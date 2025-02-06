Return-Path: <linux-rdma+bounces-7475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81677A2A24B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D71162944
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5693224AF6;
	Thu,  6 Feb 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQt5xEzI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DD2E64A;
	Thu,  6 Feb 2025 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826751; cv=none; b=W85zZjv/Chu7CcqsUi37pL/aeO18ALM5UYnQomnaXLoqRzUpY7mCy6hVqOq9h4SovyDhgUFbRL8hgnqY5RtDZfhkC5eq89t1GddOzDCz0CvBOcy8t/lct80+lIqJcsGmJodk1zaChIxfZ3RtiGvcN+Ptjt0/0jCjMDxbbfV6kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826751; c=relaxed/simple;
	bh=8EAGBqr/MIkuUASK7TFbf1Jri+T0dnJy3gwSyrQniJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAWLA2avODt4lBJpiOSd7U5CMPZ+KZANGkU/m4czvfzPPqPo5NVsMa4nfYLtlVmhgM+llkpUZ9IKxKval7hNp96r2mkQPoTaPAxzf4pnwmM/9ToNy7Uk5vKCfj2ThFxSrbZB+0LGTdcXN+rLfj8bVObMc3k78EOWnRKeOkGFKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQt5xEzI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so85548966b.3;
        Wed, 05 Feb 2025 23:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738826747; x=1739431547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cg9Khwyhq95pFbex1Z5wYjxfR3pQRmUQz+ucT3SRC/M=;
        b=KQt5xEzIG0Fg55qxAGTK9t2A5rYdK8YjQayAOU9xGz2ld1Y4yhcpKssO1qwM+Vb21b
         I9kL1R2ofcHeP5xjfXrLKrJ9lNUdJGawb1y6YeF0mfx7Uve5ML2yiX/+Yib01ekkzDY7
         yi4TYFvktWoEmsmBKeBvW9811yr5L4kpRVxaYZ2+SN38F/EDO7uFNYmAgpPrVVmAhMwc
         jSpSLVl2Y+SEDgxx3n33dEtDi0tOXUcvAvuwd4fQ5rrigMmzPfOOAR0F5tc37cW8WCo5
         LWKhMIB/H3vU+uagjWB+0guvgVSECz4hCq9eXy0aIqjmhyUYGMLnU2qUtn+upOzevKVS
         YW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826747; x=1739431547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg9Khwyhq95pFbex1Z5wYjxfR3pQRmUQz+ucT3SRC/M=;
        b=kT+fNXi2Wrsd06GwBH7myYNKMy2IctGdogqmKN9cyfYxxNhpTke+FdFjq+SFzOmMa3
         4n1TADOvqOSZIWmwWr1DugBEqaqKkRMMj3/FsBvnvjq6psEuFx7e+id89rI/NqYXax+v
         8AieaPJ0xeGqeDMVnGRr4Sc68VQQyL0DODJADsDqWYrfpQnF8WMmNPGLzH86PzXsZSsw
         KXKrlWXT+txgw2bKHAPlqdn/mvfErh5CeOdKLQPn57TpGolO7jj5TQ5VORJe1bOkENOk
         J4ZV9CRG+jeS0NLaoBCNKy8v83oHIlH5fSUlulL8wHh8pAI2GJpFvoUKM2qNem1n202J
         NN5g==
X-Forwarded-Encrypted: i=1; AJvYcCV/wYpzVmoizzK9LGa26vDk6u4hEWc8o2Y4Rkot8ZXRvNhG0CuUJTgXRCnzyeWRK2PR2EvvQByVP1y8D8lO2oI=@vger.kernel.org, AJvYcCWeGD/M/R1ZHcJ/xgxng1NTUlTs8rALqPlMIjtUMYoRXADdCharONezwcCEorwvd1an86ysw8Fp4fIDpQ5K@vger.kernel.org, AJvYcCX1OlW47nDafHp8oxBB1oVyIgAyxLZJQ32T3pPAaUSbolCl9dqQWHmGW/oJF9qgrWL5h7S3d3HGsC7xig==@vger.kernel.org
X-Gm-Message-State: AOJu0YybbhTThKRQojMgzR0vd/Eb4jyGR6boNOZViUNumtVtUTi2Vds0
	m8YB+hEtIoEYPC94kk4AhRR1VFzEkn6Kfq9dORM1/S1hVBpY22TS
