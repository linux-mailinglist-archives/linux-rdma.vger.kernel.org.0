Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF4E611ABD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiJ1TQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1TQX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 15:16:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13533234795
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 12:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUM+oY3QeMF4ckWz5J04LpBIdm05Q1VinF7ABxfPpTTQBlGm8MNA6S4d9nETHG4Bo7C+IMLYbNeobNGU8GwAp108UePoiSOKYdktAnINmV+xiZ0daDsqaAdeLgif5kkYF3tWoruu7xOPdPgxGvhB+ueNmfZyJM3u5rYnCl+2+SV1bbXOCBi4anbXLwMDbVGpAE8u8sKI1gYlz/dx46u16SLLAJLA2oTtPCXtH/nWIxRlLZeUP9NHm8csPvCbT58MM6Qi1RlqEFJSJAIog0Cp6UCYHoh0gJAEm8VFS1o0DukgfntBO5f5ZhvTVU+zr51adsDcgxpfPpPIwesL6s2U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUIgE1yZI5b1p7GUhgfy8zTQaM9ihYOVby3s01k8NYA=;
 b=LFsfKdjhZTJt1c7M7e8moOWv3gYx5qFNB3Yuuih6SuVBPKx0vqfhThv4NekmeKRfEbuy037j1OXQbol/HMhD95nPUJ/KLWCXUvxb/hKj82Zu0tPGh+OsCj0lFhZKbYfPJrDKw/Bm8pdwV+2rGMEuE8H66LZvwdw6SnlnF0hj/CBnqhj7ZJbMmvKs8dJtfatWwFjF0PSM/lfWjwg7+gV4CEd5caBqBh0mqp3/uLV8gRY4OakXw17mVC50Zhs2LBi8UyR8KtAKZk1Pl1Fr0RDshj49Xb5tlM11Ux0Uqvn3Oz3oqNph88PQ4LipZrJ/vHONBKnZkVRrGnFMloyW7jONLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUIgE1yZI5b1p7GUhgfy8zTQaM9ihYOVby3s01k8NYA=;
 b=R2jj6oQC+Lqi+Ikx8oXLyWe9LvXpNaln/9NhWv4g8ir+CFEvfZHtQg5NiUvSIzSg2XhbEZgLdbKYpwiszTuydw1RrU1yclIa9wz01d4lO97RBDHo1L0PEtRijksbssbOrD5emDaZGSmyV7nRmLtUuEJmxDRIJPQBUfFstqqfMFaGBreCuUh8Ckph6FPmcZdA3O9IPKeqW6rESNOKGVx71eE3gMREDKD85ubqn9CGUscXQitCU+68IpTp9mSxSyyNbuAkmB41zYsqhhlaK132BRp76v0jCnl+knin5ET1pWCBeuphMEzzr76/eN9PHpPwqa2nkgzchaBh8AJQKJGlbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Fri, 28 Oct
 2022 19:16:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:16:19 +0000
