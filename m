Return-Path: <linux-rdma+bounces-17047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEvVAlVDm2ljxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-17047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 18:56:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5C16FFB6
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA6A3010BB6
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFE3587D7;
	Sun, 22 Feb 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fP7jCXNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C23F9C0;
	Sun, 22 Feb 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771782988; cv=fail; b=cuo2JagQi5fJiGhDEXuRDKzmA2n8eTgmd/QY/XpUtfvp0HkV7gFJNGmNiM6u1aqfW5+p9Y59x5dkZuYy6ENZcRNnbdzW7UkLCdHD6UAZmk2CnAK/uTFWXSrVsatjp6/hhmApoCW4C+KCd9s5WpY/EiMR6Du/XAJIEIpcFSgFc+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771782988; c=relaxed/simple;
	bh=9u437kK6xKMxuLbYj1lBypPA5qu77kEi1Vk4IeArC4Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ODHO1iW8Tepif+t7xZc7CJHscny6Gp5BjlD9ypAi4TAKJtjggEInwogO5NOXOkybCjCdk/0tSlBOGs1cH1wKbx8spjihlK4GHADG1W+Mjmh1vtlE1xtePifdZvaeNutiRU+3ZF9CER0c63uv/iPvXyJwmwHfyD+/0Me/fTg6wRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fP7jCXNZ; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGDU2oiw7EdtIzcsSsg7cvutu6wPlr45STLvfMUsHxOAxdHqGrkSiu7+Ts4VWMA0pka/ZzUuQ2e75dyZlfBKGMHa4rOYUQoCuruqhSS4m2Kh4OFetilsZF0R7bkhxYs+9bT2ELJBYmhwDbMb7TcP17PniXHljW1mBnnPXe+oVs+7ZL0E0yKKv6ZNAU09m4U95xOpZRZE1I+gY+fcqwktiZMNTvoN4RAWnrWohog5SjoO5J51nqvgf/wUPyxu+zUwjQnyWbmOBSe1jWZz2Cw4VSy2xIFBHvaCmtX606FtSRTizoDWmRHTiNAfUXhZHbyN9msxgRV86iAMm4oTnQ90wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYuYs7u3tBFLsISZUEVirgg4ZNP1wRisdOPSkgY9igg=;
 b=HveguQoFzVFcecFa52Q2iBrK27agJTYpkvOClKTOk1xDKmm0o4Z6uAKdD3onCjOmtMQkjeDY6qr0vHyFhpSwAntOXeV7cNxrknF020CAiZ8vrgtUTnuVptm+wEmzverAPuWqTvcNjzArOLYSIeMR1Whr59mRxnl/HUWPUSmHMzi9Gg1DUpQAFnNBmifk0i8lXRw4lNGCJ/V3ew7meG/kQHMhyACkM3r1hvRQYrKdqGHRwePdm0rp3gLvKta9kFwwIz53NzxC8+xgyaCGtcvJTWZIT/bK/2+mUnVT8Rjb3zq7LFeoc3E5uSVoR6SK/azwBOV6+q7UXjpOCZr8zFdSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYuYs7u3tBFLsISZUEVirgg4ZNP1wRisdOPSkgY9igg=;
 b=fP7jCXNZZ9wsz7d3X3MLfPKly9eVeoEt3LNotQn64VcmsViQkSZlHFSXdUg1SlZAP/fCGs+h+R8QECRAgk+EiijSAtK3FuAloOCxooyg2c/bYl4zzpZ2hPZ1k/ZrVCtqpGnUCShc8OSuFWpO0q93S3hBHfONueWwMASO7qEvXLfTNzujGB8k/JeH090VtlYq316Eu7GxymS23kmNAF6nhIRaNokbsF0M5bu60Qod8oy7dj67t2hGYKutEGc/ZrieDWVXQIEznbQWpwmSNCU6rexSIEGXXlFqHMtgm38SEKz39Yn4tbromAhjBTo3RU1UpD3NK23ISAmgXWQX2W+60w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 17:56:19 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 17:56:19 +0000
Message-ID: <5a535e5c-80e3-4508-920f-846c90880d70@nvidia.com>
Date: Sun, 22 Feb 2026 19:56:14 +0200
User-Agent: Mozilla Thunderbird
From: Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH rdma-next v3 02/11] IB/core: Introduce FRMR pools
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260202-frmr_pools-v3-0-d4543e82744a@nvidia.com>
 <20260202-frmr_pools-v3-2-d4543e82744a@nvidia.com>
 <72191e37-8f9d-43f8-bd56-493d30719494@nvidia.com>
