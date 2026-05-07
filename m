Return-Path: <linux-rdma+bounces-20128-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIj4NDRj/GkqPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20128-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:02:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2E4E66C1
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3120F302D22B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CB3CAE7F;
	Thu,  7 May 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tk5fF3da"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901B3CAE8F;
	Thu,  7 May 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147949; cv=fail; b=Ac82kvbn0KvjZwrfmJvuq9pKJub3clmnmwAkO3NEGi4amXO+6zcck5ilkj0F/eH1/bFphBKusdI8LmhiSB9N8lm4AnOmfz4f/WrJSGrpSqVq+ohtc/G3dbY3zJsPUeao1gEPU6qNZ4fbs2xPbtn65ZA7kCGW0FVtZ92jQMAAAkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147949; c=relaxed/simple;
	bh=YoAiQm8qnvurQTf6xLlskb0IzAxcxySP9zbvmteMFrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9irIJupHflFlZULB87ExAuIrA0oRA8EPs1LlFyQBOpG2dZHXnclL/+I61Hc+CVZnBZTr43L5Q54t0r3g8OrV8qav4aytPC0QjvqrjjG8M+wlVYVx1V/YmuWStEN8+mxTnPKB9hXlhl2Hjd7lvPpeu77nR1qJdHpdbRUhUzW0OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tk5fF3da; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBYcxl25xCfNXEbEgNhjfL3eiKX6weZUco3sosHcqv0Ll/zU7Cx5ylxFbLvposUceIe14D6/ALEo3qPnx0ayKdzcX+OFoQcDc4VIvlRXkRm6FtMtG9cksoF2UVkDj03KORoRyo8/wiAWm1Blp7MBZNOfNoZTlZpkOndIiOABI+bUCptfD9PEruw8M//VG2fU4dwUldFIZ5NxIy70mIdAp6Y4EGo0qNcP1AGULEev57//kaPHJnmQwHuSWCcYDwuuVT46QW5ar6oPD16+od00GjDCwl6oh5gDu1zv94EIuQCUhYRUOf5Q9fRWXrDNwdQoS4yBcHDS9h2vEM1qmOgP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kltNRXgInBxqk1HPYetKd2+ZuJMekNBebRwOPUqaHq4=;
 b=G43wnjaN4HHjOqQ4kF//1+tVUpuCtVTZi/THwEudT4bcRzoIQybXPKzalvByykiNnV7u+KaBR7Pn0YHEsFbDogE6IlFpG5wLSNV9no6f8BGP7v7uDDg4xiKLRFYRqFr9BcgPydkRJn+i8ue/yd5WcQPlgPcjGIYt9NkfGB6gGrIFbnNDrZgUdn4c4oAKMkdI8i4IP9XSIMsrUTu0qwkrVBXGAUTDrH/nLhorgj5owB1cATv+1XNrH3hUfdDv/INuDB0VElMKX/sJzMvhatOV8vUHkxD4kieBuTEbCSwgL49T4ky3rV/RhV5QAgp69xC7cJTDvoy78PN5MOUUiXSIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kltNRXgInBxqk1HPYetKd2+ZuJMekNBebRwOPUqaHq4=;
 b=Tk5fF3daQFzs3IcUvXu8cqXOesrYRm8B3j691k/wBvl4G7FQoslyfg0rqBOIwvw0Ntr0mk7SozSctvvouZgET0OPw5nbg9dB21LK5K+0SDIicACZzz0IJVyDEdmXlMHnBcJEtvLxKKLUwzqZSf75Ms4sxWleTKy084BI4wSAC5/XnLYcohPR5EixPw/kGw+X/9x675b2gEhz+eyl2sRT5qh0tAMtFNojsvNc5FV+mjs3wEI5sAK79mv3C+Uwv5l5n8ErCaselbtRkcO9WfuYLgkKR8XkNJR5AAlylNhJQXrgWAg8S2a3tD3pXivRUq7LL/g9g2AxyORpINX92Zn4KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:59:01 +0000
