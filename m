Return-Path: <linux-rdma+bounces-19809-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MfNF97v82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19809-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:12:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F794A929E
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39716306D2AA
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B313C9C4;
	Fri,  1 May 2026 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3Ur7qpq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9946B5;
	Fri,  1 May 2026 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594139; cv=fail; b=sa3Dlnr9nlegIc3NPRoX7LGKgnars/HI9fwHVHSCvOaewuyF3D1Jjuj2gcFEMws5RAO7/IKqjzza7ML2l9/UQZs3CgMuoYuTgMG3Q/kFSElJv05nPO7mRhJeD14fZxJB9SlJpI6aou3X8CpAKrQI0G0d3VAY9WW6TwzlsQO/T3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594139; c=relaxed/simple;
	bh=rBHxCpxrMvRFsUGRlTGm7gllp7WXMHJRlZvoVEDYXbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i13Aql7AQEEXpO6qLf4tO1zP/ApYWyiCBuyEdrMffzAjIK2hNaxnYz22uheSbjEQvLnYylWoG0XZ2oWCYCQj8E+Y44KcS1toE28LLpFjJkFFrK+iiaRKPDIs3Zx1cDjNxdWPHUEF54rab0FbzBv0rur9MOiTFe9LHOgQbtptXJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3Ur7qpq; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXH82Fz1ZnV2w51pEZbXBiGwdAIEmVlRZfp+Wtei9xeZezDnyeuWfAuGFDv+gxHHQjlCUe2q64eUyQpsTY7UPXiFHJMSfLxAJ5LEaLHTx4dtEGH7+s6z8MLA/oP0js2/TcTV0vPLBNTRwvK1d150RuSOvWD+EkOnKaLQdHLnPaQ4+nV7mlCSYkfw5E+usSrBDnyM+0e8+tdNQjI36IVNeFenpvLxNpdOSpBhBqPuEWZdv/ib7zyeG88v1P6XFNecEFTVIThtuhR1vqaPXWACZoZmh6QgUiNSXI017jNVYImSeJ+/UYkQNani/ERZgixTT+byRyDgQNaVy/YnAUdKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtlbBMwyfk7Z0gn6VqhVKRFoS19IT5X3qpXLYxWRnMU=;
 b=d/P1/iHB9PIBEfYetOmMvw1ra10XzkMsQVRIl5aaU0iggOG7251fCwcbYiLw9NXVZ3TQ6+uvzt0SYc3SG0mg4/fGjz305U3HuzOOi6lxpgXkA81KrHfj1BakDHNEKnGPFCznwmLpTXywo7RMvWaozfsTTzuszb9dCMp/vdXWgfrhww2s5DEC9rQjAfaIt/CF6EsXlsooRshGaaR4rqkI2vOHJzgweHyPi8rXrS4hmATRoKiU74/O8a8PezkBr4AOEwSjIXGhpwTnKEF8HLKq6WGJl2Cl0uKEtP7yd2ZV94+XMin2BA0ie1T/R/lR2Sa3GBbd13XbN+bq9IpXmYzCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtlbBMwyfk7Z0gn6VqhVKRFoS19IT5X3qpXLYxWRnMU=;
 b=r3Ur7qpqTyWv0gMIPsJt5g6y5oHk6T3La6jGumj9vHwb4G3zWwAluhrKr5rqLZGt9yjdluNL9mQR+vSAT9kZzmymJYwKJrjPLN1JdWJe9Bd/d06ME9Ab1FQtvMUmvfWo+Eam0xGHArT1h4GzLxLY9SzGgXoaWeu3arm4SY2AfdFAppOVU5LDo49FIrN4/7b00RrOv5egaEZWTrNlnbAtEK3k2beeJhBRbsjyjNP/lEDiPkuoGiRUwJ0JwV3+CXGT763QVJBHVi8xvfmkEkbp2aDqqCmnZTFTPmKY7TfuZEuq1I02YInyJra5j+U3xKpDP5GMDIzQAD+IBe8BFXmw3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 00:08:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:42 +0000
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
Subject: [PATCH 11/11] vfio: selftests: mlx5 driver - add send_msi support
Date: Thu, 30 Apr 2026 21:08:37 -0300
Message-ID: <11-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: fde6a97e-a7f0-4efc-b96d-08dea715ccf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XsrmTVWyC+/ux7AxU2T8z36qqCh4B0B0B0jJWOFSaEQ3lw4shLe+ODddNMXytX40MwtUOE5zraZPTLCKzGt7XO7kLNGZDXfe7xo8fQcKcKWwSTIHoLQ7JoRi2TWBASVaIcGfWgJpi7tGo3zU4LxrVfjstvf6WvGxv4mAarDTzuw/9dKYvptDY+O4q6LFmQI69kSx0OjYZWoURlCLZ3QjSKcOpfItvQOIcTNGeI+mDkQZjXBhsKqgb3OuYxo+tXyt/DMFXfexVeg5IgNGgId4NpQTjtHoSGWoOb/8WaF5IysTW6hWw+fzOh9q8nRvGzJxJTP1r9IrHQPr+jslsNcqOTaAOe/BXxY0GkFTBM26HyzlEgMh5tp8KpiOgRQPAoeyNTW7OcuX3nTNj94zMbLPH9nw7/ymGe9/fswjxndAhQZmF+qB1euwLt1CbQG2AnPoyK/ebIgZ4Qo7oxNc3ZLhgkfuVjVYcZmMWRrnEIhJSSFcc3+JmaawfRQNIrwAugHdSUIrWp8dcywj+UH6Lg1SddLAsVhJIw5b+gMKuUX6ClEiZij/g2YekyCtitUIESa1/uj90Q2JB56wlFR4wsDp4XwlIiABJibzIV4ImgF7QGLs0gH+BueYGuBoG8T3C/A7L15Us5EyXnGBlU/PMQpEQSyqijyx6jitClIljbzY+Qxchg7FfM2861UDVrWeOpXdBLXKnGEmqwILRex+JgbgPV7siy1yCmMPUR9diKl6qtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtaQkMrRUZyTXZaZktWaDkzTFdBU3B2WUtsT1dqS1MyVUhTbDNXL2orbGxW?=
 =?utf-8?B?L2hOZnVpZ2ZHNGJZbFRBRDJkZW1VSndwbGNkR3pmdjVlRXNlbGF3eWpPZk1C?=
 =?utf-8?B?VTA3L3o4T1loci8zSHpnRUZ2SFVjV2p6OFFzdm8zOEZ6d2dGNWRMY3dUb09l?=
 =?utf-8?B?QXNpbXVzcVV3ZnBzTC9CRHJWbzE3cFZsbktqNmhmZEppSmV4aVFOYUs3U2wx?=
 =?utf-8?B?QXdBL3FEQXArQW4vYzVUVW10UFhxZHFQcVNiaGxlUngwQktRbmtJTVhPbnRx?=
 =?utf-8?B?OHpaWlBwVmVZUzJ3T2RhdGpSR21UMnUxSUxGWm9YbHZuMjBXSHNUZ3h4aCtH?=
 =?utf-8?B?N1B4NlFlUTd5WmRjYVJaR0hvQ3lrelE2ampjbm9EMmllY3JxdjZ2eld0dzNk?=
 =?utf-8?B?NlB6N0NSeTc5TFRhdmdCblVKa3hvZFd1aWZKbjVGbmd0R0R0QUFMK2lSaUd1?=
 =?utf-8?B?T1dGelpMSnRicFdTSmdteVpFVXJJRFBBTmVFSVJiSnpLQlAydnpLaElhSU5j?=
 =?utf-8?B?SEFqVVEySFdzMDNtcUZpR21pSGU2YW9tdjdMOTc3WUcxVjdlQXV3U1kwazNl?=
 =?utf-8?B?a1pTQjF0UmIwdEljREtWZ1NEZkoxTWxtc2VlN2pVMlNIb3ZWVHlNYmZ0VW5L?=
 =?utf-8?B?TCtDODg3eDlrVEZRLzJpaE1uM25vTmlDaHA5Z04zNjZqVWllMGFRb055NGVy?=
 =?utf-8?B?dGZIa3FOQWx5L2VBcFBYTUl5Vk1RejVSMDUvUUl1TGdOTWxxUTIvTlVKMUFH?=
 =?utf-8?B?Y3RmN080Q2tOTDZlK0FjbkxYR2syUy9oK3ZVSDR0Qy9ZK3AvSVNRdFg1Y3BH?=
 =?utf-8?B?SXJsREtMNU11VTB2d1lNSlZhY3BDQ21CSll5VUR2ZDg0RGExM1Z1YWt3WG9N?=
 =?utf-8?B?NWhUMTFMbnc1Q05NeHZsU29aM0xEUGU4M3ZtRi9zalBOZ2Y1R0poNEJaKy8y?=
 =?utf-8?B?azV2K1FGYVYycThHOTA1UVUzcGRRNWZRVm50M01xSjdCZ3g4YW51TTdqcXhG?=
 =?utf-8?B?akorTTFsTUhMQVh0dWpIME5wS3crbks2NGhpKzJEL2E2WGFoNG9EMGRzSlND?=
 =?utf-8?B?alhZVDRaV2toYU8wVEtEWTQrSEhReGd6a3NCeFQ1N0ErMFdyd0YyeDhudXZW?=
 =?utf-8?B?dHE5T0JDTTc2NzNPbGJ5Szg0dlV6S1I2ZFZwQXBoYWx2SGllVkxQakV3T1po?=
 =?utf-8?B?ODJzeTNQeEFTcktxU3NudGEvSlQwTEszNHE1aGsrTENCRUcyaHEzbEY5bkNI?=
 =?utf-8?B?SkUwajF4VUU1SEs0V291aW5EY2I0YVNLS3d5TG5EZlpmbzV0bDgwNHBZQ3Nk?=
 =?utf-8?B?V21Lbnd2NGU0aUV3VUNPNTl2eVcrYU1KcjJKVVltSjFSWWo5R2xqMnFvV1k2?=
 =?utf-8?B?eGFZSy9nSlVQRXUwR09WcGtuTVBOcWNYZ2ZFdy95YXV6MFRiK0ZIeFZ1MzUz?=
 =?utf-8?B?UVhkSWJyYWxjeXRTMjUvaEVqejd4QmFCMnBWQkhDZzZxL3QxVWhnMjZuNk5C?=
 =?utf-8?B?ZXhycGRDVXhKTG9uT1ZPSmZyZVltajhaVXp1QWxpMHc4cEFzMDZzb2pXemky?=
 =?utf-8?B?Y05BK3UvbnI5OE1pcldtcWVhTXRNSlJ6RDdiRFlSVklzWXF5WDc0Y3FRWFZw?=
 =?utf-8?B?WUZpZ3FkMW0wVDdxd3crdnFlQmRxaTJSVTRxcE1wME8vUG1ZZ090ci9TN3Jn?=
 =?utf-8?B?ZVArZVFFZ0NoRGZyYkxyUXQxL2cweDdWcUNqYkFCK0lxN2RkQ0IrL3BzS1VN?=
 =?utf-8?B?NGNSV2Q5dkNtblRZRm1QczhFbS9UZWRkZHIvWmp0UjJoekhUbmQ1anBINk5W?=
 =?utf-8?B?Rm42dDcydDRnd1RxK1BZb0pxK0Q5aGR3dk5IaXpSZnVkanMrdWE2ZjkwVUZI?=
 =?utf-8?B?eDRDNWpiWm5iNGFRZnozK2g1TFloMEJINnNGWE1VQm54aUV5cE9TVTJTSkNV?=
 =?utf-8?B?eXpha2taWFJlZ0dxRUZkYTVNUFdnb3VYVnZGSm5rUVI3b2EvQWRnWGtuRFU4?=
 =?utf-8?B?UGRnT3R3UlhhN1BHMFpQalBTdVJDa2ZqRGhaWXBOZEFDdmVxYWtRQVFVM2kv?=
 =?utf-8?B?d3dwbnA4RUhGdzJhOFpTOXI3T1NZKytwWFdKOFB0OWdNa3p0Ty95UFZvWDdn?=
 =?utf-8?B?R09QdVg2c2svdE9MWkp2MUI1NFZSSlJSMzVudHJFdlJxMVcwR093NW1YNlJh?=
 =?utf-8?B?YjdNdmpvTUdNdUNPZXpzVldNTzlCS1ZPKzNwMld4UWl1NW1Zb056d2FDWlB4?=
 =?utf-8?B?RGlCSnJ4L0JZejR5dFZzcDlET1N2eU1VNmJtK0RtWUtjaWpZNmt1RnFaSFpz?=
 =?utf-8?Q?aNJMfgdamejU5T9fSi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde6a97e-a7f0-4efc-b96d-08dea715ccf0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:41.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLvIAWUghMlEK62IiWSun2zI/r98mWn8TL76VYPRk58o/tebZl7lWg4LCnTqzjrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Rspamd-Queue-Id: B6F794A929E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19809-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Wire an MSI-X vector to a dedicated EQ so the mlx5 driver supports
