Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029252C0B9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiERQd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiERQdz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 12:33:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8678B1F35D5
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 09:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvKAjus2Y3WpQKgwXIwfsCv0VnAqmzRxHpOf9r1dYK8jVkAIj8Bzab9Rpi416q5UzTBvll3f1p2p7pI4/D7nk2EZ0RFxHsdnwd3uD8SAAdj6AswXAwXMd1u0Tgs2KvfuAEjvEZ8HUmnEWwTZ8KMr9sVJ/GY5BHnwNq4tvVENyl/jPsV6Rils+dOq3QfdVGBA7/EBLN5iVeg625DXnkCpbdEdCztb2A3YsKPnlSfZWovTOGnq98wiUfNJDCSHMDDRfl+r4GR4qsmZcd2Of+Yy7nufOjcNRgiGcApe6PcflD+F4+8+f2wORd+fVD+F8issAgJDxYOLKntWf7nt09heFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOKt43Jq6inhCFEiIQVAn5mQiQ4GEoIBRJ39reOQcD8=;
 b=QGK0yPv/WIhD+Gp0YC8lgGJuCLpZFTgdpZw6S0d5UsIvcfs7PEYaB1WAQiidZDMttUIuVCc1LraYHR6+vb/8YuC25ZJbzdnuozAn+RJY19edAA9ftABTE214Fmpuj17e6npDd41MwYTJ/TTqh/wH1u1U1wIWwcYreE7N12Gl1eC8ToShSIbZGFLAeG4npUFcr9amMTCwJ98V/X8fbyk+U1GiVNxXi904tS87ullsay2CPnCFCZmmx68LBkyvzCbhFQnxSe6l0+EnxbnUGp72bkiVdJcOhesHN2xz3IxDu6BS7kcVQvGIx5cDQaROgc/Isg35WI6hu+SpLQVJf2SN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOKt43Jq6inhCFEiIQVAn5mQiQ4GEoIBRJ39reOQcD8=;
 b=ju1oQE7LFaCqq0mE+i0p6Bqspoby5XtccF0YxqDeci9AiJwTRnLtNa8cbtozOojwW/gqdk8GjJDOllxXk0b5xEhpQPyONo48aHEx+UWP9j0iUVhU+60kgcJj2zJRDkd3jUos4pfbDYGYgMVYDhFCQcxwT7i6vVfjLGurMxa5ai9IOUkWgUfO4IoVbMRQW4IzYd0RPkZhi5N2PQ+zzk88AVRYTvMrmE6s5zNWZP6CpV3lVIY7n2UD7pFGTGhEg1Y5zZmREn63Ipp8QFOgU2wLrKcdE2CeIqBykwDT9cwuBEDvzh3tc3en+fseSec61bKTmsePAhuXZZZMXbM2D24s4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 18 May
 2022 16:33:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 16:33:52 +0000
Date:   Wed, 18 May 2022 13:31:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, BMT@zurich.ibm.com,
        Tom Talpey <tom@talpey.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220518163142.GR1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
 <20220518144621.GH1343366@nvidia.com>
 <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
