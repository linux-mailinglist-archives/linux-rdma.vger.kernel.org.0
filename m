Return-Path: <linux-rdma+bounces-2534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B018C8CD4
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC390281B3B
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB4140363;
	Fri, 17 May 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sw62eIp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FE1A2C19;
	Fri, 17 May 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974479; cv=fail; b=ug1bi4FMDY7LeO6IxetVh8FOJ7TlDJSBEmyZz7Lhq1vwX4s8/o5fzDARYmjnlM+MXjauoCtKsw7d/ETs58ZfP3fhfLzTfe6dYR+l6Sdilwyehn/JFPEf+0wXW5E29T7OHo3dhuUFI5AnWmYU+cIHsZYMO+24EWO7kvRMc5iZ4cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974479; c=relaxed/simple;
	bh=veYcGErAars0dQHYbF4osItCHaNFcqyUccdaplJYQgY=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BZGFFJuyWjRe1+/OWzlWfD28oJdU5GLUKXbSfs6mj3SofddE3jKGpKF32cRmKsfWs9r4Pxh5GEuzZkzPPR3Fjc24OhIxiNsrPQLBuhMiI1whH/6F2wfeqnMnRBw2s5e5CpPOrgBNhhfHhOF9WakCjJROAZw+Xnxa+PcaRCFMhCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sw62eIp8; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWnwJjXNapmh9qIz2/WEOKmvxTm/ougJJfFR/rux4FMzijy3KRk2AK/fxYBxxKEFOSrBYQragk5SAADHG4LYO42PU0KyoazcJTFwt6BEsXlBGaEtg4dw9NpSrvtXiErrwY/gBmM4vz9PKFImF4iIbejJcccdYEHab3KpDe1rDMfDOnlnp8zRS0htWgntxt9m7yV2ieLAMruZekjXHweNDVQftG0/1cHIxkQqNCdxYJxJV3UXgprG9TenSp730lyzbFvF858v4SM6u9YNyte+vNeYCUtOiswoVeza9kuGpj8iFAln9LM0g6/642Qu00YcixYAlu/RlhdlMF+WJ1TupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3A71csoHjYBIRt5mqWhucMhTk+Bhrq9seTXYRfKOso=;
 b=kdl8mFcrHyogNfCOnx74xWhP270SgKuR/c+FfZJJyeAffOypna611qfXPSkjDatPY038eaomkCRv5v4zY9UUm8hWte0H2ELVwaKupWXwMyTmurKoK1EMBkYNOO+Tdu8PNERYheyFFzHJS/2vEu60FTkKbCHMYUrXxk1rwW9Ha/cYMdtCHy2zy6uKs0angwMv/vhyZbroFVUpWIeJQmVZym2DUFPQPnSY81BYF1OvropZOcVGnHs7etSfIjgGimsVKXQ/vSG26KxvcxnpgY10tENg0J09GsirCeJFsqXQe3xQhEqUeFD5M/MTyy5UqGgYmXnTn3uJG3fgtzV1cPnzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3A71csoHjYBIRt5mqWhucMhTk+Bhrq9seTXYRfKOso=;
 b=Sw62eIp8xwiSBCvORWPJye3oXBddWkyFnfYC2A3kyd9luOHmgRVi/j8YUBKXjJJmPChuYeTnakP83LWCRaZEsZpHToPBwVT2tWfsXQQCyWpQekx7E1jYIhJIytzPgMVpMUqupKuFadt3+JY9A7ZHZAte2QN8qR14lGWTGuHRuqieCxqaVxpEEFCt2JpozX20X+Y2Bx2u20BZ1iqVLTx3j7EYt7seIodSRI2X2HKBRW7O5yOXyFpZTr/CDvfCb88eOClMXwMk7ixEim8yyn1jaYCOl/ykjXakXKo8umdOxZEA2ODh6cyYfu6JvfGSa04jNlp99rsMbHI7IvaICo0Kjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 19:34:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 19:34:33 +0000
