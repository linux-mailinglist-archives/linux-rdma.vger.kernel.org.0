Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261D6E1CCE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNGrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 02:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNGrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 02:47:45 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA526BB;
        Thu, 13 Apr 2023 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681454860; x=1712990860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DlIrdyEfuDv25LP4VFXwijlaRVNRwwfdjpQK2Ac/GHE=;
  b=N9+8HoLIsvXal8X1EnwVsA/de35TB9mkHyMFEtzFninnYsQmHE8jTTzs
   fa2UAshg+f9D/hGNHml14ols+Fxe4iU85Cgl6a7YoXcUkQm3OGM+dQhJg
   eKxXrpZ5oqhW5Xwc1Z2vukiPFL+usUKiNpNMNp/9FkxdZIO0P/jPuEalA
   s7V6gt1VxiKlULrdo4WK2GLqFxBY+Aw2tJ4OxebVvEZvtgHzUR2rPJucB
   2NGMsJsfGw0m4srrAwoHDvQB3wdnq4UrhKJkF9OsuV/ybOWfs5xk/LRvY
   UybLyXFWb4i7WNfDLshm+2l+deSppKdySGVVdmTwzOGpmqQl7xIfOHz6V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="82293207"
X-IronPort-AV: E=Sophos;i="5.99,195,1677510000"; 
   d="scan'208";a="82293207"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 15:47:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTjn8HZDDzcDbPnM5o+XdUGtkf4e5Xdm5qGc3eMKflIpUZONnVtOJGW2basPdiGUKJyc2yXExaJ5pOdJDjl+Wc5vzfElgOwji218ecBji6GExDA64rluzUUWXhjQ9mgqrsq3Fc9iOsp7ex8JO8xQ+r+qq6+OM4SNVwes8HYUKXhSrRl/2luJ5c6BgOsjhCuI1y+Nc4lXMXOh1JmNmdIXbYbuZ7Ep4SquiWUt3PnTe9ah+e7AoaANbeqbSWEoPyB11iV7iJ5+4dBfxozwkKdP+8CwLwpt75+y3ufoqcRnN9PB4io84XOEvwr56i9eUcwQEXwrT6Wu6x9/N7SPz40cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlIrdyEfuDv25LP4VFXwijlaRVNRwwfdjpQK2Ac/GHE=;
 b=LXgV9BYUSndFYknCeqQeEWr+CXQ5C7uAgua9xn5sNqhSp9r0FUYutJcjV73RPZFSVp6qQPvy4W4R3E+oyVTPN3Ufk83xbWM/rJCdqS2ykkoCliMsoU8cIKkAC0kHer/Rz7Dbo/uh74KW0htSBPNR8q6UgOxU2dUK5Y0pSYnX/mZH9YgQcFa3Gp6gNR8Na4pz+7/FPniaEAVOFl3N3pleW4Z3YfKmza6G+9XX2mikFvmW3/1syI+KX2RfJIsOeYUPkKc+oIKJkZwGo0hxwOu/r+bXR7/UH4+BLyAvVRHwvnTL8y5wFDi3EniqFxU1H4A0q1AlvmCljTKNjJdtcFCw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYWPR01MB9775.jpnprd01.prod.outlook.com
 (2603:1096:400:235::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 14 Apr
 2023 06:47:32 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 06:47:32 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jinpu Wang <jinpu.wang@ionos.com>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgAFGcYCAACCfAIAAB1IAgAAMO4A=
Date:   Fri, 14 Apr 2023 06:47:32 +0000
Message-ID: <e0c96cb6-f4e3-0915-aded-10fc6df9868e@fujitsu.com>
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
 <CAMGffEkdMcj5_R49U4Vb1KV+4zMBtjzZAGhi1kHRACrz6DKkhg@mail.gmail.com>
In-Reply-To: <CAMGffEkdMcj5_R49U4Vb1KV+4zMBtjzZAGhi1kHRACrz6DKkhg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYWPR01MB9775:EE_
x-ms-office365-filtering-correlation-id: cd3c44fa-159d-4439-1569-08db3cb41fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ih1/w8mWm4qN0XXWrz0geQOtj3E6SlJ7H5EIjJ52xCWFEXDxKu39/AQEi4ejA8upUmXP6Uc26mLvtpOw35e8f1Nkv3EsM7bBo0HRf+CIxIlJTi7TsNJ/g9fHbTSq48MdcakzMhwy4ZyODbwpdg1qezg+kHB7mprya4ZpGDSYzbdIJTUBEJTPtw6TMhp+ce3EZAQrKO+bBv8Y5k09CMjdaDy6aJZDGwAiPYEIINhnzWbD3OYIN9ZNuGyBXI0pifW1PJqVrhyQIHy9a8LdzeQ5HVvV9E7rOpK+qUUSJinBxg2Qt4miB0b39HeZjMNn6F+cmvn61AkzZQB3u80VmjijCwRN8jBTyVtiBO1gwG5ftyi9W9bSNQ4EOPtvkvdnEQ5qF/qWah0Rr06k+Cpq63+cRRrR8CKQRL1DjQophk7ZqqbFwVMIcc3qcQSAPQ3fK31fF0/2l2m1ctKmXSRfmv89GHlvjku7sQqzuPdDNTZDE3uY5OwOKwqAUxaXoUHgLB3W4p+uQy8LxozRdpOaHxbqUV5n5d4unVc9f0ozFbIBNtPsflb9u5fM7m0wLhizr47mRT5+BdACfEv+aYCkj2arGqIJ79whNkHA72XQ45dZXgW+td1xTuXOHwdN8B7Tzym+OHIzIlaoVE+mI+hbf3oq7WaMtEEAQlLtRENoBWt1L3ud8be0+fR/XaUSZ9xHxVCsIfIo0euYGChEuQpvNco4DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(1590799018)(76116006)(31696002)(82960400001)(316002)(66446008)(66556008)(86362001)(31686004)(66946007)(64756008)(83380400001)(66476007)(478600001)(122000001)(91956017)(38100700002)(38070700005)(6512007)(6916009)(186003)(2616005)(53546011)(4326008)(36756003)(85182001)(2906002)(41300700001)(6506007)(26005)(71200400001)(8676002)(54906003)(8936002)(1580799015)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjgzZnpHUkxTWmFFOUtINllwUmZCODJEZkZ3ZjFBTmc1VkQvSGsrVFVSbkIr?=
 =?utf-8?B?L1dsR0hKMUpCbUExMHpzUGdFaDU2NWVFbEtZeGpoQUpFeW05Vy9GMlNzMThM?=
 =?utf-8?B?enY4STR4N0N5dC9MZjJsOWVXR0kzMXFQdG9vZC9PSXh5NzlLWWtqUHdoREt4?=
 =?utf-8?B?OXU3ZlBuUjA4UlhvQllUWHFvbmkxN2UzUEQwTE03L09hV3grb3ZYdEtZdFVQ?=
 =?utf-8?B?cmEySWZUbi91ZDdHdVZDWjFxSkVzMXVwWTdndmkrUlY5QTdYNkVOa0VhZlFD?=
 =?utf-8?B?Y3BVdVFXKzZwNWpoZWpkWnRNSjV3Z2doVFJTWjBtbmFhbDlBS1lkZGZUbU8z?=
 =?utf-8?B?TXR0Vi9wb3phNEU1U1AxRGl2UXdJME1PRWVSRVNTWTE4L2J0L2l1ZnBDNGtm?=
 =?utf-8?B?NEU4MXlQYmRxcEcvdlcrSjNpSDlOdEM4R3p1blJDK3hUYTdYd1EwZXpqYkhp?=
 =?utf-8?B?aUJ3UWtUYTZKRDNlZk1XbXpWd0dMMkNwN0ZpYmtoSDlaWE5Jb0pkZzAveU9s?=
 =?utf-8?B?aU9tWFdsS1E0NnlwZG9JZ256ek0yaUl5aitLVlRlZldTWHJqTzhTRVNwVU1G?=
 =?utf-8?B?eVVnUnhPRGFocWwxNXVGM3N2RWZBN0pvVlFOMnRxMWVTWHFLK0pKNGMzRlY2?=
 =?utf-8?B?cTAwc2xySnBtQVNITkR0RVFHek9OVlRvN0FBWm5NSnp5WDlCa3ZhOFdzaVZW?=
 =?utf-8?B?Q1hmZUExUFhzZXMvMnNUTEQ2ckdDYzlxV1dzeEoyekNPZFE4T3JaSW1UdGxS?=
 =?utf-8?B?TkhTQWtZUXlkaHRXbFpDdXNGM2xlcS9zRm5jMktONFFmaTVIMUYyTmJZaG1K?=
 =?utf-8?B?ZEJyeXNIWGVGQ1FKczhFTmdBRHdkbWlFeW1HYkNUNjJpajRHVGdadDZkVmE5?=
 =?utf-8?B?Ulg5cWg5eWd3aTBQWTZIZEovTExpeDYvd3pNUTJMTld0VktBZUg0WlJJK0t6?=
 =?utf-8?B?cVdyWFNNOXpuQ3Y2V2s2cExFeG1TdUM2cGU3OUJNU3Y5bklId0QzdzAwbFVE?=
 =?utf-8?B?bnMvaHVvSnZ5N2dQcUwvMXJwNGVtc3ZsMi9mRi9DZ0oreW5ja0dMQ3lrM1A0?=
 =?utf-8?B?RDRSZTZCV0VIOG1YLy9venloZXROVmM5dDNHNlMrQ2ZoQ1d2V3I4ZXUzUU94?=
 =?utf-8?B?UUZCeHVDSEFxTnorK1N0K0ZZdjNoOVdPdWVyMzNmbG80L0dHY0hETEhSbEhG?=
 =?utf-8?B?ZWZFUzh1UG1jVjk0ZUQzemtNZUswVjkyQWRYa3pobFhRa2ZvaUhvRUdMeG9P?=
 =?utf-8?B?bnFLM0xxV3lrR0ZJTXJXR3ViRXhucndJcmpnR0RISmRLSkR4OHBZMGJVaEMy?=
 =?utf-8?B?eUNScXlkQ3BHVTZWbmN0c0ZBMGRLbHZiTU81V25xMHZrd3Y1NTFSVHk1L2pN?=
 =?utf-8?B?M3FUTCttcFEwNlJZZElVNnd0NjhaUW9mbktrMTQyOWdncmJZc0VscFJBaGt0?=
 =?utf-8?B?ek1zN2xLb0Q0MnBKYjdaRWI0WjRVcktxK3BJK1B2WklTbCtoZ0NReEtJSUtC?=
 =?utf-8?B?WU1la01FY2lXd29BRElEYkVMRkZoYWw1eWpmYkdwRmNhdjFCVy8vSFlTRk94?=
 =?utf-8?B?b3VxQnp4bkF2WVRGMVEwMThiYXpxazd5R0d3SGRSbjh3TGRMMnp1NitSa2lp?=
 =?utf-8?B?NHJKZlZNS3Uwb1JzdVBLNVhQRWRsQzlQNVlSZFpScldsQ2xQdW5WWk10aGJo?=
 =?utf-8?B?djN5bzB3aGxIK1BydE5Qdkp1bGFYRWEyK3RSR2JJZkIwakZDOThqcE5XcU95?=
 =?utf-8?B?T0MwR21xbW1RV3l6TEV1TVN2Tnc4OUVNRkhTOVRVWTVkNUdSWi9wZGRnU1U1?=
 =?utf-8?B?ZmRGcGNwdU4rUnB1UmQwZElreGV1RmtZSlFUNm9RQ2JoSW5VNWM1aG5VVjlN?=
 =?utf-8?B?djRTK042RnpkR2ZiVTRiQTlveDJiamwxVFZZTVhNWHkwejhyT2RQUEkvemFR?=
 =?utf-8?B?cFBzNmZBcFgxM0JnTzBNQVVhMlRFNGpJYnhENm9qbHpIWVN6aFBWZCtmRXNo?=
 =?utf-8?B?QjlXY2c0aDR6T2c3RlZpZ2t2SUtFOFVxYng0TDF5cWhoNmNCUkdYY2dVNmZ5?=
 =?utf-8?B?ZmYxemlNRHRUb1ZMYStaeVRRSGVZbVNiR2ZmRUxOTVVpMEttYTl1UnhNeTcw?=
 =?utf-8?B?Qy9NM3c2eWtwYzNiVUdYV3U2S21DNVU1dEQ0RUMyZ1lSb012ODBqOEhleWU1?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDABED73FE835B4AAE16525DA113A341@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k7uS6mo2vVBuul9sGOtWJRdIPujGU3BU1ed640Fv7kyHtoQiPCatAjTX5Ukq6IEaWOpNui6+E+/+81RlzqYjx7+WHCj5nEn/yg+kAFp7ag72xJVed7TOowMeQ5zYQt0W9Tl2L5I0Pu7DDKyiCJtIepyBpgj6oaClBMj8XrMvUqfqVsEHJPzU9vqvmjHRSnKOKaWNRG9KelmN2WcdzafBO2Gbo9N/qGiR+6Sh6DUwyEH6qGZmQ0QxI5IkfqpN2A9HO9/0F/meVUwwFYc7azBweTI39DHL06hl2w9ztJEmpoykCDfxyzeLbJliYV7DSaKsBteHYCHeybGtav/hc5co+C3CY+RQC1U5CLldnqv0N4V20qa/eyRYbRMAbqTU5UVa4X88E1Sz9MLP8hYQRda56p2cccsnqrpAjOhipAEBwIIsdEyCykUdy7yLrWzxiJGEdjSOgdQE1DeJ+yXUKbI4djYKUwKHUiDQziCN1B4Ks7xql6BO4PZZgU1S14zvQqyL67YJPGIRycw6nCUBK4dl6wp9POq8mI7Td8ehh/vK6b/DkQxmZb4A1E4a0B0Yb6u4bA+3AK8FfJj69UGVvZqk9H6kRSlJTn1BZmGy5LkRfFTbVqdRv5xsEzMMrN3kjZtjTOPVtdAdAKmqLespS6Vcs+Mpwi/ZvNxybAYBRISkJwO5lljWuKyefxHBpu9FQqpveZ68eoJAPyoaB+Zrp5sN1cIIGgxkb1g3cMuH8k/e0/vvAnBqGgVkD7levgUc/hiahI4BiciSPDC6k+ru/xeklxptjs/3yxvvIxrXsL10a915NcPpio1CLOaKsC4mfEuYns9W6/iWVob+oap+Zyob0dccALq+xygsuzdoKIXK+Qx1mtI47nSWdKhCPf7bdZOc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3c44fa-159d-4439-1569-08db3cb41fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 06:47:32.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vr+3OzFE8+ej5g/03/pMymXPOV+1E00w2PMVgdjdPzmO4uMlVnQj62E2b3fXF1pUNgYSky9+qM9X8y+f0UYyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9775
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzA0LzIwMjMgMTQ6MDMsIEppbnB1IFdhbmcgd3JvdGU6DQo+Pj4gSSBjYW4gc2Vl
IHRoZSBwYXRoIGluY3JlYXNlIHVzZWNudCB0byAxLg0KPj4+DQo+Pj4gcnRyc19jcV9xcF9jcmVh
dGUgLT4gY3JlYXRlX3FwDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgIC0+IHJkbWFfY3JlYXRl
X3FwDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAtPiBpYl9jcmVhdGVfcXANCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPiBjcmVhdGVfcXANCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtPiBpYl9xcF91c2VjbnRfaW5jIHdoaWNoIGluY3JlYXNlcyBw
ZC0+dXNlY250DQo+Pj4NCj4+PiBXaGVyZSBpcyBhbm90aGVyIHBsYWNlIHRvIGluY3JlYXNlIHVz
ZWNudCB0byAyPw0KPj4gSXQgc2hvdWxkIGJlDQo+PiBpYl9jcmVhdGVfcXDjgIAuLi4NCj4+ICAg
ICAtPiByeGVfY3JlYXRlX3FwDQo+PiAgICAgICAtPiByeGVfcXBfZnJvbV9pbml0DQo+PiAgICAg
ICAgICAtPiByeGVfZ2V0KHBkKSA8PDwgcGQncyByZWZjbnQgd2lsbCBiZSBpbmNyZWFzZWQuDQo+
IElJVUMsIHRoaXMgcHJvYmxlbSBpcyByeGUgc3BlY2lmaWMsIGJlY2F1c2UgcnhlIG1hbmlwdWxh
dGUgcmVmY250DQo+IGl0c2VsZj8gSSBjaGVja2VkIG1seDUvbWx4NCB0aGV5IGRvIG5vdCBjaGFu
Z2UgdGhlIHJlZmNudCBvZiBwZCB3aGVuDQo+IGNyZWF0ZV9rZXJuZWxfcXAuDQo+IA0KPiBTbyBx
dWVzdGlvbiBpcyB0aGVuIGlmIHRoZSBidWcgaXMgb24gcnhlIHNpZGUgb3IgcnRycyBzaWRlPw0K
PiANCj4gWmhpamlhbiBob3cgZG8geW91IHJlcHJvZHVjZSB0aGUgd2FybmluZz8gZG8geW91IGlu
amVjdCBlcnJvciBleHBsaWN0bHk/DQoNCiMgY2F0IHJuYmQtc2VsZi5zaA0KIyEvYmluL2Jhc2gN
Cg0KL3Jvb3QvcnBtYS90b29scy9jb25maWdfc29mdHJvY2Uuc2ggZXRoMA0KbW9kcHJvYmUgcm5i
ZF9zZXJ2ZXINCm1vZHByb2JlIHJuYmRfY2xpZW50DQoNCndoaWxlIHRydWU7DQpkbw0KICAgICAg
ICAgZWNobyAic2Vzc25hbWU9eHl6IHBhdGg9aXA6PHNlcnZlci1pcD4gZGV2aWNlX3BhdGg9L2Rl
di9udm1lMG4xIiA+IC9zeXMvZGV2aWNlcy92aXJ0dWFsL3JuYmQtY2xpZW50L2N0bC9tYXBfZGV2
aWNlDQogICAgICAgICBmb3IgaSBpbiAvc3lzL2Jsb2NrL3JuYmQqL3JuYmQvdW5tYXBfZGV2aWNl
DQogICAgICAgICBkbw0KICAgICAgICAgICAgICAgICBlY2hvICJub3JtYWwiID4gJGkNCiAgICAg
ICAgIGRvbmUNCmRvbmU=