X-Gm-Gg: ASbGncsn+bxZ6gEaJtmpPHqO090Oouh6cG3L7HVHM72yR/HcAJFlww3Q3N6h0Nkgb+5
	N1dGOBz6vWHvBN1LfndgySzGFT/QUsBTaJaiMxV7CldqkQS1pqIgRIhyxuilt3J4W1zJtoaL1MM
	DMOK3A6Al5kTrudn4PXKGpyzIdakhwqG1BEfYqhRrvZIET+16H50Gwc2zkDATkI/W+XsU4vGUkI
	0S1YI0kW2y350OB1iPthIBvNqRP21XXTpJU6LuoNu8jqFyUVOJl05RcFfFGdblGNFq6GzFkm0bU
	JWZ0o2iO4R8JcifeF+QQVm5kaygHcpLzK44=
X-Google-Smtp-Source: AGHT+IGsrtDuXD6FXW9urLfcwyk1il0KZcJ6c8Ns7Z7OqFGR1g/roqfZ7ur1jL2SHk6wK1fAtKXwVg==
X-Received: by 2002:a17:907:9724:b0:ab7:ac0:24ea with SMTP id a640c23a62f3a-ab75e21e2dcmr523807766b.3.1738826746859;
        Wed, 05 Feb 2025 23:25:46 -0800 (PST)
