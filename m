Return-Path: <linux-rdma+bounces-15866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP4fGIdIcWn2fgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D40185E352
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5CC7667D81
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA343CEC8;
	Wed, 21 Jan 2026 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIjZlAoY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1EE43C06A;
	Wed, 21 Jan 2026 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031772; cv=fail; b=TR02tzxdzTb7gof9icD8VZzkUVsAuG14jhGrQhpt61VlNWM2K+LimpvNigpmgrg8MeqXQXC1nuZpNW2u5tPJQyKTgoBDOKHAMtVonqkX+acXhevbnZCl6m2rJiBlcJ75uyg1Xp67IcRL1b4tWYHZWuDuKVTNMZrTBWBQ8OVpcqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031772; c=relaxed/simple;
	bh=tZlMkLPaCSzXGXZteWtAID84aT2JHMEXL+bUbOezsB4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=JHKKCu9BP113wB4HEVClwgeKmnLfmGY8wxT50yNB5UMk8cPbnxwa+/pIM42l8PkqrgGRL0N703SJgh/LU9QTp1uNnJhaPk6jshOBlnUGgldF6YDNqw5FrxhiaNYIDblOYtRUHLHA2smFCAodfl8pOWqMqmlWu/thqUJalYW+6Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIjZlAoY; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9c5hYZfUavaoyRM/OpuzSyPljr6Hov2ygvyqTn0U40ABHs05RuZPsAQ8CqJsFaErHj0CutVMR2t2xKqqqhOnnhrUqu0ROPNOYqdh08AjnGI59LPola3r6OC1td0u+CIOpkbeUcd8FgpZ8ZCky6mzTMvK2d8UpoE2/QQnk7F7WnBZQ9PdqcjDtbCVmBCh2cXBW/6fQZYkePpxMiY26AbIhEp+Htr08/Q29B7eQzq1Fu1X7QQtSB++qWC4qU3x5htRU1RanC87f9z1N62s+BqFhoTynrAhP0kY9h5xYkhF2T3HNev13YmoufZjwiiA6tXMIYYHnFUDg8ms/SgHg+Gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZQYsnUtsOFwZyoKnimxZzPJUtxbgjJ2IOUO40HjTKU=;
 b=C8wJfCLwh/OeoSaZsSH87RJKeUuaryFuWcbDCqWi85Zl7fshWgWt2qKtmKqLikYh5UIVb5Wo+kLCixJm5nIOnKaV7FjoY41zWAN5iz3HVYVCduT+gmBwWiFNJ3+kdFRqVmsRk8GoNw+07kByW32HzSlruNEtU/TBHAkUGfRsqeQh3ab5ISzZotCo4kIeT6yXvAFSDWGn4sshIKuiX0M07luwCpmgDlmQj5fgTkavcpjjFcABGVDW3IyU+ufwhsqtPMd0HMAQ5cSsUzn2htcRQsTAlkC9wNFqJlraeAa9qqbklb6y4RbvolfD2YKm5WeFLK2paPRG81ZD1VtL85OjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZQYsnUtsOFwZyoKnimxZzPJUtxbgjJ2IOUO40HjTKU=;
 b=hIjZlAoYbBRk69IEN3zpkxmaSq7DD5snTTdt+Xx5XndjpvjQg6wBsXJHQFBUYcLs4ft5I15sMUIskbIU5TKddWSNRrItDxqQRbYLTVTYMatCdyy9rZ2F/vO8tfroj8MuOFGQPKJA7TN3toTvTBAyG1NcT0qi6ehKJC7l0EU/LFU+yxAmPeb+dv3kW7nomQFPNO0nl6YhPhq4EWVYfi7iadhbD8hdMjhlm2JZL9nnYWqPiE4T8sjE+IQRIZcqiG3Z6iTxkaA15KYntvvXxfusJSt94FXaJNX0miu+l/72qvv+19QGR2KcgFOnVsU/4lZfzb2dFmwelJ2Ss55zuGCkHA==
