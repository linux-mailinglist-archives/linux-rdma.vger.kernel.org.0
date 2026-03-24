Return-Path: <linux-rdma+bounces-18562-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKrPNSdRwmnNbgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18562-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 09:53:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A780305170
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E7F0303A1CE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9A3D810B;
	Tue, 24 Mar 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8/cFil3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F683D3CFC;
	Tue, 24 Mar 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342215; cv=fail; b=Odk/62+PkkTJ4MwbCjHUie51xik2ooluKPyo8QjbdwJrbtmOimAAUffmm3GXZXTA/ykBvZsymA3WIcc6FAdJvEtO9FhLcSDcDdi/n0tFjJxVpib6eQ2AC+rh/mp+SumjcxDQjEIbPT4hE6uLfkqSyDd95WiQqIZe1B03cBzXGZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342215; c=relaxed/simple;
	bh=MlmgshT8/AUCXWtx5MEapcET7vRtox4/VZRl1gZWeAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjfZ0Xe8A0ALKrcxC9QsU53rikgGSd0Hc9syuw7XqzjA5ecxuHwestGuq2W+t6WQQSRi874ACNPcbCBKAtM9dqWtH7rvw+0XAlbtR6opOgjU4ZObvqe6D+v66CI1KVaBoMzxSD8LEQ5Lklsv0vD8IjkbEer4h6bslQcWM346ezM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8/cFil3; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7jMmUovZV9b5O1n2EyBWq8CVwe2MKl1O5GgPsiCJ8ZihMiT+SvnViBdiuJdSTaMWZf/wMBjfVGahVT0600KYv1idJkN51xLXq4NNYJLxFLGuhVFKNhnA2JiRRu9XuCjEWFl+NeZnEHt0r93H4wVgltohvxm3u4kbIBVDIccTBTDOXhqt5d+kWTmeAxVzf3gCI0cQfjufBFmw8s8C6Y8oSvQyO3IIUa+WK65WC8TytrOCBLHTIMPbie44l6m4il5VuGl2agH5zWzX3T2upaJjSv/FvQc1KqXYDqDL8yssL5cZApjfXGRNz5KFnfHUamQy3QY+1hgT4DwyLYkFVkV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwiiS41KIAWsAUCgXgAD/+krdymxSMVF6gRNeJliVRU=;
 b=hgNqCg0Ok6BgZ466bZ+JY6b0XzGO3vgCjgtCqfbbp2rEkPaRIoQzVEDcXQy8nDsrYcuhYPwOuU2IdQRo6HptDRU8jEV2b5bDfdyXjIPRZWWBadeQ2vvoZ0NzHx/33YUWTbT4xYHOseiR8Sm5wyyBDuBIojnW7/07mZL+CEK2qAK1S62dgAS/OgcI6Ad2qvEK7BR4x1bDAmLPCWWvWt5ozjGTlEo5wmULh0DEPpIwmjg8WmUYa8632FJASTG3pMYxLHPOKfNragt151ErGuo0GQNRjwsZ4Zq3H7CTsmo1faWxPKV2ylpYV5p2fCWuxcPQ2JPVu4m9M7cXWVIR+q3qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwiiS41KIAWsAUCgXgAD/+krdymxSMVF6gRNeJliVRU=;
 b=Z8/cFil3Qc/nerTpI//6emn13nFtyhldLFyJ7x+xvsRbnXsAOvjV2aW1NBq4F9jfPJBDhziGpGBMZZGkqgCWpPsmX+QjOZxIH7Dgc+OhvmQFFaBYNCpMjzzkeLnxeDnHbn09dH0xhJldPIdUQZATj5PDMdhLy7vfrI49Ip8rHCt+H2t3nU3DcKYL4wJSOCxXhJp1k4tkPwpDfPzILOE8WjZwfa1v3MelSmQwOxgoj9Gc2q9FbkbJoushzDEYWNV3/PyvK6pkgXCLPQ5e+zDAkZcTqx/QEYH6ELg5qHRJ17AW/xKzVUhVY9wW7Z97fNjhJPakkEknXrN+Yj5WJ+g68A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 08:50:11 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 08:50:10 +0000
