Return-Path: <linux-rdma+bounces-8315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA86A4E17F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7743B7227
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1F20ADDC;
	Tue,  4 Mar 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOgANuBG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6C1F584D
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098633; cv=fail; b=SdeW2OyZHS4EDFUf/IyhxHmTyrJTB8rF3TTeerWWkcKijYYvWCXKKcXkEmcAECuqR9sI+T8mbEiQfNrX7OVWREORwfWckqq9/HGyFeow0STRjyT5PouN0U+LUm8gIr1rNX8VSbMtl9OSBtEfpbCOzL4wZ7byL0X1hGlPPGvqzT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098633; c=relaxed/simple;
	bh=Udi5F1C/XzJtBTHTBPU0VtDM6v76Lt4WwZi83yIni5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tR/e+UmpA6h3yKSMBuJQNydy8uum8JgMx7e0xW/1bEQRLqJoWjZmO/xRGhkuSIU0ltbF7B7GrZHvWw/tnvfnfxHRy9eh5g8CoaZyamMqdKLB5GevUPViT8v2ioRwg7RFxqCoeU0P6sZZu6EC21YygL5izTfLQoxOs7VDZ2aPKko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOgANuBG; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9a1ZTwfcF2kH9QXuzaCrUF5W0Qs5AwGlvnUQ7/N/LtLAs3UcIIc8gLvpCUB2Otj2zR9r0zAfSgdCIdxG6gXR6AhTfm7RdFxT04fHbPAaLt2H1khODSJcUvoEPC+fi4fLHnJVFHkGDHo/3mlADEkm9/pb3LkSWsSi48afDDEITjH51sEVF7b+CXnwA0J2iGlrr28qeaKH38AvyJUJF8QoS+X3FEF/CT/alJBhIm+1aWlMMi0JPFZXYJUtkdaRtxBwaMw1E/J18wgO4QMUNTHwcHMD1764ufQUemnx0cZdrmLOy6CqGQ8ZwCt2BYAi1q5VeAMOkpH3phKaVyftJS9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3yksL5+9vGUoKW2FKJScWaxfICmC2zKZV1wM1mDHCI=;
 b=KKPtHD4ONI2NOOocJmJdP+ir/zh0UvqrNiEhDZ4VHGBhFM+M8dmdOfYVfP9BX8tL3T9NVHBoE5Q7DQr8O/VcT1cUYBwSpKjDefIt5HiuEpswD3VTd9nVlbpUB4jDTVIk+loAUPjOyS1WCEvaXgI3Jx2L0DLVTWQ5NTn+1rMBaGRTkI5vC5c3Q6EAuY75oOU3SRaSAJeUWf/QzDwMBm+pAHR2W7inUCo9r0XWNZ/z7AAmms1SoTSPrk53H6w4nqhUvPD4VRln0KMCe84vWgYuYzDyrOiN5V2UwlOSBphNb/KBUCky3HkUniRArwm/NfQCPa6Fhsj8XP1i0vilxs5elA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3yksL5+9vGUoKW2FKJScWaxfICmC2zKZV1wM1mDHCI=;
 b=KOgANuBG+BU60zbVt1tfOsDIfOIj8wBV4FohGKRpFw9oPZhqoBP72PhsJ03QisXq5xKB454jcl6FXR7+0Egsa6wD+7WvmnDXZ4FH/RArsMq99EL5Q86zZ/XSFxpcKBSTYi4iOlmYHRa79jDzRrnRjUXBvCKSQyrVvst5JF8AYAd2bZUVI9VHhQoOVnkF4kR1raK7NN3ux1JrjTkC3U9+5zqnfKj0SufJJL8Oa+U2PTegjzk/He8nYK0SBrO/5INFhhi4a8C/7aJH2ag2t0cAUu6sfkyEOJ4eDYVMdxP+jiacxUJipTw6AF9hrEejg3AjhliJzse68xA07AA05AiDcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:30:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:30:28 +0000
Date: Tue, 4 Mar 2025 10:30:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250304143026.GL133783@nvidia.com>
References: <cover.1740574943.git.leon@kernel.org>
 <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
 <20250304131852.GH133783@nvidia.com>
 <20250304134418.GF1955273@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304134418.GF1955273@unreal>
