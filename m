Return-Path: <linux-rdma+bounces-2317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4C8BE464
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041451F285D7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB615EFBF;
	Tue,  7 May 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HI1mGTXu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2093.outbound.protection.outlook.com [40.107.104.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AD14D420;
	Tue,  7 May 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088781; cv=fail; b=raOCb/tJ1zcdytsTEKa8BmFgifNoyjHjWxT/b/NRxwBoTvDjBa4KGF92axOzDRqyQYj52FsPXazg6FzktjYCB43zCMbvLvvwJttWrwA/cd5hpjlPzbvrVjfrAaXzDW8m28HBV2BTP50fMi80ZQq8x7MmVCJdrtCTn8vQAZScWKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088781; c=relaxed/simple;
	bh=OZxxpzicjUaAwGFVN/MW52Ibqm7u0XYttkIEMfjuq9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WahHpNqGbvpXwCthSDTYxEp5lXyJvLGgCsBxXfwOMMIySFsouAGd/G4BfkkVBunyrsxZ2qG31p6l2vquNyfUMBJFL5iYcUKXBPzRWvJNCBAND/DF3efXdtioJnQ45aiwBubrz8Dq5zMcv1eGbfHbVJlYlNzG2s87YhmyYG5wfKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HI1mGTXu; arc=fail smtp.client-ip=40.107.104.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdyZ3FCHPBkcDsoBQ5RH1RwlVGWPz7lG7QXzC8Ybu9ew2cuQqgy6/YTthc+bF8itX3wRvgNNxZAh8AKEatG01h3+yfU165c3VFYZCvwgPybQt3r7nRZtBdBYpHz3oZscdiXk51ZArL0UE8GFIapLpyTVKatbIKNTpwExkYUTNaYbkd53ZR5f4t7PFibfJg98ECbDh3mdxD3cJdiG8JlWMm5wLkyLLN4VuHFbjwBBOxWT4qb/V4pWg1X3O82wzGzSDnbPk4ywFPHme7h5kbE2yboRpcxB571DuJiSvl8x5MYLqiTW/54FZ6TW/Y/EBUxJcth3gVxyDGGbGwivlXFlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZxxpzicjUaAwGFVN/MW52Ibqm7u0XYttkIEMfjuq9A=;
 b=eKPCP+e6x6xZoFmfUU98KiT2Bo6zQicsUEzjmg8czqjLJPGNms7XxfyAJhedGVx+ExWxDbDaXwT2rwJ9NRJ+fHPx3H9HnPi0YLPdH7XpZPSgw4VzhIRyvUOOU3F9cQlq5XJQTfGsqJzmFY8a4rbxAdWnmr7FskfruCNzZqlNv0yxkxweGwUIIeNT1XK930KEJsu7h7sceIyY0gNsgaAPJrQ+MhIsWC+RoFXwaKVRAT7pX1JBHAHBtCKhPBpU8GH/y9sHJ0YZgNb6lVEYEw1s7CT7GE4Z8V5l3R2FHtZ3u7Ph3AmojbHIk7P3Z/DW+pKU5LK0x8mJSSWx0+tnvKlpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZxxpzicjUaAwGFVN/MW52Ibqm7u0XYttkIEMfjuq9A=;
 b=HI1mGTXujF8P2ojooccpq0kd6qUCwRCb6BhMtRuhrMmobhYtZckiZUmKqBUk5qbE+2mdtJRnE/+tYGAJpPpX5F/1011ozDidVFvu6/Whb44fFOUVl5btKkBau97mRxMGdl5X4j+SRwMxXW/xyb+hFUa8XFqO6QUH0AsQBVFtcqU=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by PR3PR83MB0410.EURPRD83.prod.outlook.com (2603:10a6:102:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7565.25; Tue, 7 May
 2024 13:32:56 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::ccdf:58ce:ac06:6660]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::ccdf:58ce:ac06:6660%5]) with mapi id 15.20.7565.020; Tue, 7 May 2024
 13:32:56 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Brian Baboch <brian.baboch@gmail.com>, Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"florent.fourcot@wifirst.fr" <florent.fourcot@wifirst.fr>,
	"brian.baboch@wifirst.fr" <brian.baboch@wifirst.fr>
