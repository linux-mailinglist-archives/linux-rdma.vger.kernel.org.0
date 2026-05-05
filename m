Return-Path: <linux-rdma+bounces-20019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CY2E4oQ+mntIgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:45:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B26F4D0754
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB753041A46
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1948AE28;
	Tue,  5 May 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWAKEbxh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067A156C6A;
	Tue,  5 May 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995832; cv=fail; b=dPjPGdGdIKfymeOL9qRMKwI8LgXLCjj7OoQ/oeq/W55Ljb32oZwyfrXggQsA/mvyJ/G2Pnv8Q/RLs+nsZ6/KgZcZrtz9/cspVK19RytffHzSlkPh5dl3D+sVHmLYTmqGK3Ao1AtYXCubFYM6DB88wIe2h4L4EUrulL1IfkwKvrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995832; c=relaxed/simple;
	bh=tpyMu+iq9tobgJvpQ0iPxr5oOsMWdwTtAXfy+sFecK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjZfRHvoesc8WLaQVKp9GsZy2Hwluc6iRpk47VkoVMDZxvN46WSAHRHyjsoLNER72vmYMSmd2bziIJ/wnWEOrr4zT5F8g7PlnDjWOqIomaP0f9VL2yVhXaFZ85v7qzAG3wIeFNu5ZYmb9w6/oaEJzfbG20V57jFHBxNUqMbanRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWAKEbxh; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIpsRRfiLzxYhUuH+ivMeHvRdAfIv2x2TF3LqhTRtD6X9jWWYtBt71FSdLBFfvJ54mGolLNRDhtjX2O4zGNSIXjk78/HSWsYSEigOHZNLtGg4f1OwP+4BN0rTcSaXROqNEmsyG1ezM6834lJd++FSpgTsJhxQout7/SbsbyCpZUfAnscVnxdI3pZ9JmMxsuBHQHoiT8YEeqJaamy9WMQSXHaC+G+KldEh3yQZiufTlBmJN66Sa0DK8/Z3cR/70i4dmrKKQVkdGL9wq0mjTZHB9m6/wUDPI0ZsfMusxnC2vTVHrJG6BVI2xYLoUhCJjFb3lMUiI4DrtWMct+ujQi5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmVawI1aK5nwKnliuxxipUw8DDvW1KTXS4pv6lUoYPQ=;
 b=eO62S1NXvwXvgnQwBRnBUklcUIBeZscVZ4g6dTq9VPAFJwyaCBfEFywTF8NVeU+LfkGKDioUrTE7XzXPerhTOqxA5V+BvGzWrU7Do4I8YZ2P01/OZGbkV2wwZyiKCyfgY2m0LEuC6Iic8QAUY0W08wqpSEUQiHypOWmJyDX+aqn6vpyilfmaW49ePdACLqztqekyWozk2bzD5R4DsYgBw8kqi25SmpJ2Wvq8LFqlqDyPIjoZX6q8FejzKFho07hUxcaaE5A9OSKe+eGA4SDlwCZ+EBIMbEBBIyDuvF6x+m3TwPtdkpDLo46TxuLJFHXuY7MU7FyeUj539BAyJPoVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmVawI1aK5nwKnliuxxipUw8DDvW1KTXS4pv6lUoYPQ=;
 b=JWAKEbxhnBXqTu39zTbYnYJ7ufy0LR7h0joNEl/Pro0swgkRR2qG/VtP9XaelPbJKJZ8KxGTckH+nJad4xWfIAw3f4HRQXOUxPvG8xLAhpLEt3n9T3Y32cc98UWI9cp5pQ//NKDkwPdpBmTZUKLrBKmuoSo613xr/EVwKZ6C9jjsmKEl1mJVR9FiFpc0W2yR1ursJ6rOKHOf3LhRHYwjZ6LmK5Wt1D0/zfUrHJZqcvIt25JKRyvQTpT5mDe9ilyDKyvIgiVdfoJybVkk7J6qZid8yw7OEsYrdGAXwgIZLZSk8sJ1tSg0Ay7K6jE5ajBUAyNZNkc/HtRTh99cZjHHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 15:43:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:43:47 +0000
