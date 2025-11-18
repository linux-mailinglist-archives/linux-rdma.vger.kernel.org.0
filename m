Return-Path: <linux-rdma+bounces-14602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2884C6B4FB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A7B96299C6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA02D7387;
	Tue, 18 Nov 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="huLBXrs6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B02DAFA7;
	Tue, 18 Nov 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492233; cv=fail; b=Hc/Editj7bctugd3FFEeCLQhOuUfnEES7LMhdwL7XDS67XKlsh6o/sxd2On0Ul3zvc7UJaOmQEA/riU/YlRSsMhmwIGrz1vESSEYRPediWfZLFTAY0jaGjFb+Yl65FtpMzuPN6TuTFUSrlRLZFperDjhQGdwpgAolDZ+5qb6Wes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492233; c=relaxed/simple;
	bh=nQMNykz6lmZBAdSVR/R5DhhFFBc38NWZ55HFf3mEI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VazDTAdO7qf0eowGkZufIfP0ThECZWBzfqGQ5lyT5k8eVGI+mDreSjo5WFQmm1y8WVHDJRgnj5ciisI7ckT/EOhnP4RZCP2VwSwxYA3TiIoOOMlH0uwOrlNFegP8iOPcsy6oGOq7ky5fMfw5Tp8tCs1iXkEoaOeX7iegNvOQNvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=huLBXrs6; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8eOtKLztw4CWVIRbU24dpzAqYo9prdzcRtNWw2qye6cs4dRBJ9pg5VnaDlRlkyRKckFwNpqydZT3vLhSwHfcgrNiAJVfa/R1grUf4A7tabczQ3OqcG4Qrtycyenrm5zSZPc9DjgjdDGEL3WziE8PM/dRuvL5C2ClcpKOWLswr9zfhb8iZ/V8FLGNFtjGcx0K+7IzOFE/Ce+twITeo5PVzuNrnSwRJQ+VSNIIkDPMljX8fbK/CHxwVihn1dpCSISUB9GGoDmvK6boHIXVCqh19YgJzvnx800EtpX3sPE7SoW1392v8eF/4SVkd0Gv3tDGqpN/ptif3hyohmzzymv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS5c4SN0qrEXKOvXjk4zEfVebhWODtCjti6INcAIBYo=;
 b=RI3ZtCFcbDGZm1SR/ceHbjlrIGqp0Ezp5tivYEE9a78NRome4gcQC+qOFacIabLd1zGqI9CjKdKL+L5Ufg2a4JCoP6rxDBcve8wo0xHUSQ5L0PHdsVGB8+lDK9ZkcKCQP3Fi+jomjst+MRQfxzBLD0ezhuY3SU7KH06iuxvpAvEFluah9yyGyeGLpCMmKEW8l0cbvEtldQvMY+cGw4tqBz+bvAJ03S63kL9vNyEXYZSIWfKXT55r8v/cqBhYniBGyC5muQ+uTgIyctsO+RpQ9RiOJtaftuW0zFTIrjVdz+RFzpxHlt+WG7LvzetgoDrnZqTxGcnn5oOIbnDGBu14ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS5c4SN0qrEXKOvXjk4zEfVebhWODtCjti6INcAIBYo=;
 b=huLBXrs63UAqvQKpljIiBvl/C69Q8pXin6Zf+9pibF+ntCX5TJpo3HfHQhERau4adcq+8I37IlM+w4vrULM4LqjfIz8thYw67rG4ipvom77rl9ZfPVeYLH2TqjNyp5A2jBzD23XCi05JvwDjT97TAt4S6fq4mDIGE5jr2rlzguhtpZuqaQ8YGR7RI6bIrE6cB7cxCbaOeIObrQ/nFlI0YD8afRiU4joLb+Z/b0ureZz6+XCbSMETwscGS0DJGw6UOQUm5VemCb9cKBTlchRiCKZ/XB0mjuM+s1eoJajkipGguPngLU7DN8cNXDk39zi/BybJpEHoEomRTKSDmfjzzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:57:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 18:57:09 +0000
