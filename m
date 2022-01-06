Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3009486334
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiAFKwy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 05:52:54 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:37936 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238102AbiAFKwx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 05:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641466374; x=1673002374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pKF4rpCyY7/THMBCgJmMjCU1sP0IlM38UgiYMYUjqCk=;
  b=SiJlCIIBDptoLVrTIWWoGB5HGiCrOwEFkdm7/jYv+9nxz93fh6NZxPOG
   JauWIZMXJpk7NoBHnnUNHhvbySNRz1L5oKEQ7DNMZ0mPBm+9qUFImQ/Ca
   Mk+44msvAIpP5u+WIuZvSKrluSH4/4nqxjF481AMe9/NevJ5mm/MtF0Um
   N/oaQFce3qWTDNnqLq5bjvidVnLjmw59/K+mf88Hj/eIsGVZIpPjoDHnt
   4/ez3htQJROa6TIg8MhYYLo0UFemMOJld/SpiynfCcQJLvND+tU3jjMYG
   leK1QhBkeMp5Llmd7fIaRi9GiAC8d/1FT6f9KvI0vqEf4LGEi4qL4Fn7U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="48089213"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="48089213"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 19:52:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6Gc1zOVb2JWNHG9AcZkCQsK95GhsY4Ac5zmzpVNbxcE/08C2Xe72gEAgTkeoaliaByaNfvBZO5Kd5TxPPDb6ur26a6OmPwUAAL/louGDUo2rSc+71sHSr0xPAQOdr5lY9UnK1yZSD7YrQXPyzcbOKD8UTlKxDKLX9EmUETPb9wA+3GnSnlPZxqNJuJPmelRYY9LDsHC0FhShO79SMWTITmC8yUmfPiNhqF/VMRBcVmC4RfIg7MVCEIL7Z27P4/a7J6NinjU1YpTIiA7bUqE65+rmD8xYhi6UYtcaBRQCtM9xobYYfYwZ8q3hbXQAxM9AF2b3+0eF7JGW1EHKx+k3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKF4rpCyY7/THMBCgJmMjCU1sP0IlM38UgiYMYUjqCk=;
 b=jfDnaco6MNd2tBnbqZjzJel208enDf1XC0ZWuy1TNEP05AsdySNpEPeA8NwcOKF1R1Gc++jPOObPK7Io2jqnpBlflDkj3joxYogXXCWNYh/b3B2AJ/ro2EJaD0okTZYGw5egrrQMfJvj8ZWh8t7/rDCgrWPp/sIxeW7dfypJSz/wj8Z/jmF/TCr9NVSClx+dB8m6hNnio0Ed/XHkj+ugLKTfXtQTYmlHnQSLB7+XhCJCGwzYdG/2oXfhBxIEwN3BYBPkblSY/JNImM3jEMxFrEXkYEpZJEdO2UYQsbhzhEWxSvem5xTTgZE1cv+s2OmDK1bmGUTUrqok1B93jDkL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKF4rpCyY7/THMBCgJmMjCU1sP0IlM38UgiYMYUjqCk=;
 b=lAoRoOiJI0d6yadL3H84xCuzoAb6tUAnY2rSaci6aj4XXcpvXmqGrf8KvvtU8fBCQNELEYF4yJcVgYYFlJyOs1pAm1HoXlkwL4P4T1YFdyMA4XFxOxZlpMBq34XQDr/aj2FIX+1E7t7dJRYRoKYuyiTTpBhhU3qTran0Mj45iJA=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB2455.jpnprd01.prod.outlook.com (2603:1096:604:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 10:52:47 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 10:52:47 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbsojLLXTBWKk+I52jDqCmDKaxLkGOAgAmTrACAALgQgA==
Date:   Thu, 6 Jan 2022 10:52:47 +0000
Message-ID: <61D6C9F9.10808@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com>
In-Reply-To: <20220105235354.GV2328285@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 709be3fb-26c4-4638-aca1-08d9d102ad31
x-ms-traffictypediagnostic: OSBPR01MB2455:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2455D10B618C9C281D398493834C9@OSBPR01MB2455.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2diH2RVSZTuygthfxbpcAbtzXTl0+P5ksHvEZQNgdJ9A6JJOj7PJA2lPrkWJ/b1gSp4iwOkovFVL4JLR1sk62XguAMsFAIlidqAFpTTy8lUJrGbK0fpk1Q4C4ogQUAP7DZpSqEpPuZGwJQyDU66AUw58u0hkzQraesT6y8iWHQpmCaVT0u9MP5P3/lIbFS7D0h2OcIUoK+XWzriibq9oYrwDdDIhJfz1vmUHeHSlUxYED2uwv+2M66BVvBaKItkG9kqzzdcYho7UWK9l6IyK8PxHJnAzMPgxFZOiK02SIn+P9q3JGA5w6ROPyPIbOrWO2sIkDzX/auuWpRZt7Zxauhtnz/8q7CRaQRQHmnb+WOhKcoQRwB1k4Mgt15qmPOv0n4A86jbk1DPzO/JXHdlpfT49UX2QYS2D5jzK6vo+ZqjBEd/jsn2CqY1qZ9XBpPL5MxwGm0cBuvOfwVPLFHSeC3583/y3H1o+ZJpq5nXN8+eUG0CNMZ7e1smz4WIvltNn/kK7YMkIFguJJiG8N/IZWUMmdQR9tguqXJrUwxYRTx3vKlzD5y4LfPT503jmUKH8jQ2L3OC8qoHDPrcb9k/NC0ChJZWxm/r2eq8h4SNKd6JMDw5QldCkA4DLarGLHZ1x/1/oj+07ffEpKWkrYvcnzi0KZj25rlVX1GsY51PHJ/vQytAofjaUPQr2Yb+OMH0xwaqKwFEoscNsf5nhFz5ffQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(8676002)(8936002)(38100700002)(186003)(66446008)(2906002)(122000001)(86362001)(2616005)(110136005)(26005)(4744005)(82960400001)(508600001)(316002)(71200400001)(66476007)(36756003)(66556008)(91956017)(53546011)(6486002)(64756008)(76116006)(66946007)(85182001)(4326008)(38070700005)(6512007)(6506007)(54906003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QW1kQUc0a2R4RmdsZFpMb3B3NFFPakI1cklWMk1wOGY2N2tMU1AvczR0NVpL?=
 =?gb2312?B?QWF3MC9jamU2d0liVWt2L3RaWFgrbTFaVHAxVnZpcFJuTHJjcnZtMWZqNjNR?=
 =?gb2312?B?TlJWSDFVY1hSQkg5MnBQVWJnQ2IrUUg0ditWa3IxZFhZcXowRGlRZmVrV01L?=
 =?gb2312?B?dmh6TmYyaSt2YlhUMC9XbUdhMFRHUGJjUkEvdzhYQTA5K3U3dENSa2FCY1pI?=
 =?gb2312?B?Um0zQVpITkt5TFIzQmZSNGV6c2dxeUVUR3FsYUd6akpUdDZsZGdiWTJXQ2dG?=
 =?gb2312?B?S2F4bGhyc2ZYZEF1TlNPeGtIaTZFclZSVWhpYzVWNThRUFlRQkpnKzFIeFA2?=
 =?gb2312?B?b0h6bVhYcUNIZm9BdTFVSUlxdW5RU3RJWXJ5OUJONUJLOXJQdloyQTFIWG9q?=
 =?gb2312?B?VVdDd21KczlqZlVOdUFBZ0ZDZlJrQ0Zjb2xsQVZ3K25oTUs0ck1RKzhOenRw?=
 =?gb2312?B?VHZkN2VhWjRKUG5hVWh4ZXNXeTdzMFY2dUowelNLUURkMENraFg0TGVPY21s?=
 =?gb2312?B?amtkY0ExQjNndjh5c3dYWjlnWWVqZEt1SElyRi9GL0xzUTdCMkt1ZXgwVmJV?=
 =?gb2312?B?aGQzUXFScTZ1UlNqK05JdlFvNFgwVHpVQ2xKU21UbjFEWE1mSTh4MU1NOGs0?=
 =?gb2312?B?R1RvNVJqdFhuSFIxOXNhbEd6a1F1bTdDeVd4ekkwYy9ZbFVXRFBhaUx2ckNz?=
 =?gb2312?B?SXlhRk5aWWtZYWZ1TlhXb3dHdjByeTlXZ1pCMXEzTkl2WGZ1Z3F2L0w3ZnBm?=
 =?gb2312?B?aC92Sy9SNlFyZW10SlJuV1dzOWJsTGFzZit1OHlEejBld0tUU2lIQ202V3JH?=
 =?gb2312?B?a1pTM0FvbmV5T2pOaU1Wam11Nk11K3A5OTYyWVFmUVorWldrV2tOUDR3d2M2?=
 =?gb2312?B?N1RwbEtHQXpKKzdSYkx5bnEvNHRvQXBEbEFUTDNCaHhVSWx2cjdYNlVWbFFM?=
 =?gb2312?B?bzdvMWlkblVHVTRpbGR6VmxCNHBvUU1henpsRmkxQXo0TVVLTDFSUU1sZG1U?=
 =?gb2312?B?d09Ic3htajJRTEVXQk5JYi9ZWVVyQjVYYU9UN0lieDRkRDJiZW5TN2FXbVZH?=
 =?gb2312?B?cHQrd2hoVGtuc2JFbXRpckc4c0g5NmlySTR1cHpXMTd4Ky9UbjRCTEFRaU1S?=
 =?gb2312?B?SHRXSHQ4eU5FS0ttejliR0hwQzZUbGpiT0llZjRCYzBjdmJheGhYcURmVXpQ?=
 =?gb2312?B?dUJjTFBINklmQ0E1dVBJZVJPWjFhVUlVRm85L1o5MWppNVJ4WWlZNDVnMjhP?=
 =?gb2312?B?b0g3eWQwMG8wUjRsMitHT3NTeVoxK2Y4NTZxR05uUlhJUFNUNmpKelZvbDFB?=
 =?gb2312?B?Z2lIbXVib2FOSVNPYVk4aHZMWDZzbU8wc1pFSVB3SStONmI4eDJ5Vzl0UFFJ?=
 =?gb2312?B?cnhlV1Jtd1FlYzhPRXpIRTdsWC9lY3g0eE5uNlhaN3FnUTE0NEhWdEtBaC91?=
 =?gb2312?B?SmxCbkI2cVVweTFReVNtOFpaR25hQ0ZZM2QvSzlBT29qdURoSEw5ZFdIbTBW?=
 =?gb2312?B?aGMwVUU0a1Q3RkxUQkt5NFEzVUxpMDNobmZuTlorQkdDaHdyWkJBWk10UzVJ?=
 =?gb2312?B?RXJ4dWMyMkJPYllwaDRxdlRDUkRIaEl2N2NvMko1YU54UU95MDFoc05taEZL?=
 =?gb2312?B?clhXdG1OUUI4YzFvN0hDOFRua1FXTjBIVmhKQ1U4WktGdy85TFdWVllzZmFw?=
 =?gb2312?B?WkxMa3IzNmNwb3R4NnVIUGlUdnl6SmcwZkdIdVExeXJPblhkdXRLUWxmUk1T?=
 =?gb2312?B?SjJtOUwvbnkwSTJkS0lCblU3Y20ybW0rZy9abUZ6R0ZVNmxKbVNzNWVId3JE?=
 =?gb2312?B?bUJVYlVla244RFZGeGM1K3VncUY2eXBxZnpXNGxtbDZrZkdhYVBHYjFvMnlI?=
 =?gb2312?B?d0ZXYVU2VkhwekhqaEZ3SkN3ek1MYkZ5dTJ1QlpXMTdFVEFoMVZkS0hIZGx0?=
 =?gb2312?B?TW8xZnlnQllpMVE3NjhhSktRKzRmZk5mOGRlTFBvN21odG1oNFJaaEdkS3A2?=
 =?gb2312?B?b1YrQzJuMTc5aXNsTklITVR1cG5iZG9OaDhKTks4aTF6a2RGeHN6WTl1YkRY?=
 =?gb2312?B?Rk51MHB3MEJPWUtKc3hrMHNlS3l4Y21iQ3lobjJVeHhodVB1cHp6eGo0MHdE?=
 =?gb2312?B?WWpzalVhTkpSTm5TVGxFc1NFL2ZMeDVodnFDeTcvdkUzaEczMk1CUHJsNmFj?=
 =?gb2312?Q?PrV/lK75xwSiYol0stmkPA0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <CF558182EFD30943BBD0D49E5A6A6BA6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709be3fb-26c4-4638-aca1-08d9d102ad31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 10:52:47.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1B89vkJpse+tokemnvx9VFR9Ihzeeq+FkGhRsgyqKsstHXvrYowQKqbpG99FfTJ8COsDd6lrMISCT8QZJaBcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2455
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzYgNzo1MywgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIERlYyAz
MCwgMjAyMSBhdCAwNDozOTowMVBNIC0wNTAwLCBUb20gVGFscGV5IHdyb3RlOg0KPg0KPj4gQmVj
YXVzZSBSWEUgaXMgYSBzb2Z0d2FyZSBwcm92aWRlciwgSSBiZWxpZXZlIHRoZSBtb3N0IG5hdHVy
YWwgYXBwcm9hY2gNCj4+IGhlcmUgaXMgdG8gdXNlIGFuIGF0b21pYzY0X3NldChkc3QsICpzcmMp
Lg0KPiBBIHNtcF9zdG9yZV9yZWxlYXNlKCkgaXMgbW9zdCBsaWtlbHkgc3VmZmljaWVudC4NCkhp
IEphc29uLCBUb20NCg0KSXMgc21wX3N0b3JlX21iKCkgYmV0dGVyIGhlcmU/IEl0IGNhbGxzIFdS
SVRFX09OQ0UgKyBzbWJfbWIvYmFycmllcigpLg0KSSB0aGluayB0aGUgc2VtYW50aWNzIG9mICdh
dG9taWMgd3JpdGUnIGlzIHRvIGRvIGF0b21pYyB3cml0ZSBhbmQgbWFrZSANCnRoZSA4LWJ5dGUg
ZGF0YSByZWFjaCB0aGUgbWVtb3J5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gVGhl
IHNwZWMgd29yZCAnYXRvbWljJyBpcyBwcmV0dHkgY29uZnVzaW5nLiBXaGF0IGl0IGlzIGFza2lu
ZyBmb3IsIGluDQo+IHRoZSBtb2Rlcm4gbWVtb3J5IG1vZGVsIHZlcm5hY3VsYXIsIGlzICd3cml0
ZSBvbmNlJyBmb3IgdGhlIGVudGlyZQ0KPiBwYXlsb2FkIGFuZCAncmVsZWFzZScgdG8gb25seSBi
ZSBvYnNlcnZhYmxlIGFmdGVyIG90aGVyIHN0b3JlcyBtYWRlIGJ5DQo+IHRoZSBzYW1lIFFQLg0K
Pg0KPiAncmVsZWFzZScgc2VtYW50aWNzIHdpbGwgZGVwZW5kIG9uIHRoZSBDUFUgY29tcGxleCBo
YXZpbmcgYSByZWxlYXNlDQo+IGRlcGVuZGVuY3kgY2hhaW4gdGhyb3VnaG91dCBhbGwgQ1BVcyB0
aGF0IGNvbXBsZXRlZCBhbnkgcHJpb3IgcmVzcG9uc2UNCj4gb24gdGhlIFFQLiBJdCBsb29rcyBs
aWtlIHRoaXMgaXMgYWNoaWV2ZWQgdGhyb3VnaCB0YXNrbGV0IHNjaGVkdWxpbmcuLg0KPg0KPiBK
YXNvbg0K
