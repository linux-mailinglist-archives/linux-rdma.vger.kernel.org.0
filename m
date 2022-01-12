Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDB48BDBC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 04:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiALDjT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 22:39:19 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:29515 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350464AbiALDjS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 22:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641958759; x=1673494759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=htT6YhPnrrISxUYx9k8B8pFs0jSA34K2DjLO3fw3qWY=;
  b=DOZeD1e4LfhbEoAJ1tAxE3DmuSo/dSqyUyfWB294sTRq+YhRwu/M2lu8
   RIwmLcNyjzy9mik4yYXPI0WOSHQ1flG2oBrVwspLNn2L1SEkNsnR6CTZy
   SYZq6j/EcmJEnGQ2gEjUz/MOTvRvuZ8oUte68DYh8uHn81v0H7NDPg6Cu
   9sGkXtfvdYth3/a+nKpQUVtalgF1ZxSfVCKazD01JBooVx8I078VM/CuJ
   3ewA9kwhklni929jmnWaZ8OxaIEqGDIb2rypEwkDK0h/w8eEEW1kjrLaR
   sW/hbhiNfP1rQy3CNsc9rGz5qN6nQ4jGjZAsB7EdSmfzEBO49FuWYF5+h
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="47397503"
X-IronPort-AV: E=Sophos;i="5.88,281,1635174000"; 
   d="scan'208";a="47397503"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:39:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axy2gt8wvFSf3QjsjfEZqPI/OOFeMJD7LS4XOKEiuaTJ+dlBEg6N3Ro2DjjC/TLdRxHQcyIJQmPqcgWoNc477HtpxIkaghsbvyGWRv3PmnYkCUXVGnGtMm7/juIA9TnOhfadRKxs0QhtK+anWB/VV/5N7SzvRVrGvD+quTurTcuSOkWxVwAmlL4ZO0TDFoojDsrVJisdNN9Mt+gb1BV9Nd5mQJxe2It9CD9B5WsHI4UAlJ3OAVC2/uq7r9g3XfhZMIe/m3IjL2xB7QB37QHWgE/+gHZVdDFLquu/Yg5exh5tVZCB8Rfbe98SxShRWxhtmoE6Lq2obYXs16jACBuDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htT6YhPnrrISxUYx9k8B8pFs0jSA34K2DjLO3fw3qWY=;
 b=UHYARLucEQOsu09xdagSnZKSe1PoTHqXtBQe/3mylv1L61Zcg4rSGJMxOj2YpiD1pagXeruQVCjcsHNi9QlV9TIjQoySdo7m42DF4itNUAOGp2SbR4u+m/boMzdbW2t/W9WbrFqzEwNQVolfNf+z2Q5VHLHkceVWbPs+9C/gPzRZM2mnzrYTQFp+1N+iNeC/WzBNRYBvjaJaccOuHAr4/20pebYu8MXe1VLSsnMrNvXdBZRh1cdhEvkmXhdPlXTk5eTM9CKFaN/wbFbw+SV7+Vulp0nKV5/eesbBUrlmppLB1MqXpDrOb6C0qUSKG9r1rFuGrHqJ8EPXBjxTgrzchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htT6YhPnrrISxUYx9k8B8pFs0jSA34K2DjLO3fw3qWY=;
 b=LVVfUuSFID/J+OXWfKP4mqORJCjp8td14dn9m6XRbqukFfef4WzfuOgvvQ/Obs3hpHezB/ELdMfFGE2GJxhJ6QT6vyzaoxnA4B/txDc+q3+WsSPJBQfbICum6+11LXS8BlhMjs7G8saDKfP9UQEtABqmi93pVNVED4WTO2A8KC4=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB3761.jpnprd01.prod.outlook.com (2603:1096:604:52::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 03:39:13 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 03:39:13 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJuJ6RKP3ud9UOOlkH1pyHpjqxdVxqAgAA0fgCAABiSAIABGp2A
Date:   Wed, 12 Jan 2022 03:39:13 +0000
Message-ID: <61DE4D5F.50303@fujitsu.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
 <Yd0fpzSbzWPv1TS0@unreal> <61DD4BB0.7070306@fujitsu.com>
 <Yd1gTDZ7bq/Ixg3y@unreal>
In-Reply-To: <Yd1gTDZ7bq/Ixg3y@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e3ca8d1-df1a-4e83-5f71-08d9d57d1a19
x-ms-traffictypediagnostic: OSAPR01MB3761:EE_
x-microsoft-antispam-prvs: <OSAPR01MB376167F38FE7D71FE2FEF47D83529@OSAPR01MB3761.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zp60Uf7l+m4Nov7I+9oo3q4xKB/ZRskXsDHKe3BXrD2lAqNo81u1aiPym8w0O7YAkUHRfUnWmoQedClsEgHP7Yl+aKDzPe99SS95gNb1aB1uD/BqF/6uvtTTxxrth3FgS8YtOJ+oCLSwWKZtPYY94n0wSYSShSBIfsVWs3eRqTzZrroXQ4eiyhXb2nmGEIwvZfEVhmGA4oJXkpcgTX0A7fMgG+tDnruj4iyMh1XWA1n8Ie0dawHYb/HVMgxcKZc4+Da6bsigFVlShhvs0kD4Yv/HLfbAt9RTTTe02+E1jb6wHVyo5Imc6gIEYDOzCjer6iQ6+BOS/RcfJSqLsvhLNF9znDgfjZhgjZPUfIryluLvCF3TWLHYyLRFUhEwx+BOySJeotbih45dcSk7OFVwot9dCHlti63ATeMOl5nLnA/M9JkSpr9quh1jP+LDSYs2uTCqOV/NtqHINeVg07x2Xk/WuyHoJxDr5DE2M0KN2Gz81NkV/iXg3AjSKdDiI/zQD3UNiqy7Nzgj46Gq3M2GvzDu7V7mshHBmWgLv2FqKkH+Snxen2hW10yTGORv/20ZlDL957HOYvZDP1HWgHDRim+FrTgENJrQOFrezaS3vUAexQqJ4tvmD69e+Onqfym1b0uctnfT5909VBKj1qavu27QFlX1YLBzqbsfVo34GhDu6RO//+NBZs06wtjOtsZfA3tF8XyAwR2Fhm1TB+ZF7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(2616005)(5660300002)(8936002)(26005)(53546011)(6506007)(33656002)(82960400001)(38070700005)(83380400001)(122000001)(6486002)(66446008)(66946007)(86362001)(91956017)(76116006)(85182001)(64756008)(4326008)(2906002)(186003)(66556008)(66476007)(316002)(54906003)(6512007)(71200400001)(38100700002)(6916009)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bVNVRFFmNEd1cTViZUwyamsrVWs4OFBYdFB0SGhWK2s1VW9EKzk2SFUyaHUw?=
 =?gb2312?B?VXJvNEEwbkZDbDF2V3Q1NmZFYVBObnAxL01DNWtBUmdvRGJzeElJRlFTMFQx?=
 =?gb2312?B?K0psZ1NldW9rRlFTZ2prdlBSSk8zT1RvSDFqcEFZUWJ4VFRTMEFsdHdOVDk0?=
 =?gb2312?B?aExTbWRJS05qZ2o1WitBQXNFeXMwYm9Tak1aSExIRUd6UjRxRlZrZlRKOXZN?=
 =?gb2312?B?WGtFYmxJMGxqSmw2bGI0MjhSNjVDUVhacWlCRlJ1TWxMaW9uVlJJZ3dZVVBV?=
 =?gb2312?B?MThQV3Y2RlUyRU5nb2xDMW9kNFRzY0lPdEdtbUFwZFMzaDlyWEwrOGhTbXlm?=
 =?gb2312?B?ekdkcVRrSld6N1A0ckJFa0wraUFxT2I5bnluVTdPb3Zsa2dBUkI2MFAxbm9L?=
 =?gb2312?B?TWxMTzI5RzlncmlBWjBObWFDZ1FjTGRZalBCWVF1c0hvbTBUd2Nvb1BVM0Qy?=
 =?gb2312?B?bEsvdENGWHZzMC9DZXZ4ZGt6T1lIaCtxY1RSSlVyNkZZTGFJekxWT3E0TjBa?=
 =?gb2312?B?bFdLRnRPa1VyVHVDeUlaVVlyWHpCcDVIdWpZRlFWWFFuK0JxY2hoWFUvT3Bk?=
 =?gb2312?B?aTZvRHpkRU0ydHlZS2JtNEZDK0ZmNDVST1FyOW92VEFydkZvS3BsdjlLR0Fi?=
 =?gb2312?B?Ny9lN0taSnZhRjJZZ0Fzd2NyTGZPVDFYTmhiMDhQUVZOL3lPY3ljOGRqRXZ6?=
 =?gb2312?B?ajE2dUhyc3dNT1dNdzZWTUkwV1gySTNBYjdQMFJmdlRUMk1qbUJpcVFPL3Az?=
 =?gb2312?B?UnNMNkZ0Uis1SFdoOHk5Wll6dHFCUk1BZ0FseDg4YWFLN2YzeHFna1BKNGlX?=
 =?gb2312?B?OVZ6eGhwUE5oZHRkdDBsQVpwUVk4VDRwRGpLREtsTElKTTZDMGhyNi95S2FX?=
 =?gb2312?B?QWtpZGJGNGZEdm9BaUxkTlBwL1JXaXVKeUp5YzV4MnNHdjNUcnVDNnczaUhr?=
 =?gb2312?B?SWZsM3oycTU5ZFlaZG1aTHNsQlZ6SW9jbGJPY0JVdmprRmdXeCt3a2d3QjNy?=
 =?gb2312?B?b2wydFpYZ2RXWlg4UUViY1FZZktLRDU4cHRIN00yZ3BPTUxlZUE0aFUzek8v?=
 =?gb2312?B?NEV0OHZ6WTljTlBKRGp2YkQwNVpjVEZaNWlLNG52d0VPRlZwWTZCUElLejJ1?=
 =?gb2312?B?c1h5RE8yQkNjbUdvSk5nQXFTejB4bXU4Z0RWaHVSQ0poa3Q3TmUxMGdSbWxZ?=
 =?gb2312?B?bXdMQXRGa3hsVHYxNHV5VDJ5Qktlb2RwSFJnN3JHNmVTdUYxV0ZhN2s5TzYz?=
 =?gb2312?B?YzdvZ3BVV2sxajViKzNtdUwwaDBaMzlDYWEwbXhNbXc4U0VObHg5dE5UOXZt?=
 =?gb2312?B?YmJYcDhLbjZ5YVRHUlk0U0JRc29HRnJjeWpWR2YvYVpGUUUrSnNyZk5QZENO?=
 =?gb2312?B?VnRyWndTOGdDdTZWdzJYaTdCWSs3NW02SDd0Wmd4Q2I0aWR0V0RZTCtVOGhZ?=
 =?gb2312?B?am1UZmpzUFlHWjJBakgyR0IwL2xNcG9lMWxXUzJZQVdVQ0xLbDlUUDN2Wkhl?=
 =?gb2312?B?V3lvK0lKNWNXUXFqY0p4ZjM4Mk1lN2Y4THlMbWZpdlBhUzVRRmxUTnZsVEho?=
 =?gb2312?B?ZWF1M0dKa2dOUzFnK0Y5S2lvNEp3YjhyUGU5NkdCaUc1TEEzRnlaMlREYkJm?=
 =?gb2312?B?MjV2djFwWTdNOGErZHdXbmNLam41alZwRkV3blo0Y1NZVmNVNWRhem5rQTNk?=
 =?gb2312?B?MmNVdzUrTWt0dkY4eVhUWTUxRkxSVGlMd0E0ZVNZekk1aHJqWE0wMm5JRnBK?=
 =?gb2312?B?V2JnTWZZZ2YrMWVKeW9MWUU1WnVVdEdkQkJCdTk4NlhkRUwvdjk5U0hPRjV4?=
 =?gb2312?B?QW5JR1J3Wk9Dd2tIcE4ycHltd3ZONitwOGowZE56Y1JDbW5ENU00L1k3V2d4?=
 =?gb2312?B?RytwUDJpak0yNDk5SWRiNHVGQVh0WUpNcUpoYUxqMWRXbWlWeGRyNUlHemV1?=
 =?gb2312?B?QjlIM01mblMraUV3S1k2ZFRCRHFuaHNTcE5YWDQ3MWxQUWpuMW5nTC82TWE3?=
 =?gb2312?B?a3E0M0MrdXhROXpPNjNxeCtrSkFIRjhWSW1VSDMwaHN0ZkVNdk5YWkFEVWpD?=
 =?gb2312?B?U2JmN1h0Uk9FcFY4WThFa0xjZk9FeXRkUmlNL05HeVFtdzN3Z24zTkNWRGQ4?=
 =?gb2312?B?eW1BaS9MNlF0a2tza0p3ZS95RGgya0xPMTJIVGRyUlAvTzVBYTVHNERBc2dY?=
 =?gb2312?Q?7eUWGhFbD+YUyVSzCYNH01E=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <B826567BE6D9424FA829018DD4B20916@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ca8d1-df1a-4e83-5f71-08d9d57d1a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 03:39:13.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Avnf+gH1lLMERGleQsoMwXOGe+rC45L8iSyzzHO2rMVAxG8B4rla0D2FWyTxNYomLpymPJ1BxQ4dQMRgOet9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3761
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzExIDE4OjQ3LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIFR1ZSwgSmFu
IDExLCAyMDIyIGF0IDA5OjE5OjQ2QU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gT24gMjAyMi8xLzExIDE0OjExLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4gT24g
VHVlLCBKYW4gMTEsIDIwMjIgYXQgMTA6MjQ6MDRBTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0K
Pj4+PiBUaGUgZXhwcmVzc2lvbiAiY29ucyA9PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmlu
ZGV4X21hc2spIiBtaXN0YWtlbmx5DQo+Pj4+IGFzc3VtZXMgdGhlIHF1ZXVlIGlzIGZ1bGwgd2hl
biB0aGUgbnVtYmVyIG9mIGVudGlyZXMgaXMgZXF1YWwgdG8gIm1heGltdW0gLSAxIg0KPj4+PiAo
bWF4aW11bSBpcyBjb3JyZWN0KS4NCj4+Pj4NCj4+Pj4gRm9yIGV4YW1wbGU6DQo+Pj4+IElmIGNv
bnMgYW5kIHFwLT5jdXJfaW5kZXggYXJlIDAgYW5kIHEtPmluZGV4X21hc2sgaXMgMSwgY2hlY2tf
cXBfcXVldWVfZnVsbCgpDQo+Pj4+IHJlcG9ydHMgRU5PU1BDLg0KPj4+Pg0KPj4+PiBGaXhlczog
MWE4OTRjYTEwMTA1ICgiUHJvdmlkZXJzL3J4ZTogSW1wbGVtZW50IGlidl9jcmVhdGVfcXBfZXgg
dmVyYiIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1LmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIHByb3ZpZGVycy9yeGUvcnhlX3F1ZXVlLmggfCAyICstDQo+
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+
Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaCBiL3Byb3ZpZGVy
cy9yeGUvcnhlX3F1ZXVlLmgNCj4+Pj4gaW5kZXggNmRlODE0MGMuLjcwOGU3NmFjIDEwMDY0NA0K
Pj4+PiAtLS0gYS9wcm92aWRlcnMvcnhlL3J4ZV9xdWV1ZS5oDQo+Pj4+ICsrKyBiL3Byb3ZpZGVy
cy9yeGUvcnhlX3F1ZXVlLmgNCj4+Pj4gQEAgLTIwNSw3ICsyMDUsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBjaGVja19xcF9xdWV1ZV9mdWxsKHN0cnVjdCByeGVfcXAgKnFwKQ0KPj4+PiAgICAJaWYg
KHFwLT5lcnIpDQo+Pj4+ICAgIAkJZ290byBlcnI7DQo+Pj4+DQo+Pj4+IC0JaWYgKGNvbnMgPT0g
KChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSkNCj4+Pj4gKwlpZiAoY29ucyA9
PSAoKHFwLT5jdXJfaW5kZXggKyAxKSYgICBxLT5pbmRleF9tYXNrKSkNCj4+PiBQbGVhc2UgcmV1
c2UgcXVldWVfZnVsbCgpLg0KPj4gSGkgTGVvbiwNCj4+DQo+PiBxcC0+Y3VyX2luZGV4IGFuZCBx
cC0+ZXJyIGFyZSBpbnRyb2R1Y2VkIGZvciBuZXcgaWJ2X3dyXyogQVBJcyBhbmQgSSBhbQ0KPj4g
bm90IHN1cmUgaWYgY2hlY2tfcXBfcXVldWVfZnVsbCgpIGNhbiBiZSByZXBsYWNlZCB3aXRoIHF1
ZXVlX2Z1bGwoKS4NCj4+DQo+PiBCb2IsIGRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uPw0KPg0K
PiBkaWZmIC0tZ2l0IGEvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaCBiL3Byb3ZpZGVycy9yeGUv
cnhlX3F1ZXVlLmgNCj4gaW5kZXggNmRlODE0MGMuLjgzZWI0YTVmIDEwMDY0NA0KPiAtLS0gYS9w
cm92aWRlcnMvcnhlL3J4ZV9xdWV1ZS5oDQo+ICsrKyBiL3Byb3ZpZGVycy9yeGUvcnhlX3F1ZXVl
LmgNCj4gQEAgLTE5OCwxNCArMTk4LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhZHZhbmNlX3Fw
X2N1cl9pbmRleChzdHJ1Y3QgcnhlX3FwICpxcCkNCj4gICBzdGF0aWMgaW5saW5lIGludCBjaGVj
a19xcF9xdWV1ZV9mdWxsKHN0cnVjdCByeGVfcXAgKnFwKQ0KPiAgIHsNCj4gICAgICAgICAgc3Ry
dWN0IHJ4ZV9xdWV1ZV9idWYgKnEgPSBxcC0+c3EucXVldWU7DQo+IC0gICAgICAgdWludDMyX3Qg
Y29uczsNCj4gLQ0KPiAtICAgICAgIGNvbnMgPSBhdG9taWNfbG9hZF9leHBsaWNpdChjb25zdW1l
cihxKSwgbWVtb3J5X29yZGVyX2FjcXVpcmUpOw0KPg0KPiAgICAgICAgICBpZiAocXAtPmVycikN
Cj4gICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4NCj4gLSAgICAgICBpZiAoY29ucyA9PSAo
KHFwLT5jdXJfaW5kZXggKyAxKSAlIHEtPmluZGV4X21hc2spKQ0KPiArICAgICAgIGlmIChxdWV1
ZV9mdWxsKHEpKQ0KPiAgICAgICAgICAgICAgICAgIHFwLT5lcnIgPSBFTk9TUEM7DQo+ICAgZXJy
Og0KPiAgICAgICAgICByZXR1cm4gcXAtPmVycjsNCj4gKEVORCkNCj4NCkhpIExlb24sDQoNClRo
aXMgY2hhbmdlIHVzaW5nIHEtPnByb2R1Y2VyX2luZGV4IG1ha2VzIHFwLT5jdXJfaW5kZXggdW51
c2VkLg0KQWNjb3JkaW5nIHRvIGNvbW1pdCAxYTg5NGNhMTAxMDUsIHFwLT5jdXJfaW5kZXggYW5k
IHJlbGF0ZWQgZnVuY3Rpb25zIA0KKGFkdmFuY2VfcXBfY3VyX2luZGV4KCkgLCBjaGVja19xcF9x
dWV1ZV9mdWxsKCkpIGFyZSBpbnRyb2R1Y2VkIGZvciANCmlidl93cl8qIEFQSXMgb24gcHVycG9z
ZS4NCkkgYW0gbm90IHN1cmUgaWYgd2UgY2FuIHJlcGxhY2UgcXAtPmN1cl9pbmRleCB3aXRoIHEt
PnByb2R1Y2VyX2luZGV4IA0KZGlyZWN0bHkuIEkgdGhpbmsgd2UgbmVlZCBCb2IgdG8gY29uZmly
bSBpdC4NCkJ5IHRoZSB3YXksIGNvdWxkIHdlIGp1c3QgZml4IHRoZSBpc3N1ZSBoZXJlPw0KDQpC
ZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4+IEJlc3QgUmVnYXJkcywNCj4+IFhpYW8gWWFuZw0K
Pj4+IFRoYW5rcw0KPj4+DQo+Pj4+ICAgIAkJcXAtPmVyciA9IEVOT1NQQzsNCj4+Pj4gICAgZXJy
Og0KPj4+PiAgICAJcmV0dXJuIHFwLT5lcnI7DQo+Pj4+IC0tIA0KPj4+PiAyLjI1LjENCj4+Pj4N
Cj4+Pj4NCj4+Pj4NCg==
