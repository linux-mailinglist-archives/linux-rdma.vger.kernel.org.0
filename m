Return-Path: <linux-rdma+bounces-13066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E36B426F2
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9790E488407
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C032D3744;
	Wed,  3 Sep 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqoEAIW3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984663CF;
	Wed,  3 Sep 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917116; cv=none; b=t8vOh+cQd3k9tYybIuEtyDHau8UrZl5xPfcupYr+2bdGYlSesp35uil6GGjrl64cZWBLYxmKFtg3s2+l4WmlqaeCyfOaMGKEmo4E/F+zlwBEbjhnoe55fea4sGH9bCBWb2B7jkeQse1gI7VgH327Z2Q8gFmpD1/COyHh+cpk1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917116; c=relaxed/simple;
	bh=3xyE6UJ3vRQeHm+xo4MVbouQ16qNTitBJ89r0M10OxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mI5LLpvVjimxzg87BvJrP0rCtFPpAUh4Yk8AhhcHFaslSkZZTXc8mHhxNtKksYwblL8adBMUH3kgfnccw35Pwy9EsZqS9YhWDi1YVIEwBQ8inmNICjd+mmNvSGP8ayN/T6bBLfmSmdkt27GpQdrsolerV79ILB88BFQp5u8EG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iqoEAIW3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NANb002197;
	Wed, 3 Sep 2025 16:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=3CiJIstQli0z66FK
	STmSJyHo8ie9htn6e/FAyGuQOxE=; b=iqoEAIW3ea4+nhen2Sfa5/4LslNVZi8S
	4RJg0HVuU1PHJffJ2LQ/t04puyrlFMF3Iu6I9gbPZa03i5gLW6WaD77Q9oXJW1qM
	Ilvbd56xN1E+46meNNVhIjHirxziQXN0PwWkPR0mEjdZ7OdljSobfHE729AmZWz9
	c5D3lQRJGrKOdzMGK6bV734ajNHpn8JNDSm2OG9dIe9eZ4A+yvd02QNb1YaFLgWI
	j7Xo44dgBhJErKombctgJRvJ86YStiX7IH+tHzsWbEugWCEVfLEpm0cYqa2Mm8vn
	IsY/VWsbpZrayyRKSaMwJ+QWqexIH7/SEUj9lEZfn3WDZFONF8O+lA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvxtw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:31:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583FLRZX036092;
	Wed, 3 Sep 2025 16:31:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrahhvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:31:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 583GViLj024971;
	Wed, 3 Sep 2025 16:31:44 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrahht8-1;
	Wed, 03 Sep 2025 16:31:44 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] rds: ib: Increment i_fastreg_wrs before bailing out
Date: Wed,  3 Sep 2025 18:31:36 +0200
Message-ID: <20250903163140.3864215-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxFavc3EI/yKz
 bQEEv7BYeHvUInN+6Sioykl9cffRXg1dUDbCma7G0XZpQstWd8o5PyEL5ZAkdyq0Vcj7qDkn1BN
 Ui/MWquX32jwLcmpyDzoKED85szHAMAE9XgrUYRSngikkEU/d+Ni4h0A/qXRMdPKSBC2gyMt8HG
 HnaFXXxBwxFwTqWr0078m/mpmY8h2xy5LpUuKK70yhdiLAwbCBfrUtRNpwOnUMjX5BLYSKRagrO
 5NBYESMApdy6D+xqca+jUyK2Zobr4eNnZbe3TKZvvP+Jc2Y37HmSwkAw6RmFChh9ADdtjUWoMPb
 HbqgiQg9Rs59JedFZoe/mMdbp2+wzBIV31RZcQOSduthcgksifr7vS8yajBZZRJ40Qwtew1yCVy
 YSyivsTK
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b86d72 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8
 a=YYmwRs4_t3Fg8bYOom4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ycx0PDE0knzbo5QQca7oIFSZwZZuHzDY
X-Proofpoint-GUID: Ycx0PDE0knzbo5QQca7oIFSZwZZuHzDY

We need to increment i_fastreg_wrs before we bail out from
rds_ib_post_reg_frmr().

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 net/rds/ib_frmr.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index 28c1b00221780..7e3b04a83904d 100644
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
 
@@ -178,9 +181,11 @@ static int rds_ib_post_reg_frmr(struct rds_ib_mr *ibmr)
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