Date: Fri, 17 May 2024 16:34:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240517193432.GA129526@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7eivyqra7RH6GoON"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: f0712d7d-f3cc-4056-d8b3-08dc76a860c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdPMUt2N2hNb21CZ0VYZWVybFE1SStLRkxPNHJKZGZMeDFwWklEdk5wOWs1?=
 =?utf-8?B?eTVLYnE5bStoM3Y2K2loQU12bnFQamo3K3lCODl6bG96OXd0LzNtc092S3p1?=
 =?utf-8?B?aDkzbUZLYTlKeFlOd3lGcXJuVnJTMEVzcXNGa1JRWmRFa01pL2RZTEtzSks0?=
 =?utf-8?B?eHF2Z0J5Wm1sdnVHN0YxRkVQWnNmVFdmcnVqa2puQ0JxQXlMOVpYaFFPSWJO?=
 =?utf-8?B?bitxVG5BSnhjeTE1dUxVYzEzZmJrM2paMDB5bjQwaU92T0kyVnpzZk5mWkE5?=
 =?utf-8?B?ZCsyQkcrWFJBL3k3cEVpRGdjeXl1MHBjZHd0ZlNDUUVSZ0N5MG43eVl5eXJG?=
 =?utf-8?B?eEs1WW9zQ094VzB0SjBNcEYyUWNsMWM0MXJCMkhZYTg1WFFiUk9sN2pyWW5U?=
 =?utf-8?B?Nlc3SEZoQTM3cHVvYWhYRGlia0JERllkRllUdkJoQmhoR05ielRCV0lZK2x2?=
 =?utf-8?B?eEkvMGdVNkh2R0tzdThnWDM4OVlDbFF4aUg1c0JTc1JLeHlOVE91UVNhaWxI?=
 =?utf-8?B?bTRvWDJORWxtNjUxQldBaytCL1JaQUcySnlJTjhVeGlOaXJEZG5ONlMvMmIx?=
 =?utf-8?B?dS90RUNheHlGWHphb3pLUU1tT2NXQ3YzREswN0FpcUx4eE5NbFBoVTZiK05V?=
 =?utf-8?B?Tm1NcVNLWkhnSUdsZTBLNjQveFp5Q00zOW1kT2I0bnVoTHh5cnZaSVZVWjZE?=
 =?utf-8?B?QnhYRWVQdklWNjl5Q0loVVlyKyszM3RsZmRheGhKbTl5NHNSeHVFUHBhZkJ2?=
 =?utf-8?B?YTJBRm50WUZRWitwaDErTTZHSkhpK3czN2UvVXVIMEhzbGFWSW1sM05OenFH?=
 =?utf-8?B?eE82SXZGMnR5a1JJM0M0MG5hTHRma3ozanN5K2V0NnlVcHBCZndRam1qZm1R?=
 =?utf-8?B?N2lETGNGT2Q0MW1QZFIxM3hZQ3JVLzRCak1LZ1hPUFNaaTZUWmh3YzQ1Rkxl?=
 =?utf-8?B?OEIrUUMyT2pueEQwUUpiQ0kxUXcvaHlKcDJHcjhRR29WdjVMWVV2UkZmK0VX?=
 =?utf-8?B?aUs1aWgycG9mUVRBYXFtZG9aU3dvQVNVUGIzcGJNTFgra0ljcythekhoU2tV?=
 =?utf-8?B?MExVNDZka3BKVXlLWWw3MHpvL1F6YWNIYjA4Mkx3U2xWV0JOYjBVMDgvMys3?=
 =?utf-8?B?RUNxUEUwdXN1UkJXTkRiTnhPeXRFaWpNZ2dtUWVCYWFtcFdoaFloR3ZNUDc1?=
 =?utf-8?B?MytaTUt5WWtmWlhFVmdUdUQ2VnpFMDh0dndOM1pNTE5SWXR4ZDluSVRpQjA0?=
 =?utf-8?B?cklJai9Wd3Y3SE5yL2N5S0VmRmlPYzFuaW42Q3I2TTdMUGlJZm1LREpwSGVW?=
 =?utf-8?B?dlBnMWVaejRYOWwwaDhBV055TGZHZzZra1NQSEtiSE1wNVpTTEs0dDhacFIz?=
 =?utf-8?B?T3dWWVByclJCdU51c1R4ZjJNcFJacVpXMlpsdEZrMUp1UzJlQjZKNVc0Wkh5?=
 =?utf-8?B?Z09JRVMzOU4wcTJqUUU3Rm0zVklZMEZtY3VISmRWZVFjOUZXTUpZekNWK0FP?=
 =?utf-8?B?cjU3cVhLSlIzWm0vNTVaVE04ODJ2eGoraXpjRnNzc2x4U0JYMEdFc25RMnAz?=
 =?utf-8?B?SnFXM0xCclN0d3FOSEFpakxxTlRVRDNnSVlna0FKdFhGVmoyakJKVjlram1x?=
 =?utf-8?B?dHIwOHR3ZkkyNUpIZDVEUC9qelNvSWlJMyt2QnBTY3NqTzgwcjdTRTR6cnJK?=
 =?utf-8?B?QW5rd2tWSmNzZ1FxNndidk5QNHFvb3NPWkx2Tjk1UmIyOVFIQ0Z2WGd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDU5bGp6OHk3dzhLdFVBeDBlajU2Mk9TdzdRekJhTUJmd2RJZ0c3dUJSY2pC?=
 =?utf-8?B?S0U4a1JNV1lLUkhMZ2F1RU5JL0FxWENqelllL0xramN4dXF3ZkxLdlZFd3pm?=
 =?utf-8?B?eE1ZQ2JLNml3a2NpM044ajFoTVpiOHdBbUthM3JSTXpQdEFGcG1jSlV4L1lF?=
 =?utf-8?B?Q1pVVGtHVlpHY0RDVmtwMXNlS0d3aHdoa0ZsMG5Wd0YxeEdPVjNoSnFuOWVG?=
 =?utf-8?B?YlBhM1Q2ZTUrNzVXQWE0T3N2b2Y1M1FxSUZmNUZIUVN2TTE1R01HYk16RktD?=
 =?utf-8?B?NTY0SE9yYmMzd2wxcS9wTTZQTVR4WjNrdXhEQjRTWFRvMFU1T3locm5JSG9J?=
 =?utf-8?B?NElRRGlicG8zdnFXMHk3NDUxRlVoUWN2MVVwTXZYSXNIbW9wQVZ0NlNmb2Iy?=
 =?utf-8?B?dEwwTVdWMlhkZThFWFM0WnR2cFcxazZmSDM3ZWVKQ0cyYmhwaXkwNFQ0YXdG?=
 =?utf-8?B?b1RTa3d6ZHBNYjNHVGFraE5Yb3preExRcndCYnZPWkJqRUhWdjViMHNiQytm?=
 =?utf-8?B?c1RhSENkcHZqNWZBaStTZTc0a3p5eG0yS0RLYVVJVjBHVTZ2Rmo5QVI2OUxt?=
 =?utf-8?B?Y0sxNFBEalhvVnNjeENiT2ZmYlVZTEl6NDZVV0pGc3dOVnZ3TTQrMG5DaVhy?=
 =?utf-8?B?TjVENjZTY3hwbHlBMSt4LzJzZ1QxbGJDODhSdzUyYzZuUUg0S2p5a2VjOWhs?=
 =?utf-8?B?bGdac1ZveXp5ZXBhL2ZxK3RXaXZPdEZ4UDZ5ajVpekFFSzBaa1lDcjBWdmVR?=
 =?utf-8?B?MW9tQU13K1BhR0VSNlEyL1lzT1JoZjczZmxTMVNqeHRPWjVFc3dTMVk1NjRk?=
 =?utf-8?B?YUQzOC80V1VMT1VFbFBnRzFUUldsTTlKV2g1ZGx0RVM0MitrU0h2ZW4zeUxj?=
 =?utf-8?B?VEZOR0VCdlZaUmZyc1dWTHlJREFENmVFWDNmclJJblpYRnZCMGdTOE1lUmhM?=
 =?utf-8?B?TGl1Tzk1dVFJdis4N3RsNVdkdEc3NzRKN0xnd1FGREsrOUhKcHJEQU82ZGN1?=
 =?utf-8?B?UWxXTUk4Slh0Q3JUWUZrbmRKclR1WEgvSXE0UzJMM0pBNmExTGpna0tuKzUx?=
 =?utf-8?B?TGtjVm9JYWE5bGVFUUhlenNRYTJtU1BpNm16NEdDOWYwSUhXNFNNajVXam41?=
 =?utf-8?B?aTRFUm1seGd6bFIxQldUQ1hlcUlWcXlQYmlNS2ZlUlRYc05oK3RhcmM0S3lE?=
 =?utf-8?B?aGY4U2Z5Y3pxN2xObWhFbVY5bnJGZDNMNE1MaUVFdzgxeUlaZXZDOHFxOS9m?=
 =?utf-8?B?MTJXWmt6WHNFMlpwUzY4ajBYZkg3OHJwanJ1V2hFK2Z6RGl0ZjgzN0ZoalhK?=
 =?utf-8?B?dHcvNWsrWWNCei9oQnd4djFhYVN5MUpXV2lTZ055bXE0RHUrOHpFb0pyK3Iw?=
 =?utf-8?B?SExHRGJOVVFlU0I5VEg1ZlEyMnZLVGR6ZEZndXdGam1yd3JGMkFMdzlPVG00?=
 =?utf-8?B?SmhIUCs3aU9uSHdaTFVMN2JiVE5Ra2ttbklLcDF2a216K290UU9QMVdKSFBN?=
 =?utf-8?B?bDk3MWdJVDY1NDZUL1NvR1dzWHVjNkxIRm00VzllUVpTMTRDbHdYUXBDWFFX?=
 =?utf-8?B?ak9wN3p1MUhERHdxMmhzMGFYOXM0alpyLzJWQ0FNSDErNUE4VlV5Q1NjRERD?=
 =?utf-8?B?VWU4d2F0TTlVdURjSjVrcThyMjNBdXllcVdpaWg2TUl3MTdiMU9lSERoOHlL?=
 =?utf-8?B?bGIvakdQa3kvcUJpa3BNU1VwSjRnTkUzb29xV1ZoaTlHcUxySGoyc0tuZHh2?=
 =?utf-8?B?MmZlK1FmQWtDVTAxMW52ZlZlTS80MG9QVkZ6MldNR2xZd0dRb0dlc2Rsamgr?=
 =?utf-8?B?TlVGYU1oUS85TThqbm56aHN0aHR6YmFMdjVPa3pKY0ZIYjg2RDdoc1dHMXlT?=
 =?utf-8?B?YnFOenBpa1hocHd0cDNpbnNxeUpkdFFjVG1ObjZ5QlBYZTRhUnJFaFlLYnhj?=
 =?utf-8?B?Y0VvUXNSNTkyems5WUJIVWgxdlZrV2hqYVVWQjllbEp4ZG1yVEEzWTdBS3BV?=
 =?utf-8?B?VmlNMkUyM01wSGlscnp4WG85bytuS0Y4K2FqK2FBSytsb0dmbFo4ak5RV0VL?=
 =?utf-8?B?L2VLKytnMytoWHhrL1B6cUtTSUREM2hSOWhhOCtmQ20vL3VxWXg4T0RnUUUr?=
 =?utf-8?Q?tqhYsL0WWbrfoh87Yp1LS/lAY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0712d7d-f3cc-4056-d8b3-08dc76a860c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:34:33.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRocGUh1k6naKJ0NezNySvVlRgRwyM/E50ZRemj5Af8tXvuw28Fz50Hdwz+cy792
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

