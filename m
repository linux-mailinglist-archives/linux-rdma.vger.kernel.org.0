Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBAB4821D2
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 04:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhLaDe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 22:34:57 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:28440 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhLaDe4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 22:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640921697; x=1672457697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=89CjJJO9ECfco+9I9rP4iqXuKwDrsVlGg0RG373+wUo=;
  b=uIx/Da/dedo/yNtye5xM8za4ix1xBetb5HYSTAWSCSMbPfZucfBFB5w5
   +PfINKjEOEuV+iwzdtGo8ltPFGPDyxWF+ncX+ZKX+4/XtCGjTru2o1pOc
   ygdXXjXwPjWs2oJktcw/IjzSpGcd9cgRGoEh3qDeVgOcMLdizeiC8N2yY
   Hiz0jCsl7J+5lvwJY0eN7lokntrkb6VZz4kXD7e13XtbBKb9qglSve8PS
   tShYy8WOH6f9yQgRsDQQdafDnHwxdS9owrR4CNCIYmgFCf7XX/muekGo3
   fOxYyXZqiMi+/Rqlsux3raoDu80vcAZOGhmLatmlUgNYd1yoY5/u7CIqJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="46912583"
X-IronPort-AV: E=Sophos;i="5.88,250,1635174000"; 
   d="scan'208";a="46912583"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 12:34:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8tcPQBf/wY/GWfMRZvg1cmms8ygVfNBGT8s8UEtKGK6R/iTOhHcemyREC08Z3mNM1wxP3E9R5o2KY10Jv+V+oW1iAJARJZ6yD+DilYcFQ+3K4Z0QT4oba+Dn9MmJyQ8Fstk9sVgzezNcjNyHewWTvqxs0+NC5pejVLjmaegkKodKmDMQEbQdp9VOnJwxl4GRUrZKr6v2ZUhzwjpu37/xIQZeShjqPgrjdWbi10nSn029ZKyZ2sIVRz6h72C7u35BaKH9fULUrbyQjQZFsNYWQntPwsFr+Zby+U7/hgLcLC4K9rYnu0QomGgD46KMmGnRt6mfYKSianAUNR7KpAUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89CjJJO9ECfco+9I9rP4iqXuKwDrsVlGg0RG373+wUo=;
 b=ecOPIEh0oIe6sGbjqWNNOL03m5Hkek8+ohyzNQkEFVvtHBOnSEJZyDDMFV/BsGlXeZu+eIFbH8eBm2z7ynGkWnNzlUqeiBkwsQMGUV7YJHQ6WUTIteUYiP1pAz+w2OMwFbYOh0jepsK0qtvAiwtNA9CsNmMKVJF6CfBLkaOPdDSikxdRDxNmkDO3L16ckHG15TMcsEmVnhAvr6FvM3i23dVJ0nK49N81pImUGQYpqrj2bStCaWnDQK6ZIOG4Yykz7BBVlyE47rT8R3WQbRoKgWUy3s9QbGlo6vEi4JNknnLbRhKgjtYFSV199HErjFHUXQJEQyBnepO8kYHPCpYm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89CjJJO9ECfco+9I9rP4iqXuKwDrsVlGg0RG373+wUo=;
 b=lN9O5gXN63mHVnu5sGknGTEr6FQjhTnULTazHaL7qFTZvsq5N5u1kHXkBlpYN6mUWPwOT6COrvBVmTy4eFekVLAyWfUfa+xCwUclsBZVbpO5vZ2n6L/vbp2MHKblEq2gqzC+0Gcd0sOR7bfXA4zaORIRVS1AYNeGJWmuChqVrDU=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB8506.jpnprd01.prod.outlook.com (2603:1096:604:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 03:34:49 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26%9]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 03:34:49 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Thread-Topic: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Thread-Index: AQHX+8EvplXpTw43GUqgtpn7ngqG46xLoKmAgABWnIA=
Date:   Fri, 31 Dec 2021 03:34:49 +0000
Message-ID: <15ad4285-7a74-2b3f-1c1e-823b36cfcf82@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
 <45bfd837-a784-5ea2-7ae0-46e7e557b030@talpey.com>
