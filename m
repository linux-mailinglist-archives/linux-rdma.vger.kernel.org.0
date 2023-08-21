Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7D782863
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHUL5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 07:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHUL5e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 07:57:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E590
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 04:57:29 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LBbc0J024483;
        Mon, 21 Aug 2023 11:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ymDHdw8RDCpR3FjBJiU9d/++6DpMQjDX+49mX8bmwz8=;
 b=CQrv740M7FcacPK9QvAtQ2uTls22RbWipbuiDgxcXEiWusv4FJ4PWOhmcTmO2stj6WfJ
 +HwaOG0eIJAerNoMlz1QzH844n0EsFgFpwx/GVqzR8dynHPjDSi2QfvVDNyr2DDaQW0P
 /dtLjjwBf1xE4rE94vk3zAlfUryQ843m3uKFRGp44n9oWDOBJ0XAnPlVcqqq0gOo176W
 foDtKw6grN8euqj8J/7UI47k10ADPYbZxXIUr65J0qG173EDRYpmC8XnftQbjJrdAHZ/
 9tWKvWHUCKpzSWh43NjQwKlXHXH/Ohu30tzjWZFrR1T7Q1M6XXQQoS5FMQz0askyTWK1 9g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm6pbs6f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 11:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPRBCjMOBFhhqamqOLSGgj/MeuAIwrXfKQxQ5F1re1ifWZWTNiur2JdYvVCHXT5L6KtDqHXMICb5A1opTEMOEJax2XtDWifrQAp8ktUkGLSSU851/G9/cR/HpQRODbVHt8LrBgILQoy5aK5eO1ir2ItrnSms60SPUAgdiZYjU2Sl7jDZTTuFQoUHuJ27kkJOJUe5trFdzrgrw4VPzkJ6eiuNef0CTqNT8i37sQEJ5AMDBgbxv5VQOKDXFaVNKdYmUapw/VjarNs6kyFSO9XrxQT6NV0QdMaGR9GcYivCOKvM/dNqj4hyEraIsPYN9Lyj7FitR58BrqaK0U9D+WJY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymDHdw8RDCpR3FjBJiU9d/++6DpMQjDX+49mX8bmwz8=;
 b=QNiIOADQON+kCy5O8mtMfrh8ZRm1vy9Fxi680uuPWMgtC0WpAe/L8H1RAfIF+5TTcK/Q0w3iPEEJ3JKpAH6vnrvW5l73tJz+f723vIkG+lnVn0Wmgwp9mk941CtzYJu0+3lpb/o4yTFUTPnT2cnlGethhtx9+OMQqvmfTDAUCgCe/pIpo3JSxGeGZbbX6owPiSW5R6BP2ehVV5k/z7atwMHY/cAv67MMNo2lo5QUg7cg4y5qsGATyDmrW3rXzK2jK4vfULH8Pu6nNn09CaPUNKTPimykGEM71c5sr87qzmo2m2Y+wOoROqI0EYFrqEjw4c+TBUEhyyFWAML0yC/Eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DS0PR15MB6301.namprd15.prod.outlook.com (2603:10b6:8:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:57:14 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:57:14 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 2/3] RDMA/siw: Correct wrong debug message
Thread-Topic: [PATCH V2 2/3] RDMA/siw: Correct wrong debug message
Thread-Index: AQHZ1CagdOWwMNAEF0KZfvq6fEG5lQ==
Date:   Mon, 21 Aug 2023 11:57:14 +0000
Message-ID: <SN7PR15MB5755C90263B5FABD4098A91F991EA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230821084743.6489-1-guoqing.jiang@linux.dev>
 <20230821084743.6489-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230821084743.6489-3-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DS0PR15MB6301:EE_
