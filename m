Return-Path: <linux-rdma+bounces-11891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045BAF8131
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED81A7A231F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B952F2347;
	Thu,  3 Jul 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nxYLfzyv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDAch7i5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E71DC07D
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570216; cv=fail; b=hHVJMaGYG6fqjDXu6okvI76PtAE/+ruiqo/meE08Wh7ZeU7grkwXwbbDXcuc84ZTTjXhjkoHiPWhhuWUUZXP+K2/Eo3eGzjPwjPUcxo2402FphIXpZJBwTA55lLWJXiZ23f8jzEa+JB7OJ7/Q6kJ6MpyTYQbabXEsMSSfcIGHMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570216; c=relaxed/simple;
	bh=Xf568SZzDjU73wKPM/p4Zi1rLpA31COUqdG5i3ZJzN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ii60UU8GtbNM+q3hsvK5NviINh+JIWTSGi5wvc64oXQ3xkW3T0szK10xSarb/Mw3JnGkCLawGhHxYRFsxRjMcDRmg0EvkbIMr3uKNY9v17VQSmnI1PkERCPCE+57Kvxk/wJJL3tEgOIPFb7qxM1MPQ7zNFARUmNfxdXl7tIbaww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nxYLfzyv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDAch7i5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563HZ4io030657;
	Thu, 3 Jul 2025 19:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/JCfjRdhe7bkcewXhhObr5w7OeUGTmnMYdGRTq5MEvk=; b=
	nxYLfzyvoh7KSP9aWX46N0w9UDwdOzKWbqojZLH6mOtsXZwzWp8VqLlyYF5+eoen
	2OlL/zilZzefqUgpdoMBr19sUYrODgDl3r9bwqcoNOwOJXGRMfrWWNJeDHiQD4Gl
	Fgm8p4w6oJPzmIBhUvNPhATfLh70U0w14EGXhz4Z6m6QXWS1MUB10yEWNCRwsXEf
	63PxSYXutoAgdBrIhUagjqQz8a1sRNBOvlFN34tbnBYXkPxCbD5gnNrjFdvAKaL5
	v73KSg5KYg1kVkWfO4VVG3DtIsxcEeuVkUgRHEAulNzh3FBnMlQO4NQKYPKfP7pW
	l/0fBogqr+uSbRHNalz4VQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704hqdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 19:16:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563JCcTq018785;
	Thu, 3 Jul 2025 19:16:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ud0xgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 19:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK1ykxxW2b8t4C+J4ZdD43eQ9BaPA5ezkjW3g/hCdCe7asGk6XwsPuUlafo4qtJFbSVDv2N8bYV+3jzZ7NqhL0P/+AdT1lMwIFBMG2tjNBLnZpSKDBkxxWFt66p1wn691KzdZj3IBAxvtV5Zar1PhYeoPDt8iIV09e0l/TC34ts7CvEywJzL74iso8wWqLZyeJNcn/P4P+Nu1lMGayIVsJEKFj9kZyI7vr3ETgslpKlu5YE0u4wvsczwH+vYeAPeZ+G4Q2c5gBlvYo+qvnNpVaceVPh2ikQ1gLNW37eqd5sBrW8am+khVKEk6yq+PA9AmsI6ao71Cuz8CVNn6Q4VdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JCfjRdhe7bkcewXhhObr5w7OeUGTmnMYdGRTq5MEvk=;
 b=YvM1ikT6f9ZyzZPUv7e3OJGwrpydlGXQLm2EG+bNffouMhBh2xFX4gEKpE1lZLysO8QRdsj2v3m+cZSI0l5UoPVx4pAYrJTMix1r9vibOIWON/PyrEdEnecBWbVwvMKrh7Ua9469ceb5civJE1uvKHkZ5ZggvLNtZ8sfBUEg/KvlV5EMkmOFVFCPImDBtgVYvLIqQhbsuHOlbFC9xbuF2ybD2VfoLq+0HM3K2WLth3s4MeaNyTA9Nb0bDylmE79rExYU1Gb1X6mD+/Wu1njrZ4rjnE1FHf55rno6WEwz9ewDVqddczWVLSXi9YOzIOQKP05zmjEvj/S9QNdizX+Chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JCfjRdhe7bkcewXhhObr5w7OeUGTmnMYdGRTq5MEvk=;
 b=KDAch7i5tBn/41+rBgi6W+NYm052j/HfQu5d+fTcEV1PQ9jz48v04NM0Haq6tDE1cazLU0TWrahJ84JksHn3gES3FS+I1Ioj2Vfqd1oAAJMFToTzeJ57KVkDUM5F4Q3EuZrPOTgWmCxs+EBPxSHiZ4aCpvkvQhDZoCuOBhw1GkM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 19:16:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 19:16:42 +0000
