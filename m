Return-Path: <linux-rdma+bounces-13970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E2BFBAB3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 13:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4395E4E7A7D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8633EAF3;
	Wed, 22 Oct 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wk3ZUkaH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA0132A3E5;
	Wed, 22 Oct 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133105; cv=fail; b=N85zPHVKiqlF0BPcmZtn1Nkwq3moYc3bH09YcLuJVOeDQ15rDFMf0iDdxxGXq9pxaPM15EPTsS+aCzs/shX8AT2qWPRau6t3E6wsFjqEwGxqng7RMz3toA/WNQA6cw1WuM0/GmgnUcYvuprBfdOGbz6HbbJ8fbRtJf+Ry6pdHTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133105; c=relaxed/simple;
	bh=QD5sKv+t+FkdFQ9bNLJlZ1s+ryO36WpM/UoCnXPqNJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ta576te1rIwsLHM1Rl2z2xoSUolwgq9FBalLVbvjMj9k9ua5Df3VpaAahsUC8jXyujdbJEIpHzgm+5zvBADHFWONEVBox3ki4zRagmzbCm/0+4X4CDDI8/OCYSyHjc/j2MrXMxUZaQBcJ1su4gWRNnpTIuHtsIC6k6O4Jj88PT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wk3ZUkaH; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3O7fg1ii4N5neFtzUj8jkHznWYktmyBoHerOBBifPFxdWw/XCRpuLnaIDrD56W6ltIr21dL3cHzTAfbfiR1pDucV53+Ueia42XHEbc2RPRvBhJj84vhnIMOk5EgC4arEVNsqOhTP7fRt73DOitVhcdeWVVTwH/cYyaH9dSn/eeIoq1wh724GeyYwB5ffVGEZIfij9PC8dsPRAA2wnNBiz/EGDXeMlyiz6Vjd0SiavyIGR3TckrPwXcapDJlF1ANlh/bplIbmfhNxjwR6Vny2h83YXxnKIEbeX5XUpKZwP1I6DqBZCIzLX8ykhKrUoSFvFOlqaG0zugma7R9cu1B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjHYUnntTKHvZLJJhPO2JhDY5/OopOUCuY0HJbQE8AY=;
 b=weMG3LUMqoj4jwpbC+b86YFOeTE95KHQDeVbt2e2xh2/wAAFy/C94miGkvNgl0g1jct2D8gS170J26e+lvWSGBoZvZ8/YP/9QrXZ7LOhgdLm1cChuTLtTHQmJJpDe1nJjMWoaamEVQJdSMiaBCsR8zJRJfipn8pr5bl1suOSVfuodV/Ntj4UN/289D/3bPTDzqvAVxd82kASWiqhQc0REXfPZHEc/zs6lroR8d6wkiKWButnXhWJ4x516+3/b4Vs9Yi2NSBRdoIrL9ATyHZepyEo1Qck6h5gFS+p0AYxX/217nYoQr8cuGdjsqAl83N/aLd7eI1DS6xjSgJVU5DDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjHYUnntTKHvZLJJhPO2JhDY5/OopOUCuY0HJbQE8AY=;
 b=Wk3ZUkaHqW9ykZbf3Fy/ijGpdpKazJONWoJicvcfoBV+eV0XjA0hfsSbajv8z2fxMslrdfBWYQL3v+ZtZhNoKtKDJDqu6vZ+WJnWll+tBjsziMc15o0CJedmdZfhEhWS9D+cyaT0pIEOOr2g0l/sBstfvJLCbE37RRwO0Y085JH/Ssx3PazdwJV1cfiU1q5TKztdIpUF6aPAlY9t0WcS1LDIzlgR3rp+FWKTt25q/kOZcDDlYGvLG1CBPfqKBZWRuDT6XM9hmTxsBN7nOb9cKzogzHTvxlrARKYvJvMuWwcKLk/6VGU7YI6rDjBFaBIuTLfHxEbILUL14VTIgIej5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 11:38:20 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 11:38:20 +0000
