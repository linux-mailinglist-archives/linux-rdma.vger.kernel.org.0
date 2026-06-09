Return-Path: <linux-rdma+bounces-22009-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ik+GC6zNJ2od2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-22009-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 10:24:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6765DBB6
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 10:24:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=f2EA4QHN;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22009-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22009-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF64830E2F9A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DD3EBF02;
	Tue,  9 Jun 2026 08:12:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80E2D8393;
	Tue,  9 Jun 2026 08:12:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992764; cv=fail; b=r5Sm/nty1TJAizdzHRpqtmWXBvq9GgPq2/GqC29vqdWTDgoAUFM8QcyuxF4QRW7vAzGvRyVrtZ21XIYjJgjAyef2dxAQNYzurOYfrHdr8Rl1PEWaXPsetnZCwYLhihafTyky+vn42MikbyYgI1TKapVYqWFviINhJbg6lKtJ1Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992764; c=relaxed/simple;
	bh=ZUASzpF2m4j9b1lk9wmIykTk41PzZVQDWdqov8QFsNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ds+INGc6WW75cHXQcdqkG4E7sBQK4yk09JoxG9slvfF1nZWjijzU0ohD5mQF9k7ZlatSWhg7X/RgvN1C22L+qBX962TP3WXiOAZXQPNvEbJcyznsKNdOzFuXNtDPB+FkH2r+k/a8HOO5uARDwbvXButuyQ4ul45Tm2RoYGpf5cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2EA4QHN; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjd9NGYqf0tx9cTEl0AVi/Vod6I8YxA6EAsJRFbLCEkJE0H4ldYg5rWX9y/GofXvPYUIlZLqfMhnNdsbOy+UwYSBf7YWj5tUeysZgZ8g9NnDxzFqgleLeKKlTsDXeGhs/g+2oZW2tBIvbID3FafcUhfpvI0DfK8F6hmEPSrdoGXlmOLZ9wI1G/5HxjOpwTFVfGUsP/zSxNZFNS0XH0wFW3xB6BBMTnepSlOfj1wY5bkiWtQN7ZcfGjmo4sLUdmVthvaCAGaFyHQ39liQ2374+G2cKsyLEPW2oVZKdxMNYN18DZf+7rzzIe59RwmsuPEwGToe/5vlzIxVWJ5Klklj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2srKKecOFKAh18ilAStbbd7uIpqYBcAoiskN9L0PtXQ=;
 b=B5HA8Q1sr1A5NAJvNyVHFOJagx4cSNa39kpn/loyMy24q4wpJkKJO2Hi/XnXPLahsW38sy7aX328mGq8lunFnzIA5I3lJ/mC1qAKa2K7ZSf4JeGWlvWTm1f0pBoxgbreWnHTDau7K3oiiCaTFEUt8PXDz3jNOPHpu7kjgSUY68sVMyHEpdlGpNrRDs0IK3BQ+9eT+SmIxaeMssUTQ65XmS6zG3oYyP970RGMjcd1XnfZLUT9kZdbK9KHAawR3+VJ2Zbvmb/idbV/FogwKEMuVSNqj6MdLUnjU2d/iQ5BbDdj3Je/s0NCn0PQaZlh0beIG4Pq5ND/kGgnrRVpgfQ2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2srKKecOFKAh18ilAStbbd7uIpqYBcAoiskN9L0PtXQ=;
 b=f2EA4QHNhhVFTlH4XcEMH/RcPX1IcwDxLttrJKxmc575FK8ACdenSF4V9m1IHVKTL0Gh+TZfPSuVBTlM4zw+5rhpLRORIUMWA+Jir9Qg6sbpRPFppFx2j67XOA7ibfQk7xhzCNZ9RF9lyu1vQk05M7jvdBZKrJcQyloouZ5Jh54=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:12:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 08:12:38 +0000
