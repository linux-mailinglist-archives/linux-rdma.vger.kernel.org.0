Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AB707239
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEQTfc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEQTfb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 15:35:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D8197
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 12:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocVM2IQDYPGea0oJT4nwYsTOEh+3mjkMsq7KBYnNjrPYmW0pPYHLsjU3Nl0a9S0ZLmH4+jQMNR4oFg7HiLtHSOdm/vKC21pHlMoOl2AaDPwa15Cbrpx4kDugOUzJlYcsYKOdG1IYYmENyB1hCdNDBlGT3yOdIWJwXUtx+1NHzCjk0EWSh+Jk7Jp69ZQl1Pgi44M+vsrrOXbe48X+k4CTJ+fRpS8wiMeonNYASBLu4r5lUi32/Rx8/nYs6d16S6tUlcj/VFevV3W2oGR1Eu5/9tb19CVGIjGqDcb/pr0u3rClr/TyFPhYPc8myYDDIADPwSjZY3VMsatqFKvLSWXtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tngc4zydB5KD5ra5SIJXNYbv6iJYwPku6QADu0ForQ=;
 b=YwhWDWx3JJoiozLzum3uX3tV9IaRzqW3p9OJm6/YFioPV+dn+eCGHHFQ96+srVkW5GqV952YzmhFlWsDBHQzSGBgucp1e/Gjhqa+GB1zAp2Fin0cJ27by7XjUJBHpfa2KBBDYtsYjKWvlGHb22G/UFNZKxiM7whwkxCDmP5eYd6ohVE2juOBMwk/T8rHPuIjnZPIoNrqnevRAVA8nZxlsUNf/aWKGZulQ80nyzVrtZMlb5l8pO/AMnf9hxHmPv1iVj7eJR9/3M5C1860egZ7TTo/SybpNmwY1hooQdRxrqY3eypjYsdiWaBGBkPRGdvZTVa+buQOnNmfhcwJOwkgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tngc4zydB5KD5ra5SIJXNYbv6iJYwPku6QADu0ForQ=;
 b=uttpXnTdHdP/r8VwomNTsEu3/t/IXPNy/rkUa7IYymKJ+JTMI7scPVQMtfd2SV6b88b2YIKfxyzc/Bs/BYwWy+RXkEjZ0xZVg8YMN4qVP9HFBBzJiu5uDV64IzrHqXEURxMCIofCw7QuP19SBl1hd0pHhH714I0cTabT5mkRhWKlDcemEy9psb2bhr0kED8gfuUgu6S30aeGJmz3OFOzGjXer1zblS9vGuBgSjw/CSyCRsCeaVqldiP8PnsfYrXhTRx9DoBw6KP9tyBm7yhdg8X8DAQ2CUX3uJA91c/LkoGIUVEGxkWXTs5udLyds/T5EUYaFwhFO3u8DBZm4g81Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 19:35:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:35:28 +0000
