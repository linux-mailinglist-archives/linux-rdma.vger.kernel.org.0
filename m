Return-Path: <linux-rdma+bounces-11963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A86AFCBA1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260AB4E02E7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D42676DE;
	Tue,  8 Jul 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OXvmCWyA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC422A7FC
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980416; cv=fail; b=CFIVl7abb4DFGbXX3nP4uiu13yUN0OcL51q9g84ZQzkdyZ6wEMSu2Mebg/3PfoefGf8LJhlQULgLC3eDqHPLtgqr/6kS7CErUd9iwWV7L5mUS0T6ZxRl3HRExY+blfWOi7TDQf48c5kbHKFto7wbS7n6zx53YkMH6jAgZbxeVlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980416; c=relaxed/simple;
	bh=S4kBCBvjs7AuNExEIgMrunPigRXXhZFLCZlLL1QfFZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqmEp1AXyEXa+rHDjH9qGk7KIM68Jg7fmQpJHFEa9RQrt5mhSLYDbGdnjOCPcl5QPWMEczeytJnprW29/XDTODciEARWEj8bxQtzMK7ptaatQqUE9gHzNFitZUXFPfHdBxAwG38EO4KAit8IK5mBWqcX58so1RuduffXaAv1Qkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXvmCWyA; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpzoAvqAvN4rAtJsRy5kt9L0g9gw8Q/Er3hPifDV1wL4tpquXdjgyanseFO2yKnDzTEbLfrMbkQCgqDWZNsUrm8ZrlBewPDhPc0Ev2T/76KtsALBHlEgVpYc2wHvIUHxcEqNuWxNG6XrdzKY7zdrxDIuwTMZxMAzjmT+j2BkYUWSm9VnJT7exETxb6uiplIs/0V5ChkpdgkUOFTxp+wUXhA22RlKQUcx3k/d2UmJaPrRFBPiXYzRtjCIhonVKzdIHUpnfLh4AKW4GWe3vHb+G5Q7/ZC7oUEviHmIwx27EBqoZHDHEkKXM21up9p7ODo75PayoVbhNqCZeHiVgwGpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG1h4PQl9UPkakwzzFgpGNTEWGr5wO0uVGYkpzBijVU=;
 b=RB8N6ipaCHGw6FBTn9gXmMV0ggD+DU847o0C21jvug400cb1CKZolDTITIwLv6PP5nUgZdzBOvjLFsShDqOus2gN374ywwBzyLoZtfBc3VkDk2dNVmN3oV0gCbkCjZZqmRMktq/KbqWCxP5becqK1Ixq6rLGCKyhrJZdcoyFAox9b6LSjZSI5CYMzMFCUckmLuSE/udtfxS9ce2H/0IB9FTWBh2DdMXoZhABr9vRdPCH/2vBTUJg1iLaDWPqKNYM4ale2oaJs0Adrn31TfdntihV3vP9/jUliUhje2+oOAluCyRTnBFZyMn4wJw581lUqQ9/deICSn1RcjzpwllZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG1h4PQl9UPkakwzzFgpGNTEWGr5wO0uVGYkpzBijVU=;
 b=OXvmCWyAoCKKT00I1lNo3W9stihYFWg3aHQeKosveXbyUb1RNdfPilSYQx+bKdaUR6aL0mbMxKPc0QIckvdfORrYRXwJMqgJwhRs5YVv6AsTTqUO0P+M8hY3zK1T5q89UKIxgBwDKHGoEBBmDGoqIKlV/2zaIT6lWq5qlwt8Pr/rRThjEMv62cUd1FFAle8kAPgBYNyYMIUnPl0du/K2pzpKdhqEuFat+V6whr6Knmk0GoTTWQDNhcyixymBjCs0x5vd/ikgBNMqO+DPJbOa0UQmXteO9SUeMSsqkj25suE0SUJ8qOn2LeZIEGpLToqjQzZDMzjwTRIO7XglsureNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:13:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:13:32 +0000
