Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DB3B0CDD
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFVSaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:30:35 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:29825
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230146AbhFVSae (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:30:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii9ltUKAg/jMxB5/3W+6oF4Toa6tCQxJ4vsHwUOffwgb4us9jLmmWoiZEtPokor40Dner7SQINvvfwBozFtDeSCWZTyS8hi13WRHuJyTTPlfCABrd4Br3buH6h1YsBEz+luwTcyxCIKvzsvPAOMKAK8s1owGZbP/FkeOjeGASsxOLGu/ez9WXXrVAQOiMpyCKpeq0nNSVABJewpZJ756b4sKCHHRpIyNl+8FUFcTNyWK9c1FDN0RWP2020ai43d+8qDv+LNbA9dc25XdO6Mg+hbIkvpNUmhuKvmlMninaPPnMqhupDwwDrlO9W+JGyNxGhftHh2SWFfjn+lrZjDohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCqJP+yhJmhFF8/xPlmEY70fBeydEX0k8eJlJgMK68A=;
 b=kBOMlWM2vrUE928ReIctJX7JbMNhNLOOtmGrnYsGyHHp5vIhQ3dX8VgF2MKyUfwYtb1IzVeFl+G/1PH1LLuvrClLVKYc4MnCHj4cZVCICtKqlsaTkcQOOcdczk3evuk4+tU1I1dASy3TX1ym+mntjaKps/1jV5UQUsKje+XRcxhodPpYdiAbkdYKKfst7OTdh8h72UPrVrS5Rby4JsHJSI5HbKwzQYKN9iattzV61MNDC1I8gdx6GIGaRz//z0qnM9+shWYxgyVaKL4+8o626dQ9+xjY4TsB+XhDhYN0c8bdfvcK0/NxakRItLyYkLnJ3V0x2mEGXTb+krmTjhU7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCqJP+yhJmhFF8/xPlmEY70fBeydEX0k8eJlJgMK68A=;
 b=ommkKgQCHX26mXcbL/8kHiD4z0S/joc2fPZHAKPxaWhvNgxC5h0vQ5DHoF7nDXsxuuhdAdXALAnM6hzMxScqunhad3HhsslVx6SkG6g50UppZeF8gsnQUzQTHvZKfzkOzE3UqigPvqxB8hwJ2HBMvGwzE7itfTZGx9bXtw+OOkIPuMwx0QVvBhNp1n2vZ8ZZJr0llvKe7NxQ79XAzyzuadpwfuSgwbM864is5tmg4V1T81XzLq5g9DWGczrk6u5Uwo42bGTlPSDhH7mXi3HsxwTyUI8r7yH8dfbPmjKXANOrnSUfUcKNtfwvBdBVjer/acim87vNh2yUrcH6FGvG5g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 22 Jun
 2021 18:28:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:28:17 +0000
Date:   Tue, 22 Jun 2021 15:28:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH rdma-next 2/3] RDMA/irdma: Check return value from
 ib_umem_find_best_pgsz
