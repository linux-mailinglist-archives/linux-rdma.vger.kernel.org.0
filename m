Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC322223AE7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jul 2020 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQL5F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jul 2020 07:57:05 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:38386 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgGQL5F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jul 2020 07:57:05 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f11920e0000>; Fri, 17 Jul 2020 19:57:02 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Jul 2020 04:57:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 17 Jul 2020 04:57:02 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Jul
 2020 11:57:02 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 17 Jul 2020 11:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8hvGhWht3JErzB9NxNP9ghpSHV4VOEZ4yOpyL1nassb8NG3WO9dhrCIg70L0/q0TVMIIcpv8OkDf3iKZJI4yOOOVhZA24orUqCp8bq1VDqPIM8haZ9099Q5yEO1ivBNQYYAasddjzU2ASL+jjzsHDZKvSGG69MJmdIIEB5FNZhRZZK8Np1zdtVtFrQHx6M91ag+q2yYHFJj01GAD3xA04XCOanxy8/FRt7Pi0oaUjaLzfoGpXPtxaHD0yIlI+zkUnC9pr4ciWGOd1G9ieHZsPU4WO1AQrxQLCjWKiKUWc5jdxWtL3tGu6HvqoZR+wQHypQ028WOm9hWFk4YJVOEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovxqzc6JA8deySYQpgjLL2ToGFRV64iRqvAULWV1ens=;
 b=FecHPhI0V8azNeR8hWmKt7P+ESi6seX1vfyoXKcSiigfoze4nWxg/IVoOvfu24PdxYu9DLlH8ZW4E6o4tNTUBuOY7RZnFaH3kAoHoyJ+Gi7h6XAzll9teABh17SHnC5WjxVdQllElZgO8bH6WyyFxSvZFY4awpn10+0UnczaLe6YOBclrVL3qE9ykUiEO/Y2J1vX/hl6XtkjJ+z96Z0rGiYiKL2UJstUcD1lUFYV4cMpbLMpT6gnZZPh14R02aLqlkZDkB79tgg+5yBEwmuMniQdfQZqHY8XeZ8d5wDTA0wnzJ5MfLzWe4RQKKsWEsDboEJS4TUYZZyaum7Z9SUdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 11:56:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 11:56:59 +0000
Date:   Fri, 17 Jul 2020 08:56:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/include: Replace license text with SPDX
 tags
Message-ID: <20200717115657.GE2021234@nvidia.com>
References: <20200714053523.287522-1-leon@kernel.org>
 <20200716194507.GA2701568@nvidia.com> <20200717060603.GE813631@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200717060603.GE813631@unreal>
