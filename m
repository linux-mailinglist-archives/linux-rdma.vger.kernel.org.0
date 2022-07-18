Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E8577E22
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 10:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiGRI6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiGRI6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 04:58:41 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2718E09
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658134720; x=1689670720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b/QqiUf8dTwHxfMVaRY6h0qprH/YmE0/2Tn0iFy1ico=;
  b=soX9Fbg/IsfLK8qycqhQyLVHl84SOUJcxFA5Un0eFoxMI+S1T88JCXQ5
   WVh5HUoG2+aeTWg4xeDlaQLOhABL2Eh40vRr5nsOZRYcWlfrdyJP7NdjD
   1TS4ZynINkZ105lRHLxADUFCLkkItWtoLG+tDy7HRM4iaNiqotOo6H8yr
   r6Hkb5d7pPebpJW9lOreLdvesXMMaaUQkM5J/465VyYPp/Di00JZ6BTwI
   GS/R2FxRVk+93CVVOWMwIGurStbwaktqhsxPXJN+K8n4L8wtAH0AG5/Cq
   8QUGgqjIDGQaGpsiXPm+MQHZsyfIkaxDy3tzeRHrk3w5dljRlY1piyFxv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="60238591"
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="60238591"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:58:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLlanGhiU1PkhABEIICEhDuu71vQu0Fyt+opg2AdZp6dJkiF99uw1HOtXWoh7NEygzkAO1I3U1BDVNK1LwhdNyOQvo0VBmwxpEx2dO1/u4BWTNIFXxHAkYhVly+7aJZRFZoFqgwHl9LTEL8nWkrr/oWJ0SVsbN2LhXBYoZ7hnzPF+LBlHkhQsQgDPWziIVRDMVv9R0jqGOGX/ydOUg8FFT1GR98HptEw+TGS14RObTDPh88yuti+fpnG5kD9nij+C0KC278DU0qb1JdyZnbHb44HgUvzfXRHdW29mUavvhcIayamVz+YSjrHvbL/CXtrEDfp1wg1k7Gj0LEYjntFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/QqiUf8dTwHxfMVaRY6h0qprH/YmE0/2Tn0iFy1ico=;
 b=HB7xlHWWqhc2dZjV2Gb5mEwpAzWWRpddd+2Lvw2F629dXLsJaYeqnWxd0gX2tScNgD6RiMLfj678IETi/Anc3NexLXJNijZ8pykiCAVRzuQqVGE0sCdatys3O2E9tja8Jowi/eiDTyxrnZgVpF49Dk+jcCqM+YnLX0KzgIwFZf6nsxGWfIQaFrVKjnkPtCZI3IKiimRyqWS9AHo0U92AYyi2l2Ow1aASFWtZ2Iv4MjlqEqjZJuwSoSghBAD6udi6+IUPH9jJ8U8b7secFkQhzF3P1gNgpR24moBN0hrxby34a3GzqRbZ9Ls4hFxsG6lJ0ZijXkJoiOV4uMUWm1UkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/QqiUf8dTwHxfMVaRY6h0qprH/YmE0/2Tn0iFy1ico=;
 b=N4ru+1JbyjLiZja0h5E+8r7cdPM1ic+VS5JiJeYPh/UDCjXYZCE9gUZ6hdnNMzfRnMWIQ+hOmHmjddSirB3uW0D23ZXw9yg2lmmienzPEHXvdTEecRcSIoM1UN1C4Z41cHpZivafF8Y+gunTauYIjr6mF0afIhvwiad3hQHmBKg=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB9553.jpnprd01.prod.outlook.com (2603:1096:400:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 08:58:32 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%3]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 08:58:32 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Topic: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Index: AQHYkn6c+nf9xkj1KUiqbqr8TyUl7K2D2ywAgAAI8AA=
Date:   Mon, 18 Jul 2022 08:58:32 +0000
Message-ID: <4bca5022-2db6-b788-9a88-0615d6ea9e97@fujitsu.com>
References: <20220708035547.6592-1-yangx.jy@fujitsu.com>
 <YtUZNruUx4jjrNhW@unreal>
