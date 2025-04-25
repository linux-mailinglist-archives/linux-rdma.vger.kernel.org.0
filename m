Return-Path: <linux-rdma+bounces-9784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F6A9C508
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0C17C396
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209A23A9BD;
	Fri, 25 Apr 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zaMdFz7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FE218821;
	Fri, 25 Apr 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576180; cv=fail; b=d3F2WKoqThENKA2bveEPMssaXGkpbCXdxjIvA2qUVOPmOqLL4PD33KI0aPeqLrCfB4bXxt6YQusSOGbYcV3F9lM6pmEcclSMd/f+8IqpMj8zp7LPsH+qunz2szQJqGUWsnWkwdUkuCquRdx46vKKxOzI+AP3wKytAyN2IwfPc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576180; c=relaxed/simple;
	bh=Ivf42Rn59R+1wgWkGXff9JpCuyDyBQGkOEVk6NUv+q8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oe6vktxzGF99Fzk5CHcivelRkQjn5pa1AbzKG6JQ9ydKRpi8geZFuYCOwXptIscq3nrzQ8pVyrIpNn8PFxPv9nmOPb2Hau3fwolNRYfvdSUFeh3UQ8YEQQhT5VIQJsBb8pLEnnBgE/u0IQifPjFgks677FDaqsEEBjAl265fg50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zaMdFz7s; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3Bv4S6S2pgBgmcXMFAjdfJAa2lQ3FieqDlGJbLYGcPKtUuMFf5ynt+QRrjjBsMjMq7AEL36IBUoIs13URokEAQQ8BJnu/AdTI48zIzLeMotnX8B1c7Mhsej4uk8aoTIM/pA7/6hlZEtBVKvKKhLDEXyle7iXa2R36XqUE/BWkFQ54JoUHafDN9HllqeViNrw2OAus3CS/RMZ4EzasqXAOHkR6alQPyTU5PkWBpjERRboDwwi9Ea0FtnF7uGexte7CCz88WNt1+zSSjHKq6QOc5O0H7jsIeq9ncvBTK8RtxNOG3yn5on1SQLXvFmTVFJBehFeosyqMW8T48UsUNaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITYs67pXcjasoCpsphbUMweuurc3oV5sdRj0ZbHWLtU=;
 b=Hmo2qdMhz+DFPHhRAUvhBBfjOt4B8uTdaMQOtCUtryUXg9WU5+zmIF3WgfEVkK3Bp4W4oDpwWGvt1ACGyGdeF0wzGgGnABIIiugxcSy/IUIS81MR4l9zn4oHOntapmNS1CSzp31DPwz476v0C1K2eDf77mJfJrbH6RZJlYRROCJKMVpJI8zK6lueCLixNUYipBjuj6OXWaNAd7OWtrzWmGEnFmqCs02XVvjGwhrR0kLTwh2XnfLoHslfybYHJlDWgYYykBCw9LAnViNSSUk/eWT+GkZFGz0UQ6KhyOhcorfjfBgeBjv5s+sLHbAn8ZEIq9LwYYWKcuuHcjc5CD7LJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITYs67pXcjasoCpsphbUMweuurc3oV5sdRj0ZbHWLtU=;
 b=zaMdFz7svoyHmEdNTgm2DPUSOxiclfpXz/xvRS5RttTpoWg0qzNHaLjssWKQLPBiQ4Pv57TY8OkxNrQbMu+jJ36t5x1wUhMrUTYTtd4pKW0E4DQ05xvijP/rAzmWY+bISL88jQ5t6WC4iuOnjkEp0M4mb1SV01EEQlFM/eAJ7+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 10:16:15 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:16:15 +0000
