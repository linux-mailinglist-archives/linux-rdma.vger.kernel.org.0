Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078AA234A21
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgGaRRX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 13:17:23 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11304 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbgGaRRW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 13:17:22 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f24521f0001>; Sat, 01 Aug 2020 01:17:19 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 10:17:19 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 31 Jul 2020 10:17:19 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 17:17:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 17:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7QAfLxdX7P5+xUcqJ8FXfOXqPYEO77yRo2XsPYmTgmEKQEwjn5HF3mpJW8JBF+IoM8LYAhPhNUpdsndazoiZjwXDBn6GKI/Hf8hU6XqBMVgwEqPRubOOgPuVbtDBdsrity0GHrIh+aoiaa7sqFidFJnMAD9TlT8ugbGDBoygVtZFYuQJfo+xJFJE+smmqBA609dI8g65uDDQ1+eKQzcHYDuPD9DwpGpQcy0Z33JddQ+kHonAzqlKv5aU1vyz5ye6zOfmSnApY3EX5V+hBavOzFaD5k58/HdgWpMTaVzMLmH6H1vWUrb6PuGxunZKenrSr9KGswV/kMSjSkhWwpfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPLrHFtBhqt9YOPUoEM9CrMp9B/YMgkWI7XrLp5nzIQ=;
 b=IFgIBTOT7pWlS5a8BnSix2ddi/BmiEjCyAc2wzZNi2tk0rThAbvFiAW6XmSXK8HcCFR+XUnHGW+B9aOZBnogQK4aUOwsJlgm4kunY9TkJYfmsHnD/sYuaslybrs7z8cNU9JN6HJD9aaEA5IAk6nSMbfiqJt52aTens2DbdQvYJcXGsOqsFHyVu0sxJwVENRNPoOhkgkFrG83nQMd1JD1Y4292vGQ6ku0STvRZM8mQ8z6nEQ/PQqgs17pNwbeqCzge1Nhc2buVJbWeHC8oW87gVJ7xUgT4vfuNpRA7R7pf2uR7aqUbqU5g+kSL0sLTAETrc3Ci0U7VJLLQgQyUMCKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Fri, 31 Jul
 2020 17:17:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 17:17:16 +0000
