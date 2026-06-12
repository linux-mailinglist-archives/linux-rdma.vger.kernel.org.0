Return-Path: <linux-rdma+bounces-22182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uv8sLTc8LGqROAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 19:04:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B179D67B317
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 19:04:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="Dmnx0/YC";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22182-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22182-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB0253004053
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425A403B16;
	Fri, 12 Jun 2026 17:04:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943726ACC
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 17:04:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283873; cv=none; b=TzgBEKAVino0LMrjBvTUkDoOBugYVCftYjM/6yrhZlKSck7gy4Ca1pElv2iRgSu0L1yQv3qwHRAZ9GH5rGUD7Kp0rkffYd7uhy43cxdDfYmhwzo5BpX+GOOxSBze5dJZHolap5Qvoe5SANAFEuHBte1Uuq9z1k5CCnFWUt6KE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283873; c=relaxed/simple;
	bh=dNrF7Y8pKxj7yvgmndjDoSHTf7ZuZ4ST/ADfdrEpFio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvmZi32+JqYS7nxim0mMQjmyvqlbsHcRsD2EIJALJV54lSwEj0FT991y8xPKXhVhaVIATWYAJ4pFfTnO9x4/DqhPHRoAoJImt5hmrG5Vi3LAcPde3DzPPq7cEejzBNeRbbqXV9RP4eAQOtnnqbehaUXwR6lchq7NUiZWKuitz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Dmnx0/YC; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C5sXVS2701277
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 10:04:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=KEQGIb3xKN2RiIsccM
	VUCd6vHp285MKd+W+/k0aQgEc=; b=Dmnx0/YCswfvC2U105VRACXrYU4+nAERrJ
	6VOYNQNPTc5g1kvSjuHrvRBtaYu4SZJZmksQnh7Mzl8TbDXNnQ4HM3k6tpkz72JV
	yEU0eNQCV5RK+w+qEWK2DVnS5b2gmSCT/OQhvkRVPg+6JovigrGw+YpVHr19+U9b
	ubn28YmkWszgEQ3nm8fZc5KAhQiM5LeDoSM3xX95U/LoyTLW+fPdnsdhNL4Ik2Ef
	TN0C4Gq5nQ/x/IG4EV0Lldgme7Z/K+4eKLhrK30EMImTx4Nt2SwSd/OFkwkARnNC
	2af16+we+ewwivb3OsM6WNo+QKPQlpkCfnbh0l1+0rF9jOQj/IvA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4erccmuaef-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 10:04:30 -0700 (PDT)
Received: from twshared17215.34.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 17:04:24 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 002623E3FAD95; Fri, 12 Jun 2026 10:04:07 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1] net/mlx5: free mlx5_st_idx_data on final dealloc
Date: Fri, 12 Jun 2026 10:03:59 -0700
Message-ID: <20260612170406.3339093-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1OSBTYWx0ZWRfX1mTTvio8wYkN
 /FbIR1uYEBtT1w66PM6x/J8QLYSU1hkNaQy5co5olHyOWiAkZH+KkGwNi/pOOhZggZBStr3GM+R
 bfcaZfXWFmPPl0wBIptbyCgfHD4Wj0k=
X-Proofpoint-ORIG-GUID: ihcLE6mcX52x68aceLadHuRbF_MgNi-S
X-Authority-Analysis: v=2.4 cv=COAamxrD c=1 sm=1 tr=0 ts=6a2c3c1e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VabnemYjAAAA:8 a=6RAPK-_vliJErzSYU6QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ihcLE6mcX52x68aceLadHuRbF_MgNi-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1OSBTYWx0ZWRfX62ezWn1Q8K9C
 GWH/VIYKIzwu+gIBUqym1s0ss8PuUGmqk48GynKKfNydregUohC5nw8OmKZyqe4ZYqkafjyNNW1
 Naug0T5LrknVdLyeFDLMfM4KaBXsHGmFuRJT0lmka6JqJo3mDlHLj/bqXMqVhP5TBInBKv3NN7H
 xk95CQIv3EkElqLA7DPNofd9HAGq4pc1NIC2k5MiM4xeKs6SN/WObL2WwneJXOigJk1L+uD30XP
 2gLcz5D+54ub/p/gIQ7FDgZ44qVzYxUdbaGhdHxI/GuX2r8H8ZYsnTzPSl1/T/akWWIX1a7L1QU
 v5FwGCadviFicXrZoBUmrUJchLWukm7uC7vje6Cj4GjcGXAXtc8KR9VSbIIY1emT5TOWw3pcBjM
 Po7yCH3PiyX1TMEg993nmvNk6XpCtikYBPDlKDyxZsV1SbZ8GMBIRaoL/gkYrkWZ8qBibxyqUc4
 8bIKe4Yl1dpQb8nRaog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22182-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:yochai@nvidia.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B179D67B317

When the last reference to an ST table entry is dropped,
mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
therefore accumulate one struct mlx5_st_idx_data per cycle.

Free idx_data after the xa_erase() so the lifetime of the bookkeeping
struct matches the lifetime of the ST entry it tracks.

Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..7cedc348790d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
=20
 	if (refcount_dec_and_test(&idx_data->usecount)) {
 		xa_erase(&st->idx_xa, st_index);
+		kfree(idx_data);
 		/* We leave PCI config space as was before, no mkey will refer to it *=
/
 	}
=20
--=20
2.53.0-Meta