Message-ID: <4eacb709-4508-49cb-a672-c49e9d7fa902@oracle.com>
Date: Thu, 3 Jul 2025 15:16:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] RDMA/siw: [re-]introduce module parameters and add
 MPA V1
To: linux-rdma@vger.kernel.org
Cc: Bernard Metzler <bmt@zurich.ibm.com>, Stefan Metzmacher <metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cover.1751561826.git.metze@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:52::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 12487058-6fff-4b4f-9f49-08ddba6624f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmpnWFZ4UUxYYVhUN3dkeUE0Y210S1IxZUhHVmtnWHN2Mk44b1F0bmdwUnBr?=
 =?utf-8?B?M0N0U2c0NDhlNXhoOTVqWGpTeVQvdkVqUXBwSkp6TzgwYUN3K0xkeW1WUDRo?=
 =?utf-8?B?Qy90dVl2ajdNUDNLQklzemZhSFF4Qjl2SWRDazFHK2dYY0sxendQUGk5THls?=
 =?utf-8?B?a2lUTjI1SmlJK3F2OGsxM2gwaEg5dVFPS1R1akJaUGRqWHJ2bWdiOW1QY1A5?=
 =?utf-8?B?d3R6dEVlUUtaNG5CbDNzUWtaK0hhYkdneEpvUlhDeVJUNWFRMG1SOTJuU0I5?=
 =?utf-8?B?WTh2RXk3MmNjbXBTRnVGK01jR1BtREUwTVUvQUJkdWtwbFRwSFNvUVJTRFJY?=
 =?utf-8?B?OHpqT0hUQzdER0JVUHAvdEtSTy9jZUUrZ2ZlZnYvYm1hZUp5M1U2YlpZTGJL?=
 =?utf-8?B?VE1ic3VYOStUNXE4UkFJRjRoTkUzK0wvQXROQkFzSWpzQXVqVnNEMHNGRnUv?=
 =?utf-8?B?SWtLSm5nNzgrWkhtNkVnU1NoVXB4N0QreEViQWZXNHVXU0NJWi93UHB3RnY2?=
 =?utf-8?B?M2pZMFc1N296TENhU1Brd1J2OXNtWWh5cElhQ0pRY20vVzQ0MmxseElLRnJ5?=
 =?utf-8?B?RzdDOXhJTkJGQTFkSFVHeXR5U2VhS05LbUJJa3AwemFOR0ZRN2hzTEZPS3FK?=
 =?utf-8?B?UGtjQ3ZMTGlBU2ZpSStOaTcyd245VFg5azFiclBwRlFZcWNZRWRZdW9TR29v?=
 =?utf-8?B?azA1MUoxVkQ1UnJMNHBJblRFaEZ4OThCQldtQ3hOZEZrUERmM1JnTUNvNzN6?=
 =?utf-8?B?d2VWYnBuU3BsN1EyLytOaFM4dVBUMjJ3UlhHQmd6a2FLSzU3OTk2V1RGaXFz?=
 =?utf-8?B?MU9tejh5bkhEU1htS1JIVlBBWFQyUmFRUjNzaTc4cUlvVkxQWmhGNFdib1BF?=
 =?utf-8?B?TitBMjZZUHZiS0Q0Z2I4WVpLZFRZYnhOd2VtRVIvdXJuRzhCRS9zTnVKRm1H?=
 =?utf-8?B?MUduMHo2WFdoOCtYVVBOeDVCYk1GNjZ4eGdoOHN0MkZ1Vy9Ub25oaVU2aFJU?=
 =?utf-8?B?NXMwa2piR2RiUkQ2ME9aem9ydkhzTWUrRldFZzhQSldwU1EzZVplbi9ZZ25v?=
 =?utf-8?B?cFNGenZVVnFMY2xXb0xWcm81elU2ejJwbWxHNVBzUzlwOHk1TVI0L1NzYndD?=
 =?utf-8?B?cmtsUnpaL0ZWRHVvQmZxNVA4Y1RPdi9wUlNqVmVGTGoxd0xmTi9IWnExVzdL?=
 =?utf-8?B?R0JrVXQ3TG5UOW12REFlR1JmY2dUM2w3SE80cktYOWl0eFJISW51L0JBT2Nw?=
 =?utf-8?B?OEQ5cDNIcEhWUytlYjJleFp3R3IxNEdKQlIwTlYwanJDYUt0Um5nVkdCVkxF?=
 =?utf-8?B?SUdKa3JKOHJyT1NqU09icGFlRXRoVFpGM2lYWTVyNVVZRHZsOEEyd21oVmlz?=
 =?utf-8?B?UHFTNHdzRHA0bDBkRDZZTSttTGY3VzAxY1JRbWFSUHFyYktFMFRoNEZJeElH?=
 =?utf-8?B?eTFUR3lnc0dvZzhxUEVTOFkzQ0RTRkhBdWxERWxFRUMyaEx0cENCMzh3MU1W?=
 =?utf-8?B?V0pCeTJlYjBaaEpnM2tnMEJBelB3d09VdTdpSmYvRDF0Skd1Zzd6b2Uyd2s2?=
 =?utf-8?B?MEppYXB5NW9JczM1MHRHMGxuV3ptTFVKVko5NXhYaTJlMlRDOEJ0eU9XbzdN?=
 =?utf-8?B?NExTOE1uaXpiSC8wOHBVVzI3c24xbHBFeDZWcGNwdHlKRUxwRk1ybDU3bGRD?=
 =?utf-8?B?UWdQWkcvd1JYM0R4RkkzYXJQRjJHRTZ0ZjlKNUNONmZmSHlFdkoxSm0ydlVj?=
 =?utf-8?B?eHIwN3Rtdk4zU1FRWU9WbnZqeTU0NlNxSGNUTzQycFY1N21qQTl5cjJaZWR3?=
 =?utf-8?B?Mk43dkE3N09VWkRtMkZyZnRFSFlRYXd0bXhXeG40RkNGTFp6aW1pZFZyRmNC?=
 =?utf-8?B?a0VkR1BjckpRK0tLVWU0aXJuK0RTNTNEcWNtQTBpRU82OENWN2NCUGJYc096?=
 =?utf-8?Q?c20pHO+EWpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzlIVlBYUTZVclVaYUdDYy82VFRta1h1NXNXeUZULzNRMGc3YXVUaU1ZUGpZ?=
 =?utf-8?B?cDZUTzVUSG12bzJmMGtpeXBSUkpOb3dLL2xaTlJZK0tUZXBLTC9VZ3pFZXFR?=
 =?utf-8?B?NFk2bEl2YTB2b1puZEE2S1NueXZKQW13T2hUQldFMlN0Y2ZManZQMHdWb3A2?=
 =?utf-8?B?UHRYQmFTOTZ2eHZSajNvbE0wVlVCMzJVZUt6cWRKN2ZiNE04WllCcENFcDFB?=
 =?utf-8?B?blNESGNSSW05cXlLdlg2S0NvUzFIWG1odU84WU5aUjZGdzdxSHRVdWhocUVU?=
 =?utf-8?B?UGhISk1lclp4UlB0c2hUa1J4WVJOaDJGcWxJNHVqNlpGcXg4OE1RSlIxcHBs?=
 =?utf-8?B?ZnFZUytobmZ3UnY4U3JsUWNLZk01S0V2MFM0R3JqbHZXS3NQUnNRdXRQRVlX?=
 =?utf-8?B?MXhCVmVHMWh5dnU5WmtpSWVsYmFZRzR0MXM3Mkx2bnU0aTA2NjBxRmMxRXFY?=
 =?utf-8?B?WkRMcEFxelVURXF0NThod3dpdmczWkQ2Y2doY0t5N0ZlTUVJOGhjNmh3YWxV?=
 =?utf-8?B?QmU1NXZSM1o3TnJrT1hScU9wZUJNemNNdUtuMkE3cDNaKzlNQWNZcWNjRGQv?=
 =?utf-8?B?WmxubUtESHp5R0hQMTU0ck5VL1N2cWI0UG1KdWdGNTJFYWZqVnBvZmVnRWZW?=
 =?utf-8?B?WWh1UWpDOWpvbk9RaXZENExiVDJwemhhTmVLa2liYStWcytuSUNaZjR5K0Ux?=
 =?utf-8?B?REJGUXREZ09kRzh6b1NvUWRUWUJsOHRqTUQxdmF2ZkJqYyttWk9mN1ZKQnhs?=
 =?utf-8?B?ejBnVzJrMk5DMkZiaVhLMjBSTHJoSmdZamd2OVYxUjZ1eDMrMkFWWE1jWFda?=
 =?utf-8?B?MThYajhIR2Z1WWNHTjArUUxYTzZXS2E2YVJJQXJzREUvZ00xWkh3WFptMHpR?=
 =?utf-8?B?SWZrOTRldmhQNm1CV29UODFMMUlDcXBwWlBqcC8zeUFHamVtV2JtZ24wWENU?=
 =?utf-8?B?N0RvcGJvTW11RVBEQzFoUmtrRTRScXhoS0ZQeHl5Y2FjSURPUCtoTmdCZm93?=
 =?utf-8?B?TkV1Kys1SVdZR0NaODVnYmlHa1Y2SkZTOTlDTGpFVTQ3dXdVS3gzNTYwWHZB?=
 =?utf-8?B?M2p0Z29rbGoxNEtWUy8rTjNaTW5LNWlOcVJwRVVhd3ErV0ZkT015UUhTbHVn?=
 =?utf-8?B?azdsQzRicXYwUXFWTGtGVndxNXhZUjc4Q2hrNHB1TEtLeWl2YXpJUVNseUJM?=
 =?utf-8?B?d3IrcG05aDlXcUp0VExGZDhrSmlocnZoWWxZQVpVM2cxL2ROQ3NPQ1lYVU5Y?=
 =?utf-8?B?TkJrenZCTkhnRlRKNWtFTUJSVkx6eXhmVlhnM0pZTmF0bWMvbUNLaUxyT1ov?=
 =?utf-8?B?QjFvbEw1SGVlcS9nbEJ2SmdYSUVZc1FheEdXYXEyRENETXpvanFzOXBMR3Zy?=
 =?utf-8?B?ZHJ0a1VNenhTOUE4M2hERWkwS00vczlqa2ViUFF6UVlYTnJUcVNqdmVsbi9E?=
 =?utf-8?B?aUJZUjJGYmtxTXpZU1dvQjdZYXk5bHVhMDJLR1hmQXVjSE13QWNUdFdFTFE4?=
 =?utf-8?B?eGRrWUhrdFVialhDUHo5OEh2VDNIRjNPb1daYmlxZjRnbDFqZVM2RnFISVRi?=
 =?utf-8?B?MzlKNlRNTDJYZlJ5MTVUQXVNSlM5QzcyTlRYL1lXVGZJMmRSRVBjSGdnWTBp?=
 =?utf-8?B?czZOMCthYU82bEV2ZnBoZVpYWkNNQ09VVTVNRGJUa2JjZkh1Z0ErTDZnT1Np?=
 =?utf-8?B?YXZtYlRtcHF3bzNEM2EzWGtyTzNVTGc2WDQrVHI2V0c2UE9NTDRGK3NVU1lJ?=
 =?utf-8?B?bHJZbG1PUjFzbGJkRzhpWUozcHBmbXdFS1FhT0twTGFpNTNocG01UWJySFcz?=
 =?utf-8?B?eFZ0UFQyYm9pcjNsYWkySVRjQW1lcm1WSW9MTW14cFByZld2ZXc5NGdYOWZy?=
 =?utf-8?B?SkVtbDZLeHMyWDVteE40dG54Q0I3QzVhVFlIaFd1V2hPQnhFY1k1WnRKdHV2?=
 =?utf-8?B?RFNWRlh5L01rK1hONE5peU8vNUtvaHl3akQ1UHlsS1VsanlyOGR0ZlJPL0xW?=
 =?utf-8?B?WlNxNFlXVHg4aUlZQmw2WGF1d1FnalgzL0ptS0ZvMmlYUS9oYXppM0JWRWRj?=
 =?utf-8?B?dzFacFNVRDg3a1ErV1FITGsvUXphdm8zbDFub2hXbFJ3NFNUejdXUFplWC85?=
 =?utf-8?Q?m3iuVcDf7nFjPBJ4SimuUWFzB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8B7nLYcSdhsAbr6ZATdcWU7qtRTYMTAHr5+NOkikY/KcJYjw7S9nsS4Euy26ay+LI93O3234qO1unGA3XfjSX0SAVxYl6axGQjs15nyKHYBUKSJOurPERqWX4G7GZxAuvRZFWpUI7O22jYMfOkb8lrIZ6cRWnZ15ktMYLIK7yTX/XQTANYWqSoTWSCgB1BBlCGFkcIZr1XMe99W7viMYHLFwxdMHMav+ww3Z0kSSHQCj6WAt7Axg/S9ZBkSEgiNf6Bfta117fhsRtLQ9mw0N4FlZ1jEryTHmkoih+iF2SkN3ZWHcQ4IZX0SbUd24nJPSAyINbzfQrkQLi+PWKPbZc1oTpmvUZ48jwZbjKNy4pcVzRsk56RUpWrNGxj6nxOXJZuRIqXDFw7tGfiwIzRYoJJqRAvt5dHXtUZfSb6WirVHn+Hlppttm8R7D1F3ZaGpbTrpf/aP8ZzGQrBaTuEpIMwHjl5lOx3TZFebeSfoZfzgZXvFl+V0s+27wt+OmyDzou0ucWZUU2BUbOu/hbDZtslqbsv5GEUd+zL1TbTOlJe6osYFw3LqZmcqV5tco5ErMVjH+/8RKMCTNYVRxHr+OUPVD9ppw8/0YVyiCK7LHVHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12487058-6fff-4b4f-9f49-08ddba6624f5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 19:16:42.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGC/kQRjQpG7BJHNs2unid2whdejHfZBiz/G7S4XgvPoelZkSm+ttRY7QJAFHHlmlhi5IS4V0fSJScweCX5ilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507030160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDE2MCBTYWx0ZWRfX8+gKZL37CYct qB4dUngdnLNB4xvhjC01/czk22zcIgpng69MYstYmxxCP+skXhwlrJeuk4BzxooflzCrJ82UYqP fE81+IiBRpyrvEdgM17l2qgLkI/2zFG6IJoGUln4jzwuIYeWkU7i/GeyGlVZCms5YKbQHAc0NbN
 ExI/SMqNsKggbRia06jbBHDyhyRtWO2l4Z7m4jxeyskcnnPzUCHq9jvk0BcrhjE9cn8eOPEH+qn nC89tIaAKb+p+GIWYTS3lMObrY9zM6fhk4yVsjkb1wBxilRn7hwEZ6OgLBm8oDrHJxfRyZ9z6ev 8o44MBl6NTGpLmHboVZUmdp+9C6FL1Cpajrhj8MacIVDqbKlV6UJu5KjsHJx533Xteq7Ze3s8tt
 Yta2hKS6TSSJIAqY/ve2xfst+ATEM3eo7rU4+PR7ECHzFp7oqykPCxH4CHZ8oBr5OzMQ68+F
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6866d71e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1diEls7ffz0eBQJdCvUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YIJK-APmh943EqgOOcWm_QKyv9JZM3ag
X-Proofpoint-ORIG-GUID: YIJK-APmh943EqgOOcWm_QKyv9JZM3ag