Message-ID: <ab361812-566e-5454-ab2c-40757a8808da@amd.com>
Date: Fri, 25 Apr 2025 15:46:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
 <20250423102913.438027-9-abhijit.gangurde@amd.com>
 <20250424130813.GZ1213339@ziepe.ca>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250424130813.GZ1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::7) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc67ff1-9576-4c4e-a883-08dd83e23625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkY2NDdrK0p0aTFOVlo2eVB1VjVucmRFUUs4aHU0RVVjUzhjNEtjVjZYeE1L?=
 =?utf-8?B?enRWc1pRQVI4Mk8vZkI4Nm9Tcm1GUDBmQ0ZUeVZUWEJDdms5VjNEU2dUdE0x?=
 =?utf-8?B?NGlMSFVJTVFaSnY3b2NJZEZ5ZGVsdjNRVlczdy9hZHo0bUMrTjJiTnhmY0Jj?=
 =?utf-8?B?SWtXUDJIYWxsY0dQVDBGMnVUVHZTUWhET2xRMDRDNnROcXoycXhUN00wMXBJ?=
 =?utf-8?B?SW0yeUxucElQTW5IQ1p0K2h5K2N4QnJSR0d3VFNsUFIrbUptQkprZXE1NVd4?=
 =?utf-8?B?TDRHOE9jV3I0djBPVXdkTnl3UnlpYUtGRGM2cEE3cVRZVEJIcXUyNC9ETSs2?=
 =?utf-8?B?L3orYUowQzFPa3pxNWxCZ2l6OVppY2x1K0Fja2J4N1lDK1d6QndvS0RXTkox?=
 =?utf-8?B?SVZUaThYa1lDVTYycElncFozN3dYUHpXcXFWWkhZcWU4UkszdS9xMGNkWGEv?=
 =?utf-8?B?VFEyRnkzM1A0Y1NYWjcwSGdWcGZNbzFJMkZwdnd1Y05peVJxWWNQLzd2aUx5?=
 =?utf-8?B?d3Fmb2tBWnlvUW0yV1c5VWNjYk1Qc2FMSTZFZyt0eXFCc1Z6bFlrd2RNNC8w?=
 =?utf-8?B?ai92eDhXWEl4Uy9pUmw0VDk0ZEo5bWNRa2g4OHpkUi8wbktHSERmdzJaTjZl?=
 =?utf-8?B?SHhGcWFCeHdBS2Q2TFlHeGR6S1d3UTV1NkNMRFhydldZZ0VyTUcrWG1CZ3Vr?=
 =?utf-8?B?ajBYRS9NQ2NSeDJ5NFA5ZWdGRkRYTnIyamxFaVdvYnhYdXFRb0E0Z0phcEV0?=
 =?utf-8?B?WGUrbFgzQ2kxNTJQenhMVEdoQ0VJejFoVUUyTHNLVEhYdmp6cU9DOEFFbEs2?=
 =?utf-8?B?YkltWjc0U0YvYTR6TFkzbFEya0xGWmpKbnF4RUxmSzFwWDVQTXkzZm9ERnhm?=
 =?utf-8?B?MmhPbnFYQ0F3NGZrUEVCOGlIVUZ6d2lTbmRsdnN3eHBqdUtaQXhUM1podmxl?=
 =?utf-8?B?amMvWjA1UnpJcDU2elY0Qk9JbjF5OEVJTXB3REM2akE1S0tDSTZUMEw0S0x4?=
 =?utf-8?B?VVRnR3ZZZDNveE5hd3hGWU5rU3dGTkpzbzRGSzNzVnVrMUl3bTh4K2xMaTI2?=
 =?utf-8?B?dk1ydGl3MmJQeDArdU9meGJwelExd2xRYVU2WDM2dzFEM0k5c0RBTHdJUmJW?=
 =?utf-8?B?NExwRFdDQ2xaZC9sVnNoVVNES1hkaEhQQTB6eTh6bEhlb0l2NnkvQUZnbUlV?=
 =?utf-8?B?cnNQM1YwVWxFSnJrekdnZWpPeEpWZmMvcTZpejY0VzhNSjhwTW1rdjZURGdI?=
 =?utf-8?B?dGJ1bzBPNVlkZUVkVml6d1JhYXVPUXJGL1A0WnAzbVJ1STdmcDB1a3NIN0pL?=
 =?utf-8?B?M3hXc2RhZ3hqVkFoUzZPRVp1VGcxQUFYZmNBTTVsaGR4SVNkODIrVlRyekll?=
 =?utf-8?B?QkpqaW8xdEN3WG44UmtuSTk2MmFEV2oxNThQbG9EaDA4MmhaRkVTbkZtRTJC?=
 =?utf-8?B?RVVaSWYvOFEyY294QmFSUGNpYTNKcmN1ZFR1aHhRRUVDVllkellkWVVwczNs?=
 =?utf-8?B?azgxQkNjSnkvTWR1UkY4QnJGZ2hKN3pLOHpsSkgvc21PemhZVEVmZlVaUjNT?=
 =?utf-8?B?ZVE2NTNvbnhZNTZSRTRwa2swdFNtNHVGd05tTDZvZTlhdTgvMngvdzNndGI2?=
 =?utf-8?B?TVVpR0tHSzBNbTNDaWFSUHo3cFpxQUZ5Y0lxbllhcFFIdXdxWE9rT01yeHpW?=
 =?utf-8?B?dnFCUWxoaURXVmVZVGlyZzhnYi94ZFphWDMvWTliUTJhOTFpYXB3aHVNWVRv?=
 =?utf-8?B?RkxWaUVjVUdqejMra0dCK0x4UUF6SXJxUGVxQXgxdEFvVzZtQldQVnNaTWNv?=
 =?utf-8?B?RzBVdHc2SjdpWldFblNWMzVCNUIrUUFNNkdZOTVCYXY0eWxkZ0ZUU1V0bHlx?=
 =?utf-8?B?b3Y4ZHA1WmVVbUZFV09XQ2FoSUdJL3NJb1k3SG1MSmdxek5Ua29JTHZTSWVJ?=
 =?utf-8?Q?KpjMMiRty64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnhHdUJIZGRhSHcwLzl1MlRlYzhvR3l3WkpKOHllK0szUW5YR1NRdWdtQTcz?=
 =?utf-8?B?K1Q4WlhMN1VoOU50cGhGZU9vaHpwRU9TYUNnUVoxTHRTTTFTREFic2U4QktD?=
 =?utf-8?B?aEY3QjY5N3lka0FoVVJRNUtDcllETGlKTkJXVmpyOWtMeStPbTdya0lqZFZI?=
 =?utf-8?B?bzJkcWovNzBuMEtRVnpHVzh4czE2OWh6ZjduVjVyZzY1ekprdkpwRlVWVVRS?=
 =?utf-8?B?SWI2Mkd1czRqMUJaUXlVcHpwMWp5Y0lwTFBaaHhFR1BVZDBQSjdJcng4K3cy?=
 =?utf-8?B?d0RYdUFhR2ZOUm9GMm9QenVYK3htQy90RXVBNjVOOGlUK09RUjhKU0tySHh0?=
 =?utf-8?B?dkpnZElGYWJJeHQvVjk5cy9tT3ZVZE9SRjVSeElRVGhuTjF6SU1OUUZJdFlY?=
 =?utf-8?B?Z3RpaEk1S1ZOL21GcDc1VlpvYVFqcmdJbXlpVCs4Vld0UTYwcCtwVUlQeUVw?=
 =?utf-8?B?TU16QzM1eXdtSkI1ZUFsMnJUSXFzVEJ4NElxK3NsaSszY0hJc2dHaTZaWWw4?=
 =?utf-8?B?TnIvakRKYXBaN29TdjdmVXBhSlVzcWxuOFk0YXhjbVVFSWFMQldXeWFsdHFJ?=
 =?utf-8?B?OFhTM0svR3ROMGIvR2lwNlA0dnBDQlNpTFE4S0xMa283dE4yL0xpbmtvcXFV?=
 =?utf-8?B?SGZNRkFTSmdCbG1VY1Q3R1cza21oQnhkSittMVZhZC81UUF6WTRqUUtudVJ0?=
 =?utf-8?B?S2hKSi9hbjF0c1JIMHFHbEx5T3ZxTGJmVWRKM2lBWnU2b1N1TldCc0E4WDZa?=
 =?utf-8?B?WWZ3cTd0K1RkcHpoR0NIZkxNVENwWUc2YTNFdGxlRUxHWkpTV3dKUlJnR1B0?=
 =?utf-8?B?aHNaM2JKNHN3SXM4ZFlpM1lrZWJJbnpQQ2VDKzhzWkk5dVNpRjAzc0lRQ2U4?=
 =?utf-8?B?TkZ5V2J6Ukc5OHlzbGdSUDJPZGtmazdoM2YwNmFEc1U4ZERNZDJlbVY0RlpI?=
 =?utf-8?B?LzdEQ2ZWeDc4WUVUOTZoTXk5VVliSHU5UUNBVWdBL2xUdUQzQWVnRmZHbkwy?=
 =?utf-8?B?SkJKZVQ5QW8wSWE1RnpVQXN0bE01MEhUR0xOVy9BQyt6M1BuQUpUcnRCZ1dR?=
 =?utf-8?B?QTg5TUFTTzg5dWZQQklRN040OTFQRmRWYXl5MEdoTEh2dlJNZkVGdEl3Z25C?=
 =?utf-8?B?a2Y4ZjlScWVWRitBV2VNY3VKVXM5YmpwVXBhTndjeU9TeTlkNzlmVUYzZWF2?=
 =?utf-8?B?dldSUFJFK0VWMG4zaUQwN3kwVEx0Q2xydG83OGJxUnZTUE5EQWJpVGczNUZx?=
 =?utf-8?B?b0syM1lzN1VCb3I5MFRYQlhNZ09VZWh0UVlrbm8zS3c4Y2NQWjlKZ3hTdlVE?=
 =?utf-8?B?Y05OcVA2ZmZmdTdFR01tT3dVbmQ2MElZQ0pDSUdBOXpFdnZFaFU4NmErYTJi?=
 =?utf-8?B?RmtUekREem55WUVkY1RjdU8zeXo3Y0pSZ05xeFk1OHZydU83OFFmaWhwRXp2?=
 =?utf-8?B?MjNXNlM2VmREdFluUkZJb29vV09lL0hqRldtN3N5c0FwaEFVczZVVHBtLzFk?=
 =?utf-8?B?Wk85NUxOM09BU2wxcXBLc1psTFE5SUZHNVJ4WFpJVDcwZzNNT0lTdjlhaXJH?=
 =?utf-8?B?cEU0QlF5amdVaDYwQm1scXNuR3VzVDQvOXFNTEZyWllOMXcwSzBXa05sMU8x?=
 =?utf-8?B?RWppZ2Y3eU1aR0xXTVErR3Fwck1rdmsrb1lPYWVRVWNRWHJzenpGOGtMQlJt?=
 =?utf-8?B?NkJjS0JVa2Fub0tjeWpOeWI0aTBTNWZaMjh1dHdrQ3pTdE44WVpUSVdwRzJy?=
 =?utf-8?B?aU9iWXIzdDJTSEZ6ZGRDQTVZUzhnSnphZ01YR0IyY0pqUWJ5STkvSSt1Ti90?=
 =?utf-8?B?UkFFaXlqYkVUeU0yODlUQUFRQnZqc0pqOWFVWEUzNmlFM09Ka3Q1NG5CUE0r?=
 =?utf-8?B?cWtPZEV0Y1V6S0dZWGRtcldObXFDc3ZLbW9tekMrRTVHL2Q3bVV6eGVlVnVo?=
 =?utf-8?B?TWtzYmlvZEtqQTFZeGE5b09WS3BPQ21hOERSbHBrNldDbHdENTNPTmp1NnI3?=
 =?utf-8?B?WThtZmVwM2FLRWw1REpzRjFiL2RPVTNwcTR0TzBlYmx0Skgzb3pScExxbmtz?=
 =?utf-8?B?VzJIMUlqdzJuNGxPTkplUXkvZzhhcC9Lc21VQ3NseHlrWXl3VTNPN3NnQXpj?=
 =?utf-8?Q?fZH1IoEFCYpencWZ0DHnZq3IG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc67ff1-9576-4c4e-a883-08dd83e23625
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:16:15.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8rPV/etlWB9fSV1SyU3JC79VteQNc1tor7IOB+VE48Nppfl9LbjK6TVJIWAfTRrr5SX3+v4qsTJBx7qZ/dCZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770

