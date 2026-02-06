Return-Path: <linux-rdma+bounces-16611-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHwaBlJIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16611-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C83F90A6
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64721304A66A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3E24A044;
	Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bAJMi8hz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09C247291
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342352; cv=fail; b=k0HICjLlAEqs7caOQ+NhJ/+Q9S/R66J39/jAZdTES66cU1v4rnIaXVHhIx3k94I8J4jikfxmvZ7JiT2mYufj/p/SbV6UA4TXY6B/1ife3J8ZyUK4coTM+KFwEr/JavBEBZfqYGXuwvz4DRPJE0YP2ITJtpRKauyaKnwi9j5Pyd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342352; c=relaxed/simple;
	bh=B9IL1thTXv2WpgR74td6rexFqFLVr2acJir6T2Pdbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D30TfANQ+0Vjaj+LVWeXxSIvNfTEwca9bFaE2D5m4HLS8ouzwPRCFoWG5de2hBcgDnAIcHjkIwQVvpf+EC1rRBcSfMBIJJT+gG+MBwbRJhQEuNktj6zMwYgdA1evJzV/kgxXKXkMnE6GS/kDqhLOXkJT104Vuxm3kOWkPf6zqJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAJMi8hz; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/XJNcmaRK6aU53T5rGgXjWcytocfOU2ROOT+HqS7QxHPKtBUPnGNn5vSMwM7PBnSnOU39Z8tsQSIjqaUk2nMgUM88yc5weoPmf0piQHTebD3zHqlkvqNn5mNkI2/IODaeyBFIdLdY7M+JfhmvhflQfpdccfxTjTGKCdx+XHB5UhcIMA19qFn0uubJQPoYlYoJ9UC5X1SorlbEsnh/3LmG7CakH9F4sbLElOHfHzeSFv+ojXsr+qSQD9zYqlh+/2S9+QPR7TuvD9NAbUbsbytXET9Ll6fAJZ2geUNv2DiuaIV5svSCp4MPwpAO9+5OEtcZ3hQVH9F4SNFGac0/5v3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvjjsaJ81/16NJNYd2jd4LrRSquGd+VN4ILhemRBQbE=;
 b=usQgdXdZj8fDCiuWe83emJBJioUM3Gbb7nKVJp2IFRWaHiDvDuCY1E0sJPf6M5pECgr6VmobCZxVroyv76wHcRSupeJ7i3eYQZqGPG7paDM8ox/wY2mqDpXWs98hwuc8cJGeDuetR+O6MJO5noeA5Nv0vLpzBVQH3msEj1K5L2p9TfLtvlhXtf7zGFqdDdJruhMnheh+S6w6V0h36F7cfFZaXoog6yvp6piwRP8hV5UWngdgKYM2Ig7yK0NhBe4P6zElTFPNVoOyjF976DIBI9Nkd7fp3aaTBvLWiLe0r2N3HkNnddUQdfNdlOKYs+7/0LlJhg2/yleJQ2hrNZO5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvjjsaJ81/16NJNYd2jd4LrRSquGd+VN4ILhemRBQbE=;
 b=bAJMi8hzzzY4vZCmNktF8AfufBtJB4wGrR4dokDBI37uEYE/fU2F2H13Vedjqm3viEddVZxEGcM9EDazIhCoWTzl61jLjsi5zIOtUawtNyARGXcivtg1Tbp71ZNdZHeCiUkng/zg2d6xUS9OPatfaErXaP+udkdkQMDuk+F1+Js7j7OGl7/X4Yk9jygMkLMKRPx/jqbNuRtaEHhHQcyrZV1vyK1RpydWCVz7YvDwTd49DvCa9uy7dQcsyKQyaX300uM3wXntccfrrnBC7pcK6H37UMnIq8+nsNjI/g22i/ijcM46veF25mnQHZoyAsYz0ca+Y3ycw6yVDT9RWOv7Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 05/10] RDMA: Provide documentation about the uABI compatibility rules
