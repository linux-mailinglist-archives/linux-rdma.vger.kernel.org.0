Return-Path: <linux-rdma+bounces-19193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNK0FmQQ2Gk0XAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:47:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A43CF963
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B076301E3FF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107033F5A9;
	Thu,  9 Apr 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nD2JaIXC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07E3382F4;
	Thu,  9 Apr 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767626; cv=fail; b=rOyyZzVWGNBBZHUoUxQY5gbQRhG9Bm7j9i6t+qOiCPede5t+73WNTjQkmhQtOodXFfR2o0Im108wC3HAmrW2jpFx1XcZsVAxYJlAFUpZG9x8dTwT6lUHS42a7WiSYR+lcXZgClpQz3Z/AjN4SK1oL0qz5FiyuvU0/SNidhBbx0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767626; c=relaxed/simple;
	bh=zf2+b0OYOvcdFWXZThYhG50BORU0kUIV+Fydf09WKHE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHgCO8sv2snDo4qv1q0v0pdgm2gOotcvY4WE/0cLGM2MKcehOaEK50WPWWBRS60zivp01dQg3iI+zNtmd78f0STMPIP4UxPzAsaySr/qRS5yjpwojzRKtkX54cUxyzvburQrtf3YrXNeXjK/uwJdUBfgPglDczzKo7h6JkwcnWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nD2JaIXC; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBnI4h8vAeavrWbqhR8dZPr/fsFLEl4G7lbOPnshiDJ+47Cmbz9TnLjgwdHA1EJYfUVqhLK5+F9MNPoQ4OzeyTWpwrx0TMuduusN6e0e9Y8kpsb3gs9uTsL7FDmQDkvHsYWa1Dd2Nd1Rr/T+au5oe9IJDTcbt4YFwWcMXuABFGyIwpeOVhAnjsHiExM6eEbOi0C3W0kVwatfFTyWTcYcT5hxVyAzOoyw5cZSdEyOEgFa9KLFkSslGvq+23ekQV3Qx8i+A091703Sfkkx+8Cfnhj0PffQwzaRx37ahirZKcm0+1JYLSXoHeJB0gRiyr1BvfetyIdMN4ellMGSX9bzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI1uxUd+ugGR94MJQBUonRgOJMf/65/S1zE2Pws4t/A=;
 b=V9Yk4VjJ2fkws8kAYhQ4xw4+wpn9z659QpGq/p5EDRdxNlrtrIJs3ALGQkWgr5UmLq16AX+A+GUVAFeU8fwCgAC/o6494X/C+khupelwFuqpBiDNeui2kogd++YO5gDAWRoyPgOj9kt1wE6WWNKXI2x8SiqesFWvZ4tx5Q/Ruu7RXNCcyCIj7QKA/plBidF3MCCxB7XUsewTDT3GtHdv1Mw2lRbIcB34OPFSc0n/HFuDyO4NM987a+tneWY0QJbEEC54QL1AWoQMCFy9nSSX69S3I1+GLrJbniDrG7xbY0jwk6xFfV1oWPR9yMdqhBaFtK3c2+CoY/7MoZYqwYpmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI1uxUd+ugGR94MJQBUonRgOJMf/65/S1zE2Pws4t/A=;
 b=nD2JaIXC/4YNlBIeG7LguBemXQ/m+hl3UsoSc/3Mi5teHdlbgZnfZpsf+xzl15kFWicH7CGBUZltmY1uCBfmLad09ob9eWfcnnChqUcREVX5XlVkOph1VjCRcX6JENymYYsCgfHiDqRq4+537mTU5LA+OSfoFIlrhgZT+6VHe8IUaJT1x3ms0OiyGs9PzjxX69TaAMyASh34HiFjtEuahTcXFtOCueqH3oHrCiUIlG9fsVqTA40AVKJScDV1uKVPgj1gDP901l3Av5Yy9G4dK5MHeJj/SZlxgc+i42H6jsFmTM+Qu1J8JJw0XBnbcGNpIJq8BwshPgpBLzokXuZi+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 20:47:01 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 20:47:01 +0000
