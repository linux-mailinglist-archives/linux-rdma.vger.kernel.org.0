Return-Path: <linux-rdma+bounces-14577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D4C66A63
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3EF8829B54
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 00:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC925A633;
	Tue, 18 Nov 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3jber46"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1485272E5A
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425491; cv=none; b=t++iA4rc766qWDYZ6gnpBO2mI0qy1Uf0ljVtnKgbWYHohUAE3b7pvHprjCazwocuXdlh4Z8VK/4pjoxdwtAqlCFUD9CJYU91IpL0eq04mE0INrXafy+1/szyzO6JoQu1EBY/IopqyvDg1xDu0XjJPUG5zIc132FCJw73xiEA1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425491; c=relaxed/simple;
	bh=1QxVhURlV3CRj6dw/nZYj+9cbqqGRsqa+gmug9JhdcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WobyJdGIQmkPL1rcQXWrrYriwKbGbC93Zmx0aPMn3u3xaP6DnaZ2QcMQ5BABYow1BQKijAmK+urRyK5liFK8VmkLWRjRYKynJ7sUi3x/H+AwZxTtlbPkNlCgZpbLlF0CGJjxdoxIN0V4bQZxZrCJQWVlnwpkAQ2EtvQ5m8w4GXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3jber46; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-787da30c53dso43471737b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425488; x=1764030288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHxDX8GLUnTLzmadGqROyBBq+z9FrC/G/0RMGTX8FKU=;
        b=l3jber46oyd+lreviDKcfTRIGzDiKLhUaWcFYZAqzM1OYt0CWUBqZgVldFNILG8uLA
         Qu1nAH32QxBtf9t82QA2U5x9oNReDAbos0dFGyOHRMjci5XTrTwNOGLzw7cS3z3gZ1a2
         aSmgaOeqr6FfZoTfz84Eju9ahaB726bo/YSFCCMV0wBb7g/SDk1VnItWOatLofgtEPb5
         nhu/HBjrWrH7Z2jCxT8GthuCjyGJjus50raYMA7Rfp4y+MYfJvwJlX4VxL+5Np4uLJIn
         5UBqSBGEQMUltO1tFcju2nLpdc+c2cYJDNLgyTgn15ZLh5pppQoz/CCBw0JTtWBStDlP
         fIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425488; x=1764030288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHxDX8GLUnTLzmadGqROyBBq+z9FrC/G/0RMGTX8FKU=;
        b=avXP/9aYqP0+aszCRqIuWMmh3d3I+JXB4HUCVd7RkwUxcFRFzc6h6OX/rGYbx2Y+pM
         sqalX8GRLDe4+3QLZJGzoT1wOq3B1Za6XiqcRzyGfdU7zOOX498bZcH5ra5MbhPEy9to
         nDUp3CUBwf2nzfM11tV3BY2PadbBtmSI3C8aR/i9zSFf/40raELMZgI0IJybmhFo9P6e
         ImWhU/ikWZceVGSJvvwgL6xqbftYbV5yvFVmpipfPshVOWxKM8zZrncRwoZeD+Ckib1y
         zU9fepj5m9o7ItBZeIL5KQDVUVau/0EOBVEWbPb1bbgk4of6UT+GvhZqdePwFMgg80bI
         vgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8R2uf7TKwduEYce3TUJCf8vtGRPJzaMvnZ/BQpJjkyG8wMnas1lz1326/of6gl9jnvxA3xC07Ngpu@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyQ97+nkRYYaWAUblCmos+sEzPzMzQQWxHS5TpRV55XDLl6hm
	E2db/qBqMK/kw4Y6yIjkS4MfPXsXKrJDOAVqMacjlkXlmpEgE5C0+DHE
X-Gm-Gg: ASbGnctDPtudtt+vtQ68Y7cRmqNQLYlMcLKDKxAF93VeUEPreuSejjcs+PkCRqStHib
	W+iRUC+wxx87eNW2NNDtxkNw+B1az39SFuEoQLE1WRFNnpsPKR1VWym17zDPEXJNSdeZnFN+/sv
	sg589sEtw4FLjW5uaXKkHKbFPheBY3VZOWumiBBPkAT6i+CV1MhCYXjWP2JupwEcXuy25MslIKE
	b/l2Iz5alPDmLTte6Z3+D2LwMdJXFD/e66zNW9bwnlfpgJM0NcvXhMhSpxzUuEzkBcvUSvZVFCt
	oPLtls9lc3bafXF19pKLTdB54WIrTFLJN4eSx7iopY+MFwt5LUkyC+Rpu8QdK5CR5KXmpFjvmL7
	pqkXUATypSu0a9fs/A6sitpZJ2E5wXLHVEHelo3fiLczlvjCLlRwWwPWuApTRZuqW18Ky+ANRXJ
	zwJ++trociQFkGU+Sy29ggzqhMo3mS2sI=
