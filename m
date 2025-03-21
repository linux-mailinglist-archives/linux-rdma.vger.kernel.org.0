Return-Path: <linux-rdma+bounces-8900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA3A6C684
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Mar 2025 00:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE1B48171D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA64221548;
	Fri, 21 Mar 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSOEKXlD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715131F152D;
	Fri, 21 Mar 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742601032; cv=fail; b=iLp1NSrpsIU6dEgYncA7Mii2f5w9Fw+QbUbjuCH1KhA5E63YEhb0t+qJrW1HGhOP/o9YnN1/mHVeqK9gF9OyuvZjaUbMC+9H2sk1Jh0utNnPelYi+IXdbLqCzRNIQQlRZlTgShCXVeZ6MjabmbZfiweQccVK6baAVfuQiMKyxjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742601032; c=relaxed/simple;
	bh=3Wc6Sf4A0KQv/1ZtppwFlWCgfJ5RgNikvl4TK8h/IDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PF95+nQd9c0YtgI9B/SsTjOFf4hsLfbh5db8qvJiqIOnBp68bK7JtASXMkMjYO+1S/WfxNtW6S2ci7DaFSwCaBvrYUaCJILox2XGx89GRWadCfX2F5SxCxHpJ9nEroMwz69T5arjmMWIN4WoYKNPwZNkUppvW/kKTiyG3MhGFPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSOEKXlD; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adJflq46xLq2ZOwDS9CePjmmRQ77DFXwyj1bZhIDR+OAkgO6T9A5KJEF0X35peqCog+5E3ID47TuxAUqP3jzvhlWrK0uZfJBIcfNhr7IvCxzqgZt0apEzwlVo5GPwUnfT2RyoJp6tdi6y1nHn7DQgcsk9YZKhlLiJ1K2VlA0AZOFJz6oHxa9KBLvASvRFI50A+kcdqViJBSNQTpGUkZy7FFWVRphlJHmZWx3ZISMQS+nBuA0ns4c9F/GrJ/1At0sA6wQjUFsS6ChPNsZ/VLa0mWZSZd68ZKMrIO9HxNXimw+auQw3682h3mbkKiie22qQfRsL9dgnsww3C5cclTA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hjroPl6H+a153uxo8MRJqLCcYiN6hueQA7SqW+uflE=;
 b=ncRbHnd9WhWUq2uEupmyBVAxVb1kc78f1+WRARI72sVtWZGO4WtT5cYCWpjwE/4e0+t7QmBH1iu7lJw0P2R212lVuxXsgR++5blZ8TlfN8dUoodmGHCXDNFn+SZQ51dg+oaYLez3y3T4zjX3pVBN014DH0C25XgxKal1sUQPeXiwlZOm96QJ0gv77+HNysPfaWvgC1YRs4rP7i0RALQDgyg2BqcLmeVVnqDadRsBYAE8tvhLx4FwgHgbtWXM/6JV/HKlwd21S8PxJ9u0h3WDwcerzEWaBPj2Y+35xpOz9RZPKCzrJD95Xs4ez3i1Las2bYOS6QrHVcIhCDelZZwIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hjroPl6H+a153uxo8MRJqLCcYiN6hueQA7SqW+uflE=;
 b=OSOEKXlDXiyjAwAkE626KSgQSV2g8/G4HyX0619YcxwIUawX1GnjgDHJCfYnPlf8Id2j/A7b7ot4mTKB8fp96Iv4i5VY059MMChiGgkMG6xnhVWEibSct1s1iG3MwnSJWgz4Dail5ac56YLRpr/PZcBTPrt3iJaQ1BHpNv1HfnAgsQ/aw05OQya9YSlKs7R3qu6E+5PsdFZ9QakUMrxFKxeXzAiaZc1FsPyDGuD4g71SFa2s4sWcfgKTXGlBW28Us3o81kmfoUEjwll6IzAV9E13Zpk7mazkn6xjbKkZV5tKE18sgYGQY8FTeB44S8LqQGNIT/gX2bKbmd6JZ94ONw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 23:50:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 23:50:27 +0000
Date: Fri, 21 Mar 2025 20:50:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v4 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250321235026.GD206770@nvidia.com>
References: <20250319213237.63463-1-shannon.nelson@amd.com>
 <20250319213237.63463-6-shannon.nelson@amd.com>
 <ac2b001d-68eb-46c4-ac38-5207161ff104@stanley.mountain>
 <8225f492-721c-42d1-ac74-cf1a20f19b8d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8225f492-721c-42d1-ac74-cf1a20f19b8d@amd.com>