Received: from SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::20)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 21:42:40 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::cd) by SA1P222CA0019.outlook.office365.com
 (2603:10b6:806:22c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 21:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 21:42:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:42:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 13:42:24 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:42:21 -0800
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v2 0/3] RDMA: Add support for exporting dma-buf
 file descriptors
Date: Wed, 21 Jan 2026 23:42:10 +0200
Message-ID: <20260121-dmabuf-export-v2-0-6381183bcc3d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJIcWkC/3WNwQ6CMBBEf4Xs2TVbBKye/A/DAdlF9kBLWmwwh
 H+34e5xMm/ebBAlqES4FxsESRrVuxzKUwH92Lm3oHLOUFLZkCGLPHWvz4Cyzj4sSFzfLNWW2Qj
 kzRxk0PXwPSFkFp2sC7S5GjUuPnyPp2QO4I80GSRsuLpy1dSW+PJwSVm7c+8naPd9/wFf1kr1t
 gAAAA==
X-Change-ID: 20260108-dmabuf-export-0d598058dd1e
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, Yishai Hadas <yishaih@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769031741; l=3363;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=tZlMkLPaCSzXGXZteWtAID84aT2JHMEXL+bUbOezsB4=;
 b=jdAgG3wAVC/gaY4JGuBjEtRiD8ksVSpgDoCwXXJt9MuHu4GPW/VSFmSuMePhH21PyOCNOD3hC
 jyBbKB0GW2uBexjSY1MLKR8eU87Ksiks7UcyzlZ7fsn2Qrt5eUo8RSd
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 67556d0d-d9b7-4900-6174-08de59360042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzUrancxQkRkeHVCNlI2Mlc5N3hEdnE3NWxrVWNKWUZMRGkyQWZtR1Y1THN1?=
 =?utf-8?B?S3hPRG15TkNVOVF3N2lIZWVuR3dJTnhtT1lnME1ON3VqTmdmZmNiL1RvOCtB?=
 =?utf-8?B?QUZ1aVRSVmhSMmtPOXh4NnNBVUJiMXhyRnk3eXVSQXFlSmVsNUJZSTFndzc2?=
 =?utf-8?B?T0d6QTZ5UDVEYm1NZ091MXg4RkNLNmlyejUzZitta3o4YmlQMjBGUUwvdCtM?=
 =?utf-8?B?c0k4Q3ZENDNwZklLYjRMNDg0K1ppaE44blBYeHFtVDBtWW1tSytsdjVQU1Ix?=
 =?utf-8?B?b3dkOVdMdHFFVkM1YjBIMFpockp1Q3ViUk82UFdRU2tSdFlkNk00MGU5U0N1?=
 =?utf-8?B?b0hldy9iSVZldlVCQ3Y2N0FSaVZEUnNZY1AxUVNKLzlvbWNGeG9MVktZWXpJ?=
 =?utf-8?B?VytQTmFtRFBSdkhDK1VJMzR2aGR5Sm8yL1UvTm14Z3JSOUIwVGMzcGo4MkMy?=
 =?utf-8?B?eW45VnMyNTRnNUZnbnJqQ3JYc2VWZGRxUWo3aDQwUE94UG9NUTc3MDV6Z3Jw?=
 =?utf-8?B?UENxWWNCbDVHL0gydy9paE9tSU9MVUFaTTJaL042aUh3ZHBNekQrMURtcEJK?=
 =?utf-8?B?SDM0NlVnSVhiSDJFRTk5aW5FVHR2ejFWSEx5VTMrV05KTEpweHhqWlQxbUlE?=
 =?utf-8?B?UzNrYXVMR2o3VVFkK2d4dlBRWXl5emNDN083enhta3R5MVh0TnRPMVRpWGtZ?=
 =?utf-8?B?VE9VUmVmem5XaVY0UDc2K1RkbUk4TEdQa01iVmxwQ2xBL0Ewb0lGVmxoUUV3?=
 =?utf-8?B?QUl0cE95RWQyV2tsNTgwQVMwTUt3NnpvQ0tvdE54OGxMRlhPM2RZZjhqbFRn?=
 =?utf-8?B?MVE5NURuUmRoSkZjVXBWRm1Fd21GOTJrSU5CakF4dEswbGdqWjFkbVNzKzlv?=
 =?utf-8?B?K01CNnNCU0NURGh1Zm0zZldkMFZhTTYzc3JIMGFob05vV1FiR2hOdFg3ZHkw?=
 =?utf-8?B?bzFrQWpSaDFhejJPMEowRXBNUlRzVEhQRmw3ek12NjdjbnlCL3JsMmJ4SE5F?=
 =?utf-8?B?UEg1ZC9vQ1FlSjFDZnBrTkNYeUtsOXFUbkZCdFJJSUVlVkJsWkpNQS9LV05F?=
 =?utf-8?B?VU9hQkxySDM5SUZHSzhZanZGWEtUYUlsNHR0YmUyMHFhR0xVclFIeUVMa3lH?=
 =?utf-8?B?RFdyWGEvVG1GTUpyS0VMNytoTlpzaDYwQkhsOEYwUmZMMVBKcEF5WVd1R0Fh?=
 =?utf-8?B?WHV4Vlo3TCtvMGdhZ1FpY3lNNUpaZ2kxd0VqNTJVNWtvOFVlZ3ErYlBPWFMr?=
 =?utf-8?B?czRPNjhwNkQ3MDRKekZQajVKcTNscnVMV2d1alNmMHJvQkNadlEyWk02OThL?=
 =?utf-8?B?Y2FSS0JuTkJUd0ZCbEpaUEZYbGVnWTJ2aU1PMlZYKzF6TExEV3NiNWsyYUI3?=
 =?utf-8?B?VzZpM1l6eGRuT1lVZW1TVm5xZkpzaDA1R1VRUE92YnlUSjJlbitud1hQdjlM?=
 =?utf-8?B?cjlwWkpHRFRFUkJUQWJaT1FRTEJGK1ExTllYcXlzVllmZk9jQTJWMEpWNWho?=
 =?utf-8?B?a2lCUkQzY2x3amhNQVBOclRSZkNXSThtL1FaQ2d4ZDdqZExGMFNJdzVNWnhk?=
 =?utf-8?B?emJUZjBIUDVqU0pWbnRQM3RQTjFMLzgweCtVQ1ZjZDAzY0xBUS9iYzVOVEZH?=
 =?utf-8?B?Vy9HSUNFQ25EcjFUQVRabTkyd2VVeDNzOW5vQjlQWElTcWExRk9MTW9UV2ox?=
 =?utf-8?B?aDljT2s2Tk1TdUQ0dWcvaEgvdVJSKzBpSU5SZHM4d2hKOVl6cUVQZWVMd0dl?=
 =?utf-8?B?YVlrWExvd2QvT1JCMDR1bHFWekc2REhBdWZZNXJGcjZqYi82ZXZRNnhCdnFJ?=
 =?utf-8?B?ck1kUWVNVEY5Q1NTQldMYjlrc05xV29uQnBKUisrSndYemxxZWl3cXpCSmFR?=
 =?utf-8?B?UVNDT21LU3dXZzJmY0psNVJGekZhY0g2S28yTnB1UnQrcE50ZkFBL2ZZbjdl?=
 =?utf-8?B?NE15MmhrSitPQ3F0K2RNWlByUFZLZkd4bURoS2VZRlVVK0U5a0xNVVJVdE8x?=
 =?utf-8?B?VitueG9DY3RyUjUxY1VGc1MycWRIQWp5UTJwcmw1QVR1Z2M0ZVp2MDNSdTg4?=
 =?utf-8?B?ZHplOWZ5aHk1UlNzU1k4emF4TmRZNUFpRXp6Y25WWms4MUlzTHhLd1NRN2NC?=
 =?utf-8?B?NjlZVEl0QWZxMWpWTTVvZDllT3ZXeTMrb25NOTVUem5VL1VYU3VJOEJmNjJV?=
 =?utf-8?B?SzFLd2ErcjN0Kzg2YTNlWFVTYWxvcHZhdHFwaXlKekY3NHlKcmhMN25DaU1L?=
 =?utf-8?B?aUROZGpIWDVxZDJ0S1hVWmh4Uk5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 21:42:39.9638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67556d0d-d9b7-4900-6174-08de59360042
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-15866-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: D40185E352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series introduces dma-buf export support for RDMA/InfiniBand
devices, enabling userspace applications to export RDMA PCI-backed
memory regions (such as device memory or mlx5 UAR pages) as dma-buf file
descriptors.

