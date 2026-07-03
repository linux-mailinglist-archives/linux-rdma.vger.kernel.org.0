Return-Path: <linux-rdma+bounces-22751-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fFSvDeMASGpIjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-22751-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 20:35:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD65704F6E
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 20:35:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=j7LOSUA2;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22751-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22751-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17763024A65
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C530ACE3;
	Fri,  3 Jul 2026 18:32:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807221DDC35;
	Fri,  3 Jul 2026 18:32:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103541; cv=fail; b=tHTY5far1vtOS3Kf6QVi2jtoZaTXI96Snv2SNPA5TPlFL6Y4kiVMAiYn8xVggQjyd90r2HiNzk8ivPPMGJbN/OzL88FQYIib+ZS2KlMbWMBFf8GcxCHnSDIwZRnhWZvf3LQFs0NCieUhBmqwuK8E1L0IP55Sl1zsbBAsFrqj6Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103541; c=relaxed/simple;
	bh=UZRv//56MJmqaUpR+jhih1Bs7HrvkUMmoFsiqNQAwAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ym8WNyz2znyFEZvV98w/9qQ/DIFU4m/rxmVZr0VTifBFOwgan7xX2vbNqbrgcLYew4/4VjFi9V06V9Fs7lqNSu+mApqfsQOV7LUofjHonSN3hEOZJY2achBBNgKe2WxjHS8pCZtj8NDq6j4ROwzR+EYwEGng8VQ12ApxPEXKmuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7LOSUA2; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHE2IuUhwprNYVDns2N/w8qoKFcyCde5sF6I6pDmjCf0qEp78KBZDvTbq19xOJPeO1hOD4yChHgDtpubEdr71mzrxgZs7xyU1MlsyCK2h8TnHEfOrEJboiYdvv9gc54oGI/JDxq6Cd9ZS1TEZnUZA2T0HBdpdebltOniFH44W1JlUQB+hRzPfOZdNkC7mVx41MAVV7ZbmLJlRjWn6osj6YXmrfGADZU4t++X4GEDevcGPX9PYYVmMbYj7ELiQWFhaUEF4BbUEBNzpuld4R8eVTrSYgoEyJFLxC8H1BNMTAneItD5fU64A0i046WKHlTvAjT/4Av1JzS54KxGfQFOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmIyN+CZ6DtyT4FcRNI4vco9tv5tcMQQZzmsDFRueIE=;
 b=OgP1ASnjZK5OjFsCoJYlFnHAhFMJvP1cpWeCjHF8YIbNC/l/3A6hh4DLDFFyzWrgaNZh9GbiDDv6g+/WaYsyHNKChitMGRINbWp0ICUKaNB2lipayE1W95bgM13Yuqr9yb3ebQW8x85gIaI7KUbW8JCSnSLQpCi/48imavoAQSlw3Uvghei63Yv167ERo0GHpWVPHBkvM4Zl52R2do+WS5LmVGCMckQu9i0ubW5YHIvAQq9I44j5C+CSjyAC9ITVqA3a39Zu/gd1k/766o/Dro4cpQL0X+ES8/djHlsPvOPz3o3iYWnDzLIzjNmEhOLXxnaYzJUy6h6DfXvwc9+VOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmIyN+CZ6DtyT4FcRNI4vco9tv5tcMQQZzmsDFRueIE=;
 b=j7LOSUA2PnfnKMd7o70vNGjx/F65gIdk8ROWs2VIfiz7vu969rvWUuG6ZHu1EjdkyIbvOPLtNtccTeUfdsQPVvqMrDeQRWyRBJppn05lLBDi0eTaY9KJ1KNX0otysIVx89MdnSoDp51A3SEi5fhhhpQtaSl+DNpXidqegj2I/BHcQHQboagPM20qy48YmP5FWyCpNl4UyUHEVk6QH6DkMtFJZogBQHN3twJVafL3Nb6OKh/ItcfhGfv2X5l3qWra7yMhgao0HriaAaYooiW5zEAhKHlA7ySDlVhiurB7rU3tqibz905Xy1RqUKrPBdTJgPw42sOOulaqd7kzzWSDBw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 18:32:16 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 18:32:16 +0000