Message-ID: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
Date: Tue, 9 Jun 2026 10:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
 <20260608185646.4085127-5-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608185646.4085127-5-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9945913e-ecbf-47b9-ef25-08dec5fedea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ToF3q34+w7a3jK4qOmqeN2X4VWXR02Ua04BCaRmjRHJyvJTUtfrz4Kex1s7fBSp4SRwHosdmA4O3TirJ3Qj8GR8WBDnZxOY9KLwKyjVnBuZL8Gz6fx14fzqN31VnvI3nPiuxFKZFVmLwWSxfURF5QHZVXdrCbQvxl6CR81VqTqHMBW33bFFS9t28ZcifEQaRLHSZb6+Xrmm0LXsZ252by/zLrEn/J6aRL1ruQMkY/2jFvhzGaFf+v9dXaAJH5HppBXkmQGxeciRKmZ4wncQaX8IA3IL64JGdxvZoBHjdQXx3Sl+CAMKghqB+VV3Mcu3q+wYlXom5J27zLcygwubNSS0kOxmwIkQlv17HzDNalrjK+BLgTqLu56fSH5aXX/56KqJSZRA4u3x2dHe5dL2Bqu8NBxL0snnuZ5aS7+xqnPJZ7EJqRFgHklhOnpqNnpW33NzsEWJxdEPK6TcHgG7THO18dvQ0CFjXRmmUrhk1JSwPyUQcROUia/j09yO3Qo8I7L+xhF/Ut7GwxL7QS1y8I4rcuwkibf5fLtBjXmue9vtW3w50KZwN76GaXK5EOXEZo3oLGjZsoDIaHBGpT7HO7a97iPiswtHmDt0VnooRffdar21y8q5FI58lz0dKfrts2GE17EEjhC4Lq/0eUdO0k9HVLVY0extxT06/5NrIYYqtyg9+h6+9jLlznCPbqwjJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1pkelRUdWFMTWdmb0lRcHlUZUNlWm05WEY3ZnZHK3VTRExweU1jMEx6M25o?=
 =?utf-8?B?WFByZmIxNGRPYW9yMFBRSzM0WjhRLzVJZ0VLV2hvM0FmS3JXYXZyZWZEN0ZR?=
 =?utf-8?B?VnFGR3U2REgyNGRMR0UwMHFuNk02WlBMZnhiTmh2RTRFMHVvQkJ3QXcwOGJS?=
 =?utf-8?B?Q0VjVHNtK1FYQmxvZDNsR2J2VHNJZm9HRU1pOGpYeit3MFNwNWEvRGEycWJO?=
 =?utf-8?B?QTFwQlhzUFVKWTBDZk8wVDNtNHZpVC9NbStja3JPVGdBa2VLeWJDR0hxU2gw?=
 =?utf-8?B?aFVoS1NNQlIraEdDQTNLeGZYSWhkaTdqdjdMZzVwK2xCbzJmRlNoVnczZFNq?=
 =?utf-8?B?Qzk4RzlWY3NjcCtVdG9xb0YzblJrdWFWN2FsTnpMaURzMHAzc3VuWks4QTF4?=
 =?utf-8?B?ekZtRytTK0g0MVd6NjJBMTYyV056aHg5V2tsQWNGdGJDTGt4S1gvM0VJa1dv?=
 =?utf-8?B?M2ZoQXBRNTBJN29hc1VCdzh6eDBrc2JaRjV1aTBXR1kxSDNMOUNCdzhWMTlk?=
 =?utf-8?B?Q29QMkdRMUk3bURONmxPT09UTVhUUDhFUkppOUtvQ3lFc2ZXb2J2bWUwYlI1?=
 =?utf-8?B?UjFMTW50QmRHQ0pieWE4cFpFdUZXTk9ZenFFeWNpUlp1bGk5a1BnNEdIWWdu?=
 =?utf-8?B?TjkrYUFmQlJmaDdubXBPL2ErWFdHeVNsNDNSQWxhUWp1TFc0NnUzWVh6RVI3?=
 =?utf-8?B?cXhSdG9FLzFkb2lMY3RBa3BHaEJFOHY5elF4aVRQbVlqQ1VhQnJzK2xRY0Mx?=
 =?utf-8?B?cm1VWUl5M0d4bEhYZW9NMFZXTVBvdDBSUHRkTjJsaTNVTDJEKytPR3luVUpy?=
 =?utf-8?B?aHhseTEyeGpLZUQ2Z1g2S0NFN0NzZjlZNStsV01DYW5uUXZyNklFNk1MdlFR?=
 =?utf-8?B?S21iQVdxMm5UZit0Y2pjRFBJWjhJRFhBOVJ4Z3ExVmpVTXIzRG9PYU1OeHpx?=
 =?utf-8?B?OEhVWVI3SHUvOHRtVHRwcG5JMjM5RVB0Vm1XRzEzU0lnM0QzdTQ2b3IyQVRR?=
 =?utf-8?B?QjhSS1U1V1ZpeFFJaUVES0hWT2FXT2dHOHZpMmFncktoMjc0ODljRUo1VGoz?=
 =?utf-8?B?L2VaUFdqdVRjMjBOQ3ErVkJzZXh4eWZqbXp2blJLamxDRjJ4WGsxSnFpaEwr?=
 =?utf-8?B?UDhmeXN5b21BMTdya1doamZzV1c1WkZ5NmVZTzkwTm94VC9kZUY2M2VIbnhq?=
 =?utf-8?B?R3M2UWdOc2RvU293REFzblhST2RWNTA5Vnp1cmRqMHJMNENPa2puRmJiQkdr?=
 =?utf-8?B?M1lvNE56OUtjaTJNRTJEaEcxdXRtZ3NISWVnTDZxcDRoS0VPWEE1MFR2Z0RL?=
 =?utf-8?B?Z1Z6K1RHdEJTUWJiaHI4amZaT2pwL0I2YnozdjZMaWZoZUZnaFRWWHZPbXRw?=
 =?utf-8?B?RGVwcEVnVWVWV2E4aVBwL3dLdWYzZk81U0tXNHg1MWJmNnlZNG0zL2VIUjRX?=
 =?utf-8?B?ZWFKYVZFcTljdWNvTkV3eTJiejJqNWhSQU1Da1Y4Skt3QWpmVnc5RVBKVkJq?=
 =?utf-8?B?L1ZHamczbGMreW5JMnk1UWxDUGJvSmNkZ2ZNenNIekhNUmlKOU53Y2wyVmhz?=
 =?utf-8?B?Q0J1NXBkT3cwZG5uOWpKZGlyNy91MnNDVzhQY0ljSFdnb0s5dWxKVElRY3g3?=
 =?utf-8?B?MlFNTGFZSmxyYlJ1RDM3UnRiNGJTU3RreEpIVTZmYjVxR1l0OUladEJyVEhj?=
 =?utf-8?B?L0drVktGdUl0ZmFKeXkrai9xK2pKbjJMazZKYkNtQ1dvTFdlYzhmQkdBVzZN?=
 =?utf-8?B?cDBpYnlVOVZPeWZXcVdRYXZOOWhmQjMxMURpZExQb1FQaWtzeU9QUEhXb2tq?=
 =?utf-8?B?S1JrelZKQWhqM3k4YjhVM3JrNzZneTQrTXd2UEIyU1JOc1lPWThvakw2U1Fw?=
 =?utf-8?B?aTJlbjdBcjRsWTdOTjBrNDJDMkt1eHF5V3ppNzVVVTJvZ0ZoRlVvdUsvL0d4?=
 =?utf-8?B?aVFCcDVoQlpVSkhocEFwdDBOR3JEVG5zZFMvNHBiVERSbU53VkZ4RmJCWnVQ?=
 =?utf-8?B?L1RFK0NWb214ZXdKTzhUVkRDUFRVQkhvOU0vdWNiNThRUnFjVU9LMys0Q1hK?=
 =?utf-8?B?enNmK1A4U0NOWklHaHpEeWlibEZ4NmRaZUFCaEwxZUhPNksxZEdCVlVuU25p?=
 =?utf-8?B?SGFLcERVRDRNTHlpMUw5ZmpJZGR2ZWJqMlpBZDJkYVJUUlh1UGhOUlhkTzZR?=
 =?utf-8?B?bVlNT0xabWpnNkJ1YWZOLzhmSkZCckRMZzBGaStZaXBlZkxyTFBIUU8wVmZQ?=
 =?utf-8?B?anQ2WTZObW5NTkV1K1dnMkV6R0NVUmNCQ0d6T2w4UGdVRzVlQllvWDJzdmk2?=
 =?utf-8?Q?KjKJGIewKuAvakhAuT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9945913e-ecbf-47b9-ef25-08dec5fedea1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:12:38.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smvhzEMKoaJA42DhM50JDcHmFfXvOrcJz2AzQwiP5/8d1cGTsxbYIpBo6yyMOz2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22009-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: D9C6765DBB6

