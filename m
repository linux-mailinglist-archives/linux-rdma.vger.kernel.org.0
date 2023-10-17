Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F297CB9F1
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 07:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQFXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQFXC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 01:23:02 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D4A2
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697520181; x=1729056181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H0nE0SiLUG0TNTK+nTnzcmk1fck7TSK1CagEPH4M+do=;
  b=PT3Dr1+fPvA0jivk2OsyS6BMKEB9ZGCTCfgUzKprdPK6agiHos8PZHWO
   9qKH9VVXyYjDxCXRfDYHDTHIafTE6057uHQrz2AAlq8POceKJdsS1l8/T
   MlVfJNpSTT2w741LTdIK/+8MckRSdD1m18K7GAJZXJUjrV/zsI6gKS0mA
   TKD8e7c/g4V4KV0eEV8O0XXjtj5MOHLF7InuOTV3rCNBwNLZK9JVAZVbX
   sX64XjnuDjsVXWZIGAlRF9ekzwp7GaViIZUULG97kwpmw431fdK6QN+A7
   Xf+Bg6cF4/nSuc+84hBMO9SgzLILxcXOwoW3EHIKrIJlhoDQj4dpYkeW5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="10528855"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
   d="scan'208";a="10528855"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:22:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3FvPhfcwn0m1nDUG6JvOrv30hNgi2fzhEAK1ms0VDXmWFen78dXuaZt2awBuE4lkQnVDW2bIEIsE52iI20YmYbViqZOLNNpOFBKnEm47qgfzfwvcaovMlsg+aeuRMlDr5OtD4aWIEmRTZHswOhiyL5uUdOc3jOmY8JJVJbohLQWtptLtajJOst8EOnMMgxoS8egucKdSyg7vTogkZFIREDrrc65bWLZJVXX7qQLlKJ7foncOUg/BsJooWtdr5//NrEh/NqBeSIR+tQm85afupyonGSUz6mRaCZ8g8arek+6uFY2mpioVL5wzHBykQ0KKrBH+WOBstTJX0JX3uhTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0nE0SiLUG0TNTK+nTnzcmk1fck7TSK1CagEPH4M+do=;
 b=lL8F+Fdg71pjYt9SF64civmOZ93h1sLMv9q5K14MD1icgCheXt3Wgl3hf9IIoLr2DENYaq/qvYoEr0J60/p+AiXdm65K4lvHFOBqOpawHQtQk/bCBztsZ1f1Rk1BL3evaQNhAIvaV45AGHqn1mWknr1+VJV56i3ZJT3HQubqpX1i4I0AV9tCqyFsXtPXtkLrolo6p7klzTtvoyglmnVVjmOmBXn0dqbeEgqsLEV/6MzKqSsTqD8kRMAuRPFjJlv+4uW46X9ZTSlJ3PS3RHK3XHYEOEQ8KwVt1ciyD8VUlMkDeQP8wnUlzHxOkEuzAotISpx2B29oYfcWO7fTqk8JNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB10811.jpnprd01.prod.outlook.com (2603:1096:400:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:22:54 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 05:22:53 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Markus Armbruster <armbru@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "quintela@redhat.com" <quintela@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Topic: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Index: AQHZ6j9fgex1HQn4skmnwwB9vRYjH7AspjSAgAABUICAADsohIABuXlrgA8vfICADrOigIABIDEA
Date:   Tue, 17 Oct 2023 05:22:53 +0000
Message-ID: <a9f234af-c479-4567-ae44-c0a79b790fd6@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
 <87ttrhgu9e.fsf@pond.sub.org> <87zg17dejj.fsf@pond.sub.org>
 <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
 <20231016121123.GD282036@ziepe.ca>
In-Reply-To: <20231016121123.GD282036@ziepe.ca>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB10811:EE_
x-ms-office365-filtering-correlation-id: d0c6b1dc-3633-4a11-944d-08dbced11d5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oL/cog8ziIMgeiebwzBlgovSuIkqqkRbMiw6IOP7H24/Rsl/v85SLHGGyhL7D6bZJ7z0kldyt27Kq2LVJpXJcbWBiwXGKV9SEBedJ4x/3tlyApKgIc4G04q+R7/A3savp71mA8rRg/r7TBM4+JRmbEOwZ6VQdCHJvApCsE9S8u/LheFpdma4+T+KpSdGa1T5/KTWsiSJMF9/FFaDLdR1zd6YPBcT35skPVB3UqiaK6ISio/x4LmMESAtexvywIdZjYnf25qxWzIjbRPI5ViWQJky3+JJeAqbzgKjoNsZqTWOBealBjhxObWGGtaWT9AJmpmXmtFeG3DFZu5PmRdKnDmQS+BxBGzz9LoA0tHP3PQvFj8TsXtZlxMZGZMmCsssrGWfTvQvqKsZk6Pyl+m1vYu2AB9jvlpMCUeC4oOe2mpqBCiFLd2APCo1tSCvqFmhm+pc3bgst/NAvGUhcwJh1Ny7yLn0fHrotyo229ADZiOUr9ZwtMdRfVDY0LWNKeqxJ1wYUh4dxtf1xxIDdeGkbVDayJEGMidobsPGnA+eeH1pgmm4+fftWoXeFkEFeyFkk83Wl0j7HFO4p5vVWkQx8TxNtgJ65jAScqjAE72JlHJSZ999QRz56thEy+2GZNbjICLs7gWnwFrO3XA0Jb9tlaB4YGEN0I+kBr7Po9qs72qnTi4rLAiUw25zPWLWhCNqrf2XbK9VThXnY9LmAUc1kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1590799021)(31686004)(1580799018)(66946007)(478600001)(76116006)(6486002)(71200400001)(91956017)(66446008)(64756008)(54906003)(6916009)(66476007)(66556008)(83380400001)(31696002)(86362001)(82960400001)(38100700002)(316002)(6512007)(2616005)(53546011)(26005)(6506007)(41300700001)(5660300002)(38070700005)(122000001)(85182001)(36756003)(8676002)(2906002)(4326008)(8936002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2dISHh6WldHcjlnYXBpR2ZjcCszY3FRNDNXeDM5QWRxQnVSTUdmamlJYWVs?=
 =?utf-8?B?ZFptSzFSZlYyNUhHZU1nZ0VMTFlBeVZsV1NtUE4xZ3JUbkVzL1JSaDJrNkd2?=
 =?utf-8?B?UVBOOTQ1SkkxRGcvcjJiR3IyZktvRXMvYVo4N01xanVZZ0VwUE5GdE9rMkxO?=
 =?utf-8?B?Mk9aZU5ZazJXUTEzUU9oTHBrVm0wYmwxWkt6ZW8yNHU3UEVMQ1k5cHNrK2ds?=
 =?utf-8?B?bFlCbXF1U2doREpWcFR2ZjJ5YW9OQVFURDhreTFqakdnQmtJQ1laSGh0Nnkr?=
 =?utf-8?B?dHRWOFdjS0ViTTFOYlBIUzJhREFrYmpCVlUwRUs3YThlQzYvUmlJYVdEaGkv?=
 =?utf-8?B?MHNRSHh6TjlXV1VsOEVDbzhucXIrVFJkb2pUdnd2N1JYQkFmMFpVQ2cxazJR?=
 =?utf-8?B?THV0VEpOSytjU2R3VFlVTE9PZS85MVo5T2ZKN25UTmhZOWRwdnB1c3ZhRDVm?=
 =?utf-8?B?NzNhREsyVjFybXVCQ1VremQ2OThLTDZPUmJRd2YvVVYvcWE1dW9neVM5M2lP?=
 =?utf-8?B?TXdpWUlJdFY2MVJpcDIrUm1kc25Wa25WYlZVZVgybG1YYUVlaVJ3Q1hLNzZh?=
 =?utf-8?B?WFowR0JjQUtXQldHbkRlbWRXcTBjbS9lWEJKbnJUL3FOSllBKy9UTGxaS1Vt?=
 =?utf-8?B?bUZGUFdVZytFbVNOR3hLbExMYlUvNndaNVY5L3ZUaUxieWYzUVR3RFBEQmJF?=
 =?utf-8?B?ajlKNm81a0p4ZXFMWHk0Tm9lb25kZlF0dlZydVFGYkRuNS9WTm1RbFJ6N0xy?=
 =?utf-8?B?YU5FZFZ2VXNpVklid3NvMXVDTTEyWTFJVXN4TFhxN0RFM1hkTFJjK3ZoUURJ?=
 =?utf-8?B?Rnljc2FQYVhrVC9IOFdIalVuN3gxOEFNVjlpa3h0YXRCUnRKa3RLc29CaHMr?=
 =?utf-8?B?dklxT3Q5RlBzUjJuc2FSUzNtbkpsTWs0SFNjSnlwTEdqRndHaUFiQ1JoUVlk?=
 =?utf-8?B?d050SFJNUm95dkd5alk3QituYm5rbHZpRlBlR1I0RUl6KytCUmh1TjN2d3VI?=
 =?utf-8?B?VlliV2Z0amNuR29OUXRYQ2M3TjMxWFNKblc2SldVbFBGZDR4MDBWSEd1c2I5?=
 =?utf-8?B?VGJmbUhUNnRXTi9IeHNFMHJ5d0d3NW1GRUJYMDhPOGwwWmsrMVVCdnR0Q1hu?=
 =?utf-8?B?U3Q4NDI5Sjg2aVROekhXWHQ5OXdmai9oS3dQQlhXR0htbUg4WmVSdFZXckFE?=
 =?utf-8?B?UDlMSVNIeGRMckZMQ0hKQ2lRU0RUWVErbFdrVE44UERQYjYyNDl6blJlNVh0?=
 =?utf-8?B?S0JNUlhhK2RwVERkQnFUSy9NbTFKVEtBWENGd1NIbVBKLzR2dUVSOXhEVTMr?=
 =?utf-8?B?OVJUM1F0MElLcGdrbDZLN01helJtYjFuSXJWMnFKV3gzaWpZQlBvTmhld1Ux?=
 =?utf-8?B?WXZJSVJqTWp6WE1oalZFOE5OM1pNbmR3ME1jMThuVEticTFnbEVvYlJEWWVm?=
 =?utf-8?B?c2tqZWFPYWlRUlprbVl5V0pxUktyN0JHRU42eFFXYXNPY01iT2tRUVhqaEJU?=
 =?utf-8?B?emdUcTFZcTJiSFNQVE9Cc2lzRlZlVkk1WWpxcERqRm5IdGIwNjZMRDNXSjN2?=
 =?utf-8?B?NUdvK3FWSmdqK01ZZkNRUUhVU2F6WkhwNmpTNlVxR3NxRmZjQXdvaGlGY2p0?=
 =?utf-8?B?YnBJVEt4QWpLcEk3RE1YcnplelN4SGJDOThXM3grRVlmcUppcWxhRUgvcWlG?=
 =?utf-8?B?aG0xYklCYmtHa3laQ2Q4YVhzVG9JTkZpU1dRNzdJb1BWdFplUzRuWFZKTzBx?=
 =?utf-8?B?dmNmZnRMNHhpSzdGK29oT1A1NGVMQm1Edm1STXc5LzFMWWhMYVZ3clAvbEdD?=
 =?utf-8?B?Mlp5WldVTFlUbkpzeGNCbmtKamxYcVZBS0dwd3hxVzIyeWdnQ3ZUbkxyRHBK?=
 =?utf-8?B?WnFaUVZuaG1lUE1EU3dBdHZ5WS9MY3RGQXJjVkdVWHk5U3Q0ZnExTkhkY0ZW?=
 =?utf-8?B?V09kZmFNWkZJZWpRWHlIcFd0clBQYzlBRS9tZGdWZG52VFZkVjhnWXl1Z01F?=
 =?utf-8?B?NEZaV2E1Z0w3ck1XV0dEZXpGV2wrQW5xY0hCT3BTTEZ5MlJXWFp6YTArNGZn?=
 =?utf-8?B?UmpDQVVyL1h2ZWRHUGFyc3lJVXMrb2RZdFJYa2RrSVJaL0EzWklVdGNuZ3FO?=
 =?utf-8?B?bExCU3NIMnFscFR2TjRRY3pHcVUxUU0vUjgrMDBoV29UR0JUd2N6UUdoQk9r?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <870DA910272BBA4C81D82A853E171C16@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HNc8i8DVpT0ve8GKeITussWjA8x/Em2t7bf+iL4MO/eumPKWntvvy9ZbZNjB+6rgj2hgRDkoFXawjKOLRX8znxd7pF7IffzVr/IeEz21AbH3NGeVuosf0DG2+i8NnNcV5PAxX2z1zg3LnZkR/rt3y4a7sGpMFZ9ftKBX/O0/SKNK/bcLIHI/lE5ftxkCWGvr+raYSk68ZsBOraa+VuhkVRHYglwewSp6III/E9By+2sZ/iUaRYbP4MDW8lXDx4rOOVyZqOSwYzAUaU/mqkcatVMXpT61ziW/33ljeE0IAZwBVOI6zSyJPloaTEurTheOauEQgtdystEbzlAp1ZqqJoWH6FbJPnDkridkq1lSkTOqtneoXCuPMzrjYyRoqDzaPGIwEsmqK6PGWSG7yKIx/Fae9+Z3w/TcxA+fQwofkzwXXXlq9izyNLktN/98S+5X+S7T4m8+vJFyoQtP7VS1eztZCZg49kxaLfxApaK2PJNrs9wakw3stng7eaHDH8DPisar8ubz+MZpjeQiYy//Xf/k/OAjm0xGg5iPEnYeqtFVmnYBiHhw5zdN6zONSUCzPDnHGTATEYyBet1Q39w1ElZQawzNDq0JNa2voRsp3TGLlR3scyQhYvKtvRtOQQJLLuWFVR+VJtdxCpAojwoSTDhOXA4rkGhInwS44ffVxXAvRMz0fLqPuJVsP9PUv1B5R7ahQJD3iCon568SJzunN1EwGVhoQFWqGfnlVCqAOZKZHNG2Z51mFSPZ5ieYYFJs8Cf+MY8UM/e8pRchAky+wRc8JM576fIbGk01QEX8+IXFPraTO3UPCZCgCX7co9Zu6dJq52km0DTKI4l2Tjren6nm5+KWbHiQTee0Kn3cvE4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c6b1dc-3633-4a11-944d-08dbced11d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 05:22:53.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXlhmuC7BwZ541LqQws77JLjg3LxMiAmQRRiDZr4Mucr4t7CGa3tBsqKEooLXlgIZ3K4ziD4EtVzDhhNjMWAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE2LzEwLzIwMjMgMjA6MTEsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gU2F0
LCBPY3QgMDcsIDIwMjMgYXQgMDM6NDA6NTBBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+PiArcmRtYS1jb3JlDQo+Pg0KPj4NCj4+IElzIGdsb2JhbCB2YXJpYWJsZSAqZXJy
bm8qIHJlbGlhYmxlIHdoZW4gdGhlIGRvY3VtZW50YXRpb24gb25seSBzdGF0ZXMNCj4+ICJyZXR1
cm5zIDAgb24gc3VjY2Vzcywgb3IgdGhlIHZhbHVlIG9mIGVycm5vIG9uIGZhaWx1cmUgKHdoaWNo
IGluZGljYXRlcyB0aGUgZmFpbHVyZSByZWFzb24pLiINCj4gDQo+IEkgdGhpbmsgdGhlIGludGVu
dGlvbiBvZiB0aGlzIGxhbmd1YWdlIHdhcyB0aGF0IGFuIGVycm5vIGNvbnN0YW50IGlzDQo+IHJl
dHVybmVkLCB0aGUgY2FsbGVyIHNob3VsZCBub3QgYXNzdW1lIGl0IGlzIHN0b3JlZCBpbiBlcnJu
by4NCj4gDQpVbmRlcnN0b29kLg0KSWYgdGhhdCdzIHRoZSBjYXNlLCBJIHRoaW5rIHNvbWUgcGll
Y2VzIG9mIGNvZGUgd2VyZSBtaXN1bmRlcnN0b29kIGluIFFFTVUgYmVmb3JlLg0KDQoNClRoYW5r
cw0KWmhpamlhbg0KDQo+IGVycm5vIGlzIGRpZmZpY3VsdCwgbWFueSB0aGluZ3Mgb3ZlcndyaXRl
IGl0LCB5b3UgY2FuIGxvb3NlIGl0cyB2YWx1ZQ0KPiBkdXJpbmcgZXJyb3IgaGFuZGxpbmcuDQo+
IA0KPiBKYXNvbg==
