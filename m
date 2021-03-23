Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E663E3453C9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCWAWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 20:22:06 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:64480
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhCWAVk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 20:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTYdWE2xD9XJvIM446TaCNv/oJf1PXhNQ9s+3R8BgqCsbRcEXahNKX25yAuheD6zCUnwE9S/q89AxFLdbNeXJkQr1J+s3kSfeTWrOP8ePebIr1CUB+QeX9QBKizngvjpSSdoc7fnH0LSaFqxNNIzHfIqC/z+RPtpDJUablLZ30ygU7f/9em192GMTCcRbKQ2Dqc4q8edtSVNpnoA+5HSptM1Fqx0uPIa9VH2RMqKrSbsTlGyh9pqaJVe+tzWBpU8zsKb/YKrouMKd0sFnQbSdKxzxu4YvtOE7ihRdRlF3/eNqOjpTeOqXzf6ADz5+1It5wEg3mGQIMsp868hHIS7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5EJ3vY6ui7QQlfQ+/r79M+DkJ+VCv6kAsKZkBx+vHc=;
 b=Ln8kEarhIsz1my/m04FGUWPD7ju5VTO1dX0I/380ZcOUm1hJG8JFzxEnnLHjrSUsqfQPiOC/mHlqouqN2lLHaSAQwhq1BjTHouiE5jd9zOtPDuDEpv1UzBmjJz2Gy7j9pTB6W7fxJZN+axUsvLVyMocx1CQVN8LzVfRRtZ7KE5+qAM3smsTP0erNzvAhPrs/JDUgXxoDvh1A5uS9WHNLPuEbDv5PD/fzpqUO7g4VstQJHRsKDDMvP1gL7f/GNi8VZk34hqzNdYfcN/Rllyvmod4PTqXbp0ltoKXIYQwmJ30YkuG9n3GsUMIeRxJCvLK9MAbUMAGoMIDQqQERSOTwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5EJ3vY6ui7QQlfQ+/r79M+DkJ+VCv6kAsKZkBx+vHc=;
 b=VANb94XMQlLN2lV43zDo1XKSLWxqZMN4hhf3qV62CTIV5YQkOUXiaI5+7bsNflvJr4w4JEa5mXLamAUni+jE+xED3oucKTlxKe+eFUWYTj2+BBaLTp0SpWmPrFIC5vItR4Wv8ajmWTZ0fuqno8XjfEhzekZ6cx4CELgY2OSB+qRPDlSTOqEMcs9a6pXL8EEoG30qkoIARxlmNbgfNhXMdrICGY/zpX8bUeOLuS5iWZieisG/yDJfsAkSP+bIwviaaWTVmdY83223OEUUNMNGY3hrbp5Jl7XPz2br2MVrO35PBbK1rEK//n+4jTLdsZKvr8lr8WFCSx8xP9/CqvpnGg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:21:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:21:38 +0000
