Return-Path: <linux-rdma+bounces-18543-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAwGBzm3wWm/UwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18543-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 22:57:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4162FDFC2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 22:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B12C301A931
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F69B3815CD;
	Mon, 23 Mar 2026 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Mv7uF6DS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022143.outbound.protection.outlook.com [40.107.209.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896B3815CB;
	Mon, 23 Mar 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302867; cv=fail; b=kEPChj1WuClUX4SDA6XnGT28SLg8I1C5q0oSHwMDzh9Ba+C+t5ZrCHxwGePU77RQs8IQJ91dXyyLXYzz9I6yj5ZshuWsZ3eNms5TwV3fWGta038DSeBrIIXrexqCPE7bp8q28ZZPjaR8swq0RTBQtJ94WRR4JVLLkDem+WnTvI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302867; c=relaxed/simple;
	bh=GXTIK4Xh41+vf5rpJeR3G0JMT+c/BrqJLB1xoj5Ye5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4BOWSQISrxmYGPsHxOIuTkU0CjStyrGkbTg7Mek5FfNk4OTxkA2wer/UkkQKBT3noDjD7WNT3WgtF1VxCXLVo9ld0DCYf9tTNyagoTSKmbsB+xm1zIHCczZVGvdkxPPzOaLA6y4TE6hZ9YTQhMcXXyH9dawHhBxJ8ZP2sMWPTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Mv7uF6DS; arc=fail smtp.client-ip=40.107.209.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyJBX74kWBTv0bE9sE8PsjK0xu6pTQf0zOV/Jcbfqyu5jDC7ovwVjIfEuiinGiFvYqb8qW4G7a5EtOf8zRA+4RFELAC5bsZhUZXt9oMCCFvpgfAg7q8py/iu8xO8AzjVtiK+DviWabBY2w8klmBNigSX47rFgWp8oLSV90dD+7K7uQermKGeUdMmsui4T5aijDkQRX6jZqP6TFcgmnwQHwXHMkP7QrRy1h6ybD9Epe95uN7d3WJjYptUJm/QnkzMp97t2aDHFGEBSObtjGufjffDMU1u+VVz9p09DYbAbPgP3kmWBUIl3Qh4XVIo662HTTts+FhHI/TqlbG4dhF6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a82lksIV7iEgNfTSEQLSFaarISYf+9dzjz17qaqKXCY=;
 b=hMStEhyYs+UNKRzRJX1WO3IXzXPuDGHJkSK1PITtGlSfJ2QDYZJAq+1hF5ApWhqvADF+FV2BrzoBa+w42NyUHg6LGQ5w5QovNi349wQV8kiOETLvd/QcRPeiJXlZmlrm/IVKgVUknllztOaTeLDKEuAZKTHWqWrCR7GS1RBTijVIfR7WVwpr5Csb/8ZjgkSOlJgwbD/dugT0f2YavQ8kbUtWf6BTwNLh8AGudeBqaPwDhNETxvW+mc8lYoOaMy258LFJbRJNitwD9idkmcvnzcjwIgcP29y/L+7+GMbU2NAqbSoYEFGYdWzF005/5mwvaa4A2wQjQh1cZ4jd+HEmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a82lksIV7iEgNfTSEQLSFaarISYf+9dzjz17qaqKXCY=;
 b=Mv7uF6DS5DEj2ZSY+cNAcT9GMD79d+GJ24qs2qLLA0BgND3xxj739swjF+gxz5Ve0vkyWkSLex3jjRm8ZIU16b3/DXprvaMPQSCTaLAByhLjfRMCzno64QO/NT3SGE6y1tpcUnvIkN/SV9Xxr0WtYWG6aZdxMtthMD5m4sm1VPDq0teciMmblvjV3cv4j1ePRlkjtoHD89NGht0fCCLiD+uKVN6LcwJBAuLn0f71FxqfSlqAZaB25ANsqlhX6bgGtzg1rhEsvnopKC29nqYrZ4z/8BBK4TgG+FEAWt6QzLrmTQw0gkRq0ZcZZ1nWMWvXAGMYEBA11myR1N48CiknPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 DS1PR01MB8943.prod.exchangelabs.com (2603:10b6:8:219::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 21:54:23 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 21:54:08 +0000
Message-ID: <54d04d85-79c0-41fb-9c33-4858cd4e6b2f@cornelisnetworks.com>
Date: Mon, 23 Mar 2026 17:54:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
To: Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nathan Chancellor <nathan@kernel.org>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 Doug Ledford <dledford@redhat.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Ingo Molnar
 <mingo@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::9) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|DS1PR01MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: f092a648-4d5a-411d-01c8-08de8926b5cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GgPSLcKDxM5fS6+Q+RuEPPsgFzr1HMDZZ4IunEsYrrXmi2sQbxtHEi0+Dn+6FxvqibPDu31Z7pHs7EgPA2s+dHCUTfJVawawqOW6iTmRZAC13vo1Qkb+oM3IJ7vCI2bo2eT+xZnPBoy7/tVHt3lFETscA4bt7bMuCRFWEtHFA3KQcJ9iQ6G+KsxkbydyTLolr8QxIT1xBFT0lGW32F4JoWYT4WmWUN3mvKMtv8sVJKA/Tkb5Cu/wuPv07KyfuEWi220xPCQ/IadPI6yUlyL8tckjWmDOJVgLNwk0F8XxqhoNieWSWnbvuwI4gp1T7H0vPpne/tyCg1awNFPj8qBwvKhjrWPYPWa8D3yz5dl/n+esxwc6vfcT1rRkOs7kUmu1WBwncDd8npvWjfyTPLgQ523D+eIvCsMTHf/F8y1KzucClxPIOjHHCcbv6k6Jy17/FZ4ok9Q6Ia2LajY78JrMl2tO0RvQ+K/fFKnMm3GLHfhHU8RAuXZsPhyrv4gzfBEcCxdVI2L2Gturtgv+jvG5M/CJxHzHzxp49tKb5JIMKaKyaw+Ao54VysxRN9l0aUu40SDD7U5/MGkyx10/yclJ/ZMkmNZNCHMeu/6g6cUC4+/N0fOf8er5s4S0Au2197p6hZyRJx0GEv6mNiuCtvjBA9YqQgVuW2quGiuFu39vxY6ZuR1220gmIDatQooqJ50iDv5o6z7e1t3qkMOlZlnfDlvzMqmHPyTOjcCVY4hecuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlV6dXU3Vi9UZ2FZQVpmbVNLK1dPWGZOS0dtNDFiaFd3RWNRUk9DUk5SbUJ0?=
 =?utf-8?B?cUpvZm5xQ3JlZm14TXJtbHEzVDBWeEtFR0lldU5GUk55YW9idElBMHovdFM3?=
 =?utf-8?B?THhaQWlHdnpxYmF0Q09qUWloSFd0QUJkN2txakNBcmdla0RyWU9vcnMrRUJy?=
 =?utf-8?B?cnRhUjZaNXBseENhQ2tLd2FESHMvUUhReU1WM3d0Wm51N29RYTZFNUFoR0VI?=
 =?utf-8?B?VmhNWUt2TzljUW52OVFxN3pPWVpRTytHa0libEduQ2FGN3N0aUNxOSs2OHFj?=
 =?utf-8?B?aFBnK2NETmlOcHJNaGVwY2trazhwTThDZE1vd1RMNHUyZmFDZVpnWVlLYzZH?=
 =?utf-8?B?OG9iMVJyWnZPZ2R6N3pMQWpmdE4wWllXNEUxSWVGL3NrYnBwc21NcDZpNTlX?=
 =?utf-8?B?YURXY041TW9wUXdXTzZUR2xrQXNrdmNweG14UDZsa2JOT3ZSTEsxZ3Z5VVlj?=
 =?utf-8?B?QUFoNzV3ZGNkTjVubjNJS1lKZGpsSDlzNWd4Q29EZXhwSC9ha0l0SXU4UExW?=
 =?utf-8?B?TkwwdU12UEQ0ZHp5QndlN2dGc2VoSldoOHRIM0JMZHNSSTViVjdxejN6K1hq?=
 =?utf-8?B?cld6UUQzazRPdjBEM1FQRlVwZWJmVDR1ck54SXpMK0l4YWtLY0t2SEg1SkE3?=
 =?utf-8?B?WGhJRnU1RVlFcnYwd0kzeFFpd01Jc1N5eldRRmdidWl6Y0duR1A0dFB6TTI2?=
 =?utf-8?B?Y2VCRWxuVWZYNmlrWjNyNkVmOG9VYjVXbkJGM0JNM1IwVzFRVi8wMnlveHhK?=
 =?utf-8?B?RHVJR3pBQStjWmowTGdXa1ltdDZkUnVlNWZ5VGxQZUVzREJ0V0dIYjhyazZ6?=
 =?utf-8?B?WmFmR3BLMGYvdUpyYmNNdkw4L1UzN1RRWnZYOUxLb2RaQkVBVGxxdkxUMDRY?=
 =?utf-8?B?eE95UXBPVTdVNVJnMHM5WGhQeEhPeGp5ZGt4RmdVZlpyZHlralVLa0ZiUksv?=
 =?utf-8?B?VTQzWFpPM3FWY3F6Q2hoY3I0Y2NqcnFzRVpsbTRTMldMSGpDYmZFbTYxdThO?=
 =?utf-8?B?Zlh1cUtmTjNVeHNqOUdXR1k1dE5yc3ZLa1VsZ29mTUxCeVZLdHJKSUxaL0Rw?=
 =?utf-8?B?UWNYSWw4cGR3Mms1ZzdVUm15aktXUlRja2hRUUJuNGF6M1c2SkViL2NUQ2dh?=
 =?utf-8?B?YVhiWFJMcDl0NVhhOE4vSWJQVVVMTmNqNTc0NWo4dExhSHVCUElEZ1lETXZw?=
 =?utf-8?B?YTFCUWE1bzFpQVhFU2N0K09iSTM2bUJ0NE5LUENFNmttSWFMckNUTWhITlBs?=
 =?utf-8?B?Q1l5MW94ejBPanZlOXMwQStsdGlKa1NHbUdjTjMzaVNKTjdCVVRMY0d5WDdL?=
 =?utf-8?B?OTBnd0N1bkRjQm5UMXoyUWFucTJDZjRpV0ZBOFBSWmoxaE9kd0sxeWpPQ0R1?=
 =?utf-8?B?b1FkaDg2Y3g3WjYydFFKZjJDb05oa3BGVWJSSmhQMy9Eamg5OU1ocVBmYjVn?=
 =?utf-8?B?ZVoxZ0ZyTDRCdWhibmVjaUZXeVdETkZFZHJKd1NoVjlxZTdzdGxYNEo1VVhH?=
 =?utf-8?B?S2lwTzEvNzh3eFdDWk1Lc2o2am5tU2VDTGhTV1RZeFNaTnEyY3IyUC9zSy94?=
 =?utf-8?B?VlpwaEF3WlEwLzZkYVFuZTZGYVZVNU1iR3MvQkRmYURyQ1U5cE42c3NRbUZW?=
 =?utf-8?B?M2h1bWR3QUNuY3BBWWZ4a1Jad3AvVjRGZThuVzNoN2VNdWhVNzV3ekdDbElw?=
 =?utf-8?B?b1YzaHpRdkFPcDhjSXhaMkc1Z1JNdGg2U0pvK1RWb3JRN2Y4U1hIMnN1QmJI?=
 =?utf-8?B?VkdMcG1JdjZIVlZyakVjYWN5eDJwZ1lXTTlvOWJ2aFdSWWpOTnFvcncvNkN0?=
 =?utf-8?B?QkI0UXB6WUJXdWI1Qjd1VG1GYVZabHl0NVExSi9YREdkNnFhamJyZm9vdEd5?=
 =?utf-8?B?YWgwaVhkM28wSkNaVVhRWFNqOE5lNUVFVHk0YWZCci9lWlBxdFJvTk51QW5j?=
 =?utf-8?B?bG01OGExdXIwaGZMT0VFRXp2U1MrZzJwdkducW4wZGRNV01Ua1ZyM2c3a0dR?=
 =?utf-8?B?cjQ5MFl1VzVleWtneWE3UDNwNmF1RmJhTytSRE9VL3JxSStpVnl1RzFMNW5a?=
 =?utf-8?B?bVdYYjZpdUd3Y0dpd3AvQ2VGK0x6UFhWbmNBUXBQN3kwV2ptT1ovVWErUHpR?=
 =?utf-8?B?QjhCZHk0b2VRZVlFSkxGbzFieFNDZEY4R2MzY1Z3RC9JRXVWbWdRZWZGRTdJ?=
 =?utf-8?B?WG9vR2szTFJsSG4rMFQxQVg1ZzFjNlpDQU0xblRmSkxnNWpQSjcyRUJNWlJy?=
 =?utf-8?B?NkY4VThyU2R5ak5OUmVEM2JkYkpYVUxJYm1kV3pCaU1Wc2hWcS92WW84Rlcz?=
 =?utf-8?B?VWxoWG0vSDUxaDlZbjVBUVVyRHl4enlRWk1TdVBENkRxcmdDK0FnUFFVU29a?=
 =?utf-8?Q?jQzUUsskEz4tXnJVwi8JnB5UgFONk/jSwf74/?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f092a648-4d5a-411d-01c8-08de8926b5cb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 21:54:08.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFY6wYxpmBEMHOgapU+AVaFeHGLfImymg16nwF5531KSoZrcnftZvdeDfkRbCHm4icpyp5LXteVsLjesRDtwgmTyuap4Dy1uRhfWbI79IRt0Q8DtVtyxwyhCBE3iL2E1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8943
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18543-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:mid]
X-Rspamd-Queue-Id: 7A4162FDFC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 4:48 AM, Arnd Bergmann wrote:
> I took a quick look at the hfi2 driver, and noticed a few things
> that that may be worth addressing before it gets merged, mostly
> stuff copied from hfi1:
> 
> - A few global functions with questionable namespacing:
>    user_event_ack, ctxt_reset, iowait_init, register_pinning_interface,
>    sc_{alloc,free,enable,disable}, pio_copy, acquire_hw_mutex,
>    load_firmware, cap_mask.
>    It would make sense to prefix all global identifiers with 'hfi2_',
>    both out of principle, and to allow building hfi1 and hfi2 into
>    an allyesconfig kernel without link failures.

