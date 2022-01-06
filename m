Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492B7485E65
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 03:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbiAFCBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 21:01:47 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:12487 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344518AbiAFCBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 21:01:47 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 21:01:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641434508; x=1672970508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sidixAcl8yNItlHucgX/8WfUAutbtrsYwWJOg1ujY9U=;
  b=f4A3YwshZSfpHuwDLJOMQsm8JrOqfoOr1Lat37fJpcWPuHNIh9WX8n07
   M1TeZpASn13RUFM/KHPqYzOCV5O6LwuqGutcHudDurDCIQx/PctUaW/Lq
   xBLy4XUNoHYGJYFO5maM8UYgqv/YMOdMpnlANaN6st6fgxdmjYiCu+Te4
   gc16KSwIV5m5Xc+vQ+/WLF+AVXe0IlFZi4M98XJzt9kR7lOHSbjHiwDro
   sOCb1r2ZQWZNnrDba7LV9mmdxBndX+5Tr9L+h5F5yjJevXZgcFT3+TkNz
   lhuIWpGWh0/7lMrQOc4ZKYBWc58qURIltvHcH4STCWg7kCkKzA2zOYlgy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="55310894"
X-IronPort-AV: E=Sophos;i="5.88,265,1635174000"; 
   d="scan'208";a="55310894"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:54:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEgPgqpCCpyuFMkWjtpzg+bhlX3ngg//NtEAFOITUt382mnJ5MCNQrhey8X4DtjSKQS5PwMA0B3XLTfrSTEo4rRVjRmHsfOSgncmeSvivOSqc8PdxVimgN4Pcvx3C1phyGRXhxmI832OJlYR5SUwobhumkH8TYoqFi315a5vWfQvo8DcDriHJaTi2rnzj8hH0cbd5Y8QsM73+GgC6vLd/q/zhop/7Nkql+Iss0byfvcUxtFprMvoRKQy4/cK1QxocNA6f/OmlQZ/EwnmOu2rPtZrb3lCGrCZAkbp02L0j2J7knIQdz+lTx2e9GeR4MvnDeY+4f7kxB4vavTFRi98CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sidixAcl8yNItlHucgX/8WfUAutbtrsYwWJOg1ujY9U=;
 b=IndeFdFFOGmC4SM137GhwVKn66YQbhNJ4dPEsial7RnJJqEVQjGscgsOp5BSdZPwfumdgKcYSSXs03uKwnXH3fsLq4bkqSfYJr0KoJcCupJj+Yh+KzxVB8djr26TAr9RgsS5dwkuuPPUiL26U9rnkXCRewISeCx4Zj81AT3RPZa2UD18kcfZHOUM4XIk8u4sLvTGNnvHDv7mjQ6CNLMiRGvLb0RFRNRWeJKUP9ffcnGGq3LaNmalvIE0LyDeumK1ctvXmIxxpWK+jGzEGW4N7vwLc1Fugl8tn47d/Ox6ALHSZb3LI9dkLx4TiIH7LFYIGHuicfPDRA42lCGBsLyNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sidixAcl8yNItlHucgX/8WfUAutbtrsYwWJOg1ujY9U=;
 b=hyLIT+ctnmv01nWNcYmLhHO3uYpySnb3cplorQotV+rtt3tpJ5XHTCyBqgB4qG38u2Awl2RtWsqvflj61bpBdmnKlectmyWCfuPxFgnlA47FyphfpbjyA7geHJ0CR2sFrBCBM0GWIEYSooOIJ/btQmr+rIPfqURpjRuLY3IYUK8=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6374.jpnprd01.prod.outlook.com (2603:1096:604:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 01:54:30 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 01:54:30 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQaxLae+AgAAndACAAJOUAIAGetKAgABhiwCAAKMMAIABgeqAgAAfdoA=
Date:   Thu, 6 Jan 2022 01:54:30 +0000
Message-ID: <61D64BD5.9020401@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com> <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
 <61D4EDB6.7040504@fujitsu.com> <20220106000153.GW2328285@nvidia.com>
In-Reply-To: <20220106000153.GW2328285@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b36ee1a0-eab0-442d-caf5-08d9d0b77ad9
x-ms-traffictypediagnostic: OS3PR01MB6374:EE_
x-microsoft-antispam-prvs: <OS3PR01MB637468118E857FDE6B97EBDF834C9@OS3PR01MB6374.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCAqhkh1PXAM1pvhNfu1kGel+znaNxGCjQSOXozHgwvIKbobOx2xvc7C4tCVkidcZcqucMO0X1iaC8WEKQ38aoAr+oZGWpAsOQ118iZCpyyYdrlAdZs7zS6IskSZJwByb+gXai+cnyydOMbuLi8lU2zsyotH7pbrAbTJANef3gwUoXl09aEt/0LVjZbz8nB26ad2BBBvF/dYdCkdZrqGWOQa75SYlSgpvzzEs8lpo4xXmphAq8hnCWTdJA4ZVXGEpVC849FaQn7hXLywzPcQa4b6TwaX/LUUyF/BbsaQE3aRSOWG8RtGEn4/tumvcAZYQlF3E2J1W4WGhthAUwOEVhTAiNWvJ98G0H7PTsT+1GZl9kowgK9LRI7OuOB/ac3xxim3T2qnlk91L2i4Y2cApTQ5hwMBGaocvAgOuYPDbq9W4s63XrXU6yDxRSSu7YRXipZOyahBQ1h5HFhtUcLwFXgXMAc0eKtE4unDlPYL03Mm5z5DjfB/uZhSG+kfeYJezL5zocoEBz/wk5s4NhLPoAsvYbVRGd2jwA9Tqw0ZJu36je/YxibXe2wvo5lFd+iX1cdxArUdwfFOkgWCcyuSxg+/TEpdWYy2ShXFdYgdiJ5i4eeL/+KpKg05RJtqr2rYszP1Lklk2f2FUd7EOyjIqjZ7pc98gygsscX1TK5DbojludCIcz/ZaYQLqGXtsoGPxib0ESUj4ugt+jqfWRFnNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(86362001)(4326008)(508600001)(82960400001)(53546011)(38100700002)(54906003)(2616005)(85182001)(6512007)(76116006)(66556008)(36756003)(122000001)(66946007)(64756008)(66446008)(5660300002)(66476007)(91956017)(87266011)(6916009)(6506007)(38070700005)(186003)(316002)(33656002)(8936002)(26005)(71200400001)(6486002)(2906002)(83380400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eXJhVEhEVkNHZ2trejd5RHNiMEl4VnBDZjUweFVWeTZ6SUtYZ3ViMVN2VHBy?=
 =?gb2312?B?WTJOME5qejJtTDYyS1VLK0dHM3JsOWxublBRcXZyWWtsVHVPdjZrREdKOFJ0?=
 =?gb2312?B?Z213UkVoSVhrUkI1ZHZtQTF0YWxaa0F4UTF3dWRDbzd1T1pVWGxpN3RUNkht?=
 =?gb2312?B?eGZJS1N1U0FUa0NsbTdOK3JnazhTRWhWbnZuV0pGZnhld3kwY3FNbk5nVE1t?=
 =?gb2312?B?UmFROFM2ZTFLTmxUY09haUYrVVhNbWVYZkpMKzJmUDBVWE1qSFFxMGlFcElD?=
 =?gb2312?B?SVBJZlpDd3BOclhNUUJ1U0tpeXlOQ0RhSzJvTnJqaC9USzRjSDAvR0ptNzYy?=
 =?gb2312?B?bVkvNkhZUVRwZ0ZoT2V6RE1lUkhiNzFBUUQ3MFlvdGFWYXJ6a1dYMVRDc09N?=
 =?gb2312?B?N0J3RmJpZ0NlWGRMQ2ZGeTRqRVNKSWlXbVRON1U2SG1TYWl3Wlkyc01ONkhE?=
 =?gb2312?B?WkxsNXVWSDk2eVpNbkVXMmNHclNiUjU5bzlsUDdpWmpiRmpSRnp3YnFuR2pI?=
 =?gb2312?B?WE1WOHE5b3YzR2gyYzJ5T2hNQ0d0MUJoR3BSdWhDNnY2MXRkbVJua2ZQcEpQ?=
 =?gb2312?B?bXlVQnZ5Tks5bThsTi9NcjNJSGkxSWZrZFNiZmpScTZyamRtdkNiZEZrbmxv?=
 =?gb2312?B?Q2ZxQWh5QzBVR0lrVEVZZHRidXN4cElOQitFN3pFTjBKbTFHb2FxRW9QblpC?=
 =?gb2312?B?ZW14dmhxazNFNi9ucnV6TGxXQzJvcXBkb3E2RWdoTUNZNU9OU1ArT3F0Z09I?=
 =?gb2312?B?bkhxcnBWVlVGQ2lCbldJSjBxTnNLbDFTMHI4ODJwQ2krdXcxWTdscmQ0alA3?=
 =?gb2312?B?dGp3ZkdUUzF3Um9vL0pqd2ZEWGNyK1kxem5SekhodDRpSVBsV3p2ZUNDTXVV?=
 =?gb2312?B?OW9aRDN1eFJzY3lRYnUvdEY0alRBMVVOaTUrK3hQcHNlRGVxY3hXMWRDdnJT?=
 =?gb2312?B?MStlLytkeW9zWWRvWE0ycHVXNThTU2k2eWhubDgzU1dyZ1hVTjRrNHQ0N2tj?=
 =?gb2312?B?dEp1djhxa3d1b0xpN2RBYmlXNU5NcHFZQjlDOWMxQWcyZVJNUVlZbm9aVzM5?=
 =?gb2312?B?L280emdTSHhmU2VlWFRMZGR5UnNkL2V1T1hiYk5TWE9OWm05NjZTTVdlRUNM?=
 =?gb2312?B?MlJMclEyV1lJQXRsUi9qc2lqTFlTMTFDWUZ3TytBTHMwL2NVV2o5YW9Rcjd6?=
 =?gb2312?B?dkdJMWttbkZweXBBdStOT2hhS0VQS3ArUG4ya2xiN0g3YjI2VEtEZVBFYzdO?=
 =?gb2312?B?Y0EvUWJvalA3bk5FSmxOR2JpZWg5L3ZkWUNxVDlpSDBSRzJHcE9oRVVHNkFw?=
 =?gb2312?B?dHAzSTVyQzYvb1pXUk9lUlgzSUZ0L3dvcWJic0c1RlRySGk2NjVFY3p2RVZh?=
 =?gb2312?B?VDB3UWxxZUxmRGJkOVlmUWt4TFM5am01SkJBNjRnNmNoQ1Z6MkRTY2UzNjJ1?=
 =?gb2312?B?c21SVVFsYlpBTHBNc0d5UVdkL1lsSFcwcUl3MUhJQTR4UlV4N2FCdWtKRDl1?=
 =?gb2312?B?aWVWY3BGS2VFaXJYeHRPSUNVczNKVURBdXZqVTkzTUhoNlVaalNicHU4Z0Fs?=
 =?gb2312?B?WTM2NG9NRDRJMXVKcERZRklYcmdJcDN5VEFoK1VDR1dXci9hQk9VaVIwVGdX?=
 =?gb2312?B?ZEVLM1h4b01JNHVPN2dIU1pVMmRuWnc2YmVBM2owQWdhVWpUK0ljWldDbTl3?=
 =?gb2312?B?Z0tlNVVvL2U1RjhZR0ZaU2Z1b0JzYU9mSzh4NmpUN1JqTmNTN1VhNDlZbGpn?=
 =?gb2312?B?MEU3eGgybHI4amZiV3IweFVqenNJcjg1czZFWDJtQnNXRUUxVDBkN2dKa3Ji?=
 =?gb2312?B?S2hqSGpOZFc4andqbjVUQVB6SDJqU2srSjhaL2pLdDhaeHpCSkVHV1VrSGx1?=
 =?gb2312?B?SWZSdkNxKzJkZ29CVXZWQ0Q0OXRyMHY5emQwbVlidUZQdTR2LzlheGFiYzdN?=
 =?gb2312?B?OGFOVllrSXZCcFhaaGdCT1dGK0cxOVU4b09VYzk5YkRIVTRjZXpuSUx2SmZJ?=
 =?gb2312?B?Tlh1S01Majd0dnBXRkk3SS92Q2Q5L3ZCdDFqOWdnSGJpZlhtVTUwSjl1K053?=
 =?gb2312?B?QjEvRHlXRVIxTHdQRE1QK2ZhV3kzd09JYU9Zd2JaR0pBL2tzQ0lsRzhJQkQr?=
 =?gb2312?B?UU1EeDNBRFhaNXNXeGZTZS9EYXVHaDFnOFJxTlV4cU05RFpKRnIzZlhyN0h6?=
 =?gb2312?Q?zQ7xDGR/qp9YUkLaiTeEAPk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <692DBA06B1841643811E949456C1DB02@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ee1a0-eab0-442d-caf5-08d9d0b77ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 01:54:30.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp+wV8yUrsuf6jXv4o+RXcOLQauzj/sXPAxbszFBK9mqwirqKSX5/ncefTgSrM4skyj/LZSKbO9HrEl+hLfUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6374
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzYgODowMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBXZWQsIEphbiAw
NSwgMjAyMiBhdCAwMTowMDo0MkFNICswMDAwLCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToN
Cj4NCj4+IDEpIEluIGtlcm5lbCwgY3VycmVudCBTb2Z0Um9DRSBjb3BpZXMgdGhlIGNvbnRlbnQg
b2Ygc3RydWN0IHJkbWEgdG8gUkVUSA0KPj4gYW5kIGNvcGllcyB0aGUgY29udGVudCBvZiBzdHJ1
Y3QgYXRvbWljIHRvIEF0b21pY0VUSC4NCj4+IDIpIElCVEEgZGVmaW5lcyB0aGF0IFJETUEgQXRv
bWljIFdyaXRlIHVzZXMgUkVUSCArIHBheWxvYWQuDQo+PiBBY2NvcmRpbmcgdG8gdGhlc2UgdHdv
IHJlYXNvbnMsIEkgcGVyZmVyIHRvIHR3ZWFrIHRoZSBleGlzdGluZyBzdHJ1Y3QgcmRtYS4NCj4g
Tm8gdGhpcyBpcyBiYXNpY2FsbHkgbWVhbmluZ2xlc3MNCj4NCj4gVGhlIHdyIHN0cnVjdCBpcyBk
ZXNpZ25lZCBhcyBhICd0YWdnZWQgdW5pb24nIHdoZXJlIHRoZSBvcCBzcGVjaWZpZWQNCj4gd2hp
Y2ggdW5pb24gaXMgaW4gZWZmZWN0Lg0KPg0KPiBJdCB0dXJucyBvdXQgdGhhdCB0aGUgb3AgZ2Vu
ZXJhbGx5IHNwZWNpZmllcyB0aGUgbmV0d29yayBoZWFkZXJzIGFzDQo+IHdlbGwsIGJ1dCB0aGF0
IGlzIGp1c3QgYSBzaWRlIGVmZmVjdC4NCj4NCj4+Pj4gSG93IGFib3V0IGFkZGluZyBhIG1lbWJl
ciBpbiBzdHJ1Y3QgcmRtYT8gZm9yIGV4YW1wbGU6DQo+Pj4+IHN0cnVjdCB7DQo+Pj4+ICAgICAg
ICB1aW50NjRfdCAgICByZW1vdGVfYWRkcjsNCj4+Pj4gICAgICAgIHVpbnQzMl90ICAgIHJrZXk7
DQo+Pj4+ICAgICAgICB1aW50NjRfdCAgICB3cl92YWx1ZToNCj4+Pj4gfSByZG1hOw0KPj4+IFll
cywgdGhhdCdzIHdoYXQgVG9tYXN6IGFuZCBJIHdlcmUgc3VnZ2VzdGluZyAtIGEgbmV3IHRlbXBs
YXRlIGZvciB0aGUNCj4+PiBBVE9NSUNfV1JJVEUgcmVxdWVzdCBwYXlsb2FkLiBUaGUgdGhyZWUg
ZmllbGRzIGFyZSB0byBiZSBzdXBwbGllZCBieQ0KPj4+IHRoZSB2ZXJiIGNvbnN1bWVyIHdoZW4g
cG9zdGluZyB0aGUgd29yayByZXF1ZXN0Lg0KPj4gT0ssIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNo
IGluIHRoaXMgd2F5Lg0KPiBXZSBhcmUgbm90IGV4dGVuZGluZyB0aGUgaWJfc2VuZF93ciBhbnlt
b3JlIGFueWhvdy4NCj4NCj4gWW91IHNob3VsZCBpbXBsZW1lbnQgbmV3IG9wcyBpbnNpZGUgc3Ry
dWN0IGlidl9xcF9leCBhcyBmdW5jdGlvbg0KPiBjYWxscy4NCg0KSGkgSmFzb24sDQoNCkZvciBT
b2Z0Um9DRSwgZG8geW91IG1lYW4gdGhhdCBJIG9ubHkgbmVlZCB0byBleHRlbmQgc3RydWN0IHJ4
ZV9zZW5kX3dyIA0KYW5kIGFkZCAgaWJ2X3dyX3JkbWFfYXRvbWljX3dyaXRlKCkgPw0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
c3RydWN0IHJ4ZV9zZW5kX3dyIHsNCiAgICAgLi4uDQogICAgICAgICBzdHJ1Y3Qgew0KICAgICAg
ICAgICAgIF9fYWxpZ25lZF91NjQgcmVtb3RlX2FkZHI7DQorICAgICAgICAgICBfX2FsaWduZWRf
dTY0IGF0b21pY193cjsNCiAgICAgICAgICAgICBfX3UzMiAgIHJrZXk7DQogICAgICAgICAgICAg
X191MzIgICByZXNlcnZlZDsNCiAgICAgICAgIH0gcmRtYTsNCiAgICAgLi4uDQp9DQoNCnN0YXRp
YyBpbmxpbmUgdm9pZCBpYnZfd3JfcmRtYV9hdG9taWNfd3JpdGUoc3RydWN0IGlidl9xcF9leCAq
cXAsIA0KdWludDMyX3QgcmtleSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgcmVtb3RlX2FkZHIpDQp7DQogICAgICAgICBxcC0+d3JfcmRtYV9hdG9taWNf
d3JpdGUocXAsIHJrZXksIHJlbW90ZV9hZGRyKTsNCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkJlc2lkZXMsIGNvdWxkIHlv
dSB0ZWxsIG1lIHdoeSB3ZSBjYW5ub3QgZXh0ZW5kIHN0cnVjdCBpYnZfc2VuZF93ciBmb3IgDQpp
YnZfcG9zdF9zZW5kKCk/DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBKYXNvbg0K
