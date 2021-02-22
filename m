Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FED321CF0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBVQ22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:28:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhBVQ1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 11:27:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGIOvf073002;
        Mon, 22 Feb 2021 16:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=N2JHoNooTc/nQcbR0Mo3zUXxbgkBPc1tT4z5ZDDCFkI=;
 b=pbIMM7wIdMSqLLSVaAc1IvRPs+KrugXWP+l8CqxrFOEMogg9uAlRjPeOU/4qIyzJub/l
 H/px6A6jD9+u0JJo9jFidfH4tUrdwJaLD9fx0wxxBqk13UUEGR2lJTI4XSz6LJt0VN6v
 iwvAeW60m9AiZeLuiLSKQls893un/ZQNAeQSRSr+P9x8r/ZpYIbaMpgL91DRN6vUbO+c
 8F/PX2pBdsYdx/BWGPXtVknAlP0wu419ZqTbUK97OqgAKwL6YcoDURCkJSinsn6GqJQe
 nlCV6kniuAgxU6ZUQC8HfZy7Fa9MwikvVbzlNPrq6Np7XFjZidIm+wguEW6X3cnqUjxi qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3b3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:26:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MGK3QP142202;
        Mon, 22 Feb 2021 16:26:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by userp3020.oracle.com with ESMTP id 36uc6qk790-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeFWc7W/zj+W0aLKFy7f6IeCahUp3NoEAh2YsXEDQeP7Sma4S0guHIBta1EV/bydF9sNQToVkimDGZr/t1lse5Kym2G9OYH6hvU7Q5ZCwLHrisnb2AFnVP+nqYQ79Na0A9ho2x4A/N8T8l7wbdbjA8BQd73FvbIComPtL59AUHwxrPnVsTHPbKK2VdIdhz3FD8P4xyNHGytfuKnDsfhtsX46ek2qeMf8vZuo2yJVIzgV7YzSQ8srCkAwUT+w1iH9AU58uSusgbqJLOwgPR7lyQlkvLbWebQtN5agVTeK2AImGwetpRc0wK+QGmvY4VxnlhPmoaFvd7V059rg7PiRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2JHoNooTc/nQcbR0Mo3zUXxbgkBPc1tT4z5ZDDCFkI=;
 b=ky4DLL/IjfuUcTLhwwqy/iHhDDYS5XVI/ogJ/wb1GaGl6zOQV1fBm3SXH4fbt/8NsY7yDqCG8pxucROtUrSGJQ6FsiCP16A8T4FAsAZBQxH3/qz0+a0WpjQ9aE06k37rV+Ne61kGF7E4l/mfqsYnlTHokSLT65UnKEfyvOLbvLT37cgT9135ZgZDFH+M5OXZObVDWuAOla/2i3nbYSEgkA2OQXsp/qwIhw6oj6g3F4VBcy761qePEh+fEPkWObWMlvOkuRtFfqe9ysmFSX9QkQTO992mQFy2vt7qMO9JWAqhs/VBgTTy0J5v5Hex6AAuGMbDkVJh0vXkI+Y1iuOCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2JHoNooTc/nQcbR0Mo3zUXxbgkBPc1tT4z5ZDDCFkI=;
 b=ZWCaaDZ43IlFYZ4I49hcjuPHtDDwUg5xSnohkr6xLhRae2DrAA2HHG//UJsiwjUkyxJfOm+2JaHZ/hhPy+ArYm66Jlcm59Eb6gbSsR49UiuyWoQktC1/W3GDLlingtZnu1rnPvJfdgZ/H9lxAJ3kNkqFpTbGTnYo0F87+ee74SE=
Received: from CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12)
 by CY4PR1001MB2053.namprd10.prod.outlook.com (2603:10b6:910:3f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.42; Mon, 22 Feb
 2021 16:26:23 +0000
Received: from CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1]) by CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1%7]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 16:26:23 +0000
From:   Praveen Kannoju <praveen.kannoju@oracle.com>
To:     Praveen Kannoju <praveen.kannoju@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>
Subject: RE: [PATCH RFC] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Thread-Topic: [PATCH RFC] IB/mlx5: Reduce max order of memory allocated for
 xlt update
