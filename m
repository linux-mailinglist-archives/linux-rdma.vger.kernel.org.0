Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662C3E084C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbhHDSul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 14:50:41 -0400
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:22784
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239165AbhHDSuk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Aug 2021 14:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avzpciybrCfzwGRcizYGqPIVjKnMWCre6YvamNL5hcfWlECgi86mCvzUFqFTUP62BEEDVcXaRyLdnt7EgALO6bYxzMdTfNl9ieDdklYwSsYb50S3v2K4B2C3rXmjfQ32Jx2Qat2/P2RzHvZQiK0KV0xHIM4wOCRZA0/OLI3elflpwttJk0WeT/Mm65X0SNT+BPhBRIDDhyBed+3P4R6IKJv3Q2Nb2mCJyeLC5cbaWFRxOQuDXLcODyaiBFgEt7vz7KTpRu/U+TAiF6++FITU//uu5+1a/52p2R8CpkL0ep4PV+z5hYDrOx/JdIN0Tjj6SNs1RktfYP3RvCCMJ27www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgJb8xwsVmLh9slHr8mMyoSdHsYL5zNL/KcNA6nJ++k=;
 b=Ak9zSk6vgxlumw+HtCSqDlXYOSnXeOyvYXY4h6duEpJ6DRkDX+GJUU0qKCzzgOHVSbBqWHgJP576TPStNBu1bbpNZMEj7AjUBRi4lLyPtgsQQxhBiapExuZ55VK2mm/RIl4PuoBjOkqYTFcWg0rhwwr+Wqr6tvNgaBxD0ZiqNvXsTy1HFxz2yhp2vP1WIx2Yt1jh+Yq25kT/rq0vSbaexJXeEpgFkVoY+kD+RzLl1P8ARSxYSl/uAszz9mQIqC7ZtwO28h2nfarb2cvEyLspr3dHPI1TLcaP5kBEqwwhlROv/PcpBKACPgbdPqL01ti0u2SgvjBMgwyI0L9kD2onQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgJb8xwsVmLh9slHr8mMyoSdHsYL5zNL/KcNA6nJ++k=;
 b=KvIwwjl2XWOiDw2lRF5alSwpJ0kWXGQsbkpVM72n3Mbjygh6RkyrEHaCvUcoYCOo+B9JjrlLqLKd2qeOLNbYU+OtiIBfWgCrOvQ5Mq6dHL+jaMMCl6jD4SZSXGZGWUXvP874inIDsHwWcX2Yif39onFBDgEIqozdIsWaYEcbqVggT97798CQ8vM8rqpu6BoGFqamKesjI859eFrMpxaDAMlDYfH7fbaaz67zcI8TSWXaEOOAf5GBA39L5uoqVDFZ810y3DCCBnAb+fQemqzzUlAuhtcnpBCiyS7Zge7WlMTc54PlqH83noX2smYwJfwLPVcuC3vNfO1Hv/ebeWKyjw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16; Wed, 4 Aug 2021 18:50:26 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 18:50:26 +0000
Date:   Wed, 4 Aug 2021 15:50:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <20210804185022.GM1721383@nvidia.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com>
 <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com>
 <YQonIu3VMTlGj0TJ@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQonIu3VMTlGj0TJ@unreal>
