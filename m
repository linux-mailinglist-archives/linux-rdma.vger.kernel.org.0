Return-Path: <linux-rdma+bounces-3904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12899350DF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32DD283B60
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F450144D3E;
	Thu, 18 Jul 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQy0QEQl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BC13C3E6;
	Thu, 18 Jul 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321305; cv=fail; b=Qa7/Xd8HEYqCOLDT9lgDECHrzm0zpr6U75WevEHCU2GGuCrsGTgQJCT2Na7HRJ6chDWHxsb+N3fLVsiZL+PwKUYGuNi5iOYys8RyS0eb9dNo5OuhUXCkuFghTcF2MGkHCFiaN1QhttDxn1AlPtzyoT2znBjU93/84+SdBIO22mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321305; c=relaxed/simple;
	bh=8xhyFrqBCvEy/sZOwnJbO5DMAnUdsU2KOHEdx3ylkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IwcbfqmgQZ8cJ7Ncomy6Tn5jp0eOltuBiZna0gTjGNccqOP6LCoW8/v+Tw7DuYFOU38J310am8dlFZ8Ka72isFG5L2q1ujOHbf58fG+z32FL0xOT7eWINytQKvgrKtChliTbRk+X7lG5ht6boK2l1IWB1woz7d0rMlECMgHkOnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQy0QEQl; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpXICvHhEq054+PjPJeirFiCB+XMgy9kA3lgB3NtZl9O8PYtm2ivt9updgXjo8E6QKmcDk4CsQAoZ4x5E9ilNNondhwgNY3GrIKkQmTFNRMrGeh9VHUIFsgFAic3uqnH3Eh21m0Xgo/JOu0sHOAxgnS1oFx/qo32zgXf3FL91RIcFqDBWIVRJMGKN1Do5kv0Mrjzne2LpGaO2c8q8RCjOpdcIDjUyNLWb6x5pjPBtKU0UrpIU3C9MHInedaT9Irhsm0IenxCB2nazZuKumWfqydsuEp+giYxRNq60wUrF3ioJoUh1UwNinoV8Yz607XFr/xPN+vGmZlnHTEXrbPp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXpDUHP75KMDflNYv4AW2mIquMKC7DNRHip4S+1SRVw=;
 b=S5yCy3cwmlD92dnuGXdyjrhTf1DzY+XG09PdLV1hxcmnPgHZ/wl4OFmypqI7cHYKAwibnknoYFd0C/MVrQRFNSAWx3LvvjG0wmO17S3HTXJHWVVlRv3ct/wRL1/RenNV3BMsM9OXdt5h39/bVDYn+nG5yCH3cKZdjbmynNqX8OaN9r1s+BkKxsy/J+Lsrb2EwcRSOjJY1yIJwgSWaeeo4XsYfa5x/93RbPkO4BTUo3QeSBVrtc6xiumjlTaUxIAMqOzgpfXDXIlaEe0oxhEvXqCCx+K8rgJcmry4RZCPN7r70M6uO4N3ZZ4W1fdGDjOATUYDzILaZpijuE8FMkXwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXpDUHP75KMDflNYv4AW2mIquMKC7DNRHip4S+1SRVw=;
 b=FQy0QEQlY6OLTga7X/FEptmgncGSnPvvsGLO7K/w8KOPtXR6QrOCRZwwP4Lfa1bjj6sziht0SsgEek+8KmsUphCZraaGpm/SSmRIuctjum9+rRZEGRGMdA/pamj6tO9aicz+09DMmfOOytbpeYcn1JzNfoH90JFZcEjXL7joMM0/5yd7sUXAKq9C9MNYJyEFlZ7UkIMBN2Ua0dqCd32ezG2Vjf7KPKf9vgcfRTAvpJHgULMFSu1TbthIv0193TKGA9w0lcT4aUQsXOXsfIrUcONcBBS5oDHEsLym41eqVLVxVl1SKaDi0pWm4bylrWF7OA/rU+KvlQHljmFk3p2Jow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 16:48:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 16:48:20 +0000
