Return-Path: <linux-rdma+bounces-3747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8492A75B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F3F1F214DD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5C146D4D;
	Mon,  8 Jul 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Z348zQZF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2135.outbound.protection.outlook.com [40.107.101.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483F14532B;
	Mon,  8 Jul 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456314; cv=fail; b=iBaXbUsU1fBQ2NDr5cBPTTABMbTyb6OrO8d9XTh0yirpY1FSmuuLVevoqS72BTtq6Ty+s1+xcAbhnwGhFMRHuk6D7UCfrPiqF5eRgLGpIGWEeatpfgsztSo2pLZQkiEKPy/S7/sZxYbDfnqVUyMnF/aKIL7xu9NEO2ibTYCuxDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456314; c=relaxed/simple;
	bh=mOXHt01+65gRUJLd4zc5QNTWzjc/SHuo1GUwycQqu5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KEp8yM6Ok40IiQmYmVfTvuiqRz9oZ0DuonK0Ury7TTgfLntpccSqKtdZk3j18IddFyPABEXVeCzjH4DEMG5pgrE+wuSZ1TdTfdPrg9i20fB/L5noB2fKh5p4I8Acz9WacJghNxRM5wWYfyx19l/xvEEccPA3BF654Nz7rX/gYw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Z348zQZF; arc=fail smtp.client-ip=40.107.101.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpcaYHs4vECVnyE+HaqpKkYxwDN1GN7OUK2whQpm2eQMtmdBdxE7zrpiyMSd1DxiduiCPuHFXr7Q+3bqvVZFoPAC3obz1DK9BOSQc91XK363r4Yx8ZfgysdVrpwn2zZzNuC1nSEXPwi0aBnKIPrhmoH0BxhPET42xEdPBfCfoZlwkguFSbshaVAiT5+WWAqH/hgAC3f3bsi518yXgfA/k9kYagyWUyv5HHSmvpEjjtL8CkODaSaokrcj3HwHpYZFzGgqIpG3h9yZmDgPiY+bSdJ8jTqFSxllaWZQKVIRVf5Wzw/95i1GNYLeV9A30si9q8OHRXjRs5q3wksIykRHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSPrh0Nh8HYY49iy2oOIn8fulGViSmAws4ObBHGDan4=;
 b=Mu9QnVjreWhKh6OQB8iy2zvEu8iTe0PSd7+qE3kONQI4n2XWUFwwo8wZriJFWDjpmbce2NR3ZxONezihnBQzA8dEBjlPI1sUrrPz4ayxrZ1bCTuCGAVYHBY52X3cmfQ4Q/l2v5sEINPmzDdPtW4s//stTfVN1TCm/oSRDZfg4lAWURK+nK++DP9g+gzgbo7roi07xltuzpKK9dOkeylhZvfIHfqCIDBigGyCrNoc5sUcFrkWb2A3lxuKhMdQW9UzEgqZtWnVd41z4xIAePjhs6bpumyk/IuUIfExQkNq6hYHxxLglPdXlLAwK/ckVBV4Hlq/t0CoX57L0+9wsZkdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSPrh0Nh8HYY49iy2oOIn8fulGViSmAws4ObBHGDan4=;
 b=Z348zQZFRmd/0BBs9hbjPicN6BDm7LOap3l/Foq9VENVkO+MAMUSMFQ9q0viFE93DZJVi5cTQjAIvi2J1w3/Ernkz3uvzcrYDrinUY5Ucq8EzSS4eVrArPCOQy+c77tQ1lJuS6ksQvOujJnPFRiaT8+MbtS2iJlfaK9rFmAfBu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11)
 by DM3PR19MB8360.namprd19.prod.outlook.com (2603:10b6:0:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 16:31:49 +0000
Received: from DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4]) by DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:31:48 +0000
Message-ID: <0daca554-89fe-4926-adb7-d4cd2e855d66@eideticom.com>
Date: Mon, 8 Jul 2024 10:31:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rdma@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Artemy Kovalyov <artemyko@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>, Tejun Heo <tj@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 David Sloan <david.sloan@eideticom.com>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
 <20240704163724.2462161-2-martin.oliveira@eideticom.com>
 <ZobVol_trCwtwjK4@casper.infradead.org>
 <310071c8-04b7-4996-a496-614c2bdb8163@eideticom.com>
 <Zoeew3RMOoUIMHz9@infradead.org>
