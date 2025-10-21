Return-Path: <linux-rdma+bounces-13957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801FBF6C56
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 15:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C69D48604D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED2337100;
	Tue, 21 Oct 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSDUECDd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481C253B59;
	Tue, 21 Oct 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053273; cv=none; b=vFVYgKmMinzievK1RkFG+JcxioBr6PK3rFI5RK3hhU1gMDx0dN05duX9jYep+/8yCeXn++Ge/KuXpGefhtito9ufE5vhL4m8QR9m9uRwM5mk69MZqqq2nbimwl2VcSAM+6rwQ75zW8q6OLjxPhMVA016k01OMMn2LexhidyAiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053273; c=relaxed/simple;
	bh=C0Vsu5q2435elJlVerWo0mXxWQjXfadCTKvMMq6uDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLeLUnTPmALb8qHsYv18c8YinZjPn67ZudHDcHsu3N6rj+UzdLP0YZwWywysIq3merXzGZbmBuQ42LABdELl/msT39zDOx5G2v6Lw43/SW6WPmT5X8Ui5UYVixmSLA8rWsyCH2DHz5Kuw4Em3zKv/Z9hbC+cvhuBgQbbv8DSxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSDUECDd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7uUDj029425;
	Tue, 21 Oct 2025 13:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=XL8yF1gk7jDq2pim
	rOdoo7P8n64/Uwhpj1T+/1FZ4jE=; b=SSDUECDdkBYIgU0LSWQBZ2UyOSY/9Jzj
	x5VSQ9nhiq4qXIgPBry3OXbjcEJqF/Q+yAybTLstK0WuKwytTaYs8gyHj7lGVyqC
	waEQ4tBe/HgGyp5wjOI4jGjNRcXhSUdmintgvIAGXRgqCEc2vKE1hj7oOxbUVNCz
	3Q2DgzGF0A3a72ZB2OPcimzNBdFL6ekupmbp/9OoMkIfXGZJjcHMAmnzp3NcMKnZ
	YWgYkKLeIILvIyhVMX0m6xPTea37ivuvPrJnr0aWJOsy2FLuVuD28JRw2/RR4RZy
	1Izr1vdaBl527HQnOnN9/Xqo2j4BG7gSx/9/C05nE5Q6QDUAYxSrvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2waw6gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LB1Urk025462;
	Tue, 21 Oct 2025 13:27:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbv622-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:27:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LDRfej018557;
	Tue, 21 Oct 2025 13:27:41 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bbv617-1;
	Tue, 21 Oct 2025 13:27:41 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sean Hefty <shefty@nvidia.com>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jacob Moroni <jmoroni@google.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next] RDMA/cm: Base cm_id destruction timeout on CMA values
Date: Tue, 21 Oct 2025 15:27:33 +0200
Message-ID: <20251021132738.4179604-1-haakon.bugge@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210105
X-Proofpoint-ORIG-GUID: Smzmd9-8UTuCmmqxPB4NrfSKWO3MiUYH
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f78a4f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=78MCNktfei52413G-oQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2zIkpDBiki/B
 RJkV3zKN9SvnaC86ep4j9STesC4mE2xAw0fmfrWUffG2Dl1Tk/844R5s3WJR0XbLVRN99vyIlUE
 T21WWQfTxaXZoqqoyj7y1MbwV19mS8MkH2P9dLZD4is6D201QA1R5EaJ9xebuzzVFp2klpKjkwS
 +f5cmqTZEjFR1BXcZYQFPnXcJtR1Plcx5xsD92n4BfLT/tZ7DBwBRkl5xh4LnuUiR8c0hnMj2mY
 OWUfk/5ZMGxd1lNG1NqfNoyFTufq1cICtdQjumTFvVM5WPaoHyAVJuDtoDQ9P0Q5Nvt56m0Xo/O
 w54FTTTthTImm/JUVVhS4d0ckKLk0OowfiS9dkSsj+j0GjNfOh3XnQC8jqUTKsTZ6LGXhtu9VA/
 I17VJz2KMONwjjkRsMTXCUXoofdKUg==
X-Proofpoint-GUID: Smzmd9-8UTuCmmqxPB4NrfSKWO3MiUYH

When a GSI MAD packet is sent on the QP, it will potentially be
retried CMA_MAX_CM_RETRIES times with a timeout value of:

    4.096usec * 2 ^ CMA_CM_RESPONSE_TIMEOUT

The above equates to ~64 seconds using the default CMA values.

The cm_id_priv's refcount will be incremented for this period.
Therefore, the timeout value waiting for a cm_id destruction must be
based on the effective timeout of MAD packets.  To provide additional
leeway, we add 25% to this timeout and use that instead of the
constant 10 seconds timeout, which may result in false negatives.

Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 01bede8ba1055..2a36a93459592 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,7 +34,6 @@ MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
-#define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 #define CM_DIRECT_RETRY_CTX ((void *) 1UL)
 #define CM_MRA_SETTING 24 /* 4.096us * 2^24 = ~68.7 seconds */
 
@@ -1057,6 +1056,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
 	enum ib_cm_state old_state;
+	unsigned long timeout;
 	struct cm_work *work;
 	int ret;
 
@@ -1167,10 +1167,9 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 
 	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
+	timeout = msecs_to_jiffies((cm_id_priv->max_cm_retries * cm_id_priv->timeout_ms * 5) / 4);
 	do {
-		ret = wait_for_completion_timeout(&cm_id_priv->comp,
-						  msecs_to_jiffies(
-						  CM_DESTROY_ID_WAIT_TIMEOUT));
+		ret = wait_for_completion_timeout(&cm_id_priv->comp, timeout);
 		if (!ret) /* timeout happened */
 			cm_destroy_id_wait_timeout(cm_id, old_state);
 	} while (!ret);
-- 
2.43.5


