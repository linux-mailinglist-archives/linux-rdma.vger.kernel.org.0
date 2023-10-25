Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5137D6C68
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjJYMxM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjJYMxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:53:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D0116
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:53:08 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClOFL030731;
        Wed, 25 Oct 2023 12:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qecffAmdZelNO0e4wqryXZ/uADhWZnPgWhHjPdPBhak=;
 b=rVyMCkaHum8BAGG4YM9JvaXpkPnfoKytviK+4vP3TYajQ6dKsn8CPAiF8UxGOvcgVguK
 okHC5LaU5t4iV5eITeme5goXHHwO86YXjOTBgnjGnbKBTq2C31Mkbz0A2wXcnkC5DRAj
 xf90htV/pDfpB6BScotRymoUciH3FfFfsSbR9v5m+1VthWhMMLSNSfI/bCu76PYjTaOZ
 LFoCzzyiyRjYl7ikgGM1XPHdgvuTKiSvF9toquwOZpkBMD39gV4RkTJXvZTPK+EcA495
 oXbxxa64Iva62lFkRjXR7F76Aw0gg9h3/fZtkmKFUPYmDfdqFxTLOovJ4frCCXG3Gs0C hg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b2094s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivPbEKZ7x0AuJAK0BHxTgAn2VfuEDUP8xaErPiio02z5cGBJ0+IDDM9k6vSOjkNnqJXREbCDV0V3L8CK0NtmTIcEdVmg3KdEgikwUjH8fdMfRIoJK+SRYH6Wqw5jHVvvUK76uylmTrCWfOlIy/mbT3z4XqgppkCq/nS2TmsLlsvTKvwKlJ0OI9+WkIMPh35UTPoUKdP381uL4yL/QUwzmpC21jcmwli4b9lOq2bcm3pYWar9a1Y4AHxllKDbOBDSv/wkvN0xdHGOc8h0yeqsuTejDUi41NpNWBsiBWv7Bou6OZdmpXHKrblO0LFlIK5b/m86+YzDw9xzoI+SmrlbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qecffAmdZelNO0e4wqryXZ/uADhWZnPgWhHjPdPBhak=;
 b=FiY3ELVW2a6UPdm21KRJ/FofXnp1jqqilf2iI8gpoMv64JwpkFQVsAQp052ST4nX4veY/rtoYbVR0Jq8mSLa7NhkUoZbs69Qyh4Dz/cXG5imhKVNZ6rZJYXGzujL/SJKezI3fN0y39f9zXPpfRwQ+OTzo5oc4AZylGh51AMVlD7SJpCfa/n6SaQTXkjGTuRwoLNtNmx4uZ94LrIuy17N1SVaWnyVGBJzvlwE697JDZBqS0HGPi8SIYUk8tLQG2lyTKSZ3szIrTDYnjNY+go4ZcOgEZCfwssEp2WqrPwWt4y682co4h8B8orFoP7B5ghY/RYVZKjx1n7aBwqkj/dZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DM4PR15MB6324.namprd15.prod.outlook.com (2603:10b6:8:186::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Wed, 25 Oct
 2023 12:52:56 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:52:56 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 09/19] RDMA/siw: Introduce SIW_STAG_MAX_INDEX
