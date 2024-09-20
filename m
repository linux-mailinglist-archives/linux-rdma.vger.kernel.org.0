Return-Path: <linux-rdma+bounces-5026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC997D5ED
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626021C21AA3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7B16F0DC;
	Fri, 20 Sep 2024 13:03:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08513C67E;
	Fri, 20 Sep 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837386; cv=fail; b=dECnQM/fFtPLcp23sHMmvDcUxLtzepkjNJc27HWObhUDdZGJsA4IBcgTDE7Ne2I7MCcJwxUFlJlNaAv4n+Wlu/UGfSuTxQJeQ6R42ETvb1arBykqwgrv19ySvO9gc/uDfP6hOFCNgGkAuXszZ3bVghgyupleGeeWg2m3sA7XLRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837386; c=relaxed/simple;
	bh=lY0U4NNqesuNehT5e+MtxKEnM5XBwdcPI4lDRQBO/QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Im9x3nhlZT8hDaaJNwRmu40iH0m6AWEQYz3BGYrcEVbTbOPM6IDoko3jlplvWugG9ka3YXHxU4zY+Nx+kkdyq5PQ4zdN4BPaYsA2SSx0yNJy7F4f0Vt0LELmHdQY1qyC6DbjDiG1tX6Lp+ba4KbJZkIdYsLQosevEy2SwTmz98k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K6hpCW008943;
	Fri, 20 Sep 2024 13:02:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41n1f9excq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 13:02:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kav36vXq02TvBk1C9uMSYRk6JFYCkic3zZ/YEJAdO2IqE+d2gIgx+bL40dFFpza8FONjWGdqFl/P0xsLxd1DqgmT940VqnJzwvly6KOFoFcbNWBG8cQqbkEInMCD4+cxPltb5nkChqA86PXCpZfZK2W9mqbyUxtsAfey28Ca+qscMH6OgGJ+4fiaa2LtCdj3eKf3pK2aJYW29JKW+wHuGggHv/BioGOMjYDFGqInKUedo5ikVJY6l9E0VamQfduYBNQol1ReSzCh69pKoh2PZlUEMIb0Gwd70ZGRRdpOMrkMGrdzPx0uMrgVXyUeOYh0gts1fihV9nVySAFC0DK6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY0U4NNqesuNehT5e+MtxKEnM5XBwdcPI4lDRQBO/QU=;
 b=DgP0cWFxo8du8sJx+3DzPAoxIkjeO8kS/dN61o+tGVz9kRREtEJzf5McDO82J0E16NNJc9oUu/pwO1uGaIrhYZZh+NVRYWtHV90SPZtNY3AVnA41IESIdYbTVh7/Rwg9s5la3eyGGpcKp2kIik0JmppKspwsL01SOvvOKrxFkdCo5gTtnwv2fMqvO7Xpu1uRcK3tS8PGcYmKi16vsJAtwIa0I4ZbXcXp/Bn9HQExkvFIQOb4uNmwYf0X23HAyECmnWbWh2PNTJI53k0dfHM0KyljeJ7a8B5vIDcdy5yiSuz30FMRaGzZLG0ZH7FUQofGhj+jFBMD4x9tylHvKJdphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 13:02:37 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%5]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 13:02:36 +0000
