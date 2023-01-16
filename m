Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C966B58A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 03:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAPCWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 21:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAPCWQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 21:22:16 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 18:22:15 PST
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED986A6A
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 18:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1673835736; x=1705371736;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ej+tooiGZsgzikVZsmiVoqr83oPrPMEj8N4Ep34UUEw=;
  b=umtUAG1A7C68WPMmC4sFjBd5+/QQ8StFqyjf34SQLH3mUpEHHFNuaOjF
   pGEIpaDNOTgQWh0i7IDGAhsR+orj29qpyW8lfv57cEmRsr/V0ijkvdReA
   EdhFuwN/OD68QMw/OX353zBVIwxQL6DSykOmUpPd2vfD7+J4VUr5UOG1m
   oa+YMXKmsOmdRHz0/zYiWKS5IVcXYM9xo9AzKYL4bowHA2EkBUvDmNY59
   RI5euQbPw+dh1LNh2Kun+q8vJH2EwW4Mdf8Cw62UqDhLacXK1wd84WJ+T
   B8L/ZpGtT/aXMXEvKI0+8wizfiv9pxRWY7vCjvYvMHPBa/MrVJn7B7BIY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="82807236"
X-IronPort-AV: E=Sophos;i="5.97,219,1669042800"; 
   d="scan'208";a="82807236"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 11:21:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2T/H1KwDPqEbt1KB5l/cAkEcEh4cqvEFTPx7uBJ7z+Vu25+LkfBLx5cxedEfKY+CboTa5fmLMeEdso+r6B35HpVzRcCtH5O5/Wcu7CQp/BrboJD6uOI4Hof4jJZqjemEu6RtRuzNF0q9kvkBKUBeigoHXYiNz7s5Pu0tBX9DHanRLJljp59NPLGuYr/kfp0HXlWCnyEer7q52nmOP7W4CwgM4wmx028gaFpq6k88m1DonWO65XshQqfc7zZv3J2XjkMPQC/6FzUx2YCjbLyUJcnWrBCO/mUshccEuDfzV1QLyHAw7ssmHukvemxB6xNhwwMBa3hL5oXVT1cUkYWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej+tooiGZsgzikVZsmiVoqr83oPrPMEj8N4Ep34UUEw=;
 b=di9jenAGRMrVLJtNb7jnacJFEffUZAs7n8yqfWwZeGXvYRlmQjbSjqHi9fKcoxCRN6DnDpocINKGOzyWrws41WmivIJrqwkSbW7yOTdMCGef2NOW0Pw2e7zZiNiQYZ88cUmwvRdJxspquLSFm5WB/cIB68GP7BgtxXoLnq65/DYyFQ+3ACXZMsfdinO1BQyU819mF2OvAGMVx6tB1F+aVvh8Xz5qAdzcgbUg4VrEIVQ6HW0tj/7+2Dm0yyhyUG8g+H4s6PinaVlXJhZo+h8mE/dB1tNq96K/+HAoIEm0kOM2KlHwSS36bwlp12OIZt39omDuGYJcvg/4vOelp3rnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS0PR01MB5571.jpnprd01.prod.outlook.com
 (2603:1096:604:be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 02:21:05 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 02:21:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 6/6] RDMA/rxe: Replace rxe_map and
 rxe_phys_buf by xarray
Thread-Topic: [PATCH for-next v3 6/6] RDMA/rxe: Replace rxe_map and
 rxe_phys_buf by xarray