In-Reply-To: <YtUZNruUx4jjrNhW@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cb84b6-b2bc-4f97-c503-08da689bb12a
x-ms-traffictypediagnostic: TYCPR01MB9553:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHAuiYoiIq8MHHFyB+T0FWnyMENgmw6MCA0XB2PoFZlQs4PdqTywNBBv3y4UAFWHiVQZmb27dNtgRFY54m17itKZKdhAsiEGZYvraYeK2RaOizO7gYkuzYXRAllaDSqNHD2Ev0XxyAyE3z7nPX9fN/8gwSWkK7SvPyP10SQkUL0slGhVjC0mlzXQALnsEttk0FVK1RbyFi5/jTjzS2Jlp+8S+bnoNG/ip0WiayUe3igLjNTdOTzJ5AepZEWth13YtrdXwb6m9edGI5DZzX7ScidDhAj2yO2Bz+XlnwqLQI8XsaM5qp2Wc3qqJ1JCe1dkaTPq8L4H4B2V4xV0U/kRycH5He0xzvPiVePmx/iljg/p8Drj7y7VfMouGqioV0+dsCQatQlhbr8lwvzB1Dc+sTX5f2Eq0Eurcq1h/a0TVh/NT9ogHCi0orb5xKKUUoJHcov/sbaYajE3A6aQwaR2lHhDIY9fNnCr/csxPELjNaB7X+sDotacF7u78gTkn8gHlZbIXinxynqRjEDp1EijC0bpbUGJDYqhpWKOy2O6r9pRM8YhjGJOW37zDrgcVev4RJopsbGzFzhNuDLBY53bC5ALFyahxEu/AXdKXv8YR/XrZ8EO85CfoEcJdWgq3Vt2gIUTHDJvF0d/xQAO4+Ua9mGA19xot4+7vIn7ftELXilzTj2HvBCtHVO99NvnaDFICMSp54MqOmuFW+Btj1P+AYQGI3r3mpVRiYewKYUrv0anuTnBbdxkBH4gL5b1TqjX5NbpuElIKVPj0YxXnmoEJ2w44/Z2eqDKbAZ7xm3biqrROELAryXgpEy6/LmLsV4W1Htxx6+rZiG6YCyLnhW+qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(8936002)(4744005)(5660300002)(4326008)(66476007)(66556008)(66946007)(8676002)(64756008)(66446008)(85182001)(36756003)(76116006)(122000001)(38100700002)(31696002)(2616005)(2906002)(86362001)(82960400001)(38070700005)(6486002)(71200400001)(41300700001)(478600001)(6916009)(91956017)(316002)(6512007)(54906003)(26005)(83380400001)(53546011)(6506007)(186003)(107886003)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGw4dmxBN1ExUHhNRHV4SnBSUVdRSkx3K0lHS1VSWUgzVkxaSFZjbXZoSTlt?=
 =?utf-8?B?VGNDSDJlL0hRTy9QUFBNaHI2MzlreWFiMHdWVUZ5Z2J4NmtIMmZSQjVOekhY?=
 =?utf-8?B?N25vMWkwdTk5cGdzL2FRK2phZWh3eXUxajdSNUs3VmRLUER3bWx2OHFUaEdt?=
 =?utf-8?B?ZTVGbXRqOEdaWWdoTlI4NzRkWTVyRDFPSUNIdHR3VHJBVWJxS2pud3Z3MGVy?=
 =?utf-8?B?VjlQVHdobGdIUitKaDJiNUdXMHpWN2FmWU1xWHByQXp1eUxoMnFGcm92NTBl?=
 =?utf-8?B?QzFUQTFpVlB3dXlmTXNMSmdxV2hMRm9mc0JwREV2SzBuUXk2eUJZM2NpMGY3?=
 =?utf-8?B?TVJDdVlWTUpuOXFZYWdzM29ubHpBcWFnenNwMllqajZkTE15M3VrTWZVTHFN?=
 =?utf-8?B?NHlacXB6d0REWVZkSVBPcHV5NEVZTkRqaFAzV0V6MktaUUdMaER3NnhxS0Zu?=
 =?utf-8?B?ekVFWU1VbEdlSDdQK1F4NldIcFkyaTJWaCtmS2ZwNHBzTHhiWVA3Y1ZMc0RJ?=
 =?utf-8?B?blNFM2JVMHRTM3BoWEFyemNZTXBZMjVoZERsVWJFOVFBRUdaQjV3Vnlnc3Bw?=
 =?utf-8?B?eUhHVW1TT0lxME9IVTZhU1I1QkVQSjRjU1pHaVU1UEczM2VETXprOUF3VWlQ?=
 =?utf-8?B?bjhFT3ZWcTFEYTQ0WWZLK0F5cElTY0tDN2txMGJsU0p1cWoxUGlQbHBqaEZV?=
 =?utf-8?B?U0pndlUzTy8yN00zUWNuMzJMZW9qdXd4S1NNUFIwMlhZdkVwTEpMQ0h1WTN5?=
 =?utf-8?B?MllrMThaOFUwTlcxSno2SXRiTVF6cXAzRm8yb1I5UmxGaFNlM09kWUtLUmhn?=
 =?utf-8?B?QVFCMnhaVnFTa1k2TVNmbkEvb2s1N2VDUEorK3RGWDl6eDhxT2ZuOHh3UGsr?=
 =?utf-8?B?THZGQ2ZZWWlCTGlYMWlLcXp5WFRJOGN4Z1QzbUJwc0c2ZSt1R1ZvZlpQS1FJ?=
 =?utf-8?B?MktBLytXc3BhNDdwSUp5UWhUNzhrQTNPQS9EdjE5a1VURHJCS3N3SU5lS0xH?=
 =?utf-8?B?VFc2UDJFQndGTmUvQUVSY3BhTXZWZ1JtZ0ZNL3lpYmp4VlAzbnh5enpVblY1?=
 =?utf-8?B?SzN4TlkrbHRqVGVjYWxYY3dtWnZ5azlwaFZnaUI4M2tPdTBDeG8yL1hmclcz?=
 =?utf-8?B?Q0ZHTm1CbzJuYTRCYWNhd1pwbm0xYnVCM0lOblFJbkhtUGZJYkFjMnVhYy84?=
 =?utf-8?B?MGU1STA4bWx0MStzL1prMGp2dGVqdVlRR1FxTmwwQzJBakRFenRTQi83cFBy?=
 =?utf-8?B?bUp3aXBaN1MvQjI1elMvc3FkaUhJZVdQQnRzd0xoNUQ2c2J5K1dYMmxUWmJ3?=
 =?utf-8?B?RE5kM3ZNWUJJNU9lZU5NSDVWT2ZFWjIzV3RLdUxVSzkycTY3NVJnRjZvM3ZO?=
 =?utf-8?B?dE5sbnFYSUJmOG9LQk1xV3Y2Q0FieDV2TnhSWFRscXBIbHRXd0x5dHk2alhE?=
 =?utf-8?B?cElRUklNbGlmcGRScnp6K2Q0WHY3b1N1Y2hldWVhbDhVNnZWRUp5a1N6dGtr?=
 =?utf-8?B?YlF2d2JNTXRjMTVMZkFUaGxNTWphTUpDRVFMN3VRTUUyRnU4cjJNVHBDRzY3?=
 =?utf-8?B?b3pLTGpBMzJiZW1tZ2YyUGJyMFpFd0t6ZDg4Vll5SHZtSHRmV0JPWm5CSWJL?=
 =?utf-8?B?VFdyTHlNSjNieFJlckV0aTBBM2ZjeVZHeXVYSEp4N0tzclk5V2VEL21xWDBm?=
 =?utf-8?B?M0FXdUdUM0hkci9RemJEUXBMNmNJaFFnYWxIK0IwSy9Da2laYkVnc2tSZ1dn?=
 =?utf-8?B?YVN6aDBzSk9PVllKUVBMdUtJanlHeEE5V2tqaWxtVEUvaTBoZm8zakZ4djlQ?=
 =?utf-8?B?RFRuRURWbnl0VjJXaitHWXcxd3lnazg4V05HYmNnR1NFcjlmNURYS2o0ZmJW?=
 =?utf-8?B?NVNPNjMzaVNJTTlGemxZTTU0R0FCaGd4MnRnREFQd2ZOKzNNWmVYMTk5Vm1q?=
 =?utf-8?B?Smo0L2c2RWw1T1U3R1lvNXVFU2ZyWnFQQ1ArUXk0eWhNck9kakNoWlNSUlJI?=
 =?utf-8?B?Y0RMTHBmOXVKaGtMeTVhbUJ5dnliODIyV20yR2pKVVcrV1BOTlRsNytVZkJq?=
 =?utf-8?B?cEdRT0lpNjNqR2Z6dmVnMmlTZG5xVkU3OWwxOXkvMHRQR01JTUF5a3Evd1Fj?=
 =?utf-8?B?YXU4RFJLM0lCRGZxVm13VmZqMHN3L004cXVRL0dSOFpTRTkxZTV5S2RoQjBw?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAED6DCEA044DB4A9C4659C46E1920A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb84b6-b2bc-4f97-c503-08da689bb12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 08:58:32.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vIvEuKyA0nzwFg7MvR60e1RDmqv2a4jvMienPgCIItrJDLofWJlYuTmfkn4nXyPtWEJ5SKmUm+m7XokRnRkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9553
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzE4IDE2OjI2LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIEZyaSwgSnVs
IDA4LCAyMDIyIGF0IDAzOjU1OjUwQU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gVGhlIHFwIHBhcmFtZXRlciBpbiBmcmVlX3JkX2F0b21pY19yZXNvdXJjZSgpIGhhcyBi
ZWNvbWUNCj4+IHVudXNlZCBzbyByZW1vdmUgaXQgZGlyZWN0bHkuDQo+Pg0KPj4gRml4ZXM6IDE1
YWUxMzc1ZWE5MSAoIlJETUEvcnhlOiBGaXggcXAgcmVmZXJlbmNlIGNvdW50aW5nIGZvciBhdG9t
aWMgb3BzIikNCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmggIHwg
MiArLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jICAgfCA2ICsrKy0t
LQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgfCAyICstDQo+PiAg
IDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
VGhlIHBhdGNoIGRvZXNuJ3QgYXBwbHkuDQo+IA0KPiBUaGFua3MNCg0KSGkgTGVvbiwNCg0KQ291
bGQgeW91IHRlbGwgbWUgd2h5IGl0IGRvZXNuJ3QgYXBwbHk/DQoNCkJlc3QgUmVnYXJkcywNClhp
YW8gWWFuZw==
