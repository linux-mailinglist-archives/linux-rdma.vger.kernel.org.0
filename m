Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FA46DAB3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhLHSLU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 13:11:20 -0500
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:31969
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232815AbhLHSLU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 13:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRX0XyN1WW0NYsgzoLFDVIx4MrN9eEMpXXSWYcxzVvx2+CqZI3tZf6KcHtkLmZt5pPXO0y9JLh3G1tC6VkYC/TkYB1NbIEsnIr7wJUBAXCGbAKJfsDRM0DVn2Vf0xWjwVda0K4RJHOKPhFI+wS0lzxB4KPToBkBmWZMUWt+uMhV71jST+IOQTcKh0gCx0QnXKoJT6LhdfdX2UNvexAktZR2XLLYcqqf5itpR2KRDgzunaQjmt77/r211mGCGwlr/F67HM2/dVje2ssg+sBRjjYxLHh4YL9cpZs/7JnUE390K8tLewjmUnClKFLypjumQYfYNTN4EeMBCX/ZgLOThfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd2QbF96kcJC5XjpRmoT2GRVuONgBzGT3Tp0hiuE2hM=;
 b=jKDWsezhoyYKiEwfaf/qaI+zYIgJRs6hqhQDxgz9I7stmAaMV0JJ084OYGYZZh5qhmu4eiiRrzNZTgER7GBdHprjgr5fXV/6aAWprSaunBTxCRIfOaBS8E/TAw5ayrxmCa6IQCM3XssuR6BpqdwHyLkaKlGIa62BX5WXFAQ0uAp5C9D3cn9JjuayAg1XhUGHssPHXt8psOMJNz/01mR5NE+xr0Wt6JBOZZ2+0SQt1olsAYEnkijO5VrHMRT90Evow0gJWQMhF2ygI3ozdJ4I96ormMG7RaO2bDqawxnnDJxezE3QgPRb6FCHGVsyI7vqDTJVzhd7z0efNsf6NfO7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd2QbF96kcJC5XjpRmoT2GRVuONgBzGT3Tp0hiuE2hM=;
 b=Q3YysDDtOyCw45dv7EbxWsr5Xr2rj2PctuZb3T7ZWn6orIqOXdZKn9HTne5BLfmtOe/NGm88O9BdNioHP9yKOcx1U9Cce91XIwEsbqnPMUihwrDPYrt2XKDrnAmO4xWa6yP+XabnxX9gDOE8WXnrxFTETTZEpaFGcrrttp2wS4vZs661d3XQlyib0Q6RDipTF7LuYkBAeL+P26rX0S26f8JPTA/NyAhTFluIl/dZknlb8Q9uNhbuDc8f2tAwcJOyqvsHl6k8MU2VzeTElDAiX5excZq3bien0Y+pcQAlRxFn7ouaAv4UHkGd+r4ZfNhBxuhLUbf2q4oBiRtRWgLKTA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5832.prod.exchangelabs.com (2603:10b6:610:3a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Wed, 8 Dec 2021 18:07:46 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::2114:506b:1266:f823]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::2114:506b:1266:f823%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 18:07:46 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] IB/qib: Fix memory leak in qib_user_sdma_queue_pkts
