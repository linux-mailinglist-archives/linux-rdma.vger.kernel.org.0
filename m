Return-Path: <linux-rdma+bounces-21517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NqFH1iaGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:53:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5A60322C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF629304B99C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D161B347FCD;
	Fri, 29 May 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfgTlf9W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE42367DF;
	Fri, 29 May 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062594; cv=fail; b=AU7hXTWIw51o/klHrFBUMFrcPOCc3ZbAHWZhoOoC+ZD1mBK3DJQ8yB/h26hncJSH/D9rLx2Y2SUyhGhecEGm36LzN/RS6tNEKtXe6uY/GcSNz/fwuM7e3jqsw8jbFuEvdQbARW723gp7V70iLn+TGymBgcXtzYZ4C6fdytlbWQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062594; c=relaxed/simple;
	bh=hn/B1tAGCd+SdzSbVTlsOekCIk4G5eGP+f9jjRiUqO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjxIrhzxOUuLQBaBnZmuRYMSZO2I7KqtJnF6eKAv2njCtqxspbvHlMm2gZ1ekaNxBuNMgoFiiaMLAS25PJ9PzpnzT8JHurVQut3Je/bktTljqBBDT8fLBeRSiPSUDF+8ierOQOFSaPy8HIIXrEHpOJnNpP2i98ZdZkhYn73G7Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfgTlf9W; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtMqvot8WK4+1w2VfEloLNmxu5OOetedt3LyOKZw/18fVeeJco+lU3qRTVU6eq9CG+J+2bZap+m/piti2yKwi1F9AacDnKaRwRkP98wnMZr5xfVMCoALBeUAaFttDyAv2KFuMTFigkAGuu5M/6BPK5oAsNyJaNLdgMS1jP85iyfG56iAb+8Q7E71YUpOxfTuebfgWhW74dbivfUsbnE47dq/85K2aVc8IudV/kdHsU1Jhoiqg1MdHIrE9XNTUExNNMNdF/rs9ooaWGCQ2Dy37o+nuv6FAXBGZNymEHjClkgHXrA3DLzPs1HsOouubFt7jpBd0o6YsZNzI9qz67HW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTbAhRe0T4vQ762jbL+UBp2+ZigdkdOiTNIYp9ESb9M=;
 b=Lxg0asnhXx1NAJbzLxxlRI+dxV0yDWRNxhUQ4rtxqmp3b1vVbfOKcCi9Wq1q8+VUhvTvXys8uU/rOJDEM0KwWiEVYdHAcLO/gEus9s7+V7RmhmdAnItQBz202ziENZC7Z/sd4Rant6WuLNlwGlmEQjxjK4dId7Dxs2+0LwPjcDYhnh18BDFOrZ8pxiR1nw9oSCo3zD1N3fiN1U9Y/t7vZmronW2IzvvUTmLhGdDV2SMRX/Lufo+BROot35SsbTq+enG8aRZidLUXZYnNlGD9NC7g6wfB0bq8TA4Ps0R+QB8yqg/9CkinsqaJbbYN1sbqAXHqLultuV+ebiDuX9xwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTbAhRe0T4vQ762jbL+UBp2+ZigdkdOiTNIYp9ESb9M=;
 b=UfgTlf9Ws6CimrnOLgV2PnUDffTHEyqs7239e+YF+fC+W1YV3p2RzBofCzAXrpJJI3V+GFH6H4UCPTnRzC5TaKL9Z7R0wXGmtYCxmsLSt5A3A9KCsVDdV43JoK/2/7ZuQJXNZ67PObMcKUvjavYO5AX2HpqiN1m89awCMmKkGwNpu5WAzMWhAmIwfrj16/DUgeeMQ7tVCEl7ueTPUI0je1XxXSuva2XAC77oFPGYBj6exOR8sFPmthNX8OBKZIqsgqvyzsvMtdF6eBHrh9Jr+gp4rQUbpN2EY5SqGCJGWGzT3YYR8CXfcArkbsTsDD8YbP7p5dfq3tCxa167DTug4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 13:49:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 13:49:48 +0000
