Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2230363CF0
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhDSHr4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:47:56 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:65217
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237962AbhDSHr4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 03:47:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMLDlAmywU6Z/+fCkl7mHJLmeVM3nyYPqWmWjiasLIJVc8RKuBRNOxFG9dQ/BglTfw6OmXlPNE6lMdYCJW2lBfCq696bK81uLTwZDE6Ps07K2G25Vr9URJLF0nN7P+QyBWuH/JiRCa8JlkF+faMg/GNLoG7aDd5BOW67Y24t46RJ2U7Uv4V4I3VlwQhfMAb5jpHJ0euVoeXa6OQCpBc0soulEtUfcXz9QYM9hI1YPl0i11ympwVsnqCgq84N+z+z7zm0WHDmLYgOgqSFhR45A6iEY3D3xCOoDuJksLjIOAjTja5v0ApW1zqiqlVr+3dTraHFgSUZEmWWfiLZV0/1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jI1q2BKydazUF/Bs4QTWjfxJEWWw7x6g+oBxBy+Ct8=;
 b=EVhBoGuiCcOxkLCwhZ1n4fa3M4YZhDi3ACBgyjwt26bqNg/jp7WgNbDr+osqvxrgWL7nAD7D4dT3afeaBx++Tpbx49bBn9GPB67yWrcAKP4lc5AuCDXUR6eB9A9hSEX3gwGmj4MiKdEDRWxI5QDsLy/xZsNTQD9z9W38mWbWOR2rxZr9RDMrDNvDDy2Gu0fcraG5Asx4fF36A5aLR+EQNe5GBsG8fT/FC6ftq3CLM5zubeKywB4lHv+0SSzBRvNYiafob5BbyDCehfZaPzz5IZd9/WdF+nIwdAYzaogZD2GuXS5XmSfGY1pEWgTTIS6Ft6KN/t7xjrdewB7DI6x3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ionos.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jI1q2BKydazUF/Bs4QTWjfxJEWWw7x6g+oBxBy+Ct8=;
 b=Gx+l6PLJzKUYSQfSbxwlIjmCAW61dMHyiTDaT5MNaleXyOO0ijzhcA5xkqY5jU8xhvuMe2LpTcs57VkfclfLZWojBd4/mHJrUYpVLYbh3TEnmGWT+yZ/0hvXMBL4Um1esJCUus004c9mvygVknIyb8AxfUQOKI7Ob2xFf7KS4VHSX/tk/tlAZ6yjXVSU43PUU/7V+RBoPLYRW1bP6ZdVrkk6A+aTfislgVk+5HF4szfHULw5F6IQvTGlL/pGEm8xi6kvBbnkfT4DsiLoLrDJJuBSVPvtuPtdG8Kr9KJgVrt65PpvRTNEQ6NJRF2Go7ABFIf9YPkxJ+f0Hmg+bkWAEg==
Received: from BN6PR22CA0032.namprd22.prod.outlook.com (2603:10b6:404:37::18)
 by MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 19 Apr
 2021 07:47:24 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::23) by BN6PR22CA0032.outlook.office365.com
 (2603:10b6:404:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:47:23 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:47:22 +0000
Date:   Mon, 19 Apr 2021 10:47:18 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <axboe@kernel.dk>, <akinobu.mita@gmail.com>, <corbet@lwn.net>,
        <hch@infradead.org>, <sagi@grimberg.me>, <bvanassche@acm.org>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCHv5 for-next 17/19] block/rnbd-clt: Remove max_segment_size
Message-ID: <YH01hqzqq0tLPP3w@unreal>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
 <20210419073722.15351-18-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419073722.15351-18-gi-oh.kim@ionos.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9374bf28-c114-48b7-709a-08d903075ed6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3407FE615B0ED959E008DC31BD499@MN2PR12MB3407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4F8MhxS/5jKjIeX1L+GLKKhtdkmSA9oM6FxZ658hWBoIqDncv0bLuJublsC+wnyjFjP+k1a1Bu2um7HpiVl1kSzCma8/+tsqIC8ockRzAbKqyOBHKvLhYWFw62a7Qc3TLK/dfc6ymmgJciiNHpDRJQfqKgRl0XdnOmqu5Z/5noCxHfimbnI/EGw/0Z7wIo4779LDmgwU9zpKq+LkhTM9PWg9Y7Bm22M1KNUNChq1h1GRuLijZFHVUBga4zRjlDsCA4/vP4sv/3cmMJZkUVPxS5/PJcf1BP5I1lEf5Fy3JZxjANRGvhGc6LS4pkk77v4KzHuvD98dPJhDpDHvm9hN+T54XyL5+EDY3zpl/DZgErqxFeoCAcU3UNcjbQZTw5vgCq8EgsHABLmR6fOMV1NdiiN3wHA4SF2WRt6EJUH8Bq5j5pEl8BVXAtKSAICeREwlMM6RitBuACTy91Q1Gw6dA+2SkD8dvS2+w7/NWfARb1nMXDsdufLxJXgkxjXG4ceq7+T6neti9tQITTnkECn2PhVr5GAzpLIQRjq0npb2FRZhEqCCjifRyTOaf4CaZsmd9dkxoOIXHN693Gb5vN7zMao7INPsoC3YHtX2XLVaLda3mSINnrBo0aFT+QELg/hHmcFo/dx4zmRZI+iAaMmsYQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(6916009)(5660300002)(4744005)(478600001)(26005)(16526019)(54906003)(186003)(107886003)(82740400003)(70206006)(36860700001)(4326008)(86362001)(9686003)(70586007)(83380400001)(426003)(82310400003)(8676002)(356005)(316002)(2906002)(336012)(8936002)(7636003)(47076005)(33716001)(7416002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:47:23.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9374bf28-c114-48b7-709a-08d903075ed6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3407
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 09:37:20AM +0200, Gioh Kim wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> We always map with SZ_4K, so do not need max_segment_size.
> 
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c          |  1 -
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  1 -
>  4 files changed, 5 insertions(+), 13 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
