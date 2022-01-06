Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343EF48608F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 07:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiAFGVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 01:21:04 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:25707 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbiAFGVE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 01:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641450063; x=1672986063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tHn7wWWSvsNifNeE7eoeppgD8EcWqFWtYomFv1HX3dM=;
  b=a6KI4h4LaXtbr81K+F5G3g92h911bVVvHwm5l/KiWmEgMVVcZliIAih5
   cobMycSFClft+BZZ/Ri+EE8DD8qAi+5trcfYdgWycBQ+HAdfaKYRJEH+2
   s5xCTcFnYozm94SHZx/Kc3OpqvDt89AR2UM00SJLHMUk5BNNRgcaEjtPr
   wjrtg1SOipgMdpRtBUh7jt+tM/hSNNoBtdQKCIVg9+FzUwFdrt1kHtfcq
   ZjUqGHo/yd09SMPP/Fq/JkGuJAkyJDaCFUPD81z0Ecf0CEsOJgM/Nb0U+
   oe4FbBLAdwVpEqak0bHmrlQJK9+POVXEZYvTBf2nFM2Ud5Q8Eq81RU7oZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47415821"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="47415821"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:21:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUcJILP40z56sIHPIqeSP3q0WGF1dD1q3HOPwFfwT4/0r4p1l2GZ+P3ZD4NqK9VoYi6rpjwvPp4sHa7/Z8iBOsoZY4CZGmFNBruODBcJawCcYC7XKb2ezF41NtHcb50qEErMsLZzFk7rxz41qnkbQaeylHorxaBTMCq5YmSSjSShDfJTu0qqImzVOWl2XdcSUMITs0VQxKZkmq8LR9+/INCIuDn7nLLUaezNpPOlPzvsMgWYUWc82Q3F/K9ckyXfLaWHWBWg09dxiGeGkNyB5LrjB6PVO2w5UEQsqk38l/I9xFSB1kV4+kXZHAKD4KxivxzaV588rwLSMbu6dTqYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHn7wWWSvsNifNeE7eoeppgD8EcWqFWtYomFv1HX3dM=;
 b=WZHyiuiWxNX6N5rMOY7kg6swRN6HRmgab2GPVckwKA32tgHrJndo+IvJm43/gtxR64vdPGHxDZkAKZ2a4kFiLyopX/AAy0U2w1BZay9atQBN06+FsXjot0hTlDouWQLodw0oGVWtLQzGSMavasVUuqSrqEqtXU1MwLfA43AU7OrdR9nzcckXV7H7PL3EfJZqC0mAqpwPMX3FVl4bI9hmweItEdgWThC8rywUo1VLN8//nV7bK1DrUDNpF4oDGNdbpo1jxl5kZaLv3D2MyV56px+EsKIPUm8RBVnOPP27oU0nw9yNm9q+s9di3xW3DnM1KmeogkKoU3pGc58+0fzWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHn7wWWSvsNifNeE7eoeppgD8EcWqFWtYomFv1HX3dM=;
 b=MqdQAul9QiG0Hh0chWTT9INRxu/8htgakb6+QcpKOZIChKsbgoKo4HdjD5p++R4FV8vt3myZ4u8gIq7zYM3DG7RiEXOIWqlJ/GdIyDL0XYZO61W7TMOUwd06uOfm1PwVqbaEWOZgj6Jq/5iTJpXFZaPKEby89s0Ke5A1lZ4fXaM=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYYPR01MB7782.jpnprd01.prod.outlook.com (2603:1096:400:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 06:20:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Thu, 6 Jan 2022
 06:20:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH
 flags for supported device only
Thread-Topic: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH
 flags for supported device only
Thread-Index: AQHX+8Er95KpI1UKtUu28PtoB5n6zaxVL4OAgABkI4A=
Date:   Thu, 6 Jan 2022 06:20:57 +0000
Message-ID: <33d0f4d4-17e7-8212-c37d-d39454f3f4d3@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
 <20220106002239.GQ6467@ziepe.ca>
In-Reply-To: <20220106002239.GQ6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eeec125-b818-448f-3873-08d9d0dcb3a2
x-ms-traffictypediagnostic: TYYPR01MB7782:EE_
x-microsoft-antispam-prvs: <TYYPR01MB7782C86828483450C19F4434A54C9@TYYPR01MB7782.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhM6mosgtlMGEGaDVwh1Yr3CxzhZUBtWvajecJ9eoMgW4FV1G934gdM1XrHeS6G+UFEuyM4ipoqc8pozTL7raSbHKkHVZb1iwO/iiFx6LRtZ/P6dH3YBdnWBCwjoSKzx7aGm/0UkDiGqzMe/ilkyrOBt8wZYHcBqDXuJPcsLEuvGA/DOkwg9YLD7gFXuEDyclkCzFOvWU4xPslYyMlO5O3MQioHk2N22rZIwsUnCfvt/u70iRTuWJsgTmZ77/Uj8rYEuwfEY7HDCnW9RIp6zQLSub4xXI6BZjCW2oVdQTp0njePX0x5hKJbWcon+/7sDdu0A3W1J5OWYxwkwtFVPMC0sEXciQywmeQmxLr2xA14R5UOy5Oq1ZwVzH3gCgpmqtdW3oNGVR95XUB95qv7sBM1LgBil/cRF2t/GLECnG6Zma/mWjL5DaI4NUocWY2rJso7JD4TCfeoa2ltm3vQ8uES3qB+yR9nwFYpxbifPL2Vp7CvAezrT8UjP4O/k1cIyeHOC8nW17K1MwMPeY8F8yo+3Lq/efT1bEkHF2+UaqNIXlwLjAUSkXhX3U7XhraDXx7iMdgyrQdluvamDiNsu+J+0dYmvxy6pzn2GP9oaLn9HafvXTiLcSQO0BY6lcSonvKd1r2MdNcv0F6dWnjBJ8UlynuraKevsbjoKAgV3UPHTJpXJT/PPg0zsjjf1DAMVMd6UQF1Sg0zu3dDEAQVR5QglGQLMWN0vgK/d2jrOE8gNoGwZ+rC6m9DFitLGTMctgNfv4RJGVs6JXoQ0/gPi4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38070700005)(31686004)(6486002)(91956017)(508600001)(2906002)(38100700002)(186003)(8676002)(26005)(4326008)(107886003)(71200400001)(6512007)(76116006)(110136005)(122000001)(66946007)(8936002)(66476007)(2616005)(66446008)(85182001)(86362001)(53546011)(6506007)(64756008)(82960400001)(83380400001)(66556008)(5660300002)(36756003)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVpMWXNmQzZydDNkTGFZUGQ4S2hTbXJxVTlOaXplZHo5NG5HaEUzc3VxSnJQ?=
 =?utf-8?B?WlNxWCtVT0JKMHgydEpGdXcrQmN2SUcybmFXc2RHdEFnYVQrWWlIa05xWnFy?=
 =?utf-8?B?ZlZTRWo3U1ZwUW1QNkNvQ1FKTmplemQ0YVpKeEgwcmVMWHJMWXQ5VDd2QTVt?=
 =?utf-8?B?b2ZBa1h3SzdRT2l1a3BQbEJEdFdDNFg3dVMybFBWUE5SLzVucUt1MmtPbXJ0?=
 =?utf-8?B?QzdPQlF5TmIxaUM2WURJcjVMQnVqcXM0UnhNZG9LOHBPNkJzRjNjZXVwZk5i?=
 =?utf-8?B?ZkQyWWJPUGlyeXRPSFpUTEtIUEpYK0ZkNUR2Y21IWmcxQ3Nsc09OMVVzT2dN?=
 =?utf-8?B?emxFdWlDTjAvNjJvbmx3NnFXZ2FjanVnNHdkVWdLSVNTenl0Mk50d2pQUlRt?=
 =?utf-8?B?aHVXQm5kQ3hCcHhvUTdoQ1lWdkkvb3hoOVNRRzBYUnRQL1Q0cFhzZTVlUUVj?=
 =?utf-8?B?QVNuQmM5KzM3NVdySHUrcGhSR3BMNXdCZmlENHJOeVRmV20veFVub04zOSto?=
 =?utf-8?B?bFZSOUVLYWpmSGtURWpUbjQwelNDTk40ZWpRN09SNXA2L2pHNDVPV1ZScU1V?=
 =?utf-8?B?UWpPMTZmVlh3UVJ4L2c3RGlDQXNLK0xsZVpkT2Z1YVRxZW4wK1N3d2RSeThK?=
 =?utf-8?B?QVV6NFBlVlltU3dsVFYzK085aWU3UmsrcEhFZkdlajNhRUZpejQ5bmkrVWUy?=
 =?utf-8?B?OE1MUldLOXNRdFFYbTVVMVVhSjBZQVhRY1VzOG56aHJTenZPUi85NVJzS21K?=
 =?utf-8?B?Q1hTMFpyVW1OSHVwT1dFQzYzZFF3a1Z4SmVjWHBJTGdXU0FaUGNOYk1QMUtw?=
 =?utf-8?B?N043R1BSRGZCVVNzY3JJa3JTUS9yeTNLN2RQUkNNNm5wOVYzVDRTdUlPcmYv?=
 =?utf-8?B?WFZsaXFGYndLN2gwRVhCVVlXVEhHcWVPSXY5dk5XdmliejZWSGd2OWI4RGJD?=
 =?utf-8?B?aEw2a3l4dXltMG1xOTBjaXFGS1E1QlpDajNsVVVvcVZHazltV2ZZRzhVZjBU?=
 =?utf-8?B?ZndOUTYzYWlkaVpKZ29vTXp2N1RyUG5hNkhvVmJUaVdDZFFkRGtxTFFhRDBT?=
 =?utf-8?B?Z21VaEg5c2t3VHhQUW9kN1RrK0dLMWE5QzVtcTJZN2l6c2JSeklIVFJqcjY5?=
 =?utf-8?B?alhHN09hd2RaeEp2UkhaRWFyVmRpandBMUVRUkI2N3Nyc0E0VmZQc3ExVnhG?=
 =?utf-8?B?NWpteHVMdFAyQ1BsZXZmNXpCN25NcWlVcVlNc0lCUFI5clVPTFQzMWdMYWF6?=
 =?utf-8?B?Si8xdHloZzBDWUg1OXBzalFxcFBLd0wzRG9WcWtNYXV4OFB2THNtcTRWWE54?=
 =?utf-8?B?NklnMVRRWHl0aDA4VkF0a3RaZHFQbTNzMVlBNTM2am5tRkZvSHJ1RzZrWlF4?=
 =?utf-8?B?cXRZaU1LckhjYnN5VFZDUmZ5czZFNS9RYUJKK1ZWcHc0ZkE3Tkc2Q3dJckds?=
 =?utf-8?B?dnRKM3k4OGRyMGFYMHgxTFJobndlektnWENRYVlVZHhJbTFESnZ3QUpRZ3lr?=
 =?utf-8?B?eVNBWUhuaHhqdGEvWURVZURVT2Z6ZitQWVRSWUlYZlB2bVd0N2VzUWthY3pM?=
 =?utf-8?B?VUVIeHJ1YmdIM2pLc2VFQVFLRVJmbXhKSzE2ZFVxZzhvaVBOQVRsdW1jZkl0?=
 =?utf-8?B?bUwwbXZIUklzbnRJMEZTRndPbk1WTk5qbEhMdFdDc25GSXQ4WEowa3VrcEYv?=
 =?utf-8?B?ZlFvSGRja3BlZW1iZG5mWW4wWXJwTG8rblRwU0dKaGd0Rk1IV0NYSVF4YlV2?=
 =?utf-8?B?SkQ3VnBHVVVSUjlncmZyekVreUtHUE9zTEF1ZDVSeGpLY0FGRlJhK2U2N3dk?=
 =?utf-8?B?RkhWV3VraTk4aGxDa0lRWWxlZWZydFEya2k5WU1CbHdRdGE0QmUwcXhnK1VQ?=
 =?utf-8?B?WG1HVlpCT1RlZTBGMmYrNTMzb1NnNzE4cjhNQ2MvTG9ac2U2aVZqRGVuRWRq?=
 =?utf-8?B?VEdGaFFZTWNLQm1GTmdRb2tJcDhmY2FOb1JlNUJMTGdBSFpVR2wxZ2N5R0NE?=
 =?utf-8?B?aVd6RVRhNGhRbnRDVGNudDM0NGIrZEpsV05BK3c5V05rVkdrVHhNMnhlT0do?=
 =?utf-8?B?MUx1TmhoU3F2VzJsOTJRckxjSzBtUUJSMTMvWkdjRjEra0pPYW1JWVByOXhI?=
 =?utf-8?B?RGV2VldEMlUxSnNlT09wTS9qMHZ1ekNTZ01XcVltKzJacmN0ckwxdERBVnVp?=
 =?utf-8?Q?3iiwlcvSAwWiNxCdmRmEu+o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BC2D0D2EE6B6B48B3C88654744D016B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eeec125-b818-448f-3873-08d9d0dcb3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 06:20:57.3990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +K3a9OGjzKEbjLTnAz+OsQBJ5RAdkGSgFleNNqDVt9Wz9mf7ubpPWFZ4rJ6Fj4URaWP3EI9EInxLtxEmRako+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7782
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzAxLzIwMjIgMDg6MjIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVl
LCBEZWMgMjgsIDIwMjEgYXQgMDQ6MDc6MTBQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IERldmljZSBzaG91bGQgZW5hYmxlIElCX0RFVklDRV9SRE1BX0ZMVVNIIGNhcGFiaWxpdHkgaWYg
aXQgd2FudCB0bw0KPj4gc3VwcG9ydCBSRE1BIEZMVVNILg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNs
dWRlL3JkbWEvaWJfdmVyYnMuaCB8IDUgKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCBi
L2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oDQo+PiBpbmRleCBmMDRkNjY1Mzk4NzkuLjUxZDU4YjY0
MTIwMSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oDQo+PiArKysgYi9p
bmNsdWRlL3JkbWEvaWJfdmVyYnMuaA0KPj4gQEAgLTI5MSw2ICsyOTEsNyBAQCBlbnVtIGliX2Rl
dmljZV9jYXBfZmxhZ3Mgew0KPj4gICAJLyogVGhlIGRldmljZSBzdXBwb3J0cyBwYWRkaW5nIGlu
Y29taW5nIHdyaXRlcyB0byBjYWNoZWxpbmUuICovDQo+PiAgIAlJQl9ERVZJQ0VfUENJX1dSSVRF
X0VORF9QQURESU5HCQk9ICgxVUxMIDw8IDM2KSwNCj4+ICAgCUlCX0RFVklDRV9BTExPV19VU0VS
X1VOUkVHCQk9ICgxVUxMIDw8IDM3KSwNCj4+ICsJSUJfREVWSUNFX1JETUFfRkxVU0gJCQk9ICgx
VUxMIDw8IDM4KSwNCj4+ICAgfTsNCj4+ICAgDQo+PiAgIGVudW0gaWJfYXRvbWljX2NhcCB7DQo+
PiBAQCAtNDMxOSw2ICs0MzIwLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGliX2NoZWNrX21yX2Fj
Y2VzcyhzdHJ1Y3QgaWJfZGV2aWNlICppYl9kZXYsDQo+PiAgIAlpZiAoZmxhZ3MgJiBJQl9BQ0NF
U1NfT05fREVNQU5EICYmDQo+PiAgIAkgICAgIShpYl9kZXYtPmF0dHJzLmRldmljZV9jYXBfZmxh
Z3MgJiBJQl9ERVZJQ0VfT05fREVNQU5EX1BBR0lORykpDQo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7
DQo+PiArDQo+PiArCWlmIChmbGFncyAmIElCX0FDQ0VTU19GTFVTSCAmJg0KPj4gKwkgICAgIShp
Yl9kZXYtPmF0dHJzLmRldmljZV9jYXBfZmxhZ3MgJiBJQl9ERVZJQ0VfUkRNQV9GTFVTSCkpDQo+
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAgCXJldHVybiAwOw0KPj4gICB9DQo+IFRoaXMgbmVl
ZHMgdG8gYmUgY29tYmluZWQgd2l0aCB0aGUgcHJldmlvdXMgcGF0Y2gNCk1ha2Ugc2Vuc2UNCg0K
VGhhbmtzDQpaaGlqaWFuDQoNCj4NCj4gSmFzb24NCg==
