Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380C3F06CA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbhHROeT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 10:34:19 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:28425 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239476AbhHROeR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 10:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629297224; x=1660833224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X02mlLsAgxS9l8usWAq8WkMkeh8siXGEhN4Q9hoBEeg=;
  b=MAleOfDjT6QeHzNn8sTEC2q9YBeiOjmd0TGYiUaUh3cdMZPZ2UQ3lMD3
   rt2FUG5kK+XZgzQDuzi70vykGAFAghmnulkfjCHHlyfIOcRooWRJ943fs
   neVDjeouabas7AB3l6JR2Gm6cDj6S0jsyoXOaMdioi9/0MWyOiMBAvQcp
   ckxw8sUP9Qz3Z81yzGkBGNadW4Ff5XZRSFC4fEK6LJ0D+enRyVrGRw2Eb
   CtK2RqPBf8hLkcrKo5DbV2fB/fUSkMo52rhHdEhHn7hF8tGNtpY3YKlGb
   oiZM+4oWftYEGDVskcweIc0XtJh4SJ5gUTRUkt4YFCx9sPao4wCtuRD6f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="37557138"
X-IronPort-AV: E=Sophos;i="5.84,330,1620658800"; 
   d="scan'208";a="37557138"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 23:33:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9L0Lf3refI1Pc/9RoEp4aGOnjuf2Ax1EvLO2EqGVJy7eLo6Y51i3cVoQ8WNKFTUkwLBpCDZ5qjoUzOaKTQx0AKFBGQKlDlWipWQizvl6ovWTcx74VCaLoWlmSNH+1bcRhNWgFCBepAJBI69G+5ng8mozHWOHwH2t9Pc7Xr2tNYWHKvMdnEfnE+2Kp11wshXIlWgZEiiFAOmgC6eWCFrGu94VDAqz3tJ3i/paMS2+FOL/ZHhPQ+JUtH7R6R8R93KeU0u5IJYnlfq8m9y9GotiqwrrKHbqVexUapR88WelgbtFXAAaS3bMZdcSbqQpQnWxHgFpSi7HwvQ0kABun76fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X02mlLsAgxS9l8usWAq8WkMkeh8siXGEhN4Q9hoBEeg=;
 b=gmML5eFafI5O6peCwz3ARIFyUYyEuHWvFVpv1g5C+Mmt0+ZFi3E805HiXTw3wFlBXplrFoe+HTxR0f4GblC6211wXXGGeUcsLfmxRuYFFPQ+o0rZYgjnJI8CV12nJf5dCtgLjRJbtZIv2LIMlWz1tZrsELTFQ4pld/7T7MMeEIhIDOafz9vo1iOLMPZwJNAvq/n7VGdbCi6aXRpncYKN3Wi/3RYBmYEGs9stYljdIflgPQxmPhls0BfrRIfGHWa8/7SjdS6bGCydnXH11NdCFEO29GB6rPWFb6afiTBjNfcQuDypqJeRcAywnOMx2dFfSi2Isf8g6f/ZPV2vlDs+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X02mlLsAgxS9l8usWAq8WkMkeh8siXGEhN4Q9hoBEeg=;
 b=TJkWIlQS0RCQxOHX1E4KGvaNqWd8SWz9VdPAY3VaLesjko+ij8m6NjYV6aSDAlnB7YJKaD4da635De+vDJyn/8GxjhKsRVCnWCinn+U8UzTmOnnsAkYrQImFFXKOMqKEveSO5mp/hCGsDAVAwb3l/N0P71Qq7AVHCnEvZKu3nGc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6642.jpnprd01.prod.outlook.com (2603:1096:604:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 14:33:37 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 14:33:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RXE status in the upstream rping using rxe
Thread-Topic: RXE status in the upstream rping using rxe
Thread-Index: AQHXiJKFs2Uwv9tDRE2C9sy1eEMhGKtih4KAgAACJ4CAAEvmAIAAOPAAgAK4PQCAEUcwAIAB2XAAgAAKroCAAAZwAIAADHiAgABl9AA=
Date:   Wed, 18 Aug 2021 14:33:37 +0000
Message-ID: <611D1A3E.20701@fujitsu.com>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com>
 <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com>
 <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
In-Reply-To: <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 363dde77-0acc-4d03-0d0a-08d962552a9e
x-ms-traffictypediagnostic: OS3PR01MB6642:
x-microsoft-antispam-prvs: <OS3PR01MB66425D5CBB044834A6B0601683FF9@OS3PR01MB6642.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PE/FIiPAFzpWc+Ip2EmCiDl4zKz2myGJDH6amqYljiTWHPeZITC9JNkSASYSvVz3nUq/ZJFTSugORXG/KlpUp38NlcEG9Kx6xeNttXyTbyJa1eQgGfcur7PsT2Cz0i3VQyHlagzxAy6AMW5W4iw8MHMeyNasez/jSdT1uDpVUvZtoMP2k8lqVPwilXig0c/7JlzMS6Ec/ITo+lVyu5iHbkjotSvHYvMu0oU77x0YRqSv1Zn+HiRoH9h6fc4Kjjhf21Go188xbEKJ1boHDJm9rMxmtlc6FTqe5rBSHmyAaFpie+WL5kNBLMUzCy6iYRVsCmdKa1CyGJ83SmPOSUJzR54B5L/dHZ/p3tqmmqz5YNWXJ4POPJXfP7jdnC91JKIkuZX8raaoo+5tDAolVbTBONXNAtg3WFJm0kv471EgNsFtirqOMl5E/ghyvfTThNAuJCWTXSeNBcB1IJEV4AqQxG1xDdif863R/QIiFLmpFd8mLDMYMmdgikWTltKAjJGtJ6+z7aRxzs5WL4L1QJZDW28PQ8txK0OU1hd6JmE8pjMXCWKMrJHUEJVWa2RdTbhc5ocVqGBDsxOwPOmS4EvWoNRw6kpccZ4tBunjUyO0amKP+H0ypsfe8fOUkpp4fzQvDkI3R7BQHiQqeBcerC+bPmXM/R6YHhx2cBR514dM4ueFw39Z4DN53K3mBiqGNHmiy9zSxtILmZhZmtV+dBLI/jTXPDTLGhQ1Ck10l3Rg3g8oF+u3svJ/PZrL5wkxbqnZr6Z05rZULK8t0JkBFDbTyWLQ2ZrguKrZhzjs9EwjaFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39850400004)(366004)(36756003)(54906003)(6916009)(2906002)(966005)(86362001)(5660300002)(66946007)(6486002)(38070700005)(33656002)(91956017)(66446008)(76116006)(478600001)(66476007)(26005)(66556008)(8936002)(64756008)(2616005)(53546011)(6506007)(4744005)(4326008)(8676002)(316002)(186003)(85182001)(122000001)(6512007)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SldUdzg5LzkxejVPVnR6VEY1RDhBMitublJ3MHEvV25WK1QrRFdYOEhWNUVm?=
 =?utf-8?B?YnV4cnFvUEFmZ0hhNWN1UTRxOXB0RnFWZDhwU3ZJVFBIRjF3YURRclRLbXJ1?=
 =?utf-8?B?YnV3QzVya2gyQkN3QU1oTkFRa25jN0FpMGYrS1NIWDVyRUpYSjVDcUR6Q0x2?=
 =?utf-8?B?MXBreHFhanJTd1htWEJSYVhjRnlRMmJhRmU2RlRkdTQrRVA4bnR1RHFxdkpS?=
 =?utf-8?B?TFd0MmprUGRXeFRIQnN4c21PTmdTQjdQU2MwOGp1NXVVUjdUWm42dVFiY1BZ?=
 =?utf-8?B?TFJXQU95ZGNhMUdUSkNMM0JNdEJORWVLa0JuSXNneFhCVU82ajFOLzIyc0JG?=
 =?utf-8?B?QWpsYkhxOUYzQSt6YVhiTU9rR01tR0g1SGtXdCtSMkh0clpyY1A4SEhiSUdN?=
 =?utf-8?B?Q1U4ZHNnWVJuNVdhdXBxcmMwekw4bjFVUU4rR3RZRVhZWG1RVDZmTytvaHlz?=
 =?utf-8?B?MHh3MnJDOVA4SHc4em1aRU50RXhMWVA3RTYweStxbGg2YTdvMEplVkN0MWI4?=
 =?utf-8?B?TFB0RlhsWUF0anU2Z0ozN3VmZkt4NVNLaFdJQ0ZISmthVWw5OU9weHRVcEpJ?=
 =?utf-8?B?Sm5RN05qblVJbXhvcXJSMUtYRndJNlVHK2JpN1ZUMGlKcWo0cVd0K090YW5F?=
 =?utf-8?B?S09RNERDNUZnZjJPRzVxRUVHUGVrL1ZWa0F0S21zUXcvcTg0NG5ULzJJbXE4?=
 =?utf-8?B?ZzdYbCthVmZQenpwK1hUNDJWbWZmcXU3YkZDbWowWm92Yjd1ZWZ4VnlpT2Js?=
 =?utf-8?B?VUttM2hqendOcEJEekgzNGpHRUZTYXBYUytwdnF6MU9sbXdhWmw1ZHJ2WmV0?=
 =?utf-8?B?cHlhWkwwbDFYOHJQZVEzOXFSTVZLNFNFeDE2WTlUcEFlbm9Za3duUFdHbW13?=
 =?utf-8?B?YzY4ejZBNEN1M0Nqb2ZmUUNWT3poMEhsZSs1c09halhuUXVmRk80cmlYWDBK?=
 =?utf-8?B?Ym5nZWtEZU1ydnk5MDdLMHQ0U3pCaUREK01NOVZGZUV0czZIY2RlVUl3SW4v?=
 =?utf-8?B?R2Q1U1BBZTVVZS9zU3ZPVzIzQUlvaEdtYlE4eWw5YnZOSXo2d1c0dk9nQ2dk?=
 =?utf-8?B?OXAxTkgxamJvWWFLQzZIZW5lKzlLRWNBMVRYWjhHb3RWdGZjMWJaeHNTWXZE?=
 =?utf-8?B?ZG9nY0s0VXZQYW0yeXllSktKZ29xYVozalZyYkdUU3RWWVFpTDJtU1phSis4?=
 =?utf-8?B?N1dZdFZPTUljZDhLeWN3V28wc2hJUWhIcmhQZlJ6L1dONkNQbTZWbVNOMDBL?=
 =?utf-8?B?THFpS2hFZ2MvS1B0M1RxUWk3TFk4RWdiVGVOVHZZR0JsSDJ3ckRxbDIyM0tl?=
 =?utf-8?B?TTRCWkYzVkdLWnk5c3BWVTIrWkVYbVUwdzhLN3pPS01TekcwV29iTHB1TXJP?=
 =?utf-8?B?ZXI0RWFOOE1UTFAvdlZRcUUvS2QvK2IyYzhyY2ZTMm1yZ1ZGRExJaVcweEd1?=
 =?utf-8?B?MDFESHFLWU9kMGNCblRUTVJqd0lLdVF0RmQwREJORC8zb29MSy9lU0k5dTZh?=
 =?utf-8?B?VFdUSkR0aUI1dFp4czVGUnBzcmh0dE5oMklsUldnV1pIeU1tdmJURjhVanZi?=
 =?utf-8?B?T3lQNnJ2WlREZ0NaK2dtWGtaaGdqMDZBejJZK2hkeVFiaStnOGFoeGpxeU9X?=
 =?utf-8?B?SlNmaE9iRlR4YXJWMGhIS0tPZGxpNFVkNzNFeTgxQjZ6NmNSclFQWUYxeWF2?=
 =?utf-8?B?R3hHbkhsa00yNUhjbGk2bjlCSXpndVhRSHV2TFJGU0xWa01iMjVGdndJYmV3?=
 =?utf-8?Q?2j40hy2urSnmqAyuuwV4+v/UmtIms4Swx9uT1mi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F9FAA06246274E8DFAA42EBCB3CB26@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363dde77-0acc-4d03-0d0a-08d962552a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 14:33:37.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI39rkoBpKEFAEtw22+U3s3nhAKnczvq9GSEQd7r3TunSQAjAUbEI6Ss/CDTdgTUz6jSPKC92JRdBB5MmdLhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6642
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzE4IDE2OjI4LCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxOCwg
MjAyMSBhdCAzOjQ0IFBNIHlhbmd4Lmp5QGZ1aml0c3UuY29tDQo+IDx5YW5neC5qeUBmdWppdHN1
LmNvbT4gIHdyb3RlOg0KPj4gT24gMjAyMS84LzE4IDE1OjIwLCBaaHUgWWFuanVuIHdyb3RlOg0K
Pj4+IENhbiB5b3UgbGV0IG1lIGtub3cgaG93IHRvIHJlcHJvZHVjZSB0aGUgcGFuaWM/DQo+Pj4N
Cj4+PiAxLiBsaW51eCB1cHN0cmVhbTwgICAtLS0tcnBpbmctLS0tPiAgIGxpbnV4IHVwc3RyZWFt
Pw0KPj4gcmRtYV9jbGllbnQgb24gdjUuMTM8ICAgLS0tPiAgIHJkbWFfc2VydmVyIG9uIHVwc3Ry
ZWFtIGtlcm5lbC4NCj4+DQo+Pj4gMi4ganVzdCBydW4gcnBpbmc/DQo+PiBSdW5uaW5nIHJkbWFf
Y2xpZW50IG9uIHY1LjEzIGFuZCByZG1hX3NlcnZlciBvbiB1cHN0cmVhbSBjYW4gcmVwcm9kdWNl
DQo+PiB0aGUgaXNzdWUuDQo+Pg0KPj4gTm90ZTogcnVubmluZyBycGluZyBjYW4gcmVwcm9kdWNl
IHRoZSBpc3N1ZSBhcyB3ZWxsLg0KPiBycGluZyBhbmQgcmRtYV9zZXJ2ZXIvcmRtYV9jbGllbnQg
YXJlIGZyb20gdGhlIGxhdGVzdCByZG1hLWNvcmU/DQpZZXMsIHVzZSB0aGUgbGF0ZXN0IHJkbWEt
Y29yZSBmcm9tIA0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRtYS1jb3JlIChtYXN0
ZXIgYnJhbmNoKS4NCj4gVGhhbmtzDQo+IFpodSBZYW5qdW4NCj4NCj4+PiAzLiBob3cgZG8geW91
IGNyZWF0ZSByeGU/IHdpdGggcmRtYSBsaW5rIG9yIHJ4ZV9jZmc/DQo+PiByZG1hIGxpbmsgYWRk
DQo+Pj4gNC4gZG8geW91IG1ha2Ugb3RoZXIgb3BlcmF0aW9ucz8NCj4+IE5vDQo+Pj4gNS4gb3Ro
ZXIgb3BlcmF0aW9ucz8NCj4+IE5vDQo+Pj4gVGhhbmtzLg0KPj4+IFpodSBZYW5qdW4NCj4+Pg0K
