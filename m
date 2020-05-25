Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD61E13B3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgEYRv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:51:59 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:54958
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388336AbgEYRv6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:51:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJybmeeXRk6z937VRU1TcItvhTtY79Hukhe2gzdoHaKm8luvimdyU7JCfNgTbeLfGLC/NslTQjr6Sa8y4U2/NnvVXVf8r2HgCvZvHICi96jdVQRwzBo3KyFYHpuiL8uCU1wV/Z6n4x+MYRBvNiB0TzPHITkoy6WIrDFhdX5c5H/dvVWCyXFKdN7hZF6VxlqNHdyyEz/2Oy/8osC2tolBhIEUA8qYRq1IKy5f2x+u8Z7rfq2+9i8HaXmSaSB1ROCLCKnKzLTyfpCfl1Btn5QWPKojpIcX0aDsBk0w0dH4FfA9K5surr/xovSTvMbJv39IBV75zzo2vMzzlEHLdeDjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQKY+09g87v8TYrNYQGbKPD5U9WIjQsJ97GnqHcyTwM=;
 b=I9Pk2Ii+QkoizZFoYc7p7k5hSVQFlWtbnxrx1/Ku5CQAcArQVdS0RGcQ3i/rZx39i/AxyOMAN8hMEeFQPZl7uDsMa/OEXhOZfP1qFPu2RlWP2N/M/VMnJ1pkzs8jVQe27wWmteB9USR/P5yGfEWC/1X0qA39zu4YEyRIH8lO5O/FiR/zyL2nCaonFBErGMbifJtSmbuyDtdLVyNHJBQ/duXvFVKNioKNUetjO4ViUTPVE806iOEP/YdkU0HXjQrtFjYKhiGbD4hGyzDPSdA4b6exgwUExIMIYblMCigzNvT/yD7IzOswgjF7cQXvAl8RLH4b5QTOAnxJzq+d+S4C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQKY+09g87v8TYrNYQGbKPD5U9WIjQsJ97GnqHcyTwM=;
 b=VQfxVqwcGshe2K+bBAYhImYulvJgkvGr4MhoAAltfcA5bHKshCrYancL4tAMcl9tz5IjebEAwfoEp9ciss/OQWSQN0mjay/hpD6l7yh5j39rkt1yI4WUXU2NQ82H3Ivm9heVy52XXE6EcKXLEaxby9UDeRrbTQLhSY5zhI7MXTY=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6614.eurprd05.prod.outlook.com (2603:10a6:20b:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 17:51:55 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 17:51:54 +0000
Date:   Mon, 25 May 2020 20:51:52 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH v2 4/4] RDMA/srpt: Increase max_send_sge
Message-ID: <20200525175152.GI10591@unreal>
References: <20200525172212.14413-1-bvanassche@acm.org>
 <20200525172212.14413-5-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525172212.14413-5-bvanassche@acm.org>
