Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664F442B93D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhJMHgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 03:36:21 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:24683 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhJMHgT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 03:36:19 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 03:36:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634110456; x=1665646456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ag+j9kcQWM7CpQukHUJY+LYI2Ac45AVKWRu9Dy4Twck=;
  b=P4Nmgeui9//YjJ9l4dIASu3NEapRO/ytMNRsvFNFByOJMIbWuPoingfG
   pjkcL2LxoAKh6Lsef/vhm+vF5io7T+sNEGzQAaYRgzmWj1KlmxwUzc0Bx
   8hKnkEeUnUqsC6Pe1pzncttgcXKgGdBM+C1CHT5k81ah3WZNpOgv4PBYm
   onsAwGq0MN27TZFfTVKVT9r0i3p8qVmHipRcvVvM/gIHtSEIaxFgn+kOi
   iqtdlSJ7IwdyD4N+dXbJtmeDJtxa1K0d7u3qRMcA8YeNsemvsQE50+mv2
   QwxngVitm6GbzpDcF8PobKVkltQvtgj2wpS4JkgOLXvhAV2XgnK85IILx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="41294888"
X-IronPort-AV: E=Sophos;i="5.85,369,1624287600"; 
   d="scan'208";a="41294888"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 16:26:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFbEOR8eMGlGnjXyb32X0fHU6Kzgc0Zbk5VYV5wpnSG6bABmE9Vx4y05TDgyWnExMKQs2vLSiq5C1821XFUBKQAHCkxvvIayOgvRGm6U843I0kWpq8a2xBE3lI0r27E3W52f4oDhiH3jCLeB40Ut6nnPEqvTZjBfpVlBM95U1upn1GkTyUainSX6C68sDA3NWm/puf6Iy5GgtP83sv0/B7aLEO4+NCXz82zZ0KOHIu1BP6sMUU953WXE0Rvyh1um/62Ra/EA5txcw6ZA+VVb+BFA7XgNybRRGIg9GcztgqlLLa9BY6iSJV12we4L3GNd4Ku525fiIWYLZNUU9a4K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag+j9kcQWM7CpQukHUJY+LYI2Ac45AVKWRu9Dy4Twck=;
 b=ivmFsCovIx8h+A8bVGUg/TIURh9tqDBzf0OiXgAzdIIfr2hSP83ng7nKGmwugl1eMqfrpI9+kW/q3Kv/nfTPOtveY9y6y5uhxmHTDiH93EHNhTP5PI5v18mq+0Q+QJ6QP5mZ9TVGceuJix+EB4+ZW/3x9Zg3mYBvQmVZH5G5mzIyCTJt4coAoA28j71ZF2YUMsMMlYVgTiGliLtmC3lyD6JJV56vrC2ac3rRPxESi4WSGvjIexKvDySK+ykYP4Wc5NApw63J7rcuGLv6hKLVNO+b3VFGV7V9aiC4BNs4VVZkRMbFysMdtWESuL8JdtZ2MBaNUJzBjTPbHUnJCyOk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag+j9kcQWM7CpQukHUJY+LYI2Ac45AVKWRu9Dy4Twck=;
 b=UVP/0R/9gT6x2IAYptl7T70l6aYPtmSbdxb3W4PHnrMiLs1r0qFrPhqNULC6ISjTf4J9CJczID49ZGqpTurTmvGZxpkUhAYixnT3VLgTA3a5WcjK3N2la6aEtztjqplRUiUkIe2z70JTF3BYTYCdcNqsblxFwY/Bm183Z5YxApM=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OSZPR01MB8187.jpnprd01.prod.outlook.com (2603:1096:604:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 07:26:49 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::9401:db52:496:51%6]) with mapi id 15.20.4587.025; Wed, 13 Oct 2021
 07:26:49 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Topic: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Index: AQHXoJ/HyxlES6SvX0+PJ4+/45Jv8qu51b8AgBbwKAA=
Date:   Wed, 13 Oct 2021 07:26:49 +0000
Message-ID: <a7e08316-221d-554b-b853-7f58a7fcdbd1@fujitsu.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
 <20210928170846.GA1721590@nvidia.com>
