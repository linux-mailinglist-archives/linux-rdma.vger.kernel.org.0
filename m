Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAC7DCDE7
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 14:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjJaNah (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjJaNag (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 09:30:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D3DF
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 06:30:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V73FjI009816
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 06:30:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tLStxBrkpwQ953zzdfvbHoYxwewhGfKJdvN4LuI/HtQ=;
 b=ekTxkoEDY+RNSYpjjdnIUQ5gV/Z6eHD3ByRk7t4Ffq/H4V2UW3DM5Yw+b4Uci4zq3f0n
 1wSHhV0/lBH8QU3DGKAdkzx7wuMJoShWY2YF2JlrYHLkm3OGLtTapcJ7pv9toRjtmAXE
 chvElmVAFxaDth5FpoIS1lkxi4l0Zx0DvXmi7PduWjjr6nPTQaXML0+6n4I6jpjTNzqc
 fhE61QB/juanXPkoDaj3TJubp1xzBINCwVD7pXCNM2YAnc/1io20xhHPIZlsqT4CAOWV
 8/5cz+ZJX9SIgCzxbMBi9G9I3zPmS8MX4dmum5pMs8MCGhPKGw0Cm54rzRyetsWg2xYq vg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2vursunp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 06:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXu67s6MwMsuyTU70v0IhWfuLAvVWMAEv0s1WrbsQrqci9zsXAu42IyB9nnX5RBg0Mk5z/Gj91sH8pA7FVbhkxbMVO3xH0S3fn1ReRaIO20EqsYbPD1XMqY/YtIOo7B14nmhhOB6UyyOxHSel75WNtLykSQb7Gg3E6ua+V+0X+IpM/KVbBocz5YZSF5tu/qgY5cvXvcPgMLAhS6wuOcjBCS9ZD4QnDHhbPOUMbFWiyI3ngZmn3EoQhdI8iNP1dGyj6+X1oHxXchCnNwug9UccWVk7zhTVChKclgn8NcWziWYUD/Tx7kTvzmNUQUNmLA7IhOLrZxTwMnAbfD29ucggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLStxBrkpwQ953zzdfvbHoYxwewhGfKJdvN4LuI/HtQ=;
 b=l2XzVzTVAnnWyrYJQDf1E8ZmMRdUkWWB3j5iALMx4vyGXgtBM61z5YCJE02TfC8aXqmSLdHKhhNnhvVUrqfrgjVDJzD/6UGHP4u7e3YKWGMzJJ0lV9h+BYvefvmmMykFiENCgzxcbMNYB/ELhHqOaU0Cd53vm2Cw7L6wuaLtqoY8reto7ABU4+Q/NuB7lS/NpPUxojzzbLo9oUS87EfhoxouEBYT7GZXLx3vJxwi6aqru+NtXgWXMpwe9fjm5pXH3BepVPWXeh+tN2iSe7m+ydRZiSX1aTq9lwwhjFhlRFpy6TSFfqROtcFPvUHA9jL7JdC9T8V0S0+yuFA9a3zouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DS0PR15MB5494.namprd15.prod.outlook.com (2603:10b6:8:c5::8) by
 SN7PR15MB6086.namprd15.prod.outlook.com (2603:10b6:806:2ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Tue, 31 Oct
 2023 13:30:27 +0000
Received: from DS0PR15MB5494.namprd15.prod.outlook.com
 ([fe80::f3c8:a88d:65c0:11cf]) by DS0PR15MB5494.namprd15.prod.outlook.com
 ([fe80::f3c8:a88d:65c0:11cf%7]) with mapi id 15.20.6954.012; Tue, 31 Oct 2023
 13:30:27 +0000
From:   Maxim Samoylov <max7255@meta.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
Thread-Topic: [PATCH v2] IB: rework memlock limit handling code
Thread-Index: AQHZ/OY8Wqn2VzcqC0i/fYkYcU7QvLBKl72AgAwSNQCAAEZ4gIANEpoA
Date:   Tue, 31 Oct 2023 13:30:27 +0000
Message-ID: <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
In-Reply-To: <20231023055229.GB10551@unreal>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5494:EE_|SN7PR15MB6086:EE_
x-ms-office365-filtering-correlation-id: 6ed95450-bfe7-4615-db6e-08dbda158b8d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WwQfdh+43XTP5OGLf3XKNqC8qilKVHKoOJkFV9F8SsCta9XH2zr350UlDCiz4NvBWiHimmKLd6336R2nbc8lpuIdpDsnAnWh4FKXhBHxO6ZDnoUzTn/8Yuefdyd/FuCkYfi+AcMUMOs48PraOn5xk7GXnXO0OFxgI2bHR9VD448hTUNwlrUCmXxxd3T+XZA4jmjEdflNJlPcEPaKHtCeOazL8xlH3iga1VVn6L/13k0dpcw9WVXCARw2cN2qdY1/98qBgfpqIKmXn3q/NcGGFgP8ONUUaYuUl+G8TG8H4Y/o1NVcrdg+W6vF/nw5roSCXqKmcvieJTNjfZ78bU+ivqfv5EepKUsz/1LpzKurkW9OhSfaEbXT2AMitmroRhbGRJQxZ7hDSTIhVCiGtOd6j8VMlVeVmI0+Gcb7RbmKMNkZzeJL7ecaE8GgmYg7zBWEMaGJrBdlfUL1j/655Ok9AAvHJC7zHV33yLbmdXLKoY6p8a1jKB1b/sYBqryb+AedWQAHE+ESEuvUHE437z2sPqm7xSQZTLPj9vZfmOmWPCgpiXiJlev27mBifatO001VVteARgkOAKxP58UvRXBVtFIxzC+pUt8gwkbMwTeb53Ca9K0yQo1puusrythX30CYXo0t6ZaHr+8k+G73oXeyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5494.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(86362001)(31696002)(2616005)(2906002)(38070700009)(66476007)(83380400001)(64756008)(54906003)(91956017)(66556008)(76116006)(110136005)(66446008)(66946007)(6506007)(478600001)(53546011)(41300700001)(36756003)(122000001)(6512007)(38100700002)(71200400001)(8936002)(8676002)(4326008)(31686004)(6486002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVYzbm5sdXRjdU9rYmV0MXd6U1ZwUDl1ajRBcVlpd0lKaVEvSEVYY0k3eWhm?=
 =?utf-8?B?TzFvRDk2SkY3bHdOK0pqR2tBU1RBNjd5anZHS1RaQTNzQ0lySkFodHZ0VXlm?=
 =?utf-8?B?cVl6K3dZLzF0VGdXLzdaZGgvbEJYNDU4U2N4YUNYTzEyNm1tTjE3MFlpVkpv?=
 =?utf-8?B?TWZHbUhjN25tNzBDMm1qSFB4aDNIenE4QUlaT3Uvd3Z2NkQ2aVVlcnRMTUhZ?=
 =?utf-8?B?SCtURnFtemtjUEdRTnhPZ21NYWZhL0FWVmh1WmtvMU81RzlJZk5LTnN0cTFD?=
 =?utf-8?B?aGpTOVNocVQzb2NuK1VmN0lRd0c1RHc3T0tEYWNKdk1YNURTWHBLRTNTUk5K?=
 =?utf-8?B?SXdYL3V2MXNUQVBVZWw2aHRNNXZpQkdyWXlETVp3MHZHQXp4N1Mzbyt3blJm?=
 =?utf-8?B?L0owdVJ5czQzNUJhbXFvZU5DR1pzUVhRUjh5SWNuRUdRY2NmYjJtMG1pN2JP?=
 =?utf-8?B?M09qdDNCajJzV2s2K1FLSU5XQm1KeDZROW9UZnN6Q2FGclZxMUx2anA3ZTdJ?=
 =?utf-8?B?ZThORTMrMlZla0YxYTZ1dHhkdk55RS9MVklHNVpiRUhjbTIzN2pzMG1wOE5E?=
 =?utf-8?B?ZDRHTTdBNFNxdHo0SS9yRytTYWtNdkxaNDl4S0I4Sk5uencvdmpUalUwZita?=
 =?utf-8?B?STdpMTdzK3k0QlB1RElnbnJobnQ4V25YclRCak4rZlhTV0F2aFBjSHlUc1lj?=
 =?utf-8?B?ekFxYklORWhzd3pWakRWcjFTbTJkZWtKODdWN0J3UElIbWlYcXZqWUhFV2p5?=
 =?utf-8?B?NHpBRHd2YlNPcUxIcWY0RllvMWZnYzIzWWI3RCs4Qm45NUFhTVlLTWJJWW9K?=
 =?utf-8?B?NGdDMnhabitjZHd0ZXlOejdkaGtUNmFIbWh4U0NNdnV2dmdBY3lSajcrU0Nu?=
 =?utf-8?B?TFpVRW5DOU9vbmhjMUNkUHFEOC9NNWdRQ1JoL2Vla2k4ZExXSTNqelpYU1pT?=
 =?utf-8?B?L2RPdm1tZnN3QWVsaERaQVBkYkJPU01hcUhzWW50SkF2akNFQk9ZdDZJcTlT?=
 =?utf-8?B?VHRCT1NYMXlWNEtqZHBZeFVleWpIdHlLcFdHQVNGb0NFbngyaHFadEd5QXhO?=
 =?utf-8?B?UllkYWVoWmRKN3BBd0VpVTM3cTVzSWh4eFFySURkL0xvQkI2SUkwNCtKdVlS?=
 =?utf-8?B?Q0Z6dzRCR0h3bmNHTXNxaGdqb3JSWDA4N2srUEYxV21BREtJK3VqYllOeldo?=
 =?utf-8?B?cDVZQ0U3d1ExUDhOUmZRQTlienNUKys4UjdibkMyU2xDS2p4cEFRaGo4a1Z6?=
 =?utf-8?B?dy9pTkhOMGcyNFBkcEZnTm1COEFGVnFoS1hJWTRqZGFNQ0JWblY2MjlxZ2Ev?=
 =?utf-8?B?RGZvaHlwUndXajhBUXBwVVh4WjAwZFFnVmhsUDFSb29Oajh5cUFyVlVHWGU1?=
 =?utf-8?B?cS9YOFMrcjBGREY2K1RXQUhwWGo5WXZQYjJwdlkxcWNSMGNXNnIrczlvWitS?=
 =?utf-8?B?NE12MjhJaGthbm1RVzBwUklmVkhEMmZ4Zi9QT0NLdlFBNUFhMVB3MEFVd0Rt?=
 =?utf-8?B?c3hpVXdrT21jZnBvam5ZajR0NTVzOUJlV3IvbmRENU1MSFJmU1cwYnBhUGlS?=
 =?utf-8?B?a0tWZjdZeFQzQXVuaFNrU1V2Vlh2SStwMy9NaVRQSnB4RUwzVjFGRU5ZS2Jo?=
 =?utf-8?B?dnUwVmd6emxmaW5HYStEMUFBMHdndk85aU13ODZiNWRhR1Nscm8vS1hZWkRx?=
 =?utf-8?B?V2pScEpmY0MyL1Z2MWY4cE41TWFITis3V2JVcVQybUtsbTBqY055SFZQV08z?=
 =?utf-8?B?VFpwUXh2eGtTQXdnTjdmWlN5dGpWS1hDSE83TTNmRlZtRGxhbndGaGpvbDNP?=
 =?utf-8?B?TmFXMXpSVWc3Q0s2YnlidlhUTU9XOTQxNFRuRXFoMEZRa3ZIM29xREFaWWdO?=
 =?utf-8?B?bWdyR3hHZXFKTGZES2VMUktEU1ZFMlI3V2JDMUpKUDdMOVlhbHR1Ri95enZw?=
 =?utf-8?B?a2xQWk9XMTZ2bWNZWGRjVHBuMUtVM3NIUFhuekhXMHhIUjhzVUZpSHlsSlk3?=
 =?utf-8?B?YXlpdGFLRWxJSHVOREVjWDVFNWtTSUVtcjJsZGR0N3l5OVZUUnBvTGVDZHI2?=
 =?utf-8?B?aEg0VVkrWlJoTWFwb3JUU1NpcXBuZ2Jpd3doZlVCZnhTWkpLbUhXbmxCTlMx?=
 =?utf-8?Q?6AY7TP/iQsKiQqn+3ddFwFZbQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA12AE4D45221F4D877C1F87C02215E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5494.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed95450-bfe7-4615-db6e-08dbda158b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 13:30:27.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQmYogk/Sd0mWjnuEMm/Xi7g8Do/yZtnwtAyddWEQzMUvo+7L5Vca44gPne+PHrTMUAIGxYUuGd3tlqZGCAP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6086
X-Proofpoint-GUID: rRZYCVBZofprare51h_jy6rxgZNnfoA6
X-Proofpoint-ORIG-GUID: rRZYCVBZofprare51h_jy6rxgZNnfoA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjMvMTAvMjAyMyAwNzo1MiwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiBPbiBNb24sIE9j
dCAyMywgMjAyMyBhdCAwOTo0MDoxNkFNICswODAwLCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPj4N
Cj4+DQo+PiBPbiAxMC8xNS8yMyAxNzoxOSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+IE9u
IFRodSwgT2N0IDEyLCAyMDIzIGF0IDAxOjI5OjIxQU0gLTA3MDAsIE1heGltIFNhbW95bG92IHdy
b3RlOg0KPj4+PiBUaGlzIHBhdGNoIHByb3ZpZGVzIHRoZSB1bmlmb3JtIGhhbmRsaW5nIGZvciBS
TElNX0lORklOSVRZIHZhbHVlDQo+Pj4+IGFjcm9zcyB0aGUgaW5maW5pYmFuZC9yZG1hIHN1YnN5
c3RlbS4NCj4+Pj4NCj4+Pj4gQ3VycmVudGx5IGluIHNvbWUgY2FzZXMgdGhlIGluZmluaXR5IGNv
bnN0YW50IGlzIHRyZWF0ZWQNCj4+Pj4gYXMgYW4gYWN0dWFsIGxpbWl0IHZhbHVlLCB3aGljaCBj
b3VsZCBiZSBtaXNsZWFkaW5nLg0KPj4+Pg0KPj4+PiBMZXQncyBhbHNvIHByb3ZpZGUgdGhlIHNp
bmdsZSBoZWxwZXIgdG8gY2hlY2sgYWdhaW5zdCBwcm9jZXNzDQo+Pj4+IE1FTUxPQ0sgbGltaXQg
d2hpbGUgcmVnaXN0ZXJpbmcgdXNlciBtZW1vcnkgcmVnaW9uIG1hcHBpbmdzLg0KPj4+Pg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBNYXhpbSBTYW1veWxvdjxtYXg3MjU1QG1ldGEuY29tPg0KPj4+PiAt
LS0NCj4+Pj4NCj4+Pj4gdjEgLT4gdjI6IHJld3JpdHRlbiBjb21taXQgbWVzc2FnZSwgcmViYXNl
ZCBvbiByZWNlbnQgdXBzdHJlYW0NCj4+Pj4NCj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvdW1lbS5jICAgICAgICAgICAgIHwgIDcgKystLS0tLQ0KPj4+PiAgICBkcml2ZXJzL2luZmlu
aWJhbmQvaHcvcWliL3FpYl91c2VyX3BhZ2VzLmMgfCAgNyArKystLS0tDQo+Pj4+ICAgIGRyaXZl
cnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY191aW9tLmMgICB8ICA2ICsrLS0tLQ0KPj4+PiAg
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYyAgICAgICAgfCAgNiArKystLS0N
Cj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYyAgICAgIHwgMjMg
KysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPj4+PiAgICBpbmNsdWRlL3JkbWEvaWJfdW1lbS5oICAg
ICAgICAgICAgICAgICAgICAgfCAxMSArKysrKysrKysrKw0KPj4+PiAgICA2IGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPj4+IDwuLi4+DQo+Pj4NCj4+
Pj4gQEAgLTEzMjEsOCArMTMyMiw4IEBAIHN0cnVjdCBpYl9tciAqc2l3X3JlZ191c2VyX21yKHN0
cnVjdCBpYl9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxlbiwNCj4+Pj4gICAgCXN0cnVjdCBzaXdf
dW1lbSAqdW1lbSA9IE5VTEw7DQo+Pj4+ICAgIAlzdHJ1Y3Qgc2l3X3VyZXFfcmVnX21yIHVyZXE7
DQo+Pj4+ICAgIAlzdHJ1Y3Qgc2l3X2RldmljZSAqc2RldiA9IHRvX3Npd19kZXYocGQtPmRldmlj
ZSk7DQo+Pj4+IC0NCj4+Pj4gLQl1bnNpZ25lZCBsb25nIG1lbV9saW1pdCA9IHJsaW1pdChSTElN
SVRfTUVNTE9DSyk7DQo+Pj4+ICsJdW5zaWduZWQgbG9uZyBudW1fcGFnZXMgPQ0KPj4+PiArCQko
UEFHRV9BTElHTihsZW4gKyAoc3RhcnQgJiB+UEFHRV9NQVNLKSkpID4+IFBBR0VfU0hJRlQ7DQo+
Pj4+ICAgIAlpbnQgcnY7DQo+Pj4+ICAgIAlzaXdfZGJnX3BkKHBkLCAic3RhcnQ6IDB4JXBLLCB2
YTogMHglcEssIGxlbjogJWxsdVxuIiwNCj4+Pj4gQEAgLTEzMzgsMTkgKzEzMzksMTUgQEAgc3Ry
dWN0IGliX21yICpzaXdfcmVnX3VzZXJfbXIoc3RydWN0IGliX3BkICpwZCwgdTY0IHN0YXJ0LCB1
NjQgbGVuLA0KPj4+PiAgICAJCXJ2ID0gLUVJTlZBTDsNCj4+Pj4gICAgCQlnb3RvIGVycl9vdXQ7
DQo+Pj4+ICAgIAl9DQo+Pj4+IC0JaWYgKG1lbV9saW1pdCAhPSBSTElNX0lORklOSVRZKSB7DQo+
Pj4+IC0JCXVuc2lnbmVkIGxvbmcgbnVtX3BhZ2VzID0NCj4+Pj4gLQkJCShQQUdFX0FMSUdOKGxl
biArIChzdGFydCAmIH5QQUdFX01BU0spKSkgPj4gUEFHRV9TSElGVDsNCj4+Pj4gLQkJbWVtX2xp
bWl0ID4+PSBQQUdFX1NISUZUOw0KPj4+PiAtCQlpZiAobnVtX3BhZ2VzID4gbWVtX2xpbWl0IC0g
Y3VycmVudC0+bW0tPmxvY2tlZF92bSkgew0KPj4+PiAtCQkJc2l3X2RiZ19wZChwZCwgInBhZ2Vz
IHJlcSAlbHUsIG1heCAlbHUsIGxvY2sgJWx1XG4iLA0KPj4+PiAtCQkJCSAgIG51bV9wYWdlcywg
bWVtX2xpbWl0LA0KPj4+PiAtCQkJCSAgIGN1cnJlbnQtPm1tLT5sb2NrZWRfdm0pOw0KPj4+PiAt
CQkJcnYgPSAtRU5PTUVNOw0KPj4+PiAtCQkJZ290byBlcnJfb3V0Ow0KPj4+PiAtCQl9DQo+Pj4+
ICsJaWYgKCFpYl91bWVtX2NoZWNrX3JsaW1pdF9tZW1sb2NrKG51bV9wYWdlcyArIGN1cnJlbnQt
Pm1tLT5sb2NrZWRfdm0pKSB7DQo+Pj4+ICsJCXNpd19kYmdfcGQocGQsICJwYWdlcyByZXEgJWx1
LCBtYXggJWx1LCBsb2NrICVsdVxuIiwNCj4+Pj4gKwkJCQludW1fcGFnZXMsIHJsaW1pdChSTElN
SVRfTUVNTE9DSyksDQo+Pj4+ICsJCQkJY3VycmVudC0+bW0tPmxvY2tlZF92bSk7DQo+Pj4+ICsJ
CXJ2ID0gLUVOT01FTTsNCj4+Pj4gKwkJZ290byBlcnJfb3V0Ow0KPj4+PiAgICAJfQ0KPj4+IFNv
cnJ5IGZvciBsYXRlIHJlc3BvbnNlLCBidXQgd2h5IGRvZXMgdGhpcyBodW5rIGV4aXN0IGluIGZp
cnN0IHBsYWNlPw0KPj4+DQoNClRyYWlsaW5nIG5ld2xpbmUsIHdpbGwgZGVmaW5pdGVseSBkcm9w
IGl0Lg0KDQo+Pj4+ICsNCj4+Pj4gICAgCXVtZW0gPSBzaXdfdW1lbV9nZXQoc3RhcnQsIGxlbiwg
aWJfYWNjZXNzX3dyaXRhYmxlKHJpZ2h0cykpOw0KPj4+IFRoaXMgc2hvdWxkIGJlIGliX3VtZW1f
Z2V0KCkuDQo+Pg0KPj4gSU1PLCBpdCBkZXNlcnZlcyBhIHNlcGFyYXRlIHBhdGNoLCBhbmQgcmVw
bGFjZSBzaXdfdW1lbV9nZXQgd2l0aCBpYl91bWVtX2dldA0KPj4gaXMgbm90IHN0cmFpZ2h0Zm9y
d2FyZCBnaXZlbiBzaXdfbWVtIGhhcyB0d28gdHlwZXMgb2YgbWVtb3J5IChwYmwgYW5kIHVtZW0p
Lg0KPiANCj4gVGhlIHRoaW5nIGlzIHRoYXQgb25jZSB5b3UgY29udmluY2UgeW91cnNlbGYgdGhh
dCBTSVcgc2hvdWxkIHVzZSBpYl91bWVtX2dldCgpLA0KPiB0aGUgc2FtZSBxdWVzdGlvbiB3aWxs
IGFyaXNlIGZvciBvdGhlciBwYXJ0cyBvZiB0aGlzIHBhdGNoIHdoZXJlDQo+IGliX3VtZW1fY2hl
Y2tfcmxpbWl0X21lbWxvY2soKSBpcyB1c2VkLg0KPiANCj4gQW5kIGlmIHdlIGVsaW1pbmF0ZSB0
aGVtIGFsbCwgdGhlcmUgd29uJ3QgYmUgYSBuZWVkIGZvciB0aGlzIG5ldyBBUEkgY2FsbCBhdCBh
bGwuDQo+IA0KPiBUaGFua3MNCj4NCg0KSGkhDQoNClNvLCBhcyBmb3IgMzEuMTAuMjAyMyBJIHN0
aWxsIHNlZSBzaXdfdW1lbV9nZXQoKSBjYWxsIHVzZWQgaW4NCmxpbnV4LXJkbWEgcmVwbyBpbiAi
Zm9yLW5leHQiIGJyYW5jaC4NCg0KQUZBSVUgdGhpcyBoZWxwZXIgY2FsbCBpcyB1c2VkIG9ubHkg
aW4gYSBzaW5nbGUgcGxhY2UgYW5kIGNvdWxkDQpwb3RlbnRpYWxseSBiZSByZXBsYWNlZCB3aXRo
IGliX3VtZW1fZ2V0KCkgYXMgTGVvbiBzdWdnZXN0cy4NCg0KQnV0IHNob3VsZCB3ZSBwZXJmb3Jt
IGl0IHJpZ2h0IGluc2lkZSB0aGlzIG1lbWxvY2sgaGVscGVyIHBhdGNoPw0KDQpJIGNhbiBzdWJt
aXQgbGF0ZXIgYW5vdGhlciBwYXRjaCB3aXRoIHNpd191bWVtX2dldCgpIHJlcGxhY2VkDQppZiBu
ZWNlc3NhcnkuDQoNCg0KPj4NCj4+IFRoYW5rcywNCj4+IEd1b3FpbmcNCg0K