Date: Fri, 29 May 2026 10:49:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Message-ID: <20260529134947.GA128816@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <ahiFxtmspbETiqWw@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiFxtmspbETiqWw@google.com>
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 781a69c2-c2b7-40cb-176e-08debd892610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|3023799007|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hC/zActOEHxDuY5oj95u6P4WgEusQRmbo+0oaRuFTWOzpy8lTVKHSlmlCc/FrFK4aGHyxhDGSrXak5PZS0m8egIBt5rYqUAF3u8PpWCt0V+l++30eyYdfDvM/QUxNUqegRnCkWb+GfrCBedWODuL7KFQgOREjKhU4RE9vNlCsn9GkFMiAFcpvW/PB7ow3+mTEI9IVmyggkAA6eFU0O+WmGKNetnz5sf1N7hNHARGKob4e3RondhS9oyYa2z8hKdd4zEy1/bqGWNCuMGA983BCGhJ50fnlRKYYOxeaoEPWj8hmNSyFArr3ppzNPCHhg/4E9eJNgl7249EMXt5YHKQLcXqPGI4Rt1QmKfAQOjOD3cX4XOMQ5UWXGu94SAt1UTASadXXh9rMTbIP/s7wSezHaGogu86rxM2SoT7dVdSDo057COY6P1sTlETUtyDV+2K73eBZ+a+4hLA7I/4XtUiwlhDoTpVIRnSRCaGfZHh7E00OPMEF8XqS2BAgkAZeNgmoqlaN3xfKKJ0zwfXqpKTb4uTzaF0B12QF3Qj8AMJQLDsmOO1NUMzwGDBYnuvsEEmbjN7kJDHzxzFcAxcIi4tKTx1qMcmYZVxAI7CalxCDjdMraVH7WZaOYrzMjmrawpFfZ9/33fBhZc5H/ULayi8mh/ldlYwOhqkT242UNoVkGD6xmrr+LX2V1Daribhe8qT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(3023799007)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DuIldhi9ne+1A5TfjU+9VsFAB3MgoFSFWggtnJtvxIJV6fHTEWt6WlGBCyp5?=
 =?us-ascii?Q?EYeuQsC23H7qF9E2dmtPSr/asGURjkpQ67mdYFyWRGR2/78WRaRL/OtIvyIy?=
 =?us-ascii?Q?wVSIRq4yE92tCRq+Gcv3XHfgWIp1mT5D5iwRd7mb34DhCuEbZZ/Bel8xXdTc?=
 =?us-ascii?Q?LFj2cqU8+p47xKXak8VReKNX/xDGXeZkzRYQAgGGdqpeiweQVjiTN0ryE/1x?=
 =?us-ascii?Q?l0kCA0RbrGjYFfBdZTi4hl3EhA5KqNgszCIjaAxItLP4o/Kkp/lMXpLsamNG?=
 =?us-ascii?Q?DB13YuJbP1UWF4U8redrxUokj3LVyZdKZq2shRyTg9JBTIaw+dr/D6mq+eJ8?=
 =?us-ascii?Q?Hp98ObU1b7zzG3c3x8qcvZ0J3nO1RwuvTTZ2MR7T4E7KIqY8bEa52wa9FiTP?=
 =?us-ascii?Q?X16e9fDTpPs/V7nXmq1StpCz135bnOFcwEqLJ08GkUwvVsrjvY88aN246ygI?=
 =?us-ascii?Q?jPeMnHpMXFicNr1ixf5t7ytmSoYf1YWbi/MabPG/jmclv0BiikiKostpqSu7?=
 =?us-ascii?Q?jJn4bMqOq3DyO6SE9nifO7o3RVMZOypzQmGWT5BR/Q3+asFiB425N6Fqw5P2?=
 =?us-ascii?Q?Faktn2Q/ntzpGouSTCu/DlxMZ4pqV7dTM0vm8NXDpk3ntWoaRL0CiOe/ZtxB?=
 =?us-ascii?Q?8+JwQqkMgZHYrNtIVlEkyZd750ZfuWE/15Zx/+v7PEc6mdKJ8j885O4jvmks?=
 =?us-ascii?Q?N5cxLT09ReeU7amKiEOkj1hrSKsrFh0utOvth3o1ds5lijlpx5KCTU6FIhjs?=
 =?us-ascii?Q?K3kM/sfA2klr+JfeS62w7OypDTZcmtOILsBf00DwrQCxsW6hCQs9A+czxbd2?=
 =?us-ascii?Q?IpMu0AXQ9iFWvd+Z1m+TmslEZGCTdFBCi6QVYelxVj6lHzo92RFT4Sd0bBT3?=
 =?us-ascii?Q?R2kdAnfCE3wgnmk49BgHXdwihNLUWCplzl2gN4yfJRHWhlmqhIIqxiPRzwvz?=
 =?us-ascii?Q?7UvO8HNG7BMBBP+P+SwMbpugMYgAfMkt/TffOdL/xzwnVKPlbqx5YWr01j4d?=
 =?us-ascii?Q?cRcCxnGJfxEu542kD5o6QScRLFUeO71tlqmPUEjvzLaEUzp0cXqkjaMACJnI?=
 =?us-ascii?Q?TAjeKlCCUzI2+KIcw/YVkGEKTsiq8TdYeFCdCsX1Sv3gruqjj/IspggB8Hb6?=
 =?us-ascii?Q?7P9z3csiPicYvMM8Cn/HX3kcNPZB4xPR0fwRJL9BX03LRyP1sWUU4BTd6JbZ?=
 =?us-ascii?Q?cmHpToeEv9RN8rijXM0PbnLTEAK5tqQMyYNrrtzkgmzVGpFmfI3EBgy7+fZw?=
 =?us-ascii?Q?V9DaiIP7TII/ruxcCnL6rhDACsM1e0pExVx4nBgpCNFPGuzz9qTP15OT51s5?=
 =?us-ascii?Q?Q94qHUaJHqf1Ip0/sXhU4WWHbxMKkzVeYI2+ze8hhVEtx+LqJpLDBPsSw7Y6?=
 =?us-ascii?Q?p/5+RQ9HnZgEVIh09z17mHHWi76MtaGhWkr89gDYy6Ldk4BAC3e3xo/TR9o2?=
 =?us-ascii?Q?NtW7wjm1YIYX9BPKg4nXj57h46rPX7ropHQv0PWjVxfCZZXCtLuazmOvsxKH?=
 =?us-ascii?Q?Chi6ysrXoTfCfiE1GUGqCoG+vHEVrYb59ae2EOvUuy4k1M2ybeNvvoklofv/?=
 =?us-ascii?Q?6YqYEjdfue/UTL8dbhCzk8zuWmt7RtSRe83hlhqLg0kXKWaTLOY6sN+2oriA?=
 =?us-ascii?Q?k62p1TCoXAWHh4UD0rUEVlBYveW3blX6PuDGAAO84zt6wg1ez6wyCIh/5iKT?=
 =?us-ascii?Q?HXyIikKV/gkBCKhEZmBDnbHdgEyfrtlNIyjmM/i9jjjiYHuJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781a69c2-c2b7-40cb-176e-08debd892610
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:49:48.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/FQh5mH5fDuf2SlXSDk8LqE37Jr4uKp+VQYXa+QubeXjPRb9NGffsk6C6CfyX/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21517-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: D9F5A60322C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:

> Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> headers are more aligned with the kernel headers, and so that the arm64
> io.h overrides are done in the same way as the x86 overrides in
> tools/arch/x86/include/asm/io.h.
> 
> Something like this (untested):

Okay, the disassembly says it works:

    1db8:       ca080108        eor     x8, x8, x8
    1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
    1dc0:       f9000fe8        str     x8, [sp, #24]

Jason

