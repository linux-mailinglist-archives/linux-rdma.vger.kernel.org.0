Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4682446E46C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 09:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhLIIoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 03:44:13 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:44922
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231501AbhLIIoN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Dec 2021 03:44:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFv1On0S3gLoasrZGZ0mJH/a/GL3jG+9dvUsMsfhAJRzqqXK8bAsV7rgnQhMhvhiHhgaz65vuDY3XL1JmwqDpRwdlWbu2DLOqVxqiz9vGN8FbwqjbKVuFfdBMCPZPSm2XaX9+tvt6ZkLYIIpW7vCG4/5UY0nThCi348+2nekc43ry9enBq+CgTw+mBjIm+vYnE04gsbtii+eqzyUs7Rvfg5OMHke90k5yUn+1rTlbM7kuX3mM1eQk6l1yGJlP6jSpLRhhGXQkREQM4Laq163E0xvd6ILM6IujNsOkBwWP+aQHgH6DK/kRmcFOEvLioNZ+x2/HaEmeYBtuhzFJ52b5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0Cc00d0u9R+4irJgivIKdTj7GfKVjsmmZeSctZmnk=;
 b=NqpGExKXKfuTqmikauIy86/TMDArMUSVFpcCQUEPQEkm5PS+3yV10BnnQkeRy0FurNzPjjnv9q1kyuVkNLyVGoWQ6MAfrZkQUOB/Rsd70Q0wHeFLxfS7BYyl8hE31jgedALIwThMloxFhmJRnu/HaXf0F7VrglMWyKYHcXh8n5tN90TbTGuXJEOg9WLzrMX/eBKdXE2hRv27x91wgXKc53FaHEkMq4+YB/K1fAKzr3VloCEgh41ZVgygRVXpmFHs0xKN/Atgn+hwXOadfxVNyL2vE08Heq/3hzbo3PfhSE+GK8xLzsbKs6PrwQhq/8L8mJqCa41GIY3Yy4tXZOi3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ0Cc00d0u9R+4irJgivIKdTj7GfKVjsmmZeSctZmnk=;
 b=qZ8xvY9nPV8uvAouB1fSP2h/bPC0JTxKvE9qDE/TrEtBzo9bixiRyAq2UniIo/GODxGZIPtuLVk0w2NHLw0zucJ5Xc3ZNevCfsBGZ4LpQYP47jZljD4Ul1njfFKraKHGXwzVPkKzUzTIhGeOrKLSUeI/opBS0xYMgiS6AzWlKJ/gHwKI7BNEn7jBfGojrunfHO23XHCPsy3n28j+k1FwgtO/7LfK3bv2r1LfareV0WuansYW/VdDk5CLGOimRj29Cu91ACFt+TldixfDhj/36jBmGVy+05TMlsPgqmt5ueJw53rXJ9ciByB6zHwNOKgn+8A90QIn7weNXnKW8VVmYw==
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 9 Dec
 2021 08:40:39 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::8f) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 08:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 08:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 08:40:37 +0000
Received: from localhost (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 9 Dec 2021
 00:40:35 -0800
Date:   Thu, 9 Dec 2021 10:40:31 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Aharon Landau <aharonl@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/7] MR cache enhancement
Message-ID: <YbHA//PfQG4I8GgO@unreal>
References: <cover.1638781506.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8236b2-fb29-40a8-1e29-08d9baef93dc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3633:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB363304891650628C6E8589DDBD709@BN8PR12MB3633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2n6l1+8YfjrTLEK26iJDnpAqvCd/60pprOah97rjVGcuoqGka1PhsjIQFhSZfq7lNgA1RscSwxP7KqxP9dOIKMGaW2a64H9Pg6pvXxsZZhWlykGWKkiG235N+aNnM5//eKq6l/MorhaQ1AcZsJcWjwnGOjyJKtNbUi3jXn0k+XUJwZvks0KjF7yISmMzza+XMDGwxXtkZfQl8X0K1sWZT+GVmX+nfdOd50E/ElX/9Ulj757R6dxJPIQwXdl7+jYiKosBGHFYcFA3ockoDkMd7HZzYE01MxhgdI63jZVBiGTPBoEoDOC0MWjxBeai4y0www0zeEHKGtFjylmpkCUNEsS8LtgRSH6Wg9rwiuiRWF/O31zgNmmuroLD+VOYUHj5Ap79HrLr3bwLbo/mtW4phj9N2UAzC/fY3e9bpZwZLJvFaeguDsB3CIsk7ShKBBTRCSmvmrglnTBN89uTF2eAi7EitfQ4P+Iytl5nZ5U2x7gkeA/CBymVTBWSUz6A9xlQ6t9TrdnlvbcbPVQkm03KBtOo7RdpwLpTw/K8kx1RWPSWjEicuxfIHoW8bprnX/qBjqKC2kZXT8YOlGU8BD5v1ncm0T5lbv+yCADj5lYpz78DymfdNm4eqY5hOhEj3z82WeE+ppGYpOrg/clKIm6OXtUIRvudAb5oZVMUyMFJW5/tgHc27DzIlH4pTF518EOFgUNGONQWvIA4hnuknsjdhmEyu+9OlA5Jiv250NlqHtJTqQj2MEnEfumggcrZh6hUs6XukF1G0Qt489nwRwHTCytiUDZqyuWRyZMAIWjQQA=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(46966006)(36840700001)(40470700001)(508600001)(5660300002)(186003)(70586007)(86362001)(4744005)(70206006)(83380400001)(26005)(426003)(47076005)(6666004)(336012)(16526019)(6636002)(316002)(8936002)(40460700001)(9686003)(8676002)(33716001)(2906002)(4326008)(34070700002)(6862004)(7636003)(54906003)(36860700001)(356005)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:40:38.5887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8236b2-fb29-40a8-1e29-08d9baef93dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3633
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 11:10:45AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Aharon refactors mlx5 MR cache management logic to
> speedup deregistration significantly.
> 
> Thanks
> 
> Aharon Landau (7):
>   RDMA/mlx5: Merge similar flows of allocating MR from the cache
>   RDMA/mlx5: Replace cache list with Xarray
>   RDMA/mlx5: Store in the cache mkeys instead of mrs
>   RDMA/mlx5: Change the cache structure to an RB-tree
>   RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
>   RDMA/mlx5: Delay the deregistration of a non-cache mkey
>   RDMA/mlx5: Rename the mkey cache variables and functions

Let's me resubmit it after more deep review.

Thanks