This allows PCI device memory to be shared with other kernel subsystems
(e.g., graphics or media) or between userspace processes, via the 
standard dma-buf interface, avoiding unnecessary copies and enabling
efficient peer-to-peer (P2P) DMA transfers. See [1] for background on
dma-buf.

As part of this series, we introduce a new uverbs object of type FD for 
dma-buf export, along with the corresponding APIs for allocation and 
teardown. This object encapsulates all attributes required to export a
dma-buf.

The implementation enforces P2P-only mappings and properly manages
resource lifecycle, including:
- Cleanup during driver removal or RDMA context destruction.
- Revocation via dma_buf_move_notify() when the underlying mmap entries
  are removed.
- Refactors common cleanup logic for reuse across FD uobject types.

The infrastructure is generic within uverbs, allowing individual drivers
to easily integrate and supply their vendor-specific implementation.

The mlx5 driver is the first consumer of this new API, providing:
- Initialization of PCI peer-to-peer DMA support.
- mlx5-specific implementations of the mmap_get_pfns and 
  pgoff_to_mmap_entry device operations required for dma-buf export.

[1] https://docs.kernel.org/driver-api/dma-buf.html

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v2:
- Split the FD uobject refactoring into a separate patch
  ("RDMA: Add support for exporting dma-buf file descriptors")
