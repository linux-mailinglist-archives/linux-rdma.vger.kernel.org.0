Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F726FF95
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIROLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:11:33 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14093 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 10:11:33 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64c0080001>; Fri, 18 Sep 2020 07:11:20 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 14:11:29 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 14:11:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdP+Ib3LK9Ts7+Rp49WemRRu0yiHP7SN9hVaBuREgnZgZzo3puSBtbsWRPU7E6iAcQEemWWdJ9b609ibPZWB654lvKRldEtuOSY1O9eEIl7bG6bpOgHBEodc320A9rJHyECsDrAUbldQz6lkuWJmWXBJoJKeNDe1V9086ucdxS9sqrnmHWxdkIf/86HBXGHGOjO+aThv+ReLPgL2QkupD/sUndJfBHS4we48DX4gJaqQ3b9I313K0TqSjLOyJm0s672YQPJDtfAACX32mHtVefMJHhwCpzYCyXjAQmcEnk8LigDHKFa2Ygwmg9MiCHizDAXb/9Q6DpjMrgNhe7HLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dizmrtLuCbgL2vGtlQLYUssS+yi00Ykpr5LzNd+4xA=;
 b=LKpaXxqopzk5UgOgqirirhFrU4NZr7+8bMkxGVyAROcvpLZtXvE/zIpuKUxW9qw3Plr6TtYUAEo/OSezi0I88vt/+9JH15QZX7lLl2wCUo903SghRJ0PKmLUxgJgzw/9NUqjWyirlhebFKt6tpAHTJOh/jOUdzT+5YZmk6FZon/D/VqI0E7Ff0R/KRcF9Q06fScvyFbsDdY+V3RbHQjKocigguJnULNc/B8+99+NqIQpZMw5jAQsV1/k9Fp8qHdXlEIEtE1CGgA3sXEVlnLKIMobnlACHvjHKK6gI6HNzSzcsHrR9aGBylr67dORNa2x5cD0w8QnLJaluRryY9QwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 14:11:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 14:11:28 +0000
Date:   Fri, 18 Sep 2020 11:11:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 5/9] RDMA/hns: Add check for the validity of
 sl configuration
Message-ID: <20200918141126.GC305257@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-6-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-6-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:208:178::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 14:11:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJH6k-001HU1-Ks; Fri, 18 Sep 2020 11:11:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9edba8e-dd6c-45ec-f10c-08d85bdcbc13
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739B0AE0A65B84225C15A6BC23F0@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnmJP2jWH971AdlJkEYh1QsiVHvguIKRQQ67IFdP5YPzZ3t+uV5jNWVl04YRm6txK40mZkdBb3OVnlfm0NPf8bEB5SlewuBw63VLldlsNb6TeVjj9QF2nVtSRJe4hiw7SKOh3gQ2eItWoruR9cyZgZ+AqijhBcw6orzh+/QS6ufztw5ZPwm4QlIO2ALDwLpF9EX92haXT0H4vbe6FOOG3Otp7H9+L7I8lBW0cwf05jPHV9Ans+gqoR8l682Jbp8VH/TiAs6A439MD1oZ1inUAG8cWjbjKBUQdQQ9QvAPpe6dTZJyA2xD2s2ggplgw5DG+1ge2HGRGmVKvb0Eugzb/fAVabu0jPLw9KReR7SwjCfdBCNiBMtSoQ+PhdxhjVsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(2616005)(86362001)(6916009)(478600001)(426003)(4326008)(36756003)(26005)(316002)(8676002)(2906002)(1076003)(4744005)(33656002)(186003)(83380400001)(9746002)(66476007)(66946007)(8936002)(9786002)(66556008)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Rkem38Pb1+t/+wJ9pXLR1DfHqcoQFXjRttRaqtvzd7O3S6DBfrC6myut+kd4bgOqsnJhj03RhQrN5sEWmEIaQqNuIyLKGDNodcWzblfcJ0cQ+CjRlmkQmGpa42mX3J1gCxgUZN++eBUYZRmfL+2mpBSLpjdmafPI+J1/Lc+BlDFi1RzyYuSDiWfKI29T+HLUDb/GS+fqwVbkXik1RNzEPPlSR2KTIbCsGCqzhoZIQM1YLFZmvWMjcSos+LM5yr8eNX8NAXGjBIvImHIv+4UD1q8BbeGjDZIJT8hIgARMNR80rUrTLUBFFughpzT9lX4PgHXNRlHp/rssaTAr7FFwHmGWMEQAvobtV6evS6IqZd0L9loRA6I5+U4LX/lYZ00NJkUmpxHbuskdWTFZX0z8XM6Mwri2JUli82bC+EPARjt+5HjPDbtU8oCVyVcDzVOd+kD35L8Q3f1mRF0oSmZc1oNV00DZM0Mw2cGSXH5sdaSmJqIZBP4iKw69+xwSKFPWKDKTc9NxH4TGKjyuSRmbrV0ROOKXTV1fhJdoZ+pVzxal9XtmxGXo3UwVhKc4Uh5RMWgr9/paGmocI2NJuuxgvBUwA/PgOJUN09VYO4FVrfINvgrSOXSZ3nGwyiwvCJdA0aY2+UX3/imaSiw8nNl4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9edba8e-dd6c-45ec-f10c-08d85bdcbc13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:11:28.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFs0OTaa1B5EkADppIr69gp5YskLWWGTAbltnE62wl1FLnxJvMajalkuB5f7o62H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600438280; bh=3dizmrtLuCbgL2vGtlQLYUssS+yi00Ykpr5LzNd+4xA=;
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
        b=mCYN4hK6DAW3UovNxB9mJ7jAg9+yyAn9IiHxEeuxfZmZva1U5IqH2p8kQNabRiS30
         CwCI4/vAeIYPK/pEzIm8WkXFO/IIy43tJLr/PBo6ghnJjLjYVLUXicS6fmVJh52TxH
         FTAOZBZ2hrCkYEI2UetyNRdSpBtlH6lB2ekxOxiQxMW4u/AkDjYHRwnL2mF7V8gIHL
         wag+fZGcXKmFIU3MbH57HlUIDA9EkhCcWEhsh6dHG5l8BfJ0tslg5ru1tXMJi+1qGV
         /vrLl//OCsYeU6gDeaGDRu7Wfu+GOC2+Z5oIebw4JydTqJo/rToCKo1QA1zScGGiZp
         gZ5N0KCa7hKCQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:30PM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> According to the RoCE v1 specification, the sl (service level) 0-7 are
> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
> driver should verify whether the the value of sl is larger than 7, if so,
> an exception should be returned.
> 
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)

Missing fixes line

Jason
