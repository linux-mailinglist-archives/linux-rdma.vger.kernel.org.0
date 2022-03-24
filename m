Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91B4E6986
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347580AbiCXTyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353465AbiCXTx3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 15:53:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA3A66F9
        for <linux-rdma@vger.kernel.org>; Thu, 24 Mar 2022 12:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+wke9CVvWzsjUGSsvq7UMa3QDN0yCoC4o1c2PJVxVYClO5kpd8SHGvSc9Mp4VrcWztWM8omGUqUsVA+Z25V41e10FPnn2lWqpCkvFFlXmChVRPGFxoVWTgZLhJPIyKlBU4gCHvlmPgPG3l0n0i/TMocKKeVNsdmmYLWRzUOWbbbO0hHgQZxtHOx7NbmRqTGCn0P31KJnny88ruskT1MDnOhb+L5lXtgIUNUtPvyplUQQ8NG+KDgFSWyKNCQSM543+4t89e+Tl6BQpn0kIHMYvWzkL1EUO9wV7SMaIxhpj4rq8/xyALlhbZ1JIYcPEemucA4f8OAGghJ7Y7hpF7DXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAJE7Jkrlpjk0QdAZ6sU3B6DClNXSyGxif//2Dgs5no=;
 b=Aiq+0rD9o8zE1fY6rK/49o+CC7mllI2GYFWYiEdmAnPiO2ChJzqWvExt6IoUNmLM78W+gn3akqAJCRcYte7Pp6/oeyoqbbQz+nJVqaC4kLum6vawywFhgzxI75s0ZEFMDOAa080V02DZgoACQdUwRjsA+hDxkudf0D62Vuuyl4RWqHrMlwfyJqcfOLgG39C0swJ8b+ftMl0MAt+KBsyNEQoP1/lGGiH02QNfHYN0/ei39u7Mu5wjF4bSeo3/Q2vAwp4NB5g3rJcvY/jwwyphKcyBXfZgLZ7eN+hGG+gc9IUJbgQM3pLf7QqmU6v2sfGg+kAvbChnOeorHE134hJg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAJE7Jkrlpjk0QdAZ6sU3B6DClNXSyGxif//2Dgs5no=;
 b=tYqR97aAF8SHVqLzOweZ9m0jFn0JVZIanAukM6MPPRbz8lqzIWO8WKgaieClTZ+coa7fx8V8axozz6ZdgXuN5ucYfNBeq0bVFPetivQ0XawLxsRLfJdQ0HXgP35v4TITLJBm8U67Zts+C2o4uCUC3nLzweMXSFKj8ivIOASNGQdYMKs6xHxw3WIT0GFP0OAgmetsiTVUDnBQz+lA5d0jRvSXdeettwXUsruLeNDqCKBIYYZeibHX+Tr1GLl91751fw99vuWX2YBFFHgt+PEZ6GaHpflY70DnA/FWpWx+TP/NcKRAbB+3tBNDL0uoEvcEgoa/nweYLk09Aj53G8pPbQ==
Received: from MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::33)
 by DM6PR12MB2793.namprd12.prod.outlook.com (2603:10b6:5:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 19:51:54 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::82) by MW4P222CA0028.outlook.office365.com
 (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 19:51:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 24 Mar
 2022 19:51:52 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 12:51:51 -0700
Date:   Thu, 24 Mar 2022 21:51:48 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Leon Romanovsky to RDMA maintainers
Message-ID: <YjzL1CthgBQaXfCb@unreal>
References: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 162abe96-b4ac-4dd9-2b4c-08da0dcfbf6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2793:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2793E99A39635B1F92BEADF0BD199@DM6PR12MB2793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IZXI5ZOYzkSkDT5Daiyke0zcIqjxp3Y4dokDoO0eB6D/3sCgE0iLSytILxpY2ikQgdth2ZN4ks2Lr8L8rnxkdQe0Q6AASTxWM4nxaaEFk7WH5zZBIdjVLcONiL/2cmnT1tdKpIYsLF1S7Yx8IcQgRmhIQVoZxSI3s+FA7RJvusrvB6bBbhFl7dM8TWY5GwB4daz+Ud8SkQOOZDJ+OTCTGldimXGnDzyYqziZhOmB0VYvKfMGM9tzMPbdAtjgVdiYCLULGDUMFYtXA0brwovQB8p+RSjtbqsmp5DiYlAgdFNssb/5lAsbmeTgwKhzYmFz9rUXIbwNjc2JK/wMASIbm2g/XkIQjUIObnxtjN0WZ3Xsk3eXy51nRyo3K2w5aVUrHDzCvnrGglShtJEpNDJ0VmHU8zgYOXCEDO7hQU0DExOBJpqvuBAIyKLA3NBGf1dcHFfklXF/05CgCRVDFdS4ddiZeJAZFAYtDhgvSoKEZCsSkC5YUrR2S92EPWIgrqXRyjFVAEQxO0WZVKEd/Iw1yIEZWYzQTdTtn4KcIq62TJXIvX78NuTE9kBU+luva7TDoTvx+/cl7AqUsriRMu3TQB1+IXhEdZqOlmXsPXq+YfSlgHmqJX4d6YHj+Sz3UaIVE+Kg60alIGX2vRRnzShQe2ocmDCahvMjU5n0bIKL7eoHjKPbj80U8wb4wEiE+CSHrzkEWXvvXau9SxABLhtJMLa8yy8WGuYJqb+CMuF4Wq6aKFGDvKCgc7lQWYC/Z5syM5jEfu5DFmye5O4k26rP4HgaJQ/Zt90PGc3q6zrQ3w=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(36840700001)(46966006)(40470700004)(186003)(8936002)(26005)(47076005)(8676002)(6862004)(70206006)(70586007)(40460700003)(4744005)(5660300002)(316002)(336012)(6666004)(426003)(6636002)(36860700001)(16526019)(82310400004)(81166007)(966005)(508600001)(356005)(4326008)(2906002)(9686003)(33716001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 19:51:54.6090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162abe96-b4ac-4dd9-2b4c-08da0dcfbf6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 24, 2022 at 02:53:19PM -0300, Jason Gunthorpe wrote:
> Welcome Leon to the maintainer list so we continue to have two people on a
> medium sized subsystem.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks a lot.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c91438481..8f05457f9be176 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9408,6 +9408,7 @@ F:	drivers/iio/pressure/dps310.c
>  
>  INFINIBAND SUBSYSTEM
>  M:	Jason Gunthorpe <jgg@nvidia.com>
> +M:	Leon Romanovsky <leonro@nvidia.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  W:	https://github.com/linux-rdma/rdma-core
> 
> base-commit: 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5
> -- 
> 2.35.1
> 
