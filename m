Return-Path: <linux-rdma+bounces-20653-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK7nKG1rBWo+WwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20653-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:27:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9853E4B1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C961730209D1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBD3C5DCD;
	Thu, 14 May 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d1LsqvPu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA963C4161;
	Thu, 14 May 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739994; cv=none; b=ijH7EuUMgdf+guG8PbYWAQdXL7xzHcbE/wvcXVWgiTi/ZN1wRCnbd3Quwa1ISK0DfeErvVP9guncalhkIvxQQ885Eq16OnFMN05LsnPR4enKytAPs1W9N7cSnEEcvMGcoD85pMOiPnQUfoXzioLZUKIPCb67EPNvy4wSm6OtLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739994; c=relaxed/simple;
	bh=82S5qPKABfZLZNdFCHZg5I3zAOaT1wv0sRxx9PplVs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNGL/Lu3J2Oq99xBgjB1J6uzX8UQJ5psgsqZ7s9RQqD+hwkMyjmHd4m1/avHoO/5mm5vhKQzlYPUA5A1rKw6EC8F3TpIPXWGWbEV7Tm5ok6+ZZFY0avRd7SLz16x9spctOcvJWc4DO0qPnZUdPwm4ULZELCOp2EB4vIrxqwV6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d1LsqvPu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DK6Hbj1320187;
	Wed, 13 May 2026 23:26:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	U+zHNDZEsWwX6Mq1FaTlkkIxTZNWYmPtkPXt96TI1s=; b=d1LsqvPu8517SO/pU
	+BQy3cisoAMqqZHEZhtO3h2WJionxuOjq94p76dvD/6it+pGignhmhcPyOxOnKDL
	ziV/K3Jvu7Ak1YkRAGDU7JPmZnS8hsXu0Ztp6nQswnEQ+ZEnnyi3Uli9Z7VZOCSm
	7VwoNdOIolLS+K2AuoTewQzJFyxjOE3aPugWkbXNYPAEek7hntuy4qtI/5LMMYWo
	cNzB4Up0tmjveOyysjlxZeZWNA2fItFx6GgqwVHW8yftpLZRSjjBVu750nAgvk/v
	yF4m80BI5xnjJlc903NgujaEB7pj5qK+L0um9C7OFy3lqFXdwYbx6D18AXtK9V0p
	6bxDQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e4neu3dq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 23:26:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 23:26:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 23:26:13 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3022F5B6943;
	Wed, 13 May 2026 23:26:04 -0700 (PDT)
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
Subject: [PATCH v14 net-next 2/9] net/mlx5e: Reduce stack use reading PCIe congestion thresholds
Date: Thu, 14 May 2026 11:55:30 +0530
Message-ID: <20260514062537.3813802-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514062537.3813802-1-rkannoth@marvell.com>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: StUO8JSfqVhyNlvUq7XN-yHeBBRdbBiQ
X-Proofpoint-ORIG-GUID: StUO8JSfqVhyNlvUq7XN-yHeBBRdbBiQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MCBTYWx0ZWRfXzFPoh4vTg5q/
 xq/N9CQCQahlSaLTYbB8yVuZkm3dpen63O6D7+Pk0fg45/1fGJxeYqu/LwRZll0paF3N2fxKqTY
 6+nnf3xEoWHoVV24EqZs5S2zmNyfrFZcn3o17dxKtAdZ7y0ZGdCJMr37wccZ08nCTpB8uH/Oh5r
 yi6Hgy9v3CdhtGYnrSJV+IETcUxyRk5FTqihBZAZfsvgfO0ztZEATa7iYskdI33ATPk6xabpkX2
 DNAVDT7Llv2KXZwey7vh59x7CNxlDnsZOZj8p3T77ymTmCDK98VLuNHqUm8vBvBdO74/N/uiuQ4
 s9LAnaQSkjD19IL4jz95/xLf3SmgXqTq/BYUN2DCLRN3bOoqcD8ZZ7cW8sK/A7PB9MQUX9u1/iY
 VcuazU4gOWc8VSk9IhZyqxTZaToQorxAvHZ5qfenJQHW+4JcCvvVvOGT431exrdhT7zTNyPswSI
 G7c5BBu1KBQpzG4GQ6w==
X-Authority-Analysis: v=2.4 cv=f7p4wuyM c=1 sm=1 tr=0 ts=6a056b06 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=Ikd4Dj_1AAAA:8 a=M5GUcnROAAAA:8
 a=atuItEQtGSbojjJp8OQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 4ED9853E4B1
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
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20653-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
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


