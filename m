Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06331679D33
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjAXPRg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 10:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjAXPRe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 10:17:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58789274B3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 07:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeqq18mr2c1FXYI48dPPiTdT9Yey1UkMSpgEIlMcZc9isJYCigUAlTNcGtxFdXY8z+yZcLIRREWsinwj6cBAyaYNi6pIpir2kTCxktWqrWib+XCEaH9Q9eugqNZtRAjnOujFPrUphAP7VGq6N5fi/QJYrpgIW8E9V84Y5CtnTjm7w8jM9TtLsQTcimH7BaM2zID4jmwgqhlboFtP0eyDI1cPMu6gYG6jhWFqz6I86ceIj6Pt/50j9AMRBXU4HLjV8QrqvdnxA0uVJZub1xdWwE5jB6b7nD2Lr1gtxC7VhJFaaCb5ZhrgW0O4IGI9nBdHpHD2fXctLOXc3SQ8XRTioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADchnDq2g3bzDvI7K6zxe8oJWkC17evoONKRsTyOh4Y=;
 b=JQEGutk859J4jfsRB3u68dr6rg8n1ylF7/Fq4dXNJ6peIT0i75kpctMVO6PLQ4QeX6MqiX2ZMHcRQrkWypfYNpp9AdQhhdwUBz8TDQrhZrpmBzFzZYDkhlMrUmNbxVEBCBuU2wVIAnCcYRxazD7ZfKqx4F7g6yvTj80Bin4ZX5pA4csqz9Ydq/XG80IriEeCnYDthh5MGEy05eCpGv/5nUlW+t5ErgHylxkE1Brfa98ic4/nwtBbSFBYze7kqVHC9Hr1cWkr7skrFFRCUC3cW+xfTqrz2RtThL1lIxJmIVKDsiNPiFIIdEHvaFchnN2PvzXAfjDetOHD3hBsohWfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADchnDq2g3bzDvI7K6zxe8oJWkC17evoONKRsTyOh4Y=;
 b=TZse4m+PhA6UYHQjBqfLhClxEwOijVfzLBVfza/G2NncA/qR4STn1xgjZPcknonGlb0g6DIXBgB0T6pp5p+t05DcliRAZogaJzWLLpmtoIbdU5o9vw45z6CEUd/Sbt4aL1cAIADJS02gfIMSFC9bQbY4dflmWxwwbvVXksWtx+L9jUszUkii7OpUxO8LO/AkY9BkP9kZXQ5oW5+6xvkIieYNkcVr0ZUMHV1fo35DjjCq9PnUu+31fJ/4Tcr+6LbL1eK9nB3WMAcfjxn6eaaDMwEaG2STUWXUhyG8Hm21ojX9/EWaeZXydTTZEyWph193aSrPwNDdc9bi1X/XHk0K/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:17:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:17:30 +0000
