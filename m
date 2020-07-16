Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75A222C18
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgGPTpY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 15:45:24 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41841 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgGPTpX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 15:45:23 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10ae500000>; Fri, 17 Jul 2020 03:45:20 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 12:45:20 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 12:45:20 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 19:45:12 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 19:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5tNnlltlqbVKk99oph+d4vGPA1fAa0aizUZ11fFHvOsIBba/kF4kHp4jmpj5S1UFbpALEiY1RcjSmnQJo7/UORNvXfqcScHnzH4nAwGYzqI8ds5RJG5VPR3VXcxCKrOExL8hkL4RBy2x+vo1ogHe+VkmfOAXbWIdmIQknfUocPrGE1r3sZAXvyT//VFEDZEBSUmV2aZ8KpIUDSJTwrRBoubs9S+NhVQ7aPv2CBQW1P7VCcAqTXQ4uhT0Z6HcjMODhHL/r7ZFsLqobW4dGVIWdR5lZI8dtuAg2UPb/eyxNeAkZIBfT5p3JWjmQyvcEGx/dfhIIh3eutI78wZjTAX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amuUmcYSjEkLrBODBBJXXaxy85jISJHCLS/7b+A0HT8=;
 b=DQSichavn2s0kCYiUwRsoicBYMhxUrJ9TMll35ObotvaGRRYykNt87DBXjxitShYdp6ni6GBdY3mCGG5Oar8ibaF0WEVZP9ixQvicPggwXYg9r5E7krvP/lFjSxOMCfP1x8eZnAQgu6Rr1IUBU6+pVZIPpt4wr3kvhHzdsHq+ADEQccqBKdymBJXoPcdhOu5v11yGIPnpbeK/gm5QqtePfUrSpEkHze5ALRvpiXpDZE58XrDpk2eV8bfkA1r41yJeH3WWGzT5lboC2XUvjiL+Sp8xNoDcil0HDXuON9lfmGFKmRPDfLBhKh9OZZ0uRqO4Skzljuv0M8vHvJzvzsbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 19:45:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 19:45:09 +0000
Date:   Thu, 16 Jul 2020 16:45:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/include: Replace license text with SPDX
 tags
Message-ID: <20200716194507.GA2701568@nvidia.com>
References: <20200714053523.287522-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200714053523.287522-1-leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 19:45:09 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw9oZ-00BKpX-7q; Thu, 16 Jul 2020 16:45:07 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8597043d-b4b0-4da3-91a6-08d829c0bf60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265EE6DF5375F0B40061715C27F0@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOvhzW6W60SwCAjY5hv2lh52OR/QTuCIrDaxaH1oUyw8mdHhvOF31Q8Z1A1x6L9xp9q0UBKBE8E51kf0w8as1OcIHzXDMkev6rd28Z/91fDIOaC/S0ptM76Fqvy/qWYipT++Bd0OxAJZSzvjY3J6GbEZdcUowwlk6KUeIDIRCs5ZVLhyyePEh9O2uVXiTHdziYPeUkBK9UzXk71ivWUKuFi9bX3vmxyzOCJ01N2ceUsoXiG/+7Da9uKA1ZQHeGZu4gmfc/9emICsdr81kqGUCVc1f4tUNG1HLBoSFsLR9065YtByZtNstn5POFCVMj/14WOuor+hxWkrgTXwiPquZTrd3mY/3tJKJK1yPaO6hUEZRDtzrgs7XNMXpZ/p4Jls
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(426003)(54906003)(26005)(6916009)(33656002)(86362001)(8676002)(478600001)(1076003)(186003)(9786002)(66476007)(66946007)(66556008)(9746002)(8936002)(83380400001)(5660300002)(316002)(2906002)(2616005)(4326008)(36756003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j02GKJpv+ns4I08VH9mRK2y6YLbcev/KX3MBY5NEsywxTpU6pwHr3JjxqRPcN9TToZQgq79AZlsSaz6DiiXXvU8LAQ6hyqr/wL2TvyrfxSVm58SLC4atGOSqWnQpY4I0OL9IXtASWYuY8M/YyiT5kxwbtN0Wk2py2auwK7EMEUznF0SoPfMTVXQyToFuuy7hEwie9saobvjGNHaucOoX1HuJIMSWbH/khw8L/05pRF9jn9r+9syW0BjKHyTR1uEmn1dmNWBT+RoOXKX5h5rDb4MzZDY+3hLQqV7AK56fju46OcWwKORfraBHXbiv8bYGRYa1rv8hBo3M00QdwxpOAjxyoR50u3CqwY7TyblZXTjyDMmnphvMv6yUV+GG25HQ0er8fxd+sfcjnHPpfzamkil3VySNupP1hCJELhOtXO8Wi7vTT9+H8Mr3o/6MckVCMinX1CLlnXhqrL50DT75z7H2AesjEnCsgdbR3lB2X6VvQpVGzPYMIEbGRBv2x/rd
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597043d-b4b0-4da3-91a6-08d829c0bf60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 19:45:09.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rtQWuaMsWFYTWxK4NbNMPrKSnqOnd2Iub2OLmx7nrDCbP+zruHuKGB22TKuEbMy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594928720; bh=amuUmcYSjEkLrBODBBJXXaxy85jISJHCLS/7b+A0HT8=;
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
        b=fWiJ/vdkBwK5HB2hRQktjbAeNq0FI9HwWXxdQmTe7QLNj+p+m5TU54aMsdtHG8nHX
         Y/FaCOxjJyqM6C07cYU1F8sBLYy6p0GHXr72fjxXTY9MOeBSn8bMgUjvnVa79hAzwY
         WJn0nbKRB9P78O8jPIMhZA2NlrdhRIBa3YrHqbwQxYZebyLkQfuNBtEWKJMG/AyB9w
         h2+cLExmD1OMitHMuQ1wtVpzdCbzeFSgTw97gJAJt99H7Cl7UkTxt0LDOSPjIStX6c
         J3yZQQNQB8r7t71Y/5l4urdmJW0k5MxBjEogTONcQYdZ92IZKa3g/DCVeEpZMLG1wz
         vPeg0Yf3+SB8Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 08:35:23AM +0300, Leon Romanovsky wrote:
> diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
> index 9a90bd031e8c..03567e7c5c57 100644
> +++ b/include/rdma/ib_hdrs.h
> @@ -1,48 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>  /*
>   * Copyright(c) 2016 - 2018 Intel Corporation.
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * BSD LICENSE
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - *  - Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - *  - Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in
> - *    the documentation and/or other materials provided with the
> - *    distribution.
> - *  - Neither the name of Intel Corporation nor the names of its
> - *    contributors may be used to endorse or promote products derived
> - *    from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *

This text is not Linux-OpenIB. License changes can't be done blindly
only exact blocks of text can be replaced by SPDX.

Jason
