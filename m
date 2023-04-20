Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712F6E87C0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Apr 2023 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDTCBH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 22:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjDTCAu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 22:00:50 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B623A90;
        Wed, 19 Apr 2023 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681956029; x=1713492029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6zJ1JiskA+IswUxB7ZyOAsffmrhmNvkBLbhJNIfm62Q=;
  b=f39GNtboLLfICqzQothzwc7ERI2eBH0gd+dTj4GzPxJcXmC0iscuLHdp
   JoXARqMjU0+yal5hGCMkglrt1vVy/2/lMge0b/rfpzBzNuhd1EmK1ewPl
   7WNKKHHhM10l0oE4ygnqZBvy26bhRMMNiKXIIc/E9oZ8+6PToxOd9dVvU
   ZuTXUK5dZMzb2Db2eDjJUlvUBESUHXHlf3T1NltB+Xf2VaJIbUxCVV1B4
   zkm0/87oweroObnMLqUREQVqT8Wd6Gl7D/Wc1fzPYJ+P685yahirt+8Go
   RYOit8XN9IF7FQlIjrplJdPz2b9okRyg61RMeAtCr6nzjw12sTGho3sFT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="90758036"
X-IronPort-AV: E=Sophos;i="5.99,211,1677510000"; 
   d="scan'208";a="90758036"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 11:00:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEV5qIQuhKwAr/BL5cob2cDWHmYsRCgxypxwwP5nLWJtg+zxg7Hbd1eTXvLPWJZwGqKgQmk+dIgAG1LyjS46ySKHYHSItpKkStEtceyOukHyk+MU607fzH2ZR2Jhe+12m8wWxiKQktSym5CjTHnm/guP19rT2KN1TiQiZmEt7TfuhjVoqLpVR9kOK/3I5pD0k25TQgpEcslncjpMll1tEUl10i6bhUWQhygaExduM+HxvwwoCs0/i1b4jzFgTkWXJuGfPuhhlUBC02zQ8rN7xWQ1RIIKiP0PS61obIlD+IqkQL0Gg5hihIh+Fkn0SK+3lMoD+ZhpJy1AWbhXxMsSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zJ1JiskA+IswUxB7ZyOAsffmrhmNvkBLbhJNIfm62Q=;
 b=H3hMmYFYV+5CM4s9Qnvkkb5rqxZfmvmHEgIAFLVKRtkAf29kxkMz4mCCiqlI4YLfv2Volg/xPRwOyJLKMI95sgrRpgH0kYaeWs53ZFZNvAQxm04OAsKvfw3vQhxuGCd2wAmURQqrVV8F7UOtJeEBq1GeYHZWn1JjN1y0Dec7CVKe2v5NulUy23I0NymMmfvX/M1yHpQNGZJ32FbV3tH1LTi7eJLB7mC4Qzdh9V8iK8srIxOKHPTuMFQ8giKOo3VX1ktyf5c9tZk7D6Y54zWJ7hQ5N/q+aVHldMRZfTsafaQE2/71XyBDBxNss2zTgd4gSz/oXauE+SVcMK5C1/UdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by OS0PR01MB5716.jpnprd01.prod.outlook.com
 (2603:1096:604:bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 02:00:19 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%7]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 02:00:19 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jinpu Wang <jinpu.wang@ionos.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCAgAEIcgCAANmvgIAADtcAgAGyw4CAADnvAIAA1EaA
Date:   Thu, 20 Apr 2023 02:00:19 +0000
Message-ID: <51b9e74d-70e0-3d76-ade9-93d960074ef9@fujitsu.com>
References: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
 <20230417180452.GG15386@unreal>
 <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com>
 <20230418075706.GB9740@unreal>
 <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com>
 <CAMGffEkyNnSXDfwuzCQ_ERZ-53OnoJ7gOF4eL1MAPYc74V43iQ@mail.gmail.com>
