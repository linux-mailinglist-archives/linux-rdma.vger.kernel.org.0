Return-Path: <linux-rdma+bounces-19138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLeLDBUV12kSKwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:55:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A623C5C52
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 04:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C148307C22C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97336E47F;
	Thu,  9 Apr 2026 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TzcZC6Li"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B0363C60;
	Thu,  9 Apr 2026 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703096; cv=none; b=L31tIvhYRWYoa4Ek4dx08aVjAHMcYm5gZNNakf8Iv5ZJSQh/snfbnQaH/T9kTkOCU0XXg5GRrxN8Cz5vHE8DmqgTOuwcCtJthq7DMZvNSqs9pvKgZRrS0qpJdwQaJomyqdy7bFOGyvOP8Zz4M88scd0e110OUb66dmo7yGgglhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703096; c=relaxed/simple;
	bh=bku4H/UZEGyHFNNbB/622394p04bXiZq69x3ssX7pBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1wdNFE5w6UKcoyNpmdXsbsidd02ejR9SR1uhfbIdWjYC74T6DRMO1P+MspelzzAg0aLRsvtxzqK+SRqghpGSn13o0Dq/OcyL0T+4TM1pjUj/9YBh2CRFEMIF8Y2udFQUmK4IO5jEycDkQwFLbEamRB1iZ54PVxwBHWJ07WITQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TzcZC6Li; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NZmAJ2130824;
	Wed, 8 Apr 2026 19:51:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	L9edTtQ+I8yjFW5xTW3OLUVfsJ015crBPbFIlBj9qU=; b=TzcZC6LirTV8phCqM
	SNdnu5dvQAgO4xh5IPTbFnnpDk6dvjabE10Tj/2UAnVkGQb9dBf1FYVX8+w42cHa
	jmBvtDXfHi6lGI9/lBj7vPH4XA9fWi/XzvjZRJ1hrFDW6PLOcNGzTJIk6gH8G+4t
	vZxYw8UySmFMwitAuoGY0Cz2QxSt2/MrXbaeH4JQ3SlD5l/yK4Yc43SvdGQKwzMv
	66M7Ld3oFB0x8uZf8ljpaXuOQUQoCy7pV40QkWirmKX12X5//9IaEXGA9e9kgncn
	WbY/NQd/xDNmsaFi2LPtO6P8GBCfkhblAvFX/fksgFE00bPitTVB3typZPz26ytC
	Yunmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4de0u40b65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 19:51:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 19:51:21 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 19:51:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 19:51:20 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 628FA3F7055;
	Wed,  8 Apr 2026 19:51:14 -0700 (PDT)
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
Subject: [PATCH v11 net-next 2/7] net/mlx5e: heap-allocate devlink param values
Date: Thu, 9 Apr 2026 08:20:50 +0530
Message-ID: <20260409025055.1664053-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409025055.1664053-1-rkannoth@marvell.com>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KpN9H2WN c=1 sm=1 tr=0 ts=69d7142a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=aWKQy79EXxaKdZR1qOkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 55a1UyUvQqd1LmMOeFFaEqMGAOA77sCq
X-Proofpoint-GUID: 55a1UyUvQqd1LmMOeFFaEqMGAOA77sCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAyNCBTYWx0ZWRfX0PNc0M5ZTOar
 B1sOPQ8JLU9lYgYlngK80i178NpuounK3Gu2l68KGTL4WEnGASsVK+0Ypdh+jQP9IVxEoZwrHFg
 ewGdKrdHc9F8XUHVCOON+NgETDYPIyU/n9FWdo1RsFhWX2l1k9zCTU4dHGSxcUBKlDp9/HDxsji
 NNEpkqZ9qpAeP3R8WeoIMExp/Wu+kfrTLdRSjirp8ZIIljdav0zzjcVs+S8bDWn+VVbUsWJcbOG
 f7PaFs4CHCUne6cIVzBcKKNonJO1cknK69UsVi4GjTvac7GnkyW2up59ag2uLTIYz7nAW/G3wub
 ZNysRiFgOGhKNfmWcglC0Xz+W/J9zgjGKVJ76gI+0YDGtgD8xk2Sdl30aw7SKj56onuGBefMeeq
 uXeG3mudcXiaqK8TUJG4JUrIUVnXs3UH4SaL0gLbQpXYF4N7FqyqH1xc1IafLTpgYcxA+JrPPXy
 lLCGKEIH5Bkqo1y5Mtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19138-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E7A623C5C52
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


