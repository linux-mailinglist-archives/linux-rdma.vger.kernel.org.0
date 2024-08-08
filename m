Return-Path: <linux-rdma+bounces-4245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98B94BC76
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CA92836E1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4718A6A1;
	Thu,  8 Aug 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLoLfY8Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283013D265;
	Thu,  8 Aug 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117589; cv=fail; b=qkcQtIQ7pAnWBfojjCliqZdMHFhJsvYljllCg828t/tiz03Fyv0sdMbDHqbyb3g0dBZ+av+Ve3kA9/pbG+gtH8mVosRLFpqHvH9tXXWOUBt1OaFtOVamEXHTDybuHZUldwlk7tErWCiLa7EaLyqnCP8ERffqKlTSBKYxdvy176A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117589; c=relaxed/simple;
	bh=Ly+h6zQhpj4F+uYJlv2DJzsmMjLl1C52Jss0dE5pfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KoT0+Y11+P7Hn9KtaHkAaLYu23jUu0BK7pI+uccjalDdk5YahRyhbKv8vZs68ZfLQuZI34sWjsBUN+TC99xEHuHCwitrVZ6qD6OcSYvFao+hyQ0TWmAuL8Yr8zusppnc7aqAqWlFGiSnNd4znFW8U7fWPgGqfI9xyw5HXDDxtHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLoLfY8Q; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdDLklqqWZzfCWetyplhBCdhAZuTAqof8NfRbKd3sr5StVgzSU+U1mqFV8MqxKiRImt/q1ZV7MWcHOEUO7VoHZjSyt6ZYmRYaB6YLYurG+q8ODkHixFnLGzLR3nfD+uar4hSU4ArVEXEtNO2ypyEYwwxVht2bljhOXfNFh7U2qH9EWfKOz5ecJJmC2+UQj4Fx+rrXtVwKtCmipOXq8kMAwv//PWLQAItj6Kr8bR2eY4jkEyGKZ78aNm/ghCGbZeHEadEoNR+Dxtq60/2rXqKUt5SYqYNGWwiLgg5d6WTWggWAuZRs95WbJcArZNWjc5MQn6GMDOjt1W+whuPEM9e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7VmUeN2bPZUZQ3pglkA2B7eMGe7LNoZz2CPFZVHm/0=;
 b=PAHE52WQ1duDRAXHoK9fqnk/+JsyNeme6KHn/uvQQ0FaPZAoyl4q8OA9dxSTWxUG4bGhD708ji6eVf565pNGt6Av/+TYW2wQjJlPE9H1e88ZwnQiUX59UYthLEq1UvcinoVTIAcfs9HdKW8e1ewxdSwejybJZBNqi8zlXKYjnpin8KOoSr1lyNwEze/JO8XcRoIJ44U5zk5ZETPfXlyyWMUb85VXOLjmYJCRvChTfdDcb2FN8ovVNLh+JYKR23Dbwzeqc4Ckf9vu7sWbqu7PmMJ7o7PYXpcj+I5/DOVbwm0Ann7UlbyVV5U8lMSIj3xkMYWHtDRijVGr7PEFo1DcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7VmUeN2bPZUZQ3pglkA2B7eMGe7LNoZz2CPFZVHm/0=;
 b=gLoLfY8Q5KjXvwIwFY5R2EksduKt7KwVEBmSOd4hw4fVaPR+CWItHBJlbuIHoQy0GInToEe5NJTweT75Jr2ZiPia4ZGuJIAxlCjxa+qt8GnJ5mURK1BFTVZ5CZ5/OLO5+SI3LS7MnvIUCHDf+UkCsLMndcWfN5KdD0+2Cnt3aK20MQtzsUjwycmvHXx4g4h+Q+jHbykzqT6Ydy8eu6ghW7svUHBysvMUQVpnfEh7oHq1GACEJ7oh/rdejlIVIy/s48kxm7tA1pxK9Bv6FD0g0c6REYD5xW/zpJXj4k6/qk3VQqvHsZGbuSGPLLmakY6TtB7L4kVX4jwak9gUDtqNWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 11:46:24 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 11:46:24 +0000