Message-ID: <9bd07013-0d59-43a9-a5c2-0bbb8fa6a47b@nvidia.com>
Date: Fri, 3 Jul 2026 21:32:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
To: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
 <b8ff6104-790e-441f-a095-d50843d241c4@redhat.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <b8ff6104-790e-441f-a095-d50843d241c4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0998f519-bedd-4366-2ac7-08ded931683e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	06KA1MM6oV0OnVRzrbErpuYzujHhAv9iOsx6cQVJseCBGQSKdTAFlC10uBHakW1zL3a5LsE1UpO7U2akqjQWNooeH5fV4ChkQ2ZTcMUB7RJuVVA5BOYAuOAHBiq/4sKuNDrNY3rvGTC4yvTYspx3iGUZE4UgSKoeevwDkJPM8vL+xJAS33yaO+WrEHBBgT86U4iQxSHbfWdC/jUaUpvYneQuD4VDTpns4Ap1/NJz7sFsRDiMLhse8PFEbYQVX7rWhXXzmhfZ4IP+hTxv5cXT5jYrAGbGd6RlutxTYFwAeAYyolB86iY4/XND6W/FfSW9auUdVRI2aqrU0lkTo0jGVaYZJ2rlDEv7Lp6J69+fkViytR0FPGl+7UeiEWEOYgj68Mf7mESrXBzIKqwzMmmdk5fk2beQH/9Sai0xgrZ4TPFr7iMN7rXBOepwNpu0ekyHOxvPMf6HknoFSMkjmI15lxoD9CaBdKHdnxQabqtZCJeMWu0u3IHNI/aDsgoucNhEuLXrgujJJBeBkNtS4KnO/Z4Knqz96NxNMi6fqRRBgqp6igapYdrBssiUXr0I70uv2FNX788XETB3wZaTiKuO3re4D5OoJeKW90el5h/D5u/DugOVG9vhZaRgPr07aOG4cdjtrUDrVMTjB3ELg9H8kxFxcHgmVUCq8ZSBJ12ss6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUp5cmJweGx0WFVKUmp4R2UvY1ZNQ0FPN01aZm5MbDlMM0plNWhkMC9zLzcw?=
 =?utf-8?B?c2UyNnozK2lPV0xKSUlGbStmaS80Wm1uYjZCQ2dBNWhLaFBKMDhQd25ta1FN?=
 =?utf-8?B?Rk1zdnBNd2k0ajNhOEFzVG5ia1BDWGVPakpOUEJCWTZDL1hkQjE0b0IrbkJB?=
 =?utf-8?B?eG9LUXdqRGVGSkZ0Y0ZYVzl0Y0JPVUhJWXVueE5WWFJGK0JpS3FhQWY0SUsz?=
 =?utf-8?B?U3dISVdoVEhRZXpUMnoyK3NVUWxlNGVzQUVqWGtNdGovSmFvbzdUWERNdWlN?=
 =?utf-8?B?Tzl1MFJrMCtqNW92ZDZaWjluZVMzaDlDZ3JrWmw5dnUwMjlJQmQxeTFhcHVn?=
 =?utf-8?B?MHpRc0x5UVBtR1JhaFdYMUVDeThpcTVUTll6YWpaUS9YTURndVZiUGErd29k?=
 =?utf-8?B?WFdMb2hvaTNvMUx5QmlTWEdUd0J6WnlsUDlkV3BoUXFuRThWWXdyMHFBWkRv?=
 =?utf-8?B?QWtKWmliY2wxZmJTbmIraDROb3RuMWlpeUFpTjJ2cTFkczZJa3lGdUJhMzlT?=
 =?utf-8?B?dkhUdzN6VG1tSTNHRTd3TDFhWGl2cXRPbkpXZWJuWWFNZTBVUDlYRkZrVkFQ?=
 =?utf-8?B?dDFTL3VYOXFVZm9Wa3pGbExPb21RQ1JDNVEyTHlSNUVWUEZNMUxYN2NZalli?=
 =?utf-8?B?YlB5ZGNZOWhVZUZRTmluOU1sRXdDKzhiYkQ2MUhNbUZRNTVGWWNHOWNqb1Bo?=
 =?utf-8?B?clJNMTFMZkFlU3I5S3Y4Y0piajVlTzFsMndWdElXbmtOODN0Qk5mR2tPY1dC?=
 =?utf-8?B?bU1tTHg3TnJKb0VsWXpRbWVEVkQ5aXRSWnIraVVuemxpL3htTm5HZnh5eDZE?=
 =?utf-8?B?c3JiK2lONFMrM2ttVWdQZTNSWlVKdG15YlBJenJiZjRyNTNJYzY0K250a21z?=
 =?utf-8?B?NXBzU2Zqa3g0a3U3R0RXdW1pUzFsSHBQaGhhdkh3Nzl3NnZyUFhSdjIzL2ZC?=
 =?utf-8?B?c0EzN3FpQi9rTkNxZmtSOTJXSUFLTWVKZ2ZqYnpxZnBoVXEwRzdzQXc4QzJW?=
 =?utf-8?B?aDVROWpuTmFVSG5TT05VdHQ4ZTYxc3o4cldETm5HQzZ2eUJNczZwUm4rNk5T?=
 =?utf-8?B?V1lmcFAvSms1Wnl4L1hCb1c0NlYvMm9YaDBpWlVjRzlheHlvYTFGeDlDMjNL?=
 =?utf-8?B?Y1lQVmN0YkVZbXhyMmt4RnM0OUxSSmE3bVgvVWlua25XdGNMZjcya3VDVzJx?=
 =?utf-8?B?VFVhQ1hxOVhsRU5oc00wMUF6MzdWNDFNNlJUVkNLY2hZRU1DNXI4S0tXeXF2?=
 =?utf-8?B?dVQyZ0hEc3dXYVE2WmdvdnVuU3JGKzhzYTVzNHkrS3JHTXpQMzdyakZQL25a?=
 =?utf-8?B?Sk4xVVRVdUZlUUEwUUI3UzdKcklMT0d2Vyt3YVU1VEJvWWRQZ2ZaRW9ibjBP?=
 =?utf-8?B?SFBMOUswZGU1VHZ4ZmRuV0p4S0E4eHlSTlVOd3hCK3RXOFRQNnhvQjhQaU1t?=
 =?utf-8?B?cGZzd1BBSVo0L2RWWk9kTlVVcjZqQ2Y2bllkajJZWnd6ODJWd1FuRzFUS3ds?=
 =?utf-8?B?eUZpbVVyTmhhelVON1pJbGJXZ2VVcTQyUHB4YVJDK0JxOERJUnZUYnNVcHRp?=
 =?utf-8?B?dEJQdTFJL2FsbXdUYUZKaFE1Ync3ejZOcmYvek40WUZSNThoZGF0d2s4LzNL?=
 =?utf-8?B?eU5KcStOV3k1WXowd25IYVNhRjJxYUtScFpWUVVCczQxMEl0ODdHdUthUUw1?=
 =?utf-8?B?bjlySG9IeFk2TUVqNDRFTHJMTS9LQWF3UFdRTC9mK0QyTUo2U2wxZmZKK0My?=
 =?utf-8?B?dzE3Uyt5ajRKWDRaa2orbE0yYWZzSy9tTmVLck5xOHlDeHl0UFNNWG1zZzhH?=
 =?utf-8?B?cXFwK01DL2VjazdSS2RCZ0s3N1g1VUhXclJQNlpMRi9OTjY5Y2FRVFVrNDdL?=
 =?utf-8?B?MUVjcWlrU3E1L1pZWkd2c0tOcWtFVm80c3BTWWN4ZUR6L2g1eXpwTzZoQWkw?=
 =?utf-8?B?QWFZMmY5ZnBwc00vUDEyZzBVM21HMjg1WkZUcXNod2FOVzVxK3JKMEdSOUhX?=
 =?utf-8?B?a2xMWFdCdTZtcko3SzdNZWR4dllscTFKSTBJd3FDb0tnQUVQTTdGN1R5ZFdI?=
 =?utf-8?B?NFQ2UG5lbkV0Mkt0TlpVa0gvTUZFVnlxMWlJbGUvYkxLTjV5RERFbEp3REhn?=
 =?utf-8?B?YTlBeTJWWnhlaDZaYjlHVVh4SmJzdUZkdWtLVWVRY0x5VE9hQ2g0OTY2cXpB?=
 =?utf-8?B?UjhpM3JISzVuZGg1K3hZeXEzdzB3ZE1VeWFxLzArYXYzajJUQlgyOGVOemRX?=
 =?utf-8?B?eWlyQmNGcW9RamZPVUh5NE5Jc0grK3FaUnVmMXg5RnR1bHBsQmJ1Sm1HM2NI?=
 =?utf-8?Q?hoxaP01Aauy0oqjO36?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0998f519-bedd-4366-2ac7-08ded931683e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:32:16.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NZJLGt6Om/jALDhS2RjUoS6nQIkSb0i+00kywHAqbNzKJM0K7uy7ArljFz3YDGRjw3NI+HJRUi85HRET6q9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22751-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAD65704F6E