Date: Thu,  5 Feb 2026 21:45:39 -0400
Message-ID: <5-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: f56e11c0-c0c2-42c7-26db-08de65217307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?0svFzBoMwQO4VVqZMTcwBTQxQFZvV6Grqd6ZoBiBbC/PyL+ETe/ACF6CMTpu?=
 =?us-ascii?Q?mugw3ckV3c6C+GiBNd6zfVdlisLBxT0Jq06V2Kh9HdPkUCcxSVU2LEcK2bRw?=
 =?us-ascii?Q?XX6LPEgZ/m0FpgbDjBnhaHujojZxF7AsuJN6dGzCePWVB9stRt3HZ3orE82O?=
 =?us-ascii?Q?ttAGuyVqREj2A5qZaLBdi3RW1fCysd/VquC6gGZrchq0fDBj9P8Zdhea189g?=
 =?us-ascii?Q?/SvBDOZB/c37+bG8fAdzw7h6TY78yHwDbz0BIoQtb0upmw2W7m93GpWl6AEV?=
 =?us-ascii?Q?qPLIjnhbT4kUnBwy83uyANetyIcI7+es+mq0C64MlW4xwTauWLBC30BzpmJT?=
 =?us-ascii?Q?XXnBfgWrRomuUrMtHrlGfmrUWJpvzUV4fX8rAKH0YypdOBkLVFERsuRRP3RE?=
 =?us-ascii?Q?0BNCc6TxKqD19+9haN4xJKB1x0qmmF6V4rJUopG8jPcu+pNYVR/iiNc16k0V?=
 =?us-ascii?Q?tbMAgVJQEVseXcgx8XyG1DhVzk5t2S4oYMphBpBRNAhkl75R7EpKHO74PJE7?=
 =?us-ascii?Q?6GVg1gzfHqbJwd9OBKobiX3BrfcB8vRKamplQMowlgrV3kthLq70kxteVjaG?=
 =?us-ascii?Q?htMRSTYNzEwHbm4xBCBbG4U217jgShHBJ1J0RyQLuCe65DskXcWR00mg72z9?=
 =?us-ascii?Q?dhy7twg6AuyfpRC7WUgWoCcoM9M3BGevcJyg2mH+JqK1G8Izo6jsXXHZGcs+?=
 =?us-ascii?Q?wxFq+FtzDGyLwdxBXzT6wj74THsfMsXbYLJldloXkzB1fpKYvHu39FKy6WYw?=
 =?us-ascii?Q?LcDCtV6CsHT83dYsTgfcE4fytD99bB22ZUDfR7E+TciQ2DEUTpxLBLFuYR2O?=
 =?us-ascii?Q?gxROL1UNa9yOQsWmS5+18oJmyWstSyr5/THJxRpsYZgsxXlcrEv701OEJ3tM?=
 =?us-ascii?Q?VmlRNzWBUaKcAxosDrj6LmEwd9sqrERZUb4IuoCj1S5ga1uuX5m/MuNIVKrc?=
 =?us-ascii?Q?/a12qdsJQS88ms+r2W8tDluuBkXCWpOS40nvh0x8g7hxwx/2M3bPH8wVuAnS?=
 =?us-ascii?Q?/qEu9anOdLl0/pxKPae0e/1knaKO3HW7onlusMb0+J8ILD2zOJevOLStyA6W?=
 =?us-ascii?Q?BQL1tTQjAht8bk423NEc9SR533FWOZYhxIRCoapvkyD9xeWHp4y6Re39iE9D?=
 =?us-ascii?Q?p+GdS1fL72VZBFrFB3A8cyNNBkN6mrnBimwgyhJrpDHxogprL1W6XC/pezMd?=
 =?us-ascii?Q?lu2a/StSaTVPFxGTZy5X4iz4MILr+J/c+kNwoESCDT9IxJST+EFYMVlZNnY1?=
 =?us-ascii?Q?A3RREHxHI/E7KrnxOmx6CtQFDj1CCDRzDCqFbqpUiRrc4dVoweu8jNCiJVWF?=
 =?us-ascii?Q?nS3GwONqpdNnw6JGLLMsFH+O3TO7OhR37o3mNi0DL6EDZfdV1jVXyt/9V+xa?=
 =?us-ascii?Q?VBNMBZ+7uf1P8N5tqrjMpWad2gwMzqqPeT7niRm9t2XWQ5ZWOdWnDpTYq9/d?=
 =?us-ascii?Q?+//A02LKzsUmU3yi/kXuR9TrnIwMd16MYfkVID4qCu1ebIrnFOPoXUJ0qcSd?=
 =?us-ascii?Q?rsqagJF5sE1uFzz6Gfue8mJFJYfj/LR3bItmnVDI9sLmBc+OouaX4q5MBeUf?=
 =?us-ascii?Q?bBvgAFndpKcK0pOFZys=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?eM6MvGOeyF8TMenFGTXhHSp8TLVY3JikSSkxWja0Yy6NFKSQs+VK+ANaQnjK?=
 =?us-ascii?Q?ECsI5kAWbiu4/fdatj0dP4zUbe5T9oJ8rmrEVXHdndqnE/RFN/XuJJNS1fDM?=
 =?us-ascii?Q?mImCBsAgI6ILYA4NL/QVVVU8N+QH2FHHLE0wj/cdoX9yaMZHO1sksJWlXRH3?=
 =?us-ascii?Q?duc5ZU/uDxlVVqoxiKzhM/utbflW/Ztqx5ZcRfKlnhfTG3k43Y8gIl8fawFU?=
 =?us-ascii?Q?uLv7kCi8DSazc1W8KKez4BWpuGXQxLcwX2oTJBOgtzmsDj6zMu2zbdECy5vB?=
 =?us-ascii?Q?SyOJPJDd2dUzYLvDBhI03dM4IWuSJyQKa1Xq5iDzVNQK2ju1OFjOiHYS9SYA?=
 =?us-ascii?Q?p1RcsxVJ3apmGYo2HdGSt1jOkvtUWrZCraJQLGXPCHzFWCf/Hb6OVen1s/SV?=
 =?us-ascii?Q?WJOMtxeOsBg/nqY6+vZfqetz5zW1+Wz78Z3UTZg4LC/tJSVoiiotxRPs9k0d?=
 =?us-ascii?Q?rHEgvTOzqHkys+97B/bT6N5MYwTBFpyBSRlQ465h5irkj2nrtbbyUMOFqyq1?=
 =?us-ascii?Q?Hx+8yMDJSR+QJUOnRV6T+U41W4ErZi4DuE9TrLYxYE8enlhdh2ngIHgB8iJb?=
 =?us-ascii?Q?tfZ46J7QG1QS8x1gPxFfxhU9g2hjwCE9G1JdMPy4KcvjoHngTN1pqWjCMW+q?=
 =?us-ascii?Q?8ryheW/Sh9x6nG1gVc0ihGHLiBGEju5SGvOcDq4cOcdpH6WjKKy8a/rmZ7IB?=
 =?us-ascii?Q?AAMwIjelipy2xtqa010xZ/n1O+ZJreSQeK1g0PNt3n0l1R7ZlzyuzCmJyU3i?=
 =?us-ascii?Q?rTbRJcmJeWY0qwOEfAPHwTQrS5gSjHoaOuw6v6AZ5IN6MpY94j/MCayx0cod?=
 =?us-ascii?Q?JL1K+O1lJnf027rkaAzlCjRTUj7ABnXahXc/z6rxDVvp3jqP5S21gYtpHDSL?=
 =?us-ascii?Q?LBWrkFcphwUVnooC5/kuNya3fgmlqHrYtVD/1mmeQ6emGdyjO7Ok/qc+/k6Z?=
 =?us-ascii?Q?ED8Pxx50FxZjhxQiHnb0ZE7x1NKvIBYG1HEcjsrhjV/0kS2126E8PzzCglC4?=
 =?us-ascii?Q?DvAlhASdRPQX99LCkBTWMUh47IfthI8pgJzu6/RizAoNNClAYR5eBio414Fh?=
 =?us-ascii?Q?NhojkypVRcOPMDLuKXVMKOgEw8swijCoBKfuUKEzM5Q6WXsM5c+xLa4P+wY9?=
 =?us-ascii?Q?QP0x0bfvm0/27jUca8tfLsrJE/Xo9TnF5Zlo3F0XgEMe6GNrzMKtW9h8Toej?=
 =?us-ascii?Q?Z7Zymz7s0FHKkmzuuGAxtvBmWdF99BbY5vDFninS75Kz/GwKorGHyNP/KuiS?=
 =?us-ascii?Q?fGbCz/Rav2xOQwa+czD0im/6kpYSATFvDhRnWPeY+SlBuXRW0C9wTJzPYLix?=
 =?us-ascii?Q?89kx5VBkS6K26QALsYeDWcHFLIQuTLfwdoxJDfdtkZ5/VJwXtq87n/pkwTcv?=
 =?us-ascii?Q?8vigj+RPjIxDHVjdax8Ptdgo/F3zaCYTPy7pAdvs5lNM4RTGMBOyONhZXvHd?=
 =?us-ascii?Q?HSRvO4AMDQ8KnfVq4jMiqfexVkcatwDlpp1JqAd5xRMHggRIT8CozUVPlAa3?=
 =?us-ascii?Q?v1ckInaQy2EY/LfiFdLa/iAd4KuAsn2gJllvdFLnP849fjWhfkyewuh0jYRJ?=
 =?us-ascii?Q?SugXGlxcmFB+1kknHunRWtkUj4JUUiZ9e1U+8Mz5ELi2GEwdeNBPf1Ns2uxC?=
 =?us-ascii?Q?zA5sC9PdWMLEpwPNz8NZlUFqte/EeKs5T11R6BnT+g2bhfAD4BTZsHqUZvWk?=
 =?us-ascii?Q?FJfcC6hP43dfNoC5HecYIxvOh+2O9WnDN4qYoch4UqKdiqzP2PyElJZTEjmc?=
 =?us-ascii?Q?9OOpRDDCeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56e11c0-c0c2-42c7-26db-08de65217307
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:47.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsNHqOzGZTgFy5dV/4rDEbIc6OIx/iLhG69zDM40ZeNFY/FsAiNiegp0gUAEJhJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16611-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87C83F90A6
X-Rspamd-Action: no action

