Return-Path: <linux-rdma+bounces-174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10457FF918
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FBEB20E66
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3236D59153;
	Thu, 30 Nov 2023 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lbka2Rf0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B98131
	for <linux-rdma@vger.kernel.org>; Thu, 30 Nov 2023 10:10:21 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUHZwwU011931;
	Thu, 30 Nov 2023 18:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/C6gAfijYSgqLOcn6/iXOqs8OfEF+PYfTEFsNutPFZs=;
 b=lbka2Rf0Pf2cYmyUHc1aAxmdt/8UmOeU4ZC6lJJxmyMRFaEasQfmuOpso8fodD06PMJW
 l2NbBKDCjlnwDBG9kHooQEKkH5Shbzah65QwFm6RBR0MIMfJ1sb/krP7MJ2AmL6lmczj
 Z7IOqm738uAzje55P2UmD9/20xtWN0O/Zj1lSLzfrDTgYtoHAiFrStUdwPhzt4bZyyZO
 wjQ5DP97u1G2SjwUviXahonHxqT7jLEHpdusHyf2Wpl3RqNemvjFwE/aN9F4rK4W0O3n
 66vkI0ggM22Dh73r8E09CvhYURTDbhfbnnQMglNzdWDTdX5ZPWnzTnQGPg8PDF1nTxYQ kg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upxqu188u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 18:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcboWoBkzkWNg6YUp793qz3eqHbhd8fzP7dovC3Wee4JubJxzuI2yKeNMBAkQt3YB7oNP2FvSr7ScieNxFFsLB4+Mz9Z2xtJiOJ6nVi31wv9JTqSsD4VXJHZJPET2oDJRsdwO9ocQdtIqHj+jpsr/t4V3VpaMQUpqL7tF9x6DZZJtvc6Josz/NCoGdvoRk3xwQtcQlCioTMvTUEsZ9uzDm/Ik6mSAz7oq61bHO9FAzRwtxBAxn+DciYceMk9b6REN8UpCeZVHJbJqViD4ZmLs4RO2Ep8n3H0ygLtLzzqjHRQoxcyig5PK0d2eI9u+WZ1qTzazJ9qOP5EZbDmTvKwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C6gAfijYSgqLOcn6/iXOqs8OfEF+PYfTEFsNutPFZs=;
 b=Fk/flzN5qX6txLZv5RvSTC3kfBsy0dJe6GBb/YrwChAk+6nyy5L3F+IVSCH+Y4Bw7beobaK26zuhkwrs1jLszF8nsUAoUWz6p8iEvoLtoS5Pay2Y0qeDVV7DAOBGI2Igx0phXeT6oFuM7P32CI36nR1mOKksJRM4XNmN5uhQX/rNeL6x6dz/3lmoABRmhgm9YFOBj6qp+MK00v0i9bUz5C64slkExb32hEIiM8Mcu3VFeinHdACneVPiVepYg2i4kAhlxgPEt/MHQ6/NG/3bRZ541e5jciJ/hpI9ititM+WsSFRhAZVdgxMU/F4zrWcK8T+n/hiKtbk26X/b/GlKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by CO6PR15MB4196.namprd15.prod.outlook.com (2603:10b6:5:350::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 18:09:22 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7068.008; Thu, 30 Nov 2023
 18:09:22 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 3/4] RDMA/siw: Set qp_state in siw_query_qp
Thread-Topic: [PATCH 3/4] RDMA/siw: Set qp_state in siw_query_qp
Thread-Index: AQHaI7hYfzTy9lpy8U2dCdzMzcWiBA==
Date: Thu, 30 Nov 2023 18:09:22 +0000
Message-ID: 
 <BY5PR15MB3602998251455B5F504978F39982A@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-4-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-4-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|CO6PR15MB4196:EE_
x-ms-office365-filtering-correlation-id: 2b2982d6-7796-47df-33cb-08dbf1cf7ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w5seYxzzM3Ad91L1wvbXI6gi8jzVAm61fKWQ88Wnns2ixrY7Cm73PYJbDfjbLRa/tJeLbn7/bWno3vSSzSOSKhCzQupujVo7u2iAKGH6KTvxtPJItkkOvpZUbV00khJYZXU7jqX0rBodaYSO7JeT2Bb1tfReWhY7tpKyjO6Q8cZEgjFlAyLwlt9lwIJQLy76jqbzeX9bCSVfyDlfjijzNB6DS4jVe8DoAzhCkuhYfRmt8YQT9aRm9UzTfi2jdt+Q71MfNKAVAesdXBimPY/B1Ke7EWWvvKw9ukEIoNVx/HPqEZEanh06Y4CAeKn6grI6RoVtMB1DFLgyfywqMfRQr1rduovogP/CTbTILJ8pLI3ZOgxb2MA9rQDiiJonTEhg50xTb6kakZDmrnBtHundHNQHrYcnxqnw4/3RFZSm3FaZcTQNATnOac3UZPi/y+IxOSn4QzH2rR1RJwd1mY5eITasKr/NOhSrJwVf6B4gtYlDgl38AeFclt0R97gb4zPINMQokSUoGQTm7SZ1wp2t6LOZZfi20Z7nBFTN+BYquXMgKFV951HSQfz3/2pAxE9iK735GC9whQoyqAU10rU1WwC2ZKGmqtFzCoyQ8eSBnD8UC0mj9m39k2wxqRNSnBM0s8dD7JL8nqlBLVnkBm7tdgtEqt8hBt3q66/OgDKwMGQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(55016003)(38100700002)(83380400001)(52536014)(2906002)(110136005)(5660300002)(8936002)(4326008)(8676002)(66446008)(64756008)(316002)(122000001)(66946007)(66476007)(76116006)(86362001)(66556008)(41300700001)(478600001)(33656002)(7696005)(71200400001)(53546011)(6506007)(9686003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MndGakd4QTdxYnJ3cCsvNzBNWWllN2J3TVpDSUhZQnQ2LzIydkd1cG1SQnEx?=
 =?utf-8?B?SDZiMDlQSnN3a1NXTHEwV1V3NDNHU2RtYUdlU3RNMVRzK3RjVkV6V2FXbXBx?=
 =?utf-8?B?TmJ1b3FMcWpPbFRyYmNGY01MbHgzWHR4eEt4UUJHeE5EbURMM0wrSklUajNL?=
 =?utf-8?B?c2tzTlY3eFRTRVpzNEo4TW9RRHFMc24vM1AyTGdOR3VHdnM5bGI2czdreFM3?=
 =?utf-8?B?MzlidStndm83OFJCR29JdzkrcWhnRHR6V3Rrc2wyTDdxUmxidEVlalR6alo1?=
 =?utf-8?B?cnRHb0lOaEN0Y1QzSVJyazc5YzhLZ2t0UzBjWWptQlc2dStaNmlBUDc5N29r?=
 =?utf-8?B?bUxSeTVjVHdDTDM2Q1hCbkRGZjRKd1ZwZXlHc2pNOGcwcG8xTk05dTVLbW5P?=
 =?utf-8?B?K1RGeWk3MUczL1ZKOHMwYjlkOWtwcXRvRGI1Z3hQVlNJcnpSSU8xV3dNbE8v?=
 =?utf-8?B?R2oxdmM3YXR0a0gvYlc3L2s1cWhVZ0JsTGFyZTljU2lYa3dEY3lpNXA4bzFa?=
 =?utf-8?B?eEVxVHp6c0JvekpuRkRvWGxHY3VYcVhvLzZ4ekJGRU5JRk5ndXNvaDI5UnZO?=
 =?utf-8?B?REtld0R4UG5QSEYrZHVGWlY5VFhvQitYb0hFRWovcmo0QkFDbUg2b3pPQUkz?=
 =?utf-8?B?cGV1NFUvaXVFMW40emJtSnNmYk11dFY1VTZ6NWJMVThkdW5xNEgwR1lUTU5t?=
 =?utf-8?B?Q2xQOVBiL3lZZkdDUWIxcVpjNHpDYXQ2NTZ4WFRhZk4wdnJ2MXZ6NEhad0pN?=
 =?utf-8?B?a1VoRENnbWVkUC93bEk5Q3RPZHdzZVpqYmpUUi9HQ0Jmd20ra3lMTnduakhH?=
 =?utf-8?B?UkxwYTFmaW5OekdEMFlLcnVtaFVVNXNLVU1mT1lnTHYwdUJaMVZmU0ZrcUVT?=
 =?utf-8?B?T05SMkc0STExN3Q2Q3BUNmxZVGE0SENBQ0l2RzJXM2JuaXg4Wkh1b3g3ZkNo?=
 =?utf-8?B?MmdYQ3BlZmhCYTlqSnNNdW9WOXBpVm56VWp5Y3JCYjBNUXQveGpLbEJrd3lS?=
 =?utf-8?B?UkNzNGUvdjVXU3IwSFY2Tmpib2pZcytWei84alhGWUI2a0JQLzRGT3NDdFNM?=
 =?utf-8?B?V0ZxN2JRYVBzT2pjL2UzaGhFK3FGY1Zzd0YzVEdpc3VSNGRnRi9BanZZWnZj?=
 =?utf-8?B?VnFwMXhiOFF6MlpDUXZ3RVRFSHZRQmdOZXhqV2dkamNia2UzbzZ0NDUyVEM5?=
 =?utf-8?B?SXo4c1NNaFUyOHhOOEhnbnNXcGRDVStzVzZoVjNhNStxWHphTDJjMGhmQkZS?=
 =?utf-8?B?d2ZDMHRvdUFRTFFrMlhrQ3VTTXVlRFNHR2VtZlFkVjdUK1lYamtqaTZiUlVm?=
 =?utf-8?B?aDg3MldNNnpId0JKZ1hFVHpESDhYWnAwZVdOaXFvaDFGa1l6bkpXSkxiMmZ6?=
 =?utf-8?B?MFhpM2N0RDUwcWNrM3NXakRxZGIxam1OQ0JQOXdxU2VBNkpTaUhMNUsrZnJu?=
 =?utf-8?B?SS9sVlB0djVhUWZSclBaZCtxUHp0S3lVRVA5eGx1K2tTaGo1c095anpVUlc0?=
 =?utf-8?B?RU1qTzEyMVpzQ29Ca0tuUVhGRVdpbGlWVjJGdjFRckliZC9TdFN0YjJrMHVH?=
 =?utf-8?B?Ny9IbWVEa2U0RmNQeThqb2kyeEoxOGMvdUZzc1NRakdOMXZJNWtMTTFON0tH?=
 =?utf-8?B?YWE2elZaMFJLTVdRQXcvMlorNGMxT3pubTlJRWRpdEl0L0NYUkl5M0c0NGZv?=
 =?utf-8?B?c3VkZTB1WVFVM1ZYUmRNcXhiSEtRMmRJcVpIS014b0h1UFA5ZDBuZmQzZUxI?=
 =?utf-8?B?MDcxMVEyRmhRZEJLV1NyT2oxVDVlM3BFSFh1WWdqa3NGdUY0Z2JmM0pBL2lB?=
 =?utf-8?B?cDRoQ1Blc3h0Mmp1Q0ZmOGEzbkVOcWkyckU4SjhaVk1leWZXUC9MZCtqOGF0?=
 =?utf-8?B?dlM5R0tUNVhkNXVuODRlYVJaZFVUYkE3UTBnYXpGRCtkYUdwdkZhYm1ISDJ3?=
 =?utf-8?B?c0tNS0U1MzV3bjRxRDVQTVN3cVphdHZHdmdVczUxempwOG5QSWVBQ1pRMFdp?=
 =?utf-8?B?SjE2NXg2bGo4OHNDTXdlQW51OU9tV3RJcmk3QWF0RzNlRHl4NzZKNjVjWjZT?=
 =?utf-8?B?QXZDMUtLa0pQQ3UxWUZyZVU1TE5SYXhZT0ZVZk5ZNElsNkJCV0ZqY0RjOFli?=
 =?utf-8?B?a3V2QnRrWHFwUjJXaDV3VFQrVDl1QXRVb1dvVGxvZFFJaVMzaXNLdmNlUE5h?=
 =?utf-8?Q?t06rPMThr1dEltBJ8/KvMN8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2982d6-7796-47df-33cb-08dbf1cf7ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 18:09:22.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nezLYd8ugZku3Ql2IqV8oZHOOIr+kNRnVcx1pEYdEmrhFK4YdpfAmcHkpdRHMnqiAc+8FqUpUs2HKrkBaPAk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4196
X-Proofpoint-GUID: NjydnO0EGP50GvEnBN109Ug8r17jsbbt
X-Proofpoint-ORIG-GUID: NjydnO0EGP50GvEnBN109Ug8r17jsbbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_17,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300134

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjks
IDIwMjMgNDoyNCBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtl
cm5lbC5vcmc7IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIDMvNF0gUkRNQS9zaXc6IFNldCBxcF9zdGF0ZSBpbiBzaXdfcXVlcnlfcXANCj4gDQo+
IFJ1biB0ZXN0X3F1ZXJ5X3JjX3FwIGFnYWluc3Qgc2l3IGZhaWxlZCBzaW5jZSBzaXcgZGlkbid0
IHNldCBxcF9zdGF0ZQ0KPiBhY2NvcmRpbmdseS4gVG8gYWRkcmVzcyBpdCwgaW50cm9kdWNlIHNp
d19xcF9zdGF0ZV90b19pYl9xcF9zdGF0ZQ0KPiB3aGljaCBjb252ZXJ0IFNJV19RUF9TVEFURV9J
RExFIHRvIElCX1FQU19JTklUIHdoaWNoIGlzIHNpbWlsYXIgYXMNCj4gaW4gY3hnYjQuDQo+IA0K
PiByZG1hLWNvcmUjIC4vYnVpbGQvYmluL3J1bl90ZXN0cy5weSAtLWRldiBzaXcwDQo+IHRlc3Rz
LnRlc3RfcXAuUVBUZXN0LnRlc3RfcXVlcnlfcmNfcXAgLXYNCj4gdGVzdF9xdWVyeV9yY19xcCAo
dGVzdHMudGVzdF9xcC5RUFRlc3QpDQo+IFF1ZXJpZXMgYW4gUkMgUVAgYWZ0ZXIgY3JlYXRpb24u
IFZlcmlmaWVzIHRoYXQgaXRzIHByb3BlcnRpZXMgYXJlIGFzIC4uLg0KPiBGQUlMDQo+IA0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IEZBSUw6IHRlc3RfcXVlcnlfcmNfcXAgKHRlc3RzLnRlc3RfcXAuUVBU
ZXN0KQ0KPiBRdWVyaWVzIGFuIFJDIFFQIGFmdGVyIGNyZWF0aW9uLiBWZXJpZmllcyB0aGF0IGl0
cyBwcm9wZXJ0aWVzIGFyZSBhcw0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToNCj4gICBGaWxlICIvaG9tZS9namlhbmcvcmRtYS1jb3JlL3Rlc3Rz
L3Rlc3RfcXAucHkiLCBsaW5lIDI4NCwgaW4NCj4gdGVzdF9xdWVyeV9yY19xcA0KPiAgICAgc2Vs
Zi5xdWVyeV9xcF9jb21tb25fdGVzdChlLklCVl9RUFRfUkMpDQo+ICAgRmlsZSAiL2hvbWUvZ2pp
YW5nL3JkbWEtY29yZS90ZXN0cy90ZXN0X3FwLnB5IiwgbGluZSAyNjUsIGluDQo+IHF1ZXJ5X3Fw
X2NvbW1vbl90ZXN0DQo+ICAgICBzZWxmLnZlcmlmeV9xcF9hdHRycyhjYXBzLCBlLklCVl9RUFNf
SU5JVCwgcXBfaW5pdF9hdHRyLCBxcF9hdHRyKQ0KPiAgIEZpbGUgIi9ob21lL2dqaWFuZy9yZG1h
LWNvcmUvdGVzdHMvdGVzdF9xcC5weSIsIGxpbmUgMjM5LCBpbg0KPiB2ZXJpZnlfcXBfYXR0cnMN
Cj4gICAgIHNlbGYuYXNzZXJ0RXF1YWwoc3RhdGUsIGF0dHIucXBfc3RhdGUpDQo+IEFzc2VydGlv
bkVycm9yOiA8aWJ2X3FwX3N0YXRlLklCVl9RUFNfSU5JVDogMT4gIT0gMA0KPiANCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBSYW4gMSB0ZXN0IGluIDAuMDU3cw0KPiANCj4gRkFJTEVEIChmYWlsdXJlcz0x
KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51
eC5kZXY+DQoNClZlcnkgbmljZSBmaW5kaW5nISBIb3cgY291bGQgdGhhdCByZW1haW4gdW5kZXRl
Y3RlZC4NClByb2JhYmx5IG5vIHJlYWwgYXBwbGljYXRpb24gY2hlY2tzIFFQIHN0YXRlIPCfmIkN
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAxMCAr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IGluZGV4IGRjYTZhMTU1NTIzZC4u
MjMzOTg1NDM0Y2ZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d192ZXJicy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMN
Cj4gQEAgLTE5LDYgKzE5LDE1IEBADQo+ICAjaW5jbHVkZSAic2l3X3ZlcmJzLmgiDQo+ICAjaW5j
bHVkZSAic2l3X21lbS5oIg0KPiANCj4gK3N0YXRpYyBpbnQgc2l3X3FwX3N0YXRlX3RvX2liX3Fw
X3N0YXRlW0lCX1FQU19FUlJdID0gew0KDQpZb3UgbWF5IGJldHRlciB1c2UgU0lXX1FQX1NUQVRF
X0NPVU5UIGZvciB0aGUgc2l6ZQ0Kb2YgdGhlIGFycmF5DQoNCj4gKwlbU0lXX1FQX1NUQVRFX0lE
TEVdID0gSUJfUVBTX0lOSVQsDQo+ICsJW1NJV19RUF9TVEFURV9SVFJdID0gSUJfUVBTX1JUUiwN
Cj4gKwlbU0lXX1FQX1NUQVRFX1JUU10gPSBJQl9RUFNfUlRTLA0KPiArCVtTSVdfUVBfU1RBVEVf
Q0xPU0lOR10gPSBJQl9RUFNfU1FELA0KPiArCVtTSVdfUVBfU1RBVEVfVEVSTUlOQVRFXSA9IElC
X1FQU19TUUUsDQo+ICsJW1NJV19RUF9TVEFURV9FUlJPUl0gPSBJQl9RUFNfRVJSDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgaW50IGliX3FwX3N0YXRlX3RvX3Npd19xcF9zdGF0ZVtJQl9RUFNfRVJS
ICsgMV0gPSB7DQo+ICAJW0lCX1FQU19SRVNFVF0gPSBTSVdfUVBfU1RBVEVfSURMRSwNCj4gIAlb
SUJfUVBTX0lOSVRdID0gU0lXX1FQX1NUQVRFX0lETEUsDQo+IEBAIC01MDQsNiArNTEzLDcgQEAg
aW50IHNpd19xdWVyeV9xcChzdHJ1Y3QgaWJfcXAgKmJhc2VfcXAsIHN0cnVjdA0KPiBpYl9xcF9h
dHRyICpxcF9hdHRyLA0KPiAgCX0gZWxzZSB7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0N
Cj4gKwlxcF9hdHRyLT5xcF9zdGF0ZSA9IHNpd19xcF9zdGF0ZV90b19pYl9xcF9zdGF0ZVtxcC0+
YXR0cnMuc3RhdGVdOw0KPiAgCXFwX2F0dHItPmNhcC5tYXhfaW5saW5lX2RhdGEgPSBTSVdfTUFY
X0lOTElORTsNCj4gIAlxcF9hdHRyLT5jYXAubWF4X3NlbmRfd3IgPSBxcC0+YXR0cnMuc3Ffc2l6
ZTsNCj4gIAlxcF9hdHRyLT5jYXAubWF4X3NlbmRfc2dlID0gcXAtPmF0dHJzLnNxX21heF9zZ2Vz
Ow0KPiAtLQ0KPiAyLjM1LjMNCg0K

