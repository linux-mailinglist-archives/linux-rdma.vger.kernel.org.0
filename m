Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375383F4AA0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhHWM0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 08:26:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24740 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233755AbhHWM0b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 08:26:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NBmx5I006614;
        Mon, 23 Aug 2021 12:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LRMhOghatRH/JhGc0HXJxJqkDTVuKaEnix4LqrrT2Wo=;
 b=g/VTBRLe5Qmf7M1KXChytj8IilsIsd0jp7SXETjs7lYjfv17IPZjf4lVdmnyE9T4v4RQ
 5vsBXoqDwhkzuI2UBpEglsgN1CYkBmDaLNL/8rRpJm+jtsnqq0uUR2WH+vHKQMjvuKSV
 NMMyYm7JboEcyfSDCfC2AXFxwiTuRc2Il72xQrijli7SWqfIwgTlOSxZLH5eAp3BtIcc
 9cG9AYPEe/b3AA8wmeWUZpHvD7pT0aVS348BZGtS+K7E1JoTYVp2J2giLdifM+bVfs9a
 B2x8xFDdy/w0fL0Luyt7dliOlrD3L6oYsblex5V+jBpXGZgg+jVarvsCNrCEqEwrozwc 7A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LRMhOghatRH/JhGc0HXJxJqkDTVuKaEnix4LqrrT2Wo=;
 b=wi1QozjFOiezXJ8Ouxz+dysexmuXYIiHX4L3CZIkXcTFk+DQmDIus7VNQoZA1/0wdgYA
 lUx+XaiOt2zaD+jjRmaHrJVzz5fMPZOh5Lk2O7Ts1oio5VP/JVrC61HBA4oyGGHmMDSk
 iPZJzWoS6r6ZGGMIEMhtpT1FJeSR9ubCGob0GCcldUs1lDIstJZC1qMwraJw55c4QAZw
 JZPw0EavMy++AP16zA1o8LuLnTltB2H31GYY+a4ZlJBshMyAFenPR3Rz/JUMRgHpKt0R
 jEVzSU3HT+QZmkeusxEwy9yzAIaaDlZrlU3Kh664+//uPKotbm1p9rcP6gpM2sWqT3zp Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrtse6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 12:25:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NCLHpm057268;
        Mon, 23 Aug 2021 12:25:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3ajqhck5uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 12:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5DNWaOpR1/7JiZu6PNC/v+PpE+9q/C5hzBojFnrbtTboiHg9J6MmCfVwsXtYsMP6RhkP+Tu9ZjKhr52hq8pIQyF4E1h4idKFWuOIxPQz4TXRsOYSSTcoTg8Bl9CHae+KQ6b7fhkGiNqL4XoRm+xVuoI7BMTJFDACtJEPU/3ntRaWXebfac7J+KX5KZuQS4YvGeYazFX0a5oN4NsJrJXK88A+RetVjOUfCnJijax1H7n8y0PBEZseFkZTNF4IiXC2TcCEVGb7u3iQVSQVtMW4mUjWLx8OhjtfFYUqULuW66fahPZYVfzOnNQdAgGfSo3eSmK8rftuazxKBikNYbuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRMhOghatRH/JhGc0HXJxJqkDTVuKaEnix4LqrrT2Wo=;
 b=bOnw5GZ4wrbb0JOZZtbPQcdJpdZGVeBp8OcRJ5PxDBCG/b+MILExOaNxsr8P222urfsWlioVP3pRfcdIm4L2eD8KCT3ITFv6oeztY2eiNekW2y6yGsrUFz+vRigdt/tjKPF+aTnhcmmNuC9Xk4wgwtdWdHB0IRp3QycJXsg94N/I/BB1/p4GmOkBcdW4LewyhidkqlDSbB8Zfi7IDS2XzKfJVWFip7BsiMzmIh6OIVDPNGNdr56xgg3IKy7yARnBsWijMKTqDUw8BaYuF6MukQKiJTbHCkXgzFx17qPHGqYgJfIn5s22UAT5bmE6cVv56ST+XXq9XpbbwvS7GouGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRMhOghatRH/JhGc0HXJxJqkDTVuKaEnix4LqrrT2Wo=;
 b=IUbg+/3OCGMtejay08IcVOn5gSqZ37sOAbRz2FWbjqcXkqq7lIyrRiIeEqthPiQ8SQzVBNItb4IoDfDURyHZZUGbQMnRTqpc1AkcV0rDR1//Wuls4Lnz1eafFAtyuTK3DgoS8wtQDMweaLrXTBBhvor+P8JZUdGci8KPu76uK44=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB1676.namprd10.prod.outlook.com (2603:10b6:4:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Mon, 23 Aug 2021 12:25:44 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 12:25:44 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Thread-Topic: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Thread-Index: AQHXj5U1pGh4t5fRsUGkipTXxVNmY6uBFNGA
