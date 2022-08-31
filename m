Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CC5A7453
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiHaDQr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiHaDQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 23:16:37 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211D4F66F;
        Tue, 30 Aug 2022 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661915796; x=1693451796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PPKGi0wQg/2I4eTLmzZ87me+QQyJJmc9p0vBh9u8zfk=;
  b=Vw4kldqPQk8cndcauMpZZvUvY6NIPGrxwS9U0Xxu1PfrKhgy5cAZXTWm
   /+LhAA+S5N9113Q2Wv6OadmLiF/U+/GWdCrqm4R7sd6P0jhbqxFCQ4sKv
   X4A/uET7kqka/f4mkcybrKZL1dt85FWA8M+5GXraW9R+KvUgsEBhJlB9n
   /16fdXw02MPIuRVndODWN/ME2NEh1z3uJ9QjV8lVqNGXKkViBynPeI/f7
   hNQp7nvuIeVIZ+ld7Dw39j17Miz9NUrM+ANMBltlu2YRh+eaKXKTerMD0
   scwIqVDEA7Y1LCzhDRpwzk3i8L8Nc/BBcKtdEM2AlVczUUiUWQklRwk/p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="64024753"
X-IronPort-AV: E=Sophos;i="5.93,276,1654527600"; 
   d="scan'208";a="64024753"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:16:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3CU9AiOm1AbMn/bl+VvdzNQPiamQbUxA1lnZV0EXuVVYZ8atJera7ApEOv6svszaSEZl74yaGANeojJHbLOXn5crSyRGsfSHN8HQq/sHaZ6Nxo7DJFDBjhU2wTfhCfZ1AEZL19sav1D0O52MyCp7hL5c4268TQ41MM+VASJMBNFfh/ZTPUiecBTpwJX6ahYFFAYEqe+DZKPuIKd1Wnvw/qlc/HfU92vQQAACqZgbAfXEFLMStj7sNOM8nwohfiG6vIk6YpqgcPqVd8Kag6jyR42IdL/uKObDHIzLyklnAIDr4Ce/a7x+pybxSxVoHoQjyHv2YEUEnO+12soO5f/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPKGi0wQg/2I4eTLmzZ87me+QQyJJmc9p0vBh9u8zfk=;
 b=YfCIwqk/2NYQ1TKy2uJbSQOZAQEFFEOv+1qNm5Esg3wVMq/vrqzUviVVduKP+HBwSqHSpmQXeyh4j8S3nHu/AWX1k5aaC723OBghQqMdbke9feGrKGA2P4W8UKdmfutx+/AwxE94iQwbr4E7poY1x2z0t+bE9PXTSjTAoedA3F/i6D9Wf6MJc4o/Uq3P45vvpSVJGicqPEundXx/le7Uz2IkGM9scRSbYT/2ILFnOKXOuWVFn5MNjNzbWYTv7IrTFCoaDMz8mgYj3aIGGZeEPiRwTwdJeyIyipk7ZTe73EP/m4ewb1+KHJGH044P3ZPU2MDB6jztuB8Ozl2gP0kCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB10229.jpnprd01.prod.outlook.com (2603:1096:400:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 03:16:28 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 03:16:28 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Topic: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Index: AQHYvNukv4zzfaSRMEm9MHXMyi33Uq3ITkmAgAAIGwA=
Date:   Wed, 31 Aug 2022 03:16:28 +0000
Message-ID: <bff7565b-7159-e8f4-e8f5-711994f95056@fujitsu.com>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
 <5daac9db-2b34-fbe5-a891-8ecf77fbe46f@acm.org>
In-Reply-To: <5daac9db-2b34-fbe5-a891-8ecf77fbe46f@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbd2814c-099a-46b0-9d22-08da8aff31b8
x-ms-traffictypediagnostic: TYCPR01MB10229:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tv4EqcpvK8iV1eM2OUR4tFh4ZNqZ0Y6V9AUbSFaSAeS52TyWOrReZAILZiR/n7GCJi0Ohj4Ik6CDC6vG8KXtJMxygy+5FQFGC2ZzzhagM4i4Fp0s4A4DQXsNvQPJrntUz3PFFlGgIxynivYi0fRAMpirIgIcUc1KHv3P+qxe0uSgZYGjNue1BU4PcDK3f2eoV0DgolRTLHpb74505TVCABpg3hYZgbQXiBmYysvAAGkO/hm/GwX1+xIqfnDfF0BPpzyINxd/oLGWjXXwEKBvisGj0GBQ/98/+3DuYAQYQ0HJFWJ4QP5tPFctgCLs3coZtlsgKe89A77U0YBnGOWvDq9ntBoVdW3W/Vc6jcXEIMYlyFJ4I8o8lg6OS6kQDy/XPy0kXnmQG0lRWcW42q+OmgmPcJuRbTOlgWNgDgDf4jFy9LmgruiZ21NLKig7vEGuyyMXR08FqD+As/y4rijzOd7ASzJMFGkYkv492/ydbabFDYKWWkf+Y52t987ohr1wR1jJeBfH/ZrpW/HGL+n4QVrdwkoJv0Rvf7s1Jhs3F4w9k9avscApK1Mm8uXc/5kqRCr6BPCtzE+4zVKon5ag5VvoaJVZVLDYvb2u3EmjhE7E/UK2U0/FbI/0kDgc0j30GL7dOom2WiWBP24cmZ+eVWdz3sQ3iF7LcsqfqRI9Dyl6EkKyzKnhAFbpSfgyrA242+xh+pYvyH/a4D8XI+xkyfG6fh7648ZFT0lB2y4MZ7HHXgNYjdK/mRXKXHTiiIX4UvpyqFIE29q+jl3yeD5nHkXd9FDvAoQgaPZ72jbGjj6Pw+iXh3ATfTXCI250va/SfQXpVID1lMZ43l7V9KZWpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(1590799006)(2906002)(64756008)(66946007)(76116006)(86362001)(8676002)(91956017)(66556008)(66476007)(31696002)(66446008)(4326008)(6506007)(82960400001)(316002)(38070700005)(110136005)(54906003)(6512007)(186003)(53546011)(2616005)(5660300002)(1580799003)(71200400001)(8936002)(478600001)(38100700002)(6486002)(122000001)(41300700001)(31686004)(26005)(85182001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWRSQ0FQTjk0cFJXamZ1WDNwdTJUL0RyZysrRlZ0dEtQd3BrZkVja3hSVUNx?=
 =?utf-8?B?T1VMZmh5N0JFWjlyS0JDTFQ4L2t1QVl2M3RISlJvQWptT1ZqNEl4MjhneVhQ?=
 =?utf-8?B?eTBEMVNFc2hYT3NycG5rKzNnNWhxd3VBOXFwdVBoTE9yNkVxVWJyMmtzV0Jk?=
 =?utf-8?B?KzJwaWZFS2orek9seENvUEx6cU4rcTZjdytOS3FKNjRnejRkUjRQU3dKVllL?=
 =?utf-8?B?NGVCbS96SDNXcU1qR055djBtb0w2cUJyUHZvenBnODJhQmlNa2dhbkQrMTA4?=
 =?utf-8?B?SUthVGZ5KzFwTDJ2UGNXQWZkZmZ1dWlId0Z2NGpqWUlBTW54OWx3TUpwU1VL?=
 =?utf-8?B?Z3VyNmFOWlFxcmYzaVJ3UXR3aWxNWkc0MTRGUjJEb2p0cGw4czdRQjF5MU1J?=
 =?utf-8?B?WWdRbTlBdW1kN09jWlhHZEFaNFNxaUxHcjhyMFFEajFidEdMVGQ5V1NyMG5h?=
 =?utf-8?B?SW9UMjNjRFRuWHcwa3p4UjVHbXlDWDNUQkpBMTRPYU5xenRaMVlBcE9KT1hU?=
 =?utf-8?B?b003dW5HY0tqUXRtQjF4NGViTkhXUEtjN3c0aFh0WUdzTmo4STZaYTUrbGdi?=
 =?utf-8?B?STNqRzJReVh5RjAxVVBVWExIN0RGSmFMSndiQ3MxS1h1dU1sbDFLeGN0MnlU?=
 =?utf-8?B?NWhmZUlTMEllWHJUSmsvTnF3Vm1VK0hNeS80bWRPM0NJZklWdy85T1BzQnZC?=
 =?utf-8?B?RFlZQjlBZyt3MU5KdUpZZjJvbDdFM1dmL1pYTDBYS2xvTWFEYVp3TFQrWFBR?=
 =?utf-8?B?UUEvWHI5OUdwTVM4dWtaWEFKNURZbUNuZ2ltRFR6ampWWXNEL1Y3ZFc0VmtK?=
 =?utf-8?B?MUp5RkcwZDZTQmE4bElwTElFTmozWENiSkc4bmlvYmhLbEp5OG16N25QcmZp?=
 =?utf-8?B?NjRSV1JCQldDVi8yeS9mUkZnS0FLeE9pdUZCd3RRaUlCUjY4NzZGRDlqcWFl?=
 =?utf-8?B?OUgzaEJlY1dtSGxSQkdlam9mWjhxbzlWRjBDZ2p3bkhrK212VW9mTGFPeWxG?=
 =?utf-8?B?TFdmRUcySCtwSmZTWnlUelM2UUM3ZUpHTm9vc1FkS3hmSjZqdzJXNmVWZ084?=
 =?utf-8?B?RGJiU0I2NWx1Tm1ZZzVRdk9sWS8wZEpLT2NjVTJKYXdPbTZEdVhXVHJaVGNj?=
 =?utf-8?B?dVNjTXJlZFdMUFJJQ0szNGFOcTdZY0orcTI5d2lJcUtNV1JJM1ZnQVR3djda?=
 =?utf-8?B?UGF5OThDMTJ5NHlxQXdKSVhtN2UrRTl1dml4dDVCR0dIRlEra3Zsd1RwQ1pQ?=
 =?utf-8?B?YzNEeHlkejRNcldlYVA3eVBaVEcvOFhFMEw2eTZmbW5LKzNkUkE1UGZQeEFV?=
 =?utf-8?B?MER2eisyZnFRWmcvK0NPYUZuZ2FNUUtHYmQzYTlHM0xNWVVhTEYxeExtZVpC?=
 =?utf-8?B?cUVKZGxrNS9FUVg0MUdDSUFuUExaOEdKREJSbkYzWnN4NmNYbUxiVm5vbjBU?=
 =?utf-8?B?TFk1L0RWbWFPZDlnQjFsNmRPeXNtaW9sL0hObVhxZUxzK3cwVXRScmpKMlpw?=
 =?utf-8?B?elVtZ3JjdUJkNHROb1JEL2hmaWkzMmNlb2kyRGoyOFcxWThNazZXT3FHcVJo?=
 =?utf-8?B?S1pJWlZXaHVRZ1lWWXVoWXoxNFMvRGFkRWs2bkRCVEp3UGFuR3RGRWdqQ0pT?=
 =?utf-8?B?Skt1S3NOZlRPNmV3c3BKU3ZvL25SZzR2VHYvVWVRWW0zeVBMSERYUmpldFJL?=
 =?utf-8?B?V0NFUUhZY3grZ0hsbVdabzdDdXRzVTdydlViSGJFOWFmMGZWSTY2QzBURXRG?=
 =?utf-8?B?a3BndEt4ZldBck5oOTBkcUU0a2lzYi9VNGtieXVmM0hrNFdmVk9CRFpHSTcy?=
 =?utf-8?B?T2RVTkpMR3c2alM4RVFjTFZkem1XL2hMR2dhUEFVdkJIbVBnbXFvaU5sWVUv?=
 =?utf-8?B?TmJwT2hZZnowczFtZURHWWpLUXFzOVFWWk1kTi9vcWVsaVJCb0MrWFY5bnhB?=
 =?utf-8?B?RFh4QUNXaGJRbDNNMnhrUy9PRGlnclhrb3VCMTF5RUNaM0l1cm82TlBORWNT?=
 =?utf-8?B?UmFpVjNZNjdIcUt1b0x5TnB0N3ZaeG5COTZZN2FLaUR6aExQSjErVmJqc29u?=
 =?utf-8?B?ejZFZlhrUG1CbDIxdHBqZTZjaWdBSTkyN3Q1WTVwSkVYTnB5TlBDUnE4SGRU?=
 =?utf-8?B?eTZVUEM0Q29WQ1ZKNzZSdmIzdk43TVgzUUtMbjloNFpQbVBaVkZUWkJxR25E?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3180ADDDB39654D96C8B5C5010EA171@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd2814c-099a-46b0-9d22-08da8aff31b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 03:16:28.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIh7NJN4rJPR5DtE+we9zTHDlLq2KppUZN2DIaemzEXE7t5DZUZFGS/nSgb3IJxuX/XHhBbNQltKm8IPRjygpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10229
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi84LzMxIDEwOjQ3LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IE9uIDgvMzAvMjIg
MTg6NDcsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jIA0KPj4gYi9kcml2ZXJzL2luZmluaWJhbmQv
dWxwL3NycC9pYl9zcnAuYw0KPj4gaW5kZXggNzcyMGVhMjcwZWQ4Li41MjhjZGQwZGFiYTQgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycC9pYl9zcnAuYw0KPj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3JwLmMNCj4+IEBAIC0xOTYxLDYgKzE5
NjEsNyBAQCBzdGF0aWMgdm9pZCBzcnBfcHJvY2Vzc19yc3Aoc3RydWN0IHNycF9yZG1hX2NoIA0K
Pj4gKmNoLCBzdHJ1Y3Qgc3JwX3JzcCAqcnNwKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChz
Y21uZCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxID0gc2NzaV9jbWRfcHJp
dihzY21uZCk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY21uZCA9IHNycF9jbGFp
bV9yZXEoY2gsIHJlcSwgTlVMTCwgc2NtbmQpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2NtbmQtPnJlc3VsdCA9IHJzcC0+c3RhdHVzOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxz
ZSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaG9zdF9wcmludGsoS0VSTl9FUlIs
IHRhcmdldC0+c2NzaV9ob3N0LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIk51bGwgc2NtbmQgZm9yIFJTUCB3L3RhZyAlIzAxNmxseCByZWNlaXZlZCBv
biANCj4+IGNoICV0ZCAvIFFQICUjeFxuIiwNCj4+IEBAIC0xOTcyLDcgKzE5NzMsNiBAQCBzdGF0
aWMgdm9pZCBzcnBfcHJvY2Vzc19yc3Aoc3RydWN0IHNycF9yZG1hX2NoIA0KPj4gKmNoLCBzdHJ1
Y3Qgc3JwX3JzcCAqcnNwKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqDCoMKgwqDCoCBzY21uZC0+cmVzdWx0
ID0gcnNwLT5zdGF0dXM7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJzcC0+ZmxhZ3MgJiBT
UlBfUlNQX0ZMQUdfU05TVkFMSUQpIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1l
bWNweShzY21uZC0+c2Vuc2VfYnVmZmVyLCByc3AtPmRhdGEgKw0KPiANCj4gU2luY2UgdGhlcmUg
aXMgYSAncmV0dXJuJyBzdGF0ZW1lbnQgaW4gdGhlIGVsc2UgYnJhbmNoLCBJIGRvbid0IHNlZSBo
b3cgDQo+IHRoaXMgcGF0Y2ggY2FuIG1ha2UgYSBkaWZmZXJlbmNlPw0KDQpIaSBCYXJ0LA0KDQpT
b3JyeSwgSSBkaWRuJ3QgbWFrZSB0aGUgcmlnaHQgZml4LiBJIHdpbGwgc2VuZCB2MiBwYXRjaC4N
CkkgdGhpbmsgc2NtbmQgbWF5IGJlIHNldCB0byBOVUxMIGFmdGVyIHNycF9jbGFpbV9yZXEoKSBp
cyBjYWxsZWQgYW5kIA0KdGhlbiBzZXR0aW5nIHNjbW5kLT5yZXN1bHQgY2FuIHRyaWdnZXIgdGhl
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg==
