Return-Path: <linux-rdma+bounces-21012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LyUBmkYDWoctQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:11:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B767F586BC6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 04:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F0C3055E56
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E33002D8;
	Wed, 20 May 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DQg2No1z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36B2FFFB8;
	Wed, 20 May 2026 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243080; cv=none; b=DCqcAmfK4h1pDWSmhAeVW/f1QJxBDd8UMqvrVswBFWenxDRb6R1N/65C5WL4DeRAmD/ENpUKascpW5zMCKImRfUVoid1dG3Oy7+zhVf/DbslvHvVnBtGbFllbMAW3UIwKrkzb4gbBzsCtnc4wA+RYal8WIIt++gnNwgJaFUmjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243080; c=relaxed/simple;
	bh=82S5qPKABfZLZNdFCHZg5I3zAOaT1wv0sRxx9PplVs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxs/cM6wJS2dpRuyjIvUXdo7W/p/0LgOkBT/Ueg+ia2KnsY9Ym6iEE1MuLt/mXRaRtHCmTsqdK4jiIQsHI07bRplnapkYQkfeQweDSW3PcI8s9H2oxNZPjfVmyqdcjyzX/kKX9WqZDTAeYWbU0A9ZpZFkWz1ciif5x1TiSAbGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DQg2No1z; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JLpWnS3638159;
	Tue, 19 May 2026 19:10:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	U+zHNDZEsWwX6Mq1FaTlkkIxTZNWYmPtkPXt96TI1s=; b=DQg2No1z9+2CTDfTY
	8SxybK0373d0RurDHbXpxAw86VxKA8KrzDcVKDvfEjw42kWC5EQa3vQK126flKSl
	Ar2o87JvCAOInaAJYh5IHLagWwTjpRqlMeUD3UT0aOv46dk9vkrYxPhYDytDOsqM
	fqoy8oFA4jpclmjkjkgym7dbp7vdnUy3ZI25sEkpzIzIqVkjUBWIiNAuwlA4dpvm
	CCOipAfQ1h9bAI19SEqUvO/XsTVbVcZqvsoigucWE2eL+gifvRrgsdd/ODu5Krcp
	fMFlZ4ioSrpxWd6ib7r2fr5tpbM+QCAVKlABBPQoJkI1UMcrUcKtDx4fBRM7NQGx
	bCMNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8ejb3v9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:10:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 May 2026 19:10:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 May 2026 19:10:17 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2F0CA5B6945;
	Tue, 19 May 2026 19:10:08 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>,
        "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH v15 net-next 2/9] net/mlx5e: Reduce stack use reading PCIe congestion thresholds
Date: Wed, 20 May 2026 07:39:32 +0530
Message-ID: <20260520020939.1457231-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520020939.1457231-1-rkannoth@marvell.com>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fmM5LG89DVoe6WsT2wicD4kN3aJguZPU
X-Authority-Analysis: v=2.4 cv=KaPidwYD c=1 sm=1 tr=0 ts=6a0d180b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=atuItEQtGSbojjJp8OQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOCBTYWx0ZWRfXyx2avOx6OJ2l
 eOku4tcdTTh+QZdfsDNJOizUwR8SHRxjghWlfLYiKzliXH0oWgiqSIAaTwPiUc5/+dxUVqGCXd3
 Zb9CzzGxr5WPj+z7ZR7BpQ6yk1KErAwIsiopQxHziC0j5p5YTopvXlJ4JxC7TYam0QuhIO4SDyj
 R0uUslgxJsTFy6JOSUiD3R7IvPk4K3zE9czGWOVG59h1jdzldGATc3B9Ljjk3QgPsmWnnmqsIXL
 Ee0Z7WES/vUOWVAercXVwRyY4M2KXQfQiNuPzKz9pGX3aRWdYpCEZSM8hktXrjRp7ssSY+4uMyN
 nABXRBPUbEZUasvMv9V2yfJR5TNO+Lf4SEaMpWkfwthLJDXfMbPMaPzB6TxJiScGFctRZbG6I7U
 1aQI571YYv+Ma7sPP3WI7kHhJVuGHUWAjDfuwYalB2/Sv2KgtYMWwmlvnfesqd5lflpDig854JG
 SvXGcNxd0cDZDr4VdcQ==
X-Proofpoint-ORIG-GUID: fmM5LG89DVoe6WsT2wicD4kN3aJguZPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21012-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B767F586BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

union devlink_param_value grew when U64 array parameters were added.
Keeping union devlink_param_value val[4] in
mlx5e_pcie_cong_get_thresh_config() exceeded the compiler's
-Wframe-larger-than limit.

Reuse one union: call devl_param_driverinit_value_get() once per
MLX5 PCIe congestion threshold and assign each vu16 to the
corresponding mlx5e_pcie_cong_thresh member.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 45 +++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 2eb666a46f39..f4f2ecfc6719 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -252,28 +252,37 @@ static int
 mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 				  struct mlx5e_pcie_cong_thresh *config)
 {
-	u32 ids[4] = {
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
-	};
 	struct devlink *devlink = priv_to_devlink(dev);
-	union devlink_param_value val[4];
+	union devlink_param_value val;
+	int err;
 
-	for (int i = 0; i < 4; i++) {
-		u32 id = ids[i];
-		int err;
+	err = devl_param_driverinit_value_get(devlink,
+					      MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
+					      &val);
+	if (err)
+		return err;
+	config->inbound_low = val.vu16;
 
-		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
-		if (err)
-			return err;
-	}
+	err = devl_param_driverinit_value_get(devlink,
+					      MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
+					      &val);
+	if (err)
+		return err;
+	config->inbound_high = val.vu16;
 
-	config->inbound_low = val[0].vu16;
-	config->inbound_high = val[1].vu16;
-	config->outbound_low = val[2].vu16;
-	config->outbound_high = val[3].vu16;
+	err = devl_param_driverinit_value_get(devlink,
+					      MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
+					      &val);
+	if (err)
+		return err;
+	config->outbound_low = val.vu16;
+
+	err = devl_param_driverinit_value_get(devlink,
+					      MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
+					      &val);
+	if (err)
+		return err;
+	config->outbound_high = val.vu16;
 
 	return 0;
 }
-- 
2.43.0


