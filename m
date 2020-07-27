Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD58422F86D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 20:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgG0St0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 14:49:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:59491 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgG0StZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 14:49:25 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1f21b20000>; Tue, 28 Jul 2020 02:49:22 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 11:49:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 27 Jul 2020 11:49:22 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 18:49:22 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 18:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMvbwLeb2qIhSen6rDm189YFozQ73Wo990O4xhHikU0BxITLCa2nA6dx+9o4u8lkPJZFKZy2EHQhRN/MuC6RZmMmM3WblJgqCOLwHXh0QjzdrlVIkB5NUS3CHHNtaK3rL+98cYOloNDdI0NRuwerBO5TBQfj7zTVhAgiOQv4sRZCsYEMUITUT7JYlRDj6ZnX+i+ahN6JpxGKKu7hjyuEvQPAR5ChTrc68c9FkgVOTjJZDlMpDJNiaBh3o+7DcXszdfdOnTHOfm1cUf6m3wE6BEYhj9Ryi889wajDWKZayNl2nr50qGooSeqSvlWs3xqbz8fMms32jArKgSOrSJLyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEjSqJYOM5665T6rpP3lqLoBsigI8MlQSBXQ4PR/SRw=;
 b=TKRAO2nd46E7miNczhkMiwnYALL68vQyUJpuCokPgBH4eWNzYPZB9qDRip7q0L2Eh5Nvt+qm7YPnISuGuNRS4KC9EPj+JfylvoWULT+V/VOFwqnHv5Pi2M5SNTy6oBbrpF3nuLDymoIMMr1l2G8Y+H0J3DyTONyjRCH9IS5Fc4b2Hjjph4ZSX4oUloNyKMbOpPPmX/5T8Jw/GxnzOxrzjp2gXS+7qfGR3EDyyhRIAzGAvtZJAhQjI9aeQ2yIoJ+rFRwKU4Q5Ty4qWAjpqye8QIo74CJXNmqBJ1Beo+DV4VZtjwe11M5L9HXWSsnhggAhGy6HQPmDrhUhrA1yX0ODYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 18:49:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:49:19 +0000
Date:   Mon, 27 Jul 2020 15:49:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yuval Basson <ybason@marvell.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next] qedr: Add support for user mode XRC-SRQ's
Message-ID: <20200727184917.GA69703@nvidia.com>
References: <20200722102339.30104-1-ybason@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722102339.30104-1-ybason@marvell.com>
X-ClientProxiedBy: MN2PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:160::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Mon, 27 Jul 2020 18:49:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k08Ba-000I9Y-0I; Mon, 27 Jul 2020 15:49:18 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f401ec5a-541e-4ace-4391-08d8325dc508
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44989BB3D22EDB1AB6332294C2720@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgC2G6mTbyjndWnB7n9vWDfTscZGgpP5gGnHTlw+DS/aueBuL+96A6nJNnxW5uTNcT8KT/Ihlu+Kbio+eNNgMTdFF70p5hT7YkhZ+NcrEEUjWqepMzDWvpbG7wPLkLkab17C/2YVwXFm15eA4NwONaRQtiai3Y0gr0bSDViHxWIbEnxfpP1jHF/Qq0l9p4Zu5slneN67CFEv6hf6bHjfnUbUWB4NteDvmPv+DA1PAlkmzMf8qHWXstpzR5muC14MGtbZmG/zeJLtLQw17pHJ3mCogU8/LjZF+iqS82iEXm3aXnyG4MZ9Cgw8mA1Rjc+wcRq0gcU31bnSBr9G99n5lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(478600001)(316002)(426003)(2906002)(186003)(9746002)(9786002)(1076003)(6916009)(2616005)(26005)(8676002)(8936002)(4326008)(86362001)(66556008)(66476007)(83380400001)(36756003)(4744005)(33656002)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Yf4GWeSprZzwy94Asizgwd0jGrRKU+O47b0MZkNUh0H8GTQlMl8dSvjLZ1tpjfWRDKQ3cBe+zfGEDB6UlXhtOkPtUFmsS6IP/V33e+Dovo8ZEUSsM8c78vOL/SAneIoGV6JZe3qr8WxmiquqcEcU3RuuftS4wdugNXUgP/k6n3BrAt6x5D53cWqGOe7ua4W0uTvUDer3bILg8HMqYcdFC+0KSfApyNaHLMJXPXqF2NHHEe2D8/wP2k9XeuOIT2qSnLCQGXiSy8DXNT41tculnhHZM79NTScnRsjHFIte/1oFpIhGhuxa+XOLFQIz0NI25MUMCoxzKmMg6LL5JPEC5tR1SZE9FsRtOm4enO3rOq926qOOrIJffzwovlUC14yWwrjrJZgle2RdVoYfkZyUt8B+wCfYJGzbDWIuKHBVype4yco5G8xJW2ym8J6KuqtrfbgO0K69EAOZb6UR59r4YGB5A0pZTsZCdvr4+q/jzY4=
X-MS-Exchange-CrossTenant-Network-Message-Id: f401ec5a-541e-4ace-4391-08d8325dc508
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:49:19.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7whRDQ3jYBKeQgmuQaXHDMSxuSxauEt82j07SKjI2Zw2kcFViU0JcWlCrjP8w2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595875762; bh=rEjSqJYOM5665T6rpP3lqLoBsigI8MlQSBXQ4PR/SRw=;
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
        b=BHBmrVOZgqlid4C49e8RlVGCQ8/Qdv0IuovcBbsZTSwYeNQLaWCMxL2KHGL1IFPVd
         o5+FJ8T7zvJ740on8NEgrVravyietjK7iXwheSIZf801n1/P8+4lcKSniWwm0WfzjR
         HphckEqs2t2g7duKhRdEmH7c7x2L3J++hMhEviZTfS7NyxPygXHQO67Q5J+Npce3J2
         fJzta6XzrI9gkLzbnwU6dxE7RBbYQ4DaANCGLtpKnEhxbCOy/q28wiGVuoj5sLHBVv
         +X7qL0lskS3Z+8cZP+MUSR7EUfHsiuwwfG1/+HrnMzDVLY8GDPlqKlKnIlA1Hycs/s
         KZefGdJNBp1yw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 01:23:39PM +0300, Yuval Basson wrote:
> Implement the XRC specific verbs.
> The additional QP type introduced new logic to the rest of the verbs that
> now require distinguishing whether a QP has an "RQ" or an "SQ" or both.
> 
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  |  19 +++
>  drivers/infiniband/hw/qedr/qedr.h  |  33 +++++
>  drivers/infiniband/hw/qedr/verbs.c | 291 +++++++++++++++++++++++++------------
>  drivers/infiniband/hw/qedr/verbs.h |   4 +-
>  4 files changed, 255 insertions(+), 92 deletions(-)

Where is the rdma-core part of this?

Jason
