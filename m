Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC36E59A7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 08:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjDRGtD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDRGtA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 02:49:00 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848A6A78;
        Mon, 17 Apr 2023 23:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681800508; x=1713336508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xqHbZtCcbYtQY2ZPvtvQ3DRuUmIviuvvGnIV7LjEWq4=;
  b=svsgMF34BVKfCZUWGuS/XWTy97K1EKROi1WU8rVpt+xRzDa8F95nhnQr
   r98eavLSwh12qXhOfOH47CxMGt/dxWhFZcsVZarT2N5aJABNxF2OkQkAG
   44kmcQkLTkFhhggFoKA/X/B4cl2fbcRp70+c4ZH55gWEnBilFrlRtHxJB
   aUjBNqvRtCWmE/HQQD2jwGf1+GJIRReeX/k0WtxY3LEvR9ifvLcXy2ViK
   EoGtRkrCUUuG0M5KaQgusJchGg/1bbhlZDcPystaL4KeCZB2P3SMBi4JA
   DwGFN/4BgbOvxgbmHzuoScFRc3DoucN5jI+66ArML918ERfnUGzEfrJ9U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="82175708"
X-IronPort-AV: E=Sophos;i="5.99,206,1677510000"; 
   d="scan'208";a="82175708"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 15:47:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfarR/3gxvkYzruc7xmLAycb3lowwYpGwwTNYHUZhSE7Gp5pO76XDsKaCJjpy8IeE3/w3nJ5A0ZAfhTnulWmHNK9C/t3zhW6y8AaJc6vpKG8W3yRiZm8rfcnyibPUZDMQtI3xOryopEvbwXccudg5BJpNmAaD8nd7Yb+5JaWjKTj3RY4Ph07R7oEhc4Oc5WnuTojx9GXcytFKUoIaqdCo9Io4CalfAOMs43saWNk9TrrhKSbAJ6hTZz9dRAYAV8pxjdvHyPoZ3Wxa+7OggoX3vz2JgxmVaLBE3fE39ytQUyW3CXetmVBPiGH1HCXWv+iZ1Y8Dre/6DPsI/PZ4MpfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqHbZtCcbYtQY2ZPvtvQ3DRuUmIviuvvGnIV7LjEWq4=;
 b=Xzs5868gHGttWfRWDz2CjTn7gPOuQDLqCt2qnEyiHSMDLQrep0vFmicyKmabBYu+lXALbJ2vXs0SRX1ZHxcF5VL0YXyAhHss8ybDxGLbBFGpohDiF/sXyhULeeZnR6XzdEtOglR+F/FhXWMl0RsR6pPsT3sl5evvHlgsSC67wgR08S4sFJBjWOZJRfgK4PTTnsOD8qug0EjmyS7tcHCwSUwRs8MjmAzjGcWhfF2vLg3OeZPIOGixAHnwzgcwZBjeMZDnkY/Z2i3dROmMCEv6zkuno8/xrZfIb3p8j9JPj1Qy4WoJcvY8ZHhAG1UvGxor3V8O5/CyA1JcXTLFgnIHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TY3PR01MB11283.jpnprd01.prod.outlook.com
 (2603:1096:400:36e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 06:47:45 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 06:47:45 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>
CC:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgAFGcYCAACCfAIAAB46AgABElwCABEErgIABz6wA
Date:   Tue, 18 Apr 2023 06:47:45 +0000
Message-ID: <006f598e-c7cc-8240-78f9-1b393fde8ea6@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
 <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
 <bfa3317b-656f-9a3f-9564-4dbb1bbef3e3@linux.dev>
 <71935de6-e3c1-c719-4e66-19242af51ab7@fujitsu.com>
 <90bcf57d-3e2f-5fd5-a901-6a640d2b523c@linux.dev>
In-Reply-To: <90bcf57d-3e2f-5fd5-a901-6a640d2b523c@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TY3PR01MB11283:EE_
x-ms-office365-filtering-correlation-id: 633faf2b-bebc-4aa1-b76c-08db3fd8d0e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKtNeUoxpGx+2RqcZfgnqu7TCefrEyQhG2pdc0SfloeCEcEMT6A40Eii1tMjk01CyBc+q2+1zVjDdQ5wKmaUqLLnIoQyJnmCqe5ZxfMu3r6x5s9vFGXgxTGvGlLigdF589CxmeQ6UdmOe6zXI9IKalZg3ogudxecWUUti715SMTd5X7Da6rTQEYz0rCLwohNK8tLswXH6IBoIUlCYAxhIqnSxcMMa0EGuyADhcIOk2WygKmldNSMDEFtv+OopQ2GgKjJ/s1PvyNuU9s9An6FeDqCU9XYorkBv+HSv6USeOpOni2RnYXCUNecSG5EQ6KVFNBxEy9Lo6uA8TYaierL2euXYr8gbPBwCmHSnZmDwc6cW9kg0AhGuafQxQoQd1INXQoQ4Q/fULiLEdzD+Gjtex5DkReLGKAW0hO53SUpo4ghN0mmCXrdIjGHsDIHbB1QK+sXarHuqpAesbQq2pACgvh+gj03rHtzUv+jkYGrkPgLJXreC0F4Sz1neL30/K++VKrR5aFaA/gOPv6JJSTxfZ00iobgxR8cYY/HkdclnqYBv4N5oCAOIGR9zR8mGFBtG3/PktfcrRl9FC/O6iQpUbWPRVzXLfQ7hzxYVaCTw+7Elzs+geVzjnhMhVG7Y9JAuPjoW9Oyoflrx/ftkyOt0TVTZQst4VBeHaibhxJhXFV/+wjbYr/NdVK8AjoAMjuVBSUCLtMZlEZ5SI2KRi5JYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(1590799018)(451199021)(5660300002)(2616005)(31696002)(83380400001)(122000001)(86362001)(186003)(26005)(6512007)(53546011)(82960400001)(6506007)(38100700002)(38070700005)(8936002)(8676002)(110136005)(54906003)(478600001)(71200400001)(6486002)(85182001)(41300700001)(316002)(91956017)(36756003)(76116006)(66556008)(64756008)(66476007)(4326008)(66946007)(31686004)(66899021)(66446008)(1580799015)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZQWXMwYml6T3M0aml3SG9yOEIrU0tDaHE0c1pZQThBN1hLMHdXMFY2clpj?=
 =?utf-8?B?WWE3b3hhV0VQL1lGQy9SS2hIL25qQkt4UEV1NWIrWVI4a3ZybC9oRTE1WlR5?=
 =?utf-8?B?VHBnSVNkRWFYVk5nUzhBSlZORjQwSEI5cVRadDhwN2dZQzhqSHpRYjFXQURk?=
 =?utf-8?B?STdZVWIwZ3J6VG45WTd5cUxoVmVnTlV1YjlSdkdRT2d6UEMzRVp0OWJHTUNC?=
 =?utf-8?B?bVVQVGQ1Sk9MeXdvWDF1TkVnRFhZbURBd2hKdGtDK1VoM1Y5WmZRNUN0UUtq?=
 =?utf-8?B?alV1TlFPSkNBcDAydmhOaXc3RkFMeDV5MitxYkhPdXZJY2hWcy9aSDA3aE5X?=
 =?utf-8?B?bCtRRWlnUVdTYzJTbkdSaXFJVUpvcmRqZzRTRjdFTzlMKzlIOGdUWk1WbEdz?=
 =?utf-8?B?Rm1lZ2JnOFErRGpTclBFcG9hOWdVWUN5OVJNQUIva3BQd2JxUkR0NUVtc0RH?=
 =?utf-8?B?cUpNc1FTV2JXTURpYm9aZENkQmwvekxPZGdIWEZFTnJmRmp1d1FmREpISEhX?=
 =?utf-8?B?c094U3hYU0xPdGg1V2xyS2ZTRHYxS1djZXlkY0YyN2FxWDVMeG0yanQzSXVY?=
 =?utf-8?B?QmNKb0VNVTlCZnhrZDVQK2hoMFFVVkM4TUVmRExIRUVwcFUxOFBON29IZi9R?=
 =?utf-8?B?UXEzcER1N1lEd1Z4VjFWekVzRWpqQnh2Ykl4R2RIbE1WVHprSkg3Y1F5bTRn?=
 =?utf-8?B?cG9yVU1hMEM3UCt3a1R2Rnhzb0d6T1g1RENRWjFJTUZXTkZPWlNCaExQL1RX?=
 =?utf-8?B?VlN3Ym1DUDJoOFhQNlQ1WlN4cTJnMWh5L0xDUUxuQk10bkNHYTlCNDd5VWh3?=
 =?utf-8?B?THlLOVRuUmhzeVYvU2tvNDdWWk5aZUE2NnZ4Q0xoNXVMdWF0TkQ1NGhSdmx6?=
 =?utf-8?B?S2RpUHZzRFU1YU95czBmRjl5OEd0eG9wdDBpK0tTWFc3bUpIbTBOVnVVNmVk?=
 =?utf-8?B?ZGVJR2owcmRyRUMyRTdxVnNSTTMxMTN3Q1dHU2t4cU16cW9MdDJWbko2MGIy?=
 =?utf-8?B?TWxmQzJ3MEk3YjNTK2lrNnV4dDBaK0VDR0NXQ2VDako0L2dHQ1hic1lNN0Fz?=
 =?utf-8?B?UFR5QjMyMVN4ZWRaV29KeGp4THprZ2tBS1pIZUp0TFZEQ1NPREJLMVRJeWVj?=
 =?utf-8?B?M0ZUbEUxQlpvbWlBWWs3VTVJVXJVQXd6ZEZ0cnEyZU51K0V3NjRUOE5rYXpX?=
 =?utf-8?B?WXNFekcybjdTL1l6aTZGcElSZEVsVEVtTXZhbUJxOHQxaTl1cklQRmhKK3ln?=
 =?utf-8?B?ckVtUTVTRzJzQWVtMmM4OVVDejQ1QTNRcGZSSzFPS3JnMHJEaUhqT2x3cW1q?=
 =?utf-8?B?U3RUdThUMEFkRDZ5SWh0Uy9TbExSVzVUZ2MycnhmUDIxaWlaS1lraXpJUUwy?=
 =?utf-8?B?cytSSHNYM3hWUjNha3ZoY1pvYUlzUmRscDUwMW5LVlBOR3lRaGFXTW80cE4r?=
 =?utf-8?B?ZXdYa1MweXMva2ZWOE9WeDlwZUJoT3lRck04aXZmS2NPaFJIekQyT2o1TVkz?=
 =?utf-8?B?cS9RTnZUR0tDSHQvbTFkMmVZbG91NFBWYlMvSTlHdmYwSFNFNnA2cnI0NVJR?=
 =?utf-8?B?aVdUYk1xaDRCbUhGWWZwTkJyNTJOZjBwUHBRVGtKem8yZ245QmlkaVNRc3o2?=
 =?utf-8?B?M2pnVVlocFpaV2VUeXFENmVINlRBRVpXak8ySXlWaDRrUGRNclBEK1pHN2cw?=
 =?utf-8?B?QUFmTzFMa1Y3d2E5S0RaZkxjcEtld0tZY0d3TWROYlVVNHpoRTJyemRBTnpy?=
 =?utf-8?B?aDNNbit6SWZBVGxQeVhNZENrSE11T0FIRWxEWUNOa2UzYXM5QWtFN2NLWU5R?=
 =?utf-8?B?NWUyczQ2OXVrRXQwVHBsckRaWW5nUWIxa1RtelgrcTZvS2hVS2dLTXNYTi9w?=
 =?utf-8?B?SVF2ZHpUNUg3TjNqOUxtWnlBN29UbzFCY2FJeXdGTnljZS91ckNLa2xLbWNn?=
 =?utf-8?B?YlZYMGpoZElTVUtRQmMzeGJqcjBvbFJncmNUb1pDQ2w4NkNmbUkzZ2VHVUxR?=
 =?utf-8?B?dVBveHV5a0pFZlpQaFVISkUyM2RpbWVLeVJYQklSbktaMnBlQzY2VGl1bDZ5?=
 =?utf-8?B?T1hLVGRKaVBiTGF3SkxjdEM3YlZnUU04NXVxYnMyL2REcHpESmFkVWVDUFRX?=
 =?utf-8?B?d2pqVFlQbk1jV3M0U3NEaVRNeVQzR2FQVkJUMFBpV3dPR1pEcTVubWtmVFpm?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F42B74F90D726A4C811C59C874A34BA7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T7O1h9LpiWgVSg/giVrU3Gmm9PPYMp+4Hhnb6sr2zO3yj+NodwXOFgeljFORMUo10OK1xDhjgkuVmET+GmuHnpJ+woxHid/qY0MJbplTaQ5cGFB54v9WP9EEfr50F51EZAqTR7ZSxSN0zV2VY6mC/E4NgYQGsy2vYaL4Jk83uyXjAH4BQCgJXRhTeVTUFwGcvWQjtHmFClwZudKUXxe1N3GnHsGzlWKRSAiii7PJ6A7aTXYYWvtmPGcqUeoZmxeo7J3eFNN1Z3FvcVHGRUBH34FXAyJt68D8HuN57VjCxb0Gc2p7TEoj7R2osMG0H1p2p7Y5k44iEeCBn6h18JhuTpFNm0jNUwyVK4ThuZikdN3Pn1Ozvg4BwNxxgCprv2qNPDnBQuBP7muTC+JRaniwiSNVne/WiPbmLx8yoTf2WGUOI6DZo0Rn2QtgRsp5CcPEGhkoBPVgAyuykMhnSsrWU4H6Ydaqd3eD5jl0fr/EnrIUpc0Jzm77z5s16v6St8t+JdljmjVMZjR5WZuRp+SoCjUtBn0zoXyxVGyNQNAShQ/1yxtz1n+NTf0vf15hwtdXvDbniIN6mSuZLJ6UMs2AyHPY1ZlZH8BAYdb3do6p/R9R4yOrjc4q+m6qoShlCqb2Q3iiEop69m5OiA8DQMlrA/QeU7wKqF58u6wMAuAev043J+FaLM86FDaifrgLXK3n/jnDXlVc/A3S48AqVwjkvcAH1oshWCJPv5TiKXn0e5I/X958Fl58nm5SlqSNyA3lq2sq4H4DISotCQkSdXhoZdSzssQCLM/QRth6vsRHuhHnDyrdkzgfmjSGKrAt7uo2TvtTojziV3FlAGXTSzF8whJXDhd97Pqg7TitUQyhis4Us4hggJAMJUugQu+7alRp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633faf2b-bebc-4aa1-b76c-08db3fd8d0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 06:47:45.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMizCVA1/KXfp1suu1AY0awM79QPx3UIwfvmlhvuwVeEJ+mfpOQIPGmu55oiriPbbu3OVHy2TI3OCH8MYiBIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11283
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE3LzA0LzIwMjMgMTE6MDgsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gNC8xNC8yMyAxODowOSwgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4gT24g
MTQvMDQvMjAyMyAxNDowNCwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4+Pg0KPj4+IE9uIDQvMTQv
MjMgMTM6MzcsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+PiBPbiAxNC8wNC8yMDIz
IDExOjQwLCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPj4+Pj4gT24gNC8xMy8yMyAxNjoxMiwgWmhp
amlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pj4+Pj4gT24gMTMvMDQvMjAyMyAxNTozNSwgR3Vv
cWluZyBKaWFuZyB3cm90ZToNCj4+Pj4+Pj4gSGksDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkgdGFrZSBh
IGNsb3NlciBsb29rIHRvZGF5Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiA0LzEyLzIzIDA5OjE1LCBa
aGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+Pj4+IE9uIDExLzA0LzIwMjMgMjA6MjYs
IExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBUdWUsIEFwciAxMSwgMjAyMyBh
dCAwMjo0Mzo0NkFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+Pj4+
Pj4gT24gMTAvMDQvMjAyMyAyMToxMCwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4+Pj4+Pj4+Pj4+
IE9uIDQvMTAvMjMgMjA6MDgsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+Pj4+Pj4+Pj4+PiBP
biBNb24sIEFwciAxMCwgMjAyMyBhdCAwNjo0MzowM0FNICswMDAwLCBMaSBaaGlqaWFuIHdyb3Rl
Og0KPj4+Pj4+Pj4+Pj4+PiBUaGUgd2FybmluZyBvY2N1cnMgd2hlbiBkZXN0cm95aW5nIFBEIHdo
b3NlIHJlZmVyZW5jZSBjb3VudCBpcyBub3QgemVyby4NCj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4+Pj4gUHJlY29kaXRpb246IGNsdF9wYXRoLT5zLmNvbl9udW0gaXMgMi4NCj4+Pj4+Pj4+Pj4+
Pj4gU28gMiBjbSBjb25uZWN0aW9uIHdpbGwgYmUgY3JlYXRlZCBhcyBiZWxvdzoNCj4+Pj4+Pj4+
Pj4+Pj4gQ1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFUxDQo+Pj4+Pj4+
Pj4+Pj4+IGluaXRfY29ubnMge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCDCoMKgIGNyZWF0
ZV9jbSgpIC8vIGEuIGNvblswXSBjcmVhdGVkwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+Pj4+
PiDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIGEnLiBydHJzX2NsdF9y
ZG1hX2NtX2hhbmRsZXIoKSB7DQo+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoMKgIHJ0cnNfcmRtYV9hZGRyX3Jlc29sdmVkKCkNCj4+Pj4+Pj4+
Pj4+Pj4gwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIGNy
ZWF0ZV9jb25fY3FfcXAoY29uKTsgPDwgY29uWzBdDQo+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgfQ0KPj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBpbiB0aGlzIG1vbWVudCwgcmVmY250IG9mIFBE
IHdhcyBpbmNyZWFzZWQgdG8gMisNCj4+Pj4+Pj4gV2hhdCBkbyB5b3UgbWVhbiAicmVmY250IG9m
IFBEIj8gdXNlY250IGluIHN0cnVjdCBpYl9wZCBvciBkZXZfcmVmLg0KPj4+Pj4+IEkgbWVhbiB1
c2VjbnQgaW4gc3RydWN0IGliX3BkDQo+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgwqDCoCBj
cmVhdGVfY20oKSAvLyBiLiBjaWQgPSAxLCBmYWlsZWTCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+
Pj4+PiDCoMKgwqDCoCDCoMKgwqDCoCBkZXN0cm95X2Nvbl9jcV9xcCgpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgwqDCoMKgwqDC
oMKgIHJ0cnNfaWJfZGV2X3B1dCgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwNCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZnJlZSgpwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4+
Pj4+IMKgwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGliX2RlYWxsb2NfcGQoZGV2LT5pYl9w
ZCkgPDwgUEQgfA0KPj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlzIGRlc3Ryb3llZCwgYnV0IHJlZmNudCBpc8KgwqDCoCB8DQo+Pj4+Pj4+Pj4+Pj4+IMKgwqDC
oMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RpbGwgZ3JlYXRlciB0aGFuIDDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8DQo+Pj4+Pj4+IEFzc3VtaW5nIHlvdSBtZWFuICJwZC0+dXNlY250Ii4gV2Ug
b25seSBhbGxvY2F0ZSBwZCBpbiBjb25bMF0gYnkgcnRyc19pYl9kZXZfZmluZF9vcl9hZGQsDQo+
Pj4+Pj4+IGlmIGNvblsxXSBmYWlsZWQgdG8gY3JlYXRlIGNtLCB0aGVuIGFsbG9jX3BhdGhfcmVx
cyAtPiBpYl9hbGxvY19tciAtPiBhdG9taWNfaW5jKCZwZC0+dXNlY250KQ0KPj4+Pj4gVGhlIGFi
b3ZlIGNhbid0IGJlIGludm9rZWQsIHJpZ2h0Pw0KPj4+Pj4NCj4+Pj4+Pj4gY2FuJ3QgYmUgdHJp
Z2dlcmVkLiBJcyB0aGVyZSBvdGhlciBwbGFjZXMgY291bGQgaW5jcmVhc2UgdGhlIHJlZmNudD8N
Cj4+Pj4+PiBZZXMsIHdoZW4gY3JlYXRlIGEgcXAsIGl0IHdpbGwgYWxzbyBhc3NvY2lhdGUgdG8g
dGhpcyBQRCwgdGhhdCBhbHNvIG1lYW4gcmVmY250IG9mIFBEIHdpbGwgYmUgaW5jcmVhc2VkLg0K
Pj4+Pj4+DQo+Pj4+Pj4gV2hlbiBjb25bMF0oY3JlYXRlX2Nvbl9jcV9xcCkgc3VjY2VlZGVkLCBy
ZWZjbnQgb2YgUEQgd2lsbCBiZSAyLiBhbmQgdGhlbiB3aGVuIGNvblsxXSBmYWlsZWQsIHNpbmNl
DQo+Pj4+Pj4gUVAgZGlkbid0IGNyZWF0ZSwgcmVmY250IG9mIFBEIGlzIHN0aWxsIDIuIGNvblsx
XSdzIGNsZWFudXAgd2lsbCBkZXN0cm95IHRoZSBQRChpYl9kZWFsbG9jX3BkKSBzaW5jZSBkZXZf
cmVmID0gMSwgYWZ0ZXIgdGhhdCBpdHMNCj4+Pj4+PiByZWZjbnQgaXMgc3RpbGwgMS4NCj4+Pj4+
IEkgY2FuIHNlZSB0aGUgcGF0aCBpbmNyZWFzZSB1c2VjbnQgdG8gMS4NCj4+Pj4+DQo+Pj4+PiBy
dHJzX2NxX3FwX2NyZWF0ZSAtPiBjcmVhdGVfcXANCj4+Pj4+IMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCAtPiByZG1hX2NyZWF0ZV9xcA0KPj4+Pj4gwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAtPiBpYl9jcmVhdGVfcXANCj4+Pj4+
IMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIC0+
IGNyZWF0ZV9xcA0KPj4+Pj4gwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgLT4gaWJfcXBfdXNlY250X2luYyB3aGljaCBpbmNyZWFzZXMgcGQtPnVz
ZWNudA0KPj4+Pj4NCj4+Pj4+IFdoZXJlIGlzIGFub3RoZXIgcGxhY2UgdG8gaW5jcmVhc2UgdXNl
Y250IHRvIDI/DQo+Pj4+IEl0IHNob3VsZCBiZQ0KPj4+PiBpYl9jcmVhdGVfcXDjgIAuLi4NCj4+
Pj4gwqDCoMKgwqAgLT4gcnhlX2NyZWF0ZV9xcA0KPj4+PiDCoMKgwqDCoMKgwqAgLT4gcnhlX3Fw
X2Zyb21faW5pdA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLT4gcnhlX2dldChwZCkgPDw8IHBk
J3MgcmVmY250IHdpbGwgYmUgaW5jcmVhc2VkLg0KPj4+IElzbid0IHJ4ZV9nZXQganVzdCBpbmNy
ZWFzZSBlbGVtLT5yZWZfY250Pw0KPj4gWWVzLCB0aGF0J3MgdHJ1ZS4NCj4gDQo+IEkgYW0gY29u
ZnVzZWQsIGRvZXMgaW5jcmVhc2UgcmVmX2NudCBlcXVhbCB0byBpbmNyZWFzZSB1c2VjbnQ/DQoN
Cg0KSSBuZWVkIHRvIGFwb2xvZ2l6ZSBmb3IgbXkgbWlzdGFrZS4gSSBoYXZlIGJlZW4gcmVmZXJy
aW5nIHRvIHRoZSBlbGVtLnJlZl9jbnQgb2YgdGhlIHJ4ZSBkcml2ZXIgYXMgdGhlIHJlZmNudCBv
ZiBQRC4NCg0KDQo+IElmIG5vdCwgdGhlbiB3aGVyZSBpcyBhbm90aGVyIHBsYWNlIHRvIGluY3Jl
YXNlIHVzZWNudCB0byAyPw0KPiANCj4gQlRXLCBJIHRyYWNlZCB3aXRoIDYuMy1yYzUsIHNlZW1z
IHBkJ3MgdXNlY250IGlzIG9ubHkgaW5jcmVhc2Ugb25jZQ0KPiBhZnRlciBjcmVhdGUgb25lIGNv
bm5lY3Rpb24uDQoNCkFuZCB0aGUgd2FybmluZyBtZW50aW9uZWQgYWJvdmUgaXQgYWxzbyBwb2lu
dGVkIHRvIHRoZSBQRCdzIGVsZW0ucmVmX2NudC4NCg0KPiANCj4gWyA2OTQxLjUyNTA4OF0gaW4g
aW5pdF9jb25ucyAyMzUzIGNvbl9udW09Mw0KPiBbIDY5NDEuNTI1NzMyXSBpbiBjcmVhdGVfY29u
X2NxX3FwIDE2NDgNCj4gWyA2OTQxLjUyNTk0NF0gaW4gcnRyc19jcV9xcF9jcmVhdGUgMzExIGNv
bi0+Y2lkPTAgcGF0aC0+ZGV2LT5pYl9wZC0+dXNlY250PTENCj4gWyA2OTQxLjUzMjQ2MF0gaW4g
Y3JlYXRlX2Nvbl9jcV9xcCAxNjQ4DQo+IFsgNjk0MS41MzI3NDZdIGluIHJ0cnNfY3FfcXBfY3Jl
YXRlIDMxMSBjb24tPmNpZD0xIHBhdGgtPmRldi0+aWJfcGQtPnVzZWNudD0yDQo+IFsgNjk0MS41
MzMxODNdIGluIGNyZWF0ZV9jb25fY3FfcXAgMTY0OA0KPiBbIDY5NDEuNTMzNDY0XSBpbiBydHJz
X2NxX3FwX2NyZWF0ZSAzMTEgY29uLT5jaWQ9MiBwYXRoLT5kZXYtPmliX3BkLT51c2VjbnQ9Mw0K
PiBbIDY5NDEuNTMzNjg1XSBpbiBpbml0X2Nvbm5zIDIzNjUsIGNsdF9wYXRoLT5zLmRldi0+aWJf
cGQtPnVzZWNudD0zDQo+IFsgNjk0MS41MzU2ODBdIGluIGluaXRfY29ubnMgMjM3MSwgY2x0X3Bh
dGgtPnMuZGV2LT5pYl9wZC0+dXNlY250PTUxNQ0KDQpUaGFua3MNClpoaWppYW4NCg0KYmVsb3cg
aXMgYSBwaWVjZSBvZiBjb2RlIHRoYXQgaSB1c2VkIHRvIGRlYnVnIHRoaXMgaXNzdWUuDQoNCi0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQorKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYw0KQEAgLTE3MzAsMTUgKzE3MzAsMzkgQEAg
c3RhdGljIGludCBjcmVhdGVfY29uX2NxX3FwKHN0cnVjdCBydHJzX2NsdF9jb24gKmNvbikNCiAg
ICAgICAgIHJldHVybiBlcnI7DQogIH0NCiAgDQorc3RydWN0IHJ4ZV9wb29sOw0KK3N0cnVjdCBy
eGVfcG9vbF9lbGVtIHsNCisgICAgICAgc3RydWN0IHJ4ZV9wb29sICAgICAgICAgKnBvb2w7DQor
ICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICpvYmo7DQorICAgICAgIHN0cnVjdCBrcmVm
ICAgICAgICAgICAgIHJlZl9jbnQ7DQorICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgICAgICAgIGxp
c3Q7DQorICAgICAgIHN0cnVjdCBjb21wbGV0aW9uICAgICAgIGNvbXBsZXRlOw0KKyAgICAgICB1
MzIgICAgICAgICAgICAgICAgICAgICBpbmRleDsNCit9Ow0KKw0KK3N0cnVjdCByeGVfcGQgew0K
KyAgICAgICBzdHJ1Y3QgaWJfcGQgICAgICAgICAgICBpYnBkOw0KKyAgICAgICBzdHJ1Y3Qgcnhl
X3Bvb2xfZWxlbSAgICBlbGVtOw0KK307DQorDQorc3RhdGljIGlubGluZSBzdHJ1Y3QgcnhlX3Bk
ICp0b19ycGQoc3RydWN0IGliX3BkICpwZCkNCit7DQorICAgICAgIHJldHVybiBwZCA/IGNvbnRh
aW5lcl9vZihwZCwgc3RydWN0IHJ4ZV9wZCwgaWJwZCkgOiBOVUxMOw0KK30NCisNCisjZGVmaW5l
IHJ4ZV9yZWFkKG9iaikga3JlZl9yZWFkKCYob2JqKS0+ZWxlbS5yZWZfY250KQ0KICBzdGF0aWMg
dm9pZCBkZXN0cm95X2Nvbl9jcV9xcChzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQogIHsNCiAg
ICAgICAgIHN0cnVjdCBydHJzX2NsdF9wYXRoICpjbHRfcGF0aCA9IHRvX2NsdF9wYXRoKGNvbi0+
Yy5wYXRoKTsNCisgICAgICAgc3RydWN0IHJ0cnNfaWJfZGV2ICpkZXYgPSBjbHRfcGF0aC0+cy5k
ZXY7DQorICAgICAgIHN0cnVjdCByeGVfcGQgKnBkID0gdG9fcnBkKGRldi0+aWJfcGQpOw0KICAN
CiAgICAgICAgIC8qDQogICAgICAgICAgKiBCZSBjYXJlZnVsIGhlcmU6IGRlc3Ryb3lfY29uX2Nx
X3FwKCkgY2FuIGJlIGNhbGxlZCBldmVuDQogICAgICAgICAgKiBjcmVhdGVfY29uX2NxX3FwKCkg
ZmFpbGVkLCBzZWUgY29tbWVudHMgdGhlcmUuDQogICAgICAgICAgKi8NCiAgICAgICAgIGxvY2tk
ZXBfYXNzZXJ0X2hlbGQoJmNvbi0+Y29uX211dGV4KTsNCisgICAgICAgcnRyc19pbmZvKGNsdF9w
YXRoLT5jbHQsICIlczogY2x0X3BhdGgtPnMuZGV2X3JlZjogJWQsIHBkICVweCwgcmVmOiAlZFxu
IiwgX19mdW5jX18sIGNsdF9wYXRoLT5zLmRldl9yZWYsICZwZC0+ZWxlbSwgcnhlX3JlYWQocGQp
KTsNCiAgICAgICAgIHJ0cnNfY3FfcXBfZGVzdHJveSgmY29uLT5jKTsNCiAgICAgICAgIGlmIChj
b24tPnJzcF9pdXMpIHsNCiAgICAgICAgICAgICAgICAgcnRyc19pdV9mcmVlKGNvbi0+cnNwX2l1
cywgY2x0X3BhdGgtPnMuZGV2LT5pYl9kZXYsDQpAQCAtMTc0Niw3ICsxNzcwLDggQEAgc3RhdGlj
IHZvaWQgZGVzdHJveV9jb25fY3FfcXAoc3RydWN0IHJ0cnNfY2x0X2NvbiAqY29uKQ0KICAgICAg
ICAgICAgICAgICBjb24tPnJzcF9pdXMgPSBOVUxMOw0KICAgICAgICAgICAgICAgICBjb24tPnF1
ZXVlX251bSA9IDA7DQogICAgICAgICB9DQorICAgICAgIHJ0cnNfaW5mbyhjbHRfcGF0aC0+Y2x0
LCAiJXM6IGNsdF9wYXRoLT5zLmRldl9yZWY6ICVkLCBwZCAlcHgsIHJlZjogJWRcbiIsIF9fZnVu
Y19fLCBjbHRfcGF0aC0+cy5kZXZfcmVmLCAmcGQtPmVsZW0sIHJ4ZV9yZWFkKHBkKSk7DQogICAg
ICAgICBpZiAoY2x0X3BhdGgtPnMuZGV2X3JlZiAmJiAhLS1jbHRfcGF0aC0+cy5kZXZfcmVmKSB7
DQogICAgICAgICAgICAgICAgIHJ0cnNfaWJfZGV2X3B1dChjbHRfcGF0aC0+cy5kZXYpOw0KICAg
ICAgICAgICAgICAgICBjbHRfcGF0aC0+cy5kZXYgPSBOVUxMOw0KDQoNCg0KPiANCj4gVGhhbmtz
LA0KPiBHdW9xaW5n
