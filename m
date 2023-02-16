Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F0699878
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBPPM2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 10:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBPPM2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 10:12:28 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241330FF
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 07:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1mkCRDN4+weGr6Q1dXDx8AmWX12LrFIMQwvEgBloSPUoWttQ++bRXt8rWKKmPE9ifnVQ0Kv+bRD+BdJrKA5a7VcSYE4CSDFmjtjtVHwoTgkg3eziIckT4nNAXW/ndYPeWzuIwj1qo+7l9owmGXx8wqJWk4pp5xXc6VsCPHUJj3wXNTHdxXXiw/JGPDIM99ZzBvgFyBc6/JgDixz128ibOD16FbpQG4upySnzpZgjzc4/rubF4ydD5dFo0xfTdtLLxrg5BRA0nZ0jIwtrWVGoso3dBpVHOEKixICufAWgjeCsmoeWhVWY/37mPghMzE8JSv1tv4xxCNv9UO1/saSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpsQXoshNZ7ou2L2FNMB/vwMsWan+n5CH45FjjYYOrs=;
 b=lVl5AleQjSYgJLTXrVNZoavDPuuWCiuPlgyZ+aLEdWplwKiBp3ffVD2qlR91aUN1sLPd+1MeuhlB5cviUNxcuZbxnyOUJbfpByAbYTEUIjzjlHvxS6OAu5DN5zChI+gqBvx4GuFWZD9PhUgRqRRVHisVmP9I7NMHzVzQJRAMa/V3jmpbTn4tUgePp8o/It39Duwme9OIhZdOo0x9ZBVQ6mfpNfRWGkf5OJmN8VK9Ejx0S98BDdbIQTGv0r1pv80hAbmfa/xfMYJDolRH3AVn184Gh0VY7Zr3xaZwBDw8kJuq4I5Hm6dN/c4H3ZJeB6oNjF2C8L0chcMtvOA4G1cQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpsQXoshNZ7ou2L2FNMB/vwMsWan+n5CH45FjjYYOrs=;
 b=M6JaKLiie0nw+eOdT1Sqqq0Tcu6SZO0gnaUV5+TK9kaIn4RLpT161upS+AVmAvqssFwmZ1lQ5IyupQDDcr+y5ur3DaZSF+2NlnUhY313JlvJ88WQ/176FZ2eST2Hluiyro5VKL4ftvyADgAVVGjM4vFZK2U2BW8J9bCD169IIYHc6EUVkNfPTsGJ3QIIlDPJ5xhgWvepwbYhT2rC8yHH7PBuQrCPRSHUzKHvzCu7K2gH8yjO0dBTlNZSTuKVI5DdGAdb1p4qOOIYvju/I4NGdpTQ4Y71B3meEQ/TuGj67KhP/EAuCA5lBRIPbCznrGDhenXgvYcquzaaT3JRGRwF+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 15:12:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 15:12:24 +0000
Date:   Thu, 16 Feb 2023 11:12:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 1/3] IB/hfi1: Fix math bugs in
 hfi1_can_pin_pages()
