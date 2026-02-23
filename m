Return-Path: <linux-rdma+bounces-17079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFwkJQe+nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614C17D395
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82CD9309386A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240337FF4A;
	Mon, 23 Feb 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sc+DcLyD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3D37AA68;
	Mon, 23 Feb 2026 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879481; cv=fail; b=hMoxOm3Xhm3EwTgyDBM6NleSyQS+YpjkKht11f3dD5a+MjXbjIb15FU9KeU1eyHN9gjsPaPlMgmTIFYu5lsqATWz75CMH00rLpoB/9Y4Jyhzk3xocvfBbEsxRtCPApJLEhmANqbdvdrQRvwLMWaKIKNe09vsxsZHGlS/Bkhogco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879481; c=relaxed/simple;
	bh=6BeT7vKSG0JdQiRT6iXJoEJGt4C1QxFjsvTbBzRZCvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3bbHqoBsv0uv6R+Krsxd7OaWXpkOSpjZOvPq7C855OcZW1WinK1ihZSq8bOy01NpBMRelfqGWDMDRdizXAXRLyd6ZpmxZSti9Wstn2iyU71ocd0oAQbYhptIWG6lv5y3kF0Zz6IBdv3m36zgFMn5+s+Ypy8GGSWvWYnVFH+Eoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sc+DcLyD; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbeNRPAP+3DPo/0e7UHL7eo6iO5lya+nK0CeMx1KsuUlYccWP3lDgresipuh1za/m0enCPh7HcnN+D4w8BunsXvshKsBzP6nep3pI4pPwLJ0+pwbwQPproOFkLSC/U7ZkMRsZ3TVgYBOcFmdW4i3vk15NL11z9yJ/PDUG32HmcCkK3pPMB/6lgjGQ5lv7XMeIPi2zoV6LHTEQJxGPI8dLQ/ftvR9tidRkvz2jmjHtDnWR8ndI/1V9V0lxmlZT+9OLMbNRlZZJS2Jrrmhj03LUk3FqB1BzKjez1MiXXTkAEFHg7JcelcRSoGm3ufnrQl+2a+dBq4B4tD9ddr11kWN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU6SazWCge9XI+Wg7OzrJFNJe3b74RmkA/81fxRHiQU=;
 b=am7XVZjVrTEazDlpetzKFUFEQHWZGT5IRt4sjL114nENk1yAAs3+k2nPmxiU0BKRAfC4y1tw4E1IrRX7T5ezGg3Wtdpe2OIO3x/50sOs0hA7/FJL7cPlgVi7d4ptzxo6puLWu9Wqz727Y/3An7bVByRxEr8iYhspJlyJDN+hm2P7P612bMbfKTi8oPuN0nVpWRXPydKiZedrmLkmH1eWyA9wq30jOlMJqN0pR7ZCLoFdYv0lncwHdJK8E5IZ8LHPHx9A8IM7AmQoiC7hrWZSAc6jd2413OL3FX9NBctjRuCt9/3/YSva21LlIBJCDuj7xhWD/yN5fLPl9xyrv//Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU6SazWCge9XI+Wg7OzrJFNJe3b74RmkA/81fxRHiQU=;
 b=Sc+DcLyDSN/C6WrGP2M3huimdueSHWr5bZo8rCweKKGiU0syYIKXF5TJIrksKDPMrDK5cnE1l/he/PoSKrtCwC44w9Edkxst5j2+YwWIdOWl9z3V3H5No1Q8PIdjFAz2piqwA7TmxHNgQzd1TBHMM93GR+K4jJDS/u+cedZ2tE2WPrAkGQ9+UsPJNc2X/CHfmLy5zchtmPbkbWTg5CbOvA+TYhiuK+in5zKYc0IQp7L/EoV/YbjdjhN3+qTDEDdpgU9tJSe6ywmDGl6bfY85G6kaO7VtxL8/2rGw8oUqCWw6g26BmB5HPkMCCxF0M//xdU5DLuTuSiHO7JFIExp0Ug==
