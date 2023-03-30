Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA26CFCF6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC3Hho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 03:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC3Hhn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 03:37:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3EE6
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 00:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q27Ef8rms0ZLRcopkLsg1tqPtij2tJt/fB6KEiO9mZ6bbFnZ4v1dFio33s2Y7LC5HVQhM4SBgnxU+2jARkwuGT9nsRuppFUqhSQSjVma2FZaCcY9VevdmvMTkuuz8RB4dv3dYt44ZFTV1o6j/44IrlScI+pyOuvqH/ny4kCs0VXW5HIzhBTWiQH08hvG1ZC+klN6/wUk6mPcOyPaAI8qlJVgwpqrt03zhRSSSDIGISYdr+vQs+krDEeuI8SXbtKf3AasXcbpeWEn7fm/aPefQKWP02VY+NUyK6ap8korw6VDzo6P4Z11QXxW8u8r5w3jNMtXUQtD/EGxoKrrsDvS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG9NM9WfD5IenSba+E7R4W7zgScHW7aSpNGBsZ5htpo=;
 b=PSQXscERqDsrs7ikH9/lEDuD2cR4V+qGsq2FkFx315HblUv9QVkJ+R4gjRLtF02TKvi9+Bc0/QQ04Hg69Epcef3rjxEL7Dq9/RKUU+vk5kkwTomjU/u547J9mhMl6QOl3ONjyUA3Hx8TWdD2zBxFC5XjpOpUf/DqKYVddI2dOJGkzWliEBIH32sUD8XcvjK/wytxurb1iINjFpthr+sS3yh/08c/2cZQoOSnxHseWiiPt50yeflnhGa+sF/P0/sjUagHHBKRb8var8wwDhL/n711vqUyoobBJCr9mO3YNGb5kBhZBqDAEC4/TTwni03ywnXZLJT2Sv7iWthlUXYYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG9NM9WfD5IenSba+E7R4W7zgScHW7aSpNGBsZ5htpo=;
 b=UD2Z2ctlHlPGHkEYF6gaKJbrTH03Ker3t4+sbmzXHMvqb95XbAcfabsdYx9RkojFb2+dDku74Apr6pfDU1bn2PwXW6A83J/p46WxmZSMTJr8oyz+zo+Rhm2Nvex3ghuSyt/kGB7SAYfceEw4k74+NnNF0p5AkiQrDrHIPvSLwEParMvj0Sm+p55bjjSEXitWkgq2kbuut4lRl4B+2ohgJAaNvK0qMcBV57yHFaRP1u4OJ/RWGIa4ZtJEXeSKbjzmQhGeQ1U12ubDShixSrFUGTncLefDpn0VaA9TZjdDBxNEQ2PpOsxgCNKp6wg9f3cGGalq46NLGyO9EjiuUsqweQ==
Received: from CY5PR15CA0220.namprd15.prod.outlook.com (2603:10b6:930:88::22)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 07:37:40 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:88:cafe::6c) by CY5PR15CA0220.outlook.office365.com
 (2603:10b6:930:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 07:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 07:37:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 00:37:29 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 00:37:28 -0700
Date:   Thu, 30 Mar 2023 10:37:25 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <chuck.lever@oracle.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RESEND rdma-next] RDMA/cm: Trace icm_send_rej event
 before the cm state is reset
Message-ID: <20230330073725.GU831478@unreal>
References: <20230330072351.481200-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330072351.481200-1-markzhang@nvidia.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: f42c7f3d-2c7c-4311-1a0b-08db30f1a409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VlRNxOVYu71WSO1+5fIbeo+nPnxm2ec1hJCLcLgweuuKHCWiydM5et95ssRjaoCuAatCcdmW0A6dJ6n9SK7i0fGPKUrDTlrLnLc5eJt00CpRfQBgKBeY5n384HJ1SgyjB48QZM+ZoMhOMZzP80Z5v2vyaZkjgStK8KciQarfkOmu+D82LO2bHblZ2J4NwLfJJaUaaFQVcoJ/aKaz9aT3ZQD8oj8gwm4JRzVuvMvErP9x9EmB8TjODINuUfre9SYUgki92wQGNhQqrUHuQ/8dxdYSQCVH+gpBrEO167BgpSAu9E9rvEg6M5dJM6HGTEgp5ys8Pz7SfH10Y9hjW5347sENlkGHLMohjZpiJZ/YuextZNlvNWNMDQlrnNO0ji8U/GXigC2XYQhlCO38Suf+ZTOSGOILIkymL4z7H0bEYrPNJGiLOeKE8otOL0oqNFyfqXdh/J8Al/UbR9YJI8FJfmx5KIzdtmy9t+JL/EqENtYl7irMbZhyWYwzkaLScnaHzrbL8AGaiHwQlfzA/S8CVgdo/QmrdJjRajJYRkLGjcdi7Lw386+v3IGpcVYCDacghr/E+tJoMcUTZ1Z+lvSbjQJnsElFGdQoVjfzkg5A7YRLlwsHEkv2zwaN27UClRXKIdfZ54Uw0B28mgDBzZwcbdgXAQ8+ZfZJqJgJqMxCbWgxsLfjxL7zQm85wWKlVd/wtjdb7K2UNovEtm6vWNmNgsY36PbTrVTC9s+Zz4PNDJVgxADPGq3Mu1M88c/eW0S
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(9686003)(16526019)(26005)(41300700001)(426003)(1076003)(40480700001)(6666004)(186003)(83380400001)(336012)(47076005)(478600001)(54906003)(6636002)(316002)(36860700001)(40460700003)(70206006)(4326008)(70586007)(2906002)(8676002)(4744005)(33656002)(7636003)(86362001)(356005)(82740400003)(82310400005)(5660300002)(33716001)(6862004)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:37:39.8961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c7f3d-2c7c-4311-1a0b-08db30f1a409
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 10:23:51AM +0300, Mark Zhang wrote:
> Trace icm_send_rej event before the cm state is reset to idle, so that
> correct cm state will be logged. For example when an incoming request is
> rejected, the old trace log was:
>     icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
> With this patch:
>     icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Fixes: 8dc105befe16 ("RDMA/cm: Add tracepoints to track MAD send operations")
> ---
>  drivers/infiniband/core/cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

For future reference:
1. You sent new version, so your patch should have vXXX in subject and not RESEND.
2. Changelog is missing.
3. Signed-off-by should be last.

There is no need to resend this patch, we will fix when we will apply it.

Thanks
