Return-Path: <linux-rdma+bounces-15115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5ACD27F2
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 06:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66403014AD8
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 05:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6182ED848;
	Sat, 20 Dec 2025 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hFVF+dqi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j7/YtBGS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A927B33B
	for <linux-rdma@vger.kernel.org>; Sat, 20 Dec 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208145; cv=fail; b=C2CD2pUKO8vihX1fhS7gqjVwWFssUU08RW3jIawp8H3gEOA9g0vybNA6tZ7N/9dafvIlLEaFdcDXu47Qi9Nb2HbK7QJj484NnOfuIslKfho2ZB8S5Ux9OhLwnm7s2pkTj5vggCO2RTLEZHam10hFo3nyu/pcoIxQS2eZyc7TkH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208145; c=relaxed/simple;
	bh=Gp2z4ZKHCKbWRW4UTrYA5gIgXmA1Uafn19RM/dlrvYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnwMMa9qLc1VB45ILip+BnYLqgiihA7LjjDoSfnBl3hQBLlri/5gqiDuunr2LcD7TIiimgN9oETiYUMe5jN+kZXdzCvr5sGlO0WzuSquXn5oE/F+5NYkRHfGVIV1n7Iva452jMfEShD/iOuOLwKbDtOwb6fN4T2Mc5hZuEjqOFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hFVF+dqi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j7/YtBGS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766208143; x=1797744143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gp2z4ZKHCKbWRW4UTrYA5gIgXmA1Uafn19RM/dlrvYo=;
  b=hFVF+dqiflek2lAUPhja48drlLb093lD+5ZVyTFAM0sPF0WEYU5FneOv
   uaeLdxJQkgc4shm1h+NOi44Rk6hbOC026bGL5DRwaRPtzpinn5ON56qQ7
   X9ikOGHaHwLSf1ZCpvEae4g6AUtP+r2X7Co1Y6m9rYCOwqTKpmk9MT608
   gfpj+eVImtjOBtFrx12Xs1YLcFk6YyaeekizPT4c4fjn6dSr5eBL1EWpG
   Pt3zEK8+/zWbnXhGPBbaTVbMd77jCT+yHSh4mN3dl5/+mgvbALplNOwJu
   4cpyHVX1hUz8KLPWRWqLy2Z6u0LTirG3uH4zSv4TvGyylwmzVEs5Gub3o
   w==;
X-CSE-ConnectionGUID: E2uLZCOyQmuXhOLyvdpXJA==
X-CSE-MsgGUID: FvuJC8kCQjyy3bkIoRnSKg==
X-IronPort-AV: E=Sophos;i="6.21,162,1763395200"; 
   d="scan'208";a="136885773"