X-ClientProxiedBy: AM0PR02CA0082.eurprd02.prod.outlook.com
 (2603:10a6:208:154::23) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM0PR02CA0082.eurprd02.prod.outlook.com (2603:10a6:208:154::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Mon, 25 May 2020 17:51:54 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfefa32c-b467-46a6-c7af-08d800d44fe3
X-MS-TrafficTypeDiagnostic: AM6PR05MB6614:
X-Microsoft-Antispam-PRVS: <AM6PR05MB661458E5A07F10C8CE9FFA56B0B30@AM6PR05MB6614.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNvmwHjhdQNxgnWoGR/82H5l+yTA0yJXPRRtMd73GUjia4Qs1Q+8/9n+cfVu0N8JIWwCImfmRTgGqNnFjOBSeAk3RQ8qhibpFipZcYc/WOxqFLJscTPSi82pknwm5r7aFYG6egr2wFS1zloL1g7x4uBT6NzQdnQZLapLmnHqeswY1gvvL92WdWqAf0Xy5w7FIZm65q1iA3K3/nEqSESmf+EWJ5h09cYlU+2Zvht9hW1neX+za6XM/IjQW12cMF8VGhNE4oY1yvWOTGWaxeiHqgls0xC45FH4q4+qd01HYcU1illpOk4A9ZYzTouGt2ri
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(136003)(396003)(346002)(366004)(376002)(6496006)(52116002)(6486002)(5660300002)(66946007)(316002)(66476007)(478600001)(54906003)(9686003)(66556008)(8676002)(86362001)(1076003)(186003)(16526019)(33716001)(33656002)(6916009)(4326008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KrEp7GO4SVO1I2zrXWqSX8df+QFdHpSQKCivUosETb0MQcvbgS4MKDWEF4qkzqkHzIVWlcS99gJWxAOOVww0XoTFy7X9lbnbpDtTC1DwcyeHNBS+sZd96OBAKq+6WOCOehjPXrRBsJMoJ7/DGr5+Vf/ns7GESYX1Tzg9bD4xsIuRzFfO4+Q91R9Lr7uKEpsLmzVbdZuFllju8LZlYeHLulErZMIxcHUSuch7/J/qqymoqSnumXEFZcKgqrufGL7J8fg+hOmJOQFfYE2+bl6G0n4qdKGRnDEfNHNSJot7BMI6+j+QZpsZch2xpQGOrTCqAVpDvBuuKmQJvqQ+7+QR2NYQv435APxX6I8D3ZmXHJhwfTOj5HYqsastpIYT53Ye5hgPYcecObt+MDJIOfleSGPMGngFC3N5pYgIlGoR6S1NAV9AI3nb+iuWHy8xI3igXzEo5BbwaZA9CWu+uz3gZs9v8PWgW70UBvisefv8SNwmrCr/3raqFsLDrqUY3Gzo8w3w95xzf9zHlF6P6m3T1w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfefa32c-b467-46a6-c7af-08d800d44fe3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 17:51:54.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qk7il2tiGA+6w4vI0leIKb3+/BxYv2vfa6fMP2H3mr0Zjni1legwDuxBHqw9XSDqsMClOQacy7BEr5S7VhqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6614
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 10:22:12AM -0700, Bart Van Assche wrote:
> The ib_srpt driver limits max_send_sge to 16. Since that is a workaround
> for an mlx4 bug that has been fixed, increase max_send_sge. For mlx4, do
> not use the value advertised by the driver (32) since that causes QP's
> to transition to the error status.

Bart,

How are you avoiding mlx4 bug in this patch?
Isn't "attrs->max_send_sge" come from driver as is?

Thanks

>
> See also commit f95ccffc715b ("IB/mlx4: Use 4K pages for kernel QP's WQE
> buffer").
>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Kamal Heib <kamalheib1@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
>  drivers/infiniband/ulp/srpt/ib_srpt.h | 5 -----
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 1ad3cc7c553a..86e4c87e7ec2 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1816,8 +1816,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>  	 */
>  	qp_init->cap.max_send_wr = min(sq_size / 2, attrs->max_qp_wr);
>  	qp_init->cap.max_rdma_ctxs = sq_size / 2;
> -	qp_init->cap.max_send_sge = min(attrs->max_send_sge,
> -					SRPT_MAX_SG_PER_WQE);
> +	qp_init->cap.max_send_sge = attrs->max_send_sge;
>  	qp_init->cap.max_recv_sge = 1;
>  	qp_init->port_num = ch->sport->port;
>  	if (sdev->use_srq)
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
> index 2e1a69840857..f31c349d07a1 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -105,11 +105,6 @@ enum {
>  	SRP_CMD_ACA = 0x4,
>
>  	SRPT_DEF_SG_TABLESIZE = 128,
> -	/*
> -	 * An experimentally determined value that avoids that QP creation
> -	 * fails due to "swiotlb buffer is full" on systems using the swiotlb.
> -	 */
> -	SRPT_MAX_SG_PER_WQE = 16,
>
>  	MIN_SRPT_SQ_SIZE = 16,
>  	DEF_SRPT_SQ_SIZE = 4096,
