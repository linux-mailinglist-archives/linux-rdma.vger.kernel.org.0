Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8EA3A3C7D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKHBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 03:01:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53062 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKHBX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 03:01:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B6oEr2060945;
        Fri, 11 Jun 2021 06:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5j4GKCcgTYnsoiuiDReRVAM9Kqlj0yIHGdDP/oznFnk=;
 b=WfXaXQqbMPxRVMvbRO3sMFbSeLplj+P9gwql8IuYsnNPJNIMhHeCuEloHKNpFV64gVu7
 8RWN8vje85nVZ4LnlOmLqTFvXcUUrROzzik8XlnjMixSpRU3Tvo8GOkH5tJ3N0hHCauq
 /mM5gPqPOrLx5KRiTIs88/tWi6uAjZeuerh0c3+BGlneq8ZETLVt5/kQsBHcY8IZdXPt
 72gxRGxJqyI7BFTxFAZX9InA2tP4DMTrgm/0/XOJiJiDLoroyGu585vhDWoqtQPf7iOE
 oY1vo21b3K5Ir7OhqpyOZb8eSoESUb4ndOF7J5u3Y6IUSkJ57V1DIS9ZqDVBfEEGW2fz Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 39017nnu2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 06:59:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B6ujKx111305;
        Fri, 11 Jun 2021 06:59:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3020.oracle.com with ESMTP id 3922x1mf6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 06:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7IwzXktYguMQmNOcpE2s32J4tvTeKQIp2u1UxjsIg4KVfh+FjCTleB8bgpYIQ+NfGvt/UnXAaqwVF4NjjoRwJliSHvLfl9k26X+I1N11004CBWqAV9f6ehfM/Lf8AvpLc2ZoDZKGVlFvfMHg5Rn5YGiUUIrRXTdTBHvvgNE2q2P+iTaSac04cZGaumBBCiBft51Jsfu8+WUe9/1exyryckphXLVgY6PQGGAueqNEYzIweTAaqmFv8rtIkJaUFtb4pLFG3xtghNXd9W0SwJSw/J4yvFakTnEegKt5BF7rOEqOR+/VaVcNWgtJswBcW0pYJElBTH4ibAYsK62zkbYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j4GKCcgTYnsoiuiDReRVAM9Kqlj0yIHGdDP/oznFnk=;
 b=PTtGuUlrJOIDCKb0YIeWGI6kZt/gY7jkSFSYSxjsuu7WEddzV5mBiw/OeLVk54zo7vG97wrIwdP7uRtve2vKDr5JPbeGk/GwStqytQAopGFX6sMEioVVGXKF9JaiROQso/KdHHFeIgtBgDjIbQdjGvPjaEHbzPWVbNTN16ECjDClU1Xds+c07EidOOU0wopVhBfqJznbvGjlH3ogFMnuTw1ftb1sAVDB+HyHrzpRmyeOAhats9o4WI8v1/810ewD3nvgs3g0uItaUDdjiYlYgAYzJIrVmKe3ImBMgNeM3dei21rKEqSKi//HmUL0YUdOzwHXBlBIWlTlLO/IW/zEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j4GKCcgTYnsoiuiDReRVAM9Kqlj0yIHGdDP/oznFnk=;
 b=hvQxsqCTMCQOs0KCoEWolbCOADXCgK3mpjGeFiZcwmigDk0lLh1kEEcO8wZGgC5vBulqBBQnnmtOkVEwxIxwrWje2o+5w+tMbwM5SKIc2xGeAuQ7MKWn97zJyXVgv/wB0XLHXiHhTYzSvxCdR0zW1iJmnQEsDca3mN3zKJV7wAk=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2408.namprd10.prod.outlook.com (2603:10b6:910:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Fri, 11 Jun
 2021 06:59:22 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 06:59:22 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V4 rdma-core 3/5] bnxt_re/lib: add a function to
 initialize software queue
Thread-Topic: [PATCH V4 rdma-core 3/5] bnxt_re/lib: add a function to
 initialize software queue
