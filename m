Return-Path: <linux-rdma+bounces-4892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F59761A1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 08:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F40B1C20DB7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B70189B88;
	Thu, 12 Sep 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="ZDlSgDhc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C513307B;
	Thu, 12 Sep 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123177; cv=none; b=GQYar3Rmu6Jj6jIPrdfZYsJvsaOSFhp+ardTs5Jpd/kX/+H1nJu2uL7uUX0RSRwVlIVFJ2B61ri3U0PW8hXuQpIl5urMgpgx9ruQSAv+zE8wMWC9Mg4V5XY4ZBRqAE7RfnLCDD1RF/31IpCJjVlrfAoO0AQx2Qny+pq7HTAFM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123177; c=relaxed/simple;
	bh=qMti8TOkF49at/JjjM+2xZd1VDN8ouRs1Xy7zFMILuU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=XssP4y+9NQPLgOWUsBoDPJr9Kn5MrEar2ikG4oN7pGlME8FOOCxre1AhbfQR6IvvA0soSqkLw4TRPfmDNx3T2L9LwC560eRxm9ShLjLE9RAlF2J+fXWdaIwPNa1WRK+MbCynSRTPnGGx5UFnLqoA2ovEp83PIOzVhq0LvDvbluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=ZDlSgDhc; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6clPq019590
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:38:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726123133; bh=EZB+B2jWXk2HnC/1CNaI0I+2FNtEtAYvByasMjqWJb0=;
	h=Date:From:To:Cc:Subject;
	b=ZDlSgDhcvucG32W5brufng+MytqdyyQ+LRs2SH4IAmX17BJ5/7OWl7iC3ILRKbvY9
	 9sAZxQXgIgGrxPh48HrO9GtcvH8mclf5tgvY1KtlRuU2pcKCT55iFYsYqUpst5QAVl
	 +viO25z2spBYFKjSZWp4mvUdofj00YnTHkE8BL/g=
Message-ID: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
Date: Wed, 11 Sep 2024 23:38:45 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use SFF8024 constants defined in linux/sfp.h instead of private ones.

Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
as close as possible to each other.

Simplify the logic for selecting SFF_8436 vs SFF_8636.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 33 ++++++++++---------
 drivers/net/ethernet/mellanox/mlx4/port.c     |  9 ++---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 +++++++++-------
 .../net/ethernet/mellanox/mlx5/core/port.c    |  9 ++---
 include/linux/mlx4/device.h                   |  7 ----
 include/linux/mlx5/port.h                     |  8 -----
 6 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index cd17a3f4faf8..4c985d62af12 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -40,6 +40,7 @@
 #include <net/ip.h>
 #include <linux/bitmap.h>
 #include <linux/mii.h>
+#include <linux/sfp.h>
 
 #include "mlx4_en.h"
 #include "en_port.h"
@@ -2029,33 +2030,35 @@ static int mlx4_en_get_module_info(struct net_device *dev,
 
 	/* Read first 2 bytes to get Module & REV ID */
 	ret = mlx4_get_module_info(mdev->dev, priv->port,
-				   0/*offset*/, 2/*size*/, data);
+				   0 /*offset*/, 2 /*size*/, data);
 	if (ret < 2)
 		return -EIO;
 