send_msi().

Each EQ can be linked to an MSI-X vector, and the CQ can be set up
to deliver an event to the EQ. Thus, when everything is armed, an
RDMA WRITE posted to the QP generates a CQE, which generates an
EQE, which generates an MSI-X.

To keep things simple this just re-uses all the existing QPs and
CQs, so they generate single MSIs during memcpy.

send_msi() drains any accumulated MSI EQ events from prior memcpy
completions, posts a small signaled RDMA Write, then polls the CQ to
consume the resulting CQE (avoiding stale completions on subsequent
test cycles).

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 165 +++++++++++++++++-
 .../selftests/vfio/lib/drivers/mlx5/mlx5_hw.h |   6 +
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
index 39c5414e2c743c..cf6c436a6df0de 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
@@ -56,17 +56,23 @@ struct mlx5st_device {
 	/* CQ */
 	u32 cqn;
 	u32 cq_ci;
+	u32 cq_arm_sn;
 
 	/* UAR */
 	u32 uar_page;
 	void __iomem *uar_base;
 	unsigned int uar_bf_offset;
 
-	/* EQ */
+	/* EQ (cmd/pages events — polled, not interrupt-driven) */
 	u32 eqn;
 	u32 eq_cons_index;
 	bool have_eq;
 
+	/* MSI EQ (CQ completion events — fires MSI-X) */
+	u32 msi_eqn;
+	u32 msi_eq_cons_index;
+	bool have_msi_eq;
+
 	/* Async pages slot state */
 	bool pages_slot_in_use;
 	bool pages_slot_is_reclaim;
@@ -89,6 +95,10 @@ struct mlx5st_device {
 	/* Capabilities */
 	bool fl_supported;
 
+	/* Buffers used by send_msi() to trigger an interrupt */
+	u64 send_msi_src;
+	u64 send_msi_dst;
+
 	/*
 	 * HW-visible DMA buffers below — device reads/writes via DMA.
 	 */
@@ -111,6 +121,9 @@ struct mlx5st_device {
 	/* EQ does not support page_offset */
 	struct mlx5st_eqe eq_buf[EQ_NENT] __aligned(MLX5_HW_PAGE_SIZE);
 
+	/* MSI EQ buffer — CQ completions generate EQEs here -> MSI-X */
+	struct mlx5st_eqe msi_eq_buf[MSI_EQ_NENT] __aligned(MLX5_HW_PAGE_SIZE);
+
 	u8 fw_pages[MAX_FW_PAGES][MLX5_HW_PAGE_SIZE]
 		__aligned(MLX5_HW_PAGE_SIZE);
 };
@@ -133,6 +146,9 @@ static_assert(offsetof(struct mlx5st_device, qp_dbrec) % 64 == 0,
 static_assert(offsetof(struct mlx5st_device, eq_buf) %
 			      MLX5_HW_PAGE_SIZE == 0,
 	      "eq_buf must be page-aligned");
+static_assert(offsetof(struct mlx5st_device, msi_eq_buf) %
+			      MLX5_HW_PAGE_SIZE == 0,
+	      "msi_eq_buf must be page-aligned");
 static_assert(offsetof(struct mlx5st_device, fw_pages) %
 			      MLX5_HW_PAGE_SIZE == 0,
 	      "fw_pages must be page-aligned");
@@ -1012,6 +1028,85 @@ static void mlx5st_process_events(struct mlx5st_device *dev)
 		mlx5st_eq_update_ci(dev, cc, 0);
 }
 
+/*
+ * MSI EQ — dedicated EQ for CQ completion events that fires MSI-X.
+ * Separate from the cmd/pages EQ so that only CQ completions (from
+ * send_msi or memcpy) trigger the interrupt vector.
+ */
+
+static void mlx5st_msi_eq_drain(struct mlx5st_device *dev)
+{
+	u32 cc = 0;
+	u32 val;
+
+	while (cc < MSI_EQ_NENT) {
+		u32 ci = dev->msi_eq_cons_index + cc;
+		struct mlx5st_eqe *eqe =
+			&dev->msi_eq_buf[ci % MSI_EQ_NENT];
+
+		if (MLX5_GET_ONCE(eqe, eqe, owner) != !!(ci & MSI_EQ_NENT))
+			break;
+		cc++;
+	}
+
+	/* Update consumer index and re-arm for next interrupt */
+	dev->msi_eq_cons_index += cc;
+	val = (dev->msi_eq_cons_index & 0xffffff) | (dev->msi_eqn << 24);
+	iowrite32be(val, (u8 __iomem *)dev->uar_base + MLX5_EQ_DOORBELL_OFFSET);
+}
+
+static void mlx5st_create_msi_eq(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_eq_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_eq_out)] = {};
+	struct mlx5_ifc_eqc_bits *eqc;
+	unsigned int i;
+	__be64 *pas;
+
+	/* Initialize EQE owner bits */
+	for (i = 0; i < MSI_EQ_NENT; i++) {
+		struct mlx5st_eqe *eqe = &dev->msi_eq_buf[i];
+
+		MLX5_SET_ONCE(eqe, eqe, owner, 1);
+	}
+
+	MLX5_SET(create_eq_in, in, opcode, MLX5_CMD_OP_CREATE_EQ);
+
+	/*
+	 * No event_bitmask — completion events are routed to this EQ via
+	 * the CQ's c_eqn field, not through CREATE_EQ subscription.
+	 */
+	eqc = MLX5_ADDR_OF(create_eq_in, in, eq_context_entry);
+	MLX5_SET(eqc, eqc, log_eq_size, LOG_MSI_EQ_SIZE);
+	MLX5_SET(eqc, eqc, uar_page, dev->uar_page);
+	MLX5_SET(eqc, eqc, intr, MSI_VECTOR);
+	pas = MLX5_ADDR_OF(create_eq_in, in, pas);
+	VFIO_ASSERT_EQ(mlx5st_fill_pas(device, dev->msi_eq_buf, pas), 0u);
+	MLX5_SET(eqc, eqc, log_page_size, 0);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->msi_eqn = MLX5_GET(create_eq_out, out, eq_number);
+	dev->msi_eq_cons_index = 0;
+	dev->have_msi_eq = true;
+	mlx5st_msi_eq_drain(dev);
+
+	dev_dbg(device,
+		 "Created MSI EQ: eqn=%u, %d entries (COMP), vector=%d\n",
+		 dev->msi_eqn, MSI_EQ_NENT, MSI_VECTOR);
+}
+
+static void mlx5st_destroy_msi_eq(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_eq_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_eq_in)] = {};
+
+	MLX5_SET(destroy_eq_in, in, opcode, MLX5_CMD_OP_DESTROY_EQ);
+	MLX5_SET(destroy_eq_in, in, eq_number, dev->msi_eqn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
 /*
  * HCA init / teardown
  */
@@ -1366,7 +1461,7 @@ static void mlx5st_create_cq(struct mlx5st_device *dev)
 	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
 	MLX5_SET(cqc, cqc, log_cq_size, LOG_CQ_SIZE);
 	MLX5_SET(cqc, cqc, uar_page, dev->uar_page);
-	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->eqn);
+	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->msi_eqn);
 	MLX5_SET(cqc, cqc, cqe_sz, 0);
 	pas = MLX5_ADDR_OF(create_cq_in, in, pas);
 	MLX5_SET(cqc, cqc, page_offset, mlx5st_fill_pas(device, dev->cq_buf, pas));
