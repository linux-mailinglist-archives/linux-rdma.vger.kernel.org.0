Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11D41659B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhIWTH7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 15:07:59 -0400
Received: from mail-dm3nam07on2103.outbound.protection.outlook.com ([40.107.95.103]:56896
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237009AbhIWTH6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 15:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq3RYFdznaz759vPqZCpa8/9WuAqQHzj9CRdRAV9stApZAh5A4Al+r059ndfuJnJ2T+OXTNVqXrX1yyuWCBLCt2A3JuVOubhFUhEuDKw4d4pURXZVzCsdfMzrFsqmdOnVlceWwin6c+tAu8Stb+y3Dt6vSkDv+FGsgCEo/UehUE2gKnD52/NZlW6lE32m4ymwH8NZKrQAl2wTBt+5cgGk5gaGjWlaOdfqNnxKeYvPevzCEZ8/dr/5rRngW08vwGt76RSneMxk4ZkR8KaCKJbRRexiR6CNNMEKakX3kMYfmAszVST1fZzXpelBYB8U2mqSmRNGNNJcU3uiytqmIUqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PpZVsBGziBppa6kxKJBqjHcubxpnrpQ6JlJJXAQsSfQ=;
 b=n/xYJW8NjXugjYIsr4eO3dTxLmRGldjLGMniS+RKUzzfVFV5VDqtgrUf9xGc5epSebIQN92z653geZu4G5jblvA1Kr9rfXR03p+97NtpiSVaLmyTPsRlUhQyhc/fOw4XxaDz911xVyLnWRXdjAoUKqT6Qtf8j3GscX6OZQeDBu51FluJTDbphG4G5qlIg70CysgVLzQV4zHSi/72CxyLG4y3j52GZGLavetO4KK5Z7PD6UEkIoKNlDyVSA2R+I6+/Ty0o/d9KTEWXhHPIda+Vt9Faa8eWFBCgv3ttb6mDpQZxJ/gbE+uqSWMKJf3lQjnsVrdwcEC+SKrv6UEwZ/QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpZVsBGziBppa6kxKJBqjHcubxpnrpQ6JlJJXAQsSfQ=;
 b=I1e00yPUFsAKVihThlD5STt3of4BVjF4DFSCUf8XHwb+7pn678aAhba8OXtISNYZFOWjBCzMFl1LLQLswsDqF1/f2u3hk4wNNOTa90HDnF0U1zXN1HuBEHGA6FX2ASkTKHmY63sg6g2PPTujMDf5DWXqUW/sw38sr2G1OsFksIIjD9/VS1yIIXitiEXUbdaO28xo+fA+beBC1nSu0ez1Yv8lyKKEoR+SLRwxg4g2fnKMpkfLiYOvINHZl2qwx3YYjD3jUi4dpDwlonDVF6IxYjygub+mXpmU0d0dm1Yrwk43KG/3sOgwjN7aORpS72rOxQLY5PkgY3lXj4Qa9khQXQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5928.prod.exchangelabs.com (2603:10b6:610:3d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 23 Sep 2021 19:06:24 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 19:06:24 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] infiniband: hw: hfi1: possible ABBA deadlock in pio_wait()
 and sc_disable()
Thread-Topic: [BUG] infiniband: hw: hfi1: possible ABBA deadlock in pio_wait()
 and sc_disable()
Thread-Index: AQHXqhHZlszztmdEiEO0/OQ+ZHE9P6uyBFhQ
Date:   Thu, 23 Sep 2021 19:06:24 +0000
Message-ID: <CH0PR01MB7153B9AAF22940DBF4BCB600F2A39@CH0PR01MB7153.prod.exchangelabs.com>
References: <857df2fa-7d60-bff3-70f2-642201888977@gmail.com>
In-Reply-To: <857df2fa-7d60-bff3-70f2-642201888977@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2acc248-6287-4074-9457-08d97ec53d0c
x-ms-traffictypediagnostic: CH2PR01MB5928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB5928C14967AF0429353446D0F2A39@CH2PR01MB5928.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLigWztfwvOXxZcTuZ9lDNFuEHykPlr82qE8Pwlp0XTvQtpYa+kwuwt1jdB4TXVfwc6RIr57rpzAbYSqtM7n/fK2t7lTehVcx0DLX8Y4itVXcLA2dcMyzWHDHajbqid7XE2mYuZzQ99JJIRg4vMpjI2v1lwLsEWpBItdCEr9YdFkYM8tWpMjt11DbTkj9qALLtpkS3rxTYjIjE30U5OtXeLst3WDyqgOETWsdrR6Fikh/7ZteUxE+b80L5jWXIC35KbjKssejjV6PRfEDXogNMs7ytwWYr3KrYYANKVQH+00VJ1bwyIDsdh0Bst1/8q79cd0r4J/3/zc2jKyUBmQGEpbya8R/+S4FUslIGEBktFdGqtEq0NUwCF66hqzHOOcKuOvzGdbkvZf52rwy89zwdJSx7xTahDgOqB/0SY03VgH/KowUKrEQy7ukyhgFvfVOqHBAc/GkmsaOGHoJY0PJD5ATrw5azfaLw+aRVgWn50Bjlab1eMJwi0Wh/68ab4G5jm3n/ou57ikpJ9rk0dAdiQ1Ojh4qb1bGfkTP87zHakvdMvhQCjsqGM3K7XalSoltEQcCJIyV5kGuO/6nT2Q2AH1b4EEWR8W+4ueDKjh0wfDRLqtDehEpGHifj6Tuqb8nMvPuSJgOjn8a7N6gUTIW1ifK3x6puXqwEfG+IdLGLiBWJXUUz6VgYoxQsI2HF773O1r4dGxq1V2zj6pp5U6Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39840400004)(366004)(136003)(110136005)(54906003)(33656002)(55016002)(186003)(8936002)(71200400001)(76116006)(38100700002)(2906002)(38070700005)(7696005)(9686003)(122000001)(26005)(508600001)(8676002)(83380400001)(6506007)(66556008)(5660300002)(316002)(64756008)(86362001)(4326008)(66946007)(66446008)(4744005)(66476007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2hzU2lpM0tVK0RUWUI5ZGZ3VGRZZmlTY0F0U1AvaVpmaTV0dkFpaFEyTjFZ?=
 =?utf-8?B?SVVUWld2M2JWWWh3TnRXZXZOSnNnWWNWREFtK0xjWXhiSjBtc2FPcGNCamFE?=
 =?utf-8?B?LzVIeVpIa0U2OTFKc2k0c0s4akVYc2lUTFIrdDFnbWNFdWdEdWtYZFgzS25w?=
 =?utf-8?B?aCtWU1dXZ2VGR09FUWxnOTk3V2trWlorY0o5b3Ftc0c5bFcwU3Q1NnRNMnds?=
 =?utf-8?B?bUhBemJ5VmlySStEcXVZTnUwNkUyQUpwZnNMd3ZOa2h1UWxGMHNmaTU0MUJy?=
 =?utf-8?B?Q3J5cDhCeVMxOFBrQjBKQmNGS1A3MWVIN1BiUE1LbU9zT1JJSTI1Mk9rOGFE?=
 =?utf-8?B?dC9Rb2kzY2I1UmN4NDVqL3dmQ3U3anM4TGtBV3B1ekVNbS9OZGcxOW8yeUlW?=
 =?utf-8?B?ajAvQlNtbFBhU2t5cWVLRTIzaXVDNC96K2o5WGlwblBHL1YxbC82elk1eWM5?=
 =?utf-8?B?bzh6R3h4aXkvc3JiRXliSmhMMVFsK3dLeXBkR2daZkJDNzZvVXVDcERBKy9O?=
 =?utf-8?B?c05CVGZPdWhDQ0tocmR5ckVCaXI3bWNJRWVYTHpyUHJZM1BUak4wWlI1dEZ0?=
 =?utf-8?B?TUpZUS9rSGFSaFBkMUFQUjdKcE1zR3FaRThaZ1FTZU9lbHpPeFFDQkwrWDZL?=
 =?utf-8?B?TWlIOWpEMjkyN1FyWlFUQ0ZpQ240RGpBeHFVM3RuNnU0NVRwSncrSnBBWVBS?=
 =?utf-8?B?cXBQTVBlSVoyS2RNRUhqQXRqMmpDZnRsNFRRdUFJZUYwUEttdUhqVlY2bDY3?=
 =?utf-8?B?Znd0Q1VGTTNCVWRaam9mU1FiNVNWeWNEUzl6RE9qdDRQSDd3aHdlczhPSWFV?=
 =?utf-8?B?cEw0WmgvaEk2NjVDejBaNVIrcDFHakhDZmFFdlpGclk4TGZRQVo2Z2ZmTkgx?=
 =?utf-8?B?WHg0RWlvQkRObzhtZ0lQelY2c0VoTndyamJ5SVViUHFUZHFKYVVCYXlUYlZN?=
 =?utf-8?B?UlZ4Y1hscFFlVXM0ZWtLanR4YTN5Y3lQWDJFdUF6Q2V0dGdUd2s2UExDdnZm?=
 =?utf-8?B?RzVIZ0lxUmpIbTUyRTRONEI0amZhUGM3RFJ2NHAxbVZreHEzNi9aM0htV3hq?=
 =?utf-8?B?dllGRzFOMDVySGdQQ3BhdS96bnFGYjByTEw2aW8yNVcyNThEYjlUOC9BTDBV?=
 =?utf-8?B?L1NJbFNjNnJuTEFXTzd2U0JKTXRQRy9VbGwyZUpkWWpDRkhnOXlUSTRYM1hQ?=
 =?utf-8?B?SklCNlgrK3UwUVIwN1RGcEtlZFc2TVNhWklUOC82TkFRWHRPVkc5S1dONFpu?=
 =?utf-8?B?SDFZVWhyRXRIUnhQQVpSc2c4OTlDYVRHSEdkanNDZUJNSHF2czhjeFdCaVdr?=
 =?utf-8?B?ZnVudkFqQ0Q4cEZ2SWl4WFkrK21hU2RvUHpUeDV3U1dGWnM1eHllSjN3a0tD?=
 =?utf-8?B?OE0yWkYwejJuN2hhWUxXNFk3YUtUUHpUZnc3R1doNktHVTM2bFRNSEtRVzgv?=
 =?utf-8?B?Mjg5WHVBTWZSZ1VLUEx6L2pmd00wK2huZEpSMS9LUkJtUEhHVFVHazU0NHBn?=
 =?utf-8?B?YzVBQUtuUnNUT3hncC8vcHpYUHlWZVBRTkRHYytmSkNKMy8vdjdSTG9pRm5w?=
 =?utf-8?B?eXFVQ2tVZkZjSmdGdVVDRE1KdkYwejZDRjZ3enZ5VGJiY3lodFRpTkxjcTZI?=
 =?utf-8?B?cUNtb1pZQXVabDk5M1pTRVZ1UllNZnZvNjUyQi9oNndBTHgxQUZKcldkWXRz?=
 =?utf-8?B?MmErZzduanZGMWt2dlhJUUdpNVdlZU9sSXE5bnNYUzNIK2VxTjZhcjJNRGxW?=
 =?utf-8?Q?oyMgWTfteJKXgiSD7/guLGONlPAkkn98958ehhE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2acc248-6287-4074-9457-08d97ec53d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 19:06:24.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuVUJzViwd1yU7BlDScppEDa+9OXRQaxxVDY6GuF8WJ21oBXm3R2QGU3x0ETKf7c4We5tvw0To/YLcRe74eSuavzvSuwduM+6YbwJmxpT9oeNyc4D5aPf4BuvUv5BpTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5928
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gSGVsbG8sDQo+IA0KPiBNeSBzdGF0aWMgYW5hbHlzaXMgdG9vbCByZXBvcnRzIGEgcG9z
c2libGUgQUJCQSBkZWFkbG9jayBpbiB0aGUgaGZpMSBkcml2ZXIgaW4NCj4gTGludXggNS4xMDoN
Cj4gDQo+IHNjX2Rpc2FibGUoKQ0KPiAgwqAgd3JpdGVfc2VxbG9jaygmc2MtPndhaXRsb2NrKTsg
LS0+IExpbmUgOTU2IChMb2NrIEEpDQo+ICDCoCBoZmkxX3FwX3dha2V1cCgpDQo+ICDCoMKgwqAg
c3Bpbl9sb2NrX2lycXNhdmUoJnFwLT5zX2xvY2ssIGZsYWdzKTsgLS0+IExpbmUgNDQxIChMb2Nr
IEIpDQo+IA0KPiBwaW9fd2FpdCgpDQo+ICDCoCBzcGluX2xvY2tfaXJxc2F2ZSgmcXAtPnNfbG9j
aywgZmxhZ3MpOyAtLT4gTGluZSA5MzkgKExvY2sgQikNCj4gIMKgIHdyaXRlX3NlcWxvY2soJnNj
LT53YWl0bG9jayk7IC0tPiBMaW5lIDk0MSAoTG9jayBBKQ0KPiANCj4gV2hlbiBzY19kaXNhYmxl
KCkgYW5kIHBpb193YWl0KCkgYXJlIGNvbmN1cnJlbnRseSBleGVjdXRlZCwgdGhlIGRlYWRsb2Nr
DQo+IGNhbiBvY2N1ci4NCj4gDQo+IEkgYW0gbm90IHF1aXRlIHN1cmUgd2hldGhlciB0aGlzIHBv
c3NpYmxlIGRlYWRsb2NrIGlzIHJlYWwgYW5kIGhvdyB0byBmaXggaXQgaWYgaXQNCj4gaXMgcmVh
bC4NCj4gQW55IGZlZWRiYWNrIHdvdWxkIGJlIGFwcHJlY2lhdGVkLCB0aGFua3MgOikNCj4gDQo+
IFJlcG9ydGVkLWJ5OiBUT1RFIFJvYm90IDxvc2xhYkB0c2luZ2h1YS5lZHUuY24+DQo+IA0KPiAN
Cj4gQmVzdCB3aXNoZXMsDQo+IEppYS1KdSBCYWkNCg0KSSBkb24ndCB0aGluayB0aGlzIGNhbiBv
Y2N1ciwgYnV0IGFsbCBvdGhlciBjYWxsZXJzIHRvIGhmaTFfcXBfd2FrZXVwKCkgc3Rhc2ggdGhl
IHdhaXRlcnMgaW50byBhbiBhcnJheS4NCg0KSSB3aWxsIHdvcmt1cCBhIHBhdGNoIHRvIG1vdmUg
dGhlIGxpbmtlZCBsaXN0IG9mIHdhaXRlcnMgdG8gYSBsb2NhbCwgZHJvcCB0aGUgbG9jaywgYW5k
IHByb2Nlc3MgdGhlIGxvY2FsIGFycmF5IG9mIHdhaXRlcnMuDQoNCk1pa2UNCg==
