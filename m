Return-Path: <linux-rdma+bounces-9131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B7A79A49
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3062D3AD525
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EA2AE9A;
	Thu,  3 Apr 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MqSu+I44"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553861854;
	Thu,  3 Apr 2025 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649228; cv=fail; b=M/KgYJpUy09XU39c1TsOCMJ1PrU4OOwdEKnPda4AdIueABP43bVH09ERfbjno3+44COw5EUVzMUnM+2jMvsFohaE4AlBcegXJg7BKhaBMKC7jbJVC4HvIYusTOC4jGoxvb0zj8y6Ik85qooWlBsa7aGGd/GrgLxOG00r50O6djw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649228; c=relaxed/simple;
	bh=JQXQIKm9YXcY/Ogo/QzC8Rq13ZhEn/Ah2wtl3uKGINQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmQ6sRAXkn7HFU3MeYOUVRytdKx4CVyOpVon0AboZnYHx/E1VJILCeJJBN9dsC06UYepMLfYM8WyH3sg6Uu4z0zpsubXpAb0s2f/45If0UgQg0BfwoX2qmDeEusXTm/YUopRO1zZh/Gebe3E8mZ8Sd5wGo84in2CA9lQPr6m7vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MqSu+I44; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743649227; x=1775185227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JQXQIKm9YXcY/Ogo/QzC8Rq13ZhEn/Ah2wtl3uKGINQ=;
  b=MqSu+I444q0yqe44tDZgj6S9/qIkItOIiTO7S0MTbR4+GOnhEua6hT1E
   65dSt+pwx4rbEwxWJlTXhO6dxLxQkcJOl0lD1UqNxNiHs8k6jgFsW0d4u
   DzYiidTBQKPIpe7Re5BA2+IeL87o6c6TjUHCLqX2KzHmWiCAq53JD0GoT
   Vc6hmqDmA2vyb1Jh9Je7Mv1q57WfGo/l2BIocmzuxnFM/4Oy6OGzlzYwk
   ZO8x/asv7HC9kv0j5r16K24ussB9tb/KEMWO5Podo2LQxGWEs06Gvle5O
   Ab49kp8UV6IdLglmqoq3SYVSgsB6aQ8EPuneRvpLsEnRujF13OpbVvS4s
   Q==;
