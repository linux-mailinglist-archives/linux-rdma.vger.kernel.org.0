Return-Path: <linux-rdma+bounces-14662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A06C7616E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7A4632B20C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F52DE70A;
	Thu, 20 Nov 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UWu8QjQY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4A279DCC;
	Thu, 20 Nov 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667226; cv=fail; b=UdhH3ycCDqWLc/7Oo1CW8stUI78KabIP6yUhDZm5l4/8BLtcSHFKf8Oa9YtzTdPKNT2+n9PZszMuBEDomYkJbR2CFVJwLKgqWvaTb3ecrtlkOxMVchQ5utGFg88Xr5DClPHeiK3WLBSj1F0bwHknPKRKLrf4mnvu3Q+0/w4BPuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667226; c=relaxed/simple;
	bh=m4g7Hk6P1LLf3AFN/73XgKEahSstH1mZZo7ULQko8Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kXo+v7W5VWNOX0CHF6GD9HTB0CzqUR4BbuH4IYXt8W9Ut5VAUkhynajFXqz/6jyPFfb3nHx7L3kuHepugNlxspgyJ9+aCHPe92BdLnFgzG4QME0+1IOilREc5FXxptAaiREeg9gMzhHwDkwfhFGiLJ9Tsb6xt3d4+EpHXNb5ZNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWu8QjQY; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InI+kTvTV1FJWPaA+wipBmVLvezrRxfmx4edUzg9DGD1egdIk020qcPLRO32nSApamqOvjKd/y6wuLxnnehvUMMvrnzzshkIA1TQiyrPH0RiAq2p7OK2gWM5r7Gu7j9OG5u9ouD8RwEXtKRutxRuCbqXrIitLy0TtdqKiwMIc1NyQWfLBFYlDhy1kvcvj848gTxvkPKBE6I1vAqLmOsC419GppzjDk7RPz52rcbvhqvZ/1WLiEXWzich8koFKKk9m7G+Kgt4a/yOFT0+Thy9bAVQyijN6iBraub3ujKje8Fvoonj3CtS3CGX/SrxHQj0FoyQkKF4bTMAJ01BxXyQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcSHzI1JdqqcC1AaBRRLRtWp8XGhOSL5mCVVFR2CxbU=;
 b=hQSI2OUhou2HW4WCPuu17aJ5fdwvfFSfizKuO1aSstOPyKFcTbnMoMEnrH6HHYh45QdL4XFC9YWA9Ef5X8T0RKjT59/V+lbcRoyP/AGxmUOJ6kTpvniM1X/cbQRQI4V59UX2dbD3fSqdyc5mL6awgqI5Z7ecHEtEdYXyS2QREKAdHFNPoHTC2nfejwua2EbADQ9nggDeXgwIEOyvbRk8XTP3Dss0ZPfhyU1rcHN1EUT8bjGAVhRLOkWGZ5CuAk3nN7AHwllgZ6lMsQrOFDih4Ruu2AfPb/lnczP5RoIW8Dh1CvxeL1dj353ocG91WFWUVg7lsfG/chQu6qnQnzhBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcSHzI1JdqqcC1AaBRRLRtWp8XGhOSL5mCVVFR2CxbU=;
 b=UWu8QjQYMLkYDa4Y1VQnIPW/fStDEt4ZAg3KoIYNlAA1HovO5QwbwYvlIQBaU7D4yz8yeQ2AywUq6PY4vnoW6xkkw6lLYJ3C//CKHjsv7u/RIRQEyf39bwKMjqujU/mPvds8k5QTZdD4B/UYrtF8cCBtLlJJg2VRA07t2ztY+u/+GDTr1lPE6UpLH6sACMnYrzfJ5D10/fLmLAq8dUlLZOCBK3tY8AcWpjdtYIZYNu4xvZ/pwMKleRaz69Wq8B2KJpWEEBxRXiJUfQVeI6FkAj5t2udcfYxKnq9NI6VRPMVyxoq37c2sGxn3GuD+PqWe1AN6bAkSwmFaHyEUc6Bh1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 19:33:39 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:33:39 +0000
