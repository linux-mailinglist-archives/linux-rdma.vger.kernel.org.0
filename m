Return-Path: <linux-rdma+bounces-4163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC37944CE2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 15:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C61F22120
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BC1A2550;
	Thu,  1 Aug 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jWYchavX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251A1A08D1;
	Thu,  1 Aug 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517874; cv=fail; b=AnPH4w4JbyndhLKJf3Sg+cTU6McpMv0fhb9G3vsV4uHSVoHGwd3wCuL0kZVKZVPn11jxnM/nFngEEGEMQlackAyP0u5rhWpQhLjBdJ0tyGGs/2GtJqrx1FhWud5OL+4MUHwhnVIRlwrtg2cIKn4dWQJ67UAkL/7Lb7D+fxy5JpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517874; c=relaxed/simple;
	bh=xv4CsCW3H53eJN2jd/WI4dFucy7e7UYN0hndZrrJ4yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wc/kN1OF8Wi2VeCtBChmaAeQpmbE1FmNNGBmQjLyBUekag0At68KQVgW+SmwxXN2JkybN5zI+9G2b/ziyEp12M9u6D6PPAVDrXzPg/dDR3LB5wf0Iz/rR/LJBacKxCOYACkrimit3DqJClMAKOTOqbUrqnGF7BPyD7MjAK9VEwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jWYchavX; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0px5a/zxgn+PHuBUQmd960RICEvziJDKNjIdxp/N8YCsWt0sXlwNRgdsjgzl+SKzRiCldBZQ261BqotgPK/VOWkebP8nZk9D92TMVEzXTiBL3/X+vqwgbbfBardarV2Dr83nID8HTRS9azfJCmeRt4F9G6u/rm2PMlmhHwZ0fe754bAG1969RG1JetRWmIkRXGhyZZBEZ3EDdNnTwOhzwJw7BZsx2UjYgkwZ4reOtCmPQCqmsj/AKEg6UA12+5fRZkUDMMPIdJo2OqzFL8VM2uFwf+ckoUnhIKVgMHdQ4OfqQsXOqcba227DKBVzpd+SuiQGWRse7F8hT0XviM/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylhcffmuaoyQL2d1ho7RmIlF5LXzfsXM67PrmtXWCfk=;
 b=dPUCIijWVLKMFUmGBO/MjOFu6ml+W5jxKmu/3RbvlZD/MCwTHhjd4jVPW4adw0XUspGiFVinF2z/WSTuJmSyWbUpekNLqqJ3shXDpD7oSRcQmlZdjBmLlDxuzB9y25wsEb9vClMW0sdzRNQwWbJztMa4agh1unUi+FeI91f7+X5LFvy6Bx7ru4uhTblhFyqFykK85H8fd+qJSh3XU7hFjRHHWzuAFwDIW8MfSrgbesZRs7RxA+5hjeYxv+YTgjOBPAor88l2UidXbgszw/sqS1AVj1kr0xsU/yCDKlXnwJHJx32n3AgASzunEnwLA5cKW3eQ+ldm+MT9LMY/GmNfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylhcffmuaoyQL2d1ho7RmIlF5LXzfsXM67PrmtXWCfk=;
 b=jWYchavXnCJ4ZgXzaxb4j8HYcu/862AypFThUoGhVeRuSir3q9XjRikxR7/Thca3g8mQEaZy1P4ner4i09lyrZX0RyszPD7xRdowhOnzTJrBkBkF5tZYhymtHtl3RZj3ryGJrXCKGHYwkMRy/8/t75+osnloKbp5kwGqymtWByaiwHp+CMH1SltWH0sLVf2dA6GHQ5yR8RIMdzEPP3cupyKCWBAS6gC8tTNWA9LHEkg+KJ2ittqrMUy2ptNddbJkL/6ir9W4jHTmZSUwVbCWV1gaYX6KotYE57oSnfraXl4gdfdnQHiKyQa+DMcG3YJiHEmyedGchxeHonjDDnl2Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 13:11:07 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 13:11:07 +0000
