Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD2363CE8
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhDSHrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:47:33 -0400
Received: from mail-dm6nam08on2041.outbound.protection.outlook.com ([40.107.102.41]:39265
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237895AbhDSHrd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 03:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgBVfa1u+qFkOYCtg7esAVx1SeQVFazGR6rv+A9WI56ebYTDRTBq6ztZEITNioWPgOoB80BQ3clYOEBkppzTj6birfvfRFj0mX0B6SZJAZZmOVV7wRPeQdjLM+66yX9g23pIyNm0iUorpSIQhW9+XZtukgfclbX85fygOmXxzcp0s0jYWv2zF0AeaZzoSHTAxJ8gjFMYNYOPssM03MUsvtS/T/Akxbtob2x9fI7WEn/kospdCuER67ntvNUFjM+uc4mVSkR7Sa34KZN9zE0FozeXs6utLUFJ2iTmttTuC0gvcCo0nYN5MU0dfv5m1BvYZms0GKK6D0b1TuYaKmKFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I9sOkmxN1NXQf6UemQxx9sLypH914o0KvHa35ZAHcA=;
 b=MfeKQRWQTWj81eLMoK1ohZQGowx7deeTCRfOTrn6lt3y90foRjWwJiNNuA+a2NWskTSUF+xZK60RsR95KOvG0AmL+xMAfCNLtdcfiBZvNbNSg5WiYD1PozukuMTY3Br0xCHoXTzeqWFjwApwIt+65LkEuk7QO+y7yJynWuB1m7bjfhnNP8j+a/allskPnwWQoohw79Ffj66HRvpKkQNI/fRIJM7Fj//t8j0TJyc2yDEbUDx3t1135sEfbVS1S9tYGRtPZqbYsYya4Cl/Elh4AMrMa7Qh6B21uKLRXJ76tlbrtV7glFGk4CDdJCfCZBoaQZ4kf5Gu22fHBQc9Elt6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ionos.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I9sOkmxN1NXQf6UemQxx9sLypH914o0KvHa35ZAHcA=;
 b=aqesMWh5kaY9MmujtVuO+GKJMMifaxIyn2wamn56R4/cY6KXKxZwD5ZcQ5MYtYkQUcChj5r3RZbVuf206mUpmjhlARCCMK3XZmPefYMwRaCXwPxam0n5okH7UXMzBel0BuHFsC30qKhPdV47W+jf4wWCVzZouuGQOqqkSfsrXwP09+vAfUVxfq4hCzB2c3RGLZfceDDE4k5brO34YnJ6El8mffQBIv35T7D9XdbygBUSpCsK7EF1n5vWPFeqlBYLeLAZNkZ3K+PsuRuM8P8NywboWZA0us6YY9SJBkTfvk7OO2zoCUxOgp8MRzCyJNXFeT2EphPjDbhmd8+3v+Fn2Q==
Received: from BN6PR16CA0002.namprd16.prod.outlook.com (2603:10b6:404:f5::12)
 by DM6PR12MB3354.namprd12.prod.outlook.com (2603:10b6:5:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 07:47:01 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::3) by BN6PR16CA0002.outlook.office365.com
 (2603:10b6:404:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:47:00 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:46:59 +0000
Date:   Mon, 19 Apr 2021 10:46:56 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <axboe@kernel.dk>, <akinobu.mita@gmail.com>, <corbet@lwn.net>,
        <hch@infradead.org>, <sagi@grimberg.me>, <bvanassche@acm.org>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCHv5 for-next 08/19] block/rnbd-clt: Replace {NO_WAIT,WAIT}
 with RTRS_PERMIT_{WAIT,NOWAIT}
Message-ID: <YH01cJefECbRDZLl@unreal>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
 <20210419073722.15351-9-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419073722.15351-9-gi-oh.kim@ionos.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc2847e-c6ca-4506-6e6f-08d9030750fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3354:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33548EEF6182E995FDE26E13BD499@DM6PR12MB3354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+5nUJVelGkvmcVybpjr5srHE5xlUVyItwY003b6dXZNHTzUbMZ5288Ue8qYh7Z6vI4R/1rk7SOhPbWg71fMujwFTjRdonMdcW0EvFQH8qAS3HAyfK1brX6VoihLT344TNpy22RqFfajV1j0Z1F3vt36AS54uMotaKCo8gNHtyVgK1sLY26dPSFBAP4Mg/ek4w9AplMx29J9/lBcxNKv1OXrcJ0NONi10etX2URXZuxG5+FijoosAduxp4d8C55IPmxRKSvr79m6JtpX9cTEqcxqT1NULZM39z7um/x1xnldB9iC/tfrlSniLbGqdYSnI9BsY5YvVip0dtb19qqqW/VIXMlQgT5hQ3UhoCC9wDgAsg9WiPdhti7s+jhp6FmS1DjNOPCPK2A4JSqQ7Yvcx78pQaWqatU37a3Hd9jzAsiMszG7O1mCTQIR5DmMm5w5ziTYgsXCZIcSBvf8ops2RTRoOBLzt9KNIZYhTxZ3ZQmLjrCu1nruOaI8SXYarjsCa9o/lfbnemmPZ7FYlo8QxADERX200d29Ak1BIMeLDiiJL8C9Gzfv+ZwLLLlIE/Z0H0wHuya2/AZTB/AbU0D6rPMLIsmeigqT5rJBWaRtF/TpaEyD3fb9E01BnrX+qa6Ky+LjYzWnhVPF0BZ8orHESQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(426003)(5660300002)(82310400003)(107886003)(54906003)(6916009)(316002)(4326008)(70206006)(478600001)(2906002)(47076005)(33716001)(83380400001)(26005)(186003)(7636003)(70586007)(36860700001)(8936002)(82740400003)(6666004)(336012)(356005)(9686003)(16526019)(86362001)(4744005)(8676002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:47:00.6321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2847e-c6ca-4506-6e6f-08d9030750fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3354
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 09:37:11AM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> They are defined with the same value and similar meaning, let's remove
> one of them, then we can remove {WAIT,NOWAIT}.
> 
> Also change the type of 'wait' from 'int' to 'enum wait_type' to make
> it clear.
> 
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c          | 42 +++++++++++---------------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  4 +--
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  6 ++--
>  3 files changed, 22 insertions(+), 30 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