Message-ID: <85479042-d982-48df-87aa-591d73346a59@nvidia.com>
Date: Thu, 9 Apr 2026 23:46:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Use dma_wmb() for completion queue
 doorbell updates
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Boris Pismenny <borisp@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Kees Cook <kees@kernel.org>,
 Akiva Goldberger <agoldberger@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260402055206.2311-1-lirongqing@baidu.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260402055206.2311-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ba9f1a-4b3e-44b4-3c68-08de96792643
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nrpTGJO9ppmm09fERAM7w5M+keejrLjnB1zsqT8pbSwOkehcibAEI8RTzxBHz9oHLpFLsWjZUpNTxxT0iFedQlThW9EABLBuhww5cbWzZuUqLh8jwFc54CBqO8LNBwtcFgj5UlbI12dncGrBENcFAKBdYDrhkPymWdJtDqKS8UlLUNNJ7tQKUUMcfLUyfDc68U0ktlJJGOdIrbEZXEmSSxR9Ueu0DbrfAAuK71ZWVSMGrBqvuguxanNQ1J9O9xIKUsvXR4SOFnnCDxOZrm+pUW6N+u45Fts2ZKbnNEveD7nNgb6KSJF53USLf5ceE8zCfYNuF4UR/iAGgHO33Iv9TZSwnZhqa63wydSeccQfNhxyR7UocXCEa9bqDPwDg4CE8xyV/j7WClAS5ir6L1Cds2CVroZizEDFaYmD41NEWU8qjZRsKsYaMofwCHENz9FKvD5+KYW1NjWRHSs3rqM0BbadotqI/vT9Fe54YO9w+HjMFIPkfvBnPS6xSci0s9euzdApPM7p522p064AS45R4tqzpN0V/MEfc2tJ0S3mgTNJ5qtBDkQngtVBrRsOwEq/ROhRqTsv8WZZx5F31DEOjzlu4kg7RYz9p40v4ZPokGP1SmmCPF3RQs7OvlP0WF/kez4z9bSYdNf5SnWz/YYk92VJCIGo0LunUQFt0y7twxvdzOeSy8VJvZWAUHP6S47o4xNGWc2mqckxpjckhoy2notItq3OUb6yKsbI1xtKAToEWG5CtSNzJcq1Sj6OTnNmeag5uBOODFi1IcueoMFAuN8RkpqjjSgN94lWmtkBfCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJndnF0aFJyMldiQ0U0RGVtMG1odnNKanBPTmU0R1U4T3A4a3VzdWNCWjZJ?=
 =?utf-8?B?Q2RBR3dZTUJSTGE5UElkQXJZNmlCd0xvTDZTN2NkbWhXeDNmeHR3VlMxczdS?=
 =?utf-8?B?RjQ0MjNKQ1pzc1B1T1BJeHhtcVQxbU5IZ1MxWi93RWdTRmV0M3JWZGhaSkpJ?=
 =?utf-8?B?MjF0SkdaZDhtckJOTW9UUlE5ZDBwb0pWOW45Vk9tSnd1bGJnTWpVTEtRUXV5?=
 =?utf-8?B?ekY3OXlkaGlVcVl5Zy94QVA3aEloVDZWUTNOOXRyemt4S3RtTHpoUnZ6QU5i?=
 =?utf-8?B?THZiZXQrWVlxRTg1R1d6OVNTTkVxT3RVNm1mVEhUeXhPRU5sSkpYQUV2WEZK?=
 =?utf-8?B?bWdHd2FnMUlXRXVvTkoyNTdKUlhHd24vUzVQWk41SVNqd3dyd0tWeStYMDdq?=
 =?utf-8?B?OW9DZlhpbEVuSmZGai9HOGRlbFpoK3BHWlJrcEl1d3oxOFBYZFM1QzVQaFFu?=
 =?utf-8?B?UTNRUk9DaU5IVklrNmp2WVJtd3JJTlZuQlpTQ0wvamhZS0o1eTlIQU5RdGhE?=
 =?utf-8?B?ZkF0YnlUL2RYMHQrZEFIUGZQbCtqOFJDTE1KWjhNdVM3NkNBVnlkb0J1TDky?=
 =?utf-8?B?RlVnZzJtVWxoRE9oTy9kcGd6N1pRMURieTU1ajhLY0VNcTZnd2tVZHVkVDVa?=
 =?utf-8?B?NDk0R2tNNEJqbWkrU3FRN2lLYjRiV082Q0x1aUIwYTRxQVVXZWJTSmxNZ2JY?=
 =?utf-8?B?dmtwNWoyWlRZdENxR2s2clA4b3FMVXFzaTBSc0xDck96Y3gzVzV1VE5iazdY?=
 =?utf-8?B?UnF3MUVLOGhNdXRPL1VmaElaZ0RjQm1YbDU3YXRCWGZTdzA0eGpDU09IVGRC?=
 =?utf-8?B?N3J1dG1NODlkZ2JqdXNzYzUxU3kwZ2Z5Z0Q5WXZVbmlUc3FZOGRUam45ODZ5?=
 =?utf-8?B?RlhxR1daT1RkYTBMV2hLSEVVcXRWbktWeHRkR2hoTWZKTXI2UCtHcnJQU3c0?=
 =?utf-8?B?SDVwTmNjUEpPWkRLMHBPamZzS2VkVzJGSlBrQ090aFl0aDN3dmNZUU8yQjRp?=
 =?utf-8?B?WFRMcGdKVDdOSXk1VVBucHN2dktPcGQ0UjQrVUNEOFRQQnVNSnczbjd2dVo4?=
 =?utf-8?B?VDFvaGVZQm1PWTVPa09EbzR0M1lYMk5xNkVhbjE3Zm1paG1UcFpNQ00zVHVi?=
 =?utf-8?B?MWJBVTRkMElMMUNDbzRoRXFpQjZBR3RNTGlJT3VQc2RTaGNXeWkyNW1sZytR?=
 =?utf-8?B?MHlySTMrcWVGK0tJU1dEVmNqUnZ4MzI3YmRMNS95bGl3UW9LTXI5QUNUYjNz?=
 =?utf-8?B?TkVYbUVZd3U0bldsVVVqS1BCSEVKYmdFdFc3MlM3QnZHUm1KWkM3dkVjT2Ri?=
 =?utf-8?B?dDVBTG90cnZpL0RwQzBDQzNLckpXdWUxbDREVjZTd0MrMXNTQ3poVXZ4N1RT?=
 =?utf-8?B?OU14Vm5pMHErSktwY0ZrWnc2MTRESkNNVnZjcVJvVjE0VVRHL0tuWHltclVY?=
 =?utf-8?B?WHJsWHpLWDV2dkZ0SHRuZnVCQ1B0L1FEemp4RzFUWElsbHdXQ1k2R1B2M1BE?=
 =?utf-8?B?VVhVQzdXYnEyS2hoMlBUc3VibnlTaDZCaExIeWJCSFhBaytET05zSThrcW5O?=
 =?utf-8?B?ZHMxSlhYejY3bEhhVG9Vb0hqSTRvK2Fuc1MrT0JOeGxCQ2VDL0ZzUW9hMFY0?=
 =?utf-8?B?MzNtalFQTTJzWklGTVI3UlMxTlR3WjlqNmhnMi9NY3RLMDMvYlA1aDVuMGdY?=
 =?utf-8?B?RDROb3BKdWZxNnZlSjdidEVINk1QTTJ2dFQzeHgwak5XTVBjMTBsOHhHYS8z?=
 =?utf-8?B?Y2lEUC9CYU8zV25QSXdrMzhYL3NlejkrV0NERnlLNHBmY3JzbzF3ditzNVEr?=
 =?utf-8?B?ZkVkalY3OTcxUTBHL0g0NmR6STQ3QWUvbnZTVEdVT2pDQWZEZ2c0UTlXeE9Y?=
 =?utf-8?B?QTJmbC9lSDFEVzlYQjJhY3gyZVVCMm9KUUR0KzdGd29HeFNVd2I4RXJHMGdI?=
 =?utf-8?B?TGh0S0RMQWduZCsvc3hWVnhnYTRMcFVRVzhZYzlTd2FxYVFRNVR6TkMwWERN?=
 =?utf-8?B?RFVVOU1sU2N5U3QvZWF1K1JYbkQxNzdOaE0rY0tXRUtTRlVUOGlFNVkvSVVJ?=
 =?utf-8?B?WnVZUXlUeTVPaC9GNWh5TzFDOFk5K1BPY25rNGZiaFdYUk1udzl1dFlleG5C?=
 =?utf-8?B?T3N3Y2dFQ3BJSXoxeFpURW83YUp6VDRER1BreXNLOFpVTmlPdDREaXRtUDYz?=
 =?utf-8?B?UkpnQVlaYnZFMnN3WG5SRnpvMWo3eENWTGYzcCt6eTQyajh2QUl4UHNKZXlF?=
 =?utf-8?B?YTNLODU2ZXlwN1RhTElpUGdCN29XdndCNDJ5TlFadmxHYklFbEZmU3JVSW1p?=
 =?utf-8?B?VlcyUDYybWJYQzhZQUx3aUlFZllGZ0ZLTW4vSUc5MGU4aFd0aXJydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ba9f1a-4b3e-44b4-3c68-08de96792643
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:47:01.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaIpjHqGqTvF0gpHX+WOnL5k/Jq9nkfSaqmwagSLjm633Ygo4fxRW0hFs7nKOt4o7RCb69GjEy1W+iQqCfWZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19193-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baidu.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF4A43CF963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 02/04/2026 8:52, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> dma_wmb() barriers are specifically for ordering writes to DMA
> coherent memory that is accessible to both the CPU and DMA capable
> devices.
> 
> The dma_wmb() barrier is lighter than wmb() on some architectures
> because it only ensures ordering for DMA writes, not for all writes
> including MMIO accesses.
> 
> In the MLX5 driver, completion queue (CQ) doorbell records are
> allocated as DMA coherent memory via mlx5_dma_zalloc_coherent_node().
> The CQ update pattern is:
>    1. Update CQ space (device reads via DMA)
>    2. Update doorbell record (device reads via DMA)
>    3. Memory barrier
>    4. Enable more CQEs
> 
> Since only DMA coherent memory accesses are involved (no MMIO accesses
> follow), can safely use dma_wmb() instead of wmb().
> 
> This change improves performance slightly on architectures where
> dma_wmb() is lighter than wmb().
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

