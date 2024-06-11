Return-Path: <linux-rdma+bounces-3059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202C9040FF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8429286ED3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39943B192;
	Tue, 11 Jun 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nr07CdoN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371C22086;
	Tue, 11 Jun 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122630; cv=fail; b=fy+lmXH/4EefDZsBJvSYHVb6cLN4yT+QkgX7tXB0C/F1/AYN6wmAyUEUpy38kGPVJOW2vmHaHeoee9tZm99ENd0dmBmcZ5xxRmFPdnLx8HkdxL09LdWM1pi87nH4X/x5Ad3g27UgYfLEl0YVeRk2HtYvK5QUlejvjgVJQ2f0iOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122630; c=relaxed/simple;
	bh=enhuOglE2tyKLmfSUAyqiYFpLJhy74JPQYm3iR397N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndToBUU/yHrMwxjSrZ2khEYtkjEQXnCgbNnr9+r9yzGLcS8aBxm9yCp4VI+ej0c72VMIrVj7cci77wmXXNI7pHsP4ZDnTB9BTz1tRs70quFgEwp1+gMQvJRaDIFdOT+YZYFFBv/C7Swo13Ykw6LAVu93mJMMDkzt+vNq6gxwb5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nr07CdoN; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAAdkSSYc9LsGoyGCd9zZPr3Kdy2A299ZHMkMMoEEOZQHRvH7MHgDKlix5P0vloXd6yt5LT8Vgwiuts8JIh/Kty5tzSw85c8Vx3VfY8fLDscGd8PeUTqMOg8k11l1WiYahThGIsj8fUOkH/Fb5bRrmw2JF4ftD2e4i2Ag/uT66KrQjbGQo8GGQwoTrPLL0QUkYJWLZehFqDlCczJnBmH8PL9ML5krlkk54FukcOopip3dDMCrM6hXrgu+Q6AMBQmpJEgjQA0S/nHQelv9lGRW0evStJraX51qKHwZIY0wA0JHuG/diTKysy+HIH+i5B4tIEKawItIh26L0A8NMSwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kebmkSlsZn+wkmkTNXoFTetBimNzi3+RMirkWddgCOw=;
 b=BJR/bTz1SRItNMTPRPlVORYV7n8BDwHAtihDMoeZ0pjMMI4VTmYfY/6bzXRRXISmwJHhAC5YZy+f4jFQiGVeA1zAXA7RtJikj7HVTDhjbL86dA3LAB2C+1h/8+zCBk+ISx8gFegxUYCNOjtLlNRgWg7oe0KiRlzOx7QwHh3QAWH9P+2DiFIQukEIxCJ0y7Gk1dx4rMOyGaMJexmoF55ArlYEw7vOKqSCeKlOWiRU3CQlUNGClunZs/0v5F71HJgXgfm68DnAikYT/b+K9v+pEDIS7ZBZv83g5e78ZxY1Uk6ZWIgJ/pNgM6MQeJ31AEfxH7vm5+wx4EEVBFzA9hJ4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kebmkSlsZn+wkmkTNXoFTetBimNzi3+RMirkWddgCOw=;
 b=nr07CdoN8Xi5vQvFkMZLYLn2NS+Ax+SIP/S0ijh8JxnBzl24aTL31nvMl9h+xUFlEYjQDrHg6b9ZQwoekU4R7rIqzb0l6pAfpyuS7btL3t8rPRX3JWzLT2RIxF+A9OEP7tg+qa+mRKiyVEWNyTpvbBqejMajK6Qg6os6/KcBDp11AtbHpHgzIdxM2Sp4B8CGZ9LK+aoJiIVMWy2dei4n6zKNdBaajTeI0hHzzcxV8Eb1eKdXbnUqG8IU1Zl1qUFPwHbNFym/Li+9HNc7+ilUPa/591wBn7KuZwfMG6yM7V9vGO+EqeYAgXN7E8ZwNhpJ3dWyAyaiLXQBGMKNxRaqZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:17:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:17:05 +0000
