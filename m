Return-Path: <linux-rdma+bounces-248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A4804335
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A17728138B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614B389;
	Tue,  5 Dec 2023 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZ9qSFiZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301EFFF
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At8wThvoXk/BG3UegXZWJ5i/WxigFm7Q14YYgjzN1OxqAprA8G3A2ssBbcmv5V4TRF40EhbINYTvVO4mzIU9oXSVS01jxzemhO2s5I4Z4PkluNG/qkrbzibOZSOUcjUFFfMJK92GO9ZVXtHWTmsW/VL/b9gluTgVnu1BNGIsrUfqNPyBmKmR1siyFO0hk1Z6+Isrt0g0crxagdAJfLNxercOMcgaTjRIQs0iHaSKCGQJXp/AREGkr/+SkgSQWM6S1/QgVRFeVS2bQopXhYacSKFs6iqsRHJU/uD5G3A1XiRkzoowWvhkO0Ievt/RG7Tmt4TNeCcCvAmqtPvZBGdGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=325oqsTxN4Y8ilERtJK+jkrb4eic06l220MT58YiRM0=;
 b=D/EhJQn3ohGBEgmEhvge1EPYSHties1MlZvhMMWCGv8i1kfcuLPkp/6fbo/KYV0Fs3SQRBzZ0sL7nm3KTMvG61JBC9SmvO7Xm2QiD+YL5R4Pv9a9iJGNm/hHwERNMUPV6eJelrQz37s/mrlx74oPp+z9rgOIhpmcnjoc/jfQbdmXZDl1yZ4foXjCwGcpV3RqkYR0PSd3R0lgWSYy9M+pZ8XUE4JF5ivLc1mtBTcCw1KagzfUQKaNcEfnfK2F7WJeeuhS8Dwbp3r2sJDRe9lcVgvIisnH3t8P3Lv3wDT1eHQekBrl83coJCMi8IhZtqzQH+jKeEzmRKEbybhlRFCuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=325oqsTxN4Y8ilERtJK+jkrb4eic06l220MT58YiRM0=;
 b=bZ9qSFiZq9dOIeMKR2+1VoHfCGf7kcP54mkIWbKbNpnIYZRbZvdRpZGXYJrMqqLZFX114VmPJJMY5CFfQnepUtS4C3dDKBCHvn+XpOgrFvHs7OEqmAEEmHyaLk0teYNv7f9GK6v2ULnpp4dBAQYtniMorGCPSSnwGOQcjfjMiO0P9h8eE4WlWFwEyAMQv1Hh+AX91eHfa8WcGA4EtVtTJR9i3ziRTlqTW/BVUn0dq4qPkizae40nDAU73zOiqmykGvcNbhAfulmi6EjnhKEiUZwb+bvd+I76lXh6lBK3XmYLGGBDdZHrRTfgDqP1ARPupACZG73zaBI+yhza+mXSBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 00:21:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 00:21:35 +0000
