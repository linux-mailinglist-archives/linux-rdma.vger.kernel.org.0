Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F440B7C2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhINTTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:19:11 -0400
Received: from mail-bn1nam07on2069.outbound.protection.outlook.com ([40.107.212.69]:36997
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhINTTL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 15:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEo0n1ziFnkOvRPVMYpU0vTlFPomU9C7scn0OGY1ADgJdzWELGtfdeaxeQyM/uBAzchXOFAxU//XAcvhn7wSlqkifB7T+b8U+QNYSxiKrBxyyxLzVHwcp/aIez7hbbKrL/HLSSiN29hbRoGSsyIJRopbjHlnVguKOGJd00WcUavp7rXJeBdq6JZU5FV4YuvHNhfDT0G1CpzOSz9KkmTJxDyEJKDeFt07DpnlviwLaGAUIb1aRo29QcQsJ2xAomPHMes9yMTjgLV1NaKSS/T3rvBxdcQuCC7P9vSE2sB8YGlDxSrnumlG0dc9UPwaQf9fpf+jr1R1spQWKUlzY801Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=q3HmMNCVlb8oqC5LDzl1zdoGHrIdNK8aN1iiox//dY8=;
 b=Rt1BozEsDsOE+gZ8Nqavg+XsfG4hNBhhoNADYCpAsd+NRaGC39MRlBbkM02aHpAaeQvNivGFJalHQJAqg2Yk1ZiqqJJDvmY8NFiTfyv2GTRkDrsTphS3gqUhNxzsMDZUJS/Q/LOENZBlZ2A8WUHJvizo8QAWRVAv1dF3rSB+9jjZsQ4Sb3MatjOTIAEM9JtwSv1yXAFxky4eEAzQxsc6iHn0G+HupbibZPykUuKnlD5he6fLZVaANVYX3iNwRlVEIProxa91TZSIfWtQ8UooW6JEJ6GiU2AV+o6Vv65NxCt14JvgmhgBO0AgEYF5P3FUxD229c+MQloMGX72H5YBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3HmMNCVlb8oqC5LDzl1zdoGHrIdNK8aN1iiox//dY8=;
 b=Q1gSojkYbuII4UN9hyPWwXnfuZQeCONzF0t3gYMvR1cIkO6LF1HpJq0+AfRE6XO0Y6acrH4jPaXyIykFZtowA7+F2w29eBv1m39fZ3p6xLkJJfVmwMMLOUIVoRWhnXn1hkdolxAD8TXsvzQsbiCm6VihLJ9GaQpU+pTD50j7/YB0dU0fDXqQnMur5y6bkugXk95zAi7E7zcW7JC551oCdTwmuyvDDVrdz4qi1B/slBGMGaaZOjIQDOAl66LSuGkHJ77s2BQwLCgWSBEmPJjK3SEbA+uXV4ME12wlMZL3rQPpNCGe6TZzfcX7XFLDQPFuEcRrfeRXYD+cpQLm0F4tZw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 19:17:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:17:52 +0000
Date:   Tue, 14 Sep 2021 16:17:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: remove the unnecessary variable
Message-ID: <20210914191751.GB149861@nvidia.com>
References: <20210915075128.482919-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915075128.482919-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 19:17:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDwF-000d0U-47; Tue, 14 Sep 2021 16:17:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e65f3918-5a27-4773-9285-08d977b45928
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5351F3ECDE018D532257918BC2DA9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seoAhGAdvbRcN+aKR/hBHNpovlG1Fkk/qqpa1KUOzuEDIKdCq9zgxJ7Y8jj2bjnY+Y+fxVPe8we3n/qn5foJoE/kfay2sGs82kboqzfc1plUxvR4y6xEmUdWGySW0QOlyKvtKd613+rD7Fze7QSnr8PjJccGtea2NLXWKby/Vsfqgu0wc8a7ooPiCkcbyrhdQKTb8cEEOR/KScqy0MJVXilL5mdZzsmHtjCG3IzYDtlu21BsEsXm7U3fBGSB+8haUZf1WfrW+kAGQtR0VpoKu9iwCaPW2R83Y8HdaAP79wFdnHPIS7fT6nab7kFtL56E0Qh6HYOM4MDjv/Zfl86NILP0aeTO5mGQbbzx195lh6dzMNynawiP0YSnVWdMe4/2CkfbZAsgU71udIhy4sNAIfzQUCpVdcymOoTftCabeO7/Q6XVzMYJMTFLAfVRdABK3FBpp/CkIZ2YiJT/r2e+RuFLchQfhHc+rUYXIau/2Er6p2gpCKhHgSyOBRBYWzzoEn/1gKEycCwSboJ6QUqeIs3VWdJdoK3c9kQKOA6f7DuxE2OnYNHtiKFvKM5dTBLIJfCyyNPJQByPq8syrtwP2sf0iC2ee9tkhiX9vm+m1B1Zqrji5adqSr4LHTEEWXOoYslSX98g/cBBfjs4ynOFw38lux98aiSzRqwt9Ek2zrZHdhm+zhAJoetwHqsJH3/FmLJN/koBKM/7WMLFk0QlQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(4744005)(5660300002)(478600001)(86362001)(83380400001)(9786002)(66476007)(26005)(2906002)(36756003)(8676002)(8936002)(38100700002)(33656002)(9746002)(2616005)(426003)(316002)(186003)(4326008)(1076003)(66556008)(6916009)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4o0TfxPCG2BGL/q73uXnErOV3HQckXKRKHzgNQ+lANQcpMaMLKuKcBEJhE11?=
 =?us-ascii?Q?WxkFXzdWC0LcQ7ZCOKWvtG42BEj4OoxiiK43jOJU5Zo9I3vBEQTlctYwChez?=
 =?us-ascii?Q?e2K+zvnxSAfbbOTQ9GGlNXEbR2vE28S0DNGTDKolSVCEHVg5B7rEKznNpXCP?=
 =?us-ascii?Q?Uf1imj0uxGLTvFw5OhEqDQN2eSOH6M/BritkBJDiyxXE6nv3uh7HDA+Fj0xE?=
 =?us-ascii?Q?6pBprHkugd2MTIewiQzfQwchXP7MAOWaB/ylqulFnBNZKxvvzd8V3iUK0Y7D?=
 =?us-ascii?Q?PKtdeN8aY8+OJ2AewchAc2lzhoacnUk8B7VyeVcAfYdbRmXUvIU77OxnEooU?=
 =?us-ascii?Q?DwTyFc1ALBSC1d8RFKOHNRkrh8eDlF6iMNWzAU0ehE5FF/v4RVrvaQVvc1bF?=
 =?us-ascii?Q?eTkrfVqHvl+oPsLSWZHLH2X1ui78WFwU5sJDoegh5Td9vFhsxOZwLlGurU+K?=
 =?us-ascii?Q?4mH3vmpxAtmefycsZjudwFH74kkbBrT7p3iIdRkZyAAZ5c3basv24aVxNs2O?=
 =?us-ascii?Q?0G9FQE7OAnNGnkrxkoG8xcpE2r4lFQ/8aRDaGvKr8NWHMrDQ25Vehq8bLpJx?=
 =?us-ascii?Q?QXYXhiBNz9aNYSwXfVKLHRBmT+AgoeEyzbqzQVk2WC2hL/Thd7XfddJjhA1K?=
 =?us-ascii?Q?OxiKf2ply5gewB3KfSDTUxaoAzTDshXjtvdl8o4YNLelkqdLo+PBv5C+FfF5?=
 =?us-ascii?Q?PE/3DM4YEXtoaOfsiNaxA7NUCxsQ0TrrraVEdm2RpnWYyJkoGXAi/oGLNmAH?=
 =?us-ascii?Q?rx2vwSHUgLRQSy26+BX10IqpyW0gm1BINSdt7gq38Huif6BqtfsjXpyZ/sya?=
 =?us-ascii?Q?PkQDS+MFMG4A9LJSoCNf6yaUfcac+PEiGFSB0076lxRZNRvpPAN+APyMc+im?=
 =?us-ascii?Q?lmCsA/iAl6VVT+2LNVq5f4eq4Xspw+KjUrWQyfYCyx680TSVFWozHH7LfP3h?=
 =?us-ascii?Q?kYGLLsEv345VhUCSBkMab//q/aixe9HqNceA+cFUs9xmEtwTscEIvpfj48WD?=
 =?us-ascii?Q?ZEzWe5UqcKwUH0wJtXhBp/MdeH4kJlt0tU4nfxmadgSblPRrGQH1U2nZETs2?=
 =?us-ascii?Q?c7eox7tmbOkx5QaQVuHUW6SXYVgK5mH660wlYJJhuMpGR+XJ9V2kGrlthQdd?=
 =?us-ascii?Q?PoX+hn2yZ53lbvd4D+JA82GuFQBpUO/dJ+rSa1FpiYTw9KbupvnvxQq1Oj/Z?=
 =?us-ascii?Q?cEI48T0on8lJu0VS70JI73SN2vRJFMRYaifn1gLgK4EKH5g5XPQM7Q5OVek0?=
 =?us-ascii?Q?Dp/6aFwAijVCy4b4mVoSk6VahjdnKGyIRd+nxedr4rfC5ejV7CNOK8G5LGFS?=
 =?us-ascii?Q?OgeyvrRuk0ajtK5YFrtwN28P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65f3918-5a27-4773-9285-08d977b45928
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:17:52.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3lDxPp1ICSMG949MJ/4bh83UOAE8I0PU2YEl/6YShrDokV3njMUMT9H1PHitj+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 03:51:28AM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> In the struct rxe_qp, the variable send_pkts is never used.
> So remove it.
> 
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 2 --
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>  2 files changed, 3 deletions(-)

Applied to for-next, thanks

Jason