Content-Language: en-US
From: Martin Oliveira <martin.oliveira@eideticom.com>
In-Reply-To: <Zoeew3RMOoUIMHz9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To DM6PR19MB4248.namprd19.prod.outlook.com
 (2603:10b6:5:2b0::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB4248:EE_|DM3PR19MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edc0890-8072-4ba6-770c-08dc9f6b76e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTdwczBRQ3VLL0VzWWh6YnI1b0FHL3BOb0w2aStlaURudVphL0hwOVNHSkRR?=
 =?utf-8?B?c3R5a1J0SFIwTzlqWjdFalhvaEQzTGxORU5qclQvQjJTdno0andodFFVWmxZ?=
 =?utf-8?B?UWgzTVp5WFgwZjI1S3R3RGJyTWZxUWZjUHB6d2FLclo0SERGdTNCYUxzWFNG?=
 =?utf-8?B?Z2RVZjF3QzBLRFh6MEliUHFlMTc5STF4TGExYWZyZGpOOXV5aU1saDJXZkJS?=
 =?utf-8?B?VHUxYjlXSUlIRVk4VGRBU1MrakZzUjFiSmdxZitieW1ZT21tUSsxcXlvRFJH?=
 =?utf-8?B?UDJTdEpVc0NWUTJ6a2xXdXdiNDRrOENGaklHdU5qVFJSNUlRRDM5OFZjOVl5?=
 =?utf-8?B?SHVIb2xBdCtpMXNqN0loV0FMRnJLNDRDY0JMeEtIVjBZRXlhZW4xc1hCeEsr?=
 =?utf-8?B?UDdlTGRsUmlOQTd3UWNVcnFSdjJ3MlBLNVVCSkVBdGNaenVORDFTUTVaZi9u?=
 =?utf-8?B?dGNUM09pSlMrcC9lNVVpWm5TWDA4QlpidjVrdE4wRGNVSWtOb0tNdTRsSktH?=
 =?utf-8?B?YnRCdVp1UUw4TFFka3kyY2doSDFRQTA3MzlXdWxBTEpUT3lYUk54UUVVcUNT?=
 =?utf-8?B?S2d0MGE5UDhERXNiNG1FMTUwK29Qb0VzUTFIUW9uRHNYMjZvMThQNllNbWJq?=
 =?utf-8?B?RFo5UXFYZDB6a0pYbGx2bDJmNGkxRDdVTUVuSFQrUXM0cUdRbGhrd2pCbUhI?=
 =?utf-8?B?ekZ5d1RoY3hobmdvWkxtMEM2S1JUeWxFNC9LVStJYjNZc0paZmtaWXRyRENJ?=
 =?utf-8?B?aXBsWnFqTkZsU2E5NlJWcVdxaVVUcmNpeUZJeUltNHJiQWNMcm5OWVVoKzRL?=
 =?utf-8?B?SnFVZlpaNmU5ODRvZFZSZG9QMjZmVzIrZ2piVjRWWVppRGRyN2RKeGNCbHND?=
 =?utf-8?B?Uk9VZmpUV1B6dlA2eXR4VkRsa0NZL0lYaDAzSnlGdTZwQy82UUs3WHVhWEUx?=
 =?utf-8?B?Qjg1ZzRMd1RseE00MXBKM1BsdmRvVThEWFpBRGlsNis3WXFnNEZLd3RJQlhn?=
 =?utf-8?B?Uk1uaVhVNkhQci8rQjJOSXF3QmwrdkNBa29zdEl2VDd1S1FmL1R0bVhSYmp0?=
 =?utf-8?B?WkhPRnhMUWRva0dOVWtYRE5naVVndGRQbjdqdHZJL1J5elJGczgwMG9CQ1ll?=
 =?utf-8?B?b0t3cmNycTNQWVJmdEIwREU2aEdRK3k1YmdrUTZ5MG4zRzlUVFlXejlLaUdE?=
 =?utf-8?B?RVZpR01rT01vdUYwS01HakU1SEV2UGNqNEpuWnJYZnUxTVFCb0pNakFOWGFh?=
 =?utf-8?B?c3dtMUx1aFlhWVcyeStFUnFXcEhBS2hJa1krNGVxRUVEU3NFNkFTMWlhZEEz?=
 =?utf-8?B?cFc1TUI0T01hYXlZa3kxb1JVU2RTQk00TDFUeGFFckFES2ZSNUtoVCsxSUdH?=
 =?utf-8?B?MVliblNRclVXSWxGMFF1eStlTG9DekFUMUJ6SUhFQnI4SUNWdm13NjVxaWtu?=
 =?utf-8?B?QlQ5VDJLR1hrUkNMYnl5YXFhWWN1b0tkTlhHVzhKbmVPcG11YjQzS3plaEF3?=
 =?utf-8?B?TUxwVDZYVm5xY2tZdVJQcngrdi9YZkJ4ank2NmFld1ZIdGJ3QjRtOW55UTUz?=
 =?utf-8?B?eDRYaHlBL3l0Y2VnSWdEbFpXL0NtK3BhZVNwWTd6TEtMTGNnQWpURzVRU3Z0?=
 =?utf-8?B?ZTBlL1lXZXpoYm9iU0UyUGdNTFdiTU1JcGxnLzM5dTBITWR2TndYeXhwZG1U?=
 =?utf-8?B?aUdKZlp2eHFsSFpjaEM4S0FnZlZOWFhHVDM3NGtqRnNmcGlNSlJBeU1kSjE4?=
 =?utf-8?B?RkhpbG1aOWFrUk5SRkZvUVc2cDFEL0I3WFpzT0NIOU81WlNVdUdxbU1CTk5D?=
 =?utf-8?B?TldmQ25KMWlVVnZaRmx6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4248.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0VjWlRhLzMxMlRvczBYbEN3TU9kc0x0TW5iRWg0cEpwMEszSFRzWkxwS1dN?=
 =?utf-8?B?OXZQdzFsMFRaWWZsMDVvcWtndTE4eTl5cVF0K3RSUjlNOS9nbFJYNWlQWFRK?=
 =?utf-8?B?VlNHWnQ1ZzduUGVKWENCZzlOT285TFc0bTFqV1l0bHQ2RnQ1STRwa3VYMGd1?=
 =?utf-8?B?NDFJSitTRjdWN3RxU21LcWlFME52L0tMMFpCL2dKRDluVDIveWJNNVp6Vmk1?=
 =?utf-8?B?bkVISnNNZGt4NTl0SXhVV1B6V1Fjc1VWNDF4Y09Xb25pWGs3aHdpTjdnbmxM?=
 =?utf-8?B?eFN4UGFiY3ZrdEdBRk9NcUNxREwxa0FKdWtwNm16MU5NdlhOb3ZjUVpPaEhm?=
 =?utf-8?B?RXUrZS9tZ2hBbEE2cTdpSUxPaWdsc0svdnZZOTU0MXViZ3JCR0dtbDZqb3Fy?=
 =?utf-8?B?RTNHczJiQXB4SG1pUUdxamcvNGlEZENDRHJZVnVkSDFmOWQxeGdCbW1ZelJa?=
 =?utf-8?B?VkM0UGZpYUNxWFVCK09CQVRHME1RRlI3cE8ra05kNDlDOVRzQkpGSGxxVXJB?=
 =?utf-8?B?THIrZTlEM2hZVHY1WHFqRVpLRk1JSUhNNzMyMFNwS09zaTdHamk2V3l0Q01h?=
 =?utf-8?B?dFZCcFZjUUhueTEyWkhHZUJCVVlNSFRFWFBreG91VmlpcDNTRnJFWEhzTDNM?=
 =?utf-8?B?S0tYOUp0YmV3Vkhld28vWFA3TnN5NUlOQXA0MG9xby9ERk1Zb2x6SFVKKzFJ?=
 =?utf-8?B?WW94RUozc2FSSEsvRDJBQ281SDQ4Myt3bkJxYW9ja25pMm9YZlZyVGtEQXBN?=
 =?utf-8?B?eDBNSGpweUhCOUgzekJqT1I4bVFWaFRoVUZqV3VJWFlVaWVNT3JkbVhmZjg0?=
 =?utf-8?B?akgvQnIzL2ZrR3lYUlJZalBPWDJ5dEljMUQwckdBYk5uaERRaG94bUc5NVhx?=
 =?utf-8?B?TGkxZVBTWS91ZDBhYVV6L0pabThVc1Z4OXV6Mm5udjdaM1hYSThuZWZKRkxn?=
 =?utf-8?B?bzQvcVNpR0pYL2xhVDkxSk9zSmRUZzY1U2dTN01JOStuVDZuUnp6K3FQQm9p?=
 =?utf-8?B?NFd0NUtnWTJ2OUl3eDgwTzZIZkZNNFFjNEtSeDVDaTdWd2tTbUkrNW52RFho?=
 =?utf-8?B?dUVZTWRLNE9BcDErUThYaUszSnpHTXFJRVFqQXB3YzFtSDdxSFUxQUpqY211?=
 =?utf-8?B?T3FhdXQ4UTFBajNkU3M0WEJrcDlrTytPKzBVZ0puWVdHSnM3K3h3MWlRSmtH?=
 =?utf-8?B?emRMZGRoTXQwdHJLcXdIRng1M09XaExFWDNKeEVmWUJiOEFiNzZnbE5BcVBB?=
 =?utf-8?B?emZBRWk3eFBHbTM3cG9DblJQSDV4eGJsOC80SjBHeXcvMU9ENGp3UGkrNlJQ?=
 =?utf-8?B?d1c4eW9aK0hWbnU0SUI2VjlQeU1GbzNvSjRRenI1ekVVdHk2UHdkYU1iZWlX?=
 =?utf-8?B?NVV5SGZPNHorUXdDbHVCTFdpa3pCemFoUDJmQkp2Z3psYXIrdkVYN3NjYnFP?=
 =?utf-8?B?NGtkUEhVT21nWnhUUWNsN0I0a1Jsejg5SEM4M1lIVXdGNjg1UStEQnR4VnYz?=
 =?utf-8?B?cjlLdjhYOUZIaDZ0ckVkSXFUdEk2MXVya09FdGtjM2VJL2lVU3cydUg4RDlU?=
 =?utf-8?B?VWFRMFRYQloxS0t3Tis0aFN4d1ozWXdqWnFiTnM0TEl5YTFmaEx1NTV3VnVI?=
 =?utf-8?B?TTNjQWhKbE4wMkprNy91a1BUa2RtcWxNaHRtcUtxeXh5OFErUElHcTUzYkhz?=
 =?utf-8?B?ZUhWeGUwMFVvVFdiSG1Nd1lhU1RFajJnZExTcDVDc0xPZjJUS2U5Zk1uOHV0?=
 =?utf-8?B?ZGMxVGdBREllcThIYmY3NHJKUHpKS1JMeEU5aHJhZy9udzdPR0dDbDJVTmxQ?=
 =?utf-8?B?MFdqbkhmUEcxMEIwNzZqSFFQUVpnVFlJbkVPQlV3dTk2WldiWnBvM1NTbUtI?=
 =?utf-8?B?K1gwOVoySHVwdVN1bng4cVRoZy9zUmxxZE0zU3FNQUdjZVI2NWVmd3Nra1Ja?=
 =?utf-8?B?ZDRyaW1ZYWxIZDBlWkRIZkE0emFrL1lJY0x5N3JnRGVWdDNESFNKWk9mbkRn?=
 =?utf-8?B?STVPU0ptZUVMb1FXYURoaGwwZXpUbWt4a29mMDE2cTRSZ3phRDFsNVpKNGRn?=
 =?utf-8?B?QTR6ei9JeEVJRGRVWGVvQzhCaHNuTTJUVnBkY0M0dFRwSVE5UXdQZm4zUm50?=
 =?utf-8?B?NmNJZ1E1TFlwUU4yc0Q5M3VyUXZXbVpNZVlHUXJTTmNkSXZNWUhHSFFtVmpx?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edc0890-8072-4ba6-770c-08dc9f6b76e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4248.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:31:48.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTFJ+LgLSfc9/VKYbNRdY0uJbxW1aFkoFDZoB7+mva7ZZa/tVpaYA06R1ZyQDCakarMGkmbpyZHxJej06AwGrbWFbVEABoXpI17XD3PQMME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8360

On 2024-07-05 01:20, Christoph Hellwig wrote:
> Btw, sorry if I mislead you with my WARN_ON_ONCE suggestion.  That
> was always intended in addition to the error handling, not instead.
> (In fact there are very few reasons to use WARN_ON* without actually
> handling the error as well).

Yeah, I should have caught that. Thanks for the feedback, Christoph!
I'll submit a new version later today.
  
> Yes, doing the same for ->close or anything unimplemented would be
> nice.  But it's not really in scope for this series.
> 
> kernfs really should be using it's own ops instead of abusing
> file_operations, but that's even more out of scope..

Ok, I'll add the ->page_mkwrite with the WARN but leave the ->close
the way it is.

Martin