x-ms-office365-filtering-correlation-id: a593e4cb-d64b-4b78-766f-08dba23dc28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWzUGLUhhvILsSAicCkVjhJ7zjyHYPO3RiuBPheg7ULvNF8ZI13kd1qxO8Nxkh6Obvq/1onNTAt+ydOpiepOce/STkd/l2sR2NdxAk6QVCEi8YMPV2p2VcwAOkIZfEUNj7Me9nMzXjFO0hjShwukD1031eJSy8ZexBomlCDRDe6xob4Sjdnh4zY9oU/YlTJs60a8zF7KE4vz5IkhjmVkJcNQvVf7llu7yhyb7eULVmLmbf49bO5ncpK7UGj23ZctBHo+XW8iJwxUhZt0zvfT6E92xIKqCb53RGLZlfTm05xSmcYuab83PqCqfNkxTqtlN1WAz9qteGmFvloIV3q+eqoNzRxNVhcpWxKX+6MSeR243YkVBFbCldXUa7NZE0/u60gHv+mSdYUbTdHZp5/OiBpMX383QYcOKDPqq6uEc+EiJVhGV9JWnvnas0+iLv98AniaDBAz8JWOUeW+HrooqAVf4WIMvCkaLP0Wap6AVVQEWLKenwOt1215B61OqVCCHNIbz6oGzszXUVpXpixRwdbpY1VB44kM1lTQbcCjU+6DjQj1Qq+PhJ8bChFscO8oMnYH7QNSZrCTyj8MCctKZieHNXeGRNSxHdX4m5VVXmq+46x8ovT9WulZq6ILBC4d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(76116006)(66556008)(66946007)(316002)(9686003)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(7696005)(38100700002)(53546011)(6506007)(15650500001)(2906002)(83380400001)(86362001)(38070700005)(5660300002)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJBNkpVbkZZYUZMcUZZYk8rRjRzQ1NqcGpxRGR4ejcyNWRidWpNZW5VYVJl?=
 =?utf-8?B?clpWa0Z4TUk5MzE3aHZmLzFYYnFSYjQ4WVhuaHVVVmRjTS8vbzl1OFRaaHBo?=
 =?utf-8?B?RkFLb1RvVG5FTCtZK29OSmt0U0RoT1F4SGVxNDNEZTZBNFNCWGZqSlNZbjZC?=
 =?utf-8?B?SW9waStWYTVyNHlmZVR1NjJBeGtIbS9RbXZaMVRPbnB0azRMZ1NoTzE5WlF5?=
 =?utf-8?B?RVlKcElnSDRUQ0Z2Y0lnOHk0d29GcUFIYXpVamxaZjluY1hoZmZZdzlUWlZU?=
 =?utf-8?B?Qnk1K2JDMERJVmN6Q0NvUGY1RHZVSktIOUg0czIxcGF2L0Q5ejlWMHlmMllh?=
 =?utf-8?B?a1BJa3oxSTlkWFZQNTUzTmRrbTNsUFVEdm5maVBHRWxMaHJmWExFbFVwQ3pB?=
 =?utf-8?B?dHZUOXY1RDd6bzZoSzRzdEZOTHhuRzN2M0tmOWJiUkwvRndTTWRhaU84UTQ2?=
 =?utf-8?B?b0RZTmNKUlJkYlpHTHR1MkgyYk1nTmUzV0pnUVpuSG9ycTN1Q3Y5NkYwWFdX?=
 =?utf-8?B?OS80b0Z3VlAwT2N0VHpDYkRhc01OZWZZZUxCU2FjUHdVQ1NZdUQrd091eDFq?=
 =?utf-8?B?RnpJbktzMHNUSXJSbFAzcEtNRDU1MUVEblUvdVBKczVJR0ZzTUN6Ymo1ZXlD?=
 =?utf-8?B?clNERU1hQWRsakJKVXRjdVB6RUpuL0pBSFJvMmdHS1k3VGdTNGRSOGVTM1hO?=
 =?utf-8?B?Z2NYYnJMQWZKNStBbkJmb3ZCZjc5L1cvNmRTRzk0cXB5NUprVVF0Rm5EZ2V2?=
 =?utf-8?B?cHcvaG53bE5GcFNkMVNoVldoK21sNWhMamxGbXpJbk5sRnppc2llQmhucmhm?=
 =?utf-8?B?eWpLZlF1MmRZWTM5TVNIMlR5dWVpc2Zvek1vc3pTRzBVRzBNQ0tkUGRNeU5B?=
 =?utf-8?B?UENxaE5RajVxTk5qRjRkc1dEN1pJUCs0ZDJOM3Z6QU1PRjA1Mi8zcWlVRGFQ?=
 =?utf-8?B?ckVGN1pvMVYxYW1RSldpREUvUlhCUGZsWlp4VS9WcGdjQmpLb1VXdHpQcHc5?=
 =?utf-8?B?QU5wd0pRTW9wNENsZkRiL0M4eXg2cU1RZnVTaS8rWVQvbm1nNXpLK0RJVFZ0?=
 =?utf-8?B?YVg3K20xUEljSE1Xc1dLZEZaWEFNOTBkN3RQd3B2TkdsbDIyT05uM0xUVmpk?=
 =?utf-8?B?M20rdnM1SVJHMXFMZlFmWEVWcVBSQksvQkhIS0Q4UFVqYmM5bGI0ZXd0NTMy?=
 =?utf-8?B?aExUVGl6bitJeHFWSW54ZUtIU3VRNndqL3ozUTZ2Si9rc3RpRHdGQ0FQSGp4?=
 =?utf-8?B?MjNCQUpCalYzM3lTSG1VeEZLTTNBRDg3VnBudnhHWVQwT1VER3Z5NE5SczNE?=
 =?utf-8?B?bEs1TVZibStBa0dURXJsYy9ScW9OWkFmOHhoUFFMTVZDMDJTS0cvSkxrcDZC?=
 =?utf-8?B?YlB4YnB5eHhpRDlIUVpPTjVYR00raS8rS2JwZDZMcGJ5cllMQ0diekFLZ2dh?=
 =?utf-8?B?S0Zuam5OZXRjNGxzYlhLYXJ6c0hJK2VxamJXRUdvOExRSXJNeWNRL2NNL3VV?=
 =?utf-8?B?MFFMRXRTMHhaWmlPNHg5Wkw1U2FEeFpBNFk1WXNFWHMvWW1ISkl3SFpkM0Vp?=
 =?utf-8?B?dzVsNlRST2ZJS2pzT05XVTQ2eTdVb3pRcjQvQ21ManJOaVduMVpTamFZSHI2?=
 =?utf-8?B?cTV4N1hnQlpJbVZhYVo1Z1NmcUdyZk5IUmY1cWdRZndKaTNEenA1aTZoNVV1?=
 =?utf-8?B?dm5SUDBaQStOUHRyYjZLT3JWVFl1OW85Tmt0cWRMY3hSY05aWjNIaTF2Rk44?=
 =?utf-8?B?amlPOWs5cU05YkZKcUpDdUZ2bWNTVUE1bDVRbG1wendlOUpyNnI4dG9EUGw4?=
 =?utf-8?B?YjdZSWFyYmJLazBDeUtFdDJVY2FsTTU5WVNwaDYrcDl6SitTY01IOXdkTFBJ?=
 =?utf-8?B?WmJnclNCejQ1SFpXdzhXZmM4WWtweEpRYTFaU3lSUzc5U04vV0R3MXBXWkd4?=
 =?utf-8?B?a1FGWUhJSTViVkVsbjYySFFuYytLWkhKR0lzN0RQR0g3RGorbUJHN2hEazR4?=
 =?utf-8?B?bDVYcnRLb1N6dERYekZXMXZudmd3VmM5aTdjdkZDOU05WFBRUVN5cUVxYTAz?=
 =?utf-8?B?a29kR1JZWDBobkdDTFl4Q0hUYjNMQ3FKY1pveFJLcUc1QW1BZGNwZVg3MUh4?=
 =?utf-8?B?b3NTdGw3R2Z0VU1YTHJOTW94Z1FrTjRzSkkyWlVzQmhXZTNIL2lCQnkwTDg1?=
 =?utf-8?Q?LuuWZ50RclMB6cnq+grcsao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a593e4cb-d64b-4b78-766f-08dba23dc28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:57:14.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFcxhEjOHpvEPMyD30lSSAWfPFaP+6gzELSK6nfVJIc+uvlAc/oNqfifiYLsBY2T+DYHoeSKIRRLa8r1AR7RiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6301
