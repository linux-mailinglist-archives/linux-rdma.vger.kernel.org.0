Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D3439BC5
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhJYQmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 12:42:09 -0400
Received: from mail-dm3nam07on2059.outbound.protection.outlook.com ([40.107.95.59]:10080
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234025AbhJYQmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5sxFri49247rdONHdxWvBM36qfXaO6NyWh8D+6uDDQ6hX2yap1nkO/GIeFaMHYme+RKvlr7DExHmCWkUlAC/Zj1YmR3Lzm+6g/5gLXVvCzPDB1pmtJeFMFC+tcArfajxjOPbuM5rlmNdOVXoYzgNn6pD9zjLmGXL/EM8KL2yLCSGO9zdD/CJWbE1xlw2IrTKDsVdsdoo883NPa0QJHMLXYK0vasrpxEqJS1NMoAsuGlYPsK3EnpQWfhZO30ssTL+XQixlI6Z8eIsFZCJsGEACiWNFUAWq91b+hCQXgieMGm2Se+foL93Jw0PM1z6AS2oeYgjr6huomhOt6a1LTbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsBYQ/n7ovRIAcBovFHrOHhJiSmzlo90dbt5iR818AU=;
 b=C5Kzm8mR1xed92u5m98YojUidH2CT2fEzihCNvshbmF373nP43GzfRwFy9cIS+zSxvZ/97PV7qbG8KNjGSCDkAcD3TaevA2Wu3ADb28i2BmxjEo6GFXbxO3t1PtJPO+sI7QLwJ7KReaTGnpsiPvAGSWbuVZeUyyS6MtXnnddOS9lYXTZ9OTtq+5RfJYNgAeo6f1OEJMoJJt4tNogz4YJ6kI/mh5b5h0vr/VVSsU+j72e2g1tqXHqiP0m62GbvjOmMxyg4EWA0O9sQZk7bH5DzMAp4NR9EGbU6CxJt3opgC0Lj0OqtiVLFn4uNENc3wvQL5e4ChVDFmSbPHqy68AB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsBYQ/n7ovRIAcBovFHrOHhJiSmzlo90dbt5iR818AU=;
 b=UgQmEPGtIZlz7OdhuR0btfXiSY88WAk3RLgblCMFPntTkw+3UylU+H/WXTfBsXFrVdK020JVOdYTexTL+kdipOQ+aQ9HlCQncxwVzJtzqCAj+FIKOhCwutmNUfr+XLCNyrGPyD5P+4PxaL6Y1d9u3RRWwtLFQtPo3/mxZYQCO+llddBazNW9aHV6V5oSEMhLrxeeqshIIiGNyB8A4SNPSKCK+NUPC6iGwYgz5cE6b4C41uCoDrXFTuQ1qnCCpOdj4fblIPyjnAnOdTfgtl8TjlCHQvC0sYpFXw9KabR2AuAtTgqSwjR2/pFqBJn7RYj2vjymCxs/BHt3eALj7E7f4g==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:39:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 16:39:44 +0000
Date:   Mon, 25 Oct 2021 13:39:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>,
        Jiri Pirko <jiri@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, mbloch@nvidia.com,
        jinpu.wang@ionos.com, lee.jones@linaro.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/core: fix a UAF for netdev in netdevice_event
 process
Message-ID: <20211025163941.GA393143@nvidia.com>
References: <20211025034258.2426872-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025034258.2426872-1-william.xuanziyang@huawei.com>
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by BYAPR07CA0097.namprd07.prod.outlook.com (2603:10b6:a03:12b::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 16:39:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf30f-001eaJ-Az; Mon, 25 Oct 2021 13:39:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9b4d9e-51a9-4554-a48a-08d997d60c89
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361DB236D993EEED2173696C2839@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFdiWER0etoiQ+f0O0g7ROi+kT1yrnZj1C0wLrLbxXm3l1xT8BUGX31J7DOidRsk1NNc4JUlkM6vgY746anAGV0q9NazJzZxfHL+x9B6IFGN1pVXwjN3TYvOUjthaMAIrp2Rk0Dy2EXK/nT5+Rq5c1zgh3wf4qKsd80MCUzHvGZ10XVV6BKWE/9TaG334s5ZX2dwICdx7kCvfw3Fpyllfd1noUsBsdo9y2+MJXXnxu8cCrWO1h052FISMObbDDZ7p//qH6RKjmM27I/vIkV8sSJDNBUx9vYWhtW0ZGKq7+KOyQlfz25aRgIHEnE2jrU8pbMG9frUHtcXtEB8m3x1gKyzhrYH/qHY4uY4sqsJ5Vo9fAAo3YliMLoIPjyTYDwD5pAP/F32jbPb0aJgr+ANVrlVuomPbvhWjUcQcI8/OyMxVXtPhrt04vkLR82i96GK0uYO+BD2rjmc5GL1UfGrWd2AhVAIaITtRmdD5+r0I8MDtYsk2QqgT16gjICKQFDocyBFfdbe7SKguoy2zU3us0ZNlCZ1jBHkkIUQDAZDzWpQayj9R7SGtcGxbl9UNz9U9vljSqkbyvhACGmP1MKXZzeLWWD0KwvzKW1Q8Aiv7OOR0XZKLXvdmSkTo72ItMmtt46a8s9rsoGHtFJ8UA1lbjkqwDKFzpPU2U1YiO4XbEj+8TEha+Z2PKRv1ObBLH0jO5L+3oVNKWp30/umZ3nplw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(36756003)(1076003)(9746002)(38100700002)(8936002)(26005)(186003)(8676002)(4326008)(2616005)(9786002)(508600001)(33656002)(6636002)(66476007)(66946007)(2906002)(5660300002)(316002)(66556008)(83380400001)(110136005)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xY4XQi4syL13H6dBPqmUFInNIDUzBpqEwRQQtzv8C65SfbYqO2h5ZU8MOon2?=
 =?us-ascii?Q?DiYeBAQOberYFQoT61+WfLiXJF/lvcdXvxCGH0sL99j7G7gkjLuUQUB72U2D?=
 =?us-ascii?Q?XW3I0GBvg99bRddxreMcsSvh2DhE0XEv44FxJwes+kwb8zTWk2fs3Nw5GwQf?=
 =?us-ascii?Q?9ykE41vQpQhvYjStJ+aVL2ltwCx/Dfq9NloQ4O6YLpVcvgCXb/QMEdd6ycJl?=
 =?us-ascii?Q?AgyFkrJwD83+nTFCs9n+upixvtTcguDF3BVQmeqaArS0zksBDjZqSIXiC4As?=
 =?us-ascii?Q?o1Kkc8DBLOvqlp3VkbihmvQu9JCuSaCabr2PEI9ZK8NNge4EpMRbKj8uA4LJ?=
 =?us-ascii?Q?iuqxeevJOlUMt3RvwBVeP2YeP6Intkh/pA1CRFNaaDDbhexCh0jI8+RYicpB?=
 =?us-ascii?Q?M+zox6WiLHRkGQwqTxqgC5xI3+DxwfjlMbStrFdZ6GTCDPPvmxDV9UGT03ws?=
 =?us-ascii?Q?ryQ7dWeUOedaMSEyjASFOsbut7slm5zEJmt2LP0uLGtL2o/b0vqZJ3ci4BZo?=
 =?us-ascii?Q?BnKKOODRgjhamTcpLwroJpdLI+rBz7i6QIexsGke0rZ/7LvgkwpaE+3YPNaj?=
 =?us-ascii?Q?IpURvpE91mt5Hw9/YHH+ISJLGDZqJnIoJVJ92xYwFDxqFmNSZ0YxM56kDaPK?=
 =?us-ascii?Q?sQ/soimiksUJ1zROt9lUDUrY9xsNwZOqdnG7rD2eHVay70XC1sA2Kb8sWOS/?=
 =?us-ascii?Q?MmzO8radIK/dNUAB8ELywZcyqy2XYtS5V4eBmSqb+sP0w1P14rxLZGOV/+3u?=
 =?us-ascii?Q?5N2887RRzX/31i79C1914YQsUEwe/sDDv/SuqSiZsE6ordTEfkEI1KmxTN57?=
 =?us-ascii?Q?H2d9ROJVDObkbpJSlbLY7c5PcktwGTw14L78IEyx5GOVYVSr7966Zoe5sEWQ?=
 =?us-ascii?Q?tFxFjNR4T8TZSkJRWbbjgNxRAHEDNu/GQeZwTDpOm+Tl6uWEPu77+Ne/zUIX?=
 =?us-ascii?Q?lw1ZBa1Up0x2VrETEre1s/hkXb2obSvoSTgaTodlTsG++L8dW6DDq8Vc5fyG?=
 =?us-ascii?Q?9hOkblel+VcOQQPRFasmLy/KcFO8sYe05PPJiGiJU2CyjCN1GyTtWvnWvlVL?=
 =?us-ascii?Q?IjjV/hsmlAMwNsRcE42XAq3XbtTsGD5hANaCkX4zxNuQavyTuUToGmsySr/L?=
 =?us-ascii?Q?4h3D9GR/Oh4E4tGv1AU9XbSd5bG/IPQFaw0wRGA9AIoiKyJ48Sn7+2yIG3HE?=
 =?us-ascii?Q?//7BZNps1ifvjx3sUt06J4CfkiYQXgI/4+zmTnEj4Dxm/xRO7/tRv/7sjDk9?=
 =?us-ascii?Q?B/TIee3rbM4sE+L4ZaiU/jN/owM3KUxfrB/SknpWfABsanA2bYjVgRbqIN1S?=
 =?us-ascii?Q?azAh+XJqwQBhrJrbKeW108QjPOz1AnDpD1XlZj79jt2XuAevskDQQ66zkYaJ?=
 =?us-ascii?Q?GvLzxZL7X9MlpeK1XEfnXNdKYBQXF0yjMrxN/srf8QnHxINpOeCuEi8dapFH?=
 =?us-ascii?Q?FhtU6Yvf8TiitKPulSMV/N3aXSNtXC7NvRnNYNOhCOM2P51eXdd/g1QDIaGr?=
 =?us-ascii?Q?LGP9bTk1Q5FB9cI9QnrsJdm5JqrfwXHuZUfNNkCjLuk/d50iYVCXIBI+U9pr?=
 =?us-ascii?Q?+JG7yNjRyiLo8r52o7c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b4d9e-51a9-4554-a48a-08d997d60c89
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:39:44.0799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6phg7m5BrX4kJF/65f3MkPvARfjH4JPPix7pjwVJvQfFrJhQbz5Ht0CH1y8p3PeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 11:42:58AM +0800, Ziyang Xuan wrote:
> When a vlan netdev enter netdevice_event process although it is not a
> roce netdev, it will be passed to netdevice_event_work_handler() to
> process. In order to hold the netdev of netdevice_event after
> netdevice_event() return, call dev_hold() to hold the netdev in
> netdevice_queue_work(). But that did not consider the real_dev of a vlan
> netdev, the real_dev can be freed within netdevice_event_work_handler()
> be scheduled. It would trigger the UAF problem for the real_dev like
> following:

I think this is a netdev bug. Under rtnl vlan_dev_real_dev() should
return NULL if the vlan device has passed unregister_vlan_dev()

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 55275ef9a31a7c..1106da84e72559 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -126,6 +126,7 @@ void unregister_vlan_dev(struct net_device *dev, struct list_head *head)
 
        /* Get rid of the vlan's reference to real_dev */
        dev_put(real_dev);
+       vlan->real_dev = NULL;
 }
 
 int vlan_check_real_dev(struct net_device *real_dev,

I'm assuming there is more too it than this, but it is a starting
point.

Jason
