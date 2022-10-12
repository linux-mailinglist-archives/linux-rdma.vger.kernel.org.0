Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051D75FC15B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJLHlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 03:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJLHlP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 03:41:15 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E22195AE4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665560474; x=1697096474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gV3p9jdsyEZGnreUtF7e3UojF5tF5JyV/D6iqtx/h1Y=;
  b=nxA+wBC1jndvB6M5gClYKO7544gUOgxu9fJB34s9n00Yb2eDQSnBDcfY
   nnrihst5gUJJ+Kqzo/WqqJEBhSR6k5d37JtIuL9lVpP++ywdUpWtMkqx4
   4jB1TWEaqnhUa+2F8qkPPiQv927w9mwKaxa2+t0kNu2vfSEPzxdD/fS7u
   PUHqzhDkvEcEUhhgXVj3Q6Ppc7Kjx5tDQ544djCc0mOO0BjecggAvmGMz
   Fv45726RPk6fZdoVBspSLQNLT9GHfSebMupM8gCOl/RJnXqFsiu+zRI9u
   fjBjEjp11N2npCMWharVnDqBxVcZPrWzRWBrjeyLrn2jx7WfHtG5TboIN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="67304118"
X-IronPort-AV: E=Sophos;i="5.95,178,1661785200"; 
   d="scan'208";a="67304118"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 16:41:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy2t84PqycGDK4UzPQQdLLUkjeMWwXk7Nh/ls1n0z6bnCRbZlDX2wBk03h7+rcINczXJqyCTDuWkC1YhMJuAl/GoK0gB6E03MnrzwZPHvPzUTLESUUuaVK6ortLNX8Thiaz7BRLLZTEaBPeKCMhz5vKw8OClhiWZJjxoboWjZr9+WvmnXwLXr1mbGHCdRBVpafe5T5Or3HIaFtS2yoYlil+3/GyfZDODhY3bSRHVOgy7fTbMuDlANLyhIablsKDlrIZilR99sZ0yKE1YDDn/wWJZWoTF5gYRY3T33vKPeOmT05IM8d2wT9KF+pnITdewYg0PBogJAARyM/sEubB3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV3p9jdsyEZGnreUtF7e3UojF5tF5JyV/D6iqtx/h1Y=;
 b=jJ3ojy40jzecwNRtPdEgLkeg7sSGsCQggghJU33L7uZ36dRgQQ1MyxyQ2wbjacM9cnjijy78eROY1OeML/GGyqxPjDxxX80tajQvnTBR4pWx/E+IBFlHt/wDRWzciY7lSf4kiUDU/ncG/wQplB0+BzNXLnGMDEaLs/Qe0THgz5viCf4t/IZxkb+JE0IIC7PpEcPbH4//O2FdavHiJx/qHixsbSvoRs3ecM7t1DZ4y4Ntcvex2jWLg+jRqr6o9lUmeYPQAfWo/E4QH1Fuf6CBAzwxi2hIpsc9eEnuZ2n6nJrwlW5dSE11OI3rfb90JCByXnv7ktWesya/xAPhj2efFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OSYPR01MB5479.jpnprd01.prod.outlook.com (2603:1096:604:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 07:41:08 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 07:41:08 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        'Bob Pearson' <rpearsonhpe@gmail.com>,
        'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 00/13] Implement the xrc transport
Thread-Topic: [PATCH for-next 00/13] Implement the xrc transport
Thread-Index: AQHYykM9ecjzxQckj0W3lkf079lrYK3yZqwAgAAg4fCABBySAIAAfOlQgBNlmhA=
Date:   Wed, 12 Oct 2022 07:41:08 +0000
Message-ID: <TYCPR01MB84554785DE728A68EFF385C1E5229@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
 <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
 <TYCPR01MB8455C2E2DCD507C32051E929E5579@TYCPR01MB8455.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8455C2E2DCD507C32051E929E5579@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 7c213ff6949b45b7880bd0d1949ecf23
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjlUMjM6NTI6?=
 =?utf-8?B?MjVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0wZWRmODYzNy03Yjc2LTQ0YmQt?=
 =?utf-8?B?ODBiOS05NzcxZDI0ZmY4NTA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OSYPR01MB5479:EE_
