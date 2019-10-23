Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE5E21D8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfJWReK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 13:34:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfJWReK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 13:34:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NHT0MZ190406;
        Wed, 23 Oct 2019 17:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=mHXswdXwjMkjlynu6WoO/JXk1XcXd81Y/XoQ2aJrYlc=;
 b=mMjMJAWPAOGCP7e/Eh0KJ0oLM2GOYPVRUzKsUHf//g0VJ08flrTR0PkKo4ldPUvx1wdm
 1xmJ7V0CmnPZDFiYiXyMQSegB8oHt93MBAi6YqL3l6fZEn/cdB7MkTrYastp0NGPc768
 pCnlbnvQAbRkFQp5P7zznAX3D1z7QHRa5CWyWnKNwiHIiu0nt7kjBZNTALpfrzMjjngN
 H7jVzBMhjRsiThJdQDbBjdka3yGnnfZYpchbaFuJ1j2WugWb39nBrXC+Bc83odRKRAWL
 erPhKb2D3xBDLCq4tfyzK5ONtK6jUp3a7ze5R0LZ9Y/Ytr+q/seVuuUshtZqik2geQ3B /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtepxv63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 17:33:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NHXkwc070018;
        Wed, 23 Oct 2019 17:33:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2vtm22kxeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 17:33:58 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9NHXnFO070572;
        Wed, 23 Oct 2019 17:33:57 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by aserp3030.oracle.com with ESMTP id 2vtm22kwep-2;
        Wed, 23 Oct 2019 17:33:57 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v1 1/1] rxe: calculate inline data size based on requested values
Date:   Wed, 23 Oct 2019 10:32:37 -0700
Message-Id: <1571851957-3524-2-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
References: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230167
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

rxe driver has a hard coded value for the size of inline data, where as
mlx5 driver calculates number of SGE's and inline data size based on the
values in the qp request. This patch modifies rxe driver to do the same
so that applications can work seamlessly across drivers.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 1b596fb..657f9303 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -68,7 +68,6 @@ enum rxe_device_param {
 	RXE_HW_VER			= 0,
 	RXE_MAX_QP			= 0x10000,
 	RXE_MAX_QP_WR			= 0x4000,
-	RXE_MAX_INLINE_DATA		= 400,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
 					| IB_DEVICE_AUTO_PATH_MIG
@@ -81,6 +80,7 @@ enum rxe_device_param {
 					| IB_DEVICE_MEM_MGT_EXTENSIONS,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_SGE_RD			= 32,
+	RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge),
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
 	RXE_MAX_MR			= 2 * 1024,
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index aeea994..45b5da5 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -229,6 +229,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	int err;
 	int wqe_size;
+	unsigned int inline_size;
 
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
@@ -244,6 +245,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			 sizeof(struct rxe_send_wqe) +
 			 qp->sq.max_inline);
 
+	inline_size = wqe_size - sizeof(struct rxe_send_wqe);
+	qp->sq.max_inline = inline_size;
+	init->cap.max_inline_data = inline_size;
 	qp->sq.queue = rxe_queue_init(rxe,
 				      &qp->sq.max_wr,
 				      wqe_size);
-- 
1.8.3.1

