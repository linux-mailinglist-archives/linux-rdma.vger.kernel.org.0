Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0E3F4468
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 06:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhHWEiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 00:38:25 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:21190 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhHWEiY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 00:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629693463; x=1661229463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NKTXrqw9r1HW7/FKG/NlzlqKP9X+kUfoKXzWxl70Bj4=;
  b=YbHLpGUVeqr9eTAWHaTPEUuqpu9oc5+MkSnJJMOdD45XUT+kILVe7uST
   NXP+zHPD1/goBIBNoCXWNYqdix9Xt/sywPUytpq9LJ1RfctUOMG71R44m
   LPZHFBDAnoRv3cxjak2BLgpao/sOaDRj1+E6xFdmhnd9eB/t8UW+inqp3
   RhZB32YnhfKkC/v4VJue72E5dnrngr/WaWz6yybijvLvUeYzv80II4sry
   tC8Hy6l5rz1U4+qQhTY6wjvRJDJzYAfZsqfISF1qZ227RFhdhXodNzvSm
   yh+NRNGmn56NWkFRDM/lK6bLdEgtp9zZglzdn+uvkNc6CPvlgOxQrrhuv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="37405615"
X-IronPort-AV: E=Sophos;i="5.84,343,1620658800"; 
   d="scan'208";a="37405615"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:37:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df4TLubOBgQkF7hTNtUmL9HnUEqlX7CQWhZBvzU6zIyBxjsb79Cav/QWrAdgeJ9nAe57a0zZjkRIca4NYZLEyun1fs0Gr/xi4jCZnjlaAgj/JTCtjl1b30SnrmC3NJmax+yZHa1to93GUea49vr0LZZp+yXG1HPv4PyjpEE/B4GyJKei41u0LzbJgg8aZJrNvTBBNRs1AD3Mv8Ljae4YbeLRGIFDZ7f+jxJ1Q1f01ztZnZZXKWB94XtFYz3Ts+bv9YL05HJj7Hu4P4MRETtYeXQB5bQ6fihpl9IJsFBBrrdldM6QpFYHK+eSPzpFo1r0qihZ03B4AeDVqMGE1yKKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKTXrqw9r1HW7/FKG/NlzlqKP9X+kUfoKXzWxl70Bj4=;
 b=ZNwR7+034V4qbTualwhdZfL1KGt35tm8Br+8XecsNnsJMh8ex8+QxtGiXP4BIzwFPwE6dGcfCtdxbMuHMPnyc4nDzl7aMnF/GZUBmw4lO1Dk2HodQpTUPtZ8kW3aNp15uht8up9YXZys/x5cGx9+ySA8etosWb02+luFn/VQzTBPAncTiChxmie+5UB0moho5bAzeEGslyUKfhH2NokQaco7HXx7BiCGGneOabiPi806onxWVfRcVlswFdslQvRIj1Hf7Jv+qwhYhU+zFwuHfPawefzllO1uoXY8m+EE928T8DL4QuSmg9ryjRISVWqd0sq2XpQzoFKD6DyLKSrgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKTXrqw9r1HW7/FKG/NlzlqKP9X+kUfoKXzWxl70Bj4=;
 b=EW9YykynX4/32msPfv11syt7r//phqSwbgUognvBAOvc7raTNlYvexBbfGHcgif/avglBwHtWCxUk9hiBUo6SXtsnzpGI4ybbxFk5vCk0O095WW2eyr7d7YxgMgiJfEfAgK60RVfuqaTVuknCt7vmJZ0+Ebv9e9y2YF42lNftFc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB6082.jpnprd01.prod.outlook.com (2603:1096:604:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 04:37:31 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 04:37:31 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Topic: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Index: AQHXlbAkwqjHlJzA7Ue2Vhqx7eRcdKt9juEAgAL254A=
Date:   Mon, 23 Aug 2021 04:37:31 +0000
Message-ID: <61232609.7020500@fujitsu.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
 <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
