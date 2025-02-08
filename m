Return-Path: <linux-rdma+bounces-7576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908DAA2D27E
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 02:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C5016C458
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A57288DB;
	Sat,  8 Feb 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dpV1NkDg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95285F9DA;
	Sat,  8 Feb 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977066; cv=fail; b=Y9URiqzJbwRpybIMSmeV/5cf2hpMBR+DN3okYyiA01UOTC+7xio5Zk+6srL5XQZVNiB+UMhr7VH1y/cmr8DrICfzQlVJQWm49/n9hYRoB9HTBGTp1EblYQkWVhyBgv26B0kHNxvuyk56m/ntXv5JzWchoBtEnPFrA33DeDrJaaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977066; c=relaxed/simple;
	bh=ya9kK/yLCDvnJsxZ8B3V4cM+46rfqd6lYiPezRtkEV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPoJiddbJTYVNNKpiKh9uF3MDh4VhoMLT3aa2Bj1t0BbTfVqjMsyq2hQkywgb1Lh86q8HLzjLLtirJiJhHxvdITMY02OIci43gSvoe3yVHxJAMiDgX8FYCVnvsh89fLVuBwoYPGRPjwpqop5vu5RCt6xsYCDZZ4Dy9gH14CsBxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dpV1NkDg; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVODmu6fx3O/z7SlIGvS6QlAmSO9ozsTzEy8p4/WLq4k9//86uhXok7CLzIZRYZswbjG7LT35UHr8hXmLhhg1oVgVqWBcI7U/VORGCgALmjhyqQ9qvT9vQuUD4Is7zSa0Q6M2MfnbDiMVqKv+s7BMGb1GwAX7LMbIIH+NAO5ndI6PlTtSAlh4UmmJdpXu9BzGlIl5JO0JFqnI06lvBaer3HuBfARPhugmjilWCYs8Fg6a914+PJKKpSZuzWTjiW3JlWNdm38k29HmzEHttpH5cI7lh4N1GXke5+eJgYzr/+HHxOVFTRq7+qUvmbeH1kDUrnr6evy34M5l0H2R3orVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmfyXUjwphQxJHfzhq7x8hOd7X6crRDyoLQwUnMDj2g=;
 b=OxRlwEUMiiYivLsn4GrtXnblK3qI0+RqVOg5GBS7KJwTgr7mF8dB1GpEGBXLkDRkaAQ0DFaAxrJ6+MF+oG8eLc2451hRNjOSi1NQBfOMsgI9q/FOSU34uMFEw8OGJRazazMSdMDSpJvsrdKMRLd+/Ik16p16/SFjEoe+naZGkL5kLnVFF7RDlFi8wk+ddtFGkKAvbiXgHw4zK6JpGLGth3eZW//Nowfx37S9DlaO1QgxbO/RhR9hLF9YuLXKf+oCnuL5wkECwMTkUs97iFLw4GwBLLxzH77Os1mazpuccXSlOhs2ezB16xbWxmI496QvuDixz1Dn/1JRRvBakLU1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmfyXUjwphQxJHfzhq7x8hOd7X6crRDyoLQwUnMDj2g=;
 b=dpV1NkDgS3opiYXVJBcf3L0d0XPi5A8D2dZV/TlHtOOOXqqqWgRw/lzDEe+tX/KxCjQKY3iN8HyC3hXk3rQf1Z1gkNZv5u8bjadw9EVXym/Ou6dxEgzYhGQcVEJZYVKTjk/rS2jMiemjA5aDAadXHlGRpQQqVqzsj8RxgUx6yFNx8tUIvQniounR52TPFhCcHi/1CjnB4k6IiaYijxgl1V8/aM35GvNWz9kaLKPRBP4Aq7SHYnCNE68AyyaYAMRyQtG7yFX14lDjq/JVj6q+J1pk0zyQ4D7pdGSxF6qLXYk1bLtyItUQB9v3vg8cagdU8UBTZ9vXH5ONUBo4X1EL1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 01:11:02 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8422.009; Sat, 8 Feb 2025
 01:11:01 +0000
