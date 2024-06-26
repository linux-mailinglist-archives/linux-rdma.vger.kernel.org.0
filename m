Return-Path: <linux-rdma+bounces-3534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C648C919A89
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B154282322
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00863175567;
	Wed, 26 Jun 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="bVaZddLX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2953364;
	Wed, 26 Jun 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440602; cv=fail; b=tlhoDrcDe0a5ckyklmWINs1CSr0SNiB3SgbMkIao55hb8AWhOAmv1lTVRa6p7pjOxa5uE8gPz44y6pUOUruN5dh8UaQnALyM1Q1dq7nPSBhADF529Rv3XTPLlhqcPIBqn6x33JtlDPIZKP25cZHfPXNh+dGPYUTAa1r1P6mNrWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440602; c=relaxed/simple;
	bh=H1maZVMi7xTL/ocrwEOJqSm+8w7uXf2qQ+zc/RCmXBc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCAQ0VOYkYKTVBchUBKuXcx5X5A4zepPkLyl2R7NrYSdcB+NmwS2IRWnr7dNkzVi913ogoJvWUoHO0pTxslT52WvNg6dZxmGP2WvwGYC+AQuASbd/nRuswmlodJyyUPwa28oypMclA+BwZLwPPmf+IIMC8y7f3WQqfOST9vGiAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=bVaZddLX; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHzN8AxMe214Oy0uKRhDVsI7U+JuhjiWMi5AugeQQ60MK7HfOUSnz1wo3OsQzupSEQ4YE8r7lDR/Xg580xXi0/5PP3fcMNSYT1kuN3O3fktxOvU1Y+V79baMovymSCPusG4g2eu1hR8vlYbaCufNwsfboql21eJKg++egUpCjHhsCppG+R+Dsbo7huYmTqUqqYkZ7J2kX/EAhws/+Q5z6gWSdNp604KYDJnQ4TlHtME9GS1vSjhnBeBrXVMcDIBuzA3/B9uPEslBm2XTWufeleN17vHOxNBJY5naWka5MiQ1atq8EjgrdnTi6ayd7LCujiE92jxuETKnFSN5cPqt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVia9LFINwQfHDtnwSuFxyJZa5gcEv5QchCogXMcukM=;
 b=L764aNRqkndiZsO8/in1N2h9KQpVunML8NSDhWygALuTy7gG9J5C9C0j4ZCAVv8rqb2o8WgVP+NlkBXvMWY0ZlBWa094zd+sikuC4o6UBoouub80t1NbZPRk/o0TGCX3Cn/UrXIOUdVrx79Edgz3tGhTSb8y4WA31l1mnY6+l+0fvBViCfDnQruYABQV8nq9Ry+u9hDShDMO+js9M31/sdpudPP1M6RFpySq78MmHC9n88y1AdGsIANGwqVC3NlGVyC0WpBSMaU9OSSLXtob07iPiuEL0hTndv6mScu9uC13d1mSYC1ozplJyT5Oes1Cf1HUBm+aEjTdCFJqamO3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVia9LFINwQfHDtnwSuFxyJZa5gcEv5QchCogXMcukM=;
 b=bVaZddLX5/GzDZSdwP0zTxq86dq41IVpwVZsxdWNpjw6fhy7hWcfHZzGlUL9XLYVLbxwIEH7eVnV+ZGuEFygvM/6LdVpRN8vw3qaYlAV20ODfiirLGTO7I8XdYyG6rtJNmpx1yz2edqwU3lteY+5sXUBKICwvePQwC1K66dxnvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by IA1PR19MB6419.namprd19.prod.outlook.com (2603:10b6:208:3e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 22:23:17 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 22:23:15 +0000
Message-ID: <afe10d1d-ba02-4a5f-b745-8366c97f6c13@eideticom.com>
Date: Wed, 26 Jun 2024 16:23:12 -0600
User-Agent: Mozilla Thunderbird
From: Martin Oliveira <martin.oliveira@eideticom.com>
Subject: Re: [PATCH v2 2/4] mm/gup: handle ZONE_DEVICE pages in
 folio_fast_pin_allowed()
To: John Hubbard <jhubbard@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Artemy Kovalyov <artemyko@nvidia.com>, david.sloan@eideticom.com
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-3-martin.oliveira@eideticom.com>
 <cc68a062-d44b-4608-a11a-6c87423d0b87@nvidia.com>
Content-Language: en-US
In-Reply-To: <cc68a062-d44b-4608-a11a-6c87423d0b87@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|IA1PR19MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db3c5d4-0ecb-490d-a5c3-08dc962e92e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymc2U1preVhiSW9WeEZuYURweWZtWTlzcmpJUThWRjc1U2V0QWVkYlFmZCs2?=
 =?utf-8?B?QUdhM2Q1dHBXVkIwR3pKT3BGSjV1aGhabzlBc1o0Q1M2cHdXWTNRWTgxYm8v?=
 =?utf-8?B?MGNyNUZOZ0J3SC95V3piRGxuZC9UZnU3K256Y3JWRGgwVlo0a0xzLzJLRFp5?=
 =?utf-8?B?Z1NHS25aL2JEcFlqa084cU1mWTVJazF5NXpFWUpNWXNiSWl2eldXNU5SK2x4?=
 =?utf-8?B?bTluV1NTTFI5a2czT3Z4T3pacVhXWHZJR05CNnpoeVFkZG9yMzE3TnZaV0M0?=
 =?utf-8?B?MklsZzhKMzkzRHpocVlVUmlDRlZrWG1TWjNHeU4yazJsNzRqNzBuVkVpcmdN?=
 =?utf-8?B?Q2RCVmw4TklGV3psanlHSTR1WnBocHpIK09yM255dzhDTm9oejNWVVV5cmsz?=
 =?utf-8?B?Rk9WSk96cThvTmJrUVRPVjVOM3d0MUNZSzlkVmVrTzJDcks2bW9vclA2cFJx?=
 =?utf-8?B?M1lVVkFUUnpTSGhrcHZxekhWbUoxTVZqK2RpNzJXdk9rK0dvSzU4a2RlOGM3?=
 =?utf-8?B?Sm1IVVN3VUdZc0RZbmJaS01aN1l0S2dONjFFaDRvSjUwaTI3VGpQT1FCbmdM?=
 =?utf-8?B?dC85VmxMTjlERjdySnRLSVd4T054UTY2ZFRjMHRkU1dOd3hDbDNOQ3VhZk83?=
 =?utf-8?B?aEZxK3haMklYQlpEM0JzQW1FNFUwcnRzeEJZVzFnUDRkZnNBcGdKcWl1RkVZ?=
 =?utf-8?B?cFZqUGRnKzNBemsrNWlkUFJSbFBVUjMvSk9jVS9aYjRuejVaN1hNb2dEQ0tp?=
 =?utf-8?B?MFVkVjlIQjZjOWZxY1NIYnRZTHNYUzhwT0JJdUxHUldIa3V5S1Nqc1lJdy9n?=
 =?utf-8?B?cHFQZUQvSTErV1M0bFpuVVdxM1ZVcFAzVUEveTY4ZmtOck9MYktTVmM4QWVs?=
 =?utf-8?B?bUtDV2xjN2sza3FneGFzRmQ2Mlo5ZFpwNkpVTG0wZ0h0YzZ6cEE2LzlyWGtY?=
 =?utf-8?B?Z1hsSngwd0JJMFU4Vk94NEVMZzI4c21SUHphOEROa2I4MUtsckUxNzd2WlFE?=
 =?utf-8?B?QzNRMXNLbnpjVCsweWJmMzl2NmRzRmhuQnhWRlEwTkdmWjJQOUJPVzFFc21D?=
 =?utf-8?B?Sk9lRmowUEJudUJKL1UvSUhKMUxSK2dxcjIva3A4VEZybEYvS09JVjVRdEJp?=
 =?utf-8?B?cWtjRFZXbFZsRU1kc0trTXZHM3VpVkhvdnlrQ1ljaUJtM0dOT1M2QUZyLzUv?=
 =?utf-8?B?Y0hya3BMYnJ4dnB3UmdSL0JmS01ablRFbldkeWswWVFpa0tYcUtUYi8rT3E2?=
 =?utf-8?B?SDg2VEZ3L0RQNHA3d1FrM2lSTHRkNnlqakpjWi96ellPNUZ4R3FveXNYQnVN?=
 =?utf-8?B?ZEt6T1lxTDNqekFTQkwxUk9hZUtVbkMvQVVUd0xIdlh6YkV1R2s3NVVHcVhv?=
 =?utf-8?B?Y1VXVE0zeGJKaTVZWFZEN1dpUjd0aE05a3kxb25nKzF5ZWtKRi96RE16NGND?=
 =?utf-8?B?cWVkOHQwWGFJQzNTalU3ZXJjRGFWL1B6TFFUaHQ2U0JsR28wWm9YWUJ5UDRw?=
 =?utf-8?B?emlveTBoeVZ6Z21nQVdUUHNCZ01nem9OVDFTVTVmUnUyLzRscFYyNWdJaGVu?=
 =?utf-8?B?QmJVQTJXdlFHYjFpTkhrek56cGZ3SnpQeVdJZzZKai92WFJ5b24yZlJSRlN5?=
 =?utf-8?B?NWRwY2NNTk1hL2xHRmdXYmxlaUVBL0VLS1RFS3EycGFBcDdQUWFKRU1qc20y?=
 =?utf-8?B?T2lXWU9ZUVRMYmZSb2w3bjlwemJaS3huVFFJeFRLVElnZXBUbFlHTDFSMEJu?=
 =?utf-8?Q?W5JB/3FSEN9KChFJviPdBXLoCIxfQ+7OLOrq0IY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3hLOGd0dnJFU0tMVGsxNFBlaVU0SGtreWJZZXF5ZE1CU09wZ3Vnck5idXlC?=
 =?utf-8?B?dG5qem9sZndXYkRaWjZhTWl0S0QvczY0TXNwZFFCOFgrbDlYVmhMQ2xxN2Fr?=
 =?utf-8?B?Z3N1TGNjaVQrREgrUFlmdk16OWRZZ0FKRi9POWNRTHJHVHREaU05cWdQL0pJ?=
 =?utf-8?B?NjV1ZFZNKzVBbE5VdGxMUkh6bytnRWJVQ1A1bi8zRDh4TDVXM0JFR2ZwOTlL?=
 =?utf-8?B?MEp5Uy8zTEtTZDhIaytzaVgrM3hCNWZWeVRLQmtEM3RKcEczb1hDc0NYNnVy?=
 =?utf-8?B?eU5RTExjck1TOUNUbUM2TGNyb0lGQm1IZWRpZ2h2VVA1bTFUTjRmZHhyNlcy?=
 =?utf-8?B?T2NSRXBVZHdOVS95VDFQV0k0SDNPMXRocW9Cai8xdmcyd1J3WEVOVjBObFo5?=
 =?utf-8?B?aHFYdzQ3L1V0bUVteHJ6MS9rcWIrLzJ2d1JLTTBIU2doeFFwMVJJaHlBeGQv?=
 =?utf-8?B?N3FDRXJ2V3RnMVE5ZThQYzBObDlqN2JSQ3BraGhvRW5WQTRUNFJmYmdHSmo3?=
 =?utf-8?B?NVUrUjdoVjRCMGNCcFl1NU02dmFJSXVPS004clVsSm9NUjhYTUJWUlN2YVI4?=
 =?utf-8?B?ZDA1Q2dQQnYzclJoa1VwTGY4QTRId2w0OHNKazRyTlNFRlNJLzM4dFZmZlg3?=
 =?utf-8?B?MWxCUzd1bXgxRzQ0dEpJTFpMYXJza3NxSVRjMUVPeHhLNUExS1FzRUp5endF?=
 =?utf-8?B?ZmRHYS9EOVBjTTJ3T1cxQnZWWitwZjRhY0ZxR2dxQktoZy9aeGpsbk5vcDlS?=
 =?utf-8?B?Y0NKK25XcTlrbW04NjQ4YU0wSFYvODFkcjgzcUNKd1JyczEyVXZJNkxzNU54?=
 =?utf-8?B?TE9VdFAvdXpxeHhJaCtsbEJ1d2ErNjJUWlNzVXVtQ2FHZ3dVQVJpb2ZpcW9F?=
 =?utf-8?B?am4xODUrZ1NXMWJyMjlaREFaYnJZQ1dpdStVMlBFdHZTN0cvK3AwWjdWVmZZ?=
 =?utf-8?B?VWI0NkJhdTFoYWdrRFFrcVlza3BNTTVXc1krRTl3RTZ3cjZ3ckpvQzJuem1P?=
 =?utf-8?B?b1B5dDJUK1l2N1ZzUmYveGdmb1poYXJJbTJFZHYwSDFSenEyQ1VSa1BXaHcx?=
 =?utf-8?B?YlRPb1VQNUFmMk5tNFJWVmV0anFYMHNLV1F2MW1tYXg3SThPSEZJYkZ6MDFU?=
 =?utf-8?B?TDVnT0JXRTJEK2psWms3T3htMUJoSVhFZXVPQ0xGYi9VbmdWcXRmNFNuL2RP?=
 =?utf-8?B?SXExamlySkM0clRkN2VBWlFralFlcTZHbE1jdFNrUEhmWnlBOHpiTE5VNk8v?=
 =?utf-8?B?eGhxenhzdE9tMkVtMUJnNC9QdmpxKzE0WUhBVGZ1UytnYzRldDZJVzI1OFlN?=
 =?utf-8?B?UENqSXd5T1VSL3JTc3k1UFB2RU5hVzF5bDBvWjUzZ2FwRkdEVnI1U0lzNmt1?=
 =?utf-8?B?aTMvQWJwcGF1SGxvV0tyK053VWd4QmZlMlF0ZmhXb0pKTTgrcHorSi96ejNQ?=
 =?utf-8?B?MXRPSU4vYkxma1FqTGVhSGxQM1UxcmRKR1F1cnRkSVJMZ2IrYW1EbERscksy?=
 =?utf-8?B?UlJrNno5RllZZ2hNNzJLN3VyNk80Z0ZaR3JWa2xBNFNmUllYZ2tpeUs5c0x1?=
 =?utf-8?B?Q0hWa0c0OHRWOWxTelJhMmJXM0xUTFh0T25rWHd3SXpXamxjbm5vL0xaSE9v?=
 =?utf-8?B?ZGNWcG8wek9GL29nd09SejdrRDY0SmJHZm1jUUVuRFZkWVczY29XV05aWUpk?=
 =?utf-8?B?RHhHZ1hXUUdkQnFOZ0U2TjZoT05CQUV5SnNSK2FINzVKai95c3F3R0dFeTlp?=
 =?utf-8?B?YUdJejlDaFpHZFhkalprSUcyZnJBRVh2MHpwMXV0dmZYNSszQTN4S0Z3YzNF?=
 =?utf-8?B?d3NrazkrK1gvM1lXSkdtSVR2QlNrZ1ZpS0M1ekVWSjFMS2VTUm5ySnVwSVFG?=
 =?utf-8?B?ai8wTEpCTTdId29xRmZlQU40eHhPMHBabmhYVSsxRGpRNzJuU1Rvckp3L09B?=
 =?utf-8?B?b0QzeG5TUWU4Z0RCaU1FWGNUMjRCRmJSRWRTOWRLZUUrKzVJZjE2SVFLSUVX?=
 =?utf-8?B?NjBzMGI0bEZXOUhLeFNIaTB6bzRVdWZieGFMZTBGMlp1d1cvQXZlL0owazg0?=
 =?utf-8?B?dDdmK2pBTGt3NzFhODZHRVh1dDdIbzNCRTIydU9NM2l3Snd1WWRCQ0s3NUtZ?=
 =?utf-8?B?RityekU3SDkvVW85YWdkMTJ3WHVoeUUrZHlLYXlCb0hXMUlNMjEzMklTNUU3?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3c5d4-0ecb-490d-a5c3-08dc962e92e4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 22:23:15.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xus7EuNCBlenEaiPfiYZBpsv+rTmQZSyYlPmVW78eMIR6BGkB7xUthrbwGmjd17olNKT4tfrZy552SL2qv72FXDTF5VuuJ2awCeZ85aA5xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6419

Hi John,

Thanks for your comments and sorry for the delayed response, I was off the
last few days.

On 2024-06-14 20:40, John Hubbard wrote:
> s/folio_fast_pin_allowed/gup_fast_folio_allowed/ ?

Nice catch! That function got renamed from the original work
we did on this series.

> This comment is very difficult, because it states that one cannot
> do something, right before explicitly enable something else. And the
> reader is given little help on connecting the two.
> 
> And there are several subtypes of ZONE_DEVICE. Is it really true that
> none of them can be mapped to user space? For p2p BAR1 mappings, those
> actually go to user space, yes? Confused, need help. :)
This is a fair point, I had only looked at p2p but I can't say anything
about the other subtypes of ZONE_DEVICE.

For p2p, yes, they will go to userspace, however folio->mapping was NULL
for those cases. And hence fast path would reject it.

In any case, I think we could drop this patch for now and revisit when/if
required, the regular gup path was not measurably slower.

Thanks,
Martin

