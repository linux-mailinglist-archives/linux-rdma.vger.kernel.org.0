Return-Path: <linux-rdma+bounces-21916-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8VBN5pQJWqEGwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21916-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:06:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E16504D4
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HWDru2AP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21916-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21916-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1CF730143FC
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC938A73C;
	Sun,  7 Jun 2026 11:04:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152430D405;
	Sun,  7 Jun 2026 11:04:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830297; cv=fail; b=EazF4spXqmCwGyRvnH2LptOETDHK7B7utPKg+ekeHBqvpJlSHCskSMl5uV0Pv8F+2zakwE3B2GFSUnTZAYiOKxmuD8V+5F2BWB2bFY3qFDsuP5UYukbN/H+EYnvJY2aEmsVU/MAIrXC2DV8gik9RYi5nKoWCLxH1fr5iBJgH+oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830297; c=relaxed/simple;
	bh=SsDKY15dUYncnu+dGhb2H+i/VMx/vCgK6m8PeG/c/mA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qpmBbYQNWajq0K1KDyHsNRsp1PNwvyVLFUTSB2KrkvBGTuLglkXCYsxIgNE5jUf0n+m7/V3hLTUML5sSJ9rc9zLv0pxIXgjBGKIokXEH5FzCkiR7Rho4yYrkgSBp6SJ9r0S4YzKVEQv9Ps5VNhuNt9YlWQTWwIXutYJ/uyBxpzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWDru2AP; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlAgkgVFOQSt4tnSnVF75DJ5qYB+LCDOYcjlTmX3J+qxzVtPtCw4buccNgUEiBnQ3liNhJ4HG0L/21TC/dQ18SlXX1x0edmcGwiGWIpL6wgGXKTgofg/CUGOThOxhIfgRssO6S0V5Op+QeMyBibMZ/CuRtOf+MA5hDGPvrNr81fWng7chihc6hdJgY6RvsHADLW5idEWnPtqBjD0m66HdrsRvwEvKiAiYnarGoBneglYwKlsorG02gEToy8lBnzmrQukwnCgQ9YOJKDO6GhN5EY2tq0qd2CLMLXNQMe9szYFcKveoe9Xt+yklkZ3Uno2KkbUtH8updTEoY4N4G1X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCS2LrzIDuL9/Ixka5U7LkOkj9adJthwA+aWwrdvrr8=;
 b=NNfpBuocB7E//INv+mnRlL/Ns8OGP39VTZOjB9oFN3kdO3Xq0BhCQBKI57JFgMcsLVB2NTvAmqLV/ImBeRI2Nh7PNWDVv9MRgNJAwo7FHBG8/+4ORWpR4VaVyUC9VHHlh0E8JtrC2QBecuUkiHvAiPbV8KTeQXmcLTaNchSdjy3ueoo9/zD3QyxeOlQO+3u2IkSTDO/VCtS9PD3fX6uYBnY/VfJTh3L68y01m1Qsk0DoyUHVIVZ1iiSMcgu+6N7GFOpq6G89tp84QPjHwD02azvAOC5I+VcpcqRs2uxagyZKpozlREaNogtj+95oQH93clOQAqYS2JTbwYk9bToOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCS2LrzIDuL9/Ixka5U7LkOkj9adJthwA+aWwrdvrr8=;
 b=HWDru2APGZq3Mp5VWIvSp9fIdwA7tUtKeFq11TisVqvMl9i/JXs+vGIonKVMjUC6ohuzQnOXnJq2fZ2EEZZXDOXTDOO9AzRJwbGHfodFIzfaSijZdiUka2z7ECeEuy9V4HHmdiF0Ph4xa6KWmza2dCjvpgkTLcqp1J+FmEt59MKxtg1tnBkiTg8BVBUIaPrOer4zY37Mpm+wdJeEZu8hj6+Kw7DbybOwoEmYXd409BohfWDF14tox0xmwoDGploCYoARCBwivzZHmLcwjIQRZrMyi+GEGv2zw6/V/mxI5U5jsg7hF7v90FHgMzWoI9ruEga4aPicEnT2yDYF9b29bA==
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 11:04:51 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0092.007; Sun, 7 Jun 2026
 11:04:51 +0000
Message-ID: <65f91545-572c-44ff-9b9c-e2a1efcb1f6c@nvidia.com>
Date: Sun, 7 Jun 2026 14:04:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/mlx5: Simplify cpumask operations in
 comp_irq_request_sf()
