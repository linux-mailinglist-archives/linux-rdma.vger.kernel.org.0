Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7953257DA7E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 08:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGVGvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVGvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 02:51:48 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF889665
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 23:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658472707; x=1690008707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LGJp0qNHaEfjz2tzfkhOhTzI+MAihvnYUUCL1lygYcU=;
  b=EYkh84sqrWRtbKenoRhQ3b1gDXEQBx9LhPxVKF9oL3UxGoqDcwAcJFya
   1i2iLE2FxEsDNDwhvOXzoh6bMi5PVj6BR9mYsEybj88VZjSzqVKQi4nTK
   jMGZTXv1PtTn+MlEAvyFlvUB16vnfSlxUr8vHwBU9E+ooQFsGBKBHSOiP
   qQrNfNXQ35so+td8juXznlXIY1RMUEuapD9EtQtft+B8ZNLLbidr8b7Yc
   nCfHt09NLohTDTO1Yal1KFBsW92nd9ZJ1kO6D7abLjhyqWdtWIUGQ+Mi/
   OSXwZx2N+JLnZ0ghg1JyOywZiylDVYdcmGRwRhAmC1OiY0Oz0rgLJdSi2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="61154440"
X-IronPort-AV: E=Sophos;i="5.93,184,1654527600"; 
   d="scan'208";a="61154440"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 15:51:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMAm9K4XveCM6eHRHTVtuqne8Tmsi++NZfUbNiySAVNNiDbUMayOMq0puycTbzugOVJxhlD0128GfeDR27XyoswC19K+umIXQ0ofsdppVMiKIcIfFw/b6HR07YuNbbcuC1MH/R1H9Nzj3UTwHuy8s1KVemcSFYwLKIwoCabD2NKtbgZRzEBJ6EOhAjHh0uLSgtWJ026QmQO/egQaqXrPkA9+wVLEC3DoCaC+hgdZNgY5L7ZPoAcXyfMq6SCOCWhIoDzh/H504/B4OMfPHrqmzENsxx0o2gnndK1TlGiRLeKZqyl1ySfFuyj0y3Bjsl/MvnM9FS2MQ1r3tCwAmUc4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGJp0qNHaEfjz2tzfkhOhTzI+MAihvnYUUCL1lygYcU=;
 b=k7+Z7XwhrdTODhSm8W1YxrRzQol1ej6Sc/FlzsYvOLI4OwXAqyR/VY7LX3SSW49dy00/zeU7VgQnMHk+u15EONnT4B0CUxxEHh63k82VgRtUXw/D8fVEAGYPrxWL/JS1hWVr17QyXPEKbMsC1k9SgsZaxua4ZkqRWSvbIczW4Nqhoy6DeBB61pmIskWPGByKe76vYq/hndlTbNb5laKUBLGam9u8NOmIDdZTQ5P9N9XOmT3U5cz4cTALq5Q8IIl9OGflIGUaerFr7xs/kQJY+ReXB6Le4Vlh2Oa7JcONTGpQ4VYBOfLH8RGM5Bx+Z5BTY9F3ydkJV77W9j4PaeLwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYAPR01MB6138.jpnprd01.prod.outlook.com (2603:1096:402:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 06:51:40 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 06:51:40 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
Thread-Topic: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Thread-Index: AQHYVfh78FJGULZERkyCenLi+ouYm62KgwoA
Date:   Fri, 22 Jul 2022 06:51:40 +0000
Message-ID: <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220422194416.983549-1-yanjun.zhu@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62868e58-b51a-4b34-2c19-08da6baea16a
x-ms-traffictypediagnostic: TYAPR01MB6138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbzdjbzPY4rKjuYC8Q77tvnU8kos6+5bsjIzeAxWxUzOXsuorQrqwOz7EOWrX4tk1tBbvOE2G7isi9r4OOAy3KNDuuAEmf7O+eCJ0VP771k/lTy9bR1NqIv2EETrkuW/ZOhVT7gRuqLWXqM1ESXH50O2JJ7YeNSMK1aj7NoMmlGvKGJGQ947hzTt0q5QHyugjhr0aUx1UvIkAYlIqb+Y2bXWFd1cWDwfS6eeyqEy7vucE396HMzs7ssmrlzJRHF6+IDjkvb6HZ4j8AEzYLdY1jYth/EmyzQ2ZnhwgNt9c2f72qDhsrIzcBz0GB7JLacEJVMqAkTrMQC7iQGeppn22pLelsbdtyAr6ZK3nU7ntKI8NEfVJUO0QCaSgXz2xsA7v4l8LgYBaNu9bLnYd83MOjYIUH5d67YfhRD4JVB8tW7G9hqe43TdJIAp3VLxVWN8Yf8dabawwkNSM9o+FbMJQ2oiKkeuGpno/A+zwEea35Xo0pjHyW/g0CMaz0jvzal5017Kyq4zqTezmHZ+Upu6/5IeWq67wmtuDpqLTAFXuQYDQ0w+u3qC+IQNLE7N7HcZ+GSfnwJeW9Ron+Niwm3aPLgb6JOtDDDtmdHiSdC+ZLELxMKIEsuSDIBhkoaf+NKDsIVD78c5/HyN9nGTjbOtx6os+YKpOASD3710evQqDxVuEtD2SeDkqGKjPFYu3Get6ONLgoDUaR1RJJ5XabnDN8tFq0JYMIWDHzyz8xO5Qkdt4W9YOznk4RT5EHdJDM2TAHWhJKT27or6BQ/1kmcCv42bN/sySU9Oa09eK/eeDN/HE5H6VBblikrHD4z6EE+bwEksT4Fruk6221CezAAsEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(186003)(64756008)(4326008)(8676002)(66446008)(66476007)(66946007)(66556008)(83380400001)(76116006)(85182001)(91956017)(86362001)(31686004)(2906002)(31696002)(36756003)(122000001)(38070700005)(82960400001)(38100700002)(8936002)(5660300002)(2616005)(478600001)(71200400001)(316002)(6506007)(41300700001)(26005)(6486002)(6512007)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVvK1MzT250N1N4dkJhL2UrUUlhd0xMdmVWWG1SVCtEUTVESkdka2RlZFpu?=
 =?utf-8?B?MWVMNjVhSDhCOW1BS2hpZEptS2hlL2dPQUZER0ExM3FrQTl5M3MwV3JBMFlL?=
 =?utf-8?B?VGVaZGpMTHVKbWluSGRoejdsSWR5NUdFNS93UTEwd1luVGRSS3lwbFdxYVhv?=
 =?utf-8?B?SmRRYTMrcVViRFNiRGVZRFNHQlZkcXR5VzFFZys4Mkc5TjJab1V0UHgxMzNs?=
 =?utf-8?B?ajdzc1o4dEtWSzcwTnc5bGZlK2ZSbzRVT0JjcU5mSEdvL0Y3Y0I3eFd6WDVS?=
 =?utf-8?B?QXJvVldZZVJwOFpJdEs4KzRua0VsU1RyTHhTbFJ2c0x2eTd2bnZmeTZqTDBo?=
 =?utf-8?B?cmlPaGlmZWwwUEg5YWZtVlMySFVWVGorUmlJcVN0bWZwWnZVMGZzNXo3MVFp?=
 =?utf-8?B?KzY4QXJxMkdHb0dHMFZodGFaN0FTMTFKRnhTSTQxZVZ6K3RneWRMSUhRYnFH?=
 =?utf-8?B?UTdhNXo3ZkYwbjd1VHFLdzJFcVZLMDhkYTlHZ0lxQVJlY1ZKaGtrbWsrSXFi?=
 =?utf-8?B?VWQ3SU42bDk5UWNwdnlnL3l1Z3AxckZmZ05GM1U3YXYvRHBOSDBoYmpiM05I?=
 =?utf-8?B?YmNjZ2orNk5NTzl0MmlhOUhHaVQxRXZUbm1Sd3BzZXNBWkZQaVJRVGF2K0FT?=
 =?utf-8?B?Nnd5Wm5ZUldiNGpkK3pwTWRKd1U4dEVCRUs4dUNnRVc4STBrR0d6VmQxZEdK?=
 =?utf-8?B?UGZuMVRlWFk2akNpczZTTmdtR2grcTRuNFJUK2hUK0tUVzBiTTE4aGJDNnFS?=
 =?utf-8?B?RmZSVkZadDF5cTRvN1Y0ejNFZ3ZjZ3JkVnpWMTVsZkgyMkI1Ty80QU12L3Nt?=
 =?utf-8?B?VE52cEk1TXZIUHVXQ2V3cmwvUUVPNzJmQ0pJQTFPTUJZN1ExbGJncy82SUpl?=
 =?utf-8?B?SFE0ekFRSmUvS1F4aFRaaDBCL3RTd2M2TE1Zck1nREhjYTRVWFFMK2t3Sk82?=
 =?utf-8?B?blFLMmlNMitzeUk4MjB2TmpheFZpNzBSYVVlMHhiaHV6NXNvdmNOemUzcUxl?=
 =?utf-8?B?RVVZb0VRendtOE9KaTdwL2lkdHQxQ0xuYmFrWGR5dlJhMjY4VFZkN1d1Y1Ja?=
 =?utf-8?B?a200SFMrbU9pdXpWd3hUZEc1U3huZ2hrVnliL0p4MXRIRWF2eGtGNmhzVjFq?=
 =?utf-8?B?WWZoRzRrL3VpYU1CazNlSVJOb0ttcTZleXZJdlBYMHFsKzNXdFVFOWdoMVFP?=
 =?utf-8?B?NkthNXNPSmgvdlMyNFB0eHRtOTFsOXRLL1hLY1h2TzJ5ZDU2NllVT2ozbDlx?=
 =?utf-8?B?SlNnV05XSWp4WHhJdHI1TmUwREZEQjRsSkREV0tIRTZqaTRhSXljSnhiZzdp?=
 =?utf-8?B?c3BlQW5WSTJEWmRyVENvMGJiYmMwUnRISEF3ZmN3dXUyZHA1RDl6VUZsTlow?=
 =?utf-8?B?Zi8zbk5EdFpNZlJyQ05ZNlhQc1diL3orWUZsMzBYRUF2VURlOENpNStGV0cw?=
 =?utf-8?B?MGRBbm5sQUZYVm9wMkZWS0o1M1I0TVJpTHo3Uk5lMkZta2hteElUZzBhd1BE?=
 =?utf-8?B?bFZOYk9XWmpmbS90ZVhLOGFLbTIzcm1pS0xkL2RNRDJZMnJrYTFkMU9DcTVF?=
 =?utf-8?B?SGoweG1aNmNuVWdDUmtGMnJrWEpIR3IzUXdlWkZoSytybFlQQUdxSUxZeUhz?=
 =?utf-8?B?Z1JNME5pNE9tNUx0Vm9hTjJCeDdBelNGSVppNHpvS1FXcHhYMFM2NmI5MHNs?=
 =?utf-8?B?SllXeFlHbHFyamxBTDFjeHJRWDhWNDhrRDRHQmFtSTcxbTltSzJFWUpkQnN4?=
 =?utf-8?B?RXJscnlBUTFoZENJRTk4bjRqdSt0L251bnZ3MDZsTDd6bzdWdjRGVjRRRE5D?=
 =?utf-8?B?TTVQcWRObjBlSWRVYnNtK0c4L1p1cHhTQlNSaExYamxJWmtVQVpHUCtlKytG?=
 =?utf-8?B?R05uRFZFaDhvRHR3L3V3eXlqcGJ2Zkt5SXlYdnRraXovZ015VG1WRE80aisz?=
 =?utf-8?B?UjlXemViTHlmSkEvR01qckhydElSWHdNeVJZZFdraFJBVEFYOHNadXRaS2Z5?=
 =?utf-8?B?WlNtelI2MHhSdnZHeTRWcHMvem5ISjRTYVc4SjNJekNqa05VUERqYzFPcGQ4?=
 =?utf-8?B?N29OeVF1aXFERHlPMXVzOWQyV296d3lqbXEvN3UranBhNmNMNVFrWVhEV0Vh?=
 =?utf-8?B?TWNzU29JNlpjMllhNWVkTVZRLzAwcXp5a3pMeXllLzI1bXpaZFRjckhKN0Zv?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B88C2D954C6E247A5D06F66919EE247@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62868e58-b51a-4b34-2c19-08da6baea16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 06:51:40.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK57PxPo53goYP9dc1oaTxzuMuV1GogtSIEDH1fB/eDOiJdZ7g3DWZ4Twwlg3TgEQ3BmmieDQCAaBphW2UhkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6138
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgWWFuanVuLCBCb2INCg0KQ291bGQgeW91IHRlbGwgbWUgaWYgdGhlIGRlYWQgbG9jayBpc3N1
ZSBoYXMgYmVlbiBmaXhlZCBieSB0aGUgZm9sbG93aW5nIA0KaXNzdWU6DQpbUEFUQ0ggdjE2IDIv
Ml0gUkRNQS9yeGU6IENvbnZlcnQgcmVhZCBzaWRlIGxvY2tpbmcgdG8gcmN1DQoNCkJlc3QgUmVn
YXJkcywNClhpYW8gWWFuZw0KDQpPbiAyMDIyLzQvMjMgMzo0NCwgeWFuanVuLnpodUBsaW51eC5k
ZXYg5YaZ6YGTOg0KPiBGcm9tOiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4g
DQo+IFRoaXMgaXMgYSBkZWFkIGxvY2sgcHJvYmxlbS4NCj4gVGhlIGFoX3Bvb2wgeGFfbG9jayBm
aXJzdCBpcyBhY3F1aXJlZCBpbiB0aGlzOg0KPiANCj4ge1NPRlRJUlEtT04tV30gc3RhdGUgd2Fz
IHJlZ2lzdGVyZWQgYXQ6DQo+IA0KPiAgICBsb2NrX2FjcXVpcmUrMHgxZDIvMHg1YTANCj4gICAg
X3Jhd19zcGluX2xvY2srMHgzMy8weDgwDQo+ICAgIF9fcnhlX2FkZF90b19wb29sKzB4MTgzLzB4
MjMwIFtyZG1hX3J4ZV0NCj4gDQo+IFRoZW4gYWhfcG9vbCB4YV9sb2NrIGlzIGFjcXVpcmVkIGlu
IHRoaXM6DQo+IA0KPiB7SU4tU09GVElSUS1XfToNCj4gDQo+IENhbGwgVHJhY2U6DQo+ICAgPFRB
U0s+DQo+ICAgIGR1bXBfc3RhY2tfbHZsKzB4NDQvMHg1Nw0KPiAgICBtYXJrX2xvY2sucGFydC41
Mi5jb2xkLjc5KzB4M2MvMHg0Ng0KPiAgICBfX2xvY2tfYWNxdWlyZSsweDE1NjUvMHgzNGEwDQo+
ICAgIGxvY2tfYWNxdWlyZSsweDFkMi8weDVhMA0KPiAgICBfcmF3X3NwaW5fbG9ja19pcnFzYXZl
KzB4NDIvMHg5MA0KPiAgICByeGVfcG9vbF9nZXRfaW5kZXgrMHg3Mi8weDFkMCBbcmRtYV9yeGVd
DQo+ICAgIHJ4ZV9nZXRfYXYrMHgxNjgvMHgyYTAgW3JkbWFfcnhlXQ0KPiA8L1RBU0s+DQo+IA0K
PiAgRnJvbSB0aGUgYWJvdmUsIGluIHRoZSBmdW5jdGlvbiBfX3J4ZV9hZGRfdG9fcG9vbCwNCj4g
eGFfbG9jayBpcyBhY3F1aXJlZC4gVGhlbiB0aGUgZnVuY3Rpb24gX19yeGVfYWRkX3RvX3Bvb2wN
Cj4gaXMgaW50ZXJydXB0ZWQgYnkgc29mdGlycS4gVGhlIGZ1bmN0aW9uDQo+IHJ4ZV9wb29sX2dl
dF9pbmRleCB3aWxsIGFsc28gYWNxdWlyZSB4YV9sb2NrLg0KPiANCj4gRmluYWxseSwgdGhlIGRl
YWQgbG9jayBhcHBlYXJzLg0KPiANCj4gICAgICAgICAgQ1BVMA0KPiAgICAgICAgICAtLS0tDQo+
ICAgICBsb2NrKCZ4YS0+eGFfbG9jayMxNSk7ICA8LS0tLS0gX19yeGVfYWRkX3RvX3Bvb2wNCj4g
ICAgIDxJbnRlcnJ1cHQ+DQo+ICAgICAgIGxvY2soJnhhLT54YV9sb2NrIzE1KTsgPC0tLS0gcnhl
X3Bvb2xfZ2V0X2luZGV4DQo+IA0KPiAgICAgICAgICAgICAgICAgICAqKiogREVBRExPQ0sgKioq
DQo+IA0KPiBGaXhlczogMzIyNTcxN2Y2ZGZhICgiUkRNQS9yeGU6IFJlcGxhY2UgcmVkLWJsYWNr
IHRyZWVzIGJ5IGNhcnJheXMiKQ0KPiBSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBZaSBaaGFuZyA8
eWkuemhhbmdAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmh1IFlhbmp1biA8eWFuanVu
LnpodUBsaW51eC5kZXY+DQo+IC0tLQ0KPiBWNS0+VjY6IE9uZSBkZWFkIGxvY2sgZml4IGluIG9u
ZSBjb21taXQNCj4gVjQtPlY1OiBDb21taXQgbG9ncyBhcmUgY2hhbmdlZC4NCj4gVjMtPlY0OiB4
YV9sb2NrX2lycSBsb2NrcyBhcmUgdXNlZC4NCj4gVjItPlYzOiBfX3J4ZV9hZGRfdG9fcG9vbCBp
cyBiZXR3ZWVuIHNwaW5fbG9jayBhbmQgc3Bpbl91bmxvY2ssIHNvDQo+ICAgICAgICAgIEdGUF9B
VE9NSUMgaXMgdXNlZCBpbiBfX3J4ZV9hZGRfdG9fcG9vbC4NCj4gVjEtPlYyOiBSZXBsYWNlIEdG
UF9LRVJORUwgd2l0aCBHRlBfQVRPTUlDDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Bvb2wuYyB8IDExICsrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29sLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9wb29sLmMNCj4gaW5kZXggODcwNjZkMDRlZDE4Li42N2YxZDQ3MzM2ODIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYw0KPiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29sLmMNCj4gQEAgLTEwNiw3ICsxMDYsNyBAQCB2
b2lkIHJ4ZV9wb29sX2luaXQoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgc3RydWN0IHJ4ZV9wb29sICpw
b29sLA0KPiAgIA0KPiAgIAlhdG9taWNfc2V0KCZwb29sLT5udW1fZWxlbSwgMCk7DQo+ICAgDQo+
IC0JeGFfaW5pdF9mbGFncygmcG9vbC0+eGEsIFhBX0ZMQUdTX0FMTE9DKTsNCj4gKwl4YV9pbml0
X2ZsYWdzKCZwb29sLT54YSwgWEFfRkxBR1NfQUxMT0MgfCBYQV9GTEFHU19MT0NLX0lSUSk7DQo+
ICAgCXBvb2wtPmxpbWl0Lm1pbiA9IGluZm8tPm1pbl9pbmRleDsNCj4gICAJcG9vbC0+bGltaXQu
bWF4ID0gaW5mby0+bWF4X2luZGV4Ow0KPiAgIH0NCj4gQEAgLTE1NSw2ICsxNTUsNyBAQCB2b2lk
ICpyeGVfYWxsb2Moc3RydWN0IHJ4ZV9wb29sICpwb29sKQ0KPiAgIGludCBfX3J4ZV9hZGRfdG9f
cG9vbChzdHJ1Y3QgcnhlX3Bvb2wgKnBvb2wsIHN0cnVjdCByeGVfcG9vbF9lbGVtICplbGVtKQ0K
PiAgIHsNCj4gICAJaW50IGVycjsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgIA0KPiAg
IAlpZiAoV0FSTl9PTihwb29sLT5mbGFncyAmIFJYRV9QT09MX0FMTE9DKSkNCj4gICAJCXJldHVy
biAtRUlOVkFMOw0KPiBAQCAtMTY2LDggKzE2NywxMCBAQCBpbnQgX19yeGVfYWRkX3RvX3Bvb2wo
c3RydWN0IHJ4ZV9wb29sICpwb29sLCBzdHJ1Y3QgcnhlX3Bvb2xfZWxlbSAqZWxlbSkNCj4gICAJ
ZWxlbS0+b2JqID0gKHU4ICopZWxlbSAtIHBvb2wtPmVsZW1fb2Zmc2V0Ow0KPiAgIAlrcmVmX2lu
aXQoJmVsZW0tPnJlZl9jbnQpOw0KPiAgIA0KPiAtCWVyciA9IHhhX2FsbG9jX2N5Y2xpYygmcG9v
bC0+eGEsICZlbGVtLT5pbmRleCwgZWxlbSwgcG9vbC0+bGltaXQsDQo+IC0JCQkgICAgICAmcG9v
bC0+bmV4dCwgR0ZQX0tFUk5FTCk7DQo+ICsJeGFfbG9ja19pcnFzYXZlKCZwb29sLT54YSwgZmxh
Z3MpOw0KPiArCWVyciA9IF9feGFfYWxsb2NfY3ljbGljKCZwb29sLT54YSwgJmVsZW0tPmluZGV4
LCBlbGVtLCBwb29sLT5saW1pdCwNCj4gKwkJCQkmcG9vbC0+bmV4dCwgR0ZQX0FUT01JQyk7DQo+
ICsJeGFfdW5sb2NrX2lycXJlc3RvcmUoJnBvb2wtPnhhLCBmbGFncyk7DQo+ICAgCWlmIChlcnIp
DQo+ICAgCQlnb3RvIGVycl9jbnQ7DQo+ICAgDQo+IEBAIC0yMDEsNyArMjA0LDcgQEAgc3RhdGlj
IHZvaWQgcnhlX2VsZW1fcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3JlZikNCj4gICAJc3RydWN0IHJ4
ZV9wb29sX2VsZW0gKmVsZW0gPSBjb250YWluZXJfb2Yoa3JlZiwgdHlwZW9mKCplbGVtKSwgcmVm
X2NudCk7DQo+ICAgCXN0cnVjdCByeGVfcG9vbCAqcG9vbCA9IGVsZW0tPnBvb2w7DQo+ICAgDQo+
IC0JeGFfZXJhc2UoJnBvb2wtPnhhLCBlbGVtLT5pbmRleCk7DQo+ICsJeGFfZXJhc2VfaXJxKCZw
b29sLT54YSwgZWxlbS0+aW5kZXgpOw0KPiAgIA0KPiAgIAlpZiAocG9vbC0+Y2xlYW51cCkNCj4g
ICAJCXBvb2wtPmNsZWFudXAoZWxlbSk7