In-Reply-To: <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42979659-080f-4146-3670-08d965efb89a
x-ms-traffictypediagnostic: OS0PR01MB6082:
x-microsoft-antispam-prvs: <OS0PR01MB6082D2DB0067A885DF762BB983C49@OS0PR01MB6082.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGzCtPSHzox96MGcZ3NjQjf58j3cHljmBiakoLoBmV7Cdy9XQAPxNonO4bZsxYIwZdwgzJ00cwvXde95YIgMMLyX5nqfo4eQwdfZ6rpaJj6EP8IlVLcBT33tl4Tv8gZQLYcf65WDhqdOQ/oHyTFXdTMssNVkSra0XjIvYWUNS790wBE4Btfv/buJOqbPkpRlOcZv9xEsTINHtm1L2uB9/zGgB6o9xIwTrwyj6VO3WhwE+VjZ6L2I3z2ck+I2+xDxhNOfJSzozQvfIZdKc98/PoJh3VzaPPc+PP8ySIQjIsXT1pPn1qT+kIWpXGy45MNkyp/548N0vvT10VSFMJYfiSXYVH2cbegmkj4kqBIFsWFCltTOvozsOi6kjZS0pQpGDxXVZOmQuhm1takVdnuXrkGRWHSTqCEsvMYCtByku4Bn45zHK8ZwwyY8DbpQRMf4aTfmeGr1/wxi0WUzp19tweeiHQ/xg8vatxKMYFg1h7fCO+3oScdzmAX5KPV+wYl6PevNTc67rU/4PKC4lBoddYm+M+h/O4cmfCT3DPXKsawyNaJyb/LWJSROTZq/Q5ePkvv9XK+cmJ1PRraewB31Yu+Y0r6NwM2E7Dk9nKbtC7AscazThqavYWYt8CIRzfznRwOGAAMDLN7Vd9x777XtvbWFjE2eMy0SU6z5yTfGXXWLvt8hdNDC1UAatYVXmKEWhhT0V5THOC/9+cbSEiazpK182TE7nizFEUNrAqlohVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(64756008)(66446008)(66556008)(66946007)(122000001)(91956017)(38100700002)(186003)(6916009)(5660300002)(87266011)(53546011)(26005)(6486002)(76116006)(6506007)(85182001)(83380400001)(71200400001)(36756003)(86362001)(8936002)(4326008)(54906003)(6512007)(8676002)(316002)(2906002)(38070700005)(478600001)(2616005)(62816006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEtWaUFMVzJ5UCszQkNIakZsbC8zSU5XVm9RSFplZEpaWVNrSy9qTk9wTkRv?=
 =?utf-8?B?ZGF2TE1CcU1DRGJVS0F4eitpeDBiZ3o0elpIOXNhcXEwamNsOEIyRk1tUnRQ?=
 =?utf-8?B?dXlCRWFnZmxMdm02eDZxd1JyWFRyVlBZTE5ZeUUwUnM2b0hiNHJEbGlXUnVl?=
 =?utf-8?B?MkpOMWxiZVpHanJQY2V3ZEJwZ05KMXRhbWVHbzBoZXhVY05NTDl2aHhCMGVi?=
 =?utf-8?B?b2RhWWJUNzhTZWEvRW5HYnRPejh3UVN1SlV3MFdUeXFXcE1SSGN0SEtvZzZU?=
 =?utf-8?B?UGNKUWI3UWtHY2FpRDJmaVVRK3JJZDFxZVZicUp5d09YZkw2NU9udjdRdmJT?=
 =?utf-8?B?NURjU2d4ZzM2NlFoLyt6UWtyTGRjR09jQlJ3SlpMMVRSaVE1UjBRSzQvV1lY?=
 =?utf-8?B?Mm82TzhaWnc1ajRNQnBySTJnYVl2NVdERTJVWURiY2hlMDFvM2RDclZhRmxJ?=
 =?utf-8?B?S1BWSzkxUDBOUkVqb1E2endSYTZGT2MrWENUeWJwVkpSa1Y5bkhUa1FCb0xk?=
 =?utf-8?B?OE9JSzNiSmlWM3dCOCswbHVXcHJYR3psWWxjRkxqSGI4U0xOSzJXYXRVZ2dG?=
 =?utf-8?B?T1RNSFVXemVxQUNJU1JqMXRPd0VRSE9MWStPOTZIanl4QUhncEdid2YyczRq?=
 =?utf-8?B?Y3Y3dWRWcFplVis5aDdDcXJqcVBMbkJCU2tFQktGQmZOSENsanpjYWJjNW82?=
 =?utf-8?B?emFCbXl0R3VnQUtsYm5EOHYwem5xNHMxYngxUUpYcXhMQXlBV0w4c2txUlBF?=
 =?utf-8?B?ZVFHU09FUTNMTE1IZlBKenlkNmJYdDFkc3BPOHVjSnVQbnNjaTliczhEa0c4?=
 =?utf-8?B?ckN0MllZQ2hjclF1OStQY0JGS1IrWDJnNTZTYXpjNFRCenJhUkRYdno0OWQy?=
 =?utf-8?B?UzBaQlRobHgwcVk4SEprdVVZNEoyZUNwb0Nya3kzRWZzRXlCb0RhNVQzTE5O?=
 =?utf-8?B?SVhNWkgvdnZNby91ejZFZ3ZSTlRyUkt6dk9nR3JhQmpwcjFXa0lUUkZxbUxm?=
 =?utf-8?B?YlNxYkVPUWZSSFQrcFhZa1I3LzdEZ0l6QjNsRE9xNXB4Z1lVcWhOd3plZHJn?=
 =?utf-8?B?a1pGNTVDM0I0RE5tTDhzVlBGa2llNGI2SlFqY3RlYy9EQkVlNFNWclEwSFE2?=
 =?utf-8?B?WlVVR09DTlZBeWE4YVlRYU5nMk5OQ3dvYWZDaWNsWFFUSGR6VXdLbjJOVEl2?=
 =?utf-8?B?TG1Pb1BrSlFieEtsK0t0Z1pYdFdWalJmZmdQazc3U2Flc2F6M2E1QmRKV3lm?=
 =?utf-8?B?UFhrSjdRY2dIaUNSeUszcDlTejI5MHQwZFhuZzM4K05NYS9TZk5lQnc5QmhI?=
 =?utf-8?B?QnRnaWpoZDNOVkpWVjhBNEdZVjYxRzVIcDIzMHNzSTVaUEVNdGxSdnNCT1E2?=
 =?utf-8?B?WDlXSTE0aTlxdWE3eW5yMWREaWtTMDlBVEtnSGs3QmRLODRnZmNkaDdBZ09Z?=
 =?utf-8?B?SFdoTTBWUmxpMEtwam9ld3YveEQyUm9oQXI5WlpnVlluaG9FL3J6dlNkYUhV?=
 =?utf-8?B?UmgyUEk5QWtUdkNzZHRQWGFaRTBmNWpkOTV4Zi9ENjdhR1QzQTFrb1VlT1ZI?=
 =?utf-8?B?aC9CQ1lsWENSUk0zb1YyNmdubU9iS2hXSmxoMnNGWmFKZ1FreUFSNEVjSWFV?=
 =?utf-8?B?WTZBWVFkbU0zOGlDY2x2MnU3V2JKTTVKNERpZHBwNXMyeEJMWlliZVVyM0Nw?=
 =?utf-8?B?WDZqSXhHVkpzNmNyMlFXazdqR1hRbjBqaDhCd1lLVUdJN2NOMWpWODlpMEVx?=
 =?utf-8?B?V2Y1VVd6cTVKRTZJbmRIYitYemtKSm5QNTdBZ2MzZEFQeFg5ZUJwQnhFUTNi?=
 =?utf-8?B?YjJkSVQ4SFQ3a0VBck5EQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE54AF80B54F74D85A417E19086B7D2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42979659-080f-4146-3670-08d965efb89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 04:37:31.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjwIl9Eax5TqDztNioeGTcbOdELZipgePcx351VawkxjtVmQPcXGPF8Lx+GnprFszDQXVkXjDGaoO9etSiEmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6082
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzIxIDE1OjIxLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBGcmksIEF1ZyAyMCwg
MjAyMSBhdCA2OjQ0IFBNIFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1LmNvbT4gIHdyb3RlOg0K
Pj4gMSkgTmV3IGluZGV4IG1lbWJlciBvZiBzdHJ1Y3QgcnhlX3F1ZXVlIGlzIGludHJvZHVjZWQg
YnV0IG5vdCB6ZXJvZWQNCj4+ICAgICBzbyB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBpbmRleCBtYXkg
YmUgcmFuZG9tLg0KPj4gMikgQ3VycmVudCBpbmRleCBpcyBub3QgbWFza2VkIG9mZiB0byBpbmRl
eF9tYXNrLg0KPj4gSW4gc3VjaCBjYXNlLCBwcm9kdWNlcl9hZGRyKCkgYW5kIGNvbnN1bWVyX2Fk
ZHIoKSB3aWxsIGdldCBhbiBpbnZhbGlkDQo+PiBhZGRyZXNzIGJ5IHRoZSByYW5kb20gaW5kZXgg
YW5kIHRoZW4gYWNjZXNzaW5nIHRoZSBpbnZhbGlkIGFkZHJlc3MNCj4+IHRyaWdnZXJzIHRoZSBm
b2xsb3dpbmcgcGFuaWM6DQo+PiAiQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9y
IGFkZHJlc3M6IGZmZmY5YWUyYzA3YTE0MTQiDQo+Pg0KPj4gRml4IHRoZSBpc3N1ZSBieSB1c2lu
ZyBremFsbG9jKCkgdG8gemVybyBvdXQgaW5kZXggbWVtYmVyLg0KPj4NCj4+IEZpeGVzOiA1YmNm
NWE1OWM0MWUgKCJSRE1BL3J4ZTogUHJvdGV4dCBrZXJuZWwgaW5kZXggZnJvbSB1c2VyIHNwYWNl
IikNCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5jIHwgMiArLQ0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVldWUuYyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3F1ZXVlLmMNCj4+IGluZGV4IDg1YjgxMjU4NmVk
NC4uNzJkOTUzOThlNjA0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcXVldWUuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVl
dWUuYw0KPj4gQEAgLTYzLDcgKzYzLDcgQEAgc3RydWN0IHJ4ZV9xdWV1ZSAqcnhlX3F1ZXVlX2lu
aXQoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgaW50ICpudW1fZWxlbSwNCj4+ICAgICAgICAgIGlmICgq
bnVtX2VsZW08ICAwKQ0KPj4gICAgICAgICAgICAgICAgICBnb3RvIGVycjE7DQo+Pg0KPj4gLSAg
ICAgICBxID0ga21hbGxvYyhzaXplb2YoKnEpLCBHRlBfS0VSTkVMKTsNCj4+ICsgICAgICAgcSA9
IGt6YWxsb2Moc2l6ZW9mKCpxKSwgR0ZQX0tFUk5FTCk7DQo+IFBlcmhhcHMgdGhpcyBpcyB3aHkg
SSBjYW4gbm90IHJlcHJvZHVjZSB0aGlzIHByb2JsZW0gaW4gdGhlIGxvY2FsIGhvc3QuDQpIaSBZ
YW5qdW4sDQoNCkkgZm9yZ290IHRvIHNheSB0aGF0IEkgcmVwcm9kdWNlZCB0aGUgaXNzdWUgb24g
bXkgbG9jYWwgdm0uDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBaaHUgWWFuanVuDQo+
DQo+PiAgICAgICAgICBpZiAoIXEpDQo+PiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyMTsNCj4+
DQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0KPj4NCj4+DQo=
