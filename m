Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A17AE335
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjIZBKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 21:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjIZBKU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 21:10:20 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 18:10:13 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFFE10A;
        Mon, 25 Sep 2023 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695690614; x=1727226614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eOeYdT6tFzdVilzFygv5QVfd5/C8UrnvFqoCaSJN2fk=;
  b=xkxtKSH3uRAVWAsu4a6qrwwzyph62rszjnSsMrUL9RWrSK6BmaPDz/Xf
   2kjS4oCkWUWSU4jbbki9vUikdm2hUFxpEvLYbYbQMzoGo+Mp3ldrVGWZk
   YfUuC9LpH3v7vq2XTrqsGBQN4I+4m+wu3kwg9C1nhNlO/D41/aQcnyuQR
   eiOrfKd9ty1WI7daiDUBuuKlEXvbRsjOF7irTO1RsH+p5wTM9iLTWRXJ5
   PFtufD4jtX+Vnp0pZ9I8xLOkB4VRb9Zkliyg7+QXYH4U2LnlPz9wuhO9C
   2ATvR+5889SEwu6YURdjl/yFXJLoPVY9oqbt0W7P7hC5gklaRe/hqTFKv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7706071"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; 
   d="scan'208";a="7706071"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:09:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbOl7hMwh9yi57eZG0bhwlX0ns7aXeA0vW2a3ABtD1r6KJFA6Ca7ImlvZRGXvA4qh6xF/ScWb/KGunrsdNFKWpYCOdl2j99Z5WOKnkfgDqo/1fIIqIVwq++1wJu8sLwuNAwavROS2Whts00kW2FAnMDJAYuk9wNwUuuluSJcBab4mPUtXm7jcbp31/5jnLgef/YAbg+q9MJhQryy4oUMW/bhuAL70pXBF+rOjdOftD5IYxz7y+NAZ7CXb7n051Gwo/BT4ADU/IddEPvFKO8a5MwZzvFNVZadFq6QaN2oniM3eTQFUnoSUNy/PcyejEaIlr9pmdDKM5EVjoRus7R/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOeYdT6tFzdVilzFygv5QVfd5/C8UrnvFqoCaSJN2fk=;
 b=H+zBvy0hvjFuPRXHVZW68YlAAjOkBsJwmGo3DWpuICVL41DbYnyUXW+/mrBJ+N18A5mICZOGc3+ZSIAl5nuEiQxV0OdFChg6TYzF99cYm2rNm9Z+DdJUL5CkBfmGeVOBnHKK40g0TczJ3K93WAfYk2+YPWCVbM4JC5mtXfEAHJHmz3FV4+L2A3v0YWn0Xp+CjyGElwFwZwN7UfzCN3/cmEChvxRFVJReUHqd+nfyvoW04iNy9659lcsaQjCtIlTH4Ys+USRQ15U98NLq8eI59I37R3b8eXB3sOLFFbV3CgMT/6j9G+epT7z2D5G+tOYmzwceUpgMLEbPEiVyUJ2Lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by OSRPR01MB11597.jpnprd01.prod.outlook.com (2603:1096:604:22f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:09:02 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:09:02 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAIAAQSmAgACo/YCAAKqdAIAAybuAgAADVACAAAvRAIAAARmAgAAB7YCAAWLiu4AACHmAgAHFvwCAAgi0AIABpikggADJ0wCAAK9TQA==
Date:   Tue, 26 Sep 2023 01:09:02 +0000
Message-ID: <OS7PR01MB11804B7BFCD8A3DF78E51DD5CE5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a940c460-af66-df45-f718-b669746880db@linux.dev>
In-Reply-To: <a940c460-af66-df45-f718-b669746880db@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YThhMTk4MTEtZjcxYy00NzAyLWJkYWItZGZkZjNhZjYy?=
 =?utf-8?B?YTZmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yNlQwMDo1ODozNlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|OSRPR01MB11597:EE_
x-ms-office365-filtering-correlation-id: cb5d63be-ec43-4b49-67fc-08dbbe2d2bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Che5zd2celbylQw3V0ku7mEKJEjiY7YBaM4Vbaer3gcGZbcxzVvUy9kcTOwY915udSyE/0XfsGL2uVszB2WTNxpKA1tEHT/W4238pkGUo2AoxrNzSghOcIpuqHA7iDHjPkLvyrndqIf80cnKWN3CSGNw7dATxRpBPm5FBgAH1Um/l5XjTU5Qz2k46uCL7Wt7M+sECuBcPZgp6Vwq27usbt956mFgaRbMBRWew3I60xeEhdrHD8PbKlu/F03PdMykknEryIGD4KfiXUS7Oh10v7xlGnS4Gxm/Q53c4VkfIp+y3CC2bRsujVipYAUHerZ188d2TRtUvDI8QQryFXVGJhj8sVmHY2jvlh0hSSpoISpY2/qlncSgVpDHAjhRZjBwCculMy7A/ZNUisLpHYCRRi/2IyypVFge0itR5pVETszrKNmZ1+1jOmN+/QiWCk8GbEMTYcOlr/i88T1s1pd7vLBi+ZFmf8dSW4HqqEyWAYlTj8chnw4uR7ozYVUMBXrSSdVBIcoqcaJ8JWzRHrJH5Oc4cLGu4rOyFHrZQoOlEz2IxSBf7ljfBPb0LCokgGW6Oi/riNOMKYIEpTgqveNMLpljg6gh01D8GY+1LpFvvwnUr91j+s0gNr6Tig3spDyPwrlRwi0Wr39kZFlVGdd2sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(1590799021)(2906002)(86362001)(1580799018)(966005)(33656002)(38070700005)(85182001)(9686003)(7696005)(6506007)(5660300002)(38100700002)(53546011)(83380400001)(71200400001)(122000001)(82960400001)(478600001)(55016003)(4326008)(8676002)(8936002)(41300700001)(26005)(52536014)(110136005)(76116006)(66446008)(66476007)(54906003)(66946007)(66556008)(64756008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amtwRUQxdWhRSUdwRmdkOFFFRGpEeEZuUC9ZUnVwaUNtV3pEVGxvenhDM3VP?=
 =?utf-8?B?TjhXWkI3eWpVUEhyY2pRMWFaUFJISU9adWxZR2pRK24wTkRsOVpzZUlYRHRH?=
 =?utf-8?B?amxvU25ENzRDd0trc01raDZyZm9UVUxjWTdrZ0QvWUozcXo5dFhRdEFvUlNP?=
 =?utf-8?B?R0NWSWRyRHN1NTEyYjdia3ZHV2Z1TVQwQXMxbWltMVZEekpWMEpiOFV4RGhl?=
 =?utf-8?B?YmZ3SWFGb0J1ZVFCS1dqalNCSDVNcTBkTE1hRnFLS3dpU1liVHdVcDdEWXBa?=
 =?utf-8?B?RUgwT1ZKY0RXbHlTMWVTS3dXdVltVVpwejgwMG1uODlTRExlWEpUR0VoRU5S?=
 =?utf-8?B?Y2tNSHBLVjd2RVNsZ1ZVazBXQUNRUUNUNUhhM0t0NGtOcGpSRjEvR2ZaVjds?=
 =?utf-8?B?cXFmZmIvbmlaRWZLb3JkU0hTNENzTVRTTXJOOFpaYWI2M1c3bE9lRTFKK1pV?=
 =?utf-8?B?VndTVG1uT2s2ZFhYVkVla2xCZURZcjJRRmY5Y3VQeEd0OTFIcS9QNzBQa0ZZ?=
 =?utf-8?B?eE1hcnJzTTROTS9ibkIrVTQyYzF1MXp3S24rNTdyejdvekhseG1YZXExQ2I1?=
 =?utf-8?B?TFVFTGJDaGJTejVtRlJ0N1pVbVZVa1hCWXZwWDVSMVovc2MxMHdZcGNSTjFY?=
 =?utf-8?B?bVpkZlNsYUd4c3VJQytHQWxuRGY0RkFUSjN3dGExNUZLTEZ3SGxlbEt3Q2p3?=
 =?utf-8?B?OXU1WjBKT25iS3d4eDcvRkdPZDE1aXdwTEE4Snd0OVM1NWkweC9ZRCtCUlpI?=
 =?utf-8?B?NUQrS3lUTHBEbWlkaVlrbE9aeWszQURaTHl2M1gvRVRlRXRSSDN4bytVTXRZ?=
 =?utf-8?B?cGZOUXpBSCtrMFM1dk1lTXRvRFhlMHVBRS9HclRTU00xS1RBenowajJUUmRj?=
 =?utf-8?B?bW9CSitaZFFRVEFFdWxTZm5TRVU5R2g3K1NOUUVaUHFYVzk1VW1pc2JndW83?=
 =?utf-8?B?SmNTU08zSTlQUkVCWXlocDNpSU5hY2MzRTloSE91RzlLT3VNc0Q0N2gxQVd2?=
 =?utf-8?B?TjJFU0h0SER2b2pXWGowYi9UMHBEelRkMGlHdWFsN2lUbEhyam55NUR5YUZK?=
 =?utf-8?B?UlhuMVVwczhRRGY1TkNPbTJTZ0xvZjBwMk91eHpKeEwvSlJUZmV5VjdZZ3Yv?=
 =?utf-8?B?ZDMwQWxycFFLMyt1dDRzMGhxbDFTK1MweUVqbXg0ZlY1TThVZXV4ajc3SWFm?=
 =?utf-8?B?bHZjZnN4cWxmc0NESHMxUGtHYUdNRVNlMGdOdzZsOTl6NUg4cnUvMkRLamIx?=
 =?utf-8?B?TFY5Tm5kVFJtaitNWERhblJQSUEyTHQvWVlvODhHbHdPUHZKTGJXdTdUUUpj?=
 =?utf-8?B?R0pWbkxYRkhnS3Rtb3lHdEFyM0RKd2ZrckQ2Yi8rem03WXAvWTEyVlhyMm04?=
 =?utf-8?B?VFdjL2hHQzJDL0QxY0FaRFQyVXRqWVV1NHdKd05FL1pYVG9DZ29HUXdoWnUx?=
 =?utf-8?B?MnFCTmxnN3hqK1A0TTQyeFUrWWNGWUJjNkdySWZnNjVmTndLa2gzQlBMSEYx?=
 =?utf-8?B?UStLWDFRdC9mRy9ESGhrMzYxTnJWQnRqd0tuRE8wUjI1WSs1bXBYbWRNd01i?=
 =?utf-8?B?bklkcm55a1FkNklpeVdSSHdsdU0vbFcwTGUzaE5TdmxRemxIaDZRSGhYczdP?=
 =?utf-8?B?c1JRbUs3ejI2d3k3cnJGanNnRUQxL1QyRk5XdWVidmVYak94NmRBcUhoUzR3?=
 =?utf-8?B?UTNydXpJdit2Z2F0SmRmSEVxbFZUM3J2NUdIcDU2cnozZm5xR3RSTWM0TnBZ?=
 =?utf-8?B?UXZpd1d6Kzg4b1pPTXdoQ2k5aVlNbkJ5YVk1d1NlUHNmbGRQZU1JU0c2QlNX?=
 =?utf-8?B?S0FzTFhHWm85N1NidDlpdEhENmhoTVZSSTkwbGpXNzdnWVJtSDQ2QytHZE9C?=
 =?utf-8?B?UHZhTjNWQ0xTNHdZdjdSSXRkR3ZNNG5NM1V1UGJmdjUzeVlkeWJaVEVIekZQ?=
 =?utf-8?B?OWJUaWNsblNUaXBtTHEvUWhTYlZMODNXaVhrQ3BXUGZsMU5SemtxWTBTelFY?=
 =?utf-8?B?NzNZeFNibnBvQXJuUE5oT2lXOUlra1A5TndqZ3Z1a1RLUVQrTXNRUmVLcXAv?=
 =?utf-8?B?eFI0c1RnR1BoaXNiTVZ2ZnNJR3preTkrbStJVk1oMUsrZUJDVjNZNzlEcUI5?=
 =?utf-8?B?U3E3YWQwNWVjVmpUNWpGa0JmTXNGWCtCVzF3Rnl2RzE0K1plNHRNYkx2Yjgx?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AJB8DGOk4fgWOf4CGIxaR1DyZA68bm6alVzphOICzfNFPo+gN2jqA0FbVTnfVA4C92t2Nd8IRzGgHcV4fWFZr+0sGbcP1WsQHfWWUYiw7lzFUALSVBzJQcMfERgKSAzmJMXdiT+ft4tqujWb44fE8VvJViOutI5QME8eFvs4q1VU7bxzaA/tjyEIhBEIgJwmW5CmgfxUAl3w2xxoD9TDiTKdlLkfhdbgnStBQxfXMg3VeT832X2CMzQhbMFXuIVlY6HNsnkBPN/2OETW6tl21R8J5l0bDpzcmCNOpvvAXbNoCg5Z9bQoLkHRqQQO8YGyLCkLe0ZAn42uu6QxOKPUvq92zrfOGAK9/DEY17totEFfC9b4QHvNMTq53AX+4Qr/wpg0z44UsPVhL3KoAIIpYOmSJUObY+1SQIq7unokoHuKrFV6zajfS8B56x/6K59c4iUmqPbxhNvrhUrcZX8bGa5z7UFX3K2quXQoimBR4nKWAt8ktQM8lOQu3BGL357K578jZ3nAWSPLoMxnVnwtiUm3NUvHb7oaFSB6+MLm5DU7WIZdkl4YGYCNwzbQlrnYON8GZ3dCb+2fX1TNjM3NfaH0T8C5DLKvRnzHkwlT3EAVkKdB06Ih7aP+swH3m83Sqs/ZYrM40RoXnf9a+zYKeWepy3oSaNjXtKHr0CrBFeD83eVq5+yXgtEZYUKN2h6b/JBtJ5ZNiIGyqIPGZgSbntrL7s+XYoxif7C0JAF5YrbOSfZVvJT1TfvDkH3g9P6bbHf4jUps0jTe9diXSqOUKDx6mrWVoF+gWVI60w8ECMm6YsSozQg7aUkbAtMPLtGIKo454jjiM6Q56kD7wkf8hBBJsoCRgCW4TMekzHTrrH2OgeGZf0unQUahVqM0bvCb1LE18A8UIUmEoM0EtRz5h79rOEUkwoiBOlg2fXYtuE4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5d63be-ec43-4b49-67fc-08dbbe2d2bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:09:02.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvo/zO/2rGWB46Iot9vUhbWkGB7tSkuYdA5kwf7aAM+tgxcBddZq9vGypZtto6fshXuEKz1vFTUIsO14oboIff89EHn/qHuTS5/HQFqcB8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11597
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMjUsIDIwMjMgMTE6MzEgUE0gWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51
eC5kZXY+IHdyb3RlOg0KPiDlnKggMjAyMy85LzI1IDEyOjQ3LCBEYWlzdWtlIE1hdHN1ZGEgKEZ1
aml0c3UpIOWGmemBkzoNCj4gPiBPbiBTdW4sIFNlcCAyNCwgMjAyMyAxMDoxOCBBTSBSYWluIFJp
dmVyIHdyb3RlOg0KPiA+PiBPbiBTYXQsIFNlcCAyMywgMjAyMyBhdCAyOjE04oCvQU0gQm9iIFBl
YXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+PiBPbiA5LzIxLzIzIDEw
OjEwLCBaaHUgWWFuanVuIHdyb3RlOg0KPiA+Pj4+IOWcqCAyMDIzLzkvMjEgMjI6MzksIEJvYiBQ
ZWFyc29uIOWGmemBkzoNCj4gPj4+Pj4gT24gOS8yMS8yMyAwOToyMywgUmFpbiBSaXZlciB3cm90
ZToNCj4gPj4+Pj4+IE9uIFRodSwgU2VwIDIxLCAyMDIzIGF0IDI6NTPigK9BTSBCb2IgUGVhcnNv
biA8cnBlYXJzb25ocGVAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+PiBPbiA5LzIwLzIzIDEy
OjIyLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4+Pj4+Pj4+IE9uIDkvMjAvMjMgMTA6MTgs
IEJvYiBQZWFyc29uIHdyb3RlOg0KPiA+Pj4+Pj4+Pj4gQnV0IEkgaGF2ZSBhbHNvIHNlZW4gdGhl
IHNhbWUgYmVoYXZpb3IgaW4gdGhlIHNpdyBkcml2ZXIgd2hpY2ggaXMNCj4gPj4+Pj4+Pj4+IGNv
bXBsZXRlbHkgaW5kZXBlbmRlbnQuDQo+ID4+Pj4+Pj4+IEhtbSAuLi4gSSBoYXZlbid0IHNlZW4g
YW55IGhhbmdzIHlldCB3aXRoIHRoZSBzaXcgZHJpdmVyLg0KPiA+Pj4+Pj4+IEkgd2FzIG9uIFVi
dW50dSA2LTkgbW9udGhzIGFnby4gQ3VycmVudGx5IEkgZG9uJ3Qgc2VlIGhhbmdzIG9uIGVpdGhl
ci4NCj4gPj4+Pj4+Pj4+IEFzIG1lbnRpb25lZCBhYm92ZSBhdCB0aGUgbW9tZW50IFVidW50dSBp
cyBmYWlsaW5nIHJhcmVseS4gQnV0IGl0IHVzZWQgdG8gZmFpbCByZWxpYWJseSAoc3JwLzAwMiBh
Ym91dCA3NSUNCj4gb2YNCj4gPj4gdGhlIHRpbWUgYW5kIHNycC8wMTEgYWJvdXQgOTklIG9mIHRo
ZSB0aW1lLikgVGhlcmUgaGF2ZW4ndCBiZWVuIGFueSBjaGFuZ2VzIHRvIHJ4ZSB0byBleHBsYWlu
IHRoaXMuDQo+ID4+Pj4+Pj4+IEkgdGhpbmsgdGhhdCBaaHUgbWVudGlvbmVkIGNvbW1pdCA5YjRi
N2MxZjlmNTQgKCJSRE1BL3J4ZTogQWRkIHdvcmtxdWV1ZQ0KPiA+Pj4+Pj4+PiBzdXBwb3J0IGZv
ciByeGUgdGFza3MiKT8NCj4gPj4+Pj4+PiBUaGF0IGNoYW5nZSBoYXBwZW5lZCB3ZWxsIGJlZm9y
ZSB0aGUgZmFpbHVyZXMgd2VudCBhd2F5LiBJIHdhcyBzZWVpbmcgZmFpbHVyZXMgYXQgdGhlIHNh
bWUgcmF0ZSB3aXRoIHRhc2tsZXRzDQo+ID4+Pj4+Pj4gYW5kIHdxcy4gQnV0IGFmdGVyIHVwZGF0
aW5nIFVidW50dSBhbmQgdGhlIGtlcm5lbCBhdCBzb21lIHBvaW50IHRoZXkgYWxsIHdlbnQgYXdh
eS4NCj4gPj4+Pj4+IEkgbWFkZSB0ZXN0cyBvbiB0aGUgbGF0ZXN0IFVidW50dSB3aXRoIHRoZSBs
YXRlc3Qga2VybmVsIHdpdGhvdXQgdGhlDQo+ID4+Pj4+PiBjb21taXQgOWI0YjdjMWY5ZjU0ICgi
UkRNQS9yeGU6IEFkZCB3b3JrcXVldWUgc3VwcG9ydCBmb3IgcnhlIHRhc2tzIikuDQo+ID4+Pj4+
PiBUaGUgbGF0ZXN0IGtlcm5lbCBpcyB2Ni42LXJjMiwgdGhlIGNvbW1pdCA5YjRiN2MxZjlmNTQg
KCJSRE1BL3J4ZTogQWRkDQo+ID4+Pj4+PiB3b3JrcXVldWUgc3VwcG9ydCBmb3IgcnhlIHRhc2tz
IikgaXMgcmV2ZXJ0ZWQuDQo+ID4+Pj4+PiBJIG1hZGUgYmxrdGVzdCB0ZXN0cyBmb3IgYWJvdXQg
MzAgdGltZXMsIHRoaXMgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ci4NCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBTbyBJIGNvbmZpcm0gdGhhdCB3aXRob3V0IHRoaXMgY29tbWl0LCB0aGlzIGhhbmcgcHJvYmxl
bSBkb2VzIG5vdA0KPiA+Pj4+Pj4gb2NjdXIgb24gVWJ1bnR1IHdpdGhvdXQgdGhlIGNvbW1pdCA5
YjRiN2MxZjlmNTQgKCJSRE1BL3J4ZTogQWRkDQo+ID4+Pj4+PiB3b3JrcXVldWUgc3VwcG9ydCBm
b3IgcnhlIHRhc2tzIikuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTmFudGhhbg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+Pj4gVGhhbmtzLA0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBCYXJ0Lg0KPiA+Pj4+PiBU
aGlzIGNvbW1pdCBpcyB2ZXJ5IGltcG9ydGFudCBmb3Igc2V2ZXJhbCByZWFzb25zLiBJdCBpcyBu
ZWVkZWQgZm9yIHRoZSBPRFAgaW1wbGVtZW50YXRpb24NCj4gPj4+Pj4gdGhhdCBpcyBpbiB0aGUg
d29ya3MgZnJvbSBEYWlzdWtlIE1hdHN1ZGEgYW5kIGFsc28gZm9yIFFQIHNjYWxpbmcgb2YgcGVy
Zm9ybWFuY2UuIFRoZSB3b3JrDQo+ID4+Pj4+IHF1ZXVlIGltcGxlbWVudGF0aW9uIHNjYWxlcyB3
ZWxsIHdpdGggaW5jcmVhc2luZyBxcCBudW1iZXIgd2hpbGUgdGhlIHRhc2tsZXQgaW1wbGVtZW50
YXRpb24NCj4gPj4+Pj4gZG9lcyBub3QuIFRoaXMgaXMgY3JpdGljYWwgZm9yIHRoZSBkcml2ZXJz
IHVzZSBpbiBsYXJnZSBzY2FsZSBzdG9yYWdlIGFwcGxpY2F0aW9ucy4gU28sIGlmDQo+ID4+Pj4+
IHRoZXJlIGlzIGEgYnVnIGluIHRoZSB3b3JrIHF1ZXVlIGltcGxlbWVudGF0aW9uIGl0IG5lZWRz
IHRvIGJlIGZpeGVkIG5vdCByZXZlcnRlZC4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBhbSBzdGlsbCBo
b3BpbmcgdGhhdCBzb21lb25lIHdpbGwgZGlhZ25vc2Ugd2hhdCBpcyBjYXVzaW5nIHRoZSBVTFBz
IHRvIGhhbmcgaW4gdGVybXMgb2YNCj4gPj4+Pj4gc29tZXRoaW5nIG1pc3NpbmcgY2F1c2luZyBp
dCB0byB3YWl0Lg0KPiA+Pj4+IEhpLCBCb2INCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gWW91IHN1
Ym1pdHRlZCB0aGlzIGNvbW1pdCA5YjRiN2MxZjlmNTQgKCJSRE1BL3J4ZTogQWRkIHdvcmtxdWV1
ZSBzdXBwb3J0IGZvciByeGUgdGFza3MiKS4NCj4gPj4+Pg0KPiA+Pj4+IFlvdSBzaG91bGQgYmUg
dmVyeSBmYW1pbGlhciB3aXRoIHRoaXMgY29tbWl0Lg0KPiA+Pj4+DQo+ID4+Pj4gQW5kIHRoaXMg
Y29tbWl0IGNhdXNlcyByZWdyZXNzaW9uLg0KPiA+Pj4+DQo+ID4+Pj4gU28geW91IHNob3VsZCBk
ZWx2ZWQgaW50byB0aGUgc291cmNlIGNvZGUgdG8gZmluZCB0aGUgcm9vdCBjYXVzZSwgdGhlbiBm
aXggaXQuDQo+ID4+PiBaaHUsDQo+ID4+Pg0KPiA+Pj4gSSBoYXZlIHNwZW50IHRvbnMgb2YgdGlt
ZSBvdmVyIHRoZSBtb250aHMgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2hhdCBpcyBoYXBwZW5pbmcg
d2l0aCBibGt0ZXN0cy4NCj4gPj4+IEFzIEkgaGF2ZSBtZW50aW9uZWQgc2V2ZXJhbCB0aW1lcyBJ
IGhhdmUgc2VlbiB0aGUgc2FtZSBleGFjdCBmYWlsdXJlIGluIHNpdyBpbiB0aGUgcGFzdCBhbHRo
b3VnaA0KPiA+Pj4gY3VycmVudGx5IHRoYXQgZG9lc24ndCBzZWVtIHRvIGhhcHBlbiBzbyBJIGhh
ZCBiZWVuIHN1c3BlY3RpbmcgdGhhdCB0aGUgcHJvYmxlbSBtYXkgYmUgaW4gdGhlIFVMUC4NCj4g
Pj4+IFRoZSBjaGFsbGVuZ2UgaXMgdGhhdCB0aGUgYmxrdGVzdHMgcmVwcmVzZW50cyBhIGh1Z2Ug
c3RhY2sgb2Ygc29mdHdhcmUgbXVjaCBvZiB3aGljaCBJIGFtIG5vdA0KPiA+Pj4gZmFtaWxpYXIg
d2l0aC4gVGhlIGJ1ZyBpcyBhIGhhbmcgaW4gbGF5ZXJzIGFib3ZlIHRoZSByeGUgZHJpdmVyIGFu
ZCBzbyBmYXIgbm8gb25lIGhhcyBiZWVuIGFibGUgdG8NCj4gPj4+IHNheSB3aXRoIGFueSBzcGVj
aWZpY2l0eSB0aGUgcnhlIGRyaXZlciBmYWlsZWQgdG8gZG8gc29tZXRoaW5nIG5lZWRlZCB0byBt
YWtlIHByb2dyZXNzIG9yIHZpb2xhdGVkDQo+ID4+PiBleHBlY3RlZCBiZWhhdmlvci4gV2l0aG91
dCBhbnkgY2x1ZSBhcyB0byB3aGVyZSB0byBsb29rIGl0IGhhcyBiZWVuIGhhcmQgdG8gbWFrZSBw
cm9ncmVzcy4NCj4gPj4gQm9iDQo+ID4+DQo+ID4+IFdvcmsgcXVldWUgd2lsbCBzbGVlcC4gSWYg
d29yayBxdWV1ZSBzbGVlcCBmb3IgbG9uZyB0aW1lLCB0aGUgcGFja2V0cw0KPiA+PiB3aWxsIG5v
dCBiZSBzZW50IHRvIFVMUC4gVGhpcyBpcyB3aHkgdGhpcyBoYW5nIG9jY3Vycy4NCj4gPiBJbiBn
ZW5lcmFsIHdvcmsgcXVldWUgY2FuIHNsZWVwLCBidXQgdGhlIHdvcmtsb2FkIHJ1bm5pbmcgaW4g
cnhlIGRyaXZlcg0KPiA+IHNob3VsZCBub3Qgc2xlZXAgYmVjYXVzZSBpdCB3YXMgb3JpZ2luYWxs
eSBydW5uaW5nIG9uIHRhc2tsZXQgYW5kIGNvbnZlcnRlZA0KPiA+IHRvIHVzZSB3b3JrIHF1ZXVl
LiBBIHRhc2sgY2FuIHNvbWV0aW1lIHRha2UgbG9uZ2VyIGJlY2F1c2Ugb2YgSVJRcywgYnV0DQo+
ID4gdGhlIHNhbWUgdGhpbmcgY2FuIGFsc28gaGFwcGVuIHdpdGggdGFza2xldC4gSWYgdGhlcmUg
aXMgYSBkaWZmZXJlbmNlIGJldHdlZW4NCj4gPiB0aGUgdHdvLCBJIHRoaW5rIGl0IHdvdWxkIGJl
IHRoZSBvdmVyaGVhZCBvZiBzY2hlZHVyaW5nIHRoZSB3b3JrIHF1ZXVlLg0KPiA+DQo+ID4+IERp
ZmZpY3VsdCB0byBoYW5kbGUgdGhpcyBzbGVlcCBpbiB3b3JrIHF1ZXVlLiBJdCBoYWQgYmV0dGVy
IHJldmVydA0KPiA+PiB0aGlzIGNvbW1pdCBpbiBSWEUuDQo+ID4gSSBhbSBvYmplY3RlZCB0byBy
ZXZlcnRpbmcgdGhlIGNvbW1pdCBhdCB0aGlzIHN0YWdlLiBBcyBCb2Igd3JvdGUgYWJvdmUsDQo+
ID4gbm9ib2R5IGhhcyBmb3VuZCBhbnkgbG9naWNhbCBmYWlsdXJlIGluIHJ4ZSBkcml2ZXIuIEl0
IGlzIHF1aXRlIHBvc3NpYmxlDQo+ID4gdGhhdCB0aGUgcGF0Y2ggaXMganVzdCByZXZlYWxpbmcg
YSBsYXRlbnQgYnVnIGluIHRoZSBoaWdoZXIgbGF5ZXJzLg0KPiANCj4gVG8gbm93LCBvbiBEZWJp
YW4gYW5kIEZlZG9yYSwgYWxsIHRoZSB0ZXN0cyB3aXRoIHdvcmsgcXVldWUgd2lsbCBoYW5nLg0K
PiBBbmQgYWZ0ZXIgcmV2ZXJ0aW5nIHRoaXMgY29tbWl0LA0KPiANCj4gbm8gaGFuZyB3aWxsIG9j
Y3VyLg0KPiANCj4gQmVmb3JlIG5ldyB0ZXN0IHJlc3VsdHMsIGl0IGlzIGEgcmVhc29uYWJsZSBz
dXNwZWN0IHRoYXQgdGhpcyBjb21taXQNCj4gd2lsbCByZXN1bHQgaW4gdGhlIGhhbmcuDQoNCklm
IHRoZSBoYW5nICphbHdheXMqIG9jY3VycywgdGhlbiBJIGFncmVlIHlvdXIgb3BpbmlvbiBpcyBj
b3JyZWN0LA0KYnV0IHRoaXMgb25lIGhhcHBlbnMgb2NjYXNpb25hbGx5LiBJdCBpcyBhbHNvIG5h
dHVyYWwgdG8gdGhpbmsgdGhhdA0KdGhlIGNvbW1pdCBtYWtlcyBpdCBlYXNpZXIgdG8gbWVldCB0
aGUgY29uZGl0aW9uIG9mIGFuIGV4aXN0aW5nIGJ1Zy4NCg0KPiANCj4gPg0KPiA+PiBCZWNhdXNl
IHdvcmsgcXVldWUgc2xlZXBzLCAgVUxQIGNhbiBub3Qgd2FpdCBmb3IgbG9uZyB0aW1lIGZvciB0
aGUNCj4gPj4gcGFja2V0cy4gSWYgcGFja2V0cyBjYW4gbm90IHJlYWNoIFVMUHMgZm9yIGxvbmcg
dGltZSwgbWFueSBwcm9ibGVtcw0KPiA+PiB3aWxsIG9jY3VyIHRvIFVMUHMuDQo+ID4gSSB3b25k
ZXIgd2hlcmUgaW4gdGhlIHJ4ZSBkcml2ZXIgZG9lcyBpdCBzbGVlcC4gQlRXLCBtb3N0IHBhY2tl
dHMgYXJlDQo+ID4gcHJvY2Vzc2VkIGluIE5FVF9SWF9JUlEgY29udGV4dCwgYW5kIHdvcmsgcXVl
dWUgaXMgc2NoZWR1bGVkIG9ubHkNCj4gDQo+IERvIHlvdSBtZWFuIE5FVF9SWF9TT0ZUSVJRPw0K
DQpZZXMuIEkgYW0gc29ycnkgZm9yIGNvbmZ1c2luZyB5b3UuDQoNClRoYW5rcywNCkRhaXN1a2UN
Cg0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4gPiB3aGVuIHRoZXJlIGlzIGFscmVhZHkgYSBydW5u
aW5nIGNvbnRleHQuIElmIHlvdXIgc3BlY3VsYXRpb24gaXMgdG8gdGhlIHBvaW50LA0KPiA+IHRo
ZSBoYW5nIHdpbGwgb2NjdXIgbW9yZSBmcmVxdWVudGx5IGlmIHdlIGNoYW5nZSBpdCB0byB1c2Ug
d29yayBxdWV1ZSBleGNsdXNpdmVseS4NCj4gPiBNeSBPRFAgcGF0Y2hlcyBpbmNsdWRlIGEgY2hh
bmdlIHRvIGRvIHRoaXMuDQo+ID4gQ2YuDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
NzY5OWE5MGJjNGFmMTBjMzNjMGE0NmVmNjMzMGVkNGJiN2U3YWNlNi4xNjk0MTUzMjUxLmdpdC5t
YXRzdWRhLWRhaXN1a2VAZnVqaXRzdS5jDQo+IG9tLw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IERh
aXN1a2UNCj4gPg0KPiA+Pj4gTXkgbWFpbiBtb3RpdmF0aW9uIGlzIG1ha2luZyBMdXN0cmUgcnVu
IG9uIHJ4ZSBhbmQgaXQgZG9lcyBhbmQgaXQncyBmYXN0IGVub3VnaCB0byBtZWV0IG91ciBuZWVk
cy4NCj4gPj4+IEx1c3RyZSBpcyBzaW1pbGFyIHRvIHNycCBhcyBhIFVMUCBhbmQgaW4gYWxsIG9m
IG91ciB0ZXN0aW5nIHdlIGhhdmUgbmV2ZXIgc2VlbiBhIHNpbWlsYXIgaGFuZy4gT3RoZXINCj4g
Pj4+IGhhbmdzIHRvIGJlIHN1cmUgYnV0IG5vdCB0aGlzIG9uZS4gSSBiZWxpZXZlIHRoYXQgdGhp
cyBidWcgd2lsbCBuZXZlciBnZXQgcmVzb2x2ZWQgdW50aWwgc29tZW9uZSB3aXRoDQo+ID4+PiBh
IGdvb2QgdW5kZXJzdGFuZGluZyBvZiB0aGUgdWxwIGRyaXZlcnMgbWFrZXMgYW4gZWZmb3J0IHRv
IGZpbmQgb3V0IHdoZXJlIGFuZCB3aHkgdGhlIGhhbmcgaXMgb2NjdXJyaW5nLg0KPiA+Pj4gIEZy
b20gdGhlcmUgaXQgc2hvdWxkIGJlIHN0cmFpZ2h0IGZvcndhcmQgdG8gZml4IHRoZSBwcm9ibGVt
LiBJIGFtIGNvbnRpbnVpbmcgdG8gaW52ZXN0aWdhdGUgYW5kIGFtIGxlYXJuaW5nDQo+ID4+PiB0
aGUgZGV2aWNlLW1hbmFnZXIvbXVsdGlwYXRoL3NycC9zY3NpIHN0YWNrIGJ1dCBJIGhhdmUgYSBs
b25nIHdheXMgdG8gZ28uDQo+ID4+Pg0KPiA+Pj4gQm9iDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+Pg0K
PiA+Pj4+IEphc29uICYmIExlb24sIHBsZWFzZSBjb21tZW50IG9uIHRoaXMuDQo+ID4+Pj4NCj4g
Pj4+Pg0KPiA+Pj4+IEJlc3QgUmVnYXJkcywNCj4gPj4+Pg0KPiA+Pj4+IFpodSBZYW5qdW4NCj4g
Pj4+Pg0KPiA+Pj4+PiBCb2INCg==