Date:   Tue, 24 Jan 2023 11:17:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     'Zhu Yanjun' <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Message-ID: <Y8/2iFQ+RdMQhtTu@nvidia.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
 <Y87h1Cl7aYXDD49M@nvidia.com>
 <CAD=hENfvup4mwZz9rCjpc5-Oar3mzFDdnvTHoT9FbRVFu28O9g@mail.gmail.com>
 <TYCPR01MB84555933D77D04649BCDF6C3E5C99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB84555933D77D04649BCDF6C3E5C99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2a40d7-3225-4cea-c0f0-08dafe1e1c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4pT1QOiGswHkzvvJ+h33CJpnwgmSPmJkXWNdBJ+M0jeDpIQkhXTBuyrlED/v7qLGRN7rvnc8nn8EFTKxTCCrsE8Jn3nDsFDUYyM8SZIcRRdl0gkep7Z9RFUTL9CrgiVoOW3fHrrs3Nn3DvBUBe0U/I/7Seo/s2CwVAORixDCEPPUh+SqR534VoVW6U7eG3XVgb/j8g2HEbcHs8dc+d89uL+V88CTmQoYEHiRdwdE1K8/hqjosZ9vNh3GpZvfTVpyazOTdKyD51mS8VWD4sXJ+IOLR4OI9pMZ8Nu+hETSLFvTwCTOOmK04wp20r4S05YdlZeVTHkOEWDpB55RrZ0MwzOaaTWYtEzE/4pi8qGXeN5R6e6e/kC7Pe4ezgI+kMR7FIrRjfQvER4gH/rxH8JNSgG6eM4FtdWu3+H8hOIwv+w1p1K4/BS88RniPRUcU39eiaTV/977dLfAtPyLLCAT1IWLdsMlta2x6ZA9/KTILMN/m/DNjoH+Outegbd6RGfhBKWb6dtBwCKB9R9ZD83J7Hn3Fv2Oynzl//F5WnyyLIYHD9nQ38b9OrmQ9uj7FfeGlXKcdBGfndQI9rjkPmfYPlasyOV/FZ1SBdWXyKJoKdNKiwXku6LWmQmSG7xJUuiV8KNEKgy/MmujqJU4kRVKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(83380400001)(86362001)(5660300002)(38100700002)(2906002)(41300700001)(4326008)(8936002)(6512007)(186003)(26005)(6916009)(6506007)(53546011)(8676002)(66556008)(316002)(2616005)(66476007)(54906003)(66946007)(6486002)(478600001)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7Zkbzo/WG7RXPByIytfmTe2A0h59hU+y5efuL9tweDRgxs62SbkcenLhg8+?=
 =?us-ascii?Q?m9LurzT/oUsidGW8qopjAAUG01xw9Q3IjeMGJAGT06kEpTjdtON/qGcNxi+B?=
 =?us-ascii?Q?UVaf9Y58DpFecaQbfxmaqcyxDN4Hp0RDiIIebJCDokzXG5LQMnkDBjMtN2gJ?=
 =?us-ascii?Q?6eIHemiNREYMljO0X1uW9Pn8INt5HKB9Ny1VA8LdybGRLdUlHVqcDqdr6fVa?=
 =?us-ascii?Q?fM/4nBgdJ3M8SDy6DWcrCBqdBS3kV6O49vrzZfXTfBoLK8TzUXa1nJzFLVRz?=
 =?us-ascii?Q?s7qwCUzvVuQnPTrDsXlviiBUVm8OfHGx1Bm0t6Ko9mKAP4S2FONvtzYMWoSv?=
 =?us-ascii?Q?G/LG/ciL5ESSkfe6M5o0gLwZeavd2U7I2UryYUs4U25I16HmhFxlKm7tNhXc?=
 =?us-ascii?Q?SarvdP75SdYcnVZcfXWjd9DR8KvfdfyMDmKFQHRg1trxWl2we90KuCGoSU7W?=
 =?us-ascii?Q?+W55eipmP8h48SM7rZoDlDJyurcuYjy0cRnnL1FzPL/49mpzWoR3jrCIKhBC?=
 =?us-ascii?Q?mJO1ugl9CABsKhzo9L1St5xcXEgl7DJksuj+0wPc/8nweD+QZslMoDuopP56?=
 =?us-ascii?Q?P8VkGrRlk0R6Z+fqxZMmS+ovFbTibHFZRmXZzS4au42SRIISYD0082MeU0y/?=
 =?us-ascii?Q?ipEUIPzKCiMrcVoU/FNma06cs3liSGcwwGhR77GPvuzEhSw44tGIeINknyQZ?=
 =?us-ascii?Q?ppbnC1ygqbNQtqlHN7kUtDfv/IKMb3KCLERprq2Nbsc7FzQuYBE6Nxbpnt+Q?=
 =?us-ascii?Q?LpnoTYkMwzMZdDBY8W4lA44QFHG/7MSHreu9JPXY+MAyYwLgVLfxWMQvyywn?=
 =?us-ascii?Q?MolGJooyxV5h4QMqWULeSCgePs3ZisFlCdz6q3EAsiQo+g0cjI/BVYv0PzI+?=
 =?us-ascii?Q?uCNl7iYH+IypUdcae0MbPa1L0AQ/6Zc0eh5PriHu4opGFrEHHKgg916vM7EI?=
 =?us-ascii?Q?Ls8UcXrcq0oLspkjGYPura19w8GF5Q8sfCyjzwCL8coGAEfnVlzIzWb+Rs6X?=
 =?us-ascii?Q?UNLR6/Rbn0U8mpnGpVFhEsKo3GN0M5ABVxcxdQTgKF5cefvzgMKeqZbwRhb3?=
 =?us-ascii?Q?SiamGX0lo4auIy4qqdw4XC6/ZKxUv90TWDK/WoLRleahOHVN4DJnInKtzVzj?=
 =?us-ascii?Q?9bRTiQ31jF4wzqfTBOAZWG50B1uwcn/oGcokFifC7g7sf2apUXhWi0D+Rdo8?=
 =?us-ascii?Q?giT8reiO+WnPrK13Gb4w4kufJm2bwQMP+5gla7PYaM15KjP1ss27PHi+PRne?=
 =?us-ascii?Q?segy75M0Y2Z65UsOszhgWjuora3i6f6ZLQYV5oG7pdpdKf7weDGZmXamkE++?=
 =?us-ascii?Q?4Lh1Zx1kfLEVim8VSA9CYaSVhW//40wZDx3kBW32+BG5dqxKyEfQxrKTrOcL?=
 =?us-ascii?Q?YaU1lC63B028QdHVNoGoy5fU5OvWE0m02GW4kZqmN484AeGuAKg91cHaUviJ?=
 =?us-ascii?Q?4DWC+LCHQ3HwFFKrxRq0U4iL1MdxqWYHfbB6FKRxgubT9J+mOhbptD8S/VL1?=
 =?us-ascii?Q?E/QzwRR577Ol5Q3El5Lkf/kL037IQirwd1BVbVpFM4UdXVCn0y3sblr/tlb3?=
 =?us-ascii?Q?7GkOmWJpBBrbJaaPlQDb1FEaUAVGxcl24SedBnde?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a40d7-3225-4cea-c0f0-08dafe1e1c59
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:17:30.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvdWsH7nM4nTwWCBDY3DrSab1hsXElefPmBVGAAUE7ATnUA45Dqb6QIfygDQLkSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 05:39:34AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> Tue, Jan 24, 2023 12:43 PM Zhu Yanjun wrote:
> > On Tue, Jan 24, 2023 at 3:36 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Jan 17, 2023 at 11:25:35AM -0600, Bob Pearson wrote:
> > > > This patch series replaces the page map carried in each memory region
> > > > with a struct xarray. It is based on a sketch developed by Jason
> > > > Gunthorpe. The first five patches are preparation that tries to
> > > > cleanly isolate all the mr specific code into rxe_mr.c. The sixth
> > > > patch is the actual change.
> > >
> > > I think this is fine, are all the other people satisfied?
> > 
> > I noticed that RXE is disabled in RHEL9.x. And in RHEL 8.x, RXE still
> > is enabled.
> > It seems that RXE is disabled in RHEL 9.x because of instability.
> > And recently RXE accepted several patch series.
> > IMO, we should have more time to make tests and fix bugs before the
> > new patch series are accepted.
> 
> I am relatively a newcomer here, but I think what Zhu says is true.
> 
> While there are some pending patch series, there comes a new large
> patch series that is hard to review, and they get merged without being
> tested and inspected enough resulting in new bugs. I suppose that is 
> what have been happening here.

I think the counterpoint is that rxe isn't really a production piece
of software. If the goal if rxe is to experiment with these new
features people keep proposing then we should let it advance.

Stability comes from actual testing, not from time. If people aren't
testing then waiting longer won't magically make it better.

> Blocking new patch series totally will make the rxe less attractive to
> the contributors. 

Exactly, I would rather people work on rxe than chase some ideal of
bug-freeness

Jason