X-Google-Smtp-Source: AGHT+IFIKrFYMWg0zCKqJk+a0BFJqG04IXqlg12zEb3AXX9T7XE0hT7R0BPp3LZj9ecFbJpwjWIcVQ==
X-Received: by 2002:a05:690c:6993:b0:786:4fd5:e5cf with SMTP id 00721157ae682-78929eb61ffmr127348387b3.32.1763425487577;
        Mon, 17 Nov 2025 16:24:47 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78821de1bfcsm47310967b3.4.2025.11.17.16.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:24:45 -0800 (PST)
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
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 4/6] net/mlx5: implement swp_l4_csum_mode via devlink params
Date: Mon, 17 Nov 2025 16:24:30 -0800
Message-ID: <20251118002433.332272-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
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
  1. default: device will choose between full_csum or l4_only. Driver
     will discover the device's choice during initialization.
  2. full_csum: calculate L4 checksum with the pseudo-header.
  3. l4_only: calculate L4 checksum without the pseudo-header. Only
     available when swp_l4_csum_mode_l4_only is set in
     mlx5_ifc_nv_sw_offload_cap_bits.

Note that 'default' might be returned from the device and passed to
userspace, and it might also be set during a
devlink_param::reset_default() call, but attempts to set a value of
default directly with param-set will be rejected.

The l4_only setting is a dependency for PSP initialization in
mlx5e_psp_init().

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v4:
    - rename device_default to default
    - implement get_default and reset_default handlers
    - don't allow user to request "default" in set cmd
    v2:
    - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
    - fix indentation issue in mlx5.rst entry

 Documentation/networking/devlink/mlx5.rst     |  14 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 229 ++++++++++++++++++
 3 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 0e5f9c76e514..4bba4d780a4a 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -218,6 +218,20 @@ parameters.
        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
 
+   * - ``swp_l4_csum_mode``
+     - string
+     - permanent
+     - Configure how the L4 checksum is calculated by the device when using
+       Software Parser (SWP) hints for header locations.
+
+       * ``default`` : Use the device's default checksum calculation
+         mode. The driver will discover during init whether or
+         full_csum or l4_only is in use. Setting this value explicitly
+         from userspace is not allowed, but some firmware versions may
+         return this value on param read.
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
index 3d2195338d39..2dfc3fc367c0 100644
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
@@ -32,6 +34,12 @@ union mlx5_ifc_config_item_type_auto_bits {
 	u8 reserved_at_0[0x20];
 };
 
+enum {
+	MLX5_ACCESS_MODE_NEXT = 0,
+	MLX5_ACCESS_MODE_CURRENT,
+	MLX5_ACCESS_MODE_DEFAULT,
+};
+
 struct mlx5_ifc_config_item_bits {
 	u8         valid[0x2];
 	u8         priority[0x2];
@@ -123,6 +131,17 @@ struct mlx5_ifc_nv_sw_offload_conf_bits {
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
@@ -195,6 +214,32 @@ mlx5_nv_param_read_sw_offload_conf(struct mlx5_core_dev *dev, void *mnvda,
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
+				      size_t len, int access_mode)
+{
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, type_class, 0);
+	MLX5_SET_CFG_ITEM_TYPE(global, mnvda, parameter_index,
+			       MLX5_CLASS_0_CTRL_ID_NV_SW_ACCELERATE_CONF);
+	MLX5_SET_CFG_HDR_LEN(mnvda, nv_sw_accelerate_conf);
+	MLX5_SET(mnvda_reg, mnvda, configuration_item_header.access_mode,
+		 access_mode);
+
+	return mlx5_nv_param_read(dev, mnvda, len);
+}
+
 static const char *const
 	cqe_compress_str[] = { "balanced", "aggressive" };
 
@@ -269,6 +314,182 @@ mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 id,
 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
 }
 
