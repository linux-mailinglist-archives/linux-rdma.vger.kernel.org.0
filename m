Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD755F0190
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Sep 2022 01:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiI2Xwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiI2Xwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 19:52:36 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03714A78E
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664495554; x=1696031554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MlL0Dz2+qNlhFqrEzpxwohizuI6/sktgBBSn4vwrids=;
  b=Ok7bAlNTElVDRwccgiKss46xa/VvHnxTYsW91LbE9tQqfkyq9S1EEE/9
   v12QGhCX+9ImP/eX9EkGvqaX5SAPAIcIiZWDuJX4QbnUpAyP19dx6chG9
   TgAT3/5ihgS+YRJ5DyaXPV8o+8/wVJlbQxFHiwAAAhmR8S7T9DAGLuEvK
   lOw49L8ahD9QT0Srq1cJ+Cuu6WpZqWmIEbyfESQZpJ+i0pDkkNq+NqTqW
   BvxUJJK533HM+fUwoZsdTEObgxEgepPXeRu+Qhb0qHxbpogHr+SsIknRA
   +05cCH6ZR/TxdRCplrAl6o77mkRKMQLnFadLlQIBKT9L8LU4R8jTw5Nrv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="74222331"
X-IronPort-AV: E=Sophos;i="5.93,356,1654527600"; 
   d="scan'208";a="74222331"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 08:52:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmrUNS+1URsZcZFIj5T5U7SSJsaEJT8XO9UySjH7TpFNopQ73jqGsqmtKJQtKkvt3yGMdD5hGIbRdlZr4E2aGjuCGJSDtlbLX2Ekdh1jQMxArtrtOBjYtZdyPWtExMgX9UDDPT2plaJEYOaOFdNLdpLbYJUc/oYtS3CVhTk5uHjnuv8+7KOdypqmrKKS/2WbJKqOqj+usKcmRpz8CDcRsI7G839y1WB20fP6jrbHIgncdHD1T6irSdoJjIASS9oUBMmtfRRkD4ZTM3O4gA/q3DXGStcDfls+oCm3PEjcxUPapbF+NyemiZYP06hSC2+4mgdmaXbE2z/k0fDlXc7VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlL0Dz2+qNlhFqrEzpxwohizuI6/sktgBBSn4vwrids=;
 b=Jp1aOTBsaB02Z7VXOykW10zn3teAGkxfBUQ95wsknEvUA127sBw4SrlB2v1uN5DQv6jn1CGSqFNpKjq/injRM5Hzk/oqPrL4wDH9hZRLEBOXy2Z8XMu0PD761SPTgWjbFp2NfSrdNcljqX7mJlHJloGBhk+Fu4bCg7TctFSKzPQgl4k4rD9tjdy7OAz2vHDhqthBmF8gI9E249VzItxTfwM+5GL+T8cYFJGYDif90pjPEu09XZp9AmUOnJ3C2lUFtcm1+7tiN7lgvHHnduwIRQsHkJBF/gSoU7E4Ytw5cQ58hrk7BAywVxl0voiBAn1QbochQTttxlJ/Bscb1JXcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB8113.jpnprd01.prod.outlook.com (2603:1096:604:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 29 Sep
 2022 23:52:27 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::41fd:feb6:57d:5a7f]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::41fd:feb6:57d:5a7f%4]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 23:52:27 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 00/13] Implement the xrc transport
Thread-Topic: [PATCH for-next 00/13] Implement the xrc transport
Thread-Index: AQHYykM9ecjzxQckj0W3lkf079lrYK3yZqwAgAAg4fCABBySAIAAfOlQ
Date:   Thu, 29 Sep 2022 23:52:27 +0000
Message-ID: <TYCPR01MB8455C2E2DCD507C32051E929E5579@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
 <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