Hi,

Sorry for the delay.
Thanks for your patch.

The idea looks valid.
This is the kind of patches that better go through intensive testing 
before acceptance, I'm picking it for internal testing and will update.

PS: I know you have one more patch [1] pending testing. It looks good so 
far, I'll verify and send an update soon.

Regards,
Tariq

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20260317003544.2583-1-lirongqing@baidu.com/

>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c    | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c    | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en_tx.c     | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c   | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/wc.c        | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> index 1b76647..7bd6dfc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -259,7 +259,7 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int napi_budget)
>   	mlx5_cqwq_update_db_record(cqwq);
>   
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   
>   	while (metadata_buff_sz > 0)
>   		mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 80f9fc1..dde8856 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -805,7 +805,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
>   	mlx5_cqwq_update_db_record(&cq->wq);
>   
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   
>   	sq->cc = sqcc;
>   	return (i == MLX5E_TX_CQ_POLL_BUDGET);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 268e208..f17e7f1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2447,7 +2447,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
>   	mlx5_cqwq_update_db_record(cqwq);
>   
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   
>   	return work_done;
>   }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index 9f02726..7ba319f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -849,7 +849,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
>   	mlx5_cqwq_update_db_record(&cq->wq);
>   
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   
>   	sq->dma_fifo_cc = dma_fifo_cc;
>   	sq->cc = sqcc;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> index 1f6bde5..1341874 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> @@ -384,7 +384,7 @@ static inline void mlx5_fpga_conn_cqes(struct mlx5_fpga_conn *conn,
>   
>   	mlx5_fpga_dbg(conn->fdev, "Re-arming CQ with cc# %u\n", conn->cq.wq.cc);
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   	mlx5_fpga_conn_arm_cq(conn);
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
> index 614cd57..8f7a89a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
> @@ -421,7 +421,7 @@ int mlx5_aso_poll_cq(struct mlx5_aso *aso, bool with_data)
>   	mlx5_cqwq_update_db_record(&cq->wq);
>   
>   	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
>   
>   	if (with_data)
>   		aso->cc += MLX5_ASO_WQEBBS_DATA;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> index 7d3d4d7..1afbdd19 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> @@ -314,7 +314,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, unsigned int *offset,
>   	/* ensure doorbell record is visible to device before ringing the
>   	 * doorbell
>   	 */
> -	wmb();
> +	dma_wmb();
>   
>   	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe), *offset);
>   


