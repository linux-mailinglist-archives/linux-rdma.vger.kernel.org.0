Return-Path: <linux-rdma+bounces-14014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B400C01179
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E12B7561432
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3FD313543;
	Thu, 23 Oct 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bXcf3T1R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B5313523
	for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221909; cv=none; b=GY3sGJ1bCAlzk/SrE4yfGz9YrX2KqzwTJ2b4LeQfg1O+947Uwgh2cf2vZfintFlq/vkbhUAx9HQBv4T0sFHf1czZr7duSbK9Yy9EDWR+99BgE9EfRKeJ/jqDIADH016hS4p7AgHi14oIj/zDM8sX1Y76TRSJclqphMOCWH+OR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221909; c=relaxed/simple;
	bh=Iyk8BQ1Be4NI135CLWJIcY8wteD6EX2fK1i012jg9No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV4Eqz+5TZDnrAVETLlS8nSXV4BD6H6Ib+WpmNbIHFdZd9axBqoHEgNwmL6VIQ5PPk3nNfSheiMCEbFz2mTeFIyb7gXuH9/U+vao4zcH/GlIasuk27Xmql4HF137jQi4PVlkCs1rqCLckJC8n5+9i8vHZu5PBuNeLN0L3mqf3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bXcf3T1R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471075c0a18so8383895e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761221902; x=1761826702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OAEkvBognBReklFZ/Tv+qPVxV3jDo2zgXc2ZXgPE3Q=;
        b=bXcf3T1RUpvNb94hMplEqdz/ba6LHeJFNaw2HakzxnVzsKduXV7ON9TVMpzKfK5oF0
         dBxwLMR3ndmF1G99nwd1a9FEkrIB/Aq4gRP34RPCBn1eAfnEyyT3jN7beia/Zrb4hQxS
         SetNDXJNIHUe/JOv9oqV/8KDlYRuNsXjYCMALmaQ8PGwkDqzABTlc4R3Ot9KfjdfReD0
         OC+2SzbHRQbeWB8CCCudO3mLbs27iXjcDzkQghUqmv7TVABPLRqN2OICpT6YEANiRITm
         z+pvC6tYWTHXajMN03JjmLb8Fqsu8dirpXUFBH4DUGZNhIcsr1PPzjWwQWQ1eU1QS7B2
         4zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221902; x=1761826702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OAEkvBognBReklFZ/Tv+qPVxV3jDo2zgXc2ZXgPE3Q=;
        b=Dlsx4X+6W/YHYM7TqURKYHEibidrM372H5gIyLaz63rDadQy67LDoW4IPSGu0+xGOx
         2Yum5/LyPYHAp6Djkpm6PcIZHzhLGIssrBDhRHcVGNTQtr6oDkgp1ZFVjj0idPYz0Cjs
         VGyVBdlDRGPAyRdYTrWjg27Auhz69IZ4O6QOwLH915tWEBWoA49HXqfp/kSd79S/XRVD
         TVbkLqJN/Wl5108E/HTogZQoRyyLG5MiCNVGh23S15SxtY5xwvpJLVAYq1KYSzZCaGLm
         dx1FtOmH0cEQUhBvWklcAiyd6hzRqoOq04I2H7/EYJwslL9JYiSc9SPCbWX0VdUwF1Ov
         MXMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+vasJlD1I+x8ZEd/6Kej9W98BxrQ9xnRBO/2NRJGX7/dt8HFy1oCHvB8Rt+vxEl1F9P31L9XrNyCv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzih62HclOzWODpQJTM72f7YpZFNm9c0CxLmxtY2kovSN3XX7hc
	yrBBvhLM1II3XdLWet560dS4ZVG7M/FIeSIgjJ5qJxMbq+MMrMttNrlu7zXxbjMXFH8=
X-Gm-Gg: ASbGncuxPUSpufRbRfHgqx8OFFz7ge417YMHTdSWMaQIeIQm5rtDDusPuhz/kIHXM3o
	Ui69v+oSa+3bg4sYaWz2qiDXO9kY3c0WYYYVCvKYjadhFw7ZiC1lOlMyzKghxSgxAH1rmtCFy6e
	O2g7bFvRZQsYb3Sn2eL0TDCV6acckUi8YrR1d8vYi0w9BPp6b54Sj1qy5XeNOyq/8Xl9KO7DzAf
	3CuStvmNYwYHQb8XFpvxU2Umuiu/Ct5Acxa/ufs5WRnRdd+umdoAMQKsgIA5XKRb+rKj1SjOrLV
	MkWbIobZJW/u/f+5bNY1JqyVczVxAA5bx+eP6NdFcoFjwYbnXAWcQPBtG8AUHeN/JJ23JEPGLZW
	/JDyvxQyqpYfbieuBktCmSQ6hyKwBG4/aBdugTHxPmQPj4vfVFhWGkwMuSJdiNJWyhWjwKC6Y6N
	xBaMj2Gn2EExC1LwYaj3GvPUVOJ9s=