In-Reply-To: <45bfd837-a784-5ea2-7ae0-46e7e557b030@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d867b59-24dc-4bf9-b3f8-08d9cc0e7f9b
x-ms-traffictypediagnostic: OS3PR01MB8506:EE_
x-microsoft-antispam-prvs: <OS3PR01MB850634A2749874297383436EA5469@OS3PR01MB8506.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOlvcKX6F1PyY3iSIkzjashy90eqO3StFqdt9WF+vBQ42876fGieCcetkNuqShZhXekzPYJNNjv67r6apNi/pWNeZfzzk5vf6gFUaB4Pzoc7ximEzNX2kvrjrlwT3cpY6ob0C9T0IX1WHE6GZxIvIfF886CNZC+fQlBdOsii4C99s2JFqRmE8jg7rRWOFfaO5LT/D9ll+h9THJbzvMgkcSs+UzJ6TZVD97kR6EkP2aCGa4ZAgzOsBCeRaZQrVR79kRa7afKdZ4jSL91NrgEPQmNtzW6Ju8m26JOI8ja/NaIEElbyRa9CjDEXfl7N0bFBx/3eH0SgW+EJz76hCZOMR1Jc5VTk9QtibNfa33ggt4bioIcO/yqKoL8oS6Y8ieZRdWgfjA3ZX5oNzE3pzLayDkqShgpLBenwlhlttsCQXOq2A2hMF5hbLbNNYKaDTtTKN0fEB8bzRJ9uz/ftXbxonyWVJv5wW0pxcAcJsnMxRB1NFXrgTsUQM0mvi7aRSdzRxHiuc6utHigPEJAuQ/GUHtHq1uLwcO1lJ/KxkoPAjFMnWb7kbiFYbPbQS/tXnHhIuSPRFesfdM2hoFqaK6O4mGRXfPNk1LX6v8ZAUI8WvfYHBQT3myqn3BsgJjlI+x5Eg9RQNnYh9xMkdxlsGvKgNc2au8TdFDYalgtzw24yn5WtFyve7E5hInqtqGAbt8E6eS4MTa7dsjB55l2AsopdpNyRvUeknh9nhRuO7OLq9YEXuvWmL6H3Ct45wXuMzOsqnPbG23a+xIqD39/rlT1j0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(54906003)(316002)(2616005)(36756003)(83380400001)(86362001)(508600001)(122000001)(26005)(31696002)(2906002)(66946007)(8676002)(6512007)(110136005)(82960400001)(71200400001)(66476007)(85182001)(5660300002)(66446008)(66556008)(186003)(6486002)(38070700005)(31686004)(64756008)(8936002)(6506007)(38100700002)(76116006)(91956017)(107886003)(4326008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODlKc1ptY0tZRThCcVpnWXkzcU9iZWVnem0vNjQyWEp1Z053TEF4QlNORlhM?=
 =?utf-8?B?TFJhMjk0dExyNjNvZDNKOE5McitwdS9yOWRLb3BFS05Seml4Z2g5S1pPb2JD?=
 =?utf-8?B?SS9sOS85Umo4ckx2YWhVbUNlTzlrUFhpR0NYbjdSZDRTaUZPMjJIOUNyNGFo?=
 =?utf-8?B?Q1dGb2Iya05Udi9CWXlCbXdIZFcwbW1jeDE3UkF3UVdsTXRMcDlBSXJIcnh0?=
 =?utf-8?B?Mnl3SHVBRVV2LzBJQzFDdjVTb3prRDcrakx5TjVYYXNHWEc3OCtrbDRkYmQv?=
 =?utf-8?B?Q1kzdG1YNjFpZitpYk1iVVZNOVU5cjl1akRWMWs1ejV1TWV2cUtmSTFpam16?=
 =?utf-8?B?dlozSVJXVzBhZCsyWTZVVkQ2cXRvaU1LYy9hQXkwR1FiOE96QmEwNmEvRkpT?=
 =?utf-8?B?bVBhZVp1OHBaMU5lZ0lQb2o4OXhCVUU2NGY1ZTdTbHpHN0YyWWhZTzdnWHlj?=
 =?utf-8?B?SlVveDh3dDkraENLSytTNE4vdWdnL2I0WE9SbUV3UHFBUTE4dlovbXJKam5E?=
 =?utf-8?B?c3lKTmMwZW5HVFQzQXZDRzU3cG5GMEw1aFZkQUo1WjZJN0FPSXlMdEVWdk1M?=
 =?utf-8?B?RjFzeDlXSUlwUTNxZDV6N3JPL1Z6dW9XNWhMc0VLTEEvdUdFYk5xOGhKTEhM?=
 =?utf-8?B?RWxqanJPbDlFYUV0NXJlMVJSRlhtbG91YVE4bXlXWVoyZDNDUjY0M2tsenhP?=
 =?utf-8?B?MnVpcDFKM2I1L09Kd2ZoMWErdVhKSE9KSzRuemFVankvSnlZZk1oajVEUTUw?=
 =?utf-8?B?M013SFcwOEMxMjFodEVXTTFhaG1NTjBqVlhmZUJxdUUvUHVTSGlrOG42NTRx?=
 =?utf-8?B?Sk1CeWM2TlZUbzROSkRDSUl1M0E5UENTQSs2OG54SXA5QVBRREJ6N3BMQnpD?=
 =?utf-8?B?Yy80SnJ5ZW1nMHJqTDgrMVZXZ25HSnFXZkZHRTFjc3R5b0lidHVyUWVkZFYv?=
 =?utf-8?B?WEF4cXN0MmhlWEd2UW9qV3FRN282ekw3WjZRc3k3cW1pem52M28wZjRZakIx?=
 =?utf-8?B?T0QyKzhxM1VDS01ZcU9zbytGWjBJei8xUTFHTmoyZlI3WURDeTl5cXhSSVF3?=
 =?utf-8?B?ZU93UklaNjdOQlE5aXdjTmtGT1RnRU9PYmVKNkxPM1BvMzhETkdtT08yVWR4?=
 =?utf-8?B?cEg0ODBmeml2SEZMalJOL0hiTE8wc1pab0R3SlBFZFJoT0MxLzVDY2UxQ2hz?=
 =?utf-8?B?Tlo3ODc2ZThRM1VBNGkyVWN0MEtiT2dxMkNKYUk2Y2swejFlRVN2aURRMTZu?=
 =?utf-8?B?TUtWaWRWQ0w4dGJodXFzUVpRMUdxMDNaZ1k5Y3RFSHg4VHR4YmVtRU43c2xY?=
 =?utf-8?B?cSt2RHFoNEFINmlEQXBhNHJMZmRXVEp6bTJXbUZDVHpJMUtwblhyYVhFQUhy?=
 =?utf-8?B?cHFtRFJxb2MyVnUzQ3doYUgrNmZQMk5kSkxweGtVZnlXcXVic3FVTnhlV1hG?=
 =?utf-8?B?QjJJYUF3dUxERHNtSlpTaWVmYWkwOVl4M1pLQklaQzNIb3dtN3BLckNxaDJH?=
 =?utf-8?B?bTBtVERBdjg1YU9RaXRhZjBBUFI3Z3ducjhlN25KaTVLbFJicmlTUm12d0FW?=
 =?utf-8?B?QmlSUG5aT1lMK0QzVUIzcVNKclk0L3FkMTV4KzJ3a3QvUFJUckxPOEtqZzVj?=
 =?utf-8?B?cmRvSlYrZmhHV2ZIeUZUOVIwREEwSFhPKzlaaFJCVklLV3U1YllOUUd3RXZP?=
 =?utf-8?B?TnNuK25PSFZUTE1XNEJUZVN2RDlLcWlNWUhiazNpanpRMGhUVkk0ZWIrTUE5?=
 =?utf-8?B?NCtzSlZvdVNiM2U3YmY4aFZkaktPV1EvMXdlanovWW1SYXZDSWl6TUU1NXZx?=
 =?utf-8?B?NTllUXl0QzYzRXpnR0loQmpEWldpVEt1QmZuTjM5emhzSENNQ1RHSUVjN0E4?=
 =?utf-8?B?Mm10OC9kMk0rbDh1MmpLVi8xd0srSTF4WVdvcEZkN2h0aGJzWGRLRFNaZ3RS?=
 =?utf-8?B?NnhtUVVyOEJCbXdEUVByOG14Sy9vQjduZUZYUU1IYmtoa0poNmt6VFQ4cnBN?=
 =?utf-8?B?d29XSzh3STc0eWprdFZpSWk1MUVqMGpUNXJkdm11SUhPR25iNnZNNHRLekdP?=
 =?utf-8?B?RHkxcVBGSkViRlJSZmJkQkNjN1NxazJqQTZQOU5GYmU5eEgwbVZzdlZBckha?=
 =?utf-8?B?UEkwalJJRGtQdjc5WWZYRzYwRmRaOEdLSHl5VytML1hvVVJ6ZXdhdzkzUkVl?=
 =?utf-8?Q?Ht55+hpF0/7tkb+FrGSsSLw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01122B4DA624424DB537C42EC19051E2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d867b59-24dc-4bf9-b3f8-08d9cc0e7f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 03:34:49.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxT064b9ahxwOfs2NCUoIWedCrC8qyFWXGpACtTRA1Bh64rDpRoPakLkWSB44qSpckp+zDCB/fqes9N1oHMNKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpkZWxldGUgdW5yZWFjaGFibGUgbGl3ZWloYW5nQGh1YXdlaS5jb20gZnJvbSByZWNpcGllbnRz
DQoNCg0KT24gMzEvMTIvMjAyMSAwNjoyNSwgVG9tIFRhbHBleSB3cm90ZToNCj4gT24gMTIvMjgv
MjAyMSAzOjA3IEFNLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gTWVtb3J5IHJlZ2lvbiBzaG91bGQg
c3VwcG9ydCAyIHBsYWNlbWVudCB0eXBlczogSUJfQUNDRVNTX0ZMVVNIX1BFUlNJU1RFTlQNCj4+
IGFuZCBJQl9BQ0NFU1NfRkxVU0hfR0xPQkFMX1ZJU0lCSUxJVFksIGFuZCBvbmx5IHBtZW0vbnZk
aW1tIGhhcyBhYmlsaXR5IHRvDQo+PiBwZXJzaXN0IGRhdGEoSUJfQUNDRVNTX0ZMVVNIX1BFUlNJ
U1RFTlQpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5m
dWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYyB8IDEyICsrKysrKysrKysrKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IGluZGV4IGJjZDVl
N2FmYTQ3NS4uMjE2MTZkMDU4ZjI5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfbXIuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYw0KPj4gQEAgLTIwNiw2ICsyMDYsMTEgQEAgc3RhdGljIGJvb2wgaW92YV9pbl9wbWVtKHN0
cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IGxlbmd0aCkNCj4+IMKgwqDCoMKgwqAgcmV0
dXJuIHBhZ2VfaW5fZGV2X3BhZ2VtYXAocGFnZSk7DQo+PiDCoCB9DQo+PiDCoCArc3RhdGljIGJv
b2wgaWJfY2hlY2tfZmx1c2hfYWNjZXNzX2ZsYWdzKHN0cnVjdCBpYl9tciAqbXIsIHUzMiBmbGFn
cykNCj4+ICt7DQo+PiArwqDCoMKgIHJldHVybiBtci0+aXNfcG1lbSB8fCAhKGZsYWdzICYgSUJf
QUNDRVNTX0ZMVVNIX1BFUlNJU1RFTlQpOw0KPj4gK30NCj4NCj4gSXQgaXMgcGVyZmVjdGx5IGFs
bG93ZWQgdG8gZmx1c2ggb3JkaW5hcnkgbWVtb3J5LCBwZXJzaXN0ZW5jZSBpcw0KPiBhbm90aGVy
IG1hdHRlciBlbnRpcmVseS4gDQpJdCBkaWQsIGJ1dCBvbmx5IGFsbG93cyBmb3IgdGhlIE1ScyB0
aGF0IHJlZ2lzdGVyZWQgRkxVU0ggYWNjZXNzIGZsYWdzLg0KDQoNCg0KPiBJcyB0aGlzIHN1YnJv
dXRpbmUgY2hlY2tpbmcgZm9yIGZsdXNoLA0KPiBvciBwZXJzaXN0ZW5jZT8gDQoNCmJvdGgsIGJ1
dCBpdCBzaG91bGQgYmUgY2FsbGVkIGluIHJlZ2lzdGVyaW5nIE1SIHN0YWdlLg0Kd2UgaGF2ZSB0
byAyIGNoZWNraW5nIHBvaW50cywgaGVyZSBpcyB0aGUgMXN0IGdhdGUsIHdoZXJlIGl0IHByZXZl
bnQNCmxvY2FsIHVzZXIgZnJvbSByZWdpc3RlcmluZyBhIHBlcnNpc3RlbnQgYWNjZXNzIGZsYWcg
dG8gYW4gb3JkaW5hcnkgbWVtb3J5Lg0KDQoybmQgaXMgaW4gW1JGQyBQQVRDSCByZG1hLW5leHQg
MDgvMTBdIFJETUEvcnhlOiBJbXBsZW1lbnQgZmx1c2ggZXhlY3V0aW9uIGluIHJlc3BvbmRlciBz
aWRlDQp3aGVyZSBpdCBwcmV2ZW50IHJlbW90ZSB1c2VyIHRvIHJlcXVlc3RpbmcgcGVyc2lzdCBk
YXRhIGludG8gYW4gb3JkaW5hcnkgbWVtb3J5Lg0KDQo+IEl0cyBuYW1lIGlzIGNvbmZ1c2luZyBh
bmQgbmVlZHMgdG8gYmUgY2xhcmlmaWVkLg0KDQpFcnIswqAgbGV0IG1lIHNlZS4uLi4gYSBtb3Jl
IHN1aXRhYmxlIG5hbWUgaXMgdmVyeSB3ZWxjb21lLg0KDQoNClRoYW5rcw0KDQo+DQo+PiArDQo+
PiDCoCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1
NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50
IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpDQo+PiDCoCB7DQo+PiBAQCAtMjgyLDYgKzI4Nywx
MyBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1
NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+IMKgIMKgwqDCoMKgwqAgLy8gaW92YV9pbl9wbWVtIG11
c3QgYmUgY2FsbGVkIGFmdGVyIHNldCBpcyB1cGRhdGVkDQo+PiDCoMKgwqDCoMKgIG1yLT5pYm1y
LmlzX3BtZW0gPSBpb3ZhX2luX3BtZW0obXIsIGlvdmEsIGxlbmd0aCk7DQo+PiArwqDCoMKgIGlm
ICghaWJfY2hlY2tfZmx1c2hfYWNjZXNzX2ZsYWdzKCZtci0+aWJtciwgYWNjZXNzKSkgew0KPj4g
K8KgwqDCoMKgwqDCoMKgIHByX2VycigiQ2Fubm90IHNldCBJQl9BQ0NFU1NfRkxVU0hfUEVSU0lT
VEVOVCBmb3Igbm9uLXBtZW0gbWVtb3J5XG4iKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBtci0+c3Rh
dGUgPSBSWEVfTVJfU1RBVEVfSU5WQUxJRDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBtci0+dW1lbSA9
IE5VTEw7DQo+PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gLUVJTlZBTDsNCj4+ICvCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycl9yZWxlYXNlX3VtZW07DQo+PiArwqDCoMKgIH0NCj4NCj4gU2V0dGluZyBp
c19wbWVtIGlzIHJlYXNvbmFibGUsIGJ1dCBhZ2FpbiwgdGhpcyBpcyBjb25mdXNpbmcgd2l0aCBy
ZXNwZWN0DQo+IHRvIHRoZSByZWdpb24gYmVpbmcgZmx1c2hhYmxlLiBJbiBnZW5lcmFsLCBhbGwg
bWVtb3J5IGlzIGZsdXNoYWJsZSwNCj4gcHJvdmlkZWQgdGhlIHBsYXRmb3JtIHN1cHBvcnRzIGFu
eSBraW5kIG9mIGNhY2hlIGZsdXNoIChpLmUuIGFsbCBvZiB0aGVtKS4NCj4NCj4gVG9tLg0K
