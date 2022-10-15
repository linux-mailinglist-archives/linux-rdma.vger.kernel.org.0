Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26275FF8E6
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJOHAi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJOHAc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:32 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1503385D
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817230; x=1697353230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rpfd3dATwf8wwzOdanxEXgJttSLO3f1VP+pMLCZ/XFg=;
  b=s2AnHKE3MRGGpkrCCcAsYuCuq+hRZdbub1Lh/XCQSZvVN22vtt3WWgF2
   6D4b36M0Q0G20RjeWdR31ufiF4WDhKnTkebDrQCwAuA4hWpc1jD3tPMFL
   SpBS739mpcoWRqSCHLAX8sCYgcu34nq1w0gSxWmjCii7BR/kMvOdovCq+
   ECGyYtSD4gT7J4aQgJAFAgmFpvwQ/3iZ/t1WYmlzPUGfhOdBvRvZY3uO9
   kdUEYSUxaeqN/9FCFv8xSRJsaHXkfzCRSHy92SC9RD459Nd5YVaoFJTMZ
   e6Dw2sZhElimxhfKonEe2eA+0gCB+NATV8DBh/O9iIpEKo0VARcVmw04B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689751"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689751"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYkdpH2NcqMIoOEJe7Dms/cxFBSCIM+DffUZcFbzlU6U5fToBBy02ZjY5vq2dNDm3ylez4An4+PyQsZhqHKPorUQogV7Tbx+028AHzHYPhRASDjWLF1LStYhltc0Le7020To5OBEx2x3lTZ2MFoqX+f6hueXsaa/9siTZskJ15ZarfNuv6h99gFmEu0jUNI0vv1ZolF5br3TT6WjCuANAQ+ChSYQGIUdKqvkPZ7nsttUgGB8xBuc/Z32oA3rngQd1zruIpemsn4oJ+6fibo8uvnWJMqFXnvVVIaKByLi4fK7WrHrNJnrjyKFrafRwQ/rMwhxmVzFo+aMXONwkCWprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpfd3dATwf8wwzOdanxEXgJttSLO3f1VP+pMLCZ/XFg=;
 b=CdptjgNzlzdDiqTUFXnRGKudTnJyQenOfGNjPxKBskdloiqWF3CIWIJJPYtCvW3ztiroxTGYfwIo+UQZOOPllurNZEDPDW8Wjr2Iv7E+CO7vBrzFCNyd6v82yL5uo3uym1XKYCnFep8nDNauD8iwoKOc4ztkDGyGbT1III7qevqlugPJlSftnR6z1o1sAQRKBOY65tK4DXTNcgnlH6BGMiKAglFgzgziCh0vPhgeQtXkWIuWEKJdzI8hEyUq7xXbr/NcKnOLyJZKn1sP70cuhxmkZljrvl1iVJxCbjVtOTamQzaBil4ijigaZ7+PgCwFymR1oSGqWzDyHIwluiw+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:06 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:06 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 4/8] RDMA/rxe: Extend rxe packet format to support atomic
 write
Thread-Topic: [PATCH v6 4/8] RDMA/rxe: Extend rxe packet format to support
 atomic write
Thread-Index: AQHY4GCLKhDKVKdpKUKvKn+dDxj/2g==
Date:   Sat, 15 Oct 2022 06:37:06 +0000
Message-ID: <20221015063648.52285-5-yangx.jy@fujitsu.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: 3f54ab66-5588-469b-d473-08daae77adde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zy92E97ugZ933fJWHou8V/SVciG4mQW+T6bqp7m0fv0NJtxxIB5A5XfnBOVSQ+Qk2iuRyh4HSLgh6EpFHAH5pP+/JAigkXexW6xvt4cFN56tEc37rJAD+F6FKhUjdU6cbAIgJbvVfD6pOQbzhR5fMjVmS2CuaeXvOpxIM19QJGJazEGTGuO8ozL7CB1MLMR3aVO8DgClTFQ2hFO453YFLvTa057bx6QMByXm276e82/BtWMH+4+DcNTPkRNG+4xHlj8VRxNwTYXjJgXyDo+A08IMybkTtBfvWtrHRrgM/71sQjNq6cMwXhTx6AivXzCpTV5HEK3aueXwzLix5TPpMrnrm040j+3qlXN8yz0Ro8vuu/PriBPXKaQyYX7rgWacEfuUkTUgF7Z8XRL6h7xV0tQliacDh/vX8hrH7l94k3A5FBsZWD5mocqn11WiNE/au/PU7rz1T/89uzsy5QUKABkShinFFuWl5KQ1NpMoPiT2012Ari3Cmpr6MXGKYpgFW44+V4TKvGGLCDyurttq8jUb93pBnHbK4MAlOJQ6kK/w0B9W+7GL2MZ0K1uJmDvi0wjTQtMb1h8OiCbSC7Y4EwflYz9J1En4bcnFBj8YP9jYob0CKzkT4yjKNNEm1qukaSQOSGYu6NFTvEdHT11ugsquqBOnQMzchkIgwNshcwzIdQI4y0sZ9K4VMK5mLdncCwIjppdiEMSoiF5UUxk1F+XXmlOQeSRJ/IBrr7Th40VIKlI1RhJo1KueKT+Eq11GovC88Y03xJG8s6c4yk6ZvKCrVqhsxoXbuzbujwn1hAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UHJFYk5mOFFmY014KzJQOXh3YXhZTE9yRTZ5RHlHWWJvN25JanJUaVNkNDIr?=
 =?gb2312?B?OFdaNHdQU3dBZ2JCdkNoZzF2NzQvOFlZU1ZMcmp3QjZ0bGpBd29PQ2lES1VF?=
 =?gb2312?B?UlhNTStOWVlvMWRiZ1dEZFIvT3c2Zm1pQisxbU9hMFQ4amU2b1NFaDJQcDBI?=
 =?gb2312?B?SnBoK0VXYVR1OFZ3NlpteW1KNWh6Tmd1anJUYnJjNzFoa3BxUFhjaUpVaWtM?=
 =?gb2312?B?VjFDeTI1czlsWkMzbnA5QjhKVlk5bXBsNm9EQlJTL0xiNExJUEwvMFlLUEhC?=
 =?gb2312?B?MkVMeDNTMitvU3JjRmFpN0UxR2hZTGJ2blFFK20zRHhGOHo0bG9UVVZOWVMz?=
 =?gb2312?B?QlJHWWFKd0dWWXJ3NmdVaEN0VnVhWHBIMlUxQWVJNHFRUGNzSURvSE5XUitp?=
 =?gb2312?B?aE0vR2hRYlFINVBwSysvTmtXbG5raFg1ZS9zTVNEMnNmMHgxeEV6N0NzR1VZ?=
 =?gb2312?B?c3diV3F6TndBbFd4S29HNW5pU2F2VGYyS2h3TTlsQzIrNkpCMUJUbmphUUda?=
 =?gb2312?B?L3Z1dStKUTJDNGtWdmVheFRHY0NubExlSGkvTWRxdUl1a1hMSTRFMHZRQ01H?=
 =?gb2312?B?VzM5RTI3NW44ZmRLUE1LUVZsME1xNGI2L0FOQ1ZCM0ZNTmpUUTkrVWZ1Yk5a?=
 =?gb2312?B?TWVreDZoc3BuTUJLR3RMcy9xL3ZLMlM0b01ONTVwWEtPRE5ieWYrM2tEbXVs?=
 =?gb2312?B?SEk2N0tMRHZEZTY4Mlg0MjVCUGRveFd6ZkFNaXIweUIySFZ6SWwwUm5Wdm1Q?=
 =?gb2312?B?WE1GL1hFSTc3Zm9IREc0YUc0cGIyZm9QQ2srQ0VMbWdwbmZLTlJGQzJUYnJK?=
 =?gb2312?B?QnFNb0RBb3o0WitPbjMvcXl6Y0dXeHQvcHZvL2dYYWtrNDlaSlUzODhuc01T?=
 =?gb2312?B?THU5NU5jUmRvZ1JyOWhtNnFBTk13UkJraHlNNStRZTBWajBUYWwwSllPbWUx?=
 =?gb2312?B?YW5hQ0hBakRQYkU4WTNQeFphL3FhUU00RE4rK0xUMndSWDRFSksrWXNPRTI5?=
 =?gb2312?B?MG15RWMrQWZ3OUtLNjFmRGhpNVJzcTdiRGdxZ3czZ2Y1bUNvWmZqZzZoY2pL?=
 =?gb2312?B?Z0VvbmV3UFZYVnNuR0lhdS9sOWJTY1Q5dm1TRjdFTVNCVThxeGJwZW5ZdnNQ?=
 =?gb2312?B?alhYSThFeTVOUWpndlNna2dxWnlVcmQvRmt0dUd6SU51bnZlOVFwS2NiQnRD?=
 =?gb2312?B?dEk1OU1KV2pMUlVnODVlckVoVmVkeFpTdWNsbDJrcmlKbG1CRnE1TS9rb2hV?=
 =?gb2312?B?UWw4L29oOGxtY2NEY3dWREl6UGpuOVgyTVJFRXlpQVRtelRwWlBnNXcrV1RE?=
 =?gb2312?B?RlZZZTY5dmx4ZVd2THdHY0VrU2Z3Um95SHc5WTMxOURqOUNNbDdtamhUMXlE?=
 =?gb2312?B?Y0ZocGdqODYwVzVwNWMxQkhmQVdMLzg1Njd6ZVMvWms3Yk56RnQxRkR4cGJX?=
 =?gb2312?B?M1Awc0EvdnlTam45Sm81ZHgyZk82K2JKV2lYaSs5ZlFiMGV6Rldqa0p5aWJ2?=
 =?gb2312?B?OThoVWpLaUlNTHpocEVubHJNSHFkTStVUXVFYkJPNGlaNWhvLytDZFpHRXl3?=
 =?gb2312?B?bmxwd2hYVkxxcHQ2cEFpWUcxNVppS1dVb0pRY3JqSmRxZnp0UEl0Q3p5SGNq?=
 =?gb2312?B?ZWFNcDhyMmpLQmxHekF0bzJEOUtzT29HMklTMVBMd3FWK2dZZWsvZDdtaWhG?=
 =?gb2312?B?QW4xK2pDVXBTRkp2T295NDhzVnZIRzZxQUJHS2swRzVBT01CVUpXZWQ4dUtT?=
 =?gb2312?B?MGROTGtPMGl4WExYZXNuUW5mYXhrek0vS2I4enlVaXVNczcyYW9tc0ViNUkw?=
 =?gb2312?B?RzdzaGZEYUNXZks3R3QyUkhjQ2JzOUZUdERTMTh1azJTZkR3Z21ZUzlGeHhu?=
 =?gb2312?B?TittamowanRKSzJvSmtWR3JXWWpwODgrZ0NySnUvMkkrUXR6NEZ2ekxMYmRJ?=
 =?gb2312?B?M3lKNHpHMEFnNXNKdHBDaWZCdEtSKy9VOUFjdHhpajc1MkF6cGRxL3VnWlpM?=
 =?gb2312?B?ZE1meUQyM3Btc2QyMU11dGV1Y2ZpNFBZYWVKZ2xUeDZ5TjZDc1J5Smx6WmNa?=
 =?gb2312?B?cEpWVDUxUldrc3J3TFd4TjJkQ2Z6Mlhzc1kzMHA3NFgyOTR3Rm9BSEZUaHY4?=
 =?gb2312?B?bEduKytVM3JEL085RjRvWGJqTEFiSHg1S1JJQWNuZGlacnozT3FSRTJPZko3?=
 =?gb2312?B?bUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f54ab66-5588-469b-d473-08daae77adde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:06.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A49gBHt9JEtF2q3YXfBO1mnmNlJiN6mVTLQpKM3L0F1bSqVF32+A/BjnvWZoYpSS/6Y2ymtvt3i1LbJEuFLvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RXh0ZW5kIHJ4ZV93cl9vcGNvZGVfaW5mb1tdIGFuZCByeGVfb3Bjb2RlW10gZm9yIG5ldyBhdG9t
aWMgd3JpdGUgb3Bjb2RlLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1
aml0c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMg
fCAxOCArKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9v
cGNvZGUuaCB8ICAzICsrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuYw0KaW5kZXggZDRiYTRkNTA2ZjE3Li5m
YjE5NjAyOTA0OGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9v
cGNvZGUuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMNCkBA
IC0xMDEsNiArMTAxLDEyIEBAIHN0cnVjdCByeGVfd3Jfb3Bjb2RlX2luZm8gcnhlX3dyX29wY29k
ZV9pbmZvW10gPSB7DQogCQkJW0lCX1FQVF9VQ10JPSBXUl9MT0NBTF9PUF9NQVNLLA0KIAkJfSwN
CiAJfSwNCisJW0lCX1dSX0FUT01JQ19XUklURV0gICAgICAgICAgICAgICAgICAgICAgID0gew0K
KwkJLm5hbWUgICA9ICJJQl9XUl9BVE9NSUNfV1JJVEUiLA0KKwkJLm1hc2sgICA9IHsNCisJCQlb
SUJfUVBUX1JDXSAgICAgPSBXUl9BVE9NSUNfV1JJVEVfTUFTSywNCisJCX0sDQorCX0sDQogfTsN
CiANCiBzdHJ1Y3QgcnhlX29wY29kZV9pbmZvIHJ4ZV9vcGNvZGVbUlhFX05VTV9PUENPREVdID0g
ew0KQEAgLTM3OCw2ICszODQsMTggQEAgc3RydWN0IHJ4ZV9vcGNvZGVfaW5mbyByeGVfb3Bjb2Rl
W1JYRV9OVU1fT1BDT0RFXSA9IHsNCiAJCQkJCSAgUlhFX0lFVEhfQllURVMsDQogCQl9DQogCX0s
DQorCVtJQl9PUENPREVfUkNfQVRPTUlDX1dSSVRFXSAgICAgICAgICAgICAgICAgICAgICAgID0g
ew0KKwkJLm5hbWUgICA9ICJJQl9PUENPREVfUkNfQVRPTUlDX1dSSVRFIiwNCisJCS5tYXNrICAg
PSBSWEVfUkVUSF9NQVNLIHwgUlhFX1BBWUxPQURfTUFTSyB8IFJYRV9SRVFfTUFTSyB8DQorCQkJ
ICBSWEVfQVRPTUlDX1dSSVRFX01BU0sgfCBSWEVfU1RBUlRfTUFTSyB8DQorCQkJICBSWEVfRU5E
X01BU0ssDQorCQkubGVuZ3RoID0gUlhFX0JUSF9CWVRFUyArIFJYRV9SRVRIX0JZVEVTLA0KKwkJ
Lm9mZnNldCA9IHsNCisJCQlbUlhFX0JUSF0gICAgICAgPSAwLA0KKwkJCVtSWEVfUkVUSF0gICAg
ICA9IFJYRV9CVEhfQllURVMsDQorCQkJW1JYRV9QQVlMT0FEXSAgID0gUlhFX0JUSF9CWVRFUyAr
IFJYRV9SRVRIX0JZVEVTLA0KKwkJfQ0KKwl9LA0KIA0KIAkvKiBVQyAqLw0KIAlbSUJfT1BDT0RF
X1VDX1NFTkRfRklSU1RdCQkJPSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfb3Bjb2RlLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUu
aA0KaW5kZXggOGY5YWFhZjI2MGYyLi5hNDcwZTliMGI4ODQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuaA0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfb3Bjb2RlLmgNCkBAIC0yMCw2ICsyMCw3IEBAIGVudW0gcnhlX3dyX21hc2sg
ew0KIAlXUl9SRUFEX01BU0sJCQk9IEJJVCgzKSwNCiAJV1JfV1JJVEVfTUFTSwkJCT0gQklUKDQp
LA0KIAlXUl9MT0NBTF9PUF9NQVNLCQk9IEJJVCg1KSwNCisJV1JfQVRPTUlDX1dSSVRFX01BU0sJ
CT0gQklUKDcpLA0KIA0KIAlXUl9SRUFEX09SX1dSSVRFX01BU0sJCT0gV1JfUkVBRF9NQVNLIHwg
V1JfV1JJVEVfTUFTSywNCiAJV1JfV1JJVEVfT1JfU0VORF9NQVNLCQk9IFdSX1dSSVRFX01BU0sg
fCBXUl9TRU5EX01BU0ssDQpAQCAtODEsNiArODIsOCBAQCBlbnVtIHJ4ZV9oZHJfbWFzayB7DQog
DQogCVJYRV9MT09QQkFDS19NQVNLCT0gQklUKE5VTV9IRFJfVFlQRVMgKyAxMiksDQogDQorCVJY
RV9BVE9NSUNfV1JJVEVfTUFTSyAgID0gQklUKE5VTV9IRFJfVFlQRVMgKyAxNCksDQorDQogCVJY
RV9SRUFEX09SX0FUT01JQ19NQVNLCT0gKFJYRV9SRUFEX01BU0sgfCBSWEVfQVRPTUlDX01BU0sp
LA0KIAlSWEVfV1JJVEVfT1JfU0VORF9NQVNLCT0gKFJYRV9XUklURV9NQVNLIHwgUlhFX1NFTkRf
TUFTSyksDQogCVJYRV9SRUFEX09SX1dSSVRFX01BU0sJPSAoUlhFX1JFQURfTUFTSyB8IFJYRV9X
UklURV9NQVNLKSwNCi0tIA0KMi4zNC4xDQo=
