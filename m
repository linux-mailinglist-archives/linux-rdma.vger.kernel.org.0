Return-Path: <linux-rdma+bounces-21138-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEDXOUNzD2r4MQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21138-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 23:04:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300785ABFEC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36051301BCE4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71734678E;
	Thu, 21 May 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="REoMhZJ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3C2FC876;
	Thu, 21 May 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397358; cv=fail; b=nx0Au0nnznpGCXh+Nrw473GzkEadcSz95jpSis3Eu5SSt3nkLH2nc8E6QWgTUb0KBKBfEohc+nwZhJin+kMCl23UaRt89KXi2+g7fZwMA8BdpmBBM4yauZsKcjiuwk1hkBnYqsSYifns+xTnJfrbQTxSLb7RRbZFpCfKa6dYYPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397358; c=relaxed/simple;
	bh=6ywuiUxOa8QNKBRAYPEwzddLdHNK6PYUQyQH9pitEs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qJC1SyMH2us8NRzrk6BvOvxD0yFkDvPgKHPa4HYGGfgPGjrjONYtK0wUAtmZVJK7KPWE5cGcSi5uMYLAqa42cdvfVbGBeAqb+OScL3HQDHTpyHz3WaHvRRDJWpP7ZGXln+D8kk/7gb9QPvEOPoBrIGYIr5iDXdCdaSVfK+1SDvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=REoMhZJ7; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVAdh+WaRvTHwfLY8i2yfYH6rLVON+4pu0zbLU6DmNZgLEuygz/Da+lrY9gzqllXwldtvcUk/Bh84hQMHZwxuX3nOFXeQaY8e/aK3/X9++y1pvF1l+box3MYIzCxmp1Bh/8h+C556jqVGlEO5dXoxyhCVVWhnrdk63KLGACdmMorkXOAfiFvNH7z5DXBczUcSLAIxV2L5XIoTEloXJFK1H/TbnylphOOsTulh6Dxyx7+TGtcKxtzZ61phVs7ojeLVo3GpTMf+1T5dd9659jOYgifbT4+onKUZ/Ec/hNs/VZd/2Vjx4v4z6MZjrqvzh+JRom1fF74Gro2RQTbXpVuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0Id+PER91HSa/hR1Dpn90lufhE0+q5UpaiMRR4BKhU=;
 b=dNdBMNEfLXh4T6BCCXSSX89iF/51n/SbM9aGxPTcSWrlG9ynCbjpjNfBu4W9w74+cgebdsmqxpTp5kK1eDOENwrKP4xaomTwPwFFZQQShQehDXXSlzt1sUsZJPV2e8u5bFSOVE1b+FwBIVbEsxgEyNQeqxnNfG7UIiQkti4/WYxoEtLDChlVU/BmMhCpV8ej9z6zbqf/WDMJRXaKW4GYgx/CKSYeWZPd8Ma7pivDjA+BveZKO1+nXOVa/uEQf1hl+82MClQ4qgyQ/9J49Fd0ORak+GJKDhcbh8EVZL413tBC3IALri9J/cQaT+t3MDIoLXZIOQyBfCpH/IAnU99eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0Id+PER91HSa/hR1Dpn90lufhE0+q5UpaiMRR4BKhU=;
 b=REoMhZJ7EjrtoePNsD9T/EO4CDPQkXAXngR0xyK9J+K+PPzYyOQ1x91STQ3qrhsfkhX8/J8DlV8f4/LS0EkuX9Rz9sGqBPH8ZAjqpJLBuKI5bEEQ9LqHo0GWZLZZ4QTxwxjEjCPuYgoaYvoF/hc3IDrOGJ2Ve7CxqYJ58llTZP40pr1B+SvevdhHwZ1YiGfvzoPdISYAHC33vw2Zly/qIPUFbUo7CI5tI+WYLSv2CQazER0CkRAyMCIAKqAO3za6XWYoMhZKZ/pfr7hJ4xjLVPjiOZiN7q5b/bZGWxt6bUYWlHhK4bfGo1rdpUhmZKhIf+l1KoCJQHWP2qTkx6tHig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:02:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 21:02:30 +0000