Message-ID: <e195d0ec-92a8-4ea4-a939-31f6d5b7ef7b@windriver.com>
Date: Fri, 20 Sep 2024 21:02:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/hns: Fix UAF for cq async event
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: liangwenpeng@huawei.com, liweihang@huawei.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240920124540.2392571-1-haixiao.yan.cn@windriver.com>
 <Zu1xS4dX77jikYw9@ziepe.ca>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <Zu1xS4dX77jikYw9@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CH3PR11MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1af285-3b48-4970-ab83-08dcd9747fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHdwaTA5WW5XVktSZFR0SmR2MWNUQnVvYnRpYVQ0N2xOZndjZS9EcG4zNzNM?=
 =?utf-8?B?UmNwS2ZIbzNpT1ZKOEFRMzV4WU04RWs1WWZmV2FlZGwzb1hkV0RYNlBFeEdD?=
 =?utf-8?B?MElrMTVaR205a0hNZnFJWFM0SGsrSFltcXNRcTFxZXlldm1Ua2xOTk5hVU1S?=
 =?utf-8?B?ZEYzckE1QnFQNmJTampRL2ZzeGtacERteEJnVnoxU1VZVk9NZGRzWFFrc0Fw?=
 =?utf-8?B?VS9LcmxOZURZUExhYXdNd3NxWmZUaDY3S0hUdng1ektPaHNsaU10N3Y0dmJ6?=
 =?utf-8?B?SU55aFdUZmI2RmdCamx5NjhOeHZMUGZjRjh0ZVBjWExHNndWaFZrTis5UnM5?=
 =?utf-8?B?S1lLdkNNZ2dhZUxZa0VFR2NPWmVCZTdteE8vbXBDbmthYTU1a3pXUFl3UU55?=
 =?utf-8?B?OGJFK2d6c2pTNjNVY2FDVDlBYi9TWmhyY09GemVsQzdTSVJrNXJVRjBhYndW?=
 =?utf-8?B?eUZYSlRyOXg2TGRCMFozUzNXYnVjbkk3Vm9Xcy84NXF5N244WmpyaEQ5UGxR?=
 =?utf-8?B?YjBrQUZKeXU3aWV1eStVclV5RVRhMjVWMVJjMHpadDdCcFhoRFNGa3VqNENl?=
 =?utf-8?B?am5DVW9MT1IrRXNZYXpkT2tNdytrL1cxTW1hSy9vUm54VWxCM2NENHNsTXFB?=
 =?utf-8?B?dDdBbHFnaFRISi9LTzVZL2ZLTGx0bWdRSWxmMWVSNTZ4ZDdzNUFDOHlSK0tx?=
 =?utf-8?B?Rk10UWNQc2VHSjNlSlZpSWlqbEZ0YmxKdFdUcjNqd3ZKaks1eEZpcDdVNEo3?=
 =?utf-8?B?Y1ZnZk14dEJkWE9QTDh0VmREa28zSGJhS3UzaDAzcFlka0xZbTlhLzllZGJB?=
 =?utf-8?B?L0VMbFNENXRBdXhieWVBeDFoblVUVE0wSlNGLy93Q1NRM3QyR2hTSlJ0Rzk3?=
 =?utf-8?B?OEpVU3lJUUlNc2JSc0gzQk5uUjgvWjZjSmd2Nzl5K05lWjg3WkdwNVNKd2hK?=
 =?utf-8?B?cWErUWVLaFJlN1F2Si91UEhWcGw4VEVnaTZkdTQ3dkcxSEVweFZWWXJYc0Vz?=
 =?utf-8?B?a2Y5Yktnc3ZId1pxazVESk9Mcm5nSnRqWm5DVmx0MHZySEFnalJiSFpyQ0kr?=
 =?utf-8?B?TTdaRzJLNVFuZzJXZnhWWjVTYWFCdmN6ZDE2czFoVURFNnBEb0tvZjROZmdB?=
 =?utf-8?B?MFdFWGgvdmplZ3FrazF1bDE2N0FSbHkybjByb2RvU2ZxZGlZeXlGc2FrTnFp?=
 =?utf-8?B?eU9CMk1rYm5vcHhPY2Z2TUNDQnhMbFlGamJ2S2c3TEwyWHN2K01zSStlSVVh?=
 =?utf-8?B?d2JZL04xcTgreDBINVgvbk0xVTNzZVR4U1JVMkJIbm85VXgyaGVUK21KN3Mz?=
 =?utf-8?B?cEJ6N1d0ak5rYjJQZXJXenlSZGdTRWh2UGZpNFN4aHkxeU0wNVcyemFSOXVu?=
 =?utf-8?B?bHJDRUpodUhvTTBPS3RwcmE4RTdGZ1h0YWtQeFowMUJJTDAvQXBIaCtaQzFr?=
 =?utf-8?B?TEw5cEYvcWNBVkVkYlhpTmtDL2JQN0t2OWV6QnAreTdDTmZMOGZRZXBiQjZH?=
 =?utf-8?B?cUdwYWUrS0J0QXRJMys1K1RhQzk1U2pMTkxFbnZxUnovVEhxQ2dVMzBmdEN1?=
 =?utf-8?B?S0VZdXhVMDZPS2Z1aWhNL0FCcjVRbVgxN1RHRnhFNkIyN2xRTytQNHBHS0xl?=
 =?utf-8?B?eTJSVVdHMzJhdHRacnhSQWpKNlZ1SE9QeXg3NkdZcXRmVkF5Qkl1U2toSVFi?=
 =?utf-8?B?R0ppRlJ6cXU2Q2xXNm53MGpHampmWGN0V0QvcW53cjc1clFYSEUrd1F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXB4K2s3WStlaVZ2dFZKNXlzbFArcWV5UlBxUXZDdGwvb1VFdnJqRmJtWE9q?=
 =?utf-8?B?ZFVQS3ZWUitLdkdGeUd2U3lMdkFublRNQVBFczVoSWpRNS9hbmY3OVh3dFJT?=
 =?utf-8?B?RXozRFcwZmdkdURGdzVMdW9hajJiTmNFd08vcEsvUi9hN3U4ejBuQ0lzNWpj?=
 =?utf-8?B?bHZzeUlsNS9JL3JRQ3JQV1NQaEViNXpxczFwdS93WTQrbnU3RDRpQ2o5YUFK?=
 =?utf-8?B?UnpXTWdSL0FEbnkrSUZXekZmN1VqN0Z1eGhYSWplV1VkbmFXVjRVSGJLaFhK?=
 =?utf-8?B?cW1kSnV3aUdhSlROKzBpRkMxZUt5TGhGb3NWRU1hQ3Z5dzIwMWV0eE5QUUdq?=
 =?utf-8?B?WE9iaUVqS2duL1NYWXp5MC9Xa3lIbWtMRDZ1OHMyZnhGTFJaemtPcDRTenEw?=
 =?utf-8?B?MEo1d2N6TXp6VzN4d0c4dzVnaWdUbFMzcTlLYzBUWk9KeFhJOFNKcDBycXNk?=
 =?utf-8?B?VDdkaW5oaDN1eVNwT0NBSXgwVTZYRDRINlh5NVM0eGwyZjB4c2YxTTQzeEI2?=
 =?utf-8?B?U1hpVEpZbnZkVkZCUGFPenp0bVlnTVRwQjVMbEVmL1F3STJ2bmZVL2pZZ251?=
 =?utf-8?B?b2lWVmw4a1dINkJKWDN5QlRrV2xNSS9QK2JYaWhQajdYMUhvcFNPRFc1OEpq?=
 =?utf-8?B?KzFQbHNiRGFOQlA3UXpyZWlhQ3RlNjhaSis3REJWakxJUXJ2c3hTcC9DcEwv?=
 =?utf-8?B?TlVCdlJHU0N3d2E3Sld2cjlFR2UvTXZtV05oY21MNTQzUDdRZjd3WlNPdU1h?=
 =?utf-8?B?QVhNbGpDdjF3SzZsT05PVzdueHNvZ29GRjE4YTY0ck1HbVd3QSt3alJ6aU14?=
 =?utf-8?B?NW8xR1RXVGlHclhYU2dWSG5Sd0tHbXRjbUhSbVRhdGM3eWdUWWU4UzdtVFBR?=
 =?utf-8?B?SDRWd2phY1lYcVJUbUIrNVFVamw4NFJkMUNtVGtUSm9WbW1uOXI0MklJS2V6?=
 =?utf-8?B?MldmcXA0bWJhZjNCT0ZUcGZnQlZFNENsYW85R3NtMkoyZXlXN21OeUM4RDM1?=
 =?utf-8?B?V2dtL2RnMXovZkNEalJiVzFubjNqY3c3Nit3UHFvU01PbWQySjlGK1Zzd1I0?=
 =?utf-8?B?Nmdjdk5yT1VyNzNUNm9IQW9KY0lsK211ZUQ2dHlhb0piUHVUREYrbnQ0ZzhM?=
 =?utf-8?B?cXRoRTFFcDR0a3Qxc2RGRktwL05tS3JMdTFsaHlyM2owV1QxZUVFSGwrOTlk?=
 =?utf-8?B?aTJiYkMxWXQwTDZ1K1BsSTluVzN0NmVvNWg5SWsra1lZRiswTUZRVXBqN1J6?=
 =?utf-8?B?MHhNa3FHa2ZaZ0FxQWVBMDRScFNQdGpyTGdObE4xZEVHdGllcFE0SjNzaW1n?=
 =?utf-8?B?aittKzdnN0F1bERiWXhCYW1ialAzRXRNOEtkSFdWV01QekJWZW05emtaZFZT?=
 =?utf-8?B?UEoweVJUSldTeUJPdnkyb045WVRYTlMwdUNVdWhVOVBxT1hHUE55NVMzeXBH?=
 =?utf-8?B?MjJOVm1Hd1pWRGhlT1Y0OU5jdkd2WWpneE1YMzJ5emlrUklVLzBKVHlnd1dC?=
 =?utf-8?B?eU44eDRiMFh5U2xrUGdVWThxMENCcFNKZmZDZGNlcjdCUHBSTlhyOGpJR1dF?=
 =?utf-8?B?OFFGM2tXSHRvQUhPY3d3Mk9lY1lSR0FZSmkrZUpVTW1QK2JQL1BDcisvb3RK?=
 =?utf-8?B?OTExbG5TV2xVSnpQYU83bzJMd2VXQTkzRTlUNHFQUWxzRmRvRFJVU0s0NWRS?=
 =?utf-8?B?ZlVrNlRZc21TWHBEMFl4dkVMRTBhakhLMGhZamY2RkxxaDBIdFBzTllrampu?=
 =?utf-8?B?azFNcDdGVTVoMWQ2MERNVVRwYnplemhCSkpJbWFaa0JTb1JqeGlaa3NtM0NJ?=
 =?utf-8?B?QUZTd0tkejdyTjl1WVNvT0hEM2tlY2RCekpEdU1ka3NGTlZnQWxPNncyeTcv?=
 =?utf-8?B?UnpyaDhpRDE3cisrK1hMc0hqSzl5cWVEamZCb1FYQmRJdzZCRnIzN1J4N056?=
 =?utf-8?B?RkJHdUNSTXhlTUpBcWg1aG5pOUFzWEU3a3lJcXljUGRLVnVpN2NjMzgwMDhI?=
 =?utf-8?B?bUwzaDRRT3ZZUDFNdG4yOEIwZ2daeW5BQUg3U3I0bHVEV2x4Slg0c0dJbTUr?=
 =?utf-8?B?Mjk1eTZNcEhrYjFqK0ZiRC9tcEdjTHRid0pPWm1Ga3M3cVpsYmxobkc3OWN2?=
 =?utf-8?B?VUFJNHI5Wm5kRmlzb1UrUXFFNHFSRUVmMlZBZVJQdFhERVZjMTlpTFMyek03?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1af285-3b48-4970-ab83-08dcd9747fc7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:02:36.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uU9VJitEtWGzM2g9W+e2Z9JE+3M/dCvIdc0lN8o5ie9Ra62NUJSmirmfHjLD+3gS3G2kACF+iZp/7TTBGOw9oYsqmQaesbPDUnB0i66ASU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-Proofpoint-ORIG-GUID: 01fVfQRm_zbl94p1lUsO8FDsBsIokIx9
