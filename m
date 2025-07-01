Return-Path: <linux-rdma+bounces-11807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991EAF019B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 19:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D7A441BA3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE327E071;
	Tue,  1 Jul 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="R35bHkbM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193C27D77D
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390377; cv=fail; b=ojcir/26oJUA+aKKsYGt5ArFqup2G78pAQnakM85lOF3Sl3jc657bAJmNCy7CuiisPSNSKcYhDBNbkZkEuEVeWnV/dmv6QR6WAHSvb963y+7iUW4Ad1bLGL5DI4gvp1MHNqhZFQYsp2JsBKdCXzJ9gpeHJsNbSRUfcihqVRykRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390377; c=relaxed/simple;
	bh=Z0TLqIXX+G77q0h9uJNcbxlwoBRVjCqmREQmvbFMnbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ul7UUY8MUdRZx684tMyh1ReVEhoxGHSIVd40+au4Aus69kZdq0gD8V24Nxp8ii1cLRFrQeA0uiJsnvhX+LoVVVtOPRLqitZuRIuMp4jxJynkdqrdiCywuyjsCbuSES6SNBdQj/MkfRIGFlOy9mNMbgnP0Mv9LETdUilJ1Xp+/MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=R35bHkbM; arc=fail smtp.client-ip=40.107.223.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK9MpAhhaXQ3FR3yyocThgBltqSYsrrZQ3mYUYuyJX7JCXPEtKWaNusFBR0KcM3+PBzs7fFwXnGCdsBLoZT32Lgo02G2IVLShOtDqgvyXd3wT85mMJkClqUqZypALzyevOfjcN/cOmALldgu3F5xiobEa5LTxXQOM1w9Tm/kxtxVtVgQSJpOXMM5+tc8j4hqjaIUgDXEIrP3/ogZGTcvYgMXhDarCs3jijBceYn3ajDfwOBNGc7+QCqfA9kq0/XwJzPba2kBnmGq286tM1mEkR8bgdOknGJ7AOq7zi+4ZzMf4bKOmsGiOsGaLH/9ngGkR8xu52TsGvGuJS1z7GgOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwDgKbq/k6HkRkpEe37jEivLWidoJ+HiN3xg0W2iAsc=;
 b=cuMqUPBPN4rlouHVOWgPRIVkXAHkOw64dI3m+OVlcnm9sMZtc5z/PvAisFr0lXZLhL5yxuz5oHOjZnWXBmoH33qBmLlSOeG8dhsNCxuyGLK8n6/m1mnVtuJhh80LnBuwiTsS2wbqedWtOl/d7LHE1JVeNCG+j8I55TJ01WxZC/sim7Z12hrdZz+aukEm9/Q7sPeh1m1X8aH986+P48hVnBYWc9VQzzsFWCuxgYabm4NJHMY1rTf8Q0PPonFgjp/8TjkPxWvZ2+8QvDPoIBEK96QRtKNSMwMLTKlpYEGumYUe4DIYgSIP9+Y6xSPyGvf6//4ebj6Le6VtVrJVNFGeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwDgKbq/k6HkRkpEe37jEivLWidoJ+HiN3xg0W2iAsc=;
 b=R35bHkbMK+Kx4lPpTsGulpAk2XqF2mNM5ePnQ+r4KlxQXfT238SRakBE9BDrFxEPArcGeDHT+IWe3SLnChUyle1eZ+lHn+uHV2BP5pFlmPoULo4CjgFQsfvxA1MgcO2b8YYfnRIokeCRomupZrXNjvju1rbAN0uG7f5NUaPOtiJ1bHwETHjVrY948MfyAoNqxFGgweZPRJBf6bpYGqGF1yHdUOHsCCzhfqlTKGYI0CmeuQ7oH3WRV5wQIsn5wpCnO9Fvks+ecQ+YM9w96SC7ZD2WWK7hUhZKnLa7EIHZzaBY3j7c7qK+S7HtpqFSPo0uQhDnP8zR3K/7d6DH3l3B1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 CO1PR01MB6647.prod.exchangelabs.com (2603:10b6:303:f9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Tue, 1 Jul 2025 17:19:34 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 17:19:34 +0000
Message-ID: <eabaf135-c3d6-4916-8eaf-f60fb4e12ce4@cornelisnetworks.com>
Date: Tue, 1 Jul 2025 13:19:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 06/23] RDMA/hfi1: Remove opa_vnic
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123853.GD6278@unreal>
 <5dbcf9f6-cfe5-42f5-880d-d0fd7e8bcb3c@cornelisnetworks.com>
 <20250701160024.GF6278@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20250701160024.GF6278@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::11) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|CO1PR01MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9d9433-8f4b-4e2f-ac88-08ddb8c372be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlByZDNxZVJnRFE3NVFRWU42NW0wZE53UzBBWG5MN1lrYXBHV1U0MWR2RFNh?=
 =?utf-8?B?VXdOVkduMnpQY1FwclM5UDI1MVczZHR4bEF3S1NQNU9XZXE4VXlNemhzdVRO?=
 =?utf-8?B?WWxPK0oxdGN5SmgwRWxncWxzNlNGa05RaVU0YWVTWEk2OVhIZkZGaE81ZEp2?=
 =?utf-8?B?TUVjaTJkUFNuYTFtMXRtdmd6RER1N3BzeHhiejRBSWtkVFcvTHUyUDZFWGI0?=
 =?utf-8?B?MmVCOXp3UzRDaDBEdnplWVZ6SEhVZlAxUXpSK1BDcGw2cUUrVE9SR0dSUkR3?=
 =?utf-8?B?aEQ1aGR6WmFGV0VrbjRJT3RURHNKNzFjOTlZTklEWk8wVTFlcEdzS2lRRWJI?=
 =?utf-8?B?M0hjZlJmQ3pEWkxHVFpCdGdhUE51VC9Wc2tXc2pqT3hiVjJmbmo0dExRMHpL?=
 =?utf-8?B?ejdwR1A1RSttODlmNExCejlJbHNRcGZScU1PVnIyaGJidXkzWVREUDZJMDhn?=
 =?utf-8?B?cWZEUkNReW9SSVQydnVoRDh0SkRTdDdlU2p6TFlXczdKZXpHNFczMGNSNXdl?=
 =?utf-8?B?UXlzR2tMcktxU3lQOWIzdUpMeTdpRlE5bUNXcXFTQ2x1L01odmZXYzNkUkRl?=
 =?utf-8?B?SzRiTS94WHR1QSt0L0MyN2ZIbXZJSWpWWnpyREVvUnMzV2FhN2hLVTBXQW4x?=
 =?utf-8?B?ektjYTBvOEtYNzIwcFNZNzZwVzlEMExUaEVQdXB3UTFaS1RRdjlRNGIrN3My?=
 =?utf-8?B?YXFaRURMZnpNOEZ2LzJ2MkJpYlBDeUcyMlcycllaSW5YUXN2Uy9ZWTJ1R2Nh?=
 =?utf-8?B?SElIZnkxRkxvNzBKYlZOeFZMdVlLZG1DclE0cFd1eXo0NTBnbEM5R0lXc3BI?=
 =?utf-8?B?UjJBWjVDL1FRVndBNmZkM1o0cEtFdjhFaDhhbkhOMjlldERNKy9ZQ08zUkYv?=
 =?utf-8?B?ZzFIaHhRa2RhUlRhZ1JJdCtFaC92b3BCZmF3TC9yUkY1VW5aZnZ0SHpBOVVS?=
 =?utf-8?B?TWVXQnJLZU5sek85dFdCMm5pNmtaN01hMW1uNUxzcjc3eFQ5eFBHd2RLcjdk?=
 =?utf-8?B?aDFHNTBzeTlSVDRYeTVtVDFkeUVvWVBUNVlKdHFtVnkrb000Y0lyRU1WMnBm?=
 =?utf-8?B?VnArMFphRm1aTWdmS0Fwc0RZQjJRdVdKbTJXK3BsQ0NiU3VSOUdabGpsT3h3?=
 =?utf-8?B?VGpMRUNJbnV3eWl4UnY5c2xwcHREaU5jdVZKNU8zcHRXVVNIVXUzZHh6a2lO?=
 =?utf-8?B?a2NJdzBxOGQwWGlGRjdtYlJxKzVYM1VrbHZ3NHRZZGRSeFBoeTFvMWlzdnJn?=
 =?utf-8?B?V0RzUkoxZVkyeDU1ZHEvalBNc1lJaUR4cmY2VG5WWmRVZ2N0aEtQVytQQlNs?=
 =?utf-8?B?R2lFb3IwZHhLYTU1bStRbHJLWGcwbno5Y3FhUWhDL1JIRTZMd2EyWXBHZXgy?=
 =?utf-8?B?L1BYalVlTDduWWpoR1ZLQUpLVm9RQUxlajMwV3k1SENsdC9GNXVCeFVodE54?=
 =?utf-8?B?dWtuaTVLcjNCSVMyNGF6ZXhuYzM3K3dxUmFWNXR0T2dPb01ic04rVGRPNHh3?=
 =?utf-8?B?YkhrTDdWeTErNGJCZDh0NmVLMk1kdUFBVHFnbHBWdVZEM2dxVG5zeGp1VURo?=
 =?utf-8?B?REdVM3RtcnFvZEVUdCtTRyt6MFh1QkVNTWQ0TU5sR2tnMnNuUDRhYnlmRU9V?=
 =?utf-8?B?cDRrb1UyVlhwT05SN0JUTWFJUFlCY2d6MWIvUFpsVVZuT0l0SFNYTzh1UWE2?=
 =?utf-8?B?R0JweHVUZkxwdHZ1UkNmZzloOW1URUpOVlk5Q3pITXBHczZGUzk5RWhxZHRV?=
 =?utf-8?B?b3h3c2I1bFB2VFdycHJCSWYzYmJSYS9WMllyMGRCZHRzRWJIRGw4MU0wT0o4?=
 =?utf-8?B?eWk4V1BNdUJQcThpbm9hQnRvRVRGM1Z0K0lmdXNCd1d6c2w0SHFGZVZQWTJ4?=
 =?utf-8?B?TlFEVDNhS1Nrci9KaDl1VmVXU1lxMWFtbytxZHF1YVkrN0xIc2FxZ3VmQUpK?=
 =?utf-8?Q?WIkxaeRKPUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVPVE0rY3VNbDdYbmdGRHcwL3BpeTRrSUZIOVp2Q3E3M21rL3c5L0F6b0NM?=
 =?utf-8?B?ZSszQWZwYjFVU25IZ3Nvd3FIcDM0bS9vNWk0SFI0SUNlMkwrQ2Uxa0V0Wnhh?=
 =?utf-8?B?Ykx0MlJqTVJxOGVYL2d4NUhkaFpjWThTYTQzdU5QTTBpRHUrRllvWWpFazJO?=
 =?utf-8?B?VFpSRVB2VUh1NVhWa1NtUkd1d2NITDFndGF5c3VIOGhQaVM4NmtQcEZXdjVI?=
 =?utf-8?B?U25LK2R2TFlQY0c0cU9SU1ZFZ0czUFNQcGZMdUNERFMyVThNYnFnYUFlSm05?=
 =?utf-8?B?eHZCK0lDcURvaHBMNWNVcEx0WWVpTEovVjk4Y1ppZXJuYXNyVmZTWlNEcXZT?=
 =?utf-8?B?MlJLOU5vN0Jwd2F6ZVFheENEVENxM2JiRG1NL2xxdmlxNEYrUy9VL1B3T3pH?=
 =?utf-8?B?Nmp6S3gxeFhRd0lLQUdZN2Zoa014Y2pqUkg0Tnhwblppem02SE10SWErTk1Z?=
 =?utf-8?B?bFRyUDFNamhNS3JFay9meWlOQ0k1TG0yV3VKRDRyYWdSSWVpSHgyRHp4eVV0?=
 =?utf-8?B?SWpZYU4yK1dwQ0trTXhtV2xtQ2NmSVRrZ0tMdGMvYXZIK24zblI5akpabkdM?=
 =?utf-8?B?RXNkS3NVcHJzMlNmaFVWU0JaOVZSaUkwWmUrdDRkQmhGeEZITEVXYS9GOE9C?=
 =?utf-8?B?L0ZZeXpDQTAwWGJPYXUydEg4MkNaMmRqUTg1UFFEWkRxWEdvME1oa3dmb04w?=
 =?utf-8?B?Z2lHRjNlM1AvdnJjVCs2K0h3VDJLeFBtQ0JSUFY2Qm5ha0E1WXBRTGRWS0NZ?=
 =?utf-8?B?UXdIaXdFdlFuR0hSWEJFc3YvdUZXZlRWMzNTVWlhbFRGaFp1YlJrNVExYnBw?=
 =?utf-8?B?WS9VUDFWaUpPbUJKVDkyRGdFMGgvTDM5K1NJRUVTSGh2MmZNV0NKYnd3WHlj?=
 =?utf-8?B?WmZyRVVjS2RWN1htUUhDL3Y0Qm12Z2JDNDdscUFhUHp5Z25vVWdXV1pTYVA3?=
 =?utf-8?B?NTVOell4OWtOTzFmak5VTmRmZHk2Y0kvV3VIMWExVStPMVpHMkh3ZU5nMVN6?=
 =?utf-8?B?VlYwVDBUUHNCRjdaYW1CQ29GNXRoVktObHA3ZDZERjRyMGZFRkdWQVJqU2tv?=
 =?utf-8?B?N2FHQ2c4ZHgvejlSeXBoNk9Sa2ludExJL2xrRVFPOFJmbmR5eXI1eWcybFJm?=
 =?utf-8?B?VEVORnNVVEhlQlNGWW5iZW4ybmJENUFJdk80RUlLNTlRWVh2WFpuM0FNRjk2?=
 =?utf-8?B?NkZQVzAvVFU1Vk5HVnFDaW9ZbkNLYnMrUlJBRFh1azlOWDZpdTVqbFhHYkhW?=
 =?utf-8?B?WG1NMmtvWTZ3eUNEVEN2TjExeGpib01jemF3bGZiT0lkS3U3aDNwRGNIRURR?=
 =?utf-8?B?d3k1WXY3b1hwWFVBdFU5Wm1lcHVML0pWWkVWUXlURVVNMjljSUJneklOVXp6?=
 =?utf-8?B?bWtvSHhCdkpmWXBsL091NnRqUFNZWlpYZEc2MjdoT3l2cXMvWXMwUWtyUUhB?=
 =?utf-8?B?Z2Q3RVhqZG1kK0I3YWZsTVlVSlFkRzR3T2JiREhMWnRzaXo0amlGK010YTdQ?=
 =?utf-8?B?VGJFY3d1NjVBV2RPZkpuR0ZvcDdvdkQ4cllXazVaVkJ0UFViVFdNWWswUUJz?=
 =?utf-8?B?dkp3TzBza1dEMVdYUjk3SE5veFVJSndBclM0eEhqeWNSWW1GUldENTlCTU5S?=
 =?utf-8?B?UTlqYUJZWlhvMU1VcmlicHUwU0xxTkxRelpnblJBZXRwYkpkRmdrMm9Tb29K?=
 =?utf-8?B?TGtGMTN4SXFxRlloS3RTRTllWTBRWlRUbTlqdWJuUTdBRFBaK205NTlvYzRT?=
 =?utf-8?B?ZGVEeVU4SnZzNjV6WW5ucW05OVc2WFpaUUE5RFNJNGc4a1RZLzdIcUNFcDV3?=
 =?utf-8?B?OFg5TXkyYzAvK3J3SXlzOERaaU1NYU9iUVIrRmdNVlNWSkdTZnNid050OTVH?=
 =?utf-8?B?NWcrMFRwM3FabVFyZXdEbFJVa1k0VFNRa3BJRVVlRXFNSFF3cmtaeDYzTjIz?=
 =?utf-8?B?S3pFSExDejVRSzhiZkRRY3JNNmlzNytVd2pGM3IyRGRFcFJ5QlpEYXZIZGVW?=
 =?utf-8?B?SlNnRGNSY3JvcGpUQk5hdU16N01vb0wyRnFBRFBraWdRMjg1eVp0V2hpdkEy?=
 =?utf-8?B?QVJ2LytMQlNXL2s1a1oyMmRQMmZhcndhWnkrNjBwL3M5aUUvRkY3OExMMU11?=
 =?utf-8?B?UkZCY0JJWVNQa2ZqcmhjRjRpYUl0VmNEbVcwWS9MMzNneEYzVWF0RG9OS3dI?=
 =?utf-8?Q?3Ely1OKQUq8j/TiHElUCAgs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d9433-8f4b-4e2f-ac88-08ddb8c372be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:19:34.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUGZ2FDGnFSPNJ8BbUnG3uoK77Su4pW26Io/m9/RDTdyHmJMxWYQKVDHLCSX9Z2vxX9VjpdkQOvXgRNGQ0c46Dy6g3yhkzuVpz8IQDjLx7qQdoMUMC76s2b80WG6LhOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6647

