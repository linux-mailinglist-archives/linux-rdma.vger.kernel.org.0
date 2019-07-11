Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC936530C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGKIW3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jul 2019 04:22:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfGKIW2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 04:22:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6B8MQAU128082
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 04:22:27 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tp0q3261n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 04:22:26 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 11 Jul 2019 08:22:16 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 11 Jul 2019 08:22:11 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071108221042-166196 ;
          Thu, 11 Jul 2019 08:22:10 +0000 
In-Reply-To: <20190711071213.57880-1-yuehaibing@huawei.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "YueHaibing" <yuehaibing@huawei.com>
Cc:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Date:   Thu, 11 Jul 2019 08:22:10 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190711071213.57880-1-yuehaibing@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 7C58670D:824A65B3-00258434:002DF9B8;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 33595
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071108-1529-0000-0000-000006734F2D
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.026953
X-IBM-SpamModules-Versions: BY=3.00011408; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230538; UDB=6.00648159; IPR=6.01011814;
 BA=6.00006354; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027677; XFM=3.00000015;
 UTC=2019-07-11 08:22:14
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-11 03:28:48 - 6.00010150
x-cbparentid: 19071108-1530-0000-0000-0000737676C2
Message-Id: <OF7C58670D.824A65B3-ON00258434.002DF9B8-00258434.002DF9C1@notes.na.collabserv.com>
Subject: Re:  [PATCH -next] rdma/siw: remove set but not used variable 's'
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"YueHaibing" <yuehaibing@huawei.com> wrote: -----

>To: <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
>From: "YueHaibing" <yuehaibing@huawei.com>
>Date: 07/11/2019 09:13AM
>Cc: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
>"YueHaibing" <yuehaibing@huawei.com>
>Subject: [EXTERNAL] [PATCH -next] rdma/siw: remove set but not used
>variable 's'
>
>Fixes gcc '-Wunused-but-set-variable' warning:
>
>drivers/infiniband/sw/siw/siw_cm.c: In function
>siw_cm_llp_state_change:
>drivers/infiniband/sw/siw/siw_cm.c:1278:17: warning: variable s set
>but not used [-Wunused-but-set-variable]
>
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>---
> drivers/infiniband/sw/siw/siw_cm.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index c883bf5..7d87a78 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -1275,7 +1275,6 @@ static void siw_cm_llp_error_report(struct sock
>*sk)
> static void siw_cm_llp_state_change(struct sock *sk)
> {
> 	struct siw_cep *cep;
>-	struct socket *s;
> 	void (*orig_state_change)(struct sock *s);
> 
> 	read_lock(&sk->sk_callback_lock);
>@@ -1288,8 +1287,6 @@ static void siw_cm_llp_state_change(struct sock
>*sk)
> 	}
> 	orig_state_change = cep->sk_state_change;
> 
>-	s = sk->sk_socket;
>-
> 	siw_dbg_cep(cep, "state: %d\n", cep->state);
> 
> 	switch (sk->sk_state) {
>-- 
>2.7.4
>
>
>

Another bad leftover from excessive debugging times...

Thanks alot Yue!
Bernard.

