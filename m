Return-Path: <linux-rdma+bounces-4077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046793FA54
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF55B224F6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983A15A86D;
	Mon, 29 Jul 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iYYfdkiT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A6548E0;
	Mon, 29 Jul 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269487; cv=fail; b=D02S0njdMfzCh06aQGeDrDTNr5z184XI3oh5BzEQj3V1qGG94hyGS+/kdNK5R35CGE0pxnPMEF+PWzH8yoeTLLD3c2gdnTgdbF6n5Q2ZAGD5hrlIXhuGF95ghE88mav8vwS2S9gkGMn6kKSth3F+EBV2CDH4hpH3xX7ZvPBjmYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269487; c=relaxed/simple;
	bh=Qin/OhvGnDkgez6Qxe2nC6XxEX5kyr04hUfRvCZv5rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KN+P95uhglLzBOXOfR5/Qoa8FvautM95i8PBZian7LqJyzOwx1NE2WYuPfgzk/kuJI6L+ugnZIAYLZ3FTFth5dBlziuJ0GVCbVSGCvWsHrEWw8LzgJJsI303hqg/vYYekiGLjSEYq6G7QGVXi/bx6XHQti1ErNY+vfHtvTFuGUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iYYfdkiT; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNl0cf/OC6vflOJ56horodHi32MpZ+MDWv9hZiSpqqki9NUUBZc0BIKSjX9EFOlyZn1qfOHQZ5J+67HpHkVXkSTbDFWI04NazVQQBkkrO/5mT6Se2eBWAAtfstWY7fBOJrFYW62dogCwxQ8szWvuAQ7zTmQ4R3cvC+r1rhvGktFb6JzjqfQDrE7iHr/ZKCMCb/UHPqKygvMU8hWIz65HK948XuLgcuGEJjbMNGeDKaPlzIV47vdK4M+Ngk9JlNSCkzUo8ngFWEgu41RR9A4x8iLUDy4y/TNX/lriF7A0O+f45WlMKx7iOthBsx7LlKSbhcJUZMrWlZWmpEhUV0xhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL74L9JXZDAe/HRwcWJreBYBrjBxHMklb+3unTl0Fy0=;
 b=nDtgCJjPb8kM0xNQGX5QSfF1BX/Z1ZrHpqoOPp++j60o4qEK1hUHcmcxhZjppSKE6orQGlIaOwvNIsOiSYcJIUPjCzB9gplSKXed8n0K2rIs00pJAYMqHP991gBAfBxt4fT6O53zJUnuMa7RBAPVbG70pX6F8tKJ5prZBYAqNFW+rGEWCHVI5PgMGBr+hV+c4aGtVZX7YF81JLKGAWrT8iqYUA+Pxi5e5axgnAeFLSlALYjQB8ePZTNY3vQ5YkbS1Cy9mWgaFQiglVU0mGv3uF4CI9jskxTbgP9XvjE1fIk1gla4ORHYYtA0iq+XMZmmpHzYa5Zihk9GOlwEOVck+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL74L9JXZDAe/HRwcWJreBYBrjBxHMklb+3unTl0Fy0=;
 b=iYYfdkiTyWy9fUKOfAY1hvDwTrR+aritZpVj0/JiR3DU3qzop5f8XDqvhRAUM6nxoFkt7cIMq6bIFb4jTdXg5AOVKZEI0OjeOG69xaxISLkSgGuZAvhbS1x1VRmhR4v2AjoyuaW2p3IYKkOOs1pdv1nsgal6pFRD95+B9TNTmazFWsBJ/F+qYT/1qECl7C18JQ/KesyX8+PFWGoNWo9mFG5gVOY+o17lePDxwJyM7Es7MakWJBMSu/9FUvugO+oOWBQh4UFrgvW5xqDsbZyqK9tICpNMGbfgwgDVpDft4T5vUsToydANF4bo6m74FIPOz2Y3KY34g7ZiT64Kv7wEOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 16:11:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:11:22 +0000
