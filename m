Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D063D3AAF90
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFQJVm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 05:21:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13724 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhFQJVm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 05:21:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H9Hj5Y019536;
        Thu, 17 Jun 2021 09:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QhYoD9r/h80htD5F8bZcD7IOBwd+/I0dwlfiQ1cKF8c=;
 b=HngA6H7iWZau/G7uFZpif0DztpDcSNvRelKGoPbmo0JRUshPwRa+fd3oNtre5BVJtgkJ
 +umNiPQl7be+USDuMfkj2MRZP/d0nXDLhnL46ZtQwPja05nJwi+PEZOv6yPAxychlzEA
 w/MqcTShqBbtOsKETT7UVz8VgJstERKO8W8tLVQieCZPm0eqkAtjKpoKSusEV4as0uhe
 u//BRzCr6bl07pOemMeiOhPgMhQqbS/l2tCd0biM2sRxhnK6FF3GhakN1KB9JbtcpmpW
 ipNA626v9Lxi4e4QMfXGFbgJi3u+7NAOBHZ2ngP56moyDVMlgJ7fKgsI+ECK1gWumTcs WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 397w1y0ky3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 09:19:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15H9FYWu101949;
        Thu, 17 Jun 2021 09:19:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 396waxdw4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 09:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx+e9YJj6mPL335a1YUMXVxgmqv2I8KmuAwecLqVlOhZY3t97rmZ/ML7Tfsq2NiBwJdiVNHN7YP/Jw9Y43tcUL4S+6QhbLtMJoZI5kNS5wzlbuB29cqEqZAOtf9WyT8EQ1xKTVczL6fghkDkMPnt+frvObFJRJhmAby0I8oqS6AqK+y7ouUlrvv/h0XVr6nCG6GhtjlYdHlq0JVqVVheUb+eOcJrLYyecx3MjDCxpfNYJCfn48tTLSGt5cxnC8ZSw1PaCdwuv1bJua+NOiKx3LdBY2awhgY3z4zV4pRLm9DeD+5dJUpynTpOvor5coMlSQh/x8SGx9VTYyBEs0Smtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhYoD9r/h80htD5F8bZcD7IOBwd+/I0dwlfiQ1cKF8c=;
 b=iostmwDdW+vodJ4Kb9TCjcEYrDdvpZkMzyWGuIOilAH/wia2EXjlDyWdeV/J1NbCUkEjhOPpTKdPDvvwGnvvea5AjuoAtQXWGZ13DCl+HSf5rcHlqALlPY3m3MDssu8AKRhTQezzQDO2qtrOdIY8hOac1jqd9zBiFfp/hToc3FqIDNKYdBXO4pBSuZX1cRzpk2zRJsc0tfeYWenlkqfDyM3zulj/ZtzkplFwfT98IUzOTi2cg+SAob5Rd/teKTuvlOA8fv5y0ZZdawBeJmNevYPx5hoIsPkbNtAAY4Xh0BZM4uIPWpI76eoSVVMtV6nKSHJsOCZ845Yt9suu04zEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhYoD9r/h80htD5F8bZcD7IOBwd+/I0dwlfiQ1cKF8c=;
 b=TXUiKR9SpCdM6Y9O38tozxSjarryru3DzqExmycPa6hYovQ33XGf9eF+i3tBLo2g2BeRdrS4QfkVP3jb629+cXwKMtGSYHYyJxoP+PqmHK3HnkYuhQSR502W0j/1b6tBsFabZlYX5Sucy6XlUNGeOoy243YqtNLwSiw017HgMfY=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1272.namprd10.prod.outlook.com (2603:10b6:910:7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 09:19:27 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 09:19:26 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsXxQ4AgAABMICAAAuugIAAHFMA
Date:   Thu, 17 Jun 2021 09:19:26 +0000
Message-ID: <4C4C7F68-619C-4146-BDC8-18E0B356FCC6@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <YMrxDtudALQkYuXP@unreal> <E69C3CB3-AE31-4139-816A-11467729ABDC@oracle.com>
 <YMr72f1bVgQPPlnv@unreal>
In-Reply-To: <YMr72f1bVgQPPlnv@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75b7904-504c-4454-595e-08d931710117
x-ms-traffictypediagnostic: CY4PR10MB1272:
x-microsoft-antispam-prvs: <CY4PR10MB12723E8D8B24A92E5A33EDB5FD0E9@CY4PR10MB1272.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTEjPPCsKE5bR37UwMUSzjxnJRR2JZ45f+rIuQ1xvsEIZ4r6/uPnHvBE7DTeHk4xTEXLG6PLbmt8s8rf8Fg5KCayMw+yFXhcpf9swo+qJN8cECcT5LvGR9UcfWLv393sZ26MGofWZ/Fggj0tjCntj7FbBd2SYO5JJGr5f3kX/B0DUHHR64QVviQF6/tG8mb631sDKCViw6JTcuiZy1fKyBxqzAHA4IRisfA06xuemd/sO+gkNDmDuUyHMrAtJXTe07VgT2qx2VAYMP11RB5h6LI8qRrFTxn5XZFisIPzpy7GesJdHViIIvCT6J4oDTr7kw4ephKL2UZmPO0Mg1Sj3zhQV5CeuK3Lhto6skrOmd+gTSj4ywzWIrtYCG0SMjBA3ansbJk+efybtp3ngcaQqjsefsYc0krO3KxttOaB9EA5ov30cizIitdfDwDuYfiIIrdvB0GCXXFqv0kILy3xuMcZEwqL41fMWp84ozHFNs47xCj4MEDZOy6QLZRmHcwYRX+ZaTwNkZ42MVRExaz7I8F+kwePr6FeuUQ4M0heGe5NZFxURJVNiWd9USQuZKjjUVnyz1rg5qz0WRmzK6B1SvJ6zSx3a1nPco5PLDiWNabr7NMatAMP4I2M01Yc6jzRMp1hrN/rYL6iNG8oQU98CjajzjpcqBVx3wCQsvkcfAYNAiyesNn1Cy9F3nPkKIew
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(53546011)(36756003)(6506007)(54906003)(4326008)(38100700002)(8676002)(316002)(44832011)(186003)(6486002)(2906002)(26005)(5660300002)(6512007)(33656002)(8936002)(2616005)(478600001)(86362001)(66476007)(76116006)(64756008)(71200400001)(83380400001)(6916009)(91956017)(66574015)(122000001)(66446008)(66946007)(66556008)(290074003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHozRU5mL2JJVU5ORjRCY09VeVV4cVFOd1ZYZ2Y3alpkek9qNzVaVUZVbERF?=
 =?utf-8?B?TjFabE1DdXJvT2h6SzdoYTNhSFY4aFppUGhlbzdDNExqWm5mYTE3QzI2cTEz?=
 =?utf-8?B?OC9qTFN6Mkl5dzcrZVNuQUcrNmdMcXR3Nmt4N0lRQ05jaG5xWXpvdHE2VWpw?=
 =?utf-8?B?SWp4dGlzUHhiYVRqbGtuWHRUb1hjc2tRUEkrWSsrUXArSDJRT2d3RStkcnBP?=
 =?utf-8?B?bnNZODA0SExpQUJVdXU5MDhVSnVXWjJVaXBrWmdqZ01FMzVvZnNiMEszK2Fn?=
 =?utf-8?B?a2JOTXRjNWF4VlVMWjVuREJOazdyYzRQRlQ3WUNLbGdMSW9mY0pudU5hTnNn?=
 =?utf-8?B?czRKOXk4OWMxSUJHTUpZVGZEVmVYcVhBUlEvZ002SWlkT2ZiZlJiL0dSeVpJ?=
 =?utf-8?B?THlwVkxIYVRDN0pwVFJvWGh3Q1paTEsrTUI0YUFUMWlNL2ROYW4zVk10dWN5?=
 =?utf-8?B?VFZFSjZvUGFlc0JYcnMrd3ZWMU9NeEhXenc1UDV4TmlGMGtUTHBKUCtLOWU5?=
 =?utf-8?B?RjdPMmpjVXNOSURTbDl2c3ZwSzY3empNRGRKb2V4eTNSOVl3cWZkSWJBNm1k?=
 =?utf-8?B?Q21haWlEZ3RIdDZpcDc3Uzg5Y01qNXo3M0J4OTN2a3RKdXNlUGFXM05qMmFw?=
 =?utf-8?B?VFRKZWFydVRSV3lCRUN4aWp1Q2tSeDVTWml4aDVMMUZTMVN0S0hjeWY2bVQx?=
 =?utf-8?B?V202aXFNM0krdnZ2bE9MZ1hkZTRYblM1czNiVDNrUmtnQVI0dm1hQmpFSUYx?=
 =?utf-8?B?Z0U4QjJvSCtTbVBjSlRaWjdldUloTlZ3cDhCS0NtTCtad25sWU9ObzVOaGsr?=
 =?utf-8?B?SnZhNnJGbXIzby9tRlY0MDZxR1dIaDNvbW52eUR1VzFBZ1gxdlYwSXE2elZq?=
 =?utf-8?B?UkQ0QjVQNEIrS0doZ012eUZCN1YyWU9MTlYrcHNzYWoyUEZGVnFQVFZPQ21E?=
 =?utf-8?B?cWtjU2JnQXZIRjFrektKaHpaYVl4S1BHMEhvQ2psdTF6cVhBaElVSmdrL3Ar?=
 =?utf-8?B?LzNsbzJFWWxjZGN3RHIzc1RYNUNmcGpHM3ZvZUdjdFFSYUsydXFyMVRUdkJC?=
 =?utf-8?B?dksrNmNvVTFvV3Fmd0IyN3R3VW5IWGRtckZlcU5TaUJtV2pSWkNHVjlaOVhs?=
 =?utf-8?B?K291cHNEVm8wZ1VQY0o5UlNvN3J2QlYwVDZ5aTV4anY3WlpLZmdaZWFyc1ND?=
 =?utf-8?B?UUljNHIzSkJ6R0E2cWV6MlNNcTJDK2Q1L2N5WGxXQTJIQkF1TW1oRlZ1WnBI?=
 =?utf-8?B?NGozWDRCbW1JcERzSjA1K0Z1ZUVSeS9WS3dSRk92YVpKaTgvTHJDQzB4R2k4?=
 =?utf-8?B?Vm1jdVlPWUpCT2d4M2kwUWtVKzZ0MkFTbTcrTEx0amJ0cjNqNnJqNVRSWGln?=
 =?utf-8?B?WWxrRGRqMHhrQ05SNjZPMnAwcnBMaHh6ZkNTZ0hncDlNUXMrenNZeVp0aVQz?=
 =?utf-8?B?SDhqUk05ZnZ4T0ViSTZyYk5BNDZWSFIyMGw4Z3ZaeXM3QWZ2MStKa0o1djZy?=
 =?utf-8?B?ZEVoK0hZU2VtWis2UzNXV0F6VjRERGx1R3NOckROQjlhNUFTZVlXMUZQVnVI?=
 =?utf-8?B?TUEzcVJEeHNNeml0bjlFQ2VPbWRLQU82N1lBMUIxdWNVdjNTVlkyM2liWlJx?=
 =?utf-8?B?U01yMDJYNUlJMFNpNWVtdjZOUTd4WlVSN01ORE5DVlJWVTdwUjcyODNHd05Y?=
 =?utf-8?B?OGJ4K0ozTWJ4UTBmbm9WZVgvUXh1bUREcU1kVkYrbnZNSWNoNFk5R1R0bXpk?=
 =?utf-8?B?aWwyN1F4TktGaERpL0JiUFd3NUZVOVd6aVRsLzk0aHM3WGZ0VFcvWlZIM2pM?=
 =?utf-8?B?eHhiU2EwTVdRUFptcG1PZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A42DD547064945B5E643689C2D3BBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75b7904-504c-4454-595e-08d931710117
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 09:19:26.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JXYYhdcn8XBayHeWaKKthl5n2Xr/9znISTOi7whG0bYbPMxnFwefCZqlyhctfvUnJTeGr9pEMdqBdYd9TRoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1272
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10017 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170065
X-Proofpoint-ORIG-GUID: zIj-zRRim5IKDTAK6R3odUCYdTVv3qQC
X-Proofpoint-GUID: zIj-zRRim5IKDTAK6R3odUCYdTVv3qQC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTcgSnVuIDIwMjEsIGF0IDA5OjM4LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxNywgMjAyMSBhdCAwNjo1NjoxNUFN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDE3IEp1biAyMDIx
LCBhdCAwODo1MSwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFdlZCwgSnVuIDE2LCAyMDIxIGF0IDA0OjM1OjUzUE0gKzAyMDAsIEjDpWtvbiBC
dWdnZSB3cm90ZToNCj4+Pj4gVGhlIHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgY29udGFpbnMgdGhy
ZWUgYml0LWZpZWxkcywgdG9zX3NldCwNCj4+Pj4gdGltZW91dF9zZXQsIGFuZCBtaW5fcm5yX3Rp
bWVyX3NldC4gVGhlc2UgYXJlIHNldCBieSBhY2Nlc3Nvcg0KPj4+PiBmdW5jdGlvbnMgd2l0aG91
dCBhbnkgc3luY2hyb25pemF0aW9uLiBJZiB0d28gb3IgYWxsIGFjY2Vzc29yDQo+Pj4+IGZ1bmN0
aW9ucyBhcmUgaW52b2tlZCBpbiBjbG9zZSBwcm94aW1pdHkgaW4gdGltZSwgdGhlcmUgd2lsbCBi
ZQ0KPj4+PiBSZWFkLU1vZGlmeS1Xcml0ZSBmcm9tIHNldmVyYWwgY29udGV4dHMgdG8gdGhlIHNh
bWUgdmFyaWFibGUsIGFuZCB0aGUNCj4+Pj4gcmVzdWx0IHdpbGwgYmUgaW50ZXJtaXR0ZW50Lg0K
Pj4+PiANCj4+Pj4gUmVwbGFjZSB3aXRoIGEgZmxhZyB2YXJpYWJsZSBhbmQgaW5saW5lIGZ1bmN0
aW9ucyBmb3Igc2V0IGFuZCBnZXQuDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24g
QnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBIYW5z
IFdlc3RnYWFyZCBSeTxoYW5zLndlc3RnYWFyZC5yeUBvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgICAgICB8IDI0ICsrKysrKysrKysrLS0t
LS0tLS0tLS0tLQ0KPj4+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4+PiAyIGZpbGVzIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21h
LmMNCj4+Pj4gaW5kZXggMmI5ZmZjMi4uZmU2MDllNyAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY21hLmMNCj4+Pj4gQEAgLTg0NCw5ICs4NDQsNyBAQCBzdGF0aWMgdm9pZCBjbWFfaWRfcHV0
KHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXYpDQo+Pj4+IAlpZF9wcml2LT5pZC5ldmVu
dF9oYW5kbGVyID0gZXZlbnRfaGFuZGxlcjsNCj4+Pj4gCWlkX3ByaXYtPmlkLnBzID0gcHM7DQo+
Pj4+IAlpZF9wcml2LT5pZC5xcF90eXBlID0gcXBfdHlwZTsNCj4+Pj4gLQlpZF9wcml2LT50b3Nf
c2V0ID0gZmFsc2U7DQo+Pj4+IC0JaWRfcHJpdi0+dGltZW91dF9zZXQgPSBmYWxzZTsNCj4+Pj4g
LQlpZF9wcml2LT5taW5fcm5yX3RpbWVyX3NldCA9IGZhbHNlOw0KPj4+PiArCWlkX3ByaXYtPmZs
YWdzID0gMDsNCj4+PiANCj4+PiBJdCBpcyBub3QgbmVlZGVkLCBpZF9wcml2IGlzIGFsbG9jYXRl
ZCB3aXRoIGt6YWxsb2MuDQo+PiANCj4+IEkgYWdyZWUuIERpZCBwdXQgaXQgaW4gZHVlIHRoZSBm
b28gPSBmYWxzZS4NCj4+PiANCj4+Pj4gCWlkX3ByaXYtPmdpZF90eXBlID0gSUJfR0lEX1RZUEVf
SUI7DQo+Pj4+IAlzcGluX2xvY2tfaW5pdCgmaWRfcHJpdi0+bG9jayk7DQo+Pj4+IAltdXRleF9p
bml0KCZpZF9wcml2LT5xcF9tdXRleCk7DQo+Pj4+IEBAIC0xMTM0LDEwICsxMTMyLDEwIEBAIGlu
dCByZG1hX2luaXRfcXBfYXR0cihzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHN0cnVjdCBpYl9xcF9h
dHRyICpxcF9hdHRyLA0KPj4+PiAJCXJldCA9IC1FTk9TWVM7DQo+Pj4+IAl9DQo+Pj4+IA0KPj4+
PiAtCWlmICgoKnFwX2F0dHJfbWFzayAmIElCX1FQX1RJTUVPVVQpICYmIGlkX3ByaXYtPnRpbWVv
dXRfc2V0KQ0KPj4+PiArCWlmICgoKnFwX2F0dHJfbWFzayAmIElCX1FQX1RJTUVPVVQpICYmIGdl
dF9USU1FT1VUX1NFVChpZF9wcml2LT5mbGFncykpDQo+Pj4+IAkJcXBfYXR0ci0+dGltZW91dCA9
IGlkX3ByaXYtPnRpbWVvdXQ7DQo+Pj4+IA0KPj4+PiAtCWlmICgoKnFwX2F0dHJfbWFzayAmIElC
X1FQX01JTl9STlJfVElNRVIpICYmIGlkX3ByaXYtPm1pbl9ybnJfdGltZXJfc2V0KQ0KPj4+PiAr
CWlmICgoKnFwX2F0dHJfbWFzayAmIElCX1FQX01JTl9STlJfVElNRVIpICYmIGdldF9NSU5fUk5S
X1RJTUVSX1NFVChpZF9wcml2LT5mbGFncykpDQo+Pj4+IAkJcXBfYXR0ci0+bWluX3Jucl90aW1l
ciA9IGlkX3ByaXYtPm1pbl9ybnJfdGltZXI7DQo+Pj4+IA0KPj4+PiAJcmV0dXJuIHJldDsNCj4+
Pj4gQEAgLTI0NzIsNyArMjQ3MCw3IEBAIHN0YXRpYyBpbnQgY21hX2l3X2xpc3RlbihzdHJ1Y3Qg
cmRtYV9pZF9wcml2YXRlICppZF9wcml2LCBpbnQgYmFja2xvZykNCj4+Pj4gCQlyZXR1cm4gUFRS
X0VSUihpZCk7DQo+Pj4+IA0KPj4+PiAJaWQtPnRvcyA9IGlkX3ByaXYtPnRvczsNCj4+Pj4gLQlp
ZC0+dG9zX3NldCA9IGlkX3ByaXYtPnRvc19zZXQ7DQo+Pj4+ICsJaWQtPnRvc19zZXQgPSBnZXRf
VE9TX1NFVChpZF9wcml2LT5mbGFncyk7DQo+Pj4+IAlpZC0+YWZvbmx5ID0gaWRfcHJpdi0+YWZv
bmx5Ow0KPj4+PiAJaWRfcHJpdi0+Y21faWQuaXcgPSBpZDsNCj4+Pj4gDQo+Pj4+IEBAIC0yNTMz
LDcgKzI1MzEsNyBAQCBzdGF0aWMgaW50IGNtYV9saXN0ZW5fb25fZGV2KHN0cnVjdCByZG1hX2lk
X3ByaXZhdGUgKmlkX3ByaXYsDQo+Pj4+IAljbWFfaWRfZ2V0KGlkX3ByaXYpOw0KPj4+PiAJZGV2
X2lkX3ByaXYtPmludGVybmFsX2lkID0gMTsNCj4+Pj4gCWRldl9pZF9wcml2LT5hZm9ubHkgPSBp
ZF9wcml2LT5hZm9ubHk7DQo+Pj4+IC0JZGV2X2lkX3ByaXYtPnRvc19zZXQgPSBpZF9wcml2LT50
b3Nfc2V0Ow0KPj4+PiArCWRldl9pZF9wcml2LT5mbGFncyA9IGlkX3ByaXYtPmZsYWdzOw0KPj4+
PiAJZGV2X2lkX3ByaXYtPnRvcyA9IGlkX3ByaXYtPnRvczsNCj4+Pj4gDQo+Pj4+IAlyZXQgPSBy
ZG1hX2xpc3RlbigmZGV2X2lkX3ByaXYtPmlkLCBpZF9wcml2LT5iYWNrbG9nKTsNCj4+Pj4gQEAg
LTI1ODIsNyArMjU4MCw3IEBAIHZvaWQgcmRtYV9zZXRfc2VydmljZV90eXBlKHN0cnVjdCByZG1h
X2NtX2lkICppZCwgaW50IHRvcykNCj4+Pj4gDQo+Pj4+IAlpZF9wcml2ID0gY29udGFpbmVyX29m
KGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+Pj4+IAlpZF9wcml2LT50b3MgPSAo
dTgpIHRvczsNCj4+Pj4gLQlpZF9wcml2LT50b3Nfc2V0ID0gdHJ1ZTsNCj4+Pj4gKwlzZXRfVE9T
X1NFVChpZF9wcml2LT5mbGFncyk7DQo+Pj4+IH0NCj4+Pj4gRVhQT1JUX1NZTUJPTChyZG1hX3Nl
dF9zZXJ2aWNlX3R5cGUpOw0KPj4+PiANCj4+Pj4gQEAgLTI2MTAsNyArMjYwOCw3IEBAIGludCBy
ZG1hX3NldF9hY2tfdGltZW91dChzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHU4IHRpbWVvdXQpDQo+
Pj4+IA0KPj4+PiAJaWRfcHJpdiA9IGNvbnRhaW5lcl9vZihpZCwgc3RydWN0IHJkbWFfaWRfcHJp
dmF0ZSwgaWQpOw0KPj4+PiAJaWRfcHJpdi0+dGltZW91dCA9IHRpbWVvdXQ7DQo+Pj4+IC0JaWRf
cHJpdi0+dGltZW91dF9zZXQgPSB0cnVlOw0KPj4+PiArCXNldF9USU1FT1VUX1NFVChpZF9wcml2
LT5mbGFncyk7DQo+Pj4+IA0KPj4+PiAJcmV0dXJuIDA7DQo+Pj4+IH0NCj4+Pj4gQEAgLTI2NDcs
NyArMjY0NSw3IEBAIGludCByZG1hX3NldF9taW5fcm5yX3RpbWVyKHN0cnVjdCByZG1hX2NtX2lk
ICppZCwgdTggbWluX3Jucl90aW1lcikNCj4+Pj4gDQo+Pj4+IAlpZF9wcml2ID0gY29udGFpbmVy
X29mKGlkLCBzdHJ1Y3QgcmRtYV9pZF9wcml2YXRlLCBpZCk7DQo+Pj4+IAlpZF9wcml2LT5taW5f
cm5yX3RpbWVyID0gbWluX3Jucl90aW1lcjsNCj4+Pj4gLQlpZF9wcml2LT5taW5fcm5yX3RpbWVy
X3NldCA9IHRydWU7DQo+Pj4+ICsJc2V0X01JTl9STlJfVElNRVJfU0VUKGlkX3ByaXYtPmZsYWdz
KTsNCj4+Pj4gDQo+Pj4+IAlyZXR1cm4gMDsNCj4+Pj4gfQ0KPj4+PiBAQCAtMzAzMyw3ICszMDMx
LDcgQEAgc3RhdGljIGludCBjbWFfcmVzb2x2ZV9pYm9lX3JvdXRlKHN0cnVjdCByZG1hX2lkX3By
aXZhdGUgKmlkX3ByaXYpDQo+Pj4+IA0KPj4+PiAJdTggZGVmYXVsdF9yb2NlX3RvcyA9IGlkX3By
aXYtPmNtYV9kZXYtPmRlZmF1bHRfcm9jZV90b3NbaWRfcHJpdi0+aWQucG9ydF9udW0gLQ0KPj4+
PiAJCQkJCXJkbWFfc3RhcnRfcG9ydChpZF9wcml2LT5jbWFfZGV2LT5kZXZpY2UpXTsNCj4+Pj4g
LQl1OCB0b3MgPSBpZF9wcml2LT50b3Nfc2V0ID8gaWRfcHJpdi0+dG9zIDogZGVmYXVsdF9yb2Nl
X3RvczsNCj4+Pj4gKwl1OCB0b3MgPSBnZXRfVE9TX1NFVChpZF9wcml2LT5mbGFncykgPyBpZF9w
cml2LT50b3MgOiBkZWZhdWx0X3JvY2VfdG9zOw0KPj4+PiANCj4+Pj4gDQo+Pj4+IAl3b3JrID0g
a3phbGxvYyhzaXplb2YgKndvcmssIEdGUF9LRVJORUwpOw0KPj4+PiBAQCAtMzA4MSw3ICszMDc5
LDcgQEAgc3RhdGljIGludCBjbWFfcmVzb2x2ZV9pYm9lX3JvdXRlKHN0cnVjdCByZG1hX2lkX3By
aXZhdGUgKmlkX3ByaXYpDQo+Pj4+IAkgKiBQYWNrZXRMaWZlVGltZSA9IGxvY2FsIEFDSyB0aW1l
b3V0LzINCj4+Pj4gCSAqIGFzIGEgcmVhc29uYWJsZSBhcHByb3hpbWF0aW9uIGZvciBSb0NFIG5l
dHdvcmtzLg0KPj4+PiAJICovDQo+Pj4+IC0Jcm91dGUtPnBhdGhfcmVjLT5wYWNrZXRfbGlmZV90
aW1lID0gaWRfcHJpdi0+dGltZW91dF9zZXQgPw0KPj4+PiArCXJvdXRlLT5wYXRoX3JlYy0+cGFj
a2V0X2xpZmVfdGltZSA9IGdldF9USU1FT1VUX1NFVChpZF9wcml2LT5mbGFncykgPw0KPj4+PiAJ
CWlkX3ByaXYtPnRpbWVvdXQgLSAxIDogQ01BX0lCT0VfUEFDS0VUX0xJRkVUSU1FOw0KPj4+PiAN
Cj4+Pj4gCWlmICghcm91dGUtPnBhdGhfcmVjLT5tdHUpIHsNCj4+Pj4gQEAgLTQxMDcsNyArNDEw
NSw3IEBAIHN0YXRpYyBpbnQgY21hX2Nvbm5lY3RfaXcoc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAq
aWRfcHJpdiwNCj4+Pj4gCQlyZXR1cm4gUFRSX0VSUihjbV9pZCk7DQo+Pj4+IA0KPj4+PiAJY21f
aWQtPnRvcyA9IGlkX3ByaXYtPnRvczsNCj4+Pj4gLQljbV9pZC0+dG9zX3NldCA9IGlkX3ByaXYt
PnRvc19zZXQ7DQo+Pj4+ICsJY21faWQtPnRvc19zZXQgPSBnZXRfVE9TX1NFVChpZF9wcml2LT5m
bGFncyk7DQo+Pj4+IAlpZF9wcml2LT5jbV9pZC5pdyA9IGNtX2lkOw0KPj4+PiANCj4+Pj4gCW1l
bWNweSgmY21faWQtPmxvY2FsX2FkZHIsIGNtYV9zcmNfYWRkcihpZF9wcml2KSwNCj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmggYi9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oDQo+Pj4+IGluZGV4IDVjNDYzZGEuLjJjMTY5NGYgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYV9wcml2LmgNCj4+Pj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hX3ByaXYuaA0KPj4+PiBAQCAtODIsMTEg
KzgyLDkgQEAgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSB7DQo+Pj4+IAl1MzIJCQlxa2V5Ow0KPj4+
PiAJdTMyCQkJcXBfbnVtOw0KPj4+PiAJdTMyCQkJb3B0aW9uczsNCj4+Pj4gKwl1bnNpZ25lZCBs
b25nCQlmbGFnczsNCj4+Pj4gCXU4CQkJc3JxOw0KPj4+PiAJdTgJCQl0b3M7DQo+Pj4+IC0JdTgJ
CQl0b3Nfc2V0OjE7DQo+Pj4+IC0JdTggICAgICAgICAgICAgICAgICAgICAgdGltZW91dF9zZXQ6
MTsNCj4+Pj4gLQl1OAkJCW1pbl9ybnJfdGltZXJfc2V0OjE7DQo+Pj4+IAl1OAkJCXJldXNlYWRk
cjsNCj4+Pj4gCXU4CQkJYWZvbmx5Ow0KPj4+PiAJdTgJCQl0aW1lb3V0Ow0KPj4+PiBAQCAtMTI3
LDQgKzEyNSwyOCBAQCBpbnQgY21hX3NldF9kZWZhdWx0X3JvY2VfdG9zKHN0cnVjdCBjbWFfZGV2
aWNlICpkZXYsIHUzMiBwb3J0LA0KPj4+PiAJCQkgICAgIHU4IGRlZmF1bHRfcm9jZV90b3MpOw0K
Pj4+PiBzdHJ1Y3QgaWJfZGV2aWNlICpjbWFfZ2V0X2liX2RldihzdHJ1Y3QgY21hX2RldmljZSAq
ZGV2KTsNCj4+Pj4gDQo+Pj4+ICsjZGVmaW5lIEJJVF9BQ0NFU1NfRlVOQ1RJT05TKGIpCQkJCQkJ
CVwNCj4+Pj4gKwlzdGF0aWMgaW5saW5lIHZvaWQgc2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdz
KQkJCQlcDQo+Pj4+ICsJewkJCQkJCQkJCVwNCj4+Pj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90
IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8JCQlcDQo+Pj4+ICsJCXNtcF9tYl9fYmVmb3JlX2F0
b21pYygpOwkJCQkJXA0KPj4+PiArCQlzZXRfYml0KGIsICZmbGFncyk7CQkJCQkJXA0KPj4+PiAr
CQkvKiBzZXRfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBtZW1vcnkgYmFycmllciAqLwkJCVwNCj4+
Pj4gKwkJc21wX21iX19hZnRlcl9hdG9taWMoKTsJCQkJCQlcDQo+Pj4+ICsJfQkJCQkJCQkJCVwN
Cj4+Pj4gKwlzdGF0aWMgaW5saW5lIGJvb2wgZ2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdzKQkJ
CQlcDQo+Pj4+ICsJewkJCQkJCQkJCVwNCj4+Pj4gKwkJcmV0dXJuIHRlc3RfYml0KGIsICZmbGFn
cyk7CQkJCQlcDQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICtlbnVtIGNtX2lkX2ZsYWdfYml0cyB7
DQo+PiANCj4+IFRoaXMgc2hvdWxkIGJlIGNhbGxlZCBjbV9pZF9wcml2X2ZsYWdzX2JpdHMuDQo+
PiANCj4+Pj4gKwlUT1NfU0VULA0KPj4+PiArCVRJTUVPVVRfU0VULA0KPj4+PiArCU1JTl9STlJf
VElNRVJfU0VULA0KPj4+PiArfTsNCj4+Pj4gKw0KPj4+PiArQklUX0FDQ0VTU19GVU5DVElPTlMo
VElNRU9VVF9TRVQpOw0KPj4+PiArQklUX0FDQ0VTU19GVU5DVElPTlMoVE9TX1NFVCk7DQo+Pj4+
ICtCSVRfQUNDRVNTX0ZVTkNUSU9OUyhNSU5fUk5SX1RJTUVSX1NFVCk7DQo+Pj4gDQo+Pj4gSSB3
b3VsZCBwcmVmZXIgb25lIGZ1bmN0aW9uIHRoYXQgaGFzIHNhbWUgc3ludGF4IGFzIHNldF9iaXQo
KSBpbnN0ZWFkIG9mDQo+Pj4gaW50cm9kdWNpbmcgdHdvIG5ldyB0aGF0IGJ1aWx0IHdpdGggbWFj
cm9zLg0KPj4+IA0KPj4+IFNvbWV0aGluZyBsaWtlIHRoaXM6DQo+Pj4gc3RhdGljIGlubGluZSBz
ZXRfYml0X21iKGxvbmcgbnIsIHVuc2lnbmVkIGxvbmcgKmZsYWdzKQ0KPj4+IHsNCj4+PiAgc21w
X21iX19iZWZvcmVfYXRvbWljKCk7DQo+Pj4gIHNldF9iaXQobnIsIGZsYWdzKTsgDQo+Pj4gIHNt
cF9tYl9fYWZ0ZXJfYXRvbWljKCk7DQo+Pj4gfQ0KPj4gDQo+PiBPSy4gSSBzaG91bGQgYWxzbyBw
cm9iYWJseSBtb3ZlIHRoaXMgdG8gY21hLmMsIHNpbmNlIGl0IGlzIG5vdCB1c2VkIG91dHNpZGUg
Y21hLmM/DQo+IA0KPiBZZXMsIHBsZWFzZQ0KPiANCj4+IA0KPj4gQWxzbywgZG8geW91IHdhbnQg
aXQgY2hlY2twYXRjaCBjbGVhbj8gVGhlbiBJIG5lZWQgdGhlIC8qIHNldF9iaXQoKSBkb2VzIG5v
dCBpbXBseSBhIG1lbW9yeSBiYXJyaWVyICovIGNvbW1lbnRzLg0KPiANCj4gSXQgaXMgYWx3YXlz
IHNhZmVyIHRvIHNlbmQgY2hlY2twYXRjaCBjbGVhbiBwYXRjaGVzLiBUaGUgbW9zdCBpbXBvcnRh
bnQNCj4gcGFydCBpcyB0byBoYXZlIFc9MSBjbGVhbiBwYXRjaGVzLCBvdXIgc3Vic3lzdGVtIGlz
IG9uZSB3YXJuaW5nIGF3YXkgZnJvbQ0KPiBiZWluZyB3YXJuaW5ncy1mcmVlIG9uZS4NCj4gDQo+
PiANCj4+IFRoYW5rcyBmb3IgeW91IHJldmlldywgTGVvbi4NCj4gDQo+IFRoYW5rIHlvdSBmb3Ig
bGlzdGVuaW5nIDopDQoNCkZyb20gY2hlY2twYXRjaDoNCg0KRVJST1I6IGlubGluZSBrZXl3b3Jk
IHNob3VsZCBzaXQgYmV0d2VlbiBzdG9yYWdlIGNsYXNzIGFuZCB0eXBlDQojNDc6IEZJTEU6IGRy
aXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jOjUxOg0KK2lubGluZSBzdGF0aWMgdm9pZCBzZXRf
Yml0X21iKHVuc2lnbmVkIGxvbmcgbnIsIHVuc2lnbmVkIGxvbmcgKmZsYWdzKQ0KDQpGcm9tIFc9
MToNCg0KICBDQyBbTV0gIC9ob21lL2hidWdnZS9naXQvbGludXgtdWVrL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5vDQovaG9tZS9oYnVnZ2UvZ2l0L2xpbnV4LXVlay9kcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9jbWEuYzo1MToxOiB3YXJuaW5nOiDigJhpbmxpbmXigJkgaXMgbm90IGF0IGJl
Z2lubmluZyBvZiBkZWNsYXJhdGlvbiBbLVdvbGQtc3R5bGUtZGVjbGFyYXRpb25dDQogc3RhdGlj
IHZvaWQgaW5saW5lIHNldF9iaXRfbWIodW5zaWduZWQgbG9uZyBuciwgdW5zaWduZWQgbG9uZyAq
ZmxhZ3MpDQogXn5+fn5+DQoNCg0Kd2hpY2ggb25lIGRvIHlvdSBwcmVmZXI/DQoNCg0KSMOla29u
DQoNCg0KPj4gDQo+PiANCj4+IEjDpWtvbg0KPj4gDQo+Pj4gDQo+Pj4+ICsNCj4+Pj4gI2VuZGlm
IC8qIF9DTUFfUFJJVl9IICovDQo+Pj4+IC0tIA0KPj4+PiAxLjguMy4xDQoNCg==