--7eivyqra7RH6GoON
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Aside from the usual things this has an arch update for
__iowrite64_copy() used by the RDMA drivers. This API was intended to
generate large 64 byte MemWr TLPs on PCI. These days most processors
had done this by just repeating writel() in a loop. S390 and some new
ARM64 designs require a special helper to get this to generate.

Thanks,
Jason

The following changes since commit a68292eb431619a5f8db9d4868346837c5606424:

  net: mana: Avoid open coded arithmetic (2024-04-11 13:46:47 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 9c0731832d3b7420cbadba6a7f334363bc8dfb15:

  RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma us=
e siw (2024-05-12 13:04:11 +0300)

----------------------------------------------------------------
RDMA v6.10 merge window

Normal set of driver updates and small fixes:

- Small improvements and fixes for erdma, efa, hfi1, bnxt_re

- Fix a UAF crash after module unload on leaking restrack entry

- Continue adding full RDMA support in mana with support for EQs, GID's
  and CQs

- Improvements to the mkey cache in mlx5

- DSCP traffic class support in hns and several bug fixes

- Cap the maximum number of MADs in the receive queue to avoid OOM

- Another batch of rxe bug fixes from large scale testing

- __iowrite64_copy() optimizations for write combining MMIO memory

- Remove NULL checks before dev_put/hold()

- EFA support for receive with immediate

- Fix a recent memleaking regression in a cma error path

----------------------------------------------------------------
Bob Pearson (12):
      RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
      RDMA/rxe: Allow good work requests to be executed
      RDMA/rxe: Remove redundant scheduling of rxe_completer
      RDMA/rxe: Merge request and complete tasks
      RDMA/rxe: Remove save/rollback_state in rxe_requester
      RDMA/rxe: Don't schedule rxe_completer from rxe_requester
      RDMA/rxe: Don't call rxe_requester from rxe_completer
      RDMA/rxe: Don't call direct between tasks
      RDMA/rxe: Fix incorrect rxe_put in error path
      RDMA/rxe: Make rxe_loopback match rxe_send behavior
      RDMA/rxe: Get rid of pkt resend on err
      RDMA/rxe: Let destroy qp succeed with stuck packet

Boshi Yu (3):
      RDMA/erdma: Allocate doorbell records from dma pool
      RDMA/erdma: Unify the names related to doorbell records
      RDMA/erdma: Remove unnecessary __GFP_ZERO flag

Breno Leitao (2):
      IB/hfi1: Do not use custom stat allocator
      IB/hfi1: Remove generic .ndo_get_stats64

Chengchang Tang (7):
      RDMA/hns: Remove unused parameters and variables
      RDMA/hns: Add max_ah and cq moderation capacities in query_device()
      RDMA/hns: Fix deadlock on SRQ async events.
      RDMA/hns: Fix UAF for cq async event
      RDMA/hns: Fix GMV table pagesize
      RDMA/hns: Use complete parentheses in macros
      RDMA/hns: Modify the print level of CQE error

Chiara Meiohas (2):
      RDMA/core: Add an option to display driver-specific QPs in the rdmato=
ol
      RDMA/mlx5: Track DCT, DCI and REG_UMR QPs as diver_detail resources.

Ilpo J=C3=A4rvinen (1):
      RDMA/hfi1: Use RMW accessors for changing LNKCTL2

Jason Gunthorpe (6):
      x86: Stop using weak symbols for __iowrite32_copy()
      s390: Implement __iowrite32_copy()
      s390: Stop using weak symbols for __iowrite64_copy()
      arm64/io: Provide a WC friendly __iowriteXX_copy()
      net: hns3: Remove io_stop_wc() calls after __iowrite64_copy()
      IB/mlx5: Use __iowrite64_copy() for write combining stores

Jules Irenge (3):
      RDMA/mlx5: Remove NULL check before dev_{put, hold}
      RDMA/ipoib: Remove NULL check before dev_{put, hold}
      RDMA/core: Remove NULL check before dev_{put, hold}

Junxian Huang (1):
      RDMA/hns: Support DSCP

Konstantin Taranov (18):
      RDMA/mana_ib: Introduce helpers to create and destroy mana queues
      RDMA/mana_ib: Use struct mana_ib_queue for CQs
      RDMA/mana_ib: Use struct mana_ib_queue for WQs
      RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
      RDMA/mana_ib: remove useless return values from dbg prints
      RDMA/mana_ib: Use num_comp_vectors of ib_device
      RDMA/mana_ib: Add EQ creation for rnic adapter
      RDMA/mana_ib: Create and destroy rnic adapter
      RDMA/mana_ib: Implement port parameters
      RDMA/mana_ib: Enable RoCE on port 1
      RDMA/mana_ib: Adding and deleting GIDs
      RDMA/mana_ib: Configure mac address in RNIC
      RDMA/mana_ib: Fix missing ret value
      RDMA/mana_ib: create EQs for RNIC CQs
      RDMA/mana_ib: create and destroy RNIC cqs
      RDMA/mana_ib: introduce a helper to remove cq callbacks
      RDMA/mana_ib: boundary check before installing cq callbacks
      RDMA/mana_ib: implement uapi for creation of rnic cq

Leon Romanovsky (2):
      RDMA/mana_ib: Add flex array to struct mana_cfg_rx_steer_req_v2
      RDMA/IPoIB: Fix format truncation compilation errors

Michael Guralnik (1):
      IB/core: Implement a limit on UMAD receive List

Michael Margolin (2):
      RDMA/efa: Add shutdown notifier
      RDMA/efa: Support QP with unsolicited write w/ imm. receive

Michal Schmidt (1):
      bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq

Or Har-Toov (3):
      RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
      RDMA/mlx5: Change check for cacheable mkeys
      RDMA/mlx5: Adding remote atomic access flag to updatable flags

Wenchao Hao (1):
      RDMA/restrack: Fix potential invalid address access

Yangyang Li (1):
      RDMA/hns: Use macro instead of magic number

Zhengchao Shao (1):
      RDMA/hns: Fix return value in hns_roce_map_mr_sg

Zhu Yanjun (2):
      RDMA/rxe: Return the correct errno
      RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdm=
a use siw

wenglianfa (2):
      RDMA/hns: Fix mismatch exception rollback
      RDMA/hns: Add mutex_destroy()

 arch/arm64/include/asm/io.h                     | 132 ++++++++++
 arch/arm64/kernel/io.c                          |  42 +++
 arch/s390/include/asm/io.h                      |  15 ++
 arch/s390/pci/pci.c                             |   6 -
 arch/x86/include/asm/io.h                       |  17 ++
 arch/x86/lib/Makefile                           |   1 -
 arch/x86/lib/iomap_copy_64.S                    |  15 --
 drivers/infiniband/core/cma.c                   |   4 +-
 drivers/infiniband/core/device.c                |  10 +-
 drivers/infiniband/core/lag.c                   |   3 +-
 drivers/infiniband/core/nldev.c                 |  23 +-
 drivers/infiniband/core/restrack.c              |  63 +----
 drivers/infiniband/core/roce_gid_mgmt.c         |   3 +-
 drivers/infiniband/core/user_mad.c              |  21 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c        |   3 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h |  11 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c         |   3 +
 drivers/infiniband/hw/efa/efa_com_cmd.h         |   1 +
 drivers/infiniband/hw/efa/efa_main.c            |  11 +
 drivers/infiniband/hw/efa/efa_verbs.c           |  19 +-
 drivers/infiniband/hw/erdma/erdma.h             |  13 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c        |  99 +++----
 drivers/infiniband/hw/erdma/erdma_cq.c          |   2 +-
 drivers/infiniband/hw/erdma/erdma_eq.c          |  54 ++--
 drivers/infiniband/hw/erdma/erdma_hw.h          |   6 +-
 drivers/infiniband/hw/erdma/erdma_main.c        |  15 +-
 drivers/infiniband/hw/erdma/erdma_qp.c          |   4 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c       | 105 ++++----
 drivers/infiniband/hw/erdma/erdma_verbs.h       |  16 +-
 drivers/infiniband/hw/hfi1/ipoib_main.c         |  20 +-
 drivers/infiniband/hw/hfi1/pcie.c               |  30 +--
 drivers/infiniband/hw/hns/hns_roce_ah.c         |  33 ++-
 drivers/infiniband/hw/hns/hns_roce_alloc.c      |   3 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c         |  25 +-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c        |  17 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h        |  12 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c      | 154 +++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h      |  15 +-
 drivers/infiniband/hw/hns/hns_roce_main.c       |  32 ++-
 drivers/infiniband/hw/hns/hns_roce_mr.c         |  19 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c         |  29 ++-
 drivers/infiniband/hw/hns/hns_roce_srq.c        |  12 +-
 drivers/infiniband/hw/mana/cq.c                 | 111 ++++----
 drivers/infiniband/hw/mana/device.c             |  51 +++-
 drivers/infiniband/hw/mana/main.c               | 328 ++++++++++++++++++++=
+++-
 drivers/infiniband/hw/mana/mana_ib.h            | 147 ++++++++++-
 drivers/infiniband/hw/mana/mr.c                 |   2 +-
 drivers/infiniband/hw/mana/qp.c                 | 114 +++-----
 drivers/infiniband/hw/mana/wq.c                 |  31 +--
 drivers/infiniband/hw/mlx5/main.c               |   3 +-
 drivers/infiniband/hw/mlx5/mem.c                |   8 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |   3 +-
 drivers/infiniband/hw/mlx5/mr.c                 |  35 ++-
 drivers/infiniband/hw/mlx5/qp.c                 |   3 +-
 drivers/infiniband/hw/mlx5/restrack.c           |  29 +++
 drivers/infiniband/sw/rxe/rxe_comp.c            |  32 +--
 drivers/infiniband/sw/rxe/rxe_hw_counters.c     |   2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h     |   2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h             |   3 +-
 drivers/infiniband/sw/rxe/rxe_net.c             |  69 ++---
 drivers/infiniband/sw/rxe/rxe_pool.c            |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c              |  46 ++--
 drivers/infiniband/sw/rxe/rxe_req.c             |  82 ++----
 drivers/infiniband/sw/rxe/rxe_resp.c            |  14 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  17 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h           |   7 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c       |   3 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c       |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |   4 -
 include/linux/io.h                              |   8 +-
 include/rdma/restrack.h                         |   7 +-
 include/uapi/rdma/efa-abi.h                     |   7 +
 include/uapi/rdma/hns-abi.h                     |   9 +-
 include/uapi/rdma/mana-abi.h                    |  12 +
 include/uapi/rdma/rdma_netlink.h                |   6 +
 lib/iomap_copy.c                                |  13 +-
 77 files changed, 1584 insertions(+), 768 deletions(-)
 delete mode 100644 arch/x86/lib/iomap_copy_64.S

--7eivyqra7RH6GoON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZkexRAAKCRCFwuHvBreF
YbzxAQD2gi3f8iLSHpTKaPOHIXWiM6x7+LYWHYrgcEvEF8MnYgD/avE6Wj2mL2cQ
i/H3ZQpzVel9vK79Ou3k/VUHnsy5sgg=
=EW+n
-----END PGP SIGNATURE-----

--7eivyqra7RH6GoON--

