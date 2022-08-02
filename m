Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3373F587601
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 05:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiHBDf2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBDf1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 23:35:27 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4793A18A;
        Mon,  1 Aug 2022 20:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659411325; x=1690947325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x2nVMwLwMyiKSU07toKSa82p53zv4MSRtCfFRzAPFr0=;
  b=hCGpGg5Fh042nQ1wrjCrrCQd8ZBOfRuHLCifHFRfWAQfBCiDUzq6crR8
   92N9ohqW+VGLtgSDBdNgmPdt7GgHWNCxLyYb7u/fI1zfbyfJg85H8ZEDj
   k1kKkHC4tXXTk8RCOWree+MyCklSgbBIbn3Nn9igbNcO44rcC1Makk+hn
   pFFpUtPBVfIxFUBmyWEALdYDsaQsik8PfrPD7k/bkfD5UaxiJMA7QBsWa
   5U6qw6JR73CkHPVuSSbtr92yt0deHHoYzJ2C62QmjF5H+Hsq+TsatzMRX
   5CXuqRhQ6ztzgTkhjhEDrbyTAoyRL0JD7V2KwAQEQzK2szO+foHawF9Mw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="61984549"
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600"; 
   d="scan'208";a="61984549"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 12:35:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhEKLSrtHicIymARdqEug3aX8idOuXfNzIcUM9V86BHk3DvdNZKqv7S9+VjWCNqi6hlqmhCMVRqboBqtfTuFf6yRoCCExiydT6b4fuOtDnsocabVd9arszI2D6chtwQfu24qdRZFSgq6dsEk9TQFjXMue21Hv3wGCF8swceluY3aNFjqbkLnzuOskXgUeC2CfPeHrT7DU9ZUdMzZLr/OXzOsfN11gHn0vozN0FpHd1+mh3/6uJu/EMKmn2qcTwp/eTMiW9YCK9NVwQPJPsiYEIGYf/zohyh7QzNiHjlqfBVN+uo9HpkP+Gs98U+P6589uRZEbyHGZjBCdBWAurxxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2nVMwLwMyiKSU07toKSa82p53zv4MSRtCfFRzAPFr0=;
 b=m6fOCnyW08G4dLdeRXO0FLylKiWbvTK+P8m6AGTSeTya953jk3LHplUuyG0d5x5TAcTGkBtL5xytuSZ83cqyaWrzJGm3NtqvMV8nh4EplOHX0cdWS/ayKNyzRR4rmGdI7gWpoGitJVmG638R1xg/6r2SJJO9I8OYL6puryxNJQN1WpWItVLZjLuWQL8dpdMynddo3X9fsvwI3KtOp8K5pVtPU6W7n6POQ88r2z3uiHaDjDJaGek9FqbOvXMjgakUX6NHsctlRQzkxftj3ZMwLYfG3Eqld7AUC8atM6lOjGRVowUFhy/JJ4b4OWRhVbla//9/zJ58/7Rhdkog8Yyjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB4699.jpnprd01.prod.outlook.com (2603:1096:404:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Tue, 2 Aug
 2022 03:35:17 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 03:35:17 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Thread-Topic: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Thread-Index: AQHYpXEa1gfiqIZ17kGeFBg38tpahK2aQYGAgAC1UoA=
Date:   Tue, 2 Aug 2022 03:35:17 +0000
Message-ID: <c37397fc-f406-db4a-64db-294457384c40@fujitsu.com>
References: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
 <bb20de72-fc15-feb1-541a-91454593e043@acm.org>
