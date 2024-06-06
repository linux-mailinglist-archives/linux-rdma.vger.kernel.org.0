Return-Path: <linux-rdma+bounces-2943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD48FE59E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428491C24098
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CAC19580C;
	Thu,  6 Jun 2024 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DQ5v+WIq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2107.outbound.protection.outlook.com [40.107.22.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6B3CF73;
	Thu,  6 Jun 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674154; cv=fail; b=j95SPsATJ/Y2ptTFPSY7uCIECo4rcAk9Ay0zxgTfLxRhhzqaGmrVyhMWmheGqgXPVf8kGBgvG6ofVnrlj3r70pJ+NUEFLV93v+N03GpuFflVmW04Dw4twemilLle6zjFkPMKZmkJI+TmO+XTM/hEuyZgEMixA9U1Iz4XqKYjL2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674154; c=relaxed/simple;
	bh=tpL1cQAKRXcjIRji/G3+bvGss8DKcDa/tdkrX16RQt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHQ5luGJ1mIADo2h/bcW7uT5qZePnM0mK6s/qjB0Ye36D/l2PN1TD7lD8vM+lN7V0O9Kzhl8GrDFRMk3R/NDAmJb5NJWZjmgNA+290DUihGkKOKLPHnBKki/TXroAauCtzkn8EHFfucElVjTfgSk6kuCBTdVVgGKBIUhoQwv+t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DQ5v+WIq; arc=fail smtp.client-ip=40.107.22.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCMZduTx74LFfO5cwBxFmnvaNH/GSjVZQI+fSg4yKgLXcek8Fcomm5cLe9OXuxZwdLlB3A8HzXcqTbri3RVgr5OEd+iiOsHbhiKlXHhhhXmszUXO5YI820WGibCMz7KNF1JkGYCdTeetV1PvYpXDJFMCTxDI1un5ukgbuHJtiweXKRmYi8i7s3mWaSMYS5qfEeC132yqeVPuGA/PYmPP8VQNJi7inq/xh7gixENCDDmz0tVWvBZs5HjoGXpS1yWPg49St0Zd9FDWf5TVJiHn7408NiqaSXW0tYpBW6HHUCm+mnPpkVuyudgfnphYD/9qoC2+nPFAfXrkUmVs72tJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpL1cQAKRXcjIRji/G3+bvGss8DKcDa/tdkrX16RQt4=;
 b=aTNqfbnzOQ17jUsO5p1/2JbOvCUPgwOyGyu1aWhEwTVxFwXa0WbPt+FW0KWOuyYy0YYm+bEVp3LHUXuTDZHNGbeo5xbe4HHOFmhRuKW7mCvLPAQS+vfeaiGZJPBAyy/ZX4NgPXG7fjSAXkY7AQ6R0ZaqzsWWvcP5RwwddmXnDhrwZo2yfS6PN8yoSvaKIrk3fYEha9q1znOyxhJvxJuGsNf7oLyX+EUduwuh/NfraEt/aoDG5J0CcrfukBLgliwyJtEfJt1Gu5/qjh/trGd9DJbloTZWxPJ6ePDH4OOaed21BI6WsDnCn2EgV0hbr+I4BqeU6Y/MMOVX+u67X1BU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpL1cQAKRXcjIRji/G3+bvGss8DKcDa/tdkrX16RQt4=;
 b=DQ5v+WIqsxOxUCpi94cqZ3mnnbAJZrm645rho5I4OCS9kitreylkTY7/i2p9JUTshIsGVz0n3nD3HCR/WxITkiDZtxJFfJNCxPC4V/35Bp/jq/hfvcfrZyMTYTi5marvzPpxCprP5EZCWH4WyG3/ixQuWAwqxPc3KTJPEQlWGig=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DBAPR83MB0390.EURPRD83.prod.outlook.com (2603:10a6:10:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.10; Thu, 6 Jun
 2024 11:42:28 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Thu, 6 Jun 2024
 11:42:28 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for MRs
Thread-Topic: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for
 MRs
Thread-Index: AQHauAabQtRPYaOJY0KNJiBrC+CLLA==
Date: Thu, 6 Jun 2024 11:42:28 +0000
Message-ID:
 <PAXPR83MB0559943EC4B77A5B82C49DB3B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB307116D097353657259A7BB1CEF92@PH7PR21MB3071.namprd21.prod.outlook.com>
 <PAXPR83MB0559158B879C008258BC7B6AB4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240606113931.GH13732@unreal>
In-Reply-To: <20240606113931.GH13732@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=994b28aa-17d9-4803-9cfe-045a07b85d27;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-06T11:41:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DBAPR83MB0390:EE_
x-ms-office365-filtering-correlation-id: 5820df52-1236-4d65-1f80-08dc861dbe6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEhVS0tYNlJlaUlVaXdCREF6YzRMaHdvMGdBTmdPbXRoZStYV01NOGpkenpG?=
 =?utf-8?B?ODRjc0lTajRoaTJwRHNjRjRVNzJuT3dUVVNPNTV4eERFcnRWSEhFUU5vNGx1?=
 =?utf-8?B?VDdFTDR2TGFyOE11aUhic0xVdTFPSmc3UDA2Z0pNREczSnVwS1Z3VmRWalJk?=
 =?utf-8?B?Qk1iZVpwUHJiK0JnRDhRenpLamV5cEUwUFJNZVZ3MzFmOGdId3N6NUhmUkJW?=
 =?utf-8?B?MTZoalozU2dLVVFPZXdSMXU5UE80QVlaL3BJc1lLSGc5UGdiQUVOSzJXZXJv?=
 =?utf-8?B?a3o4Vk9rR21iSlVvd0NtRGNvN2M1OFVYcENla2g5N2dJNFBZRGdLQytmVzVO?=
 =?utf-8?B?d1RWVlJkSk1hcVhKZThrSG5HZHVQQ3RNZ1VSNVdRaHJiVlhWM3VVdVBqMWdS?=
 =?utf-8?B?bU5LKzEyRmloalFZZUIxRFBMOHkveHMyTFVJb2xmNEs1b1NzTkdIbVFrc0ll?=
 =?utf-8?B?Z3RlZWg3alRHU3c0ZU9wT0Y3ZU1ncGI2MU1QTm1wRGdOSWJOcnB2Vzh4S2M0?=
 =?utf-8?B?UlZsRGhmc01Fb09xMHAvUzIrVkJEQjRzbXdldGdUODNYZEMyMjEzVFU5VGwv?=
 =?utf-8?B?bzFSblZLU3MyZ00wY3lGMzVGdUZDaUhBcWtGajNYUFBqTk9DUDBDQVRvTkJ3?=
 =?utf-8?B?WjU5WU42NW5UMVArQWM5M2h5Rm9XcmZLMDlqZk9hNk9JSG8rMHpKOUpmYmp0?=
 =?utf-8?B?MWlqUy9EVHM0TkcrNUZEUVNjbGR4cXVkVmx2emVSTi9CQmJTMndlTDM3Z3d5?=
 =?utf-8?B?R2RLdVl2MGNoek1Tem9ZejBJZ2wzSWVxV09XQVlwQ3R2YVpQTWRFRzFMUVRK?=
 =?utf-8?B?OFU2VTNMN3dGdmlGNUp5cDlyZEw0UVhIMkxBZFU1cjNlaVEwT0RScC9tNzVO?=
 =?utf-8?B?dXEwZ2xhcFpQVDR3b2pOSTVScHM0NEhGbUU5VzdjcitnUHFhL0tGQ0NUTytG?=
 =?utf-8?B?c0dxYVJ6NzZyM3Ixbk9FZUVXSmpIeUZyTkdVcUZ5bm5EY2ZhckxNN1pYKzJ1?=
 =?utf-8?B?dk02R1VieUpFdEh1N1A5SU1FMUVYeGxqblpYcXRDOFBzRC9vWERPNmpJTG40?=
 =?utf-8?B?SGVUZktueVEzcnBmbE9sNktOTUhtREdxcnJFUjQ2MnVzRXhvMFNDdjF3WnR6?=
 =?utf-8?B?a3BSQXZZbWZGenZnM09pbkpORW1qdGtwUzhodkxaYjYyRHM1UVRwek05Y2p6?=
 =?utf-8?B?bnBFcGJyUnNkalY3VHZWLzJiMktHeHg0MTZiY1BoRGo3R2hIaE0yUmg2NnY2?=
 =?utf-8?B?UVFWNnhVbXNES2xvRndNdWxXZmZTYkhqUWFQRE1CdWxXV1ozNFlwbGQxelQw?=
 =?utf-8?B?OGJrRUE5T21TTUZ2WUpyQzkwWmRoaWN3TUFFTE9IdGFDNVNlaVRWcTVyWmpR?=
 =?utf-8?B?MWhyTk15K3NGRnRoMExWZC9GT0c4L2J4akQ5WHVlZEs4bk1PbmlKR21EWFpH?=
 =?utf-8?B?RDdqcXpNZmo2RFhIQTh6ZjI2Umt6MllSbEFjZTFMK2QrYURqZy9nUC84ODBY?=
 =?utf-8?B?VXRRZ0tqSzBYQ3c0ajZ4K01zUWl3eFc1SnlkUElmdFh6M3BtR09tN3UzSVlJ?=
 =?utf-8?B?YXpuSkR4aDJSOG1yU3ZZU01kamV0V2ZLUDhJZFFWWVVJSzBtSHcydGo0dHJS?=
 =?utf-8?B?ZEUyYmpucEJySVBXSjdKYmk0SEVKb20xbkU0NkhFekdndjNxSFFVdVNDUHZ3?=
 =?utf-8?B?TEV1eXN2SHQ1V21raEUzTjdzUW9oOU1TN2NZNm50K2ZQR2ZZMkJ5djRCUXNy?=
 =?utf-8?B?anNyWFB4YXpOMVFwRlp3Tjd0MjlJd284UjBCdmM4ak1xN2d1N1licjhudjBl?=
 =?utf-8?Q?vpUyFuc8+pmZbTpgUm8skriUKLZPEjOHMPGmc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmlTeHNJeEVtZjRTa3RUOHVjemVncVQ0TFFzZ28rMmpsNzNNbnd4ZXZJb2FL?=
 =?utf-8?B?Y0piSklPZ01TOEZFRVRrVHdjZHRyblNQUm03S01GdEtTemlpcGVxSWpTY09z?=
 =?utf-8?B?bi9VTmZ2NUt3bGJSemFhaEE1UmdmM1FWYTgvVnFpYmdOb2ZzMFBKaDJEOVlV?=
 =?utf-8?B?VmE4MFhxczJPcnkrOUYxbHBCTGhQWGRZdzAzTGxsR2FzaHNLVUgzNWdzSW85?=
 =?utf-8?B?Z09SbHg5QnZRSEJ0VllEd3J5QTZyVStWb1k4YmkyQnV0RUJ4ZkRQc0EzR0FH?=
 =?utf-8?B?Z3R6WjRxWFBqOG5ndFMzNnBkMnZ4UnJ1VE9rcHBXeU5BbTBmbW9ReE00ZG5T?=
 =?utf-8?B?YW45cDZaOVluSXNVcGZNbzBiVlZsN2pVQWkwYVcxaWdVSU04cG8xT25SbzRq?=
 =?utf-8?B?VFBkQVBMc2tTNWkrTUZFbXNSbGFqMWQ3Z2QrZURjMmFTNmdSeGp5aUxxRVJI?=
 =?utf-8?B?OWNUc1FRUUpIMVdjaVZXbHh6ZC9oejkraFFtbFZ1ZjQrc092TlhOdUVYUlZF?=
 =?utf-8?B?SVpPbmR3UkxCYTRYQTJPMlZtQTN6MnA1dnFPY2ZOdVJ4aXRHYkJZeGZIakVn?=
 =?utf-8?B?UGJpSkJCUUVGTVBkRkNYNm9kV2pVMWcwazVFWmZBbDZLRzFaaDdiMkxVbmJr?=
 =?utf-8?B?emd1dXRSdjdJby9PWHBsZlJDRjBGRFVCUm1XK3V4cFJxaHpHZkJkVkg1Mk1r?=
 =?utf-8?B?ZFNRblFITUdndU5HNnIrbkNreEtHMWM5Qk9Vbm5iSW9JMXFWckNCNERYSU1i?=
 =?utf-8?B?Z3hxMG9WblhnbWc5UE9Mc1VBSCtHRDQzTWhwbk9EQlcxSkFIQzN5a2ZWQnJz?=
 =?utf-8?B?UStQZkpnTWpkS1FLRTlZRHlVd0R2RC8yeXBJZHR5OEtQM09qVkxhMTluclVH?=
 =?utf-8?B?TE41ZEpoTHFZWGs5VG9rMXR3TUg4elRaUnFEVjRrb0FTeEQ0akxZTkthS0VD?=
 =?utf-8?B?YytpRGpsT2I0eDU5V1ZxZStFK0JVMFRla1dwZVhWOVZqTEsrSmh6TW9xb0lP?=
 =?utf-8?B?UlhWcmxsZUFIVW1nR01oc0lrWWJ4akpucGNPRm5tbVVRRGduc0RrVVNLS2Nm?=
 =?utf-8?B?TENNQTJwanJER1ZEdmdrQ3R1bE8zYU9QUmNBTkdzTUVWMDJlZHFlcUtQNTJC?=
 =?utf-8?B?WXNEY1QyRWhmQnZCMTFsbjdXcjljTlQvWXFQcjVpckVWaWQ5TEJrc1JLSHRn?=
 =?utf-8?B?Tml1YldHZDBFcStkd2czUkk4RkFGZ1pIZHJ3bXpVVVdIdlo4MVJ1dXBVNEVP?=
 =?utf-8?B?VHlUYXlMR0ZDeW9HNmZLTmhuRDNJbDV1eDI4WDBuY2dYL3hnRkpudndwa2RH?=
 =?utf-8?B?SDI2TzBqaVRJOUdDM1ZTRXYrZlhvajViZnNhR0tXRXF5YS9POUphNXp5bFdh?=
 =?utf-8?B?a1R3M3FnR1V6Ym44cEpSU3ZLQlpHZGRLQWxjTDFmTWp0Mm82S3pNa3BpTzVS?=
 =?utf-8?B?WjFzWkVyN1FUMTh1ZXVOcjBESGRLUlhVNnQ5Y3J0NmhScmppSHlYaWx6eVJF?=
 =?utf-8?B?dVNEcmhGZjlKZDBsR2kwUGYzVzUxbXJKei93RWRST2Y3alJGTGU2ZWRmOWlZ?=
 =?utf-8?B?MG92UEFBTE8wQXNIaTNxTHhUK21WVzVSN3ZjalNWOGt3VHN6SDZYTmJsVWtD?=
 =?utf-8?B?dHVhcDlHSU9SS3ErU2ZFOHJZTE00MjdUL2dUVFpIb0IrVHRuS2hLWG1YdVJp?=
 =?utf-8?B?bDZSRlpHUW0rcGZaSUdTN2plQnV1UERXSHVnK1BhVE9YZm5idHQwa242U0li?=
 =?utf-8?B?RWpacmpVQ1NTVTdDTjgrV3ovejl5ejJNTUtXZVpCTlNmdWVXZ0RDTVVBZDlJ?=
 =?utf-8?B?TDY3TFU3dVpVejVtbW45b3hPYUZkRXJBWDBNUlJrVkU2UldxZm82QTFWcUI2?=
 =?utf-8?B?T0V3NVYxSHIzSHBLNWo3bHhUamVZNjhkamNaa0E4Q3NuazZYb3VHSFFQQnVy?=
 =?utf-8?B?aDJvZHE2QVhZV05nd0RhU3JBNkJKUzB4RG4zQkg2SUM0REFUOTFITEpGb0ls?=
 =?utf-8?B?cGxaOWh0UkdiS09vL3FXYm5CU1psK1J1T1RuNGEwUkpXWUlRT2pPZ2RPNmdV?=
 =?utf-8?Q?i7YGWg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5820df52-1236-4d65-1f80-08dc861dbe6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 11:42:28.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59MzHHFph1CFn6ue/cjgVcd0NIO+erTWuilpHRcrrHcLjJxnbPWcKamWaf1DO7bDJzsC8dDSBx5C5TwbGN6FWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR83MB0390

PiA+ID4gPiBJZ25vcmUgb3B0aW9uYWwgaWJfYWNjZXNzX2ZsYWdzIHdoZW4gYW4gTVIgaXMgY3Jl
YXRlZC4NCj4gPiA+DQo+ID4gPiBDYW4geW91IGFkZCBkZXRhaWxzIG9uIHdoeSB0aGlzIGlzIG5l
ZWRlZD8NCj4gPg0KPiA+IERvIHlvdSBtZWFuIHRvIHRoZSBjb21taXQgbWVzc2FnZT8NCj4gPiBJ
ZiB3ZSBkbyBub3QgaWdub3JlIHRoZXNlIG9wdGlvbmFsIGZsYWdzLCB0aGUgcmVnIHVzZXIgbXIg
ZmFpbHMgYmVjYXVzZSB0aGUNCj4gbmV4dCAyIGxpbmVzOg0KPiA+IAlpZiAoYWNjZXNzX2ZsYWdz
ICYgflZBTElEX01SX0ZMQUdTKQ0KPiA+IAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+IA0K
PiBJIHRvb2sgdGhpcyBwYXRjaCBhcyBpcy4NCj4gDQo+IFRoYW5rcw0KDQp0aGFua3MuIEl0IG1h
a2VzIHNlbnNlLg0K

