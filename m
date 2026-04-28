Return-Path: <linux-rdma+bounces-19654-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD8pLerI8GmfYgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19654-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:49:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1F487538
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E60D301FF9B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6768413256;
	Tue, 28 Apr 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHtyZOJ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9D340A6B;
	Tue, 28 Apr 2026 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387417; cv=fail; b=E3YQTeHic2mT7PJcuJ05XKUvcMotaDVnTK6aA5h6s+O3yua2CvWfavhg1Bbps85uDXJAfw7tadbKYF0O1/cMVkpSDW3Twfqoi7xjvOuCpz/08TZB8W7X20CEh4v9yYXhUTpMB7ee1byHtkLMHLCj29zNYiX+BuCmdJraObVbrtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387417; c=relaxed/simple;
	bh=vws6q9BG5M40jCVBouDJedmhUjFSFvHqYPv2nynzSqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S31icJiDUJ7ApYGY6wykmF/FcCQM6Tx3Q0kzSOjPDyutf3MZGzXwYXB9A90hffJdTCLPuMIb95BKNnKMcHMaeEvVQiM+B3WWRrfamafnZdwVxkTBnsayOeVc59xKXNv5ckG16iYTIyzvybFtgfO3ir2SYROzJXwm39LoC4KQQbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHtyZOJ4; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvuz1sVyAac93GPsUzhLYAc9+xynUtZtSOphRTv69bZ89l3n7haSNKLYjy+IbAoawR9I7oC5tyUIr1RCS7aLHQS2JxaNbviWU4uHM4Z7gJcWFYArHmWbJWXyIc62jHQ/sIAppakANHtdyLuJc/4jJE2WzXHniNMqSeo/iLEuTstdGQbvtgasetsCy5gCEKHW6qqDwTlD1d5Ig6ff96ExbjmQaxnWYQL+xaEGUo32ej2LvmAX5A0QWCwq6fvMKxOrZUVlQdBpLyA912dwp+V1TuPwpT+Y+dFRZxgaIWOonumDh0e6rQNYNjpdrgvYB3tx2dp4o/+tzXoIqhZXL0c5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtuceuKiV1eyvlF3f0wt92j4yEFP16UPAQda8zzGE6w=;
 b=y+jwj9PPHtZ9uRy+r2p4ZOoqdZdF95eblKvmWR1wDgWcBCrqbf+JJv8u0+YqdeT+eDpzfKC2H32QYCTV8t3Wi3axNIuS1caTpC8LxpKhfF8pboSW3PYSbxiWrDqdjnaMThnOMOamgeCqD8za9qf/IQPHzjCUigrDAFM/l8+YybdzeE6U0CAX8eThmiOj9WOifzTsDPu/AQ0TzmYBMtqOgmGCG2P4Yv4NYIo2zJcauKNPbPDILybjPKPcytVAfGDZ7JIp8hxjnIZjnESmm4NzjjmiZj8JeD/Nhz+TCHTwo0a9uNw6ORsKtgrW5r4E/EAyTp/1ZKRJSRz3D5k0Sui79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtuceuKiV1eyvlF3f0wt92j4yEFP16UPAQda8zzGE6w=;
 b=fHtyZOJ4Y35AYlnsCLw/BCpz1zD5FDkQwUaIEAkkYqtVFCqdlpduaZ7OtP6ocXXYvBduBMtymA1wwToT+bb9pyjC4p0dN6hCBiTjLF9eeaxg121/jXJ7udxEA3fQaucWFGuTMPH5M8uTXsMUxQ8F9i8Nt1f0AYCKffLOWujNUUHgNr6wB6FoI5DgOmYWquWRHTSjzxQFhwNL7nAGfClYj7IWuez+8qjdmTr/CMc4f1rPd7LxJcNP8P70BOPGBTXOjb6QXPyQiP3rroLFi0poU6cAI9cTAfGgxi/oPRRimeQeVLXO73yhmd0N3SWjMkLWghbOMIB6Gv0C2pZU/yP/kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 14:43:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:43:20 +0000
