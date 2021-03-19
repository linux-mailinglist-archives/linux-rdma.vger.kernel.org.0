Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114A342089
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 16:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCSPHk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 11:07:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52738 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCSPHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 11:07:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEsQSB052528;
        Fri, 19 Mar 2021 15:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/huxpsWo1sbGsM9MFS5RyM4lIPusd0WBwZ0qeTBTFiA=;
 b=yCDKDEuNZEXEI8wFHD2n5dUT7H2HZvgIM7Qmsx91rSJHE+/vW2F7q9n/+Xr5PLGvq5Bf
 s/+xHsX5kc0VaoZzzOeyzqoBfXuR02qdF/02IBCoHSaEwTV3viydR7ORAKdyzl1ardYA
 as0PrQArXIgyI0lTwhjlMfJyATccLZot7jNcKm7rkOuEYxst/tOb+RVH0XNjJNkvYj5q
 eAX1r7Nie20pYLlkRGh41LoVeBD/N//0FAoI5fAMyEwXsL1KasxsMvGyREbmkECaNFCy
 6vSo6+LvAK1q6SdsRjg0JhBzJIWuviW/3BvegCPiuMG4/tj7EL0pZnGMGzwWHbIU9LkV PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 378jwbudba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 15:07:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEuEOo136988;
        Fri, 19 Mar 2021 15:07:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3797b4c95h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 15:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHprg9miBEj5y4Ern+HLmGiyoUYuZFBPPMJfqP7NVPx632PrftkLpJeMyLGfz3UbSD52ZwTqN3Rek3ecWikAGXl3G+f8u138CnFWxGTMyx/5w77n70+SopQEnhTYVNtH4kJ0RMK4YXjfkfvaZeD0hCjUiAmyn4E/FoPRgnxr9Q5Ma+rDBA8Jft8wnSjeUN3iYl1pYdomJhY3XzJJI6eOUrwVzKfAyboeqitOdj9vgQU7RdOa2olzHtqcvQghtrgvoadzgH0FZZVvs+ZOqSIVvCmqkIs03LywZxS/cAGKrUEfQwD9lL2yB5jx7tX6jn8cUbdkFdYHKnR12cDfivbn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/huxpsWo1sbGsM9MFS5RyM4lIPusd0WBwZ0qeTBTFiA=;
 b=YHWwu8hBaELiSNtIOqHVBD7vQ4rNO9vTH01lz5qeZQQ3t1R3FNS/xWV3HEtJJBLKdIOlEY/WbiCFou2/Z9/KzfA5eSjdJbXICooizIqhLmFLr1wHeihugqFzjUGbn8b8krJhS2i5QgUBPd17X9q2PFL2kTU3MlntVCRqkgMuwvgc+1hMESijdPltWJlH0gsh8dfYxHo/25BBerpVeegWPm0OIt28Jpl+QYFOJCYloTa9udL6icfsj1eH2JnnSeke43hYgptGk/QJx45B5E0F94k1xS0KTk7nOvJrp1BcDyeG0T1uiyjLX0kHuFHZGKLBNdPyrmYAdwV/wYK+vHz8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/huxpsWo1sbGsM9MFS5RyM4lIPusd0WBwZ0qeTBTFiA=;
 b=YTLdyTB0YiNUwm8qDIixACqSCbSlh+ltyjDt2gUdPjNRXg33Hh2OnPqzmiIB/X8uvrYmtpr/Gqt+uVAesKVLpEilLt279523CGLFcQpbD/ob/FkEzGPZm+vrEQAUdEhzTMRnym1exmufDvVLUoaXcAJKaYZsSDMPkZwVACljn4M=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2117.namprd10.prod.outlook.com (2603:10b6:910:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 15:07:07 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3955.018; Fri, 19 Mar
 2021 15:07:07 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Topic: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Index: AQHXHCvyugjSuECPqUSo/S5N1vnDPqqLarQA
Date:   Fri, 19 Mar 2021 15:07:07 +0000
Message-ID: <D96DEBF5-042B-4B92-A512-EA6757020960@oracle.com>
References: <566B6781-C268-4B1C-A359-44B2FE14B91A@oracle.com>
In-Reply-To: <566B6781-C268-4B1C-A359-44B2FE14B91A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1b11df-946b-4cfd-d7de-08d8eae8a9d6
x-ms-traffictypediagnostic: CY4PR1001MB2117:
x-microsoft-antispam-prvs: <CY4PR1001MB2117A25C88F267C4537E880FFD689@CY4PR1001MB2117.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl9NeAMjy1hIAwlwPML1gem9QjWyJU3WaD0gvI4ORVNTCcd/i/fcfbZpSIy+OsRP2QVaJPfhRjSN29CLl8xxap1y5CIRP5PwkSFtCO9sTXFzfOdD6YvdDoh5cBDr2cdVhazRb5H2zITnQIg+EpjHWkUwvJNrs+mYQ71Tk5Z/U0PVpoEJGeE6a36RD3gnpjoVKDgNYpJuQimO+N4FX1huW9hlrXzDe8hEXIOcuzDtwRquE1i+nQkt0lPz1FTDpZI3GmKIpeLfDLJVTOmTs7yTU8zHMZJfd1df4BO96prxwmr47q0J8TxEPQNGDU2IA0c2PQrHETi6xZRAd/uNNhAszS0O5Lobueg/11vezoS8LKmWuhR5DHk8tQLjQ8dpFQLYkbGOXq/hCJFkNCTkcitWe2VckEZtUoan0VYMUnzxuB06lffHAi1NASXtWG9QNxglFy2/BJKAjaC4ESxmNSiPJO/v9A04HvGh6Y3+ZNnsgj2Rt0WFqorDCcLXkZfJG4SbQiepD/NPgYjTJHEE32c2fiTGO7iA4IDUHxO6GzPEu/O5AQCe3RBWwcjFyANFBKGQswQ8tXqY0OCmNTN2mwFHq6eBOtSZ7Y2nFr3lLt59s+3LZZ3MeuSJBVSGsZR4kU2p6uILgfzkBP32P1T1E4iDG/s4HdVm5PMRruHBwg1wPrVOrzMKPtA5cGwZ2WjIRkpn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(396003)(366004)(376002)(83380400001)(2616005)(36756003)(8676002)(66446008)(44832011)(110136005)(316002)(8936002)(76116006)(66946007)(66476007)(5660300002)(86362001)(71200400001)(66556008)(91956017)(64756008)(186003)(66574015)(6506007)(53546011)(6486002)(38100700001)(6512007)(33656002)(2906002)(26005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RjZGUXd1TnA3UVJpcFRJTUNkSGxMd0hhOXVjRFBEclB5R0ovLzBLOUlrdkFP?=
 =?utf-8?B?L3VLa2JmdU9KcEJOUWhzQS9SbXNGSUxYN0Rjb3RYNEhhalpXejJKOCtzSEx5?=
 =?utf-8?B?bE8ycWlrc3JLZUFXS1NXRGNjU1NkYjBKOUY5Q3d4NHZ5T2ZCMmkrR3lqYzB0?=
 =?utf-8?B?STJjQ2I1OXM4SjNOd2d1K0VmYWZuQTNveE9DeDdjVFdTSU14MWc4am9zeGtP?=
 =?utf-8?B?L0szcVVSN1lZVjNFQ2dqRmJKb2V5TWxlcmhZVzM5TE91UkJLOGw2M2V5L3R2?=
 =?utf-8?B?MTZ2OVhZQ3pZL2dNWmIxcWJKM3F5WUdUdU5FRTRqb0ludmpzTmNYSkkxbi9x?=
 =?utf-8?B?K0M1TXNaaW0vREo4VDQ5TkwrK3lXVjBKZWVNaTdTbXBZV1MyUGl2VXNVWWxW?=
 =?utf-8?B?eWNIelpkY210U1ZQTVd6dzNVQ292ektLeFYyeC9lY0xhTzY3RytLRVJiWk1r?=
 =?utf-8?B?OU5kYmpaNlZ6T21tRFBCZEpPYSszeVlCODdqVnJIcWwvK1lRWnhLN3hjRHRG?=
 =?utf-8?B?Qy9SS3NRbkxJRzBsYmdGUG9OV1FYK2FORms3SVl4NGFTN1g2ZkhVNmZ0Tkd6?=
 =?utf-8?B?VlI0WFZvUitXQlNHL2x4QmhyNE5jeGRhU2VjTjJrOStwbW1MZGFPK211elFp?=
 =?utf-8?B?ZEFNTlZKTjcyejJVWHl2Q25mdnBPUXc2VkZ2U045N25YY3ZWQVljNzM3TnVr?=
 =?utf-8?B?KzJFK3NWM0lmOVQ0M0tDWUdETCtzVWNPRkYwNVF5TUorTzNMd05QRGQydG1Q?=
 =?utf-8?B?VUIwUWtSbDNqNmR2WXdTUEt0SjF4dldJMkd0YUFaSStvK0FXYWVENnlPLytM?=
 =?utf-8?B?MGk3SkJtKzJuSE5qd05PQTQ1Sk52bEVyRmJKVlJuTDVBRHp5RnAwRWhjb2hi?=
 =?utf-8?B?MkhXcVJZaSsyenpkam5aU0dzbG1RamFwa3E0S3c1cWJmTFRGZGlkbTlMV1Bv?=
 =?utf-8?B?M1ZrTVNtMXNUNkJWT0VZTEd6RW9ORnd6VUlsTUdJMllFK2xmZ0F0ZzNqVlMw?=
 =?utf-8?B?SmhlMEVkS2VoSU4xeTJaQ0JFSWRWRHRSOERBc05JZll6OVdQVXVXUFBWOHkr?=
 =?utf-8?B?dTBVS3hJQlZKSEVKbzNSVVBWWDBucERrM2dFek1ObTdxNjQvaUdldEJLbXVS?=
 =?utf-8?B?Z0pvLzFJTXAyTnVXUWNldWlGaWY2UTliSnZDSHVPOWJxdzJ6M2NqcWtnUDF5?=
 =?utf-8?B?STR6dzZhU3oxWVhXRENGdmQyVFZkRU1udHV4ek12T2ZyckI4T2xPMEMwYTY1?=
 =?utf-8?B?ZmJKNlNqRlBvT25EUkdFNnZoRVc2NWJIWTd5bWplWC9xSVhGdFI3SlFtM21S?=
 =?utf-8?B?MzNsTXM4NjBHZHFPWTdIa3g2SlJNYWh0UlJtOWJ5NWZDcGF2SVgwV2EzYmxj?=
 =?utf-8?B?UExMd2RkM0RVdlJkSU03YnVIVGhOaXlvK3Q2d0J6U0RXNkppbHovejlKckRG?=
 =?utf-8?B?cWN3M1RzNXpKMW1mbW0wbGdvSFEwL0gzQ09HK1pWc2FVUVRKRXBVaGZOb08v?=
 =?utf-8?B?SjFtbXlLWlRoMVpPVWJHNXBGdm1XTDFpRnV5a2ZJaEhTdG1pQ1ZLRWU4WEpX?=
 =?utf-8?B?SmN3WnlxT3JRYngzSitZRmd2WmpHU0xWR0NYTVF0S3F4Y29IUTJHQ3kxMkM0?=
 =?utf-8?B?ZS9ZOHJITEVuQTNodzQ1NHRRajJsRnE3cGhHTnNoS0pLcnZpTnllZGdtVkNk?=
 =?utf-8?B?aDNEdVAvM1FqSmpWYkQvTmtLK2pOSEhZNkFPZnVhT3RQWkl2RTNPb2ZraExu?=
 =?utf-8?B?L3lFNGlLNU5KT2tScDd1cWd5bHFyeXhJYXdJblBlbXUrUjZ2Q2kvQkVJWkNa?=
 =?utf-8?B?S2dacTZTT3p3aFpaaEM3dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC970CA8370BA0469AB53C819E47B4D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1b11df-946b-4cfd-d7de-08d8eae8a9d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 15:07:07.5087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7oIpIrHiUXy4bx+hg/X0V19zK+6RAiJvQhEUUjfnwSURmORW4CeM0QM9h3SmIMKSUgawvHvKcdZhKvjWDl2BWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2117
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190107
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTggTWFyIDIwMjEsIGF0IDIwOjIxLCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBSb0NF
IHN5c3RlbXMsIGEgQ00gUkVRIG1lc3NhZ2Ugd2lsbCBjb250YWluIChwYXN0ZWQgZnJvbSBXaXJl
c2hhcmspOg0KPiANCj4gUHJpbWFyeSBIb3AgTGltaXQ6IDB4NDANCj4gLi4uLiAwLi4uID0gUHJp
bWFyeSBTdWJuZXQgTG9jYWw6IDB4MA0KPiANCj4gVGhpcyBiZWNhdXNlIGNtYV9yZXNvbHZlX2li
b2Vfcm91dGUoKSBoYXM6DQo+IA0KPiAgICAgICAgaWYgKCgoc3RydWN0IHNvY2thZGRyICopJmlk
X3ByaXYtPmlkLnJvdXRlLmFkZHIuZHN0X2FkZHIpLT5zYV9mYW1pbHkgIT0gQUZfSUIpDQo+ICAg
ICAgICAgICAgICAgIC8qIFRPRE86IGdldCB0aGUgaG9wbGltaXQgZnJvbSB0aGUgaW5ldC9pbmV0
NiBkZXZpY2UgKi8NCj4gICAgICAgICAgICAgICAgcm91dGUtPnBhdGhfcmVjLT5ob3BfbGltaXQg
PSBhZGRyLT5kZXZfYWRkci5ob3BsaW1pdDsNCj4gICAgICAgIGVsc2UNCj4gICAgICAgICAgICAg
ICAgcm91dGUtPnBhdGhfcmVjLT5ob3BfbGltaXQgPSAxOw0KPiANCj4gVGhlIGFkZHItPmRldl9h
ZGRyLmhvcGxpbWl0IGlzIGNvbWluZyBmcm9tIGFkZHI0X3Jlc29sdmUoKSwgd2hpY2ggaGFzOg0K
PiANCj4gCWFkZHItPmhvcGxpbWl0ID0gaXA0X2RzdF9ob3BsaW1pdCgmcnQtPmRzdCk7DQo+IA0K
PiBpcDRfZHN0X2hvcGxpbWl0KCkgcmV0dXJucyB0aGUgdmFsdWUgb2YgdGhlIHN5c2N0bCBuZXQu
aXB2NC5pcF9kZWZhdWx0X3R0bCBpbiB0aGlzIGNhc2UgKDY0KS4NCj4gDQo+IEZvciB0aGUgcHVy
cG9zZSBvZiB0aGlzIGNhc2UsIGNvbnNpZGVyIHRoZSBDTSBSRVEgdG8gaGF2ZSB0aGUgUHJpbWFy
eSBTTCAhPSAwLg0KPiANCj4gV2hlbiB0aGlzIFJFUSBnZXRzIHByb2Nlc3NlZCBieSBjbV9yZXFf
aGFuZGxlcigpLCB0aGUgY21fcHJvY2Vzc19yb3V0ZWRfcmVxKCkgZnVuY3Rpb24gaXMgY2FsbGVk
Lg0KPiANCj4gU2luY2UgdGhlIFByaW1hcnkgU3VibmV0IExvY2FsIHZhbHVlIGlzIHplcm8gaW4g
dGhlIHJlcXVlc3QsIGFuZCBzaW5jZSB0aGlzIGlzIFJvQ0UgKFByaW1hcnkgTG9jYWwgTElEIGlz
IHBlcm1pc3NpdmUpLCB0aGUgZm9sbG93aW5nIHN0YXRlbWVudCB3aWxsIGJlIGV4ZWN1dGVkOg0K
PiANCj4gCUlCQV9TRVQoQ01fUkVRX1BSSU1BUllfU0wsIHJlcV9tc2csIHdjLT5zbCk7DQo+IA0K
PiBBdCBsZWFzdCBvbiB0aGUgc3lzdGVtIEkgcmFuIG9uLCB3aGljaCB3YXMgZXF1aXBwZWQgd2l0
aCBhIE1lbGxhbm94IENYLTUgSENBLCB0aGUgd2MtPnNsIGlzIHplcm8uIEhlbmNlLCB0aGUgcmVx
dWVzdCB0byBzZXR1cCBhIGNvbm5lY3Rpb24gdXNpbmcgYW4gU0wgIT0gemVybywgd2lsbCBub3Qg
YmUgaG9ub3VyZWQsIGFuZCBhIGNvbm5lY3Rpb24gdXNpbmcgU0wgemVybyB3aWxsIGJlIGNyZWF0
ZWQgaW5zdGVhZC4NCj4gDQo+IEFzIGEgc2lkZSBub3RlLCBpbiBjbV9wcm9jZXNzX3JvdXRlZF9y
ZXEoKSwgd2UgaGF2ZToNCj4gDQo+IAlJQkFfU0VUKENNX1JFUV9QUklNQVJZX1JFTU9URV9QT1JU
X0xJRCwgcmVxX21zZywgd2MtPmRsaWRfcGF0aF9iaXRzKTsNCj4gDQo+IHdoaWNoIGlzIHN0cmFu
Z2UsIHNpbmNlIGEgTElEIGlzIDE2IGJpdHMsIHdoZXJlYXMgZGxpZF9wYXRoX2JpdHMgaXMgb25s
eSBlaWdodC4NCj4gDQo+IEkgYW0gdW5jZXJ0YWluIGFib3V0IHRoZSBjb3JyZWN0IGZpeCBoZXJl
LiBBbnkgaW5wdXQgYXBwcmVjaWF0ZWQuDQoNCkkgaW50ZW5kIHRvIHNlbmQgYSBwYXRjaCBkb2lu
ZzoNCg0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL2NvcmUvY20uYw0KQEAgLTIxMzgsNyArMjEzOCw4IEBAIHN0YXRpYyBpbnQgY21f
cmVxX2hhbmRsZXIoc3RydWN0IGNtX3dvcmsgKndvcmspDQogICAgICAgICAgICAgICAgZ290byBk
ZXN0cm95Ow0KICAgICAgICB9DQogDQotICAgICAgIGNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFf
bXNnLCB3b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0KKyAgICAgICBpZiAoY21faWRfcHJpdi0+YXYu
YWhfYXR0ci50eXBlICE9IFJETUFfQUhfQVRUUl9UWVBFX1JPQ0UpDQorICAgICAgICAgICAgICAg
Y21fcHJvY2Vzc19yb3V0ZWRfcmVxKHJlcV9tc2csIHdvcmstPm1hZF9yZWN2X3djLT53Yyk7DQog
DQogICAgICAgIG1lbXNldCgmd29yay0+cGF0aFswXSwgMCwgc2l6ZW9mKHdvcmstPnBhdGhbMF0p
KTsNCiAgICAgICAgaWYgKGNtX3JlcV9oYXNfYWx0X3BhdGgocmVxX21zZykpDQoNCg0KDQppZiBJ
IGRvIG5vdCBnZXQgYSBwdXNoIGJhY2suDQoNCg0KDQpUaHhzLCBIw6Vrb24NCg0K
