Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC7274D34
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVXUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 19:20:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:62538 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXUR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 19:20:17 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a86af0000>; Wed, 23 Sep 2020 07:20:15 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:20:15 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 23:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+RC9TRwJM209o3SEVxl9taMNvd492FYwCayy/wnqPyR+rRvP/u4ZEvH7vYhgGyqC1Wch9EFJ9qwt2QcLn0oQPxRB4X7bHSAD7x4FJ+8ACbiYqayYVmEnmOLrAtcM4lJHBPoFi/4OakdUpYNMJrY04Gn9d8o2Nx9uCFMvfeBvP7vLADsICxgunfGXqq5eAZhuPAnrEByjJv8oA5HV7MjHQ1hGF9pKCKYwU0o5Y+6D1YfvEy5vMCeIGbiHxDmyi08fPYVhEGk89yT72ihHx/h7jikrs5VxlBcJjVI+v/Qb9Rjb3A+cscFVV+NIGTTY7rkB9/jGd+5b4GeRR9gNb3YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny6EGvye4dr/Am6N7SUBvdm2qkxAZ24nQ2EXQxgj59A=;
 b=N5FtJPi9UjUQjDD2sjLFxTr7rxO3RLGF0q/0DRlw28PzT0AExYfRNWMbuKnAw4tIYzEWolyBHlStsNVLrVXsFsuj/J/BOBodRJWfQpcIV0LVYmHTwfR9pi8bMkQLpyDryjbO4Z8TYXDzOJ0ZT9OUEB3HpYq248Izbqa0bnfAdK2xq9qadmHGIqMw4gKfFvBbc4zOR0EtDKO/zPFwRpOMrD7l8akOS6hJjEPWRucDBw2jJ7pDx6NEZ7A4LbHUHRlJOOjtWGyNWrjvngCNf3HnH9wxE/S+6Clkk7E8Ds/QqKSf4brYeOo5EUHQRHI6DbN91Q6HPMrLfN01ncZvwvt2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Tue, 22 Sep
 2020 23:20:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:20:11 +0000