Thread-Topic: [PATCH 09/19] RDMA/siw: Introduce SIW_STAG_MAX_INDEX
Thread-Index: AQHaB0IscUFrGLTzd066I6f1j4GUhQ==
Date:   Wed, 25 Oct 2023 12:52:56 +0000
Message-ID: <SN7PR15MB5755FEA583B8784042D492AD99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-10-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-10-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DM4PR15MB6324:EE_
x-ms-office365-filtering-correlation-id: bb8b6c98-08f7-4e9a-77ff-08dbd5594f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOblxoZ+lLr8ZjDRr5d2A0AXC5XxaMvY9XEIrslDxDduUChi66GwBtdNPr5oTr9fVgDrYL9TIuOX2a5J3EGjqeRHT3MWRtuJgiepgZBhsueox07LEKPo80ThZRb/uctnBhX6TSdJO7GiSY0Pb+oUy1CGRk2vQ83+G117JLZjck45Dh3b9fHBMSrsGAJozK5MjtHA75tjgEMYPmen+gOp/Tfoc1gsbqWvj0C98VV9oTX4bQ0yDY7cTKouXkts8eqks/og5+0LsVRdtnVIGZxsM8H3PRQZAte6BWWiNfQLPBXO/4q5muySF1lg5KrONlvHnvI/1+LOXY8OxuIOa0ccmYWtUrOLsL1jt9dSDq7op00VWB1tL1Eio7TOd18nuBr0NUh5pDT6Y+NQl7qZkWinK+Z7QSLf5HOtH2Y+meS9NZEJCzUVymXFkQBiHwsNiDIMVs4biyRKNy+O+m8ii3lIrtC3dFlXP9/2ZwBl8izN6SMtERNP3IL2pApGsRiAvYJ3O2G4LxaYriUAOYZuL7NhzcfcDQ/qjrYcSHbwhPG/OK+vrZlFU9DBNETrc3SRINlyTul26ECA8bgysai5D/qPUjy3XQeBm56yEKIqURUazoRN5937nm8Ag9E5M+hmrmQq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(83380400001)(55016003)(2906002)(8936002)(52536014)(5660300002)(4326008)(8676002)(41300700001)(86362001)(478600001)(122000001)(71200400001)(53546011)(38100700002)(6506007)(316002)(7696005)(9686003)(110136005)(33656002)(66556008)(66446008)(76116006)(66476007)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZyaTZJenZUVXREcVZ0bnZVUUM4M1Iwb3plVzd4STJzTGNEQkc4U3gvbW9u?=
 =?utf-8?B?Wjg3Ykx1Sk5OZTJUd2djNU43Rk1SWHlLcURlazFUMjdidVlXTkNPZjluWEVr?=
 =?utf-8?B?TTlUc3pTdVVhY3dsTzc2TTd4L0kwbUdNVnlHSGw5K2RuaXF4VEk0bkVWd3Jh?=
 =?utf-8?B?N2pnNm9JbjdjNlJCN3kxMFNlL0tkbk53bEE2OFdzck1WeXhXUVZQbm9iSWQ3?=
 =?utf-8?B?d2hnSU1CTW5XNmMyQXNTaVBhRzh2T2xHL3BDNm81WFBmbHJBR20yM2FTa0pI?=
 =?utf-8?B?bGFvK3hkM2xHSkZSR2NXSk1hMmw2QUJjOEd2Y1ZpblNjSTZ5Zlc0Rk5kOGMx?=
 =?utf-8?B?VDJWTUdCeHlPUzZRZWVqUWEvNUExZThObXZseGFXWmtlQThBNUZ0OXBjVGl4?=
 =?utf-8?B?T21BUFpKRXZsL2RRMVBFZ3FsL282ZVYya3U5bkN3K3M5WVdnQ1ZLdjdwTzJK?=
 =?utf-8?B?VjdpUTBrYU1DZmRLU3VJZzE4d2lvbzZCdE55VCtGdGVUb0VPR1dPblgyb1U5?=
 =?utf-8?B?Vmd2NGJSOTIvMDRXcktkZnlvOXV0bDR0cHNQc2ErdjFRYm9GSllWenZSY3BI?=
 =?utf-8?B?SjFDeWpXaittZE5ST3c4eHlnUzc4MGE4Ny8renVKYlhCZzhIQ3BIVDYzdzdN?=
 =?utf-8?B?M09raVRLeVV4WE1aQlRtUnBMU3Y2QnF2VGJEcS9CcFVKV2RjUkhLRk1xOVZ6?=
 =?utf-8?B?QmNvenYycThQWk9tQkllTWtJVEtLN2NTSXptNW1hbVpva0xETG1ZZTdaN2xh?=
 =?utf-8?B?WmlCSTdSNDV6T3BNbVFYdWdqWmFMQnJQaGFjcHA2dlRTMzFramV6VzVIWjdq?=
 =?utf-8?B?Qnd0R081c3hQNUhlQ0dnYzJkRXBWSjBRQmQrK25kN1ExTVlOaEhibDdUTE5a?=
 =?utf-8?B?aHp1aHlhYWQ5cDZQd2I5ZlhRV3BZeE5wOXhldUpRTFpFaUwrcitiQWp4WSt3?=
 =?utf-8?B?eVdrTzNaQVU1cDdPM2JOT1FRUDV1MTg0Wnd1QjdqMVdoMFRudk8zeWxLYVlG?=
 =?utf-8?B?clJVelN2b0RIeERwVVFQazRFZE1HSTJEU3hISnQ0VjBnZVhMb2d4dzVRUEJ2?=
 =?utf-8?B?QTIwR2JxS1BDTDJUaGszcWgySGdXNWs4RzUzVUZwcWNoMXIyUzA0cmF4Y3I5?=
 =?utf-8?B?QkVFT0lmU0VxVUpFOWV0cEZsOVhOeVVpUTNVMmtLOXNBSEZPblNBQm1pTUQx?=
 =?utf-8?B?MitJbkFrOEdac01aMEN2elQ4cEVYcG5YV1NKNis3TlgzZlI4QzhFZTAycEM0?=
 =?utf-8?B?ZGRQYTB4WXVGUnpGaTNHS3V4aXI4T05Pb0tla2ZGRlc2Vmk2NUkzcTMzN1FF?=
 =?utf-8?B?VVBGSE5hczVwamdBZ3dMVjlSclc5bEhCZko1Z01MSVZ3M3RNQkpOOVE2SHow?=
 =?utf-8?B?YVMzOEk1WThZZUh6WEVmc0xsbHVMaWlzRm9GMS9Ga3pyWXhIZy9sVjNFK0lp?=
 =?utf-8?B?NWdTN3Qwa2xQVXp0Q2VFWXY4aEN3NjZhdkJNMVhwS3N0OHlNNSt3clc4bFlw?=
 =?utf-8?B?RjdtREhMSUoraHJhQzU4TXdFTFNLL0FoY0tCM2dzZlhZcHFzR3kyQnhVZGF6?=
 =?utf-8?B?bGxJOXc4UVJFbzRyd1JqT2M0dzltU25kam1YOWdOWmZRQUhyaWMrRk83Qmg1?=
 =?utf-8?B?cTNScVdrZzlla0MveFdFVzNyZy96TEduQVB1OVdrVWh0Ylk1Q2ZjZW45S01s?=
 =?utf-8?B?S2pxdHFiSzliTmcrbVZIUGRqTnZTTjkrdFQvVlRSbUYvcWtnYWY0azNXTDRC?=
 =?utf-8?B?ZTY1ZUpVYklKYU1QVWhHLzYrM1BoRDJNbTJNRFRabVg3T0lkTkx1V1BwQ1lK?=
 =?utf-8?B?WVJvTVpmRXVjTmM4QmxOOEhtUHd5TllBWTgyQjZNUkR2Y214anVhR05VL1Fl?=
 =?utf-8?B?N1ZpVEEzVXA0cFE1Rm1EaHBrL0ZURGJlR2ppV0I1WGxxM2pUWU94SFJGR1o5?=
 =?utf-8?B?QmJ5WGY3akc5aHphbFBxaXFIcE9UcXlERFJpM28zaFh2b29Mekx5eSttOU9O?=
 =?utf-8?B?NFdHZjhTTFd6aXlBN2dsMUV0TnVwVlk2SFBHZW9wbUJoTDVEK09BZnY0ODJY?=
 =?utf-8?B?emNuQ04rSm9zUURGRDdmNFd0eFdxSjRZbDNDdjlGdnpsVlh3MmQxQURDZzJo?=
 =?utf-8?B?N2hrMzVmeHlNai8rc0E5T28veVdSSlNhY21jelkydjhKbWhycHBXVVNmS3FL?=
 =?utf-8?Q?4ubSuIahDlpvIUAHoREbvj0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b6c98-08f7-4e9a-77ff-08dbd5594f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:52:56.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QSRmq06z68Cp/UEtEOAMVZDvUovhlC+gO1o05gPWiIJpreXWXju6lCYJnzL65hkgNjSQy63gBYq9A3di/r8fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6324