Subject: Re: Excessive memory usage when infiniband config is enabled
Thread-Topic: Excessive memory usage when infiniband config is enabled
Thread-Index: AQHaoIMSOaRl49tPcU6wnwya51e1cw==
Date: Tue, 7 May 2024 13:32:56 +0000
Message-ID:
 <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
 <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
In-Reply-To: <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b832e385-3ba6-41d8-8280-a2859aa5971e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-07T13:26:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|PR3PR83MB0410:EE_
x-ms-office365-filtering-correlation-id: ba673757-37db-481a-995d-08dc6e9a3490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?OE85OUFMUkVQTzN1ckIvNVpTWEU2YkZmeVNLSkcxQW1BSnFhZk5wb1phM3NI?=
 =?utf-8?B?T3VZNkM5ZmZEVUVaems5ZXhjTG5PMHc3eUJQWEsvdmJyb3cvWUZlRkY1Vndp?=
 =?utf-8?B?Qkl0VTl3akl4Ym9LZURQaURpOUlMaFNnYzZPZG90bjF1L005Qk5VZlFYdERX?=
 =?utf-8?B?YXErZE94UjFPbXFmemR3dHNFVVhHZC8rbko0OWZqYy9qd0ZTZ0c2RFA5dTg4?=
 =?utf-8?B?V1o2TWU4dURJM0dQeDBqNGY0NFA5TkJoQ3FXTWR1QnZTR3RHd3hneDdXaXMr?=
 =?utf-8?B?MmF3Y3YzZUVtT2ptOVRQUXNVNVpBUEo2cW1WMGt5Q0c5Z3RsdHJEbW41Q2Na?=
 =?utf-8?B?NjdSSDV1cy9KaXg5UFhBZDkzNExQSkxRS21sTXc2LzlXeEJQcWF4ODl3ajhn?=
 =?utf-8?B?cFZVRnI3YTBVdUVUcUlhN3VzTjA1cU91QTREcEs4R2ZsZVBPMVFKNzlWMzls?=
 =?utf-8?B?UWtGY0ZsM3QvVkZ1Zy9LOTArbktBeXcyeVNRekRNSlJsbG53aWFDb3UyQS9P?=
 =?utf-8?B?MERkWndZcWZVeXo0aXlVTHQwZmpIRmNkdlhyNGEyRzdiWllzSjJ5ak9maEFU?=
 =?utf-8?B?UEhjUWRIcjRXNUpYbW5GQWVDMSt1ak1XTnRXRUNOSE1ZTmxZRFkxa2JIejA2?=
 =?utf-8?B?VG1mTzRHMHJuL0w0RVh6eG5QbU5hcEMxUkQwNmRzRDE0b21rUlZDNXFaNkpr?=
 =?utf-8?B?ZVRaQXZ6UFVEYnkvNU1zT1BaRjUxV1NXQkFuNFc0RTFrTFRvN3FWWVF2OXM4?=
 =?utf-8?B?U1Yyd25ZcnVYSm5xZ005QUN1S0VrTGZuYytScWNCUzE2ZGI2NkVlckNhMjR5?=
 =?utf-8?B?V25yL2JTck5CMzJOK2gzR1U0NitFbFVyQjBYU3dRcDltQWlzM1dqSm9KYkps?=
 =?utf-8?B?enJ2dzJxM3g4aEh3am5ZYmVjc2x2Z0RMaDgrVUFvMEVZYU1KcVF6cU12ZUZn?=
 =?utf-8?B?UWZOSUdyZmdiczdqQUoyNTRpWmxJZ2hsUnEwc3VTQ3c4cWZNUG94YSttczZm?=
 =?utf-8?B?RURscGc5ekkzckVkdjZWSW1UdjNHTG1qOEZuRXNza3AyR2RKSGtBSzNvSVcv?=
 =?utf-8?B?b0JTbFlrUTdFaGRNMEIvRU4rQlJNc3BnMFVNK2NHaGxCN1p4OVdBV2Uwd2xX?=
 =?utf-8?B?OS9xTmZ2cFpNcWFTWXFnNFBvanFWSmtjYW5ESURYS1VFQjFpL25uY2FJV01J?=
 =?utf-8?B?dUFTb0ZCMXZWYS9xKzRxOHRyRnFaY1NmK1FVbE1vVit6QjNyM21rSUlBY1hj?=
 =?utf-8?B?U0F3UG0vbUhCcStDWjlpSFJ5cDZDdnpFVWxZbDkrTU9UYklYcjhIakx3WnVL?=
 =?utf-8?B?SXhtTnNlNUZLbHNSaE9SRUFhdE5oVTFkL3AvTTdyaGNrRlNYTDBWWERMeDFH?=
 =?utf-8?B?WlZqS0tEWENLbjJJRTRPQXRLYk9YOUxHQ1d1NGo5R21jcHVGdFBnb290dVhT?=
 =?utf-8?B?cUplMTVlZGRFVUZmaGpudHE3YmFGNUxVK1B2OEFkbjBta1pvOWlVVGphbzJG?=
 =?utf-8?B?R1NUUVkvQkcrOHZjdndSTU1LbTlYTm9qT2NxajVEVFJHcUtjblJ4TktONmRz?=
 =?utf-8?B?ejJMTnZWNDdlWmJCeVdTWlNSNnR2elU4NTFjbEt5SVJSNDI5dnAwUnNOWGgv?=
 =?utf-8?B?Ty9aNU5ZNXNZWGpzUlViN20vUnlPQ1hMZ0hMMzkrem9wdXNkcFZxUUpGNk10?=
 =?utf-8?B?eEt0MUlPdlBrR0lRclQvRVJEa3NJeE5mNTRZU3JsNmxYUXptOExmVEpFVWMy?=
 =?utf-8?B?K3B0aWZtWXhCK1p4L3ppa2VFY2dJKzl4MFpPT3M2K01nKzdNR1BJOXNXWk5F?=
 =?utf-8?B?S0ltRTI4dWs1VnlpWGlPQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjhPMC85Y0ttcWx5c2NkWjNSWDZ4OEx6UW00WDZjR2tjRXI3RXozQlNiMitE?=
 =?utf-8?B?dTFQb3dDTkJLY2RCSnZPL3Byem85Y3FKU1U1aFYzQ0FMMVBrb01aL2lxUGZa?=
 =?utf-8?B?cDFCQkZCeVh6NzhteG1rYlJnZHhvUW1VZWg5NHlxMHRudnMrZU1QMmx2MExP?=
 =?utf-8?B?OUpKckx1V25lNHI3VG05WVoza3JwQkdveEJKMGR4OE1jRUNSUHdqSnR3YmVN?=
 =?utf-8?B?cUFnVmtWd29YOTR1OEs0dUl5bG8xOFRJKzNOTDU2R2pIRnNWUlZFQW9CRHRG?=
 =?utf-8?B?aVh4M3g2aDU4eFA2WVd4WW1FQythcS9RdkRsODBOTDB1NmFlZ1B0Y0pxUmpU?=
 =?utf-8?B?ZG52Rm5LdnVSSEFOL0lTcEVlSW04azZwRVJPRFRIK0M2dzI3L3cyaUpKdzkz?=
 =?utf-8?B?bE9LWHdZRm94SHJhTnlYWkh5Sm1QZnlrV25tMTJKQXZzNkRVaVhGa1p2OW1T?=
 =?utf-8?B?ZWN3MjczU0ZvejIreGdDanpkUHFsazdRN29LYU0vTDZOcWVtZFFleDFRT2R1?=
 =?utf-8?B?cVdyS29YOVdOWkM1OTVRTm5GZTlza0pnay9JMXdPcXQzL2thSEczcVAxUXhy?=
 =?utf-8?B?NUhjZEtkL2JhNEZMZHRNUmZjZFZRWjc2dHg0cEFpZ09yc04xNFNQVXlGSzJQ?=
 =?utf-8?B?ckRtVHIrV1NZcVpIYmlRMUpTU1RyQ3JMM0JMcHcrdGlHQzFBQlZJZFNKWDZo?=
 =?utf-8?B?eVhyaFlNNTNCWk1aRUZydEpMSTdpTVlmNEFOOGVzN096S2xBSURjUVlIK1dO?=
 =?utf-8?B?cXZrYnhDV3lFbmZONmtSNVJoVnp3RUJUS3hsdGlheTRuQ2orQVNrZFN1M1oz?=
 =?utf-8?B?alJydEh2WkJ3NlVZRWFpeDFmeStxSXJ4SjF6ZnFDSkt1QkZEV0VrWWI2a05T?=
 =?utf-8?B?b3JVQWgraHBmOVFWYkR4Vzk5Z3o5dGRWeVNrejZoWGNKWVlRRXV0djdyV0dk?=
 =?utf-8?B?Unh5bkVJSndHVk1QUC9XdVBuSFJZRUQ5WVJwYTVGY2RJdnZFZlJpQlpmRVdq?=
 =?utf-8?B?RzBkaWF6ZjB6MHB5MktEeVFuSnU2WHJKU2tmR2hYM2ExcGZmZWU5ZjFXU3Fp?=
 =?utf-8?B?MEZsU0xkZDRpemhCZXVveDVDU3JVVG5XN2M3VEhEU0pDUGZzSUFjSDh2OFBM?=
 =?utf-8?B?T3d0bk5yMWxWWXpjTEpTRWJ5amdnUkVEMG9aMVAvZVB0N1FtYWJNUWJTTzky?=
 =?utf-8?B?d3IxOUN6UXIxUkNteVNtclVhMkdTR3VZN0JwSGVOMFo0RVpuUzl4RnBwRGRn?=
 =?utf-8?B?QWxkRERwdEs3b3p2blM5UVdYU1cwN2ZRWUNmeWpBZ2xZeXJvSHIxVEVkMERH?=
 =?utf-8?B?TzllOWhqSVRYRVFVR1lzMHR4d1Z1Q3AxY0l1ZDc5L3VnK0s5YWFIOUVhRldG?=
 =?utf-8?B?bWZsMVNsUXV6YlhudG5aSXg0WFlBL3JpT3drRVVZdG5OSDJnYjBuUmZlU2pv?=
 =?utf-8?B?Wi9tVHM1cGxQRnFZR2JpYXFuYmpRbGRXMWFHd2VwMzN1TXNCclJ3RDFSUk9n?=
 =?utf-8?B?dk14d29JL1hKUTZ3WDhsbllMOEp1Y2l5N3FyMktJUWMwWDAzZG0xYTA0MDhr?=
 =?utf-8?B?TmU0NHA1L1lKeVV4Z3JuU1Y0RnYrekttbmpyUlhPeUtVY3BYcENIL3R2NmRw?=
 =?utf-8?B?NHR3a3plUEYrdkM3cVpNUVVkQ2tpVzBQNXV2bW9kOHJ2QUNGMytDekYraDVs?=
 =?utf-8?B?Y2w5L3dPVVRXQ1FUaHZDMThJdnpJZGNiV3RVQmZLNVlkbGNVRnVFSm1JZVJy?=
 =?utf-8?B?OVJISkwwNTM5WXcyMW81MG1lYlZBVlJHbUx0c095cXJVejRHakUvSXB5WFh5?=
 =?utf-8?B?VEM4UmhPM0dEL2YrY0tnNVRrNTJDRGMzYWVBQ2JLMlRlSnJodW5QejJRY2ZQ?=
 =?utf-8?B?TDE4SzVYRTlYRGhnOVlYeGNrSlU3QlcxWlhPWm9Kek1IUVR6UG4xOVNBV3Ni?=
 =?utf-8?B?YlhUbDArZUVUTGI2cDI1QWhveFpsU1E4cC9QVXBvVnJLWlZZRGxHZGxjaFJN?=
 =?utf-8?B?RHJzZ1RDc3BxNm81dDFNZ1hLMi9FM3hqdEtLcEx2ZUthV1RXZXpBVjQyclFT?=
 =?utf-8?Q?HowuvA?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba673757-37db-481a-995d-08dc6e9a3490
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 13:32:56.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EG9n2oovtWhNHgvGXeQhA7PtXIb2x8+TARQDgp7+pDzDid8ixu+OVNqbS/NmqiWalC7fILFbo0XAldCLtbhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR83MB0410

