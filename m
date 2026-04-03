Return-Path: <linux-rdma+bounces-18961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOnsNrUsz2k3tgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:57:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0D390847
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 04:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B08302BEB9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45334BA57;
	Fri,  3 Apr 2026 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JkFkyMCZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744533F58D;
	Fri,  3 Apr 2026 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184974; cv=none; b=AfHW7Ppoz4WTsueZVmO+IMqxN9NimdbumkHEKHlry1wuGn9KChNLo8N7ZrK0JyUBvcnW7n2kv3LDIjlwKur468gpSkQeQb8BNCTijDiWMzJ0nirzmsI1FkB0/tjfYCFBucX+A4fQmmUNu4/TOTm+k+Ngoa+uS0h02ijtUhaqUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184974; c=relaxed/simple;
	bh=bku4H/UZEGyHFNNbB/622394p04bXiZq69x3ssX7pBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY4cyHkJ7RHlgnWjulPsgCJ04oHrfrTAimdNNhT1jVx/3zrT/kYfYbx5qAJn0aJLlqW699tEtlDGKssRGkAcFfv48Jbka6pitSXWDNATkbwmcL9NWz9dd4VwqeDctYYj989vSIUmOyfp8d7vtcJYV4HR4/Y2n4Nq+s3hjXZNodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JkFkyMCZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632GBmNr1945692;
	Thu, 2 Apr 2026 19:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	L9edTtQ+I8yjFW5xTW3OLUVfsJ015crBPbFIlBj9qU=; b=JkFkyMCZzs0vIX+iV
	j+IsMInDGcnvdkRYdb06WFXqEJM8w4Duqv7R90pv/ApntC1IobtWoBRzvZSVfwt3
	QNAv/ffG+YzdRpsGs8/DwE+gcYTmS21ePUofEI8NB8bereCeAy7AYzNhB11xxV4w
	ZoAqSsp4UkgKy/1YpeMvzLsoUc0fto0TfZvYKlkyv+rI3wD9DW/yynoVv0aMK/Y5
	45hh7dQrsjyGUevq1EKuHOxHuCmVELGSQYGgwnM7AM0cTOhTMe1Rwbhv2zWk7nFE
	+I/Em27MWFyuu/ryKH34Rq59sqVIwX+lRBc3qRTqFW0WETqKPHZp99v3SY/DakaE
	Ss3dg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d9urtsk62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 19:56:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 19:56:02 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 2 Apr 2026 19:56:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 2 Apr 2026 19:56:01 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 680643F7051;
	Thu,  2 Apr 2026 19:55:53 -0700 (PDT)
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
Subject: [PATCH v10 net-next 2/6] net/mlx5e: heap-allocate devlink param values
Date: Fri, 3 Apr 2026 08:25:29 +0530
Message-ID: <20260403025533.6250-3-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403025533.6250-1-rkannoth@marvell.com>
References: <20260403025533.6250-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8GYJ5CZcgLtSrfe5CBAFCQgaG33_lLIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAyNCBTYWx0ZWRfXzSCoIrZqeeCm
 7e+ZEXwyn2JAM1YFU07pbQXhfnLVnrJj4QmIqLG5b/aKA45mUUFSgEORVzBPrfpPAzsKjPjts9j
 bAZ7iCNlnrms0nCyWEwrP3Byn4Qj/iI62YxbqfFHvODvMelFAkc6UuuSz4DEPRjEwjyowQgWYEP
 XMoP+7PAw1AOiUR28p+B2tJorngxjSq487Dz55BVw/5CiyD9nhNNHpu+0N47cxT4u55iJ/JyTnH
 l4BkD2ECLa20xY/XlMnIkcNZdeFYnCva443s3UGnMH7+5Qh8Eie0dyMEyc0FscASoVEVkcLGYkH
 8agCO2CIfWBdEzezNEGdUJk/igkKhdaGu/YwQZ3SLIEWc3BPRSKQqVNHvLBNymkq/gE7W392TR5
 oGzx1jpR3izDR7IEI3DHH8UuGslhoiAYyF9iEed4VJyQA1omptOV+DuQm1n29Rmjvqx17Ubo1Jf
 ZDMDh7xP9Ur3IJCJWMw==
X-Proofpoint-GUID: 8GYJ5CZcgLtSrfe5CBAFCQgaG33_lLIh
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69cf2c42 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=aWKQy79EXxaKdZR1qOkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
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
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18961-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3EF0D390847
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


