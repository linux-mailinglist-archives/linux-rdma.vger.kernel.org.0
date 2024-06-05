Return-Path: <linux-rdma+bounces-2893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7B8FD04C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8091F24D2F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06C17C8D;
	Wed,  5 Jun 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2FHIguy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933717BC9;
	Wed,  5 Jun 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595961; cv=fail; b=iR8xdsvE0RFMouPUV6Fs5PywnvcvKxgmkIHSIiskdm8/BtY6jzl7d/bBk2hAZBqV4W0Ws5HZcAd+d17Z/BGenxhZXMrNtRFsAUCHuSVjkYpnGb90Upmc58dnTuR14Proy/yXpInRzv9vQYb2C4ftJwomW2CEo2otUpDG0Ukyy5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595961; c=relaxed/simple;
	bh=uDTCEOAI2Oi90RNBCLrk66GxqaC3jVTCVbVuRVMx6O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LB8QC/0FTTxQ0VY2xF1B7WKQ6MHjo0Dfnq96XJANvStDPvBp8juZB1fpmZ06fwDv4ogQuVraL6awXfxkiiiNWwjnApzvC/wOgnEthhxz9JE2WCOYB/UlimKPPp9gILbt1LTb/R2rWURPSCYOyPbb1H9xCwItftCOQO9FBgWoF8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2FHIguy; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlcnMQAGvDDk1ubOfFPV+qo9fhUITI18CBhGaqZOZTyGpkVK2D6DClkiKb7H3N8jRucIsAxGx/Lij0o8t2ECCW6QUJcVZDv4aFmX28zDdURfTdPbKJ1QWVfBzVLqZ5SPCseW3ZOOijd/VjFPFp8J/kM3QLLE7/LGsKKawEoKW0DkSdGq5ApSmbHM5LAVTr+d4omkT2O/Sh99P0JSc5ICgCgSOaXIetJEa534H9+RJYsVuPFlwtwm1K/WRAcsbjsY2uuzc1cuLBWuGLKUNPQgr8+1S3hwRKx13wHxNSCkwIS4/sWZCGg7pbodwzo6F+C/OkF0fD6j/WSeKsCYW44rHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRXGFmqjmfCJJ7owtvw0e1rt/HgpdYskHBsa2EVyd0Q=;
 b=Pt3QgvbWuDUEC4bs3vHCfwen8VhI+2EZ8joZhoeRe3Iu97XKGwNG16utCFmACYC+mVGUTUhAjv0I9F7xa92hKk/DAzw6p0W6x0Re42YSDfUUavaH1aCq5tgIybqyzuG3XF1U9IJkG6H31BGjhe6qHmQTNaytJKNRjEQUI0VW8QDGVwTPEIFcoCpNN8UOnkbD8uwKy9eCNry2aSmXZdYKxqzi8XUuy+SvJGAsJv4dXZWYNbOhmB6XLV2W1NHtzSWhnJaKXK9lFk9GyveRgkDrpNZ7Itlujlyau1eLrN3GJOtJldX/zX5AMWUG+xyEHISuhZ5LeZGV/4D158YXmWXXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRXGFmqjmfCJJ7owtvw0e1rt/HgpdYskHBsa2EVyd0Q=;
 b=Y2FHIguyHCgbmI8t5vnNhRiSOeVVI070P+Pq1DRjv3c/FwdCqBXsayUNOufNkHB2A8eRjtSRa10MEufdxVNTFumnwtGQQSkQhOWNvdWWtoU93wVO/Lus/pKuP/90tf12dYk0d5uVaowiV94aD/5ZT3Oh2X0l808jAoMCOhynZ0YLLRLuPq23B8IC0BQ9XOLaBhxZ75aVM4tIKVRGYf1fbDnk93evsbo1foUoN0et/6/4QFu9K5kiR9F0PGoP1B6puDZFBaXIWxfI8t3WhDAraeQ0s60T4Rmd4nOzIhfuLmDo5JfiyD4RFopUXv5HToBCXtpesmeE6Hmtt9xvZ+e44Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 13:59:13 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 13:59:13 +0000
