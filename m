Return-Path: <linux-rdma+bounces-22080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R3KpOnGGKWrDYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:44:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910B66AF7B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=faMdGZV5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22080-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22080-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4237F32DABE8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C71426D19;
	Wed, 10 Jun 2026 15:26:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E083FCB0B;
	Wed, 10 Jun 2026 15:26:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105169; cv=fail; b=JRJh3xeh5lh4bcPJ8q9wFaLqAkYygxEuixIKoQNbYkUX6csznhLvDBB4MPiIPRaL6anA3I/xDDWmLXFh01VOsV5NroboevNl6WenIn36P3esXRWqMXybKWgssyRu2wyaX79kMVftd/jUDH3u/82eOYzigq7fM/sgvqdMjG8kalA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105169; c=relaxed/simple;
	bh=F//5wCZMqPG4kkLGQTPoeHCW8D6GYD9STWmWMmkSNHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuNnCEUf84VaH/ILJqLPUzlAM/H3nO8y4gZUpZoQUW4B2rDWJ5Y5Snksghd4ptaUGPW5g7aUDdEMGcZjFyJJEbT1VZPqk9Cw0t3gKi7kQUv8XfMj0Uo0Wfmub6KGg1Q1XT/Wo/gZnU5HPX9ZGGrINXEqdXbeQaFxnrSVyf+4hAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=faMdGZV5; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EafEBazMN1YKWHNhWR/WazPg6gGd9fy1QSa3KeljExTyk5vaRx7SvQK0Gyq4bs9sTw4DS5TI2jK6s+PNtcheaYvaCVIaEQ1Ez1MIhhYMf0VqKhldwa2GErNyl0vMGoA+4bT+Vjoomy4OkfMNc7iPpdAJRk/olQYGJdzxTS9occ5evJvWIU3b22RMw/lcpCO15XGID/2blwsQwbOAlaTub+bcYm1ulsBkFHqdz4/PumoPs50eFqasWS+AwnUqSU4lPZFWg/97FBQflE6pl7s8pPmOTBCp0BL+9cplefggLgUFoRNFrk0GLjSG7WraD9hVZdafQASwRw6Dr5YtNfQd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chmsQIzdvrWXEMLCL4c8iTY9dizM28ONRsNEEhsNhUs=;
 b=dzWRjs8KGupwG04khNT7zVdqs1oA2L3x8f4kyfRj+6oL2pHwHI0Bu7bSdf3gUQzsKNONiCNIw/7Nz7cqTay6Vd8sbnRswpgSqqT3uUEhuebi+DHOuqRJmhSispszNjGaBAZQ46nlSoghMUflrwndP1Xt+Yq1ghWlammDHDCSfIUotQANUySgHcAC3U8movOxIkCPf9kBq5uA5LQPIwGts+2TrCBrQ7WNB8Q3QnyzHHiyJja7mqhdq2EB7TRm9x7Xwf4P3q5xyu1yhcorTR6kwkbONXxfuyIAGCB8a1RiKmrui7wIyypGlXRtLzD6+i3nQXBQMSPvHsnYChp7DlYhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chmsQIzdvrWXEMLCL4c8iTY9dizM28ONRsNEEhsNhUs=;
 b=faMdGZV5PF4Gog/tqOLEj8MkNVrGozU9O3fNINE6S8J7x3KPLbAQJpbrgmLR9zL7eq9JCnIdyiel51M8U2OyjR+nWryWobiS0jUBvASdPBu9MNOLQl8xpStaelB/cklMA0BNxYoueks6rvElyG/WVYrbnGQ6FCwLTJFv2M6oaQI=
