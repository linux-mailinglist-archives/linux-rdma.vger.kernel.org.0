Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A336EAE2E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDUPkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDUPkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 11:40:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19C118FE;
        Fri, 21 Apr 2023 08:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h536JtpqAXFJQLdjp7hL7DrxRJVBuXb/PgY/v+NHd4D41ArwzaoZLGsnT04frP1D070Wtlnnx3+a2XuBt8tQKN4EEN3NxjLrHRH7MB1/Wvpb7AIgLMXR1o8BlDRBS+hIierYQuKqBNlvLP5TWQu19baLMD2l8r28zbmqRT1DsfzGune7Jxhah3z8OuS2k8MPrRi7XpLicG70d+71qJzpQw03PPnBFa6YhaywF60cfkHbhpWOEpIHFZepqo1WoSfw3z9BYicm7oAsq6cMCEJe7LOL6/ISmt8vSotXBGO534V6LLe7JhbJcW4s8VBzO0NBINc7jaEw+nkWEV8bxbi2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vYmNgFhp1D4RYBS2rADXRrRpTIa9oyTxt5quM7txDQ=;
 b=hOLmM1omtNSh/GPJrExHi59ldMNDT+ZP40ugrKe4TAom7v6imxmdDP7v6i25KuhzBqj+Vv5thpN/SdSNtNcj6iO0isM/e7gvOc4zhYhC8EtSi/6U0J9ua7IAQea8iTwQCqyxnUrVzf7jfJ7qJlll7QmFw0Er5RjDawf2APCsy1pMu2FOgHTCZqmB0iFYWDjf00QGxYgC8uawBMGWXO2D1uIfsXvKo3q0wKsaAfutgVFOKhsb7RJhDxoCi1ao53wldJ2J5nZcWlHxK4e0lFFqfuCvKq2Bz2QmHV9yjuRmz2INgWXofetgzGwe8Kg6hV9lFNSL0e3jYjVaPJ33FxBU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vYmNgFhp1D4RYBS2rADXRrRpTIa9oyTxt5quM7txDQ=;
 b=DWeLcfgU9fb/dPK9w6UbV/9pxguGBkgkpo0tH2SENXfbYhbt9WqvGOGs4r6sR+vKhNrNzRwz7cZUMmArgdtRuKxd85Yx6vUzOhXB6btXELKEUiUgfUFKylJ3XjWCDbXvsVAUzkVJrulzW4JZ4YsvQBUYWEK+fglVHfwXH60HCiVgM584A+qnR9/PZBPOgO+ek+K7UbK59answk50BqdREWafP3MgqKwUysP3co3Ovib2r2yG+V/WGRCFOnlV2lYisy6hHb5LQKp1a13IitL9lNAfwudyWaHCGJeNa3jLA/xzix1rSpUMV9ywvPJXORKkHSoMr6ArnclfNL4+4kso/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 15:39:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 15:39:58 +0000