Date: Thu, 18 Jul 2024 13:48:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Message-ID: <20240718164818.GH1482543@nvidia.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240717062250.GE5630@unreal>
 <20240717163437.GG1482543@nvidia.com>
 <PAXPR83MB05599E93C7F584D34D715E8AB4AC2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05599E93C7F584D34D715E8AB4AC2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:208:32f::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: f35ce0a9-1014-4e0e-35e7-08dca7496e0b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1OUWkCs0Z6sC48+JM/l7wbJtHBlCVyk47Ki/PX5w83HhNG68SEDVTLI12DE?=
 =?us-ascii?Q?5yqyeq7Le4ZS8B5+qLudkpLusQfXWsGPxk8mBC0Ei93eDlSMj6S8OhyzWNW5?=
 =?us-ascii?Q?tusocCnJo5HyZeNItxLM2RAy3TIXCoZRPvZ1JUVn8NpKvo0Wtl4psTw9Qpae?=
 =?us-ascii?Q?jjDSbPZcfpFSu3FihPpkFksHL+hHmh/lm67Gk4cztwlLHdYFof8jrGkFPnwj?=
 =?us-ascii?Q?Xc5UdS4tuPWOK1ZzMkdNUjwK4DWmRF6es6DIYXnVvj+fw+8z5pnEyjk6oGlT?=
 =?us-ascii?Q?gZZI2FgR99O6CIehRAddfbcqVqMlwGluRiBqDmjrBElso696XTbvYAjUlLJi?=
 =?us-ascii?Q?ppLFjrVl24t5YwbzvIDe/2eepDppX2IJNOh9h25ll8N2cdIXqPim6Mvi7Hfm?=
 =?us-ascii?Q?vgMcU0CE7e3xqzRkZle3u9OXGEj8VWLfG34Ag+/JxxcUoG3KGr/iGtmoBS8H?=
 =?us-ascii?Q?ZU1IgFudM9bvrULLJ+wWIdX11FBIQJpnESIzMkEyaKUVv2IK4/vKXfSStQck?=
 =?us-ascii?Q?G2Jq+KCezGuDSratC1x/eNzp6MBQz8KQAd7+G7mkwgciRoK61TOmod+a1lWB?=
 =?us-ascii?Q?6f7Vq0o+lztz6rvmryAxpFj6evSwe8bZq85xbVR0A8GXu9f0iHuaWUIA6tTj?=
 =?us-ascii?Q?3UBQBraEAEZBJmCzjwGrP2OPbQooZXtSTssfAVpyd2TuObj+zU2sWPG8yJWb?=
 =?us-ascii?Q?9vmRnEnJR06vOV99pAB1EVRmJqvV/9Nxrbvj2BxpFy8QuL0kqFVoJ7mtxQ+v?=
 =?us-ascii?Q?SK+/dpuNZRAk6EODyWHsRg2iZCQFDCe90hDWrSSWWDwcx3TDUFqXAve5BxNc?=
 =?us-ascii?Q?w0TPm97qUcAwj5xQjESYvrZb15fwwU8PWwIf5Q7dqL0D08zhvXeDkIVj1agp?=
 =?us-ascii?Q?7IzQuD5ZZWzLXpwU75tv0VV1Ca6VjlGHnCDv1OePng2LCjLq/JYiaqwCCb01?=
 =?us-ascii?Q?ZhDY7yS0lT623xnZQHF/eubdnEON57Sx6+Kj6VP3CVzPdndFk+v1Pn6TFF5f?=
 =?us-ascii?Q?nwKtDIJE9F3SpJ2vVywXV+6waPTBxM+rti9Lgj0S6x15j/R4NqU8BXQeU50L?=
 =?us-ascii?Q?FAT9TpSLG61Q6eUQ76b6UBI5IoQEQ7Ffq7HpPCkWVESNpYzAiGd1LO8CghfS?=
 =?us-ascii?Q?ps3s2LGzpl2EvBl5La+zg/kjUFt70lGefmBx2aJ+qiv6f+95MxCzK1zp+EDA?=
 =?us-ascii?Q?4/K2WY/ZdDbhHtyzJZYf59YRPtC+oYMP2LrkExmV2mvHJBV8mMJHfMrTLMXu?=
 =?us-ascii?Q?UJkEN25haFLaiVdGfAcXfqsHIWmZr1IUjw/Igcor577vJa6xK1SfrzQH3Y+9?=
 =?us-ascii?Q?x8bVRL+lRPUZEj0d2JZZ5Yi9Ok7Wct1HLj5zR/Q2DLKnyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jys3oiV1T/Fyhvw3ssvrb1vJfEQ+wOprP3llE7LmkkjgoG+uTJbNORzU5zOC?=
 =?us-ascii?Q?4L1a3aFxrMmR4X/Ol2Mvzx8Dby34FUy26d6uIqRL+xxPQedTVGufnBhKDXRY?=
 =?us-ascii?Q?6uMsj+cjaYXffVdCsGDWKTrKfzMl/XaNoZwkVMhlfbZ+Kr6XeJy/XZKTgvZq?=
 =?us-ascii?Q?jx9NU5Ddu7YRpRCS1PfLx5KwDb2Za5xl2omlyEtzpX1tMH9akuETHKYWq5Ix?=
 =?us-ascii?Q?igQ8R3796GnWG3CFyINnC5fE4iYY7d5rnv4K5XtoBC8toXSgkhH5VrP1gwpF?=
 =?us-ascii?Q?QXC+Uvn/bBDHDGjdeDfczSFPOo8+iqsf6zbb160MCpklNSfCVA4DbXf4Pqxu?=
 =?us-ascii?Q?Yn0U2rmLqvRRkH3TdlWf3raWSOdfHrnLwU5A/Dz8ionGIfYnGoOdO1pcIj7F?=
 =?us-ascii?Q?TXAWMBe7ncvM+Dfh5+UD9SBhQvMXulJsKGNAkPERb048JE7yd9LvRfXAIafb?=
 =?us-ascii?Q?CiJUlkSgBpPM4SiHNuBCrBoHyhjl9tB0TIL1xhCUAp+6ZSmQ9BzFhXA7Y3rd?=
 =?us-ascii?Q?V5oBXSeDBaNZcU+muXW7ZTk+KPNN7Ohk2NyGB/RTPutRa52l/w24osWz+0Le?=
 =?us-ascii?Q?7T02r7mAe83VzXaIfY9NSiM2h9hhOG4FC4A49x0duglcsP0TfXUhYdBVirBZ?=
 =?us-ascii?Q?HVQhAT9uQVQnksGjUUar5pqrwOcfrK5SWt1tO88igXB9lJToyZB8+2NY+l5J?=
 =?us-ascii?Q?SkMfm2VgqU4TYWloRkvdD/Rwby43WkWu8cBxte9B7fi1weaoRFeStUDO3/D2?=
 =?us-ascii?Q?H2F/gID8PlGr0vqlrMgaoH6sySUhUrEAAc7mvTETfEzJTQCWzUXr6AYH0HuL?=
 =?us-ascii?Q?hYHmqtoTd7g/x3Z8kWKyQeTJj7OUW0fFnhLSlliyZneKxnD2pq6kbL8kXro6?=
 =?us-ascii?Q?/jT3fD/ITsYWTWkM/ojXBKMdNpoJbN5O1pNOcKkRuLvPKsjwsclXmJzYnu0b?=
 =?us-ascii?Q?DlkXJCZ84qWQRn9W6z7RYNuHzyDQKbIt8iex0roC0iVDpSrvYGqCup7Ow7Ry?=
 =?us-ascii?Q?SIEMZVfRWygMQE13NOfcSSlI1z5gf9A6yy80xIuDAgEe+NmXvt94R1GpopFA?=
 =?us-ascii?Q?ORouvMZI5h9hBOVyBIzchKt5TfiUE3UYS8KRiGKQplVCrDwQ7vHn8P9Iz62n?=
 =?us-ascii?Q?LtKPOn1NUPPOHS1mQzL8Et0ZGjns1TOjPv61JfewnqJ+dpRtGill7Knizsws?=
 =?us-ascii?Q?QDq3VR0lIryTltSe5Yu3TZed47OwBlMkVSKSv+B7gC9SQ/cslowLDAT96ohw?=
 =?us-ascii?Q?OO2ybdtBQKTfJ3aOfU5Ftv5OubBE56CUnV3f4MKdkNiH/LIsAlwt8ZE4CODN?=
 =?us-ascii?Q?OmKlGXWeT4FcWi9R5hYhPt3+BItlT2JHWVBPDp8CyJXR1Fc33Z9AiDQADVoh?=
 =?us-ascii?Q?2bVVekRTWiiEzySL9nzhKB9lrfi3JwCVIctFicWfek87A7ksrGY1VkdPWQAj?=
 =?us-ascii?Q?IJK5j7bZNkCSAzlsZaRDDkVcnEbzKIriri0ZgNgjKPLmK7AUftQyltWKK6jk?=
 =?us-ascii?Q?vZoih5bqVwyKEjeE/2jG7+ozqpN4dhJUlCuM3hRI6a9ZA96uDCFvjBE40GA8?=
 =?us-ascii?Q?oyqUvX36wUqj7k3b6VY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35ce0a9-1014-4e0e-35e7-08dca7496e0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 16:48:20.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHFX5XXgfmfVkMf/SXvSP2hJ5xN5OnZ5cGVQr1fsh24ZeBA2HM4Ok3IpwabnAgUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

