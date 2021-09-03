Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA133FF8AD
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhICBk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 21:40:29 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:42076 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhICBk3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 21:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630633171; x=1662169171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3jG5aIlg3c8VzZytaHYQC6Hj49mge4imV7EGNm5dYrI=;
  b=fj4m1MnEJVAU/jNP5t9DV3VVh8nF8CLaePVyNhQvzIdfCWW0nEFLKxMr
   4TP7L9ZNPWFcqkc4g/WFp59kLdSZQLb+3UDWxLT4T6ZmPo1VdD6iaE0yU
   o36otbLl98lww0LXakZw2WLPHXeLrkCVthxbw4LpgsLm4k/Nf4L02PI4/
   ALrh1GEwsZxbsmPP/LnH5twUwzCM4UEnjt2SRgdRPe2kGpzE8fUl90Jyv
   2RmroLa8rnd1bJP7UmNlIGc14PQpqlQpBG/wEDJ0kyK5PajY0Q47oBZ2O
   bTEjgG/ZITAKyul5zC70u9Oi/iJ5FqmhCTW56HrZfA9BnHbUJs8QSEnEd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="39100945"
X-IronPort-AV: E=Sophos;i="5.85,263,1624287600"; 
   d="scan'208";a="39100945"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:39:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwDIL0DcDzpulWQcAE1gxYaxtcVQvcbWvxPpGE/cOfCyJwqiEQPh3eM7YP+FPDIyktsN4j5KYu5afGu/98oXbMOGXaGJAYRK8taDBnTj39pNL/4wS7gG1Ch/INfSxo7ZLsq2nCzclZ9kLszYMJCN3AEHXdo0YYVV+wwXb9f/mh5qUymUXEeUq51PCcEh8BfQtJTwNrX5k2wNb4VRU6gwJXan93YXicYAVOTqY4U8iLQ4xcrFUrLuBQHCPG1ax5AT/D31Lxdk/REoEgTbTjWS2CV8dnrYN5SblO4UXAaXEo1t2ZIhaVV6I31JgYzsQUDaifzrdpKuPhMTmNeyqlgGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3jG5aIlg3c8VzZytaHYQC6Hj49mge4imV7EGNm5dYrI=;
 b=gLjHA2HfKRT9GWG2e4LeeXqS00R/NbHA9S48peFy7pad1M4RXvKoOu0v0YQ0PKZnyXe5P7Pp8m/B/k64YQbypyXCsKFh1wHCvhK9rvDHmgnvI8+0UAf+63wgRveO+d+cS6n5MpkKWdYg/KXWyIfSAn7h5HYXk8NThF+CRmpO0421+ERBTMjgzEUPa+yIJopEKAw/2D1D1j9l6dUZH3ZUuNrHzYrbvGOrVb9V+OfkdGDMKnjIcqheDhhp22tiLRTux7OjkgcAor+JFzocOVyhkH2Pz30kMPe4ZMIYyHo/0pM7nCRqCAD8vTHbF3myc/BHS2jVAhbkxwc1RWWn80x6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jG5aIlg3c8VzZytaHYQC6Hj49mge4imV7EGNm5dYrI=;
 b=WM8BNc18gGdEzZaaeNfp1oblzM6Fa+6UXX1bqHAQqc1vwib6xlgpaiUZRzi8WDo3fnvxnwV65q43wsxLHdae4GY/ny44aD0KUpA27/5HE9MQbPlgF6D9jE2sySjiYlcjjGG8hqPmV55/ZWD7Bn5DaLj9pfyk3NgclLAqnsNuPTc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB5093.jpnprd01.prod.outlook.com (2603:1096:604:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 01:39:23 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2%6]) with mapi id 15.20.4457.026; Fri, 3 Sep 2021
 01:39:23 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Topic: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtyBf+AgAOEzwCAAPqWgIAJ3fuAgAOtywCADH1NgIAAviAAgABiFgA=
Date:   Fri, 3 Sep 2021 01:39:23 +0000
Message-ID: <61317CC6.1070406@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
 <6122FAE1.4080306@fujitsu.com> <YSYQ6hLAebrnGow6@unreal>
 <61308B01.9050706@fujitsu.com>
 <819eadbd-9f9d-669f-a552-18a9e434a43a@gmail.com>
