Return-Path: <linux-rdma+bounces-19653-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKgHLwbI8GkqYgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19653-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:45:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF4E4873FD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E6230CD04E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38788438FEE;
	Tue, 28 Apr 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pwtNgqKY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470F436362;
	Tue, 28 Apr 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387189; cv=fail; b=MtX+qVtnqHsVreV96CYmmDR/7s2S/W/uzSP+66xDk6vlcfXotHOdZCgJ+xvPX1S7+rBbzucb2HyGBFx8jZZusjJ2VCTwkjlAwlNjnCPCZJQKJKXonm7xSc5nTSmrDkhF1VPWtTi48tdQhhXA5DQ34RePJ9IuU3e80jlSyLtkgGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387189; c=relaxed/simple;
	bh=rIC1RkoQGIXVcGABtAUsqmO7PgErAhucmAF8V5dEPUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ix7JHXlntUdTrYPwVTkPOYoYW16OU3G1zw50StGkbuZPJVz4ls1Z7sND9qzidKT0cJXxdYPIdeV1Astuo9BBNyHyckXP5flzM8FnkTTAy8U7oqOm2xXnkrzgpASQyp6a+wpfhprYZJBPqm85iIaNENrXRYngkVzc/oYV4J9Ga48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pwtNgqKY; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tePwR9U17f9AuUy4Bxr2RmGBuDAjcd9HkWDJ+Oxj5UsYbsWalg14tXQNlhEZpLaDoasbHQIAxNSXB0PE8pg9hDQJFR9Pv4ooFyUSIP6EdbQxtTfS29l770DuQkHv7z27WZ4zEn/LWEleI++nWzGXeKA8qKkBpxHdanzZa2br9fsw5Xig5n7pImg4rz5Gze5KKXY6F66mU7OiSs8shBzA0l4XEmuxdUnCYDub7wfKMz54SJc61NGrMv7FL4zhW64Ck+cWhFANxEEqolb1cKfT2sD08uspFWmqSr3NKiwL3pIt2XkYtkmW1rMLJdmdjxB+vry39Fpo6tVUhh1Y7HwnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C71Wv8vG4SsAfmDqlChLrv5cHLdjsOiT90nc5eI7vL8=;
 b=ssyXinrPxD2lOnXk4bbKbf+/WA31DY/Y2eMca5+az5ePLPBqwdVr2w71qfM/SdulMptdoksCwkeSS7oyGz00BBzQgxauOw//EBcw6j8QxoN5uWxhiy/W98HaA2jPHCENMWWo1zEekuUbc9wyk2c4sul+p8Zags5XHAf45USFUKn5ld/CvgnpiU31Sc5jAzTpu4F3aaav1rue2LPTCjAy8dugddM3GtgbHdhjr5jg817Vd8nPvCTR5F5Buh+sS/oMA9wQizN11sNpX2S5EMaD2bWquXsDHQLoNMIWyho9vtwOM/o1M0sdRXl7BpXAOioVdOVFF5Zs1oLIPDsTFrBUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C71Wv8vG4SsAfmDqlChLrv5cHLdjsOiT90nc5eI7vL8=;
 b=pwtNgqKYMEhCfx2sgti02+1TJkJo5r6nj5Lo/m3n1yVFCpqrQnwFroNhBM9CSC/PApXhAOz1lhkynA6XVikDTru+Fy1xy0xXc5qnGMjL/Ig8usPfSR47gFeO2PJhGYmccBatqjzmWcNyJZy2bvjfgkuFOsx+lkPzwTDP9JAzhnRcuVixfyqJVjp2ki3nz0W6tDRDQU22stJq47hHHpKQ+3yyjIJzfTIydhrIySTiBV8Bot2X4lHaJ23htGl3Hj9iaFpYpFBQrEw1dFvSGebu5kYzLSk/KKHsqO48KZfqhPo4lbSNjGr/SS7P0vDMzTNZLNED4agUlRlVVx8Q78f0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 28 Apr
 2026 14:39:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:39:38 +0000
Date: Tue, 28 Apr 2026 11:39:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	hkbinbin <hkbinbinbin@gmail.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: Reject unknown opcodes before ICRC
 processing
