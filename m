Return-Path: <linux-rdma+bounces-5381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A4999A954
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8819B283934
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F62194AE7;
	Fri, 11 Oct 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJTqG9eR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CE126C1E
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666020; cv=fail; b=CVxzhN1ucVz5d5OFNXLD+A6qim/ySuxyegVKlN0TQZTgmtfa+lmpV5qNsRDW5WwH5NIlTEAKqh9EenV9rpHNhlet0oyc9qL3EOqGxwYXCk38HfpKIPX24z9ymlE8vPJkySlXG2K4rT162c1oGDixWpQjAsJbj0VDq9IhtgoVVwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666020; c=relaxed/simple;
	bh=1Yw0x5SroUbDgrBJ5RKq64CVkfhNy6VUM/BUYxfwpiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E5KbPugv8a5udJRhziQoQQQ1J6kud+S4P+ES+UcUvxGmbU1TXGnZ1qv0QH5ch9k5iI9H5+GlDoKnjfb+Z89rhzG+NSFyAR/NNzOYOzuwiZzzElCBnS/3TyG3TRgBe9fsLTVpOuBwgw251UHZ1iskTWMB0L5PqyMqtswMjy+ciro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJTqG9eR; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp6HnIdWY2TzM48DoW/LdZdmIlDWqSOKZW1vGqrsiQSbPvSWZ4UGc0658a6DcY00HCteZob+st7eHw/YYSfoqHI8Vsq/NfrGFptB95Z5qbW0Bv9B+f/3lgbgPqGWPd81XQyz74+PQJ1CYonnzmp0+ZhwpBCTf7kicR8oZJ9KQfKQShVC4M7iDt7vok1OVLC1p3llq/MLhxh5FTfEz0rSEM22didXOp9+iDpBAtZR4asI9dwfI/uzbSfUDVIIdvuPsPO4I6jLA14E5ojDndCrGM8fYHFvYTsOxYLh/ZQ3u1g9hJkRy9LErsj3qY02op2TlWcmbRKRu80hOliNK378QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki81V5KP2zkuP6m8f/7ayf8Nwqmvxog4JLImTSsYOHI=;
 b=IOCmvHMTGLmd3vDI5k0eKi1D5CT3L0z9WnxJp1IX9mXVByA1Da4zAsaSKaz/knQ9UIpZoGyom6JeCrqVQxmGl1ZtdwUuvT+FpfPNBDQhMq2npqW8TYKGRHt6QeyqiNbmnjhiIL6e74JS97jrFwW/TsKpoAE0m1lAosD7ZoCzk4DTGSbG4N0SfOqmA8xbmQTrL2b1dvRdLqrj2ZKxPqw8yjFIVrTHgodOM1grwkuSXwdqtRvpDqGNkIOlckZc0I2xkxIWozaimxNYK+M6/L6BrZ0mnRXch1pNe13pCd7uE/9TpF8crXmXSlvuf0E3uq5HggEuS5E+aBxocKU6JR41LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki81V5KP2zkuP6m8f/7ayf8Nwqmvxog4JLImTSsYOHI=;
 b=OJTqG9eRz+5Hlcxn7DviR3Ajxq6fJNyR+jx3HHtTNC5VS0j1vVOesLchvoLupfKXv2zVpQo7n68FLZ2iquugGc9dGjKA3iT6OP761EPZ4Y8UEy/+0v6h7ZTArZ2lqI+nbvX9SMI0zMUjdE6zU1cK70mT46Aa8DXuy9mXHPzptpBZs56ZDTVN82Y1Pr9MS6pGa4D3nDyDHIvtFrdJRwRrwse65j5u+NWifhXshvAt+gR4v1eEKslxQNl2d02sorY2Uc1NSUsuUgxV7yLfVWDQunC2OmWbZgn+EU6DET34j7m0hhSstPcGNQxcJ1uvgvNZtWaawOtn9mWr/w+EQMs6sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 17:00:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 17:00:09 +0000
Date: Fri, 11 Oct 2024 14:00:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Showrya M N <showrya@chelsio.com>
Cc: leonro@nvidia.com, bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc v2] RDMA/siw: add sendpage_ok() check to disable
 MSG_SPLICE_PAGES