Date: Thu, 1 Aug 2024 10:11:06 -0300
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
Subject: Re: [PATCH v2 3/8] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240801131106.GC2809814@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726161503.00001c85@Huawei.com>
 <20240729163513.GD3625856@nvidia.com>
 <20240730183441.00004672@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730183441.00004672@Huawei.com>
X-ClientProxiedBy: BLAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:335::13) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a878e-8635-4540-96f4-08dcb22b67ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hZrZbpONst5R4TOmeuAm+VKIk15snDyr0HzJX5/EbOn6q6+7djv19QKGtK5Q?=
 =?us-ascii?Q?E13tAbqVN23+1wZN5drlimOPXOLEEds2MhdsLSOLycJerhBWHY2gzoBfO7cb?=
 =?us-ascii?Q?mdyNHB9JNHrhcftGY9hbZLh0swoWd8byAW0ir9/9KXZGC0f2xI1mrj3cvTBW?=
 =?us-ascii?Q?dAy0IIyB4QsOGPIeXd+28R28EADzsrBtQGkXaa4LEvGewCWrctavY7YRjmcE?=
 =?us-ascii?Q?l2o3kvW7OTcfnH7Y2tV2qBV134R7DoRLvYroHAFqtDNcoNfwd4IXTFNXcn7l?=
 =?us-ascii?Q?jMdtuo65TwGttoopAH+lpzQ7uSmEXr/O0CKk93Q7rxmlWpQfqAbt9iOZZwau?=
 =?us-ascii?Q?DhScA+V8c4EFO4LFe1nKu/mG/+VImQoTT22pI1Is5w5OL9mgmUEIhlTkzauw?=
 =?us-ascii?Q?zb6ty/egZx0YtOt2FdtNSbGwmsfimE1NYlwlG4A5auMzTZ37pWir8aFdcV8U?=
 =?us-ascii?Q?z1TL0e6wvgR0vd0YKWWWb1obmAkMoN6DuqUh2B1TBWAyNiGCVrQVGuzz+cLk?=
 =?us-ascii?Q?eTXq6A9zql4UwK9ZRgT+B+H7fLBkPS1CnVXF5igz6xp1J3D8Ni7KzIJXBmko?=
 =?us-ascii?Q?cAv152NbkIKAD/Kh66nAkaswbLXT2D+Cyq/JCC0tVXUvLsuhpytWvBVe1GFi?=
 =?us-ascii?Q?V7es5GZs6VOguc+1k5gDE1JHyK2yuRxXnOp4rFGm/CyzHZGeR0qyvYKdMowS?=
 =?us-ascii?Q?mS3uIBhKhGlVkZJJLSK7Smc9UzGkBZpsK6uGL+6+KeVinEoshQtIJS7LRHOH?=
 =?us-ascii?Q?AARgtsEKei3JsENtMLlnyWPP8z09jBb+lo50vS71I3CypVqLr6CTSdpGZwun?=
 =?us-ascii?Q?XqIAPHkzn8ejjIlAX83cOIPwKi1nhzc3l5Lww6OhiQV1jgIqGhDX33pQwwrA?=
 =?us-ascii?Q?L45E6hxQjKZAAdz1msK3GS7TwITC7bow6gedlR/nO5n+8GWq0QDUB+/L5OXO?=
 =?us-ascii?Q?ex8NHRcQvZRtdwUfVacStADeTf8iiRU7XWnqh0BRaE1uSNaQ89pNkiAtPesO?=
 =?us-ascii?Q?e2u9Jg/62jCo3CSVhFUgLBaHVaRj7h5eMolONrpbvXsL+RTLAQsc5uiBpmtI?=
 =?us-ascii?Q?+ALjV39Kl0C8pVT0hGX+nc5IhAbzfjTWz5xNj8KDaQ5QmHofF21wRuuizcJo?=
 =?us-ascii?Q?2qdAwGzNMD1qN44SoJz8hwKUBvyeKHicw9Y7KHgh4drbAMwHGExTH56PSt8R?=
 =?us-ascii?Q?NXtcUZe/zQfCvmZhyeRrfo5i9q8hztr4d94DuYaKf8wE5/t9BV93gRxE5sRO?=
 =?us-ascii?Q?3FaoFMhcugIopxSJNEizDVQmrm1VFMkqmG+smkv04nb8LaYATaf8+gCuoQxZ?=
 =?us-ascii?Q?kjlqhee7kMQiREC7hUSIl/zIU5Sn5HWx8spghyo6eq3SPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jhcV75NQPhM4uKZTijDUjQqDk4FFnaZUy/xPXupavpg+dXdE4vBoJKE/IUnx?=
 =?us-ascii?Q?nBxX8HP4N9H55bejxI3lAnQ/7k6lsEOD/o9/fyZc+qRcCHGijJqf3BuEilcl?=
 =?us-ascii?Q?waBB0en5padph9UND0LrUHAEjxiU0Ha9J+tuIOsBcNCmImOymJ8LDTJ0E9M0?=
 =?us-ascii?Q?cfps9GjwOBUaMZZ5wPXqhND1h53NuVJhoRSAOWZ7+45PbuN3ZHNrwZbKwjjw?=
 =?us-ascii?Q?6M8I3yhOCVbiVNVz+MA04rv/WQoixfgvuYIjgx0lrkyrgO1QBVzV48TjEJJn?=
 =?us-ascii?Q?ntDxhKxi000DmXk+8a08iV2OxzZ1WHpbv6HEpejz8MCSFsGPugQF1DnuAsHi?=
 =?us-ascii?Q?UNsiR5MdwDWQZuCYuM1N0UgEjN5HyP2ytiQsAIW29RB+vbBdrUeQUyIj87wU?=
 =?us-ascii?Q?nhMlJ3OGbMqFwdEc7+IomW1QdhhX+Ox51jwYFtzMb4ATrKuMzTTcelPH1oWC?=
 =?us-ascii?Q?Q7muLfGX47kWID6c5veNI7n+dr7OGnMCmM/VwJfeSrDFB5Uh1ZQrogAgQ5sT?=
 =?us-ascii?Q?oAWonuDSaeQza8Kj9IA71pmMUl+Af1ww1GEP8LG4xywmTVwjdsIgOuRlvpBm?=
 =?us-ascii?Q?0hWY04RRDY4Yo+jUmHNxM5F4VmGUNfeNizQELvx8wKdqz7+63VXOYip9dWKy?=
 =?us-ascii?Q?aWUrK+TCQ3OcXBBEV9sj0JccXTac8P71QlRwOL4+DCc5vhi1aiKlRo8Qu4LS?=
 =?us-ascii?Q?8LEHF9d9MRnSSxH2BoEaTK/jsd7Z9JENvqxZ6Y4fDPBTXETAeb/2YZqzmFQj?=
 =?us-ascii?Q?kdwLubST84xAPLwZhzUrvHPpI8QVxvDeV1GK7g6MAI8+4jlDOxwQJpKhjm/u?=
 =?us-ascii?Q?TbqLRD3oZMAqNtsoSPEjQjWCmnwGkVqPtxZ4C88jq/rRScgKZ71KOnX+NO0f?=
 =?us-ascii?Q?diJ4nRsUHmajHFMPCMliPQmsywK7m8RC4L9hwryK0d0YKUB3xp+gRuCOfjQs?=
 =?us-ascii?Q?HwFIFHbyEIIPR7H8J10xQnEqLhUcS15oqmY6QyQ/Ka1J+g4HEItYblvMdkJi?=
 =?us-ascii?Q?z0IkSMfABftLS7W8rYnEYJRVdawBbUcjchIzQa2UY9CVRcGONMOA0V0FF99l?=
 =?us-ascii?Q?lCA24PNoKZbzPyKP2RJT1PMzJE9Xd9WNfjzs9MR/Kl7HYHBiwYJ3hycLNpaY?=
 =?us-ascii?Q?kwSQiYeV7pwCP57lfmM3qaELcNy6qLryrPDHJj6ugJDeDuTKIEhdfTYOq381?=
 =?us-ascii?Q?/0ga9Qfy/xMSqvWuYQ1hziKWNTd6o+yoep7/D8ldlr2E/HJqFFo9fKBg+2q5?=
 =?us-ascii?Q?rICfghhfbL+p2Qv5UEv2igqTFIeHso3wKNeEYfOyPWHtY3UEDSZY/LlfW4qM?=
 =?us-ascii?Q?vVTKYNm/IiMB7YQItv80zmjXPVpFz/8lIj/lsHytMg8HBLkcyDLj+89Q15B1?=
 =?us-ascii?Q?Nu/BlKq3LUBnLzeRMGSXcl6G9cD28pexT3YwsDjx6dLsjTj8m10H20OwWXRK?=
 =?us-ascii?Q?4boctITdr9z4Sd+QebQ66g5PGWpdlb588hFWtzpV0sRxBmVymK7aLglFDKN2?=
 =?us-ascii?Q?DpbYj87BpUaY2IxNpQsDIoa3f4rm7jggihCCZvE5RGvon02LjNcfLAjrzZhB?=
 =?us-ascii?Q?nKa1U3EZccZ6D/RtuDaPqYhdWZ8RYFuJFjdLPXmH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a878e-8635-4540-96f4-08dcb22b67ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 13:11:07.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k/cjj+gEnIKWfGyWT+mQNi/ZgyCGUlD4eIHSqWWfbRwRgaUqPz9Qg8zpfNixnQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