On 02/07/2026 10:41, Paolo Abeni wrote:
> On 6/29/26 8:20 PM, Mark Bloch wrote:
>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>> and after successful reload.
>>
>> devl_register() may still be called before the device is ready for an
>> eswitch mode change, so keep a per-devlink delayed work item and pending
>> flag for the registration path. Registration queues the work, and the
>> worker tries to take the devlink instance lock.
>>
>> If the lock is busy, the worker requeues itself with a delay.
>>
>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>> already holds the devlink instance lock and the driver has completed
>> reload_up(). Clear pending work and apply the default directly from the
>> reload path instead of queueing work.
>>
>> If a user sets eswitch mode through netlink before the pending
>> registration work runs, clear the pending flag so the queued default does
>> not override that user request. Cancel pending default apply work when
>> freeing the devlink instance.
>>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>>  net/devlink/core.c          | 198 +++++++++++++++++++++++++++++++-----
>>  net/devlink/dev.c           |   6 ++
>>  net/devlink/devl_internal.h |   5 +
>>  3 files changed, 182 insertions(+), 27 deletions(-)
>>
>> diff --git a/net/devlink/core.c b/net/devlink/core.c
>> index 5126509a9c4e..998e4ffd5dce 100644
>> --- a/net/devlink/core.c
>> +++ b/net/devlink/core.c
>> @@ -5,6 +5,7 @@
>>   */
>>  
>>  #include <linux/init.h>
>> +#include <linux/jiffies.h>
>>  #include <linux/list.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>> @@ -22,8 +23,12 @@ DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
>>  
>>  static char *devlink_default_esw_mode_param;
>>  static bool devlink_default_esw_mode_match_all;
>> +static bool devlink_default_esw_mode_enabled;
>>  static enum devlink_eswitch_mode devlink_default_esw_mode;
>>  static LIST_HEAD(devlink_default_esw_mode_nodes);
>> +static struct workqueue_struct *devlink_default_esw_mode_wq;
>> +
>> +#define DEVLINK_DEFAULT_ESW_MODE_APPLY_DELAY msecs_to_jiffies(100)
>>  
>>  struct devlink_default_esw_mode_node {
>>  	struct list_head list;
>> @@ -166,6 +171,7 @@ static void __init devlink_default_esw_mode_nodes_clear(void)
>>  	}
>>  
>>  	devlink_default_esw_mode_match_all = false;
>> +	devlink_default_esw_mode_enabled = false;
>>  }
>>  
>>  static int __init devlink_default_esw_mode_parse(char *str)
>> @@ -192,14 +198,113 @@ static int __init devlink_default_esw_mode_parse(char *str)
>>  		return err;
>>  
>>  	err = devlink_default_esw_mode_handles_parse(handles);
>> -	if (err)
>> +	if (err) {
>>  		devlink_default_esw_mode_nodes_clear();
>> -	else
>> +	} else {
>>  		devlink_default_esw_mode = esw_mode;
>> +		devlink_default_esw_mode_enabled = true;
>> +	}
>>  
>>  	return err;
>>  }
>>  
>> +static bool devlink_default_esw_mode_match(struct devlink *devlink)
>> +{
>> +	const char *bus_name = devlink_bus_name(devlink);
>> +	const char *dev_name = devlink_dev_name(devlink);
>> +	struct devlink_default_esw_mode_node *node;
>> +
>> +	if (devlink_default_esw_mode_match_all)
>> +		return true;
>> +
>> +	node = devlink_default_esw_mode_node_find(bus_name, dev_name);
>> +	return !!node;
>> +}
>> +
>> +void devlink_default_esw_mode_apply(struct devlink *devlink)
>> +{
>> +	const struct devlink_ops *ops = devlink->ops;
>> +	int err;
>> +
>> +	devl_assert_locked(devlink);
>> +
>> +	if (!devlink_default_esw_mode_match(devlink))
>> +		return;
>> +
>> +	if (!ops->eswitch_mode_set) {
>> +		if (!devlink_default_esw_mode_match_all)
>> +			devl_warn(devlink,
>> +				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
> 
> Not a very strong opinion on my side, but I *think* it would be more
> consistent to emit this warning even for devlink_default_esw_mode_match_all
> 

I kept it only for the explicit handle case intentionally.

With "*" most devlink instances are not expected
to support eswitch mode. In the current tree I see 9 drivers 
that do, and many more devlink users without it.

So warning for every unsupported instance in the "*" case would be noisy
and would look like errors for devices this knob was never meant for.

Mark

> /P
> 


