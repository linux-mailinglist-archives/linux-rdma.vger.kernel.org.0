Return-Path: <linux-rdma+bounces-20674-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPNkHOeUBWpLYwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20674-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:24:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D21D53FBDB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A4D5301585A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B639EF23;
	Thu, 14 May 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j3AStO6o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2C39D6E7;
	Thu, 14 May 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750692; cv=fail; b=NDyUqIA7ok1/ntv7DO/H1/vFcAYWKpDYsDn9/Tjgn13yB8aVg1JrUE5NwXxUXBeeJB8tEgFwLsGXpGuvER8fKyOiju1n+gNI10TcivYCsXVfnTrIFRpg7FLme90eA51uimyroNVD/jzcngxbJyCi0HyPEH9LZb18DLmdj1rsHXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750692; c=relaxed/simple;
	bh=mmH4ueowQlRks+aHcHjFpUUiYbi5QxRaiiyqrasNQAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FeXOrz36gm5rVpj4zfIRSxecqugr+IQw4uGLBEv4RIctHB979BhE3zYj4TqiQrBLvhHY7qKGhWo6OuzmApWFWZWg9w4rHq/oPWCcJTJDEDeBkscKS9mnNjSN2zh9uzOr/1syEJifxJmbwWLQQG6yHgTrOmQrkf6t0twY2ee3+KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j3AStO6o; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGcHRZmWLylh+qKEiSzDY+I6pJDx+xXc+ber76YGUZjl9n1QvuQVi+JykpCjjSLOfx8Sg0IyQjSbnNf/s8kjxey/3A2OfmvR0A2N8ZbdqUrrAbS65xY5rnrpz+J+Fot+8jazt62FEKP81jO6w6aDOVh4QVzLbwa99KNW5HEBHYTect9XOyNmopgB8CK2t44DHr66GwVujOpBREvTGn49C3SyVnHINNHhvQcHyDUF+Maxk5FLvWpZJoSCO+jGaqvwtQ29qW6oLQBMfYLt1yE0cSTB3b0fW0em/RaFIT7GnQ/HSaNTM+KmoaDKlcPrX/igKJj2fi8lmBZ3eHW3Y3HoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDvkHTPnDFqCk9Rs/nbQI8/TkRPBlh6b198wAzNqDr8=;
 b=EQmsBV+R4n+6mOyH4JnGl5Mqpl25+pqIftox4RVqXdEWPYHktDxGdGDzy+cyRA3ejUc4JIot3zQBE1+psoDk+1WD4hFmMQyxWzX5g2SBwbVVZAHggnqBP6xLRTjUxN/AM62wnn0brbzfuiUcjfdntxjdqKBfGHVFz3J5T8eveMZOwsN1ShsK3DlcQf/Jui5hCRUEHeHPUYj+Cmem0yImCm5oCS8QXflvIINugH/ZM5m3en+HGQrZtiqp90q3/asZ5NAZSw7T+xNYTGPehaFtqiCeijhRwr82yHpdN1Tpj+iXVTFqnz6yKjyzkyVV78dV+QcgwHFdKlnorxeGzF7bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDvkHTPnDFqCk9Rs/nbQI8/TkRPBlh6b198wAzNqDr8=;
 b=j3AStO6oGCEtwWgW2lGKlHWkmBZ8YYzAgd9AehArDTvhMsROkGQjSJX+3m0QDl+dglfGFIrDDSSigSFnmG4Z13Fp4dLhSVoslSaHCE/yVmp18UfSsfPYPvnEFnx/vUPwASh8OGHKumJvPJ8FtZAfGMjQu99AOu7la60BNoQKDUUwDqIJRHw7aru46OWJuPaxbWxIgySc2fb3GkUEDCK/2Tlp3GzMImvT3vqF7Je/PiJ1xDajRAUs/mDNBTp7e/isgBHoRkPqq2GTXis4TS3Y8jROyKsKg04r3EdocoLAt2ZnTfoW9BSpCiYag07/Wcsgezqid/0XHVq/wC66JHqG3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:24:46 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:24:45 +0000