On Tue, Jul 30, 2024 at 06:34:41PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Jul 2024 13:35:13 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Jul 26, 2024 at 04:15:03PM +0100, Jonathan Cameron wrote:
> > > On Mon, 24 Jun 2024 19:47:27 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >   
> > > > Userspace will need to know some details about the fwctl interface being
> > > > used to locate the correct userspace code to communicate with the
> > > > kernel. Provide a simple device_type enum indicating what the kernel
> > > > driver is.  
> > > 
> > > As below - maybe consider a UUID?
> > > Would let you decouple allocating those with upstreaming drivers.
> > > We'll just get annoying races on the enum otherwise as multiple
> > > drivers get upstreamed that use this.  
> > 
> > I view the coupling as a feature - controlling uABI number assignment
> > is one of the subtle motivations the kernel community has typically
> > used to encourage upstream participation.
> 
> Hmm. I'm not sure it's worth the possible pain if this becomes
> popular.  Maybe you'll have to run a reservation hotline.

As long as there is one tree things get sorted. We'd need a big scale
of new drivers for this to be a practical problem. Big incentive for
people to get their stuff merged before shipping it. :)

> > > > + * @device_data_len: On input the length of the out_device_data memory. On
> > > > + *	output the size of the kernel's device_data which may be larger or
> > > > + *	smaller than the input. Maybe 0 on input.
> > > > + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> > > > + *	fill the entire memory, zeroing as required.  
> > > 
> > > Why do we need device in names of these two?  
> > 
> > I'm not sure I understand this question?
> > 
> > out_device_type returns the "name"
> > 
> > out_device_data returns a struct of data, the layout of the struct is
> > defined by out_device_type
> 
> What is device in this case?  fwctl struct device, hardware device, something else?

Oh, I see what you are asking..

fwctl is split into a common ABI and a "device" ABI which varies
depending on the fwctl driver. So The labeling was to put "device" in
front of those things that vary.

Basically if you touch a "device" field you need a userspace driver
that understands that device.

Not sure it is worth to have an explicit naming, it is sort of a
RDMAism creeping in where we called this concept "driver_data"

Jason

