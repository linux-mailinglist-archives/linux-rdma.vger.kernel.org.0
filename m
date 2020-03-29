Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8D196E08
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgC2PBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 29 Mar 2020 11:01:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727942AbgC2PBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 11:01:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02TEgiRV045599
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 11:01:44 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3022qfa6sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 11:01:44 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sun, 29 Mar 2020 15:01:43 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Sun, 29 Mar 2020 15:01:37 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2020032915013628-285089 ;
          Sun, 29 Mar 2020 15:01:36 +0000 
In-Reply-To: <202003281643.02SGhN9T020186@sdf.org>
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "George Spelvin" <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Sun, 29 Mar 2020 15:01:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <202003281643.02SGhN9T020186@sdf.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP64 March 05, 2020 at 12:58
X-LLNOutbound: False
X-Disclaimed: 26727
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20032915-7279-0000-0000-000002561FD4
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.004176
X-IBM-SpamModules-Versions: BY=3.00012839; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01354713; UDB=6.00722867; IPR=6.01137129;
 MB=3.00031446; MTD=3.00000008; XFM=3.00000015; UTC=2020-03-29 15:01:42
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-03-29 11:43:32 - 6.00011176
x-cbparentid: 20032915-7280-0000-0000-00004F3820AE
Message-Id: <OF05D43316.2F69D46F-ON0025853A.00513FE8-0025853A.00528B66@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-29_04:2020-03-27,2020-03-29 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"George Spelvin" <lkml@sdf.org> wrote: -----

