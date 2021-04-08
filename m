Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5A358545
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDHNuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 09:50:50 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:55072
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231655AbhDHNus (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 09:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBU55L0zVTsI6hDeP+QVthkyzmPNLcgUR5Bfz/Qhy4ChrcPOHBUQOj0rIvQ/YIg8Bff/MTzbI+2KXBoOB4baDWBLAI6yBRATopa+FXcU8u0xYTKeufeTga3QBG+fTtC0aJXfEry1sC7C8Gd3iMnlYa/k2nT/W+Qp9gckQIQnwYHdSxGCzp1XAV2T0uZ/s+NPF46htIvDFJ4sATUypVbLTsceilCnvhgEeSrad5g8dpnNQs7yZ1/yx/gnFjF7S9zW1sMnhzWx/u0jC+gbgLSLchIZOhD4Wi1NJhJMzXPamYM5cpl4y9Xd6OXefTRKIUJU2vWMA4i/5UYgUx24srNkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOave/v5YD260Y6fbStAysAEXarSmhru4cMKiz8q3q8=;
 b=LskFiL4yUlz+rtp1olfYTtqzCR+3mFFDRyquDqPOpMrQNbPvgIiq2fVdl31+2wcY6/gp5v48214tfRstgH+pjicK82w9LYojXTyIHIP1tNminymL/gPVnKGPgl/20GKkNBKcKrc6+nzEnQUEE12trCPCojsnhiENJyjTvTrFZORNIzP7Nmh2OXscsTDChs038T1Ilri/BqJy+/iLlBkCKX1S2sIT/SbpAAGT9hOXeIMKHtan34C2RsJTln75tdU1OAe8OReEtI2xzueTxIFv8vMlY//w+yDIMUy9+NUaEuw7WR2duBWLU/BKYOaYkufeAAnn85CCXj7Ofvvh/IHTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOave/v5YD260Y6fbStAysAEXarSmhru4cMKiz8q3q8=;
 b=jjU4nSjRttU8/ToTSzNd98RgnO9vm2KjPYvRVCJ8qRx4QcC5nD/jpGFh/ouuvzTe98vGRRV9n9uvpEX9ZarYR7+Vx5PWErhNm46I8KV2gFsMHu+DqRJ3le8PLr4l1vBW1PZlTPc8ASYA24dKGg4YxQzoDbwOUtJNh+Wzb4Kh8OIg/Psxz5neUKOMfmueIkxJEGlxbFC3JBIh3JCIGN/OpVQm+La5xEJGlRf+vOk9BtnaITm+DFWoSRW9tC8r3Q5RtdKkk4GDO0JAfZXMvZ7nG5wAW8KYLfpn2Wr0S3EDg+II81N+lazWQw8nH2gEH/O6eUYAZnOsIwKk0Rk10SH70g==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Thu, 8 Apr 2021 13:50:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 13:50:34 +0000
Date:   Thu, 8 Apr 2021 10:50:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
Message-ID: <20210408135033.GT7405@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com>
 <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com>
 <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Thu, 8 Apr 2021 13:50:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUV3J-002k3Q-Dt; Thu, 08 Apr 2021 10:50:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedadcd5-551d-41cd-6b05-08d8fa954879
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB151400D96AAE86920D53D15AC2749@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBYMBAzCCjRPZASzXO8DnWZZWKZPOCWClCF2nNJ2wYqYAqBtz9FH5owYJmor2RLeBQllyoxItp6FccWRDFLmkUpy6997ELGWu/MzF5pkcI0tjf53GdLvIg3oJ2sOk5Fej2Y4icPzoDSZNFkI+v+BIWvuUouiZ9+Oo3tqyZezafnLzoVzksjOcBh+q6f54SL74Gac4vkXBWa/4JopIjxHGwCZdAmRXBJgYkvWxIpYydZQq2F5UCDmr+udqnHqCQxVOGG9RdVH5TPnGvQfqzPgGckzT2FCidB2/ldJYrkxFcCQDO7Emru7rQGmOxczUQUdP6jxEs02OMzBHtWBpuQTOdiq5h+DJPwahwIZoIwrk4TxVUK4cuvvphiqFukRtBDkZhHbPUlc3mFw5grmHueAMVM3UVVZIXSzW+5KTTRB+I6Zow+4Y2IqhepJmj9qQtcxVcNEvTIBPD+p9NWfFvmIf0F8qhBRZalHztxbX6L5jS2LpIWom2snAgNV2BVND6YrPFDR4XL7XXpOwlIN9t/elahkv2dVJUn8Na6EQY4zjoS741AHFrwe+9a3rvYWAj9NsVstZol4UDQPo+GsZpcIJIrn9kObibV5FYeUFy5XFSsrD6JKojG3L+4udxMSSIv+nNOcCd86W78sHGl81fdzsiUQUGMw68tWa36xHgfFp6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(9746002)(9786002)(2616005)(2906002)(66556008)(53546011)(86362001)(66476007)(478600001)(1076003)(66946007)(6916009)(8936002)(8676002)(426003)(5660300002)(38100700001)(186003)(83380400001)(4326008)(36756003)(316002)(26005)(54906003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?StswwBcWZY+VoiHKmqx9AuImxNGU+d4pSzuR/nNFrsFJneD+7WYYQp5MDU9g?=
 =?us-ascii?Q?U4TbVQtsTFCHUeIV9k5spr+uiiGbAlLVD4QvYOpAk79JciAASWqxKhX4upMd?=
 =?us-ascii?Q?/OoW9agsPm9XLqGNAX2fo6T5cCD1HVy3Zk5tuzJAevf9bcbQe03BlN4H1q+a?=
 =?us-ascii?Q?qO1x1sRlyNtK+3icVaPBT3dTzfTNv7Qt630wxM06sToMDMfCWujFeOCVJw5B?=
 =?us-ascii?Q?i7D+c2zot+530J1CGdZ3TSvjMueErVKclv4ue5aw6xWHWfLc0Zbp5ffdGFw4?=
 =?us-ascii?Q?MOJV+gjwPbjik+Sjc7vchP+XB9Mahf3lyRU3PQdF5hbHM1tqYO9R5dlz+Hk9?=
 =?us-ascii?Q?J9zvk6Wea8vOocyf+yjPIznQq8IRcqgmCSpSOZsC7NLmu6s0oSxhTDI/0iis?=
 =?us-ascii?Q?nH+LB9YeYqYAFDOstjzMXVUB2DIl5LOF5JRyeTdVo43WBrseBW7b7GC7VubN?=
 =?us-ascii?Q?O2vDc0ErykkMdfSroD9tUO6IPksCWtScI311CIsNz4k/GVwYuD0fFDoCzJmW?=
 =?us-ascii?Q?8wrzhsYJusI4JQ76E4fhj0LQ+Tna6E8R7nXhnATcZ+JFN0xYCw/UlB1si/n4?=
 =?us-ascii?Q?/rjIG+EahccY0ksfV45oiNjEBR6/g27UT1nFhEB9NAYeZfikeLRHDwd0k81H?=
 =?us-ascii?Q?XIagJZ2bc4i2pxdVeVTFK5bLO4DfAIsW04XFGF9oDHj19x9dQVUO5BJsRXf1?=
 =?us-ascii?Q?B9NSOijr1sV6OpvvhnpOH/Y7LSd5DVgnUswdR9hKH5KSQbi91rpcP6SCT0QH?=
 =?us-ascii?Q?2P5E4335KaiJJWphqqC1fORvlMizzyMSi/PQ4qIOK1TVFDP2aSvlWMGP66b+?=
 =?us-ascii?Q?bU+eaV8rg5i/9my9ofl96BMvPEbosGTZnujDnhYW7npGoTt2JGrIEH8ZRe1+?=
 =?us-ascii?Q?YnuqrvQ2Kldr3XPiKHQrlzRjfpZJ3Y3nlo3tzvoX3bYhMwGA8WSbOvyCaVR9?=
 =?us-ascii?Q?4fBjxQ4+JPqn8BfjFDeRVgS1xlwLm4mu++snqkctcIBs9YflyeReB+O8coVL?=
 =?us-ascii?Q?CpimG7p+tpwzsNNaGTa7GP0NeiFWoVhEy6QE9iUQJcIZNCgHsJHvTBrrfRQP?=
 =?us-ascii?Q?Bdd9ygcNLfHMF/QctSG3aVjdzLl+adH7RUrv+EMyLYw2Z/ypSQ2ewF9BPNk8?=
 =?us-ascii?Q?nxsDPZ5vZO81q6tBefc1GjhyyrkB9pnTGEvGH/ERj3MAiI5T7//uouFNtMdR?=
 =?us-ascii?Q?zIee4fUXoUSznJKXohOAoyu38e/2K7IBF+bim//SPzeFEbGNRYeXDYZTQeUa?=
 =?us-ascii?Q?S+1Kz4+/imCIiXVHGdgcvcYOLVS+vmPDuQ8/bjJyV1qg2SJ290adTPcE6hdX?=
 =?us-ascii?Q?NUOCP+NvwaviAQ65kgJaUPxz5nS7TVQ8zuABpg5PiNuXig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedadcd5-551d-41cd-6b05-08d8fa954879
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 13:50:34.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2TfVBlLcs3nAds1NdJVLKMFwoZKzkgRwNYhSJPV9HL8yh5W4/u8FbW1aVJfMKF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 03:45:45PM +0200, Jinpu Wang wrote:
> On Thu, Apr 8, 2021 at 2:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Apr 06, 2021 at 10:55:59AM +0200, Gioh Kim wrote:
> > > On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > index 42f49208b8f7..1519191d7154 100644
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> > > > >       int inflight;
> > > > >
> > > > >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > > > +                     continue;
> > > >
> > > > There is no way this could be right, a READ_ONCE can't guarentee that
> > > > a following load is not going to happen without races.
> > > >
> > > > You need locking.
> > >
> > > Hi Jason,
> > >
> > > rtrs_clt_request() calls rcu_read_lock() before calling
> > > get_next_path_min_inflight().
> > > And rtrs_clt_change_state_from_to(), that changes the sess->state,
> > > calls spin_lock_irq() before changing it.
> > > I think that is enough, isn't it?
> >
> > Why would that be enough?
> >
> > Under RCU this check is racy and effetively does nothing.
> >
> > This is an OK usage of RCU:
> >
> >         list_del_rcu(&sess->s.entry);
> >
> >         /* Make sure everybody observes path removal. */
> >         synchronize_rcu();
> >
> > And you could say that observing the sess in the list is required, but
> > checking state is pointless.
> >
> > Jason
> Hi Jason
> 
> Sending IO via disconnected session is not a problem, it will just get
> an error. It's only about if in the meantime user delete the path
> while IO running, and session is freed.

But the session can toggle to !connected immediately after the test
above as well, so I still don't see what this is accomplishing.

Jason
