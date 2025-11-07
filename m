Return-Path: <linux-rdma+bounces-14312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF7C419C2
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D913BAF49
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB930F948;
	Fri,  7 Nov 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DspA49r3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EEC30E859
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548235; cv=none; b=iR/80M8175Yd7gyq5lY2lcmHer84ZJ88Z982UMiyQgxKqfmBEdy+RdwW+y2nhl0jLQJceC8g+rvJkUiGkmGHEMEShW8lzyS4LmC5LtE5aRbTHNTc5dx6cb07w9DppM/cANK+XnSrgpMEyOiOHKusNByThy0kx0hkCuMz11xC7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548235; c=relaxed/simple;
	bh=QsWGhTEv5o5MmhceuHSHYM4Lx5h1hcZORNffawLbY1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8xkpABPBrcBp2TSG/zpdzeS5rDYYmMdO4EZdBcwMgdojs7KJEz9GLSzj5JgNTwmTf7IwtCsmWV1uN8Os+J1t+AoGZej4mLnwqpin3rpZ8f6Lxc7OA8veuhzI6eFFNBPbPdxwI8aggOQKTJ7sYlAckOHoXHG1uB08rXWR9FBj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DspA49r3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab6fso11613537b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548232; x=1763153032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbS6VI2bNTHm/o6rxRH2I/vNUA+a3DGv8cXb7Is3Tw=;
        b=DspA49r3tFYTrhmBNybZrF/Yd2TjNJEfnuLq6ABrJHho4uFwORzqJ24Yb3oFG1YsIL
         3BAQO1+StBAc3GoniKhaYNmz/zr+glIlBZcEdJtcj6vqx8agtuTkxG/WWXYyYXCp7g5b
         NytO6R/UwfxbHhe1ekraEZFD/HqRE/TGoz6VxMPG0QmyTf84N4JTHK6vRHFygdKd8XER
         OmK+AXgU6IpzXR/hQN+39vz2KOup05ubU3OitD5s+HrINjlUZdqWXVZga9jdjJSlR4na
         AnEVY1zF5rKJRC3axCfvelmMgdYjyn/qdTJyL5XAe9MbWaNOa0Sxpad36P+Z7GNZ3Cti
         lqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548232; x=1763153032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRbS6VI2bNTHm/o6rxRH2I/vNUA+a3DGv8cXb7Is3Tw=;
        b=SoClgUhQJB8Qq/RjvMsde1FWjaG1kaXjsp7qHIrnitEYQdrTiz5aNv8jOJdGxx8ltS
         ZxSi13StPivJVlsBfvRwV+g6/5P/hUU51I89MX1loQn9oJonksNcLhYRQG8pAnb36HjC
         JRanBuOtIbnbJWcpOT/4rUYA7GBqU5Xwxn26dZej0IBBh7up2zELJY4s2mcEPST68zwI
         DfhsKpPNhc+783/FTqh4+04n0Wku6OJO4uVs87z4lyv3W/NBdPDpk+bZHv9LLOsCgR04
         fRNdZCPhQMWhvOOg/v6MRd+EP/J6B5bRCztQK0uxc61oM8jsMYOenoRcTx4NSc9N33IL
         m7lg==
X-Forwarded-Encrypted: i=1; AJvYcCVkvgYRrGEAEFm0G1w3OgqcCjRgUh+K+9pQGH//Y2HjHJ2TaaxhPHY2Hm7CK1wl6ESPYteYc+GpaVFq@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCVyRWeXauRly2c/qZNN31tTmtVtqJNdhxBBM531GJ3bhDlHF
	QezzfuyOR+K7Ix0P5Au95HPjil8z7WuwAsfTBw1+pc/qoPibinGgc/XZ
