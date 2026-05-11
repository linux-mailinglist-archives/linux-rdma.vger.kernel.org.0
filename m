Return-Path: <linux-rdma+bounces-20343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEHrHS1QAWq+UgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:42:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549F507B79
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B427830378B7
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818537CD4C;
	Mon, 11 May 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="edIl0DI7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84537CD53;
	Mon, 11 May 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470823; cv=none; b=tVh9W83/d4MPz5d9AqqM1laxy5GV4sjwYDEclW/FpFNun+yTzpEUyF74D7IGGGjl/UpSHi70WhdBALDWUdICwXILhkvO+71QTMS5o79YtOsXqZK+BBcWmkHIdyzXnkRfVxbLMJv+RmHq9ON4ce/6lNPdgaIr1gAtYRommihqg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470823; c=relaxed/simple;
	bh=NbAHv+xyR75ZAGTPldMCMUgj5d4PXQun4eKw1CVd3Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/jq3pqdGgPnOcrPOTVIDNPzcy4TcXZrLdHQsgQT0kJ8GqypFODd8Tx+HtzO6XbP5Z6SP8bCRIrE5+tXnxCDXgLNGeXvy8psBTjzNMxqM8qfFY0kxqIExao3B42lVFEiTM/SBhtTcjgqhYqFo23SnKuBR4c+ApTGVxaqISG5ySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=edIl0DI7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANpOC92290298;
	Sun, 10 May 2026 20:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	tQPsk8Yutx2f1aY/LRWiptkFNlDzHHUMyxmtJ2w05A=; b=edIl0DI7zUwfryXle
	IgoAQja9pfMqM8gE7m813Vv4pBB97fJZxnqe7av0PSv2tly/mh4UYS1Z9xGDL5X1
	tpKPpk3ZLyfOliGofwVmJw/THyA7mZjBwJroD6ynBz7wAQnQ7HiDOIsiWFIvmhtL
	fleDiYJH5Ej25HI4OToGQfMEGbSo1see/pN+r5t0wMjkDEvgNzsqwqPNnv9faogK
	KkXhe1LWe9xuo46GfhlOFi0RtzPIvz1XaKEAtmuwDFPtT2ilr2+Ldx5FkOE9jtKL
	NVyuUB3EnF9Pfhw+T+HOwvSx2FeNFquAY5+/kT8UnABnhizKHn13RgBJvcrUb4Hx
	sMZ8Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e2s68s6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:39:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:39:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:39:57 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A7E365C68E1;
	Sun, 10 May 2026 20:39:48 -0700 (PDT)
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
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v13 net-next 2/9] net/mlx5e: Reduce stack use reading PCIe congestion thresholds
Date: Mon, 11 May 2026 09:09:16 +0530
Message-ID: <20260511033923.1301976-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511033923.1301976-1-rkannoth@marvell.com>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -q_YCMYVndZeC9TxClTSYuUYDDZ7XZwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNiBTYWx0ZWRfX0REPMgrZTaL9
 F2AC/QXmrOWFW0mkp8UId8SCqU6RGqdxjkOQCqkd9UUzHkKkzownsRwjS8C+x9D6+N7nMnZEAHR
 a1M19rjy2Un+8ngmK4bZ2iqnF0XdrXJKxCYVqTqHghMoBNCEwJV9cSD0ZuCUFirqbIY4mmzeV4t
 5PSJ0tjuOiwdvChLxhsgKPoRQKZbC7YWAcy4DMyUKopKsFS7lWcZvDskUA8eQiMnVo0bdSwiqLZ
 nQ0vT4I7XQyIrpbjrp2hwc52muY0/25b9i0Ownnqvnt/76WX+o4atktljMS1dyXdkTZsPx4+s26
 KJfu9I2Ew5JX2BzdLs+JcBCEwffzCGw143CufeP8o1XfSWppBFN+eVX34pk7DxT5/pmrpgQrndt
 NqEKYpFrUvOWibDUxf2LbrNbKUGS8yCtnSRRXq63D16XQe/JObRr2kyTpEUOwvtdsnLdrr5GG7/
 Gx2nOTqgj2U7cPCxvLw==
X-Proofpoint-ORIG-GUID: -q_YCMYVndZeC9TxClTSYuUYDDZ7XZwq
X-Authority-Analysis: v=2.4 cv=Y8rIdBeN c=1 sm=1 tr=0 ts=6a014f8e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=M_3JBKSTiQx28Y-0IcAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 2549F507B79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20343-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

union devlink_param_value grew when U64 array parameters were added.
Keeping union devlink_param_value val[4] in
mlx5e_pcie_cong_get_thresh_config() exceeded the compiler's
-Wframe-larger-than limit.

Reuse one union: call devl_param_driverinit_value_get() once per
MLX5 PCIe congestion threshold and assign each vu16 to the
corresponding mlx5e_pcie_cong_thresh member.

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


