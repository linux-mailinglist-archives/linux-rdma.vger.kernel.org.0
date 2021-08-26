Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CE3F8B67
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhHZQAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 12:00:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13434 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234549AbhHZQAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 12:00:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QExRGr025067;
        Thu, 26 Aug 2021 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e/uKzqBbm4V0dD0L1bCD6SahoO3qPMAvDgTeIbJ6hBE=;
 b=TKy7xQJxnqZBKSPZcdjWd19LfLTWjZgDkKRaTML2ztafJvCjOL+8MXIPEaKQzQdOvRC4
 KEJNroUAgAejq/tJ/61yGOkRonNjUie15gM1dCdaiP5QWNJWRKL1bgrBet9d4ypVSNNb
 Dt+C6zoDfalIKVzAxcqhFNEbluJxwMmAWq+fMu2cXvZIFZBdEQpD1dd3ErmErQYu3HTH
 hWA/cHeA3rpiHpY7BssqQtkdEwWPqaVyPMRAbwsfE6+7gWdQKssdmF/rPamDcmfuz1Yn
 zhl9MKAb1aUfCOIkUr0hSbhbiF4ZUASUP6GgAxi67Cjd2SldB5OFEzYnFBqT1EExAlXH 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=e/uKzqBbm4V0dD0L1bCD6SahoO3qPMAvDgTeIbJ6hBE=;
 b=oDvYVw02Yx4OCqPVe9qKbFv8dOT4zegZT+qBK1lLG2QKKVPYLCtgAempgIDVmvZ9nPju
 a9Yhmi+7yOlvH7veYA1BlyJAbP5TPx7dj5PgFnHy1UXd4ieVJkTPRRGbpcGK7YYawqAL
 xdJ4/3cWVr/rq0STSnyQ3dD3olPTtYUq4isoiE/diOlVBEUTMhPqAkmbDPZOs84LQlbs
 i3NKIyUKBW4OohP151bYrt85edO8g66SXAdJjRGX1DofPCGjTosmr1bjmMxsdhs9SD8/
 CgHsSrD8FcxunH/6Rpw1zCDAOsWhCAVNxJy2GIipQPXsx0SLjqTnSr5IQSjp3zT8uXyD FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xp9r48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 15:59:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QFnWW0037399;
        Thu, 26 Aug 2021 15:59:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 3ajqhju5e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 15:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co/OV2Ccu0/8NvPGvjzkrgEvwdYmCqrGP5k4huedNJM2idHaTgAS8QOhFa6z4932b5vRiKpN4IWO1fr+8YfJQUW5n+9wvQ/WRC53Xnkxutjeh/O+5yjr6q6Aotf5MoocLe991hPhfLNkPHRxOeJeYnmIiiDjh7PAyLx80KZFIT4Ah8KBx+6gshxbqxHoDMVJXrJY5hv4QK08BTSJ8Sw6hj7d/PLJZGBOi6Ge0eUQw84Q/tKPACmkAxVXO89K1O/lQF+Kzmt5W9a7Ncj9Ae/zpw3AGkrc+Wa7txW/dNZxZhySgG10W73jiaBBOjitCEhDwWua3s2NEXi+Ebo00heQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/uKzqBbm4V0dD0L1bCD6SahoO3qPMAvDgTeIbJ6hBE=;
 b=lf62qNyqiHPefF7Jk/xBscmNAmloP7cdmKq85YkLHnS6D+6S9hju571xWbIZgwi2iijNpQn0ErBhs4R1q1scbb+upwqcRTfXBLmBk0dLvI11NXduea7Bey0ksy0lVEeXKJiVJorTRTKVFoSBDp09cUCLrxS4wFtr8DB42EPEy0G7O4wlKke2+HJKMyxT+PYPeufBt4bhVrXqjToS9PRRH5CUvS2MaqNINpQmfLcKttIsfVtThQrmoV4rBnc5PON29xymZM0yDyu4dk+1D3WXT60gsUzkJnzedfGgF7EV68RkLTB9Gt8RLm9PLGSwU+0+U3vHZHFm2CDM8HZvUwvkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/uKzqBbm4V0dD0L1bCD6SahoO3qPMAvDgTeIbJ6hBE=;
 b=fCMcCbOEzg5kXM02odp26BqmZl0b8Z/2K61Whc6OaLEFHezfeMI+7ubgfTqlmaiIOY7jREHnDGYBsG4P6acXs0jDR0/WR3XppIbV7+47iDNQyNXjXgt7o1yEVA8Zq9H/+x/gat9WDPSPX973PgHU27iRsY4p8nLJAzP9AAjARrk=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DS7PR10MB4941.namprd10.prod.outlook.com (2603:10b6:5:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 15:59:46 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 15:59:46 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Thread-Topic: [PATCH for-next v2] RDMA/core/sa_query: Retry SA queries
Thread-Index: AQHXj5U1pGh4t5fRsUGkipTXxVNmY6uElBAAgAFzjIA=
Date:   Thu, 26 Aug 2021 15:59:46 +0000
Message-ID: <09CD5ACD-0147-45D5-8620-39FBF94CC02C@oracle.com>
References: <1628784755-28316-1-git-send-email-haakon.bugge@oracle.com>
 <20210825174956.GA1200145@nvidia.com>
In-Reply-To: <20210825174956.GA1200145@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06c5d668-384c-4783-18af-08d968aa86b0
x-ms-traffictypediagnostic: DS7PR10MB4941:
x-microsoft-antispam-prvs: <DS7PR10MB494129939863E9446FFFD678FDC79@DS7PR10MB4941.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjQCzzS9P+2PyXDbKnalqU0BOQ+Kfd1bxcwEDrflcYyQXZMhkmZYE71norw/s5E02QMM0w9dT7f46XhkQ9se7dVlhxsZNxwNyMTWdd43EjimeGEMUaA4GhIauzs+nQg4ZJSRftSw732vA00jnPXshilVe6z8mjB7XgLdj38ofra/6ysuxCFJdqdmfdsA7Yn4yCMymOes5xIHI0IWA694DIFEXFJLCKWzb3oNzgdaiKGGJpvtLDJjw0Hmqz/XZmEX8u3ZmH/sOSHQQ3BZE7qta4XKsc5Auycg8YuLt0E0FoXNQCICrvxofKisITvQN2ROUSYRM2Nx/fstTDWYfj78VQuK8l7fyaECcmFDwUWPDogHsWGEbWd5U5+ZnpgST7egIz5BgU4h0ws/6ZYN98bAW7R9N60I74Ne5hOQ1ZgGMgvdip4UVGMUz+o1RDiVQw191S5ny6fcsoRUTfOw/fSqTEdLIwlbKhZki2huLu9yxPkOmMPkmK3PqfaKDQP/ot1/I4tibCt+bX7YFKgrqFImwDoGAf/EfGJQv7GBcaOjCjhBrBbcz6Vilmcm4azjQpl4NdPzakGXu4dqO+9awA3eL5OuUyqyzpSpkMs5dAudwXPDcKc5lnsGRMMI4aGZB3Mifebbqk7nAd1rB6ilVbVhm5y9ayJi3bnM/sOJvl6LRC/lmN8pu6zQvq6VxwLx79/bD3d2GkTk82O+e8lwzH2EKLxT/9z8+DKQXeJnt+jV4kXa/HT0k2xrN8xNwUZGD180
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(44832011)(83380400001)(6486002)(26005)(4326008)(316002)(5660300002)(54906003)(86362001)(6916009)(38100700002)(66574015)(2906002)(38070700005)(122000001)(2616005)(64756008)(76116006)(478600001)(6506007)(53546011)(66476007)(66446008)(66556008)(66946007)(33656002)(8936002)(8676002)(186003)(71200400001)(36756003)(6512007)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW1ZVmVTOFlmbnZNTGVNdUIwQTBTS2ozZ1BGTncyVFVZMEE3N3g2cU1TL0lh?=
 =?utf-8?B?NmZpUXNyMVA3U2RIZXdsWTVXdmpmeCthRXREOUxPSnllN2RQZkpKVys3WTJ5?=
 =?utf-8?B?ejg1MVNlTk51NjBtUmxMK0tKbXhqQ255KzkyVXlIbGlTSmk1SXhTVHZOc0gy?=
 =?utf-8?B?UmRsUDZ3emVOMkZCTlJXdlBTcGkvakoxUUh3RnFsZ1RobEFDSkZSVXVCYlJx?=
 =?utf-8?B?bTNKL0FJZ1VPdVpMNjVmUG1HM2pmUlhxaHNiMVpETXkrN0JpWjdoekJKbW83?=
 =?utf-8?B?T1p6UFdZT2FveTBHN0lkcUhxQXpvZFo2ZlhPM09ocGVqZkt1SDBjNDA2SXMr?=
 =?utf-8?B?ZVpqY0o2R3VMeWZsc3VxNG1EVVhQcmNocDVneVIzdDlRUWZOdjF1WllNekNt?=
 =?utf-8?B?dlJpMi9uVkp4WWpVZmFPZnZqd3crcnZhMzlyNE04TXNKaTFXU3FpeFRNNTB1?=
 =?utf-8?B?dFQ4cVJKenpCMVRINlJlOGRzSmdHcTYvN3VuMHVJMjJxQ3ZweWZONjFuSGtN?=
 =?utf-8?B?clU2V1JIQ2dsa3dkeVovdlNyMlNMRDI4QUFpMXY5MGpmWGdFeXNaajl2Qmsw?=
 =?utf-8?B?UnROa2poOUIrTFppSlFXSUF3c0RRdHJ0Q3MrN1REanJrL2tUQjdoZzgxTCtQ?=
 =?utf-8?B?S3ZJQmhidjQ1cWJVN3cwZk95dkRXK2N3WGNrVGxGUkhXZE9MZzNqUjVta2d2?=
 =?utf-8?B?c2swSWh3MDNabDlMWmJ0dzhEWXFqOGpCclNUdEJBakJ1c280QXRYQUxzU0Rp?=
 =?utf-8?B?aFYwNU5xbks0RVRqL09zb2tvRHN3U2hvVk5lZU9KeG53NlJSdHNhV1JxTVJi?=
 =?utf-8?B?bHBEMmRjUGVkMFlPdUNmMHQ1dlZKeVIzUFp5UWpiNWpKWStwZjRWdnhDNXVi?=
 =?utf-8?B?ZHNackNoWFI1c1VnUytqenZUbDNmQjRDQXAyWllvOXJXamkwcDlzNVhGOXZy?=
 =?utf-8?B?TEtrUEJOYVB2eHVLUE5DeWxkalcyQytxSkZPMTJYUWVnbG53bUZMcjExZUlO?=
 =?utf-8?B?aENWSFFsVzNyUjAwZjV0MVV4SnUxWCtFYjZ0R1hIU1NNUFpBaVFFbGsrOXJC?=
 =?utf-8?B?VythTndYd3FzckJ3b0pPbGNsOTk3OTZYVXI4Tk0zSkE2MjFDOUs3Q1lBRjlB?=
 =?utf-8?B?OG9WWGFCa0o1RXZ6K25VZmtsR2V0dXJFaTRQV2ttZjJYUEFTeWJUbHlBR1E2?=
 =?utf-8?B?VGJWZml2QStJRnFtRDlxQ1V3WGJndHN2QzlPVVpaZk5nZGg3Y0l6Y3lqTjlK?=
 =?utf-8?B?c0wzM3RRWDNhcHZ0a3FSVHJjL0RMVTFtL0JLTFZUQWZ5YUx6WC9LUlNiN1h0?=
 =?utf-8?B?S1Nha2crQWwxS3NiMmJJdTdkUFBvc2t1R0s5ZkhzeUpzZTFtZW16Ky9kYVV3?=
 =?utf-8?B?eVptNTN4MG5iWWF1R1RHUjZrWnU0cWJiSVZNNTZxVFRxZWtTOE9DVWVueXlw?=
 =?utf-8?B?Sm96bzRVdEVoS21NY3RvOEtBZTFHTDk3UUZqWk5PdE16TlovcElQMWhKNHV3?=
 =?utf-8?B?a29WZmZNMThQd0tyN21qNGlzd3RzY3BsOU00L3RLbUF0VExVRnJuVnUzQmky?=
 =?utf-8?B?L2hGM1hPdFFYSzQ1Kzg4K0NaTEFMK2tTYTBLd1dTbDRqZ2t0d013dXA4M1Vh?=
 =?utf-8?B?NkkyYWI5NUZaUm51MUl4ZnVKZVR0Q2RiTDJDY1NXTmtFbEpPUzV5VXRPeEJ6?=
 =?utf-8?B?RSt0QkhENHRqWnN1K3I2Z3ZwYUtvVGFiWkIvVUE5RzEvSTJkYjI4N1JHVmNm?=
 =?utf-8?B?NDNTcmtISCtMbDZMZE9vL0RTTGFwQWpNTFh5YUR1SFVQTVppSkhXcUxObVdK?=
 =?utf-8?B?ckZNSW5QVTJvTS9mQUNHdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB62311941F8884E90E8BECBCB06E05C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c5d668-384c-4783-18af-08d968aa86b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 15:59:46.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cetq5wfwDsbD0OSp167cYrYCCOs+vdG8S99aFXvh3ep6FjuCavemw+leXxHFBuNijTwfOT+YjNY5NWZowTfJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4941
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260089
X-Proofpoint-GUID: 3KfJ40pOfF9zHN-IzrBFFsaqTFwXeXJP
X-Proofpoint-ORIG-GUID: 3KfJ40pOfF9zHN-IzrBFFsaqTFwXeXJP
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjUgQXVnIDIwMjEsIGF0IDE5OjQ5LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDA2OjEyOjM1UE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEEgTUFEIHBhY2tldCBpcyBzZW50IGFzIGFu
IHVucmVsaWFibGUgZGF0YWdyYW0gKFVEKS4gU0EgcmVxdWVzdHMgYXJlDQo+PiBzZW50IGFzIE1B
RCBwYWNrZXRzLiBBcyBzdWNoLCBTQSByZXF1ZXN0cyBvciByZXNwb25zZXMgbWF5IGJlIHNpbGVu
dGx5DQo+PiBkcm9wcGVkLg0KPj4gDQo+PiBJQiBDb3JlJ3MgTUFEIGxheWVyIGhhcyBhIHRpbWVv
dXQgYW5kIHJldHJ5IG1lY2hhbmlzbSwgd2hpY2ggYW1vbmdzdA0KPj4gb3RoZXIsIGlzIHVzZWQg
YnkgUkRNQSBDTS4gQnV0IGl0IGlzIG5vdCB1c2VkIGJ5IFNBIHF1ZXJpZXMuIFRoZSBsYWNrDQo+
PiBvZiByZXRyaWVzIG9mIFNBIHF1ZXJpZXMgbGVhZHMgdG8gbG9uZyBzcGVjaWZpZWQgdGltZW91
dCwgYW5kIGVycm9yDQo+PiBiZWluZyByZXR1cm5lZCBpbiBjYXNlIG9mIHBhY2tldCBsb3NzLiBU
aGUgVUxQIG9yIHVzZXItbGFuZCBwcm9jZXNzDQo+PiBoYXMgdG8gcGVyZm9ybSB0aGUgcmV0cnku
DQo+PiANCj4+IEZpeCB0aGlzIGJ5IHRha2luZyBhZHZhbnRhZ2Ugb2YgdGhlIE1BRCBsYXllcidz
IHJldHJ5IG1lY2hhbmlzbS4NCj4+IA0KPj4gRmlyc3QsIGEgY2hlY2sgYWdhaW5zdCBhIHplcm8g
dGltZW91dCBpcyBhZGRlZCBpbg0KPj4gcmRtYV9yZXNvbHZlX3JvdXRlKCkuIEluIHNlbmRfbWFk
KCksIHdlIHNldCB0aGUgTUFEIGxheWVyIHRpbWVvdXQgdG8NCj4+IG9uZSB0ZW50aCBvZiB0aGUg
c3BlY2lmaWVkIHRpbWVvdXQgYW5kIHRoZSBudW1iZXIgb2YgcmV0cmllcyB0bw0KPj4gMTAuIFRo
ZSBzcGVjaWFsIGNhc2Ugd2hlbiB0aW1lb3V0IGlzIGxlc3MgdGhhbiAxMCBpcyBoYW5kbGVkLg0K
Pj4gDQo+PiBXaXRoIHRoaXMgZml4Og0KPj4gDQo+PiAjIHVjbWF0b3NlIC1jIDEwMDAgLVMgMTAy
NCAtQyAxDQo+PiANCj4+IHJ1bnMgc3RhYmxlIG9uIGFuIEluZmluaWJhbmQgZmFicmljLiBXaXRo
b3V0IHRoaXMgZml4LCB3ZSBzZWUgYW4NCj4+IGludGVybWl0dGVudCBiZWhhdmlvciBhbmQgaXQg
ZXJyb3JzIG91dCB3aXRoOg0KPj4gDQo+PiBjbWF0b3NlOiBldmVudDogUkRNQV9DTV9FVkVOVF9S
T1VURV9FUlJPUiwgZXJyb3I6IC0xMTANCj4+IA0KPj4gKDExMCBpcyBFVElNRURPVVQpDQo+PiAN
Cj4+IEZpeGVzOiBmNzViN2E1Mjk0OTQgKCJbUEFUQ0hdIElCOiBBZGQgYXV0b21hdGljIHJldHJp
ZXMgdG8gTUFEIGxheWVyIikNCj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29u
LmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Nt
YS5jICAgICAgfCAzICsrKw0KPj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvc2FfcXVlcnkuYyB8
IDkgKysrKysrKystDQo+PiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IEknbSBuZXJ2b3VzIGFib3V0IHRoaXMsIG1vc3RseSBiZWNhdXNlIHRo
ZSBtYWQgbGF5ZXIgaXMgdmVyeQ0KPiBjb21wbGljYXRlZCwgYnV0IGl0IGRvZXMgc2VlbSBhbGln
bmVkIHdpdGggdGhlIHNwZWMuDQo+IA0KPiBIb3dldmVyLCBpdCBzZWVtcyBxdWl0ZSB3cm9uZyB0
aGF0IHRoZSB0aW1lb3V0IGNvbWVzIGluIGZyb20gb3V0c2lkZSwNCj4gdGhlIFNBIHRpbWVvdXQg
c2hvdWxkIGJlIGludGVncmFsIHRvIHRoZSBTQSBsYXllci4uDQoNClRoZXkgYXJlIHF1aXRlIGRp
ZmZlcmVudCAodGltZW91dCBpbiBtcyk6DQoNCglpc2VyOiAgICAgIDEwMDANCglydHJzOiAgICAg
MzAwMDANCglzcnA6ICAgICAgIDEwMDANCgludm1lOiAgICAgIDMwMDANCglzYW1iYTogICAgIDUw
MDANCglwOTogICAgICAgMzAwMDANCglyZHM6ICAgICAgIDUwMDANCgl4cHJ0cmRtYTogIDUwMDAN
Cg0KRGl2aWRpbmcgMzAgc2Vjb25kcyBieSB0ZW4gYW5kIGdldCAzLCBzZWVtcyBPSy4gQnV0IGZv
ciBpc2VyL3NycCwgd2UgZ2V0IDEwMG1zLCB3aGljaCBpcyBpbiB0aGUgbG93IGVuZCBmb3Igc29t
ZSBzeXN0ZW0gSSB3b3VsZCBleHBlY3QuDQoNCj4gQW55aG93LCBhcHBsaWVkIHRvIGZvci1uZXh0
DQoNCg0KVGhhbmtzIQ0KDQoNCkjDpWtvbg0KDQo=
