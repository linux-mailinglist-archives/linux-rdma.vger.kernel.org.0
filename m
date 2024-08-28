Return-Path: <linux-rdma+bounces-4620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD5962D44
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648DD1C2110D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE31A38FD;
	Wed, 28 Aug 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Sj3FQf/3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021121.outbound.protection.outlook.com [52.101.57.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0267E574;
	Wed, 28 Aug 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861186; cv=fail; b=mU6sK6hEDOlcRpDbE6+r5HWPDvQGCuXIKfILS2qb5vsuEYWkQ1BM7KqwUbfefrYrrZz1+oLy4DByS9rZNkbdeTakeKzARMD1ORhh9p7WvWmt5jAQ2kzLuGhxLbuRs28GHFNACvvOWId0kc6VjtEkGudOYokvAK/jQ6zCZLqH+Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861186; c=relaxed/simple;
	bh=Xmwg1YyY/6eY8SHzmfuAnB1hGjZp7f2qGj5MERoGbPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PrH7ofplWkDAsaqcA9E4WWJU23KfPsf94cK+TSvORAMTyEoU62C/IsRyp6rJftZj1YCp6h5gc3+KIYoYpn390ffvzxvGBOdYgu5pexoEI7ijAXtYClag0b349+ooYpat7wdmV23nPh1S/jzyY8EOaNLgcd5iPGZl6P2Dt5hGfKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Sj3FQf/3; arc=fail smtp.client-ip=52.101.57.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4L4rE0pjg1N20EjfF9Ef4Gm3eRfcBgt7fgTimDgnSYZqa+cTJ892LUax/PqlZfvIIsUuX4HZjws3MG4KZODHF1esiaXSdwaX220OKfr/0uXER9+guzgNpJ4NbnTsWH0bJE99sxKSqfLx2waq2jthhk53/7SmiLC20c3yPYngccD9xhca/s7s/nFnKlWGSzMqcd2Zk6t3svq7A+jMp82IDUrgeDjnmDQ0u8qKnhLB/XfRIRLgeBdmOGnfScwzy+skNt1XK821fjdcDqBKP2qK+0FccD++4t91JerHP2gWUPy1xAWNeM3qP+iLrq5ibbozRls+4F9Wmik2WNsuZkmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXpLGG22OfVJJNnj5zVYSdDeTefm+AQykDAao7/30TU=;
 b=MPaoWuWQIAimq176FITMbHk1vl95v6UwvhIDO+QCMTvvMDEUKa30NyvgyvoFCSwm3rrMMgZ1chwwJIZfvYq61qulww5XBP1s3+0P+BXnG9x4ikt6uCqr3Yxg4TTesFlv75PVLDgn1kDIUp6JLSVYXtz2V+FW0Mkj5r90X3BO4xTAyGMUIaGyZlmizz65+y6lUNfrx77EPcC37Q1uJAnUoUrnDmscYMmDjgTB8yNlW6tZ07QFb8zRUtLbM0kLV6cpoXPxp3Me6XCkweYj/ShzdxRBC+SVxrig6AbvKGpbQQe30Z9MMB25cbPvhGKwYUKEC/2EN4okkOcLgkRqdsYCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXpLGG22OfVJJNnj5zVYSdDeTefm+AQykDAao7/30TU=;
 b=Sj3FQf/3lwpym77Jbmt3FZX9izp2QYE/ymeqPWVNF6TMb9C626Fv2G7bDoYbd9LNhdm+EcUdAwlWQ0ZljojPx5/E6GnFOnu6CV7rIG+c9IN9yB311ymVxdFMUIYAHJFwqGJif729PhPpcle3rlYP3zqasfmhe7xQui2BZQuZ8NiP6DQo2so0DGCikSeN4gEspagJ6JBRI4N06wpoHyiq+KURoOtUEgzr00Huv7BbUTo1TjzdfTIidRNUldvDzSsm4zWOMrp2JeCgQ/Evm8z1Qu+J3Esx10P9xyvGAKWfClFl149XaBYN2O9FmbPwqwClnqhakYic+fFvxbyDBN1Ndg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 SA1PR01MB6655.prod.exchangelabs.com (2603:10b6:806:1a3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.27; Wed, 28 Aug 2024 16:06:21 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 16:06:21 +0000
Message-ID: <e8cb7488-aea2-4829-9942-dd55b127c25e@cornelisnetworks.com>
Date: Wed, 28 Aug 2024 12:06:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] RDMA/sw/rdmavt/mr: Convert to use ERR_CAST()
To: Shen Lichuan <shenlichuan@vivo.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240828082720.33231-1-shenlichuan@vivo.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240828082720.33231-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:408:20::26) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|SA1PR01MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f729b3-06fa-40ec-edf2-08dcc77b5b77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkhsQ3EwWm1MR0ZPVDg0OE1zNllZYTc5TThha3paWWh3OWlQaGtMWXNLZEto?=
 =?utf-8?B?VHRwYXY2dWhDaWpSUnRRMTNoOG85anQ3YVMwek5WK3pFWk15aS83d0hmcCsv?=
 =?utf-8?B?clY0U0ZqOEVDa0RxWGNwUW5RTHE2U1Q3UXNBQitrMDFiTmxUbElqL2ZMTEpN?=
 =?utf-8?B?anZwbWZYWFVESUFTSWNEV2ZRUlpvNjhsNnEzMEZjcjFRenlmWlZ6Ni9UQXho?=
 =?utf-8?B?WU01dW1Rbm1NZncxdzVDN21zWnFhWXN4bXBFSDFEemhjZ2xBMGR2TXg2Mjl2?=
 =?utf-8?B?Wk9JaXlJYS9rWlRqeXVVMzVZeEF2UDlaQit3WkRlekVDUTkvODgyelM2SjJD?=
 =?utf-8?B?eHd3QzU5bExORk1mZzZaZDZQMVhoQ0FoajFmRi9kaHZJNXQ1SmpGUHBiYytN?=
 =?utf-8?B?UkRIeHdrbngzaDAzandyTFpla1daeTI3bmdLVFEzeDJGWkdmMHVvRDdscUVq?=
 =?utf-8?B?dXF4NENFYzZFMGJrWVpnWVdTa1dRZWthYUhtcWNJL1FzZHpvOEdVcE5JNUp2?=
 =?utf-8?B?QjY4NUVvZis3QXpqM010WkFsVUdQZ1BDK2cxS0UxNkZWTkdWdWpQZVdMTHFa?=
 =?utf-8?B?SkNmVzI4S2FPbVJ0QUlOYkt2QVdURjMxN0czZ0hxTDlwdys2QUlPVERCUU1D?=
 =?utf-8?B?akRTNExkSlIwSDIwZStNRU9RMDd5S2dORGhWTjQrRSsvL1hvMWhrL05FTTBH?=
 =?utf-8?B?cjNjWjFWYTBMWGJzQVFGc2pjSFBmQklhQWpyTkN5c2pab1pORGVzQytzYUdh?=
 =?utf-8?B?RW9TNzVQanRDeVlxS2dwWTg2UVJwNnArRzhWcVdGZ3hLcEdUeEx0ZWhQaDB4?=
 =?utf-8?B?SXNZek1MbnVzTzBxSy9mQ2FwcTRkSjRMOEZFOW92RDA5WmhuNTA0V1gyWWJi?=
 =?utf-8?B?TG5RVUNZaVZQUFlIWlJ4Z25tOVFITHpIL0xkcVlzUHB0QXc5bkhDTVpEekF5?=
 =?utf-8?B?WGs1bjZzRlpOZkZnWW8waS9yYkdMQjNDS2hsNkVyc0VRL04wQ01qSUVvZThI?=
 =?utf-8?B?Z0liSmJSS2NaMytmcE1iYm5SS2lVeHRZY1FMMkUzeU9SWExDSXZhYWVmVXJp?=
 =?utf-8?B?UUlFQXZGWVJ0N0pKeTF0S0N0cGJYY2Zla29NSlVkL1lyeFNxQ2xiMVJTSmRK?=
 =?utf-8?B?Uk43cXlpWCtjZHd0MFNJU0J5b2xEb1F1UDMwQ1F3WlJ4aGlxVFRnbzBVQzI0?=
 =?utf-8?B?OXRmbUpsbVN1KzI4S09JdzZheDFlL1ZON2w3NWQ2R3l1OENma0cwMHI5SS9q?=
 =?utf-8?B?cElRbDJtMW9RSm9kM2xCSTRmbGJ5Mm15YTNrYWJ0Wjc2MXhpWUIvNXdHUUNq?=
 =?utf-8?B?elUyRmJEMXcxRURxY1ZybHV6Ulo1LzlFclN6U1FCVXRaK0xzcWc4NWJGdEl1?=
 =?utf-8?B?U1RMNkVqNUluNVNVRWtod1grdjJ4cWtYZmM3eTkrZzBRcUJQbDAwbzA1bUk2?=
 =?utf-8?B?aGJWamhJVUtOM3VnZ2I0bVBSYVBmc2hKMmRDK0NKRytQdjYvdjg2YzJZTWJ1?=
 =?utf-8?B?bkFKUm5vWXgwZEIvTlRmdW9CVnJERnQ1SXk3RnZrd1hmOTVpblkyVHZnQlNp?=
 =?utf-8?B?ZW1QZEo3WExKTmJGem5qODFFcXNCN3lQR3lReGRkQ0hJaFFnRmMwbVdlMUZC?=
 =?utf-8?B?Tnl5UGxjSFpIRG52d2RqSmVFK1c4VlJZbzh3TnQ5OXlVTDlkdFNYM3pET0pG?=
 =?utf-8?B?dTlUUGM0N2IxNHM1ayszVlFkTGNXUFh4TDVseC9XdUgxUm1VUjVRWFRHSTZD?=
 =?utf-8?B?NWhqMDRTSGJOeGNLcEtaRzdNZzhhVVNIOFRSWkI5Yzd5c3FmTXNOMEcreXB5?=
 =?utf-8?B?WmVlUER5WmM0cTZ6dlBCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0R0KzhnU3Z4YnFoVXpyaU5UNjVHRXF0ZDgzNXkwS0lwdmdweU12dmxBdHMx?=
 =?utf-8?B?Z0ZtQ1JDeUU2amFaV0tWWnNneWR1enRwcE9wZE1hQUZ3YmZvSThlSXFackVK?=
 =?utf-8?B?RUVTeVluYnFqL2xLOTdvSU1OY2lYQ1h5OHlkZFFaTkV3ZnNyNkluNVZwWnBm?=
 =?utf-8?B?Q3lmaURJTzR0UE1wU1BGK0hZYjkwMmczRkNacDR4eXN0dTZFdDdsOStCUkx4?=
 =?utf-8?B?ejQ0dGt1MXg1TFNMNU9QVnMrSTBPbWNlRmNGeUVLOEtLK3UzT28xR2FqT1JL?=
 =?utf-8?B?cm9Ca1ljdStSdjVINXZBUWE1Q3lOQkZtS1grWm91K2g1ZEJScnVKODY3SzNs?=
 =?utf-8?B?TG1jVmljTlZTZVpVTHdmYy85Y1Fqb0pmWUUrTWpud0FER0tmTkJna1hqMjVk?=
 =?utf-8?B?L3JCdjI5b1h2cUpQM3p6Um91MnhEM0RJSi91c0UvQjN0dDc1VysrUjY4bmxs?=
 =?utf-8?B?Rm1KL010ejEyMkRkaGZ0ZDZjQkxUY3JYUXRndUJ6QmV3V3d5TGtSbE9FTTI2?=
 =?utf-8?B?R2xCT0pBWWlLODRrTEdibUJlWkp0azlNc2F0R3RDc3E1dHB5TU1XM0pSYnQz?=
 =?utf-8?B?NmVuOXM0ZmJZbTRSVjhFSXpkd0pBS2U1N2tQSXFNU2ZWcVk4dW93L2VhNy9x?=
 =?utf-8?B?ejZLQzlqWVI2N0xqWlVMMVJpMDZLTWdDQk0vanpjY0xjb2szTklBZGNDODRX?=
 =?utf-8?B?N244a2QzSlowVkk3dHp1aitpeWZzbDJTa2FLekdkMElGZXNCU3pLOGpVeHZD?=
 =?utf-8?B?R01Xa1hucGV4UlpSVWNPakNrQnpud1BZVlQrTk5RT2J1UXRGQWJuZ1c5UlpJ?=
 =?utf-8?B?NTEwSFZYc1ppaW96RDFkWVZiZ2lDOUxqbU9vaFRlL2dyM3dxTDgwaUdLbzFl?=
 =?utf-8?B?WkdKYXM4SzZWSzYyTXZScEhKanFVNTcxU1R4dzlQWlp5Ujltc3Y2SThqby9R?=
 =?utf-8?B?UGR6UW9ZRndGQzBRZDRaODY2WmpOelVYcDhVSWVyY2sybTZvc0ZucVpuM21a?=
 =?utf-8?B?TWtsUzAzaFJZRWxjdDkzL0tEdGNUWmRmMmFvVmJuUEJpYjE1dCtxclRFeHJN?=
 =?utf-8?B?cVZwbVA0VnBlWHJ3L0tqb1N6cTdrQkpTaVN2V09DMXI2L05OKzNOd0p2WHJV?=
 =?utf-8?B?Vyt2eExFbmJHUlRFcGZHMHA3MHJWM2poSFFBa2tpbzdSZEwwTml2cDlaRWVk?=
 =?utf-8?B?Vm51SnpIa2dGSEE5UEZsU2Q4cHNvcXdBSlNuSXZNZ3V0NVFnYmVWZWtEcFVm?=
 =?utf-8?B?L0JrZUM0ZlM0bk0vMkxRWDBndHhIOHZaSlZJcWxIL0FxTUxJd3diQW9rMlcr?=
 =?utf-8?B?SWxQR1kzRG9uMWZVL3JuR2xVZDlMUnJOVWpKMUVZQTZQZmFFbUNZRlYvNC9R?=
 =?utf-8?B?WmRIcnExOGRaWVdTcTVla3hVdCtkbzNFZ014eE5oSTlGbzNtRjlaamxDVmlz?=
 =?utf-8?B?NTlsRW13cWZ1bElmdFVvbEFtVXFQejd5RXlyVDA3ZEo5N3psLysvYmlZTmIy?=
 =?utf-8?B?UVNDQ1BCYndsaEozdE1VMkdpSC9Cd2JsUktPNkFteVBUdnRLK2RET21vNFA0?=
 =?utf-8?B?YnUxbDFIL2lJVmZFMU1GV1NXbERXVXZFVllTZndLUFlIQndyWlAzemxyNWVy?=
 =?utf-8?B?Qm95QTJ0SXZ3dXVYUmMvbzdEbFdhZXJXN0NyK3kzb2JGOStSYTd1NjBqRTFM?=
 =?utf-8?B?bmMyb25HK0FDeGRqNzBvU3hFNUk5cTVPL2FIK1E0dkVyaFdsQ1BQMXRyK0o3?=
 =?utf-8?B?UlJwWHZKRXo5d09ISGVFT2dyUzRSZ3pVSGVwK3VXVnhhZFVGWlY5TE1MNVFR?=
 =?utf-8?B?REJlS1VXMHMvTjd4Zi9sSXRZOStZZ0lBVW1yTEpDUDEwNlBPSTZMdjVmWmp2?=
 =?utf-8?B?MWRLREJjSDNVSTJ5T2JTYk1sWjdkbU9jWC9hWGszdFBpRVZ3QjJnVWMvS1RI?=
 =?utf-8?B?OFpSVm4rc0tRdXBTV2o1ZklSQ0VXZ0pHWU1vOXpvQVc2TjJFcTlXYzVFZDEz?=
 =?utf-8?B?Wjk3SXNPTGJ2N2NZdXBSUkpKMmhKR0JqYUVDTmlTS2lHakc5ZW82ZytCNEN5?=
 =?utf-8?B?Vy9BUzFQdE4xbUltZFZlbXY5WGwrSUJadlFrSWs4U1pPdUx6ZXFVS1dnOTlp?=
 =?utf-8?B?L3NxZDV0VEEzTlYyQXdEMFBOMitsTW95MndVUWYweGN5enBHbkxxem5uanUr?=
 =?utf-8?Q?zRlErB5vt/t0Rz9oydTipAA=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f729b3-06fa-40ec-edf2-08dcc77b5b77
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:06:21.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBPg5IEFTR09l/+Xyh3Jr9C9ThlKTcxDfApbkBVyEZBg1N172+OaiyNoKG1Kbw1a6I6fQLfQWRTeok1wjHJ1siI0fhHMQHlw9B24fEW6PKxBnVhJNi1mNLC81qZn4vNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6655

