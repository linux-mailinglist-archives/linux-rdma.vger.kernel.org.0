Return-Path: <linux-rdma+bounces-13080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97AB43AB8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D19189E818
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA52F7455;
	Thu,  4 Sep 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/mE1o7q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF42ED170;
	Thu,  4 Sep 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986644; cv=none; b=uoJIIf9U69ReFuvZMqYriteZ7WSw9kxVk3hhxeCThP1z8qKaP+onsGRd2G6SDcd1ULYPr33FW3WxeMkmWU/jxMehlXZH1qZ30UQXM+h7GYsnEA0EMyS66e28l62jABnK1Iwb1HPcB+/x/YJA+L+vVGN80aoaxfFWDhJn2rmCLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986644; c=relaxed/simple;
	bh=bDXTGo/QH3JlMHNHojIWif9QLEQ/TgHgzZUHcRy59pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEvbFt/71hJqwJE+AolS+LoTuacrvx1fU8lGpF31Xjclwuh4O+PyWE/OFbHYxfXaHXu1R+alZQoeryCGezUCZUGTbq8lD0v4vy+DCHa9jG17fDJcRgLl67Iv6YXo+yuQK2bch3UHp1yjgYoXmerp32MJNOZhLVFtoR4P7eqQZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/mE1o7q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584BYXbL002994;
	Thu, 4 Sep 2025 11:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=cPKajP/0tc5usCnf
	PwJyo4PSqxsmbbiS2YYvK6B0HZo=; b=H/mE1o7qVx3XX5Ebn9IuVSkw59bnzKKr
	Y4kLyQQ4uufiU1guUvxgRo4Q1L8bYyuEIbafjhi2lWRmmQxy3bZoeLwgxGwHtirI
	DM6BnnvzKbhoS+mv4TiiS/bNIYuPHgvYG3QGyvLbEcJblFTh82l1vuodWgVeXzAf
	gCUmWC0DGTNe1S7PpBXSaaUx+Np3VauuqdoYiZffJYmYhk+F9Kf8DLzBLAF6opoL
	swAK7nSasvkgJUgHJ2iQgLoSid52Sogp0/nO22oWWGm4eI+oAHigrrupTGlX6kcU
	tdXUDUWiBqJB6n/YHO3YvAWvmktGKb7+hBQnZlpypAKL3+enX1LCIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ya0w810u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 11:50:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584BfD1T015809;
	Thu, 4 Sep 2025 11:50:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01qr924-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 11:50:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 584BoXIt040932;
	Thu, 4 Sep 2025 11:50:33 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48v01qr907-1;
	Thu, 04 Sep 2025 11:50:33 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] rds: ib: Increment i_fastreg_wrs before bailing out
Date: Thu,  4 Sep 2025 13:50:28 +0200
Message-ID: <20250904115030.3940649-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040117
X-Authority-Analysis: v=2.4 cv=eOYTjGp1 c=1 sm=1 tr=0 ts=68b97d0b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=YYmwRs4_t3Fg8bYOom4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDExNCBTYWx0ZWRfX2BuefHbCutHE
 WCW9f5Y4q0hqwuexKzrxdeiF3gNJx/dCSMIeBgyu0H+jr1p9iYNParX6qA2PybCf0Q5BKep0So4
 3GoTR6wRJANB44ZS8kWSJnT6hRRv/I2iiaeetqiGj8wn/J2xstFaXR8+6f2Uzv54aHmUZzIKf2V
 QhEZsv78cwOoHZMAg+XXcgMH0f1fBFaZiYr2RwCaJDhA0DbbB9MXc8GdTuQkWURCBTMuqqidBWb
 xZ+2fJKnXOVCte7cMhCkd2VLhmHxSw1IQk/9Zl3149xmGYKvpveuzeVEh8F7jnY8Ngzkq0hX0CT
 bXHG+5xqZY08zJX5x8pKqr9C/yULolGNEPpy5YTVB5wmrJgTq6g6SGODtjtXaSiDdcS4aeY76Cy
 TthtbPSi
X-Proofpoint-GUID: fPPVAkQNWUpJIkdnwT5FWWpw4y3EqN-7
X-Proofpoint-ORIG-GUID: fPPVAkQNWUpJIkdnwT5FWWpw4y3EqN-7

We need to increment i_fastreg_wrs before we bail out from
rds_ib_post_reg_frmr().

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

	v1 -> v2: Added Cc: stable@vger.kernel.org
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


