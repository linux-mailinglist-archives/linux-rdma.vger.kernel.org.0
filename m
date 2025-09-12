Return-Path: <linux-rdma+bounces-13309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34BB548B2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD331188C773
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7212DF706;
	Fri, 12 Sep 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWDQhmAe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394612638AF;
	Fri, 12 Sep 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671537; cv=none; b=Y+3AS4CtJZN1fqwzC3py//3A2yIIA3SG7Jk9jU5A2mesSjzdRZyzbKrOymaJXBGns5shAH/U4bg29jGx4awYObaZJtfxFarOY/NTeLueOV1jQA9aEEdidYfWWutC+FKNpuWeIdtVlqcE/X/xCzgXGkQah/M5sKVtHdFURRG1I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671537; c=relaxed/simple;
	bh=sFfpY6YLi6EwMWkjv3r0+rKPzB9T/5wsWY1QnNZHvpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mgb2KAjn4bxkD23NsKX7AFJXvVH2VzjoWbiTlbriCo3D1OkC53qWy6QVXhHDs5vrqo019BxX9D2nfIAc+TqgZjpYjk3BXX9H+39auv3FUrKoqwMmwwYIBDaGvxFMzDYjubOW5RHI5mZYZQeVdDLQ5gPlCy+hIUZZhHQLzP0z480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWDQhmAe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uB10031040;
	Fri, 12 Sep 2025 10:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=75qm33nB16xVCrsf
	zn2zp+tyWmB5WaWiELlJA+F+cM0=; b=aWDQhmAexjoIDu3rh3RsjvC2PVX3/ueW
	OmP6bpJDsfJ7Pimq/EBLPraaJRTUKArfhUb+PXrhj6UGbn+d4mdyy68v/FuaOlBL
	T7UTnBY5oe43p+qWlhsTIN/SJcM3XH/Wr+6Re0pfpJFSDpRuzCZQd4HjdgGAMfmc
	yObVqu4Uxe5+7a9bDOBIm3ubDAh3qNtYM1ocUZGkHar/VFqQ6QK4F9zYpUDnOwvL
	nhPgKzlABQ+tD1dJZJiSQoFcLL8oTm94n3U2W2cmWKEx0GFY9AHlNkt2sbJyt1Xq
	99dWoi2mE79MLqBEIpwnFPmVqzncGueDNmtX+M3NdlVL3WEMVSlTjQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x97w91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:05:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CA25ng030667;
	Fri, 12 Sep 2025 10:05:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddm7er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:05:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CA5TXc018905;
	Fri, 12 Sep 2025 10:05:29 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bddm7bv-1;
	Fri, 12 Sep 2025 10:05:29 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sean Hefty <shefty@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jacob Moroni <jmoroni@google.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error message
Date: Fri, 12 Sep 2025 12:05:20 +0200
Message-ID: <20250912100525.531102-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXzBZUmvHxvcTi
 SGg3iD/AJcXa/l3q1vXZojSHjVv2DGWA7EvwKjqxyA3fh2mLyaMdcLgLY22Vi/vMG5igdLyfIhU
 Mza0dSe2vlQ504i8pT8FJZm4De4YU7Y+P+t4Nqr21F3vfdflj21iUQgwH+ZQxhMzuOY7CaEaVzP
 nRNMdrVX6WPP8onc7T1xq0BpGVOUMuNzW51nEpz3DwsnmFMbTOkDd5n0LAGbvyIPMFShiBGxGeK
 3s5njaNPnDYUfF1tbha+laEE0dk0tCHWpB1oQj0q6nV0vBG65gtECrkviH/XLl15cbK2WEAuXuq
 zMOqvPxGyof4J8b7+7eQZDGDS+CDM8fbzxgvnApIvCL6OnX8hLZckI47CtgjEKRLl+3hNR4GuUF
 CFf4VS87
X-Proofpoint-GUID: N1mNjugfeh4e5YoR_Aq7bDlDEBJJ6xLv
X-Proofpoint-ORIG-GUID: N1mNjugfeh4e5YoR_Aq7bDlDEBJJ6xLv
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c3f06a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8
 a=WsWmwj7wiaX3-TYSHvUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

When the destroy CM ID timeout kicks in, you typically get a storm of
them which creates a log flooding. Hence, change pr_err() to
pr_err_ratelimited() in cm_destroy_id_wait_timeout().

Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 92678e438ff4d..01bede8ba1055 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1049,8 +1049,8 @@ static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
-	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err_ratelimited("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+			   cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
-- 
2.43.5