X-Google-Smtp-Source: AGHT+IEckDVpnjM+kF+Enrq8ICxQxXSWGQCvGZHBJMVHKPscv1KDy1zMbOMdSWmaiGYkQEbQx1nj8w==
X-Received: by 2002:a05:600c:3492:b0:46e:45d3:82fd with SMTP id 5b1f17b1804b1-47117917267mr174487365e9.31.1761221902341;
        Thu, 23 Oct 2025 05:18:22 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm61138975e9.1.2025.10.23.05.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:18:21 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:18:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022190932.1073898-1-daniel.zahka@gmail.com>

Wed, Oct 22, 2025 at 09:09:31PM +0200, daniel.zahka@gmail.com wrote:
>swp_l4_csum_mode controls how L4 transmit checksums are computed when
>using Software Parser (SWP) hints for header locations.
>
>Supported values:
>  1. device_default: use device default setting.

Is this different between devices/fw_versions?


>  2. full_csum: calculate L4 checksum with the psuedo-header.
>  3. l4_only: calculate L4 checksum without the psuedo-header. Only

s/psuedo/pseudo/


>     available when swp_l4_csum_mode_l4_only is set in
>     mlx5_ifc_nv_sw_offload_cap_bits.
>
>The l4_only setting is a dependency for PSP initialization in
>mlx5e_psp_init().
>
>Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>---
> Documentation/networking/devlink/mlx5.rst     |   9 ++
> .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
> .../mellanox/mlx5/core/lib/nv_param.c         | 148 ++++++++++++++++++
> 3 files changed, 159 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>index 0e5f9c76e514..f366e551b2f7 100644
>--- a/Documentation/networking/devlink/mlx5.rst
>+++ b/Documentation/networking/devlink/mlx5.rst
>@@ -218,6 +218,15 @@ parameters.
>        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
>        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
> 
>+    * - ``swp_l4_csum_mode``
>+      - string
>+      - permanent
>+      - Configure how the L4 checksum is calculated by the device when using
>+        Software Parser (SWP) hints for header locations.
>+        * ``device_default`` : Use the device's default checksum calculation mode
>+        * ``full_csum`` : Calculate full checksum including the pseudo-header
>+        * ``l4_only`` : Calculate L4-only checksum, excluding the pseudo-header
>+
> The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
> 
> Info versions
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
>index c9555119a661..43b9bf8829cf 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
>@@ -26,7 +26,8 @@ enum mlx5_devlink_param_id {
> 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
> 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
> 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
>-	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
>+	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
>+	MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
> };
> 
> struct mlx5_trap_ctx {
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>index 459a0b4d08e6..fac3d9801b3b 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>@@ -8,6 +8,8 @@ enum {
> 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
> 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
> 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
>+	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CAP                = 0x10b,
>+	MLX5_CLASS_0_CTRL_ID_NV_SW_ACCELERATE_CONF            = 0x11d,
> 
> 	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
> };
>@@ -123,6 +125,17 @@ struct mlx5_ifc_nv_sw_offload_conf_bits {
> 	u8         lro_log_timeout0[0x4];
> };
> 
>+struct mlx5_ifc_nv_sw_offload_cap_bits {
>+	u8         reserved_at_0[0x19];
>+	u8         swp_l4_csum_mode_l4_only[0x1];
>+	u8         reserved_at_1a[0x6];
>+};
>+
>+struct mlx5_ifc_nv_sw_accelerate_conf_bits {
>+	u8         swp_l4_csum_mode[0x2];
>+	u8         reserved_at_2[0x3e];
>+};
>+
> #define MNVDA_HDR_SZ \
> 	(MLX5_ST_SZ_BYTES(mnvda_reg) - \
> 	 MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
>@@ -195,9 +208,42 @@ mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
> 	return mlx5_nv_param_read(dev, mnvda, len);
> }
> 
>+static int
>+mlx5_nv_param_read_sw_offload_cap(struct mlx5_core_dev *dev, void *mnvda,
>+				  size_t len)
>+{
>+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
>+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
>+			       MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CAP);
>+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_offload_cap);
>+
>+	return mlx5_nv_param_read(dev, mnvda, len);
>+}
>+
>+static int
>+mlx5_nv_param_read_sw_accelerate_conf(struct mlx5_core_dev *dev, void *mnvda,
>+				      size_t len)
>+{
>+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
>+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
>+			       MLX5_CLASS_0_CTRL_ID_NV_SW_ACCELERATE_CONF);
>+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_accelerate_conf);
>+
>+	return mlx5_nv_param_read(dev, mnvda, len);
>+}
>+
> static const char *const
> 	cqe_compress_str[] = { "balanced", "aggressive" };
> 
>+enum swp_l4_csum_mode {
>+	SWP_L4_CSUM_MODE_DEVICE_DEFAULT = 0,
>+	SWP_L4_CSUM_MODE_FULL_CSUM = 1,
>+	SWP_L4_CSUM_MODE_L4_ONLY = 2,
>+};
>+
>+static const char *const
>+	swp_l4_csum_mode_str[] = { "device_default", "full_csum", "l4_only" };
>+
> static int
> mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
> 				       struct devlink_param_gset_ctx *ctx)
>@@ -268,6 +314,102 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
> 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> }
> 
>+static int
>+mlx5_nv_param_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
>+					   struct devlink_param_gset_ctx *ctx)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	u8 value = U8_MAX;
>+	void *data;
>+	int err;
>+
>+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
>+	if (err)
>+		return err;
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	value = MLX5_GET(nv_sw_accelerate_conf, data, swp_l4_csum_mode);
>+
>+	if (value >= ARRAY_SIZE(swp_l4_csum_mode_str))
>+		return -EOPNOTSUPP;