Date: Wed, 5 Jun 2024 10:59:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
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
Message-ID: <20240605135911.GT19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BL1PR13CA0431.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: c67dc920-9f13-4d8d-d619-08dc8567ae1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CeEpL8mM9tKQBe//wXE+uFysQ/zPY4rkgslU1aPjtb4d+GRZmNF7YVHG/zO6?=
 =?us-ascii?Q?x0TVZRtXyMp1G+dXYp8KLR8MjGc1Yx/PvI6PuLrXWJmCLFcXvv3eg5ZhAxlX?=
 =?us-ascii?Q?/oXDfwZUJyOkMJroY+1fFJSBxd/s5QHPXmF2dDKIkMfhebQebTahzn197GFx?=
 =?us-ascii?Q?PIA2HKLtwlFj02LtL4Qh3TLMuZzz3kFAg+lHdW1gJ6peOB5l5Lo674B5+2O2?=
 =?us-ascii?Q?c+BYXU9yPqU8ptqMkNUShv1DzTVJnDgXzN5A+rTH9sY3VbNmpjxkG+tDgVke?=
 =?us-ascii?Q?cCQw/IFvnyzlHlIjebE+cIz4ODlqH3lrIExfmcHvyBhvCZZCcXNg8yGOWxAH?=
 =?us-ascii?Q?J/WAo0mRpbM0hhp38VuCpNDJ6w0Y+sjykNZzEv5+OrqXx6dbhgFP985iU10Z?=
 =?us-ascii?Q?FL2q+gPZ8YLhtWLJexeQHD4PmGGLPF37t68pq7ekvqV08Xa9Wie66ZeEqdQR?=
 =?us-ascii?Q?silaRx2juXJA/jNZlYSUDBn62IwadATp/sYNZscynwXsH9cnyS/3Mv/vV0DT?=
 =?us-ascii?Q?v7W+4XCbLoUS1x0v94n5H8dGmReXKbdNU8O0aNjqWNrSXVvgMSOL/SSe9h6F?=
 =?us-ascii?Q?R0CSQ0QdzCSlc+VazGzNiUbMATmbgN02ZLVHPWYMeVuwhUj/YI0JRYj58yk8?=
 =?us-ascii?Q?4ith5qauCArwnSq7NNlrmQT0h3gyym/bL8XkLVNXYCdr9EJYIjpliNkHYWUB?=
 =?us-ascii?Q?cpArLFnyDGFBJ2DnfMmD4i69y4TtiEREkTQUYuKXB2J0kJ2If2tdQxMWJCrG?=
 =?us-ascii?Q?F5M+uwQRymR0gE7vnM73+I2hHnHwlv1d3NqINfXC2z0nCWhyAJDNfnenOGHC?=
 =?us-ascii?Q?xjuOCau/pguMrrq0b3ZqReqJcVuVQRrxXcipd2uf3zbHJVMAih8MLPdME5is?=
 =?us-ascii?Q?F//ixvIqvKvM5risc2Sp0onIBL1wVesl7A2v4d04cpcb7iyrm8eZVdIAZ7ZJ?=
 =?us-ascii?Q?0BKzbnhegfm8/NE/rURKxz1SORojyI7rXr3UdTIKnloI0hXsFg6zOFcnS8TL?=
 =?us-ascii?Q?s9QThlXdbCdte7jTw+u7omSlFRh+I5EaE6ujXnOxVqDa5RsW8BssqTMHzeUp?=
 =?us-ascii?Q?dFVrIxakEhmNnwo0DwE64yxbFif06SUBVG2PC1U75ly5sd5qGZSuLOGjgBR6?=
 =?us-ascii?Q?lJZ0Cc6jiXlr2lk/mBrHFXPDhHjK2WvaWHsNU+ymH1XRSofpsUuszfcBZN0A?=
 =?us-ascii?Q?zMWbRFmErjLOUMfAYLhXUgNCZp2CYmQQmQ/kdllpBGgDFrX7k46G7u1J3YuC?=
 =?us-ascii?Q?7Exl/jJx1MeOGQ3k4FEQS8BiWeT6qSO1b9YKeXhIQqRfRfbTzCVyLdFrzlhy?=
 =?us-ascii?Q?fEKAdhgiTKZ8cbx0Yc1pYIKX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17zLuypxL71dgcGCxLgeztNoLhk7oInwNGEyKaBvqVGwgqLxliWtOyGConDH?=
 =?us-ascii?Q?dz4NYH/WYEAAhsUDCWphopCnj60Ho1xU7JF9dUnTBdEnk7sMIuwcZeOi96TX?=
 =?us-ascii?Q?reNvtlJjinwdwJHd5ubHh5GXcnGb+SjudkSTff+cisD5n2mWdjBzNbRHE2N8?=
 =?us-ascii?Q?yEjrzQjdSIjDW/wS0bpwtIjffmnp7nfOIEgq5lsc6QnTKt8zpTDTNl0YgXLj?=
 =?us-ascii?Q?uhoZ0ZcHFPaRsBoy6NSR2LVM2wKT91NofcN6n39l0qmtM7P3gN+VXsOgn98d?=
 =?us-ascii?Q?gR86bzr1TqWEcbKTlE4vyaZMNYIeu6+JV5K0+FRP7O5or77ZoUAs42i0IEx1?=
 =?us-ascii?Q?wNTYTDMk2rrQJCzj9yIN0HbfqyMK8NiSsQo2EZ8u9nNhPuvkX3sIpFfKW0IZ?=
 =?us-ascii?Q?jZa2unLT29IqGlQe44qZIYRtIkn1d9uosDqJ7NLTmsTjTj4FZcfuJN/dZyvB?=
 =?us-ascii?Q?/xwbcLc3JymE9GGOao+Z8oAPEEhH2lzd7/OMoPzRt5LMFgW5jvUoCpz56w4B?=
 =?us-ascii?Q?lQ3DlF03run0gJ+Ix6ou1JjGvtkcCy7pauf3mj7FX7A8EYUa6YTSJAG83i7z?=
 =?us-ascii?Q?e52titTNg0+1aXn7gEBwvUtnSkxl8RqYOq5LujSa6uCUVDfOmgEyoQZJtqRq?=
 =?us-ascii?Q?OCheav7kdRrv/UvBNaF2jfsBfxpOmO2AUhITQ9bTSdpAwl9gkfSDKuOfGe8N?=
 =?us-ascii?Q?jmliYQeJ05JdJ3HMCnDbr2KTas3/lrzq6KrlOpjz3y8xwO9mVmkLLyBnE2aQ?=
 =?us-ascii?Q?L4f6EGWghR3BvOksG3O2TVlmud4tXaSeMbviFoiyhk+TcRxaWg4D7of/9kSm?=
 =?us-ascii?Q?Zif7AVEnkxTvvCheSY+0p+vkzhYN+M7zkPJpILWfa0jSQFsZFUuSL24SbSqf?=
 =?us-ascii?Q?LdmcgDTir0xi/bA3b+4OOJOKUOV231cdfMx/G4pnwv4O/SAV8MQZvCEUwOvr?=
 =?us-ascii?Q?39hTERq0BFGPnVTReLOcg7rAsNlUb+JROg40Rxj3FbHPgBiE8DbFgZJNjVJ1?=
 =?us-ascii?Q?wc49LdPXViPWo/c8/YdQKPnYaPSiFBV7zUuehYtL0RT9ibvSENsMHBqKU4Yj?=
 =?us-ascii?Q?YBLeTgmdoarXLuWwBE/4NlB8G1Fr1gkEdVxtB5TwXuXr8VgjECotUGSPFsZ3?=
 =?us-ascii?Q?2vAyzcTQLypAtYMFmCgZ/yryyuiuzqiPS7lI1ciumIJdXW3jRD8O15W1FqV8?=
 =?us-ascii?Q?pOkl5P3mMmtl+XrDIk5CG6SbqN/KSjk0dt4vHeHEgulnot2iWRKp5QY0cIoU?=
 =?us-ascii?Q?xKsPXuZTR59AsMzBguCPrZ0Ri/zHBg01lt/O9TLsXdb2HY7DjMEoPOJSnhgD?=
 =?us-ascii?Q?omSOJ0CIM+QvLb88QNSQG6t7+lYAtMc7qK+kZkaikUREF5j2PkWtJMpCufup?=
 =?us-ascii?Q?u2KO7jsu4elOOI3TQoGsQBRdGEcrjdR7xmqlWGVaHu9Zuz0DqOcjOZURLL7+?=
 =?us-ascii?Q?e7CKDC9z7NMe6YEEhcnQUMD15t1LUmsUQ/ArrnYPghfrKBw+nV25dZNuAsvK?=
 =?us-ascii?Q?9pNDhbfmjc6ZeCENIgfWX4aY9Sq0eoYHgL90Gt0Fkm75/kt20euH9b96Vmo/?=
 =?us-ascii?Q?vmSOgDaf23kT+dnRwkRHLxFPGOVWcPdbkZ0rfoB3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67dc920-9f13-4d8d-d619-08dc8567ae1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:59:13.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mdS6869gBCxQnemR+Omqlm3nKW6oBMOHL7jv/FiqAGHkp2VOmF1jJnOyZK5o5Mo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