Date:   Fri, 28 Oct 2022 16:16:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe
Message-ID: <Y1wqglqKKz2oVgcM@nvidia.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <Y1wLi5lFAGeeS9T3@nvidia.com>
 <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
 <Y1wcyzvH5gMNxpaZ@nvidia.com>
 <83d14def-32e3-41b6-31c6-786dc5059eea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d14def-32e3-41b6-31c6-786dc5059eea@gmail.com>
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a440383-c0c2-4384-33c0-08dab918e474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxCPZBm1dLOhDetirS6odYHOGK0068B958L+0n1moL0Gaqaf2tXsND8Vxgfez/juN+l/8Dz6q9uDLiGcPCktOtPUdtlpc+M3HTc0NUCOoVseGn5aiD5l834mVWpehdzHaLWR+WUlZFKseOoPw9P+Oekjle5GRmSfhcnUAZ7wTOKKL5gUk9tWTTDmUJjqfAgoSlkkauw9Jdc8jjYZaCaCThj9SzjC/yc2TPcYnD3PoaFca897siQqUQDClQG6knDKPrypp9lepg86Xfev0ASL/XOm/sdsQn6y4Gw/66En2z9IyLY+CjVKFdjDjf7xUIBJSwjtvoICFLrV7lZ0QZRUFugQGp2yLgT5d9DFSzp3dD7g5vgrwXffoe8fOMcfoO3YcAa4ORpMQxqbigaZK68qYuhLdvOM87y7N7861EWcQJ0gEPmUGioJSoBYlaWa0PNdigTy+Yxa24MehECIP5k7qyxJQUxkgpwzC/cPJEf9+MRZB8xu+2PpB+fVv9HH1jamc12RA4JvEecLNfOWEZ4jHN2uigwie1EMkbvQR9Cj5sqfXJIGT3JHQZ696Lh3RDl8kjmEXuicg3N3vGtc49tsTnABL0Eg+JDrAiekuf73YrbD6rK5Y2pXLC9YXPk5Ohi8OLUiiQt3JpbxVExfoOov4inwYOqjrz/+0KEyRvmMZfv6LjWeeXBo1HcJr1UR+Akobr2jjxX1M5q0QskzpG06trfVhmkd+NrqJ2vEEqQf5imF7wSTLcJz7TQ6skS8nCsG4L8CWRjYcM+jE1XOx9BEZD1yZpJBr3i6P5W8Kl+zcS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(41300700001)(86362001)(6486002)(478600001)(6916009)(4326008)(38100700002)(8936002)(4744005)(8676002)(66946007)(5660300002)(316002)(966005)(66556008)(186003)(6506007)(6512007)(66476007)(83380400001)(26005)(53546011)(36756003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqiNiqxOizcmZT3sWBznAnSIkAvs+KrOuxytUZg5Ry4qY7jpOQLEY6HD8dGO?=
 =?us-ascii?Q?RkKBrAGDR0Y5C1y0OeD0nHj8HRecQV+f1i1Iw6v2hFFSWy26fLhhkrZlp6mh?=
 =?us-ascii?Q?b7C/2H1kX4yrHPntT2sQ75hjxRI99ZgYd8Wv89rL5JEvv1MDTTDipoUWHPac?=
 =?us-ascii?Q?XeaaFFljHFfCJVI/MAH5BkhSLSk5ccugRfufNy8Dzq553hpdP9V2Et8mRGjA?=
 =?us-ascii?Q?D9SSvdEUo7e7LF/V5O63HhcGA1YTbZMRv22zhg/myBCAmej3dBbKzXXRB75B?=
 =?us-ascii?Q?8k7vcQGcoe5Fp/GSUqRNBEzmCvX15FzTQsWmJWsRNyRAXHgPIDH4/ESstD4I?=
 =?us-ascii?Q?4mOlWE40Z9mx+a7NRaJLgMvbxUvZUHZdxxzsu1iRJqZOaq+Zd1VHXw6GHysW?=
 =?us-ascii?Q?HV/NSV02lVyDoOIHRWOBGTgaIlTvUxO+n6nMiLgNl0WY4N3/njFbgSCF12Wd?=
 =?us-ascii?Q?hk5iN3vFtK2jL+xxkfR6H+zGuUPc3ylAWFrNEMYCMkh+3ZiROXts/v1URIU6?=
 =?us-ascii?Q?DJPNQars4VOl+n+zaSHuVywwMUHu8pRhgdGIr8uKw/OrMzu5XWZ2/LN4KnhG?=
 =?us-ascii?Q?mcT0hW+dj65g8np7z1pG0gsJ/+ZJSxIFmwyBE5f4nR7kmdYoYy2HAWDtKSol?=
 =?us-ascii?Q?dVv5MNCKwT5aFBA/N41ZvidjVjbOciJ5ySHtZIW4Yg3frvd9/9IAJ+VgPRay?=
 =?us-ascii?Q?uGy+bTOPOO1q3Ne/maI9pkUzQqkHCSvBvac9LLDt75CgnK8yyI2b8clyuoTP?=
 =?us-ascii?Q?BMS4GwKvy0bMpwA5DAg5GqmjvKhhI9ETJyy8zQIQoymBJW/eueT51Xjk6/dc?=
 =?us-ascii?Q?5FJTQ6fbMdB22RHU7pC/ELYymAEvC4J3jYaUXAfkgSkJEsrcylsswhpPTLSE?=
 =?us-ascii?Q?55sCHYo3OX7/muo79dwcmw2d2AtEKfUcvUjd2pWqEGJNxzqVEYET34IZJdrE?=
 =?us-ascii?Q?RBcqFr0jfYVewWuaU37JVOUSx1hVfFtN9BaJR1QC7ZGBWMX5azFxXCtOKBmF?=
 =?us-ascii?Q?8gOIMzxeDagKAKFmX4/gHPjnrV8uynbNHy1LhP753TJ752yB8/iLNyuO/J1f?=
 =?us-ascii?Q?RSDwPk2T9yiktNuCyoGjs7g2c5M+mqEnqZlXziWNrh3LK+QAzAbTbSlfZLd3?=
 =?us-ascii?Q?GxrJmjcmD2nxv7tlzRG12y1fFbqYSI0pIaO9VLv8Tz1d+NdytxInqrn6VTGL?=
 =?us-ascii?Q?MQkc5GPmsOqg4MXBgbYj7YSjnysgWHlwKBNj8EFk5XlXFV4tIPvJaSWq7Uqe?=
 =?us-ascii?Q?e76ReW7FLdqSx61muPSpxgV/Z0o10Jlr5QEOZSK3FhBd9sJSae93ueOoaReO?=
 =?us-ascii?Q?S8hDMytQQA3vxwyqrvUy9p25kIVgqlv65vNGeKMGoDE8umJgN3SYoUTqv1Eb?=
 =?us-ascii?Q?FM7NcO0ciHD1VWOHAzzlbMb7QejIdbrtQjR/UEfnVQSAJZBd8Co91y6b+JTy?=
 =?us-ascii?Q?0AJ7MA4aO/F0ZrS4M6da6yLkBz/N6l2xh5ArQrfpEGn4qF7HPr0ha1Fk05B+?=
 =?us-ascii?Q?3yBIamHfh63d5gJFoQ0HQ8N6dKl+y7Xp99iJPJ2WhxwO4FdvpbmTmZLJsvwH?=
 =?us-ascii?Q?AXtSAYRmVPwzY2MXZTc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a440383-c0c2-4384-33c0-08dab918e474
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 19:16:19.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiHKdSRPEO2ASN8ygXrl37LAIJYWDP9KnXPgpA/NUw71smsB3BtETNGgNZNr0LEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 01:58:08PM -0500, Bob Pearson wrote:
> On 10/28/22 13:17, Jason Gunthorpe wrote:
> > On Fri, Oct 28, 2022 at 01:16:11PM -0500, Bob Pearson wrote:
> >> On 10/28/22 12:04, Jason Gunthorpe wrote:
> >>>> Bob Pearson (18):
> >>>>   RDMA/rxe: Remove redundant header files
> >>>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
> >>>>   RDMA/rxe: Removed unused name from rxe_task struct
> >>>>   RDMA/rxe: Split rxe_run_task() into two subroutines
> >>>>   RDMA/rxe: Make rxe_do_task static
> >>>
> >>> I took these patches into for-next, the rest will need reposting to
> >>> address the 0-day and decide if we should strip out the work queue
> >>> entirely
> >>>
> >>> Jason
> >>
> >> I'm guessing you meant tasklet??
> > 
> > yes
> > 
> > Jason
> 
> What do you mean by 0-day?? Sounds like a cpu bug we used to talk
> about. But not sure what it has to do with work queue patches.

https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/

Jason