Received: from BLAPR03CA0139.namprd03.prod.outlook.com (2603:10b6:208:32e::24)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Mon, 23 Feb
 2026 20:44:31 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::9f) by BLAPR03CA0139.outlook.office365.com
 (2603:10b6:208:32e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:44:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:44:09 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 15/15] net/mlx5e: SHAMPO, Allow high order pages in zerocopy mode
Date: Mon, 23 Feb 2026 22:41:55 +0200
Message-ID: <20260223204155.1783580-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1deeb7-6a7d-41f0-4bd4-08de731c5883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEOM0XJC1xKJZUMn4uMqUxMQ81LVZnaunGA/3CymgPXfFxkei7GpeW7709mS?=
 =?us-ascii?Q?iUlww5pwoaHKgNZLyIwSVQXvmJupx1kZ2vEqA1SaejEe8srXyxPwfOewJPyn?=
 =?us-ascii?Q?LKX/RaYYHzKwn65Sy1RUZm6Pmg6FmOeXCBS7cwwXGHusroeG666577xae32Y?=
 =?us-ascii?Q?gRGLcWaLYrCzsphpn84q8gk1n84r49D26B8fsRj83kuR6gI8a28sPAJvZG0i?=
 =?us-ascii?Q?xmd3jQvu6zSuev8QhDL8s6SbUAcCVlj1njqa3/Q8CNUfpLnwlIYpd+jQgreK?=
 =?us-ascii?Q?1snOCiUt81H61SnoZTH2Ps2HotnCCM8CfxHbcW6TNhvEkvArYAO1POWDfgky?=
 =?us-ascii?Q?fjll+3MLfiYvSWmQhxMOg0I0WDkH3frzz1aUkZZBALsQQouya8mEvVhq/BSx?=
 =?us-ascii?Q?Ykgf/qHotpU6R1WgY6k7z0hXT7J50yodirpLwD1gWU/YqfHdPAvPeCKiPX5b?=
 =?us-ascii?Q?XmK2hGKVZtlNm9Cmfnz/blDf5/NLECNk+ibQmqhPZiQ6q3+RYERknS0PKnHJ?=
 =?us-ascii?Q?IP4cOX7GFhtriR1Bsd8NYnoTGR45ynay6ZoicC6w/MCCly8HVxsIl+rWcHCn?=
 =?us-ascii?Q?nJcrPIn1cS4Ie7+XD+2CRyAQ6qQjMvCLMBn6X42A402f/y334uXf5dvdHrfW?=
 =?us-ascii?Q?uN3DUCUhTbatftE4OSc0UYVx0zRF6LNSp+u6kU2RHMdwmXhnqRLHHmbmt7jP?=
 =?us-ascii?Q?uPH4z+Y4B+jkUMA4QXtEwRdWCi4Y/1cYPK7PmtKE5NF0iVklZPg67PoyOQPu?=
 =?us-ascii?Q?2l7BR8f0oL/Qkh6IZpgUg2TsjzZ9GLwdCg5WflYDhaP16PXr+c+/NpwsAnmT?=
 =?us-ascii?Q?x4T2RMXw874NI7DFnZf1GXTDDCBnH3L7x+Jzs+XvDCdlj+Bs6seEQ6+jSwfW?=
 =?us-ascii?Q?7YTdXsrhnPVuk980KwnVPlcvoqtS8X58wvWbdlIkl+CQvfcr0MJMAeQkcgDC?=
 =?us-ascii?Q?NbZ1diddZeikZ4hzzzRCZ4hV0FIy3XeWhdL71HoSgiBqykgQ06nfGVDGcQlh?=
 =?us-ascii?Q?zexpM8ioOUfkIYB14MHHiuAdY9ST5cQ891ivV/YHDzTG0TI6+s46IEu6nLPU?=
 =?us-ascii?Q?u70Jf6EHFmHL7/NUwbUaFleN6Rcn9n4yspTU+aIhZhLLi0OzqiSaRc1GxDgm?=
 =?us-ascii?Q?ORBnpddjjLORT4LKIdlMl+8pbCECYPDrU4h+dyXsuYmb/XVr34jvLDrHCg6m?=
 =?us-ascii?Q?MLNdR/+czJRKVSiht+i/QS+z2Ih4cG1qeQk2C9j/UUdqlDBgCDKbPmh55/lO?=
 =?us-ascii?Q?uwds27lArmt2owLdLzxVG7Z3rKupbjWuftLHFGA3D06XBa7BURO0DNmvoSqy?=
 =?us-ascii?Q?IRgyy8wg34FuORTDztkW5FT1F1IoPtr6imnBZq6NmlsZIqtxOUIg6u8JhMVj?=
 =?us-ascii?Q?zzp8nSHApMMRDoAIuuW5WhjD1IVGipB9JUVzBRNKTJnm/FEwvz7CyFV/eV8h?=
 =?us-ascii?Q?U47R1hLh7OlHiI8gQ/r7Ebxmh6ybmwnMbwx+lRWDBO2By5oWgraCqWrsPHjI?=
 =?us-ascii?Q?BmtcwvJN2qb1y8IOj/QADKEUL7iuBcpAlKfqFa20CSLvGOdtpIFHCMdGBSgI?=
 =?us-ascii?Q?KU030/c2QqShal4+o1K/eMVPOVnSwUkOIOTKyJJTGZRUtBxJJYkDx2+vA3mT?=
 =?us-ascii?Q?apC/Xfo42pjiscUKBUxmp5EaCpcEZ3Esaleo9DnMK7H65zIyY7JH+pDRJY+3?=
 =?us-ascii?Q?X/aSFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DfThcPOQmAIc8+fPXaeoAOinEAtmWFu5siDTHgYgTpUQ2tCxUUI4uHqAieMyldM4LdNe2E6ZvrYb9HFOQDkkRwQVimS5bP3w3dO7rOLyDauUdC1vN6Sb70jgV1DiME/aUPC31tCnXOSpRKz49nhxFq0TNNrTP1+DVXtbtH+/xF4gT5kII5DIHSb0ijMFsWkUa9ey0rGHFrEBg14kvZOiOdjf/lTVguV4iD45bFx/HiLoJkFTPk4EzsjXLNoVTn8AB/QVIKNtRDBs+ObnQ392iKCDDeakMXaYxjq5RG8EF1MiSuyLba9IHSRt0ojU++2UqSzO/599ak2OR+27tKHQSokGcZjkKZqAHhW6cNZtjCGNkQNp59VeTvirJt5Pu3BuL3iJapiXNby/Jl7t5w6YD9U8U+kX2EDRFCnGPW09ieBsnc8It74PFlhtYpKpnJMN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:44:31.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1deeb7-6a7d-41f0-4bd4-08de731c5883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17079-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5614C17D395
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Allow high order pages only when SHAMPO mode is enabled (hw-gro) and the
queue is used for zerocopy (has memory provider ops set). The limit is
128K and it was chosen for the following reasons:
- 256K size requires a special case during MTT calculation to split the
  page in two. That's because two MTTs are needed to form an octword.
