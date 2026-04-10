Return-Path: <linux-rdma+bounces-19222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCbyMB2M2WnSqggAu9opvQ
	(envelope-from <linux-rdma+bounces-19222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 01:47:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B13DD8BD
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 01:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166D130329B9
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9A388E50;
	Fri, 10 Apr 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2HtptLD+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0F37FF7A;
	Fri, 10 Apr 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864666; cv=fail; b=Wx9sz7+cKTzSW63KZBL2Q8vTKqZSAA7q8Ewm2184Dkm2kAoCO66QrdgRiRFjmm/BDg0XYFdjsmflSSO7fuyZNW4L+9bmFC2FpKMR/rljz/xblhPcSnuwR4/HJSUnvb/0c6MEySZ2d6d7I/WZPckxCnXSUKxH76Id7hdcUqfP3Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864666; c=relaxed/simple;
	bh=N2u4406qslGMGAlP7GwFQipeGPqbMM/H6BzK+Ycj7dM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsA/L47C9qltmsn21QkAWhrC5k5tDH8cbiRhmvQMYkz72c5lGwb1ob21F94PerP/JHthMUpl+fTdsE1nFOxCZrmhg/lgdA4NO5OvTx+ZFmbYJEov/4c8cjkfatAwE4u1KPZMgs8ZblgH2JfoK5O33AhH93+G/MX5tzbkZkzIIao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2HtptLD+; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYpKMmDhoovam79mdTh7SXGncSLrPC9cHlDBL9/67/5a3WAGGiq7w0KT9qY4jLycA5sNeewvgeq+TIw1oFbdB4LZWztcx1Tnll9RfJVfJ31r2ZFgiyYqBGWFq5hiSUVfXsjHEMNkSe3inIOe4OBsQ5OwzlcuDX0YNc4jVecmIBo//ZCvF2C2hUbrT+0CTIBwMOZiknNPENUpVNhnNO1GnFFYp28436CcqSgHz/gD9Aj7leWK6bmBLwhbu3uDLya0jLlEzFK6Sc4NmG+4Km+e6oHjanCgJ/UdWtc8LnVQhwJTXGlLSM0GeMEliGMfZtPf8OA5tqQY5oMRsLTf2VxQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORjJzHqEfsHgNm4dN82QRLUIVuan/8U2zsVlz6EWIuM=;
 b=LCshgZiUz5R2Na6IK1bpWsi1bncKT+VwEz1pnoU0t5FD7vIgyep/lsJaBeUHbHNekjwmY/WUW9wnQwS3CNQcJjo8DHm829+g5M8YHfAUNOupWfs5g7vtQr2RRkgCJwKPDPRWPj7gAewgEguE/monRVIRez7q7JPOiZoyf0dL/sts3ksOaJUWEGP98yDqydLDoua868ITGdT/uaOrDFyGmakgUSnITbZWh4ACeq6vnLI2kEKTtr8bjdyWxZfesWE1NDMSR1bJUXYx0xm+FvKa/5HxMIgt7mLNcH1djdj7H3RaBprSn1qYOVGwXx8TFsyF4h5DMnNjv8zv5dc3v08ueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORjJzHqEfsHgNm4dN82QRLUIVuan/8U2zsVlz6EWIuM=;
 b=2HtptLD+UFhNFZ+ie08FKuPUcBjEk1tV83ww2k7VXsWk/5R4Kxms+UUSPkZGaHF6M76Rjsj+CJ+pdHc7GyFB8LgsMHZUxNanOciFPMai49pmjxGQZoc2zf9oDKTphpkUZ/lFpq1SI8kfU8yGzx502+LUNt/FFWtjYn6rkMHOJwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2797.namprd12.prod.outlook.com (2603:10b6:805:6e::22)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 23:44:22 +0000
Received: from SN6PR12MB2797.namprd12.prod.outlook.com
 ([fe80::1ef0:99a5:313e:a60b]) by SN6PR12MB2797.namprd12.prod.outlook.com
 ([fe80::1ef0:99a5:313e:a60b%7]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 23:44:21 +0000
Message-ID: <69c189b7-9896-41cf-b28f-5ed4c7b80d6a@amd.com>
Date: Fri, 10 Apr 2026 19:44:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: ionic: Add PHC state page for user space access
To: Jakub Kicinski <kuba@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, jgg@ziepe.ca,
 leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
 <20260401102501.3395305-3-abhijit.gangurde@amd.com>
 <20260401170600.312a23d1@kernel.org>
 <52cee89f-50e2-4569-a622-b03e711ab26b@amd.com>
 <20260410134311.785683cd@kernel.org>
Content-Language: en-US
From: Allen Hubbe <allen.hubbe@amd.com>
In-Reply-To: <20260410134311.785683cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:610:118::25) To SN6PR12MB2797.namprd12.prod.outlook.com
 (2603:10b6:805:6e::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2797:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: fe86a622-72f1-4142-853a-08de975b16e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QslgCj22Rw/w5me7qKDnY6E+YJ4MLE2zdnkglm/y8/9wO2ioYcBTwcB1QD3tO6A+1G3PGq8IxcYkfmtT9PVnemeBn0YT0lC8qJLQ1MrRmz81c8Dcp6TJ5OfGbw8B/QWH2SL9+7x89OzSAOtqNdDdHJbS6B577Da+teKr66m/gMsMM+uuMPJF1F/wK12Ateed9+6li7YiRR0ztCjJKJkcM0G1/y8lk2s0e8ZdmHH04zaFc60mlR1QZ8Y18GDAuQtyjNi/aHcDdRvRMjyrJUjf20d8pkEjE8Tgx5B++c0G4ZPNFs5ooFXyXpb9EV/htRW6P4BHjYncyZSyA7sGJ+OQ/rCx5zQe6vzm0OBxofMihDvZ/5tnpZEpOFsB9iX6NEa0NPwTXY9yOsQ3xjKwD2fR96+sP7m+Gk6tsoFVHkE0rTDkBWrJUqjC7Ub9OjN0xh+HtlDbToTs0NLMFLY1AisK5/flqHmP259B1ynnxtopBvk1lTjcsvWa2WcQHNyzuzaLuVOgIAzY9pL0MrIRDau6kcPUTLWM7tRyYdV+4XD79RxgNJc76IuEOZD6pTtrLgHouEjfwsfMAlhRvV0iEz9J0U9r8vSowAWeYz5RU64igkT30vEXQHUIKJx6bkcVRFZMIIZ3j1K0ZwFLxAbrmOZEYrlLMBCMBlNsYefb/zZ9ZL2BlnRnkQZJ+I+GUvUPA5wQGYA2joytWWSMdyvQER/VvW5sbNANGYF3r8QuoQOxAdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2797.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVUza0tUNGdrSEdJMTRxMVFFdG4zWGowWExGcnppWU5xNnBzVDNKWDYxa2VJ?=
 =?utf-8?B?cmRPMEx4djlCMkNpL2JCZmVSNjQ4T01HRXZRNk1pTUlpQkR1bnQrdExtOXBq?=
 =?utf-8?B?UXBmUk4vdHZLVVgvdlVpWUFTeGxneVVZTGZnWDhzaEExS0FWb3RJN0x1VWlh?=
 =?utf-8?B?QkxxOUNyL1BLZ2pMa0ptMjZuUGpOaHJvRzg2NnZVSzR2R1hYZ1Y4SldLd3pY?=
 =?utf-8?B?MHRDU0tESkNHZyswRXoveFIyVGNBYm9YSUZLUW5nakRkVERyS0JjWG9ZRVlS?=
 =?utf-8?B?ejRvWGJwUlc5cDZmWjlhd1NvdU9NZ0hDN1Zidmg1R1FIU2FWNXVKTGJjL2JS?=
 =?utf-8?B?NkdIWVpVNG50NmpkUFVyRTM1SlZRV1dkZzBMT3VreWNkWURwTkJKMDYrYm5K?=
 =?utf-8?B?ZVlHSHhmN1ZwOFlVQS83NFN6bFJYTVR2L05PRFJ1QmR1WlhxbVA0b2tUdWl6?=
 =?utf-8?B?eU5DbDRRczkzb3NtMTFkSlgveHNJWHhwc0QvMUpndUMrOUNwZFVISlZ4Z2hk?=
 =?utf-8?B?NHRKRktWRlJoR2FjQTIzYlh0YWZMU3laUHFNR2JvTlFudHFGWm02RTZaeUlt?=
 =?utf-8?B?cGpuTkNLSVVFVDRlTUMxVkdMb0VJTlJHOGR1aXVMVTRDbzlSVS9xVmY1Rmk3?=
 =?utf-8?B?ZVY4dFV4ekJYdE9EWFliaFdXU0dseEo1azh6ekdSYmFXZE5DMnM1Wk1mYnpZ?=
 =?utf-8?B?VHQvTXV0aSticU1tWXNsVUxuR1ZtSzZYTWlhbHo4SVlQdTgxd0NrTHh1U0o3?=
 =?utf-8?B?UWhwamJHMEtXVS85TUd5a3ZySzZRV2gvTlkwTzUzV01ubzY1ZlJ0K05Ibmk4?=
 =?utf-8?B?ditpZy9YVmpUUSsxa25DSis5Tlg5Z2pnNkJscUVzOW1PeW5xQ2o3VWRIcXQx?=
 =?utf-8?B?Z2trY0hqdHlIbzg5eHVwKzBZNWpTNjRIK25mWFpUYW9KSEl2cFNzMnZ5MVd3?=
 =?utf-8?B?UVBObWJjaHRQdFRrZnB6MVFKSzlSREpPc3loR2FvUVJodk9UZEtpMGpKdDVl?=
 =?utf-8?B?RkJKOUl0Nml4UXdxYkp5c0N1djBLSkcvYXVwZ09RcTlIeTl2Qm5RR3Z1enkr?=
 =?utf-8?B?OVQzY0hMQTZNQkFiN1MzOWhMZUhYTm5KSU4rb0dsaHozampXSTZ1dzI1cjFp?=
 =?utf-8?B?d0lZblZIOFp5c1BjeDZvVGJ0NWNKckh2ZWVNZ255cXFCZlVsUkhNeE1zK3oy?=
 =?utf-8?B?dEtqZGpJV29ZQWNXN2E3UUhHQVpROW5oUm9QVnprc2tlYmMzVXo5UTYraFRP?=
 =?utf-8?B?VHZOSTRWV2pYaDNxa3lXMlNoamw4WThCUlY0cjU2aVNTZjJqbWxpREEza2Ey?=
 =?utf-8?B?RGljU1RCSG1rM3lTRFlDWEhKcnJ1d0JFRGF2NHFWSWt2K2RZUUlVTUtIR0Fr?=
 =?utf-8?B?ekhubUlrcUhkK3UyczFiWDFnYy9zWXE0MEREbnNiZUY0V0MzcE5TalV6UDBO?=
 =?utf-8?B?UnUxK0RRWkhTcmczZ3cxQ1Bubk9oVkltZXY4d0NacnVQWjlySjVZWnppU2hO?=
 =?utf-8?B?RFNKSlpJZjdraEhFLzNZRWgzOVJsd05YeFpidGpsSEZ0Y2hIbVlnMTZVQlNh?=
 =?utf-8?B?ZzR6S2crTnJHYjVMakVxc0h0L29VRWZBRTBpcHZVbTRTZU1USlVRa2N0THo4?=
 =?utf-8?B?N05tczIxbC8vcy8rbEhsRjRyaHh0ZFIzRkNsVVFRS2swbGxsNUM5M3lMZGMz?=
 =?utf-8?B?VVp3MmhoSGhGeEFOcjVyTE82aHd0QW5pNWthbmJoMjFyNE1qWVIyd0JnVDQy?=
 =?utf-8?B?ck1jSHZFeS92cjlsN3lROVNHTGNjeHhhNFkwYTA1VjFuSElxOXI1YmJTQ2FK?=
 =?utf-8?B?ZlNOUmMrSmlHeVBDSFVXZnFnQ0lnSXNVRmdWdmorckJWY0dUTGRIV0JYS2o2?=
 =?utf-8?B?dlBXS2pLak9GdkhBRUFwNHZON2dEbk9iWXZPTXNhNnFndXFkNmk4Rm8rNjBX?=
 =?utf-8?B?QjNQU09nVUpJcXNmTmpjd1c2bEU2LzJ1RXpwWHNqNXdjN0FkZ3cxNC9RL2Rr?=
 =?utf-8?B?VnB3N2tWK0t6MDJrOGprV2s5czZ6Y3U4U3QzeHFxdFVsNkUydTl0bzFiNFIw?=
 =?utf-8?B?dzJNdjdraWk4akh3d3dnbnJMbDZFSVJGcmY2R0RmUzY1clZWNDRSa0hoYnFs?=
 =?utf-8?B?bHYzWkw0c3lYc28rTEtKWGtKRFgwUmNRMHhLbkR6cWVDZUlIbE1sSU85K3Ft?=
 =?utf-8?B?WVV4QndSU2RjTGgxM3BMUXBxdCtFVk5qMVB3VERJaEwzRzlaalBzSGZ6MG8z?=
 =?utf-8?B?UThuRm80ckc4eG9VTXRLYzF5QUtZMnkrVWNLbEpLcUtrYS9GaE9pTWhIbnhi?=
 =?utf-8?Q?8VHIZX2OoT/DWocuQg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe86a622-72f1-4142-853a-08de975b16e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2797.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 23:44:21.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFHvRMGICmSVw6KrrMWNalBZE6Ae+cYOcotyXB+QnQlUG016ItLblIw9lLTCj7Vf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19222-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allen.hubbe@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 534B13DD8BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 4:43 PM, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 09:10:09 -0400 Allen Hubbe wrote:
>>>> +struct ionic_phc_state {
>>>> +     __u32 seq;
>>>> +     __u32 rsvd;
>>>> +     __aligned_u64 mask;
>>>> +     __aligned_u64 tick;
>>>> +     __aligned_u64 nsec;
>>>> +     __aligned_u64 frac;
>>>> +     __u32 mult;
>>>> +     __u32 shift;
>>>> +};
>>>
>>> You're just exposing kernel timecounter internals.
>>> Why is this ionic uAPI and not something reusable by other drivers?
>>
>> The simple answer is just following the same approach as an existing
>> implementation.  See struct mlx5_ib_clock_info and
>> mlx5_update_clock_info_page().
>>
>> Making this common might risk presuming that other implementations will
>> be a similar design.  Compare these to the sfc driver.  The clock is
>> quite different from ionic and mlx5, not using timecounter, because
>> instead of a free-running cycle counter the hardware itself provides an
>> adjustable clock for timestamping.
> 
> So your augment is basically that drivers which don't use sw timecounter
> exist so we shouldn't bother creating common definitions for drivers
> that do? Why do we have common implementation of timecounter in the
> kernel at all then?
> 
> These are rhetorical questions.

There is no suggestion to get rid of timecounter in the kernel.

Maybe I've been overthinking this and misunderstood your first reply. 
Did you mean, just, why not move this to ib_user_verbs.h, struct 
ib_uverbs_phc_state, and use it from the vendor driver?

