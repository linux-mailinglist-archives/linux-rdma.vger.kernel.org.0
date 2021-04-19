Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3F363CEB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbhDSHrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 03:47:45 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:11265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237895AbhDSHrn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 03:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv/BtlhMdA7YNDgoCTyx5RAGVccZ9l9HdceAQUT8wUtZ+O58WPO4flAoAk1aypGvec0vSVNHmulqo5PNTAiL+95OLa2m5z7x5JHEsRYiWOKtXxeCE7D8Vn+ASfoa1mlp7aRVUf0fE2d1RvkKTU9/+eKQ7oCmy8nzVGO4QTpSSiusz5gFH8Y9rdx7reHobPQiz+uIuq63v3pggNf6FArXET3lkAJQwOtTD/dxxZbD5k9VZyl9EASY6oy6STZMBgd4p2XrTnUuiE8QU1upQSZKxfGTnHiGftURr/66WyQI9JmjL5aZyxDQGPQmMG4myZKQrRxtGnkuPkRAYXdH1nPvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytEYqxSezZfbdulepRh9QZK8mzcMsRSLxWYlbmv96Q0=;
 b=G1r+VuGmRvWCLiq6ZGCaZtkgr/fREEqR6Ox5hBoNwFgoLcBEjUbNaTAZKjygdgzyhBgGr5yrG+WlWLlni8SmaVVdzLHoJGAU8WGdaForUvEep3KlrMGzxUgkOq5cJrkAaafLf0X6kKr7M+sAVJN8SG4YnUr4HvklF/O/7LvDSq0N/bPMm26i/40yBwuiWMIic9y16f6PshHzhX+2lQHcqlrXbxl3zn7h7z2j64dKU9GxPkpD8ehnfj1vcnycEgmEU6twQ/rVJAPFjtT0fo5hnCkC7MG+NNdXdkt5EPqtAsIjYhb06DWvg9jqNzxatwZ9HBWIjDIaHBl9BrMFtNd0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=ionos.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytEYqxSezZfbdulepRh9QZK8mzcMsRSLxWYlbmv96Q0=;
 b=tmeBUUsFy5CIf127Nno0mUI7v/CNynCZ+xrzZSxyI06PV9injP4BCMJkCBT12cbeEnqcSTWlMvSQMDaDu6SogwDo1HLwdWXul818I6wDKicPc8tJrr/QlHz1tSJQk5bi2ITUQE2loaf1/ApOvfBpX90LV/sY1vaqd2zxswMhvoaxkehI0a2TCRadZh9pGsJI2LI/tsE3Ph6AmgE6Tn8cW61dNI8KTkUenVe2NWpNR8KuP4CTDAzeXG9fXGuj5ZoL+4k+PkH7DYsyHEV0tafKec3JUnhBet7e8h/0K3QZzVnaZ97MHXgZc1HOfa7mwulXywv83IFmyCiyRXdslk98Nw==
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:47:13 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::d1) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.17 via Frontend
 Transport; Mon, 19 Apr 2021 07:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:47:12 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:47:11 +0000
Date:   Mon, 19 Apr 2021 10:47:08 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <axboe@kernel.dk>, <akinobu.mita@gmail.com>, <corbet@lwn.net>,
        <hch@infradead.org>, <sagi@grimberg.me>, <bvanassche@acm.org>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCHv5 for-next 13/19] block/rnbd-clt: Support polling mode
 for IO latency optimization
Message-ID: <YH01fC8w0ky36Tz1@unreal>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
 <20210419073722.15351-14-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419073722.15351-14-gi-oh.kim@ionos.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d155866-8a72-434e-75a0-08d90307582a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33671BF9AFAC45716EEE0C4EBD499@BYAPR12MB3367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgS63MT24kndeTBz1b25qfTkwnmdhTlm65gUz84iFoFGPbBElY4YLaD8/pVi+QzUMWlJLD1rM2rhkr9sIUDbDcJsHPykRftvi+JNeuqn0bqptZeIMIDxebpaQ/wp3gEVd/22puIX7e7UM6enY97jxV01DDjz6m/LhxX0trSKwRxJzTS/jU4SIEiYC7s891UtjWMJ4CwkMTn3aZbn2T7QHEMCFmoYo1txjfvf1r2ROjixIuPWujCqaOYJPoa/zKcMMRCDyh4Wu4wpgD1TyNKo49QRv7arDZJTir6KfSc3qL27mqpWZ6fOhPKAcOaWnxmRO3RcQuVWqz4LT7dW8tgFPw+E1uZFsH7YKA8+Z+GN+YOWcxh8J2RRJssuDe+lTgxKeOHW8Lrqo6nttFxHRvYdGa8evfxwRB5t4qTw00xvs7u4d/V7anDGqrwOv5hJLD/ge5KxHURKbXwEEbsEOsNamEc3+scj/OYIetzTDUv80IUmqOZZOHVSR9QF/6dugGOyELpVtiwnbhIZfi5V4faNhic8jn9/HWE/zMi4PDnBKkFwxOXi1C2Ods2MbE+egH/Dpp0JXmx7lv36olzysB0EXYwTkWnE+GJdm5Lb850fYZ5GUtUmKsy/6/g6HNzqEC5YMr/UZxs9MI3ULmm8EX2R2A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(336012)(36860700001)(26005)(82310400003)(4326008)(478600001)(186003)(54906003)(36906005)(8676002)(8936002)(16526019)(47076005)(86362001)(6666004)(316002)(426003)(70206006)(9686003)(107886003)(5660300002)(83380400001)(6916009)(7416002)(2906002)(82740400003)(356005)(7636003)(33716001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:47:12.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d155866-8a72-434e-75a0-08d90307582a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 09:37:16AM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> RNBD can make double-queues for irq-mode and poll-mode.
> For example, on 4-CPU system 8 request-queues are created,
> 4 for irq-mode and 4 for poll-mode.
> If the IO has HIPRI flag, the block-layer will call .poll function
> of RNBD. Then IO is sent to the poll-mode queue.
> Add optional nr_poll_queues argument for map_devices interface.
> 
> To support polling of RNBD, RTRS client creates connections
> for both of irq-mode and direct-poll-mode.
> 
> For example, on 4-CPU system it could've create 5 connections:
> con[0] => user message (softirq cq)
> con[1:4] => softirq cq
> 
> After this patch, it can create 9 connections:
> con[0] => user message (softirq cq)
> con[1:4] => softirq cq
> con[5:8] => DIRECT-POLL cq
> 
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c    | 55 ++++++++++++----
>  drivers/block/rnbd/rnbd-clt.c          | 89 +++++++++++++++++++++++---
>  drivers/block/rnbd/rnbd-clt.h          |  5 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 62 ++++++++++++++----
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
>  6 files changed, 181 insertions(+), 34 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