X-ClientProxiedBy: YQBPR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::42) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 18:50:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mBLyA-00CiJC-Uu; Wed, 04 Aug 2021 15:50:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce28b6a9-ba84-4936-de35-08d95778b919
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5431F8034A31C450B471967AC2F19@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IkVLB685QKupQNXZ43luvz1bXYk4Z/372lfXkatK0U/VD+mTdglsJ0pvhglaIF3fbR3kF8vnfIaodXFZmnxk+yg6mg6Sjb2rUx+1t6+MqEIh/G3j6hsivyt04b+XsX4hvjltl8+6Xv0DkUvmj7Piu+XzwXvDyNBFaezDLqRfGE3/2dHDYe6b4nT825A8MA9qrkM+r79aUenRMnb7f99kQ8tuayJULTutKP/Jtx3mz1JLjb5pibnl1NmxACBXErgg7yZW28JwiJd3gy4XbpKP3UqLKZLuo0+IZ2I6hGMDFdkAhb6W0djeEOksG9FSn7Rachwfh2p5F98WjxzaN5qUBlWphjjoPdwolr63VO0K6r9NY/RzTlkKfdPJ0bwfy0KNic7nLkQBDIEX87RoZUn7+zq/aruzkB8vtZygLFP1H3B6yIYLutONq/XiVGZ1nqxy3w8xREo9BbtgXuzVodUYxA22J1r3zflBzr3YT/OFlabgv9E3gPXjbsKRL+EGXNkeq1QvYhOhtTpb9KiCd1Fndyy3+sVolb60f2fkb1AcKedvO04BLx67VXsxdt4pnYQSV+PevNSSHA9gsU2TXum5ISlMniyPbQIY/YIoS0vfbornPJBLIxX8TLG6fJKm4TKEjHikxPFGw2hEIa36CU2cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(66556008)(66476007)(1076003)(2616005)(86362001)(83380400001)(66946007)(5660300002)(426003)(6916009)(38100700002)(36756003)(478600001)(4326008)(9746002)(33656002)(8936002)(26005)(8676002)(2906002)(186003)(316002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6LgbV3PvEyvdrQ7Tk0+aBU7EDXrYlR01/jFLbfId1bUodj2xVMZgkd2pJb5?=
 =?us-ascii?Q?5rkfZnS56WZCEUDUzD9MKh8nxO8d/9O0mAEeWUZa/9yHQ9TVpejx5axCyrir?=
 =?us-ascii?Q?5PYcUpQ9GGvJPqkXBXUA+eV/Z/sXOFSG7VtjdUu+fetxGvhDKxAPCYsrZY2S?=
 =?us-ascii?Q?2OLhmxEGvD4FMt5fYeVqGKTNm3eFEiP+/RE5jC6D1+PZHD1hMPqmafXn1BSV?=
 =?us-ascii?Q?7eC+68mOD21QCZUlgw8EarG6msU0XmGhEXzvlMvviGih0wjGqKcjCiEW57cD?=
 =?us-ascii?Q?J+u4lS4IvhT1mxNzASPpU2KsUezJQZwlRCEe1L9NFsuLo8D3JVzch2qkivkv?=
 =?us-ascii?Q?RRKOI/PREYd28JK3/uXmnWczUYIlr5iWO/a3ozdwewXGSmBsgeuH4KJ/lbuc?=
 =?us-ascii?Q?MPZ+IVSleJEYr1R20OJR0gZJCfaz+tGjCn3addKRKHla/LZFLcCIzO+JVSLE?=
 =?us-ascii?Q?9ho6tWEI1XwFnZ3N7hmi4lRjq2XiP0NTjGz+f+zyyPcuaBvGvPu5YAaAHyHd?=
 =?us-ascii?Q?xNPmdCE8HafXRVh0G+c7npri8iSyEWQsjKKat7Bjg/+tou+TJaxg/wDQ8fWL?=
 =?us-ascii?Q?M7a7r5CBRMO8o2hdu4S70eqGrxbBfy/uceKIjNDBNlIGyOS3fxE2Puje8VWY?=
 =?us-ascii?Q?ezSrNZQHN7Pwb7/BqCnqswA+FhNp9h8UnO9vllVWIZpFIxvG1GHW+C5BdALo?=
 =?us-ascii?Q?NH07NlW//cm2PNurSxh2uc/MMjxI8tid+z4P50CVOkBcUsP7WGalwtYRqAuE?=
 =?us-ascii?Q?xd4BYLnq2xA07MJ8WkvY22Ztx2P/L+TSa5K9q+YpC9lJ4HgSH8ncFXr3/jl6?=
 =?us-ascii?Q?ki8qaS8duHeTpu7PClDEPOyTDwNo1ARC0BA1Ze3vu44WVwGHrosp13Dj4O8x?=
 =?us-ascii?Q?X6f94YVNrBmlzdn1iRLzVyPIZ3wOX1HQP7GEunxMjLZD01O0Yu+pyVAnAWIJ?=
 =?us-ascii?Q?V8ACfOGZi5a6qP0ERETn6p9lHmLessv6gv8DgE9SbAq5tZuPel8ADSY/8MdX?=
 =?us-ascii?Q?RjfSSl+5rWpUIoKpz8+lNpfmoISPC77HFVY0dC+A2JmewVFX8rJnVhIBXGHJ?=
 =?us-ascii?Q?o59hECSu4SgscixOdLtIeqUm40PCKOcTQwHJg1rU0ieEGvu3l9Crf/A7HqYi?=
 =?us-ascii?Q?72Au85aTj6xsJYNVBOORxrpm3/WFBH9IKOEf9TIiSr9GABd0piiUg7aSnMey?=
 =?us-ascii?Q?lVrUkYcyxaGzKGrlyM6X4jPup6DEG+jNdxFB8jzzijaSMb/HtZd5sPTYK5MG?=
 =?us-ascii?Q?ZEI5X3LTsoBSJzNEMEua/ICI+8f4XNMIg3u20S+DrGk3v2wtQFgeNLXFeEVt?=
 =?us-ascii?Q?g+UEzAUsShtm1Q19z2w/HT54?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce28b6a9-ba84-4936-de35-08d95778b919
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 18:50:26.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L64kIk7zD+rqYQmmss1D4f9kXdE7l2o04pVVPDWJV5tk5+5YXufk35CbC2Vnd/JO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 08:35:30AM +0300, Leon Romanovsky wrote:
> On Tue, Aug 03, 2021 at 03:13:41PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 03, 2021 at 08:56:54PM +0300, Leon Romanovsky wrote:
> > > On Tue, Aug 03, 2021 at 01:25:07PM -0300, Jason Gunthorpe wrote:
> > > > On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> > > > > ibv_advise_mr(3) says:
> > > > > EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
> > > > >        or  when  parts of it are not part of the process address space. o One of the
> > > > >        lkeys provided in the scatter gather list is invalid or with wrong write access
> > > > > 
> > > > > Actually get_prefetchable_mr() will return NULL if it see above conditions
> > > > 
> > > > No, get_prefetchable_mr() returns NULL if the mkey is invalid
> > > 
> > > And what is this?
> > >   1701 static struct mlx5_ib_mr *                         
> > >   1702 get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> > >   1703                     u32 lkey)
> > > 
> > > ...
> > > 
> > >   1721         /* prefetch with write-access must be supported by the MR */
> > >   1722         if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> > >   1723             !mr->umem->writable) {
> > >   1724                 mr = NULL;
> > >   1725                 goto end;
> > >   1726         }
> > 
> > I would say that is an invalid mkey
> 
> I see it is as wrong write access.

It just means the man page is wrong

Jason
