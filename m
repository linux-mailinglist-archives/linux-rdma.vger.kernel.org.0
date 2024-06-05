Return-Path: <linux-rdma+bounces-2907-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A88FD20D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C80C1C22EC7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10991494BD;
	Wed,  5 Jun 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EUpSwwUQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01B376F1;
	Wed,  5 Jun 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602559; cv=fail; b=dCpZEnZKBtMMpTV5hGbLuH+tHcDSGIdAYD7Ol6rqJ4gH9CPa/eLdj3moR0G3eWJvr/Vw0BrHzFqX5f6VDd3ds6epWYM3D0TwY+GKB2wvE0nS8XwzmgdEZrJ3VDuLoxGo4Vu4AZ/u76HXK/APmS0dBwAM5cNF2PwACOGZioohRoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602559; c=relaxed/simple;
	bh=NVNIqV50uygc043n3Gxpkr4+k62xhF8DTJJ3rHA/CWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfxBRzYkZsaB4BgMn4Xa4fNKtQbMmnSLhLlpQEhwFye4868GTwkhjWO4mRNA1+HHYrDFGv0tcbEiwJjmqH42qXj9DMapcvdQKB9T8DIC0F/mIQNwTZNICtk+x9AM04IjnDnkOi8XgrVt5wG4LOI2bg6SmqcJu6tmRo+mES5hxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EUpSwwUQ; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwIEr4GElLK2Aj8UQI4rYmS7pJEcCJ30x7Bawkf81/BVG889rhtngOeXcIF8/RxQQfVzrpuGVtHy2EqZ91HEDHb4WGF1NGQJfWjlVoEvrCpTZJTr5CvecByiLY0E4ZO65R8MDwm66F6PaZth9dFPSNpZPP/wZE0H9iNfo6BItJ7rt2KdJ9VqX+YBTfO3hTiE6FGB3iN8Qp3gODWr7kQX+AYP0sTaQRe2bLFbdjaQW4FcweueFW7zcbWbqOA8/lFKKxTQcCPHujHf05MaqFZP/j9xX4q/6UBZbdvJsCiMiw+/Ide56pQS3/AfNsrSEt7F2Rh3yl0orsyQqFSjasoPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c08pqRDkXJMxpn/9C3KE2O3n8VdY/4w6uJJUL75Z4w=;
 b=HRx5PImY8ZfdFkL+q9gX8GGkWRscMFH6M2ahvLJwvABNN4PXa7VQeGsge2iAbuAIdZc2LafgxCkbkVopYgesInr993XKb23/6L3YBpDrht0bglJrIWfm4HxcFJgDy1brplrnp2o17hwa7QtqAkB2zBcQ06N87Errpllcs5SBSffO2HmZtzSvhpkxhGwSdn6R8Stoioog7HOco7G9mj0biptjoxHdLluCi9G2T3c7xAgRPAnBBrejynO1bZX4uazMmJzfKW2YNwzZlOXbEjgiCfHb3+EAkfd8JefQ6cnLdVTOTlYA7THQkNVPQfEm6H6Io1E40F26FY4WvxA2IfN/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c08pqRDkXJMxpn/9C3KE2O3n8VdY/4w6uJJUL75Z4w=;
 b=EUpSwwUQwxPzv97q2FKVR3/3LsOIR3Zq58pFjXqTZWEMY8yFsog0wf6kBBPLIpHfq6z0JQMNtHq64dIe3yMhzltMi9WjD7BnswZINrRbbStOJS8hDjTFfx2/zFU+ljg+OQNx6+H8c54WUN4IbDaoyvQh6EdONg9jwb98+3MeZ5q3mEMJJUcF6XxWzOq6Jw0T8hBr10HiteI0AYiEwxXd8EK3Kq4xAUp0EQp9xza3z8Hct/LfitD/RNr761JnbXAty/FG9vsqbngI7mdb1G8Q8uL0mpPAI56v9ojLXTzZ6AyekHYU68kCn8VMkRbp50B2iYab35S5saHJ9fBLKGC+Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 15:49:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 15:49:14 +0000
