Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292C6AD9FC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfIINaD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 09:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbfIINaD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 09:30:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89DMf7q055194
        for <linux-rdma@vger.kernel.org>; Mon, 9 Sep 2019 09:30:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uv86uxhyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2019 09:29:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Mon, 9 Sep 2019 14:29:54 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 14:29:50 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89DTndM44958154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 13:29:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92CF2A405C;
        Mon,  9 Sep 2019 13:29:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6817CA4054;
        Mon,  9 Sep 2019 13:29:49 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 13:29:49 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v1 rdma-next] RDMA/siw: Relax from kmap_atomic() use in TX path
Date:   Mon,  9 Sep 2019 15:29:45 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19090913-0008-0000-0000-0000031326B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090913-0009-0000-0000-00004A318A4C
Message-Id: <20190909132945.30462-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090138
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the transmit path is never executed in an atomic
context, we do not need kmap_atomic() and can always
use less demanding kmap().

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 8e72f955921d..5d97bba0ce6d 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -76,16 +76,15 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 			if (unlikely(!p))
 				return -EFAULT;
 
-			buffer = kmap_atomic(p);
+			buffer = kmap(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
 				memcpy(paddr, buffer + off, bytes);
-				kunmap_atomic(buffer);
 			} else {
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
 				memcpy(paddr, buffer + off, part);
-				kunmap_atomic(buffer);
+				kunmap(p);
 
 				if (!mem->is_pbl)
 					p = siw_get_upage(mem->umem,
@@ -97,11 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				if (unlikely(!p))
 					return -EFAULT;
 
-				buffer = kmap_atomic(p);
-				memcpy(paddr + part, buffer,
-				       bytes - part);
-				kunmap_atomic(buffer);
+				buffer = kmap(p);
+				memcpy(paddr + part, buffer, bytes - part);
 			}
+			kunmap(p);
 		}
 	}
 	return (int)bytes;
-- 
2.17.2