@@ -1391,6 +1486,30 @@ static void mlx5st_destroy_cq(struct mlx5st_device *dev)
 	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
+/*
+ * Arm CQ for event generation.  The CQ event delivery state machine is
+ * single-shot: after generating one EQE the CQ enters "Fired" state and
+ * won't generate another until re-armed via ARM_NEXT.  Both the CQ doorbell
+ * record and the UAR CQ doorbell register must be written.
+ */
+static void mlx5st_arm_cq(struct mlx5st_device *dev)
+{
+	u32 sn = dev->cq_arm_sn & 3;
+	u32 ci = dev->cq_ci & 0xffffff;
+	u64 doorbell;
+
+	/* Update CQ doorbell record arm word */
+	WRITE_ONCE(dev->cq_dbrec.send_counter,
+		   cpu_to_be32(sn << 28 | ci));
+
+	/* Ring CQ doorbell register, iowrite has an internal dma_wmb() */
+	doorbell = ((u64)(sn << 28 | ci) << 32) | dev->cqn;
+	iowrite64be(doorbell,
+		    (u8 __iomem *)dev->uar_base + MLX5_CQ_DOORBELL_OFFSET);
+
+	dev->cq_arm_sn++;
+}
+
 /*
  * QP create/destroy
  */
@@ -1647,6 +1766,7 @@ static void mlx5st_teardown_datapath(struct mlx5st_device *dev)
 	}
 	dev->sq_pi = 0;
 	dev->sq_ci = 0;
