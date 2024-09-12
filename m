Return-Path: <linux-rdma+bounces-4927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B1976E5F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641E51F216E8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64113B586;
	Thu, 12 Sep 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="IBqgYdhP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D44AEF4;
	Thu, 12 Sep 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157049; cv=none; b=lTdO4dGny6qoRILF4G+BV31czwNEfwSNRb538PUVpoifLxW1YEqlAHSBxyASULBFpOf/a/nK+dFlpHDBXY6D7S0Ua+29APjzG3lSW6rBMEJch9YUo7nbqL7D+F9ynmBISX+XBSHZiow9DWzQftPFq9c0RJ5bsxwwrjwRo7KOesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157049; c=relaxed/simple;
	bh=wsDv/arzCurRGG01CnlJKHW8usTiuaP12/HqZwORRYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZR8r1vgj6KaUi8ei59Is02KCsjeKnHvPQFwd7wSEQvSC1gWPLRABnkaZ9Lv5osqnESQM31lY4B7GCh3ywYoFb+N/wPF13k13rSclY1UTcHpa1zJ/kmqHV117dpDC4I1tS2VMcxk3H0xBaIs3tl5xML3EiJX4jN6uiPlwu5NfEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=IBqgYdhP; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48CG3YP5005529
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 18:03:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726157019; bh=LB5PI2X1hzWTYFdIScuV1AnGwjQxdobearLktnQZJbQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=IBqgYdhPTW43M0+KGOJgEdFmBSNsmKpa4QZQ6NWHqLArVPJHynNn7OwL79ioqUn9S
	 ChFMDQ/pikgXbYgfvlO01PQaZouMYxB3Jsty7XnEYOyyeur3jTBRHmfPhNbM7bdwFC
	 aWvLo+qmu+75keuoduOu9ZrBAr0stKXiz+NYpie8=
Message-ID: <f8ebfe69-d169-4e97-9191-4fb06db3a9fc@ans.pl>
Date: Thu, 12 Sep 2024 09:03:33 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of
 0xFF60 magic value
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
References: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>
Content-Language: en-US
In-Reply-To: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.09.2024 at 23:40, Krzysztof Olędzki wrote:
> Use MLX4_ATTR_CABLE_INFO instead of 0xFF60 magic value.
> 
> Also, remove MLX4_ATTR_EXTENDED_PORT_INFO which should have been done in
> commit 8154c07fe14e ("mlx4_core: Get rid of redundant ext_port_cap flags").

Turns out this is not true, as it is still used in ib_link_query_port() from drivers/infiniband/hw/mlx4/main.c

Will wait for other comments and then send v2, for consistency how about I'll move cpu_to_be16() into that function?

> 
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>  drivers/net/ethernet/mellanox/mlx4/port.c | 8 ++++----
>  include/linux/mlx4/device.h               | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
> index 6dbd505e7f30..1ebd459d1d21 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
> @@ -2052,7 +2052,7 @@ static int mlx4_get_module_id(struct mlx4_dev *dev, u8 port, u8 *module_id)
>  	inmad->class_version = 0x1;
>  	inmad->mgmt_class = 0x1;
>  	inmad->base_version = 0x1;
> -	inmad->attr_id = cpu_to_be16(0xFF60); /* Module Info */
> +	inmad->attr_id = cpu_to_be16(MLX4_ATTR_CABLE_INFO);
>  
>  	cable_info = (struct mlx4_cable_info *)inmad->data;
>  	cable_info->dev_mem_address = 0;
> @@ -2071,7 +2071,7 @@ static int mlx4_get_module_id(struct mlx4_dev *dev, u8 port, u8 *module_id)
>  		ret = be16_to_cpu(outmad->status);
>  		mlx4_warn(dev,
>  			  "MLX4_CMD_MAD_IFC Get Module ID attr(%x) port(%d) i2c_addr(%x) offset(%d) size(%d): Response Mad Status(%x) - %s\n",
> -			  0xFF60, port, I2C_ADDR_LOW, 0, 1, ret,
> +			  MLX4_ATTR_CABLE_INFO, port, I2C_ADDR_LOW, 0, 1, ret,
>  			  cable_info_mad_err_str(ret));
>  		ret = -ret;
>  		goto out;
> @@ -2170,7 +2170,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>  	inmad->class_version = 0x1;
>  	inmad->mgmt_class = 0x1;
>  	inmad->base_version = 0x1;
> -	inmad->attr_id = cpu_to_be16(0xFF60); /* Module Info */
> +	inmad->attr_id = cpu_to_be16(MLX4_ATTR_CABLE_INFO);
>  
>  	if (offset < I2C_PAGE_SIZE && offset + size > I2C_PAGE_SIZE)
>  		/* Cross pages reads are not allowed
> @@ -2195,7 +2195,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>  		ret = be16_to_cpu(outmad->status);
>  		mlx4_warn(dev,
>  			  "MLX4_CMD_MAD_IFC Get Module info attr(%x) port(%d) i2c_addr(%x) offset(%d) size(%d): Response Mad Status(%x) - %s\n",
> -			  0xFF60, port, i2c_addr, offset, size,
> +			  MLX4_ATTR_CABLE_INFO, port, i2c_addr, offset, size,
>  			  ret, cable_info_mad_err_str(ret));
>  
>  		if (i2c_addr == I2C_ADDR_HIGH &&
> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
> index a75bfb2a4438..4f2ff466b459 100644
> --- a/include/linux/mlx4/device.h
> +++ b/include/linux/mlx4/device.h
> @@ -265,7 +265,7 @@ enum {
>  };
>  
>  
> -#define MLX4_ATTR_EXTENDED_PORT_INFO	cpu_to_be16(0xff90)
> +#define MLX4_ATTR_CABLE_INFO		0xff60
>  
>  enum {
>  	MLX4_BMME_FLAG_WIN_TYPE_2B	= 1 <<  1,


