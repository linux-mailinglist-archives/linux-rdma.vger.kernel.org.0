Return-Path: <linux-rdma+bounces-22661-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Gh/M0lSRWoS+goAu9opvQ
	(envelope-from <linux-rdma+bounces-22661-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 19:45:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8F6F06AA
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 19:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CKg5p33k;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22661-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22661-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AB10301FD61
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1A4BCAAE;
	Wed,  1 Jul 2026 17:43:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E24ADD94;
	Wed,  1 Jul 2026 17:43:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927785; cv=fail; b=ILb7rszgcZFLP8prZ0JpCpV1LGYhET5yt+PJSegXrsoYs3ZXp7yaxZUJsqPh2KdPrsujQsijmTWk5KaefHGrwHeIczN/A273rXoapQkj7qVrYsIgquNshAj3diHvJCnfotHziAdNClqJOOyptFYJ7ZkPPV0uqMv5zomigv804sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927785; c=relaxed/simple;
	bh=lIOfIxqF1yhzddC8kR6B6qnczir4D1CxfUTORaEN7ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDDhL15rIRSv8ijfwLLk0H6DFxAQAooIzwISr7BqL4288cy6wNrM3u/0YXiwVJnTOWY0LDGuT/nNC7kziVlhnCdqlEQuv7kfzgOSnvfgHYdNlJa/+nrtNZx7GPeIlpGeFxKsaaDJ/ISz9GZDfi0oLDnWZjRV5rOOWr5CFWpjBB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKg5p33k; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqZR3UkJcRmRjbUdzOjL+zLwBxfzDuWZ9VnjC5zUf58PoPhIqMPVNwBFMa4vr2iBPP98xQtjtZpEnYJ1BJabwSBNwpdj/SdGUpxIay/kqcCh36abd8MmyZh5E1x36XE5zPuJ/dgekyQUKN6EJR/QnqeYHLvmIUQPJBkjro7GauVfQpZ6o8fm5XTx9fKfZWeSWTJ20+rizmHbySHQD+fKo0lPkr9LYXn9R6uIklx13IoUiiAWvtHG7pmHAbBnfQ7EH+m/8G5y+uABrUElLmhkLzq1zgi5qeqAKtZZVFExe4urPLe6bb4qYHLiobIJxKUr9fa59RjNsFJdkD9oraNoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sornevo84XadK6N3oG6/iP5ttgCq/m9AFWt1XzxYoPU=;
 b=RrEb5KO+U2ATryvpx/hC3/JqM/6RFCGYc6kAKZLM2bZZWH1gsNnwk/Ux6YWMZPy4LqlGNYzSRWEKCAvlxt6K6Yq0AHpFs/vX9P3fsvSiu8hMQMDIfEKrJ5Gu39j8wJ/k4lveV8MK9mlfl2v7WYf6OGdm8GsnPeYYgOGuLjbXpqMDWTwpR9sl255zOBa0V+GJ2BN6tlUt91Avs9A7mgH6Vlh7fMheYg6JYkvf7QoA5kJxjUsSIVgd1QPH4ZgzqrelKJKCxJp+g4eozpOVdXFDlemOV8Zh9zkMWuGaCiMl6/vGbKoxRWxhWKljl+j5+ZGnfl8rNaQmzceq0ldjwPRL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sornevo84XadK6N3oG6/iP5ttgCq/m9AFWt1XzxYoPU=;
 b=CKg5p33kqhIBHvg60bm5Z6jEF9UVHf+zClD/J/uEw4mkUJZURU87udlRkXv04la0ofP7Rw0wBz1IMgbCWdW4bx1BEihs30fQdEHq45+poAhgJKdaNyPbBGsfQxzHmGJPAcRXlUsBwCAUC0EehHfnaNacIBHFNWj8rQlQDfQw1FKK7sos7QsatkCDqWENlT1poVo5jdWw0Y7Schq8y1kKoMB+pP7gtgybi7W0X5tr76Iaqjt0y5E4iVMFOePESvq20oEnh5kNIT1bBsCv4DZawLe0w0zHH9E4YqsTyOtuE/is7g8D+i69KiFc9ne/aHrAiASea8QdXoZdUBM7UefFTw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 17:43:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 17:42:59 +0000
Message-ID: <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
Date: Wed, 1 Jul 2026 20:42:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com> <akThPmvUHvCMT2cp@FV6GYCPJ69>
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
 <akUfXyKioGNAO_iB@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <akUfXyKioGNAO_iB@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0bdb56-f9c4-4401-278e-08ded7983156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VBISuDmh1c3rS3m3bob+vs4m+OoC0b6e68C6nYjbaAlCio7qtfxa6yng6idz3Kk9XJwaohaIJqG+z7FaneUCzUFpia0S18gC6VEYO09J0zVKM2Pk/jPa+5l1dkxX7mkD/RqJSR6HKilq0+Kpcu31InKqTI5pYGMGDghNbd3N+ERepDNdYxEuLZyVsxTUlJ4fsmvCQOtmJOVsgWUQxw0g0Bfr2ouuf6T/ARqbo7wdkmnzaBHQboCF0lfq6woKBJljJGhT/2eSBiUN5LPR/Im/ix6qqL1GxvEHEsHRjkqjvh6kUwPP2LmDG2ep/WdOH7cL4MKm2Eq4O7ae7fMvG2QHyMbuRSxwzgc/gVeHCPN0/ZQKCMJcf3Ewp+H9/CeR7PhvS/l99Eby5bQLdTkxi/II4g47Ior3OysiGSJUBYgjodPB9iGRtTxEHDiRNsgvfsd0we0EdaVGf/x6ACaEc+uIzOFvb6GT/6vGWQm0tV3doLDZy8ZJpwtw0lWux1zSyJn2wYYOAhnmO+jnNyG4F8dRNl7OGVYHVDhW646dteBrkSFAULXCYV97OJ8lXFgPhLOM0ncc9pAy39/+1H/xOY6SL8r7gT7CJdgC2BJ80H/bHUqVxaGIFiomikrGpegWLVG21QU/OxL6gezgDr8fGvEc/8Quece4CHN5RvaDZvZ6feo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFEyaTNwOTN5TERBaFM5Mmx4WGFUNTdFM0VOT3RQZDB2VkwyTTNSN3BnRUQ5?=
 =?utf-8?B?U2NLc1VxRmQ1a2tnaC9ETlJuT1B3NTF6WnpKM3gxcWUwMTFnYzJHbmNPM08r?=
 =?utf-8?B?amdiWUJ1c1pIM01iUWwzcEI2SGw3REc5Vkx1Y3dxWkhaM3VCQUlkSnQrdC8y?=
 =?utf-8?B?SXdiQ2Z2Q09ZN3pSaXFOWDZjSDRMZWdxTi9HY3QyZ1AzWHNWekhNWlVweHNV?=
 =?utf-8?B?Y3YwS3FVSkNCcHBMcjNKRmE0NGthaTYwbndqVE8vRHduWnNBY3YvaXI2Y1pn?=
 =?utf-8?B?b3V6UkluRlZCc2RVMWJVSnlyQUxmcnFXSkxYTWI2c2p6NFh0eVduNTFIWXZq?=
 =?utf-8?B?aFVvUVAyTVpzMnp4eEpFQUJHYWxLKzFtNTlsSWZMRkJwc3EvNmJjaWdIODJM?=
 =?utf-8?B?Z1Q5STdweXhtcjlodDZoajlKTytucjY5WGE2Tm5UdjFSOGZWMzFxZEpQVXhK?=
 =?utf-8?B?QjAvVzFOR0NSSXhWeCtyYTFXMmNhZGlXTEtKTnJXU0IvbFhESXptd1BGOFRt?=
 =?utf-8?B?MjRjU2ZDR0NPUzkvOEJyZm5waWZmeDYrZ1hzSkdBN0xBbXJPU25icmlqdmtz?=
 =?utf-8?B?WUxxY3RFMXBKSEFLZE00M1JTQkNybW4rT25kdmNWY2JPNGdHRHBrYnZoUk5p?=
 =?utf-8?B?VFkyVmdUaGdOZnV4WjNwTExCZ3dLN2ZhUTdrUVlmRnhGenRRdEphZ3N6RXZI?=
 =?utf-8?B?NVNjZ3l3VDZmTG5BcHY3VXFzT3VvOWpXVkk1emxvZ09FTFVTWENScVYyS1NP?=
 =?utf-8?B?OE1DNWgzVC81OS9TWjhEZTFXaEs4bUFxQVk2RGdhLzFWcDBIbTFrRi9NUG1a?=
 =?utf-8?B?ZElPdDZsb2xrOHlrN0JvNS9VUFFnR1hyUzlFRlF3b21qbkpIWFU2R05WTUp2?=
 =?utf-8?B?Y3lmM1dXRCs2Y1QrL3gzNTdPTEVCZDJ2aVRvaW4vMG54S3JjUXdqUHFxK2JS?=
 =?utf-8?B?TGxlbmNlSWh2WGd6bVY3Q0RWcG90c3AwQnFCUk81VmwvOVRwaEVQTEl6Rm9M?=
 =?utf-8?B?d20xdndCS0hOWDc3Q0drVHVEUFgzWFBRaTV6ZGlSZGxWTFRaZnRpUDRRQW5C?=
 =?utf-8?B?MUZhcm1QbTkrV0I0MXcrcTF6R01YRGorWTJxalRwTHd5Q1JDM0tXekV3Y3Jr?=
 =?utf-8?B?eHJtNUp0WWUyQ3dqeFdNVUx2dENXcEgxbWpJTS9DMkFIbENtMWdnNGpTQno0?=
 =?utf-8?B?V01RS2tTRmhhQWs0aG5EeWw2MjZWeDh3czBnUS80TERGaDZaUUZiZmZUTFRZ?=
 =?utf-8?B?QlpJei9yeVFsT0h2UVYzM09WMlQvYlB4L2k4dkt0MEp6U0txUXZ5VXVHYkRC?=
 =?utf-8?B?M3R1U2Ztc2ZPOTV5eDE2UHZZZTgyYjhKbVRKeWFiOGdpcXBsb3RBQ0lKQmdy?=
 =?utf-8?B?dWFSelFveEpjdXJzMStqRmhHMm84MmdkWVJ6OFpNLytTS2FmMkxvUmxueXRD?=
 =?utf-8?B?aXgrVCtudU5xTzd2eldxVENYa3N6WFo2WjAwK0FVVm4xZjkxUTdHekZPOUFH?=
 =?utf-8?B?NGdMMnN3YU1yRCtQU3JiU0hLbGs1dmxWMzNab3JSSnF3dm5hUjZSTGFzNUY2?=
 =?utf-8?B?eHM1a21keEtZK3dMK2NyYWNtMnQ0Ylhqc29EREE4ckVBZGVWUTVkbTB1YURK?=
 =?utf-8?B?SXcwRzJacFdUQkM0WGphTFcvQUhjT21vblo5ZnhUOWRMQjd0ajdvSFZ5R3d6?=
 =?utf-8?B?VnRuUjRBNFVZdDN4Z3ZSS3QzS25PTElSOHIxNzY0VHJYK1NuNkNjdlVRTjdq?=
 =?utf-8?B?Y0w3WGJRSlg5MFlYK3NaQVZlV0thMUlicS96cXc3K2h0SjY4NHdNQWdHdlpG?=
 =?utf-8?B?Vzh5YzNzTnpjRUpreTE4WkQyTENVN3BtRno0ZlRydmt3WFBLSUtBdWs3VkEz?=
 =?utf-8?B?dER0TG5zbU1IeDFLaHg0UWhlWjdLcStPa2ZEU2Q2RnhzTTZuQ3h6emVGbng5?=
 =?utf-8?B?WE1TKzZxOXFCTDV1Z2RyRlI2WEViNk9tTE9WN3ZEODJTVU4zTTY3TzZ5eWRk?=
 =?utf-8?B?eG5FbkI1TEkzaU1CdWlqTytVcEc3RnYvTTgxN09FaFVzdnZaZFdoUGE5eWVY?=
 =?utf-8?B?Znk0cnNWd3BGOC9uRytkald0K2NFaWFUaWFXa01JR0NwN1dTT3AwTlJmdVVu?=
 =?utf-8?B?QTRzci96YStabi9uY2RoOS9mZ2pOQXdzVU5pbzBCM2swbXRVSkhDclVOVVNh?=
 =?utf-8?B?bW9MRFJoYURGb1c0dHEvelpxQzNycGRvaUNzL3FCQVRRRGJFbHRmZVF0QkZY?=
 =?utf-8?B?M3NLWkpRVTIyREhNbzVlR2pRNXNzMXYyb2FkMUdCMVpOWm5pUFZONDBBcUl2?=
 =?utf-8?B?Rk9iQmR2cHZLb2lxMmJ4YWgxdkcxN0phY3lwcHkvVWEyci9PSmxKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0bdb56-f9c4-4401-278e-08ded7983156
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 17:42:59.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxRWpkmM/ARyQ2wPNKRXTC5l5Kw+GDg645NLwZsjXt5FSMDd1HLRfHhbpRb4dCr5eP8V0B+rJm8oBMKImOoknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22661-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32F8F6F06AA



On 01/07/2026 17:09, Jiri Pirko wrote:
> Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 01/07/2026 12:48, Jiri Pirko wrote:
>>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>> and after successful reload.
>>>>
>>>> devl_register() may still be called before the device is ready for an
>>>
>>> How so? I would assume that driver calls devl_register only after
>>> everything is up and running and ready. If not, isn't it a bug?
>>>
>>
>> You would think so :)
>>
>> Some drivers, mlx5 included, call devl_register() while holding the
>> devlink instance lock and then finish setting up state before releasing
>> the lock.
>>
>> In v3 I tried to enforce exactly that model, move devl_register() to
>> be the last thing the driver does. Jakub pushed back on making that a
>> general rule. So in v4 I changed the approach. devl_register() only
>> schedules the work, and the actual eswitch mode change can run only
>> after the driver releases the devlink lock.
> 
> Wouldn't it make sense to use a completion instead of loop-reschedule of
> delayed work?

