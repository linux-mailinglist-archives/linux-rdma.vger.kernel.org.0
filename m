Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2459D245
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiHWH3q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiHWH3p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 03:29:45 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ADE4A11F
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661239783; x=1692775783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oVVJaIZuGwoDksyhtA/zadgUnmuwjBCogeL7rbDhQVs=;
  b=Laf/XcEk4jg6CbKCx4FZLAJKrpROsRgyPpxJ8K9/lQD71tMurhunTV8J
   z/XbSWrpmllbHLZ8GFXQGfpFYQDVxv3Ttbw7evSoHAv7AtxA1DavOieVl
   iGoonDYe5VD6v9Wv97IR4lptC2PuVHXWIKjYoEKXIxaTq795TXMxZQfdG
   oGkWQmM9GjZehI2tXqYRVN19sm+k/erzLXBUuU+T1EtxVtAOfDnvVSQhX
   db/03j1Pkmm1fEq4MonSRvSlk2xyU7xvLKK/AwbXCnkTQ6jGDubhXNLzE
   J52Kxjel7j4DHmzQ6nw8CRES4xecbbKSI6M9zAJGF22m5QytTSSqejJ+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63441235"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; 
   d="scan'208";a="63441235"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 16:29:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByO7zYoFGooZmfX4mJR0vmrtGAdVk7VWaQkeUeSYWeqW1gJQ9mkIWkdfMnNHsCyY8JIxVRyOrB+vzek7vXcynjTIM+tGFkpywrA2rgEL0m9WLafFvu/GHyC7FgySmJYrvrvROZ/oU7hEGW/yuZPQ3EdokbWi4EHW9BgVWO+m3sVOu8or0oYoyvt4IPfySqzBioNtcGFU3Et4PH6MhU//R76ASVcNFsFkesFhMFG/+X9a06r4GWR+njqUwyw7OeX8lUq2mCZaBcKHgndFlcGopMMmKJ6Vv527VvD6R3PfZTxRxP6yoaByT7eLmuDGDkl386+SMUvGtE3xm113CrlBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVVJaIZuGwoDksyhtA/zadgUnmuwjBCogeL7rbDhQVs=;
 b=nF4qmkA2LCBE0eW45LH5dGqUzr1i2FqI6PC5Ud1zQyVjza9zlE8/EYZb3NI0CC5fOFfbTkRLh4Uy8GriPFLm8svflLNDoVjUXT9w8AqbRzlkTlyepEe3GROsYs+mYrZ1WGWKYikxA+q/QmvTpWxPBzawjNVjp+9XBRthkmIA9VK+APGtiYWUHS/OD9s6/WyaOHFh1vPAeaB3xuDG819V8pH/zjupY5Q2/CKEqcgg2cuPdy15iAdD5cq5PESh33kL42FLOLAjEuoHHjBaLO092Wi8EOicxhU5/ZNWtSHwVVr4sbWt1YNK/A7vQ7FGTyttKgXRxuKbxQ8gk5VF/bk/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB7795.jpnprd01.prod.outlook.com (2603:1096:604:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 07:29:37 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%6]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 07:29:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Topic: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Index: AQHX6LvFpcY61i1rak26VhnSnZTaj60we/uAgACDRACAAsCIgIAB+RcAgARLjgCAAFlrAIABO8QAgAA9ugCAABGpgIACVtiAgAVxhYCAegFbgA==
Date:   Tue, 23 Aug 2022 07:29:36 +0000
Message-ID: <12828262-c553-efd2-b459-5b2ae2e94844@fujitsu.com>
References: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
 <20220601173005.GJ2960187@ziepe.ca>
 <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
 <20220606162101.GA3932382@ziepe.ca>
