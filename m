Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30F4457626
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhKSSO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 13:14:26 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:2684
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhKSSO0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 13:14:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyCTRciWg9LZKq1mwrpT2Mf2ypIh6h4T49KLPqBeCWQSV0E4DkrXh8i2YmeegbyUUfJqOEB970GHBRiN5z7tE3Ate14UKiLJfS+EEKqt97AwLH0XfkQd+xI2iQ8oFd6kgeUrqXuFy0lqhqtfmUWN5q56jVAp5e6bNeC2SpPSVF0om7L0vkjW9sBz7iQ1S1eraHFc2GjM7JOgSI5pvcLZNwXvCXI0Yq/h4doDhztxuWkNhTokn/5JlYnold1hf0Z85QJfS4tejYdt3paI3MhqSKBbycbPutrPHRew80mTPd2uNDTDVY4k//cSHHIj4x5TdEa5uo0PYCPhf6fKPanjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0hc+Wq7vj85Vvgd3Mtw5RgbG/03OkDx06KhPUH3Gfc=;
 b=F4JQef4bIRuXWJ/eiRFFlZQBQ0jX9tmUUvDCX2gENSnYOUcSRugsMpQQIsMThaqO9ENoi1zHRj4d51uloTKG2hWb+POhi37Qk14alJlrLrXzyfPDjAy3lH4+wpq8LGGzstDtCKEU7YG+eEoFJREfTsT6+uorkNmkOemTsIQdMrIPIWTpBZRjM/nk1vFAYvuyyiu+8U5pFSRs+k2veXFxo7iCPkASEKu1ImPUCPhrgT0ck9FKlQkzPFaFWNy3cCK+DI6ql/WlmcTEnrjbjGR3asHSnpcp/ZBvCGphrkFRNZWO6qScdGjwseLVtQofeBoWqPC2TrXQtPHzeHtEi/iFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0hc+Wq7vj85Vvgd3Mtw5RgbG/03OkDx06KhPUH3Gfc=;
 b=cCZyjPn0zzoALgF7G+tiQ2HYm/TaHYDGl/bPQWNRuRNZCaGOXzXHzBMwV78JLZ7KTdafNauYQDjg2umm4AKq0/Ars9a5Ok8miN9Fuud19QwnCm1kclTLNiCv3XkJ+yMTtPjZwhB/C2t3oS+8f2LhVTlaYPa7ubM4T17QIE52tfhVQjBeCFNsQ8IG1bMDufpKV2O8FRaHprr3tNxD6z1pi22i0OVVJOglUqcm1CzTNroP7j5psbIMRgvpEwM0dCk59XB/E/6jvAEg8SdDaNUEnpviSPqrt5bqm1Z0p2LLSa/jf7YjfjplAikVedVObCwyPd03bvbNzgaz22yUvJxcIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 18:11:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 18:11:23 +0000