On 7/1/25 12:00 PM, Leon Romanovsky wrote:
> On Tue, Jul 01, 2025 at 09:44:05AM -0400, Dennis Dalessandro wrote:
>> On 7/1/25 8:38 AM, Leon Romanovsky wrote:
>>> On Mon, Jun 30, 2025 at 11:30:17AM -0400, Dennis Dalessandro wrote:
>>>> OPA Vnic has been abandoned and left to rot. Time to excise.
>>>>
>>>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>>> ---
>>>>  Documentation/infiniband/opa_vnic.rst              |  159 ---
>>>>  .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
>>>>  MAINTAINERS                                        |    6 
>>>>  drivers/infiniband/Kconfig                         |    2 
>>>>  drivers/infiniband/hw/hfi1/Makefile                |    4 
>>>>  drivers/infiniband/hw/hfi1/aspm.c                  |    2 
>>>>  drivers/infiniband/hw/hfi1/chip.c                  |   54 -
>>>>  drivers/infiniband/hw/hfi1/chip.h                  |    2 
>>>>  drivers/infiniband/hw/hfi1/driver.c                |   13 
>>>>  drivers/infiniband/hw/hfi1/hfi.h                   |   20 
>>>>  drivers/infiniband/hw/hfi1/init.c                  |    4 
>>>>  drivers/infiniband/hw/hfi1/mad.c                   |    1 
>>>>  drivers/infiniband/hw/hfi1/msix.c                  |    4 
>>>>  drivers/infiniband/hw/hfi1/netdev.h                |    8 
>>>>  drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 
>>>>  drivers/infiniband/hw/hfi1/verbs.c                 |    2 
>>>>  drivers/infiniband/hw/hfi1/vnic.h                  |  126 --
>>>>  drivers/infiniband/hw/hfi1/vnic_main.c             |  615 ------------
>>>>  drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
>>>>  drivers/infiniband/ulp/Makefile                    |    1 
>>>>  drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 
>>>>  drivers/infiniband/ulp/opa_vnic/Makefile           |    9 
>>>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ----------
>>>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ----------
>>>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ---
>>>>  .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
>>>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 --------
>>>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 --------------------
>>>>  .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
>>>>  29 files changed, 20 insertions(+), 4857 deletions(-)
>>>>  delete mode 100644 Documentation/infiniband/opa_vnic.rst
>>>>  delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
>>>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
>>>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
>>>>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
>>>>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
>>>
>>> It is not complete, after applying the patch:
>>> ➜  kernel git:(wip/leon-for-next) git grep -c -i opa_vnic 
>>> Documentation/driver-api/infiniband.rst:4
>>> Documentation/infiniband/index.rst:1
>>> Documentation/translations/zh_CN/infiniband/index.rst:1
>>> include/rdma/ib_verbs.h:2
>>> include/rdma/opa_vnic.h:24
>>
>> Ah! Will get rid of those in the next iteration.
> 
> Send opa_vnic separately, it is independent.

Sounds like a good idea. Will do that.

-Denny

