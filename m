Return-Path: <linux-rdma+bounces-22098-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0TV7IThoKmpwowMAu9opvQ
	(envelope-from <linux-rdma+bounces-22098-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 09:48:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB366F879
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 09:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=nrtnhtR3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22098-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22098-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9726301F178
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5236E494;
	Thu, 11 Jun 2026 07:47:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DE367F2F;
	Thu, 11 Jun 2026 07:47:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164054; cv=fail; b=l2IGfVi7+0mguxT9GlKor3QdHRhdQJ2Ec7+LbDQ0C/FDzhQf4bbZ/0zAvq3vLYAGr7NLkN+AjM5NMSYfekfiXbFu1B08qI/6Fw4CKB/47EtGg7i10aqc6tcxSGT3/JOJBMzx+lSI3alGLF1yK8tub+wnTn24LGpOv73qDGu3Szw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164054; c=relaxed/simple;
	bh=3eeUHPoWo7gUcaB4S/YS/cxd8pTa6CxPX3SaBuMlDqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rK2V0Gs6PWZfzsMQt3B8hmQPqqbTKsJVcjcaE1TeuFRBRHTvGONBjvAT0f7c2nw5awJkg83jhcrtoyOgs/4tdRa4osUf4EPKy9mAObjKj482KYuEy/b1kxFqQl3F6AsIdM/HSSz4JlWkEdRZwg2gJ0QPa9T0DvkLO2xpMF7OFyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nrtnhtR3; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCcc/F9K3lZMUSDTXasxwiyRmCqW5Rlf7YFTnWHGizRD1qXcCTFQjWS2Mzd9gnQ+6z6QqJWrIXouHSe/mKXd++ADC0LhdbDHJyUvT8Z/YokDuM7FOD1OfK5fbJNl+WyUCM1ZIZwR5tULoXJv3avLUe1AdDSi6RiPjPPyzUHBEPuAjuHCw7NNLncmmv1yXuXT/PWQeuqcDeo88Lq0PXIaQtikxBdS+crYd9DJYXSxpPRLBsj2Y/96fen5RRIMqrT7UueU8Eh2djLtWbrYPU+9Rsd7Wucz42FqvP3+3UXVk0zWKD4vWNqeyI59YRagLAhoLbwKigO+MZk12PM5k46nkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR32W3O681FNCYxzeuWqB94qTEobpZ+Iwjsny9kZXvQ=;
 b=VqJaqmgRbnPMB3uYW4J+YuiEebb/s1sxM47PSkGe3RLX5lkdTduUZ6ffxh8s85ZOQUvE5r6OEr5Rzke1Yt7MBFqFb7LL6m9kHPO7AIDswE3ki7wR64pUnajGUdwpZR8rMkcAqk7JL/Zlz2Oo0uJJuGt8RxRdbhjYcABRnOpR/enyFpn+CQYD3z18Uj31W8X9i6uCTpfviCoYltB9l3ChK6V5urXM1i5GmVz/nmMu6Nuwk9dDPX6pJVMePVq9lGm0cN+1pwHX0HhSMGXGZ2FlCrxHkWHt5l8u8MDUwb2CW3bD1R6zXjh22tN6I6cYaERyyCVLkNOtFUlWqfbwpSlNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR32W3O681FNCYxzeuWqB94qTEobpZ+Iwjsny9kZXvQ=;
 b=nrtnhtR3Ht/nvDQ7bKypLzb2RJhDJ5olu09/3SLsUlVyCvRXlmLE3unbPhw5qnU3A0CvO+bfHKMhPsvBlgLvmgGEX5hRQdBDXAERQQKhtjjdJZVls7rbsj+mHg6A16cJMSvkAGuzmeHgF81GoGKkWPtUfQgpLHy7TTTAK2pdWYE=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 07:47:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 07:47:29 +0000
Message-ID: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
Date: Thu, 11 Jun 2026 09:47:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-2-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610193158.2614209-2-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a59f1c-407a-4fe9-dc57-08dec78db00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9DgyKPx3VNC6QruSZTMMK1c517ix1CCoUzujEZ1lyq5my3X8F/uTmH7E2lq9RCwVfBjYLgp3iFMgK/jd91sV2amWyHcCu4ZdBvhW7twuiVym7ZdV4cW2yP5Pih8qFUlvxyQJvv/p85EQryFH7j54fJn1BuI+O4K0TY5nX/Grk1rwRLn/n4SXYm60z9yuSrjUKFku51ridnYc4Ul3GA6RWO8I7QcMQXLzn1Q0+LIwR1hxOqXKNf6VczMHTe1d3wb1U6iksISEV6y9jXUGSmQ0EaH8w0LDARCTBFRW1q3FtkAg6gGPB1eGlgu5HkZw3qx1cto4gwClGDFHDzKCcyoKmhYGoz+dotDNoKNW22ddBUrMJsvWkiGC2eIsst0vd8AuSrPVCvuAUAquGdMaIcdifaVNpkM4NjhCIPrsgnSeK43o77WWASPCTDqaTw4eLuDUkPIyIATDXdwEUH4KNX5vKhNiUnnJRYKLahAeiQzrPxFs2r3oFWazxUHiIT6w1FgbPaUpTWoL13VgSOfhk0Hx6FZJnsBnrj/rCFVpoLMyBOjtylCFS1wtzCSXH8JBhw9AjU/7FX+RG1HmwcReRta2QiQMZmemJNkcGjMx+FilxwJtzLat5K26YGgu1XFgrnjEdNya8iLyFUWCHwbqi3Em1S9QJ4r0xUwB9rVP3AOIakf3tUM3igd8wGOXKEnB5aZ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NmZmJObnhmb0FnMUR0c1R0ODl2eG1DN1M0S1FsR2xqd25qSVBJMVhvN1Z1?=
 =?utf-8?B?Z2Iwb1piZzFraThtak54cTNSUE4vTFJuc3Y1RjRhdEJYcGI3cVJQMnY4cnFx?=
 =?utf-8?B?djlGS3FFdUZ4WTMrcUFJMXgwSGJTQTRrS00zaXFCMXNmRjVxRTVBNnJMUmVS?=
 =?utf-8?B?QjdZQmx3Q05maFhyTXJxbUwwK0ZuTUNmRGtZQTN6SUVBR29hUTZQZ3hLQ2JI?=
 =?utf-8?B?eGdEZjJjSkZkcFBBeU1Id3p1S3k2ZkVCSytjWjVvWjB5MFgyM0VBbm9ldVI5?=
 =?utf-8?B?ZkQ5WGUrb25CUktUTDhuME5PeE5XV2FNNVAwU0dqbDkzd2k3SGk3eTJ2OVFr?=
 =?utf-8?B?SXExWnk5T01mK25SS25VcnRPMkNZdkRRVlZpSXdtd1c3UzlVMGRiQU1MckxH?=
 =?utf-8?B?aFlBTmtYTXpSRExlSmQ4c3Q0YjhoSDl0SmN4MU9hSXA0a25PakhrR2pvSktr?=
 =?utf-8?B?d0hlVlhtQVJrd2lLWkVGWjJEbXBuYnhQMUNzc2ljOU5GTmR3ay95dFFxWVVM?=
 =?utf-8?B?VnV5RkhNTWF2M2ZKYXVLU1FSSHAyTG04VURwS3JoVlAvQk9GYkhOeDhiVFdm?=
 =?utf-8?B?TksvRHIvWEtHVGFiU21VejBSYm9JRWtreVZQTjhPeWxRNE9aSjN1dnUvaFFs?=
 =?utf-8?B?ZlB4aEROMDFLQ2lCMitTTUZmYk15eENBOUF3a0ZuUy9jMzlyUFlXc3A5MDBq?=
 =?utf-8?B?QWtZd3JhMVdGWGNhTTFzS0pnNTVYMDd6aUc1RHBsRjN3UmZHRm5VbmVuZldw?=
 =?utf-8?B?UCtuSWIzOVBEeTdSUmQrUjVwVERqOHhjUmpRZlorcnlGWDFHaWhrZWh0bi9N?=
 =?utf-8?B?VStrbG1tb05qNzRZSVhYMmJDaWFmc3lkb1VHR2xSY0orODBNZ2lmYXlYV1hh?=
 =?utf-8?B?eTV5VXpwQ1Zqd1V3bVF5NE5ja1ZQbk9NUUFpa1RaWHoxWER4bExNTFJvVGVo?=
 =?utf-8?B?TGRFK2VPUUJuZ2NLYTJFQlhVM1FVcmVqKzRTR0tQaGkvTHlhVUFJRWZVdzVB?=
 =?utf-8?B?UVNhaEQ3MXN5T1l5VzdtOTlNQ05vaGtGbzJuc3JQYndMQ2JMeTRNTWNQMkVj?=
 =?utf-8?B?Y21mSTd0NzNnOTYvRmpWa0srQXZmMlozSnFYQll5QzhtN2xMZHdiSHk4VnBa?=
 =?utf-8?B?dUo3cHhkVVdWelRNWUg4eFF0UXlQRnVnWGZaM0NMcGcyTGlCSWNQbDhVTEhQ?=
 =?utf-8?B?RnU0Tm5nZXNQTWFBWmZ3U0o0dTJtRVkyOU9FbUphWGIzTEl5MjJreGgwQ1Zu?=
 =?utf-8?B?NkYzbWlKcHRMd3pRWnVzYm5IRlFIQ1Vnc0hURVJXelp6WFlNaUFBY3QzYjY3?=
 =?utf-8?B?Qy9iQndpYjBhOS95N01tWndVbWh5QXc3a1lOT2NCWG1xWjczOVZpR0xKTjIz?=
 =?utf-8?B?KzgvVkI1TGdFcG1ZVWlRVDduQ3BQQUVOMGptVGxBR3ZwNzJEaGFBeFlLK0la?=
 =?utf-8?B?M0tVRG9GS2RXUGdqWkZXQ0dlb0lyTlp2Wm9hZDU3WlJKVUNyU2RnUDliQmlY?=
 =?utf-8?B?Nm1Zd1Mxc1ljUG9WTUEyOHlrVUNKTUpPS2o5QWljWmJveGdrdExOVGxEaTUv?=
 =?utf-8?B?dk12cUNZVCt2NGRpUXB2V3I2QldrUko5WC9LTElFdWRtdUNDeHFZQml5UWVn?=
 =?utf-8?B?R2FqMEpNSjlEdXk2L2pKTjNxY1lpKytKdWxQMWcrcUhMTmdOMHpZK3JQeFBQ?=
 =?utf-8?B?S3llT1UybElIR2pKU1p6c2Nuck1jUklOa0g3Yldwdms4ZTRXS2IyekdYcmo5?=
 =?utf-8?B?UjZuTno0M2s5T2dqQ01yZi9scGVJaDdReXBGL1A2Q2dBZjZOU3FIOEFOZ2xL?=
 =?utf-8?B?MTVHT0ZIeUFlRUxUS1ZaeEhUZlMxRDFzZUd3Mkp1TkdKSE9tZVE5aUhvOXdS?=
 =?utf-8?B?TGJGZFgrTUZrRCt1M29SZ05DMUJMMW1jWXltd0R5SjkzT0pmMTJyRXFyOW9E?=
 =?utf-8?B?UVcwMlRpaHhPRHRuYkc2MkV3d2YxWGh5eEs0aWZ0M1MzbVBwYjYvVmxwdlJP?=
 =?utf-8?B?aktTMnl1b2hkR2UxaTNJR2hzSjRGV2UyaGJDM3Y5NS9tbDJZS3kxZjkySDd1?=
 =?utf-8?B?Q2J1QnNZMGV2b1NiRmVNRXVLOVQ4REJVN1FIeDNoYmZjekRmVjB5RXhKeldW?=
 =?utf-8?B?TXhyb0UwZUx5V1dOSS94MXRVRDdWbFZGSTd0NTRGcVRzMTBkOW1tWUIwb3dz?=
 =?utf-8?B?dFovZUhka3JDSFp6Sms0ck16WC9OcDcyemhGUTVON2cySFFzZ3NUWDNCRU9U?=
 =?utf-8?B?dXdZaUd2MVJ4OWorMFNXd2o2QlRDTEQwTnQvRkJvNzZrYTlSNVQ4a1h0RGRo?=
 =?utf-8?Q?h8Y55DCV1RJwl4bM/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a59f1c-407a-4fe9-dc57-08dec78db00d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:47:29.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovxvhhrv2TFtFToZ9KW+sYFOCDfvMVT2edjTUI+IdJPGKWNsYooc0Rls8XofgydA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22098-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29AB366F879

On 6/10/26 21:31, Zhiping Zhang wrote:
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
> 
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
> 
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Since this is an obvious bug fix I think it shouldn't be part of this patch set and go upstream completely independent.

Regards,
Christian.

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a13..7cedc348790d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>  
>  	if (refcount_dec_and_test(&idx_data->usecount)) {
>  		xa_erase(&st->idx_xa, st_index);
> +		kfree(idx_data);
>  		/* We leave PCI config space as was before, no mkey will refer to it */
>  	}
>  


