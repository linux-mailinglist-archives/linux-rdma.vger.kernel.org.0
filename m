Return-Path: <linux-rdma+bounces-661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A9832A10
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 14:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AD61C22D4A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574651C4B;
	Fri, 19 Jan 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BsXh5DGc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4851C35
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669562; cv=none; b=p01G6HedCgc4uud64StMmtoOFQTPFQd5ikTK6SrpPq1UEmtD6/mQ7h2Osr0fP62mIVaiK3tpd0E54IR0wVJ6XQVEHcGAmM7HApeaeTfFdvK8boB7QyXc3kZ9iaF4yJ2dNjHNnNTxUOhNG0UzrTnnHN47EYAEnMoTwJdtW8DN2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669562; c=relaxed/simple;
	bh=tQEujDxkt6t4i49gmTDB8Mjx8ZPwhSiE+qFxh5Ic3Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jmp4mOyibrH7E1yM4RzqKfVKCrV1f2OldLMJQJryhYxxFgQs7BU4M475+5uhTK7gHfBvNhow13Wqd0YXwEMa/D2bJ55o2MvOzzMpfXljuhET5NJZdtZFCuDg8UJDcEgqZvg6GTWbScjg4jxieYL5/vy3dHEiMC1JgsdOUmYIgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BsXh5DGc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JClHRk014712;
	Fri, 19 Jan 2024 13:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=9tv+SwymC3awJ/DY9LPTVbb7UAI8uzL12QZw1nE26HU=;
 b=BsXh5DGchOow7OHxQpDeZDiqI85OfSrX/rZwCHUwnQ9GIMJHHctlRpuQdnvOXHdeY0tw
 nbNqYv+4VaPFboCf7LFv9VbW6h0N/qZnhZU/0syyzxaLC5Efl/aj4wtu1oaDAgRDSRnq
 66auqhB975OYsjt3xyFzV/85qzIXv8tpyZdJoJeJwrQ/+fWl3vgqI3oS9dvBn++JNOqO
 63nZvnaHvJ3pjskvVvtMzSjkUrWXyMZUYBq/YaxjbXh52R9qB74xRbLXcQ8EK1rCU/i4
 BZKVpvMMfrTVDYGFK4UwVEwmJwho2EFQCwmHh7lali6WWXmAox7PhNrQ+XyMtiUgpI0/ dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqscy0m92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:05:57 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JCmdqP019290;
	Fri, 19 Jan 2024 13:05:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vqscy0m8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:05:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JAOebg006513;
	Fri, 19 Jan 2024 13:05:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j294v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:05:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40JD5stE60096998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 13:05:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E1C20043;
	Fri, 19 Jan 2024 13:05:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE1E420040;
	Fri, 19 Jan 2024 13:05:53 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.68.71])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jan 2024 13:05:53 +0000 (GMT)
From: Bernard Metzler <bmt@zurich.ibm.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
        ionut_n2001@yahoo.com
Subject: [PATCH] RDMA/siw: Trim size of page array to max size needed
Date: Fri, 19 Jan 2024 14:05:31 +0100
Message-Id: <20240119130532.57146-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TimqaI3dnCmtsfq--rnidnTaEIkUtvcT
X-Proofpoint-GUID: RWKz8hDdcGn3lcXdq-7GYiKeUr3HQ80H
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=659 phishscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401190067

siw tries sending all parts of an iWarp wire frame in one socket
send operation. If user data can be send without copy, user data
pages for one wire frame are referenced in an fixed size page array.
The size of this array can be made 2 elements smaller, since it
does not reference iWarp header and trailer crc. Trimming
the page array reduces the affected siw_tx_hdt() functions frame
size, staying below 1024 bytes. This avoids the following
compile-time warning:

 drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
 drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame
 size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Reported-by: ionut_n2001@yahoo.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218375
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 29 +++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 64ad9e0895bd..7ffc91bac606 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -432,7 +432,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
 	struct kvec iov[MAX_ARRAY];
-	struct page *page_array[MAX_ARRAY];
+	struct page *page_array[MAX_ARRAY-2];
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
 
 	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
@@ -491,7 +491,6 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 		while (sge_len) {
 			size_t plen = min((int)PAGE_SIZE - fp_off, sge_len);
-			void *kaddr;
 
 			if (!is_kva) {
 				struct page *p;
@@ -503,14 +502,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					rv = -EFAULT;
 					goto done_crc;
 				}
-				page_array[seg] = p;
-
 				if (!c_tx->use_sendpage) {
-					void *kaddr = kmap_local_page(p);
+					void *pa = kmap_local_page(p);
 
 					/* Remember for later kunmap() */
 					kmap_mask |= BIT(seg);
-					iov[seg].iov_base = kaddr + fp_off;
+					iov[seg].iov_base = pa + fp_off;
 					iov[seg].iov_len = plen;
 
 					if (do_crc)
@@ -518,12 +515,17 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 							c_tx->mpa_crc_hd,
 							iov[seg].iov_base,
 							plen);
-				} else if (do_crc) {
-					kaddr = kmap_local_page(p);
-					crypto_shash_update(c_tx->mpa_crc_hd,
-							    kaddr + fp_off,
-							    plen);
-					kunmap_local(kaddr);
+				} else {
+					page_array[seg] = p;
+					if (do_crc) {
+						void *pa = kmap_local_page(p);
+
+						crypto_shash_update(
+							c_tx->mpa_crc_hd,
+							pa + fp_off,
+							plen);
+						kunmap_local(pa);
+					}
 				}
 			} else {
 				/*
@@ -545,7 +547,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			data_len -= plen;
 			fp_off = 0;
 
-			if (++seg >= (int)MAX_ARRAY) {
+			if (++seg >= (int)MAX_ARRAY ||
+			    (c_tx->use_sendpage && seg >= (int)MAX_ARRAY-2)) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
 				siw_unmap_pages(iov, kmap_mask, seg-1);
 				wqe->processed -= c_tx->bytes_unsent;
-- 
2.38.1


