Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175177D6CA9
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjJYNE3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbjJYNE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:04:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044B116
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:04:26 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClQ2I000366;
        Wed, 25 Oct 2023 13:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cmQxUN4tWrzAa91eQDolflwaeY4VOHNC+OCkA0zpwcY=;
 b=GhaoEal/Q594oGFxB+KnFEcVKRlCai+P+YCy4L+WpbPwl9z8PyfoW1YOgU5Q3tKPLN+v
 4IjsewQFMowNVn4QVC4tbcxLs0bb5BP+3G7Jj8sUYQ63G/YPjcTHVXz2gZt1i8dReEwu
 03k6KxLhGuvm17fcUp4mkYhb7bWBByu+tK14t1t7KgnucVGigOWxAUSJTaThlMsBAqC5
 gpKWMTEHrmpWwY/8EUnIOjfkssDhcqSc4GGAVUoF+Pdy5sbJrZ3nKcYbX5r7T1BnOm+6
 YLfiiF1/ujggDYwj5DIWhuGpgA6r3a4SzFQBcF+m54+O5OxWKeLEzYCPQadQfo3evbTj LA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b3rs1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mav5gxirRVy5qKLkzpxnXAbLsKGu/q31R3ZeDkcW65lt2XvlAKMIVOpvOfM3kv30lT/OljlMkas9qDlvVvXGTMRPNCLlTMxSP1pFePCWB7VdzmF1WwftuNSBm7Gu1ZMU7ergJ+WZYHBu0Q/cCfIq4e0m5pM53fs+Pwb9C/dlLGw3YdIdRw0X46oqDpjbqPga4cS7kMdR0YfNPB/ub966diA5RK4Hj1pSpn0e1B0sg5LLoln/xDYCT+hbFMWWILs1mEt5r3JGzVgI7soYeygLy5NZ6Bd+RBWmgYPZ4Zb9Qo95pwHSuzIJYzgNUW8LVCjMA5ekaTzz0OivjaPQT6ej7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmQxUN4tWrzAa91eQDolflwaeY4VOHNC+OCkA0zpwcY=;
 b=WedcbJb6jIm9Xa+b5pDWX9Z8fuCWtmqnsGgyCIxVaOL28ibt+DcvZu3ndcM7dwwsSL9w2MBPkzd+ZnHIb02RImtOE0h3Ht6FVNaZVKClkN4siMLlM7mvgF/cElVy5QFZUMhzQPDed6tYBUGD/bgGVnGEJaF2SV4mGL7Wvf5+rslwfwNPEJ7Zti6dm1FCXKPY1PXRWWzKWgb6ekGDEuIpPEyxDmiP30WCfg3VEEwMwGFh0IOphYln+oYb63ZOTExFPvJ3A9FbgO7pJEx11g4fLVJOhxkdFPf7RY0cuK8hgobrVk9DS0C5kfvWalr5fOGab4i/91TlDDqz7cHhQUs1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by LV2PR15MB5357.namprd15.prod.outlook.com (2603:10b6:408:17e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Wed, 25 Oct
 2023 13:04:01 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:04:00 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
Thread-Topic: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
Thread-Index: AQHaB0O5/SstmxCXz0eivIljVe3Yuw==
Date:   Wed, 25 Oct 2023 13:04:00 +0000
Message-ID: <SN7PR15MB5755FBAC40BA3C94DFE20DE799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-14-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-14-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|LV2PR15MB5357:EE_
x-ms-office365-filtering-correlation-id: 5c3b8b79-e0d3-47d5-431b-08dbd55adb7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Somcx0XC4k0r6tUxir2mAkysp0AuTQ0iFCsLgSgk+QjKSNuLBY8ZcHLkmbPUx4fOpPATDHjzTJj7tHygPJXIqs6G9H/SzA7QIYltwgoTvzIQ+TjZAEJydgHMbhIRGZzaDFlQbVrfMYvAGUjhZNVSzSY5FDWCvUdTIURXBtfkAZASVyzw0dG5fVjTLtEHkVsn+SqqwRyP04vZ0yM7JEQQK8V4+TuQQxWyVOENELfAN+AktybAktW6ecUFCGqNPo8FglavmlccV/Ysg8wbE+kngHpS1R7BpNQqvvLmxlim5H3phJezRzxX4eiS14tNqlu1cWBtN1CNL6DSodHMs2g1IYGxaD4K9fuWxsdyRe9tgu6RRlIoEHVAMamEz0dYxeMaWfIvk/EvoAnIjbLFf0zpqnO79LHaa6G3jLRLPObsesQnsyzOri95f0WL4rHBkvENoAMR7NemGBd6p7iC1Imben7Q3RZQsI6q6PMMeqCYrJlTmARNY3dfGSJ3v7S3ePumMRbmvnF0v3UxcFYjxGrV3fEmtx8s8Nu/P5kBacYYB4tsnt1ZOeyRrgxhnqzzOiwc2w1oT2GUWytrxFizOEDho977pb6dv1EK3CMd01shMQTqfLgSHT1mIvOb4h0BFFEr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(4326008)(41300700001)(8936002)(8676002)(2906002)(38070700009)(52536014)(5660300002)(83380400001)(53546011)(9686003)(6506007)(7696005)(71200400001)(38100700002)(33656002)(86362001)(122000001)(478600001)(64756008)(55016003)(66556008)(316002)(66946007)(66446008)(76116006)(66476007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTFMVnFVcWcxL0o3WHpLYm9pekd0WHVwNnRWR0VKUEhHNkVsR1FrQVQ2NEUy?=
 =?utf-8?B?TFB4ZmRrbGx2dlZCOHhORm5rdHZUeDdmY1hwYndrT1RMV21XSUpvZnJzSlpu?=
 =?utf-8?B?NXpDbnlIc04rZUdOcUpRWUYxc3JwazMxQmhnV1hVN2NxNEhNSzlYWjdySWdx?=
 =?utf-8?B?NGZkWUVPMUs1U3U5UVhCbGJuUXBFdDhnK3Z4enFueC93c2ZsSTdBTytyY0tm?=
 =?utf-8?B?MkxjT0REZ1IvdkkwREZVMlg1bUcvYmp4WTRMOWoyblJJU2lqVjFpcVdUeFJ4?=
 =?utf-8?B?ZHRhRnZJMjI4R3BxYTIrTklPckpPQ1V2VFpMUjd6dUdiRWFEVDlILy9lN3ZV?=
 =?utf-8?B?Y242U2ZFSXM3NzZqQUpwM1NQSEg2TU5SdHlrRVA1SmI4elIxTlo1U2tUMHdm?=
 =?utf-8?B?T1hQaHlJaWxLM29MaDZ3cUFhWWhCdGd4K0JUU0NqbHZNcFhxOXNiVVZhcCt2?=
 =?utf-8?B?SXM1T2FyRUFVM0UyUzhod1Y5NmttWktMMlJ1bU9wbm5USndiNk10MGY1MkFO?=
 =?utf-8?B?ZlJJVzBmYXJkR1lTUndhVGs5U3Q3QnBEZkJqai9Zc0xYcGhGYnkvRDA2Vzl3?=
 =?utf-8?B?cU9sc1laZldsZUtNK2I3UUNRNWNTMUcwTDgvWEtSSENDK0E3cHp1cGdZak5T?=
 =?utf-8?B?WEszWWZxaUVDWEFnTUQ2RjVoZFhoeXgxeVZNTnZTamY2VXdTV2F6N0hNdzNX?=
 =?utf-8?B?ZGZzYXdoRi84Z1ZpRFdteFAzNjlUd0N4U05MbFk3UGh1MGZBVmVqOUxtWFBR?=
 =?utf-8?B?aHE1MnUzME9XOUU4RXRob0VHbzl2K0YxRCtKZkVSVUJ5UGczUE8ya1g5cndo?=
 =?utf-8?B?cnJjN2ZjMk9uam5LOW9kU1JxU1piSGRjZ1kvdTZMMytUdUVHSWFFNDJhMXBs?=
 =?utf-8?B?L0paWjE1dG5uQ3ZxeEEyVTdHd3BnVG4rY25qbDhna2FpalZadmdEb3FSUWEr?=
 =?utf-8?B?cXVOQUpvaW9xLysvUzd1WFRPMUFkK0hKdWdoYktwakt3RXh0ZWNWL0VCREtO?=
 =?utf-8?B?eHREMnd2S3d6RDBBMTRkU3lvWjJQT2t4MFBJUDNSaFRHTTkycWJFWGtHVmlq?=
 =?utf-8?B?WElYZHNXUmJpNjgwdXpFRUlYN1I4SVh3bDhtUVBHbDVINytiQzlmN2dsR1Fu?=
 =?utf-8?B?a1NKbzk1cTBvT3lBR1ljNFBlalVIaEZlMjFBcm9ZMkxjRlgrZ1hBSTFNT3Uw?=
 =?utf-8?B?RkR4S0pNVTFxMWo1OWFES3JOYWVGakVVZkMwZWppdkUzNFdyS0pSaExab3o4?=
 =?utf-8?B?R0RkcDBFYWRDR1dWZm1pcktmZlVDbzMzbjBlRUFacTVKU29qbTNqdi9lN2xa?=
 =?utf-8?B?SS84MisxL0FhQ2RQMFBiWUJURkNrSDgzKzJ1WlIvZ0VySDVIZVp2UzVaQ1l4?=
 =?utf-8?B?YUxGSDlxRndaNXRHVDQ4QXljRVBndGRaNktsRUlYNjBPT2VwOTRMckZsdThP?=
 =?utf-8?B?YnpKOHBFMVRjdWs4YThmbnNOZExhODM0Y1RXRWNtV0lHTkN5cUtWRHpCSzF3?=
 =?utf-8?B?WVFDakJwOVR5bk80c1RBVitkRE5iNk01K053MmNycnhydjlFWWxjN3dHMnlr?=
 =?utf-8?B?d3NHZ3NKa3pwblVCcEJMME5yb2Z5ekRVVUNWOHQ3Wjd3aENkbGlNY1MzZ3l3?=
 =?utf-8?B?UEl2VFlMRTZndmRHdzJyK2V2ZjB0dm1xazdVaWtGUEZBMERncENHV1ZpcEY0?=
 =?utf-8?B?M00va3R1bFRaTmtrVENVQ21UREc3Tm1JQnk3ai9UU09vMVdIakhxeko3NHNw?=
 =?utf-8?B?R210a0lDZW1MOEZNUzdDeUlvbThpMFdyVUp0ekh1NUYwK0J4bmp6TWF5Zkc1?=
 =?utf-8?B?TFpmNUNaUUFRdGxKazBqQUtacXpkNVRsRGFSV0IrRDM5SGg2T0w0cmdNVnpD?=
 =?utf-8?B?WVFkdmZiVTMxRmFib3NuQ3hmL1F2QXRVTnFGeFkzTDJSUm1LN25yQUpITDJj?=
 =?utf-8?B?cUZMUWM1VmFYU2o5NlFmRVpRbjdzczAvYUV5bGJQUEpxRk5tTnJDVVVKdUcx?=
 =?utf-8?B?ZFo2aEFOTCs5bmdtZ1AxeHhEaUQ5S2JVWFFSK3ZYdjBleFpXYUduSEFEeGJw?=
 =?utf-8?B?Y09NdmRIeEN2ZGhQOW02OXUyM3h4cEgyZS9NNXpKd2JBczd2TUloZmtqdkpi?=
 =?utf-8?B?czJoRmYwQ0dmYXQ1R0huVmsycE51R2R1VHZubDl2enJRWE9JTkEweU5pc3pT?=
 =?utf-8?Q?R8SFG5emeNjgf1Af0N3MjgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b8b79-e0d3-47d5-431b-08dbd55adb7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:04:00.9351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQnrbslBdsWR3djyqkMbduR5pFDifJd+lSmFXGT6ZTGScKkpjLl+LRc0Zuz8qWhCL62IYcHhxdoxpRkePGFjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5357
X-Proofpoint-ORIG-GUID: qU6z-taGy3QnGy-WRjpuJla9xuHFHtm0
X-Proofpoint-GUID: qU6z-taGy3QnGy-WRjpuJla9xuHFHtm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250113
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDEzLzE5XSBSRE1BL3NpdzogU2ltcGxp
Znkgc2l3X3FwX2lkMm9iag0KPiANCj4gTGV0J3Mgc2V0IHFwIGFuZCByZXR1cm4gaXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oIHwgOCArKystLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiBpbmRleCA0NDY4NGI3NDU1MGYuLmUxMjdlZjQ5
MzI5NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiAr
KysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IEBAIC02MDEsMTIgKzYwMSwx
MCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBzaXdfcXAgKnNpd19xcF9pZDJvYmooc3RydWN0DQo+
IHNpd19kZXZpY2UgKnNkZXYsIGludCBpZCkNCj4gDQo+ICAJcmN1X3JlYWRfbG9jaygpOw0KPiAg
CXFwID0geGFfbG9hZCgmc2Rldi0+cXBfeGEsIGlkKTsNCj4gLQlpZiAobGlrZWx5KHFwICYmIGty
ZWZfZ2V0X3VubGVzc196ZXJvKCZxcC0+cmVmKSkpIHsNCj4gLQkJcmN1X3JlYWRfdW5sb2NrKCk7
DQo+IC0JCXJldHVybiBxcDsNCj4gLQl9DQo+ICsJaWYgKGxpa2VseShxcCAmJiAha3JlZl9nZXRf
dW5sZXNzX3plcm8oJnFwLT5yZWYpKSkNCj4gKwkJcXAgPSBOVUxMOw0KPiAgCXJjdV9yZWFkX3Vu
bG9jaygpOw0KPiAtCXJldHVybiBOVUxMOw0KPiArCXJldHVybiBxcDsNCj4gIH0NCj4gDQo+ICBz
dGF0aWMgaW5saW5lIHUzMiBxcF9pZChzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4gLS0NCj4gMi4zNS4z
DQpObyBsZXQncyBrZWVwIGl0IGFzIGlzLiBJdCBvcGVubHkgY29kZXMgdGhlIGxpa2VseSBjYXNl
DQpmaXJzdC4NCg0KWW91ciBjb2RlIG1ha2VzIHRoZSB1bmxpa2VseSB0aGluZyBsaWtlbHkuDQo=
