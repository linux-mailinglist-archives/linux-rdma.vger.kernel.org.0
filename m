Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88477857
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jul 2019 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfG0LED convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 27 Jul 2019 07:04:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfG0LED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 27 Jul 2019 07:04:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6RB21cN128420
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jul 2019 07:04:01 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u0fgd99p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jul 2019 07:04:01 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sat, 27 Jul 2019 11:04:01 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Sat, 27 Jul 2019 11:03:56 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2019072711035656-189150 ;
          Sat, 27 Jul 2019 11:03:56 +0000 
In-Reply-To: <20190726081056.GA27059@mwanda>
Subject: Re: [bug report] rdma/siw: queue pair methods
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Sat, 27 Jul 2019 11:03:55 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190726081056.GA27059@mwanda>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 38811
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19072711-1799-0000-0000-00000C6641AF
X-IBM-SpamModules-Scores: BY=0.027886; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.005657
X-IBM-SpamModules-Versions: BY=3.00011502; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01238140; UDB=6.00652715; IPR=6.01019530;
 BA=6.00006357; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027914; XFM=3.00000015;
 UTC=2019-07-27 11:03:59
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-27 08:09:54 - 6.00010215
x-cbparentid: 19072711-1800-0000-0000-0000008E4524
Message-Id: <OF61E386ED.49A73798-ON00258444.003BD6A6-00258444.003CC8D9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----

>To: bmt@zurich.ibm.com
>From: "Dan Carpenter" <dan.carpenter@oracle.com>
>Date: 07/26/2019 10:11AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] [bug report] rdma/siw: queue pair methods
>
>Hello Bernard Metzler,
>
>The patch f29dd55b0236: "rdma/siw: queue pair methods" from Jun 20,
>2019, leads to the following static checker warning:
>
>	drivers/infiniband/sw/siw/siw_qp.c:226 siw_qp_enable_crc()
>	warn: variable dereferenced before check 'siw_crypto_shash' (see
>line 223)
>
>drivers/infiniband/sw/siw/siw_qp.c
>   219  static int siw_qp_enable_crc(struct siw_qp *qp)
>   220  {
>   221          struct siw_rx_stream *c_rx = &qp->rx_stream;
>   222          struct siw_iwarp_tx *c_tx = &qp->tx_ctx;
>   223          int size = crypto_shash_descsize(siw_crypto_shash) +
>                                                 ^^^^^^^^^^^^^^^^
>Dereferenced inside function.
>
>   224                          sizeof(struct shash_desc);
>   225  
>   226          if (siw_crypto_shash == NULL)
>                    ^^^^^^^^^^^^^^^^^^^^^^^^
>Checked too late.
>
>   227                  return -ENOENT;
>   228  
>   229          c_tx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
>   230          c_rx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
>   231          if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {
>   232                  kfree(c_tx->mpa_crc_hd);
>   233                  kfree(c_rx->mpa_crc_hd);
>   234                  c_tx->mpa_crc_hd = NULL;
>   235                  c_rx->mpa_crc_hd = NULL;
>   236                  return -ENOMEM;
>   237          }
>   238          c_tx->mpa_crc_hd->tfm = siw_crypto_shash;
>   239          c_rx->mpa_crc_hd->tfm = siw_crypto_shash;
>   240  
>   241          return 0;
>   242  }
>
>regards,
>dan carpenter
>
>

Hi Dan,
many thanks for catching this one! The fix of course is simple:


From c13b5da99aea7766a61aabe33e9943618f4505cf Mon Sep 17 00:00:00 2001
From: Bernard Metzler <bmt@zurich.ibm.com>
Date: Sat, 27 Jul 2019 12:38:32 +0200
Subject: [PATCH] Do not dereference 'siw_crypto_shash' before checking

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 11383d9f95ef..e27bd5b35b96 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -220,12 +220,14 @@ static int siw_qp_enable_crc(struct siw_qp *qp)
 {
 	struct siw_rx_stream *c_rx = &qp->rx_stream;
 	struct siw_iwarp_tx *c_tx = &qp->tx_ctx;
-	int size = crypto_shash_descsize(siw_crypto_shash) +
-			sizeof(struct shash_desc);
+	int size;
 
 	if (siw_crypto_shash == NULL)
 	return -ENOENT;
 
+	size = crypto_shash_descsize(siw_crypto_shash) +
+		sizeof(struct shash_desc);
+
 	c_tx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
 	c_rx->mpa_crc_hd = kzalloc(size, GFP_KERNEL);
 	if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {
-- 
2.17.2

