Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09CD3EA61C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhHLOBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 10:01:44 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:28832
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232351AbhHLOBn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 10:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJdXcgbrYm2prPM78p7Gm9AGKkOfZCAwHSk9QjmxgHlSbnENb0f/73qj1p8t+/165Ct2fV+qJp9RTDRrnYQQLFW4DVuS7uiuZiyYbUlYtFzTnPC+LKdn3kalp1XM3SBrZ3pw4iGEwQjLEU85Pju/87aPimmI7mv42vuHvBYzsdK6KNzo2dw6Pu3rEEwzyiu2OT2fXgt979VUCqw+Zs2ZbvXCiJi8UemdlgNkPp79pwREOoIhUNNXhBRERzU4wO33WWFJTH/QtfSt9cSbMznWgtdDTlizGHiz5tC+R7PKRAi9JIg3QTHP6POOQjs6iceOb13UOcEz1+yB8qkxHU0veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXE5igAoxfTobsunkDwpahLr7Addu72ESeDNeCk4nko=;
 b=c08XiPuUcqhAtaJg9pLZ4YZtUhvW+etkx+e3PRAQavddNGjRH+gSViC/ZrLtTeZPviJmXg1HJ/SaDyy4+ZEUtQeqCGYuhF6lzXHg/eHPS3UoTOWRUKVOmx05CXU4h1Ym4SzLU6udEKvd/4xy6uO3PQchuL/ej089n5/7sx8NkD3Q1cI+oajPNQj0a7Jg8O2BwqxAENqOJXwCsX7/zeStox71wlT2pDXYuF1ZFEfDM2TKgmNt12lwYcvEL6mPmI6pkexjORR3XhXkH5IF1lNPP0ZxI4yfP1NRJh5lH8vOliV/coDfXuPyGTmpYhCQD3SFkreVGyQDeegTqt0mBi8Fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXE5igAoxfTobsunkDwpahLr7Addu72ESeDNeCk4nko=;
 b=qjfMphqOSmf1+p0iI2cq6AQ5ojFIvWesvRakzc/6xmG6bmRfUVmV3e6h7yhjK5Yeu0uKpGJbW8HsnY8axoR4/eqyG7xELL4o/tgqt58eSKdrPe7rG2Tnjruu8lw/xXz7olCNXZmkwWnkV/6jz9FqG973x1xoED1HmlAfbAuYWc5HjsusbkKzyNT/3hkSbEkXLdth3gn7Fyc9/mQo7YoiHt5umck5gb0lJ0Nh6NRvNK8HbdpliKpQN7KZXsEBvjhg2ALoNcN32pqafoJpEpm+vE14jz4R2AOgCEAYsHoZICbxSYgfRMYMOmd4ol4MdDmVAohz+tH4ZjedHbzipnjmpQ==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by MN2PR12MB3582.namprd12.prod.outlook.com (2603:10b6:208:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 14:01:17 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::11) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 14:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 14:01:17 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 14:00:58 +0000
Date:   Thu, 12 Aug 2021 17:00:54 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Subject: Re: [PATCH for-rc] RDMA/uverbs: Track dmabuf memory regions
Message-ID: <YRUplrJuFNAOjoVh@unreal>
References: <20210812135607.6228-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210812135607.6228-1-galpress@amazon.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c599df-61e3-4e1e-1515-08d95d99a7ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB3582:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3582D1903D9AD01E48F3601BBDF99@MN2PR12MB3582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgKFr4eG4ZMTQv9YArvWa51G961wttlivrGXTvJUtLvdkZeEvHkCmiIiA5YOG6WVH6UGWFp4+wZ4HvOymxNeH/0ITR5NtDlQWGTo6lA3V1XyWNI3VXdshpKIwS7Yy+2pPl5o1avM90ujYl0mGbEGMGhhuvoVadObImOf80xYewdayOEk0m8OPAbBZwVRHN6GR/cgrZB2eygvVhRWOcF2u5SpuGj3jFdIW71rRUrnonGVX/X4Er6iKJjhKQkFYgksVrNZLjbO9dqRaIsFex80BNUourE7ZSY3cCkEkAMfU58CKvxMWT5M5s6LNSdwSeOwDQFjlbAnPGTAGpLsNIZxAcK+SjqNdxsc0DEGVqd81NvBqoargPVieyI5L9NUt7xtBycLx4/RWKLEU9nZND6AJbEpRFlYsdgoLRjyM2IPD3DcFY5LoGmtafxGVSmRcyT7UTChn8FTVHaXMK4Q/AMhO0NDXco9kOrUF8fAx+bu9N9Bof5SlO9CZXMD8jNvDNvEUYomdSdqSpKFLQFQFb4GgYvL9LDA2Hg7ny2qYNRgA5RcM8qEoMklr8dsyz7DXXucvPoaMRwy6AGI7b+NdVmDIz4PSV2lmUE2uhGWScaFr9KL0jFu6wPoFJ2Tp+lQ9UcWMZ4bBFo9+DjCl2TAY5UJDRagO9jLTqf9wBtQUJnvEm/YZ1x1GHCH3JlTP+Y5aebHphPrJ+1b4F3FjnInNwzGcg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(36840700001)(46966006)(4326008)(33716001)(7636003)(6666004)(6916009)(82310400003)(36860700001)(5660300002)(36906005)(2906002)(4744005)(9686003)(426003)(186003)(16526019)(70206006)(336012)(47076005)(8676002)(70586007)(26005)(508600001)(54906003)(316002)(8936002)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 14:01:17.3014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c599df-61e3-4e1e-1515-08d95d99a7ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3582
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 12, 2021 at 04:56:06PM +0300, Gal Pressman wrote:
> The dmabuf memory registrations are missing the restrack handling and
> hence do not appear in rdma tool.
> 
> Fixes: bfe0cc6eb249 ("RDMA/uverbs: Add uverbs command for dma-buf based MR registration")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_mr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
