Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1E7D6BD7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjJYMdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbjJYMdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:33:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44ECC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:33:35 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PBnuPr021933;
        Wed, 25 Oct 2023 12:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JijKZ9WRWuVOm7VMM1d6T9GGgI1r7+l+TRW65Z0Ww1g=;
 b=WtyuaqOical4aJpKwcgjIxYZN5BnZKMqY18goRJJfslWyfDcKRlNg2Shai7OvR2wq9cl
 uuDTyRKRc9vF2TcOUplnN53bTUAiI1yyjEJUq/knP9QvJ0uVOHfgX0OZCu8RpkeKt8Yg
 NslzmSP0fjelERDxr2rR3x5lKTKkXgA94XOqO7J3cDhOy+QqrELJ3npbP+FHhJ+qXM3c
 Ovmp+vfyrO8ge3pmVkJtttTgwXia5VPKgi9LddBqTNrfrp0rGIuBFHzjIw/XV1nUkNPn
 VeAPCA3r1shKmM8VOmoT37lVBj8zmup/5ZRIfN6DLb5byWl6eksg7yO0CGe2fYiloBEW xA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2g1s4u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyLJ3gFEAqWAozY9ZqhSPZD4vSq0M0tUdOkcIp8P5GSVMbHSKbuwrDilZCspfP0Luc2i2BVooJhA8xiGOZeiUNiWWJpVxy5fj6ptBq5blkHlAdMzg4y+WmKXwni102R9lReePSECQQKEXOyU0NtRToplWrfbjyOD9Wv214LMHuRVM02yNpbGuqULeNbWmar3PNT9pmr0esmYgXuDgJj8vTYjjbYyrl3yXaeEyYf/a1IHXoeztJXL2T+kW/6DwocL4yvAcb4Z7oNHifMUcDwNIR6pa+l9MTi4etGtyrWWb/y2Lm1AbgXTiUF8QfuYhxdBqudpebPa430qMfcFrojtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JijKZ9WRWuVOm7VMM1d6T9GGgI1r7+l+TRW65Z0Ww1g=;
 b=EIlXvVBq7LkiWjifl4WeG07icSOjwaiSMmiYb0GE2K6yVdrKW5jicSfG/9TerWohE/7xZJcDok54Mi6ZhA2Lx4GIo6S/8i2cIf6ZUNFpzwm/tbo5g/82viqXgFQLtAlSQpAoJSrk8svp4eBi6klYB16eXmCiUFqVDpCfAyX5RY6CR04hfEXOttjFFp3lLDaVuQrGZ5HHADVwdFx0Cbv2BiRWc3POuARRxELjJH6Ky/DmnD0hfKP7JBDGQHUbGKl17jMeYPB/Zq5bBw39XRsVtkYDlyVZRzss+TTGbhzCJa9SVjU6y7d6MfOmIWO7DuA4fcQRmXvbdOuMDDzQhdMnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by PH7PR15MB5401.namprd15.prod.outlook.com (2603:10b6:510:1ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:33:25 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:33:25 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 02/19] RDMA/siw: Introduce siw_srx_update_skb
