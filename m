Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE157B0FA
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiGTGVk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiGTGVj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 02:21:39 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874B4598E
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 23:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658298095; x=1689834095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mnkkpR0lW0XohDsUz4JcjKk9jeRJ8+SJURnHabp8EuQ=;
  b=T1MfKVNPrHM+RHJ4N0XoN5OhEb6SRMBW7daMP7lMcvI/DhoTdrt9FwQ8
   l0yNSlhLNHCw/1G2aCSqVa+B2QYaVCPwdZ3SUE8HgDHvexHD9SQWcR9aH
   WhZ2YrHDWY9dfAFWljT7bf9tCHQh7+0Q3gEFSQuRHazZmLc8dBuaZ79hP
   oAfp17Xjzurw5Su0/e/ZP4eOYPG7uH1XLzTTOZ/ecWutSOUF4oBWvYLnT
   sZn61tu9ohtsk3dkpYg69d2M4OQCd646N05Q3xu8vx1RcYs+8SgdczXv0
   up9ZZ8n381Km1dN++CplQW4lWe1jc9xMIoOWYZ6JcGxZaSb1Jncvnxjns
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="62274194"
X-IronPort-AV: E=Sophos;i="5.92,286,1650898800"; 
   d="scan'208";a="62274194"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 15:21:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G05Fba04ljbjjcoPhqOUp/gdncuGU2Bfv695bUnjCwJqZkeHuijNd6nytmDXuCIjg5I2LrJC+Mb1PwvRUoa6AszfoxchJQ3qsirqero4pcYUtdoOf0M6cdlc6wY9ggYGj4sSaMvnIaTWyUJIcdDopYU8BiKfIskrnh5PWKqPlZuDo/JeqwS21TtLXL7O2Cjd1XZ4OKaRGAnguJs99C3vVyS478VcHSW1KlYGvq+qU71zo35eWi2PM+dQyCNjPg1pC/5DCb9lENI7YG8W2nE7lYx4Duku0RMywHh+dWHnvruPFjB7YyUqnYAEYzxIUCyhqDYWVeLXaMDfe3jP48At2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnkkpR0lW0XohDsUz4JcjKk9jeRJ8+SJURnHabp8EuQ=;
 b=Yz3GJoGQ+q2tloPfv1X52+KBVrNVoXVy0eWlc+jWC3laHf5HQac8roTSok7jTbD2IXdcTOaCZdVe10g3jTxNHQbkfhdECxWB6Qdkubn7g/7vn3d0SZT/bP23tyAyg7TZewqt6BkoVqmAj9VJknXZSNDqh6VfER7cQboldW22HXksho0ntpZ5+aFMcaZCPCnOeph7pAb3c/OIF053kj5xFQozXWHFOiBel79ilz+bjBgGSFTjS1DMYLmEer1vYcz+rfPtQdFSX8SqKj4a5XaHq4FF/Hn1KLDCNUrB6+3kyHZ/KPLPehPCjVXlSWR3dYU6p3tjf41u84IwhWw/7L+mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7751.jpnprd01.prod.outlook.com (2603:1096:400:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 06:21:30 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 06:21:30 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Thread-Topic: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Thread-Index: AQHYj2tsVqLq8qnUGEa0XJOwJo3ZV62G1uwAgAAMIoA=
Date:   Wed, 20 Jul 2022 06:21:29 +0000
Message-ID: <a19c2627-22d9-4362-66ee-bf66903d120a@fujitsu.com>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
 <YteUvNhKF/VH+OFW@unreal>
In-Reply-To: <YteUvNhKF/VH+OFW@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d89bb807-ca0e-4d70-10e4-08da6a18159d
x-ms-traffictypediagnostic: TYCPR01MB7751:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dzz3WryyiPxl4dsKIIexiY2VemBkN9Zt+iGzCwzqi/nNxa4iHMR8CcinlgsRMmRoeqTAmhdvJikYeX7pGjE92yfvH9yuvJ5dchT9iznAzJn/I2DMhzLb58w2OpP4SbSctd6kMd1P2TnN1JoE1GBaw42bJ/b2xT9Im2zG6GUvceCTg2Yln/chx1Cpl+AkaVKQg9dysSKaBm2VOXA1tljf/JcimPh0hotExl/JoNavO6gJpOYkzerVwaVMrIBgxRk5CpSeInuPQ9LzNt/0Vt15qyE2Cnm6IwBZY+OVsffnAIKVRaI6tDE5GF2TTO4Bja7wJvg5oDGX7QZ6x8s0EUr1O0tUVaUfVLUBJF/DsZ0Patb/7dxf8aTYIRLpWyYDLpfLueDj3BPMptDB+hhZmcxYrVPpWe1fVA9oOIQrD1uLELbC1t2Ws8aRTQg5PtJX4OOyWlb5KzfLWTVHFPJ0vTS2NB0deVAAw8P1Hxh3qigrMXEd0C+1HTp+B93aJcb9zpNMiCIKBWzf0oeXiuYyb8uPCe3tXC9CkjZi2G11n/VkNEKuwaUUQINv0pdd7AT5Es3uyxqKw/elukWN1BGVhO1eIAwQxNtPMO074k35Wi0cG1ew8/rZVp20xY9xp0SqimgCUnzkjgJ2GG2C8rmGL55abqVbDeaAmcBgQNlSS4XCyHR4ZKuAeNi2uVk9AJVgMTaRZf1MKctGn9DVIZJXMfuPwV+V+M6OheignfWC5mvxYRfD6DfrJsNwdNajUvQ9SZRKS5v8uOHr5D6zKFuXKZ5U0PL8K6Bg80yEvA8zWEvrZWQwwGPHl2qovwmzDncyT+IxQb1nlocJpggoaxv3ek8GeGEvxNaZFYDk94pieG2WMNQYIymAgp76/3a23/hebUW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(71200400001)(6486002)(478600001)(85182001)(91956017)(38070700005)(31696002)(54906003)(36756003)(186003)(86362001)(6506007)(53546011)(26005)(38100700002)(6512007)(41300700001)(31686004)(316002)(2616005)(6916009)(82960400001)(64756008)(4744005)(66446008)(66476007)(66946007)(5660300002)(66556008)(8936002)(76116006)(8676002)(4326008)(122000001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmwyckc5VnlCaVA1SDJ6N2NOT3p0SGZCRVFzY2NwOFJUQ2s5bGJYZW9VNGd5?=
 =?utf-8?B?WUFjVGQ1eG1paGRlbWI0OC9GNnBDOXBqcXhiQ3l2a1JiL2U0VWtOWnBOTmhi?=
 =?utf-8?B?REdFZGd4RVJzaW9ReVNlT2tnNUFKUjA0ZVY0Ri9Na0VLei93TWU1ZVFyQVM1?=
 =?utf-8?B?d3I0L1VWMHdieWJoYmNKWGpkNHVpSzhzUjdzYThKSzdLWFRqUkpSMU9nYzJp?=
 =?utf-8?B?djBNam85blFYU3lPalZhU3VTaW5HbG5tUmVrYUFHZmNLZjFDQVQ5bWd3VHUz?=
 =?utf-8?B?eHYxWmFKK1kvS1VSbGU5SUlKN2Z1bEZDTDE2K2V4T1RUY2RlR2g2djNkbkha?=
 =?utf-8?B?L3VmOUw3eGVNTUJBL1NEbEVhNWplOEF5UHo5UHBnSUpxd00rWlhFcm04WklJ?=
 =?utf-8?B?RjNFRlNxd09sU3VVSmxSNlFXbXpORXdLdWFEYVRmQUNnUFRoMGJ1ZE43VTlV?=
 =?utf-8?B?cXB6VGxaeW9EY3VROERSdVF5dURaV1FIaktmZmM0SnRZdWN1TUpsN0Q5L3lv?=
 =?utf-8?B?clFEeGpDTlVubjVMdUx0Um1pMVc3eVpDMEhaekhFWXJBanVSTE45QnJ2L0Nl?=
 =?utf-8?B?WWpYaDVNRk8zR0dDWU1hdDU0eklXUlNYd1hHZVV6dkVzeDNjZjJUUCtDUjZK?=
 =?utf-8?B?K1pWa3o3blB0RE1DeHRndGs0N1BWRUJFaStJYzF5TlVNbjBYYzd4RWYxQ1JH?=
 =?utf-8?B?TmsrSmw0cEVNOFMzVU84Z1pGYlFVbTVyTjVhcmxpbUZhVlJQWElHYWZkREoy?=
 =?utf-8?B?Rm5BWFk0SzRLdnZjNWd6Zk5WSS83ZlBPSTBzN0hnM09ac2tXTDFpWEhxbmIy?=
 =?utf-8?B?d3BQUSt2QURlVEliZmlmeFRTTmNSOEhmNUUyaVdRdFdKSy84Ly85SHFpV1Ri?=
 =?utf-8?B?UjhrNno3RTBrYzVEdEFZUm14bFFVZWVnZU9sNjZ5MWgwdUxwdng4MjYyanh5?=
 =?utf-8?B?Z05ueXplakxZL3MwbzRBR1ZHMWZadDRCUkV5N0JCVXVRT1p0a2lWUU92a2NF?=
 =?utf-8?B?UU5BVC9jNUhveFBmN040YWFDV3pqeHBoSEp1bk9NTHo1dTk4RTNFdlhSZERs?=
 =?utf-8?B?VTZsdHc4NTVsS0J1RHZLLzNRdG9Ec1ZYZTdocDFYZ1JMcWllbmRIRGNESW1X?=
 =?utf-8?B?eW9QbHJGbDl4WEhTZmpvN25YNVJmWVZnWis4dWkrSzZsMTZRbFptTHl6bGJk?=
 =?utf-8?B?VE1taVl0Ry9kYjdxbnRuczI5MnhxL0cwOW1nMjRxdmhhdFZXck9pZU5zeXRo?=
 =?utf-8?B?MXpqalh6RGNxaHZYaWZ3Y3dBaC9ZbS9OWXBEYURRMGZMVTFLVC9YbjFCbFpR?=
 =?utf-8?B?VVZYeFpabENGS0FsMTdZZlNXV3ptcTZVdWM2UnRTd0JOUUhVZXlzME9uOHFT?=
 =?utf-8?B?UUw3ODRtMXdEZkoxNkxVSngrY2hPMXZYcmtpRlBTUU5pdWV5RkhVZnhJREk1?=
 =?utf-8?B?TjhRQjEvTjRnc20rT0s0T3lLNVVva2RLL2ZzaVlCa1BIOHZrZFk2Q2E2N3dl?=
 =?utf-8?B?RVhtUm1WUG5oWENBZ0xFMHVRdGdqNkdLcFJmZm9JNjFwbmlac3pkMTNJanox?=
 =?utf-8?B?eFZiSTdhT0xoY2FyRnNqNWw3S0pOUWwrbjgyTWJ0aXBoejNCa1pzUXV6M0Vl?=
 =?utf-8?B?QmllSzdEeWFkb04rWkVFbGZ0emhRaW1ZcEVvM21mc0hxRzlQcXdZNkZKNVNr?=
 =?utf-8?B?UmljWFZGdjZDMHpyR3Urdi9PTjZOTXR0eVI5Y09zUUh2ajIremZtcHJpUzBj?=
 =?utf-8?B?Vjl2aytnSVZiTzNNVkttNU05T2ErR2l3WG9rWjd2eFNxbDRuTmdadCttNjIy?=
 =?utf-8?B?Qk80WFdIWFY1UHJ1LzRBZUZIZDFCaXBWdm1FSzRJYUY3OXYvd05XcExkK1B2?=
 =?utf-8?B?clJiWVc2RW9PcmE4cFpUbkNGSlZRU3Q4NnZNRW9JeTI1aTRJWlBQMzZwemRC?=
 =?utf-8?B?T3BiVUtoa2FPWU1USFU0V3NqY0ozL1d2ZGxzaktDVWZ0NFVTY2xIUVFOdEND?=
 =?utf-8?B?YnVWbk9TWEt0dHpXeGpsa25uMDR5dk95YWp0ZVVZTDNmZlhQK3JYczl6QmtE?=
 =?utf-8?B?TktraDhCSTdZMitLdlhwNmR4Rlp2MFdLUHFtVDZmQk5QREJBblNuOUNaSlU2?=
 =?utf-8?B?VVk4UE9YS0ZLS3RwbGl0UEJhMVcwT3QxTWdPbWhhWUJSU2ZtcG1IamgzSHVL?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9F63636C6DD641A8167251632CB4AF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89bb807-ca0e-4d70-10e4-08da6a18159d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 06:21:30.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikp+0UQ8NK7sqrfJgWxqG7S9QkycCe0kFRkkDsqD4NpD68TPn2RUt3d8t+H2b/nQ3QOmRC5kGHLIjONBANsD5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7751
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTGVvbg0KDQoNCk9uIDIwLzA3LzIwMjIgMTM6MzgsIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4gT24gTW9uLCBKdWwgMDQsIDIwMjIgYXQgMDY6MDA6NTRBTSArMDAwMCwgbGl6aGlqaWFuQGZ1
aml0c3UuY29tIHdyb3RlOg0KPg0KPiBQbGVhc2UgZml4IHlvdXIgZ2l0Y29uZmlnIHRvIGhhdmUg
c2FtZSBGcm9tL2F1dGhvciBmaWVsZHMgYXMgaW4gU2lnbmVkLW9mZi1ieS4NCg0KSSdtIHNvcnJ5
IGFib3V0IHRoYXQsIHRheSBJIGtub3cgd2hpY2ggcGF0Y2ggaGFzIHNvbWV0aGluZyB3cm9uZz8g
SSBoYXZlIG5vdCB1cGRhdGVkIHRoZXNlIGZpZWxkcyByZWNlbnRseS4NCkRvIHlvdSBtZWFuICJb
UEFUQ0ggdjUgMy80XSBSRE1BL3J4ZTogU3BsaXQgcXAgc3RhdGUgZm9yIHJlcXVlc3RlciBhbmQg
Y29tcGxldGVyIiB3aGljaCBpcyBmcm9tIEJvYi4gU28NCkkga2VlcCBoaXMgYXV0aG9yIGFuZCBT
T0IuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4NCj4gVGhhbmtzDQo=