In-Reply-To: <20210928170846.GA1721590@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 064ef19b-6963-4294-29b2-08d98e1ad235
x-ms-traffictypediagnostic: OSZPR01MB8187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB8187733FFC634B90771319BDA5B79@OSZPR01MB8187.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7euz7gwvfH7upSzED79R9nepplhjWwsW4O9x1XH9bvsf5qw+PnM0dVCEqHp2yBCLROgug/uFSvPd4yBzI6kX/J8uT+5c2xW4bs+wwmhb9s/3R7dnkXs6vloQhpPw7gcaHbYx1CXaZXOr2qlDk9E6HmObx7TaJC+uaTi3Hlb4f7rcTj4S+njGVwrKv/2gf1orN1evPcFpjI5ce3QCtE9ZZzdAn1aplmj08yYpczXBhTzy/vP3+akD5etnO9KXuR1RNt8gwPtMOT24qWh/zf5u6MYYqqKic0l1QS6GgAUjJohzkxjfRMM6S42nNvUhFX7kqL2ijzKlO7Qz93umTlaaUqtWROMSzdGMH5GO++LOm5a4RdBKZzfkwrhCXNIzGy3PNem2iJVryfdzl0NGqqaJTheqpLVZZ1+pPFM79PGjY4nYsSx95GI7fwve4LwOECxjgYR15NbvJg7eFg35thuhM4RulwRV1TeI0KWsgHDO7dX8Cb1BlctlUI8G2A4jvnijzFQfK355bv5lX/XYMWT1Fg9V0loYA5N8aZfIIIz5//f7Ga6AqpHGl9TWKGdNVtqfPNIq1K01q8sCRSHAyNiVX3B63JwygDoqoa8WcUIbv5p4S6/dJFCCcPKWN7gMoMtFmwOqOeNHQx7HOKGPstX3ctwlxZFfzcdGosL10r2/AUtzT7vdoTa/PTvzY3cXaNy5iG98h8QK013ImS8LgjkG5UCmywr96IQrx5YxLz0t9KWDtsM/Hy6x5eiUQlnUW/ATZZORmvJCAlsXjMeDGWxiKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(4326008)(6506007)(508600001)(36756003)(26005)(186003)(6512007)(71200400001)(8936002)(2906002)(316002)(83380400001)(86362001)(38100700002)(122000001)(85182001)(31686004)(38070700005)(82960400001)(31696002)(8676002)(76116006)(5660300002)(91956017)(2616005)(54906003)(110136005)(66946007)(64756008)(66476007)(6486002)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJMWjVuMTU1eERCWGpCdjFWL3pmUmx4NDl6cjlPdHNCMmtvOVpKOGVFVnhp?=
 =?utf-8?B?R21NS1RBVTBGdjdpMGovVm1OWEJZbEpIek1FUm5RL2Q5cEhhZTVWdUxCUFls?=
 =?utf-8?B?aXpDbEtvN0FxTHB4NjRWZkJpaWVjNi9nZ0s2TDI0WXRTekptcFNuaFVzWDI4?=
 =?utf-8?B?dlZhcjZCUFA2aElmdlRKQ3ZML3cyRmpnVWY1cHR2OFh1QS9GQU5QZmRXRnly?=
 =?utf-8?B?TytWSWpJeWF3RXFjTHUvQXQwOVJsZmxGUnY2OHMxZUorWmszeVJ3NlhndTJ5?=
 =?utf-8?B?cGlpeDJPYVBvQ3owQUtRTDd3QWd4NnNEY3FVRHNDS1R2L2gzNXBhOGxKS1N6?=
 =?utf-8?B?dU9TYitncmJPMFlVaGhJamtpak1iTEptME81TEZLTksrNkJycTlVK01OVVdq?=
 =?utf-8?B?Y2RBbGw0ZkxyNVI4R3l3KzVMUmtwb0lJYUVkVVUxUXZEMjUzeVRVaWtydHN5?=
 =?utf-8?B?MmdRTE1wamRKQkpZMnlrQVUrZ2ZnbHM5T0NBUFByVlZBOURiamhvZjd4TVhM?=
 =?utf-8?B?dVh4MmtxaDVQL3RkVlJQdnFjVmxTd0lMZ1lXWXBYMEVUdE16V3N4NUVHZjZN?=
 =?utf-8?B?MytUMmo0aXgvclNMdGNwS01qYTRLczJEZjh5ZDhJVThDa1JRdDBaZ1VMbUwz?=
 =?utf-8?B?VitZZG54VTlnMWNLYWFhYXJFTnYwUU1EOU1odFMrQmpHaG5JRHBEenB6NTlq?=
 =?utf-8?B?WUs1L29ScGZHMWZVblFLdXlzR0I1UC93N21GRjlhcUhBZUwyRlJqTW85V3Za?=
 =?utf-8?B?VjJBaXNjN1hHQ1BxV2lvTkVJV2l6ME1iWkZJRXM5QzY4aVdPblh3N0VRQVI3?=
 =?utf-8?B?MkVBbEZBeVh2TEQvaFREcGJNWXJsaitsNkJVbVRsQlBKSzNLeG44WWFQNkFD?=
 =?utf-8?B?SGJIYWRqZndjdjMzcUxRZlVSeXdOQmcySGl4SWJoQ1NaYkZ1TERzNkhIYzZ1?=
 =?utf-8?B?YmxSajRsQWwyWm92TXA2RHhHT01Ha1llOGJVekVlNk9pekVwTHBVTmtmd0Ir?=
 =?utf-8?B?WFRSSlpjV0ZSUDc4N3F5NzNaYnNGNDNRRFJHRExFekVoaUVlcWJmekVEMXpw?=
 =?utf-8?B?c2tnTTBtTmlLZGsydGI1dEE1NEpndmgyYzdiOWFjN2RJaUg2N1VrajcyY21R?=
 =?utf-8?B?VFFwcVZCREIwWU1NbHhjQkMyRzNDTWU5Z005ZlUwUDRUdVZKS2hZbklxeUtS?=
 =?utf-8?B?OUdtMGV1elFaZ0FpVGcwNklaeDNlOG9iUHRUZHhjMENTUEdsMWdKREhFRUFK?=
 =?utf-8?B?QS9RU1RQUkthV25FNmhlM3QzQU4yVGI3bFJtVjlYeTBoSk9yd2tyTzVzL0pB?=
 =?utf-8?B?RW9jVU9XNWlQY0tOY0dxYlp4OFVzdHNQUXJkRWpDRlVjNGpSb2JMZ3VaV1I3?=
 =?utf-8?B?VmNmYlFjcGpEQkFFR3ZUTk1Jckd3QlpFWXE1Rnd3WCs3S2tWbCtxeHZqYkFG?=
 =?utf-8?B?RCtGcEdGUzdPZUJIOUg3VjhTZ3RPTmorTTVsUmFzbFFEa0tseHN1aWM2RlhN?=
 =?utf-8?B?WDU5c3lrZUx6QkFmQmxyeEVuS25vbitWTDNiSnRrUllJRkQ0L0RLTVBFN042?=
 =?utf-8?B?WmVFa2g1VHM0d0JNOEJIaGR2b2JyNHVFdXJLbGVHODNTOHlFU21NVEZQeDNI?=
 =?utf-8?B?cm8rbkV1NzAzRlpjNFVNZkFoRGNGSHpvaWY4Wm8zNmJqSzFiblRsV3BYTm5L?=
 =?utf-8?B?TUJhcEE4RVkyRUg5Z0Y0eUcvZ1VuK0pyZjU4L05CQXh3alNhaTBJazZXQ2Ur?=
 =?utf-8?Q?+sovXPu5CfEmUb439DUGw2JQ2fRljuBxLyd3vWT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB004970A3BD644B5771B4A0247F08B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064ef19b-6963-4294-29b2-08d98e1ad235
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:26:49.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFT6srgzyshxVos77nffA6fBuSwTVvqiUGSf0vIKH8mkrxuZZ1W6LCIkRYMc9tUyVK2BH/hh91mr5AuzC+kYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8187
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgSmFzb24NCg0KV2hlbiB1cGRhdGUgdGhlIGlidl9hZHZpc2VfbXIgbWFuIHBhZ2UsIGkgaGF2
ZSBhIGZldyBjb25jZXJuczoNCg0KDQpPbiAyOS8wOS8yMDIxIDAxOjA4LCBKYXNvbiBHdW50aG9y
cGUgd3JvdGU6DQo+IE9uIEZyaSwgU2VwIDAzLCAyMDIxIGF0IDA0OjQ4OjE1UE0gKzA4MDAsIExp
IFpoaWppYW4gd3JvdGU6DQo+PiBQcmV2aW91c2x5LCBFTk9FTlQgb3IgRUlOVkFMIHdpbGwgYmUg
cmV0dXJuZWQgYnkgaWJ2X2FkdmlzZV9tcigpIGFsdGhvdWdoDQo+PiB0aGUgZXJyb3JzIGFsbCBv
Y2N1ciBhdCBnZXRfcHJlZmV0Y2hhYmxlX21yKCkuDQo+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0
IHRoaXMgaW5zdGVhZD8NCj4NCj4gIEZyb20gYjczOTkyMGVkNDg2OWRlY2IwMmEwZGJjNTgyNTZl
NmM3MmVjNzA2MSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogSmFzb24gR3VudGhv
cnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gRGF0ZTogRnJpLCAzIFNlcCAyMDIxIDE2OjQ4OjE1ICsw
ODAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gSUIvbWx4NTogRmxvdyB0aHJvdWdoIGEgbW9yZSBkZXRh
aWxlZCByZXR1cm4gY29kZSBmcm9tDQo+ICAgZ2V0X3ByZWZldGNoYWJsZV9tcigpDQo+DQo+IFRo
ZSBlcnJvciByZXR1cm5zIGZvciB2YXJpb3VzIGNhc2VzIGRldGVjdGVkIGJ5IGdldF9wcmVmZXRj
aGFibGVfbXIoKSBnZXQNCj4gY29uZnVzZWQgYXMgaXQgZmxvd3MgYmFjayB0byB1c2Vyc3BhY2Uu
IFByb3Blcmx5IGxhYmVsIGVhY2ggZXJyb3IgcGF0aCBhbmQNCj4gZmxvdyB0aGUgZXJyb3IgY29k
ZSBwcm9wZXJseSBiYWNrIHRvIHRoZSBzeXN0ZW0gY2FsbC4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9tbHg1L29kcC5jIHwgNDAgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9tbHg1L29kcC5jDQo+IGluZGV4IGQwZDk4ZTU4NGViY2MzLi43Nzg5
MGE4NWZjMmRkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2Rw
LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2RwLmMNCj4gQEAgLTE3MDgs
MjAgKzE3MDgsMjYgQEAgZ2V0X3ByZWZldGNoYWJsZV9tcihzdHJ1Y3QgaWJfcGQgKnBkLCBlbnVt
IGliX3V2ZXJic19hZHZpc2VfbXJfYWR2aWNlIGFkdmljZSwNCj4gICANCj4gICAJeGFfbG9jaygm
ZGV2LT5vZHBfbWtleXMpOw0KPiAgIAltbWtleSA9IHhhX2xvYWQoJmRldi0+b2RwX21rZXlzLCBt
bHg1X2Jhc2VfbWtleShsa2V5KSk7DQo+IC0JaWYgKCFtbWtleSB8fCBtbWtleS0+a2V5ICE9IGxr
ZXkgfHwgbW1rZXktPnR5cGUgIT0gTUxYNV9NS0VZX01SKQ0KPiArCWlmICghbW1rZXkgfHwgbW1r
ZXktPmtleSAhPSBsa2V5KSB7DQo+ICsJCW1yID0gRVJSX1BUUigtRU5PRU5UKTsNCj4gICAJCWdv
dG8gZW5kOw0KPiArCX0NCj4gKwlpZiAobW1rZXktPnR5cGUgIT0gTUxYNV9NS0VZX01SKSB7DQo+
ICsJCW1yID0gRVJSX1BUUigtRUlOVkFMKTsNCj4gKwkJZ290byBlbmQ7DQo+ICsJfQ0KDQoNCkNh
biB3ZSByZXR1cm4gRUlOVkFMIGluIGJvdGggYWJvdmUgMiBjYXNlcyBzbyB0aGF0IHdlIGNhbiBh
dHRyaWJ1dGUgdGhlbSB0byAqbGtleSBpcyBpbnZhbGlkKsKgIHNpbXBseS4NCk90aGVyd2lzZSBp
dCdzIGhhcmQgdG8gZGVzY3JpYmUgMm5kIGNhc2UgYnkgbWFuIHBhZ2Ugc2luY2UgdXNlcnMvZGV2
ZWxvcGVycyBjYW5ub3QgbGluayBtbWtleS0+dHlwZQ0KdG8gdGhlIHBhcmFtZXRlcnMgb2YgaWJ2
X2FkdmlzZV9tcigpLg0KDQoNCj4gICANCj4gICAJbXIgPSBjb250YWluZXJfb2YobW1rZXksIHN0
cnVjdCBtbHg1X2liX21yLCBtbWtleSk7DQo+ICAgDQo+ICAgCWlmIChtci0+aWJtci5wZCAhPSBw
ZCkgew0KPiAtCQltciA9IE5VTEw7DQo+ICsJCW1yID0gRVJSX1BUUigtRVBFUk0pOw0KDQpFSU5W
QUwgaXMgYmV0dGVywqAgZm9yIGNvbXBhdGlibGUgPyBzaW5jZSBtYW4gcGFnZSBzYWlkIEVJTlZB
TCBpbiB0aGlzIGNhc2UgYmVmb3JlLg0KDQpUaGFua3MNCg0KDQo+ICAgCQlnb3RvIGVuZDsNCj4g
ICAJfQ0KPiAgIA0KPiAgIAkvKiBwcmVmZXRjaCB3aXRoIHdyaXRlLWFjY2VzcyBtdXN0IGJlIHN1
cHBvcnRlZCBieSB0aGUgTVIgKi8NCj4gICAJaWYgKGFkdmljZSA9PSBJQl9VVkVSQlNfQURWSVNF
X01SX0FEVklDRV9QUkVGRVRDSF9XUklURSAmJg0KPiAgIAkgICAgIW1yLT51bWVtLT53cml0YWJs
ZSkgew0KPiAtCQltciA9IE5VTEw7DQo+ICsJCW1yID0gRVJSX1BUUigtRVBFUk0pOw0KPiAgIAkJ
Z290byBlbmQ7DQo+ICAgCX0NCj4gICANCj4gQEAgLTE3NTMsNyArMTc1OSw3IEBAIHN0YXRpYyB2
b2lkIG1seDVfaWJfcHJlZmV0Y2hfbXJfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ICAg
CWRlc3Ryb3lfcHJlZmV0Y2hfd29yayh3b3JrKTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgYm9v
bCBpbml0X3ByZWZldGNoX3dvcmsoc3RydWN0IGliX3BkICpwZCwNCj4gK3N0YXRpYyBpbnQgaW5p
dF9wcmVmZXRjaF93b3JrKHN0cnVjdCBpYl9wZCAqcGQsDQo+ICAgCQkJICAgICAgIGVudW0gaWJf
dXZlcmJzX2FkdmlzZV9tcl9hZHZpY2UgYWR2aWNlLA0KPiAgIAkJCSAgICAgICB1MzIgcGZfZmxh
Z3MsIHN0cnVjdCBwcmVmZXRjaF9tcl93b3JrICp3b3JrLA0KPiAgIAkJCSAgICAgICBzdHJ1Y3Qg
aWJfc2dlICpzZ19saXN0LCB1MzIgbnVtX3NnZSkNCj4gQEAgLTE3NjQsMTcgKzE3NzAsMTkgQEAg
c3RhdGljIGJvb2wgaW5pdF9wcmVmZXRjaF93b3JrKHN0cnVjdCBpYl9wZCAqcGQsDQo+ICAgCXdv
cmstPnBmX2ZsYWdzID0gcGZfZmxhZ3M7DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBudW1f
c2dlOyArK2kpIHsNCj4gKwkJc3RydWN0IG1seDVfaWJfbXIgKm1yOw0KPiArDQo+ICsJCW1yID0g
Z2V0X3ByZWZldGNoYWJsZV9tcihwZCwgYWR2aWNlLCBzZ19saXN0W2ldLmxrZXkpOw0KPiArCQlp
ZiAoSVNfRVJSKG1yKSkgew0KPiArCQkJd29yay0+bnVtX3NnZSA9IGk7DQo+ICsJCQlyZXR1cm4g
UFRSX0VSUihtcik7DQo+ICsJCX0NCj4gICAJCXdvcmstPmZyYWdzW2ldLmlvX3ZpcnQgPSBzZ19s
aXN0W2ldLmFkZHI7DQo+ICAgCQl3b3JrLT5mcmFnc1tpXS5sZW5ndGggPSBzZ19saXN0W2ldLmxl
bmd0aDsNCj4gLQkJd29yay0+ZnJhZ3NbaV0ubXIgPQ0KPiAtCQkJZ2V0X3ByZWZldGNoYWJsZV9t
cihwZCwgYWR2aWNlLCBzZ19saXN0W2ldLmxrZXkpOw0KPiAtCQlpZiAoIXdvcmstPmZyYWdzW2ld
Lm1yKSB7DQo+IC0JCQl3b3JrLT5udW1fc2dlID0gaTsNCj4gLQkJCXJldHVybiBmYWxzZTsNCj4g
LQkJfQ0KPiArCQl3b3JrLT5mcmFnc1tpXS5tciA9IG1yOw0KPiAgIAl9DQo+ICAgCXdvcmstPm51
bV9zZ2UgPSBudW1fc2dlOw0KPiAtCXJldHVybiB0cnVlOw0KPiArCXJldHVybiAwOw0KPiAgIH0N
Cj4gICANCj4gICBzdGF0aWMgaW50IG1seDVfaWJfcHJlZmV0Y2hfc2dfbGlzdChzdHJ1Y3QgaWJf
cGQgKnBkLA0KPiBAQCAtMTc5MCw4ICsxNzk4LDggQEAgc3RhdGljIGludCBtbHg1X2liX3ByZWZl
dGNoX3NnX2xpc3Qoc3RydWN0IGliX3BkICpwZCwNCj4gICAJCXN0cnVjdCBtbHg1X2liX21yICpt
cjsNCj4gICANCj4gICAJCW1yID0gZ2V0X3ByZWZldGNoYWJsZV9tcihwZCwgYWR2aWNlLCBzZ19s
aXN0W2ldLmxrZXkpOw0KPiAtCQlpZiAoIW1yKQ0KPiAtCQkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsJ
CWlmIChJU19FUlIobXIpKQ0KPiArCQkJcmV0dXJuIFBUUl9FUlIobXIpOw0KPiAgIAkJcmV0ID0g
cGFnZWZhdWx0X21yKG1yLCBzZ19saXN0W2ldLmFkZHIsIHNnX2xpc3RbaV0ubGVuZ3RoLA0KPiAg
IAkJCQkgICAmYnl0ZXNfbWFwcGVkLCBwZl9mbGFncyk7DQo+ICAgCQlpZiAocmV0IDwgMCkgew0K
PiBAQCAtMTgxMSw2ICsxODE5LDcgQEAgaW50IG1seDVfaWJfYWR2aXNlX21yX3ByZWZldGNoKHN0
cnVjdCBpYl9wZCAqcGQsDQo+ICAgew0KPiAgIAl1MzIgcGZfZmxhZ3MgPSAwOw0KPiAgIAlzdHJ1
Y3QgcHJlZmV0Y2hfbXJfd29yayAqd29yazsNCj4gKwlpbnQgcmM7DQo+ICAgDQo+ICAgCWlmIChh
ZHZpY2UgPT0gSUJfVVZFUkJTX0FEVklTRV9NUl9BRFZJQ0VfUFJFRkVUQ0gpDQo+ICAgCQlwZl9m
bGFncyB8PSBNTFg1X1BGX0ZMQUdTX0RPV05HUkFERTsNCj4gQEAgLTE4MjYsOSArMTgzNSwxMCBA
QCBpbnQgbWx4NV9pYl9hZHZpc2VfbXJfcHJlZmV0Y2goc3RydWN0IGliX3BkICpwZCwNCj4gICAJ
aWYgKCF3b3JrKQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+IC0JaWYgKCFpbml0X3By
ZWZldGNoX3dvcmsocGQsIGFkdmljZSwgcGZfZmxhZ3MsIHdvcmssIHNnX2xpc3QsIG51bV9zZ2Up
KSB7DQo+ICsJcmMgPSBpbml0X3ByZWZldGNoX3dvcmsocGQsIGFkdmljZSwgcGZfZmxhZ3MsIHdv
cmssIHNnX2xpc3QsIG51bV9zZ2UpOw0KPiArCWlmIChyYykgew0KPiAgIAkJZGVzdHJveV9wcmVm
ZXRjaF93b3JrKHdvcmspOw0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJcmV0dXJuIHJjOw0K
PiAgIAl9DQo+ICAgCXF1ZXVlX3dvcmsoc3lzdGVtX3VuYm91bmRfd3EsICZ3b3JrLT53b3JrKTsN
Cj4gICAJcmV0dXJuIDA7DQo=