Date:   Mon, 23 Aug 2021 12:25:43 +0000
Message-ID: <A38C0646-66F9-4470-9ECB-616BC98B6C81@oracle.com>
References: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac0f8c8f-8dd8-4212-a00b-08d9663120ec
x-ms-traffictypediagnostic: DM5PR10MB1676:
x-microsoft-antispam-prvs: <DM5PR10MB1676EEE1A6DFC179604618A1FDC49@DM5PR10MB1676.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbzSMlHtEAqVkpSg0LKAW/hOlrop6la2hfiI5PrPrAojwSVtTyYyG5eLp3AO3wgPEqmuBV2PaLR+vxOgKuHwnMvR2qpzEnAS15xKDM9aInWzI/lymIaqKn6J/lPIZgleooCwuc8/UCmMnEEyEcO+0MeyjftMjfYaTPgso/q1/H/vE0N5AtNb85LpFmc7h8EyO9/EBF6l8ioIgGYCPYICilv7B/tpurOe9oyRjt6pNZVZtIRBqq+i4jYXke2pr837U9SQbK8xd7j1NI6JH9K+97bHe51DfUtmgXCFD6hDFRWHAC7jpeaL3Pzfu2kUq614pAkxfknv78pvqyr9O+bZQltnFIUe2ClFGw7JdGLLbUlCbCvawL+bvT0eR9J542+Six+5OE5yXKoRfylHpLswFfgJ118uh74/BpNtoXgOor0wa+mWQ9lfSOUglWmk8DUNPflyfrsSPqT7QehbFUbXQqOg7seTelFa6fQWtu/sbDsHToWYtPqgBL/MDT8av/yFkg4Rzhoud09HM+OtQAZJZE5zMB5VT80oJSgMaVkE2APBjzx9H1r+jR/adimxxJySw7+E9QV2VtdQwDVb8BJR3jvzERWq9Nf3E1cGLfZ+Oy3qdxoVr85td7TrZNi+wCjf6ShhF5iTzqbi1fagEB9MJ8LGBgQeMlp4oTiQORGMwxIW4DKyhk4WcZv6hl2v+pCyd6WkfgQ02ffO3B1Vn8fVVOXc7+xz8kZVTR56lIKotjGuBTOaNkamc1E2QDSjQ0qR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39860400002)(6506007)(6486002)(66476007)(53546011)(76116006)(86362001)(8676002)(66556008)(26005)(66446008)(5660300002)(91956017)(66946007)(316002)(64756008)(110136005)(36756003)(478600001)(71200400001)(8936002)(44832011)(2906002)(122000001)(6512007)(2616005)(83380400001)(66574015)(38100700002)(38070700005)(33656002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0pjS2JIL3huMnVZQTRzcmJDUmFFaHNYOG83OFUvNzczbmhZbXJrdU1pbDVu?=
 =?utf-8?B?Y0lmcDQzNW5JUllrQnh5cWJUbDkyaWx0ekxJK0xRUUdBeHRDNzkwdzFlUVNP?=
 =?utf-8?B?c2RpTmpPK3dBK1ZoYTBZRWJTSlMwSkJUcXBBUlBzRWF5a08vdStZU3RtZ2VY?=
 =?utf-8?B?L3djT1V4QTlQSFJuZzhqRjI3UURqelN2NjhaeElKNWtuMzg5d2c2OHFUYUF2?=
 =?utf-8?B?bUhwdEs0NFUzZGFtVFd0MXNUVktCUEszMEZjSkpJK2dXS0dIUHptQmJ0eld1?=
 =?utf-8?B?WG1ZemJFc05SeVdXczRjWW44SlB0YXBDQmFVNUpxUG9yR1FNbVB3UWt3Q0pJ?=
 =?utf-8?B?SEFzcWxkSG5weEFUc1lSaUxTcDluOVF4ZFVndU1rbUsyK0wxa1dsM1hocEJy?=
 =?utf-8?B?NFltSWFYcXUvclExM0FYQVlpSTdWNkRhN0hOdTlvek10NE4wL3B3Qk9Zald3?=
 =?utf-8?B?V216bG5BN1JhUy9lY0h0QlhWN2ErMDVhZFNLWUl2SkZCWG94UGpydzVMWTZN?=
 =?utf-8?B?eDl5VFk5dTFrZTQvMGZjdlJ4cmVuaGxFdDkrbXExS2N5cWVDbXlyK20zZVdy?=
 =?utf-8?B?aW9ZV0xuTU8wSDBxM3FId29ac1I1d3BXUlZqb2lBNE1zOCtYT0dFN1d1ZkdP?=
 =?utf-8?B?YzZEeXNGUUV1ejgyWTZBRll6aElkcUZHemRQS0pUc3l6U1lpMVFFUnNzbVZq?=
 =?utf-8?B?aUVtMnIwQ3BvUlRLcks5MDhBZE1DclRnenpLaGNJZ2MzUHhPY1M0MHFFN3M5?=
 =?utf-8?B?N1FUYUdQTWw4ODg0NElDNnpySGI1dHZsNGVyblFreEk1K1JCM0ZWemozZHNV?=
 =?utf-8?B?ODZWTkVPbVFrd096VjJ0ODF5cnN6VkcrU1ZXemN2aDFxSjZPZEpjbERZT3Yw?=
 =?utf-8?B?U1RtRHBEUHhTZVVwWjVyNXJUdUR3TUpaQ1dSN1o4MjJWU0NHbkY4anlsUGpD?=
 =?utf-8?B?Wks0NWNrUlVwekQrTUNYeGF2UGNOaHZwaUd6S29vekhIK0tFWFdLMXVGVTJ6?=
 =?utf-8?B?WVkvQlZIT2ZSWmR4UUxlQWVPbXdMSmcxMThkdHVGS0x0WVhyZkZKYVNpVVM0?=
 =?utf-8?B?MXRsemx3dE9wc2lMblJQYVFtb1Jua1N2V0p1TkxQWVJGT05aN0pNbVdRdjR6?=
 =?utf-8?B?MjhOYVdZMTE2WnVYYlZwNDBzbjFnaGN3WTk0TndaSmVRVTVDZWIyd0ozQzNY?=
 =?utf-8?B?NGFrU3JONEpyYW9QaUo5T01DK2d5VmNxSzIvVFBtN3JoK3BySXZHTkdtbkcx?=
 =?utf-8?B?d1JNZ2lLRW5hN1doTzJKblRGcmxiTDZrT0JZemV4ZnRYbURpYU03ejdaVi8x?=
 =?utf-8?B?eEQyZ3c3dCsxZkI1NC96UjZiR3VoUkdnaVZ0am93WEJNRURvYnM5TWhVNTl4?=
 =?utf-8?B?R1NZZmNabVd6Y2JnS0xBZ25SbllxblEzMzcvV250bkRqQ1U2K0V6b25jMHE5?=
 =?utf-8?B?d2JNSlZYNzI4YW9JL090SVlFLys2dkk1UkRGeWhKMVYzVkx6Q1pZQ2hmbHpR?=
 =?utf-8?B?dlZmcXlQT1cxQTJkcUdNS0NCOFROemppbFR0NXFGMWZkVVNpWE9TVU53dHVD?=
 =?utf-8?B?RmdkK2N1YXVCeWROVzdwUFZIWVN0Z2pnTkZoclZHYzNuaHhYMWt0dnlDajFu?=
 =?utf-8?B?dFhCelNvc1hWcHp5dUNBRVdMSHM4d0FGWVVWUzl0L1AwRjdEck9tNzNxWG5l?=
 =?utf-8?B?ZmRJWHBtVGpaWEFQcStveWUxaDVOYkMwZmVidFprT1FNb3oxZitzUUlGRGdE?=
 =?utf-8?B?OTBoMDVUZ3BsUzIzTzV5Smo4R2w4R0VXd2k3Z3pyMDYwamszZEtkQUdkRzht?=
 =?utf-8?B?bGpHeVFMZHkzRHlQRFdtZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <808C0691157D544E8C497774DAF9E9DE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0f8c8f-8dd8-4212-a00b-08d9663120ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 12:25:44.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y6xXdIDsfHCEjWmJfnXOejF5oAWzlNJTBnFsT0Xc8gd4hskit+QXXJKs0BAxpVt19Tx4y0PEYqEvTUqVvY3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1676
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230084
X-Proofpoint-GUID: jGKhY1Xa8RfzX1mnES1mEZb1Uv2TDU_8
X-Proofpoint-ORIG-GUID: jGKhY1Xa8RfzX1mnES1mEZb1Uv2TDU_8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QSBnZW50bGUgcGluZyBvbiB0aGlzIG9uZS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+IE9uIDEy
IEF1ZyAyMDIxLCBhdCAxODoxMiwgSMOla29uIEJ1Z2dlIDxIYWFrb24uQnVnZ2VAb3JhY2xlLmNv
bT4gd3JvdGU6DQo+IA0KPiBBIE1BRCBwYWNrZXQgaXMgc2VudCBhcyBhbiB1bnJlbGlhYmxlIGRh
dGFncmFtIChVRCkuIFNBIHJlcXVlc3RzIGFyZQ0KPiBzZW50IGFzIE1BRCBwYWNrZXRzLiBBcyBz
dWNoLCBTQSByZXF1ZXN0cyBvciByZXNwb25zZXMgbWF5IGJlIHNpbGVudGx5DQo+IGRyb3BwZWQu
DQo+IA0KPiBJQiBDb3JlJ3MgTUFEIGxheWVyIGhhcyBhIHRpbWVvdXQgYW5kIHJldHJ5IG1lY2hh
bmlzbSwgd2hpY2ggYW1vbmdzdA0KPiBvdGhlciwgaXMgdXNlZCBieSBSRE1BIENNLiBCdXQgaXQg
aXMgbm90IHVzZWQgYnkgU0EgcXVlcmllcy4gVGhlIGxhY2sNCj4gb2YgcmV0cmllcyBvZiBTQSBx
dWVyaWVzIGxlYWRzIHRvIGxvbmcgc3BlY2lmaWVkIHRpbWVvdXQsIGFuZCBlcnJvcg0KPiBiZWlu
ZyByZXR1cm5lZCBpbiBjYXNlIG9mIHBhY2tldCBsb3NzLiBUaGUgVUxQIG9yIHVzZXItbGFuZCBw
cm9jZXNzDQo+IGhhcyB0byBwZXJmb3JtIHRoZSByZXRyeS4NCj4gDQo+IEZpeCB0aGlzIGJ5IHRh
a2luZyBhZHZhbnRhZ2Ugb2YgdGhlIE1BRCBsYXllcidzIHJldHJ5IG1lY2hhbmlzbS4NCj4gDQo+
IEZpcnN0LCBhIGNoZWNrIGFnYWluc3QgYSB6ZXJvIHRpbWVvdXQgaXMgYWRkZWQgaW4NCj4gcmRt
YV9yZXNvbHZlX3JvdXRlKCkuIEluIHNlbmRfbWFkKCksIHdlIHNldCB0aGUgTUFEIGxheWVyIHRp
bWVvdXQgdG8NCj4gb25lIHRlbnRoIG9mIHRoZSBzcGVjaWZpZWQgdGltZW91dCBhbmQgdGhlIG51
bWJlciBvZiByZXRyaWVzIHRvDQo+IDEwLiBUaGUgc3BlY2lhbCBjYXNlIHdoZW4gdGltZW91dCBp
cyBsZXNzIHRoYW4gMTAgaXMgaGFuZGxlZC4NCj4gDQo+IFdpdGggdGhpcyBmaXg6DQo+IA0KPiAj
IHVjbWF0b3NlIC1jIDEwMDAgLVMgMTAyNCAtQyAxDQo+IA0KPiBydW5zIHN0YWJsZSBvbiBhbiBJ
bmZpbmliYW5kIGZhYnJpYy4gV2l0aG91dCB0aGlzIGZpeCwgd2Ugc2VlIGFuDQo+IGludGVybWl0
dGVudCBiZWhhdmlvciBhbmQgaXQgZXJyb3JzIG91dCB3aXRoOg0KPiANCj4gY21hdG9zZTogZXZl
bnQ6IFJETUFfQ01fRVZFTlRfUk9VVEVfRVJST1IsIGVycm9yOiAtMTEwDQo+IA0KPiAoMTEwIGlz
IEVUSU1FRE9VVCkNCj4gDQo+IEZpeGVzOiBmNzViN2E1Mjk0OTQgKCJbUEFUQ0hdIElCOiBBZGQg
YXV0b21hdGljIHJldHJpZXMgdG8gTUFEIGxheWVyIikNCj4gU2lnbmVkLW9mZi1ieTogSMOla29u
IEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5jICAgICAgfCAzICsrKw0KPiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9z
YV9xdWVyeS5jIHwgOSArKysrKysrKy0NCj4gMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY21hLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiBpbmRleCA1MTVh
N2U5Li5jM2YyZmFjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEu
Yw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYw0KPiBAQCAtMzExNyw2ICsz
MTE3LDkgQEAgaW50IHJkbWFfcmVzb2x2ZV9yb3V0ZShzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHVu
c2lnbmVkIGxvbmcgdGltZW91dF9tcykNCj4gCXN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3By
aXY7DQo+IAlpbnQgcmV0Ow0KPiANCj4gKwlpZiAoIXRpbWVvdXRfbXMpDQo+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiArDQo+IAlpZF9wcml2ID0gY29udGFpbmVyX29mKGlkLCBzdHJ1Y3QgcmRtYV9p
ZF9wcml2YXRlLCBpZCk7DQo+IAlpZiAoIWNtYV9jb21wX2V4Y2goaWRfcHJpdiwgUkRNQV9DTV9B
RERSX1JFU09MVkVELCBSRE1BX0NNX1JPVVRFX1FVRVJZKSkNCj4gCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NhX3F1ZXJ5LmMgYi9kcml2
ZXJzL2luZmluaWJhbmQvY29yZS9zYV9xdWVyeS5jDQo+IGluZGV4IGI2MTU3NmYuLjVhNTYwODIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NhX3F1ZXJ5LmMNCj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvc2FfcXVlcnkuYw0KPiBAQCAtMTM1OCw2ICsxMzU4
LDcgQEAgc3RhdGljIGludCBzZW5kX21hZChzdHJ1Y3QgaWJfc2FfcXVlcnkgKnF1ZXJ5LCB1bnNp
Z25lZCBsb25nIHRpbWVvdXRfbXMsDQo+IHsNCj4gCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IAlp
bnQgcmV0LCBpZDsNCj4gKwljb25zdCBpbnQgbm1icl9zYV9xdWVyeV9yZXRyaWVzID0gMTA7DQo+
IA0KPiAJeGFfbG9ja19pcnFzYXZlKCZxdWVyaWVzLCBmbGFncyk7DQo+IAlyZXQgPSBfX3hhX2Fs
bG9jKCZxdWVyaWVzLCAmaWQsIHF1ZXJ5LCB4YV9saW1pdF8zMmIsIGdmcF9tYXNrKTsNCj4gQEAg
LTEzNjUsNyArMTM2NiwxMyBAQCBzdGF0aWMgaW50IHNlbmRfbWFkKHN0cnVjdCBpYl9zYV9xdWVy
eSAqcXVlcnksIHVuc2lnbmVkIGxvbmcgdGltZW91dF9tcywNCj4gCWlmIChyZXQgPCAwKQ0KPiAJ
CXJldHVybiByZXQ7DQo+IA0KPiAtCXF1ZXJ5LT5tYWRfYnVmLT50aW1lb3V0X21zICA9IHRpbWVv
dXRfbXM7DQo+ICsJcXVlcnktPm1hZF9idWYtPnRpbWVvdXRfbXMgID0gdGltZW91dF9tcyAvIG5t
YnJfc2FfcXVlcnlfcmV0cmllczsNCj4gKwlxdWVyeS0+bWFkX2J1Zi0+cmV0cmllcyA9IG5tYnJf
c2FfcXVlcnlfcmV0cmllczsNCj4gKwlpZiAoIXF1ZXJ5LT5tYWRfYnVmLT50aW1lb3V0X21zKSB7
DQo+ICsJCS8qIFNwZWNpYWwgY2FzZSwgdmVyeSBzbWFsbCB0aW1lb3V0X21zICovDQo+ICsJCXF1
ZXJ5LT5tYWRfYnVmLT50aW1lb3V0X21zID0gMTsNCj4gKwkJcXVlcnktPm1hZF9idWYtPnJldHJp
ZXMgPSB0aW1lb3V0X21zOw0KPiArCX0NCj4gCXF1ZXJ5LT5tYWRfYnVmLT5jb250ZXh0WzBdID0g
cXVlcnk7DQo+IAlxdWVyeS0+aWQgPSBpZDsNCj4gDQo+IC0tIA0KPiAxLjguMy4xDQo+IA0KDQo=
