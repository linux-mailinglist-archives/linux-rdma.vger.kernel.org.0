Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB755D175
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiF0I5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiF0I5p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 04:57:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD16393
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 01:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCO9O2jNlZB0aqmNIQFydKOOqeLBpFjRODW51ovA4D6W+rJnOExNhE5qqWPv373b7kL9N4jBaXE462GpXsLzbmw+z4IXX4lf1xGk97cBsohekEoGd3CD7Uq8or2iXz9RCFPwxssopeI8cUQQw6+FKu8cowfqjYKbAq1OYnYS0KWPFoj0G/UCeLGwCCcVu0M7XR4SRhdi9kF7WoN667urZGljWUcU0IUPDBMa0DnNt+qWrxePactSF/s8NvpZ130Bh4uLuEegX4AJoQ5nZzrmZ4ihnJRiAMoe3AHrafdXsLYGXkHKTz0QSJQJNTB6FucdRmHhPCzPyh6Cg/DPWVRp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzGbuAf/lcZVlddd7DcCoEMOSAxK2RSfizCyiPFiYa8=;
 b=Ri21wAJ1Pk4DsIo7LDKbsvZ+94VuyRGkozw/a2JKL9bPfh1qAz7GEJn0sfdg9t6s86wFwf/6dZhUhBkmdKk5npCi3mSm3Xbbh1sx/WCWdt9rZtpY5WAelfTpNfl8P8zxiONoKkCmoSvKPAi+glHvDmx6CZvElua+RddXpWEzl2KdevXa68Gd2ZkN5SJ9YOWkk47lA2EE4RFZnKcki3PGhIKjX7zYoBkSKYgewfGZggezNAXFf25vGdzJdvawwwiRKTIafujbL2VtcQajms+N3FYsegC8xYC8pr3Thb+Ssxbh583QqY6th+0vZ+uOE/e6XxxncXuJfwPyUVsQrCfdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzGbuAf/lcZVlddd7DcCoEMOSAxK2RSfizCyiPFiYa8=;
 b=YSeH0bzKvto2Y7JsEdOs8vDVcsu7ECIcFq6kVzxE9+M2VyYmFRl7PY6fuWpRom7MpB+NeauVLQAytvn7Ybx/DakRSTGEaXWO+oPtlRou2MAByRY58aNTOLxboHj4PiUSsFDlmF38fw5hT670gx/IJSvA/exMqqVaW/64RpAUgJiHO2UN656/dH6nw49tu4rZVl3Gat6pFz0NbA6MuB9ty7ymt/SRjceOfgdhuDmW7FHYK2HHifLJtgB0j8nNxEnp5UV4v8e+9FFPa+DR1QkVZDyvmiWJQwh/J5BzIDPShQi5BO4/1LeQaMiIRiufT5XSB/r6/yN9NCLAFqNmgIAwKQ==
