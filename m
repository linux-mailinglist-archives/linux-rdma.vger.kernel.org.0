Return-Path: <linux-rdma+bounces-15865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFjyGnBIcWn2fgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF485E32D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F019E664DC9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803E43C050;
	Wed, 21 Jan 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZkuZRpJc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D7438FE5;
	Wed, 21 Jan 2026 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031768; cv=fail; b=WLg1LGP2LJujfuwqTmc/geOsvB5v+GgNm74kK/tl5a6RGtwEEqH2TomvpIJ2THvzYDj6I/aJFp5gFN5qJzf/Aq673Nm2X5MVsqY1guAwKrO8CmOpNXQrp/nzGsq7VoLzSGfenbLPfusQDqpuq/uI/sBiLwCtNluoFAzN31cq6U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031768; c=relaxed/simple;
	bh=PM3JSlt4fhglgKtyQfSMdJTj4L2zArTiYCc4dORczcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ndRhYichQInd6Ii2sxY9vy7v7AVHPZr/TBWM2xYQ5AfCn6BBLXQIdQu2E4tf3BNiWuZv0Fh+mhND+IMkTNPaWfE2B40U8D1ZrNQMUTTlDALoVa26X6hOTmtV2oZ8+4xdRu/IPrJaapwQ4WSoWzITprcucjUkv3TdnGtRyd2JjP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZkuZRpJc; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cufIbyUCoW+FSmq6+bFMpE2fr0jtm6ZhIjdRYglnm7RIJUxXJlbHF6k004Q3WqrL7LwlcASbCkEyvzxL53KZyRyIv0/uZyTL+jT642c+LaEibfDs2ipgx0MM0CN4HJ5Dr7xaO1rW/V2w3GbJvuRIpy9t/e8CLgcvKgfoqeWOTplKYIOGHsu7rfSXGk09DipZhLn8pkHwnZpEmVFDP44t4Bwb9+f3ispv9FPaWWsp/eBibXypDsBLy3AdrTVCDNwHp0en1oMWntcjmyJ0FXpRVatkFEKAYONYZHK7k6qEzgYP4YVSG5X3F8k+tfKJLcrwQFRZrgB29YeXcJfY/KL5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1JOO+P9CmgrO2c+MK/RicVe4hocB9U0zNDmyV38gB4=;
 b=qYf2l36UaybPYxmHKmjcOQqa/AenRJ1pu9/BsSwKFVHAWZzkCgdGwYk2xcKsPAwhOyxfiiZE5BkAHbeXmjqvwcBUHX2YNhqu2ZArKp8dD32dNMy3zQsRPP5QDaa7YL8LxfsxHXZxVc3TIFBrOwyhpDak74TrCVqAz/yNR6lhIJbBInCS/5t2uNm+zB+6lFJZP2sWfdF/zp5PIEPceRAAE6o2j+JibS92aTqHxiIlkA7xFlEs9YWxgFmjFl9MiRNA7XhUAbRojr2UQwRKDHVh4mzrPTtfdA+U81AeVDRWhgnrguGY6TMZr3rpK9PPQDsi2Hb2JMD6py6CCSghOE3pmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1JOO+P9CmgrO2c+MK/RicVe4hocB9U0zNDmyV38gB4=;
 b=ZkuZRpJcd4Sb018zgCrqITWH46D5tITMr58FVrUUfWEbI7+qvRq8CDY7kor3wvlORFA2y3XWJxzsBd6O3aS1okp7yR7LWW4eI8dqP0iojgdTyPZIbsDTrbkY32yU8UdayCpOZsQXZVnPrskvcZKvZC1bWTJ7/MD8KNfULl21FGEseNg6AIvg5bv5uAP81+owxKl2Z4FV8/CM1Gq/aHbOnHxox87UWYbZfXu4YhlGZK4MtQC/omKEwPO67DjA62pMaXcD8BnrQVfP4oJTRsGVSsa1qZbNaD0Aiser6odRnARPXCSZzhYpxlrMYOjtgK+Rb/dYkRHlMOSU8767buVNgg==
