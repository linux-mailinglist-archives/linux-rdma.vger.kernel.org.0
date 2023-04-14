Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987956E1BCF
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDNFih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNFig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 01:38:36 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 22:38:34 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B47271E
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681450714; x=1712986714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HJNSE00I9uMXVBjzZql7/+XXklpGVdnBEWJXxZauH/g=;
  b=iM5aBW0grvCn208YoqNp0e/MoZLFk4hBsvRKOhVrLpTYWYuoqvrOgFC+
   3mYJBZ7KSSe8kF273xkiviNrWkCzGmflAQF3ZuX3AUIifGeX92Rc0z2IV
   nHA6OU62pkalqktctSr2a36IDFMqaPthMKtefgzxGuqeGUxDFHbpAXmz7
   SCtaAnK9BT7k27vnwQWD17I4swTg35VHelA4fjd/isbDoI8AOabQT7sL3
   mi91/4ktKSzsja258hf4VFd9VtwQCu5X3Xju4zjcovaPAwi3WoiYZvqup
   wmCPHe7rr01d+Xoo+Lo6BCFKjvwitsrhvHPpv03UFmjaMg+1Mt2R7Ixyn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="90088570"
X-IronPort-AV: E=Sophos;i="5.99,195,1677510000"; 
   d="scan'208";a="90088570"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:37:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARfhzTWlG7JOv/QR/qaigZFszD1BzVL+cBt71M/Je1v0jNp0ZUX74pkOZj/z4/eEHUzMvCvPv4TGzXOTSiw7Fa0STewcoN64NIty3oBzSxGw74rC69VFf5swxg4T1D11yLuhpgm9Q5kRqkz5I6P485GxOpo9ac1O5snboKYqTCeSbcaqJ0oOxL9BQzrJ6qUob55CcP0roAXUex5mdIK1LTOYwIsjLSg3cvunU2XkhJYU78B2EfH8kcuq3nuMovVSporv8I7hwfCiMN27K1xYH0W9jyLUY/4QElVlZo3cEm02Rif3GSu65NI1d9XEIih0xJOE6OQKppiK5zwGMRJngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJNSE00I9uMXVBjzZql7/+XXklpGVdnBEWJXxZauH/g=;
 b=H8bBNgdt4fx4G0EYirOR8W9cXweHDQ38HJRNMfeqj1wU2i7om72mB+RKuoGUEv2iqaNsSD+UR2N6ZtFQSIE/EGfIMVxUJM9QBqE5h7vSy0NHsgSeivL5usYflYceVvzs0I3ri+mquZyGIahRWzQVzWiJ04ZbGgIvBrtf3Q95SofKLMV5ZYbQbjLuttVLahstN0a56Z9RKe6xUV8v8/VBtP+HhpOY73zfbSj1TVnpdgt2cp1/OTDMv1v12WwOce9Cgfbwq7h41WrkuSsSaGrMUoGfLXw/KKFteDlJyD3fusRhPmEhyxRa+SDJQkjA2Aeno2ys/pxUMKp8I/wJvbMq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 (2603:1096:400:38c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 05:37:23 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 05:37:23 +0000
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
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgAFGcYCAACCfAA==
Date:   Fri, 14 Apr 2023 05:37:23 +0000
Message-ID: <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
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
In-Reply-To: <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYCPR01MB11865:EE_
x-ms-office365-filtering-correlation-id: 134e788d-b6c5-47a0-bc28-08db3caa5295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9V109z05Jdx43/NudLMPRho4qH/NEmY6pCn410JHRZCTUJHAqqZgYv4rZJCF32jYjM4zGIkeO80wrFy7Ml8CKMb91vXlQYYS4OzsvCok5FnmUfJ8cex+I6vnilIDxvIZZZKLq61Pw/68MTe8AY1Va6s2qwi7qlnS26pYwZx/FwSsLw9eDRKpw5uHtuFPFqGFzWAdYTH02JwwGbRUU4dr+pPEFv90zWjtHtqrlTua8cFbWRBC8CBv7gvFYJK4rThtL+mAcdx2jky6GtJtmgf4gnoodwke0b5adM4ZTm5A317xdMalXn9Mb/Ry0PV3g1kg4o2/9sgbA6t6+RM4s+W2XOMQGU4OsLQoh3sh+ZGUYFRIvUwFeEA7pekh6qF6CzdMcylDgezb1jksjcq9BP39E5tuGo6rqG5s/twAr8KtvgimZRl3un5joZVRGldbbVnIgb6pQtxzDUB1R+sMtqsi/4s09sE2foetWbm9dad2pkQZxOSyXN1PRij6ElLrN181CsjEOUesisz/w0mO7owwHIO7bKYoO9f1q/qLLrD5SGjDUBdoXdNms2k6nesCZ2Ok8aEW/WAHz6k78wmXYVFYCToYj3H4bnRtZ1qYpHWqPYSAOLnN6Etz65EIuy4JlpIuGIRc6utDZAUR+ALK1W2/3kwq0fFdczzrhYhqCxEi3rC+tjFz6972tAYEZwEYcjYpXZJ9x3uAc+5Uqj7YG8C3dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(1590799018)(5660300002)(122000001)(2906002)(8676002)(1580799015)(8936002)(66899021)(41300700001)(31686004)(316002)(4326008)(83380400001)(91956017)(64756008)(66446008)(76116006)(66556008)(66476007)(66946007)(71200400001)(38100700002)(86362001)(110136005)(478600001)(6486002)(38070700005)(31696002)(6506007)(6512007)(53546011)(36756003)(186003)(85182001)(54906003)(2616005)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzR4VWVwU211aXFaem9WYU1pelRoZzB5a1E1eGxtOXRDNGtIRFNwTmJ4YXBn?=
 =?utf-8?B?NlVIcDNJY2wwU1JTM2ZxVk5yWm5iVmcrbmZPcEhmRDJsbS9uVUt5WjY3SUdJ?=
 =?utf-8?B?Z3VmeXJpV241aXZJeGY4K0xzQisxTXZUa1ZlY3VSZVlGWXJzNm8vMXVoSzgx?=
 =?utf-8?B?Zndmb2h1NUVqZ1Q0VVI0NzA4WGVkb05aRnh2R2N2RmdNNU1xWWhjTzdlVXRI?=
 =?utf-8?B?M2VrWk5YcXlRaVRZUlM0NlZEVW94dERCN1lPTkVEWnNwZmhycitWbjEvT1NW?=
 =?utf-8?B?bnY3cGNsK05UdW12T1BmVEtDcXlWMnhrRExtMnkwaDZYbFpLeVFTZUNCYlpV?=
 =?utf-8?B?T3A0aEpyN0poQWFSR2RueHhwek1uVWhkSjJSMWhQRGkyUlVEdFpTVE5vRjdo?=
 =?utf-8?B?WnpBUEpuanBIemJOM20zQS8wNXBiY0NIU0FrSlNPQjlkQitoalJLbDBrNENZ?=
 =?utf-8?B?cFlPNkt6UENxN0xFWDlISG5sejE3VTUrNnlmbE1iMW95d0kwTXFHYkFMN0Qx?=
 =?utf-8?B?VDltbnJ5L0wveHdCNG1FbzRJTDIxUytEays5OEJVVzY1Yk1UUWw5dzd4QU5X?=
 =?utf-8?B?dldIN3haZG4zbnB1RitoTTU3b1NZQXQ5eVBRUFZWMEI1RnV3YjVJZm01T1hU?=
 =?utf-8?B?STVsNXlxM2lVRzNBcWJkRzNtNnBxMkd2bi81anZSV0p0UHZXd29CQWQ5WTFL?=
 =?utf-8?B?ODkzOFowVnBWa3dUYm5JOUtKRUIxNmdreTlLMWloOE1CM2VpWEl4Z29tc2NN?=
 =?utf-8?B?UGgrWW9MVWk0NTFsNlBEbnhIOTZoNlcrMUxIWVJrRFdyZjA5Qm5iMjk2aEt4?=
 =?utf-8?B?OVp6dEptdTJqaG90QjNaMmR4T1NISVdDWlJLaEdZVkdQZEVjMFNnZDRmRVhG?=
 =?utf-8?B?MDh4ZWdHSHhYWGVUeUozc2l2Ti9jRUdZb01vOEtadGVsZ3FzNVUwU2tqZnM0?=
 =?utf-8?B?U0JROUU0amU3Sm9WVEl5R0VpcUJpTDl4emgyV2M3OUtGOWFGWGVtY3VoQkcy?=
 =?utf-8?B?djFiMUZ3K0J4dlVNMjR4dngzZklwM3RMZFhIUGVyQmZhNEJLbVhXck5sNm1K?=
 =?utf-8?B?QjBLalBZdnVmWjZWNmZ1bksveHVEb0F4RGxZRXlEc1FkRWMzODVwYWpyRmpu?=
 =?utf-8?B?ZHVHM2xITTJ2NWxzeFZXZ2ZXeU5VZDVTcGZpMzRpdTduSzdrQ2F3VjVOWXZR?=
 =?utf-8?B?bk1FSll3Z0l0MDNZNUNPbVhjb3EvZDZsMnpQRmwvN0wySDJVNlQ3RmZkckRU?=
 =?utf-8?B?cmFTOEFGK2JjMTVDL0hzMlJGOGhneW5Gb0Y1d284ZTNwWUZhTE9ISVJ4dVU3?=
 =?utf-8?B?S21kZmNqNEdWVzliL2pybFZnTFp4RnIxNlFmb1Ridk5PMC9kTzQyZXJQandz?=
 =?utf-8?B?RlBVaHR5by9WWVp4Tmdqd25zN0RJVjBna0tNQ0lLNU0yR1p2akVQTlpldnZP?=
 =?utf-8?B?amZxSGNrdHZDYW10clUvdU91RmFvSUNGaUdLaUVtMWpYU3loTWlDbURCMEIx?=
 =?utf-8?B?NS9RMnhWMVVQSkdWUDZPNy94eE05UDBXNVhiUlUzV1Vab3VQYUFJbkVPVThz?=
 =?utf-8?B?LzVWT2FrMTJFZ3BvNWhWTFYvcDFURkozYjZtbzFSeHJ4dzMyNFFNVk44RkVF?=
 =?utf-8?B?RW1sSUxZbWN3K1FGanI5enVqMlhnbk9EaDJNS3VZdm9SK0VCNlRNNlhsYXlP?=
 =?utf-8?B?dEtHMjVPT1BZamVzWkJJMUdORDFvNzN5aVJlRlNaV2pVUzVxMW5CVEgzU0xq?=
 =?utf-8?B?ZDEydmMvcXc2cmNCNWRmYTVPbEgzekswUThrWENpNVVtVkpSeFRrOVBnSWI5?=
 =?utf-8?B?RUNSS1FwOHFKU3RCcWdXWkJoYTJTUkwzVTlja1g0S3NBYzhaVmwzWS80U3dT?=
 =?utf-8?B?RDJNYzNlNzJlSVlXMHB3SXZ5eG53QXcra28xOThjSnJFNkRXb0RKK2JTbTg3?=
 =?utf-8?B?QlRKcmtaK3M1VXN1UW1HcGpYV01ES1ZDc1h0cUdXNEtjMzRiSk1YL1dEZXB1?=
 =?utf-8?B?clNXMUEvaGRtSkcvdkdLeFZkUzlocnBEOFJPaTlyemJtMEdROHNlb0loc2gx?=
 =?utf-8?B?aFkyVWVtMzVlS0xNTUhOeGo5YWlLVlh1SEgwSXpCbDJodWk3VndZM3kranQv?=
 =?utf-8?B?Y1QxOCt4YlVjcDJuY2ZPVkZuR2lmV2FMNkx2aDI1VFB4TEhFOVB1VW9ScWFP?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC4309B58EF55489B6214CBE4CDA83A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eI1uUaQbb+Ne3ZwJRfjxNWn4NzgAcFNGFpR9dPItxOP2gC1zumzxk1GNlCP1wBEs49JmtLddNPo+wlTOsxqYjRx63v47XGDWTfbzDwjcOrCI59xDOk04W2cOBmNMkGgqQ5Yq/iy2T/6hiPHt5CzYNNxr49XUvPPE1cdz1WQp7n1fJTG5b9+IWNMg/nLYKQn+kHeOwz3ubxLOtD0kFv0FySDnl4J36duBIxnaKOkogs2+EQXrh6nQF2aEP7ZNMYAoZitxcE2T7DJohE3DrkcDhcaSfSRqKAZA8kwlFPMsNyJahVSG1bNNmhndWbe6jdvDttytrTGeFPG1xd2rD+2w8q5bBeLwpEtIWnq9V2vLgWZh6+UfA1t0ny7Ic5PuEeHWyGp0ZXcNLMSblLGDMDH/vgoy9HM235PYirP9fJk4W9eEB2nnl594z2vTpxy1fYO89DCmE0yp+QqmVEI0qijpYW65oG0Ovy3wmQwL2qMqxqbMoWB341oPo7nmPM0EdcAdifGwuGMkGDWTnZNr3AJmnGu+aOda97olSxJ9cgmsv0H9X4oZnRd4XHzRSgh5QUaOpBeMizWjC+UCK4wtvGysqKUGOpWnC2Uz8FfwOPBxgV5IsanE3Ant1gKQ/tnRT6pbFjGP1GEIVOl53VAd9gNJj5i/UdP8qYvaxzMtsaEe+mEZ0gJQWHqwChf5J7fgpFESTWxiBLe6TekyIXNUIqK2Iu6dfB5Uf3CDclwDJoAIHlO516NWqZmiIwKbCGn2BU9eW7zj4Xwme+3Bbnecq6pfI9zNlTpHhUDEmzCblh5FmaZ7QzfcL5Sm5tYjt4ArFqIv0GRQMC1PgqvD/z5uAd6Y3CRcbA95iylsdBMjRTocfze99XeoGbGT3tBNCcNDRTyV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e788d-b6c5-47a0-bc28-08db3caa5295
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 05:37:23.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sKeB0f3Xe2/RP7nGTy6Di983k29PKFusl/dCqB9Ecwu8CvusFE6NrTTZAnhAEeh/UdRsIRSfkK/mCxQEJCjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11865
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzA0LzIwMjMgMTE6NDAsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gNC8xMy8yMyAxNjoxMiwgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+PiBPbiAxMy8w
NC8yMDIzIDE1OjM1LCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gSSB0
YWtlIGEgY2xvc2VyIGxvb2sgdG9kYXkuDQo+Pj4NCj4+PiBPbiA0LzEyLzIzIDA5OjE1LCBaaGlq
aWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4gT24gMTEvMDQvMjAyMyAyMDoyNiwgTGVvbiBS
b21hbm92c2t5IHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDI6NDM6NDZB
TSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pj4+Pj4gT24gMTAvMDQvMjAy
MyAyMToxMCwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4+Pj4+Pj4gT24gNC8xMC8yMyAyMDowOCwg
TGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+Pj4+Pj4gT24gTW9uLCBBcHIgMTAsIDIwMjMgYXQg
MDY6NDM6MDNBTSArMDAwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4+Pj4+PiBUaGUgd2Fybmlu
ZyBvY2N1cnMgd2hlbiBkZXN0cm95aW5nIFBEIHdob3NlIHJlZmVyZW5jZSBjb3VudCBpcyBub3Qg
emVyby4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFByZWNvZGl0aW9uOiBjbHRfcGF0aC0+cy5jb25f
bnVtIGlzIDIuDQo+Pj4+Pj4+Pj4gU28gMiBjbSBjb25uZWN0aW9uIHdpbGwgYmUgY3JlYXRlZCBh
cyBiZWxvdzoNCj4+Pj4+Pj4+PiBDUFUwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IENQVTENCj4+Pj4+Pj4+PiBpbml0X2Nvbm5zIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+PiDCoMKgIMKgwqAgY3Jl
YXRlX2NtKCkgLy8gYS4gY29uWzBdIGNyZWF0ZWTCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4g
wqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIGEnLiBydHJzX2NsdF9yZG1hX2Nt
X2hhbmRsZXIoKSB7DQo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoCBydHJzX3JkbWFfYWRkcl9yZXNvbHZlZCgpDQo+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqAgY3JlYXRlX2Nvbl9jcV9xcChjb24pOyA8
PCBjb25bMF0NCj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
fQ0KPj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgaW4gdGhpcyBt
b21lbnQsIHJlZmNudCBvZiBQRCB3YXMgaW5jcmVhc2VkIHRvIDIrDQo+Pj4gV2hhdCBkbyB5b3Ug
bWVhbiAicmVmY250IG9mIFBEIj8gdXNlY250IGluIHN0cnVjdCBpYl9wZCBvciBkZXZfcmVmLg0K
Pj4gSSBtZWFuIHVzZWNudCBpbiBzdHJ1Y3QgaWJfcGQNCj4+DQo+Pg0KPj4NCj4+Pj4+Pj4+PiDC
oMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4gwqDCoCDCoMKgIGNy
ZWF0ZV9jbSgpIC8vIGIuIGNpZCA9IDEsIGZhaWxlZMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4g
wqDCoCDCoMKgwqDCoCBkZXN0cm95X2Nvbl9jcV9xcCgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoCBydHJzX2liX2Rldl9w
dXQoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4gwqDC
oCDCoMKgwqDCoMKgwqDCoMKgIGRldl9mcmVlKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGliX2RlYWxsb2NfcGQoZGV2LT5pYl9wZCkgPDwgUEQgfA0KPj4+Pj4+Pj4+IMKgwqAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpcyBkZXN0cm95ZWQsIGJ1dCByZWZjbnQgaXPCoMKgwqAgfA0KPj4+
Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGlsbCBncmVhdGVyIHRoYW4gMMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+PiBBc3N1bWluZyB5b3UgbWVhbiAicGQtPnVzZWNudCIu
IFdlIG9ubHkgYWxsb2NhdGUgcGQgaW4gY29uWzBdIGJ5IHJ0cnNfaWJfZGV2X2ZpbmRfb3JfYWRk
LA0KPj4+IGlmIGNvblsxXSBmYWlsZWQgdG8gY3JlYXRlIGNtLCB0aGVuIGFsbG9jX3BhdGhfcmVx
cyAtPiBpYl9hbGxvY19tciAtPiBhdG9taWNfaW5jKCZwZC0+dXNlY250KQ0KPiANCj4gVGhlIGFi
b3ZlIGNhbid0IGJlIGludm9rZWQsIHJpZ2h0Pw0KPiANCj4+PiBjYW4ndCBiZSB0cmlnZ2VyZWQu
IElzIHRoZXJlIG90aGVyIHBsYWNlcyBjb3VsZCBpbmNyZWFzZSB0aGUgcmVmY250Pw0KPj4gWWVz
LCB3aGVuIGNyZWF0ZSBhIHFwLCBpdCB3aWxsIGFsc28gYXNzb2NpYXRlIHRvIHRoaXMgUEQsIHRo
YXQgYWxzbyBtZWFuIHJlZmNudCBvZiBQRCB3aWxsIGJlIGluY3JlYXNlZC4NCj4+DQo+PiBXaGVu
IGNvblswXShjcmVhdGVfY29uX2NxX3FwKSBzdWNjZWVkZWQsIHJlZmNudCBvZiBQRCB3aWxsIGJl
IDIuIGFuZCB0aGVuIHdoZW4gY29uWzFdIGZhaWxlZCwgc2luY2UNCj4+IFFQIGRpZG4ndCBjcmVh
dGUsIHJlZmNudCBvZiBQRCBpcyBzdGlsbCAyLiBjb25bMV0ncyBjbGVhbnVwIHdpbGwgZGVzdHJv
eSB0aGUgUEQoaWJfZGVhbGxvY19wZCkgc2luY2UgZGV2X3JlZiA9IDEsIGFmdGVyIHRoYXQgaXRz
DQo+PiByZWZjbnQgaXMgc3RpbGwgMS4NCj4gDQo+IEkgY2FuIHNlZSB0aGUgcGF0aCBpbmNyZWFz
ZSB1c2VjbnQgdG8gMS4NCj4gDQo+IHJ0cnNfY3FfcXBfY3JlYXRlIC0+IGNyZWF0ZV9xcA0KPiAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAtPiByZG1hX2NyZWF0ZV9xcA0KPiAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgLT4gaWJfY3JlYXRlX3Fw
DQo+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgLT4g
Y3JlYXRlX3FwDQo+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgLT4gaWJfcXBfdXNlY250X2luYyB3aGljaCBpbmNyZWFzZXMgcGQtPnVzZWNudA0KPiAN
Cj4gV2hlcmUgaXMgYW5vdGhlciBwbGFjZSB0byBpbmNyZWFzZSB1c2VjbnQgdG8gMj8NCg0KSXQg
c2hvdWxkIGJlDQppYl9jcmVhdGVfcXDjgIAuLi4NCiAgIC0+IHJ4ZV9jcmVhdGVfcXANCiAgICAg
LT4gcnhlX3FwX2Zyb21faW5pdA0KICAgICAgICAtPiByeGVfZ2V0KHBkKSA8PDwgcGQncyByZWZj
bnQgd2lsbCBiZSBpbmNyZWFzZWQuDQoNCg0KPiANCj4+PiBUaGVuIHdoYXQgaXMgdGhlIGFwcHJv
cHJpYXRlIHRpbWUgdG8gY2FsbCBkZXN0cm95X2Nvbl9jcV9xcCBmb3IgdGhpcyBzY2VuYXJpbz8N
Cj4+PiBPdGhlcndpc2UgdGhlcmUgY291bGQgYmUgbWVtb3J5IGxlYWsuDQo+PiB3ZSBtdXN0IGVu
c3VyZSBRUCBpbiBjb25bMF0gaXMgY2xvc2VkIGJlZm9yZSBkZXN0cm95aW5nIHRoZSBQRC4NCj4+
IEN1cnJlbnRseSBkZXN0cm95X2Nvbl9jcV9xcCgpIHN1YnJvdXRpbmUgd2lsbCBjbG9zZSB0aGUg
b3BlbmVkIFFQIGZpcnN0Lg0KPiANCj4gTGV0IG1lIHRyeSBhbm90aGVyIHdheSwgd2l0aCBiZWxv
dyBjaGFuZ2UsIHJ0cnNfaWJfZGV2X3B1dCBjYW4ndCBiZSBjYWxsZWQNCj4gZnJvbSBkZXN0cm95
X2Nvbl9jcV9xcCwgcmlnaHQ/DQoNCk5vdCByZWFsbHksIGNvblswXS0+aGFzX2RldiBpcyB0cnVl
LCBzbyBjb25bMF0ncyBjbGVhbnVwIHdpbGwgY2FsbCBydHJzX2liX2Rldl9wdXQoKQ0KDQpXaXRo
b3V0IHRoaXMgcGF0Y2gsIHdoZW4gY29uWzFdIGZhaWxlZCwgY29uWzFdJ3MgY2xlYW51cCB3aWxs
IGJlIGNhbGxlZCBmaXJzdC4gdGhlbiBjYWxsIGNvblswXSdzIGNsZWFudXAuDQpBZnRlciB0aGlz
IGNoYW5nZSwgY29uWzFdJ3MgY2xlYW51cCB3aWxsIG5vdCBjYWxsIHJ0cnNfaWJfZGV2X3B1dCwg
YnV0IGl0IHdpbGwgYmUgY2FsbGVkIHRoZSBsYXRlciBjb25bMF0ncyBjbGVhbnVwLg0KDQoNClRo
YW5rcw0KWmhpamlhbg0KDQo+IA0KPiArwqDCoMKgIGlmICghY29uLT5oYXNfZGV2KQ0KPiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOw0KPiAgwqDCoMKgwqAgaWYgKGNsdF9wYXRoLT5zLmRldl9yZWYg
JiYgIS0tY2x0X3BhdGgtPnMuZGV2X3JlZikgew0KPiAgwqDCoMKgwqDCoMKgwqDCoCBydHJzX2li
X2Rldl9wdXQoY2x0X3BhdGgtPnMuZGV2KTsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgY2x0X3BhdGgt
PnMuZGV2ID0gTlVMTDsNCj4gDQo+IFRoZW4gd2hlbiB3aWxsIHlvdSBkZWFsbG9jIHBkIGFuZCBm
cmVlIHJ0cnNfaWJfZGV2Pw0KPiANCj4gVGhhbmtzLA0KPiBHdW9xaW5n