Date: Thu, 20 Nov 2025 15:26:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
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
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] iommu/amd: Don't call report_iommu_fault()
Message-ID: <20251120192612.GA258497@nvidia.com>
References: <2-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
 <579bdc4e-ab71-4120-8991-34400d4bbf8d@arm.com>
 <20251023142657.GH262900@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023142657.GH262900@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e6c7a9-3a70-41fb-92ca-08de286bb46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buiClKIDtZjXmPmwO1cblyZpH4NLrzB7VZUS+Ti/ebKmfkb230NLj89SPxpc?=
 =?us-ascii?Q?Lo2oGgxXrtSSRCmZ6+HAmDLrAZrh5ZMMezOvqEz2Ir+kU4kllH1FaA0ZOYAq?=
 =?us-ascii?Q?SaLZWCI7JNrYivDxI2oUbXIXC+ve49YG8bZmBXDotg1C5iCyNNaBSR1fei1s?=
 =?us-ascii?Q?+8qSjmm1qdAMgUD/wFMI/CQ2uyPcPdJ2fGFCy9bcw9mPfVwQxitNP1S6laKM?=
 =?us-ascii?Q?5WAMbiye5cRv8lO0NhUjKK1LXiw8o/qTff0A0gGz5mBGVjl05Py3XDwPUkp2?=
 =?us-ascii?Q?13dHshgLZYRkZAQFGPSP/m4+DA7jUp2oZQckOfuRpxmbL4gPgPIlZ8JQ3kSD?=
 =?us-ascii?Q?56Si7Z/Fz8i+sDPoas/HTVraxl5XAPFA5K1clRUg6VHfLFWsO0nfepUvSiuh?=
 =?us-ascii?Q?z+wHkdhdgXj/DCAA/prNZgYAUZ5oczeE6TCnWTBX3kn6brmkVP34h8ABoRsm?=
 =?us-ascii?Q?CQmftac+a07TdozXalEZ7HdW+o0f5zxojxoN5gBqt5YT6GC7N5PYmB6GRZgY?=
 =?us-ascii?Q?ednS47+3M/H7XVUgGNm2m3ekFpm7W/uMt/Da5p6uRCBs8Se6+iPb8THDqXdR?=
 =?us-ascii?Q?A64mSHC0AiM59YEKFeM0oX2rm4CpVCdhkoh0PJ5/5tsFFr6sb6sLwVSAZn2L?=
 =?us-ascii?Q?DuuxaTG+aQMs5OgXeeYjBI6AtuuYd7G+Pnl5E8w6Wc4UDL3PycFAXEC4Jjrc?=
 =?us-ascii?Q?Wpf4arNMQ8IMmZs9PmsBsgWugHQcOkVLHKacexVv2ILRBuKHiN1Q/8ef0Ro7?=
 =?us-ascii?Q?l0K/snlFAKyAIfGx5n2Lsq8V1BfBwPprEGY5I4m5A/t9+pLX9jWRygirvjIx?=
 =?us-ascii?Q?sqFdnr9MpJWNFW77IymTwpksEly8RKaHKCsEWoQuP8Hfx8My25LyNIY51BsJ?=
 =?us-ascii?Q?j1bnDBu5YOBlxgPG2rm3x3gd17coiK2DVL7hZGLFs/IECksf20+JgF3RO4dJ?=
 =?us-ascii?Q?BMdcOtapLKxKm4WXiDJ+3a+bO1Z+8olerVGQvv4CXEatEfpoEEafeUoTsbuI?=
 =?us-ascii?Q?dFrnUg7PCoF0VEIY3/mMOdpoPqF+GjA2IxRWNS8MI9WXJmTRbbjJaP4lu9jp?=
 =?us-ascii?Q?7VMkrCJU3qgEwpwtWw5Z/BgRAzUCNHQuWahgHdTnA71wxqbT9LAjb58cObwk?=
 =?us-ascii?Q?OB/0EoEGkMOSYHC7pN7uPkgR3aiJEBLBxh+GCLkzgh2PgxwhScjzOy3vSSDH?=
 =?us-ascii?Q?RqMmfjv5ognKbLZhWzkY48cQ0mtT70237tUs8uj5806yzsim8ET5evzxv9p1?=
 =?us-ascii?Q?sgSjPkBWDRFvFA8RSHKyaapqCtUTyjhUx0YAUqLGnb1vlFSyBgKYezvAdovW?=
 =?us-ascii?Q?7IxSal2Bgba7JBdr1DKeWEsK4eP0jJ2/xq35ktvT1T5LNegf+8YxtkV1l00h?=
 =?us-ascii?Q?sxh0A30K0nCiLVQ89rEdbm/1T58xMS/vZhdhcJ2DP6LSWhzSjH5WgSlVwGp/?=
 =?us-ascii?Q?IJtDUeHucB+im31jaH8bK+f0CsaHzNud?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ySCzhZnpHxOWqPI/yflBssifJZdo+Q4GOHTvqiLmgjAL8b8ZfrHAJoMUSB7z?=
 =?us-ascii?Q?xq/8qubLtMvbET/ufIu6o4jj3gL5cO0m4S+TMEp/eHVjPQzYkhZpl7hmMZMM?=
 =?us-ascii?Q?bRCFk44q8sseuyxJcH9ezlmCiT7sqZa4OvX/xlHIduD+z1WLinZa6x2jVU2V?=
 =?us-ascii?Q?qRDCWGdS/Qdv6RtBpqNtNciEbRpkah2gihPgwddXQjVY0nWoXaKtu7tG9rh9?=
 =?us-ascii?Q?qKexBeMNUbfuyfGtS7URChx1F4pjIap/eHEMuabR6GUP+N9eRc0XOnTX0DVW?=
 =?us-ascii?Q?G4CYS7uWT+wMcplvHIP0IEXKTQ6n1VOB7G/BWDyOBnRQp4LyyE0//nl88nlV?=
 =?us-ascii?Q?SYyjUemajFEmk/3tUUBeCxIvWRXYMe4NI6hLyhW0gN1fwPhrE40y6FokjW/U?=
 =?us-ascii?Q?BfllBxRUdOoH1bQr1BjWyICJN+ms4r2FgdEWloOI1JixUq3vzKj6P8wDIyhN?=
 =?us-ascii?Q?6WMsXjowLydXLd1lnnMLYZ8HoHM1k2oVUtANhMavTmHlo3pml2JIu5YM45P4?=
 =?us-ascii?Q?FL9I4z+ReSNgxRfPhEclEcpJsRPkZ4KK2HuR/AzY7+1Y980VpLcJZAFAl2q6?=
 =?us-ascii?Q?3Vy0A/dj2FMtIzzwMk5KA9P8SXHg1eI33GcGOZ+04KfdfaMpOmOJgREbnZjz?=
 =?us-ascii?Q?o0aIqxm18JKs/eRRrRek09OjpqlmygVb49ZaU3+vhbDWT2Yl3jakXhm9Kx+I?=
 =?us-ascii?Q?dy/aWsbadrZU0z5RSEgBrvd2TYSbDeh1axww8/Cqh+sJxTbXOiUascrztriP?=
 =?us-ascii?Q?OumHu1b5hztULJcqvW2OCVoPImRLYeJ2FqsrUBqNcA27fE7y7ymTrYSWEK08?=
 =?us-ascii?Q?gFr1noDcGUQCYB9aLfHtoU/0zyH/aC45I456+u9veAl6XW6ELSM6YmiVJWjV?=
 =?us-ascii?Q?q22GptSLjMxE7jpj3QKyVnP0EQar8YdOWxtofOXi3AvHybRPyqb7IPPHQaJV?=
 =?us-ascii?Q?NN1huEPmQlMlJv7OmAU+GvAOx97MZ8MqYMCr3P+UAQG4ydNbkj73j6r7R9GK?=
 =?us-ascii?Q?+XYJPnsBm1SYJvtSh5pZ6MN4isEXUIK8bY8FUKOgcx4FGMKsd13VNRFxmJvl?=
 =?us-ascii?Q?tDDfMXQVL6aBKxCZBfiKfJNxVtETl8rkBS0GnNR6xBUsjrt/MLI0Eigkfwky?=
 =?us-ascii?Q?5Z/bvfeZL0grGvMxmgPn64pezVtBfotbriDq7dO2u04umCy7Qq7jwBlG1Di4?=
 =?us-ascii?Q?9noVFIjobLSdwkmKr8H/qpe9xGtfwABpqQhI8zrHC+AiUmmOXB9IDu8mTrTB?=
 =?us-ascii?Q?Ly3xFJ9jnOIt5Aesv82LtttD9v3giCGWppo4+AIHijcotRymDdJ9tfQkc8NG?=
 =?us-ascii?Q?nhjuCdWp3524BAhXZqx5xjzmm/sn2At4Dpls3TxCAo/bifDAfaOPXYzOVxOP?=
 =?us-ascii?Q?8Xf4dn2I+WCK1nxKE+otod9U1eeB9gYAO3ibWVCh6UueNaD2oO30AMhhV+Ks?=
 =?us-ascii?Q?9L6DhIELVC6oFpDFG/mdySdVMVy9XQDR6dLBGqmbGOniK6pNUjbAgTNsaKs9?=
 =?us-ascii?Q?ETz7Jkaausn3CkzRziGkQeF3kUNODUCkpvvcNa5vw6Roz3+AvqiI/h29H9E3?=
 =?us-ascii?Q?SUlkuE/JVTBhEAkyOyE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e6c7a9-3a70-41fb-92ca-08de286bb46e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:33:38.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3E6T2HbLCadhRg05ogWH3sH4JtZMr/WAsgRI9TGrPFbqoQ/Ga2dOf1BMWQS+fdEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