Date: Fri, 7 Feb 2025 17:10:59 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <Z6avI-tLNOecCT-4@x130>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207135111.6e4e10b9@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: af8c9f8c-df6b-4520-8ecd-08dd47dd73d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hTsWwO6q+AL7k3F51O4H6HXKl3fupwgB+hW7c0Kp6LDjEqQ/Vv2CDSGImbr?=
 =?us-ascii?Q?MKIEh3uIGrOOx5Rb7A2weTNitjpr+tqqHkDLPyEWcDHTXiNW3PoDT8e1bbQ2?=
 =?us-ascii?Q?ujYEa6fsgdXfqlLk/yQdDb3McYI2I496IK7jVe5mHZ5xcr5rQ6zipPD9YDHq?=
 =?us-ascii?Q?JPOYWiHqqLBruSpPFES/uFiuIj1vgXIoVVNkxkHgSOL+bq5UQTOI2bElXM/3?=
 =?us-ascii?Q?KxV+lB7KjFgzjypArFEnfrOvOgHmniPDAqmQEp5uJNMb/Nniu/ZXnRN8zN+G?=
 =?us-ascii?Q?+B46w23lAoU5C25TkbbF1vPOa/KQC3BlYad9aXycZ7WPcoO3TtxDB1HYGt76?=
 =?us-ascii?Q?UmiYye3veBtP1cYnlojYaRshdvrlbm0H2Am3zpVoer3mpAVPCMJnEZtNCoum?=
 =?us-ascii?Q?UjnxnnvHjK4m8HRFlwBehLa2qr/7Q9PiwODOKIdOoNlZHYgpwlzB/2AuuNYL?=
 =?us-ascii?Q?T1wrq8H3nlcPdUyvonhjgKYoEUgx5KEL2aa2fMa1ZMTPEYWX3pU17iw7ai6t?=
 =?us-ascii?Q?2kjdNFWV5bZdHqrJbDB5Dr43i8ULqJgTGo3YXv0CXW7+717J9wBfj9l1Y9Ea?=
 =?us-ascii?Q?+s7FGiD48ch9QUF1e5w3cizRi//9UcOijZRx3w9RCR8itzt6/HWy5rdE8wcP?=
 =?us-ascii?Q?H3DUh+Tm/mIWv+oKxFsg3Z7FrcrIKI4pnmr9zE6X2Rp5lzeKfUOPy7PsuJSe?=
 =?us-ascii?Q?VX/1Uq5n/dCbE0CvZLimVUvdTB45oTuvYnHaxnYwAIUL/h039oRoENOhY/qq?=
 =?us-ascii?Q?OHo+ySTSZSInOuKJ0ryRNE/J/R5mprsjszSAuAV2izK2o87dazf1XU7TrakN?=
 =?us-ascii?Q?Teo0Hi1N8ZFAn+KQLATyxU9axB6kZrdIGzT6iMXg0h7Rix4Ez33JlyxW6Ake?=
 =?us-ascii?Q?mfqvXdjJRRyr46n0RmUUTaDDFEkjmpLinW+satNOeoYPMH53kRJBtfmIDj9z?=
 =?us-ascii?Q?qUF+MPt2HVRrm1cVVDrE0GPj1y//Cj17q8Ueg/PJtKgt+BZHaYZRb1tf6uuy?=
 =?us-ascii?Q?pgT51oXCY3jgZmh5JAmIvjepTeWIFDeCgtRMsKbKCMk2wRLavtED81vH49vg?=
 =?us-ascii?Q?vSTeFNtDMM96+OTzdiy3znerjdMsq3xS69KZTuYIRu5z7PuC1evj/l0JLdI1?=
 =?us-ascii?Q?Plsan+oRwtFw1Ip32YrsciMdL9cLI4O1G+ewtaBMBY6HcfL8ntuMCDmbkKN9?=
 =?us-ascii?Q?hjuc0UZZvFK1N2xlm02tXOG9Sf4vcClWSXaEgPF63h5qGqrhsdym5p9hDaAn?=
 =?us-ascii?Q?BecQX3fmA/8XPXOxJ9mOHpLw0IOouwSInOVsgyWYwllmEa75B+pKkOjrV79W?=
 =?us-ascii?Q?hxmrWrf52T7KRwaOK8f4DuiiAbTbLHNYiaqiZasGwPhho0EwvX/eKuM70rWZ?=
 =?us-ascii?Q?glJf1o+3G2tLpOBeRvkgOCgtVrPr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZegFD8uZZS9PvaFbWoSF1ff3iN5udZY3ON9Pjocwggf8fL0dceFf/DTYuo1H?=
 =?us-ascii?Q?6uH8aCUGiLYrZmMyi/MzPDKbvqlOrVrsfec7OqiqZ0+uyWK3C2xSX4wCtdr7?=
 =?us-ascii?Q?qH/+jgEG5NKXmwTgqCkt7fgHGX/VdCveep1eafRnlq17ENf2PVXe7jAcEEvd?=
 =?us-ascii?Q?AdFJ65uN+KKZfZMfO8742K2GCoj7Tisfr7l+KnpjtcNyjs08YlVCyfz3s1Eo?=
 =?us-ascii?Q?e6Bt463j6RLeOT8GUy8Pst54qAk+lEoNXo0ZRfnc2J84XB5KLSfUxSHuLEop?=
 =?us-ascii?Q?mL69aoY+UcncEOiUG1E4/epW5+8eAqMLx2RHQJP0e8a1+yKhp74gZUtn/6mP?=
 =?us-ascii?Q?6Iu3BpetK+3lH8bkf3icR1S57YRPHF4hYofv3gfOVTG6TP2UlOpm5qmBNKjw?=
 =?us-ascii?Q?U91j042DbuiWzOKZU3J1ZF6eAlY1PyI/SC7nGyc21x1aPlb9kxXVbObQD/X9?=
 =?us-ascii?Q?51vUy/liDHSIISRi36lnkumx0vLXD17ov7GDwQ3ul6xmj9HSpd780oeZbkzv?=
 =?us-ascii?Q?FoyHmRsvVZ1QNSEN1A60Yk6pRs0mPnHEixfYwpNAE5Ni1hDvIVdee8hV05+Y?=
 =?us-ascii?Q?yZdLBNnp4U7KWwlJYdTmNXh0eKcGfY31kk3SyHY4cFKFLt6v1Cz+f/Nxt8hn?=
 =?us-ascii?Q?7pQpaaS2C6SMp9TxODjgtsj/v7O1DZpMGsYtQRRiu6MJlKtT5qY/WBU9Xol7?=
 =?us-ascii?Q?ffuBlu7Ar9JkyVa86NTxtR3F7xCU5JC562T5C8azm4/ZehHoze0zs2FqQWpr?=
 =?us-ascii?Q?PLOBgZAf1oZTV1t++pCbnbttxQW1RSa8sRG02gFM1X6HfVoRF2djQ+uQnbGp?=
 =?us-ascii?Q?kgPlpd7XiiIDcLvMZj+U6X12U1DiYfLnzBxKWrDZC036VM+JbhXN6R2eIGem?=
 =?us-ascii?Q?SzHNM4+nbEZIyN0Juwp/OAxtu2gC6pCnUAIjj8EnX1CZ9JnoUG4F5FYPOERI?=
 =?us-ascii?Q?usVho7KmuPIo4XH3yCOrOwKmfNDTgfPe7cZdc4/sd/OQicUmHiC1jTRjbXWb?=
 =?us-ascii?Q?Qn2QP3vE2BBm8mlVltVMJ6p6sis++fjcVB81Q0D2uMoF/P7EitDOm+3cJNjb?=
 =?us-ascii?Q?FPzIHKnVP7zJF728vDDt8WmI+TXrSRf0YzRax1Sum9uJXly8TIOHecaLUhWE?=
 =?us-ascii?Q?xyDlsFEmkODkABnfN5ml/CMSFgpT+w7yUuEnQZF4ok6fSpKZfylC9l9VHeG0?=
 =?us-ascii?Q?jdBySwpDT5cQzn+7Xu7JMvCjFg1QkxIMcf14MD8cxr7WjCtdL4QGRolVcKJd?=
 =?us-ascii?Q?x334BW6mmdnm/vHq0zA9md+iwARMqKeHN3k1Sf9jrw0dN5v0zGgN4LCLGYZ9?=
 =?us-ascii?Q?BXi56LB/fV7TPT1qV2kByF9ppH6Zs1RI5U6zlkoaRckv+yu36am2Lfov1RwF?=
 =?us-ascii?Q?Hc81CGXyni2AELH0qiwEIWHxz4W5nOGLTUA6S6CQ4pir7mqV0epVBjM5R7xG?=
 =?us-ascii?Q?9aqZruOhJU4nmmzXJiNMxUwTu70JvDTLpLz0kFYu2dzN4+IOwMlyYvM27+2E?=
 =?us-ascii?Q?lNCu4igsa6ZvEy0tHhhu8+p15tgli5JtZ4xQGwLNSZ74hR1SZULAeJIcDb09?=
 =?us-ascii?Q?ktPZxFDD5Fvlw41Z9MNdws7U6CC0nJwPZLt80rPx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8c9f8c-df6b-4520-8ecd-08dd47dd73d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:11:01.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0HLB5U/rUWrCpQBSxOA1xE26xbeuXhpYzHzIp8w4Mot4NUItPq0pmfzbNzlNkRxhEqN55GPFQcv443SRE+5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On 07 Feb 13:51, Jakub Kicinski wrote:
>On Fri, 7 Feb 2025 12:25:28 -0800 Saeed Mahameed wrote:
>> >nVidia is already refusing to add basic minoring features to their
>> >upstream driver, and keeps asking its customers to migrate to libdoca.
>>
>> nVidia is one of the top contributers to netdev,
>
>That's inaccurate. I can't think of a single meaningful contribution
>from nVidia's NIC team outside of your own driver in the last 2 years.
>

I can help refresh your memory.
Switchdev, devlink, XFRM, TLS, XDP (multi buff, meta data),
page pool, and I'm pretty sure much more.

I can also point out a lot of projects that are still stuck for many years
due to lack of agreements on design and communicated importance e.g:
PSP, TCP ZC, devlink params, and some more..

Maybe you mean meaningful to you, which is very hard to predict what is
meaningful to you without clear communication.

>> we submit patches on weekly bases and due to netdev mailing list
>> review backlog and policy we barely make quota,
>
>Luckily we have development statistics so we don't have to argue:
>
Yes we don't have to argue, thanks for sharing.

[...] snip top reviewers since it's not part of the discussion.
>Top authors (cs):                    Top authors (msg):
>   1 (   ) [9] RedHat                   1 (   ) [48] Intel
>   2 ( +2) [8] Google                   2 (   ) [42] RedHat
>   3 ( -1) [7] Intel                    3 ( +1) [39] Meta
>   4 ( -1) [7] Meta                     4 ( -1) [31] Huawei
>   5 ( +2) [5] nVidia                   5 (   ) [31] nVidia
                 ^^^^^^                                ^^^^^^

