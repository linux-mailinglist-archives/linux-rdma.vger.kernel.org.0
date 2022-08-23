Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0859D0BE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 07:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiHWFxe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiHWFxd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 01:53:33 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E710550
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661234011; x=1692770011;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KdCSVzq/t6kFDOqPi5L6SUnd768ncM0XvxNYanfOnj0=;
  b=QWR5TBTxixP5yybrtF+kZ2WeDeNxiIeptNf7FwXPaiTwmpxnCAwwqtFF
   zEWkWTwTcfPkKRXjPzd9audlv4YNM4HJnqMjovPyYJdsbMI1yuDYG2+SJ
   kgdU7bZeQyinmHC62WJXcsRAT3tlnFFcpf08dzNPBKna5+iXIfPtNoj5z
   06/CJOC6jz8XwVvUyenzGKjIbDpi/oMLdQpAXB8tOhPMDzr9j7kbubIKN
   2tCapzvm7IIED5by4CGZfuwm4oiy4xQMBrEHy7iCAWNz3UqVQx0fJkmCV
   T1tjUM0rmcWzGED3C0gCGfBJrgSSg916QiLF1aNqZUhbv6k//41PubT2H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63286353"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; 
   d="scan'208";a="63286353"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:53:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl3znRsVv3c+dlvnq6fL3sNroAbfRbtcCnKNjN/3m+ri9D6pHwJhch2Psf6J4biP6vgLcNf4vqOlhMqdxNaIgtwUhxDrCwh8EQ+APbqdCuDNFlkNLy8d2aCfkxD0RLnnomQvylCSTi/fcEfY2YTXrJTn95KVnlVmRFanLafNDKWLRJDuPbzXL5cP8d+yjS/kdYTw4DwhVB3m0pDwJg3r5TXVhEHVRzjbmZdQHbRvSD1J6U7h9IwHrJ9arlc5bxF4v7MgKMEF+Z0+xI9T2OTZ3XzVEEMyTVdDMDid9f5gDpniwMKeswOkFZmWSn3ozNNwo7alr5oZmh1R1Kym/q1pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdCSVzq/t6kFDOqPi5L6SUnd768ncM0XvxNYanfOnj0=;
 b=AYbfPILQsK1RHObWx9BwUGj9QCFUf8cJdTrsVLOeXm70F4CS50pdNBPZ5SytDhCcJJI+a9i9XRMpYSz+wOy7Ooys6yq4RP5pt4s3gvkca/8D2dMuqzJ0T2buTxPgCiAihMHZ9C6El0tTf2doqSfyg6K3Rq0EFpO77rpkXwyDmajEurX8aHO9iLDZ5aJ2F16j+FBv+GtjtEjcadSf3Vv6rbClWnZvRP+u5T6AmWgcH6ZYP+e/l9eSP7GU/cIWwZPXES28cTw67p/ubccSkydtmJWDISDmCzi+ZpA7CZMqQlYjzBZPTndPfX8EWpGF+gpTyt0ETiBs1SeHqCat5gtozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB3383.jpnprd01.prod.outlook.com (2603:1096:604:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 05:53:23 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6%9]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 05:53:23 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 2/3] RDMA/rxe: Fix the error caused by qp->sk
Thread-Topic: [PATCH 2/3] RDMA/rxe: Fix the error caused by qp->sk
Thread-Index: AQHYtTrtq0nqKyZRgkqJT5fOAXjpJa27SKWAgAC2B4A=
Date:   Tue, 23 Aug 2022 05:53:22 +0000
Message-ID: <c1e7eb0d-3dbe-06b8-7b31-3d811d82d032@fujitsu.com>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-3-yanjun.zhu@linux.dev>
 <8038c20c-37e6-bd39-54d0-be56bd88c1f9@gmail.com>