Received: from mail-northcentralusazon11012003.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 13:22:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2vosKi21FWV0QzEIg/qv8IIMuLMVZP1ABxUKvz4RagKUAtREHA+Ty8rOBDsXpVtkzvGeUtQ4+AGojcqC4NFZV5BGTcyyK7W9F/HMywetFwsX6avVX8pIRWN3BF4Tm6RkpgqsYLZn7NeaQs+HZ0v5ceE1cVnx+Il7BSRJO3T7eE/cbxhNCg1H7iY8a/S0jLXlnUvjRB0nG7OXD1eLxxFYd1YTK5xJxQEV6WB3ZeCOigZECabNT3rYpIJfm0f8FGsE0nMb4TPoI0ZfunC/eoatGspXFSdMKQ3eHuYHcE16TfotocWDVzFFfLrBUfRNwGsEPPQJRWP0RRlQRa2eZj79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp2z4ZKHCKbWRW4UTrYA5gIgXmA1Uafn19RM/dlrvYo=;
 b=VBlVj1503Dlfl7aaS54/+dWIQN21RUOuYbfMmaAgRYi0gJIvVRjSWsIulBdUPy89vEtxIBaH43bJMpwBT+EfTsDY/XbCiQV7Nt4BWeS4cG+z/rkh57iC8Cecv1Uzs2xEvpTdL071YZf/ldD6m/FMbqibsFnHhfnOECS5RDnMNSE85TxwCweWHKtxCQzUYn3jGwf0TCnJ4v49HyYKdAZ2vmt9weTbUrj19SUTullDupNdkDPucGN84I8yQOHnr6kS7lbdo9TFVBo+EtE7raNVpt+Rr5jyHKCCWnRnGtifJSqKTL+j0N/zHW0LcPTPEqI8An0IGl7JiO1u5EtIHqJr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp2z4ZKHCKbWRW4UTrYA5gIgXmA1Uafn19RM/dlrvYo=;
 b=j7/YtBGS4Pgh28sPnelMXn8PKcXLaBHhgd+urDDUdejZb3vIXBcEttUbT5xyINtyLGwqyPmTCVoW3PKYaC03rMHIplL7JhEuUn3Rog9cPKzN8XicCsaW4fzb+pzSL2jPnEV8bb8SHsF5O0J7MeGUwiQYZHpKmTo/9sUdH4O/myE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH2PR04MB6791.namprd04.prod.outlook.com (2603:10b6:610:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 05:22:19 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 05:22:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: yanjun.zhu <yanjun.zhu@linux.dev>, Stefan Metzmacher <metze@samba.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Leon Romanovsky <leon@kernel.org>
Subject: Re: [bug report] rdma_rxe module unload failure with DEBUG_LOCK_ALLOC
 enabled
Thread-Topic: [bug report] rdma_rxe module unload failure with
 DEBUG_LOCK_ALLOC enabled
Thread-Index: AQHccNqt8rFtEpUF3UaZITwEEl5z/rUo+coAgABG6ICAAL7RgA==
Date: Sat, 20 Dec 2025 05:22:19 +0000
Message-ID: <d70d489d-d083-405b-9795-0181cbcb65d7@wdc.com>
References: <170e3191-7e15-4af8-948f-14904fe260cc@wdc.com>
 <7affc986-1378-4257-bac6-cd0be4e2f5c8@samba.org>
 <70fbec5d-1894-4660-a768-62e176e9e421@linux.dev>
In-Reply-To: <70fbec5d-1894-4660-a768-62e176e9e421@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH2PR04MB6791:EE_
x-ms-office365-filtering-correlation-id: 97d51f76-aef2-4bf7-b77b-08de3f87bf5b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZERuV2JvL2xYY2dCMDJ2RVhjeTBPaXg4YkRObDhGSWJFRzdaWm9oZzhZMUJL?=
 =?utf-8?B?SHZzMXVadmVhZklhNnN6VVZpOTV6dk1XMk53ZmprM1NMSTdvSjMxci9jc29L?=
 =?utf-8?B?NlhYcGZWblBSUDdTV0RPb1lFRW9ZOTI2NWR0TjBuV05WMGZ4QUZVbWVPbC9a?=
 =?utf-8?B?Z1JSYUpsRGx6blJxdmlHMFNGU09mNW9qY2U2cjBwREpnUUhVelplZEFJK1Yz?=
 =?utf-8?B?d3NZQXJqMWRMTVhrQUh3cVY5eXFKMExpNlpIUW9nUmhPV1J6azd5aHpvVGFS?=
 =?utf-8?B?aXE2TkRXNnhHV2p5UlRYUk1FT2R1OGlmSWhnSmdhd3VlY1c2a2kweUFaRUpx?=
 =?utf-8?B?VytmYnNnRGdUZVozbjc1UjB4YUY3WG92d3RuT3RscUJQUXFiRno0N1VOM0V5?=
 =?utf-8?B?MGkyQkpmWnVGT0RyUVNJMmtJd3VNc053ODdISGJ3NmNBSlVabVpiUWhNRFd2?=
 =?utf-8?B?TjQ4WjhLNEc1VUJtOGVhMnBaWEFaRDM5dnFuRE9OWXdieXcyT3p2Z2ZNYVRN?=
 =?utf-8?B?VThtM1daOHU5bDEvTzI2ME84SEI5QnJETzYzbGxOeGVNY3R0OFZ0Q3JCZW5J?=
 =?utf-8?B?RUxJdWdVOG1vTGVlUDFtY1JQOStuSVJ4SU11RnZsRW95UnlwWHpJN0pJcTR1?=
 =?utf-8?B?L3Z3bU8vaDBmejRKT3ZYMlIzUCtXU2JkdmNMdlFVZXZvcTROYUh6RFQ0VWt5?=
 =?utf-8?B?MFlnOUozREhaVjFFT3R2SXUwSjN1ZjAySXgzd3VJejBFeGhmZFZBTjVmK3hU?=
 =?utf-8?B?UXdwbDQyNW5IblFWdTB6bFMrRVEwQ08yMU9vOTZhVkYzUC9odFdaWXRMWkUz?=
 =?utf-8?B?SWU3WG05UHpEV2NsUUd1MS9JeVZtSjY2UUNTTjZJK29jV290YktHRGEvMXlm?=
 =?utf-8?B?N1lZenJtd0VVZjFFMWRVa2dlNkxSZlJMVmk3cm1kaCt5MTNuaDZ0NHIrUDRu?=
 =?utf-8?B?dC91NWtNODVyOWMwRmNEOVp2eGFnN0grWS9NR2lqVnJSRFBoaE5NMkY3VEZO?=
 =?utf-8?B?WmlWRFlCOGJlZlZseVBsQ3hMa1ZpZ29oUUdsclMwbVA4UktnNCtkenJHTjhX?=
 =?utf-8?B?Qmd6bGdtdmRqSkdZdUlyVFF2R1dIOTZjSTdOQytTcEFvSThwdTJEb2p1dVl2?=
 =?utf-8?B?OVMveTNHWGZ4bk04RHNDS3o5S3lYWHFQTTRVYzJoZkpjdjAzY1QweEd6Y2xv?=
 =?utf-8?B?ZkFGY1VwYUFzTnBxajcvdVhuMXdtWDZYTlgvdmlIWVRiOXdLOWFOOVdiQ1FC?=
 =?utf-8?B?WG51cnI5aE80ZWxFejhnRHNybkg4bytKcDdxSkJ2UnVpZC9ZLzVoQUZtdUNW?=
 =?utf-8?B?aGxXZGFsRE5QVE4wQWxpd1NKN3Z1WkhHUG1uWFVsTFg0ZUx4ZWliNE9yNUZv?=
 =?utf-8?B?WXBoQ3lDVU02SGdEQnZaTnBpTnRja1BGdkREYmVGUm1UM3hOM3BwMWZ4L1Rv?=
 =?utf-8?B?VEQrRDBuZVRsTTYxUHdiL291UGFsR3pXQUdLdER0bnVhRXUxVUxUZ216cDBt?=
 =?utf-8?B?MktzMjJvTkRXblp5QlNxYzR6TmhncURlci9ZZEJxN005OEgvdUd6dkwzOUov?=
 =?utf-8?B?ZWNmVDAzdXA4Vlg3dU94UW82aXRKYU4xei9tbXI2N0s2RGJibnRML3dMYTQ3?=
 =?utf-8?B?ZnBPU2RmK3F1ZkVoNXI1ZW5mN0NzdmRXbG1JK3BCYjlXblc2RThpWlcwOTVE?=
 =?utf-8?B?QTJUajRQa0J3VGhmbC9kMmcxN0h5amNXazMxYkRBdmMwK1pZMHNReDRCMWU1?=
 =?utf-8?B?emw1N3drTzhSM0pwSWdWNlpJVitmcGVCY1M3Z1h0WDlhRFNjQ25hMUg0R0JH?=
 =?utf-8?B?S2JBdXBtemRpKzIvaTlHUkdPVTA5eXB6cFBkUFJmOEdKVWlBbWsvUFBMejZw?=
 =?utf-8?B?ZVJGQWx4MVJmRFFtdmhxNUxUMXVnb0I2SmlINlJ2clRGa0F4RnZvTThYd2Jk?=
 =?utf-8?Q?fq1pEoI9yfOEU9GBAxCk/CE3TMLYKV/I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGFEQ0RXdSt6UFdyOU5iL0ZQaWpzalVFaE1wV1BiUmpUNG1TOHhuVGM5WVND?=
 =?utf-8?B?dzNJMnliOUNhbjdmWFhLRmNBTTg3ZGRHUTVvRUppNjdBSVB4UUVvWEpFcFpX?=
 =?utf-8?B?cDY3T3piSEZuaG5vTGZpajBBcVAzTFFkV3BaaUYwZmpISVNvVXpWUUFKSzI1?=
 =?utf-8?B?dGkwUzRUTDZHNEhMVmd0QytGbTFuNTI5L09xQUJIVnVwak5yOWZyOWs2TTJG?=
 =?utf-8?B?UTVleXZxbXBiN2NuY0crR01mM0ZHdjNRdlI0d3V1TzJpdzR2OC9aazJPUmk4?=
 =?utf-8?B?MWRiMjNRRU9SWUNDVG9IeHdtaHdNVHJhZ2N6UlJjVFQ3a09vYmFTMVBmbzV5?=
 =?utf-8?B?SGtiWmpGbjJ2WUFaRWd4NEpqaE9wSDc2T1pDbzNWZENnK2pmQnhZRTdVUXVj?=
 =?utf-8?B?TFJFRndxNWsvTFdCRnQ2NUFZNmZOaWlBWFA2VitaNkpGaVNBT0EvZ1JhbUcx?=
 =?utf-8?B?bTJpenZSTXM5R1R2UmZqOGIyV3JIMUdQbE1qM0xKUVBaeUtBZzRvRjlzMEZu?=
 =?utf-8?B?cUh4cURXbDJSeXRTZlNRU2dyNGtOdVRTdnVZM0VHNCtQTFJHMTNkanBNNTlE?=
 =?utf-8?B?emwyQW01dWxiRExENjF0MW5MV1VGa0hRdVcyenFkUDErWmpYWXBOUXRJSEQ4?=
 =?utf-8?B?dWYyUnRsM1VDbklGa2dsNTZWeFR0OVF2a2J6bEF5UjgzdFZvajZOTHp0Qm8r?=
 =?utf-8?B?N2dVTUdBTXNNMEF0bFR6Z3Z2Nmo3QW82SVgvRHhNSWxkc1VXS0JNY0ZLWDZE?=
 =?utf-8?B?V083QVNFQ3pPV0hkeHFaSEVnNjBJaThSVE5KZlhPRlhqVHpGUmt0MVYvQVBi?=
 =?utf-8?B?SE5NR05Oa1BhZHZ3NURNSzRCVGpnYnVMZDZvNDNIWGdNajZEd1dXZ3piM295?=
 =?utf-8?B?WFFFMWtKWXR0ZElLNXdpcnArNEdROWlOWG9HN3NNVXI4eC9IaHBhb0crbVpj?=
 =?utf-8?B?WGljK2xIdmlXMWZ2ck55K29VZTIxSDc4bUVTUWlEcUpqMDhKVHN0WFRSN1dk?=
 =?utf-8?B?UTZLdE9idFMyTm54OTVYd3crUng3RE81UUZFQkF6L3FNNGYxOTczTzVjK2VS?=
 =?utf-8?B?eUhSdTUyUGJaRHhqN2hNaU03Y0JYTzZPeDZvT0ZXUzRrTzNvQStrczNGZ1Bw?=
 =?utf-8?B?UnA2VzJGb3JRVm5lSTFaNU05eFBZeWk5T082bVhGejZObGxHV012SG95aThX?=
 =?utf-8?B?cnVScHR4dzRucFZWZE8yNEY5K1drKzZiMElLaGhwV3lIUkcxM0pYSVNzUGU1?=
 =?utf-8?B?US93Tnh6VHlNVFJPZWRjTHlsNVNKYUtPc05BVzNqTlptSmgrUmVzcTlsZXMz?=
 =?utf-8?B?UFRSOHdzOEVabjc0Ri9RUEYvN1I3c21DVi9qYWw4MWw3eUlLNFJYOWU1bncv?=
 =?utf-8?B?QUMzYk5CT3NCL2lZempmZWpKU3BUZUJVSnFFUi9hWTJlSEdYeE9QSVZUUmFK?=
 =?utf-8?B?d1Vudm1NRVc1S3RNWnhKS1ZmQVZwRUt2MDFkVkFtU1pUMzF2MUF5ZmZCbEJW?=
 =?utf-8?B?aFJ3VHB1KzNMNXF1S0lMMWk5N3hVR2phNXJlUVBOWHdYQm5rWUlwRlZ6a2hl?=
 =?utf-8?B?NG4zQ2NHUXNjVDRSVW1GODlyakdpTlRBM0w5WnFwUTJJMitVWFRnQXhTK00w?=
 =?utf-8?B?dDBDR3RqcHdPSzJXTk90WnRna0RNbXRYZzhDZE0xUUpVQmtYRkdBaU1YZCtL?=
 =?utf-8?B?VkZITWNhRUV0RmpkUXVLR2xRTndueHpuWEQ4TjB1N0R1MnJYMnhKNjQ2ZzZQ?=
 =?utf-8?B?cFh3bWQrMVZjazlZNDQ4aHAyS0FWK2F0YUpwYVk0d3RHbi9vZ2RkbHpiTVpV?=
 =?utf-8?B?d1kxUXJWakJGeDduek9ueVRhSEtOZTB0eVlDS3ZLRHYxVU1NWXlDQlF1d0w1?=
 =?utf-8?B?eEtpM2hDVEZ6NlpYRlh2RGFYaVFzTVZxRm1rSDZSY0NZd3YybFc1Q0pGM25z?=
 =?utf-8?B?Rml5a1FvWjNZajF0NmVvUW94aEdKMlRRYnh4WlJmd3RzUSt1OTRCSGYzSVVQ?=
 =?utf-8?B?VHhzUmhacWtYdHZtdlNPSFJhd0FoRXNhajhFeGZ2RENIWXRWRXZDODdMODBa?=
 =?utf-8?B?QTVRZFM2SFdvVDd1b0JCZkZkVUs0RjdEcWpHaXFJbjdwbmo2LzNMUFNGY1Jj?=
 =?utf-8?B?YVhSaDIweG5kSktPZFBIYXNKS2JuMm1raXQzRzNqd1FYcDM4OHpQR05SQWZl?=
 =?utf-8?B?YlJyNWRrSTM0a0xpeDBjajdhVkdQTVIyVlI2OHQ2b245T1puZTVEWnJaZTMr?=
 =?utf-8?B?Z1M4Y2dZNFlwUUoreXBkczBxYmhxTEpHWnE2VXhiOXVSNFdLcWdsVFU1eE5a?=
 =?utf-8?B?NGhIWGV1MlJyUVdvc2VXQzJxeHNLODB2VzhQaTFubXd1Z0RGLzdqbjVrNWZr?=
 =?utf-8?Q?1hQbcVge+mIL20LM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DB0B01AF318634880B61F43D621CF2B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	88uhpbhniDlf042acjPjHwxn7aWqRuniG0EzGVzXsFEYk+no8SZ7ZyqSfbTOfgWcXtSw9+yh+NYt8QZUcBuOMBSKwrR7jvDrlVm7SKEimPzZMVPv+pvWPpTXW9qCdFxZusj8cuHueWzNxlBzY4BDRm87Ox7RVkhVSOvpaAiEFiBci4L1I1i8Wb3+mVT8xUctxha+H2VlpNMhth33yTkhlW4fF+OURRRd40+SEYoI4k3mJUHCgz6FmwuWXYQYH0CuuRBru9VevYPoi/AwefYWjOqKyIokswumVvgMMxumF3CPye3Z0/y4+iM2DnKH/Ax/+SCygfDupJo/+EPqpSmKAnVt81+1sgjP4/3RAyIH0qdNTEt+r/86JEe+0bqAgtNoczP1OUU+DcWmHwijJuXgfwO7ZrZ+Lphw6Wf1lZj1wo9PgIAzH10J/qXr+LaUXT8KynYTs7D26U2H0tZCME34278x6xVbRdVNiIqw2NGNUNK+yXgn9pNMOPPY7WfJ+ZBqUFijARNFLSO+AiUcsTmEOhJhMaX5Pf9TYuCYtWpWxFbzCt9wAW5GIqugzX7qR9BIUGxscmqMMTsrUJQE9C2W5813+ZdB6hyq5Wq95Stz6yPbvRcO5WWqR75yXxBHHrl3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d51f76-aef2-4bf7-b77b-08de3f87bf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 05:22:19.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m87uIrh63pnUbqlePQiBXgqkvV7Q9px0GGv4BeNHIh6OjrQE/b+OINHrhtV2KGseRGox7+VaPqIxIUQkzkucEAOGkyMeyecMjm1TfHy2Uy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6791

T24gMTIvMjAvMjUgMjo1OSBBTSwgeWFuanVuLnpodSB3cm90ZToNCj4gT24gMTIvMTkvMjUgNTo0
NSBBTSwgU3RlZmFuIE1ldHptYWNoZXIgd3JvdGU6DQo+PiBIaSBTaGluaWNoaXJvLA0KPj4NCj4+
PiBXaGlsZSBJIGV2YWx1YXRlIHY2LjE5LXJjMSBrZXJuZWwsIEkgZm91bmQgdGhhdCByZG1hX3J4
ZSBtb2R1bGUgdW5sb2FkDQo+Pj4gZmFpbHMuDQo+Pj4gVGhlIGZhaWx1cmUgY2FuIGJlIHJlY3Jl
YXRlZCBieSBzaW1wbGUgdHdvIGNvbW1hbmRzIGJlbG93Og0KPj4+DQo+Pj4gIMKgwqDCoCAkIHN1
ZG8gbW9kcHJvYmUgcmRtYV9yeGUNCj4+PiAgwqDCoMKgICQgc3VkbyBtb2Rwcm9iZSAtciByZG1h
X3J4ZQ0KPj4+ICDCoMKgwqAgbW9kcHJvYmU6IEZBVEFMOiBNb2R1bGUgcmRtYV9yeGUgaXMgaW4g
dXNlLg0KPj4+DQo+Pj4gSSBiaXNlY3RlZCBhbmQgZm91bmQgdGhlIHRyaWdnZXIgY29tbWl0IGlz
IHRoaXM6DQo+Pj4NCj4+PiAgwqDCoMKgIDgwYTg1YTc3MWRlYiAoIlJETUEvcnhlOiByZWNsYXNz
aWZ5IHNvY2tldHMgaW4gb3JkZXIgdG8gYXZvaWQNCj4+PiBmYWxzZSBwb3NpdGl2ZXMgZnJvbSBs
b2NrZGVwIikNCj4gDQo+IFRoYW5rcyBhIGxvdC4NCj4gDQo+IGh0dHBzOi8vZ2l0LnNhbWJhLm9y
Zy8/cD1tZXR6ZS9saW51eC93aXAuZ2l0O2E9Y29tbWl0ZGlmZjtoPTdmNTVlYjMzNzNkY2E5N2I3
MDZlODUyMTcwNWEwNmQ0YmY4NGIwZjANCj4gDQo+IEhpLCBTaGluaWNoaXJvIEthd2FzYWtpDQo+
IA0KPiBQbGVhc2UgY29uZmlybSBpZiB0aGUgYWJvdmUgbGluayBjYW4gZml4IHRoZSBhYm92ZSBw
cm9ibGVtIG9yIG5vdC4NCg0KWWVzLCBJIGNvbmZpcm1lZCB0aGF0IHRoZSBwYXRjaCBhdm9pZHMg
dGhlIHJkbWFfcnhlIG1vZHVsZSB1bmxvYWQgZmFpbHVyZSwNCmFuZCByZXBsaWVkIHdpdGggbXkg
VGVzdGVkLWJ5IHRhZy4gU3RlZmFuLCBZZW5qdW4sIHRoYW5rIHlvdSBhZ2FpbiBmb3IgdGhlIGZp
eC4NCg==

