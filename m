Return-Path: <linux-rdma+bounces-22011-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ye/wAHXhJ2rO3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22011-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 11:48:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5081365E87E
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 11:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=g+Bwg11o;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22011-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22011-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 190FC302304D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E563D669C;
	Tue,  9 Jun 2026 09:40:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020121.outbound.protection.outlook.com [52.101.69.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859123BE174;
	Tue,  9 Jun 2026 09:40:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998037; cv=fail; b=HUXocgS1Lnxyu+35EunPeWeGc0dKdaxD5Z3IC1CWquDg4NGWzrBs6RJQhuyXO4MWrx+GoXM3+Dq1Chll7bLVWTO8kU3Cn8xnAD9FADaRBWDsoTQ4/IDPT5nv905EbMBRJajtDDBGsEJsreRk2lA+fz23wrgv2r15oZdMrS6ERYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998037; c=relaxed/simple;
	bh=w7qMOTWlC6m/YTzlAQmFghkxli2oh211w5pvH83fGgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLBwmJddtCoUaK/CsWxKZEwkl6h1fcbjCoQklx5caEqw+Tl1ooX1Mg+I5ovRzFOpt19EgO/97UE/ZB3J2tshUMH+EuH3QOcBfyNzq1iwXi45tz1ETSgDUaz0kKxTdCEAVk0TWPKQ9z38vHEnMbUVOIR3u6PZ6jn9FEJYedZhm3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=g+Bwg11o; arc=fail smtp.client-ip=52.101.69.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry4IVGCVJvrSDEUPgcXTTJDLJPXabHjgt7SRZfY9GZ1dt6eBCAV2lWbKCLb/QyGIbSH6rCEfE2pteNrY/c7qNor5E+UpUHNE2YcYx6dNjL+kbhnGPc4OE81jRa6M0cPcqHj+L6a+HAC+R3pEL6EzpmSQWueRxGCj3WAFEhAeuRoC9OHsxylkeIw72H/1TqO5GOcGeS808ZKTYG0JfynqTPZ7x+QzJ8ydhWZdVEkqoSMkZ5fY9MI2ASrzLyKG88lNdN5S0fLHOI6B3wr3OaK260/Z3S3av6XYkpVQEp83JgRm/0z08icvl/O3ZZoe69S2k3N2v8nc4kg9VvkYz9K3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7qMOTWlC6m/YTzlAQmFghkxli2oh211w5pvH83fGgk=;
 b=Ox+gwX/pQH8k8+7xVCqxqYKVkR8LgaufxPq7/5foLLu45vzPooFqvXgorlzWOsF457ssAF/Qd+xwZUZsiPd5KVyGFmkhMhba84hUbJIW2iI765iVjl5mh7pEAGJ/rpXSD5ltTqjyfmN8B/0nVeG++S2AZeBuqCRJyNvs7Ix93VrOBs9KtgaUfsfkV/Gy3FM23liwdtOkqeSuE8LcDEzH0YfeJrqdaN59lBKRnpVTzqdv2zHf4Wo3JW/Ym/F4HEZFQRDGLnKhJIll+3ANeyatFF4ZWFw/QLiSU5aiKa5sdbNyZwvSQxl0HRqRT+SqAkPpn71ThwBhwU8qAigKiwgO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7qMOTWlC6m/YTzlAQmFghkxli2oh211w5pvH83fGgk=;
 b=g+Bwg11ospusZFSH0iQ1rogTm2FRNM4Q5M1PqsfM0yWVGiYo4QT453rto566YbyMPcNN6r8/W/zgjwpNU720r8JmV8BpRYJlZwgcSHDnmTpnw2nSGqmzLbEVqGE8dzGIzgzyVlxvLOniiGo3r41habrxBuAWUhcXvchCKmmS9lg=
Received: from PAWPR83MB0984.EURPRD83.prod.outlook.com (2603:10a6:102:4cb::22)
 by GV1PR83MB0729.EURPRD83.prod.outlook.com (2603:10a6:150:207::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.10; Tue, 9 Jun
 2026 09:40:30 +0000
Received: from PAWPR83MB0984.EURPRD83.prod.outlook.com
 ([fe80::3503:1b57:6b00:4866]) by PAWPR83MB0984.EURPRD83.prod.outlook.com
 ([fe80::3503:1b57:6b00:4866%3]) with mapi id 15.21.0113.006; Tue, 9 Jun 2026
 09:40:30 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Topic: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Index: AQHc6EBt7uS/tnwDiEeD83bj4kCXErYvRbqAgAbQK2A=
Date: Tue, 9 Jun 2026 09:40:30 +0000
Message-ID:
 <PAWPR83MB098460109147A819963260A9B41D2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
References: <20260520100656.875006-1-kotaranov@linux.microsoft.com>
 <SA1PR21MB66836572AF65E8A2D147F96DCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB66836572AF65E8A2D147F96DCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b2e4d92-126f-4e0a-b295-cf383dcaff25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-05T01:25:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR83MB0984:EE_|GV1PR83MB0729:EE_
x-ms-office365-filtering-correlation-id: 107fa910-53da-4d3d-afb0-08dec60b2519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /JCVKCmpuMLOWjK1h4vQiU2a7GU35O3CbcICVZdUu51dejEOqYvOiLXRIgP8Rk2WAFsQxtOIy763YeJJxBULlNFkA4sfZJjwCLSvlIHS+318FjhVH+ZmTwoelsk5Nl/hLIxV9MUGGy8MzIO7FV4iYOvheTIRGLICdBHi50osnQGtxa3tZ/8GQ0E4jSG416nDWEWatfTAnLlZ+GqkWGmeiA7QZeTn+3DrRSaSDFr6gvWx7MwPBHxINRG/6EQ5rZUs/1tEELoVwPkH+cjIpSJS1YeaoacQKlMKnF+/WQpzh+AX+6tgoBnvET1KqZBHdFdpxacdZ4+olK/snptDOimBmqQQGZ3c/G/4CPHydkLAZxSI596JpzSnsBkOtgj4wK/HUeSilxTXwkQREYmKE/dWi8whFBg7hAJ/rDR4csdOPIUeRAedIoCvkqhnuUMMlVhPAoidcq+ct8X9+ZxW0lTRCnzbujcyO2IeiL8bNGLDHpDtL50d3JaGP/n9wdPVxvkws1Paqc2HgQQ+xojOPGUQww1bMhBRHM9V4am+VhGtiGMinZI0vY0Tf7X3M4ZtQQGiY5BagTY7P1fc6vaAPz+q21wwaIG8i01edfoXjwE9jUapEEoL5lrCkjtICwxjSfz+HeAZhfWG9qJPeXo4iL8pTdPBn1kzTy1V4FTHAglyUAJMuExGkBtIOYV/VGeRM/0UguUrViFRxLsOsdlyp1kQDu9Zg7xBLpbSyyfbN0WbD5gO49xIuXcFHkwue5cPSMhs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR83MB0984.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjBUeWlHWDhCbmF6b2JGU1BrNHlrMmZFb2xDdmcvWTNEVmd6OU1xS0djdy9K?=
 =?utf-8?B?UkZ3emVlQmFIWnBMb2dra2UzZUorTnpST2lVRCtMQU9sbitSTGVlUndWNHRU?=
 =?utf-8?B?K3ZSN1kydWMxTXJmclBPT2NhcmMwZUtmdDdyb2Roa1pHOWlvOXJkcGtMYTRm?=
 =?utf-8?B?bnFHM1Y4WE1KUzI0Z00ybDYvQmVPNUZFMVZ6VC9GbkUvU0d2TFlVUENYTzZG?=
 =?utf-8?B?aEZJQVltdloycnpsVlI0YnUxSUZhSDVPbEx4QTRhTEVBTmtWVitEdU9wdUpU?=
 =?utf-8?B?VXJ5eVprNFkvQ2YvRWZnS0UybGVIdmNDMTYydFNWVEVhRm1BUExsTFA5ZTQ1?=
 =?utf-8?B?YzNJaFNHNmJwSWQ5QnZvOFkrTGZ4OVhZMW5PbkU0ZStuSEJFbGZmU2EvTllZ?=
 =?utf-8?B?NWM4QVhlQ3cxYzJkSmVYYnV2K1JQMSs1VW1nT2tHTE1NT0dQam9DTjUrQjdS?=
 =?utf-8?B?QU42UlEyWXNLRDNST0dhcDg3V0hjaDg5cG9NY3RsMUdxdERNaXVqNEFlZ2tT?=
 =?utf-8?B?WlNqZGMvNmRHYXFLa21GZFcrbUlUM3NKUE16TXpVYyswbWRpeDFwTWdnemFU?=
 =?utf-8?B?d1grQkptNkw4dGN2S1g1REZQWEJNK0ZrTFVoVVRkTGc0V3ZBdHpzNjRyRXZP?=
 =?utf-8?B?Q2poMHpua1VtVkpacmVIOVZJTVYyWm1wTE5mVXgyZHRlWUhybjI4ZUk4cXZS?=
 =?utf-8?B?WWtHYUlUWUVQaGtmcVBRWFBmUzRlVUdHNkxXNEsxMGRqVW1IMXlNMUJ3a1Ez?=
 =?utf-8?B?Q0VOR09RTE9UUHA0c0FHZ0Z1STVsUDQ4dHQ3MFNxU2ZZQTU3WTlVOExmWGpT?=
 =?utf-8?B?bTBEWjdSZ0lwM29xdUgydE01K3BGeCtoS09paDVuVXJpOHl4TStzWWlCUW02?=
 =?utf-8?B?R1g3Z042NHc2QnZYd0sveG1pU3RMTmwyeHZnbkJVa1B1WFN5bjNIaGRvMFpE?=
 =?utf-8?B?NFdLbkNhc21aMGNKcndqZ0t3aEhPcDRwemh2bFlRallkR1FIUzZlc3RaMFRt?=
 =?utf-8?B?Rld4WWhmVnUwek9yem9lV2lqcWN3YmVZUTJpTVJENGhWN0UvNlRUamQvL3pt?=
 =?utf-8?B?cWJFOHN5Y3RWbG9jV29BZVo1V0thSDRuMHRIZDUyMlhMU0xyZHJNeHM3MUc3?=
 =?utf-8?B?YnJ0QWhGenoyYXYyc2Q3U1lLWVZYaHJLbVkrRmZTVzI2ZFpFN0tzQ2poTGtR?=
 =?utf-8?B?L2phM2dSemlWMENhQWtOdlp4NURialNxTU5YRDVSbW1rOGZGaG80bkJkcE1T?=
 =?utf-8?B?bEtReFZpUHpCS3hyeTNhOTNXTytwUFpIN2RXcExWNFVWd25QblJNZzNFbDNh?=
 =?utf-8?B?Z1RjOS82d2ZRTDNFcDJQSHhCMkJHZGpsQVpJVXZjNkw5eVVoUmpiNXAwMDFv?=
 =?utf-8?B?TW1xdWtUMURqTm05QytJbFQ1SjhkNHdwelEwSGx5bkVQMXlCWC9tK1dhSUV1?=
 =?utf-8?B?Y0JlQ0RScWszWmhqTVUvNE5aSTVNNFRreEhNSGdYTWhHK2hjRFgrcDFoUzVO?=
 =?utf-8?B?S3JwaHpMZGc0Y0tSVlFaZVVNSWU2YzJERWRQVS96WGdVcDBBV0hkeWdod3pI?=
 =?utf-8?B?TUFVV1JhRzlsMGtoL05CTlB1QnZ1R2tPdGNLNEtkZWJ4MXB0OEdsVVFmVW95?=
 =?utf-8?B?WWJVT2pUMHNtNjJvWUVEYUcvNTAyOUhNTHlsYlBYUEg1ZEZmOG51MmkxbEYz?=
 =?utf-8?B?WmhRMWt1SG5YRHNlRldpeHA2dVdMWHgyaUlDSk9XZEtQVmluL2wwK1NudUhj?=
 =?utf-8?B?YVZkNUF1ZEFoMzZCMXNTUWRIRzJBUTVPeHFTektHbEZIa2VBRGlNanc1STVr?=
 =?utf-8?B?ajcwYVpIcWFMUDV3aHlBVkM0UEJmcXZPQTVONTh0S2xUYTBDL01EMWdkMERI?=
 =?utf-8?B?ZmszWDBNZFFLVnpXTlRLcWIvVHkxeVl0OW9tU0VmUzRrN0lIRXFKTUowTmRY?=
 =?utf-8?B?QmxMVlRnZ2dhbFhoaitDdVN2YmJjV01FTnk1cUs0R2drbkhDb3lwaTBLVnVW?=
 =?utf-8?B?VkdYbFh2S3dBWGJEb3orY3VVWDA3dDlpdWhpdmdFb0U3RDlHdktuNGhLdGI0?=
 =?utf-8?B?K1RidUJJMFEvdzZqL0JrWktaOUY5N25hZW1US2xBR1V6eUFTZmx3YlRxakZi?=
 =?utf-8?B?b2RDNWtLU0hudkN2cU9FOUk2QU9HRld5bkZ5Y2dUU0J3V3FvL2JlK0dEMXpL?=
 =?utf-8?Q?46xe2NzyYJfZgM3mV6zfBq7HY7+/CIaFKWZkgwmGfrwX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR83MB0984.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107fa910-53da-4d3d-afb0-08dec60b2519
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 09:40:30.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ArtyiN67kpNZB9wxUsFRzq79LLbsKUBsE4Ft2pg37RaGZ7+4SqhQko0UF5qncF6DQVhhGWn78XYvW8rI17vVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0729
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22011-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,PAWPR83MB0984.EURPRD83.prod.outlook.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5081365E87E

PiA+ICtpbnQgbWFuYV9pYl9nZF9kZXN0cm95X3JuaWNfcXAoc3RydWN0IG1hbmFfaWJfZGV2ICpt
ZGV2LCBzdHJ1Y3QNCj4gPiArbWFuYV9pYl9xcCAqcXApDQo+IA0KPiBUaGUgZnVuY3Rpb24gaXMg
cmVuYW1lZCB0byBfcm5pY18gdG8gYmUgc2hhcmVkIGJldHdlZW4gUkMgYW5kIFVDLCBidXQgIHRo
ZQ0KPiByZXF1ZXN0L3Jlc3BvbnNlIHN0cnVjdHMgYXJlIHN0aWxsIG5hbWVkIF9yY18uIFNob3Vs
ZCB0aGVzZSBiZSAgcmVuYW1lZCB0bw0KPiBfcm5pY18gYXMgd2VsbCBmb3IgY29uc2lzdGVuY3k/
IE9yIGRvZXMgdGhlIGZpcm13YXJlIHVzZSAgdGhlIHNhbWUgZGVzdHJveQ0KPiBjb21tYW5kIGZv
ciBib3RoIFFQIHR5cGVzPw0KDQpTdXJlLCB0aGV5IGNhbiBiZSByZW5hbWVkLiBJbiB0aGUgZmly
bXdhcmUsIGl0IGlzIHN0aWxsIGNhbGxlZCBSQyB0aG91Z2gsIGJ1dCBpdCBjYW4NCmJlIHVzZWQg
Zm9yIGFsbCBRUCB0eXBlcyAoZXZlbiBVRCkuIFNvLCB0aGUgbmFtZSBfcmNfIGlzIGp1c3QgaGlz
dG9yaWNhbC4NCg0KTG9uZywgZG8geW91IHdhbnQgbWUgdG8gcmVuYW1lIGl0Pw0KDQpKYXNvbiwg
Y2FuIHRoZSBwYXRjaCBzZXJpZXMgYWNjZXB0ZWQsIG9yIGRvIEkgbmVlZCB0byBzZW5kIA0KSUJf
VVZFUkJTX0NPUkVfU1VQUE9SVF9ST0JVU1RfVURBVEEgZmlyc3Q/IA0KDQpUaGFua3MNCg0KPiAN
Cj4gPiAgew0KPiA+ICAJc3RydWN0IG1hbmFfcm5pY19kZXN0cm95X3JjX3FwX3Jlc3AgcmVzcCA9
IHswfTsNCj4gPiAgCXN0cnVjdCBtYW5hX3JuaWNfZGVzdHJveV9yY19xcF9yZXEgcmVxID0gezB9
OyBkaWZmIC0tZ2l0DQo=