So we do contribute to netdev.. and we are not moving away from netdev
which was the whole point of your argument.

[...] snip Top scores, since doing reviews is not the issue here.
It's a separate topic. If you want we can discuss in a separate thread
since I got a lot of what to say on this.

>https://lore.kernel.org/all/20250121200710.19126f7d@kernel.org/
>
>nVidia has a negative review vs authorship score. It'd probably
>be much worse if it wasn't for the work of the switch team.
>

Irrelevant to FWCTL. And yes very important topic to discuss, we have
our own reasons and concerns. Let me know if you want to open this topic
for discussion in a separate thread.

>> so please elaborate on what features we are refusing to do ??
>
>nVidia likes to send these threads to my management so I need
>to be careful. An issue was discovered during new platform evaluation.
>That's all I'm gonna say.
>

I am not sure what you are talking about, but as one of the mlx5
maintainers I am 100% we are not refusing to do anything that we've been
asked, it is all about priorities, you have to sort this out with whoever
is reaching out to you :).

It's really hard to keep the discussion coherent and objective when you
are referring to private discussions I am not really part of, that we
can't discuss here, yet you brought them up.

>> As explained above, netdev doesn't need it, but netdev subsystem also
>> hosts the pci base drivers, so you are going to see fwctl patches the
>> same as you see rdma and other non netdev patches flowing through
>> netdev ML.
>
>Sure, but we're deadlocked here. It may be a slight inconvenience to
>redo the interface so that its not a standalone aux bus driver. But if
>you agree the netdev doesn't need it seems like a fairly straightforward
>way to unblock your progress.

Yes Aux needs some improvements and it must and can be abstracted out of
netdev relatively easily, to remove this unnecessary workload on netdev ML.

>
>I am glad that you at least agree now that nedev doesn't need it.

netdev can perfectly operate with all the standard tooling we got and we will
keep on developing them, TCP/IP configurability is well-established, that being
said, netdev is very bad at debug, and really really behind, the
few debugfs' and devlinks we have really don't cut it and will never be as
good as fwctl, so mlx5 fwctl has to run side by side with netdev,
I believe the same is true for all other vendors.