+	dev->cq_arm_sn = 0;
 	memset(&dev->qp_dbrec, 0, sizeof(dev->qp_dbrec));
 	memset(&dev->cq_dbrec, 0, sizeof(dev->cq_dbrec));
 }
@@ -1688,6 +1808,34 @@ static int mlx5st_memcpy_wait(struct vfio_pci_device *device)
 	return ret;
 }
 
+/*
+ * send_msi callback — trigger CQE -> EQE -> MSI-X via a small RDMA Write.
+ *
+ * Both the CQ and MSI EQ use single-shot arming: the CQ must be armed so the
+ * CQE generates an EQE, and the MSI EQ must be armed so the EQE fires MSI-X.
+ */
+static void mlx5st_send_msi(struct vfio_pci_device *device)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+
+	/* Drain accumulated MSI EQ events and re-arm for next interrupt */
+	mlx5st_msi_eq_drain(dev);
+
+	/* Arm CQ so the next CQE generates an EQE on the MSI EQ */
+	mlx5st_arm_cq(dev);
+
+	/* Post a signaled RDMA Write to trigger CQE -> EQE -> MSI-X */
+	mlx5st_post_rdma_write(dev,
+			       to_iova(device, &dev->send_msi_src),
+			       dev->global_lkey,
+			       to_iova(device, &dev->send_msi_dst),
+			       dev->global_rkey,
+			       sizeof(dev->send_msi_src), true);
+
+	/* Consume the CQE to avoid stale completions */
+	VFIO_ASSERT_EQ(mlx5st_poll_cq(dev, MLX5ST_MEMCPY_TIMEOUT_MS), 0);
+}
+
 /*
  * Driver ops callbacks
  */