Write down how all of this is supposed to work using the new helpers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 973d9ec6875e63..0603c19bbadc4a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1575,6 +1575,87 @@ struct ib_uobject {
 	const struct uverbs_api_object *uapi_object;
 };
 
+/**
+ * struct ib_udata - Driver request/response data from userspace
+ * @inbuf: Pointer to request data from userspace
+ * @outbuf: Pointer to response buffer in userspace
+ * @inlen: Length of request data
+ * @outlen: Length of response buffer
+ *
+ * struct ib_udata is used to hold the driver data request and response
+ * structures defined in the uapi. They follow these rules for forwards and
+ * backwards compatibility:
+ *
+ * 1) Userspace can provide a longer request so long as the trailing part the
+ *    kernel doesn't understand is all zeros.
+ *
+ *    This provides a degree of safety if userspace wrongly tries to use a new
+ *    feature the kernel does not understand with some non-zero value.
+ *
+ *    It allows a simpler rdma-core implementation because the library can
+ *    simply always use the latest structs for the request, even if they are
+ *    bigger. It simply has to avoid using the new members if they are not
+ *    supported/required.
+ *
+ * 2) Userspace can provide a shorter request; the kernel will zero-pad it out
+ *    to fill the storage. The newer kernel should understand that older
+ *    userspace will provide 0 to new fields. The kernel has three options to
+ *    enable new request fields:
+ *
+ *    - Input comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Check if the udata->inlen size covers the field
+ *
+ *    This also corrects any bugs related to not filling in request structures
+ *    as the new helper always fully writes to the struct.
+ *
+ * 3) Userspace can provide a shorter or longer response struct. If shorter,
+ *    the kernel reply is truncated. The kernel should be designed to not write
+ *    to new reply fields unless userspace has affirmatively requested them.
+ *
+ *    If the user buffer is longer, the kernel will zero-fill it.
+ *
+ *    Userspace has three options to enable new response fields:
+ *
+ *    - Output comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Infer the output must be valid because the request contents demand it
+ *      and old kernels will fail the request
+ *
+ * The following helper functions implement these semantics:
+ *
+ * ib_copy_validate_udata_in() - Checks the minimum length, and zero trailing::
+ *
+ *     struct driver_create_cq_req req;
+ *     int err;
+ *
+ *     err = ib_copy_validate_udata_in(udata, req, end_member);
+ *     if (err)
+ *         return err;
+ *
+ * The third argument specifies the last member of the struct in the first
+ * kernel version that introduced it, establishing the minimum required size.
+ *
+ * ib_copy_validate_udata_in_cm() - The above but also validate a
+ * comp_mask member only has supported bits set:
+ *
+ *     err = ib_copy_validate_udata_in_cm(udata, req, first_version_last_member,
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_A |
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_B);
+ *
+ * ib_respond_udata() - Implements the response rules::
+ *
+ *     struct driver_create_cq_resp resp = {};
+ *
+ *     resp.some_field = value;
+ *     return ib_respond_udata(udata, resp);
+ *
+ * ib_is_udata_in_empty() - Used instead of ib_copy_validate_udata_in() if the
+ * driver does not have a request structure:
+ *
+ *     if (!ib_is_udata_in_empty(udata))
+ *         return -EOPNOTSUPP;
+ */
 struct ib_udata {
 	const void __user *inbuf;
 	void __user *outbuf;
-- 
2.43.0


