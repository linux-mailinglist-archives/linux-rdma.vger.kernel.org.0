Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5359D0DC
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiHWFyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiHWFyX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 01:54:23 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5A4E63A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661234061; x=1692770061;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Th5rpw1RkUStmCGOUECQl2wxsJrAR1S+En8vAGBdTRU=;
  b=L1PpM8o81+98S9xwpwd9bb/UuUmuHKjq4Q7qsU0+OMFqgZAks6Rg0iZn
   b+UuaWYfK7EsKXqQVfprAzJqLALW3+6IKnaKAZu+VfKZu8UpzH9gMNXk8
   WJonmxl2WkRCzJX+M+n2OhKftdJq2qj204gmfHuoPxG0oHtE/ZxfMJOQj
   BqNGvqu0tpuy1FLzMioJhuTihNrN/aXmmIDhQ0hQ8Mhn8aVDlXkusjxyI
   HxiSzwuEUATez7dMWG1DvJGxreMjChGPMTcx+mF+ucPm6Z3iF/Jj+soZ/
   JacKVW8xDOZjNG1TbzcIL1CKnogvW/nfSlLQXOZb9O/3qSqaifZC2S3mu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63430883"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; 
   d="scan'208";a="63430883"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:54:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjI8W7ektm6255iLugU0+uOvREX0LIQ/7ul+YNh/b+nw+wGGIs1KajmrN2fkBXn1U6wUiaZfm6kgSSvfA6GMX8yKilaHxqfTuuyTPKVQSDMe4FC2UM62imUqLvEtL+MJyuMeVw1sDcln53maYnyKWsCvdqiz38HP5ltz+4XXCWzvV4IE2t6E9i2q3uLuEZgUeaWY8YwUcXihXAbfKiqWgsWpt7KGpl84wctKuSTxPBOFsqVqEzMIbe0u8EYo0dzia/v+NoGR+bVCcQXMaUQQ38JYinunsxKiwNIZovgYam9iqeJOsHQQRapOzYPaoDI1LHJkqRpVcz/kqk5BNlFgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th5rpw1RkUStmCGOUECQl2wxsJrAR1S+En8vAGBdTRU=;
 b=IqOc2Zc82iBUUBGv26Ca46w1B+MryGou47SJsVViZbZ4S/u9AXjOKnF2CDwDBftzL87Hnjc9+YtA0HUNAnxmr87F5eCnxB6WtOa+zCrWc9btDnugtmvEumQuMQH8OSLwc172GTpFQJ+i2ygdEBu8vsyHLDqcVo0OnHcrqpyQCXZZuwxXFnCQFHOR7Rq7JcUuHalM2Bij7Er6UOTIV9ElWA9yKJ066/VZpffYu46dvP7+iO4u3IsCuF0fCbIh+jWWwxgRKsxc0wb786/NEUAx/gAKJSoZ8MKgx5MqIoEWO8tiUbCaQVDLaeFmUtRli0jyhjjdyMAiLN+PwFoJ6i6TSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY3PR01MB9948.jpnprd01.prod.outlook.com (2603:1096:400:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 05:54:12 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6%9]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 05:54:12 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 3/3] RDMA/rxe: Remove the unused variable obj
Thread-Topic: [PATCH 3/3] RDMA/rxe: Remove the unused variable obj
Thread-Index: AQHYtTruKetOVwRZPEa1JEnXSR4dDa27SjqAgAC0rAA=
Date:   Tue, 23 Aug 2022 05:54:12 +0000
Message-ID: <b04ba2a2-e075-cbc9-331f-37f693d932a8@fujitsu.com>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-4-yanjun.zhu@linux.dev>
 <8d5fb124-c2fc-c191-3786-a243977774a8@gmail.com>
