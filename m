Return-Path: <linux-rdma+bounces-2078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB78B2990
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 22:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC159B20E8E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66283155385;
	Thu, 25 Apr 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SBcIalVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E6154450;
	Thu, 25 Apr 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076245; cv=fail; b=cUcT5xoE4YJq+84qbrfd3ON+nTzcCu1NePFSkEpYYroFwbWp7Uv5LhSFUxs29SOaM/Q6SnRKtGhSKexw5QtQc/hUSmxnbgYumbv/doi8k6Od8sKUAsdNLFW/niz7Mb6Wwj5EqOCwyCanNydGXkDHmNCfMBWYDHChiTiqgDmTXsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076245; c=relaxed/simple;
	bh=6GqQhB7nczyyWh/ca1cHHSDAOlP3VvvKtdMZ/VYfgcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ntEHHFIwsUyy1YkniQZFIzfDXTTPtQl30orGDw6KrQdRg2Gpqf3GKnZh90Dna81bhhBRWUhciutoV0S3lmYsx9DNHh2hPonv7fwbu8nxDMDKFrgyHzbar9dzvQTkLhvshivfwWF8WER6wjlOn0SzfvBFIwwKpOoJmHkfuC2kqm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SBcIalVM; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5q4HjWT3IKQb++VO7xRQ76xfvs6hflFiYwl9r9gQhSzkXzw97MLDPQoMHNRWhIyFo2RoGQdeEwOdaXQR9sJNtzpQBGZ9GYNKvOdH+tFBJjg6h5uz+JM+EKGyrG+KQV0jLMkFSSbCTF01BqgDGcoJZvPT5Jx1h66YjZfESU4fuu0rOpjaMt93qjSqbo3DoOU0H4sdZW8Ce5G4KZihTiFkEKPvdYn2xmOXEsfSwYT0DFgZjRQEc4QaAwYqAA2MX+PbRBxsswsj4xYQYEc5KxzJHwAEwhsjT0oF8oLFcJe7RFFRfbm4M+UPb2yFxoW+yArntnTqscUfcnLN+pRX+wThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GqQhB7nczyyWh/ca1cHHSDAOlP3VvvKtdMZ/VYfgcg=;
 b=DcsNNFyeKmXYXDE2oqDIo14XEhbg0eeIiO5CKL7eKzvs6LSAGCAylWXli5hwxZ2fsp0+7C4nQDfcBmbVppJt5S4snq6K2e6h76QSg5TXjiQqlgKeHovRQ/gvdVyHLOVl8TDT96aGU0wHxpMYUJsh/hJ1XQzUvLQ6Mx0CZ4yk+i9o+n/v0WgZxSIpLUkQmF0WxF7rDVHVnCzXgL60qoyePBEhXIwtn6Zbnl6Dz3NitZ8WnwASX0sR8PiK2QFvRPqaR1dqql3fn7aFW0uG5ApEVrjtLjES5AS0Y6oWltMiguow/6HMuRrcFOxCjDK8rDdx5MC1s2ghgVIZC9VlDEuQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GqQhB7nczyyWh/ca1cHHSDAOlP3VvvKtdMZ/VYfgcg=;
 b=SBcIalVMLXxT6oUKHJ4grZcJMOxWZoPRDp8HiYaZKU224GnyZpt9g0zo5g0/lIfYvcx30h0x+srTFtgO8+BWLQjbq0JpKvq5ELW7OV0StOhcBbhha00fL2Bh01qETOX36BARZA293P6eeCGM42SuweYfWA2hVlttHckfA6MNoLA=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by DS1PR21MB4354.namprd21.prod.outlook.com (2603:10b6:8:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11; Thu, 25 Apr
 2024 20:17:20 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.010; Thu, 25 Apr 2024
 20:17:20 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Topic: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Index: AQHakbDH+/djAuODE0K1bSKvuMHIubF2ibqggACZ2wCAAlPFsA==
Date: Thu, 25 Apr 2024 20:17:20 +0000
Message-ID:
 <SJ1PR21MB345789BC81C9128D6AD7906ACE172@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-4-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB3457AB602DEA2B369E219121CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <PAXPR83MB0557DD076A61EF095242348CB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAXPR83MB0557DD076A61EF095242348CB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c56225b-5065-4ac3-a480-0af7c1935eb5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:32:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|DS1PR21MB4354:EE_
x-ms-office365-filtering-correlation-id: 41f175c9-5149-47d5-3a66-08dc6564b5f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVQxU1g5NEhWUlRiWWNVSUNtY1pDMzBoaUNYL1NWOFJjcm4zRjVRQWVSelJO?=
 =?utf-8?B?cFdzSXdVWVc0UzNkTTl1Y0M2dUZ5cEI1bkxFZUtsV0xVak5ZU2hndk9UTEZz?=
 =?utf-8?B?WXN0UkIzRno5SW4waFRrSW1oWjlDOVZiMHRVNWNvbGlpaldORXdhelNKMzFN?=
 =?utf-8?B?eTRRdC9CeUsvWmtzVllEVXV3TXAxRmQ2bzJFZXVPcHVaQ1JCQzh4cjhEeUV0?=
 =?utf-8?B?QjV6ZGlVMlhFOC9INEpvTHF0TmtQcElxeGdxeFVtSGUwMm9KRTZzNTFPam1G?=
 =?utf-8?B?SXNRcGx2Vi93OSs5TGZOTDl4ZG85cHhIbHJBb3hYS2xjZlJ3NFRtRWtrck9x?=
 =?utf-8?B?c2hreFlTSlBsdDhOSXNZOVpHWWc0RlNzbFlJZ2pVRGwrcVd5ODJBamNLa1lx?=
 =?utf-8?B?Q2RFZzgzcVQwdEwvRkEyVm1WUUV5NkhYRXJUMkdIV3dwbzE1NmtnNzltVkNY?=
 =?utf-8?B?RG9sTGtBNzVsaEE5T1owaVV6MVQ1bFBoNG4zdXZYTmZmUUdKNnh0S3RXc0Jj?=
 =?utf-8?B?UC9xVWIySVZXajdURXBMTmxLV2svQ0NkdjE2Vlc3NEloTlZNRGdXK3IxZVpv?=
 =?utf-8?B?dGY4THkwbnFNeS9YditTdm1XOVFCRmxkK2EySTU5ZmNXWlYySlZmQjNpU014?=
 =?utf-8?B?d1VFZWZEUG51bkhKbTBJSFlNSXNDZmNMVDRSOE1WYXJzL1FNc2ZncDlTUTQ0?=
 =?utf-8?B?VElIQWQ1bFRFd2N3T2ZpM21hRi9jS3lMRTYraVFPay9OUUNHNWNDd01CTnJh?=
 =?utf-8?B?VHBieWZubXZBWkZ1V2ZKRDEwNXk2dHR5NkRhZVM4YlRaeXRWbXcrZkxsenhB?=
 =?utf-8?B?WnQ4YjM5c0cwM0srNkdycWkyVXhGeHh0WkpEMGh0M25YZitwUGxodUVlcUJX?=
 =?utf-8?B?OWVwVzdSZGw4K05yVGVuTFJYaTMxWlpOM2JWZTVRb00ydWwrdzQxRzlBSnow?=
 =?utf-8?B?bEY4ekY3R3J2dmFDcHJIMGxwbXk5czg2RlpkSFh3alpVdFhISzVyRGdyUEdV?=
 =?utf-8?B?Y3NvenYzMEtWSThrL3MwakdxWjlhMEpESVpkVXdSWERrSDYyeVExNThDOE13?=
 =?utf-8?B?NUpSeW9Hem1TSEN0dTNJOUtrT0FpZXJxRkNzOEhmc09LZGVneno5OVcyZFZy?=
 =?utf-8?B?TkZkZ0JULzkxUlRqcEhSRHpaWXovU2htNTRuTUJoRloxM1pGOEY0US9HY1Jq?=
 =?utf-8?B?U3NKZmNGZlhhcjNGWjlEV0w5aFM0UVdMNnYxTktQNkxOWnExNjVYL1RXenB4?=
 =?utf-8?B?YXlROWVQV0QyUWsvTmZPb0xCTUFtVm1XTXFwcDY3Nm84U1BBTEFZeUVZSHMw?=
 =?utf-8?B?NGZGTHhSQ21sK2RxdkRmeFNCc2h5YzU4eUhjMCt1Snp3dUlXaml5ajhjVloy?=
 =?utf-8?B?aFFSelN6ZkhLZUx3MXNaR0RSTHFJNTdmVU5Jbmg2OVRyZzRoZ3RvS1kzZjY2?=
 =?utf-8?B?cHk3aStLdGt0NjhQQlhsTDlpdEJCQ0wzYzVsSkVieUx4cHc1Z3BPMi9xSDRD?=
 =?utf-8?B?VU1heHFwT2k5dnJMVCtybGpVZS9HTDJ1a1NrSVcxcmFPaWQvWTJQamtsWFF2?=
 =?utf-8?B?eTNsTGFVaWFFUCswbWl3cEV0UmY0SFoveVFvRUg0YjFwb0QrbVMyZUJjQWpF?=
 =?utf-8?B?eFJoMThTQmF0cWZtSytWVzlnbVYzTEtVbFk3ZVpPQVF2elJQVGNKQkNzQnFX?=
 =?utf-8?B?MjVkZERKSnJUZVgxMUorTTRPZWZpUzlTTXROVnA1T0NOK0V3QTI0SWhwQmJv?=
 =?utf-8?B?cXA1anBXUURpaFBidXJRUUxib0JCeW15ZmR3YThZWW56alFqRCtUdndkZ0Ni?=
 =?utf-8?B?bEpKeGRieFV4amFrQWRPdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHB4KzZaaTVtamlKWVN1NmEyQjRkLy9CL3U0YVdROHZjQmszY1dXODdhcThV?=
 =?utf-8?B?MWs0WnlQRVdOZXBXYlRHQ1dWNmRya242d09WZGF4M3JRcGhZL1JrcUF5SFZS?=
 =?utf-8?B?dWpiYXMzZHluV0M3ajN4c2EzQlJmeTNoT1VyVW5yNXJqNUQwT3lFR21XcXk4?=
 =?utf-8?B?TlVmZ3pBZGRsTDRWZVovQkdvcnNqSkgzUU81VWRXK0RadG5Bd3BCa2ZpTW1h?=
 =?utf-8?B?UW1KUzVLVWFNWjFTQ3N0Q21ESXRZT1g1Y0drMGlpeFBudVVZUjQzZlY0UEhB?=
 =?utf-8?B?UFVRRjZlTFh1emJwcmNTbmlESWE2K21UYjlRdS9PbTVkcDBBTjI0M2pMeWZY?=
 =?utf-8?B?ZDlpMUNoWmNYZVZ3ZGdac2lvM2lRNmxEYlpTdFU3NnRwSmwveEdlbnRKZzhJ?=
 =?utf-8?B?WFVpYnlaYktXSThlcWRPU25udENYeUpDNTdRcWg4VjN2c0xvT2xENHA2K2tI?=
 =?utf-8?B?VWFzOExSWFU5ZGZjSEZpMzM1WVBWbE1CM3JmdjFPdW9nay9va08xMDA3VUNw?=
 =?utf-8?B?Z01ib3l2Z3kxZDQ1SlF4aFI4VFhQQ04ydlV1cTRKUzQyT21zRmZzOUwwWVlq?=
 =?utf-8?B?MzF0Q3g0ams0eGNvQlFLUm5DUUdLc3p3VFZ6OXJxamhFN0pRdHhJZS9qMWV6?=
 =?utf-8?B?alBwcXlaL2xLd0NOMjZOQkhpMDlIaWdWd2VvSnFmK09qdFlQUWdaSlhDbldP?=
 =?utf-8?B?TUxHbHNqeE56S2lzOXpnOGNMcUNYN0NBb3ZzR1ByVndCSWE3OGJWaGdyNk5j?=
 =?utf-8?B?emJ1NXBNOWJCdG5Sb3VHRnkwaklDSkhlQkRHRVo4cEMrcm9JazRjUjA4VWxr?=
 =?utf-8?B?RmFrOU1oM1RsdHpUdFUzSS9BMFJsNkVaZlpLUTZ6dUdMNGxRZXhzekx2NEhp?=
 =?utf-8?B?ZXZmeTBWQ3NjQThLM0RKYVF5bktmZTMreVNVdExZMHdiempQUXlGaEI0Zk44?=
 =?utf-8?B?WDhHN3RzZGNybThnWUQwbVlTajRaZGVBa2s4WGhqMzk2Vm5PQWtMWG51Znhu?=
 =?utf-8?B?YXdmVFl5bWk2ZVFCZXpzQUNFSW85ZVczQ000OW44a09lS0tHemZJdlk3V09S?=
 =?utf-8?B?QU9TNThjc3Y1eitvcGpNei94bjJlTUtIbDNwRG02RVBvWkxQenc5TGpBVW42?=
 =?utf-8?B?MG96N0l2R25nMnJzUmJhZzZGMVZQangrajFEQzdpa1BQWjN5SkppSzl0NUZK?=
 =?utf-8?B?a1FJd0xoM21OM3dKSUk1Q1JXQWtHdkswdytmdXNtZWYvNzBubWlINThINXVy?=
 =?utf-8?B?S0RDTTdZd3JyZHFKNTNVUUQvRTluTDhoZFNHeHNwMk5pT0RvTFowWFNkYitp?=
 =?utf-8?B?c3hKVkVrQTQwV2UzYVhnRTROckRnMGF5TUgxcWhhZUNDVHlzZGFVb0NwNDk4?=
 =?utf-8?B?VFltdnVsT2ZuVEVIanRLTXFlTXh3RXVIakVMTmxwcVdJTjhFVnZ1dG93RldS?=
 =?utf-8?B?NzcyaE83a3EzbjlVdTlzSCtHenpha1U5QUp6ZG5IR0QvQzVvaDY0QWUrZk1L?=
 =?utf-8?B?dm9GT3hhbGk5M0dTa0VtbFJFTW92U3ArNGlYVEgvOFJQdkREa3lMc1V3TTEv?=
 =?utf-8?B?RTZXY3A3OHdjRXNUUFZnR2pMNXk1NHBXcTNGNFhJcFFaVUNnNW9JUy9mMUxo?=
 =?utf-8?B?UW1JaUFhdCtJRjl5RlUvZ253K0g3MUFFeXBJTFJhdDB1UGVsakRxUHhDSlY0?=
 =?utf-8?B?S3RRdlpXdG1CQ1NxVXVjSWwvRWROaGptVGdxcEpISGkxVWlaYTJDMnI5VlVX?=
 =?utf-8?B?WkZCWk40aTRZQ0EzWHNLNjBubmhZeWVQVWFuQW1GQWhJZEhkWnMza080VUhI?=
 =?utf-8?B?Tlhvc3FpcEgyRk9qRjQ4SGRuREFqbVQvazRVT2lZL1R0bkxPRXZEVnc4a1ZR?=
 =?utf-8?B?NURQNGs3RUNLVTJnenQwYVJuNmhDNVVvWWZtVXBqbW9EQWZxbzk2bUhXcExX?=
 =?utf-8?B?dUNsTHNZQXA3alhwZEI0Zk9tb1BCaUJsdytnY1A5RnlwbVZPclliTksvUHRJ?=
 =?utf-8?B?SEdVTGFyVXgxUkxzNjNydEVMdEV2ZHBLakM5RWVndFE5Vkk0MFJyM05NVU84?=
 =?utf-8?B?b2NnL0F6QXdMN2lwdXJrTlJ3dVJRTEdCSEJraXovdUVWdXNFMmFpcUlyVUV5?=
 =?utf-8?Q?7izfH2VQ5NqfGHel8jidWXkj5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f175c9-5149-47d5-3a66-08dc6564b5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 20:17:20.3175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apA0N5XeXOdzjUdbGzDot3ZEF58oXeK1FrUWRYlFta0QBv8FEzYmj7G6cFe0S13HWY7vrDLE7Z+CxiVDUl7gfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4354

PiBTdWJqZWN0OiBSRTogW1BBVENIIHJkbWEtbmV4dCAzLzZdIFJETUEvbWFuYV9pYjogcmVwbGFj
ZSBkdXBsaWNhdGUgY3FlIHdpdGgNCj4gYnVmX3NpemUNCj4gDQo+ID4gRnJvbTogTG9uZyBMaSA8
bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCAyNCBBcHJpbCAyMDI0
IDAxOjM1DQo+ID4gVG86IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QGxpbnV4Lm1pY3Jv
c29mdC5jb20+OyBLb25zdGFudGluDQo+ID4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5j
b20+OyBzaGFybWFhamF5QG1pY3Jvc29mdC5jb207DQo+ID4gamdnQHppZXBlLmNhOyBsZW9uQGtl
cm5lbC5vcmcNCj4gPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHJkbWEtbmV4dCAzLzZd
IFJETUEvbWFuYV9pYjogcmVwbGFjZSBkdXBsaWNhdGUgY3FlDQo+ID4gd2l0aCBidWZfc2l6ZQ0K
PiA+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggcmRtYS1uZXh0IDMvNl0gUkRNQS9tYW5hX2liOiBy
ZXBsYWNlIGR1cGxpY2F0ZSBjcWUNCj4gPiA+IHdpdGggYnVmX3NpemUNCj4gPg0KPiA+IEkgZG9u
J3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1pdCBtZXNzYWdlIG9uICJkdXBsaWNhdGUiIGNxZS4gSSBj
b3VsZG4ndA0KPiA+IGZpbmQgYSBkdXBsaWNhdGUgb2YgaXQgaW4gdGhlIGV4aXN0aW5nIGNvZGUu
DQo+IA0KPiBJZiB3ZSBuZWVkIGNxZSwgd2UgY291bGQgdXNlIGl0IGF0IGNxLT5pYmNxLmNxZS4g
VGhlIHBhdGNoIGRvZXMgbm90IGFzc2lnbiBpdCBhcyBpdA0KPiBpcyBub3QgdXNlZCwgYnV0IGlm
IHlvdSB3YW50IEkgY2FuIGFkZCAiY3EtPmliY3EuY3FlID0gYXR0ci0+Y3FlOyIgaW4gdjIuDQo+
IA0KPiAtIEtvbnN0YW50aW4NCg0KSSBzZWUuIFdlIGRvbid0IG5lZWQgYnVmX3NpemUgYmVjYXVz
ZSBpdCBjYW4gYmUgY29tcHV0ZWQgZnJvbSBjcS0+aWJjcS5jcWU/DQoNClRoZSBjb21taXQgbWVz
c2FnZSBpcyBjb25mdXNpbmcgZW5vdWdoIHRvIG1ha2UgcGVvcGxlIHRoaW5rIGNxZSBpcyBhIGR1
cGxpY2F0ZSBvZiBidWZfc2l6ZS4NCg0KTG9uZyANCg==

