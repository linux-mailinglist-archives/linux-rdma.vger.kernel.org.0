Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA527093A
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRXta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:49:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:48594 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgIRXt3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 19:49:29 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6547860000>; Sat, 19 Sep 2020 07:49:26 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:49:26 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoCeDqS+OX6HgZOGZzSPpHYA7h5hws8D8Urhxl3IMii3bORI7R32YntZ4C/7LRQfaFbJtiSXENefjdqyrkf18UFyvJStBdgyMaQWOKE2X8hNLiZBiCuJVh+DNFa+UfsqrJQ6SUsIFhDfP/hhrHRQrwexSUQUgyxMsHBC9WQky/VjWsrSUSPon58ed5M+Gs0m47J0923ZhRucRkq3fE8cSZP90fljQpQ8leBDrNu1oQ66UboFBV7zP9u+qX4Qb+dVCLSKcJjFlHTeIXnGerUzrTsWhwSXWD5wvsv4YXdfTvavQ+e6RY1jvzfoi2IhunVcVLjPpgX4+KM/hZ3h5xD1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eiWdJQ/u37NBxT11B55qzeb4NUJncS3oS9Hv9ydG1M=;
 b=AnMAEc4mEkMhikOmuQpHOjkMcDQ0YSi7LGJERSNARTLPBmhpq44sCv0XROzzcRuEH8Rwnf41T1H8bOgGNMwgbPWA/xCbElR+wfLxP2+2Aq5UbAVVerHCuHYqWNiZYKd2t5XvOZgYjz5SBEMCea7AqB/zUmAkEnbzuE4TFgFC91pgdZnPsxmnBl2d63X6N+ViYJ3KyKtNgj1UkjMo+bw3hEPSdLo0hpvAJgS5Ezrjfa9GsGutao2qG5LtlAQ9lofi55jQ1qezHWxraVNAmktsZ5XGYJwRp8SDVqVvQboRo4uNrejmfBbrKSrmKqRI4d1JDyytJqAT1GELxSFiP0jOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 23:49:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:49:22 +0000