X-Proofpoint-ORIG-GUID: AXpl_kCeI23bR1wwIpvcCQiY4BrVracH
X-Proofpoint-GUID: AXpl_kCeI23bR1wwIpvcCQiY4BrVracH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=696 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDk6MTggQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdn
QHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDA5LzE5XSBSRE1BL3NpdzogSW50cm9k
dWNlIFNJV19TVEFHX01BWF9JTkRFWA0KPiANCj4gQWRkIHRoZSBtYWNybyB0byByZW1vdmUgbWFn
aWMgbnVtYmVyIGluIHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFu
ZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfbWVtLmMgfCAxMiArKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19tZW0uYw0KPiBpbmRleCA5MmM1Nzc2YTllZWQuLmFjNDUwMmZiMGE5NiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gQEAgLTEzLDE4ICsxMywyMCBAQA0K
PiAgI2luY2x1ZGUgInNpdy5oIg0KPiAgI2luY2x1ZGUgInNpd19tZW0uaCINCj4gDQo+ICsvKiBT
dGFnIGxvb2t1cCBpcyBiYXNlZCBvbiBpdHMgaW5kZXggcGFydCBvbmx5ICgyNCBiaXRzKS4gKi8N
Cj4gKyNkZWZpbmUgU0lXX1NUQUdfTUFYX0lOREVYCTB4MDBmZmZmZmYNCj4gKw0KPiAgLyoNCj4g
LSAqIFN0YWcgbG9va3VwIGlzIGJhc2VkIG9uIGl0cyBpbmRleCBwYXJ0IG9ubHkgKDI0IGJpdHMp
Lg0KPiAgICogVGhlIGNvZGUgYXZvaWRzIHNwZWNpYWwgU3RhZyBvZiB6ZXJvIGFuZCB0cmllcyB0
byByYW5kb21pemUNCj4gICAqIFNUYWcgdmFsdWVzIGJldHdlZW4gMSBhbmQgU0lXX1NUQUdfTUFY
X0lOREVYLg0KPiAgICovDQo+ICBpbnQgc2l3X21lbV9hZGQoc3RydWN0IHNpd19kZXZpY2UgKnNk
ZXYsIHN0cnVjdCBzaXdfbWVtICptKQ0KPiAgew0KPiAtCXN0cnVjdCB4YV9saW1pdCBsaW1pdCA9
IFhBX0xJTUlUKDEsIDB4MDBmZmZmZmYpOw0KPiArCXN0cnVjdCB4YV9saW1pdCBsaW1pdCA9IFhB
X0xJTUlUKDEsIFNJV19TVEFHX01BWF9JTkRFWCk7DQo+ICAJdTMyIGlkLCBuZXh0Ow0KPiANCj4g
IAlnZXRfcmFuZG9tX2J5dGVzKCZuZXh0LCA0KTsNCj4gLQluZXh0ICY9IDB4MDBmZmZmZmY7DQo+
ICsJbmV4dCAmPSBTSVdfU1RBR19NQVhfSU5ERVg7DQo+IA0KPiAgCWlmICh4YV9hbGxvY19jeWNs
aWMoJnNkZXYtPm1lbV94YSwgJmlkLCBtLCBsaW1pdCwgJm5leHQsDQo+ICAJICAgIEdGUF9LRVJO
RUwpIDwgMCkNCj4gQEAgLTkxLDcgKzkzLDcgQEAgaW50IHNpd19tcl9hZGRfbWVtKHN0cnVjdCBz
aXdfbXIgKm1yLCBzdHJ1Y3QgaWJfcGQgKnBkLA0KPiB2b2lkICptZW1fb2JqLA0KPiAgew0KPiAg
CXN0cnVjdCBzaXdfZGV2aWNlICpzZGV2ID0gdG9fc2l3X2RldihwZC0+ZGV2aWNlKTsNCj4gIAlz
dHJ1Y3Qgc2l3X21lbSAqbWVtID0ga3phbGxvYyhzaXplb2YoKm1lbSksIEdGUF9LRVJORUwpOw0K
PiAtCXN0cnVjdCB4YV9saW1pdCBsaW1pdCA9IFhBX0xJTUlUKDEsIDB4MDBmZmZmZmYpOw0KPiAr
CXN0cnVjdCB4YV9saW1pdCBsaW1pdCA9IFhBX0xJTUlUKDEsIFNJV19TVEFHX01BWF9JTkRFWCk7
DQo+ICAJdTMyIGlkLCBuZXh0Ow0KPiANCj4gIAlpZiAoIW1lbSkNCj4gQEAgLTEwNyw3ICsxMDks
NyBAQCBpbnQgc2l3X21yX2FkZF9tZW0oc3RydWN0IHNpd19tciAqbXIsIHN0cnVjdCBpYl9wZCAq
cGQsDQo+IHZvaWQgKm1lbV9vYmosDQo+ICAJa3JlZl9pbml0KCZtZW0tPnJlZik7DQo+IA0KPiAg
CWdldF9yYW5kb21fYnl0ZXMoJm5leHQsIDQpOw0KPiAtCW5leHQgJj0gMHgwMGZmZmZmZjsNCj4g
KwluZXh0ICY9IFNJV19TVEFHX01BWF9JTkRFWDsNCj4gDQo+ICAJaWYgKHhhX2FsbG9jX2N5Y2xp
Yygmc2Rldi0+bWVtX3hhLCAmaWQsIG1lbSwgbGltaXQsICZuZXh0LA0KPiAgCSAgICBHRlBfS0VS
TkVMKSA8IDApIHsNCj4gLS0NCj4gMi4zNS4zDQoNCk9rYXkuDQoNCkFja2VkLWJ5OiBCZXJuYXJk
IE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==
