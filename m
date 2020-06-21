Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBADB202B1F
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgFUOmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 10:42:04 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:51397
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730147AbgFUOmE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 10:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP5E9d7AKjkDapVmiL0cku5KbNPbE3tgcCDRQYO5Nat0yxxbCE4UrZJBSpA/4WOwxUePSjO0L6i35M6REDLGATCGGAR5OXNdVXfCw5HzVFraJsQ+xBlahPWZN98OFwpsW5yoekLsa22HC9qI97re0WgRqpg8dLNn97LpFKD8ft5c/JhRcjEAj9LW5tV/RsKLFiRjaiCWNslSbtOfpLY95LONiAm0XRHyBU2OW/moMwJ5YoK0e9Wq7BduErnQxGn8Us10Yww73Jo3zTGIPwD3ccqT+LcVUxmn/yIYahId+XN1eCRqsNmkMqRH0LjFurbII7jEOI4LoPIw4rUZekUmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NrjZO8SMJbH1DqCZ1gU2mzukhT/HUDGXiiJoJ7bQY4=;
 b=RQIyQ8bIOib2/mH5nB0SL+Bz8KXgLdlTMhObn72E+2fLCEeLuGwj7Rf+r9ClHwN5YCuQM2/4ZBDw/EPSjgdDtTQyHRzHFg0YuRYGRdlxlEQVfvt2bEV74ClZTwd8ApjrsKko1+749YEwUVPxfzMicfDUkN77FZuwCFI8tlwTJ/J1ws9NdODpr0bj8QtIi82jI0KWNOWE/gw9Lf4QiIz1o4hme5aL3mZmXKhUyWCFE/yOe6miFs20jf+1GoXuFnir+/UcgFMoxuB4i79P0cLB2aDed5i7bSi0pcWkGmFhsErORxkZwxDXXN+ZXA7j4bzIiBouB4mo+HRa5jMIg54k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NrjZO8SMJbH1DqCZ1gU2mzukhT/HUDGXiiJoJ7bQY4=;
 b=WbcWk1a8cwYFYy/yV5xHpzO9rkYaX+K1I9AZHSjsOMUTYgyuE29nASkv7ijnqBOIbv1/SV9VoWwqXhZ6cMA9F+hu9IgM62Q734K3A1XAgY4Qpd0gcZGwdX7CfDzbFm+Tfl+shTq6AflCTb1w8esC6CyetsV85SUktpV6egWUu9s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB5940.eurprd05.prod.outlook.com (2603:10a6:208:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sun, 21 Jun
 2020 14:42:00 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3109.025; Sun, 21 Jun 2020
 14:41:59 +0000
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Optimize XRC target lookup
To:     Jack Wang <xjtuwjp@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org
References: <20200621104110.53509-1-leon@kernel.org>
 <20200621104110.53509-3-leon@kernel.org>
 <CAD+HZHUnW53ni=16=XL6hY1AHoNtsa88_V5P+XOHb55Fm83zZQ@mail.gmail.com>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <481b4111-55d8-6c49-2c1c-e15d39ba1129@mellanox.com>
Date:   Sun, 21 Jun 2020 17:41:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CAD+HZHUnW53ni=16=XL6hY1AHoNtsa88_V5P+XOHb55Fm83zZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::32) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.11] (93.173.18.107) by AM4PR0101CA0064.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sun, 21 Jun 2020 14:41:58 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f4a988d-3ccf-46e5-87e7-08d815f14112
X-MS-TrafficTypeDiagnostic: AM0PR05MB5940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB59401D82A58507795A7D216ED3960@AM0PR05MB5940.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHf1kSlyrZM/4+frJ5DWBVY+4dsziqgqt7LBbDq+1SPOaqzZt40UeAjOnAC63jxc2yFV950Npj1thgkEsuUqHbrBhW7NGQ4T+yGg04s7F6D71cTK0PGHcji/pf2lGM7yYTFXl89aMOcuZhx9wYJ2Wn5rV5Zk8FwwKIiMrkI1nDSDbEDienUG6gmS+XbAMw4APbcuGyQhZCCmSyuIzjJTtzomIjAcTxlD0XliddtraK2ZJYNmRtfGKnFNI67vv8NFch+lvuJbsKVgF+8um8MC2uH4RL0EDM/Yg2k0P/Nib2fxrVQxGnb7IqTFHVDGahVoXxFQESiAZlyYHrTLRuNORz2cs68APFWJSUeyXUmScxrVRixJfigUQrattmhebdCF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(6666004)(5660300002)(31686004)(54906003)(66476007)(8936002)(8676002)(66946007)(316002)(16576012)(110136005)(6486002)(66556008)(16526019)(26005)(31696002)(2906002)(36756003)(186003)(86362001)(4326008)(478600001)(53546011)(52116002)(956004)(2616005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wpU1GcP0hi6mGJxlrlsqYlzcgupeOOwH8T/opTW/VAlROC1HvN3AxeymsDUSMFTGKysURdKUbu5RpPfJJD/aEhGi7314yFch6Wb2Zfc0GFi0ZT5PAArbVx+N76I6pOO+dRzld/ZSJiVFT+Uh4NEuBSLAVxrDsZ0P7bzDo+mPVo0F23sc44fWLUFgVDfr7hSC4eIfQ8LxESqjHWuyQVm2TFiSH2JJaD/BiqQizXuKGRAXJv34V9xzCNcrhOv5z2nv3wrSVTirDi3vm2UOp9bygkJhEJcf9uWukECQKO4L+8Oz5TPBny7WaczyF/GVHQbuPtB9QhxXzwWmeA9sb+RiHeLMrVln303CsxSSSjaxi3azhhb5n0x6JtPDb8ysmbXRGqQr2+bnUJ+i1QMHG5r3HZ7YXkiuLgQT8ZEzoyrpzjIL9V83+cCH5DQl0W3jqe+fmsJUYxKKsKufDnXKTsOW+9aM327I1MYWCtCK9CtgOzqMe5dTGEOVrKphJJ6pm7P3
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a988d-3ccf-46e5-87e7-08d815f14112
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 14:41:59.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRXQ8v+ZiFf9klc011UOkvghAJl94L52W7V0WYXZig1w2N7rLUIFRcAUTVJT2UhxXk/3KO5SVA0QcF1BNZO1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5940
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/21/2020 2:34 PM, Jack Wang wrote:
>
> Hi
>
>
> Leon Romanovsky <leon@kernel.org <mailto:leon@kernel.org>>于2020年6月21日 
> 周日12:42写道：
>
>     From: Maor Gottlieb <maorg@mellanox.com <mailto:maorg@mellanox.com>>
>
>     Replace the mutex with read write semaphore and use xarray instead
>     of linked list for XRC target QPs. This will give faster XRC target
>     lookup. In addition, when QP is closed, don't insert it back to the
>     xarray if the destroy command failed
>
> Just curious, why not use RCU,xarray is RCU friendly?
>
> Thanks

The lock protects against parallel close and open of the same XRC target 
QP and not the access to the xarray. In addition RCU can't be taken 
since there is a sleepable function that called under the lock, using 
SRCU locking shceme looks overkill for me in this case.
>
>
>
>     Signed-off-by: Maor Gottlieb <maorg@mellanox.com
>     <mailto:maorg@mellanox.com>>
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com
>     <mailto:leonro@mellanox.com>>
>     ---
>      drivers/infiniband/core/verbs.c | 50
>     +++++++++++++++------------------
>      include/rdma/ib_verbs.h         |  5 ++--
>      2 files changed, 24 insertions(+), 31 deletions(-)
>
>     diff --git a/drivers/infiniband/core/verbs.c
>     b/drivers/infiniband/core/verbs.c
>     index d66a0ad62077..ef980124f7e6 100644
>     --- a/drivers/infiniband/core/verbs.c
>     +++ b/drivers/infiniband/core/verbs.c
>     @@ -1090,13 +1090,6 @@ static void
>     __ib_shared_qp_event_handler(struct ib_event *event, void *context)
>     spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
>      }
>
>     -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct
>     ib_qp *qp)
>     -{
>     -       mutex_lock(&xrcd->tgt_qp_mutex);
>     -       list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
>     -       mutex_unlock(&xrcd->tgt_qp_mutex);
>     -}
>     -
>      static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
>                                       void (*event_handler)(struct
>     ib_event *, void *),
>                                       void *qp_context)
>     @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
>             if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
>                     return ERR_PTR(-EINVAL);
>
>     -       qp = ERR_PTR(-EINVAL);
>     -       mutex_lock(&xrcd->tgt_qp_mutex);
>     -       list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
>     -               if (real_qp->qp_num == qp_open_attr->qp_num) {
>     -                       qp = __ib_open_qp(real_qp,
>     qp_open_attr->event_handler,
>     -  qp_open_attr->qp_context);
>     -                       break;
>     -               }
>     +       down_read(&xrcd->tgt_qps_rwsem);
>     +       real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
>     +       if (!real_qp) {
>     +               up_read(&xrcd->tgt_qps_rwsem);
>     +               return ERR_PTR(-EINVAL);
>             }
>     -       mutex_unlock(&xrcd->tgt_qp_mutex);
>     +       qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
>     +                         qp_open_attr->qp_context);
>     +       up_read(&xrcd->tgt_qps_rwsem);
>             return qp;
>      }
>      EXPORT_SYMBOL(ib_open_qp);
>     @@ -1157,6 +1149,7 @@ static struct ib_qp
>     *create_xrc_qp_user(struct ib_qp *qp,
>                                             struct ib_qp_init_attr
>     *qp_init_attr)
>      {
>             struct ib_qp *real_qp = qp;
>     +       int err;
>
>             qp->event_handler = __ib_shared_qp_event_handler;
>             qp->qp_context = qp;
>     @@ -1172,7 +1165,12 @@ static struct ib_qp
>     *create_xrc_qp_user(struct ib_qp *qp,
>             if (IS_ERR(qp))
>                     return qp;
>
>     -       __ib_insert_xrcd_qp(qp_init_attr->xrcd, real_qp);
>     +       err = xa_err(xa_store(&qp_init_attr->xrcd->tgt_qps,
>     real_qp->qp_num,
>     +                             real_qp, GFP_KERNEL));
>     +       if (err) {
>     +               ib_close_qp(qp);
>     +               return ERR_PTR(err);
>     +       }
>             return qp;
>      }
>
>     @@ -1888,21 +1886,18 @@ static int __ib_destroy_shared_qp(struct
>     ib_qp *qp)
>
>             real_qp = qp->real_qp;
>             xrcd = real_qp->xrcd;
>     -
>     -       mutex_lock(&xrcd->tgt_qp_mutex);
>     +       down_write(&xrcd->tgt_qps_rwsem);
>             ib_close_qp(qp);
>             if (atomic_read(&real_qp->usecnt) == 0)
>     -               list_del(&real_qp->xrcd_list);
>     +               xa_erase(&xrcd->tgt_qps, real_qp->qp_num);
>             else
>                     real_qp = NULL;
>     -       mutex_unlock(&xrcd->tgt_qp_mutex);
>     +       up_write(&xrcd->tgt_qps_rwsem);
>
>             if (real_qp) {
>                     ret = ib_destroy_qp(real_qp);
>                     if (!ret)
>                             atomic_dec(&xrcd->usecnt);
>     -               else
>     -                       __ib_insert_xrcd_qp(xrcd, real_qp);
>             }
>
>             return 0;
>     @@ -2308,8 +2303,8 @@ struct ib_xrcd *ib_alloc_xrcd_user(struct
>     ib_device *device,
>                     xrcd->device = device;
>                     xrcd->inode = inode;
>                     atomic_set(&xrcd->usecnt, 0);
>     -               mutex_init(&xrcd->tgt_qp_mutex);
>     -               INIT_LIST_HEAD(&xrcd->tgt_qp_list);
>     +               init_rwsem(&xrcd->tgt_qps_rwsem);
>     +               xa_init(&xrcd->tgt_qps);
>             }
>
>             return xrcd;
>     @@ -2318,19 +2313,18 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
>
>      int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata
>     *udata)
>      {
>     +       unsigned long index;
>             struct ib_qp *qp;
>             int ret;
>
>             if (atomic_read(&xrcd->usecnt))
>                     return -EBUSY;
>
>     -       while (!list_empty(&xrcd->tgt_qp_list)) {
>     -               qp = list_entry(xrcd->tgt_qp_list.next, struct
>     ib_qp, xrcd_list);
>     +       xa_for_each(&xrcd->tgt_qps, index, qp) {
>                     ret = ib_destroy_qp(qp);
>                     if (ret)
>                             return ret;
>             }
>     -       mutex_destroy(&xrcd->tgt_qp_mutex);
>
>             return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
>      }
>     diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>     index f785a4f1e58b..9b973b3b6f4c 100644
>     --- a/include/rdma/ib_verbs.h
>     +++ b/include/rdma/ib_verbs.h
>     @@ -1568,9 +1568,8 @@ struct ib_xrcd {
>             struct ib_device       *device;
>             atomic_t                usecnt; /* count all exposed
>     resources */
>             struct inode           *inode;
>     -
>     -       struct mutex            tgt_qp_mutex;
>     -       struct list_head        tgt_qp_list;
>     +       struct rw_semaphore     tgt_qps_rwsem;
>     +       struct xarray           tgt_qps;
>      };
>
>      struct ib_ah {
>     -- 
>     2.26.2
>
