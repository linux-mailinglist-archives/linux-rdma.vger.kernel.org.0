Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DE34334B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCUPwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 11:52:40 -0400
Received: from mail-bn8nam08on2065.outbound.protection.outlook.com ([40.107.100.65]:60641
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbhCUPwN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 11:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY4vZiGdPp3AF6/Z2ZA2FBJGVSeu2vw1PwvWForBiDrB8qeVa5j9OzCjB4N0+BhJQq5zZ/1msWNfYv1Yx6Ohf0ucET6jeHOo/qGmDavp2XD8yNQUFUQKceWHqqSavANd0LJ4kNmTveyzYcRkDfYSEynJA6ebAEOQX7Lr8eeMH3Ckde+iEMvOCvopKHEJHb0Sb5OIInRccchEgW0xWsLd7CJOTBy81F8ivwQKRj0C9hYu7IOcMAjWAvv6lMO7yd7YHnowZPLpnf6htoi126V11JZbdRzQpXUrRyF3QUliDrg1gheH72pU7mwi3xWyli8jtE8K1rNQJKzlt47OKqhJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHRAOXD0Rm8+U4gRbwL2azxk6n+/J9cNla+Qjb6H880=;
 b=UVeE0OmgBkkb0qa57G9IWP7vWddXU5O7PPvrR2QXUYZF1oaY69SnXRpuX/w9Bt+95AH9qyLw7jXSoBif1/z6QhXZhcgrwTf6et3cZO11NuoGmTl4V3empzQNIcN3r6Fxs4UF0erRvO/3WILkD8aMx2FAacD7e+yVfoYAjKIxJ8cgk0633ADHz0LvgFqD4/XryAOcftw81s6W73gbegAkYTx8UjSA2kC2nD75g6aa+CnRzNokwlSWnR8nC+o64M3TWMLKgBoTMa4qSOwUGBnjnGY8tN+VwAsfFOS27wbv7m7+T+SS5X+ilWyZWCrOLEAZrRseh8GQdGXa0t/jzfI4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHRAOXD0Rm8+U4gRbwL2azxk6n+/J9cNla+Qjb6H880=;
 b=VE0yLSU/RpiNz7P65dgCKUB8X2j+HTd4J9S6xYsa8s3/9zsPjajjsrhsezQ7UE+XGaXn2d1j//2Bi2iVYwPyNXsEmuI6PqgSrbRIVTjAHAkwVYLIKPnS9Wkj2jv483KpHtoaK5dsNYeBu8vhgmjgQrR0B03KcpbTXFwiYqRE4ldg9NYH9nb3OHdbrYGAhII6WbT3p+NqrX3i0c4czVicD6SXX5XFg8HP3OKkau6ykB60R0C6JzrIAH0Jczvrp2Em0ZNKrGOp4IZUzdqOlo0DBp0SHjmhmlKtEIU9vW3wAjhgdx/hAfYNskg0ZKsJOyBxUBM1wPtMK6GpIMhXrOrkBQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 15:52:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 15:52:09 +0000
Date:   Sun, 21 Mar 2021 12:52:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210321155207.GR2356281@nvidia.com>
References: <20210319130059.GQ2356281@nvidia.com>
 <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com>
 <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com>
 <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
 <20210321120725.GK2356281@nvidia.com>
 <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
 <20210321130315.GN2356281@nvidia.com>
 <CAD=hENeekUYEGZszMGs5bOHZ9fb4sahkv5Jy4QW1kWzUBLfYSQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeekUYEGZszMGs5bOHZ9fb4sahkv5Jy4QW1kWzUBLfYSQ@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 15:52:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lO0N5-000arI-Hy; Sun, 21 Mar 2021 12:52:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6023efe-422a-41c0-8417-08d8ec81488d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3740F39F3287278DDEA50CF8C2669@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGPD8jg99z+IZ3+Hy//qeR6OINU3I3Q8pl0rjFAk8ld3oVu9PGlVgfnpAlf+H1dKgIb2PoUbr5S8GhOfdVaWAAsPac05QYAsd3ORrYuLgYtD20m8i+1yN/P4vgqCpuFEb4yMdYxt/kkPQVOsTxc1mwmSJyJG3RSnFwXMBD/9howPL2NFxSzfKF0LHeFf5kLdnafMJtx875ToJnDyq1o7Z4B/nd09OyYtY5mWGFvfYf0WI7WwWbz0aQDteZreS/SGiOxY67dJkR+PQfFL+wY41D/C7q4AGhS/DKaACnDwvhkfdd+1tkvo9edTFXfvxxxq0RVCDJ9dGCmhxh0iBcSHgXNw4UVeyKQ89oz17xIQdP+n4iHjD4w2FJS0TEJOlN0SWi6BpCdsP2WgvXpB5CjwvVXJBj8KG1Fmd+Ajjw2ZHKrEkN09XRZ58an/DGDacaUYREgyMOgix6nCz6Xz/Cz4G+e0oFui7DQBY13Yge4Uv88kn42XmInfpKfVQ4sj/W8QZGhDWK9luXiAzkzo1EdCqBnh9hKLTx3ygIh6pxQyuhcGAsyFZZYov7Xr1dZvE23yY0EzsM1Wk8/xofVsX7RnzgBtqlqJVnLZonPN3zrblLEJGgKqw4ljOmbOLhbWRrutc9JaTynOf5VKwLx5NYejtzYuFGcD22+4gLY48pnAk5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(66556008)(107886003)(66946007)(38100700001)(8936002)(9786002)(9746002)(5660300002)(2906002)(4744005)(478600001)(33656002)(66476007)(4326008)(8676002)(54906003)(36756003)(26005)(1076003)(2616005)(426003)(186003)(316002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vnCfmXHkFAqcwK3eSFiNW3/YabKt3KH/2yitS/zvXnXkMp+dka4P1mPuItWx?=
 =?us-ascii?Q?H+dpZ3akhR17Iv+QmffgrBZbMamqXe3ZIWdRZ7/1JIbSYqNC9eY9xaZAf1sj?=
 =?us-ascii?Q?r2LDFvMVkVJi7UZt4MVXGME2FvP3nQV6vEBFiG8ClJFxIKkGEtNgt1p/SSE4?=
 =?us-ascii?Q?DsNxvDtl1aevtx0hITOhYW3A20n+J5gel3WaT6odOkNEnED90z17M2EFU6Ji?=
 =?us-ascii?Q?74KqesAKF0v1bbAUDoXiCuR3+3PHYwXU5xY3QJG/GiBRAVY52S6qt9+xC8wJ?=
 =?us-ascii?Q?WuxhrAJe12QBD9agz6f51bYmtSd8As7JVpI83Zt9hkKgmu8bjgsnteMaMzXa?=
 =?us-ascii?Q?d8gANpCZuyY1NsGhiNcZq3O+8kaMcnOrZoMGYwiwWqWjYl13FLy7y5UwJOHB?=
 =?us-ascii?Q?1LP/bwwnsjXD7dSUpKrfo3R1cRsPu1FK2VcAp3dvfTodjj5iy65miDDC0uUZ?=
 =?us-ascii?Q?prNhaPHE2uxFqFZoi6SHC3BxeTXB0cfyqGdEP7TrLvSe3Fk+yu70lTlOBEFJ?=
 =?us-ascii?Q?OQAALmiM7j+AEmf6WEOIjPe/NKRqsuPa+TMgUJIYAKOG4Yg1WYfbbtBFHBOK?=
 =?us-ascii?Q?m7fhgRTex6AUfbTXLUfo31DcmIFYyU39jBZhfG4EvAZGM+mgV5BK50OOvURt?=
 =?us-ascii?Q?1UR+ukhZ2GwpqRpC37li52LA2B23AntkQwlSGrtzWEyGuA8QHUdenYqnE2ZD?=
 =?us-ascii?Q?vq3EKcxXssrwnLjcdjD//JnqAAN3LORH0I+VG1g6dGYGCO++Jw2fDweo1dQx?=
 =?us-ascii?Q?X+L+x4UEBdxfgB6llbb7/GZTklvxDKRpiAzGKDT9p6H8nuXzOjapdyF2nnEn?=
 =?us-ascii?Q?onaMsysMxQ5qzHOjIWsv8yYu+9GXDS6N2ck6yEf3hDk759CtFdN49sZ8m5KV?=
 =?us-ascii?Q?7s8Gbr/HlwPT3yep259al5nhS3azmMqhkTVw4yRHC6Ny84jo8btazTyNmFLS?=
 =?us-ascii?Q?E4utaZmxO1uZMUszIglxyoj8c9JtDHML3FbwBXub6Iw6ON4TVyLZvf/lmasE?=
 =?us-ascii?Q?1TuP8RrPjOVpLda53vv6s1nrpyRTYMzHhRszrMHcMFFe5KQjsfl4veoiiVY5?=
 =?us-ascii?Q?hR9o/2N4FE2CotWr+YSQZ/Tmkws2RvFfQ/xDmtQ/i9jw1AZ31UfUoNXfYazT?=
 =?us-ascii?Q?MhJADOT8m3mAxJlxK1V8erXDcHrsbTdnIGGB4J7XIcTMRME09NLNc1DGzZ9/?=
 =?us-ascii?Q?LnCVsJRrFQhnAYuYd2MQEEK5l8Q+jVnH3l/kSjcI8CR9sqVjQJQkEa6ix9x/?=
 =?us-ascii?Q?ZwAOL3HbRtVPCs9Q+E6Z/VANO0RnFx1biMG5VUxzjBfRX8ByeMoJdL3tUB1l?=
 =?us-ascii?Q?WuKtCPNe1ApR6GQbJcDIv2M0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6023efe-422a-41c0-8417-08d8ec81488d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 15:52:09.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TdcK7KrX4QaMxgRV80U2errjQyRjx1zSXN0lKYxjqgDJIcifKgwjgcLMTsHJzdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 10:38:45PM +0800, Zhu Yanjun wrote:

> No. You suppose n_pages is very big, then prv->length will increase to
> reach max_segment.
> If n_pages is very small, for example, we suppose n_pages is 1, then
> prv->length will
> not reach max_segment.
> 
> In fact, in my test case, n_pages is very small.

n_pages is an *input* it is the number of pages in the VA range, if it
is very small it is not a problem with this algorithm

Jason
