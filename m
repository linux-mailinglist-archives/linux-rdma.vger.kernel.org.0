Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507F0E456B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407793AbfJYIQW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 25 Oct 2019 04:16:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407695AbfJYIQV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Oct 2019 04:16:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P87Ij6141238
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 04:16:21 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vuujh3e99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 04:16:20 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 25 Oct 2019 08:16:20 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 25 Oct 2019 08:16:16 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019102508161577-166956 ;
          Fri, 25 Oct 2019 08:16:15 +0000 
In-Reply-To: <20191024203841.GA7912@mwanda>
Subject: Re: [bug report] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Doug Ledford" <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 25 Oct 2019 08:16:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191024203841.GA7912@mwanda>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-LLNOutbound: False
X-Disclaimed: 51467
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19102508-2475-0000-0000-0000011E469A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000897
X-IBM-SpamModules-Versions: BY=3.00011994; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01280429; UDB=6.00678489; IPR=6.01062571;
 MB=3.00029233; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-25 08:16:19
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-25 07:57:11 - 6.00010570
x-cbparentid: 19102508-2476-0000-0000-00002D9B8379
Message-Id: <OF9EE3BDCA.84D0CB33-ON0025849E.002C56C0-0025849E.002D6F03@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----

>To: bmt@zurich.ibm.com
>From: "Dan Carpenter" <dan.carpenter@oracle.com>
>Date: 10/24/2019 10:39PM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] [bug report] RDMA/siw: Fix SQ/RQ drain logic
>
>Hello Bernard Metzler,
>
>The patch cf049bb31f71: "RDMA/siw: Fix SQ/RQ drain logic" from Oct 4,
>2019, leads to the following static checker warning:
>
>	drivers/infiniband/sw/siw/siw_verbs.c:1079 siw_post_receive()
>	error: locking inconsistency.  We assume 'read_sem:&qp->state_lock'
>is both locked and unlocked at the start.
>
>drivers/infiniband/sw/siw/siw_verbs.c
>   978  int siw_post_receive(struct ib_qp *base_qp, const struct
>ib_recv_wr *wr,
>   979                       const struct ib_recv_wr **bad_wr)
>   980  {
>   981          struct siw_qp *qp = to_siw_qp(base_qp);
>   982          unsigned long flags;
>   983          int rv = 0;
>   984  
>   985          if (qp->srq) {
>   986                  *bad_wr = wr;
>   987                  return -EOPNOTSUPP; /* what else from
>errno.h? */
>   988          }
>   989          if (!qp->kernel_verbs) {
>   990                  siw_dbg_qp(qp, "no kernel post_recv for user
>mapped sq\n");
>   991                  up_read(&qp->state_lock);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^
>The patch changes the locking so this isn't held here and should be
>released.  Should it be held, though?

Yes, this is a BUG. Thanks very much! There is no qp spinlock to 
be held here. I moved that down to state checking. No need to
hold the qp lock before. 

Shall I re-send, or can we just amend the patch,
removing that single 'up_read()' line?

Thanks very much,
Bernard


>
>   992                  *bad_wr = wr;
>   993                  return -EINVAL;
>   994          }
>   995  
>   996          /*
>   997           * Try to acquire QP state lock. Must be non-blocking
>   998           * to accommodate kernel clients needs.
>   999           */
>  1000          if (!down_read_trylock(&qp->state_lock)) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>  1001                  if (qp->attrs.state == SIW_QP_STATE_ERROR) {
>  1002                          /*
>  1003                           * ERROR state is final, so we can be
>sure
>  1004                           * this state will not change as long
>as the QP
>  1005                           * exists.
>  1006                           *
>  1007                           * This handles an ib_drain_rq() call
>with
>  1008                           * a concurrent request to set the QP
>state
>  1009                           * to ERROR.
>  1010                           */
>  1011                          rv = siw_rq_flush_wr(qp, wr, bad_wr);
>  1012                  } else {
>
>regards,
>dan carpenter
>
>

