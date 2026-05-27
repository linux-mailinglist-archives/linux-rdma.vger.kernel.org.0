Return-Path: <linux-rdma+bounces-21403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CbBMbd2F2ruFggAu9opvQ
	(envelope-from <linux-rdma+bounces-21403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:56:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988C5EACC7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20882302A06C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8B3C4B78;
	Wed, 27 May 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQyRV0vc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C231ED83;
	Wed, 27 May 2026 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922532; cv=fail; b=jNmIoImpKor6LzBGrRQoLHAYXw8nCApWan3d9Q/PSoK/7efeuTvxaPANK1ajBkNdcDD1nWkf6eXDslx8b8WqSrWHyKZ/S3fh96TWNfcM+iWVkOJQEDxnEwk0V7GXgis5UiPO9aLiK5VaJwt/4MUhlDgqZ055iuVlVHcYAjdhg/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922532; c=relaxed/simple;
	bh=c7lDuxxP46PHrbTWA/w2nu4/A9f6aX1nVb1fBWHD4Dw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AuihbX8IFB4dcd5tCcy8aqA+2uu3O5/MVs8icAXYtCrS2Kk6gyZrQezUxbn+tR/akOwPc9yWVHgdPMJAFnBv/cl/UqddWApxkW9GFufNpRh5c/z77tofcfhQ+qMAYwhPEDWuNh4ckYmsGhAsuilGe+k8nqMBXd2WpFJC9XAeJ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQyRV0vc; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUmmwHX7bivQIKDsrD36xcz7wsgHB+JoR8OApN3KO4grRejcheamHTsfE1VcLOLAbFFSVny5afAZ+rip722W5E/YQbPL6K947ESrEPWS5r/+u0s2aFk1U8jrSjuDrjKQk53vQ26m1CDBGWvqhgLPHr8/uve7REhJjM/N99u6YLST6ETBCwbmXUvLrd6SZBgpU25AcsiYyFpcxzZJ/xj4EDv1NXDTXr7epawCJMHrE0ZhK854akB/Pmru0QNM8r9Q2hxV3ehQ8S3YjARN5nlrCY7yK1rM1sYrhbH9fxfQG2IULSvqnFnkesjVl2NyiYHGRe5Z6aGOxhNQPC+qkUGyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mkJ8tK5U1AQTCclPHyrzeX9tD/r/3M83djqI4ie3ME=;
 b=KjR4g4t2v1sQ6jcsu355RnNgwTC9VjNq0jKgYYaZA3UkWvdgkk5hGKjdxl+YI0vKrLzwaxpzKQ5Q6XHhSKfHAiFCDjMurXb7OUHxEZdF8AY9ZHCMQZT2DLAdl7RNJuNwqRh9JSRU1gHpS+kmkTV8kqxaD86wEfvITuf6wbvWuwqXesNXvv9bfanb8+DVEwc+LXpft84sNqn9e+WCh3vyQi7rujcAJj5qyPIEEdz/91DYCUKywkMpwhnC3yc12B/ejB4rhmLpof85P/ky+qDH22HIlGoOV+ii5WcWu+DPf6em8uP7g13Fglb7Q99kL9QyKP9HvTgvfg6UwdiNCtPyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mkJ8tK5U1AQTCclPHyrzeX9tD/r/3M83djqI4ie3ME=;
 b=pQyRV0vcK+uj6wxU8bk9WAC3+bgAJTw+jAk3XLDYvmRlzRgqHZZK/S6xL8sBDROlOUAOVhY5qhL0l/4PsvQTvwMRY1o++SUxt9OHpTlhfp+PoR5CSMriWLn7560h2Jb07WX12C547sI2AH1LnMbb1wCHcxP1LLN2xyzwByxX85dYnCobQsxHvlBfOICmtWcvv/agt70qU+Mi32/Lwz1kj2+1FvZZFWqNKVDY5RspZbgwWkHyUHXavGYCw+qJG38Tv5MWhKhDH5Q/bjA6MbfJcbXqWjsPhPK1V7iGEKDKwUU5ny4tNGSfhJdA8Sh3JBuofK2PN4GsC6ekeYllRy3yZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 22:55:27 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:55:27 +0000
Message-ID: <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
Date: Thu, 28 May 2026 01:55:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-5-zhipingz@meta.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260526144401.1485788-5-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4204e0-44b4-4840-7962-08debc430b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FI/rmeukIpbmCgaHBokn33kYdQnkljrtV85laLSom/rP3Oi54SP2jPZ+qvzW7sCaNLUiWf2690IInr/IV+9zQYyiOCNaN1MW7FJgX38TlhR6HAqDnXNFTWRKWwolDEMvW9H68+vrsEyrhxHsOsfdV4cTywhjAoEGn6gHYu61kB/XKSMfK0uuUEZBkVh9yhQageA3KFfD7d7N6cFuW9bpBWvuRqLiHDbQKNwllNsoSMy7eHJ4HwugnA1IN8xwpkUuXwdUZOyRaiWsdFUX1NAHxREbrTxWMlY+fX+kOGN16jKlhQz4VkpKyqn3oK8QjtO2M98vlCLBJC+5ceoNS5sIj/RIuiUzP/OJFTd06ent4Vy+y1yVzZFZOjq6m7My3YgB26DhN72DgxJRH9zv6JjS/SEqsGMgQaGCC+lqNWZLq5D7jXRkr//OMOQKIWwozedXhBHyROVmvooydmAGWiEf98Gh74RNKeSTFnma67MRS9qYxQ/7nZc3kgDbnOGDwqspN+xLA1NxWAF8dZVu+KlRNnVLY43FezUnQl0HvJQn9Qiq7iH+CRbGTTbq+a9y1IDZ0pHQsBFlHopqZaQCVX2zZTttK6n1zxopT4ivsIAZvXGTTWRYjpT8oLNLDPWyWbzazx62k5mFxhWeI/B6h7R0/7b/izI53EH5UquMN4EE0LMZj4wJOFUps+KvJ6WSpiEI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9QWFVJZldRRXNQS3dGT0R3QmpKWUg1d3Z5VUFGMHpuNFZxSU4xYmM1RGVm?=
 =?utf-8?B?OEpRQ29rN1BReE44MHU2RTVremRIZUZzOFU3cFp3U2J5TmtKTStsVERXUlRz?=
 =?utf-8?B?NEJWOW5OY2VZRzMrVm81V2Yrd1A0eS9hVCtPaFFLMUhDTG42dEVjQ0pvUWxF?=
 =?utf-8?B?anBacWtqYVo2cTlVRldxUGFkcGZaVGQ5T2l6aU1wVXpjaUlzRkIwY2tmczk5?=
 =?utf-8?B?N1VTaXZuR09JYmVwOGtVbGFzVHVHTXp5ZDkzR2dSa2ZkWEVwaVJia0lod0FL?=
 =?utf-8?B?Q2xLNHd0aG1acXVEWlNmSnUzTm9yZElWOGtTOXFkaDZRK25HS0pRbFpuTEtR?=
 =?utf-8?B?Vy9GUzkzeFFjSDJ1TksydVdhUEZ1eHExZDVRRG02Q2NKUmhJUmtUdFB1ZHBr?=
 =?utf-8?B?YVdLTFUyLzVlRVpGeERpdVpGWUo1NWRFMzhscFI4Z0NoUnFTbkJudFU5eHhp?=
 =?utf-8?B?empSejBRYjVjT0RwNUwvQ20yem5OVC9ZblkwZy9MVDVpckl0ZnkyL3ptc252?=
 =?utf-8?B?YVE0UERSRTRiVFZqc1RTMEZkaERQYk9peFNtQWZTY0wvQ080VEwvQTAxUnp0?=
 =?utf-8?B?KzhxcCtndjAxZkpGa3l6bWxCeTYrcTRGdlcxMkFYTmtwTkRKS3Z2ck10R1dR?=
 =?utf-8?B?L2tOdUV6bGI0ZEQveHJaTnBBallZUG9VTmlFanQ3ai9vYmNVRWFFM2w3c3Nu?=
 =?utf-8?B?SW5oR043WnlVRkUyZTNnSHAxSW9WMTZnL2lUeGRxN2NvY0tTSUhxRGdKMCtt?=
 =?utf-8?B?S1ltV2lidzVpbHJJaXUxVlJXK0xEdFB0cHFsRGRxNDRldlNCVFlqWHFTSDVy?=
 =?utf-8?B?bE9lV0xsOG5tUEZQUDhoeVh4TXdyeDNmUlJ0a2NhNk5sOGw0WmtqWk8xYXp2?=
 =?utf-8?B?amhwc01oSm1YM2ljWTEzdlZJU1pRTDJEQ1R4YldGSldtRURFNDZlQUs3Zzcy?=
 =?utf-8?B?MGNpdUtpVXNUQ0dMQUxoTDZxTVlBQkdkTGtMUnFQSTBoeTBoZmxCLzhoUTNT?=
 =?utf-8?B?MkR6Ti8yaUVZbXAxZEpGd01EOGQzY0xyVXNzdXNHT3JuWUdXUzUxTitvYUtO?=
 =?utf-8?B?L2o5OUJaWXNtMkxRd1NBQjdPRVZYTTBFempDNFByMFMva2FGdXhXTG55MFNH?=
 =?utf-8?B?VUlxc1d5WFhkRDhFYStLSVhOWEZDbFVqbDc4c21PT2EzNGlMNlY2RWVYYVpX?=
 =?utf-8?B?QXZ3TTZzSFVwYlFxQ3dqR211Zk1iVGplRk9VQTBGb2Q3d3hoTnF2cldMUDlW?=
 =?utf-8?B?L3ltRC8vVGhnTTlrOUNhbVo1bTFzYTNBMklNM0IyanZxTXBER0tMTnlPUFoy?=
 =?utf-8?B?UEY1dldhZUpFMW9WMUZEOGxESHNXRW45bEVCa0ZyelAxclQvbzgrMnMzTkdm?=
 =?utf-8?B?N3JhQ2JmSTdwT0hyaUpnTVZTN2ZtQkVnNW1WOXpRb3g3K1IzYnppaVovOW9q?=
 =?utf-8?B?Q3lubFVNK3ZoQzk1L2VDTG5rZ3ZmaUNocWo5b2JlUWszQ0YxZXlLMjhrNlU4?=
 =?utf-8?B?OXhGOEVBTmhlRGRQUXc5SDBnbi9ZNCtJU0pnREl1N05qSzQzVFAweWk1NFdN?=
 =?utf-8?B?aHpkQmR6L01FVUFUUVgvalJPOWNIbW5SRmI3SDF5R3NJREVieGZweG5jNW9o?=
 =?utf-8?B?SXhlSWxvc3BqTGw0VnJzVXc5Nm82THN3aEdQK3BoYkFmQkhqeWtnOFY2Q2tL?=
 =?utf-8?B?V3Y5UktJNWRPR2dTMDlUNnZJQVpGaWlGckVoQXlGOUxYWloxbDFucXFCUWRY?=
 =?utf-8?B?UEp5cXp0cjJKUkY4Wmk3SXVCQnBqd1ZmYnpFeFhFeW5QK0NJMER0amh3Y0I1?=
 =?utf-8?B?TXhOQ1gzdUhNcUZoZjZoZ2UwaE9XY1I0ZzMvU0QvWU9TQ0FFOGExRDhkclJF?=
 =?utf-8?B?L1NLSWNGdTBFby9hL2tIZjNTWTN1Q1Y1NzlCcGRzMmsyZG5ZMmZvQ2RyaElz?=
 =?utf-8?B?bHd0VEIweXZzUndMcU9vYlF6eVVuMzdCK3NPbm1uR1M3U25aN1ptZUkwdXIr?=
 =?utf-8?B?ZDZ4TGEzZzV6NEx6bmFtT1M1aEVJMDBhZUhlQ05HYU8zQW96Tms3UHVkMm16?=
 =?utf-8?B?Qzh2dnRkdVB0UkpIclJBbzN0ODVBY05UVnEyTjV3ajI3dGVQdVRBSFRuTWdr?=
 =?utf-8?B?NWVxcyt0WFA1RE5kM1NTenk5SzRwQ3ZZVlNqUlo2UlFPUXlHVEp6N1BVTWI1?=
 =?utf-8?B?VXFNZC9LcnFyeXhqQ0JYY1NLdG5LU0toNHlET1NMdGdIYlhQNUJGN09vR3FE?=
 =?utf-8?B?aGpTSTBmSXZscjNmdHVYU2pvQ2pSbzZxaTFqSDFtTTlJRXVSN1RnZmZCck9W?=
 =?utf-8?B?N2FLcGloMXJ4MEhSTEQwT015U3Z0cUpZL3Z2VmpsQUlWRVhrQ2lkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4204e0-44b4-4840-7962-08debc430b49
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:55:27.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owlS+/VMj+irdecxmCiRNlwBSLOuMzXYD8RCsW/3RZWpMFE1KJixei3uMFwHOGfUzBq1To+z7FMvxlSFnvPT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21403-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 2988C5EACC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/2026 5:43 PM, Zhiping Zhang wrote:
> Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> peer access and translate the returned steering tag into an mlx5 ST
> index. Keep the DMAH path as the first priority and only fall back to
> DMA-buf metadata when no DMAH is supplied.
>
> Track per-MR ownership of the allocated ST index and release it on MR
> setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> its refcount reaches zero so repeated allocation/deallocation does not
> leak memory.
>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
>   drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
>   .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
>   include/linux/mlx5/driver.h                   |  7 ++
>   4 files changed, 115 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index e156dc4d7529..4ab867392267 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
>   			u8 revoked :1;
>   			/* Indicates previous dmabuf page fault occurred */
>   			u8 dmabuf_faulted:1;
> +			/* Set when the MR owns dmabuf_st_index and must
> +			 * release it via mlx5_st_dealloc_index() once the
> +			 * firmware mkey is no longer referencing it.
> +			 */
mkey st value is kept after revoke, regardless of st alloc and dealloc.
mkeys are kept in FRMR pool for future reuse even if their st index is 
currently stale.
> +			u8 dmabuf_st_owned:1;
> +			u16 dmabuf_st_index;
st_index can be read from the frmr pool key. No need to store again.
>   			struct mlx5_ib_mkey null_mmkey;
>   		};
>   	};
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3b6da45061a5..8059b5e4da97 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -38,6 +38,7 @@
>   #include <linux/delay.h>
>   #include <linux/dma-buf.h>
>   #include <linux/dma-resv.h>
> +#include <linux/pci-tph.h>
>   #include <rdma/frmr_pools.h>
>   #include <rdma/ib_umem_odp.h>
>   #include "dm.h"
> @@ -46,6 +47,8 @@
>   #include "data_direct.h"
>   #include "dmah.h"
>   
> +MODULE_IMPORT_NS("DMA_BUF");
> +
>   static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
>   {
>   	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
>   	.invalidate_mappings = mlx5_ib_dmabuf_invalidate_cb,
>   };
>   
> +/*
> + * Query TPH metadata from @dmabuf and translate the raw steering tag into
> + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> + * once the firmware mkey no longer references it). On any failure
> + * *@st_index and *@ph are left as the no-TPH defaults set by the caller.
> + *
> + * @dmabuf must already be referenced by the caller (e.g. via the umem's
> + * attachment) so we don't re-resolve the user's fd here and avoid a
> + * dup2() TOCTOU between umem creation and TPH lookup.
> + */
> +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *dmabuf,
> +			      u16 *st_index, u8 *ph)
> +{
> +	u8 req_type;
> +	u16 steering_tag;
> +	u8 st_width;
> +	int ret;
> +
> +	if (!dmabuf->ops->get_tph)
> +		return;
> +
> +	req_type = pcie_tph_enabled_req_type(dev->mdev->pdev);
> +	switch (req_type) {
> +	case PCI_TPH_REQ_TPH_ONLY:
> +		st_width = 8;
> +		break;
> +	case PCI_TPH_REQ_EXT_TPH:
> +		st_width = 16;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	ret = dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> +	if (ret) {
> +		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> +		*ph = MLX5_IB_NO_PH;
> +		return;
> +	}
> +
> +	ret = mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
> +	if (ret) {
> +		*ph = MLX5_IB_NO_PH;
> +		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
> +	}
> +}
> +
> +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> +{
> +	if (mr->umem && mr->dmabuf_st_owned) {
> +		mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> +				      mr->dmabuf_st_index);
> +		mr->dmabuf_st_owned = 0;
> +	}
> +}
> +
>   static struct ib_mr *
>   reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>   		   u64 offset, u64 length, u64 virt_addr,
> @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>   		ph = dmah->ph;
>   		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
>   			st_index = mdmah->st_index;
> +	} else {
> +		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> +				  &st_index, &ph);
>   	}
>   
>   	mr = alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
>   				access_flags, access_mode,
>   				st_index, ph);
>   	if (IS_ERR(mr)) {
> +		if (!dmah && st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> +			mlx5_st_dealloc_index(dev->mdev, st_index);
>   		ib_umem_release(&umem_dmabuf->umem);
>   		return ERR_CAST(mr);
>   	}
>   
> +	if (!dmah && st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX) {
> +		mr->dmabuf_st_index = st_index;
> +		mr->dmabuf_st_owned = 1;
> +	}
> +
>   	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
>   
>   	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
> @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
>   	bool is_odp = is_odp_mr(mr);
>   	int ret;
>   
> -	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> -	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> -		return 0;
> +	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> +		/*
> +		 * The mkey has been revoked: firmware no longer references
> +		 * dmabuf_st_index, so release it before this mr can re-enter
> +		 * the FRMR cache for reuse by another registration.
> +		 */
> +		mlx5_ib_mr_put_dmabuf_st(mr);
> +
> +		if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> +			return 0;
> +	}

The Sashiko comment on previous version of this series was wrong about 
the concept of FRMR pools and its reuse of mkeys.

Please move the st put operation outside the mkey cleanup flow.

>   
>   	if (is_odp)
>   		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
> @@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
>   		dma_resv_unlock(
>   			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
>   	}
> +	if (!ret)
> +		mlx5_ib_mr_put_dmabuf_st(mr);
>   	return ret;
>   }
>   

