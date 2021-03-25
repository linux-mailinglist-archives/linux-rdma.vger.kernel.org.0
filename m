Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB934967C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYQMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 12:12:43 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:17120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhCYQMS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 12:12:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOxHmJn9357c+7Aezi+4gRyaQB+UwuqZx0XM4s5qHvDpUklEjS0CbDAcnO4tFbhzk0FYZV0o1HX/+b9Lb2WIaQ56IWxNDQBl08wR13uIy+PaoTHDz6x9ZA5VaK7waCYONKEtMmE6qwAFOjoMUfJlOkYDwkzRnjFMYw0qt6lJj8wLTzrLUXg6WXBbjpmB+cm56dkTpLFvwJETnBYPJQTSwl+d3N0JxUImQdie0Fe+3vVQTAFEPqekOG1z1xfWH30c4GUQ+7hbaOf/zYcDPaWbtX4TgG6cw9q5nho2q9veTGMnU6oMdURaGbuhB69mbABpn7itiBpwQS7DWRVm+MMcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsAM5J3Qx3//ShhYGFre8NvJqcJee4FAgICGHnj3+3E=;
 b=Fv97sIftNfVMsnCk4jAS4FbMEr6Y9BOQR2R+gGlzrduvQRRr/zbYjN2QztfHzRVv5k+gHSljeBBJ/jJPubwtAr8c+hXpWwY0zTmlCi5m4zqgYEeouAiqUY8NPed5aU10HND19wSWX3ZcW5pTeRs5rWXSkRm7NpXVPWVdHzA38hD2fl8XIxm1qjw8ACvfLXLWwiDXGlc7Ygqm/8PwEf7IhygjBHVHo+DQ0LP85fMPaUZXM/OswXLiho31uHw5vwt8lX2CPYuGpTlSt5Rt1sjV7yLzq/SDrAbrNlO+LG6m3jNU1MmM7yxlP6uae2GF3WkSBGjNOFXn6poxbldlJdFRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ionos.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsAM5J3Qx3//ShhYGFre8NvJqcJee4FAgICGHnj3+3E=;
 b=PmRIvcJb2a4e/wZcE50W7o+IeZ+0NwxK50h3ZyKDztgY3BwToY6fWzc7JtOErCptyB08dqR3OuwhlxM2ocJOyLMttCnCi+XqG8EgBj6Vq5RfflEDQJi3aXWXXpMNkt+j9QG0wBqfGkTuGhM5UmcU7PUqIUA9WN/3mYtrvr/K6S6n3BxLIqk3ymGQhMTwGu0ObqBk4AHg4lcIyeIoWDXNq4mlj0FE3riKqQ9cRqfawzhl3nXCL/aRA7C8UFGFQO+SDpyAid6E2nWikgjjUPvgbZ3Sugp3JwNz1trJO6bM02oH/2Text+O0Ybsh+vIV9pKf9bSoZo3g7eASxiCgkjDIA==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 16:12:13 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::7c) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Thu, 25 Mar 2021 16:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 25 Mar 2021 16:12:12 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Mar
 2021 16:12:11 +0000
Date:   Thu, 25 Mar 2021 18:12:08 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <hch@infradead.org>, <sagi@grimberg.me>, <bvanassche@acm.org>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        <linux-rdma@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@ionos.com>
Subject: Re: [PATCH for-rc 13/24] block/rnbd-clt: Replace {NO_WAIT,WAIT} with
 RTRS_PERMIT_{WAIT,NOWAIT}
Message-ID: <YFy2WJEpOpjBxx7f@unreal>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
 <20210325152911.1213627-14-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210325152911.1213627-14-gi-oh.kim@ionos.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd7bb2cb-05ae-41ab-2b41-08d8efa8c020
X-MS-TrafficTypeDiagnostic: BY5PR12MB4210:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4210EFF7C6146BA671DD742DBD629@BY5PR12MB4210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTDcobhElVjRrJ2duGtN2II3HZ3RnfUeklHOEiGZn+JYylFMPHpZrgDhAN+S6kju5kITZl0nn9Q99EY9ShqCHLCnmD/SSynZAQHM5imZMTo+bsjBF/fHL6INox1go3ksy7iPDuDVi/PPM3FsFtCzd19cgYQRrmPTKSNCgBz1m0TVVaFMpzrfLndYScY6V7+3suVY3ljAvDwm7mdBBh2GLLkGMEsEjIJ7+mrN9tgAWPVuY42u8kXMXOkaneI0LLMUFhv8lrG2vgkT7NDJDLP5NVoV4oaGiAhadwmfT4pYXfWtOB9JhktYVAd2SFvGj225FmnbI1Fi2Qx9XpfmFD7H+yI3WbYfKViWlowb7xAVNQUqcDsvrRZCXflC9ERR5rrdqsQQq/8p95pmvTs8vz9yGf/lR/k/tFepB45VIrv/BT4xVQwTT2MYU2uNNrzxRaIgA6br7vOfmAXanjyETU6tMchzGEExMJdELXek7my7Nokv9B4Mfj/6lsvcRMo+Dy/aoUfZJG/8AT59w5c37z9Txy3n2MrHDJgDEUdW9d0htmPnp81szhNlpefCtESBNtSCGlXHWX+UKjac2yJQDxiDBMmR+pfTRIFU3B/NlUizH6tNq1J7+sm5uKkLePY77nalyzobM0q8La+T9tf8MrqHkg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(7636003)(70586007)(82740400003)(70206006)(86362001)(356005)(82310400003)(426003)(47076005)(83380400001)(336012)(8936002)(8676002)(33716001)(5660300002)(4326008)(54906003)(36860700001)(2906002)(316002)(16526019)(36906005)(6916009)(26005)(478600001)(7416002)(6666004)(9686003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:12:12.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7bb2cb-05ae-41ab-2b41-08d8efa8c020
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:29:00PM +0100, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> They are defined with the same value and similar meaning, let's remove
> one of them, then we can remove {WAIT,NOWAIT}.
> 
> Also change the type of 'wait' from 'int' to 'enum wait_type' to make
> it clear.
> 
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c          | 42 +++++++++++---------------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 +--
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  6 ++--
>  3 files changed, 22 insertions(+), 30 deletions(-)

<...>

> @@ -535,7 +527,7 @@ static void msg_open_conf(struct work_struct *work)
>  			 * If server thinks its fine, but we fail to process
>  			 * then be nice and send a close to server.
>  			 */
> -			(void)send_msg_close(dev, device_id, NO_WAIT);
> +			(void)send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);

This (void) casting is not needed.

Thanks
