Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2483AE4AB
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUIXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:23:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41622 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhFUIXJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 04:23:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L8BDw8018605;
        Mon, 21 Jun 2021 08:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=z9z7Nk9MT6lEJ5v7129S5fb9brbOcqSl0goi9kgGC80=;
 b=XPi3dp+76J3KnxbIdSrr9t/Yr7QeFRumdzNp5x8Lc0Wt3UpxnJx8YznmqxAo1nfjiP2B
 JwUoZaKpfAfqoJuBJdQVio5AuVsMnNFzrxzRcZ+Ay8pmEbBVxLAnLew++ifdptvfdcZK
 9R6+RgzaQBRD5wirKmo9n+eKT7k/elaL3tLgtT7e/S7VdX8KrRoUH1TLG0WIWuG9Ezg2
 spIr5wCRopEwsGicoQU/SpCq6BfIOCgasFb3ic6PgFfyqxIc/M4n7BqdQ5p/Rti26kVT
 jdIx2ewjqpB5JwZ6lHqZaGChAub+W+e8ahlMHO2wC0b3uVC+BHVilGPhhJ1oo88Asiq5 FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39a65th0vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:20:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15L8FR6P172085;
        Mon, 21 Jun 2021 08:20:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3998d5e427-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhG7p7wfBZo6KwRFSLuEcx3jti/F+QHloCGyoYA6tg8FlrPZ8BUhqTmtutZbDBpGIXpfugIl9Kt+sOPwXe69PAev/fjqR29uApiXBez2WWK1YJakUm8bLuFPEeJfD3NrYyuLHyRl2LIjDALXCNcYOCl1YOQrN7AEy1QjVk3nXM+eNpOvK1RoTOOrBwlLd8e3wtoK8qPLIx9N8+X/MPm7ns4tkirocr3hvBsMET++ZK2Qh2sfChQqC9zWY+cjubYGK9OH/AI5StBuXO+tTcu3jea4h2lQa8+yYqaAjOz9p6KxWMtEewZDfFR1vkYMD+ecO9pNxatbmh0iIqpa8WVLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9z7Nk9MT6lEJ5v7129S5fb9brbOcqSl0goi9kgGC80=;
 b=gK4v9KWQicifDZI42D1dhaqRVScEEv7bn0gawNNVpYjLQ5fJPvoYcFlwYFER6wks9UYE3fea9MUp1JfZGNgfje8VUkdDjVwB9rOoCN0gpwD9TD72OWD4sP0ilt2M1hxe8JT5DBGaVEMl9VTNVTHyDTIjtCMFE2BSt2sMwYkiuV4dQKBXRXKWGj6JTwnNwUg7i0uom5IQPh/Xl/Ov765uM+xV3VpWAhAFQlmKwW63kpkZP6JP6IOdehlio0TUbgn3JfOeEwFSWTSEJN/hrbrL7dgOzqEUfo79z05uX4ZRaUVdLpNhAww+GKcekAsqJYtyHPKnUGusATJdYvbmXavHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9z7Nk9MT6lEJ5v7129S5fb9brbOcqSl0goi9kgGC80=;
 b=nh7cZ3ejukdBL/tj4iZA8U3iEkBuQixDIyAsheDUbxzckmswJQ+fx71ck3T0XrlkmM8Sd3MiLEQitC4/M+vQ9HMgHNbGE17hTOhUhPHhhjdD3Kq7EcucxOpkl/g0Jk4Ko2XV0IiVaeyD1EF8Z4X3KPbEDCMX2CLc0ybKvrlOENs=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (10.175.59.12) by
 CY4PR10MB1719.namprd10.prod.outlook.com (10.172.71.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Mon, 21 Jun 2021 08:20:47 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 08:20:47 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXY3iqQ+lwecvXsUKE5x7HSp6gYKseEhgAgAAToQA=
Date:   Mon, 21 Jun 2021 08:20:47 +0000
Message-ID: <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
In-Reply-To: <YNA7ZnKIKC217pCw@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 960c7959-75ce-4d57-b192-08d9348d78de
x-ms-traffictypediagnostic: CY4PR10MB1719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB171914601F829DB363A2D3EEFD0A9@CY4PR10MB1719.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIkJqKKQ8s93tALvXw2gqykSWQKCp25wnQTvfJQDlT2men8I09OVF6aofGPBiN55z9OiG+tVacLbon1eXNgbfuabioGi51FjDu+fF3yLJfBTat5/qHAXttyimk7abGlloXFjLJkcTcSrVN31ymUfNFAPPKk8aAaA4CVbCLNW6QqVlX6B5p8cxzPOtLRNqeoLe7/IceMruGxG3vuDHCJBB9NsalHoyicADO5pGLBUy6VD8P2ZgXpySoKG8LcaCUW5lAbXe4Ld0qVTFEvEH2EzyD8T1rGExBA6fsTHZUDKHkhDLR7Rn7JaMxef9Na4MMrAJZki72EVeiKuS+SjnicqzbUspokhPbacsLdWbIrrSvnLf3xHoDgoy9o6c7o2CFi6qcePvH6RXR3F6OW5ssm1We2Cx6QuNLrAdlFGhEF/gavaKFRDaLycMuPyKac1fr97NsaEt1ccoP7x4Z3drXOzlMkAyvm9QFyOezICYXjZ6DeEjLfXGF7EUrYZG/0LXs9rvxrEsVC7NuvugAGJnFrsGiLUhIcG8QwJrFjh5YAh8/jgtLKYYJznqXH8MRvQ4SyUMFchotOYRekt0757RMy+DuCrPaEKLV5Q5JYxX2uMtfAftWTPcWTFItYx9U3wpGrXDS3/wBfS3sxr76MYTQvAb1NM2IlFAZVatojK4UOjS8RmrSvhJ0rzKXvNavI8X3W56Hn8UTO6KdgnVv3KW2zKJhyAo1N85HkhAk+ETXcbQfrzy8LnbPp8MgBJw0p03Ysm3aXUW4fofy5FIHRFxP8hag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(316002)(5660300002)(186003)(2616005)(86362001)(6512007)(4326008)(53546011)(36756003)(54906003)(107886003)(2906002)(966005)(478600001)(66556008)(66476007)(38100700002)(91956017)(76116006)(26005)(83380400001)(44832011)(8936002)(66446008)(64756008)(8676002)(122000001)(6916009)(66946007)(66574015)(6486002)(33656002)(6506007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkZUa3k4UkhvRjlBWkYrOWVib20zcVJXUTlYRk1QOTZ5ZEk3R1JnUE54NktG?=
 =?utf-8?B?SWZhSHdxeDV5bTVqYW4vb1V1NldRdGJmVTRhOUZQMElmYlYrUm4zZVA2R2RE?=
 =?utf-8?B?RGx3VEdMbUk1K2hyR2NsZlZ6ZHpPTWJHL3I3bklNUzJxaHFLNFRwb3pMVEFY?=
 =?utf-8?B?OVFYTkpZdWRkNVdQcHhJM3dtcXFCNXNlWTA0VjVKTS9xZzZzL2RCdG13dzNi?=
 =?utf-8?B?UnVQS1BncTU5dzUxY0lHZWd2elZWbTJFY1ZjWE5FSENKZnhrTXBmMFpUa29w?=
 =?utf-8?B?b1MxWG85ZG90d2RQZmsyUzRaWk9LQzNJNGNORWlHMXk3WWhoVHl1bjc0V1lV?=
 =?utf-8?B?VHRsc0QrTGIvLzhYaE1LakNETm9IZzdiVGNxaUVzRFNHTy9zRWFnS2ZsWEx4?=
 =?utf-8?B?TnpGZDEwUVlUdXRlZzNpSE95ajM0K0FIT1RwVnQzeExNeE5OaklabWxvTjFp?=
 =?utf-8?B?S1h6WkZWa01GTFhFaDl6Tm0yZ2g4SFpNbVIrYWQ2TjMrNXJ5NFg4SGQwTHNj?=
 =?utf-8?B?bW9pVHA2RWV1S1M3QktFMjZNeWs5ODVpazVjMXU3OHhNRDdyRlZpOXdSQTkw?=
 =?utf-8?B?K2xhWmlsUDFlM1diczhUdFU0UzVxcjBaWWMwMTA1cmJYdzhrQnJmYWRMY3pB?=
 =?utf-8?B?MlpFcDluRVppYWNrbmV6UWdBQ1JBMHVoSnNDcVlNMzhSOHptUElRZ2EvRTAy?=
 =?utf-8?B?Y3FLQUdGVWd3ZUZiQU0xdEJCVnBiQmNsRnZUQUhpRDE2Q3ZtUFh1NzhEeWZl?=
 =?utf-8?B?eVhPSGwzK1d6L0U0aWZ2b2NnYXBDNlY0NUwzbjdZNGVEZmZyanNXa2k2bkd2?=
 =?utf-8?B?QUR0NnpGZXE3bmhBR2E2R2RWWEI2MTNlTUg5VXY4L0FlRlVQMWhwUlJtVGpr?=
 =?utf-8?B?U3BESFdUWWdLK09QUkczYTFWakw1NW9SMHczSGYyaGNZaUJNWGVtY0tjL3Yx?=
 =?utf-8?B?QjE0RHdkRTlTbGx0K0tEYXlRVG11c1UzVkxLM3B5eW1rU2wrckJ0L3RrL2Jx?=
 =?utf-8?B?amxieEtoWmlsNzNPTHNJakJnSG1remhac0QzRmZvSXIwRFNQUjB1aGM3VlNm?=
 =?utf-8?B?cU43SEtHMHFxc1NiNExGOEpCVUNzaVJOZEFNcUJhUFFoREZPV01SblhzdENM?=
 =?utf-8?B?d2dCcmpZcEJwcGxKc1RBS294MXVJeDRxR1h0cUtTZWx3OWt6TXdGMkhPQVFs?=
 =?utf-8?B?ajNOUmNlRkpiZElRT1JKRmJQZHhobCtLOHk0TUZRQWpnZW53eWxXN1AzajBp?=
 =?utf-8?B?eHpLbHo2UmIzVmpma1c2eGZZdGlteUVlbWJUR2dzTUJJd2g2aDhQa3VXVi9P?=
 =?utf-8?B?dGZCT1loSWZQOXRvVEVGRU9FcktlR3c4L24vYUE0R0huM012Uy9LQTNDeGJP?=
 =?utf-8?B?VjkxV0RRdzlTdzJhcEJQbW96OEhEcmFuK1hjcEYzSkc3QkVGNlJDalJxSUx4?=
 =?utf-8?B?d0FEblFORlpLbXkvcHhSdU1VYTVzVENJcnRwcHNuSW4wWnN2Y0RWcDBkWk45?=
 =?utf-8?B?R2hON0pBT2x4angya29NblJkQzFvbzVXS2x3V0ZoVTJZS2ViSHhMYW16c0dL?=
 =?utf-8?B?cnBRdE1BNjZybHN1R3BuK1FtRW1POVJIM1ZsM0JYVmNTZzM3QjhqYlM0QnZI?=
 =?utf-8?B?cWtIUGI1dlozZ05VY3pLaFMvNTdVUjVPNDNJcFhLRFRLWWJjWVM5VUdmMkMz?=
 =?utf-8?B?ckFOeWt6UmNhaGV5ZHlUU2ZJa2oyUHg0RCtmaVhkNytyQldsSGl4TVgreHo1?=
 =?utf-8?Q?HGZZNdC8ktbrAMcYmnVM1/uvyx9IYXmfx+P4N6Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C46FD0D4089AB34BB038BC7034766C14@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960c7959-75ce-4d57-b192-08d9348d78de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 08:20:47.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrm0ay33a4uqPdVgau23rbwufgnpPSqdlBgUW629lw/738qve1mtiBIAkry3Xnaj1OtJLgT4gvTRE/7mXClJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1719
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10021 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210048
X-Proofpoint-GUID: 5nB7udpik5M2uAwAvjjm6hL5LgRC0Sjq
X-Proofpoint-ORIG-GUID: 5nB7udpik5M2uAwAvjjm6hL5LgRC0Sjq
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDA5OjEwLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxNywgMjAyMSBhdCAwMjo1OToyNVBN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBUaGUgc3RydWN0IHJkbWFfaWRfcHJpdmF0
ZSBjb250YWlucyB0aHJlZSBiaXQtZmllbGRzLCB0b3Nfc2V0LA0KPj4gdGltZW91dF9zZXQsIGFu
ZCBtaW5fcm5yX3RpbWVyX3NldC4gVGhlc2UgYXJlIHNldCBieSBhY2Nlc3Nvcg0KPj4gZnVuY3Rp
b25zIHdpdGhvdXQgYW55IHN5bmNocm9uaXphdGlvbi4gSWYgdHdvIG9yIGFsbCBhY2Nlc3Nvcg0K
Pj4gZnVuY3Rpb25zIGFyZSBpbnZva2VkIGluIGNsb3NlIHByb3hpbWl0eSBpbiB0aW1lLCB0aGVy
ZSB3aWxsIGJlDQo+PiBSZWFkLU1vZGlmeS1Xcml0ZSBmcm9tIHNldmVyYWwgY29udGV4dHMgdG8g
dGhlIHNhbWUgdmFyaWFibGUsIGFuZCB0aGUNCj4+IHJlc3VsdCB3aWxsIGJlIGludGVybWl0dGVu
dC4NCj4+IA0KPj4gUmVwbGFjZSB3aXRoIGEgZmxhZyB2YXJpYWJsZSBhbmQgYW4gaW5saW5lIGZ1
bmN0aW9uIGZvciBzZXQgd2l0aA0KPj4gYXBwcm9wcmlhdGUgbWVtb3J5IGJhcnJpZXJzIGFuZCB0
aGUgdXNlIG9mIHRlc3RfYml0KCkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdn
ZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIFdlc3Rn
YWFyZCBSeTxoYW5zLndlc3RnYWFyZC5yeUBvcmFjbGUuY29tPg0KPj4gDQo+PiAtLS0NCj4+IAl2
MSAtPiB2MjoNCj4+IAkgICAqIFJlbW92ZWQgZGVmaW5lIHdpemFyZHJ5IGFuZCByZXBsYWNlZCB3
aXRoIGEgc2V0IGZ1bmN0aW9uDQo+PiAgICAgICAgICAgICB3aXRoIG1lbW9yeSBiYXJyaWVycy4g
U3VnZ2VzdGVkIGJ5IExlb24uDQo+PiAJICAgKiBSZW1vdmVkIHplcm8taW5pdGlhbGl6YXRpb24g
b2YgZmxhZ3MsIGR1ZSB0byBremFsbG9jKCksDQo+PiAgICAgICAgICAgICBhcyBzdWdnZXN0ZWQg
YnkgTGVvbg0KPj4gCSAgICogUmV2aWV3IGNvbW1lbnRzIGZyb20gU3RlZmFuIGltcGxpY2l0bHkg
YWRhcHRlZCBkdWUgdG8NCj4+ICAgICAgICAgICAgIGZpcnN0IGJ1bGxldCBhYm92ZQ0KPj4gCSAg
ICogTW92ZWQgZGVmaW5lcyBhbmQgaW5saW5lIGZ1bmN0aW9uIGZyb20gaGVhZGVyIGZpbGUgdG8N
Cj4+ICAgICAgICAgICAgIGNtYS5jLCBhcyBzdWdnZXN0ZWQgYnkgdGhlIHVuZGVyc2lnbmVkDQo+
PiAJICAgKiBSZW5hbWVkIGVudW0gdG8gY21faWRfcHJpdl9mbGFnX2JpdHMgYXMgc3VnZ2VzdGVk
IGJ5IHRoZQ0KPj4gICAgICAgICAgICAgdW5kZXJzaWduZWQNCj4+IC0tLQ0KPj4gZHJpdmVycy9p
bmZpbmliYW5kL2NvcmUvY21hLmMgICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIHwgIDQg
Ky0tLQ0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMo
LSkNCj4gDQo+IFRoaXMgcGF0Y2ggZ2VuZXJhdGVzIGNoZWNrcGF0Y2ggd2FybmluZ3MuDQo+IA0K
PiDinpwgIGtlcm5lbCBnaXQ6KHJkbWEtbmV4dCkgZ2l0IGNoZWNrcGF0Y2gNCj4gV0FSTklORzog
bGluZSBsZW5ndGggb2YgODYgZXhjZWVkcyA4MCBjb2x1bW5zDQo+ICM2OTogRklMRTogZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvY21hLmM6MTE0OToNCj4gKwlpZiAoKCpxcF9hdHRyX21hc2sgJiBJ
Ql9RUF9USU1FT1VUKSAmJiB0ZXN0X2JpdChUSU1FT1VUX1NFVCwgJmlkX3ByaXYtPmZsYWdzKSkN
Cj4gDQo+IFdBUk5JTkc6IGxpbmUgbGVuZ3RoIG9mIDk4IGV4Y2VlZHMgODAgY29sdW1ucw0KPiAj
NzM6IEZJTEU6IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jOjExNTI6DQo+ICsJaWYgKCgq
cXBfYXR0cl9tYXNrICYgSUJfUVBfTUlOX1JOUl9USU1FUikgJiYgdGVzdF9iaXQoTUlOX1JOUl9U
SU1FUl9TRVQsICZpZF9wcml2LT5mbGFncykpDQo+IA0KPiBXQVJOSU5HOiBsaW5lIGxlbmd0aCBv
ZiA4NiBleGNlZWRzIDgwIGNvbHVtbnMNCj4gIzEyNzogRklMRTogZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY21hLmM6MzA0ODoNCj4gKwl1OCB0b3MgPSB0ZXN0X2JpdChUT1NfU0VULCAmaWRfcHJp
di0+ZmxhZ3MpID8gaWRfcHJpdi0+dG9zIDogZGVmYXVsdF9yb2NlX3RvczsNCj4gDQo+IFdBUk5J
Tkc6IGxpbmUgbGVuZ3RoIG9mIDg0IGV4Y2VlZHMgODAgY29sdW1ucw0KPiAjMTM2OiBGSUxFOiBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWEuYzozMDk2Og0KPiArCXJvdXRlLT5wYXRoX3JlYy0+
cGFja2V0X2xpZmVfdGltZSA9IHRlc3RfYml0KFRJTUVPVVRfU0VULCAmaWRfcHJpdi0+ZmxhZ3Mp
ID8NCj4gDQo+IDAwMDEtUkRNQS1jbWEtUmVwbGFjZS1STVctd2l0aC1hdG9taWMtYml0LW9wcy5w
YXRjaCB0b3RhbDogMCBlcnJvcnMsIDQgd2FybmluZ3MsIDExOCBsaW5lcyBjaGVja2VkDQoNCllv
dSdyZSBydW5uaW5nIGFuIG9sZCBjaGVja3BhdGNoLiBTaW5jZSBjb21taXQgYmRjNDhmYTExZTQ2
ICgiY2hlY2twYXRjaC9jb2Rpbmctc3R5bGU6IGRlcHJlY2F0ZSA4MC1jb2x1bW4gd2FybmluZyIp
LCB0aGUgZGVmYXVsdCBsaW5lLWxlbmd0aCBpcyAxMDAuIEFzIExpbnVzIHN0YXRlcyBpbjoNCg0K
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMDkvMTIvMTcvMjI5DQoNCiIuLi4gQnV0IDgwIGNoYXJh
Y3RlcnMgaXMgY2F1c2luZyB0b28gbWFueSBpZGlvdGljIGNoYW5nZXMuIg0KDQpTbywgaW5kZWVk
LCB0aGUgY29tbWl0IHBhc3NlczoNCg0KJCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3Qg
LS1naXQgSEVBRA0KdG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAwIGNoZWNrcywgMTE4IGxp
bmVzIGNoZWNrZWQNCg0KQ29tbWl0IGQ0ZDBkY2Q5NTEzZSAoIlJETUEvY21hOiBSZXBsYWNlIFJN
VyB3aXRoIGF0b21pYyBiaXQtb3BzIikgaGFzIG5vIG9idmlvdXMgc3R5bGUgcHJvYmxlbXMgYW5k
IGlzIHJlYWR5IGZvciBzdWJtaXNzaW9uLg0KDQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQo+IA0K
PiBUaGFua3MNCg0K