Message-ID: <ae854fd5-dda1-416a-9327-ac8f9f7d25ba@nvidia.com>
Date: Wed, 22 Oct 2025 14:38:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Sabrina Dubroca <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
 <1760943954-909301-3-git-send-email-tariqt@nvidia.com>
 <aPemno8TB-McfE24@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aPemno8TB-McfE24@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 52311fd6-4bde-408b-5bd4-08de115f7fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3F6NnZqbWR5cFpzNUNIdDloemh4YVZvSmxFZFdLdzlOQU1BS3lYSThDYWZU?=
 =?utf-8?B?eUxIQTVxbU5vK0hxelR0VDlKVXZKMkR3QmFFSUZUZ0g3d3B6YWVFM0ZBalFj?=
 =?utf-8?B?T2xUd3kzcVZrR1VtNERkNnUyOXVjZ1VWYStxWmpFdExlUzA1Q1ZzTTBpUG1x?=
 =?utf-8?B?WG1NUGxBemRzUitkcXpMemwzdG04Ry8rRVhhcGZRNWlNdnhEN0pEeTRIcVJi?=
 =?utf-8?B?VVZIclh3RGRHd0pJNEpzNGllcHQ5eVVCUUZRWTJBNWdOSHRyaENMTEsvNS84?=
 =?utf-8?B?LzNncFJ0NFIwR2lSN3hma0JVc1U1Q0VNMXVUaWhlU3FIZ2JoV2VoRU4yQ3B3?=
 =?utf-8?B?S1NHekl3SlVDQUFkMVhmc1hsTGo3a2ZmSm5GWm5nRW5QakZuMGdabTc5Uk51?=
 =?utf-8?B?WHZIT3U1NTZYQjhLRmJUdHd5d3JnOUdKa2EybllTTW5xVXB3VEt4ZGpvRkVO?=
 =?utf-8?B?TDIvdkdOTHVwUkZOMEI0RWwxOGtSdGNsV3hyYXRnOCtVTFVmZFl4SmNBaFMz?=
 =?utf-8?B?b3VJVTMxdkIzdmN1R0gvc2NZQVluUkpvMjk2cFd0VTh5TXJLejJGTmV3TGNj?=
 =?utf-8?B?SVJJL1pMalRuK2JtaXVKNlA3ZllYc2ZBMkZ5YkN4R2h2dXJEZUtRSjFEYlhi?=
 =?utf-8?B?T0N2alJkR0wrdWJuREI1aCtTSHBTbENUUmhLVnJDa2MxNXMwODlDRlZ5UmF5?=
 =?utf-8?B?Q2srM3NkNmZCdWFRZytOZ0VaeFFwYUYvVHpiazA3SG1WMmFrZ3NSTEg4TmxH?=
 =?utf-8?B?NkFTRFFscTFRRWlMRVBhSW52ODN5ZDFFeFUyWWdsU0J5YzhHeHd6UjdyNFNw?=
 =?utf-8?B?UTZaaVNDaDRCOHRoeGY0RU95c3A1RDZvTmJOc3ZNaFF2aXo0ZGVxajU2aHR3?=
 =?utf-8?B?SjcwSVFobnlMbXNGaFZNZWdIT054cWdFSHFQbUJEZzUyNTM2V0FWMlJFMVdC?=
 =?utf-8?B?WHVsOHorazdZUXZGYlhyNGd3V2FLS2JhQ2xGK2RhWVpIMllJVlhhK0ZacWpU?=
 =?utf-8?B?UW9XV3J6SlRnVlNGVlBmbTZvY05GMC85OFJFejVzMm9nTHFzaHd2ZDZxMFRD?=
 =?utf-8?B?anlFbG5yZGtDMjFUNjZKcE4rNUZFZjhjVzVFMFpnVGFEay9HY0hCUHVybkw0?=
 =?utf-8?B?ZTZ4WEZZNWRVbGRsTlA0RHlqVlJXeDgycmlveEE2dE1mcjB3Y0ZVMlF1WUo5?=
 =?utf-8?B?Nk5sN3MyVHhubmxSOFlNUjluM2JseFQzNkh0aVU0MmlaWWJMUVRHSXZQOU1Z?=
 =?utf-8?B?TWxHS3dXMDVyN0NQZDRKc0dJbE9tSVhuV0g3WDBjRGZxejBJdWJCZ0RuWTRP?=
 =?utf-8?B?MWw1UWc0MFZFblkxYy9pa1J3M1gvSWlLc1FaQW9CbVppNEY0NVlBYmI2blVD?=
 =?utf-8?B?SkJNYlhseUpUN2M4K0Y5TkVDTUZEQkI4NVJCd1o4WVUybXU5a0VTdGhMSnor?=
 =?utf-8?B?MWdBUHNmUjRsVXIzZ3hWZ0w2aWtPbUtFeUd5WjhxT2l4Vm5udFJMQXJvdlF6?=
 =?utf-8?B?U2g1aGxuanQ2UmJJZXVCTVZDR0MxMFJLUWFqVXlLN01FTFltaytiQnF0WXpz?=
 =?utf-8?B?Y1lMMnNYVTF5NWFINHM2SmtCNlozR3hob1N5c2tZbGRMWXNOMXRYeDB2MzhF?=
 =?utf-8?B?cGtRSm40bzc2bGtwN2FrV0ZuUTVkY05HTUNPUzJIeE1ObjlNMVYvUllia1Jk?=
 =?utf-8?B?Y2FBSi81RTNsT1NEeW92SlFQYUJOdjVha3BhSmVBck9pZWlkMW9qc0x3WUll?=
 =?utf-8?B?MEVnRDZHbm40a0Y4Ty9HLzJCSEp0S25iTG8rbDNsS0JDOSthTnN5LzVYQW5r?=
 =?utf-8?B?OGFNUjJPRFNySFExV0R1UEcxVUZSQlFLN2pKdlBkUkFrUEhoZkxUQ1VoQWZY?=
 =?utf-8?B?MDdKTG82TElhMFNGdXljY0xJR0ZyR3pRcFdPTHNYYXU1ckl5N3FVUkdBWVFy?=
 =?utf-8?Q?2EqB7aYpWzqQFX/M+jxulUcdLgArWzNX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZOTlZzZGxnd3RvUnRYZ0hJMEowTWNsQW8vdU5XeGhIek1OeG9ZelFxN2pl?=
 =?utf-8?B?cGZaOHlSenFVa2RJZjVSeVU2dWNDS1pidXRmaW1kdU1aeEIwczZGOWQyZVl6?=
 =?utf-8?B?T1JacjNENUR3VVBYUWRsdkNJeFdCeEtaMnRHL1VUZmpxRTVMNThFVDhWdkpu?=
 =?utf-8?B?M2VRRFFReC9zWjJTekhzUlROc0FJR1kwVlg0bk8zWkVYZjZ5cUdPck9VZ2ho?=
 =?utf-8?B?SVc0Q3dGZXJ2WlZQN1RrSnRwOFNSc2FYL1RzOU5LQW14NElkVjhzcUMvQWhC?=
 =?utf-8?B?cVRaQkQxRlhtWHBrU1FEbkFBVUZObzYzOWxxVWdBSEpCekFadnV5SFNPejRR?=
 =?utf-8?B?QkkxT1NUTVR1OGxKeVRXQkU1NjhUZWI1YUZFZkRSUTVxODJtZkRpL2hiNncy?=
 =?utf-8?B?STJMV1NsdW0ydXpJblk0dHJVL3diU0JkLzV0QVhITmRWWTEyZjF5SmJWMVhW?=
 =?utf-8?B?SEI3cnNFM0tJL1ZFMDcrYm1pSFk0NW8vR0lvUlY2a1VtZWpyTTNkMENMNDhF?=
 =?utf-8?B?MCtteHVPa2U3Y3FzeXNHcldsUmdQaklvNEJ4RUhFeWRkdWxEZy9BdWgrMEla?=
 =?utf-8?B?RExyYWN3UEJPMTNyVWpiTUlrY1hVOTg2alJBeEkzWkdXTFF2YjVMYlFlUm8v?=
 =?utf-8?B?ZG8xYzNHTWtwQk1IOWh2V0dVQzQ2MnE5OVFnc2diUERHaVdsMjRQR2RlS2Uv?=
 =?utf-8?B?b2FLUnltc1JmM0V3ZTg2RDd2Y0FVT2VZZkpyVTR5a1A2bndiMnIwZzA5dUVE?=
 =?utf-8?B?aU8yN253b1F6QnMyamRudFlWOGxVc3ZXaFlNU24zVWVNc0VjZUc3V0tUOUx0?=
 =?utf-8?B?SDVRUXBPNFNYc3lBaG9RRkUwTm1KNlcxUW1TU1JlWXhmY0F4VjRKTUpzL3BC?=
 =?utf-8?B?Z0E4WUpuNm1hVWFwdmxFUnNnT3Z5OWRPTGdOMEJRMm9yTTI5TGhnekdTdmZj?=
 =?utf-8?B?OW9CK3BZcGU5Sjlmc20rbVM5TFVjRlhRZTkzaFg0a1gwbEZISlhRcFMwSlRz?=
 =?utf-8?B?QXFmMnhmUjI1aUw5QjRrdUxCQ3ZwZzJ6cmJKOVV3YmVLaE1KeGhoY2VZQTlL?=
 =?utf-8?B?WGgxVFhQUGNTVjNLTm96OU9sekZVNWFWTjRLRnJ6QlpkZE90QnJmVXViV0Ni?=
 =?utf-8?B?TU1Xb1duRDRDSmZzTmoxdk83aVVUNzA1THRic2ZMY1F3ektPeG9RYnZEV1E1?=
 =?utf-8?B?bEdTczNhRjVGRitBdEQybWwvbVFadm5iYTA1bUhqd2dOZ3dDVXhxWDFkYlcv?=
 =?utf-8?B?L29GbzJGcVhSMDIwbHJRQjRhNjlkQTNZbFIxRldPRTFnZkErS2pLcS9NMGpL?=
 =?utf-8?B?dHZGS214YmhJZzAxdWlEY2NuVHBtU0JQZ3J3VEVtMFpRdWw3YnhYTEpvYmdQ?=
 =?utf-8?B?V0E5OWlkWURYV1VScDU5WllUQ0RqVm5OOThYSnhkZXpCODZwdjJqdE5EUkJE?=
 =?utf-8?B?RExsVVN2OFZsQmtuT0k3QnNLR3VGbS82L3FzZUVJb0hTSFBiR1pBUC9FdU1z?=
 =?utf-8?B?eitkTW5vRmdCR2g1OURTbUpmeEdoTDEvTmVuOVUvdE0wOGJVZG5CL3dwcy9I?=
 =?utf-8?B?MHREcEF1VG9GQU5IR21wVW44NkRYRFAydThUZUNGSmY2WDNEWkxrOGRUcjdE?=
 =?utf-8?B?Rll0UWpCRExqbnR6cXRtUkt5MmtIZ0xreDRFNXpRQWt3Lzk0dnVidHFESDMw?=
 =?utf-8?B?VFNFS0NsTzZlbGttRUdhOFpZN0FmMGFTYXRtMDA5UTVSUHhSQUpvc3VKNFRl?=
 =?utf-8?B?cS9FdE9EVUNHU0kyM3ltdW5XNDM3YkVFOWRSak1XYkQ3dkxvejhhZW45L1gy?=
 =?utf-8?B?VWdQb2kwYWJSTlQxT0FCVGlhMWlxV3pKSlg5MVVUS0dnT2RzUzVtZTYwQW9I?=
 =?utf-8?B?amp3V0Y4d1NFUWxLdzhJcVJaZm9WbkZqWGxwRk5uNWtGRWZiVWNYbTFDcWNI?=
 =?utf-8?B?dWsrNlVnczNNT3JUcVI1dEg4SE9HTkdVR01ZdG9XbnUySFlBNGFpdWZKNlh1?=
 =?utf-8?B?UEd0Mkhvemg3Q2VYTjBLZno0V0NiWHlEdkdTSitoL245Mk5uK0FtaklockNY?=
 =?utf-8?B?bXhTSkdUN1A1dklWRGdqdnFpNDZEeUoxZU5rR2ZRNUphM1NDMHdTeHoyeURU?=
 =?utf-8?Q?dBfdu0bpHVB9DsN3R7EZFz5/9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52311fd6-4bde-408b-5bd4-08de115f7fff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 11:38:20.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/g1nRgZ0Jd6dZTNXyr57RuH7JFz3nV9HDYSh/sMxRQC5dqToYD0i+9orfr4MED1mBIRDNaFf/Uwbji9jBStLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654



