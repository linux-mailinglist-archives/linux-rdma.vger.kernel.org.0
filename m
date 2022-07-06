Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1A568745
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiGFLtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiGFLtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 07:49:51 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 04:49:50 PDT
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27827FFB
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657108190; x=1688644190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UjSi60zaZTUqdaclO0vmqb3M5Jw6V+kF7HD/MGYPEqU=;
  b=wpOLjwq2A31+3J95QvU6fkDMArMyfya6SPP9Y5Sdf0BF+/u3fI2rjzir
   ZA6ns7utWne5DDxIATU1BHtqCGnPiphb+hDlx6+Z8DPL38cdRDXtNsSdW
   pyCE1Oo7P6YjZnI+01K/9k4Eq+bUoCxPQuZT/TWMN7TojLJs6VAw4r+QK
   UVmCKUcB5v9jFQypu2hM9btgDGXjjdbWy8gokgnS6i8q9BbSNYV1MdLG5
   7l72+BxKo5M2m7BHEnOZawGOhmhdAhEb+fOHGJajP20ollDwrz2Zsm3Ra
   DqNCFsVCw8AhPNJLPOPyppqD/+J8U+R4JzV6uAKza5zSH/uouZH48QhFK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="67627906"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; 
   d="scan'208";a="67627906"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:48:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWT+zAkTFk6TkB+ecL5EgXHj6O/G+7gfXeO/vksppYLA6RHZfh5zTMckekri27T7vQMpCk+8BgnriAvcdN2QqZhtk8q+ohHy5lvaE4oiABxjtP+qulN/59eV/sg8GRmRsderK1eb9G5igRibTCnWh3zerneDS4M+vu0t0XtyQDX82C84Lcdqsh4HZkyPC5dVtbP8tRadB1bDF/Zd8p7qRuD4K8FHV3ypurf+REeE5rKThkcmghGQ3fg4g6EFyJEVVjinkAsxkSjFAXyTI3jayxDjViw3WJw9GfNJ4hEeMh65cPvBneBRNub9tI4+aQbJ3WVmHowzLtaN3uqKa8xSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjSi60zaZTUqdaclO0vmqb3M5Jw6V+kF7HD/MGYPEqU=;
 b=CzfVMNQDb57S8nODUstoMR0gmUFI0AlK7L2HQPACMQ6BrGOVKhOd4kb5KQrEK2byPagAcdw5MZ+8Zey1NEgwo9nXAp6d2JpHTrpIMfus8JB4cx5A9EKB6fuhGgc5PZhA/5VQmBGdcM4pJ9Zscyc0WqQaOZNCsPvDUCqmsthDPrEsAX3C7GGN8jOE+DHWRIWG9dxro5F2LMtHd4FemnQ6xRmg7rJQV8W5ndR7zcjksM51AcIwp4/BOniBskM0CmpPLEwkILKZ9CTyyloytfp0w2Sxs4Huhs5f3JFySOpen4bCKSai6PCgP5VeMO0f/UVrhLZBuMhEmefghRXPT1nCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjSi60zaZTUqdaclO0vmqb3M5Jw6V+kF7HD/MGYPEqU=;
 b=ZoifIVkvs8WWXFMavAU+xgp0TbvmUHIewjCkPx3ppnTE/WZF8DNM2xS6/zAHZV6Ocl0iHVlZJIj4gPtjne5QQnu7vwaEIjydmGIboXHTUDXjI4/EhgLSGEyFzkxkbzGwOEbqQuXowrDuIEbJn5mY2/LT4fEElLJaMHGqQQh1e9Y=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY1PR01MB1465.jpnprd01.prod.outlook.com (2603:1096:403:1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 11:48:40 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 11:48:40 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Use correct ATOMIC Acknowledge opcode in BTH
Thread-Topic: [PATCH] RDMA/rxe: Use correct ATOMIC Acknowledge opcode in BTH
Thread-Index: AQHYkIfjVAOWwi3iKk6kP3+nsPbn8a1xO5kA
Date:   Wed, 6 Jul 2022 11:48:40 +0000
Message-ID: <bbe36efa-1a6e-5944-0d0e-2efcdb722516@fujitsu.com>
References: <20220705155705.21094-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220705155705.21094-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 573637d1-607c-4429-81b2-08da5f457842
x-ms-traffictypediagnostic: TY1PR01MB1465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bd68zj9TvWkhBO5GPJENmg3fg9lcnNKwaXGIPvJ9udHoXsiTYBcDSrnvL2E8IghAU8IbRUpjdvKkCX598n0MyeL00Sn5onNuPlpBHxEHrShCacsyq55BaYVFo2dHl1q2Ei4xNqB3K5rLBAVn7W6sj2h2lN0YsN2J4bJ+3UOdeyeSD1Ta2cKAe1q2UuSN8eknOSGZJd101/ThToEzRAixaaIV15FjFAXv97/OWaXKx81UOe8ccn1s7eU4doM2gNoXjR6xhlHrOAgWuEnh4kEejo3blCpBu8XnIJUtiAnPLBG7sefFtVvgfMKfydnPM7BOXyWQWyjZPmvXuwIRvA7gZWdiS3450IwQ5QF6DsQ48RzewQEnH8RqogFa3rYasK2k5vHr/036XJySfrsYbpd2AdQiO7itXAwsi9fMIv6IaGyuxvS6G6Y48mk4SM23GqxdSw7CX+KmkA+3cpA5d0Rx/NJFYkZfKVN3Y3DRDvj+45u2aRgnQlP9vVOAqAfcpNmRechDV7VciZbJVQDv1lacpiadm7kMjPm/5mXC/AgX7ReGVtThLwXBS4YL/Nvh+K3Qu0SKHfFFwJ8rQ3rGdOAomUGKjlU7NCe85hW88la3qLiJcVgBmKX9kB+IQEeAii/hoUAWTR2L76ouQMSye873T3rbkj3Oy/7bKNHGIYHN2eKRXHSlldhOLCCRKQ92jqqtfYrnNjToj6DwbjyCLfLXhuHFuHQpCjdw9ysO6i5VYW3SCtoK37552FpgA/b9oE7i85Sn6HaOhL361E/NlZUiKoW8TPh0N7h0Nt8CGU7L+EUSr+zOcbnu3Ac9t1KgSRsqJ++JUQi76eHDwUloZADG8VJGqCSFDB4OGHaACyYKznY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(64756008)(76116006)(8676002)(91956017)(66946007)(66476007)(66556008)(4326008)(66446008)(86362001)(38100700002)(31696002)(2906002)(5660300002)(122000001)(8936002)(38070700005)(82960400001)(41300700001)(83380400001)(26005)(53546011)(2616005)(6512007)(186003)(6506007)(316002)(54906003)(6916009)(6486002)(478600001)(71200400001)(85182001)(31686004)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dKWHFIcHJlUmZCL0IyU0dxWEFIc2dWaXVqVVQwMVBHbnRGb1pQUC9NM1JI?=
 =?utf-8?B?bWdYTldqem8xZVFUYjlJanNIQ1hGL1hMRFYvYW16d3FWMkNtaUNVVWM4OVdk?=
 =?utf-8?B?L3NhcHIwMXJtRzFEUEhSaElrQXoyeThTdURRUE1GUVVRb2pSYjdRV1dSUmZT?=
 =?utf-8?B?UE5OSW5HTTFTNFJjL1ozQ25jRzMzK01tcktyZWw4V2svbVVsaVQyVGllYWN2?=
 =?utf-8?B?eGxuYmF6a3M3anl4Znp2SW9DUGQ3RXJoUXFrVDN4czkwYW1wN0RmNHZvSUhG?=
 =?utf-8?B?LzJ2TzVLNjNCWnhyNGpidHUvY25SUWY1aUxkK2Z4Nm5UWldPMG85K2pwVXNO?=
 =?utf-8?B?eWF1UjNFZGMxOHU1NDd5Y0dpYndoY0Q5eDB6TTdKa1FuazZmdURDUnJMT1ps?=
 =?utf-8?B?cTNwSExyQ25jYlRVVmhMWk1xamh5cnhXRGFIZjVGckhOTzlTL3JKWnFORm80?=
 =?utf-8?B?YUZvY2crRW40ck9RbVBMa1lWaGF4L2YveFpHS3Avbm5sa01MeTM2ZDVCbzFK?=
 =?utf-8?B?TzRhZGFzMitLd3J6YTBJdUhyTzhmcCtiR1ZrRVBZTFNTcmVCbGI5RC8wdGNR?=
 =?utf-8?B?L2Z1eWtzKzRoWHY1VVNwUGVSKzZKMlBzbCtaWUxBWFlLQ3lXQ0o1dTNUYi9u?=
 =?utf-8?B?bEY2VGtVcWNYdTNBejVlb3BIc0JMRkpFSmt1R1BqK0NhdW8wRXBkc0VjTDdX?=
 =?utf-8?B?T2dnZ3ZvUW1HOTdvelZDcStzRXNJOEtrVlNpOHNMLy91TjVPQTFKOXFsWk9t?=
 =?utf-8?B?M2cwdXl5eG5RZTBWSEZoaXZQSzlDcWJ1bkZheUxTbWs5YXNPNEdiMVhyRDlC?=
 =?utf-8?B?TDNXWlNWTjhOSmw0eTdMN3N1ZFNUNDFUZXVrQzR0VUdHZlg0S2FvTjluZVh5?=
 =?utf-8?B?Zi9Wd2xqTVA2c2dSUllERjhUanRaOHVpSHJBWmdHcTU4U0RZMEhhaVE2L2hq?=
 =?utf-8?B?bG5BUkRLNGNCd3Q1cTJIUE1INXgyaFVxRm4rSGxNZmJPbW1ZRHFUS1JQL0pn?=
 =?utf-8?B?SFg5Sk9xNTdJK2Y2MitNNlpDMVNJTVk2V09jZWJpR3JURFBBbUUrKzBCaDVM?=
 =?utf-8?B?SEVQc01CbkkvTVVZbkJ4Vk1LT01iYUdiQnhiZW9CWmpyWXVFVFFtZXJJMlVw?=
 =?utf-8?B?QjJiZHJCMUFWMEpXQ1QwQnlZSDE1TlhDQ1RPV0d1dE9LZklwenIxVER4NDcz?=
 =?utf-8?B?Vkc5TSt5ZlB4NjB4TC9QUU1NbXg1bGdxWEJIbmthQUh0NHI3Sy83M1JYMjYw?=
 =?utf-8?B?QWpxWVV3LzhRaUFabFlmOEdSZWN0b1RweUVqSmZxYWRJMSs3V0d4cExBL3Fi?=
 =?utf-8?B?QjNRdk14ZVkwQ292cjE5MS9HS1ErMEh3RWY3dlNtdGNwUFZJRU95VEFDazVI?=
 =?utf-8?B?OVJlbC9MMnlhb3kyOVdwcVlKUUoybzMxcnRaa2FsY1M1T2ZOd2NxM2JveXQ1?=
 =?utf-8?B?ZEorYWJjMmxGUzNGQnZJMndLRDF3dFlPdEJLRkdBY01SQm8yN0xQakNaYmcy?=
 =?utf-8?B?Ry9Yb1ZuUkY5SUZ1Vk9NbEQySWF6VklPbTNHc09PUENaWHlLcmh2WVlwMjRm?=
 =?utf-8?B?SUhYWCt2NVJmaThPRzBHeWNxb3c5SUxyQjlMdHR1ZDdCeXJIQzdKZC8rdjVL?=
 =?utf-8?B?MjAvaE5qQXNON0VRY3pubXRjWk9Cc0lLS1hWTjFEcmlGZDlmSDd1cFhLcmMx?=
 =?utf-8?B?blNSTEM4b0xFdXZaV1Y2MWtVTW0vYnVKQWxtWCs1TGVmek1EOXJRZFE3b2tJ?=
 =?utf-8?B?S20wZzZ5RUpERDFZUlZSckszamxLeEQyK1UrcXA4ZVhxeTY2bzZHbzEvb0cx?=
 =?utf-8?B?ZkQvdXNKZmtUYnZPOUlDNTA2R2R0SHpKcmkyQkk3K3drR2pETlh4cE81bXNP?=
 =?utf-8?B?SUl5MitxbUZ2VDh5NTZrZ1ZDMHhuQTdIbUhtcjAwQjFzNTNWdUJFbFc2cWtJ?=
 =?utf-8?B?T0tTZFFhbk82L1pqYUVoNXMyZ3NrSnJTOUdGQ2FxNlo3TTIvUUFrNFdCSVRl?=
 =?utf-8?B?WE0vYWJFcTNqVTdxbk0rMlB6QTRTRWlaQkNkQ2hNeG9DcGpQZFhCck9hWWVI?=
 =?utf-8?B?bGg4cnBLYXlHTThVTnRpdGxzUkt1Rk9oVXA1d3NHVUxoWk1uZWlZdWNoTzBq?=
 =?utf-8?B?T0xoMGFWVlFKNUFwV2dFcXhWV3pIOCt4UUNabHFuR0hScVRFVnBhOHVZTWpZ?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C871597117FCB45B044D4A76AAE9C48@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573637d1-607c-4429-81b2-08da5f457842
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 11:48:40.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoJbatbl10Nn2TnTjWU7/gT4Ij2rrEanfLEZs9qp015jO+pKtB9AvcFnjyHACYxjK4P2ZSlCJ3I5bpxikENSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzUgMjM6NTcsIFhpYW8gWWFuZyB3cm90ZToNCj4gV2hlbiByZXNwb25kZXIgcHJv
Y2Vzc2VkIGFuIEF0b21pYyByZXF1ZXNldCBhbmQgZ290IGEgTkFLLA0KPiB0aGUgb3Bjb2RlIGZp
ZWxkIGluIEJUSCBzaG91bGQgYmUgQVRPTUlDIEFja25vd2xlZGdlIGluc3RlYWQNCj4gb2YgQWNr
bm93bGVkZ2UuDQoNCkhpLA0KDQpTb3JyeSwgcGxlYXNlIGlnbm9yZSB0aGUgd3JvbmcgcGF0Y2gg
YmVjYXVzZSBpdCB3aWxsIGxlYWQgdG8gYSBrZXJuZWwgcGFuaWMuDQoNCkJlc3QgUmVnYXJkcywN
ClhpYW8gWWFuZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWpp
dHN1LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5j
IHwgNiArKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBpbmRleCAy
NjVlNDZmZTA1MGYuLjU5MmQ3M2MzN2Q0OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3Jlc3AuYw0KPiBAQCAtMTA4MCwxMCArMTA4MCwxMCBAQCBzdGF0aWMgZW51bSByZXNwX3N0
YXRlcyBhY2tub3dsZWRnZShzdHJ1Y3QgcnhlX3FwICpxcCwNCj4gICAJaWYgKHFwX3R5cGUocXAp
ICE9IElCX1FQVF9SQykNCj4gICAJCXJldHVybiBSRVNQU1RfQ0xFQU5VUDsNCj4gICANCj4gLQlp
ZiAocXAtPnJlc3AuYWV0aF9zeW5kcm9tZSAhPSBBRVRIX0FDS19VTkxJTUlURUQpDQo+ICsJaWYg
KHBrdC0+bWFzayAmIFJYRV9BVE9NSUNfTUFTSykNCj4gKwkJc2VuZF9hdG9taWNfYWNrKHFwLCBx
cC0+cmVzcC5hZXRoX3N5bmRyb21lLCBwa3QtPnBzbik7DQo+ICsJZWxzZSBpZiAocXAtPnJlc3Au
YWV0aF9zeW5kcm9tZSAhPSBBRVRIX0FDS19VTkxJTUlURUQpDQo+ICAgCQlzZW5kX2FjayhxcCwg
cXAtPnJlc3AuYWV0aF9zeW5kcm9tZSwgcGt0LT5wc24pOw0KPiAtCWVsc2UgaWYgKHBrdC0+bWFz
ayAmIFJYRV9BVE9NSUNfTUFTSykNCj4gLQkJc2VuZF9hdG9taWNfYWNrKHFwLCBBRVRIX0FDS19V
TkxJTUlURUQsIHBrdC0+cHNuKTsNCj4gICAJZWxzZSBpZiAoYnRoX2Fjayhwa3QpKQ0KPiAgIAkJ
c2VuZF9hY2socXAsIEFFVEhfQUNLX1VOTElNSVRFRCwgcGt0LT5wc24pOw0KPiAgIA==
