Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0224E9590
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiC1LqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243294AbiC1Lol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 07:44:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10AAE7A
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 04:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoVJgyAzC33Raqr/AAm5tXif7GZDUFCG0Tkp4fgiZ8WOUb+yuM1KuiCsKWkK9tdezna+Srv7mRb5el/KwKkQG4a47h7+aI/DdBgiSvuN/H14Tmr+BFWY64hZ3hMPy/gqDUcpKK27HCSS/Xk75RaiRY92zKavPX5Nd3AWmZjAwCBDh1qp4MXDh4GnI0axJaXzh/3JBemmKATirJvk9YRlNh6lnoQCZglW/QepXMALAhFj9gsGNAUdilfyhmnc7j9urRgufEjO5Nn16rcRqwz5IOuph6Beb9gEfKkHAHKNdN8MJsB2k/vkEPWpDCr6BysovOu7Z1CjCYN7uotlCqyNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x6yqMWd+Xreta1gT3FAP9e1faod9VH1FRAn7hwtl5A=;
 b=D+Sv3lDrHwukLjqJbH+MfREfdYQ1cC2vmTyFqwkUpLkdpOWkT4HGrMOm5jSKX6ATfV1mdGJL7ZCOH1/ohIVh5hx5IpprSkoAfEtR2hrvrtSPp4k5DHudS82Af7JRXQDZa+vU9EIaDE1i8JxK7G9mVueoJ/Ze7vFAnAij0mKw09F+ZluWH908SKDTkEVrA9Xv2P1aNSb0jlPI8QVxGiaTO/CU2F+v0vAgUSXeq0i77PcvhNK51cX+rFuAQT7AFZnQP4arprRMS0+qme0trIJ6s/A9C074gRJLc8xfVaVqi/bDx8R+k2S1whGOVecAy7TP4J6t1rGsy3ODc9wGepqEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x6yqMWd+Xreta1gT3FAP9e1faod9VH1FRAn7hwtl5A=;
 b=C/wKadMw3IYfpirzxzKndHJFmLaG73vrZMXWzhiO9cmu9Z6E8EwjsaxxIibSYZlgG5gFAwq+qv4XIKztN9UpqCwSRfAFfQryTNbaKq85Txaq5xal/saw/dfGAqIfGaL/bwjJolaMVgSCDBF5zBbyL0CrAiMUZoKA0/agKevZK2gQbjg/6WfOHMOnrcb0VTYoujTecNyyL0LxiZHEfgQsJ6+yEzmKplvvxAhixg/1YbQFTSAL6HmooGRkGHjm5/VvXPIlzpoaszk5uWFtoLCAWd2684A4vjhFWAcxudcBOXMb2fh87uXC5FUSc1MSDAs94BobApWIvb5Y4CTvr5Ox9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 11:39:48 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 11:39:48 +0000
Date:   Mon, 28 Mar 2022 08:39:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Message-ID: <20220328113947.GG1342626@nvidia.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
 <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
 <20220325132252.GB1342626@nvidia.com>
 <470872a3-3191-905a-f1f1-8452455d5ca1@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470872a3-3191-905a-f1f1-8452455d5ca1@fujitsu.com>
