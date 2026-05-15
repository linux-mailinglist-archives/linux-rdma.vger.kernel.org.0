Return-Path: <linux-rdma+bounces-20778-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KsNDlhZB2orzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20778-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:35:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C35555413
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B20A3024737
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFC4F7991;
	Fri, 15 May 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EmpEuRcj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9D3DC85B;
	Fri, 15 May 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866221; cv=fail; b=lsGhlkq9DAQK6akxLunW/AyxWCDs4v1DY1vYocZcH6f8QoPbv+l/i89yYLXK3/+4IwCxxOFchWo2KDscYliV10TCoc/US6A6uVbFo7y4L6r9R03JrTI9n/ED3ZFx1/9No43V/ESUyr9Tn7t6hF7Jhp5roUNjxuO8jwoPdXeNS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866221; c=relaxed/simple;
	bh=Mbhc5FqBMEz9A2ZtOS8W/XS0cdye92wc+QHmjzDxrxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXPzj6mdi2ESlksPjpiGvy8wWe56WKgyNlDOXSmZmQcEjnuOV1dJ842NKLScj2I8ZiMpMng0QDPoBLvawDDlWgMU15/IgihHWEa74NdMAM3Pm1IO2wJoWAA8fe9R4MGBUulQpP6URGPtnT1t972tH8qM+qnO6O4q/XwlbwGUlzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EmpEuRcj; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY954xC+GDVcfyT4q5XrZQvWzL9RoRrB6E91Hh07W1CnPcg0LGOTCKiQEC5q5eNLY53pevTTRgbm7WplUTs13W94f5jAWPRuEPbfYIVUdQX5KFTTO/PGY7RI7VD4+xp3zwFxPchAWOfRgDRgY49a7UK6wDBys0quddXx67As5RuOc9wmmLrqJsujDOodRzTuRIeAwnEnuqVh1MvCoaPaH8arRIGdjkJUfxDCM3RJgshngpcuK0QOY9a9fF8MqoOsKfo+mjSH8uhgCNM/kXmzD8C1gXhqDfeEDB1+NWQ7Ytu+6c31QKwwKz7GFAPSxaaEsz2TW60NNpaFVGgRLB6oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbuLwKdcj94ghRoxb8IF5qCmxobWHZ7gWtYvZqSrY8I=;
 b=KpM4X9IidsMTbORVMRv8jaGyOrpqml6KCxkEhdKdLrmBd9BBZN2VMQhtyuAg3AE1A9cadxh8cble6fS6J+P37mHKfE+/FPl/vQcdc3KGRVS8RByPcuj1fMgHBK0cRkT6yf6jJKtCuUKArL3vwgrOFDSRQ8oewBtVnZittyIfPUHFbI/VlyCnr5yrCWrvMsKi5XhYi9tllDK9IoB+MEMLXuyolWqV31/gZEtZ1gzoh5R/5cy4qiDTtNJDdNTWAC31xEjO0el4aGo3CPyIZp76DQRwiy9XduiTC6eNrd6+P7C5eH6jde2+KKzSBHaWDRRRD7/wNDKn4pmH/on4Zf49tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbuLwKdcj94ghRoxb8IF5qCmxobWHZ7gWtYvZqSrY8I=;
 b=EmpEuRcjs5/C4Eo3voq19XHmAreBSw+deCS4Zp5iIPeGj2e7766LSz8dZ7JrIMYFnCgV4irPobnaMwvCkHEe2WV5VUuA3QN9b6wxt7z/wjrS1L4ZbvELzQo8bun9b+roNo37/7fflQ8cWCCN9XdKDL2+JAYi/ukVDmwj08yHgGCKKrm/7atkowQs3ZmLlKtCT72S3qpaYfjofOsUM6M7KSkAQv/QRjyjt7hRkvkWsdHt6olOpK8RJY6V9CkMNklD6h/TrHpPu6JEYkkm8TONZsY5iuyiXeQrOiRGcu6CZzWpfdU73xsxAqfl1Lmot7pKixI6W9YD+fL/oMyvkUDeHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:30:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:14 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match kernel
