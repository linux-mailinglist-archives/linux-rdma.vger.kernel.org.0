Return-Path: <linux-rdma+bounces-16956-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HYDF6xylGntDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16956-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:52:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F310314CC6B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 14:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A0F130022EA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59236165D;
	Tue, 17 Feb 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5hHjVMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A054C6C
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336360; cv=fail; b=edeKaWjC65r4QxMIOagkONCeVWYYgcXuG4XVnl5KY5jEbpLVEgRIFmQtWHe0xcfG6gB9UyF2+4do/cTFZYa3X45l/meHGpozI6gSSk90QiVbldnNg6mU2yzy2AEqO7QZftR1fhsNMZRAam+7Dnelvg4+fCR3xzzM5YYpGl090b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336360; c=relaxed/simple;
	bh=aSSdYH+WBVz7LNl9tXFhZdpjjkFZ6ooJ+4Hd2wEWm64=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzSGPOCuXNiAQ2vBLo4iluQN8voe/w3pXuSz3Ho+CdRxG1LIneE0Aa0LcGCCtx56EUFACmH5WGZedNYV73kqSMwSrLuew5BE49YaqEfbQCP1M7+h1w/qFqGpHnCuHNY9UJ35OirGHo+PySgV2UG9CwzJvh5jzSOJSMrDA61Y4ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5hHjVMz; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYCgPIaTpZR768nzres8J9YduaxB6NYzHLIF4D4Y97lhrs8v6VR7f66SGJZD3UVq3B0oOveMegvn64ekVYp6Q4Pw60UiK2F49A0eTSwnzTgGh56yf6nHdnAKnhygoHfXviDH3/X5MYWwRHyA2m5MtmtldICcKZP3mvBXCOrcPe6QsuQw0XxDIO/Y/vnTBxIKwtp/AgxoCl1ZGUD23rMGutH7tZUuQ/gHEoq0XIokNvs63sb5b+dyntyBb+q+gfziEoMG6mXjowooUeheXjusqI2XNNbY0ncxGtSPeqheXsLIO6/HBCcNnu6W0OPvDly5/a4izBJpxsDZBq0VUbVJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSSdYH+WBVz7LNl9tXFhZdpjjkFZ6ooJ+4Hd2wEWm64=;
 b=j64qSq5hX7P/xRuMyVNcb3n+7mM2JSPxxTV+04NfVsW2e0uU+GXxLiKF2X7d6oYt26uHH0pk5XnhdLnBdzPqDaeWQCkZJR48DtDqyXeA8XbI8Wgo9VQJcNrzsV/VtV+3rLIddzAJj0OjxvfQ99DSjP+Sp00cmdGmIVkhK5JVbVHWPXUWx9oUiljkhXaMo3t7pP30ilk6g6LTJSVZc2zgQIV4aIInbW7Mmg3YsxIrAy5rtdejrGCROMrxxHnknCVJL0xtmfjnSEAdfz7xUC/vc+mlXuh+9+BsnWyClwhNVevD8noX6En0OrLaxvT+KPFkJQMYHZ6cAhymASwEWBUFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSSdYH+WBVz7LNl9tXFhZdpjjkFZ6ooJ+4Hd2wEWm64=;
 b=I5hHjVMzz8hmMkDyyBVhiHA0tLleYoIlsqw4mRPOsMx1Q5/1JTlpHgLrcTQh6eIHWe++5jWqBuelC4QYCaPx10tmQwhNQxrDnbQWjLFVkRqCw1IEqJl5KLf7an8SGu4uReUZ+rdrBUAEPIqArD/VFE3Uc6/1OTmMjRpQy047e2LYZNAs0LP3QSy/+nWddTqgdCONMX6GalCvKZUSx3Xatpqxl07+AwhzpwN+uoVAhGfXnBickZveQLdD9TxU1DUl4mQuOTMb3UtTZbT/eE3LhtCz5bBiXF64j0V8CQBCbmSQ4V/3hJwAo7hlFDtoec5TC+4B0kyh/F/xNYdcV0bXdQ==
