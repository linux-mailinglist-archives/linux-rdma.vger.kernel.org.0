Return-Path: <linux-rdma+bounces-13461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F6CB815FE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BFF4683D4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ACA301024;
	Wed, 17 Sep 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pajF9CRa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECC26D4C4;
	Wed, 17 Sep 2025 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134560; cv=none; b=fWX6l1Ah02zqTAucVYHk6/rrcCx43XHfrnsr5Q0Ekj4M05tsVZHp+lCqSUsvz/d7RwqHgW78K1xAIJ/xsa2jE/iy+1vwhN/m4FTzFiBLCn51iTRKuX6WUavOIgkTQxpN8nbQpkPhcVRyi00FhimVUeKOs5TdfBud/uQcLXmDT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134560; c=relaxed/simple;
	bh=0foBAsVE+LB5+pq0SPplm74sj2q/NUP0pBhIynF97vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1i5afT9M1XeJVmd6GxgSZu0eOUPksmIPRivZAxIfBD8VI6l1GFF0hTiMBbvlFkWnv/EPgCN8xAhAWSxrtHRTh5tMRj2+QuGAMHB+QecmuW9gM75aNXakVZ6CpJGFG+ZP6JJDEjlqfZTtGo+C1jcD+jApse+JZI0pSLR7OERmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pajF9CRa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIJd6T027672;
	Wed, 17 Sep 2025 18:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sz16kJF9qOd971cDCM9SATsIbe06/InSon5nSaYxE
	zo=; b=pajF9CRaOGNjdwy1Vgu/phOuL0/lkJD5Mqh8LVNtm4WAJ2AmCzTN26VBL
	Tb5D6egJuP+NHS/udXrtn9gwK/2nMwrxoyg5VD7+BLcAJWOFeJeoj6p54BgVD4jp
	xkGk9r2KQYsjdC2yG1LpCpkkqilTxsvavvqUxyH8/FzPY3h6YeyMwCUk1FMkbC5Q
	IaZvSahYXndXGrXVHYaBD6uWvOcKJoBWh3w8H/q3sGAmBAysOReDJ7y+DDfc2Jq8
	0QMxtBpXSgXbl6ToUgp4lmmG6oopSLGJgu3qV+D+7cg1h3E9UHHRTDscW0vxiALl
	9KIgIVOlVnau1TZusDTTRma0l1ixQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p5p0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:42:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HIbVG0018256;
	Wed, 17 Sep 2025 18:42:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p5p0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:42:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIC8Ji018632;
	Wed, 17 Sep 2025 18:42:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mjjp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:42:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58HIgQ507078552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 18:42:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D6E658050;
	Wed, 17 Sep 2025 18:42:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF1B958052;
	Wed, 17 Sep 2025 18:42:24 +0000 (GMT)
Received: from a3560036.lnxne.boe (unknown [9.152.108.100])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Sep 2025 18:42:24 +0000 (GMT)
From: Sidraya Jayagond <sidraya@linux.ibm.com>
To: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        pabeni@redhat.com, horms@kernel.org, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, wenjia@linux.ibm.com,
        mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org, Sidraya Jayagond <sidraya@linux.ibm.com>
Subject: [PATCH net] net/smc: fix warning in smc_rx_splice() when calling get_page()
Date: Wed, 17 Sep 2025 20:42:20 +0200
Message-ID: <20250917184220.801066-1-sidraya@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2+CbK4IC47Rn
 jHWdDwuPYk6CNOheWhapPHWjtpaBAqdpzaO6h8LPV81V9f+R0o0OxBHQWHjfxWASotsJ55nwaHK
 tRQ0XQc26sCjigt0h4PALN+8yFlqgEs1PyjS+cjj+2DPnmOO/tnsePgGzeC3x7V4CYComAs9021
 VGeVfUe9CTXqPucERxCU0iSqhTtTK3ruSvPreqi1Y/VllPx4ZVyhjWnk0JzjdFTEwdl1hrtLiiL
 eilfxe79N3IlD2MpPt00Xfr3vBhG3oZRmDNPnOtj9XbTU4vS1VId2aE6ywLh8mXHv2AQ2EnA+8H
 soxaSRmHstDZtr2Ch5nauaahlqKj0C1qzE/FBA1ZVmeQChxbQDqicZVjLIeTnH4uyLXzik5HCgO
 FrLF+W6S