Einval? I think this is another argument for introduction of extack for
param getters. Care to add it?


>+
>+	strscpy(ctx->val.vstr, swp_l4_csum_mode_str[value],
>+		sizeof(ctx->val.vstr));
>+	return 0;
>+}
>+
>+static int
>+mlx5_nv_param_devlink_swp_l4_csum_mode_validate(struct devlink *devlink, u32 id,
>+						union devlink_param_value val,
>+						struct netlink_ext_ack *extack)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 cap[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	void *data;
>+	int err, i;
>+
>+	for (i = 0; i < ARRAY_SIZE(swp_l4_csum_mode_str); i++) {
>+		if (!strcmp(val.vstr, swp_l4_csum_mode_str[i]))
>+			break;
>+	}
>+
>+	if (i >= ARRAY_SIZE(swp_l4_csum_mode_str)) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Invalid value, supported values are device_default/full_csum/l4_only");
>+		return -EINVAL;
>+	}
>+
>+	if (i == SWP_L4_CSUM_MODE_L4_ONLY) {
>+		err = mlx5_nv_param_read_sw_offload_cap(dev, cap, sizeof(cap));
>+		if (err) {
>+			NL_SET_ERR_MSG_MOD(extack,
>+					   "Failed to read sw_offload_cap");
>+			return err;
>+		}
>+
>+		data = MLX5_ADDR_OF(mnvda_reg, cap, configuration_item_data);
>+		if (!MLX5_GET(nv_sw_offload_cap, data, swp_l4_csum_mode_l4_only)) {
>+			NL_SET_ERR_MSG_MOD(extack,
>+					   "l4_only mode is not supported on this device");
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
>+static int
>+mlx5_nv_param_devlink_swp_l4_csum_mode_set(struct devlink *devlink, u32 id,
>+					   struct devlink_param_gset_ctx *ctx,
>+					   struct netlink_ext_ack *extack)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	void *data;
>+	u8 value;
>+	int err;
>+
>+	if (!strcmp(ctx->val.vstr, "device_default"))
>+		value = SWP_L4_CSUM_MODE_DEVICE_DEFAULT;
>+	else if (!strcmp(ctx->val.vstr, "full_csum"))
>+		value = SWP_L4_CSUM_MODE_FULL_CSUM;
>+	else
>+		value = SWP_L4_CSUM_MODE_L4_ONLY;
>+
>+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Failed to read sw_accelerate_conf mnvda reg");
>+		return err;
>+	}
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	MLX5_SET(nv_sw_accelerate_conf, data, swp_l4_csum_mode, value);
>+
>+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>+}
>+
> static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
> 					      void *mnvda, size_t len)
> {
>@@ -545,6 +687,12 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
> 			     mlx5_nv_param_devlink_cqe_compress_get,
> 			     mlx5_nv_param_devlink_cqe_compress_set,
> 			     mlx5_nv_param_devlink_cqe_compress_validate),
>+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,

Why this is driver specific? Isn't this something other drivers might
eventually implement as well?


>+			     "swp_l4_csum_mode", DEVLINK_PARAM_TYPE_STRING,
>+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>+			     mlx5_nv_param_devlink_swp_l4_csum_mode_get,
>+			     mlx5_nv_param_devlink_swp_l4_csum_mode_set,
>+			     mlx5_nv_param_devlink_swp_l4_csum_mode_validate),
> };
> 
> int mlx5_nv_param_register_dl_params(struct devlink *devlink)
>-- 
>2.47.3
>

