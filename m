Return-Path: <linux-rdma+bounces-7751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C48A34E12
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A78F7A3317
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DF245AEB;
	Thu, 13 Feb 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FD+We5Vh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551928A2D4;
	Thu, 13 Feb 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472740; cv=fail; b=IlzznnBTJzB4uktwOd81Vw6y7Q5xTgqaU+uQ/BidN/qqAIpStekTbNQbxQ5BMQiPg87Pzo6wYrRN5L/IZwuG7eY//w0ht4gWkuNDixp/SB7HXH76mzor4cUWIpwmfZWLEfaArP4OclzeOPOghtmRmDFth02A5SAeS7X0y79tyjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472740; c=relaxed/simple;
	bh=Lom+gfj4ogg4nZr5S4xIppSOmtp1hDP60dn7jmq8e6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JrKBDvNsEVvub4pc8l0Cuk0pFIqwvxjPI/16jEX25sER2z9/Yy3xK792h/qAvCFh1HL6Erd2dvnIsJmOO4zlLkvkqudb76504Mbglim6HImfl+KwPa6FO5VA8Y9zkvFDzW80z2CvHi45tNPTBqhraHal022U0J/Z9ie0nIPtEHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FD+We5Vh; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOoitzDxcyOlTviHvassWf+1X1BuuDynjNFN5wkO2J9XNWXf5kwVf9Dwswm8EF3dLx+5PfnRUGllwm6LxGhfb+9NERHS0SXN08VhSOJqjm24mQ8m2+215xqCNCywZ1KPGq92oiiJgrwFVCRXwEsD5HBeIv8Js0Kf3BwmDltBXvObQNGR/V9SbQSvyImf+exawdASqj97Smx51q9zKXMwJdTPv0cmhjzZ9Tt0RJ3ZC/2BlwAtFo9Y7e0KZWW3k6rL6FBXkPNXiDu7O+0/tYo7JyPca6q5O3+HosbgVcJW/v6ahO0mNaEfsK0zMtedF3BGic0stQUflXIwuCEbxqAsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWntbytCib/Tkoz3dgiuHtPpf/nVbAyj/aOl+mwXTlg=;
 b=W+ulU19a+PooMaWiCHdsGYEn+nMOCQFKJfuCQ6vX5DRElVCESqhjNLLqJy6SoAzFiOBaIdU66mpo7l4gHSDX0w/5xDZ3akJaFwtEpJThnHFtn69uJeS2wpve2nJlon+kvWv65bUvbmoDs455q586VN730Iati3xPAvpHS2V/oWr+vHaCegAp1Hhkta4/IW3IEgRg09SVBSdz6YJFKAMItTyhfiVlJ87L61DgFs3aukeeJxQi8iu7A+/Qi2WMtDqGiyNvA4/e3EEvB17OZLAdqAqyBckvOzmNfPyuz+bMRmUW+mrPQsCInFF2rf8JdH95dj5CgXeQZqZUxkRoqC5FzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWntbytCib/Tkoz3dgiuHtPpf/nVbAyj/aOl+mwXTlg=;
 b=FD+We5Vh3uQpJP5HDB8xju6S4KUtHJXmpG0GI5TEgiYDNA02yrLlFtMI6uYeoBhVnXEnJiiCLix5pAutPrY+gKo9DQZRhYO4bUGiDvaEgwPzzJusBtue8lLJOpkXeD4QHSxlSRt3jNnBaI6p7iq3v5dz6cO09zNafEF5ZNMD/9XGQETlo4YyW4w6+BRuSglR9NU5VcQCyeZ2iGw1rFBsOGw4C6yIwWEvbBqCC+5eb1R/1L1gU0f7IPMnbYR9s5xs3jrAunLJiBqRSolXfBEFS5eoU4R4oBqAcpaztCzyHOKukvDhWgghqkB0uP93eysK3CZ4hycvyMkDU19UUbfTAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Thu, 13 Feb 2025 18:52:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:52:13 +0000
