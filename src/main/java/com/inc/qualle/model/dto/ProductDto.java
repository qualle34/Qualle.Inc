package com.inc.qualle.model.dto;

import com.inc.qualle.model.entity.ProductType;
import lombok.*;

import java.util.Collection;
import java.util.Set;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {

    private long id;
    private String title;
    private String description;
    private double price;
    private ProductType type;
    private DeveloperDto developer;
    private CategoryDto category;
    private GenreDto genre;
    private ImageDto image;
    private MetadataDto metadata;
    private Collection<ReviewDto> reviews;
}
