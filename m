Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC641FFAC1
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgFRSGI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 14:06:08 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:4151 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgFRSGH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 14:06:07 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebad0c0000>; Fri, 19 Jun 2020 02:06:04 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 11:06:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 18 Jun 2020 11:06:04 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 18:05:56 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 18:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwfQvBkRHQKwJ62nQIJhEXkqejN0KSib8A8U6QXog7HbdrD+G8mrRQwc6DGpVvOte8eH6mBk7LkPkMBoSqtU5Wdxuptl7VWGSvpEueT7gwGAKq2U4Q9XLPUFxuGznArUovyJC4fK7m+piuH5XUlw16DdvO5gq0dmHrcMwcND28+Sr6n4j7F0LiQKYRcyYsCpM5s4QcaNrIus9MNQMLx0DP3lQ0+nln7i0bfFknLWTP7R5Vfaw6CdfrcgXqkWgDDkucOK9lw9kXKrvrBU24F54ENxI35uvyWPjRe4jFlgM6jUsOJDj8msDlg+QKM444gnQ6/DYdPQVZuFdvnKt2JCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQkTOcFwa+QpfQTMdcssUxhVbZS/aJCYgSb2LddHKMY=;
 b=MDgM0zZJaf2LHumXlqpoU0Z2D+xs+Wmj7spxVXu76jCJZlJmbLgsB3wGoCHYgBMF7T4V8EevHieprLzCGK+Rwn34QwRt/yB3xbGWGYiYv1Ygzv1LU7Q2ZRp8JWDAL78h8nfDaQry++0yjuVrSXE0SmtyXKprs4HzvsiTfbC5rsKJPFSmfOkglhXcVZXvoXPz00t9fQTXWRfOsYs+IKJJkCuPpMlBfgiPNIT7SdvNYbISKbTmTLFsKjl59nfPTX7haaWM03BGOss6/GTDv5XmE5TYkCgsp9HGbx9ZOuynFENhjmAcEtju0kBHdyPYQ6NrStaG8Ns9QKL0riX1WjvFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 18:05:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:05:53 +0000
Date:   Thu, 18 Jun 2020 15:05:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/2] Two small fixes to the mlx5_ib
Message-ID: <20200618180552.GB2449048@mellanox.com>
References: <20200618112507.3453496-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200618112507.3453496-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 18:05:53 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlyvA-00AH7f-M2; Thu, 18 Jun 2020 15:05:52 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b30b2f4-158e-4f4c-f684-08d813b23df5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488EC99868FA368140E201DC29B0@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0ADXH/6+l9Ve25mYUOzWmzJjy/BBqee6WkZwG0n7bnxA8q28eAW1BymVhByjZa5SXGcCo2Iu3x5sTJ893rNy/yl03OfjX70e3EPCWy4qBcHWRrbEiAhYRLvTYwkBBr1BXpiGtGr0V9twiRw0OS9/954cqzo4yGkw1gsNIPtA06h4fbGTLSVWUD05oLWMJLhVFavYD7JQFw5og1codl2SHjksCSjaNrMN3EXV2H3p181LLw2SEKgSy+rOX7eBBX121+nMZk4fk25YxA+9E8zpCo3KpHpWVB4yeTGdv5Zsfbu3MBeRJpVmH3d4NA8PXfIU2AuHJlNwmUZCHCIQ6p35g58AojXnBgnsFLHL6Urk6d+tJ509i5RZV61nwTwyT+YdcBwcumV+qVNJVMWKj8v6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(2906002)(33656002)(54906003)(316002)(36756003)(4744005)(8676002)(6916009)(9686003)(66476007)(66946007)(966005)(66556008)(478600001)(86362001)(83380400001)(4326008)(1076003)(8936002)(9786002)(9746002)(5660300002)(186003)(26005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2rGhp2tV4ePNTJUe/mkIIBJPaRDAaLMF+TMUtN+TDUtYpRHrG4jwgf9QGRhzCMptAzZczjHqDq0W9/6PQ8Puw02er8fKp8pVpG312aEeyOXBjivV6ofkWnmOOrsgq7NdYwOYitajCUCqSfOvNbMOZ7dooevj0T8aax0LkA/YhkLCvhbD50ZwJIDtqryIzcRSKsYVuQMdzgk5ltrofU4GgYMZSZEmbCWPFgOSRq2GdrId+F0dVAVITG93KsWiOLed7GSY9M9azwWj2cHe+j0A7FDsG33PhgANpIZQQtt/AM8IhKwBwZilVhHk1sFqoXKc9OoMLv8AK+rHX/sd9QLV4J6H0sGPzVjYCoLiwNmm+CNGs+5eOEISqP0LwRemhHv+gQOKqqDOWyN4pWnWt9fMZ6mReLtKPeqqYjHTte6VSViAfPWHT9G2PCdLAXwAsN3xOiOWfwSevdnytwjpImpyipvMl0eexfMme9X9LossQaI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b30b2f4-158e-4f4c-f684-08d813b23df5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:05:53.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF7IHw+gua1Y8nibOossqNfdNRqmejwV6CtX/BWEfjkC/nH3NrD+Ivjfn1Oq3hvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592503564; bh=NQkTOcFwa+QpfQTMdcssUxhVbZS/aJCYgSb2LddHKMY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GWgIb4DiuVc5Z7BzVcCj3JzFY/eypg68DfxkNBozmruYp0EDXSCZrFded+zRI658b
         nl20HFvYaXzLIeQM6+4Pni0jbl/O4HtNuMoAFQ6hpHvCqFHDjOKWx+pf4w2/sRRhyo
         bBbiORps9IdsOgWsI1Z574ZsPIexG47/BACa08YADfpqRaOPsdYZb/PT4vFBEFuF0G
         tUtVBLyc7dUQ31Y8SIOfUpkMQDzlPT2U5t/DX3LaP4ddJx6uwb3wm3J2EB3y6VmD3x
         vLCogljFtD99tn9txbvykaEYwNHKmHn6iJXRyF5aEALtDE0yPhV/cik4X45kAU/+xH
         jVU6nCmpei6CA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 18, 2020 at 02:25:05PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> The following two fixes are user-visible one. The first patch is needed
> to continue to use RAW_PACKET QPs after PR [1] is merged and new FW will
> be released. The second patch fixes wrongly reported GID.
> 
> Thanks
> 
> [1] https://github.com/linux-rdma/rdma-core/pull/745
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs
> 
> Maor Gottlieb (1):
>   RDMA/mlx5: Fix remote gid value in query QP

Applied to for-rc, thanks

Jason
