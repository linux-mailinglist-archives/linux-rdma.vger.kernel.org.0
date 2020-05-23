Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B661DF7B9
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgEWNzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 09:55:32 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:6769
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387529AbgEWNzb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 May 2020 09:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP1vtXQreFIFCfp1TNRqBEo2MnOeeMU8qto5K7f4ftfBQRyOiMbAruvQusYCkj1ml+tYYIyMYVzn+cXzAzfmHzEL2g2u8K5sLLu3IFTmY7+wnjTJvxzNfRrUGZNxjc7kY87GJUHtcM8BN4wDJ3ALTBWnWkZtEKj6JtjIgVYIpDMYqsm2HRf/CUP993atvy4IdhAXtyf1i1zH9gXxV3DMR+2R6jYV0YqrZ0ABzkZGN1vbjb8yvkVdL5A5oLIIaWtA/BDL9wmbfAT3dpVY+T75V8f/rjOXT5GhcTjPitRLjB54PgjoATIISn9k0qyKzIXCeSTkfUDZBjS4KLcRd2LJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9dfr/dZ6JAyezGFdHMFlJHzYAXDP5v5NmcRgDK8N7U=;
 b=LfPPDrKPTWzLifnmhx3cuB1Hle6VjUKiHrhZMXangyDvmVpixHKXYZote5+ru99h0iFFRMD6Q0oAkcvfMIhBkzytuBksXwj6b394pNvLliMTxKSTk5tuz8nY141b06NJ+AyfBADMp4J/ex1F+bxAvB0S4PD6pXv66tpE/j4K5BOx3Olra39NdWVRlhgCAkMdp1vne81W2IZGu93XTTr64BGNOAKMQFJnSiO/Mq0tGNnI6DrcogmEWUo7jDYMzD5vMzjdb7z5sPGvl7rwfi4oqezVs+++V2fUZTxRuh4UPK11O3hluWS9L5zFk0JluTAUiicoD4r+H4ucZOq2WjR73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9dfr/dZ6JAyezGFdHMFlJHzYAXDP5v5NmcRgDK8N7U=;
 b=lY/ATgnu67N80rr+8HoqoexA8DrHN2ds8/4clNIuLbDjG6sKj/lKodF+HnNYXdT3SRpRBuX7Qwuk44Y+3JTrAb2FFd++93Ad3hPTFgomdYMxoY3uAl5LOm2VWQ574S5aL0OA30Mxh5F1nNcMWpzK0sgywrjjk6gmx7Uy8AYwftM=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB4904.eurprd05.prod.outlook.com (2603:10a6:20b:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sat, 23 May
 2020 13:55:27 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.027; Sat, 23 May 2020
 13:55:27 +0000
Date:   Sat, 23 May 2020 16:55:23 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH 1/4] RDMA/srp: Make the channel count configurable per
 target
Message-ID: <20200523135523.GA569407@unreal>
References: <20200522213341.16341-1-bvanassche@acm.org>
 <20200522213341.16341-2-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522213341.16341-2-bvanassche@acm.org>
X-ClientProxiedBy: AM4PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:200:42::20) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM4PR0701CA0010.eurprd07.prod.outlook.com (2603:10a6:200:42::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.9 via Frontend Transport; Sat, 23 May 2020 13:55:27 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffc91c51-e438-44ac-fd1e-08d7ff20f2b8
X-MS-TrafficTypeDiagnostic: AM6PR05MB4904:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4904899DAF873A41531945C1B0B50@AM6PR05MB4904.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-Forefront-PRVS: 0412A98A59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CovHzXaM2mkKNMPXl8X4cKGKwINszJNlw0Uvrtdxdc8kuUNt34qFqRBNn99oyyUqIt7LVoMkqT4rbveUGX4ZhD4Jvmav5MHkMHQyyB9LzySZM0qUHI087U8ROl/JRbHwTK3BrTVwMeEyu2FPO7odIdwZ8VDxFNQfQWXQfnCUh9vbc7N01acbiPdNrRei+Rd6dktdwpSwlhTHepEe+nbEDLy+D34nnTXqlUXVusgzCOdYz4Jmb0HCF8Nqt5RU4XWqUXrB9H5VxVzFkQi9lNuruLAg3KiLgpGwfVxjMEgMHMY7AKbXtqg0DMEcgOMqIukihWp9Ucz7WIWMWtXtmlF/0DHxc/tEkkbfBzF9+N0bBqZ+a7XaQecpk/lqD2GSfbAjJoftFXe25kDbXS5618CtiDgEvHZpxZYKf2Nnlx/JhCjfO15IjQSHh9h1yvMTLOuh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(346002)(376002)(136003)(366004)(396003)(186003)(16526019)(6666004)(6916009)(2906002)(8936002)(66556008)(33656002)(66946007)(66476007)(8676002)(4326008)(33716001)(478600001)(1076003)(54906003)(9686003)(6486002)(52116002)(316002)(86362001)(6496006)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EjIJSXe1SCrzg5jeT1ycYvHt/YExtELA+EOQ8FUdWcqqboIqbUgbcPLbv+0Xd1fr7VqSHLBseh0S5Hymcn8/yHivfsLACz+KNG1GxIvViER5jVB9bsJk0v8Gz7W9Kku7l0Q0FyJL+hxefpjQvpv4Ry6sY7KObsuGsgAu8jC6IxckL6j1n3g69KLABuCMBfo9905+aX3WFVBOYoHGkTrcHPrTu0hOcI1r1v7BgbjF6uL+6v0l4uRPKLJIgli6F5euBFI0qwBEWbRKvhjoapLKahLKpNCU75V6FeuBg61yT3gCR0zNzGtFo/F0ViMpt2/T3EuuwVgIrSJJmj5naJtZJd1xjOOd0gdRb53oEgIH/Wk8mHyHzKaouBKZczF0BaF9A7SkyygNOJ654AnSJaTE7Zw0FVeN+y0S2pfq43qAaP3VUvRcXuF7bVJOiJdki3ob1pHGiVt7oo/wIwSMpgq/t3ZxSRGnnkADUc/R/5XHbG8FNn9Nwv8jbndAmG1VIH+1
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc91c51-e438-44ac-fd1e-08d7ff20f2b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2020 13:55:27.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DcEboeXfHIT9+CZBvIUqyd6Y8+lQbbQx9vp761OWFGWIdIUTKjY3JwHSID5ycitDhOLEdoAqkSoGl7CgKOfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4904
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 02:33:38PM -0700, Bart Van Assche wrote:
> Increase the flexibility of the SRP initiator driver by making the channel
> count configurable per target instead of only providing a kernel module
> parameter for configuring the channel count.
>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Kamal Heib <kamalheib1@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 00b4f88b113e..d686c39710c0 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3424,6 +3424,7 @@ enum {
>  	SRP_OPT_IP_DEST		= 1 << 16,
>  	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
>  	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
> +	SRP_OPT_CH_COUNT	= 1 << 19,
>  };
>
>  static unsigned int srp_opt_mandatory[] = {
> @@ -3457,6 +3458,7 @@ static const match_table_t srp_opt_tokens = {
>  	{ SRP_OPT_IP_SRC,		"src=%s"		},
>  	{ SRP_OPT_IP_DEST,		"dest=%s"		},
>  	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
> +	{ SRP_OPT_CH_COUNT,		"ch_count=%d",		},

Why did you use %d and not %u?

Thanks
