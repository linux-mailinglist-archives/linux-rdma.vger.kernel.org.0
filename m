Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF352BDE2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiEROqd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiEROq1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 10:46:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2A606E1
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 07:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry44iqloaW10eNlsXq8tG1gFSAmDm9DsokC4gtn0RRtSUG9u9bI8P3ul/MOb4KA7jNNGRSWNy1PmQPgb4wOYqvN/x749LC3raxPn5xa26bg3HUBiZkR30nbDY+LvUWKHIii9mtl4B+xBxcbCZf3ZNRONLElnSh5TSZm2B+GDeGblU1zKSuFIDw2j0VMdT/n5GzgG21RsISQTUad+mnKR5L0v0xVrLC451hwUBEfT6uBlouqv6b13Cij+/M2JYrpIuXNG3t01LiCox6UvYKMUVtfa1Gy/Ew0ENb8Zw0/ohhSaGPvz9s/XgHZA0JaJ6Sep24rrpBQInOFQngtYR02N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G18De0WhlqA0ob+377J5TifvHoNAq8u73VWWXfPbsU=;
 b=JKlQ+vIrFqc/8f4IC4M/aPAgLKCgLYyUhRKFCWgh5zPbGQw6Slq0CVi0GvQInRFg67j3f1fZNEcUD83h+GAxyTRMOd+CheKVsiNRurbNiRT8VIcMBX5iDysiohrPj7yYfpUv6evHEySbi+6i9Lxko42tDwXfb0BobpsXqajiTxlzffxkUJwjytaqq5gAbI424T6bgesIs84+MrPspj9tsU8WZdVLw1z0kii35H5e0/T4SgrWVqjBCbbSoxO6MVtocrOpgXINhwX5/jgfGVRq2f9rMcd8AKA7wZwUj2sWSjEdgWnJaqa3clnbUTDMgUvrUVfIrWLWxh3yVyaiAr0A/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G18De0WhlqA0ob+377J5TifvHoNAq8u73VWWXfPbsU=;
 b=qLYtR0Uzaii5tO9okPS114v4+P2EBuiJWDt65G5EcuBsu2QoqNnvJ0auqDW4QN4Iif9jcuq/tzRHXLG2R+0SPwMjxJHmAMaqL3LTBAwv7b15K5LnJ9BUrm04PN2sRZXuyIUAvr8y8Jy9XZI60D2v8yMwJPW80kmP8FxFdQRn6i/76iYP9Urim+1cdA8yOLzBwnHYthMS4jMwhzN35qrnRXe4Of94CdJFB2kuPY1zHmUCgTck0D6Cm08GBIlQVY5141e3ZuGNoMrp3RSQwzuFYwtmYVfMl+5/lzRtQe1WhAr3Q7WTiM8gtERDLG6QYlsjFZ5cY8EL4NFZxCguw7Ap5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 18 May
 2022 14:46:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 14:46:22 +0000
