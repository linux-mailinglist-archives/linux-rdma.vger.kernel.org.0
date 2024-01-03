Return-Path: <linux-rdma+bounces-530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC84822E87
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 14:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6257E28503D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589E1A5B8;
	Wed,  3 Jan 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRIYf8Pv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B171A592
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsh/jbVyLAYH4+jKYrO/AV8kmmxk7fzY4Y+ceNez5eyriApELqyDvhPWa6tn53Ub1UjlNS6cXXmqoEcQ6xUNavrjQTxGZDpDkE5g8MUxxwDe4KVQjh7xBJ+1LkZ7eJf1EYlABgqkTluVJmTgAY1O2ULMP8rIiA2gA+2DES/Nr6aGL9Oet4LQxGGLMH17u44IQw10tz4NNGebw53d1QLMtPBZyeTsBl0si5EB/6Pm4tBTcf2KQRmXSQj67oOaJEkyeEjuZVbiCA/KoNxQtXWVgkK9paV/Lq8vSFAomUdi1us71KEOa4LIRQwzldEfCKPhEK3HULJ/qgpQds0pJIEuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBfzsFbVYUFJEc1Cys6lveXmjPR9cEdZySycIeq1kFU=;
 b=nNSeuullOiE5mBc0Jgp8DgtgKBzp09hU5vjJ4bzXdne5qzb8iMteewsvnMzOEsbkxqAu15aVkef4oYY6P10Vj/aaW12ti/TkyA2gdNVdpCWfBNG5I0/yvzD+vd34CcQFFUJA7SUiwU09MKZALKi72fAS4XgJ1GxQVAgeyVKJ1BE2X11oHypCq7jE6+qUefA4MtR5rcFsyOS2IoR33q0T9QEm2tbP035Chbs/+6xCFBt3KYXM6Tnm1la4lPEPI6zyy8/GjgaJO7S7c/iBSwvO7Pw+RLLrIBLvW/322SGSfwT+Wwq/iNjDUb9MObFkyvkCzeGfUVFCwwuvejlDhB+k7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBfzsFbVYUFJEc1Cys6lveXmjPR9cEdZySycIeq1kFU=;
 b=HRIYf8PvuQqYpQrDeezyxRcv69DO9mfDlulp7DK7rcpKHLKqubgKjDcqVEqiy1MyNMeR0OCsOgL6iXvAZ4TO2D/4SKqVooxTC9blQQaJPNWMBC2Jqm8Q5jLvzdl2LuXhtuxgVEFS4E5bUkIjn41zUHESUleI0EFPh7JxP9cMsAZSV+jo85hFmwfGQzKDJGRRaUX54EpouExGq6s+79zTL6XCdASarSS125ffb76MjY5764Z5Y3h911CO/C7qy+K/noWzHNjpmOtbiuT1o5Q5VCKqj/8bUo/TicvFtP8RN6yHzOVtNAXJ1iCViErDOhaYrp7dXFlr02xaF4ut34mj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 13:37:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 13:37:03 +0000
Date: Wed, 3 Jan 2024 09:37:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Message-ID: <20240103133702.GN50406@nvidia.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
 <20240102234713.GL50406@nvidia.com>
 <d6394917-802d-4d37-8141-c4f462583943@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6394917-802d-4d37-8141-c4f462583943@amazon.com>
