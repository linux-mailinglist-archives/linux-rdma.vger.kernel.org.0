Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEA363CF2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhDSHsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:48:07 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:41060
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237962AbhDSHsF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 03:48:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJUwC2dRGgAU0OZwE6S8kULxJxt2ePQw/M2omNrN1427Kfdy5DQBUHk1fiipVNRRGaAhWK2C7hKt7EyfpGDYNkPDhKOxi/9WXCSc+NEkR4bcjRML5dsa1kCclNMONsOos3JsYny0WQzYTw6j55l/1Fcejjpr7a8TuBTXbSTiXFKwcUXXg8p+Fnd/ue49tc6wyM7BFfBYZxWtK5UEdTOvfSzpZn8cPAYDJd2cjnmpBTZ3LQJ9srXJ0NBYbYtFQjkcQz7c9MKU5HnZ5Zn3kNhzfeUCx9moH+bDbUjJp35458XwODZTyqwSGaP6EIFKMG26hCUbLRcziatVddQdPVctPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/zpGDW86HgOFeB8V0FJ/H/IpQlGkBxH4WGawYnXjpg=;
 b=i5g8GPUQWcqI7Io9W0wwm6AII9FxOTlZ4js97mNG21orgooPC+GiklP3YWS5Ufd6x7K/YdGUPmqgIoJ1Xj/ZW+IWN9h+01CTtKmPiJbrkPNdakbOUlhEgrOM8FgX0bVzFZNfQ7jJU6qxsqHVNw9hfRQ9j7ZDqpkkTbKd5nG95d0fyw8ffXc76OEj44lo2KwPENVM5v6dx6KFG3jWREu60ya+vY01DnVxyEV6/jpGozURpO5aTGffSBKloatnrj2yvB5g0/R7Q7xw+p1jN/LHTEvuTNHxTOe3ikOq8vzgCURrUTacbkOkS/KtAD5oTPbvYuv6BOKNfz+j/fBJ22NYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ionos.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/zpGDW86HgOFeB8V0FJ/H/IpQlGkBxH4WGawYnXjpg=;
 b=h7qYzxQvJ/EKuSpgt7NmFouF8/dw/SVqsdpB2ZYw2gascDYBrOo6F4uC//KJhTfyevZmFpmAjijssUm4ZB0is44fNUuDhiPTgCaeW/UrEq/5UgZRu2YxT7uGVzZTg7OAGhH0acJzdknsC53sbjZpcfFd7aaynU2ldwJ+3nPA8npXbdJQR09V34Qhi/veX21vk79SJZTZgJb92TzjM8xc2LOP6AtktacGhjc/ZWOliPHyzz3LuMSU2eA7a7sR8O/KwQdfG1xeV2GxQG6WeyRvXWvESPWa542BizZy17se7gPpxoe5VfcysxMBoKRAksFdDLB8knBQcmB+GSrlQGLI2w==
Received: from BN6PR1401CA0014.namprd14.prod.outlook.com
 (2603:10b6:405:4b::24) by PH0PR12MB5433.namprd12.prod.outlook.com
 (2603:10b6:510:e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 07:47:34 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::9d) by BN6PR1401CA0014.outlook.office365.com
 (2603:10b6:405:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:47:33 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:47:32 +0000
Date:   Mon, 19 Apr 2021 10:47:29 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <axboe@kernel.dk>, <akinobu.mita@gmail.com>, <corbet@lwn.net>,
        <hch@infradead.org>, <sagi@grimberg.me>, <bvanassche@acm.org>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCHv5 for-next 15/19] block/rnbd-srv: Remove unused arguments
 of rnbd_srv_rdma_ev
Message-ID: <YH01kXEJFZgxjQy9@unreal>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
 <20210419073722.15351-16-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419073722.15351-16-gi-oh.kim@ionos.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef41e42-b8ea-4cb3-ce96-08d9030764a9
X-MS-TrafficTypeDiagnostic: PH0PR12MB5433:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54334FCE7DC89647B4BE474CBD499@PH0PR12MB5433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOt8iAebzXEExgqYacziWus7A3tmJqYhjOy+LiaewHO6pPXH/QQcx6VqFi0xLm+3186ByaDl6nfIve2FNqzVO/zognAG9P8GI1K6r9qs6mlfXaeculxXhmNAYR+nSNVFBFW9rAgufGh6V3cOJ7I7c7Idnwz1dKBAZA/oGU5+ygQuOfhPgIjie4t05HgQ5A1TB7ZYIfXtCptSFqdckXj9S7ZytZWdQTJex3w/QgoNSvmVpyBRP5YZtGssL+CgdwgmacT8HZpTcoI+uwbP9RydSq+/LqppD7QyCb9Ja/a/favvuZ6Kj+BHKZHRZR8LM+OttM/zynvuARInZNrGHNeZJGvCcVATLrtXFKjMKRguHqrL7iX3IV0PgCGF1LSMom47qKyujppwVW2pFfvAUwdAqoodg4xGEZ4R62Ll4pA0vbFvavECVZGSlD1+/PCvgNN2MaJkKyNALM7+jhfHvlNxlRob94azJOThSgJPAB0ivqrTYMXAOjRy2qqcCdw30LaOwJprFwdMKNSh5ks4Vo8Vx7Xr/bVgFVQyNsc05f/RlQLKui6c+Cy2eLXpNQwBs6Zqvm56Z1YHmBp4tGrshIFJgfpp0itrUwuw3snu6ps3cfFve7A4sjFfXqIAJuS2MACBKFCIFjnfmrS1SEAohd6Cwg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(426003)(336012)(26005)(86362001)(4326008)(7636003)(356005)(6916009)(36860700001)(47076005)(316002)(186003)(16526019)(8676002)(82310400003)(33716001)(8936002)(70586007)(107886003)(2906002)(6666004)(54906003)(9686003)(82740400003)(478600001)(5660300002)(7416002)(83380400001)(70206006)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:47:33.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef41e42-b8ea-4cb3-ce96-08d9030764a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 09:37:18AM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
> cleaned up
> rdma_ev function pointer in rtrs_srv_ops also is changed.
> 
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c          | 39 ++++++++++----------------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c |  4 +--
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
>  3 files changed, 18 insertions(+), 28 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