X-ClientProxiedBy: MN2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:208:15e::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be76c631-153b-4def-1b88-08da38ec31cb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51333D040988BFA1F8FE061DC2D19@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRQX8azwNqLV/1GHjsGC4ksOYyTenwbc0tIle4nLU9Qt/M92eIXwOdv6A+rIlC2rKFtvC3WFWdQCUB8EwLXimsaSW6OsavXX8uyyUo5xIA987e1KnyQe5ESqX83suei8i4p5gD8ebL0R8RIol6CpMmIQSaOirxunLCBlJcQn1o6GCeCGTeasJNyroDh4BYr1pSS7Ti9Ud+Idpq3mpD2zD+wXrrTS7aeoa8dsCFxFxruqeAlwZdZ72IT+kywYZzNL82E2L5CLgADl6C0DPEw/v6g519EZwugdM01bP2YcfC5SI0868sm2g2uZQKAGJz2i6Jbic99KCqS4M9FXvv7J/P3FNuGgMPxWAdzCchd7Q+qfPIRcG4KSRrrfYva+pzfHSQ55RXhK+kP+JpsZblTh0gOBLVt7YslD1Q5KhHMXh/5j7BGUwlgaJbUQLJCSQJh1Kfq6GZXv6CsV8lHBn+mgNm5sBhOpaDOeNj6Rh4QIVKUztvKdNNfHLRnzspPqCnGK8mmpXgjfwKyoUVL0ICANY65nhczqGpWufSs+17A3psM61KyBZ3wizNAfnan6eFWSyvsyL95HqPpThiZtEQi8eZ6sz1qTUifYiRsO22vaMIghIOStbcuca8KYGZGC2XoPJm5s+2B9+AYaD+mvO2mf2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(110136005)(66946007)(66556008)(8676002)(4326008)(186003)(66476007)(33656002)(6512007)(6486002)(6506007)(2616005)(1076003)(53546011)(36756003)(38100700002)(508600001)(316002)(2906002)(26005)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wv10Aqj003e+oV7k4p3s6Ft/oDaNiPpX03TeEL0YJxGtyr56eT5o6JxP4cN?=
 =?us-ascii?Q?Og/ZundIVvRD/NUOPjH4eG0fEk/t+gP3GuMhKNFGfT6d+S1ITKNlrjrmSuLQ?=
 =?us-ascii?Q?8cUsGZYZ0V2dBYMDSQQMGMmMCgLb4iIKRO0nXYIxiQ7NwtNP4WpV6ocPsx99?=
 =?us-ascii?Q?WYWm7KBFyXSJUaJwIgtGVAlfqX/+jLyJbldBgBL8PnDLMiYRVZ5tZ/TpoFK0?=
 =?us-ascii?Q?B4erapp6jcS5vpo2W6j6G68KoHxEFGdSSMc6LIkMfkEKSdylP2ywYim1Z3G4?=
 =?us-ascii?Q?pA1/rKDOuQGOxsqdAQ5U9PDsLSTrOsoLTUhQ8GYicEGROWeqmkebmrOxEcQm?=
 =?us-ascii?Q?CUn5qk51Ohh3M2iVs4RQxRBCh9l992tETV9O+IKH0M91o17jq4vqayBCL1GO?=
 =?us-ascii?Q?DKkL4kdFLlCcffslWAzMajGuIO9q2fcniOvZMqWPn3jPnBGLchabKTFWxRhp?=
 =?us-ascii?Q?WQDfm+ZVfIEPD+DY0B2hDX5mxKdAQ+aoxmIPUdEB74QlZqRFHIpoGMlwwLq8?=
 =?us-ascii?Q?kbabnBXSjQqPy4ZoU1FVtI/Zud6fFCQ/9Om2NEYKbYvDx0PMFkGe0ynx3koi?=
 =?us-ascii?Q?okc5L+a2tgKUQOoDwwlBZWwfSLbu3zdkuJ9YUAMXPwy+tnG7yn94oR6yoOvt?=
 =?us-ascii?Q?8UgZXvcnhWWZBGOiJy7qPXEwBmRK2hruiPQEwlOVZDp2JOqN1V1UAJMqSsun?=
 =?us-ascii?Q?AWSoGlz0Fwfw/7kgYbYljSxehZq/OnOU8SHViM/LDg5r4cm/AjB1uWKIYXsC?=
 =?us-ascii?Q?kVTTcLgEypCnlGvyjojTZ3avpRNQAPJVpSqj2XxIpsxeXbxQeAO2EDpddHwP?=
 =?us-ascii?Q?AAI/zzgVrIw+Rd0xgsIPk1OTg6Q/KrivBlGWH9wz/o6XKjZaYoYuQ6jhJX/K?=
 =?us-ascii?Q?57Fr9i0daLqUXDW8G1IpIMzImkrds209icMgqJqDngt+n/oNcbLEQGFbPt3K?=
 =?us-ascii?Q?/R3vGLnYA6QyDpJzdMmPf4gtYGCI+PYx2yev6kZqOmEAP1TTDC7xVkhix0QP?=
 =?us-ascii?Q?deEyVYmuF9Tm4xJ55BVbO8cMOQh7R8DCr91GDIB9hANikddtj9SuV5LyrjpY?=
 =?us-ascii?Q?Ri8UeQ9rZrMBIEfaSkGhzarbxC7QQp3OwugPqvQo55SSD5varpG3Hmoy4dPx?=
 =?us-ascii?Q?FKmHUhsdhSiGftRgVD7rFS571oAqPagmoGKV1H50jjxQy7qMkypxSWBZKfFa?=
 =?us-ascii?Q?DgqzKvMVMDcKGXv6Sl9ZDfSSxMfpuGyF2PDp9l1IgScU3gVvrTwK0X41xCD7?=
 =?us-ascii?Q?bMApWFvl0xsgx8xPZEvX/5t4N+fS00KtsVbHx+OVW2VbXZS9LR3UIPCUMPkF?=
 =?us-ascii?Q?QibTw6NT1T8rnHFbgaifIAnz5oAbjEOBJl9hxS4YJMxxxRHdLH25QOt4XJgb?=
 =?us-ascii?Q?QlXMAH3sfXhP5PRNsADMTdWoWFzyJwB4aQw7jqLQQmj/u8fbCYRE/hnd3hWb?=
 =?us-ascii?Q?w31VnCQdgQ2izdqIeX3gXJQ0AoF/cgp2v5YR7M2IPVLIfX66Yweu+azlmJwF?=
 =?us-ascii?Q?+y3yhuNBpM9G1ki42K/TaXPeI4IWIzU5ZdWqwn1bIjl/CXe+ng8+T6I9/PdN?=
 =?us-ascii?Q?+oV8sMmNZtz4ApkXwFk5TIpj3xEk7HntI1dcKJ0CA5nXjagGF6yY+CJFwhR6?=
 =?us-ascii?Q?8NbR8oOZKxIJZXRiUQjegmpnpu2eMlYfx7nBF0OBtcbAi3JWHZqQ7Xd/UL7K?=
 =?us-ascii?Q?AJ9LWxFWVQijvg0Dgpfk59t93FTUAIOF+PQUoMIiUchbD3sASjaBRpQC6WkN?=
 =?us-ascii?Q?+WHMheLjsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be76c631-153b-4def-1b88-08da38ec31cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 16:33:52.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5VOYtYtacEZhTBpYkGRmfD6sLQhvJwXWdvqcQtYQ/kmP8rfGP5BdG/A/t/Wet+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 19, 2022 at 12:24:22AM +0800, Cheng Xu wrote:
