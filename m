Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155773E2F4A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbhHFS3Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 14:29:16 -0400
Received: from mail-bn1nam07on2057.outbound.protection.outlook.com ([40.107.212.57]:59296
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240879AbhHFS3L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Aug 2021 14:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWPTDQI8v5ZFd58bxuZciioLOi3veIVz+KrVhPPBZkG880rKhlx3j85Jw7g8nmbByA1wLSoLNY7FtGPxd7DLQEEQjoX43zw+ralZDPF4yOaxNu3Rm82L85fJrHd4a0+2uwHrQqnkedOJQU+gZAapnjRzcGLuM9gV75BFiv9RQHhT1aaMzLoST4rL/0iOZbaaXw6OTSEGty7bZMyzFrKUu7AqTbo8dTVtmkmg7obZdcX3BA8s+6kXj/aJfgB5ojsageY1hnMmnmVI2iftKhbXu/dc3pOfvrJCTO3x2TWIcYalxhWZ2B20VBxy+pNaKb2CKR9fdIBMcWe434eJWWpp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWb9KcdDaaXSuQ7lcDgRcitWqaKo5Uxu4RpXs6fiIi0=;
 b=c14U53uEL3KQm7n+EDJCm9WWM4xr3caR+W/j0h6Y/PgEVoT+W/GBuGzBFsWARLGUEyjyoNpN8OsJf3cyQe/gd5PRlpQtKjxsOuBuKfxzf9qNv0O5ovV6P8icw8MouH36SRTpO1MZpaznVBynZ4ODwmJO/4AoV5VMwHBQDEmEV6rAOdMSxYO5BBPY6oOe6dXWcxegdL3E2Mjcwk+AwWqdh+irEQav7UytmoNIJ3XCUW6OR8+XmuhAmBFuTyxin+rHF6J1oDeymAequEP6N+JesTXA5SH8OQhUEvsY5r4Z0AtdqNoiCrcbDkBmoZqZdjjS81YsipUNmXfoV1QTC6C9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWb9KcdDaaXSuQ7lcDgRcitWqaKo5Uxu4RpXs6fiIi0=;
 b=hGznEMEw0OAH7rWWAiv2Pn+gD8z7WEAKlIFYrnICs9TV3vOSjZQNg8ZdbC/l28fgelC4uobJ72VhB2Ydnoooz7HnsMDQYA0NoPktjF3XOgWfO4o3AiCpuEPNPWfVNVLtr+s/k2nh/EBlCOWQ2N1OEPkAfqc6SPlnUtAoWGn/cnuqVX4QwxbTqN5vVvj+YmzzlEFtdSCXW1edhvq2MlPmLCoU1HZKg37Cz201A8yLmosKBtwNfqXE4YNYAg/Sj3BJwQE6hCVA9Nm1fv6zE1lr7CvQTJA5cDfc40Y5hEGwO1BoGV6fESvbm9Kytgn4obRimgfjyYYx7f6d7OG4Mj0Huw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 18:28:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 18:28:54 +0000
Date:   Fri, 6 Aug 2021 15:28:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Message-ID: <20210806182852.GS1721383@nvidia.com>
References: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Fri, 6 Aug 2021 18:28:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mC4aS-00F75d-QJ; Fri, 06 Aug 2021 15:28:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98362071-3397-4c60-b5f9-08d959080ba0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51913405EFA50640961FFCFEC2F39@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zH091IhLaEApuGB4+L+9HEQT2Q9DHuBsqIM8wnnzNHlO+JEn19oGxCwGg0ZA6TyqZj5eQHYZDJwVU4pcyanpCb9lFKRNta4Z51QI3Bqu+JFnPdP5mJbyhI+eB4Y7oWZr0M7zJ2xCjoshm/bzuvKlr5mNchmwQzEJTNMXsysIbqj4X6aZ930V8cdLhGFtDK5QBwnRo8g+d3omtIQZp/jky0uG58rpTkse9m/ExXLJwX8jXoxfXl2MKX2xZt0cuIdDqfGZqnWgwxvqTUWHiiDP30eC+J8vjugrLeMgb85SkNPp9cO/Bz+hxZLNWbfvr3Butk0z2wXvRcvDknCamO0fElYSTob95Pc19Wjp7g5sAz5PrWFKltsHjmgzUsi0WSoFUCupDsaK0lDFTl48g8+Wfy//VESDJclp0r/S0Kjty/ypw/8F+cgdcnNTJHR9anCvBBbpWNR0zea3RHh+dQTiZ4qaoLRvzFkSLncVkBCa1GAvrMUjHz7FXEmGWCz7ye+I0xF3VEnfzKSAhVjE4T3Il6uXaJAui75WhQPnon2634D4pStUKmAeL2lsrIQuleT4TxZHOv0XknJCqcEQ++nJNa7SiLZskr1XvBVvyoDjw0Jp8kAE+fMfF7UKTKo22M1nlGHg2r0Uas3JQarUAcZT9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(8676002)(1076003)(8936002)(86362001)(33656002)(478600001)(5660300002)(26005)(186003)(6916009)(38100700002)(316002)(66476007)(66556008)(66946007)(2906002)(4326008)(2616005)(9786002)(9746002)(36756003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36HLvDO57UPLlKXjKFriTvCjyghq6NXxIAEXV9seeOHAMJ5Mr2TYPDvAw99t?=
 =?us-ascii?Q?3CEDA60MfYsG/yWtjBsoXOY85gzg+gL+Wqm9VyZ8WAF+ls+WqB4auzF7ILpJ?=
 =?us-ascii?Q?KFuxff9ppIL3Jd8NHILbrMlpHtHsrhR/Axr9g/HcHQvNa1etXu0nsTBIo3kJ?=
 =?us-ascii?Q?5pCuRhOZpq0sJEH/My1UbdbFo17Qb7+6/0F+z4yDF0ItFBrXgF5eMdqYwS9H?=
 =?us-ascii?Q?xxE5l9nBtF2CMwfywPDqb9XkADYi+o9YwMDZ5l4EyUnm2dDCFEt92ah1O1gR?=
 =?us-ascii?Q?Lie1XwU9ZQemA6mixrbOSWlG01+V5Ura6mRIseUWnDkTLQnvUc0sNZLFAD2Q?=
 =?us-ascii?Q?Z3FAVAhqIQ/WF7Zfg3PzVsaxoo7E9t8HJRApfHsoHwAG6VvA1EFzmFB+VIRj?=
 =?us-ascii?Q?ewPP67tFqILTKpBiKPKJXe2VXj0m/1eQ4qUdZYPTEDY+lWlu+YGzw9rFEM4U?=
 =?us-ascii?Q?bXWfHClOq7fq2V5QuS7mwnie3JRIKySFBOzbqpQz4l8+zSavqZGt43wz4F7j?=
 =?us-ascii?Q?BUxIo4478HJPymfMYuvfh/1ihfw1DcwUnMdQl3KNQLYBpdjCtNFNyG1F/Z8e?=
 =?us-ascii?Q?8uXhQ3N+1WoYXbZ33HtUuw0R5QrhPoLS0TC3wO2xH551JJqkTOmGCvDbapJU?=
 =?us-ascii?Q?9DkoyHCPG9n2AJBgsWPx537dSFKSfoMVtRxiG3F4qLJ3DHei/8UD9SU+8MUp?=
 =?us-ascii?Q?ox3/J1BN9nMABwzyNWpmiJeWjth+Vg1Xic4eVdkALMZsdB5NNdvTdsptWmn7?=
 =?us-ascii?Q?d+H/sVcxuE1qE+I3hs1yvtA+jQNp1Alg/lEhR0cxec00Iob546+kK/9RX7A8?=
 =?us-ascii?Q?K4KFZeTGucajfkzP+Oz7kD1/dHbTXkfa5dj1o6fbfxhlPvTOPhGN8Pwmjpcg?=
 =?us-ascii?Q?mZ+mI79JMVo69Bh26tSoovJ8TWVjiycmuy0goxPyjg+nr8RMjNoPOICuVgoJ?=
 =?us-ascii?Q?IswJqPwR0tLNwSHHi5oWFKCnShwa+154Tng+Rg8IsiVIzehRulshuh1Njrbh?=
 =?us-ascii?Q?GevRr5U18iKvZFqz0dzHGoRPDThlvX8hgAzSYyTxObxA1It8rAW2Qhxr9NfF?=
 =?us-ascii?Q?KXxsMD/A8fWvoHhf/lAXPxV1wS8tx4VYQbrpQFOESINnL5qswb9Kz34Jm/lz?=
 =?us-ascii?Q?yvOPZWHvaRx1JYULVl/UqwHRjQ3ngXS39wt8ZqZAQLSRZK85F/ki+ouKU0Bz?=
 =?us-ascii?Q?ROVap1bEckxcjIA9r4EIsEJW+gSHhnb42wRQQRpgrKmFXXJjqt9sT2lGDkU0?=
 =?us-ascii?Q?5ZHSd/LLtZ9/9ev6+ZDQzZ8dru5d+TEITbhMbuUzKYHiucnxozVc1g4GPy9L?=
 =?us-ascii?Q?me5B7BvE05ZwjL8L+36/rjX9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98362071-3397-4c60-b5f9-08d959080ba0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 18:28:54.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cFLuGZgKeKO1JAfJJElwFrHeocdJU1p6lJQYyLanmoDlacHG80otpwbH1vbJpwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 12:58:08PM -0500, Tatyana Nikolova wrote:
> Add ice and irdma to kernel-boot rules so that
> these devices are recognized as iWARP and RoCE capable.
> 
> Otherwise the port mapper service which is only relevant
> for iWARP devices may not start automatically after boot.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  kernel-boot/rdma-description.rules | 2 ++
>  kernel-boot/rdma-hw-modules.rules  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-description.rules
> index 48a7ced..f2f7b38 100644
> +++ b/kernel-boot/rdma-description.rules
> @@ -24,11 +24,13 @@ DRIVERS=="hfi1", ENV{ID_RDMA_OPA}="1"
>  # Hardware that supports iWarp
>  DRIVERS=="cxgb4", ENV{ID_RDMA_IWARP}="1"
>  DRIVERS=="i40e", ENV{ID_RDMA_IWARP}="1"
> +DRIVERS=="ice", ENV{ID_RDMA_IWARP}="1"
>  
>  # Hardware that supports RoCE
>  DRIVERS=="be2net", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="bnxt_en", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="hns", ENV{ID_RDMA_ROCE}="1"
> +DRIVERS=="ice", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="mlx4_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="mlx5_core", ENV{ID_RDMA_ROCE}="1"
>  DRIVERS=="qede", ENV{ID_RDMA_ROCE}="1"
> diff --git a/kernel-boot/rdma-hw-modules.rules b/kernel-boot/rdma-hw-modules.rules
> index 95eaf72..040deb3 100644
> +++ b/kernel-boot/rdma-hw-modules.rules
> @@ -12,6 +12,7 @@ ENV{ID_NET_DRIVER}=="bnxt_en", RUN{builtin}+="kmod load bnxt_re"
>  ENV{ID_NET_DRIVER}=="cxgb4", RUN{builtin}+="kmod load iw_cxgb4"
>  ENV{ID_NET_DRIVER}=="hns", RUN{builtin}+="kmod load hns_roce"
>  ENV{ID_NET_DRIVER}=="i40e", RUN{builtin}+="kmod load i40iw"
> +ENV{ID_NET_DRIVER}=="ice", RUN{builtin}+="kmod load irdma"

This should not be needed, right? The auxbux stuff triggers
proper module autoloading?

Jason
