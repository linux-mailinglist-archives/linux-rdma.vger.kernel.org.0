Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5246EE5C
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jul 2019 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfGTICJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 20 Jul 2019 04:02:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfGTICI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Jul 2019 04:02:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6K7vSje066387
        for <linux-rdma@vger.kernel.org>; Sat, 20 Jul 2019 04:02:07 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tux4d1gt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sat, 20 Jul 2019 04:02:07 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sat, 20 Jul 2019 08:02:06 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Sat, 20 Jul 2019 08:02:00 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019072008015996-126596 ;
          Sat, 20 Jul 2019 08:01:59 +0000 
In-Reply-To: <20190719012938.100628-1-maowenan@huawei.com>
Subject: Re: [PATCH -next] infiniband: siw: remove set but not used variables 'rv'
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Mao Wenan" <maowenan@huawei.com>
Cc:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date:   Sat, 20 Jul 2019 08:01:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190719012938.100628-1-maowenan@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 775
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19072008-0327-0000-0000-00000C071D23
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.017273
X-IBM-SpamModules-Versions: BY=3.00011461; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234777; UDB=6.00650736; IPR=6.01016115;
 BA=6.00006356; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027814; XFM=3.00000015;
 UTC=2019-07-20 08:02:04
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-20 01:42:31 - 6.00010186
x-cbparentid: 19072008-0328-0000-0000-0000183448A0
Message-Id: <OF77C0BA7B.17273086-ON0025843D.002C20A5-0025843D.002C20AD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Mao Wenan" <maowenan@huawei.com> wrote: -----

>To: <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
>From: "Mao Wenan" <maowenan@huawei.com>
>Date: 07/19/2019 03:24AM
>Cc: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
><kernel-janitors@vger.kernel.org>, "Mao Wenan" <maowenan@huawei.com>
>Subject: [EXTERNAL] [PATCH -next] infiniband: siw: remove set but not
>used variables 'rv'
>
>Fixes gcc '-Wunused-but-set-variable' warning:
>
>drivers/infiniband/sw/siw/siw_cm.c: In function siw_cep_set_inuse:
>drivers/infiniband/sw/siw/siw_cm.c:223:6: warning: variable rv set
>but not used [-Wunused-but-set-variable]
>
>It is not used since commit 6c52fdc244b5("rdma/siw: connection
>management")
>
>Signed-off-by: Mao Wenan <maowenan@huawei.com>
>---
> drivers/infiniband/sw/siw/siw_cm.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index a7cde98..9ce8a1b 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -220,13 +220,12 @@ static void siw_put_work(struct siw_cm_work
>*work)
> static void siw_cep_set_inuse(struct siw_cep *cep)
> {
> 	unsigned long flags;
>-	int rv;
> retry:
> 	spin_lock_irqsave(&cep->lock, flags);
> 
> 	if (cep->in_use) {
> 		spin_unlock_irqrestore(&cep->lock, flags);
>-		rv = wait_event_interruptible(cep->waitq, !cep->in_use);
>+		wait_event_interruptible(cep->waitq, !cep->in_use);
> 		if (signal_pending(current))
> 			flush_signals(current);
> 		goto retry;
>-- 
>2.7.4
>
>

Mao, many thanks for finding that. So, yes, 'rv'  shall be removed.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