In-Reply-To: <20220606162101.GA3932382@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bfc37f7-dd05-4ce5-51b6-08da84d93bab
x-ms-traffictypediagnostic: OSZPR01MB7795:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OxyogFIcYsg2cFn3zYWMKSHfdV190ls9clEuZWvWB+3DPd3YhJKAe8Qn6NflcARiSiE+q/ZgXMCbacH3ZbAf0h8mXiNHvxNGGELM+bhO6inR/lK5hiAn4tbMLbaMY7dgjIJaChgH/Q4vu+tpbOOTswfW3pXNth/wpxP11EegKKyoQsY0kS0x/pdNeZDNcx53YicRFQYiU9BX2sfaKRw8iDSmOiM6FwgzOViijsKrznEYTlI2N2KvL9n3QS4gcuIr8J+Dl88HO6pPY4JYiRSdp3cBpqE+Nl+8jq1kz4++56764L3sPL4CipwKzSC59XoW7HPZnSNNWZ2tcz0uaQPKk4X+hvz96WDh2sdZuKImWipG9QmlBYm92iQJ9/zgty7KSk5XYNcVpRlYl94dknrdTHWv4cBRsGemw6EvPKs5C9BLwNVz6PYLe5OgMxbPsC/l4UIZ4+NVWeUQHLnjF04h1IICJBgUVDgc5bwhcfuXMcLSAOhW826N7rACUivzgc17DBYhDp7LQtHTPXB+a6Ba+/woybwOVl36wAShbKYht+ZtvD/YpB3QoY+cM9eX5sJHwG9dnTPEfMDjYQximxG9IjC3OvumrhmJ+9bxhYgOr6Gi8TD+b5GktmBwqrEassfIvIVEDoXekWKIdJHddpxuACc9Wo5lNYnjkpUw5G93Lh2FAJ2eiZkq4Yvg1inDU2Sbe0OKXrN6skyKhork2/86v2uVq6jGjddl2+V3kHiX1yHH/7YP0ipUmwS0PpXQPqUxLZ/Cf1YHPaslY7yUxqjgLKcDRKpWuTMnCopkgOYP/2LsSuD0HKwNRcKpVgos+SMxLv6Lp0pp9emGPAFRHd5Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(1590799006)(1580799003)(4744005)(8936002)(66476007)(66556008)(8676002)(4326008)(64756008)(66946007)(76116006)(66446008)(5660300002)(6506007)(6512007)(53546011)(71200400001)(26005)(31686004)(478600001)(110136005)(6486002)(85182001)(36756003)(41300700001)(2616005)(83380400001)(186003)(2906002)(38070700005)(86362001)(82960400001)(31696002)(316002)(91956017)(54906003)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXFPN21tUDRhd2JYSHdrL1V2QTV5SFc5UHNiZUlDTjJjOVppYTAwU29wNTI5?=
 =?utf-8?B?THB4NXNMZHF3WUlIQk0rZG9jR1V1SktTcVZhZHRkRUV3QzFURDZhTGJEbFNN?=
 =?utf-8?B?ZFRKM05RTDFRdlFQTSsyVDdITE5MaitMQlBWQUdaVU9OckhtdE8zUk43Titv?=
 =?utf-8?B?a2xzTWRPOWhKaDA2V1VYNS94Nmt3SFJGa2tUaFFob1JkSHdHZ0hyQWV0RkN3?=
 =?utf-8?B?a2ZvbEZVNmRmRzZLY2hyWGZ4RzMyNWt2c2Evak9yWHBEbGJFSGJWU3A5Smdm?=
 =?utf-8?B?RGRzNDNRYkVIMzhlUFlsMDVyRjVnM3hiTk9GRTFrMzhvWUZEQnZONVZuMmx4?=
 =?utf-8?B?Y2RtKzdGNGM5ZVRwVFRnYzJubkhLWW5lSEF0UWp3SDZBNkFHZEdmMUlFMkov?=
 =?utf-8?B?ODZhdlZ4WTJNMmlKQ1VuQUN0MVN4MHhsK1E3SzRzZnRvTjBLUUdTUVBlQlV3?=
 =?utf-8?B?UVdTc1NSNldFVHRKSEdoOUErVDcvQ3NpSFNZSEZrZWtITC8zVDl1bFZpWnhk?=
 =?utf-8?B?ays4WW9VaE1OdUNsNStTaEJPMlJNUUU3WGJ5djFFZ1V5QytxR0VWM0x6TnhE?=
 =?utf-8?B?clhpSkxORmV3VWdXRllpVTZMWlRXSXJBaXYxcEJrenVUbC9yMVRDNWlHaUxh?=
 =?utf-8?B?czlhNUl4OWFRZmhCaWNGL2NaSm1jT1hnWU9zZk1Ob0s1aEpjT00xKy9MWEkw?=
 =?utf-8?B?OGYwaWdVWisxdkVUL3pJd1k5YkxmN0JQajR4MWZCNTNUalRIa2Q1bG9MZDY3?=
 =?utf-8?B?eHJJZW82WHFJN1pyRWtwMUgwZnhHS1pScnBRZFNkZXFlSzNDL2ZkWWxrQy9N?=
 =?utf-8?B?OVhhajdUWlBQbEVyNGZhbmNzUHVkT3lBZEN0OEszZlRsYVJyOVRHZkZYZGJX?=
 =?utf-8?B?a1kraHV5QXYzVFV0Mmt5NlB4LzlvV0UwL0F6SGZ2dHJZb0s5K1ZKT1Bja0xk?=
 =?utf-8?B?anNIemJVR1pGaHMwRkRDR3JhYVFNWFBNRlB5MFcvUTN6ZWQzMDFGQjJMTXVT?=
 =?utf-8?B?Q2ljZjlicC9HVjZpQVJNR2ZlQmJHaFJzOWlrN1VVcnpja1JsWmJGeXltS3lm?=
 =?utf-8?B?bGJzY0Nqc0tWZk9CWE4zY3g5SVJIeU45Y2dwVFg0Y1RkTDQ2Q3ZucERoV1VV?=
 =?utf-8?B?THc5c0RjU2h2cm00MGRRQTlUV09EY2ZLRHVpdC9LZWRWNnB1OWc3a3VreGhv?=
 =?utf-8?B?MmxwZkxnRFFjc0FCSDlMK1BDSHlSb0dEVk94b09nY2hOdDluSFhhN3dydnZE?=
 =?utf-8?B?ZTc1c0R0K3hXK251b0U4QUUwWFlXeUJzZEZ1cWlYcWhlZ04wZmVMdGx4Y1BQ?=
 =?utf-8?B?M3EzcUZOancvTVFJSGRtam9OcDR3NFBiaGliUUIvbGgyT0o2SDdwdXNkWWNC?=
 =?utf-8?B?TkdQa0NXbEczN21ndjlzNHJhMkFBWndGMTdsTVFaVUtOME1mNnI4VStQL0VW?=
 =?utf-8?B?RDlReUxBa2xSbTVnNFRzREZmNUFwMWdjZ2ltMXNOM2R1anZvTENteHBja3pp?=
 =?utf-8?B?VFVqN0NuZGw3ODErZnIwMkI2Q2VtZTRsWTZNMmlVQ0dTS1FSYTQyT0M0UGJ3?=
 =?utf-8?B?QkNKV1l5OEZUa1EyKzh2YmlUck80UUkrL3hWN2psTWxDVDRqcVIxQ0ZRbS9a?=
 =?utf-8?B?ckF1UURYNEdzS25OUDYxeHp3VUdQRTlrbHJKQzd4RFA3Q1lLQUhHQlZEMS9a?=
 =?utf-8?B?b3lZYkFDU0VadmtxRU5iQ3I2MW80QVZtMVhPcFZ6MmZmMjBwK0lCc3Era2o4?=
 =?utf-8?B?MmFEQzgxd0ZRbnhvUmk5UkRGaVlSeS9HeGcrU0pIRlBKdmkzWldsYjB2My9m?=
 =?utf-8?B?VTFlazA2aTlZUWpJVFAzRkFmWWNzR0ZKT0hpQ0pTUUV5SS94K3NNWGRjdzNi?=
 =?utf-8?B?aEZKaC8xdjFkc3JXekdJSVR2ZStFZzBLczd0b2lHYTZWZndiUDZTak9PRDV5?=
 =?utf-8?B?Ny9qR3lPTDhMa0RqRFVYMUpaVEMyUmxsZE9SVnB0WHVkNHNQVDBkb2I2akln?=
 =?utf-8?B?ODVzZFdyZU1iOHVaQkVpU28vMXZSMjNRaDJGRXZTWDNBQjV5RS9ZcEY2WUJW?=
 =?utf-8?B?WmlDK0h1aWJKaWVKZFIzL204VENubnlxQ2hGQytuVWJ0dEtFdm1rd1IxYzhX?=
 =?utf-8?B?T2JyRnFHa2E1Z1N4Zk4vU1lKMDAxZDlNa0taNDAvMjVyT2tGOWsrZlBvTUs4?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23E29FB3858AE140ADD0EA63396D310A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfc37f7-dd05-4ce5-51b6-08da84d93bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 07:29:36.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyfKEL5t7sljtQYXTffpAODk7QYsnDlOYqIqg1DGgoilW7RkfkHmlt2VcfM4IdcBXKJTWwBkwtyTFgausORZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7795
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi82LzcgMDoyMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIEp1biAw
MiwgMjAyMiBhdCAxMDoxMzoyNVBNIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+PiBP
biA2LzEvMjIgMTA6MzAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+PiBUaGF0IGlzIGp1c3Qg
dGhlIGtleXMsIG5vdCB0aGUgZ3JhcGggYXJjcy4gbG9ja2RlcCByZWNvcmRzIGFuIGFyYw0KPj4+
IGJldHdlZW4gZXZlcnkga2V5IHRoYXQgZXN0YWJsaXNoZXMgYSBsb2NraW5nIHJlbGF0aW9uc2hp
cCBhbmQNCj4+PiBtaW5pbWl6aW5nIHRoZSBudW1iZXIgb2Yga2V5cyBhbHNvIGRlLWR1cGxpY2F0
ZXMgdGhvc2UgYXJjcy4NCj4+DQo+PiBEbyB5b3UgYWdyZWUgdGhhdCB0aGlzIG92ZXJoZWFkIGlz
IGFjY2VwdGFibGUgc2luY2UgbG9ja2RlcCBpcyBvbmx5DQo+PiB1c2VkIHRvIGRlYnVnIGtlcm5l
bCBjb2RlPw0KPiANCj4gSSBkb24ndCBrbm93IGxvY2tkZXAgd2VsbCBlbm91Z2ggdG8ga25vdyAt
IGlmIHlvdSBibG9hdCB0aGUgZ3JhcGggdG9vDQo+IG11Y2ggaXQgbWF5IGJlY29tZSBleGNlc3Np
dmVseSBzbG93IHdoZW4gc2VhcmNoaW5nIGZvcg0KPiBjeWNsZXMvZWRnZXMuIERlYnVnIHdvcmts
b2FkcyB3aXRoIENNIG1heSB0cmlnZ2VyIGNyZWF0aW5nIG9mIDEwMDAncw0KPiBvZiBrZXlzIGFu
ZCB3ZSBzdGlsbCB3YW50IHRoZSB0ZXN0aW5nIHRvIGJlIHdvcmthYmxlLg0KPiANCj4gSU1ITyBp
dCB3YXMgbm90IGRlc2lnbmVkIHRvIGhhdmUgb25lIGtleSBwZXIgaW5zdGFuY2UuDQoNCkhpIEph
c29uLCBCYXJ0DQoNCkkgd29uZGVyIGlmIHRoZXJlIGlzIGEgcGF0Y2ggdG8gZml4IHRoZSBpc3N1
ZT8NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQoNCj4gDQo+IEphc29u
