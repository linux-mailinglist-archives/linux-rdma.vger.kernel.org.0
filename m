Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1442E354E17
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhDFHmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 03:42:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37458 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbhDFHls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 03:41:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1367dCOC068515;
        Tue, 6 Apr 2021 07:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jnPPkYnLqdWSiJN7DHao0j/qyxw18ZlMz6KTpCPY/Bs=;
 b=mcpbgVVb4mKFZ1IPS74wwioB7Z8RVjP6+Q3siOKLn3G83wXom43zZiKmDD+O0fEfzQxf
 7pG8mVFzdP3vwyOtyb1NcWuVeHPUW8mI0c12gXLysQVZ4iMeqnXB8Z/V061QTawXty2W
 JpHXYDb1E+R4vIBVYiW8/zbUwKYh0C7Q4mGbSP3gdILROGqz49EadgEiAKkUgGRcdHj0
 KJU8B4MB+4KMi7KR7p9k5buvY3uXppb6pUjsDNTZFtaLg2kqkZaWN006Uqha30AL5IGr
 AHRGkqi7og+r5XZ5bn+klOkdMek36AqVMsoPUhWVBXfmqEB7c8D/zMznNn/l5TzqwtE6 xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37q38mmc2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 07:41:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1367fFuK178428;
        Tue, 6 Apr 2021 07:41:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 37q2px6g5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 07:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A56QeVdVrNoWv9JxM/Pv0yI4wf2sgKH2H+c6ZB4ZyBt7nElFggN9yTEELSJ8u1HI8cJzFGQdsFpR42undCDJ5ln6u+n3OZ/1UutfGoJL8iZ6nRFxbGi07sKND33ku+eF5Rx717BrvNxKHqbtK0p2sb46adHlfZfhNUQcZ26pRhIArbovzxKLLQPnAtG6Jc6qY4mDRKFeuYd4hOriiWHMq7MWhdVqJm+IJs+SKqJppaKgth5p5wUWh1ZyrqeKijoxB3rW0i99IXbSm990ijuH3CbKw8vodapWEM9k3YDaj24YGDpzsyr8ZiVN6H2CdCBIF+k9FLNfdwioM+YIL7IAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnPPkYnLqdWSiJN7DHao0j/qyxw18ZlMz6KTpCPY/Bs=;
 b=aczX800lATEMAjCYn7a1hhtnaOXqnAmttKVwnsjxUJD6JMriiKgmhHUEJn2h9J6wlchD8MgMWPzAbg6IZKKidlNNpQ/vGrvbWKDv1F36fHYRtdmhb1I06tQl+arXIhsUSP1gMYHwxz2Ejr4jAY/h8mkkPkGQFBdJOvEIbSxWk8Kq0RJJ+zN89/HkoeMhgRstlxGc9vo8jhW6VI1mR0OgAkBqpyj3wX+m1+TrIOtpKo+wUMwhO09+wjb8o/mG+E5ks54we8MGIlUHvW5q0G/P3Cewigguu/eFiuX1NT1LTnzFV9PexOstG1F6o1ukSls4Pr0AQ7sqL6J8oYNZH/qxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnPPkYnLqdWSiJN7DHao0j/qyxw18ZlMz6KTpCPY/Bs=;
 b=cq3tNMSCMiVUYNWemNnYHtosU99pDmYQaN4N94MQxKTbZXYEFATq1E0W4kvRuGgWmpFk3Kc0ULxudwgn2qlVkBBGyNa+U+gl91Eu3eY6LpFEJEQBZt7oQqFW0e5jcSIjbj8zWO9a8q+b3UAf0xH+fvcvnlNF4m9UkoMqF2qmVeo=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1543.namprd10.prod.outlook.com (2603:10b6:903:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 07:41:35 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 07:41:35 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Topic: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Index: AQHXHyBjcp8TyH1SzUWnxbuZ1f1Dr6qR/BUAgAE7LgCADJsVgIAHX+6A
Date:   Tue, 6 Apr 2021 07:41:35 +0000
Message-ID: <3BB6C757-3DDB-41B8-96D0-88957E6F1DC0@oracle.com>
References: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
 <20210323194608.GO2356281@nvidia.com>
 <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
 <20210401150423.GH1463678@nvidia.com>
In-Reply-To: <20210401150423.GH1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c30a4dd-52ae-47c9-0f8b-08d8f8cf67b3
x-ms-traffictypediagnostic: CY4PR10MB1543:
x-microsoft-antispam-prvs: <CY4PR10MB1543F8A6840923F8EE7351B1FD769@CY4PR10MB1543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dqWA7yxnoTldtJsMHwRxXOvxj+rEQ0/lx2ion1orhyoXzI5q9BNd0GcKvdPjTdlzBEBuvvxEvokdvxbzjfFIvFYqpqZL61CIqLN3Pbot7pi9Ks6N0/B1XxWU9UsW3dxW8vp+5xlf3s7bU1ohGYFvzAn7CK9t4BHlGxYMiRArbuaaF63p03Q9SDMBG9Eq8kyxhINSgZNIjWSuq0sdJ1LX136y9meTeakCM+C7VyCGOt736shaRDdGrmR4FmoiZiyOspNuB7/SXud8zrOHruBYn8PCAM/tjMfTn55UR3Ytg3fQfIWmgvpQuWQw1L4/8hzjhSC2wwwIoz8l9zSF8bGhIvy9CfF3REncDL1iqThHKBHS+zep9bfFpZDAr9ufEmbhpSyaX4Wj3jKZaVMJ4UR1reUNp75GXKw9DpjbQx9VQH0LdHEbZ82igft4uAA1nJiZUqZ+N0owg2s6hVYtS/8GzWvtfA6yjgvhc+iXSccYXwJ/cqOGQl8924tUfHGMbK3apjOe392tTCxtS9CRAUor/Kbr8jM/QWLHI9SVZrSsg8kkQLx5Xrb7XaKEJHepAl0rPdbgqiZDaiwrZzeDL1neAdBU4vsksyctoJGhQuMJeebwBj2M8lde0HPW7yo9TGL6I8PRtXPL552F9lk534lylC/6zHg/UytvTkSmiJ0ikayp8O1SSikE/Fq31B7rFzv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(4326008)(2906002)(478600001)(26005)(6506007)(53546011)(91956017)(33656002)(6486002)(5660300002)(36756003)(71200400001)(66946007)(66556008)(64756008)(66446008)(66476007)(186003)(76116006)(83380400001)(86362001)(8936002)(2616005)(8676002)(66574015)(38100700001)(44832011)(6512007)(6916009)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlhGb1J6TVhQQVYvS1ZMZlBiUWEwRnE0TjRKM3NXQm0vdUIvN2IrZG82ZEho?=
 =?utf-8?B?OUdvMnlYTHQ5ZWM1TXlmTWZScHBLWnlucEE4bWVqU3U1bEJjNlZKQi9Gb2hR?=
 =?utf-8?B?bjVZbEphZmVXNzdoK0tmTlgvNGdlUlRlZnM5aHV4Tk5GZkRvdzU3WThLRGdr?=
 =?utf-8?B?Uk03VVlJdU42bU52cCtzOEZnQ1pmZURRdGsvVHNpc0UxUE1HakF3N0l0TCtQ?=
 =?utf-8?B?REZyQWwyNW5JTFBsYjlNTHdDaVpMYVdYRUo5Uk9Kdk5zNTNQZFVOVzNEUFY2?=
 =?utf-8?B?WEJFN1hXMWNuQWY2YUtWV3JFdW9XeGhVT1lBekpINHpaNG9WdkczOWNVZk43?=
 =?utf-8?B?UzBDeEJLU2RjcGtyZmRvQWtaam9ZK2I0a0tyck1nQTh3SjVzRlEzN1ZmOWZl?=
 =?utf-8?B?QUdpM3F2SnRYZDRlMHVwalZGQ3V1L0VNVDNpeVZJakhSN3ZaMlFpbjFvLytw?=
 =?utf-8?B?eWJqdVRvaG52Kzd6dlZvVjJjVmNlem1VZFMzOXlwS2owUHRETjYxU3ZMUTl0?=
 =?utf-8?B?dFhJZnQ3bXFQWnA0dnU0bGQ2Q0daNmlSTVRSSWlZVkJsbkN3eHk4U2xNajVK?=
 =?utf-8?B?Rk1HSFJvNW5uaHhXOW8zTnhXQ1hoaUhIN09GamhFYlFxYm1wMjQwWkl0ZHRD?=
 =?utf-8?B?TnpkZWdndjdrU2VsQnJFY1ViVks3MHFVbjFQUHhqOE4zOTMrcVNFRWphb2lN?=
 =?utf-8?B?b3hJL0d5SzRmWW01dk95a0lOVlVlcDcrN1BkSGhuUmw2R1VEMzZLR0M5NUZp?=
 =?utf-8?B?RjhBWDU1Y3BnZ0VpV05sTUVtaUt2amhEN3hITjM2dEFhbnlwdFlsQlArWU50?=
 =?utf-8?B?MDVtc3BYWkZTREd5c2RScDA3dzRvRG4yRHJ1K1dpWHpsRUg3bFVtOC9aazRX?=
 =?utf-8?B?cDVxaUJuemp5MnJJOGR6dUZRT3RqQjhJWFFERHNlcFI2WFZIMTUvQWJjakpB?=
 =?utf-8?B?YkRBRE1uOWVKRTg1VU9iaWR2a3NNWWJrWTc1cjMyZmNFbDJkVjJub2dYRTU2?=
 =?utf-8?B?ZTc2RzVFOStWMkNIcUpXWFlFU3ZDbWpJa0l3alZwRVV5Y1J3VVh2aUlBUkk0?=
 =?utf-8?B?dFpBeWFoayswR04zb01lWVM5b0NZUUVxc1FOcXZUMjFvSTRxeGdyZWhOSGNk?=
 =?utf-8?B?WnUySzBQU05jeWc4QzBYbHRPbXZjVGp6dm4yeDFVS2RuMkNrdGROTkUwUklP?=
 =?utf-8?B?ZUZQcUp2TDFmazhORFliejRXV0VBK3RBOGtXZHphbXFKTjFYVGxpOERxZW9z?=
 =?utf-8?B?alI4SklCd2dsQm1VMWprVUFjQklqbGFwc1hBcTdzTjdEcWxXL1B3ZXljeWEv?=
 =?utf-8?B?VlZ4YVZsL0k4cHdNWHVlSnBVTXF0RlkwZXpuT0llVkxNczJZQ0hPN2JqNGFP?=
 =?utf-8?B?UFNBbkRsMy9SYVVGZDdJZS9wdWpWNE9waDlUY2NKeTB6MS9kY1Z3ckM4eTBv?=
 =?utf-8?B?WERZTm5tQTE2OVoycHVFc1ZINXA5RUNFclV6UzVyZzJjbWdML0VsVzlQUFRD?=
 =?utf-8?B?UmNIQyt4NlFZTVQ2Q1JiWis1czBrWk8zUWhDV2hQL0hrOXFZN2p4Q2NaWmpX?=
 =?utf-8?B?a2V5ZlB3cUVaYzNtRlBESjBRNDhBL093UHdQc1QvVkNRTUd0Y3ZMVDFtaTR4?=
 =?utf-8?B?VlhNQTc4QTJvV1FkZXpyRS9xSlRKMmFVajF1Y2IwTzBBNVNkRDhNZENya1Jh?=
 =?utf-8?B?b0J3dTNqZ09UMGgwb3JZWWVjTGZNeUppalN4TDN3OGlkSmxGZWd0RndrbW1L?=
 =?utf-8?B?eHA0ZjJjQldhelVFcHBzT3JtcSsyalR0ZGg0dmtnRE1uTFpzaStMd0owSTRk?=
 =?utf-8?B?dlR4ZzNQeFBlZ25Kbjh3Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CF38ED5DC922446917289B49E619F4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c30a4dd-52ae-47c9-0f8b-08d8f8cf67b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 07:41:35.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVmU6ZZb5giScfWAUl0cwfqh2BNHik9Kaug9Xfg4T7WHqA6//CuvbUc+odtIQ6w/twbEQGcB3d1LZ4TjeNgv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1543
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060051
X-Proofpoint-GUID: JhrV0FOKN-I6BnBKAja036XQMQSnOq97
X-Proofpoint-ORIG-GUID: JhrV0FOKN-I6BnBKAja036XQMQSnOq97
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060051
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMSBBcHIgMjAyMSwgYXQgMTc6MDQsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBNYXIgMjQsIDIwMjEgYXQgMDI6MzQ6MTNQTSAr
MDAwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiAyMyBNYXIgMjAyMSwg
YXQgMjA6NDYsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IE9uIE1vbiwgTWFyIDIyLCAyMDIxIGF0IDAyOjM1OjMyUE0gKzAxMDAsIEjDpWtvbiBCdWdn
ZSB3cm90ZToNCj4+Pj4gT24gUm9DRSBzeXN0ZW1zLCBhIENNIFJFUSBjb250YWlucyBhIFByaW1h
cnkgSG9wIExpbWl0ID4gMSBhbmQgUHJpbWFyeQ0KPj4+PiBTdWJuZXQgTG9jYWwgaXMgemVyby4N
Cj4+Pj4gDQo+Pj4+IEluIGNtX3JlcV9oYW5kbGVyKCksIHRoZSBjbV9wcm9jZXNzX3JvdXRlZF9y
ZXEoKSBmdW5jdGlvbiBpcw0KPj4+PiBjYWxsZWQuIFNpbmNlIHRoZSBQcmltYXJ5IFN1Ym5ldCBM
b2NhbCB2YWx1ZSBpcyB6ZXJvIGluIHRoZSByZXF1ZXN0LA0KPj4+PiBhbmQgc2luY2UgdGhpcyBp
cyBSb0NFIChQcmltYXJ5IExvY2FsIExJRCBpcyBwZXJtaXNzaXZlKSwgdGhlDQo+Pj4+IGZvbGxv
d2luZyBzdGF0ZW1lbnQgd2lsbCBiZSBleGVjdXRlZDoNCj4+Pj4gDQo+Pj4+ICAgICBJQkFfU0VU
KENNX1JFUV9QUklNQVJZX1NMLCByZXFfbXNnLCB3Yy0+c2wpOw0KPj4+PiANCj4+Pj4gVGhpcyBj
b3JydXB0cyBTTCBpbiByZXFfbXNnIGlmIGl0IHdhcyBkaWZmZXJlbnQgZnJvbSB6ZXJvLiBJbiBv
dGhlcg0KPj4+PiB3b3JkcywgYSByZXF1ZXN0IHRvIHNldHVwIGEgY29ubmVjdGlvbiB1c2luZyBh
biBTTCAhPSB6ZXJvLCB3aWxsIG5vdA0KPj4+PiBiZSBob25vcmVkLCBhbmQgYSBjb25uZWN0aW9u
IHVzaW5nIFNMIHplcm8gd2lsbCBiZSBjcmVhdGVkIGluc3RlYWQuDQo+Pj4+IA0KPj4+PiBGaXhl
ZCBieSBub3QgY2FsbGluZyBjbV9wcm9jZXNzX3JvdXRlZF9yZXEoKSBvbiBSb0NFIHN5c3RlbXMu
DQo+Pj4+IA0KPj4+PiBGaXhlczogMzk3MWM5ZjZkYmYyICgiSUIvY206IEFkZCBpbnRlcmltIHN1
cHBvcnQgZm9yIHJvdXRlZCBwYXRocyIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdn
ZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L2NtLmMgfCAzICsrLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY20uYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+Pj4gaW5kZXggM2QxOTRi
Yi4uNmFkYmFlYSAxMDA2NDQNCj4+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20u
Yw0KPj4+PiBAQCAtMjEzOCw3ICsyMTM4LDggQEAgc3RhdGljIGludCBjbV9yZXFfaGFuZGxlcihz
dHJ1Y3QgY21fd29yayAqd29yaykNCj4+Pj4gCQlnb3RvIGRlc3Ryb3k7DQo+Pj4+IAl9DQo+Pj4+
IA0KPj4+PiAtCWNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFfbXNnLCB3b3JrLT5tYWRfcmVjdl93
Yy0+d2MpOw0KPj4+PiArCWlmIChjbV9pZF9wcml2LT5hdi5haF9hdHRyLnR5cGUgIT0gUkRNQV9B
SF9BVFRSX1RZUEVfUk9DRSkNCj4+Pj4gKwkJY21fcHJvY2Vzc19yb3V0ZWRfcmVxKHJlcV9tc2cs
IHdvcmstPm1hZF9yZWN2X3djLT53Yyk7DQo+Pj4gDQo+Pj4gd2h5IHVzZSBhaF9hdHRyLnR5cGUg
d2hlbiBhIGZldyBsaW5lcyBiZWxvdyB3ZSBoYXZlOg0KPj4+IA0KPj4+IAlpZiAoZ2lkX2F0dHIg
JiYNCj4+PiAJICAgIHJkbWFfcHJvdG9jb2xfcm9jZSh3b3JrLT5wb3J0LT5jbV9kZXYtPmliX2Rl
dmljZSwNCj4+PiAJCQkgICAgICAgd29yay0+cG9ydC0+cG9ydF9udW0pKSB7DQo+Pj4gDQo+Pj4g
Pw0KPj4+IA0KPj4+IEkgc3VzcGVjdCB5b3UgY2FuIGp1c3QgbW92ZSB0aGlzIGludG8gdGhlIGVs
c2U/DQo+PiANCj4+IEkgY2FuIGNvdW50ZXIgdGhhdCBieSBzYXlpbmcgYWhfYXR0ci50eXBlIGlz
IHVzZWQgfjEwIGxpbmVzIGZ1cnRoZXINCj4+IGRvd24gaW4gdGhlIGNvbmRpdGlvbmFsIGNhbGwg
dG8gc2FfcGF0aF9zZXRfZG1hYygpIDstKQ0KPiANCj4gSHVtLCBPSy4gUGxlYXNlIHNlbmQgYW4g
YWRkaXRpb25hbCBwYXRjaCB0byB1bmlmeSBldmVyeXRoaW5nIGFyb3VuZA0KPiBhdi5haF9hdHRy
LnR5cGUNCg0KV2lsbCBkby4NCg0KPj4+IAlpZiAoZ2lkX2F0dHIgJiYNCj4+PiAJICAgIHJkbWFf
cHJvdG9jb2xfcm9jZSh3b3JrLT5wb3J0LT5jbV9kZXYtPmliX2RldmljZSwNCj4+PiAJCQkgICAg
ICAgd29yay0+cG9ydC0+cG9ydF9udW0pKSB7DQo+PiANCj4+IEkgY2Fubm90IHJlYWxseSBzZWUg
aG93IGdpZF9hdHRyIGNvdWxkIGJlIG51bGwuIElmDQo+PiBpYl9pbml0X2FoX2F0dHJfZnJvbV93
YygpIHN1Y2NlZWRzLCBpdCBpcyBzZXQgYWZ0ZXIgdGhlIGNhbGwgdG8NCj4+IGNtX2luaXRfYXZf
Zm9yX3Jlc3BvbnNlKCkgYWJvdmUuIE1heSBiZSB1c2luZyBhaF9hdHRyLnR5cGUgaW4gdGhpcw0K
Pj4gdGVzdCBpbnN0ZWFkLCBmb3IgdW5pZm9ybWl0eSBhbmQgcmVhZGFiaWxpdHk/DQo+IA0KPiBU
aGUgR1JIIGlzIG9wdGlvbmFsLCBpYl9pbml0X2FoX2F0dHJfZnJvbV93YygpIG9ubHkgc2V0cyBp
dA0KPiBjb25kaXRpb25hbGx5Lg0KDQpUcnVlLiBCdXQgb25lIG9mIHRoZSBjb25kaXRpb25zIHRv
IHNldCBzZ2lkX2F0dHIgaXMgcmRtYV9wcm90b2NvbF9yb2NlKCkuIEhlbmNlIHRoZSBmaXJzdCB0
ZXJtIGluOg0KDQppZiAoZ2lkX2F0dHIgJiYgcmRtYV9wcm90b2NvbF9yb2NlKCkpDQoNCmlzIHN1
cGVyZmx1b3VzLiBUaGlzIGJlY2F1c2UsIGl0IGNhbm5vdCBiZSBOVUxMIG9uIFJvQ0Ugc3lzdGVt
cywgYmVjYXVzZSBpdCBpcyBkZXJlZmVyZW5jZWQgaW46DQoNCmNtX2luaXRfYXZfZm9yX3Jlc3Bv
bnNlKCkNCiAgICBpYl9pbml0X2FoX2F0dHJfZnJvbV93YygpDQogICAgICAgIHJkbWFfbW92ZV9n
cmhfc2dpZF9hdHRyKCkNCg0KDQpJJ2xsIHNlbmQgdGhlIHBhdGNoIHdpdGggdGhlIGdpZF9hdHRy
IHRlcm0gYW5kIGxldCB5b3UgY2FuIGRlY2lkZS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCg0K
DQo+IA0KPiBBcHBsaWVkIHRvIGZvci1uZXh0DQo+IA0KPiBUaGFua3MsDQo+IEphc29uDQoNCg==