- Higher sizes require increasing WQE size and/or reducing the number
  of WQEs.
- Having the RQ lined with too few large pages can lead to refill
  issues.

Results show an increase in BW and a decrease in CPU usage.
The benchmark was done with the zcrx samples from liburing [0].

rx_buf_len=4K, oncpu [1]:
packets=3358832 (MB=820027), rps=55794 (MB/s=13621)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    1.56    0.00   18.09   13.42    0.00   66.80    0.00    0.00    0.00    0.12

rx_buf_len=128K, oncpu [2]:
packets=3781376 (MB=923187), rps=62813 (MB/s=15335)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.33    0.00    7.61   18.86    0.00   73.08    0.00    0.00    0.00    0.12

rx_buf_len=4K, offcpu [3]:
packets=3460368 (MB=844816), rps=57481 (MB/s=14033)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.00    0.00    0.26    0.00    0.00   92.63    0.00    0.00    0.00    7.11
Average:      11    3.04    0.00   68.09   28.87    0.00    0.00    0.00    0.00    0.00    0.00

rx_buf_len=128K, offcpu [4]:
packets=4119840 (MB=1005820), rps=68435 (MB/s=16707)
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       9    0.00    0.00    0.87    0.00    0.00   63.77    0.00    0.00    0.00   35.36
Average:      11    1.96    0.00   43.68   54.37    0.00    0.00    0.00    0.00    0.00    0.00

