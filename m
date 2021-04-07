Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98F35788D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 01:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDGXbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 19:31:53 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:50503
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhDGXbw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Apr 2021 19:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THgLA+lgWZ626rxmKP2KDw3whK+31wDwBuWbUP9SRVNg9vOVqwQ9YwbCFoZt7t5+SvXrJbPex8nPEiiv7LvdAQvRUYuDWpOBGWLhO2Bwpg28mN0ALYI5OxYIfa3CZworcftwSP8yYjbHSVK/Qys8sRX3v5qD83fRr78ERjFtkIVKmnENKCn0EnbMpxu3hLwLFJqvUpGyCB30QqAWQYN82zhgpiqvrF+VCMnb7saFCkxVILj3e/1ZznwjnEAn95FXNuHZGiNYjjmf0Ec2p+q6JnDFfz+zgZN8hToEj0x038C0yTbrF0V/MVcqHm4YY+m0LRKZaPtBnB6gIfschXfxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ+A+Omhpd4W7ggP86GraFYq0WC08xHIh/zqTTVTONI=;
 b=EgRIUZAsrykvE0+HN1Z5IYbmi+eTAM0x6pAu6ulEPHbYNUieekudJwAxMuT5jHg4D2gJNdJiLRFHKH4eeuUX/OaF7LkGtnsgTBShZPI+2+OYzW+ijekx4Ase43ZUxcrGzqvx4/gz85k3S5gFDxbhX0X0MGjqjDs52qfRUJZ3LGvRSUwcTLjqQ/sV45zX/I1aJn2ktJ56KXmpFcWdUZc6umRFC4Y2OKpj0C5iJcqZWsiUNdPMbQHICBDpvhoBVyAAktEWs+IQy4/aPVWoGHZfCXActd7IeBNwWdlbkEMh5n9ZlG7ID5BDmp8R5+i+dr4sQ/lupR0O8P2SDktkWCYgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ+A+Omhpd4W7ggP86GraFYq0WC08xHIh/zqTTVTONI=;
 b=eUhlxeXfzdpkA3QBs74FiQg5FEKy5ADxLOZBU+med8v7Cq125dYBWCQlOnJoKwvkPe8qyIi0zZnMSIxQ1q1HGSTio4FX934Ls7iJoGsNnUl/ze3SeldBQD5sHYQaRQetsQCS1sMPH0F3BgiQUWA3QctY9vYXyz2umOh8J3GM17gEQ0b4pCU8JTZj9lVuMuJS0S6m4nSS4Ya37d64oLnNROV9+nTJlJLelai8MITmYSQfW+aLKhjAB5Y7lGeed35iG4DScuCxBZHABmQFnydP0vV+LCYSqlX300BI6ib3zo89R3/wJBVyw3b0ZHvlAt+aSsNkj7DgmrNzdB3btr+wuQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Wed, 7 Apr 2021 23:31:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 23:31:40 +0000
Date:   Wed, 7 Apr 2021 20:31:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        rajesh.sivaramasubramaniom@oracle.com,
        rama.nichanamatlu@oracle.com, aruna.ramakrishna@oracle.com,
        jeffery.yoder@oracle.com