X-ClientProxiedBy: BL1PR13CA0405.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb94d15-e28b-4f57-5f65-08dc0c6111d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0nHtxgdHRU7ybjwss8fpvzvrhfDXL99y2RyE/VR3+8PS90q9NmlNj/F0yqOTUIP4G+IDh73Rn93bPVoR+R6VkLiiTOKuVWt0tLoUQWTditadygWS1b0YtnliV9lzRO1QjtIaij3eZVJ5snxXvOj3wMG/qWl0pY3Fx68emPqArJyT4XLVFAV6UevQ0NXW/nCrtJOA0U1oRdi+1fJC+Y/lnmm3bLopgoX+2BwyqGNGaYKhhJfibjKhAE3P0kMCnp1iO4AwvhiAtM9KKcL88n16LXR9KpDqoQasko7MnOT7IGNlJmAhU/i1Pv5h0TRXOQsnFo4nzz3bm//3lAp0RCo2siaN15IHKrsRM4TijyDsFl23nWDgl+R/0MwlUS6ZTYM7lI3wlLqRBDjV31tSu2oPBQ80d4wyAKFmgsVvLNQkMouXl3GBaFf0HAbISQFBpZR4GMzlgT2IMIjD9GLecNKlsoYxr1K0/patZ8Nr07JYSWpVG8R3Y2WPWvKg5GaUUM+iaBBSSRGUz2s+GrxFhG5oLoVfj2MXj2mLtYqPN9S/oxFm760jkAd3S854JCgfm2Gx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66476007)(66556008)(66946007)(2616005)(4326008)(6486002)(316002)(6916009)(8676002)(8936002)(26005)(1076003)(54906003)(478600001)(41300700001)(4744005)(2906002)(5660300002)(6506007)(33656002)(36756003)(38100700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXtq+VnnkYISOJauzhAH6oq5Hmvm4xMzPonk++gdNUe2Qxv03Ituk9faJHC8?=
 =?us-ascii?Q?WQZiNgkeqAEVOiltS+GCF8AWYlmYS7kFIog0mf6Uo5wWmq0Got8qpCvgIJt/?=
 =?us-ascii?Q?tnIeSavbo3QIy3Kea29B1HFZI9argYhfaiwRP/e6nfw3sfhVBJTF0NpUSZ4A?=
 =?us-ascii?Q?tjgEbfDDewAoUyVM51yPLtXtHvWk1P5XcW7mAxLwfs2rZHcbCJMiXZ4K0lVP?=
 =?us-ascii?Q?w31HU7hAErJJ1VwmmmQ8kFrVsXsBu+bG3RlSpxD7CoqTNikedCQ+kS5123zb?=
 =?us-ascii?Q?CsvB940hf8pOzhUbAEIHWAs4HRhJbkN0AVjiw88+uIIclS3GSWlyBqSKUKA4?=
 =?us-ascii?Q?jrrqrEbq+QlrD5DErOnAF7nsgu5SKNE1Rgqlz3+Duh0ACxpoEYOLE9dqFwMu?=
 =?us-ascii?Q?1aa7gktklNhp9LNKOjkrIxuGsg/uW9zLzt06NpPkqo8yMDwm9XIYhgBipAnV?=
 =?us-ascii?Q?Ke9JVG8T2kvJgBe8Eyi9zQ4Bhuf7fV5ja/529aY8vwmeCh4Ykn7qmy3CgpTw?=
 =?us-ascii?Q?6sizG9ft/Csj+TXubB4vrFG9HNStf8i7YXI4Tv225HycZI1jNg9F3P5DjQab?=
 =?us-ascii?Q?kDRIxW69WZ4ddqR6XFOeLCiLcDH1oh36UL/Vj/DMPwg0rJtVunt5Lk6Y+sH3?=
 =?us-ascii?Q?WaySX/2TMfIDurTATM6xGc9D+kbSyheob4u1Z0A5X4+0XuVB4kAzAiuJE5Zj?=
 =?us-ascii?Q?MHi3TTBv2fPAFbOg5utYWxDYuBWXtTSe2O7MH7UKudFAxGnLC5iu4gJSuQji?=
 =?us-ascii?Q?dPgeAXnLsp++mvIsQJffMV8fy4/0DtPc27gf9V2BfD1mW9FSV9Zj3rHLXemY?=
 =?us-ascii?Q?qObXgihZjsJ+b11+dX0iGe+aYsSJXbfL6tpDiVzcNC6XtJpCIUpV08PRJAZT?=
 =?us-ascii?Q?h1Ba5uI4mZCtvCmMpiu0MCl8ssAld/+kk7+jG3VBqx9lCipye3p0Cy/aF92S?=
 =?us-ascii?Q?Kj86NMzJ7NksMD1+JQ5nP7RNkHxTZB14Z+/gdCIr/E6yaaTahL/XjQbaxMrO?=
 =?us-ascii?Q?fPJGaXipuce+IutpmFGKyGcAPX1g90erbZY6d9NkvxmnI+BFGfVQ9EkEh5yl?=
 =?us-ascii?Q?23FNMFdstNmTsGjjCnobA08Y8ieoeX+mZj9/raSKANGwf8zWPpU6TfSp/dMb?=
 =?us-ascii?Q?BjkewvCrGRmUFth1riUmM4x3xmrYw56p5VXt1KfocXvksCtneEzv//q3Utl3?=
 =?us-ascii?Q?g1yUbqYM5SD8ENdq95tpUq2/KJANTYaqZvZXVRbFxA9xA0CXb3UNsPtaCckf?=
 =?us-ascii?Q?XYRwZnUJ+H/ul+AZQ4RpevUJ+2u4z9kIE2IU442lXZqF+cQDa0l8DXhxtTRD?=
 =?us-ascii?Q?LCTJDi6HE04OYserAXOARNLPNJAKuGnMZ5ncS2jnCQ2gd7umj+4KBLW92ozK?=
 =?us-ascii?Q?8j48EIOSOIzx68q8YyrX453NpSMr/bXKq34NnmSKHfuhJcEdNeXwNOVgvrRd?=
 =?us-ascii?Q?k2iLcPJy+ES8/IyOAeDgQON1yapeZA4XJg5kTlxqIUrye2fpA7JPceZ4p85V?=
 =?us-ascii?Q?XWaQ0/sGYWBAjHkw4jjWTCLOCAm7R85OELhWDanl75eCMetG7L2OWpw1O+Mc?=
 =?us-ascii?Q?kBtQBBQDMFklqgaup0lp6s6zkH0NDoBCP0KI15No?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb94d15-e28b-4f57-5f65-08dc0c6111d5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 13:37:03.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y1kmoqHRPxTWhMjf1zS6kqvd3qY+odRTEQv4KcbYEHT0f2d+0595G7oE6g+HplY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401

On Wed, Jan 03, 2024 at 03:33:41PM +0200, Margolin, Michael wrote:

> I would like it to be as opaque as possible but on the other hand to express
> that the mentioned 'interconnect path' relates specifically to PCI path.

Who cares it is a "PCI path" if the the thing is totally invisible? It
is some hidden implementation detail of your device that today happens
to be PCI.

There are many ways to get interconnect multipath coming, including
PCIe UIO.

Jason

