Return-Path: <linux-rdma+bounces-3533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E89F918E7B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA0E1F26373
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F9190679;
	Wed, 26 Jun 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D/+6y2ek"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7319005D;
	Wed, 26 Jun 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426547; cv=fail; b=oc21dLxWNij5Yi1zldZhd5f1cAKfk937iGixssmAfPjQtup6yLEZaBQc9Endp03KNNnWbco+6RL0AOSEu9gEsu46MuB5LUn3jwxJBg5fNBbdvEQXQz6vcuDRmy/QQMCLBdRpUMqgMlFOpmVOQ36ZBcz7Ba42zzOls+Kjz4gQudI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426547; c=relaxed/simple;
	bh=LQttRUBEWUAJGECPPbUL/lEKFHlt4CldI+QqwP5UIo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGCz380ps21C/NZIU2eC30J63skNUuaZlaHZGlkSWdA20w8oDR3ASVnqMdoMDTu7kKK5Xy7bvqqCxfj+it9QX8tL05Eri1L2bNg2drGd6pc4ytjY0zddkP459Hm24VMM9aCzb9tVOPjhZNkCnXI9hcV1C04/uuuRXoNoVSt+A2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D/+6y2ek; arc=fail smtp.client-ip=40.107.94.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRSA1L9/EGqR6NeLc3pEab42mMWZF4nPCLuhjR1RnWGvRiL8Ughug98z67H95Vh87Tye1v1oSJ0A+zVn8CWcfCOuhILnf2JVkBSjRsIfeJcV3QI8pqEg41xRMJL1v14L5otBdDhtszPfBzhqVZgyD83mgQTGAPjFpRRCNyyI0H0wtvgCc4jzFSq1XYd7ExS/Q9PLrXc7sFl2eRzo9Ko4Kpxtg7Vr926gL/uQ5EbJp5p4TGrBbsoQK1K3+fRSRYESSvUDWd5rI7SoPEZchhnrHuv7Pzb0yDpZJ3WuXLvUX07UL+u4ZaQbIbpyNkVawS6FK7MDf1bXMfCMsOxTY5Qzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQttRUBEWUAJGECPPbUL/lEKFHlt4CldI+QqwP5UIo0=;
 b=m5JM3gs3EU8kWK40d0GmMSRvOur0zTsq8KRb4qmJ6jHvPdDkhFU4T+etnWLb5LB7BdYabNk5FmpFxio8xM7Pdek9K/IfNK6frndZeogkiH/SJwCAVLp2N9E2CH97/JYZdDMNhwlJoxIBobtqr3bhjYlaBPt5uXW/i9G3m3yW5cWQTCy5NW5WLwD6tVGuqvFJ+kTNQ8aMlaXFv+biV4svle22iwAeMc91UlDRz/htWXvzhafqHbcU94S2ZQJ7prGZ6ce9NZioAUGr3nmN4b06U45f58VFCqYxQJEJEw6k7fwfn0ARU/0tMdVNwuWXGUqTuXbhKQ2zF4AiRG+sp8O7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQttRUBEWUAJGECPPbUL/lEKFHlt4CldI+QqwP5UIo0=;
 b=D/+6y2ekPvv2kYeH0YdbYFYsvKXRwssdf9tOJssyHz8cliTGsZ//Se1jTH6lVGkOR3Pj8d18kvcRDjTWjCJUD2NfbvMEtZyTipFUGiJVrrflffurCkEZcnIi6Apte1bOVcXiPPyZ65DmcUQ5U/OR8n8BkWCHkel1iv1smozgUp0=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 SJ1PR21MB3553.namprd21.prod.outlook.com (2603:10b6:a03:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8; Wed, 26 Jun
 2024 18:29:03 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e165:ee2:43ac:c1b7%5]) with mapi id 15.20.7741.006; Wed, 26 Jun 2024
 18:29:03 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
	<netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHax/VptPUFxpDhC0qzKAWZO+66RbHaW2AA
Date: Wed, 26 Jun 2024 18:29:02 +0000
Message-ID:
 <DM6PR21MB14819FB76960139B7027D1EECAD62@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>	<20240626082731.70d064bb@hermes.local>
	<20240626153354.GQ29266@unreal> <20240626091028.1948b223@hermes.local>
 <PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