Thread-Index: AQHZJ6a4x06U8CfX5EC/ukM5AriCqK6gUxAA
Date:   Mon, 16 Jan 2023 02:21:05 +0000
Message-ID: <c03afa55-c2f2-5949-289a-4411bdba87f9@fujitsu.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-7-rpearsonhpe@gmail.com>
In-Reply-To: <20230113232704.20072-7-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS0PR01MB5571:EE_
x-ms-office365-filtering-correlation-id: 926f9bfc-751a-4057-1f5e-08daf7685235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P66iTd3iXE3TqH4zrmsYBZ6ilVjSGkSMB8789KV4pNNf2SeR3a0yhccJq7dzCAB7uQul/Ij4qePNe1u2Owd9ADJo8xWXsZzgpreT4dE2pzLwPy+wHkmWhzRBc4/g4w6MfOIpiSRzouV+jsw8St3lgg82fWcLYpJyibKo216ZgZ+6UcW4A+f1ntpjxRjQh5eUUCCfN5oCNpwY7VWoGVGjQ74W1bliBVqDeDDa50Eqfe9bQhAwX5cGZyYv3gtZSMg6oB5Qa2aibod+XQv/6csrdKu3EsGFv13IHlqp66zIpNGsp74A29dsA4BlYr2dYc44NPPFNGmoduxYvCdptIG0mrbApGywxoEgNudPAzv3Z0XM/uYSZj6ltTDEGqI0/oGKcnwuB5oMwOjZrh3WOwnck808gksEri60qJCNt4c10Mcs2i7HChtTy/UGSzjUmHBEu5oLDl4TzXpazv5pWcHGpQnwIaVD46UmZKBfeN/daXM4kbFqsA9SW8YC2Er9B3gf/j45+ib9T7NxVJDTjwYGWcVTgY2T5lMEmb56LTPLMGtRSues+chNLL1nColyzlZTZUURmvrF4GYeGwlkGrsJ14ufCKDngK4nodDAy4ouQ+PMA+ADznF7vyTLuxMSWeSP8shfbZHN18KhNuAOCRI6mPtxAma5vNYOy+jMhXPiQfHIcUiY+N05XO+JcrLvQZySMQVh/Hh2c9pd6MaYCFb4xV0XwHnXjfs7tVGJU/UBscrwfUPTmzxtxmBqJDW9zY/3ECmTUQ1XwI7uyUviU9mXirZgCCJfgoJiDSsvLq75fAmp7v4H4qhWcCdtY2dw6btR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(1590799012)(451199015)(83380400001)(31696002)(5660300002)(8936002)(82960400001)(38100700002)(36756003)(2906002)(38070700005)(122000001)(41300700001)(86362001)(85182001)(6512007)(53546011)(478600001)(6486002)(91956017)(31686004)(26005)(186003)(8676002)(2616005)(64756008)(71200400001)(66946007)(1580799009)(66446008)(76116006)(110136005)(66476007)(316002)(6506007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2ZnZTdwUGVBdHBsYnRBRUFDZFprY3JTczAvY0c3ZWpQaWNrYmtLRTdRSG9N?=
 =?utf-8?B?T2t1K0h5Rm1OQURXWVh0NHAra0VOWlRTRGNlcVlYVitrK1lPem1mMXpYMVZz?=
 =?utf-8?B?UXBKditob0ZHejBpYjZ1aDJaZnNiSXhweC9yeE4vbzZZL1VEd0NXeFYzaGxz?=
 =?utf-8?B?eExMb1VVUTBEQ3M0dFcvNEs2ZkFWTWpQTUIxRVBZMkQrWUl2UTBvVXRESEFt?=
 =?utf-8?B?UnFmNC8zL0pOa1kvcG4vTzI4QjJrbW9MVHlVWUVkRkUrWUR6MFBORFJzZk5r?=
 =?utf-8?B?TlpCbkFvSXFjWnpiMFExa0tCTnl0STJvRE9nYVdUOWR1bzdrY0VyLzdNcXhF?=
 =?utf-8?B?Y3BqN3E3amFRM29IbTdsVGlxVE1lNjdSMURLQ1o0bEcwamRPVG9DbmlEVjlT?=
 =?utf-8?B?eC9MRDNLYitzK1FDWmJURUYrQTRPYkE1NFRLdUQzRUFXL0d3dDNjUFpUQ3lL?=
 =?utf-8?B?UXJqTTRndTRZUlJsRUxBc0U3MDl0a1BGUEdjaktXc2R2NTVoQlhBRzZ3dERP?=
 =?utf-8?B?U3ZJVHVTRERrK25uMmtheHE2VTlodThKSDhrSEU3V1dEM0Q2Zk5GeHV5Rnoy?=
 =?utf-8?B?SkFJNHg2WTVFN05FZ0EvOVNhMnNFM3ZGVmFLQm9FY09XcnpWMDVpN0p2Zjh0?=
 =?utf-8?B?RGZjNDJmMDNCYWxweXJxZVNvcE5lS3lEUy8vUXRqTkw1T3grOWs3NHVTV3l3?=
 =?utf-8?B?SUhTbE05V2k5SFI3VTczNXROdCtUa0tncHdCV2Y5dS9yRmRJS1JDYUZWeC9H?=
 =?utf-8?B?SmpqUTZaOE1FNXhSVDdUTXZiK3ZFU1I2ZDg0eEVrMzJEdUNoZlNuekhFb05Z?=
 =?utf-8?B?Q3lRNXNBbTJjWCt4MFk5TmJaSWpnNnltSzlrRUhaeGdqd2twNTdrUUhYMUdl?=
 =?utf-8?B?NmF2LzFuZ000UnBCR3J3S3Nja0kvcHpCa1ZUU2dtNWhtdmthNk9PUnp0UE1X?=
 =?utf-8?B?a3NFTGFyK1ZHNFZZaEErOTBnUDd0NlI5cjliYno0YmFCRkUxY0U1ejZiRU50?=
 =?utf-8?B?S3g3d2ZLbmxhMWZ4bnpCTnNEa0lHU0oxQUR6T2RwaWFXMVF2WmhIanJtRGVE?=
 =?utf-8?B?RWlUMEhyQ0pGaFJMRDZKMWRkVTRFZDk3UVBpS2JBMGJ0TlA1MXRDWlZzQUVG?=
 =?utf-8?B?Y3NNWnF4TTFQY0VFcFlpUC8zZERwTEZ0QVFjaDBuQk5YWHIvdHRZMzJORmtJ?=
 =?utf-8?B?UEtZZkc3VEdaZ3RSejNUN09ZYWJGaDF6OUE0YVk5VmQrWHdUQ2hBNVE4L0d5?=
 =?utf-8?B?SjhhRWh6MVd2aXVaMG9qeHlmVUlBUFZmYTJiUFBxOXRYYVlNUVgxS0dhNlcw?=
 =?utf-8?B?ekszZmttQ2hDUzZFZS9tdHdVK3J6SFBzQVVqbDNyZXY4TkJna0NXT1E1TmlB?=
 =?utf-8?B?cVhnZUhPSit2VVRVQjhmaGtpL0ZaeXJKTjBkTGZHNjMwZGx1VEhFNkhlRWFE?=
 =?utf-8?B?dHV3Uis2MGR5Y1IvVExCemlZQno2dXNoZXNUNklSZWV6SDVjZ2FaZVhUOXhR?=
 =?utf-8?B?OVJCSHlPN21kbGd6RW1mSlU0Vm54R1AvZStYKys2S2UvNDErck5BWWZHTjgw?=
 =?utf-8?B?d0lRNGlMLy95MUNnZjJWckNKdmFxT3l4M0R5NnVoQUVLTmNCS0wzUHJhTjlL?=
 =?utf-8?B?WnRsajMxZEpxRmJUalBTQXp3bGp0R0FDcS8rb0xPdU83Zk5QRTBXSzdpUWRX?=
 =?utf-8?B?bDJNb0ZhTU9kWmdNUG5GV0dKeTl3Vk5pc3o0ZVVjOE00MFVQNEhLMTNQTWl4?=
 =?utf-8?B?RGF0d1RJeFlobkNwcjU1aHBsb1ZGdlV2S2QxcHZrR3pjY0NYYXduWHg3VVRN?=
 =?utf-8?B?a1lkWUZieUVxL2J3N0c1bjZlNnJaUS9rdEhPbHA2dk9EZ29ZWnNibE9XS3JJ?=
 =?utf-8?B?MmlxbmtVQ1NrdUNvV2xLaXVqc01MNWEvVGZuc2Y2SkZFWm4wOENYbWpJZE9L?=
 =?utf-8?B?dzhKUXUvQk1JZisveGZIUmxIRmptU2JVVG5UWnQ0YTkrNU9Gek9QMEdGeUF2?=
 =?utf-8?B?cis4bndWaGc2dmw1dHQ4NUs3VE9OQVk2ajd4Rnd0VExxL3NuRmdUcGwvZWZK?=
 =?utf-8?B?MlhYNlhpOGdQeEVYankvQUU2K3EzemlqckVneHIxTGtFeWJRdDBTMm9tNUVI?=
 =?utf-8?B?RDViRkxmWFVGRm4zZENRUEEyQjB1YzhaRDF3dEM0bmpubkNndlUwZkl4Q1pK?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18D0A5416F0016459D8F1CF733692B43@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K+JiE2hgVGceKJ+1+TXhaTAIsqeFrVsrPRHnAZ1G9l3VyO6WDa8AEXwNYbEoJZ4Q0ambntTvYMD0P9DMqOMPQuFTU31pUt6o3UtqzcdgPnUJ4DSYpDbOjAcOusrZHcBXrvlyHKDA3sDNiTjFfSg3Sju88p5Q4WfiA7nrOvRWvE1Bf2QRlLBt7+bYtgc5QkfkT0bYpHx1GXrQoYy6o5pVVqAE30lJYE54GA0oIo7jHm1bymiZ0a+rh9jlWl+aq27tfXPy0k/nyRCfgNlRfr3nt3T6uWMn/BA4/IkTTSCbAVEPKWKprAm9cM46xIxOupTlR+XgwbMy3/sAGUGgA5qd5fDg2wdMp33Jzb6gC2xeFspx7Pi4cQlny/zzzeGM0jhk4O3boKOrq3S+3EItcWIPvzBHV00FL5NY6r44UyLbG279HOcj591Twr6VlcozY901cvepV9cwL0nZRbqWgyY4ivJAfkznOUwD1qI1BEO/eeJxg0RShvKaonY8NQfP+fqnXNsbMmaQGjKk/SaKN/NDFUC0wV85XzsvleuHVkyLfjoy5P3e4uXXrU/1NI4V2YupUrJqFeLofgrD9Z48n+qXK0gucfADbKvtc+6HbvU47WnsOCH1TbREbubEQle1VVIhZJpSLNtONEtoAaJIqrVR5gKyKJSLwHq9Sn0jtmd0iSD8XrtMMnz2b2NSysB+CT0tJYTwpwz3psiH4y5CiX/HP6HkY4mv3i6RDCim8c5+osTIh/zIigzOh8ihoCsxP6nxsYI6SRdxt05vZUxB4wL/KlGenL9IwmttSGrUo6sgGThqWPE66xh/Epf/gsYr0QJQI5C4ICjvtqGo7TKSJzEBsA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926f9bfc-751a-4057-1f5e-08daf7685235
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 02:21:05.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0UPcaPR+4S7u2MME9J05NtpNA5jahcHetV4jQA1lRin8jloKcenwDMEi22JCXmZMfI5FDugYL5yGlNd8dtsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5571
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzAxLzIwMjMgMDc6MjcsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBSZXBsYWNlIHN0
cnVjdCByeGUtcGh5c19idWYgYW5kIHN0cnVjdCByeGVfbWFwIGJ5IHN0cnVjdCB4YXJyYXkNCj4g
aW4gcnhlX3ZlcmJzLmguIFRoaXMgYWxsb3dzIHVzaW5nIHJjdSBsb2NraW5nIG9uIHJlYWRzIGZv
cg0KPiB0aGUgbWVtb3J5IG1hcHMgc3RvcmVkIGluIGVhY2ggbXIuDQo+IA0KPiBUaGlzIGlzIGJh
c2VkIG9mZiBvZiBhIHNrZXRjaCBvZiBhIHBhdGNoIGZyb20gSmFzb24gR3VudGhvcnBlIGluIHRo
ZQ0KPiBsaW5rIGJlbG93LiBTb21lIGNoYW5nZXMgd2VyZSBuZWVkZWQgdG8gbWFrZSB0aGlzIHdv
cmsuIEl0IGFwcGxpZXMNCj4gY2xlYW5seSB0byB0aGUgY3VycmVudCBmb3ItbmV4dCBhbmQgcGFz
c2VzIHRoZSBweXZlcmJzLCBwZXJmdGVzdA0KPiBhbmQgdGhlIHNhbWUgYmxrdGVzdHMgdGVzdCBj
YXNlcyB3aGljaCBydW4gdG9kYXkuDQo+IA0KPiBMaW5rOmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXJkbWEvWTNndlpyNiUyRk5DaWk5QXZ5QG52aWRpYS5jb20vDQo+IENvLWRldmVsb3Bl
ZC1ieTogSmFzb24gR3VudGhvcnBlPGpnZ0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBC
b2IgUGVhcnNvbjxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oICAgfCAgIDEgLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX21yLmMgICAgfCA1MzMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4g
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgIHwgICAyICstDQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuaCB8ICAyMSArLQ0KPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMjUxIGluc2VydGlvbnMoKyksIDMwNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaCBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+IGluZGV4IGZkNzBjNzFhOWU0ZS4uMGNmNzhmOWJi
MjdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KPiBAQCAtNzEsNyAr
NzEsNiBAQCBpbnQgY29weV9kYXRhKHN0cnVjdCByeGVfcGQgKnBkLCBpbnQgYWNjZXNzLCBzdHJ1
Y3QgcnhlX2RtYV9pbmZvICpkbWEsDQo+ICAgCSAgICAgIHZvaWQgKmFkZHIsIGludCBsZW5ndGgs
IGVudW0gcnhlX21yX2NvcHlfZGlyIGRpcik7DQo+ICAgaW50IHJ4ZV9tYXBfbXJfc2coc3RydWN0
IGliX21yICppYm1yLCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLA0KPiAgIAkJICBpbnQgc2dfbmVu
dHMsIHVuc2lnbmVkIGludCAqc2dfb2Zmc2V0KTsNCj4gLXZvaWQgKmlvdmFfdG9fdmFkZHIoc3Ry
dWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCBpbnQgbGVuZ3RoKTsNCj4gICBpbnQgcnhlX21yX2Rv
X2F0b21pY19vcChzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIGludCBvcGNvZGUsDQo+ICAg
CQkJdTY0IGNvbXBhcmUsIHU2NCBzd2FwX2FkZCwgdTY0ICpvcmlnX3ZhbCk7DQo+ICAgaW50IHJ4
ZV9tcl9kb19hdG9taWNfd3JpdGUoc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCB2b2lkICph
ZGRyKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGluZGV4IGZkNTUzN2VlN2Yw
NC4uZTQ2MzQyNzkwODBhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9tci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCltz
bmlwLi4uXQ0KDQo+IC1zdGF0aWMgYm9vbCBpc19wbWVtX3BhZ2Uoc3RydWN0IHBhZ2UgKnBnKQ0K
PiArc3RhdGljIHVuc2lnbmVkIGxvbmcgcnhlX21yX2lvdmFfdG9faW5kZXgoc3RydWN0IHJ4ZV9t
ciAqbXIsIHU2NCBpb3ZhKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIHBhZGRyID0gcGFnZV90
b19waHlzKHBnKTsNCj4gKwlyZXR1cm4gKGlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQpIC0gKG1yLT5p
Ym1yLmlvdmEgPj4gbXItPnBhZ2Vfc2hpZnQpOw0KPiArfQ0KPiAgIA0KPiAtCXJldHVybiBSRUdJ
T05fSU5URVJTRUNUUyA9PQ0KPiAtCSAgICAgICByZWdpb25faW50ZXJzZWN0cyhwYWRkciwgUEFH
RV9TSVpFLCBJT1JFU09VUkNFX01FTSwNCj4gLQkJCQkgSU9SRVNfREVTQ19QRVJTSVNURU5UX01F
TU9SWSk7DQoNCltzbmlwLi4uXQ0KDQo+ICsJcnhlX21yX2luaXQoYWNjZXNzLCBtcik7DQo+ICsN
Cj4gICAJdW1lbSA9IGliX3VtZW1fZ2V0KCZyeGUtPmliX2Rldiwgc3RhcnQsIGxlbmd0aCwgYWNj
ZXNzKTsNCj4gICAJaWYgKElTX0VSUih1bWVtKSkgew0KPiAgIAkJcnhlX2RiZ19tcihtciwgIlVu
YWJsZSB0byBwaW4gbWVtb3J5IHJlZ2lvbiBlcnIgPSAlZFxuIiwNCj4gICAJCQkoaW50KVBUUl9F
UlIodW1lbSkpOw0KPiAtCQllcnIgPSBQVFJfRVJSKHVtZW0pOw0KPiAtCQlnb3RvIGVycl9vdXQ7
DQo+ICsJCXJldHVybiBQVFJfRVJSKHVtZW0pOw0KPiAgIAl9DQo+ICAgDQo+IC0JbnVtX2J1ZiA9
IGliX3VtZW1fbnVtX3BhZ2VzKHVtZW0pOw0KPiAtDQo+IC0JcnhlX21yX2luaXQoYWNjZXNzLCBt
cik7DQo+IC0NCj4gLQllcnIgPSByeGVfbXJfYWxsb2MobXIsIG51bV9idWYpOw0KPiArCWVyciA9
IHJ4ZV9tcl9maWxsX3BhZ2VzX2Zyb21fc2d0KG1yLCAmdW1lbS0+c2d0X2FwcGVuZC5zZ3QpOw0K
PiAgIAlpZiAoZXJyKSB7DQo+IC0JCXJ4ZV9kYmdfbXIobXIsICJVbmFibGUgdG8gYWxsb2NhdGUg
bWVtb3J5IGZvciBtYXBcbiIpOw0KPiAtCQlnb3RvIGVycl9yZWxlYXNlX3VtZW07DQo+ICsJCWli
X3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4gKwkJcmV0dXJuIGVycjsNCj4gICAJfQ0KPiAgIA0KPiAt
CW51bV9idWYJCQk9IDA7DQo+IC0JbWFwID0gbXItPm1hcDsNCj4gLQlpZiAobGVuZ3RoID4gMCkg
ew0KPiAtCQlib29sIHBlcnNpc3RlbnRfYWNjZXNzID0gYWNjZXNzICYgSUJfQUNDRVNTX0ZMVVNI
X1BFUlNJU1RFTlQ7DQo+IC0NCj4gLQkJYnVmID0gbWFwWzBdLT5idWY7DQo+IC0JCWZvcl9lYWNo
X3NndGFibGVfcGFnZSAoJnVtZW0tPnNndF9hcHBlbmQuc2d0LCAmc2dfaXRlciwgMCkgew0KPiAt
CQkJc3RydWN0IHBhZ2UgKnBnID0gc2dfcGFnZV9pdGVyX3BhZ2UoJnNnX2l0ZXIpOw0KPiArCW1y
LT51bWVtID0gdW1lbTsNCj4gKwltci0+aWJtci50eXBlID0gSUJfTVJfVFlQRV9VU0VSOw0KPiAr
CW1yLT5zdGF0ZSA9IFJYRV9NUl9TVEFURV9WQUxJRDsNCj4gICANCj4gLQkJCWlmIChwZXJzaXN0
ZW50X2FjY2VzcyAmJiAhaXNfcG1lbV9wYWdlKHBnKSkgew0KPiAtCQkJCXJ4ZV9kYmdfbXIobXIs
ICJVbmFibGUgdG8gcmVnaXN0ZXIgcGVyc2lzdGVudCBhY2Nlc3MgdG8gbm9uLXBtZW0gZGV2aWNl
XG4iKTsNCj4gLQkJCQllcnIgPSAtRUlOVkFMOw0KPiAtCQkJCWdvdG8gZXJyX3JlbGVhc2VfdW1l
bTsNCj4gLQkJCX0NCg0KSSByZWFkIHlvdSByZW1vdmVkIGlzX3BtZW1fcGFnZSBhbmQgaXRzIGNo
ZWNraW5nLCBidXQgdGhlcmUgaXMgbm8gZGVzY3JpcHRpb24gYWJvdXQgdGhpcy4NCklNTywgaXQn
cyByZXF1aXJlZCBieSBJQkEgc3BlYy4NCg0KVGhhbmtzDQpaaGlqaWFu