Date: Fri, 15 May 2026 14:30:03 -0300
Message-ID: <6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f31767f-d4f0-4a9b-bdf5-08deb2a79e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Hxq3J4BDPf/XeoR5sKmh//6eNd5IQpkSXVHnVC0gyyhK7Q8pBge87hdwT2bpM9mY8gO8/qII8po19AxWzH6mamupfjcF83R5ZecAf3TsO/ilHcDw2OTPT9A4eGC0xwkppCBU94Ck1Atmwaj5mV43xLMsJBcK12JwKnm2TWBqg1AUh4Hea4Qg6uMNUQyESPExDcPXktTEwemOuHRQcPRPfDf9ZYulyCbUENDJq5oOQRl0fnSajZQrTIGUKHaKJHdiGRPycfmPij4y+i9Y45YcLqOjizc/qb4coETgvAmO7utnE01WB7bJfPcnXyrSiNsj9Reqhe1oA10T3vROEf2E6kdL9NHIoT2Uq3pcTN3nVNUZaz/VlX5wvPzCoYEFbjUU5ItIvOlt7ZrZPXTskMBmp9DsXuHJGFv/5XKYIzVgFE6yO8wXPOgwGHJOsIamfsRohi7h+XjFtmr0oIt3uDV0b9btL4+Chp0bdl1rVHjOJC2smdlOMiPWe2cfhkivIJ87w+BepENZkl2qkibTIm2bh137cIZsuKnIVLIdAi/3RS3VJWzio/uI7uUgN05C1zUqpwzDRxFjsj6ga+elPeRABXPo9sLNgoiJcpe1WHT4jCiFeoF6b1ojNtOBnOjWTw6tqgDzrtAojXV7FLNTIGKOxzYaVXmLNA+cerBr8DgWhS3boGcXzjOtDej6CvSoDPwXq349Cf9ZwWYxkLcKDAI+fQer4Q1XwjHjLg8Hglx1Vk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2owkW2EeWxuVN3U1S3FN6SSC8DBhzC4kmnM6xH7e95v/8kYDYcnCEKKKRUve?=
 =?us-ascii?Q?XK4efTnWzsSgbZ05EU+864g5lyUQRPdwrrrjF3K8SBQfgmlRk9AoQpLjOKFU?=
 =?us-ascii?Q?vKy3wsJPLkpnQ43oCMsdz52LZh4xlQ371K0MZH7uS6KRffKjX5BgWS4NFrju?=
 =?us-ascii?Q?lIwDnrvSCWHU7vApOA837h0Nww+jmdPcdaD/UQavDjc7tLjqJGsSWifMkkNG?=
 =?us-ascii?Q?zcLCz7L7jdvHOsbSDEeN1pHFcxXNHPgZMr7PonfH5Su1w3IXFfEb4J3t2m4h?=
 =?us-ascii?Q?oZlRnboVkQIinA7SKpjosc+HXW8lCteykydRItT+Sy1tzzGrKh4D1ngAFgw7?=
 =?us-ascii?Q?i2vUmK7xfiMkbFPqOaYEF25r7q44gutTUFW/mWIsfGbrV816ZauRjDtmP1Hd?=
 =?us-ascii?Q?tkWJixarAR3dFw+GvU+aY4uyw8VhnNtP0pEJOEuX4PNE+AAB1NVHkZqnJy+a?=
 =?us-ascii?Q?dH0omzjdaGueC756i4fnMJC+OFVVINgMCbx1oj/MjAezK2lscCo2NtYq5pG0?=
 =?us-ascii?Q?zEQBd/jbCbdMaFNwVe8iBwl23EaU+MibJRaWGVKeGKrByOA5cKz1EymnT0b3?=
 =?us-ascii?Q?kviYnw5S6fkhsvn/Qw/2VzF1mM6uz3pSDEKyDXxpf53ORnSquIpN9ywS7Y//?=
 =?us-ascii?Q?t/TCe+Y0eMGz4M3b7IMRpm/SLrhUwkOc/rXWrWx4qkGsG1WH6+fYD7RHrNvt?=
 =?us-ascii?Q?P3NlRyByij9w/tyCLTyat8GEsnhl95lx1GUujJODpFRXJoD2VXiLrqKhobEe?=
 =?us-ascii?Q?CWQvJdSOOSEZwn4wWub3OU4EQmboOuLL8EHgkeLSZ7KAnEjWqRRi+YR1txCj?=
 =?us-ascii?Q?4qBgIPnvh4WMTLF5Yz6YcjbrTYiCDmDNUdtTW7lDBecHM6Wxt5zkVwG2jVm8?=
 =?us-ascii?Q?iISOLNOvPYOOOFtpCeHWFyaT4aE8dAFsvJstwA83Kl4GWSSKl5CFtTAm7Wlz?=
 =?us-ascii?Q?rlKUTlDtGHe5LSUiGfZXlPD85Kt+xeyLT9+YCKSQCqybwHu7b6qas6085zeW?=
 =?us-ascii?Q?58awtEr372xkwHvf8g0yAQKPLw7Jz0AaHCtwtQVd08K2qMXx4b8h94TAV6bS?=
 =?us-ascii?Q?fQZuzuT3V9GKQpzOL5joVe+aO2iSphjLr6MwOevyUeF4ofnyI51DPlYu+IE9?=
 =?us-ascii?Q?MW3jSctQEJaJmi6FcglNE6QZ7mXrZ8hZMegZVGUrdZgroTqXpFhyhSt5IoW2?=
 =?us-ascii?Q?+CGePF3CA+4e5Dxg6WDqzILkzG36iBzB3z4B5TyZyb8DT9C2/HMRAgHMB+AS?=
 =?us-ascii?Q?ifb1zqFSVHFuIUm6z+IL18QKWWzW5uFlKjqghIoKd7To64R4Ga4pRFdn7J9y?=
 =?us-ascii?Q?Af2mb7nOY1Qjayg4F6YRM/i/A5Vsy91CQmR8B2rQ1+yklOEFmBQoXu1eASTZ?=
 =?us-ascii?Q?MldfTosSYE4qKHMxJIpemaW79kHh8YQ+dN1LFCCfYTlBC8r93E28ejTWG6ed?=
 =?us-ascii?Q?afeV1mXe52Ix/VD0l5Ec0PkaZGhj4rKwPHnXvsaWNZTh8sFku7/rsoe+aP6K?=
 =?us-ascii?Q?vOr+iOs4h/1j3LnGRR4OtSlB9nW8hR67D+wILrNRKIrOXRWUjKnBQUNdbUNS?=
 =?us-ascii?Q?O9tfDcrJsl5uCWoytUn0Owf9KdcncKXwu97/2vtpUnWxtDh0Xr79qZpllr7P?=
 =?us-ascii?Q?7TZhNAWFvRjZM02xCjQFbMf2ZDaNAKKOmvk4NAek5vHWhXnUw/gXAkUpVOO2?=
 =?us-ascii?Q?1BFuV9XUgUKBjFXywBTXfDRaUF0IvF/vr8J6FQlhAXMauq9g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f31767f-d4f0-4a9b-bdf5-08deb2a79e44
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:12.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xZf0ybQhBO20WPr+Ju20FSZgtoJW1abjCJf+hx64x1Zff0dM3LwmntJvQU66ezt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Rspamd-Queue-Id: 21C35555413
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20778-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