PiBIZWxsbyBMZW9uLA0KPiANCj4gSSBmZWVsIHRoYXQgaXQncyBhIGJ1ZyBiZWNhdXNlIEkgZG9u
J3QgdW5kZXJzdGFuZCB3aHkgaXMgdGhpcyBtb2R1bGUvb3B0aW9uDQo+IGFsbG9jYXRpbmcgNkdC
IG9mIFJBTSB3aXRob3V0IGFueSBleHBsaWNpdCBjb25maWd1cmF0aW9uIG9yIHVzYWdlIGZyb20g
dXMuDQo+IEl0J3MgYWxzbyB3b3J0aCBtZW50aW9uaW5nIHRoYXQgd2UgYXJlIHVzaW5nIHRoZSBk
ZWZhdWx0IGxpbnV4LWltYWdlIGZyb20NCj4gRGViaWFuIGJvb2t3b3JtLCBhbmQgaXQgdG9vayB1
cyBhIGxvbmcgdGltZSB0byB1bmRlcnN0YW5kIHRoZSByZWFzb24NCj4gYmVoaW5kIHRoaXMgbWVt
b3J5IGluY3JlYXNlIGJ5IGJpc2VjdGluZyB0aGUga2VybmVsJ3MgY29uZmlnIGZpbGUuDQo+IE1v
cmVvdmVyIHRoZSBkb2N1bWVudGF0aW9uIG9mIHRoZSBtb2R1bGUgZG9lc24ndCBtZW50aW9uIGFu
eXRoaW5nDQo+IHJlZ2FyZGluZyBhZGRpdGlvbmFsIG1lbW9yeSB1c2FnZSwgd2UncmUgdGFsa2lu
ZyBhYm91dCBhbiBpbmNyZWFzZSBvZiA2R2INCj4gd2hpY2ggaXMgaHVnZSBzaW5jZSB3ZSdyZSBu
b3QgdXNpbmcgdGhlIG9wdGlvbi4NCj4gU28gaXMgdGhhdCBhbiBleHBlY3RlZCBiZWhhdmlvciwg
dG8gaGF2ZSB0aGlzIG11Y2ggaW5jcmVhc2UgaW4gdGhlIG1lbW9yeQ0KPiBjb25zdW1wdGlvbiwg
d2hlbiBhY3RpdmF0aW5nIHRoZSBSRE1BIG9wdGlvbiBldmVuIGlmIHdlJ3JlIG5vdCB1c2luZyBp
dCA/IElmDQo+IHRoYXQncyB0aGUgY2FzZSwgcGVyaGFwcyBpdCB3b3VsZCBiZSBnb29kIHRvIG1l
bnRpb24gdGhpcyBpbiB0aGUNCj4gZG9jdW1lbnRhdGlvbi4NCj4gDQo+IFRoYW5rIHlvdQ0KPiAN
Cg0KSGkgQnJpYW4sDQoNCkkgZG8gbm90IHRoaW5rIGl0IGlzIGEgYnVnLiBUaGUgaGlnaCBtZW1v
cnkgdXNhZ2Ugc2VlbXMgdG8gY29tZSBmcm9tIHRoZXNlIGxpbmVzOg0KCXJzcmNfc2l6ZSA9IGly
ZG1hX2NhbGNfbWVtX3JzcmNfc2l6ZShyZik7DQoJcmYtPm1lbV9yc3JjID0gdnphbGxvYyhyc3Jj
X3NpemUpOw0KDQppbnNpZGUgb2YgaXJkbWFfaW5pdGlhbGl6ZV9od19yc3JjIGZ1bmN0aW9uLiBZ
b3UgY2FuIHJlYWQgdGhlIGNvZGUgb2YNCmlyZG1hX2NhbGNfbWVtX3JzcmNfc2l6ZSB0byB1bmRl
cnN0YW5kIHRoZSA2R0IgbWVtb3J5IHVzYWdlLg0KDQpZb3UgY2FuIGFzayBkZXZlbG9wZXJzIG9m
IGlyZG1hIHRvIG9wdGltaXplIG1lbW9yeSB1c2FnZS4NCkJ0dy4sIG1vZHVsZSBpcyBsb2FkZWQg
PT0gbW9kdWxlIGlzIHVzZWQuIFRoZXJlIGlzIG5vICJsb2FkZWQgYW5kIHVudXNlZCIuDQoNCktv
bnN0YW50aW4gDQo=