Message-ID: <20241011170008.GA1871991@nvidia.com>
References: <20241007125835.89942-1-showrya@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007125835.89942-1-showrya@chelsio.com>
X-ClientProxiedBy: BLAPR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:208:32f::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 87614a88-dbe1-4e3b-a0f5-08dcea1629ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VvSpDK3UgXMxVvP9+bjww1GbZhmTbC0AluucbCvPLM5eHg/KpYsWdL7n3NS8?=
 =?us-ascii?Q?neZlg/V/L4zVcLJ3Tpt1ehzjSgQLyQnjVufnhWIirKgZZxZr/WoB/MEzuspC?=
 =?us-ascii?Q?8QlM7NMFEQb6BagoAHFomevU3UUui2wesNoGRC1XC3EaP2OCqnYeTM7E+lVq?=
 =?us-ascii?Q?SgxsZaf4rsMLwZHcU7kinSxJdZnR4hDh+Du78sz6PGfEGoAgmG5tV9oQh84M?=
 =?us-ascii?Q?kuQsLJQTbSVSKqNXCPdYaZDpfhk10FIBL3HcZGlFSxLtNMU1ZjIR43hje05B?=
 =?us-ascii?Q?cc/cX5CGZ+23y5V47fuE+XPWB2asZ1+FAyKjJcv2ph44vfJd/eKdL/R9apkK?=
 =?us-ascii?Q?nRRFcXye52GRtZfF1vqLzBexH+TX7XuYbyaBBe7fdG3A/2mZvkIV5tKtDkwU?=
 =?us-ascii?Q?okCNZgg2xi1Vo5dHcLzfTI/UG8rf9V817/u7vOYfeYegfZ/Gr4qXTSC+OjxT?=
 =?us-ascii?Q?fAieHBoJce4o381jJ4JXTsHU28XG74LklBlODaK1AkXnZZNBgQxhh/QEZZxH?=
 =?us-ascii?Q?nINzXDp7Z7z/EIeTpQF2BueJKcctCp8NkseVVgvz8b/XuEaqbdMnPcc6NCZQ?=
 =?us-ascii?Q?zn3UR5w3aB7S6ZoWLntAAVDnfN2kBNOQ4D13XodexGV9JUVzRSZczDUQg36m?=
 =?us-ascii?Q?QhNMv5dloQhPEb79X82AhvSXXm4DcwzVYJRYyYpGw2Og8VaF6qxkMyAygcoZ?=
 =?us-ascii?Q?2WyKvy44Gn7tjmkpiHAGM1B3UmwRxFSJety6dmjXU53bBGWlqcsd/lhe1v9A?=
 =?us-ascii?Q?VGah826FOMsLYdlx4/aIoNkcWjWfrTNRZWnEJ2Lw1EvudI3afYg2YNrAIcDg?=
 =?us-ascii?Q?v5JnkYU8MXxUG06MScNEj+PR61EmFIbA7OBNJwYWh098INZRbrFhrfFCEWtH?=
 =?us-ascii?Q?FgAyNVyquR1Kg6/YyGimaILYKjqM0jh4I3VHmJYSEBUrQpUNHTAKXNsSWMel?=
 =?us-ascii?Q?YozoRd0TiPHfI42+Qh2A7GpumYetKI8Aa0Ed+EunJMJJvv5hJ0GGMy3Jq0FT?=
 =?us-ascii?Q?dpcAxQFCduZJ9TdMKMJ2Uhz4wHkR1rhjCUyjXizsGQjkXuOSk8JG+xqjc+89?=
 =?us-ascii?Q?/rfv4wchNOSrKGMQkXvHPsQxJJz954fq3TdMJblyKHP62fZZgYbo8OICtmZF?=
 =?us-ascii?Q?Ig1aZCleZpXrIHP6tz09zQCKbVKXF+vTPjz1z4dyNZbdsRgsPdlzy8oJ23Bb?=
 =?us-ascii?Q?DJwCWHm0rG44wr9wvrBVne1h5mlQe3iVnGyBKFUhsPxdVFrf3TItlqdfdG1D?=
 =?us-ascii?Q?zgsiSmOD0CyCS8KGFyljeu2M+w1umKxyWDaFH/6laQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWO7tOCtHeuCuTu0f9Bbp0qWC5+fZ5DMLhnVYyOOjH/EwB8/IkX0nMkApiXd?=
 =?us-ascii?Q?H9vqJxBAyAAJxj00sbKMc8TjSOHoTIbi4LIwGvGJlxmTkFzWUMPmgA0RDH2f?=
 =?us-ascii?Q?yfmv6jrNVnq1w46BF0j6q5nwP+szUnWuawxvwUns2ZF3+fj82kChNuXYWARY?=
 =?us-ascii?Q?d78Omr+I//f6iJTitObjzLzoEOd7WO9eVNDOHNz2IiL7iUYk14kQ2BkOmebI?=
 =?us-ascii?Q?TZOK1doIwfgYQuDdua2VU5IGldWqk9okIedClIHtGyXAL/3dXYdtGUR9NRmY?=
 =?us-ascii?Q?HeMJiobcxQZtdt1R2e+y2a6Rmqdaw6gkitzVSLHKTe6gQt9rd+xtC+oi/Eyf?=
 =?us-ascii?Q?25fNi1BVj+kH/fPIqnX3RR2Ww9rt7fj+0CvQfbtIrxoMhhNGa6dXyBTFd85e?=
 =?us-ascii?Q?G+xYKT65CLKubFnqiPyzPvbLhcN10aCOWOgmXtIGOUFI4HY77d7Iuh5uBpe2?=
 =?us-ascii?Q?37qk7BBAgm0b/OLfNhqFBqfWjJol+4+lh2BWaeDeRVZrdQxvWUtg+MQur5v9?=
 =?us-ascii?Q?CIpnuaIsfBsv7auCKrOzcCf7hFxpSemuEE9hRExVblvEIY/d/ZZiWedgx/ta?=
 =?us-ascii?Q?J2xtzRCDw0/VaSIXxvFd6qT2Cqd43K79r5V6iwoe+HWWMEPIB/mxfB9CVW80?=
 =?us-ascii?Q?BtmsvWTeLLaDCTbgrKr2yH0SNA+nQ2hkbir7lG9QeEDPvQYtcCuCiZF302ds?=
 =?us-ascii?Q?gVpv2Kv/Y6YvaeuVXMukc5fmsyK/BI4gQhnIZtI6hr1UV4hYCHLp5PJlwu9d?=
 =?us-ascii?Q?Ad48mc0J/nNDVDiUlMtc8X8Q2HxS2ZHC6/YV4/3pORwn1rxghHRr6X09nzyC?=
 =?us-ascii?Q?FLqjCE32Ng3GtY4qK41+eucKQuQas32rocjz5loTEr14WmURoElsdVjQNzv4?=
 =?us-ascii?Q?bCOiRvq/6UG74GhUu5TCrZSLWufxuTrzflNlvkqyTE6LXYxdxFVL76CyLWZN?=
 =?us-ascii?Q?LCjalLCEgS1KJri965+QKyARl07CQsS7IlyrbU1upLLWqSsh4OUhaikHi0UW?=
 =?us-ascii?Q?O5uIbJhi1WhBKNOz4Isk52wyfneGwrtXUzVx6C9z2ZyPBvs0Co3h9/f52zoJ?=
 =?us-ascii?Q?2H7z1z3xcUOmwbMA2Vt4BYqNbiUtMsI/jW7/8/62F894TWSqoIzbo7+M4KOC?=
 =?us-ascii?Q?B2sCD89SVQnxkX0Kk7/ER0Ul8OqDPUVueJndB35BCj551KilFcoBrXJt7nLp?=
 =?us-ascii?Q?URSGhdkNu9n2annLV8daXhmwq/2EXlX8mDU9SuVQeqMq9R2sl1SzoKPW9jhB?=
 =?us-ascii?Q?nCN+RgVGuK+C2iXH+7FI9yzR7M5izIhYogssvfhpj4S/rMvTt5a43hI6emwV?=
 =?us-ascii?Q?suorUEPtKPjqKDm/Wy6BclrW/0wzcVSDcm0cv0m/Z9lC2dITmm6WF+Z1G/7H?=
 =?us-ascii?Q?A5Oz+6ZACSsbZtGbrDMpKMG6h4R9/wqx7wLdTTmKhjWzHbAYrxps1zpCYbB9?=
 =?us-ascii?Q?AZy/dvevrIQDI54Ix0ZgcA8cTkSyzqrxXdR/7UIljUcemdNrN77brUoyNB63?=
 =?us-ascii?Q?3b1cZ9KV+TMB9k1BAb0tZyh+XfKy7sHd3FDaBY4gdZi9mwwRM4d9GddsjbPc?=
 =?us-ascii?Q?l0yEx4m3gMcVtkXRT2k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87614a88-dbe1-4e3b-a0f5-08dcea1629ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:00:09.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIcCORda+as4bk9nEWtxsM+0Wd3WM4ZVFuTYofQyepHA8iLGOBroZEOHvX2WMVPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