Message-ID: <f4f5e3b2-64c4-4ad2-8678-d29ae08150e6@nvidia.com>
Date: Thu, 14 May 2026 11:24:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
To: Byungchul Park <byungchul@sk.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>, linux-mm@kvack.org, akpm@linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
References: <20260224051347.19621-1-byungchul@sk.com>
 <982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com>
 <4af19eda-c29c-4302-92d5-c0915267fc0c@kernel.org>
 <agRB2QTbzceRgpzX@pedro-suse>
 <1817a749-8232-43ab-a0f5-350e5aade235@kernel.org>
 <f3e38c07-d410-4c8e-a572-68d52dc55353@nvidia.com>
 <20260514085402.GA63255@system.software.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260514085402.GA63255@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d1f41b-6be9-4f23-700b-08deb19aa335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|11063799003|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	lg6eGdfTsHbNcY5qpna7vnfCRRoBy5W9TmafUDmfyPlge0OMimi751pytTayOjhshZr1CFxIuu2W5uhi3G8yAzkUq8B8fxiNXCKfWPoAwOEqU7yfR3yo06db0t171rZv9eFr4INjnGxkIeJdKdmSxUSBi7qj3cWkcDWstzxr+FoynyQfg45jehYjGhl4BJ452IsKSAXNoZF9yexepzWlgIJjLp4FikyjOgf+uvGf/qLCSLDLpGoaOLWGuGticOixcNqIpnd4XThPqukRwVm4Rr+Q8vmZBRfu+Zw/iHHQBqtHOWuvD/un3/pSYeBHpPXnVu0pO3KBBLpbMtOqLb4dLSMQrsnQ60/EGblw77R1hOQ1Lqk/z/KLNO57dP1G+3TZAN9+h4zjSsgvnVGkBjx3aXaoUBCXdjtQeNuyTctsyNdjJngttFednTjeb25fZPyopw9l2nVWf9PlFujwglB+8jAmKXRlT04pBcRlKL7hqHsXvUQ8XGLnLslQmcL/TirTIDxscxTHxXqNYdkhJCGgGG2u157zAStXL/KU93simrqcUkiC568ltPI1Sqeac8GzE7gll0Z7hy1azjbqvQTj8JszlwrTQ0D2rJ/24e8XK6DzeoE3MKknZBqGsYO00MCWA6AryGqEPwLsolQv8zWQT/Y/LZRMHBJWZA+cjcNokNSp2lo0FJuQb0IxqcM5MiG6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(11063799003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2NwL0Ria2xvamVqWFFkTGlRbVljNnBqSEgvSC9YUkxUK21lU2FnUzlhNjQy?=
 =?utf-8?B?VFlXSU8wTHF5WWVjemo3djdTMlNiZ1BGVncxTXVsczZhMnhiN2JJenVpTzZj?=
 =?utf-8?B?Ym1SZVFZNEVoN1d1ZG1PRVR2bjBITmVKVnM3VE5VWGxHVXdPY3FYY2l0VFhV?=
 =?utf-8?B?eFdxaGFPMG56VGdWS2NFLzBHQlhBa3NRNzE0VlVoY1F3eVBkSFNwVnV4ZDhT?=
 =?utf-8?B?T2NBOE1jaXR2RmpRL0RZbjFrTHhLbEdiZXIxeFJkbzdlRXZBYlJjSXMzNGJX?=
 =?utf-8?B?OVlnVENjejVVVUlCQ1IvZTFmaFNQVDF1SlNaQmJFRkZYWDdodHk0akNWR2d4?=
 =?utf-8?B?NXo1bDd2bEI4RHVNOTlyU3FnSVNaMngwR0x3MXJJN0syMlVrcHR4dnIrSEZh?=
 =?utf-8?B?Sy9vNkF3RTJQV0hzRDA3cmI2eFAxWVRBTVRycVRVWVd5VDdlTm0yNk5ZNE05?=
 =?utf-8?B?Z3dKWDBMT3c2a082Q3d3emJwU1BkQ0dJbmdhOGthNXlLaUJMTHZ2dnhnZmR0?=
 =?utf-8?B?T1lLaExjS1pKMXByN0kvZjg2blVPUDdGdVh6dnNMOC9ndnQwaFhDQ0FBcHJT?=
 =?utf-8?B?NkF1dnF5MmxMUmszeFJJcWw0WVlQc2JpNFlUN2oxbmtQVFBuYTNhNmJYUUhI?=
 =?utf-8?B?THBUZUdUeUFQU04zRjRwY3BjeDl5T240bzlqNk1WbGlyM21GeFJzZjBDUkVm?=
 =?utf-8?B?UWZtZXpYazFRc3NseWlHUjBkbkN6WjBtL21Va20reExIVHdVOXRzbUZqWFQ3?=
 =?utf-8?B?dU9NK2NuaHM5aUxPNUdXOXg0RTlTTjZZaFB4WmlRRVM0YzJUYWF2d1E1OHhJ?=
 =?utf-8?B?M2FqNG1WNEhVaWI2WmlHaVZwWncxSlpJZWdNeERxQ0p6UlJOc1VDbWlYNVE1?=
 =?utf-8?B?YVNnVFMzSmdsaDV5cURRM3BiNDVTVzFrYkl0Z2g4aTF0VHFRSktSTGxWN05k?=
 =?utf-8?B?RFpUcDAvcmhQRHU1Sk1nOGYyU25lbEJlOEE4QUU2anduUW1aVkh0bjNsb2JL?=
 =?utf-8?B?aHpjdW1TTGw1YlZSRlJoOGhwVTMxM1dncU5LWmVMM1Q1Skl3aW9QZ1Q1SDdJ?=
 =?utf-8?B?K3NEb2FOeUJ4TC9DOHl5QkZGUHR3eDIrR3dtelc3MHlURkdUc0d6WkpLRGJr?=
 =?utf-8?B?c053SjRjdTdmZUJFS0dqbUVFZGRtRG1aakF2UkpyQnI0VmVkWVVWd1BjZElO?=
 =?utf-8?B?OGROdlIyTHFSTlZscUNGSmdyWU1Yb0YxOWRia2hhN2xTcWdDeTZOeEhzUzQ5?=
 =?utf-8?B?THo5RkxSdTdVcHp4RUsyaEgvdVZQb1p3SStvTlAwZFF6c1ZtNzFvcEI4VlJP?=
 =?utf-8?B?UTBDcE9FRnFuN0t1c0Mzc2lBaGxFZm81WmlWTlJTb1ZNcEVlWEcvcS9XK3dD?=
 =?utf-8?B?aTdvSkl4QzFOU2Z6TFFyVHFzRnhaYUY0S1JuTENTMVJzTmZ5ZkozWWw2TU54?=
 =?utf-8?B?amZzUDdOQUx6N2MxUVJldHRTcjZFZHpOdUdsdjRmeDljUHhBQUUwbnc5OUpl?=
 =?utf-8?B?OVBKK0pscXluQXZCNnQ2MG9jSlNPS0I0Y2lYSDVkL1VVR3lnSnMybEprN2lO?=
 =?utf-8?B?OGZqalJmenpVZ2lnL1ZTSjFCeDZkdlcxbTY5YWx0ZzhPK3IybWk3YzdqUk91?=
 =?utf-8?B?OExTR25oaEZXQ2tYN1ZQRDRsUXVzRHFRdm5Mdi9aOFJPdm50cUkveW11L3Na?=
 =?utf-8?B?eFhqc0lQMXh5Nzdwd0NJSGF1S3BPc3M5YTdpc2hkeTY2ODVWUDkxWVBZd1p3?=
 =?utf-8?B?NWc0S2ZoQ1Nxak5NTmdHc09JR2hCMEVwVXdrZjhxS3ZjcFczWHhMYzRzcmVV?=
 =?utf-8?B?ZXJ6NDRzd2NyUUs1T1RsUWhQMTR0UUVGRkwzcVM1cVRDQXpyUThSenh1dlgy?=
 =?utf-8?B?NndlV1ZSMEdhSm9EbjNLcWtYRFFVc2NFUHFQNWsxN0Q0eDlOSE0xV0xHY3E2?=
 =?utf-8?B?ZlE0Y0x3VGhoVU1TcVUyQVZCR1g1bS93SFBQYlpxUmh6K3N6bkU4RFFEMGNI?=
 =?utf-8?B?VE9mMm10d2ZyTm41M3R0RkJNQmlpQ1pjbFpZQUFYcS93QThHUjZLSHJpZmRH?=
 =?utf-8?B?TnNxSzY3WENrU1o1bk4yQjV3YjAySXdNTDNxNXJOdlNMSUlIeDZoRmpPcUFP?=
 =?utf-8?B?aktjTE04ZTNTU3F3VjdzYkJVMjFwT3A1cFVBWCtTdHBLQW05dXJvQ1h2UXpO?=
 =?utf-8?B?d0VIc1JuUGJBNS9MaTRwR0ozOUovRXJKOHRZTi9GOXlOUlZlR0JuRGVYanBl?=
 =?utf-8?B?eFd6dmNnUGl6VndoQU44bG9MTG5xR2NtemVCMzg0RmdnYWtjRUhxMkRoaG94?=
 =?utf-8?B?WWxjM2l3Qm92VFlLSGZweDh5UFpheXhlclplVER3cXRqRkpEMzFOUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d1f41b-6be9-4f23-700b-08deb19aa335
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:24:45.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaNShV1FrSrUJS+tmyYrywS1H/8H5rfTc6GUSyTWwNbhi7TYCMFo+R/SS74E28sh0nt1xHgPE4rVkFqmZihtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
X-Rspamd-Queue-Id: 2D21D53FBDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20674-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action



On 14.05.26 10:54, Byungchul Park wrote:
> On Wed, May 13, 2026 at 02:06:06PM +0200, Dragos Tatulea wrote:
>> On 13.05.26 11:36, David Hildenbrand (Arm) wrote:
>>> On 5/13/26 11:26, Pedro Falcato wrote:
>>>> On Wed, May 13, 2026 at 11:12:43AM +0200, Vlastimil Babka (SUSE) wrote:
>>>>> On 5/13/26 11:00, Dragos Tatulea wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Seems like this patch broke tcp_mmap because
>>>>>> validate_page_before_insert() returns -EINVAL due
>>>>>> to a page having a type. Here's the full flow:
>>>>>>
>>>>>> getsockopt(TCP_ZEROCOPY_RECEIVE) returns -EINVAL because of the
>>>>>> below flow in the kernel:
>>>>>>
>>>>>> tcp_zerocopy_receive()
>>>>>> -> tcp_zerocopy_vm_insert_batch()
>>>>>>   -> vm_insert_pages()
>>>>>>     -> insert_pages()
>>>>>>       -> insert_page_in_batch_locked()
>>>>>>         -> validate_page_before_insert() returns -EINVAL
>>>>>>            because page_has_type(page) is now true.
>>>>>>
>>>>>> The patch below fixes the issue. But is this a valid fix?
>>>>>
>>>>> Hmm the check traces back to commit 0ee930e6cafa0 "mm/memory.c: prevent
>>>>> mapping typed pages to userspace"
>>>>>
>>>>>> Pages which use page_type must never be mapped to userspace as it would
>>>>>> destroy their page type.  Add an explicit check for this instead of
>>>>>> assuming that kernel drivers always get this right.
>>>>>
>>>>> So uh, this doesn't look good I think.
>>>>
>>>> Yep, you fundamentally can't map a page with a type as page type aliases with
>>>> mapcount. Even with the given diff, just mapping it will increment the mapcount
>>>> and wreak havoc. I think we need to revert this patch for now.
>>>>
>>>> I'm not sure what the long term plan for this would be. If page types are moved
>>>> to memdesc types, then the two stop colliding and that could work. I don't know
>>>> if that's Willy's plan, however.
>>>>
>>>> (then there's the other question: are page pool pages really folios? not really.
>>>> they are mappable, but they aren't part of the page cache, or anon, nor are
>>>> they in the LRU or have rmap capabilities. perhaps we need a different memdesc
>>>> for those. we're one step away from reinventing class polymorphism from first
>>>> principles ;)
>>>
>>> Zi Yan is working on this: non-folio pages would no longer mess with
>>> rmap/mapcounts, and page table walking code will identify them to be non-folio
>>> things to skip them.
>>>
>>> It will take a while, though ...
>>>
>> So do I get it right that the path forward here is to revert this commit [1]
>> and wait until the work from Zi Yan is ready?
> 
> I think it's the best way for now.
> 
Ack. Can you do it please? This is a more complicated revert and the risk that I
mess it up is higher.

Thanks,
Dragos



