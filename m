Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4492FEC55
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbhAUNwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 08:52:47 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13364 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbhAUNwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 08:52:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600986f30000>; Thu, 21 Jan 2021 05:51:47 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 13:51:46 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 13:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgwoEfaQF4NE70StblEVmC48DRRAC1jHmuNadKpr36k1cCohUdQ6blzOXxyfDGOA4vCBpZ4eg05t+UAldO21lYoSaPdZX3YEM0s2Gm4EdVtLrrOMDPi+ClLlJLMTNaT+vqTQBxiKxZCn6Zejdb6tHRmsCq9b/OSCyqJkuqaZzkzG0c672QSYFPaX05HWzkpl5lvNT4+tYOpNbDTBgS0G1z8nOoGH96p6KY+cQuwyaGq5GFDzo/FWM4OR51ggWJzQ7OycvZPjYLiZeucr+pfQ026Dm/zxOEP3eYtjPW7hl6AhJhyuUuvDXm5AiW5uMJix3L6nh3HeWiKymK7sCB+x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAcLHAvcGKqXW9Mrf54v7UbYz/6agvxAw6vGWQcsmHE=;
 b=cPilrkTBmG3QvIrwMUdPnoGOmP5bYKXZRQX9lLsPsnwBNWZaP0di/Ge1a+arFrCf5CUKgMJCMsehgujTIsjcrBYDBZz1NwlcVxwTL2SQn4HiXonzo/4fqwMr1Kvh1191/Jgb8tspmDpewjDqxAtsmRMcRAgN9uh+U/XgaFCU/IEWPc3kME16i/QTNA6UmYHJkI9xMwWoPKkndhdYOu2wrymxGlwqU1hPQNeMd7eN1Tdh2BzvnJAE/xjKPJDZNTEN/+Dk9VnLcv9Dnrg1LI6thkjfyUJ36UZvru9zv0VVUEbSTUdhL8PS4MJI2d2m4ojrLgZqtvxsEcy+RYhKpL0zJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 13:51:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 13:51:45 +0000
Date:   Thu, 21 Jan 2021 09:51:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Message-ID: <20210121135143.GZ4147@nvidia.com>
References: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
 <1610706138-4219-2-git-send-email-liweihang@huawei.com>
 <20210120081025.GA225873@unreal>
 <8d255812177a4f53becd3c912d00c528@huawei.com>
 <20210121085325.GC320304@unreal>
 <96d7fb7db36e4bce8c556d0de5c8f961@huawei.com>
 <20210121133445.GY4147@nvidia.com>
 <14243f680ba6428789b878078f766967@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14243f680ba6428789b878078f766967@huawei.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Thu, 21 Jan 2021 13:51:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2aND-0051l0-ON; Thu, 21 Jan 2021 09:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611237107; bh=dAcLHAvcGKqXW9Mrf54v7UbYz/6agvxAw6vGWQcsmHE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oujH3TYwPLVl6APoRcRQ1+X1NdTWKukbN+mbUUs/VEBQnaiYUiG4RgtZIbXg6r+b0
         w1ebPTa+WzpP419ZOBiPG9t3VrUfpdKccvdeLbGxJN73MYxQ2pmr1DNC+18IIMiKsN
         qtPMTpXCC7nYTcX8nZSkfgpQR5MWf54AlC/snBtXB3UyXlfy61Xj9tHCnpnRw9T1P0
         PslVGgsE9EjCjYKbtlhZ1xsFuy3d22ECFAMj5I45tj5pQZnjAyppgrEiq0IcGw1G7T
         f/G5QbLhljpfACEaxIqpO3QA/60plqRuzqwlWm9KYPar6HpcQSsF8aVVLMFrA8xF23
         hUcnsmG2/Szew==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 01:48:56PM +0000, liweihang wrote:
> On 2021/1/21 21:36, Jason Gunthorpe wrote:
> > On Thu, Jan 21, 2021 at 01:33:42PM +0000, liweihang wrote:
> > 
> >> We need to allocate memory while spin_lock is hold, how about using GFP_KERNEL or
> >> GFP_NOWAIT?
> > 
> > You should try hard not to do that. Convert he spinlock to a mutex,
> > for instance.
> > 
> > Jason
> > 
> 
> But what if some kernel users call ib_post_send() when holding a spinlock?

I doubt extensions like this would be part of kernel verbs..

Does any ULP call ib_post_send under lock? I'm not sure that is valid.

Jason