On 21/10/2025 18:28, Sabrina Dubroca wrote:
> nit if you end up respinning, there's a typo in the subject:
> s/rdc_delta/rcd_delta/
> 
> 
> 2025-10-20, 10:05:53 +0300, Tariq Toukan wrote:
>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> When a netdev issues a RX async resync request for a TLS connection,
>> the TLS module handles it by logging record headers and attempting to
>> match them to the tcp_sn provided by the device. If a match is found,
>> the TLS module approves the tcp_sn for resynchronization.
>>
>> While waiting for a device response, the TLS module also increments
>> rcd_delta each time a new TLS record is received, tracking the distance
>> from the original resync request.
>>
>> However, if the device response is delayed or fails (e.g due to
>> unstable connection and device getting out of tracking, hardware
>> errors, resource exhaustion etc.), the TLS module keeps logging and
>> incrementing, which can lead to a WARN() when rcd_delta exceeds the
>> threshold.
>>
>> To address this, introduce tls_offload_rx_resync_async_request_cancel()
>> to explicitly cancel resync requests when a device response failure is
>> detected. Call this helper also as a final safeguard when rcd_delta
>> crosses its threshold, as reaching this point implies that earlier
>> cancellation did not occur.
>>
>> Fixes: 138559b9f99d ("net/tls: Fix wrong record sn in async mode of device resync")
> 
> The patch itself looks good, but what issue is fixed within this
> patch? The helper will be useful in the next patch, but right now
> we're only resetting the resync_async status. The only change I see
> (without patch 3) is that we won't call tls_device_rx_resync_async()
> next time we decrypt a record in SW, but it wouldn't have done
> anything.
> 
> Actually, also in patch 1/3, there is no "fix" is in that patch.
> 

I agree about patch 1/3 so I'll remove the fixes tag.

For this patch, indeed at this point the WARN() was already fired,
however, the bug being addressed is the unnecessary work the TLS module
continues to do. For my liking, the wasted CPU cycles and resources
alone justify the fix, even if we've already issued a warning.
What do you think?

