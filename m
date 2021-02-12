Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F731A1EB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBLPlR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 10:41:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10665 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBLPlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 10:41:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026a1710000>; Fri, 12 Feb 2021 07:40:33 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 15:40:33 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 15:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQd4GN2SXn/kLN5R0/SpeHYnRZqh0X5roKxAubIXjDatf+B70CIlv1KTC3ZntW1jEBwUjInPcu4b2vGFa2x9LUkJox9ARr3sqmzit+fwDrCFohCIN75/65Ip3FULepk3rM2vAf++SlPUP9m+5Bkd1RzL/HuKgDHkY625pcQGs7+q5I53s82j7efpuCcMbpuR9RDpsdUeIS5LnphjAVEmZUgURsRFUmMpo4dDUmYyGxdildWufpkufulQQw03l0whTOyvLTOpZUmU49fRhYSPyDkYuX1ZrO/dfU2ZctlgmJ7ogh9pX0RpiAkk6ZHe7bYXsi0meXTSNaXdnf42kzGykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6Sw8BcfiOwEzz71R78d3mm0lSEPgFVUuByY34o4mrg=;
 b=X1jv7fGjM7MBJSR4y96Nl1lI5HaPLbH/OU3HqiBlMedV1OGDbmAqHbncWfwlr1zqalpJvJTG0Zqx7t4Y+wky31grnN77CCA7K7BZyFHOpgPlE6pvkUoQe7rUzK6j4QycSFiixuKlqe8+Ci53Hc2Ix1J2xp7D2HHGfN2xFQWnt6V1A27f/qFJ5mTXOaxJOXZV7uxxH9+EIWSwoTT4q66YdVFfwL0yyprOgoob5fTCecM8Xla+WW1FlHtadZIgnEgreAyWmx9dEjsaz9CmQ2vnhJTpyZ8r70kegcmnEHBxcMdS5FfjzUtu6kVidophAEoy9Iy3N0OU4gG5ip7luRHlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 12 Feb
 2021 15:40:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 15:40:32 +0000
Date:   Fri, 12 Feb 2021 11:40:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 0/4] A few bugfix for RTRS
Message-ID: <20210212154030.GC1716976@nvidia.com>
References: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0056.namprd03.prod.outlook.com (2603:10b6:208:32d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 15:40:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAaYY-007Cju-Fh; Fri, 12 Feb 2021 11:40:30 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613144433; bh=N6Sw8BcfiOwEzz71R78d3mm0lSEPgFVUuByY34o4mrg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=lCYIhXxEJ6RLJLbw9ptYGuQ6UwzDDZvp96HrBWzXH3+KlfBjwbZx+jQR1I+jTC2uN
         pu9UrioPahfIM4Om7d2yFLuGs5/hmi6xfpZm4bbpsc+C8dyZAlQlzk7Xj5YWp+LPxS
         qPVFY1GrMh0nsh3EZPcVwvGE/tJ9NtG2/MT5CSarVz+/fx4DIkhNLqPHseOsbaYLaH
         YZDNMjoAGNwUSnJx9MdpvUtzytB3uobZOmcghA/Ee/4/9ifk/rQijpdWCZLlrIyWAD
         UaGov6v3O3G9WZlV83Fspo4/skawRssYh2SbFUwiFrEIqy8sdLSMIPwCZZN1ISuXf/
         qrxnaJ+lb62gg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 12, 2021 at 02:45:21PM +0100, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include follwing bugfix to next release.
> 
> One bugfix for KASAN splat due to we use wrong structure type when send
> RDMA_WRITE_WITH_IMM opcode from me.
> 
> One bugfix for allowing addition of random path to exsition session from Haris.
> 
> 2 bugfix for memory leak from Gioh.
> 
> v2->v1:
> - collect reviewed-by from Leon for patch1 and patch4.
> - adjust patch2 as suggested by Leon, also add missing mutex_unlock before
>   return and misc cleanup. 
> 
> Thanks!
> Jack Wang
> 
> Gioh Kim (2):
>   RDMA/rtrs-srv: fix memory leak by missing kobject free
>   RDMA/rtrs-srv-sysfs: fix missing put_device
> 
> Jack Wang (1):
>   RDMA/rtrs-srv: Fix BUG: KASAN: stack-out-of-bounds
> 
> Md Haris Iqbal (1):
>   RDMA/rtrs: Only allow addition of path to an already established
>     session

Applied to for-next, thanks

Jason
