Return-Path: <linux-rdma+bounces-9217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607AA7EBDF
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F46D16C608
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C783230BE5;
	Mon,  7 Apr 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JDNYjveA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404382376EA;
	Mon,  7 Apr 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050227; cv=fail; b=OHm3L86Kj7oJatO7uLih3xpBnG/aSuQix4WKaT8NOVz9osNwcOzZxvrPF4c0ilpE86FFoV3gocppTAYn91pVqlSU/tst1RQVMpaG4N2tELiXGruq836aYB1AxDFyyPbiR51dOfimYdTwEHu72UAVoz06ct/gTX5uwaAn5eKwx1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050227; c=relaxed/simple;
	bh=yxm1CyWX5B10wJhHoTcmzBOEZT4FIrZ0Kw7SKXoAT7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CAE9ujmb0KTX6q6oe/Y/5h1DQRtwB3hXSFcEJvr1rrs8i4+F+3Cx1urn1g2Ep2jJLiP3yRZ6/cch7SDehafhD4cEYmFcmWVT2TcNLviIhsoVlPyQH/R6tSu9PnbYENy1LgtTbyqVbOiiF9+srkwJwaQlkODCeDxYEnCD+E0kVrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JDNYjveA; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq6UXRAh6s4dqa9CCh0uGdpNLtOuz5Dt+xGskZq4+QKaGSsOGFNWWEUsqJRJpwwyf7wAPk33kj6yI2CMlnIN4ir80W2EG0oo4g7meKaQmoc5sD/3CR35n3boOs6Yxx50B4V0Wodmu+OI8ppbpHoSkgeGx2T1EfwOGchjv4wYix4+erPbVeE7SUwuZRnyXA8DOXSd2SrkcL27391fiNruvgUbIBuOVS0c/aO8r6tKBFcLiKHMZ/Jwux4aV1Ud2h27Aslge1kzDRVpM/Cj1TiCNC9c8EpgcgLo+hxMV6g8LCqiMHSSu2RUcf6WdARRfbjkBLJoLzfeMVwaXIjZ/971jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOzuucSULduFsBVEbMYJtsDrRbXboKKihH33LUa4Rh8=;
 b=CNvea5kY0KRpvqbuOCGfY600xXcgiVTpVPhNY/7xIQtdIidlan+TmCvIE1Q0SG0YojPEIla2p3IqcipMfSTvGzx1TtdFV6OUQf1nyZKPC7BSWO143AAaEDD91wTEyp9ARLYz6EjeTAFDygEVxVSJiek9/qfzFNb8kKT2UBfusRN5QWDbMC4LAe5F7i/Re2cb81/HA0Jrf7rRA5Fz3/fKpSXMuhWR09y58k5uuxHXjzyCr1bpKW3CdBDluGSQEBT3E83iZAllMotm3ji1HifQdpgnvmFAR5dRvmW+wC1yM1Cp2P94p4th9sDmkEjkwoGfTzbzmBWyGPAnR+poLiyKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOzuucSULduFsBVEbMYJtsDrRbXboKKihH33LUa4Rh8=;
 b=JDNYjveAkBtk4JnmTGDLO/YAxB004TvMJkgIue9i5oV5uEsYfoBhhkknFQwfMdWtyp5riOMXCU+ikD4Ed7z4A5TudwHD6NtJUgP+hgSHdGdNrGAyzLp+T9YUNFDN2vQy7ZKZmgUFnq/rk8J/1F6bIZBmczGwaEsg7IJZs1xK8D7D9Gg2M+jY79Y9DQBEG+w3Mq1k4tIPYzgkb7N0NSpm4VlyREa6j7VOrD4uIqBspvXanPNQ3ph7YOASVYJZQgpBHeJObXddTyfNrjFPtQ9nhzoxKrChNJ50dOLaw65/D68gLQtUiKE0AKSY6GGag8oaYSMRJWb3aoO4S2KANn5t8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:23:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:23:43 +0000
