Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B699317
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 14:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfHVMQd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 08:16:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728872AbfHVMQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 08:16:33 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MC8dTe055113
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 08:16:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhtebsg28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 08:16:31 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Thu, 22 Aug 2019 13:16:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 13:16:26 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MCGP3Y49676488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 12:16:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3C81AE055;
        Thu, 22 Aug 2019 12:16:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A37FAE053;
        Thu, 22 Aug 2019 12:16:25 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 12:16:25 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     krishna2@chelsio.com, dledford@redhat.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Enable SGL's with mixed memory types
Date:   Thu, 22 Aug 2019 14:16:14 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082212-0028-0000-0000-000003927BF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082212-0029-0000-0000-00002454A6F5
Message-Id: <20190822121614.21146-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch enables the transmission of work requests with SGL's
of mixed types, e.g. kernel buffers and PBL regions referenced
by same work request. This enables iSER as a kernel client.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Tested-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 37 +++++++++++----------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 43020d2040fc..42c63622c7bd 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -398,15 +398,13 @@ static int siw_0copy_tx(struct socket *s, struct page **page,
 
 #define MAX_TRAILER (MPA_CRC_SIZE + 4)
 
-static void siw_unmap_pages(struct page **pages, int hdr_len, int num_maps)
+static void siw_unmap_pages(struct page **pp, unsigned long kmap_mask)
 {
-	if (hdr_len) {
-		++pages;
-		--num_maps;
-	}
-	while (num_maps-- > 0) {
-		kunmap(*pages);
-		pages++;
+	while (kmap_mask) {
+		if (kmap_mask & BIT(0))
+			kunmap(*pp);
+		pp++;
+		kmap_mask >>= 1;
 	}
 }
 
@@ -437,6 +435,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
 		     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
 		     pbl_idx = c_tx->pbl_idx;
+	unsigned long kmap_mask = 0L;
 
 	if (c_tx->state == SIW_SEND_HDR) {
 		if (c_tx->use_sendpage) {
@@ -463,8 +462,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 		if (!(tx_flags(wqe) & SIW_WQE_INLINE)) {
 			mem = wqe->mem[sge_idx];
-			if (!mem->mem_obj)
-				is_kva = 1;
+			is_kva = mem->mem_obj == NULL ? 1 : 0;
 		} else {
 			is_kva = 1;
 		}
@@ -500,12 +498,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					p = siw_get_upage(mem->umem,
 							  sge->laddr + sge_off);
 				if (unlikely(!p)) {
-					if (hdr_len)
-						seg--;
-					if (!c_tx->use_sendpage && seg) {
-						siw_unmap_pages(page_array,
-								hdr_len, seg);
-					}
+					siw_unmap_pages(page_array, kmap_mask);
 					wqe->processed -= c_tx->bytes_unsent;
 					rv = -EFAULT;
 					goto done_crc;
@@ -515,6 +508,10 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				if (!c_tx->use_sendpage) {
 					iov[seg].iov_base = kmap(p) + fp_off;
 					iov[seg].iov_len = plen;
+
+					/* Remember for later kunmap() */
+					kmap_mask |= BIT(seg);
+
 					if (do_crc)
 						crypto_shash_update(
 							c_tx->mpa_crc_hd,
@@ -543,10 +540,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 			if (++seg > (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
-				if (!is_kva && !c_tx->use_sendpage) {
-					siw_unmap_pages(page_array, hdr_len,
-							seg - 1);
-				}
+				siw_unmap_pages(page_array, kmap_mask);
 				wqe->processed -= c_tx->bytes_unsent;
 				rv = -EMSGSIZE;
 				goto done_crc;
@@ -597,8 +591,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	} else {
 		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
 				    hdr_len + data_len + trl_len);
-		if (!is_kva)
-			siw_unmap_pages(page_array, hdr_len, seg);
+		siw_unmap_pages(page_array, kmap_mask);
 	}
 	if (rv < (int)hdr_len) {
 		/* Not even complete hdr pushed or negative rv */
-- 
2.17.2