Received: from DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 15:26:05 +0000
Received: from DS0PR12MB7777.namprd12.prod.outlook.com
 ([fe80::826:25fa:4fd6:2d74]) by DS0PR12MB7777.namprd12.prod.outlook.com
 ([fe80::826:25fa:4fd6:2d74%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:26:04 +0000
Message-ID: <fd929374-57a3-f78b-d123-e6ac0a6fc10a@amd.com>
Date: Wed, 10 Jun 2026 20:55:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] RDMA/ionic: Support QP transport mode selection in
 create and modify
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
 <20260430123931.3256130-4-abhijit.gangurde@amd.com>
 <20260523191619.GA1605401@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20260523191619.GA1605401@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To DS0PR12MB7777.namprd12.prod.outlook.com
 (2603:10b6:8:153::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7777:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbee95c-f641-45a1-2747-08dec70495d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	c84xePgOsM40rpiFkWVtR+GZZcuOjPY2Y/wxeGq2lNKPHmKqd6TszA0MwkYVJZqajVdKIfYDv7879I23wtYj5MgkCtyeLDX0UYFO+eS6ZmgWkmud1vPxwNlMrRcfqWYW5xaI67A10IXW7G5fVlXabrqbKXI0gPEq54I7ul/ZVeO8f0sutTvL7GHjpstd29Sc8K/AV8JSRr1YPZn5vDnGi3weHcrBzoIQJJZEZosYp36+I7MuvMb3Z3gjZMgUN6uhGmMgJK/Z25p6aq9JEnWeMGdqXiIMTcWpLQ8W3AHxKFO5ofMeTVJiM+B+j7aPsbmYIGiq1U9H/ccnOAUrhX44JazCLgNRgGWYSQhc36D4MPs+U2h93jZgSoUlFtiY1lThwkdMTH3nXff70bcn1jRSQ8QhqWiAEDA8QZCi/qRPV5kZXm4zSQvOT1Wy7opO4IaC+BSZ8tHs8wxbrLQjQa1C0Po8ehqClS/KKoaTMubgPO5AKeXOiYF/b/m/QI2vGwUSN4qOab7OlT2iIHoV//NxAux9Z74r4ZxoagTjsYCPd6qBfTK+ijLLn00D9xHgGHIebfvypJw4QrNufLfR8LwivLJBM2ZwF0Anu4gVqDaRlHD5VUVemaxjZEnFV2iB9HGeRm4YsC7t9rt32ltLmYwdMVxzPtYsjJKm1jwPwrGNf5mNj5Cnfu7Vwq1iBwDmCJ5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFIdFJSUlNyb1ZWUDFqd0o0b2tUQm5xYnh4WFFyOWZQejdESVZUdEJRcUtZ?=
 =?utf-8?B?MlJ3U1RLOGNHckhSMkxpMUdBbncwQkh5R01QT0JRSlk0TUg5T285blZXTHNk?=
 =?utf-8?B?MC9nOHIrRktTa0xSQkt5cXZobWlXRFBiRVlEcy9UbnpJVWRKSnFKK2FFVmhw?=
 =?utf-8?B?dnNDb2liUnhmK1dFTGY1a1RqWXhpNU9ySTNTeG1EMFR6bWNLWWdNMGpuelRj?=
 =?utf-8?B?TVdXbEpGZUZFaVJiNU9UREJpRjk4dWd3dllEL2RBQ3FuNkxzbmNBNW0zQ1lk?=
 =?utf-8?B?TUxBVzlwYnlYbnNaV1lzUVFkMXA4N0FMN1BHeHhBbjQwdWcrbG9tSEE5RUgy?=
 =?utf-8?B?NEpHTDl6dmxwV3hJaDZFWkNobFdNb21yUjJ0V1hPY09IeTZwN0MrU0hneHd3?=
 =?utf-8?B?VzNkODhlZ0pzMXdkRWlWeEV6ZUFkTUdEN3F0M1llQlZtSXhPT0xiMm5Ga09Z?=
 =?utf-8?B?Nk5mT3pmRFRLSWJmMllGOU1tWFE3eW1aeGRyZndpQ0NPVUZ2YnNsQ0Z5STNv?=
 =?utf-8?B?aCtLOURnMjFBd3JrM0dHRytYTjlxbkN4eGU5UXd4VDcvM1hjbVN4NW9NSGVk?=
 =?utf-8?B?VjFOUTRDNmVEa0p0Yk15UDA4MnpXUGlTZzk4K0FoYWhXM1JLU2dMcXJlTE5q?=
 =?utf-8?B?Zk9SZUtoWkZJYjQwQWR6bWFHQ2cwbG9yNml5SHM2VnpUWm81ZGlYVGVWcUty?=
 =?utf-8?B?b2drWFZEREJ2SFVSUXFqMXZncmtJZFc1NFo5enZsT2FWK3VnQW9VUGpaZEJI?=
 =?utf-8?B?MDJLNk5GYnRvSTVuZ0tXV3JSdkE0SEp4WG9VcERMMFFjaC85WldYbUQvU3hB?=
 =?utf-8?B?UUc1Uk9qTFRlOURlWWVHcnZleVpsK0NRL2p1azk4ZklFTC93cWdPUnhmd2Fa?=
 =?utf-8?B?Qm43eFU3V3BLR0JWUnVJVUhydlgvQ3MyUDhXTEJiRkF3MXU1TmFLVmplc1BD?=
 =?utf-8?B?RUxNSmFsN2hEOVZMTDZEcmQ2R2lVY0tzemcyMWx3TnVMRUh3VHU1NzNWWHht?=
 =?utf-8?B?TlNKNVNxTlJLeFRkOXRUaVdjSWQrSjFLZSt6cW5BVStHaVhJbm5KaUh4cVBQ?=
 =?utf-8?B?c0wvQ3luajlZeWRmVzFTKzdqaWN5SlVROGhKY3VEc3N4Qmp5ZEdWTW0vekdF?=
 =?utf-8?B?NHFBOWgwVjlYUEdHL3Y0SW43K2IyVmcxUSsvMWl1Wi94dy8yWE56Q2xYdXBy?=
 =?utf-8?B?TG5oU2p2UmZnZm4vaFNHQ2R6SmcvSVFWREZySjR4TmRWYVRRUUFxSER6VXpO?=
 =?utf-8?B?M0hLYXplQ2dpdW9HYVM2VGNJOG1tNzdzdzdvaTVqQ2hYbldDR1ZjTWhINXJD?=
 =?utf-8?B?VmpSL3hBYi9sNmRiMTMzRnBzaGFBakxieFNpNXBJNzMxUko0ODFUOWZsaUN6?=
 =?utf-8?B?Wnp1TlN1RnM0dnVnTENlMS9CZlhPc2VXdk5DSCtPSG5vTXpVNE5YenhzQ1Ex?=
 =?utf-8?B?RldyQ1c3S1JFeHFLalZFUVp6bjZvMjB0VExUM3BlbXNuQVFQTUZzNUg3QkVR?=
 =?utf-8?B?Z1lFdkowaGx5d0hWNExDTjVYaWQwWmg1R29RSDNzbXdyQVo2eEFiQlpSK1Jy?=
 =?utf-8?B?ZDNUTk5pZno0V1N1WE1wWVh0Tldmc05LcC9xNGxsVDc1T0JvbTlDK0tWT1ZM?=
 =?utf-8?B?a2dRNDZRaHBLcytXVkxLazNtTm5pZFRmVXZ3M2pyZjBhYXUrRExUb1p6RHBB?=
 =?utf-8?B?YWhuUWhwZ0tKZEZuWGN2bzBHWHlZTUROQVQxVFllUEs2a01mOUFVNTM2czZF?=
 =?utf-8?B?OTdiYjE2TFdxSW1nWS9GR2NxQVd4L2dibEJKTlVpemJmWmxjZWNTczBQbXc0?=
 =?utf-8?B?MzhuUkhVOU96WUtMRDlheDNvMWxmL0xhb0J0VU14L3VlRkt6SmxYRzNwWEdT?=
 =?utf-8?B?K0RQK25jd2pFUUtCK01uNHJZMlA1Ti9aVzg5K3BhaXdzQThucnZmaFNiSzlJ?=
 =?utf-8?B?Q2RZVW1JbXVnQldtdVhaSDZPNU51NExjT0NaSzhpYTBvWmw3UDFpcENNNkc1?=
 =?utf-8?B?RldrNnByMG9qU1owQVo5UU9kUlVGMno1N091Tk91Rml3ZE4yeCs5dnEwMWI4?=
 =?utf-8?B?bzVsbDhDdm5WQXY1clJtQnAvNk55bStwcWFlN1BoR0hzSXpWeG5TTXdGRzNv?=
 =?utf-8?B?QUNGejlWWmVWbHhIOS9Yd25nS1JyK2dYVnBmaVdJd082T0ZVU0wzQngvREhG?=
 =?utf-8?B?ajNqWmsyQzNXbnpySWhORGVlV3l4c3pHVGMyeVU2ZklRYitEOXUva2ZHVUVi?=
 =?utf-8?B?V2hTSTNuTkl0dU52YzM5MCtBUmQvZktkRG5TcERBU0t0M1pVK2s5ZnJqYWNJ?=
 =?utf-8?B?M090OVo5SGcyRnd4NUowYjdlbTJ6RklLRGNrWVQ5ZitlVUNwTVhwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbee95c-f641-45a1-2747-08dec70495d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:26:04.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXAKKV8irwmrQYE//NARzNEP8Hl8IY2hQ4k4+Sy02pR6/o4bE26Q2iAxdty+Am1oEOwSWJyosOFn1UCtXkaa2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-22080-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6910B66AF7B

On 5/24/26 00:46, Jason Gunthorpe wrote:

> On Thu, Apr 30, 2026 at 06:09:31PM +0530, Abhijit Gangurde wrote:
>> +enum ionic_qp_transport_mode {
>> +	IONIC_QPT_TRANSPORT_ROCE_V2 = BIT(0),
>> +	IONIC_QPT_TRANSPORT_MRC = BIT(1),
>> +};
> I'm pretty sure you published this a few weeks too early :\
>
> Anyhow now that MRC is public and a real official multi-vendor spec I
> would like to see MRC be implemented in first class ways, not as
> driver hacks on the side please
>
> Jason

Thanks for the feedback.

Agreed that MRC deserves a proper first-class implementation now that 
the spec is public.
To align with that direction, I've reworked the series and dropped the 
MRC-specific pieces for now. The current version focuses only on 
introducing basic RCQ support in a minimal and self-contained way. The 
MRC-related functionality will be revisited and proposed separately once 
we have a design proposal for proper integration.
I'll post a revised series reflecting this shortly.

Abhijit