In-Reply-To: <819eadbd-9f9d-669f-a552-18a9e434a43a@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602f0a89-3721-4f1b-1ded-08d96e7ba836
x-ms-traffictypediagnostic: OSBPR01MB5093:
x-microsoft-antispam-prvs: <OSBPR01MB50936B39E1ADC97A7995782583CF9@OSBPR01MB5093.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4urkrsZsbPlFoiX8BGLgXZdk62WIwBeUdQSkYacY5H4qfav3nGal89/OFyq9eKqDhyRLpUzLF8WZ5zke1lCIqDGNgHYyMP1m5Uttms2gb43GmfrDDwhMUJ6fsKLFdXcmUQ0q1Vns9acQuZTMPNi7whRkTf2OUsxHLylGadJjMDDHxwvJz4F4QgmJo4ZZZlOwOnFYIwzxHqPFxWaD4kL8WP2x2EYDz6qAS+5Pjsj+Jiyad5IJHgrUwV1LJDQv2aKKDlhcBuqycqPPDbXL/LNNr3A7xC54RCd8dsg7T/9kihhGj9crY7+HaOp09BDE0H2cO4HnhVXjGbrijuAd7jSlTuXNVKPP0TKhZO4Dwp7iT1fs597MZkKMc+Z4jUcw6n0xd0KvHu7F+oYKZvkdvxg67XAM8re2XRy7Fr/OVgL0hDWsdO6QvtkyYL9410Hed0/+F/7m7HyIPzh5TkR9DG532HN/zEMU8Ma9Is0zSWO3y+Ln/HHUvXozzqF1OqtN2uwzDHsSFD3FLUXnkB0YCYcBLYHfVdd/nrMyXnh4ZUFVu7QEexqNUmkYXt5udQiPa6SV1SQqdFJ8e6ef8eTfLF0uJ2mzP4IRHXQV8foTu45IQFCZ9u1jtJ97TPQaGj9hAlPHJxhBEjqJi7pbeSPdTa3SceEbvIuEff+6AmEM8yLF396QGUY3XRuopA8JY3iHduxOsJGO9tUXViw+zF+lGhoUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66556008)(66446008)(4326008)(122000001)(54906003)(66476007)(316002)(33656002)(6512007)(71200400001)(6486002)(38100700002)(64756008)(83380400001)(76116006)(6916009)(66946007)(86362001)(91956017)(2906002)(85182001)(8676002)(38070700005)(8936002)(5660300002)(87266011)(2616005)(36756003)(186003)(26005)(53546011)(6506007)(4744005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNpc0JyRDloWmZtTVArQ0xmL085UlhPc0ZSbjg5M2ZEZ1hVOUd3My9KMHcz?=
 =?utf-8?B?VnQ5emFJeTVYZm56TGtzYWZ2dXBTRFFUMG5MaURKVjdZQkdycmRkUU9xcWZS?=
 =?utf-8?B?cjZvenV3Rzd1aENocGxUMU9Tb0twQUJnVkJoZjJ4TjRpbFNLeVZFL3pNYWt0?=
 =?utf-8?B?b2ppeXMxSUlSVG9pWmZ5bkgzOG1nT3pubDZScFhCV1FPbms2dk0rVnhCNnlv?=
 =?utf-8?B?OEZQMzRGRWtvdlI2QnJvUitTbE96d1lmaU1qQ3V4Z2VKRU44dlNGNDFUOTFE?=
 =?utf-8?B?cTRGWFh3Y3M3c0JraHpWV0NtTjhteURZbTN2SkVHbmxyYVpXTWpEaGkwV1hY?=
 =?utf-8?B?QUcxMWtqRVdDb0xpbGJvS052Si81d3hlOC8rT0hiNzM5azJCNFBSYklTZFN4?=
 =?utf-8?B?aCtOd2tpamdYdE9KZVdpdEZwUGVhd1ZzblJKTzloT0V6cCtRVUNqaWNrNVJB?=
 =?utf-8?B?WjNZTGw3bHVtQi9qWHloSlpoR05LeHBLSmIrdlNiUjZjc3ppRlhwQXZoZ0wr?=
 =?utf-8?B?V2tBZi9LTnNiZEFxWEFjRjVTZkVERGpRRFlwWW9aWkV0SFpSVnpTNjNjZjFq?=
 =?utf-8?B?N1hyaW9sbmlZY0szcXV6Z09JTU12TkVWa2lyczhRSEZNNW9EMmdYWTcyV1c3?=
 =?utf-8?B?bmtxYWNuai94cGNUSzFBRExoZUl2M0loTXNXMWlYdlBqK1YxYllJbTNQQXNX?=
 =?utf-8?B?bmpsNGJXWUNLdHdHcTVqSG9sMDRyKzZ4WXFNZXFpVHc3ME5WRHJCWGFHZG12?=
 =?utf-8?B?VFBsc09ZMVNyZGtlMnFhLzZWV1RZblYrcDB0SFNSWGJ4SGlZMitGWXM3WjlQ?=
 =?utf-8?B?NWNYSWhPNGZzS1JUWU9yRkIzWWsydTA5TUYydjB5UW12RW9VVUpPUFNRempX?=
 =?utf-8?B?VFhaZjlLYzBxb3RGNnBFb2FleFQrUldsV295aUZIcFg5RDhxKzhiUEJrWUJS?=
 =?utf-8?B?bHhxTHVleWZQQXo3aEZ6eER3cFhWb1BEenkvMVk4SS9iTFNCdkJQY3BmeE1U?=
 =?utf-8?B?WTN6ZXFqcUoxcjNzWFB6VngwK3l1ZjhoUTA0a1NPRkEyc0YrNmZFakxFUDZj?=
 =?utf-8?B?bVcxMzdXRkRWUlhYOEFzZy8veEx1REFoNTRkOXRkaDF5YTlCdjBnNVpjaEdS?=
 =?utf-8?B?bUlIYmZrTEYrUTlIQ2VEK3lEWS82RisvWXUvcDlrYUpOWUxSTTAzSWo2T01W?=
 =?utf-8?B?K241V2Q0cHFDUmpZSHYydzl4WkNQZ0JzbUUvWXVwOGRkU1UyeGxjRU8wZThT?=
 =?utf-8?B?TWsyUVcyZHV0VE9zT0lYRFJ0WE1odDYvRFJ6QnNRaXFZcS9RaHZXUHB4SjRO?=
 =?utf-8?B?VzNldTl1TElnMzh0eGdqN0pML0RKVCtJNjI5NngxTzc4UjU3cTVybGxzUk9h?=
 =?utf-8?B?MjN1TzBqOE9yVG9KZ2xBVE9MenNjbytoUGZjeDI1c2ZzY2Z6MnlPNjh5N25x?=
 =?utf-8?B?NllhYjNpd2FVZm9sNzQ4UGZjT09RbmtmMzh0MGdwcForTmZXNWxBUzZrZ2ZX?=
 =?utf-8?B?VnNmTjIxMHp6RUU3Z3JGczZnWEkyVlc3ZWJnZ3k5NkJXUkN2RkFkSEZRS3VW?=
 =?utf-8?B?K2NJNytWMXNkWEY2V01Vb3FoOEZQcWhRY0VlUU9DcWdYMzVSaXZrd0l3Zmw1?=
 =?utf-8?B?cWhyYlp3SVJ5YnZVMk80LzNZeGhwTldHckx1eXQ4dlUwZktLQTdESkRJNTJL?=
 =?utf-8?B?Nzk1OC9HUGpmY1VQdytUM3p4ak96ZHpUMWp0U2pvM0VFMFkycUZHY0Fsc3du?=
 =?utf-8?B?VGtrWGRzTVNlSlpNQUdnSDVtZVF6dlBRMUZmOVdKTVVPTVdDZURETmF6S2ln?=
 =?utf-8?B?a3dNYlU1UThzejNCVnhCQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A16A88CF40106840A451967EEC82390C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602f0a89-3721-4f1b-1ded-08d96e7ba836
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 01:39:23.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUVNxCyvvKCfvrbY9DPDZT7gJOl5a827VyKwSIxyY0HpaPo0kfFj1eGgISAiGm//cuD4t2Ic607P9U3a1nTMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5093
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS85LzMgMzo0OCwgQm9iIFBlYXJzb24gd3JvdGU6DQo+IEhpLA0KPg0KPiBXaGF0IGFy
ZSB5b3UgbG9va2luZyBmb3I/IEkgcmV2aWV3ZWQgdGhlIHBhdGNoIChhYm92ZSkgYW5kIGFncmVl
IHdpdGggeW91IHRoYXQgaXQgbWFrZXMgc2Vuc2UuDQo+IEJ1dCBpdCdzIG5vdCB1cCB0byBtZSB0
byBhY2NlcHQgaXQuIFRoYXQgd291bGQgYmUgSmFzb24gb3IgWmh1Lg0KSGkgQm9iLA0KDQpTb3Jy
eSBmb3IgbWlzc2luZyB5b3VyIHJldmlldy4gIFRoYW5rcyBmb3IgeW91ciByZW1pbmQuDQoNCj4g
QlRXIHVudGlsIHRoaXMgaXMgZml4ZWQgSSBpdCBsb29rcyBsaWtlIGlubGluZSBXUnMgYXJlIGJy
b2tlbiBmb3IgdGhlIGV4dGVuZGVkIFFQIEFQSS4NCg0KSSB3b25kZXIgaWYgdGhlcmUgaXMgc29t
ZSBjb21tYW5kcyBvciB0ZXN0cyBjYW4gdmVyaWZ5IG5ldyBpbmxpbmUgV1JzIGluIA0KcmRtYS1j
b3JlPw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gQm9iDQo=
