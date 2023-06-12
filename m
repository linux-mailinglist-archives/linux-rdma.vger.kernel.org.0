Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4172672CDC5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjFLSUy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjFLSUw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:20:52 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CD170C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXhYqt7NcVqsnSYb3dBRDBUmPBB8PSsoX5vOxWx6X+W4RW6ffrFC1MoX1shhlfIaViqy2von0CRZQIij2zYnp+gO8OAwu5YdD4X2UE4qvT3twlNp15g2vjPX/FdPJT19P1fPIoVIyVBPYPoORiCweIez/a97tyygA6iFoMH5kjL756XDbDo41BhIKkm5VHN4BwHnhl32bycfjCF7nAK0lAipWwUcx41BHSNbLyXW5r9E+5Bd6wBnc61UyxbPGU44EWC5Hlc6lkZJgFOmqdkjEaIiBXXnvvEyeTUTGR4n2Ln+E7uaNafPYCN+TOtzTAo3XKIaNddlM8g9/SawQD88kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbRy+XVAH3gd7gk7NS0Y0kVSY+DDvodbdRFk/2rM3eY=;
 b=iBQ/iVK7BgSZak/oJIYhQFYyhtnyUx6GvLZKiYiz6m7ZNnSJOy5xoKoyWLcjaUhcyFLd0aFdzRKleWQMUKSj4fZ76qn0C0MO++DuSLiaeVVX2ZK8Ks6W7dpCwo5crBROqRYKPyTPkreDaAtDzUx3xlK2Wb4knuR7t760TNKeg9pJx9uvaq8TZPhXCSXZIzEL6cYX7zFp+gXY/PdWqDCQ7l5oQMLoYvVnhrQPpnXf5L4r1LPBa8qJKkpAQAo2OIPBtyi3ptPCSymZikAOeYwCLFIzndyLZVtArPT829tsB2lPQ1zQqxr9+8ai6HTyjq9WDNdProTdnCrveCkeFM+itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbRy+XVAH3gd7gk7NS0Y0kVSY+DDvodbdRFk/2rM3eY=;
 b=PE+sXvBnoYCg9A13zcqJ/z0z3BxITpS4vB2pTA32yZ1Hw5FY257FpWzwqLMZ0q8ExmdJ0jDKnGukOKyxu4kMdedvYateVdwfjKJwpXQ/FuNcf3sR4kFWewreIhdBb4MNF087PhvbvaQr9DIPjwOejnofy0Ac9udfPSaTqhnybZYpnWWuCmD0+5XToPILHiv2E+KYJEcf6SC71e/k2m7WUPGG7NlfzNhFxg2ZPExVd0OdlyiJUCZtQUaTL6wn5zlLdi0Sx/Fb1IQycl6rtXoLs2I8cLFHd8M2uMFIeLL1A+PiRaR0J48pRnGSEDhnE1gNJcez9GwkNs3IBDwE3slv5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Mon, 12 Jun
 2023 18:20:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:20:36 +0000