In-Reply-To: <8d5fb124-c2fc-c191-3786-a243977774a8@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33047a41-0d89-4f48-6add-08da84cbe7a2
x-ms-traffictypediagnostic: TY3PR01MB9948:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2B1P5V69vzRFI5BBTCyWwZ+NJ9VzEyZMciSJwadlGRFZRVNZIegW/Lgw2JryPYPmi2/k8Smt2QfzkmQpuSpU5tWMtVHDGL5sLgf4n6N7flXxtEFBjzXvBH64fY4QlJyJAPa8JTX7h8Ycq2OdN3L6VHufYOJXyAxxlgJWFMw9IkirBMNYuDtf8R+IKiLYR2rvMDPMIc/R07wLE9fu846VvyB4NPlaek1H1lp1rIIqOReyoWZQ7WOp+jt6LRfh775Ki198+Sb74cy2lbBaEH+9XeJcTocOR5Hr1Oo6OHYm3rSohnHaIYhM9VOR+bsuBMij20UtUyqGpijRvs4NTgv/O5dja6jQD/s9dB9ofJ9OH5g3eLmxBRpuQ5M0q7PxjsTzzkq6Fw2tVAgiQRsUMuR177pNvdFqrksBnGMbr+scGnWi5W72oD9HDq2we8WhLRzmAcaHcOTrLMU0I/nJL+9PTXb4LlICrwo5llqRF5DIsUPWLUqlnNxDKwas4ibiDEC9JjmVSt8GWBTdVGzMxt5LMyF8LaidAlqunKIb4bX0FLyOWsjEJbJhSJSVwO9qjF14vFQSUmxtYzh4k1k9/2st5g9T8BkA/IueEZA23fqY2NXBaE/XMeFjZvxGGEiv6j7+ofer2CYSH5Nxt1psHu4S5km9wtJHNbMrverFKm3nveSH8U7qG0PmII8zJ74Y/RNvLy5E122gSyY5Gg1J0x0fHnHodLAULj/+ln/tsob3MbSnSmkCZueCVWPRUZvCI5kOoItYfH4q3pGsV9CRePRP9wNQje96fY4XcBY58HCX2Y5rVmUrBaRljBz7DbcHZ6uVTt0bjHyZwMJ1PVEQZfyJwxNoJcA73FaOzedIOfkxx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(1590799006)(41300700001)(6506007)(53546011)(26005)(86362001)(31696002)(85182001)(38070700005)(82960400001)(83380400001)(1580799003)(31686004)(36756003)(2616005)(186003)(478600001)(6486002)(6512007)(71200400001)(66946007)(110136005)(76116006)(66446008)(64756008)(8676002)(316002)(91956017)(66556008)(66476007)(38100700002)(5660300002)(8936002)(122000001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXR5M0s0aDl1SW5MTndRZXBXa0lmZGk2ZmxwNklqWUV0alBWQmJ3SzAweFVP?=
 =?utf-8?B?UHVhU0p2R0k4VXVJcEVWWVp5Tk5mMjhEdTRYTElxdTNlaVFyYjNoRmhHSllt?=
 =?utf-8?B?cS9CdVR4cytsNTVGaXg1b3d1S0czcUhUN1lqNXF5cUNBcUpTUGpvUXdEZGk4?=
 =?utf-8?B?cEtEekdPR3JVWHpHZit3aUd0TVN6dS84S0JBMmtFNlk1dExFcEhXRWMrbXRK?=
 =?utf-8?B?bDlmd2tMblVCTUJWNzdnY2RTU3ZnWXlBUnFOem1UQmRNUmNnaHFlWE51UnRU?=
 =?utf-8?B?a3cvT1JzQ0hLZ1RYV1lKSXhmNXd0dGw5R0hSbHlON0Z6TzR2V1VSZ2JhSjRO?=
 =?utf-8?B?dTlyQ1FMUWFyVERzR3UwSFhWU1pGU2dwS0ZWMFNhU1NoYngzTDdHV2o1UVNX?=
 =?utf-8?B?OVVQSHRwMzdKY2JMaThhVi84WDNGajVGUytkbmtNdm16ZHB0dFNOM05UbG5T?=
 =?utf-8?B?cVpZMkhRQ1U0bGp3V3lLemdwVTFuSjE4Z3F5Qmd3NTVtbzlBU3hyeFIyVHZ3?=
 =?utf-8?B?Vnk0RWliMU50Tk5TTXYzaUZFODVLcnNBZk8vdEM0VnNHelJnalVnTTMzM2hO?=
 =?utf-8?B?R2EyMmVxZW1lRWI5bzRYcFgwenA2TFI2T0JWb2o1K3lDSnJobE51MXl4em85?=
 =?utf-8?B?Q0daRDhNVnN1NU1KdmtjT0F3SzJiNGJKVklWcCsvekU3RmFTWGs3ZXRLMWVw?=
 =?utf-8?B?Y0pLbDZSbHIrNm4zM1F6ZzNBSE9uNVViOTM3UHl6dzZUOGtCUVRhUExMcElI?=
 =?utf-8?B?VGZ6UkJkNzRMeXhScU5QOGdqRGJuc0grbGVzZG5SbnMvT0JxN1NFY3o3OURI?=
 =?utf-8?B?MnM1TFh0eHptUWx0b1N0WkZGM2VrVndWQUNaMzBzOStXUk53SGEzSTB0dkVn?=
 =?utf-8?B?enVOZytrSGxyTDk4clFBOHRPekxxZXo1OHgyd3hOU0xGd3VQZ0Q5QzdDaXFp?=
 =?utf-8?B?aVZjVEY4MExGQ3Z4VXpvZWlrSWNxVTc1KzUxWmpEZHZJVGtqK3hGSUpNNFdN?=
 =?utf-8?B?ZUF4TGEzQjlxV1NZN3NqL2p4dWdYVnpHWUo4QmkzcjhYMnEwOHFIa1JoazBk?=
 =?utf-8?B?bjg2VHhyWkJCdi9QbU1rUGFVZ25sckc5N3Z6MkJxYi9lSUlaMkxjcUZ5bmpp?=
 =?utf-8?B?S2ExdkQ2RDJEQVdtRW0wQmJBZ2dHMTNRMzFsZDdRTkVvRm00TFIzNnFLaFQw?=
 =?utf-8?B?VGZTVUtQc2dZbDkzaVQraHVpWGpTcis5RGFBRk9kcHJxMTRiRHJwa2ZxTFJU?=
 =?utf-8?B?dWNSM043Mzc4Wm1aaTRrZGgvN2xQYTV0QjZJNXB2K3ZTUWx6VXEwYUU4cHl4?=
 =?utf-8?B?dE52cy94WHRrSTQ2U3pGOWgxNUtMc1NYRUxoZlNGa1F0clY3Z2hzWDNUc25m?=
 =?utf-8?B?cXF1alFaZ1NQcTVNWUZBaXRYSmJkcjkwTVJiTDRJS2NyQWFRYjc0QTFIY0Nx?=
 =?utf-8?B?RTRoQmRyUUY4dDdLa2U1QWhZQ1ptZDkvcVRERlFvV1h1WHIyOXp0UHNML0FM?=
 =?utf-8?B?aXE5ZEx3clNXeWhBRFBINUVpaDBQZHorSWZmWEsvWVVIODV4eVBsSVJ0TXVj?=
 =?utf-8?B?ZUlXR09RME9HellOWCt6Q05hTy8vOWN3WXlRRlZjdGVvRFZsMTI4alFjMUFz?=
 =?utf-8?B?SWFXakRWTW8vb2tLd3R5Wm5PeHRJamhSK0N2VFEvRlFaNHFQVFVaVG8zSUxt?=
 =?utf-8?B?WEpCbzdWZGNoOUR3SEhGN0lydnl4eDVOMVdpbmsxNnhTQ01KOU51dUZ1UE9w?=
 =?utf-8?B?L0tKZVhTOTZzbWJLU0M5ZGNYc0hMZUFWK2VvakZicmF4ZXJMUDQ1OFFrdUxp?=
 =?utf-8?B?QXJRMlFLTkgwU3ZNaW94dkU3czlxOXJFb2haWXV0NFNveWR3TjludWIvREFt?=
 =?utf-8?B?OXlHa1dVdy94UU00eTl6QXBHdkxDS201NDRlWTVvVGl2bU1aS1htVkwzOHJa?=
 =?utf-8?B?KzVHR1hPOEpTQlB6b1VVN2JGa3dJQlN5WFdwdlMwS3dZdkdKbTFQZ1l1bXM1?=
 =?utf-8?B?UENMWXBnSk1JQVNtblZuaXBGMW9kN01VV0JjWVd2NjN6UjBrU3Q5Z0d2em5t?=
 =?utf-8?B?Mzd2MVhvOENZc0lZOG1xS2ZwWTRXdHEyK0U3cWhQQlphN1FLYXloVHBUaTc5?=
 =?utf-8?B?TURUb3oralFtS1ZyT2lhbmsxaVlveXBCVUhKOXBCQW5LRUNvQk8xSWtrWmZL?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96593592BC8B3140940627B16056CBDB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33047a41-0d89-4f48-6add-08da84cbe7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:54:12.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSnnxJ3hYUZopbkKwSKQn62PlXTlETuyIdSn0LO0zFz93b9MigoHrI2SOqpxl0zxvCieDBL1qk8tDpS4pg29EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9948
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjIgMDM6MDYsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA4LzIxLzIy
IDIwOjE2LCB5YW5qdW4uemh1QGxpbnV4LmRldiB3cm90ZToNCj4+IEZyb206IFpodSBZYW5qdW4g
PHlhbmp1bi56aHVAbGludXguZGV2Pg0KPj4NCj4+IFRoZSBtZW1iZXIgdmFyaWFibGUgb2JqIGlu
IHN0cnVjdCByeGVfdGFzayBpcyBub3QgbmVlZGVkLg0KPj4gU28gcmVtb3ZlIGl0IHRvIHNhdmUg
bWVtb3J5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGlu
dXguZGV2Pg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KDQoNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jICAg
fCA2ICsrKy0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMgfCAz
ICstLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmggfCAzICstLQ0K
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCj4+IGluZGV4IGIyMjkwNTJhZTkxYS4u
ZWU0ZjdhNGE3ZTAxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcXAuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPj4g
QEAgLTI0Miw5ICsyNDIsOSBAQCBzdGF0aWMgaW50IHJ4ZV9xcF9pbml0X3JlcShzdHJ1Y3Qgcnhl
X2RldiAqcnhlLCBzdHJ1Y3QgcnhlX3FwICpxcCwNCj4+ICAgDQo+PiAgIAlza2JfcXVldWVfaGVh
ZF9pbml0KCZxcC0+cmVxX3BrdHMpOw0KPj4gICANCj4+IC0JcnhlX2luaXRfdGFzayhyeGUsICZx
cC0+cmVxLnRhc2ssIHFwLA0KPj4gKwlyeGVfaW5pdF90YXNrKCZxcC0+cmVxLnRhc2ssIHFwLA0K
Pj4gICAJCSAgICAgIHJ4ZV9yZXF1ZXN0ZXIsICJyZXEiKTsNCj4+IC0JcnhlX2luaXRfdGFzayhy
eGUsICZxcC0+Y29tcC50YXNrLCBxcCwNCj4+ICsJcnhlX2luaXRfdGFzaygmcXAtPmNvbXAudGFz
aywgcXAsDQo+PiAgIAkJICAgICAgcnhlX2NvbXBsZXRlciwgImNvbXAiKTsNCj4+ICAgDQo+PiAg
IAlxcC0+cXBfdGltZW91dF9qaWZmaWVzID0gMDsgLyogQ2FuJ3QgYmUgc2V0IGZvciBVRC9VQyBp
biBtb2RpZnlfcXAgKi8NCj4+IEBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGljIGludCByeGVfcXBf
aW5pdF9yZXNwKHN0cnVjdCByeGVfZGV2ICpyeGUsIHN0cnVjdCByeGVfcXAgKnFwLA0KPj4gICAN
Cj4+ICAgCXNrYl9xdWV1ZV9oZWFkX2luaXQoJnFwLT5yZXNwX3BrdHMpOw0KPj4gICANCj4+IC0J
cnhlX2luaXRfdGFzayhyeGUsICZxcC0+cmVzcC50YXNrLCBxcCwNCj4+ICsJcnhlX2luaXRfdGFz
aygmcXAtPnJlc3AudGFzaywgcXAsDQo+PiAgIAkJICAgICAgcnhlX3Jlc3BvbmRlciwgInJlc3Ai
KTsNCj4+ICAgDQo+PiAgIAlxcC0+cmVzcC5vcGNvZGUJCT0gT1BDT0RFX05PTkU7DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jIGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jDQo+PiBpbmRleCAyMjQ4Y2YzM2Q3NzYuLmVjMmI3
ZGUxYzQ5NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rh
c2suYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jDQo+PiBA
QCAtOTQsMTAgKzk0LDkgQEAgdm9pZCByeGVfZG9fdGFzayhzdHJ1Y3QgdGFza2xldF9zdHJ1Y3Qg
KnQpDQo+PiAgIAl0YXNrLT5yZXQgPSByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiAtaW50IHJ4ZV9p
bml0X3Rhc2sodm9pZCAqb2JqLCBzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2ssDQo+PiAraW50IHJ4ZV9p
bml0X3Rhc2soc3RydWN0IHJ4ZV90YXNrICp0YXNrLA0KPj4gICAJCSAgdm9pZCAqYXJnLCBpbnQg
KCpmdW5jKSh2b2lkICopLCBjaGFyICpuYW1lKQ0KPj4gICB7DQo+PiAtCXRhc2stPm9iagk9IG9i
ajsNCj4+ICAgCXRhc2stPmFyZwk9IGFyZzsNCj4+ICAgCXRhc2stPmZ1bmMJPSBmdW5jOw0KPj4g
ICAJc25wcmludGYodGFzay0+bmFtZSwgc2l6ZW9mKHRhc2stPm5hbWUpLCAiJXMiLCBuYW1lKTsN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmggYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmgNCj4+IGluZGV4IDExZDE4M2ZkMzMz
OC4uN2Y2MTJhMWM2OGE3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfdGFzay5oDQo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNr
LmgNCj4+IEBAIC0xOSw3ICsxOSw2IEBAIGVudW0gew0KPj4gICAgKiBjYWxsZWQgYWdhaW4uDQo+
PiAgICAqLw0KPj4gICBzdHJ1Y3QgcnhlX3Rhc2sgew0KPj4gLQl2b2lkCQkJKm9iajsNCj4+ICAg
CXN0cnVjdCB0YXNrbGV0X3N0cnVjdAl0YXNrbGV0Ow0KPj4gICAJaW50CQkJc3RhdGU7DQo+PiAg
IAlzcGlubG9ja190CQlzdGF0ZV9sb2NrOyAvKiBzcGlubG9jayBmb3IgdGFzayBzdGF0ZSAqLw0K
Pj4gQEAgLTM1LDcgKzM0LDcgQEAgc3RydWN0IHJ4ZV90YXNrIHsNCj4+ICAgICoJYXJnICA9PiBw
YXJhbWV0ZXIgdG8gcGFzcyB0byBmY24NCj4+ICAgICoJZnVuYyA9PiBmdW5jdGlvbiB0byBjYWxs
IHVudGlsIGl0IHJldHVybnMgIT0gMA0KPj4gICAgKi8NCj4+IC1pbnQgcnhlX2luaXRfdGFzayh2
b2lkICpvYmosIHN0cnVjdCByeGVfdGFzayAqdGFzaywNCj4+ICtpbnQgcnhlX2luaXRfdGFzayhz
dHJ1Y3QgcnhlX3Rhc2sgKnRhc2ssDQo+PiAgIAkJICB2b2lkICphcmcsIGludCAoKmZ1bmMpKHZv
aWQgKiksIGNoYXIgKm5hbWUpOw0KPj4gICANCj4+ICAgLyogY2xlYW51cCB0YXNrICovDQo+IExv
b2tzIE9LIHRvIG1lLiBOb3Qgc3VyZSB3aHkgdGhhdCB3YXMgZXZlciB0aGVyZS4NCj4NCj4gUmV2
aWV3ZWQtYnk6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo=
