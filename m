Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09535F12E
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhDNKC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 06:02:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhDNKCP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 06:02:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EA0XJr090619;
        Wed, 14 Apr 2021 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rYu0Ri/Y9AiDu12rsgd4Z/ZklcuUipRcI3XGH8cZlCw=;
 b=s5RWTEy8BVANBgpyGna8Bx9G+o0JJBOpKuiks2bfMY82pwIJC2qnjEZcpi8c2XDMJ8+1
 1Jx4/VaGIoM/zCLL6iG6X4CsdUgmkM9DufiIydX54NpLos5rKWpSI6sAuLDD/SxUPjIy
 /NuvBOaHLccdVw0wVO1SR9fwmm7Ph+bR8HF9VuIEC7T3L0AKZUAzmFzRSuQHdf0Qj+CC
 iYt7tTRj9GE7sdYlAEbJncKsP1AA0FuEmI8xmYmH2LekPEaU/6bH7tJjEjyEuBM6lQIG
 XdCQRr/AoZSkAj0TZBUMLFynU7IhVcgHnW4sZrVWj1QaCyzZAkAcstnP9qj095WbEzi8 DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37u3ymhuf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 10:01:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E9ximW132429;
        Wed, 14 Apr 2021 10:01:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 37unx13dw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 10:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvGs6bOpdyOIoToD6VaW7LiG+yCI14LDIwenagVnuFnBXCyZj1koL0J3WcAH2tOhBED1D6UILlfRKJx2b+DBre+J/OERtMGzSnk4zGUtVQ1RSL7w+EvueeyaffIjq2nAW/7ncoYH+NW67GZ1BjIC9MIfpTGg2QUFv+JCm9GkZRopSRJukiHnz4pXqzBCKIneEDQW9IaqF0NbAjuwrWHJYG1eocMZ+QbBOXh0RmFTtQC4+58lQQ0URAbD1+sZo7WNUEdwR67wnL/XXwdStyoF+yYga9OtigQnPb2XjsfiGSOWvSqMilTTQNTuSXm0luH1jKeAXPYTngBa2EuIf4FpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYu0Ri/Y9AiDu12rsgd4Z/ZklcuUipRcI3XGH8cZlCw=;
 b=AbUtMtDohe7u8WAxX1UXu+ldQlzUSkMcpwQrA1NZkGNY2ZJGQ5+pj23gO49Ftv22GbZ1DcHD0/jrJ5tweLiBxTgK4YdflrKAj2tvzZaI2dh1f3VyXhUfSJ3Rz4iSgkibQME0HC3X1Uv6NQ5hZ82oyl2fCA1uv9qd7nQZw+JPblkkcIQVyCh80CQNfvEEjIVJW5KoKDp0Ux8IQWmd+z3R1xmhQ8u4ikaEZvAFAd1WXdqSLpqaVxhTv3DzcFqNAfqcMzqjwXlUuHDrPe7IXbgFStrCP/1G6nn2h4wZZ2xOABirs7vy7nPDHFk1RPmR14GiG7CkMDK4SCnCWJ+VohuO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYu0Ri/Y9AiDu12rsgd4Z/ZklcuUipRcI3XGH8cZlCw=;
 b=A96O+j9UCNQb/Z9CkJhAZDI/Nx/FD6uhaK/SWzLZWO+GAhu56aC/lqyyMe+CKcjhh6DCWJ5hOo2LxKD1z3JkGf/wqthkTjXZAaE4ZVyCd70EdWEWUWV5DVHL0KXUFpAoktvIV2sst7aVBr9c7ABp8CK4QlDf7wW3RwijQqA0hk0=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1622.namprd10.prod.outlook.com (2603:10b6:910:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 10:01:43 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4020.023; Wed, 14 Apr
 2021 10:01:43 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Manjunath Patil <manjunath.b.patil@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "valentinef@mellanox.com" <valentinef@mellanox.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Topic: [PATCH v2] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Index: AQHXMJPThFy0QvxCN0Oht0Iw473Vl6qyyFiAgAEA1YA=
Date:   Wed, 14 Apr 2021 10:01:43 +0000
Message-ID: <9CE729BE-0E3B-4101-8AE7-60653388639B@oracle.com>
References: <1618338965-16717-1-git-send-email-manjunath.b.patil@oracle.com>
 <20210413184227.GL227011@ziepe.ca>
In-Reply-To: <20210413184227.GL227011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f5d6e7-8b99-4320-7766-08d8ff2c4e9c
x-ms-traffictypediagnostic: CY4PR10MB1622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1622510287D7B1032EC0B4BBFD4E9@CY4PR10MB1622.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRD2RvGgQfx+U0UB6pwx6gNxWGhINVLAd6hBLNx5JVe5fIszt1nRKhCERMDx0xMG0ZYPplx9UYU8DqhzSP1UhCkchsL2n2N/lKEMVCOhiG6N8Icv47Er+Lwrr1OIk+CUfIYBtpzR7TFKJK1+5TuRlBDr7JPSEO5OT6MVZE+JiftOziuYG6LZEAM67rBBJqhXrujkl2Lsem0G4zbD0b5AZMI7ACURtATsJPdBoGFr0B7X+KSfe4L2sX57y+2nMK1gec6LwHWDj5/R2eDZ+DtlsLC6wWQuu4M84/nnjpBNFhFTpSbjdHlBGtM5m68i7OgRICT8izx1yfwyh4jIVAtuwwXStBsKvNNs986rjC67ZV84FXJ2ttRiSLNFz9I4MzlcAP6Uidgw2kDK3hDXdxDih5bksOV/4eixHOKyROWmMuTxVe80wJQCezbe9kHlKbXj5HiWFFCppc+77qXJGZn9GK3o2pWF2wYPGBAHYB+BC0TK/5VnLNxSm1QerDv20HwePqjp0vzkuzjDbHAa63wgad/hXI4PDLqEGzxPOWtVv9xs+42wgef6Lv+kfo/VoF09+ZWPfDmVW7YyKTFCnesMyKlYDzP8vrlBmRpJBWLpfFSdEnyjjp2S/5WtohyroY1EeSDA1KJB7zgcmREe+lZhczpvxeoJi5CGPqRBmEw5soA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(53546011)(71200400001)(6506007)(76116006)(91956017)(4326008)(8676002)(36756003)(8936002)(66556008)(33656002)(44832011)(83380400001)(66574015)(6916009)(5660300002)(54906003)(66476007)(66446008)(26005)(2906002)(38100700002)(316002)(122000001)(2616005)(64756008)(66946007)(186003)(478600001)(6512007)(6486002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S1ZYdHV4QzdjMEdoejBHcU5sUlZ3ZTlGRGdvcU1HQnZPaXVTN0w5Q0dqbSti?=
 =?utf-8?B?bGhCVE45b3pTNzN5Ukw2b2IwcVZudTFKL0hLWXpwd01tZHdoajM2OGJaYkZp?=
 =?utf-8?B?KzBEeUZWT2tPWHFJdG14QytCZ2NXTkp3UlhtK3c1RDFSdFIrd2ZoWDB2MmJK?=
 =?utf-8?B?RWxKM2ZvRnlSeVFpL2dWK1ZrU2g0NzZmU294UU1zVCt4NUNoUzdtRCtobFFY?=
 =?utf-8?B?ejVxdzhGZnNsSWJVRjY1L0RUQ3ZSZ0xuQ0hlcFpSOUpJODFkalBDb0N4SGU4?=
 =?utf-8?B?cTJIWGJuUEpsTnRHUFhEb29FelFJK0hacmk5clFtYUg2S2dWeGE1UUt1cFZK?=
 =?utf-8?B?dlZWbm5DdEdpcEU2WFNFbUxmZzZ6aHRiV2c3ZHh0aE5iUjd1TGdhb0tQamlT?=
 =?utf-8?B?QklpSWxqU1JPWUVYazRXU3BNQTd5NFJIV2tGcE81L2lwMUdMcDhHcVdxQUJ1?=
 =?utf-8?B?ZjFJY21pQ0NrSXpTaTFjcEhzZFl0MGdaZUh5aDBKWlkyNWllVlBTdkpKNkpD?=
 =?utf-8?B?bkJIVUxZdFhvSTZtNkJvWUE4U2JROGZuNElCdCsxekJHTDYyK3F5ZG01Unc0?=
 =?utf-8?B?Z2x1Q1U1cEZIQitEaVdrdkxrMU5SZGhCeG5NaCtaODZhSjdZQmVxL3pPUCtD?=
 =?utf-8?B?dXlNREJ4LzV3c1hhSnNUMFd3SVo4dmZOVGt4YUpiejhuSXkrZE81RHQ5MUEz?=
 =?utf-8?B?ckRudEJVV25qaVIrTit0UHBJRDdmNkpIQU1EaUtrbEU3Uks0aEpQNit1c3FB?=
 =?utf-8?B?enZhbnFpQXY1blBLTjR2djQ5YkIxbUpBYndpVjBuWS9ta0VQWW1ZVWhha3RF?=
 =?utf-8?B?aGw4Mm5vcENIQTZZNUx4dnIvbHZBQUkrSEdJSjVtSWdlY1F4NEFyMHZpVFFs?=
 =?utf-8?B?bnQ3L3NRRHZQeFd5bndwMEVvdDN1TG5XV0tLRUpKcDYvMDNDdlFiUktnOXlt?=
 =?utf-8?B?QWxJYnVBcHVWd1J6U3F2WStaSzJXTGx6bEQ1eURmL0E3RnRrY2lFcFhOUEM4?=
 =?utf-8?B?RUhnT3poSkUxVWtzWlhOZTFJNWVVNEhNK2tUNW0wc1RRUUcyM00vZHZpbEJV?=
 =?utf-8?B?MEd4VTNZc3ZHVVlDeHF0TDAzSW1aNDJ2bGJNMnpiekt1cXljQ2hFNWxtY1dm?=
 =?utf-8?B?NExwZmVlOUJucW5JbzE2S2w0OHMwZWg4TWhkUUhPUUc4bXMxL2ZLSmJ0WGFN?=
 =?utf-8?B?MVlWMVpEQ2hwV0Q1YitXaDMzS21zMFBwY0NMRCtLVjR4L0hOWnVFWldPdkNH?=
 =?utf-8?B?Y090ZlBNaTNXZThldG0yOHpwd0xXV2pDTCtqaHBYS2NpNGowakRLTGdCdUVm?=
 =?utf-8?B?Q01nUmRTcDVlY3NmOWtBSEk1aUVjb280MjRUM3ZIWmVPMVc0UGY1M2pnZWs4?=
 =?utf-8?B?T21OTjYrOHN0UmZyVGtZMFBNUkh2OUZxZjJNd2VVcHdiZEdodkk3VklDc1ox?=
 =?utf-8?B?RTZhNHRLWlYrWnVTOVp3ZU5qRmdPVEFCc0FYRXY2czhFam5XZnlUSXhEZWJt?=
 =?utf-8?B?bUZ2dzdEdUxaMzZzWGgvUWw5dDZVd05WNURRU3VacXN4ZVdsYXhhbVFpOVFG?=
 =?utf-8?B?VUpKRlRNOHdhMGF1SzZSYzZ4dzFrUmp2SlBFRTJHSDlXL0kvK3FCdGN4Mk1Z?=
 =?utf-8?B?UFNDelNYSkp6S2xiZm9mU3oraU1xYTRRYmZ6UnFZajF6bEYzT0RLRkYxaGgx?=
 =?utf-8?B?RnI1UHlnbzV4a0NVRGdqV2U4YW8xZ0drbVpZNkZnUDJlVlZUVCtPMlB5dDNt?=
 =?utf-8?B?cnFtbExId3dUamZLTjBCMmpQbmRwU3IzeHd2eUJVcFkyKzZ2cytHTHN0M1hw?=
 =?utf-8?B?YUtnUUhpRm1xbVlBM0MyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4B0E31303374440B83EE893B00A3892@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f5d6e7-8b99-4320-7766-08d8ff2c4e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 10:01:43.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GySWY/KuJeERAIn8o6LA4MO8kU/PR/+rYthgboau/2Xr/VQWOY/jOa2U+1bS+2CmfxljD5jBk7o+guQWRVHx+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1622
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140069
X-Proofpoint-GUID: zCeIRuCqnSpo_nnYt4IKBMcBJMPhAvLa
X-Proofpoint-ORIG-GUID: zCeIRuCqnSpo_nnYt4IKBMcBJMPhAvLa
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140069
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgQXByIDIwMjEsIGF0IDIwOjQyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAxMTozNjowNUFNIC0w
NzAwLCBNYW5qdW5hdGggUGF0aWwgd3JvdGU6DQo+PiBDdXJyZW50bHkgaXBvaWIgY29ubmVjdGVk
IG1vZGUgcXVlcmllcyB0aGUgZGV2aWNlW0hDQV0gdG8gZ2V0IHBrZXkgdGFibGUNCj4+IGVudHJ5
IGR1cmluZyBjb25uZWN0aW9uIGZvcm1hdGlvbi4gVGhpcyB3aWxsIGluY3JlYXNlIHRoZSB0aW1l
IHRha2VuIHRvDQo+PiBmb3JtIHRoZSBjb25uZWN0aW9uLCBlc3BlY2lhbGx5IHdoZW4gbGltaXRl
ZCBwa2V5cyBhcmUgaW4gdXNlLiAgVGhpcw0KPj4gZ2V0cyB3b3JzZSB3aGVuIG11bHRpcGxlIGNv
bm5lY3Rpb24gYXR0ZW1wdHMgYXJlIGRvbmUgaW4gcGFyYWxsZWwuDQo+PiANCj4+IFNpbmNlIGlw
b2liIGludGVyZmFjZXMgYXJlIGxvY2tlZCB0byBhIHNpbmdsZSBwa2V5LCB1c2UgdGhlIHBrZXkg
aW5kZXgNCj4+IHRoYXQgd2FzIGRldGVybWluZWQgYXQgbGluayB1cCB0aW1lIGluc3RlYWQgb2Yg
c2VhcmNoaW5nIGFueXRoaW5nLg0KPj4gDQo+PiBUaGlzIGltcHJvdmVkIHRoZSBsYXRlbmN5IGZy
b20gNTAwbXMgdG8gMW1zIG9uIGFuIGludGVybmFsIHNldHVwLg0KPj4gDQo+PiBTdWdnZXN0ZWQt
Ynk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBN
YW5qdW5hdGggUGF0aWwgPG1hbmp1bmF0aC5iLnBhdGlsQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+
IHYyOiB2MSB1c2VkIHRoZSBjYWNoZWQgdmVyc2lvbltpYl9maW5kX2NhY2hlZF9wa2V5KCldIHRv
IGdldCB0aGUgcGtleSB0YWJsZQ0KPj4gZW50cnkuIEZvbGxvd2luZyB0aGUgSmFzb24ncyBjb21t
ZW50cyBmb3IgdjEsIEkgc3dpdGNoZWQgdG8gcGtleSBpbmRleCB0aGF0IHdhcw0KPj4gZGV0ZXJt
aW5lZCBhdCBsaW5rIHVwIHRpbWUgaW4gdjIuDQo+IA0KPiBDYW4geW91IGNvbmZpcm0gdGhhdCB0
aGUgcGtleSBpbmRleCBkb2VzIGdldCB1cGRhdGVkIGlmIHRoZSBTTSBjaGFuZ2VzDQo+IHRoZSBw
a2V5IHRhYmxlPyAoYW5kIGlmIHNvIGhvdyBpcyB0aGUgbG9ja2luZyBkb25lIGZvciByZWFkaW5n
IHRoZSBwa2V5X2luZGV4PykNCj4gDQo+IFRoYXQgaXMgYWJvdXQgdGhlIG9ubHkgcmVhc29uIHRv
IGhhdmUgaGFkIGEgZGVkaWNhdGVkIHF1ZXJ5IGhlcmUNCg0KVW5sZXNzIEkgbWlzdW5kZXJzdG9v
ZCB5b3UgY29tcGxldGVseSwgb25lIGluc3RhbmNlIG9mIGEgbmV0ZGV2IGhhcyBvbmx5IGEgc2lu
Z2xlIHBrZXkgZm9yIGl0cyBsaWZldGltZToNCg0KPiBPbiAyNyBKYW4gMjAyMSwgYXQgMDE6MTYs
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gWWVzLCBhbmQg
ZWFjaCBuZXcgbmV0ZGV2IHRoYXQgc3Bhd25zIGhhcyBhIGZpeGVkIHBrZXkgdGhhdCBkb2Vzbid0
DQo+IGNoYW5nZSBmb3IgdGhlIGxpZmUgb2YgdGhlIG5ldGRldg0KDQouLi4gYW5kLCBpZiB5b3Ug
YW50aWNpcGF0ZSB0aGF0IHRoZSBVRCBRUCBpcyB1c2luZyBwa2V5MSBhdCBpbmRleFgsIHRoZSBw
a2V5IHRhYmxlIHRhYmxlIGdldHMgdXBkYXRlcyBieSB0aGUgU00gc28gdGhlIG5ldyBlbnRyeSBp
biBpbmRleFggYmVjb21lcyBwa2V5MiwgdGhlIG9sZCBwa2V5MSBpcyBub3cgYXQgYSBuZXcgcG9z
aXRpb24gaW4gdGhlIHRhYmxlIChvciBub3QgaW4gdGhlIHRhYmxlIGlzIGFub3RoZXIgY2FzZSks
IGxldCdzIHNheSBwa2V5MSBpcyBub3cgZm91bmQgYXQgaW5kZXhZLiBOb3csIHRoZSBjb25uZWN0
ZWQgbW9kZSBRUCB3aWxsIHVzZSBwa2V5MSBhdCBpbmRleFkgaWYgYSBkZWRpY2F0ZWQgcXVlcnkg
aXMgcGVyZm9ybWVkLg0KDQpUaGVuIHdlIGVuZCB1cCBpbiBhIHNwbGl0IGJyYWluLCB0aGUgVUQg
UVAgdXNlcyBwa2V5MiBhbmQgdGhlIFJDIFFQcyB1c2UgcGtleTEuIFdpdGggTWFuanUncyBwYXRj
aCwgdGhleSB3aWxsIGF0IGxlYXN0IHVzZSB0aGUgc2FtZSBwa2V5Lg0KDQpOb3QgcmVsYXRlZCB0
byB0aGlzIGNvbW1pdDsgSSBmaW5kIGl0IHN0cmFuZ2UgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIG9m
IHVwZGF0ZV9jaGlsZF9wa2V5KCkgaXMgbm90IHVzZWQgaW4gX19pcG9pYl9pYl9kZXZfZmx1c2go
KS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCg0KDQoNCg0KDQo+IA0KPiBKYXNvbg0KDQo=
