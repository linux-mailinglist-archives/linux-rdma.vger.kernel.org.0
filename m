Return-Path: <linux-rdma+bounces-17014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHDVDroJl2nvtwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47415ECFE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7095730117D9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69A33ADAD;
	Thu, 19 Feb 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr4Z6+DB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140733A037;
	Thu, 19 Feb 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506083; cv=none; b=QKaLJMUNedxeV5AHdCGg3Sgu6TSX09nAEZ9NCXFZWDljf/nZQmtgy3wx8ugQAAQj+EeJA4UxIYxTmYqrwoYhkuP3Iy+8oQOFgcMT96EfrHm4zQUVfSz3+WSnsxl6GXj2YH5Hu5ynuKTDX/RBDbTFWcEKLyR7jQXEtZWKkjaBkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506083; c=relaxed/simple;
	bh=V2Sg/sfv4PWxxKI75fDIqd1RPCy34I6/UXyVpO38+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y98x9AwreysnjlZaVggnRs3aA2Kz9RsJ8yciTMengA0MMhLbgMO46t7vZqlGMTn/+QP6CnrWhLyvEtY3eYqibo52dfyODu+9dZowdaCnmhlqGDQbRqsPdtBuz4693jD7lE7GWg9GE7k0uT5zj+vmjqWsnl0+o2uM4uHmT+cnJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr4Z6+DB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FC6C116C6;
	Thu, 19 Feb 2026 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506082;
	bh=V2Sg/sfv4PWxxKI75fDIqd1RPCy34I6/UXyVpO38+G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr4Z6+DBa/B/bdDMhtrKzSh9U8kAFd1Fmi29Oi9IyqLvOYoyXjCQJm8+LYkfQwlCo
	 AvN4nWz6WHVPM5qc9mIY2Ae1ctG5tGXDV1OYskwU3csFgnOt6ZaUzfz3NAOjeBv1qd
	 9Q+VGw+RCXPCPBsLOHN1AA4E6vV6tX13a+8NRM3qOwzucPfjdNosGGa4gEEo6lHUR5
	 bAK23oORQQdaNCAFKwDphlEFLTUw2QC5nl3jo66g2J93Zr8aiG8oqUdjP78+X5jNuS
	 MbnLuSHI3NswtssBiusmRodpGHsf68eLU3Jjrh9nRUvrMlNysIQisxK3ftrmP0JvqE
	 Bcn3ZWj9GwyGw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [RFC net-next 4/4] net/mlx5e: Implement set_module_eeprom_by_page ethtool callback
Date: Thu, 19 Feb 2026 14:00:45 +0100
Message-ID: <20260219130050.2390226-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219130050.2390226-1-bjorn@kernel.org>
References: <20260219130050.2390226-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17014-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE47415ECFE
X-Rspamd-Action: no action

Add EEPROM write support by implementing the set_module_eeprom_by_page
ethtool_ops callback, mirroring the existing get_module_eeprom_by_page
read path. This enables the kernel's module loopback SET path which
requires both get and set callbacks.

The write path reuses the MCIA register (MLX5_REG_MCIA) via
mlx5_core_access_reg() with write=1 instead of write=0.

This seems to work, but I'd like some proper feedback from the mlx5
folks! ;-)

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 52 +++++++++++++------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  6 +--
 .../net/ethernet/mellanox/mlx5/core/port.c    | 34 ++++++++----
 3 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 4a8dc85d5924..1dce67485651 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2103,22 +2103,24 @@ static int mlx5e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
-static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
-					   const struct ethtool_module_eeprom *page_data,
-					   struct netlink_ext_ack *extack)
+static int __mlx5e_access_module_eeprom_by_page(struct net_device *netdev,
+						const struct ethtool_module_eeprom *page_data,
+						struct netlink_ext_ack *extack,
+						bool write)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_module_eeprom_query_params query;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 *data = page_data->data;
-	int size_read;
+	int size_xfered;
 	u8 status = 0;
 	int i = 0;
 
 	if (!page_data->length)
 		return -EINVAL;
 
-	memset(data, 0, page_data->length);
+	if (!write)
+		memset(data, 0, page_data->length);
 
 	query.offset = page_data->offset;
 	query.i2c_address = page_data->i2c_address;
@@ -2126,28 +2128,47 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 	query.page = page_data->page;
 	while (i < page_data->length) {
 		query.size = page_data->length - i;
-		size_read = mlx5_query_module_eeprom_by_page(mdev, &query,
-							     data + i, &status);
+		size_xfered = mlx5_access_module_eeprom_by_page(mdev, &query,
+								data + i, &status,
+								write);
 
-		/* Done reading, return how many bytes was read */
-		if (!size_read)
+		if (!size_xfered)
 			return i;
 
-		if (size_read < 0) {
+		if (size_xfered < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(
 				extack,
-				"Query module eeprom by page failed, read %u bytes, err %d, status %u",
-				i, size_read, status);
-			return size_read;
+				"%s module eeprom by page failed, %s %u bytes, err %d, status %u",
+				write ? "Set" : "Query",
+				write ? "wrote" : "read",
+				i, size_xfered, status);
+			return size_xfered;
 		}
 
-		i += size_read;
-		query.offset += size_read;
+		i += size_xfered;
+		query.offset += size_xfered;
 	}
 
 	return i;
 }
 