Thread-Topic: [PATCH 02/19] RDMA/siw: Introduce siw_srx_update_skb
Thread-Index: AQHaBz9yl48fJVJlW0aKfIiUWnwHdw==
Date:   Wed, 25 Oct 2023 12:33:25 +0000
Message-ID: <SN7PR15MB575564AC986E9CB8F3D1E06799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-3-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-3-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|PH7PR15MB5401:EE_
x-ms-office365-filtering-correlation-id: ee3e37ff-44cd-4fac-0476-08dbd5569586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpf8Mur6e+jWjgMuQS3JlspOZJu2KE3U/PumUpifbKLFC578UmTJa62Tl2faDMpaZnXb7i0L7EH7Ze71zXjcNd7sKLoHdXSqvYGM7Vqy37ADj4AQepfIwyl8yLOpkkMaHk85aVso4LeRhKMETj57sg1nqvWwwldf5udH3CiZ4bW2tBRFKGVlEJtFevdVeU9iL1ExT67Ci2vdP2lS0Q/APt3Cpl6wHIK6/v8fvUSXRmPcewnKUdOPlSHnKOWHbG3yY2HsXW/WFeNwXFhNvCiPkvmP34MCloPSr3vBaV0c29AEbuPYkUypMhuG3hWsDVAQy8jvZ+8zzD0h3GRs2f2gPdp2RQg3Y9tW2/HYHZaKw4uoOck53cY3rxAw/klT+G/air2vAYQ9cymLRscZIsJ6ok0QqHp3OxQJbbTT+ZL2z/OLWmQzjhHk/rLfJCcyHRY6AqLW3zwg/VW31FegB53wihrCQ253a7MAaOHhY0+mc6qiST90xkQuxFOCqWLclyho42gMpBHuqPa6Uyrp8OqxzJQ71ziUBwOgjyfdfHFiBe4AZ1LmxnRB1N/1pmsd2z12j5NoAgZoXHCVgCXJZyoGGiUsv+s++2irt0iwZ4kbagPQuvgawinrPZPXmSoQojIu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(9686003)(7696005)(71200400001)(8936002)(53546011)(6506007)(83380400001)(52536014)(4326008)(41300700001)(5660300002)(66446008)(8676002)(478600001)(2906002)(66556008)(110136005)(38070700009)(66946007)(66476007)(316002)(122000001)(38100700002)(86362001)(64756008)(76116006)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzN0RSt5cHNMMHZwcGt3SktPS3FDNnlSN2RPUk82ZXVxZUpVKzFDbGdHT0Qr?=
 =?utf-8?B?NytDVTF0bTN1QXAxcmUzM2JtdkxkNTNUMjNvL0RHc3lDM1FubWpyRFVGdjdU?=
 =?utf-8?B?bEdYNXRSTnd5UDdnVDNYeWpEMkczbFpCeTRiYnpLUmtaM05ONXMrMkEzTjZp?=
 =?utf-8?B?YW41QU8wN01tSUhsZEQyMlk4bmRjZlJwYXZKSUtBTGhEL0M1TENYNVFWUktt?=
 =?utf-8?B?TFd5WFFYRU9PSitCKzdwTklFYmg3b2xseUEyRGtrWDFGMjdxd3hOM21OV202?=
 =?utf-8?B?eXltUGtoYVJlRTZRYmF4d3dYSkRudjNyeFlqWnljN2ZRcW8xSGQzMlQweGk5?=
 =?utf-8?B?MXpQaGcvb2lJbGFyY0ppaFl3dFhSTW5DTTNVcnUvSEJIQkhEd3hscmFjTzk4?=
 =?utf-8?B?bExVcnRiU2U3SHBDcHBsN1lhY2lmdDBmTXRWblpGd05rd0dzWXFBVUdIRnRp?=
 =?utf-8?B?TEgzQktxQnFFd0pJMVZCT0dpbkVvRFI0SnJsWWR6eThXeHJEaHhHZ2g2QndG?=
 =?utf-8?B?ajdZM1J2S1lSeXF5WWc3L3NFd1dKY1hiUXJXUk52TmxTN1dYWTVEMDF1eXB5?=
 =?utf-8?B?ZVNPQlMwSmhZU3RDcnNaL0xpMEc4OExHOEJhTmE5ckxnb29vNlRxMHc3STJa?=
 =?utf-8?B?VmlqYjFWaFBIcW8zQjlpR05LaCtwemc1aWZ3ZmcvUURKb3kxME5tdEdKWm4y?=
 =?utf-8?B?NjVjd1dQRW05VU02UGhQNkNTK21oVkZkYlZoMHFDUjZLaWNHSmFmT1YybG5R?=
 =?utf-8?B?YkVEY0tiTy9mMFQ2ODROR2NqOGI1d0Z2VXFhV1Y3MzJPNWliOU1VVWRPYnZs?=
 =?utf-8?B?SUkzTlZiYWlrMFpjc3Z0eTduaE5XYk5vczQzd2VYMzdiV2VUckdIWERmeWdh?=
 =?utf-8?B?WTlweFdCK0xsc1RJL253ZlN6aGhUdWt4bWpYQWFndmNzdjNWblZUajRmT0ly?=
 =?utf-8?B?T0RRU3JQMzdzS3NLcHM3Y2pVWmJDUUMvQ1VOQXVJZHU3RzRMSGhqNlBvL3Fq?=
 =?utf-8?B?SkRBTmFTcUlWUk8zTWtrL2J2SkRUVEd3MmkvNndkOEd6blpkNWdoNjI3UUJv?=
 =?utf-8?B?L29Bc2Rvcks4ZHd1dFd2UEk0UG1KNUNiOW9SWmhYb05UTHc5dERkTithckVu?=
 =?utf-8?B?ZDlBelFNTXpnRTIxZjQxVlMwOFByOGJJQ2d6eGJKb3NtZFc0aXFyUGJCZWVv?=
 =?utf-8?B?bkQySS8wVE1CeTRRQlBiS2Z5bzliRDh1QzRWUFVPQU9wdFJKVGNiRGRxMXpy?=
 =?utf-8?B?S3VnbFFhK3R5d3YwcFFGcmFqTjFudm5iTXZuZDdiNkdhZGtIZ1czWU01bDQ0?=
 =?utf-8?B?NGw2cS9zbFZWd2dZMEUxN0REQXVJa2lHV2xUamhUZjZ4WWF4WG9iQWpVMW1a?=
 =?utf-8?B?WnQ4b09pNkhQbkVFRHRFbG9MYWJqT1MxdE5RTWZjTHhFbTk0OGlMaUV3NGta?=
 =?utf-8?B?dkt1Z3FiVXJnRnpTTVdMZlhielZ6dmZWcGIzNzBwTk9pbmtwMklwaDg3S0lZ?=
 =?utf-8?B?ZnlkaTcrY25IUE5GSm9lQ0hNdEJqOUZnVzcvZHY0UHFjSWMvNG1IbmptKzdS?=
 =?utf-8?B?TGQvcnhKd2o0eTB6V0VOWG9YODFiS3hYVHI5bnMyYmE2ZEVUbGpuOHBhbGZz?=
 =?utf-8?B?USsxQk5HWXR2OTFReUUzSXNRUWJRSFJ3S3J3QlZWZ2Fwa0hNM0p2UXBKUkxo?=
 =?utf-8?B?MHE5dTRaYzBjdWd1RkRVQnVTL1c0MjRITWRta2p0dXFsNEIxcE00NFdNZ3No?=
 =?utf-8?B?RlpFVytURlNFaVVROExXb2lNaDY4Rm9kN1FheHRrQWx5TWNJYVpFNWsvQ0ZD?=
 =?utf-8?B?U1cvVTBEMTMwWW80TkVJcVk4Qjg2bEE5TjFVaWhReXlmYXQzTTVDdG9idThK?=
 =?utf-8?B?ejNHWnRwU1g4a3lIRVFGS0h2aFV1UW94MVU2UnExNkM4UzVSRDk2NEdRYjJO?=
 =?utf-8?B?Q3haamNoQytHcWNWU0E1bzBpYnVGRlhYZVVPcjNOdVhzT0UvRHNsSmwwUThY?=
 =?utf-8?B?eUdkQmp1bEVlRlhjK2ttdmRETnBSRTdKY3g3LzkrN1g4eTBIanV2ODFDSGZx?=
 =?utf-8?B?YzBTSlR4cUE5eGFWU0drZGtzazhrZFZRcjFQbmMzUDBCa0JVTXBhZjh4eDJR?=
 =?utf-8?B?Tytja0VuN0lEY3pVaHZRZ2RKaVp3dXpqR1Z3TnNDYUQ1b0lGZ3ArSnNLTUx0?=
 =?utf-8?Q?j8JSzXUXLFo0Iq4NYByu8Ww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3e37ff-44cd-4fac-0476-08dbd5569586
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:33:25.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqt1A0pN0r3N1++XTwZGUPQz9Urdsx7Hf8sCAr/9yXRB+P1GtUk1gNiOx3oDosX9CZ6Ho6EvK9S4Q/asH/le+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5401
X-Proofpoint-GUID: Aq2fEbuDiC2LO7W4SzOEtP2uut3731re
X-Proofpoint-ORIG-GUID: Aq2fEbuDiC2LO7W4SzOEtP2uut3731re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250108
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDAyLzE5XSBSRE1BL3NpdzogSW50cm9k
dWNlIHNpd19zcnhfdXBkYXRlX3NrYg0KPiANCj4gVGhlcmUgYXJlIHNvbWUgcGxhY2VzIHNoYXJl
IHRoZSBzYW1lIGxvZ2ljLCBmYWN0b3IgYSBjb21tb24NCj4gaGVscGVyIGZvciBpdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEd1b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0K
PiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMgfCAzMSArKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
cXBfcnguYw0KPiBpbmRleCAzM2UwZmRiMzYyZmYuLmFhN2I2ODA0NTJmYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IEBAIC04ODEsNiArODgxLDEzIEBAIGlu
dCBzaXdfcHJvY19ycmVzcChzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4gIAlyZXR1cm4gcnY7DQo+ICB9
DQo+IA0KPiArc3RhdGljIHZvaWQgc2l3X3NyeF91cGRhdGVfc2tiKHN0cnVjdCBzaXdfcnhfc3Ry
ZWFtICpzcngsIHUxNiBsZW5ndGgpDQo+ICt7DQo+ICsJc3J4LT5za2Jfb2Zmc2V0ICs9IGxlbmd0
aDsNCj4gKwlzcngtPnNrYl9uZXcgLT0gbGVuZ3RoOw0KPiArCXNyeC0+c2tiX2NvcGllZCArPSBs
ZW5ndGg7DQo+ICt9DQo+ICsNCg0KYmV0dGVyIGNhbGwgaXQgc2l3X3VwZGF0ZV9za2JfcmN2ZCgp
Pw0KV2UgYXJlIG5vdCB1cGRhdGluZyB0aGUgc2tiIGhlcmUsIGJ1dCBvdXIgc3RhdGUNCnJlZmVy
ZW5jaW5nIGFuIHNrYi4NCg0KPiAgaW50IHNpd19wcm9jX3Rlcm1pbmF0ZShzdHJ1Y3Qgc2l3X3Fw
ICpxcCkNCj4gIHsNCj4gIAlzdHJ1Y3Qgc2l3X3J4X3N0cmVhbSAqc3J4ID0gJnFwLT5yeF9zdHJl
YW07DQo+IEBAIC05MjUsOSArOTMyLDcgQEAgaW50IHNpd19wcm9jX3Rlcm1pbmF0ZShzdHJ1Y3Qg
c2l3X3FwICpxcCkNCj4gIAkJZ290byBvdXQ7DQo+IA0KPiAgCWluZm9wICs9IHRvX2NvcHk7DQo+
IC0Jc3J4LT5za2Jfb2Zmc2V0ICs9IHRvX2NvcHk7DQo+IC0Jc3J4LT5za2JfbmV3IC09IHRvX2Nv
cHk7DQo+IC0Jc3J4LT5za2JfY29waWVkICs9IHRvX2NvcHk7DQo+ICsJc2l3X3NyeF91cGRhdGVf
c2tiKHNyeCwgdG9fY29weSk7DQo+ICAJc3J4LT5mcGR1X3BhcnRfcmN2ZCArPSB0b19jb3B5Ow0K
PiAgCXNyeC0+ZnBkdV9wYXJ0X3JlbSAtPSB0b19jb3B5Ow0KPiANCj4gQEAgLTk0OSw5ICs5NTQs
NyBAQCBpbnQgc2l3X3Byb2NfdGVybWluYXRlKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCQkJICAg
dGVybS0+ZmxhZ19tID8gInZhbGlkIiA6ICJpbnZhbGlkIik7DQo+ICAJfQ0KPiAgb3V0Og0KPiAt
CXNyeC0+c2tiX25ldyAtPSB0b19jb3B5Ow0KPiAtCXNyeC0+c2tiX29mZnNldCArPSB0b19jb3B5
Ow0KPiAtCXNyeC0+c2tiX2NvcGllZCArPSB0b19jb3B5Ow0KPiArCXNpd19zcnhfdXBkYXRlX3Nr
YihzcngsIHRvX2NvcHkpOw0KPiAgCXNyeC0+ZnBkdV9wYXJ0X3JjdmQgKz0gdG9fY29weTsNCj4g
IAlzcngtPmZwZHVfcGFydF9yZW0gLT0gdG9fY29weTsNCj4gDQo+IEBAIC05NzAsOSArOTczLDcg
QEAgc3RhdGljIGludCBzaXdfZ2V0X3RyYWlsZXIoc3RydWN0IHNpd19xcCAqcXAsIHN0cnVjdA0K
PiBzaXdfcnhfc3RyZWFtICpzcngpDQo+IA0KPiAgCXNrYl9jb3B5X2JpdHMoc2tiLCBzcngtPnNr
Yl9vZmZzZXQsIHRidWYsIGF2YWlsKTsNCj4gDQo+IC0Jc3J4LT5za2JfbmV3IC09IGF2YWlsOw0K
PiAtCXNyeC0+c2tiX29mZnNldCArPSBhdmFpbDsNCj4gLQlzcngtPnNrYl9jb3BpZWQgKz0gYXZh
aWw7DQo+ICsJc2l3X3NyeF91cGRhdGVfc2tiKHNyeCwgYXZhaWwpOw0KPiAgCXNyeC0+ZnBkdV9w
YXJ0X3JlbSAtPSBhdmFpbDsNCj4gDQo+ICAJaWYgKHNyeC0+ZnBkdV9wYXJ0X3JlbSkNCj4gQEAg
LTEwMjMsMTIgKzEwMjQsOCBAQCBzdGF0aWMgaW50IHNpd19nZXRfaGRyKHN0cnVjdCBzaXdfcnhf
c3RyZWFtICpzcngpDQo+ICAJCXNrYl9jb3B5X2JpdHMoc2tiLCBzcngtPnNrYl9vZmZzZXQsDQo+
ICAJCQkgICAgICAoY2hhciAqKWNfaGRyICsgc3J4LT5mcGR1X3BhcnRfcmN2ZCwgYnl0ZXMpOw0K
PiANCj4gKwkJc2l3X3NyeF91cGRhdGVfc2tiKHNyeCwgYnl0ZXMpOw0KPiAgCQlzcngtPmZwZHVf
cGFydF9yY3ZkICs9IGJ5dGVzOw0KPiAtDQo+IC0JCXNyeC0+c2tiX25ldyAtPSBieXRlczsNCj4g
LQkJc3J4LT5za2Jfb2Zmc2V0ICs9IGJ5dGVzOw0KPiAtCQlzcngtPnNrYl9jb3BpZWQgKz0gYnl0
ZXM7DQo+IC0NCj4gIAkJaWYgKHNyeC0+ZnBkdV9wYXJ0X3JjdmQgPCBNSU5fRERQX0hEUikNCj4g
IAkJCXJldHVybiAtRUFHQUlOOw0KPiANCj4gQEAgLTEwOTEsMTIgKzEwODgsOCBAQCBzdGF0aWMg
aW50IHNpd19nZXRfaGRyKHN0cnVjdCBzaXdfcnhfc3RyZWFtICpzcngpDQo+ICAJCXNrYl9jb3B5
X2JpdHMoc2tiLCBzcngtPnNrYl9vZmZzZXQsDQo+ICAJCQkgICAgICAoY2hhciAqKWNfaGRyICsg
c3J4LT5mcGR1X3BhcnRfcmN2ZCwgYnl0ZXMpOw0KPiANCj4gKwkJc2l3X3NyeF91cGRhdGVfc2ti
KHNyeCwgYnl0ZXMpOw0KPiAgCQlzcngtPmZwZHVfcGFydF9yY3ZkICs9IGJ5dGVzOw0KPiAtDQo+
IC0JCXNyeC0+c2tiX25ldyAtPSBieXRlczsNCj4gLQkJc3J4LT5za2Jfb2Zmc2V0ICs9IGJ5dGVz
Ow0KPiAtCQlzcngtPnNrYl9jb3BpZWQgKz0gYnl0ZXM7DQo+IC0NCj4gIAkJaWYgKHNyeC0+ZnBk
dV9wYXJ0X3JjdmQgPCBoZHJsZW4pDQo+ICAJCQlyZXR1cm4gLUVBR0FJTjsNCj4gIAl9DQo+IC0t
DQo+IDIuMzUuMw0KDQo=
