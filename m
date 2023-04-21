Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803996EA110
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 03:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDUBiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Apr 2023 21:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDUBiT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Apr 2023 21:38:19 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16293AAE;
        Thu, 20 Apr 2023 18:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682041098; x=1713577098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V5G25yZ3L5X50zBtbZNYwrOysJ6RsAmjajwOdnmcSUY=;
  b=ZYY8CvimlCtuVclJmV0j78ZFMAIcfNerU+KgMNRdgiwKHcqows/RWWOo
   nJwue2V15hZ7gB3SQpelrrD8WOMnmn4csXBtAVc/DaMPN6EDoItsvrBJa
   BzqWNyulccib7+qs+bDUABeTUFV+PbOkqYCDAVhwTYWFAPmqJNIyNGzoQ
   TY2QBmYsoSU1yaQBQf8YJfjtV9AfVPg9mqgpElKyXC09Lhlla7hEElyne
   302Lplza2euQZYcjYhgzkM9PO5a4LhXJC/jWNSOMFiJ7oiGeV7bc595BP
   oE8mFmbbRaIzksAXjiDkwuGKrj1zcc66mEjwZfOS5mIcMt/AWEEqcI9bT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="82531464"
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="82531464"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 10:38:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORYtO/KXJENgjSeftXbHxy8WQQCC0jEccfQotAQaUjtv2OVWGjMWzlTcbe5FdyHrwKTxbAjsDjy7PtuLSEorYrC1D+YfHV7c4X1SW31Ut9kfNUvsgX2saPgBE5V1sHqCTfqxoM3mUf8deXAuKDkA3RQtNYLx9xjXDT0C5QMnOGoJU2ry0LQ49nXJEBva+EjlW2DFiQ7Lym1Dr78IKYfzh2AAzIQky5JBNoT2qJkLRg4DbRmbVO1Fh2ttvpd8pDOuSdvXnrTElnBSrFih1gS58gwPOjjN2ABf+Lt3T6m8N3qeJ9pkbtg2qLVpErOAUwqJIMWyKbe0L9VBs/npze9+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5G25yZ3L5X50zBtbZNYwrOysJ6RsAmjajwOdnmcSUY=;
 b=By4qGFjW0V7O5kvrAquSUIsbcyF4FF/kE2BIp5/qMzmuZqBUeHdDQewobUVJdT4DSGNlBHvtdtDoYTQtt1JMGhulBpth++fl0jNPPQa1EdWZFK6Q7zAcg1TWF0+8X0mkdj4LU4ga4+fCixr7BrkcsAl/51eDTm8b6PCjgEFM1ZIfeQmKSmCBj6Fk8NIDUGAPttCFLcIdCsmH+nMjNaSohrw4jdnQ49EQz+50y0uWEPa+yS1+OFcnK+OFhR/ioSudl8RFTmZc2JtLO/H8sdXIf4F6Yfpd5Kqxp+8GMOSqnckmxHueLtQI4Z/ySB0ssmwiPnurO3PAQqTSaqjGe0sZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB5984.jpnprd01.prod.outlook.com (2603:1096:400:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 01:38:10 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 01:38:10 +0000
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
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCAgAEIcgCAANmvgIAADtcAgAGyw4CAADnvAIAA1EaAgAGMJoA=
Date:   Fri, 21 Apr 2023 01:38:10 +0000
Message-ID: <00202749-1b0d-91c8-9a52-cf8a66d8d340@fujitsu.com>
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
 <51b9e74d-70e0-3d76-ade9-93d960074ef9@fujitsu.com>
In-Reply-To: <51b9e74d-70e0-3d76-ade9-93d960074ef9@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB5984:EE_
x-ms-office365-filtering-correlation-id: 3a5029d3-ac44-4d48-0e20-08db420910dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ol2j2EmtTTc74pHAgYcz+cB9e/IxiUMB2FHE0w4ublFXBwancPQeyLKKXjFQas08tUs24Od+oQ8LACHqAYQW9A4Qt98ApqXCkGn/09ZIMuUU2PpvfUR3Ns9B0gORyZ6KUrnH3mi1p65tjPYfo8mdA9qvfVaNbVYlUB1aOWN8Nnl0ldZVvLJtWYW+0bWCsO56ZroJcD5EJnmk9JUSWM72KGB3e0sQIYguEb+3Zpz6dWNyVEBkQ4u/XXcX8LkDCAEoTJe6gG3+opYoQ1iizBSfrwdxXd/YUwlMeZNMpZB9S7ScWpF2XfGQxJJxGtAq/7VJJdLjfbs3ykjkky7iGVkyzRFM6KIucLA7/sTBVtTM9o7MzphqEkCbTTjAh1Q36QvTpcgMmzZqVNdZnBvMuQ3eI9DkKrIw4qORSN78V1wkTGWk361O4aoI/D5jiMXVVfM7QpaWp02D6/i7jLtxqCWo/tWrz3Y3cUtVwua/oefWUiWcCgysn2aTMqpzdFPQTCPeR5xGhb8lj0rW+Rq+MeCpFItMi9tzvioh1Keat6NOwEW6zrFpFLQviT1+oLTB+BOODr262unEh9TpChrE/SVXeXvxkNeXPpL+zg4Mkb9NjbY0qsTePovXr2GJrsFrho0u9hwlUbJVViJNXnXf/m1DwSdfkXulUMGi7zJJGhjn2jmML8AaU/lSDGdgeB+XX8yveNjYbmPlfP4iHfuVTiDEyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(1590799018)(451199021)(316002)(66556008)(66476007)(64756008)(66446008)(66946007)(66899021)(76116006)(6916009)(4326008)(91956017)(86362001)(478600001)(31696002)(71200400001)(54906003)(6486002)(85182001)(36756003)(8936002)(8676002)(38100700002)(31686004)(122000001)(5660300002)(2616005)(83380400001)(82960400001)(41300700001)(2906002)(26005)(53546011)(6512007)(6506007)(38070700005)(1580799015)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0Y5TjE1LysrV0toVEtUY2ZwRHVzd1VkSnJIZ0UxVDVRY3AzU3hDR1hIRnIv?=
 =?utf-8?B?Kyt0QWZUaGtmdnJFbTBjUU5Sc1pCSVN1L3daaWJuNjZjZGhkdkk5NEJBRDVV?=
 =?utf-8?B?Zm9nUlNaTWpkS3hRNmhERWp0Wkt6QWtQZGlmdEQydlkrM1I2Mk8zbXFZM29q?=
 =?utf-8?B?aE0rMGVSOHNBbTdDNGFpMHExVlNPOFJmZ2NPNFM1VE9QQnBNR2tsL0VQREZL?=
 =?utf-8?B?SHVjbUo2VStabWRDVGVBaVdIUW5MV2luSlhIVGl6dFFtaDFvZ2UyOGk2aGR1?=
 =?utf-8?B?RmZXaXViRGNqK2dUVTAwS1pJSHNCN0pWSGdSQmgvR2JJc2lvVElrMTNRZm85?=
 =?utf-8?B?ZHFVbzNrR1V1Nnd5UUFQVldsVkNjcVhoSk1FcmVDY0ZGQjZyTDQ4VFZ3Tkgv?=
 =?utf-8?B?aWFPNmJmTDV6WnVjNFN2VWFoL0w2aDRyeTh3OVMyRGVJS0NPR014a0tRRkh2?=
 =?utf-8?B?N0lkL0hCcVZLT3p3QktwOFd2WHE0S003Z0o2Rzc5aXVHL0NlRzFYT2pkeFlp?=
 =?utf-8?B?ajViRlJpSTB5ZFRvbFZPaTd3cUhrT3FCaXlNLzRabjRkcnBZNFpHcVlKQ2lk?=
 =?utf-8?B?b0RuNEFzOHQ5NXJHeHJVc3pkZnlIRk01N3I0SnJ3VngveVRqL1hTWS9IeVFR?=
 =?utf-8?B?YTRocWdLN1NZaThVQUNIelUvNUEwWlhsTHdXT2ozR2piYnRiYkRmZzN6Vzh5?=
 =?utf-8?B?aGVleHA1aEdWLzR1M0tqc0xrenlDSFBBN2p4a1FmTXROODQrTDh5U3UyV1Vk?=
 =?utf-8?B?SVRRTnZkdXN3RTJHUU9seUhXOVRyTi8wWEJIZEhPRWRqOUsxRmg5M01TRldY?=
 =?utf-8?B?Y0dUWjA4eGQyeUc4dFEyYVl6MTRrbHpwQTIwY3JOZ2Jpb0IyMUlnWXM5Y0lp?=
 =?utf-8?B?L3BMSXBuMXpHbGVkcmRDNWFiN2NLT0x4SUl2bmJBbkFjOXprSitqaHpCTXZ3?=
 =?utf-8?B?NkNvL0FlbVhDaEpoa0pHKzFUNEZOdWxBSWliSlVQVUptdFpyQXd2dHBlaUxI?=
 =?utf-8?B?bHRSVS9xY0FpZWZEeEtwY0pLWThQakplWWNBRGlQa2pLSnpWc1YvNVVPRFdU?=
 =?utf-8?B?QUgxS3g3RFUyaHowWGVPRTZMdXkrMU4yTzExS05EU1UwcWJYbU5ST29rM2dU?=
 =?utf-8?B?Nm5MNVFzdVFmWkJvVDQ3MmhDUE5PalJzOVRsZFlsVVhORGdZTndUTTNYRnBy?=
 =?utf-8?B?L3lpSTN6RzdnMitpT3VhRlk4YzU2NjlKOXludDdlNVJXbVBIWmRLTzB5NEth?=
 =?utf-8?B?ZC84K3JqTE82Sno1WUdqaHJBVFJ5TnB1OVlHdUJtenFDYkNRZDFNM3AxV0pK?=
 =?utf-8?B?Sm0yUksvdE5uajFnNFBMblJEM3BUYm9KK09VZ0RVU2pXVm4zblU5eXlIWTNi?=
 =?utf-8?B?bktyZ1d5RnRCSElIOTlOMkYveU1HWFpqVkk1bnFWSWg2UlVRN24wTTVFN1VT?=
 =?utf-8?B?R2l5aDVXN0pYWTlVVHJQOEt3ZmNzRHRDUERNUlFLbEZPL0hoQ3V5MTJVVnRh?=
 =?utf-8?B?bXBwNHByOHRXSFJ5OUhQd0ZlTCttR3JITmQ3bmg4c0cxYVlPc0l0d3hxb2p1?=
 =?utf-8?B?bnlkbm01NlR2SUN2Qk14c2t4VlYyNUhrVlpqd2RFTVU4Smxqbzh2YkczWHpY?=
 =?utf-8?B?bU44ZFdlRlhRQzM5YVFwc3B3elk5V0pPRzlSK25rdVlrWVV2NEpmdGhwT3kw?=
 =?utf-8?B?Y3AvU1hjOFBUaDYzcUpiY3YyOUx0LzdQOVd0OVVPSEF0d2h4UFJsTUl2SHNy?=
 =?utf-8?B?cmswRWw2eFowcXNQS0JKVkQ0MWMya1VWMlhDbjFlOU5ZRkUyQzBRSWVwNHhK?=
 =?utf-8?B?MzRUbXJSZE9lbDJiT1BqcGl1bnRFOTh6OUY1TUJPN2VsTExqRFN5UExCYWJa?=
 =?utf-8?B?VG1la0VDSnZncmtqcHNMRWlsMk9Ta3FGbmtXUXJGMHdIc3BQQjYzTlp4YUVW?=
 =?utf-8?B?SlBEOGg4Z3hHcktoTWlCZlpYeEYwdGZHOHNrTkZKRlRLOHBTR3dYRGQ2c3RJ?=
 =?utf-8?B?KzFWUjlFejk2a0Q2K1hVZGJPRU1FZWoxSnMxWDFpV1R2WHV1cjZUeHlXWlRE?=
 =?utf-8?B?b3NpQ2lvNEJhZ1F5WVhnTFJhQjUrUG9MMXVEdnlyVlFURC9aY2ZJTDE3YWRD?=
 =?utf-8?B?WElHZVpuOVVzVDh4VjBtZlBmTzByUG9LN2p0OXBnTkdNVythMVZVWDhEV1R1?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60862B2F7CD524DA634C7F410B5D714@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tZFPvMoirqtoeeRGf3vKpRWw/heKohqPyPeUE+liCOlgqOvfTbGKOr1wazsWbeJcTzLWE6nCRgF13re7jXHxwou2M8IPrrceBhROo3FYOCXekSJ04b2ZQE86v917+b4eAg8L4EtBAS54D6Y9FSyTlQBpl6id5ELOEyFRxmU7j3yEiT1yhZPgG4k+3VwcpFAa24iBphIuLPCDLPdkFTVTg0uV6de2/EfhbKe2saF3MwKFI5pOQVFBh2Pd4cG6PUEu5fYfeDdc5DZFAcyXs6lxaMENaabGPwducDzffoLea5CEiYvDJ3QlIbjmNsHvDHvVSgjcExsgggfb6HYujFOms7wzPd4pD+JAxKm2S+7UmlSKj9aQ7WxNMwqotB/3EAKQW0TDB0pvbCZmCnI1E74ek4jc7fb9gpcn1X685+ypMp3HkbgrL7lo6Gm49R6cViyzOWaUIJX8tik69VD5Ji94qtdZ7sGKzj4Lu5aageVzcjePfbTeiAsUbfzFdpMiQ21j2B87MOET7vs09CKib179UxAsZ237qYJfJgJMRVRBll+f1lJRnxh5wJRiOdGVUCsybXMkxgVxgl0nCz+IM2/LdteO9qDBtstrje2N8VKPHvHwhd5PhFAfriuN4dD6iI5KSDklquAaZ50oFgSwMbxQzcu/D+NgE9KsD6faO6PUBfYhGGlfM55Nn3oLE04IhkSg0N4Gy2iwBbbklUwlIxXdS2G0AIQg953mZb4ISJWWgk8FFpKRHfjwa3gOvtBRsZ5miPiAn0n28KIPj0iTMr86/nBXzk1FxK/SkBkZclOBKw1rdUJcg31xwq1n3Ct3VWKXxGO7Ys/GAzgnN8Q740BI961HCP+d3lnqUUsQvjx1dp7b/EcpkFfLLNDsP+hyJarL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5029d3-ac44-4d48-0e20-08db420910dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 01:38:10.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8zuP68Pil0RuA022kOGIOQ6vrZcoiJBieJzhkhXY9eCYH1y4sSYhKCB9rd1QXFPdIEaPb7qUeX3LE/DFKovgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5984
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmlucHUNCg0KSSB1cGRhdGVkIHRoZSBjaGFuZ2VzIGFzIGJlbG93LCBhbmQgdGVzdGVkIGZvciB0
aG91c2FuZCByb3VuZHMuDQoNCiBGcm9tIGQ0NDFjMGUyNDk2YzE3OTViNWFmMmI2YjhhZTQ2NzIy
MDNkNmFmM2MgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQpEYXRlOiBUaHUsIDIwIEFwciAyMDIzIDE3OjI4OjI4ICswODAw
DQpTdWJqZWN0OiBbUEFUQ0hdIFJETUEvcnRyczogRml4IHJ4ZV9kZWFsbG9jX3BkIHdhcm5pbmcN
Cg0KSW4gY3VycmVudCBkZXNpZ246DQoxLiBQRCBhbmQgY2x0X3BhdGgtPnMuZGV2IGFyZSBzaGFy
ZWQgYW1vbmcgY29ubmVjdGlvbnMuDQoyLiBldmVyeSBjb25bbl0ncyBjbGVhbnVwIHBoYXNlIHdp
bGwgY2FsbCBkZXN0cm95X2Nvbl9jcV9xcCgpDQozLiBjbHRfcGF0aC0+cy5kZXYgd2lsbCBiZSBh
bHdheXMgZGVjcmVhc2VkIGluIGRlc3Ryb3lfY29uX2NxX3FwKCksIGFuZA0KICAgIHdoZW4gY2x0
X3BhdGgtPnMuZGV2IGJlY29tZSB6ZXJvLCBpdCB3aWxsIGRlc3Ryb3kgUEQuDQo0LiB3aGVuIGNv
blsxXSBmYWlsZWQgdG8gY3JlYXRlLCBjb25bMV0gd2lsbCBub3QgdGFrZSBjbHRfcGF0aC0+cy5k
ZXYsDQogICAgYnV0IGl0IHRyeSB0byBkZWNyZWFzZWQgY2x0X3BhdGgtPnMuZGV2DQoNClNvLCBp
biBjYXNlIGNyZWF0ZV9jbShjb25bMF0pIHN1Y2NlZWRzIGJ1dCBjcmVhdGVfY20oY29uWzFdKQ0K
ZmFpbHMsIGRlc3Ryb3lfY29uX2NxX3FwKGNvblsxXSkgd2lsbCBiZSBjYWxsZWQgZmlyc3Qgd2hp
Y2ggd2lsbCBkZXN0b3J5DQp0aGUgUEQgd2hpbGUgdGhpcyBQRCBpcyBzdGlsbCB0YWtlbiBieSBj
b25bMF0uDQoNCkhlcmUsIHdlIHJlZmFjdG9yIHRoZSBlcnJvciBwYXRoIG9mIGNyZWF0ZV9jbSgp
IGFuZCBpbml0X2Nvbm5zKCksIHNvIHRoYXQNCndlIGRvIHRoZSBjbGVhbnVwIGluIHRoZSBvcmRl
ciB0aGV5IGFyZSBjcmVhdGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQotLS0NCiAgZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMt
Y2x0LmMgfCA0NyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KICAxIGZpbGUgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAv
cnRycy9ydHJzLWNsdC5jDQppbmRleCA4MGFiZjQ1YTE5N2EuLjVmYWYwZWNiNzI2YiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQorKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYw0KQEAgLTIwNDAsNiArMjA0MCw3IEBA
IHN0YXRpYyBpbnQgcnRyc19jbHRfcmRtYV9jbV9oYW5kbGVyKHN0cnVjdCByZG1hX2NtX2lkICpj
bV9pZCwNCiAgCXJldHVybiAwOw0KICB9DQogIA0KKy8qIFRoZSBjYWxsZXIgc2hvdWxkIHRoZSBk
byB0aGUgY2xlYW51cCBpbiBjYXNlIG9mIGVycm9yICovDQogIHN0YXRpYyBpbnQgY3JlYXRlX2Nt
KHN0cnVjdCBydHJzX2NsdF9jb24gKmNvbikNCiAgew0KICAJc3RydWN0IHJ0cnNfcGF0aCAqcyA9
IGNvbi0+Yy5wYXRoOw0KQEAgLTIwNjIsMTQgKzIwNjMsMTQgQEAgc3RhdGljIGludCBjcmVhdGVf
Y20oc3RydWN0IHJ0cnNfY2x0X2NvbiAqY29uKQ0KICAJZXJyID0gcmRtYV9zZXRfcmV1c2VhZGRy
KGNtX2lkLCAxKTsNCiAgCWlmIChlcnIgIT0gMCkgew0KICAJCXJ0cnNfZXJyKHMsICJTZXQgYWRk
cmVzcyByZXVzZSBmYWlsZWQsIGVycjogJWRcbiIsIGVycik7DQotCQlnb3RvIGRlc3Ryb3lfY207
DQorCQlyZXR1cm4gZXJyOw0KICAJfQ0KICAJZXJyID0gcmRtYV9yZXNvbHZlX2FkZHIoY21faWQs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmY2x0X3BhdGgtPnMuc3JjX2FkZHIsDQogIAkJCQkoc3RydWN0
IHNvY2thZGRyICopJmNsdF9wYXRoLT5zLmRzdF9hZGRyLA0KICAJCQkJUlRSU19DT05ORUNUX1RJ
TUVPVVRfTVMpOw0KICAJaWYgKGVycikgew0KICAJCXJ0cnNfZXJyKHMsICJGYWlsZWQgdG8gcmVz
b2x2ZSBhZGRyZXNzLCBlcnI6ICVkXG4iLCBlcnIpOw0KLQkJZ290byBkZXN0cm95X2NtOw0KKwkJ
cmV0dXJuIGVycjsNCiAgCX0NCiAgCS8qDQogIAkgKiBDb21iaW5lIGNvbm5lY3Rpb24gc3RhdHVz
IGFuZCBzZXNzaW9uIGV2ZW50cy4gVGhpcyBpcyBuZWVkZWQNCkBAIC0yMDg0LDI5ICsyMDg1LDE3
IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2NtKHN0cnVjdCBydHJzX2NsdF9jb24gKmNvbikNCiAgCQlp
ZiAoZXJyID09IDApDQogIAkJCWVyciA9IC1FVElNRURPVVQ7DQogIAkJLyogVGltZWRvdXQgb3Ig
aW50ZXJydXB0ZWQgKi8NCi0JCWdvdG8gZXJycjsNCisJCXJldHVybiBlcnI7DQogIAl9DQogIAlp
ZiAoY29uLT5jbV9lcnIgPCAwKSB7DQotCQllcnIgPSBjb24tPmNtX2VycjsNCi0JCWdvdG8gZXJy
cjsNCisJCXJldHVybiBjb24tPmNtX2VycjsNCiAgCX0NCiAgCWlmIChSRUFEX09OQ0UoY2x0X3Bh
dGgtPnN0YXRlKSAhPSBSVFJTX0NMVF9DT05ORUNUSU5HKSB7DQogIAkJLyogRGV2aWNlIHJlbW92
YWwgKi8NCi0JCWVyciA9IC1FQ09OTkFCT1JURUQ7DQotCQlnb3RvIGVycnI7DQorCQlyZXR1cm4g
LUVDT05OQUJPUlRFRDsNCiAgCX0NCiAgDQogIAlyZXR1cm4gMDsNCi0NCi1lcnJyOg0KLQlzdG9w
X2NtKGNvbik7DQotCW11dGV4X2xvY2soJmNvbi0+Y29uX211dGV4KTsNCi0JZGVzdHJveV9jb25f
Y3FfcXAoY29uKTsNCi0JbXV0ZXhfdW5sb2NrKCZjb24tPmNvbl9tdXRleCk7DQotZGVzdHJveV9j
bToNCi0JZGVzdHJveV9jbShjb24pOw0KLQ0KLQlyZXR1cm4gZXJyOw0KICB9DQogIA0KICBzdGF0
aWMgdm9pZCBydHJzX2NsdF9wYXRoX3VwKHN0cnVjdCBydHJzX2NsdF9wYXRoICpjbHRfcGF0aCkN
CkBAIC0yMzM0LDcgKzIzMjMsNyBAQCBzdGF0aWMgdm9pZCBydHJzX2NsdF9jbG9zZV93b3JrKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAgc3RhdGljIGludCBpbml0X2Nvbm5zKHN0cnVjdCBy
dHJzX2NsdF9wYXRoICpjbHRfcGF0aCkNCiAgew0KICAJdW5zaWduZWQgaW50IGNpZDsNCi0JaW50
IGVycjsNCisJaW50IGVyciwgaTsNCiAgDQogIAkvKg0KICAJICogT24gZXZlcnkgbmV3IHNlc3Np
b24gY29ubmVjdGlvbnMgaW5jcmVhc2UgcmVjb25uZWN0IGNvdW50ZXINCkBAIC0yMzUwLDEwICsy
MzM5LDggQEAgc3RhdGljIGludCBpbml0X2Nvbm5zKHN0cnVjdCBydHJzX2NsdF9wYXRoICpjbHRf
cGF0aCkNCiAgCQkJZ290byBkZXN0cm95Ow0KICANCiAgCQllcnIgPSBjcmVhdGVfY20odG9fY2x0
X2NvbihjbHRfcGF0aC0+cy5jb25bY2lkXSkpOw0KLQkJaWYgKGVycikgew0KLQkJCWRlc3Ryb3lf
Y29uKHRvX2NsdF9jb24oY2x0X3BhdGgtPnMuY29uW2NpZF0pKTsNCisJCWlmIChlcnIpDQogIAkJ
CWdvdG8gZGVzdHJveTsNCi0JCX0NCiAgCX0NCiAgCWVyciA9IGFsbG9jX3BhdGhfcmVxcyhjbHRf
cGF0aCk7DQogIAlpZiAoZXJyKQ0KQEAgLTIzNjQsMTUgKzIzNTEsMTkgQEAgc3RhdGljIGludCBp
bml0X2Nvbm5zKHN0cnVjdCBydHJzX2NsdF9wYXRoICpjbHRfcGF0aCkNCiAgCXJldHVybiAwOw0K
ICANCiAgZGVzdHJveToNCi0Jd2hpbGUgKGNpZC0tKSB7DQorCS8qIE1ha2Ugc3VyZSB3ZSBkbyB0
aGUgY2xlYW51cCBpbiB0aGUgb3JkZXIgdGhleSBhcmUgY3JlYXRlZCAqLw0KKwlmb3IgKGkgPSAw
OyBpIDw9IGNpZDsgaSsrKSB7DQogIAkJc3RydWN0IHJ0cnNfY2x0X2NvbiAqY29uID0gdG9fY2x0
X2NvbihjbHRfcGF0aC0+cy5jb25bY2lkXSk7DQogIA0KLQkJc3RvcF9jbShjb24pOw0KLQ0KLQkJ
bXV0ZXhfbG9jaygmY29uLT5jb25fbXV0ZXgpOw0KLQkJZGVzdHJveV9jb25fY3FfcXAoY29uKTsN
Ci0JCW11dGV4X3VubG9jaygmY29uLT5jb25fbXV0ZXgpOw0KLQkJZGVzdHJveV9jbShjb24pOw0K
KwkJaWYgKCFjb24pDQorCQkJYnJlYWs7DQorCQlpZiAoY29uLT5jLmNtX2lkKSB7DQorCQkJc3Rv
cF9jbShjb24pOw0KKwkJCW11dGV4X2xvY2soJmNvbi0+Y29uX211dGV4KTsNCisJCQlkZXN0cm95
X2Nvbl9jcV9xcChjb24pOw0KKwkJCW11dGV4X3VubG9jaygmY29uLT5jb25fbXV0ZXgpOw0KKwkJ
CWRlc3Ryb3lfY20oY29uKTsNCisJCX0NCiAgCQlkZXN0cm95X2Nvbihjb24pOw0KICAJfQ0KICAJ
LyoNCi0tIA0KMi4yOS4yDQoNCg0KDQpPbiAyMC8wNC8yMDIzIDEwOjAwLCBMaSBaaGlqaWFuIHdy
b3RlOg0KPiBPbsKgMTkvMDQvMjAyM8KgMjE6MjAswqBKaW5wdcKgV2FuZ8Kgd3JvdGU6DQo+PiBP
bsKgV2VkLMKgQXBywqAxOSzCoDIwMjPCoGF0wqAxMTo1M+KAr0FNwqBaaGlqaWFuwqBMacKgKEZ1
aml0c3UpDQo+PiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPsKgd3JvdGU6DQo+Pj4NCj4+PiBMZW9u
LMKgR3VvcWluZw0KPj4+DQo+Pj4NCj4+PiBPbsKgMTgvMDQvMjAyM8KgMTU6NTcswqBMZW9uwqBS
b21hbm92c2t5wqB3cm90ZToNCj4+Pj4+Pj4gQ3VycmVudGx5LMKgd2l0aG91dMKgdGhpc8KgcGF0
Y2g6DQo+Pj4+Pj4+IDEuwqBQRMKgYW5kwqBjbHRfcGF0aC0+cy5kZXbCoGFyZcKgc2hhcmVkwqBh
bW9uZ8KgY29ubmVjdGlvbnMuDQo+Pj4+Pj4+IDIuwqBldmVyecKgY29uW25dJ3PCoGNsZWFudXDC
oHBoYXNlwqB3aWxswqBjYWxswqBkZXN0cm95X2Nvbl9jcV9xcCgpDQo+Pj4+Pj4+IDMuwqBjbHRf
cGF0aC0+cy5kZXbCoHdpbGzCoGJlwqBhbHdheXPCoGRlY3JlYXNlZMKgaW7CoGRlc3Ryb3lfY29u
X2NxX3FwKCkswqBhbmTCoHdoZW4NCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqBjbHRfcGF0aC0+cy5k
ZXbCoGJlY29tZcKgemVybyzCoGl0wqB3aWxswqBkZXN0cm95wqBQRC4NCj4+Pj4+Pj4gNC7CoHdo
ZW7CoGNvblsxXcKgZmFpbGVkwqB0b8KgY3JlYXRlLMKgY29uWzFdwqB3aWxswqBub3TCoHRha2XC
oGNsdF9wYXRoLT5zLmRldizCoGJ1dMKgaXTCoHRyecKgdG/CoGRlY3JlYXNlZMKgY2x0X3BhdGgt
PnMuZGV2wqA8PDzCoGl0J3PCoHdyb25nwqB0b8KgZG/CoHRoYXQuDQo+Pj4+Pj4gU2/CoHBsZWFz
ZcKgZml4wqBpdMKgYnnCoG1ha2luZ8Kgc3VyZcKgdGhhdMKgZmFpbHVyZcKgdG/CoGNyZWF0ZcKg
Y29uWzFdwqB3aWxsDQo+Pj4+Pj4gcmVsZWFzZcKgcmVzb3VyY2VzwqB3aGljaMKgd2VyZcKgYWxs
b2NhdGVkLsKgSWbCoGNvblsxXcKgZGlkbid0wqBpbmNyZWFzZQ0KPj4+Pj4+IHMuZGV2X3JlZizC
oGl0wqBzaG91bGRuJ3TCoGRlY3JlYXNlwqBpdMKgZWl0aGVyLg0KPj4+Pj4gWW91wqBhcmXCoHJp
Z2h0LMKgdGhlwqBjdXJyZW50wqBwYXRjaMKgZGlkwqBleGFjdGx5wqB0aGF0Lg0KPj4+Pj4gSXTC
oGludHJvZHVjZWTCoGHCoGNvbsKgb3duaW5nwqBmbGFnwqAnaGFzX2RldifCoHRvwqBpbmRpY2F0
ZcKgd2hldGhlcsKgdGhpc8KgY29uwqBoYXPCoHRha2VuwqBzLmRldi4NCj4+Pj4+IHNvwqB0aGF0
wqBpdHPCoGNsZWFudXDCoHBoYXNlwqB3aWxswqBvbmx5wqBkZWNyZWFzZcKgaXRzwqBzLmRldsKg
cHJvcGVybHkuDQo+Pj4+IFRoZcKgaGFzX2RldsKgaXPCoGHCoHdvcmthcm91bmTCoGFuZMKgbm90
wqBhwqBzb2x1dGlvbi7CoEluwqBwcm9wZXLCoGVycm9ywqB1bndpbmQNCj4+Pj4gc2VxdWVuY2Us
wqB5b3XCoHdvbid0wqBuZWVkwqBleHRyYcKgZmxhZy4=