On Tue, Jun 04, 2024 at 04:56:57PM -0700, Dan Williams wrote:
> Jakub Kicinski wrote:
> [..]
> > I don't begrudge anyone building proprietary options, but leave
> > upstream out of it.
> 
> So I am of 2 minds here. In general, how is upstream benefited by
> requiring every vendor command to be wrapped by a Linux command?

People actually can use upstream :)

Amazingly there is inherit benefit to people being able to use the
software we produce.

> 3 years on from that recommendation it seems no vendor has even needed
> that level of distribution help. I.e. checking a few distro kernels
> (Fedora, openSUSE) shows no uptake for CONFIG_CXL_MEM_RAW_COMMANDS=y in
> their debug builds. I can only assume that locally compiled custom
> kernel binaries are filling the need.

My strong advice would be to be careful about this. Android-ism where
nobody runs the upstream kernel is a real thing. For something
emerging like CXL there is a real risk that the hyperscale folks will
go off and do their own OOT stuff and in-tree CXL will be something
usuable but inferior. I've seen this happen enough times..

If people come and say we need X and the maintainer says no, they
don't just give up and stop doing X, the go and do X anyhow out of
tree. This has become especially true now that the center of business
activity in server-Linux is driven by the hyperscale crowd that don't
care much about upstream. Linux maintainer's don't actually have the
power to force the industry to do things, though people do keep
trying.. Maintainers can only lead, and productive leading is not done
with a NO.

