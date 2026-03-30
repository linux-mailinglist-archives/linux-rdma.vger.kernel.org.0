Return-Path: <linux-rdma+bounces-18777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIBvKM4LymmL4gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:36:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244F3559CC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 07:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847F4304E736
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 05:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94856382381;
	Mon, 30 Mar 2026 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hbIsQLgY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F44381AF6;
	Mon, 30 Mar 2026 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848735; cv=none; b=FdZ3nC1F2X+0a0ej5SyCLpIyhQROduG+IAX+GVDg+RlRT9QxIcrCwqFTqdmt2WQnKpKi8p45X0XDWE86A2dpo7XGpyGj/a9+e3U/vQZLs8W2CQ4GRJiYOp0eA0Dfg7bB2WJxZBvL6pL2nsOpW6XHLh9uNZ9jTlf3A5E2hNeaTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848735; c=relaxed/simple;
	bh=bku4H/UZEGyHFNNbB/622394p04bXiZq69x3ssX7pBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO0t3hLGmb5Wcezf5JHRzcSS2bN0uTkMF02IxuelKpKGG7GBXD/slLDkcicpatUdzvQXXUPmmJVq0NuwDMGAHaVEcPsVYDb2KzgwkFtJ6nMql0F1ZJa8veYKc4s42GGfZ/eNKmyXR+/xUK1U7gUaTGr8ESVwpIv2xarUL3yGCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hbIsQLgY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNvAHj301870;
	Sun, 29 Mar 2026 22:31:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	L9edTtQ+I8yjFW5xTW3OLUVfsJ015crBPbFIlBj9qU=; b=hbIsQLgY9KbJMmY1r
	c98gh6g9za1qmFv6sguhmFy77jGPY+b1+b/pcZXimZzCGvuOHNh5X0+SLQBap01U
	2v/eCn/Eameu8oB8YT3YpSf4HRIZ6Lk1EeQFeUzKQS2nDx+/JUSa5jS9FzoeS4X1
	sRfA8Wis0Zzs92xEd+4ATc/QMN57k2AXWF3ez5QnA2MiPauDeG5mPcEd8KrKphOD
	hhI0WZ4GDCWye7ifjZXVUTaPKYjG3MZAkBEPFWisGRRwSHAAsXJ+CslucYrluij4
	X2vHpE72JoosDbzLvZLRfozldm1wjZ8P9CSdkYY3NqD6DkQlissmcyakdhtxvKX2
	36c1g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d6cbjtxm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 22:31:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 22:31:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 22:31:53 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 852623F706F;
	Sun, 29 Mar 2026 22:31:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC: <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <donald.hunter@gmail.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
        <mbloch@nvidia.com>, <dtatulea@nvidia.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v9 net-next 2/6] net/mlx5e: heap-allocate devlink param values
Date: Mon, 30 Mar 2026 11:01:01 +0530
Message-ID: <20260330053105.2722453-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330053105.2722453-1-rkannoth@marvell.com>
References: <20260330053105.2722453-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0MCBTYWx0ZWRfXzvfcOb5/8U9A
 L9k2Izgo+aVSwPM5A/NkfbbVZ83fU3nMbNk63BXXm50YLFy3o2/GPA9WdH5dYGNSEUjkPC9juf9
 hzVcP57xlUy7+bnwvKT9Fdi1cvUCheNQHxlQ/Eb5uvS4G2obTDZSEZwQ61dHabHDKRU2A1mKrL9
 R2ELxsTwenQU6hlcrUT3eivYipUNaTz14twuUrCp3LU8LX4G/CYGdeZgfBxRAOKABGh7PzzFBQi
 KNXeiXKr6kDiQ2J0rgUdnT+kLvOl2Jr/BJzcHmmjjMOYg04rGK545S6hTtoghUMsvRYCkrQKod6
 nMk9DVsb16CztPV78NXZIIC9FtMVP2Q/Bf4LxWel39Dd1TuCe5dI1chF3zs2nOOxpveUbUqdpFm
 4Y8RsAOU5vk2vRnpGwLobcFnaIXXx4fKsZ5hayNZp0YCZPU19bXD8KNcZPQaxNSDPgyXVn8Q0jE
 dEjkeWVXpB+enDGdM2Q==
X-Proofpoint-GUID: XDhUNycHe1W382U1nYZkqAi8dCYDhS4e
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=69ca0aca cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=aWKQy79EXxaKdZR1qOkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: XDhUNycHe1W382U1nYZkqAi8dCYDhS4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18777-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4244F3559CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

union devlink_param_value grows when U64 array params
are added to devlink. Keeping a four-element array of that
union on the stack in mlx5e_pcie_cong_get_thresh_config()
then trips -Wframe-larger-than=1280. Allocate the temporary
values with kcalloc() and free them on success and
error paths.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/mellanox/mlx5/core/en/pcie_cong_event.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
index 2eb666a46f39..f02995552129 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -259,15 +259,21 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
 	};
 	struct devlink *devlink = priv_to_devlink(dev);
-	union devlink_param_value val[4];
+	union devlink_param_value *val;
+
+	val = kcalloc(4, sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
 
 	for (int i = 0; i < 4; i++) {
 		u32 id = ids[i];
 		int err;
 
 		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
-		if (err)
+		if (err) {
+			kfree(val);
 			return err;
+		}
 	}
 
 	config->inbound_low = val[0].vu16;
@@ -275,6 +281,7 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
 	config->outbound_low = val[2].vu16;
 	config->outbound_high = val[3].vu16;
 
+	kfree(val);
 	return 0;
 }
 
-- 
2.43.0