Subject: Re: [PATCH v3] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210407233139.GA605674@nvidia.com>
References: <1617425635-35631-1-git-send-email-praveen.kannoju@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617425635-35631-1-git-send-email-praveen.kannoju@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 23:31:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUHe7-002XZY-K9; Wed, 07 Apr 2021 20:31:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ac61fc-83dc-452a-5694-08d8fa1d4bd9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1547737C3B40C4DE727B512EC2759@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rgAnJBQ1gvg2PflOthFyUhgz2PMbJ+rnDqlXw7K62z7RFMb/Nst3xmtGBjKlUsnzKtcchV2oRd7oSGmM6AVuDIMcBeLc489/RMlljgDUm8KZoQl4ZeLukSNzfGnYkXAAPdT7RqtMz5KkbQktC+IXxDH3zQIGnDpM06+DvUFTufZQTJF1gbgjqxles7xvJ0HkBb7NPc18d7nLGSpLt+HwmGv2laLonjVTRZG+ecxEwW8gMo1QE7EmGH267qNOsE3kRI00I/8E9UNtfupOeDdiB2gRdgfvmCTe2b/fc2oFCfs9DcmZTtExeaF5wxl9CKZoWcvierl/nRQ41XOmDb38msRm/Zmvz5e/yMxcyIJCzQJak69U6A0lecWkYKuPFI7pu74YA62p4GJM5N13mKNo/L3MlZnmsmffseArcKmT4av/I6PXckq/byk7Mnr8QvG+rhzvRW78FQCT9c1A6L8uZrhq6cHQZGfOSGpGbjWs3sLgJ6TyRStWzPrmlk60/9Sfyi8BANytwlLYGr565WBNWddbIZXPbOd106c+2fY7Jt3t2fRAxUmydi8SHfbMOh10kliVtfjBRsty2zMiuMce15dx+O+u7+IW0rWA1QnBVJ8HWvYxHU2QQmJC3u2Hj2ihSs0l61bhAzju5jrDxd5BqAwAfqO5qvr1AA9MRYdyoAqQ/UBvSsn3DMCOJZVPzG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(26005)(83380400001)(9746002)(9786002)(1076003)(8936002)(66556008)(66946007)(66476007)(478600001)(86362001)(6916009)(4326008)(4744005)(186003)(5660300002)(8676002)(2616005)(15650500001)(2906002)(38100700001)(316002)(36756003)(33656002)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ppKoM0T5Bu1sWHQStWe3WDZbpChnPtr756FrnofzHflnT7/i9K8wvO6nAcae?=
 =?us-ascii?Q?z7RUAFsj2dJHDHRgnz8PHNGBKQp+nXjv1e88gdD5L5LS9AKaxR3ab52NM6Xs?=
 =?us-ascii?Q?NyyQ9+TvzveWXsgLu8MQ+fizHKMKB4JZ49iD+T2qZtjlWCxA0ImSiGcw+vuh?=
 =?us-ascii?Q?h4p0g0NKae6Vch23FekjDxseSi5Z6v1dKmyMZVhBUayrCYvu6v1ujbe+sT8U?=
 =?us-ascii?Q?PiB7fUCZ48PJCNn6ylPm++jw/e9+FXDqsD76oMeOP0VIFbjs8BrROec6yAKm?=
 =?us-ascii?Q?Zus4Sb7G14yb5tCx+8JKyj00pGVSbPoOSzBbTZI/clN6m+RDE0huqF0Pb1bU?=
 =?us-ascii?Q?Io56Ssufup7QATsdS6QMoKc0t4Kv8Fq/jp01zMZXwRGZgry09bydTjk0wxTl?=
 =?us-ascii?Q?bWwFY1FnnOlJkod2IQifOGEOM68I5b3zZTM1CsTg7bKlz5Un3dA6SiuUtzpH?=
 =?us-ascii?Q?rkyny2II0lCinnaIcKCDj7j3OHYCly45t1bNtB6dmFyVZEIEtf2zQEiMeF46?=
 =?us-ascii?Q?ZnXt7HmqgrLS2M9jPmNmw6XCCA/uSz+7urKl18l92mjNTsKTqcMC4O+ulq2j?=
 =?us-ascii?Q?bh+EHSX6wDX+zjITshz0vCsZefq5k2Zx2aK+glMUF8KERgcmMt0Vptd+gDgg?=
 =?us-ascii?Q?JeSuFE5oAyn8YMOEU+v9el7ixfdl4Hx6VmAKEjcDtxCN/JjeIpnF12gZEgpZ?=
 =?us-ascii?Q?J5ie9bjrZR5ONDLQZA3PtuGSB735gpxqP8awEXdWnrSlqfeRlA5GKBoH+dd/?=
 =?us-ascii?Q?wozJcXveLI62hqbJ3nHrmxiRotrM1cABQ/8CgKZAltYA1Y1R83xr32QhlYG7?=
 =?us-ascii?Q?iqvMQq5L2rTGNkxGXnujC3kASI5/HP+Yc1p4P42zjVQtUdsSwvR38iFXV4Yd?=
 =?us-ascii?Q?XwA+za/Ale7KJYaNHdvP1ge4iPBHMb175hiBkAs92P2LQjufrcEyaFIGEUkW?=
 =?us-ascii?Q?t5TQBDlsiTorx60PnXDxFeGoiGlUJxWPx8BtzXsK/6CWAf+aIW8ypXNYwXhp?=
 =?us-ascii?Q?8jKtK7Cedw4W1sR2Ctw3ekmO1kA5Oo9a7HPPnMhxyj/O08/ASJ3HBEBgChhb?=
 =?us-ascii?Q?O1/m48cd7G3X88GNiCyOwnrn4ZczGFzDJqKtipAE7qR8Pha20s7e49vUmpJ9?=
 =?us-ascii?Q?CrDaK3E2kRuCsQEdxQPLkivr1CWegtiVSoq/4X4vlV34WCB8n4eFWKS2jF0U?=
 =?us-ascii?Q?j3Xak7QDTwGE7owAScxlaqr9CET41qDRJUv+Cw5M2LtoWUtcS7G5QGT271GX?=
 =?us-ascii?Q?aMQ418+gyU68jlIwIKt0Uiip+H9hE7IqzOsJ2MeS4VLK1uPehCyaA2jVkp/n?=
 =?us-ascii?Q?jBOtKnk7SvBYWvGjnkyfhQlD88kL53kz5VoR4+CUgKZvgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ac61fc-83dc-452a-5694-08d8fa1d4bd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:31:40.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkTNOfr2KUSkTmXiNeeg9Ce7HvVpVq2H+hLwNHXw0B7mf+pbAEGH5UBo7zvFMCOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 03, 2021 at 04:53:55AM +0000, Praveen Kumar Kannoju wrote:
> To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
> 1 MB (order-8) memory, depending on the size of the MR. This costly
> allocation can sometimes take very long to return (a few seconds). This
> causes the calling application to hang for a long time, especially when the
> system is fragmented.  To avoid these long latency spikes, the calls the
> higher order allocations need to fail faster in case they are not
> available. In order to acheive this we need __GFP_NORETRY flag in the
> gfp_mask before during fetching the free pages. This patch adds this flag
> to the mask.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
