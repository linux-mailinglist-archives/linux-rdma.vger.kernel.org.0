Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8117133484F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Mar 2021 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCJTuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Mar 2021 14:50:03 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:56384
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229828AbhCJTtq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Mar 2021 14:49:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgEY1W6IzmRjbNck0GWt2/Qr1pEr+H2MwhyWKbmPCIJIldSuUpYjLX17drYcfyPLuHUGaBMf7Yq69b7iujCnVOYqVd5qMsl+Z+uWeDVK0CrWhhEucjZ8NyJgmBHKpruqbeIhXs0MkZKMtzevQH4z3WHC8U9HZG8lfQT9j+eMKk1WmjkPKh4D7tGFgfkEoiCaGn8iYe+aErJaVD/7inq6pRRPhZJj9gorOG6m0M4+bH0uszIGgh2RqqgibnHtgwq5kBEwxAwu6MM2JejjMMs+cN/fGvMF0z2JHFsiFysNFKhiSDiSeSsjPpaf3XrL+mC/SJ4oUQqdoAQIXJdM4NhXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfnqkxhbow95mpRB02Z1rsSqx4AeD5PV2kdwcIa5zQE=;
 b=clBP3JsbquZ221zjBOusg3u0veWhefS+hoHGsXzzPgqK6sduWCrt0joMQj597pr4obX5m6U9srrB85m2Phq42lwYmkYcyvbUEMp6cPwbeAICj3mlUxq8vOfIjZ+kL82eZBO6Dj9R2I9+Y2FxU0b5hcajmQYCWgSvxYSoDf6qjSEPAHzu84I8SZYAZtYUTnjaOTMMMkWdlSBqYTyNG4D/v8PFaRxXComCwzEjXzWvEuc/DVc2hQaJnBm4oJZu13t8YMvj672yyAKIeoYQstAxin8zG8Qpn7vHZUTbAySKN+Y+gLiM+vtcRN2eFs4n/l7YBIakKhm+fBnO/FozAZ0sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfnqkxhbow95mpRB02Z1rsSqx4AeD5PV2kdwcIa5zQE=;
 b=Q9zEJ0QCmo3fOIjLJHeQ0X8Ofz0jMiNAL+HUx2z//1RvK4kCfAVDxNJQqW5jjaPeGn0r56B/SAhG+dp9s66if7eVpP4j0aQRQv/Tx1jU0VGlziD12xt1HsvF3jbvbNKHiuhnIlOe1bHDIFHmfjQEr+3GKvx1LNMh6ABEpZpRHgHOm29zcrU2ltqpZCL0E0T7CfwF1j94RUArDTjs9bnZcVc3y9nyY5hTXDeCA9WO028n6+0r94aXPq+N8Iegiaq5UzAsQ2Mx9PwXYWN+JFz1FcRmrhZn4AjBPmkAcm+SLCTjhcuGl7BjeVp/n3uscyF2PmZq5+1mLhzoiiyjrl7eSQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:49:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:49:44 +0000