X-Gm-Gg: ASbGnctYJa9jkMJ+3kvC6HNp2OWR1dHGQ7mh8arJh9StoHd8GroGSCZaYcImNwJemDf
	9Wg7sz9KZKW4/Ozuka08h5Fqfdcf64zyEEgEnGvD1pcEi6brMDdbxls9/X2fq3vtayGzW891gAe
	Jh4f4mLmG1hvK1ijHxhKdZjRkgh+hVsksYoWJaIELqKGDYRKZK2f7edqsV/yUg8CQsupdQgbI3B
	CAwC9HLGdy5ISHPB1+KpuACyW+n/bMotwGNeiRh2qasbn0F2YMnXGONoOXnkEFaaF3858XVMAkQ
	/j8i7F+MvYvis4rMS1p56BPCwaYEiWuvARZTfxuNGWnec/w0Ny9ec0W7TAKaw/YHtGSiV8659EC
	PmnwRMZBd17hlqg+j/GdLbdVw0C3N7+CORgN/Z0/BZUB34xA5W/nOxUD+CohqA3eUSxAWOHyHEY
	9uR2oOPcv50w==
X-Google-Smtp-Source: AGHT+IE0Ugc4C6NPSk5vUZlI98wOMo4Ff0U+yawpaKDpCc1QgQFDLIe3p4+5eXnHVHgkKJ3wKPJQDw==
X-Received: by 2002:a05:690c:6ac9:b0:785:cbf4:72cd with SMTP id 00721157ae682-787d53524b1mr8282087b3.3.1762548232348;
        Fri, 07 Nov 2025 12:43:52 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6809e07sm856687b3.3.2025.11.07.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:43:51 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via devlink params
Date: Fri,  7 Nov 2025 12:43:46 -0800
Message-ID: <20251107204347.4060542-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251107204347.4060542-1-daniel.zahka@gmail.com>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swp_l4_csum_mode controls how L4 transmit checksums are computed when
using Software Parser (SWP) hints for header locations.

Supported values:
  1. device_default: use device default setting.
  2. full_csum: calculate L4 checksum with the pseudo-header.
  3. l4_only: calculate L4 checksum without the pseudo-header. Only
     available when swp_l4_csum_mode_l4_only is set in
     mlx5_ifc_nv_sw_offload_cap_bits.

The l4_only setting is a dependency for PSP initialization in
mlx5e_psp_init().

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
    - fix indentation issue in mlx5.rst entry

 Documentation/networking/devlink/mlx5.rst     |   9 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 161 ++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 0e5f9c76e514..675b5a1ec625 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -218,6 +218,15 @@ parameters.
        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
 
+   * - ``swp_l4_csum_mode``
+     - string
+     - permanent
+     - Configure how the L4 checksum is calculated by the device when using
+       Software Parser (SWP) hints for header locations.
+       * ``device_default`` : Use the device's default checksum calculation mode
+       * ``full_csum`` : Calculate full checksum including the pseudo-header
+       * ``l4_only`` : Calculate L4-only checksum, excluding the pseudo-header
+
 The ``mlx5`` driver supports reloading via ``DEVLINK_CMD_RELOAD``
 
 Info versions
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index c9555119a661..43b9bf8829cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -26,7 +26,8 @@ enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
 	MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
-	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
+	MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
+	MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
 };
 
 struct mlx5_trap_ctx {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 3d2195338d39..3dc5b899a5fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -8,6 +8,8 @@ enum {
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
 	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
+	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CAP                = 0x10b,
+	MLX5_CLASS_0_CTRL_ID_NV_SW_ACCELERATE_CONF            = 0x11d,
 
 	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
 };
@@ -123,6 +125,17 @@ struct mlx5_ifc_nv_sw_offload_conf_bits {
 	u8         lro_log_timeout0[0x4];
 };
 
+struct mlx5_ifc_nv_sw_offload_cap_bits {
+	u8         reserved_at_0[0x19];
+	u8         swp_l4_csum_mode_l4_only[0x1];
+	u8         reserved_at_1a[0x6];
+};
+
+struct mlx5_ifc_nv_sw_accelerate_conf_bits {
+	u8         swp_l4_csum_mode[0x2];
+	u8         reserved_at_2[0x3e];
+};
+
 #define MNVDA_HDR_SZ \
 	(MLX5_ST_SZ_BYTES(mnvda_reg) - \
 	 MLX5_BYTE_OFF(mnvda_reg, configuration_item_data))
@@ -195,6 +208,30 @@ mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
 	return mlx5_nv_param_read(dev, mnvda, len);
 }
 
