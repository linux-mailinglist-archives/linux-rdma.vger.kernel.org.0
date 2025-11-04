Return-Path: <linux-rdma+bounces-14237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFDAC30704
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C183ADEB1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D93148BE;
	Tue,  4 Nov 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UK8x8Bdq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108E3128AA
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251253; cv=none; b=slgjyrKYl1HXiSgJyGJ9gfOv11kVxID0pN8s1iX8UrYpifqIyzrpuztRzDLIOUdq24oRuE3imeXvdtgI3yLYTb9FOWto7ze7BRviXVneA7YoBJZN+g8sQLqXsbGu49eM8t+OcKTzboprAEihGNIJaIxIxWqDwc0OA7dPLEXFHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251253; c=relaxed/simple;
	bh=WE9+Ktyu+xlyKowaEUzMsa22wPI8fbdShWwoSf53wJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVz7c01w33hzafB3JNcnBz/iyQwAncxu2RzIA8t4M2NJsopTEHXT7Bg6fOWG+BIjZLElwp8eSlfQob6dTSesMlyT3ZewwwgxWERIwT/FTeX/QfvqjPAHSr1l0bBmSH7uhpmHHr4CyGzHQ9CDFMj2E7VJL4fBjILJKjjwZFgtw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UK8x8Bdq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so5800725e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 04 Nov 2025 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762251248; x=1762856048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgtBbLaC1qXEwG0EBrNcX2Q2+z7cTl6b5ktmRXlbEl0=;
        b=UK8x8Bdqu7YdeT1X4Ctrj2RkUZZ/KHhF/8eImpUrSztYZljhA9XaEJ6rzB9IxgeSFw
         /MC38Ds0CvRPWECQm4aMQ0SkzZHhEdkxFXNqKemgLLXAx29mmJl5MMQYC5bRHL/rLxCo
         cMm0OxXfl3Pmarq1vOwX4AT7vfJurKBbKVAbaIBIxdvDNQKiF3f64G2+kfaA/NLS80g6
         qIuPb0osPakv6dlMDK/P/BtHKiJfcM8pg00ouyB5MtYx0oosiV/NOiK/DhUCJ++3SzSD
         WaLcZg4PEAMhHiWqOBQ/qdrT9uOOcJ66tP7Mg0+L1uEN9dyXke8HseY/MtsleIyUZcMV
         meiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251248; x=1762856048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgtBbLaC1qXEwG0EBrNcX2Q2+z7cTl6b5ktmRXlbEl0=;
        b=a6qU58t0v0Ta9VHZpML9ddHN3KQJZj+rOAISj0gM3z1dsCw83HRFYqZgU0DWUhd1UK
         NyTFUE1aJKIIxtxCSGvuZozb6ozOMHsl4zkq1r65CLICWGOlmR1vnv/uKUPjO5hS1Ja8
         4DwXurnVcx/szAXk5SViRSSKuI2l2huAXeqyE17P10SUEHHHDSAI/Z4GZ2qQ2UXta3v/
         jW0TqauK2ThXAkPytvI9Oc7AWtQ4gkAThoj3m1nFzI6BCq6Gh6XIyBV8vukPkF7FU56S
         PBZCammZLg/3+pk3v5Hux9jzS/NpdvdG9qCDKP5jM5higr2HtW0iRGmG86gMgzFg16J7
         Uyvw==
X-Forwarded-Encrypted: i=1; AJvYcCUt74d2Viy++z5YCqwUViy5CCTlbNCUAEAdpRNaFOMtb8tjOa/797TCm4OREWflnbjQ2s+8n9zZhKfp@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqPMtIFKT3g+o2loSXW7q126TylESF/s2VLnuqFQ4Q7iJLvKx
	ve4RjzKGo02Q5nOP+yyoZKT8/izaEcb9szHJlvjB0SRe2Ul7vfZRk6gN6ILgl8b9jnc=
X-Gm-Gg: ASbGncuML0GrI4Y/CJYimStO3Dkl3vIyCuY+noVH4kXcR3UxkZH8Nhdt/h4RMT5BoyM
	lmoAGbhIKni1vOCOo2dGt30entnx17Zo8NTv7J9ga+KTKSs4xhY2HA56Cz24KL19N6s6v/RdN87
	FCZpWeL7j1OUJ6SDwdm8OhEIxatFth5VxnJGfPRfyzVZ7gtjypRzjAeuBzxIVByLhOb9bWhBMwf
	paPvQ1vMNHEgLBP8VVhLafhYO5c5TXOGY1OGVvq7lOY2p7kyBQvr9smsfYr2zCq2/t0WqwZl60M
	j2isD1xqeSbBssrn2c9TaSBzsBv0anX3pelEr9zCtjkoFpZC4pMyUgzVcBKOsezqWKPnyXau3A9
	7n/CPfByED6Dg4LUoasAz7RYb4mq5W+B//9K3bXCcj4ksysZJe8gc+xNLI9G7Vim0vGH1fggtsg
	SZ3rMU7sCS