Date:   Fri, 19 Nov 2021 14:11:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Two announcements
Message-ID: <20211119181122.GB2105516@nvidia.com>
References: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0300.namprd13.prod.outlook.com (2603:10b6:208:2bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.8 via Frontend Transport; Fri, 19 Nov 2021 18:11:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo8M6-00CZSL-BD; Fri, 19 Nov 2021 14:11:22 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b325df-a03e-4ac3-eea8-08d9ab87fe95
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255E45EF23761F4B31F58E0C29C9@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xFOJ+WTfY8a4QKcjrLaidNE00sNJEBeliAPYHptj05iR4ayVcp+/M+4n2Q+YITKxUKLdpanyNA6iGhaxE27RIFOJCIAGyfqzS9xhdq3pZA7JmkdsIiZpYs0u+dVqBWNHuuqswvS+npoiIJZL0MLgpaKIvrm7xWRm6cUIff3sEgPoVaMqhkVt3+gG2WWMqQbgxTblcnhPlvSDMBUePyxB4zKyD1jEScJWI4tPr2Jg7KoL8240uBTm3ShkGGQldk9vSa0zEPc/hXuqyz6qgNdnM2bAg5Hp+zD/CY9KE/aaEGPGUNe+bmrQQV6lr/ohG9MacbICpSGtQMZGGA9+87KRb35liy3SDO5H0pTbRE9V9fi14qmebpTcKqb8XWESLZ6oFNa4OZl20pvmD130D7PcVXfW1AZqP7D7/3BWOZg8MZUwJ/jJ3U+3hv4RGfLbAuE71QBAdPfwXRSqiYaJ2KlxmNzSHnDdlfsfwpU+CNgZsS8ozK9bhuQK2Mr9RgBg3Svp0sXh4bulE8GXKF7N2evaFAPcr2HTx5oyrpxnMbmVccNgcyuXy92FfrzmO+39Hl2T/ZFJfQ+HKDoQZjIK1dfUCJR9fcn7sjxxWD5yQgKUEkBVjNhHCd69BXyqrXQrTd2RyklnMq/+oE+qgeS6PCmHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66556008)(6916009)(33656002)(8936002)(66946007)(26005)(7116003)(2906002)(9746002)(66476007)(4744005)(9786002)(1076003)(2616005)(4326008)(316002)(186003)(8676002)(426003)(5660300002)(86362001)(3480700007)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LrNcNIea3fiYfKC3P52lrFoDiy7Om2zi6i4vhP+vtUu3jNEnvk3SU4QBbrcG?=
 =?us-ascii?Q?25YokXIxozn4w1X5Rn7YNp5YeN2HbDPNoHu8s+/fu6zEGYsEIayZQUPutG9g?=
 =?us-ascii?Q?sDTw5i2c+TRL9n7UbgmiMSkp0r+FrgnjlxTv9RPUbJUi5ML0yk301fcNwG84?=
 =?us-ascii?Q?l/gHSHR2XKJKac1huSCM4L/QKi/5wSyDwAMsQCAS5/UZOwdhKsDbmI4SwhjT?=
 =?us-ascii?Q?QxbU1F24LGVHBYVxZs1OK9cf2OHF24h9NC65gJvZsZCRGyISL43iyoOg5ake?=
 =?us-ascii?Q?GaGVz9ZTYMKhjGPOKuexcluzauLuDUQSG12LfvduLQ6YhNo8wb5nuwix+iLs?=
 =?us-ascii?Q?pY+XfQLXSEKD+a1H2OCGDXkhakYJmv3CTzzOFSeHp79kqUSsgtFYbQHBtMHp?=
 =?us-ascii?Q?wKSnc3otCQTvSBqHf965FdOGunDllDMUXUYzQsF9/Hqm7xFoPTQaWDkiWq6C?=
 =?us-ascii?Q?Z1CurEyq9NlHP4g0R8XGR6Vca9FpAe3GDbch/zq1icCbVXgoZw073fG39c87?=
 =?us-ascii?Q?2jo2mddron0ZQpfrI8eMK2vb4MxolFIoO9FATkDkqcuflKd+n8ccKREOhjJI?=
 =?us-ascii?Q?Y/B8xf/mAcVoGT1ijrSCHG+wRjmqJ6mmUYJ3IHIBxBlKdQxWcmF0ZWpCkCBi?=
 =?us-ascii?Q?q7rZT34U5wc0o7oqJd9X22wZw+UJkDFflcJf4af4tx/nJUA/V/2U2mbsntqd?=
 =?us-ascii?Q?LRXKc6PGtCqEW5XNKUx01qmsv7/7R/vUhrEGZVVdtcYbwitfOnvTjrsRP6Uu?=
 =?us-ascii?Q?/GNawXNTPQGn+uy1Ozm/qVjSLlbzwkvuzowxJ8KSslidZ4FXgeBEqOGrUKQV?=
 =?us-ascii?Q?8y0WXUssSsBe2fZkabuYxBRiXftDPPq4GGBCHBsuuepuExInoZStZYovhNaS?=
 =?us-ascii?Q?DeR1VqBSu7NProtXvdubJ1mSkfUizPIDO1jyEO3KwNEuOASIlVjXZgEVh4jh?=
 =?us-ascii?Q?DdG3oxY24nW87EDowbNPJEjF+S1WQA/TiaX5KbxYFekhkn+A1M/zLdGjeZIF?=
 =?us-ascii?Q?WnHCaU6FlWTrVmAPW8OqzCKTrradVDB9+3drcQH74OIIcCKneuN+3kiVq+6B?=
 =?us-ascii?Q?0D4ZIx42kM/xLI/khTpptfKdbUWaxFWV9phDDqxpE2ItrwZlwVaP/WqrJa/7?=
 =?us-ascii?Q?lUSbFDGWb6ByUyI/sL7vWrAcyDsXb9kFp0GIIW8iIoMVMtpVW1YDcACxKueQ?=
 =?us-ascii?Q?uOqMeTWKMUQ5HO/Y1WNJNJ4X4gR6DKt0RJEAZqzX8BjsS+ON2ppclx+BU8PY?=
 =?us-ascii?Q?LBFGGhfC/OUvVdkQaZoGyjRrcnZI36I9M0IxYJnuGQdgXzcJzwWenzTL9bLY?=
 =?us-ascii?Q?OgVDzAxIwJal3R02s1pWLr1I7k1BRoUD3Kn0rvPh7usJy3+0j+nyqcscuFAd?=
 =?us-ascii?Q?80hAZwAfyms347bwmc/njxeVNZnpxWbTN4oboE+7mPGku/dNvMszAz1KY3vm?=
 =?us-ascii?Q?NGEwyLAlJ4+Z2B9RmZZA7Jl77R85PKN6zorhS8VBqe26ivDwusbJap3Zoftw?=
 =?us-ascii?Q?vFUuHGUWgcTaBX4DScrgSexPoIsHIehv5DL1V8iexa2wINfgdqWtnF2/8Phj?=
 =?us-ascii?Q?2erUaNEVRCAKnZyLfLk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b325df-a03e-4ac3-eea8-08d9ab87fe95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 18:11:23.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsPKow3WNLoqcMke/dFzNy4nxMG554PEtzSlrQC0YHlL67a5jouCV21a9ij12/bH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 02:57:09PM -0600, Doug Ledford wrote:
> As I'm sure many of you have noticed, while I've been off doing these
> things, Jason has carried the burden of RDMA kernel maintenance on his
> own.  Since adding the CI infrastructure and getting the initial tests
> added to the cluster will not likely provide me any more free time
> than I have had recently, the second announcement is that I'm going to
> remove my name from the list of upstream kernel maintainers on the
> RDMA stack and the rdma-core user space package.  

Thanks Doug for all you've done and I hope the FSDP project will be a
success!

Jason
