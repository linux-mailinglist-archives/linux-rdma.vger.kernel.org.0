Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF054DB43
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiFPHJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 03:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358576AbiFPHJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 03:09:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D019FA9;
        Thu, 16 Jun 2022 00:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1HjikEczDgayjRTA+QDFFznzhyvKbgKCp5y9THSZTkAfK8T9SkhjRWHQuk2he5uMnIvqLAioLqCUiO2nq3KuGUb2kXDDfTBtje60eLgcZpTEL7PvGKg+hvqmVw7rU7BWOW5Zsgw+Gl8W4ygptjcmVa+nPzZqYqJTY09JxnFO8GJZM4d5j2Eenm1vGCc4k9BHPboJ1lef9lgfhI26ZQd6Vnuu7CeSIGJ1DC1o17KiKl3EbCZaNUZIpBmd9gXKNx1Ju6BvzJ2zXxf9ZO+YRfwXe6b3l1BJ2e/J307ktVOBg+HxYjaLI387QZqfNuaV4NAAy6EIjlYO25WX+M0kAA0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pba3suRHqOTfJu+7ChpC0/twHAm0ravLWivLwgzGupQ=;
 b=E2cyBm28IgstKZCZQ8HQl2S2eUKF08ON9jSGaxe1J6Y1ONgBkcp34iJ2yJ1RYdBhkUuJnYiPiihWwGR3SGXXRvIkcrG62tL4gie3WIqA9CB/WvHiyk3YgBS6W6APBysq3d4WHDw/3KzzpLI5mgdErbrqBGmO6hDssSwnvY2q37x/mkScGoo8yRnQMDF10Fdtn5c5ykTCMGCmr8+bRa6JFMX4JXV9mJxgDFqZYzbdg0aDv9jun2+vi/oGDx9EExutQg7hFL6l7yY7VwHKC4Cipqp1A8If4NJeGzn0TI062ME4oNj650hxmEPntTUaz8EWnSLCVR0hFom+qBPHr8mIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pba3suRHqOTfJu+7ChpC0/twHAm0ravLWivLwgzGupQ=;
 b=Y0/JeUwKUZru3nF+lRkaTE9DcqcVWH7DjoEzRS4mpUHuTB3rZZZcB1a/2YfxFwIR5hjRe5zE6BO2+tJOBEF5vtZRp9NBYDDIVQvp+zCT/2k217DFgK5/vZrXS3wydb5YWpJXbyoAFrezIaR68VePoKk51fmny9aAW9QZdke8vzG1z/vFh3eBsFmrt2exBGEN7WX8v665vsVRzuCsTuCs64Zd0iVeWKkMMAQ0F9joDijjjwsPLpYVQT8fW6vdDrpiXsiwwRBhDjoETmbupUNQxKbVsdhriMOv1AhDnxTx6p8BqAvVkeI7d/FGxgBem8lzfTtjYcrFK/5eBBKIHFbTVg==
Received: from MWHPR20CA0032.namprd20.prod.outlook.com (2603:10b6:300:ed::18)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 07:09:00 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::87) by MWHPR20CA0032.outlook.office365.com
 (2603:10b6:300:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 07:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 07:09:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 16 Jun
 2022 07:08:59 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 00:08:58 -0700
Date:   Thu, 16 Jun 2022 10:08:55 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH rdma-next v2 0/2] Add gratuitous ARP support to RDMA-CM
Message-ID: <YqrXBxOIzL9J2fQE@unreal>
References: <cover.1654601342.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1654601342.git.leonro@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4373cc6d-43a5-4897-1489-08da4f671667
X-MS-TrafficTypeDiagnostic: DS0PR12MB6533:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6533EE6C073435DC42C46755BDAC9@DS0PR12MB6533.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvoQrrMtV3HKhzrQ66bXTCvsTRRvu4wdO14T2wSiIHMCExtCRbQVqLtV0r51VUYdCQnWuFQ1U/SnFuo5Ys3lSX9UaRBFDHfaMFOboe1DnNmeXjtRcZzVsdGf3CgmM8uSy59/bdyBmvSIX2lCjg411+X6/LsJ44hyZusNUOxBsHjrSNJWt9zkGgCPyDvf2IyBPg6lGsksi1M6Quhstxb8loShAXOGGerLg4JhqXWOh7pgJu4ek1duOhyXbrcWzXfy+TkodA4AO+lmwvpGMlV7fKTZUGKwVIZRqH50p3qfRIwdlkTqO3NGTI1JAW7sAoYGvZ3SfWjOykYgLVBdV4G3ATc8y0dQYXGYAOvgZBoCX8KHvtNmtZYd2eDUioFBx4cFRdf+uV0Euuoq3KumQc9dSWqEO3OrI0kFh2xcCCeVV2bkToHXRmdd3AU8Mc0C/B8r0qu+uL+2XWIQ5IIhoZ/QhQSd+Mtcjhj/MD+0bHITW3whjyTa6fyXZMoRgx7gkjVdycMPUcnp2aI1Y0REpy1hLqrGa64y7SMyKnihnKQGT3DAkd6a043TEt/DzLdE9YFaAtQAYqqKZ4yeZlsee4NNdo5Gh2mabgmAUxTkbuLBkvU5sqnyK6IFb2e2e6xBRVoMs8PxnZt9YaNYleUhkOZfJ7HJgeiQpfYVa33LkxutISJQ2IduWSEOVZM6nitEVEOHHCBzdFDvOMQROv4G8jOMHQ6VAF+5xu10WSCNRJuPYyKA8Ia71JF4N8oEzF3MnBRKiMn470lxmU8oZYIDcvNaqPjxWBC7sATwxoUxB7/94I0BXmv2FKiNyLHCrGswWa6w7Ix+FVbDtJnd2KRrLq6VZg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(46966006)(36840700001)(40470700004)(4744005)(8936002)(6666004)(336012)(33716001)(6862004)(5660300002)(966005)(86362001)(9686003)(82310400005)(2906002)(70206006)(40460700003)(508600001)(356005)(47076005)(8676002)(16526019)(107886003)(54906003)(26005)(81166007)(450100002)(83380400001)(4326008)(36860700001)(6636002)(316002)(426003)(186003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:09:00.1332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4373cc6d-43a5-4897-1489-08da4f671667
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 07, 2022 at 02:32:42PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v2:
>  * Patch 1: used memcp and ipv6_addr_cmp
>  * Patch 2: removed cma_netevent_work
> v1: https://lore.kernel.org/linux-rdma/cover.1652935014.git.leonro@nvidia.com/
>  * Removed special workqueue
>  * Rewrote compare_netdev_and_ip()
> v0: https://lore.kernel.org/all/cover.1649075034.git.leonro@nvidia.com
> 
> ----------------------------------------------------------------------------
> 
> In this series, Patrisious adds gratuitous ARP support to RDMA-CM, in
> order to speed up migration failover from one node to another.
> 
> Thanks

Thanks, applied