Date: Mon, 7 Apr 2025 15:23:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com, leon@kernel.org, matsuda-daisuke@fujitsu.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Message-ID: <20250407182341.GA1771020@nvidia.com>
References: <20250402032657.1762800-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402032657.1762800-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BN8PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:408:60::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 948f5ffd-9c90-400a-5815-08dd760153c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcSSmR90ULMXgT4h/MqkTVNtcVovw7DDmrdzKIi4o/GsLWL1tEt0UeskTK/b?=
 =?us-ascii?Q?a3u26EgOvgw+tVaVZWELX/BvwQhPcGhTNMm9pjaOnYnic4TcrDAHdN26E8lv?=
 =?us-ascii?Q?sFfy15b9q3Ik8WUHI/Hb1HUGXNHXZ7XmYbS/Wxop2/QMVbTtO6YYJbFMKJN6?=
 =?us-ascii?Q?+L/YwtP3hEWAo36jBP8P6GHedWSbxOnTXkvi1QeJ5qQswPMIYk8xKqD1F0zf?=
 =?us-ascii?Q?XiERswpN68kdCF4nqJZ/lKFh2gEfif8l4Rf8BydbN4baBDEyYFr9Qrvq67os?=
 =?us-ascii?Q?m6uObKfyR5tkW5V8V1lmf+OOaWEA4E9J0kGBXogBGPDHIs4wOv8kWItnqZBz?=
 =?us-ascii?Q?xVj5+WXWimFPDP5T1rNMZQ0FxsO7KEFnvMx7CqjQiCqPKlU9qkSQhgLxzKA2?=
 =?us-ascii?Q?LgRV3rvKDky4/E+k27fkuvtagWfSF6qhnyU+a+VU5Zb9qpAOni4s3x1UkKMN?=
 =?us-ascii?Q?eJsxEA5FMBCNNSUxHexbAuui5Bk00NDC7SVWkWAVxHl2KQoNt6s6deMdfvRi?=
 =?us-ascii?Q?jDiiRFwVsrR7LkAizBzf1GcAABwQdwzk6Wpk6OibXUfpTQmSm5epzhUfSqix?=
 =?us-ascii?Q?rj1ItHCUC3T33DEKibnsf8RM6CfXo0B2rfzb74Ozvd9/DpD6I3JK847qd8s1?=
 =?us-ascii?Q?/XWPCU3U2ax2lNrO8C75xVp1RtUOwiGwxUXv5aNK+HTmIUY6JxkSszWPAqMu?=
 =?us-ascii?Q?kG9NWjfOZvW0DJbMholVW99A30bh9NnXLXdkK53FN7NIBOUE686lJDou0bb7?=
 =?us-ascii?Q?lebw/xT4KsSkuK6JlfRMlzntd7cEt5iv47YFm2JDG89cNFX7BswLU8LLXUzl?=
 =?us-ascii?Q?pWPtDSaLY7ERlemCSkuFcLB7gK0J2YzyBpLVci0/7jQ5nQosdSRiEv+xVcCJ?=
 =?us-ascii?Q?WApD5VpHcihRuz83cVslQD5Jv+GPsu796Ea3QnO7BIFIqwl8aihy4nxNvvAe?=
 =?us-ascii?Q?dn6cD0FeVm2QYv0EavdwYlZC3NAQiCKe1MUr0yWpme2BiugESQjbZ1VJqnPl?=
 =?us-ascii?Q?8DCCUOcAMZXgTW6j46jBglv4qTyzgjqRmOatSph7V77ZbJ3zyM/3WCZWW1io?=
 =?us-ascii?Q?iVr8n90IBVgC+8oCst3DBWIFgoNo6invwEu/d8QSqHuB/0bOYd8x9n23lqd6?=
 =?us-ascii?Q?bwMhA+lW5OAhMQjIR/PlSfomvgbtvEZL63e1vQwG5lPiXQqQKQ6WF5juvi9V?=
 =?us-ascii?Q?ShF/kQWW7nJnRVUjpgDGxcehs8KUWN+9EJVd+kVFsbOVKv7skhK9PxCspcRo?=
 =?us-ascii?Q?wMM7/8a3Y5I18uTlEny165Ne//NNTYrQv2uhaBF7cy0YVsgAxisEtw/NwVT6?=
 =?us-ascii?Q?sLobJz3+f9cf8cYAdip3Zrhlb585MFE2+ikw79gKdUYhnIPhxd0ysfA4JE1s?=
 =?us-ascii?Q?WNfYMsjkRdot7SPF6qO1YFv/FMFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nPF/OYQW+lFJct7DtnUoZnrT4I6TmbsW/PIvzZJB65DNK2APknNNSMqRDql?=
 =?us-ascii?Q?7xWenvJZuiwP2GgwxMMfhTuSfan8jOM1wC/c4c+KLUb6N+qneIAbGJnIKo34?=
 =?us-ascii?Q?NFyhFPi/PcYM3FqFDAjex2aAeueFvTZkPN4EVF3N1IaCvAzdBfj9LgEh1YIW?=
 =?us-ascii?Q?c/KTp7BLemdInzu/mhjxj2RFwJy/CP2tuNPMUwGZ3cMc+vq1KSaycjurj/ds?=
 =?us-ascii?Q?tsNQZ4KEkhQ9pcuhzi8Tva0reVfg0RbldthE9Rpcnp3mIavs+9V+3OeIzdY+?=
 =?us-ascii?Q?4dR1W6f/e+WKkBsUwSoBaI4vsrIL9TnbFsRdn9QButaFoxX/IM0mm21FFwMo?=
 =?us-ascii?Q?QejdUecmShmXfFoSfOoa+C6qawLWBpkJnvgMj2rzxOW6Y2ngVKIRgGMB5TY2?=
 =?us-ascii?Q?26Kch5z5TrmbUz99+4uxEKl9wmITEPFkfbif0PYDYPfNIKk20l8LsHpvA7Wf?=
 =?us-ascii?Q?tfwe8j8vclvs6O8R4BS/JDLVTxbm/kjmnZhz2U+z3wUuiK9fn9QXz5XledLx?=
 =?us-ascii?Q?hM9pnfJkwH8Q6PBagovTxt44Ztv8MH/UrcJ/fHHe2JETM9mLIijRxmWz9+F9?=
 =?us-ascii?Q?3xOoQpkjJ1uygYPbcR+hLHnmiOhGN85PC1PJSCTSR4Evhvonp38kIvzszseD?=
 =?us-ascii?Q?mAAUxg9HEVZo+dbIf49dOr66sKGG4xVg6uH+QahJh1vSAFzA+QqxAoGtSYSd?=
 =?us-ascii?Q?iPyVWQmbUv5WTNNCx9DMsbzZlEwDWLzS7YHaGkpiGc82gu+YfvkcNvoE+OeM?=
 =?us-ascii?Q?MU17GGfBMUi5/pS+gguzDhPcHWWRbY79T8JNRPoawWi+KZjYhkGeumzUA3H0?=
 =?us-ascii?Q?y/9ii0XjePx294F5bZSB5KMc1UOXwPMbbTvkqztvoH53xW07F6HI+jN0WmZg?=
 =?us-ascii?Q?ZQtx3lgaLeNR3uR9t7TeIE3IxwyHQ4PHvt695vt5ZHQC6i/fAMMvOynBJIYz?=
 =?us-ascii?Q?FldLgkEYkEwKDQRXYFOgsSztry67/THX2xiQRL7GH7+2ggmupykKBZxXIyjj?=
 =?us-ascii?Q?kIlWn9mbH6qldzHMJQGO6O5ICGDuVgm9NweS1sqGmxg2SkXTFgTbFAVuZoem?=
 =?us-ascii?Q?B2bW7qibyC6gEqyzn5dulS5D4FVx9LRHJ4weq/ZsfzzItgdKmJBqAgJO19fU?=
 =?us-ascii?Q?/CzF/rVkoERKBwLYsyOsClWMNLe23eAxkFMDmUyuZZteJlDKehQd/jn6dXit?=
 =?us-ascii?Q?/m8oElF9jtnwG3Nm91geDYKe0QL7cy5I26r0Oe1gO25XpMX/FNxYX5BA/YZR?=
 =?us-ascii?Q?nZeFGln1xjae5Be27AhbG/+FQVpkFpphXdE65ApgmomOgyRX7t029DvqOF9q?=
 =?us-ascii?Q?21ETEt6FtyoTCrLdicnelmmRpSnGML8XSXFWDo/r3BMBDsBRRFaHB6PiaULp?=
 =?us-ascii?Q?0ffUjy25W+t7AGXXz6MTMlXlCl/33nMnmChy9UOz+4PKid+sdD06KNhRSiZ6?=
 =?us-ascii?Q?IaRaxhWAMMqdWO1qD7fl2DGVJH68ClULYvZsUNZNhJJKrQBQa4IV62aKfEyW?=
 =?us-ascii?Q?eYJo6Is9eK8ws8Jt1T7/rVBxNHxh1TmhAjxaj+7w3EOHLBhyayIgDX5OxOpz?=
 =?us-ascii?Q?T5CdiDAJUWfnBvvhj+bTzc8FpnzqXoRSlm7BvAZh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948f5ffd-9c90-400a-5815-08dd760153c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:23:43.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpVYMMHubs5wIikYlP9CT6C4uYk/DmEBwKuHIMTFljI/Dgfn2y3ncGoqsZcTW4aj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

