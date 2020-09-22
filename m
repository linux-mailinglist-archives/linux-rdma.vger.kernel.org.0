Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531CD274D3B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIVXVh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 19:21:37 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:59284 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXVh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 19:21:37 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a86fe0000>; Wed, 23 Sep 2020 07:21:34 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:21:34 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 23:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG5qkMbrwQCKxLfLfq9S14ZviR8NDGHW5LWH7eUeioBezou3jg98UBdB+5ix31w/J5VfJ6mYs+yyXdLaEPmmcMAsouurRoDsaux8Tg1pi4uWghhFJ7IWg8Dw2EYK4g4ts2ru2M9y3Pt/kAmM+swi3/LuZiLQuCBhTOSjbmL55jTrN4fuPyesZVQhQRBZKR6FcSWKE1/VtpRLa3sDPdTqIm78gNjKo0IE1uNqqKT5rwQbhlWIRECrMJn9iyZFw1KoUoAmdfLk0cNc9tPP5FQtDNutVN5Skg5/a/u01LWZDJXzPkQCWt2zcSQpLPPDZaPKHJyzUMFcZGDxoRYdSE+sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yGmz+VbDCiYyny/XnJ3gP8NDzyOgAZ0IZEOCBtdVVM=;
 b=ZkiGHH+TaVG/Xfn66ZVyXZp+ROQCC/OwfChFLU4ADVRHa4oXCnd1NBbxxrMQvAVmcbycbv0AXPHq9Cg02mcT+/Sf7jHv91/yC6Du72uG0dYJQi7buC/y73c1bZaWEkOmnDdc00SKpL/FKK8BA/lrBOkXNdqau2X98iRMI4tqmOE+hH0Mea8QhngI78n0X63qA+drAM7dlMmHPJ7tgXum7vbPKROjbM2UltxlW1teJQ/zDiMGcdZzxuCYH/Crfwp1Yx53MQZo9lwmb5Ihe2iO7UKQ4az2bfE1lO1gdPGXaM/vAptRfhxtfjTLIxzp9eCHW8HqBYZkpKPhr+o89ZWcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Tue, 22 Sep
 2020 23:21:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:21:31 +0000
Date:   Tue, 22 Sep 2020 20:21:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/2] EFA messages & RDMA read statistics
Message-ID: <20200922232129.GA801952@nvidia.com>
References: <20200915141449.8428-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200915141449.8428-1-galpress@amazon.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:208:23c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 23:21:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKrbF-003MeP-JE; Tue, 22 Sep 2020 20:21:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5aade7d-9e24-4c58-bcd3-08d85f4e3cea
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43880F68B7F9B46FFD6F7758C23B0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZNs3oc1g3F8GB5mFtmI8uwxhFfgtIcEXGRqC9wUTnEHu0xJE65Vuqxu9fg9ynytv6OI9T+qyNLzPHIRLpOOy+uLwvOeCmXrrW08LMSbxJUpHEqAYwbSfJTrd1x5C608rdxjmv1nVH8nDfN8XuL9B2pi+xptPA71XsMR2NuLM9ddvOgOe1Vg+VtHUpD5tRLjvVqf5VuaiNG+JfHlEjpLPb6/NodYiZgUmh3DlHVK9RQW2xnm1r0yjColn+GWP0NhxtQPyqszeVprTShPLyd1jtF5prBnYldvsSb0Of/BANUAW8CG0fqYSIBLFKmF+j8HcS73BzWEYBp3nJTZgMAoBwbqzsDYvOWFlbv5jknk3vw8xtMfihJPeoSi8jfOXxQU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(5660300002)(1076003)(66476007)(66556008)(86362001)(4744005)(66946007)(6916009)(2616005)(426003)(478600001)(316002)(4326008)(9786002)(15650500001)(33656002)(9746002)(36756003)(54906003)(2906002)(83380400001)(8936002)(186003)(8676002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FI5QuwxWt9AbbIMkjfwmg3UXQw5sV1fb8O1QtUIriV3lfx3f7CDmEnjZtUUzC2ZAsv31bEdB6k1cOX4JUVTO0M57akO1gdmz6H2S2qPCc6sy+EymF3LvJLRsZgRn7NunCeE5lne+4Re/2XHl1e+RS59SgOhdGqNmDLG241+A/C/IPgZgukWRMgAN6bYmuWWb7fRjOQICt+31JQye1uCwgsnWriQk6Ijf+V6tDVtOl000anBPP6osnGo9vcJPdWY2mZV0KB55YfSiflE4o+PzCXUaSR9bqXgoDNTbByrEJu1QuaPzlMGzqWicLpxWu9LRngn0QHig6SvaaJjSGANPAstefvByVU/ZocorMPYO0+h41MRZ6q58D846XIxAAbq/t37fzRia3AN6Ox4b1nof6NPLa4UYqYcQX31T4HoYUME/ivavHzEHJvvIWqhzlN+iJAA0zB5/M5UUy4YdOynOw7Qy5haZ3LJrTf1qCAQhqYN2zKLHeHcip9tPF3RrpNM9TsGVQ49fn7vOt6XkDkLUn+vbrd/1Q5CJ9gK6vuzoARAeF3T7R9h3akBttQ8FfMXjXqe1fLvqDXUKNDBzN4m/2wDaxTYWXlwF5aTBOKPq6bDXxJRCUb/tBhrtf4Hm1o4hY2aA8Yk/1DR3BpoiBcQn8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aade7d-9e24-4c58-bcd3-08d85f4e3cea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:21:31.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvbeivfbUVzPHqd+HnNwZe62YysnzyJcD/tdYpRiUjCHtia0kP4PIRVxycLNF7gq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600816894; bh=+yGmz+VbDCiYyny/XnJ3gP8NDzyOgAZ0IZEOCBtdVVM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=WZ172in1je4n6Rt/t8kKVQAJQIrzmw1Fn/TbtjlWDH4VeoDL4MmgyNghCHL6FrIrc
         +8f4ztmBU8SgsbBAilXEkWJlAKmwEr3s3xGEYr0DD4MF7bDYfW9WQGrm0JYic6/4u0
         Em673zWR53jnQDjIuNzSmkvhiG9rPkjw6oC3tBozWLSyj714PZtgBfQtrqnep8/LoE
         DBcpnEnY1GLM4bAjgt5InQEIAosb57FiFuT0CcJeZdMfW2wlOR4zBJcKarvcOJurvn
         DkCKCRrFSg6ONm3pD+0IhXOV7n2Qh77xPbW6oHymvHjASaCIFnPrnQKEnUVDyuJj5s
         S7+RaCt7O/drA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 05:14:47PM +0300, Gal Pressman wrote:
> Hi all,
> 
> This small series contains a small cleanup to the way we store our
> statistics and exposes a new set of counters.
> The new exposed counters report send/receive work requests counters and
> RDMA read work requests counters.
> 
> Regards,
> Gal
> 
> Daniel Kranzdorf (1):
>   RDMA/efa: Add messages and RDMA read work requests HW stats
> 
> Gal Pressman (1):
>   RDMA/efa: Group keep alive received counter with other SW stats
> 
>  drivers/infiniband/hw/efa/efa.h               |  8 +--
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 30 ++++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       | 26 ++++++--
>  drivers/infiniband/hw/efa/efa_com_cmd.h       | 16 +++++
>  drivers/infiniband/hw/efa/efa_verbs.c         | 65 ++++++++++++++-----
>  5 files changed, 117 insertions(+), 28 deletions(-)

Applied to for-next, thanks

Jason
