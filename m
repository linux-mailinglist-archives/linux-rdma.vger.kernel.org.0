Return-Path: <linux-rdma+bounces-22155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cYukNxPJK2r0EwQAu9opvQ
	(envelope-from <linux-rdma+bounces-22155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C0677F94
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cCW6rxYg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22155-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22155-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FC9D30488DD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D31367B9D;
	Fri, 12 Jun 2026 08:53:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB31E5724;
	Fri, 12 Jun 2026 08:53:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254417; cv=fail; b=AjnDIe1nzSJFUzF8Wxaq+d8+87D5a8cgEwsxHsVZHOmutjMeMgpQIzw/+45hfR4xOw9Ax5NstBbpBD5t81iijuS8U/C6NC8TSq7YDGPFPZaQ/SQEdvL8HU2R4yMClwaRFgR9MpSf+K4/as1HReXI1vs5cKGSjv8YPN/OAlYNuBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254417; c=relaxed/simple;
	bh=kucxFz4v3GsO8zKfOllazi3oKImcdKdBzq6sSjvSJPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQx08S2GQrUPRk2yWfkJTXVSMZUomk/6JsUrqJSKeSr+OL5WM8Sk9hOWh40TuxWkD9UUqA7nsFuQgXu73RHWfHc90kvcQmkhXSwMswuGTqWqxvsjW+UbO0aFg5RgG2YxSwc+w6teXo3fr6qkd9sxpC1P5GScidyfO+bm6mNAG/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCW6rxYg; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNgFGKuvlBQeXBxYwHuvQzwzT8iE4xTxQTcWGm22sP4GKBlsQ+pQBrToqhfAlkPVBCC2cWCHGmBYRVmFRrh8DKTGdb6QlWuU8fcXZ+W3RudwlFVPGJYRNasGHC3qZlGPVvjPytsuBnGcqZ3V8RBPr82ms7Rj0x8gC2v9gmzLRcUHHUY/Z3x+fNxM8ugGoteCNtx4pT1foe76KKk71Y0BPxh1kW8rRMbiUtEHPLZoIsU1thS3N/+atcwUdk8DbFjSpKmIJVjlJPNb1SysA3yYOuGmFdpLBCL0xpfT5aEW0LXXau7Q2OrtNQEtRBlELVx82bC8rbEUTWBxIs7j5oRLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq3u1701sjAwczatNV18goMsDbARV7ZsowhhY6aQn4g=;
 b=Q+5oZYfJBVYkqfhz4kUNcfmZLwwvYl3T4tFwthQY8M9+oIJwp36YpW2J6vFPR6XHzwdr+1vpFlnCThsZ8OIAQHCyjggGIOXRteYB72Sc+Jy3/0s8rLcANxtPxTS8LCd6rxzjnx+ZJqf+w+cz8MgxujKucx6E3KbKNczNUs+zErbeh0wvBQHgBFf9Nrleemq7aiQyikYOn4i/5s2n77aftrS/rFwwKqmxgELAPE8Rd0PJ6/UNzbWqd7DTseAGHlLmay0jIs2VaYH3DZyCaywzRelwgPHcyNGjCh1LC7EHuTzpkS2DRk5KxiGd11n+fOcZiE7dqVfJrNo3u0mJ5w83yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq3u1701sjAwczatNV18goMsDbARV7ZsowhhY6aQn4g=;
 b=cCW6rxYg+OSDASLyisbRBAqH0ARZSG/h3WlXECST//GAkXYGGLzdR/E9n47VLKxSwlFUPxiDPlsf9t/GuYqAAK+Irpq3MLT2c5rTFJIPtrGyWJmKMUp+QRWsxspWTP0irsmuPAvG7rq/jJ/K52cfPqLj6Sr2ExNeOb8KgdIPYy4w2L3i3SEfZd7wiR4NQUm3doye9OZaTr6whEm+wRkxjOA6f9azfXXnZBsmGBzmBjfsXsI3+PkKcaBheuAHeI8Pc4NbuinTd+OoxlK7hheo9kLGDp0o1uktQCwpfmykkd6167OGAqkU5os6Ox9Yoz8PhX5CJrp0h5YLtHhuhorVvg==
Received: from PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:53:32 +0000
Received: from PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4]) by PH0PR12MB7095.namprd12.prod.outlook.com
 ([fe80::a1a2:8f39:886b:30d4%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 08:53:31 +0000
Message-ID: <5760fd46-247b-494f-9fbf-fbb520c829cd@nvidia.com>
Date: Fri, 12 Jun 2026 11:53:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 0/6] RDMA: Fix restrack UAF in QP/CQ/SRQ destroy
To: Jason Gunthorpe <jgg@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
 Maor Gottlieb <maorg@mellanox.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Gal Pressman <galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>,
 Mark Bloch <markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>,
 Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
 <20260611191104.GA1501742@nvidia.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20260611191104.GA1501742@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To PH0PR12MB7095.namprd12.prod.outlook.com
 (2603:10b6:510:21d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7095:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a79845-df59-43b1-1ae1-08dec8601433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3C6R3w8/la6MadJcgIIOhZpUI5X80QCvJYfi9lrnLxN4/3ZGIfyv5/qjSrSshbSobaGKfvTlNJG46BgDSvuSgbeBLTCRFyCoQGOD3T1+cu+vIGoeHmSyEFQf7bV2D1OQN+4aTTmLcjhwTEt/nh/v9oZ78G/uuvfwm+6nfWvg2vg9S0N27KS0C3AlCKY68rZYBpzoSFOPvBNs8qiS9kLMnt6BQ19U7entcuCFFsA1w3fX9xT0qmWAqgJPsMbc/ewF3uQXyQcjQo5YtvfAvgpVEWk8d022kRYuBbUo5WVAy23cuu/I6zD9ddUM0dFbYC+VpFKNvJW9GfDamqBW83NLRzk7ydvvGCb6GL5BWYRL/x0xF3cCR1cLjTNvwvU1S5Vhv3kI74EElC8Jt3MIUjXsolYoBog8Hv5n8cHDuNlLY5fTFV43t/uq1W8ZaJicyl4j3v+1s1IM/PyVD4JvYYZpyGXG0WV74oyz41g+smbLmj8rORJOgt0AsQMuJLDbXXb9t+vntDGLy9lYJGJ4/BllrInXR//B+sNJr7nlzzFL4e9EfdtW8ePzCBeAGJWpW5N/EPw5IlOWrYTIYGOepEZ8NhWTNbOavpRzIOzs4M/o7nLNLvNk21sW1n/wrQH/Tj+DPZbR90dwrPlo7oao9mlwVrLNwIpVS8QpgaeYoGclqtOw3qyuex+NKRvxDXKW9S/3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDFWdk15SDZvL0FqL2dXSnNXUTRhN2pubDBnN0JERFZCZW1uMkU0S2xPSlMr?=
 =?utf-8?B?VEc3Nmtna1YvSHp5aGJWSW1acnJrNWFIR0Q4S1dXcTlkWlJMQVVHMTB5K2J4?=
 =?utf-8?B?djVoMDQxc1doTTFldjQwVUtOQ2hURGM1VC82NHdMWVFNVWljaEM4OWhDY0I2?=
 =?utf-8?B?SUM2REFGYTVUU2N2cWRoVlFuMENqVFNvdXE2YW85aGp0dy9TUmFCeS9aSTNS?=
 =?utf-8?B?eTVqTGlKNjIxSUt4N1JuSDR5OW93d0J0SW1NZHdBb3c1b0RDcXd5ZURzQjVk?=
 =?utf-8?B?bUY1VDBpbm9qbU5XcXRKUGJiRytXVEViNGdpMzVCcGdJbnZCM3ZKaXVNeDlJ?=
 =?utf-8?B?YURSUGc5THRPZUkzVW5zNjBvQ1E3ZWNNV0NnUjZjSFovUklWZ3Jnc2lJejR5?=
 =?utf-8?B?UzFNL2NaVENLV3NDdzBoYUVPUjVWUVJmV2tFcTM3K3E2QW81ZnJSWmJOYkNx?=
 =?utf-8?B?VFN2bk9vOUl6T2lnMDFNQW9nTURqUm1maUNDSERwaGI0UU9oemZGbmVuZUp3?=
 =?utf-8?B?QWlka2hvNCt3NkxMUW1aK2hWSkNDU1UrOEpJVGMrTVIxcUhPcnl3Ylo5dkY4?=
 =?utf-8?B?Rld0NHFGajA1TWx4eFRkZHlZZXJxSVVBaTJGZ3NtQnVwTTJiVzIyVGZyRElr?=
 =?utf-8?B?QjJnRUd4eTVPc3BxTWRZeHl4S2YvNzNweXNkNWV4MzFLSGdFalNMMy8zTC9v?=
 =?utf-8?B?SnB2TDVuWVNPdGw1TVNVbUdvOGRzT3FqWWRxUWF5Z2xkL1Rkb0k0SmxwT1Fs?=
 =?utf-8?B?dSt1VmtVYlFhOEs5VGZKSjhhcXdTL3hEaTBhYnVab2RLRG01cHN2cGM0UXRD?=
 =?utf-8?B?VytrNG14N05DNXJ3ZCtsV1gvSlRHdkJCaFB1K2xBUzZGQVhKSGZzMjVqOVF3?=
 =?utf-8?B?ekI4UEROVVEyb1lTakpPTDZuZGtWM09VcTBSUDJTbmJ2d0tUdTJ5TW80c0xO?=
 =?utf-8?B?QTJrd25ISDJ5S1FyZDR5NmMrRU9tWHpPQVliYkhKay9sd1dvckw0N0U5bjBw?=
 =?utf-8?B?bGFXZ1dqd3k4RG5qQ2tiN2Z0WU9CYlE5Z0lIaFAxZ01xQUxCVC9iaXo4eCt2?=
 =?utf-8?B?Y0MwU0ZYNDVSMjZ4YjQ0R1N2SG55TUdkNFE5bFlhYy9NWmVpanhYS09NcytP?=
 =?utf-8?B?ZnJURDNEcmJqUFNOalJldHg2S2pMVmx4L3YxaWs5MkNqS1hRZ2VUZDVZUWp4?=
 =?utf-8?B?TjJTNzVIR096ZGU4dG1jV3ZEL2hlay9sdnc5ZVRjSWg0N0dsOFZYdzlReW1T?=
 =?utf-8?B?TmcrbEVWamRZK3ZNZDFzZEp1aXNGUEd6OVQwZmp2bVRZRmdOR3VweUdrRzdT?=
 =?utf-8?B?TUZnY09URUpZOGYwWFFiOTBXekhJK0tlSzBVRFRFTDgzQUlnSkIzZE9iNHhj?=
 =?utf-8?B?Q2UwMTBXUmxVeUswS2hUbVZJcG95a1JJQ3BKWlJsbTdyWllCaEVLRmJKVTBW?=
 =?utf-8?B?TkxlbERwUWlKRnMxTFNBSlRsMFYwdVVlMmxmNmxCWGFRdml2bU5PNmhPbjlk?=
 =?utf-8?B?d1preW5NQjlPRlFHdWZQTzZMZ0VhMkR4YTNpbVJoTlM0d0NieWY2Njk0eVhy?=
 =?utf-8?B?MGdCYWxoUjd4V1A2eFgrRDd5QktSWndYZUhhS0RMcDRLc0JDb2kvUURkS3Ur?=
 =?utf-8?B?UXkvVThZNUNqbm8vK3psWnJrb1VhQUsxZUpGNWpJL29wTVpVTUdNRzFhUkpl?=
 =?utf-8?B?THd5QmI4V2FOZDZLWDhDQ012RWlxMkFoSXBUdVFza3N3QVhtQm5wMzhMc01U?=
 =?utf-8?B?VG95K1ovVVdBVDg3RERRdVc3MC8wL2k0YlhLQ0lQbUpPUnVrclN1S1JUSHNS?=
 =?utf-8?B?L2FUT2hwSWZ0WjVKRDV2MEZ5YnhnaWNZK0lDZE43VC9TOXAxQlc1T2krTWQz?=
 =?utf-8?B?ZEE3V1RSdmppdzFGeTh3aFkrdlFMOHo3ODJTNkdhcHVPeXNINW9TZEd5K09P?=
 =?utf-8?B?akc5K2hqdTFreXlWTmp0UXNyTytCSDBNODBTUFQwSnhNUWwyak4yUnJ5YVpQ?=
 =?utf-8?B?SzNTTWcvNlpYSFVwSnJEZlQramQxbU5BTnRvbGFRTlNPekdkS2wxVkxuemFq?=
 =?utf-8?B?MlVndjdsbmJqaEdNZm1XczEwVW5XaWtzZ1E2cFNNallISGtoWjNBaFBMWmY0?=
 =?utf-8?B?NVdxYjFzWXI5N01raFI2RllnWXhGUmVPU2lZQm13STA0cEdGQ0ZmMGxPKzQ3?=
 =?utf-8?B?QTA3N0o3MXUvSFlRQ2REYVVPWGtWem5CNHNhcjB5SXIrS1AvM29pN1VoMW03?=
 =?utf-8?B?NDJUYzZqWlQzQnh3RldHOUhyYmlQTVl0KzBiaC9jbmM1c1N4R1BCaTVJT25l?=
 =?utf-8?B?RHNLS3c0bG9aVXIvRDN6NUZqTVZoU0htTmlTZk9sb2RoQ1NnQzB3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a79845-df59-43b1-1ae1-08dec8601433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:53:31.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaztXJaaEdW9qrNX8++EZHesT8QdkXUB3j4ifDbJY0bl+xssdbGwmh9ARrdgka5KebC/qYc2ewTQl05ygj/4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22155-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:edwards@nvidia.com,m:leon@kernel.org,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[phaddad@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phaddad@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546C0677F94


On 6/11/2026 10:11 PM, Jason Gunthorpe wrote:
> On Sun, Jun 07, 2026 at 09:18:07PM +0300, Edward Srouji wrote:
>> The resource-tracking (restrack) database is the back-end for the netlink
>> "rdma resource show" interface which pins objects with
>> rdma_restrack_get().
>> The QP/CQ/SRQ destroy flows call rdma_restrack_del() at the end of
>> ib_destroy_*_user(), after device->ops.destroy_*() had already freed the
>> vendor object. Therefore, a concurrent netlink dump could look the
>> object up and touch freed memory, causing a use-after-free via
>> ib_query_qp() for instance.
>>
>> Fix this by splitting the delete into a begin/commit/abort sequence:
>> begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
>> drops the birth reference and waits for in-flight readers to drain,
>> while keeping the index reserved. The destroy paths run begin_del()
>> first, then commit_del() on success or abort_del() on error.
>> abort_del() re-inserts into the reserved slot, so it needs no allocation
>> and cannot fail.
>>
>> The first two patches remove DCT and raw RSS QP restrack tracking as
>> they have never worked (their ID is unset/reserved at create time).
>>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>> ---
>> Patrisious Haddad (6):
>>        RDMA/mlx5: Remove DCT restrack tracking
>>        RDMA/mlx5: Remove raw RSS QP restrack tracking
>>        RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
>>        RDMA/core: Fix use after free in ib_query_qp()
>>        RDMA/core: Fix potential use after free in ib_destroy_cq_user()
>>        RDMA/core: Fix potential use after free in ib_destroy_srq_user()
> The pre-existing sashiko issues look real too, can you fix them also:
Sure but one of them is a false-positive though:
Before destroy_qp() is called, the counter is unconditionally unbound:
         rdma_counter_unbind_qp(qp, qp->port, true);
         ret = qp->device->ops.destroy_qp(qp, udata);
If destroy_qp() fails and we abort destruction here, the kref on the
counter was dropped in rdma_counter_unbind_qp(), but qp->counter is never
set to NULL.

This is actually wrong the qp->counter is actually set to NULL(inside 
the driver though not the core) so subsequent calls will hit the NULL 
check and return safely.
>
> https://sashiko.dev/#/patchset/20260607-restrack-uaf-fix-v1-0-d72e45eb76c2%40nvidia.com
>
> The sashiko notes about XA_ZERO_ENTRY seems to be really obviously
> wrong:
>
> void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
> 			void *old, void *entry, gfp_t gfp)
> {
> 	return xa_zero_to_null(__xa_cmpxchg_raw(xa, index, old, entry, gfp));
> }
> EXPORT_SYMBOL(__xa_cmpxchg);
>
> This looks legit:
>
> For instance, in drivers/infiniband/core/cq.c:ib_free_cq():
>      ret = cq->device->ops.destroy_cq(cq, NULL);
>      WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
>      rdma_restrack_del(&cq->res);
Agreed I seem to have missed this one and the counter_release_one().
>
> and so on
>
> Please send a series switching more/all places to commit/abort,
> probably there should be very few/no calls to a naked del left.

I wonder what about places where switching to commit/abort doesnt fix an 
actual bug.

I had a bigger series that changes all places but decided to send only 
critical ones instead.

For instance "ib_dealloc_pd_user()" I didnt fix since there is no 
rdma_restrack_get() for it currently so it cant hit this issue - should 
I fix that as well ?

and ib_dereg_mr_user() actually calls the delete at start so it doesnt 
have this issue (but it also doesnt readd it to restrack when driver OP 
fails) - but here I think thats by design since the MR would be in weird 
state and we dont want to track it ?
>
> This doesn't apply on top of the restrack_sync addition, please rebase
> it.
>
> You should probably be refactoring rdma_restrack_sync() and using its
> parts in this implementation since it does the same things.
>
> I don't think this should NULL the task on abort either, it doesn't
> seem necessary.
I dont NULL the task on abort(I do NULL it on commit_del() though , or 
were you talking about the restrack_sync() ?
>
> Jason