In-Reply-To: <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: c6ef4ef1996745fea77f873ca3401f7f
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
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB8113:EE_
x-ms-office365-filtering-correlation-id: c0f04093-718b-41fc-d647-08daa275aa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4I3IM+6bqiRYnFnRQNNyrV8ZrGE4737jxapizF8Z7ZeHgZF6cKAYQfdXY8nVgWveenu+e2GwwkPw02/FXxSh9qGf/3lU9gkRh2uvtV1jX1p9trI1YpnVIz6c/XVCEu+aS0GDHeI5zRBJhTfoTtWYMu1D5IIuVXUZ5gOHETG9geyKFzu3XKkVelU4EHTJql3m+3Q050N9Z0RyC2Yked4LjYr+OzibExiIXKGqpXXi+zmCsZ3i6Kn7ZH9ocDL4Xsps0X7doXO1rzzARkEV2iULHTbqKv0fOIGH9JB79xSGtIxhnPlLw0Eqwss1wjn3oaSVWYobJUrNCIZt+tgyai/1wFpwKGWu+KRcATJUWsDZbUkPW0g5S22+YV1z4GuGsRu5hNAdFGul6h9SOW+hyIwYRKpWSYhLn9W9My3QVEzyH7U5a3ABT6www4NXfHWO0NGsvVBeXb+igDWr9GFeKwWvTL9xQlEcXeWJ7oU2r7JICmuxxXKK2H1sFxVcOy7SqEGvpZ3ynXSZ+Fxq+XkN+5R+iUoCgj6Rui+7t3k7k+pvFh4DfaSekhuvs3RMYlHh6Lr4xeLbO21bY41XZL37jvnztaGLtPGHjyva/1+0iraexpoNLi/ojys4bHOWrpI3GbNTtpnwopbLiNNxEYTKNVRlKDwvCOkS+VQMmoe0JvPyK1rCJYuQXMU4rDNg9cRW9/hrtsNCS23quhhAmBYRt5nUwE39yyGwDDJblayJErRcCqfVFvLcOPAK0DltKNNccqKTLZ2KZp2zwmQFNbmsEgOGU1FKMnxKWsb6+spS9Cv+YFcldIb62yhK0aQGlHJD02XuY07MVDbdS/DXRmm6t8P+Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(1590799012)(451199015)(316002)(71200400001)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(966005)(76116006)(66946007)(52536014)(5660300002)(8936002)(1580799009)(8676002)(4326008)(53546011)(41300700001)(7696005)(6506007)(478600001)(9686003)(26005)(38070700005)(82960400001)(85182001)(83380400001)(2906002)(186003)(38100700002)(33656002)(55016003)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnkrQW1hcW53a1NLdnZVZm5Oemh1aWdiUy9Ya0dTYmhUcUxjTldJaWR0RU5n?=
 =?utf-8?B?UnNjTzNGMlU0R2JxT2pZUVNDcVdMQzR4aVdteXM1WnJIbTBpN1NlZnA1SFd3?=
 =?utf-8?B?V0hqNjlQekZQNjBvamoxMkMySVVKazA0cFdZcUJTdXhUaks2eUZlcytHdGxY?=
 =?utf-8?B?cnpPT05pNFZwTWJBU1MwOXFiZmhuYTVnNVIxK3hoM0pEaVJlVTJFWG5nYnZU?=
 =?utf-8?B?U1dzWGd0ZWN6eFVPc3BTZzMycTNrRXZSMFZvREpLUTF3UFV3NEltUjJHUXRH?=
 =?utf-8?B?YlErRmRYb2RzZXJIQTByZnFaU2lJM1k1QVY1VDBHa2NQek0vQllrWnVGSk5X?=
 =?utf-8?B?eGV1bUI0Ymtqa1dxZGZLNWh1WW5XNjVGS0M3WS9hczhNZ2hoWWkxeVZucDRz?=
 =?utf-8?B?YW9kWUV2VzNjSzhZamZKUUJzRzRuc0M2dDZrRDhjWU1wTEcxaGZQS0F2N0Rq?=
 =?utf-8?B?TWtCaDRSTkxabERPVEZReURLUzVBQVZMWFpIb1VPTnJ2dUQ2eDJLSWZOOWF2?=
 =?utf-8?B?TXVyc3N2ZU8rNXRMNERmZXBLTm8zNDVsbW0xSHk2UGFMRTY4QXZENEFaYTlO?=
 =?utf-8?B?TE00K1JHUXJaOVhURUo3MzFTZjVlQmgrRFRCaWhsakEzd0c2SnN6OWp3eW9k?=
 =?utf-8?B?MHBjaTNRN3RDMFFFRml5WERiNStlZG85Z0R3bElMeG15dUhXUFB5WEsxdk9k?=
 =?utf-8?B?S0wxUUZBZG9weE5PRlhmbjl4UEN1dlBObFE3Y0tkSStQODFYYmhxWWgrVVVK?=
 =?utf-8?B?M2ppZFNHYWVDNW1sR1FpRXBZWFZVZ21Ld0Y2VzF2RVNMQzkyRUhsbFpqWFk3?=
 =?utf-8?B?RFpDOUFUaUhOWDdRUjUzT3hJb2srMjRFYlVuYkFGV2NpWWRJUWpnTi9CREpp?=
 =?utf-8?B?L0JXcUtUVGhsMFBVZFlraVlTL1JGNjFjMDRBNis1Q0EwenNpL1VyaWNLU1dJ?=
 =?utf-8?B?UlZvN2lNZmd4NEtKa2J5c2ZUeHRVaUd3M0xrZW5oQW5oTEowZ1ovU2RHL3JY?=
 =?utf-8?B?SW9jR2ozZ3ZwOTUySUlIdkU5YXJHcVFuUTBQZ0xWQ1lQeGs5V0FnQmdXU1Rs?=
 =?utf-8?B?YVlRVS94ejJVdTVVWVZoRjFZSFZ3b1lIR01hKzZVNUg4VE1WTjZjQU9XTmE5?=
 =?utf-8?B?RE9CTk85RDJyKy9aUitKUExZdWVDL0dFZkZibEJ5c3VFdEJUUWF2aTRHM0ln?=
 =?utf-8?B?UUFmdExnUTJEd2pmc0I1NnRnejVQeXF2MFlTUnplWlY4M3Fqc3I4R1VoQW5k?=
 =?utf-8?B?RGVSSVludUgremJpOGlGcVZRZmhSbTYxUTdpMVZieE1vTmhiK2JQdjRtWW53?=
 =?utf-8?B?TWxJZzNwQTlqYS9HNExxTzlFOCtHTUlHNjhlZUw3TkdCZkV6QzRrUlo4NkNE?=
 =?utf-8?B?SXhSb3JGTGpaaWd2UTBvUWk0VzU2NGJPcVRQeG5QeFdYLzhMRnkvbTd4d0o2?=
 =?utf-8?B?NmNFdXEzdHhDdnNYZnhwRjFJZmlvaTVsNm1UZi9iQkZTOGlNcDJXRTQ1WEIr?=
 =?utf-8?B?ZjNVY0NoQXo4RUY4alBEYWJuTlhaZTJad0RDTmxhSE9LYWcrQVZaUXd4Tm5U?=
 =?utf-8?B?UHhqamdjb3R5NGN5cjVFWWtXUElhTWZLckpqMUJrdU1heXhORkp2VTdkQndO?=
 =?utf-8?B?c0o4dys2T3owNTB0cHNpVlZFcVFGN1pzQS9MbldUSVcvT1p4MEoyUEw1RExZ?=
 =?utf-8?B?T3QzeEFJd0MrQWZNVVhhQ1ZEbFVzREtaWmlVSXpQb1pHYnZqRVFjTk43RzRa?=
 =?utf-8?B?TC9vd3JWOVRNU2tBMmJHcHZqZ1JmYzZBMWY4S1JSWFRneDZRWXh0RktpYk1n?=
 =?utf-8?B?YUdDUGxuSzdOTXM5b0tCUG9LRitsemxIK0N4TjdZNlpwRlg0dll4MW43a3B0?=
 =?utf-8?B?WTdFZG5PR1NVdGJSc3Mxay9nZytGOG1CbXIvNGJpRWNNZEpzaUR2SFhPQWx6?=
 =?utf-8?B?aWM2aGNUMFdHendCMXVhSkJSTHdpWm5pYm5yaFpqbTE5TllmTmUwVDkxZS9y?=
 =?utf-8?B?LytDdFREUGFlNlk2UVlwekhvYWxwbFFiL2Vaa3RCUlNyb1JlTklUcFd1STJI?=
 =?utf-8?B?elQ0T295RUx0N2NxUW0rZzhvWnVmUTNSUXYrS25WdENYcGx2T1plRyt0N3hr?=
 =?utf-8?B?bzlJeko3UksrL2RINlZvL05vWUJMVkE2b1pUaTJtckFTZ0dra2FMcUl0VG96?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f04093-718b-41fc-d647-08daa275aa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 23:52:27.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7ptC+QSTKiQh/B21e/+6wzhEtxdRj3NTWDWf+2fKMPFbufTxoTEhJ3xHpsP4vp9mbFsgx1dYNlUO6g0MaruyAz1Yh5rXLC+LHj4fTvxm2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8113
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBTZXAgMzAsIDIwMjIgMTI6NTkgQU0gQm9iIFBlYXJzb24gd3JvdGU6DQo+IE9uIDkv
MjYvMjIgMjA6MzgsIG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbSB3cm90ZToNCj4gPiBPbiBU
dWUsIFNlcCAyNywgMjAyMiA4OjE0IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+IE9u
IEZyaSwgU2VwIDE2LCAyMDIyIGF0IDEwOjEwOjUxUE0gLTA1MDAsIEJvYiBQZWFyc29uIHdyb3Rl
Og0KPiA+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB0aGUgeHJjIHRyYW5zcG9ydCBm
b3IgdGhlIHJkbWFfcnhlIGRyaXZlci4NCj4gPj4+IEl0IGlzIGJhc2VkIG9uIHRoZSBjdXJyZW50
IGZvci1uZXh0IGJyYW5jaCBvZiByZG1hLWxpbnV4Lg0KPiA+Pj4gVGhlIGZpcnN0IHR3byBwYXRj
aGVzIGluIHRoZSBzZXJpZXMgZG8gc29tZSBjbGVhbnVwIHdoaWNoIGlzIGhlbHBmdWwNCj4gPj4+
IGZvciB0aGlzIGVmZm9ydC4gVGhlIHJlbWFpbmluZyBwYXRjaGVzIGltcGxlbWVudCB0aGUgeHJj
IGZ1bmN0aW9uYWxpdHkuDQo+ID4+PiBUaGVyZSBpcyBhIG1hdGNoaW5nIHBhdGNoIHNldCBmb3Ig
dGhlIHVzZXIgc3BhY2UgcnhlIHByb3ZpZGVyIGRyaXZlci4NCj4gPj4+IFRoZSBjb21tdW5pY2F0
aW9ucyBiZXR3ZWVuIHRoZXNlIGlzIGFjY29tcGxpc2hlZCB3aXRob3V0IG1ha2luZyBhbg0KPiA+
Pj4gQUJJIGNoYW5nZSBieSB0YWtpbmcgYWR2YW50YWdlIG9mIHRoZSBzcGFjZSBmcmVlZCB1cCBi
eSBhIHJlY2VudA0KPiA+Pj4gcGF0Y2ggY2FsbGVkICJSZW1vdmUgcmVkdW5kYW50IG51bV9zZ2Ug
ZmllbGRzIiB3aGljaCBpcyBhIHJlcHJlcXVpc2l0ZQ0KPiA+Pj4gZm9yIHRoaXMgcGF0Y2ggc2Vy
aWVzLg0KPiA+Pj4NCj4gPj4+IFRoZSB0d28gcGF0Y2ggc2V0cyBoYXZlIGJlZW4gdGVzdGVkIHdp
dGggdGhlIHB5dmVyYnMgcmVncmVzc2lvbiB0ZXN0DQo+ID4+PiBzdWl0ZSB3aXRoIGFuZCB3aXRo
b3V0IGVhY2ggc2V0IGluc3RhbGxlZC4gVGhpcyBzZXJpZXMgZW5hYmxlcyA1IG9mDQo+ID4+PiB0
aGUgNiB4cmMgdGVzdCBjYXNlcyBpbiBweXZlcmJzLiBUaGUgT0RQIGNhc2UgZG9lcyBpcyBjdXJy
ZW50bHkgc2tpcHBlZA0KPiA+Pj4gYnV0IHNob3VsZCB3b3JrIG9uY2UgdGhlIE9EUCBwYXRjaCBz
ZXJpZXMgaXMgYWNjZXB0ZWQuDQo+ID4+DQo+ID4+IFRoZSBPRFAgcGF0Y2ggaXNuJ3QgZXZlbiBv
biBwYXRjaHdvcmtzIGFueSBtb3JlLCBzbyBpdCBuZWVkcw0KPiA+PiByZXNlbmRpbmcuIEkgY2Fu
J3QgcmVtZW1iZXIgd2h5IGl0IG5lZWRlZCByZXNwaW4gbm93Lg0KPiA+DQo+ID4gVGhlIE9EUCBw
YXRjaCBzZXJpZXMgaXMgdGhlIG9uZSBJIHBvc3RlZCBmb3IgcnhlIHRoaXMgbW9udGg6DQo+ID4g
ICBbUkZDIFBBVENIIDAvN10gUkRNQS9yeGU6IE9uLURlbWFuZCBQYWdpbmcgb24gU29mdFJvQ0UN
Cj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTY2MjQ2MTg5Ny5naXQu
bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tLw0KPiA+ICAgaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJkbWEvbGlzdC8/c2VyaWVzPTY3NDY5OSZzdGF0ZT0lMkEm
YXJjaGl2ZT1ib3RoDQo+ID4NCj4gPiBXZSBoYWQgYW4gYXJndW1lbnQgYWJvdXQgdGhlIHdheSB0
byB1c2Ugd29ya3F1ZXVlcyBpbnN0ZWFkIG9mIHRhc2tsZXRzLg0KPiA+IFNvbWUgcHJlZmVyIHRv
IGdldCByaWQgb2YgdGFza2xldHMsIGJ1dCBvdGhlcnMgcHJlZmVyIGZpbmRpbmcgYSB3YXkgdG8g
c3dpdGNoDQo+ID4gYmV0d2VlbiB0aGUgYm90dG9tIGhhbHZlcyBmb3IgcGVyZm9ybWFuY2UgcmVh
c29ucy4gSSBhbSBjdXJyZW50bHkgdGFraW5nDQo+ID4gc29tZSBkYXRhIHRvIGNvbnRpbnVlIHRo
ZSBkaXNjdXNzaW9uIHdoaWxlIHdhaXRpbmcgZm9yIEJvYiB0byBwb3N0IHRoZWlyKEhQRSdzKQ0K
PiA+IGltcGxlbWVudGF0aW9uIHRoYXQgZW5hYmxlcyB0aGUgc3dpdGNoaW5nLiBJIHRoaW5rIEkg
Y2FuIHJlc2VuZCB0aGUgT0RQIHBhdGNoZXMNCj4gPiB3aXRob3V0IGFuIFJGQyB0YWcgb25jZSB3
ZSByZWFjaCBhbiBhZ3JlZW1lbnQgb24gdGhpcyBwb2ludC4NCj4gDQo+IEkgdHJpZWQgdG8gZ2V0
IElhbiBaaWVtYmEsIHdobyB3cm90ZSB0aGUgcGF0Y2ggc2VyaWVzLCB0byBzZW5kIGl0IGluIGJ1
dCBoZSBpcyB2ZXJ5IGJ1c3kNCj4gYW5kIGZpbmFsbHkgYWZ0ZXIgYSBsb25nIHdoaWxlIGhlIGFz
a2VkIG1lIHRvIGRvIHRoYXQuIEkgaGF2ZSB0byByZWJhc2UgaXQgZnJvbQ0KPiBhbiBvbGRlciBr
ZXJuZWwgdG8gaGVhZCBvZiB0cmVlLiBJIGhvcGUgdG8gaGF2ZSB0aGF0IGRvbmUgaW4gYSBkYXkg
b3IgdHdvLg0KPiANCj4gQm9iDQoNClRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4NCkkgYW0gZ2xh
ZCB0byBoZWFyIHlvdXIgd29yayBpcyBpbiBwcm9ncmVzcyBqdXN0IG5vdy4NCkkgYW0gbG9va2lu
ZyBmb3J3YXJkIHRvIHNlZWluZyB5b3VyIHdvcmshDQoNCkRhaXN1a2UNCg0KPiA+DQo+ID4gVGhh
bmtzLA0KPiA+IERhaXN1a2UgTWF0c3VkYQ0KPiA+DQo+ID4+DQo+ID4+IEknbSBpbmNsaW5lZCB0
byBhcHBseSB0aGlzIHdpdGhvdXQgcmVhbGx5IGxvb2tpbmcgY2xvc2VseSBhdCB0aGUgcnhlDQo+
ID4+IGNvZGUuIElmIHNvbWVvbmUgaGFzIG90aGVyIGlkZWFzIHBsZWFzZSBjaGltZSBpbi4gSXQg
bG9va3MgbGlrZSBpdA0KPiA+PiBuZWVkcyByZWJhc2luZywgeWVzPw0KPiA+Pg0KPiA+PiBKYXNv
bg0KPiANCg0K