Content-Language: en-US
In-Reply-To: <72191e37-8f9d-43f8-bd56-493d30719494@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c918fa-a41c-4bb4-046f-08de723bae6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnNid2ZmRXpFWXdhYjBEZG5QKzNxak9WSGlZWTh6V0s3UGF1Ny9sU01IeWRo?=
 =?utf-8?B?TFYwV00rc0lrMEpCbkMyRGczQzdUbjdta1daMVhVU0cxYzBzV1dQYTI3b0l6?=
 =?utf-8?B?YzFRY1hKaFlmQ21JNU9FSmFaWEZSSmk3YmVJeXdTL0ZjZEhoNkt1OEdPczZv?=
 =?utf-8?B?SDFIUEF0SmpOcTk5cEFEalhsUDhET2ZIbUM2RW81b1JVRHRqMXo3aDBCMUpE?=
 =?utf-8?B?R09mNVUwMFo4aWdORmFXZldXc0dsNXZEOW1ESHdJbUo2dXBxYjJJMEwydGFn?=
 =?utf-8?B?UE0zbElNcU5sUFFLMlhhZ3ZrVFR5OExnbXdJSGNQMkR0MzFCWTE0bUZlMC9J?=
 =?utf-8?B?T2NUWW9tamhVa09RdnV4Z3JpcFBEMlRhemlGTUVoQzZjZWl4dDZ5NVpvMU5o?=
 =?utf-8?B?UEFOUnVkcWZqRUZWL2NnM25jMThxMzNONldwUG9PbEgxdFdyeU52ZWVLZFgv?=
 =?utf-8?B?Q1BDOGFiNDk3SnViMTJQYjl5eC84R2lwZUNWd0xtYjQ1OGJCRHFLZWRNeHg4?=
 =?utf-8?B?UVlSc0tqVE5Gc3JSd2YvWjJqNlVtQmgxeHFqWG40bkszUmtZVFUrVFNPSklx?=
 =?utf-8?B?dWxnYURlU3Y1OTRPYVNwQWxENDBuNGZ4U1o2QWZDSEhKMExJOHNhT1dCY1Jp?=
 =?utf-8?B?Tk1vM0pub05PSGo1TktWKzgrZElPYllwZmRyeGMwVFpibUtGbFNyMm9wUHM4?=
 =?utf-8?B?SnY4MlVNY2drUU5KWkcyNHVDY3Bta2V2S011Wk9TVmdUaVd1cHhjUG0xOVhn?=
 =?utf-8?B?T21LRStPdHFNZDhKSGNiUGtTNnJPL1QzeWlQa0Y5SXJiQVRuV2hnSGhJNmdK?=
 =?utf-8?B?cjcxeUVEU2MzOVdGMDhIdUFONkZqQzFwRFVWQ1RFSWptMHNYR3BXRDRsa3RN?=
 =?utf-8?B?MlN4dm5kb2QwbWpNNlZZc0EzY2MyWERYQjVSay9UWmxLdjQwRmhjMldXZHNJ?=
 =?utf-8?B?dnhEU3pzYXlqNUVDQ0ZGb2tHTmNxV2ZTck9WT1FMcWxpQmJ6MTFNRldxNVhB?=
 =?utf-8?B?a2NMSElpRVpWd1JsUWhLZXNQWFE3UVQ5dnIyUVdjb1ZmcDhnWnQ1cDBlQTdo?=
 =?utf-8?B?MC84czNPY0M4clJkdGJjQXJoUUNuQWNDamh1MXIyWDlSQWg3VTdYWk82V09z?=
 =?utf-8?B?UFk0d3ZueFQ3YWdYbFZlbW5kNTZ1NlV4UThaQXozSTNGRTRzbjhKeU82RFRT?=
 =?utf-8?B?OTQwR25qeHYwdXgxRGNkWnJ6VWI2NmpRLytmQ1BYblo2YW1JRU8zdHRFV0VV?=
 =?utf-8?B?M0NtUjY5V3R1dDAya3V6TjRoNHg0Q3h1R3hPQjFsSVQ4YjFMVUkreVl3dUpN?=
 =?utf-8?B?OVFJSVEvSGtSZDYvVXlDZXJKelBVOFdjQlMrY1ZSeGtMeHcxUnNwcGMrTjdP?=
 =?utf-8?B?UjhzWWJhWUZzOFlDQWQ1TmY5L1hzL3VsUnZPSXk1ME9TOThuSVprYW1qbFk1?=
 =?utf-8?B?a2xsYWZHbDFHcEFKRStRUzAxUTJsTktQUHhLalU5Y1h6Zlc0QzU3ZWtnNUJC?=
 =?utf-8?B?TnBkdFdVdTU3OC9VOWR3QUw3UjJoV2tYeUg5L2VFbm1ESStkVXBELy9kU2gx?=
 =?utf-8?B?KytVNGY4ZXlSb1lOWTZkYzZkN0ZmNGQzZzlJUGNNOThhUzVIazJ6ZC96M3J2?=
 =?utf-8?B?em5qcml6TmV2Vi82M0xrUFBKSFhnVjJ3UWJQa1RGcHNTdnVTY2hUY3pWN0pM?=
 =?utf-8?B?L2VxMExCNG1PUmFac2hDaG5ZVzdvcFlOS2JRMERJM0RwK0hpQUpTbVhWQS80?=
 =?utf-8?B?a1NtSlBBd0RUT2JhUUpjZXUrR0MxK3hpTDE3ZHYzRDlhb3g2SmJxMTJZUEVu?=
 =?utf-8?B?VUFvNjJtZGk5SzhrSFdyUkEvYzNrOWlvNUhRK0ZGQ0dnMUl1WTN1dWdadmJ5?=
 =?utf-8?B?YzVkVERDcUwyejlKU1ZQVTZIQ3R2NGwrcU1mdmNNK3FGbmdTM0pMQWtGTU5J?=
 =?utf-8?B?N3VQM1NkV0Jmc0xXSkVsODExSjVoWWFJNjVCRFUrS3p5Q0FZdHByREFueXNi?=
 =?utf-8?B?QkR4WjZhaW5IeWh1czNPQ0ZzOC9ib3JDSmdDclBZTGZLQ0J2TEtIL3VXOWto?=
 =?utf-8?B?RUFNenFJWFB6MUJWUXR2ZHFNVDZPRDNSWVBzQnFNMjFsWEdxbGZSUit2ckFB?=
 =?utf-8?B?S1Q1am5sc1REb3pQdGNkTGtyUFczWDUyRWQxMVZSZjh0REpVeHhiODNBN3dM?=
 =?utf-8?B?S3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enB2Zi84S29jY3cxVXJBZFBaUU8yZ2RVYm9xWXA4VFJVMDYvM3lwQlRua0Iw?=
 =?utf-8?B?LzduaGdnNzJXZkpMSFJVYzA1eXp2TXIzNGNBSFVwMERVeUxWc3NvcHN6eE1B?=
 =?utf-8?B?TVVzdTI3TmdXKzY4UEJESFVudExUb0oxTDkyS0xTMXphby85YjZ5aHhmbk5l?=
 =?utf-8?B?WlAvdmcyR0tCVGwxOGIzajFacEdwRFEybTg4ekdxRHNGUk5oOGpZTndpdXdV?=
 =?utf-8?B?VXY3ZGRxcUhCbk9kNDF6UUlUWFRLRzJ0elFaSlYycllWVXZIaU5SVUpicWFo?=
 =?utf-8?B?L3lScmRKVHRjbEQyaTgyelBTWXlWdnV1SXhWVUVKYmdXT01zU3Y2OHdVUzRY?=
 =?utf-8?B?d1o0cmJkMGZvYnZaeHhNVXQzdHkvdzA2a3VQTXlwWFlIb1hESmk2Nk83dU5Y?=
 =?utf-8?B?WTNudHp6MC9DdjF0VkxSOE5mOHhpMG5pTXNHTFVTZDhVYlF1czI2L3paYlA0?=
 =?utf-8?B?ZE5vZVNsRWkzemV0OTlzZnRTYlQ4REJUZlRLUjJqV3FZMmF0WU9xdWFMSCth?=
 =?utf-8?B?ejhXaVZISTVSc09TbmoxeGhuQlV3YjBKeU5pRzVpb1ZYMW5pRTlJUUNmS2Nu?=
 =?utf-8?B?VTQ0TXJzMm5qZzQyUmZ3R0pjNkJjY2NzSVQ4Q25jdWg5NDAxM3NRM3IraUs2?=
 =?utf-8?B?VVFxd3czL2FwWDJoWEkvU0VBVWpLYW9rdEh4VjdQdXFCUzU4bnQ1VXdqdVZY?=
 =?utf-8?B?a3ZvTy9tZHJ0QndINDIyaitUOU1XMmpRSllSOVVTd1ZPajFUMWFKbEovelRF?=
 =?utf-8?B?WUZPTnBramlHNWlhQlY4alB3NHRoQStTOXA1TUdFbTV4dlJXNVZZYzJIaTlV?=
 =?utf-8?B?NlhuTW4raUpkQjRnbG5oNUFSZURBOE4zUEFXVFBNMmNsaGlmMGpDKy9rOWFv?=
 =?utf-8?B?SFp2QllYYnF6aXBRZkxuLzhmelQ5UHcwUXIva2pzcmhxeDVEcElrZGN0T0o4?=
 =?utf-8?B?UVJFOTdNdWx1YnBtT0pRYVlWdEFsU2xHQUtuOGhKNjBjNGUxbjlLd1k1bDBs?=
 =?utf-8?B?dGwySGduYW9mNXd6bDlwam1hMGtvZ25GMnA4eEd0UTYvRGp1OFZrYXdOZnJl?=
 =?utf-8?B?YkJmU3Uxd3cvVWJDeWxmZ25zWndQZmVwMTJNY0JVQnExSS9LZUlnOXVsMDZJ?=
 =?utf-8?B?OXIya2UxWXJSZElibGwrK2NFS29PN0pNdHRnY296ZFVaa3ZFNkJUb25DTk9m?=
 =?utf-8?B?TVJuUWRLbjA3NUdQaG0xVm9EV0M3elhUMk5wNzBDcVNZOGxQN0FhMDFTYW5y?=
 =?utf-8?B?YmQxZ0E1S0h6S2ZOK25oWmlwUEhabVFmdmVIZWZacDdYdXVEYnQ5alRJc0xO?=
 =?utf-8?B?bUJFNVZ5OFRXc0lzck5OTFhHSDBnWldHczR0cWZ0czZsSENzbkk4cWhNdWVM?=
 =?utf-8?B?N3ZoSU1oY01DLzhBZ01YT3RjVm55UmtHQ2VSWDQ2L3F3VkRyNWcvdTlzcmkw?=
 =?utf-8?B?MnJwU0ZvaGVZZFQ0Nk5oZTM2OVQzYVlZNXM0dTcyMDRoek80WG1PdEl3ZlF0?=
 =?utf-8?B?N1Zra2RBZEZvWmhyOFczTFR4MVc2T1ZxL0xXNHpWL2VoZjI5RHNrT0w4VzBW?=
 =?utf-8?B?eDUzZ0JETnFEL045WGpFcGM0QmpadU9NQndKaTRleVdoazdJT0dRYXpWMmNp?=
 =?utf-8?B?Y3ZTbFgxQ1VYZHE2SHVIWWRyaVYxZDFId2sxWTgwMllzYThFNnZYcWRaQi9I?=
 =?utf-8?B?Ty9Ka2dSMS9FanRoWGd6VHVnTjRITlBZMGtsYzh6YjQyTjAvTUdGeDJKOUpv?=
 =?utf-8?B?VzViT2lZQ1E0cTB5QzVFNC9NVDJLdTFibXAvTFZPRjIrdmpvd2Q1TEd1SjNz?=
 =?utf-8?B?U1dMZHkzRzlXRld0OGxDUFc3NkFIM3k0MVBqcjJxMm9VcUZXejJxTjNTOFRM?=
 =?utf-8?B?c2JkN1JMcHhpc3pRVnpJZWdEOVVGRG9MeFNUSlBiaEh0akNmR091NmkxeXdh?=
 =?utf-8?B?SDFUR2pHbGJMdTArNzFHZ2tCNTEzZ2gzRFVoTFppc2Jwa3JsM1pNV0FkQVhv?=
 =?utf-8?B?NTM5ajd4MXdCc3BZSFcxNnJpYnVGNm5HMm5xM1BwVE9jMjZlekRPTVI2Q0hK?=
 =?utf-8?B?eUlmL1RaYUY2OXd4ditKUUlrNDFCQWZxMG96VDQ0cjhBSE9NSjhScXhNM2Jh?=
 =?utf-8?B?U2QvMDBaRVJSYnhWdDg3d3RnbHdGbEhocncvb2hMbFpkKytTaTFrREZKY2hJ?=
 =?utf-8?B?S2VHYkFKM3JJZDdtYld0QVRGUWJvZlBZa1ZJZFc2S3prK211eVJXNDVzeVNS?=
 =?utf-8?B?YU1RTzZiMUtjTTlvYThjWUVhZm5UeDFpNFJzVVJoZjVtb1I2OU96UzBRc1dk?=
 =?utf-8?B?K0s1NFUwQjdnZUVOdXcwWXRRZFp5YU5qZ1RYV0JCM0t3MUtmR0VMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c918fa-a41c-4bb4-046f-08de723bae6c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 17:56:19.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+P8RKP1Yw2uviSgQ1tbhHD4HwOZzF5eKN59GgRdmr2op2AmZEXwPKGjNfKAjMy8WrbHT5U0aXWFPT/4OL+9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17047-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 57B5C16FFB6