X-Google-Smtp-Source: AGHT+IFLhFW+4JqR6YGzodu6ZRf4ghsDtIxlWX1USrYQuB2vtrAyEu7aDLTWiSaN9Znd5ArYog5BpQ==
X-Received: by 2002:a05:600c:1907:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4773089c432mr139320365e9.20.1762251248291;
        Tue, 04 Nov 2025 02:14:08 -0800 (PST)
Received: from jiri-mlt ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775594e311sm14408325e9.6.2025.11.04.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:14:07 -0800 (PST)
Date: Tue, 4 Nov 2025 11:14:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103194554.3203178-3-daniel.zahka@gmail.com>

Mon, Nov 03, 2025 at 08:45:53PM +0100, daniel.zahka@gmail.com wrote:
>swp_l4_csum_mode controls how L4 transmit checksums are computed when
>using Software Parser (SWP) hints for header locations.
>
>Supported values:
>  1. device_default: use device default setting.
>  2. full_csum: calculate L4 checksum with the pseudo-header.
>  3. l4_only: calculate L4 checksum without the pseudo-header. Only
>     available when swp_l4_csum_mode_l4_only is set in
>     mlx5_ifc_nv_sw_offload_cap_bits.
>
>The l4_only setting is a dependency for PSP initialization in
>mlx5e_psp_init().
>
>Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>---
>
>Notes:
>    v2:
>    - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
>    - fix indentation issue in mlx5.rst entry
>
> Documentation/networking/devlink/mlx5.rst     |   9 +
> .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
> .../mellanox/mlx5/core/lib/nv_param.c         | 161 ++++++++++++++++++
> 3 files changed, 172 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>index 0e5f9c76e514..675b5a1ec625 100644
>--- a/Documentation/networking/devlink/mlx5.rst
>+++ b/Documentation/networking/devlink/mlx5.rst
>@@ -218,6 +218,15 @@ parameters.
>        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
>        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
> 
>+   * - ``swp_l4_csum_mode``
>+     - string
>+     - permanent
>+     - Configure how the L4 checksum is calculated by the device when using
>+       Software Parser (SWP) hints for header locations.
>+       * ``device_default`` : Use the device's default checksum calculation mode
>+       * ``full_csum`` : Calculate full checksum including the pseudo-header
>+       * ``l4_only`` : Calculate L4-only checksum, excluding the pseudo-header
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
>index 3d2195338d39..3dc5b899a5fb 100644
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
>@@ -195,6 +208,30 @@ mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
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
>@@ -269,6 +306,124 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
> 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> }
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
>+static int
>+mlx5_nv_param_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
>+					   struct devlink_param_gset_ctx *ctx,
>+					   struct netlink_ext_ack *extack)
>+{
>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>+	u8 value = U8_MAX;
>+	void *data;
>+	int err;
>+
>+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
>+	if (err) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Failed to read sw_accelerate_conf mnvda reg");
>+		return err;
>+	}
>+
>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>+	value = MLX5_GET(nv_sw_accelerate_conf, data, swp_l4_csum_mode);
>+
>+	if (value >= ARRAY_SIZE(swp_l4_csum_mode_str)) {
>+		NL_SET_ERR_MSG_FMT_MOD(extack,
>+				       "Invalid swp_l4_csum_mode value %u read from device",
>+				       value);
>+		return -EINVAL;
>+	}
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

I did some research. 0/DEVICE_DEFAULT should not be ever reported back
from FW. It's purpose is for user to reset to default FW configuration.
What's the usecase for that? I think you could just avoid
0/DEVICE_DEFAULT entirely, for both get and set.

But ff you find a need to allow user to set FW default, it should be
most likely done differently, perhaps by a new devlink command,
rather than per-param free-form string.


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
>+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>+	if (err)
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Failed to write sw_accelerate_conf mnvda reg");
>+
>+	return err;
>+}
>+
> static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
> 					      void *mnvda, size_t len)
> {
>@@ -548,6 +703,12 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
> 			     mlx5_nv_param_devlink_cqe_compress_get,
> 			     mlx5_nv_param_devlink_cqe_compress_set,
> 			     mlx5_nv_param_devlink_cqe_compress_validate),
>+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
>+			     "swp_l4_csum_mode", DEVLINK_PARAM_TYPE_STRING,

I still think that even unlikely this will be implemented in other
driver, it is generic param. Could you please treat it as such?



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