Date:   Wed, 18 May 2022 11:46:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220518144621.GH1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
X-ClientProxiedBy: MN2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:208:23e::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8ae612-dc83-4cfe-f6a8-08da38dd2d5e
X-MS-TrafficTypeDiagnostic: SA1PR12MB5638:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5638268396119C445FC8753AC2D19@SA1PR12MB5638.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8mku9ZSDu7C6A8EYBOfbJwZgceNofe33s3MfP4MajzgCZ4JiNmiDam5UZfjpK491gJJ0WhEeIAimxSVsVWnzfan0eh4+NrpOvpUi6SJr2taP+tS1v5XiDPy66/HXM2gbB0Iz8n5WN+UDhk2iqpRxlDUERP7QrQ3wK3d51LwvgbBtUli2vzkq3J2Veql882kDeCAlGtApjQ7/U18NK2wz+FX+vi2n3bU6QZryJs0DXAQ+3EBZsMHvLgHoEb2H8SEjkrgqIlb+uxljFQrdsqHamyvwJ2/2eNtZQAJ7ufVuaqNCoJrjyHImRjWRa7H98jQeG4ZZY6AnGSffak8onoSBnTaLZw+zuU1qZVvcbkSF1wV6pGC5H4OKTWAdXVsjOPnvxe+WBZO2/EL6l0fCzmW4IiATKu6aJixHxLAN9xrT17eUc/aAaiz1am88rjtQCoqV3igC4LwYgqyczmVy8+vD8r/QAbcv4vrX/zQRWtYApZdlm0UQ0pelNqm/WBiNDr3/2n0BND7lm6FObPBnscafuUIPPHRw8/gbvz5ghuCiOD6Zc2BtoswpvzZ915efjw8GO6hCNjliwpfB4dUbSrAhyWyifNNn84i3QtcernN2OtPyWuZwRyGokXB3R7GDkE+xrzPSU04U8zYmc6l0sXYnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(8936002)(2616005)(66476007)(4326008)(1076003)(26005)(186003)(66946007)(8676002)(86362001)(2906002)(316002)(53546011)(6506007)(33656002)(38100700002)(6916009)(36756003)(6512007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PomKLAZxJNNCKlrl9rmv44TPhh+d/9j28lv8MxfXXkusWtTGo7bC1IH6rRFP?=
 =?us-ascii?Q?zCtGJcpSlP6qAFkRZFruLk/3VJitE7220uc36olnAVysbXcpYa7N3vD3ZkP0?=
 =?us-ascii?Q?zxjnhgRO9bPYsrUMjr6kUf8KfhsQTBlVl3+xKEW5SLLVHxxzVsoVbdI9iKKw?=
 =?us-ascii?Q?XV/eMwvySzW7HMgxX+18HzatB7F746g7y5uyRi/vxjnEYLQt32MYqW1FHgY6?=
 =?us-ascii?Q?D2a985LefsNO/q2w33x/LHmQH//8bPQWK34ckTwP0tfeCqT8Bi138bOPmznf?=
 =?us-ascii?Q?+PdutJV5pdHd+4djKt0RtrzDRjzU4BBPykga4vPoA2k17dWnUEfdf9qPjrhe?=
 =?us-ascii?Q?pOoIZF073icdnZ5+rXhe6XeaGLrFifL0pSUfW+oN/l6A0sAXO2mWfRKCCE2r?=
 =?us-ascii?Q?Ax4miTLLGM0LVPievDvTpngnTaM5eEpQheOVx2J+qJV4I4UPCLHJ8BmP8Hel?=
 =?us-ascii?Q?Vh7uMn7DN2U2jEEgO5hs8Uh24iPkiMvLD/J90G/dv4A2nkvO8wb6vuLH8J0l?=
 =?us-ascii?Q?cgNM9cAMCFZuY4V+LkJkmpHHbrW1FPz9VX/t6L9gwAJci/57h9Qdom8HJanb?=
 =?us-ascii?Q?5Gh/mv0nEGFD9Otn7KdR1553OluIgbpnzfsVBFBF/SIjbGlTXgk7+4aKCa3J?=
 =?us-ascii?Q?9wXJ7PhRZ1gEhwAPF4N2n8ZFplnecHG8UDOzFTeCs2EMFfiSHvaZf9QPTgE+?=
 =?us-ascii?Q?coD/WfF84plNT6XnrR2QyBU2QKbnSvpvcutbhJV/YT5r4UxsyDL4zIglbNNG?=
 =?us-ascii?Q?XPnV4n9Ny81HXOQHoM/42/tA4ijzxqeLVCTQF6RUqODYHMYW2fijNdl5hCcO?=
 =?us-ascii?Q?WT4M2lVFCtIbmnveikRRVemI74rnWsv4+i2r/GHj08tEn9QV+H6DxfK3UXt3?=
 =?us-ascii?Q?IFy3qwutBbwY+zcmYF7w42Q+KB8MwC2sgRL9ju14rxW0OpqGbTn0g3nYvn0Z?=
 =?us-ascii?Q?HBGKDbAcmzlCbZ5dmyVJ01oV2+HQaiogo9cUe2kwYXLs/kyYImnXBumC6hZA?=
 =?us-ascii?Q?woMfAEc9KkLP4Vjics2CQNwCBwwYfwRgCQJgGMjNuAdNuPokUct8bhCN79Ej?=
 =?us-ascii?Q?/W8953BmHmwzhvq7uTg8UlejlbdmUEFM5VyLBcZhMtjUk4VbNoleZmA1XF5L?=
 =?us-ascii?Q?3uAnbXqvUBGcoqpzcGKimY2B14EqHFFK2h++ZcEMihFGO+W/cMp00MM2jW/k?=
 =?us-ascii?Q?AFfU3lrjRKNxRsB5+T7J9wTXZrsP8s1V7hxJg+l0kLAbDG6+mIvidPkVQz3h?=
 =?us-ascii?Q?bAIDgoaqW2KSc/IyPfcHiq8PZBI1+bMdA0uN2KGX/0qIpt5x5G3ykfoymPa0?=
 =?us-ascii?Q?KTaK68LqWThrtyo3bdp6738eIvm7QM0pJum/kUeITCbS1a9zK7CDyz01MUm2?=
 =?us-ascii?Q?Yays7UvJeF/Qg45rDnzH0gHRwQbIwgszIcvrOIAEniYk+ERGMnh1myFlKR91?=
 =?us-ascii?Q?4uhwpgPoWT2iGkyrDxA2eCmIVxmuBEV9qLX9IsYoOfs6Z7sxM/1+NUjwjxN6?=
 =?us-ascii?Q?snkc9+az1tSIt8r+a5OIlxkND6xowAA1MA6TFRTKXmFw58qU2UKOvr9cZFkY?=
 =?us-ascii?Q?MnsC/pN70Hs/QOJ3OWqXZch9gueD54joO1Nq5FeMmYn53gnmb0NB3QoWywT4?=
 =?us-ascii?Q?xR8oK9/Wc6HOolUr1xjGROigoNtSk27E8FK85gFTu9qg5LpraZIz3a3JfpJM?=
 =?us-ascii?Q?8hnDq7ZqhEnyhdaTqZDgQjvbeTMZK4xD/KWyJkywQwK5EuN2vMveNvQJBpVj?=
 =?us-ascii?Q?sj+SchQH8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8ae612-dc83-4cfe-f6a8-08da38dd2d5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 14:46:22.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr8pfOgu9cv6FSYwVJOpzMxWcjs/gP1Sjt1CZjFFMRJfbYXa9uESQtHzyFnLo1Nr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 18, 2022 at 04:30:33PM +0800, Cheng Xu wrote:
> 
> 
> On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
> > 
> > > +static struct rdma_link_ops erdma_link_ops = {
> > > +	.type = "erdma",
> > > +	.newlink = erdma_newlink,
> > > +};
> > 
> > Why is there still a newlink?
> > 
> 
> Hello, Jason,
> 
> About this issue, I have another idea, more simple and reasonable.
> 
> Maybe erdma driver doesn't need to link to a net device in kernel. In
> the core code, the ib_device_get_netdev has several use cases:
> 
>   1). query port info in netlink
>   2). get eth speed for IB (ib_get_eth_speed)
>   3). enumerate all RoCE ports (ib_enum_roce_netdev)
>   4). iw_query_port
> 
> The cases related to erdma is 4). But we change it in our patch 02/12.
> So, it seems all right that we do not link erdma to a net device.
> 
> * I also test this solution, it works for both perftest and NoF. *
> 
> Another issue is how to get the port state and attributes without
> net device. For this, erdma can get it from HW directly.
> 
> So, I think this may be the final solution. (BTW, I have gone over
> the rdma drivers, EFA does in this way, it also has two separated
> devices for net and rdma. It inspired me).

I'm not sure this works for an iWarp device - various things expect to
know the netdevice to know how to relate IP addresses to the iWarp
stuff - but then I don't really know iWarp.

If it works at all it is not a great idea.

EFA gets by because it doesn't use IP addressing at all.

Jason
