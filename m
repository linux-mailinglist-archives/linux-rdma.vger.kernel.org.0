Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66D65B88
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfGKQ2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jul 2019 12:28:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728226AbfGKQ2T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 12:28:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BGNDvn004002
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 12:28:18 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp7nqjxwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 12:28:18 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 11 Jul 2019 16:28:17 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 11 Jul 2019 16:28:11 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071116281124-603891 ;
          Thu, 11 Jul 2019 16:28:11 +0000 
In-Reply-To: <20190711161218.GA4989@embeddedor>
Subject: Re: [PATCH] RDMA/siw: Mark expected switch fall-throughs
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 16:28:10 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190711161218.GA4989@embeddedor>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: BB618A17:F92ECEDA-00258434:005A1205;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 62223
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071116-3721-0000-0000-000006F3A05C
X-IBM-SpamModules-Scores: BY=0.002733; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000100
X-IBM-SpamModules-Versions: BY=3.00011410; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230700; UDB=6.00648256; IPR=6.01011975;
 BA=6.00006355; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027681; XFM=3.00000015;
 UTC=2019-07-11 16:28:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-11 16:14:30 - 6.00010152
x-cbparentid: 19071116-3722-0000-0000-0000FEA2B324
Message-Id: <OFBB618A17.F92ECEDA-ON00258434.005A1205-00258434.005A7884@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>Date: 07/11/2019 06:12PM
>Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
>"Gustavo A. R. Silva" <gustavo@embeddedor.com>
>Subject: [EXTERNAL] [PATCH] RDMA/siw: Mark expected switch
>fall-throughs
>
>In preparation to enabling -Wimplicit-fallthrough, mark switch
>cases where we are expecting to fall through.
>
>This patch fixes the following warnings:
>
>drivers/infiniband/sw/siw/siw_qp_rx.c: In function
>‘siw_rdmap_complete’:
>drivers/infiniband/sw/siw/siw_qp_rx.c:1214:18: warning: this
>statement may fall through [-Wimplicit-fallthrough=]
>   wqe->rqe.flags |= SIW_WQE_SOLICITED;
>   ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw_qp_rx.c:1215:2: note: here
>  case RDMAP_SEND:
>  ^~~~
>
>drivers/infiniband/sw/siw/siw_qp_tx.c: In function
>‘siw_qp_sq_process’:
>drivers/infiniband/sw/siw/siw_qp_tx.c:1044:4: warning: this statement
>may fall through [-Wimplicit-fallthrough=]
>    siw_wqe_put_mem(wqe, tx_type);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw_qp_tx.c:1045:3: note: here
>   case SIW_OP_INVAL_STAG:
>   ^~~~
>drivers/infiniband/sw/siw/siw_qp_tx.c:1128:4: warning: this statement
>may fall through [-Wimplicit-fallthrough=]
>    siw_wqe_put_mem(wqe, tx_type);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw_qp_tx.c:1129:3: note: here
>   case SIW_OP_INVAL_STAG:
>   ^~~~
>
>Warning level 3 was used: -Wimplicit-fallthrough=3
>
>This patch is part of the ongoing efforts to enable
>-Wimplicit-fallthrough.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>---
>
>NOTE: -Wimplicit-fallthrough will be enabled globally in v5.3. So, I
>      suggest you to take this patch for 5.3-rc1.
>
> drivers/infiniband/sw/siw/siw_qp_rx.c | 2 ++
> drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++++
> 2 files changed, 6 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
>b/drivers/infiniband/sw/siw/siw_qp_rx.c
>index 682a290bc11e..f87657a11657 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>@@ -1212,6 +1212,8 @@ static int siw_rdmap_complete(struct siw_qp
>*qp, int error)
> 	case RDMAP_SEND_SE:
> 	case RDMAP_SEND_SE_INVAL:
> 		wqe->rqe.flags |= SIW_WQE_SOLICITED;
>+		/* Fall through */
>+
> 	case RDMAP_SEND:
> 	case RDMAP_SEND_INVAL:
> 		if (wqe->wr_status == SIW_WR_IDLE)
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index f0d949e2e318..43020d2040fc 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -1042,6 +1042,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
> 		case SIW_OP_SEND_REMOTE_INV:
> 		case SIW_OP_WRITE:
> 			siw_wqe_put_mem(wqe, tx_type);
>+			/* Fall through */
>+
> 		case SIW_OP_INVAL_STAG:
> 		case SIW_OP_REG_MR:
> 			if (tx_flags(wqe) & SIW_WQE_SIGNALLED)
>@@ -1126,6 +1128,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
> 		case SIW_OP_READ:
> 		case SIW_OP_READ_LOCAL_INV:
> 			siw_wqe_put_mem(wqe, tx_type);
>+			/* Fall through */
>+
> 		case SIW_OP_INVAL_STAG:
> 		case SIW_OP_REG_MR:
> 			siw_sqe_complete(qp, &wqe->sqe, wqe->bytes,
>-- 
>2.21.0
>
>
Thanks Gustavo. Didn't know that becomes mandatory. Had it here and there
only, where I thought it is not obvious...but better to keep the rules
simple.

Thanks,
Bernard.