Thread-Topic: [PATCH] IB/qib: Fix memory leak in qib_user_sdma_queue_pkts
Thread-Index: AQHX7Fxs4yMe7m2zxUSIdHugWqvVm6wo4xIA
Date:   Wed, 8 Dec 2021 18:07:45 +0000
Message-ID: <CH0PR01MB715354CD468DD7B80CD2A149F26F9@CH0PR01MB7153.prod.exchangelabs.com>
References: <20211208175238.29983-1-jose.exposito89@gmail.com>
In-Reply-To: <20211208175238.29983-1-jose.exposito89@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a03538a-83c4-43f2-dca0-08d9ba75a329
x-ms-traffictypediagnostic: CH2PR01MB5832:EE_
x-microsoft-antispam-prvs: <CH2PR01MB5832A73039F65373B249235BF26F9@CH2PR01MB5832.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zq4NGlsFg8ko0sHb5y1V8qvXFkvPmTOD4ALE6WakNw8/J9jasF7yCppX2YsduXntC0p4B2Y6Y7c2kbKWImIGyziAy1ZJyaZthF60j+kfGI9Jz8zyFtJp/oP16ddLasDtRLUrHYJsFUzrGFN4QUceeoiSlNoEgMHzMciXtoqcniUoMxjzSrTy9ei4BG2LDY9TooUidnj2kzMDahV8Hf/vFAC/4Spuhe+ihuDb7jZB1nfjr+26YMDQp4jtTqVM9bigAqg8ahF1qqy8Qg4yn28iuhBEAEF0arT/OxoxwNLpKcgITR2J80bXOXrHeGDH94mNhc2OAxB8211tjLMTbFSa9YX8ikfTpbYe4cWRU8fmfsGgrbQCSMOwGStuOmCu3f7SVEKuBdEvvIMTt9w4ttiyXvIngSPMU5qvNQ355gjGtpRE+taaVGDRFCpxJ496h1c8S6HPCAHYKpoUViSrLMC5OOzpU4980wlkIJxMILIF/Acj9ZKaDWxqO46iyG2rjH0ga/4iDmJhJUbcKfRsiYRIt5wYSyLM25c7dXkq/rcVfJIFa6KolUVXll66py1/LEbNLf3QxVrePIgbRQRcX0MVLBq6TM1XBSiYYfcfzFdQJ+ofyIjLHAaKYX7qiBgMkvjMNvvzNVBjVBZRGlqrH+SdAWC3Ami99lRevTi8CRB/C4bbuWO+KxpXIxfrhVK3k4PN9Nm9ZkM6RtYjdMNGAJG5Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39830400003)(396003)(346002)(136003)(33656002)(38100700002)(186003)(54906003)(6636002)(55016003)(86362001)(26005)(4744005)(38070700005)(110136005)(4326008)(508600001)(64756008)(52536014)(76116006)(71200400001)(316002)(9686003)(83380400001)(7696005)(6506007)(66574015)(2906002)(66446008)(5660300002)(66556008)(8676002)(122000001)(66476007)(66946007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnNVQ0NkZ2dNTGlES2dvWFYzaHpMWmxWVENtQnlLaC9PZnZZQlN4bTkwM0NM?=
 =?utf-8?B?ckc0eGs3d1pZTGZNUk5rQ2FWeUpwUTBpL3BMdkRDRUo3M2ZBZGI3V0JFWWFj?=
 =?utf-8?B?aGthbXdIM1pvUU5BY0gvQkg0OVI0Rm16QXVrRlBsaHdvWlZPMkR2LzBuWjFo?=
 =?utf-8?B?RjBiWkZ0VEFzL1kwSkE4a21yV0RYeXk3YnU4bFRIOU9YVjA4a2Z5aTNnWFo3?=
 =?utf-8?B?SzJkQVhQVXhtZGgzYStRZjJpU1lYam92TlBmZHYybjROVEpHbkgza1RRSmZC?=
 =?utf-8?B?YkpWWmpNNWJjcnFSZ24xMld2NmYxUUU2Q1doQnk1QUNvRXRtdS96Z2NxYkE3?=
 =?utf-8?B?NFhGM0JId1AzR1UxT25TczVJTkRiTjJsbzU0ZWViSjBLRytyaEwzWVI1dWFI?=
 =?utf-8?B?Zjd5ZTFGVGp0STJjcmsrM2I1RzNqMzJ2VW93Z0FWN21jVDlhc2ovY2EwSUZN?=
 =?utf-8?B?cWlXV0tFeGV6b2FKZVdWR0QwSlJSbnpHZEhtWGtDYUZ4Z29ucHlhREZ3aVZ0?=
 =?utf-8?B?TWI5Qmt4TXJWUk1qWWVhZEYyeVhPNXQ3ZEwzb3pWVnNjOHFWQy9rY3IwTTcz?=
 =?utf-8?B?ekpEME9xRmNVYnV6OWFydndtckZVNURtT2FtVWlYenFLeTBGeDhxeDE5M0Q3?=
 =?utf-8?B?Z1FiYjRveFNwczQzeDkrNy9xVTI1T2Z6NEQ3Zjl1TEc5ZDFrMm1qSWxiL0Ja?=
 =?utf-8?B?a0hGMzFPZEJKMnF5K2NBSGlNMDRTVFdnbGZBRUhmUUF2V05MbVlzU1VRSWIw?=
 =?utf-8?B?eUFhaG5jdEVDZFZ4UVJHMzVCZWg5Z0dGQjFHR2Z5UUlLc3lZZWhzTXFRUmFP?=
 =?utf-8?B?WmIrQ2lCUUJ5dk9waDVxbzFxS2lnbi9yQzg5NGwyRGM4SURqM0pMelUzbVdX?=
 =?utf-8?B?TlZRWlluQm4zVlZZcGMxU2RsOGdCU0NhTkZLRStLdVRsM0RjM0lCY1dRS2tS?=
 =?utf-8?B?cVZPVURadm9zTFdYTUdVb0kyUDRnY3IxTi8zQzRNUUR1QXhLRGxEeEdiLzVq?=
 =?utf-8?B?TjFENXVwUlVOSzNhcFN0aVpDRDR6YVdRT3IvMkFwUW1pbjdjVzVzV3ZaMGhZ?=
 =?utf-8?B?YlNMcG9ONUxHZlplRVlHckZ0UFdNQ21uMWNHQWJsdTE1NDVRWHJkV3hOUW9z?=
 =?utf-8?B?bmpFekdpVFlXZWRIQVFhd0ZuVjAyWGpLSHJoQ2svNEVzRW82YjlvbGtvU0ZC?=
 =?utf-8?B?aURsclMrMjhFY3dMQVd5MFB2QzhyUDFGaVk2cTZjUDFZMElJVER1ZTg0WVl0?=
 =?utf-8?B?Lzcya2NTWUtWTEFFUk83V2RYeFRmTFduYTBWb3ZkSW9UL3ltUnVSRGx3SklX?=
 =?utf-8?B?L2FUWHFKbWo0b0xjS2wvMmEvN3ZaanV2ekY2R1lmbWtxTDdHcmViSWZNd0hi?=
 =?utf-8?B?dFJMYitMZUtQQkhRTlhxb29Wa1NKOU1HaHAxZ3FvcTJEMDZMcWsrOXhDV1dh?=
 =?utf-8?B?VndSekJLd3lwQkVZaFJmZXpMVE8vZkRHdGdiSTNZWE4zQmd1aXhiZkM2cCt5?=
 =?utf-8?B?WlFBdU4wM2pzYVRmZ29jbEx3R0xVWjFZUHNlZm9MUnhuZUlOSm5jMlZ5czVp?=
 =?utf-8?B?TkNLUjcrbjFzbWJxM2sxRktnWjBOYjE2WjBQbDBtZDB5UkUxdVMvcDNGb3Zi?=
 =?utf-8?B?clB4a3VNUnhPSkRxTnI2OWV4UUZleWF4eC9Lbjl4dUFIVkpEN1RSOWpTVkh2?=
 =?utf-8?B?SERZemllT3I3TFlNMEtvVjBWMDY4N2hjWlFQR0M0ZitSdlM1eTFuLzNnclJH?=
 =?utf-8?B?RHB0T0draFFXbzcvNlNXaC81WThTZ0NBNFg4ekVtMmVCZHlOYmk0dXV2Q1ds?=
 =?utf-8?B?bXJkSmsvTGNaSXdQdlRncjhFcWRURjlOMXpkOGhNR05FVTJhVC9IUGFZYk92?=
 =?utf-8?B?MGVFc0JlUE9JM0pjQTYxa24xNVU0VUU4NGsxN1pvZnlteUNSc2FqT0daUG5P?=
 =?utf-8?B?RkdVeUdjbW9oNDREWlBFTFdkQjZkVlhvUzNoMHA2ZCtsN3ByRnMzbDc2OFpV?=
 =?utf-8?B?M00vVWVLbms0MEV3TnNFYnlISEFjZTZ0L3hybUNTOWdOcUJKTFpxd0xHR0hV?=
 =?utf-8?B?b0RHQkVzL0ppOEZFS0FrTzFVWlUzYTVGTERvQ2JLN3ZSMmZ1MVp0TDVRWmhJ?=
 =?utf-8?B?TDFaUTdicnBnVHRPVVg5NGNIQi90M1U2eURhSFRwMmVUcmdybWRXMEpRL0xj?=
 =?utf-8?B?b3l1anZQS2JUclZmdHdlb3dhQ0trU0hrTnpaeTkwS05TQVl0TlhONFZwb3NN?=
 =?utf-8?B?dHN0ZU9ROVFRZmlsbHNsM3VCQ3A1T3ZuM1ArWU9NQnVyNmVjQlF2aW9WVzYy?=
 =?utf-8?Q?t7BApI520epxvKNGbz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a03538a-83c4-43f2-dca0-08d9ba75a329
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 18:07:45.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAQKRdyMmkB9zen4NZmr9ByQLx1MO59JwPPP5I+7Y2lWPu7IcDE1/BS82c3E7pnpqWKp2TU8SlsWf9CKOhn1Au7+VBot/3xukCmBem4FYil30kvIeLuDRuiPC8ygUtuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5832
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0hdIElCL3FpYjogRml4IG1lbW9yeSBsZWFrIGluIHFpYl91c2VyX3Nk
bWFfcXVldWVfcGt0cw0KPiANCj4gQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiAxNDkzMzUyICgiUmVz
b3VyY2UgbGVhayIpDQo+IFNpZ25lZC1vZmYtYnk6IEpvc8OpIEV4cMOzc2l0byA8am9zZS5leHBv
c2l0bzg5QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvcWliL3Fp
Yl91c2VyX3NkbWEuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9x
aWIvcWliX3VzZXJfc2RtYS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L3FpYi9xaWJfdXNl
cl9zZG1hLmMNCj4gaW5kZXggYWMxMTk0M2E1ZGRiLi5iZjJmMzBkNjc5NDkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3VzZXJfc2RtYS5jDQo+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3VzZXJfc2RtYS5jDQo+IEBAIC05NDEsNyArOTQx
LDcgQEAgc3RhdGljIGludCBxaWJfdXNlcl9zZG1hX3F1ZXVlX3BrdHMoY29uc3Qgc3RydWN0DQo+
IHFpYl9kZXZkYXRhICpkZCwNCj4gIAkJCQkJICAgICAgICZhZGRybGltaXQpIHx8DQo+ICAJCQkg
ICAgYWRkcmxpbWl0ID4gdHlwZV9tYXgodHlwZW9mKHBrdC0+YWRkcmxpbWl0KSkpIHsNCj4gIAkJ
CQlyZXQgPSAtRUlOVkFMOw0KPiAtCQkJCWdvdG8gZnJlZV9wYmM7DQo+ICsJCQkJZ290byBmcmVl
X3BrdDsNCj4gIAkJCX0NCj4gIAkJCXBrdC0+YWRkcmxpbWl0ID0gYWRkcmxpbWl0Ow0KPiANCj4g
LS0NClRoYW5rcyBmb3IgY2F0Y2hpbmcgbXkgbWlzdGFrZSENCg0KTWlrZQ0KDQpBY2tlZC1ieTog
TWlrZSBNYXJjaW5pc3p5biA8bWlrZS5tYXJjaW5pc3p5bkBjb3JuZWxpc25ldHdvcmtzLmNvbT4N
CkZpeGVzIGQzOWJmNDBlNTVlNiAoIklCL3FpYjogUHJvdGVjdCBmcm9tIGJ1ZmZlciBvdmVyZmxv
dyBpbiBzdHJ1Y3QgcWliX3VzZXJfc2RtYV9wa3QgZmllbGRzIik6IA0K