X-CSE-ConnectionGUID: VqkQeLbNSkmFRM7Pb7l3Cw==
X-CSE-MsgGUID: 9ZJNM8SpRXCCsuDCngekvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="152140202"
X-IronPort-AV: E=Sophos;i="6.15,184,1739804400"; 
   d="scan'208";a="152140202"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:59:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxKkKcyRI42FkO1tc/iERSr3tMXG9Jdvhhth78p1sA1M26kmYmQh+tcVd8rFYO/o9QaaStu1qRbLiCcjRHoqv+9golpnPfvnj42Mf4gJGD/2osrWdgOwhJB8SS8zf0FV+QADm5CO5aMZYaODCvrqVfPAvDQavZr0PJMepv2xhKpRE7iyeiwwK3PzhcAXPfsef3fBEY8yjmyeAmZUonO7pxHGu+O6kGXHzz55GHMxUpnKB4Wm/MG+Rb8/25rtB+usPjAFBYqrlsaK1NgfrBcr/SrKkp9a7ykFUFwT79lERXMQ22GsphIxpicc6dw0gWK9tvzJEMcpacDH78/0qOzKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQXQIKm9YXcY/Ogo/QzC8Rq13ZhEn/Ah2wtl3uKGINQ=;
 b=E9wJTbP/qRyzz858RsSAubO7TS92fnve81ApknzmXrT3q4y5aOlat9pnaZOE250EzeaXtFFdjxTW0oyhT0Gp3D6grvqqfKxI5XcwyzBB7lCw/0UNDdy7IIqHjZ2IIw8Nx5gdBwrgB7kb6L29wzqLhoITU2Tc176YhDj3lDuV6bgEMGk2T1dmq9QKLQlQHVhB6wnUZjH1GhotFXilZBeMcjt6lKmbDSF/ig4IUx6cy2eIGJWQPrnK4VBfqMFR+zQDuFJTm7agkX8x3ZrULtYGltcOrvCarJA9Z6kpm8CTZq2XSG9JAwnq5R2rVWfDzh5zVqRgPU8Ka/0Vls7j8ymy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB13137.jpnprd01.prod.outlook.com (2603:1096:405:165::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 02:59:07 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 02:59:06 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>, "Daisuke Matsuda (Fujitsu)"
	<matsuda-daisuke@fujitsu.com>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Thread-Topic: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Thread-Index: AQHbo38gxlirxY/s70CV918ho0hgcrOQE9UAgAEt5AA=
Date: Thu, 3 Apr 2025 02:59:05 +0000
Message-ID: <20551f6e-df87-460b-9927-70c93b8d6149@fujitsu.com>
References: <20250402032657.1762800-1-lizhijian@fujitsu.com>
 <a0eb561e-9fa9-46ab-bb0a-6e68a8e0d834@linux.dev>
In-Reply-To: <a0eb561e-9fa9-46ab-bb0a-6e68a8e0d834@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB13137:EE_
x-ms-office365-filtering-correlation-id: ad031dfe-6548-4173-f0e1-08dd725b7f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGY2Nis3UXlEU3hvaTVielA4MXpKWWJhVHIrOTRaZ3ZhbExyd3ZtVkphRUVp?=
 =?utf-8?B?ZkY1ZHBFblNmNVFQRy9xcFJMTzArYWQ1RjFKc3BJZjBVS21sRzN1bTRzN1ZC?=
 =?utf-8?B?UTViVW5aMjEzOS9lNm1tVVJ0MG5IVnV6OWswVUlTQTYxOVJGVkpKSkRHMGc0?=
 =?utf-8?B?NDhQVlZ0UkJDc2dnQ1MxMjJZZHNxMGJUU0hKcEJiRnlVSDMzM3ozQjZDNDU4?=
 =?utf-8?B?VXFMT1hZOS9ibUZDK2JsUGZlM3hmZEFHYnB5bE05ZHNibnI0VERMcXVFeGVH?=
 =?utf-8?B?NnJYZTZ1eDZLMnhNM2s0Z1JBZUZkckFLdlBBQ0RocDN6SjJ6aWVBZTVBU1Q1?=
 =?utf-8?B?NUZWZW0xOHBLNUQ0NUM0aXFBQlV5VGpabk9hNzNSK2hBSWVLZ0NZam1BS0xa?=
 =?utf-8?B?eDZCbDBLNWx1Qk55NERVRi9ZNHdoTHdDM2JmUGRuZHJCYnRiQVpyNEZVaGJG?=
 =?utf-8?B?a1hwNnBWS3Q0SndzTDhmYkdRTGc3cU9UQ0FrcTJUMkQrdTY3bmIrTnVjbE8w?=
 =?utf-8?B?NWZIUHVQbUhkL0VrNGNzZVNyR0pSV3VnTFdkTGpRLzMvSHZKc0dHTVF0Y1FU?=
 =?utf-8?B?dmtmWDU4dllwVU1IeU9LditCaFBBeER0MSs2TUNwN0NHdjNOM2dtTGFzdk1I?=
 =?utf-8?B?eUNOOG9WTjJKZVlneGJSS0lSWWdERkZNdXZGSWFreEdmVlFLbkt5amNpaVhX?=
 =?utf-8?B?RmpHZzNXUW95cEx3bG1HOFhYVFI2VFpTa2hhNU84Um9mcjFadFhkSWNVZDh3?=
 =?utf-8?B?VEpSWURCRDNSNEMzSlBkZHBsVTk2SS90VDhWOGVQVHdzVitjbTJMWHEyMkNp?=
 =?utf-8?B?bVdWcGoyTGRwSGlhR1BMSlRwUm5xb3FvSHRFdjB1WHA4SXNqN1ZUdEJDVmZw?=
 =?utf-8?B?UDlYTjFKN1RNZE9QOGdaWE5IdnV3Wmh3TEJaQzJaaUNsZTBybHFjN0VGOFlP?=
 =?utf-8?B?U0F3cmJuYXp1bHlBSWJoT0dkL2l1RDFQY3E0L3pCcCthajBUc1FIMEJWSTc0?=
 =?utf-8?B?K2Jmb0VOZGs4R0NTN1JNK3pONVg3L0RyejhaY3IzR3hZeHZuemJMWm95bzk1?=
 =?utf-8?B?SFduZkwwRUh1UTZLaGs3L3BCMStHakhtN2JDUlhla0lIMDB1U1RQd2JQZ2V0?=
 =?utf-8?B?RWc1M2xzVk81TDdIT05nRVZZbC9qWmNIU2hzbUNMdUVEK1Nrai9hVFF6RlF5?=
 =?utf-8?B?cEhuTFBXSHlzdTF4QjdsWVhQRjN2R3JrYXh3TG5ZSjlZN0JPcWlCak1VYVBt?=
 =?utf-8?B?SWkyMUx4SWRYb2VhMkU2QkVtTGZEZnk1L1RtY0NudVNHT3Y0aDNZVE8zcWw5?=
 =?utf-8?B?bFJ4WHQwakhMdmVYenlWS3lvT0tMZ2ZwYUMvSlhwc0d5OGV4S1pBRzYxa2tJ?=
 =?utf-8?B?bFhvbCtnOFk2V0k4VENTTHFiVDFmbnkvS2FEVEZyMmp3azYzVWxQM1JZdUFw?=
 =?utf-8?B?WGc1dFNRRS9rUmd4b2RrdldkeEx2cUJEZ29BRklTaXQrN25IV1BmcURLVnc3?=
 =?utf-8?B?TEp0NkRzbldQZFUwV1BqYmM0cVJ4SFVrRkdlc3VvMlByTmFJOFEvS0ZNbUpr?=
 =?utf-8?B?M3ZZcU5pdnM0RWt2bFhwVHVHY3oxWkpPdksvbkg1eEFWcDdKZG1jQmo4V2FY?=
 =?utf-8?B?NHp0bFUxQ3AzVVdJdzdPMDJMN25ra2lGMjVYcGxKbElBL2oyVUVxOHJ2QThB?=
 =?utf-8?B?ME1ZSzU5RkQwWEF1VitobFVMU3o0SjVhQjQzZzJKeUpZMXZyK2VRQkU2Z3ZS?=
 =?utf-8?B?MkU4V2FpNmpBMUNpQmVoUHJVQndJaUtqZWRiSk5BMTloQU0xeC85SmJUTUxD?=
 =?utf-8?B?eDlsY25FMi9Rc3NwRkh6VENja2Zwb0gxTlNVc3RKN0dDZFdZTzk2cnNycUdj?=
 =?utf-8?B?b3diRmZ1MUtrWWh2cUN0MzM1Zjh3TW5NUU1XNXJLNXdDVmNoejhVQlB3ejRr?=
 =?utf-8?B?bGo1MjZPcHZiMm5pWTJUbHZYeEczY0owaFhyckxWandmcHErQTNFc3R0bEJi?=
 =?utf-8?B?YmRkWGZ2ZndBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2tuWk9yZGNwam9lQXdJSkdWSU5EVlgvQ0xGaGt2djFqMWdlYVhIU0Z2ejE4?=
 =?utf-8?B?VmpBcjdPY3d6cDFOUTdCclFzZXk4azB6RjF5UFM2U05oN3oybmtaRlZ3RjVJ?=
 =?utf-8?B?UWw3N2hQZ0JpVEhsd1J1MkpPMmxackRMZ3FMdnJ5WktJU0dwQTROWEk5TEJj?=
 =?utf-8?B?UWNBWXljMzlOMlF2YjZPUm1mMGtnNVJUa0hZQ0lmRStQSldjVGRuL0JUaXpP?=
 =?utf-8?B?VHFvYVUwM3JLVTBlQVlwaUdnYnBkSkVTbGg3TnNFTjFDWU9qcFQ0akVoNkRB?=
 =?utf-8?B?OFgyK1dxTFV1aFhlSm9yK0lyMDg3aE1UVzRncHVic1ZUVzVtTDVuNFlyM3BL?=
 =?utf-8?B?aEN5Ry9mZHJSSlBKQ212VWltRGFWbjlTdVJzaFQ5YkNtV2hTa0FTSTRUN3Zy?=
 =?utf-8?B?a0dDVldJeXlZNjhBVlU1TnhJc2VsRnBkak5mUXlYUlJXZWk0cDFla1lVNWxo?=
 =?utf-8?B?TjZFaGdZZlczMVJabkZFSUVyM3IyMkZXNTJPdzZrSlB4OUMwemgvLzBpbit4?=
 =?utf-8?B?SVI4bUhiMGpnVVFmRk1YY0xmQ2NIUkIvVkJOSzNDeTNUU0hrR1M0Wm1ybjRl?=
 =?utf-8?B?OGM3TUI5OVVIaUZRMEFnYSswZmIzbnZCQktMN0JLM3FUeUpncWxjVzUzUUwy?=
 =?utf-8?B?bXUyR1hFK01IVkNZMlBQVTFDQ0Q5OHpjWE92Q3FobVhpeW1WUXVnWjFDVTYx?=
 =?utf-8?B?b09ncmxrcTZxbkNVaTJtczNiSUJaSFZZWFkzWWNYOXZMRDl2WlNkREtnZVdm?=
 =?utf-8?B?am5yeHFUMCt3Qys3ZVI1bXdySlZYYWl0NXhCN005V2RXTjNNbXVHUEM3bmdj?=
 =?utf-8?B?V2FxR2lzMThXRFhocmY4V05kb2R2VWd0YjJKMkZoMm1qT2FMN2Q1RlljTFRL?=
 =?utf-8?B?VFd4TzZxeEFlTENYa0hWQzkvaUdQWWhZSzluV2Z1aWtOMXcxUUVnYmd3aHVm?=
 =?utf-8?B?NThWTVgyQVRQckpUaldKV2ZMRTgrZEs3YUdsV3NGM1RJRHNob2VvQXF3eEt0?=
 =?utf-8?B?K1NLUXNCZStuV2R0WE13YTVVUm9jbjQrQWdCbUNFWXdNMVJxZFhLWHF0QSt2?=
 =?utf-8?B?eUJxd2pxWVNSamRud2h0TDhXN2VzdzhGWGRZdU5jY3FxaDA2OFpFWmlOTmJi?=
 =?utf-8?B?NFVRR2hqNFVlTDRKbXJEbVQ5Mjl6MlNSQktGcXZ5eW4yYVF2NzNiNkcxNktj?=
 =?utf-8?B?VXFzdEplT1JqdnJxU3AxeGNSMDNEZU1ibjE5czFvZjQ2SW5Pd1dKdVZuaVVY?=
 =?utf-8?B?S0srdXZhc2FFOEk4WXlpcUxURm8yUTVxN0hSaUtSV014WW9UaXRLL1VHQnpZ?=
 =?utf-8?B?RUN6NDM1RFF0ekhHNE9TWnFOZ0NFalBvdFFUbWxyTDFYMXhseVo5Qzg2S3Ay?=
 =?utf-8?B?QlBNeXh1dGppem1YR0dzQUlGSmlmWnBmMTdoVkdsbVdPSTBzMXNKL2J3cDhS?=
 =?utf-8?B?a1lJNnMrblhyckR6ampCUTBMakRpWWp4WkJQZWFsS2dLL0F0QmVmOUVzWW5m?=
 =?utf-8?B?eWwwUEY5UmxEaGhzQ2pQNnhKZ05nK0p5RW5zSUl6QlppYnRjK0VIZ1NTc2Jw?=
 =?utf-8?B?VTRueDhUZTduemFULzRTUnBIRHBNalQwdFFPNXJrMVE0VUtXVlVvSS8vUmdE?=
 =?utf-8?B?NFd2dHdJOW1mR1B0cXpIUGFJUVN6ZjcyMk80dkFGTCtyZmdnMG9wUzMxY2hh?=
 =?utf-8?B?TTNXZ1YyTngxMmZ4QnJ3UHluelJscStKMkl1MGl3MVRDQmduMnZKZnVUSm9R?=
 =?utf-8?B?WE01OHZ2RTBXYkcvZUdJdE5ITVl0VlY3eldBTEs3ckM0U2NDTmFhMFpBaS9B?=
 =?utf-8?B?Wk1VU2gxUTB1dklsQ3RaRVhaQjBHTTFPdFoySldVd05JRlJMV1NKUUlHbzlT?=
 =?utf-8?B?RkQyV1REdTQ5a1pQS2ZKckRsaWFVc2RBdXdtVlIwc05ZYklXVW5JK2tLd05S?=
 =?utf-8?B?QXdUMmczQVcxUlFWV2gvaC9nSCtSd05tNUxzTVo4MWl4Y0ROY1h1Tjh1RVdq?=
 =?utf-8?B?bkpuTmlld0RkS1hKd29OdDNTMmtvU1h5QUQzSTYvNVVQdEZhNVBTUEJKeUV5?=
 =?utf-8?B?Zi9oaGlhVTdVRUluYzZLVzdHc01KZk9lRWRWYUEyZUhXS3MxMHYxd2pvV09C?=
 =?utf-8?B?eUZzR0U0RkZDaS9sUVVNREpwMUNOU0F5RFN5dnk0Z29LNGh1NHBUaUFBZXBh?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C0ECCE4048BDF47A75418701D51079F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	all5Sm/PLU1QcoIFg0ZxSn1hCvDsan7mEjOh37QcUTP6YHmY1wLt7w3WnCgtSeSTgv0sDkmLPXBQ5yWXYmr0zL/e2iWYYAcJyeNC/hwYrzdgf7wIPqJ2qsu2+L/4m74nWIyEJZzmlyPhEGwg6TKHRRucTZfjYkWo2D3PMEQ2PlBMEFT2DriKQn48i7Z0JUzce3JqlixeIMrVvIqCYvBIQIeWipyeEmK2XgPGbvjJn9vtun8WLuKptV68o/82k9QHpg071Gd1a3f9qZ/vQH8Rx3bIxA8hN3WhkiiQXb0b5cR97Yuw4zaKNCqfOfruuODzIe2606IWDkfA/n9ozh+Q0HxWvpH2reVqRlUtC3uu4tv2mclVsKKFohSXwvsNSfM29S0IFafisQ1j+07hL76X+a/Hh9yr/LETKvoNyrkKZn0idE/hxrpu59wHvvxYe6sj355p9OerbvGEaMHD9kraLUZJEzTMULoB1z+ccMFjyFHjmXJLzbqPIKxfJwy4VCNN1q/yyscfKbGgadP8PcFMfw/CUrvGNjZfy3pb8+HJiW6ou2ZqbuiC+ZmFTFN8tOgJ181HXohtqtUM4qsrnbwQX02I4OANS/buPkbKi8bXCQxU0bugHftyf21uIvTENw6N
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad031dfe-6548-4173-f0e1-08dd725b7f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 02:59:05.8397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nX/lIBzFlRlq82pklYSULlQfefEptLYit8/Pc45ZWJtCPT/0Gn+jwVTz/civbs3Lr1oRJoM+APsYXDNNZ5FoSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13137

DQoNCk9uIDAyLzA0LzIwMjUgMTY6NTgsIFpodSBZYW5qdW4gd3JvdGU6DQo+IA0KPiBQcmV2aW91
c2x5wqBJwqBvbmNlwqBkaXNjdXNzZWTCoHdpdGjCoEJvYsKgUGVhcnNvbsKgYWJvdXTCoHRoZcKg
ZnVuY3Rpb27CoG5hbWVzLg0KDQpUaGlzIGlzIGEgZnJlcXVlbnRseSByYWlzZWQgcXVlc3Rpb24s
IHlldCBJIGhhdmUgbm90IGRpc2NvdmVyZWQgYSBkZWZpbml0aXZlDQpjb2Rpbmcgc3R5bGUoUGxl
YXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlKS4gQWNjb3JkaW5nIHRvIG15IHVuZGVyc3RhbmRp
bmcsDQp0aGUgY29tbW9uIHByYWN0aWNlIEkgYWRoZXJlIHRvIGlzIGFzIGZvbGxvd3M6DQoNCi0g
RnVuY3Rpb25zIHV0aWxpemVkIHdpdGhpbiBhIHNpbmdsZSBmaWxlIG9mdGVuIGRvIG5vdCByZXF1
aXJlIGEgcHJlZml4LCBhcyBjdXJyZW50IHNpdHVhdGlvbi4NCi0gSWYgYSBmdW5jdGlvbiBpcyB0
byBiZSB1c2VkIGFjcm9zcyBtdWx0aXBsZSBmaWxlcywgSSBiZWxpZXZlIGEgcHJlZml4IGlzIGVz
c2VudGlhbC4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gUGVyaGFwc8KgaXTCoGlzwqBiZXR0ZXLC
oHRvwqByZW5hbWXCoGlzX29kcF9tcsKgdG/CoHJ4ZV9pc19vZHBfbXI/DQo+IA0KPiBTaW5jZSBz
b21ldGltZXMgd2UgZGVidWcgaW4gcmRtYSwgd2l0aCBhIGxvdCBvZiBmdW5jdGlvbnMgd2l0aCB0
aGUgc2FtZSBuYW1lLCBpdCBpcyBkaWZmaWN1bHQgdG8gcmVjb2duaXplIHRoZSBtb2R1bGVzIHRo
YXQgdGhpcyBmdW5jdGlvbiBiZWxvbmdzwqB0by4NCj4gDQo+IFRodXMsIGluIHJ4ZSBtb2R1bGUs
IGl0IGlzIGJldHRlciB0byBhZGQgcnhlXyBwcmVmaXggdG8gdGhlIGZ1bmN0aW9uIG5hbWUuwqBC
dXTCoGFueXdheSzCoHRoaXPCoGNvbW1pdMKgaXPCoGZpbmUu

