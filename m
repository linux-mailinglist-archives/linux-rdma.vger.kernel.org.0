Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E87621D1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGYSzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYSzT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 14:55:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF2121;
        Tue, 25 Jul 2023 11:55:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so4743451f8f.3;
        Tue, 25 Jul 2023 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690311317; x=1690916117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ID2THAA/NbYE8R23svw1NZ1DXmlvllOYuUgG/DSAang=;
        b=NpAdRJOK/nGc08rBOaPSeoHJDewfhcQojxFbtmtWPu8I7vOcjH7UoUsxIZzImb1M8f
         hkZH/X6LIPi31fqxN/mBxBAQ+SkMx64bYGoorbyJa2KrST8IM9bWb6ORrg/hBLuj7Fhr
         kdhgH/mrMJsuFnsDylrN9t44TvOa26zB9qT+7Q6+dDQC+UoA+pxr8nqNfZXIKhxPS7/S
         /66tWLyeLceML5d77m7XqXWJIxSpUlZZrA0kp1zZ1U0t65LrTRAi6tJ9qXqkAr8TU/8J
         fdzBO5jtBcBqAm3eWrduuDsowJQ7a0VoMhUmLMK/Deue2Lb184rQAH+sR6HXy7laSy9+
         PHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690311317; x=1690916117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ID2THAA/NbYE8R23svw1NZ1DXmlvllOYuUgG/DSAang=;
        b=FlKpv/ofvC6y5c6WhfmVC0RCmLCWyh7/+ApEosOd0feQJHLMWzlns0ptmSMib4YVQ7
         niLtCbtyAYKfW0aIIdOgWANi5Cm3AzDUPxDYnhZ/f0EHXDUv9BxRLMo6DDGFMLnK5nxe
         fWgn8wNlEmaWXPLUOnVFuziwcAak+j3/Y+HT/90wAn/3kS3YS7TOypkEgNBYV3NDAKGw
         OdWy+ykxc68yQV/451CnKDFz6DBUttTFXKgAp8zvSuOy/nee2NLjDvGTehrAogSig25J
         S8cbvOnJgKqSZT/D40OGdwoO86ymz+nNghreiPhhgZvlUgf5kOuVdgOzCJA5od/Nmapg
         G3FQ==
X-Gm-Message-State: ABy/qLa2Xp4PxWLdMi4Fmb3kEEKeefVEf/ExFrMzwF/cKjft9eKYprUJ
        c96wsffIz9AN8yH25XhaV4Q=
X-Google-Smtp-Source: APBJJlF82vcbC5ug+0jWh48cqy9JDEpPZbebIZMd5AVDHKJVeKNzpC3uDB46oI5jR19N7ydWpjcumw==
X-Received: by 2002:a5d:6783:0:b0:316:f25f:eb4 with SMTP id v3-20020a5d6783000000b00316f25f0eb4mr8544897wru.60.1690311316599;
        Tue, 25 Jul 2023 11:55:16 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id v5-20020adfebc5000000b0031417b0d338sm17268946wrn.87.2023.07.25.11.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:55:16 -0700 (PDT)
Message-ID: <f0190c1c-3b2c-ed8d-b0e6-8176f756630a@gmail.com>
Date:   Tue, 25 Jul 2023 21:55:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Tariq Toukan <tariqt@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25/07/2023 8:39, Dan Carpenter wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Not a bug.  Targetting net-next.
> 
>   drivers/net/ethernet/mellanox/mlx4/mcg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mcg.c b/drivers/net/ethernet/mellanox/mlx4/mcg.c
> index f1716a83a4d3..24d0c7c46878 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
> @@ -294,7 +294,7 @@ static bool check_duplicate_entry(struct mlx4_dev *dev, u8 port,
>   	struct mlx4_promisc_qp *dqp, *tmp_dqp;
>   
>   	if (port < 1 || port > dev->caps.num_ports)
> -		return NULL;
> +		return false;
>   
>   	s_steer = &mlx4_priv(dev)->steer[port - 1];
>   
> @@ -375,7 +375,7 @@ static bool can_remove_steering_entry(struct mlx4_dev *dev, u8 port,
>   	bool ret = false;
>   
>   	if (port < 1 || port > dev->caps.num_ports)
> -		return NULL;
> +		return false;
>   
>   	s_steer = &mlx4_priv(dev)->steer[port - 1];
>   

Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
