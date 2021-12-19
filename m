Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C547A016
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhLSJvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Dec 2021 04:51:10 -0500
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:8641
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229585AbhLSJvJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Dec 2021 04:51:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6E6KW4eSMm4yDWxR2u9U4pWp7jZIuMltOOwbVw97xd1f4X0n676+fimx+se7b0ol/d6GvUenuHuo86pCRwgfk1Xq/xB0E8N2Rnued+nBa+wYdnbE2tNga86gukkcypgF3/3BAWv8I74PXTFFdU9qv/7QS5uO/nApeJIBZMo5KoynfLQ97PdQxcNFuWJR+MtnpaI2UR1quIeovvC9MGg3JI1bNcpsIsSIkXm/mMucr8dGBLHlZKf4B1078AH9Lh/yw7mk8fg3EVR/XtPHKilNn8tULuS9vVqtuhWAk7f+elaV6RhkB6pL5MVpTe1hgm+JVjVKyZoeMfH9vEseyGROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EM311EIAFj2euJWPar518I8wErx8D3He3ChSa+RQUo=;
 b=WlXd9QwpmdPD1Boo+kBpg+4VcZIBnRknukEwdyCoZy1Eit/6GztYe93d8791HsVc1tBKWUWpnKDPofH7tbs7it66nr3NMOTYuUFdpOt+7HnQOTTe/JliyqPkSOQ67bFIhEdnnCvF1ieMR+t22m9Ngsd/NnFQhzXSCPiWVrCW7/JJBHbJiYZLjwYXQ2ZkJb9XZ40C5FYOaK0n8h1wzkTtLOhTdGC0C7wzeFv6IOGwJpBqlnjcmZlDT7ojHnZGSQQiHa5AO/m3IqmYgxmVfBr432cbqAfwUbUV9ih8+pMFzRWTLS9FOigVRoLAWW6j3Zsy7es5LBWzN7AW7wsS3xjmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EM311EIAFj2euJWPar518I8wErx8D3He3ChSa+RQUo=;
 b=SKMLUUJDbEN+6MUYXv4EFTwr0Uvhmki+zQZO1OQ+uI1sIEnoHMFww8ewJ09eGrhnwrxa2PSnJLFWWnaYW1QLYZXJmfbv4O8Tnz1JjLKnTVCV01MQqKeDw2PyqWmTIJBZHKc0oKqpDkOFZ5O27cHQm703BKXAdKeEqjGnlNXC/9vExcJuj21JN7u4njkCY9uqEjVpzzg+kZnAUdjpL2J70m5P8taiUCiYPQN39LUutOXxI73czJ1PEiIXchn5N/MFXmpkWx944g5YMngdXNGEtuEHpHxJlY/CO8bY9MlCa5DkCDde59rKWAQh6nJH8cvKFmUKHifKK/x+fhSg9REBxA==
Received: from DM5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:3:93::25) by
 BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.19; Sun, 19 Dec 2021 09:51:08 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::c2) by DM5PR20CA0015.outlook.office365.com
 (2603:10b6:3:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16 via Frontend
 Transport; Sun, 19 Dec 2021 09:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 09:51:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Dec
 2021 09:51:07 +0000
Received: from [172.27.13.152] (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Sun, 19 Dec 2021
 01:51:05 -0800
Message-ID: <3fa317ce-e0cf-cfce-c4f2-8940ba546b61@nvidia.com>
Date:   Sun, 19 Dec 2021 11:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
 dereg MR flow")
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
From:   Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beb6d269-e59e-488a-09f1-08d9c2d514b2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26116B87E248E0C798EE949BDE7A9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tlxHpv0JMsCXHtHc4ULnkBtxt/XoRnSVzumRTzoqzudALfXfLhLelXTW2LYNUkbEXBH2xiHf9aW5JJq8WKLBOVrzL1KDJsWNAw7/wnib/S0ZnC3a7r+F8Fq4fCOYIpClT76E6S0obz8nziui2DayWGSKUmsUUB9GKcZwVbWPOS81Y+V7F2qbjbA/4+cL0YVJop/sZujt6beqe9yQl2P9c+yQeIJuqL7j02JJugkMdOD5gT3Sz4jsa1IOpM7+umWnYi2u8xLJTW+na+rq5TKK7i9e7mvBAUBj+7EjsjaSLyju+TMMAMHlBQGOD8JwZe5n7EHUP2+fdHsmyNKfdmMqTKXICmAQp9rEWjpzYDsuMjHcX+CRxqWeyTK1209apedLB3zxlzYuox/QTryWap8TbBUIyHBCj1y+6Mc9pjdkjHIWPOY/yAkTF2nK4U/anSgWYWenNVEVR7qljQTD3CR7pPGgIgdptTijUBvSmZiuT4hD3hTxAMO/rrfRiEqnTYZbKgysKKfLnL+UZsw6fWZLhwnNoUIWrv6P1y/kwg9tH7gv8kuL9omxyiaV2piOJKjgd8t60DppVJxSSSrUrKk/f65awcZuAzOFRNXEMbiAQrEzDE76X4BQIedYp9302YcWR529gIBgxwzNSV+SB3rHzc+Te2uKvHR7iz8xbEHshb2Nc6ub7k9tQU9Q0Z5Zli8X2bi5XHK8J3WSWZACqNclsqjnz09T+X8zwbl7QW+s8u3UELKKDdhywI2cTVNAT5SPnxxeenP6bTO8U4qYVYxLr8yHT89UztITtJEhvjsr5IHiclmecoIUneZYm0b+ez+qyjIN2To7FseYUghtCGeMUOPKZvihvyo9Tr9kckZWZ0=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(34020700004)(5660300002)(26005)(16526019)(53546011)(81166007)(31696002)(40460700001)(356005)(47076005)(36860700001)(186003)(82310400004)(2906002)(6666004)(336012)(2616005)(426003)(316002)(83380400001)(16576012)(8676002)(70586007)(110136005)(86362001)(508600001)(8936002)(36756003)(4744005)(31686004)(70206006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 09:51:07.9420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb6d269-e59e-488a-09f1-08d9c2d514b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/18/2021 11:25 PM, Chuck Lever III wrote:
> NFS/RDMA with an NFS client using mlx5-based hardware triggers a
> system deadlock (no error messages) on the client. I bisected to
> f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
> dereg MR flow").
>
> --
> Chuck Lever

Hi Chuck,

I found some bug in the cited commit. Can you please test if the below 
patch fixes this deadlock ?

diff --git a/drivers/infiniband/hw/mlx5/mr.c 
b/drivers/infiniband/hw/mlx5/mr.c
index 157d862fb864..3cb4e34fe199 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1978,7 +1978,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct 
ib_udata *udata)
                         return rc;
         }

-   if (mr->umem) {
+ if (udata && mr->umem) {
                 bool is_odp = is_odp_mr(mr);

                 if (!is_odp)

>
>
>