On 4/24/25 18:38, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 03:59:07PM +0530, Abhijit Gangurde wrote:
>> +static int ionic_aux_probe(struct auxiliary_device *adev,
>> +			   const struct auxiliary_device_id *id)
>> +{
>> +	struct ionic_aux_dev *ionic_adev;
>> +	struct net_device *ndev;
>> +	struct ionic_ibdev *dev;
>> +
>> +	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
>> +	ndev = ionic_api_get_netdev_from_handle(ionic_adev->handle);
> It must not do this, the net_device should not go into the IB driver,
> like this that will create a huge complex tangled mess.
>
> The netdev(s) come in indirectly through the gid table and through the
> net notifiers and ib_device_set_netdev() and they should only be
> touched in paths dealing with specific areas.
>
> So don't use things like netdev_err, we have ib_err/dev_err and
> related instead for IB drivers to use.

Sure. Will remove storing of net_device in the IB driver and its
references in the next spin. Will wait for some more feedback
before rolling out v2.

Thanks,
Abhijit

>
>> +struct ionic_ibdev {
>> +	struct ib_device	ibdev;
>> +
>> +	struct device		*hwdev;
>> +	struct net_device	*ndev;
> Same here, this member should not exist, and it didn't hold a
> refcount for this pointer.
>
> Jason