X-Proofpoint-ORIG-GUID: v2EJ_I-Y1OstoPOSJCSLYKMh9_dSEaLy
X-Proofpoint-GUID: v2EJ_I-Y1OstoPOSJCSLYKMh9_dSEaLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=832 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgMjEgQXVndXN0IDIwMjMg
MTA6NDgNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdnQHpp
ZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIFYyIDIvM10gUkRNQS9zaXc6IENvcnJlY3Qg
d3JvbmcgZGVidWcgbWVzc2FnZQ0KPiANCj4gV2UgbmVlZCB0byBwcmludCBudW1fc2xlIGZpcnN0
IHRoZW4gcGJsLT5tYXhfYnVmIHBlciB0aGUgY29uZGl0aW9uLg0KPiBBbHNvIHJlcGxhY2UgbWVt
LT5wYmwgd2l0aCBwYmwgd2hpbGUgYXQgaXQuDQo+IA0KPiBGaXhlczogMzAzYWUxY2RmZGY3ICgi
cmRtYS9zaXc6IGFwcGxpY2F0aW9uIGludGVyZmFjZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEd1b3Fp
bmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfdmVyYnMuYw0KPiBpbmRleCAzOThlYzEzZGI2MjQuLjQ4MzI3MjNkYzI0NCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IEBAIC0xNDk0LDcgKzE0OTQs
NyBAQCBpbnQgc2l3X21hcF9tcl9zZyhzdHJ1Y3QgaWJfbXIgKmJhc2VfbXIsIHN0cnVjdA0KPiBz
Y2F0dGVybGlzdCAqc2wsIGludCBudW1fc2xlLA0KPiANCj4gIAlpZiAocGJsLT5tYXhfYnVmIDwg
bnVtX3NsZSkgew0KPiAgCQlzaXdfZGJnX21lbShtZW0sICJ0b28gbWFueSBTR0UnczogJWQgPiAl
ZFxuIiwNCj4gLQkJCSAgICBtZW0tPnBibC0+bWF4X2J1ZiwgbnVtX3NsZSk7DQo+ICsJCQkgICAg
bnVtX3NsZSwgcGJsLT5tYXhfYnVmKTsNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAJfQ0KPiAg
CWZvcl9lYWNoX3NnKHNsLCBzbHAsIG51bV9zbGUsIGkpIHsNCj4gLS0NCj4gMi4zNS4zDQptYWtl
cyBzZW5zZSwgdGhhbmsgeW91IQ0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVy
aWNoLmlibS5jb20+DQo=