> 
> 
> On 5/18/22 10:46 PM, Jason Gunthorpe wrote:
> > On Wed, May 18, 2022 at 04:30:33PM +0800, Cheng Xu wrote:
> > > 
> > > 
> > > On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
> > > > On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
> > > > 
> > > > > +static struct rdma_link_ops erdma_link_ops = {
> > > > > +	.type = "erdma",
> > > > > +	.newlink = erdma_newlink,
> > > > > +};
> > > > 
> > > > Why is there still a newlink?
> > > > 
> > > 
> > > Hello, Jason,
> > > 
> > > About this issue, I have another idea, more simple and reasonable.
> > > 
> > > Maybe erdma driver doesn't need to link to a net device in kernel. In
> > > the core code, the ib_device_get_netdev has several use cases:
> > > 
> > >    1). query port info in netlink
> > >    2). get eth speed for IB (ib_get_eth_speed)
> > >    3). enumerate all RoCE ports (ib_enum_roce_netdev)
> > >    4). iw_query_port
> > > 
> > > The cases related to erdma is 4). But we change it in our patch 02/12.
> > > So, it seems all right that we do not link erdma to a net device.
> > > 
> > > * I also test this solution, it works for both perftest and NoF. *
> > > 
> > > Another issue is how to get the port state and attributes without
> > > net device. For this, erdma can get it from HW directly.
> > > 
> > > So, I think this may be the final solution. (BTW, I have gone over
> > > the rdma drivers, EFA does in this way, it also has two separated
> > > devices for net and rdma. It inspired me).
> > 
> > I'm not sure this works for an iWarp device - various things expect to
> > know the netdevice to know how to relate IP addresses to the iWarp
> > stuff - but then I don't really know iWarp.
> 
> As far as I know, iWarp device only has one GID entry which generated
> from MAC address.
> 
> For iWarp, The CM part in core code resolves address, finds
> route with the help of kernel's net subsystem, and then obtains the correct
> ibdev by GID matching. The GID matching in iWarp is indeed MAC address
> matching.
> 
> In another words, for iWarp devices, the core code doesn't handle IP
> addressing related stuff directly, it is finished by calling net APIs.
> The netdev set by ib_device_set_netdev does not used in iWarp's CM
> process.
> 
> The binded netdev in iWarp devices, mainly have two purposes:
>   1). generated GID0, using the netdev's mac address.
>   2). get the port state and attributes.
> 
> For 1), erdma device binded to net device also by mac address, which can
> be obtained from our PCIe bar registers.
> For 2), erdma can also get the information, and may be more accurately.
> For example, erdma can have different MTU with virtio-net in our cloud.
> 
> For RoCEv2, I know that it has many GIDs, some of them are generated
> from IP addresses, and handing IP addressing in core code.

Bernard, Tom what do you think? 

Jason
