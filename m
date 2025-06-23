Return-Path: <linux-rdma+bounces-11529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDAAE3525
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 07:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DB916C230
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84981C84A1;
	Mon, 23 Jun 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOvhoQl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGcsQWIt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AC52F88;
	Mon, 23 Jun 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657704; cv=fail; b=nt7j0KudIaaE5VVdbmCBIMi5KATuqYN2fndwsXjZk71DkoSi14HoWkww4r5q7RKs/idVaNy6V7tu2DlqNy8By5ttxJ6Ty+Nb+jlhgfMCGN/0qDJLljuKXqvofx13Y2xzvie/32X//63TkIb67k8NSzFzkc6Eh/hBPENZJWNlZz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657704; c=relaxed/simple;
	bh=0QZjyMcx2jeUvc+Hn9GQ5ibX9r1o1W/1JgzOu1+vqJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HX4b0babA1cSXVoIjRsZVUyE16v80JIwbPfYcBCElFdhKPRhgg0zVBbkbKX71ZodV8pRd/zn34LctXlG+C1HBqNgiHvbGqmW8Ru1j30aqEXk6EXon++o9OdZV4ACOe3JAFWGsdG5pjTVUvakf4WEWQr5rHVFt+/REDDYtYL+1nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oOvhoQl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGcsQWIt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0Qmw6018676;
	Mon, 23 Jun 2025 05:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rk7w01+QPLiYnO14M0Hng4tIW047L782UqHrGB1+Iac=; b=
	oOvhoQl+gzkSFvhDnemvuPLHC2nQb+vr26WZZoioUkwNRQVSdkh6i4kGdTWpBRxw
	+4ZXvc7b8u77EiCvopecOHKMUYnoLGmItTIdcCzH6U/m2Kmil4N4yN2XBl2oLqqZ
	Wq1eTxsoyY1ygpPEJoltBew4LVgttm+/0gliTpUc5az/XKTkOaFF3Rt/nEPPkQdB
	wmESbI7OeGDi6DS3gOJeXcDr6p9v29+p3YkhFOQbuSXZ/pHr1q4J9HveLM5i2LuI
	q+QoxXQJf7QlNGXYDbzZNs3UnblURZWz5uqXa7sUHBThlJMCsUznUzesZoWOM0Bm
	DPStJRiFYCoGGLROMHKDVw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87sxbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 05:48:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4h9xd026079;
	Mon, 23 Jun 2025 05:48:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvudhjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 05:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDvHoqiDJRa52B+DEbIFFE1adFv5/ZW5ShbbexVa4Zpnw21x3/uJevo65JzFBvmvQqYOHhA5GqLPLraSGNIWMQ+moVfiytdumhfmeiIxMXliKk46s7mOiZYij/wVX9uWfSpRH3X2UGYNTPAybSrM4097FzVK3D6jy15ELObFlZs8XlgSfBgu54gIkpspmiMRgpynb+MFSCLmu7u0nVcDiReobLn7F3OoT5bgAfjH+Kk3Oew8LcO/tIcO27fh3dyvKAXI3zq0aewuCjhQ4D+feGSk4pIr92aNwIJjAtpixGu+JwRMR0VHbnJUh2g1tx5h6sB89ISbnQUbTD4ngy0wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk7w01+QPLiYnO14M0Hng4tIW047L782UqHrGB1+Iac=;
 b=sz2KbfPgQHmMFHojme+y4RaPdNuKzjUVZRtsdQXidU3xQBicxuh46MTzKqszf1yxKrIZlFbsxEeyuwBafqJNZf0cH2rhy3bQGRhaP2N1eZOn8XxkhVOFGxbPC3/U3zd6H/u4oE9roRX/j4Pc68udHV/d5fDJDb1woxmFpBKoNgJoBYNHSA2UnXHlGw+DXZEE5IjC7u9B2OTyv51mahZ4Q90sEwdL94viodUiKK3X0dUtnktrFWG8+WSaJU072LlSmXV39Y9zrmUEahCAJ+e7ahSF9er7EeryZePCeep5VfdUrHi5f6J+n0yVLoSCA0vsskPJJ19Cr1V5GRZRCEzHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk7w01+QPLiYnO14M0Hng4tIW047L782UqHrGB1+Iac=;
 b=fGcsQWItEHWOKB60jch9Cbtl/1rhD/+E4VIrCGd0yHH6QGF7k7RioMnABY6NSTG8QW5NGSIJ/2tb8dmKTD11w8GnD1GMW82qvRnZURvnS+382ZdfohmbSH1v/+zYWEywGpP7K20RMXVbke7627IFIhVIPvH6XBwYA8AAPuAiqBw=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.21; Mon, 23 Jun 2025 05:48:00 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:48:00 +0000
