Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC757D83C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGVCKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 22:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVCKQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 22:10:16 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E0115801
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658455816; x=1689991816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xSIUovnzkavpNxwvHESYigyt4y9kwobnj48hSG0kTJk=;
  b=DhHMDGTZStIv9aFSa6Q40f41NMuUhaY0F25YqyEoPcD+3mkXim6Y399e
   kVOwkEbpKtZqcJSJBMabWgEOekftNi47aRFULywMgxKQTSxh/NpRKIEs/
   cSRAT0EgI0rLmE/Fk+atCyabARMtNuYPofhuRANkIWsETbdsGrjtKOjyT
   iu+9rEtAm55C9lZFSx/jAJ9LS4X2s0OeI7mr6oSTU9/Gxl2M48UHCODyo
   Je3F6G2y+NqPI3ZCxzfqySqQXg8ejCv4AVxft/MKjV2q+ctmuNGt6LVXk
   1oIFnD1RdfWtcW4idblByTiJCbG1GsWgnz/tGT8KZbSbCpSYMYdYJqjcw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="69175654"
X-IronPort-AV: E=Sophos;i="5.93,184,1654527600"; 
   d="scan'208";a="69175654"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 11:10:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emx5DOD2+gIdLgDCt9KBLC7LLl1XyAYJxukd9LjQ2JIDoujQ0Be6wxTezHGXQSD/UcxGP7St8HsEqj3EheqybWGly1gPHL5IHjOE23wUmEJU16/MTFg7BgKjnVvxDkvoIEmKpMctXUK9c1/k0Z4jdqC9vnGEt9jBKJiLBdZoHN194VRfG8CX3Yq0gmw2Vu/Cr9bt4S8sZG9MpNd/QGCHd6GqkXIIDcKIiU9zovXzkp6ljN4awptLwKK+vgqhsP8scxQqkDiHbQSN+SXNAMJUoyrIu19toeBYmSbvlCvXzJu1LIIqn5TCfj1IriJCWYjiMisCNbhVLUjg21DZ+33fzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSIUovnzkavpNxwvHESYigyt4y9kwobnj48hSG0kTJk=;
 b=Y/4pKsjpO4M9BM6r89MWw4T6neW/aGinMg8c5N1H6YkgXcdZatEzuSJQTMnrcp1+NfDriayRYjt7mBaz1lIYic6AVEsfJOrVbIL9QizkSenve8l6CLch6jbm68X3YaPZiTPPGZoOc6CzorGiWsQBNLW2sbeUx3QJp28zUvQ1QClpJqAoHnIy5EHW1AHfrrVAo9dnXmz1er4m9g3j7Ons5D7G/SmKEGYZwtig1NGTd8awlehxtSntOW5BQgFPh/yfrwtgPoKS9Y+PcTvjskycDV8q/oU5Wri8W5G/kFVwGWsS0Xy85DecNCQOlFMo6qoHQO6FwllD8/s7Q/adyAgiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB7600.jpnprd01.prod.outlook.com (2603:1096:604:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 02:10:09 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 02:10:09 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "leon@kernel.org" <leon@kernel.org>,
        "jgg@mellanox.com" <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] tests/test_mr.py: make cases description unique
Thread-Topic: [PATCH rdma-core] tests/test_mr.py: make cases description
 unique