X-Authority-Analysis: v=2.4 cv=afUzngot c=1 sm=1 tr=0 ts=66ed7272 cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=i0EeH86SAAAA:8
 a=BTeA3XvPAAAA:8 a=VwQbUJbxAAAA:8 a=poY0bUlxjiiIuugbB9QA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=tafbbOV3vt1XuEhzTjGK:22
X-Proofpoint-GUID: 01fVfQRm_zbl94p1lUsO8FDsBsIokIx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_06,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=876 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409200094

Add Greg in the loop. Thanks.

On 9/20/2024 8:57 PM, Jason Gunthorpe wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Sep 20, 2024 at 08:45:40PM +0800, haixiao.yan.cn@windriver.com wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> [ Upstream commit a942ec2745ca864cd8512142100e4027dc306a42 ]
>>
>> The refcount of CQ is not protected by locks. When CQ asynchronous
>> events and CQ destruction are concurrent, CQ may have been released,
>> which will cause UAF.
>>
>> Use the xa_lock() to protect the CQ refcount.
>>
>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> Link: https://lore.kernel.org/r/20240412091616.370789-6-huangjunxian6@hisilicon.com
>> Signed-off-by: Leon Romanovsky <leon@kernel.org>
>> Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
>> ---
>> This commit is backporting a942ec2745ca to the branch linux-5.15.y to
>> solve the CVE-2024-38545. Please merge this commit to linux-5.15.y.
> Don't you need to send this to the stable maintainers too?
>
> Jason

