Return-Path: <linux-rdma+bounces-20736-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDoTG6g9BmqmggIAu9opvQ
	(envelope-from <linux-rdma+bounces-20736-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 23:24:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0E54706D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53C5E302EA99
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717733B8406;
	Thu, 14 May 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjaHUwuv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E525B094;
	Thu, 14 May 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793893; cv=fail; b=lDTOyUu0B2H+pIhtLyToJ4t4OUv8FADuwyfBgREA1NF4kYmnqCtpWCjA+oU6mTqox5IyiqbQHkfK/O7KEJrA8UDCsMYaroVEhSbnIbjslUWrkFya0JqXNFXIiPDVOSLFcIJH9hqQvDjCve9FMAEOH4D16beJRBwzRYXh4UhIPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793893; c=relaxed/simple;
	bh=pXLxprcNJ7VdkgI2cALH/feoHlCdBbpVsp+LE7yHbtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOZ7TFJeBmAENROncm2p8+KLl7iQd9wvNAX2aPYc+Z1Wrrvhsb+4KbImw1pcsG1j5lMwdAxYtPmhVCknQ5OtYR6lWCHMFdZPuhTTJId4fJtmzU8D7ZTPh41R3gRcyHEAZuBdWPW2KjqSoCfx0aU7mFzY4tVR6s3j1WZSNn9jhdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjaHUwuv; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7T6QR8Sa46mNOdPq/tEGTwU9jheg0hDAZLFSULijX3eRKACbAt81q8FI1R9pt4WRZnPGzsawnHTUXPElAFHp8FvgxpcpArAKmQ8H4VEujJ+K8qvCSDDGG0QXFALPxgqvVfrEpjoG32TJLjgtG6K7B+j1ctbZWcLZEvXQkEBlZGNYBPHARMKEfkQh3ofjNnQknzqFNZwpMYw24IWYInk4ckKbwZ8VY9v1dQy3l0wtib/1mVpLxgq8XZd7cQEdUQxtEWyVLsT3P39Gid2VM6LqExXyZHstSB641UnF/QlVdSV+cIxNKr4DEEvQVxtCkTDsGIloD0AFOJXvfTnUXa57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs8tTshGQNuighLkTqyp6hEJct9VzzlsofFxt3XYZwg=;
 b=qZBuCKmxZec6wX1RdbzTYxgRUxUc+kLp9exuIz22skIf5mbjMIUb4Lvsc140rFha4d/08xfi/30MzIUPRZo0opTZMQAzcoAtS1SyeetCIbLG3NgTblHOef/iFNc2MoQttWOxOG4aVROHiED5iPS9K5hazg4zoJrHIQ3D7nJ+lD3FkgHbmBl2r0UAiV/9R95lLPo88P7+jcDlM0QgW2/T4njUsY4vpW5RC0S3Fn6n1EuvMuo7cdlXjiNb8ZVDYrDPU/nqj8chCgkAfly07VxE9HOU/OfmAFTSfiBHkp5u2qETyht22jEk3JX9wDn1LB5FCuUkY3za4QGyxcHEcNlO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs8tTshGQNuighLkTqyp6hEJct9VzzlsofFxt3XYZwg=;
 b=mjaHUwuvyrGYd0QeqOgVbJmJ5SFr1IeFeQpbT1K8wfq1o17+87sgbGMf4ADTYHrxxnJKnLNwOu097ZqAX5wMd+RsVizTsIsWgsvDbBduvsdiR3SrS97K0fBbhsrvKkLgnCX+O56V7qTXsXYS59kW9x3rAA/AdAl1s8u5n1KQZ95LXrPE9/TC5x50pgeMOyQIUVuu6mgs1M3Gqap/A3IXk1A4aWGZOIruDEQyOCXgVYBQWMx01GfpwdCNSuqwqsH1CpQtaAgGT6PSIrYbwDLktrJrnBazjLgydmhSfyscJoRMJ4t0xhTG8otrPIBjN/YYBGYjDC7Yjgm6McTk/Mln4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 21:24:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 21:24:46 +0000
Date: Thu, 14 May 2026 18:24:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/siw: reject MPA FPDU length underflow before
 signed receive math
Message-ID: <20260514212445.GA1452755@nvidia.com>
References: <20260513175325.2042630-1-michael.bommarito@gmail.com>
 <20260513175325.2042630-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513175325.2042630-2-michael.bommarito@gmail.com>
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f24514-39c9-4c1d-6754-08deb1ff38c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|3023799003|4143699003|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	H7CNhkAwKtyF0hllvHt+O8w6IIYhjkf9tpAZoq8bkGiUBt2w6iFSbjWlCtQRmk9cea8wFsJf+TvxvhULmgLVtuARcd8kQLKndrVjC/cHNjX1SopqhX5a0o7EqlGI/4ZyPRnj8SSbbZnP/0gcql4y3qGWK67vj9cUCT8QcZmVymIqLzVv0OpfZktiY9PwATXosEUxyeRIgjLEdsHVxS9Twnk99AjFy+CGRFKiB4lmi4HECpj01GA137D9H48qz2V//Kr8GMXcibNV0PiKTC4mzAIUFA19u8OkNwBlnqARG2PvaPntaeJ61ZGdySghUbx/EQurZL38766YDdE3dfCq2pWQC1vQprwhrQ5KGi5R3d63b1pT8o/q/S81HekdVArZ1xEQpRLs9EyoAvw2ka4z/T+NNlSZTgbhx8mColv1oETu7aNJhiw1U6IwHdLqMpyyRrubVP8ereU47K7eZiGNxRCBucxsEGSr4iBWbPPJalJ0SqoJ51Ehos2D0crtkgrlyxJEZh8WMsYUp31tiPzz6bLIVK/Y5lFC3Ml62LeK/gn1EZYnfjTksHVNoVvuJ+nzdEpFKSSHunji5KpGxJc/xqabnMJfE6mUosBrWG4g49G7X1flGZVmPtRJonvS/5ibl4MFTfKY2LaoOA2jZ5V6JLbCDs5ztjxcPdXyhsyBZ3eZAJEVUiGPF31gexdkTmUY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(4143699003)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1B4hsCN2odE0nSkduu80qaLWJOUA5mLlV8JPR9nU/3gi1lhgFxCjRCr9dHEU?=
 =?us-ascii?Q?5YslBqF7+jxZ37lTPo7TZdjxYF3G0F2WQTpGGXrT4LVAD2tlhVlk0jPliLqD?=
 =?us-ascii?Q?RyUENj3Lk6wZPaztHRP+S4YN84G2UpuDlV/Wm9cWJaw8ez0MtWcP5ySdqhkV?=
 =?us-ascii?Q?sm/11qGltsEv3D8plFiGTQkyNRgpikgY/OADVzKM3qLi6FZ/R5/qEGhl8NXk?=
 =?us-ascii?Q?jtqK4wPfyGUKppaYvkwR8FA4teSuTI4T2OGoJkYQ2jggNW+lO6Jqiwviqmu9?=
 =?us-ascii?Q?rNjljYCV5ZA4Tw/urO3x8Y+Zzy38/tZk1mHTYRBRsgNHKqa/kYeLxZfWlvcU?=
 =?us-ascii?Q?8iKKlETBNRQAWvs++6b6mtRn+In0uc5jpJn+/CDug4/yWTwD2dtj4uoHmNTS?=
 =?us-ascii?Q?3KPRgjY6ukSyJz5Y2FKDUYEaZOHGANmtNzm4guSGViOwLRdUk/PKkhBNSjv/?=
 =?us-ascii?Q?P0EQKUBGs5KQKVnWoiMHRMjPfsL6RLiQSI3D8qQ0afW1o08TdvZpSsPVMZpO?=
 =?us-ascii?Q?H0+mHyNG0eVjIHn0quYVKhm6xRe3r7rea801gVk/1wUmXi12Aw0DT2u9L34u?=
 =?us-ascii?Q?+rwjwZFxRFXBFA3kxArTH2aL8N5oSsAOxGRmpmbQQLT2LrI9DmZVt/Fb6b0h?=
 =?us-ascii?Q?lOh1h+UwPkb6Tv/Gll7SjKdu03xGTgMkmO/5gSCAXTzU2CgM5sdJ8ENiCHF1?=
 =?us-ascii?Q?0Q3HpD8rUeJkcxeL3xkUo730xQTP44uZnNVX8nGRmogt8QExf4OuV5jAXiqg?=
 =?us-ascii?Q?29F8EaAWySWn1Nh8KPFnq9+/orVhr2whJAk6fssNZpVxmjbJtP2yfIv8Wmx2?=
 =?us-ascii?Q?lPmi2J729lA3hENG/+zrHK/2eMFvuH9jd3IRlhN2elF+zI2puR2iPhIW5eOi?=
 =?us-ascii?Q?iSbL44qOAqmNoOpH/1d2DQXrzpyo3xyURH/AGmDmcqTloIr0tEhGp218OCQY?=
 =?us-ascii?Q?zKGBt3BT89v4JNkQn/tamog/ELI6ZMenE60VP9waHFqrj9mLa/Lv318L/m/v?=
 =?us-ascii?Q?eZqkBkFtZmvszf8n/u3Cvguvin4elHvwI1bfaD1QCgulNeM5fQxYuCnQ1/Mx?=
 =?us-ascii?Q?qv72Rc5BffyJ+gPZ2RBDMlS7Mrr07SC+qcmEtSfpN3PyUCPOXiBcOl1fHWmB?=
 =?us-ascii?Q?Z691nRt3qUO3x6kVYI5EdAWFVNgBfw4MIf4UrXYyELrBz8jdxRZQc0pC0t1J?=
 =?us-ascii?Q?E2kYmPQNT2/FzGcTtasMMMBSN7izvQVnPCeTd/7WVObM/eNAHYdxnDWajNES?=
 =?us-ascii?Q?lBX5d2ORJo6K3TWO6zYcmE7dfWrfc4XM4GZxGvifiuElVxzfrovitCmQ74MT?=
 =?us-ascii?Q?Mm/xcRVA9ESLiwztRuoYtv3OHtsQ1Cmm9m+Cj0NJwLUsFnJrPPRkYwAXx7lR?=
 =?us-ascii?Q?Qk5PiEPz4zDVYiIo7H5BmBxzuemobKlmeptALfE6Y1nQmzlLE2IuX7deQUHL?=
 =?us-ascii?Q?Ymfo/wDawUu44tRVrR0kzpwtX2a8ipJvfkdAYeTIWVcUhMFfJvjEUxl52kq1?=
 =?us-ascii?Q?uDnG7Ig/PCUiZHHggyGgqKBS+4QDpiZ1xeB2GuHsH8QLvIlJsmTEnbH6wqmR?=
 =?us-ascii?Q?4oa0vsS4GTYUsCAVO6e2dfsSP+FTr2UsPPuvvbRxIeHg+Q6kR914GhW8f8XT?=
 =?us-ascii?Q?DcHmXIXUygKqevGCfxFDBYrfWaQryaFcbNjYoVfbPfcY2aIAIvIvAwW1+MRk?=
 =?us-ascii?Q?cpjxqmWdZg2asS93wA/ifwhNfXvszgA6ED0hBxHZXP9B7WeU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f24514-39c9-4c1d-6754-08deb1ff38c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:24:46.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8gHtV7aUSzICClFGtebZFZ9Y5W48rIgbdGb27c4Ckt1gxJ5eEfIBj5MNaLP+DhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
X-Rspamd-Queue-Id: D7B0E54706D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20736-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,linux.dev:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 01:53:24PM -0400, Michael Bommarito wrote:
> A malicious connected siw peer can send an iWARP FPDU whose MPA length
> field (c_hdr->mpa_len, 16 bit big-endian, peer-controlled) is smaller
> than the fixed DDP/RDMAP header for the announced opcode. Soft-iWARP
> parses the full header in siw_get_hdr() based on iwarp_pktinfo[opcode]
> .hdr_len, but never compares mpa_len against that header length.
> 
> siw_tcp_rx_data() then derives
> 
>     srx->fpdu_part_rem = be16_to_cpu(mpa_len) - fpdu_part_rcvd
>                          + MPA_HDR_SIZE;
> 
> where fpdu_part_rcvd equals iwarp_pktinfo[opcode].hdr_len at this
> point. For a tagged WRITE (hdr_len 16, MPA_HDR_SIZE 2) the smallest
> on-wire mpa_len of 0 yields fpdu_part_rem = -14, and any mpa_len below
> hdr_len - MPA_HDR_SIZE underflows to a negative int.
> 
> The signed value then flows into siw_proc_write()/siw_proc_rresp() as
> 
>     bytes = min(srx->fpdu_part_rem, srx->skb_new);
> 
> is handed to siw_check_mem() as an int len (whose interval check
> addr + len > mem->va + mem->len is satisfied for a valid base when
> len is negative), and reaches siw_rx_data() -> siw_rx_kva() /
> siw_rx_umem() -> skb_copy_bits() as a signed copy length. The header
> copy branch in skb_copy_bits() promotes that to size_t, producing a
> multi-gigabyte read.
> 
> KASAN under a KUnit harness that drives the real kernel TCP receive
> path -- a loopback AF_INET socketpair, the malformed FPDU written via
> kernel_sendmsg, sk_data_ready firing in softirq, tcp_read_sock
> dispatching to siw_tcp_rx_data -- reports:
> 
>     BUG: KASAN: use-after-free in skb_copy_bits+0x284/0x480
>     Read of size 4294967295 at addr ffff888...
>     Call Trace:
>      skb_copy_bits
>      siw_rx_kva
>      siw_rx_data
>      siw_check_mem
>      siw_proc_write
>      siw_tcp_rx_data
>      __tcp_read_sock
>      siw_qp_llp_data_ready
>      tcp_data_ready
>      tcp_data_queue
> 
> Add the missing invariant at the earliest point where the peer header
> is fully assembled. iwarp_pktinfo[*].hdr_len - MPA_HDR_SIZE is exactly
> the value the siw transmitter uses as the minimum mpa_len for each
> opcode (drivers/infiniband/sw/siw/siw_qp.c:33), so this matches the
> protocol contract. Out-of-range FPDUs terminate the connection with
> TERM_ERROR_LAYER_LLP / LLP_ETYPE_MPA / LLP_ECODE_FPDU_START -- which
> is RFC 5044 Section 8 error code 3 ("Marker and ULPDU Length fields
> do not agree on the start of an FPDU"), the correct framing-error
> class for this inconsistency.
> 
> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Acked-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
> See cover letter for full root cause, series rationale, and test
> summary.  [2/2] adds the KUnit regression harness used to validate
> this fix.
> 
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied to for-rc

Thanks,
Jason

