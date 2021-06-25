Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B923B4604
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFYOrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 10:47:13 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:46240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhFYOrM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 10:47:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev3+1VoY8x3G9T+7G7lrsI8n38BxAWANyAf12wgptdF0qodkubu41lZGU8obnhrMEHvrNJ5KYmIFHe15ZIsYQGUheRZAZyt9C9MhXQ/SFad80p+DH9iQMU6yZNRgEIenbh05Jk5ddERZikqYgjl/uCUCZctq0yb8iPxi0H8mYR0NoSc08cV0wjPDF1m65m2q6MtvSdbdeO/bpZpCseu2oXNralEKKcCcRZVxR3j6+j/0r7rtoMOKkn9mfaMsQgvCqU4BhBvY2OCFCXwOgfQAJ/JtaGoTgBSWxG6muoCBHMX/5ZIAbtmJ40nrUD6dlB2hclyOKOiI/Sse4mb69DC6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xslr7tYTU/JoP9Q/r4AiRYsS3oN+k316REZvikubI4=;
 b=KLpIfdvcfk+/X//kZ4HtSgB6F4q+flz109ZXa/v94kSumd7dzHNAZQ+xNvQ8bM/WVOFT0xL45vEjzYABzCrpHFBGq/S2SncZHi+DaaW+qb9iYwL/ZegVBrRTW2UbwDtIISwi53Si1BN2sESDEZE7ogd6qHTi3v2aIDDmedV5GkCOUySNPBw2MsFkF5Cf2uwQD78gMBat0qs8f4i3r6I8ZxZ6BbYLwoUs97PK7HZ5m6NQrnZVLGNvW659Xk3Fu12DU+Sv/oY8o0zO1lt1wYCi0KuqRzHxINiZaXSPrk37tepffKSB03zsP61K6TyzaEVSWUZbiuEPq2wzGkeINhde0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xslr7tYTU/JoP9Q/r4AiRYsS3oN+k316REZvikubI4=;
 b=VDpmgBLr3jJsRNk1qqjukdlqJFhreP/AeMGgEHqd1XHGogzGVKaLaSNDf81kOH50FS3GyGgKkxHU96hvmsoqe1hOY9qXhc+waAbyjoHaMojVrTVtEC62lwZxx3g/S0LDezrXeDw9Rs3wIiryPC7I6BM95Tar9eVO+rjzOGty2F4bRjA4R4FYxYUyQb28UXn4EWQ92KtXTB1eWiMgyVSYs6o5OaD1Eg8DNHQyrJvmZ5NHwxNi1xItctzBiL1+JqKQsb+XzGp2vFHYDGGE9Wtkvxy7fZU0krk1q/1qsRuTzxm6VOPegMm2uO8HHJ0chhs1+IoZt7VmBx+Q4shlhAoVCw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 14:44:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 14:44:51 +0000
Date:   Fri, 25 Jun 2021 11:44:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/cma: Fix incorrect Packet Lifetime
 calculation