+static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
+					   const struct ethtool_module_eeprom *page_data,
+					   struct netlink_ext_ack *extack)
+{
+	return __mlx5e_access_module_eeprom_by_page(netdev, page_data, extack, false);
+}
+
+static int mlx5e_set_module_eeprom_by_page(struct net_device *netdev,
+					   const struct ethtool_module_eeprom *page_data,
+					   struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = __mlx5e_access_module_eeprom_by_page(netdev, page_data, extack, true);
+	return err < 0 ? err : 0;
+}
+
 int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
 			       struct ethtool_flash *flash)
 {
@@ -2776,6 +2797,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.get_module_info   = mlx5e_get_module_info,
 	.get_module_eeprom = mlx5e_get_module_eeprom,
 	.get_module_eeprom_by_page = mlx5e_get_module_eeprom_by_page,
+	.set_module_eeprom_by_page = mlx5e_set_module_eeprom_by_page,
 	.flash_device      = mlx5e_flash_device,
 	.get_priv_flags    = mlx5e_get_priv_flags,
 	.set_priv_flags    = mlx5e_set_priv_flags,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b635b423d972..b69730727764 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -361,9 +361,9 @@ void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 			     u16 offset, u16 size, u8 *data, u8 *status);
 int
-mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
-				 struct mlx5_module_eeprom_query_params *params,
-				 u8 *data, u8 *status);
+mlx5_access_module_eeprom_by_page(struct mlx5_core_dev *dev,
+				  struct mlx5_module_eeprom_query_params *params,
+				  u8 *data, u8 *status, bool write);
 
 int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
 int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index ee8b9765c5ba..d68f9f9d7a80 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -369,9 +369,9 @@ static int mlx5_mcia_max_bytes(struct mlx5_core_dev *dev)
 	return (MLX5_CAP_MCAM_FEATURE(dev, mcia_32dwords) ? 32 : 12) * sizeof(u32);
 }
 
-static int mlx5_query_mcia(struct mlx5_core_dev *dev,
-			   struct mlx5_module_eeprom_query_params *params,
-			   u8 *data, u8 *status)
+static int __mlx5_access_mcia(struct mlx5_core_dev *dev,
+			      struct mlx5_module_eeprom_query_params *params,
+			      u8 *data, u8 *status, bool write)
 {
 	u32 in[MLX5_ST_SZ_DW(mcia_reg)] = {};
 	u32 out[MLX5_ST_SZ_DW(mcia_reg)];
@@ -388,8 +388,13 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 	MLX5_SET(mcia_reg, in, page_number, params->page);
 	MLX5_SET(mcia_reg, in, i2c_device_address, params->i2c_address);
 
+	if (write) {
+		ptr = MLX5_ADDR_OF(mcia_reg, in, dword_0);
+		memcpy(ptr, data, size);
+	}
+
 	err = mlx5_core_access_reg(dev, in, sizeof(in), out,
-				   sizeof(out), MLX5_REG_MCIA, 0, 0);
+				   sizeof(out), MLX5_REG_MCIA, 0, write);
 	if (err)
 		return err;
 
@@ -399,12 +404,21 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 		return -EIO;
 	}
 
-	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
-	memcpy(data, ptr, size);
+	if (!write) {
+		ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
+		memcpy(data, ptr, size);
+	}
 
 	return size;
 }
 
+static int mlx5_query_mcia(struct mlx5_core_dev *dev,
+			   struct mlx5_module_eeprom_query_params *params,
+			   u8 *data, u8 *status)
+{
+	return __mlx5_access_mcia(dev, params, data, status, false);
+}
+
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 			     u16 offset, u16 size, u8 *data, u8 *status)
 {
@@ -446,9 +460,9 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 	return mlx5_query_mcia(dev, &query, data, status);
 }
 
-int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
-				     struct mlx5_module_eeprom_query_params *params,
-				     u8 *data, u8 *status)
+int mlx5_access_module_eeprom_by_page(struct mlx5_core_dev *dev,
+				      struct mlx5_module_eeprom_query_params *params,
+				      u8 *data, u8 *status, bool write)
 {
 	int err;
 
@@ -462,7 +476,7 @@ int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 		return -EINVAL;
 	}
 
-	return mlx5_query_mcia(dev, params, data, status);
+	return __mlx5_access_mcia(dev, params, data, status, write);
 }
 
 static int mlx5_query_port_pvlc(struct mlx5_core_dev *dev, u32 *pvlc,
-- 
2.53.0