Just to make sure I understand the suggestion, this would mean that the
work waits until the devlink lock holder drops the lock, and devl_unlock()
would signal it, something like:

void devl_unlock(struct devlink *devlink)
{
	ool complete_apply = devlink->default_esw_mode_apply_pending;

	mutex_unlock(&devlink->lock);

	if (complete_apply)
		complete(&devlink->default_esw_mode_apply_ready);
}

That would avoid the retry loop, but it also means the queued work 
sleeps until the driver drops devl_lock. It does keep one worker
blocked per pending instance and adds this default-esw-mode signalling to
the generic devl_unlock() path.

The delayed retry was meant to avoid a sleeping worker and keep the
instances independent. If one devlink instance is still locked, we just
try it again later while other instances can progress.

If you prefer the completion approach I can switch to it, but I don't see
it as simpler overall.

Mark

> 
>>
>> Mark
>>
>>>
>>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>>> flag for the registration path. Registration queues the work, and the
>>>> worker tries to take the devlink instance lock.
>>>>
>>>> If the lock is busy, the worker requeues itself with a delay.
>>>>
>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>> already holds the devlink instance lock and the driver has completed
>>>> reload_up(). Clear pending work and apply the default directly from the
>>>> reload path instead of queueing work.
>>>>
>>>> If a user sets eswitch mode through netlink before the pending
>>>> registration work runs, clear the pending flag so the queued default does
>>>> not override that user request. Cancel pending default apply work when
>>>> freeing the devlink instance.
>>>
>>> These AI generated code descriptive messages are generally not very
>>> useful :(
>>>
>>