Date: Tue, 11 Jun 2024 13:17:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240611161702.GU19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <Zmhu8egti-URPFoB@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmhu8egti-URPFoB@phenom.ffwll.local>
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: a367c31b-fcfb-488a-c9dc-08dc8a31ef57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGe8LLyY9jrSTGfPM2TmoT9KNJ1fy2BHTLdGcVCxFvP3MO4AVf3kWodq7gm/?=
 =?us-ascii?Q?84hwIwuc+D7TtOLVUe1TPVv1l6/rNxGdt0p4Ei3QCAdtkKsFbZGgLjFnX7Xm?=
 =?us-ascii?Q?h+2AGpbOyxJJE8+t/NhD2ZS1nNceaxP7+MLgTyZLfahlpMtNOMtD4Z1qVJ1+?=
 =?us-ascii?Q?T9u955ULj7+VLz82s/bf8iM0Y1n/tMxxLlOCcOrIB6dL3zDqpMmD65OuXxG4?=
 =?us-ascii?Q?+X1wvv1lI0/KbUm4savkddSh2dqBcf9bwiSijVut7BEJoc4HR1cnlGmUoqyk?=
 =?us-ascii?Q?uygF5z5PCaebxy9F31zAE3P4XAr9p7t512YWzRA9cKiDymHyVkqj/w/09FcR?=
 =?us-ascii?Q?ntacZ2g7bUs/SwjkcEf6rdJfXTruYt7XPkzuVmilv97MwTV4QtzbL2eArekn?=
 =?us-ascii?Q?SFupmpIBcvfWmSrxIOFBpwofn6k9XpVSfjO6pPDK4RQNvHp2N8RlxdTn33e4?=
 =?us-ascii?Q?DSay9VuGT03E0gexcgrrC/IjkvitfPSnlJSuzKZi081RCM6ZDPAhpOC4gk8L?=
 =?us-ascii?Q?hepOqAHg2ssgmPYUxR2gSM9aRTi81VpHP6H9ECsLVLpgPaJDphCA1mfi/60G?=
 =?us-ascii?Q?cV6Z+GdrnWN/KJYyuWhEgYECWmEP/IUlMKamlgzsDXXweyRqclE7eQOkEUkF?=
 =?us-ascii?Q?+wqGWy32bfQh/F8d3BFNB6yUEjf+iYoZcln44PgfnJcxYBGs5RNvxMZENjTB?=
 =?us-ascii?Q?v1AkH9+cYxKNG13XE65alM+kGBZ/P4uVeqvNoXo36QP3nDg9Q5m2mMqn6tqM?=
 =?us-ascii?Q?6XWZdGbJ1zj5ucwv91/uWoFDQNqujUqEuhgcos6cnCPYg/JeIpSjb9m9/bWp?=
 =?us-ascii?Q?+oZcpwZGY+Ywj8D2pnuJ5yDc4EF9UiC69QfovYVuJQ+DzqDcIekRr0uEgFTY?=
 =?us-ascii?Q?HKVWWfxfttZxr+vjPeu0PN/9/4vdauiM3IQPyRKcnjip4BHCiK0PhOHRx4XA?=
 =?us-ascii?Q?myJzA9xe5/W1XL0wAyqAgbQyrIUkKdr45fpDHID8xUIOJuf5bIJwkpZcioYc?=
 =?us-ascii?Q?QMXU2N0oBAnAuehq4khvBSbxuQ3ca4gV+VzWSU+TDjOG/Ey8f/AZnGGAMHiB?=
 =?us-ascii?Q?WCEKg5DCy//8E+mdsrVNHKAHL1/1DRZGfHvbmU/da4njUw7pFKEbJpir6BUK?=
 =?us-ascii?Q?cDS+IbIVu6TwgNOLFYRaIsrep9GMCwj8H8Hwtjaek5IfaDCqOPYM/YpThP9F?=
 =?us-ascii?Q?xRUuz++0U0rGNG3MVMBkJBBSr9rfDxRqQYKpgwhGbdPJC02s9uuNzrUAACKe?=
 =?us-ascii?Q?JMqEWb3S0dpgN55lhRE6pynVI1wqYIBx/oa1+8UKAzj1IlPlw7M8dHCjMdai?=
 =?us-ascii?Q?OVhry0FFac4mGLUwZMcmbmZO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RerBgzjzwX0aF7dr19HKq1bmCgaF4wo6yvH0hTGRY1yRfgwwihBHqXWtK9m7?=
 =?us-ascii?Q?4Lgf05yrYiIhyYFPAAwDDa3buZwhblWS3ImS3q80vC4J2YWwlfDb/aLwOW+s?=
 =?us-ascii?Q?TaERLcik0TkKXPqDPI0tWObtVrxMBiZ6BN33E/K5lMADduxP+DIub7wfaTdI?=
 =?us-ascii?Q?yM6A8GGbIpuZpETfsgVeu7aGKqpoIUwRLvNOu0tSppnahh9a8vqeebVS4HOK?=
 =?us-ascii?Q?y0DoCiQYVhr5PMZ5JZ8cZntmcWSLycGg0SJtapr12EXcxiEgpDsXca8iUZ9K?=
 =?us-ascii?Q?P5PU8f53TVkhN7EFkFwazoQP+0PkuAhJVKvRIAgPW76qBJJlam18qLE/SSES?=
 =?us-ascii?Q?1hXWmn+16kqaXMmLJ7Ac/fxFQ0l6Ta02u7gbl9diWvJlY5daROJyN2sW1GS5?=
 =?us-ascii?Q?n4A3irosX+fIzUiCQDRpYX3VrSLwq8ul+vZ05aOn0ai7KkG+83LdGvOJ2JBc?=
 =?us-ascii?Q?chbyKTAWKv4HTG0O8GfvNFmSPASpibHSNzBS4wnUac/ukQgL//j1IL4fbQfK?=
 =?us-ascii?Q?z6AL+TQwpdRha9lb1qdRmcXN71+bEHcY+7zq70GUcq0w2Cvh5kMQov2hwC2I?=
 =?us-ascii?Q?O9YBa+oqDx/kxA3gkc40Xs15c61BX+0wnreP8ZdBNuLYjOPbP9CMWs6n/tyP?=
 =?us-ascii?Q?dUw5mvR0+LroJ+5K7BYBbEzkb+s9v8xLzAJwpBVCyLLxCCzb4uHvwt0PD3BT?=
 =?us-ascii?Q?oqK4jmw0iT7Pp+hs7IlxN6vCVyI71KhG+5jd7RwOBHb4W6A5gmuyhFPTT1i6?=
 =?us-ascii?Q?ZMI/VrrM72UvK9tvTE7u3STkVQr/3Jh6KDx76j9CRU5XV/6Kg4SWPy7iLcyd?=
 =?us-ascii?Q?zdNpHAZyTTHfLAMXUxII2RAYfG9c6mZ5iuML8lEXb8bLANf1Es0r4XsZzygs?=
 =?us-ascii?Q?0G993gNfQhoi8EPt0HY262jNgJm49yCc2uamXxy8DwiN94IOJsV5kO5AFWWN?=
 =?us-ascii?Q?6H9jZ2Je/+lwWu6gjFW2OXaYOgVeADgvYN8DbVC+2MsLJoGPsSC7qTF8SbNN?=
 =?us-ascii?Q?J23VLN2YwF5Gixb1pHoV2lOzIhrJzoiDsD4/JzdNAUGyOE976ZKdNA0Wifyw?=
 =?us-ascii?Q?NiNLk6yhQtAdCn3Sx2kqQQMeotlGvdkP3wSJASd41BzIXkPJ18Rt6P+cRgr3?=
 =?us-ascii?Q?+sj/fMKZKslzrqlziUJC2l++wHfT7XJeetTM8SAtSuwZ5VSWwTda3V8wfwzp?=
 =?us-ascii?Q?qFGy/dZq/fb9Iusqe1Y2kLbS7DDsB9su9N8bO54GyXibHYx62EfH+g1fVk1E?=
 =?us-ascii?Q?e46qSFux6n4yPkifpCwbP26grxgSGC8OGi/kUntdtzWqif6zL8iuwe2CxOUF?=
 =?us-ascii?Q?0yBNUGATZ3oWwt/gajkFPhit/1CrSfyJuNv0+a2RJfyQhu3AaKTqOsMogxJM?=
 =?us-ascii?Q?FBEODUOZDL7PNwo3Zs8mbCmGX28DtUEL2vjLkzdVytmcyXqHnednLOZC6gys?=
 =?us-ascii?Q?aFNz3oESinbO2F9PEy2+Dc96aLWMPZUFo4/ccKDUEk0LEeoT4Zsv2ZwsvrPf?=
 =?us-ascii?Q?icOlvcWJUE3AxuKy9CCB76GuifBSnwv42glHpjSX71nnWFfF4xjRlMwSFSA+?=
 =?us-ascii?Q?BF2Iu6gWfyQEBUiq12ALf+NzeYxuLSvk0wttHwkk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a367c31b-fcfb-488a-c9dc-08dc8a31ef57
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:17:05.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVnjJ+XlIhkUXlev/lI6nFrTFHJjh0QkwpAL5nERKY+15Iyv8wUNM1vO3LrLjpaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