To: Fushuai Wang <fushuai.wang@linux.dev>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: shayd@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangfushuai@baidu.com
References: <20260605101756.91275-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260605101756.91275-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ca4126-4609-4688-d2ac-08dec4849889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nMhKGhrPeYE/iyUMRuKxknUcxJPwmLV5l0IssfJR/xTYlslSwkrP4T40m+DMKcLyp556Z2lgcccsldctkXScuw8gwp33dfltrLJy7pAeq2TtXcaR1/0lmQHS61mqWi5xMa3XMkFx2g8PibmXt2vGZedSop3DMpeKoPs/i1PjWfCrSejilrwtQf80a2IBElLOWpIzXqtMx5egDkhNINeMW3YERSdrKk5/fD42icb3ZC1yIkSxsD/xblZ+rODt/I8ks09xcFzBrtL+RWyrhi+mt2dK7PuQKhfl7uFfYeDhWh9sA5q+Rf1f0Fr5OFrrasi9ZCzyzVVFNashYxhmY7hwlsRV2n3XmC5bVkuTtegwyLxt5XU5vxJi0Rog98OzN/jfFH0Hjgf6FLBIQVpipSAQjYdsFa7vWbO1cK+1amSdqcq2FsvEbhVYN6ZjN+L3PT7iXWYHr9IK6p9YoviTnVrWGNjIpVbAzmGfCuyWcHufsbqd+uX1l0U1Rs0UuYuzsxov3EIl0eOy/XOVMGwfQAwsNqeZ9uOsTsFc3INSbmlvmr4z8pwhW+tYp2wiApesivJxG5xX4Kfb9ioM97eEMWk3H+9dUPE6YT9Bi0n1BvzMKuKu695Z0nVuM6CvsQXouZphAX3IHjOmGpbjCD102wnZjpRDbJkoer5ENQMh/1En+R2Bx4rUmyOl6mubGl6WiHi1FbNsrmm2j85GIZnEjZn1gZtfjpFPR+FwXXyg3hMTGkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFrcnh3Z0xYOXF0WkNGMTlBSHlZSnlFR2tTL3EyRDZHN01ldjgwWjY0ZDcy?=
 =?utf-8?B?YndlRHBVeWF1bWNGTmFnUW9lbWZYcjloSzlQNUJXS28xNFE3WVVneWE0c05s?=
 =?utf-8?B?KzQzakRoNDA5TDFWZHdFUmE0cTllRUdLSy9jMzZCbXp2cG9PbUpNbDlMSHkx?=
 =?utf-8?B?YVRYQnRvNThTKzJEdWZ1VVNEV2x1aTRtY1E4NjNwZHdUcFpaSmxwQUVEeU1K?=
 =?utf-8?B?YWdkakpNRXBYUlRwa2RpSi8yenlLSkZzSUI3Q1dDQnBNRkhNL3lDeHhuK3hr?=
 =?utf-8?B?b0g2M1NZQ3FQditHZDN4aFd1Y3RsNkxoRkdRQUVRWFpUMm8vVVlENHE1ejV6?=
 =?utf-8?B?NWNuV3A0eU5iWDJtdmRMMWgyN0MvSTdBZVdCSnFIaVFxb3kzbDlXaHJ6WVFT?=
 =?utf-8?B?SFNmWW1Na1pVZVZzaGNWQWMvYTZwM21FZzF1d0xIcENXQWxwb2hwR29pQ1JM?=
 =?utf-8?B?SnpvNWQxQTZpMWFJVnpwM1V3aXJDWGtCTFYzWjJzeGU1SmZLSU5Kd1Y2VDBX?=
 =?utf-8?B?dU92dFVpSTFWRVNZVHBBRzc2dDNqMU9wdCsxK0Q2TWlrUXo3MHhaK0pqam5W?=
 =?utf-8?B?ZXErQVAwSUVuK3E4c3JoNUc2MXlNak04YkpvV1ZyTDF5SUU5Y09qRGFNOVd5?=
 =?utf-8?B?VDZXOWVCQlc0RjJGSWVNMUhMMTJ1cXhNNnVtc2lWZ0FSb0VjbG4zcm1aRzJS?=
 =?utf-8?B?bFZCYU9odHhLYzNnZ2VobXNkdjMzNkpzanpydEtpeUovTVdxSWFHQXZPUHVy?=
 =?utf-8?B?Q3JMWU9meEVNMzJlbzVUYWZOdk13V2h3Ny9jZUNvYUlETTNWUHpMbDZZRFBY?=
 =?utf-8?B?eXZmYWI4eWdlRTV1dDZ2UzIxWmZqaEFscnpHckdaSEFoUndSYWpuNUdzalA5?=
 =?utf-8?B?UXQ2dkUvckc5V1Iya3hmdWlieDZxQi8zSHNCTVNzQVdqOE0zcEpSeUx6dk1j?=
 =?utf-8?B?SGpYSldQcmRNWGZjRjgzRm9EZGJZMzFPVVQxOUxHMVhaUDBvVWZqNGltVTZk?=
 =?utf-8?B?SU9ORXVJZ2RiY0tiNmlBUnJJU3RreDcybkR1MlRjNlorVERZTGVpdGpTQ095?=
 =?utf-8?B?Z1J1QUVSN2kvSVp5OTFhSWdZRTZYZFh4VElQUXVqc3pvcW5sL3hTUHAyMHZ4?=
 =?utf-8?B?cXBWc1NWNWpvcUtZQWJyMk54UThCMkNHSElhVXloQjl4SVBERENQUGw4VmV0?=
 =?utf-8?B?OGV5cEFmSXllTWJ4NkM0c2NhclJJM1l5bjlVUDZQVXYxWWVYcUpzVkhZT1Jw?=
 =?utf-8?B?YXAwMHdyZnJGYWlzek43dkdWWXJENTVPUGsrT0lpMFlzYkhEb3ppWVc5Sjhq?=
 =?utf-8?B?SWpFQ0NkN05VUzU5OVMvY2IzdG85TWQ1RXRwWExMSi9WVkg1MFJkR2p1clNQ?=
 =?utf-8?B?MmpIbXR5Q203amV0cXQxZ3Z2MWtXVFZveHhiZzBLMjgyMldXc0tDRER2OHNw?=
 =?utf-8?B?VDM0TUpxeDk3andaR0hrTEd6M3BieElVbERwSW9XejNSa3EzSzRveHZCTFBq?=
 =?utf-8?B?ZXNKbGhabjNSeGpkWDd5ZHl4NkVYcFpHelh4b2RoRWZWTG44MHVOaVZFbWVB?=
 =?utf-8?B?ZG9CeFZjcVlJUlFtS0Q4YXZsNVQ3VG9LeTZnWFhrMW8rY1huUTJiMjJpTnhr?=
 =?utf-8?B?RXRvSERTcEZDRm9wVGZ5NHlqaFlLVk5QajdXZnFQd2N1VUtKa2kvRk1yL0hp?=
 =?utf-8?B?b0tEczhFTksvbGZJTFVRdkgrclNxa0RhNU82TW9TVVl0TExkRUdQUWZkUno2?=
 =?utf-8?B?Tjk4ZFdMT3l5QTF4SlhDWDgyeWtvZGsrbnNiUmx0N3phaEVLSGFFcThacUpq?=
 =?utf-8?B?ZFJPdU9OM0lxNUdpOXp0UTI2cTJDcFBYNHRIeHBJZThhY0dzWHlwWTZwWWU3?=
 =?utf-8?B?djQyaUsrWFhDVnRhS1FXK01mWCsvME1YdlNIVUZ2RGwyQnRXN0o3dnBaUXpW?=
 =?utf-8?B?bHJjQmZSMXZjZ2hhc2ZOZmtmU2tTZzJEYm42STJ2UFN2S2JLcThNMDlMSWFq?=
 =?utf-8?B?TWE3R3A5OEQ5RitMUlFWTnY0SWdoNUl4V2JaeDdyNlUzU0dnYVp2SG5FM09i?=
 =?utf-8?B?SXhmaGlRallCMXpRcXVJSHBKN0lzamJrUXRWTlEvNStrdDhoWlB0UTFFWHQx?=
 =?utf-8?B?R0FnQ0ZXZWw1eXVuUG0vZVI5RVMyZTY4bHhPMGR5OGovcldzaURVcitSTThq?=
 =?utf-8?B?NlBmNXQ1elo2bjFjQzN1Z1RuMGFRR0NaS1pIMDlBTHIrN2xtZ3ZKYlE0TnhH?=
 =?utf-8?B?Q0ZhTGM4a0huWW9kUTN0MUFTWGNTeUVLSG5DOFBLdGV4V1dTTXI5S2NkaC9H?=
 =?utf-8?B?QnZQKzFUb00xUUk3dnRBbjN6QU0vb2l6cXhDTDVUTHRXKzVTZ3J5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ca4126-4609-4688-d2ac-08dec4849889
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:04:50.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqZnYrmYzjHm3CeMC42cZ+Y8L0biWzU49QKs+UZOpRz/0a8EATCUzet2tVUeI+9URu8dlHRZtmzqMLqILTyu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21916-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shayd@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596E16504D4



On 05/06/2026 13:17, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Combine cpumask_copy() and cpumask_andnot() into a single
> cpumask_andnot() since the function can take cpu_online_mask
> directly as the source.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> ---
> v2->v3: Separate the patchset to two patches, no changes on this patch
> v1->v2: No changes on this patch
> 
> previous discussion:
> https://lore.kernel.org/all/20260603072657.10868-1-fushuai.wang@linux.dev/T/#u
> https://lore.kernel.org/all/20260604125705.21241-1-fushuai.wang@linux.dev/T/#u
> 
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 22a637111aa2..d11ec263d53c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -886,8 +886,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>   		return -ENOMEM;
>   
>   	af_desc->is_managed = false;
> -	cpumask_copy(&af_desc->mask, cpu_online_mask);
> -	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +	cpumask_andnot(&af_desc->mask, cpu_online_mask, &table->used_cpus);
>   	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>   	if (IS_ERR(irq)) {
>   		kvfree(af_desc);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