Date: Wed, 5 Jun 2024 12:49:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
Message-ID: <20240605154913.GV19897@nvidia.com>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <1cd4f08f-b0e2-46f0-a916-9f32b4bfc90a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd4f08f-b0e2-46f0-a916-9f32b4bfc90a@intel.com>
X-ClientProxiedBy: BLAPR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:208:32f::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6e3c0d-100d-4a2a-bfb9-08dc85770cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ai5C0ID76EiaHtXLBjYwwLUamDO4WG+dRbW7kSe8qm1NiVFapQvct7vvEjf?=
 =?us-ascii?Q?Xhn//zlbCyT0GhhlzfFt60yzb0pwI6vDX+Itsg36mXAL3cxmgx8jHugUqK2q?=
 =?us-ascii?Q?U8We8Hk0QleW0+PqXxwIXEe3/dSEkZTg/UAyMy46Vv6pkMXZSUL7X0tdCjUE?=
 =?us-ascii?Q?01qDgngc05pEjHa6Qdur16GdhBTcxbw33HMyMHG4hoCBXO/61EVGh4TwDqqR?=
 =?us-ascii?Q?TW2zS68FXbH8aJzGvkm967JGkc5zkC0x6jkCI/zItvscfYRvU82HfLZAk7GC?=
 =?us-ascii?Q?XtKd7MFh+Xh5UICqj6H4Y731q3nO9HnYedwpZ7TJ/hvy6YPrRyecmrOmln5h?=
 =?us-ascii?Q?kiMr/aAwJ53ert7812jr/CHjL85Eh30i+ky9HmP8b6UKzLFN2gpM/o077ui6?=
 =?us-ascii?Q?jRq1G60Xv/tWAIUc/GlHoAMoMOaXN25mSAdpDKeIjduuvyQS+gwBRcH/wEBn?=
 =?us-ascii?Q?PfcJFMPra8f4m/zYSmQ9PLw5hfquv0OlVq/ON6VxCFbm07bjddEfucPrefe8?=
 =?us-ascii?Q?uKW82RzDOJNHTy7oNfEva99MXXuQee1qhlj+CTSx8g8Lz7Cu/IvXURe4I2o5?=
 =?us-ascii?Q?FOQOVTWOXuAKfrGsAFrycAppQWtC/ktrIFb2gJ+ePQFCT/lha/IHpXfKIDwE?=
 =?us-ascii?Q?bm6+EdLQJ62Jrn1Z9Gl+NWeDF4W38LgakkHS/cZyFK+S055cIh7GOhOeHlG9?=
 =?us-ascii?Q?UL7JlEdf/RnS53x/jMpkjdRGx/Vnh9ApkSMfk4PwFrBGdEtctSGo7AGYZEQO?=
 =?us-ascii?Q?X3XvEfZvP4TA8tHo9tjWOHU8t8T321bWCN/AQli9cApjsJHxzdR02W/nouGd?=
 =?us-ascii?Q?gJFTbMlFYAMBQW8BB7MSuW733DjygcseDRFYE+ioCwToL5QTeF4b/4Cilvx1?=
 =?us-ascii?Q?Bcj1dNEk0I8Bzbak/aKH8Ervi6MztBuiwBKlVnC5Cups+zqWmAHxmrpkS1le?=
 =?us-ascii?Q?3IJq+M81TCtCF2yG6o3MV1OPkDeDarmNmIvgSvAVrDDv+/5Kmk/SbJdEVj6E?=
 =?us-ascii?Q?+WNmYgKWE+DR2UdsB0XZ7RHChnc5rQA4wL37kDQRlFmGbvIgpzryRP8tWkQa?=
 =?us-ascii?Q?y4xBKgDEtkKHOm+e72jLCwekHd6L91/P6EtpAXzvwEozaGuPqR4G/L+dcVFS?=
 =?us-ascii?Q?xlZS7KKWbgvMDSnj66TqQ+kgz+D418qsvfLI9RYBGEP+NkLviCLJkchs+Pqo?=
 =?us-ascii?Q?jA/SDuUpxUMfIRzWFv+3dgEYpgTJgZwyCUrarvjAglixNGau1i6lVnpkIeUJ?=
 =?us-ascii?Q?lEiT/ldRe46QnV4nM49EpbOLhLWc0KW2kC+z7DcXew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/JIy5IWdo5t8VapD/wgNOaN+LgCDq5kMDqO7zCyvbu5hDhHEE9D4UIfFJ33?=
 =?us-ascii?Q?wn0+cYYGzdi1MMgTKh/iV7DOreKmnXAEg/dXMkL2iwHLsiLuChR4FH4XQmDM?=
 =?us-ascii?Q?Cz1zCAL5RX3y8NllBkx+vlNh1PIk1sYpqEsoXY8SQoKzjYGSwALqVLDATC2k?=
 =?us-ascii?Q?BxjL03jeQY5fr1xEE63DLlo/Lys2Qvc3AnSTsDMpKLSsOGapOpdhA21MY1hI?=
 =?us-ascii?Q?nt9P0yiGA4+m+q32txmkv85GMtwjHowF6dSNKIq1G0BIeUS72KOEbfof/Ehj?=
 =?us-ascii?Q?QepPv0AKWb/2E2CS0AY8RpTFIBBFkCOx3dJeq+yPdM3chNRLVGmJyh8d26eT?=
 =?us-ascii?Q?gW67aZKGtokpjAO6eG9x6txx0wv2/xZtn4v/dst3TZDBCT4bZD0rxKzlnRjb?=
 =?us-ascii?Q?GSBySsAoChA/9+HsRFyMZ38N+w5U9JGpE/JpkC06Wy00349hhfX4a4lXBYh7?=
 =?us-ascii?Q?WK57fRGihUgcYuGhta+8NGgrTe2RRzcQTz7nto2ODtkw0/Hp2yVqIf/7POFi?=
 =?us-ascii?Q?BsMBFchqyEu1gruFI1Z514o5vTTWKxHPdzcwhrNxRUQnfEAuTRYWw2j45SG0?=
 =?us-ascii?Q?WoG4zbW21SBUCWNhTx1w6+QbQo4IZGliljoON96dhkSeAd78JWCI3/wrkdqm?=
 =?us-ascii?Q?aoUMj8WxboqIKA9TYT+sWlO9012/92BqYpZzuYDDoCkt7dNhucaifuFYh1BK?=
 =?us-ascii?Q?Wnh2e1QF2twQfKh/1gENzn8N+B/p+xnyiVvoA9GKvKeMDYLoHFUnD4lYeJM4?=
 =?us-ascii?Q?1r2mOCIIf2GhgpDHV1arrFnbodG6hOI9QxLkbDUXMPi68NUr9l4QMjFEvlBl?=
 =?us-ascii?Q?w96tHk7nFF2tU3dEAC4ko9x6Dw69G920I99FtQYUu4AeVch1dgXUZA7yMsjL?=
 =?us-ascii?Q?j6X9P2Z/N28xBM7D5LIQDYLPIfc4CNYn05Y1en/vXYjpqqO3e0RY267T0FbL?=
 =?us-ascii?Q?6FREDFSWsGHd6FA4tZ4V3Oyv/wwvsL443NGIPMFAvHttot2p/vy3fFB0IAqQ?=
 =?us-ascii?Q?wCGZNjW0z2n+Qy1cZ9SifYd+XabI9ir7pKSax9St4DcslHESRNXC+kJMZPKs?=
 =?us-ascii?Q?s6JqtxbkrjId4Q/DmTJEGlnf1m7dU2PGpdW9x+5CGh0uVgTYM1RbCeh2pkS/?=
 =?us-ascii?Q?WL7m4+6znq1x6lEOy6X7NAq2HxsxGqkUSeeCcg/MtgC/17+snLdNFmMVYzli?=
 =?us-ascii?Q?q7KY35YntfbSYuUoxBoMiDwOKH8xneJc3KZH6fZPHH46tvxQ1dav8Zk+CTti?=
 =?us-ascii?Q?TbkmocwT1mdVVLKbg4/HHSKKgVDZmd8UN9XLtxgf3gcozgnQc7rM1l6OVQR5?=
 =?us-ascii?Q?980gtYD/AfSa2auIbaTO6fn5GrKOyHcx5EEfu0nqpOx7zUnL6guRVD2fXMGg?=
 =?us-ascii?Q?jLegUroE+ky6FB4QPVs/wYB3HQqnBHJmzzLvEjTxYACER2gp++GZ4jpcBc3V?=
 =?us-ascii?Q?at3vYzVhiUzFZTqFYfoLyg6DibOJtqNSHHCz4fL5lYZmabdiZL67jvGgdb5m?=
 =?us-ascii?Q?VByLBWdYrlsBs/wbhjD4xyyYWuD3pC3/G5IBCWmU1JhqNbNDx8krpz0qjGBS?=
 =?us-ascii?Q?XrgLH4dxszk3R2rpaaJrtrevPTfQFIHfuU1d/9LQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6e3c0d-100d-4a2a-bfb9-08dc85770cba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:49:14.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0K1ChmyZxmc2Oy7f2UcW2e+178sq/esK8UUqDrO8XeC1ueTZHofEmzgWajeqci1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