Date:   Wed, 17 May 2023 16:35:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-rc 00/10] RDMA/bnxt_re: Bug fixes
Message-ID: <ZGUsf5z3bpGD549k@nvidia.com>
References: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 76baaccf-f46e-472a-243c-08db570dde94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrynvZtZq7BjdVK+pdxyiYfNSvDUpKRj1rreoJB1GchKcIBL0wlcBzvVGH5/sj+IOnwuV6H0W/Ka3oogUkK9/13GnFOVH2dsQNjf0uxtnO+poFB2LAXsgTHI7f241sWIq2YBWs+vMHAeofiLu4uYQNUIjdTitaA6A2LBLHhdDW9biLPPSEXtEYtMeLiCZ2ypYqs3/mgt/V8t7MjQBxD8JkT5bMPKXQs/7bj248OuW/hJ9pfs7OUZHsIsnM3XliJOh6OzVRwO++/H2onoCr61DECYmXPMNbAdcfg+xg0nqYRH42a9lyjOBmMGa66Re3nM/Qxs2Im5L7kR7LJ9s6g1HTcQxxGZzDkxHHokJDmvLABx6wQ7i5SGzOGymWesD/GUPUtEjUD+898yZrlDrQaVP8CC241Nari2OdeDzj8JaYP+WFkzOugH0qe8btBrLxDHEdYf+LzptXOu6YuLyRBZgimz3xjhkdhApo25fZTQJR2S5/dh6B/Fze3TRBPoO4AaZaoP6AVgIv3Djp2+of9LxleQGsfn+72g/Kdv2aQm6s77d/dDWADNHoUPr9EVkoi8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36756003)(6916009)(4744005)(2906002)(4326008)(8936002)(86362001)(8676002)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6486002)(478600001)(6506007)(2616005)(83380400001)(6512007)(26005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDrQEFKwzHbguA8si+sMuGXMlGCpzyqG/UX/+ezCjTLCSHadMWwO0oVU1AvL?=
 =?us-ascii?Q?JF2teBm1efOY+sywIl4t/1CVDGaZhIXE2RpRrXWxjAL7UV9gz4ishO3ove6J?=
 =?us-ascii?Q?8vsdM9lE7ZNvs5fEW+rr0OOhbxL+BBPRVX2lORvtWBmaHPXSwLj8cUiV/YIF?=
 =?us-ascii?Q?5tZSPUiTmR5uaGr0IK0M4CS05oP/qNq0TyyAsgkiqGTBfZMX8A1ucbHj67Dk?=
 =?us-ascii?Q?0DJ6nsm/PcxN3aqFJXr7AJjVAb8F1rnb1kep8yvjsWbaCycapUZnYGASkPkE?=
 =?us-ascii?Q?H2pe5vA8dfjvJhKnFzPRFHyWAw9TNyyz/U0uq1WxcdiItxHKDBfMDR6cbbbn?=
 =?us-ascii?Q?L5n84bnAOSIogiMusJ3PKzYlUZ8FdZ0vMkyk9yfoGyZbfH2oM1YGy7TE644B?=
 =?us-ascii?Q?b8hjE6UIDX8SCscSalaaCY6Q8a38fK+M9B3LTJOsVxHVdrqF9UDLskfmgvdY?=
 =?us-ascii?Q?rIrxvsJtv4LHjrHNO4FasduYnulnWDCAh2l7MEy4UjHLOsJ0udJRWVvDbkWp?=
 =?us-ascii?Q?4cVmdLmcXsbhFm5d4sqSF6k6uM4h17NpC4DRWUgDudlE4LDxOfHbYInOOoGZ?=
 =?us-ascii?Q?CVag5wPlMGdbiphJ4F3zUC4ORAz/KNhF7neS3xoCeh0cwTaTXbualCHGBzNz?=
 =?us-ascii?Q?DisYYVsp56iWDz4kSD49hdILC4ahPe29OVFHEPQ2PcjHOqdScVu4bJ4Afflt?=
 =?us-ascii?Q?WNXaW/NaCHK2+OzbCQZV2iC3NITqXiNK2FqFji0udMbDVZEZVL1qO4VARju9?=
 =?us-ascii?Q?GhEnanH3rwVDcCQSW8FZnIJlxXI3g0CyADn6TlUgJYoFEPXo4IKVa5rVrU7r?=
 =?us-ascii?Q?0us3FRi//X4WnZabE7CJABSqh3jhIHbcz7hPn2j5B/S9jyWwppzocRVwQRVR?=
 =?us-ascii?Q?4dLz03SG0e6pxLYP9DIrndi5AN/rA14hrtVhUc8aoxzwycKre9uCGRBaiHVe?=
 =?us-ascii?Q?8A66JogCWVFbt/zUiS04TGoWL50KMQK8KrxFrQbGFrvEumItDtEa4MCnCO6w?=
 =?us-ascii?Q?mXmITboc4PhJKfhp5GPzdwPZbY9j45FfINFpVSrdMHvWnddywKMQELih7auF?=
 =?us-ascii?Q?UUJtYjFjN7M+LU4/NeOkHlF0dRFaxsLFVmmbkn5XVxD6ftcrcCu4hBAzghTn?=
 =?us-ascii?Q?f2xiVbyAwFRjqlcJI5BNUAelxO4RAW5qH/QmBwZLhE/DfSyxtihdFtn6XPXD?=
 =?us-ascii?Q?QhO762R0mupsV4Rb3YUteLqV38LyNLbqbBAYaljmaL/nwTAN3w3IVvRUmfh+?=
 =?us-ascii?Q?i8TtNXmHdFqv77tpmXrHF+6pY6SFr9mtMTMHHgd4oy7il30W9h5um8v2Y7L8?=
 =?us-ascii?Q?3rOBbJ43Q3Zq1tJqyhiBhq4ySRsn0ESHmx04KgI6a5zplcGXpckLfj0xFfsH?=
 =?us-ascii?Q?bltPkd/lDgOfAK5kHlWtChtthWicJ2YkRpwbAV8fpdgZvld+a4QYCq8eWqmU?=
 =?us-ascii?Q?7C8vXL1r0kZBwe7MDqXJmK5+Rp6fIvLOVAJ9/k1U95lMwV+3K8DCAiHAYz9A?=
 =?us-ascii?Q?mVL54l32q0qoAY7hfH4OL0LJ2pYCOq5A6/jyHiGlhTFT7khHAMYOmzoOrxPm?=
 =?us-ascii?Q?9SmeZhgJjrEjg4kz022O+s0CPFDaSzfSb/+l42tP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76baaccf-f46e-472a-243c-08db570dde94
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:35:28.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMYtQYxI2F8QEQvPe2g8oW2iOLeWzwrGxj+MV6CJMrK6K3Aiffkiw7vIg6+Uhts2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 11, 2023 at 12:26:15AM -0700, Selvin Xavier wrote:
> Includes some of the generic bug fixes in bnxt_re driver.
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> Kalesh AP (9):
>   RDMA/bnxt_re: Fix a possible memory leak
>   RDMA/bnxt_re: Fix to remove unnecessary return labels
>   RDMA/bnxt_re: Use unique names while registering interrupts
>   RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
>   RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx
>   RDMA/bnxt_re: Fix to remove an unnecessary log
>   RDMA/bnxt_re: Do not enable congestion control on VFs
>   RDMA/bnxt_re: Return directly without goto jumps
>   RDMA/bnxt_re: Remove unnecessary checks
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

A lot of this is not for-rc material, please split it up properly

Jason