-	switch (data[0] /* identifier */) {
-	case MLX4_MODULE_ID_QSFP:
-		modinfo->type = ETH_MODULE_SFF_8436;
+	/* data[0] = identifier byte */
+	switch (data[0]) {
+	case SFF8024_ID_QSFP_8438:
+		modinfo->type       = ETH_MODULE_SFF_8436;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
-	case MLX4_MODULE_ID_QSFP_PLUS:
-		if (data[1] >= 0x3) { /* revision id */
-			modinfo->type = ETH_MODULE_SFF_8636;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
-		} else {
-			modinfo->type = ETH_MODULE_SFF_8436;
+	case SFF8024_ID_QSFP_8436_8636:
+		/* data[1] = revision id */
+		if (data[1] < 0x3) {
+			modinfo->type       = ETH_MODULE_SFF_8436;
 			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
+			break;
 		}
-		break;
-	case MLX4_MODULE_ID_QSFP28:
-		modinfo->type = ETH_MODULE_SFF_8636;
+		fallthrough;
+	case SFF8024_ID_QSFP28_8636:
+		modinfo->type       = ETH_MODULE_SFF_8636;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		break;
-	case MLX4_MODULE_ID_SFP:
-		modinfo->type = ETH_MODULE_SFF_8472;
+	case SFF8024_ID_SFP:
+		modinfo->type       = ETH_MODULE_SFF_8472;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
 		break;
 	default:
+		netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
+			   __func__, data[0]);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 4e43f4a7d246..6dbd505e7f30 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -34,6 +34,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/export.h>
+#include <linux/sfp.h>
 
 #include <linux/mlx4/cmd.h>
 
@@ -2139,12 +2140,12 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
 		return ret;
 
 	switch (module_id) {
-	case MLX4_MODULE_ID_SFP:
+	case SFF8024_ID_SFP:
 		mlx4_sfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
 		break;
-	case MLX4_MODULE_ID_QSFP:
-	case MLX4_MODULE_ID_QSFP_PLUS:
-	case MLX4_MODULE_ID_QSFP28:
+	case SFF8024_ID_QSFP_8438:
+	case SFF8024_ID_QSFP_8436_8636:
+	case SFF8024_ID_QSFP28_8636:
 		mlx4_qsfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
 		break;
 	default:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 4d123dae912c..12a22e5c60ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -32,6 +32,7 @@
 
 #include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/sfp.h>
 
 #include "en.h"
 #include "en/channels.h"
@@ -1899,36 +1900,39 @@ static int mlx5e_get_module_info(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *dev = priv->mdev;
-	int size_read = 0;
+	int ret;
 	u8 data[4] = {0};
 
-	size_read = mlx5_query_module_eeprom(dev, 0, 2, data);
-	if (size_read < 2)
+	/* Read first 2 bytes to get Module & REV ID */
+	ret = mlx5_query_module_eeprom(dev,
+				       0 /*offset*/, 2 /*size*/, data);
+	if (ret < 2)
 		return -EIO;
 
 	/* data[0] = identifier byte */
 	switch (data[0]) {
-	case MLX5_MODULE_ID_QSFP:
+	case SFF8024_ID_QSFP_8438:
 		modinfo->type       = ETH_MODULE_SFF_8436;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
-	case MLX5_MODULE_ID_QSFP_PLUS:
-	case MLX5_MODULE_ID_QSFP28:
+	case SFF8024_ID_QSFP_8436_8636:
 		/* data[1] = revision id */
-		if (data[0] == MLX5_MODULE_ID_QSFP28 || data[1] >= 0x3) {
-			modinfo->type       = ETH_MODULE_SFF_8636;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
-		} else {
+		if (data[1] < 0x3) {
 			modinfo->type       = ETH_MODULE_SFF_8436;
 			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
+			break;
 		}
+		fallthrough;
+	case SFF8024_ID_QSFP28_8636:
+		modinfo->type       = ETH_MODULE_SFF_8636;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		break;
-	case MLX5_MODULE_ID_SFP:
+	case SFF8024_ID_SFP:
 		modinfo->type       = ETH_MODULE_SFF_8472;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
 		break;
 	default:
-		netdev_err(priv->netdev, "%s: cable type not recognized:0x%x\n",
+		netdev_err(priv->netdev, "%s: cable type not recognized: 0x%x\n",
 			   __func__, data[0]);
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 50931584132b..4258489a5782 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/sfp.h>
 #include <linux/mlx5/port.h>
 #include "mlx5_core.h"
 
@@ -425,12 +426,12 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 		return err;
 
 	switch (module_id) {
-	case MLX5_MODULE_ID_SFP:
+	case SFF8024_ID_SFP:
 		mlx5_sfp_eeprom_params_set(&query.i2c_address, &query.page, &offset);
 		break;
-	case MLX5_MODULE_ID_QSFP:
-	case MLX5_MODULE_ID_QSFP_PLUS:
-	case MLX5_MODULE_ID_QSFP28:
+	case SFF8024_ID_QSFP_8438:
+	case SFF8024_ID_QSFP_8436_8636:
+	case SFF8024_ID_QSFP28_8636:
 		mlx5_qsfp_eeprom_params_set(&query.i2c_address, &query.page, &offset);
 		break;
 	default:
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c89..a75bfb2a4438 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -487,13 +487,6 @@ enum {
 #define MSTR_SM_CHANGE_MASK (MLX4_EQ_PORT_INFO_MSTR_SM_SL_CHANGE_MASK | \
 			     MLX4_EQ_PORT_INFO_MSTR_SM_LID_CHANGE_MASK)
 
-enum mlx4_module_id {
-	MLX4_MODULE_ID_SFP              = 0x3,
-	MLX4_MODULE_ID_QSFP             = 0xC,
-	MLX4_MODULE_ID_QSFP_PLUS        = 0xD,
-	MLX4_MODULE_ID_QSFP28           = 0x11,
-};
-
 enum { /* rl */
 	MLX4_QP_RATE_LIMIT_NONE		= 0,
 	MLX4_QP_RATE_LIMIT_KBS		= 1,
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index e68d42b8ce65..e9495271160f 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -40,14 +40,6 @@ enum mlx5_beacon_duration {
 	MLX5_BEACON_DURATION_INF = 0xffff,
 };
 
-enum mlx5_module_id {
-	MLX5_MODULE_ID_SFP              = 0x3,
-	MLX5_MODULE_ID_QSFP             = 0xC,
-	MLX5_MODULE_ID_QSFP_PLUS        = 0xD,
-	MLX5_MODULE_ID_QSFP28           = 0x11,
-	MLX5_MODULE_ID_DSFP		= 0x1B,
-};
-
 enum mlx5_an_status {
 	MLX5_AN_UNAVAILABLE = 0,
 	MLX5_AN_COMPLETE    = 1,
-- 
2.46.0