X-ClientProxiedBy: BL0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:2d::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 11:56:58 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jwOz3-00BdvV-90; Fri, 17 Jul 2020 08:56:57 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972bfa11-f9a9-496a-9c3f-08d82a488260
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3836DBE32C6AD099DFC4573FC27C0@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wZc7bYhcF3zXwwIVqNrF7wKufM6KXoDuqjF6yoBZ1/AwRtsBzDvPJKGGGfH2/VJ6Qi2ZIxk9ty5vifcmOqu3s7mV0/tq/nRLLhMO9EKesL8ucda8z7pq4HV3Ps8fRtTEhudhFEjXVfe628DZtpmr3E12haljB+/hnadqMUz9OoE/lwuABsdd4n2eOJdn04F7pQpc82UtKsC81962zevL00GTOHrB1XIUe7g48crMYZSOin4IVwWPS3leZfgn+0sNKZB2CY0CuS+MLrVfA2sXwKsA5/m8taqB4q3eUQcEsOGlmLDEQxZzQIPDJG/6H93GiMZFdLF4M6PynVvq9wBYXu+jstXa69J0xbMl8toqFpqUb7EXtuGzZyVWLJULriW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66946007)(5660300002)(6916009)(2906002)(186003)(478600001)(26005)(86362001)(316002)(9786002)(66476007)(33656002)(8936002)(8676002)(2616005)(83380400001)(9746002)(426003)(36756003)(66556008)(1076003)(4326008)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WGVCi3aWtBoOhHWNHCsKWyKhYdspxnrjCpBeJIRa/jbHa1JrmS/uC5/VzOsIIkeH3bL4HYmEtnYYRjjDN/RBTp+f8DNkIdvyjiH9yEe3AG3K3AQ+PHJQOJLis+HlnYJu2ccADN6mmARKPKZAfwe4uDVySJUiT1UWnKW1Mx73NZSWPZiDFa37ElY5tzElWRVH996O7qSmvDEDAn9hUFNnQ5mvTz5zcYaaiFPRrvb21HvvcIQz5ldaIm/OiOzAkevoLb6Kd5NHlfXrVELSpyWL6hDEq663b/zK6dLyUXkwA+7IN7qrukOKP8cexa2fqMf6P+K9L5IE805fQ7wH8/fo1GuxBN3TA5iyWgfh051WEvEnUpliHf/+Hy4txoCUA6fM4GD2qZy5NpeGm/jU3AabtS+MfolsKO7Nrvn+6Fxgm769C8H1ONJ6mmM8SJqpTNmbQj0yzHx25vaWZEqIOiZA7j979gT6MwqSkGvr8Gn0xwo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 972bfa11-f9a9-496a-9c3f-08d82a488260
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 11:56:58.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqMS1gwc+46RTkr6YWmOgjU+iBRajOAQNiv99jqY93EnwPbgcjttgnk7D89apE13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594987022; bh=ovxqzc6JA8deySYQpgjLL2ToGFRV64iRqvAULWV1ens=;
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
        b=gd1qrAE1cwxpxiFn+AVat462rDM1lxMshzemzqcgMMZxBB9vLjB4bFaiOsTZ/ftci
         X3mwou14YlS2oPicHZJklKb3ygDJVXA0jM4gwaUB72FRT8AFCeXnKSzzfue7ozGU+q
         KmS/9S5dGwSxSKJ+RhS46ZNH5zm30DWZtbvBnRB3RjbcGBnJJJT/H+7teC2RI0b2Dh
         MCDgiGAJRUZ4HG7i3f6szP4711SOfLEHQc0Zg92XwjJ3HQ5qhF3s9r8VktbZurOjS3
         09vrPnF4KyvGm0Fw24kH2HK/wHnHZOYsueTHst65IznyNi3q9upIt4njgy3crM+iIz
         rZzeW1JafhUSQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 17, 2020 at 09:06:03AM +0300, Leon Romanovsky wrote:
> On Thu, Jul 16, 2020 at 04:45:07PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 14, 2020 at 08:35:23AM +0300, Leon Romanovsky wrote:
> > > diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
> > > index 9a90bd031e8c..03567e7c5c57 100644
> > > +++ b/include/rdma/ib_hdrs.h
> > > @@ -1,48 +1,6 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> > >  /*
> > >   * Copyright(c) 2016 - 2018 Intel Corporation.
> > > - *
> > > - * This file is provided under a dual BSD/GPLv2 license.  When using or
> > > - * redistributing this file, you may do so under either license.
> > > - *
> > > - * GPL LICENSE SUMMARY
> > > - *
> > > - * This program is free software; you can redistribute it and/or modify
> > > - * it under the terms of version 2 of the GNU General Public License as
> > > - * published by the Free Software Foundation.
> > > - *
> > > - * This program is distributed in the hope that it will be useful, but
> > > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > - * General Public License for more details.
> > > - *
> > > - * BSD LICENSE
> > > - *
> > > - * Redistribution and use in source and binary forms, with or without
> > > - * modification, are permitted provided that the following conditions
> > > - * are met:
> > > - *
> > > - *  - Redistributions of source code must retain the above copyright
> > > - *    notice, this list of conditions and the following disclaimer.
> > > - *  - Redistributions in binary form must reproduce the above copyright
> > > - *    notice, this list of conditions and the following disclaimer in
> > > - *    the documentation and/or other materials provided with the
> > > - *    distribution.
> > > - *  - Neither the name of Intel Corporation nor the names of its
> > > - *    contributors may be used to endorse or promote products derived
> > > - *    from this software without specific prior written permission.
> > > - *
> > > - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > > - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > > - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > > - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > > - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > > - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > > - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > > - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > > - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > > - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > > - *
> >
> > This text is not Linux-OpenIB. License changes can't be done blindly
> > only exact blocks of text can be replaced by SPDX.
> 
> Do you know why it is not OpenIB?

Intel's preference, most of their licenses are different

> Can we relicense it?

No

> The difference between BSD and OpenIB is only in MIT disclaimer,
> which is very logical addition to me.

Doesn't matter, it needs to use the SPDX tag that matches the text
exactly

Jason
