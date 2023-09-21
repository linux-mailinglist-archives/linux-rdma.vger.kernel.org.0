Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4897AA216
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjIUVMY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjIUVLL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 17:11:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB476B4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:10:20 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38LGQ4Gt009637
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=21csZjvWOBZPn7xp6U5nWlbPweJ5ndSxyAXJ2NiLCpg=;
 b=DhYu5gN3RujtUU1OkLWSNnVhn6owhVj0OC2IYEzYI+vkvjLUo/rWuzbwDPnX5sMw1g6J
 6B4ECNo1CwUewjF612Kgx0rwXQcu2gzTi+nRdj5qFdPW1D1w9E5hGebUW7RtYDwF2Oy/
 Jl1OUvSn7iQ+/ZoD8UhT87PrYjfjVxjMTRMatKMk4zrbR0j+X+Vlo3KzVXVZlGDIA9qt
 8/CP9rnY2zHuGEcaBK+bTxo/7t3m62fAkHFdEGkDQkOTvGrEXQ+jYsmu9eM4CnE5btTU
 M9ML70a9DNdA9nGD6y8aUCXKHtGV8ZOpqfwsNfKH5W4klpHSbvlPJ4su+5Cqqe2YZ2PI 0Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0001303.ppops.net (PPS) with ESMTPS id 3t8axk8r9h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1J45Jns/WQ+Gli+ADyb48kTHc8m5cTIDlEiJpFLGHMmGPdmx/n/IwCd1o0tzZXInXNQz5x/R9MaNrkY6t3EukzEFXezXnEW9lXMpJGQrodurpVtTBX1rEbJSZQ8h+U64jHUhrMO59Dp30cW5Whas5rut3v9UB/V8FKrOBt3v26c8YMnRLZCVTBCDDgKMrBU7/obgNbFj9PAJWVuuP/dWruc5UiX3A0KK8jdTgeluhOQnBXzTYdD7ZuXCcosm4n6YLjLlHaMxeW/wFspLqFAiJ/wekWuZNf9ydurpkiSfWtoau1+1OST5x1S/eQQQs27wuIib1+AMUY+CM5uv5s/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21csZjvWOBZPn7xp6U5nWlbPweJ5ndSxyAXJ2NiLCpg=;
 b=h1Gsi9hfcpQt4hOS17fGL9NQfc2ZoDSB+h14uoTiEBu+n5aEUwc3rBuSukA8cTnjqURTqR5RsbzCZ70+bMbUK3DovTLdvDSU87sMtIjXrCR9lbPBZsJ+i1iOXTWR/lzfhUEPPTJCV4axsZuF3acKTcPIFqKWNbOuAkm6ee+vFLRLd4A+aWgQsPk/i06OJEMqezqNfiTZDOK7Rpat3IJmxb7Z3Fiz5yhUG1HJ3qapf28OEPMp2jNHpcz35qXxiYOlZevNT6WdZP8MylqoH8uGja7wCh13q+g3SLHvfKrz/YlX+jY8Yd4u+qi52zUqQrbz8LnmpE3pXSWNn4C3vi1+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DS0PR15MB5494.namprd15.prod.outlook.com (2603:10b6:8:c5::8) by
 SA1PR15MB4516.namprd15.prod.outlook.com (2603:10b6:806:19b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 16:31:44 +0000
Received: from DS0PR15MB5494.namprd15.prod.outlook.com
 ([fe80::ed6e:1fad:210e:d619]) by DS0PR15MB5494.namprd15.prod.outlook.com
 ([fe80::ed6e:1fad:210e:d619%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 16:31:44 +0000
From:   Maxim Samoylov <max7255@meta.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] IB: fix memlock limit handling code
Thread-Topic: [PATCH] IB: fix memlock limit handling code
Thread-Index: AQHZ6A/OwzwBLuCyS06OMFzlYLVztLAggdcAgAUAP4A=
Date:   Thu, 21 Sep 2023 16:31:44 +0000
Message-ID: <f83fcbe0-308c-4485-ad96-ede52608e141@meta.com>
References: <20230915200353.1238097-1-max7255@meta.com>
 <20230918120932.GC103601@unreal>
In-Reply-To: <20230918120932.GC103601@unreal>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5494:EE_|SA1PR15MB4516:EE_
x-ms-office365-filtering-correlation-id: b4f9410b-e84e-44fe-4cba-08dbbac03e3e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8k6xGWrRDqGDoTzcbi/bkr2LVMkl8+FnGNo/F3Xh2VSnx2DHLXioE2yjSWgFNQjD4S5RqUZDvEVTck+nbzQBTQlFvVOFwySxkgTmVptwT2+KM2c66h9H9x/j6fbUveaNRadFR/7XnABCI4Gdg/Mq3zAufBmCMGCCt9v5Vi6ZsfLGKu5nRMtn8/LNCdUT6q0ZbZDi3kzQMcsO12y80pIWm+VniwFpoGoYvY9/M/cHJPizAx+KL3/wP6faBefj5HISCG9WUaIhDAEJSpWlOi1SAoWCkXMzE8Sf64FJ3Y3mi3kfGEaOdgy/aXkBQLTIx+Od8cl+aaExv7yg1CZwz3f6Te8SZuFju/nLoi8Tmx7yhExCKwZdU2uYPROPVzbAY37zPmkcf89rL0wgEviVn8h2VZ6X7Ok64sFt27ry9zPDgqKOQzjUAMvgTYGIYVkMz3boO0NciMXprSEOxqZILX2k7FH4Phr+lQq2ZegnMEolfaWabLF283LjTH3c2SQCyVBU66+RZwxH8GegyIH/QAmG+J/kY6kxClsn9YbQjL1MYdVmvp02C75QSgTzqNXwnsPS61wmHsP5wK5htLQSTlmbWfTJm8CSbDOLna/+J4YAcGUasGgabHT42ZQL+VIr+/ne0IJxsw6CxSGTztjzRVCECA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5494.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(83380400001)(71200400001)(2616005)(54906003)(76116006)(66556008)(91956017)(66476007)(66446008)(316002)(6916009)(66946007)(64756008)(4326008)(8676002)(8936002)(41300700001)(5660300002)(6512007)(6506007)(53546011)(478600001)(2906002)(6486002)(31696002)(86362001)(122000001)(38100700002)(38070700005)(36756003)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEUzUGNFbU5xUFRGYUZOUVpIUFJ3MTdObGM0RENENzFiOHlsUjhhY1cyOFla?=
 =?utf-8?B?QWQvTDRSZnlUR2RKcXRYVGdDcWVmREZBWE9FNXoyREU4ckYzaXNWQWpPZFdK?=
 =?utf-8?B?c0JRNXJmdGRtM2pzZENMeFdXdlVYbE9HQWZtdHlMYlorQWRuNXFlYmd3RDBS?=
 =?utf-8?B?ZU1wUjZWTVNCU2RTSWt0MXJnaGtRbHRUL3NldDY3VW9uLzRmNzRzOWJMaENO?=
 =?utf-8?B?aDl0SUlQbDErcUU1QzgzNERUbGFBTjFYemdJOXdDMUFNdUkrL0huN2R1cm1W?=
 =?utf-8?B?enk3L0R0cS9MRGgwVzRSVGdId1MxaDMveHVEb1ZPVmpSMkd2ZFo1OWZLL2Vv?=
 =?utf-8?B?NHZOZWlndURuOXp1eDBwNDdpUHBPUzJ5bld0K2dOOXNzZ2VrVlVRV3QwK0Jr?=
 =?utf-8?B?WnY3dTRScVFQelgxaXd4aTExMVc2VmY4ZldRSXhONVM4ODloMEF1SUZMc3BI?=
 =?utf-8?B?bS9hWVhWWjEycEtIYVpqREFrdGxlalkyY0dLdHRKMGxNcDRuUzlnay9JbWl6?=
 =?utf-8?B?ZURzTVFLTGZQQWhKZnF5YUxzam5uazNKQllEWWNOUnFqY0JMcGlOSzVBa21a?=
 =?utf-8?B?MGdDMHJtVmNSdDZVUnNFSHdTMXJSaVdxVDN5SERicXZoSzVyTXZQZkl6aXph?=
 =?utf-8?B?TWN1eWJnYXZBSE5zMWlyWUNlcTdzTDJueFQwdldnM3ZUeEJxUFJLeFBURllK?=
 =?utf-8?B?b2ZZeXppUGZRZDBhc2VsU3FVcng2a1pjeDJuTjR3ZVVVSVg0U2pWM3huVU9s?=
 =?utf-8?B?U3ZwM2pSd2F5T3BxdXB3bmhiM2Z4QXBwemlxaHRoaHZNMHljTUJJaTFyVnZp?=
 =?utf-8?B?Q0hFY2NXc3VGeWdPRU1FWElibzU1TjVyS21LRWlyd2s2YktTNFhRdzBjT0R5?=
 =?utf-8?B?MFNzUnpwVlBqMzFLcWVKZHQrajdUd1FaWnRSN1pjbTlZaCtSczhYdHQ4bG1y?=
 =?utf-8?B?WFQ4OTdIRFFpb1ZiTWFaMHlQOXhBekw1VDg1MzVvZWdoN0JrMmV1NmJOT1Vw?=
 =?utf-8?B?NWY4NVhyOGxucUxyZGN1VHBVV01iOXh2eUlsZFNsemR6Um9NQStQYkVtWm8z?=
 =?utf-8?B?VzN6ZDJ6UkExMEFCei8vdm14OEt3cG5rdmQ5U0Q1RnFvdSsrS2RRTk8wNHJX?=
 =?utf-8?B?Q3dKazFEWXZTMXJYOW02QmErcElFZ3NvU3h5aTVBcVZwZDVXSENlcW0xU1hP?=
 =?utf-8?B?NE1Qd01UMlBNTUw0SXFua0s2cGtBTEFKWDRPNHRQaiszS3dldWU3d1ZiK0dV?=
 =?utf-8?B?OG02QlYyYUxuQ2hjODRxRWxyTk9RMFE2azZNU29TdUl2QVNUMXJvOVI1QXkv?=
 =?utf-8?B?MDhCK1o4cUNjSWRoZTZFT3czbXI5dEk2cndtbTRwR3VOdGR6WXdZdzRTSmI3?=
 =?utf-8?B?SCtZYjlhWHdnMTV3QmdkU3M5V0F5R1VZTWcxLzVJc2lkUk5aaTJPZFZGVW9j?=
 =?utf-8?B?R21wRGZIRlhnRmg5WC8vK1BsVTczczc5MkhzeG1LVDJDZldKV1RaTkVIMFVh?=
 =?utf-8?B?WWJQM3NISkF5VENpL1UrUDlqWWd4WGxKaU42ZFhTckU5UFlpVzc1THI2VEs3?=
 =?utf-8?B?bEp1S0xwb2RhU3B4ZXV1bmRVOWpWdzYvRU4zaDFnMnE5N00zSlBnT2xBUldG?=
 =?utf-8?B?SW9SWlBYOFJCMm5WTW9CS25mbkNhVHpUTHNKc2JQN1BMVUkxV0JKSFRzVDZW?=
 =?utf-8?B?akVoNzIzNEpzRGI5UzJ4UGxHUjJxTjZydDBiY0RWeUkwSFRMQyt0TnFUdHNw?=
 =?utf-8?B?a0lTSzdvU2Nkc2hTQ3JHeUlzTTVsWWljeE1BTGx6clArRTZvbktGWllvVElJ?=
 =?utf-8?B?enJvZjM5VnFmVHdWK1hPQnRlMTZsSm9CUUtOOU1uSWRqcnFUZ2hIMEs3RjYr?=
 =?utf-8?B?U09MQnBoMkNQN1NORFdiWXhob2tES1NSZXpUSlFyUktjYTVuZnJ0dCs4Y1dv?=
 =?utf-8?B?VUowbDI2cmkvRFNCU3lnSFdDNXdla0cySC92MjNXZS9TdldMMC9tcGl5RWhu?=
 =?utf-8?B?c05OeU4vY3VGa3ZEckFsZFM2UWt6bE42aDZwN2swQWtGTEVGY0daZlI0cHdC?=
 =?utf-8?B?YzlKa2grUlgwbklWS1ZHWEU2dVp6eEg4Q3ZOUWRNamgzKzIwbFBOY2pxZm5T?=
 =?utf-8?B?eVlHVUF6VHdLNDROZzVqSWZxek5aV2htUnozcHdRNWI1QmxEY3loR2N3U3Y2?=
 =?utf-8?Q?3ZYvskjAt9bj9N7NssXPPUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3817483DFCAE348B8EBE54409C93EE0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5494.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f9410b-e84e-44fe-4cba-08dbbac03e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 16:31:44.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTpFY0QqchSRsNj6XcNp78faw/X5X6V2Okhzq+vKC6PTjRIeBS6RbYe9pSp899PrZ/0baGW6+GPMKLvXByiL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4516
X-Proofpoint-ORIG-GUID: I_davqXrSgEU5_0yiA60YYvRZ_3res1a
X-Proofpoint-GUID: I_davqXrSgEU5_0yiA60YYvRZ_3res1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTgvMDkvMjAyMyAxNDowOSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiBPbiBGcmksIFNl
cCAxNSwgMjAyMyBhdCAwMTowMzo1M1BNIC0wNzAwLCBNYXhpbSBTYW1veWxvdiB3cm90ZToNCj4+
IFRoaXMgcGF0Y2ggZml4ZXMgaGFuZGxpbmcgZm9yIFJMSU1fSU5GSU5JVFkgdmFsdWUgdW5pZm9y
bWx5IGFjcm9zcw0KPj4gdGhlIGluZmluaWJhbmQvcmRtYSBzdWJzeXN0ZW0uDQo+Pg0KPj4gQ3Vy
cmVudGx5IGluZmluaXR5IGNvbnN0YW50IGlzIHRyZWF0ZWQgYXMgYWN0dWFsIGxpbWl0DQo+PiB2
YWx1ZSwgd2hpY2ggY2FuIHRyaWdnZXIgdW5leHBlY3RlZCBFTk9NRU0gZXJyb3JzIGluDQo+PiBj
b3JuZXItY2FzZSBjb25maWd1cmF0aW9ucw0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBh
biBleGFtcGxlIGFuZCB3aHkgdGhlc2UgY29ybmVyIGNhc2VzIGFyZQ0KPiBpbXBvcnRhbnQ/DQo+
IA0KDQpBY3R1YWxseSwgSeKAmXZlIGNvbWUgdXAgd2l0aCBwcm9wb3NpbmcgdGhpcyBtaW5vciBw
YXRjaCB0byBhdm9pZA0KY29uZnVzaW9uIEkgZ290IHdoaWxlIGludmVzdGlnYXRpbmcgcHJvZHVj
dGlvbiBjYXNlIHdpdGgNCmliX3JlZ191c2VyX21yKCkgcmV0dXJuaW5nIEVOT01FTSBmb3IgKHBy
ZXN1bWFibHkpIG5vIHBhcnRpY3VsYXIgcmVhc29uLg0KDQpBbG9uZyB3aXRoIHRoYXQgSSBjYW1l
IGFjcm9zcyBzb21lIGN1cmlvdXMgcmVwcm8uDQpDb25zaWRlciB0aGUgZm9sbG93aW5nIGNvZGU6
DQoNCg0KYWRkciA9IG1tYXAoLi4uICwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwNCiAgICAgICAg
ICAgICBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMgfCBNQVBfTk9SRVNFUlZFLCAuLi4gKQ0K
DQovKiBJQiBvYmplY3RzIGluaXRpYWxpc2F0aW9uICovDQoNCndoaWxlICgxKSB7DQoNCmlidl9y
ZWdfbXJfaW92YShwZCwgKHZvaWQqKWFkZHIsIExFTkdUSCwgKHVpbnQ2NF90KWFkZHIsDQogICAg
IElCVl9BQ0NFU1NfTE9DQUxfV1JJVEV8SUJWX0FDQ0VTU19SRU1PVEVfV1JJVEV8DQogICAgIElC
Vl9BQ0NFU1NfUkVNT1RFX1JFQUR8SUJWX0FDQ0VTU19SRUxBWEVEX09SREVSSU5HKTsNCg0KfQ0K
DQoNClRoaXMgY3ljbGUgY2FuIHdvcmsgYWxtb3N0IGV0ZXJuYWxseSB3aXRob3V0IHRyaWdnZXJp
bmcgYW55IGVycm9ycw0KLSB1bnRpbCB0aGUga2VybmVsIHdpbGwgcnVuIG91dCBvZiBtZW1vcnkg
b3Igd2UgZmluYWxseSBiYWlsIG91dCBhZnRlcg0KY29tcGFyaXNvbiBhZ2FpbnN0IHRocmVhZCBt
ZW1sb2NrIHJsaW1pdC4NCg0KQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgdGhpcyBtZWFucyB3ZSBj
YW4gY29udGludW91c2x5IHJlZ2lzdGVyIHRoZSBzYW1lDQptZW1vcnkgcmVnaW9uIGZvciBhIHNp
bmdsZSBkZXZpY2Ugb3ZlciBhbmQgb3ZlciwgYmxvYXRpbmcgbnVtYmVyIG9mDQpwZXItZGV2aWNl
IE1Scy4gRG9uJ3Qga25vdyBmb3Igc3VyZSBpZiBpdCdzIHdyb25nLCBidXQNCkkgYXNzdW1lIGl0
IGNvbnN0aXR1dGVzIHNvbWUgYXQgbGVhc3QgbG9naWNhbCBwaXRmYWxsLg0KDQpGdXJ0aGVybW9y
ZSwgaXQgYWxzbyBidW1wcyBwZXItbW0gVm1QaW4gY291bnRlciBvdmVyIGFuZCBvdmVyIHdpdGhv
dXQNCmluY3JlYXNpbmcgYW55IG90aGVyIG1lbW9yeSB1c2FnZSBtZXRyaWMsDQp3aGljaCBpcyBw
cm9iYWJseSBtaXNndWlkaW5nIGZyb20gdGhlIG1lbW9yeSBhY2NvdW50aW5nIHBlcnNwZWN0aXZl
Lg0KDQo+IEJUVywgVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIGp1c3QgbmVlZCBtb3JlIGlu
Zm9ybWF0aW9uIGluIGNvbW1pdCBtZXNzYWdlLg0KPg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJl
c3BvbnNlIQ0KQW5kIEkgYXBvbG9naXNlIHRoYXQgbXkgYW5zd2VyIHRvb2sgc28gbG9uZy4NCg0K
PiBUaGFua3MNCj4gDQo+IA0KPj4NCg0K
