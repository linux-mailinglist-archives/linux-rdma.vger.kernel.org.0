Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8993CCCF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390442AbfFKNVV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 09:21:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387764AbfFKNVV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 09:21:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BDIvMe107433
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 09:21:19 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2ct418ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 09:21:19 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 13:21:18 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 13:21:16 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019061113211516-528977 ;
          Tue, 11 Jun 2019 13:21:15 +0000 
In-Reply-To: 
Subject: receive side CRC computation in siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 13:21:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: 
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: BD80408B:8C25683E-00258416:0047A63B;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 35715
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061113-9695-0000-0000-0000067C3BFE
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.405233; ST=0; TS=0; UL=0; ISC=; MB=0.032118
X-IBM-SpamModules-Versions: BY=3.00011246; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216439; UDB=6.00639591; IPR=6.00997539;
 BA=6.00006331; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027261; XFM=3.00000015;
 UTC=2019-06-11 13:21:17
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:40:24 - 6.00010036
x-cbparentid: 19061113-9696-0000-0000-000067C140EC
Message-Id: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

If enabled for siw, during receive operation, a crc32c over
header and data is being generated and checked. So far, siw
was generating that CRC from the content of the just written
target buffer. What kept me busy last weekend were spurious
CRC errors, if running qperf. I finally found the application
is constantly writing the target buffer while data are placed
concurrently, which sometimes races with the CRC computation
for that buffer, and yields a broken CRC.

siw uses skb_copy_bits() to move the data. I now added an
extra round of skb walking via __skb_checksum() in front of
it, which resolves the issue. Unfortunately, performance
significantly drops with that (some 30% or worse compared
to generating the CRC from a linear buffer).

To preserve performance for kernel clients, I propose
checksumming the data before the copy only for user
land applications, and leave it as is for kernel clients.
I am not aware of kernel clients which are constantly
reading/writing a target buffer to detect it has been written. 
I also checked other kernel code using skb_copy_bits(),
which also needs to checksum the received data. Those code
(such as nvme tcp) also does the CRC on the linear buffer
after data receive.

The best solution might be to fold the CRC into the
skb_copy_bits() function itself. That being something we
might propose later?

Thoughts?


Many thanks,
Bernard.