On Mon, Oct 07, 2024 at 06:28:36PM +0530, Showrya M N wrote:
> While running ISER over SIW, the initiator machine encounters a warning
> from skb_splice_from_iter() indicating that a slab page is being used
> in send_page. To address this, it is better to add a sendpage_ok() check
> within the driver itself, and if it returns 0, then MSG_SPLICE_PAGES flag
> should be disabled before entering the network stack.
> 
> A similar issue has been discussed for NVMe in this thread:
> https://lore.kernel.org/all/20240530142417.146696-1-ofir.gal@volumez.com/
> 
> stack trace:
> ...
> [ 2157.532917] WARNING: CPU: 0 PID: 5342 at net/core/skbuff.c:7140 skb_splice_from_iter+0x173/0x320
> Call Trace:
> [ 2157.533064] Call Trace:
> [ 2157.533069]  ? __warn+0x84/0x130
> [ 2157.533073]  ? skb_splice_from_iter+0x173/0x320
> [ 2157.533075]  ? report_bug+0xfc/0x1e0
> [ 2157.533081]  ? handle_bug+0x3f/0x70
> [ 2157.533085]  ? exc_invalid_op+0x17/0x70
> [ 2157.533088]  ? asm_exc_invalid_op+0x1a/0x20
> [ 2157.533096]  ? skb_splice_from_iter+0x173/0x320
> [ 2157.533101]  tcp_sendmsg_locked+0x368/0xe40
> [ 2157.533111]  siw_tx_hdt+0x695/0xa40 [siw]
> [ 2157.533134]  ? sched_balance_find_src_group+0x44/0x4f0
> [ 2157.533143]  ? __update_load_avg_cfs_rq+0x272/0x300
> [ 2157.533152]  ? place_entity+0x19/0xf0
> [ 2157.533157]  ? enqueue_entity+0xdb/0x3d0
> [ 2157.533162]  ? pick_eevdf+0xe2/0x120
> [ 2157.533169]  ? check_preempt_wakeup_fair+0x161/0x1f0
> [ 2157.533174]  ? wakeup_preempt+0x61/0x70
> [ 2157.533177]  ? ttwu_do_activate+0x5d/0x1e0
> [ 2157.533183]  ? try_to_wake_up+0x78/0x610
> [ 2157.533188]  ? xas_load+0xd/0xb0
> [ 2157.533193]  ? xa_load+0x80/0xb0
> [ 2157.533200]  siw_qp_sq_process+0x102/0xb00 [siw]
> [ 2157.533213]  ? __pfx_siw_run_sq+0x10/0x10 [siw]
> [ 2157.533224]  siw_sq_resume+0x39/0x110 [siw]
> [ 2157.533236]  siw_run_sq+0x74/0x160 [siw]
> [ 2157.533246]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 2157.533252]  kthread+0xd2/0x100
> [ 2157.533257]  ? __pfx_kthread+0x10/0x10
> [ 2157.533261]  ret_from_fork+0x34/0x40
> [ 2157.533266]  ? __pfx_kthread+0x10/0x10
> [ 2157.533269]  ret_from_fork_asm+0x1a/0x30
> .
> [ 2157.533301] iser: iser_qp_event_callback: qp event QP request error (2)
> [ 2157.533307] iser: iser_qp_event_callback: qp event send queue drained (5)
> [ 2157.533348]  connection26:0: detected conn error (1011)
> 
> Signed-off-by: Showrya M N <showrya@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> V1 -> V2: addressed review comment
> https://lore.kernel.org/all/BN8PR15MB2513C8CC78CBEADA83117A5599712@BN8PR15MB2513.namprd15.prod.outlook.com/
> ---
> 
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason

