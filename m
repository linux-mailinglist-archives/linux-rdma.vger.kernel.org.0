Return-Path: <linux-rdma+bounces-177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02500800EBF
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D34C1F20F83
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D044AF9B;
	Fri,  1 Dec 2023 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JSAhCXg4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0F19E
	for <linux-rdma@vger.kernel.org>; Fri,  1 Dec 2023 07:43:22 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1EvRtK013628;
	Fri, 1 Dec 2023 15:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZZ6bUBW+9g87JNBD2OhfdnXroFvdLtD8kj4h8UMitrI=;
 b=JSAhCXg4FP1c2kKxti1X2Ec8DrbHAe+9dn8O5/fy/6qBUjW0+T6ZjmZ2lwA7xC4jdnsR
 cmvufBrSyyLD4Re7JeEAqrPoX9ALt7Niq7oTQ0drq8HwtKQemitWy2y6xG40ZakStiXe
 44wcS1L34jj+mi9fO7Ldsa2r1QH7Y4NHst6amB+/nNPo1fjN7oTzfL1Zhh7/4lJ9z91+
 v5rJ2y0SGSP33LehClY68D9KeTXamWptjCtQLBKq0JfTznhNGJOsABZUXIY6qWEzuwWR
 035rKz+BiYkWTyhbe34o/tZeGcH408bv07fGbafyiLHoQV49txlFPjD19jcqPZIXfOpB Gw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqhpx9brx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 15:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WydRXzC3g7k/6w8MuPCyq0+I+HX/KD9PbsUrr1J9D+asrD8oFUfTIFgRSW9YkL4vHDCpYWVfW3ufCT5pxnUIrwEx/TZqyP5frWKAWzgHE6ACmQAx1dIiNgrq+wIaTOhEgZ8cdb93Laf0kAjXYQFucO4mHB5NwyUwvM1zAHk0zjN9gG8P1/n9mOgUiSJoBa1tNzq1PZwlPDkZbz+lpa+MtEUbq+rKNCPSzW5w1jhafMAclYrFLJy+29If6Mux1/qWVcAtxA9OQiy035CxaC59Y5Opw1wJffwNxJToSAZ/XMwijfRrTfT3DhF+N05W2a1l2typONXhbZ0IplVOIHq+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ6bUBW+9g87JNBD2OhfdnXroFvdLtD8kj4h8UMitrI=;
 b=WaMfyy2RV0x4GySuB/IrfTsrtMfyKsUM5OzslDG+0z0QHdtYeUZNdrOSMRHoi6bgFBs+xLZ0KFBrJuIDkD2XVgKra4x9TNXqL06JEHM6dVUBvYdktO9Iw7tZfaD7WdKt1mmWzCpjqrEe02v2677Z9OQlsDmt3cUl4hecYPqsZii759OfSuK/xIh8LFCA4QsPz4lr76F7/Vo6UpRsindFcGBrYUHIGU0T4ibXU4XAUPKRP4dnInKjtyZM3/u3rgKL/P4GFDciC1v2xpsoBkKwybmpmqIclWVORYI5x+xfIgGGJobz1ezPwdIKVZtQ4R/ZgQJeVllMyIiK5fN+3W6BCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by CH3PR15MB5587.namprd15.prod.outlook.com (2603:10b6:610:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Fri, 1 Dec
 2023 15:43:15 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 15:43:15 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/4] RDMA/siw: Move tx_cpu ahead
Thread-Topic: [PATCH 1/4] RDMA/siw: Move tx_cpu ahead
Thread-Index: AQHaJG0ZnUuVbgByg0iyxY86RIyYkA==
Date: Fri, 1 Dec 2023 15:43:15 +0000
Message-ID: 
 <BY5PR15MB3602E62647EEB08CB23627979981A@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-2-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-2-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|CH3PR15MB5587:EE_
x-ms-office365-filtering-correlation-id: 37c266a1-7a7c-4180-e2c1-08dbf2843b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qBCM9BGOm5krWuYVzS467wSKtcIgTKpQ7qnrIISzyQSqdSpNa0lfK4g2iFqBs8rMeCL2k5osmB9437Qmi7A/6cA76k6+VCQTkntG6GT2Q2upvjHNJ6c4X6TZ8KWlvoJUuja0rzoPDtS/nZHrhuUGBFyeZ+DFmpXqXcxF/8MUWf+6Cx/5isBv1gQP6wRR13hhh1AvEnSypnGt4gzzmHLQ5XVLFHJbEZ/K/U4azxFhUCE4jFZv0nW0UHVquO+3b3KY8NptHgKA3Qk35BK/WHZO7LmFSCwFZzY4vwLvLFJyTwTLB0OrzMESq/OHp8NgTndL8Bi4cPZapN1qQUuVNB8tr17axRz9HjpwGO07WYG+z+1cdJhJ37C8FaWuqP9w1QRSjxYm1eRdYpNRZZv2q7AXV370zTkyEKjW8aBCdw7Qwvmek7ZDypvwWL5FFAV03KcPanAr33Z3SbyZbuYLQaq7lpsfPf3VOUDwEzmS3VLzRlH1YNEOsJuNP/g4ix6r0QREHdvszuECSIirE17YcA+Ix556vaU7hu6SlMETxXot/vLtnFv6KEbFk60fF8RG0tO9GclMm4wHG3ep7yKFyHt0yz+CilBO/fhp3zMcqsGL1XAWsNvnYSFNnkZcEmLjeeE4EUp7UPQZuNG/5qAxYul7jiqg9L1TvWR1sSSDhcJKb8M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(122000001)(5660300002)(38100700002)(2906002)(38070700009)(33656002)(41300700001)(86362001)(8676002)(478600001)(4326008)(8936002)(9686003)(55016003)(110136005)(66556008)(64756008)(66446008)(83380400001)(66476007)(316002)(66946007)(7696005)(76116006)(53546011)(6506007)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Nm9MaWNYZ3ZScXJLNm43RUNIMGRtNUFMUXp2dGlVR2x3VFFNWjY5K0hLNHhj?=
 =?utf-8?B?anlOTFhJY3hnYXcrOUNPeEZ4dnJXcFp1b0FMcGlIVyt4UUFDS2Q1TStsbGlk?=
 =?utf-8?B?U1JkN0ErRngvc0NMTDFNSjg1cm1LcllYbTNWZndaaGJMRmZucDBXK3RFSlVO?=
 =?utf-8?B?UTlyVnhsMFM3bFlXc0pRYlU5OWF4SUVuc0dVV0RlL280Z0d3ZmVDblJUMHRZ?=
 =?utf-8?B?U0hFVDFVby9XV0tBMmpnTjZZNTNOM2lIdEhuWk5Fd2c0bEpSUlA3NjFOSk96?=
 =?utf-8?B?WFJuTUVqa3JIdDZkNk8yYjFrQ29sWXd1MTQzZHNGeDFpUFR5Wk5pWThscXdP?=
 =?utf-8?B?NHJmL0ZtZHpQSVBuWmZIS2RiZ0pVN05ubDJvYjFLQWZPN2xTakwxRVlKLzhk?=
 =?utf-8?B?UHBRN2dxVGJnMGlKMXZXZi9FbTNPalQvN0lPNDFKdjMzcVUzbWJwK3JDbTNO?=
 =?utf-8?B?bG5zbW5kZ0IyUXhKVHdtTml1elBFNDlsQ0lYeXFCWFErRlhyT2VuUEFsWjlj?=
 =?utf-8?B?ZnA2VDlobXlXSFl5WGM5bm1hOFd0ZjFLMDJ6ZEJUalBkalJweTd2SDk5OWZG?=
 =?utf-8?B?UnlQMnE2QkRTVE5VY2tNZy9oWGN4c1R0TmhBbnF4d2kxZEhsdWFWbnpXakFs?=
 =?utf-8?B?bnJCbXR5a0xvSjFGY2J5ZFlCN3hKNUpyUG1kZXB1Z2ZaZEcrdy8yNzIyMmJo?=
 =?utf-8?B?R3Nmbk5pSEZ3SzVubEtGeTZQK0ZwY2pUajRFSThZVDQxQUF3UHFaQ1l6U29n?=
 =?utf-8?B?aXN1WGxKNmxnTWRoZlNyTFZzbkhIT0hnM3hkT0p4R2puZnhtMVhMRklSbi9y?=
 =?utf-8?B?c2FXT1RXMGoxWkVLU1Uyd2R6c0d5UElyUGxqY3doWWVVcTVHWHVrUm5FMHZo?=
 =?utf-8?B?ZzBwWS9vZU4rMGVQRENZaHpQY3hsRzkwZ3Mzb0Z5V3ZlRGhjYzJTaDRKYytG?=
 =?utf-8?B?TWdDbFQvbFovQ3RwS1lFbklLSmtPZ25vSGxmR1cvam1RQmIraXV2T3NYNXU5?=
 =?utf-8?B?M3Y5dXBFNEdjdE9QbGpRSU5ONURmWGN1SnB4UzVlamVpamZXUVhIckVYS2hR?=
 =?utf-8?B?Smg3WGZCL2x0YUZIL2w5Zy8ydEswQUhrRmlhQlF0M3lHWVpRRkY5UXlJUzNU?=
 =?utf-8?B?TGpvQVdSaUlGSWMrNmkwNDRXMzJlQytidmRkUHNjd25GTGRaWUlGL3hlV1lF?=
 =?utf-8?B?RSsrSGhaRkJ6MFc2TFpvWHBoZkVGbWFXOXpYY2pKQ3NMcEduY0JvTmEzNFVG?=
 =?utf-8?B?Nm9Wbjlmc0FKeWQ4dTZCQi9Xd2s1czc4TmdyeEFWR3NObC9kNUxVcjVmNGw1?=
 =?utf-8?B?TitYdDRVMnlRTEZoR1lDSHhHSllWRDN5M3E0eEpaeVpMVUIxc0RTaGowQ0NU?=
 =?utf-8?B?a2pqYnE5akVBcW5GM3p0eC9jM0VjY0tzVWNVeTA5aUZRN2U3U2pPYWZaMktj?=
 =?utf-8?B?Z3ViaXo3UzRIS2w3Ky9hVFltcTBXcXNEZTA1M1MzVURTUnNGTmNRakxnZmZG?=
 =?utf-8?B?NjJvcURZOWxUSm44YVNGL3ZIZkYzUVlkYnlsUmEwQjZaS0VSVGNiTGJvdkh3?=
 =?utf-8?B?QmhiSXF3RjdkeEtMRzM2dUZVN0ozaUdnK3BWb0hQNkNaakQ3N3hEd202RFk1?=
 =?utf-8?B?OTdldHlDMWlUS1gzNjdkM3UrUmJWcmd5Q0ltM3VEckc4eVp2N3JlK0lPSGRU?=
 =?utf-8?B?WEU5dURJSnpKS0FQSVZKbUpGQUVpa2dzUmdaRCs0YUtlV2srRVhJTGwwTzIw?=
 =?utf-8?B?YWdWclhpM3daS3h4N3FkOFl0NjJwekhWQitKaGhSdi9nRG9STWZnNm04VjRM?=
 =?utf-8?B?dTZGMzFRdUVRSUhzSHRRUjJmMUJ0UndZb2k3WEN3SDV4MDU3NkF5NjN3a1l1?=
 =?utf-8?B?YW5hS0dYWTVVS0ZSVmlDTFNUZDdaODE1K1R0RlByUjE1ZmdTK0dMeWRENTZh?=
 =?utf-8?B?WGl1WUNFRTB1dU9kNWRmWHN4bmZpM3FvT0pTMlNhM0EvZmdwU1dQLy8zMW0r?=
 =?utf-8?B?UWdNK3lqRG9sWW9TQWt1U05MQTF4YnU1aWpTMlAySDQ1bTVjRFNXanY2N3B6?=
 =?utf-8?B?YlRqeGtPMUNleWhBczg1RVIzU1p1TzdkM2E1UVJTQ2J0NnRwcEdaazFxaW5E?=
 =?utf-8?B?OW50S08zNHo2azJRekV1eVNCTlFTdlJzdG4vOTlFbS82NnhpWU8zVDR3Z0VO?=
 =?utf-8?Q?UFcfJs4OayADrDB3yJlUyBT/wLmsALxNYZcH59b6rUsg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c266a1-7a7c-4180-e2c1-08dbf2843b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 15:43:15.2366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4s6KMsttcD9StE71t6MTk1TG2afPvlnzz+XriQY38sN66PswaEO9fuC1vflpjN0ktoAjKUksXXJNci4KQ/DDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5587
X-Proofpoint-GUID: yFWnl57IEg2xaJecwhNqZJcUvgvkZEoT
X-Proofpoint-ORIG-GUID: yFWnl57IEg2xaJecwhNqZJcUvgvkZEoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_13,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=541 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010109

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjks
IDIwMjMgNDoyNCBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtl
cm5lbC5vcmc7IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIDEvNF0gUkRNQS9zaXc6IE1vdmUgdHhfY3B1IGFoZWFkDQo+IA0KPiBXZSBjYW4gcmVk
dWNlIG9uZSBjYWNoZWxpbmUgZm9yIHRoZSB1c2FnZSBvZiBzdHJ1Y3Qgc2l3X3FwLg0KPiANCj4g
QmVmb3JlLA0KPiANCj4gCS8qIHNpemU6IDE5MjgsIGNhY2hlbGluZXM6IDMxLCBtZW1iZXJzOiAz
OCAqLw0KPiAJLyogc3VtIG1lbWJlcnM6IDE5MjAsIGhvbGVzOiAyLCBzdW0gaG9sZXM6IDggKi8N
Cj4gCS8qIHBhZGRpbmdzOiA0LCBzdW0gcGFkZGluZ3M6IDEzICovDQo+IAkvKiBmb3JjZWQgYWxp
Z25tZW50czogMyAqLw0KPiANCj4gYWZ0ZXINCj4gDQo+IAkvKiBzaXplOiAxOTIwLCBjYWNoZWxp
bmVzOiAzMCwgbWVtYmVyczogMzggKi8NCj4gCS8qIHBhZGRpbmdzOiA0LCBzdW0gcGFkZGluZ3M6
IDEzICovDQo+IAkvKiBmb3JjZWQgYWxpZ25tZW50czogMyAqLw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
dy5oDQo+IGluZGV4IGIzNmQxZWMyNTMyNy4uZDE0YmI5NjVhZjc1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3LmgNCj4gQEAgLTQxNywxMCArNDE3LDEwIEBAIHN0cnVjdCBzaXdfaXdhcnBf
dHggew0KPiAgc3RydWN0IHNpd19xcCB7DQo+ICAJc3RydWN0IGliX3FwIGJhc2VfcXA7DQo+ICAJ
c3RydWN0IHNpd19kZXZpY2UgKnNkZXY7DQo+ICsJaW50IHR4X2NwdTsNCj4gIAlzdHJ1Y3Qga3Jl
ZiByZWY7DQo+ICAJc3RydWN0IGNvbXBsZXRpb24gcXBfZnJlZTsNCj4gIAlzdHJ1Y3QgbGlzdF9o
ZWFkIGRldnE7DQo+IC0JaW50IHR4X2NwdTsNCj4gIAlzdHJ1Y3Qgc2l3X3FwX2F0dHJzIGF0dHJz
Ow0KPiANCj4gIAlzdHJ1Y3Qgc2l3X2NlcCAqY2VwOw0KPiAtLQ0KPiAyLjM1LjMNCg0KTG9va3Mg
Z29vZC4NCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K

