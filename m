Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE167D505
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAZTCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 14:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAZTCe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 14:02:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672569503
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 11:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrAcErO0c5Np/I48NMqSXKnAhxkWsXu5cFtrVHpBfFP1CPr6XYAdhLbpK0gnZjMQE03YFhUrQ1gi3f95W86qVFFlprg9ykGjE9OJdtkK3F4kJnqPifco4A9SqC237BpG/3rJhKI+LdHRgShd4aJ6hhQRHGYMQaQdSMJtdkZeiGPCFcT0CmD57pwizfddauxCtrydh5yCE/ALI55A8r3EufR+3O6PV2MXTOYnl1PYT3RIMztO066weOLmjxVt7+fqy7Gw8b65ieAHrUzXcaKr9NMjWTM0tJ7DoF7e+9GWznAC8XMQaCDBE0Mk+LgU/KFHct6e597CB4/GRXn273DdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llu4JaXYleV91sjY71RcUaXeHq/K43HolhwNAvHJwk4=;
 b=kSQbdfNunFAx7BirZf+Kt0iTqWGpYswmtgJq7t79MvjiQwLLz3mDMD+oHOMhB8FE1Uv8eZa3hv06q1OfYtzQRHjZeJmt6AcHRgUCSGg6F/UcuLV9Gb3ULape29lISG1VIXLEAYm1M8kRAN4H0AC7Qsk9Lf8SgjPg9bdnXKXEXLnnEcxKt4E9PsfhoHBVTbJMlgIqqU4fdDBRqsaBMfzyBQQ36YxB1zpIqRNk5kE0QqdKsRtWKQgCS5Cqa9QWcR/9oyjAW8cP9y7hleYqzCwuLN3NfsBu5DZ1T/a4Sc/Pu9MDFy3R8o3+UhL0qxxafK3L5ai4UFsON5NUGMxamCCESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llu4JaXYleV91sjY71RcUaXeHq/K43HolhwNAvHJwk4=;
 b=KWB7is+y1MBKKwiUfROIP62f5p08PA22s9PZKPg3KbqakzcX6QtidCMJveKHgoykk/DNLQhcdHka+HaizwHxhv97R+UkUOmh+IY937RX/slCt15MbZxitb3PrILtk/MaH1AU3lMz0Fl/GcEuXxZvryKmY/QnXxHKTk3dQtIutcHsiibYSadtB8692qqURaWmhQqVelDgg+xODX12fbt3SX9UjY/pQZ2EwaXbMwU6xfPg6zEvmIIz3n5foqgmFC7kvQzLrSMEvPMOmYPBAoQNLuR8vtZCtQfUJqBGpzG4dHhIdDQxW3SwS77Q2WWTClwq0eJoSrrcJK14Xn+cQR7ukg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 19:02:06 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::37c6:70c5:2b29:befd]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::37c6:70c5:2b29:befd%3]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 19:02:06 +0000