Message-ID: <e1afda58-56b8-426a-a8e0-65e6609e9875@oracle.com>
Date: Mon, 23 Jun 2025 11:17:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
        netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
        shayd@nvidia.com, elic@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, anand.a.khoje@oracle.com,
        manjunath.b.patil@oracle.com, rama.nichanamatlu@oracle.com,
        rajesh.sivaramasubramaniom@oracle.com, rohit.sajan.kumar@oracle.com,
        qing.huang@oracle.com
References: <20250610143859.957848-1-mohith.k.kumar.thummaluru@oracle.com>
Content-Language: en-US
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
In-Reply-To: <20250610143859.957848-1-mohith.k.kumar.thummaluru@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DS0PR10MB6056.namprd10.prod.outlook.com
 (2603:10b6:8:cb::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6056:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ce14a9-017a-41a0-6f1d-08ddb21982e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXNveFJrNitSdUx6QmtMbHRzTVQwSUNuMkxpYXQwZXUvaDUxQS9RN0NOeUZZ?=
 =?utf-8?B?L2Q0OWIyamhYUFZveVFUM0pOVmtEa09BenVxd1B5Yko2Mk5nMkRveHpJaXUw?=
 =?utf-8?B?RkpNMDNjQ3RpSkR2L0JTVkRCSmlDL0pzYUs2M2pCTzBUUUx4MktpK1dXM3JF?=
 =?utf-8?B?dEZVcmVkcURrMjNhT0JmTUlGcEEzdUJRUjRQdVM2aHpKRDFrazNJN3lOYStI?=
 =?utf-8?B?SXlheU1aQ0UvdnBXNm44Qk5YcjVjUWx4NjJ6SkxrQ2VtR3RoMXNCSnVNV2c4?=
 =?utf-8?B?cVA5dnQ3UHVjNkpZM2E4MWlxbTFqelp3bzdNS2VScU8rK3FhSHN1SVNZaTFy?=
 =?utf-8?B?YzUzV2JJL0xYV0NwK0VQNnFxRHpoUHN1cEMvUEFKMEtGc0s0Njd2THllMSsv?=
 =?utf-8?B?WXFXSzBlOTErSmhrNjNvYjBsT21HSXkyQmw2VE1BdkRpM3c5UmovTXYrdWxW?=
 =?utf-8?B?M2Q1T2FEZWJMcm1FOU5EUUFiSHJIVHgxU2E2MWd1QXJwZlVMZnAwTWprbkZW?=
 =?utf-8?B?Tyt2YmdDNlhyRFNBSUVTZDcraGl1ZXJvNXJJK2dIRW1XcTVOeXFNUjk3UlU0?=
 =?utf-8?B?OThTS21UM2ttZ0t6b2VJUHdpTWlKRER0Y1MrbjFVTFIzM2dYeFljV093WlRq?=
 =?utf-8?B?ckVnOUFkaTVxQkxDdWNNbXdsQ2UrV2dUR2tleE1LU3IwOS9GKy9JNUJRL01O?=
 =?utf-8?B?bkYwR2hUeThsOVFoMmZvUFlaQWFHb2EwS0drUjg1eWVPaTc4dUhCQ1dUZ1Zh?=
 =?utf-8?B?RFVNOWNBREpveldBakZLaW9CK0JMRkcyRHZUMUlUNTdtK3VTU3Y2OUp2eDFR?=
 =?utf-8?B?bzV0a3lYOHhNVGpvRmpjMmRobmpuM3BxWUhJSWZNVFVFazFTSTRWZDdFK3ht?=
 =?utf-8?B?bGlweGRzOGRIdXkxVzFUMXFEZDN0REZwd3FocEpDZ2l6OWg4bkJWYmpjeklF?=
 =?utf-8?B?MHRJZCtjZldMTGRDY25xWmJzUjJISEhsa0JPZ29nSjZPdGVGcUhaYzJxZi94?=
 =?utf-8?B?ZEVkaWVYbmJVd1ZPTjI3NW1oLzR6anJ3ekZnbkVuazRoUlI4Q0lZNzFLbENP?=
 =?utf-8?B?UytZVEZWN1NlcXdvdU9ld3FsUlQrUjRLMXZuWG1oZlpKU01INzlQK2lCd0R0?=
 =?utf-8?B?QzYvY3dsK2JLL2FqNHNOR2hoSFpXQjZtQm9BTU9ZSlpiaUdSVjRsTHhyYTlT?=
 =?utf-8?B?SkI2WlVXV2o1NHlLL1BJZXJDYTRwNTR4c0h6S2JhS0R5OWpTWnp6cjNCYWFt?=
 =?utf-8?B?Q0JIVlc3TjZ3cHN4MmVBWUhUWjFwU2V4cEdORFUvS1dTT0FhVVI1TW15cWtm?=
 =?utf-8?B?d3U4dGQyTG0wWHd1a1NnMERybEora3hacUhsR2h4cTZqQ1RSV0pldlVRdXJz?=
 =?utf-8?B?b3V6R1JmazlVZU5zRFZDY3VqSXRpcloyNEpzL1U3Q1dJaW1PbUxlQ1NlYzFh?=
 =?utf-8?B?N1dQSGxwVkNlcjkxM0ZQcGV0VXFITlhBWGFqWjdtcFI4d0ZROUowS0pZckR2?=
 =?utf-8?B?TjlQaS9GcTFBdDE5Q3hQZURFQ3AzeFhERGIvcGFST0FJZE5scFhSZWRYYlZ5?=
 =?utf-8?B?aEdIVVBUc3UrUHRCQ0szczIvZzRRWkJKUXVidmhSdHB6UC8zQjEvN3I3Qnpu?=
 =?utf-8?B?dFJPbWM0emFnM093Y0hJMjY1TCt1Ujc4eTdaN1VOeGc1WjBKWUpjUmlueFpW?=
 =?utf-8?B?c09pM2Rkd1NsWXZ2OUlaRHMraEt3TFFnQVNBYzErQ2VKSGtaT0VZQXJnU05Z?=
 =?utf-8?B?emJMdWlBMjhvUUJMbEtDUzd0Vjc3OW9MalZPaGgxblhteXpvV2t6cjZUR2Fp?=
 =?utf-8?B?RGtES1VoS09YbFlQZDg4UzFhamxweFdyZUpmciswY3R0SHhnZFRiSGwyUWZ3?=
 =?utf-8?B?QWFhTGpzVzJzMENBaVZDdkYvQXN0NHIxUmNZZmpha2xGMG40ekxiQVBpK1Qr?=
 =?utf-8?Q?yaQCZuQ2VPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUdiVEoyWVc2WmxrYnlEWE5kUnpzTnUxdFN2N2NVMkRiVjdLeDVjKzlYU21K?=
 =?utf-8?B?WU95N0dnUnlBdVdQQUJKdU13ZTRMaXJHOVdLN2oxZEpOWFUyZDFyQVBaMVpr?=
 =?utf-8?B?dUlTNG9laGdGN0w0RWVMQ2ViRFJrNzZ2ZzdQaXBOYi8wd0tGM1UwOEQ2Y0NK?=
 =?utf-8?B?d3paNDlNSXNIMkl5YWlVZGYyeFRGdmtabTB1bzRXVzVDbGFNNEZVVXN3a3R0?=
 =?utf-8?B?WExqbVI1cWtZSnBQRXBkNk00T2prZlJrM2VIc043eHJNWDB2V3Q3SDRkYVd0?=
 =?utf-8?B?SXRtaHE5dmVaUlh6SHF1VWpiVFQ4c0dyVkRNTFV1RXRZS2tqMWtjK0hObC9h?=
 =?utf-8?B?UGFSZ1E5bllEZCtIbFF1b1FDczZYYjVTVHNKeFA2VEhCak5xUlk3Z2RoaGg5?=
 =?utf-8?B?MEdxa1pLZ1J0QVRqcFhJREZUY3hlNldBODZqZmZzK25Tc3krL1FibjkwclhU?=
 =?utf-8?B?L1lSSWxBTGc1RlQ1dHF1T0p5VWxQTExPZnJRelYwc2FwWUh0alRObXpYU3h2?=
 =?utf-8?B?QUI5VDlOejJlUVBvY3V3LzBGS0VJZUowR1prajd3eW5kWVhNNVhmNWFlVHlp?=
 =?utf-8?B?WE1xUjg2K0E0bE1oZFNzRU5hY0lUTWRuQzBhak1BcTdOcFc4eWNXUFdoMnZF?=
 =?utf-8?B?ZW1xeTJub1RZYXM4cERZczAzMUI2SWd3bHBsZi9LaWNIS2pMeFkvRDlwZkFk?=
 =?utf-8?B?RCtjUXZ4VzNKZ3VVVjlCNkM3bWVjS2RERlYrRVJLTURna2x1T09KRjNUQTdl?=
 =?utf-8?B?MU10TG4wWWFsOWF3d1M3bHFTUC8zNitLZFl2QXRrNVB1MjVDZmUzblg2RGV3?=
 =?utf-8?B?QzZXRmlFQ2RsNlZ3cWZNVThXdktjalAzTXpFWXI4UGdqY0JvTXowdXpBWWxo?=
 =?utf-8?B?b1l2dy93ZXdpNVcxQUgrVGI1Y29tK21SUVZub2ZySU1Od1VjNDJUdzRoYUFm?=
 =?utf-8?B?SGdvd1QvSFpHVXpsNUJiR1lkSFU1d0ErVnBjODlUVVRNOGxvenZDd2tMc2kx?=
 =?utf-8?B?aXhqQTAzMUMyQTRPNjF6cWV4UjNLWUFIcjlnS3lMaTFkMzRiYlNMa2wwbUdJ?=
 =?utf-8?B?VjY5ZDBkQk9sTE5SUXRpajhSL1UvNzJjRXgwOFdwaG9aRUtveE5ML3ExcVFm?=
 =?utf-8?B?d01raFZCTzQ1ejlvZ1QzRXBRbmhtVlp1UVFTeGdFdlpRSnpyeE9GbkFFMk1T?=
 =?utf-8?B?RW1JYS92ZHhmWDY1bWVPdzhhd1FvZXVwdGVWVXh1NEt3S1YrUWFFZzlZdmpu?=
 =?utf-8?B?dVN6NVVwT2FFdUl3TS9CbTlma0JNVXlRSC9WZksraWRTY3pwZWxEanhEUldj?=
 =?utf-8?B?MHNwbFZPMGY4UXU0VnBXYjJRNXB0ODU3LzloMGl6NzBvSnBENHJjMGdIM0Y5?=
 =?utf-8?B?S1dGNmlycUVwVEVSbzRNMTNxOFdsdzU1WThjbUVxT1VadHVsVGN5VEZ3SUp6?=
 =?utf-8?B?TldlZ21Kell4MUhJUXRqeHR1bWNuUTA3YnZYZkt4S1NjQlRtQ09tVTJ1NENs?=
 =?utf-8?B?WkhDdE0wS2t2TWVuWS9OR0U5Q3djdUZXTy9nazFwMHk4VmI5RFRMb010bFQ4?=
 =?utf-8?B?VVlDb0s5ZTlYTFdlUzB2K0VmaTRNUTRCYVdmVFJ3VEUyc0E0d3BYcExIQmlR?=
 =?utf-8?B?aERQNE9qNUxTYXVHS09WcnN4V2tPNHk0RkJJa2NSVk5jdDN0Mi9qcXZzMWJv?=
 =?utf-8?B?R1NYWG5qbkt0RmJmajVPYk9lMy9SejZFbVRFcjI3czNNMUh5VzRoUlZld3NI?=
 =?utf-8?B?MXg4QnErcmtqWnJ3WVhFQXpVenlvSHI1UDJ0UUtVWHROeEVsRmk0TnpaNC9N?=
 =?utf-8?B?UWFLQVduR2ZRMEdBNHkxRi9UWmJ6R3FFSTdLVmo0K1ByYlF1N1ZKcnlIVnRo?=
 =?utf-8?B?SkQ2NmFrTWRQTWtScW96MnJGK1d0cDNnazhNM0NqZDN4RGRaY1BkNXU5SGdQ?=
 =?utf-8?B?aHFBengzVzJlbHpscUlvVkM5T0RSZUg2aGRPV2FmWml3REJVb1c2elBTeWNH?=
 =?utf-8?B?L0V5YjVNdkxQaUlteEg2dkFXUmNyQjJ4bzBzVmFsT0F1Y3F4TVh6TVg3UUda?=
 =?utf-8?B?QlpUNUZPeFZFU1cxeWp6ZEVETkZiYllaUzkzN1hSdW9CbzRDQlA2OEpxcnRs?=
 =?utf-8?B?M2hPeG5POUNqQ29XV3hEYlo4WHB1TWx3eTdlb2NPVEt5V1VydWEyTHpld3Bn?=
 =?utf-8?Q?2AGqqtg9cLCYi14zfparkZo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/RLYucxg4gTACr/uwJPNR7g/jG/xhRqsaE52gxRptHAiHWzBWvXZNs5fuuHIm/xNdiIKsP8bev5NqPO6ujmIO5SyZvhtcUx2ZCZ6TcF8c8OTPg7fmK1ckT7e/zxtuFwmQe2OGuYIBv9pKGVfltaMsobXjcg7bibsEmfVOHzU/kuUESu9mT9qKCuI+7jb7ljz97Nazd1fku9g0fK630lNptVzpoCMeI4k2uAkQD+9bsx4rxfh9D3JnFEzljM4Cu+QuDU3Aj84JnoBaqDAEZahImaJgfe9MXPtmn4rSl1ObCmj/EdOhzXS+iuI7zD47EbSU7wVt/NP6+NJsxwZ7DWVR1DXpmXgmdSXhMUxR7evNVUU86IQeeGLal3lId01oWlj3haCa47CYuLsveieDiVMFmQvUkwEkAY7JrxlIg2HQJw+17yEUr9DIOZ1un2HLnkBezMaBR6u556LFcD3jI/KkASgFoGSCR3GqgFUkG63l/doltOGuSpWVOpGNj66Qus4nn4PS0ucX2KmOSRda+cyXIS95uMW1wAXDZygT2kyWw5/RW/7PKLJgbij8IiN+4D0E/9jeWAkpF18h3Bjpja2JbZzW3u6zCXUEzlmknWO2KM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ce14a9-017a-41a0-6f1d-08ddb21982e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:48:00.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQpn1qdfD3xJSD4uvWByty62lIyWAWNJJEzipu0/hEPSNOf1Ylq1j8ZMxTkDt7TNkFBwsjNYhkukoAJafEUXE/yoonYzhKGbvxYzgnj/bp4Y6yj3o4ITmMUfEiNlON2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230032
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=6858ea94 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YZ1Oz8W861sLCC07urIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzMiBTYWx0ZWRfXzzXLqh5lm9Bu O0EmKEGzJdQkUWY0q3tE2Bw0sV10jUdZujiAriZonLSwdqZBjiGJfa0uuAdR5Tiqix2ow79sAip 07UEk3OMYGl5Ak4NPcHtdYto0jPL+Dyfye0GV5v3t1R7DifQvadPPxyqapphnl3L7IZe1M6Y7ZF
 mS6DvxGfpsjzj8gU4dUOvuA/lu52aEuyiDh7DNLH/7g2d/Z3VH50n6Iwagh/WSQB8kR3aM8c8/S WWfb9qvXRG5W7nwhcMZK3emi3Ler9zGfQckyCqyJGFhCvQIsaNzAzPZL6xC2iziVlY7V7wEUHDw jXYKUI+kR9w8ijK32BldXbSL/XVnQUPE/ER6/IN2GjpfC1DGOPLQQI8jf7ZaA3IiHRm0RG069vw
 4TvuMnD9fw/bvzRLy3/DdpQVgYDAlSP0TsmXtfMPINFfPbq5Q/Z29ENNoi3UDqnzFVBNNkZY
X-Proofpoint-GUID: ektkoP5smkIat_u7h47ZEwENUld-u_ey
X-Proofpoint-ORIG-GUID: ektkoP5smkIat_u7h47ZEwENUld-u_ey

Hi all,

Just a gentle reminder regarding this patch. I'd appreciate any feedback 
or comments. Please let me know if additional context is required.

Thanks for your time!

Regards,
Mohith Kumar Thummaluru.

On 10/06/25 8:08 pm, Mohith Kumar Thummaluru wrote:
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
>
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
>
> Note: This error is observed when both fwctl and rds configs are enabled.
>
> [1]
> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
> general protection fault, probably for non-canonical address 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Call Trace:
>   <TASK>
>   ? show_trace_log_lvl+0x1d6/0x2f9
>   ? show_trace_log_lvl+0x1d6/0x2f9
>   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>   ? __die_body.cold+0x8/0xa
>   ? die_addr+0x39/0x53
>   ? exc_general_protection+0x1c4/0x3e9
>   ? dev_vprintk_emit+0x5f/0x90
>   ? asm_exc_general_protection+0x22/0x27
>   ? free_irq_cpu_rmap+0x23/0x7d
>   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>   create_comp_eq+0x71/0x385 [mlx5_core]
>   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>   ? xas_load+0x8/0x91
>   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>   mlx5e_open_channels+0xad/0x250 [mlx5_core]
>   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>   mlx5e_open+0x23/0x70 [mlx5_core]
>   __dev_open+0xf1/0x1a5
>   __dev_change_flags+0x1e1/0x249
>   dev_change_flags+0x21/0x5c
>   do_setlink+0x28b/0xcc4
>   ? __nla_parse+0x22/0x3d
>   ? inet6_validate_link_af+0x6b/0x108
>   ? cpumask_next+0x1f/0x35
>   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>   ? __nla_validate_parse+0x48/0x1e6
>   __rtnl_newlink+0x5ff/0xa57
>   ? kmem_cache_alloc_trace+0x164/0x2ce
>   rtnl_newlink+0x44/0x6e
>   rtnetlink_rcv_msg+0x2bb/0x362
>   ? __netlink_sendskb+0x4c/0x6c
>   ? netlink_unicast+0x28f/0x2ce
>   ? rtnl_calcit.isra.0+0x150/0x146
>   netlink_rcv_skb+0x5f/0x112
>   netlink_unicast+0x213/0x2ce
>   netlink_sendmsg+0x24f/0x4d9
>   __sock_sendmsg+0x65/0x6a
>   ____sys_sendmsg+0x28f/0x2c9
>   ? import_iovec+0x17/0x2b
>   ___sys_sendmsg+0x97/0xe0
>   __sys_sendmsg+0x81/0xd8
>   do_syscall_64+0x35/0x87
>   entry_SYSCALL_64_after_hwframe+0x6e/0x0
> RIP: 0033:0x7fc328603727
> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>   </TASK>
> ---[ end trace f43ce73c3c2b13a2 ]---
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31 f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> kvm-guest: disable async PF for cpu 0
>
>
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Signed-off-by: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..822e92ed2d45 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
>   err_req_irq:
>   #ifdef CONFIG_RFS_ACCEL
>   	if (i && rmap && *rmap) {
> -		free_irq_cpu_rmap(*rmap);
> -		*rmap = NULL;
> +		irq_cpu_rmap_remove(*rmap, irq->map.virq);
>   	}
>   err_irq_rmap:
>   #endif

