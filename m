Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC964920FB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiARIJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:09:37 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:12312 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344037AbiARIJe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 03:09:34 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 03:09:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642493375; x=1674029375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
  b=XCRZP/N8ecCy5yBZ09lHeVsxGaklbdyvW7GimMn08KOhaTjB/bAIBXmk
   fFrAMNETpnylFgOtiQPFVhL/MnWct5j00hCyMC6FYCI7SjzWQeXOQk76u
   n5ScoC/S5xlwl3x5m8H6q8G9GwsI1tZu87OYMTQ3FjjJefXBkLzyaY+Jx
   7BysXIR4ajrB2jpYatXWhI6ukb++BlbshRySKGxfFHOrW4rWbnyN3Insf
   cWHKNFdd+4D6KmvVf9bVuTi44GJyrUd+xccBo8gDWspvenNJJLImseOoO
   R7hGD6tD7ilOMrirjuAKPxVBewjbKdxMGgsPV/Q+yRo9HABr4IUHrVhNv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="55733338"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="55733338"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:02:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK4KmpBF0OwsVNfYp0Fzve2reN5eXu8Cc1mvZ7NSCRmHR6Ap/SGYq+22y7hFaMfiBtmzyQObNQUSGiwT3LKTxsV0S1WR1SARzp/8odFWdal3/aVxkXBC1XboMeiGBFHaA59UfTzlgCDjayJimwQgngw84TmLN33GBJ3rJ2OKDXbVzIhOMPdoJiHi808SmT5VMTdLk/jj/RZNuHLDCPKhZN1wBPpaCG7wfrCBkq+ai9m/IiXU2+WPl5bxSbRY/6bPNjJ9cjCD2uRMD1FmpuweNpcEjsiB1UaMqVNgWM1jdDDKk4jc3bllsbkyV2zgI81/p4w2LkgwqAZlKgNWIKjsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=T2gIvVVFJIAepz49Lk8iPi/jblQsSAd+QUBi/VFYxeMS/F8KSdn4V4qQ8WGBKcC8aOJSJ8gGe21eXwr0pMgKGJ8iTO3yDsrYZpsvdoxh65YOo/hHNIW9cmhGoem53esEnJiOJRlW8vAbXszEmFT9G+QPl8Xs1JK8sI8JU1EqMjLKMNQXnQ9UeHqBiGIrO/f6Hui+q9ZlkaK/fX0qXs9SO0QLhIXogFANHJ2gmsnbsPgvigUkEDs8WAqajOxgxywnimNToDxTOML8mTPl25QPpJKW7PelD6KYCSQfNNvbl1iVA9m8/ZVE4/is1oZ+W7kdCuzOyrDmQoGlkdLI9RMnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=GfzxIWHsXsq0HRsYG7Jp1AFel1ejwyrUP6O5x77TMSltD7WKEUwcfUJfKkXiGVWe3D7Lq761L+gUrdI9zItgrrOKIjMI9FYn3/6i6FkRbjwwqmgt2EnqjX/hE8HAYP51oYoOVEHbF6p1JCP0psWOVLfMJRzxqOixNZ7MytMsD9k=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYXPR01MB1757.jpnprd01.prod.outlook.com (2603:1096:403:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 08:02:22 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:02:22 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE6lIA=
Date:   Tue, 18 Jan 2022 08:02:21 +0000
Message-ID: <61E6740B.705@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
In-Reply-To: <20220117131624.GB7906@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1828f16b-b0ba-4c84-909f-08d9da58db43
x-ms-traffictypediagnostic: TYXPR01MB1757:EE_
x-microsoft-antispam-prvs: <TYXPR01MB175788ABCE5351A6E293FFEA83589@TYXPR01MB1757.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxlUuLijvKxjIgKoLtRr88C0HkDOjWrBHZP24qlTToO/j7aGOkilN2sTZkOsREIBlsDl+jJeQW8JooWmSXJxL7v3RXXltqf8Gs5hqCVsYV9+iulXIngnnxaURUOI/urv4aJBMKVxKyGpi6uOBZjFZIqxopi/Kzn9bx2OAvGL4CPHKS45DRZy53YmmEqrDQS6q2afLSyX6CteYxxsnZ1p+4r+yEJ32VD0VYvNltIi3tM040DxOLs4Uq7yOyGo86JKToEUviMpf9ANee8oCSJ2ksmyx/Kz1UgY7SIuQ2E5SnQsm88oR9f1CeyLXajliN+fqDgZnNCbng90xJ2F/HnfzNZWUwjzsi+JWDYyuGpGQh/yGZkxNXgSlH23h+vI/bS1uc9E5iGNQ/5G0huBNZpoFiU6ZI7SZ1twNi+zhA9fEw9ljNm2G5yj6WjXHDpjWMMSQEUrdeSirZTJWqkdllSIG90YAo0BCym5w/S2VfCdBr9p9w9OfgffbxrIrIJSSKNo1UBJBZnwJ5tLsQfETh1AQA5MGekSqc1xwgmnJEGF2WmtAqXJ1HlDV9klQnl2IZuEgU6POBFajtXXuGBNVvjLRdJa/ynF5Vy+1pP3Mxj5hPB7uial1Qts1FBIehmJeFIPOUq8c881GY67fDHMt6GkjqOZWpIUjVNm7yD3py8OrroHoWMxaaoup9sW/xf1W67k8ISpzWEcdfBtFeG2Jd6gVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(4326008)(38070700005)(6512007)(316002)(86362001)(71200400001)(6506007)(91956017)(64756008)(26005)(66476007)(33656002)(186003)(66556008)(66946007)(66446008)(82960400001)(38100700002)(76116006)(122000001)(508600001)(2906002)(5660300002)(6486002)(6916009)(54906003)(85182001)(36756003)(4744005)(8676002)(8936002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bHRHc2NNNURqeVkrc1I4UXR1T09HN2xPbGJTdDZBTTZyOEdHdS9TNkNjSGpp?=
 =?gb2312?B?YmVTM0lTcXVyck9YTkt1aTF1ZVdTOHBhREU5c1RXWi9SNmVnYUxFcE05d1hn?=
 =?gb2312?B?cTU5UnVvWWIyM1lRSXhoaExxR210OWNkRmswNGg1TzZkRHFWdUdEQXZEWlBv?=
 =?gb2312?B?ZEV5WnVmQnNhWExCQ25BQThhbWNkTWord2VyTlVHaWduTm1ZY0d6blFWS2Nz?=
 =?gb2312?B?UGJORVgzSG13QUxHeEVmb0c4MVdFa251YXBKTHhucVVCVXhGTEVza0JsdHdX?=
 =?gb2312?B?UytCektabnFzc2RxSzNjUkNLOHUvUFRibXB3NkxKOHVtLzRNRHV2S1hhT0pL?=
 =?gb2312?B?b3Q4eWZ5Yk1pbkFNWWpRbGdJSlltZXp4Nk1sNXU2ZHpMT3haN284cnJ1YlpI?=
 =?gb2312?B?czBpM2dwTE9KRENHQ1g5Mm9ubFVMeDAxd2J1a2diMlZvYUNiSTd2NlE2bDY3?=
 =?gb2312?B?ZE1lTTBWNlM1UFZTaGZrMDV1Q1JxY3FPQXlxRTM1OERLS2o2UlFrUjV5YWhY?=
 =?gb2312?B?REROYXpJTWxxcjdRZkxDdWd1RDAxQXVyRno5eDBXYVIxeU9Td0ZxWW9ybmhv?=
 =?gb2312?B?MnlydHArWW5FOUNvYm5iVndnVUswamNSSTBrNjU2MS9jUTdZeFNVaDY4SFR6?=
 =?gb2312?B?d3E0c1FlbUY4K2Y2V2VMZkYzSGJEREtiUnpCaGVwUTREWnd6NStyL0d1WWhL?=
 =?gb2312?B?eHNWUmNMTTNHT1l2a0ZqblJ3VWR6TlQyMnVCMjNwRXlqMEJBNDlqUWZxbXhJ?=
 =?gb2312?B?Tmk4TEV5dlc0RHhZdStnRE0wdHRGaTRvOVdzOTBNcVVyMXhROGxYNFRHRDBp?=
 =?gb2312?B?Y0tndy9KOHdLY0FjdUYrNGs4YUN5c3J4ano0U0RlUEc5ZUFWcmJGeEJVRXY0?=
 =?gb2312?B?cnp0Vk5jZjRFZU8rZlluRnVGbHNIS0R6SUhzWUh2L21LSVlGak9qbDZNOGZ2?=
 =?gb2312?B?MlBpVU9pQlp0ZDRZMkY2alcrQ3JHanc4MkppeEpIbjFYKzNUYXNscWNCM1ZE?=
 =?gb2312?B?WmVNbkhLM2JGUW16RkZ1ZjRmNzJXeGNoT2lkWThNSDloSE40NHdmZDVVRi9D?=
 =?gb2312?B?cEZrL2k5eTVBTUpjYW5KL2NaM0c5bzN5QUtocytPZ2M1QnZOTC9FN1lFeTMr?=
 =?gb2312?B?aHBjazkzKzlGK3ZTbTNNOHZ2SE53SVpXUUtVaktET3dKMjRVMGYrRkRLRThj?=
 =?gb2312?B?Ym5ZVXVJNEZrc21qaWUzaDlDaldSc0J4akFsWk9QMUtvWC8zN2NvYkNhRGdo?=
 =?gb2312?B?Qmw2UlZreDhRN3puUUhuUkJGeTFxajdFeVpIYm9uYXZ5ek9RWEhmYk54OCtN?=
 =?gb2312?B?UU9yODFqMlhqNEJRS01HY2dTUVpNV2duNHl2VTkzSjl3UWZEeFkwMTlJazR6?=
 =?gb2312?B?a2xoU21KazZBMzZPemcwNlBwY2laV2pNWkF3dW1YMzFRcENUSkpUWjFnYStw?=
 =?gb2312?B?dDVBeTJDZmRCT25Gb2JVd1Vwa3JjUFg3aWxNOWk2ak1JUHRQc1R1VEJRSDBo?=
 =?gb2312?B?SGg2Lyt0R3lVa1JCaXp5N1dqZ09iS2VlTHVSUHZPTUVJS1YxYnBaR0JGQW94?=
 =?gb2312?B?ckVaNVV3RFdhM1RQaWdNSEs5ZmRCa09zZks5MXVNYnNXQmJjRDcxUHc0dkNQ?=
 =?gb2312?B?b1dUeHJqbm9yaitpdDFWaVlYMlZOeENhNzE0RCt2YTV0cG5tSnRSZTBVRTFj?=
 =?gb2312?B?WFE1QlRsdlFqVGtTcE9XUlVWaXY0enkvcUN5YmRHSUdHSlZJOGg2b2pBMUF0?=
 =?gb2312?B?TTg0aUhjSW4xaUgzUnVOekc2eWs1RHVaeGhubXhZRy84bTlRbm00SDVRK2g0?=
 =?gb2312?B?WGs3Z3RmcG0wNGs2NmNyaldtSThTaktiRUhsaDE2Z3NWM3JaRXNvZ3pPaUpa?=
 =?gb2312?B?VGpxOWpLWkN6TDRqOEFxc251UUI5WkYza3ZtZGNvQmJ5N3UyRklZdUNmT0lC?=
 =?gb2312?B?NW1XamprZUVubE9Qc0tuR2pKdXZqS2Zvai9GNjBxZVhtVEhaWE1pRTNQeWQx?=
 =?gb2312?B?VGNsREFNYkJLVjhDTm9vQ2pjYzMvT0laRXJRRWlqNmVrR3kreVBOWGxrQUh2?=
 =?gb2312?B?MEZvcCt3bUY1T1ZpM1VsOGszVTRTYmplN1ZJMURBSmxVK2xqa0ZOMitTd2Iv?=
 =?gb2312?B?T3dKRmZlUUFEajBLWUkyenk0UHFEOHUzY2EzU1JNWVVpajBsSzhTSnpJY21w?=
 =?gb2312?Q?cg96pujzf5kh31pdQjTZ0wE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <8690E3D5B03DF045A5B570EABEFCBC13@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828f16b-b0ba-4c84-909f-08d9da58db43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:02:21.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fiheikzf7AMEciL2rg5tdSVXC95qCxqmiMl/pn058RQeKXYhJMRu7uV6xmi/V/sOwZQ4+XRsrcfm2Q44CWneDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1757
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzE3IDIxOjE2LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgSmFu
IDEzLCAyMDIyIGF0IDExOjAzOjUwQU0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+ICtzdGF0
aWMgZW51bSByZXNwX3N0YXRlcyBwcm9jZXNzX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX3FwICpx
cCwNCj4+ICsJCQkJCSAgICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IHJ4ZV9tciAqbXIgPSBxcC0+cmVzcC5tcjsNCj4+ICsNCj4+ICsJdTY0ICpzcmMgPSBw
YXlsb2FkX2FkZHIocGt0KTsNCj4+ICsNCj4+ICsJdTY0ICpkc3QgPSBpb3ZhX3RvX3ZhZGRyKG1y
LCBxcC0+cmVzcC52YSArIHFwLT5yZXNwLm9mZnNldCwgc2l6ZW9mKHU2NCkpOw0KPj4gKwlpZiAo
IWRzdCB8fCAodWludHB0cl90KWRzdCYgIDcpDQo+PiArCQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNB
TElHTkVEX0FUT01JQzsNCj4gSXQgbG9va3MgdG8gbWUgbGlrZSBpb3ZhX3RvX3ZhZGRyIGlzIGNv
bXBsZXRlbHkgYnJva2VuLCB3aGVyZSBpcyB0aGUNCj4ga21hcCBvbiB0aGF0IGZsb3c/DQpIaSBK
YXNvbiwNCg0KSSB0aGluayByeGVfbXJfaW5pdF91c2VyKCkgbWFwcyB0aGUgdXNlciBhZGRyIHNw
YWNlIHRvIHRoZSBrZXJuZWwgYWRkciANCnNwYWNlIGR1cmluZyBtZW1vcnkgcmVnaW9uIHJlZ2lz
dHJhdGlvbiwgdGhlIG1hcHBpbmcgcmVjb3JkcyBhcmUgc2F2ZWQgDQppbnRvIG1yLT5jdXJfbWFw
X3NldC0+bWFwW3hdLg0KV2h5IGRvIHlvdSB0aGluayBpb3ZhX3RvX3ZhZGRyKCkgaXMgY29tcGxl
dGVseSBicm9rZW4/DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBKYXNvbg0K
