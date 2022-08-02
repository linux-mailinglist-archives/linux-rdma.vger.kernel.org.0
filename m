Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04E5876E6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 07:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiHBFw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBFw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 01:52:26 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700846DBD
        for <linux-rdma@vger.kernel.org>; Mon,  1 Aug 2022 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659419544; x=1690955544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0+od5r0mtKBRVdZ0NuNeNkM5Yy5Aqdv3CdpSIMQH5GQ=;
  b=gIdJx5NvRQBoZoQbFmmrP165An+fBGvLCP2ylIXQfUhTwS+HkDDCbvUj
   fKVonZ89ONe362NDKZZOwkLqkI7AzKQGJJJse/iOhNbm5QBpUcTRaNlP7
   FWWmj0XNOl+eW7thOslZbjKWWb/O+XlpZCAeHdaKB8BEMLKyRDmMWgkJW
   sLcHJlTWPaK4DNX/Ef8ET2K1Rt/WEytSSnU40CwQ8kzMDhAaeYPE8c/88
   wA0woONFSwAKysFb1kRMDFU6RpHQKV4IkL1EqIDKEoq7hLeCEKfh5mhce
   PVuTQukomSE599uhJJ/5u07P3FxiBj+8U+m/TfuUZ4ZtXPz4B+lVEuZWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="61616589"
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600"; 
   d="scan'208";a="61616589"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:52:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAaL1YHS2obFmgVke3699eJGkbV+J51EMYGUpSnX/urRj0qkcr7CzltDssg64rmOzoO/q9Io/wwCp/CwUUW0HYxcFbmqp8q+et8V7776cg7vHNxKExyZIdElLXP2vtroWqn9YGujKnzrZYeqGBrYvsQDaPta7Cr6Jnt2GNt5nu19kwtEEKhDvzH3o4CpUJ/unoAt8fQlmpsv427OX+AiHMK4nNglK6jGMLKE1lkDhfadSSd3Pth21GxzYqMJQ2uG0LihCGGtx9MDhNkytjU5X59WT6+WGooH9wA558wK1wNno1nKJEwEbgwXKcKorYNxVxuT9Q2AOcsF18IBH5Ld9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+od5r0mtKBRVdZ0NuNeNkM5Yy5Aqdv3CdpSIMQH5GQ=;
 b=Mj/lhw5xZCkaW5iPNIxPPznydpSv07n13jKC2E76+GMQrsLOWq8TRvllBnbc2yNdPuVwHnTXcH9YVNn3s8fK/YYg9/L75S7pe3dKve9G4fi5pUvQ/YTa3Z1ancDBFdHhMj0AVNvKSBWYQaT0x2R0q4iL2bthu4wMiwT+gppzSgIfuaT7OZG6TLbWSjoUETVknK1TDx2pmuN+nC2TUOFeibjiwDugnTRxlH/gQ2MCw1RlYtz9VatU2Vu3kvrQ/9te9O/aJBu9I6TX9GcVLyJagRa22SjZ5iKw+UniF7bGpia7oHkjeXdjkMzb8Kdg6SFzKuf4unq89xWhX2uGDuv+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7292.jpnprd01.prod.outlook.com (2603:1096:400:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 05:52:17 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 05:52:17 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
Thread-Topic: [PATCH] RDMA/RXE: Add send_common_ack() helper
Thread-Index: AQHYpW5JtoVnjzUx3EukIV84mOfaXK2ZoQcAgAAErQCAAAV0gIABcfiA
Date:   Tue, 2 Aug 2022 05:52:17 +0000
Message-ID: <02c52efa-61fd-5e27-9f98-46e0384d81e7@fujitsu.com>
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com>
 <b47219be-b6e0-9a18-5d84-5546c08d721e@fujitsu.com>
 <CAD=hENfZN43c4ZBmXwdru61=341bZgfYa8VJeKaBQYF5KKFA2A@mail.gmail.com>
In-Reply-To: <CAD=hENfZN43c4ZBmXwdru61=341bZgfYa8VJeKaBQYF5KKFA2A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf6cfc93-23b0-4450-3315-08da744b283d
x-ms-traffictypediagnostic: TYCPR01MB7292:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZbB1KbqiKwbzbEQFeJZNPe6Y5pSOOgdiY/MOCr5CoVoVEUQtmrB78ReaHY3LWsP1h0BZkdWTXXgEnxeMeq+9ohpOabvDpVL0GFcIm+60H8HWGT0HVqotH8xg1ZMaw/U2DtmUho7GDjUk1dWz7rJVsOUFiUgM5TJvFIFystzAVA+WLSLsDJ0YSJbwX7p+T90QhkyubnsHJqx+y3yL64zMDgVaVTt36U+VUYF1KB9hJrLxte8wmZEiodbB0fzqJruJ5Wc151AoYUdNborAcdNxJ1ibk25R+3477iFzB0o+76XIrUkB8tt1IpNnEZpO5cr/lrQ25S122JBmEUdR9YYWombLcAniZA2m6BU6XM9qzzdUhLwKeGXqXr0Prp0ULo1J+tn3XlECJw6ZCGM2B/IiovRy7dm5YWFGUgd572x2DNq/RSPTDnpg7OUi9JJiabEStFgfrKnwXkEXl6SJU2XUAEEtHjPPdsrNlAcBeZvrgqLhZ4lhbmQJoAkq4YkYSLW2X5YlVBpxUY+CkC3zGroItGOjxxSwKBDelSlXxrF3Fx/wZiU65yMcB1/Ofc1FwFZLalem0B4o1s2N6tb92WD6kxeQFhBdGvw0/55rhRDkCvPgyGBVKIr8lEqpqEWgsuAUuI1EHq+T17RV2x6rNBqx6/nMnm+mweLrbVKt/IRNnC99UDmgdMk+plIDqpLL35Nbj0JkJYUAIry0SwJP2L3Ku7wTNUDao/PkTbSexe0G6WNV/oz+2d0Gdsi/N1Ox/tykSqBwTKvjACNo6HSS4Dp0zEpm7bQ9vu2yTKUMJbjL9XSA804t2S9Gz8Ezzzc9+VjO8LPYPIpJP+mjcDK9lBkzBsgD3KNK9co6CCaVMgu+rmyl5isFz0wQ9ee3St5KeAH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(91956017)(186003)(6486002)(38100700002)(478600001)(122000001)(38070700005)(83380400001)(5660300002)(66946007)(86362001)(76116006)(66556008)(4326008)(8676002)(64756008)(66446008)(66476007)(31696002)(53546011)(6506007)(82960400001)(2616005)(41300700001)(36756003)(71200400001)(6916009)(54906003)(31686004)(2906002)(6512007)(316002)(85182001)(26005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEQ3SkM1a0xQNWdrbU5qeVpBbkhLZ3p6dmhSQjUyZjE1dGd0NThGUVczTmpU?=
 =?utf-8?B?UXdZRlp0NXljRkJNL0QxL0crZ2E1QkRTeE9kRC9DUFFUTXBrUWhMRC8xakZh?=
 =?utf-8?B?UDd5U3JieGwvRE9kNTd2YU9DSVJSTlBXeHdqSnpKM2Y2RnR5amEyOEpwbzJw?=
 =?utf-8?B?bGtYaS8vRGl5UE9PeVc4YklKWWFxenE4THVFd2ZBMU5JcDYwVDJEd1k2MEZ0?=
 =?utf-8?B?NnFaTWQ5UU92bnQ1RmRDZnpGbVlySktJSzJzQ0ZQdHNNSURZaUs5YkRQR1Fz?=
 =?utf-8?B?aXNzVGhFTTRzNHRlV1B0OE8xOE4vMFcyRlFiYWovNzhBL2FCRFJ5ODFpUU8y?=
 =?utf-8?B?SFVza0RSTHlnU2hHTTUyNmVZT08rOEMrRzlMOXFZbCtmeTZzOUk0MWE2MENU?=
 =?utf-8?B?RCtra1drRmpTOEgzWUt1MjVQRmdzZVluZWhsbnE0ZW1TVEVvQUNFaDhVdVY0?=
 =?utf-8?B?ZXlPWGxnT1A1UWxROC81VmVrRUVtRExWSklFemFJaTZMeGRuRS91WXRxT3A2?=
 =?utf-8?B?WHBGVW9MMFR5YmZGRHRXdFRmY2lCemNFcGdCUUlBdlJJSmRkL2I3NVo3NTJi?=
 =?utf-8?B?UzNoWm9tRFVJZ1FYSEoyU0hwRlh5dmNIbGFtVXYzU25lYjYweXVBeDFGYzRV?=
 =?utf-8?B?ZGZOM1pUMThIZWNkYUpaaWk3OTFTTFpNSjdqSjkzUmRYajVEbldGNW84MFNu?=
 =?utf-8?B?amtYNmpNR0RwSUhJQnpqeVhYQmhkMloyMmhEc1RVc1hneFNRbUtaMlM1VFE0?=
 =?utf-8?B?VGRpQXVhRFQyaE4xWDhIYkdpNFY1SENFNFRFL2Q5VFpiT2NTa2Jmc1RmTFFE?=
 =?utf-8?B?SVhrUjRkZEw3Ung0OEtSZ3QzcTloV1JWLzB6OXQya1JrbUJvRHdiL2tyeW5N?=
 =?utf-8?B?TXVxOGZzUGhOdXVqV1VwN3Z1alpWQlZLL0JuQ2VRNEREaXFuKythdGcvMUdH?=
 =?utf-8?B?MnBvRlJGRmlzaVloVklZWUVyMEx1UmNyNFhGWVNxdHZQTWlsbmhuZktVQW95?=
 =?utf-8?B?RUQvaG1uZTJud3R3ai9XYW9BL1pFYU81ZWRoSVlzWTc5dnFBbi9FaHpCcDdk?=
 =?utf-8?B?OWtxQzVrK0x2cUJCeDhUWTZZbmpFWnpLNlpDQTlLZnBCdWdIK0dMUEE2Z0t6?=
 =?utf-8?B?aisxOS8zdjRRbUJOSGlpNTNZWU5mb0ZmbTlOUmRjMy95WVo2YU5JbVhpRzM2?=
 =?utf-8?B?d2NobXNhSTlpS2NBR3J4emEwa0ZrRnFlZFhtclhHMkFkQ0FxMGVSSFdDV05r?=
 =?utf-8?B?akZIQk4yRXNMV3Y2UkR5ZDVucmFXU0ZNMEp4MDVxMjgxREZJejIxa1JveHl2?=
 =?utf-8?B?QVFMMTZFU1lMRzl0NnQ5VTE5dGtzdGk4d0psR1h1cy9OMWR5Rm40aTZaZmR3?=
 =?utf-8?B?RzVNTmZmV3FNS1g2elcyRXEzSnZPT3VHWEliaHlSaEliSG52MjFKWldQT3Yw?=
 =?utf-8?B?WWRCYjRNTDBrZWJGSGVPbXVyT2VwV0RRL3luNGkzeG9JQjVJTnB0dWRNOTlT?=
 =?utf-8?B?dFYxMWlCdmUyVzVRcXVIaEtteWFmSm9UaHAxQ3E5MG1kam92T0xFWlF4Q051?=
 =?utf-8?B?REJldGFzQVhSTmF4TWF3QktNbVNnU3dUTm9uZlRwbWJ4bjJURW5lTnVWSlU1?=
 =?utf-8?B?UGV4SlBqalVXNHdMOTFPY2dFamhkUlczRzdDK01Ea3NkTERadTJWbU9maWNO?=
 =?utf-8?B?MjN4dXJDM0Z0S2tKQTQyc0FHTHptTCtTN04rVXdwUEUrbUY4SzQzbS85TFdO?=
 =?utf-8?B?NmxnaVVPdWRPOWlOd2ZPUGF1eEg2ZVR0K3JBNjB0OWFlMEZUS0ZDdG9wMFpX?=
 =?utf-8?B?ZFAyd2NaZlB3bS9wT0FCak9HQUtTUzRJZ1JjUXplSERNd1RHSG1WQ3UxOGtq?=
 =?utf-8?B?c3hrK0YvVjRRTEc3UWkxUU1SNmZrNStrQUFod3RjT2ZNWjRJTitJZmVOdllm?=
 =?utf-8?B?ZzJaZVMrQ2tka21Yakp5N1AyNkpGaUtzVUdPRFM0UmpMSEI1elJVODdmZkpK?=
 =?utf-8?B?OEQ3QlVuYUpZOHhweHRZayttMjRmbHRCUzY4Ylhyd1gxOGdaa29HVTdMUExQ?=
 =?utf-8?B?blU2MHdPNWs1aDlYUUs4UnVITU1pNXdEZCtkZzdrZVZZQVBnZXFBZEw0bE1i?=
 =?utf-8?B?QzRicHlaNG5DSGJCMTAwaTIwellJUFJjZGR3ZjJRUkdEYlM0ZmNzK1dSMUYz?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DC907C71AAAA840AA0C46A2EFF90BA5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6cfc93-23b0-4450-3315-08da744b283d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 05:52:17.2346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGll7abYQMJlWxK4It377GXawN+NLWEtgXPfydP+W7jE/If9NgZmr6edQtdkekLKAGMFgSF+1rH9w6qfrp+eUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7292
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAxLzA4LzIwMjIgMTU6NDcsIFpodSBZYW5qdW4gd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDEsIDIwMjIgYXQgMzoyOCBQTSBsaXpoaWppYW5AZnVqaXRzdS5jb20NCj4gPGxpemhpamlhbkBm
dWppdHN1LmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDAxLzA4LzIwMjIgMTU6MTEsIFpodSBZ
YW5qdW4gd3JvdGU6DQo+Pj4gT24gTW9uLCBBdWcgMSwgMjAyMiBhdCAyOjE2IFBNIExpIFpoaWpp
YW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pj4+IE1vc3QgY29kZSBpbiBzZW5k
X2FjaygpIGFuZCBzZW5kX2F0b21pY19hY2soKSBhcmUgZHVwbGljYXRlLCBtb3ZlIHRoZW0NCj4+
Pj4gdG8gYSBuZXcgaGVscGVyIHNlbmRfY29tbW9uX2FjaygpLg0KPj4+Pg0KPj4+PiBJbiBuZXdl
ciBJQkEgU1BFQywgc29tZSBvcGNvZGVzIHJlcXVpcmUgYWNrbm93bGVkZ2Ugd2l0aCBhIHplcm8t
bGVuZ3RoIHJlYWQNCj4+Pj4gcmVzcG9uc2UsIHdpdGggdGhpcyBuZXcgaGVscGVyLCB3ZSBjYW4g
ZWFzaWx5IGltcGxlbWVudCBpdCBsYXRlci4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIHwgNDMgKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAyNiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
c3AuYw0KPj4+PiBpbmRleCBiMzZlYzVjNGQ1ZTAuLjRjMzk4ZmEyMjBmYSAxMDA2NDQNCj4+Pj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+Pj4+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPj4+PiBAQCAtMTAyOCw1MCArMTAy
OCw0MSBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBkb19jb21wbGV0ZShzdHJ1Y3QgcnhlX3Fw
ICpxcCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIFJFU1BTVF9DTEVBTlVQOw0KPj4+
PiAgICB9DQo+Pj4+DQo+Pj4+IC1zdGF0aWMgaW50IHNlbmRfYWNrKHN0cnVjdCByeGVfcXAgKnFw
LCB1OCBzeW5kcm9tZSwgdTMyIHBzbikNCj4+Pj4gKw0KPj4+PiArc3RhdGljIGludCBzZW5kX2Nv
bW1vbl9hY2soc3RydWN0IHJ4ZV9xcCAqcXAsIHU4IHN5bmRyb21lLCB1MzIgcHNuLA0KPj4+IFRo
ZSBmdW5jdGlvbiBpcyBiZXR0ZXIgd2l0aCByeGVfc2VuZF9jb21tb25fYWNrPw0KPj4gSSdtIG5v
dCBjbGVhciB0aGUgZXhhY3QgcnVsZSBhYm91dCB0aGUgbmFtaW5nIHByZWZpeC4gaWYgaXQgaGFz
LCBwbGVhc2UgbGV0IG1lIGtub3cgOikNCj4+DQo+PiBJTUhPLCBpZiBhIGZ1bmN0aW9uIGlzIGVp
dGhlciBhIHB1YmxpYyBBUEkoZXhwb3J0IGZ1bmN0aW9uKSBvciBhIGNhbGxiYWNrIHRvIGEgdXBw
ZXIgbGF5ZXIsICBpdCdzIGEgZ29vZCBpZGVhIHRvIGEgZml4ZWQgcHJlZml4Lg0KPj4gSW5zdGVh
ZCwgaWYgdGhleSBhcmUganVzdCBzdGF0aWMsIG5vIHByZWZpeCBpcyBub3QgdG9vIGJhZC4NCj4g
V2hlbiBkZWJ1ZywgYSByeGVfIHByZWZpeCBjYW4gaGVscCB1cyBmaWx0ZXIgdGhlIGZ1bmN0aW9u
cyB3aGF0ZXZlcg0KPiB0aGUgZnVuY3Rpb24gc3RhdGljIG9yIHB1YmxpYy4NCj4NCj4+IEJUVywg
Y3VycmVudCBSWEUgYXJlIG1peGluZyB0aGUgdHdvIHJ1bGVzLCBpdCBzaG91bGQgYmUgYW5vdGhl
ciBzdGFuZGFsb25lIHBhdGNoIHRvIGRvIHRoZSBjbGVhbnVwIGlmIG5lZWRlZC4NCj4gWWVzLiBQ
bGVhc2UgbWFrZSB0aGlzIHN0YW5kYWxvbmUgcGF0Y2ggdG8gY29tcGxldGUgdGhpcy4NCg0KaSB0
cmllZCB0byBkbyBhIHJvdWdoIHN0YXRpc3RpYy4NCg0KYWxsIGZ1bmN0aW9uczoNCiQgZ2l0IGdy
ZXAgLUUgJ15bYS16XS4qXCgnIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUgfCBhd2sgLUYnKCcg
J3twcmludCAkMX0nIHwgYXdrICd7cHJpbnQgJE5GfScgfCB0ciAtZCAnXConIHwgZ3JlcCAtRSBe
W2Etel0rIHwgd2MgLWwNCjQ3NA0KDQp3aXRob3V0IHJ4ZV8gcHJlZml4Og0KZ2l0IGdyZXAgLUUg
J15bYS16XS4qXCgnIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUgfCBhd2sgLUYnKCcgJ3twcmlu
dCAkMX0nIHwgYXdrICd7cHJpbnQgJE5GfScgfCB0ciAtZCAnXConIHwgZ3JlcCAtRSBeW2Etel0r
IHwgZ3JlcCAtdiAtZSBecnhlIHwgd2MgLWwNCjE5OQ0KDQpTaW1pbGFybHksIHRoZSBtbHg1IGhh
dmUgdGhlIHNhbWUgc2l0dWF0aW9ucy4NCiQgZ2l0IGdyZXAgLWggLUUgJ15bYS16XS4qXCgnIGRy
aXZlcnMvaW5maW5pYmFuZC9ody9tbHg1IHwgYXdrIC1GJygnICd7cHJpbnQgJDF9JyB8IGF3ayAn
e3ByaW50ICRORn0nIHwgdHIgLWQgJ1wqJyB8IGdyZXAgLUUgXlthLXpdKyB8IHdjIC1sDQoxMDgz
DQokIGdpdCBncmVwIC1oIC1FICdeW2Etel0uKlwoJyBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4
NSB8IGF3ayAtRicoJyAne3ByaW50ICQxfScgfCBhd2sgJ3twcmludCAkTkZ9JyB8IHRyIC1kICdc
KicgfCBncmVwIC1FIF5bYS16XSsgfCBncmVwIC12IC1lIF5tbHg1IHwgd2MgLWwNCjQ3Ng0KDQpU
QkgsIGkgaGF2ZSBubyBzdHJvbmcgc3RvbWFjaCB0byBkbyBzdWNoIGNsZWFudXAgc28gZmFyIDop
DQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4NCj4gVGhhbmtzIGFuZCBSZWdhcmRzLA0KPiBaaHUg
WWFuanVuDQo+DQo+PiBUaGFua3MNCj4+IFpoaWppYW4NCj4+DQo+Pg0KPj4+IFNvIHdoZW4gZGVi
dWcsIHJ4ZV8gcHJlZml4IGNhbiBoZWxwIHVzLg0KPj4+DQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgb3Bjb2RlLCBjb25zdCBjaGFyICptc2cpDQo+Pj4+ICAgIHsN
Cj4+Pj4gLSAgICAgICBpbnQgZXJyID0gMDsNCj4+Pj4gKyAgICAgICBpbnQgZXJyOw0KPj4+PiAg
ICAgICAgICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyBhY2tfcGt0Ow0KPj4+PiAgICAgICAgICAgc3Ry
dWN0IHNrX2J1ZmYgKnNrYjsNCj4+Pj4NCj4+Pj4gLSAgICAgICBza2IgPSBwcmVwYXJlX2Fja19w
YWNrZXQocXAsICZhY2tfcGt0LCBJQl9PUENPREVfUkNfQUNLTk9XTEVER0UsDQo+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIHBzbiwgc3luZHJvbWUpOw0KPj4+PiAtICAg
ICAgIGlmICghc2tiKSB7DQo+Pj4+IC0gICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOw0KPj4+
PiAtICAgICAgICAgICAgICAgZ290byBlcnIxOw0KPj4+PiAtICAgICAgIH0NCj4+Pj4gKyAgICAg
ICBza2IgPSBwcmVwYXJlX2Fja19wYWNrZXQocXAsICZhY2tfcGt0LCBvcGNvZGUsIDAsIHBzbiwg
c3luZHJvbWUpOw0KPj4+PiArICAgICAgIGlmICghc2tiKQ0KPj4+PiArICAgICAgICAgICAgICAg
cmV0dXJuIC1FTk9NRU07DQo+Pj4+DQo+Pj4+ICAgICAgICAgICBlcnIgPSByeGVfeG1pdF9wYWNr
ZXQocXAsICZhY2tfcGt0LCBza2IpOw0KPj4+PiAgICAgICAgICAgaWYgKGVycikNCj4+Pj4gLSAg
ICAgICAgICAgICAgIHByX2Vycl9yYXRlbGltaXRlZCgiRmFpbGVkIHNlbmRpbmcgYWNrXG4iKTsN
Cj4+Pj4gKyAgICAgICAgICAgICAgIHByX2Vycl9yYXRlbGltaXRlZCgiRmFpbGVkIHNlbmRpbmcg
JXNcbiIsIG1zZyk7DQo+Pj4+DQo+Pj4+IC1lcnIxOg0KPj4+PiAgICAgICAgICAgcmV0dXJuIGVy
cjsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+PiAtc3RhdGljIGludCBzZW5kX2F0b21pY19hY2soc3Ry
dWN0IHJ4ZV9xcCAqcXAsIHU4IHN5bmRyb21lLCB1MzIgcHNuKQ0KPj4+PiArc3RhdGljIGludCBz
ZW5kX2FjayhzdHJ1Y3QgcnhlX3FwICpxcCwgdTggc3luZHJvbWUsIHUzMiBwc24pDQo+Pj4gcnhl
X3NlbmRfYWNrDQo+Pj4NCj4+Pj4gICAgew0KPj4+PiAtICAgICAgIGludCBlcnIgPSAwOw0KPj4+
PiAtICAgICAgIHN0cnVjdCByeGVfcGt0X2luZm8gYWNrX3BrdDsNCj4+Pj4gLSAgICAgICBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiOw0KPj4+PiAtDQo+Pj4+IC0gICAgICAgc2tiID0gcHJlcGFyZV9hY2tf
cGFja2V0KHFwLCAmYWNrX3BrdCwgSUJfT1BDT0RFX1JDX0FUT01JQ19BQ0tOT1dMRURHRSwNCj4+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgcHNuLCBzeW5kcm9tZSk7DQo+
Pj4+IC0gICAgICAgaWYgKCFza2IpIHsNCj4+Pj4gLSAgICAgICAgICAgICAgIGVyciA9IC1FTk9N
RU07DQo+Pj4+IC0gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+Pj4gLSAgICAgICB9DQo+Pj4+
ICsgICAgICAgcmV0dXJuIHNlbmRfY29tbW9uX2FjayhxcCwgc3luZHJvbWUsIHBzbiwNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgSUJfT1BDT0RFX1JDX0FDS05PV0xFREdFLCAiQUNLIik7
DQo+Pj4+ICt9DQo+Pj4+DQo+Pj4+IC0gICAgICAgZXJyID0gcnhlX3htaXRfcGFja2V0KHFwLCAm
YWNrX3BrdCwgc2tiKTsNCj4+Pj4gLSAgICAgICBpZiAoZXJyKQ0KPj4+PiAtICAgICAgICAgICAg
ICAgcHJfZXJyX3JhdGVsaW1pdGVkKCJGYWlsZWQgc2VuZGluZyBhdG9taWMgYWNrXG4iKTsNCj4+
Pj4gK3N0YXRpYyBpbnQgc2VuZF9hdG9taWNfYWNrKHN0cnVjdCByeGVfcXAgKnFwLCB1OCBzeW5k
cm9tZSwgdTMyIHBzbikNCj4+PiByeGVfc2VuZF9hdG9taWNfYWNrDQo+Pj4NCj4+PiBUaGFua3Mg
YW5kIFJlZ2FyZHMsDQo+Pj4gWmh1IFlhbmp1bg0KPj4+PiArew0KPj4+PiArICAgICAgIGludCBy
ZXQgPSBzZW5kX2NvbW1vbl9hY2socXAsIHN5bmRyb21lLCBwc24sDQo+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIElCX09QQ09ERV9SQ19BVE9NSUNfQUNLTk9XTEVER0UsICJBVE9NSUMgQUNL
Iik7DQo+Pj4+DQo+Pj4+ICAgICAgICAgICAvKiBoYXZlIHRvIGNsZWFyIHRoaXMgc2luY2UgaXQg
aXMgdXNlZCB0byB0cmlnZ2VyDQo+Pj4+ICAgICAgICAgICAgKiBsb25nIHJlYWQgcmVwbGllcw0K
Pj4+PiAgICAgICAgICAgICovDQo+Pj4+ICAgICAgICAgICBxcC0+cmVzcC5yZXMgPSBOVUxMOw0K
Pj4+PiAtb3V0Og0KPj4+PiAtICAgICAgIHJldHVybiBlcnI7DQo+Pj4+ICsgICAgICAgcmV0dXJu
IHJldDsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+PiAgICBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBh
Y2tub3dsZWRnZShzdHJ1Y3QgcnhlX3FwICpxcCwNCj4+Pj4gLS0NCj4+Pj4gMS44LjMuMQ0KPj4+
Pg0K
