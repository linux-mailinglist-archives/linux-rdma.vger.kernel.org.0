Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842BB1D8EC9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgESEeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 00:34:02 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:16353
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgESEeB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 00:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUTWDIlfGkvg/uOyQzqmUx+vgSWtIXaakzeAWeEIXey1KlMt3bPbEzhvI1VTqRyuQRBd/CxNR7LZAXxh2u5R1FEQX2UiZnPo3vsNoieA0sAWiBzV0wHantADgE6NvjsyLd1cp+hKf8EhDJ72RmrLUUpBuKQOL+/PctxsGQq+hc3qeQattxfLPOlcPymbIiQbFvvLjuoN2ij+I9WBO3eHww4wWvztdsrQPjbN2bSyw5algyKyG2vLONZ1PpD+iXoXeOiwTen44148WQGGKZ27fTSqsW5//MLYSWf4Vpluh49J8tCT5l0Jj6yyUbaCktoRy8vkhC7MZG0mZh9Nfd5uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SKP/TlQGPQa6+4zKTlAtQWwwu6nMCD405rfvsHuHo8=;
 b=lXcs9wx28HLVUczp6EsEBNd/+3594v3P5dtm07WvWpn4kYzPHtl1KhpLVCZ3oMV4jN33mHTL882X7h+7JR2mdNe/YZOnoHzRGVtZIznc9rQrHeFBba7LR08jKctli+nXL/6nP6SwS8iFV7LHW1cbGkazE7uBICgLppBpDdtZXcaevaUlFbNbjT1hoMJn0aDwBpRefOQT8btLXeKfjHGQ1OBvVHodV73WDUoa4g8ISbYKhgyt9Ew5En03niSXbr+coctApaz98Y69GnjcnSQUDIl/kcT8lv8qUELaR8hjeVdL+ECQD++FV/okwiiYJuakoMy0ctD/Llq131tuTQUDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SKP/TlQGPQa6+4zKTlAtQWwwu6nMCD405rfvsHuHo8=;
 b=Bdx0NtBiR8pbbY+CWi8Zk7vxxltZhcbyua0btKZraFNUQ+K2i1/XPxC2WPKTmoxPp5WZcnBfQj0JmyOQliW7FMCnxYhXsOj9ngpihv3x3FA+JXmyB6UOyXs55oeP58I78pWQBvE43HZG9QKDyvix2MMI6jJ5ltiYcqJhb3vHyho=
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB5334.eurprd05.prod.outlook.com (2603:10a6:20b:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 04:33:56 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 04:33:56 +0000
Date:   Tue, 19 May 2020 07:33:53 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200519043353.GL188135@unreal>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-3-git-send-email-yaminf@mellanox.com>
 <20200518083032.GB185893@unreal>
 <a6281ce2-71e1-db0f-1038-8aa0db0aa6be@mellanox.com>
 <20200518174821.GB188135@unreal>
 <CANjDDBh32qgfYFv+cVbzYj7fE3+PRE3QqrhW-X7h=BQJzowX_g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBh32qgfYFv+cVbzYj7fE3+PRE3QqrhW-X7h=BQJzowX_g@mail.gmail.com>
X-ClientProxiedBy: AM3PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:207:5::21) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM3PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:207:5::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 04:33:56 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 546050b1-931b-409a-c427-08d7fbadd7b9
X-MS-TrafficTypeDiagnostic: AM6PR05MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5334CB5FC7D0A688B142EDEDB0B90@AM6PR05MB5334.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2pnOXLZSPPsj7oe3PPa/i8bk9p7fsN002cFMkNNQPO9f5ADL1s56DuEn8XkSSidE2SPD7eZ81//xKCm/GbFs4DOU9ZlWv2GFTyreWTwktyaiq2aDcB5pQ+ERUFHsNB5FOtLvC/QvtTf0S+sDxOd2bTSlAETIKX4Ia1pidMnOGsYKBDTMa1n+aR0jLggc2lY5Rf6h/+pb0CfDOMjR4G1FcEBQlK5UZ8jbH0U9kXzN+u9FwPNIEqMA4rQGM3dvTEE0tBDMxJZEejNxw3Bi8dQVhqxqxVzwnZtzaAYNmaKCW6OHFvGmrDrvTzqGs6Xz+WjXPap9LM7zKIMH0GDGKkBX7UR4N0uTWJQVhW4K7LVt2uGhDja/o1NANWRjeYrjCr+BsXNHR2o9GiGapnIoXoVe62UlvlPg0oMma4dFlRf/gGCADsiDLdUMU0Y4DmcJdXg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(9686003)(30864003)(66476007)(66556008)(4326008)(52116002)(33716001)(53546011)(6496006)(6916009)(54906003)(2906002)(5660300002)(33656002)(316002)(1076003)(478600001)(86362001)(66946007)(16526019)(186003)(8936002)(8676002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jkru0alZwXcgjOqFKgX2E/FSLSPwNrIkOmEsESja4hPr2DsjFkOFa/WfSNrFYPL1bM8cTdAqhs7N/GJiVK79387jQxWF3Zn5FkWEV0lzl8ye6g0pD8cDji0jhJdPbiQMvUcsWlqYHoiivRHeLbc4zjDnHMADYBIJDX2Z5ecRgRlWIoyvDBwfJwWp06xymZBxvWmtBt9PYJd8/Mw/6cUIWub4fX9M+DHhIQg/tthYWtK4aXiBSyhuzfN3wnd7HjwigAHjNFQFGjA4DOoGxpq7syXN/uTtPYSG0CNYWdGZFa3yuEh2z8HvHB4x44g4tNMB7IEPSFGC5VS4mFQy4KEveBsJODNFjfXh/Cz4Rj9J800ABpIRt/g5+EuxOgxyLPBYaAGw6qfwdnJ6WToRIjU/KFSWMPb8IcoEpts8Ocbtt4z3rvU29P22lVTHJEyXdDLhPMq6LOlM/X1fFEBHsAg/il/5Yxow25XqOD1T2t2BD0N25pIcNlDZhFQNSxfIglU+H1cKTiNqNlgnBG1m1k8dUg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546050b1-931b-409a-c427-08d7fbadd7b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 04:33:56.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP9X1ojzF3uWn5t72kHk/qweoBxEMyo+7E/qYMVjklOAH6oOMr3ff1CFYKq49U0COM1jItevAY/5aIzSgwsZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 09:57:58AM +0530, Devesh Sharma wrote:
> On Mon, May 18, 2020 at 11:18 PM Leon Romanovsky <leonro@mellanox.com> wrote:
> >
> > On Mon, May 18, 2020 at 04:16:05PM +0300, Yamin Friedman wrote:
> > >
> > > On 5/18/2020 11:30 AM, Leon Romanovsky wrote:
> > > > On Wed, May 13, 2020 at 02:52:41PM +0300, Yamin Friedman wrote:
> > > > > Allow a ULP to ask the core to provide a completion queue based on a
> > > > > least-used search on a per-device CQ pools. The device CQ pools grow in a
> > > > > lazy fashion when more CQs are requested.
> > > > >
> > > > > This feature reduces the amount of interrupts when using many QPs.
> > > > > Using shared CQs allows for more effcient completion handling. It also
> > > > > reduces the amount of overhead needed for CQ contexts.
> > > > >
> > > > > Test setup:
> > > > > Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> > > > > Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> > > > > TX-depth = 32. The patch was applied in the nvme driver on both the target
> > > > > and initiator. Four controllers are accessed from each core. In the
> > > > > current test case we have exposed sixteen NVMe namespaces using four
> > > > > different subsystems (four namespaces per subsystem) from one NVM port.
> > > > > Each controller allocated X queues (RDMA QPs) and attached to Y CQs.
> > > > > Before this series we had X == Y, i.e for four controllers we've created
> > > > > total of 4X QPs and 4X CQs. In the shared case, we've created 4X QPs and
> > > > > only X CQs which means that we have four controllers that share a
> > > > > completion queue per core. Until fourteen cores there is no significant
> > > > > change in performance and the number of interrupts per second is less than
> > > > > a million in the current case.
> > > > > ==================================================
> > > > > |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> > > > > |-----|---------------|--------------|-----------|
> > > > > |14   |2332           |2723          |16.7%      |
> > > > > |-----|---------------|--------------|-----------|
> > > > > |20   |2086           |2712          |30%        |
> > > > > |-----|---------------|--------------|-----------|
> > > > > |28   |1971           |2669          |35.4%      |
> > > > > |=================================================
> > > > > |Cores|Current avg lat|Shared avg lat|improvement|
> > > > > |-----|---------------|--------------|-----------|
> > > > > |14   |767us          |657us         |14.3%      |
> > > > > |-----|---------------|--------------|-----------|
> > > > > |20   |1225us         |943us         |23%        |
> > > > > |-----|---------------|--------------|-----------|
> > > > > |28   |1816us         |1341us        |26.1%      |
> > > > > ========================================================
> > > > > |Cores|Current interrupts|Shared interrupts|improvement|
> > > > > |-----|------------------|-----------------|-----------|
> > > > > |14   |1.6M/sec          |0.4M/sec         |72%        |
> > > > > |-----|------------------|-----------------|-----------|
> > > > > |20   |2.8M/sec          |0.6M/sec         |72.4%      |
> > > > > |-----|------------------|-----------------|-----------|
> > > > > |28   |2.9M/sec          |0.8M/sec         |63.4%      |
> > > > > ====================================================================
> > > > > |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> > > > > |-----|------------------------|-----------------------|-----------|
> > > > > |14   |67ms                    |6ms                    |90.9%      |
> > > > > |-----|------------------------|-----------------------|-----------|
> > > > > |20   |5ms                     |6ms                    |-10%       |
> > > > > |-----|------------------------|-----------------------|-----------|
> > > > > |28   |8.7ms                   |6ms                    |25.9%      |
> > > > > |===================================================================
> > > > >
> > > > > Performance improvement with sixteen disks (sixteen CQs per core) is
> > > > > comparable.
> > > > >
> > > > > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > > > > Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> > > > > Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > ---
> > > > >   drivers/infiniband/core/core_priv.h |   4 ++
> > > > >   drivers/infiniband/core/cq.c        | 137 ++++++++++++++++++++++++++++++++++++
> > > > >   drivers/infiniband/core/device.c    |   2 +
> > > > >   include/rdma/ib_verbs.h             |  35 +++++++++
> > > > >   4 files changed, 178 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> > > > > index cf42acc..fa3151b 100644
> > > > > --- a/drivers/infiniband/core/core_priv.h
> > > > > +++ b/drivers/infiniband/core/core_priv.h
> > > > > @@ -414,4 +414,8 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> > > > >                            struct vm_area_struct *vma,
> > > > >                            struct rdma_user_mmap_entry *entry);
> > > > >
> > > > > +void ib_cq_pool_init(struct ib_device *dev);
> > > > > +
> > > > > +void ib_cq_pool_destroy(struct ib_device *dev);
> > > > > +
> > > > >   #endif /* _CORE_PRIV_H */
> > > > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > > > index 04046eb..5319c14 100644
> > > > > --- a/drivers/infiniband/core/cq.c
> > > > > +++ b/drivers/infiniband/core/cq.c
> > > > > @@ -7,7 +7,11 @@
> > > > >   #include <linux/slab.h>
> > > > >   #include <rdma/ib_verbs.h>
> > > > >
> > > > > +#include "core_priv.h"
> > > > > +
> > > > >   #include <trace/events/rdma_core.h>
> > > > > +/* Max size for shared CQ, may require tuning */
> > > > > +#define IB_MAX_SHARED_CQ_SZ              4096
> > > > >
> > > > >   /* # of WCs to poll for with a single call to ib_poll_cq */
> > > > >   #define IB_POLL_BATCH                   16
> > > > > @@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
> > > > >           cq->cq_context = private;
> > > > >           cq->poll_ctx = poll_ctx;
> > > > >           atomic_set(&cq->usecnt, 0);
> > > > > + cq->comp_vector = comp_vector;
> > > > >
> > > > >           cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
> > > > >           if (!cq->wc)
> > > > > @@ -304,6 +309,8 @@ static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > > >   {
> > > > >           if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
> > > > >                   return;
> > > > > + if (WARN_ON_ONCE(cq->cqe_used != 0))
> > > > Let's do WARN_ON_ONCE(cq->cqe_used)
> > > >
> > > > > +         return;
> > > > >
> > > > >           switch (cq->poll_ctx) {
> > > > >           case IB_POLL_DIRECT:
> > > > > @@ -340,3 +347,133 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > > >                   _ib_free_cq_user(cq, udata);
> > > > >   }
> > > > >   EXPORT_SYMBOL(ib_free_cq_user);
> > > > > +
> > > > > +void ib_cq_pool_init(struct ib_device *dev)
> > > > > +{
> > > > > + int i;
> > > > > +
> > > > > + spin_lock_init(&dev->cq_pools_lock);
> > > > > + for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> > > > > +         INIT_LIST_HEAD(&dev->cq_pools[i]);
> > > > > +}
> > > > > +
> > > > > +void ib_cq_pool_destroy(struct ib_device *dev)
> > > > > +{
> > > > > + struct ib_cq *cq, *n;
> > > > > + int i;
> > > > > +
> > > > > + for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> > > > > +         list_for_each_entry_safe(cq, n, &dev->cq_pools[i], pool_entry)
> > > > > +                 _ib_free_cq_user(cq, NULL);
> > > > > + }
> > > > > +
> > > > > +}
> > > > > +
> > > > > +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> > > > > +                 enum ib_poll_context poll_ctx)
> > > > > +{
> > > > > + LIST_HEAD(tmp_list);
> > > > > + struct ib_cq *cq;
> > > > > + unsigned long flags;
> > > > > + int nr_cqs, ret, i;
> > > > > +
> > > > > + /*
> > > > > +  * Allocated at least as many CQEs as requested, and otherwise
> > > > > +  * a reasonable batch size so that we can share CQs between
> > > > > +  * multiple users instead of allocating a larger number of CQs.
> > > > > +  */
> > > > > + nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> > > > > + nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> > > > > + for (i = 0; i < nr_cqs; i++) {
> > > > > +         cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> > > > > +         if (IS_ERR(cq)) {
> > > > > +                 ret = PTR_ERR(cq);
> > > > > +                 goto out_free_cqs;
> > > > > +         }
> > > > > +         cq->shared = true;
> > > > > +         list_add_tail(&cq->pool_entry, &tmp_list);
> > > > > + }
> > > > > +
> > > > > + spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > > > > + list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> > > > > + spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > > +
> > > > > + return 0;
> > > > > +
> > > > > +out_free_cqs:
> > > > > + list_for_each_entry(cq, &tmp_list, pool_entry)
> > > > > +         ib_free_cq(cq);
> > > > > + return ret;
> > > > > +}
> > > > > +
> > > > > +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> > > > > +                      int comp_vector_hint,
> > > > > +                      enum ib_poll_context poll_ctx)
> > > > > +{
> > > > > + static unsigned int default_comp_vector;
> > > > > + int vector, ret, num_comp_vectors;
> > > > > + struct ib_cq *cq, *found = NULL;
> > > > > + unsigned long flags;
> > > > > +
> > > > > + if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
> > > > > +         return ERR_PTR(-EINVAL);
> > > > > +
> > > > > + num_comp_vectors = min_t(int, dev->num_comp_vectors,
> > > > > +                          num_online_cpus());
> > > > > + /* Project the affinty to the device completion vector range */
> > > > > + if (comp_vector_hint < 0)
> > > > > +         vector = default_comp_vector++ % num_comp_vectors;
> > > > > + else
> > > > > +         vector = comp_vector_hint % num_comp_vectors;
> > > > > +
> > > > > + /*
> > > > > +  * Find the least used CQ with correct affinity and
> > > > > +  * enough free CQ entries
> > > > > +  */
> > > > > + while (!found) {
> > > > > +         spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > > > > +         list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> > > > > +                             pool_entry) {
> > > > > +                 if (vector != cq->comp_vector)
> > > > I think that this check worth to have a comment.
> > > > At least for me, it is not clear if it will work correctly if
> > > > comp_vector == 0.
> > > >
> > > > > +                         continue;
> > > > > +                 if (cq->cqe_used + nr_cqe > cq->cqe)
> > > > > +                         continue;
> > > > > +                 if (found && cq->cqe_used >= found->cqe_used)
> > > > > +                         continue;
> > > > > +                 found = cq;
> > > > > +                 break;
> > > > > +         }
> > > > > +
> > > > > +         if (found) {
> > > > > +                 found->cqe_used += nr_cqe;
> > > > > +                 spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > > +
> > > > > +                 return found;
> > > > > +         }
> > > > > +         spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> > > > > +
> > > > > +         /*
> > > > > +          * Didn't find a match or ran out of CQs in the device
> > > > > +          * pool, allocate a new array of CQs.
> > > > > +          */
> > > > > +         ret = ib_alloc_cqs(dev, nr_cqe, poll_ctx);
> > > > > +         if (ret)
> > > > > +                 return ERR_PTR(ret);
> > > > > + }
> > > > > +
> > > > > + return found;
> > > > > +}
> > > > > +EXPORT_SYMBOL(ib_cq_pool_get);
> > > > > +
> > > > > +void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe)
> > > > > +{
> > > > > + unsigned long flags;
> > > > > +
> > > > > + if (nr_cqe > cq->cqe_used)
> > > > > +         return;
> > > > Is it possible?
> > > > 1. It is racy
> > > > 2. It is a bug in the ib_cq_pool_put() caller.
> > >
> > > It is possible, the pool doesn't save the amount of cqes used per user.
> >
> > So, #2 from the list above.
> >
> > >
> > > I think to make it really secure I would have to never reduce the cqes used,
> > > save the number of active users, and have some form of garbage collection
> > > for used up CQs but that seems to me a lot for something that should not
> > > occur during proper use.
> > >
> > > Would it be better to just have a WARN for this case?
> >
> > I think so.
> >
> It would be better to fail the pool creation with WARN, because there
> may not be any benefit of having a pooled CQs if comp-vectors = 0 for
> any given provider.
> Using what strategy CQs are pulled from the pool is it FCFS? I did not
> checked the complete patch, but is it possible to balance the load
> across all the CQs present in the pool?

Yes, this is what Yamin is doing, he chooses less occupied CQ from the pool.

Thanks

> > Thanks
