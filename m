Return-Path: <linux-rdma+bounces-18228-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAENH4d9uGmVewEAu9opvQ
	(envelope-from <linux-rdma+bounces-18228-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:00:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2C2A1397
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3B69300C6D9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5AC2066F7;
	Mon, 16 Mar 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="OUBueDgO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAC15530C
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698432; cv=fail; b=pDbtkeStlLkMeE0ipq1fALCKT2liyO0wurxtmvbjqtv7PtoHG490G7LXp/LYZ6807X8Z5Ma2IPHL6hdDYHC9fvq81nh6rzBiDJwJHSnsgvzlfTgxuQe7GLl+5X4BGVJ1lGp0blw82SQH8bRHYkoWhji39fv7hdL42qiY9R48HGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698432; c=relaxed/simple;
	bh=M1TMoSxA+zlaDExwLsWPDdWg7UiqH7GnK6HMhpMjTm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpRTJROOo/6mfQsTtau3RNnAW7oLnzfvPf2CvpYM+xaGNEEp4lxmIWLcQZJFLNmf5PAbhbYh7AvC0dDPi0zamr/Z0zjpEuMv565qEc24eh9zb7rNAgskCP0NOLEbhMKf1Y2kAE0XQ28Tx8S+qEboyxOXeCGDwQ/2rUWAfQkeqrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=OUBueDgO; arc=fail smtp.client-ip=52.101.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqM1DQTy8Df7Vd+CLPFS53HT21W0jblu3mcyxSiRaEkQD/yR6vrIZCrXcKgEmf+WSJqCyJQvDTlDavQOPd6FKkyLpo0jnTtL7aqi72kfcCdZuHBfK9sV1wguIO3cvZIhYJ7JYT153H32jKc+kl1W3DtsD/gwDeKA3kZ6tM94U/mCIwGCvLxuyyXOOmIyft3/AXhGgYBcRsJxmtnQzDgsb5wV8fyBDYOEtm6J3CMOO9rw9S6ICZtG+vl2GlFebYStF9UleNjEIK72SGFAEFoq5njJTyVc3/iSp1Vnz8WuFfKJecwR9kmt+oaQ5l9jV5TjGbQYtnrUs+o8U4U44aYVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4PBD9ggIiiazcZgsu1tvGGJq6z3MM/nWslKvFT3UFQ=;
 b=pSde7D/fZM8WogCe1CkTOu6kMs4Lqc9SmXHDCk0QuEupTbxhB1tLVmlYWUY4vudeX8l4/WryZ5HgabPiLbFrzl1SwwrfVbGCkN7N7YSGzvHrCWCcFdUTH9Bd15FZXRE7yQRoOE1z7U/uJYHHBFgoQUkrRXp02PBq2kNPAfxfxshk41Svk7ngSWdrFIqg5Ib53MFPbT5ObsqdU3VAU/7Kscpn/3pJvqtS6TdocTAr1khbzQozvbd/m3x3f4TQcIhQuZn7GFetG1tCRZ89Z7ZTsbUb38X5mYCF7wHeGYrTVgvrkfwsMOpvoH8JyMtHnXqeHSxJyo+GYtwLtXx4ndYENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4PBD9ggIiiazcZgsu1tvGGJq6z3MM/nWslKvFT3UFQ=;
 b=OUBueDgOuwnRYY+h3crYUA8Z3mRxmIsG016E0WeMjm16TWeIA7RPUuTCc0Y0pXSl1jmTXA1xOFSp1lvUQHtippESSoOwdaNtup4+vwt5B5hyE3IuhGIbTx70dBfP141GBBC7n5AMVWOBxqbyNba0AApd6RV8jOLwGqZOL8M/H7kY3tCDCQUB3AGr95CXx2qjnJUfycemTMp6D+2d9bobB1oRrWFg+hs4nRn33kqydiyed27KNYwtX/TVS2PRGSdKhuccR35tucpxuqJNPMNH03QTuW+Z4u0H2j4S31QqtHVViQRPqvm0uZhgKbZZB+uzmmMriunRYLZPMQ3A+Hh5Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 CO1PR01MB8820.prod.exchangelabs.com (2603:10b6:303:273::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.25; Mon, 16 Mar 2026 22:00:10 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 22:00:27 +0000
Message-ID: <1954a5ec-2a77-4713-b20f-6a6c09b7f18a@cornelisnetworks.com>
Date: Mon, 16 Mar 2026 18:00:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next resend 01/24] RDMA/hfi2: Start hfi2 driver by
 basing off of hfi1
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
References: <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
 <177325163046.57064.2112731243866122444.stgit@awdrv-04.cornelisnetworks.com>
 <20260316155141.GC61385@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260316155141.GC61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::20) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|CO1PR01MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d180df6-d41f-44ab-147b-08de83a76e8a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	JC2cHvhhf5pfghiTovp8YDMFTaSyWidLK2fEWygJdmIjJ36bBTci5WB4eVj0yhYa75RIf/ZD6zPcTt+79cL7OaXbTphPyQDpTnse4cM8AeD7p9+VrSPX0o9oZYZQsVUl8knvXAnFncCgZQe1p68cr21lBabd2fxXdBOQXCpBr8xWzsEPHVH/wUQM2/ZiU/lsRupqbewj7Nd58UtgLllbkvberBIoR2HJcqJC3C3RthHWD2jB2l5iis2xiAcnaVbuMZLMwMczQb/bYbjriqScevklkGqTHmyXVZk85nwyzcTVOusvHGjj36DuVz283YLnuq4V6vj9DjzhG8NDegBz8tKxqmBwUnJ9CskN3W3iAT029a+pPeUnPM73h0H2QTgLodkeD14sHom5YbOoPq8PpeuyLHLa1wQymKA2UgHimRfMFBz3YDd1zgfHajAQ5Fzu83DitVIuixbBjEFPmMkLBGjIvUZHE8h1lEWgLHqdxfcWO4eZdnQLiwBDWwt1Uzs3/4fK23AliwhTHDDVQ+TjpkhqCNLuLXd8OLpkp82j2KqdefuE0QLdIrWNnvB3EwhdiIXgH3cZKFoCbSOAeMNC3JbqM3OMvEyRLc/MNoVdoeblC8KFmlY52CmngNi+sawCKkTfDHuS5pQRFLuYaNgTBXCdeM5ik1tKI8GtLtZ+0dBaX6tIknsVOycgipWvKbwmKhEY3AEiT0UekSg7KKW6vtuC0LClFY4GUQupDgPx918=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alV3dk1jYzNyTG81MnNaWXc5T3M5cVZmTHBXRnhIc3EzOVNicnpxUWlmQTRY?=
 =?utf-8?B?aXNhUDYwcEt3OHZHMUR6WHNEQmFBQzExN0xiRndrT0lTMW5OYzJscncrZHFp?=
 =?utf-8?B?NVVFcHQzaWZhUWpyWFl5U1kwSlpvb2Y3QjRycFl3YXlzdXhxVHFPQjhNeWU0?=
 =?utf-8?B?cTJGT2ZCUDhFZHFrOHlaTkxLUFVNNFowaTNPSGtiMjc3MmFCVi9XMDA0T3Y2?=
 =?utf-8?B?WnZUdlg4K1J2clVYajJGbGs2SnlkWVpLaTg4UVJYWTZmRG14c0hIVFQ4d3hX?=
 =?utf-8?B?R3d1bHNIN1pTYjRtWXFHaUJ5bWtKVmJFSHdzTmFNRXdCVzZQMEFIbC95TSt1?=
 =?utf-8?B?NnVJMC9qMDhWU01Kd3NDdFVpZDRoQnU2eTRuZ01mTlM3ZVhxWExteGhoRXVI?=
 =?utf-8?B?VFdaWXpFanI3V2VSRVVzSEZrZmNYWFRzMUVCczRmSFpRR3l5SDlTQTg2dmlD?=
 =?utf-8?B?VGlEYzlHbkFaOEFoMXZ1Yk9ybS9EZ2Q1U0podlRQbHNLSkF3cFhzSFQ5azdi?=
 =?utf-8?B?S2ZqNTR3RFVmWVhRamtIMmg0WHpUVTRkT2c2enZhWUZpMjkyN0Q5V01SNjV6?=
 =?utf-8?B?L2FzenBIeVdYbFFrUnhQZE5XemN1WnI4MmhxWitXS1lwaFgrZDM0UC8wbTh1?=
 =?utf-8?B?eTR5K3FVdUFwOVJSTThvWmJCbnBQR1UyaWJWZ3BUWUV1RkVtVnNlTzRXQU9M?=
 =?utf-8?B?ME8ydmcwSzJUN0dKcmJDRk54ME5xenZSSDNEaTFMOHp1bmkvSEx6dTkvaGVu?=
 =?utf-8?B?NU1TSlk5SEcyR2NsaktUWkVaNldtYkFHaWYzU3JaNFhaT2NHMW14bDZOeXZB?=
 =?utf-8?B?SFhjT2U2UnFDM0RJZGdpelU0Yy9FVkd0OU11Ulo0ZzlXdUdpMFFLb3Y2ZURx?=
 =?utf-8?B?MWNBOGVRbUkrbW5Hdy9OWVRONTViYUF2WFlMVjNHVW5tZTVwVGRFREFVNjVT?=
 =?utf-8?B?c3VCSHN0TlI4Si9VcHUrdDVobGl0WmFVZXhEazRtYzdrSXNSR2tycmszbis1?=
 =?utf-8?B?c1UzNFlya3l0N2krWWYzS04veUdTQ21XTlVXRHpqOW56c1F4VXRMQ29ySEE4?=
 =?utf-8?B?TnplU0cyNDlFSmFYVzZERllOT1ZpdUVqQWtibi9ONXBaTE9oTWtHUzRyNWI5?=
 =?utf-8?B?R3FTaEc1QktYdUtrZkE1eWdCWkdSVGd6WUFVYU00bVFvVU9mbTFnNElOTVg4?=
 =?utf-8?B?Y2ZYUUR6V2dHZlM0R2V5dFdRVHBJY0hWeGdKVXFyQ3J5cjVZMk53UCt2YzQy?=
 =?utf-8?B?cnNQSEw5ZTRIL3Jiak1tZ2xrN3J5NUVGLzNqaCs3VUxiZkg4KzdBMDJMNnNU?=
 =?utf-8?B?T201dXRiTnRtc1pjM1BoM3U5RWdxNXJNeW1VSC9oYWlpb25kdzNQd0hGWTVN?=
 =?utf-8?B?Z2o2SzdDUzFEYkNXR1QxOTlsUkJ4QktGdll5b3ZNRHc0cFl2ZjdYVnpEQTFa?=
 =?utf-8?B?T3JRWU9tM0F5RFovVkE2dHlRM0ZBcFhteHlEZHVPMWpzNHZqV1lqd2RUVTc0?=
 =?utf-8?B?YXAyLzYwY2d4NmpzRE4ydVA3bC9HalVzT2VJWWVDaE9nQUk2NHZ3ektmRE1D?=
 =?utf-8?B?UitLaW9CNEh0RUFYOTJIbHJrZS9EUWVta3hkVW9kUndMSnh6Tmpnckt6TE5N?=
 =?utf-8?B?aG1KT2srNHhPU1B0TGUwYm44VzlZeGZMN3hSRnoxa0NRcVUzVGMxalRucHF2?=
 =?utf-8?B?UXdzQ0d0L2JiQTdla0dVTGJwOGRIVWhib3o4T01DaFNVN0xkbloxV1dNbWRl?=
 =?utf-8?B?NGZLTVdvMFhpbjE4RWxseGlITEMyZGljcWtUSGhGMGRqZUM4a01GU3RZWFE2?=
 =?utf-8?B?LytLd2VLRy84cmtNS0ZQa0E2UHFJa1lKOEJ4VWhycDg5RWpBYU04T2hvbFlD?=
 =?utf-8?B?eUF0WWdpbDU1ZWxMTGhoR3JlcFppOHlaL3g4bndxQzd5dGJ2ejJRR0JYZ2xl?=
 =?utf-8?B?SXhDVlA2N0dPTndzWUtmMURualk0bGN1TTY2YXdSTkN2SmIzbUdIRlVsc1hB?=
 =?utf-8?B?Q3F3cmVQU1FqVlNYbTBpS1hpbXVFcHRDb2xzNERXbzBvTExQcDZCakY1c3kr?=
 =?utf-8?B?cGV2dW94MVpkMllabXdXVkZVdFdDRndHVVUzajcxRENvMFd5YzVNWERCTXhu?=
 =?utf-8?B?bllzeGxTenpQSVV0RTBUY2R5emU2a1NMeko4c0QwN2kzRWVGM3U1NkdDZFFR?=
 =?utf-8?B?TXNQZVNHQm9KZ3VXc0VsMG95S2E5eXNaaXFEdVJEbkZqMFoxdFQwTWRDWERB?=
 =?utf-8?B?eHlINFFqem5MMExreklObWRUSzhmTGRSVExZOW8vT1RzWmY5Y0NVdGFjWDlY?=
 =?utf-8?B?TWpLTkpiOHZCWWdrOFhHK0dzVm55Q3I0K05JVDIxNXhBZ2hJTUtCai8remds?=
 =?utf-8?Q?LfOKcKjIhk4/+s5iW3OX/c6fZ0heB5o0EuBzv?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d180df6-d41f-44ab-147b-08de83a76e8a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 22:00:27.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc9zBWW2csBSRW8ToJuNm5JkMkqvaRVdRF3yFWDLr61AwVwyUfb1CXKhpedpWbLcjdgVZ7QCxrhr2UC2Upu7iISmAiOPbfIUwns/2cHgRRrAhgLcAsHvGt2A/IJzWVck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8820
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-18228-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+]
X-Rspamd-Queue-Id: 86F2C2A1397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:51 AM, Leon Romanovsky wrote:
>> +/*
>> + * per driver stats, either not device nor port-specific, or
>> + * summed over all of the devices and ports.
>> + * They are described by name via ipathfs filesystem, so layout
>> + * and number of elements can change without breaking compatibility.
>> + * If members are added or deleted hfi2_statnames[] in debugfs.c must
>> + * change to match.
>> + */
> 
> What is ipathfs filesystem?

