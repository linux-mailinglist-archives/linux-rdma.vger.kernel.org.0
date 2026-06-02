Return-Path: <linux-rdma+bounces-21603-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCYKDU4iHmoEhgkAu9opvQ
	(envelope-from <linux-rdma+bounces-21603-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:22:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8162688B
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 427B03006011
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 00:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BF829E0E5;
	Tue,  2 Jun 2026 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xe3XJieY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A763EA66
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359752; cv=fail; b=jObE6J74OtXKlosiXtFFrK9KK+CfIwW6z4JDG4/jZmjM6gSzydmuqyj3h4KQMmPu8elXfLwCQv2eyG0Mt6hjTP+yuLVDO2oHW1kCnPc1K/jT4JIYJMHNFcDEBLn92EtdJXpYVp1zGG2B46gpesKLl+wNmahnctXD/ksxaf/QjEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359752; c=relaxed/simple;
	bh=X0Fg+kYw+S0hLcF0aPwur8VaAL+BrtPUmyUAWAAVSIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxDV3mzdMqWtGu+xp2DlaZi7DYkCa6pnFZB17jKRWY85A2gUQk8912mG15x/r+w0/GWShQ5+JAQcYDsvV3sqHK9rBop6OybWoljRWc5JERB0M2RacG/ue8syiRxPMXN7OFodB5o4TzzyIzU0Y8sLUHIQ8BSCLR1ld2wrHAEQWAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xe3XJieY; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+Pf2t4R9qRFLjjm0LmoxSQUKovocmYmnoxKP9JlNq57gBzMNQuiHGrGB9mW+umd9oNtqjhXe/Fwg80yNcgMfpfRLr9+JXljD9QMUEyuwG6VkPA5zcfJp9JHs93KHvd4rpRmuAtxwLs5X0zgfYz5BrkU9FSCtsJpboK8Nx37I5CESykwPw1IpoaVHdo4DPGsVY28aCs21BzhrqcmbEXT1hfpGE/4ZqrDBCEsWHyA3e1DXqIswwTPvSVYjIap6dkBlRG3KjkYNhqDExu79xtoCC+cLvKgywvh2667sjD17un0lnLeHW4HTa5cvLCFyzqc1klucEzU2oRp3UiAHCAkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0Fg+kYw+S0hLcF0aPwur8VaAL+BrtPUmyUAWAAVSIs=;
 b=qQuAtsd2+xtCVaOwuchPPWdni2pzjQMVCu96OjmzTdUm6tNEhfyfOctHUwKFcLj/9tX1mzV9HfmgVvPB/qPx/T1X98w02NsfLFP1nl3Q1Qg1+pRzP1TdYY6+g/fOqxYIJMBHQbugHT4vguXxNElhZvCISuAfcmx7omidDVg53+G2LW4d1tvEMrK25NEH//gyOhoNfeJDT5M0goFN7FPenfCdLTXPQHkadGgbF184NCEj359usauGd1x0YaZtroCPh8u7/Vd71HrHaOW0HG7uynzJsaktKovGC2MzezuYgkCE5xVn3ex8vNzPlP+uYJT5GBiKRFYH4HgkMoE1vU8qYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Fg+kYw+S0hLcF0aPwur8VaAL+BrtPUmyUAWAAVSIs=;
 b=Xe3XJieYf4O3D95i8NRZyvvPqZpYjx4DOSREPsuJj9/S6jve8oUvDjepvY0SZrL7l/i+QxJE0NW5Is1WdctZH47rXpW64/LqO8zW6Ij6D2cu3ZUE+iHLNQmtJ28JwQbilnFj+QvpiSqPmM/SM+BwI5jRNACviefW/5blDXywPkiYNzo1M9FyMecdj/B/divwdXZcS7MUXi+5jP7Pw8XT5qEWviGkSmXa0Yf5699h+jhUbyMNPo2Zni+Tc6XTbzclnPAZnL4U2D8sp6OBMextYBlm9ZgWucbhUBc/rJOTdn4W0B12ALkfuCVIA+veZ92aIR6exxVIEU6RsNZpIq5gFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 00:22:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 00:22:24 +0000
Date: Mon, 1 Jun 2026 21:22:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Sela <tomsela@amazon.com>
Cc: mrgolin@amazon.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Propagate destroy AH error
Message-ID: <20260602002223.GA644685@nvidia.com>
References: <20260526073334.24905-1-tomsela@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526073334.24905-1-tomsela@amazon.com>
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb83294-56ba-4e2c-404e-08dec03d053c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0hXJvpAk6jtQd4mzE9ovUixhVQAzXl7qVw4aVR7IDXUbzLmdrV0yLGMUaoSOhc18XF7/9ZpgJ1Nppu63TkHtPvn4rsxK5fNNnJXXqY3HIgdITvT8ut5HpFDxQIbE/flZm/uMo4561kkWGT42k/wS7WhOSVrb1o3G3dEmyS15YqJLyaomPkOJM2+OAFaoDjC3r4hDjTBXPbWKhZXGMHKAHIJGE59uuAbb326VqIeBnqwPN4FV9fJPNy5oePzGeZaqGWOov+NqC4ba3q0i15y0CiG7ewX4s2rQKK4arm4ahPRlIrIHzn4JujEw3H7SvO7F6nUQg3GDZGe+qMx8Dpi7CKDQz3GaxXD9vkShlDcs0AKjsHflnQWQA+qStIjes35ipd+quMuH1rRp2ZdpFNjnCzAsgYw2tcIXF65gokitAoD87pMNmEav0kZR+Zctf818kVraXQE/Utt951UcICtjD9Z51DjgBBlxwrDjIYwZxgXKd94xSHhxAi7K5cwKuvaWX3dYZjnjEQvvTYhtFL/ZgYmvSUBWNy+qhopioTWaPE7WtNFdXBoEv7R1qOdV9b1qP5ABSo1ay6mCWr1JU/e5PGBmNPrBRfiQ4abnLKQzSyT3CClg3P+kswo7iJ+M16cp2JQC4n4ZrCuenLODnya8XQViuD8gmhirCigY+26fufbPRPBIJl7MrOvQ7xjJA5io
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wa4FQCusnGuOEEXIQNQXXo5R8hg8viM2hLm7FYnB1RpRmZ+3nXB92CWOJiB0?=
 =?us-ascii?Q?pC0wbmjctlghztcWlc/G80AyV7t/mZXunUqItbexPyziqvHwo0kbIRANatGF?=
 =?us-ascii?Q?YCA0yfiCL2WiPU+sq4wOHBXjulDVHMM0NwMCFIvyzqHOoPA7boS5qpNAqa7e?=
 =?us-ascii?Q?OrbMEuJoQruYBtXwz3Zj08T56y02eM9cZHiqpgiwkHWxvXcHhJyvGkIoS7V2?=
 =?us-ascii?Q?mE0mw+d/RTFRb6EJaOS2x5ryq2a8/06FZ2CqN4D7k+oL9GykpHops5GZ5lWf?=
 =?us-ascii?Q?rifkf2Sx2EqLEF9ZEO//UyGWqfFQ0uIL9y5NM9tBBijYXbLSgOrOO1vsSV+j?=
 =?us-ascii?Q?6rasoqw0EJiPiRUlBb/JrsnTTVBjPbRukO7TLE7yXI+tXDfzvBlgdnQxqbvY?=
 =?us-ascii?Q?vcy3/sJE21O9v5o0WfJ4XNSwQ//ZOHQPsAfKTlAzVaFeRTE+LojlWeEBO7zO?=
 =?us-ascii?Q?E4VXOWM+NBhc4UDixIyQbZ0PieIn9GlpVok/zcAWeWg3lZuL59LLNUMs7q93?=
 =?us-ascii?Q?EFOFw+Q24pdqDMgH+LEQIM+s0/0kqavc+q5EWuFbgh+J+E+SeHUFNnEK/sTy?=
 =?us-ascii?Q?7RtOZV5H+uvjMgihCNjTAc9cAdIL8AsjcERwjOiUCGinmp4FeYGG4pHFGsPP?=
 =?us-ascii?Q?yW4bGbzbryxidGRzDIEMffnwn6D2NZVwkzK2srL7yeL87DJm2H5HN/YHmpHe?=
 =?us-ascii?Q?V8mwtwcxV36DgrLm49VUVC8yp+iGViSoRXU0PufWVf0rNrs4EjNeO4hc23i9?=
 =?us-ascii?Q?hn5CQmzZQ3ukdYAJeUSAzegRffV58y0iub7yNfa+aVthEl82N+PMzz9yJSxq?=
 =?us-ascii?Q?Gg9j3Fdpla0a1x5tUGEgIgBuLPhixkNDTALyogJgg7sN6rSclk/7NRmt+TS3?=
 =?us-ascii?Q?1zhEmGibVIfTIrZXLYXDAgZZqMD2MQ+wQjh0by4QFA7mO2kAyCm+xipmTCeU?=
 =?us-ascii?Q?OqwfFwmRSTs4iOdBLBAhOK6XZYPzVwBtfrWqGf2udy7J9X53G3L/C3kwQ2ae?=
 =?us-ascii?Q?9ziA91nyKT25fo2CE2g18UxvyLirT/cEvnz1v+OWWgjwLyEVzkVcfuRONwsb?=
 =?us-ascii?Q?pcXUHd2b26oLHGA2pKdY66mZ5RHfgtw5kYh+raw1NKA8QLsB0vuTqOxPT4zj?=
 =?us-ascii?Q?7el6r2bWv2HFx9zgRabGDo6rDRbwMLC89YYR1C32e1dfO4h01EM7FSodEh12?=
 =?us-ascii?Q?YU7WHX+S/wuDY8QcI7UNn2kcpHyvBmVHJrQruTjuwDaNogOXP/5LuoKZDBgl?=
 =?us-ascii?Q?W/vXleFNEeCosB+Fq3bCrLJliaJsNroS+qrXXVZAq0SN/bxta9TIKqsQUWaL?=
 =?us-ascii?Q?SNdD6h+8gWvRJENjP6ldxZJK7lqbsHw1QQEjFAEnHX8eGMTfr6Jj6k73tNRA?=
 =?us-ascii?Q?0ZNtDsaw5tBjGEg4XOQz+oHY8V24e253/9q8JthAUXv2qSBQtS0ERO2vW+RF?=
 =?us-ascii?Q?2Rmc5Ym31SRbPkmTwHi2ZBO/wnXIdIeUY2LBcGAaVYp8NVfgsE/TTwZSCj27?=
 =?us-ascii?Q?Q2ZhOJStKuQHIPZgc7XAu25sijyShK9uZUu80EvqwAjHnDwMfE5+SuaIMT3w?=
 =?us-ascii?Q?TKqHP2YoLLwYMMmj6e8rCxMh161qjWbOgrLF5u1z0zcKvyjRunD0ZDhqbd2D?=
 =?us-ascii?Q?9eAANdGJJ0ygHB+gpbvvSoOOacOg2E2Ck6IMN2WGi3973jvyknddvX9BnuNG?=
 =?us-ascii?Q?8FxI6AGBGvjioBs9rGL2kFl8wYmc6NnK4b42fj1NtCCW17n/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb83294-56ba-4e2c-404e-08dec03d053c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:22:24.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uxhcagPQuxkfmGEJIWxMOmnu+Pyx9a3grrLeyqS/2lQSg43IMOqGN1XjR+pBTs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21603-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 3BD8162688B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:33:34AM +0000, Tom Sela wrote:
> AH destruction currently always returns success, ignoring any error
> from the device. Propagate the actual device error so the caller can
> handle failures appropriately.

Callers don't handle failures. Drivers are not permitted to fail
destroy, if they do it probably will trigger a WARN_ON.

You can make some of an argument to allow failing destroy for user
objects only, but not like this in general for kernel objects.

If your FW fails destroying a kernel object then the device is busted,
you should reset it and succeed to destroy the kernel object anyhow.

Jason

