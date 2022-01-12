Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762948C19A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiALJvV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 04:51:21 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:49122 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352472AbiALJu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jan 2022 04:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641981055; x=1673517055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RqdZHkgAodJ/diQOVGGRBRLyh7vvjiQs1uwG2m3llqQ=;
  b=lZy8Hnw20RQ9dHdUy0Hmc0jTQKhwc3nDMCwgmwBJcsUfNeltnvm3HzF8
   6EmKGJp5lgvzKzbgU1KOFzzmlZj5w9qS+GA5Zmb8f5rheas3FrJNgkQWe
   k2e2LjSUkoI9sAixw9lBvo5kmHd9Jec8GLLhSH1xYht3v59uc7k1krXMc
   WpHoX9srFcA+TWGRtLjel5wgJ28pnCHWiLFq8axOgHxwwRlymS3I/O0fG
   2V7IfhaLamJsRka/wQWgiUSlyZQs7Ng2e2buEDei/9pjGo+zuu8hgxNOS
   OHPrW7+CLJKWrqce2SocaMocDqRYiJrF4paDi8di2md26GRF+mMFh2xrM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="55550290"
X-IronPort-AV: E=Sophos;i="5.88,282,1635174000"; 
   d="scan'208";a="55550290"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:50:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQPKC0PSHHpXgu0KQHgK3hhZJt+1mYRPYpGbRAjwbzS5DVEc8NReAlB5GrPCMmpIttDpI0I8AM7fZHvboH4sJ3K3Csq7cVJQ5EmO8z3wi0ruPi4NpOG6WppDXc3iu+Fiz2Flzqp1PBP2Bine9EKd8SanTqBOzxIFnRZ68HRuyE+6JBB2WWNzCNvmX7maNwDSfGqxalkbmgmpUCBDNsSKCV1KhxvZr1zUoPRypmPN0olY9XbFS0L+M78mUDhdubiEI4n7rZqsKjwv0XNogh++LLwSbwNFnRJ7GeNg+9lRfBYZKsmCxK1kWTfrH8sISzuLdbdCKiVZymtkCNhXAoXHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqdZHkgAodJ/diQOVGGRBRLyh7vvjiQs1uwG2m3llqQ=;
 b=g06WYRV4mw0bHeugmfbbVlhYwbu7tlrM2wNiUtSmXo1wfrozKHVwkzy7ZfxHwGwQqhxpkwxUyHKc2pPzfrAD36U0nHTx0Nm+bF6wxS7tJU87l1Zx965YChR/lIGjjq8zyNeB8b/EQGPkrX3sg/NqTU08oa6CuEWcOv9R/9u5XuWnNdu0Gm9Au2XBPu5TQktYscDscLnOiyBQIyxUqK/QMLTbbPBY55HiVtliW/7j81CL6erASJBzL2C+S2JyYiEo8dZXfsbaoapPmsbsJjT6QpmsbXOwt3sIHcPdUmvp5bu7sFu50amGQxlD3W0RxPN1jLHNVPZ+U3m1JD1eF+GLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqdZHkgAodJ/diQOVGGRBRLyh7vvjiQs1uwG2m3llqQ=;
 b=j95CfjzyRJNbbZV8kJN+Lx+vYbXMgeZw0CLMzLCph2ckYt3MTF8fvvzXl+iS3ujBZb2X+r28P3r7Sv3nB1l1sOU1/ZhwyMH2O04gfDMUkAiHdbYS0GyRoohSP0EgEGB5LScuEktFVqaBv/Z2QZKz8YXzkJK2H2YYKFk2l1USc2M=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB8672.jpnprd01.prod.outlook.com (2603:1096:604:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Wed, 12 Jan
 2022 09:50:39 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 09:50:39 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xVMQcAgABoxYCAALXOAIAFg4eAgACTqoCAAPuMgIAA/08AgADajgA=
Date:   Wed, 12 Jan 2022 09:50:38 +0000
Message-ID: <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
 <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
 <20220111204826.GK6467@ziepe.ca>
In-Reply-To: <20220111204826.GK6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74ac598a-2f9d-40f0-cac1-08d9d5b0fd4d
x-ms-traffictypediagnostic: OSZPR01MB8672:EE_
x-microsoft-antispam-prvs: <OSZPR01MB86722341E91C7D25EDC511E4A5529@OSZPR01MB8672.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idCnTJrOldIMMXRJy/iq95hBmrQSBoEeGmF0orPrBRaHlckkVDuuMDulKdI0fe6B8YUoL8Cn0ImhoZhYklOacj7cYZ6vDTkaD0WGSPcmgttYSrFgjKLHw+TPV0zO3fjUJJ4+a6OI5uT3Yh6xEq8fuYROEGzNNKVripAt5EiiiTiDU+I4NdGotlIiVU4jnwObbK1imSOzQZvmbd74z0yLbqrLkvwmecv51MyA5Gnomuze2l9cy71GOpJjXpsl4qK051AhlRXh2N7jw0jvn897BAArpiLvjviPwFNMavRpJFdjF2m0EQkD4Froq+NveHRUGeX22HX7DzpndZA5ZBaZFrRe0bKO+MRdjf/h0jT6fSB2PiAxbYJjxp0Vn5gYkyr/5fcGu74dLkqiOJQk5ZYdT33Hh2ECIGKQIjv+zeLOCPobEwFOvdJDw/o+80qAMeNlDvQ+AS3YuTyaARwe9J6Zut7aqS9QI/URHuKpV2ZiX2+J5w4irAhhdcfVIe2+2HzrJqWgyf+UoqtGV81aBLteaKiEdKayJGH7Hjeyj4XXt/GTq3ioacMNnI/XiAbaDN3DLi8FFbXzjdWdAP0itccQozVDdgnKFtn7OauWEJyAURZjgkOmza8dS13WXcEGVou127gQFCMmN7V/V6ytsa7RiYRtvx5VfzJj1lhEENU3LPWLambQhYDXiZ9g/9ejKk+Fvr9SgVP8PGQ4H6JtbuPb8BUqc07GqBpPtLWdvsKV2SVLZSBQsrBtnuLIwJaVWvjb5X08vWCo/VLodxcmJCjRtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2906002)(76116006)(66476007)(107886003)(38100700002)(122000001)(6486002)(5660300002)(66946007)(6512007)(8676002)(91956017)(82960400001)(6506007)(6916009)(53546011)(54906003)(508600001)(2616005)(83380400001)(4326008)(186003)(8936002)(316002)(66446008)(38070700005)(36756003)(71200400001)(31696002)(85182001)(86362001)(31686004)(66556008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?citKc1dFek43K3pQYVFOTW9lTG1hdnoxODJvVisyR1V3MjdoMXRTYU50c3JX?=
 =?utf-8?B?d0hneGNKTU1RQ0J4STBsdEEwcjY2d0I5TjNObjdYSk5LTHBFVlkrMXdOVm5Q?=
 =?utf-8?B?SkczTk1xUm9HNkwvcmw5RUpEWWJpbkdXSFZuZWhIQkpVRDVwWnZmNTdtc0Vm?=
 =?utf-8?B?OG0zdnp1ckh2bmVraE5aa25pUGZobTVwbUFsNGM0d0E5MFhyVW1Mblkrc2xh?=
 =?utf-8?B?cU5reGpudEVVNHdEQzEvVUxPdVlSaGFzR2w1SHFjNEgzcktHN3FHL3RBa255?=
 =?utf-8?B?SnZzeUh1REVuaVFwaDVNcE1PM0FPVUpUOXhHTGx1ZndSSmpWQm1oS1dnWk1X?=
 =?utf-8?B?bk5Pa0c5NzZzemRRTXpaMGFWNUZLa2NML3lhS1NmaC9KMkswUzhNUm0rQno5?=
 =?utf-8?B?ZDRCd1p5K1kzNVF3UjJhS21zU25jZnBaUnlyTm1kOXZRY0pCeVFCV2MvY3dR?=
 =?utf-8?B?WFZqR055ajRGejZPc2dqWFhvTnBORjRpQ2MzMHRUQlluOWloRWxwTzAveEx5?=
 =?utf-8?B?eEJJN2Y3dzBrK0huQUhjclk1Y2l3Rm9pZzl6SDBEbytEM3psNUJJMStMUTRU?=
 =?utf-8?B?VEdYaDAzYmxmdWV4a3Ria2IvSkFCdldIR0UydDYrMDIyZjVWcEZtc3FiaHdK?=
 =?utf-8?B?V3J2NUZnRU5QSjdIZXJ0aGNBOS9Cb0hWMFRrd3BWWUJaOUF3YU9vNzlsUTda?=
 =?utf-8?B?eERTbEJjVHpkUnBsSXo1ZmdOdXpid2tQcDk3dDFKdmhCbklRbzlXZ0tzOGc2?=
 =?utf-8?B?TUREMWlMTHJKZm9vdmd0UEF6VTBYUDdGSktrZFpwbWVNOXk3K0p0MkREbnBv?=
 =?utf-8?B?eE05Vy9iSnorbFZYUWtHalZmUlBmVjZQeUdsSG1oYzVzRElMMSs2dVpOc3lU?=
 =?utf-8?B?cWpzalZpNjNvSXFxT2N4ZFB6MXBmRzc3ZWM4YkwrU1lXWXF2VWxSREsrTFZl?=
 =?utf-8?B?UXp3R2hTRUFHb2dzeEdqVHVZU3JFeUprVUVGRjRDWEo0d0dCK2VXM2ZxZzZo?=
 =?utf-8?B?dEppbmlEQkdrNWRUc0JFUytMbE9SWklUOXgrZHlZbWUxb0JxMzNuRDUwQ3cx?=
 =?utf-8?B?NzRKOTVKSVBhY011WGFEVk13eUlCL0d6TzEwQ0VBNDZkbThCVEc4TWg0VnIz?=
 =?utf-8?B?WG5Jekx1aWVHNFFJc2dIYWtjMHJUZWd2K1pQZFRTZkFaS1dGVXNQRThaNXYy?=
 =?utf-8?B?dXNGNkRtQjBSSzkzT21VR2RQZitHUkJHY0VYSEt2UEgzY3VRdk5XZy90RTdG?=
 =?utf-8?B?dDBpeDhjWUVjZ0Iva29qU2h5UnBDajNXN3hSTkd2T3Q0YjlJQVpyc3JpT28v?=
 =?utf-8?B?aTdoeFdyVysvMXNoTzJPTGVTMml1aWE2Uzl4aEJpcUM0TTFITkFUUzJHS1RN?=
 =?utf-8?B?dndTNXZVMC9DUDFCWk41am5kMUNWSFlVNmRtbkd2ajhXMkxDb1JXV2tmclla?=
 =?utf-8?B?cHluN0Q1V0JBWm14S1ZMQ0ZYN1J6K0FLTERyV2FJa0xYZUUwQldJSFB2Ykc3?=
 =?utf-8?B?L0NPd3I4U2JCV2g0djJYcmNGZi9randXSXh4NWNjZVlWVVdyU1RUUC9Pcis4?=
 =?utf-8?B?TitNNDFBVDljaXBUbStKZ3lCV2pKSXZsMGRmZVlvVjgvam9abCtUQjE2MU1z?=
 =?utf-8?B?TW5ITjFXOWFaeHJrN1NqUUtvNzduS1BuZTUxQllqT1dtYVZrNkxqanJsb3Zm?=
 =?utf-8?B?YnlWTFl5K3huUUdja1VGYUpwbWZEYWIvUm1Sa1BqU25mZWwzU3c0d2NFSjBT?=
 =?utf-8?B?TGJucExlTk93SHhFRktvL2I1S2lZbHFGbG96MmgyMlBaWmZVN3k3U3paZlYx?=
 =?utf-8?B?d2dUU3pYS2UvekJnNHBiV3RjbndvVlNPcjRvOTRYZm12eW01c204WmZ0L1M5?=
 =?utf-8?B?UzhYSjVaejA2K0UrWEdoTm1KenIvQTJ4S3cvbkxRNDRUZDkwVWlnSEFsSU9G?=
 =?utf-8?B?aVFlSHI1NDdQbjI5c2d5bU5DdjZyOGIwdDdvV0psb1JiSEwxZEJCVUZGdzBr?=
 =?utf-8?B?NFFCd2tCSGpPeHk0ZjN5Vkdqd20vMTFZUzJBSXBuNWQ3YmlmRnp6d1RQbzI1?=
 =?utf-8?B?emE3NWxsZ0s3SDN2R3pRS2NudmdxckJEdmtJMm5OOUU0eEl2cThEbkFST1dn?=
 =?utf-8?B?S3RTU2JLN2hEaFJoMkt1eUp6M0E1M20wQjVqanNMdG8zbE1Oa3lXNEtqQTdl?=
 =?utf-8?Q?/gQZUbYH+N7nDlGHLs0/9j8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74C2B6E99FCF0B43BCD7988262F55F16@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ac598a-2f9d-40f0-cac1-08d9d5b0fd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:50:38.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MRP89f1sBdHPbQ4pqMx3asSaPwX8YVeYYBEAcyoCJw4i7o1/iPCv/xTcLMcE/FwVBDOS0iav0JTaC+zbTE4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8672
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDEyLzAxLzIwMjIgMDQ6NDgsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVl
LCBKYW4gMTEsIDIwMjIgYXQgMDU6MzQ6MzZBTSArMDAwMCwgbGl6aGlqaWFuQGZ1aml0c3UuY29t
IHdyb3RlOg0KPg0KPj4gWWVzLCB0aGF0J3MgdHJ1ZS4gdGhhdCdzIGJlY2F1c2Ugb25seSBwbWVt
IGhhcyBhYmlsaXR5IHRvIHBlcnNpc3QgZGF0YS4NCj4+IFNvIGRvIHlvdSBtZWFuIHdlIGRvbid0
IG5lZWQgdG8gcHJldmVudCB1c2VyIHRvIGNyZWF0ZS9yZWdpc3RlciBhIHBlcnNpc3RlbnQNCj4+
IGFjY2VzcyBmbGFnIHRvIGEgbm9uLXBtZW0gTVI/IGl0IHdvdWxkIGJlIGEgYml0IGNvbmZ1c2lu
ZyBpZiBzby4NCj4gU2luY2UgdGhlc2UgZXh0ZW5zaW9ucyBzZWVtIHRvIGhhdmUgYSBtb2RlIHRo
YXQgaXMgdW5yZWxhdGVkIHRvDQo+IHBlcnNpc3RlbnQgbWVtb3J5LA0KSSBjYW4gb25seSBhZ3Jl
ZSB3aXRoIHBhcnQgb2YgdGhlbSwgc2luY2UgdGhlIGV4dGVuc2lvbnMgYWxzbyBzYXkgdGhhdDoN
Cg0Kb0ExOS0xOiBSZXNwb25kZXIgc2hhbGwgc3VjY2Vzc2Z1bGx5IHJlc3BvbmQgb24gRkxVU0gg
b3BlcmF0aW9uIG9ubHkNCmFmdGVyIHByb3ZpZGluZyB0aGUgcGxhY2VtZW50IGd1YXJhbnRlZXMs
IGFzIHNwZWNpZmllZCBpbiB0aGUgcGFja2V0LCBvZg0KcHJlY2VkaW5nIG1lbW9yeSB1cGRhdGVz
IChmb3IgZXhhbXBsZTogUkRNQSBXUklURSwgQXRvbWljcyBhbmQNCkFUT01JQyBXUklURSkgdG93
YXJkcyB0aGUgbWVtb3J5IHJlZ2lvbi4NCg0KaXQgbWVudGlvbnMgKnNoYWxsIHN1Y2Nlc3NmdWxs
eSByZXNwb25kIG9uIEZMVVNIIG9wZXJhdGlvbiBvbmx5DQphZnRlciBwcm92aWRpbmcgdGhlIHBs
YWNlbWVudCBndWFyYW50ZWVzKi4gSWYgdXNlcnMgcmVxdWVzdCBhDQpwZXJzaXN0ZW50IHBsYWNl
bWVudCB0byBhIG5vbi1wbWVtIE1SIHdpdGhvdXQgZXJyb3JzLMKgIGZyb20gdmlldw0Kb2YgdGhl
IHVzZXJzLCB0aGV5IHdpbGwgdGhpbmsgb2YgdGhlaXIgcmVxdWVzdCBoYWQgYmVlbiAqc3VjY2Vz
c2Z1bGx5IHJlc3BvbmRlZCoNCnRoYXQgZG9lc24ndCByZWZsZWN0IHRoZSB0cnVlKGRhdGEgd2Fz
IHBlcnNpc3RlZCkuDQoNClNvIGkgdGhpbmsgd2Ugc2hvdWxkIHJlc3BvbmQgZXJyb3IgdG8gcmVx
dWVzdCBzaWRlIGluIHN1Y2ggY2FzZS4NCg0KDQpGdXJ0aGVyIG1vcmUsIElmIHdlIGhhdmUgYSBj
aGVja2luZyBkdXJpbmcgdGhlIG5ldyBNUiBjcmVhdGluZy9yZWdpc3RlcmluZywNCnVzZXIgd2hv
IHJlZ2lzdGVycyB0aGlzIE1SIGNhbiBrbm93IGlmIHRoZSB0YXJnZXQgTVIgc3VwcG9ydHMgcGVy
c2lzdGVudCBhY2Nlc3MgZmxhZy4NClRoZW4gdGhleSBjYW4gdGVsbCB0aGlzIGluZm9ybWF0aW9u
IHRvIHRoZSByZXF1ZXN0IHNpZGUgc28gdGhhdCByZXF1ZXN0IHNpZGUgY2FuDQpyZXF1ZXN0IGEg
dmFsaWQgcGxhY2VtZW50IHR5cGUgbGF0ZXIuIHRoYXQgaXMgc2ltaWxhciBiZWhhdmlvciB3aXRo
IGN1cnJlbnQgbGlicnBtYS4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiAgIEknbSBub3Qgc3Vy
ZSBpdCBtYWtlcyBzZW5zZSB0byBsaW5rIHRoZSB0d28gdGhpbmdzLg0KPg0KPiBKYXNvbg0K
