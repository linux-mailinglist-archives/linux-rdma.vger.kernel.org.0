Return-Path: <linux-rdma+bounces-21839-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h2tDEAzgImq1egEAu9opvQ
	(envelope-from <linux-rdma+bounces-21839-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 16:41:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFA648ECA
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 16:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=K0y5APHg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21839-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21839-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739B4301D314
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D183B8921;
	Fri,  5 Jun 2026 14:31:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40633B582F;
	Fri,  5 Jun 2026 14:31:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669888; cv=fail; b=eXW6jvDTdd1+91d8lHmPK9A9iECCW9sFVsNeeX47FxOvn0eYwqkwx67Bd9RlNSLGmJv7V7gMDHyHc3qkf9LjXz6FUAEsX3JxwTpW3MmhFCypinfRoBgC0mNrN0GCFd8p0JCvNCyAk7G10d9WJfuwJHByn+WujLG5NuIzRVA4Bfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669888; c=relaxed/simple;
	bh=fPV7xsKxQxFdN2ti6vwUU8Opk65l2n0AWMOJSVdKgfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EdXvDtxF99wLljIkMucWNG9PeFRvBmI5SYxv4nkEGh81n45dK2uyNsHXjcvHemvLD7rwIJBHSXBaYTPOaf7WanNhrMo51nJwmudk8l09viSD752Tnq/4tyWbyRvdDttQTnzR6b18vl6SehAc+OK1OCo9H+l4JAh/FEa90GUYWGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0y5APHg; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdESV95OEiLO/r/RITknG2u4gFFYORXZ9TudjwVbvxwQqRzulLffykNHklpUlPCN3elt+wnLXQCwMHQLGpu2fgO4r/krRrfKqXPhkrDfKGIw8Y3dBgX9BGbey2Dqpu6rl7essTsCEY0c3O2Ic478KGj5i9E23cGZPQIS0s9LJdCSdFhFhk65AXSak17nok7TMyeYqvTGyvrtA0FJdmTAX+spDDW+IO7MAm2lzdk/kbNtAI8I/9aBE7p7VHsnWxB/m8A+iE81/RMznBieNgBNtczyP4rCC0Jdjp26p6Oh6xEr1ynjWuZl5v83bidT+E5Y8uardFDBq7XKnvlHlcjCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClVFReKgLlvhLMls25eMwrZPttdbNJ4yE6wNtdoShCM=;
 b=J1RCP+uQkGMtKWAf8SbAbAgipafS1y/yasGxRq5edz6uwDLMf/T/wcHa33XjPC9gJ39Enlv2Iz3A1Hs844pa1G7h08glMI6ht0GElJbheDiBC2plpFgOSKV38XdC6hXB1jq1fCk0PF/6ASPnUpAbG2Pp5hQ3CPRtauQur/zm3+MdbqgvBeq78G7zAM7O6dHWHFIT0l6M7i5bJibVFSkKYOmUVId0zzn3J0G6ACtPRBm0I9nfSlVkiYkvEiu28EegmAAUraR/vr15ac2y0YJ7V22SRZfPBrO8EQyI1FUImQRZnFMkLmwHK1N53PlOsLH6q6Q0bMBXuICVw5TR1vg1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClVFReKgLlvhLMls25eMwrZPttdbNJ4yE6wNtdoShCM=;
 b=K0y5APHg2RS0ANxZ8VyWDA7CdAe+GFZEs6WNlJjVzgF4pSq1yKHwiHFo+rpzD36MnNViKjyfe2tKHsmWAxJ85a9XUN7X6U4No+J4Epdz/P3Gg4GcrVeCyxCO2Xfvl6P0oci/z79SC9fWJ71zXiYdA/UKeS/kMWLq5ZIKeNJP1lvshI8ef064yzhCG8luwj82JpErkOWyzpfeurP5HJ24SB/mE4tnsgMbalLlFtUfANby+tKdcz0Fh70Rz096xdsiBwILYbmuszlwe4Q2ZiAOCY3n2AczSDPMNkAFWN8xlspSHI8Lz3RE/VROJAIBBQnmoWkSZpTz6aja6VmqO/qBZQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:31:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:31:20 +0000
Date: Fri, 5 Jun 2026 11:31:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <20260605143119.GC1962447@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <ahiFxtmspbETiqWw@google.com>
 <20260529134947.GA128816@nvidia.com>
 <20260529175516.06d5788f@pumpkin>
 <20260529192933.GD3195266@nvidia.com>
 <ah2B_mzQabiEYSWt@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2B_mzQabiEYSWt@willie-the-truck>
X-ClientProxiedBy: LV3P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH8PR12MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: bdac9edf-0cef-4b93-df4e-08dec30f1c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|4143699003|3023799007|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b8LQl8b7yc5TEaXhiQN8+YvJH/COhusWcI4cYDJujuPs0XX8S4OvA5eOV8aqd9jhNatlIqGD0dp8HCC+PidKou8+aA80emT/2zrppt/COhqij4JsjWJDXm5vbpMDImp9qX3VjAxhUkVuJgY759/qB/YGT+wPgKI1yXcAAi/CMcvAUevEYr4mMyfQsALLXvUrBn1A739jNj/AimXJEiuqI1APN8WMc2q/GwamKINIEMjxAh5gLWZ27lcFNl06y810m83jr13YXhyYr+BuZbbLtiq+z1wSB9ajfpIZ4qmmuwbAAs/6DCkA920jGutrz9pRQR/8z8JzH7fUq8WYhONcsuSGyAqPE1jBKYVYkfhItnOtL+b+F/brq6HRoZSHqU/+N+sKnAhpvhDCzsMxSBJSYYPjdBpmeYs09DKAuB88QicGwsmVDJew+0t8lPB9FN1eiD+IhGihl46XEI4fjG/EZ8qnChnGRbp+jFPnZkQ4muvzJsrIntUn6UoNVVDRmqpeaiZKvGPNDHh8dYo1p+4qWF2CJOyAMyZ252ETdZFnhGIxH5o54E8p0x8dO64fJ+mCo7sWW6btZn3u5YoIE16/1oKfbowJFn3ChaO9cHrirfh2tpGD306C64qyhRfRVJ7UALLYeoEnzmH4xWowKYJekq2ECU/2InXcuKzCofq0GTn5hG+RIPm8/+eXW0SOi7XD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(4143699003)(3023799007)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?taDoa1rMOXP2qqYncIftsH912Ywv7p9B16ZqLm/F/oN0jKLzIvhtF6ksvmwb?=
 =?us-ascii?Q?747a/TDAFnz/d6znnMZmu8YuzX+O0EW2QxzKk03dmEeCt5Y+JviwslqYBwFK?=
 =?us-ascii?Q?MThxbZQctCsd9tFmXSioSDijnEpBEVqv/LLri6xcdLWWsECII8hdeTZGpgrp?=
 =?us-ascii?Q?3+iV9w2kmmQA1RrZ/gDvr7cEmfxULD61CYZ6nsAog7rb9K3DxIFCOUVpwsrK?=
 =?us-ascii?Q?KSX6P0TWRPkbM0pqR7/oxb3p1bobC/Y/BWoQZYh/oCfIzxi02jiVKPXngG+f?=
 =?us-ascii?Q?udjTj3CClqhqoZNJX4cfiN+ztf18X2HrAAzNNBG66/H04ndYR+DYle7iiCCW?=
 =?us-ascii?Q?hWMdjK+HkRBtqYEayo4cDVCbJzojtU2+Rc9YgGySUxmnGaRXVs3fh8rL4TN6?=
 =?us-ascii?Q?/+L3hEYSvcWkqblOMWYfzpD1W717u505OgoIZyY1/nYrm8H1ttNnIP9n63Rx?=
 =?us-ascii?Q?2UXTvID6xjl48x3Ok0aZ9DN5rn3+Wd51gjjuoJI2Ub5ItxMOWBxA2E1PRsut?=
 =?us-ascii?Q?PdKzlJM4VyZjGqXNBBwCK5d3cMTYYrpqtWIRydeGTYmgMN/2CmzfDr8HCosI?=
 =?us-ascii?Q?9N8atffSpCSXCDUmoAPJp0lOBxUOyoXvghTW5g4jIUZYo6+14lEvEpQTJm2h?=
 =?us-ascii?Q?jFJd6tkfD3rfzRsD2AsbQ7ziYdBC7QeC/7cFF05mlL20u3/EWfO0m9nr7O2M?=
 =?us-ascii?Q?rxIoTntC/JFNEhwtmLlXiWgWAhMbkQtsTsQQyRjZC5FtaxE/RDuF6RAzEsfk?=
 =?us-ascii?Q?JunJ5Ihi1mKLbOly4u19ALcwPR0yHbkvgL2lmUU4gRamQD7swn+fFwVyqbHM?=
 =?us-ascii?Q?FnnxKAzArqUtAUGF0zei7Ccnon3o0V8vyob4O4y56fYjpPJ0NSTZHjsmdKOe?=
 =?us-ascii?Q?L1syuBt6EMh0lBtDYJtR0MghqCvAQeQk+SSGto8Ccuf9M4CIiXOj4XMwe4Bg?=
 =?us-ascii?Q?imgnrQllVRCccmywy4PZr97tdtuPXpZ5Os5Bn1i8dlbdnqDf7/Dw09wDoVQI?=
 =?us-ascii?Q?JQLmp0WkJ5/Ab1y1XUa5YWCjoJ8SXJcmPtXNtouHoDU/io8LBAv0twahcokf?=
 =?us-ascii?Q?l9mkaaiCU6sA3XuEPbYui0X7LilvsxNiU5JpKBx+Mzorg0WObnh0URbQLtTr?=
 =?us-ascii?Q?ML9pP2vQYjatsxlN1SrgUALoQu+I91ZBBlln2HZJ3HyXqrNJTt4R2UtI48Zh?=
 =?us-ascii?Q?MZ/ZYqJnzrA0pdxL6kSxR0SzsqqDPyyQLXEI5lnMc5O0VYwqvBYBx9O4z4EG?=
 =?us-ascii?Q?fEek9Bxx29KfvS7Zuv8Oga7B/BcpS9vZmgAasFDFOGa5bQDHg2xpCKcc094U?=
 =?us-ascii?Q?ZYQi07piwM4tyAR4u4e+r5CcBw6xJQ1FYhOHja+lwZwD50T1VWfdLkhQbLM/?=
 =?us-ascii?Q?8rzuvHDhh+iqLXJux/4lCf8iDT8MYogiYmocceyYRyRDaig6FPciK7aLNaPp?=
 =?us-ascii?Q?aB8HXKJsHNCoY5WLir8TKtwRZ+XpK7Pe7mOA98CufZiJQOSLJ2kKjjtajwne?=
 =?us-ascii?Q?aMvE/CPUEPfQwbflNWNWytN227z4HAClqdW0sxruZuaSB7lDwUGntfj56GtH?=
 =?us-ascii?Q?Q+q3NOpMx5e/zn4ejzDnFxIdkusJdJKiBulZkbDbCS4v/mTOucALAvi9rlTw?=
 =?us-ascii?Q?wF1wKYzg63aY7HrbwqwQQvpuAJC4g1cnL9ctCqgu/uHXvhUIGVpkydVeNnTP?=
 =?us-ascii?Q?H9Qibr0n5hAuvnSydF7iKhQfw3ITQGCdQgKYFSVYEXJ1njQp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdac9edf-0cef-4b93-df4e-08dec30f1c43
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:31:20.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDa8sATVxkNFCZb7eRcGVi5Bfno5lcjLtmtoFbAIVfySYvCHnPeFojMlKtLyf+4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21839-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:will@kernel.org,m:david.laight.linux@gmail.com,m:dmatlack@google.com,m:alex@shazbot.org,m:kvm@vger.kernel.org,m:leon@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:shuah@kernel.org,m:tariqt@nvidia.com,m:patches@lists.linux.dev,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,shazbot.org,vger.kernel.org,kernel.org,nvidia.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47BFA648ECA

On Mon, Jun 01, 2026 at 01:58:38PM +0100, Will Deacon wrote:
> On Fri, May 29, 2026 at 04:29:34PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 29, 2026 at 05:55:16PM +0100, David Laight wrote:
> > > On Fri, 29 May 2026 10:49:47 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > 
> > > > On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> > > > 
> > > > > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > > > > headers are more aligned with the kernel headers, and so that the arm64
> > > > > io.h overrides are done in the same way as the x86 overrides in
> > > > > tools/arch/x86/include/asm/io.h.
> > > > > 
> > > > > Something like this (untested):  
> > > > 
> > > > Okay, the disassembly says it works:
> > > > 
> > > >     1db8:       ca080108        eor     x8, x8, x8
> > > >     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
> > > >     1dc0:       f9000fe8        str     x8, [sp, #24]
> > > 
> > > That looks strange, I suspect the C didn't match any usual pattern.
> > > Normally 'tmp' would get thrown away and 'v' would get kept.
> > > But you seem to have discarded 'v' and written 'tmp' to stack.
> > 
> > Oh interesting the optimizer isn't turned on for selftest builds. So
> > the str is dutifully writing tmp to the stack. Another register has
> > the actual value.
> > 
> > > I'm probably being stupid again, but how does that work?
> > > The cpu can speculate straight through the control dependency into
> > > the following instructions.
> > > An 'eor x1, x8, x8' may not even have a data-dependency on x8.
> > > (Most x86 cpus just generate a zero for the equivalent instruction.)
> > 
> > I can't say, this is copied from the kernel and Will made it:
> > 
> >     arm64: io: Ensure calls to delay routines are ordered against prior readX()
> 
> This is specifically for ordering counter accesses against prior
> barriered MMIO reads. Userspace should really be using the vDSO instead
> of accessing the counter directly, so you could probably drop this for
> the tools headers tbh and just have the dma_rmb().

Okay lets drop it then

Jason