In-Reply-To: <8038c20c-37e6-bd39-54d0-be56bd88c1f9@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6bbceb2-8a9a-4bca-37cd-08da84cbca31
x-ms-traffictypediagnostic: OSBPR01MB3383:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8wShKGEzYw3KCScj0ePS045VmaDzi8w+oc1TMHAK7brtW/umXAe6KC0i5Cdhj0e2+UZQDH+BMdjtbwXYXgaj1xLuWFnyP+CHaiPfJyJkxgQXYMhtmLyVbCJtN67DiMRyqPVKlMWtrcDmh2p3tJ5pfYAADwl4y27FZP6BRGRwuxupxNYMHxPjRG6hfofFJnPb4FXjBCVH9IZUf3wDFz/0uBIsv2du9HKHChhuL4mr0e6WfzpomaiV7Pz8Lisw/XL3nCNuOrfpDuk31LyRD8BVt6+L0jgw1IRAjJbJflhgPuTm+7yZ6x7DLADer+0CCa9qlgEf3A4hqduhhzX3z+lTV2rsrf13WTTpgNM84wX0Mm/Y0gWQkwOhKRxaemr6oYxd5VKD6NndVBou9ECxG/CHgS+tucQ44y8Z7QwCHNsZoIFr8y1RW54KoNd2XEAm1hbrOMgmN0gXCTUnXkYJTrRtx2B4rJam/VycEyFG5ZEajftrHK0xH2z5s5JIUAd2iEvehgzT2PVyvxY+73/vPVP4EhxiYjBb11l2AGzFwH+cDVhBEKvtgMU5vz0GUBkBdRfuMVq2WSo4Tw69Z6I0jtJwRIokMNoMIjy7hXnCLHIvwuisEQsxQfg+J7GLkwUtSGkl5RFO42Tpa6+dYjp3C1M84MB+021NxdeTz49PPtY03UfcHc71yJU/bmlpnyUEFs/PgvMWtT1NS29eBgPBeEBPSwQj94OxXnnWWGqYWCT5Ksk+q+d9SXQrQLezxR/pFTPIocvOecUfyS7lMpZwWhkioSyFjRR3BHERGF7m4rB61ipsoZVBN4h+iFKD6QWXSVZRlaf+LGdNkScLhNJwBs9TbUoVJ6RwFoWLydacTyXLvi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(1590799006)(76116006)(122000001)(316002)(36756003)(85182001)(8936002)(110136005)(82960400001)(71200400001)(83380400001)(38100700002)(31686004)(478600001)(66476007)(66556008)(6486002)(66446008)(66946007)(38070700005)(8676002)(64756008)(91956017)(186003)(1580799003)(5660300002)(31696002)(53546011)(2906002)(2616005)(41300700001)(86362001)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFQR2dpZE1vN3R3blJyS1d2d25zNEdjR3hWSWpQdWpMMWMzY1czWEV0VUdW?=
 =?utf-8?B?S0ZPbGhYTi9KdFk3WWg1SWQvK2oyMUE3MHVQdkJXYytjbzdMSnBoa3VYS0xY?=
 =?utf-8?B?VUVJWEpqa2UrajNuTkFzNW9TZG93blF2UFpoQzdCdTZlSEFmcW05UjAxazFQ?=
 =?utf-8?B?c1B1UVdnTlRFUUREa2owZnoxeU5JN2dBUDNHaTVGYjF4SXRWam9YSUVMYmZL?=
 =?utf-8?B?N1hONVdsNkd2dEtoUjF5VUNETEVZNU50YmpXWk1iRC81MGxpVjFkM1lNMFZ5?=
 =?utf-8?B?Zmg1SzJsRXZYOStPYk13WGgxL3l5WXFGM3FCQkRhcHByc0s1aWo2K0FZUkM2?=
 =?utf-8?B?RkYxcTgyWVowQkg4Q1BUNDdtOWhlcFdJT1R2NFE4M1Z1ZGhOVnlnOEZiUjFC?=
 =?utf-8?B?aWs0bTFnREJtQ0IwTWQyOVVuSlZYUndTL1VWSU0yRTRJSUw3TXpyYThlamkr?=
 =?utf-8?B?RUw3YkI1MVpYUVpMZ3RtU3lYSURyOEUweXhnaHg2N3ExMlI5UnZXQVo0R1Zs?=
 =?utf-8?B?K3puRUFaNGhRZDBqb1pFZ1dMMFhvak9icVZRdFRpS2lBblRzU2VxUUp0b1dD?=
 =?utf-8?B?dEFzbU9jOUpUZEZST3RwUFZaTkF0RExsM1lxT0xRTm9NdVZyakxDaWxndUNx?=
 =?utf-8?B?Q0RudGZFdGpEM3lPcHhEbDdDUnN0aTIwL1REVnJuU0NyNWVVeEd2VVJER3dU?=
 =?utf-8?B?ajh1TWlOK0pNRXhuNlpsYzB0S0VwZ3RXNjM0ZHRaTGtMQXVzR2tqQ01IZlVu?=
 =?utf-8?B?NVE2am5mNmhkVHBrakZKRGlMWVdKbkF0a09LeTdqNVpkTXJKd3VPRFF0WXEz?=
 =?utf-8?B?Q3JhbTBscU1yR3NUT3gvRW0zaWxoZWI4YWZ5OGNaQjNKRTNvakQweVQyb2Fz?=
 =?utf-8?B?OXcvK3pzc015WVhJbFh2ckpmRU9TcnZCU0JHY0RBMjZtVDVMOVUwSmxTZXVE?=
 =?utf-8?B?bEtQdWxObE12WDFGMWdiWVNGeXdPd29pR1dmK285d0V1cVFXZm1vYTgvWGQ2?=
 =?utf-8?B?aHY4c1JLZ2JZV2pMTXZ1SUl0N1dBbVdCOWJTbnJCYjI2d0V3L2JpSFQ4T093?=
 =?utf-8?B?Zmx5Ti8wV3kzdGdMLzUzWFZ1TmtZajNnRTg0N2d5SzRoSVhIcnNOSTdmMHox?=
 =?utf-8?B?ZGN6MnZRcnRRMll0UzZvL0p0cnRDc3ZPdHJpS3dLeFc4NzhzWVU4dHhMMDVD?=
 =?utf-8?B?Y2RrMkExVGhpL2FIWkRjY0docXRCbHFkNllFRnVmUW1YNUZFS0RWaXVSSG4z?=
 =?utf-8?B?TXdVMUVUd0JFWnpad2xZTk5pKzNDV1ZiUUszZllKMVNWTTg5QXVFRjZ4TVJs?=
 =?utf-8?B?anRPMlh4QjA2LzhTQzB6ZWw3VmpUeml4YVRNcXNXTng2TWs4ZXJWbU84d0c2?=
 =?utf-8?B?VmdTUk01M3UvR1BQcUd6UDZaSnNTUENlbkE4T29WcXh2M2NHVjQ5ZU00Z28z?=
 =?utf-8?B?Qlp4bUZsODIrMmV1aXRjQXhDbUpQOWVuZ0NZOUUyNUJ2eXZCd3dnMy8xS0JE?=
 =?utf-8?B?enVMQzAybWZEbEV0OHB3WGplMWxGT3FSbGkwRFd5UzdnZm5wZVZiNTU1cDdJ?=
 =?utf-8?B?SXJPR0hPNlNRR05qb2dEK1VRU3lqNnJMOVZTSU1URTYzN2xGRVFCZWFwaUFK?=
 =?utf-8?B?cnM2TUU5c2dmYS9tRXRLWng2NlNjVm9XajJnRTZRTTVXeTlJR25RdkZhOW5W?=
 =?utf-8?B?azU2d01CRk1UaUNNYnlMTTV3eUJ1SFVKUkRtSDE5WnllRjZENVdlbWxBc2xt?=
 =?utf-8?B?Y3ZzRFhsQlhiejhLczBjdUR2MFNGaUNUWFZqbUFHSlFpWWFOZnZRSnUzYmZp?=
 =?utf-8?B?S25KWk5UbEYxN2pmWlp5NWhHSUQvb293YnI2RFNvclVadFd5Yzc0aFRiSURF?=
 =?utf-8?B?Q1psamEvSlVGQmlpVW1Kbysvc0sxNU9iQUV0V2R4MW9CV0pncy9wRVMvNUl3?=
 =?utf-8?B?WHUyY1NtMWpOelBVS1VTSTltOHA3NXZUdmcwb2ROTDc3Qjl4bjl1dS9OS1N2?=
 =?utf-8?B?aERYWXpTUi8yQzV6RC9CeVJ6U2RHYk5sR1B4YXM0NzROU3RRaXg1a0ZFNlEw?=
 =?utf-8?B?VlRteSttdDRTVndqcERKazgycGVCdnlDT3l6SlIzQzFrUVR5TEVCMUtKTE15?=
 =?utf-8?B?b0lzZTBJcjB6TUFSUlBDRGMwUWZCdTJOejZRUkowRmJ0b1dhM2hrK0xUK1cr?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF20A8CB1CAA74AAF9E4D2DA62463CD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bbceb2-8a9a-4bca-37cd-08da84cbca31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:53:22.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLnSdv5rZtzBmH07w/xMCCleyPR0rxhp+ecW6yIPm5r1iyvrQNQiepu0W5YTyXhAVITRZ7LQ8TShDTtD3vXq8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3383
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjIgMDM6MDEsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA4LzIxLzIy
IDIwOjE2LCB5YW5qdW4uemh1QGxpbnV4LmRldiB3cm90ZToNCj4+IEZyb206IFpodSBZYW5qdW4g
PHlhbmp1bi56aHVAbGludXguZGV2Pg0KPj4NCj4+IFdoZW4gc29ja19jcmVhdGVfa2VybiBpbiB0
aGUgZnVuY3Rpb24gcnhlX3FwX2luaXRfcmVxIGZhaWxzLA0KPj4gcXAtPnNrIGlzIHNldCB0byBO
VUxMLg0KPj4NCj4+IFRoZW4gdGhlIGZ1bmN0aW9uIHJ4ZV9jcmVhdGVfcXAgd2lsbCBjYWxsIHJ4
ZV9xcF9kb19jbGVhbnVwDQo+PiB0byBoYW5kbGUgYWxsb2NhdGVkIHJlc291cmNlLg0KPj4NCj4+
IEJlZm9yZSBoYW5kbGluZyBxcC0+c2ssIHRoaXMgdmFyaWFibGUgc2hvdWxkIGJlIGNoZWNrZWQu
DQo+Pg0KPj4gRml4ZXM6IDg3MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQ0KPj4gU2ln
bmVkLW9mZi1ieTogWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51eC5kZXY+DQpSZXZpZXdlZC1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jIHwgNiArKysrLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3FwLmMNCj4+IGluZGV4IGYxMGI0NjFiOTk2My4uYjIyOTA1MmFlOTFh
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPj4gQEAgLTgzNSw4ICs4
MzUsMTAgQEAgc3RhdGljIHZvaWQgcnhlX3FwX2RvX2NsZWFudXAoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKQ0KPj4gICANCj4+ICAgCWZyZWVfcmRfYXRvbWljX3Jlc291cmNlcyhxcCk7DQo+PiAg
IA0KPj4gLQlrZXJuZWxfc29ja19zaHV0ZG93bihxcC0+c2ssIFNIVVRfUkRXUik7DQo+PiAtCXNv
Y2tfcmVsZWFzZShxcC0+c2spOw0KPj4gKwlpZiAocXAtPnNrKSB7DQo+PiArCQlrZXJuZWxfc29j
a19zaHV0ZG93bihxcC0+c2ssIFNIVVRfUkRXUik7DQo+PiArCQlzb2NrX3JlbGVhc2UocXAtPnNr
KTsNCj4+ICsJfQ0KPj4gICB9DQo+PiAgIA0KPj4gICAvKiBjYWxsZWQgd2hlbiB0aGUgbGFzdCBy
ZWZlcmVuY2UgdG8gdGhlIHFwIGlzIGRyb3BwZWQgKi8NCj4gUmV2aWV3ZWQtYnk6IEJvYiBQZWFy
c29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo=