You will start to see this pain in maybe 5-10 years if CXL starts to
be something deployed in an enterprise RedHat/Dell/etc sort of
environment. Then that missing X becomes a critical issue because it
turns out the hyperscale folks long since figured out it is really
important but didn't do anything to enable it upstream.

There is merit in upstream being something people can and do actually
use, not just an ivory tower of architectural perfection. There is
merit in bringing code into the community instead of forcing things to
be OOT.

For instance the thread you linked where there was talk of needing the
signal integrity data is a great example. Sure some of that is
manufacturing time, but also if you deploy a million interfaces in a
datacenter, then yes, there will be need to collect SI information
from live systems and do some analysis on it. You wouldn't believe how
much physically broken HW leaks out into data centers and needs
manufacturing level debugging techniques to properly root cause :(

> userpace-to-device-firmware tunnel?" to at least get all the various
> concerns documented in one place, and provide guidance for how device
> vendors should navigate this space across subsystems. 

This is my effort here. If we document the expectations there is a
much better chance that a standard body or device manufacturer can
implement their interfaces in a way that works with the OS. There is a
much higher chance they will attract CVEs and be forced to fix it if
the security expectations are clearly laid out. You had a good
observation in one of those links about how they are not OS
people. Let's help them do better.

Shunt the less robust stuff to fwctl and then people can also make
their own security choices, don't enable or load the fwctl modules and
you get more protection. It is closer to your
CONFIG_CXL_MEM_RAW_COMMANDS=y but at runtime.

I think I captured most of your commentary below here in patch 6.

>   Effects Log". In that "trust Command Effects" scenario the kernel still
>   has no idea what the command is actually doing, but it can at least
>   assert that the device does not claim that the command changes the
>   contents of system-memory. Now, you might say, "the device can just
>   lie", but that betrays a conceit of the kernel restriction. A device
>   could lie that a Linux wrapped command when passed certain payloads does
>   not in turn proxy to a restricted command.

Yeah, we have to trust the device. If the device is hostile toward the
OS then there are already big problems. We need to allow for
unintentional defects in the devices, but we don't need to be
paranoid.

IMHO a command effects report, in conjunction with a robust OS centric
defintion is something we can trust in.

> * Introspection / validation: Subsystem community needs to be able to
>   audit behavior after the fact.
> 
>   To me this means even if the kernel is letting a command through based
>   on the stated Command Effect of "Configuration Change after Cold Reset"
>   upstream community has a need to be able to read the vendor
>   specification for that command. I.e. commands might be vendor-specific,
>   but never vendor-private. I see this as similar to the requirement for
>   open source userspace for sophisticated accelerators.

I'm less hard on this. As long as reasonable open userspace exists I
think it is fine to let other stuff through too. I can appreciate the
DRM stance on this, but IMHO, there is meaningfully more value for open
source in trying get an open Vulkan implementation vs blocking users
from reading their vendor'd diagnostic SI values.

I don't think we should get into some kind of extremism and insist
that every single bit must be documented/standardized or Linux won't
support it.

This is why I envision fwctl as not being suitable for actual
datapath/performance stuff.

> * Collaboration: open standards support open driver maintenance.
> 
>   Without standards we end up with awkward situations like Confidential
>   Computing where every vendor races to implement the same functionality
>   in arbitrarily different and vendor specific ways.

Standard are important. Linux is not a standards body. Linux
maintainers can only advise, not force, the industry to make
standards. At a certain point Linux's job is to implement software to
support what people have built. CC is a sad example where the industry
did not get together enough, but still Linux will support the CC mess.

>   For CXL devices, and I believe the devices fwctl is targeting, there
>   are a whole class of commands for vendor specific configuration and
>   debug. Commands that the kernel really need not worry about.

Right.

>   Some subsystems may want to allow high-performance science experiments
>   like what NVMe allows, but it seems worth asking the question if
>   standardizing device configuration and debug is really the best use of
>   upstream's limited time?

From what I've been seeing it looks like a significant waste of
time. For example there is minimal industry value in standardizing
values stored in a device's boot time flash configuration. If some
common software wants to access really generic configuration (like
SRIOV enable) then sure there is merit, but that is really the
minority.

Jason