X-ClientProxiedBy: BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05183ea-d85e-41e3-e01e-08da10afa9d6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB255079D278629B3A38908E22C21D9@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6XL7BhhCPcoOFclDvArAC3uLZm+LC6sVpzdtmUVUW8IeBDdPToug6jSaurJhD8R8t3h/NWRLtVRtc7NXTe3RMikbXTAn9iub0CAFj3zKSQl96DKuj1e4sY2gKAD0PQm0oEzRS/D5jhZqmPwZVH8Tc3QcBGno6lQM5AHSJGtA2BGQ9PgS6L5G2C/iy8Y+fMX914ByUOa/v+nYgpej/BPC5yh4lZH1A6Y1zA+/nEs7oqYWg8aqqkPXB9h1oXH7IC/jcpdOxgPbk211+UFJHyENuikT1a+i002gEzJ75EWQSdfLtVr94O7mujJAesjmycaNSFlm6NLsB7+uZIBMv6dDjwjqYg8NCkpHwm8+fPyzBfkQNWkloEvarpQnju0HK3msOhue5CnH28m07fzgxTv01cRos0J+Xr4VP3m9H16c4xUMDn596yLio14dzFcR6netrl429rX2havVqbwzf9sSQCLk5HwTDPdSaWwWhnrRa6o+Sa8L1kp+WUtMT2SCVlU7Sn8ENRB4hzQQ/RTi/FmHFTdj53u6KP7JIcK3hhJbhMc7vJMj44gnYqWwe/S6cNenmqG52Uz8H9VJ61N5CAKSnhpuJiSMrgRj4UAEoNJFb0iWxa3OShHvJs/wmodg6IrSF59EABL4QNgrwvsGMNvCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(36756003)(6512007)(6506007)(316002)(6916009)(66476007)(66556008)(66946007)(53546011)(8676002)(508600001)(6486002)(33656002)(2906002)(54906003)(2616005)(1076003)(26005)(186003)(5660300002)(4326008)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Q6vebeDDwQwAUqT15cXvm692uv48fgv13gIL196Y21IbE0ubTfXHm4t+fKW?=
 =?us-ascii?Q?HxS+Vh9KdMIGnSashbk9WILCSU6M6K7Qx4fNlrttcWll5UtQfvdrP1a65OES?=
 =?us-ascii?Q?s7YlCiUAeCNhH26T7VETyGlGyHg+JIfWydg8y7Yff2o+vEzt5xLkI/7bfxWs?=
 =?us-ascii?Q?IrjNltCKR6mTkWvSmg+jObpRds04g40t/AKO/gwDbR3cvGKs1D9b8op8CfJe?=
 =?us-ascii?Q?fid+CcGwnqAiBkN6JFv1fjJMLzBDzKO0hBwtezhsbX2sF/GYyukyDwfhK19h?=
 =?us-ascii?Q?1r2Be84y3xG4aO/rGIY7Zr5ofPqPrygad/qCCNAfdvYgliUaqbGCNbDNFXao?=
 =?us-ascii?Q?WdMOhqYA4Y5dMDEoLhYyTpFebX1DxMyFhIJIMv8UpHCn7GUo5+NMcoPEbPTQ?=
 =?us-ascii?Q?0Zzs9B0HxD585fUmiS0cvkwoqAm9AR4045SkBulIu3VqT0PFrQGb5ZmmNvxN?=
 =?us-ascii?Q?Rk7X2ETOhrfkoftuZp1GonRC+q2sCoahQq0qgeO1XPs2fKwtyAqyiApHnoHm?=
 =?us-ascii?Q?ppdr4bH2CjZ7SXrAw7a/LfRwSpz8P58oPrXAK1juHMqYeaZv2Izcohv0nT/3?=
 =?us-ascii?Q?ZL8VYO44hMN+WFPUTJ6ymt069xZMrxMr2k6DWLlWx+pzfFjgpq7EtJToFCr8?=
 =?us-ascii?Q?6A1wUYmagwQD8zzMGOq0RgpR1ZIpQlR7DZOofxl2QfcbEg+hrsL/+f/EbA5B?=
 =?us-ascii?Q?6OLTFjj9arOBaYkTeiLtnV3rwnhp0tZoOkc7XiYwfRTylY7sZ8eIsouoONpS?=
 =?us-ascii?Q?zuVcUZwxTNcdhEUHfveXyCVtK9A0D26SeIMyGiQjmQisvnbAhs4dJHpEtXcm?=
 =?us-ascii?Q?I5xVR54u+viv19+WBFcIcH2Mza5L43nGD5ziQa99Kf4WJ27Zwgb72EnUc6Tb?=
 =?us-ascii?Q?5S7+TKOhAa4s14Z3+ZGAGWiGuYR4/MXv8+80qoMOpeTdYcUtjdViei3OubMx?=
 =?us-ascii?Q?sAkJk4RccvRR3o7wGQvT66IAmNbIJN24OUbSGKBnNU9V+84knPgOE7aJx6Bu?=
 =?us-ascii?Q?29Xgp7u6rtRYY0qP3W+T6IEmStyqzO+bsn1wlgVXf+wqYGsS2uwmF+14bxrb?=
 =?us-ascii?Q?tQQUP5lgQBMa+FSfysiCnhZ9DLJ+d0dR3v+4nzjKotSs0tuub/6B62EN7+Z+?=
 =?us-ascii?Q?NKQBT7Ij0AJmCZ9UDGhCE1Qwdcgp5oFyPuY2T+GVuHm6toCNayKEw0jG4Tcs?=
 =?us-ascii?Q?3DzCacXO0qbtEvLDbCkbvpYljp/CPZCnixl6XO1BFq2bJMRoeSzx3g5QqIno?=
 =?us-ascii?Q?D2DpYuXpbAOp4XHon9jLSnstYLg0amBi8K1SuxZvPnyBfEUDRYMBNlwvm1L0?=
 =?us-ascii?Q?5JwD6dlhWju7k9GHXRE+5nJ3JRGCMxpxFv4sV5weXzrDsiGLtquViL9IzPIJ?=
 =?us-ascii?Q?vqwbhb4mpEa9Nn4xeTP9WK0Dbc/eNk4/baJHShoAH/Tt4lOozfEgRbg8QHvy?=
 =?us-ascii?Q?M3t/Rtzi2o3ZLCPKcRjWSJm+RU26vyZL2QpTW5Hca9k2wBsAcTK8yUHwu0Mo?=
 =?us-ascii?Q?25RUNm0YAUqkcJOyebcS1XukgssXtCzoL8lQO0cWOa+ML2NwOUTGFc+magoA?=
 =?us-ascii?Q?z/aj9VG+YLNpByRklll22NaDNs2gYrOhtjElxi7jM9nUtNGMJ2yOP2V8VgxJ?=
 =?us-ascii?Q?V9uCzXLYzk06J3OA5K9/pu0IhQaXTIfyF0x33R4pAYPqI/PPexGnXu9XvKwf?=
 =?us-ascii?Q?V12//tyUGqbZRBSfE0nmTMzW+aq52SGYZ3ztIuG5JEV4mEGXuFwYURF9sKvu?=
 =?us-ascii?Q?oDHwkwmfVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05183ea-d85e-41e3-e01e-08da10afa9d6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 11:39:48.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIcj7aMfxW5TQIYCXvUmLRUTfdAPi5jnZhuhU9U/UIh6tA8qqci//hxPa4IGBVsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 10:07:26AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/3/25 21:22, Jason Gunthorpe wrote:
> > It is not great, but there is not another choice I can see..
> 
> Hi Jason,
> 
> I plan to only disable the key places by the following change so that 
> user cannot use the atomic write:

Isn't there a cap flag too?

Jason
