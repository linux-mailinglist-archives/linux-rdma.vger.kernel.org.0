Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE7399F0E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 12:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFCKif (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 06:38:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCKif (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 06:38:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153AUIwa059518;
        Thu, 3 Jun 2021 10:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nxe/yny+B8pR5Rz2qgj0bh9d+UsLewDjYbIDG5edgiE=;
 b=ExRecRVvH5n0IyHts1AYHcLECxCRkh8J5aDXk7bpnvpy5YV26NGid8hxzBG4IbFi+dJN
 1fowwoU0E73OZIi9+4rcJfWe906xljkgtuNPo1Beh2g69hOPc5+GwkWnYbPwkMd4mw6j
 cIR/oyu37U8TnIDCFiCUNXtTzGZATcUjCdqaaTEw1V4AjXw6KjQjzumSCq85unM8BwFm
 dQJNpQAMfKiHZbSPPzQZEk88xVRBL9LNWWE2IXROKDbFUDx5r+M0FYhpWRWapYYF8SmO
 T+nmsXVsa7hrc7lGqX4PWWJLQquUwepLmx5tkKoPqVjegxf7WERLLKXuEmD4bmmXoB3p Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38ud1sjyjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 10:36:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153AV0ZL138360;
        Thu, 3 Jun 2021 10:36:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3020.oracle.com with ESMTP id 38x1bds04c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 10:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF+hmhmyONYvfUVCuFAwld3ZQ2THhO4sgItQ5DUUGb/x8BnSwn1jOqOsrIX76c2Occes0ExPF1OyPfm/LN8o35Yl0hI2o7x+6FABsBHNoFuqGroQcvzdVaX76b/ksMOkl5UqtQckLx4RepmGiFY5RUNnXr9y6ZSuazsUSvtcXWg3n67x3WU/pf6h6rZKNjACBBgLoKIrkqRbetixRdz3Z8MHssC2nCVi7FdCr0C2rXxKwQU53qW254nP9+oIIYwyC+lPaKjpmLIy637bB66BKXyOnl6CSHh3jtQNIJxbGlouyf3NytRTF43eBeOoyGT9LR9EvromccTCHNyNFHVtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxe/yny+B8pR5Rz2qgj0bh9d+UsLewDjYbIDG5edgiE=;
 b=a/KY68reVdvk82n5QQ1Fi2k2Lmfu9kHvW+zpRB4Vj5Smo2oxSzYJdYr7/AbDDrtJmCqWvJMKDR2pvrInhJjhfqrUz3lYahIG+VDxVO0WF159tkDGGBCSrAW/c9JZzbX+ngZJezf5fcpwc3WXs+ZUWYokpr/TJ26didK7oTbgtL7eNd4zCy81zipjWXO/FI/iRv8IoRME8+In3b2JCL8YtHKttVesWZXH9s0tR5v3ZW6ZNPQdZYO1bfyJ0PM4K+i0g97QxlvKTcb3VtUYf4EHBcquSOHuYs6LLLDy/UqR7DcUxLL5X7/DMC2J1EAFxZjyHEUh2LplzFFvTswO6Epxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxe/yny+B8pR5Rz2qgj0bh9d+UsLewDjYbIDG5edgiE=;
 b=yLKUHgU/CgN6UNy8ssjmf4eZBgKshYCedquIDNVv4WoW9SX2X9a2RekL73Dr/PmG71qBh10pbfblsB9VDjIJ6Ry1oa/WHp7OopywZayfk/F16MXKjCqgh/ux4+7+aSvc0j5JqGwieFHjvUDmkREMzXWs23+yhmgww4ctcAmCP8A=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1800.namprd10.prod.outlook.com (2603:10b6:903:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 10:36:44 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 10:36:44 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Topic: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Index: AQHXWETJKd1twDrD1UCPHUswQ9RvnasB/04AgAAGEwCAAA0uAIAABZeA
Date:   Thu, 3 Jun 2021 10:36:44 +0000
Message-ID: <7312F593-FF71-4EEB-9D4A-6F32A4AC7AE9@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com> <YLib5BhTX6tEMTfe@unreal>
 <D188B984-4B47-4992-80E6-6927ADC3DA26@oracle.com> <YLisCgBLu9pD1qSw@unreal>
In-Reply-To: <YLisCgBLu9pD1qSw@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad12a14c-27c6-45cd-4ade-08d9267b7b5d
x-ms-traffictypediagnostic: CY4PR10MB1800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB18006990C073C9118461D7F4FD3C9@CY4PR10MB1800.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2cTY6pDFP3T8YQPj8owaBQIjG7DfEDHMcJZWq/Y1uJ6yJ48hLVxqNUmEmhCVDZGpR79Kd0HuvrO4EMtFCGYE8pimF/BX1Id5QYjNO/WSL9gtVXroh22zxnXAXsVrmRZRWY4OJ+ADcxe0IQKw1sNcgGxuiNUdAsIdGUU3tBhAokAsF4DRfQF+7TH55UverCH5MMYEGSlObA6/3tGZQh0VaiTSLvTe7+vm7fZmSn8eKkRpZT/jMOJpaw3Bp6qFHEgK2YNnw6JOD1P/fTEOj0r9r/4NXAHELQTjjivTWDPyKu40x8UkDYkAyr3xk9pt8W86KfxaKQ5CdMMzz6GAQ/kOlUi0eLTwRUkv0ClrTfXjgXdho5/uxkNCMGJwVGnK855NJo6J+hG92djJdwatfhmHVjShmamtUXr6UW0QtDM3RaJ5cJ7m4Xt53IBTllJL0OKp9qwjQ9d7cgQXP97f/KbvWQ+WNvyDCAloFbkBpgQjBVd3BmRuzjiz6Gpre+GZqLGEkCtyhRgu+s8zs1LHn91wVTbhc5tK+eMfU3ezF90ZOlTuHWB4nVCoecEBczzXJHl6Qdi7qy4t4nXpl55Lq5Ln0YkaOZJyoov9CxzbFexcRk/CZDGEZIsGfTowUrTZVfj32vXbqhZskkd5lq093AHp29iHO6pMFEgj+ShDaf+PNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(66946007)(8676002)(66446008)(64756008)(66556008)(66476007)(6916009)(2616005)(6486002)(6506007)(53546011)(91956017)(71200400001)(54906003)(86362001)(66574015)(5660300002)(76116006)(36756003)(4326008)(122000001)(33656002)(38100700002)(186003)(44832011)(478600001)(83380400001)(2906002)(316002)(26005)(8936002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2JPVlk2V3prT2k3S0QxS3p2K2x5cnYxMmVRUXBtR2ZXSnRPSTVwaXIwSDRo?=
 =?utf-8?B?K2V6c1RLMk5FcU4yTFl3Y1ZhOHAxWS9QU0FMLzNMM2xKYU5NZ1dEVStxN04r?=
 =?utf-8?B?M1JDZ0RhZG5YRWQwNjNDUWQyOXpFUWtmT1NwTkJoUnNxQnNpOWVmbFlOYTB0?=
 =?utf-8?B?ait6cnFpZkUzNHVhbGtudFVtZktKM05rS2szU3B4aHNnOHVvV3hsa2dqWWxH?=
 =?utf-8?B?MFhsL1dhL1BGZGMxdWV0LzlhTkZwbmxDQklCS0s0NDJ5Yit0ZGEyVTA4MEFV?=
 =?utf-8?B?MitSZmNDTUpwZkZPV3ZvTlVNVXNmM1NoN2I2SUxKMGFhVjF1QnVRdXdyU1ND?=
 =?utf-8?B?MnNJNFpCZlFnZ1hvOFFacERSNFBhNzc3b1lWWVJxRHlpK2xXNVF2TkEyazgv?=
 =?utf-8?B?QXBVeDZNWVNSdjZORXp3WDJ6SjlVMVNXUk5tZG9sOHphczlaeWM3ZGh5d0Jl?=
 =?utf-8?B?a2VPQ0piRFNQaUN0WVhZR1RlRWF3bTF4WnZiRjdKQmJwSG52a2hiWVVFdFd3?=
 =?utf-8?B?TS8zblRBcnhWdVZqN0ZSMlY4UjhRbC91c2UrUE9MR2NWdGxxRElQR1RwQXBl?=
 =?utf-8?B?bmdJT0IyQVAvakhFcVUzNkI4TlZnZ1N0NW05SXJnaWp5VlNFaWp6WFhGUVJn?=
 =?utf-8?B?eE1qTURzWVd0d1hkUFJ5YWwzK2tWRWZTbld4VzVoYm5pM0VxSEdHSnpncGdz?=
 =?utf-8?B?SlAzbTFHVFIycWl5bWJBZkQ4SUVwQTA4TWJsUXcraGtBbXU4a0VnV1dPbHBJ?=
 =?utf-8?B?TElsalVVRUFDSzJIb04rZTNIOW1kTXdNU3A5NmkvTUZveTZHUTEyVVhkditi?=
 =?utf-8?B?em9wR3JUKzZKbkdLdnRSUDVnZkNXZTJUK1pnTkk1bTJDZ0R4cWlsYVVVS2da?=
 =?utf-8?B?c2VJQWxVaTFYRy9UZWUxQkhHaUlnTVBVYUhRaTlaTzkvd3d2dXV5algwNEJu?=
 =?utf-8?B?bWV3eDRRbWVBM1hjWUNBQURMN01xSnVxK05YNVRhYytCdGp5ajlKNG9BSjdS?=
 =?utf-8?B?NUpLZ2lqQkQwdVQwazErZDVacnpsVTNlRWgvU21hOCtXdWN5R1QwM3ZMTFNp?=
 =?utf-8?B?dklyWEFHMU93NEpEZFQ4QWtXMXRzMldORG5tN0xFdDJJTTRzVWlPZE9SL05G?=
 =?utf-8?B?YVFVWWJsZlg0MGZzVm5hcGc1bklJZDM0MFpIcDJRSW1WRitzeDRvSVJ1MXJr?=
 =?utf-8?B?Q0lOTUwwVHB0UmFVWXIyU2lJUTRETnBJaWtiNlhrN0ZCMlhuSldYNGd5a2tQ?=
 =?utf-8?B?dHJqUENBenpTZnJzZXc5YUJvRFdjb3ArQnpjT2NOQUh0UWlxRGJzU3NuNzNV?=
 =?utf-8?B?ZXJPd2YrTERYWWo4Z2NJWnJ3VVJtaDBGMWhGVTRqR3BSSmpMWEFKN21jc2Fu?=
 =?utf-8?B?NGRpS25KVEhWcEhNK3p2a0wwNXFlK0pDeWpqM1M2TlFKNFRTblJ6YjdEdnNG?=
 =?utf-8?B?VU0xck1ZdU4wKzhDcDdUaHUyN1k4aGxVSnpxTFBFYW1DWHM4Snl3MzhYcFM2?=
 =?utf-8?B?bDlSeTdianZZUDlBVVdLRGJlNHhtZmtFWXdSaFZzZ1NTQmNuZHN0Q2VBd0Ir?=
 =?utf-8?B?UWZoN3Q4aEdiZm9yU3JidUllbktEbXc5VUNlRk9Hc1RUVDRUTmUzSXF1d2Vn?=
 =?utf-8?B?eTg5ZDNwNHVmZEFYSS84MURkVmZWc1JlaWtHNWo4ekFvWUpBVkdvVDdvMGZ3?=
 =?utf-8?B?Ly9ZWnR4bU9SbFJ5YWk3em55YkxSUm4yblhCSjkvWWVnMzBFNEtwNE9JRWFx?=
 =?utf-8?B?di92YmVWSEs5Tmt2VzQySk1yVWZXcHVDME5XYUY5dWhkSkVaeXIwSUVsY0RM?=
 =?utf-8?B?akdPYjE0T3hMWE50SjZ5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <227743205B49304DA982B6940A6B1201@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad12a14c-27c6-45cd-4ade-08d9267b7b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 10:36:44.0690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBHFoZXIRRRB7L4DOLNFO0r+BG9gIGA1Wtr5XOq01UN0qfyZ9yx9Ot5XYWRZOdqDDVRHwrGyHm2NygFRS4Pphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1800
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030071
X-Proofpoint-ORIG-GUID: B3hSLMqsU34YtBoCIjJtuSJyS8NB8MBw
X-Proofpoint-GUID: B3hSLMqsU34YtBoCIjJtuSJyS8NB8MBw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMyBKdW4gMjAyMSwgYXQgMTI6MTYsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDAzLCAyMDIxIGF0IDA5OjI5OjMyQU0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMyBKdW4gMjAyMSwg
YXQgMTE6MDcsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBUaHUsIEp1biAwMywgMjAyMSBhdCAxMjoyMDoyNFBNICswNTMwLCBBbmFuZCBLaG9q
ZSB3cm90ZToNCj4+Pj4gaWJfcXVlcnlfcG9ydCgpIGNhbGxzIGRldmljZS0+b3BzLnF1ZXJ5X3Bv
cnQoKSB0byBnZXQgdGhlIHBvcnQNCj4+Pj4gYXR0cmlidXRlcy4gVGhlIG1ldGhvZCBvZiBxdWVy
eWluZyBpcyBkZXZpY2UgZHJpdmVyIHNwZWNpZmljLg0KPj4+PiBUaGUgc2FtZSBmdW5jdGlvbiBj
YWxscyBkZXZpY2UtPm9wcy5xdWVyeV9naWQoKSB0byBnZXQgdGhlIEdJRCBhbmQNCj4+Pj4gZXh0
cmFjdCB0aGUgc3VibmV0X3ByZWZpeCAoZ2lkX3ByZWZpeCkuDQo+Pj4+IA0KPj4+PiBUaGUgR0lE
IGFuZCBzdWJuZXRfcHJlZml4IGFyZSBzdG9yZWQgaW4gYSBjYWNoZS4gQnV0IHRoZXkgZG8gbm90
IGdldA0KPj4+PiByZWFkIGZyb20gdGhlIGNhY2hlIGlmIHRoZSBkZXZpY2UgaXMgYW4gSW5maW5p
YmFuZCBkZXZpY2UuIFRoZQ0KPj4+PiBmb2xsb3dpbmcgY2hhbmdlIHRha2VzIGFkdmFudGFnZSBv
ZiB0aGUgY2FjaGVkIHN1Ym5ldF9wcmVmaXguDQo+Pj4+IFRlc3Rpbmcgd2l0aCBSREJNUyBoYXMg
c2hvd24gYSBzaWduaWZpY2FudCBpbXByb3ZlbWVudCBpbiBwZXJmb3JtYW5jZQ0KPj4+PiB3aXRo
IHRoaXMgY2hhbmdlLg0KPj4+PiANCj4+Pj4gVGhlIGZ1bmN0aW9uIGliX2NhY2hlX2lzX2luaXRp
YWxpc2VkKCkgaXMgaW50cm9kdWNlZCBiZWNhdXNlDQo+Pj4+IGliX3F1ZXJ5X3BvcnQoKSBnZXRz
IGNhbGxlZCBlYXJseSBpbiB0aGUgc3RhZ2Ugd2hlbiB0aGUgY2FjaGUgaXMgbm90DQo+Pj4+IGJ1
aWx0IHdoaWxlIHJlYWRpbmcgcG9ydCBpbW11dGFibGUgcHJvcGVydHkuDQo+Pj4+IA0KPj4+PiBJ
biB0aGF0IGNhc2UsIHRoZSBkZWZhdWx0IEdJRCBzdGlsbCBnZXRzIHJlYWQgZnJvbSBIQ0EgZm9y
IElCIGxpbmstDQo+Pj4+IGxheWVyIGRldmljZXMuDQo+Pj4+IA0KPj4+PiBGaXhlczogZmFkNjFh
ZCAoIklCL2NvcmU6IEFkZCBzdWJuZXQgcHJlZml4IHRvIHBvcnQgaW5mbyIpDQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEFuYW5kIEtob2plIDxhbmFuZC5hLmtob2plQG9yYWNsZS5jb20+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jICB8IDcgKysrKysrLQ0K
Pj4+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYyB8IDkgKysrKysrKysrDQo+Pj4+
IGluY2x1ZGUvcmRtYS9pYl9jYWNoZS5oICAgICAgICAgIHwgNiArKysrKysNCj4+Pj4gaW5jbHVk
ZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgfCA2ICsrKysrKw0KPj4+PiA0IGZpbGVzIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBDYW4geW91IHBs
ZWFzZSBoZWxwIG1lIHRvIHVuZGVyc3RhbmQgaG93IGNhY2hlIGlzIHVwZGF0ZWQ/DQo+Pj4gDQo+
Pj4gVGhlcmUgYXJlIGEgbG90IG9mIGNhbGxzIHRvIGliX3F1ZXJ5X3BvcnQoKSBhbmQgSSB3b25k
ZXIgaG93IGNhbGxlcnMgY2FuDQo+Pj4gZ2V0IG5ldyBHSUQgYWZ0ZXIgaXQgd2FzIGNoYW5nZWQg
aW4gYWxyZWFkeSBpbml0aWFsaXplZCBjYWNoZS4NCj4+IA0KPj4gVGhlIGNhY2hlIGlzIGluaXRp
YWxpemVkIHdoZW4gaXQgaXMgY3JlYXRlZCwganVzdCBiZWZvcmUgdGhlIGJpdCBJQl9QT1JUX0NB
Q0hFX0lOSVRJQUxJWkVEIGlzIHNldCBpbiBmbGFncy4NCj4+IA0KPj4gQWZ0ZXIgY29tbWl0IGQ1
OGMyM2M5MjU0OCAoIklCL2NvcmU6IE9ubHkgdXBkYXRlIFBLRVkgYW5kIEdJRCBjYWNoZXMgb24g
cmVzcGVjdGl2ZSBldmVudHMiKSwgdGhlIEdJRCBwb3J0aW9uIG9mIHRoZSBjYWNoZSBpcyB1cGRh
dGVkIHdoZW4gYSBJQl9FVkVOVF9HSURfQ0hBTkdFIGV2ZW50IGlzIHJlY2VpdmVkLg0KPj4gDQo+
PiBCZWZvcmUgc2FpZCBjb21taXQsIGl0IHdhcyB1cGRhdGVkIG9uIGFueSBldmVudC4NCj4gDQo+
IFRoaXMgcGFydCBpcyBjbGVhciB0byBtZSwgdGhlIG1pc3NpbmcgcGllY2UgaXMgdG8gdW5kZXJz
dGFuZCB3aGF0IHdpbGwNCj4gaGFwcGVuIGlmIGNhY2hlIGFuZCBHSUQgYXJlIG5vdCBpbiBzeW5j
IGJlY2F1c2Ugb2YgYXN5bmNocm9ub3VzIG5hdHVyZSBvZg0KPiBldmVudHMuDQoNClRoZSBjYWxs
cyB0byBpYl9xdWVyeV9wb3J0KCkgYXJlIGFzeW5jaHJvbm91cyB3aXRoIEdJRCBjaGFuZ2UuIENv
bnNpZGVyIHRoZSB0aW1lIGxpbmU6DQoNClRpbWUgICAgSENBICAgICBjYWNoZQ0KdDAgICAgICBH
SURhICAgIEdJRGENCnQxDQp0MiAgICAgIEdJRGIgICAgR0lEYQ0KdDMNCnQ0ICAgICAgR0lEYiAg
ICBHSURiDQp0NQ0KDQoNClByaW9yIHRvIHRoaXMgY29tbWl0LCBpZiBpYl9xdWVyeV9wb3J0KCkg
d2FzIGNhbGxlZCBhdCB0MSBvciBhdCB0MywgdHdvIGRpZmZlcmVudCBHSURzIHdvdWxkIGJlIHJl
dHJpZXZlZC4NCg0KV2l0aCB0aGlzIGNvbW1pdCwgaWYgaWJfcXVlcnlfcG9ydCgpIHdhcyBjYWxs
ZWQgYXQgdDMgb3IgdDUsIHR3byBkaWZmZXJlbnQgR0lEcyB3b3VsZCBiZSByZXRyaWV2ZWQuDQoN
ClRoZSBzY2VuYXJpbyBpcyB0aGUgc2FtZSwgb25seSBza2V3ZWQgaW4gdGltZS4NCg0KDQpUaHhz
LCBIw6Vrb24NCg0K