Date: Tue, 5 May 2026 12:43:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <afoQMBK8wFIVwMya@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkUO56H6KPy5afA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkUO56H6KPy5afA@google.com>
X-ClientProxiedBy: WA0P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 499eaeee-64a4-4df1-1e48-08deaabd1885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gCOvB2prCAMNJc3Df1L8y9A8IZj4bveGFex8lNHGHWjyXUjn+gWXmNtLoScb6K2X2q87+w8UbDO3bO+eN5rlPHw4/wxpzPJUWZfGFehgamogzoCFfFbA7cq3+fJ08JxbTbLndNKVXLjLIbB5qmuRYcLBbPpKM2uSUcK6N3XMDhgCvF9WOVq3fCQQeLCkSnBzH0WMFdhc11Fl9jKqPm5s547NiRd/+LG91zHx7KP5sNnWh3sFWC/IWcuAMHL4jrN8CMXJ+3FRdjXNW++m9s+8dn1F9DwBXIHaOFYnhmgtV3bFVc21al+xYfuzMH1o/Z7aLMu4MZX6V1OLkmcAWwSlEGKhi2q/WMatVJxHfH/MfJu8dYQmVnn7pW0H326pjCYN9pTqdrfR2xTlnQCw/M1Btau/ejhli2ogQkXRgF7YjWDKJ79guEGZt/yYXQx+0ADpPG54ZjARWr2zOFG3EivwELGAO+QBhiCODL5i094nIxaCXOKHV6dmA5cn6XThhkqPJR/ZSwmvF235QK//i1DgJuCosrOFrnu79X1I5XbbIY5sp3LdKqEz4EA184HLGzcEXlAxUnOxFQsm3ll23DQMWgtT2b15oEBKLj7ZGupqGpw4B82LPpwDdyecvkTRaHKBO48CqOzgYgSQjXEFiHPRQOCFJJrfGjOt63RuMR6PMml92B7jfNp2oDFJ7O4jVlDy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H79FEiutUGnQ9VZ26A2R1CV4WnuN4QmgB4X/7kuFz8aCTUj3t5dKBbCqN5p/?=
 =?us-ascii?Q?TuGehrtSFEKx9FYWruLDC+cuW7Tpu4EL1cVXKqh/6K3xzWbrnsT/KZZAtx+F?=
 =?us-ascii?Q?nxdEKC8jTGsq+GhPxVSy+oZmXIzldCyR6pgRlCQBw0Nje3qu/k9VLBXa8ufX?=
 =?us-ascii?Q?73hcp1YRE37NEVatGDNstiIPIODp87veHjM4dZqGrp3y3ZuU73GAVV4kMoF8?=
 =?us-ascii?Q?cvNqz30OBWQkrfl7Xmm3q9QHKHAoTaNnVBEbk9UuK13FvTNXsC5yWDTLMOhP?=
 =?us-ascii?Q?4CvzFs+EEn2AzBjTAvAbAKzxHR1Icl334LXMT5l7DyPv6vPsP8jfBZX5/x2Y?=
 =?us-ascii?Q?doJdI2cTkWBTbb7PLR+6uJI//T7tkc6LpZ4K4fzh/oOMSjkWBNhWpeeJh31m?=
 =?us-ascii?Q?EiGpTGRni3f8DTo0zGq3klaM02+DzMAT9XWEt/r0dUp71ZREG0cDSq0E8Auk?=
 =?us-ascii?Q?BwSqBU+4RROUR4YH6pz41rxMXiN0Q10G76uk2yaIcMFdzNjvq1ILxBIn8z33?=
 =?us-ascii?Q?qkC/Eq7yldYP8iP9wmFwifCPJ0tR2Pzv0Xuu5qYJyWGWcUDMq5q/jyJXmRJK?=
 =?us-ascii?Q?Ieqz40SSJU291XZ9DACaVcFkDwXX6gafuxCahfGCSnod+OU+RRTYPzy58w/E?=
 =?us-ascii?Q?cyzctoeVcN6brwx0G+uRXBtAIGATHXlvEuXQ9qhai9pw/t3TYS6mP64uIM4I?=
 =?us-ascii?Q?xgB6RSHPBnCCbBM12pmmgOw5s4tSdugskxmcsawtq0kUDqCUi+s8gVTOfCwc?=
 =?us-ascii?Q?03hUcbyLIFKjC8Z7sNeCIy2ZEaCcrwrEs3Vk9i3F9vkLEf9/dPaW1LXqnQMm?=
 =?us-ascii?Q?GDAHxjGkUkbp038IpvCNm89GRrLKv/3Crvz2/IQI24uk+pjlsakZjZa/jkbP?=
 =?us-ascii?Q?rAh6e6M//0CInNNnAwVvm7biTnEigTZSsQsK8OHSLN6xauxb9cMbwTAe0FKc?=
 =?us-ascii?Q?uBdKaFZa+ie+C3CbKj42/D6V2Cn7sEt0m8xeeOkr7FFQw3qow0+qPMjl0zy5?=
 =?us-ascii?Q?4SS0Ix4gHCF+6W5u5CcVQwXVKXciVPzeIuUYAZAyV9LMJN4vtBF/TUzi7BYd?=
 =?us-ascii?Q?wBYtx1clljbkjjX0zuaaRSpN0vVFpnvAu+8KThs5sIsKDRO4DxSsSP/SjXEO?=
 =?us-ascii?Q?6L8zf06lbHPGPERgcdC8M/2/ZgUz+ZMooCoeXH+lPQrq1UELSmbDHZINBjga?=
 =?us-ascii?Q?AYqg8RqTf7WMhTV7H7k/aWGy7Xl5vjRBy4/zwOi1OS2qO0YghjF5IC0Eb6XE?=
 =?us-ascii?Q?QWW1MEafvPLdabCiUgLv+dPtyR5lm/tLWuEicfeZRZdXSDpvDsNKTLfzgjRc?=
 =?us-ascii?Q?XoKdQOrBfVCG2xYlvgZDVV2HQFqtVvjWRxMF0wHAFvsrHH7W2iC74d5bS292?=
 =?us-ascii?Q?Zu6s9wO79n6bM9lseIw4+f4zIbaZS1v4sfZwrqRGJHoXoyFnA0JYqVWM0Ak6?=
 =?us-ascii?Q?YI/UPL1HIYf49vpAcuFcjD4x5gwKxElCG+oBIHUcke5A16MbYiS6RhC7w1tx?=
 =?us-ascii?Q?0FQeY5Cq02xV7gK39C3DOjdttxCAjco+imR+strRyT1wAMvt/jQciKHVr4Bt?=
 =?us-ascii?Q?nW9ElHVF3YGHbdNAn6cn6C/RXP61CwO8gSnDBQ2Qop8aWx6zJ7adO+l5OXY9?=
 =?us-ascii?Q?sl12MLj14kGPMyjHy3pc8/nawnKtgP/a3vjulWJYWvM7v3pELChlshdm0ezT?=
 =?us-ascii?Q?u/e05IiI06vlYOHEsD4mwa/0GcKXBJl+JK64nNkhD6X3EoHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499eaeee-64a4-4df1-1e48-08deaabd1885
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:43:47.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osSNu9z5zfJlvYHxnkVoVzzKQZssUNZREsnV1QNTisy5R1o7fIGjZVj33ufk5AXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
X-Rspamd-Queue-Id: 2B26F4D0754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20019-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

On Mon, May 04, 2026 at 09:48:43PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > These are needed by the VFIO mlx5 selftest in the following patches,
> > which includes some headers from mlx5 and also needs a few more
> > MMIO-related features.
> > 
> > - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
> >   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)
> 
> Is this needed? I don't see it used anywhere.
> 
>   $ git grep DECLARE_FLEX_ARRAY tools/testing/selftests/vfio

I think it was used in an earlier version, I can drop it

Jason

