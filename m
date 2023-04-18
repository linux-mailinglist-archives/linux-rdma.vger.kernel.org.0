Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580266E5A0A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDRHFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjDRHFW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 03:05:22 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 00:05:12 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AAA198E
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681801513; x=1713337513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tpuQXC2DtNx56qRxduNDCkVKB+XSXdvEV7K2Z8gO/wE=;
  b=uismHR21VZv8Xi42waI09KZ5BBz7kq7MzwBlxSTvNErhD8qn2Mx9T7ZM
   nrD7n+SxWWm3IQCRjeesDRaH50Fo3rlwlPcrZIOBG/pu6b6LgMh0QiSYm
   Mf1mKdT6Dx17Zq8x7xv5S4xhgCIcUXMvWXV9J0oDA+LsRqJI70SbXNjvz
   BqxA/aHfvUo1l/wsBDVeIdXNYiTwOequp4bDRLp7QEa8ccL7y6LRMkc08
   /wm38LWf02JUoL4u6nm6yEYgJx/SN0acINXE5wjVR4hQX48+fuM98Q9aD
   1egCBtazIYcJcmn7BgxreASg3cib1s7eBKEaFYzocYYY7ngx3BnIrY/ZS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="81992587"
X-IronPort-AV: E=Sophos;i="5.99,206,1677510000"; 
   d="scan'208";a="81992587"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 16:04:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUbXl1s6G/D0ojL4YVdJ5WSh/gYiMAxtIauIow0kGvQ814ACRoa+M00ByH1zfPIsqovF5SnQY2lyntBWM5x75gicUJJe2d/8uj5uQqCowkkk+b+NA9u5tzVXZgwvbIB0y/joq5vTqjs8qXpkXSZpOkQxr9+zl3tfWZxKUAWuFfuwjZehxSZXqltK4AmeIwtgu/2EwJqTjibh7iFsvs8x5RMcM+w0RO9ASCUF+QXSnrLl+d/WMi7LrvWJVLHzNZC8CSpEEfgr/EESgR7oCS7qEMIBoQv+B5gXxOMsJCOHq+TdlWtKFfUMQkGrflsnkg20mtb+eq61X5JyCA3/waVy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpuQXC2DtNx56qRxduNDCkVKB+XSXdvEV7K2Z8gO/wE=;
 b=Sx53vdmzpBaC7yPEyNYTvybJesMsHGxUJrYv+VWEGZZ/Yjrg1rA3saHXDgC4ZlEGqv2zh8VPyEWHGkOn2WkgBHbdsaF29qzeWO6a9zOFzzzo8TEs+9cycgcNBUJ3Riq/lQ2/BnN0oc3B5Kc+icyEGgae50utO0ZIa7qtcXuw5dt2LWjSTW1z/Ldy3ka3eBQRmDcnhTjgwpIEFYXys57U1JudedkuzWtjXPkUxMxKLj1GN/WbzB+XLjYvATsPNwjK9+jFRvvOMjwiNZ1w0Bci9lgB0sL6fPEyBgGgqrW8RRETrn9ZwVDBPKuO+FfFrmHjkw1kp5oB0T52sWshLuA6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYCPR01MB8407.jpnprd01.prod.outlook.com
 (2603:1096:400:150::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 07:04:01 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 07:04:00 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCAgAEIcgCAANmvgA==
Date:   Tue, 18 Apr 2023 07:04:00 +0000
Message-ID: <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com>
References: <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
 <20230417180452.GG15386@unreal>
In-Reply-To: <20230417180452.GG15386@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYCPR01MB8407:EE_
x-ms-office365-filtering-correlation-id: 739f335d-309f-4989-51b6-08db3fdb1662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LHKVGWphsGmyKbZF0YLRfE2dgTXOd847HyLOUMuj2Ohf78HVErCkQQ4rB/Os6KnNaht8v3B8a3pg55ZC0Da3+HG6Q123kskqq4/i01F34uUMLvZidKZcIq9oDCM3uJUhLhg3v8tPRAKcDCTwoG4o96yaVMa4Na4A1nY+Pn8mpiSE1qxgHE90CTEeZT5lRCqXzH7wIClonQfP9BXhPtWuqggSXfyjBoZV3gCVBW5yPeGpAefivT7NPyCJ55KtlRpPyGOUB7Q9Hwc9sxAJ0zKkhlvMSGx9I+KkIzSh950OlkGiO6SdNdhP4pL6px+6+NRtXLsIs4kHod8azm/p+Y4cqQHpZvHNrT6Ok0+tOAHhoClRkCsX/UNqvcX0qRCLgFsfGD/deFMW0/aVuA345XTSP1nImXzOVo1xeufDIQDx68hoKnb+d3wr6kk/Sgkb4+RflMbcOjvxWnKcF8aUb14CeUs1Qy95TUkv5srVp9gxp37lL+EEyy+XEHasaxjEAilGS1QlSXHTa3LcaCgVSIXVcKuXHAfSHkl2bRP7t150OkLgua87F/Wz4tzh31qoCyJmRXdxHu2nNrVmxVGXHx9mE+piA+X5G7J+84wu5VBBQKkV92yrkX5uoMsPaEzcq+lZV7BvSwP51xvvwOGne1smEMTbXKaicjaKCYSJ2UDub7l8TKEx8jZUv8Xx2IW572xtyjPzZ+0ZKdaFY87jxA9RKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(1590799018)(31696002)(31686004)(6506007)(26005)(6512007)(53546011)(478600001)(86362001)(83380400001)(2616005)(186003)(6486002)(1580799015)(66899021)(66446008)(66476007)(5660300002)(66946007)(4326008)(6916009)(76116006)(8676002)(91956017)(8936002)(2906002)(66556008)(38070700005)(71200400001)(38100700002)(64756008)(316002)(41300700001)(36756003)(85182001)(82960400001)(122000001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJpSkRvSyt5OE5CdTNiTlBmOFJmYWw5NFlUVy9pKy9LeVdVbXBUNyt4cG9X?=
 =?utf-8?B?QlJBaGUxbmo3VHVqbFBMdUNIMVNUQnlVMURrSGlOUHR6YXBCS1ZVWFlFVmtn?=
 =?utf-8?B?bjRlQTM3Vk5Ud2xsSlVGMFpRZXZ4V3BtRnU2YW1ET25PK0lGQkNvV29VeitJ?=
 =?utf-8?B?aFdIdUQxUi9VMVF3NHVYaTd6a2FiL0lCWkFqYk8xSDZYc0xFSHZyZDBjVG9p?=
 =?utf-8?B?SXlZZSs3cEZhVSszQnVnRG5sK2JUOWRVQUFKN0dYRkJlR2FaQnJ4LzV1VDJK?=
 =?utf-8?B?eEpGazlTbHhqNUp4ZWlnT1VlWXNHMklmV3JHbVhqRUMyMnJldTRmRVhoZUlH?=
 =?utf-8?B?T2lsaGkxVnNBYzBnckQxSXY0MWJBK0w2V1VHeEJ6M1dzcjF3WW1Dc050ak9m?=
 =?utf-8?B?MFdEVTMwb2xlQ3Y4b2xqM0RIL0ZjMVhTc1FiUVFPZXdUaTdjTFVyRjZvck93?=
 =?utf-8?B?NXliNlNabjVoN212Lys1VytvQXNEeHNsZkVMckJzd1NGUTI0Wm5peDg5M2gy?=
 =?utf-8?B?TFZKK1AzQmRxeEF3dVpDWFBKU1RqOVU2SXRCcjRmaFU2alF6NXpRTTI5bUhh?=
 =?utf-8?B?bURNQ1g2SlQyN2R4bENWRnFJZGppTTc1NktWZ2Q2blBXZytmMG5aanhlYzBN?=
 =?utf-8?B?SDV3RjgzSloyb2JHWE1GWm9NaE0vQVBDL0sxTnRESVRUZkxkclNmWS9NMVJN?=
 =?utf-8?B?S1oxaCtRUE8wM2hxbnB3NldyZkdyM0k1ZVFKczJXTWhwaWUrNEdydFdvUTRN?=
 =?utf-8?B?WnBlbjg0RklkbUlMYTRweTVvUDM5R0ZVMUlMMTBwTTBjWENTdERqczBFQURK?=
 =?utf-8?B?bnFLRi9QbmtJcldDRm1wbDZ2djhGbmE0VHp2UHlydDhQRlZra3RIemRka0lB?=
 =?utf-8?B?RzREc0VObnJTUHlHWmVDSGJWYkZ4TTRZVU80eW92WjcxMW9LbmluQTVsZ3pV?=
 =?utf-8?B?OHJlU3doQ2YyWUhtTGp1anA5Y3FhOFRwUlhMeXQ2d3EwOVRneWJaVlp1U2Uv?=
 =?utf-8?B?UjJCdVVrUXR4Q1FadTdkaXVjaFNQVU5XT3lPTDdWaVZEc1NnSFhiaVNlYTBB?=
 =?utf-8?B?UmFNSyt0RWhqUVNLTExHcEFuR1ltMkpqMFZjb1Q5QW9XYzlIbStVdDNjeVdD?=
 =?utf-8?B?THI3QlVPL016Mjl3YnFVUFFKNDVBWWFabk50UFFyQjBweEN2ZEJFaU1aUElB?=
 =?utf-8?B?SlA4ZURwVVZHZzNRQkdpSXp3WjR6U1NReDgrbC9hbkw1Ulp6VGh5QUlLcTlG?=
 =?utf-8?B?d3VKd0tMRjIvcWJucmxONUlPNDBUSmlyNzlCQ2ljQXBYdW5way8xRm42Rk02?=
 =?utf-8?B?SXdqTi9ZLzFaNndYczhyY0xHMTN3VmpxNmVCYStzaVdHMVhFbVQxbW9POGVK?=
 =?utf-8?B?YnpoQW9uUTFjZGdTZFpwZUJScitoSkZPYlFXMmRJVEdlOGJ1RWcybDBlVTl5?=
 =?utf-8?B?UENobEFzcE9hMHFIZEsrNXlaUDhnM0JNNjYzTDdNZHQ4R3EybGFvVUNKcVpH?=
 =?utf-8?B?czVFUjlpK1UwaXFBQjNsd1RNL0lSV1hIakxhNng1RGlZM01wK0NsSnNMN1do?=
 =?utf-8?B?R1dwT09xRXJ6a3Z6VTRwekw0eXpiZmxSL29UbDRXbHlVdUxYRGJ3WjM3L0VX?=
 =?utf-8?B?S0djbWNmY25vMWgrTDRtNGlYYlhHd21NaVpaS3FuWG9rYVAwYlYrWU90ZGZY?=
 =?utf-8?B?cGJDcFRYSVBnazhIc1RjSE9iRXdwNWhhVHJ0d3hZeFdnRmpMbnpQZEhRbDM2?=
 =?utf-8?B?VEM1TEVqSFdUMU1UZlc5RVVLUEQrWUpGaGdFSGM1d2NwM2JtN1NJR2hodlJ2?=
 =?utf-8?B?ZW1RSmhvbE9hemkrQndMQ3lKdzc1Uk9GVmE1WjE1YlQxdnNnOTZWTkFONVlO?=
 =?utf-8?B?R21hbDRQVkFzL3R6amRGTFlCejZQTnM1Nk1OUHQ5ckxkRmIrOHNJOXE4RzlT?=
 =?utf-8?B?eER3SFVEQkNFelltU2FQaTcyM2NjSTFqRGZXRWptUHRsRWQxY2RGR0pXTzRO?=
 =?utf-8?B?WFFsYzkvTTcrOHZOZUIzbVlNcit6RXhuWVNOVG9odWV5UXFVRERaZWVWUjgx?=
 =?utf-8?B?SUVVMk5TektsSEpFQnE4M2hWRm9VYVdIcEM1c1VZUWgvMlQrZEQ0SmYxbXZL?=
 =?utf-8?B?WWZlUXprRVBUYjNjWU5CTlQ2UjdMYnVQeEZETkZqOE5RMjhzZktFeURoN0pp?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3F711117B07814B9A3DCA5B31287F5E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dogaEJUnrtp0KYCw8Q7ePGc96yz5zjAPXJUedTxZW3xvuXYKSsK2hJIxE2nKyyd18GwsyYBwK2xQE1FK7AQz2H65WMsh2CHUU1cizbQPqaNPAuSDo3JFGCgcQyKhzxUYMB3DRILFzWtitkXLW+x6Ur71V2yt5suqnMMyozZNqJWP3jlbaGgvqzeXAxsrYtWq2KWz6K7HoJZFO4fw3EFnBSnC7gfVd9HrqCeqd51UeHH61T06WL/zYBJjd5vxmxd8NLl2bvo+Rw0WwqVbaMNDIK92YiWvuOMhbDCFHCVFPHD0ZPRSElXcMMI+kcMe8NQ/LwdJreMue4FxLZ5hKVCArVj2LsVnHCuQGjjoLyRPk8IUMieytHBsOaslZGRycLCHIwRtJqa2Dn3HtCWzGw0uQY8Ik3ceOe4/J/8NmhsWCyyOHfEwoKlhCiD7RqzFxJI0u+erQ8FEALSxsr4ii4Cc0gbpI9vNd7uomQBCxTnSUeSq7xIx6nnNYpjvHWKTJRGP8JKDDGOSvNjDhsdKHijsI84+M3DNQEOhTEwe/E7nfX0o5qQ3XbvyUq15B38Pcva6HKItLVjmG5xfW7xCRNl5f8pMUeOl++P6ki/P7YsDfVF4Af+woM5Ro2lVRzEbxrwkE0/2kbQMhi8YolXIm/70K5rkm6qAE10t4oUkbhpDvrmNCGsdQYBAHf2fOlM5cerceEp0v87P+HFhGr4+iZQJ3+waOcg0zKXKvlwpwGPNmfyXhHSetTOoAnVlqmbGt6w8tJpOVr57yaOr0CG9il+0+SBFJsFVASFbO/X0DuQ/p/E6zG5Z02jr7CSHMxF/zZyFRHl/gB47NoQGm+Bmxn6OZuLOb+rx7oWEra0HWAe2km3QbzkkHVdzZNfIN11Y4+7a
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f335d-309f-4989-51b6-08db3fdb1662
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 07:04:00.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnfO5kZVNqflTR/6GheWDVbtAKlHHkrqcNikVKsXpWa64A1P1FqZk96cYuxhnq1u4itsWkDN00BfCz6Xy58ybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8407
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzA0LzIwMjMgMDI6MDQsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gTW9u
LCBBcHIgMTcsIDIwMjMgYXQgMDI6MTg6MjRBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDE0LzA0LzIwMjMgMjM6NTgsIFpodSBZYW5qdW4gd3JvdGU6
DQo+Pj4g5ZyoIDIwMjMvNC8xMyAyMToyNCwgTGVvbiBSb21hbm92c2t5IOWGmemBkzoNCj4+Pj4g
T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDg6MTI6MTVBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVq
aXRzdSkgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIDEzLzA0LzIwMjMgMTU6MzUsIEd1
b3FpbmcgSmlhbmcgd3JvdGU6DQo+Pj4+Pj4gSGksDQo+Pj4+Pj4NCj4+Pj4+PiBJIHRha2UgYSBj
bG9zZXIgbG9vayB0b2RheS4NCj4+Pj4+Pg0KPj4+Pj4+IE9uIDQvMTIvMjMgMDk6MTUsIFpoaWpp
YW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiAxMS8wNC8yMDIzIDIw
OjI2LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+Pj4+PiBPbiBUdWUsIEFwciAxMSwgMjAy
MyBhdCAwMjo0Mzo0NkFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+IE9uIDEwLzA0LzIwMjMgMjE6MTAsIEd1b3FpbmcgSmlhbmcgd3JvdGU6
DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IE9uIDQvMTAvMjMgMjA6MDgsIExlb24gUm9tYW5vdnNr
eSB3cm90ZToNCj4+Pj4+Pj4+Pj4+IE9uIE1vbiwgQXByIDEwLCAyMDIzIGF0IDA2OjQzOjAzQU0g
KzAwMDAsIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gVGhlIHdhcm5pbmcgb2NjdXJz
IHdoZW4gZGVzdHJveWluZyBQRCB3aG9zZSByZWZlcmVuY2UgY291bnQgaXMgbm90IHplcm8uDQo+
Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBQcmVjb2RpdGlvbjogY2x0X3BhdGgtPnMuY29uX251
bSBpcyAyLg0KPj4+Pj4+Pj4+Pj4+IFNvIDIgY20gY29ubmVjdGlvbiB3aWxsIGJlIGNyZWF0ZWQg
YXMgYmVsb3c6DQo+Pj4+Pj4+Pj4+Pj4gQ1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBDUFUxDQo+Pj4+Pj4+Pj4+Pj4gaW5pdF9jb25ucyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4+Pj4gIMKg
wqAgwqDCoCBjcmVhdGVfY20oKSAvLyBhLiBjb25bMF0gY3JlYXRlZMKgwqDCoMKgwqDCoMKgIHwN
Cj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIGEnLiBy
dHJzX2NsdF9yZG1hX2NtX2hhbmRsZXIoKSB7DQo+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgcnRyc19yZG1hX2FkZHJfcmVzb2x2ZWQoKQ0KPj4+
Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoCBj
cmVhdGVfY29uX2NxX3FwKGNvbik7IDw8IGNvblswXQ0KPj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgfQ0KPj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IGluIHRoaXMgbW9tZW50LCByZWZjbnQgb2YgUEQgd2FzIGlu
Y3JlYXNlZCB0byAyKw0KPj4+Pj4+DQo+Pj4+Pj4gV2hhdCBkbyB5b3UgbWVhbiAicmVmY250IG9m
IFBEIj8gdXNlY250IGluIHN0cnVjdCBpYl9wZCBvciBkZXZfcmVmLg0KPj4+Pj4NCj4+Pj4+IEkg
bWVhbiB1c2VjbnQgaW4gc3RydWN0IGliX3BkDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4N
Cj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+
Pj4+Pj4+ICDCoMKgIMKgwqAgY3JlYXRlX2NtKCkgLy8gYi4gY2lkID0gMSwgZmFpbGVkwqDCoMKg
wqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKgwqDCoCBkZXN0cm95X2Nvbl9jcV9xcCgp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+PiAgwqDC
oCDCoMKgwqDCoMKgwqAgcnRyc19pYl9kZXZfcHV0KCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Zy
ZWUoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+
Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGliX2RlYWxsb2NfcGQoZGV2LT5p
Yl9wZCkgPDwgUEQgfA0KPj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aXMgZGVzdHJveWVkLCBidXQgcmVmY250IGlzwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+PiAgwqDCoCDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0aWxsIGdyZWF0ZXIgdGhhbiAwwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfA0KPj4+Pj4+DQo+Pj4+Pj4gQXNzdW1pbmcgeW91IG1lYW4gInBkLT51c2VjbnQiLiBX
ZSBvbmx5IGFsbG9jYXRlIHBkIGluIGNvblswXSBieSBydHJzX2liX2Rldl9maW5kX29yX2FkZCwN
Cj4+Pj4+PiBpZiBjb25bMV0gZmFpbGVkIHRvIGNyZWF0ZSBjbSwgdGhlbiBhbGxvY19wYXRoX3Jl
cXMgLT4gaWJfYWxsb2NfbXIgLT4gYXRvbWljX2luYygmcGQtPnVzZWNudCkNCj4+Pj4+PiBjYW4n
dCBiZSB0cmlnZ2VyZWQuIElzIHRoZXJlIG90aGVyIHBsYWNlcyBjb3VsZCBpbmNyZWFzZSB0aGUg
cmVmY250Pw0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBZZXMsIHdoZW4gY3JlYXRlIGEgcXAsIGl0IHdp
bGwgYWxzbyBhc3NvY2lhdGUgdG8gdGhpcyBQRCwgdGhhdCBhbHNvIG1lYW4gcmVmY250IG9mIFBE
IHdpbGwgYmUgaW5jcmVhc2VkLg0KPj4+Pj4NCj4+Pj4+IFdoZW4gY29uWzBdKGNyZWF0ZV9jb25f
Y3FfcXApIHN1Y2NlZWRlZCwgcmVmY250IG9mIFBEIHdpbGwgYmUgMi4gYW5kIHRoZW4gd2hlbiBj
b25bMV0gZmFpbGVkLCBzaW5jZQ0KPj4+Pj4gUVAgZGlkbid0IGNyZWF0ZSwgcmVmY250IG9mIFBE
IGlzIHN0aWxsIDIuIGNvblsxXSdzIGNsZWFudXAgd2lsbCBkZXN0cm95IHRoZSBQRChpYl9kZWFs
bG9jX3BkKSBzaW5jZSBkZXZfcmVmID0gMSwgYWZ0ZXIgdGhhdCBpdHMNCj4+Pj4+IHJlZmNudCBp
cyBzdGlsbCAxLg0KPj4+Pg0KPj4+PiBXaHkgaXMgcmVmY250IDEgaW4gY29uWzFdIGRlc3RydWN0
aW9uIHBoYXNlPyBJdCBzZWVtcyB0byBtZSBsaWtlIGEgYnVnLg0KPj4NCj4+DQo+Pg0KPj4+ICsJ
aWYgKCFjb24tPmhhc19kZXYpDQo+Pj4gKwkJcmV0dXJuOw0KPj4+ICAgCWlmIChjbHRfcGF0aC0+
cy5kZXZfcmVmICYmICEtLWNsdF9wYXRoLT5zLmRldl9yZWYpIHsNCj4+PiAgIAkJcnRyc19pYl9k
ZXZfcHV0KGNsdF9wYXRoLT5zLmRldik7DQo+Pj4gICAJCWNsdF9wYXRoLT5zLmRldiA9IE5VTEw7
DQo+Pg0KPj4gQ3VycmVudGx5LCB3aXRob3V0IHRoaXMgcGF0Y2g6DQo+PiAxLiBQRCBhbmQgY2x0
X3BhdGgtPnMuZGV2IGFyZSBzaGFyZWQgYW1vbmcgY29ubmVjdGlvbnMuDQo+PiAyLiBldmVyeSBj
b25bbl0ncyBjbGVhbnVwIHBoYXNlIHdpbGwgY2FsbCBkZXN0cm95X2Nvbl9jcV9xcCgpDQo+PiAz
LiBjbHRfcGF0aC0+cy5kZXYgd2lsbCBiZSBhbHdheXMgZGVjcmVhc2VkIGluIGRlc3Ryb3lfY29u
X2NxX3FwKCksIGFuZCB3aGVuDQo+PiAgICAgIGNsdF9wYXRoLT5zLmRldiBiZWNvbWUgemVybywg
aXQgd2lsbCBkZXN0cm95IFBELg0KPj4gNC4gd2hlbiBjb25bMV0gZmFpbGVkIHRvIGNyZWF0ZSwg
Y29uWzFdIHdpbGwgbm90IHRha2UgY2x0X3BhdGgtPnMuZGV2LCBidXQgaXQgdHJ5IHRvIGRlY3Jl
YXNlZCBjbHRfcGF0aC0+cy5kZXYgPDw8IGl0J3Mgd3JvbmcgdG8gZG8gdGhhdC4NCj4gDQo+IFNv
IHBsZWFzZSBmaXggaXQgYnkgbWFraW5nIHN1cmUgdGhhdCBmYWlsdXJlIHRvIGNyZWF0ZSBjb25b
MV0gd2lsbA0KPiByZWxlYXNlIHJlc291cmNlcyB3aGljaCB3ZXJlIGFsbG9jYXRlZC4gSWYgY29u
WzFdIGRpZG4ndCBpbmNyZWFzZQ0KPiBzLmRldl9yZWYsIGl0IHNob3VsZG4ndCBkZWNyZWFzZSBp
dCBlaXRoZXIuDQoNCllvdSBhcmUgcmlnaHQsIHRoZSBjdXJyZW50IHBhdGNoIGRpZCBleGFjdGx5
IHRoYXQuDQpJdCBpbnRyb2R1Y2VkIGEgY29uIG93bmluZyBmbGFnICdoYXNfZGV2JyB0byBpbmRp
Y2F0ZSB3aGV0aGVyIHRoaXMgY29uIGhhcyB0YWtlbiBzLmRldi4NCnNvIHRoYXQgaXRzIGNsZWFu
dXAgcGhhc2Ugd2lsbCBvbmx5IGRlY3JlYXNlIGl0cyBzLmRldiBwcm9wZXJseS4NCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCg0KPiANCj4gVGhhbmtzDQo+IA0KPj4NCj4+DQo+PiBUaGFua3MNCj4+IFpo
aWppYW4NCj4+DQo+Pj4gQWdyZWUuIFdlIHNob3VsZCBmaW5kIG91dCB3aHkgcmVmY250IDEgYW5k
IGZpeCB0aGlzIHByb2JsZW0uDQo+Pg0KPj4NCj4+DQo+Pg0KPj4+DQo+Pj4gWmh1IFlhbmp1bg0K
Pj4+Pg0KPj4+PiBUaGFua3MNCj4+Pg==