Date:   Fri, 18 Sep 2020 20:49:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 10/12] rdma_rxe: Fix pool related bugs
Message-ID: <20200918234921.GI3699@nvidia.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918211517.5295-11-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200918211517.5295-11-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 23:49:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJQ81-001thj-5E; Fri, 18 Sep 2020 20:49:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12058118-d66b-4f6f-e4b1-08d85c2d77b4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15462CDE258B4BC00E666DF2C23F0@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ4E2iu4dbOxNujQskkLJfNkGw2S6sowzz+gaa5GlPrDcG6Xu68WMr1wDgk+AYV68onXz12miX+khdhvuBYlVpmjDuW6IfsEBVYBboBGnfyrrpzJcOw3jnEXFu81CXUO/HrDxRyzIIX1co33RY/aFu4gNfV8lkNvKOjqeB/sdEtoMtfe74QEhnAJGGus2RYMRM4BHRCn98XsMCM+kfZow1yGOr49H6YMsLPsG//2sMLV5tsNHLrdgJ4QMKzdGheSVHU9bcOV146Ui3LdlS4ce3hT3jXLLUYE6KqIQnLb2tJ0YFqWPo+ICqow2wE6bQw40QPOxNU+GNL/ZlfIHzloQcdZmi3CBW1sZKk+nUhsroP8oMa3cTEVCGUCEG7bHmrW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(26005)(426003)(4326008)(316002)(186003)(6916009)(2616005)(478600001)(86362001)(33656002)(8936002)(9786002)(2906002)(36756003)(9746002)(5660300002)(66946007)(83380400001)(66556008)(66476007)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ipvqGvOIZ+0TVepdZS65++MBj8tnD+AA6gJeNdDQ3S6AIjj6nBawE7Eg7honkW7fI5T3glhl2jntbwRLdE7qCHc1A2zwpRBBhgiQMoX7KZVIjg7X6pOkHRB2sbjIuV3Q0IJiiSzaa5dgUdXAYL14tMuGCS8LXwVEb3zMl5/oNfcDuPxAUqtd6S6wwfvEqYjQYpbKlwdPInLSgqHHcKGB56NY1wepRZgvD3rgfmmHoArkYVDfL00cITlrJeX4GPAll2m8kfpdvGUCXBAjR1du5ePAnhF9T8p7+pTTM28sq5XTH62NUjQnhPSvIiobAoSzulnhfdhxqUov6BmdUZEDSa4GZhsFmU7YG/Lgjk4lob4FT2Uuf+6862mA7WqT25Q85YiimAgAsaTI6xVi3giaYrKrH4SKlS8ivDwoC9k9Kt6chxKRn6J5oRNT0htIGHSr5+Gf0ZN5Qz+BE0flOfYkhIQVe0awToEIkVrtoNMbiyQLC8QMawKDpTC1HnyCn0CquMJNTMsZjiXW0ExOt9jK5jtWgHJBxyEqrOhwJ1MMwm7p8W6k3zcS8Z5lUGjfxblyfYBXfQU0kuk+sH5XTLTERosULh7g/h4buRq0sTlawCJgcI1jGF0FUaeRLp+ZEmieP8s1iMwTNpxX4Z2oIlK6ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12058118-d66b-4f6f-e4b1-08d85c2d77b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:49:22.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1oZQF6fWJPsl8xqeVcNfOoP0savthl67fZNECq7I757A1UAGYiMfP6MEnaYXqmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600472966; bh=4eiWdJQ/u37NBxT11B55qzeb4NUJncS3oS9Hv9ydG1M=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=L+ZxSAmicdisggDrne3c/J+0rUYBCSM/kfqAtnpOWXK/o1Q3FulQqF2oiBoZQtKX/
         lnA1NjJjeRppZuYXYEu8Mwsxt0tAXASjqWIgUm95sIyajE7SA6YicwVY/isM4buU5q
         aIUrH0IugVFN6IpTyLVQgADTMh/LOYmM3Mw3Q2F5FA/0eJ/cvI/zNMKYHNpz65RKyM
         YzEx7c8xUegY0dlvPwlAfLyjgUSph89GsDrNKezj9jf7pT/ynUYTND2DXrnc77lUg3
         Q63Beu42IqBbqlqSnCfTYoVtgBGcGhWdtYGD3hzu/cp6MGYUOvXKC3+SgQ+PZv7/Im
         aNciGBWMuesIw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 04:15:15PM -0500, Bob Pearson wrote:
> This patch does following:
>   - Replace the rwlock used for pool->pool_lock by a spinlock.
>     Rwlock is a multi-reader single writer lock but there are
>     cases where a multi-writer lock is required, especially where
>     multiple objects can be created at the same time.

Not sure what a multi-write lock is, sounds scary

>   - Be more careful about type checking in pool APIs.
>     Originally each object used in rxe had a pool_entry struct as
>     the first member of it's struct. Since then about half have
>     it first and the other half have it later in the struct. The
>     pool APIs used void * as a hack to avoid type checking. This
>     patch changes the APIs so the pool_entry struct is position
>     independent. When used a parameter a macro is used to convert
>     the object pointer to the entry pointer. The offset of the entry
>     is stored for each pool and used to convert the entry address to
>     the object address.
>   - Provide locked and unlocked versions of the APIs.
>     The current code uses a lock in each API to allow atomic
>     updates to the pools. But some uses fail to work because they
>     combined multiple pool operations and expect them to be
>     atomic. As an example doing a lookup to see if a matching object
>     exists for a multicast group followed by a create of a new group
>     if it does not. By letting the caller take the pool lock and then
>     combine unlocked operations this problem is fixed.
>   - Replace calls to pool APIs with the typesafe versions.
>   - Replaced a few calls to pr_warn with pr_err_once.

This probably needs to be split up

Jason