X-ClientProxiedBy: BLAPR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:208:32f::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaa7876-dc44-4612-3da6-08dd5b291c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+Im0EsVgWOEFWKp1x+22BOEQ13GJXcdScm5icL0cQEITlzIaPjb11U9GlI+?=
 =?us-ascii?Q?OZ97Hpcz/Ub5tNIwCdeTbWmDD1GYBl8RxjgHlhJl9WTfpB5cMEm1wt7kTKan?=
 =?us-ascii?Q?h3D1h07XPZQTHZ/P8IjXSP1TM3W2I3EHHZPCpxc2++w0W6YzZX9zwNHEJpZZ?=
 =?us-ascii?Q?MNdHNnEE02IKdGBLrFe3oWqaTHRXUhdxhEfj/uPh6pViC/awSdaE25jqmTka?=
 =?us-ascii?Q?DbiP9d72p/SrVNdocbzuidp7OrI8/dkh3m7/GNNiRHR6V+zlRle7PZC/Y9f4?=
 =?us-ascii?Q?pRe0X0Lw9SnhbE0/5KkCAtu3qNnEwr9oM2TvuqRDFmvgHxc9Q61PmupiKIBT?=
 =?us-ascii?Q?vBUFnurnxIk2i+b5LrxZ+l7xct2LzMWJjPOuleeGAxtqs8IZ0H7tkq87lsLD?=
 =?us-ascii?Q?WplwKgiC5fhSpDH3BL+/93hKaFT1+uA7pQBq2ghNmjuxXODHjj/NT7qRhvCt?=
 =?us-ascii?Q?W75t3VNacK615bzMn/pBEkXXosBIdOj+19InZLiBiVUvFo7LxGmK/5dEtLO5?=
 =?us-ascii?Q?+E3U9BWHU8M9s9tQmCjSfnkpeDWnN36ATD2v8gOdqo3jz/gPnHDwbhhwv+FY?=
 =?us-ascii?Q?eHb1+iASaihn/VfH6M8368B6h6Esstsc31IqXTofdcHMElNolmlJiF5ChACi?=
 =?us-ascii?Q?fNTvMbCPTpoe7IW0tQYe0w93iVJLzZux7LkmzBSgHYV/GOiRBf5U0dS4dEn8?=
 =?us-ascii?Q?IKAlOme/MR9aH/upnxhAuXUeUVavr5Y5+7vuhpNflAxsiGEb6d3JWdvIiH6l?=
 =?us-ascii?Q?2vZvzXnwNq41dJnB/sUpWAbOuXwPIrlfFqjm9QitlfLiPWcVbDfD40oZiecb?=
 =?us-ascii?Q?etnaIQQ6ApUvZ2JzGc1l65GqG8AFp/a2DhH8Tg7lTpPGoVzD2iDiWQhNVHLh?=
 =?us-ascii?Q?iEXZnT5t0zbMxNSd3IEgnceAN8qFvIW03gJH0zEc/ep+IBEoCFmzhoP7RBxF?=
 =?us-ascii?Q?UETK9u2isog/lw7YjijmwyuSd3EVWSyjnbHQKyyqEhEnZwirrhu/z+i/lZJ7?=
 =?us-ascii?Q?HumE8OdNuPMqC3eoWP0o3453bgm6VdV8xB1xFiknMHtVZFzJVdGdMcdErxed?=
 =?us-ascii?Q?prISNBAUppsiTaRrLFcOMwSqAzlid/x/RiIgd9sKDuv7VaA5ogPM0KMAIyvJ?=
 =?us-ascii?Q?83rvDHIo+8W6ED2UKs3IiUNO5wh84+KEnJ1qsYqPgVo7cBCeFaE38pnGbCA0?=
 =?us-ascii?Q?Udx4oRpEqNcvxwacdo53liY8dz6MTMh5398ZMVMRrhcMYHjyj9o/XcRNOvkc?=
 =?us-ascii?Q?4UJayuLmtEFUm9NI8xWLFwsRl3ahb95oU1WAfVTnH6MxOAwdTQjocWTiZnKl?=
 =?us-ascii?Q?k/8uxsAegTKtCKVsU57cn7NYJ1DR/VGicYa/G/yDkmdPgqurscWjjnT7vOoD?=
 =?us-ascii?Q?i1jAFC2leZiD5oe0qqwMzu6iVT42?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/o2auNIQoATPucRvchmYj1Al56GXWx0vQ7QaSokfhg3naytWYKpJq/qvcj7?=
 =?us-ascii?Q?0x+wJr9olkEnQNfMEl+1+xf+bhZTz+cJdiXEYBpg22844Qm1O2qBvEzA8+v5?=
 =?us-ascii?Q?RPOQCrsQ49klhe6/OTRbiLe2eaXb/ej+GwuG+K3MFCM5VSVItZafRCvmHtO1?=
 =?us-ascii?Q?PXhYzMuQBs5EkQDaHqX1LRmFWUDyhMF8riYsesZj7QRUReL3LHXglutP4Anp?=
 =?us-ascii?Q?VIP3riG3WOhTy0IgzDOp7WotVyzK3sNaUUBZ5wNZJsCRhPGVWc180hT+O3He?=
 =?us-ascii?Q?UzSEapAHiXCt00UUYm6Ch+DzYHyOH2pIUIQz/iwv9JLIjBimhBJf3hxwWTLC?=
 =?us-ascii?Q?LGDx4WWq9Cfn672cHbotjH1m3RAxZol1g8Vqe9RkhYfUehPn4co66s+qrWxe?=
 =?us-ascii?Q?Dkaue0AAuG1+d5zU7bY35oXaz970wha2AIid7musAZHJ5/a2n4CWOnsVFIzh?=
 =?us-ascii?Q?xJHuGpDO2D1/imVci67qX2xb2NejPWny7wci3BQycQolXumMxtBU2ZvJ+ruR?=
 =?us-ascii?Q?YxNH97JkCYxZJxFU9rmW+ITvSEQNE/HxPNJGzoKnVw8D/FbTE7udj8UblzPG?=
 =?us-ascii?Q?nIiqXdDfd9ZnI4b7cpFElAlXGWYOXyZhor02QlMuaJtDn4LSOSpV1iB7mIlC?=
 =?us-ascii?Q?bjn69Y5DEAZYbJ0zeyITIjjoRSfpq2Z2Va6EtZ/J5XP/v1SLyPeJ/ukcYaLp?=
 =?us-ascii?Q?LvJltjnSevsZ+8g4tT/p+giuJPCvQnOELRmJw8os3JI8hjIoWQ8BtB7Py84z?=
 =?us-ascii?Q?b1YMORS5PhUPFRDvmg9Xql7n82RK3Tdb+UhdLT7qtfyeRZZf/dbnYSl31VGx?=
 =?us-ascii?Q?Qx4kUO51HysohI6mPnWfhe/06q7TLdUEyuuN/WfkqfWqEKEnir/ia4zAHQYU?=
 =?us-ascii?Q?nhV4SiXa07y49Apfx8UkdxljbNreUcvfYWjLWeletycG0gGQibUmd3iXN/MI?=
 =?us-ascii?Q?oXfQv/lsBDOu2g5mxkMUD/2JD7RmriFnZy4muGj8Ti/BQ41P2I5Jy+ck7Gkx?=
 =?us-ascii?Q?arLZGzO5dXzcS2FswRZWumRpB2bZ49JQlIYqsCnZSjuTkRuuY6W2exM4tJ7f?=
 =?us-ascii?Q?sqG7KEscQ0AggBesk2STWJS4niewqqjv/oH9g5vLte8Hv0oKYkALfCQWjsfT?=
 =?us-ascii?Q?VFVbkfg/eJ4tYVvXlowNVBg4+CrCJ+DpVxy3ozyQN4iEJXok5krr8E2cy5R2?=
 =?us-ascii?Q?p0QOfj0EN8ErX8yq/fgqTobvW1xOJ/WKgvdrTyJdXhZrOzhhMjqnX/fO0iKR?=
 =?us-ascii?Q?ceU0dHuo5YjkUK7DDrpAmiWseN639E9EZg6EWWcA83FU+372CUrGVQjCIJEc?=
 =?us-ascii?Q?SWmqz6nLzmuiN8+Yl0jEFoyrvCWlV42wPrsb9JCyQ90sB+57jOe8MAJBduaz?=
 =?us-ascii?Q?YXSvUAbcSPZsX10QqtSdZhtVTMSEfsPvdpG+Uk4ts1SEShQQkhfPwCztczeL?=
 =?us-ascii?Q?V4d1/InrliudjPXHL69t6pFFT+ANGaf4hlKKiwjqvaqJTV+7hKBVTvR5t2xW?=
 =?us-ascii?Q?/zUtOPcYSIt9I7k6byP4uEul4+g8PDs+Mr8CMeVqiHucShM4qxmtiorYtzhm?=
 =?us-ascii?Q?nFi5r/cNsoe2u6Y5JGI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa7876-dc44-4612-3da6-08dd5b291c36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:30:28.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjpW7Tip1XNEfYtglbBarTSJyCATEXFrhj0PEfzSa6wDZAlGTCVJ0MCjbRSjm2aT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

On Tue, Mar 04, 2025 at 03:44:18PM +0200, Leon Romanovsky wrote:

> > > +	device_initialize(&ucap->dev);
> > > +	ucap->dev.class = &ucaps_class;
> > > +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> > > +	ucap->dev.release = ucap_dev_release;
> > > +	dev_set_name(&ucap->dev, ucap_names[type]);
> > 
> > Missing error handling on dev_set_name()
> 
> Most of the kernel users don't check dev_set_name(). It can't fail in
> reality.

I'd still add the missing check

Jason