Thread-Index: AQHXAUbUEaNnuB0gHkC1mpYzXMJFhqpkbDrg
Date:   Mon, 22 Feb 2021 16:26:23 +0000
Message-ID: <CY4PR10MB1448EDE77B7FB66DF79ACAD38C819@CY4PR10MB1448.namprd10.prod.outlook.com>
References: <praveen.kannoju@oracle.com>
 <1613138176-22082-1-git-send-email-praveen.kannoju@oracle.com>
In-Reply-To: <1613138176-22082-1-git-send-email-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [223.237.50.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e578ea8-4c81-4373-a58a-08d8d74e9871
x-ms-traffictypediagnostic: CY4PR1001MB2053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB20534C544BE8F117754D9CE88C819@CY4PR1001MB2053.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5TC4SFgagazvb/Fve1m0HGNC1mLe4GeeMFn4ukb7Or/rnbNkgE3F3iHAWbjkyaNMDSfC4bQc1xNZjgMiCKQacCkDfUYByau55He+/3hXwJajAcB/Vx6JUNWHDqM2Z563IL4bR+ZEeQSE3fzJmNt0Rl9jbqRm2+evOrBk9D0kk3cRrJByMYOonVkRjGnhAP0ENzjJS7EuFH8pyO72IF4IMsFnYSMRDl/obIWM/Bj4QysQvU0etJx87pxCDmXFf0CyPyOI4oNu1DgHMj75Su26EwDBzAHL8iWjiS685wM5Qfdg4Uy9Gy0OAd6aobE2BiOgFcXD0qktLjg8K/IQErHGyaBlq5m3y97VPKagcFUXpncn2tE+g5nCj84P8nPPog2VA/m/nHDT7WCnHY1XzvTg6W+NbK6/wi56zgljedAU9bUJPTXF29Vx3pbNDuYFyLbuSYk6Xn6jjO8JquWWCnsADuS/jx63Fx2wwoYi3BdyJI/Ov63StZfaYIeocReZM9YK+6GOrQtn2jlwYbSuWJIQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1448.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39860400002)(4326008)(186003)(66946007)(5660300002)(66446008)(64756008)(110136005)(76116006)(52536014)(86362001)(66476007)(44832011)(66556008)(8936002)(107886003)(8676002)(9686003)(7696005)(33656002)(15650500001)(6506007)(53546011)(316002)(54906003)(71200400001)(478600001)(55016002)(2906002)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VWN3ejBUWHZlY0RaSXkyb1FaZTc2V3JtdTk0YUJiQi8xTFh3akRWcW1qYXQ5?=
 =?utf-8?B?L3BRWlUxZG0wMlpKNWtkYUFXUldRMXc5NXcrRTl2a1BtQnV0aFR6T0FnMXhV?=
 =?utf-8?B?SWZXSVZEVnpKMlhzUTMyNjBsOGVFN0lXRDljZmFqUFBmVEJGNDNiVDRUMHl0?=
 =?utf-8?B?bDlSOUxjREJ2M21mWTFGRlZlamJ0NTNBVldOTWsrMm5GT2hLeVVqU2NFU25L?=
 =?utf-8?B?ckUwdDJYYldtQ3BmYzArWUo5b1RuRnVkL0p4cHpNQi93aTFrWmpGV09BOXZq?=
 =?utf-8?B?cDB4bWFja0M3aVNFNk9wVW5GSzJUNlc5Q05QWi9CTHZzUlJUQkVnUThLMkNY?=
 =?utf-8?B?T1RRYVhEMDZUdkExMTVIZExCNnAvUGhPMVp0ZFhmWC9SRHpGUzZ1L2hWNU9C?=
 =?utf-8?B?bDVWVUY2b1AzUjZxbGVJcTBaVkROcVdHOSs0WnJVby9ueVhRSCtFVi9pQVlw?=
 =?utf-8?B?MG81RDJLNC9CS0dveEd2YlRSL1ZGcmpLRDVQVUpINjhYQzdJOVFja2RkVEYy?=
 =?utf-8?B?YzZGT25SZk1PcmMyYTZ1RFNCbFlFS3BKNXZFeWJ2Vy94eGRCem9DU3hLQ1c0?=
 =?utf-8?B?VEg0UUZmTzhZMVpieGszSkNSR2FlTDgvZ1VON2tZRHpsZ3dQS2RrVkxPeUhm?=
 =?utf-8?B?UG9JWFMya3F4MlFYaFVUbWxxT0p2ekJSN3hTQWd1dEN1Y3NHQmV1Vk9ldHhn?=
 =?utf-8?B?SFdmYzNzMjExOU5Ka0lGSEVWakR1bkIxcUF0Tjloa1ROTFZLa0RyNm5udGl4?=
 =?utf-8?B?N2UzZTd1aGlzL1Iyd2N4dEhoMEgxanl5bmtGSFM5SE1Gdi9pWEhoYXhUQ0l6?=
 =?utf-8?B?eUoyNlhWZ3B3dDAyMjVkN0drcnhTUGluRUtLVzdZNE9QTlNSVC91Y2VmUXFD?=
 =?utf-8?B?emJleUt1THJzL1hBYiswYnJQMldjUndDVTYrSWU0aldLSmRESitDazE2OTlM?=
 =?utf-8?B?WlJQbUJiK3U0a0VlcGl3WDBLTWxHRzN1bGp1Y3FrT1NMSmtHV01iZmxpaWVm?=
 =?utf-8?B?bllGcmNWcTlUd09Gc2RUY1NJRTNGRFk2VkJYWENZVE1WNmh0NllUcWlrbXlS?=
 =?utf-8?B?RUtiUzJYelhSYnRkSERDOHhrMm95SWk3eVhQckcyR21UUlhyOURwT01TTkpC?=
 =?utf-8?B?UUM5eVhSMVdZRDAxeHNvd3FVYTh4Mkc1aHhic3c4b3M2ZG9IS0xlMEF5SnRu?=
 =?utf-8?B?ZlpVa1ZHZ0dxdjUrYTR3Q1ZqMmxDdllyNXppNWl2UDZLY3BHZTB5aWxmaXoy?=
 =?utf-8?B?REQ5dVhIRVlocGV0SmZHdTc1clBLMEtnYTdVOXh2czVQbXNkNzZhS3RwMTd4?=
 =?utf-8?B?ZzNuQ0JOVnM4dXN3SnlwKzhQL1Frb0Y3WERhM3Q5d0pFQ1NWRmZQV3hXaU52?=
 =?utf-8?B?a0xxaHRHaDQxY3U4SDVreC9IWVYvd2dyR2owQ1BuK0d4d0c3cSt6bWJ0OU1v?=
 =?utf-8?B?R05CRmx3czE3aWVDcldtM1ZtZ1k4T0RPYktUNExsblVkdC9DNnB3NU9xK1N3?=
 =?utf-8?B?eHVFTi82T0pQNkpPdFJDMVZpY0IvaE5MdWNhSUJZUEJUOWtuZFhETzFMNkZW?=
 =?utf-8?B?WmtIR28zQm9WREYvUDNzcllhVmZiTEdpcHlwWG14OWI2T1gwNkt3eUNuQXh1?=
 =?utf-8?B?ampYMzBQSlNFaWNRRnRKdGJPWkx1SG50bHNwVEhaYnB6VDhldTdKYWE2Y2Qw?=
 =?utf-8?B?QzI3cy9aYnZyOTlsTnBGS2MwZU1BaW1zVW05ZGI2eFN5MGlOTlc1SG81VWZt?=
 =?utf-8?Q?EAKa/g1v+mM6VaYDGY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1448.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e578ea8-4c81-4373-a58a-08d8d74e9871
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 16:26:23.6241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ROjjzsVb8c4O+iyle+UTt7lYnySh/vSFRUQekwGnpd6Mukud8PM7WKDXWPRY/Hs8GkToXemK4yZIXL9px2N/vxkxf2Yqn76ItcWqw7YOEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2053
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220149
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220149
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UGluZyENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHByYXZlZW4ua2Fubm9q
dUBvcmFjbGUuY29tIFttYWlsdG86cHJhdmVlbi5rYW5ub2p1QG9yYWNsZS5jb21dIA0KU2VudDog
MTIgRmVicnVhcnkgMjAyMSAwNzoyNiBQTQ0KVG86IGxlb25Aa2VybmVsLm9yZzsgZGxlZGZvcmRA
cmVkaGF0LmNvbTsgamdnQHppZXBlLmNhOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6IFByYXZlZW4gS2Fubm9qdSA8cHJhdmVlbi5r
YW5ub2p1QG9yYWNsZS5jb20+OyBSYW1hIE5pY2hhbmFtYXRsdSA8cmFtYS5uaWNoYW5hbWF0bHVA
b3JhY2xlLmNvbT47IFJhamVzaCBTaXZhcmFtYXN1YnJhbWFuaW9tIDxyYWplc2guc2l2YXJhbWFz
dWJyYW1hbmlvbUBvcmFjbGUuY29tPg0KU3ViamVjdDogW1BBVENIIFJGQ10gSUIvbWx4NTogUmVk
dWNlIG1heCBvcmRlciBvZiBtZW1vcnkgYWxsb2NhdGVkIGZvciB4bHQgdXBkYXRlDQoNClRvIHVw
ZGF0ZSB4bHQgKGR1cmluZyBtbHg1X2liX3JlZ191c2VyX21yKCkpLCB0aGUgZHJpdmVyIGNhbiBy
ZXF1ZXN0IHVwIHRvDQoxIE1CIChvcmRlci04KSBtZW1vcnksIGRlcGVuZGluZyBvbiB0aGUgc2l6
ZSBvZiB0aGUgTVIuIFRoaXMgY29zdGx5IGFsbG9jYXRpb24gY2FuIHNvbWV0aW1lcyB0YWtlIHZl
cnkgbG9uZyB0byByZXR1cm4gKGEgZmV3IHNlY29uZHMpLCBlc3BlY2lhbGx5IGlmIHRoZSBzeXN0
ZW0gaXMgZnJhZ21lbnRlZCBhbmQgZG9lcyBub3QgaGF2ZSBhbnkgZnJlZSBjaHVua3MgZm9yIG9y
ZGVycyA+PSAzLiBUaGlzIGNhdXNlcyB0aGUgY2FsbGluZyBhcHBsaWNhdGlvbiB0byBoYW5nIGZv
ciBhIGxvbmcgdGltZS4gVG8gYXZvaWQgdGhlc2UgbG9uZyBsYXRlbmN5IHNwaWtlcywgbGltaXQg
bWF4IG9yZGVyIG9mIGFsbG9jYXRpb24gdG8gb3JkZXIgMywgYW5kIHJldXNlIHRoYXQgYnVmZmVy
IHRvIHBvcHVsYXRlX3hsdCgpIGZvciB0aGF0IE1SLiBUaGlzIHdpbGwgaW5jcmVhc2UgdGhlIGxh
dGVuY3kgc2xpZ2h0bHkgKGluIHRoZSBvcmRlciBvZiBtaWNyb3NlY29uZHMpIGZvciBlYWNoDQpt
bHg1X2liX3VwZGF0ZV94bHQoKSBjYWxsLCBlc3BlY2lhbGx5IGZvciBsYXJnZXIgTVJzIChzaW5j
ZSB3ZeKAmXJlIG1ha2luZyBtdWx0aXBsZSBjYWxscyB0byBwb3B1bGF0ZV94bHQoKSksIGJ1dCBp
dOKAmXMgYSBzbWFsbCBwcmljZSB0byBwYXkgdG8gYXZvaWQgdGhlIGxhcmdlIGxhdGVuY3kgc3Bp
a2VzIHdpdGggaGlnaGVyIG9yZGVyIGFsbG9jYXRpb25zLg0KDQpTaWduZWQtb2ZmLWJ5OiBQcmF2
ZWVuIEt1bWFyIEthbm5vanUgPHByYXZlZW4ua2Fubm9qdUBvcmFjbGUuY29tPg0KLS0tDQogZHJp
dmVycy9pbmZpbmliYW5kL2h3L21seDUvbXIuYyB8ICAgMjAgKystLS0tLS0tLS0tLS0tLS0tLS0N
CiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tci5jIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21seDUvbXIuYyBpbmRleCAyNGY4ZDU5Li40ZjMzMTI3IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbXIuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21seDUvbXIuYw0KQEAgLTk4Niw5ICs5ODYsNyBAQCBzdGF0aWMgdm9pZCBzZXRfbXJfZmll
bGRzKHN0cnVjdCBtbHg1X2liX2RldiAqZGV2LCBzdHJ1Y3QgbWx4NV9pYl9tciAqbXIsDQogCXJl
dHVybiBtcjsNCiB9DQogDQotI2RlZmluZSBNTFg1X01BWF9VTVJfQ0hVTksgKCgxIDw8IChNTFg1
X01BWF9VTVJfU0hJRlQgKyA0KSkgLSBcDQotCQkJICAgIE1MWDVfVU1SX01UVF9BTElHTk1FTlQp
DQotI2RlZmluZSBNTFg1X1NQQVJFX1VNUl9DSFVOSyAweDEwMDAwDQorI2RlZmluZSBNTFg1X1NQ
QVJFX1VNUl9DSFVOSyAweDgwMDANCiANCiAvKg0KICAqIEFsbG9jYXRlIGEgdGVtcG9yYXJ5IGJ1
ZmZlciB0byBob2xkIHRoZSBwZXItcGFnZSBpbmZvcm1hdGlvbiB0byB0cmFuc2ZlciB0byBAQCAt
MTAxMiwyOCArMTAxMCwxNCBAQCBzdGF0aWMgdm9pZCBzZXRfbXJfZmllbGRzKHN0cnVjdCBtbHg1
X2liX2RldiAqZGV2LCBzdHJ1Y3QgbWx4NV9pYl9tciAqbXIsDQogDQogCWdmcF9tYXNrIHw9IF9f
R0ZQX1pFUk87DQogDQotCS8qDQotCSAqIElmIHRoZSBzeXN0ZW0gYWxyZWFkeSBoYXMgYSBzdWl0
YWJsZSBoaWdoIG9yZGVyIHBhZ2UgdGhlbiBqdXN0IHVzZQ0KLQkgKiB0aGF0LCBidXQgZG9uJ3Qg
dHJ5IGhhcmQgdG8gY3JlYXRlIG9uZS4gVGhpcyBtYXggaXMgYWJvdXQgMU0sIHNvIGENCi0JICog
ZnJlZSB4ODYgaHVnZSBwYWdlIHdpbGwgc2F0aXNmeSBpdC4NCi0JICovDQogCXNpemUgPSBtaW5f
dChzaXplX3QsIGVudF9zaXplICogQUxJR04oKm5lbnRzLCB4bHRfY2h1bmtfYWxpZ24pLA0KLQkJ
ICAgICBNTFg1X01BWF9VTVJfQ0hVTkspOw0KKwkJICAgICBNTFg1X1NQQVJFX1VNUl9DSFVOSyk7
DQogCSpuZW50cyA9IHNpemUgLyBlbnRfc2l6ZTsNCiAJcmVzID0gKHZvaWQgKilfX2dldF9mcmVl
X3BhZ2VzKGdmcF9tYXNrIHwgX19HRlBfTk9XQVJOLA0KIAkJCQkgICAgICAgZ2V0X29yZGVyKHNp
emUpKTsNCiAJaWYgKHJlcykNCiAJCXJldHVybiByZXM7DQogDQotCWlmIChzaXplID4gTUxYNV9T
UEFSRV9VTVJfQ0hVTkspIHsNCi0JCXNpemUgPSBNTFg1X1NQQVJFX1VNUl9DSFVOSzsNCi0JCSpu
ZW50cyA9IGdldF9vcmRlcihzaXplKSAvIGVudF9zaXplOw0KLQkJcmVzID0gKHZvaWQgKilfX2dl
dF9mcmVlX3BhZ2VzKGdmcF9tYXNrIHwgX19HRlBfTk9XQVJOLA0KLQkJCQkJICAgICAgIGdldF9v
cmRlcihzaXplKSk7DQotCQlpZiAocmVzKQ0KLQkJCXJldHVybiByZXM7DQotCX0NCi0NCiAJKm5l
bnRzID0gUEFHRV9TSVpFIC8gZW50X3NpemU7DQogCXJlcyA9ICh2b2lkICopX19nZXRfZnJlZV9w
YWdlKGdmcF9tYXNrKTsNCiAJaWYgKHJlcykNCi0tDQoxLjcuMQ0KDQo=
