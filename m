Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AF26FF1B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRNtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 09:49:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10961 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRNtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 09:49:41 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64bae70002>; Fri, 18 Sep 2020 06:49:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 13:49:38 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 13:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKIPAQKxhITEh8FUO4d2Gwkxpi5AS9lGPriXQdIF94Mjtu6WcySlNx62aEdZkXZEVcg+YWMhFJFEnXQrg3gmpUb7l2M77o1jY9SmvT6kO6nLsKsdDKA2gCk8TCkPk56uQtDfUW6/FmiP8dgu+bDhju8UqO7o4dauZNu4op6nv4V11Il9TfPg+gkT60t+RTQTy2n8V290Vp7u2EM9COOvrR6uituGGrNhGNEJ4yKq0vfM4Kpp396rNqNIDcgErZ9LiMKhA5hu4B/Vf0mfcwuLnYf4AkRZu6H2uFSh0hN0apS4ioKXPIddQRX8vglrSmFNxWj+8m+f/aTwc3b7WU8Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyTIIs9W7t2+IzY6vqMIwVOXTzPv6CIMnjc27jlkR10=;
 b=WE9yTWYp6NoA9muLRxkIH4kEAhByqbRG7s7PfwT+BmOiRuK5lqE9OS1Act5rY+4K+WKIhLIjEfrcCIyD21peSLkw/grnuGRWjlj62dDArpb1KSiqKoH6DYl/D7i6QfdRQES/kz3LfyblPlM/FiM8jmSjozS8ZOXbERz1L6Rm21oF5IIxkOhhcryBFnN0ViSbSf/AsoYlkk+4RlfJLkvc7PO2a1Xii8GfxE+jskbzRMMDLYS1+Z0suggpuFAlWO9tKB6YiwrEuqOVLt/KQlU1G0O2x9Gz3u7K08COmDey9auIG36+RNolpek511ru9yjhViBa+mTKNp5CZK6V1ow0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 13:49:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 13:49:37 +0000
Date:   Fri, 18 Sep 2020 10:49:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 2/9] RDMA/hns: Add type check in get/set hw
 field
Message-ID: <20200918134935.GA304147@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-3-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 13:49:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJGlb-001H96-LE; Fri, 18 Sep 2020 10:49:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c21d9a5-0447-4b19-a0eb-08d85bd9aeaa
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32106BF29FA5F5D6849FCCB4C23F0@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otGUScrz/KFM1ipAp/4xQqvt5BEBFvyFjr7Kh1bxbUWxVVOB48hsxghtK2Y8Wdvp6EGjQzmeLpRMrgfVdy0XjSZavUdNBrpb1saZFYNnufA8Tq+P7oMa0v+Q3FPseTvMwe8igE8lJ1p5HyGYIYWbpSgL0dHa76oOI/Bww21YzVEj59aIiBhegAyuNiG+jSmlE8IOUuHDrQu8auYOh0Ba/4lSJsldw14ExNZnmnRYHG5+Kk32BC76viDTn9uPdFmJ36NKZLzEAagWMiJjlIepsF0hP8+8WFI1STi32ZgTPBzHEAz/cXr6bURN6fsUHl1OlQFUfmnYeI7gKfyOfBt7/jJXAJ3p6ITSBvmQuIxjLGqQeyp3QHhEMAlSEH6J2+5ay0jiX/FLZt9vW3ujUCgCCgGSUt0wlBi+03c+Qvfa5HQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(33656002)(316002)(83380400001)(26005)(478600001)(36756003)(1076003)(5660300002)(4744005)(426003)(186003)(9746002)(2906002)(66556008)(66476007)(4326008)(9786002)(66946007)(8676002)(86362001)(8936002)(2616005)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2JfR8xjDYiGrNTzuJ5QpwIjN8AZvIlIlBXAhc3uVWwksjXsBsyL4YyrqM/TQ3G7Yy9tfmwo/8iYFx3opSeNP6tZSRNljVNkoDl8Q6/GBPXUSI9ChXY/RwNVVWj5Jkn3ruU0GD8vWdow/3EmpCozCmN+OebgYaIUVo9iNa0r7NT6BYFUFft5EwirYE3fQnCI0jG3dmq9El4qa8sf4HKXCnLTqTqfyrxc9u+Tmm4WuIsubJNinAI+zLA1aFVGwimdeKTn/1KFHQNxZdbTc3xVVRZKKUGZXGqg+/jvzKuxWEMrNEwKcpRNK/ZRhoaXbb5R99/vMf9HbMijwT4X+khsLWefDfIV1PyZAPyFjhDNuEGEVPSOIQe0ECEFll5K2PpoE7cKs/9zMECzxacP4AJJDbUZcigidLAPX5/RkH8g5vJT7cX1r4kLDnBIjjw4PvSxNue3fICtAweJd4jF9x4/tWI5PKSxAuwEdnhNUH+fQ32lWyKgsAPInKIDWKMhu3kloOkWu/mo+X6WqdC1+5Uwq1yqFXfouy4JfF+AEUt8LXk+KD8PNlLmy72lljIMokIuu1zi/IBejRM7prdwUqdRSkIX5deBNuIF6RjN+Jw0JfDNvvjWhgFLhFeq+ovOA0DsP5nHy4csAIfS4WmtMox6iTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c21d9a5-0447-4b19-a0eb-08d85bd9aeaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 13:49:37.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwVTNsgP2g2/F0eqSvN04+9BSHhGPAT7YOUM5xVItUbjcj1Y1WPzQYKy+afbQ2um
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600436968; bh=CyTIIs9W7t2+IzY6vqMIwVOXTzPv6CIMnjc27jlkR10=;
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
        b=cUWhAPv71G4HzzmFhBWGZtSXl+Ig8Ryi2FblPgWxR5/Oz0kPRXD0IWCnDCzVXO0GD
         vaoYjvaDgHVEcpmKz44neNCC5xA6UWFbcqlwd2vE0+lYqV4Oh2wXtLJjY+A5JmN7PD
         qjKnTfFYYwKvWR7geezFM3UACiD1n1ZkMJdPUl09VFld/+RWpLTKjuZ9BUmV+IKAY2
         gSlSR24a6hq4m8vgGPMa5CZpwfEKgzKXpGTfRaKyUsBrXYS3ZVZiJlg+D659QrvSDd
         CknMZ25lmCeGEwn+tJ727HgyAf4p4bh7nu/yoWU3cpSQMOPtJgeXo/BzdQ8/C97nyT
         gz7h85ffG2NMQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:27PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> roce_get_field() and roce_set_field() are only used to set variables in
> type of __le32, add checks for type to avoid inappropriate assignments.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_common.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

I'm skeptical this actually works. __le32 and u32 are the same thing
unless using sparse, and sparse will already catch mis-uses as-is.

Jason