Message-ID: <20210625144450.GA3001725@nvidia.com>
References: <1624371207-26710-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1624371207-26710-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:207:3c::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:207:3c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend Transport; Fri, 25 Jun 2021 14:44:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwn4c-00Cau3-8A; Fri, 25 Jun 2021 11:44:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a49fae6-9e4a-4a89-fb82-08d937e7c9ae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208ED343E81BF6E007812C6C2069@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kWS+rZH973ys57N7TawhdEqwG1GeSnPTOBMh9zgF1nDtucVzi6m8ra/bBfB6OCL4P3nNLf7muqP/43AwqKwhep6chZu5bG48HBQ4iZKaOdJjg7P3kkiN34RDqUypydTHcj9T4/1bgdXh/+A+NbMSVaoOjklaKYQ2OdkbaQmaPAfkNotkuACiWQQ6m48gp3cTJCFVK7wQpG0qXVyI73hVNl0hBkbM11UCgrIo8WGG2a7XGj1vubFu/MKNQWQamsod2gWDUTUcY0gU6HJBYL7bpt9YIBnX+ygu9RKG7GulLqsPJQs8Ze7bYyHcBe9lC0FYHNsmHYuOaDU7mf2TVLyXMDxMp/ptcXLfySVcpD5k6Wa9MHbOp3RGV5h9V7kd0g1IrVtDhSoiwwRmTwEeLAUZf6dnoPP/XQum5qlcmmIflozCM4ACdtjeS+ZldB1pKxUH4ZhX4p4GdoKE2UaFctRYgBT1fLvtuhC/KQ5/rCpffWy53i6YwbSxiN6ybFU+z4la0Jr7iBPa1WdbggzOn7aoAvFRH5DIh6GJKyUiRhsw5jzTB4YJrPvjA2pU0kTnA3dGxvn/cnudM5zQT6yPQOn1TaMT2r+rCAEjn3hZCGykeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(6916009)(5660300002)(38100700002)(9746002)(33656002)(86362001)(9786002)(2616005)(4326008)(186003)(54906003)(316002)(426003)(2906002)(26005)(478600001)(36756003)(8936002)(66476007)(66556008)(66946007)(1076003)(8676002)(83380400001)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3IwV3pmQ0MyUHVMY1UvQjU1ZUJBRGZRMFZibXN6Mkg2czBybDl6VWt0bXgx?=
 =?utf-8?B?M2JNSWtUdno5UFdjeDA1NUplQlBKdjFCVlh2Nk5CdmtkYWlSU0xYYktsRVZT?=
 =?utf-8?B?ZTF6RWtjcnpqRWJyeDNEb0dteE1EU3gxeC9FeWdieUc3dTBVUmxuSllNUnJH?=
 =?utf-8?B?OGZxbnl2MmQwczg1N2ozNG9nRXdSOFB2UnQwbEQ0cDlWL25rU2hPUjJpOUY5?=
 =?utf-8?B?cnowT0F5VzZBc0xKVlljdGZDQ1ordSt6bnJLNGhJUTUxUXRqUmJ6bWRuMDUw?=
 =?utf-8?B?WTRYU1ZUaWN3elVJTVY5N3ljSER5bmlMVytDdG85WnJiOWhoRkYxMDB0Q09L?=
 =?utf-8?B?dXV6UmtsTTM4UTFUVVBBZHF3Y0lIZ1lwNEJaT3d4TlpiaFJuV0o2V0hjTFFQ?=
 =?utf-8?B?RWhUNEQ1NEFVL0NScXpBeUdGWlVUUUFiLzRjNEdzNjdBb3V3WTgrZ2NMZHNU?=
 =?utf-8?B?MTRBbVdHRlc5aU5EY3FTTW5pb2g3bHI5VVVFeUFmTDByUTFXTjRvem5CcVh0?=
 =?utf-8?B?cG1EZEMxM0hzY1gvSDRQdFNQd0VGbDhBdkE5OG04ZUZOcmZ6VUwzN1lYL1NN?=
 =?utf-8?B?N0hRbVAzakg0SlI0ZUdIR1FKM2tjYkJWcmZDcjhkdUl0b2kxdU1HWTBoNTM1?=
 =?utf-8?B?endKamtxQytQRUY0bTJFTTFkSXEyWlZ1OHJaTDI3RlB6YmJvYjhaNEZsUzU5?=
 =?utf-8?B?eTV1WVNXMURwYjYzaGI0UmpHd3EwNjJvdE9PeEZFYStkbGs1S3YxaElDQ1JG?=
 =?utf-8?B?d3hYcXg1aWR4Q3Z1dW9lbDZzMXUreGE0N0JyQTJIK29Rd0t1YlBNS010a3Vq?=
 =?utf-8?B?dExrRmVDeGc1bGI4N3ZFZm5FcXQ4OUVsM2p5T2FjOVlRVXhYQVlkdFEyMkQ4?=
 =?utf-8?B?bkkyUXJWVHIxKzhhdjdTVG94Q0xJV0tNY0NMREZyVDN3WjBIRy83NU1xREVN?=
 =?utf-8?B?SUpvNTNDdEJtcTY4UnkwSjhCVTZ2MG5SeWZUV3dLSzVadUFwRys1K0tFY1dr?=
 =?utf-8?B?UzlwNU1lVXlqNFgyNnJPaG9ldllNT2duY1diM0Z0OTJ3THZtakMzUFlraXZ5?=
 =?utf-8?B?M0dFM1gwbGo0TmFIQmhCRk52QjFsaEN0TVI4MmRWelBaWWV4OG5RR0xwQmhx?=
 =?utf-8?B?WVV1SEVaWEs0UnR1Rm8xRlRzQndWN3RSNXBHQUpuRFpENnB1VEhGdFNLVU1U?=
 =?utf-8?B?YityeVd0YVhhS01lRW8wczZ6MEpLZlFPVHN4T1M1OC9EcXpBaXRuWlQzY2Vp?=
 =?utf-8?B?RnRPUERYekQxL0lRMXZpQzlORzBFYkZENUNoU3Q4alBLN0o3MkhTQll0L2hZ?=
 =?utf-8?B?bWlHZ1hCUEZYOXhDbjdLd0NmN2IvQ1NNVDRGUy82M0hDZDRTRXpVUEJmRE1n?=
 =?utf-8?B?cENCdkl2VUxoSTNGOGtNYXprc3hUVmszYUdCSDdEKzhyeVpuZHVRdVp6TnlB?=
 =?utf-8?B?YkpyQnZSd01zVHdMTm13RzFobE80M3pQZ3UvVzBYMzl5amlwcXJ3dEI4elVo?=
 =?utf-8?B?QVlqdUxyTCtQZnQ1Z1RFUXhDUVdnNDRSbTR0VTRwbGtneUVobTcvWmJEU2Z1?=
 =?utf-8?B?Sk9MT20rZmFMbTZBNjVuajhjUWJNV2YzeHY3Tnp3TUUxTkI1S0x4enI3S1lU?=
 =?utf-8?B?K1pld3pQcmlXeHdoL2g4dXpia0JxKzFWdnZkWjNpY0ZyajBHS3VaVVRMNWxD?=
 =?utf-8?B?WTFBYzZ1VU0zWHpvSXAxM3VoWVZ2UXlwSjc5aHdNSDRjNUZTbVJZRzIrYW9B?=
 =?utf-8?Q?7l8/bCDecqTnYx+1MVAMfR2vGQoktey5aPKWNTk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a49fae6-9e4a-4a89-fb82-08d937e7c9ae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 14:44:51.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmYtglBJAvq2RtwZgyghl3GqiTFAizJpDtazE9xDho6uYZjK/eFg+8U7GhMimcGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 04:13:27PM +0200, Håkon Bugge wrote:
> An approximation for the PacketLifeTime is half the local ACK timeout.
> The encoding for both timers are logarithmic.
> 
> If the local ACK timeout is set, but zero, it means the timer is
> disabled. In this case, we choose the CMA_IBOE_PACKET_LIFETIME value,
> since 50% of infinite makes no sense.
> 
> Before this commit, the PacketLifeTime became 255 if local ACK
> timeout was zero (not running).
> 
> Fixed by explicitly testing for timeout being zero.
> 
> Fixes: e1ee1e62bec4 ("RDMA/cma: Use ACK timeout for RoCE packetLifeTime")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> 
> 	v1 -> v2:
> 	   * Rebased on tip of for-next with ("RDMA/cma: Protect RMW
> 	     with qp_mutex") included
> 	   * A local ACK timeout of zero now sets PacketLifeTime to
>              CMA_IBOE_PACKET_LIFETIME
> 	   * Added Leon's r-b
> ---
>  drivers/infiniband/core/cma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
