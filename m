Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00962DD5F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiKQN4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 08:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiKQN4p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 08:56:45 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B1770A31
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 05:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668693405; x=1700229405;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=CKPrNpwHqvwQ7CYGHTogB/gZXwuOnbbdx2gcPPlxbLI=;
  b=X0mj1PXUiBpMzkOP8tyiKffL8TnQ3eDHbjkma7Nh005A3soMSOIQOwEf
   ZWD0QzEsW+rnm2x98hXN5ZliylWKIDCgxHDYkXcUFMTxo60B3Zn1RHGih
   efjOCw3VV8sYTUBs0Mp4xXlJio0zDtKi+NNuhe4VQ0Jd0Tpf5viKhNmTX
   DK1Dd6qAC4VlldorV8jrHw7cYMKzJ1OIJsVf2NFHCjzRZkpWFDkYdPhHk
   D3+8JbqlaIhjIGR5XP6mkBTZLo5K36Y/OynJCE30Lwl43VeEtN0bBICGJ
   D5L3RC9zcMe15FtEKV7uS0qqgraO8pkMv+KSBbSOE1ojOaGi8HdRGBmgx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="70325386"
X-IronPort-AV: E=Sophos;i="5.96,171,1665414000"; 
   d="scan'208";a="70325386"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 22:56:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7z1ZourzdyckEFnqw51X9OoHXZRTT3bWDXI58liQthJs9dbVcIn2qRqccNSdt14qoD8J/DEMMA0j+T2P7Y6b3CdEQaCd6e4LQoAoyMO9Z9jysQb/n5PJqeOte4oKDasyUFB4g1mB5Y3MpwHdBWdbocnfzbjPUB8F0VVWEco3MVHZSnrQrP7tBqdK21A7oXwY/iCtLW8pTua+7qCDgnky7cUggNVyXLlJ1gcyGACuzuTOx7z4YEYu1AHbPa+iQFiOonBRvUnOosOma8E1+HlzUtY34u8vt6Oq7LqLHGfGiFt023xgW9JcTG/ZKzzdlFUIG596aNcOONyUbVR5HNBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKPrNpwHqvwQ7CYGHTogB/gZXwuOnbbdx2gcPPlxbLI=;
 b=PHjfLJxXlz5UqBbvLZBo8g8MU4GM9v4ZyN39QHag/f8RUe4tUcozCM4gC7M/S7NL4nj673OVdD5mMRoGztuWgD/3m9qx8VgnMO/UxX/d82vrjV3hg0pIYacnAxp+MihNOEqpaN3cgzg8QuE1QOtbBA4uHyJVjM5jtHtScvT+Ygek//mlucFqXbWP5jihKYMdpcrfdWl5qBXmNGpfOaZ5fA53eTUQA58gX5AXMpzJKI0fdNW5qAV3uAOUk6DBkyjsrjQ8rupxGgQ+DX166ZfKLgbO1cbCqTw78pbYKVF4jVMRAdBaRgY8QeMGIvP3x6Dbm7X2ke3/FDbTbL/snoRfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB6005.jpnprd01.prod.outlook.com
 (2603:1096:604:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 13:56:37 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 13:56:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
Thread-Topic: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
Thread-Index: AQHY+nfiTbcYUjqkQEmsGw99Y/d71a5DI+AA
Date:   Thu, 17 Nov 2022 13:56:36 +0000
Message-ID: <16cb1c06-cc93-f0a8-d674-2c9cd5e63cea@fujitsu.com>
References: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB6005:EE_
x-ms-office365-filtering-correlation-id: 0d649704-d608-4e31-0899-08dac8a38b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcUk+PZuBJklpaV09/8bz0RBkabYH7A/CDDsKPRXpYQzWrXON3GZHqGgQquxbbpKf7ETkgOFm6k5cn5ai4Lg3SUX24/jdnI7efpwtg8fKm1QuaiXbxyT4Gger9AcjvSmP+pBjSov8xmP3qKvLWBJdIWVOvoD1KThiq7pIQiv1w3UJNHXrIQt1Vl61U8AUecqz1lwvgtKTQikZWqQXzy1ZrC4E3B1jIAqTMHWT11C6PuV+t5Dbn+8QijXMqfeXu2lPbFWpKm+b1jnOiuf4RgTcxbwWLTOjwbeDZF+10yPTTMfwkVlYeo6704FH0cBo7K5I0IJQHVhYYpILdufCoAwrViU7fBESPuhuxk0bwVEUH+Jy6QfllKrZPldZwYvCJkJOSArY04gTyl58bGrSOcMXwV91hjQxTlGhBVapkrReKzLJYDmLOr1zp093KHJqcMIZRddaHysreIFT7490xqprV8oQgaWEWJpzpuviGm+8ZpWD7j1iqeHRX1ladqmt/CwG+KHZCzxXGDHi0c9OFJDx942CEcpZLpgPmEfJmD6W+lWtj9eVvvg1vzpKrTD2inOS8bTGnvnOaaddHMtfJXDPeAnivIUNiZ8rneOIQFUB6Wf/X2VIQJkwZfp4c7uL3ImhwK9hU8ZuiN/GQMYWpiohcmOElXlTrGG4Ro7aZVfDWpwImzzBYd6uUEPyINuiC1JgXARe0H3fHyA1MFxLOSpciMY2sJgAHl6lMgDYShlIGqiZUxQ4qnXCCmAwKED5H3q8EvNXgPt11+CU0yTZtfE8sUznQ7bdlpxGggoOTDBRY1tfcBCH6rRMIan5UhUbT/RaYthhbzuAQm6kLOO0THtKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(1590799012)(451199015)(8676002)(26005)(64756008)(41300700001)(66446008)(36756003)(5660300002)(6512007)(66556008)(91956017)(186003)(8936002)(76116006)(66476007)(2616005)(86362001)(82960400001)(85182001)(66946007)(38100700002)(2906002)(122000001)(83380400001)(31696002)(53546011)(110136005)(31686004)(38070700005)(71200400001)(316002)(84970400001)(6486002)(6506007)(1580799009)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVNKUHRBc3VsMy8vaURmRkh5NG9Fd0FZR3NsMkUvZ2RYSzZzbGZVY2ZIa2xy?=
 =?utf-8?B?ZzNJVVM0cFd5azBza1BRVHFCWGNqbDh0cGJ1cnpQNHpHRzZibjl4Y0FJYzli?=
 =?utf-8?B?S2tGMFU1L2lGUTNXbWJhbDBIVzEyeEZYeFpQRTR1M1JILzUzd1hHRGxpT2U0?=
 =?utf-8?B?NTJFeTNac3IrRG5iMDJiNmZyajN1VE1PeW0vUmlzc1o4eDNJUWVIMWFCalBF?=
 =?utf-8?B?OUwyMU12ZEhRWjNaa3ZMRWpXQ282V3pvNGpwQmZWWVMxR0JrMVI3WFh5bEI4?=
 =?utf-8?B?QUNXcWt3Yk5JSytKZ1dVRzA5WHpad1JUZGtCcEZqY1A4MkNaMU9lOFRGNENu?=
 =?utf-8?B?ZVRrbFp1ZGx4ZHMwMUlNeklHeEp4bEhVUGdpREtwMkNXN3RVVkVja1RrOTEr?=
 =?utf-8?B?aDJvNHAwYXQzZDBTYTNrb3k4K0sxK0J0d0dRdC9pdkViRnhyYllvZTB6UmNp?=
 =?utf-8?B?SVJSVDVnaXpLcStpSVlSRXNDc1M2cGJ4UkJRWmliTzRBR1lLcjJ4RWMyWi9z?=
 =?utf-8?B?dDhFeHE4ZXNVT0ZYTENjZFZCZ2Q5dk5DdGRGT2VPT1c0KzRmbmJrM0FKWlls?=
 =?utf-8?B?VXFoTXVVZElBOHVxWlpHVjBKVUpzWVZoMFQ3WlpybE1GbW5yUW9QcllMOU1U?=
 =?utf-8?B?ckJlNmJkb3FhMXd1UWV6Q0N3d1I2K2FWMDZQQ2oraEFZT1ZxQmloZDFQYkdW?=
 =?utf-8?B?UkFpaHFrVTlVb0NzWG9xMGpXU1h2QU15QmdPN2dZckU1TTh4Wk9OMWM5YTdI?=
 =?utf-8?B?RDRjN3ptd051eU53NXYya0Q4c2J1djNkaDBBa0hwcW5FMDJZd2EyQWZrS2k5?=
 =?utf-8?B?eWYwSEYySHpWYVFncFRxSzlkTUJpY0NSQ1ZWbHkvWGx6V2IweFIyQXBwVDV5?=
 =?utf-8?B?SDdzUENIb25xSUkrOVJRT2J6cCt0ODhqalIrbTFuNVRBanozbzlkQkEvWEJs?=
 =?utf-8?B?QXNBcm01N21sOVM3UU1kbVpGYnc2NTlDbjJVUDVwT0lHS2paWFExRFRnUUpn?=
 =?utf-8?B?bEs2RDZ1WlRKbE5lWTRuUFc0Z3RKRHVFUHdpdmxIU3RnQ3g2U2cxY0pscEFW?=
 =?utf-8?B?eHVRRS82dWFyMVh1WWplWFIvR2FqdW8rM2owc3hkSDhsMEpzbVB5MG1zWTdJ?=
 =?utf-8?B?YnVSUWhpUzlqS0czaE5jdGJHclJNUnpqenZyakNYY0lVQndqTjNEQmtnaVBx?=
 =?utf-8?B?bU5qUFI2VStnT2syclBQTnB4eGtISmpndUNEYUhvQUNmM0pkSWtaTkh2WDFs?=
 =?utf-8?B?bUwzTk1GR1huaGxWT2lGdWM0VURxZ00zd29jaFVTWFhmaFI3eGQrZUttSVVu?=
 =?utf-8?B?M21MeVNXR2tjNDQyTERnQUZyTnN5bE1JTUNEczl3SXBBUytGMjNIMjFMaFZO?=
 =?utf-8?B?ZG1Oa0gyQWNTSGZJOTZCb1NGVzFNNFJHWXhyMDNmQ2tKeDliMFdtSWhDVGhQ?=
 =?utf-8?B?akJjb2JRVnpsOEJCSjJ5S0ZjS0JqaVBPb3hvQW1NUmlwb2d5QzMwS09OZzdS?=
 =?utf-8?B?dDdJU2JWSHZUaTluWERRREJTdmxMN25HNVIvNVhnSVpET2ljaHZnSjR5QnFU?=
 =?utf-8?B?QUdzSFRpMkpKejFSUTFoamFHdzZiVnZvZU85Mm1DWk1rTktadm5mZm9zTkRv?=
 =?utf-8?B?RHJZZHp3ZjJWWWtpb0laRFNFUUJvcFhzS1FIWm9tSDNBNEhtV1RMQkdqNWhh?=
 =?utf-8?B?elpnalNuSnJHbkM2TzBUUVZSMnFkV0RiaTg5WXhxT2FaeWdoRHUzSDQrUUZl?=
 =?utf-8?B?VXEyd3F3SmpkNlhlSnN2S2pFQUxvajZQZ0ZUWXRoS0lGVVhXUVpXMXFGTlND?=
 =?utf-8?B?dG9HVlMvUlQ4emFoT1hTUi9qMkVvMmVFRUZQKzRmeE9jMXBpUy9zb3dYWEpB?=
 =?utf-8?B?N21vdHowU3NaV08rbHZHdjhjYWlyNzFsTGtma3dnTzRsL0lKYTlCeEIraUIr?=
 =?utf-8?B?UFVRdlBzb1VYYmNIbXowVDJsTWFEbTkzMll4SitVYlEyellZcVo5bi9ka3BV?=
 =?utf-8?B?TkE4RHhVK3RRcnJ2dVVIK2prMW1tSU5mc29IZ3BKRXRVakU1V1E5M2dyUnJk?=
 =?utf-8?B?Wkc2RDlob2Q1NnNSZlhFWVNBTnpJMGF2V0t3VjBNekZMNGdoYnRMdFBMZ3RT?=
 =?utf-8?B?cHpaWlUwcWtLVDhYQ1NRSXVZaEd1WDFkemNaOWUzdkM3N3pZeWxUZSt6K2dD?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12E50E376FE26E44BF2AB477BD68C773@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 995NbV3G7JXEv5/tSPcSwAh3hQjJAH6eV0dPCh2ttByB/fESgkXWfC84Sg9fazedqEvZoJg789C71TMcaXm848wRegR94ipXkDjyXK++KOHHd0p2MePnjFQroVKFiMsErtV8Ux+86MkLA7YNqWwcs9AjRrkQxJxo/j2FBFVdhJNekiKP2Tm/Qj71S0RsXeG0OMIsf6ExDjRr6cj0khtDabpgRDikWMkWQvVPnAfHzHaHUXz+n6IyxIn4lMz01a4hAGU0SnqRXDYcHbqU7t5W1w7NRWxtU0YwkECqZXiASLIwyNOWJ2om1xBFQ+DB/B6lTkS8ThuDNUu0qtU5zmvPj87Pz1NwLB8xwUpdn98ubN3Pw9/8FlpT4CLhts5RjelR5s7FDHSYl+3sDNAb4qMYqybse99vJouLU+2V6kfm9cJJDyy0gXq78gztMQBM5DKNYH3ZKA2+nHKAMnop7ivytX+MCuzBdvOKyHoZvPu8TpSeu+7tmK5coG4JJspJk+z29dL0UqZqyfsmcwFUjTOLkVtaJann8BNNycDSsPt94AYYsDcTnm9B4dKs7BahL5O67/VkZiJceSZ0e2Bl+57aDXryT8zNwlqtUZ53YrueV2m43xy+6kGh9E9IUadHSMUiP5AdFAHPPEzuYhSW168SI7iPQnwgFQEaYFCFNymtSP47Q7jN/RLcocGhZqdDa94eyahZvFfHIFZAxqjHnYZhiIc9UZa68IBHJC86qTkJaBurDmypckjRIjD9VgD7M6NiaaQsYasa4PAGUyNwKk/MDZyDRtYvTdSVZo2osLcgqsP+4eXGBtlTIht3U/qRbh2YJsMv7crsCyOkeiiIHb5BcDJf+fjRST7gM1SfV2BTVOT/tvdmAVKhByrJXmVd9hsP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d649704-d608-4e31-0899-08dac8a38b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 13:56:37.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Og1MrAsAAFgvosK0JZdAgdsm63PJXPYjkVpvQLredFb5q5I0VwPLmxdoZj79dAH4yyA8h7JGD7JOHlJ6aqPosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6005
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE3LzExLzIwMjIgMjA6MzMsIFpoYW5nIFhpYW94dSB3cm90ZToNCj4gVGhlcmUgaXMg
YSBudWxsLXB0ci1kZXJlZiB3aGVuIG1vdW50LmNpZnMgb3ZlciByZG1hOg0KPiANCj4gICAgQlVH
OiBLQVNBTjogbnVsbC1wdHItZGVyZWYgaW4gcnhlX3FwX2RvX2NsZWFudXArMHgyZjMvMHgzNjAg
W3JkbWFfcnhlXQ0KPiAgICBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIDAwMDAwMDAwMDAwMDAwMTgg
YnkgdGFzayBtb3VudC5jaWZzLzMwNDYNCj4gDQo+ICAgIENQVTogMiBQSUQ6IDMwNDYgQ29tbTog
bW91bnQuY2lmcyBOb3QgdGFpbnRlZCA2LjEuMC1yYzUrICM2Mg0KPiAgICBIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE0LjAtMS5m
YzMNCj4gICAgQ2FsbCBUcmFjZToNCj4gICAgIDxUQVNLPg0KPiAgICAgZHVtcF9zdGFja19sdmwr
MHgzNC8weDQ0DQo+ICAgICBrYXNhbl9yZXBvcnQrMHhhZC8weDEzMA0KPiAgICAgcnhlX3FwX2Rv
X2NsZWFudXArMHgyZjMvMHgzNjAgW3JkbWFfcnhlXQ0KPiAgICAgZXhlY3V0ZV9pbl9wcm9jZXNz
X2NvbnRleHQrMHgyNS8weDkwDQo+ICAgICBfX3J4ZV9jbGVhbnVwKzB4MTAxLzB4MWQwIFtyZG1h
X3J4ZV0NCj4gICAgIHJ4ZV9jcmVhdGVfcXArMHgxNmEvMHgxODAgW3JkbWFfcnhlXQ0KPiAgICAg
Y3JlYXRlX3FwLnBhcnQuMCsweDI3ZC8weDM0MA0KPiAgICAgaWJfY3JlYXRlX3FwX2tlcm5lbCsw
eDczLzB4MTYwDQo+ICAgICByZG1hX2NyZWF0ZV9xcCsweDEwMC8weDIzMA0KPiAgICAgX3NtYmRf
Z2V0X2Nvbm5lY3Rpb24rMHg3NTIvMHgyMGYwDQo+ICAgICBzbWJkX2dldF9jb25uZWN0aW9uKzB4
MjEvMHg0MA0KPiAgICAgY2lmc19nZXRfdGNwX3Nlc3Npb24rMHg4ZWYvMHhkYTANCj4gICAgIG1v
dW50X2dldF9jb25ucysweDYwLzB4NzUwDQo+ICAgICBjaWZzX21vdW50KzB4MTAzLzB4ZDAwDQo+
ICAgICBjaWZzX3NtYjNfZG9fbW91bnQrMHgxZGQvMHhjYjANCj4gICAgIHNtYjNfZ2V0X3RyZWUr
MHgxZDUvMHgzMDANCj4gICAgIHZmc19nZXRfdHJlZSsweDQxLzB4ZjANCj4gICAgIHBhdGhfbW91
bnQrMHg5YjMvMHhkZDANCj4gICAgIF9feDY0X3N5c19tb3VudCsweDE5MC8weDFkMA0KPiAgICAg
ZG9fc3lzY2FsbF82NCsweDM1LzB4ODANCj4gICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDQ2LzB4YjANCj4gDQo+IFRoZSByb290IGNhdXNlIG9mIHRoZSBpc3N1ZSBpcyB0aGUg
c29ja2V0IGNyZWF0ZSBmYWlsZWQgaW4NCj4gcnhlX3FwX2luaXRfcmVxKCkuDQo+IA0KPiBTbyBh
ZGQgYSBudWxsIHB0ciBjaGVjayBhYm91dCB0aGUgc2sgYmVmb3JlIHJlc2V0IHRoZSBkc3Qgc29j
a2V0Lg0KPiANCj4gRml4ZXM6IDg3MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBaaGFuZyBYaWFveHUgPHpoYW5neGlhb3h1NUBodWF3ZWkuY29tPg0KDQoN
CkxHVE0uDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
DQpCVFcsIGkgdG9vayBhIGxvb2sgYXQgdGhlIGhpc3Rvcnkgb2YgJ3NrX2RzdF9yZXNldChxcC0+
c2stPnNrKScgcm91Z2hseSwgDQppIGRpZG4ndCBnZXQgd2h5IGl0IGNhbiBpbXByb3ZlIHRoZSBw
ZXJmb3JtYW5jZS4NCnRoaXMgc29jayB3aWxsIGJlIHNodXRkb3duIGFuZCByZWxlYXNlIHNvb24u
DQoNCjgyNSAgICAgICAgIGlmIChxcF90eXBlKHFwKSA9PSBJQl9RUFRfUkMpIA0KDQo4MjYgICAg
ICAgICAgICAgICAgIHNrX2RzdF9yZXNldChxcC0+c2stPnNrKTsgDQoNCjgyNyANCg0KODI4ICAg
ICAgICAgZnJlZV9yZF9hdG9taWNfcmVzb3VyY2VzKHFwKTsgDQoNCjgyOSANCg0KODMwICAgICAg
ICAgaWYgKHFwLT5zaykgeyANCg0KODMxICAgICAgICAgICAgICAgICBrZXJuZWxfc29ja19zaHV0
ZG93bihxcC0+c2ssIFNIVVRfUkRXUik7IA0KDQo4MzIgICAgICAgICAgICAgICAgIHNvY2tfcmVs
ZWFzZShxcC0+c2spOyANCiANCiANCg0KODMzICAgICAgICAgfQ0KDQoNCj4gLS0tDQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcXAuYw0KPiBpbmRleCBhNjJiYWI4ODQxNWMuLjRiYWI2NDFmZGQ0MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jDQo+IEBAIC04MjksNyArODI5LDcgQEAgc3RhdGlj
IHZvaWQgcnhlX3FwX2RvX2NsZWFudXAoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgIAlp
ZiAocXAtPnJlc3AubXIpDQo+ICAgCQlyeGVfcHV0KHFwLT5yZXNwLm1yKTsNCj4gICANCj4gLQlp
ZiAocXBfdHlwZShxcCkgPT0gSUJfUVBUX1JDKQ0KPiArCWlmIChxcF90eXBlKHFwKSA9PSBJQl9R
UFRfUkMgJiYgcXAtPnNrKQ0KPiAgIAkJc2tfZHN0X3Jlc2V0KHFwLT5zay0+c2spOw0KPiAgIA0K
DQoNCg0KPiAgIAlmcmVlX3JkX2F0b21pY19yZXNvdXJjZXMocXApOw==