X-Rspamd-Action: no action



On 2/22/2026 7:39 PM, Edward Srouji wrote:
> 
> On 2/2/2026 5:31 PM, Edward Srouji wrote:
>> From: Michael Guralnik <michaelgur@nvidia.com>
>>
>> Add a generic Fast Registration Memory Region pools mechanism to allow
>> drivers to optimize memory registration performance.
>> Drivers that have the ability to reuse MRs or their underlying HW
>> objects can take advantage of the mechanism to keep a 'handle' for those
>> objects and use them upon user request.
>> We assume that to achieve this goal a driver and its HW should implement
>> a modify operation for the MRs that is able to at least clear and set the
>> MRs and in more advanced implementations also support changing a subset
>> of the MRs properties.
>>
>> The mechanism is built using an RB-tree consisting of pools, each pool
>> represents a set of MR properties that are shared by all of the MRs
>> residing in the pool and are unmodifiable by the vendor driver or HW.
>>
>> The exposed API from ib_core to the driver has 4 operations:
>> Init and cleanup - handles data structs and locks for the pools.
>> Push and pop - store and retrieve 'handle' for a memory registration
>> or deregistrations request.
>>
>> The FRMR pools mechanism implements the logic to search the RB-tree for
>> a pool with matching properties and create a new one when needed and
>> requires the driver to implement creation and destruction of a 'handle'
>> when pool is empty or a handle is requested or is being destroyed.
>>
>> Later patch will introduce Netlink API to interact with the FRMR pools
>> mechanism to allow users to both configure and track its usage.
>> A vendor wishing to configure FRMR pool without exposing it or without
>> exposing internal MR properties to users, should use the
>> kernel_vendor_key field in the pools key. This can be useful in a few
>> cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
>> property that the user registering the memory might not be aware of.
>>
>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>> ---
>>   drivers/infiniband/core/Makefile     |   2 +-
>>   drivers/infiniband/core/frmr_pools.c | 323 +++++++++++++++++++++++++ 
>> ++++++++++
>>   drivers/infiniband/core/frmr_pools.h |  48 ++++++
>>   include/rdma/frmr_pools.h            |  37 ++++
>>   include/rdma/ib_verbs.h              |   8 +
>>   5 files changed, 417 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/ 
>> core/Makefile
>> index f483e0c12444..7089a982b876 100644
>> --- a/drivers/infiniband/core/Makefile
>> +++ b/drivers/infiniband/core/Makefile
>> @@ -12,7 +12,7 @@ ib_core-y :=            packer.o ud_header.o verbs.o 
>> cq.o rw.o sysfs.o \
>>                   roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>>                   multicast.o mad.o smi.o agent.o mad_rmpp.o \
>>                   nldev.o restrack.o counters.o ib_core_uverbs.o \
>> -                trace.o lag.o
>> +                trace.o lag.o frmr_pools.o
>>   ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
>>   ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
>> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/ 
>> infiniband/core/frmr_pools.c
>> new file mode 100644
>> index 000000000000..eae15894a3b2
>> --- /dev/null
>> +++ b/drivers/infiniband/core/frmr_pools.c
>> @@ -0,0 +1,323 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/slab.h>
>> +#include <linux/rbtree.h>
>> +#include <linux/sort.h>
>> +#include <linux/spinlock.h>
>> +#include <rdma/ib_verbs.h>
>> +
>> +#include "frmr_pools.h"
>> +
>> +static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 
>> handle)
>> +{
>> +    u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
>> +    struct frmr_handles_page *page;
>> +
>> +    if (queue->ci >= queue->num_pages * NUM_HANDLES_PER_PAGE) {
>> +        page = kzalloc(sizeof(*page), GFP_ATOMIC);
>> +        if (!page)
>> +            return -ENOMEM;
>> +        queue->num_pages++;
>> +        list_add_tail(&page->list, &queue->pages_list);
>> +    } else {
>> +        page = list_last_entry(&queue->pages_list,
>> +                       struct frmr_handles_page, list);
>> +    }
>> +
>> +    page->handles[tmp] = handle;
>> +    queue->ci++;
>> +    return 0;
>> +}
>> +
>> +static u32 pop_handle_from_queue_locked(struct frmr_queue *queue)
>> +{
>> +    u32 tmp = (queue->ci - 1) % NUM_HANDLES_PER_PAGE;
>> +    struct frmr_handles_page *page;
>> +    u32 handle;
>> +
>> +    page = list_last_entry(&queue->pages_list, struct frmr_handles_page,
>> +                   list);
>> +    handle = page->handles[tmp];
>> +    queue->ci--;
>> +
>> +    if (!tmp) {
>> +        list_del(&page->list);
>> +        queue->num_pages--;
>> +        kfree(page);
>> +    }
>> +
>> +    return handle;
>> +}
>> +
>> +static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
>> +                  struct frmr_queue *queue,
>> +                  struct frmr_handles_page **page, u32 *count)
>> +{
>> +    spin_lock(&pool->lock);
>> +    if (list_empty(&queue->pages_list)) {
>> +        spin_unlock(&pool->lock);
>> +        return false;
>> +    }
>> +
>> +    *page = list_first_entry(&queue->pages_list, struct 
>> frmr_handles_page,
>> +                 list);
>> +    list_del(&(*page)->list);
>> +    queue->num_pages--;
>> +
>> +    /* If this is the last page, count may be less than
>> +     * NUM_HANDLES_PER_PAGE.
>> +     */
>> +    if (queue->ci >= NUM_HANDLES_PER_PAGE)
>> +        *count = NUM_HANDLES_PER_PAGE;
>> +    else
>> +        *count = queue->ci;
>> +
>> +    queue->ci -= *count;
>> +    spin_unlock(&pool->lock);
>> +    return true;
>> +}
>> +
>> +static void destroy_frmr_pool(struct ib_device *device,
>> +                  struct ib_frmr_pool *pool)
>> +{
>> +    struct ib_frmr_pools *pools = device->frmr_pools;
>> +    struct frmr_handles_page *page;
>> +    u32 count;
>> +
>> +    while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
>> +        pools->pool_ops->destroy_frmrs(device, page->handles, count);
>> +        kfree(page);
>> +    }
>> +
>> +    rb_erase(&pool->node, &pools->rb_root);
>> +    kfree(pool);
>> +}
>> +
>> +/*
>> + * Initialize the FRMR pools for a device.
>> + *
>> + * @device: The device to initialize the FRMR pools for.
>> + * @pool_ops: The pool operations to use.
>> + *
>> + * Returns 0 on success, negative error code on failure.
>> + */
>> +int ib_frmr_pools_init(struct ib_device *device,
>> +               const struct ib_frmr_pool_ops *pool_ops)
>> +{
>> +    struct ib_frmr_pools *pools;
>> +
>> +    pools = kzalloc(sizeof(*pools), GFP_KERNEL);
>> +    if (!pools)
>> +        return -ENOMEM;
>> +
>> +    pools->rb_root = RB_ROOT;
>> +    rwlock_init(&pools->rb_lock);
>> +    pools->pool_ops = pool_ops;
>> +
>> +    device->frmr_pools = pools;
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(ib_frmr_pools_init);
>> +
>> +/*
>> + * Clean up the FRMR pools for a device.
>> + *
>> + * @device: The device to clean up the FRMR pools for.
>> + *
>> + * Call cleanup only after all FRMR handles have been pushed back to 
>> the pool
>> + * and no other FRMR operations are allowed to run in parallel.
>> + * Ensuring this allows us to save synchronization overhead in pop 
>> and push
>> + * operations.
>> + */
>> +void ib_frmr_pools_cleanup(struct ib_device *device)
>> +{
>> +    struct ib_frmr_pools *pools = device->frmr_pools;
>> +    struct rb_node *node = rb_first(&pools->rb_root);
>> +    struct ib_frmr_pool *pool;
>> +
>> +    while (node) {
>> +        struct rb_node *next = rb_next(node);
>> +
>> +        pool = rb_entry(node, struct ib_frmr_pool, node);
>> +        destroy_frmr_pool(device, pool);
>> +        node = next;
>> +    }
>> +
>> +    kfree(pools);
>> +    device->frmr_pools = NULL;
>> +}
>> +EXPORT_SYMBOL(ib_frmr_pools_cleanup);
>> +
>> +static inline int compare_keys(struct ib_frmr_key *key1,
>> +                   struct ib_frmr_key *key2)
>> +{
>> +    int res;
>> +
>> +    res = cmp_int(key1->ats, key2->ats);
>> +    if (res)
>> +        return res;
>> +
>> +    res = cmp_int(key1->access_flags, key2->access_flags);
>> +    if (res)
>> +        return res;
>> +
>> +    res = cmp_int(key1->vendor_key, key2->vendor_key);
>> +    if (res)
>> +        return res;
>> +
>> +    res = cmp_int(key1->kernel_vendor_key, key2->kernel_vendor_key);
>> +    if (res)
>> +        return res;
>> +
>> +    /*
>> +     * allow using handles that support more DMA blocks, up to twice the
>> +     * requested number
>> +     */
>> +    res = cmp_int(key1->num_dma_blocks, key2->num_dma_blocks);
>> +    if (res > 0) {
>> +        if (key1->num_dma_blocks - key2->num_dma_blocks <
>> +            key2->num_dma_blocks)
>> +            return 0;
>> +    }
>> +
>> +    return res;
>> +}
>> +
>> +static int frmr_pool_cmp_find(const void *key, const struct rb_node 
>> *node)
>> +{
>> +    struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, 
>> node);
>> +
>> +    return compare_keys(&pool->key, (struct ib_frmr_key *)key);
>> +}
>> +
>> +static int frmr_pool_cmp_add(struct rb_node *new, const struct 
>> rb_node *node)
>> +{
>> +    struct ib_frmr_pool *new_pool =
>> +        rb_entry(new, struct ib_frmr_pool, node);
>> +    struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, 
>> node);
>> +
>> +    return compare_keys(&pool->key, &new_pool->key);
>> +}
>> +
>> +static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools 
>> *pools,
>> +                          struct ib_frmr_key *key)
>> +{
>> +    struct ib_frmr_pool *pool;
>> +    struct rb_node *node;
>> +
>> +    /* find operation is done under read lock for performance reasons.
>> +     * The case of threads failing to find the same pool and creating it
>> +     * is handled by the create_frmr_pool function.
>> +     */
>> +    read_lock(&pools->rb_lock);
>> +    node = rb_find(key, &pools->rb_root, frmr_pool_cmp_find);
>> +    pool = rb_entry_safe(node, struct ib_frmr_pool, node);
>> +    read_unlock(&pools->rb_lock);
>> +
>> +    return pool;
>> +}
>> +
>> +static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
>> +                         struct ib_frmr_key *key)
>> +{
>> +    struct ib_frmr_pools *pools = device->frmr_pools;
>> +    struct ib_frmr_pool *pool;
>> +    struct rb_node *existing;
>> +
>> +    pool = kzalloc(sizeof(*pool), GFP_KERNEL);
>> +    if (!pool)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    memcpy(&pool->key, key, sizeof(*key));
>> +    INIT_LIST_HEAD(&pool->queue.pages_list);
>> +    spin_lock_init(&pool->lock);
>> +
>> +    write_lock(&pools->rb_lock);
>> +    existing = rb_find_add(&pool->node, &pools->rb_root, 
>> frmr_pool_cmp_add);
>> +    write_unlock(&pools->rb_lock);
>> +
>> +    /* If a different thread has already created the pool, return it.
>> +     * The insert operation is done under the write lock so we are sure
>> +     * that the pool is not inserted twice.
>> +     */
>> +    if (existing) {
>> +        kfree(pool);
>> +        return rb_entry(existing, struct ib_frmr_pool, node);
>> +    }
>> +
>> +    return pool;
>> +}
>> +
>> +static int get_frmr_from_pool(struct ib_device *device,
>> +                  struct ib_frmr_pool *pool, struct ib_mr *mr)
>> +{
>> +    struct ib_frmr_pools *pools = device->frmr_pools;
>> +    u32 handle;
>> +    int err;
>> +
>> +    spin_lock(&pool->lock);
>> +    if (pool->queue.ci == 0) {
>> +        spin_unlock(&pool->lock);
>> +        err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
>> +                            1);
>> +        if (err)
>> +            return err;
>> +    } else {
>> +        handle = pop_handle_from_queue_locked(&pool->queue);
>> +        spin_unlock(&pool->lock);
>> +    }
>> +
>> +    mr->frmr.pool = pool;
>> +    mr->frmr.handle = handle;
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Pop an FRMR handle from the pool.
>> + *
>> + * @device: The device to pop the FRMR handle from.
>> + * @mr: The MR to pop the FRMR handle from.
>> + *
>> + * Returns 0 on success, negative error code on failure.
>> + */
>> +int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
>> +{
>> +    struct ib_frmr_pools *pools = device->frmr_pools;
>> +    struct ib_frmr_pool *pool;
>> +
>> +    WARN_ON_ONCE(!device->frmr_pools);
>> +    pool = ib_frmr_pool_find(pools, &mr->frmr.key);
>> +    if (!pool) {
>> +        pool = create_frmr_pool(device, &mr->frmr.key);
>> +        if (IS_ERR(pool))
>> +            return PTR_ERR(pool);
>> +    }
>> +
>> +    return get_frmr_from_pool(device, pool, mr);
>> +}
>> +EXPORT_SYMBOL(ib_frmr_pool_pop);
>> +
>> +/*
>> + * Push an FRMR handle back to the pool.
>> + *
>> + * @device: The device to push the FRMR handle to.
>> + * @mr: The MR containing the FRMR handle to push back to the pool.
>> + *
>> + * Returns 0 on success, negative error code on failure.
>> + */
>> +int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
>> +{
>> +    struct ib_frmr_pool *pool = mr->frmr.pool;
>> +    int ret;
>> +
>> +    spin_lock(&pool->lock);
>> +    ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
>> +    spin_unlock(&pool->lock);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL(ib_frmr_pool_push);
>> diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/ 
>> infiniband/core/frmr_pools.h
>> new file mode 100644
>> index 000000000000..5a4d03b3d86f
>> --- /dev/null
>> +++ b/drivers/infiniband/core/frmr_pools.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only
>> + *
>> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef RDMA_CORE_FRMR_POOLS_H
>> +#define RDMA_CORE_FRMR_POOLS_H
>> +
>> +#include <rdma/frmr_pools.h>
>> +#include <linux/rbtree_types.h>
>> +#include <linux/spinlock_types.h>
>> +#include <linux/types.h>
>> +#include <asm/page.h>
>> +
>> +#define NUM_HANDLES_PER_PAGE \
>> +    ((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
>> +
>> +struct frmr_handles_page {
>> +    struct list_head list;
>> +    u32 handles[NUM_HANDLES_PER_PAGE];
>> +};
>> +
>> +/* FRMR queue holds a list of frmr_handles_page.
>> + * num_pages: number of pages in the queue.
>> + * ci: current index in the handles array across all pages.
>> + */
>> +struct frmr_queue {
>> +    struct list_head pages_list;
>> +    u32 num_pages;
>> +    unsigned long ci;
>> +};
>> +
>> +struct ib_frmr_pool {
>> +    struct rb_node node;
>> +    struct ib_frmr_key key; /* Pool key */
>> +
>> +    /* Protect access to the queue */
>> +    spinlock_t lock;
>> +    struct frmr_queue queue;
>> +};
>> +
>> +struct ib_frmr_pools {
>> +    struct rb_root rb_root;
>> +    rwlock_t rb_lock;
>> +    const struct ib_frmr_pool_ops *pool_ops;
>> +};
>> +
>> +#endif /* RDMA_CORE_FRMR_POOLS_H */
>> diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
>> new file mode 100644
>> index 000000000000..da92ef4d7310
>> --- /dev/null
>> +++ b/include/rdma/frmr_pools.h
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only
>> + *
>> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef FRMR_POOLS_H
>> +#define FRMR_POOLS_H
>> +
>> +#include <linux/types.h>
>> +#include <asm/page.h>
>> +
>> +struct ib_device;
>> +struct ib_mr;
>> +
>> +struct ib_frmr_key {
>> +    u64 vendor_key;
>> +    /* A pool with non-zero kernel_vendor_key is a kernel-only pool. */
>> +    u64 kernel_vendor_key;
>> +    size_t num_dma_blocks;
>> +    int access_flags;
>> +    u8 ats:1;
>> +};
>> +
>> +struct ib_frmr_pool_ops {
>> +    int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key 
>> *key,
>> +                u32 *handles, u32 count);
>> +    void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
>> +                  u32 count);
>> +};
>> +
>> +int ib_frmr_pools_init(struct ib_device *device,
>> +               const struct ib_frmr_pool_ops *pool_ops);
>> +void ib_frmr_pools_cleanup(struct ib_device *device);
>> +int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
>> +int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
>> +
>> +#endif /* FRMR_POOLS_H */
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index 0a85af610b6b..6cc557424e23 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -43,6 +43,7 @@
>>   #include <uapi/rdma/rdma_user_ioctl.h>
>>   #include <uapi/rdma/ib_user_ioctl_verbs.h>
>>   #include <linux/pci-tph.h>
>> +#include <rdma/frmr_pools.h>
>>   #define IB_FW_VERSION_NAME_MAX    ETHTOOL_FWVERS_LEN
>> @@ -1886,6 +1887,11 @@ struct ib_mr {
>>       struct ib_dm      *dm;
>>       struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY 
>> MRs */
>>       struct ib_dmah *dmah;
>> +    struct {
>> +        struct ib_frmr_pool *pool;
>> +        struct ib_frmr_key key;
>> +        u32 handle;
>> +    } frmr;
>>       /*
>>        * Implementation details of the RDMA core, don't use in drivers:
>>        */
>> @@ -2879,6 +2885,8 @@ struct ib_device {
>>       struct list_head subdev_list;
>>       enum rdma_nl_name_assign_type name_assign_type;
>> +
>> +    struct ib_frmr_pools *frmr_pools;
>>   };
>>   static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> 
> A potential NULL pointer dereference was identified in 
> ib_frmr_pools_cleanup() when device->frmr_pools is not initialized. 
> Instead of sending a full v4 of this long series (no review comments 
> have been received on v3 so far), posting the diff change here. The 
> change simplifies the error unwinding and allows calls to FRMR pools 
> cleanup without prior pools initialization. diff --git a/drivers/ 
> infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c 
> index eae15894a3b2..8cecafabda3c 100644 --- a/drivers/infiniband/core/ 
> frmr_pools.c +++ b/drivers/infiniband/core/frmr_pools.c @@ -92,7 +92,6 
> @@ static void destroy_frmr_pool(struct ib_device *device,               
>    kfree(page);         } -       rb_erase(&pool->node, &pools- 
>  >rb_root); kfree(pool);  } @@ -135,16 +134,13 @@ 
> EXPORT_SYMBOL(ib_frmr_pools_init);  void ib_frmr_pools_cleanup(struct 
> ib_device *device)  {         struct ib_frmr_pools *pools = device- 
>  >frmr_pools; -       struct rb_node *node = rb_first(&pools->rb_root); 
> -       struct ib_frmr_pool *pool; +  struct ib_frmr_pool *pool, *next; 
> -       while (node) { -    struct rb_node *next = rb_next(node); +      
>   if (!pools) +      return; -               pool = rb_entry(node, 
> struct ib_frmr_pool, node); +      
>   rbtree_postorder_for_each_entry_safe(pool, next, &pools->rb_root, 
> node)                 destroy_frmr_pool(device, pool); -              
>   node = next; -       }         kfree(pools); device->frmr_pools = NULL;
> 

Fixing my last email as it got HTML-formatted by mistake (sorry for that):

A potential NULL pointer dereference was identified in 
ib_frmr_pools_cleanup() when device->frmr_pools is not initialized.
Instead of sending a full v4 of this long series (no review comments 
have been received on v3 so far), posting the diff change here.

The change simplifies the error unwinding and allows calls to FRMR pools 
cleanup without prior pools initialization.

diff --git a/drivers/infiniband/core/frmr_pools.c 
b/drivers/infiniband/core/frmr_pools.c
index eae15894a3b2..8cecafabda3c 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -92,7 +92,6 @@ static void destroy_frmr_pool(struct ib_device *device,
                 kfree(page);
         }

-       rb_erase(&pool->node, &pools->rb_root);
         kfree(pool);
  }

@@ -135,16 +134,13 @@ EXPORT_SYMBOL(ib_frmr_pools_init);
  void ib_frmr_pools_cleanup(struct ib_device *device)
  {
         struct ib_frmr_pools *pools = device->frmr_pools;
-       struct rb_node *node = rb_first(&pools->rb_root);
-       struct ib_frmr_pool *pool;
+       struct ib_frmr_pool *pool, *next;

-       while (node) {
-               struct rb_node *next = rb_next(node);
+       if (!pools)
+               return;

-               pool = rb_entry(node, struct ib_frmr_pool, node);
+       rbtree_postorder_for_each_entry_safe(pool, next, 
&pools->rb_root, node)
                 destroy_frmr_pool(device, pool);
-               node = next;
-       }

         kfree(pools);
         device->frmr_pools = NULL;
> 


