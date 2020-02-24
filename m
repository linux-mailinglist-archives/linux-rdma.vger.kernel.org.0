Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20C216A790
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBXNsf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 08:48:35 -0500
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:8065
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbgBXNsf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 08:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaKZ3N3kV2AY/5Xv/83wlO7kyiwvdyww/Zl/+WekvzLpH9aFt4H4xJqBnOd3xRxuN67FVut8ObYiKfU1nhJE3WRaNfwK4EATi+gPpZHc4wCevetyTjCBsEnRgmtMPFSNbRm+YXMAeAXQpLhCQSa9fw/z850mSztu2hqfVCmyr8jPY0uGfX35A0xWwX3PJ17bn4qc8kTZFTfCghHzt61ay7tRdS04bDzun9gVnsPl0kdIR83Jd1iIkbfJzNkpeP2HlUWXUctyuWD2kKSoxopzO8SDNhmBat6vojLT4CkJeiFsWiftzO9Kkn2VleXnij8DcHoeO7yQX8pvZcHkdZWPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOwNKM84sF5/kaRl2nsGcij5NQJG8IQxThvhfDx8Hbo=;
 b=Svl+DfI7ULxAyWQjLdvCLrRNRM1VZaAcJkGJod5yOd8oQZYOGBcIhXkj9WQX9duktVUIf0vKQNmKzphgqvmR5x5ZZoNZF0LCTeB0MUKDYY6TCHdZ2ABnBOKDia+CheW0EphAd1vlEJGCUbDlLnjEb69s2c80Ic5qC7h7OXY6+KGjDoy4oOspNpsc4Rs+8AWzRM0tg811N+TSZydHSgKRUM1L2pgEqGV1Wi9kV6MeYR0IFvDXgLp0T6dJeVn3DJOdnj5Rc2sCuLow5RKNL8NjW7/tov7gIDflJfNmfvGjfp+8d9YnFtvqoGQJipXbOBLJT+agUnSvxyDJlnCWpfwldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOwNKM84sF5/kaRl2nsGcij5NQJG8IQxThvhfDx8Hbo=;
 b=UqZZbhYNOLWPbumQDKgR7gQ+cjW31385g7VjWFk8pRAGdD/DsnuVrkAyXkbWWd1WZa+Ij5/bYZK3+IE55Cr2UExWWM1jfwxe0964tl4Mw/p3DgsLX+admxH+PQi7SPrP+w+4BlZD60SdfPRg1hymfAaFRhxUFmJSbA2kI58R3hM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3263.eurprd05.prod.outlook.com (10.170.238.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 13:48:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 13:48:32 +0000
Date:   Mon, 24 Feb 2020 09:48:28 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 1/3] RDMA/bnxt_re: Add more flags in device
 init and uninit path
Message-ID: <20200224134828.GI26318@mellanox.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
 <1582541395-19409-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582541395-19409-2-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 13:48:32 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j6E60-0002kU-KK; Mon, 24 Feb 2020 09:48:28 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15409261-bcce-4d66-d467-08d7b9303c95
X-MS-TrafficTypeDiagnostic: VI1PR05MB3263:
X-Microsoft-Antispam-PRVS: <VI1PR05MB32630E15109FB7EC3D598202CFEC0@VI1PR05MB3263.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(189003)(199004)(81156014)(2616005)(8676002)(5660300002)(33656002)(81166006)(86362001)(4326008)(478600001)(8936002)(316002)(6916009)(52116002)(26005)(2906002)(66476007)(66946007)(66556008)(9746002)(1076003)(9786002)(186003)(36756003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3263;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaEZkVLh6xlfD5D60SqmGItEjESE2Ms+euo/fN4pwCwQm8z8kCoIrsnqgCLStxV22a6rjgU61QGLHUfTVyTQ17gS20G1qpf0kRr0T+xargA+2dpqyHBEnPcdVFym++V9TwJyMHOT7OY8H8B+gRC/MvjTkn2iF7dskOY488txwZJt0YUahZQAr3tXAsErHqsRpaKiRzhtXGSN7koftzKuv83XvxhtfL41pTfUKxld0AcqASsnJqSLFX1ASKnlsBpANfAdxwWcJVptxR5VLRCkrAU5B5P3bJ7JYYJoTBElblWGXRoiA1ge6mwkvJFYhvgaiLGysuF00GCiEXfZlBoPS8J8TdF0KrF6ofqAroiGnvadV19FMEk3VP4DxHkWgQyJVYPyYcwzN6sRQYvanvFR8M5wAuq0rPJ06EUaWxNWaQ+K7GjBbDkm8UyQhR83lyCrcXtVZNi9y/nKOCcGU66dXrDpmxTHrG2XiT3ZqEEfia7cTv5dRraztMEB3tZ7VOO+
X-MS-Exchange-AntiSpam-MessageData: hJPINTdu07XKRDtoeqG+x0LwCkXQXsZ84cR9u/GkKhPiIKbOEzlrhlTeyIYYdPWt1MxCnS5qxebL4efTbim0U0szyIsTgpjieaYNTrhvWpwh6GCeg/8tuKK6DQoUQtdKPJ0eWTwpJH6hh+QS5fI6Sw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15409261-bcce-4d66-d467-08d7b9303c95
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 13:48:32.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw3UX5oSqI+lS97jEfUBUEHlssFDfHF0hvjIus1LVHwOFfk1sHu/3SqcpPHXJ/A1TVpHhp3gwi6kA08Gc6tU0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3263
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 02:49:53AM -0800, Selvin Xavier wrote:
> Add more flags for better granularity in in device init/uninit path
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h | 16 +++++++++----
>  drivers/infiniband/hw/bnxt_re/main.c    | 41 ++++++++++++++++-----------------
>  2 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index c736e82..0babc66 100644
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -135,11 +135,17 @@ struct bnxt_re_dev {
>  #define BNXT_RE_FLAG_IBDEV_REGISTERED		1
>  #define BNXT_RE_FLAG_GOT_MSIX			2
>  #define BNXT_RE_FLAG_HAVE_L2_REF		3
> -#define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
> -#define BNXT_RE_FLAG_QOS_WORK_REG		5
> -#define BNXT_RE_FLAG_RESOURCES_ALLOCATED	7
> -#define BNXT_RE_FLAG_RESOURCES_INITIALIZED	8
> -#define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
> +#define BNXT_RE_FLAG_ALLOC_RCFW			4
> +#define BNXT_RE_FLAG_NET_RING_ALLOC		5
> +#define BNXT_RE_FLAG_RCFW_CHANNEL_EN		6
> +#define BNXT_RE_FLAG_ALLOC_CTX			7
> +#define BNXT_RE_FLAG_STATS_CTX_ALLOC		8
> +#define BNXT_RE_FLAG_STATS_CTX2_ALLOC		9
> +#define BNXT_RE_FLAG_RCFW_CHANNEL_INIT		10
> +#define BNXT_RE_FLAG_QOS_WORK_REG		11
> +#define BNXT_RE_FLAG_RESOURCES_ALLOCATED	12
> +#define BNXT_RE_FLAG_RESOURCES_INITIALIZED	13
> +#define BNXT_RE_FLAG_ISSUE_ROCE_STATS		29

The error unwind is better than adding these endless flags.

It is hard to understand the flow with all this needless conditional,
really if you want to change this I'd delete the test_bit scheme and
stick to the normal goto error unwind.

Jason