Date:   Thu, 26 Jan 2023 20:02:00 +0100
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-ID: <20230126190200.tsrewoziq5gf7wae@goatcheese>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
 <Y9LH5kim0d5rBKOR@unreal>
 <Y9LJOHWYidVHBDMO@nvidia.com>
 <Y9LMDRBWH+L5CTio@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LMDRBWH+L5CTio@unreal>
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To DM6PR12MB5565.namprd12.prod.outlook.com
 (2603:10b6:5:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a95e6d-4c04-4d3e-ab0d-08daffcfd172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmcVz6Z9DEVjgSd2Q8J+Rar6mX4wPZ7rKUvoZ0lVOflWACtxb0qvQr9pQSu5o/kLuAgUgSCfptMbIwlu6shwwcMi8B8pp4bVN9nDE+E28hdQ0DtrvWoIVsMY/bNzE2C+YISJ24iUx19sdvRHWuaKNhOKgNjQy26Z7gVyTToRa0mFJcoqNWKtCShgrSXLunh4LdIHVCDfLhyxLLSjKBxYQoAUCzPJ+ZOqUBI+vp6/6bEQNsrQnVHbgxpKPeIYuICmAbJewBs8QIsjhtnEtJu0vx2VW5wCILu6Klg6o+Yjc3qkQiI66aSWXLAU2Ki/xVJ0YVlQ4X08tH7TFourMdOu1au6uWLdgh1pUmwVC/qcZEkrgkXVO6cd4nbb4mgOT43cCB9vPORYc5onj34f9r+MVNwiYCJeJN3/cYg5yiBg8Eu6239zdDVXK56uWjGp/8MW/cTsNqckhWu3AuowbNF7It2ZpOlKGRqwKqh6e1Gmmq6jvOAPzrdt+ty+N130lZXLwNxTkils+F4AZI/D4P7OegqwcMTXDnyrpVy5s+qTFoSROav1gRv8Un/GlcBYXXZiyj8a619NCuvYhyoZYgwhS+FUDa37q4xscUh/JcipovC9HtGoYpwy1C9wdzp8/0aqGIi+PM4La/Zy5VkHIIrpwRYLOUAomuUvJNrapPe/MLa0wsY6bAmYHsGCvYIrN3dlIpvOVPAWjvi6jE0R0eU/kYphJq+Q/u7hkdyhG6hMXJSiRAIkkYLILBbKsasX5t4k7664yTzi2S7vhxGIEWTo0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(9686003)(4326008)(66476007)(316002)(66556008)(86362001)(66946007)(8676002)(6636002)(6512007)(966005)(33716001)(83380400001)(478600001)(8936002)(186003)(6666004)(5660300002)(1076003)(2906002)(6486002)(6862004)(38100700002)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DDcIO3Y5vyI9opr/cbVPALlRZ8bSqiduE2p7Az9pqIjjWZcKY4zYC7q8nGt?=
 =?us-ascii?Q?jyEcSJ+yoWCxfRPhwsJq0qZuxQTrEYi7i1r8KfAVOX3AdxatrBECPZHD6RXV?=
 =?us-ascii?Q?pqC1fgS9tvfYeg/Wls2/kWEjujKdqHWa6tXVW0d5gNkmUDwZA8kySVLacxUV?=
 =?us-ascii?Q?bKzCU9BuxYEuoeG/JRxjXqR24CfIgIjN7rOCO4Ulyn3mNGzc1XBNCyn7+MFk?=
 =?us-ascii?Q?LTMA0jN+OBNR51J3A6emuVRTZBR/kv6VhZ6926avNGW6XsN9hh0zd6G9g231?=
 =?us-ascii?Q?WlwdcMVO/LJtJEFfatw7oACRpz1pNAH80LDIWVeYt997IunVxWY4y5JUwroj?=
 =?us-ascii?Q?13KuQtNhJEhYmhkgqz0Ux5ywClwWXJ4xXrRwIVVBwlEO1CDAZD/KNsArQyw4?=
 =?us-ascii?Q?1QpjKN6y4w3oslKyrnZF1g+ZgbX166o8jzv5FZ7xPJAGv5JEinAw1HPUHWep?=
 =?us-ascii?Q?2g5D9K4RTWgoRQKX4+bcHBt3V9ECeDvN25T5x923UEe7PoDzIgQPwDxkshWV?=
 =?us-ascii?Q?krjWa1sA+UKx8Nb2pDdCrMSZap+B0tPZeRXDM1WIUcpm6shWMu7cGLtQtZsG?=
 =?us-ascii?Q?QYSKtveCNODr5JMo6LSDkcP9hPtwpEgyTQ3MQL9++JCMVJKd6pb2yQM/9J+c?=
 =?us-ascii?Q?UGLYNrtKFmmOaQJdfTkODykPSzPn40j6qEVPKhwybLKGy9vAGlR520/Vj/V6?=
 =?us-ascii?Q?aZ18gfI2npjZuehv/9o4YKUfN6xbVHcSYQp3nDVzMzabneEqQQlxc+O46q+/?=
 =?us-ascii?Q?oVK75b4rGh19MEOjclRXc1+Ts+xaqfjdKaPswjmdyQvCKrFQrZ2PylHfj7DY?=
 =?us-ascii?Q?dix6KDMslnEwdFE9LdAxpUlfw36Z2JSOyzhnfggCVrU51OEjC+ZHQCjIWS98?=
 =?us-ascii?Q?NQtkQctXRlYKhXCxQ9x0IdQcbSwy6vnSr4y8nwVQi+Q8mYPVFQNh/5RFEeYK?=
 =?us-ascii?Q?ry6K8/UDuKnUzTmCvFf/6SsSDUJd0pQ5/ETmAdgCi3LQTPEN2WJsDx9w5Y03?=
 =?us-ascii?Q?dETkHYedOgniOv1qmy4K7k1wyByxXR+6puq/2lHl0UE3SAXQeG9eV84IK5Es?=
 =?us-ascii?Q?1rmQTbQDeLMN9SqRrm+kI8FCIYCTPioFfcWqFXzDSw/svueUyX1g0E1rzEah?=
 =?us-ascii?Q?hFUDS6ylYIX0GmceuHnMbOg18ux/1BtWD/EkmcRAlHBEvxEsBRXbeQjjaQFA?=
 =?us-ascii?Q?6PYAKlumyyMbI0XEi0qHVAJegy+83x+KNMF0/pDo77P3UgaUwKXrpOidJtyJ?=
 =?us-ascii?Q?OvWLaVJZbolMugBB+v0frV/WGsls4pp0au2FwMSqSKT/q2d8mXfixcAyA2Lt?=
 =?us-ascii?Q?fSX1Rq7ng5RDVlHhr8zJMe7a0oVie2dvfG2eq6aaGINLmqbViB+qHZBEFHtu?=
 =?us-ascii?Q?lNFKcg+52rlJxDNvmxbhbJb70aJAe7NCWvYeuDra0tCor3uwsL84jd9olBO6?=
 =?us-ascii?Q?9NORTYNIB/7f+spTmvLhUjSe1Y0TW4TnM3Q5JeW8jNXR+W9oKSDCP9lEFuLX?=
 =?us-ascii?Q?toCBeBt0gIPTUrMZ/KE58DViQT2nlYTW8AosUS1KeUw8sLaOPcChx79lKjoY?=
 =?us-ascii?Q?PsWtVKzT7J4hVb/GU0BNx6Eym+mLL/9i/AYRt96L1Oa4vwIlhRjLJJrBgu3u?=
 =?us-ascii?Q?3H1tJI6upHfuh8/ssP5eiTtvyoRTp1I2BtTIMP3MHQFU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a95e6d-4c04-4d3e-ab0d-08daffcfd172
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:02:06.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tGCiyRvXRYnraQgIVoZVg6Tv3aI855XFq2tMIfbcJKbrZaJO/voBbqLlUU8zfEW24XGTTA+wUdls1bkqrJO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01/26, Leon Romanovsky wrote:
> On Thu, Jan 26, 2023 at 02:40:56PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 26, 2023 at 08:35:18PM +0200, Leon Romanovsky wrote:
> > > On Tue, Jan 24, 2023 at 08:24:18PM +0200, Leon Romanovsky wrote:
> > > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > > > 
> > > > Make sure that non-enhanced IPoIB queues are configured with only
> > > > 1 tx and rx queues over netlink. This behavior is consistent with the
> > > > sysfs child_create configuration.
> > > > 
> > > > The cited commit opened up the possibility for child PKEY interface
> > > > to have multiple tx/rx queues. It is the driver's responsibility to
> > > > re-adjust the queue count accordingly. This patch does exactly that:
> > > > non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> > > > 
> > > > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leon@nvidia.coma
> > > > ---
> > > > Changelog:
> > > > v2:
> > > >  * Changed implementation
> > > > v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
> > > >  * Fixed typo in warning print.
> > > > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
> > > > ---
> > > >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > 
> > > 
> > > Dragos pointed to me that I sent commit with "old" commit message.
> > > The right one is below and I'll fix it locally once will apply it.
> > > 
> > > Jason, are you happy with the patch?
> > 
> > Why not use min?
> 
> It doesn't give anything as we are in legacy IPoIB path and it will be
> min with 1 anyway.
> 
To add to Leon's comment:

It is making it explicit that IPoIB is using only one queue. Similar to
how ipoib_alloc_netdev() calls alloc_netdev_mq() with 1 tx and 1 rx queue
for legacy IPoIB when the parent interface is created and also when
child interfaces are created over sysfs.