The tools/include readl/writel MMIO accessors on arm64 use
inner-shareable barriers (dmb ish) while the kernel uses
outer-shareable (dmb osh).  Fix them to match.

Add __io_bw() and __io_ar() definitions matching the kernel's
arch/arm64/include/asm/io.h, including the dummy control dependency
in __io_ar() that orders MMIO reads against all subsequent
instructions.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/arch/arm64/include/asm/barrier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
index abdc64fc3c70f0..3f7fcb2a27541e 100644
--- a/tools/arch/arm64/include/asm/barrier.h
+++ b/tools/arch/arm64/include/asm/barrier.h
@@ -28,6 +28,20 @@
 #define dma_rmb()	asm volatile("dmb oshld" ::: "memory")
 #define dma_wmb()	asm volatile("dmb oshst" ::: "memory")
 
+/* Match arch/arm64/include/asm/io.h: use osh barriers for device MMIO */
+#define __io_bw()	dma_wmb()
+#define __io_ar(v)							\
+({									\
+	unsigned long tmp;						\
+									\
+	dma_rmb();							\
+									\
+	asm volatile("eor	%0, %1, %1\n"				\
+		     "cbnz	%0, ."					\
+		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
+		     : "memory");					\
+})
+
 #define smp_store_release(p, v)						\
 do {									\
 	union { typeof(*p) __val; char __c[1]; } __u =			\
-- 
2.43.0