[0] https://github.com/isilence/liburing/tree/zcrx/rx-buf-len

[1] commands:
  $> taskset -c 9 ./zcrx 6 -i eth2 -q 9 -A 1 -B 4096 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[2] commands:
  $> taskset -c 9 ./zcrx 6 -i eth2 -q 9 -A 1 -B 131072 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[3] commands:
  $> taskset -c 11 ./zcrx 6 -i eth2 -q 9 -A 1 -B 4096 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

[4] commands:
  $> taskset -c 11 ./zcrx 6 -i eth2 -q 9 -A 1 -B 131072 -S 33554432
  $> ./send-zerocopy tcp -6 -D 2001:db8::1 -t 60 -C 0 -l 1 -b 1 -n 1 -z 1 -d -s 256000

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 59e38e7e067e..67dc38981101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5586,12 +5586,40 @@ static int mlx5e_queue_validate_qcfg(struct net_device *dev,
 				     struct netdev_queue_config *qcfg,
 				     struct netlink_ext_ack *extack)
 {
-	if (qcfg->rx_page_size != PAGE_SIZE)
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5_core_dev *mdev = priv->mdev;
+	u32 max;
+
+	if (!is_power_of_2(qcfg->rx_page_size)) {
+		netdev_err(priv->netdev, "rx_page_size not power of 2: %u",
+			   qcfg->rx_page_size);
 		return -EINVAL;
+	}
+
+	max = mlx5e_mpwrq_max_page_size(mdev);
+	if (qcfg->rx_page_size < PAGE_SIZE || qcfg->rx_page_size > max) {
+		netdev_err(priv->netdev,
+			   "Selected rx_page_size %u not in supported range [%lu, %u]\n",
+			   qcfg->rx_page_size, PAGE_SIZE, max);
+		return -ERANGE;
+	}
 
 	return 0;
 }
 
+static bool mlx5e_queue_validate_page_size(struct net_device *dev,
+					   struct netdev_queue_config *qcfg,
+					   int queue_index)
+{
+	if (qcfg->rx_page_size == PAGE_SIZE)
+		return true;
+
+	if (!netif_rxq_has_unreadable_mp(dev, queue_index))
+		return false;
+
+	return true;
+}
+
 static int mlx5e_queue_mem_alloc(struct net_device *dev,
 				 struct netdev_queue_config *qcfg,
 				 void *newq, int queue_index)
@@ -5623,6 +5651,12 @@ static int mlx5e_queue_mem_alloc(struct net_device *dev,
 		goto unlock;
 	}
 
+	if (!mlx5e_queue_validate_page_size(dev, qcfg, queue_index)) {
+		netdev_err(priv->netdev, "High order pages are supported only in Zero-Copy mode\n");
+		err = -EINVAL;
+		goto unlock;
+	}
+
 	err = mlx5e_open_channel(priv, queue_index, &params, qcfg, NULL,
 				 &new->c);
 unlock:
-- 
2.44.0