- Remove redundant revoked check from attach callback. It is checked
  during map
- Add pin callback that returns -EOPNOTSUPP to explicitly refuse pinned
  importers
- Wait for pending fences after dma_buf_move_notify() using
  dma_resv_wait_timeout() to ensure hardware has completed all in-flight
  operations before proceeding
- Link to v1: https://lore.kernel.org/r/20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com

---
Yishai Hadas (3):
      RDMA/uverbs: Support external FD uobjects
      RDMA/uverbs: Add DMABUF object type and operations
      RDMA/mlx5: Implement DMABUF export ops

 drivers/infiniband/core/Makefile                  |   1 +
 drivers/infiniband/core/device.c                  |   2 +
 drivers/infiniband/core/ib_core_uverbs.c          |  22 +++
 drivers/infiniband/core/rdma_core.c               |  63 ++++----
 drivers/infiniband/core/rdma_core.h               |   1 +
 drivers/infiniband/core/uverbs.h                  |  10 ++
 drivers/infiniband/core/uverbs_std_types_dmabuf.c | 176 ++++++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c             |   1 +
 drivers/infiniband/hw/mlx5/main.c                 |  72 +++++++++
 include/rdma/ib_verbs.h                           |   9 ++
 include/rdma/uverbs_types.h                       |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h            |  10 ++
 12 files changed, 342 insertions(+), 26 deletions(-)
---
base-commit: 325e3b5431ddd27c5f93156b36838a351e3b2f72
change-id: 20260108-dmabuf-export-0d598058dd1e

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


