Return-Path: <linux-rdma+bounces-16876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNzVFM9Hj2kiPAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:48:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9495137AF6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60FAF304D17F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB056312808;
	Fri, 13 Feb 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlnflGkO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273A246762
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997701; cv=fail; b=jwTFwaFEwLeaGHQgqNEA5U6UsejaWUECjx7VW+XjRQKx9siB3W/iST5AifU8LNKTlKwIt64YEEqHgAgYVWwu0OQWqrACJTCPfAh7V8DDNu2LRwql6OkVF2L3P/P1XnA0Ubn7LIwg8nsBVNv0nYcZ/UtuPk8+9hh6y5EUX6MTTy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997701; c=relaxed/simple;
	bh=Kl98vIKsgJGdZ+oyRjdkAVTMcRgIDTI0i1VhmvQZmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=glnHImkQm/vmpEaPS0/1khlfivcwyAGqQIxsPC8Kj6PrMtHFk4kuPzRaqPPz+wVR3uTrRWWxKgDY3xxDrcM8xaI+yjykZ8V5hznlSZo7jGoyaVKMZMJYdmZKDZl68bTgq2hZRD3VhMCtutYmyrQsvj0RfV4IoWT0Y89w6afyWic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlnflGkO; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TczmpZpy7F/GzvfPrsFibjQab0YXjd4c1LJkTeiA86Qgl4aQkNtTSyM42yfAo52fc4gNqKkZ23IBjPNLavzppLJ1tCto+bntezfiG0mPjTEVp2Zb2YOJ8EEKqx+aAxkwwL3/2ZN8wUvol7nOPr1z4B3feTOqFqHFfMGkLQgElSI4DW6tocbzNeg/NP3T9ChSapQ6izuHX9YdAGv86KqdE6Q+cYgRdvmctB7OwZ1xg87FqTgy7e6ijrjn1+pVEZsQppm3BSCC7IqMOKNq8T7tQel8PWCFfiXNUN2muuSsvKY1QLMYedt6Pd5R0NeWSTvCxrrDEVu9qIeKvrMSZ+N2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEDoZQJ1JcHLxqo2BzeW9RYML1gOTJKn6tx7bxFODAg=;
 b=HFeCiW4AqyQhRhIDvnRjKHWR0qk1Ukz2F8tozsDAiSS3a4ZB3lHttceeb6NoudwJ1udSAuhlWHUwqdqO3zLlf7S3uv1d3F2suDpuVJCYmPgmSwJHdcsr3rL6Xaams6rUO/DvMQrOLL6z/tHwtm2kZ2GYWjfybGvglcKjf3Z5Tssq5gRzEwgoDRtVw5i2jq4xeqHo05lRoyk/vznMkTLJqxoA11Y+lNWP34WsBd/YMq54ykoRlBsqfgVwIaCNl0v+DKhAKHjusr9mQ6aBZ9g3hIkwIQ73QMV3XJGRQEUrI+dKGyUAN2dV2BLExLuvZBWHUDd5f+BPCQjN8aOKS2Fb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEDoZQJ1JcHLxqo2BzeW9RYML1gOTJKn6tx7bxFODAg=;
 b=XlnflGkOMkrWqNA2Bn+SWS4BrtZFAtFttKhys4JGAxvxTLyN2TOjsOWNXTATi7Qf6k56lIv8UB+VwAJsf/G8VqWgM/ZzRp70j2SSiM65OmwlhjpIoHsFfXu6YUCorEpSloi2YpwOssAtFEMg2ykL0dBDDJy2UJCBeTzzBruNW8IEmOcO3yxB74RDrIVtw2FcOazEb52AD2h8EvFT2UnWSidpZudT4smgZMgXN/EZVjd5E3T4WEXGx4RW0zkw0BBTWvzXh4ULmAXVdulWzPeyufaleGwGggrbS9h/zOoOppdfphIIPLVA3lgN6uM0h39C1lBgJE07tlagSHT6pS7cLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 15:48:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 15:48:14 +0000
