Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19948AA50
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 10:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiAKJTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 04:19:52 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:38855 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236935AbiAKJTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 04:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641892792; x=1673428792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPDXOxLVWrM6B/uGPqfrfMOApHFf6dGFHvM0HIqRv04=;
  b=pdmxjSk3LvjkHP+/vAtyi0evgoTiYJeAhMrQjrnd9mviB1RjgGGcpnGh
   WGpotNOb04P3+0iijn98g0ZxOwhfYi2+cXp62GDQAU2yssTVtxBD+idPH
   EEw9sTlrcy6Ica45KsnvZWrmFrk1eCg5u4eb180UfT2ZIqq2dJlfaEQFm
   PRkoxS6sB+w0mskw/RSbh1TI/iHKmfzKYnqlVYOx2M2VVH45VxPWsE8nL
   hRMAipCKBRSIi+R3KZx7X1miyUNrmYTAZJDS2SrzGIOWjpsCsKqSUHilO
   e5J1T97gU9oueF3CeEHsEeV9fxRo1XwydqHZXBOLGGhQyg4Fkj7A/KbGe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47308010"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; 
   d="scan'208";a="47308010"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 18:19:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmOSQ/APrvNs1wH7RqoxwYunyZtAfGfrBeVAM6C+IVR7YGmINDXTNf+z90lnbe4uPJyYsTmlBO85p6rbnEJGKB2cWd3fz6ZsnW+3d3nbOgEZ2U+REVrFW3tvSb15Sitf0Qgr68nuOFj24m5G6Xg+2DOndSClPfZB0QHS3YqItGcd+78LaHQ0wwTepQJmmmWS88YRY161ZKhIl8cT/YvSijKnzHn0CRexwKsn3/iGcyoYBgjc8MoQiexkpp02Xg0JaVdNUdrcAwt8xAY1hsez8Gh4y1AxVeXV5uzh2duc/y90RMdaVWvmP7BudQJta6f08KGsHJrC9U7zU3y1Z/vYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPDXOxLVWrM6B/uGPqfrfMOApHFf6dGFHvM0HIqRv04=;
 b=cUnFLAs387GMyJD11PI1I0IaMJJ1EQZBrVdf9fD2ez3QYo1kDe6cjzFPyQ0LX6uGyvY9Wyhi0ZtdTb3cpRLk1/sVY2xOuQAUiSZMunLNZCFzqHFbf89MArKeJwXEGxrQcwr072UunuhxCMJoaZyBx5TyPmd0L34U5b5H+q7WB8EoshyV9RVaFZyCwksyhUhZO1gszgtZW2iSrsjoBjccbPASlA2Jkw0kFxNG2fv1zv4yPOyTutcBY3s1d1ohHOM8oik8Nw6QeFxQObMsqf7KmHsER/hGtvXubTcsx8/6GkoNNl+y9EKzXSmPxDYn1n74rTPqauhUHjdlGLWoS92ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPDXOxLVWrM6B/uGPqfrfMOApHFf6dGFHvM0HIqRv04=;
 b=bjS2lVdEygYXNUZ6wL4SJpYzeEzwyVKmKlc9TgA4Y3N7nSKg6bQL+cLBKobXWaZDeGG9z7N1OSb8SEv39fXKn0AtX+VrhBmG6bfMJe85+9sjk3PCqRVurwPXRzrdniDfqmOqfB8M5Vl7eFP2xUSzTeej/wTIf8GnUU366QNm1cM=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB1589.jpnprd01.prod.outlook.com (2603:1096:603:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 09:19:46 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:19:46 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJuJ6RKP3ud9UOOlkH1pyHpjqxdVxqAgAA0fgA=
Date:   Tue, 11 Jan 2022 09:19:46 +0000
Message-ID: <61DD4BB0.7070306@fujitsu.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
 <Yd0fpzSbzWPv1TS0@unreal>
In-Reply-To: <Yd0fpzSbzWPv1TS0@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32940418-b7bd-4856-13ec-08d9d4e38290
x-ms-traffictypediagnostic: OSBPR01MB1589:EE_
x-microsoft-antispam-prvs: <OSBPR01MB158941472507B55DB5BF2CF883519@OSBPR01MB1589.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8W7Tl/j5JPcMCQXy2X7jlF/N6+ClTSp0yXepQuH3PnC7MTcoAQzEESazBsikh8BEPQ5SKlBeHqJjzc7JHW5LnLt0GsdjpsX3YebcK5vcnEy5r3zVLeBCt5NrbdmW8O18R2234pVxe+AwDmSnubo72i6fC0JwzhYVTqX+1fv/4eDQNqQFQNQBpOvfmO6SjDmSNdFq/2DQFu1+1syv6T7UvwCrcZge0l759RPbhtfE0H7zlDuBKSr0iFyaEEaEPL4QlmIJ0QtoY85+gS2rOFwz37V+IDh92x2+YV0jgX474dCdwUrx4sXi6AbFv2YrroISOTf93CDgL8ZQ2V473dge2ntg4urBLTd3o2Wf444FFniUJ/d1rtl+kl89jPEx9XDPHJNZg0rzuloZGm7yyAfSruIVlhxKYvQXa5kXvgyqVkEGWksOxpBUvfACFHL8WRv+9QsSzBmYPgC+gGrEN3Oqtr9GrZzU8Obqos8LPmXIchLFbu98JY4o9VIP7Zg1WTpToz4XZO+MPWFlGMD2pc/XChAhjZJf9+rKbFH1SdacLPDBhI4323Aaj/DmzCfEgp3VBe9iB+pmpkxyObHgvDVngBbxKtFRMxCT8PGxyUm1JWf77mVUe606ixbYM9onfxdFDDmuFYo5idlKNGa6T4QDbtn9Krpa5CBQyeI5KUdxRnWy4Yp4r8fV4ue3zJ5IJT57vDed5+ETvuQr6m7A0xIrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(110136005)(86362001)(36756003)(2906002)(8676002)(33656002)(508600001)(71200400001)(4326008)(2616005)(83380400001)(5660300002)(38070700005)(186003)(6486002)(66446008)(316002)(53546011)(26005)(38100700002)(122000001)(6506007)(87266011)(66556008)(66476007)(66946007)(6512007)(85182001)(76116006)(64756008)(91956017)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WU1wc2h6QU5WWk9WNmdodXVEN2kwUEpnWWR1dktjUk51bTd0K2kvUlZRcURu?=
 =?gb2312?B?VTZBZ2huaGhMTkdDMnhNOWRVUWcrMVkvNzRoWUVGdVdYNEU0U09Cbys0UmJx?=
 =?gb2312?B?NHVLclVLeFNrT3I3K0h4emovUlZSNEI4am9TM2wzenVsT2pxNjRRZmNpZmlU?=
 =?gb2312?B?bE1hU2pIeDVJbmd6ZHJpajJEYVpHWnhNNE1GYnpnc1ZWMHliZGxXL0d3K09G?=
 =?gb2312?B?aXBJNGZYdG4yczBCYWRYdUIyZzc2V3ZSTmJ2VXRNbzBLdmZqN0NIakVhQUEz?=
 =?gb2312?B?S04vbXpXSTRlUFVBd3EzbVVHS1FjakhJYkJUWUtaR0JKY2RCY2oyamZhVjlB?=
 =?gb2312?B?NlppaXdXZG5ZRkJPRmlZc285M0J6QTRyaG1FWDhVbEZWZVFNOU9lQ21RR0c4?=
 =?gb2312?B?eFVuUFNvL21PaW5QMkVtRkhWTWVQeUttYnpKRi93K2I1OCs3djN0Z25xZlV0?=
 =?gb2312?B?QzRWVzhJOWFaVHVXMGJ6aWlPTkNiNVFsWG9YVmVrSVhqVVBoMXp6Z1FyaDd2?=
 =?gb2312?B?LzJ0NzBnOE1sWmRxMXh1Rk54akYvS0MzdnNDdmMyWEgrM2RIQk91WlNOSVFW?=
 =?gb2312?B?RE5iK2d0NE5KRVJocGNDS1VzT2lQTWpRbTRnZVlEdHlHQmpIU1dWWUUxSEpN?=
 =?gb2312?B?QXB5TjIrYkEyVWR6TVdwclkwQjcrUTFnV0cvK2kzZUNIZU56YUV4V0F0TlBm?=
 =?gb2312?B?dWd2SzEzbzQvVDB2Ni9nZDFqQTNHYWJnZUx0eTZFazN4RzFKY1NpNis3ekQ2?=
 =?gb2312?B?V29DWHprWTZpeTViNjhYc3FOWmFGNkpXU0JqN0g5cU1nOFg5RmVhRzB1Y3Jl?=
 =?gb2312?B?c0NNcEh4ZVQ3aVlyMG1rQU5HeDUxb3JESVV2ZHF1TU9lUzZQSGtZYVpDS3JY?=
 =?gb2312?B?bDUzbjkwaE1GVG5aczlrREMrM1htMnhjTG40Y1VXWjFzRXZxK0hENXQycDRu?=
 =?gb2312?B?bW1Zb1JCSkpWYlJLWVJ6MEc3MUZSUlVKWnpITDlyaXVPVUp5SjBPd0FSK3FG?=
 =?gb2312?B?bWJIZ3RyOHQ4TkJRaGZnYlJqVU5yalg0SlQ2SHhqTnhWamdQWmYrU0doemFz?=
 =?gb2312?B?MnJZbHVDY3dnem5rSWtyKzlxaW0wUzlxcjlLc2lLb0dsUzJ2M2greGIzZHVR?=
 =?gb2312?B?VFJONzVEYmJHSDMwTXZ6aG04N1FKKy9LbEh3cFN5QnBZa1lyREdwQ3MxNVND?=
 =?gb2312?B?cjJCbHhtNzNNNWNHOW5wZ3k0OS9yaFk4TWlsdEg0ZnJRNzQ1NXhEa1phTkd5?=
 =?gb2312?B?V3pWcEZlSE9pMCtwaHJXTjB0N1EySFhycWROSUhjTXRVMjk3a1NDYzZobUpS?=
 =?gb2312?B?SzlwTGZHWXZubHEzeUlyZjFqS3NvaS9RdzQxN1NnUnVLRVllNzJYeDZ0NVRI?=
 =?gb2312?B?TTdJWmt3TGptb0xnRGNac1AwQzdOK053WXZkczF2Z2NkREZ6anhyMG9EM0d0?=
 =?gb2312?B?S0NCQjhiVkx3YlJnb0pCVk9GRHlDYmZzUGp3MTJSNVBxbTg3THNaSEdlVjNO?=
 =?gb2312?B?UjdadnYzTkUwQUNEZXQreGU5Z0k3YVd2T3h4RVBGckF2YTB2M1dQSFQ1Z09n?=
 =?gb2312?B?SXNHcnVPdVFHS2hYS2kzVEdDTEVmRENsMG1DKzYzWTUveWY5MUl1SFIwTWor?=
 =?gb2312?B?ODdGOGxtVmozYmFjT3BESjJuTDNCQ25nWUQ3QXVYZ0FtUnNnSTE4c1VxZ1RY?=
 =?gb2312?B?R2NtRkRBeE52UmZmeURSSXIyZ040elliVExVUEdGVHVMbzhVeFIwdWJBZTlp?=
 =?gb2312?B?Vk9ybmtTaW14aXp1Y3VZeGk0VXF6MzJoQmZleHlyUzVpdDN1bnREWFBEeWtx?=
 =?gb2312?B?dC8rY1pTY3pFOHU0Q3Y3YlBxNEpZM3IwTmZqd2hMeXNHK2dnS25VNUdndEJm?=
 =?gb2312?B?RVBOVlNGOEVMUEdVYWx6SzBENXdXdW0wR0xHaTJQY0szNVZYQnhWNVJjZ2w2?=
 =?gb2312?B?VW8xL1cxa1JpQVUxblpLL2tWQWwwYVNWQjhUbzlsdDFBNUFLTVRyWk5SWDlh?=
 =?gb2312?B?UXFBTExVczYwTmVnVmNRRC9lVE1kUXdWU09hNGNuTldhc2psQ2xpaWVXVDMz?=
 =?gb2312?B?QVlybklJdDhKa2h1UDVDN3VuWkRSR0QvUjFQRGhCVEFpVjlGRndPTGlobFlE?=
 =?gb2312?B?eWtzMW5LeHZIOVZ4dzJIWGZoQTlrZG1taWV2L25ETVg5ZXZ5VEpDaXREK1Ft?=
 =?gb2312?Q?rzPlEkzXluNBo75L6gF0+uY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <6B9435E383F42349A69C6536AB00BB91@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32940418-b7bd-4856-13ec-08d9d4e38290
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 09:19:46.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1m6yzWEgarCt3CSPZiy+03GdLzqSBhL9gVnsfGiCw/Wpfumc1rYhZCqx9JXD2QD5X0H4188Bk0msiXGvRtdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1589
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzExIDE0OjExLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIFR1ZSwgSmFu
IDExLCAyMDIyIGF0IDEwOjI0OjA0QU0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+IFRoZSBl
eHByZXNzaW9uICJjb25zID09ICgocXAtPmN1cl9pbmRleCArIDEpICUgcS0+aW5kZXhfbWFzayki
IG1pc3Rha2VubHkNCj4+IGFzc3VtZXMgdGhlIHF1ZXVlIGlzIGZ1bGwgd2hlbiB0aGUgbnVtYmVy
IG9mIGVudGlyZXMgaXMgZXF1YWwgdG8gIm1heGltdW0gLSAxIg0KPj4gKG1heGltdW0gaXMgY29y
cmVjdCkuDQo+Pg0KPj4gRm9yIGV4YW1wbGU6DQo+PiBJZiBjb25zIGFuZCBxcC0+Y3VyX2luZGV4
IGFyZSAwIGFuZCBxLT5pbmRleF9tYXNrIGlzIDEsIGNoZWNrX3FwX3F1ZXVlX2Z1bGwoKQ0KPj4g
cmVwb3J0cyBFTk9TUEMuDQo+Pg0KPj4gRml4ZXM6IDFhODk0Y2ExMDEwNSAoIlByb3ZpZGVycy9y
eGU6IEltcGxlbWVudCBpYnZfY3JlYXRlX3FwX2V4IHZlcmIiKQ0KPj4gU2lnbmVkLW9mZi1ieTog
WGlhbyBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIHByb3ZpZGVycy9y
eGUvcnhlX3F1ZXVlLmggfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9wcm92aWRlcnMvcnhlL3J4ZV9x
dWV1ZS5oIGIvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPj4gaW5kZXggNmRlODE0MGMuLjcw
OGU3NmFjIDEwMDY0NA0KPj4gLS0tIGEvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPj4gKysr
IGIvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPj4gQEAgLTIwNSw3ICsyMDUsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBjaGVja19xcF9xdWV1ZV9mdWxsKHN0cnVjdCByeGVfcXAgKnFwKQ0KPj4g
ICAJaWYgKHFwLT5lcnIpDQo+PiAgIAkJZ290byBlcnI7DQo+Pg0KPj4gLQlpZiAoY29ucyA9PSAo
KHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmluZGV4X21hc2spKQ0KPj4gKwlpZiAoY29ucyA9PSAo
KHFwLT5jdXJfaW5kZXggKyAxKSYgIHEtPmluZGV4X21hc2spKQ0KPiBQbGVhc2UgcmV1c2UgcXVl
dWVfZnVsbCgpLg0KSGkgTGVvbiwNCg0KcXAtPmN1cl9pbmRleCBhbmQgcXAtPmVyciBhcmUgaW50
cm9kdWNlZCBmb3IgbmV3IGlidl93cl8qIEFQSXMgYW5kIEkgYW0gDQpub3Qgc3VyZSBpZiBjaGVj
a19xcF9xdWV1ZV9mdWxsKCkgY2FuIGJlIHJlcGxhY2VkIHdpdGggcXVldWVfZnVsbCgpLg0KDQpC
b2IsIGRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uPw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlh
bmcNCj4gVGhhbmtzDQo+DQo+PiAgIAkJcXAtPmVyciA9IEVOT1NQQzsNCj4+ICAgZXJyOg0KPj4g
ICAJcmV0dXJuIHFwLT5lcnI7DQo+PiAtLSANCj4+IDIuMjUuMQ0KPj4NCj4+DQo+Pg0K
