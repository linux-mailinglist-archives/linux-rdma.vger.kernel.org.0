Return-Path: <linux-rdma+bounces-15103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A4CCF29A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68D53056C54
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199929BD9A;
	Fri, 19 Dec 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U15iuny6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81028B7DB
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136807; cv=none; b=ZV8kef55/V4tN7QCa6q/efc3CpWiiWLz4xp7C1HhrMTx6fneGbiXCg/VZGtCO3l2siUvLWWgjN/uSCHPdH0e23YCu0p/7X8f7C/v+xw71Ct1ogwM62hY+hKZwjXfAi3WI6xjtaek6oMo0xzPF4zBxzGngS4sYEOG166PXITRG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136807; c=relaxed/simple;
	bh=HmdCatChgk07c6PYjvQFXRVxk8EeGY/8sFmDwBjfasI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjW3VJO4ikUHgtVHZjgTDcv2z8UOp8CIJQ6lPRSn0HlbMcsxqOeIWPh+zdzH6D6QD2a19WQD/dtkWOk4aNv269LMCMJuJNX38xq9Gkqwi+XT1ouvIXogoCz6k+4DMW9PCuy/JMuWZWHYbvK76almKH/YRWFq3hyl/tNoLQ+k+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U15iuny6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3E2b33120356;
	Fri, 19 Dec 2025 09:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TN8xKPUZQ+MEDebUGBD5YBxhF98Wq
	4WuRHq2Yem7qTk=; b=U15iuny6FzvC2VGRyBUCDMh9f4JhUvLeV/WdpTVEqLs7h
	rA3oJJrrMK3bZpKwiIK9ms9uXhMeHCN+Fa0viy2p4fopDVMrwe9AohyOHDtketoE
	s69MhXiq5wKucHiZZxK/LWckB5pB/zd4agsf/qs+iHOF8JsCyfTBTHztqosZPWys
	AsgvEFjYibqgqm6bhVCqlfPdlYt9ut9IuploGxNMu3rnBrCAp2Olrsb9AJiea+Is
	E9rOFomjDtEmo1b39ELITi1bRUMJKdig/ccsHpLSbRts/OpY4kfaPhFK18Syaiq3
	Bu5zJmgXB4Pjx/vbg/TaXfhRaziu64Ub7WeNBe4xA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r298v56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 09:33:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ9CRip037134;
	Fri, 19 Dec 2025 09:33:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtm6hhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 09:33:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BJ9XKpb005992;
	Fri, 19 Dec 2025 09:33:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b4qtm6hdm-1;
	Fri, 19 Dec 2025 09:33:20 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        leon@kernel.org, jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com,
        selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
Date: Fri, 19 Dec 2025 01:32:57 -0800
Message-ID: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190078
X-Authority-Analysis: v=2.4 cv=Ib2KmGqa c=1 sm=1 tr=0 ts=69451be1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=koA3Wo6WgtFlX8aIMV0A:9 cc=ntf awl=host:13654
X-Proofpoint-GUID: tAiI1cqkO-_ap60brI7ePu7npD5Z79-3
X-Proofpoint-ORIG-GUID: tAiI1cqkO-_ap60brI7ePu7npD5Z79-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA3OCBTYWx0ZWRfX1N7O7wdN054x
 cln3iYzO3pMJ2KFV+elcaTDcGQbRwdn0GPqTojtPBGNmxFj+Xg+amzdVxAfO8cBXHkRObAL7oSj
 rdALp0Bx/O3rcAZH1n26uS1u/24x6fg6CuYw/l4Xn+n8rp7edxkSq70Rbtt7vWSZQqL/91szHo/
 A3oqip1QcT5dp+38f777xGM01hK9TlJdFMs92vAmypKmcMRmKy0acJh9dIQx5mMH1Rjyhb6yBxb
 e3vAOGf94EYDhPgNBIqgo2w0FfwcUgpjIPVy7JNmmaGRDgPYNwkYYfv2oIT1QwGM5mE/wQfwp/Q
 0NVoLOrcv2UtIP3BKmXZ7MCT+Q0WZi/kNJKSSNJPYivGHx+2nO01sfmnoKU9ukeaPqfUHzc/DY7
 K+71Pags6akj9k6BRQLe6pH7A/ScodE7+9LkqR2eH73kOncerReR+3ymAu1wJRl7OQvekbJdGGd
 DW9LigYcDrTJgg5kL8T9ZQS78OUqZI7vecnawZlA=

The bnxt_re SEND path checks wr->send_flags to enable features such as
IP checksum offload. However, send_flags is a bitmask and may contain
multiple flags (e.g. IB_SEND_SIGNALED | IB_SEND_IP_CSUM), while the
existing code uses a switch() statement that only matches when
send_flags is exactly IB_SEND_IP_CSUM.

As a result, checksum offload is not enabled when additional SEND
flags are present.

Replace the switch() with a bitmask test:

    if (wr->send_flags & IB_SEND_IP_CSUM)

This ensures IP checksum offload is enabled correctly when multiple
SEND flags are used.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f19b55c13d58..ff91511bd338 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2919,14 +2919,9 @@ int bnxt_re_post_send(struct ib_qp *ib_qp, const struct ib_send_wr *wr,
 				wqe.rawqp1.lflags |=
 					SQ_SEND_RAWETH_QP1_LFLAGS_ROCE_CRC;
 			}
-			switch (wr->send_flags) {
-			case IB_SEND_IP_CSUM:
+			if (wr->send_flags & IB_SEND_IP_CSUM)
 				wqe.rawqp1.lflags |=
 					SQ_SEND_RAWETH_QP1_LFLAGS_IP_CHKSUM;
-				break;
-			default:
-				break;
-			}
 			fallthrough;
 		case IB_WR_SEND_WITH_INV:
 			rc = bnxt_re_build_send_wqe(qp, wr, &wqe);
-- 
2.50.1