Date: Mon, 4 Dec 2023 20:21:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 0/4] Misc changes for siw
Message-ID: <20231205002134.GA2774449@nvidia.com>
References: <20231203092655.28102-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203092655.28102-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: MN2PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:208:fc::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6d5c45-d4ea-44b4-e5a7-08dbf52823c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	huLmFJbptAY21cJRAfZVLf87EyFcMYjECX3prM+TuLPV+eyffnd8jWx/WnPJn8B4O8VOx49tfh0mqUUp06Q+oK0hqdk+VmxoL4ogwD27F8TbkZeLQiu6Q225jJGfhJVr4iq2rUa2HEJ+HER7xE4jPJUbaJ6YhbGzyIpso6J3allkadEWIyxQhic0Oj9lTvx/iZaguSoWxVh5CwKpdZhV8qt4aNAmGpd/VuCyEwNJDmzcWr2tuRmymFbTtRY6J8B0JUoxfhDHhXRLT5ViOXsuG4B2BTlHmhmFZK1kuBKiDWNivMTysmDP+3U/iWa/VH/FPhs6HCJXBFbyMdq/OSg98/zP2BdH0iy257B604SoxFCNcEJI2TkGt2Ecz9ytjO80ecMaUXcKc0pKrXLMPjcnvb5Xvt3IT+WhoVfY+29+MhsX9O7wW+GzGG99iBY2oCi8qDEGp4gT14JtiILpnqOhtrDxEejVEXMsKefjh3Bdv1Sq6coPh3VG9lN5/5x7AQJIvyoG1IjZI1JIb7LpNfmeULmLgiN03dAuATj39tLI3+nLSH0ZmrPaY8QcnwIoVmAK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(38100700002)(2906002)(86362001)(36756003)(558084003)(33656002)(41300700001)(1076003)(6486002)(2616005)(26005)(6506007)(478600001)(6512007)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PHRKoXK9o4+oKWAxxF/XP0MIpLIcWVNXtKo9eTSHEuoxYN9pYSCbUiGEi7OU?=
 =?us-ascii?Q?VC7/G9f9/z0R94Xf0RiAlSTblT2uwz7inMEhlvepbdWQXcw7bKZUm1WimUYQ?=
 =?us-ascii?Q?ePpTytL4kmnau6RdT7x2VbFp6ZvW4eO3mGh0pb0Y5+uwuP5OsDzYda2HSVBI?=
 =?us-ascii?Q?X9RNQVIQwL7cOlmcB0GVLHnZ0cbmk9RDPkQ05utW9WpR1ClKEVGhJIkygzEq?=
 =?us-ascii?Q?ZnCGOTLSxkHRL0+k79MLA6BqT2iUXLrcVVHUMa557zayI51E+9l7n5bvqZGI?=
 =?us-ascii?Q?+6a2QhKN6PgcPp8kpV/7zs92kXr0Jnmg42hPsU9cVV6ZIU8BVJzvBhApFqod?=
 =?us-ascii?Q?qrot3Co9aPFDqmMxMiRr98dL6xdFdztg3UbngowOwLP0WE4LKJLlZEHzVMPs?=
 =?us-ascii?Q?GgqFeqIlbkmXDiUM8Do2HZbfZXuvVbK6lSJ6GGrjIFocWwK3K/kW7nbL/W6P?=
 =?us-ascii?Q?dtyD1ptjQrxOJikNs2h5zxej03xB/FGVjBQb1v/LGu3nkLbGxDt7qtTcPsGT?=
 =?us-ascii?Q?VtvYsuT9Q1xtDXffuR6/032bMSxwBqxGlXYzOF5huIVqSqoT9DuGW2mZOA1j?=
 =?us-ascii?Q?bvqPjrnlMmYCFlDZ9XYrswtuAVu6W6a8b/ZNqeKwzahyDnpdS9KMLHA699pz?=
 =?us-ascii?Q?bvvBS2kjsctmryO7bGMAxLM/q5Ekff6xPa2PaiiJqD5sA9BcZDPh1YMo3x6i?=
 =?us-ascii?Q?Mw/7Uo0Xs9UVVt8e8Slp+bfSLyDyj5cVAr3v1wbmLwhAD2OYTBHucKBwDmnL?=
 =?us-ascii?Q?F8OW3ix9++qPt09XBkloxHC+N4FwhcdK673GWVVcFzuSzWikiBu2I345yRdm?=
 =?us-ascii?Q?MeUUA7YK55dTFqlPoMrb4Q6lSXBTe96gDT1t/dxsQvZ3pedjXwLy1E4iwL4b?=
 =?us-ascii?Q?XPNlQ/41uouBj8kXrL07qJ45j0eXuDsgi6jvFyKYoB5+3cHoTZkS+g+D0qnU?=
 =?us-ascii?Q?i/FA4pfb4HLXvubGPYa+ZcFkmDeYVc81B7OOWLoWbcHElB0vTsqAIqcGgHlQ?=
 =?us-ascii?Q?hm+BupfkmXarJjblfEdFP3jVzHlSUxEH5jKvCrkJKJ2Az2xPJrBaUFtGz4Bp?=
 =?us-ascii?Q?Ah63s6Fj7SRVYDOQ4MH9fTOnzsoZWco3GV2SzKjkl4W4bMpMDqL+w7d2tJbU?=
 =?us-ascii?Q?Ysq6N5Vo2gR9BpFsQDwwCKlBE1CWhPb8imgo5djUCfpWPJ8K+ZdokP6OYOBl?=
 =?us-ascii?Q?7kPbWrDcszbPelKnqJfvIt20BHPked/VqprU0INIEl6cXMOZ9UVVauT0RgCo?=
 =?us-ascii?Q?8vzrI3jRYOd7b4prg85wJgqo8fn+66hZhkHZL3AFQuaH40/+L1f4fi59CAFl?=
 =?us-ascii?Q?xAPE4u/uOkzdc3jruej2JDmxo5NqDeWlknA+q+MIW+pj4sH0czxiytvIhPnw?=
 =?us-ascii?Q?NjP/RmcO5hB43wvOpX69P8F8kPZeCO7Nay8exTsd4M3p0zg7Vf3GP2Tj5oTR?=
 =?us-ascii?Q?MvoGejnbsWskVHKi9cTlfB9HkDXLKIOjMuSIuZArZpooEVVO7XTrp6TMrEft?=
 =?us-ascii?Q?eGc5UMhI4hJAbEFjfN1qfkqTfwSWqAJm/Cs0fayOsKvDmLj2KcV7JZsyP6sG?=
 =?us-ascii?Q?mHBrjJ5DAY15T4XKcPdc3yyO+/aG0dbvOK0Iy4q9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d5c45-d4ea-44b4-e5a7-08dbf52823c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:21:35.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IjeW69U5JTOxwdlJEaU2O548VD1+F60VJK3nwrQj9l723t/UJuU5AD5qMCJaRsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255

On Sun, Dec 03, 2023 at 05:26:51PM +0800, Guoqing Jiang wrote:

> Guoqing Jiang (4):
>   RDMA/siw: Move tx_cpu ahead
>   RDMA/siw: Reduce memory usage of struct siw_rx_stream
>   RDMA/siw: Set qp_state in siw_query_qp
>   RDMA/siw: Call orq_get_current if possible

Applied to for-next, thanks

Jason