Received: from SA9PR13CA0108.namprd13.prod.outlook.com (2603:10b6:806:24::23)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 21:42:41 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::57) by SA9PR13CA0108.outlook.office365.com
 (2603:10b6:806:24::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 21:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 21:42:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:42:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 13:42:26 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:42:24 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 21 Jan 2026 23:42:11 +0200
Subject: [PATCH rdma-next v2 1/3] RDMA/uverbs: Support external FD uobjects
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260121-dmabuf-export-v2-1-6381183bcc3d@nvidia.com>
References: <20260121-dmabuf-export-v2-0-6381183bcc3d@nvidia.com>
In-Reply-To: <20260121-dmabuf-export-v2-0-6381183bcc3d@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, Yishai Hadas <yishaih@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769031741; l=2919;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=NEf4tjfLs+CEQnECqTZ2VKUUXIGRqTQZBxE2IdIJBjQ=;
 b=zw8fk2qGb12uPCtsvrP7lERsSO05x86HSa99wuI0I8wcybv9jTXIJ6ayZYVUjplbAsaPENmb+
 D1MHybfIROxAK983mdP5jVPz0UhVrfKePczwgqT1M9T3TLPgBMTuPa0
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d18b01-28d5-4718-8847-08de5936013b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFcwZ1pRY2xUN1ZOVk9uSTYwdnpWN2EzV25TQkVWcFVtVFlDUkxiY3VJUFhS?=
 =?utf-8?B?UDRzYmwyNjZxREJIamppbVlvSDc5Yy9WRStMditjejNTS3czaUJINytnY2dU?=
 =?utf-8?B?bGxOU2gvcVNndkM2c1hMMEJxVEVHVS9NMWNwRmZyUFZvWTZtbHgvQkJjaTd2?=
 =?utf-8?B?MTBkTXp6VDJ0Qnh2cXlsRlVTZWVuOGk0QTlHSjRobm15L1hBWXVYL1BNZ3JV?=
 =?utf-8?B?cVpRcjRBRzdobnZRRlVoOWhCb051YW42VHBKMEIyUFJSVVZtTS9WZDVialRq?=
 =?utf-8?B?KzhPUFM3d09nQkoycStFVy9DbmVHWVJ3bmppWjNXUWFZeThhWVpDZnV0cGJ2?=
 =?utf-8?B?SlpSREJHOWNYRHhpTGxkdE5OZitvTFRDZnExS1NldHNUa2g3WnFhaFJnNXhK?=
 =?utf-8?B?ZE5FS0dlcGN3cFJzMEFXSk5UMTNvL0wrZWhnUTg4bW0za0ZVaGIyM0ljckVt?=
 =?utf-8?B?eHNRL291NnQyRFU0cG5JaXMvalJWS3JtRGpMejhYNjdnOXI5MTE2cDAydlJL?=
 =?utf-8?B?My9IWWpvNVFLZStGREFST3RTbGNjTEROT1AvaG93VFlWMHRmcUJHbFJ4cEtY?=
 =?utf-8?B?bWtSVW5NUlo5Q3IwdFpJVXI3NVgyWkl6RXZ1R1l5UDNGcWs4VlBucGxmNGlI?=
 =?utf-8?B?S3NNc1pUbXlURkxpaUtkRFRxUERHb29WNDdRTzdPTGRZQUd0elJJWW9iK3BQ?=
 =?utf-8?B?Mk14MEZsUU1JeXVnKzlNUGd1eXNGaUNMV2xDN0pUc2h1dWJ5dzFyZ2IrY1hy?=
 =?utf-8?B?b21ERUZGTTlIbTg1SmNBbEpnVzI2VU9mdi9VM3lkVHFYNWh3UVQxVllVaFg2?=
 =?utf-8?B?SnFwSXVrVXRpTHNNTVMvam91UzZMY3g0ZXpvb0NKNDVXNHhtcmpNSExwMW9V?=
 =?utf-8?B?MDhFMUtKdFYvNTlpeHlaczRnK0o3UEdOUHFJZ3NaTGs1UHRpZURUeWNmSXc1?=
 =?utf-8?B?ak95MTc3R3dRbXMxYm1jSGwzMXJxZkNpZ1I5a3VXeW1PcU5BMUdidUNqRHJD?=
 =?utf-8?B?UlF6cmRzenZxS2t4eXg2aXp5dkVVWnhML3hsbVlCa0xGTUc4dTI0UlUyNi8z?=
 =?utf-8?B?RDgvOExubFpNWWJ5em9FVmwwOTFJMXhWNWZGT0swZnl4bXFtSHFnNGEzTFRC?=
 =?utf-8?B?aDVXenJDaE5IckFpbTQyUFBHaG9wVDFPUTBuV3I0YjJTVjFybU8vMHZyODZM?=
 =?utf-8?B?TTRBL2U0dFcxT3VEWElFL0E1aCtPditYdGFoTkFON1ZvTHlGclJIS0psQkZQ?=
 =?utf-8?B?YUM4aEpPa3hyVFp1eWlyaDJZVUYyNzZ4Y0hYMFZDamNKZkl5UENqVU9QWVUx?=
 =?utf-8?B?dmJHSHV6V1hPRmkxbmNNWWcyWUFPcUN0cEJ3VTNjWkJTeUoxYS9QV2NCelIw?=
 =?utf-8?B?WjlCcEVnVnZrN3FLdUxMY1QxU1BHZllZdnltQ0I3a3NWc0E1U0xFbGNoMk8z?=
 =?utf-8?B?R3M2SUJPQnI3NEVOeXBlM1puMDZ2bUptTVpJU3htSFBLdzRML0FPWGR5ekYz?=
 =?utf-8?B?M0NDQVFMeXp5cGdCQ1FkbjBHZWgyRUl5R3RFSHZVTk5GUjA1cFQxVzZRaklX?=
 =?utf-8?B?ZmhydWgwUll2ZUNrS01vbmFIeGFRS2xkMCtKNTJWb0d4VG03QlRYUDJoTWNV?=
 =?utf-8?B?QndITTV4WXB4Mm10RHBUeUVaaTN6enhlWWIvWmhsWTNPazRSOHdDMVlDN3JV?=
 =?utf-8?B?T0pUc1lhVEFZNVRTTThOUWs4eHhHSFI5c3Q2RUovaXh2SXI3YkNDNjB5clRC?=
 =?utf-8?B?NzZhcHp3YzBDZVJxdUl4QWZLTVdBOTBSRTg3ekpuMzIvNWZHM0pJdy85VHZM?=
 =?utf-8?B?TVRJRi9waXQwTEFSNmJ6YUp5cDhDS0Yya1BIZm5OeFhrVis3NW53b0hmWWlX?=
 =?utf-8?B?WDlEUkhIRUk5S01CZXZpMEVpUU9lS0htZ1JMVTRnWk1kUzBKc2NsYndQeXJU?=
 =?utf-8?B?UC93WWRiTmV3eWVOUXNJaGNkVGVmRHd2T3NsM1VmY1VFaEtmYkgyWk5sWVJx?=
 =?utf-8?B?aGVxNklPQzFqSU9mZERQS3VnTzFTcW9lU2oyUmFTT1lTVGtQdFZuTUYyQy9z?=
 =?utf-8?B?RkVFVTRHUm85RzJMOTFYRDB2MXJpTHZjQStLdU9RcXo2V3dHandPQ1N5ZG1X?=
 =?utf-8?B?eWF5Wk1SSHU3emFFdDdEdGFCbE9YaWxDWjRxeUVRK2g4UkhqWk9la2pZdTBq?=
 =?utf-8?B?UncvNHBUMlZud25pN3dKRmJCTUVraENZN0c1dnFaQWt2ZVVyRkhyTHJuU0pG?=
 =?utf-8?B?Q0ZEWkhZTVVjUElRV0pNSmhYaTd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 21:42:41.5553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d18b01-28d5-4718-8847-08de5936013b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-15865-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1BF485E32D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yishai Hadas <yishaih@nvidia.com>

Add support for uobjects that wrap externally allocated file
descriptors (FDs).

In this mode, the FD number still follows the standard uverbs allocation
flow, but the file pointer is allocated externally and has its own fops
and private data.

As a result, alloc_begin_fd_uobject() must handle cases where
fd_type->fops is NULL, and both alloc_commit_fd_uobject() and
alloc_abort_fd_uobject() must account for whether filp->private_data
exists, since it is populated outside the standard uverbs flow.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 18918f463361..b6eda2fb0911 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -465,7 +465,7 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 
 	fd_type =
 		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
-	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release &&
+	if (WARN_ON(fd_type->fops && fd_type->fops->release != &uverbs_uobject_fd_release &&
 		    fd_type->fops->release != &uverbs_async_event_release)) {
 		ret = ERR_PTR(-EINVAL);
 		goto err_fd;
@@ -477,14 +477,16 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 		goto err_fd;
 	}
 
-	/* Note that uverbs_uobject_fd_release() is called during abort */
-	filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
-				  fd_type->flags);
-	if (IS_ERR(filp)) {
-		ret = ERR_CAST(filp);
-		goto err_getfile;
+	if (fd_type->fops) {
+		/* Note that uverbs_uobject_fd_release() is called during abort */
+		filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
+					  fd_type->flags);
+		if (IS_ERR(filp)) {
+			ret = ERR_CAST(filp);
+			goto err_getfile;
+		}
+		uobj->object = filp;
 	}
-	uobj->object = filp;
 
 	uobj->id = new_fd;
 	return uobj;
@@ -561,7 +563,9 @@ static void alloc_abort_fd_uobject(struct ib_uobject *uobj)
 {
 	struct file *filp = uobj->object;
 
-	fput(filp);
+	if (filp)
+		fput(filp);
+
 	put_unused_fd(uobj->id);
 }
 
@@ -628,11 +632,14 @@ static void alloc_commit_fd_uobject(struct ib_uobject *uobj)
 	/* This shouldn't be used anymore. Use the file object instead */
 	uobj->id = 0;
 
-	/*
-	 * NOTE: Once we install the file we loose ownership of our kref on
-	 * uobj. It will be put by uverbs_uobject_fd_release()
-	 */
-	filp->private_data = uobj;
+	if (!filp->private_data) {
+		/*
+		 * NOTE: Once we install the file we loose ownership of our kref on
+		 * uobj. It will be put by uverbs_uobject_fd_release()
+		 */
+		filp->private_data = uobj;
+	}
+
 	fd_install(fd, filp);
 }
 

-- 
2.49.0