Thread-Index: AQHYmC+EC+JNR3zngkKZ6EX5K66rPa2Jr/SA
Date:   Fri, 22 Jul 2022 02:10:09 +0000
Message-ID: <0ddbea16-2426-45e4-efea-af9965e40c8a@fujitsu.com>
References: <20220715095117.1902874-1-lizhijian@fujitsu.com>
In-Reply-To: <20220715095117.1902874-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28e37437-01c8-4a1e-b5ed-08da6b874db9
x-ms-traffictypediagnostic: OS3PR01MB7600:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVWgDFTbbOwE9w75kgwVK5/iHLxWxmKIp2rdQkR7iJWLeywiqWV6nqWxPpW/dPegfV5j45gqpvci5aKR3e5x8B+Vu++14C7iS7L7JOREieYX5kOuXjQDgywu9U6lqWU1Ybhj0ZNC8XCHQGDTfpJZQtu4EUbIj4Uazh+KExhUoMxiDN8OkZ4pycFc69VymqAsqoy7LLczEpJK2FVhyftW52WAlD2MQFMxgUTMM1JwgHtK2n7KrjWFPd6k0FV1dhT7QD9WRp/RRbPSyZxPQu3gJeIQks+LOUdu2HlGobkpMqVjV9NrTqi1eMtg1QnGNS+2AGCyW6hmEEhmGZbb2nc9B23GV1OlW7nIvta+eSVZ4hM9sTyrpKij4CtNKppzmvf2Af0E1TtRoBGhzo3j5aAz/xmiPe0EHFn6scuHLjNjQLt9T9C4yw+fc56tRd8MdM+5U6GTJYeURNDVgvRVfM2vSqKit/h4fzKrwvCj5P9Q8MNjDxUOqn1kMX64YKx473OAuitL+TV6MWgXeQ13pFDRfqJL2gZOrR8ON4vVo/ZCYRVKKqHsa5u1ieTkNK8TgzZZ334CrA9wC9QqR05MjbEm9aKgojO4tg7O8yQu7k3TfIhFlGFuyL9qozp7iM+TYj68I1dAbLFb+iteyob2iNkHSjf+U/YtLEmO2gserumWwTqTrwlZg+vZCESDJocyXTFQp4hDTWcj2Ml7Z/PuHuLpI3AACJh7HcntntJ/H2+0TF3j7xIn5Dxg4xmECSPTUdvJVryctkp5mXhiErAQXUAcV5ES1uA8o/3xxDKABPBUIGoLAAl5cvWey2f0yInceLTmYGcC/xth3+9cFbOAAQLqgTkz2+59UqCAvrZgXgHGOoOvlx0Wg3NYJi6LX3AmiXkfePuxd3el16tF3cqsqdVX6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(83380400001)(186003)(122000001)(2616005)(66446008)(316002)(64756008)(66946007)(38100700002)(76116006)(91956017)(8936002)(5660300002)(66476007)(478600001)(26005)(31686004)(4326008)(6486002)(8676002)(41300700001)(71200400001)(82960400001)(66556008)(6512007)(966005)(53546011)(110136005)(2906002)(6506007)(31696002)(85182001)(36756003)(86362001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdycFZHRndRamIrbDljR2RYTUt3T2p0M1dnakh1M0hjSm91YzJ3UllTMnZ3?=
 =?utf-8?B?eVBYU01rYkhmbDlDQzh4c0k0UmNDdjRZQWNxc3hwMVBEbVRVZzFKNURGcXBm?=
 =?utf-8?B?VGpRalRzaEVSTWZrSTJIM0l3UUxBYy8vK2lwdUR5MWtHVHFaT2RDWnljUzNy?=
 =?utf-8?B?YTk2ZjdnSGFDU3o0NTRySC9CelFNVlk0WWF3cU5yZXFUNW1TKzJISEl1S3FR?=
 =?utf-8?B?ZnRZTzZlZnN5RFZkc1Ftd0xkZTBoSHZJMnhSV3dDSHgvL0t1bFdvUUVkSnlW?=
 =?utf-8?B?SG5oNFJ3Z0V5RXV4eVc1bDEyU2w4TWhsc0xYYWRJVDZyUittbmphYWJPWEZP?=
 =?utf-8?B?dUsrZGtlb0llTWdaQ2thMWFyaXIybzJ2WXhCVW1qYmtEV1kyVHJRT1B4ZGRF?=
 =?utf-8?B?QnpkSGZDN2lsZUo5Q3paeXBQZDcwcjVnWGRMdk80TUdHWDYyVEVqR0FrdnBJ?=
 =?utf-8?B?U2loSHdsZFV1dzVRNTA5dEJPWXBaQmNFd0haUERxb00vMzRTWDhSYzMweHlj?=
 =?utf-8?B?NkR1NVh4QWdjM0VqNytRUVlaYUYycGNEOGpaeUIxNmVBWGx1bTdhSEpJUkR0?=
 =?utf-8?B?aGkweUJwN21tWi9vMm9HVjBkUWl1K2o5VTYvaTRIbCs2RkE4SFZudHZTYkpm?=
 =?utf-8?B?MUhtMGhyYUNqL0x5UG1ISkY4cVY5Skk2SHR0dExYK04vMjljb0R5VGM2bm1G?=
 =?utf-8?B?SVZlb0tYc3pONVJuaVFSTURRMVVVc21RWWZZb0lPZXdPa0ZoYmdtU3pWRnp1?=
 =?utf-8?B?VExXSENmS0Yxc2dtWnJCbXMvS0RYcGQvbTFWRkdvK2VCOEsxYUFVSU8waG53?=
 =?utf-8?B?RlJGRHoxSXk2Y3dubVVaUkh1OTBJRk5KNGhoT0NkUEFENHo5Ri8zalBuQ2N3?=
 =?utf-8?B?aDdHZi9mOTdJSW52Q24wbFpmN2c5SjdkTU4yaEQ4c2UxaVhMZDk5YXFFdTha?=
 =?utf-8?B?Ymc0SE5QSVhQaXNnYzE5NnVaUEhnM0ZieVRKYmxGZDg4cG85ZTlsMG9GbmlO?=
 =?utf-8?B?MlZwMXV3eUwwTCtGKysrZVJOeU5JQmdObFlEVENZbmxvN3pvOGZuQmRrN28z?=
 =?utf-8?B?MEJWT29kMTA5NE9nRXNlTnpBd2FsK3FNZitNd2RObkVhREZwd1J0NHdoa3Jq?=
 =?utf-8?B?K1VBdk0yVGViU1o0NDQwdm1PUFpPVDJVNkNMb251OXBvQm1NcGR5dFRmdGRI?=
 =?utf-8?B?UzNCdzI3SktvdlowL0RReG84d2RnbFcxK2Q4Mit5Q21CdS9hMW4xaEZpN2hZ?=
 =?utf-8?B?Zkx3NjlSeVVyOSt6S3phd1JUTUVrVmxsSUgwaVR3bFlKY0h2TGJNdjZPTVA0?=
 =?utf-8?B?U0FLN1JvaVpXcGlzNDhST3JkR0tDVjk3Skh0VVRkOGJyTURqVmhkNnNJbEp3?=
 =?utf-8?B?c0hFZmw1MTBoeCtxemJLQysxcTZuZVg1WlorVXRXK0ZYWWRaYzVzaHRJZWdu?=
 =?utf-8?B?dERJRU84Zy9WOFdkbVkxOXZVOGppY285TE5icEoyZ2hYMzNlZXNrRmNPSktF?=
 =?utf-8?B?dWY0MXNDN1luU282VThwZTZyQ2lwbFUyTjhNNitFQ2F6NTBKNUVTN0ltM2Zj?=
 =?utf-8?B?anNsOTBEZkVpT01tQldnZVA3OGk3QS9pUVdqd25JUUJXOWxhMmtKWG9nbXc3?=
 =?utf-8?B?VWh5aUpjWHora082T050RjdmSDY4OE9VRWhNU1RLdkp6blhEMjZVcE9sQm9E?=
 =?utf-8?B?bjFyRndHU1JrU0JJU2xMZ2dXNDdSdmVCeUc5UStSYUZrQTFDUHdmNzZRQWJW?=
 =?utf-8?B?dnBMdzhLRDVsSG1MUGp5UWtJL3hWSUhEMFp5aDFKWTVlZURxOTlOcFhYK3pK?=
 =?utf-8?B?Y0t6bGFTR0IxVWZmZDdIWC9vdGxjd1FzNHdGbjZ6YWF0L0ZHTncwekVSUmho?=
 =?utf-8?B?eUwzTndZYzVZM0VQUUVnckRSMEFRMC9FL05kVkJJc1BOMjNkUHhHbDVkNk5G?=
 =?utf-8?B?QnROa2llK2pod3ZSN1BkcXlpV2QvS3dkWnNkZ2ptWGZaTEhHdzlwYzN6VGFm?=
 =?utf-8?B?SkcvRzd1L3MwbzR1VWt1Tk9lZTN5T0dzN21jaFNBNWVTZENSWjdQNGNkakFZ?=
 =?utf-8?B?UXRzSnk0R1JnUmVNWWczeUJXcFFQTlhKZjh5Q3N2WENaTEMrVS83dXZ3QzUr?=
 =?utf-8?B?YU1ab3dmcGR5aGlicFVPYjJZRDV4MXprSWFSRjN5SlZOV1Jza1JxMVJqUlgz?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A032F96C59A8B49B44372982BD6078D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e37437-01c8-4a1e-b5ed-08da6b874db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 02:10:09.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgfNID2/PzGSJhvX9w3epaz2r94vBybcub+OqGwZewVvCYcei5lWg22gzDQ1aaXYIpKyGdj6WYieg3WQp6MZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U2luY2UgZm9ybWF0IG9mIHRoaXMgcGF0Y2ggaXMgbWFuZ2xlZCzCoCBzdWJtaXQgYSBQUiBpbnN0
ZWFkDQpodHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvcHVsbC8xMjAwDQoN
Ck9uIDE1LzA3LzIwMjIgMTc6NDQsIExpLCBaaGlqaWFuL+adjiDmmbrlnZogd3JvdGU6DQo+IFty
b290QHJkbWEtc2VydmVyIHJkbWEtY29yZV0jIGdpdCBncmVwICdWZXJpZnkgdGhhdCBpbGxlZ2Fs
IGZsYWdzIGNvbWJpbmF0aW9uIGZhaWxzIGFzIGV4cGVjdGVkJw0KPiB0ZXN0cy90ZXN0X21yLnB5
OiAgICAgICAgVmVyaWZ5IHRoYXQgaWxsZWdhbCBmbGFncyBjb21iaW5hdGlvbiBmYWlscyBhcyBl
eHBlY3RlZA0KPiB0ZXN0cy90ZXN0X21yLnB5OiAgICAgICAgVmVyaWZ5IHRoYXQgaWxsZWdhbCBm
bGFncyBjb21iaW5hdGlvbiBmYWlscyBhcyBleHBlY3RlZA0KPg0KPiBUaGlzIGRlc2NyaXB0aW9u
IHdpbGwgYmUgcHJpbnRlZCBpZiB2ZXJib3NlIGlzIG9uLg0KPg0KPiBJJ20gZ29pbmcgdG8gYWRk
IHB5dmVyYnMgdGVzdHMgdG8gdGhlIExLUCBDSSwgdW5pcXVlIGRlc2NyaXB0aW9uIGNhbiBoZWxw
DQo+IExLUCB0byBkaXN0aW5ndWlzaCB0aGUgY2FzZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy90ZXN0X21y
LnB5IHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGVzdF9tci5weSBiL3Rlc3RzL3Rlc3RfbXIu
cHkNCj4gaW5kZXggM2VjMWZiM2YzMmU4Li5iODE1OWU0Y2E1MDQgMTAwNjQ0DQo+IC0tLSBhL3Rl
c3RzL3Rlc3RfbXIucHkNCj4gKysrIGIvdGVzdHMvdGVzdF9tci5weQ0KPiBAQCAtNTI5LDcgKzUy
OSw3IEBAIGNsYXNzIERtYUJ1Zk1SVGVzdChQeXZlcmJzQVBJVGVzdENhc2UpOg0KPiAgIA0KPiAg
ICAgICBkZWYgdGVzdF9kbWFidWZfcmVnX21yX2JhZF9mbGFncyhzZWxmKToNCj4gICAgICAgICAg
ICIiIg0KPiAtICAgICAgICBWZXJpZnkgdGhhdCBpbGxlZ2FsIGZsYWdzIGNvbWJpbmF0aW9uIGZh
aWxzIGFzIGV4cGVjdGVkDQo+ICsgICAgICAgIFZlcmlmeSB0aGF0IERtYUJ1Zk1SIHdpdGggaWxs
ZWdhbCBmbGFncyBjb21iaW5hdGlvbiBmYWlscyBhcyBleHBlY3RlZA0KPiAgICAgICAgICAgIiIi
DQo+ICAgICAgICAgICBjaGVja19kbWFidWZfc3VwcG9ydChzZWxmLmdwdSkNCj4gICAgICAgICAg
IHdpdGggUEQoc2VsZi5jdHgpIGFzIHBkOg0K