In-Reply-To: <CAMGffEkyNnSXDfwuzCQ_ERZ-53OnoJ7gOF4eL1MAPYc74V43iQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|OS0PR01MB5716:EE_
x-ms-office365-filtering-correlation-id: e7019fd3-2f0a-476d-7946-08db4142fe67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvL523tQhU0xvMaibkhKSEnn3IKt4L5AeHVw0nCmczkjaPX5y0cjOUrHE5+z2PB/mE5W8esjAbkiLYym4lCnS4goGe1qDTh0ic0hgaDM0kkNOcmAslByxoGyz//h6E3tXYzMxcGUMOiuKWET/1fwSS1w0Oq8CmoUglFZxAkBF2p09gllfuZ8VDh7pWGW2j/iHgeggx2T2AqjtU/WOPldJR4645bY5zVNQPHUOoMamphegsoUWn+pEyE1hLolCCFG+dsikVxdoDrrByJcOAILP1vBeK76TDjDqRtzHynzKkllml0Xgnvsugnx2gbBMkHHPGHXSHFlYcKX6KKAa+m/CkeuhamSUJo2zaf/f98NaJCqV0m12Fx0hGjFqaGKA6jW5Sps6JMEgZePBBqYE+BTwQRnxCcjAEpgoeuqfAJV+NdBwoszscbWcagYBaqTQoa9xrJJxAZF5r/meM1eZmwnwsxbArIeflOgOq11qJR+tBfeAlU/+W8k/8pPucxd4hbLLnZ846G6fbkGhQA2coic9Z8NZ87EyonIwRhX91FZfGZ5m1MC0QFvJfQonPKOSI00RGDHU464lDRSWA6QRHybr0nHBja6yS/CxwPepYMX5s1b7Rkg8/qMG3OT8P0b0K4To+upHFnWyLGo7CrE9CBAX7nj8j+1EkAtWN5AqoAjSG/bveqSVQVKRrNY+if4lCCgMjhurD6P6yU2bMXz0zkaOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(1590799018)(451199021)(2616005)(83380400001)(85182001)(31686004)(2906002)(38070700005)(186003)(36756003)(5660300002)(8676002)(53546011)(8936002)(6506007)(6512007)(26005)(38100700002)(122000001)(6486002)(41300700001)(71200400001)(66899021)(82960400001)(316002)(45080400002)(1580799015)(66946007)(66556008)(76116006)(31696002)(64756008)(478600001)(66446008)(66476007)(91956017)(6916009)(86362001)(4326008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekI4OXpmUzdLRGl4cURaR25mcGE5NXkyMGEveHh4UW55R2FNeHhZVnNrcnhH?=
 =?utf-8?B?S2kyYmptZFhXUFIwSEllci9IMENzYmx2RDdzN2pNTWE0amlhbDQ5ZUhoYUs1?=
 =?utf-8?B?bkFwbk80YjJFYjFSd3hTK3J0NlJMd0dET3dyellyd0VNaDIvVUM4MW9GV1hz?=
 =?utf-8?B?YUkza0lnUkk5TXdPZXoyeCtkenY2MXFrUzJFSFFtNGd6c3BKVkVrd3pRM3Ew?=
 =?utf-8?B?b2F0aEJnQmtGS3pkQ1YwcVBpSDdEUXh0UzlUQ1V2SW9QbVFzZTdkemFqekZB?=
 =?utf-8?B?T3VvU2lWTWR6SXBsOTRwcFJYMnJoc1d5U0ZSQ0NET2Rtak1IbWU1bFFndWdu?=
 =?utf-8?B?L2VyVVcrNmYrR0h5TmF6dVVaNHVmYVJVYm1wT1RXdFlmVGlQR0hwaXFhRWYv?=
 =?utf-8?B?RzR3NzYyeVE4eXBkNlg0TzF2a2hsVkQ2d1pDdFgySG9YSVg2RElCSVpmZkhN?=
 =?utf-8?B?VWlUbHZ4djlraGF6bmwxRlJhdk5HOTJGNGd3cFFEYnYxc0RsV05wT1lQYm1q?=
 =?utf-8?B?QWlZaDZLT014WFd4ejRBNzgvaHdPR3hxekNxRVQvU2U3L3pEZHMxckdpUjlU?=
 =?utf-8?B?MEUveWlhckJTSzAxTWZqalhYeEh5UDNwL0krQUdHNThkcXBaKzZ1RllaK01Y?=
 =?utf-8?B?ZHRqU09LUTZ6V0pCSEVsc2JxemppNXdSWkZuN3p3NDFDSmEzaysyZlI1aUZE?=
 =?utf-8?B?U3BMY20zcXdHcmI5RkZPR2VlWTVjdEJ2bEgwSFhHYjliWStlQW55UEtZK2dk?=
 =?utf-8?B?R0JRM2tlTVFkc1cwbjJyS2t0MmwrNzlmT0k0b1NuYUJiQTZBYzllRHhKdDhW?=
 =?utf-8?B?NG9MQ3ZEc3ZOSWZWU2VKbkszTmcrMkRPNHJKdElBc1Q1RGVzRlhwTzVLazZT?=
 =?utf-8?B?azNtdFZTTmZuS0RNZE5weHVHOUlBM1h0MTd4MHY4Sk56clpzQ2E3RUhpUVJH?=
 =?utf-8?B?U2ZjR2dxdXp4QkgwMi9TSnZoZDQ1WjRtZUgrckV2V3Z6VG82SEc3dE05S2tr?=
 =?utf-8?B?cVVuRXNvSzZLWS9NbXVnRXVQeDJlUjljZThOeE45N2cwQ3N4c21sRGs4NjJy?=
 =?utf-8?B?Ym9oTU84eTExZy9MZXhmMUVSZlczRWdmSy9Sd0xvNFZocUdoZ2lNL3V1bjg2?=
 =?utf-8?B?TWhtQlk4bEJ3SmJHdnBXQTN0NTFodHBxWHpwTE9aaFFxUWh3MlVwVllaWUNj?=
 =?utf-8?B?OS9IWTZPTlFZMGJqTlBCZCsvL2VzRTlMaDlRamxBdlBubWFId3B4VFpCU1ZV?=
 =?utf-8?B?Nm5wbVIwbHdlYzdpRUFvRTJ0aGlwdDRMRzE5L3RBU2U5bmRGSFVDbHFtaDJp?=
 =?utf-8?B?OUExY2MvTHpEYThTUVlNK1FScmZJR1ppakhscUZqVjhnREF5dGJZTjdGNnV2?=
 =?utf-8?B?UGY1bkx1a3JCdWxjejBCZUVtUkhVVTJFZ0ZNSytGSEZLemhrZzdOQzlXcUlh?=
 =?utf-8?B?aWFTRzAxcEZEUFhBcnNRVGxQTFc5ZXdpaldhYnFYUS9zS2JkRzNFdE9KY3BI?=
 =?utf-8?B?WjlRUGFEL1BsYTRuM01LS2g3bnEyWGhEUit4UkdWL2twV245dWZ5bkhaVkJU?=
 =?utf-8?B?aHUrWElCYXdpM3ZJQ2kyM0pLK1M0blgrRGxua05xZEhoM3VTY3pTbEttenZ6?=
 =?utf-8?B?UllNVWFvQ24vZG9FMUFjTTA0dnUwNVlIM25YdTRTd0lDZ0Q2aVgyNGkyWkhw?=
 =?utf-8?B?QXk1VHN5cGVIR2hFWGd0NSsxOXErVTU1R3Bpa2J6Wi82NjZqZjFTNUJuR3k3?=
 =?utf-8?B?cVk0eVhnTkxtMHN6YzZOa2x0Z3ZNdVA2ZkZRVVBFemRMeVpKaGVwS2hudVRa?=
 =?utf-8?B?UTlsYnVPWmZIZjhMeDgvOUFEek50cnBvekVEK1p1RUpjd21aTG0yQ3hHOVdZ?=
 =?utf-8?B?dXlsVm5raTVSQzRLYzdjcUVOOHVBSDB5bkJUVnExbE5VL2VEaWUxaStzL1po?=
 =?utf-8?B?dnVhY01qaU4wbEd2U1podWlwVnVtUW1VWk8rWUlaWFRmS25QcEEwR2VRdjNB?=
 =?utf-8?B?MkIxZ1kzbHhzWWlvSmZScUc5TmNVMm0vRnNFcDk1ZWtLQUtrRDdXeFovS0xi?=
 =?utf-8?B?K0xEL0NjSkh5TWJwNlRQNWN5ZmRnVjRFTGViaCtQdDVzRzRTVVh4dFRqUC91?=
 =?utf-8?B?TG1qeE1GdWFsVHN4NUI1R1pQb0grRmN1UUM2SEx4V08vWXhxWnkxVVVpRDBH?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <906544B6B7635A4FA149ACD4349478EC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ySft3cTQoDSOYsRV7cdhmsQPe+x1kQeX3h8xkSup/WV4RpHZX+OURxpZUWi496DVnPkD47oA/w/5atnwUFFvQanFC9F6GFh5Qwb5Ro5OYGDZExzfmsOpABlEA40Sy+t45MPr/ZZ9LL4biVN61fFzbCe+FGkUiMoNSBI9We7a/jyt3MvbCEbi8UcR0ZFle64ZszDmcYNgQQKZOU9hH4UO/cKg/z5+Jf6z9VkdN7nywj8bTlhXDTQ95nW8r/ATPxsNa6dvLbtT6MFnOfm9fny679gKJqkjjVXOrQCv+BkVfH0dkGb80Wa4SVjKA2koX+ptqTsj8rHKCmE4rUUPp9DrspoFV3ZUH4Mg7z86cUyYlgjnBwvhq342GxzTa7ke7r4GYR/IPkvWA6Pd/N8axr+FMfguaQJDH81CM4qTshUjA7eKEW13DLad2YRY8F+cG/hwemo00RHiMtjHZNYBCsa0kZ95b6Edac2OZm6mVdFJnVD6nWkUdnqZM8PGjZo/e9VGQSGaS2LOwZLWiXc4Ohd23uKeZriCSofYJxz1mb+FX3JsNVOyweY/ie0nXKoYrGkjFmEtoYzM27DYMrtuJ3B3AnOtWeTjhzEWRDuBP5CO94K2rxgQ4JZZr7eKcAufQBByn5m3pdRmJmSCGglbqv0riKFLp7/poc3YW1YIg5CgsGAXHD/WhJibMi0kW7VlW/d8fsiSaflQTsTFQM4CSb9+WbBAc9IC97QJBEt9OtvLjSKffbvvzWoqbSoLA+y8gJt6qyQAVlYm9tSLraiLQSilbuNcQxtj1b4agXk3wdM+GopDO3+D6uqobjXyt8e4B8WLfyO0gaO86C/5lir3thzEgkrMmL0Aok494If3zojLSqRiXhBwt9JN+Qjzpzm9Jbve
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7019fd3-2f0a-476d-7946-08db4142fe67
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 02:00:19.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWQsgEDI7wAbBl2gDpsLlzWotLlsM2H32eo7ZMlkXdovYPMUWHX9FJjV4nu+Viz6cNAtqm+PHBXiii7bj/Ep5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5716
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE5LzA0LzIwMjMgMjE6MjAsIEppbnB1IFdhbmcgd3JvdGU6DQo+IE9uIFdlZCwgQXBy
IDE5LCAyMDIzIGF0IDExOjUz4oCvQU0gWmhpamlhbiBMaSAoRnVqaXRzdSkNCj4gPGxpemhpamlh
bkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pg0KPj4gTGVvbiwgR3VvcWluZw0KPj4NCj4+DQo+PiBP
biAxOC8wNC8yMDIzIDE1OjU3LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+Pj4gQ3VycmVu
dGx5LCB3aXRob3V0IHRoaXMgcGF0Y2g6DQo+Pj4+Pj4gMS4gUEQgYW5kIGNsdF9wYXRoLT5zLmRl
diBhcmUgc2hhcmVkIGFtb25nIGNvbm5lY3Rpb25zLg0KPj4+Pj4+IDIuIGV2ZXJ5IGNvbltuXSdz
IGNsZWFudXAgcGhhc2Ugd2lsbCBjYWxsIGRlc3Ryb3lfY29uX2NxX3FwKCkNCj4+Pj4+PiAzLiBj
bHRfcGF0aC0+cy5kZXYgd2lsbCBiZSBhbHdheXMgZGVjcmVhc2VkIGluIGRlc3Ryb3lfY29uX2Nx
X3FwKCksIGFuZCB3aGVuDQo+Pj4+Pj4gICAgICAgIGNsdF9wYXRoLT5zLmRldiBiZWNvbWUgemVy
bywgaXQgd2lsbCBkZXN0cm95IFBELg0KPj4+Pj4+IDQuIHdoZW4gY29uWzFdIGZhaWxlZCB0byBj
cmVhdGUsIGNvblsxXSB3aWxsIG5vdCB0YWtlIGNsdF9wYXRoLT5zLmRldiwgYnV0IGl0IHRyeSB0
byBkZWNyZWFzZWQgY2x0X3BhdGgtPnMuZGV2IDw8PCBpdCdzIHdyb25nIHRvIGRvIHRoYXQuDQo+
Pj4+PiBTbyBwbGVhc2UgZml4IGl0IGJ5IG1ha2luZyBzdXJlIHRoYXQgZmFpbHVyZSB0byBjcmVh
dGUgY29uWzFdIHdpbGwNCj4+Pj4+IHJlbGVhc2UgcmVzb3VyY2VzIHdoaWNoIHdlcmUgYWxsb2Nh
dGVkLiBJZiBjb25bMV0gZGlkbid0IGluY3JlYXNlDQo+Pj4+PiBzLmRldl9yZWYsIGl0IHNob3Vs
ZG4ndCBkZWNyZWFzZSBpdCBlaXRoZXIuDQo+Pj4+IFlvdSBhcmUgcmlnaHQsIHRoZSBjdXJyZW50
IHBhdGNoIGRpZCBleGFjdGx5IHRoYXQuDQo+Pj4+IEl0IGludHJvZHVjZWQgYSBjb24gb3duaW5n
IGZsYWcgJ2hhc19kZXYnIHRvIGluZGljYXRlIHdoZXRoZXIgdGhpcyBjb24gaGFzIHRha2VuIHMu
ZGV2Lg0KPj4+PiBzbyB0aGF0IGl0cyBjbGVhbnVwIHBoYXNlIHdpbGwgb25seSBkZWNyZWFzZSBp
dHMgcy5kZXYgcHJvcGVybHkuDQo+Pj4gVGhlIGhhc19kZXYgaXMgYSB3b3JrYXJvdW5kIGFuZCBu
b3QgYSBzb2x1dGlvbi4gSW4gcHJvcGVyIGVycm9yIHVud2luZA0KPj4+IHNlcXVlbmNlLCB5b3Ug
d29uJ3QgbmVlZCBleHRyYSBmbGFnLg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4+DQo+PiBob3cg
YWJvdXQgYmVsb3cgY2hhbmdlcw0KPj4NCj4+IGNvbW1pdCA2MWRiYTcyNTM4NGUyMjZkNDcyYjgx
NDJkNzBkNDBkNDEwM2RmODdhDQo+PiBBdXRob3I6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCj4+IERhdGU6ICAgV2VkIEFwciAxOSAxNzo0MjoyNiAyMDIzICswODAwDQo+Pg0K
Pj4gICAgICAgUkRNQS9ydHJzOiBGaXggcnhlX2RlYWxsb2NfcGQgd2FybmluZw0KPj4NCj4+ICAg
ICAgIGNvblswXSBhbHdheXMgc2V0cyBzLmRldiB0byAxLCBjb3JyZXNwb25kaW5nbHksIHdlIHNo
b3VsZCBsZXQgaXQgdG8NCj4+ICAgICAgIHJlbGVhc2UgdGhlIGxhc3QgZGV2Lg0KPj4NCj4+ICAg
ICAgIFByZXZpb3VzbHksDQo+PiAgICAgICAxLiBQRCBhbmQgY2x0X3BhdGgtPnMuZGV2IGFyZSBz
aGFyZWQgYW1vbmcgY29ubmVjdGlvbnMuDQo+PiAgICAgICAyLiBldmVyeSBjb25bbl0ncyBjbGVh
bnVwIHBoYXNlIHdpbGwgY2FsbCBkZXN0cm95X2Nvbl9jcV9xcCgpDQo+PiAgICAgICAzLiBjbHRf
cGF0aC0+cy5kZXYgd2lsbCBiZSBhbHdheXMgZGVjcmVhc2VkIGluIGRlc3Ryb3lfY29uX2NxX3Fw
KCksIGFuZCB3aGVuDQo+PiAgICAgICAgICBjbHRfcGF0aC0+cy5kZXYgYmVjb21lIHplcm8sIGl0
IHdpbGwgZGVzdHJveSBQRC4NCj4+ICAgICAgIDQuIHdoZW4gY29uWzFdIGZhaWxlZCB0byBjcmVh
dGUsIGNvblsxXSB3aWxsIG5vdCB0YWtlIGNsdF9wYXRoLT5zLmRldiwNCj4+ICAgICAgICAgIGJ1
dCBpdCB0cnkgdG8gZGVjcmVhc2VkIGNsdF9wYXRoLT5zLmRldiA8PDwgaXQncyB3cm9uZyB0byBk
byB0aGF0Lg0KPj4NCj4+ICAgICAgIFRoZSB3YXJuaW5nIG9jY3VycyB3aGVuIGRlc3Ryb3lpbmcg
UEQgd2hvc2UgcmVmZXJlbmNlIGNvdW50IGlzIG5vdCB6ZXJvLg0KPj4gICAgICAgUHJlY29kaXRp
b246IGNsdF9wYXRoLT5zLmNvbl9udW0gaXMgMi4NCj4+ICAgICAgIFNvIDIgY20gY29ubmVjdGlv
biB3aWxsIGJlIGNyZWF0ZWQgYXMgYmVsb3c6DQo+PiAgICAgICBDUFUwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTENCj4+ICAgICAgIGluaXRfY29ubnMg
eyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgY3JlYXRlX2NtKCkg
Ly8gYS4gY29uWzBdIGNyZWF0ZWQgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIGEnLiBydHJzX2NsdF9yZG1hX2NtX2hhbmRsZXIo
KSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIHJ0cnNfcmRtYV9hZGRyX3Jlc29sdmVkKCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICBjcmVhdGVfY29uX2NxX3FwKGNvbik7IDw8
IGNvblswXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgfQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCBpbiB0aGlzIG1vbWVudCwgcmVmY250IG9mIFBEIHdhcyBpbmNyZWFzZWQgdG8gMisNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAg
ICAgICAgY3JlYXRlX2NtKCkgLy8gYi4gY2lkID0gMSwgZmFpbGVkICAgICAgIHwNCj4+ICAgICAg
ICAgICBkZXN0cm95X2Nvbl9jcV9xcCgpICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAg
ICAgIHJ0cnNfaWJfZGV2X3B1dCgpICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAg
ICAgZGV2X2ZyZWUoKSAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAg
ICBpYl9kZWFsbG9jX3BkKGRldi0+aWJfcGQpIDw8IFBEIHwNCj4+ICAgICAgICAgICAgICAgICAg
aXMgZGVzdHJveWVkLCBidXQgcmVmY250IGlzICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgc3Rp
bGwgZ3JlYXRlciB0aGFuIDAgICAgICAgICAgIHwNCj4+ICAgICAgIH0NCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYw0KPj4gaW5kZXggODBhYmY0NWExOTdhLi4xZWI2
NTJkZWRjYTMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRy
cy1jbHQuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMN
Cj4+IEBAIC0xNzQzLDYgKzE3NDMsMTUgQEAgc3RhdGljIHZvaWQgZGVzdHJveV9jb25fY3FfcXAo
c3RydWN0IHJ0cnNfY2x0X2NvbiAqY29uKQ0KPj4gICAgICAgICAgICAgICAgICAgY29uLT5yc3Bf
aXVzID0gTlVMTDsNCj4+ICAgICAgICAgICAgICAgICAgIGNvbi0+cXVldWVfbnVtID0gMDsNCj4+
ICAgICAgICAgICB9DQo+PiArDQo+PiArICAgICAgIC8qDQo+PiArICAgICAgICAqIEV2ZXJ5IGNv
biB3aWxsIHRyeSB0byBkZWNyZWFzZWQgcy5kZXZfcmVmLCBidXQgd2Ugc2hvdWxkDQo+PiArICAg
ICAgICAqIHJlc2VydmUgdGhlIGxhc3Qgcy5kZXZfcmVmIGZvciBjb25bMF0uIEluIGNhc2UgY29u
WzErXSdzDQo+PiArICAgICAgICAqIGNsZWFudXAgcGhhc2UgY2FsbCBydHJzX2liX2Rldl9wdXQo
Y2x0X3BhdGgtPnMuZGV2KSBlYXJseS4NCj4+ICsgICAgICAgICovDQo+PiArICAgICAgIGlmIChj
b24tPmMuY2lkICE9IDAgJiYgY2x0X3BhdGgtPnMuZGV2X3JlZiA9PSAxKQ0KPj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsNCj4+ICsNCj4+ICAgICAgICAgICBpZiAoY2x0X3BhdGgtPnMuZGV2X3Jl
ZiAmJiAhLS1jbHRfcGF0aC0+cy5kZXZfcmVmKSB7DQo+PiAgICAgICAgICAgICAgICAgICBydHJz
X2liX2Rldl9wdXQoY2x0X3BhdGgtPnMuZGV2KTsNCj4+ICAgICAgICAgICAgICAgICAgIGNsdF9w
YXRoLT5zLmRldiA9IE5VTEw7DQo+IA0KDQpKaW5wdSwgdGhhbmtzIGZvciB5b3VyIHRlc3Rpbmcu
DQoNCkluZGVlZCwgYWJvdmUgY2hhbmdlcyBhcmUgbm90IGNvcnJlY3QuIGl0IGJyZWFrcyB0aGUg
bm9ybWFsIGNsZWFudXAgbGlrZSBiZWxvdzoNCmZvciAoaT0wOyBpIDwgTiwgaSsrKQ0KICAgZGVz
dHJveV9jb25fY3FfcXAoY29uW2ldKQ0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IEkgcnVuIGEg
cmVncmVzc2lvbiB0ZXN0IGluIG91ciB0ZXN0IGVudiwgaXQgdHJpZ2dlcnMgYSB3YXJuaW5nIG9u
DQo+IA0KPiAxNjgxICAgICAgICAgICAgICAgICBpZiAoV0FSTl9PTihjbHRfcGF0aC0+cy5kZXYp
KQ0KPiANCj4gWyAxMzMzLjA0MjYzM10gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0t
LS0tDQo+IFsgMTMzMy4wNDI2NTBdIFdBUk5JTkc6IENQVTogOCBQSUQ6IDU1OSBhdA0KPiAvcm9v
dC9rZXJuZWwtdGVzdC9pYm5iZDIvcnRycy9ydHJzLWNsdC5jOjE2ODENCj4gcnRyc19jbHRfcmRt
YV9jbV9oYW5kbGVyKzB4ODY0LzB4OGEwIFtydHJzX2NsaWVudF0NCj4gWyAxMzMzLjA0MjY1MV0g
TW9kdWxlcyBsaW5rZWQgaW46IGxvb3Agcm5iZF9jbGllbnQoTykgcnRyc19jbGllbnQoTykNCj4g
cnRyc19jb3JlKE8pIGt2bV9hbWQga3ZtIGlucHV0X2xlZHMgbGVkX2NsYXNzIGlycWJ5cGFzcyBj
cmMzMl9wY2xtdWwNCj4gYWVzbmlfaW50ZWwgc3A1MTAwX3RjbyBldmRldiBsaWJhZXMgd2F0Y2hk
b2cgc2cgazEwdGVtcCBjcnlwdG9fc2ltZA0KPiBmYW0xNWhfcG93ZXIgaXBtaV9zaSBzZXJpb19y
YXcgY3J5cHRkIGlwbWlfZGV2aW50ZiBnbHVlX2hlbHBlcg0KPiBpcG1pX21zZ2hhbmRsZXIgYWNw
aV9jcHVmcmVxIGJ1dHRvbiBpYl9pcG9pYiBpYl91bWFkIG51bGxfYmxrIGJyZA0KPiByZG1hX2Nt
IGl3X2NtIGliX2NtIGlwX3RhYmxlcyB4X3RhYmxlcyBhdXRvZnM0IHJhaWQxMCByYWlkNDU2DQo+
IGFzeW5jX3JhaWQ2X3JlY292IGFzeW5jX21lbWNweSBhc3luY19wcSBhc3luY194b3IgYXN5bmNf
dHggeG9yDQo+IHJhaWQ2X3BxIGxpYmNyYzMyYyByYWlkMSByYWlkMCBsaW5lYXIgbWx4NF9pYiBt
ZF9tb2QgaWJfdXZlcmJzIGliX2NvcmUNCj4gc2RfbW9kIHQxMF9waSBjcmNfdDEwZGlmIGNyY3Qx
MGRpZl9nZW5lcmljIGFoY2kgbGliYWhjaQ0KPiBjcmN0MTBkaWZfcGNsbXVsIGNyY3QxMGRpZl9j
b21tb24gY3JjMzJjX2ludGVsIGlnYiBsaWJhdGEgdXNiX3N0b3JhZ2UNCj4gcHNtb3VzZSBpMmNf
cGlpeDQgaTJjX2FsZ29fYml0IG1seDRfY29yZSBkY2Egc2NzaV9tb2QgaTJjX2NvcmUgcHRwDQo+
IHBwc19jb3JlDQo+IFsgMTMzMy4wNDI3MzddIENQVTogOCBQSUQ6IDU1OSBDb21tOiBrd29ya2Vy
L3UxMjg6MSBUYWludGVkOiBHDQo+ICAgIE8gICAgICA1LjEwLjEzNi1wc2VydmVyLWRldmVsb3At
NS4xMCAjMjU3DQo+IFsgMTMzMy4wNDI3MzhdIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gSDhR
RzYvSDhRRzYsIEJJT1MgMy4wMCAgICAgICAwOS8wNC8yMDEyDQo+IFsgMTMzMy4wNDI3NTJdIFdv
cmtxdWV1ZTogcmRtYV9jbSBjbWFfd29ya19oYW5kbGVyIFtyZG1hX2NtXQ0KPiBbIDEzMzMuMDQy
NzU4XSBSSVA6IDAwMTA6cnRyc19jbHRfcmRtYV9jbV9oYW5kbGVyKzB4ODY0LzB4OGEwIFtydHJz
X2NsaWVudF0NCj4gWyAxMzMzLjA0Mjc2MV0gQ29kZTogZmYgYmIgZWEgZmYgZmYgZmYgZTggZGIg
YTUgMjQgZmMgNDkgOGQgYjQgMjQgMTANCj4gMDEgMDAgMDAgODkgZGEgNDggYzcgYzcgNDAgOTMg
NWIgYzAgZTggNGIgNDcgMjEgZmMgNGQgOGIgNjUgMDAgZTkgMTUNCj4gZmUgZmYgZmYgPDBmPiAw
YiA0YyA4OSBmZiBiYiBlYSBmZiBmZiBmZiBlOCBhZCBhNSAyNCBmYyBlYiBkMCAwZiAwYiA0Yw0K
PiA4OSBmZg0KPiBbIDEzMzMuMDQyNzYzXSBSU1A6IDAwMTg6ZmZmZmFmZjY4ZTU3YmRiMCBFRkxB
R1M6IDAwMDEwMjg2DQo+IFsgMTMzMy4wNDI3NjVdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6
IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiBmZmZmOWVkZGMwMDUxNDIwDQo+IFsgMTMzMy4wNDI3Njdd
IFJEWDogZmZmZjllZTRlZjcxNmU0MCBSU0k6IGZmZmY5ZjE0ZWEyODhmMzAgUkRJOiBmZmZmOWVk
ZGM4OGRiMjQwDQo+IFsgMTMzMy4wNDI3NjhdIFJCUDogZmZmZmFmZjY4ZTU3YmU1MCBSMDg6IDAw
MDAwMDAwMDAwMDAwMDAgUjA5OiAwMDZkNjM1ZjYxNmQ2NDcyDQo+IFsgMTMzMy4wNDI3NjldIFIx
MDogZmZmZmFmZjY4ZTU3YmU2OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmOWVkZGUx
Mzg4MDAwDQo+IFsgMTMzMy4wNDI3NzFdIFIxMzogZmZmZjllZGRjODhkYjIwMCBSMTQ6IGZmZmY5
ZWRkZTEzODgwMDAgUjE1OiBmZmZmOWVkZGM4OGRiMjQwDQo+IFsgMTMzMy4wNDI3NzNdIEZTOiAg
MDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOWVlY2M3YzAwMDAwKDAwMDApDQo+IGtubEdT
OjAwMDAwMDAwMDAwMDAwMDANCj4gWyAxMzMzLjA0Mjc3NF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbIDEzMzMuMDQyNzc2XSBDUjI6IDAwMDA3
ZjBhYzRlZDQwMDQgQ1IzOiAwMDAwMDAyYjUwNDBhMDAwIENSNDogMDAwMDAwMDAwMDA0MDZlMA0K
PiBbIDEzMzMuMDQyNzc3XSBDYWxsIFRyYWNlOg0KPiBbIDEzMzMuMDQyNzkwXSAgPyBuZXdpZGxl
X2JhbGFuY2UrMHgyNWUvMHgzYzANCj4gWyAxMzMzLjA0Mjc5NV0gID8gcHNpX2dyb3VwX2NoYW5n
ZSsweDQzLzB4MjMwDQo+IFsgMTMzMy4wNDI4MDFdICA/IGNtYV9jbV9ldmVudF9oYW5kbGVyKzB4
MjMvMHhiMCBbcmRtYV9jbV0NCj4gWyAxMzMzLjA0MjgwN10gIGNtYV9jbV9ldmVudF9oYW5kbGVy
KzB4MjMvMHhiMCBbcmRtYV9jbV0NCj4gWyAxMzMzLjA0MjgxNF0gIGNtYV93b3JrX2hhbmRsZXIr
MHg1YS8weGIwIFtyZG1hX2NtXQ0KPiBbIDEzMzMuMDQyODE5XSAgcHJvY2Vzc19vbmVfd29yaysw
eDFmMy8weDM5MA0KPiBbIDEzMzMuMDQyODIyXSAgd29ya2VyX3RocmVhZCsweDJkLzB4M2Mw