Message-ID: <600504dc-b35d-4e5c-86ec-86590ae314ea@nvidia.com>
Date: Tue, 24 Mar 2026 09:50:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net/mlx5e: XDP, Use page fragments for
 linear data in multibuf-mode
To: Jakub Kicinski <kuba@kernel.org>, tariqt@nvidia.com
Cc: leon@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 moshe@nvidia.com, daniel@iogearbox.net, edumazet@google.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ast@kernel.org, mbloch@nvidia.com,
 john.fastabend@gmail.com, bpf@vger.kernel.org, cjubran@nvidia.com,
 linux-rdma@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 gal@nvidia.com, saeedm@nvidia.com
References: <20260319075036.24734-6-tariqt@nvidia.com>
 <20260324024235.929875-1-kuba@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260324024235.929875-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: b61a96d8-bca3-4894-3f08-08de89825b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yg1DqvCP4Y78NsOsZM02bd8G4z1VYXwBZqvfZm+EqdOaFpRS7XYH6ATeZBmHJc4kUIcfoqezUm7aLJQLdm9DBbzdy9oMKtVZzBUwKrGREpgpRLaPfezZW1V45jxiJm1YAxrSSPIBPEyOrxxE67rayzQl/U36zEal8ue35C78vjmpzM8H574wOj1O2UzTTG3BPcZOegEx1ja3DwL30PaJNR73WUTgsVNfTAE1osMggSXZ3tx9M2SOOVBaXSNP8ppiTlOb/CBaixXqdLSVILJDVoOfa9RahekluPZ1u2nJO8fOMj4TA9rSwVWrqZecYBtgKE9vurbAfd4gxiOKA1dXzFcRFuDUlArOoZ5qvux1amVd0wEHmCPhhDnZrwgeZ3I/t6vZCgYlR0eW7ClWHHAVM1dOIoFsB1gmWYIJ7NcM2nnak9Fh5ebPISav61M/aMHya4tWrJHLy9tzXKmMbzBYU6NpMAgf4E3QmXXiaU1IvQ6Ssiso4TCvhP1MT5VUJwRhl0mm+o8HzURBo52OL4YRUuaEgXvEJfxx67tqxfxGLO88P0SOmZypJVw48YoXiJ7a7bAkG2hw6yZhiYE0qoT4MmZNfHH2u+6YXQYz0Eeq3RbHlPbKTbzVGtUxT4stlF3mNPDSbuTwIk/QL6EJMF4Pot/MzHpXh4b1w8cEuHoaG4VXc7UR+X6h6Bz2vyitX02xisUbP0yrY4B075weXWxE3tLZLP4knzPuR4tp94fGYp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXBaTStYYVkwOFNBUWNrOTN6R05CWVFjbkpYNEtpQnFHc1UxTHdwc1p1bGNJ?=
 =?utf-8?B?eDZPUUtyK3JMa1UxWlk2V25EaGxqZGxGaVh6ZVVRdWRVM05DS3FaL1RRbEJi?=
 =?utf-8?B?QU0vcEZFT2FsV0QzUFRYUEhlOHJuenpnKzAvUzNBT1VER1pob0owOUJKUmRN?=
 =?utf-8?B?a09ESmxZQjJSMXAyVWx4L3VkY1RzazBoR1JpWU5pR2t3a2piRU4yZTRXbnNa?=
 =?utf-8?B?Y2diS2N5anVEcXRqeTh0cEJsUGcrYzJWalVxTFBDSDlBeTU1KzlPMHgwMTh6?=
 =?utf-8?B?Y29MdW1weitoUXhlU1ZhOFBRcjZrWVdkRGhkcWl0KzY3Z1U1RHp0Y3B1UjNQ?=
 =?utf-8?B?NCtzVzk1dlJFYmU3TURBRndCQlJxNmdoVGxhQWo0R0liUVVoL3lSSlZ3R0pE?=
 =?utf-8?B?OTBOT2M4bWErRk5IU0ROY1FIUUlhemFHWEU0eFM4dXRyOHAvbkRIVTlaaklF?=
 =?utf-8?B?MnJhaFZLNVV0WU55MjVuY0FwazltVnVaeTNZRklWaUtkekJWT3RLZ0hOTmtS?=
 =?utf-8?B?amErKzQ1UnBXS1VEL2I4ZGlzbXFybitRdWtPTHNXdTJWMURBMzVwcHFFVTZE?=
 =?utf-8?B?UEpKUkhzSDMrS3RWZDEycUNOL0pLeXkwUWk1cTExR2F0NDd5UVV2aFdGdXA3?=
 =?utf-8?B?WTBveFJEelBrbER5eXdlL1R1T3BWOG5sSERLdTg3YW5EUXlTay95ODdxcG5P?=
 =?utf-8?B?eWprNTdRUFZ2ejJ4b2dxcS9xdjVVMUd6ank2a1Y3akFDQlN2cnRvRE04K0VM?=
 =?utf-8?B?ZnR4WVhnMHpJaVFpeHo5aXdHQWF2ZmR5azBsM2VHVE0wQUhlbXBPWklvaVZm?=
 =?utf-8?B?NG1KckV5WnNnU3lVTWlwOXQwM0JYOFJUaThIK2Mxc08vYzZLVkcwUmo4bTY3?=
 =?utf-8?B?R3hWSFJYOXVFdm1TZzJQZmNuUXdVMGEyM29PUDRJbXFnTTV2cDFrTTJMRzR0?=
 =?utf-8?B?TmVvWUdGaVVNWERBRksvOER5VUJYemhUMkpIWG4wYjFzVlMyME1sa3g4VFpj?=
 =?utf-8?B?VURldkFkOS81OThNZ3RHb3hYd2RmNEZFNVU1RWVVL1Npcy9sWDlrN0Y5N0Fq?=
 =?utf-8?B?eUhJR0hpR3B2VTlldTY1cEVmcFR1S1pkOS9xRUdyVFEwTmhDS0JMd3F2bjlJ?=
 =?utf-8?B?UzJpMnhhcjVXMEl4aFlIaU90UTk4d1VCNVY4UzBab3BGNjZYQVJjOFRLWDRI?=
 =?utf-8?B?M2ViTWh5RkFrTkwzNnZqeWl3ZllGWnorUTBGNXcxdHFIbFdQTmpVc2NDWURq?=
 =?utf-8?B?a3BjWFpaK2RZVGl6alRUazZiYmNlaWhvTVlyUzJZbE05dUhpT2dWS21TWkVE?=
 =?utf-8?B?UDVlOWFTYzRhSTU3SWhGaUpoN3FTVWVwSVNFdDEwNDhaNi9oNG1xaTZ0SVMr?=
 =?utf-8?B?dTN5T3pkcjdqQkRZRmxxenNkM2Nqckw5M1dLbjVZVkRkcUp6by9wa1JNbUwz?=
 =?utf-8?B?eWVhdlZ3Z1RVdzA4Mi8zNGg4Wk1XNFIwT1ppNzJvTnJTZHBtK0R5RHRKdUJn?=
 =?utf-8?B?R1Q3ZHkya2ROSUVqbXRGQzJtdHZEQXdyMml6QjJNd1dFT25KK3hyTHFuWFZz?=
 =?utf-8?B?UXlUZjEwMjJqUXlCL2Z5YzhLR3dwQXJyNTRkVGk3Z2lrMjZocUZ4OUc5Y2JR?=
 =?utf-8?B?RVNNZXRaZHFjUjJZb0pDMUdXYnhnVzE4WmloR2VmSEJYdW95bWl2N1dvVVhx?=
 =?utf-8?B?NUlhSjJYeHgxUlhmc216U0RGSDZ3cWptd1NQbU5XekRMZHJ4WEdIZ3dIUFNo?=
 =?utf-8?B?dlRocFNQcCtqeGEwQ2hXYUc5Z3c3Nk9qSExxcld5RHk2cSs3WEQ1cGVwQlFG?=
 =?utf-8?B?UEU4V1FGdFVBeVRhLzkyNEx2Tk5wYk1QdXhZelRIU3EreGc2WHc2ME1WVEhh?=
 =?utf-8?B?ZEs1TjAzamVEeHpFb05hZmZYa3FBQlpHSVVSMWszcGg2Uys2QWlGYjZXMUlT?=
 =?utf-8?B?eE9mWTE3TjBTbnZXYXphQVZ1WjE5T1N4TC9MMFNNdmxOMkxCSDJzbVY4Z3ZT?=
 =?utf-8?B?aFpCMWRWRTRzOHQ5eW16d1EvMDR0NW96eXRNNzU1bS9CZXpWa1Z4TExzKzEr?=
 =?utf-8?B?VmphT1R2cDVXRXNqd3lhTXU1ZW12eGdBVlhza2dnc1p6OXVwYmlnTXBoTHlX?=
 =?utf-8?B?NFl2T0hkejlsS0V0VGkyemtLUWc4cU4xR1Jwd05qODN0MzlqamZKZjQ0OHR6?=
 =?utf-8?B?RGk1dS9RYnJvdWc0T0I3QjhwVmJRMWxjVks4c2xxblE5a3FXS1Y0THUwVk5L?=
 =?utf-8?B?M3ZoUmFUL2V6SWwyM3NjSFJ0Um9QSGhHdVFSbEpzWU0vMFhJUERTUHBpbEw0?=
 =?utf-8?B?Q0NoTHRacVp0RVNBYUpTRHJyMFhHYkpkc3l1VHo4cEdzcW92M3NDUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61a96d8-bca3-4894-3f08-08de89825b29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:50:10.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJieGDbhtJfntA2f2rv/N/PBJiTItgdXKlPA5ELJk/Fv3L+V5sCseKDlCkc0ozvn4krrF8DotAaneGUhC3SzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,iogearbox.net,google.com,lunn.ch,gmail.com,davemloft.net,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18562-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A780305170
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 24.03.26 03:42, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> [...]
> 
>> @@ -702,6 +731,16 @@ static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>  	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>>  }
>>
>> +void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq *rq)
>> +{
>> +	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
>> +
>> +	if (!li || !li->frag_page.netmem)
>> +		return;
>> +
>> +	mlx5e_page_release_fragmented(rq->page_pool, &li->frag_page);
>> +}
> 
> Does this function need to reset li->frag_page.netmem to 0 and
> li->frag_page.frags to li->max_frags after releasing the page?
> 
> When an RQ is flushed and then reactivated (for example, in error recovery
> via mlx5e_rx_reporter_err_rq_cqe_recover()), the following sequence occurs:
> 
> mlx5e_rx_reporter_err_rq_cqe_recover()
>   mlx5e_flush_rq()
>     mlx5e_free_rx_descs()
>       mlx5e_mpwqe_dealloc_linear_page()
>         mlx5e_page_release_fragmented()  [releases the page]
>         [but doesn't reset netmem or frags]
>   mlx5e_activate_rq()
>     [RQ becomes active again]
> 
> When the next XDP multi-buffer packet arrives, mlx5e_mpwqe_get_linear_page_frag()
> is called:
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear()
>   mlx5e_mpwqe_get_linear_page_frag()
>     mlx5e_mpwqe_linear_page_refill()
>       if (likely(li->frag_page.frags < li->max_frags))
>         return 0;  [skips allocation if frags < max_frags]
>     netmem_address(li->frag_page.netmem) + frag_offset  [UAF]
> 
> If li->frag_page.frags was not reset to li->max_frags in
> mlx5e_mpwqe_dealloc_linear_page(), the refill function will see frags <
> max_frags and skip the allocation, then compute the address using the stale
> netmem pointer that was already returned to the page pool.
> 
> Shouldn't this match the initialization in mlx5e_rq_alloc_mpwqe_linear_info()
> which sets li->frag_page.frags = li->max_frags?
Good catch. Will address in v2.

Thanks,
Dragos