On 8/28/24 4:27 AM, Shen Lichuan wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that 
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
> index 7a9afd5231d5..5ed5cfc2b280 100644
> --- a/drivers/infiniband/sw/rdmavt/mr.c
> +++ b/drivers/infiniband/sw/rdmavt/mr.c
> @@ -348,13 +348,13 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  
>  	umem = ib_umem_get(pd->device, start, length, mr_access_flags);
>  	if (IS_ERR(umem))
> -		return (void *)umem;
> +		return ERR_CAST(umem);
>  
>  	n = ib_umem_num_pages(umem);
>  
>  	mr = __rvt_alloc_mr(n, pd);
>  	if (IS_ERR(mr)) {
> -		ret = (struct ib_mr *)mr;
> +		ret = ERR_CAST(mr);
>  		goto bail_umem;
>  	}
>  
> @@ -542,7 +542,7 @@ struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  
>  	mr = __rvt_alloc_mr(max_num_sg, pd);
>  	if (IS_ERR(mr))
> -		return (struct ib_mr *)mr;
> +		return ERR_CAST(mr);
>  
>  	return &mr->ibmr;
>  }

I don't think this is really necessary. You are not making the code more
readable. It doesn't simplify things. So I'm not going to Ack it, but I won't
Nak either.

-Denny

