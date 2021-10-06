Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7E424754
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhJFTn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 15:43:27 -0400
Received: from mail-dm6nam08on2062.outbound.protection.outlook.com ([40.107.102.62]:2400
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239650AbhJFTnB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 15:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyFzi7Jwgvd42iMiIGDshZiXTPCE/yKs8R3QruumH3TwMbsP9XHc2wjwRar8yFiT/TH4pWBvD21izyZ2zxSFU6CGcxDcWjZDR/YnPGfDbdwkTisZjs0D057Asib5PJm2eSw41D8YMePp0DiqtYthbeIn/OaY/DxM6xOL6A5OZpaq2Psetlz29lLgo8l5L158CccP3c5+0nhqjw3KoGOs06fFqig6/T8Kd1B+WT0/UPfUe34GLICHFk/yTbXHoHkrthRi3qedMIsfPDXOkT8Odzg/PsP6I+r2qfdf3t1ElaeHEZqm6AMO2rnaywFhGEv+QD9C4Phd/3Muv3/GDTLw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnTG4gvD5Qh+I+2Jj5w3w8ZRqgNzoF1JnN01qtRuaSY=;
 b=JJKt8lG4bVWTt2ga7MVWBm4UmyNJ4Mib8dn9xGfXp90d6gtbNN7mjtO7gUD0bc1dkenwbuBpPv9/3xm2K3e+DlxThh6HQEjAEQLkuBwQtatP036ILdVzMZp7RFucsgxsGAtzMTnG1sdr0byFfQX9tbYV+jEfwCjhvA0tnvjEH6i/EAKtCbE2/Yt+/EVIpAa25zBVhIVoh96DScyZFNwJZKOXhSr2pek0NLVIRTO5Gw9ygHA5rvOv8nkOxzbOgBTFTjlcUrI9xJ7CLwkmvyVKi/Z2pZNpzxabEn48FbwyDanoKBgSKl88eX+lshJLNLThssjEO04COXOH/vD4F7va3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnTG4gvD5Qh+I+2Jj5w3w8ZRqgNzoF1JnN01qtRuaSY=;
 b=s3G+fbrOi5Tkv084/KSzY8p9tbzWMaPX8qiL75ITPVZcT3ZKLqWePGJ08vt/k85Upib72NT4uy3D7PK50eWD+skSmKVE7H9cVRyMHh4JXbJ7EtF/yDpfjn9xqqcLso8wF4GIsQ4y5Vs2Nj2B/HKtczkYe9FO9bD0XAPUZJpF7D9nq0+r0iJ3EbyDF+mzLPUk0pmToIqDQqoTx4JxtWjP9BXA1zAxDkNHpK5O/DxLmb7NyVS3wO8ydzKgxdohw9yCtvfougrl6cPghp4nQEDUD3gAG7MCt+3i81EflV6Vst2xTsDyhXzsKFeUoh4dDRm48AxYv5LEsDHvqch+ieGDvA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 19:41:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:41:04 +0000
Date:   Wed, 6 Oct 2021 16:41:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Moni Shoua <monis@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Set user priority for DCT
Message-ID: <20211006194102.GA2768770@nvidia.com>
References: <5fd2d94a13f5742d8803c218927322257d53205c.1633512672.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd2d94a13f5742d8803c218927322257d53205c.1633512672.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:208:32a::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0096.namprd03.prod.outlook.com (2603:10b6:208:32a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Wed, 6 Oct 2021 19:41:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYCmk-00BcIO-Qn; Wed, 06 Oct 2021 16:41:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6824f911-33d8-4a3f-1c77-08d989013b8c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208D7BC41523441128E68F7C2B09@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ll9gcTnOPbYtRzx2U5KWa3LB6qdndtX4i23OmD1iILqXeGe2wjeRMXMUN553dFalKdRtxn1tNfeRyBBjwBYPc2SBTxVQiHlX5SIUT/NnlbtFSGl6YesaMQQkX1FZLfEmfMLetihr36au6ZOx2iMZmfm2YK94os5/XtF1ymc7EwRweT/Bt0xx5dTl5BKj/6rXEN/VuN5PSgzFJnuvza/1gSufyhhYzqUqtEufjiNROP3LnuSAsf/ZYsHzasUFGeJw610pKr1qNL0W7Rmmhl3OA+LUfQFUBMlpXuTuR7DO+lCFx1WErqtycDMj2XspoEn9TpXDL1CcrPZQgJaC/3mJlM3Bhrl4ZJskYfS0Gh8rHot2C97LfOh+/fqLQA2vyG+h4wvBmvToVorBoFGU3dZordOYtv//AJr0G6gxo+dcdAzeyekuglsCXTDhK/GfxIM1iphBg9oN6AQw7ffCMIypkWtGB828q+DWFUmrqIYHloNAoN6YVkMcjDp2mEn5AQ5ATKvt7IiAHRee409xQkdxdoH12/RwqM9R0yyocKtJLyK1fcxC4cqih34S/5416zcWxzkUcS7H+Q8JRg4NrEHOEFje2ReYAi8BN5yldNpM9iPSTNBYs7Hww1CQMSQXaR6s625KVkJxnAXMMgjvWDNFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(36756003)(66556008)(33656002)(8936002)(66476007)(5660300002)(54906003)(8676002)(26005)(186003)(6916009)(107886003)(4326008)(38100700002)(4744005)(2616005)(1076003)(508600001)(426003)(9746002)(9786002)(86362001)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjwg6C65Ro5K3BWf/5Ys2qrs3/0B+EXGh7F4pquqM4CZw/xkaG/D3X0Npl3g?=
 =?us-ascii?Q?FHBXVUbWjJiwZqQk+sEbvpEiiAIqfX1qLa6LW716yFpolSSSA2hR1qEAa9EP?=
 =?us-ascii?Q?ujE1OUsYnx9CxVLbeINRyQl9jcnBhIL2UhGmFHVBS909g+di6+lO0ULWin/h?=
 =?us-ascii?Q?z/76Qhl8spCP6EqRpOj4yXqiWRgrk00/FuTP2qsamsnhQ5kiFiWSfuteB7YR?=
 =?us-ascii?Q?D6D/2+2JthE3tmXbNhw0Xg48qs7bAWtmVmIxshk6UmPbvtw96jBPiyXHp/w5?=
 =?us-ascii?Q?Tpjp7c0qazQOEqL9ZSwOec711RVGOXhGnnWluqMqGu1GdrN4lJHWaJzPiHDm?=
 =?us-ascii?Q?MUVPhE+6H3h1zQXkWPOoEQhlnqA7bB63ho/nNwMQmVpGfX55hoYSfuwE4N5f?=
 =?us-ascii?Q?JSTUquT+5jBs/qGZLkLm8qQuRQLt8tMfFBaU4m0ks07YULPVS/Dt3/F+kpBP?=
 =?us-ascii?Q?gJi3Op/Ylz7FnnSCs7eDDUxk+T2yYQlotExwnqp1FoJcgvBmUivpoMnN2F+n?=
 =?us-ascii?Q?LoBIua2dbe7zprFun3Ds0XuR3eNfkyebWPz+DGnLx/fX9KnGPyNsREGr3n12?=
 =?us-ascii?Q?w2P/U/StWsIy+cMcrMHVwp+qTpaicKUyEj5RS116j/vnXMO9YsnMqFitMBY8?=
 =?us-ascii?Q?aGZvUMJ9Vkatgk39+nkwWku+Ist64wxLuKz+uhyeMiY4jdRrz31jf8CZm6Bf?=
 =?us-ascii?Q?QGyLK+QCEc0Rnjl7mm7Hp2qceXTEJgytDpL+6Flf9nu50yH+kjI94uBf9Vz/?=
 =?us-ascii?Q?sxezKASuwDpvECotWjyMlOZr1lERkx+Y//T7p5T2IuKqdvSK3wez4RgvNksz?=
 =?us-ascii?Q?frzUjLQrofqTGdpGbNRj4Jnk+KUpA4KYYEMAC547WL9NneF5svBp/LHefk4n?=
 =?us-ascii?Q?ZSYD9Uc4S9BhAPsdmciOrvJm8oz4ZCEzm0AAWJ0ashqAhkCrDfhntJRXCcTR?=
 =?us-ascii?Q?sG+wd6PWSWaR2kBi0dc3D+FqSiPVM6Lmy49Tda8lKg3O8w6sZF744ZGFfn95?=
 =?us-ascii?Q?oSoaxWdlxk5PmScJxPl8IE5z6pQqc5tbdTwDpjrQTzDZuuKSsW1GfFunwZ4C?=
 =?us-ascii?Q?7l69h4jqnTn9GVPkdh8X1VrpQQ4ASDN/fL7zMnxP78SJqQmrJD625UQKaX1+?=
 =?us-ascii?Q?4xET0jVXPKjNVcxfCXR/sUW2zC0gfq56nvecDeEwrrlhbj6ZZOj/9u35QNE+?=
 =?us-ascii?Q?Y8gl/iEGP6Uv38xCLUK1CxfWpWK+p2J25G16eTD9WSfpOBijDhMOsDgomEPd?=
 =?us-ascii?Q?9K2WB2rabNc2wqSyrOHiI5w4Vec9xcEqWaVZ1MWX146GU8A2WrwXLmd6oV2K?=
 =?us-ascii?Q?jms4pDmZFRQ3dc28V90XxMHNp932hkRL6+sZHJBz6zXLfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6824f911-33d8-4a3f-1c77-08d989013b8c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 19:41:03.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFASm5wnN2C/XCm4Zlzvloa9ghFQBHrMR53GZkav5FMfmM7Neg6ucwv9KIzkBk6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 06, 2021 at 12:31:53PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Currently, the driver doesn't set the PCP-based priority for DCT,
> hence DCT response packets are transmitted without user priority.
> 
> Fix it by setting user provided priority in the eth_prio field
> in the DCT context, which in turn sets the value in the transmitted packet.
> 
> Fixes: 776a3906b692 ("IB/mlx5: Add support for DC target QP")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason
