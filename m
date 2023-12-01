Return-Path: <linux-rdma+bounces-178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515B800EC2
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3772281B2F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70D4AF8F;
	Fri,  1 Dec 2023 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="odlqImFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B459194
	for <linux-rdma@vger.kernel.org>; Fri,  1 Dec 2023 07:44:16 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1FdP0r015577;
	Fri, 1 Dec 2023 15:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZCi7OxdtWD0QPEVDhpBPHG3UiuqmF0dce8x6ri2QII0=;
 b=odlqImFjJSIepzPhtSCkQ2yGTR7xFQEDhpN/B+qAfrllaHHWy+B46NWFooQIjms+Hkks
 wsotzuxqZR2uaB5s6RwuxCMG3c3GwLvttdI3Ka48CJ2mUjvNV7UMEG5y3qn+OQxYUR2g
 CVwEiteLJheUjz38UcYdBGxgTWR2FNuT5U71vExMXeVVVon/GWJaRd52gCr76xJSj4ua
 wKjzEQ6Rity+esjl0Bk3L0d+Ux+1Ndmu0SBezlaKe6P3SQgxutSfyc8KPHaOy+iHopfh
 ngU0/hoQqhNPXBS91r2xduo4OFUcYGsJpDZmFbMrTkaRkW5KkL1xIpvM0vNrRRo4ZBLK UQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqjagr46r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 15:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixHtypHBc1mXfFactawl6A5mkVGi/0C3c+YfP078SQSsOfQqISkManzGvGMDwy4IfbbAEWEZTa/0lpRJugDoIZ+Le5OYFbFYPlj/O4fmrKBg4Y7iAOl2u5AVHAWoHS4vktaHmj8SZx6C2j/L8CSclkTsWI9xapZpniNl7z3k9DJ9aU3oy4f9/bU9vS1N6VYmtiJVeG3yw7+ilbYVi1KoLWL7WqQL2ILPzHqxWWrPLsdIiUj33Kd0Ts+lCojtCPyq1bCgBCBBbuwRX2x5e3uoXlNg6MeMxvV1FyADo2EtO8oqUsj6yC31KUTkN10HPnGM+LhpFtmj6BrfqLy7wHAKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCi7OxdtWD0QPEVDhpBPHG3UiuqmF0dce8x6ri2QII0=;
 b=bc+fL23m5grVAlfP8BwcIrY1ER7mmWRgJS91q7n2K2kVkOX/bjiUkfSaFMhj9lfFIw0UDelZ2az8nrSCQ1XPkNoMLtpmVk/aBtaKExTFoTVRdK52p0ZeC5toQOk6AVF5EEfSYkRAW1psjN1ZUbYqYOIcU/xZ8/i2jE/5omqYMt31r7QlGxErK/06NfNsvq9XxNepUV1tWvbg0DKLJsRSeX00jEmr06fBUFaEg+OOoUO0gug63QS4pyEWtj5hBBxLXlnvUParSNwU3iB+HHI6ZLluxjo5EC7prZDcmz40tHaqYtxcZPmihQFBzHJbPenfuUTQ4varDuDASSy2WRS9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SA3PR15MB5680.namprd15.prod.outlook.com (2603:10b6:806:317::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 15:43:58 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 15:43:58 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 2/4] RDMA/siw: Reduce memory usage of struct siw_rx_stream
Thread-Topic: [PATCH 2/4] RDMA/siw: Reduce memory usage of struct
 siw_rx_stream
Thread-Index: AQHaJG0yG8X2T3FVNUaoPTdmON4keg==
Date: Fri, 1 Dec 2023 15:43:58 +0000
Message-ID: 
 <BY5PR15MB3602197D8A2E59E5CF6A28F99981A@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-3-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-3-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SA3PR15MB5680:EE_
x-ms-office365-filtering-correlation-id: c8675abf-c63a-4a11-1e4f-08dbf2845565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JgSKydBW77gxWT2i4MInPgo0A2V3If+irKuXlTgw52x1aytpgPpMdZU34Ti3S5pXvB/cp+OT0cll++v5tWXip7J6C9exhIZHYvsjvU4bv0pDa3QAPacY8LJbrxzPJ1XrgOkE1zpG/ZYQzVL9+uX6cbOF+TAZFFWfOkbPx49T9ETUlzioR7BMvQhFfgrOKQlBZR4eMJ5md3ZTbN/H+U/GrVaUHlcfwnFaUgTdGGAXZeZWs3T3rgnkFUn3FJjA0p2WJm9DawAboOQKMgww+oZnQ5A0pfHmJz9FUgOzDW8byPTQHKe1VAaOIdaSyQlQfo6x1PvGZI0lya5LgQmKumAcyZCO1JvK2i8MfqcgEW+l9tzR0+CsyP1UZYjJJ3fJJvHUP/r8hlAl4Vs66DNQyf2HMdv0v6eaGA1wUMJRoRIpyGjZXnSI3wbHvDS+drJ7i+SCKWreDGscYKPbOJuyRAEjy4sUybFnFbCYsBiE48coPXWUW2crOCYT21OKzn137kfyRzRDYjQZoHLU4h2WybWNGhVXeYN4bgVzQTP6mMfQn4Sr03ShBKB3QDirCZHR7+NxwBwKTLuT9tcNtlDtvLa+dTkEa4a6zbaooQIBAdS2osCKFqAilW1F2NqhrrIJ5YpcxqS/U7gCDmPlTa9B2tpOXg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(86362001)(38070700009)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(71200400001)(38100700002)(33656002)(122000001)(83380400001)(6506007)(9686003)(53546011)(7696005)(52536014)(4326008)(478600001)(110136005)(2906002)(316002)(5660300002)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MlE4OFpTUFlnVG50M1o3RXkzRGlJcjdwbWRkeFZ4WTdjZFpnTDRBR1NCbzFh?=
 =?utf-8?B?cGYzU0cydnpSMUE2MkIzUCtRKzlYRGJacEdZYWVwK3lKc05oZGZGTGFiL1RV?=
 =?utf-8?B?YkN1SzA0T1RSK0tEYitaVThOUXNtL1RnellwTitxUHlBVW50aTBWTEpGWFJm?=
 =?utf-8?B?YWFFOUtOTG5ZS2pnZ1RrWW9mWlFWTWM1aGtndzc0UjZWdzNpNjdaSldiS3dN?=
 =?utf-8?B?bDFJQjNkbG1JWFgvdVEvWlZJZzRJQXhwR3dYZks4ZFEwS0dxbC8yNjVKeC9W?=
 =?utf-8?B?b2FUR0ZHNjY2aTNYSEQxUzI0YW00Vjg0UGk3eEhUenBFYWNtRXgzdTRCS0Rx?=
 =?utf-8?B?RUJpYXlCUjZ3bGRxd21VUklkakw1NzVZeFcrYkU4UE5pUWFTdHRvMWlQZ1lL?=
 =?utf-8?B?UFBoTW0yV2wrY0JYaVZSY01ueklNY0RsUC9ZWFdsNkY1eXl4V1RIUUp2ZlFL?=
 =?utf-8?B?VG9FV21Ob05GZHExU0EvY004WkhiR1BqQjFBTDM5RXZkcms2WmxTUWg4djhQ?=
 =?utf-8?B?d2lmbmloRFNibTM4dzMwOGF4MXplaHRLZ2tGeUhNNzJMOUlpaVhRYnVLSzds?=
 =?utf-8?B?NmZ6OEpYbWhoR0ttZVhpdS92L3Y3U0F0dWRkbEoyV09RNkZ4RUJaQ3dIQVIr?=
 =?utf-8?B?VzJXUVU4eGFXVjVPcWZQbTQ5dU0zOVFsWHU5WXN3cy9PamZ0MDNwa2w4clJi?=
 =?utf-8?B?R0VuSVpaNG10ejhoR3RnVjUybnk0Q2I2a2VwMi9RSERTVlQzU2dCcGZOS1c5?=
 =?utf-8?B?V2ZKc3c5aE1QamQ2VlI1Sjlaeks5QXdtOGZYNmIxeFNHNFZRaXFGMW5pNkp5?=
 =?utf-8?B?L1FuSmVBQ212R29OV3BjSWVUMDJ3R3k2eHZSVUhnckswd0NNMW9wTGJSMGh3?=
 =?utf-8?B?YUMzWTFqZWV0K215V1o4TFk5TVA0WVc3WENWK1lVeDNiRVZ6dXhUeXdJU2JB?=
 =?utf-8?B?cW8yZjQ5L212QS9OL1FJTXhUMkswYXBxNE5POXVFTU4wT0RqSmVYeXZaNEtF?=
 =?utf-8?B?VWVsZE5MeFRuNWlVVVpianZYTTJOeGUrVGtCa3cySjlkMFNFbTNqdGQrc2xX?=
 =?utf-8?B?YkRraWJBQUpFUGI3bHdhUTk1T3pxYmJBQ1ZVSnVDTHNtejJFTW1jV1lqMksr?=
 =?utf-8?B?MkhEOXU1VUZGaFhyU2l4OWsrd1dvY0JXMkFQNEpla3RCV1FRWEJnVVRCZS9v?=
 =?utf-8?B?ZWwzMkt4dTd1QkY4c0w3T3BhdkZCdzN3aGgxZEE2TGdaUHJvMlNjOTRXR3Jk?=
 =?utf-8?B?TVdCSGRhSk81RW9ncEJlRnpPMDl5UGRucjFEaDFPSlpkbHhLTlQ4b0FWRlJU?=
 =?utf-8?B?R2VOUHVlV253aUxEdE04bG1scVFFL3ZnbEhRdTdRNU03UjhkbkEyZFVqMmJw?=
 =?utf-8?B?czZwNS9ISzZ6K003WGtSZWRybGE2cDJmN1U3ZFhQd0FhaFJpbG5YbGJjOEJV?=
 =?utf-8?B?ZUx6ZGV6Z2o4dVhNRkk0MHJydXQzU1gvTVI0Ui9CNWl2ZDM2YlF1ZzN2NDBW?=
 =?utf-8?B?a1BFMXhlWG9xdnIvQitsUHhEeWpSenZsZWQyRWhaL2ZIMFZtQS9VdTNPL2Zp?=
 =?utf-8?B?K0liNEF2N3kyQ2h4dlBvWS93Z29xa3JOU29pOWszV3g3cWFXdDI5VGQwNTN2?=
 =?utf-8?B?UTVaQ3JtRXJyYk5uenUrc1BjdXRRcFRPUHl0Z2JiMEZCUUwxWVhyZlZjaHNT?=
 =?utf-8?B?dEFYbjRMLzU3Ymo5Y0ZHY3pJaXpCVXRDRm9pQWk5dXFNQTBXMUtxV2dPeE9M?=
 =?utf-8?B?MEMxaDl3T2JldzRJMWEvK0tPbkpzVTFPTHJJVnZaVVZaMXMrRWs1ZVFqMTc2?=
 =?utf-8?B?VEd6aS90MmZWSDFCZDd0cUxBZk1UT3ZRaTZLWHNnSXZHNE1tUkI4WS9ES09T?=
 =?utf-8?B?bDY3MitIekVkTmd1dHFqVmZEM09nQ1FOZXN2NDl6R3V1WWNnKzVoTjRPa0pG?=
 =?utf-8?B?d3I3clh3SGhUaGNwcnFONytpT1BIMXBsZDVrR1lqUmtRNGFnZFdhQWNRSHZx?=
 =?utf-8?B?TnR2RmxUWDZGWWNnZVVGWHBaeStxS1BZbDZXMURNa3dwWjZnNktieWFsS2NX?=
 =?utf-8?B?ZXo0bTlYYTByQmhja20xVHhzTFFJbmh0YkUzY24xWWdCVkhyNU9tQkpzOFFy?=
 =?utf-8?B?eGRXMDh3ZTRqM01DR245cEJaWm1SK3d1M3MrcVdLbDhaZ25NdlpHNm42T3o4?=
 =?utf-8?Q?9xefnPV/m9OTXAjVSsqkG4ZKeupA6WoLuJk8DZ2atyh8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8675abf-c63a-4a11-1e4f-08dbf2845565
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 15:43:58.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDYMfZcBA9PPMIdS2/IrNYySCmNW9u490FjkLUkZFGu/3lIjHdJwXJbkenDcCdNFgILbFVnbU/TIjGSDf8uxSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5680
X-Proofpoint-GUID: ebJjbtIIu-V46GZDWStqodemuibFKDBM
X-Proofpoint-ORIG-GUID: ebJjbtIIu-V46GZDWStqodemuibFKDBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_13,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=747 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010109

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjks
IDIwMjMgNDoyNCBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtl
cm5lbC5vcmc7IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIDIvNF0gUkRNQS9zaXc6IFJlZHVjZSBtZW1vcnkgdXNhZ2Ugb2Ygc3RydWN0DQo+IHNp
d19yeF9zdHJlYW0NCj4gDQo+IFdlIGNhbiByZWR1Y2UgdGhlIG1lbW9yeSBvZiB0aGUgc3RydWN0
IGJ5IG1vdmUgc29tZSBvZiBpdCdzDQo+IG1lbWJlci4NCj4gDQo+IEJlZm9yZSwNCj4gDQo+IAkv
KiBzaXplOiAxNDQsIGNhY2hlbGluZXM6IDMsIG1lbWJlcnM6IDE3ICovDQo+IAkvKiBzdW0gbWVt
YmVyczogMTI0LCBob2xlczogMywgc3VtIGhvbGVzOiAxMiAqLw0KPiAJLyogc3VtIGJpdGZpZWxk
IG1lbWJlcnM6IDcgYml0cyAoMCBieXRlcykgKi8NCj4gCS8qIHBhZGRpbmc6IDcgKi8NCj4gCS8q
IGJpdF9wYWRkaW5nOiAxIGJpdHMgKi8NCj4gDQo+IEFmdGVyDQo+IA0KPiAJLyogc2l6ZTogMTI4
LCBjYWNoZWxpbmVzOiAyLCBtZW1iZXJzOiAxNyAqLw0KPiAJLyogcGFkZGluZzogMyAqLw0KPiAJ
LyogYml0X3BhZGRpbmc6IDEgYml0cyAqLw0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBK
aWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXcuaCB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3LmgNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+
IGluZGV4IGQxNGJiOTY1YWY3NS4uMmVkYmEyYTg2NGJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3LmgNCj4gQEAgLTI4OCwxMCArMjg4LDExIEBAIHN0cnVjdCBzaXdfcnhfc3RyZWFtIHsN
Cj4gIAlpbnQgc2tiX29mZnNldDsgLyogb2Zmc2V0IGluIHNrYiAqLw0KPiAgCWludCBza2JfY29w
aWVkOyAvKiBwcm9jZXNzZWQgYnl0ZXMgaW4gc2tiICovDQo+IA0KPiArCWVudW0gc2l3X3J4X3N0
YXRlIHN0YXRlOw0KPiArDQo+ICAJdW5pb24gaXdhcnBfaGRyIGhkcjsNCj4gIAlzdHJ1Y3QgbXBh
X3RyYWlsZXIgdHJhaWxlcjsNCj4gLQ0KPiAtCWVudW0gc2l3X3J4X3N0YXRlIHN0YXRlOw0KPiAr
CXN0cnVjdCBzaGFzaF9kZXNjICptcGFfY3JjX2hkOw0KPiANCj4gIAkvKg0KPiAgCSAqIEZvciBl
YWNoIEZQRFUsIG1haW4gUlggbG9vcCBydW5zIHRocm91Z2ggMyBzdGFnZXM6DQo+IEBAIC0zMTMs
NyArMzE0LDYgQEAgc3RydWN0IHNpd19yeF9zdHJlYW0gew0KPiAgCXU2NCBkZHBfdG87DQo+ICAJ
dTMyIGludmFsX3N0YWc7IC8qIFN0YWcgdG8gYmUgaW52YWxpZGF0ZWQgKi8NCj4gDQo+IC0Jc3Ry
dWN0IHNoYXNoX2Rlc2MgKm1wYV9jcmNfaGQ7DQo+ICAJdTggcnhfc3VzcGVuZCA6IDE7DQo+ICAJ
dTggcGFkIDogMjsgLyogIyBvZiBwYWQgYnl0ZXMgZXhwZWN0ZWQgKi8NCj4gIAl1OCByZG1hcF9v
cCA6IDQ7IC8qIG9wY29kZSBvZiBjdXJyZW50IGZyYW1lICovDQo+IC0tDQo+IDIuMzUuMw0KDQpM
b29rcyBnb29kLg0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5j
b20+DQo=

