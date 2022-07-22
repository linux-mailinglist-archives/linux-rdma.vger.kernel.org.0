Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB757E395
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiGVPOe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiGVPOc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:14:32 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538029A5F7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658502872; x=1690038872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9bXh2iJrv/x/PRekOuv5RZAEK3hXXN7U5ECbHNRL7Fw=;
  b=cVBznUde82Xr6hQufy8QZL1+mEDtW4Q6Bnmk2rcoC769KYVRbcmCkkSC
   aNiRpXkzNdHCn+Rj+QGQLa+p4u7toptYlBU1rsP+O6xM3n74WltuojicC
   o0TfHtB3bOhEqBLdrH6k3kd0y9HOqr1/HN4/srhE8IHf4CMsCntYQokwK
   qWb6y1pageJox7xCIHMG34fxZ0AsJmAA2XqTL9TvQ3xlYDovEr71ed8rk
   8pCLmcgCOv8I6ob2JJ2dHIk7WJ4gdbcSL+REvxRCrUMkUPMNruUjHwVqp
   4TjgcRgx3KBt1OYznCpX01BL8pQv1BaimhUAYFva2ivMPKCC62xuquV0K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="61212374"
X-IronPort-AV: E=Sophos;i="5.93,186,1654527600"; 
   d="scan'208";a="61212374"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 00:14:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5K3O2dUwJ9Mz5MrPAlDXS6wPYUynz8lmumO3wOxrUB+1KbAJ+2OGWF0PozS4lqpbGu6VioouWt1A/ODil8K1X0qpZ7R3IPlSWP96ancdZ5OWHAsnqEOx1lL2uOyHlPWjtN67wu3o07L1r+O/GBhHqqiuZ68hsTvad/FFUiPsPJeE91jtfFmNeI6DDbATlKdZCBywEOh179KIQ/j02OkmhWx/vlJl0Y384RBnImRkDozOQLvZleDXOstVRdZE99ZzwousUfMkuq1iHivd2yh1B9FdW8qfeMvKyq1g0eE9Pcwa7jxQzpZ+RcEKFyS9HgfYLcHxpm8uYmCeh16JnVN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bXh2iJrv/x/PRekOuv5RZAEK3hXXN7U5ECbHNRL7Fw=;
 b=WbUDo7mf9vrCdj3LbDtCxdLS5/x8OdjvyrbFtwpcsU34PNKG+nzaFxUbs13K8Tqq7mxmPJ/GOO3yAXjkTujnOFiFlc8tWNeF/Qlj3Vpf5Mg2KxvU64R9vMKWJx0LUCd2o4Vt9AsmGcx4oCH4xxQ/d+61XlZQ07Yaz+Q+ot8xGCUUXv8C1jxnVvV/XsiaOHe2umZiu0JTup8RSngzuV/NV5tYkMjFOUTbQpU84+WQmtPko/m9QJEtLTaLOZUPlwzPh3zQSauD8YLUHmyUeCq9Fe0qj7qKyv+yvU7VlNC0wpVWEaWsrqOiIh1urmKNvNU6/eCVqTgLQf5qOEh62jZN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY3PR01MB10302.jpnprd01.prod.outlook.com (2603:1096:400:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 15:14:26 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 15:14:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
Thread-Topic: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Thread-Index: AQHYVfh78FJGULZERkyCenLi+ouYm62KgwoAgABy9YCAABmCgA==
Date:   Fri, 22 Jul 2022 15:14:25 +0000
Message-ID: <cc59c87d-39dd-6307-de9e-a67a89acfea0@fujitsu.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
 <921120a1-28fa-dd2a-b6fc-227faa3c8ace@linux.dev>
In-Reply-To: <921120a1-28fa-dd2a-b6fc-227faa3c8ace@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0064a19-26d3-48bf-5b1e-08da6bf4dd95
x-ms-traffictypediagnostic: TY3PR01MB10302:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vS4zVuNMDkhZq5Rj8l4AcxrEqo3ne4y3CUTv1EkPlQOVJ5CvBryxhJg+S14ZyVxQyKh80Kdea0f+regP4RWeI9bpZNdOAZXW+PrASzN63ruhYiu2kh3g65QjfFJ1Csovc60WTP7A2SUVSlpG0AQgUnCsEQmMmtrGGNIYJbSecn974bm1RNxS9JK+5ipwa7XejEYHvMeheKgMQ22NIUf8xIM2FTI3vIHRUaHHWJhJNRWv5ZCzKnqy9vyThrgpwtk3TOy1cZLak9A5Lt05CxAZ5CzTd+mDXKOSs6s/t2vmc5qTiKB3GYtR9oHXBIcfuaYElmpLELHILxuNvlepYI0ysD4pomdIdgzSZHZyvMoADmzZPR9Bc7tOSLTvX4aKk4T9Iu8EZ/cCGmZnwulzUk0GknWwPdU6LBd82kEX0UdfAwmb2ruU+2Uz47v91gju//Z+fVPA4wYEmoW0ob0WLsVzOMbNCGewz7q4epC+qmiImo6uIVfsNVmx1RYWe4/5rrRc+Nu60XNMhamtbw1y/qbKRb9Y2B9Y4Gg7cULgI66nHtupNpo2vJSTFiMb0JoHRgq47dg/oU1v9rAIOysOGiOVAWO3SI8/iFO4NCysytC/GpbJg2xixTuObxvbJrWCzH2fnYq0MX858k/s5PRPk5J6QFnvN3M/dZ0ZYao/rgjK0UnOvtbL3h5lLtM1p0cmT+/m4xRk6f6POSurudBk7oUnyUMMKnPJR+dK2a50lTO0R8vNga8yyAiKfzaTlBa4V3rWUOhMciW2696u3h+qD82nxzJn6ECkMaqNNtVOgb9r30uhWQIu3tvYbEZRuWvOjS6lsX0GOXVlQUxPsKriU2rhqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(4744005)(82960400001)(31686004)(110136005)(71200400001)(83380400001)(66946007)(4326008)(8676002)(66476007)(316002)(91956017)(64756008)(66446008)(36756003)(38070700005)(85182001)(66556008)(86362001)(31696002)(122000001)(478600001)(6506007)(6486002)(8936002)(53546011)(2616005)(186003)(5660300002)(6512007)(76116006)(41300700001)(2906002)(38100700002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjlXOWtMSkRrVFB3c3pabkR3MHREQmFXOVBDNjJCUTI2cTVDcmlOUTROVFNx?=
 =?utf-8?B?NndIdnNBSVFhanZTYUZnbVFkeWpsdVBXbFZqdHdyS0dKWFR6TXdaMllLMFV6?=
 =?utf-8?B?RXhHelRDMXZ6bzdJUXVlYzVGbW5MN2JCamRyNGkwOTZFeE1hMmtVUlBmdG04?=
 =?utf-8?B?MGdraXZ1V0xYZ1lsWCtEaGNwcEU2OG5hNnNLeVVYdlN1aU8waEcxUXFTZU1o?=
 =?utf-8?B?RFVSdlF4ZzVHKzFCWFJMbDQ0RlBISm9TeFhhRm9MMkJjMjZlR1hMdnFLWHFW?=
 =?utf-8?B?K1Mxa2VuandldlNMOXljditVanFoS3BlRUVZcVhyd29KWU8yMHRIVlMzRGRr?=
 =?utf-8?B?aStXMERTRjJSQ1h1WDJ4ZVdGeVIwMURScGlyN1ZxYVo2NGlCUXhmMmJwbmgv?=
 =?utf-8?B?aHBNMGwxVk92NEgxMGsydHBBMzFSOFBYdk5SeEVQRHV2U3kxdklxMk9oQy9Z?=
 =?utf-8?B?c2FuU2Z1ZFYxVW5RaHdhUjl0ODU1dEJmZW9LL1VjN3ZoU2U2djVsTDBiRGZl?=
 =?utf-8?B?RXNlU2lENzNaRnM1OGVrNnJrQy9ORG1MdkwyTzlwM1RCcWNIOUFpK1lXMWZw?=
 =?utf-8?B?UHJoeE1DUUdFK1o1ZHhrRXFXdHBjSVRPVkhWZVpQSVZiZGNSdTREVUk3Y0VW?=
 =?utf-8?B?bWR5WVlKRFp6QzBoSXN1dzdlQzJHVnh4SUh4WkhPN3JLS2lRRFBUNnB1S3Vh?=
 =?utf-8?B?QkhuSHJDUWJPL0NhUFRaL2haWW1CL3RCWDBuZ1J0c2FRb2R6cm9zWXg1eUJs?=
 =?utf-8?B?SjBVR0xvUXRKNGNDUmUvZlpQTVBUL3pMcGFxejZnYWE4cjkxK1hrd01JZTJ1?=
 =?utf-8?B?K09taDhUeWtPNzRPL1Y3Y2hkbElRNm44RHcxUndWaGcrNkM4S2kzQlBiRFln?=
 =?utf-8?B?YzdrS2dTZ3hxVUJpUmR2NytuSjBrMEhZd2UyZlkzaDVZTXlyNjB3SU1JY01H?=
 =?utf-8?B?V3JDMmtyTlFpUlZEcUhqdkNyWGh1NWFXZlBBbm1yK2Exby9xbmRMQ0RKSWpw?=
 =?utf-8?B?NmVnaTFLTkFKZElLV2hzeWQ1dXYvMEl1RHg2bkN3THVnY2h1VUN5LzF1Tlpr?=
 =?utf-8?B?aGxCZDJQRjBtL3Nic0gzbktEZElRNzlCb1I4d2hxY2dkaklKVkRZVHovaFJk?=
 =?utf-8?B?WTZ0TXdoUFFJRlVvTEdxamZWa0RrcFlvWjB2bFREMmZEYk9DTVpiOGpLcEtW?=
 =?utf-8?B?V3NzcGdoUTNsVGhWYXBUMkN2VDl0bjdDSDNVak4xTURPODVuSTI0YnF5VGpE?=
 =?utf-8?B?dkFoVUYrWEZrTDJKU2FEV1k1aWtCaTZ6SVczK29HU3E1b0hFQU1CbEQrdWJw?=
 =?utf-8?B?eERMcm02QTBkeWh4djRzVXBWMUllNUtwZDczeGVVeU1oMGJtSnA1ZllWVllj?=
 =?utf-8?B?V0JvTGJOMnVldXBiK0piRkVmdnN3aS9KZFJUZS85VGNHc3R4Y29wVlUyOGNM?=
 =?utf-8?B?YXZVNTZOcmsvdjBERnVjcmxqNWVWWG1KTEk0blpMN0V4OXFQUnRmZGg1eWZF?=
 =?utf-8?B?RVp1b29lMWJvaENSRDBOV0pJdVg4VzFMcW1tb3Vnako1c3VoNGQvY2FMU0Va?=
 =?utf-8?B?R3FkaWgrM3VQUnhhZkZaVGVMakNpMm9zYTdqSEdrbmFpdDhVNzdDN2IvNVVh?=
 =?utf-8?B?c0hlZjRnaWxKR2lINmxrY01MUExuem9HMG5BVzBsZzZaV0kyVUtGM3FwZXFs?=
 =?utf-8?B?QUtuVnU5THh4VGh2VGtTc01MRjBNOFRrc01FL3RuZ0VZUkxDRG5IRGlYTnpv?=
 =?utf-8?B?c3RjYk0zYzZEbm9NNldJVXJpQ2gvb1pFbDg4VGdtVXhSVm4vU0h5VVpJMWZB?=
 =?utf-8?B?WGZnZEdUWmJtSGtsU2xXWkZUZ2pwT2lGSXFNcmlIR2lQc25aOVpCNlpSN3Nh?=
 =?utf-8?B?YTk2UUJHTkxWQkJ2bVNpdTc1M2dXdHI2N2hTcjhDa3ljZzd2UVJ0TGxFeUtJ?=
 =?utf-8?B?cGxuWXRHS3IxMXRpRUx1KzBJdm93Y3JJa29yZmFidmEwL3BXZTFwZ0xSaVdw?=
 =?utf-8?B?ajZQSmRkZWZCU1RUc0NwL2FmbWVzSFlEZnpPWVhLVHZlWmF5TFE0anlySFI5?=
 =?utf-8?B?bW11ZHpNYVdqRGk4SU5Ha2U1UGxSSGRab2RWdGpVOVM5U0tnVFFqMHd6blh1?=
 =?utf-8?B?RWhSQjVlQ2NhcUtrVWhOYTBHODhWUUhPZnNVVnQxOEJxMVpkdGdNMThQaGNv?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5086470F4CF6C449A0EBDC7CE6451C6A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0064a19-26d3-48bf-5b1e-08da6bf4dd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 15:14:25.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/sO98w/9QIB/NilLxr6xx7Fg0FgusHtPr2LWm1H+X+TF5fVsIgRi44XrnCG1H1SHwGnIgqiKnhCsgZpzvv4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10302
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzIyIDIxOjQzLCBZYW5qdW4gWmh1IHdyb3RlOg0KPiBIae+8jCBYaWFvDQo+IA0K
PiBOb3JtYWxseSBJIGFwcGxpZWQgdGhpcyAiUkRNQS9yeGU6IEZpeCBkZWFkIGxvY2sgY2F1c2Vk
IGJ5IA0KPiBfX3J4ZV9hZGRfdG9fcG9vbCBpbnRlcnJ1cHRlZCBieSByeGVfcG9vbF9nZXRfaW5k
ZXgiIHBhdGNoDQo+IA0KPiBzZXJpZXMgdG8gZml4IHRoaXMgcHJvYmxlbS4gQW5kIEkgYW0gbm90
IHN1cmUgaWYgdGhpcyBwcm9ibGVtIGlzIGZpeGVkIA0KPiBieSAiW1BBVENIIHYxNiAyLzJdIFJE
TUEvcnhlOiBDb252ZXJ0IHJlYWQgc2lkZSBsb2NraW5nIHRvIHJjdSIuDQo+IA0KPiBaaHUgWWFu
anVuDQpIaSBZYW5qdW4sDQoNCkkgaGF2ZSBjb25maXJtZWQgdGhhdCB0aGUgcHJvYmxlbSBoYXMg
YmVlbiBmaXhlZCBieToNCltQQVRDSCB2MTYgMi8yXSBSRE1BL3J4ZTogQ29udmVydCByZWFkIHNp
ZGUgbG9ja2luZyB0byByY3UNCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5n
