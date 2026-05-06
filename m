Return-Path: <linux-rdma+bounces-20058-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKkkHRgF+2mbVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20058-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:08:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 012834D859E
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE8A3001D51
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED73E1D17;
	Wed,  6 May 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojTA84H8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA13E0238;
	Wed,  6 May 2026 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058515; cv=none; b=gWQLREfchucfhOzBrhBrL61Q/DozssvpXuzNleApOgV1oASzGSpmv+zkGI+uc63TtINhUGpRTFgY3PWJUbgczO5PpWeSJRjrt2w+5ZxBOfrTtuScs+khncko+F1qZQ1Drj68/9uz6WJS3+tAyUytiOVVAZNku4Gt8v5o0SBi8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058515; c=relaxed/simple;
	bh=BXiJ4BzMgOuGNvk99xYwfHdnHsXYWpnhunlvgmKzI14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxRgQ10AxCFEBQ57dL8+4Yp8Z+BRMLA4BQg8hFqS5LGqvHOWfKx2Dwu/RtF/hJaapFgVgTQ14408avuUX9KJ4e0xoecMK38gK9pKKMJzZjBtYE+gvCgBcatUgq26SERe40lCdh4gAdrlNXJ1vJKFEY7JyCmbXiaTQxoeHOZwObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojTA84H8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645GumlO2664817;
	Wed, 6 May 2026 09:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9ViN0rAiU9jTSRDwLbbp3PB6iid3m
	a/wqeThDhJiueg=; b=ojTA84H8HAv11lR/N8ET+vNjyP+jSmEUVaof3fMj9JgQ+
	86cMBXjPX9+rBG3RlJRQsHOAbLZUSwh+YE6gHXa57MZPpnzsY3x1EVLFnuAuK6HJ
	aYLGbm5EeP42zbXfpqxCkzoHTerCjXKRx/YunVA4b0EIRD04mrT+dWY1IupxZVfy
	l63QFxk+eQPHl1+mCy7I1zyEVtTVJusD6VI6ik/jSXL5DyI7lLtlO9jhsS0NMEh0
	FJPgF9F6S43BuXbeU0aYQC9Wxv2CBktVigi0RFahq4ca0ls4fEOOQdNiw5Ckpdl+
	JfI07ZXybuqE4cp+thoCPXYKL1hhcQWP7H34wIcmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9tqxg89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 09:08:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64691SkZ026147;
	Wed, 6 May 2026 09:08:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5ag5wux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 09:08:27 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64698RlR011419;
	Wed, 6 May 2026 09:08:27 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dx5ag5wuk-1;
	Wed, 06 May 2026 09:08:27 +0000 (GMT)
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: yishaih@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anand.a.khoje@oracle.com, manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Date: Wed,  6 May 2026 09:08:24 +0000
Message-ID: <20260506090824.359239-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605060088
X-Proofpoint-GUID: d8Q1y99oKGvCUMT9NfJpfOJjk_EFtpI4
X-Proofpoint-ORIG-GUID: d8Q1y99oKGvCUMT9NfJpfOJjk_EFtpI4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4OCBTYWx0ZWRfXw67yrJb7n1/N
 CGVo0s3cy5PQuW5V+qsEEmvLHliX2h7TD0aItHDYnnhpW3j9jv+svjGx8EIMLNfrmISljrQ3adY
 Ru18IklGdTo/l/VpQJbvBW511f3mOb6seiPuzHLBJrU6rJpuw9hVL2zL5FaCiVZZtjjyey7gizi
 jIhojP1KzSBc6U2G99kog0WHsYVohyGDXfl1TdXXn45ZNufERMTnYHOvHqhywCiXRuXLVYNu4q/
 YNos5f9/P5wk1bLlkIIDA0FDD5HDpnQQb8yAGcga8pVAfFCiB8CU5nTijGP9pua3rXmjo0gIAhl
 N57pGxneI7iwakTVLNzpN0tM47lYjQ/Dx1alU4SOePmwyb8uwV32J5x35qP6rvZEf7BHVzXUPju
 TZzyE/kIYeYzLxI7ZcFXuLyy3DfEYvkkpatqQ04aLqgIAX0jyJwQXygLVjaSOUsi/yrpESv9GUZ
 sJbCwjTJOYqSdvKqFbO1X1gCFdqclK+q5DY+Awow=
X-Authority-Analysis: v=2.4 cv=Os9/DS/t c=1 sm=1 tr=0 ts=69fb050d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=p6uiAbgbNkGtp5oC6u4A:9 cc=ntf
 awl=host:12306
X-Rspamd-Queue-Id: 012834D859E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20058-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

During scenarios where a REJ is sent after a REQ or REP, the allocated
is_map_entry remains in memory, resulting in a memory leak. Scheduling the
entry for deletion during REJ handling, if it is not NULL, resolves the
issue.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 63a868a3822f..21f2f401ed61 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -321,10 +321,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 				__func__, slave_id, sl_cm_id);
 			return PTR_ERR(id);
 		}
-	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
-		   mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
+	} else if (mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID)
 		return 0;
-	} else {
+	else {
 		sl_cm_id = get_local_comm_id(mad);
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
 	}
@@ -338,7 +337,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 cont:
 	set_local_comm_id(mad, id->pv_cm_id);
 
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
+	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
 		schedule_delayed(ibdev, id);
 	return 0;
 }
-- 
2.43.7


