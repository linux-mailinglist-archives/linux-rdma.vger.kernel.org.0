Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F014D35585E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbhDFPpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 11:45:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44960 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbhDFPpp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 11:45:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Fj0eq181437;
        Tue, 6 Apr 2021 15:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IEIr0KsqghB8g2u5iGsS2ONOFOPJFmDCWHgt5BWW8v0=;
 b=laTQTgKVFeK80udegmjAwn4T2NDTDPn+ipdU29DxMcH01KJUSk7CLlywUqixWklZsQpY
 5xtFUdvx+SXosS9A24C8UhLFGEG9Z8pDxYKyMrU5vwd1/MuXmzj1VjhmSEetShskMki5
 GrKkHt/vhw/XweTnqqpKvtZYTQCiwUHpJY7o2u3DMBxwfFaa3WIAmARM5l8dOM9hyNAD
 KqJvuMlhwZ6F8bKsuiX2ZG0IhhOjQKLX6KEaZbPDIGRBM9PRJ2qOjLSsaWcYU3fZu6LA
 zpK8nR9Yy9lNNmDufv6Zs7ooM068+0dJP+9oUS9E9rUn9tpNYoyHqU4mieSKteormqvS TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37q38mp05u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:45:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136FjHWO060185;
        Tue, 6 Apr 2021 15:45:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 37q2pxpnax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/VkQy0aa3Qq4f5su3rHy6fW6cB8kvL5Fg8dqaJHPoDc7miAUh3456AVJjDL1oc18z4NiVb6E0Dr6KHw3ONxV3zP96YTk5Yg4kxcVywLW+kCOzttfjoJUN0TZjBLG49FuitQJlL3tQjywvfW4AiWPhYglZkFT2z5uDdO31zQkxBoTzmTW8Y2yO+dPBTCWUVliK3tlgmX4OC8raVzPEjZw7IK54iWkV1drsQWwLIjsHBn5wFPbeiMnvaE8YXNod+zcL8CUliKkpfkCQNGx0/HfXJm5QM+9kXJErXC5CsTLg8Gvdo4jA+DUybQqf1W+wd7ROrZjGSXHfqDpFku6mLWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEIr0KsqghB8g2u5iGsS2ONOFOPJFmDCWHgt5BWW8v0=;
 b=WYn+TYOFiXdW1J8ANdtwdM6NVLdzFxkoyABelIgs6XnnywA6cL5eP9vAtNZLGePdQiU3M144pbgQYM4TKCbnjHw5vhRM/UNzVjPrGSq9DWzR+2FWknNwQVaS1qfDk1CH5q14C7woW0B2A+C+mzniUAJUywmKt1T17rFP9dgUkdJdptwrFsq/9GJB7eb+iZFCCkb5mFKT2YFv/OCaOW854CQtX6j0G2A+jjCePCgLWZhWLG1bWRReTzCyl56J/kOc6JXjvo5lvVS7RnBlmI5Y79bYLRcpTfs/s1eE8BkBLMKNh2jrN3ENrnduHswlohM51dH39xW+jE9PBevU6edC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEIr0KsqghB8g2u5iGsS2ONOFOPJFmDCWHgt5BWW8v0=;
 b=EpfwsTYvah5uvqisES/7tNIjTKQ/aPij1lOneXk/KpvryxWrcajiMI6VlnpY7R5FasSd3Djs1wOrZ/CfqcWYt2vQXyZZKcfzRpN+KXE1stlwsDuhCEQxtcTgWC6iX9ZdB8Y8HrWin6nqzAPRkbqReFu26UEA7U+J/pVEuyOo4e8=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2133.namprd10.prod.outlook.com (2603:10b6:910:43::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 15:45:30 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:45:30 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Subject: Re: Double RESET -> INIT transitions
Thread-Topic: Double RESET -> INIT transitions
Thread-Index: AQHXKvXA8fgjJCWRlUGbA3d9c3jDY6qnnSmAgAAEqIA=
Date:   Tue, 6 Apr 2021 15:45:30 +0000
Message-ID: <5342C53E-A6F0-4221-B04B-1D3931E2C428@oracle.com>
References: <F6F7D0C5-ECA6-43C5-91C5-818076C5619A@oracle.com>
 <20210406152849.GU7405@nvidia.com>
In-Reply-To: <20210406152849.GU7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d27bd7-3ce6-414d-c2e2-08d8f91301b6
x-ms-traffictypediagnostic: CY4PR1001MB2133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB2133DA05B33458783DDBA385FD769@CY4PR1001MB2133.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HH0AJuoQV+AoO2qhYcP13UKh+z5j+/oKY6YO7h7vC59IgpUe1saSvSvi5CKuRM6rGpXmEBAxJacphP3QONMdLTo2EndAlVYKzrW+BQbgcnapkfV/AhI4dw7Rq1nu1ehNL6U+omn02d0g37UPEQvTbqhsu01r638sOfNSpEf0TZgnfsChDxocJrzxheT0y8+ziT7DUzBcpqETFUwCJzbbbWPyJSyZx/QRynR5VL4ybrBTWMf++BizMxnuxss1+XEP/N4FjRRj0ob1IA1XZ2t1Vg6Fi/6oktVfuj75+A4SzwuMLTnSIbLzClM0xi89PgSnbOEJ6RC39NuWZvOk8VxM7p7EBKOmvhyPDT6w4zl0armkczREfj+4ob6Hltw1UvxfFqjc+vZqh+OaVaJHmDmyEkKm6JGff43GVn3lBP7QINYocj1ijwxTXTc6mO9j9x6+pc2hUXxtZhux+24B8rpbP23NfnD6/TSdaL4ux6w3JenDB6uWoKxvitItk8yVnjdpxIWG0Kn79X3D/mYb2y60V65woAimzNh3i7MZc5a3e/Q2lJxb4WBSoaTsKydQ8zXJWpHZDYyQ1tFKaLNwyJIhPhGgwvfo6+1wi5C0AGQI992ZYY6dIRtEScqcAHxYK1BGoj2P4PGe41Z5naQPZ+etOM+0kaBMoAomDiOWvF/mZwywos0SQIVf7XTUH4H2WPeP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(136003)(396003)(33656002)(6506007)(38100700001)(53546011)(44832011)(478600001)(6486002)(316002)(8936002)(54906003)(71200400001)(6916009)(5660300002)(66446008)(186003)(91956017)(86362001)(2616005)(83380400001)(107886003)(64756008)(76116006)(36756003)(66476007)(8676002)(66946007)(4326008)(2906002)(4744005)(66574015)(66556008)(6512007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUQ4QnhlblJyNExyUUp0Q05zemNxaGE4QkNGMmIrYmkzdjlCSkgzK3F4SS9j?=
 =?utf-8?B?ZjQ1aVVDamxkbE85K3FTWWpUWVdBMkY2RENJQ1lhdnM2d25ZQmIvdzZCbnQy?=
 =?utf-8?B?dUZsbzkycHdDSkR3c1dpQkxsU1NmNHVTVFl0eVYxUTA1NHB0VDMwUjA1ZVRw?=
 =?utf-8?B?Z2VnMkI5R2c4Q0xsN1FNZmREU0ovQlYxOXVkeGdWQmdtbVp2SmY5U3pITXQv?=
 =?utf-8?B?bWFwbkdpbHpDbGF0bUFRalMrM3JuS0o4dXRjQUhtOVlmOE8reWJPZlU4c1Fo?=
 =?utf-8?B?WXJJNHNaYWltYTVZWmdnNnhzY1hUSUtSb1oza1ZvNklPSzBMMUR1U0JPeGV3?=
 =?utf-8?B?cUx1L3lsRFV6VTBQeXFFZXA4WmlvOGRqbEhhbTR5ZjJpd2Y2SldSeFF2RzFx?=
 =?utf-8?B?djZ3Zmh6OEZKQ2FOUHBGMjZBRW0xUUJkMUh5TkhGejNwR2wwSnpZanp4cU9M?=
 =?utf-8?B?cVU4djBPRFkrc2ZKSHRQNHJsdGtiN2wrL3lqcGRjREdZUjROQlBsdks2RG9T?=
 =?utf-8?B?STVpM3RRd25iQ0g5WDkvTjJkMlBEU21oL3dDaHFzMnI1em10NmZURmE4NlQr?=
 =?utf-8?B?aHU4dnVsSkpNa25aWGNPem5DeWRwYjBWaURudWJ4T1dMQWdoMEVLZW0rSDNO?=
 =?utf-8?B?UmlJbWxNM3VUb1RrVlRna3VmT1g5VHR4OFVORURjLzQvTnQ0cjVaaWJJQUJs?=
 =?utf-8?B?aVpCNHVVM0Y5THBpY1BOcWkxM1gwOE40ZVptOVNlMkZqUGdScVNXMHJCYUFB?=
 =?utf-8?B?TG9TTHd6Z2lFTVY1bG4wWnFwQWZwWXlwb1B4RWdQdEJ5MXlaNFczS2hXMU1H?=
 =?utf-8?B?OGhpdDk3UWNGUzJsR1lYM0cwT09VRnF4VzNZNndQZzNPRllXYUVPSTdPdDFl?=
 =?utf-8?B?NHQ2clNNZUZsZGtGM05KM0dtNkZnSGR1eDNnZzhYd2QyUDJqTXV6SDZIdWdp?=
 =?utf-8?B?cTBoeHVGeGdCUHR6Sy81VmpybWpjWWNnUnVLZmRvcVZxbnJkbjBOakw5Nnlt?=
 =?utf-8?B?TWtuNVJTYy82RkVicHRLYVc1VHhkUlVnb1ZvVkhRSy9RWFMrdXhFckRuVVdx?=
 =?utf-8?B?M2o3a1ZDekxhK3NVRVdQTDlQK2lTQkxLWXliZGNqL2JVbjBTN1I1MmFJc2ZM?=
 =?utf-8?B?N2lkVm01N1BGRUFmaVI3MEJHM1B2YU9MMjd5eXJ1Vjc0NXBMQkQ2UW5JTy9D?=
 =?utf-8?B?MEZ4SmI0MmxGVGIzYUVnRUl4aFRBVGFuWkVHZjJYcWNGY05MQ1orQmhabnR0?=
 =?utf-8?B?Qmt0TkhTcVo5TCtaNERMWXVvYm9wcUVOOHdFN05UMWhrMDFncXphWThweTcz?=
 =?utf-8?B?elp0STRMVnp5cUh5S3RaZC9rTndoWktJVmt5NmJGVHc1VHZhRE1jTDVHNUVP?=
 =?utf-8?B?MlJyZTc5bUVLU1NBaW5VUGo0QWR1UFNvcnVwT3JFT1EybCtYT3lIczcraXU3?=
 =?utf-8?B?Ui9SOENKU2tlaGVPQ2pzbzN0QXlXSUhJYVFxKzMwTGJGM0JQQjNjOG9SVUxQ?=
 =?utf-8?B?TTJFUk5rbHRoTVI3VlMxMmg5SFZvdHFNTlByNkhLQkZ3RXB2RlJ3Rlg0Q0Y0?=
 =?utf-8?B?bjRBQkptaXd0aG1SZGIyWWpnUWhSRjhoTXhNUDFibHdCdTc3S3NmNHBFNldm?=
 =?utf-8?B?OGduYTBLUm9laWpQTS8waisxd0FMeHFCY2d3QitKTnJ2WDVFSUFVUGdudEt5?=
 =?utf-8?B?dFoxZWNiU21QL3JzMmIrYUNyckpuQmlER3lkWURSbzhqaFdBV3k0TFVucGFT?=
 =?utf-8?B?YTBzVFNoZ3ZIdkpJbUV3enpqWGhhUGxBNVBRMjBseWtWdkZ6Rzl4eFBCTGxT?=
 =?utf-8?B?L0NTVzdqREVpMm01bFZEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C3E5F235175C458E2118AABAE3510D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d27bd7-3ce6-414d-c2e2-08d8f91301b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 15:45:30.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY4vb9LzO0bzRRRMg108c/dV5luE495SRAP37LBa2MgMfbwbiSalDGI1x+SkHTpboBRyPYdxh8Hp6HDo6CY78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=917 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060106
X-Proofpoint-GUID: -P4AtdpBUY-doxKPKINyR7RMqRiSCd6x
X-Proofpoint-ORIG-GUID: -P4AtdpBUY-doxKPKINyR7RMqRiSCd6x
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNiBBcHIgMjAyMSwgYXQgMTc6MjgsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBBcHIgMDYsIDIwMjEgYXQgMDM6MDE6NDFQTSAr
MDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0KPiANCj4+IFJ1bm5pbmcgcmRtYV9zZXJ2ZXIgKFJD
IHRyYW5zcG9ydCkgb24gYW4gSUIgZGV2aWNlIHRoYXQgc3VwcG9ydHMNCj4+IGFiaV92ZXIgNCwg
SSBzZWUgdHdvIGliX21vZGlmeV9xcCgpIGNhbGxzIHRvIHRoZSBJTklUIHN0YXRlIHdpdGgNCj4+
IG1hc2sgMHgzOSAoU1RBVEUsIEFDQ0VTU19GTEFHUywgUEtFWV9JTkRFWCwgYW5kIFBPUlQpIGFu
ZCBvZiBjb3Vyc2UsDQo+PiBzdGF0ZSA9PSAxIChJQl9RUFNfSU5JVCkuDQo+PiANCj4+IFByZXN1
bWFibGUsIGZyb20gdWNtYV9pbml0X2Nvbm5fcXAoKSwgdGhlbiBhZ2FpbiBpbiB1Y21hX21vZGlm
eV9xcF9ydHIoKS4NCj4+IA0KPj4gU2xpcCBvZiB0aGUga2V5Ym9hcmQ/DQo+IA0KPiBUaGUgY29u
dHJvbCBmbG93IGlzIGNvbXBsaWNhdGVkIGhlcmUgYW5kIEkgd29ycnkgcGFydHMgb2YgdGhpcyBh
cmUgQUJJDQo+IG5vdy4gV291bGQgaXQgYmUgT0sgdG8gcmV0dXJuIGZyb20gcmRtYV9jcmVhdGVf
cXBfZXgoKSB3aXRoIGFuDQo+IGluY29tcGxldGVseSBpbml0aWFsaXplZCBRUD8gSSBkb24ndCBr
bm93Lg0KDQpUd28gdHJhbnNpdGlvbnMgdG8gSU5JVCB3aXRoIHNhbWUgbWFzayBhbmQgZGF0YSBp
cyBpZGVtcG90ZW50LiBTaG91bGQgYmUgcG9zc2libGUgdG8gcmVtb3ZlIHRoZSBzZWNvbmQgZm9y
IHRoaXMgY2FzZS4gTGV0IG1lIGRpc2N1c3MgaW50ZXJuYWxseSB3aXRoIE1hcmsgYW5kIGdldCBi
YWNrLg0KDQoNClRoeHMsIEjDpWtvbg0KDQo=
