Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7A5A73EA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiHaCbu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 22:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaCbt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 22:31:49 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109BD92F7E
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661913108; x=1693449108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YzDyGkUIoA5cspuzzXaPRJK+gZm2q5cj6UXlnG2bYWs=;
  b=XKGJHB6F99GQ3HYhIdkxPNpNrNWpF2SUpHevuagjoKiWBg0k76vPUEw6
   BAEVYSGUsZCpyi3EyHZVTuQsdoLVqgl5Egkam05dek7a3zVogpsHPcETz
   RC3ttBD5AN9s+vD8hVO8P26t76I0hriL3ppzwcHXvIeOuYUq9WSeYLcDM
   sGj32VCMvxz2BexXL0++yl//yYvqrzIIZuEx5Bh9ig6ZjUVw1jUD/dfHx
   xvbyA2+dFABhlsPVtaNbS+UeW+HCa2VffCnn45xXMmIWekhsgzAjTWpMs
   LDi0fa0uI9uqhvyzSot1e43NFa7izpukX46FSJb8hFrIGc1dpSHCav/IQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="63852799"
X-IronPort-AV: E=Sophos;i="5.93,276,1654527600"; 
   d="scan'208";a="63852799"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:31:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf18o80k+7kXD9r/ztj3q7ipwDkriFpfbH8DUtQTbZGYmSCdhu6Xfn+DTUf7+pf99ePajgZOwdI2iRpx/uQjECyU8zXRtsXFeBMNvCEdq4TItXIqnWj4L8HdHNpKxn4NbQmA20V4E5lma9BQH9Ylow1jjgd5ggW9rXgNHutWihCY8b7Ik2fU83x0hhCzewUyCo2Qi27ICKAmB4K+78HfRgoZbw7oLP31/wuvyFVBwPlXmEOqjocfNQCE3qvFMB53linpTIhC6riPlJqAAzElnVcXyD8FFG2IOMK+2Gbyii1WhuHCZ5E96bp9eRB81SlCWOp7sC+s2yxWpF7re+3Lmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzDyGkUIoA5cspuzzXaPRJK+gZm2q5cj6UXlnG2bYWs=;
 b=lYeCS4p7SAy7EUtrnxKEiTy/QjmC7VPicmeDyXXaBYIlNXVJYs5iBzDIfptcqu604ZYNewBh1xlG5WwmttJ+Pai1TW2K/4Zr7CephXbvny16r6jpSu5z10vHjF1qR5EgSMEdE2hlASa8LEkerFDYA29WYXTykxoyWZpp9NqUUTEZhX2yy50xeO1MT6CShIef0iHQuFKbXp894XhM58yEYm9tP+0zsS9lnJGUjmhSkZX6DNpqWd0uoqMxeJxX1o4h/u0xEzbClTcJ0IhQ5NfpDq1lR2J43RvN7haIORc3vOGOWd47uJrYjDJlomjzRklUpIaSrhUdru4wTeQrNRizmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSBPR01MB4056.jpnprd01.prod.outlook.com (2603:1096:604:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 02:31:38 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:31:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Topic: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Index: AQHYvNukv4zzfaSRMEm9MHXMyi33Uq3IQQAAgAAI3IA=
Date:   Wed, 31 Aug 2022 02:31:37 +0000
Message-ID: <e3488129-6681-55a7-3d1c-99a965a5c884@fujitsu.com>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
 <a66af10e-dea5-a9ec-5eeb-641b1d7ebeec@fujitsu.com>
In-Reply-To: <a66af10e-dea5-a9ec-5eeb-641b1d7ebeec@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63dd83e1-c764-41c4-3721-08da8af8ee2b
x-ms-traffictypediagnostic: OSBPR01MB4056:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMDSVeYNcNG6CcBEi1spUvEPFCKlCilRu/cABiVQvOO7G/K1029mX5kKJlkoYuMPwCpyNOJSD1PHDPP2eHkBFUtgDDdE5AYwbOb5OYHl2mtOxdn2gtUD8YquNFkuMYNxwXftm26gCnBHZ5SdsskM2TfLUcpeRCGoxHkQcWr7IX2ElGY7n7EaHJYJEitG8GFQ9Og9XmGLLW52CsU+zo5bo2lzxDsytb62oTiF66IjsZdSpxpNbAU5Izw2RzvzZJlqrL6BY1SsPaHTYgLpoivW/HPBZjQUcquUQgTP9onZmY7Ys46d7qOIYKmqyq8VM4hXAPTytZRIHY95TWHm9O8pOy1h09nb7tvJJEVxLJjoPNQXsHGnOkQZtMqw4iEajwsdBLcTsHw0QmLpdH7S83XxBdt534apMzJQVaLeL8CwsOufFaeSWjWtoHvFU5pSNI+RY0RA3Ntgbl+SYdZbUCRoJVom2hYbF2fVyYMQoHD679UAzVChUuIhALyci3LpU7IhCw/92fXd1WyxHTFWm4SwEattu65JkTGoL6yfOv4yeuWlptYABG4dfQTFf8T8hUDAvWLGm/csquxy7YJM2cc3kiuM5g75LMS7Y+RqGHYB2erZiaEOqilTwK2o73fGh3qGEgrN4Wla6gfUIMKz7iayZ3exuJjt+PcAE6JsRrn4+l8sBv/3VZlb3bMj2WlJo9QiOm/KMvIvApIsp2r2fJsRSiEiy6vQPgOjKaxo1DJb2t8hkHSqgaB+T7x+EEBeGRMjetkMX7M1UdPg/MNWxK5jesSurr5e5LiogU23MT26/aBgNcpErVWlRt0/WmAn5/IrESJgv4BEE35v4+uIPjjLwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(1590799006)(2906002)(38100700002)(86362001)(91956017)(31696002)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(76116006)(4326008)(82960400001)(316002)(38070700005)(110136005)(54906003)(26005)(6512007)(2616005)(186003)(6506007)(31686004)(53546011)(5660300002)(1580799003)(4744005)(478600001)(6486002)(122000001)(71200400001)(41300700001)(85182001)(36756003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWV6Q0g3b1JDbVFnaGl2YklnSUZnQk5qYys2N08rSEdyOXdwY1NhSHBoU24x?=
 =?utf-8?B?ZzBiZ1FWczNFNE9obnhkc21RSTNuMmw2K3NiNDNqY2tOWVQvSlZwb0ZraEcr?=
 =?utf-8?B?V2wrbEpHN2dldEQ0dUZUZUMwd0hXNWdXT1F1ZThWaUl5Ky8rb0JnQ1ZLNjhs?=
 =?utf-8?B?YlhIOEpzRkwxajV3U1hSdUZRMHk2TXlnVW96eW5DYXBsbVlFeGMyZXBpQjRJ?=
 =?utf-8?B?Y1lEMUNteldLbDVHY3BnWkdkTmpOV291Tng1MGhSNTBYc2toNmJpK1BKME9I?=
 =?utf-8?B?UHlGczZrKzNVbFZGbGpFMGx6aitDVzBmeEppbXFlNmtHZS9ycVp2dDZld0ta?=
 =?utf-8?B?SFJZZ29EUy9jWUhaOG1kT0FuSEtHSFVKNUZqZFIzOS85ZmRpSEdkNy9iQ2tr?=
 =?utf-8?B?dENhZnkyZzM1czY4YXhxTzhrUzgvU0FpRGdReElTZEdGMVF2SWJEdjNpaisr?=
 =?utf-8?B?SW9kQmRSNllLTzRPRFlzNlhaU2IvVnNTU1R3ZHhQZ2ZFYmV2Ty9FVC9xQTlM?=
 =?utf-8?B?YnovSTJRQlBqU3kxcmEvTTZKNHJ3U2ZtMUpGaWtDNXBkSi8wVUFUaTdnNWxP?=
 =?utf-8?B?dCthVHNWanVnSnNKY0N1VWNjZFMxU1ZwUThkM09Ha2JlWWJmT2lzajd3S3Vx?=
 =?utf-8?B?UzRNNThOWHd4aTVCUW1VSW5sQkJBOUxSS0FsWGo5QjF6bGtRRWhMNjRhT2hl?=
 =?utf-8?B?dldLR2hKUmlicUFvRFJlWVQ3ZTRuM01xNVN4OWtjZ0hUMWRXUnVqUXpqbnRY?=
 =?utf-8?B?d2NRVEUrYkFUNTBuVGZVaU5kR0l2NzFnVTY0OHhrQXVJazV3S3Y3c1NveHZx?=
 =?utf-8?B?YmYwaTR1QTJKSkVHQm4wYUhOSk9MWGsyclVOOGtLSTBEUmhnb2ppVWZRbVhD?=
 =?utf-8?B?QStKZWxTbXZDN3Rwczg2NjZhUnE4d29SZm5DTHdidkFCcTNqNGM2NS9JMWZ4?=
 =?utf-8?B?WkJMNnV1Zi9OUnBjUnhUbjRQbS9nTVB5MnlrMkpaaVpyMmo3ejFmQmZNQlc3?=
 =?utf-8?B?ZFlBR0VmVVJlQWozUjhHMVVrYlZJcTFMRGZEbUx1MnVXK1U2Zm1taWhmUG5z?=
 =?utf-8?B?VWZDRE8xQjEwVStRV0xpN2xqZmpaVjRoRUdtaUZhSnFnSFp0VzI1S3pPaEpP?=
 =?utf-8?B?RHh0VnptZ0x2ZUp2RHdJU3ZueGF6cnFUM0tyN1l0cmFUc3BjdWtMOVMvNmx5?=
 =?utf-8?B?bWh1NUFkZENsVjJhcy8wM2hod1lxbCt4MmlHNjR6Sm5uN3dHbWlLVzNsdGJn?=
 =?utf-8?B?RDB5UW1aVkRGb3E1eldQaEFKMmNHVS9MNjIrVEpUck9hR0NsMDgyekVxRU40?=
 =?utf-8?B?c2NyeHErczFDSVpVYlhKZVRCbVJNd2FicG9BeVlicnBXSk90b09tTmRYa1VN?=
 =?utf-8?B?V1NUWGFmN1plaTZoSGVId2dBaTduQzlHczBIZVoyQnYyVXBjQk0vTkhXUmdt?=
 =?utf-8?B?TmRpNzFuYmkxVmxDQ3laaWFteVBVOFNCMHB5dTZaaitBRWV3dW9FRk9HOTVK?=
 =?utf-8?B?bmJXT2dDQnNJMjkrbnY5U2hwWXhSeWZ2cGdsbC9oUmRJc0taZmh6TWFWaTZn?=
 =?utf-8?B?RFd2WTNycGFnYW1HNTFDMTZzMGc3SXdadFpPeTFpRDFMSXBxeTJzUWxoL2dI?=
 =?utf-8?B?a2hWdjBScjlnYjNrRWo0QzN0eUF4YWxsN2JQQWZzVFVOWGRKVXJ1bmdDR3RU?=
 =?utf-8?B?bkI1ejB0ZXNXM0VnZmtZTHRrYXQ2MWYwakxUZGdGTlJwcStGYWMzbG1FZEcr?=
 =?utf-8?B?RWE2ZVZyVWdZOXVORjNzRkJyUmd1NCs1bjNkQkRSdDF5VDBQWEhwUGdkMVdQ?=
 =?utf-8?B?OXBlZElmdUozd1lVM3d0VWc5SDgvTGRSMHZ0YXpsbW85VVFJRHBWYmpSeStK?=
 =?utf-8?B?dlVmMGpRQ1JJZkZOQ09vTzJjNk9zblhOdGYxSURrSGxSTENqeXZROXZOdHBn?=
 =?utf-8?B?OTVES01vSUN4OUx4c2ZuMUFOUTlVcGR0bHlZTHBNMW1hUXZzQVdWYU5DQUZI?=
 =?utf-8?B?b05lWTIyaUozWFNhbXE2VWdrdFhFOGpqSUtFbFcxYk1jbkxMWVg2dUkweVlS?=
 =?utf-8?B?Z2xKTHpadUdCWXpKbjYxTDVQUFlyays5UTFXSjY3am1rOUlWajl5Tytsa3FR?=
 =?utf-8?B?WGxHeGx3VWpWYXNSZTQxaGxLOXhJMUMxOUxzVUl2TTdqaEYxRWlsSzJOdHBy?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B6C1DE1CF8F8F4FAE3962593A503305@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dd83e1-c764-41c4-3721-08da8af8ee2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 02:31:37.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ldK2pA28YJv+ieqKZIv5vWQ1uxl3F75jOcf0rPB8HXpHDn7r71+Uob8WE+CG8ScN4DFQmhgfuh44WOmyuJtKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi84LzMxIDk6NTksIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiBXaGF0IGkgY2FuIHNl
ZSBpcyB0aGF0IHdlIGhhdmUgb3RoZXIgcGxhY2VzIHRvIGRlLXJlZmVyZW5jZSBzY21uZCBhbmQN
Cj4gDQo+IHNjbW5kID0gc3JwX2NsYWltX3JlcShjaCwgcmVxLCBOVUxMLCBzY21uZCkgaXMgcG9z
c2libGUgdG8gcmV0dXJuIGEgTlVMTCANCj4gdG8gc2NtbmQNCg0KSGksDQoNClRoYW5rcyBmb3Ig
eW91ciByZXZpZXcuDQoNClllcywgaXQgc2VlbXMgYmV0dGVyIHRvIGp1c3QgY2hlY2sgc2NtbmQg
YmVmb3JlIHNldHRpbmcgc2NtbmQtPnJlc3VsdCwgDQpsaWtlIHRoaXM6DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3JwLmMgDQpiL2RyaXZlcnMvaW5maW5pYmFu
ZC91bHAvc3JwL2liX3NycC5jDQppbmRleCA3NzIwZWEyNzBlZDguLjk5ZjVlN2Y4NTJiMyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jDQorKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvdWxwL3NycC9pYl9zcnAuYw0KQEAgLTE5NzIsNyArMTk3Miw5IEBAIHN0
YXRpYyB2b2lkIHNycF9wcm9jZXNzX3JzcChzdHJ1Y3Qgc3JwX3JkbWFfY2ggDQoqY2gsIHN0cnVj
dCBzcnBfcnNwICpyc3ApDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQogICAg
ICAgICAgICAgICAgIH0NCi0gICAgICAgICAgICAgICBzY21uZC0+cmVzdWx0ID0gcnNwLT5zdGF0
dXM7DQorDQorICAgICAgICAgICAgICAgaWYgKHNjbW5kKQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgc2NtbmQtPnJlc3VsdCA9IHJzcC0+c3RhdHVzOw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlh
bmc=