Date: Tue, 28 Apr 2026 11:43:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
Message-ID: <20260428144318.GA2659205@nvidia.com>
References: <20260418162141.3610201-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418162141.3610201-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: YT4P288CA0082.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a48911-35aa-4c06-f982-08dea5347db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mjqXS4qT+F0m6UX+HbqlP33ttY3nMIRe/ftFloRkrHdBe/gzglqIrU9sIgKBN6nmqZAVGNF1j6O4xUWJfoej8957WZla12jqhjk8cfdlGYhowIQFCTQ7U9HVWJvBV16fE5arzhWZdxIfu3WV+M9NZCaCxr8KMtfLIyZ05y2oPjaSEqtBHkURpKfxXj7P2nZ55lASTiVhHHWR0tt4eqIkz+cns+z9PH+qwN74iyFEMnoIj7CGFjLyxWRwrvTuzp8FaX6pyGV2ljvNI/rjQKKIFIaH/Waz68TsbGO2y61dtT+m4fja1oLH74Cn930sZtAeW4kt5FT+kjn5PFQzKX1egq2DKGu0MfqLulC0nvVnZVJ/w+uXlVJGlKT61agCXSFJsxdnde8TEILhpfw+eeGQQM+vDV2+yuAbotfQDcUwYJftyKLXtng/tyycWwT0x5ZSi/ovlDr4V7N2chNUeKmM0xPb9bhltdJZAineX4ROV8a6Kfbp373rlnDT7L3izz6HSbLlZ6vaCvl2UKhDHfdCulpxsMUJ5h8oM36NjqYAHr6+n/yElWrqGGYRgRDycqtkVoUGR79jY7jYaELEswp2xUL2bsr32LNisF4XmOLmc1AS8n0xlxpm3AXU2jbPye60+5AcJOQR32GytgHwfqW7H/L/4dG1iNrKkqOyMm6zc4r40g/XbFA6hbVMWBKrVomE0/QoQXxj9IGi5qkunogmwZiU6UBKHGVJt/ZMLn7CzWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6W7CIhB5Eyr+Mpppv6rQPt6q+9jD0K7JW1snVP9/8X2TbIydt5cd0BGGF+Q?=
 =?us-ascii?Q?H/mW8vkRu4tnHWmin2mOqTV6GNFHyqaJEm+S7ivw4ISRjALwTvLr/01xKfru?=
 =?us-ascii?Q?qRHWf+int+91v1R1KNpr+bBZvIHdx3/TDyrSIEV2d4/XwUeanBJtqIuq0Fld?=
 =?us-ascii?Q?cV4MpZU4kCo8v6XDZjV2ywf6z0WO394XHdfah2Lhm9vUvClnEp5wG6SYsCNg?=
 =?us-ascii?Q?mL1IwXYml272vlR0EcoR05dgXMduvTCyEUgGsbgaXkNOWOAAA2vRh8Ov8aHx?=
 =?us-ascii?Q?3lwHF/0a4P6dwYZ1LZiHIdoUApbegm+9r70zNk609MQjleRTxhAVO0ds4uhG?=
 =?us-ascii?Q?dVLAdOcdLGE8PC2HNYUnbIeNjFPg6AmISs2PYdWflooy6mpVuMQfPDPj7pPJ?=
 =?us-ascii?Q?klBUY9+BU6zV+OnzmNoxNen18POaeVgpM2c20ce0Ugiv2QHquEPEcd+A/lVY?=
 =?us-ascii?Q?ogBcNeomZwABAwOS0MjaVwpLsACpTHmooQVTfXNaHaK7a4jvA0occ+R0CuYe?=
 =?us-ascii?Q?OtCUWRJvNASXnj79DcBz2ujxU1v3qDwwBFq27lCozUMGQgJlP5PO50qPVgg0?=
 =?us-ascii?Q?JXPnDKtVq9h/TIS7SszVeDzKBe24orGIlYhfN/v0HBYugivqrx1SljMxZSwt?=
 =?us-ascii?Q?qwsHgFEr3QLXB5nNpRawEENslJK+jRNMH9ZMR0fMCCJFVuA0uwI2RspQT7W1?=
 =?us-ascii?Q?VCjgt9WSeeDmQ75uD2qz4M78ou6vySu9mULTnCD7o5psAiySJfCOnPbduQXV?=
 =?us-ascii?Q?t8gjgCmUMakez9uScxA+eocHUqUMxGZz1RvY/V0n1MYbPjefbp+JWCHN/mFR?=
 =?us-ascii?Q?G90oiEsOe5GHBCuxPVVd7xqjeHYwrS8zwH0NWtBrfhKYGNN8byL6HOWqumH2?=
 =?us-ascii?Q?WMrc1oa7z9z724hrvGbMkNXfcp7hLTzIl2nNtO/rPR5MBNWdiHGitbf0ukkq?=
 =?us-ascii?Q?7C1SMwH0q78aVNA+fW4G7omHOYaMlzMplG173yGyrESCw8dQtGh39BpXwVSW?=
 =?us-ascii?Q?+JymDJ+27h8EkLb4vQgBz1R0F2Q7MZe7v1NTtuR7xW4/xjqQGlrmm32qrh1N?=
 =?us-ascii?Q?Lrqh3z/RzmZmTnA+sRU9mV21exyNwakzLO5I2gjcZhobyGwFFZACypK9hchF?=
 =?us-ascii?Q?Mnzn5HnETkNxDVzEt2cmtJpLDY5Cg7Ale6Qt/EgCBDbFobuEBrynXIhrZ/Vn?=
 =?us-ascii?Q?wRQQbSz9EAIFlzCX/TGVCF3YTGJUZGefZ1HhdHHrlKJ53zsmPhkWXcGa7ZVL?=
 =?us-ascii?Q?8nLX8wxktixuN0rb734ppbXfPcx+Z9yzyqzMzkO4Ymj/ruPx0Qq7TYuk+uvD?=
 =?us-ascii?Q?26ukF+9qUcjwIVdhF9Q5WSnSuDMWkfd5UPLmDmGplqhqqP1B45T2wtftXlK/?=
 =?us-ascii?Q?biMAMw3Bq6+x9f347Oq+IvmSVoASRIsJMs5vvHB3ILb9ojjqzh075h0O1ylt?=
 =?us-ascii?Q?XUxeaLXjpI4iActEs3OCkNS3+ZSJ9NE0wGG/S+nyGSXHzLu/2gRWCwN/HMTe?=
 =?us-ascii?Q?/wuw9btSmvBJbR+KkkSDco+byj8uASCINWRJZPd8xZX/h/i+n4JP2SGZlR9F?=
 =?us-ascii?Q?S+VTKCblF1tpg7R8fHqGA8k8w0mXN0ggKqTAb0VqQJm80LplKi8u9eI11Igt?=
 =?us-ascii?Q?Z/gjXNvpIXj/3R04suOZkrFS8UN53Jo/YQyKwaE4s3a9WyE4x7sh6XT7xp7a?=
 =?us-ascii?Q?yHHmxWzHc/0Fl+Hj9caGTioapHgKnlPNxZNh4H5MRntNo69s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a48911-35aa-4c06-f982-08dea5347db3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:43:20.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ck699eiQqAJSnBjA28rnfilmG0OM5gzhLkA0fmCIAoEk2ZmKtU8/vMTH8iJbuvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