Date: Mon, 29 Jul 2024 13:11:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
Message-ID: <20240729161121.GA3625856@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726165021.000002d6@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726165021.000002d6@Huawei.com>
X-ClientProxiedBy: BLAPR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:208:32a::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c3cb6d-618e-44f3-4fd2-08dcafe916dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGxmWalLfEx3uAxuT+5QtblH+uJ9jgm5aEHuHEnss/og3KJZUIkOm9phlq67?=
 =?us-ascii?Q?BiVi1+6/M7bmQTe3KcOCHhvS0hzEwzSxetvH+V2gEFxem+CtCWEpkmGqrubA?=
 =?us-ascii?Q?ftauYaf94qhxS2cmMASqkjfUfcTsbN0zKW1EL71xKUywaxhVEkkBwY1gYMKT?=
 =?us-ascii?Q?aOjzS5wuMxenWrwj8BiehPAqop59XkpfxUl+0zaXokQx2gUcEnRM3VRx1ret?=
 =?us-ascii?Q?9D4bgGsjeMQ3GpKmO5QhvGNMWqbnjFfulmc03IrY3xTgvu9/XIxzonq6JZhG?=
 =?us-ascii?Q?7dev7q1NDDaCm6VEC2WgBjr8NF2i3hUrfpgnahNp0YvAPBVjult9hgO+aKwP?=
 =?us-ascii?Q?oj8UlmbTIbPTANpjbi7XtPfUfO7mYJn6qO+7v+Tga8vSQEsngMQ/1AlKW2fp?=
 =?us-ascii?Q?MJeRgjF5rtHBgNcBj4cagEU0+qpkxXeGpzvJIihM2jcC2mdbQrDtHqyc+UJL?=
 =?us-ascii?Q?TPBvzcFvtnOJzPcC0d628RoVPlGNqD76uU4lLjxFTSWWIh+sLc5UnZLMUMHg?=
 =?us-ascii?Q?mG4eO61UJ8mxvpbvKTP+HfD9+QxRdva9nF6qxrAk3qKrWJTY4zyMLc+sBbXd?=
 =?us-ascii?Q?qTxcQn+pMtbvKBbBdlHr6j0NPEg8N/rRSCeN/M7n2is0xXoKBT31gtT1fADh?=
 =?us-ascii?Q?2gl2UQZ1I7qV6sx/RyztH2GxSiozcrbrafmmKblSPBd2lPLGC8WurUyGvnTF?=
 =?us-ascii?Q?aZ5e/+Wj1LZ2HdSJY1nyCObx2ZiO5KPpE3HU/USYNBj5LSPQUcke+CrY4dBC?=
 =?us-ascii?Q?dV5xZoCa3QRSyhg9QPuRS07t3Pk891p3FlvmDU6zm3n4+ZLV+rDckf1v9wxO?=
 =?us-ascii?Q?d04binlymiA0YcYEeyKne9idL4TdBT/tZlzV48yF7HQDrqJsd4Ej9Ixwr5eP?=
 =?us-ascii?Q?iRiGb30EB2+7bkrTyfU7CmHzrOtcT83WB75VzR5ZGa9U11qbCoiSp/xd7x+j?=
 =?us-ascii?Q?oybpLE6jjc/OzYxCPJiJEA/njNuXd+Zr/8IPl1jOjmvn/3LUzQO4x28DEGRO?=
 =?us-ascii?Q?rToOiYB7fVG/FEU+GntmAlMZJgxqiSF7DA2k7U643cW8VsS+Kp1sZMSuSixj?=
 =?us-ascii?Q?JDHIu515yr5LkjvhfbikBmcDDct7LibvBjlBkhaMmNyIesNkny4uevj1yvB+?=
 =?us-ascii?Q?ArB701IYfrOLRhUx5MZ0TLSZeOkpol6swCjWB181HHpwbLE9w/oj149/OQ9E?=
 =?us-ascii?Q?EVQ6/LyvxTVZH8hJv7KbFCaJvE59EprADMShUGK9TIeP6hYhg0BHMZO7mtzi?=
 =?us-ascii?Q?XBdyjrAUKzTqkGFv9Z7Lh5F3Bgrtk1UFu4FdFHzAgDYsNWBikStnMRMWjahm?=
 =?us-ascii?Q?ZUX44nbDLgade8v2PGl5+urPp56OzPKRBzs8qwStEr8tEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jdka3ZAXtiw9cIFzcBsLQPN+5I9ilf3UGvAK/WtittwZvRR+ggkl0VvG2yaS?=
 =?us-ascii?Q?pT2SaP47WXDoc+bNSyCVEySWfSDBhm/cOHjGUSZ44pfVJH+smgulAt/mU5U5?=
 =?us-ascii?Q?qDstozqr3kA/ay5DLPoV9x37mdRxogFicV1s5YbQvkzTWJwqmopQ+y05Ln2w?=
 =?us-ascii?Q?rtbbcS0LdxQEOPWSLbA5qZthjTw7wyw+jyE1c25p0upjQHmA4/q4SRxOYfEH?=
 =?us-ascii?Q?WkNCYcpP3TNKwCd+f4HA9M0BqugJIyU6K6zYMQ8PStldu+7Hm+6YNiRIZEvl?=
 =?us-ascii?Q?OLBzVJrZ2ETBfFTwxUJsH2ZVX2ouQtBIuVyzWMl+fOi4WPRCiadmNawGNG4q?=
 =?us-ascii?Q?vDeZTjBNZW8gp6KlBWogJvmnlNjjtYfcht+3UVE1J87GHC8AACNuoI7qYfST?=
 =?us-ascii?Q?IW4KtgFMA5vYNPCMshCktbojQtzJ3yyzSB99tK4rofGigR22huOODkcuQRYK?=
 =?us-ascii?Q?imQaDx8ax2aKa2p37T1fUyGaq0cbGgsncTLs4PlHZ7N/bkmSZVi6HpgYH/eG?=
 =?us-ascii?Q?FDayayIRilM1v8kdf0ENxoyhdx+8AKXhOyDvWzvVGEHc2s1tLes/3zER0gAU?=
 =?us-ascii?Q?XVYDYZN1U5Ul8fq2spInsUAXbanrBp/KA38DCImZkGzdQ9FG83x/2+UkiFp/?=
 =?us-ascii?Q?jVsvVnFhfhVu8ylOHBXsH1j1Ljzc9ICill0y9JY+W9S3oI18Z/5FwotOAAQj?=
 =?us-ascii?Q?5CWYYLaTiR4D3RGW9LmPZ3TdCrVXv0a15dZ8VZw64+Srw/62M0yL5senANNi?=
 =?us-ascii?Q?CLULf45a1iAZGlitOIzrVJVDy6BnVWyolNpyY5u9EYhPWs7cNHHV1e3cpVKS?=
 =?us-ascii?Q?pxAtIB7eDEnB1Npj/Y+pSybSjHfPU4zbAkZLGpfGgo+ceBHj2MzAHtYpt101?=
 =?us-ascii?Q?XbLej7u7MiMqVGEblMSXRAlOf9UI9gUeQoy6A4HgSU3VDI417j6iBSsHuD07?=
 =?us-ascii?Q?qpz7yOnJO6EgDLFvv072w4WEeE6z2l4HLD7WGl43p1U1ZgWoCMWq3PtHbEB1?=
 =?us-ascii?Q?mlHW8SmBQ97Sa3vtTSv+oBxmxZZccDdgqihNW20zwugc/EIgPL8LdwRF8YlL?=
 =?us-ascii?Q?/QF44CoJmbuSjZWIy4S+SFVMskmTXIehQuEC+S4u9UY6KNq36AzKxHvJFpU4?=
 =?us-ascii?Q?8xUxJ/tfvOsxaZ4818Ybwk/NuoqL+xIvCFKAShkOKGFQEyrRPElSPNjP2VJp?=
 =?us-ascii?Q?D9sRJUZS2yGjib231ZrUhny10kCmNK6qwp8JHi7L28To0FMNJooFCiqWdWMk?=
 =?us-ascii?Q?DOrySpNhP1yh4DxWOtOvDj5y/7ybOOkoqJDVAo/Ev8bdSLSv3YLjbjfhWNnP?=
 =?us-ascii?Q?YiLzn3apZ87Lwu5TxhqjopepwWIxau+vORueDHxgGOw3V+hHSUvEDV9AtUJe?=
 =?us-ascii?Q?xltme4nOtWFCzBBW+xmAde0aASd1ILS9laKb/gLt4bBPkYGaROkptV64OgsE?=
 =?us-ascii?Q?hU4Xju9Y4H56gZhYp3R3O1d1sPlkxnM1CBPIICXCYXdY3Gj5ndd/uH20TId+?=
 =?us-ascii?Q?pYhWQbUnaJf7myA+wd37p01HLNOvwSWxJBz12lKuS5ppXV9B4+UuVIdOtLLi?=
 =?us-ascii?Q?1amvgQNXBHaepeMYIjfGUS467MKY/wSKanOsnGOF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c3cb6d-618e-44f3-4fd2-08dcafe916dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:11:22.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kC72JAhTZph1hovUKNTG7qKgda41Yy6JfFWAb0mV/0BzFS8lNE8RNmW5DMtgDBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

On Fri, Jul 26, 2024 at 04:50:21PM +0100, Jonathan Cameron wrote:
> 
> > diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
> > new file mode 100644
> > index 00000000000000..ece2db2530502f
> > --- /dev/null
> > +++ b/Documentation/userspace-api/fwctl.rst
> > @@ -0,0 +1,269 @@
> 
> > +Overview
> > +========
> > +
> > +Modern devices contain extensive amounts of FW, and in many cases, are largely
> 
> FW and, in many cases, are

Yep, Randy noted it too

> > +software-defined pieces of hardware. The evolution of this approach is largely a
> > +reaction to Moore's Law where a chip tape out is now highly expensive, and the
> > +chip design is extremely large. Replacing fixed HW logic with a flexible and
> > +tightly coupled FW/HW combination is an effective risk mitigation against chip
> > +respin. Problems in the HW design can be counteracted in device FW. This is
> > +especially true for devices which present a stable and backwards compatible
> > +interface to the operating system driver (such as NVMe).
> 
> ...
> 
> The document lays out where this sits well.

Thanks!

Jason

