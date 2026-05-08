Return-Path: <linux-rdma+bounces-20207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNQME5Nd/WmLbgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 05:50:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED974F1463
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 05:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8C4A301062D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2F309DB1;
	Fri,  8 May 2026 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gAy6wfkc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75B155757;
	Fri,  8 May 2026 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212240; cv=none; b=snc3HJGFv91mbkNaUqmb1Pd+BxDoqg/ZxutUM+tAhnCa8Fv7PUTWXEEwh8Ky3IGSXPl4P0zPoCHaq+V1k0CjhBfLalGXUky4B8J0nugHDgfC0gQ0Tmcr2U4yaskyLe9sKvi+3DReSJxfUf3pfd5VaBQ/X70tZUoal0JN7ad013Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212240; c=relaxed/simple;
	bh=XWS18EKv86wwMpp2fyU5MOzJjYNEwOHHo7sxEv5SAbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUYVcHiSsr+l+hrig1m3xP+t2ua1X94N8a9fQO03/wAWOoVuvyXDAj/nmzvVXSlWFNGg4T/vFeJ0rWdM0Zhx/FmF7MPmQnkWo2tPMYATMG+XKpfKmd8u/73cKKXxubFle5ITle/C0ecJUVSi5X/xNNhJqYIAWzgdtzHR1dMsL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gAy6wfkc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647G5m4g2850767;
	Thu, 7 May 2026 20:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	NoyjCcOt9iCXEZtiOjB9y5jkpJj2m5Kh9tPG4kCON8=; b=gAy6wfkcAoXTC/bZs
	ied3LxcaJxjNTXdOMSJ5hachPCyZpZBUZF1jR2gU7Mp8cWmtEGlTeepZCdwUq98u
	b3/noflsIz0d/ihXC0BM/Jk88PjPV2gueqEFQSRUpyvvSGbB+dmVfRmuQVEMVFnY
	NRUYWTQGoEc4eZlfUVWkIbkZ6jCaG8wWIt3TFGZQq9vdxeKucohvvvVmNQuIrBht
	BM4E3ROFgNUKxtvNFVKYxLeckqxSa+op9l+Cr+TkPKAePJPDyr4oZev5f3dW7sr6
	n8Ghu3Fo4+1BHNP2fv86ABPp3cS0kDcSMGn72SetMQ5RQ7K1yy9dy5p0f7ocKqBB
	m0YEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e0wy29qgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:49:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 May 2026 20:49:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 7 May 2026 20:49:51 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B9F193F7041;
	Thu,  7 May 2026 20:49:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oss-drivers@corigine.com>
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
Subject: [PATCH v12 net-next 2/9] net/mlx5e: trim stack use in PCIe congestion threshold helper
Date: Fri, 8 May 2026 09:19:05 +0530
Message-ID: <20260508034912.4082520-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508034912.4082520-1-rkannoth@marvell.com>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mIZUNbQgqFhIKvwAl1gsnIIP3dR0l610
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDAzMyBTYWx0ZWRfXytgNrDRTptqJ
 nsux18mdiNswztiaGb87eN2rVJ4yMhSOyXZwu5m3YGwLJnCZsuVY1TuNnmXj+r2dc/VectyfntT
 Z6Zxon+0B7BAyihibK+74825huMoSVu+BHOonXL8O/kHj6a4Po5qfXRyColfGYqMW0NhAoBjpqw
 bXXTV/kPmvIdprpjFvpHGsoZljQLqARVCq4PJS2cRxeOUf/4bifLQgrfZQNXwqN57HD91QyIRAu
 seHOJ/VjNL0+ra1iFoH+SUPLcR5eZy/RgpBATC0ECJnKE8s9MELlDOxyiayYEnB6jAQlrOCIlg5
 LpNHINbDXGVlF/WrzvdtvKrBiJRoVaFDVVNqeVoNguwb6bpXQdZxUAgJvMykNvfwQ+iNKEar+8i
 8CVOfnAUDd61U2u0knmUfGk2j9JU89Ed8jJ5mYfpaGwqkmJPxO75KKVdi30GG0KadNxPhzPGmGH
 pg0Ow8e5PRozoLc7mlQ==
X-Proofpoint-GUID: mIZUNbQgqFhIKvwAl1gsnIIP3dR0l610
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=69fd5d60 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=YjTTaRMW2Sk_qnKZcsQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: DED974F1463
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20207-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

union devlink_param_value grew when U64 array parameters were added.
Keeping a four-element array of that union in
mlx5e_pcie_cong_get_thresh_config() inflated the stack frame past the
-Wframe-larger-than limit.

Read each driverinit value into a single reused union, then store the
four u16 thresholds in struct mlx5e_pcie_cong_thresh field order via a
temporary u16 pointer to config.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 2eb666a46f39..88e76be3a73d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -252,28 +252,32 @@ static int
 mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 				  struct mlx5e_pcie_cong_thresh *config)
 {
+	enum {
+		INBOUND_HIGH,
+		INBOUND_LOW,
+		OUTBOUND_HIGH,
+		OUTBOUND_LOW,
+	};
+
 	u32 ids[4] = {
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
-		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
+		[INBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
+		[INBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
+		[OUTBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
+		[OUTBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
 	};
-	struct devlink *devlink = priv_to_devlink(dev);
-	union devlink_param_value val[4];
 
-	for (int i = 0; i < 4; i++) {
-		u32 id = ids[i];
-		int err;
+	struct devlink *devlink = priv_to_devlink(dev);
+	union devlink_param_value val;
+	u16 *dst = (u16 *)config;
+	int err;
 
-		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
+	for (int i = 0; i < ARRAY_SIZE(ids); i++) {
+		err = devl_param_driverinit_value_get(devlink, ids[i], &val);
 		if (err)
 			return err;
-	}
 
-	config->inbound_low = val[0].vu16;
-	config->inbound_high = val[1].vu16;
-	config->outbound_low = val[2].vu16;
-	config->outbound_high = val[3].vu16;
+		dst[i] = val.vu16;
+	}
 
 	return 0;
 }
-- 
2.43.0


