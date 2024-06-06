Return-Path: <linux-rdma+bounces-2931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E38FE191
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DE42843B9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26C13D8AE;
	Thu,  6 Jun 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Xu9DU976"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2091.outbound.protection.outlook.com [40.107.103.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FC13D884;
	Thu,  6 Jun 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663780; cv=fail; b=aQDC/mFFB1HYKuPQ4+Xg8CyZPfZnnHSPR+nQVbwy7/wsqUi5lBIDTq+jJoWEsZONf0Ej9hF3q+dagvUJu+sUPdhA95BDOJm7tScTXEZZMFBiSB1V1QG59cxd6pTCo9mF77vS5GflZCeS5OEOcLke4UGhh33rTHKsI4ckb2ZuUX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663780; c=relaxed/simple;
	bh=YfQ6cS87UR+J88rvN4M6VSh6kKtFqPq90fwdmSg3GBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+ilni+5a9+dPU5lUwHTmh/i5Hjnl+BJNv0ldtU42bhPAT/hYDKpGdqJlyKYUvoNs+1h1DTzgti58DIs1wFhPbg7LGU2o5Fp/7Ph6tp+CW9L5c946WJvWaW1G1NYCmcRltlbghh91820SQnaEPNvMwwiJOm3DTCps+peTiBcRj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Xu9DU976; arc=fail smtp.client-ip=40.107.103.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeZBCrRwqheTwVAdxdB4Rwp1X3RKvcQrq7Wn9h8FMh9bSiqwlG6h682kbcRFOsmRR2JuIySdQvj4HORRYEaTn7ONVSODKQsA+AbRMDcVQPHHPQiKyyZ+OpbuGjSM+fT5yvLxg4brQrZb9i2h78+kmx/lgJ5O9x8+b2uWMvYsuqVCDHfNtY+LYlgX0lcAxht/3hhhRD+1XXNbhDZyg7ijA1VU+2x5l5hQG64/9B9uzSX/3M+5Zvk1/b69cDBFX4kaYYxRcEAKGJ7Zc5GRSnkBn0unyqSwtg9JdVJuPfxGRlU2SVizp7ysD70n8WDqIT3rrGAMW+X4DavKFINJwY3F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfQ6cS87UR+J88rvN4M6VSh6kKtFqPq90fwdmSg3GBw=;
 b=Ek4g55zgf5Qgm1DTYHzFmIVVjuf00Vg1CVMO9C8hv2gs+x5pdIugAqla521/fcFZsbGRgJLKc6As2+kV49OsUe5bVg6M+OsALWxxaJPiA6LAe2gjKEF1ijrcpNKIEIQm7Q4v//bO9Lvx2a5FarElmBLyx89WeJ0GAH+ixahmN8mqa+53c0n7BgmvSEBdrhrb+ok73clBV/zPXXboTyjnBpJOC7iBRj8t61nuhOm5k373Y3DQZW1Em2IZsyDx+NE8CzvwEpZh2sHoXCZJfkX4QGPxQL0vMCl6DvkHXtg9RiI/qTgbdB3v2LqU3EHWJGUIPsSlkBG2XKBb3K77iYrB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfQ6cS87UR+J88rvN4M6VSh6kKtFqPq90fwdmSg3GBw=;
 b=Xu9DU976h/9h/RJw4+XUUgXvb98wvFS88c9cvLnawNsVBiqup+Cp414VURNww6P29UVS4Rc4bCfxz5hNZZ+CuFzTcgCEbMIyKz6Nc7gQA7cE8mPZry+kcQshWjn1nGZAUag9YinYZtttnzvsQCEveKLRQuF2Xk2EhVbgNX1qVl0=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by PA1PR83MB0799.EURPRD83.prod.outlook.com (2603:10a6:102:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7; Thu, 6 Jun
 2024 08:49:34 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Thu, 6 Jun 2024
 08:49:34 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHatnNpjWIYJv5iZk27b1TMYgszmLG5xnoAgACkJiA=
Date: Thu, 6 Jun 2024 08:49:33 +0000
Message-ID:
 <PAXPR83MB0559360D3C2E3D0B02E9C059B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307195C7DD870A5716E1CA92CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB307195C7DD870A5716E1CA92CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b9f9122-27a4-4ad5-b04b-3479404d893d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-05T22:23:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|PA1PR83MB0799:EE_
x-ms-office365-filtering-correlation-id: 96c59285-5020-4e2d-3fcb-08dc860596a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTZSellVSjNPL1IyelYwalk3WFFBZ2tCWkgwbWhadjZXczRVdStWT3UvODlV?=
 =?utf-8?B?UGxTRUtvTk4vajFKQ0M4N1NPVFdFbnpONWh5Nk5hd3hmaGZ3d2ZvcUg2YzRx?=
 =?utf-8?B?N1hueDhHQUVVUDZvUHVqZnBmbmxaLzAyMTVjb0N3UGNlangvNkZMSG1DTll1?=
 =?utf-8?B?cGJmSStLL1paM2xDRFBFUjRaSW92aXQ3c3pQcEtrTEQwR0lETDJ0QnRDSE11?=
 =?utf-8?B?S3JhOHRTa3BhNnRDdjJuaTdINDZnY0lFTUU2ODVGdzd0MzYwODkvM2VrV1FV?=
 =?utf-8?B?Z3hZVWFMcndTSUdkbmlpczZ1eGtZcGoxVGpVbSsyMDJVeWdsd1pYY0dPTTYv?=
 =?utf-8?B?ZTJJcExmckJVVW4veXdBYlRtYS8zNWFCZkpvTk52eEZNK2Rxb2JDa0VXYTNw?=
 =?utf-8?B?cGU1aFk1emhGOFpFVjBVaHlpZCs3V3lBVnk4eVlrWXVwY2lsQjFSbVlBS1ZN?=
 =?utf-8?B?aFNpVWlGS3VtT1YwUjZnVEMrRzFqQmszeHl5bVdFSWU0Q0l1bXFrK01tZnVv?=
 =?utf-8?B?clJEZExSR0Q2SmZDdWtTZVFBNmpDRy8wMnNBdEYrdjV3M0JMenVVSU1GZ0xV?=
 =?utf-8?B?YncwTWhTdDBXcmVtVHFKSndIWHZyeEF3d2NXL0hQWFA1V2FpSUJLaDVkaGhv?=
 =?utf-8?B?Q2s4cHRnVXBsL0s2UHF0NElwdS91L2ZuNHdoYzJFTXpnaG1DcXZRS0lzR1l6?=
 =?utf-8?B?U013NEZJSnM2Q1huVkFCaXBQWElQQU1iTC8ySTlGSnkwQ21kR0lGQXVwMFZy?=
 =?utf-8?B?aVpxV0JSM3lMQjRWZER1MnpGU2VHOGtVQ2Zvb2tsellaTHRKS2pxU2ZFdzRw?=
 =?utf-8?B?SnVRZTFoV0syZjk2a3J5dFBEaXRRbXAzTVU1ZENvYU91Qkl3UEd1YUJGcm05?=
 =?utf-8?B?ZXc1SGJQNVRHUmo4SDdtL24xNCt2Y2tqQnZOTVcxUzE5aTFVMzFQOTA4Wk9J?=
 =?utf-8?B?bStkQTRHVVloeXhrWmd0cEw4aW01RDUvcFZHQzYxWndtK2lHRlRxY0UyWXAx?=
 =?utf-8?B?K0RBSThIcXZ0NHExd201UHhBTWRzU0FWZXpzdVQ4YWRGNjRrUDAwOE43MUVL?=
 =?utf-8?B?NmJ1b1ZVMzMxV0cwSW5XckxGdnMvSUs1c05Dazd0aU1rZUs4eTNDYXVRWmhQ?=
 =?utf-8?B?c2RiUitZNjVZSkxiOURjOFhDVktIaGw0Sld4NkdROEtpRi9PcGdzdXNlUnpG?=
 =?utf-8?B?VFpQYnF5RmF2UkRtOTRQUVpDRXpTdFhVdEJyUUNSejFSTXROcGc1V2R2OW5S?=
 =?utf-8?B?YlpwMkVCZnQ0T2p1Z2FaaFhsYkJiaFJkSWlGYitmaTk2TTlZZ2xHMDladDQ4?=
 =?utf-8?B?YmNtNjBCTU5mUFBJdlNQN2VkM0dFUVExZHA1ZmVmV3QwbDJPUTRTR2txOVNa?=
 =?utf-8?B?a0h3dVNMOEtERXJESHcyTlJ4R0dpUFV3OUV0V1FaSEJhYUhiaUVKbVhMczJV?=
 =?utf-8?B?RkxLODM0NFhIRDVGWFdBWmN3ZXhRNkdGL1dIMjJOV3Z5bVFRcm41cnEyeXBU?=
 =?utf-8?B?RCtiVXVZT25aMElIVmE4bnpoOVNQaDByVkpLVmNJRzhUU0k4UmVjdGdnU3c3?=
 =?utf-8?B?NTVQV1ZQOHpWZUFPbjc3WW0rS05iR3JLZ01XZUNkTExJaXFhZGRjVnVPckkz?=
 =?utf-8?B?cCtBRGFVVm8rcXpGYnhQK05mVE42N2paVHJ1NnVRYjFmdWthcTQ5bkVWUDdV?=
 =?utf-8?B?Rm9CLzYzNmhpallMRWdORmJ6S0NRQTRYWEVrVUFJdHVzQ0c2TFFUME9qVHMv?=
 =?utf-8?B?Tk13cHVOU0xpMHN0L1hKZWpFN1hsVDNkWkhCbkQ4RVNGNllBaDJEQVNBUkF0?=
 =?utf-8?Q?amuyg/o4TpT+11DxZw8gz8JFR+8X5o0Hn4x9c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWk4M3hPTFl6NEx3MGU5MUZ4c0RFZUJXZE5obFVMeXBDOFFyZmxFQ3NIbEdk?=
 =?utf-8?B?TDhBdnBwVU1XWlYyRndMN1VzVjhHSStOeWVzakprZjZOeTZLSjArb1ZDdktN?=
 =?utf-8?B?RFV4RzVrV2MxYktWbW5lb1BNSkxPTGczMVIvb0loVVg0TS84TW1rUytoQzA5?=
 =?utf-8?B?bGJEajRPVUhZTkMxRU9vank0ZHIzaG9sR1NCRVN3Q09yM1oyTndHblRQTW10?=
 =?utf-8?B?aHl0emdMRGFicGFXbkdZeStCeFNtOXlPa2ZtS21yZExPZVkyaGFvcXJmRjlW?=
 =?utf-8?B?eWYwZ2NFYlk3Qm5oZnUvVDZRQlVRa0lMUzRlMktUODJ1WE10OWp4eDN4NGpF?=
 =?utf-8?B?ZWVVaXMwYWZIY0RnSTg1TkhGYmVGT2VSbzlLdUQ2ZTgzQzl1QnpteS9uMXQ1?=
 =?utf-8?B?Y2tGcm9uZ2Q1OGkxUUQwdkQ0QzJxZ1ZkZDFzN3hMRGNCa3hzMklBTDBYSVA1?=
 =?utf-8?B?elV4ODhqNUpQM3hzYWd5Tmdkc0t5R0l0cFM2M1cxamRwdG1ZRzMyWWErQ2ZH?=
 =?utf-8?B?eHRidWwrOTJCaUdyTVdINjFnOHM1cExGS0tJdzJWQUJkMHlyYTFFSm81L2Yx?=
 =?utf-8?B?dUNub01icjFqYWRhOGVjWjluaGxSR1BTdmpNS0Q5bVN4aUdHeVBLckJzY1VN?=
 =?utf-8?B?QlFLdTcyVVNRclRPbDJwMDJMbC9weld6UWd3WlJCS3hZNnUzOHZKK3RrOGNJ?=
 =?utf-8?B?aFIxMWc1ZXdUQ0hWSmVlRXgyM2JFZHc5VW9EQXNQY0hkeE54eU5USlhQMGJT?=
 =?utf-8?B?M2VndzIvSjMrUERyazVnajFKeEUvZVFFOHYwZXlIY1pVYWhZUGpGMkVUZ0JN?=
 =?utf-8?B?aU1XckNYTzdUZTZuSlJ2dmZENkFKclpEOWMvZjJwYVpBdlhxcTI0RjZDZW9R?=
 =?utf-8?B?VWNRTkQwdC85dGZ3SEp2ODJma3Z5NDZPUzZoR3dYTDJ3TS9KWFBYVXY2eVpP?=
 =?utf-8?B?Z09lOUMyQ2pZRXVyMFlQUlhSUTRqNjFXVDM0V29PS1hKcFRlSXJHK1JJUFM5?=
 =?utf-8?B?SjRnem5xa2Fybm1SUWlsNkVXZ0ZjbWJ5cFp2dEVoOGs0eEN3aklJNzlxQXFQ?=
 =?utf-8?B?RnVCbCtsdHFZSCt3ODIxRFJMeVgxWml5Zk5HKy9wTUI5c1hYVW84b0pBeW9r?=
 =?utf-8?B?K3FGZ214MlA2L1BmTDFGTGQ1SExsbGhPVjVpWjRiYVNpVk1DdVNiZ1ZmaWVY?=
 =?utf-8?B?NWhuUktHdVFxbE9jYUNFSUlmRHFKc1UvSWdSU1FtcWlwTDZNWUxiY3pYYThL?=
 =?utf-8?B?OWRPREZQQis5Z3dBUVZjYmxsbUo3bXlVZWhOTkxVZmp1VysyOW1CaTJjRVJ1?=
 =?utf-8?B?dlBZVTFuSkhXYVlxUzVGK0ovejFNYk5sc1ZDT0U3dkFQRURzSEVVUUpXN290?=
 =?utf-8?B?dzh0VWc5V0dKU2ptVVJrOEo2MHBZWkFoV252dDFkRUlvOEJGeWFyQ2hjd0hJ?=
 =?utf-8?B?dDZSTm5qdTFTbkNQaW9ubmdsRWpQd1pLMTZHdW8yTnZqdC9oVEdsQWx1UG1i?=
 =?utf-8?B?YmlrQlB2dmprVExlbGo4THZWV2V3VHJVNDhPTWpLTFZIM1ZMbGZVZE5iTGxx?=
 =?utf-8?B?blRDUlFvNjJWZktXYjQyUm1LZks4MFhreXFSNUlsSm0wRy8rM2tPUWVmQTRv?=
 =?utf-8?B?VWRRSGFFQmlOWHdLcnRPdFBiQUhRRkI4Wlo2Tk51RXhWTnlQeEdBQ29kbTli?=
 =?utf-8?B?cG5lMjc0Z1RlSW9TTkpMeXh6OERva0pDaHp6elNTRi9PcndLa25jU2xsenU0?=
 =?utf-8?B?cFR0MkRPTGl2MW1qVG40TitFY3JFUGZiSmpmV1IrZEVHczBiR1BLZDBLZW1r?=
 =?utf-8?B?Y2dFeTlNY1BzR085RXVBSzR3UXpnaTZNVlNtc3FHajAwSzZicEcvVXhGYXIv?=
 =?utf-8?B?dzAwU3FjSVkzZnVpUVo2bS8zMGxqSUlSbkpyYVk5czgySjJtWGpwYnRaMzk4?=
 =?utf-8?B?bzdXTG43UDhLOGlRMUl6aklIcVdKQTYzWEhNSXVSeTF0RkZWVSs5N3JyQnJN?=
 =?utf-8?B?SUh6REI3cThZQnFrdFpSM25ETjI0Sit5TG1oeHpRZGlTVkpVYy92Q0wxMUpp?=
 =?utf-8?Q?Sf+3b7?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c59285-5020-4e2d-3fcb-08dc860596a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:49:33.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTuFR/OJ53clP/4HOGZ15F+EcUinccCtlqJ1nVcIBImU0eKWpBqCqAsBf1PCGbfjP92W3QDFsTLb1yOfhCtbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0799

PiA+ICsNCj4gPiArCXN3aXRjaCAoZXZlbnQtPnR5cGUpIHsNCj4gPiArCWNhc2UgR0RNQV9FUUVf
Uk5JQ19RUF9GQVRBTDoNCj4gPiArCQlxcG4gPSBldmVudC0+ZGV0YWlsc1swXTsNCj4gPiArCQl4
YV9sb2NrX2lycXNhdmUoJm1kZXYtPnFwX3RhYmxlX3JxLCBmbGFnKTsNCj4gPiArCQlxcCA9IHhh
X2xvYWQoJm1kZXYtPnFwX3RhYmxlX3JxLCBxcG4pOw0KPiA+ICsJCWlmIChxcCkNCj4gPiArCQkJ
cmVmY291bnRfaW5jKCZxcC0+cmVmY291bnQpOw0KPiANCj4gDQo+IE1vdmUgdGhpcyB0byBhZnRl
ciBjaGVja2luZyBmb3IgImlmICghcXApIGJyZWFrIi4NCg0KVGhlbiB3ZSBjYW4gaGF2ZSBhIHJh
Y2UgY29uZGl0aW9uLg0KSW1hZ2luZSB0aGF0IEVRRSBjYW1lIHdoZW4gd2UgdHJpZWQgdG8gZGVz
dHJveSBRUCBhbmQgdGhlIGdvdCB0aGUgZm9sbG93aW5nIGV4ZWN1dGlvbiBvcmRlcjoNCiAgICAg
ICAgICAgRVFFICAgICAgICAgICAgIHwgICAgICAgIFFQIGRlc3Ryb3kNCjEgICAgeGFfbG9jayAg
ICAgICAgICAgIHwNCjIgICAgcXAgPSB4YV9sb2FkICAgfA0KMyAgICB4YV91bmxvY2sgICAgICAg
fA0KNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICB4YV9lcmFzZV9pcnEN
CjUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgcmVmY291bnRfZGVjDQo2
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgIGNvbXBsZXRlDQo3ICByZWZj
b3VudF9pbmMgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8LS0tLS0tLS0gQlVHDQoNCj4gDQo+ID4gKwkJeGFfdW5sb2NrX2lycXJlc3RvcmUo
Jm1kZXYtPnFwX3RhYmxlX3JxLCBmbGFnKTsNCj4gPiArCQlpZiAoIXFwKQ0KPiA+ICsJCQlicmVh
azsNCj4gPiArCQlpZiAocXAtPmlicXAuZXZlbnRfaGFuZGxlcikgew0KPiA+ICsJCQlldi5kZXZp
Y2UgPSBxcC0+aWJxcC5kZXZpY2U7DQo+ID4gKwkJCWV2LmVsZW1lbnQucXAgPSAmcXAtPmlicXA7
DQo+ID4gKwkJCWV2LmV2ZW50ID0gSUJfRVZFTlRfUVBfRkFUQUw7DQo+ID4gKwkJCXFwLT5pYnFw
LmV2ZW50X2hhbmRsZXIoJmV2LCBxcC0+aWJxcC5xcF9jb250ZXh0KTsNCj4gPiArCQl9DQo+ID4g
KwkJaWYgKHJlZmNvdW50X2RlY19hbmRfdGVzdCgmcXAtPnJlZmNvdW50KSkNCj4gPiArCQkJY29t
cGxldGUoJnFwLT5mcmVlKTsNCj4gPiArCQlicmVhazsNCg0KPiBTdHJhbmdlIGxvZ2ljLiBXaHkg
bm90IGRvOg0KPiBpZiAoIXJlZmNvdW50X2RlY19hbmRfdGVzdCgmcXAtPnJlZmNvdW50KSkNCj4g
CXdhaXRfZm9yX2NvbXBsZXRpb24oJnFwLT5mcmVlKTsNCj4gDQoNCkl0IG1pZ2h0IHdvcmssIGJ1
dCB0aGUgbG9naWMgd2lsbCBiZSBldmVuIHN0cmFuZ2VyIGFuZCBpdCB3aWxsIHByZXZlbnQgc29t
ZSBkZWJ1Z2dpbmcuDQpXaXRoIHRoZSBwcm9wb3NlZCBjaGFuZ2UsIHFwLT5mcmVlIG1heSBub3Qg
YmUgY29tcGxldGVkIGV2ZW4gdGhvdWdoIHRoZSBjb3VudGVyIGlzIDAuDQpBcyBhIHJlc3VsdCwg
dGhlIGNoYW5nZSBtYWtlcyBhbiBpbmNvcnJlY3Qgc3RhdGUgdG8gYmUgYW4gZXhwZWN0ZWQgc3Rh
dGUsIHRoZXJlYnkgbWFraW5nIGJ1Z3Mgd2l0aCB0aGF0IHNpZGUgZWZmZWN0IHVuZGV0ZWN0YWJs
ZS4NCkUuZy4sIHdlIGhhdmUgYSBidWcgInVzZSBhZnRlciBmcmVlIiBhbmQgdGhlbiB3ZSB0cnkg
dG8gdHJhY2Ugd2hldGhlciBxcCB3YXMgaW4gdXNlLg0KUGx1cywgaXQgaXMgYSBnb29kIHByYWN0
aWNlIGRlaW5pdCBldmVyeXRoaW5nIHRoYXQgd2FzIGluaXRlZC4gV2l0aCB0aGUgcHJvcG9zZWQg
Y2hhbmdlIGl0IGlzIHZpb2xhdGVkLg0KDQo=