Message-ID: <Y+5H1nw0Kyse8xyi@nvidia.com>
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
 <167467689891.3649436.5979603883827786631.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167467689891.3649436.5979603883827786631.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:208:134::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3ffdd3-ae59-4ac5-aa62-08db1030350f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrVsQweBol6qGWHOWdjkpt8NFGoUkTIr9xh3NBfcqehfBy1OHd4h3Ok9E7NBq+5nKf6aLywZvwQh9mwPpcWGrW0knbypb9FqUqD+KW23a2HRXBFLtQtQqbcfkmIy3STV9BuoxPTI1Nmc1yOfdI7YSQgHTSvF4qkeI62ELTYPr9tBNZ68R4HHsQUxkiKvSEG9CSX50jo0SFtLnFZu7tA+4USLCMZf6QU+i4ZZXsl6uVaDTkbfb74pArw0DR75VQFJXBowr8H72MussKBAGoz2Lh347G3JJbxq4DuU1H2w4iftMbQjwk5wNIMKqCGVfcXIXgH80U41SMUiqtQcILDN9xejUaw37dFtOSQVYXPNxZvaZdppoqaJv09hwzODHS+gmR81t2ZW2l7In9mMc6Q5imbUoMBKTKzmi80SNaXzwcpMzixMuIhP8L2q29AHzLsaypZuHK0WQ74HF8piSr53odD9SNjbd7Fw2axjxAH753gl0J0mnc+GwD1lZeM0jB2tZYw9b/LvURJpPWL85H23qFVOJKnzYqDCFY1kE3P+7buM5v4nNiksdcpGMLu5Zf2Li0BT5XwbjT8MgUQkM7dTTYoLN8hruvRL6aMNtU4j3+PM03hKEu5OWiUdfqhwLIvLR/W9KvCgVwwut8gdV2a9LJo5lePGJHpISe+R10mzHm1BuoeZJutPComebJBxEN62
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(36756003)(2906002)(54906003)(5660300002)(8936002)(66946007)(66476007)(316002)(66556008)(6916009)(4326008)(41300700001)(478600001)(8676002)(4744005)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(2616005)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/LfpKw4Ls7C4momHu/gEtKz8SVHNSuQJi2+B8n9dr99uupuXIKITMBB+137?=
 =?us-ascii?Q?CHDt64i9UWN5T7Jlj03BHFiAEwGw0w6goCAKXPuqW9QbAIXirpNmJPEUryGZ?=
 =?us-ascii?Q?/SRFc8i/dvUOiYifxUZexEHP+ZOMk+pX0C0sO6joLUdF4NUubhoXEEaelwti?=
 =?us-ascii?Q?Ivd6BZZkEoQzlEiFhAAlC4xngLCx1uRiusKfbvIdt9xNX81pvHHUuF6GqxQb?=
 =?us-ascii?Q?H4k/E/+mWGVaDV4BE+Sn9x5QT+Vs2AZO6ZuCqo+ix1AvtvAoKXd4YifiWgTu?=
 =?us-ascii?Q?G9e7YvQw3IsyF6KSRyqJM23jDeCWiacwn6HUNmxMclic2SR4y9bj8p2Fgy+b?=
 =?us-ascii?Q?Mgv70DlbFf39ZUGf26L1u8L8erytaKrwFtWVFeFp+JoYSQQiXYndT+v6gv6T?=
 =?us-ascii?Q?Ujgur2PsqAVDRAOM9Ep8u2TiVX3kimIzyzZhGv1hELwVpJVdxMzdfkg/mITO?=
 =?us-ascii?Q?Nmk6CWIe/zAggYfwYv8K9obElMz5Ct9lw4vuYX53fp6hK5Tfzx5K3xUiU+hG?=
 =?us-ascii?Q?LMVgR56nqIep5X5iNYEtOZ1YC/yaXznpaKQFIJJKnc0oIt4ctnZLKi4AHtaQ?=
 =?us-ascii?Q?yvaLtCuzETGDI6SJDlQ8Uce3vwZLVLdEZN1ENqfoKipHuzseayGCaJNmEayq?=
 =?us-ascii?Q?a+VbEuqN9bku+lrua/ci5If5w4cfTSuGPs2aS4P2QEisI+Aie5P/izj99k/K?=
 =?us-ascii?Q?0ix6ZIXfzE17iTP/cuy5y2ATWVwGHJfePinBZw38U9auTW24l0LbU+1JrOWI?=
 =?us-ascii?Q?VDB57uonUkD/eXrgJtD/TTt0zSPbM793NIzfdrUrasGxQkAbzQNl1pZC6ePT?=
 =?us-ascii?Q?1nZHVXvvJ51R0ULT5ZwwC/gif23Y/gcggyiA7oentNJe+xAYppbxyqacjGc+?=
 =?us-ascii?Q?kgGwWHGIXiFFELe8d84/Sd2h2yB98P07uZBHvxOy5gFC9Sp1ZUq1zG75S0KA?=
 =?us-ascii?Q?CSzM21V/g/PRhwJAuC1/N3R6XQRTrIymGik5CILXglbG3pbssNnR/PmavV31?=
 =?us-ascii?Q?Xtg2b6u84BJ2EE4L5zUk2Q2ko8YRHwZUwRI0UIashaKYqeMlLr69JzTceOBy?=
 =?us-ascii?Q?EZHcKfE9MxEi2tn4//lTCLWtwwyDqznmTtnuernRgZpkZBv3WVhQx4JR7iOv?=
 =?us-ascii?Q?EYiZadmPml1I6p4aU8SZ1+h6Z1CzB1FOsA6Ki2os8txc2dFPxn81FL1i4Xmr?=
 =?us-ascii?Q?4EHNlspc7PkEqBP1sv4BCaQWiWBqjfQa0SDJjj1vObJTlgO/pA+FEKha0z7z?=
 =?us-ascii?Q?DpjnhdN3Bs93zLeSuScknwQcOKDYjZFlI9/1RhDI6geuiG17qBvUo1DWZd2B?=
 =?us-ascii?Q?tOKgqb4TKzKjHzQIGwDxHVKlW1G4OLG39aL/Edb6/Rnh+kazohwTjwjiHOiW?=
 =?us-ascii?Q?XsthWCN/e2XFTlVc6qZ+Y2OTDE7ifBkHVyoGDCuZ0fv2HdVrMXRpPY3qjWFA?=
 =?us-ascii?Q?J698Uh6wVIa5WWTfc2wuz36mx+skSmmiiojIkEkVqOUjHXvl6CLQ0vFVsmAz?=
 =?us-ascii?Q?cEjohqoAWX1w/+R5Im3kFuQrbZmx8LsVQIKaIX7tll4ypntbb1Iy1sFwaCZ3?=
 =?us-ascii?Q?OsIy2Q+ZWxVuIT4HUJ/i4V1XesxAJie8KTIK5lKa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3ffdd3-ae59-4ac5-aa62-08db1030350f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:12:23.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43/FhAttgRzVZa8Y6jZQOIMkrSlnyMiZP6hUQNFOw8PVXVvl71CcBm6Q2iJnpn1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 25, 2023 at 03:01:38PM -0500, Dennis Dalessandro wrote:
> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
> 
> Fix arithmetic and logic errors in hfi1_can_pin_pages() that  would allow
> hfi1 to attempt pinning pages in cases where it should not because of
> resource limits or lack of required capability.
> 
> Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
> Signed-off-by: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/user_pages.c |   61 ++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 21 deletions(-)

I was going to take these first two patches, but where are the fixes
lines for things that are clearly bug fixes?

Jason
