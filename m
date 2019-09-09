Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECDAD9EB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfIINYk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 09:24:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729859AbfIINYk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 09:24:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89DOKmV018052
        for <linux-rdma@vger.kernel.org>; Mon, 9 Sep 2019 09:24:39 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uwqk5r0fy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2019 09:24:39 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Mon, 9 Sep 2019 14:24:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 14:24:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89DOXpN56492188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 13:24:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C3BBAE045;
        Mon,  9 Sep 2019 13:24:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6999CAE057;
        Mon,  9 Sep 2019 13:24:33 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 13:24:33 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     krishna2@chelsio.com, dledford@redhat.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v1 for-rc] RDMA/siw: Fix page address mapping in TX path
Date:   Mon,  9 Sep 2019 15:24:27 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19090913-4275-0000-0000-000003633B9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090913-4276-0000-0000-000038758C21
Message-Id: <20190909132427.30264-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090138
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the correct kmap()/kunmap() flow to determine page
address used for CRC computation. Using page_address()
is wrong, since page might be in highmem.

Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
Fixes: b9be6f18cf9e rdma/siw: transmit path
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 438a2917a47c..8e72f955921d 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -518,11 +518,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 							c_tx->mpa_crc_hd,
 							iov[seg].iov_base,
 							plen);
-				} else if (do_crc)
-					crypto_shash_update(
-						c_tx->mpa_crc_hd,
-						page_address(p) + fp_off,
-						plen);
+				} else if (do_crc) {
+					crypto_shash_update(c_tx->mpa_crc_hd,
+							    kmap(p) + fp_off,
+							    plen);
+					kunmap(p);
+				}
 			} else {
 				u64 va = sge->laddr + sge_off;
 
-- 
2.17.2