In-Reply-To: <bb20de72-fc15-feb1-541a-91454593e043@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b21538f-d9db-4ddb-5085-08da743804b3
x-ms-traffictypediagnostic: TY2PR01MB4699:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LMs4qvb//XEWKwEi7lgegNOLAwujOJrDYaYBTlVan+J39pOC7FmXXECwv5Ru6YCate12EqZQ68vOkxm8Yx/aaR1QFmcbxvFaP9Wkk4m769hS6tRst+2CcdR4izy0ZkMwNNl8nSVHg9fhChk03qgqta+py2HdHmPL8bNsQu6YfmxIj3J0LE9l2GQU4dQM2JqeSHQvkto/hkIqGmolSuxM6RXum2R3BX7XsGcGhOF7Ba3zQlmBPzVT7708ylf1F0wXuRbBgSF7mi9eRSS3PD9fzmLjpTPVqeWtdjxTo8z5e0XSrnvi0tYsIh6iS7u9Sdj3am8T7NKPQFND1uzIubwDjtdN9jBkJ/CoOy5iZgdssOlEy9i10b0VWJoaUKXoTyTlXwG5JivYivTrB/lzTqjVaFDuob22VKgWU4fdhEfAh0yQ7/6iwfgFZ5FJ3yIPSc0NG+2tY9+9JcPvY4Yy6tSrxgUszazzThcUBYEMWKANNBo9dhCOvAC4fw3VX/MCHlattt9pmQJaTmbNealbCtkx+ouVDiCSc84S524vD+O0Apx2o+K7WbQ2i2YQqziIb3oErCy5MwWyB+W2K/uthMYpfQvJZAWmJuT3VbQPtgdMWquOyep4GYUx7HXaLyfOk9tQiHLJY9MD4TwUqdSZNUIi3ZcFIpcDSfHd8XSbEDTQjfzQwxu02sP2TEmaY8kRCVh81n0Q/o3SUWT05wAEIBNP+z5SfOkrdv55pXbFxNDNQocSDpqVqFyzBUQbqGzKbT4khnX1oJjf818jh9ZWFMC+02AeR2X3DtoogsxGFjlJgRlTBgpejULfz0V6LYk5pR0k/mmVvuOS+oXhdKuOGlgbgBHp3q00G0697pWabBlnRR+ncSsJesz9LB3CEW3tWvF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(36756003)(83380400001)(8676002)(85182001)(8936002)(31696002)(64756008)(5660300002)(76116006)(4326008)(2906002)(86362001)(38070700005)(2616005)(186003)(316002)(31686004)(110136005)(53546011)(6486002)(38100700002)(66946007)(91956017)(66556008)(66476007)(66446008)(478600001)(41300700001)(6506007)(6512007)(26005)(122000001)(71200400001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRMZG5FdytERW9QQTNWK0dheVhPWDhCM1hvaFlNV2traTRKRW1yV0JHcVp6?=
 =?utf-8?B?M2o2czVkRHVHQWNkKzFCVHByVkVNUlgybDRXZGtma0VjQ2xnWVFnTEdZYWNs?=
 =?utf-8?B?M1BvSXhCeVI1RS91enl3RzRqdy9qSGRpaUpSTW12czJLNWkvTlZnREtsVlJ1?=
 =?utf-8?B?ci9OUUFJZm1Fb0xjUUVGazg5cElsT1NCTWRFcVV5UHRrV256S3cyOXg0RUVp?=
 =?utf-8?B?L3RFcitCc0o0dUR0WThTZWExOW96VFBacUhkeWlUYVpnZlJaWTN3L0R4Vnoy?=
 =?utf-8?B?a1dYMmEyMzV4cGdpRVJVRWpFdTlJU2lTenJ1ZTdobEJKQWJKN082ekVZVjlH?=
 =?utf-8?B?M0NBQndyTzNXVWhCdWdtMmoybDlSdmZ0TWF5NS8wUEducjFTZWNveS83c1NG?=
 =?utf-8?B?WUNUdG9oMlhsSnlnQmtTalpNNTM0Z0ZOWFY1OUhxY2F4dFRSWWNUUS9UQVFS?=
 =?utf-8?B?bmlMQTZnMEV1V0piU2hMUUhrTVo5WjNUVjhjWVJodVBxQ20zWDR4cStXeC9L?=
 =?utf-8?B?RWV6ZXZhK2d1cG1wWmNaeXVBOGRwYkcrWmltUXlGZFhPMThJUkZmYnVHYnla?=
 =?utf-8?B?cDI3Qkl3U2F3V1lkZW1KK1VES3dXeldkY0hyU1pJU2pDd3F2QVhCZnlDMjdS?=
 =?utf-8?B?cHlwWUlsQnNpeXlKenROM2NXdVVWZmJYVnB2dlp6dzYvSSthODFWKzVsSUZE?=
 =?utf-8?B?R0h3Unl4bTZqSEZGQmN2Vll4SHB1MGtYN0ZUeUE2OTU2QnRLMUdZbWpDL0JL?=
 =?utf-8?B?SC9UVmxlM2xVWXQrbVluR1hMdXJ3NW9XTGQ2U01BRnNDS3M4N3B6MGc0Uk9T?=
 =?utf-8?B?NUZENEdqeE94dXBzTXpUVUdxZThiRHhCcUZ3Q0p1SlNkWDdXMmJwTmU0SXRQ?=
 =?utf-8?B?U2VYUmRFK3VZWVBXSDBJK2NsQjNsTTJDaGZFSTRkeVlkd002OGswVC9vT3lZ?=
 =?utf-8?B?NWlZbExpZjE0Q0ZjMVRJVDlCYXhiNGJsSHBHa3VTUlQ0L0h5TDBJMXVyYnZW?=
 =?utf-8?B?UTRMUUEybFJERlplRmFaM1ppb3dNbllsdDdWWk5uY2EzQTVUMDc5N1FGbnZs?=
 =?utf-8?B?NXlibTh3VTFVT29TM2FrSTNZbDlzY2UrVlFLcHhzSVBrZkpJZnJKQ2Q1ai9G?=
 =?utf-8?B?K2kyMXZCRWE3Q0RkYzdsK0hlalVjRm9IcTFyVEhoNnpudzV5alE4Q2hKQVZ3?=
 =?utf-8?B?Z0Fsd0p3eWlkanpSMW9md21DVWk0RVBwaFpmWmNNRDV0ejE4Q0dYWm41S1hB?=
 =?utf-8?B?MEpUZlNXczhnSzd6bnQ2TnM3UkczYStZMXIzSm00SzQ3S1lDclVOYU9VSzBX?=
 =?utf-8?B?Ym0vQXdyTVNlZ056UFRIcmhHV3prdzJKZ21raEFOaU1NVHJEYzhmSWh5QkF0?=
 =?utf-8?B?czZBL3JJWlN4NmlPV256Zms0ODRkNFY1U3ZMZ1JYbldRMUdQaDBhc0lxNjk2?=
 =?utf-8?B?c2U3d3ZaZmltVGJzY3kzWGV1SGhNQ1FEK3NRSTNUd2pla292K3hUWkxkeXEr?=
 =?utf-8?B?WjNLOTVYS1I2Q2ZEVVlrTlJadXhXUDIwcU1pQUJWY3lJYVUyeFZZTWhia0N2?=
 =?utf-8?B?VHlWVzhDdzQ2Mkc2RWtNZWJ6YUgyT05uODBTZW93L3hCMWZsSHJ5bzlEVlhI?=
 =?utf-8?B?eUpqUVF6Z0hhNG40YmdReGQxb2hWdHl6K1pZVXRXYi9hQjE4OEcwZDlzekI4?=
 =?utf-8?B?d1BlcDZxQzRLL1A4SDNvSDBpVHZVOW5yNWNnMFgyTzlPNVgrdVRVWGFvbjZn?=
 =?utf-8?B?RzJUYStSZ0p4YnZsVHVDZGpFN2pJRjdoaUdOQ3BDYlhCNHUrcjhhR1F3U2Nm?=
 =?utf-8?B?NCt6SGVseWVOaXZnMVF5K1BkU0tHYi95S3BjcjNPRjVxa0JLeko4NG00Nzht?=
 =?utf-8?B?Sk40MW50Wm84a3g0S0JPb1B3Nm9tbzZiWG5MOUFsOFhvc2huVlQyRExDRkZh?=
 =?utf-8?B?Yi8zaE8zNnhPZHoybkppU1dtK0tIYW1PeldZVVk2bmdJaW5vM0tpZWJTQlo5?=
 =?utf-8?B?L2d5emlJSWVQOWV1RzVTTXFVZHVCQWx6L0R1cFVOZjNQMUluS1BRNVZkc01w?=
 =?utf-8?B?QjJabncxdHN2Qy9BaVhFRG93ditHMTRlK2ZkQzJGS1JqNUtwVUZ1OWxkNmZY?=
 =?utf-8?B?MDRQYVp6c253Q0luNnN3QUlMbVZvSE5yOUdwaXZ4MkFMODRRYXhtUjBRUmtY?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15BA4D9D891A2A49B1E055A3CB134C31@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b21538f-d9db-4ddb-5085-08da743804b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 03:35:17.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01/Vh7ULXzDUhCNPYo8dnB71kU7bCnXqCYfmP3hM2afVDgfYBeh6iZzY+gb7p51R0H1iDbacvlZeZeYXq9DSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4699
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAyLzA4LzIwMjIgMDA6NDYsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy8z
MS8yMiAyMzo0MywgTGkgWmhpamlhbiB3cm90ZToNCj4+IEFsdGhvdWdoIHJkbWFfY21faWQgYW5k
IGliX2NtX2lkIHBhc3NpbmcgdG8gc3JwdF9jbV9yZXFfcmVjdigpIGFyZQ0KPj4gZXhjbHVzaXZl
IGN1cnJlbnRseSwgYWxsIG90aGVyIGNoZWNraW5nIGNvbmRpdGlvbiBhcmUgdXNpbmcgcmRtYV9j
bV9pZC4NCj4+IFNvIHVuaWZ5IHRoZSAnaWYnIGNvbmRpdGlvbiB0byBtYWtlIHRoZSBjb2RlIG1v
cmUgY2xlYXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJf
c3JwdC5jIHwgOCArKysrLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3VscC9zcnB0L2liX3NycHQuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0
LmMNCj4+IGluZGV4IGMzMDM2YWVhYzg5ZS4uMjFjYmUzMGQ1MjZmIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnB0L2liX3NycHQuYw0KPj4gKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL3VscC9zcnB0L2liX3NycHQuYw0KPj4gQEAgLTIyMTgsMTMgKzIyMTgsMTMgQEAg
c3RhdGljIGludCBzcnB0X2NtX3JlcV9yZWN2KHN0cnVjdCBzcnB0X2RldmljZSAqY29uc3Qgc2Rl
diwNCj4+IMKgwqDCoMKgwqAgY2gtPnp3X2NxZS5kb25lID0gc3JwdF96ZXJvbGVuZ3RoX3dyaXRl
X2RvbmU7DQo+PiDCoMKgwqDCoMKgIElOSVRfV09SSygmY2gtPnJlbGVhc2Vfd29yaywgc3JwdF9y
ZWxlYXNlX2NoYW5uZWxfd29yayk7DQo+PiDCoMKgwqDCoMKgIGNoLT5zcG9ydCA9IHNwb3J0Ow0K
Pj4gLcKgwqDCoCBpZiAoaWJfY21faWQpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBjaC0+aWJfY20u
Y21faWQgPSBpYl9jbV9pZDsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpYl9jbV9pZC0+Y29udGV4dCA9
IGNoOw0KPj4gLcKgwqDCoCB9IGVsc2Ugew0KPj4gK8KgwqDCoCBpZiAocmRtYV9jbV9pZCkgew0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNoLT51c2luZ19yZG1hX2NtID0gdHJ1ZTsNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBjaC0+cmRtYV9jbS5jbV9pZCA9IHJkbWFfY21faWQ7DQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmRtYV9jbV9pZC0+Y29udGV4dCA9IGNoOw0KPj4gK8KgwqDCoCB9IGVsc2Ug
ew0KPj4gK8KgwqDCoMKgwqDCoMKgIGNoLT5pYl9jbS5jbV9pZCA9IGliX2NtX2lkOw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGliX2NtX2lkLT5jb250ZXh0ID0gY2g7DQo+PiDCoMKgwqDCoMKgIH0NCj4+
IMKgwqDCoMKgwqAgLyoNCj4+IMKgwqDCoMKgwqDCoCAqIGNoLT5ycV9zaXplIHNob3VsZCBiZSBh
dCBsZWFzdCBhcyBsYXJnZSBhcyB0aGUgaW5pdGlhdG9yIHF1ZXVlDQo+DQo+IEFsdGhvdWdoIHRo
ZSBhYm92ZSBwYXRjaCBsb29rcyBmaW5lIHRvIG1lLCBJJ20gbm90IHN1cmUgdGhpcyBraW5kIG9m
IGNoYW5nZXMgc2hvdWxkIGJlIGNvbnNpZGVyZWQgYXMgdXNlZnVsIG9yIGFzIGNodXJuPw0KDQpK
dXN0IHdhbnQgdG8gbWFrZSBpdCBtb3JlIGNsZWFyIDopLiB5b3UgY2FuIHNlZSBiZWxvdyBjbGVh
bnVwIHBhdGgsIGl0J3MgY2hlY2tpbmcgcmRtYV9jbV9pZCBpbnN0ZWFkLg0KV2hlbiBpIGZpcnN0
IHNhdyB0aGVzZSBjb25kaXRpb25zLCBpIHdhcyBjb25mdXNlZCB1bnRpbCBpIHJlYWxpemVkIHJk
bWFfY21faWQgYW5kIGliX2NtX2lkIGFyZSBhbHdheXMgZXhjbHVzaXZlIGN1cnJlbnRseSBhZnRl
ciBsb29raW5nIGludG8gaXRzIGNhbGxlcnMNCg0KMjQ4MyBmcmVlX2NoOg0KMjQ4NMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJkbWFfY21faWQpDQoyNDg1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmRtYV9jbV9pZC0+Y29udGV4dCA9IE5VTEw7DQoyNDg2IGVsc2UNCjI0ODfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpYl9jbV9pZC0+Y29udGV4dCA9IE5VTEw7DQoyNDg4
IGtmcmVlKGNoKTsNCjI0ODnCoMKgwqDCoMKgwqDCoMKgIGNoID0gTlVMTDsNCjI0OTANCjI0OTHC
oMKgwqDCoMKgwqDCoMKgIFdBUk5fT05fT05DRShyZXQgPT0gMCk7DQoyNDkyDQoyNDkzIHJlamVj
dDoNCjI0OTTCoMKgwqDCoMKgwqDCoMKgIHByX2luZm8oIlJlamVjdGluZyBsb2dpbiB3aXRoIHJl
YXNvbiAlI3hcbiIsIGJlMzJfdG9fY3B1KHJlai0+cmVhc29uKSk7DQouLi4NCjI0OTkNCjI1MDDC
oMKgwqDCoMKgwqDCoMKgIGlmIChyZG1hX2NtX2lkKQ0KMjUwMcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJkbWFfcmVqZWN0KHJkbWFfY21faWQsIHJlaiwgc2l6ZW9mKCpyZWopLA0K
MjUwMiBJQl9DTV9SRUpfQ09OU1VNRVJfREVGSU5FRCk7DQoyNTAzIGVsc2UNCjI1MDTCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpYl9zZW5kX2NtX3JlaihpYl9jbV9pZCwgSUJfQ01f
UkVKX0NPTlNVTUVSX0RFRklORUQsIE5VTEwsIDAsDQoyNTA1wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVqLCBzaXplb2YoKnJl
aikpOw0KDQpUaGFua3MNClpoaWppYW4NCg0KPg0KPiBCYXJ0Lg0K