On 6/8/26 20:56, Zhiping Zhang wrote:
> Implement the dma-buf get_tph callback for vfio-pci-exported dma-bufs
> and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can attach TPH
> metadata to such a dma-buf.
> 
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_tph() returns
> the value matching the importer's requested width (or -EOPNOTSUPP).
> 
> The TPH descriptor is published and read under a new per-dma-buf mutex
> priv->tph_lock so a SET racing with a get_tph reader sees consistent
> fields. The mutex's only role is serialising the TPH state; priv->vdev
> and dmabuf lifetime are managed by the existing ioctl reference and
> dma_buf_get() ref, so the cleanup path does not need to take this
> mutex.
> 
> The SET ioctl returns -EOPNOTSUPP if the underlying device does not
> expose the PCIe TPH Extended Capability (pdev->tph_cap == 0); setting
> ST metadata on a device that cannot act as a TPH completer is
> nonsensical and rejecting it early gives userspace a clear signal.
> 
> The uAPI itself is not device-specific. It publishes the PCI SIG-defined
> ST/PH tuple for a VFIO-owned PCIe completer and keeps the tuple opaque
> to dma-buf; any importer simply requests the namespace it supports and
> places the returned value on generated TLPs. Any other userspace driver
> using vfio-pci for an endpoint that accepts inbound TPH can reuse the
> same interface.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
> Test plan: verified the kernel-side behavior by checking that an
> importer such as mlx5 emits the programmed ST/PH on outbound P2P TLPs
> after a successful VFIO_DEVICE_FEATURE_DMA_BUF_TPH set.
> 
>  drivers/vfio/pci/vfio_pci_core.c   |  3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
>  include/uapi/linux/vfio.h          | 45 +++++++++++++++
>  4 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 050e7542952e..4fa36f2f7555 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> +		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> +							 argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 1a177ce7de54..dd11a7db6b41 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -2,7 +2,9 @@
>  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
>   */
>  #include <linux/dma-buf-mapping.h>
> +#include <linux/mutex.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pci-tph.h>
>  #include <linux/dma-resv.h>
>  
>  #include "vfio_pci_priv.h"
> @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;

