Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117037AEB10
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 13:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIZLKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZLKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 07:10:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F0E5
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 04:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFdgnfUHKpIwSAt7TL4uaLxSmo+79csu/j7VTnyRgAakYsoW+wN7IRmfs0pxFswyib6SBzOM9Gj5ohcdImLL5uQqVnjUutkerw6jT4Gd8nqG4gRB/Z9dIvusIGNOppVAMFAAjt92Qtjw/pbttWZKODZNsQD0DJMD3ZEqJ0TgfKpnS3nPl0VPAq+VmVYGDGzlBmkAh+tY34vJufzubie7Qp7rWYm5E5fhtXCmtC8F0CM/KE8Nv6g5wJEk8s6tNg0yaIGu/XLyA0i87+9yvQpUX6R1kr6ex4eJ1b0aY9EAmPWqfN2dOdP/GQqJQyovipyyelGXPJkCcn0k/IDaowcZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcVvY3/MhLtpKjrFjP7SqDEIGKvKrDK2Asd7Ef47Lu0=;
 b=Sg2uBdIODXt74vzGW6fy76dgUHR8Lh/C8b8yOVKosjpKCFN4t/7eDEl8e4rWBk/VFfyKJbAo5NKrYOSb3YVMzEH1FHekZBxjBjqppt52Qg93rC3ikhZDY154uDrxtBptTY/6IvEVoDB06s+T1qTX5HOlT4uYBxE4nqNnnSUo58vJx4Iup72iPoRhkQl57K20jG9JuMZYBgHjtB+Vbe+yvpi9pE8EMdJ8dghW/GV3W4ilXmmQZr+3B/pqzCSoVHaSW9ctePQ3ZTG1e/CeSqPnxujkDXPB+GqKkU63PZvyiOQ5XOZFwdp4tY/bTxB8U3KOrcSU/KPM5nqANEm1HppRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcVvY3/MhLtpKjrFjP7SqDEIGKvKrDK2Asd7Ef47Lu0=;
 b=RJBIj51q7rfAlyO+igPxMqIck8uuqF4HHP8uSQVzqGPECpbabVETwR2gCyMS2SxkKIvy2c8CYfZZgQwRt8x5hDhEC5AT8e+UAtBScCI31oD8cFZjvho2y+cIBibDBKQVQG6V26CoArt/PkY+hvIh9rNzNYRDUoMalQbrFRUugcnRBLP015pHvifTFjl79MmHWWgzlDJnlmMkh/82Jk7YI2V+PGWm/CF7rJgrBvpKFV6LSHaK7lxoGkx92Z2S4pCZUaZYQyBhMgY1dKGg49mY0W+AMP5rkiYfAZlbzsNbYoE6v0ky/uhagY65IqSk4y+LkAD0OJeKZ2GUaKUMYz+GnA==
Received: from BYAPR08CA0060.namprd08.prod.outlook.com (2603:10b6:a03:117::37)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:10:14 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::63) by BYAPR08CA0060.outlook.office365.com
 (2603:10b6:a03:117::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 11:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 11:10:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 04:10:01 -0700
Received: from localhost (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 04:10:00 -0700
Date:   Tue, 26 Sep 2023 14:09:57 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/cma: Initialize traffic_class to 0 for
 multicast path records
Message-ID: <20230926110957.GK1642130@unreal>
References: <20230926072541.564177-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926072541.564177-1-markzhang@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ca5041-52e2-4c3c-c374-08dbbe8128b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMEdJSUwk9A/pIteC7hcmZC+75Mq4J2VOwcM0m8Pgtcq8sz+NgAMiey1Hcqin79YJWC5hGGeXU6G7d0btjdKv+SadCCJ4RONe5FISv3t8gdiZIFyIsw9Bhsn8Bq8HGoOLlo6Cac1gIF/YD72IHO8sWqTtb3CFDzzU+gJwZRvs0iu+mqfrvekxzhUcF7sFhrOyOpVFq6aJBjyHyvXK3qGQ7CYU3k8Ufjm52fJhEeEb1GorXEvPByRcK9AVJ5m6DzjFZ4bSxLA6zNlNfgZj4kQ1KU3c9hV9QNLWGGTO5hZbSn9gp/kwCiefq6wPV6KczATERQlJ2M+mLSLmPJAsHDgkyx5/tFuDRXXpO5Szkl7yxBzVMvC2GPiBAUf5oqxmokfTWEs5OdDqC6XD50ZN/Li+i+yO4zi353NEIOUIp6Hu2l1bPLwtXvKINyE9ruAIZdjO5R2rW4clhnsKqkkc+zA2F/qlzo9ezxjvffUyz+sdJwiaM2j7KZXhYgRwdxGUe/1cUaeIbt59nvcTpVp3mhjHWra1oLgqLmsPciji89oPgoefW4Hh6jmPl/Ioed5FPtXNZxunLqfyonWE0AW4iEx6w5jaCEwZMuh2otxrTdDeXBGX8OL98koMctfMUco1tAUNY+I7+xqdI/rlMkt8rYpdlTiS1pEYebOogoHCR5T2/yTUxHhg2by2XFeQUWxeRpUZxfDG4IMAjNgKtooMxbLKuXZOs1vX5KLONTr96L9wWVODR2DqkVWPzvkzt091JD1
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40480700001)(6636002)(33656002)(70586007)(70206006)(54906003)(316002)(478600001)(6666004)(40460700003)(2906002)(33716001)(86362001)(4326008)(6862004)(8676002)(8936002)(5660300002)(26005)(16526019)(426003)(336012)(83380400001)(1076003)(36860700001)(47076005)(356005)(9686003)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:10:14.4851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ca5041-52e2-4c3c-c374-08dbbe8128b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 10:25:41AM +0300, Mark Zhang wrote:
> Initialize traffic_class to 0 so that it wouldn't have a random value,
> which causes a random IP DSCP in RoCEv2.

It will be great to see call trace which explains how. I think that
ib.rec.sl has same issue.

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c343edf2f664..1e2cd7c8716e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4968,7 +4968,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
        int err = 0;
        struct sockaddr *addr = (struct sockaddr *)&mc->addr;
        struct net_device *ndev = NULL;
-       struct ib_sa_multicast ib;
+       struct ib_sa_multicast ib = {};
        enum ib_gid_type gid_type;
        bool send_only;

Thanks

> 
> Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c343edf2f664..d3a72f4b9863 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4990,6 +4990,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	ib.rec.rate = IB_RATE_PORT_CURRENT;
>  	ib.rec.hop_limit = 1;
>  	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
> +	ib.rec.traffic_class = 0;
>  
>  	if (addr->sa_family == AF_INET) {
>  		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
> -- 
> 2.37.1
> 