Message-ID: <20260428143937.GA2655407@nvidia.com>
References: <20260414111555.3386793-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414111555.3386793-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: CH0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:610:e5::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7542b4e1-c21b-46b0-e555-08dea533f977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P9slo4mqA+v4EzDviSaJdQfuY4z6brSb6p9GpuD7Dll4b9nQzLFWzXwt9mXgWHJcGYPlHRzzgRUi+eA98ZDg4clQnydakDagU1mJPyuPKBcQ3e6VLxywDp65pmJpPWyYvEqeE3MIEnZqHjhhKnKXzJsLsX9kEtpLyGKbIiy5Yyy9x8CO4BsCzLSLlPUQFxZLHAK4C8qyvhIDrldPqapwjP7+6sW5Eym4C6GDWjulO9P3/kwreyAKcEKwBo5BL9aCaOMk1bx2lSn/Gi2ZK/rlrkvRzWzooVBpcDCsLVyh+RJ6+Qo7wa4I11BarRHMB0J+EsVPpZptEyHiOfBbrvubPI37tIR3R9F7rNvD0P9WuMQVQZSMXxw9RXB3GDuTCQwhwcBsWA6BeHIUuywA3qC1K/KcZ8tOVDcBDG7zwuRZS9LNz3RIn6C9CaeXUmfoEqmF0D3u+NSjgJ7KUFVMLqm13B2iU7FslonH740vdjsk4+Qiylv76b2t/bRXOCeHaridm2GEIyETsYSLUgd6IJ4PdVzoF5AjeFPlofbzwXS3cTBNlIZE1p1Tcxvthx4Nm+6CXQObzS7CGLpTAQ/7i9FSmIO9FJvi1C19h6Mab4jZIf6qcwVAhxeHkpEKKWTnQYDkJF4MTNIX84FQdGLWiJxfVfQGDrr34XShawD1LLuZ5XXbnL68X+GUvtUwlwfOLNx3nwqPmfDNkm7wrhemRHxv1YD4DngJIwmoXOvrpeJOp84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/dMxElpJnlZ3hLdMCSXDTZfa+HLWINDaN4CCuR+tlJM5ctCCsqU6QVLf4Rs?=
 =?us-ascii?Q?YQLcU8fTOAu8iVqknewLRDToOl9ZIicNnPhtIXLYXu68Kr2eAcFPCtlK1Aks?=
 =?us-ascii?Q?pLR9urbfm8OrYjfLrYb9ErNAZc9nNISDmgybHXpbNrFL0GPybOLjnpcCw6/T?=
 =?us-ascii?Q?62GqeJNK+5j99bfd0PtJwYZnlxjryAK2T0sbafB5nL09BsfuF8+dtxai5dP9?=
 =?us-ascii?Q?d3svJ73qgYyE4HpwRytJ7jkWFwya6vYfJRWD+QYc0yD/zB/jk2TpoNrmv+kB?=
 =?us-ascii?Q?MAVIX8EVl04qFllNLdp8vlxPWCoXOPA7mFEWKPYZ3QPOvLzBIvv8i8rfw8dl?=
 =?us-ascii?Q?exu2rPigEog4y/QidSHFRQ+8jlX69SucvSOAjD6CB2RfcfxL+LowJ3PgolOp?=
 =?us-ascii?Q?/Gc54ScpfPO9B1UnvSWaiQoNHIkgGtmEU+jOIySrxZ0MsRv+2m3KA2HYnF6q?=
 =?us-ascii?Q?fKUc7rQrbj6ZV3gnAsPZtNAKTjhNF0Z++rwkS7urAPrYHEpJe/7lerFAASXm?=
 =?us-ascii?Q?FV6jx2822z1MGSmuqOgoMkFYtc18O9VE9iQuwTQVn9Zo1CkDyd+1pccIaTId?=
 =?us-ascii?Q?u91kGVdTnAsrVyuxX8HqdOt9rkBl3IgyUAT57ZWILy918mfuUfhkbUwO6Ifg?=
 =?us-ascii?Q?dnR7ev2L1WkHF2EbbdkC5Uwb61ektoCAOqcIPlEwW3bVhhkNzIWwxAxwO9E/?=
 =?us-ascii?Q?ZyzQpcigd0ICS8za1Br2xW+z9nSsiWE3PLLHpDxXCYP29yuSZr2+9CbLcYAN?=
 =?us-ascii?Q?WY3/IWERrMLkdcU+f7GXPwQPVr+DiQ1KqL+9lbJCwg0vnWdECcJ6OD9xfF1k?=
 =?us-ascii?Q?6RaNPVeezVkmQ6V9mENA34EQOsbICARhttWAW0B2URYJdLY4mu4cgJ7ywgG9?=
 =?us-ascii?Q?9bcn5rPACv+thbITBqW1RX4W37YFWMZWIeAwDUod2yvWK6z62WG9fuJbolSu?=
 =?us-ascii?Q?RL4yIpnfyk4UtC6sbMQGNfvPRoaAa2EJuxGosaci9CV6+ryVyZEUAqNr9XvJ?=
 =?us-ascii?Q?h/p/ZdTYgbN2bpMuTtnCyx27OH0ntdxNGjlZf5uLn+P21lZ6+yMyFtbTCa3V?=
 =?us-ascii?Q?GcT2x2Nr94smZTZ3recgIJ4tib8k2c+EPSN9WmTi4x56NVH6CMK1Dt0K87tP?=
 =?us-ascii?Q?jYJE+rTKPybtLRJPtVDl0bR2eecIpuY6lAp6ktXBvAO17GIGP4SGpJAtnepp?=
 =?us-ascii?Q?bDseUQyqpBpO5epRpmu0v9YLypX6nTLezTn256l+aBe5xKEhChLO2z9+/dZY?=
 =?us-ascii?Q?ZAIxqELtiatzCDvytpIERhwVVFKaSLW/vKAGLm1klLpDjA8v/84ycb9kZrb1?=
 =?us-ascii?Q?Ry6wn8SDBW35mfBltWW3KRhUCYb2oIyKX8PkaarKw2YVbUTVZ5pYcIgX9c88?=
 =?us-ascii?Q?exdubQU3V55cXcvfgI1B4iz8AORB+BlTti0v5KGzkXujVmOPVVsNLJ/qpvHe?=
 =?us-ascii?Q?6ynOFZZzNqzyOsBXOky6t2BcqAGVEX3hasl4kl7wAt21r78GMYdfja6oLSx6?=
 =?us-ascii?Q?YXnNPcwIeLZ35+ANK9brhSNZPg537SlYh0+BKAV5nm8sJeaAbsgTueR860L2?=
 =?us-ascii?Q?AGfH4kmEwCZMriZyINrsWeCOzBszxrBTPYcG7O5hCVhbap77PcfpoekSVZx1?=
 =?us-ascii?Q?POi0Dm1sEJeVU7bRq+oBwU+H6bF7wVk9YKaI+App0dGAg6RxAYvn2fIA9u78?=
 =?us-ascii?Q?ZpqqESwcrQKNhckTb0zizHMD2PMu5N22W4wlW2cSuMHTtwAU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7542b4e1-c21b-46b0-e555-08dea533f977
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:39:38.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvClVSnN7+QuKnGuI5/01EmHQfO0Uz8s8uUlJb0mggqpyhOyYrWr1B/dPeMoitAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
X-Rspamd-Queue-Id: 1AF4E4873FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19653-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Tue, Apr 14, 2026 at 07:15:55AM -0400, Michael Bommarito wrote:
> Even after applying commit 7244491dab34 ("RDMA/rxe: Validate pad and ICRC
> before payload_size() in rxe_rcv"), a single unauthenticated UDP packet
> can still trigger panic.  That patch handled payload_size() underflow
> only for valid opcodes with short packets, not for packets carrying an
> unknown opcode.  The unknown-opcode OOB read described below
> predates that commit and reaches back to the initial Soft RoCE driver.
> 
> The check added there reads
> 
>     pkt->paylen < header_size(pkt) + bth_pad(pkt) + RXE_ICRC_SIZE
> 
> where header_size(pkt) expands to rxe_opcode[pkt->opcode].length.  The
> rxe_opcode[] array has 256 entries but is only populated for defined IB
> opcodes; any other entry (for example opcode 0xff) is zero-initialized,
> so length == 0 and the check degenerates to
> 
>     pkt->paylen < 0 + bth_pad(pkt) + RXE_ICRC_SIZE
> 
> which does not constrain pkt->paylen enough.  rxe_icrc_hdr() then
> computes
> 
>     rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES
> 
> which underflows when length == 0 and passes a huge value to
> rxe_crc32(), causing an out-of-bounds read of the skb payload.
> 
> Reproduced on v7.0-rc7 with that fix applied, QEMU/KVM with
> CONFIG_RDMA_RXE=y and CONFIG_KASAN=y, after
> 
>     rdma link add rxe0 type rxe netdev eth0
> 
> A single 48-byte UDP packet to port 4791 with BTH opcode=0xff and
> QPN=IB_MULTICAST_QPN triggers:
> 
>     BUG: KASAN: slab-out-of-bounds in crc32_le+0x115/0x170
>     Read of size 1 at addr ...
>     The buggy address is located 0 bytes to the right of
>      allocated 704-byte region
>     Call Trace:
>      crc32_le+0x115/0x170
>      rxe_icrc_hdr.isra.0+0x226/0x300
>      rxe_icrc_check+0x13f/0x3a0
>      rxe_rcv+0x6e1/0x16e0
>      rxe_udp_encap_recv+0x20a/0x320
>      udp_queue_rcv_one_skb+0x7ed/0x12c0
> 
> Subsequent packets with the same shape fault on unmapped memory and
> panic the kernel.  The trigger requires only module load and
> "rdma link add"; no QP, no connection, and no authentication.
> 
> Fix this by rejecting packets whose opcode has no rxe_opcode[] entry,
> detected via the zero mask or zero length, before any length
> arithmetic runs.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v2: also check rxe_opcode[].length per Zhu Yanjun; "||" rather than
>     "&&" so the guard tracks the actual underflow in rxe_icrc_hdr().
>
> v1 was sent privately to security@kernel.org.
> 
>  drivers/infiniband/sw/rxe/rxe_recv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to rc thanks

Jason