On Thu, Jul 18, 2024 at 03:05:59PM +0000, Konstantin Taranov wrote:
> > > > > Yes, you are. If user asked for specific functionality
> > > > > (max_inline_data != 0) and your device doesn't support it, you should
> > return an error.
> > > > >
> > > > > pvrdma, mlx4 and rvt are not good examples, they should return an
> > > > > error as well, but because of being legacy code, we won't change them.
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > I see. So I guess we can return a larger value, but not smaller. Right?
> > > > I will send v2 that fails QP creation then.
> > > >
> > > > In this case, may I submit a patch to rdma-core that queries device
> > > > caps before trying to create a qp in rdma_client.c and
> > > > rdma_server.c? As that code violates what you described.
> > >
> > > Let's ask Jason, why is that? Do we allow to ignore max_inline_data?
> > >
> > > librdmacm/examples/rdma_client.c
> > >   63         memset(&attr, 0, sizeof attr);
> > >   64         attr.cap.max_send_wr = attr.cap.max_recv_wr = 1;
> > >   65         attr.cap.max_send_sge = attr.cap.max_recv_sge = 1;
> > >   66         attr.cap.max_inline_data = 16;
> > >   67         attr.qp_context = id;
> > >   68         attr.sq_sig_all = 1;
> > >   69         ret = rdma_create_ep(&id, res, NULL, &attr);
> > >   70         // Check to see if we got inline data allowed or not
> > >   71         if (attr.cap.max_inline_data >= 16)
> > >   72                 send_flags = IBV_SEND_INLINE;
> > >   73         else
> > >   74                 printf("rdma_client: device doesn't support
> > IBV_SEND_INLINE, "
> > >   75                        "using sge sends\n");
> > 
> > I think the idea expressed in this code is that if max_inline_data requested
> > too much it would be limited to the device capability.
> > 
> > ie qp creation should limit the requests values to what the HW can do, similar
> > to how entries and other work.
> > 
> > If the HW has no support it should return - for max_inline_data not an error,
> > I guess?
> 
> Yes, this code implies that max_inline_data can be ignored at creation, while the manual of ibv_create_qp says:
> "The function ibv_create_qp() will update the qp_init_attr->cap struct with the actual QP values of the QP that was created;
> the values will be **greater than or equal to** the values
> requested."

Ah, well that seems to be some misunderstandings then, yes.

> I see two options:
> 1) Remove code from rdma examples that rely on ignoring max_inline; add a warning to libibverbs when drivers ignore that value.
> 2) Add to manual that max_inline_data might be ignored by drivers; and allow my current patch that ignores max_inline_data in mana_ib.

I don't know, what do the majority of drivers do? If enough are
already doing 1 then lets force everyone into 1, otherwise we have to
document 2.

And a pyverbs test should be added to cover this weirdness

Jason