Received: from BN9PR03CA0103.namprd03.prod.outlook.com (2603:10b6:408:fd::18)
 by DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 08:57:42 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f2) by BN9PR03CA0103.outlook.office365.com
 (2603:10b6:408:fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Mon, 27 Jun 2022 08:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 08:57:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 27 Jun
 2022 08:57:34 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 27 Jun
 2022 01:57:33 -0700
Date:   Mon, 27 Jun 2022 11:57:30 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Tao Liu <thomas.liu@ucloud.cn>
CC:     <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>,
        <talgi@nvidia.com>, <mgurtovoy@nvidia.com>, <jgg@nvidia.com>,
        <yaminf@nvidia.com>
Subject: Re: [PATCH RFC net] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <Yrlw+j8dnvCUVa1y@unreal>
References: <20220623085858.42945-1-thomas.liu@ucloud.cn>
 <YrlfSnNNdjkaajAg@unreal>
 <YrluGtk3wawXlnag@FVFF87CCQ6LR.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrluGtk3wawXlnag@FVFF87CCQ6LR.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a144b870-f1d6-4853-c376-08da581b182a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VudhmzMP+Q+OW1qspdHv47wA54yPAjltHMrXx3ETCI0c5N0LpJJasCP80iq9axW4pJDYoamnv6Ump7RirzyYE4A2RgwdLSpthzTkfXvYHAJj09k0pLCk0B73ZFR6cfXol6Wt+E/oV5lmqls4xPB+IUtAXbaYd8/JRUqGP1uPzqpnqXn4pDqtkvp7Fn/yi+grc9arnbZWpfj0ZZ968Y0etf5ZpF/NytjQFfXZMwjAjetq4F20FcfkY/8rHC0MrNugWv9nIq/0L68q5clUwZLunsczGY53iML2an6OC/SaLeEZUVL/Nna8tOJrBm6icAc78Th7kogpAhqp1ieiqw7Pamkjo7CQNe3ZcvKykrLMsRNS28qaysF7iIQiMJeHi5M3sN4wn2MKpxLqT7UmhWpVAG/UlpiEkBRpgWfMUYjjdJwEEhjj+meqOb4cvOh4y0MoiuSyTGhae88MsA/ze/DxfZNYivx78Fe5wOVHxoTOggKPa+UhLRjDCKBy98Ipdq3y7mQ0cTbebHHUHL1wS1otnTv6i3svETLoqsF52/p/8gyiF3UdpOZSLk5ULFSnT3P3IW60IkMNf3jnxFpuZRlItGzq1TUKGv4c+cfadkZ1+H3GQ9oVHWMdywNmq4lRP38H3u5FP7XbrZANynlQJ6NfSfdO1zoOjUlKrFCjCilCBvPcIe+jBzOoiZk2jZnbFd/hqAteL/jdVPFdF9LoLs+0V4BsjvgvnfEuKbjIs/5Jv8JrkJmFhzbg1Wy0bKGD15GXv2E+K/nRMg3Ki3obSUH5Nf0a4YTZKVXnKExAt0g6W+A0m6iUxRyw+GLio62dBgF9GhujjqrpgJB7FMDLLeMq05dLbZRRZI1IGlyvlvVg7+JZrpXkxxQlQtXWDw6KtdnryD2JcpdV1FNcqX9d0dVvLA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(39860400002)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(54906003)(107886003)(8676002)(5660300002)(36860700001)(4326008)(316002)(336012)(186003)(6916009)(16526019)(47076005)(9686003)(426003)(82310400005)(40480700001)(70586007)(83380400001)(26005)(70206006)(81166007)(41300700001)(2906002)(33716001)(478600001)(356005)(40460700003)(8936002)(82740400003)(86362001)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 08:57:41.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a144b870-f1d6-4853-c376-08da581b182a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2843
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 04:45:14PM +0800, Tao Liu wrote:
> On Mon, Jun 27, 2022 at 10:42:02AM +0300, Leon Romanovsky wrote:
> > On Thu, Jun 23, 2022 at 04:58:58PM +0800, Tao Liu wrote:
> > > We hit a divide 0 error in ofed 5.1.2.3.7.1. But dim.c and
> > > rdma_dim.c seem same as upstream.

<...>

> > > Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> > > Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> > > ---
> > >  lib/dim/rdma_dim.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > I think that this change will be better as it won't change
> > decision order in rdma_dim_stats_compare()
> > 
> > diff --git a/include/linux/dim.h b/include/linux/dim.h
> > index b698266d0035..69ae238ec2dc 100644
> > --- a/include/linux/dim.h
> > +++ b/include/linux/dim.h
> > @@ -21,7 +21,7 @@
> >   * We consider 10% difference as significant.
> >   */
> >  #define IS_SIGNIFICANT_DIFF(val, ref) \
> > -       (((100UL * abs((val) - (ref))) / (ref)) > 10)
> > +       (ref && (((100UL * abs((val) - (ref))) / (ref)) > 10))
> >  
> >  /*
> >   * Calculate the gap between two values.
> > 
> > 
> Reviewed code in net_dim_stats_compare() and rdma_dim_stats_compare(), the
> crash point is the only place not covered 0 condition. So it maybe not
> need to change the macro.

Change in the macro ensures that we check cqe_ratio only when it is
needed.

Can you please resubmit?

Thanks

> 
> But I am not familiar with the algorithm, and not sure what is the right
> return value.
> > > 
> > > diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
> > > index 15462d54758d..a657b106343c 100644
> > > --- a/lib/dim/rdma_dim.c
> > > +++ b/lib/dim/rdma_dim.c
> > > @@ -34,6 +34,9 @@ static int rdma_dim_stats_compare(struct dim_stats *curr,
> > >  		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
> > >  						DIM_STATS_WORSE;
> > >  
> > > +	if (!prev->cpe_ratio)
> > > +		return DIM_STATS_SAME;
> > > +
> > >  	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
> > >  		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
> > >  						DIM_STATS_WORSE;
> > > -- 
> > > 2.30.1 (Apple Git-130)
> > > 
> > 