X-Proofpoint-ORIG-GUID: kco9-Jjn9a2PjTbvShXfph2LF4VijF9T
X-Proofpoint-GUID: Ogats12SsLMDZ1X-zxw-rF9lnUJuxn0m
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cb0115 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=3kUJVLf2yPifrhjWNHsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

smc_lo_register_dmb() allocates DMB buffers with kzalloc(), which are
later passed to get_page() in smc_rx_splice(). Since kmalloc memory is
not page-backed, this triggers WARN_ON_ONCE() in get_page() and prevents
holding a refcount on the buffer. This can lead to use-after-free if
the memory is released before splice_to_pipe() completes.

Use folio_alloc() instead, ensuring DMBs are page-backed and safe for
get_page().

WARNING: CPU: 18 PID: 12152 at ./include/linux/mm.h:1330 smc_rx_splice+0xaf8/0xe20 [smc]
CPU: 18 UID: 0 PID: 12152 Comm: smcapp Kdump: loaded Not tainted 6.17.0-rc3-11705-g9cf4672ecfee #10 NONE
Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
Krnl PSW : 0704e00180000000 000793161032696c (smc_rx_splice+0xafc/0xe20 [smc])
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000000000 001cee80007d3001 00077400000000f8 0000000000000005
           0000000000000001 001cee80007d3006 0007740000001000 001c000000000000
           000000009b0c99e0 0000000000001000 001c0000000000f8 001c000000000000
           000003ffcc6f7c88 0007740003e98000 0007931600000005 000792969b2ff7b8
Krnl Code: 0007931610326960: af000000		mc	0,0
           0007931610326964: a7f4ff43		brc	15,00079316103267ea
          #0007931610326968: af000000		mc	0,0
          >000793161032696c: a7f4ff3f		brc	15,00079316103267ea
           0007931610326970: e320f1000004	lg	%r2,256(%r15)
           0007931610326976: c0e53fd1b5f5	brasl	%r14,000793168fd5d560
           000793161032697c: a7f4fbb5		brc	15,00079316103260e6
           0007931610326980: b904002b		lgr	%r2,%r11
Call Trace:
 smc_rx_splice+0xafc/0xe20 [smc]
 smc_rx_splice+0x756/0xe20 [smc])
 smc_rx_recvmsg+0xa74/0xe00 [smc]
 smc_splice_read+0x1ce/0x3b0 [smc]
 sock_splice_read+0xa2/0xf0
 do_splice_read+0x198/0x240
 splice_file_to_pipe+0x7e/0x110
 do_splice+0x59e/0xde0
 __do_splice+0x11a/0x2d0
 __s390x_sys_splice+0x140/0x1f0
 __do_syscall+0x122/0x280
 system_call+0x6e/0x90
Last Breaking-Event-Address:
smc_rx_splice+0x960/0xe20 [smc]
---[ end trace 0000000000000000 ]---

Fixes: f7a22071dbf3 ("net/smc: implement DMB-related operations of loopback-ism")
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
 net/smc/smc_loopback.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 0eb00bbefd17..77cc1c6dc3e9 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -56,6 +56,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 {
 	struct smc_lo_dmb_node *dmb_node, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
+	struct folio *folio;
 	int sba_idx, rc;
 
 	/* check space for new dmb */
@@ -74,13 +75,16 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 
 	dmb_node->sba_idx = sba_idx;
 	dmb_node->len = dmb->dmb_len;
-	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
-				     __GFP_NOWARN | __GFP_NORETRY |
-				     __GFP_NOMEMALLOC);
-	if (!dmb_node->cpu_addr) {
+
+	/* not critical; fail under memory pressure and fallback to TCP */
+	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
+			    __GFP_NORETRY | __GFP_ZERO,
+			    get_order(dmb_node->len));
+	if (!folio) {
 		rc = -ENOMEM;
 		goto err_node;
 	}
+	dmb_node->cpu_addr = folio_address(folio);
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
 	refcount_set(&dmb_node->refcnt, 1);
 
@@ -122,7 +126,7 @@ static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
 	write_unlock_bh(&ldev->dmb_ht_lock);
 
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kvfree(dmb_node->cpu_addr);
+	folio_put(virt_to_folio(dmb_node->cpu_addr));
 	kfree(dmb_node);
 
 	if (atomic_dec_and_test(&ldev->dmb_cnt))
-- 
2.49.0


