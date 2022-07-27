Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC42581E32
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiG0DYq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiG0DYp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 23:24:45 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6C248E8;
        Tue, 26 Jul 2022 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658892282; x=1690428282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dygjEYMm3UemXn3PKHC8TTULRgKOHG97OY6gU4odls8=;
  b=o2v7Twfp3xExoKVG7PIlQjO+PCSL5BFk5czVi8xcA+8AABrqNHzyzFHL
   Yr31vnbg6FjoasYfpSbXmDr1AmRqSKVdM9akfc/iF9pCY4CeBlc/QqvNf
   AKTExYr7OdOqR2JFS0jjivPfUra0zLrGEsMj+Q7i5r+1yLsRPU5gNVkrZ
   6zrIpHzEMPgKzu0VfiNfAe7I2v367gXW5NTbNxg+kzH4azb3/0r85I+Et
   e0yG1dgA0V47qpgSQI3Wqcmf57GhVgs3VWI9DwSMrqVNZCHHkDD8oYBeG
   n18+U5dQ9gllsT8cJCputvyOQmvnBr/OVrlCQv0yqQ3mRMtNYB5gBKMPb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="61512700"
X-IronPort-AV: E=Sophos;i="5.93,194,1654527600"; 
   d="scan'208";a="61512700"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 12:24:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsZL4mPdAhWxtarg42xqDfgKw1/FIRHr6n4Sb4Oo6yr6Y+OhcHawbthk5qpTMAEoYEcj84wzfrpkn4WCF7luaACswS3L7MFmiJsKlcLnnQmoS1c0QryibGlnZCkZoXivA7VE8TaaJjPn7NIAbaZNUUidymQSZ1eSSHPlGAVi60AwpHJ0viPyju350gMAlZBZMOL4A9akAykzvYC9OZe4i8ADTHLg6KaGciuQAroK+KukLcbFdXBqA87Ybdh8mmk/0o+50wDuuJTvOItidAi5CkFU6cB0gXM2NgPUFdTpdQ5BPTL8nwX0iDt7XxdhaE1pRKXHNRkTyRwb5iiaCIwDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dygjEYMm3UemXn3PKHC8TTULRgKOHG97OY6gU4odls8=;
 b=cXZLklN50y0cOkoHiKeI2MAEwxkYo471JTKMWrjByDYYZjhTXidywGX60BKNc+LA5V20vnVmDb9vt64/0dULJkTubF7byPmUK/RB81vwO5xAkoQjUAcow/+QQQvKkw2mY6KNjzNDchK40iiKBLr63dhfnTwHLvCQ7D5Nqq1adhoQss84DbOVp03RDqiGFKzEjkQldqPDzIKcumrwVv+OGHwZKZ2Dh2T5fkbyWSrJW8hZJgUQUJb0rAKzJmd9uQGI0/XfVTuwNk6loAqCVBR9nG71x0N+dtaDeDEDaguUCJv7qVNBVy/NlnSQwRqshPZWvoPv99V5GY7qkSdNa6WqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB9311.jpnprd01.prod.outlook.com (2603:1096:400:1a1::13)
 by OSZPR01MB8451.jpnprd01.prod.outlook.com (2603:1096:604:16e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 03:24:36 +0000
Received: from TYWPR01MB9311.jpnprd01.prod.outlook.com
 ([fe80::b02c:31e8:31cb:9012]) by TYWPR01MB9311.jpnprd01.prod.outlook.com
 ([fe80::b02c:31e8:31cb:9012%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 03:24:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>
CC:     Mike Christie <michael.christie@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: use-after-free in srpt_enable_tpg()
Thread-Topic: use-after-free in srpt_enable_tpg()
Thread-Index: AQHYifTbGPwwktyxoEmpbdMcUWz8s61jdG6AgAS34ACAACIxgIAAegIAgALpJoCAAD7MgIAA1WWAgACbl4CAAduUgIAif9cA
Date:   Wed, 27 Jul 2022 03:24:36 +0000
Message-ID: <63b37fec-3b32-dbd0-175f-ab7f6aa3dbdf@fujitsu.com>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
 <20220701015934.1105-1-hdanton@sina.com>
 <20220703021119.1109-1-hdanton@sina.com>
 <20220704001157.1644-1-hdanton@sina.com>
 <a671867f-153c-75a4-0f58-8dcb0d4f9c19@acm.org>
In-Reply-To: <a671867f-153c-75a4-0f58-8dcb0d4f9c19@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9138b111-773a-43c5-2e6a-08da6f7f8864
x-ms-traffictypediagnostic: OSZPR01MB8451:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvuuMN5h1XGTE0kttMu9mjqPd4EV/ghFUBHuT5ah1eaiXgGZhxtLSWyFrPfoDSL83xl8X/ptWxS8J9jIsG1kitxo/J882NXDr58CisSjnI7xPTKlyS6u67+cHC7cxLa66st6nIUDru5FYuXS/8gpBvKgj18/OwDgf/3qUcJN6TgAanp2kn3kQI3USHG7IcPRTUaOWfi+0sBJH1sIyXfhAR7dzrjQIDajep4XIn3nQUwlixa/zroGi1rGK76dkqkg2WrzjZmyOJBSL/ORjzsrJeXu/rD0bElm7ApVc6eHNA/vqyEvLRpMgE8Kpf4Wrv3EhLEsbBya7ro6rcRV7J3x3wnfWzG32/TJQZ8woMKBJ5V3Rb2ZO1GSVyPG2AQV/DXz1LHgGA0T3NApUvnzY9SL7Gns5kkdRKvNql8iMvwBxw94YWu16x49g2g0UdwBaJhsu38Qb5DcnAxmUoZHXAz8WXMknFTcPmqUt41/aUfoff8g28PVDzh5xz1UiCfCrc2GTEyJaICB08NDZDmgnNvp68lIMvvHW5Uv2JHRATgwZfsnGSD4RRBfh+A+dNEHAUEqLiSs5BSHRi5wk5B6K5rPKg/nEK+ZEtfcB9Abn0ZpCJZNRSXOOl50Y0dwz9pQ7p3HD+1OpeSmU9F1x7N0KieVHWWBJiJx+K+bVGa3bR0swwMVRVcthjAjbHBK9dzVYoYQb7Prj24xOhv/LhRTL62o9EC1cewEyPrTh/NObhHPjfqZekT5NZ7CYeXjmajBVYIkKggXa7/f6Wi1mEneLcArp5LitGccxtkeqPK2Uk+p+dU/kNg/Iehp1NRvMY7VvMe5aHezKrn4v501enYs/9mGTrGfOuaBLw9qOYry40cgbrQubTR7hNhYZ5GZs2aQSDAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9311.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(4744005)(6512007)(26005)(8936002)(4326008)(186003)(2616005)(36756003)(85182001)(71200400001)(5660300002)(6486002)(31686004)(41300700001)(53546011)(478600001)(6506007)(38100700002)(316002)(38070700005)(31696002)(86362001)(64756008)(76116006)(110136005)(66556008)(54906003)(66946007)(8676002)(91956017)(2906002)(66476007)(82960400001)(122000001)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3A5SExBVUZJcitIdnhxM3cxeHQraEZaOTlyR2w0K3M5S045bVJLakdYbFgv?=
 =?utf-8?B?S0x6MVFrdTJQbDFMQmtiUGFtUHVVTFMxTWpKUXdpYjY3MVg3OWg1U3FWeGNP?=
 =?utf-8?B?QUJVZnVidVJvaElNUVRvaWJYVW9WanVRRU1HYlNON3VuNHl6RkZLTk10S0VD?=
 =?utf-8?B?Y0dGM1huR3BPZUY5UWNEVjBmZHpuc3daOHpYNmZuVDI1M2Z6TjE1OXRsVVBN?=
 =?utf-8?B?WXo5TStQVGNNZ0Y5TStSUGdyMUlZOStkUS9tRVY1QWs4QnByQjYrcy9uZ1dl?=
 =?utf-8?B?OGNJTEpSOHJiSnZmYldSUnB1b3ZUb08zUGdWdlBkSU1tSFo0NmVRYUtESkJE?=
 =?utf-8?B?dWI4OXRPamdWQ0NBY0Q5Ky9MYmJoQnl6VHhtbzlyb3RtNG5PMFN0R3dDQlBm?=
 =?utf-8?B?N0VGaHdSYXdocHFrVUhnYVBnbE01RDB5cUxYQjladDdQalRGUkYzSk9IOGVW?=
 =?utf-8?B?R2M0Z0FqUCtWblRBcmtvL1FZVmxweEp6QlNGTm85enEyQW5GS0MxS1NZYUMv?=
 =?utf-8?B?Qi8zY0lQemNUZUtvdzJCcUFBWHpkNDVERTVGd0RQQUVLMGhEMEt4K2NSNWRZ?=
 =?utf-8?B?ODdUTnZuRHQ3d2hTWVlJbXNpT1dVcEJIa3ZyZytLRXFqcXJoSSt6bnQ2cEhz?=
 =?utf-8?B?VndKZms2Uk1iNWF5NEJwM01MRVdzd1ZBb2tEbmdqWFpkbEJXOUttUERiTTdn?=
 =?utf-8?B?bjRJMlRidmhIMW4wbmYxR2xKejdZV3RuT1pxZkMxUEZyVkdxdEdSZC9Qbkly?=
 =?utf-8?B?eFJCckpOUGJEcS9sNGVDS1lwclZjRnFNSUxOTE5kOElJZWd2NGx1bm9zNFgx?=
 =?utf-8?B?WVBPbkFmRVRROWxVdHlOcVVaNnIxbklCUUR5cGh3MW9uTCtwZ0tiNk9aZndt?=
 =?utf-8?B?MkxRZ0xObUNUSFUvTXp4WU1lVFgxNlpybzZVTnU0OXVHSVFhTENtT21zZ2tp?=
 =?utf-8?B?cWtlNVNlVlNiT1gyVlBnTk94TVB6dEN1a0hMNkUybStRRllobFNTajhHMlc5?=
 =?utf-8?B?WkRpUUc5ZW15UHpDaE5CdThnc0pwdE5oQmFGUUNMMGcrcndtYmpqSE5Yem01?=
 =?utf-8?B?WnlOT285SXlHQlJVSnliYmxoeHU4S1ZUSkovSVhuV0V0VXBpN2p1NXlsSVp2?=
 =?utf-8?B?WGdIYXJSVnZqUWp1akhXcnN4dWQrU1VESmV4am9GRGxrSjRjbDEyaU4zb0xt?=
 =?utf-8?B?NzJONUh0NjA4SVBOUHhLWlBHL21OU1EyL1ZscEVzVnNpZVRmOUE5ZU9ReFhY?=
 =?utf-8?B?QWQraGc2cnFuaU1FZjRjbjhHZzJKYlVaNE9kSDRiY09FTkVUbytLQmtWZ3pn?=
 =?utf-8?B?WlhpWU9YN1p5S2RiYW9hSVRQTFdzNmgyZlNLTWt5RkdwL0hWVmIxYXdBQUt2?=
 =?utf-8?B?bElXSnBFQW5JTVhnRGVtcGwzaUdMVCswYkZwbFVmOTdTOU5naVllQzFPZWMz?=
 =?utf-8?B?UnlrNXp6azg1VnBPaGVJUFpxQ0taYmo1WmlqcHUrZHUzeTNXa0lkdzRuQ2lJ?=
 =?utf-8?B?cVFDSFFlNGV2NXlBM2I1ckVZR0xoWnRzRUlZZFVCL0JxWHNncTZRamdTQmRB?=
 =?utf-8?B?ZTdxdnZTUHhPcFk0U24rOWZCQ0ZPMEZoYnRMTTdqTjFDMjAreS9welE0WG9y?=
 =?utf-8?B?c1dkS1RESnplME1jSFZ2UFloMXZ3MHJURFEzUEhKSHBGeFk5czV2bjJtN1Ny?=
 =?utf-8?B?Ny9MclJTZHVJeDk4OC9lTG9ybnFVV0xDNE5oUHJBRFJrYmxQS3pKaEViOGp5?=
 =?utf-8?B?OVVaWGtEelM2d05VN096Si9SRmNLWDYrekUzaEJNd3FkN2hzK1NlTnVucTJn?=
 =?utf-8?B?VndoZFQ4dWFEWU95NVFRbzBrYzkxeDBSUnZWQURxVlo4bDFQTVN3UHVTYkxZ?=
 =?utf-8?B?R01CSW1xcjl4TjFrYXZiOXFTazdyK1pVQitWdU5oWHhkUkg5VjI1M1o1eHVy?=
 =?utf-8?B?ZndUZzlQKzZsR0Zwam1LcjRBcEk0YldQS1dIOWNtWHVoaERwK052RW5Vb3B2?=
 =?utf-8?B?Z3NMWGdROEthL3pvTUxIb2FpaFdyV2ExajJUSkI3d09YMnVUQjVHSWZDYWR4?=
 =?utf-8?B?SnFabzdiM0tsZ1VodTkzRWptQXFyZ1dCcC9YdjJ2S294K0ZSbGYxK01kZ0ZN?=
 =?utf-8?B?RHdjNUo0NEVNT0Q2QVc4SFlRd0ZqL2NxZmpiMXVJUE5nY0R2MGhRQnRQaFYv?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E7E922849F654D9D7CE91D3F09FAC1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9311.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9138b111-773a-43c5-2e6a-08da6f7f8864
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 03:24:36.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAXVezN1fyUhyEU9dgNcR6GH9iKjtWXsat1oedJqR4Jz2r05nN4+meDBVypbnybZPxu8o3h0apkChEMn/RckLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8451
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QmFydCwNCg0KDQpPbiAwNS8wNy8yMDIyIDEyOjM0LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+
DQo+IEEgcG90ZW50aWFsIHNvbHV0aW9uIGNvdWxkIGJlIHRvIGRlY291cGxlIHRoZSBsaWZldGlt
ZXMgb2YgdGhlIGRhdGEgc3RydWN0dXJlcyB1c2VkIGZvciBjb25maWdmcyAoc3RydWN0IHNlX3d3
biBhbmQgc3RydWN0IHNycHRfdHBnKSBhbmQgdGhlIGRhdGEgc3RydWN0dXJlcyBhc3NvY2lhdGVk
IHdpdGggUkRNQSBvYmplY3RzIChzdHJ1Y3Qgc3JwdF9wb3J0KS4gSWYgbm9ib2R5IGVsc2UgYmVh
dHMgbWUgdG8gdGhpcyBJIHdpbGwgdHJ5IHRvIGZpbmQgdGhlIHRpbWUgdG8gaW1wbGVtZW50IHRo
aXMgYXBwcm9hY2guIA0KDQpJIHNhdyB5b3VyIGFwcHJvYWNoIHRoaXMgbW9ybmluZywgaSB3aWxs
IGhhdmUgYSBsb29rIGFuZCB0ZXN0cyBsYXRlci4NCg0KVGhhbmtzDQpaaGlqaWFu