@@ -1716,8 +1864,13 @@ static void mlx5st_init(struct vfio_pci_device *device)
 	mlx5st_alloc_pd(dev);
 	mlx5st_create_mkey(dev);
 
+	/* MSI EQ must be created before CQ so CQ can reference its eqn */
+	mlx5st_create_msi_eq(dev);
 	mlx5st_setup_datapath(dev);
 
+	vfio_pci_msix_enable(device, MSI_VECTOR, 1);
+	device->driver.msi = MSI_VECTOR;
+
 	device->driver.max_memcpy_size = 1 << 20;
 	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;
 
@@ -1728,8 +1881,14 @@ static void mlx5st_remove(struct vfio_pci_device *device)
 {
 	struct mlx5st_device *dev = to_mlx5st(device);
 
+	vfio_pci_msix_disable(device);
 	mlx5st_teardown_datapath(dev);
 
+	if (dev->have_msi_eq) {
+		mlx5st_destroy_msi_eq(dev);
+		dev->have_msi_eq = false;
+	}
+
 	dev_dbg(device, "teardown: destroy_mkey\n");
 	if (dev->mkey_index) {
 		mlx5st_destroy_mkey(dev);
@@ -1757,5 +1916,5 @@ struct vfio_pci_driver_ops mlx5st_ops = {
 	.remove = mlx5st_remove,
 	.memcpy_start = mlx5st_memcpy_start,
 	.memcpy_wait = mlx5st_memcpy_wait,
-	.send_msi = NULL,
+	.send_msi = mlx5st_send_msi,
 };
diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
index a2506ec8a19523..2c451e411ec13f 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
@@ -80,6 +80,9 @@ struct mlx5st_dbrec {
 #define MLX5_BF_OFFSET 0x800
 #define MLX5_BF_SIZE 0x100
 
+/* CQ doorbell offset within UAR page */
+#define MLX5_CQ_DOORBELL_OFFSET 0x20
+
 /* EQ doorbell offset within UAR page */
 #define MLX5_EQ_DOORBELL_OFFSET 0x40
 
@@ -94,6 +97,9 @@ struct mlx5st_dbrec {
 #define LOG_CQ_SIZE 4
 #define EQ_NENT 64
 #define LOG_EQ_SIZE 6
+#define MSI_EQ_NENT 16
+#define LOG_MSI_EQ_SIZE 4
+#define MSI_VECTOR 0
 
 #define MAX_FW_PAGES 8192
 #define MAX_FW_PAGES_PER_CMD 512
-- 
2.43.0