Message-ID: <7c919edd-4364-495c-a50d-bbb047a4f9fb@nvidia.com>
Date: Fri, 22 May 2026 00:02:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Thomas Gleixner <tglx@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
 <3bbcf456-322c-46f9-b238-88fb8ad227b2@nvidia.com>
 <20260521152845-11899163-df79-435c-b8c9-d3003403c6c9@linutronix.de>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260521152845-11899163-df79-435c-b8c9-d3003403c6c9@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: f77704b0-b90a-4f26-e2d5-08deb77c4560
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799006|6133799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ImBWPORx46FrtOBykO67Zt1e82n1e9aTcx+AW3ALf23xFcCOuLlzK65C1dyK0cAGBSxOQ/ZU3SJ1/m5yaRat3AHl1+6tGMBnmsMV8q8UqMV80BCANglwYYfrALOo+CYlBDFoWsPJo1IbRHJxEWck76SnGH7PFtkrtN7l8ZNOSu9PR1DzbW72EFHHk+fBOnFun6EoagX4IEI2tnpj8g3hdE8c9hwFY1x7mxtpB7vaEWy8t1p8Goc+HDdXK/ksW5psY4iZ6c17aQo3thF8xAwttXJ9fGbJrMXfcVz4fpSA+YOnCmNm9DUTj2XRV1tHPWXQtvmhK5uwAbMD7x3KsyikpqKV38K2llVnST24xGr/jyDI5fs0XLcZnuejeQgUjw3uzSQHoH8hp9xfJfSk8Yy6jt5vwblF7h4v3opy4CGMiNIZvovwcIeSYvaGN3hRI4tgFpaJwwm3fBavPAd6vgsYBAdv5s2CCCKfkvihTNNLulSjaHhnXtauR0Ohk9G5OahdR4G3zUcSwY+LhcxvhCCrAURqfJLF/62gStX+55u/JNUy3gBhpbo4wuRhN8l0G+57AoOIbH5Yt/fIMIPFCdNewjcN7IImK9RJqRQk15+NoYxL22OYbSM4pKQe1tqWS/Y9WzUl+Hv7LXpShWh4162NSwZcW14DgPmjGzmD/gOng8wuXunQ3wHzoRqFjqYe84xBQMt4pnQ5g/m00BF3rMIUhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799006)(6133799003)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tVOFVKR1lxSlE4UUFiYlh2QUM3ZzdpM1hXemFSV3JnV3VydkVDdE1UdWVy?=
 =?utf-8?B?MWIvbjIzNEhFUUtRZ2p0NWtzdW9LYm5EZ2JuOFdUcERRQndJMUFWZldkV25O?=
 =?utf-8?B?Q25jWHlJdHlIc0dvYnd1c1p5Q3lMQjVZUi9STU5Ndjg3dTNWTzJwemkzcFBq?=
 =?utf-8?B?b2xhMHNjcTFmZ1U3UGxZNE43V3VldWxtTCtQY2NTRTJLdWF4RERiUm1XQith?=
 =?utf-8?B?SzlQODhWQkRPdFg5WTFwOGdJQ3lnSFl4b3pHc3FnblgyUXFDVllRU1ZwcGZE?=
 =?utf-8?B?QXpMZ2lZdk92bkJkanlRTVY2Q2xWVFFhNndsUitReG85enRISUEyRnlqeEFR?=
 =?utf-8?B?d0N6UnFtdzlZNm03MDd0KzNSVTFmY2RHQVNCdU5hMXZEYXpGRzFPc0hzclYv?=
 =?utf-8?B?emkycC81ejNmWGRyQmEzVzdTd1QvazFMUVUxSk5vTTlyczFtOThWdytxLzBz?=
 =?utf-8?B?UnZaUVFLb2I4T1BGMCtRWGJIaDdsZnZ5UUJDWE5pSUk2SUZQZTEyVnQyY3Fx?=
 =?utf-8?B?UU5mOWdBUGpkMEV4RWRsY0JXM2F4VUtZSExXU3h4WE8rd2kzd2xLOW5GWFM2?=
 =?utf-8?B?T2dhbXpUZ04yUVJvTGRGeE4va0FxdkFTaWZzQi9PQzNaSTN0RFlPU0lRUnc3?=
 =?utf-8?B?cGhuWjZDNUdINTdSakRnbDlSZy8zb21ETUJyTUx1ckl5WlJaMGFBRXB6SGd6?=
 =?utf-8?B?WFl0VERSQnZRc0FOQmsydWU3UTVDZEdkUWFVdVJmVEZ0TVFUWk14RWV6YmJt?=
 =?utf-8?B?STk0Zy9IVEt0NkZoMm4ybkF6ZWV4SHJtL1lxL2pKZ2dqVktGUGNOTjBJNUlS?=
 =?utf-8?B?bWhId2lXWlpHUzA2RnBONGltcXdCZHFJcXpKcmdYS0RDajd5aHVyaXB2bEFh?=
 =?utf-8?B?TFJTaHhvaTl2dzhyV0ROKzZXN0p1Z2ExWEw1MnFVZnR5VE5kUFBjdWdpWkYy?=
 =?utf-8?B?c0I3a1VjZElFQ3hUd1JaQmEwZjI0bmtQQitPazNaVkNLWm1GVzhpdzBXbkxr?=
 =?utf-8?B?ZzEzWkw1d2d3dWpjTFUzUU8zS3k0bDNFYjFLQTFVWk5RYTdXam15MEZZa0pO?=
 =?utf-8?B?TDJ6S3B5S2pjVzU4MEI2eC9PTzZsR21QZjdiaC9JckJ6VXdLdXl4ZnVQT1VH?=
 =?utf-8?B?SXgvbXdpWjdzakJ4eFdtNkFPM3pPTnVSZmhVSE0wVGZuSjJ1TjNzT0h0YVFk?=
 =?utf-8?B?T1AxZ0wxWkNSM1czYjZFMkkybW4vTFBIbGFMeDVHOVA0YnhTSFFZUDhPNEY2?=
 =?utf-8?B?TVZkdmViMFYxeEp0TFVmdUI2T0hwd2ZCS2hZQUxscmlxWjFkN0h1Y0Rlamlt?=
 =?utf-8?B?N3NyejR5Sk1HV2tlVDlDazVWbEZqeHhvdDJWMWtrMldJZ3MvQ2hlNDZ5N1Ey?=
 =?utf-8?B?elZjMzFOTmZ2RGNGRGZpbkRhM3JYSzhxenlXMWM0SW41ZWJobE9qYTJzMHZr?=
 =?utf-8?B?d0xjblhYODZGd2hPdEs5U1c1YXVNcWIvZ3pYZzljekxadzNjRXFFdUhKcnNC?=
 =?utf-8?B?bGlXSGZ0WjhQU0VmaFN5ZmhGeXNUWTgxMEZFUkZrcTZzOFZXUXhlRGRLa0Fo?=
 =?utf-8?B?NnlhMkpDVFhpRHdaZVJzR0YwdlNHQzJEN0YvbGEwT1ZHVGdic3cxWGRGbGd1?=
 =?utf-8?B?UERGWlhPN05iaEpYeGlIR3hyeDV1ZWViTlRGWmtZL0dqbGJzREQ3b2R3bHYv?=
 =?utf-8?B?eGtaMStDbEVlcG96SWRBSUpKTEFidEJpS0hqYk1YRmxyL2dMZU5FV2pGR2N3?=
 =?utf-8?B?OW9YNDdGRDNSR0R0N2IrYW85OW1pcHFPZ212R3BuN1lLR25HWUx6QXBJVWdV?=
 =?utf-8?B?L0h1dG9zdWpNcG42dzVYdXByRHJQS1lsZjJha0dhWmVuSUpHRUVYZEcweHJp?=
 =?utf-8?B?VEttOUpwNjNwNVYySDhjbEhOUTVEdGxyMytXdVpKS2pTREI1ZHJFU3plcGxa?=
 =?utf-8?B?cFpoWXU2N0xPNmljd3JQejU5WnE3QXIzZUc5aTlpcWV6QTVXQVBRdTFweVlu?=
 =?utf-8?B?c21mTGN0TjlGa2c5U1ZuNmpsTlkvcEdDKzdKNlBRZWpmbDJHVkEyK2I2K3Rw?=
 =?utf-8?B?MVJiUlk3SEJpbTN5cWxEUHVScG9mc2ZqK1FsMERPclJiRjczWTJKeGI5UFUz?=
 =?utf-8?B?aHlkb01lbXlsSSttbU9weEpqVjF4ZGR4K2NXNnpXV0RHWWc1Z1lVV1RHazVh?=
 =?utf-8?B?VDBLREQzUUNkQTNQWDE2eTZKeXU3RlpiK0U1ckRrNHM5UzRUR2JVM3Y0anlO?=
 =?utf-8?B?eS9UNmpGQUdqZFZSM1h3SHp0K3ZnajQvLzlya2E5OHZVVHV4WEpTbi9VaENa?=
 =?utf-8?B?d3dpTjcyb2Q0YVh4eHg4Z08rcHl3bW93ek9kV2Y1TWlza0l0U1k2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77704b0-b90a-4f26-e2d5-08deb77c4560
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:02:30.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyJlaUDGeBYF6f0r8EkFmUQCV4BaIfRHYsGfRkQe/I5ICxcJSBHZwFDd0nNT3qjpr0MsopbaTzFIeK79HhmETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[40];
	TAGGED_FROM(0.00)[bounces-21138-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:url,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 300785ABFEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21/05/2026 16:41, Thomas Wei=C3=9Fschuh wrote:
> On Thu, May 21, 2026 at 04:16:28PM +0300, Mark Bloch wrote:
> (...)
>=20
>> NIPA flagged this patch with a build_allmodconfig_warn failure:
>> https://netdev-ctrl.bots.linux.dev/logs/build/1098506/14585935/build_all=
modconfig_warn/
>>
>> I do not see how this mlx5 patch is related to the reported issue,
>> but I looked into it anyway.
>>
>> After the kernel has been built once, the issue can be reproduced by rer=
unning sparse
>> only on version.o, which filters out the unrelated noise. I had an older=
 sparse installed,
>> so I used a local copy:
>>
>> rm -f arch/x86/boot/version.o
>> make V=3D1 C=3D1 CHECK=3D/labhome/mbloch/bin/sparse arch/x86/boot/versio=
n.o
>>
>> This gives the same error reported by NIPA:
>>
>> ...
>> ...
>> make -f ./scripts/Makefile.vmlinux
>> make -f ./scripts/Makefile.build obj=3Darch/x86/boot arch/x86/boot/bzIma=
ge
>> make -f ./scripts/Makefile.build obj=3Darch/x86/boot/compressed arch/x86=
/boot/compressed/vmlinux
>> # CC      arch/x86/boot/version.o
>>   gcc -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -I./arch/x86/include=
 -I./arch/x86/include/generated -I./include -I./include -I./arch/x86/includ=
e/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/gen=
erated/uapi -include ./include/linux/compiler-version.h -include ./include/=
linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -std=
=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE=
_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 -fno-strict-=
aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -fcf-protection=3D=
none -ffreestanding -fno-stack-protector -Wno-address-of-packed-member -mpr=
eferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-unwind-tables -Wimpli=
cit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/boot/version"' -DKBUI=
LD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"' -D__KBUILD_MODNAME=
=3Dversion -c -o arch/x86/boot/version.o arch/x86/boot/version.c
>> # CHECK   arch/x86/boot/version.c
>>   /labhome/mbloch/bin/sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__u=
nix__ -Wbitwise -Wno-return-void -Wno-unknown-attribute  -D__x86_64__ --arc=
h=3Dx86 -mlittle-endian -m64 -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc =
-I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include=
 -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/=
uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h=
 -include ./include/linux/kconfig.h -include ./include/linux/compiler_types=
.h -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_P=
ROFILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregp=
arm=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-ss=
e -fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address-o=
f-packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-u=
nwind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/b=
oot/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"=
' -D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c
>> arch/x86/boot/version.c: note: in included file (through arch/x86/includ=
e/uapi/asm/bitsperlong.h, include/uapi/asm-generic/int-ll64.h, include/asm-=
generic/int-ll64.h, include/uapi/asm-generic/types.h, ...):
>> ./include/asm-generic/bitsperlong.h:23:2: error: Inconsistent word size.=
 Check asm/bitsperlong.h
>> ./include/asm-generic/bitsperlong.h:27:33: error: static assertion faile=
d: "Inconsistent word size. Check asm/bitsperlong.h"
>> # cmd_gen_symversions_c arch/x86/boot/version.o
>>   if nm arch/x86/boot/version.o 2>/dev/null | grep -q ' __export_symbol_=
'; then gcc -E -D__GENKSYMS__ -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc=
 -I./arch/x86/include -I./arch/x86/include/generated -I./include -I./includ=
e -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include=
/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.=
h -include ./include/linux/kconfig.h -include ./include/linux/compiler_type=
s.h -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_=
PROFILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mreg=
parm=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-s=
se -fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address-=
of-packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-=
unwind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/=
boot/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version=
"' -D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c | ./scripts/genksym=
s/genksyms    >> arch/x86/boot/.version.o.cmd; fi
>> # LD      arch/x86/boot/setup.elf
>>   ld -m elf_x86_64 -z noexecstack  -m elf_i386 -z noexecstack -T arch/x8=
6/boot/setup.ld arch/x86/boot/a20.o arch/x86/boot/bioscall.o arch/x86/boot/=
cmdline.o arch/x86/boot/copy.o arch/x86/boot/cpu.o arch/x86/boot/cpuflags.o=
 arch/x86/boot/cpucheck.o arch/x86/boot/early_serial_console.o arch/x86/boo=
t/edd.o arch/x86/boot/header.o arch/x86/boot/main.o arch/x86/boot/memory.o =
arch/x86/boot/pm.o arch/x86/boot/pmjump.o arch/x86/boot/printf.o arch/x86/b=
oot/regs.o arch/x86/boot/string.o arch/x86/boot/tty.o arch/x86/boot/video.o=
 arch/x86/boot/video-mode.o arch/x86/boot/version.o arch/x86/boot/video-vga=
.o arch/x86/boot/video-vesa.o arch/x86/boot/video-bios.o -o arch/x86/boot/s=
etup.elf
>> # OBJCOPY arch/x86/boot/setup.bin
>>   objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
>> # BUILD   arch/x86/boot/bzImage
>>   (dd if=3Darch/x86/boot/setup.bin bs=3D4k conv=3Dsync status=3Dnone; ca=
t arch/x86/boot/vmlinux.bin) >arch/x86/boot/bzImage
>> mkdir -p ./arch/x86_64/boot
>> ln -fsn ../../x86/boot/bzImage ./arch/x86_64/boot/bzImage
>>
>> To me this looks like sparse is getting a conflicting set of flags.
>> The command line contains both "-D__x86_64__ -m64" and "-m16 -march=3Di3=
86 -D_SETUP".
>>
>> I confirmed that the following patch "fixes" the issue, but I do not kno=
w whether
>> this is the right fix. This area is outside my comfort zone, so it would=
 be
>> helpful if someone more familiar with the x86 build/sparse flow could ta=
ke a
>> look:
>>
>> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> index 3f9fb3698d66..80923864f6f9 100644
>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>> @@ -71,6 +71,10 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>>
>>  SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))
>>
>> +realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
>> +REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) =
$(realmode-checkflags-y)
>> +$(SETUP_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
>> +
>>  sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._s=
tub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_te=
xt\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>>
>>  quiet_cmd_zoffset =3D ZOFFSET $@
>> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefi=
le
>> index a0fb39abc5c8..341b0ff20c3d 100644
>> --- a/arch/x86/realmode/rm/Makefile
>> +++ b/arch/x86/realmode/rm/Makefile
>> @@ -29,6 +29,10 @@ targets      +=3D $(realmode-y)
>>
>>  REALMODE_OBJS =3D $(addprefix $(obj)/,$(realmode-y))
>>
>> +realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
>> +REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) =
$(realmode-checkflags-y)
>> +$(REALMODE_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
>> +
>=20
> The idea looks good, we do something similar for the 32-bit vDSO:
>=20
> arch/x86/entry/vdso/vdso32/Makefile
>=20
> CHECKFLAGS :=3D $(subst -m64,-m32,$(CHECKFLAGS))
> CHECKFLAGS :=3D $(subst -D__x86_64__,-D__i386__,$(CHECKFLAGS))
>=20
> It seems the same kind of substitution would work here.
> We can add a helper function to arch/x86/Makefile and
> use that also for the compat vDSO.
>=20
> I am wondering why this didn't show up before.
> Are you going to send a patch or should I?
>=20

Yes, please take it if you don't mind.

Mark

>=20
> Thomas