Date: Tue, 8 Jul 2025 10:13:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Message-ID: <20250708131331.GY1410929@nvidia.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
 <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
 <20250708122943.GW1410929@nvidia.com>
 <d143ed1f-a4f1-4acf-978f-059101f3973d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d143ed1f-a4f1-4acf-978f-059101f3973d@linux.dev>
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac2814c-6b18-421c-afde-08ddbe213ce7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgnGEsjvm5kWaVmX+p2Ck/SeNWVWCwaBNhMwU/0jVhsU+t54oqcFe1imlACJ?=
 =?us-ascii?Q?VyVVJZ+3J1J6sBD6Y9Y9zi8wD90/Kc7sCpflfreHLXhnpigPnQUCUppyx0vw?=
 =?us-ascii?Q?cfRKKvAv6JSfLucj8UMoHzhyXoDe5bRoFTkVbB/P8N8F9F49FHppiAKT9Tv+?=
 =?us-ascii?Q?oIYY+JSsgP5LBMYrSSmC6zjWjd0dfLiY6EDgwkZkfw6mI+L9WDpbziBfzbiG?=
 =?us-ascii?Q?yHz6aiwMgaECYTMDodc0eQnvHsFXAW0gG63LiHNoawxVV59wFUh8GAl3Jx6z?=
 =?us-ascii?Q?keDECL1qkkCBFD0+gowtWTOdNfM89X9l31TvyEkhxGgK0RnvIQvubuM0CScr?=
 =?us-ascii?Q?IIm/yEbERXCqRxEiCPs9c574LT3xAiYctJJt9/6XE2EMETYPwMextXGWv0+7?=
 =?us-ascii?Q?U1Xy/EYHaHd6TWrrXpMapJNQ+f7TDdrW7oSW4AzVv6Df9jHDuUXYLPs+Dhmc?=
 =?us-ascii?Q?Xvtq6Cj/qKdErjKwD0n0nsYUiQp8CezsJazmYm5+lO3VqtfdtQro7KAoDE5/?=
 =?us-ascii?Q?t3bQq3v+yXkqPOXphrSK7Vyt27j+/eKNdO1u2LIhCxoR/iqpzqBupsoEBk4t?=
 =?us-ascii?Q?t+imBpKYQQtZcZ3ih4/9fGza36YvK/52P4Qr6H5No8asjnqpjxoxbTan2koT?=
 =?us-ascii?Q?R94G4VSpsVS4tgD/CNO7WdDakAI+IbOltI4Zk75jkqI5uZMc8RzdrxMyN8DI?=
 =?us-ascii?Q?CKkfwLbHLGv9CZeJPCNJ7sXOZmQLgnbuOa56xnEq3ocj2tok7M/zCuF5OsK1?=
 =?us-ascii?Q?2CCVS94eGhXLyZRehYh32Fu98izM7Ra2ybcCcB4p0vILBUT5M5xFq+3sIz+K?=
 =?us-ascii?Q?x/jjlD3ciSILzdrh0kkS/dS68ADs2x2yFz+xNRgIWQyiWOpRWw55mT0CPFbJ?=
 =?us-ascii?Q?yTWCocdkri+NDS0S5HokFDkmfgy3UOMCohkbQgknnRbtgFKSGir2BW5nb+uU?=
 =?us-ascii?Q?+fkdP69PX/CO5eGEHQlTPpyhqgyb5/YjR6KlJJkX4TbVjO7z0xQls2R4OILn?=
 =?us-ascii?Q?GjzNmi8YxpxzGYySR6tcpavQirr3weX2oH1QPdAuqT3f9mXVovik43ScHDMM?=
 =?us-ascii?Q?x4zIRmabNNCNbtnMUYqbYyNfXimJAVvXLNY4gMe4xmOOQ2JNiq4T+z5itDiy?=
 =?us-ascii?Q?OhEL7pdOYA3pUOS7ORmQmgRYdz6qEwKVvxHczyoI0UTqFrem4cAzJIM6Y7Ho?=
 =?us-ascii?Q?s4D8eUYt2li+hvSJRM7qrKzReNaGp/C4hLpDzuN5foXm5gjmFo/xKzbrNCeb?=
 =?us-ascii?Q?N01sW6AaMsxzqcD8+Hp5SHdgX3UCuBrzwl0C0DyclqAd7MLY3B5dALoUL8cg?=
 =?us-ascii?Q?dYGarqkGn8RXAa138TOiPR+l8cjIddqrUfGhLKLbeF+c0hWgKmdsktixc2rd?=
 =?us-ascii?Q?H8NXbVH5T8eRKUhF5aB9+Ucgk/M9nOPBsmff5kktP3EFN6iH+9UmW/OjIzLT?=
 =?us-ascii?Q?kHtOzw+yzWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAoRJO0+Hso4OmK+wCdedTeSujua7P6NKl9A/oWdfWUgsSV8rWtFq2ecwqQg?=
 =?us-ascii?Q?9plzMOOk9rxgodBziLbaGkX2uCjsEuSRPadWDeFU8WQARC53I+2zyCH3zHtf?=
 =?us-ascii?Q?8tPGy4mtmHHboLJpluqJJGeNm8SvGwaOT2Mzdhf97qEdrIZXYY7Z8IR+5Ycx?=
 =?us-ascii?Q?2b6z49xfYVTZ2p/LirH2Uupd4zdvNEQLCfZgoSQi7BLq6752oVo+KJChyYih?=
 =?us-ascii?Q?vBmG3Fyx8ybzx2fBB8jKui3Wr7HGI4nhYmcg2upfdHYUGARC9IXAdKjIdw2q?=
 =?us-ascii?Q?Lnq45g49foyBpyX/CdtJyfZKwzJ02Xisy5HU/wFep4BkoKNf4NJ9ASycIvQA?=
 =?us-ascii?Q?b+UJ6j9Nxg5ClEv6eHysi5aKM3ICu7/GbHW5lgTPR8c5QTwjEKuOpWwTlZ/+?=
 =?us-ascii?Q?jJ0bNLPjki/IqgQIYoZJAnLdGWavYAisi0Bw9K9eMs/RwZpW64B0ql9G2/Qg?=
 =?us-ascii?Q?g1Wx/cOzIvOfFWWnazrjXTndKytNeJwiiCvoTEAIv5y/X8C2F2rv1CO9Uiok?=
 =?us-ascii?Q?3DLZ6Mm/EGL9TF9Jwmj7ZZmMRayBF5YEhMWjkBkBTDRLoc0XIUSZUOngOS3r?=
 =?us-ascii?Q?tpNr22BBDQH120dnJg0pY2jd0V+4eI8yLpQlVEsW90j1TGWvoGRwZIO2MTEj?=
 =?us-ascii?Q?2k6QoKpAaTrJV6Xrnb8b9tuPx28m1OKdlsV5r9tjL5UGam91oPGHWyBUDfuA?=
 =?us-ascii?Q?0i+um4XxcRvE00IkZChXGiUTxUhvBL4ikOM8ddjTUX1Wj9oXGG99xvzhLo6a?=
 =?us-ascii?Q?e9l8UnFT/ZR3BixpESkPEA4ePrIPDjKvZtExnmlp5yUz6rbsDfPFVdimroZq?=
 =?us-ascii?Q?rj/m96Yes6LzCZOGjr5rV3VMdlUHuisJ6EQNGiL+YrdWWtMmIeiBDUx0/xP4?=
 =?us-ascii?Q?pTCmjpv90RwNI7w1fZYuzoxGEKdKAV5tst01LsgiQojhrnrGtSxrJS8vDTFZ?=
 =?us-ascii?Q?5rsWi8uM7RkwfjlWc3cSiNNPFy/qO3x77PG3inj0GFoXFvSdmRjjrJyeayxj?=
 =?us-ascii?Q?2Rc/9XCurvwUPV2egx2w/vvrbjZE5HdpNWLH1A8ssJ7Uq+Ih+jOwnrFOHpQz?=
 =?us-ascii?Q?E8EBReyE+kBnqQWK6+0ISvDgO6LxmiQiFd1FeM4HaY+qDlV7buKvyw+/vPXw?=
 =?us-ascii?Q?xDiRx6NHGKnc1FAzoGiH1MGdkLVDABpzrW8QAIKb3qjoiSxVLWbtWanWCMee?=
 =?us-ascii?Q?fPJJxd0GY7Sm4V3XVfZSw/VCfQZF+LCAI+/onJuH7Nho9ck+eRwfqof5B/03?=
 =?us-ascii?Q?AGLSaMxAxfhhft6vQNQI9e5PlmSjSquHtI2wD1Z1btJLS6xVtaji4rK+sndd?=
 =?us-ascii?Q?23mL+oxXpm4B6EsAViEAzSki/kXApv3vntC629vNhYYAjelCqDp6KmoZw/tI?=
 =?us-ascii?Q?gdiwh0TuPQaZUrGjw4UX0+ZKWdecZOs96IrnUrjwgFMl/jbGOI/hSI62/9TJ?=
 =?us-ascii?Q?TkoA+PjTAucJlTWdQ/ye5zuc0/JUX9vUYNH2Cez6uGzhaGspPJVxTartTs/W?=
 =?us-ascii?Q?5ebN/vu2xuGhtns9TD6YpIW/hEl9zW21+1gULGnHHQT8rOoj/FhGvEoLqscK?=
 =?us-ascii?Q?5l7cfHwp3SJH6pgP/WJlfbhozf7n5Xem6MptjoSk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac2814c-6b18-421c-afde-08ddbe213ce7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:13:32.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj3mAaK8VagEZSzcWPM/8bNzVjl/2V3WnTBOugNMyoaj/RO8UaOGWxjq3lMdWPyJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831

On Tue, Jul 08, 2025 at 04:12:09PM +0300, Gal Pressman wrote:
> On 08/07/2025 15:29, Jason Gunthorpe wrote:
> > On Tue, Jul 08, 2025 at 09:03:12AM +0300, Gal Pressman wrote:
> >> On 08/07/2025 5:27, Junxian Huang wrote:
> >>> Could you change hns part as below? We have an error counter in the err_out label.
> >>
> >> Same for EFA.
> > 
> > Yuk, why?
> > 
> > If we want to count system call failures it should not be done in
> > drivers.
> 
> Why is this check different than others?
> 
> EFA counts failures from incompatible udata/abi, or even
> ib_copy_from_data() errors, isn't it similar?

It is, and that is the Yuk. Drives shouldn't have counters for generic
system call failures.

Jason

