Return-Path: <linux-rdma+bounces-13984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAABFDF95
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 21:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0ECB1A6053A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3C34E774;
	Wed, 22 Oct 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzgGgL9t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D42F1FD2
	for <linux-rdma@vger.kernel.org>; Wed, 22 Oct 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160176; cv=none; b=pFFn4Beta5yhuJJcKtkw4AImjiOUNHNF3TDzq5fIcPnsJKaqDgLw/2J1r1Z3kHBj/igr+Rem8m185oxyAlAehA4t8QDeLYncnC3LxAiK9sISnh+fXcE4NDamVbzIMVeDXAsuiom8SmZCb/5QDIEVY4BUx3VfnqkBMnsQsoKxbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160176; c=relaxed/simple;
	bh=3VROX7oYWFgfXwv1tuulpG3URc0xaVThq+McA4Nkwwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qL4iAQuyOMeEd35SLmhIDsdhjj+isTiZVdE38DiX2nDeluxgn92G4juZA6NW6RxcsVrtqZZoUAJtiBXvI5Fu31AK2xdS7PAgiRXTlg2iaj3o6xnXgUw/LW4cQdR0w0eFc+Gr5lCyyy30EFn3LHnMcKxmqfGzIf/E5eH4p8+Ywpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzgGgL9t; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7832691f86cso94088537b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Oct 2025 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761160174; x=1761764974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzTmRaie4StC1dGzPSKJ0L/pPh8vFC7i5HLcbKg6U3w=;
        b=JzgGgL9tKApy2KWE/BcEiNGXkYXAi5j6me1UXBFNxhjYSK2PgsSBM+P1Q8sSrotod+
         9j4ZkslKR5eaGwetnEfRrNl/HtTBXyZltTqCHAz66fiuWOjMWVkoCaM7DWigSAyRKN68
         CyzsHfice8G9wpTnN18eFAMpMn3fdHvVdjJ+I0igqR1XBcLXKzHB02NqH4ebeJuW3ixo
         KcfL59Vhgmg+mRTjiT6RT/XOL0F22UByilT3vm1jfdnOV5wc7iUQJWPQHui3XNWzn4Za
         sZ6IoF7fqbHKbATHr1SyGZDVj6vQSoBLVthX/FOUK+yrFX7DyOOlcDyLgSxUgAAe+4OS
         /DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761160174; x=1761764974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzTmRaie4StC1dGzPSKJ0L/pPh8vFC7i5HLcbKg6U3w=;
        b=fMvCIj1UVZDBHnhw2UiKp5kJONqFS6AE0wiQI09YlUNk5BrS807/hRtbggi/yVzBwv
         uD4r/u/uEGKh6p4+Sd3v4U8y+iX22pvHdtgs70YNzVJ+foG3NC2uirHuoVSHrNRLl1p4
         d8po83tcNQZIOBp35peg8t4PtF7/aGNq96j1JcCAh6oj8ETOUYv9DH7ncsnc7DhdORtc
         55ZUvt7cfDCtDUxyH4nL0c98TxJmizHbE6wVFIUUggAOKBpOxLuaFWhDbrKmaL1AK/UQ
         Km2odDDJUjNNjL2WwZgloDqGJ4TdZslDBDOdy4hSHW3QyOgExhmhxMxLSYvG+M6F7svC
         hP9A==
X-Forwarded-Encrypted: i=1; AJvYcCX9CnmRumP6ZozfvsBB8zKxoxivhjD7hyYrERFS/Z3g7+KTv03WZkJowqufdGEDlKjcv99VsFwGGLxi@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwitJbOzgcEnbEaRLzYeZRDrFq+wFDNxk3Rq8L/R9U5dkWooo
	6fzmMqbFgl7xbR1OwerIPCA8BG9Q1gUpPpkCaa6sbYRBE1zZ0Z7FsKB2
X-Gm-Gg: ASbGncuVUKmLCy6Fz79ZCC3BEEW57jweViFPWpLhwbqO5LYNCVjkMIrtbx8MHDfkZfG
	DVpKJSLTcEac+22jJHaFde6M34p6/M4DHCHvfodLe5m+RrN7aymq9NIDSlY0Db7QsBuZUjhCleB
	+umJX8wxd5BYoYR+8oRsEpvB2mL49hC3jo2AeZh52UP725LE5X/l47vzj9+EfCssSgD8sGJ/RGc
	CJ/v0yhD06lRZAEcn3agzsmCn+W9qq/gbG8VWD/vDfgiGxX9BA5oD7Ggwm20d4det8fygq0O3TV
	A1eu9QqqjwFEnAAllEzLrXyIHeodwqyysfMiQ9exyQP0PU2ch5RQh6Pyc9s24aRO9w7wAYsfID7
	xnn29JqVvtsgg/mJluKyqdJ8XHjH+rylzwHvuPVuMyWGKhxvyEWZN0W5AXbc13dzevuEgtiL5js
	XJ7JZKBFxh1w==
X-Google-Smtp-Source: AGHT+IFLQTLJQyjspIyGqUq/yqC1W5RgRAenuW9qYN36aVJfjtQDXjWYUcesxNEH2cwFI0pnRQWVWg==
X-Received: by 2002:a05:690c:67c5:b0:780:d2cc:3c2d with SMTP id 00721157ae682-7836d4cdb4dmr176165967b3.1.1761160173725;
        Wed, 22 Oct 2025 12:09:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd5e23e4sm199907b3.22.2025.10.22.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:09:33 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via devlink params
Date: Wed, 22 Oct 2025 12:09:31 -0700
Message-ID: <20251022190932.1073898-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
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
  2. full_csum: calculate L4 checksum with the psuedo-header.
  3. l4_only: calculate L4 checksum without the psuedo-header. Only
     available when swp_l4_csum_mode_l4_only is set in
     mlx5_ifc_nv_sw_offload_cap_bits.

The l4_only setting is a dependency for PSP initialization in
mlx5e_psp_init().

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/networking/devlink/mlx5.rst     |   9 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 148 ++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 0e5f9c76e514..f366e551b2f7 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -218,6 +218,15 @@ parameters.
        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
 
+    * - ``swp_l4_csum_mode``
+      - string
+      - permanent
+      - Configure how the L4 checksum is calculated by the device when using
+        Software Parser (SWP) hints for header locations.
+        * ``device_default`` : Use the device's default checksum calculation mode
+        * ``full_csum`` : Calculate full checksum including the pseudo-header
+        * ``l4_only`` : Calculate L4-only checksum, excluding the pseudo-header
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
index 459a0b4d08e6..fac3d9801b3b 100644
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
@@ -195,9 +208,42 @@ mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
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
 
+enum swp_l4_csum_mode {
+	SWP_L4_CSUM_MODE_DEVICE_DEFAULT = 0,
+	SWP_L4_CSUM_MODE_FULL_CSUM = 1,
+	SWP_L4_CSUM_MODE_L4_ONLY = 2,
+};
+
+static const char *const
+	swp_l4_csum_mode_str[] = { "device_default", "full_csum", "l4_only" };
+
 static int
 mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
 				       struct devlink_param_gset_ctx *ctx)
@@ -268,6 +314,102 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 }
 
+static int
+mlx5_nv_param_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	u8 value = U8_MAX;
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
+	if (err)
+		return err;
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	value = MLX5_GET(nv_sw_accelerate_conf, data, swp_l4_csum_mode);
+
+	if (value >= ARRAY_SIZE(swp_l4_csum_mode_str))
+		return -EOPNOTSUPP;
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
+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+}
+
 static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
 					      void *mnvda, size_t len)
 {
@@ -545,6 +687,12 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
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


