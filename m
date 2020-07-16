Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227682228BF
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgGPRMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 13:12:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12617 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRMV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 13:12:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f108a010000>; Thu, 16 Jul 2020 10:10:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 10:12:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 10:12:20 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 17:12:13 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 17:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps3ERzh1S9p0f39nXmYK6oh7KG73xJdZCvY3IN/rKk+6YxfKPjjEHqNyz/I/KhzG3hCNMaT08lzgom02uCXr3HRfV81AcEtv6O3cI1Q7wkklkx16XfOaiT1EXzdjdEQsC/3bD9ONfBph+X7mLw0CJE0m1dOLB4RoI3YudSJJ1fj9ZafCkkr0bEvUrunqnGBzVGjcMdQQBvQTJMVxvK+DJQ4zNrhyV0bnx9nKyzOtZOv8jdc5ELymXNpfWP9MypaGupFhng0qITwGroFtoX5shYV8xiHc2Yb8EVWKrtIiqKF8zdlMxULGUxZ3cFfaH68qn+WoHREfU7+CEdlrcnwYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw66ZasHf2oDF6ARvIVGc9UyPU+MPb4vFZLBI66WIRY=;
 b=XVAQQDqQpXbDK05HYGHr8nHt0EHVlyc4j0Z+V8mF+9GavGSl47jH380kD4+UKD31zXLqvR1Dv2kIq6/Tr/sWpPUxqjLQNR4WHJarNZDnSbscN/OVke6ltfqhSevWGgxSMEtnQaTceeNcquzlAr7cOx526tpf0i+q4NBtZ1TnGeCsQKkmCO+glGkxbFV8HhUjOIDFAcFp6VA9hwEL13L01NInOyjScLFaxbhqy7IelxkYho3e9m5FtLk6ooIoawU2z7fEdoyBhnMteFt8bnm8hnzMMVLnZ+VexWZokjPd1hIQCww3hEdkWHyykKSGHKU+YtRWWD76T6ueyHx6Vyxjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 17:12:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:12:13 +0000
Date:   Thu, 16 Jul 2020 14:12:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Init dest_type when create flow
Message-ID: <20200716171210.GA2645730@nvidia.com>
References: <20200707110259.882276-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707110259.882276-1-leon@kernel.org>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 17:12:12 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw7QY-00B6HZ-Kr; Thu, 16 Jul 2020 14:12:10 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ecb2556-bd4d-4ff2-f7d8-08d829ab616f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44518C5A6E3688CF6E1F9221C27F0@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2/r9Ja+GX26JGO9HJeVHSgz0YMFnqfv2zX4a/eKUr7QLujnz9VESl79mwD8RnzyWIJ8OQtQVvDb63h+7Otmnj3wpvSBgccR3ZjyEjGxnES2dhAE0KoiCwYyL4q1cECwlFfmDxxNjcJa+4va+79f4VjGoAX2d+w+I8N/UF9/MGSRDYmblqQ0Ri0PzUDKlA2BNBZwMuxOf+otZXrF2OgruB0kspSBPurGDhFTkPpETHEFPP5O0s81TO1SYwT8ueUBOpU+M0udQunJ+dhscwVIFGcopc0W/D0eJDMo4ySpzfcxZXiPfeUccs9RDR8JwaotOT7PMCkk+XEsFGhruICY2XeGHKPTfl6lZaoc9ymgtxWls7LIcX6OjM6dz85BtHBY+Pp1ibqPMqgKiX147UlJKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(316002)(26005)(2906002)(4744005)(5660300002)(8676002)(1076003)(66946007)(66476007)(426003)(66556008)(2616005)(8936002)(6916009)(54906003)(186003)(83380400001)(86362001)(9746002)(9786002)(4326008)(33656002)(36756003)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eVdwmGM0h1NkgdS3AvyjfdMCol5ulybakItCzQLUY76Z+EVw1G8I7QlUWxoDbaV964eK1PDLmfcVPjK8FuWr2T97vBZlxNafX1ZRT2dLMa5QMvJMbWltUTpKc6XH7B8ohonZMH2SyJHi14s1c8Ft8CoxSiaXvhNkRbgbW6yHOwaQgM0VKzc7/PNUg4KLXNRL420bYDTG9cUs4ZbGaogTrBXem1vp6Z3UjlmlZ9Om65OEKHy+7EpYXJWvPjonfmtyClAw7ritY5jCg0451RSN2TgUodyIz69NId6iXUVBn+nje/o6PVtUvnigM/9kUO4AjhyKMyshBSGPBzvCFW9FMqN5SFxPTL87MuZGICF3OAbShGvI92zDVSKnIDzD1R2w4MXX8oyonFok78M6hWiOiYdU66RQG7YNDTeWm5kuuQkxwM5PUAYBB+zjCIBwxl5jQgJC3tJr7H6LaUXhmrMtpl+mVhdnx9is9EEPgfbLXiqUtMI/8XGmGDmF4fKM+zcO
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecb2556-bd4d-4ff2-f7d8-08d829ab616f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 17:12:12.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+js3t/GFZNA0/osZ9b8BXmqhtnZ2zWJukxvZn/e8iXWCar3oX3KhdevJkrurOcN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594919425; bh=Bw66ZasHf2oDF6ARvIVGc9UyPU+MPb4vFZLBI66WIRY=;
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
        b=RtRBU4FOjoUjMh3oaOzkF5DbK3byDm8CIW8vdJSKnuUnm7L31FHwnhMh/fAFN/y5d
         EYnsnuLFepc/4wsEQ+n690IdWglNrCZKVs4YQwX1Yl6AXYWRXhkTGN9t9bWdddZW+w
         3C4yMz3at7+tL7EAv07bC+fPw+EgsxQOMlGTc6NV2v35+r7DTnBJEtXFUk9e9IP5lq
         HNhRS3C0zBvByz3cVXcFAHR02vIXbrPgVcu0iBbBR4XN7NsI2QdsNccloZeJz74zOl
         HX3r2Fe0juOlgTpQB25hAtCX4OErMSW5nqw6TCwUxPvix+gV10PjMxB6VVAFnczxBC
         zVE73K7ENpCcQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 02:02:59PM +0300, Leon Romanovsky wrote:
> From: Daria Velikovsky <daria@mellanox.com>
> 
> When using action drop dest_type was never assigned to any value.
> Add initialization of dest_type to -1 since 0 is valid.
> 
> Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Based on
> https://lore.kernel.org/lkml/20200702081809.423482-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
