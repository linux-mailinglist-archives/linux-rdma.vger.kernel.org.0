Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBD3ACCEE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhFRN74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 09:59:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233754AbhFRN74 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 09:59:56 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IDumio002339;
        Fri, 18 Jun 2021 13:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yn0ljrVLeYwJJqPkk3Fc9GuICshLNJ87mGVJROhc4RQ=;
 b=p7sbMzEheVnMGvcp3OnowlhJZkyjTw/Qyfuxl69CYQgz4fLwHlqC3tTci/K9M266Zf5R
 rIipNkF3wMbkdT+QXgs99l8mZeoSpYjOcZlO411nLKsDQjP5OESFMxWI5//7yVy1YJyb
 yc7dikNOxnW1Mt2HWgil8V779Grm5vZvuYA8lfSMidYR5EfPtMQNksFe9RVfHYaU7l19
 HHA0jyGGigwZkKa+O9qEkxl0YOdMfDI/QYBJ6NVK7q614RwJLWB49r1UV4GD/1WVcp8T
 u3kEf+bPmacD9N98V/rBXMlkiOZN0puFeCDuoycaDrjmvKSEwtBuVZJ05P6ShYWZ2UtL sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 397w1y3a39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:57:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IDsxZv189308;
        Fri, 18 Jun 2021 13:57:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 396wareq83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 13:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMC5y7LW3RNbkzSpXx8P75BEx/xKCT9984xhIeaUGCtzbmstwbj1Sxi/TiL5uj7qg/cygaSj8piG3LV4b/W92rR1DmpyYGQJX1BoiJ5GKzHXzVX0OgnKeMle9SvNtRXMZSFJRij6F462JysAjZwRv4QH9Ft4xXolukG64wnrlIGgvHC1Y4bxJiSbTaRQmyptffQB1lauPqTynZnqwdf2Te5Y5I6s5MDzjHC5hplnCwqepkvaty+rtmswQ8R7jE51cCEeA+DND4R56GP834teJttXmKb4+8i2FwW6meNM7p7C4GGAN4pNTZNvOzl6cNWRNyRqKP0fkUcGMw//AoVdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0ljrVLeYwJJqPkk3Fc9GuICshLNJ87mGVJROhc4RQ=;
 b=V39RjaisL+P9zX65RwYICQULEjyAAir3uZIsc8oWZan0Tz1tjnXHqfvqaD546VZ4o+onD6u8Y9kNDoFZKFjGF/AoBTgdlIJL3gEphpVHbAdBBO/4dWBUpyoLqTChg2wpRwNVJFXlsu/8ygenuzVt0hJAMm5QlT1bfJAeMzFtpDA9lWjGqKeObDsRNz8F7pZBxlTVfMxa2I0vmZkGXNIQ1eeoULefdPxCx3HLjzkAYa8x+bTnzyBeb4Tho0XTns//Ay0RXCpKygH2w72memd1/omSsWDnuQ7eMaqQ+Lq8iej06/c0U9FVxu+xBlSJKNyANYw/8Mk6ZSGkGRmVmcqohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0ljrVLeYwJJqPkk3Fc9GuICshLNJ87mGVJROhc4RQ=;
 b=MmAEMjXFr/I+CTn24jhlqWBGOZMaBkcGZvJiq1H3JI4s1dQBkjXKlcGFbzIAqyTxWAMWFXafpDNyZG6JsIQlULY+IqAEGFsgmlygI6K+qewYVLjxOMYVxmI7RmDC2IodfqPc6L4jqvF1kxeNn/DzAs3b9Fm4khCS0Opg4p0SV9g=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2374.namprd10.prod.outlook.com (2603:10b6:910:42::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Fri, 18 Jun
 2021 13:57:38 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.019; Fri, 18 Jun 2021
 13:57:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsXxQ4AgAABMICAAAuugIAAHFMAgAA61ICAAaU8AA==
Date:   Fri, 18 Jun 2021 13:57:38 +0000
Message-ID: <CDD2A960-7F76-4EB6-A486-35CF41DB7F37@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <YMrxDtudALQkYuXP@unreal> <E69C3CB3-AE31-4139-816A-11467729ABDC@oracle.com>
 <YMr72f1bVgQPPlnv@unreal> <4C4C7F68-619C-4146-BDC8-18E0B356FCC6@oracle.com>
 <YMtE9dUHld5GvQcq@unreal>
In-Reply-To: <YMtE9dUHld5GvQcq@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f40f0d80-7868-429c-e28a-08d93261089f
x-ms-traffictypediagnostic: CY4PR1001MB2374:
x-microsoft-antispam-prvs: <CY4PR1001MB23740EFC4864E02D5BB83235FD0D9@CY4PR1001MB2374.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9cYF4WD+RjNea8Psr0xm4DIFANmNu8RFP3ENo3lCf224KlyweXtX2xDVWKCbwmK5Ok75nSxgGbhGqCtzausuPoftMbyhi9Z//rZBVOgLPbdNbkj98ynJl+4KE1VQQboLjgG3mgg/67b6dI2jy92+3BeNR4qvw7LTeSLSmCN5A65nHu5vXeirEib83FoG9ixX6wFt+v/yrmvjth0cDe1XLiE4QS3vU/Dm10iQY7IaLR5f3FjisMkFOwf2e0URyzFdwlz+BGFoOqQ7ceny1OHxQHdsRu9pocJkgyJoAw8t/D94hgtzzzX0qtqHaL1FiN+DmI0FzIC++1DUhnK0kqUWIi/jHAvmbC1J1gCJerlkbyluJdExOBXAj96w4U65LJ8Qlo47mniS+XFBQ3j0EzvVo6nyRgOhHfNU1SsJ7MGN0BRjy++2PBesgW9PF7kEXd5V/esq4tOEw0GjlLAp43p4ycrl1DbAflZqEqNPrUFK7KDgUjzzxQONQV4SpS3hUlhd8u9zf6B5ZsE4yJT35ZEX7Qg4se3Ljt3yH8skZEFNh10A2mdYFXl2hAHOXtFH/SjUxEROzb4TrLyPMD4oc/1xYeUYPfB1EaU62FsfEXj5R15W/r+lqqAx0UPC0pokTz+YBwmESvmTVyuU0gTVxv3ONaBwSMs8BsM7gZfF4pRMqYQ0fJVJS7g4380OB3P2YvP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(346002)(396003)(66476007)(91956017)(66556008)(38100700002)(54906003)(66946007)(6486002)(76116006)(26005)(36756003)(6506007)(8676002)(478600001)(186003)(71200400001)(53546011)(44832011)(33656002)(86362001)(8936002)(316002)(122000001)(66446008)(4326008)(6916009)(2906002)(64756008)(6512007)(5660300002)(83380400001)(66574015)(2616005)(290074003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkcxUVJjcGJnM25FL3B2azQvM3NMc3kzTzZ2K2xkYmZ4Q0o2bXhzL3FpbjFZ?=
 =?utf-8?B?Wk5DTHcwd1RwYUF1b1BZcUlFZGgrOXB2eTdtZHhKZkdTUWg3cVV3L0tjcUxa?=
 =?utf-8?B?Nk9qN0RnaHJTNjFKeDU1cFV3Y3pPYkNUMmV5TC8rNlB0QUxValg2WGNqVnM5?=
 =?utf-8?B?MkNUUFQyaVdOL0c4emVMK2huVk5jTWxzQk5CTm1MYjRVRjM1L25LaGsvbzNO?=
 =?utf-8?B?SU1mdjJ1VU9aSHVCSDk5cHhDdUhXMzRqY3A1d1kzbmN5b1hGei90Szh0VlR0?=
 =?utf-8?B?Z0g1UkU2SEhlNGdvaUMxbTZKemVrc1JDbW5rR2J5RXc3RkpRYkFBNlcwejQv?=
 =?utf-8?B?bVh6UGlMTkFudXIvSlFmSUlvNFJaUlMwV1hCSkRzeStpeVhRYkJKbGVKT2Vn?=
 =?utf-8?B?enEyb3RaWGZvZkIrN0hSeTFPbmh4WWhBa3pmNFQ5NklwazU3MU05QlpGQ1hO?=
 =?utf-8?B?Z1V2Ykpick1jckZRRWF2N0ZRcU5WTWErUGozaXFmNGUwVUY4SE9zdFNvalZp?=
 =?utf-8?B?aTFQVEpXTHQ4dnB5YzZDdDNoaGRkc3RIcURvWUVaMnVzTHJZaEdRdjdYRFlY?=
 =?utf-8?B?QU5uaElMMzJhNytSenRIUFJSeSs4ZGtzYWh5cWphQzJ3cXY5Q2lMSy9wTlhE?=
 =?utf-8?B?UEZqbmRNQ0VUQUIrb2hFcm5FN1lReVNua1p3dHpIcm5KWDRvTUwvVmJqeGRi?=
 =?utf-8?B?b0dhaXdJb0hMaDBWUVhWOWJtMXpGdWUxZVFrK2d2OGdxZzhCamNsY3FmUXpk?=
 =?utf-8?B?a2FUSFBWLzFOMkNCK0lWY2lTOVIrNUQrVFhmRW5jYkRDQ3BEalBzWmVGbGh0?=
 =?utf-8?B?YnVZOFZpcTRtQUFYaXNLZ2VGSmtESlczS0VGYm51Sm4rSXRZbFFHY3J4bEg2?=
 =?utf-8?B?d28rVDhmYUo5WVZEcFd1ZEUyU3dlSHhzWFVFOXVQNWNoeFBBYVdlUHAvWXZu?=
 =?utf-8?B?V3RJc2hTUUtxWnE3bE15Nmt6dW1BUEwvNThxb2licDZrK3R4OXdOc2cvMzBv?=
 =?utf-8?B?Ni9tU1NKQlZlVzE5dnFoMGRyTTArWFR0YnRScUJZSjREYTBtd3Fvd3BNa1BB?=
 =?utf-8?B?VXlvWUhqdStUUlZqVlpUQnREOHlxNkR3WUdMSGVaQ2d6c2FTdEljM1BLeXA2?=
 =?utf-8?B?Z2MvdE1IK1JaK1BDTVEzNXhwMDhhRmdQSSs4VmRoWHYxdEQ1aXY1UlBRT2xN?=
 =?utf-8?B?QVVBKzBBR0lmYnU3T0VPNCtmZkZOd0hLeGNwNzJJYTV3c0Jtd1RTNFhPWWtM?=
 =?utf-8?B?UFZ0d1habUh5aG5JRktsRGhnblNBWVBUbVZMQXFaTlEwdVBQSFRMeEMzSDFQ?=
 =?utf-8?B?YWkyU3FNL0ZJRkM4VEFwR2c0OFBVMFJxRXQ5YlNabUxBVzhWeWZpZFF5c29l?=
 =?utf-8?B?RG1jV1BYQ09pQ0NJL1dYRjAxc3k3M0JFTXVtTGZCVm9ZdmZMY1c2dmE4bGZ5?=
 =?utf-8?B?eFpSVUo4SXpmdFp6am0rb05uLzBySVB3K1QzdmtnL0xZdXBOMG13dElmZ2pp?=
 =?utf-8?B?S0F4S0pGTlowSkxBOFJmMzZVSW5TWWE4K2V3UjhHQS9TNjBoSU1FWU5iQzBy?=
 =?utf-8?B?NTlTVUhFa2tndzQ2Y0pCOWoxOEFMV2lJeVdFS2NUV1dHSlF3bEJwZFd0SDQz?=
 =?utf-8?B?VVMvN2NyMzRvUitYd3Q0QzlGemw0aTY0YU9mNE03c3V2MjFucWs4b0hYdnoy?=
 =?utf-8?B?SytpMjdRQndRQXBiWDlMazRtalpKbGZnMzNzZVJiT1psYTJic3pnenFMcFJa?=
 =?utf-8?B?YWtrMVhNZllHdmhvK0dmMXlWcVlhSXh4QXBsbG5rR0Q1a0JjVmZYRWVLSm9t?=
 =?utf-8?B?Mjh3NW5xczh1RjY1ckROZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <576D57C103F1434E9C27CD75814B78D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40f0d80-7868-429c-e28a-08d93261089f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 13:57:38.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2ERgC2zjvOb6JJjXVSQlSv2GYrivdHaiB0HkSpdCiR3hlCzPIpBodNw245NhyhLwjsVspdusMkqvAIn2Q5qbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2374
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180082
X-Proofpoint-ORIG-GUID: cQ0sgyHniYkKMwW14SIS91UBxHRQE0ZG
X-Proofpoint-GUID: cQ0sgyHniYkKMwW14SIS91UBxHRQE0ZG
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTcgSnVuIDIwMjEsIGF0IDE0OjQ5LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxNywgMjAyMSBhdCAwOToxOToyNkFN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDE3IEp1biAyMDIx
LCBhdCAwOTozOCwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDA2OjU2OjE1QU0gKzAwMDAsIEhhYWtvbiBC
dWdnZSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gMTcgSnVuIDIwMjEsIGF0IDA4OjUx
LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+
IE9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDA0OjM1OjUzUE0gKzAyMDAsIEjDpWtvbiBCdWdnZSB3
cm90ZToNCj4+Pj4+PiBUaGUgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSBjb250YWlucyB0aHJlZSBi
aXQtZmllbGRzLCB0b3Nfc2V0LA0KPj4+Pj4+IHRpbWVvdXRfc2V0LCBhbmQgbWluX3Jucl90aW1l
cl9zZXQuIFRoZXNlIGFyZSBzZXQgYnkgYWNjZXNzb3INCj4+Pj4+PiBmdW5jdGlvbnMgd2l0aG91
dCBhbnkgc3luY2hyb25pemF0aW9uLiBJZiB0d28gb3IgYWxsIGFjY2Vzc29yDQo+Pj4+Pj4gZnVu
Y3Rpb25zIGFyZSBpbnZva2VkIGluIGNsb3NlIHByb3hpbWl0eSBpbiB0aW1lLCB0aGVyZSB3aWxs
IGJlDQo+Pj4+Pj4gUmVhZC1Nb2RpZnktV3JpdGUgZnJvbSBzZXZlcmFsIGNvbnRleHRzIHRvIHRo
ZSBzYW1lIHZhcmlhYmxlLCBhbmQgdGhlDQo+Pj4+Pj4gcmVzdWx0IHdpbGwgYmUgaW50ZXJtaXR0
ZW50Lg0KPj4+Pj4+IA0KPj4+Pj4+IFJlcGxhY2Ugd2l0aCBhIGZsYWcgdmFyaWFibGUgYW5kIGlu
bGluZSBmdW5jdGlvbnMgZm9yIHNldCBhbmQgZ2V0Lg0KPj4+Pj4+IA0KPj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogSGFucyBXZXN0Z2FhcmQgUnk8aGFucy53ZXN0Z2FhcmQucnlAb3JhY2xlLmNv
bT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyAgICAg
IHwgMjQgKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+Pj4+Pj4gZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY21hX3ByaXYuaCB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+Pj4+
PiAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4+
Pj4+IA0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+Pj4+Pj4gaW5kZXggMmI5ZmZjMi4uZmU2
MDllNyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0K
Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+Pj4+Pj4gQEAgLTg0
NCw5ICs4NDQsNyBAQCBzdGF0aWMgdm9pZCBjbWFfaWRfcHV0KHN0cnVjdCByZG1hX2lkX3ByaXZh
dGUgKmlkX3ByaXYpDQo+Pj4+Pj4gCWlkX3ByaXYtPmlkLmV2ZW50X2hhbmRsZXIgPSBldmVudF9o
YW5kbGVyOw0KPj4+Pj4+IAlpZF9wcml2LT5pZC5wcyA9IHBzOw0KPj4+Pj4+IAlpZF9wcml2LT5p
ZC5xcF90eXBlID0gcXBfdHlwZTsNCj4+Pj4+PiAtCWlkX3ByaXYtPnRvc19zZXQgPSBmYWxzZTsN
Cj4+Pj4+PiAtCWlkX3ByaXYtPnRpbWVvdXRfc2V0ID0gZmFsc2U7DQo+Pj4+Pj4gLQlpZF9wcml2
LT5taW5fcm5yX3RpbWVyX3NldCA9IGZhbHNlOw0KPj4+Pj4+ICsJaWRfcHJpdi0+ZmxhZ3MgPSAw
Ow0KPj4+Pj4gDQo+Pj4+PiBJdCBpcyBub3QgbmVlZGVkLCBpZF9wcml2IGlzIGFsbG9jYXRlZCB3
aXRoIGt6YWxsb2MuDQo+Pj4+IA0KPj4+PiBJIGFncmVlLiBEaWQgcHV0IGl0IGluIGR1ZSB0aGUg
Zm9vID0gZmFsc2UuDQo+Pj4+PiANCj4+Pj4+PiAJaWRfcHJpdi0+Z2lkX3R5cGUgPSBJQl9HSURf
VFlQRV9JQjsNCj4+Pj4+PiAJc3Bpbl9sb2NrX2luaXQoJmlkX3ByaXYtPmxvY2spOw0KPj4+Pj4+
IAltdXRleF9pbml0KCZpZF9wcml2LT5xcF9tdXRleCk7DQo+Pj4+Pj4gQEAgLTExMzQsMTAgKzEx
MzIsMTAgQEAgaW50IHJkbWFfaW5pdF9xcF9hdHRyKHN0cnVjdCByZG1hX2NtX2lkICppZCwgc3Ry
dWN0IGliX3FwX2F0dHIgKnFwX2F0dHIsDQo+Pj4+Pj4gCQlyZXQgPSAtRU5PU1lTOw0KPj4+Pj4+
IAl9DQo+Pj4+Pj4gDQo+Pj4+Pj4gLQlpZiAoKCpxcF9hdHRyX21hc2sgJiBJQl9RUF9USU1FT1VU
KSAmJiBpZF9wcml2LT50aW1lb3V0X3NldCkNCj4+Pj4+PiArCWlmICgoKnFwX2F0dHJfbWFzayAm
IElCX1FQX1RJTUVPVVQpICYmIGdldF9USU1FT1VUX1NFVChpZF9wcml2LT5mbGFncykpDQo+Pj4+
Pj4gCQlxcF9hdHRyLT50aW1lb3V0ID0gaWRfcHJpdi0+dGltZW91dDsNCj4+Pj4+PiANCj4+Pj4+
PiAtCWlmICgoKnFwX2F0dHJfbWFzayAmIElCX1FQX01JTl9STlJfVElNRVIpICYmIGlkX3ByaXYt
Pm1pbl9ybnJfdGltZXJfc2V0KQ0KPj4+Pj4+ICsJaWYgKCgqcXBfYXR0cl9tYXNrICYgSUJfUVBf
TUlOX1JOUl9USU1FUikgJiYgZ2V0X01JTl9STlJfVElNRVJfU0VUKGlkX3ByaXYtPmZsYWdzKSkN
Cj4+Pj4+PiAJCXFwX2F0dHItPm1pbl9ybnJfdGltZXIgPSBpZF9wcml2LT5taW5fcm5yX3RpbWVy
Ow0KPj4+Pj4+IA0KPj4+Pj4+IAlyZXR1cm4gcmV0Ow0KPj4+Pj4+IEBAIC0yNDcyLDcgKzI0NzAs
NyBAQCBzdGF0aWMgaW50IGNtYV9pd19saXN0ZW4oc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAqaWRf
cHJpdiwgaW50IGJhY2tsb2cpDQo+Pj4+Pj4gCQlyZXR1cm4gUFRSX0VSUihpZCk7DQo+Pj4+Pj4g
DQo+Pj4+Pj4gCWlkLT50b3MgPSBpZF9wcml2LT50b3M7DQo+Pj4+Pj4gLQlpZC0+dG9zX3NldCA9
IGlkX3ByaXYtPnRvc19zZXQ7DQo+Pj4+Pj4gKwlpZC0+dG9zX3NldCA9IGdldF9UT1NfU0VUKGlk
X3ByaXYtPmZsYWdzKTsNCj4+Pj4+PiAJaWQtPmFmb25seSA9IGlkX3ByaXYtPmFmb25seTsNCj4+
Pj4+PiAJaWRfcHJpdi0+Y21faWQuaXcgPSBpZDsNCj4+Pj4+PiANCj4+Pj4+PiBAQCAtMjUzMyw3
ICsyNTMxLDcgQEAgc3RhdGljIGludCBjbWFfbGlzdGVuX29uX2RldihzdHJ1Y3QgcmRtYV9pZF9w
cml2YXRlICppZF9wcml2LA0KPj4+Pj4+IAljbWFfaWRfZ2V0KGlkX3ByaXYpOw0KPj4+Pj4+IAlk
ZXZfaWRfcHJpdi0+aW50ZXJuYWxfaWQgPSAxOw0KPj4+Pj4+IAlkZXZfaWRfcHJpdi0+YWZvbmx5
ID0gaWRfcHJpdi0+YWZvbmx5Ow0KPj4+Pj4+IC0JZGV2X2lkX3ByaXYtPnRvc19zZXQgPSBpZF9w
cml2LT50b3Nfc2V0Ow0KPj4+Pj4+ICsJZGV2X2lkX3ByaXYtPmZsYWdzID0gaWRfcHJpdi0+Zmxh
Z3M7DQo+Pj4+Pj4gCWRldl9pZF9wcml2LT50b3MgPSBpZF9wcml2LT50b3M7DQo+Pj4+Pj4gDQo+
Pj4+Pj4gCXJldCA9IHJkbWFfbGlzdGVuKCZkZXZfaWRfcHJpdi0+aWQsIGlkX3ByaXYtPmJhY2ts
b2cpOw0KPj4+Pj4+IEBAIC0yNTgyLDcgKzI1ODAsNyBAQCB2b2lkIHJkbWFfc2V0X3NlcnZpY2Vf
dHlwZShzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIGludCB0b3MpDQo+Pj4+Pj4gDQo+Pj4+Pj4gCWlk
X3ByaXYgPSBjb250YWluZXJfb2YoaWQsIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUsIGlkKTsNCj4+
Pj4+PiAJaWRfcHJpdi0+dG9zID0gKHU4KSB0b3M7DQo+Pj4+Pj4gLQlpZF9wcml2LT50b3Nfc2V0
ID0gdHJ1ZTsNCj4+Pj4+PiArCXNldF9UT1NfU0VUKGlkX3ByaXYtPmZsYWdzKTsNCj4+Pj4+PiB9
DQo+Pj4+Pj4gRVhQT1JUX1NZTUJPTChyZG1hX3NldF9zZXJ2aWNlX3R5cGUpOw0KPj4+Pj4+IA0K
Pj4+Pj4+IEBAIC0yNjEwLDcgKzI2MDgsNyBAQCBpbnQgcmRtYV9zZXRfYWNrX3RpbWVvdXQoc3Ry
dWN0IHJkbWFfY21faWQgKmlkLCB1OCB0aW1lb3V0KQ0KPj4+Pj4+IA0KPj4+Pj4+IAlpZF9wcml2
ID0gY29udGFpbmVyX29mKGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+Pj4+Pj4g
CWlkX3ByaXYtPnRpbWVvdXQgPSB0aW1lb3V0Ow0KPj4+Pj4+IC0JaWRfcHJpdi0+dGltZW91dF9z
ZXQgPSB0cnVlOw0KPj4+Pj4+ICsJc2V0X1RJTUVPVVRfU0VUKGlkX3ByaXYtPmZsYWdzKTsNCj4+
Pj4+PiANCj4+Pj4+PiAJcmV0dXJuIDA7DQo+Pj4+Pj4gfQ0KPj4+Pj4+IEBAIC0yNjQ3LDcgKzI2
NDUsNyBAQCBpbnQgcmRtYV9zZXRfbWluX3Jucl90aW1lcihzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQs
IHU4IG1pbl9ybnJfdGltZXIpDQo+Pj4+Pj4gDQo+Pj4+Pj4gCWlkX3ByaXYgPSBjb250YWluZXJf
b2YoaWQsIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUsIGlkKTsNCj4+Pj4+PiAJaWRfcHJpdi0+bWlu
X3Jucl90aW1lciA9IG1pbl9ybnJfdGltZXI7DQo+Pj4+Pj4gLQlpZF9wcml2LT5taW5fcm5yX3Rp
bWVyX3NldCA9IHRydWU7DQo+Pj4+Pj4gKwlzZXRfTUlOX1JOUl9USU1FUl9TRVQoaWRfcHJpdi0+
ZmxhZ3MpOw0KPj4+Pj4+IA0KPj4+Pj4+IAlyZXR1cm4gMDsNCj4+Pj4+PiB9DQo+Pj4+Pj4gQEAg
LTMwMzMsNyArMzAzMSw3IEBAIHN0YXRpYyBpbnQgY21hX3Jlc29sdmVfaWJvZV9yb3V0ZShzdHJ1
Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2KQ0KPj4+Pj4+IA0KPj4+Pj4+IAl1OCBkZWZhdWx0
X3JvY2VfdG9zID0gaWRfcHJpdi0+Y21hX2Rldi0+ZGVmYXVsdF9yb2NlX3Rvc1tpZF9wcml2LT5p
ZC5wb3J0X251bSAtDQo+Pj4+Pj4gCQkJCQlyZG1hX3N0YXJ0X3BvcnQoaWRfcHJpdi0+Y21hX2Rl
di0+ZGV2aWNlKV07DQo+Pj4+Pj4gLQl1OCB0b3MgPSBpZF9wcml2LT50b3Nfc2V0ID8gaWRfcHJp
di0+dG9zIDogZGVmYXVsdF9yb2NlX3RvczsNCj4+Pj4+PiArCXU4IHRvcyA9IGdldF9UT1NfU0VU
KGlkX3ByaXYtPmZsYWdzKSA/IGlkX3ByaXYtPnRvcyA6IGRlZmF1bHRfcm9jZV90b3M7DQo+Pj4+
Pj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gCXdvcmsgPSBremFsbG9jKHNpemVvZiAqd29yaywgR0ZQX0tF
Uk5FTCk7DQo+Pj4+Pj4gQEAgLTMwODEsNyArMzA3OSw3IEBAIHN0YXRpYyBpbnQgY21hX3Jlc29s
dmVfaWJvZV9yb3V0ZShzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlICppZF9wcml2KQ0KPj4+Pj4+IAkg
KiBQYWNrZXRMaWZlVGltZSA9IGxvY2FsIEFDSyB0aW1lb3V0LzINCj4+Pj4+PiAJICogYXMgYSBy
ZWFzb25hYmxlIGFwcHJveGltYXRpb24gZm9yIFJvQ0UgbmV0d29ya3MuDQo+Pj4+Pj4gCSAqLw0K
Pj4+Pj4+IC0Jcm91dGUtPnBhdGhfcmVjLT5wYWNrZXRfbGlmZV90aW1lID0gaWRfcHJpdi0+dGlt
ZW91dF9zZXQgPw0KPj4+Pj4+ICsJcm91dGUtPnBhdGhfcmVjLT5wYWNrZXRfbGlmZV90aW1lID0g
Z2V0X1RJTUVPVVRfU0VUKGlkX3ByaXYtPmZsYWdzKSA/DQo+Pj4+Pj4gCQlpZF9wcml2LT50aW1l
b3V0IC0gMSA6IENNQV9JQk9FX1BBQ0tFVF9MSUZFVElNRTsNCj4+Pj4+PiANCj4+Pj4+PiAJaWYg
KCFyb3V0ZS0+cGF0aF9yZWMtPm10dSkgew0KPj4+Pj4+IEBAIC00MTA3LDcgKzQxMDUsNyBAQCBz
dGF0aWMgaW50IGNtYV9jb25uZWN0X2l3KHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXYs
DQo+Pj4+Pj4gCQlyZXR1cm4gUFRSX0VSUihjbV9pZCk7DQo+Pj4+Pj4gDQo+Pj4+Pj4gCWNtX2lk
LT50b3MgPSBpZF9wcml2LT50b3M7DQo+Pj4+Pj4gLQljbV9pZC0+dG9zX3NldCA9IGlkX3ByaXYt
PnRvc19zZXQ7DQo+Pj4+Pj4gKwljbV9pZC0+dG9zX3NldCA9IGdldF9UT1NfU0VUKGlkX3ByaXYt
PmZsYWdzKTsNCj4+Pj4+PiAJaWRfcHJpdi0+Y21faWQuaXcgPSBjbV9pZDsNCj4+Pj4+PiANCj4+
Pj4+PiAJbWVtY3B5KCZjbV9pZC0+bG9jYWxfYWRkciwgY21hX3NyY19hZGRyKGlkX3ByaXYpLA0K
Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hX3ByaXYuaA0KPj4+Pj4+IGluZGV4IDVjNDYzZGEu
LjJjMTY5NGYgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21h
X3ByaXYuaA0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmgN
Cj4+Pj4+PiBAQCAtODIsMTEgKzgyLDkgQEAgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSB7DQo+Pj4+
Pj4gCXUzMgkJCXFrZXk7DQo+Pj4+Pj4gCXUzMgkJCXFwX251bTsNCj4+Pj4+PiAJdTMyCQkJb3B0
aW9uczsNCj4+Pj4+PiArCXVuc2lnbmVkIGxvbmcJCWZsYWdzOw0KPj4+Pj4+IAl1OAkJCXNycTsN
Cj4+Pj4+PiAJdTgJCQl0b3M7DQo+Pj4+Pj4gLQl1OAkJCXRvc19zZXQ6MTsNCj4+Pj4+PiAtCXU4
ICAgICAgICAgICAgICAgICAgICAgIHRpbWVvdXRfc2V0OjE7DQo+Pj4+Pj4gLQl1OAkJCW1pbl9y
bnJfdGltZXJfc2V0OjE7DQo+Pj4+Pj4gCXU4CQkJcmV1c2VhZGRyOw0KPj4+Pj4+IAl1OAkJCWFm
b25seTsNCj4+Pj4+PiAJdTgJCQl0aW1lb3V0Ow0KPj4+Pj4+IEBAIC0xMjcsNCArMTI1LDI4IEBA
IGludCBjbWFfc2V0X2RlZmF1bHRfcm9jZV90b3Moc3RydWN0IGNtYV9kZXZpY2UgKmRldiwgdTMy
IHBvcnQsDQo+Pj4+Pj4gCQkJICAgICB1OCBkZWZhdWx0X3JvY2VfdG9zKTsNCj4+Pj4+PiBzdHJ1
Y3QgaWJfZGV2aWNlICpjbWFfZ2V0X2liX2RldihzdHJ1Y3QgY21hX2RldmljZSAqZGV2KTsNCj4+
Pj4+PiANCj4+Pj4+PiArI2RlZmluZSBCSVRfQUNDRVNTX0ZVTkNUSU9OUyhiKQkJCQkJCQlcDQo+
Pj4+Pj4gKwlzdGF0aWMgaW5saW5lIHZvaWQgc2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdzKQkJ
CQlcDQo+Pj4+Pj4gKwl7CQkJCQkJCQkJXA0KPj4+Pj4+ICsJCS8qIHNldF9iaXQoKSBkb2VzIG5v
dCBpbXBseSBhIG1lbW9yeSBiYXJyaWVyICovCQkJXA0KPj4+Pj4+ICsJCXNtcF9tYl9fYmVmb3Jl
X2F0b21pYygpOwkJCQkJXA0KPj4+Pj4+ICsJCXNldF9iaXQoYiwgJmZsYWdzKTsJCQkJCQlcDQo+
Pj4+Pj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8J
CQlcDQo+Pj4+Pj4gKwkJc21wX21iX19hZnRlcl9hdG9taWMoKTsJCQkJCQlcDQo+Pj4+Pj4gKwl9
CQkJCQkJCQkJXA0KPj4+Pj4+ICsJc3RhdGljIGlubGluZSBib29sIGdldF8jI2IodW5zaWduZWQg
bG9uZyBmbGFncykJCQkJXA0KPj4+Pj4+ICsJewkJCQkJCQkJCVwNCj4+Pj4+PiArCQlyZXR1cm4g
dGVzdF9iaXQoYiwgJmZsYWdzKTsJCQkJCVwNCj4+Pj4+PiArCX0NCj4+Pj4+PiArDQo+Pj4+Pj4g
K2VudW0gY21faWRfZmxhZ19iaXRzIHsNCj4+Pj4gDQo+Pj4+IFRoaXMgc2hvdWxkIGJlIGNhbGxl
ZCBjbV9pZF9wcml2X2ZsYWdzX2JpdHMuDQo+Pj4+IA0KPj4+Pj4+ICsJVE9TX1NFVCwNCj4+Pj4+
PiArCVRJTUVPVVRfU0VULA0KPj4+Pj4+ICsJTUlOX1JOUl9USU1FUl9TRVQsDQo+Pj4+Pj4gK307
DQo+Pj4+Pj4gKw0KPj4+Pj4+ICtCSVRfQUNDRVNTX0ZVTkNUSU9OUyhUSU1FT1VUX1NFVCk7DQo+
Pj4+Pj4gK0JJVF9BQ0NFU1NfRlVOQ1RJT05TKFRPU19TRVQpOw0KPj4+Pj4+ICtCSVRfQUNDRVNT
X0ZVTkNUSU9OUyhNSU5fUk5SX1RJTUVSX1NFVCk7DQo+Pj4+PiANCj4+Pj4+IEkgd291bGQgcHJl
ZmVyIG9uZSBmdW5jdGlvbiB0aGF0IGhhcyBzYW1lIHN5bnRheCBhcyBzZXRfYml0KCkgaW5zdGVh
ZCBvZg0KPj4+Pj4gaW50cm9kdWNpbmcgdHdvIG5ldyB0aGF0IGJ1aWx0IHdpdGggbWFjcm9zLg0K
Pj4+Pj4gDQo+Pj4+PiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KPj4+Pj4gc3RhdGljIGlubGluZSBz
ZXRfYml0X21iKGxvbmcgbnIsIHVuc2lnbmVkIGxvbmcgKmZsYWdzKQ0KPj4+Pj4gew0KPj4+Pj4g
c21wX21iX19iZWZvcmVfYXRvbWljKCk7DQo+Pj4+PiBzZXRfYml0KG5yLCBmbGFncyk7IA0KPj4+
Pj4gc21wX21iX19hZnRlcl9hdG9taWMoKTsNCj4+Pj4+IH0NCj4+Pj4gDQo+Pj4+IE9LLiBJIHNo
b3VsZCBhbHNvIHByb2JhYmx5IG1vdmUgdGhpcyB0byBjbWEuYywgc2luY2UgaXQgaXMgbm90IHVz
ZWQgb3V0c2lkZSBjbWEuYz8NCj4+PiANCj4+PiBZZXMsIHBsZWFzZQ0KPj4+IA0KPj4+PiANCj4+
Pj4gQWxzbywgZG8geW91IHdhbnQgaXQgY2hlY2twYXRjaCBjbGVhbj8gVGhlbiBJIG5lZWQgdGhl
IC8qIHNldF9iaXQoKSBkb2VzIG5vdCBpbXBseSBhIG1lbW9yeSBiYXJyaWVyICovIGNvbW1lbnRz
Lg0KPj4+IA0KPj4+IEl0IGlzIGFsd2F5cyBzYWZlciB0byBzZW5kIGNoZWNrcGF0Y2ggY2xlYW4g
cGF0Y2hlcy4gVGhlIG1vc3QgaW1wb3J0YW50DQo+Pj4gcGFydCBpcyB0byBoYXZlIFc9MSBjbGVh
biBwYXRjaGVzLCBvdXIgc3Vic3lzdGVtIGlzIG9uZSB3YXJuaW5nIGF3YXkgZnJvbQ0KPj4+IGJl
aW5nIHdhcm5pbmdzLWZyZWUgb25lLg0KPj4+IA0KPj4+PiANCj4+Pj4gVGhhbmtzIGZvciB5b3Ug
cmV2aWV3LCBMZW9uLg0KPj4+IA0KPj4+IFRoYW5rIHlvdSBmb3IgbGlzdGVuaW5nIDopDQo+PiAN
Cj4+IEZyb20gY2hlY2twYXRjaDoNCj4+IA0KPj4gRVJST1I6IGlubGluZSBrZXl3b3JkIHNob3Vs
ZCBzaXQgYmV0d2VlbiBzdG9yYWdlIGNsYXNzIGFuZCB0eXBlDQo+PiAjNDc6IEZJTEU6IGRyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jOjUxOg0KPj4gK2lubGluZSBzdGF0aWMgdm9pZCBzZXRf
Yml0X21iKHVuc2lnbmVkIGxvbmcgbnIsIHVuc2lnbmVkIGxvbmcgKmZsYWdzKQ0KPj4gDQo+PiBG
cm9tIFc9MToNCj4+IA0KPj4gIENDIFtNXSAgL2hvbWUvaGJ1Z2dlL2dpdC9saW51eC11ZWsvZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvY21hLm8NCj4+IC9ob21lL2hidWdnZS9naXQvbGludXgtdWVr
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jOjUxOjE6IHdhcm5pbmc6IOKAmGlubGluZeKA
mSBpcyBub3QgYXQgYmVnaW5uaW5nIG9mIGRlY2xhcmF0aW9uIFstV29sZC1zdHlsZS1kZWNsYXJh
dGlvbl0NCj4+IHN0YXRpYyB2b2lkIGlubGluZSBzZXRfYml0X21iKHVuc2lnbmVkIGxvbmcgbnIs
IHVuc2lnbmVkIGxvbmcgKmZsYWdzKQ0KPj4gXn5+fn5+DQo+PiANCj4+IA0KPj4gd2hpY2ggb25l
IGRvIHlvdSBwcmVmZXI/DQo+IA0KPiBUaGUgb25lIHRoYXQgaXMgd3JpdHRlbiBpbiBDb2RpbmdT
dHlsZSAtIGRvIG5vdCB1c2UgaW5saW5lIGZ1bmN0aW9ucyBpbiAuYyBmaWxlLg0KPiBCVFcsIGl0
IGlzICJzdGF0aWMgaW5saW5lIHZvaWQgc2V0X2JpdF9tYiIgYW5kIG5vdCBhcyB5b3Ugd3JvdGUu
DQoNClN1cmUsIHJlbWVtYmVyIHNvbWV0aGluZyBhYm91dCB0aGUgImlubGluZSBkZWNlYXNlIiA6
LSkgT21pdHRlZCBpbmxpbmUgaW4gdGhlIHYyLiBUaGV5IGdvdCBpbmxpbmVkIGRlc3BpdGUgdGhh
dCwgb24geDg2XzY0Lg0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+PiAN
Cj4+IA0KPj4gSMOla29uDQo+PiANCj4+IA0KPj4+PiANCj4+Pj4gDQo+Pj4+IEjDpWtvbg0KPj4+
PiANCj4+Pj4+IA0KPj4+Pj4+ICsNCj4+Pj4+PiAjZW5kaWYgLyogX0NNQV9QUklWX0ggKi8NCj4+
Pj4+PiAtLSANCj4+Pj4+PiAxLjguMy4xDQoNCg==