Date:   Fri, 21 Apr 2023 12:39:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <ZEKuTBvDNPJ+4Ylm@nvidia.com>
References: <ZEGW-IcFReR1juVM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGW-IcFReR1juVM@slm.duckdns.org>
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f89604-e18b-4069-e37b-08db427ea954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZMUPgCeTyG5fC2AjiwpExNR8bodW98bWsbUDL75rK+B51tu4jABEVbMEhLRcM7FimmHC9L7pkcE7GWfV1KLsVibXZVH4JclXMKBe+vs0X2WCVr3DvypMfTYlxy+veqsO28pqE9cXIzsvnTeHUW9WMchPjwKnNb+72uDlG4oxiBRdap5A7qF3szCPGHpTK5ksl/SV9zwB9rdcM5droXlUen1k+8D5Iw48V7Zg2cYOaEnHEquPnUKTFXKvuiHvYkx1ICTV7FbtQf/0hiulUeeIa2vreMhnKRK7Q+FpdlCFY96YZZRfo8d2Q9Jdak8jcs2ku0Atay+IIvmowDhuFwYOAJjUQIko7jrKMSDT5tNOVdIejkP7mI2lskH5eBa7G+qJmcTfyhCDGHiDk0nUDBv8Z5uYE7eAIUtuXPSGDlSClwJzuGwJb2jWudA0aFRIaj5NTT8Uzyk/yW42pIhEdtQd3/A13fpxmThh7+7jy20mBshHzQIQUoZj1HsvjZCvMvZQlszCOVQxX1cdj5lUuPe4v1a40aNgVsJT9LtVjx8oGmPM3ngSle1Qa9WTseKq1rHbCGyLLm8MoP7YyNCJuObcwBfepTg3I+Y0NgmLY/8kz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(2616005)(2906002)(4744005)(38100700002)(86362001)(478600001)(316002)(41300700001)(66476007)(66946007)(66556008)(4326008)(6916009)(26005)(54906003)(6512007)(6506007)(6486002)(186003)(36756003)(8676002)(8936002)(83380400001)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ubfq9NBkD8Y30EIgCG7AlW8BWA4IOGosBdDqciRtVbTBAW4JQoYHBrD7VD5?=
 =?us-ascii?Q?DP44Bbw6CTPQhmBPtECyGLO8lx32/Y+shdba9YU9bQ8lqskNHxjbXVNjV9/1?=
 =?us-ascii?Q?Cc+KxY2MSkVUyHaWjOBGEuGqaMR6YWnQZCOku4T3xggH2qz7GppRwJJ8VGll?=
 =?us-ascii?Q?/T9OmstJekLLP9JjUiPtDl0QTQfXluUfd4158NhUfaIxGYeE5hWNQdIQuIQG?=
 =?us-ascii?Q?+px6oWJO8RlPRdob8enBcU/ME33SQAT32zqWjx8ecRlTFDTSCRFah1vnMMNo?=
 =?us-ascii?Q?UYO7/RIjU/IMvxj/pR4S6+vUryWz9qz0eP/5JoOGlCZYmit3e+zMFr6C/C3o?=
 =?us-ascii?Q?oRyx+8EgS4VbnscAOPOF4yYzZ6OH8ZKcIJ6pPHCDvnEOr67cuQkwVy7JtCkF?=
 =?us-ascii?Q?K2EV5I5+WpflCMaav5GiYxathNZLOuu9QHB94260pr+6de9qj7jl7BA83LCB?=
 =?us-ascii?Q?wjrUsEqU37VG/gui7pyYAUbyYIKwWS9MeaHjFcGkbJXtu2Ed+tswfeB/XsUz?=
 =?us-ascii?Q?k42v/EeehmgNol03nPwYYf6tRyEzZNmsmrMpJtHRp9MMjvdtxwSTAmnebvBX?=
 =?us-ascii?Q?CE49xmZKJiX+C5JRKDALLYgf9EGsJQmo9s7EgtUEB7lfM/yR7hQEwoDPTCu7?=
 =?us-ascii?Q?zmRwEleCQ770VFKrDrI+IyB7QckoxlP3PFG7OKk1BHJUekspoz8Ya2pT30Aj?=
 =?us-ascii?Q?seZJfyOAkmFFihFGmi8MW0FsjS6YEtbj61Q/9kg5Df34vur9WzD4AMc/emjz?=
 =?us-ascii?Q?3X2/0qQ8yWn9NWj1QdbALCkyh6lHQ6662JIH8hxMcnqHkeBMxQyIIhUCRwt8?=
 =?us-ascii?Q?bf/l3Yf/SW3n3jRDMvCm9b3CvUSOl3hp81h+35Llvu/9DUPX/AYu5DotntP5?=
 =?us-ascii?Q?UkW1le9V8faRY3i7VPMhAtysC0cJ9OS7lYU0ibXyiCwpH+WIuGKZCxmxJkhC?=
 =?us-ascii?Q?eFnuUMLgq1LSrCqIeRSq7YhbKh7+YaOFnxG4JYY4Pq46WHdy7u5RPW/UO+WI?=
 =?us-ascii?Q?hgG7+u4SKcEf3dLtb1tQyMjlm+4Gs/h1WHoqDUoQh6slItHKyC6W6Z/fDiEu?=
 =?us-ascii?Q?doywX8jmDuGw1IDWxJ/cNHck8OQci3Q0+ev+8YcONAO1Muv5geRlLDF4hdu1?=
 =?us-ascii?Q?63ehSajEz1b2V5iVnUO1EMciRblP/IdzzS/v76XCv3B4wVf5C5GDTU5Tt8eR?=
 =?us-ascii?Q?88ebrZVgXXAcWP83HjEm09rGE/60sFsLPTuGqkcrXd+X/0dFHAik+ziZC6fV?=
 =?us-ascii?Q?rabsbR8A/rOE6VWUMPn5gQXA+CC0AmJY8UXGDkWDr+N8IIFOgZ/vLpD4jUE0?=
 =?us-ascii?Q?++NjTr6ZMm8KXeXWCAjiAP4YXqKphTMJsTk/JwbihSTPlxB/hdGwCD3bJjgk?=
 =?us-ascii?Q?NDnSSDShQiRQbAbCvYL43SfI3kbyVsntyMEtCoZWd+YbNkYmjebKTMXiFw7U?=
 =?us-ascii?Q?cYfsy5oQ/WijyctQzlbeI1GmTpEm83s6NztkeanXphKzCSMi68/OMm47cc3j?=
 =?us-ascii?Q?qVUbBCiRM3xtKGpaRqlU3vwzKLrehzst40vbo3NbmWFxr9SXDSMx7DKacUr/?=
 =?us-ascii?Q?7Pqd9imks98wJQNtlUjnuEEPJ2EkIq/vc3erh88Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f89604-e18b-4069-e37b-08db427ea954
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:39:58.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMSi9KM8iMsiH15CbHDUCV53NHOm1EXixEkbLvLRtVToXPMlsVs0B29FE+09k4ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

On Thu, Apr 20, 2023 at 09:48:08AM -1000, Tejun Heo wrote:
> Workqueue is in the process of cleaning up the distinction between unbound
> workqueues w/ @nr_active==1 and ordered workqueues. Explicit WQ_UNBOUND
> isn't needed for alloc_ordered_workqueue() and will trigger a warning in the
> future. Let's remove it. This doesn't cause any functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