X-Rspamd-Queue-Id: 15A1F487538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19654-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,fujitsu.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

On Sat, Apr 18, 2026 at 12:21:41PM -0400, Michael Bommarito wrote:
> atomic_write_reply() at drivers/infiniband/sw/rxe/rxe_resp.c
> unconditionally dereferences 8 bytes at payload_addr(pkt):
> 
>     value = *(u64 *)payload_addr(pkt);
> 
> check_rkey() previously accepted an ATOMIC_WRITE request with
> pktlen == resid == 0 because the length validation only compared
> pktlen against resid. A remote initiator that sets the RETH
> length to 0 therefore reaches atomic_write_reply() with a
> zero-byte logical payload, and the responder reads sizeof(u64)
> bytes from past the logical end of the packet into skb->head
> tailroom, then writes those 8 bytes into the attacker's MR via
> rxe_mr_do_atomic_write(). That is a remote disclosure of 4 bytes
> of kernel tailroom per probe (the other 4 bytes are the packet's
> own trailing ICRC).
> 
> IBA oA19-28 defines ATOMIC_WRITE as exactly 8 bytes. Anything
> else is protocol-invalid. Hoist a strict length check into
> check_rkey() so the responder never reaches the unchecked
> dereference, and keep the existing WRITE-family length logic for
> the normal RDMA WRITE path.
> 
> Reproduced on mainline with an unmodified rxe driver: a
> sustained zero-length ATOMIC_WRITE probe repeatedly leaks
> adjacent skb head-buffer bytes into the attacker's MR,
> including recognisable kernel strings and partial
> kernel-direct-map pointer words.  With this patch applied the
> responder rejects the PDU and the MR stays all-zero.
> 
> Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---

Applied to for-rc thanks

Jason

