Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C57AFA5E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 07:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjI0FwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjI0Fvq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 01:51:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400819E
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 22:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VT9Y8kpgdSct0uCzaqYypIJhvZzoSQzfHoymjqIeD6Xz1wfOaXNu+WzJ+DOyyLtuK06f9ar7qyIe3tRrU5tsyjPk/RQ23kSw4r8Xf93E8R9ukS/oYb6B5jP6DDyYsxG7xcs4ob5ePpvyqD/Z+Ea1kNKmd9Pk++z8gZC1O2wEvsgtxsVozBw0cbiFBu4/aznqHRdzSK+Vs85CqUR3zDQ877ca1nnJ8Qr+9HD38r4I++6g2sKaHHXHje3X6RR5iu9xHhkeBTLNjodsK/L6H7u/g9INAjfvx5gJfYKqjd2a60nuzw7+simsJpkAp1Xk9D+jlY2TZxFnWz8HAO248JWmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ttV8hTGsTuQ/N6kFHSrni9gyC4ec6LWqWeDaDL3q5M=;
 b=n2WG6hQ8GbAx5wlKryeIIwddPrMzkHpPiWIyiblj9pz136E7JYh5Lq6IYeerrZikGZioj7AE2EHQ2U8jxg5u+LzGFZCgn5RK3MsKdJsowJr0aZNLuqPpwNENbjuvujWZHPLiVpdeM+uxU8vjB+e+t89mQVDoj5AMP6qZEXNau7sT6mWo302U5pnrI+quYRoU9iIPaj6wIwRdM6xeP6Q6anA7RjZSQhp6H8wdgl8tk2aTdpIqRBBVq0eVhpcLraHjwkU2BEm8Syw++IQv6iPoDDtfraHDd8iAsNspcUuYVrapv50jgEY08kgA7ZtKzMU20utUFBrcbJy9C6A8r7lK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ttV8hTGsTuQ/N6kFHSrni9gyC4ec6LWqWeDaDL3q5M=;
 b=EUn2uBueDoZz4wTV4CYU57LbM2yT1as9hASNeew8xKRME/O/ziokF4Mhjm42LzY1YDaWrLlnq/YvVK4SIyuswBxAhsMt48rBa8+VXGD1G9a39sL1cmaHU2BvcQR1GTvwHCewyZpC7yMAHU0AkMvpZyd4OXLOq2ELIXdJRf1MyU1S49RjNE0othtsM1eWFWdON0kUaSaeFlAjrAhqBCAENnNhSaeMxrpQgmndxbl0xDNp3fAo8G1P4T52JIDlVafbOZJsuGWJp55AGnA+2YaMYlA/U8qzqoiKhlKuewgk86yjLNnHUxkXMbQ/uSHkywNvBirhRX4bpSR0MRgvLfGRlg==
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 05:49:26 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::2b) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Wed, 27 Sep 2023 05:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 05:49:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 22:49:08 -0700
Received: from localhost (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 22:49:07 -0700
Date:   Wed, 27 Sep 2023 08:49:04 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/cma: Initialize traffic_class to 0 for
 multicast path records
Message-ID: <20230927054904.GO1642130@unreal>
References: <20230926072541.564177-1-markzhang@nvidia.com>
 <20230926110957.GK1642130@unreal>
 <ad6ba804-0a58-589a-ef0c-0a012c47d3dc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad6ba804-0a58-589a-ef0c-0a012c47d3dc@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e58e4d-978f-4dc3-2e2e-08dbbf1d81f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh8ZltTgX8HTDLDiE50llfzmWal5+Wh60+QHMk170EE39lPBb34bV6nurHJsKK26rFPjjz+VbocLbx6khy8YnnZjrBMQOaJcUOvgHRLnyK50Mu+yAbldmpnNeaESHIs3YH1YtjH7SaZCidoFMBlzFUwqcDAOAeaSxo0G6MD0ex1miUlmgzvONGUOI4rEAc+N7/Ryt4szkZK482IYjVJ8zJSWzp7VudSQ68rdRJUmFFU9Hgg/nMp41ntp98CnKKyiQ1lAa9mxPwW/0jhGWInRxf1fvfAG2rzvGK18KBcRPyUyV50N6koFDOUnoN7q+1qYcIAzBsLDORuNft4Abu5G5kakS78zpa6VFesVpoMqOe+1AvuuA+ylxT6cFYA4GBIdgUdOpNmXmqxUXy3FXT6OQoo3YCu4Nzy5o+wOjPuJ6X8NifaLESRgf0DInnbK21RTVlK+IjXV2rHwZ72Wv75FN3Gq7g6Jir5m139Xr4z9YnGt4g9jCjaXwVHjkvHBSYI+89cVUxUFO634ewow9oUR3YQJfObMNDCRi9Yvg2QL1sSAgpJoXBz49OJxQF1g1C38Zs2r2jLSOSdy13LGpm1zYKv/075mpDaWYX+yXZ5S0ffe8ONFrS1jNTiS7dUEGAIHQZ+btzqS5xD98Wje0Y+Nsii/aYdbBJUXqyZHMSPRz+FTW4l9lSVAf0WBs/Zh242sqBc+v3NEMd/Z0rLIzW07IeVwo5gmI9EzfCNtew5fFF52pVVbNykwXcp9IHZtECiJ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(2906002)(8936002)(6862004)(8676002)(4326008)(41300700001)(5660300002)(54906003)(316002)(70206006)(6636002)(70586007)(33716001)(478600001)(6666004)(53546011)(9686003)(1076003)(16526019)(26005)(336012)(426003)(40460700003)(83380400001)(47076005)(36860700001)(40480700001)(82740400003)(7636003)(33656002)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 05:49:25.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e58e4d-978f-4dc3-2e2e-08dbbf1d81f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 27, 2023 at 10:30:47AM +0800, Mark Zhang wrote:
> On 9/26/2023 7:09 PM, Leon Romanovsky wrote:
> > On Tue, Sep 26, 2023 at 10:25:41AM +0300, Mark Zhang wrote:
> > > Initialize traffic_class to 0 so that it wouldn't have a random value,
> > > which causes a random IP DSCP in RoCEv2.
> > 
> > It will be great to see call trace which explains how. I think that
> > ib.rec.sl has same issue.
> 
> Yes ib.rec.sl and ib.rec.flow_label should have the same issue, I just not
> able to reproduce as somehow they are 0 in my setups.
> 
> These fields will be used to generate the ah:
>   cma_iboe_join_multicast
>     cma_make_mc_event
>       ib_init_ah_from_mcmember
> 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index c343edf2f664..1e2cd7c8716e 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -4968,7 +4968,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> >          int err = 0;
> >          struct sockaddr *addr = (struct sockaddr *)&mc->addr;
> >          struct net_device *ndev = NULL;
> > -       struct ib_sa_multicast ib;
> > +       struct ib_sa_multicast ib = {};
> >          enum ib_gid_type gid_type;
> >          bool send_only;
> 
> I think this patch is great. So what should I do now? Send this as v1, or
> you will do it?

Send v1 with updated commit message.

Thanks

> 
> Thanks
> 
> > Thanks
> > 
> > > 
> > > Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > ---
> > >   drivers/infiniband/core/cma.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index c343edf2f664..d3a72f4b9863 100644
> > > --- a/drivers/infiniband/core/cma.c
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -4990,6 +4990,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
> > >   	ib.rec.rate = IB_RATE_PORT_CURRENT;
> > >   	ib.rec.hop_limit = 1;
> > >   	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
> > > +	ib.rec.traffic_class = 0;
> > >   	if (addr->sa_family == AF_INET) {
> > >   		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
> > > -- 
> > > 2.37.1
> > > 
> 