Thread-Index: AQHXXeZzg8ePdocDVUKdZ5KV8bMsaqsNMniAgAAuiwCAAQHLgA==
Date:   Fri, 11 Jun 2021 06:59:22 +0000
Message-ID: <DAF53BD0-51BF-43C0-A8B6-A8B576D78E2C@oracle.com>
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-4-devesh.sharma@broadcom.com>
 <05C8B5D1-B086-47CB-BE2F-891FA7BB9EBC@oracle.com>
 <CANjDDBjhQB-GJPc1U-W6bti2DKEsRbAAeDAXAsfCFtBA5P7G9g@mail.gmail.com>
In-Reply-To: <CANjDDBjhQB-GJPc1U-W6bti2DKEsRbAAeDAXAsfCFtBA5P7G9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3251edb1-8c80-44b7-bf03-08d92ca670fe
x-ms-traffictypediagnostic: CY4PR1001MB2408:
x-microsoft-antispam-prvs: <CY4PR1001MB2408BC165B26D08C26EE93F1FD349@CY4PR1001MB2408.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCcxZrwVmlcVpnz3alm/8msZRF7OFtz+SDJi1LXXmgoryuRiSNdR1NDk+FSJ604s35OBz5U/3/oQ43Ev+aywtlyQUCiUP8f2wyaOyBOMKMGeurtqrY8oB2uCnGN5aukeVu3k3PSDgr+cbB30MFEJqnB1uQ+K/ngcPkhUX2EoqtDTzxTbCU1BN+bcT5i0pfYeHIbCtTYAJpFiklrmPRav21owBq8s8OFpZwtCDc5qa3LyDQ0gBGEwnkrFrs7+BWWZNbtVbdD9xk+scQxAORKlVx9NsknQmJ4wtExlJWBMRGUln/fSldODGO2tE4WoU6+Amze0tSH+9vPTpw0fGFreEuaJAS/PMXmbRSLUF85K1FGlIcgxPezWC+nIwr/eyUYiWoog6hc0zHBoRIdkS/KDIjph6DzJxgiusn6ee+MnPRR6UZZh5kcOsLRncon1jxS94P49qvt7A/PQwdG915S3CU05zuV8tr/vximsu0UhsggW1+1XxiHKmoPUdntVVG0aZnukJVVuqIXkFF9tmwgZhgN5ABmY/JxRZULRBQ7nyyKyvaqdJ1OMF7oSqnTrLgM4BfvO06UiTv83vc2y2RaMrZCYbCcHXxBUgy2dDuFadHFdTJAjFs3t+p6Mkr0xUZnLwC5oQ0QtVkULsjKokkiXYcyavHdjaCIs6PHxDVWCllI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39860400002)(376002)(71200400001)(66446008)(5660300002)(66946007)(66556008)(66574015)(2616005)(478600001)(76116006)(64756008)(2906002)(66476007)(6486002)(33656002)(91956017)(53546011)(6506007)(83380400001)(8936002)(8676002)(26005)(186003)(38100700002)(86362001)(6512007)(44832011)(4326008)(316002)(6916009)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEp0eEMyRFp6TjZiTE9ZcExiVS9WMjMrUThxQ3lrUW8zSVFCRVhEMFBQRmxz?=
 =?utf-8?B?MWk2bXVEbFc1NkVpRjB6TllINzRXanJCNjNXdm5oSG0wZHVINTZ6Z3U1Z1Zo?=
 =?utf-8?B?SG5UTi9XM1FJNDFiQnFabmlVVW9YczRWSEZsZmZ0d1ZoZ0xrcmtwRGU5U05j?=
 =?utf-8?B?MWp5UXMxLzZJTkFhY0JwbEw1SFJsVDA2OUlFajFFTXNXTnU3NnZwYlJDTHdk?=
 =?utf-8?B?K2ZWRjZadDc4ZmlKYTdUWkhUdjBzN2VQcnB3aTN5MmV5VkY2ZGVlc1NKOGlB?=
 =?utf-8?B?NU1jaUsxMDZjWWpHalVxbk16RUhjTlBDZHppcFhJNVVjOWoxeXQvM1E5eDZP?=
 =?utf-8?B?RFdTaUVyUXhxdmpHaGZ6U1BvVFREVFZSMk9JTEdmeGJZNWRaTzNzeExabG1K?=
 =?utf-8?B?SVhHSU5rSEI0M2tSMDYvOHVQQ1d0V3RqRzhQejE3c3cxK3B1M2x6aGlDbjU1?=
 =?utf-8?B?LzdBU2dQbTY5VFYvR1lROXhncGdVWUJvcHBGeE02ODAzUVpKZjR2K0RSZ1J5?=
 =?utf-8?B?RjJDYTZxR1Q5Q2VGRXk5QlJyNGMwNml2NEVTR0FGZzVYdXNmTVcwSjZhWmUw?=
 =?utf-8?B?NGxzcUhNMTgyWDFXdFdRRUZjajJnUFlTNUk4Qy9yYmI1YzJJcktvalBNVGR0?=
 =?utf-8?B?MnhFazd5OEVLZStOWHBVYzFYU3h2ZGcyZzl6L056WFNTSTh0WE94RXdlQitx?=
 =?utf-8?B?M2tLbXVoRWluZUNYRENFTG5aVmZTNjRHRVQwNWhJOEZyWUJxRlFpejJ5YnRO?=
 =?utf-8?B?TzRhL2dzV0JnckljSUxNZklNWmpHS3p6SXhuc1E0OFpqZTZZUi9WOHNTdW1t?=
 =?utf-8?B?NENhdUd1N1FMK1NpZG02TnlLUm1kQW9qNW9WRFRSM1FYY1Z0S1R4MWVXTTR5?=
 =?utf-8?B?c2ozSUV3NXlzRnVOQkMwbW9QR043eTk5NVYrTFpFdk50SDBLTFl4Vk5MMGZU?=
 =?utf-8?B?UmNmVTRidEVraWdPRFQxZlAxbDhqUUJqRDlPQ1JTMHpyMHB6eFJZdnVJZjJC?=
 =?utf-8?B?cTh6aGVZOHFDLzk3NG5hMzlkN1RjQ0d5dmJxOW51dldlOXRJeU1YajY3WVlq?=
 =?utf-8?B?Rkx0YjBCYUVzdGFMUFVBbmxoR2w5RitKNTN1cmFIa0ZjNXV0aldWZnpULzdr?=
 =?utf-8?B?U3ZZL29uMitteWhBTzhHZTdKN3ZwN3FaSS82TmdRUjN2S3NGYTdBOHBJWHBF?=
 =?utf-8?B?V2VsWWRPN0tVaFh5aWpUTzFrd0lKQmk4TVhjOTNDRFMvcHU5ZnJteXA3bnNV?=
 =?utf-8?B?alI3akVBeWJqbktxWEloUENZZEluVkt4dmFSUzJSUThBdGpHeHRDb3M2dlZN?=
 =?utf-8?B?ZitZMHhNMEdHU3B3U3RmbEtqSWRVSEswZ1VLbDdqQ2Q1VEt3RWxjVXFkbklu?=
 =?utf-8?B?TlVZZmxCTldSVTBwQ1VWcXV3eFdUdHMraW9adnZkSGxNWlZSVTE3cDlxUnp5?=
 =?utf-8?B?SXpCVEVjaXBxT3FVWWlnZitwck9iOFFwVEdKUWUzNEtKZklxTkhYaW1qTjY2?=
 =?utf-8?B?M3ZUcUcvQWRvL0k3K05pWjUwZXMyYk9lVnZkdzhlbmFBem5wYURsbFBnZFpR?=
 =?utf-8?B?WGRmb2w1TXFyL0JxalVaMlh3UVBHWUd6UWFaTHRQbkZHcTA1VCtaTzhlWmJx?=
 =?utf-8?B?c0VTMnVkcTZObmNPM0M1NVY0UWVZSGRPdjUyNlhPa3NLOWdOVWo5Wmp1V2dV?=
 =?utf-8?B?Yzh4SlViM0kyU0FRdlVoNU5JWTl1bjlUZUo4Y1orbXpRZXpRZm9BTTZBTzg4?=
 =?utf-8?B?K3o1eUJvOU1pWE5KZXNiVi90eHZxNEF4dExHb1RoV0wzUkZtdE91Vkh0MWR5?=
 =?utf-8?B?bjE5dDNoYTB2Qm5TRzI4UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDC9C66A114CAD4F945ED2BF6B2386DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3251edb1-8c80-44b7-bf03-08d92ca670fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 06:59:22.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TPJXvlXE37GP1tQSFFbF+Ohn05mFeXyxugMqTNJ3f7WfzkAre/2Qse1EeElF8t0+3XfUrAaXDxW6ovl79qCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2408
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110045
X-Proofpoint-GUID: Pr6wqNL5onQLKABqUoXilTwLcWeh--fi
X-Proofpoint-ORIG-GUID: Pr6wqNL5onQLKABqUoXilTwLcWeh--fi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110044
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgSnVuIDIwMjEsIGF0IDE3OjM2LCBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hh
cm1hQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxMCwgMjAyMSBhdCA2
OjIwIFBNIEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIDEwIEp1biAyMDIxLCBhdCAxMjo0OSwgRGV2ZXNoIFNoYXJtYSA8
ZGV2ZXNoLnNoYXJtYUBicm9hZGNvbS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFNwbGl0dGluZyB0
aGUgc2hhZG93IHNvZnR3YXJlIHF1ZXVlIGluaXRpYWxpemF0aW9uIGludG8NCj4+PiBhIHNlcGFy
YXRlIGZ1bmN0aW9uLiBTYW1lIGlzIGJlaW5nIGNhbGxlZCBmb3IgYm90aCBSUSBhbmQNCj4+PiBT
USBkdXJpbmcgY3JlYXRlIFFQLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IERldmVzaCBTaGFy
bWEgPGRldmVzaC5zaGFybWFAYnJvYWRjb20uY29tPg0KPj4+IC0tLQ0KPj4+IHByb3ZpZGVycy9i
bnh0X3JlL21haW4uaCAgfCAgMyArKw0KPj4+IHByb3ZpZGVycy9ibnh0X3JlL3ZlcmJzLmMgfCA2
NSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+PiAyIGZpbGVzIGNo
YW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+IGRpZmYg
LS1naXQgYS9wcm92aWRlcnMvYm54dF9yZS9tYWluLmggYi9wcm92aWRlcnMvYm54dF9yZS9tYWlu
LmgNCj4+PiBpbmRleCBkYzgxNjZmMi4uOTRkNDI5NTggMTAwNjQ0DQo+Pj4gLS0tIGEvcHJvdmlk
ZXJzL2JueHRfcmUvbWFpbi5oDQo+Pj4gKysrIGIvcHJvdmlkZXJzL2JueHRfcmUvbWFpbi5oDQo+
Pj4gQEAgLTk2LDcgKzk2LDEwIEBAIHN0cnVjdCBibnh0X3JlX3dyaWQgew0KPj4+ICAgICAgdWlu
dDY0X3Qgd3JpZDsNCj4+PiAgICAgIHVpbnQzMl90IGJ5dGVzOw0KPj4+ICAgICAgaW50IG5leHRf
aWR4Ow0KPj4+ICsgICAgIHVpbnQzMl90IHN0X3Nsb3RfaWR4Ow0KPj4+ICsgICAgIHVpbnQ4X3Qg
c2xvdHM7DQo+Pj4gICAgICB1aW50OF90IHNpZzsNCj4+PiArDQo+PiANCj4+IFVuaW50ZW50aW9u
YWwgYmxhbmsgbGluZT8NCj4geXVwLCBJIGd1ZXNzLg0KPj4gDQo+Pj4gfTsNCj4+PiANCj4+PiBz
dHJ1Y3QgYm54dF9yZV9xcGNhcCB7DQo+Pj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9ibnh0X3Jl
L3ZlcmJzLmMgYi9wcm92aWRlcnMvYm54dF9yZS92ZXJicy5jDQo+Pj4gaW5kZXggMTFjMDE1NzQu
LmUwZTZlMDQ1IDEwMDY0NA0KPj4+IC0tLSBhL3Byb3ZpZGVycy9ibnh0X3JlL3ZlcmJzLmMNCj4+
PiArKysgYi9wcm92aWRlcnMvYm54dF9yZS92ZXJicy5jDQo+Pj4gQEAgLTg0Nyw5ICs4NDcsMjcg
QEAgc3RhdGljIHZvaWQgYm54dF9yZV9mcmVlX3F1ZXVlcyhzdHJ1Y3QgYm54dF9yZV9xcCAqcXAp
DQo+Pj4gICAgICBibnh0X3JlX2ZyZWVfYWxpZ25lZChxcC0+anNxcS0+aHdxdWUpOw0KPj4+IH0N
Cj4+PiANCj4+PiArc3RhdGljIGludCBibnh0X3JlX2FsbG9jX2luaXRfc3dxdWUoc3RydWN0IGJu
eHRfcmVfam9pbnRfcXVldWUgKmpxcSwgaW50IG53cikNCj4+PiArew0KPj4+ICsgICAgIGludCBp
bmR4Ow0KPj4+ICsNCj4+PiArICAgICBqcXEtPnN3cXVlID0gY2FsbG9jKG53ciwgc2l6ZW9mKHN0
cnVjdCBibnh0X3JlX3dyaWQpKTsNCj4+PiArICAgICBpZiAoIWpxcS0+c3dxdWUpDQo+Pj4gKyAg
ICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+PiArICAgICBqcXEtPnN0YXJ0X2lkeCA9IDA7
DQo+Pj4gKyAgICAganFxLT5sYXN0X2lkeCA9IG53ciAtIDE7DQo+Pj4gKyAgICAgZm9yIChpbmR4
ID0gMDsgaW5keCA8IG53cjsgaW5keCsrKQ0KPj4+ICsgICAgICAgICAgICAganFxLT5zd3F1ZVtp
bmR4XS5uZXh0X2lkeCA9IGluZHggKyAxOw0KPj4+ICsgICAgIGpxcS0+c3dxdWVbanFxLT5sYXN0
X2lkeF0ubmV4dF9pZHggPSAwOw0KPj4+ICsgICAgIGpxcS0+bGFzdF9pZHggPSAwOw0KPj4+ICsN
Cj4+PiArICAgICByZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiBzdGF0aWMgaW50IGJueHRf
cmVfYWxsb2NfcXVldWVzKHN0cnVjdCBibnh0X3JlX3FwICpxcCwNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBpYnZfcXBfaW5pdF9hdHRyICphdHRyLA0KPj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBnX3NpemUpIHsNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwZ19zaXplKQ0KPj4+ICt7DQo+PiANCj4+
IE5vdCByZWxhdGVkIHRvIGNvbW1pdA0KPiBUaGlzIGlzIGEgZml4IGZvciB3YXJuaW5nLCBhcyBh
c2tlZCBieSB0aGUgbWFpbnRhaW5lci4NCg0KU3VyZSwgYnV0IG5vdCBpbiB0aGlzIGZ1bmN0aW9u
YWwgY29tbWl0LiBNdXN0IGJlIGluIGEgc2VwYXJhdGUgY29tbWl0LiBJZiB0aGlzIGNvbW1pdCBp
cyByZXZlcnRlZCBmb3Igc29tZSByZWFzb24sIEkgYW0gc3VyZSB0aGUgbWFpbnRhaW5lciBzdGls
bCB3YW50cyB0aGUgd2FybmluZyBmaXhlZC4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+PiANCj4+
PiAgICAgIHN0cnVjdCBibnh0X3JlX3BzbnNfZXh0ICpwc25zX2V4dDsNCj4+PiAgICAgIHN0cnVj
dCBibnh0X3JlX3dyaWQgKnN3cXVlOw0KPj4+ICAgICAgc3RydWN0IGJueHRfcmVfcXVldWUgKnF1
ZTsNCj4+PiBAQCAtODU3LDIyICs4NzUsMjMgQEAgc3RhdGljIGludCBibnh0X3JlX2FsbG9jX3F1
ZXVlcyhzdHJ1Y3QgYm54dF9yZV9xcCAqcXAsDQo+Pj4gICAgICB1aW50MzJfdCBwc25fZGVwdGg7
DQo+Pj4gICAgICB1aW50MzJfdCBwc25fc2l6ZTsNCj4+PiAgICAgIGludCByZXQsIGluZHg7DQo+
Pj4gKyAgICAgdWludDMyX3QgbnN3cjsNCj4+PiANCj4+PiAgICAgIHF1ZSA9IHFwLT5qc3FxLT5o
d3F1ZTsNCj4+PiAgICAgIHF1ZS0+c3RyaWRlID0gYm54dF9yZV9nZXRfc3FlX3N6KCk7DQo+Pj4g
ICAgICAvKiA4OTE2IGFkanVzdG1lbnQgKi8NCj4+PiAtICAgICBxdWUtPmRlcHRoID0gcm91bmR1
cF9wb3dfb2ZfdHdvKGF0dHItPmNhcC5tYXhfc2VuZF93ciArIDEgKw0KPj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQk5YVF9SRV9GVUxMX0ZMQUdfREVMVEEpOw0KPj4+
IC0gICAgIHF1ZS0+ZGlmZiA9IHF1ZS0+ZGVwdGggLSBhdHRyLT5jYXAubWF4X3NlbmRfd3I7DQo+
Pj4gKyAgICAgbnN3ciAgPSByb3VuZHVwX3Bvd19vZl90d28oYXR0ci0+Y2FwLm1heF9zZW5kX3dy
ICsgMSArDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQk5YVF9SRV9GVUxM
X0ZMQUdfREVMVEEpOw0KPj4+ICsgICAgIHF1ZS0+ZGlmZiA9IG5zd3IgLSBhdHRyLT5jYXAubWF4
X3NlbmRfd3I7DQo+Pj4gDQo+Pj4gICAgICAvKiBwc25fZGVwdGggZXh0cmEgZW50cmllcyBvZiBz
aXplIHF1ZS0+c3RyaWRlICovDQo+Pj4gICAgICBwc25fc2l6ZSA9IGJueHRfcmVfaXNfY2hpcF9n
ZW5fcDUocXAtPmNjdHgpID8NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZW9mKHN0cnVjdCBibnh0X3JlX3BzbnNfZXh0KSA6DQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgYm54dF9yZV9wc25zKTsNCj4+PiAt
ICAgICBwc25fZGVwdGggPSAocXVlLT5kZXB0aCAqIHBzbl9zaXplKSAvIHF1ZS0+c3RyaWRlOw0K
Pj4+IC0gICAgIGlmICgocXVlLT5kZXB0aCAqIHBzbl9zaXplKSAlIHF1ZS0+c3RyaWRlKQ0KPj4+
ICsgICAgIHBzbl9kZXB0aCA9IChuc3dyICogcHNuX3NpemUpIC8gcXVlLT5zdHJpZGU7DQo+Pj4g
KyAgICAgaWYgKChuc3dyICogcHNuX3NpemUpICUgcXVlLT5zdHJpZGUpDQo+Pj4gICAgICAgICAg
ICAgIHBzbl9kZXB0aCsrOw0KPj4+IC0gICAgIHF1ZS0+ZGVwdGggKz0gcHNuX2RlcHRoOw0KPj4+
ICsgICAgIHF1ZS0+ZGVwdGggPSBuc3dyICsgcHNuX2RlcHRoOw0KPj4+ICAgICAgLyogUFNOLXNl
YXJjaCBtZW1vcnkgaXMgYWxsb2NhdGVkIHdpdGhvdXQgY2hlY2tpbmcgZm9yDQo+Pj4gICAgICAg
KiBRUC1UeXBlLiBLZW5yZWwgZHJpdmVyIGRvIG5vdCBtYXAgdGhpcyBtZW1vcnkgaWYgaXQNCj4+
PiAgICAgICAqIGlzIFVELXFwLiBVRC1xcCB1c2UgdGhpcyBtZW1vcnkgdG8gbWFpbnRhaW4gV0Mt
b3Bjb2RlLg0KPj4+IEBAIC04ODQsNDQgKzkwMyw0MiBAQCBzdGF0aWMgaW50IGJueHRfcmVfYWxs
b2NfcXVldWVzKHN0cnVjdCBibnh0X3JlX3FwICpxcCwNCj4+PiAgICAgIC8qIGV4Y2x1ZGUgcHNu
cyBkZXB0aCovDQo+Pj4gICAgICBxdWUtPmRlcHRoIC09IHBzbl9kZXB0aDsNCj4+PiAgICAgIC8q
IHN0YXJ0IG9mIHNwc24gc3BhY2Ugc2l6ZW9mKHN0cnVjdCBibnh0X3JlX3BzbnMpIGVhY2guICov
DQo+Pj4gLSAgICAgcHNucyA9IChxdWUtPnZhICsgcXVlLT5zdHJpZGUgKiBxdWUtPmRlcHRoKTsN
Cj4+PiArICAgICBwc25zID0gKHF1ZS0+dmEgKyBxdWUtPnN0cmlkZSAqIG5zd3IpOw0KPj4+ICAg
ICAgcHNuc19leHQgPSAoc3RydWN0IGJueHRfcmVfcHNuc19leHQgKilwc25zOw0KPj4+IC0gICAg
IHN3cXVlID0gY2FsbG9jKHF1ZS0+ZGVwdGgsIHNpemVvZihzdHJ1Y3QgYm54dF9yZV93cmlkKSk7
DQo+Pj4gLSAgICAgaWYgKCFzd3F1ZSkgew0KPj4+ICsNCj4+PiArICAgICByZXQgPSBibnh0X3Jl
X2FsbG9jX2luaXRfc3dxdWUocXAtPmpzcXEsIG5zd3IpOw0KPj4+ICsgICAgIGlmIChyZXQpIHsN
Cj4+PiAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4+PiAgICAgICAgICAgICAgZ290byBm
YWlsOw0KPj4+ICAgICAgfQ0KPj4+IA0KPj4+IC0gICAgIGZvciAoaW5keCA9IDAgOyBpbmR4IDwg
cXVlLT5kZXB0aDsgaW5keCsrLCBwc25zKyspDQo+Pj4gKyAgICAgc3dxdWUgPSBxcC0+anNxcS0+
c3dxdWU7DQo+Pj4gKyAgICAgZm9yIChpbmR4ID0gMCA7IGluZHggPCBuc3dyOyBpbmR4KyssIHBz
bnMrKykNCj4+IA0KPj4gbm8gc3BhY2UgaW4gIjAgOyINCj4geXVwIQ0KPj4gDQo+Pj4gICAgICAg
ICAgICAgIHN3cXVlW2luZHhdLnBzbnMgPSBwc25zOw0KPj4+ICAgICAgaWYgKGJueHRfcmVfaXNf
Y2hpcF9nZW5fcDUocXAtPmNjdHgpKSB7DQo+Pj4gLSAgICAgICAgICAgICBmb3IgKGluZHggPSAw
IDsgaW5keCA8IHF1ZS0+ZGVwdGg7IGluZHgrKywgcHNuc19leHQrKykgew0KPj4+ICsgICAgICAg
ICAgICAgZm9yIChpbmR4ID0gMCA7IGluZHggPCBuc3dyOyBpbmR4KyssIHBzbnNfZXh0KyspIHsN
Cj4+IA0KPj4gZGl0dG8NCj4+IA0KPj4+ICAgICAgICAgICAgICAgICAgICAgIHN3cXVlW2luZHhd
LnBzbnNfZXh0ID0gcHNuc19leHQ7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgc3dxdWVbaW5k
eF0ucHNucyA9IChzdHJ1Y3QgYm54dF9yZV9wc25zICopcHNuc19leHQ7DQo+Pj4gICAgICAgICAg
ICAgIH0NCj4+PiAgICAgIH0NCj4+PiAtICAgICBxcC0+anNxcS0+c3dxdWUgPSBzd3F1ZTsNCj4+
PiAtDQo+Pj4gLSAgICAgcXAtPmNhcC5tYXhfc3dyID0gcXVlLT5kZXB0aDsNCj4+PiArICAgICBx
cC0+Y2FwLm1heF9zd3IgPSBuc3dyOw0KPj4+ICAgICAgcHRocmVhZF9zcGluX2luaXQoJnF1ZS0+
cWxvY2ssIFBUSFJFQURfUFJPQ0VTU19QUklWQVRFKTsNCj4+PiANCj4+PiAgICAgIGlmIChxcC0+
anJxcSkgew0KPj4+ICAgICAgICAgICAgICBxdWUgPSBxcC0+anJxcS0+aHdxdWU7DQo+Pj4gICAg
ICAgICAgICAgIHF1ZS0+c3RyaWRlID0gYm54dF9yZV9nZXRfcnFlX3N6KCk7DQo+Pj4gLSAgICAg
ICAgICAgICBxdWUtPmRlcHRoID0gcm91bmR1cF9wb3dfb2ZfdHdvKGF0dHItPmNhcC5tYXhfcmVj
dl93ciArIDEpOw0KPj4+IC0gICAgICAgICAgICAgcXVlLT5kaWZmID0gcXVlLT5kZXB0aCAtIGF0
dHItPmNhcC5tYXhfcmVjdl93cjsNCj4+PiArICAgICAgICAgICAgIG5zd3IgPSByb3VuZHVwX3Bv
d19vZl90d28oYXR0ci0+Y2FwLm1heF9yZWN2X3dyICsgMSk7DQo+Pj4gKyAgICAgICAgICAgICBx
dWUtPmRlcHRoID0gbnN3cjsNCj4+PiArICAgICAgICAgICAgIHF1ZS0+ZGlmZiA9IG5zd3IgLSBh
dHRyLT5jYXAubWF4X3JlY3Zfd3I7DQo+Pj4gICAgICAgICAgICAgIHJldCA9IGJueHRfcmVfYWxs
b2NfYWxpZ25lZChxdWUsIHBnX3NpemUpOw0KPj4+ICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4+
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4+PiAtICAgICAgICAgICAgIHB0aHJl
YWRfc3Bpbl9pbml0KCZxdWUtPnFsb2NrLCBQVEhSRUFEX1BST0NFU1NfUFJJVkFURSk7DQo+Pj4g
ICAgICAgICAgICAgIC8qIEZvciBSUSBvbmx5IGJueHRfcmVfd3JpLndyaWQgaXMgdXNlZC4gKi8N
Cj4+PiAtICAgICAgICAgICAgIHFwLT5qcnFxLT5zd3F1ZSA9IGNhbGxvYyhxdWUtPmRlcHRoLA0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3Qg
Ym54dF9yZV93cmlkKSk7DQo+Pj4gLSAgICAgICAgICAgICBpZiAoIXFwLT5qcnFxLT5zd3F1ZSkg
ew0KPj4+IC0gICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPj4+ICsgICAgICAg
ICAgICAgcmV0ID0gYm54dF9yZV9hbGxvY19pbml0X3N3cXVlKHFwLT5qcnFxLCBuc3dyKTsNCj4+
PiArICAgICAgICAgICAgIGlmIChyZXQpDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgZ290byBm
YWlsOw0KPj4gDQo+PiBIZXJlIHlvdSBoYXZlIG5vdCAicmV0ID0gLUVOT01FTTsiLiBZb3UgaGF2
ZSB0aGF0IGFib3ZlLCB1bm5lY2Vzc2FyeS4NCj4gdHJ1ZS4NCj4+IA0KPj4gDQo+PiBUaHhzLCBI
w6Vrb24NCj4+IA0KPj4gDQo+Pj4gLSAgICAgICAgICAgICB9DQo+Pj4gLSAgICAgICAgICAgICBx
cC0+Y2FwLm1heF9yd3IgPSBxdWUtPmRlcHRoOw0KPj4+ICsgICAgICAgICAgICAgcHRocmVhZF9z
cGluX2luaXQoJnF1ZS0+cWxvY2ssIFBUSFJFQURfUFJPQ0VTU19QUklWQVRFKTsNCj4+PiArICAg
ICAgICAgICAgIHFwLT5jYXAubWF4X3J3ciA9IG5zd3I7DQo+Pj4gICAgICB9DQo+Pj4gDQo+Pj4g
ICAgICByZXR1cm4gMDsNCj4+PiAtLQ0KPj4+IDIuMjUuMQ0KPj4+IA0KPj4gDQo+IA0KPiANCj4g
LS0gDQo+IC1SZWdhcmRzDQo+IERldmVzaA0KDQo=
