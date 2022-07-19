Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F51579069
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 04:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiGSCFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiGSCFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 22:05:40 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7B635E;
        Mon, 18 Jul 2022 19:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658196339; x=1689732339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vVyqoGLfWomFJbarQ9zUvgN4DK6FxlTtQoJQpFLlR4E=;
  b=ut0+Rm3cO8/MdmSPuGelxmXe7c9XgWSQJHUs7CyIBMxkTk1FPJLl7m69
   E7FwF7A3enyiijWMBAvQ28UqMqrFM+INre7dYIDlW/spfnl5CxaMajWwe
   OOg7qDqmKODNUOPVyxnbgarL8CYbzHHopxLD1CeisCxM1d+pw5RskAfcO
   hApJbKNWS2uXD6j3p+OBJ30bETUJJ4AD94mHRNaAmNHzmGHkgzB9GpOJM
   HqzDo5diNHOP90cXSYTXwwYQfIOqeI6wxtzof/6R7lAv38Hca7RoLfmlt
   vccp8jLMKyouNNc1+B6RG/f7hab/Th3Ls3Mez5P7vc9Rft/4ml54vDohi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="60759348"
X-IronPort-AV: E=Sophos;i="5.92,282,1650898800"; 
   d="scan'208";a="60759348"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 11:05:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjSswWPXjR5bnrcrM7oLpi1CfUyWEpjK0+8OjyoRXgJ2tzyC5qUR8M3KSWZCF75a5Pk0YE3deYsFJJjtjsd+fPlsj+4fW4wQewc4wNQjnGgBfWyZAvug8iyAo1DSJO9DizArumbX23O+vU+UHUZbpdU23t7+AN3dbssU9jGUW01+X4az8IchN5ZHXGmwUjnbyhqlE1S7A2ZJvwdoRHBqGm6JHymwhZun/ClXIJOvWieDFVgJglHtOOOFnb4Qq8D8YkYJAt6B+L+EoidHKTXiZWyujb7qoJHC5FZRLDSyEDwV0uJ2ae85MzQdrY46hfFJpPgpNpg13FDXSVVLjgbWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVyqoGLfWomFJbarQ9zUvgN4DK6FxlTtQoJQpFLlR4E=;
 b=Tst4iH7LYrnQ0Nh1cFYN+tLpN7OrIm1VBTbIdEU6KA8wpymp3diUGiO0/FIom9RWNxMDyNLprUVqblVQL2FZT6R0HJZx1cKftqLZX8jTg2VyNmxeF4eHttmPQMSmrK2ka+2MrKyXAlqipRihntSnIM77EOtzmySPBiZcBpUEdahgRdGF7PgkmiNApbKFgtsI0zOojk0ERclJOLWyOF9YFRIbdFuQsB2PcXDnxg+ZE2+6txO54X8pmmU86oIRmDA/jxWLkinj/BrdgY2FR3ITkjh2ECjMDoNqwGligTCp8RnzwSmUAzbXoHVdqR5u8uOTWbWVCPyC0MQrvY+NpUI8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVyqoGLfWomFJbarQ9zUvgN4DK6FxlTtQoJQpFLlR4E=;
 b=b4xc7Uwt4eI4kCyY7yfd836bHkK648K5opK8sNuIKBwESrl52DO54D+zrdR29npnKg85UhrS9C17kI7VU/Qp/MyF/tsvCiV4lo01LKqKeErxZyBdrp36fi7MznJBAG4s5Ig1KjeyIhtxHDt5yyaUMrdz4Q0jbvNyQYWIybHMP7g=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB7726.jpnprd01.prod.outlook.com (2603:1096:400:17b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 02:05:31 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:05:31 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Topic: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Index: AQHYiqQVAz0l7XdYxEK23PWDS7bZxK1kVYQAgAAAlYCAAADQgIAAAbUAgAqj5QCAFhY9AA==
Date:   Tue, 19 Jul 2022 02:05:30 +0000
Message-ID: <33e90f37-c201-9ac6-f65e-3646341dcc2c@fujitsu.com>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com> <YrqbNfF9uYMSwZ4V@infradead.org>
 <Yrqb47ozk5IWTnWp@kroah.com> <YrqdUpLVbLF7WNGs@infradead.org>
 <20220705004809.6guf43xwjpq33smo@shindev>
In-Reply-To: <20220705004809.6guf43xwjpq33smo@shindev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28995670-f667-4c73-9364-08da692b28ba
x-ms-traffictypediagnostic: TYCPR01MB7726:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efl8zrvqdSw1hlxnQ+eubi66KgSYlXoAbHj2GqeQiB2BZ2MWRsXTdmFEVYP0q8uhlruh8esjQb0W2HgMBpe3RVORbLCfACf8HYiWeOs8Lughhfd7VDUXy7cDx8U06EUvgXC884KzDwM6cNUlShNejVgeJOngGSHxeIBpanuKTf6GtUSVIVHtyaGUQ95eny9tKKGt6rXK5QtacMRh9oCRvjsR+Jx3JgtWsXu1r3oorZboR2va/a3USN5sHvZpgYChIAIr6cZmWc7IBI1+x35aVdqBsxb4rhbLbPuBwdvVWJmXRju0VU4m0Wy9nFkApP6cEPrlffCIzEsXaKnNA67+ryu5rWCX6vgzkoaYhFZeHUITqzRyo85Sp/oCIUVW5wwbg6DhiK/wdbZ9HF8IOH68nGKbls9wl1RrV+R04OoDvFp/Fwyb1kdxEirXSYmQVhIGQF9cg97OLNQttX7QxPMul4+8hAQVGCDzylMjzuuk89B0Dd9bXE0oZKR++Z3LSDzVY8RZptpu7BV7QzgjQY4cGU+HNXsdbHJ4GG+qhy+zk6Hv9oFOZ94yiOvUcaWzMhzFsX3OhlTnLKprIQLFMajGHp0rkR2trysUF4rpD3e8nBBhcl5nz9hHTCne8Bxk5oLsJwU1xI8KIHSJqwkSNkqbNAgbGhtYjq5DMSUdhO0XJBsuLssoKwP5DAsIPdCwaxoDdoEqT3pw5oDZq3z5k6ZCZvZvswbvqUW05kceTxq6J5z5B904uKN7x31nZlEKY6xhHFeyzyGVQOb98UGuEGRsKIEuRi53KuvvttcHdqlvGpeHbyvLYrUcmBpGwcAxhFgQuYXNRWxxasRTMa2jXqvYW5p5HvGflS1U3ZRKTvVtLyv2JuLbwVipuNrIQ9IJmuzi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(6512007)(26005)(53546011)(41300700001)(478600001)(966005)(91956017)(6506007)(54906003)(86362001)(38100700002)(31696002)(110136005)(122000001)(6486002)(71200400001)(8676002)(38070700005)(36756003)(66446008)(2616005)(82960400001)(66476007)(85182001)(2906002)(66946007)(66556008)(5660300002)(76116006)(31686004)(4326008)(7416002)(8936002)(64756008)(186003)(4744005)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUs3ZitDRDA3K2k3V3ZITXZocVNCbFU0ZmN6OXFaUjIxRndOQlpnakJISnJ6?=
 =?utf-8?B?ajUrZFN1WURXMEVkYlA2Yzh0WTZDNmJiOHNyZEt2R3dXTDl3UjRjMUFYaWpL?=
 =?utf-8?B?d09oSXZtVkhnc2NKc09vZVN3blREZUZ2aGpwQVlRR0VKS2ZWUGMrUWYyVHVZ?=
 =?utf-8?B?WVpXMGpKbGtvVWZhODdQY0haWnorMHcrRzJFS2hyN3JTTWU1V1U1OHhySnhF?=
 =?utf-8?B?ZnVJSC9iTm5OanJsaEZvb09EZlNUeHNxblBUUUg0dVRwajdXTU1lREI4SHRS?=
 =?utf-8?B?SlFUNUJ0RGxJSjFrMTBlT1FyaTBWVGdPRGs2MjMrczhSNzdGZ00xWE1uUWNo?=
 =?utf-8?B?bExIbHFGbkk0aFV3Umo5R2U0UWFadUg0T0hxenFNZFUza003SUxRUjBiWFBU?=
 =?utf-8?B?cmwvQVp1UE1KNnQwaWNNUVVvdU96OW4wS0NCeHhZdmw4djVKZjBxWnF3dTZy?=
 =?utf-8?B?dUxiZVN2TGRuY0MxNk9iaDhxRlVDWFhGQkpGK3hEb0hQZ0RwMWJyNUlVTzVm?=
 =?utf-8?B?eU9SMmdXSVdiTnN5S3RBL3Y4eEk5ZGppejdyQUdSY3czRnhwNDk2WTYycDcw?=
 =?utf-8?B?WThVaDJvTjN3c2VSajlEOWVxQ2kzNWtUTzdRSGZtRGxtUCtRTVBlTG9rd1hh?=
 =?utf-8?B?MEs2V016YTNFczlqdm1hNEJLeXhxeFBTL2JWcWxpcWF4cVVqSGE4ZVo3d2da?=
 =?utf-8?B?WHVBRGw3WFJpVnFIYUdOWnNCWGJkeUJzcmczc01KVHNZc1JNejNyNGNERXMx?=
 =?utf-8?B?UFRaOGh6Ym1jM1o4QnpyOEx2K1Bqdy9NUm5ydDRtZ2I1NFRhdkY3Kys5cUpL?=
 =?utf-8?B?UGdERDBHVytzRWRWSzlHeVRlOWh2QWUvQjFBemtoeE1jVjFHalBSeURtbisy?=
 =?utf-8?B?ZHQyWlpJMU9YOFNRdE1URkVKMnVtTTIwWDlnU1V5RHRUV2lycWRxNzNPQ3J3?=
 =?utf-8?B?eWE3ZEhTUWZUaTBvbTJBSit6ZHV6VnJiSGF3TkRwbldHRjQ1L1IvUjhQZmQw?=
 =?utf-8?B?ZXN0UmRkVWQ4dFo0UWNCbm05cjJja2NPWHZPNlZoZXBuT3pDdjRuKzltb3B2?=
 =?utf-8?B?OU90K2xYeC9RUXBISEhiZ3BZNHByUDZTSkJ5Rnd5UW1CMVpDeXI2ZHdlK0wz?=
 =?utf-8?B?SjJHeTZ1MnFJcVpHWUdmb01FUEtLU2wvOFFiZ2NVelQ4bjc3VU5aTUdGL2hj?=
 =?utf-8?B?WldnMzZjaWkwWUJ6dlRBSkxmMWh2NDNRQk1odHFDQVVNZGRUV2ZaZVV2WnlN?=
 =?utf-8?B?MFNiQTRZSVlvZ3dZOGQ1b3BvaWJkQXZ6Y1pURHJra3hCQllTRldDWndaTktn?=
 =?utf-8?B?elNQMk9YR2haaHNUM2lCU2xkRnBwbUVRU1IwMXNZZmlYdVZaRGJ5N1dIQVdo?=
 =?utf-8?B?Tks4WUFCTWlPOUoveHdXSW1paCs1KytyRzJBa1p6TzB0RGN5bS9jM1dUK25y?=
 =?utf-8?B?YXRzSHNsVHJXRGNQV0V3T2VZc0E0S2c2YXpyNHNaSFVjOHZaRXRIQU1uL0VX?=
 =?utf-8?B?b04xTTZIeUwvVG1VeXNMdWI1MzJEb2NVczZsYlJkWmZneWNRbytHU3BBNmhS?=
 =?utf-8?B?azhUSGxVRVhxNEpCU1lBbmtXVlFOdHA5NndwYk1oeTN1NGlna0dUeS9QUHFv?=
 =?utf-8?B?U3NzVXVQM3I2RzNkVmx4MnVvSjVKM2lNRWpzNCtBWlFvREVHNy9JZXpXcFFt?=
 =?utf-8?B?VUkwbmJSY3lBRUVkWlFMcjYvY2F4MWdUWmw4V01IYnRLcWs2U2RtbDMxV2Fs?=
 =?utf-8?B?VDY0LzF3ak9BREd4dE5BS3JPWkRDb1FGNzRzbmZPU3ZwSElnbTJnZVpROVFl?=
 =?utf-8?B?NUwveURjbDJRdXNDTzRDYnkvVHZHOEdSYUNPTXBrVHdWWjA4M0Y5cUd6SXJ6?=
 =?utf-8?B?TkNHckphdjkrMHJibnYyS0h3K2x5S05Wc093eklvT281VUFNWDV1ODl3WE1Y?=
 =?utf-8?B?L2ZOZ1B6Q1Z4ZEM3WEZTOUI1ODZLSEdRdzBDMUVKeDQ4Y1o2UkhnTHg5VXYv?=
 =?utf-8?B?OGh5V2p2a3dvYzU2bFozNHl3QjJreDRqQXZtZWF1TGZlNjJJSXRqU25HOFV5?=
 =?utf-8?B?N0lTQzlLZ0krTHdQTHhxUzBTaHVubjN4SGpQdHdyaXRvTWJ5R1V3L3RQN1Fv?=
 =?utf-8?B?THBBMXBYTTJsSXdyQUVLSzVnbldreG9jelJNb2s5Yis4a2diUEllVlVxV1Aw?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <619874469969BC4F8F5BC2B6B54DBF4E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28995670-f667-4c73-9364-08da692b28ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 02:05:31.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9xYIttDdy8YIacSh3hhBe9PWtG/38BQ1v4y2ZO1105Dg/4tgoglFC7/kU3dwjZBfU+PxoejdtQHykfQxCewtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7726
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzUgODo0OCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gT24gSnVuIDI3
LCAyMDIyIC8gMjM6MTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gT24gVHVlLCBKdW4g
MjgsIDIwMjIgYXQgMDg6MTI6NTFBTSArMDIwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0K
Pj4+IEFoLCBzbyBpdCdzIGEgZmFrZSBQQ0kgZGV2aWNlLCBvciBpcyBpdCBhIHJlYWwgb25lPw0K
Pj4NCj4+IFdoYXRldmVyIHRoZSBibGt0ZXN0cyBjb25maWd1cmF0aW9uIHBvaW50cyB0by4gIEJ1
dCBldmVuIGlmIGl0IGlzDQo+PiAiZmFrZSIgdGhhdCBmYWtlIHdvdWxkIGNvbWUgZnJvbSB0aGUg
aHlwZXJ2aXNvci4NCj4gDQo+IEZZSSwgdGhlIFdBUk4gd2FzIG9ic2VydmVkIHdpdGggcmVhbCBQ
Q0kgTlZNZSBkZXZpY2UgYWxzby4gSSBvYnNlcnZlZCB0aGUgV0FSTg0KPiB3aXRoIHY1LjE5LXJj
MSBhbmQgc3RpbGwgb2JzZXJ2ZSB3aXRoIHY1LjE5LXJjNS4gSSdtIG5vdCBzdXJlIHdoaWNoIHZl
cnNpb24NCj4gaW50cm9kdWNlZCB0aGUgV0FSTi4NCj4gDQo+IEkgb25jZSByZXBvcnRlZCB0aGlz
IGZhaWx1cmUsIGFuZCBzaGFyZWQgd2l0aCBsaW51eC1wY2kgbGlzdC4NCj4gDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjIwNjE0MDEwOTA3LmJ2YnJnYno3bm52cG53
NXdAc2hpbmRldi8NCj4gDQoNCkhpIFNoaW5pY2hpcm8sDQoNCkkgd29uZGVyIGlmIHRoZSBmYWls
dXJlIGhhcyBiZWVuIGZpeGVkPyBJZiBzbywgY291bGQgeW91IHRlbGwgbWUgdGhlIGZpeCANCnBh
dGNoPw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmc=