Date:   Wed, 10 Mar 2021 15:49:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Use new SQ doorbell register for HIP09
Message-ID: <20210310194943.GB2602371@nvidia.com>
References: <1614082833-23130-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614082833-23130-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:49:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lK4pz-00Av1P-1q; Wed, 10 Mar 2021 15:49:43 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9fdc3a-1547-4fe1-ced9-08d8e3fda735
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835527C0586B7604D2A23DEC2919@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1efaA0Scj2Q0ClIxu8EUIlnh2lK3yfuqO2qMSNRJtQaJcEBsdjflX5rBlz7bLK1kETJ/xZ3sNizrAAma/Hg99tDXWVTslukaTIPNl3b17y8U4g4c4FLfFzgznoJ8PFxfwWB3NZfRvMNwQOApXKI33ZgxzGSNeQJTLjZTJ9c5RTB2cXJA4D/00/6Sl2c2KJ5nWYGfgzXpdNy0vEy5XCXGxmt0BIbIvO6JyKZwFv7b32k+uHfue+nATMsUPn4S10QYrnen5d5eJ/gO8VxC5sjRFawVjXo2EfZVv86OzsvEdXGhye2Ru8qcUQmqnnhDIr4YOVlYSkUuSMkoHjtVnTtIzEPUdfNGAzcrdLht1Tx/+yH/fqArCC2Q+lNUyJCl00vqYlSep19KI33hVvwjR/oTLpm7GnaEIh4B6tGc3Opj/anhXrYz5mmG/LXLQAmWPTkf4VGB1I5Ou/P3CU78ryrtUKLUBTZdsqA0DVa00tQdSGP3ymWWjfaCjz31B1FHZjFPvEEZYM4jpoaN0saD3tKaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(66946007)(4326008)(66476007)(1076003)(6916009)(26005)(66556008)(4744005)(186003)(478600001)(426003)(83380400001)(8936002)(9786002)(9746002)(316002)(8676002)(33656002)(86362001)(36756003)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SqqZs8c/p1RX9Apr+BwNa9SkGDoubWz2wrOd1wE0ZToVXoWXAaZZzkr/Wzo8?=
 =?us-ascii?Q?m3LER38oB2LaSBx+i8lXWMx77gNsMrURWxIor6VV9AqgNXg4Qn5Fpn2HE45I?=
 =?us-ascii?Q?ST0SCy74+6HvJluJRTjRRUyomL+sW58xWEQUNgTL10/uScxBe5ecYoUILQ0j?=
 =?us-ascii?Q?4wUYjn5SiLco1clJjaltFsiTITfYooVxftpmetFoFwMKdk+p0b97J2wD2pw6?=
 =?us-ascii?Q?GVCNSTTIlXO+pzRXJhXl9xMfXorPZspYXmulcFQ6dc/7tLVSuRy8Wo87uxlq?=
 =?us-ascii?Q?sOE9FNvDpcgWph0WtjHdQugOd32QWE2ooTB0dNIPXL/UM3hunOBHa7nO14au?=
 =?us-ascii?Q?/aNl6ALdcdIeir7JbuOgkjmTeOT/uMmb2R/2OUbK54yKXyFHAjXvOhKEpJPL?=
 =?us-ascii?Q?k2+aIVufKcmnrc6wDBA3gaPI70k8ZL7LZE14K5zmOQI0wqVs0rw6T5p872Vg?=
 =?us-ascii?Q?0oEl/LJpnZF5Dp5a+YjNvbisNGPdJS10X40QN1Zli9kEsT1U2KGNUsKBml8N?=
 =?us-ascii?Q?80BRZyEKMlk/97C4wvR2ZwfDVWGBx9+/agHonQ0KWcW3ZrcvrE7nefiVTTBD?=
 =?us-ascii?Q?FSymvWAzi7XD+QcuCI7l8x76F5Vg++rMp1zBMYBgIqulHQd3tNtdm/nv37g9?=
 =?us-ascii?Q?wQCGaXQqWPO6tNj4getvNCMW5g5WxeqtA1w0C/hqkrfO96XohfmaCNywXNjK?=
 =?us-ascii?Q?u1KFn3D7SoqeaG91fPsAvCGwGWAqU4OclH1CFnxGqVZSv6PtbQ7RuR7k1x7A?=
 =?us-ascii?Q?7miMk/2DgngfiC/6KNzU9t/Xl81MN+1JhQLU8fqdXI8ujoShYHArpbzihq9p?=
 =?us-ascii?Q?Ej17OBKp3TeA0dOy/Ep2+76xLkxS37oDNi/0h1dqJzgbaCMJAsXxKzABmTV9?=
 =?us-ascii?Q?eYqW/+emb7L64wliZCkSptdKZDfUqokfNab8tZwdj2OgnzYFqbhYi4lPPls9?=
 =?us-ascii?Q?4PMk10SUlSvLHUWSmvo6jMhl4mhM7OTLNZosqzwPZUi+pf82j5lCZ3/y5HSi?=
 =?us-ascii?Q?B0/2Ha7L4xaZ9t5+0fpb7EsQLQeqEx2sEr7/N1b2GslEYWTK9DYBSonyMqc2?=
 =?us-ascii?Q?I2mfDHnrNxI0nrwisZgQcwIs+4B90oy7TvjkrTLr0TZ2LuTvO1xndYUqygH/?=
 =?us-ascii?Q?2B1OufLq4GP3JviY6cUxnzkXruqxbEqNzDg4E3I9//B134Gy+hvZjled596M?=
 =?us-ascii?Q?zNJAmuxybrAEZjGZwV7ClGRS5gp/6XN9o4C4a1v/2cLcsYymSiatjIhpVmFk?=
 =?us-ascii?Q?+lw+98ZmDbFCQH1pXl/eDTzmlWL2gzjRAYiSwEH/HGJWqrd8OZI1bKWaggjN?=
 =?us-ascii?Q?lNtTzNTgpVf0rOKpo6fybrif95Ae9xlKFEkZo1Wn+FLToA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9fdc3a-1547-4fe1-ced9-08d8e3fda735
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:49:44.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud7IpM5PL+Ik6BSs1LGPH4QryZTcnqGdTKapngdsnI0jML07jylsOuV2B0fJVckC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 08:20:33PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> HIP09 uses new address space to map SQ doorbell registers, the doorbell of
> each QP is isolated based on the size of 64KB, which can improve the
> performance in concurrency scenarios.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c    | 49 ++++++++++++++++--------------
>  2 files changed, 28 insertions(+), 24 deletions(-)

Applied to for-next, thanks

Jason