x-ms-office365-filtering-correlation-id: 0335e1a3-1125-4a30-1ad9-08daac252063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbZ5YDcWwQ6yfieKhn0sxg0mbTFl1ue+s8saiNzJhNRDGIzZfahTne0Z2+sldf7c7Vg5kM+t5p+P4KNCo7B+Obg6bHU5tofgVeg3ZG9b8Ti+rzjhr843siQilXs/Cwv7/kZbKz++pFPH8Nbu0hNawPp40GVke6+Yzs6F3vnm7qlBnlfF6iwS00OopOqeEmkf27oH8odwe2i4oIX28OcOFk0MJ8LY8YR2qhO75THv6GeHHWrVAZJxhgVAuZVuCxcpKzm87kScaVQlAmFeH9AE2YsbgUfFxbwiJdndl4xLbpiFeZ6wjFi3d2EWG+hod7tQFb0PL6WeM7V8moeUUSHnwOdRg8Y6LzDClgtsD6Q3sCXxwPHed53MGOWFHgtBETKTPqEUsaUqiflkNE9lD1REdmHf656RvNumlR5P+p7b9TqIto+Yy8Pbg3P0Moxs8k6h8sEd52r8Ae99B76x1VbSNzSkqbnzrwcuYGy33wgqO+q824hquyEKi7jY11sawRlC6MFSg0e+umOaq9ErWhpkCE8P3DENF5INoj/glR5jgg+2GFwnDPHRxb0xLyXBGGhJ1BvArbJRGnQCE0nJ1PRKzz8N9ttfcI6VWHshUt7McdvO/pVQ6yS3r/1FR8EnYluMMppHrFrZ527UiLfIqm1mlmwyuneR35vCIfuXG425hoJE7B7J2j/2WLwtP/MyIvvzvvd3qJrW8nbgJPtnrWUxEqsSMloluhDhgdVFjafVRlokesFyKZGRzMdWrzo0GYTsiBf5NPwFvWlNfOp+r69jila+wvpEd2x2q0r5sLIMkLfo56PT+AvhhE3mloDNuzdefSlN2uA0uuDWvL91lLZMp/U5wjsLXJ+EBaYxplfJhnco931ZbKFzCGLPEzqlg6Cn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(1590799012)(451199015)(316002)(8676002)(41300700001)(1580799009)(4326008)(52536014)(2906002)(66446008)(8936002)(64756008)(76116006)(66946007)(66556008)(110136005)(5660300002)(54906003)(66476007)(26005)(71200400001)(86362001)(55016003)(38100700002)(966005)(478600001)(38070700005)(7696005)(33656002)(6506007)(82960400001)(83380400001)(122000001)(85182001)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUlGKzROTlJVZE5WNk1LUWhndGR4OWtMcm85cEQ1U2gwRFJyNkd0QVpDTXUv?=
 =?utf-8?B?aGRDQmUwOHlUWW9ReUo5WWFLdzRWRTl4c0c5anBrc3RKZDBPSVY0SWxFc0lu?=
 =?utf-8?B?SlpTR0ZaZjRaRFVDT01Td2VLd0hTZ2ZHaUpFNE5PSzFTRWtwRzVCYmh0cEc3?=
 =?utf-8?B?UzZiTEg4UmdRL2hYVy9nUGJuM3ZaamM5WVlMVWxXZWtxYUIzbGNHWm9BVHVJ?=
 =?utf-8?B?UVUxTFh3V0EzOERYWEtoWlkrQW1yQWxlWEN3ZVN4MW15VURGdlRkZmF4bWxs?=
 =?utf-8?B?N3cxRFpSc0cwcUpTMEM2NkNXU3ZNTzZEclpGdU9PMXJCY1FoTWhVNzY0bFRw?=
 =?utf-8?B?TTNDdW1VZ1Y4cWRPa2w4UDNoN2tZWk1JaUtNZXFzYjllOW1yYlBVTDNXQ3o3?=
 =?utf-8?B?Qit1Tmp5cjVLZDlIZVlKSW5GbTJQb0k3aVBXaVlSaTJyQXdZVlJvWFd2dyt4?=
 =?utf-8?B?amc1cnE0V1hjaUx0UzhtNUtnck82YVliMjNiWE5ZSkpWUmF3TEZQRU42ZGZG?=
 =?utf-8?B?bngxQ2xQZDh4QkordTNoT1oxRnZhRFhzRE9US1djckp0T0RWWWdQQngvM0pO?=
 =?utf-8?B?UC9BZWZKUGxaRDVWQ0g3aTRVbHMyTHdJQ2FFeFJoRE9TQkI1cTVIMWc1Lzht?=
 =?utf-8?B?VThkbk01cmtqUUV6UitXaVVzU0ZTRWt3dzV4d2hKN2dBaktSZzU4ekJUcytM?=
 =?utf-8?B?aXZaSExyVTB6d1R2a0Flck1VUlpNbjE4d0ZXeUtuTHNuNHlPeHcrT21lQ2s0?=
 =?utf-8?B?cGhnUDZkeWplOTRtd29Nditva0FqVHNKdmg4cFcrd1NRUmVyMDRDM1pwTkd0?=
 =?utf-8?B?a1VhVFlXOEZTdGUrUmdENXlLaVBxMHJhQzU3ZVdNSkdkSUFYcGI1QlhlOXhP?=
 =?utf-8?B?V2t1ZUcyZG40MklnUFJ5NzV3NzY0NkhsOTViYUFUdHZ5Zis2dU1jYWlaMTdD?=
 =?utf-8?B?WUt4YUVyM0Rzdm9hUFBLUzBRTEZlSEo4ckIvQmJ4WTVNVlhXK3JKQjBQeE9J?=
 =?utf-8?B?K290Z3NsUUl0aWdlQ0RETE1lTHZQZUpWVTlHYmhzamVVcmdPMUdwNy9IMVQ2?=
 =?utf-8?B?WEpwWDVkZlZpeGwvTjc2dy9HejlBTWVIZEJrV3pLU2JIVG12blc3Tk04SmJr?=
 =?utf-8?B?dHBJNHVwRXlkbmVlT0oxMVpUOGNNSE1BNDIyODdZbkUzUGVDWklZQ0pKbVJv?=
 =?utf-8?B?RDlKTThBbnk5d3UrUmdraDdNeFlIMk1vblViUms2dWdUU2t5U1RBdHQrVGhn?=
 =?utf-8?B?L1l3RzNpRFo0dEZ2SGs4K3hNdzhXZ1cyUlQ2S2hXQ09tMTBTUUJibG15NnJJ?=
 =?utf-8?B?emxPQzF0TFM4R2wySEljUjBoUnYyYlQxTXVJdjdzOTRuOEFwa3NIYmFIMmph?=
 =?utf-8?B?cWgyc0p0RGZKaWZIUjZpOStHb3ZDbktWVHMrTDhKblVJWGt0eFZTdW5BVXd1?=
 =?utf-8?B?bGdpQjNoeEpvU2Fod2N4akhUOFdQaXBrbExKWldNWDFOS3JkREs3VTRuYUQ2?=
 =?utf-8?B?Qk1xS2xVK2E0czkwZ1U4bytDMy9hUVNnQ3JaUFhmKzN5dlliNUJueldCMXli?=
 =?utf-8?B?dm5oVURkQXRheEhXcUZIZkRJck41TUZremZwZmwybSs1aTRjYThGeHEvWVNC?=
 =?utf-8?B?VWtlblpZZ0psNmlDcXF5QWVlVXV3RjdtSmVYMW5yam5oMXlXQm9pZm9ZY0FJ?=
 =?utf-8?B?amxBL2lvZzN6SE9xaGI0UUlLbUlNNmU3dDI3c0diNVBUeVJDQ0FoZXlVcTNk?=
 =?utf-8?B?UU5ENDl4RjhyQUxxNW10djdFcVZmbkpva0t3aG5CNk1zS01sQVpVRktRZzBZ?=
 =?utf-8?B?SU42cVF4WGZlQVNjekpIYjBMUWkvVWo4UnRveit0bm11TjEvS0xTb0tjR3dy?=
 =?utf-8?B?MkRVVDlLY1JqcUNtOVJueXJDS3NnWTkwYVBESUFiUEpxTVl3eGd4VjdEOEpC?=
 =?utf-8?B?U3RSanJXb3RVZHhoZmZ0WCtXeUxwRUx6RlVpS3JpMnBvcDZHQjNyMVp4ZW9m?=
 =?utf-8?B?VXJJSFZhRDdoUkw2RWk2UWlsMUVMTUd5ZEhLS0dscmRpNURJc01LWStBVXdj?=
 =?utf-8?B?Rkt6dVBNbG50WFVVNU1kR3pxVGdXRENxN0pURkFiY0hvTFI5NW9OUndTdVhm?=
 =?utf-8?B?YnNXVWo2ejNOVUNhaDVhRUduWG14c29tVEN6NWRPd3B6RVhTelhxNmZvNXRP?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0335e1a3-1125-4a30-1ad9-08daac252063
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 07:41:08.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEKGfDcNXhsI+GrjzkBK/NZizxqUrU6dPv7fw7IuJAXqsBnM9kttAUpi8OY/uDjzLYqyOlL1EeFHvTIGgc/9tv+RzZJ1eLWuYjuVL8+Py2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5479
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgQm9iLA0KDQpJIGFtIHJlYWR5IGFuZCB3aWxsaW5nIHRvIHJldmlldyB5b3VyIHdvcmtxdWV1
ZSBpbXBsZW1lbnRhdGlvbi4NCkNvdWxkIHlvdSBpbmZvcm0gbWUgb2YgdGhlIGN1cnJlbnQgc3Rh
dHVzIG9mIHRoZSBwYXRjaCBzZXJpZXM/DQpBcmUgeW91IGhhdmluZyB0cm91YmxlIHJlYmFzaW5n
IGl0PyANCg0KRGFpc3VrZQ0KDQo+ID4gPiBUaGUgT0RQIHBhdGNoIHNlcmllcyBpcyB0aGUgb25l
IEkgcG9zdGVkIGZvciByeGUgdGhpcyBtb250aDoNCj4gPiA+ICAgW1JGQyBQQVRDSCAwLzddIFJE
TUEvcnhlOiBPbi1EZW1hbmQgUGFnaW5nIG9uIFNvZnRSb0NFDQo+ID4gPiAgIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTY2MjQ2MTg5Ny5naXQubWF0c3VkYS1kYWlzdWtlQGZ1
aml0c3UuY29tLw0KPiA+ID4gICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtcmRtYS9saXN0Lz9zZXJpZXM9Njc0Njk5JnN0YXRlPSUyQSZhcmNoaXZlPWJvdGgNCj4g
PiA+DQo+ID4gPiBXZSBoYWQgYW4gYXJndW1lbnQgYWJvdXQgdGhlIHdheSB0byB1c2Ugd29ya3F1
ZXVlcyBpbnN0ZWFkIG9mIHRhc2tsZXRzLg0KPiA+ID4gU29tZSBwcmVmZXIgdG8gZ2V0IHJpZCBv
ZiB0YXNrbGV0cywgYnV0IG90aGVycyBwcmVmZXIgZmluZGluZyBhIHdheSB0byBzd2l0Y2gNCj4g
PiA+IGJldHdlZW4gdGhlIGJvdHRvbSBoYWx2ZXMgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMuIEkg
YW0gY3VycmVudGx5IHRha2luZw0KPiA+ID4gc29tZSBkYXRhIHRvIGNvbnRpbnVlIHRoZSBkaXNj
dXNzaW9uIHdoaWxlIHdhaXRpbmcgZm9yIEJvYiB0byBwb3N0IHRoZWlyKEhQRSdzKQ0KPiA+ID4g
aW1wbGVtZW50YXRpb24gdGhhdCBlbmFibGVzIHRoZSBzd2l0Y2hpbmcuIEkgdGhpbmsgSSBjYW4g
cmVzZW5kIHRoZSBPRFAgcGF0Y2hlcw0KPiA+ID4gd2l0aG91dCBhbiBSRkMgdGFnIG9uY2Ugd2Ug
cmVhY2ggYW4gYWdyZWVtZW50IG9uIHRoaXMgcG9pbnQuDQo+ID4NCj4gPiBJIHRyaWVkIHRvIGdl
dCBJYW4gWmllbWJhLCB3aG8gd3JvdGUgdGhlIHBhdGNoIHNlcmllcywgdG8gc2VuZCBpdCBpbiBi
dXQgaGUgaXMgdmVyeSBidXN5DQo+ID4gYW5kIGZpbmFsbHkgYWZ0ZXIgYSBsb25nIHdoaWxlIGhl
IGFza2VkIG1lIHRvIGRvIHRoYXQuIEkgaGF2ZSB0byByZWJhc2UgaXQgZnJvbQ0KPiA+IGFuIG9s
ZGVyIGtlcm5lbCB0byBoZWFkIG9mIHRyZWUuIEkgaG9wZSB0byBoYXZlIHRoYXQgZG9uZSBpbiBh
IGRheSBvciB0d28uDQo+ID4NCj4gPiBCb2INCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0
ZS4NCj4gSSBhbSBnbGFkIHRvIGhlYXIgeW91ciB3b3JrIGlzIGluIHByb2dyZXNzIGp1c3Qgbm93
Lg0KPiBJIGFtIGxvb2tpbmcgZm9yd2FyZCB0byBzZWVpbmcgeW91ciB3b3JrIQ0KPiANCj4gRGFp
c3VrZQ0KDQo=
