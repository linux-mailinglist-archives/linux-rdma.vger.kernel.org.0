Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188F33BB4FA
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 03:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhGEBsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 21:48:22 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:34569 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhGEBsV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Jul 2021 21:48:21 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jul 2021 21:48:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1625449545; x=1656985545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2uuYcndwuvkogfQCPNYl428f/GpOQG8PEJA7sJd773I=;
  b=FZjRiLyGhuxQ0D5l94Aj0XquZHxuftDL7efEQn+QkbChB7k4G6jB2k9p
   p3PPYlmoAOsmC9qiE0+M5mrY+ojkdoAj4UMV+mnuI5CS0VatmarNsqroM
   TI/WAqgXejs3L2CoGnSjYorOhebLWZ5RF4ZxGqwXzHmDDvfPeIZ40HBBk
   95BRVNAPm5r+yK30gVgE8YTGt9eFJldY+urEeIyGJPym6nMSU1HwQHMS/
   puJlQnkgWgGisIDQQ70QEGf7w2uBuKvo9S4UuLSeThlDjA5S8s2wXQFVK
   atYaZRUi2Wa59l9E2w25pUiBodtnDBFBrwSpqGT+lp7A2RGZs9c3NI85P
   A==;
IronPort-SDR: BEt4Q0PNzu82HXgKyTAtzfz7yYSo7GDfJn5lvXFobEs1x9fntdjn2vEwK8fLiJxKwaB91HSEgV
 Ezfv3I+9OtSJDFsrIro6IvdJ419wrfRY3a6lVR7BkDqQxd0872e7ARGOgdZ6XqY6gGwADKQPPn
 PfZ9d+4jyleAOqiY8jJdhnMrl7ShX2RG00PuYpO/xS9JFToZ0tGa15Uz8KQpmA5MUHDhQOVq6H
 XmNJsgG27GyvtQaJAaG2jCoTUvVVrpbprIlhrZvcE6mYJj92+1QMapfBsh5N3knalKdOlNfMci
 30A=
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="34307398"
X-IronPort-AV: E=Sophos;i="5.83,325,1616425200"; 
   d="scan'208";a="34307398"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 10:38:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3HX6Td/DIYmK93PBk61F7b+6OaOucWL15B4PXVUYlVa1Ub17Li6rZU50aXCeA/+HqorQF99occIEogonsm7xsVlMC6jmlGVxVfWQqzXNCAfxlp8kpTvFl+wIGQcuZ+SrIX7Lb4kUB+01094IWygAaT2PIZCj73v20ZRHgwnkmzZMIGqVBzNLhGLZLY9NrXfVWp55xv9HYBkTLcAXpVjqGcMIFFnLEuDKVq59W0yUpTHOR22ByPG639Y/ICRSYBjHQxuDVGHpGMq6/ZwP8VwMJRE5pxK30+fb8rmfsZtaZIvtwtnAVq2X0AnUluemzjTJl9zJ//DwRxPk/edPu/vQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uuYcndwuvkogfQCPNYl428f/GpOQG8PEJA7sJd773I=;
 b=lHtc/lwkdvDlvskdZgYLQ2Hj90FR7+B4bIMUyx/la93I9/YKmuBpI88UkPu35T4pG4SLBSUvuMbCYDoiufkmJjNcSLzy6st8531uNEvSHQxswSjDy++Hm+NfeHweK+yNdGvWcau8UIteMmHgYZYBYBURomX4SzxRrQhYiidH/2F35sNrmn0d1uRCb5MKMi3be3MpsYWCmVr6l2GogCS/6i2LA55xlyCUawOjmnCRfskV+rU5YR+gTHN5AJw96v512HGdgVhqble33gS2zyDNcDZ0/8f9ATC8Pbb51hhN4yFVZuGrQADy7YJYUUG0OMVdfW51BbBKLcNvTuGQXdzSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uuYcndwuvkogfQCPNYl428f/GpOQG8PEJA7sJd773I=;
 b=d/fo9NIBLvKzZvRUh4Y8/ptPJLYmsZztpvnXulOYMiDthsCZ+yCdQhywGI+vOW9GKPbFsL/V4apgdNBQpQk7YjKNNejS/zz9ezUAmDP9/vt1RSlvpjN55adTHJ8djaEWT2T0XFAtGEzFX1tDTW1ergCvqerjkeeHoWRdJuggltk=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB4225.jpnprd01.prod.outlook.com (2603:1096:604:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 01:38:33 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::ed7e:e7f1:4e67:376]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::ed7e:e7f1:4e67:376%6]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 01:38:33 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     "ice_yangxiao@163.com" <ice_yangxiao@163.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Thread-Topic: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Thread-Index: AQHXbz4Sgm8CHdL40kqjQhFsVSpreasvpXkAgAP47YA=
Date:   Mon, 5 Jul 2021 01:38:33 +0000
Message-ID: <60E2628F.8010502@fujitsu.com>
References: <20210702123024.37025-1-ice_yangxiao@163.com>
 <98F0E5B6-12A4-4303-9060-6D8232DF2694@oracle.com>
In-Reply-To: <98F0E5B6-12A4-4303-9060-6D8232DF2694@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 592ae33c-20ec-4fdb-39e3-08d93f5599db
x-ms-traffictypediagnostic: OSAPR01MB4225:
x-microsoft-antispam-prvs: <OSAPR01MB4225E042100A68388DDF36C3831C9@OSAPR01MB4225.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: li2UCBmp6xUalOXQTMb0Uqwum6x2rQnK0zQtegDfS8y1WTUFqtbPGfg+/I64Ash29N339j/ZZtQuKhFUBZs1rgHsk2gw0TVlvVNwreK4e9nrOw1zunCHDMGitgsO+5aQUCHYhZhrh+3u032x4npGdSDXd1PLnHd9KmiEYn8t5m6OGs3b1fUk8DRWe1WUBfOUdOwknv5wvseoNG1mA2+L+gL0T6FqE8K0EhjfN3EgOdN9m7zji1E1X3N8MrZOyrRba8ZfGVX2H6c20BqZbGKc7/5KZ93fF+nncSM9f/Iw3sNHzXvdylEx51/qjoaVryEUSSgGWqmzp2pobadzuA3SlE3R82lwLBahZw4pDtwgnMqZvkyHhj95BDlnuZwqysg7dOyNILb+SSRlBaSmhTxJRbpDBTts1yAXIULM3A+MEHrVzw1R3ILNrrmUzuPKsLV46DUOTtfS+N8v1z5pgT5oOPO+vvyKTG2gG2MOzFlXJyOKB+tCVL78srLRilmnYruBgr7WaQ1G2RJ37lxgCtVqKRAIvWvZ6QGFNq+qJJZrq8GKfPLE9yb6q8OiSlhavGtR4dg1D187ARlzfAOxFl72cbHasoFPP4aKBQuJZjyh3QOM3R7IL1LAquaMhE0uG+epult4u3DGeCOZWPUYh/uqgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(91956017)(2906002)(6512007)(122000001)(2616005)(6506007)(66946007)(66476007)(6916009)(316002)(66556008)(38100700002)(36756003)(54906003)(186003)(26005)(66446008)(64756008)(76116006)(53546011)(66574015)(478600001)(83380400001)(8676002)(86362001)(6486002)(71200400001)(33656002)(87266011)(5660300002)(4326008)(8936002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTVNNktycFFGdHJsNXlJQ0gxMkt6ZC9NYXprUEtmZzZCN0NtNTVyR2wycnor?=
 =?utf-8?B?UlhETm1ueHQrOUpYa2VlR0YrNGJ5M0tsTmRjd1NiTUJFVnhaUkRlc2FVTG16?=
 =?utf-8?B?UG1UcWlqMHc1TkZGUUI0aVI5dkp5bTBzZzh0bkVSeUVXS3BMU3lWcU1YWDd6?=
 =?utf-8?B?VGlDNDlJWUg2cW1VZjZocWhOOHdFbWJnYnJ6RTcwemd6T2tJZlpMSTlhUTVq?=
 =?utf-8?B?cnNaUHpUcGsybE1Nb09VMlFCNVpzSnFIRS83TEp2aG1JWE43V3pPcW9zVDFr?=
 =?utf-8?B?WXBNd3YxODU2Z2xxYk9nUG1HeXFiT2ZBTXZWcjJYUmlUa3lRN29mcGZ2ZnU5?=
 =?utf-8?B?TWFuaTd2cEdRTTI5VU1oNzlKNHNmamFjZVQwVkt0S0dyMUs5WjdKV1owMFQ4?=
 =?utf-8?B?WEswZXZWR1QzbThwNHpFbDVadWpiYlU0aVU3SllqbDlxSHNXTmh5a3NKT21E?=
 =?utf-8?B?dWFtTTk0aldDelIxSDBzcStCNVljM1pJUXFJRWZMRDYwcThCV2JuTmVWSlhv?=
 =?utf-8?B?NEEyb3NTWVQ3ZEdWNEhCY1dGZXFFLzMxQWd0QjVJbU54TkpKdFFnYWNyZXZT?=
 =?utf-8?B?NWFwOFFLSFVIdTJLOFhqUWJEbWNQVW9USnZMSitHajB3ZHNsdkRydG43WVlJ?=
 =?utf-8?B?QmZVUzk0RjhvT2hiWTVzUlk4c3NobW9RMFgybGF1Qkh0VkxMd2t0SEh6QzdI?=
 =?utf-8?B?Z0hCOHFSY2ExM1JDa29EdHYvVXJYV1ZrMFA2Tk1BRWRaL0llK2RxSmpLWUhv?=
 =?utf-8?B?anZ0STFVOVNURXNQM09IaERMUGNwak9kSGdla2lmNThWVTJLVkRjb2JEaGhw?=
 =?utf-8?B?TnR1dFVvd3RKRjNtWWg5M3krbVIvOTZIbXduZ1NXN2U4M1JZRXVUMnNOTGNw?=
 =?utf-8?B?WHc2VjltVHZxYnBBaFBFR2tldzlXL05GRFlxY1FTL1FITUZaY1libWdQWUU3?=
 =?utf-8?B?SGhzM2o3dUIra2hoR3A0SVFmRmlVYTN1Z1ZUWTRrbVhBUzZJc08xdDVMWVZJ?=
 =?utf-8?B?Q2VrWGFsR2R2bDNkQW9sRitCeXpUMmkzR0FwSlZ6UWlnOXB4TERNSmxnazlp?=
 =?utf-8?B?WGZWSHVwWkpHaUczWUJneDhpYjhVNGNnYjRGaEV1VDZKbWg1azdaYlBHMnB2?=
 =?utf-8?B?Ry9HM0ZBTFU1cHE1amlqUFVVNGZ4Z1dxWVdiSDVOMHo4MkV1cnNGUXZsanV2?=
 =?utf-8?B?Rm5PZDhRM05xVFVOS3kxeEowbGdBbzF2K1hMTlhRVHA5Q1RKVHJRaC9QUmh0?=
 =?utf-8?B?WHFiZTc2c3JEN1hrdUhIM3VINWZaUW5SVjRBcmdZWjdUWEl3cTYvdzBtRlMz?=
 =?utf-8?B?bzdPRVFhWGd0b1BzMlljWlJSN3JoOVlSSGVkbDk2VzE0WVk5REk0RXp3ei9q?=
 =?utf-8?B?VUZFcnZ3VjJETTVhcnU5eDZUbjI3UFNSRUZzTzJwLzdBdkY3M1RUUzZJOEhV?=
 =?utf-8?B?Y0Z1UUVKYmp0UHJRcDNwZit0Rkx0Y3p5NWJvaXhnWjlLSktLbXdNa2g3QXhu?=
 =?utf-8?B?Zi9rcDdhN3BoYjFWYzJ2a0FmRGJMWFIrWVdDeTFWYTBHcXh2SDZGS25NaTVP?=
 =?utf-8?B?T29IZFg1bU9wSjJTamdUaExtTlRPNlNZa3VkblhxbGFDM25JMUZra2JPelVW?=
 =?utf-8?B?Y0RDSnJnOVFZSDRkdDJHc3oxTlVqSGNZc0FZT0duS2wzWTNwV3o2TXBaU0ly?=
 =?utf-8?B?QlJ6ckhoY1Q3N2kzaFdScks2bjdkc2p4bzFJSXpUS09KVThCRnJxdUgzVjN0?=
 =?utf-8?Q?KNze1odogtSz0LwoNCRbn4l0VRn8Ta7UMdEMRId?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D980A0C3864A3D4F946922D4A5E27ED9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592ae33c-20ec-4fdb-39e3-08d93f5599db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 01:38:33.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH14yyKf65Jx8a8r/bvDBpNHpDLPZzUQ0D0urpP7V/ODQlIdUGVM+VgFtmtxf37Ph5EvOm+T8kvZsOdfB8ZCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4225
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS83LzIgMjA6NTgsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4NCj4+IE9uIDIgSnVsIDIw
MjEsIGF0IDE0OjMwLCBpY2VfeWFuZ3hpYW9AMTYzLmNvbSB3cm90ZToNCj4+DQo+PiBGcm9tOiBY
aWFvIFlhbmc8eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWGlh
byBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPiBMR1RNLA0KPg0KPiBSZXZpZXdlZC1ieTog
SMOla29uIEJ1Z2dlPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPg0KPg0KPiBOb3QgcmVsYXRl
ZCB0byB0aGUgY29tbWl0LCBidXQgd2hpbHN0IHJldmlld2luZywgaXQgbG9va3MgdG8gbWUgYXMg
dGhlIHNlY29uZCAiZ290byBlcnIxIiBpbiByeGVfbXJfaW5pdF91c2VyKCkgaGFzIGEgbWVtbGVh
ayBiZWNhdXNlIG1yLT5tYXAgaXMgbm90IGRlYWxsb2NhdGVkLg0KSGksDQoNClNvcnJ5IGZvciB0
aGUgbGF0ZSByZXBseS4NCkFncmVlZC4gSSBzYXcgQm9iIFBlYXJzb24gaGFzIHNlbnQgYSBwYXRj
aCB0byBmaXggdGhlIGlzc3VlLg0KDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPg0KPiBU
aHhzLCBIw6Vrb24NCj4NCj4+IC0tLQ0KPj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYyB8IDEgLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IGluZGV4IDZhYWJjYjRkZTIzNS4uNDg3Y2VmYzAx
NWI4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0K
Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPj4gQEAgLTEyMiw3
ICsxMjIsNiBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0
YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+IAkJZ290byBlcnIxOw0KPj4gCX0NCj4+DQo+
PiAtCW1yLT51bWVtID0gdW1lbTsNCj4+IAludW1fYnVmID0gaWJfdW1lbV9udW1fcGFnZXModW1l
bSk7DQo+Pg0KPj4gCXJ4ZV9tcl9pbml0KGFjY2VzcywgbXIpOw0KPj4gLS0gDQo+PiAyLjI2LjIN
Cj4+DQo=