Date:   Mon, 12 Jun 2023 15:20:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v5 for-next 7/7] RDMA/bnxt_re: Enable low latency push
Message-ID: <ZIdh81FavMr9C0u3@nvidia.com>
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
 <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: a563d9f2-c3a4-48b4-245d-08db6b71b7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nWroq7H46iO8U9yPCuModoEBmuUlfuU3H3IZKEfHHjXxwPLBlQ8Ol6b1MX0DeUPud/G/7D6NpgYn+oeaxgNYNlV3pLf6lqaCAnIzNFAGei8kecpjheU0DRRZXScpA45oFmhLtCJOOSMcrUtnX5fTHiBG7PI7i66/s9tWePo9oJXoCdSFMBm0Av0qpT3oL5MSv8Gr6bEFJgj8o8FxdEYxWV1cRK1TA4kGbviTEhvlkBg/rWVcP3rBLguys6y/JGUcuHrXOs/dj12EGed2tgAM0PmexrTGfEa5N6MVniyNXFfuNiMzWI/o0KmP2GNja7o+yNWfVAYHWuX4yZdcCsaCcwE2sph28H2Fm3dgZAlxnt7/7mYlNd4X9reGA/HRAz+LS4CqQTvR+9zJ1lr9rYOMmcFaSZNRLiqaFAgkQwcZQbdWBrJy+OHFqdmjauY+evYL98GAwKaiDs3+73ejyI7ptYx7noxMSqR/WJlrezkbOgYPDo78wpZkuIXMWhqPoT+Rd+B9m98aMKD4jSuPWvzlzAB5ZO9JkMHKp1cLTju00maiV6TRBG9YANDgf59euwS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(5660300002)(4326008)(66946007)(66556008)(8936002)(316002)(8676002)(41300700001)(4744005)(6916009)(186003)(2906002)(478600001)(66476007)(6486002)(6506007)(6512007)(26005)(36756003)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNgQgOOWi0UuXdIow/vaBfvAV5T7X4Ycvp8xp1JSvtyZp/uf1UOd+TaX6zoJ?=
 =?us-ascii?Q?1fVMwr9EHZe7bQvKj9vYsjuHzxOQDkzq6j+lSgzR6KINHnjz6rh7UUoUahOX?=
 =?us-ascii?Q?eaDxxusTIHpuW88Vs+IPwCI7t1WFWOMKlbS+nuurACMxoL2FwF4yBjxwRPLh?=
 =?us-ascii?Q?OKr7JKx5cuvyxYOFqvAZzQ3Wcca6sDcAfn8zo1pmaaBCkTMbOjWuuPLfdALe?=
 =?us-ascii?Q?sRF5rYr5zW444V6aPJPVoPNavV86xf41YpM07hRF5J7ptKuvh5vhMa6tGFaV?=
 =?us-ascii?Q?KaAM0Fcwrv6mtTz6ZN8bUSiYbDoUYUHR76syWtv9Wdr5eJWX2AmS1qg5SkWA?=
 =?us-ascii?Q?nW+TqTEALx1Z0TgAhFmAjWYHqtEpKUk/TbQy1CUwxnagkWRa3hM/15NQtkiz?=
 =?us-ascii?Q?8wWtEPxvZXZigq4wpjeDeDldfwitFT+hmMKiwJ4ZjOojYAXpOtGQwbjblZFK?=
 =?us-ascii?Q?dchTtIXBt+1kCJrj4ox4YLrppazz/z5QbYO2is3/bLKvUCrfUK+XD2SwYzi4?=
 =?us-ascii?Q?JtGNoUbLKfh4rv7gWv9x52nFhAij58CEBB5zk6ZHLnodn9MSMUBU7sv1YRuk?=
 =?us-ascii?Q?XPB3fi83IX8MUi0/BBL4LilXPzDgBVPqWHzoVXfEA3uxygcAy6iTWQPWiLrP?=
 =?us-ascii?Q?Hqz1ePs0NB68q1KnI9bl+XItaD0l+ZTdz+FEFcO709NgpKuxx7Ptq6AZVrqu?=
 =?us-ascii?Q?Jlmdvp4QZqnfmtsp/F3ZO13f9QHHHjFt6lZI8YWSYtPZUPo2fcv6omFKyy+7?=
 =?us-ascii?Q?iRlMz2kvGZcuHqiyA4L5i4ZzUY0ua5+TcdSXtcK0cTkQmQnG+MgBx5tf9vWC?=
 =?us-ascii?Q?g+X6eBmQOD4dJ0KxPmwXXrQMRmA7PPk7bxbuili5m/1igkdQciYsYfpBLhge?=
 =?us-ascii?Q?Hyk96ZHg7/TFe5M8bH9+yVJzTBRAh22IU6ps9X5SFvunn53On7ie0ndKERE8?=
 =?us-ascii?Q?fAm5K144Ryse084usApPysL8IzrdtwRMDXB+ua/IqRwjCat8WDbtEi2drJuH?=
 =?us-ascii?Q?wOGrgCeawmHh+szp2izqkmDxVT9Sp/oO9Zv8EvwBbawIJdqfFWLfzezTAXLu?=
 =?us-ascii?Q?0nLrY3lf1Y+NYgxrqMGf1nosaAkEue0vulVkr7xlVnD4y6c6abo8F9n/57RE?=
 =?us-ascii?Q?N0a+itDjjL0wKSLZ/XzTO+dyyXrwMJ+hkHL4Xa3IAFr4Q9YoaJqeBvWaJYqZ?=
 =?us-ascii?Q?CQ7az2kZ0IUteY4bh12VoA3qM35hVy9DKGiZfNexYDtWILd3vgOpCoy3ejTV?=
 =?us-ascii?Q?NnvD+rC3L/zr/cC8OQXo7xs29UHFlSlWeSsuwnQgh6SPR2PYwnS90EEqzgGs?=
 =?us-ascii?Q?z2X1yFJfAxjqOc+sOgSC07Ot8MJsPAE5KrHwLjXkCANCMCKv08vX/aOMBBjR?=
 =?us-ascii?Q?9pjrT7kVGLAEt9yqB+cIIf3JElSR4z7XUPylq58cubzzidw3RAkQlHohPfo+?=
 =?us-ascii?Q?NB+7F5jpPc4MizfKn3pY4FuPQEYZJbgxCB1qGaZZZsMyOGVlP6aJKYEkmi9c?=
 =?us-ascii?Q?kkQgw3IJzGJ0pI01dFTQhdchBwLL6riRQBe6ENOWq5NF2hfDJeT57zUEQ0q9?=
 =?us-ascii?Q?eT0nyP8XTnLf/aFN/Zuu2Ci0Vy8KLOB7Fyt6nHdK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a563d9f2-c3a4-48b4-245d-08db6b71b7b1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:20:36.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BnzvAvrCW6uC6kK1r7YSmTmO3ptAoIQMk4uGUT1oKdf0sKiukYJiVlhpUXNQ/Fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index c4e9077..f34e624 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -41,6 +41,7 @@
>  #define __BNXT_RE_UVERBS_ABI_H__
>  
>  #include <linux/types.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
>  
>  #define BNXT_RE_ABI_VERSION	1
>  
> @@ -51,6 +52,7 @@
>  enum {
>  	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
>  	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL,
> +	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
>  };
>  
>  enum bnxt_re_wqe_mode {
> @@ -78,6 +80,7 @@ struct bnxt_re_uctx_resp {
>   * not 8 byted aligned. To avoid undesired padding in various cases we have to
>   * set this struct to packed.
>   */
> +
>  struct bnxt_re_pd_resp {
>  	__u32 pdid;
>  	__u32 dpi;

Bogus space

Jason
