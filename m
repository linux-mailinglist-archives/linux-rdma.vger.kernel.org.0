Return-Path: <linux-rdma+bounces-21084-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOh8F47WDmr2CQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21084-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:55:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C45A2C26
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B22B304ACA9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5351B37F743;
	Thu, 21 May 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bq3kuVYm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D937DE91;
	Thu, 21 May 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357243; cv=none; b=RzJSPOGb607z0AiM49n54E10i9hNNq6TGsNUkZmtjbBT2uWKqOljW91HML+PZhTlSNA4JZkB9QljTHVWU4r7fE8xLGO1k6ebEGjV/gaiPJNAy+epG/cyp+dDS/1kipGHX/LCBbOPURbVaoqp5q9gKfkG3uewaej7GNK10MIsdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357243; c=relaxed/simple;
	bh=82S5qPKABfZLZNdFCHZg5I3zAOaT1wv0sRxx9PplVs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZhV+0erYilbUfQMUCqwEjCA4SAtXSKaFrLitu9wMyuQxfEHKWj0c9SK31+gq2AN3ZFL/Bg8s6kR15te92SLZozo116TECuPA5ZIS20aRUqAUWdgEgB3PGulkO9zhfyVuQKdbFzGQUWoOxZl1p9uit6YguOZzYpV3ikM0jp1kE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bq3kuVYm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6Binu091632;
	Thu, 21 May 2026 02:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	U+zHNDZEsWwX6Mq1FaTlkkIxTZNWYmPtkPXt96TI1s=; b=Bq3kuVYmf9wsPUuTR
	lVNirAU/Bw5bZTgTWrYVriNyyrokd2uj7a/ZtNtwokO4iFNnDwptjtQgdqcCkmbE
	dSIdBh71S/28GTlQy/aDKXExzusS69tkpxpUh0KjtQydbfxrbJiEzGwz6aKImFsj
	u1xOqG+1eyZlvOfiNoYFwI2sH8smhboxnrQPtDZG1jgdC3ZBC8752IlVBSlfDn5C
	PWqzJe7Hb7jWitQpGPA+9WJrQNDWDUF0J67r6rZx88jCOf85SU6ye/+3iFNZgv4m
	7bol1LdDieduEbwRRtJ4z2vLNcDLlQK1onhXiM7JaZEMf3UqEuuszsCo9/KeyD3g
	K691A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9vjj8gpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:53:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 21 May 2026 02:53:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 21 May 2026 02:53:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id F27153F7063;
	Thu, 21 May 2026 02:53:25 -0700 (PDT)
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
Subject: [PATCH v16 net-next 2/9] net/mlx5e: Reduce stack use reading PCIe congestion thresholds
Date: Thu, 21 May 2026 15:22:56 +0530
Message-ID: <20260521095303.2395584-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521095303.2395584-1-rkannoth@marvell.com>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=O4kJeh9W c=1 sm=1 tr=0 ts=6a0ed620 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=atuItEQtGSbojjJp8OQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: LomAnYFCYW5yCOK3K9ve_ZbQKwmazHpq
X-Proofpoint-GUID: LomAnYFCYW5yCOK3K9ve_ZbQKwmazHpq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5OCBTYWx0ZWRfX4jQGqGefWu68
 ROQZmGmtw4TBg8OF3iCbnz3T0vDlyR1ZxsaKCbYb4vUbpJ/CPyQqA6f559lifZd4p53gl/ISN6u
 VgbF0J/NjQbih1nLccJhDgz1IaUxzbqj3oNdNq+HskEsUgw/s53iqxGXWSZ6rt3Ey/r4tCARVkd
 wYjbB/cJmX/HSggOqkh1rkEqTdeVqQnAuWM5/FQpchlQlPO7onrPUpNNjsoPqbS4xBPMTCSbU0Y
 +4V8iTCtDBclynNRoIzxiFu7LDpXu94Xk8VmLKlxsq8yrWxWW3QQ0tC6Kaey+I7QwDC01of6m7V
 fe5mVxozPfvH6Gv1rhWIWpyqeacMfZbiqTO068yEkKcuqnmk7xXbRkfTbW+pkn0B+d/SwdgPbaY
 jPqcwo3J3Ok/nZaLCqiJjoufWTuNbBX64OTsVzTMQf22ruoXjNDbHyJV/ZENd9gFdAGP3HKfLuE
 JjrKvvbuwZU0v5hPq9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21084-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 394C45A2C26
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