On 7/3/25 1:26 PM, Stefan Metzmacher wrote:
> While working on smbdirect cleanup I'm using siw.ko for
> testing against Windows using Chelsio T404-BT (only supporting MPA V1)
> and T520-BT (supporting MPA V2) cards.
> 
> Up to now I used old patches to add MPA V1 support
> to siw.ko and compiled against the running kernel
> each time. I don't want to do that forever, so
> I re-introduced module parameters in order to
> avoid patching and compiling.
> 
> For my testing I'm using something like this:
> 
>   echo 1 > /sys/module/siw/parameters/mpa_crc_required
>   echo 1 > /sys/module/siw/parameters/mpa_crc_strict
>   echo 0 > /sys/module/siw/parameters/mpa_rdma_write_rtr
>   echo 1 > /sys/module/siw/parameters/mpa_peer_to_peer
> 
>   echo 1 > /sys/module/siw/parameters/mpa_version
>   rdma link add siw_v1_eth0 type siw netdev eth0
> 
>   echo 2 > /sys/module/siw/parameters/mpa_version
>   rdma link add siw_v2_eth1 type siw netdev eth1
> 
> The global parameters are copied at 'rdma link add' time
> and will stay as is for the lifetime of the specific device.
> 
> So I can testing against the T520-BT card using siw_v2_eth1
> and against the T404-BT card using siw_v1_eth0.
> 
> It would be great if this can go upstream.
> 
> Stefan Metzmacher (8):
>   RDMA/siw: make mpa_version = MPA_REVISION_2 const
>   RDMA/siw: remove unused loopback_enabled = true
>   RDMA/siw: add and remember siw_device_options per device.
>   RDMA/siw: make use of sdev->options.* and avoid globals
>   RDMA/siw: combine global options into siw_default_options
>   RDMA/siw: move rtr_type to siw_device_options
>   RDMA/siw: [re-]introduce module parameters to alter the behavior at
>     runtime
>   RDMA/siw: add support for MPA V1 and IRD/ORD negotiation based on
>     [MS-SMBD]
> 
>  drivers/infiniband/sw/siw/iwarp.h     |   8 +
>  drivers/infiniband/sw/siw/siw.h       |  21 +-
>  drivers/infiniband/sw/siw/siw_cm.c    | 268 +++++++++++++++++++++-----
>  drivers/infiniband/sw/siw/siw_cm.h    |   2 +
>  drivers/infiniband/sw/siw/siw_main.c  | 173 ++++++++++++++---
>  drivers/infiniband/sw/siw/siw_qp_tx.c |   3 +-
>  drivers/infiniband/sw/siw/siw_verbs.c |   2 +-
>  7 files changed, 395 insertions(+), 82 deletions(-)
> 

Without addressing the question of whether siw should implement MPAv1, I
would like to request a user interface that is more friendly to
containers and to automation (CI). I know there is plenty of precedent
for "pull in the current setting of some random global module
parameter", but I don't think that is up to today's most common
deployment scenarios.

Surely rxe will also need to have a similar switch between RoCEv1 and
RoCEv2? Could something be added in the "rdma" tool to make this a per-
device protocol version setting?


-- 
Chuck Lever