Will address that stuff.

> - The use of INFINIBAND_RDMAVT seems unnecessary: right now
>    this is only used by hfi1, now shared with hfi2 but later to
>    be exclusive to the latter. Since it is unlikely to ever
>    be used by another driver again, this may be a good time
>    to drop the abstraction again and integrate it all into
>    hfi2, with the old version getting dropped along with hfi1.

Replied about RDMAVT stuff separately. Perhaps when we target removal of 
hfi1 that would be the time to get RDMAVT re-incorporated into the main 
hfi (hfi2) driver.

> 
> - The pio_copy() function is particularly slow since it uses
>    the full-barrier version of writeq() in a tight loop,
>    this should probably use __iowrite64_copy() etc to make it
>    work better on arm64 and other architectures

Will certainly look into this. Thanks for pointing it out.


> - The use of bitfields in drivers/infiniband/hw/hfi2/cport.h
>    makes the structures nonportable especially for big-endian
>    targets, if those describe device interfaces. Similarly
>    the use of __packed attributes in the same file seems
>    arbitrary and inconsistent, to the point where it
>    is likely to cause more harm than it can help. E.g.
>    in

Actually have a patch that addresses some of that. It's coming. We had 
previously only built on x86_64 but have plans to change that.


> +struct ib_cc_table_entry_shadow {
> +	u16 entry; /* shift:2, multiplier:14 */
> +};
> +
>>
> +struct ib_cc_table_attr_shadow {
> +	u16 ccti_limit; /* max CCTI for cc table */
> +	struct ib_cc_table_entry_shadow ccti_entries[IB_CCT_ENTRIES];
> +} __packed;
> 
>    the outer structure is unaligned while the inner one requires
>    alignment.
> 

Will take care of that one too.


-Denny