Received: from BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df]) by BL1PR12MB5873.namprd12.prod.outlook.com
 ([fe80::e8aa:dc7d:992f:93df%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 09:59:01 +0000
Message-ID: <b5c0f27f-de47-46b1-a53a-b0755dd128f2@nvidia.com>
Date: Thu, 7 May 2026 12:58:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: Fix HWS L2-to-L3 tunnel reformat release
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260504221920.48685-1-prathameshdeshpande7@gmail.com>
 <1ecb87f1-fcae-47bb-ad83-7bf2ec807463@intel.com>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <1ecb87f1-fcae-47bb-ad83-7bf2ec807463@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5873:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cadf734-139a-4076-e095-08deac1f4387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Vmo8cBPiDulYIy0pPXOc9+8xAq1I1v5ylqWVv3TFNA+4N54tFty+8qgXimfK+3ZWl8uQ0eHKxeptuk+8PvHHfBWbvmFkdIUyB9CyCzZhXPuKRXAyDwYl9ojgmoBY2zRjILPYbeK9Ux3NQHholAyqhZaJMQzaz7gt01yC/d9oR8E36PvrXrx+cEjt7TiqHHPb+WG/8FRMc02gbPyfdcu/yrjj1GkKmKdkj+TcyJdSmtKSpAJ/3nNiralz74sNbJG6l1l98zpWf8aYB0atQROr5juDb/PbYYM8iAG6UdWoJLzQ/I585zFiky4U+cjMoCxF6GUWjqucsF+HJ7RmfrGmje96b7bcFRz3dWHfDXCoyTAcrcrMV5v43cJg6tA796NOOwVPt3YGyks44t+8p5fNLBJmUMPBvifeCXOCTNaE9Zrg4+um7TyQJiMN5luW37IOGTrRkweY9iFN658U3nyokfJE4QfJCvPnUF4uyTni9g4ojQDzVZNa/e5Eh9k1b4Uwo/DFFv/MkIoofJOLgdjYdO3mcHLy8zspeUOME1eG4HTxnWh1qVlJc1WfF0HUog4gXqRNFehwGd6Iiz5ydjzgBPbwQt8YaTgaXAECaAT+65CNPXRYNuyGFL4BbUxxpzQKSI4e9F8XqXg1m285g10a7wp9dbHbcAc+T3G4Fv/hP9AS+a11p9LTzevwWrPFK/9r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWVoSTFMOHM5ZGg2UGpSbXBNTU9FYm5BMGY4cFZkWjRUWFBiMHBHcWVZTGJT?=
 =?utf-8?B?R1o0M1lHMmxhdlMxdzc4blFmMlo5aXJCNU5SS3BBL3NHcTdGOTFtOU1IQkdq?=
 =?utf-8?B?dGVmVTZmamRORW91MzdPbzJJVHBSSFFDR1RDYXZHWUxYa0FPam9sOEJBN1Mx?=
 =?utf-8?B?VmhVSk1zNDF5dHl3MFRzUTZuQVhILzNsaHdCOVB0ekQyMzRiaENMWFZlc2Nq?=
 =?utf-8?B?TXdPUkJ3UXBkbmtPbUZRNHVHYTdVQlE4amQyNEZTMEVZdVlzVGRZZU1CdVA2?=
 =?utf-8?B?T01ucUdhQUpWYVFZTzB3bUk2dWFvZ2lIdlVwN1dxcXE0RUc4eThXMzFLL1Yr?=
 =?utf-8?B?K3VVSEQwRjFyaUF2YUlZWkJtenpVallhQlZmRDNBNXovQkVoYnlYL3RuelY3?=
 =?utf-8?B?Q3dPQ2FINkU1Zk9kYVNQcCtDL1BUNkZ6SG5tZ1F4UExFb1pXWEQwSSt4QjF0?=
 =?utf-8?B?anEwa0dtUW9EakpoTVR0Yy9wWFprRTAvdDVGRmpIL1BBdmxWbzVjQlJwWWY4?=
 =?utf-8?B?eHk3dFBlZ0Y3dElBR3dZR20zRXVRZXlOd3dIUGdMQi9jZWdLdGJMa2w5TDV6?=
 =?utf-8?B?S3VweEE0NmhsOW1jeWtqSUpxUnNpVmpXM2NXVEpmY0EzSC9MUDVqQkttS3V5?=
 =?utf-8?B?ZUtiYkdPZWw3V05QQzdsZ0dWNWw4NlBnNE9aUmwzU1BTNHhrSnN1a0pYMld4?=
 =?utf-8?B?N3VQWXkvRXkwc3hRRFJlNzVaRTFWV0ZnZExTZWV6dGRUbjFTSmUrcXE2d1Zw?=
 =?utf-8?B?V0F2WURjYmRUSS9Oamg5eFFRWXhpODA4WkFqUWNZcHdQS3prdFZtbU5mMytq?=
 =?utf-8?B?VHA5L1JRbnJ0Ky9NOEFndFNPQjBqTENIY3B0aVJNMC9CWDFjTmxMaUxLdEZN?=
 =?utf-8?B?YjhVK2VtTHNrckV0alJFQmIyQXBxNjl6Q3dSYnFJbFRWVFlKRU1Fc1kzejNH?=
 =?utf-8?B?Z3NKeGNLOHhWaXg5SUhxOExldU0yd2Jad1BPYWQ1eVF1RlBrMk5ncEF5cXJk?=
 =?utf-8?B?VmpaT3NlT1hpVDJTaTVzeENuRmRZYmxlZHNCM21GVVkxUUs3OXVnWnJ1Wkxi?=
 =?utf-8?B?anVqcnAyY0hmaUNhdUxBVXFJZzQ2OHJLRjlyZlZnL25XSjFKMmdhbmlPOXpk?=
 =?utf-8?B?ZDJrUE9kWWJSR3k4aFk1WFpZY3UwRkR4RlR0U1JmVVZzWml2N1Z2SHhJNUxz?=
 =?utf-8?B?WER6UUoxYytDR3RZU1graUFpbytQMVkxd1ZmVmVJOHljYmpZdjRCZU9hZHZM?=
 =?utf-8?B?cjFIMUp2UUtDRGxEZlppTHBXaGo4b28vbEZMSG9kOG1TNWFKajVLRjk2c3Yv?=
 =?utf-8?B?UEk5LzBYM0tBdk9WeVc0eUxMYVIzVlYxMXkzKzhmUk1NZ3QyKzRpRm5VS293?=
 =?utf-8?B?SVpOZGZnbHc2YWlQZm5NVVhhRVdNL0lzY01McUFhelRpaUxERWQzUFF6Wk1h?=
 =?utf-8?B?L2J1ZHZjNGoycWtidDlWRzBzNzVHU1R5b1dwQ2hXQ3M5YzlnNWxsSUNSc0hj?=
 =?utf-8?B?ekE0RzVYRVZxd0pTTmZUa25Gbjc4bG1aRlNKbnBBNFZYMFlISitwQzczbzJY?=
 =?utf-8?B?Z2FUTmlqb0dTa21FVjltbmsrc2I4UHRXNklmSGdFQ3N1TFZ4RkpqNHY2UDl2?=
 =?utf-8?B?MDBiMFA4NHpEV1AvcVFvQkZzT3N6OGY5aTdqMUwzQTJOMlR3NzBpSm9mbHdT?=
 =?utf-8?B?RGZxM0dPdi9kVGtvbTJPNFB3Tm9LQlJpcWo2cDNqYTZLdnhPR28yOXlvTk96?=
 =?utf-8?B?TTBObENWMjBsMEk5bG04OVA4Ylc2TzVCaW5SV0FyUHVvRkJPeFUwVksyS0Vq?=
 =?utf-8?B?RUZjZmtYQTBjdFZsSVM4YzdsN0U0Y3h0UlplaGN3Q2tYTGdFMUZLMkM5dlFk?=
 =?utf-8?B?N1ZPdzJRYW50dHhyb05DVCtncTRPeUQrQnFZNGR5ZXFrbnByWXlPTldJWDdh?=
 =?utf-8?B?dmpzM0VqMjEydUdzMnpNaG94b2dvUDJTc3BxNU5CVnYwTlMzTFgzd1l0Umla?=
 =?utf-8?B?bXF3S3RZTXB0SmtMZE9GaFZJeTUyRU12Z1AveDRMZ1BjKzdudnBVSnVGUEVB?=
 =?utf-8?B?K043WVhPZnhsWWljZjl0RCtGaU5tQnRKSmFvK3gwVXZKTEhjdktRUTB1TTlH?=
 =?utf-8?B?QjRweE1qbXNkdGZ4ZFVreUJaTHJ2YnZlLzJXK2dJbnI2Yy90WFlHMUR0eFFI?=
 =?utf-8?B?a2oyb0QxRWR1YUowN0pEbzM3MGpUMGsrd3c0cXZORXFwbHVaUmlrd05OTXFs?=
 =?utf-8?B?c0t2VDRIdE41dFg5Q3JmRXd6RElCRHlWOWdVdWxWZU5MLzhjS3p1amwvN0pN?=
 =?utf-8?B?QnVSdmtJQkpJYWZabkpDNUhoOFUwYmllcFdPODUwUG4rM3o2bGlpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cadf734-139a-4076-e095-08deac1f4387
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:59:01.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ2qQOcoLb9Zc18IF8eOyo6q9trRdQEbrzslTAXwziOE0gbC8mzSGIckktgN1GpCBAITRy/UP7shZQKPCfBKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Rspamd-Queue-Id: 14F2E4E66C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20128-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kliteyn@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 05-May-26 19:26, Alexander Lobakin wrote:
> From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> Date: Mon,  4 May 2026 23:19:17 +0100
> 
>> mlx5_cmd_hws_packet_reformat_alloc() allocates
>> MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL objects from el2tol3tnl_pools with
>> MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3.
>>
>> The deallocation path uses el2tol2tnl_pools with
>> MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2 instead. This releases the
>> packet-reformat entry through the wrong pool, corrupting pool accounting
>> and potentially moving the bulk entry onto the wrong pool list.
>>
>> Use the matching L2-to-L3 tunnel pool and action type when releasing the
>> object.
>>
>> Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
>> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>

>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks,
> Olek