Date: Tue, 18 Nov 2025 14:57:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Message-ID: <20251118185707.GP10864@nvidia.com>
References: <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <93fd05cd-b227-42ab-8d96-7873a830e6be@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fd05cd-b227-42ab-8d96-7873a830e6be@amd.com>
X-ClientProxiedBy: BN0PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:408:ee::12) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: cf88df78-6100-4ce1-7b97-08de26d4465f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMz2RHz4zuTZs5mVMwV+ZxTljninvhzddO10LUR+rEm85Qh1QaWVgMdtEYGz?=
 =?us-ascii?Q?QBmT5AIuWT+CJQ+tyN030LzeN9EgjkO8MXY08VOIBmquMN4Je4gL5lyWgR5+?=
 =?us-ascii?Q?Yz2N5WLNWoxVIDgosJdc4XrEnrg478LXRBDagM9trz0zxYhD951pn04N0Afl?=
 =?us-ascii?Q?AdZhMKxOfp33YLfJjfYFKR62QgykLLvAJn8rHIW5ijWJ3xZ+g3bkBrviAaQt?=
 =?us-ascii?Q?rfGXrNbwT/priYYTnXZpmG1x+6XiP5ns4uEqihcZ1HRDdG1infUpYGvZp0mZ?=
 =?us-ascii?Q?6dkETs2W8qeIVhD3rvPxWp04uefp8l62FzyP/l3y+mGF+e6sAfR53emHlAFb?=
 =?us-ascii?Q?TbsENa5TRqR7LTbTGDcg3S9etMl5XdByj0XVsF+P1jqCnxUW9aF99O06cbsx?=
 =?us-ascii?Q?4wrBHEcaBTtR8K2sQrQPmwU/y9kndGR3nhgPvGmCoD+Xf19vzOaYGsa/M7ud?=
 =?us-ascii?Q?vsg3yOnz95LNPufPWKKpP1h2qIP7ZbiHuZ5vVocPOCvkkuT7YrU7ERelFbi9?=
 =?us-ascii?Q?ryhUmq6bhZdLIQa1FI6J2JyHZOBrKOCRBNqLejueRJu9OiD/k9Je1eD19mwu?=
 =?us-ascii?Q?5w9WFfVGDlumXmtqws0Kx1PlirIPEzGFi3XXuJTi/PXXeumnt+A1l0jsJ0o5?=
 =?us-ascii?Q?OOzvkB2lR0d33gbPfK3c2W9BXB25feg0mD0niHIlZf4fwGXbyxQ4ydXwnpue?=
 =?us-ascii?Q?LyguSkNAgduKliYRjeL0HguJ37E9tkSWwAsfcp5fCk/xEUcmNKOjdk13b7C0?=
 =?us-ascii?Q?GlQfLLs+jjBMsUz2v770AgnYoeShsJdGneRzw+qL28NctSVFP+XYkmPsXIWW?=
 =?us-ascii?Q?l9B71xX8ca8A6G8HOlrqAUf8CFlt7ViPndXlsVH1Yg8Uivsfw4QRJX0HLZiu?=
 =?us-ascii?Q?CS3CokBLmZrom29t7bW1nT63NfNEonySLHyqBi/7xj6LGQQqk1mBaZsJiEoO?=
 =?us-ascii?Q?PvBhHNlFLyr68hgLOp3GTF62wTygxC0jgjA/tXOTZLfqoqHKXSMag6xDSmHq?=
 =?us-ascii?Q?Tcd93q69R1PEg+LFIAVUhTk1wSxA+SbnBFhIB6iRyZL66+iFm+PUY5iVlMtd?=
 =?us-ascii?Q?Ee1alo9uWdPDN7OtRdT1k9GRXF/A0OYxWxueq/NnRoRl1PAALg4b3fH0bVTN?=
 =?us-ascii?Q?bOU2flsh7uRg3hOukMpG1CHGLBOetuhwIbMuybqydHJPpDM9V+JlQBN7Jj8a?=
 =?us-ascii?Q?A+LwHJdHPhfFngzZyYNjZeVvbFUwZkQKH2EsQh3YhSA/h1CsLhCgHJdYnwVL?=
 =?us-ascii?Q?qGmeZlywdzR5qMi95aAhthtLlowuLyqDyx44ZcTZr6STU+Caxd//x63fjl2Z?=
 =?us-ascii?Q?/tn5YqIQm/MxUDpqjEbRBGJ+XHiVxvb+8pWLCeKG62ZV504t5ObyEvcod35v?=
 =?us-ascii?Q?2S7bkG/TmJwCtgTnSKW76+X86T1j+aRkM4Yy5vxdmSkon4temU5R9RUwEy7x?=
 =?us-ascii?Q?xkxcc9ElUQEg3ddDCpc0QcV2FmsDW4pA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HP919l8CaL4ygB3XWgozthi81rhjwaE2Zy8AYaQ/gp5s/d8ZlV/ze57E7VOU?=
 =?us-ascii?Q?Nk2BDuV1u5AuNlyj4JwaV+KhTzx5wpmrNUAgge4aL2ppzq+72/w0kTR4vXMJ?=
 =?us-ascii?Q?dqxSUtETULumuGAeMuHXNETLnHSulA532m4a8Uc2zjLYj4yfiRAeVoG1gRFj?=
 =?us-ascii?Q?+n8SHoD0AVaiQLCHk6BYCf/S6RF1Z8Mw6EvAJ+K3V3s7dKRkKGopV0y80EvT?=
 =?us-ascii?Q?Hk4T4bPbzxrCOw9fA79Xu18v7LA6Gly26gn9iSSPELzn3wsodb5wnbbC/GW2?=
 =?us-ascii?Q?lOvlyT7emFboE1/JjbmzAGDRbfxNQ8oLhAxPJAJQGGXpv/BT+vRreQ9o5Dwq?=
 =?us-ascii?Q?Hl2HxnKta0WLZ3DqSJzsWcaysFLp7+GJFP4CVx6jiQk/iJc34ts6hZPYev/c?=
 =?us-ascii?Q?1z1JpBC12DxnuXD9EpOLopJ7uJpy1khqp8r+exHtgilKTqqNXHGIHYyL1Ppn?=
 =?us-ascii?Q?DOYixF3kp8YYK3Ln0sZeg5bgHvAPc6wixicT42A0Zhyn3eg8ffdifESRr65W?=
 =?us-ascii?Q?miwjQmMk3zcCysl4YvX93kLP6f0oARqXsEuwp509LKWI/7z2aRKkZBd8eBsj?=
 =?us-ascii?Q?+aRlCldUSap3w+gO34AavC/U2QyiEqSDX/hZHnn846fgwkfxQ4m98CcObseZ?=
 =?us-ascii?Q?XsTPSMqCnLu+oOl0hOW/hTH/yyFXbDOEZ8qQ9XjvWENPGi3vYPc6if18T6ij?=
 =?us-ascii?Q?vg8/bRGbo32VBkdF6O4XIq53bVP9dFdDlFFudvjd9Bh7rXOOwhiZxBQRyG5p?=
 =?us-ascii?Q?0NK2Uu8qpHMvobtHwZT8De26EVXwNS4ytpUB3anL9EbMu611H1cSp2KP0O5U?=
 =?us-ascii?Q?KpfO2Xgvwb+GFtaIiC2TSk1neeTKju1a1iWJ7AA7cUJr6Hm7ccSl9fMXA9AD?=
 =?us-ascii?Q?XtWfmnaKHn0rdFhvBdAjEY2790K9zAR2s2aElyQTGiC/kT6H1e+w4gC1BQO9?=
 =?us-ascii?Q?O5tT11kjmvuZD5UToRsxUI3p4tqoWGjSvInUBPb20E5CRNBKxlykfi6Jioez?=
 =?us-ascii?Q?sWRsYkANc37M2/0OD5K1ZzWbFm50YS4DJ4F7Ggh0A7qw+suh6RzUoPMFsQZr?=
 =?us-ascii?Q?zXM0lOrYYWOqe1iGu7cVoKVFz0jhE/4vGxepUWedP8p+/Ij4yJuOTIKIoXLZ?=
 =?us-ascii?Q?lflBBmEhEGN6OYCMd/PeN/ropBZTQXZkVezLVjf6PbAeSqGYMdHZOjQV5aBb?=
 =?us-ascii?Q?HL2dISPzp4X8lswqqREaoTgcDsqnuGvLKiTCkH0SvZvco/pI3PNd6VVclKm0?=
 =?us-ascii?Q?STrnc0Kb+HCtV9XHakdJz6DTycZvo849/eUXbVJYy2MXSlQ9p7wWyy+KGyXe?=
 =?us-ascii?Q?mc9/11AvEJc6yavliMfa52RGJe2WaozbTv4krYBDixTmjwV/J8V56VyU9v13?=
 =?us-ascii?Q?8NP78bx680aVNYGELK9Il23ay3rsiCfGjGJ4Ox1DbAUpwJaPS8oJhC4RXqRl?=
 =?us-ascii?Q?aolHs0QudOJcpZhSXtk+2Qg7qoAK/cAgEvW7QPc/BPWaOw6Qnz1KGV/tvyCp?=
 =?us-ascii?Q?gRMiOdVYcG4R85SPLU2+Kkw+hqlrpcK1/KYfQYkgq4rAcR5vJfavJjpkXGJJ?=
 =?us-ascii?Q?ytPPh02zbJzw1VfoFV0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf88df78-6100-4ce1-7b97-08de26d4465f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:57:08.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBbZX6zrhRu3PoZJoJ4klcZSJy+1jEjxr4p9R+Lh5t3jHfztYBnAT+saXT7PWwvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

On Sat, Nov 08, 2025 at 04:47:02PM +0530, Vasant Hegde wrote:
> > @@ -854,13 +854,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
> >  						   PCI_FUNC(devid), domain_id);
> >  				goto out;
> >  			}
> 
> If you're planning to respin this series, could you please update the comment
> above the if condition?

Done

Thanks,
Jason