On Wed, Apr 02, 2025 at 11:26:57AM +0800, Li Zhijian wrote:
> The blktests/rnbd reported a null pointer dereference as following.
> Similar to the mxl5, introduce a is_odp_mr() to check if the odp
> is enabled in this mr.
> 
> Workqueue: rxe_wq do_work [rdma_rxe]
> RIP: 0010:rxe_mr_copy+0x57/0x210 [rdma_rxe]
> Code: 7c 04 48 89 f3 48 89 d5 41 89 cf 45 89 c4 0f 84 dc 00 00 00 89 ca e8 f8 f8 ff ff 85 c0 0f 85 75 01 00 00 49 8b 86 f0 00 00 00 <f6> 40 28 02 0f 85 98 01 00 00 41 8b 46 78 41 8b 8e 10 01 00 00 8d
> RSP: 0018:ffffa0aac02cfcf8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff9079cd440024 RCX: 0000000000000000
> RDX: 000000000000003c RSI: ffff9079cd440060 RDI: ffff9079cd665600
> RBP: ffff9079c0e5e45a R08: 0000000000000000 R09: 0000000000000000
> R10: 000000003c000000 R11: 0000000000225510 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff9079cd665600 R15: 000000000000003c
> FS:  0000000000000000(0000) GS:ffff907ccfa80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000119498001 CR4: 00000000001726f0
> Call Trace:
>  <TASK>
>  ? __die_body+0x1e/0x60
>  ? page_fault_oops+0x14f/0x4c0
>  ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
>  ? search_bpf_extables+0x5f/0x80
>  ? exc_page_fault+0x7e/0x180
>  ? asm_exc_page_fault+0x26/0x30
>  ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
>  ? rxe_mr_copy+0x48/0x210 [rdma_rxe]
>  ? rxe_pool_get_index+0x50/0x90 [rdma_rxe]
>  rxe_receiver+0x1d98/0x2530 [rdma_rxe]
>  ? psi_task_switch+0x1ff/0x250
>  ? finish_task_switch+0x92/0x2d0
>  ? __schedule+0xbdf/0x17c0
>  do_task+0x65/0x1e0 [rdma_rxe]
>  process_scheduled_works+0xaa/0x3f0
>  worker_thread+0x117/0x240
> 
> Fixes: d03fb5c6599e ("RDMA/rxe: Allow registering MRs for On-Demand Paging")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  | 6 ++++++
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
>  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>  3 files changed, 10 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason

