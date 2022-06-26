Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E093D55B142
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiFZKix (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiFZKiw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 06:38:52 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127110561;
        Sun, 26 Jun 2022 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656239930; x=1687775930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=br/HpuXzk+rZjakrfF0fON1QYixbKU9uBzDlAfM9UdI=;
  b=U0fLxLbLGYfss6cHb/c0K0YcZ7bocZIkljf/CjvMfeG0RQCMkOKXiU7D
   hwuycC/PhjKuVxZXDC1HnOoLWJPmsz9H40f8oFshW9QTaZ4da+V+7gbCV
   BruItUh/sucaB0EdkWizCRs8Ec4zj5T4hMw91vXPDoS9eluY3Wuqlsu9H
   +ljIW6qEKEH1rd4kPim5LPjF+Mg1JN3kf7KHxBKackk0uWxGjN4gsZXZ4
   UsvyNh9jxPuYlU0TOwOUYdL3NH+XgTi1L7ohEr6NJIVDY0QuTJWmCEj2Q
   HggdGXhEkuYsGDqtet8J1/v7dtYDanfopVF1sKN1+iOtVlTeGAyE2M/va
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="58976211"
X-IronPort-AV: E=Sophos;i="5.92,223,1650898800"; 
   d="scan'208";a="58976211"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:38:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2UTxSixP2cjJXUnBtFQA4HrKpbsRmXEWO1IgckAFjBFjC/WwCADRqcOV2uwmcngU7RKoBv8zYcc1cAbAI4sVibbomxgH7dWx4YeHczIDek1IkkEi8szQDNgSYCfH9QKdZXW4/zV/RW4XGwb/pZGasxgCvnU9BaYVAnNnSXw68EqeQdDdW9aKjSjklb2/Vkw3wwPi9YzVyI94vuDQ2qRMFL7/jz1vVdQg001ho1E4lA0Y3uyd2UjekT47s97iaCclm4CxWzKA06f/QRV2kSHZ4gRKil2oRFt98KhnKhaaD+8Wwmc5uBn/dRswtJzTwhwJe4/5QrfHLGcitTUACwo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br/HpuXzk+rZjakrfF0fON1QYixbKU9uBzDlAfM9UdI=;
 b=nleUWbUJnvC6L2B8TxoCse+Z/QAAtN1p3wJEwaUwFfDuRY4FS6s47goF7Cs9rQ9jUJpCjDh/tlSAa7QG89dP6uggnzAnJcdKPnYeu/kdCucu0Rfp2wqQcWZtJWszYL7pmVtUhJnzMJLDBnmrxmQMBXxdAoY05hclDnxpsrjyZoWrRVU6tdyikvC/M7dZiwjQXyf67zd2ojF2taXpQ76OzEGFP9R4/QkROy2BhXqYlJTPQvYdi3yciw+dU1GR5gQXZYXsGCsqJUq0Z7ntoB4xw1yh3yb9+rQtRzmiVV4UVwFJTo3BjInzNUdlWdZGrVncJp7+GSAzvhOar/N+XtP2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br/HpuXzk+rZjakrfF0fON1QYixbKU9uBzDlAfM9UdI=;
 b=Ea/fR6eLNDvoZbD5qbadQkb7CI89xh09iiDkrJ/2CUSBNXl0pFy8dCp3pZFMW6M5fEVyhDTrvrcFmvcCpy1hJPb23rntnpnED6srx8vrZ/VLE0ghTQnnNILrvNxbI1VAUkyQCywDRfQNGjH0x/AMUAda+xSlpkXkL6rCOJjzfPs=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYWPR01MB8446.jpnprd01.prod.outlook.com (2603:1096:400:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 10:38:43 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::64dc:d945:cbcf:6068%7]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 10:38:43 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Thread-Topic: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Thread-Index: AQHYaMbYiPDFsYzOwUKlvzfUGK6Xrq1DwL4AgByUoQCAAPMSgIAAd86A
Date:   Sun, 26 Jun 2022 10:38:42 +0000
Message-ID: <14b8089b-586e-7240-1f3a-e36cbab7f7ba@fujitsu.com>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
 <3ee9e8d1-01dc-0936-efde-b07482a5e785@linux.dev>
 <83cfdf23-7a2d-0776-85ee-7314187e9980@fujitsu.com>
In-Reply-To: <83cfdf23-7a2d-0776-85ee-7314187e9980@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6870a8b-c009-4a38-ff15-08da57600a65
x-ms-traffictypediagnostic: TYWPR01MB8446:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Awfrg+bcM63HQwPjlbFu+69YBzZc4L1X15NeOLt4qLoKSjdFsPLACmcVbypib6UBbesa6HUtHc+oiXcvQZn/tOlD80vV4S8x0zCliredciVdLOjvSMh7DYtwVsL/pG/o/u/ZBFhHt7lipMUj+PpCTq0t3PCsTqp6ayCzcqSpIiZnOseRYd7j2D0zbb0M1SdKtH5rBUGAvyC5V8DCoS7CVX2lTgwB85anBbEDr7hwVo5sCMTu6qw28oKFwH4mJobcnMVahKPEzN32NGW4QZ5Dfd6VRjeSkF5Zi8p1HOUagxxm3ZkK/97LKqg2K1EQOLggmtymb4KVgt+6sEj+anJm9AK+htBjudr/EcxXcwjsT34uczjCr+JA+/qvlSLjF5z36nGJt+lwd+ienZWXineBdzu+JF5cdSoSMYZ1Xp+khMB037kJuUNYj1J8IXaVUrg7eOegxPbC12aTwjY4AAsSD+S1fewj2iT6d8KVY795Jltubh8TAB1HQY6R9MyW4zIrRaipEnat/uYnQgoJqzcxAiNP+WqnAFVjA6iLdcyH5aLnqd1YJCHrnAMSAdlkGb9h/xAoAAzvoNc/YqUq+1hlueluGnyayppuHjtbKa3jLomiXFQcUQZ4Okj3tZDLTZK2mz6SueqPNhehGab7afyDkvn5ZW5oUHsnBdHjEYmlAyVTBXntTXLx1GOXN2O31v4lLuyazNIe0dzjrtB4hiRWOjjjcbh5OQNNm9CVm5ugwrTvm3lQFT5hDNhSdbHkSuBIBzO3R6nWMwwzSzfz7/jSIo7XVcIE9k5TQD1+GZwCv2qPCwnDcfqTIN3ciYmrQdoIbpOJlfrcEB8BRpfiTovH0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(66446008)(26005)(66476007)(38070700005)(71200400001)(64756008)(66556008)(8676002)(6486002)(4326008)(82960400001)(31696002)(53546011)(66946007)(76116006)(91956017)(6512007)(6506007)(41300700001)(478600001)(2906002)(85182001)(316002)(31686004)(8936002)(36756003)(186003)(38100700002)(122000001)(2616005)(83380400001)(110136005)(86362001)(5660300002)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJzY21LZzlrS0lrQU80aGRVeHhIM2tGK290YVVoNWFOcWR4Y2VoT2grQnhi?=
 =?utf-8?B?eS9odE1aVUE1djJ3RGo3TCtFOFV4REcvVFJOMU42SHZaTEFDSDhPQWFyd0Ew?=
 =?utf-8?B?V3E4OFVzU1UrcysxRXpaUHRaM3M5emx0c0NzTjdJV2J4TC9HYnR4eWpwWDFh?=
 =?utf-8?B?NlJ3bDVzZ0ZFVUZtMGhzcGJPRlJIbjJJZlh6OHBDSE5mdDU4aElKRjBacTZV?=
 =?utf-8?B?dkNnTmphR1FMUktFR0lUK1hJdzVOcUo1YW1YVzR0OXl2LzJQZUY5WmVWcTVF?=
 =?utf-8?B?dE9xV2dlYm1udUJCcExlcElKWmk5azlhWXVXc0M4M1FpOVVxZlEweklTWVpD?=
 =?utf-8?B?ZkR4djB3RGQzVGxoY0tJdDIwVFNvOUxvU3JtRGtzNWdFZXlxVVNBelYvUndT?=
 =?utf-8?B?VTliNkFLTnFyZWZzVVVqM0xkQUlZYkp2bkRmNkNOZEwwWjB6UEkvNWE0Ujhv?=
 =?utf-8?B?cWY0alByUEx4R3g4MWhSOGpQM0pJUmxqT0t0dXA0UElrdmgrOWFtYWVGMTN3?=
 =?utf-8?B?bjVGMlFueTJZb3JJc0ZBRVcrYXVYbVhCNTc2bVg3L25wa1cyQlVKTDI1RkpB?=
 =?utf-8?B?OGZ4T3k2NGVycHViRk5MbWRGNGdzZkNsYkhPaE03WlJzUVdybkV1UGZiTnBG?=
 =?utf-8?B?cEVYYnpTOWZDSFBLRkhFT1NLeHJzcVJuZTdoSysybFhpajVqWjE4NUdOcTZm?=
 =?utf-8?B?M1lCejE2Sk5ZNUhjY1pHSkExdEVvOXVycGdTeHlzYjNmN1VhSjZudXFPWXhk?=
 =?utf-8?B?dXFBWGZwUE5mTFZFbnp6ZUVFZFUvU1BWZkh6M2RxU0ZDUzdaL3EyeHNJdWtF?=
 =?utf-8?B?UGlEdGRQb0hUUjltNTB0VExGVUJsUSsvd1lueFhtUm13bEY2RlQ3TFg5bzU5?=
 =?utf-8?B?cXNCV1JkZmVqWHJIMExMcnRzaERjNkkvbjBNRjdHL0xrRVBYbTh1QlVUY0tV?=
 =?utf-8?B?d2FWK1VZWjZoM2l4YW9HU21wMUNPd3NXTFJIdWdxVHRJVFJCMXYwMm95L2l5?=
 =?utf-8?B?MnRRMzVzNU01M1dNbTBhMDVha29EeDV2VFFJNUZINWpBR1p0elcydFk0TGdx?=
 =?utf-8?B?aW5Jbk5CWnVrSHI5MkxQWFQ1T0taNE51UERPd2lHbDJhSG1qOVFwK0p5cC9T?=
 =?utf-8?B?Zk1lU2lmcTlLSzJ3UEUzcmg2cjB2MkdzVTlMWWZhWEtrYUdmdVdkbkhVUmk1?=
 =?utf-8?B?aVFvSm91eXplSDJEK2VsTWdVWWRtckVYRGFialJGamRSSjVrN2piL3NuRW5Q?=
 =?utf-8?B?OXpHVFBDWjF0UG5oQ0pZeUplaXJWUVRhbUVxVHYwdWR4U1FrM2NmbSs5c2JU?=
 =?utf-8?B?TVZuYWFhcTNsbjczYkcrdVM4aUIvTXU3akxHUGQ4RWw1YXE1T05mMUZ3SFo5?=
 =?utf-8?B?QWZYeDNsZFNrQW5BYm1WckVJdUlNeEw1cWtQYzl6REtqeGVvMDZQbkIyU2d5?=
 =?utf-8?B?RXJIcElIWTlzZ0txc3ZYdm5RYXZNdGdCd3E1dVVPVGtWLytOQURKNDc4cGVI?=
 =?utf-8?B?ZjZGaWpmWGNvVzlPV1NFSnQ1R0VpcSs4emt5QXFkTnltdStnZ2hBQTNKL1pO?=
 =?utf-8?B?Sm40cUd3eXJQYmIrcWJXSlFsVStwK2FQTnZLMUNyZ2xMc0REdFdmQ1hnKy8w?=
 =?utf-8?B?UHZPcFJra21PNmdJWTljRGlRUytNSEw2ODhGUXJvczRKa0xOK0x2TGdwdG5Q?=
 =?utf-8?B?d05vcy9UOVlWWlRoUXBEdEtoOThOL2NkUmUwTU5PYThBdWpDTUZoYm5CV2tE?=
 =?utf-8?B?NGZRTFNNdk15NnM2Uml6YnVVN3g3czB6cCtWcTJqeGpWSVB2QWpieWdsTEV0?=
 =?utf-8?B?QU9BaGRwVUtYN2FCMmlXUHg2S1dSSjJhMVRkZDV4TWdGOTVQNjk4R2ExQmgz?=
 =?utf-8?B?UjA3SmNtMFYvR3l3QjVZd2szZlUxKy9YeVR2czJRM3hKdjhpYUI2aE5KSGpC?=
 =?utf-8?B?dVY4bDJlMGZoMUhsR2JFTkpIZUlYQ3htOW1xNGkrSlVtZVJPd1JEcUYrandi?=
 =?utf-8?B?TTY4S2twOUM2a2Z3M3lKczNWbjJ3QnVIZGxXSk0zT3IwLytIUjhsSWsvUGRO?=
 =?utf-8?B?RUVlNDAzbTgyMHc1QVhlanV0RGJySlNLd3V1MFZySDk4Snd1czZnenYrcCtp?=
 =?utf-8?B?NmZLNm1XRzNmaGxCOWJCRkxudXNRRDQwc25UcHZWQVVHV3VGbXlvSE5rdnpL?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19EA6B5E295D4E45B28815868BD2484D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6870a8b-c009-4a38-ff15-08da57600a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 10:38:42.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZxmK8a+KsdAOPD9dvHqftfI+6O+malDT2t8/kBGtHvt4QSLzkQMAX85kp8X6NJKH3JRuZzJSGb0XAOrCFEkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8446
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi82LzI2IDExOjI5LCBMaSwgWmhpamlhbiB3cm90ZToNCj4gKyBYaWFvDQo+IEkgZG8g
YmVsaWV2ZSByZWdyZXNzaW9uIGlzIGhpZ2ggcHJpb3JpdHkswqAgYW5kIEknbSB2ZXJ5IHdpbGxp
bmcgdG8gDQo+IGNvbnRyaWJ1dGUgb3VyIGVmZm9ydHMgdG8gaW1wcm92ZSB0aGUgc3RhYmlsaXR5
IG9mIFJYRSA6KQ0KPiBZYW5nLFhpYW8gYW5kIG1lIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGUgaXNz
dWVzIGluIG1haWxsaXN0IGFuZCB3ZSBhbHNvIA0KPiB0cmllZCB0byByZXZpZXcgdGhlIHRoZWly
IGNvcnJlc3BvbmRpbmcgcGF0Y2hlcy4NCj4gSG93ZXZlciBhY3R1YWxseSB3ZSBkaWRuJ3QgZmlu
ZCBhIHVuaWZpZWQgd2F5IHNvbWV0aGluZyBsaWtlIGJ1Z3ppbGxhIHRvIA0KPiBtYWludGFpbiB0
aGUgaXNzdWVzIGFuZCB0aGVpciBzdGF0dXMsIGFuZCBtb3N0IG9mDQo+IHRoZW0gYXJlIG5vdCBy
ZXByb2R1Y2VkIGJ5IG91ciBsb2NhbCBlbnZpcm9ubWVudC4gU28gaXQncyBhIGJpdCBoYXJkIGZv
ciANCj4gdXMgdG8gcmV2aWV3L3ZlcmlmeSB0aGUgcGF0Y2hlcyBlc3BlY2lhbGx5IGZvciB0aGUN
Cj4gbGFyZ2UvY29tcGxpY2F0ZSBwYXRjaCBpZiB3ZSBkb24ndCBoYXZlIHRoZSB1c2UgY2FzZXMu
DQo+IA0KPiBCVFcsIElNTyB3ZSBzaG91bGRuJ3Qgc3RvcCByZXZpZXdpbmcgb3RoZXIgZml4ZXMg
ZXhwZWN0IHJlY2VudCByZWdyZXNzaW9ucy4NCg0KQWdyZWVkLg0KDQpCZXNpZGVzLCB0aGlzIHBh
dGNoIHNldCBsb29rcyBnb29kIHRvIG1lLg0KUmV2aWV3ZWQtYnk6IFhpYW8gWWFuZyA8eWFuZ3gu
anlAZnVqaXRzdS5jb20+DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiANCj4gWmhpamlh
bg==