Message-ID: <20210622182816.GA2586444@nvidia.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
 <20210622175232.439-3-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622175232.439-3-tatyana.e.nikolova@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Tue, 22 Jun 2021 18:28:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvl8C-00Aqsk-Gx; Tue, 22 Jun 2021 15:28:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a56e87-f475-42a3-e34e-08d935ab8132
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046FF2777D66F53FAEF7B72C2099@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +inc6psocIIC7PVZojPF5AubsZfRtnu+XP1jL1eWZMfqVhyAhFO/QEzy4NYPSFumgxXcBtuRO/8kvjRWtNMjtNdeyIdrzOn9/BbIU4Ubk0y9ml0LuV/lFxaHYBEMv5may+vIm3IumbxxYMRFIoqLVAU5StDro83KHhlQAq21dTbm1YUx32A3+uo4qkz8drI7X+D4PyYiWAdERsUeYV6UMzoilK1tgTsCCspRzkh85ZvVDKXsxvGAJbvdHV0xGXlDtdhBJGEx85FBQLmZr3wSv6uiRIu0f19xtU1BhKnDqhPDYefsLA8rlvT644eosE4g15c3sZj8Ja/UrSU7dftGqW1gyRxJfB+9z0Z3MF1izNkt0S9PqTMAoRYCjrNSQ4hN2w5RkVaR5S/IETink113WRpRrQPYq9S1rOR/mBBqqG/7vGvN1msPWLEanTjo3oG47IChCslpSQvZPQGr1M4gYL7i6KQf5VrD3AlGUCS8jpXtgcMg6jfPRWY2F7n+LzMApny3guBD7Vg/+oChBHbAv2tt1CV9jPEv+nZ+B2ok7g1uWPY5NK91MicynHW0Na1XXI5XA5t6QdDce6+wRtu3Vi1zr/elPRh+T80F8dIJLpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(8676002)(1076003)(9746002)(66476007)(426003)(66556008)(4326008)(8936002)(186003)(316002)(2616005)(478600001)(9786002)(6916009)(86362001)(26005)(33656002)(83380400001)(36756003)(5660300002)(4744005)(2906002)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ypJE4JkTbv7fusV/qw19zr7LUtHpIaRJCMfpuogJsrLXHMr9I3MOCo3RbgqH?=
 =?us-ascii?Q?Q1F8idQ852fTm7Jqkpmj2KYmFrvW6lgxVEdByda+7Bs7/zSB2otb5bhp+WcQ?=
 =?us-ascii?Q?drj131QtXEPrmDSHxHMgznHI03xte8m3DjnhkF6W2oYzttghZ1pQCflS0K0D?=
 =?us-ascii?Q?8xGHf1tnzShxLELKaWEYJlRdnRgrCAec4KWusQAo/2vMTFRdwcH3EovfyBeh?=
 =?us-ascii?Q?Vf1HbzS28yRkaBdzPDjwEQbQD+yJIgijgdrBiOfbdNG0cjoQHxNYYAY6A+Ix?=
 =?us-ascii?Q?USd/XIYxRDCClBUSd7HIdqwPEUI4z1Ki2H0fq8oPOnsS3EcSEKbCi8gTSO35?=
 =?us-ascii?Q?Xf8TdP1yfCEAAZMXI6ru9wf0Y6KzrSXxGSb86nGcnX1h514/6XBmaD+L/37f?=
 =?us-ascii?Q?Nkdz6s0elXzG/n1o36wV3oJa+kiQiLyqeAjuiVh8N2gzhlx13Hc6PxHpIMlK?=
 =?us-ascii?Q?y1OY2xGLLIBt8P1c899CDMknn0ce/p6RvnHOtIsApXjoe2CVIp3+LKyZRVvs?=
 =?us-ascii?Q?3SMzq5SVnzu6nAmgAqgzUdkfKgN6u9s3ibi6oJjxmNiGoaQIsR5gDu+AQpc+?=
 =?us-ascii?Q?EDiX9vZi5kV9rQ5ODzN/7EXsDHJczAC/C2dZnGUt63aBy4bBSKFDkuO/8Jpw?=
 =?us-ascii?Q?Fe85BwMoqYNZknS8ZxSnx18OSK/Lqr1VqbbQng5GgN8E4chfQYTpwAVappMW?=
 =?us-ascii?Q?7oMMDehTu9al0CF9Qu3bQsSsl70YZzG5d25C2y1RaeEw6s90PLhLwworWhA7?=
 =?us-ascii?Q?2tDRD1BWARprMFjs2Jh1nWKYepmuIvf4CxgKmTPNi3Os+xf1n7VgOJimMnBu?=
 =?us-ascii?Q?uC/DAHBwYTQ/jLv41BxBjAVmX7SRMUTNopwNlRG4v6Rnh3Igi4Tj6BOXFV3O?=
 =?us-ascii?Q?GdSJAQRt1V/THaJ3afBKLEhQyg/8ij6frxnE+L8yM76EoVNfYnWDmqaLun49?=
 =?us-ascii?Q?u94RspsmCeQME/+MbX1L4lwfUhzrNZwPE4gdvRpzur3m1xFbH463im4iSzxI?=
 =?us-ascii?Q?DyQyy6k0ytfSM+WmlU9+nPruK8StUZuOuWR7/ZSjEldC8tH3kLWMAEjt+sLh?=
 =?us-ascii?Q?95pXmRGZM+0h1MKU7QHYjqu4bK4e5P8TcFETvrJw71aQTrSwWWDZL5hrUe9Y?=
 =?us-ascii?Q?Oo9vC//KNwvtusTL6WqR7PCgTuFrqS7C1zVW8++NPgxx+LhHk+mvjNeUyH5w?=
 =?us-ascii?Q?/Yy93I1E2fKlow9Sg5w1i2ft7ULh2kKgsewc/7ULTo6Kj6H4BJmQSH5Zf7uN?=
 =?us-ascii?Q?J76EcgmoOxO7jmdqQW0NKjNXZuq6Dck0BCF9dM+r/Xu07QElOq8Jmr4WzMIm?=
 =?us-ascii?Q?FZRbYnaw09WeJ5CLGc8+1nkz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a56e87-f475-42a3-e34e-08d935ab8132
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:28:17.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt2ORtlumDmB3Dd5PXXAwysnFNxZn8IchDznEhVNBAybH+AkrvE69EuDz6Xpr486
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 12:52:31PM -0500, Tatyana Nikolova wrote:
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> iwmr->page_size stores the return from ib_umem_find_best_pgsz
> and maybe zero when used in ib_umem_num_dma_blocks thus causing
> a divide by zero error.
> 
> Fix this by erroring out of irdma_reg_user when 0 is returned
> from ib_umem_find_best_pgsz.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1505149 ("Integer handling issues")
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

This patch applied to for-next, thanks

Jason