Date: Thu, 8 Aug 2024 08:46:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Oded Gabbay <ogabbay@kernel.org>
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
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240808114622.GA8378@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <ZrMl1bkPP-3G9B4N@T14sgabbay.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrMl1bkPP-3G9B4N@T14sgabbay.>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 79681a53-629a-40e3-0252-08dcb79fbacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lOvpq3ZynVDgLUn3gcDBWbftqB9nY9sDDD5Mse7XOiyOd5ZvPTCQVLtTNU4h?=
 =?us-ascii?Q?f+d8fcZFfpzqJCR6ezCqLXA201RB0sayyDYCp4wG8vchRYkUrd4YEfLuyE4d?=
 =?us-ascii?Q?HM+xz8irjnhsryhA5FGr6mJHAjNO0pUkYyIyWgWxpp996UmbFEBBKbcDN6P0?=
 =?us-ascii?Q?rkYDcXQZ5u7avZSyxTGsakfzozHoNLS2Gqzut0urHmurus7X4szB5s+FwfX4?=
 =?us-ascii?Q?KQDsa9lFaK9a/DeLcLnRjl7Xxgj3fzGHS7R2DiY8rZUekFY4Xa2KDOglhR4p?=
 =?us-ascii?Q?MAAIXOt8WBakAjtBy7Qt/snWfXnzQSAq+lSZ2mWMKai5Vhrnae8qg/rEEhga?=
 =?us-ascii?Q?leaXHEbEKBK406H23GlkE8WXD/cM0CL09Kt5cvTSpE8ATBBa28y8E6RY2/NG?=
 =?us-ascii?Q?tIKefg5sSJU2iX9oWjfKX7/gPgTQJKx6ABJ/UsKKkaITASFqqy9blT0KuAiq?=
 =?us-ascii?Q?rse15iVb3tX5I1NZAcBDy3ySMRNYkxr+8YV++UU/hB9iBadZ2ubxQmVtoVNh?=
 =?us-ascii?Q?9PverY3DzlpwiugEH96egPVI5J/DIlQ1yhog2De1YSnB3tJuIHZ0GWIyAeV1?=
 =?us-ascii?Q?BS+dJtkoiTnMC98ACWAAqYVZvFEp7/R/w4AWKsRINu17hdH3XY7G89K0Kp83?=
 =?us-ascii?Q?tcm8rbdGIoUhfJHwsabJJVZhhmK9tfDGorvo/s2U4ay+4EbimutYEaeUE4gl?=
 =?us-ascii?Q?0CLx/NtbVhqu+7EjyzMIeTSQRTeZrM/zSfDaNgf0IZpbBUratdW2UAfvs0nq?=
 =?us-ascii?Q?lZZtXcJXKH1y75C6L1fMxBOuoFSpXkT5YPS7ir7YSQCeTVSi7HyAlpgZo7Wd?=
 =?us-ascii?Q?VyMzzBY3VNxXLhij9AzajyXv8cHxrCuwA37gUT1aNmPOOYrp+Jokb+QTiMeu?=
 =?us-ascii?Q?R3Fo0AQNzuNSmkvScc6UtqQK2AezaDPnMnI4KQWtpLJrIjzNxhVd8HbrFzf0?=
 =?us-ascii?Q?mdJ1z5Jgm6l3kaj7rxYJ5XH4eF9yCZk8kh6jmRdHQa+cOsqhwGFdKSitop5A?=
 =?us-ascii?Q?qDS0cx1Dckhwwdh31N1bNJFvswESkCIikH5WZKOaJUmmOS6XN4cNkcn9u49Q?=
 =?us-ascii?Q?KOcVSW66Px1vAuWNfEi5rFbFdBh98wdrMkDqRwiXME+b2QTVnrA+WdIBweK2?=
 =?us-ascii?Q?Zbk+V0Vec5S2qpXiGqg2B9fAld10LXSHkX0QcbbgPlfhtUykaMFtLSHzOukZ?=
 =?us-ascii?Q?Y0OlFyO4Ia207TndqfMIzbnEs4RDPJdUeSLR7UJtjQURWq268jmVZryrinzT?=
 =?us-ascii?Q?M9EL2H+LN4VaOp4NHbAzB+5KsDyHMScIcHKn+jmomqjI4TYpNScNV+Yf0ob1?=
 =?us-ascii?Q?Txvoam/39+Ar4IaQIXUYCUVfrdj41ERwyyPgKRw3ilhZ7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGqWjts3fOa3L8hiGRKOK7Tne7DCExDlFaySzmjrI/pwKbKYVWbHQpRE3oo9?=
 =?us-ascii?Q?k4qcdBWRVqkhdXk9nbh4enhE+YBldEOw6t3UABSbDGtyUwSkr8uqJZcBrkkG?=
 =?us-ascii?Q?upTL25fL3iOAVyEfVi5bHYn+SaC3d/8AQ8s9GNcxMpTJinztGsMTphAppSnf?=
 =?us-ascii?Q?OsePjueM5Tn/3MgloGe41yrMKmEtScLZjTSxtzN4fCsBCDC+ZojXUZ5R99wR?=
 =?us-ascii?Q?+sOj1rSMHKN+nJ6LhbCtn1lM+YLaeniJhEIsRys17okjZVBey5KVDa7gk6pY?=
 =?us-ascii?Q?eastcpgNTD3MDqUTYfKv7+GszPzStLq2DNJ+dyJqsGEQN5b6n4J/TUYSO1eo?=
 =?us-ascii?Q?yFIPpD2+6hbFh/UJBdkP5NCAmmrAlCpx9uO0UuSiRYmvg9JFKNqaqLv/t8zz?=
 =?us-ascii?Q?L3kmeYVZJHkAl2R9EKI2s3v5ZgkYOfAytF2HGOPxjG/HlVbbm5UCT/hGUvds?=
 =?us-ascii?Q?J6OarWLJvmH9AXlpw3VkyZGF0Z7lPmLmo9HlM9YZSBashOUnmgYnhPxL4v1A?=
 =?us-ascii?Q?euO3YYuGyEMAu52q/fGSyPy1cCZtQBXLnDCjIVOMwZ8/8A2vTJMQqO+HQzNN?=
 =?us-ascii?Q?igN5KblRcs8LDUSP4yot0eJoy5bX3T1VLxrsNXXznYk4K7k27PG0ugih7WP2?=
 =?us-ascii?Q?SVhKKkUwc97GEh0OSqR2/bBBnJX/D8nx7EqxZalZ9vvDraxZ3kfPTlDMSLK3?=
 =?us-ascii?Q?ay4+bE8ZfBGWi9voYfRpMFF0XIf1NnIA4oRROwS0wGp1KEaip88l514kDOAu?=
 =?us-ascii?Q?e2LxeEuvoXIqhviOS/eXFOXH4C2Cd5a5H4DxmKq+QAMQYONee873oXYLv0gm?=
 =?us-ascii?Q?SlzRPjPqrhVz/UFSWXUI1WZEp8nb5Fk49v/uHp37UFRWmsBhtzk4SrVlPmZX?=
 =?us-ascii?Q?7Zb+AK66wNQ2j5T3L0eHytOq0JM3x1iWCMtdi2RKLjt34Sx5ncGdRCVsb1d5?=
 =?us-ascii?Q?ktEGcGcCZoXnnKq5zitOPD40l9YCHZ5MEMOUBK/8ixknksyNBJK+4gIDwgkD?=
 =?us-ascii?Q?a1BRsGt3SbxSKRwxkjNs2GUH1awukIv1z9UswxwfQAQ1AXO9PcFSUjJHFgUj?=
 =?us-ascii?Q?X/0J8JmWlDnzxnycWI7yTUQ6UrQTi0hhE068y92B2Z10yjb1STosqQanZJ+W?=
 =?us-ascii?Q?f6Fe2ZRRWNIplK7rghCN8rm5DgGuuvNn36GuWBtHWVZuFwuSSglrpfX93XvJ?=
 =?us-ascii?Q?B8++ornPP/6PsR+L1Z+B1ZyOS2CpTrucAU1bsuY+4J2YWMJscbVqQHiw2+2v?=
 =?us-ascii?Q?0NeKDtqwna9eZzgzQWpWsu+HOX7Os1IeT+e/JWqiSc/sME60RvTtjVP4jwNd?=
 =?us-ascii?Q?lBDCCrVTsd11b8dbkA452lk4/rlQfe3AAqCpUC44Au+pYxrCg32OROtlPHM0?=
 =?us-ascii?Q?lSJ6ugSf7h9GhtYuWcRMoxb/sXOnMJpOoXN0w+mRjCLtuhMk2mT/W2tIggCv?=
 =?us-ascii?Q?doIsFpWJWiwvHDCzdEuA3rGYNofExeCsGcl8ZML7mKzp9KkqK5dYsmY6MmPm?=
 =?us-ascii?Q?QqlhElWEDU6DNhvHrq0VYDY578bqc2g3goB1UztGDInDAAJPHP88PT0eNBq/?=
 =?us-ascii?Q?XkEBXhqJbbPYTbcDkqfcJimi5edBHs1rWZPUcJ+E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79681a53-629a-40e3-0252-08dcb79fbacb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:46:24.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEk52IbIb5OKmafBViDDGLr+1CBA/tKrLMdZN8pb/VV7S+BTj099UEhdT5aiUwPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

On Wed, Aug 07, 2024 at 10:44:21AM +0300, Oded Gabbay wrote:
> Disconnecting the RPCs from the drivers and providing a generic interface will
> allow to have a single user-space library which will be able to communicate
> with the firmware for all the IPs in the device. In Habana's case, it was
> mainly for monitoring and debugging purposes.

Yeah, monitoring and debugging is definately a key use case.
 
> I do have one question about the rpc ioctl. Are you assuming that the rpc
> is synchronous (we send a message to the firmware and block until we get the
> reply)? If so, what happen if we have an async RPC implementation
> inside the driver? How would you recommend to handle it?

Yes, this is all simplified so the ioctl system call is
synchronous. mlx5 is async under the hood too, it just launches an
async work and waits on a completion before returning from the system
call.

Userspace could multi-thread it, and If people were really keen maybe
there is some io_uring approach.

Thanks,
Jason