>To: linux-kernel@vger.kernel.org, lkml@sdf.org
>From: "George Spelvin" <lkml@sdf.org>
>Date: 03/28/2020 05:43PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@mellanox.com>, linux-rdma@vger.kernel.org, "Faisal Latif"
><faisal.latif@intel.com>, "Shiraz Saleem" <shiraz.saleem@intel.com>,
>"Bart Van Assche" <bvanassche@acm.org>, "Bernard Metzler"
><bmt@zurich.ibm.com>
>Subject: [EXTERNAL] [RFC PATCH v1 42/50] drivers/ininiband: Use
>get_random_u32()
>
>There's no need to get_random_bytes() into a temporary buffer.
>
>This is not a no-brainer change; get_random_u32() has slightly weaker
>security guarantees, but code like this is the classic example of
>when
>it's appropriate: the random value is stored in the kernel for as
>long
>as it's valuable.
>
>TODO: Could any of the call sites be further weakened to
>prandom_u32()?
>If we're randomizing to avoid collisions with a *cooperating* (as
>opposed
>to malicious) partner, we don't need cryptographic strength.
>
>Signed-off-by: George Spelvin <lkml@sdf.org>
>Cc: Doug Ledford <dledford@redhat.com>
>Cc: Jason Gunthorpe <jgg@mellanox.com>
>Cc: linux-rdma@vger.kernel.org
>Cc: Faisal Latif <faisal.latif@intel.com>
>Cc: Shiraz Saleem <shiraz.saleem@intel.com>
>Cc: Bart Van Assche <bvanassche@acm.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>---
> drivers/infiniband/core/cm.c              | 2 +-
> drivers/infiniband/core/cma.c             | 3 +--
> drivers/infiniband/core/sa_query.c        | 2 +-
> drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 +-
> drivers/infiniband/sw/siw/siw_mem.c       | 9 ++-------
> drivers/infiniband/sw/siw/siw_verbs.c     | 2 +-
> drivers/infiniband/ulp/srp/ib_srp.c       | 3 +--
> 7 files changed, 8 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/infiniband/core/cm.c
>b/drivers/infiniband/core/cm.c
>index 4decc1d4cc997..8af4368faf8ee 100644
>--- a/drivers/infiniband/core/cm.c
>+++ b/drivers/infiniband/core/cm.c
>@@ -4449,7 +4449,7 @@ static int __init ib_cm_init(void)
> 	cm.remote_qp_table = RB_ROOT;
> 	cm.remote_sidr_table = RB_ROOT;
> 	xa_init_flags(&cm.local_id_table, XA_FLAGS_ALLOC |
>XA_FLAGS_LOCK_IRQ);
>-	get_random_bytes(&cm.random_id_operand, sizeof
>cm.random_id_operand);
>+	cm.random_id_operand = (__force __be32)get_random_u32();
> 	INIT_LIST_HEAD(&cm.timewait_list);
> 
> 	ret = class_register(&cm_class);
>diff --git a/drivers/infiniband/core/cma.c
>b/drivers/infiniband/core/cma.c
>index a5874d2fac54e..1fce71e625c15 100644
>--- a/drivers/infiniband/core/cma.c
>+++ b/drivers/infiniband/core/cma.c
>@@ -873,9 +873,8 @@ struct rdma_cm_id *__rdma_create_id(struct net
>*net,
> 	mutex_init(&id_priv->handler_mutex);
> 	INIT_LIST_HEAD(&id_priv->listen_list);
> 	INIT_LIST_HEAD(&id_priv->mc_list);
>-	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
>+	id_priv->seq_num = get_random_u32() & 0x00ffffff;
> 	id_priv->id.route.addr.dev_addr.net = get_net(net);
>-	id_priv->seq_num &= 0x00ffffff;
> 
> 	return &id_priv->id;
> }
>diff --git a/drivers/infiniband/core/sa_query.c
>b/drivers/infiniband/core/sa_query.c
>index 30d4c126a2db0..0db882e247234 100644
>--- a/drivers/infiniband/core/sa_query.c
>+++ b/drivers/infiniband/core/sa_query.c
>@@ -2426,7 +2426,7 @@ int ib_sa_init(void)
> {
> 	int ret;
> 
>-	get_random_bytes(&tid, sizeof tid);
>+	tid = get_random_u32();
> 
> 	atomic_set(&ib_nl_sa_request_seq, 0);
> 
>diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>index dbd96d029d8bd..4c62b3a4f4233 100644
>--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>@@ -1262,7 +1262,7 @@ static u32 i40iw_create_stag(struct
>i40iw_device *iwdev)
> 	u8 consumer_key;
> 	int ret;
> 
>-	get_random_bytes(&random, sizeof(random));
>+	random = get_random_u32();
> 	consumer_key = (u8)random;
> 
> 	driver_key = random & ~iwdev->mr_stagmask;
>diff --git a/drivers/infiniband/sw/siw/siw_mem.c
>b/drivers/infiniband/sw/siw/siw_mem.c
>index e99983f076631..50c84f6a98e51 100644
>--- a/drivers/infiniband/sw/siw/siw_mem.c
>+++ b/drivers/infiniband/sw/siw/siw_mem.c
>@@ -21,10 +21,7 @@
> int siw_mem_add(struct siw_device *sdev, struct siw_mem *m)
> {
> 	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
>-	u32 id, next;
>-
>-	get_random_bytes(&next, 4);
>-	next &= 0x00ffffff;
>+	u32 id, next = get_random_u32() & 0x00ffffff;
> 
> 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, m, limit, &next,
> 	    GFP_KERNEL) < 0)
>@@ -107,9 +104,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct
>ib_pd *pd, void *mem_obj,
> 	kref_init(&mem->ref);
> 
> 	mr->mem = mem;
>-
>-	get_random_bytes(&next, 4);
>-	next &= 0x00ffffff;
>+	next = get_random_u32() & 0x00ffffff;
> 
> 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
> 	    GFP_KERNEL) < 0) {
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 5fd6d6499b3d7..42f3ced4ca7c7 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -1139,7 +1139,7 @@ int siw_create_cq(struct ib_cq *base_cq, const
>struct ib_cq_init_attr *attr,
> 		rv = -ENOMEM;
> 		goto err_out;
> 	}
>-	get_random_bytes(&cq->id, 4);
>+	cq->id = get_random_u32();
> 	siw_dbg(base_cq->device, "new CQ [%u]\n", cq->id);
> 
> 	spin_lock_init(&cq->lock);
>diff --git a/drivers/infiniband/ulp/srp/ib_srp.c
>b/drivers/infiniband/ulp/srp/ib_srp.c
>index cd1181c39ed29..2a954db0d6b55 100644
>--- a/drivers/infiniband/ulp/srp/ib_srp.c
>+++ b/drivers/infiniband/ulp/srp/ib_srp.c
>@@ -903,8 +903,7 @@ static int srp_send_req(struct srp_rdma_ch *ch,
>uint32_t max_iu_len,
> 		req->ib_param.primary_path = &ch->ib_cm.path;
> 		req->ib_param.alternate_path = NULL;
> 		req->ib_param.service_id = target->ib_cm.service_id;
>-		get_random_bytes(&req->ib_param.starting_psn, 4);
>-		req->ib_param.starting_psn &= 0xffffff;
>+		req->ib_param.starting_psn = get_random_u32() & 0xffffff;
> 		req->ib_param.qp_num = ch->qp->qp_num;
> 		req->ib_param.qp_type = ch->qp->qp_type;
> 		req->ib_param.local_cm_response_timeout = subnet_timeout + 2;
>-- 
>2.26.0
>
>

Speaking for the siw driver only, these two changes are looking
good to me. What is needed is a pseudo-random number, not
to easy to guess for the application. get_random_u32() provides that.

Thanks!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