X-ClientProxiedBy: BN9PR03CA0762.namprd03.prod.outlook.com
 (2603:10b6:408:13a::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a99640e-eb50-4a11-ce42-08dd68d32796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXlBwYC2NQre1k3HUtpu6/DQho4WiMVmPuaz8bSoK6Iltc+duR3xdcU5Zcpc?=
 =?us-ascii?Q?YsH3mF8yvFHEFqsES1V2yAJFzA5ckkkSgMB1IIIir5uIkEdrcdYeigj++HjI?=
 =?us-ascii?Q?Sbccgr1yVlsVbaRBInL5GzrzvTsPsJtJUu11h5MKAoHH7BDfYVoKHvAeoVwR?=
 =?us-ascii?Q?+Ugt1Wks+RmTGzVx7dA8fVkcTypEWv4xSrQcNbsJxIvsvhkLaZwFc/jAbDKX?=
 =?us-ascii?Q?GFMcJ7Sb9JPN7xEAJlSmUr5JC6Fk72WGtctfnnXYtu2IlNwIigPzOXf85mnQ?=
 =?us-ascii?Q?kM3XhD+JbRANplXZTklYJnRM9jUSNZmG40gM/0bzvT21WMg6wkV5K0oz72Cy?=
 =?us-ascii?Q?r432Oxslb60nZYhkM9VVWXGmRBfS00JfyHewL/J1zE/oyb5xS9LXHquibOFT?=
 =?us-ascii?Q?hEESLZXMuJHqvtPOJNYxtYual7yuu+bkZhw2P+R8Yr3CAlg22p48YRxLES8H?=
 =?us-ascii?Q?LMzU7CySRanWmy7qCf3lfgLP6SikO2A4qchdZliguMa3IXV1/eC0ut0gHhcE?=
 =?us-ascii?Q?fLoYoYBbN8UybBKE2aLzMFQdPHi/UraSHY/suSRX0Q3STjhuKlq2g4CxWpRf?=
 =?us-ascii?Q?kn+UQ4fBUjQvvNaJ+4ufaTfqHyEq/IZzvQHPUFY+4nQRgX9psVdjHvYOruqn?=
 =?us-ascii?Q?eBapPlUa2dUt1IEvw9ulQah+ZKit08D3jvTaUDjOnbhQVBkUPhNkDoVRPK2C?=
 =?us-ascii?Q?He8mr4PgRkx8j8ySY1Pdb9tAGS5fMWqQTVFqUpna7mPUupcdvzPk+tnpaXlQ?=
 =?us-ascii?Q?ZVMlJXJ5YC7Lc53A5nwpY+5NU6ohju64Wn2kING2B9pnpeDpjgkU1YkK1ZN9?=
 =?us-ascii?Q?oWQ6LVPS75MX/qHTFzt1PAS/Kfs5RG44Pb6fkWuy3O2QoS4OCxrNnDqjw3+d?=
 =?us-ascii?Q?oKN6nTHFHN54xNWfuvxIb2eUfVORYx+RvGOG+6Si4+TYEelisUO3Xs/kQBPI?=
 =?us-ascii?Q?LPmzsl5VxVNIFEuPUONGituNv7sP3uh+LTSGmJNvXh6oZfhBNf6wqjaIoUpL?=
 =?us-ascii?Q?r+/ASrHqbomNPv7J/JIdKNisanoGO2ESJhJzuccIb3XyMYCEu3CJgzbFD/cl?=
 =?us-ascii?Q?maJx9zmArIhgjhev/6ZL7htAoHz1lW+fTZxhzcAY2qCgRwiYJLVWKFd7U06H?=
 =?us-ascii?Q?hr3U06Cz5geAcTaa4wNdhQaVSG5gZjkz3yVkvNcjOu9B2AFUdjUwe8U5naUI?=
 =?us-ascii?Q?xoyCoZpCIYrQubcYz3o08zo/Q0wIIvC0PaFI4MJxkI6p8dIPmYI/9dH4w0wz?=
 =?us-ascii?Q?6nafotaU5PZvECeGlT6Fyvk0pxl42uvWUUFeKOI97QYzagJytYVVDdWTl0bJ?=
 =?us-ascii?Q?sQun1OwYFpFfH78eW5NkXDfmHGfQ3edBhDdzNt8LzBIG88RIRjqdP8Rxfe3G?=
 =?us-ascii?Q?LMaHJ+yEe4KzZgppLp1i4IIEeQw4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kx0mONptDHnZU/vjv2GFn/Jo0uiwEjO/LxaBmMiotqg5QN1Lx2j6RXcxek+D?=
 =?us-ascii?Q?/KFpARUhx0soaroFyzN+m4IkQrsooRG11oECA1s8oX2ouWrz8gmd9VJUZyD8?=
 =?us-ascii?Q?aHpnITXrL067UiENbYh2yISV0M4Rm41W2xwJ2xH1U9xM29vJfYExVjVCZUrm?=
 =?us-ascii?Q?P9CbOOmnCc/QDVNUg2nfs+ZfTptHMcYB3Ba0GAst33tyD+bAiwd2uOq75JBg?=
 =?us-ascii?Q?xjpKmde1gS5oueONKYSxy+6HvNb7K9DygCRdQtChURpBnmsZBkr49DUSBdCW?=
 =?us-ascii?Q?/8/J8rvCpNxKPUUMNgjrD1fI1PiRHgAh0/CD7tUh1DOP+t7squDoQhNTznZl?=
 =?us-ascii?Q?zPRLgMDm9y4pUhg6SN10Te/LsKeopWzdSUViQJ4a271QO2yjc7lU+blxVNAe?=
 =?us-ascii?Q?t/15PdfyPucOQXwUsBlKKbMHKSin2YetV9k4E3r9yGpGsNn0L1+kDjsWYo0v?=
 =?us-ascii?Q?QnrhBgDHGgLJ2MPz7XBfowOy0XMJf39vg/WQXgJk0QqzQAhg/acIozwIRbBn?=
 =?us-ascii?Q?IoduDTMhgTPX7cIGritHzVD7W9CMj91GYj6YovcnfEffxy26eSzH8IxVddn1?=
 =?us-ascii?Q?UKik/CTOkcp7fOrTwb5y0AAxZ+LRuiKiufLHmI7NOSChj6rdaNlTSiQeRmaD?=
 =?us-ascii?Q?O6gPMtNrbrK+anfkpIdTXl723qJ9VFxLj3ugXPL4rt54RxdSeh9Ey2nx+Coe?=
 =?us-ascii?Q?PFH5wkNF2Ze6V+eihFqIw7x3QQO9Pzloi38yN12b52Pa5R79chYRG976IupD?=
 =?us-ascii?Q?zw9G68KzrTUMdZSidtDUAYDsspefpKSgxvuv6RFXFR1vJIJXsWGuNftyR8Yp?=
 =?us-ascii?Q?ItQ/RGrd2oSnfbnY7/8jzTGFKnIDdu9Exdbjom+A5eNDEDKVrrDQGmbFkNzy?=
 =?us-ascii?Q?iKuYW4q99D6eVm/PL8/3g4aAOHQt0/iBnbpyKnn31SLP66r1HRU9XU4huwnu?=
 =?us-ascii?Q?xA/CcZLWzczVrnjyoh8ZDYrqWNnUI7aNtpqCwLXhLfUaBqkvCfoD6q8aq73U?=
 =?us-ascii?Q?Pwge3JPX46K317G3Vlr9bjigrt482f4+u9GNwwbMMG2lhktZrioPvATsNzHk?=
 =?us-ascii?Q?rkvSseU4oNe1dhAmazmgY4q+kkdRTN327yRm7HCLtLREgdOK1o73dn4Wb+Lc?=
 =?us-ascii?Q?ZsM4JVlhapNx9lkWMRmIZ1NYg3t4Bws97boSv3J+YXO14pc64Q9WVGvNYcA3?=
 =?us-ascii?Q?UfD55yzxwEqHdHLz/60hKQNbyLSJy++ig2gPicOvN9hXzzMWAufl6R1FElB4?=
 =?us-ascii?Q?3yeQMMM+20/zdZx+nyaynb+4RGszxmkDS2AncVKpqQxJ95KMEGgyumLUw/Fk?=
 =?us-ascii?Q?sf0pKLF8c4ycjrxjGx8/Hqb19qZDRLZn/eMzgbJJ+WU9B0NH+snh1Us0meMe?=
 =?us-ascii?Q?JSH9R8FNF1PHFlQjHgFggW3NgzpiSsk/XSREjFHVkltxtVgBJF5BMEx97PbC?=
 =?us-ascii?Q?RV12eKDQNyS8lG7HsRiYgcHGoBYO9BP3/yxdHh/TAogFu0CnKEUXcL2qDIKU?=
 =?us-ascii?Q?+mdbzOGq3+kUqVYVpDMGsSp70gTFBagNBDu3b59cKSefR0wAzYHMGcVzxqeJ?=
 =?us-ascii?Q?X9k4xWweal77GQ/5lIfBTAlQCCroVWnse8cv2kJN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a99640e-eb50-4a11-ce42-08dd68d32796
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 23:50:27.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jzbu/RNLdhGB2nhrfi4hcQL0j5F6VzcobA5pszBlbjAXRKSrr3MLpd9MZ4oISEQt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

On Fri, Mar 21, 2025 at 09:59:32AM -0700, Nelson, Shannon wrote:
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 6fedde2a962e..e50e1bbdff9a 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -76,8 +76,7 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>         int err;
> 
>         ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> -       err = dma_mapping_error(dev->parent, ident_pa);
> -       if (err) {
> +       if (!ident) {
>                 dev_err(dev, "Failed to map ident buffer\n");
>                 return err;
x
err is uninitialized, it should just be -ENOMEM I think.

Anyhow I fixed it up, please let me know

Jason