Date:   Fri, 31 Jul 2020 14:17:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net] RDMA/umem: add a schedule point in ib_umem_get()
Message-ID: <20200731171714.GA513060@nvidia.com>
References: <20200730015755.1827498-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730015755.1827498-1-edumazet@google.com>
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:208:236::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Fri, 31 Jul 2020 17:17:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1Yeg-0029V4-PS; Fri, 31 Jul 2020 14:17:14 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c37747-04cb-4109-d2e8-08d835759295
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18831529C5D64B2649AD425CC24E0@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 726rlZySC90tiZIAcaLWqyO7gtd+lC3eT9Ib8rEgjcFSh8ubF7qPkXNAVRyeEmsBLS8FQQYyEoGp/xSjexdXek+yJuF0/JDT9INxmsNI32wt9zU8JnbFSag9vM91MLBUtoH8mJQKN71Y0d7mRht2WLe7/Nd8U4R5kzEuxcvkAPu7L7InsfxVoeEuz7f5N/0oFqdnsQhfArOdU1a//163MCQpbnoDNeW4J4ttbnH/PdpNucPF+OanOLo0tF4EGiPbuIHVh9UOjYyE1goGjhV4V8TAQXhGdVPx6VF6eWc0X6wM5L6dZvKW/PeimeXC/EbqmRuSi4tYSavu3ffymS6ribCvNe0TMYtMjY6dT3HX966iMPVVJoqKPPFOBx9FEha/RVDnL349ccd5E0ebBtUboLqA5nW6gHjpjQzqDV9g15A4TyEsl4mRBmgyGJgXqeuMMSP7qGqqRRNlRqXn2BaQHaAPewnNgpk+j8l9ggmuQn3BxnYVVDX2vJUqjd2WP6eMCa/QS7jV2q2fjtpl72MQCicBXTgEmlLCTWN4IWrpSefbKD4ffXjha3HWPZ/KzG+5CQcyxR1gvyXgFNYE7zbpVJKH+HACAIuO75/VnxMCK4JU8jUg6bWYziN2fOoiIyb863jHRcOQBHew8/gktVSDSBVD9+chPOIboaY6QFMR3FAyBMmPlWOk0FMW53V8ssqU0OH51de4WQVzHPxxBJhELg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(9786002)(478600001)(426003)(54906003)(4744005)(8676002)(66556008)(86362001)(9746002)(66946007)(8936002)(66476007)(316002)(4326008)(2906002)(5660300002)(26005)(186003)(36756003)(1076003)(83380400001)(33656002)(2616005)(6916009)(27376004)(557034004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: 5HPtbfnAE7apaSiZ6/NG9w71MjjVaXg0VIxjnV2/lrFnGV/CHZ1hbJnHG+Q+Gjb/+hqYbz+VkP6E0mzkjYnA0ABZOw6nLrBxFg4uEiKR1/oDuJu4doP6nReG7IW73CRZDKxaLeOxsNXiDMJUeeZ6JwL7sz1h+jesD8tBinmZXvqF/1qzv3jZ0/8vXCCLhHV2loC5gpDrcUvag6Hc+YzzeMOXDJVPVvY8CHSvUrwXx+i03HV687EsCiC152gFgfFQV+u6wkOAbvQnN6MtdlwuYws8eDLt8HWKRDOoT30nlVeKID7vCnAq9Qw/BJqE6qy/DcQcc++aZMzOVMTvohXRaN7PwOmNb/p52yuz6SLNVjKK8Qsk5sv/ssRnrZMRguvPExUhjk4Jf2Rybngy8/kSTAP4ldn2AnzuvQXbKn1dJVmaC5LChag4WiTZ7+jv2GbW8c7/4EeoBTBc0XoNv2A743yOBu7vm4uNm1QknRoS6sE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c37747-04cb-4109-d2e8-08d835759295
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 17:17:16.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqZqFTaoUAYodDKZXMaLa5738cJOqpBeA8QXyAA8DMwrcH4c03ny+N6FNEHilI4w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596215839; bh=jPLrHFtBhqt9YOPUoEM9CrMp9B/YMgkWI7XrLp5nzIQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
        b=epetb8du2f8fPwYJePl5p5iPzYaRfyu6cfU7toEurCmq/pIEYpnIeyUN2OFQQLGas
         V6SHMgCJSM9S9ACvMQ020vidslZwUrtk12E8CTf+5la7q1uDQhVDJ1pZtV6tkABNSf
         +bSEco2fTKUCF64rDrjK4MUchOaQxv7VWE/9JKDgRtFeeJbYYpcbKfm+24+qsSxCMG
         furbYoJADD/VG55HDQpah7OyHTktibHTlpgZi9axCHpT/+cH5Y36Yxug16vK1jploI
         q2Y7nRtyQd7PJuLgUK83q12sdbstf0rbVlezhfe+cehXtIz60Z9+gOZfPIEn0fL8ti
         anc0R3hBDmEQA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 29, 2020 at 06:57:55PM -0700, Eric Dumazet wrote:
> Mapping as little as 64GB can take more than 10 seconds,
> triggering issues on kernels with CONFIG_PREEMPT_NONE=y.
> 
> ib_umem_get() already splits the work in 2MB units on x86_64,
> adding a cond_resched() in the long-lasting loop is enough
> to solve the issue.
> 
> Note that sg_alloc_table() can still use more than 100 ms,
> which is also problematic. This might be addressed later
> in ib_umem_add_sg_table(), adding new blocks in sgl
> on demand.

I have seen some patches in progress to do exactly this, the
motivation is to reduce the memory consumption if a lot of pages are
combined.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/core/umem.c | 1 +
>  1 file changed, 1 insertion(+)

Why [PATCH net] ?

Anyhow, applied to rdma for-next

Thanks,
Jason