On Wed, Jun 05, 2024 at 05:42:51PM +0200, Przemek Kitszel wrote:
> On 6/3/24 17:53, Jason Gunthorpe wrote:
> > Each file descriptor gets a chunk of per-FD driver specific context that
> > allows the driver to attach a device specific struct to. The core code
> > takes care of the memory lifetime for this structure.
> > 
> > The ioctl dispatch and design is based on what was built for iommufd. The
> > ioctls have a struct which has a combined in/out behavior with a typical
> > 'zero pad' scheme for future extension and backwards compatibility.
> 
> I would go one step further and introduce a new syscall, that would
> smooth out typical problems of ioctl, and base it on some TLV scheme
> (similar to netlink, in some kind a way smaller brother of protobuf).
> Perhaps with the name more broad than fw-knob-tuning.

We did a TLV scheme like netlink for RDMA. It is very complex and
frankly I think it is overkill for what this wants to do. It suited
RDMA because the system call interface is so vast there.

If the kernel had a general TLV path as an alternative to ioctl it
could be very interesting. I thought about generalizing the RDMA stuff
once, and even gave a small talk at LPC on some of the ideas, but
didn't have the bravery or justification to actually try to do it.

> Then I would go two steps back and a driver layer to interpert those
> syscalls to have at least some sort of openness.

I don't envision having thick drivers marshaling and unmarshaling FW
messages to obfuscate the data flow. The purpose here is what it says
on the label, to be a thin and simple path to sends native commands
with a security apparatus.

Jason

