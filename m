Return-Path: <linux-rdma+bounces-17398-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKlhOzLmpWlLHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17398-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:34:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A661DED8A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBB83058E04
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DF47DD53;
	Mon,  2 Mar 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UdHxHAtg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1447DD40
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480031; cv=fail; b=QYgGm/5csD/GUTEPXwCjW9VgSXHTuWFFaTB5ut8GjgohQiuRV78ormslUlYNn+AEs6jpi5fnPehOtDDi3rjHDI2oVwI0VhN4IR1XJIgGCw6gphOZ6MLl2acY59i/X5RvmCdylTBICCh10aJBJjUq3oRlCGtXrbt/lzhpFdKMkUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480031; c=relaxed/simple;
	bh=pvLPnfuHu8loYm+8zy8pmynToK/sL3SgXPgWp4tR/fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/qKs+t1An0xtfPnM0ZXaLovzTOt6LWz2IQN+MeiT2wA3YXZ69uweBBnNipWFWPGmqhvL8gtVocQ6h0bxefU5dKasjmCbb/C/bEmdIh4WO/THake9YaHIymzhnB9CwNyE48rKMmkp0OxGf8zcBWRqkjX0vDcscsU+mODw4pKz+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UdHxHAtg; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ3mIRyXHZgN1xWPX6ZznxZNYGJdkk0C0zdCpcKFTXP6P6dbP7JEdRBuBo3slhbifmnVUOEEiklJ3V316rOkYNZt2ec7cQQCfrpGVQ4jMdkR3NGxlQyR6lB0W8Bk0TmBanQWdrUIaO88puiHj67Mz//VxLE40YDL7mVJJzD+L+n9KWMAFe6GISsYWXLqmENaZShb2FIHsrv0BMCwOuCGF7t6w+MqgPIyrn3R6WLYwqrFKUVZzsJyDd3hdBVHcTYXufFxhOVphT+Fww54r/gPx6kjPHtevSYqs8GyJmmMqcjgfK3uOk/z+dozJ4roq/4OxPRWSaUYGTgJYvzddQqUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+C2NOJe8QJ4anJodMFFnUxSHlso9E+5WqtsXtWE4H8=;
 b=cd8ZFgCaY5PHdxU9AwbKjJdDx9hLhE+QiDfdVHEOmmNo4N8qRKYoIHq35wt37E7GwCvC/JERpzB2J4WC0S9Y57O6sY3uAUdjCbsNgVKlgAsnH24wMbIJH2LiUCINfmd3YfqpiAmwlBeWKTDuj4Zi3mnCs9bOvsETdYXcOl3yswvCcgCm9VMZUTzm4ouac27FiamZkOZSJcBsDlPvWZQqx6KXYf3nG1Rf8tpiLHAoutj3ih/L475AYUs1xd4pYAlTcYmfeYGzBnhJcO1e1+j6HyPT8fnrpM7XWQTMtSuitiIVr349GXT5XEnaze7yVtNAeGZBShocHSsD9yWoQAct1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+C2NOJe8QJ4anJodMFFnUxSHlso9E+5WqtsXtWE4H8=;
 b=UdHxHAtgNRiTqA4hBbT9vizXE4Pg2Sp127Ki5bC0ug75LvPIw+5H2mSMkMDEYJH7tcFbyh0Lvoj044zJHBh9FF1i1GFN3E5XC4v4MPumb1v3I02soTpp/y1CnKi1XDZcufUeXdkzGKNkUUDcp2CHFQY7mmjqM5Ktmcg0L5/HoDJwnPVLM2xo7h3MXd+rx2C5v6lcEEEf5yp8pBJQUOh6i9Qrl8P9eJsdQYV37EHVlbd7prBLcniJUffBPeIYPZOo3HA3b2TLq8z6bw/r1SebWrjZ+xDv0m/o7B1MI7offuNrLaz0ArIPlw3ppdZo8Dk5Q7cHllI8OQFPlIN2jp3leg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 19:33:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 19:33:45 +0000