Date:   Mon, 22 Mar 2021 21:21:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
Message-ID: <20210323002135.GZ2356281@nvidia.com>
References: <20210316132416.83578-1-galpress@amazon.com>
 <20210322130131.GC247894@nvidia.com>
 <fd35f82a-abd8-ff53-d8d2-0e401ec92ea0@amazon.com>
 <20210322165546.GX2356281@nvidia.com>
 <382540a1-248f-878f-0e1a-4caaa6839a6a@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382540a1-248f-878f-0e1a-4caaa6839a6a@amazon.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 00:21:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOUnf-001H2Q-AL; Mon, 22 Mar 2021 21:21:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb335017-a267-4d1c-073c-08d8ed919f34
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB293982B230EA3690EC9F6208C2649@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4EDUt0CDRIlIh2FvMEVsX2Gq02Q9KoISvnmU+Uyi2Gezj9sVqiSIVx/kh3l51CBihIzsIFJe1uqYtUyU6PmemlKl94jaE6VcbLpM55UxLfmplKuz8LqbT234Z8Z0Nrdrxjdv71glleJmDpC3VVvsZDZoGnLzHhip1BEascq8+qox1exyQupQcn9jmVNrG8L+8GrbNR7mJ5r6IoVFUrX8oBvBDApXFe9QYOiJ7OduApAUPMEl7iI6IeSm97wIFWx704z+K75IMhfknxn7x9LMdWmLyqENCQ6DZeghKHrQW4IYdP2UqK3ma0fFpx9tCaqhwBl7tG5kDtOUdqwdOg9MYULHLobzJMWQBViK/KJkFEGE+AoKdc9V27SkGem6D9Z2xzELyj3qs8ZjvqIZ/crY4u6OyBRFvjENfRVLZZS9+IQJ9ZR3+9hWryEIi7qs0hcR0LRjB3XuJJkBxCNxvpJgtNLK6LbUkFF9fy21440OFFQZ2RUnv8aFaCwYDEdfR+I0rAYs08/WMifjdkgk017QXFu7VshmsoC9u8f1hZAWlkuORUCAPYfEjBqUsRAqESjhfQre6t7lNTpAKqFYFW4Y0w316tbgV94ih7TMdJOD+XuLFt4D8W86Uxf2UE94VsDOFUHxUbHVvzi8RkYTHZulBe4sDd7whwvpduUJvkHdDu1Rcp0qKjK1C1cjwRKc1pMKX6TLvO7lhhLM+jhoCzj0rdX4ND2ZIaLI33Qa5ugXM9NPtO+gehskVp5RVdf8RcHjkN3yANGbvzXUe+6dXpleA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(8936002)(478600001)(426003)(2616005)(86362001)(186003)(8676002)(966005)(26005)(54906003)(33656002)(316002)(2906002)(9786002)(9746002)(53546011)(66476007)(66556008)(83380400001)(4326008)(1076003)(36756003)(38100700001)(5660300002)(6916009)(66946007)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?havbjPXeK6woey85f2w1exkz1SS0V9STMxij2iRt4/GuJXNUkNRFeVOhjoxC?=
 =?us-ascii?Q?Q45ppetwXpukhEK6CWz1d9RyiOvCkOfuCTCQYChBKDh8IljaPXXqfPHJaKqT?=
 =?us-ascii?Q?+gLRBIojkLsSG+gTQzMT/ucfktzhFW1LmgvzKzfTZ3oJivhRmu7THrNPoB4a?=
 =?us-ascii?Q?6DAXnlLvzNewxCsY0fMWjnT8SjN6iACgm1MpcJJtQb/8dVAynP375odN6bqA?=
 =?us-ascii?Q?7K11k49pipmKFHqGJNrsdImPgmBwJrJuo+YqRzk60WVT2FpKt5x6MfLlUVWV?=
 =?us-ascii?Q?iG+4mmoPkHfQ0DWPYtIe6laIh+h9Q3dIv+NNpWtr5xgFqVi4ckCABMM/AfA2?=
 =?us-ascii?Q?oeDgP65IwC482B7z6FZwKhLwlacGzJn71xO31CRaO+CGoXEPSNirMsDaGfes?=
 =?us-ascii?Q?VdncMBixF9hkdPVW1p2HjMXryq0BzCudHxNWh6N3BplZErRvgaAkus1u/8tr?=
 =?us-ascii?Q?38kSM24ZybcT619+S6hVZSK1fP6ZxWwNG6L8LYeHyJytFO8y2X0bu7zUd6/x?=
 =?us-ascii?Q?hBefnyktfMGB1OaRrB39JvDF6W4fpWjWRbTSyHe7eohNCHzGmgwoTmYy75wR?=
 =?us-ascii?Q?RLpecFj+MaaCFm3VBh7/rq1P62nUVS0YRSr9RGfpaXi2u4NmKe3dHLuVuRJ7?=
 =?us-ascii?Q?/aq1PkmqiLrS/5TkvAX/U0MQEXqljukxUjZbqhCvzgchYqZ9WO46sNVLAXBe?=
 =?us-ascii?Q?m/r/rI+eIeOD8rAJODQlj3l3j/Qpiz5QXfihE1tK3DFus2Q/cCWyAAlJ6uaN?=
 =?us-ascii?Q?9wS9I+xwTvkaDgyA9QPTsK4O30r6aTliXCk1eyEruGfB2PeBOUGYVv83gPhG?=
 =?us-ascii?Q?Wm4oLol+VByTBFRKNUb3UAouyw7tbWz35VE5ltgdqkyhOL2qDZkPlUlKjlam?=
 =?us-ascii?Q?V7yA4qfycwgUi1plUSbK+vNtkYMfZ5Gq7kLu/eBNN4h7fI8gofXZrmgofyoy?=
 =?us-ascii?Q?5YASJSNmZcobsfx4JBV137HWxj/Kk6w7v+QMmWa5Jajh0ZCuTghVnxtpy8ti?=
 =?us-ascii?Q?11XK0n6dwKOg5k98o9TJqUrP/EqxWPfzwACSfE2AYTnqEcRQX1B3B+OtuCAu?=
 =?us-ascii?Q?gfm6NxwF1hu6gOuygQWDBeFl65ekM0kdU2gs2uoaZ1M4u64sdDuU7/jrCXwH?=
 =?us-ascii?Q?u4hA2jl3LDzhbJUhQwIOEDuPhmx8TBZPUZC+vMDtJ2XaQmy6P8DKTcgeQepz?=
 =?us-ascii?Q?fe4mzA2LtR5Ve1W0jRVIAIyVGdpwtsrPBGLJY46FsSFw6LIRuBcHKkIsmm6X?=
 =?us-ascii?Q?1xhfMVTGIopMu842GxlTIAva/yT0BX+hxUTe0vN2tGKOl3kherwCtDM0WtFB?=
 =?us-ascii?Q?CrjNC3NP2KonEAh0Gzk1uKHS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb335017-a267-4d1c-073c-08d8ed919f34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:21:38.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io1tiNUbq6EI8amuglywcb50dlX2nRX8K6MOVcVMnUkAd6uorqkd7bC0wgEZ4X7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 07:14:35PM +0200, Gal Pressman wrote:
> On 22/03/2021 18:55, Jason Gunthorpe wrote:
> > On Mon, Mar 22, 2021 at 03:11:33PM +0200, Gal Pressman wrote:
> >>
> >> On 22/03/2021 15:01, Jason Gunthorpe wrote:
> >>> On Tue, Mar 16, 2021 at 03:24:16PM +0200, Gal Pressman wrote:
> >>>> The strlcpy function doesn't limit the source length, use the preferred
> >>>> strscpy function instead.
> >>>
> >>> Why do we need to limit the source length here? Either this is a bug
> >>> because the source string is no NULL terminated or it is OK as is?
> >>
> >> It's not a bug as is, but it addresses checkpatch's warning:
> >> WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> > 
> > Okay.. but why is it so weird:
> > 
> >         strscpy(hinf->kernel_ver_str, utsname()->version,
> >                 min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
> > 
> > ?
> > 
> > utsname()->version is null terminated, yes? Why does it need to be
> > min'd?
> 
> The size of the kernel buffer is different than the device buffer (65B vs 32B),
> the min() is there to prevent overflow regardless of the NULL termination.
> A NULL terminated 60 bytes utsname would be truncated to 32 bytes.

I don't understand.

If version is NULL terminated than this:

   strscpy(hinf->kernel_ver_str, utsname()->version,
           sizeof(hinf->kernel_ver_str))

Is the only thing needed? The whole point of strscpy is that it
truncates the string to fit the output.

Jason
