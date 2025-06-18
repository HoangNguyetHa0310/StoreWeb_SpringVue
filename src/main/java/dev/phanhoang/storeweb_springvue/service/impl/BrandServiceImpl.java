package dev.phanhoang.storeweb_springvue.service.impl;

import dev.phanhoang.storeweb_springvue.dto.BrandDTO;
import dev.phanhoang.storeweb_springvue.entity.Brand;
import dev.phanhoang.storeweb_springvue.repository.BrandRepository;
import dev.phanhoang.storeweb_springvue.service.BrandService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BrandServiceImpl implements BrandService {

    private final BrandRepository brandRepository;
    private final ModelMapper modelMapper;

    @Override
    public List<BrandDTO> getAllBrands() {
        return brandRepository.findAll()
                .stream()
                .map(brand -> modelMapper.map(brand, BrandDTO.class))
                .collect(Collectors.toList());
    }
}
