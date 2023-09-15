Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E27A1300
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjIOBir (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Sep 2023 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjIOBiq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Sep 2023 21:38:46 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156CE2701
        for <linux-rdma@vger.kernel.org>; Thu, 14 Sep 2023 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694741923; x=1726277923;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+BMMlf1k2tJgiF6TOPQwGs47U+uxs2vdJ0FKdrhvi9Y=;
  b=Qh8bS7Rv6Xjga4namj9628KS+9FjjLlxOGOBALgXT8pcts0GX26Fl7ww
   1GjRZ7wERKdrfL8WMAKBalbLDQDUHFAx+qxMgNipnG0wjW3PkMkN0lBjU
   a0pcTLRPRzx9Fceq2S92aBIul2YF3uJJWNd2+2TVWiwQFPijzBqPQEb+t
   utrMM5Nd2Lz30wKqhi3mg6YCmfS7iCU5cr95GcSPebGoovKxUjqxxNGQr
   4wxdPe6xAdgBzA2l9Iq4eAzG3ODM7yV2Pfu8DELvZVzEcVq/xl9tD2FvJ
   Lkj0zKkdTBSR476putt+WLMb5AsQQVrTuz96vdDOXFMNmbrjE4dS7xsSl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="95436271"
X-IronPort-AV: E=Sophos;i="6.02,147,1688396400"; 
   d="scan'208";a="95436271"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:38:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWPUkJq/c5YvK3Eb43WoVkXmxJ/0eCGwu/s8RJ4L234Vj/yBgO24JjAkPWp99dGHyLunb7+mhxlW6sxIw1HPiuc+yhVy4zNSehuX4+4qts6/jqJg8igY7R0R8RtlwWNAzDZtXXA4IqBy3YeFlOAqJyWMDst4lNTPU3s8/vJCisny9LCETocArq7ksKc7t0xtNZ/0/S3jAATBCoBSsgmRUVfl1lnFn0ENMnqf8Zfll35aOxP+r0pU8TDwfe9picdZGxPS7n/XRvbIqv2VGA0CCuGBC56PX944sdqxx9Jbm1WkPh6BzCw7o2nWxFeG1AbIgdRwj4gALwi3y6BZSqXS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BMMlf1k2tJgiF6TOPQwGs47U+uxs2vdJ0FKdrhvi9Y=;
 b=fKl2k5XFe85v+SSMP+8MCMnZjhF/aX7g3ZKk0MhHzX5QEveWb8kTNd7LRfF9aReJZpFyQ7yotOjmi6BnPJRHvZk11vmhdearIOKMwrxkJdPyCeAre/2UqIguEeHZGWDW5+xKPIRpIhumktoMNBIVt0bCalSOxnuE9XtYpU4mfTyyU9RxDWNq9ZPjTpgYAcpzU8HwgNo5ptT/YcuZ+O5B5YROKyIE86biBCP9YwpTmR/Mcaw5zq6YxJuVr+UAqivEYY8p0lHWGt9HGcINtLWjsyy73DQCx/lM69oL/CVTDQW2jtYdPVXxDOmhCohd7IBg+xD9K0cT9oVN2ILFw4Tp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB9339.jpnprd01.prod.outlook.com (2603:1096:400:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 01:38:36 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 01:38:36 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: newlines in message macros
Thread-Topic: newlines in message macros
Thread-Index: AQHZ5oPvfsTnAoXJFkObxUoM4LDSbLAZYmIAgAG7RAA=
Date:   Fri, 15 Sep 2023 01:38:36 +0000
Message-ID: <6a6c3491-5288-83ad-4a51-085797b2358c@fujitsu.com>
References: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
 <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
In-Reply-To: <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB9339:EE_
x-ms-office365-filtering-correlation-id: a2b8fe8e-f531-4f00-d7f7-08dbb58c7abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Quns0kWUxdlsAZhT7hSijbLT7qXOmZgPpxPs3bx2s/A/ADTxF7hf1eoKkIttBYtRWbXACbDHxwdhDvhtlgaFQFhE98gVnLlQnzCTc4m5qukb/8AuJnWXXddcIsHKVFlF+86tF0IewMbRLGrx0FfMraQN33iNrL/15lqtuxZGbE4w1hWAeQvCUCddWBjQeMF1TGFSt7sfq1nsQj3BFRkN5BjrJIj29MRoXvuSNvAULSV+FhZRqH4rrn71k5AoFJZizEWQeW8Un99YGUcuncVylknMhPBUGfF8Nn592Pi0HSL96L/9Pay4OLUmJcJLHjQL1pzBda/VuM+8XC0NfM1d6jHXcy45Mk0Ic3s7E6KJ+YBxjfV/fwnr24Eb7vULrg5ahZFETKGHPRjMXEqf/sY4pjD7tx5Nw/wMthIb58mYvEBYVTua5Vgg3z2DzMJeGOtFS0EQl4QdDbL6cbs61vQxPPed0NwD6/MwFrSkhMjl3dKIj4ZLev7UMhxQB6YPNXjgpGhozX4nVvopH62swLtmHPeIQwSCHSLmvesvgNwv0MB7dmCAJkKWjRn8bn8LG0s/AMJbrVHm/4+ER4sCT53Jdw+2s5JgL6AXJ8Xsi1vQSgiZcCsz5U4vfmZNgVnl5tDDwkWRNXntzk9/mpDQ7MHMInF8a6ktM+WpgEBd2P4jXroxyZ90HIKTLDeEaOv3FhNWqN2z1cgvwsAfNzPUqgcwHn5oKOIHZmWfJ3gxekWmFlw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199024)(1800799009)(1590799021)(186009)(6512007)(71200400001)(53546011)(6506007)(1580799018)(6486002)(2616005)(26005)(82960400001)(8676002)(5660300002)(8936002)(31696002)(86362001)(2906002)(15650500001)(41300700001)(36756003)(85182001)(91956017)(110136005)(316002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(122000001)(38100700002)(38070700005)(478600001)(83380400001)(3480700007)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1NxRnhaNlI2Q2RpaHVnUlU2ejNVS0RqbTVMVzh2NERkK1JkL0hNUlJpNU4v?=
 =?utf-8?B?b0RQNTF5a1g5NEQ0aktJQmJMK2JzT2lpSjRXNGlhRC94NzBRRzRXU3RVc1Vt?=
 =?utf-8?B?TVphUFZGQTBSU0ZUeGlnQ2dxVDNPOGczUFhqTms1cDUxM2J4VGt6RWxWTW5Z?=
 =?utf-8?B?UHZyN3kvYzNjTWtsdkVXRms3YXRuZ2NOR09UazBJSmxpamNRd1hJbEJMNWNJ?=
 =?utf-8?B?UDNoRVRvMzJDK0VhUU1MQVUrWThWNnpQYzZIdXBTczg1bUhXVHp2RHVEdENn?=
 =?utf-8?B?MlFSSGlUbHN6VWxORHdUWEV1K0taOFFtenlRZTIvdW5jbFduY081Q0psQ3RV?=
 =?utf-8?B?WWl1M3hOSEVjK0hWWVpIYTRXU25VLzc3ME5TNGIwOWtjMDRiWlYyak1SRWdm?=
 =?utf-8?B?UVVBc0gwZndiN1d3dGhtY0JqRzh5SUxoYmsxb1dhU0t5d2dRcEJRR29xblVN?=
 =?utf-8?B?WGh6WXdDUlVMZE1XeWtXWFlwcks3dldBb2V2MDhiSDhHVWZQU3dndm5pc2hB?=
 =?utf-8?B?dW1rT1RsckxIZ2Z2dGpWRFFaVEtOayt5V3pLTFFjL3EvejIraGFKNzdJSmRj?=
 =?utf-8?B?Zk1Xc0lpMVdNNnBRSjRqNnJjNTN2bnFSSHE3cFo5S09pRFVSUzVyUm9HeW5j?=
 =?utf-8?B?Z0ZLNXVVdVgxWGdzZFJDK3N0ZWJWaCt2TlJtTTdISCtJbkwzaTNGUTFxZUx4?=
 =?utf-8?B?dTJhczYwL0VhR2F0UmRFVFZFYXYrTHhCTnRGSHFlRDQ0eVNOSWRFdEQyNFJD?=
 =?utf-8?B?cnFJdVc2Wmw0RmRZRFJ1ZXdURUFDSE42aVdVTnRnVm9lUldMclpjZFZ2SDBE?=
 =?utf-8?B?TjdmdndmZS9WWXEwakVrV0ZZRmdKeEhXOGlNYjc0by9ibW8rTWFTamRTRjJS?=
 =?utf-8?B?ZWdXUld4WXhta0pZNTJKdnBHWUNHZndCS0VESXN0K1hvbFVLL2tOQjlSNWxn?=
 =?utf-8?B?Y2lEZjJ0VjlTOHJZLytETnh0YTd0MTBFYmZzNHpQcE9naXY3cFNIN1RjbEhG?=
 =?utf-8?B?VEdNWUcyTWNCMDUvQU5VUXoyOVlWVnlySGlxOHRDWDBiUXBERnFuVVhLekU2?=
 =?utf-8?B?ZjlMN3NYMkhmY0M0ZzlnSkhReE9MbTZKNjRGU3hpNkdBSC9qSTlIWCt1YmJy?=
 =?utf-8?B?ejkvSUhqS0RESmtGQkFXQXcycUwrWXZLRnIxQUxEbW5VQ1U1Yi9sMG5NTXNv?=
 =?utf-8?B?MHpoL0lNZDhXcXlGQzNqT3U3cjJOVnltUVUxRUdwUFFROUY3MzlyakFielAw?=
 =?utf-8?B?ZitxY3BxbjRUQmZPTHEzUjJKaCtMVFN6dFpHV1U0ME0xd0Uwc1Jtc2JjaUFo?=
 =?utf-8?B?RjQxWEFZa25zMHBNN2Q2NjV5dk1odjUvWjV2OVlyTGk1OHRtNEhnTXg3YUZJ?=
 =?utf-8?B?ZEhMM2JLWnpOQ1pidnNJSU5CUVNFQ1NhZlNBbkR2VzdLdENrRG1QTERsZXRO?=
 =?utf-8?B?V2hVa3N4ZER5ODBySEcwaWFlT0t1QmxqajlEcnF6dmhRa0RKSk1PM0Jzc0NS?=
 =?utf-8?B?WWVXVlkxNmsrcjlCNEV3eVpKajJ3SXowRGxWK2FLdHdrZ3A1NjV5cXhWcU5D?=
 =?utf-8?B?elRJNHJKVEJsYWpIVk1ZVnNabEhOcElsVk1NSWVWZnI2UWJNWE1xUTlWL0R4?=
 =?utf-8?B?VlFGK21Idlo4M1lac3laSjRJYUhSTW9JblR1bUtLZk9QM3RWQlR3Q2xSMjlQ?=
 =?utf-8?B?dzBSSHRLM05ETnpIRlJRc2F0S3EzaUc0T0hNUHlpSUdJSSswT1ZxVTB5MXlL?=
 =?utf-8?B?WEV6L3FKQ2ZjVldFNVRGZ2UwQWJ6bkg0Z1pCeUxRUU54TUJibzM4ZEo2T1JB?=
 =?utf-8?B?WWJHa1FKL2dackdGUXpiS28yaTgxZ3V4a2ZUWjhoa0JmWWtKWlR0MWhwR0dp?=
 =?utf-8?B?ekFXMjFZVnFHYUc3Q0ZlT3lhcHpreTdBVi9xejBIVjJZNXA1WkFSeThmbnlO?=
 =?utf-8?B?YlJwSXo0QzZCN0t6OWRiSjhPT2YxRUg0NXNVZzlCNGlzT0YvTGxpWkJuM0dM?=
 =?utf-8?B?ZlNHaWpnMHhFbXBpWThjREIzR2U3MlFxTFh6UDgwY3Z5Y29iM3hRWU9Tejd1?=
 =?utf-8?B?WEpSZ05RdVNpQk9TbVFpclFZV1BJaGJ6ckEzNkh4MTl3REZndnlWWXU0R3hF?=
 =?utf-8?B?bUZXUzh2MjRpVS9BdXY4ZCthUDQwQzZQZlNaTkd5UDNhTkgrdUhkUk9mdTJq?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E394A339FAB646B3EAEDE23AE110FA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UYywMQmknqo+/t5jtROsKwMUfXyihjyRj1xTA5wvWhRG71/GjzJbAwXeUR8D1jMTseIoskkhMad7if29hakMdYpARIZCxGgNx08j9KmJOtob6p+UWoC06TwhOufus6XjX/D2Yw+cSiNNZFbbX4PXE8NLo2+cY/kzK29l2N8EZOsVi4MK5B3+u7/ZGtGQyPlksrWmgC1siJcDnoS9ZHAKU1pc59Xns0aORBQc/Zsr1T2+fSxsyMHE/2VIqiYMITAU14gDmZg8s9MRFhXHw2AqGjLRkoGZso66uP5B4u3jUoOQvuok1gtxvHhNLJMv1XmfdNO8cIlzq8en5YGGRWojL5IHAXYo451SG5/MAj+YNdWtCjlqapzlwJS+eJKyH+xkqcILAnUJG70+wEthCXDueQveD/wQ1DlwanHEk75GgZORaTY9gg4SfttHOm8/1uWSXdbFtgYXnTFK2dbTLVnsxM27dC1flP+Qiky1CNvtAxNV+pBkwT31rUA5o876Yq4qO96ZJ7vv55j0ktnDdxbAvUNqOsCxZ5l5hov8W9CKoEAql6quUAhxi3JiiqbI/1Jvd1nGR12MwLhvD1qgnai/OiOdlc6zWA2l3dP2c0TKMM8KNNdZaDPoL/ODMu0aYBr8Vn897qIy+L3VVh9qRIWrRxd9sOaq+ZcnzTQejuWKZYNaeZLuSwyKHp5ryjrXu6T0bTsGjBI49tgG1Raiusdwb8i5gsjQK6pjmSCI+OwCMuc/GQCsPMSmn0vPZmdcMxiIZCSlnGfSCIl8mUM8wi9prcDUQdrx/AiqlB5x6i42xgDZES5vh53mgoISqjtsAOlk7joTYLX4HFmDpvF9CLLb/w==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b8fe8e-f531-4f00-d7f7-08dbb58c7abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 01:38:36.2304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+4RFE6UdhIvSaK6kMgClfHYs10J2ZACuLW1GhqshSPYS5LvdhU8ZG1bCobEUq+/TYx/+rekZ+5D47pNhnk3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9339
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpZYW5qdW4sDQoNCk9uIDE0LzA5LzIwMjMgMDc6MTIsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWc
qCAyMDIzLzkvMTQgNDo1MCwgQm9iIFBlYXJzb24g5YaZ6YGTOg0KPj4gTGksDQo+Pg0KPj4gSSBz
ZWUgdGhhdCB5b3UgcmVtb3ZlZCB0aGUgYnVpbHQtaW4gbmV3bGluZXMgaW4gdGhlIGRlYnVnIG1h
Y3JvcyBpbiByeGUuaCB3aGljaCBpcyBvayBieSBtZS4gQnV0LA0KPiANCj4gSSBtYWRlIHRlc3Rz
IGZvciBtYW55IHRpbWVzIGFib3V0IGFkZGluZyBuZXdsaW5lIHNwZWVkaW5nIHVwIGZsdXNoIG1l
c3NhZ2VzLiBXaXRoIG9yIHdpdGhvdXQgbmV3IGxpbmUsIEkgY2FuIG5vdCBmaW5kIG91dCB0aGUg
ZGlmZmVyZW5jZSBvbiBmbHVzaGluZyBtZXNzYWdlcy4gTm90IHN1cmUgaWYgTGkgWmhpamlhbiBm
b3VuZCB0aGlzIGRpZmZlcmVuY2UgaW4gYSBzcGVjaWZpYyBzY2VuYXJpbyBvciBub3QuDQo+IEFu
ZCBldmVuIHdpdGhvdXQgbmV3IGxpbmUsIGFmdGVyIG91dHB1dCB0aGUgbGluZSwgdGhlIG1lc3Nh
Z2Ugc3RpbGwgZ29lcyB0byBhIG5ldyBsaW5lLiBJIHN1c3BlY3QgaWYgYSBuZXdsaW5lIGlzIGFw
cGVuZGVkIGluIHRoZSBQUklOVEsgc3Vic3lzdGVtLg0KDQoNCldoZW4gaSdtIHVzaW5nIHNvbWV0
aGluZyBsaWtlOiBgZG1lc2cgLS1mb2xsb3dgIG1vbml0b3IgdGhlIGRtZXNnLCBJIGNhbiBub3Rp
Y2UgdGhhdCBkZWxheSBjbGVhcmx5Lg0KeW91IHdpbGwgc2VlIHRoYXQgdGhlIHRpbWVzdGFtcCBp
cyBjb3JyZWN0LCBidXQgdGhlIG1lc3NhZ2VzIGRvbid0IGFwcGVhciB1bnRpbCBhIG5leHQgbmV3
bGluZS4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQo+IA0KPiBaaHUgWWFuanVuDQo+IA0KPj4g
Zm9yIHNvbWUgcmVhc29uIHRoZSByeGVfeHh4KCkgbWFjcm9zIGFsbCBzdGlsbCBoYXZlIGJ1aWx0
LWluIG5ld2xpbmVzLiBXaHkgc2hvdWxkbid0IHdlIGJlIGNvbnNpc3RlbnQNCj4+IGFuZCBtYWtl
IHRoZW0gYWxsIHRoZSBzYW1lLiAoTWF5YmUgdGhleSBkb24ndCBnZXQgdXNlZCBtdWNoIG9yIGF0
IGFsbC4pDQo+Pg0KPj4gQm9iDQo+IA==