Date: Mon, 2 Mar 2026 15:33:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 00/13] Provide udata helpers and use them in bnxt_re
Message-ID: <20260302193343.GX5933@nvidia.com>
References: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
 <20260302192413.GS12611@unreal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302192413.GS12611@unreal>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1336f4-8c25-4679-7ac9-08de78929e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	Da8Am8w0IeFfNPnL2UPzDRcx0NzHwzimq7TFae6IJ+lqBfQuCb2G6AnFwwz0wbBvyMLjg6yweO6jfl9bgVW2hpU/XVHcY8mVeixx53VL7THDdxq+LKPr0AAYFNjvFC2rO19GbePmFP8pRn4CNus3DHa/ayBXakySZmQgHzQHEhjx7MSF/G4KTjZDUrkmjGF5UhPWeXqcGI7QCZf0oUF4pIxTe8eyP58y2eDrV14DIf2G+0PGxjQRKV4ZlPzRdOp7Ky6TOZmJLo8sbFk01lM1VapruDL1n4uhrtMpWpvmwUPSCxTWeL/3xe+ED1vjI1ONJnZ+wMxhe20FlaofNvJAsxeNcyB/Sg7f1VGSjXm7dWEumvSOYXxFCQZXKWEwJIFt8CKwl6LY8mXZkNOJPLGOoyd6mlfj+aGlfHnn9NedKu3cDX5E8s50m0QH0HYpFi/FlX8Vrna1cLKL1EJOIbdU4jEYZJ6ovyyTotShWJqQ5e+GRP+ew9zb3esMkBGnB+0SMvrIK4QQAXC9k3RStSQ4UW6TiJP8eCyVUMy38M/MXGl2C9/kFYB+cOSeNMxRf+r3UZpTvGV4IEv9f5YKLiqbv9sR3RCCohMj7IrXgb/jHqPd5IkC245PYWqPjjSHAvBZLEbQ7tV6Zz08d7ElkkgMBPYq36J9w1kbUwbAU7nStInrrAJ0IkNQho8xpqvbwg8IIroaf/nDS9D/zLU/tNcUAffRQyHb6NZW8PMfmSPD8cY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGl6RVBBL3RkSG4yaVRPRjZGOEZ0YkxpMlQvN0tSRVlIV05MV3JTQ2hZSzlW?=
 =?utf-8?B?LzYvWTdJcDR6ZGpJWGF4NHh4ZjNZUGxaamlRTmEyemxRcE5Wclp1Z25nQnln?=
 =?utf-8?B?NWQvcXU1bVkrKzhvdmEyb1pFVzJjL3NwUUl2dCtaREREM3FGVXZoY1V0aGhn?=
 =?utf-8?B?Z0o4RFNLM0x2azEwS1hmT24wSktldHNOV0ZLOVoxTUlLd2QyaENadDByYitZ?=
 =?utf-8?B?TUF3NGpJTTN4Z1QrNUNwTHRXbDNNbkVMUkZpSTNRZ21ySzF4UVhYVUtwMFR1?=
 =?utf-8?B?L2FMM1NKamFZZ0dJU2xpSERBVFVHMHljZWJIWlhBbHBCcTdKTnF3SlZEeFRW?=
 =?utf-8?B?RTdHc2N5a25EcjFWUkJHd1B4eWpWdmovUWxNU2E0SWsxcGxDWWIybUFBanJT?=
 =?utf-8?B?YWd2TmhwYnhmd2U4OWVaS1hXcUVUWXRidklNZFFjRzJDVTFVR1dCV0ZNeW96?=
 =?utf-8?B?MGYrQzdldlpWTjUyTjNEWXQ5WEJFWkFlMTFBcnVMRzg2RTd4SHRqUzExSG1u?=
 =?utf-8?B?Nks4RXdESmZwUEJZcytFVFA4UkhiNDlnR293TUdLZWE1eUw3ZURGcG0zSW1J?=
 =?utf-8?B?a0IxcGg1TDV0Yi94Ykh5NW8wRFdvMld4aDF4emZzZWpoeHZ5N2xrYmtISlZB?=
 =?utf-8?B?anIzMnlZVWxhS21aaitleHptcG1Bd1UzbzJRTDNhYWs3VVZTTk55OUgvbWFQ?=
 =?utf-8?B?YnJZMS9IWmltL2NPZC9aOVorWXZ1ZVB2a1VKeWM3Yk9TUUVDckZ4ZkpqY280?=
 =?utf-8?B?d3BZcVV2bDAzVS9WOFVaUkpZVUJSNDVxYktaQ2Ixd2lUYnhqcU9za0dqMmxv?=
 =?utf-8?B?eksyTlVaSkRGRFcxR3JlV0laZkVMTUlVWGVMaUNOTnM5V0NndmdjNmR3OXVo?=
 =?utf-8?B?UkhhVFNzb0pvNEovNDFtWGI3emYxem42cjJJWkx1d29pWitEbGx0S2NhZ050?=
 =?utf-8?B?VFpWMTZxc2RqM29oVUZPekw2SjlQRXo2RUw4bTljV1V6Sk1WNURhUFdJMyt5?=
 =?utf-8?B?cXFZTFVrSjlmeEVQc08vVTNBWW92Mm1qb0JrYnZRRFZNRGJIRFQzY1pITmhK?=
 =?utf-8?B?YzRsMGdMLzVjWUVvVEhJQXVDRG1IbkhsU3J2eGlmUTNSVzlxRG81ZE9QMzMx?=
 =?utf-8?B?NDlWWHhpUUlVQnpHeU1UZmJuci93ODJ5OU12TThMUHhYa2JiNmtIN212UFJ4?=
 =?utf-8?B?NURvcnpCeVpxUEhmdkdXeG9Pd045ZWZ6OWJEcWxUU0VXWXJvS1pSWmhrU2R6?=
 =?utf-8?B?cUhXNERCOUFBdERCSTZ5T091b3ZZM2dpRVAxOGRIY3ZFZE5YS2F4OUN0TlNH?=
 =?utf-8?B?dmNZQXhTNFBaU0h2TE5xRmQ4dW00dHVwSm55YytoM0pkR2R1NnZCUW1ucWdC?=
 =?utf-8?B?NFRoMXJHT2pzREVXRGJ5ZkVUQXVoOUh0UHd5c09OTW1haGhjK1lEK1h2Vmwz?=
 =?utf-8?B?Q0dsWmJvSXY3Z2N5b2o2b05WNnorVFI5dllmVDF6NGhlM3BGUUkwYVRWMXcz?=
 =?utf-8?B?enBmZDA5TzZiTG1LcHJqalNnZDFzNDZlMkVoM2NTTkJZL3JFUVdaRk9rWEZO?=
 =?utf-8?B?OGw5SnVyWjJpaFdQSExtUHR1YUNPbjlEa1N4aXZGTDV1bnVNZk1UMTJsdElC?=
 =?utf-8?B?UmxFQXlnWVRwTUE0TkY5WEtJdTg5SmJBd0ZIRzlpZ0FLVzlzN3QreUE5eUhS?=
 =?utf-8?B?QnFndjRkWmhmVXFCU25aY1Nnd3JUWmJDSFJVazBRMk1Vb0RRTDU5QkF6SlpN?=
 =?utf-8?B?QkFvK1pNZ1RSQjB6WC9TUDdzTzVsWENMR21LTi9kTHhOZVpUMXpPUTllYWtv?=
 =?utf-8?B?c2FKUDlvVlorUkFzUDVEbzJ1VUhsMHlkNThuUVc3UWh1b1NoODNoUHJHSWxa?=
 =?utf-8?B?REpMaVZyY3pEclc1R2FsTmgyMTFtQ3I0dW4xNk1wR3NwSEk2TER1d3A3dEpm?=
 =?utf-8?B?bFM2UVJLMXRUeGVFbFVERUczWTdTRGQyU1B5OHZXYU05bmpQWkNNb0JUbjcz?=
 =?utf-8?B?Z2UrcThaVXlBT1ZjMWRhN0xnenpUb2tUY1FXcEFhdWY1cTFjWmVhMUhsRkw5?=
 =?utf-8?B?Y1Q4ZUE0aytZKzlFaWdCQ2JoYlJTTTFQMW9SUXptLzhLN0JlWE5BNjllUUNx?=
 =?utf-8?B?M0tVTCt5L1FtbFNxRXZjMDRJa2NWbXlKb1JIWTZhMzB4YlQrRWF6dkdybGZJ?=
 =?utf-8?B?S2hmbDg2OVBPTVFYYXRLTVlycWRSeVE1RlF2NzJEMnVVVkpnbVNCR1ZqbWFo?=
 =?utf-8?B?SzFPdnl5eFYrM1lvNG1OY08wNEFOcTZXMUNocmd0RHVXQm1vcytHQ2pZLy9B?=
 =?utf-8?B?dnliZXA5UXlYRGFjNXBUYW16OU5KVFUySGdyTGJSOE1ZRVRTek80UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1336f4-8c25-4679-7ac9-08de78929e4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:33:45.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U60Ta+SgTLhN3R8H/heaMpe82Dkwn1pldBNYK8lO1Jo9WzRR0f6nCZXzwKkMg0H9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Rspamd-Queue-Id: 51A661DED8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17398-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:24:13PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 09:11:03PM -0400, Jason Gunthorpe wrote:
> > Add new helpers that entirely execute the expected common patterns for
> > driver data uAPI forward and backwards compatibility so that drivers don't
> > have to open code these.
> 
> <...>
> 
> > Since bnxt_re has never implemented these rules correctly and now does,
> > provide a UCTX flag to tell userspace about it. If
> > BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED is not set then userspace must
> > not use any request or response fields beyond the current kernel uAPI.
> > 
> > Using any new fields is only possible on kernels with the flag.
> 
> Does a similar flag exist in any other driver? If so, we should consider
> making it global to ib_uverbs. If not, keeping it bnxt_re‑specific is
> sufficient.

I've been thinking about this too..

I think I'm pretty close in other drivers to being able to make the
same statement.

Maybe it should be a global flag in the uctx uAPI

Jason