Date:   Tue, 22 Sep 2020 20:20:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 0/5] Cleanup restrack code
Message-ID: <20200922232008.GA798263@nvidia.com>
References: <20200922091106.2152715-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922091106.2152715-1-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:208:236::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.19 via Frontend Transport; Tue, 22 Sep 2020 23:20:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKrZw-003LgG-PO; Tue, 22 Sep 2020 20:20:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335f199c-653c-435b-7a06-08d85f4e0cdd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812CDA5B5EA4D45DB8CF4E1C23B0@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AphEu99TQ0n3/Gg6oUe39G1j6ogRz+rRRo5oRiPbxkILGR8utzyu2pd8BpPIp8mygUFY3llAzY1yAyYgm2XXg+a1ZcpHBGVKaZ4oguxUgsMjd7nIpV5CKDpu78AgWhfY9WAk3qcsWhoCPTkat3N6FR9SWEjX3WQ0vbSGKrhfV8xKxELaXEtIttAKEXw9C1Ws4d3M5J+mBX7eDaNYwMyOcySi6hMirj2OixjzIgQu0EdZD0DUREERA0Ogf7utxGiTsAxtcJ3vTTSNt8pWau225nKCIQ8ywkyRKAjNmcSMitjbkZF4psuqPbAGT3HorITAnw6R+CLl/RmAPJb542q0MzYNn9RImsNGyWcN5uXR5ZqvO7KLHq+5L3Afd3Ryucc3gugvJXkvxjnI5rHzqiUj7EgEws8mOyjJm7W2HOHhvoJmHuFuMPxDtpcR04b15tjscypL4lKNOT48FibOpAG4pR3GLrdRkORZW2GSkf8uek7wwUGv2fi9GUa5TY20pDnU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(66946007)(33656002)(9746002)(478600001)(5660300002)(426003)(186003)(9786002)(26005)(107886003)(8936002)(36756003)(4326008)(316002)(2616005)(83380400001)(8676002)(66476007)(86362001)(2906002)(66556008)(6916009)(1076003)(54906003)(966005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ie4AdwDD7isGc6zyPIpK6eWjg2S9r2nDqxLxu9tNRQ8YEsAaLi03WLJVn6aiBsZ1s5C+me1r4MHYpr+fn9rCZo+1SDnltumeZ/35rhlf9M2aTILv8VgFJwZlxWJql5MS2BlZcIvkpcPcS+6kurX8G3P9Gm+lFPIqPy8UeFcCOooi5AXegOy6oCUnujVSC7s8AfOrPnn5P1BWPH7tkKSSf2l+kdn+eBuP3WETGEG1dqG4Zr3FAPJSUwcdlN/qnmS0Toxl1qVJqEgNXKrJsq4gKWnh3L5MQFYCF9sAtW123gliih2J+05PGhsQnezpbtAg854OMoR3GzLiFS26qB3EsZsy2xbuRkus9H1nbwyXVcte/dwXEaajwLW+x7bn+z5EzuR5pihRLtyQ9paYp+R/hBXoed2l+KL5GgERfZvLJ1sTr80sVADcyD/UfeBDzN7ClK7cOpsJab0upkYwkEuWnN2bezKxEdr7d3/YGXnsx7idAxcHX7wlkf23FYRrVg/qaqZPQ9fyi57PYeeM5H+ciovn30zmi5N9qTAo5hW5SEHzyAh1k+PYCRpoF0NY+5GqZ1BHaAZVhm+22SaLJdN7uJAqtaWQUpw5NQ9UCXPkKq7wEu6hzo5ofwsVJ8VctCWXqKy4VR8RgfsDt9MTdjyfdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 335f199c-653c-435b-7a06-08d85f4e0cdd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:20:11.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/t4f7Qj/c5MbhIxuTbCYi71ZB8wX1/iVkL9+oVna5BDHabjgV/IlmemVrTfa1RA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600816815; bh=ny6EGvye4dr/Am6N7SUBvdm2qkxAZ24nQ2EXQxgj59A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=c46Z6f/JnK0ftLNRTaalbu+jdVn+jFUE+znEjMBv6HAA+FQxHK8nm+FNGz5/Ovjit
         v0ymMSNwf3xX6TJGj7mGdPAcOzil4ugeXgdH+An6KkpD324ikGprFBmvj9trwDdLLi
         510eIOankegJDybNKTOEEgSUilJ9UvZK98AS+wcDkAxmd0oQWP6k/k0djOblHzMOoA
         FwCEajSQtUk+Zsdba4ljMmSp06vu832ZQeHVlWAXfCk7IzJRx0KQVqhtOZxiLhixiW
         iiOtgOKXQ/j1aVJITC8JUrKJkColixGEPuckTV5CakbhNQCt9vXtM1Pe6TuCZEYMt1
         iIPQE3zJcT64A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 12:11:01PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v3:
>  * Removed the mlx4 SR-IOV patch in favour of more robust fix that not needed in
>    this series.
>  * Cut the eroginal series to already reviewed and standalone patches.
> v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-1-leon@kernel.org/
>  * Added new patch to fix mlx4 failure on SR-IOV, it didn't have port set.
>  * Changed "RDMA/cma: Delete from restrack DB after successful destroy" patch.
> v1:
>  * Fixed rebase error, deleted second assignment of qp_type.
>  * Rebased code on latests rdma-next, the changes in cma.c caused to change
>    in patch "RDMA/cma: Delete from restrack DB after successful destroy".
>  * Dropped patch of port assignment, it is already done as part of this
>    series.
>  * I didn't add @calller description, regular users should not use _named() funciton.
>  * https://lore.kernel.org/lkml/20200830101436.108487-1-leon@kernel.org
> v0: https://lore.kernel.org/lkml/20200824104415.1090901-1-leon@kernel.org
> 
> 
> Leon Romanovsky (5):
>   RDMA/cma: Delete from restrack DB after successful destroy
>   RDMA/mlx5: Don't call to restrack recursively
>   RDMA/restrack: Count references to the verbs objects
>   RDMA/restrack: Simplify restrack tracking in kernel flows
>   RDMA/restrack: Improve readability in task name management

Applied to for-next, thanks

Jason