On Thu, Oct 23, 2025 at 11:26:57AM -0300, Jason Gunthorpe wrote:
> > >   	if (dev_data) {
> > > -		/*
> > > -		 * If this is a DMA fault (for which the I(nterrupt)
> > > -		 * bit will be unset), allow report_iommu_fault() to
> > > -		 * prevent logging it.
> > > -		 */
> > > -		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
> > > -			/* Device not attached to domain properly */
> > > -			if (dev_data->domain == NULL) {
> > > -				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
> > > -				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
> > > -						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> > > -						   PCI_FUNC(devid), domain_id);
> > > -				goto out;
> > > -			}
> > This part is unrelated to the report_iommu_fault() call - in fact it was
> > specifically added even more recently.
> 
> Yeah, I'll fix it

Coming back to this, it was right in the v1, it should be deleted.

The (dev_data->domain == NULL) test was added because calling
report_iommu_fault() will crash if the domain is NULL. This removed
that call it so we can't crash anymore.

Instead we fall through to this:

		if (__ratelimit(&dev_data->rs)) {
			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
				domain_id, address, flags);
		}

Which prints the same information, the "domain is null" is not
especially useful. Further this only happens when dev_data is set it
so is very unlikely to be NULL anyhow, there is only a short period
after probe before the default domain is attached.

I will add some remarks to the commit message since I forgot why I did
it when you asked :\

Jason