+static int
+mlx5_nv_param_read_sw_offload_cap(struct mlx5_core_dev *dev, void *mnvda,
+				  size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CAP);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_offload_cap);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
+static int
+mlx5_nv_param_read_sw_accelerate_conf(struct mlx5_core_dev *dev, void *mnvda,
+				      size_t len)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_SW_ACCELERATE_CONF);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_accelerate_conf);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
 static const char *const
 	cqe_compress_str[] = { "balanced", "aggressive" };
 
@@ -269,6 +306,124 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 }
 
+enum swp_l4_csum_mode {
+	SWP_L4_CSUM_MODE_DEVICE_DEFAULT = 0,
+	SWP_L4_CSUM_MODE_FULL_CSUM = 1,
+	SWP_L4_CSUM_MODE_L4_ONLY = 2,
+};
+
+static const char *const
+	swp_l4_csum_mode_str[] = { "device_default", "full_csum", "l4_only" };
+
+static int
+mlx5_nv_param_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	u8 value = U8_MAX;
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read sw_accelerate_conf mnvda reg");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	value = MLX5_GET(nv_sw_accelerate_conf, data, swp_l4_csum_mode);
+
+	if (value >= ARRAY_SIZE(swp_l4_csum_mode_str)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid swp_l4_csum_mode value %u read from device",
+				       value);
+		return -EINVAL;
+	}
+
+	strscpy(ctx->val.vstr, swp_l4_csum_mode_str[value],
+		sizeof(ctx->val.vstr));
+	return 0;
+}
+
+static int
+mlx5_nv_param_devlink_swp_l4_csum_mode_validate(struct devlink *devlink, u32 id,
+						union devlink_param_value val,
+						struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 cap[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(swp_l4_csum_mode_str); i++) {
+		if (!strcmp(val.vstr, swp_l4_csum_mode_str[i]))
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(swp_l4_csum_mode_str)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid value, supported values are device_default/full_csum/l4_only");
+		return -EINVAL;
+	}
+
+	if (i == SWP_L4_CSUM_MODE_L4_ONLY) {
+		err = mlx5_nv_param_read_sw_offload_cap(dev, cap, sizeof(cap));
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to read sw_offload_cap");
+			return err;
+		}
+
+		data = MLX5_ADDR_OF(mnvda_reg, cap, configuration_item_data);
+		if (!MLX5_GET(nv_sw_offload_cap, data, swp_l4_csum_mode_l4_only)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "l4_only mode is not supported on this device");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int
+mlx5_nv_param_devlink_swp_l4_csum_mode_set(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	u8 value;
+	int err;
+
+	if (!strcmp(ctx->val.vstr, "device_default"))
+		value = SWP_L4_CSUM_MODE_DEVICE_DEFAULT;
+	else if (!strcmp(ctx->val.vstr, "full_csum"))
+		value = SWP_L4_CSUM_MODE_FULL_CSUM;
+	else
+		value = SWP_L4_CSUM_MODE_L4_ONLY;
+
+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read sw_accelerate_conf mnvda reg");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_sw_accelerate_conf, data, swp_l4_csum_mode, value);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to write sw_accelerate_conf mnvda reg");
+
+	return err;
+}
+
 static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
 					      void *mnvda, size_t len)
 {
@@ -548,6 +703,12 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			     mlx5_nv_param_devlink_cqe_compress_get,
 			     mlx5_nv_param_devlink_cqe_compress_set,
 			     mlx5_nv_param_devlink_cqe_compress_validate),
+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
+			     "swp_l4_csum_mode", DEVLINK_PARAM_TYPE_STRING,
+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			     mlx5_nv_param_devlink_swp_l4_csum_mode_get,
+			     mlx5_nv_param_devlink_swp_l4_csum_mode_set,
+			     mlx5_nv_param_devlink_swp_l4_csum_mode_validate),
 };
 
 int mlx5_nv_param_register_dl_params(struct devlink *devlink)
-- 
2.47.3