Received: from CH0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:b0::14)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Tue, 17 Feb
 2026 13:52:34 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::a8) by CH0PR03CA0009.outlook.office365.com
 (2603:10b6:610:b0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 13:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 13:52:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:52:14 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:52:13 -0800
Date: Tue, 17 Feb 2026 15:52:09 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
Message-ID: <20260217135209.GA281368@unreal>
References: <20260114100728.484834-1-siva.kallam@broadcom.com>
 <20260114115858.GA10680@unreal>
 <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d25084f-3521-4cfc-cf90-08de6e2bcd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmFOb2FxMm9WVWhxUWxBdGlNMTZOUktuY3dDOW5rY1BrL2RwMkNUZTlTM1RL?=
 =?utf-8?B?Vy90VjRsZERpcjNSMUJTOHNUOUo4Q0ErVXhRbU1GQWpBVm4wZzQxK0NCRXJk?=
 =?utf-8?B?UVdkSllYS2RmRTF5UllsOGpCTEtQNzcrMm40Uzl3a2dtakZ2cHlicVRzT3pI?=
 =?utf-8?B?bkw0TFM2ODVwMVJreGhvaGxGbmV6a2J0QXYzUFBPZWdWa1ppdlB1THNZeHkr?=
 =?utf-8?B?ekdEWGhiOWtiUnlvZGp3SG1zT2Qwa0xLQTFFV3VkcVRvVnZ5b1QwMTg1c0No?=
 =?utf-8?B?M1hCM1BKR1dLMHNFOUN0RlZxUkl6eVNFV0FYRWk0eUZMRUtjRUhsckxKazBO?=
 =?utf-8?B?V05vWW8xemFydjFlUnlMRFpSaGZpamtPOUJES1pyUVdTUnVtWjVscFBGZC83?=
 =?utf-8?B?aDlyMkdMN0d4Z1VLL2FoU3FoYUJ6UGtFQmdISlJSMXE4alZXL0t2ZmFYWHhO?=
 =?utf-8?B?Wlc3NkdMNVlkWmhoTFAwaDNvc2x0Z0pub1hDenNSbm5qWWNBOW9XeEhwUFRq?=
 =?utf-8?B?cjdrZ0hidlRjRWpneEt1UUprdU9sSDFVNmxaOTZFVmVpZENaZkQ0NDRzbXk5?=
 =?utf-8?B?anhLcHJ2QU5FTGhTNHgwRmFDTTQ4Q1B2aXZvSURIajhrRDNqTitsdDdjaGNt?=
 =?utf-8?B?VGZvYzJsYStaY21TMksrTTJnOU5yN08yUDJmMFhOOC92cWgrUTg3TG04akF1?=
 =?utf-8?B?TFhyd3l2aHE4V1UwM2x5cDNMa0U2ZHVITTJ3QmlXZFlDZTFESHNKOE1VMWFI?=
 =?utf-8?B?c2dtbTJNTGZEaE93anA3OXJPYVlZVGkxTVdtTXpWMFJIaE9pSzdDTFRQQjh3?=
 =?utf-8?B?WHRITmRpQWVhTTFlZzBkNzYwNU1ITHhoSjlFdkoxQ3k2VVJrd0N4WmdQa3F3?=
 =?utf-8?B?SFZ6S3hKbHdTSmpZZW9UMFJZUExJMVN3MFRoS1Z3YzRTZHJUSHB5Rnl3L1Z6?=
 =?utf-8?B?QjZtNVJodUExcGxweUN6SUVCanozUUNUR2JjUyt6SEhKV2sxaVdjR2V1d2p2?=
 =?utf-8?B?QzBVVnhqYXV3K0tXYXJobVN3ekZ5Q0kzNElhdndDQm5aUWFwWnZuaVhwQU5z?=
 =?utf-8?B?RG41czQwbHlWRFV5NmR4QUJXa0RrclNPK3BlQ0dleFJpNzhhVXVHcHlmWTF6?=
 =?utf-8?B?cytCY0RScXVCcXBUcnVWQ2hMc20xWmhIenlrdDRQWXh0RkxWeGhIT3l6dS90?=
 =?utf-8?B?blR5TmtMLzA0U0hqZVdLSmlZSWdHYi8rbU4zQTU0K3VrMlNmeEUyTElCaWxP?=
 =?utf-8?B?ZjV5OUJIc2paSHoyaCtIY0VMLy9vK2pzRHpLREI2aEtYV21ndThtMXpKS25h?=
 =?utf-8?B?cktNR3hpTFFrVlM0ZllQVTlDVWJsNWw0ckhIRG85SExwdTUxMHRpQXVQVEp5?=
 =?utf-8?B?VXpyTnRaaVBSbW5wTVBFVlczaHp6b2dLU1RESkFmMlViMmRqcFBvS3pYR0Zw?=
 =?utf-8?B?R2NsaSsrSG04bDZObHZ0M3k5ZUlTdHVyR0hWRUVtTDIrN09Pc0dIZi84Zm12?=
 =?utf-8?B?QVcrM3BtMTcxNndFd0VvSnRsWDNBUHorMEFqTW9welFaS1RvQm5RTnNCeDU1?=
 =?utf-8?B?aWkySGc5MmNaTUNwTGQxeTByZEQ1N1VGL0NmZFIxbE80ZDJhVnFuVkJTQmdL?=
 =?utf-8?B?QThtb3hSNlpvR1VJTGxNQW5VenZxeGFSRGFBeWNQakVBNStuTXVtTldtZjB3?=
 =?utf-8?B?akRET2xkd1VJZjFxQjhxNThXOWd4ZTdadG5SZm1ZZ0VPWWczNmVMbk9KOG9w?=
 =?utf-8?B?ekdrblFUeU13NSs3RmF4WVRjS1hzbDMxcGZxeWE2aUR5bWJUVXlUVHVuV2di?=
 =?utf-8?B?cFYvRkNXWXRmUVZMZEEwSFZncVA3NS90azdGVGJEMEszOGtBK3hhZENXa1R2?=
 =?utf-8?B?MzFJOFVVYVUzbk44VzVYaVYwcHRiTkZzMlh1TWgzMnRIWmpERXpEVEZ3OHls?=
 =?utf-8?B?c1dYc2ovRjRET0NkZG10Qk1KKzhFS21waUd3a2FheXdSQlhaV0hLT3QxeFZH?=
 =?utf-8?B?MUticDUySHhISXFWNWNjSm1Hd2NYVk5YSjM0aXpPVWxrSzlhQ0NwVG9uekFl?=
 =?utf-8?B?S2NUTEg4TkdaSUw3QWx6TEFuL25NNnBCT2pDU3hmZnRYM2o4MmdDbGkyUUE3?=
 =?utf-8?B?YU5ieU1KOUpycE4zaFFzRi96cUJGYUI3dG85WWRjek9LUm4yRThoN3RUaWdK?=
 =?utf-8?B?UjJ5c0t4Ung2RlV3cTdhOHJtVXNXdTV6KzQ1WGx2V1lHR0psVHJKejl6UHNX?=
 =?utf-8?B?MVlNeDlTNjhJdGZsdUhHUXlCQWNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i61TrAHPwBZ7nEvx2PAVkvygqaVpT5Kh+vUfVg/q+s8/8KZAfbFlMxYE5exa4Zw6TlTF+pp7sCa3nr6zLMtF4hTC4rl7w0sMp6piWVRVgHbGr4aRmCK1eMYTsJWWmB3Kz6c2z9jSDiQcb3x/bOpcCaifDbPyVjCtY/IMG9G/Qdugppd+it6qp7qaJrZLK+8dPbZXBFOdc3T4QgKw6MvJLoE6K8UQtssT2IvKLCVrp+MIc22ZzYqokclVz8Z+yxhml5e+GrhGGUBMbc+SFPhPUHceL37Ejy+xsaACtQMc8dwbIUEYWHUT58BNf8aMUIYMdPCcVSEZZe59xHSKhQkhwABQvHG3BRxZrCFz0NOKd7Vbr5d9VYkH7zLXkaI7FPzZ78duGkGDvRkEOimcTEI0BsBuDlEnPivXwQ4vm6wFWynRMvT1SIB+ed9eWjNxloyy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 13:52:34.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25084f-3521-4cfc-cf90-08de6e2bcd93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16956-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F310314CC6B
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 04:35:20PM +0530, Siva Reddy Kallam wrote:
> On Wed, Jan 14, 2026 at 5:29 PM Leon Romanovsky <leonro@nvidia.com> wrote:
> >
> > On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote:
> > > Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.
> >
> > This should be accompanied with use of such define, where is the call to
> > ib_register_device() in bng_re?
> >
> > Thanks
> Hi Leon,
> I was under the impression that driver_id can be added independently.
> I am planning to send the next patch series including ib_register_device.
> So, This change can be sent along with my next series. Thanks for the
> clarification.

What's the current status of enabling this driver?

Thanks

