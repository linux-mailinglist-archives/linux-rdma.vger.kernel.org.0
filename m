Return-Path: <linux-rdma+bounces-19043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNmwHCHg02lxngcAu9opvQ
	(envelope-from <linux-rdma+bounces-19043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 18:32:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D563A5551
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB5BB3028667
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB038B7D8;
	Mon,  6 Apr 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UV9HwU4Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F538B15D;
	Mon,  6 Apr 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493077; cv=fail; b=Qmtkb6R3ASLTNI37KMqNeTT6qwjjvnnw0ujjwE/0MTo/m0K14cNBTrHP6lYX1/gRPTV7ZjESanOrWh1JZTHsMFgt2x6hsM6JIGWiYtAdXlYZBCDrjMKWmvhK2tMS87LQB5ECI6naHpaqqlxwlGFupeudy3+uDTBlCmWoMM9SNtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493077; c=relaxed/simple;
	bh=atBguiDEKUomnGxYCdsJkRRZktKw+Y1iXzQjy+QoW88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XK9DsCs1JMKUePLhzB19va9URf6iVShx5eNpUSoi9SxBdW9tTkQW252wLjwSL+OeRuGAg3dND8ip3clN0E+akZViT5MWdSG5z+i8RNfiCoN0lYrRi1sbTxI30v50RvGMR9TamK234HFZUhZpTTqDQLbyVuHiRap1mOVCy0I54yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UV9HwU4Z; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbzozwT65kmaGgYCilZB1oQnVIQnG4R7fwWyO9fjh3iIsKkpfgDzTEau2IaAZllkycOS+3+Kho+d9i/AvQzp4ehfW7Y5pShEUknT9auCWTVH7uD9VBGAj9+7EaOoVatxZbkAyPhw6bo5tv3nQMH6d8VjTAGS0Yz/t7QYnatw5l+lFwb8stc+/5aFsHD7sD7GQ/pXR0kppWR1Ouy8j+7d0vdrPijXZZBLAeohzymp8byf6HjQaV4IiP+bvVEuH9aZXa/2DTOk1lfqN+LakDWsXY0y0pKVyYgbw99F/LBINwEKhrL7jNMdVofIjWIHQSACrG2eYgXbeTpEdNu7pMKmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDQdFr5VgtjNsMdsuW51nME+G+9AvU+ZpCdf30e/1tk=;
 b=Uw1rY/SjqcxcmmmG6mEU/K9aR9sK2EqyGkdn2uUxXHsZUuZP8AFAfV0rmXyym//ATfh4HdqQqerlfiuozHsdIhuGtLITF0VUESwqO8vaDKSHy7rhQedMspDkTasry0USC3DBessMjNPQ4VDX1YQ6QYQ0wRG8097ljHu9UuFRGdP/+M0+xsW9eIuku3WSp2TP7Cjn+NYe7g+V8vR6MiVQWdE5vdN/yfmuhW+FldDuZmYhgDRe4WkJMvTwcEG+2hITM0eTx1+g9+CTtZFXjA5jsupC5bwKiYQ0Tiz415wlT+KUIlaT9aDh04d9Awm4moCZCmISqSQSr8hvOTzYiruQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDQdFr5VgtjNsMdsuW51nME+G+9AvU+ZpCdf30e/1tk=;
 b=UV9HwU4Z20UgHn0knZFiKfMW0cS4R3KFuH8+PHi8h74A4HWxnTmK355QLy/Wy9BaTmIHP/4k85cxYk/Hj0QwirlOSH2Gd+gsN/TITT1JCC6cQUrocTsrl2gWT+O0h+VKWyG5s50Gsd0BbBiu1q+nnqY0vfSe9QLriNU+UQwB41bwNoi/ixNwzobBAXZ+HqIg48Rjx/XTFNMuLmvB4+gjsL4eTrdXzQAd6EeNVkcZsO+cDGULNUXTpdC/OvrzsjS9a5ZoMHYtks2p4UeWvq7+n9MeDEy0sgZvod0eMzSx5iXK/D1thxBUh1B3OmRhNrifksRjtkNirDT1ItUJIAXE0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 16:31:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 16:31:09 +0000
Message-ID: <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
Date: Mon, 6 Apr 2026 19:31:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page
 per rq
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Lama Kayal <lkayal@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Carolina Jubran <cjubran@nvidia.com>, Nathan Chancellor <nathan@kernel.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-5-tariqt@nvidia.com> <adH5yAsPJ8rNgT0k@x13>
 <20260406084344.5d315f01@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260406084344.5d315f01@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea3c531-b6de-4f21-e633-08de93f9e8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZvVrTX+sXMB/WCqjVvrK3s2k1OoH0FO2h6WPRmmrJLFlADNdAqIqiTpBIQYOcyISm8vZiOYHuBJOEtngRkVDenVm4kdWJnpLVQ6xT5C5q7fMsilRx5SVBoKuxMncLizOAYPIEAHNR3icb8Z2FbYudF770bZssI7ke0n1AR25UhiT9/vp4YXFbb81vahwVgvuAk2P8hXrOeLWQLNs4uFtnCEdiB7OOR+vVikTkNCE0GYo3bM369AuuJ+I2NWg/G9/rsHNdYHTol9n8q+aHjrTRykVXYHOR2QKLn36cUhCol8A/BdQzXABBlBn1YOcQosrUZ8IqkszTUb/8h/i3d87AvASVYiFZIGF+UnSg7pvB+17rSkGQk02Jz3rTGnn+eoMdClHQzaUH12D/xh7qiyIXdkoIIG0z4z2MOfr5aAdKtpvdsgNHXmRZWiLlNvI41zjpKdGqQBXTQvFPxL3M6KKyYh1cnkVoFB77FlPv6DTNzIUPVR4LdQGvTz5Kwr1dFfRcaC/jfNuxNPAS4o2YEYI0vDgltc32MJePBRt2HVERhkHCLRQDa92MM5poD1cpp8AVBAOKa/O5yQlX4BmFRwkKajrO5TG04YrLebCQKAZxUt0j5nUIetbn2wXyRr2PVWOcAnsvwvTSn81Z9SvUhrZck/pdV33S7cPOVh6DDAAMqsVhaQi9yGZjr8ppqX2C5uuKtRHNyVZu7A247q85bRc5+KB+HJFPAMXE9vEeqyyuow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy9CNnIvcDhpVW55M3lKYU1WMG13OVZjT1NRN2t0di9RMkpOcDh4Z2VaNTdP?=
 =?utf-8?B?OXFUdjJzeDUvWFlKVWxOT1FCYUZmdW52STJ3b0h3allxV3MrNjU5M0taWWxF?=
 =?utf-8?B?YkhVVDRTSUIrUEp6dHRXZENNK2dsRVNZcDAvOGxrelZUeGRrSlZ4MitiSE5N?=
 =?utf-8?B?U2ZnV1c5ZXFHRGluMnlicGVJdXBVUnBEWFYveHFLUnNIQWFKZVhUOFVPb1Az?=
 =?utf-8?B?TittT1ZxRFBGcW5XbktJYzl6MnNsd1d4T2NFMkdBWFlLQ0FZNld4NnU5MzNs?=
 =?utf-8?B?NVdOZlFlaDZjL0FuNTYxNnBLendJS0xKZTF0UTBLcUcyeEpIOEdFVXFpUTdQ?=
 =?utf-8?B?T1JqZ1dFQXdrRFpocFUwaFNmNmc2VENxQ1J5R2lqK1l4ZUJoeXVjSEF4ejRn?=
 =?utf-8?B?SVNyZk1SNnZGSlJOOGlrV2xWLzlLL1ZVZmUyY29qT01wYkFIeW9jeVBYY0xn?=
 =?utf-8?B?enFQOUNCdExYaHJab3BzYzF0Y3diT05wK0QxNGR3VW5qKy84OVg4bldvUEcw?=
 =?utf-8?B?RkxnWTUzcDYwOXFrZzIrNzZqeGRoT3d6R1QwVFkrTzBYbk0wRFZoUUp6OWhS?=
 =?utf-8?B?T3pWMXJ1RUhxaXhhckhaZ2p4S1luMmc1blZ2SndTcXU2cExSakRtNUhIamVu?=
 =?utf-8?B?STJTUzVORi9qRTc2TTJZRDhIV3NBQVlyb3Uzano0cndHWEc2a2E1ZmdsSEs5?=
 =?utf-8?B?SllnQnA5VW1kN3g4aW82RHlxU21pcTJhci9RaTdGbVVJUW1QRlBxVWNTN1hm?=
 =?utf-8?B?TXBCaEQ3ZTZQZnM1NlFidVN0TWdYVE1EdXJOVEVaRjFyb1ZhSXMyVE8rQmg2?=
 =?utf-8?B?M2dyT2doWml6eHJLeWgzSytCbFZBd2N4YU1qM3lTUU9HY0lJYkMwbGlHbnN5?=
 =?utf-8?B?ek9nL0cwSWdsMUszZWZiNGRJMllJOWliM05EMThDQ2lIdnZkaGFNWjZZQU5E?=
 =?utf-8?B?aXBHNU9aYzdmOTRLSmRUcjZrOWdMYXYzR3F6dGY4V3dTdHVuOHd0NUtXTWZB?=
 =?utf-8?B?ejBIR2RnN2NRNnZlbU1FRVljNEFjbW0yaGZRZUhONlFzY3EzYmFldDFBM1dY?=
 =?utf-8?B?N3grQzFCL1pQc1doekRXUHMwK2o1bWR6cHFwTFZYRG1iZDViTjMxZnJDbEl6?=
 =?utf-8?B?cG95Qk1HRGQyd1RvN3kwT09IZFY5QnVrekR3U3JMaWF0cytFL3NYaEFEMkd3?=
 =?utf-8?B?K1pCcHZLZEZpekdUajdKbkxUcUpCT1o3Y2Z4WXNXTy94ejk2aTFQKzBvanVw?=
 =?utf-8?B?Q21wcmYwL3VjbGU2bDkxb0tjQ3R0UHlvbG9QZ0E2ZXc5MTRKUU5FWHplNC9l?=
 =?utf-8?B?NmtvdEdsM0N6a3llcWxJRnZCOTcrbVJGMlRFZStlaHNmQmFPSy9zODRVSzZ5?=
 =?utf-8?B?d0pWUkcwdXhQODYvdTcwRCszUDkvOUZiZmZycjl3YkFncnBaMGdRMXhBRWE1?=
 =?utf-8?B?RUZsN25wZys3R0t2SG9NMTJvRlJ6Z2hwSXFnRjhlN0JkWUQxYkZ2WGJ5UWh6?=
 =?utf-8?B?NmdmSDFEQlYxY1IrY3NRdDg5RklUeFZ4TTI0SzlqTU5pRTBhV0dYb3lJZEta?=
 =?utf-8?B?N0p2elVjWFRncXNTTVlKdUxXOVh5eEl5VytJRkVyVnFSdU1ZZEVMYll5elBC?=
 =?utf-8?B?WWxYNkZrbCtTQXMxemhkZ01kL3JtRk1qNFE3R2RaOWRTWWdFSlZ4SjBvWCto?=
 =?utf-8?B?RnNwcjU3ZTNER0syZXArMzBrY0JDWnhPU1IwcU9JNXVueFM3Q3BGdktnaFRM?=
 =?utf-8?B?MmI3aFVqdmU5Q0hyT3pML1MzY3NrMEMrTmtkbVJqRjMwVS9xVUxSZFR6b0k3?=
 =?utf-8?B?VU5hc1F0ZDVwK3preHNJaytrV1ZOZW5WODNXK1FkRlFqQ2tRTjZVakNBOUEw?=
 =?utf-8?B?d3R0M0RxSytBbHgrM1poN3JGMUI3bHgrR1BwcHByTk41ZnAvWnRNWnlFemsy?=
 =?utf-8?B?VFBITCthT3M0UUFWSG92TjJtWXJqbGJwY2tDUnhxLzU3b1BBSmRBL2wydE15?=
 =?utf-8?B?bndhYW1hQ3BHK3BPMkpIdlNRbFJPTHFyODJqOGdKVUcwME1Kenl6dk4xY0th?=
 =?utf-8?B?eittTzB4TWZSYVZnS2IvTm9YUlAvNUMyMzc1NjBHN1lnb0hhN0pSWkdyNS9v?=
 =?utf-8?B?Zjh3VVlHakZJVU9NSU1qVmFGdDBzb1FCR2pXUThoNGx0VDl5bHpCSTg4VEls?=
 =?utf-8?B?aS9XakdQSFBGMTZZRmVjMGdIakZSeWJVRjR1cXVsUEZQZkJKVHgraWs5Wmhk?=
 =?utf-8?B?dzBmZXNsVjRFbW1NNFE0TVdwOWQxbnZMTi80SDVYcEFWZk9kQUdXN2JJUEtB?=
 =?utf-8?B?OVc3dytES2dVYUM2YS9VK1M2dEw1SmVkUjJrRG9UN1RIR0w1MGI4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3c531-b6de-4f21-e633-08de93f9e8d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:31:09.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NljCwySNUjV2raBCT7fLSnZCt10umaa+OTVE0bQaPN9619Df+GqkDYqscSQvrjVIy0WUPYCnxaRDMwV+ATidyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19043-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: E1D563A5551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 06/04/2026 18:43, Jakub Kicinski wrote:
> On Sun, 5 Apr 2026 08:08:06 +0200 Dragos Tatulea wrote:
>> sashiko says:
> 
> Thanks a lot for reviewing the review! It takes a lot of maintainer time

Just to add some context: we started running Sashiko internally,
so hopefully trivial issues won’t be missed. I don’t know if
you remember our on-list discussion from a few weeks ago, following that
discussion right now we have three different internal AI tools reviewing each
commit.

At the moment this is still manageable, and I think developers should
look over all comments from all tools. In our case that currently
means three review outputs per commit. It would also be useful to have
some official guidance on what authors are recommended to run before
posting, so obvious issues can be caught earlier and less reviewer/maintainer
time is spent on them.

For example:

“Before posting, authors could run a recommended baseline of review tools,
where available, to catch obvious issues early. During review, tools such
as review-prompts and Sashiko may be used to assist the reviewer.”

Mark