In-Reply-To:
 <PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b29753f-b919-45bc-b000-b5171f6f686c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-26T18:16:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|SJ1PR21MB3553:EE_
x-ms-office365-filtering-correlation-id: 33bb06dc-137f-42f6-39c6-08dc960ddadc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEllYUFZUGs1QVo1T1NyUjdIMU5VbGo0OEJidmJxeUxvbUpkYVJ0ZVdubUdS?=
 =?utf-8?B?ekpxcnFkdmx0eEM2ZWZ0bGpHVUpPZnlrenhJMlZVeGVJZktzYlFYamVOemU0?=
 =?utf-8?B?MzNQRnBXWnNYQk9rbzFXSU1zMldHZmJwWm5FbDk3VDJ5T2plL1d6dksrdFhu?=
 =?utf-8?B?R2VzQjJFaWNyd2VvUSsrL0VhOEI2SnpiNHlrZ0U3Sys0V29hZk8rNEJtdmJw?=
 =?utf-8?B?NHFzQm91dklrZWZKczA2emt1VFV0Y205SENzMThWV2xJOFZVdDNqdndvb1dz?=
 =?utf-8?B?QlFtdHBybVRPd2daZFp3Z3I0cWRQYU9GenAwQXNnRXhBMjc1QlN5MU1pZ01Y?=
 =?utf-8?B?cVBIVlJ4QzVYcVBUNDBCZnI0d1lOTHpxT2tCTlRUeXNQcEQ5N1M5bFVPK25l?=
 =?utf-8?B?RExISDhEcDdqSmh1aEZUSXZWSG53NllNQTBoL1Z2S1U2d2dLUmN4RmV3RkhU?=
 =?utf-8?B?dnVRc2V4Y29SclhxNzhqN2Z0M1ltZkhDcFQ0TkRLVS8wVXRPZU1HUlpoMml6?=
 =?utf-8?B?M3ZxZExkeVRxNjhmY3VJc1FRMHdyTUJCM3RWQXhvSk9qTktmOGxZRFM4M0Jo?=
 =?utf-8?B?Z3k4VTEvR2dMc2hWT1JXMlBlYitSMkNHbmtMZFFvZWRTN1R3YUR3Nld6YUFK?=
 =?utf-8?B?NG05TGgyVksrS1dERUQrVFMvd0hPL3ArcS9jcSs0eEtoZFgzU01wZlhCdDJU?=
 =?utf-8?B?Y245Unl3T0UwQjlGYWlRSmpNUFJxU3pnQnR2UGk4eC92dmpzOE53bmpRWHNQ?=
 =?utf-8?B?U0p1c2xTR05lWkkzVERRZDVVNmpMM0t0QzlqcldoK3ZWallUVHpwTUU3WUZk?=
 =?utf-8?B?dnZXUnFwdW9PS3VlZUpiOWhyVHJXWS90UTBuN3NMRnhYTzk2VFIrb3djcDlJ?=
 =?utf-8?B?cHh4V1AxNU5VL1F5WCtIY0hqQWY2ZTc3U1Bxd29WWW16b2RNVlRPRGNBVU9j?=
 =?utf-8?B?dVN5YlZDQ21heEhQZ2VuODZzWlA1b2RORk8rdkRWUitReWEvVnExRWZ4c1k1?=
 =?utf-8?B?U1ZjVnJrTWl6QnFlb2RmbzdhRVZJZjhPdk12MGN6dm1OZ3N0ZGd6cnNGSm9I?=
 =?utf-8?B?aThOMmxxMSs1aXBSMUJaQ0llSXpkeEoyQzNScWhGZVEwK2dFMkwxdTU4Q254?=
 =?utf-8?B?SjdUR0tSRENDZVBxL21CdGJUbjFkWkpLcHlGMU12R0MzbzViRUpYbytQYzhF?=
 =?utf-8?B?TnJVVHBSWnVyMUFmREtqKzJDc1V4dS9jVUQrR3QrYURJWm5Bc09ITlN2NHFp?=
 =?utf-8?B?WFB1UmhJVVJydllvL1owRXIxcDZyTVVqTjU5SXdiNjNqSWxsSmozMXBVY0tL?=
 =?utf-8?B?ZEQ2QzNaTG1sb2VFckdtaTZBK3VnVHdOM1pBa3JrUVEza0hmSW5GWVVISmdx?=
 =?utf-8?B?WFRWWnJhL0N3TmFzOUtBdDdqUlhXaXd0b3VhMnFzdVlaUWNGSEF0Y1ZNUENi?=
 =?utf-8?B?U0hJZ3U0ZXpQV2tzZHgvME9heGU4SUZvRjlHbldWWW9RY21oRmUwWUpPNCsx?=
 =?utf-8?B?cGUzSWZjTkpiL0tiMWJFdUpmdVJqRlg2UkFOcmR1VkttY0hmOFEyVStiY1V4?=
 =?utf-8?B?cFIvTEZ4QTg0Q2hSTDJOSWJqSDB6UTc2czZHeVlpdnR0TTgzaXBsU0YzbW1q?=
 =?utf-8?B?TG15d3pJM0djaFdXQ1czWE9KemVwOCsyM3NLZ1cyYS9GMi8xbnp0SXRSOHRY?=
 =?utf-8?B?MUlCOEkvc3liMmE5L0ptcWJXSGYwVm4rbVlqb0ZXREdGV2R6SnVtRW9QVktP?=
 =?utf-8?B?R2x6M20xNHJRbFBOcmpuK2ZwUnl4MG5vVldsbVdBZ1MvcFBqeHhrZVJXNEZs?=
 =?utf-8?B?akpHTGphS1I2c3kwaXdrd3NMbjhIRlJVMnJIblA5OUxvcW9hc2kyeEMyMk14?=
 =?utf-8?B?RCtxUFRHVmR1YVNtU2k1dGx5eGNWL1RqNnZzRHpCM1BLQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnBYTnNmdzJDOUtBRGtjQVlDZVFPTndueTVVeklkZEJzaVNzY2xuUUpiVHZK?=
 =?utf-8?B?U2lZWklFcHRGSEl5c1BNMFB4WFBnbko1bWo5UHN5QS9oTGN1RmplcUNYS2F4?=
 =?utf-8?B?ejRybjl6V29JN0pyQUl5WVdnTzJmQUMxOWI0UEhtSERVLzl3cFVlOS91WldO?=
 =?utf-8?B?QTEzajVyN1lQWDFEN2xON2VwRkIzdnJvNVU2eDVTd2pqUGdzYWZuMWk4N09J?=
 =?utf-8?B?THNuWXQrWHFBMUNNMDZod28wZ0Z4VTl5NUQxU2dHT0V4aGl2ekRzbzVoSXI3?=
 =?utf-8?B?bXVzMW1oUUFmTHQ0SnhvbnJsWS9STENWcDJvanEyNWo0V1dVTlhlcXBoS2pz?=
 =?utf-8?B?dkh5VVZ2Ti9hd0krZGU2UStxM2pzRXI3MkcxOTZIMmJSQi9NZ3FXejRJQi84?=
 =?utf-8?B?cDRMVk55K1JIWDJGZEU0VVlqUDcrbHlKMmNKU055OWZVcHpxSDNiWksySmVV?=
 =?utf-8?B?Uk5CcjlvZ3Rlek5POUhTaWs4U1hZekJWWnpaN3RHalRwNldEa25wREg0c1Yv?=
 =?utf-8?B?cDlTaTNEZTZ3bUtNbS80YWw0a2FMK2k3bjhvWVl3VXQ4c3Nxa0hJcGRiNE02?=
 =?utf-8?B?aUs5L3NYT2puWS8xWFNocEo2SExwaEJiSWJPcEJ1UlQzQXlhVHJVNU5pcExv?=
 =?utf-8?B?QUdRd1VaSFBGcFc0ajY3WFh1ZTVUcC84dVo5S0FsUmdCWi9jWjhza2krNm5G?=
 =?utf-8?B?NFFtZWp1em5ZbXJCSWtjUDI5T3pseGVsZ3FTdm1MS04xeVpRbG4vZjBRZWM0?=
 =?utf-8?B?UDdKdlI3L0lpd2NWd2MzUGl3Yjh3MHlBcHJMV1BQbWNiL2VvSEVYbzlicWE5?=
 =?utf-8?B?Z0w2Mnk5ZDJnMGlNYVBhbkRzZGNML1JjV3drMEx0SGtaQXZNT3ZBZnRJVENK?=
 =?utf-8?B?NWp2ZEZ6QjJJWTByc1VIRFd4N0RraC9UdnYvTzk5Q3duZDNSZFVabDNYWmdT?=
 =?utf-8?B?ZXUyRmZGWGJ0TU9CazFkVUY1bCs4SFJJUnRMYXlINnFOVUFuRER0MGcwVDd0?=
 =?utf-8?B?RUUwTjlubGlhMDhDc0wxL2VMUkExNFpSUThCb3VzNE1TNTFBeFg3Wm5zeEt0?=
 =?utf-8?B?VWp4b0Z5QXBBRDZMVlptc2h0KzZZU1hCTzI2WG9JalVXdDJSMHkrTnVqMW42?=
 =?utf-8?B?WWxUdTVQOWpEOE9VWnpnSXBNbnFOT1kreWhROUprNCt5MFhhSTMxbWNYWURD?=
 =?utf-8?B?NHJVd1dWQk1XcGJ4b2t3b2tYYU1iQjBFczk1RU5KM0t3cjNPQ0JvNDdZYzFO?=
 =?utf-8?B?TjlLaTdrc0tHd2h0aXhQYnNycHRCcXRJRWdYYndOb0IvZFA0SVA1cXJ3R3BB?=
 =?utf-8?B?Y0R2ZzRyUXhwaURXYTAvZUFQT3ZvVzFNdE0wWGp4enRRRGdtUlpwL3JkUnps?=
 =?utf-8?B?U2g0dkQ0NXNTZHFqeFFxTHhEZ21YWGU0UGpabkhFQ082OVl3b09xTjRIVDB2?=
 =?utf-8?B?TUhyYS9xenVnZU1mT1hHTjF2Z2xpNFpyYktxOGwzemxjb2FjSW55eUhxMkpT?=
 =?utf-8?B?NjVVNUxZaWUxK0JuN0pUdjZHaFBERTJycjdueEZqWlFseGg4V2E4WGpiRGVx?=
 =?utf-8?B?dUFxYm5NcXkyVnd2MUpjMHU3WlFVM0JkNzRuRk1wOUdsV0UzWjhhN2NHS0Jx?=
 =?utf-8?B?M3ZEQjhrcEFNOGg2UCtoOUdMWVVtcjR3TDZqN2tVekVsaCs0R3RzeE1FU1Zy?=
 =?utf-8?B?d1JWcFdkMmZOYjM2Y2tVL0c4YlJBYUtaNW1JVUxoYzFlYmlLbnhaaG1UOHkx?=
 =?utf-8?B?YWcwdmNxd2d4RjZ4YlZiUlVaaFM1c0c2TUtRSmNvdWZIZUFKS1NQcVdZazVK?=
 =?utf-8?B?ZEljT2hPK3MwSG5YNXRiTzljREw0bHVvWHYyREhMemdRVmZla0E3OEVRcEt5?=
 =?utf-8?B?Z2M4czd2c0ZxaklXNU9NQjVSc3pKY2dwMXNoVFFIdkR4Z3FCbXBCVENoNzhl?=
 =?utf-8?B?c1dYaXhBZWNOcUxjbkk1c0J1eXhGcWdwYkYxYVFWcEtDWnpZc0x1Snd3cUdI?=
 =?utf-8?B?MnhZV0QvTDczK1MzMVhNZURBYnB2WHF0RDN4cTJmWGs2eWlaUVhvWlQ2aTRk?=
 =?utf-8?B?NGhqc2kxNHZUaWkzK0RwYTN1a01pNk1vVE1oSTRMRkM3djhRMVBJMmd3NnZE?=
 =?utf-8?Q?kH82F41Jr+BZEeeMPz4PKZna0?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bb06dc-137f-42f6-39c6-08dc960ddadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 18:29:03.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR89X/0vOxO6ndNSGl85LX2S2GPg8KdMNSKqMeIWW6Viv6YQBD7CYsv9pRMpwINEgZQnRVVjuQ/l1BJBMl4W1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3553

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29uc3RhbnRpbiBUYXJh
bm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI2
LCAyMDI0IDI6MjAgUE0NCj4gVG86IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtw
bHVtYmVyLm9yZz47IExlb24gUm9tYW5vdnNreQ0KPiA8bGVvbkBrZXJuZWwub3JnPjsgSGFpeWFu
ZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IEtvbnN0YW50aW4gVGFyYW5v
diA8a290YXJhbm92QGxpbnV4Lm1pY3Jvc29mdC5jb20+OyBXZWkgSHUNCj4gPHdlaEBtaWNyb3Nv
ZnQuY29tPjsgc2hhcm1hYWpheUBtaWNyb3NvZnQuY29tOyBMb25nIExpDQo+IDxsb25nbGlAbWlj
cm9zb2Z0LmNvbT47IGpnZ0B6aWVwZS5jYTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBuZXRkZXYgPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggcmRtYS1uZXh0IDEvMV0gUkRNQS9tYW5hX2liOiBTZXQgY29ycmVjdCBkZXZpY2UgaW50
bw0KPiBpYg0KPiANCj4gPiA+ID4gPiBPbiBXZWQsIEp1biAyNiwgMjAyNCBhdCAwOTowNTowNUFN
ICswMDAwLCBLb25zdGFudGluIFRhcmFub3YNCj4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gV2hl
biBtYy0+cG9ydHNbMF0gaXMgbm90IHNsYXZlLCB1c2UgaXQgaW4gdGhlIHNldF9uZXRkZXYuDQo+
ID4gPiA+ID4gPiA+ID4gV2hlbiBtYW5hIGlzIHVzZWQgaW4gbmV0dnNjLCB0aGUgc3RvcmVkIG5l
dCBkZXZpY2VzIGluIG1hbmENCj4gPiA+ID4gPiA+ID4gPiBhcmUgc2xhdmVzIGFuZCBHSURzIHNo
b3VsZCBiZSB0YWtlbiBmcm9tIHRoZWlyIG1hc3Rlcg0KPiBkZXZpY2VzLg0KPiA+ID4gPiA+ID4g
PiA+IEluIHRoZSBiYXJlbWV0YWwgY2FzZSwgdGhlIG1jLT5wb3J0cyBkZXZpY2VzIHdpbGwgbm90
IGJlDQo+IHNsYXZlcy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gSSB3b25kZXIsIHdo
eSBkbyB5b3UgaGF2ZSAiLi4uIHwgSUZGX1NMQVZFIiBpbg0KPiA+ID4gPiA+ID4gPiBfX25ldHZz
Y192Zl9zZXR1cCgpIGluIGEgZmlyc3QgcGxhY2U/IElzbid0IElGRl9TTEFWRSBpcw0KPiBzdXBw
b3NlZCB0bw0KPiA+IGJlIHNldCBieSBib25kIGRyaXZlcj8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGd1ZXNzIGl0IGlzIGp1c3QgYSB2YWxpZCB1c2Ugb2YgdGhl
IElGRl9TTEFWRSBiaXQuIEluIHRoZQ0KPiBib25kDQo+ID4gPiA+ID4gPiBjYXNlIGl0IGlzIGFs
c28gc2V0IGFzIGEgQk9ORCBuZXRkZXYuIFRoZSBJRkZfU0xBVkUgaGVscHMgdG8NCj4gc2hvdw0K
PiA+IHVzZXJzIHRoYXQgYW5vdGhlciBtYXN0ZXINCj4gPiA+ID4gPiA+IG5ldGRldiBzaG91bGQg
YmUgdXNlZCBmb3IgbmV0d29ya2luZy4gQnV0IEkgYW0gbm90IGFuIGV4cGVydCBpbg0KPiA+IG5l
dHZzYy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSB0aGluZyBpcyB0aGF0IG5ldHZzYyBpcyB2
aXJ0dWFsIGRldmljZSBsaWtlIG1hbnkgb3RoZXJzLCBidXQNCj4gPiA+ID4gPiBpdCBpcyB0aGUg
b25seSBvbmUgd2hvIHVzZXMgSUZGX1NMQVZFIGJpdC4gVGhlIGNvbW1lbnQgYXJvdW5kDQo+IHRo
YXQNCj4gPiA+ID4gPiBiaXQgc2F5cyAic2xhdmUgb2YgYSBsb2FkIGJhbGFuY2VyLiIsIHdoaWNo
IGlzIG5vdCB0aGUgY2FzZQ0KPiA+ID4gPiA+IGFjY29yZGluZyB0byB0aGUgSHlwZXItViBkb2N1
bWVudGF0aW9uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWW91IHdpbGwgbmVlZCB0byBnZXQgQWNr
IGZyb20gbmV0ZGV2IG1haW50YWluZXJzIHRvIHJlbHkgb24NCj4gPiA+ID4gPiBJRkZfU0xBVkUg
Yml0IGluIHRoZSB3YXkgeW91IGFyZSByZWx5aW5nIG9uIGl0IG5vdy4NCj4gPiA+ID4NCj4gPiA+
ID4gVGhpcyBpcyB1c2VkIHRvIHRlbGwgdXNlcnNwYWNlIHRvb2xzIHRvIG5vdCBpbnRlcmFjdCBk
aXJlY3RseSB3aXRoDQo+IHRoZSBkZXZpY2UuDQo+ID4gPiA+IEZvciBleGFtcGxlLCBpdCBpcyB1
c2VkIHdoZW4gVkYgaXMgY29ubmVjdGVkIHRvIG5ldHZzYyBkZXZpY2UuDQo+ID4gPiA+IEl0IHBy
ZXZlbnRzIHRoaW5ncyBsaWtlIElQdjYgbG9jYWwgYWRkcmVzcywgYW5kIE5ldHdvcmsgTWFuYWdl
cg0KPiB3b24ndA0KPiA+IG1vZGlmeSBkZXZpY2UuDQo+ID4gPg0KPiA+ID4gWW91IGRlc2NyaWJl
ZCBob3cgaHlwZXItdiB1c2VzIGl0LCBidXQgSSdtIGludGVyZXN0ZWQgdG8gZ2V0DQo+ID4gPiBh
Y2tub3dsZWRnbWVudCB0aGF0IGl0IGlzIGEgdmFsaWQgdXNlIGNhc2UgZm9yIElGRl9TTEFWRSwg
ZGVzcGl0ZQ0KPiBzZW50ZW5jZQ0KPiA+IHdyaXR0ZW4gaW4gdGhlIGNvbW1lbnQuDQo+ID4NCj4g
PiBUaGVyZSBpcyBubyBkb2N1bWVudGVkIHNlbWFudGljcyBhcm91bmQgYW55IG9mIHRoZSBJRiBm
bGFncywgb25seQ0KPiBoaXN0b3JpY2FsDQo+ID4gcHJlY2VkZW50IHVzZWQgYnkgYm9uZCwgdGVh
bSBhbmQgYnJpZGdlIGRyaXZlcnMuIEluaXRpYWxseSBIeXBlci1WIFZGDQo+IHVzZWQNCj4gPiBi
b25kaW5nIGJ1dCBpdCB3YXMgaW1wb3NzaWJseSBkaWZmaWN1bHQgdG8gbWFrZSB0aGlzIHdvcmsg
YWNyb3NzIGFsbA0KPiB2ZXJzaW9ucyBvZg0KPiA+IExpbnV4LCBzbyB0cmFuc3BhcmVudCBWRiBz
dXBwb3J0IHdhcyBhZGRlZCBpbnN0ZWFkLiBJZGVhbGx5LCB0aGUgVkYNCj4gZGV2aWNlDQo+ID4g
Y291bGQgYmUgaGlkZGVuIGZyb20gdXNlcnNwYWNlIGJ1dCB0aGF0IHJlcXVpcmVkIG1vcmUga2Vy
bmVsDQo+IG1vZGlmaWNhdGlvbnMNCj4gPiB0aGFuIHdvdWxkIGJlIGFjY2VwdGVkLg0KPiANCj4g
VGhhbmtzIFN0ZXBoZW4gZm9yIHRoZSBleHBsYW5hdGlvbiENCj4gDQo+IEkgYW0gYWxzbyBDQ2lu
ZyBIYWl5YW5nLCB3aG8gbWFpbnRhaW5zIEh5cGVyLVYgbmV0dnNjLg0KPiANCg0KWWVzLCBuZXR2
c2Mgc2V0cyB0aGUgSUZGX1NMQVZFIG9uIFZGIGZvciB0aGUgYm9uZGluZy4NCg0KQWNrZWQtYnk6
IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQoNCg==

