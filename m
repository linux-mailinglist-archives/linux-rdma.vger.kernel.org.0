Return-Path: <linux-rdma+bounces-13247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D4B514C3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA71C2318F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E4522F;
	Wed, 10 Sep 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VtmIrCR5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F031D370;
	Wed, 10 Sep 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502317; cv=none; b=t5o8NQk/TyFI3Ptwe/KIet2qwqGSiyTI6eO5JlC+LEUN8/a/mSHdAre/0M8mFqa5BQITBSfwvaFJCy1/n0TxlZ2Y5hTjQfVXwizyBhWdM67UvXa0k1DtBQJEN3E+wPpcHxTqs6YvmoG2xHYfQFlHOGn/Fhu6FqjF5WLdmdQKeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502317; c=relaxed/simple;
	bh=mr5VREO0zlgyp0+N3c6zL0+mdMv963Esrn8kaa2OT50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbwSgqXSw2C6STTs/Yyni0yl/gj8IUvaKkzmxo7+inIoL3xtJhvhA7B1z6OnlKH/AVXhnFGr4fpBEW0o0Eov/feh+qDlZswbRgEBuJCbHdj/6pJFX729tAD1RU2BeRW9Iu6nD9tbmG+lCRrWKaoIdarMYBgIy3vAxwnLNj3PHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VtmIrCR5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9N7dO010083;
	Wed, 10 Sep 2025 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=OCpi8OJ5u07C66mC
	VMY0WtQNKjYjRamzDj98hmn56E0=; b=VtmIrCR5mfkoC0194t0qVYs9PTo2r9ay
	IJ8N91j4LP04+qlwAzXwOApjeIFiNEcgTJ2MMYwxbNhQGNtUAfYmft4fBH/ZDiEo
	K9pTksHwabybMODAWd7U/s4Y39xt7o3u8nFFUOBReqTgVjZwhLU3PbXU1PAD8Kj+
	q0rMtXMhlzRtBtsW/XDqpLid9mOcLjNyEF+LWX96PRdHZnxVel39e96S9wxvkMSS
	WmF2ksXS05RLA8nI7dCylLrbt+VI9IibbiK1hiNiSv3Ooraw1QNdwFxhVVFq+Upb
	RuEGN06ZheAJZWngd6AWnGByttTeJ0QvlX5UV4ilLa42LPKX+QRgXA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1m1xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 11:05:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAKsq2013588;
	Wed, 10 Sep 2025 11:05:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb2r97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 11:05:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58AB57Xd035490;
	Wed, 10 Sep 2025 11:05:07 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdb2r4w-1;
	Wed, 10 Sep 2025 11:05:06 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v3] rds: ib: Increment i_fastreg_wrs before bailing out
Date: Wed, 10 Sep 2025 13:04:59 +0200
Message-ID: <20250910110501.350238-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100101
X-Proofpoint-ORIG-GUID: CYATfuSztpsdZXvqgwIgyX1ejF1u80s9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXx7LBPhpsEOSm
 3WPKCLsVnjog3w+4c3uG+lLK/xG+iIOfD77c81GubJlhaOzDV3PnZeQL9SQQOxWW76rvM1ME6Mg
 c9IKmnxtpb6kyq9dlqplKWFvAP+BOE/SeloPGLZlw3B4WD08exGY0s4O3bgCHFnmw6jrJeQR52f
 CXeIE8DiDhy6d0FhUDTsEQmglLhsFhCu42w80VSd4lHawJeE9diJKDeTMzp79/Q9buyvob3Q43b
 +y4Ec/Tt6SK9pcVm5mLY66UMmv2WH6gbbZTNcNgtbCXMPM1Wdl/bPAX1kWye5ULHMDLr9mpUQhR
 wI0tmtkiSWe+zpMFaq6EMujf1Y5LVO6ymVvTOXYFQJQnIncSmy0dAp+52UCahdsqg1J4fTDUTkk
 GC1gtnTH
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c15b64 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=9eyeeSo07tw-mEE3XcsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CYATfuSztpsdZXvqgwIgyX1ejF1u80s9

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

---

v2 -> v3:
   * Amended commit message
   * Removed indentation of this section
   * Fixing error path from ib_post_send()

v1 -> v2: Added Cc: stable@vger.kernel.org
---
 net/rds/ib_frmr.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index 28c1b00221780..395a99b5a65ca 100644
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
@@ -178,9 +180,11 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
 	 * being accessed while registration is still pending.
 	 */
 	wait_event(frmr->fr_reg_done, !frmr->fr_reg);
-
 out:
+	return ret;
 
+out_inc:
+	atomic_inc(&ibmr->ic->i_fastreg_wrs);
 	return ret;
 }
 
-- 
2.43.5