Received: from [172.27.34.32] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772fd6ba1sm53678266b.79.2025.02.05.23.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:25:46 -0800 (PST)
Message-ID: <8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
Date: Thu, 6 Feb 2025 09:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/02/2025 6:37, Gustavo A. R. Silva wrote:
> Hi,
> 
> On 04/02/25 13:27, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of other structs, we use the `struct_group_tagged()` helper
>> to create a new tagged `struct mlx5e_umr_wqe_hdr`. This structure
>> groups together all the members of the flexible `struct mlx5e_umr_wqe`
>> except the flexible array.
>>
>> As a result, the array is effectively separated from the rest of the
>> members without modifying the memory layout of the flexible structure.
>> We then change the type of the middle struct member currently causing
>> trouble from `struct mlx5e_umr_wqe` to `struct mlx5e_umr_wqe_hdr`.
>>
>> We also want to ensure that when new members need to be added to the
>> flexible structure, they are always included within the newly created
>> tagged struct. For this, we use `static_assert()`. This ensures that the
>> memory layout for both the flexible structure and the new tagged struct
>> is the same after any changes.
>>
>> This approach avoids having to implement `struct mlx5e_umr_wqe_hdr` as
>> a completely separate structure, thus preventing having to maintain two
>> independent but basically identical structures, closing the door to
>> potential bugs in the future.
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure, through which we can access the flexible-array
>> member, if necessary.
>>
>> So, with these changes, fix 124 of the following warnings:
>>
>> drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: 
>> structure containing a flexible array member is not at the end of 
>> another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en.h      | 13 +++++++++----
>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  4 +++-
>>   2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/ 
>> net/ethernet/mellanox/mlx5/core/en.h
>> index 979fc56205e1..c30c64eb346f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> @@ -233,15 +233,20 @@ struct mlx5e_rx_wqe_cyc {
>>   };
>>   struct mlx5e_umr_wqe {
>> -    struct mlx5_wqe_ctrl_seg       ctrl;
>> -    struct mlx5_wqe_umr_ctrl_seg   uctrl;
>> -    struct mlx5_mkey_seg           mkc;
>> +    /* New members MUST be added within the struct_group() macro 
>> below. */
>> +    struct_group_tagged(mlx5e_umr_wqe_hdr, hdr,
>> +        struct mlx5_wqe_ctrl_seg       ctrl;
>> +        struct mlx5_wqe_umr_ctrl_seg   uctrl;
>> +        struct mlx5_mkey_seg           mkc;
>> +    );
>>       union {
>>           DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
>>           DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
>>           DECLARE_FLEX_ARRAY(struct mlx5_ksm, inline_ksms);
>>       };
>>   };
>> +static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == 
>> sizeof(struct mlx5e_umr_wqe_hdr),
>> +          "struct member likely outside of struct_group_tagged()");
>>   enum mlx5e_priv_flag {
>>       MLX5E_PFLAG_RX_CQE_BASED_MODER,
>> @@ -660,7 +665,7 @@ struct mlx5e_rq {
>>           } wqe;
>>           struct {
>>               struct mlx5_wq_ll      wq;
>> -            struct mlx5e_umr_wqe   umr_wqe;
>> +            struct mlx5e_umr_wqe_hdr umr_wqe;
>>               struct mlx5e_mpw_info *info;
>>               mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
>>               __be32                 umr_mkey_be;
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index bd41b75d246e..4ff4ff2342cf 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -373,6 +373,8 @@ static void mlx5e_rq_shampo_hd_info_free(struct 
>> mlx5e_rq *rq)
>>   static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
>>   {
>> +    struct mlx5e_umr_wqe *umr_wqe =
>> +        container_of(&rq->mpwqe.umr_wqe, struct mlx5e_umr_wqe, hdr);
>>       int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
>>       size_t alloc_size;
>> @@ -393,7 +395,7 @@ static int mlx5e_rq_alloc_mpwqe_info(struct 
>> mlx5e_rq *rq, int node)
>>           bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>>       }
>> -    mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
>> +    mlx5e_build_umr_wqe(rq, rq->icosq, umr_wqe);
>>       return 0;
>>   }
> 
> Here is another alternative for this.  And similarly to the 
> struct_group_tagged()
> change above, no struct members should be added before or after `struct
> mlx5e_umr_wqe_hdr hdr;` in `struct mlx5e_umr_wqe`:
> 

Thanks for your patch.

The change with the struct_group_tagged() uses advanced tag, and keeps 
code cleaner.
I prefer it.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Regards,
Tariq

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ 
> ethernet/mellanox/mlx5/core/en.h
> index 979fc56205e1..912b97eeb4d6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -232,10 +232,13 @@ struct mlx5e_rx_wqe_cyc {
>          DECLARE_FLEX_ARRAY(struct mlx5_wqe_data_seg, data);
>   };
> 
> -struct mlx5e_umr_wqe {
> +struct mlx5e_umr_wqe_hdr {
>          struct mlx5_wqe_ctrl_seg       ctrl;
>          struct mlx5_wqe_umr_ctrl_seg   uctrl;
>          struct mlx5_mkey_seg           mkc;
> +};
> +struct mlx5e_umr_wqe {
> +       struct mlx5e_umr_wqe_hdr hdr;
>          union {
>                  DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
>                  DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
> @@ -660,7 +663,7 @@ struct mlx5e_rq {
>                  } wqe;
>                  struct {
>                          struct mlx5_wq_ll      wq;
> -                       struct mlx5e_umr_wqe   umr_wqe;
> +                       struct mlx5e_umr_wqe_hdr umr_wqe;
>                          struct mlx5e_mpw_info *info;
>                          mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
>                          __be32                 umr_mkey_be;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/ 
> drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> index 1b7132fa70de..2b05536d564a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> @@ -123,7 +123,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, 
> u16 ix)
>          bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>          wi->consumed_strides = 0;
> 
> -       umr_wqe->ctrl.opmod_idx_opcode =
> +       umr_wqe->hdr.ctrl.opmod_idx_opcode =
>                  cpu_to_be32((icosq->pc << 
> MLX5_WQE_CTRL_WQE_INDEX_SHIFT) | MLX5_OPCODE_UMR);
> 
>          /* Optimized for speed: keep in sync with 
> mlx5e_mpwrq_umr_entry_size. */
> @@ -134,7 +134,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, 
> u16 ix)
>                  offset = offset * sizeof(struct mlx5_klm) * 2 / 
> MLX5_OCTWORD;
>          else if (unlikely(rq->mpwqe.umr_mode == 
> MLX5E_MPWRQ_UMR_MODE_TRIPLE))
>                  offset = offset * sizeof(struct mlx5_ksm) * 4 / 
> MLX5_OCTWORD;
> -       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
> +       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
> 
>          icosq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
>                  .wqe_type = MLX5E_ICOSQ_WQE_UMR_RX,
> @@ -144,7 +144,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, 
> u16 ix)
> 
>          icosq->pc += rq->mpwqe.umr_wqebbs;
> 
> -       icosq->doorbell_cseg = &umr_wqe->ctrl;
> +       icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
> 
>          return 0;
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/ 
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index a814b63ed97e..bbd0b888d237 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -311,8 +311,8 @@ static inline void mlx5e_build_umr_wqe(struct 
> mlx5e_rq *rq,
>                                         struct mlx5e_icosq *sq,
>                                         struct mlx5e_umr_wqe *wqe)
>   {
> -       struct mlx5_wqe_ctrl_seg      *cseg = &wqe->ctrl;
> -       struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
> +       struct mlx5_wqe_ctrl_seg      *cseg = &wqe->hdr.ctrl;
> +       struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->hdr.uctrl;
>          u16 octowords;
>          u8 ds_cnt;
> 
> @@ -393,7 +393,9 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq 
> *rq, int node)
>                  bitmap_fill(wi->skip_release_bitmap, rq- 
>  >mpwqe.pages_per_wqe);
>          }
> 
> -       mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
> +       mlx5e_build_umr_wqe(rq, rq->icosq,
> +                           container_of(&rq->mpwqe.umr_wqe,
> +                                        struct mlx5e_umr_wqe, hdr));
> 
>          return 0;
>   }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ 
> net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1963bc5adb18..5fd70b4d55be 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -631,16 +631,16 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, 
> struct mlx5e_umr_wqe *umr_wqe,
>                            __be32 key, u16 offset, u16 ksm_len)
>   {
>          memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_ksms));
> -       umr_wqe->ctrl.opmod_idx_opcode =
> +       umr_wqe->hdr.ctrl.opmod_idx_opcode =
>                  cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
>                               MLX5_OPCODE_UMR);
> -       umr_wqe->ctrl.umr_mkey = key;
> -       umr_wqe->ctrl.qpn_ds = cpu_to_be32((sq->sqn << 
> MLX5_WQE_CTRL_QPN_SHIFT)
> +       umr_wqe->hdr.ctrl.umr_mkey = key;
> +       umr_wqe->hdr.ctrl.qpn_ds = cpu_to_be32((sq->sqn << 
> MLX5_WQE_CTRL_QPN_SHIFT)
>                                              | 
> MLX5E_KSM_UMR_DS_CNT(ksm_len));
> -       umr_wqe->uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | 
> MLX5_UMR_INLINE;
> -       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
> -       umr_wqe->uctrl.xlt_octowords = cpu_to_be16(ksm_len);
> -       umr_wqe->uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
> +       umr_wqe->hdr.uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | 
> MLX5_UMR_INLINE;
> +       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
> +       umr_wqe->hdr.uctrl.xlt_octowords = cpu_to_be16(ksm_len);
> +       umr_wqe->hdr.uctrl.mkey_mask     = 
> cpu_to_be64(MLX5_MKEY_MASK_FREE);
>   }
> 
>   static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct 
> mlx5e_rq *rq, int header_index)
> @@ -704,7 +704,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq 
> *rq,
> 
>          shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
>          sq->pc += wqe_bbs;
> -       sq->doorbell_cseg = &umr_wqe->ctrl;
> +       sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
> 
>          return 0;
> 
> @@ -814,12 +814,12 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq 
> *rq, u16 ix)
>          bitmap_zero(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>          wi->consumed_strides = 0;
> 
> -       umr_wqe->ctrl.opmod_idx_opcode =
> +       umr_wqe->hdr.ctrl.opmod_idx_opcode =
>                  cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
>                              MLX5_OPCODE_UMR);
> 
>          offset = (ix * rq->mpwqe.mtts_per_wqe) * sizeof(struct 
> mlx5_mtt) / MLX5_OCTWORD;
> -       umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
> +       umr_wqe->hdr.uctrl.xlt_offset = cpu_to_be16(offset);
> 
>          sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
>                  .wqe_type   = MLX5E_ICOSQ_WQE_UMR_RX,
> @@ -829,7 +829,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, 
> u16 ix)
> 
>          sq->pc += rq->mpwqe.umr_wqebbs;
> 
> -       sq->doorbell_cseg = &umr_wqe->ctrl;
> +       sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
> 
>          return 0;
> 
> 
> Thanks
> -- 
> Gustavo
> 


