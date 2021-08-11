Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB33E91B8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhHKMlK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 08:41:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34234 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhHKMlJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 08:41:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BCarGE013228;
        Wed, 11 Aug 2021 12:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d6yIK8B7CKOJu7vYBma2O9JWRAgMZFc5IIXVBlM++IU=;
 b=mzEWtiJYtXrB4vXoxpejSZMGgqzQhii88wOCTK0pz8yIzX+HYGrcUelD9QVUULSrvkgv
 AL94pWrUwDTyVWLagAxMGM/Cqg49Yl4WUi8nApn9hoDjvKbrmOyGaiWv5kL6Jbo66Pae
 CR0ISsmED36xP8tyrjL03W9B9rNlAuAPES/HIYLzlUoqAfi82hy8UynktXeHpPqtnkRq
 RFPh5nxgvHU+xSif8QlM0Faxzc5+VH6M19qFSjt/L7wROnuvoL1ZscAZYl41Gx24ukZQ
 k1TtbP3kZWCxLSAbCYWBZdj9gCXHAdzdseP6wXZjdq1DDRvKB5+fiiWejXc6Xu4CdAZC LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=d6yIK8B7CKOJu7vYBma2O9JWRAgMZFc5IIXVBlM++IU=;
 b=cEAEip/aRv3KamIaZ4pu++fUZnHrpBdJwjZUQBVuZAkLvk4ndjwwpRA44Fwy7vSq/B9D
 t10i8g28I/G1cj3UD4fwKQwiDhWJs+4DGjkr7gwOxpVdNJUr72iCmhsBEwCoHCkJyjtq
 jlfW94/5RPsWQ/+zusC0JO+DW8fB5xoWIsOQW6x9YvAWInV35Xxq0x1dJwGR1q8JAs6X
 xSE5rqiaQPruynfO4Yc5O80Uinn72UMB7oni7LhaNkvAevjz3HW0Et75opIjMNM0c12t
 tzUR6ocTENZchV+jY8neLOpg6xMa1k2mHQNUY7Oc4RhgM4JP54Fad7rmYlMfIW73Qn0w Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd6486rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 12:40:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BCeYod160587;
        Wed, 11 Aug 2021 12:40:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3abx3vnx27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 12:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK4Z5XMWRp6iJG/FkgkiKKrBCsRFjSB4OGUPjfja98viLgwHcOYZsQ9r8Ptx19CQTcD/FfVX2QmdU4AhuutxUhGzj2CPm/7nNa1MPilhGKEZn3Fh4AZ2h2LfW1fPNWI2vKqpLMP8jUhXv+0KEKYWEFKEjT/mPfBks4fogqZbIF3AHZcZPX5Mqz7a1Be5yfgaxpO2G3tq3ySynh0LoNilURea25UKpNZ4Jtp8Xlkd6UmODYVMhQIkWxivkv7aEDBD6kvcrNGfHrc25E82RJ17nB85h+ro1PdAL2wI5Z/iwmhS1WL/c5CGaTJUfn/rgO9fUjS0ueHqRfP+x2KGMX/G5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6yIK8B7CKOJu7vYBma2O9JWRAgMZFc5IIXVBlM++IU=;
 b=fCzsA1ah54DkJWd27Rn/svJ3tydZ8nuqlIfCsb5+aoEimPfE4FJDta8GbwkThG1eJu3ht/ur4c/W3EAcjlCFxflafmj6HADjigER3WjHO5Xf8cSiNC/Y35e9W7v/5ZRIQ5dVemEirmpztPmNKC/jEBQDr1ZI+9SPaVQ9QNchWXtWREZNCZLIcRwTQ3WXgfVK3CRRQsNpw3iO/fsIfyVwbYnCX52zWOZ73MAPs26TcSwxbxm28NIbfV693bjwrjkBuZ7LVoNd/BbN0FDOuOnweP0cBZcdbAIIMWGHSdq+6UpVzCW0tBLNjUP6F8ZoiRML6DfkHsJZuj5qEcB8yAtoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6yIK8B7CKOJu7vYBma2O9JWRAgMZFc5IIXVBlM++IU=;
 b=Qx85ZqX421oybQQqByS6sIRrrj+clTIwtOJHaHy/+fE2vTWZ4fYY4fBhMBrNbzmEdHP1JDICHR2O0zCFtqkBFMfK2yySV0mS6TtIPtlTvVuuxBDnylBUJAx1YGZxDGDenAQ27qJsuM3WaqQF3w1jaEFudpdqNcuxkIcHZu8FVYI=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB3755.namprd10.prod.outlook.com (2603:10b6:5:1d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Wed, 11 Aug
 2021 12:40:37 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 12:40:37 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/core/sa_query: Remove unused function
Thread-Topic: [PATCH for-next] RDMA/core/sa_query: Remove unused function
Thread-Index: AQHXjqxt9qMbRj1JF0qtHFzvVfb4CatuPM+AgAACAYA=
Date:   Wed, 11 Aug 2021 12:40:36 +0000
Message-ID: <6FFA7D21-2B84-4B45-B215-F893B49393AB@oracle.com>
References: <1628684831-26981-1-git-send-email-haakon.bugge@oracle.com>
 <YRPDlTHjagRUqtOS@unreal>
In-Reply-To: <YRPDlTHjagRUqtOS@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac9a0d0-4de8-41fe-3640-08d95cc53831
x-ms-traffictypediagnostic: DM6PR10MB3755:
x-microsoft-antispam-prvs: <DM6PR10MB3755598A3374ACC8ADA483B4FDF89@DM6PR10MB3755.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MpH1XAzgFoIoWSdUVjbc/J0O332UaKzYBg1SGjGhZYo1EH5nNfq+PsIsCegBZbH5mtpSo9yxQPzTopwS9dmAjZSgHfq2r2OJRk74orcxXfM4+KzzBpy4MzJ86NDraHNyrVQi6lm6g2kzTj+5SNiSF2/orChFYB+nsMEqBTY98pobyO61ZjnYJr7b6Jve9SWsQGuGVOW0RUjtWFPlkUwQtYI8ey2SLjCzvHtCAamoTbo0mBFQxT1htZkyAFzLvjHOPmXZVtK+qJtgB0GmwHU+ZIDiazSG6msOkncRoWOg5kBxOoT9EZP5sIfD0osNIYRtKkKnii+3kiVh911KctidQqI07rTsEDdVmWoPnSCa+BYDANVN1GIEGEBVxx7XIQ1ymdIwzGZ/kAknEWR1gJNc0PknGTKBxe4/y1rUi9wIxpPJ9wyUyNeWQKTGDrqzNE6EXJrYtCH8JQ38bajbAFW5qKwQ4lXH/kjnkbf8lvlN2IarttnmIbb11wSGoomHx2pgb3ItLNI9bmK4aukeVnU5/agFlwrPtoHA8DgTpcwr3xndySkr2/+6ALnoTX+1VVvEh3TubVJLH4W4wTZoG798ENb8pAhbniS4vN80oCVfmcvrNk4u+GMf0H+amecPt5PkDRx58qAKvXmR/LvsGe7G454hoxpQcxNEKMB5tQGYRSbsGnPqH2/EZyJ29uZDJDdGI1byzuNm3TLjAmqZGrGPXGvUPgXHX5+0026sUVXr6fX5+w53YC6CHer9C8r7ZdZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(91956017)(6506007)(83380400001)(508600001)(8936002)(26005)(4326008)(33656002)(6512007)(66946007)(53546011)(86362001)(5660300002)(4744005)(2616005)(122000001)(54906003)(6486002)(2906002)(38070700005)(64756008)(66476007)(6916009)(38100700002)(71200400001)(8676002)(316002)(66556008)(44832011)(66446008)(186003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3dwbE1lUC9wN3FoZUZnQ2dDT3hubVVJM3pUSWZ4aTBrUWtLV1BEdDQ2MnJu?=
 =?utf-8?B?M040M3Q5a0UzRFMxWVRLOHlud3R6cFhiSGJKdVNCd1RCekRyRjB5ZXVEK2dj?=
 =?utf-8?B?SUJBR3ZPTjg4UEFlSWlwZGR1bHlnUVRqN2Z0S05WU3V2bEREc3VnN1djQ29o?=
 =?utf-8?B?L0NBd2NCUFNyM3dWYko2SkJkTnR5TTBlZkp1bmorK2xYemdnYi83K0V4UGhS?=
 =?utf-8?B?aTlURkhjWVFNQmQwdXJzbkRQazNVVkthcGVvakh3NkRSejVoWmtSRnRLOEt4?=
 =?utf-8?B?Q2VGL3Ria05nRnZ4Y1UxVDN4WXRpZXM5STZHeW54MjRUQ0x6RUprOVBtRGw3?=
 =?utf-8?B?L3IyYldkcmFFZ0J0L0hUTUFXdFNQbzNTYjJwU1VwY1BFRnBkOW1ORTlBQTE1?=
 =?utf-8?B?azkwUlZZU3p0WCt0SG9KcVczaTdsTEJzdXdHT0d4QThFaDI0MVZzVkkzVmhz?=
 =?utf-8?B?UlRTSkVLcjB4ektZUGxlUkQwSzhDQW5LdGI2WnhJbDVFNUZaTVpTVk9mUVlG?=
 =?utf-8?B?Si96SjN2WFdLRDVKbElPUDl3UTBoZ3VEaURzbkVUZk9qVFRKUXdQeGx0MXdS?=
 =?utf-8?B?a2dIQW0wL0xaOHBqanI2eXVYU1VmY25KK3luNk53aVhlR3lDbFBwUXFuOWhF?=
 =?utf-8?B?REZadkJPcFp2WmlYTVFoVGFQTUwyTFNHcmxORkJPQ3g3dFNuOUVla3JnOEtI?=
 =?utf-8?B?akgvQUp6SkdXY2pIY3lrMXVxbEpxemdyUkZHRXlibFdMbFB1M1AxQksyVDFy?=
 =?utf-8?B?VFVidWlsUkRmV3hheDJ1eDNuSVFEMDRFWHBjeWRUa3lVQU45bmdUa21xazY0?=
 =?utf-8?B?TTZPWVlZNXltRmpoQTRJOGhoMUJnazJ0KzV3Y1ZNcUFoK1RKcW1DdTUyaXZ5?=
 =?utf-8?B?MUZxUzQ4bk4xL1RIampwZE5uYkF2RVI1a3RpcENzQWNVTW5LYlBOdEU2ZThG?=
 =?utf-8?B?RmZYZUZyS21wTFo4bWRiRTcvTENZVXJOVXovcGlDTW1MRk51MjRJaFc0NHIv?=
 =?utf-8?B?ZjRsc0hOTk1NOE1UNHFaWExGM2MxVHl6eEk2Y241ZER3Q2ZQNHpqZWdrNWJ4?=
 =?utf-8?B?TU44MUt6azRHelVNS2lnb2h4T3ZkWHlRV1c3QlhkN05LMmU1ME01TVZnMWd0?=
 =?utf-8?B?cmN3ZHhzOCtvVU82djR3ck1RVUdiMEFlbllpc2tOeEJ5K3VEemR3a2FXYjht?=
 =?utf-8?B?S2FlZ2NEQVFvckgzRFFhNm16ekJtdEJ2MzJjaU1FckVDTTJmUmI4c3ZrSGlF?=
 =?utf-8?B?YzZMVDBxQ3JWSUwvRENQVTAzWnArNkxlMmtZUGxDcUF3VWw3V1h3MlhtcUFG?=
 =?utf-8?B?WVRpZ0Yrbk9oYk5JL2V6RkVkTHppUHhTUXRFSi9XYlRrdldGYU1CeFFkbkNY?=
 =?utf-8?B?Q2JyajRxS1hIcFl6a3h0UENHQ2VRME5lcUlPR3BicGpSWUJZdGFrbTFLQmJY?=
 =?utf-8?B?aHZMYkVxeUl3YXRFWWhXMG51ZWhkRkZTa2tuUU5ndEJiT2Fhd1VSb2xqYUsw?=
 =?utf-8?B?SGI2NHdxN3RDZXBNekNpc3hIMEVXMjNZR3hwUHFjcGFqWHJHNlFHQmJ1emQ0?=
 =?utf-8?B?NXJwRjRTa0ZHNXA0MS95TmFFc2hnT2F4d29VL0E1S1FNWktkNmM1S0wxOUxz?=
 =?utf-8?B?TUEvcnNaWHdRZWpoYlFJdWx1aHdIZkZwK2VIeWlOOHhnU0xNNm43QzlPa01V?=
 =?utf-8?B?QXVUaU43TmUzS2RHOGd5Qk56Wm8ycjNCM0MrSk1BVndvWGN2L3B2eFptaDFj?=
 =?utf-8?B?SDRmWTlCZVkwYkc3QjVxVGROZHN2RG1MQlhvZXJSaThVTmtrUWFzTG45Z25p?=
 =?utf-8?B?RFJ1UXE2RWtWdkJpM0g2dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD1DB2FD79DDD8429908695EC3964541@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac9a0d0-4de8-41fe-3640-08d95cc53831
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 12:40:36.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouF3dGneDiltooFQtHPoh9lF3E4UZKXHbscDQh9UBngNYzk687Aik/jEqzpV4hNw8jCH4w5VFZ6ruGqS/gKoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3755
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110086
X-Proofpoint-GUID: vGRZMwvmyyKwwOGU3x-oXCnZavfkyIEc
X-Proofpoint-ORIG-GUID: vGRZMwvmyyKwwOGU3x-oXCnZavfkyIEc
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgQXVnIDIwMjEsIGF0IDE0OjMzLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAwMjoyNzoxMVBN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBpYl9zYV9zZXJ2aWNlX3JlY19xdWVyeSgp
IHdhcyBpbnRyb2R1Y2VkIGluIGtlcm5lbCB2Mi42LjEzIGJ5IGNvbW1pdA0KPj4gY2JhZTMyYzU2
MzE0ICgiW1BBVENIXSBJQjogQWRkIFNlcnZpY2UgUmVjb3JkIHN1cHBvcnQgdG8gU0EgY2xpZW50
IikNCj4+IGluIDIwMDUuIEl0IHdhcyBub3QgdXNlZCB0aGVuIGFuZCBoYXZlIG5ldmVyIGJlZW4g
dXNlZCBzaW5jZS4NCj4+IA0KPj4gUmVtb3ZpbmcgaXQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL3NhX3F1ZXJ5LmMgfCAxMDEgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4gaW5jbHVkZS9yZG1hL2liX3NhLmggICAgICAgICAgICAgICB8
ICAxMCAtLS0tDQo+PiAyIGZpbGVzIGNoYW5nZWQsIDExMSBkZWxldGlvbnMoLSkNCj4gDQo+IFlv
dSBzaG91bGRuJ3Qgc3RvcCB0aGVyZSBhbmQgcmVtb3ZlIGliX3NhX3NlcnZpY2VfcmVjX2NhbGxi
YWNrLA0KPiBpYl9zYV9zZXJ2aWNlX3JlY19yZWxlYXNlLCBpYl9zYV9zZXJ2aWNlX3F1ZXJ5IGFu
ZCBwcm9iYWJseQ0KPiBpYl9zYV9zZXJ2aWNlX3JlYy4NCg0KSSBjaGVja2VkIGFsbCBmdW5jdGlv
bnMgY2FsbGVkIGZyb20gaWJfc2Ffc2VydmljZV9yZWNfcXVlcnkoKSB3ZXJlIHVzZWQgZWxzZXdo
ZXJlLCBhbmQgdGhleSB3ZXJlIGluZGVlZC4gQnV0IG92ZXJsb29rZWQgdGhlIGZ1bmN0aW9uIGFz
c2lnbm1lbnRzIDotKSBUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4gQSB2MiB3aWxsIGZvbGxv
dy4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K