> +	/* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> +	struct mutex tph_lock;

Clear NO-GO.

When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.

Christian.

> +	u8 tph_st_valid:1;
> +	u8 tph_st_ext_valid:1;
> +	u8 tph_ph:2;
> +	u8 tph_st;
> +	u16 tph_st_ext;
> +	u8 revoked:1;
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -69,6 +78,25 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
>  }
>  
> +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> +				    u16 *steering_tag, u8 *ph)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	guard(mutex)(&priv->tph_lock);
> +	if (extended) {
> +		if (!priv->tph_st_ext_valid)
> +			return -EOPNOTSUPP;
> +		*steering_tag = priv->tph_st_ext;
> +	} else {
> +		if (!priv->tph_st_valid)
> +			return -EOPNOTSUPP;
> +		*steering_tag = priv->tph_st;
> +	}
> +	*ph = priv->tph_ph;
> +	return 0;
> +}
> +
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
> @@ -95,12 +123,14 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  		up_write(&priv->vdev->memory_lock);
>  		vfio_device_put_registration(&priv->vdev->vdev);
>  	}
> +	mutex_destroy(&priv->tph_lock);
>  	kfree(priv->phys_vec);
>  	kfree(priv);
>  }
>  
>  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -265,6 +295,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		ret = -ENOMEM;
>  		goto err_free_ranges;
>  	}
> +	mutex_init(&priv->tph_lock);
>  	priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
>  	if (!priv->phys_vec) {
>  		ret = -ENOMEM;
> @@ -327,12 +358,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:
> +	mutex_destroy(&priv->tph_lock);
>  	kfree(priv);
>  err_free_ranges:
>  	kfree(dma_ranges);
>  	return ret;
>  }
>  
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!pcie_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	/* PCIe TLP Processing Hint is a 2-bit field. */
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;
> +
> +	dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv = dmabuf->priv;
> +	if (priv->vdev != vdev) {
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +
> +	scoped_guard(mutex, &priv->tph_lock) {
> +		priv->tph_st = set_tph.steering_tag;
> +		priv->tph_st_ext = set_tph.steering_tag_ext;
> +		priv->tph_ph = set_tph.ph;
> +		priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +		priv->tph_st_ext_valid =
> +			!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	}
> +	ret = 0;
> +
> +out_put:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  {
>  	struct vfio_pci_dma_buf *priv;
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index fca9d0dfac90..c58f369be4b3 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  struct vfio_device_feature_dma_buf __user *arg,
>  				  size_t argsz);
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz);
>  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>  #else
> @@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline int
> +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32 flags,
> +				  struct vfio_device_feature_dma_buf_tph __user *arg,
> +				  size_t argsz)
> +{
> +	return -ENOTTY;
> +}
>  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  {
>  }
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..0ca26721849b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> + * with a vfio-exported dma-buf. The dma-buf must have been created by
> + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
> + *
> + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> + *
> + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> + * distinct namespaces in the PCIe TPH ST table and may both be present with
> + * different values. Userspace should populate the value(s) it has from the
> + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> + * width and receives the matching value; if the requested width is not
> + * present, the importer is told TPH is unavailable for this dma-buf.
> + *
> + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> + * completer. The dma-buf core treats the tuple as opaque completer-owned
> + * metadata; an importer simply requests the namespace it supports and places
> + * the returned value on generated TLPs.
> + *
> + * @flags == 0 clears any previously published metadata.
> + *
> + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> + *
> + * Userspace is responsible for setting TPH on the dma-buf before handing the
> + * fd to the importer. Calling SET again replaces the previously published
> + * values; racing a SET against an importer that is already consuming the
> + * dma-buf is a userspace ordering problem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> +
> +#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
> +#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */
> +
> +struct vfio_device_feature_dma_buf_tph {
> +	__s32	dmabuf_fd;
> +	__u32	flags;
> +	__u16	steering_tag_ext;
> +	__u8	steering_tag;
> +	__u8	ph;
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