On Tue, Jun 11, 2024 at 05:36:17PM +0200, Daniel Vetter wrote:
> reliablity/health reporting. That's a lot more vendor specific in nature
> and needs to be customized anyway per deployement. And only much higher in
> the stack, maybe in k8s, can a technically reasonable unification even
> happen.  So again we're much more lenient about infrastructure enabling
> and uapi than stuff applications will use directly.

To be clear, this is the specific niche fwctl is for. It is not for
GPU command submission or something like that, and as I said to Jiri I
would agree to agressively block such abuses.
 
> Currently that's enough of a mess in drm that I feel like enforcing
> something like fwctl is still too much. But maybe once fwctl is
> established with other subsystems/devices we can start the conversations
> with vendors to get this going a few years down the road.

I wouldn't say enforcing, but instead of having every GPU driver build
their own weird vendor'd way to access their debug/diagnostic stuff
steer them into fwctl. These data center GPUs with FW at least have
lots of appropriate stuff and all the vendor OOT stuff has tooling to
inspect the GPUs far more than DRM has code for (ie
rocm-smi/nvidia-smi are have some features that are potentially good
candidates for fwctl)

> In practice, it doesn't seem to be an issue, at least not beyond the
> intentionally pragmatic choices where we merge kernel code with known
> sub-par/incomplete userspace. I'm not sure why, but to my knowledge all
> attempts to break the spirit of our userspace rules while following the
> letter die in vendor-internal discussions, at least for all the
> established upstream driver teams.

I think the same is broadly true of RDMA as well, except we don't
bother with the kernel trying to police the command stream - direct
submission from userspace. I can't say it has been much of an issue.

> tldr; fwctl as I understand it feels like a bridge to far for drm today,
> but I'd very much like someone else to make this happen so we could
> eventually push towards adoption too.

Hahah, okay, well, I'm pushing :)

Jason

