Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C371A9866
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895333AbgDOJUR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 Apr 2020 05:20:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895327AbgDOJUD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:20:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F93Pn3004465
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 05:20:02 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dnn7y1xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 05:20:01 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 15 Apr 2020 09:20:00 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 15 Apr 2020 09:19:53 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020041509195289-258098 ;
          Wed, 15 Apr 2020 09:19:52 +0000 
In-Reply-To: <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Xiyu Yang" <xiyuyang19@fudan.edu.cn>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, "Xin Tan" <tanxin.ctf@gmail.com>
Date:   Wed, 15 Apr 2020 09:19:52 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP64 March 05, 2020 at 12:58
X-KeepSent: 71AC5E77:84B4E5A4-0025854B:003341FF;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 39343
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20041509-3017-0000-0000-0000029572CC
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000163
X-IBM-SpamModules-Versions: BY=3.00012915; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01362717; UDB=6.00727583; IPR=6.01145084;
 MB=3.00031710; MTD=3.00000008; XFM=3.00000015; UTC=2020-04-15 09:19:58
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-04-15 06:42:08 - 6.00011244
x-cbparentid: 20041509-3018-0000-0000-0000DD917875
Message-Id: <OF71AC5E77.84B4E5A4-ON0025854B.003341FF-0025854B.00334209@notes.na.collabserv.com>
Subject: Re:  [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in nr_add_node
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_01:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----linux-rdma-owner@vger.kernel.org wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>From: "Xiyu Yang" 
>Sent by: linux-rdma-owner@vger.kernel.org
>Date: 04/15/2020 10:46AM
>Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, "Xiyu Yang"
><xiyuyang19@fudan.edu.cn>, "Xin Tan" <tanxin.ctf@gmail.com>
>Subject: [EXTERNAL] [PATCH] RDMA/siw: Fix potential siw_mem refcnt
>leak in nr_add_node
>
>siw_fastreg_mr() invokes siw_mem_id2obj(), which returns a local
>reference of the siw_mem object to "mem" with increased refcnt.
>When siw_fastreg_mr() returns, "mem" becomes invalid, so the refcount
>should be decreased to keep refcount balanced.
>
>The issue happens in one error path of siw_fastreg_mr(). When
>"base_mr"
>equals to NULL but "mem" is not NULL, the function forgets to
>decrease
>the refcnt increased by siw_mem_id2obj() and causes a refcnt leak.
>
>Fix this issue by calling siw_mem_put() on this error path when mem
>is
>not NULL.
>
>Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index ae92c8080967..86044a44b83b 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -926,6 +926,8 @@ static int siw_fastreg_mr(struct ib_pd *pd,
>struct siw_sqe *sqe)
> 	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
> 
> 	if (unlikely(!mem || !base_mr)) {
>+		if (mem)
>+			siw_mem_put(mem);
> 		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
> 		return -EINVAL;
> 	}
>-- 

I agree - thanks for the fix!


Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