+enum swp_l4_csum_mode {
+	SWP_L4_CSUM_MODE_DEFAULT = 0,
+	SWP_L4_CSUM_MODE_FULL_CSUM = 1,
+	SWP_L4_CSUM_MODE_L4_ONLY = 2,
+};
+
+static const char *const
+	swp_l4_csum_mode_str[] = { "default", "full_csum", "l4_only" };
+
+static int
+mlx5_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
+			  int access_mode, u8 *value,
+			  struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda),
+						    access_mode);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read sw_accelerate_conf mnvda reg");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	*value = MLX5_GET(nv_sw_accelerate_conf, data, swp_l4_csum_mode);
+
+	if (*value >= ARRAY_SIZE(swp_l4_csum_mode_str)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid swp_l4_csum_mode value %u read from device",
+				       *value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+mlx5_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
+{
+	u8 value;
+	int err;
+
+	err = mlx5_swp_l4_csum_mode_get(devlink, id, MLX5_ACCESS_MODE_NEXT,
+					&value, extack);
+	if (err)
+		return err;
+
+	strscpy(ctx->val.vstr, swp_l4_csum_mode_str[value],
+		sizeof(ctx->val.vstr));
+	return 0;
+}
+
+static int
+mlx5_devlink_swp_l4_csum_mode_validate(struct devlink *devlink, u32 id,
+				       union devlink_param_value val,
+				       struct netlink_ext_ack *extack)
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
+	if (i >= ARRAY_SIZE(swp_l4_csum_mode_str) ||
+	    i == SWP_L4_CSUM_MODE_DEFAULT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid value, supported values are full_csum/l4_only");
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
+mlx5_swp_l4_csum_mode_set(struct devlink *devlink, u32 id, u8 value,
+			  struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda),
+						    MLX5_ACCESS_MODE_NEXT);
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
+static int
+mlx5_devlink_swp_l4_csum_mode_set(struct devlink *devlink, u32 id,
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
+{
+	u8 value;
+
+	if (!strcmp(ctx->val.vstr, "full_csum"))
+		value = SWP_L4_CSUM_MODE_FULL_CSUM;
+	else
+		value = SWP_L4_CSUM_MODE_L4_ONLY;
+
+	return mlx5_swp_l4_csum_mode_set(devlink, id, value, extack);
+}
+
+static int
+mlx5_devlink_swp_l4_csum_mode_get_default(struct devlink *devlink, u32 id,
+					  struct devlink_param_gset_ctx *ctx,
+					  struct netlink_ext_ack *extack)
+{
+	u8 value;
+	int err;
+
+	err = mlx5_swp_l4_csum_mode_get(devlink, id, MLX5_ACCESS_MODE_DEFAULT,
+					&value, extack);
+	if (err)
+		return err;
+
+	strscpy(ctx->val.vstr, swp_l4_csum_mode_str[value],
+		sizeof(ctx->val.vstr));
+	return 0;
+}
+
+static int
+mlx5_devlink_swp_l4_csum_mode_set_default(struct devlink *devlink, u32 id,
+					  enum devlink_param_cmode cmode,
+					  struct netlink_ext_ack *extack)
+{
+	u8 value;
+	int err;
+
+	err = mlx5_swp_l4_csum_mode_get(devlink, id, MLX5_ACCESS_MODE_DEFAULT,
+					&value, extack);
+	if (err)
+		return err;
+
+	return mlx5_swp_l4_csum_mode_set(devlink, id, value, extack);
+}
+
 static int mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev,
 					      void *mnvda, size_t len)
 {
@@ -548,6 +769,14 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			     mlx5_nv_param_devlink_cqe_compress_get,
 			     mlx5_nv_param_devlink_cqe_compress_set,
 			     mlx5_nv_param_devlink_cqe_compress_validate),
+	DEVLINK_PARAM_DRIVER_WITH_DEFAULTS(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
+					   "swp_l4_csum_mode", DEVLINK_PARAM_TYPE_STRING,
+					   BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+					   mlx5_devlink_swp_l4_csum_mode_get,
+					   mlx5_devlink_swp_l4_csum_mode_set,
+					   mlx5_devlink_swp_l4_csum_mode_validate,
+					   mlx5_devlink_swp_l4_csum_mode_get_default,
+					   mlx5_devlink_swp_l4_csum_mode_set_default),
 };
 
 int mlx5_nv_param_register_dl_params(struct devlink *devlink)
-- 
2.47.3