Date: Fri, 13 Feb 2026 11:48:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 03/10] RDMA: Add ib_respond_udata()
Message-ID: <20260213154813.GG1218606@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213101053.GJ12887@unreal>
 <20260213124359.GD1218606@nvidia.com>
 <20260213153739.GR12887@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213153739.GR12887@unreal>
X-ClientProxiedBy: BL0PR0102CA0038.prod.exchangelabs.com
 (2603:10b6:208:25::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5819f8c5-5585-4773-7f12-08de6b174c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YtN6Uxmut930SIACajSRln9a4VkZkfQZ19g2jh9YHlEqmkF8y3opHPJ2ONps?=
 =?us-ascii?Q?ejFbUNK8mIKI37idff3ldOWrZFoUTUd0xmwu1MaLhkT1z9sDAuOPxEQ5f1Es?=
 =?us-ascii?Q?HP6+7EfeiIoaObwj314TScvgK9/nROlgAshF9b42fTz2CnodH6ssH+Rs9XvQ?=
 =?us-ascii?Q?pEmOY8jStqu6s4NRHToi7fuMBJZvnKA7xTrq6xv+71U8OMzoUdjYuA7zcowR?=
 =?us-ascii?Q?woDw/xXLX8kEJZcj50NfnNwLzTb+gji13mpaxQOh1NCEYxcYgVIyVAVWsW6i?=
 =?us-ascii?Q?xtCG3VahRhXbz03UW7dZVNmBQ9H7v9sCMb3ggBbQU8tiw0d3KIQTxZXrNepF?=
 =?us-ascii?Q?nZqmOcGqcAoMEra34S7/vEusI9doX7IwycaPYlA+MwXfB+MK+aNqzlj3j/0S?=
 =?us-ascii?Q?rwepLuHwTi3sKyHE21RLt17tDL3B4FBcmH4ZfFA6rREFOlbuoXQciako8Kzr?=
 =?us-ascii?Q?jQwz9dE8RkoHhGHtXGoSXxiXl07DtWY+akBFL/vanNWpTe0XhiKpxHTNm0r1?=
 =?us-ascii?Q?8xtrgOLwUU5WEcBmToozLPBd0MOcQImKco1Ulsxx+oAsttDA5M4TkIC0kOUx?=
 =?us-ascii?Q?5AFrv8AMBE+XwB8AngLZzf3NyqsVNFEUragGFNbPtwh2y5VGeRwjkdElT01g?=
 =?us-ascii?Q?H0yl/wuMW7CoW520d6c9qdLU2nnXQoOgYwE5rlAEqpjFyb8Pxh1gALc9Yxdm?=
 =?us-ascii?Q?XmeEfGwGohLjDJ7B0hwJhNkJPuN3R/KZbhoIsKq/Q0E6TrjyjYyYX6dY5dwO?=
 =?us-ascii?Q?iqqAse++qwkV1Zfg+cCMQZ77Q0jv/NswKxGochZmgHd7tJsJXVSIcMsf4rz0?=
 =?us-ascii?Q?NTt9h/Pz632UPETbZiPwuprs4YskC3DcqenxifvkTuir6rLEaHetl466HeJg?=
 =?us-ascii?Q?l2KP02f8LFRv3w/n8Yq22bsTzMqUDKDM/yOZjxh6cyG/e8r80prHlR12m+9W?=
 =?us-ascii?Q?NMgUxCXSnldPEu7GY/d9+w/jF5VUYZHXQWtMjknyc1ZfOnto9uZkni0kTV5o?=
 =?us-ascii?Q?vw2UZ/ENT1Fu0FGkewhuqgBU0uVqXMHcqE8pVwJ2WcXu9mMzDEoLcZnsPmSJ?=
 =?us-ascii?Q?WmjUWCrM6RcBr50wiM4Xg1D0O0/wgSsYaSXv04RLvUHKXjLtnuzyRmD0yQmZ?=
 =?us-ascii?Q?NycE1b3zPbOs7BjHRvuqY6/j7I8my+T9n/cYWIYacfUL/6DYSMVlGBt5R5Se?=
 =?us-ascii?Q?/a7Vs+fN7BAj+ikc5s3qwPxKXk8Y8+iepVyHcsAcSHYS52p9HhkoWMG3zL8y?=
 =?us-ascii?Q?C/PjH8HC8O95V6otkkA3bg7I+P3tbViKfnRNEXYP1WEE8Y53Q3YxUk0m2ZYj?=
 =?us-ascii?Q?ikOtmRztJEPIGQOqj+u/xJgT47ToMm7H7FYasZbGb0aiZ2b3hp7/1ViC/pwG?=
 =?us-ascii?Q?U7Xfj5pusKBnE+PLprnb1Av4mlFii9bevaA5mZQet2YMHJ6QCgYG0GqtEJMG?=
 =?us-ascii?Q?s6N2W3OAEc296VQikUMDZRH+b+SrtstGBqVB8bFl4gU9RB1Ba3BNTuSMSNKX?=
 =?us-ascii?Q?KKpwdEUzMqeM5SgqyrOOVPde9xOpf/nYJuPEYhQfDlJ+e2gnxcHkataN5d+V?=
 =?us-ascii?Q?0dvU7ahQMblWff5qmJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPlX5hZ5X5Clqibawti/K2k9fWF7CvCAqv+AU/L+FItVm7HEWhldqUItqQGw?=
 =?us-ascii?Q?lGire8NfM3IIw2cqYt57/0/uqTIIZ3blvknU0PoiaQqwuaFaQWnMQouB2g6N?=
 =?us-ascii?Q?NkFCx+Wo5WQh2WmyoF/nzG0sToBY8eyEIwI4cBLgg2f+GWVqGJ3MSRv1R9c0?=
 =?us-ascii?Q?K+ottoqdAw/bKep1Nap6CWYtzodtweqCFAVl7ZEAqzu9d/vbRm8rNaxoCsyR?=
 =?us-ascii?Q?uiShQYVqICJv49R9JfQLAa9T/UskpY7JBhDrRxIP9hRzw9m1LWVOXU4Jqoms?=
 =?us-ascii?Q?RZX8RzGNTPM9PQUjVcsrv+SzktcvPPuZ1SShjf3WsP+Q8tRnjKOj9q1wLyOy?=
 =?us-ascii?Q?E3fHqSHd7FxqAdIVFZAfcw3nEy1k9HC0/zk+eSGriOZK2iZJ3M5gQuOn26bv?=
 =?us-ascii?Q?uOV6kcJCu67aTLmjnzmOePQqQJ7crR4/4QEBeQJukuXAHO31fPUpvblgtXhf?=
 =?us-ascii?Q?LI/QvVgH1UpL4IoNboRaDQEb1CZm292KlvodC155Pn3RfWF/1tEXbcWe3tsY?=
 =?us-ascii?Q?DlrZu2FKQDNzJV5KBV6fw0L3mstWb9+3xgVfw1x3i+G+qkQJ2aroCZdjpkjV?=
 =?us-ascii?Q?dRWKSFxFgFuOr2nVJa7lsZIAW4LIicGDDoBeigMpZa+G2UlilPUXWPPmwNcn?=
 =?us-ascii?Q?ualbtTEPF+sQj2zPc8u301uTKLYoq2uhh9HLaUQ81NneR1up2TVk17auSi2B?=
 =?us-ascii?Q?JbJR4XWahXFMRyXKs5wPhgro2SH9f9lgCUG0SGvK5O8BwYshKdRyenvUDF17?=
 =?us-ascii?Q?8r4Z6nftcXVojrYHlbF/YOwL0U+jehudX7HSjcGD0+rlZGMMq5JG6kXE9B5Q?=
 =?us-ascii?Q?QPAalhUug3Q4KtuwayMzp/W7mRyBGL8yFw317+t+5py4aVGT+8vQIighb3cs?=
 =?us-ascii?Q?EY6mm6KnzCoowevmtp/xhZ3XGVJCFsxOTOah6bxtrLWnBMPLzOrsOTwRvhPL?=
 =?us-ascii?Q?LUtzYTp6fAAssgxQoWTDcNbLLrt0Vru8fipkTskb1Uf3NHieaSdqxSEgTrSM?=
 =?us-ascii?Q?7HRxlbv8cnZPQ9eWiZHRASNtyI3C2FfEfl/d39GNezX70ToynEBYv2tNufFI?=
 =?us-ascii?Q?mFjCu6pluYlnQurctQSB2mNwsxQmqLGXO4Wq4d65WfbVLAO7Ch+mO3W03u8X?=
 =?us-ascii?Q?1VjRHh/etNDc1W3pbHMZFq2pV8uDopKQGg7LqkGdx8PZn8bSS7fVLQ49oCPi?=
 =?us-ascii?Q?cdwPhjiHQRs1bwcpl8irBdw7/UAl9hEQ7MPBUa7b5K1Eye+43NOR62451SVF?=
 =?us-ascii?Q?8R8Yq9wu6K1ji0Ab3ZyeKJfsL9Qv5l2NF1yEbO01dC04omemk0hrGlYcp6Qz?=
 =?us-ascii?Q?o0y7KGyNngU/yjyigqM1napDhbRar6J8Ea7lqMf8BjT1KX/cYzTfHX5jp5zQ?=
 =?us-ascii?Q?/Ydg+AA/LIHcvzuNk2V6gcXK0rb7iUN1n//Jacn437H9sKaOXGkJYW46pY5Y?=
 =?us-ascii?Q?dm0aXEFe0joitVwCQLHzZNNKOjyM6BGcJWFEVSf66JzdXZtkuZNiRduxnQXp?=
 =?us-ascii?Q?z3w+WjR6sMyo++KC6HVwC2s291qhcbzU/46dH/cE2raEdXsc9iHZiVYE0DvN?=
 =?us-ascii?Q?y+c7wGkwnsW0NqKMgLYhweKmHeoo6lnRgMxUobCdGyeX+DceKTcGlkbW9QaU?=
 =?us-ascii?Q?QCz2Nq1TeqsF6uCuc06KoSIwWARl36R1ZVakEutu3HxUvft+N8DRHjRX4gNx?=
 =?us-ascii?Q?T9yNtNCm2AXKMrlp1ihvEIMpf25afh6j04HRwkgTqoDKPmhxZVXtRBpwnEGl?=
 =?us-ascii?Q?vbyUSG5axw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5819f8c5-5585-4773-7f12-08de6b174c57
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:48:14.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzSpLTcM9EY2+XGRAr8h+oxqHu9G4Spl5ii3QgM59incckxi4gBgwnuOMlpTS1y2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16876-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: E9495137AF6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:37:39PM +0200, Leon Romanovsky wrote:
> On Fri, Feb 13, 2026 at 08:43:59AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 13, 2026 at 12:10:53PM +0200, Leon Romanovsky wrote:
> > > > @@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
> > > >  		ret;                                                          \
> > > >  	})
> > > >  
> > > > +static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
> > > > +				   size_t len)
> > > > +{
> > > > +	size_t copy_len;
> > > > +
> > > > +	copy_len = min(len, udata->outlen);
> > > 
> > > Don't you need to check that udata->outlen is larger than zero?
> > 
> > As far as I can tell 0 works fine with copy_to_user()
> 
> My main concern that it is not clear what return value will be in that
> case.
> 
> +       copy_len = min(len, udata->outlen);
> +       if (copy_to_user(udata->outbuf, src, copy_len))
> +               return -EFAULT; <--- this?
> +       if (copy_len < udata->outlen) {
> ...
> +       }
> +       return 0; <- or this?

Oh, yeah, that's a really good point.

Jason