Date: Thu, 13 Feb 2025 14:52:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20250213185212.GG3885104@nvidia.com>
References: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <b25e45e0-7c37-4e93-8372-e3fbfc3b7903@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25e45e0-7c37-4e93-8372-e3fbfc3b7903@intel.com>
X-ClientProxiedBy: LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edf9b92-5d2c-4897-e43b-08dd4c5f872f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIYVW31x5c8r66s8jKWZ9/Lhset0KCLkcMqR0q2nQYy5NbvmvahFP+9MS5GQ?=
 =?us-ascii?Q?ruTerNQe3ndXCmZzZWimwqUG6HABDnxzvEaFdEuA9zRkrNjmvC4DRryt8XLe?=
 =?us-ascii?Q?rEtCqCqVRBddtTTPrleZ6DCKprCuOIYeZz6keLedzCVrQkMy97woIo8RZzWz?=
 =?us-ascii?Q?qhgedKGLEVWVSA2JwsNBcgEYimJPE3Y0A/ne5Em+4pajjaENUxtsC0E6PbFi?=
 =?us-ascii?Q?jGCIbj2eGoHz5Jm0QZL2IRy/zoAhbHfdk5eJx5nz72OXYMHqiYqbysPT8gQN?=
 =?us-ascii?Q?qRomnpAgG685OsTzwjOBV0hdmaHZu69jDmlQLSHvDdZDLA2mlUM5ywSJhpMD?=
 =?us-ascii?Q?iAW8Yu1DmtHZq1mpCT36k8h9WubGChNZbrXZ11AG3z+pLpI7DHwuDj6Bb0Bq?=
 =?us-ascii?Q?hRY/IXXyGUsjwEejuAON1E080N3B+A7JCwke1luQ6CdcFyWGDFqxcy0af8rn?=
 =?us-ascii?Q?dChma9Ncg1KWKlhouGTPvi6M4Y27puT5pBYZuh0yaVcXTSAbZHqjinBeGAl/?=
 =?us-ascii?Q?vRQxykjKpXsDY0CtH4cwJoBOpbPFiq2ZmHm65kQJo79IeAL4oMMdMvwaY/lr?=
 =?us-ascii?Q?EjeAd+o2chXvyhgNu39Dh733mMJaUll4ztJpox+k/GkzZoxTb8yWdzFR5XSg?=
 =?us-ascii?Q?khpFUbbHevbSInZfHCNsubCaRoDqDnF9k+pGARw8by51eHMBJgDnywiAk8N8?=
 =?us-ascii?Q?vzqcKDDYxNybmRSt9j+577/PC15AsI9iCoyciLdOpux1Xyv8Bsl+kqW3CGWK?=
 =?us-ascii?Q?91THlgZcsR5Tkksb8oE2XsXIV89zV0JlcU0yG/ohVTB2bavGvW5VO/eU9UoN?=
 =?us-ascii?Q?Nm1m3l0JHJWzmrhdpVjxj5LSapHpiUXhVgzlfh++l92JTDIjGKnrcYPWvkyU?=
 =?us-ascii?Q?tsWoAVB3lv53pu73sa3mdTukXO1RFElWB/rW0N5uRgO1Ckuqxx+epKnkd+S2?=
 =?us-ascii?Q?/LctLO5M9kg4v/6XeWYZbsgIYoy2SCQqI0lIqQq/+f16rSI18nK4qtz5svVY?=
 =?us-ascii?Q?FkSR+LySE0Kt+bC1uiPrgY2y/6hlLF7xtup1H9M2lVodVtpQ4H+BfFFtvPDo?=
 =?us-ascii?Q?IbeYtFjfXaI0hHOkXHJ9wvf+wX2ZE1K4fbABnjzuPjY9/36USFQAVkGnMvtD?=
 =?us-ascii?Q?fgCTXYLr3BfgBn3qtoOK+US4aZ2MfAko3QPWO20+lU/Gcu8qHMyEIwuijwQQ?=
 =?us-ascii?Q?kmCs4ukeV/CZgTUoGUkw0lkTtpidJBO1lX8sudVCaHC7pmf4p882mRZwUE58?=
 =?us-ascii?Q?IXUjLUvvDRZSyPARz809MaosRMpcl9JoWUoOTol6p32RC0iW6Y07XysJOviq?=
 =?us-ascii?Q?+8NiOM+0wvIHhuNTpiIjXRxfu/ENVH4+oh5at1I3bZ0cUja49UjaeyrPcZBu?=
 =?us-ascii?Q?deeK5YNEQyAor6D6wju+FK3l/XHi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+f0Jbxqqx15B1KN4vWhbIvn6PfBwbsqv25BV6fWWrHVkFkXjEHgeCo9pK9MQ?=
 =?us-ascii?Q?13uiaAcUJnSpbIbFrxv8VQL2N4tFU7Bq01rX50VPMh6YGSiOUCGtLeTPlZFi?=
 =?us-ascii?Q?jr2xZCOpJ94fF4SHGnY/iyWBRM3KRXlEkTkWNNN1wyQNqmXjf6PaBMFU2RP/?=
 =?us-ascii?Q?dF9fhcvHctAvxVOEcN6d/Fn0g1zAjYfkpBfA8EMMYGsANjl0DVOCD1DmSuhl?=
 =?us-ascii?Q?JifNTVZyXI1QFkrIcFNxoA334oL25lQ/SFbkWeDM5anoQRZ4qM9PCh9nk8zF?=
 =?us-ascii?Q?BVvpa90+ZSvoYJeq8qSJE+l956F5VVRx94bwFrDLU+I0PAv4yvUgGD3te2l1?=
 =?us-ascii?Q?qs9qN7c7wK2a0OKQIlnH/OjK5YrPpAZs5oTxzrkOD8/v3b0VndhJMSuqoUXM?=
 =?us-ascii?Q?xm5+HMOz+ZmuRaFfO3lSZbjfJRRuZAQTVTyoDRG+gxKwKXoz+3lIVtxBYswF?=
 =?us-ascii?Q?996BbEBIkf9ObcU1uSreE8FNtUdEFif+tB+oj+UFO8z69l1mj1JfTqTJOUtG?=
 =?us-ascii?Q?rCn5aZ2taiXKKAztBwsUmRVD7IiKoEfAFktwtzfYrAransB42CQZ1GPxtg0s?=
 =?us-ascii?Q?5oh3Fc+ro563yE8sQXYuXFlcKT1kmX2RFgRseHenwU3OmFFw3Mkp96N+85js?=
 =?us-ascii?Q?xU3pyLdA653WKaPZ+yeOq9iyLbwt/IKRlOnCKyiCaYCHNc5yImSLlbvbrPET?=
 =?us-ascii?Q?y5NLnJVUucP5PGAF1f946ZzcIyZlA64PPxt2IchGcTv++0XCCq3IN1CYI7oL?=
 =?us-ascii?Q?IyGDwHMwk5ke+A6598Vuj0vfi448PMvNy9vEKpkiZW17P9JLn/WMZaqTJ7/N?=
 =?us-ascii?Q?LKLc8/2dBPPLb0IMp7dr7Sy1s9wa2BGyEoZ5QhU2zlgcX/W9NX/0/tmzyKFn?=
 =?us-ascii?Q?1xTbvrR1DwsUH6L+n58CC0trw4NqcAKVVt1eNVW9fOX70yd0ZvyLO0oijpeQ?=
 =?us-ascii?Q?DlCUyIFhUUge4KPcU/Dv6StVwkXoPNScndiO3HGdMl3e/qmmX4xVYJE0buHq?=
 =?us-ascii?Q?wZ3JhBm5Vkq4u4f33cry2PQwH6sPhzyMVwcB8+1JPoMzJGcmWwRVs1hZKT9D?=
 =?us-ascii?Q?X93c1SqkmnE/atSKz2qjHyTB7aL0ViLYNEOVhasap0quAIEnb8AmJCyJ/res?=
 =?us-ascii?Q?4J6mq7QHgwHPj+beQpPilHZBVoJuzx62vGi3a0I9Ks50m27EQV8NRiFZro86?=
 =?us-ascii?Q?MQ/xI5hQVMZyDdXUWcQJspI4ZI1J4+8NbvrxEJS/ULalv+W/qHZ/5drhtb+O?=
 =?us-ascii?Q?R4ZvW1BhMkdW+MHgOUplWXK8BJnsCjeIQXarT2/PRgbvMGqOvtMS/Uxht3fU?=
 =?us-ascii?Q?cR0FzhLsymSLdDWQZY4xVExP/UAm1r3USIzD9f7jCZgnRuZIbxPfLMlqBIO5?=
 =?us-ascii?Q?GBM3ib40itKbQtQhy3BC6Om8LdGf9QufQbEPzfapqMFZoYn+4G5krebigeKK?=
 =?us-ascii?Q?VNR0utThfOJu/BzLgLyhh48uReULY7iN2lq9m1N/Op2RTrkAdigK4Y9jsQiH?=
 =?us-ascii?Q?oK0u4x9zyz3MXEZprDmeMBKVjPblgmG1dnuWnIlpGIopzcFidOcF5AgPJIRx?=
 =?us-ascii?Q?osumA/UlAW7YY7AqV6TTYada1nkn7LkZ4ZXOxkHf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edf9b92-5d2c-4897-e43b-08dd4c5f872f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:52:13.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+AgY1X+OFzdwY1Z4qdoPb2+Z77WE+WN7Dua6m787Eb/EhQu5FCjKC0vfwB0dOxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

On Thu, Feb 13, 2025 at 01:42:44PM +0100, Przemek Kitszel wrote:
> > +/* On stack memory for the ioctl structs */
> > +union ucmd_buffer {
> 
> for most names you follow the usual prefixing rules, would be good
> to do for all

Done

Thanks,
Jason

