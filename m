Return-Path: <linux-rdma+bounces-13276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99859B533D3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE261189E74F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0F326D73;
	Thu, 11 Sep 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sa8JmFzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4121F03C5;
	Thu, 11 Sep 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597631; cv=none; b=DBu9l71A+0LIn7T0EFMjgOvwfidd1DVDClMC2HggrTSmDCiOOOENZAtH8SQlq+P1+7MoDdyNdV9vFD0iX9a2Pj0CSIGQMXgCWDXZ/JfqbS3as8PN4UgcG+KOdag2OMykx49wsIxs8IsqZNysKPRW0s7VdvGbG8+wNzvjhxyjaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597631; c=relaxed/simple;
	bh=kImLN5/P1/e/EsIss0tSpUIc2H/kIr1F9DVGIh+j67M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UjSwVi3TQyRy+FUEQBZSrQlQexIKcQOUmeA7TSGvm4us2oQ6dN9O8atuzHgQibrKwXSW+cV24TQeCY0Ct3xpa/NgznErizk0BJ3ssHHXsHBGPP1ACLbw+9NvNTuq5NnZWCVyqYRQwSShxZ0WUVCOTxYHPGBE4VtB8FuVG/s1xr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sa8JmFzZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDWmJn000546;
	Thu, 11 Sep 2025 13:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bo+pHATz3KsHurnH
	06nuN1Fry8ZLTvPY6pSYAMdhDAA=; b=Sa8JmFzZK7lCz0M+dTXFv2zFusO7e/ry
	AGiKtJlCclRofhCdZ0YAZzK+ESH1KpxCrqNcIz7P8Tikhfbc1QwH1I/NV+AQ0eQG
	wg+k7rtP2WUhBkBt6/UyhTmHIFt1Mc7akLRZZV/7ZpK4dUEDIrLcy/D56ZnaB4FP
	b24LT6OjAZkCUbtXrNsIkiYOKXf+RGpEtj752vFXbdZGzFOA7XtnPb0/oz9ti9Lw
	6BXpaTMTgMu3MU1neEWuFgbj9b8pdsJcsiUtP5ZxUumfZdhaMmUt6NFZdAGX6Dce
	ndsFbyXc9ABJmjP1fDU9oy+bWlRI1gpV3X8VVEbNgyGTKVmjh1bE1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2x96w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:33:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCYYDd013674;
	Thu, 11 Sep 2025 13:33:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcn5u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:33:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58BDTwM8014365;
	Thu, 11 Sep 2025 13:33:40 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdcn5sf-1;
	Thu, 11 Sep 2025 13:33:40 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v4] rds: ib: Increment i_fastreg_wrs before bailing out
Date: Thu, 11 Sep 2025 15:33:34 +0200
Message-ID: <20250911133336.451212-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110120
X-Proofpoint-GUID: SUiSGi1jYIEOZfa_djKllDSqw4D_Irnr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX/OfyYHQXjqJb
 bgZUIECP9diU8ygFyBfbKVV0ave6wY+BUk8vZmOZ+VfiIXK/KEFVcgiIbujqgXrkrQ/BcZtwcO0
 I+gBRNrQaoQU585qd2cJA/CeWnLlRo2OMukmUJFSxMkogPpBw31ZQlkvxvwuR/zFjxpmfwjxLSG
 fY+KUPcWDepdly77sLbANc1O7EwBwd9x46RQSvaOhLPtsesEJgRKX/VmSoixackaw6WChKX+9+V
 MH5LgnifhBRwFY6JV9RO8fmkmNVBZn24sSi4Hg1PrK+5BgjIKap5dFaQ2JaztiWg3T4DQK2hFLn
 ea5BULt+2gPcA6SX+0G35NIWDJH1Ej53LJEqstLRnWYY1r6yWUF5hXgz3go5K+MSiJx8ybdGzW3
 T5meq03w
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c2cfb5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=9eyeeSo07tw-mEE3XcsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SUiSGi1jYIEOZfa_djKllDSqw4D_Irnr

We need to increment i_fastreg_wrs before we bail out from
rds_ib_post_reg_frmr().

We have a fixed budget of how many FRWR operations that can be
outstanding using the dedicated QP used for memory registrations and
de-registrations. This budget is enforced by the atomic_t
i_fastreg_wrs. If we bail out early in rds_ib_post_reg_frmr(), we will
"leak" the possibility of posting an FRWR operation, and if that
accumulates, no FRWR operation can be carried out.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

---

v3 -> v4:
   * Removed unused "out:" label
   * Added Allison's r-b

v2 -> v3:
   * Amended commit message
   * Removed indentation of this section
   * Fixing error path from ib_post_send()

v1 -> v2: Added Cc: stable@vger.kernel.org
---
 net/rds/ib_frmr.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index 28c1b00221780..bd861191157b5 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -133,12 +133,15 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 
 	ret = ib_map_mr_sg_zbva(frmr->mr, ibmr->sg, ibmr->sg_dma_len,
 				&off, PAGE_SIZE);
-	if (unlikely(ret != ibmr->sg_dma_len))
-		return ret < 0 ? ret : -EINVAL;
+	if (unlikely(ret != ibmr->sg_dma_len)) {
+		ret = ret < 0 ? ret : -EINVAL;
+		goto out_inc;
+	}
 
-	if (cmpxchg(&frmr->fr_state,
-		    FRMR_IS_FREE, FRMR_IS_INUSE) != FRMR_IS_FREE)
-		return -EBUSY;
+	if (cmpxchg(&frmr->fr_state, FRMR_IS_FREE, FRMR_IS_INUSE) != FRMR_IS_FREE) {
+		ret = -EBUSY;
+		goto out_inc;
+	}
 
 	atomic_inc(&ibmr->ic->i_fastreg_inuse_count);
 
@@ -166,11 +169,10 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 		/* Failure here can be because of -ENOMEM as well */
 		rds_transition_frwr_state(ibmr, FRMR_IS_INUSE, FRMR_IS_STALE);
 
-		atomic_inc(&ibmr->ic->i_fastreg_wrs);
 		if (printk_ratelimit())
 			pr_warn("RDS/IB: %s returned error(%d)\n",
 				__func__, ret);
-		goto out;
+		goto out_inc;
 	}
 
 	/* Wait for the registration to complete in order to prevent an invalid
@@ -179,8 +181,10 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 	 */
 	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
 
-out:
+	return ret;
 
+out_inc:
+	atomic_inc(&ibmr->ic->i_fastreg_wrs);
 	return ret;
 }
 
-- 
2.43.5