Something that I killed off a long ago. Comment that apparently decided 
to cling to life. Will look for other cling-ons and remove.

>> +
>> +extern struct hfi2_ib_stats hfi2_stats;
>> +extern const struct pci_error_handlers hfi2_pci_err_handler;
>> +
>> +extern int num_driver_cntrs;
> 
> git grep shows that hfi1 has too many extern variables. Can we reduce
> that number?

Will see what we can do.

> 
> <...>
> 
>> +struct hfi2_ctxtdata {
> 
> <...>
> 
>> +	/* Reference count the base context usage */
>> +	struct kref kref;
>> +	/* numa node of this context */
>> +	int numa_id;
> 
> I have very strong feeling that these two shouldn't be stored in the driver.
> 
>> +	/* same size as task_struct .comm[], command that opened context */
>> +	char comm[TASK_COMM_LEN];
> 
> This is too.
> 
>> +	/* The version of the library which opened this ctxt */
>> +	u32 userversion;
> 
> And this.
> 
> <...>

Going to have to look closer at these ones.

> 
>> +	void (*setextled)(struct hfi2_pportdata *ppd, u32 on);
>> +	void (*start_led_override)(struct hfi2_pportdata *ppd,
>> +				   unsigned int timeon,
>> +				   unsigned int timeoff);
>> +	void (*shutdown_led_override)(struct hfi2_pportdata *ppd);
>> +	void (*read_guid)(struct hfi2_devdata *dd);
>> +	int (*early_per_chip_init)(struct hfi2_devdata *dd);
>> +	int (*mid_per_chip_init)(struct hfi2_devdata *dd);
>> +	void (*init_other)(struct hfi2_devdata *dd);
>> +	int (*late_per_chip_init)(struct hfi2_devdata *dd);
>> +	void (*start_port)(struct hfi2_pportdata *ppd);
>> +	void (*stop_port)(struct hfi2_pportdata *ppd);
>> +	void (*put_tid)(struct hfi2_ctxtdata *rcd, u32 index,
>> +			u32 type, unsigned long pa, u16 order, bool flush);
>> +	void (*rcv_array_wc_fill)(struct hfi2_ctxtdata *rcd, u32 index,
>> +				  u32 type);
>> +	void (*set_port_tid_config)(struct hfi2_devdata *dd, int pidx, u16 ctxt,
>> +				    u32 eager_base, u16 alloced,
>> +				    u32 expected_base, u32 expected_count);
>> +	void (*set_port_max_mtu)(struct hfi2_pportdata *ppd, u32 maxvlmtu);
>> +	void (*update_rcv_hdr_size)(struct hfi2_pportdata *ppd, u16 ctxt,
>> +				    u32 size);
>> +	bool (*check_synth_status)(struct hfi2_devdata *dd);
>> +	void (*update_synth_status)(struct hfi2_devdata *dd);
>> +	u64 (*create_pbc)(struct hfi2_pportdata *ppd, bool loopback, u64 flags,
>> +			  int srate_mbs, u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
>> +	void (*set_pio_integrity)(struct hfi2_devdata *dd, u32 pidx, u32 ctxt, int type,
>> +				  enum spi_cmds cmd);
>> +	int (*find_used_resources)(struct hfi2_devdata *dd);
>> +	void (*read_link_quality)(struct hfi2_pportdata *ppd, u8 *link_quality);
>> +	void (*set_rheq_addr)(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr);
>> +	void (*handle_link_bounce)(struct work_struct *work);
>> +	void (*enable_rcv_context)(struct hfi2_pportdata *ppd, u16 ctxt,
>> +				   u64 *kctxt_ctrl, bool enable);
> 
> Do you really need function pointers inside driver? It makes possible refactoring harder.

We do use function pointers in a number of places because of performance 
reasons. However these are more for abstracting away the differences 
between the different chips. I'll consult with the team and see if we 
can clean this up any.

>> + * hfi2_set_rcd_head - add accessor for rcd head
>> + * @rcd: the context
>> + * @head: the new head
>> + */
>> +static inline void hfi2_set_rcd_head(struct hfi2_ctxtdata *rcd, u32 head)
>> +{
>> +	rcd->head = head;
>> +}
> 
> Do we really need to define such basic operation?

I'm going to say probalby not. My guess is there was other stuff in 
there at one point and it's been whittled down to this. I'll clean this 
up. Same with all the other ones.

>> +static inline int valid_opa_max_mtu(unsigned int mtu)
>> +{
>> +	return mtu >= 2048 &&
>> +		(valid_ib_mtu(mtu) || mtu == 8192 || mtu == 10240);
>> +}
> 
> No to module parameter.

Why? This has been a long standing knob available to users. Same with 
many of the others below. We can look into whittling them down if they 
are not being used regularly. Some of these are important for tuning 
performance and are meant to be tuned driver wide at init time, not per 
hfi instance which generally is my litmus test for if something can be a 
module paramter.

Perhaps it would be better dealt with as a follow on patch to this 
series to refine the whole set?

Thanks for the detailed review. Anything not addressed specifically 
will be included in a v2 and noted in the change log.

-Denny


