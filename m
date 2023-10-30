Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED897DBAF2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjJ3NiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3NiT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 09:38:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C497
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 06:38:17 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDZjP5031705;
        Mon, 30 Oct 2023 13:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CxhlGqAz9Q/2SfWmO7Y5kpS4MUHmJv/ZSuVEDhK/9bc=;
 b=dR1PxSrcUuFX09eW0Osp3JpkexdnYb+7DcphVOX9xc42N3NPOHT+gk89RLubclE6rQWM
 YpOUerqL+XlWI7LZQPaIkHOUchuLowcQswX61MyFmkv2/m8zEyddA+PYTA968Pbv7Q0M
 v1LJY95MkPxvjW4Alhsdve3Lo1p1aF1ejkoAryeNtFECjzQdHWZxX0AZhiK+v2fN0AzH
 bwbtunAKlxjAkoAGbERHh8G9UMtUNxbj393UQCrJnmJjCMtVGkYzkczE/O77BEMHBZBI
 tJagYVG/FUZeme3QVJZBtZqaR/+7pllmrCnFvgVSP6Xwam0F8Y7mQvNFLA56cLQs7URB KQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2dgq87nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odpG7XqcY7D5cOYKK99CSVpcNsEQYHcxCbok8ZjEje8xVINuPRsFzZB9Dr1bRKhBYG2/cLOYBIN+E251To1yty+upWhRjyS+RL9UfAi4g9HF4OMQZMOi5ElqrMGL+opQE1gFmk8BghIqRqyKYRUvb1x5pOYtSWLeecVMZrRffWTGOY5MLbQyPigHpDV+ixRVI1HMSow5/CEfrRS139EHjI8/SqFmVXfyiW5gl5IgxLDI3iCGxjhEUOxso032KfYyYJHl/avlTLMZHsgk/PlCjKCOuMdoTPNN6MQFZ4kbQ5nHb21+rC7mwqO5TC0emOED155qh1wLmtehnqfdckMIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxhlGqAz9Q/2SfWmO7Y5kpS4MUHmJv/ZSuVEDhK/9bc=;
 b=j9iQtACDgPa50HXuil0Q4igNoH6/K4W7TCA+8rq0N2mlkrAngix+4e8Bd9UQv+QrjSVpwhGhxm5QsHIwHEEJmEY9f5Fw8fkqjKO1MNmsrDhF83BW6ZjtrQCW+Hpet+8s+bP7PtdskChoibry+Tg5adqrMrRO/3uUZeyYWKvF/JPjjXfqv+aF8ozqvm9yksSCmrUNi59AeJhDZCyUdS0Xc/hjuWloPojy3vShoTM/8bjw4nx4nHaY/9YZ4bID1Bu7Ha9D/0d/ryzcR6oi8WGFZigvM+GL/18stCJUg54F0G1b8uTzIjkq0c5yKtNx/SVyzBleFhifcWkrqE+StF1JDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA3PR15MB6145.namprd15.prod.outlook.com (2603:10b6:806:2fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Mon, 30 Oct
 2023 13:37:49 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 13:37:49 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V4 08/18] RDMA/siw: Factor out siw_rx_data helper
Thread-Topic: [PATCH V4 08/18] RDMA/siw: Factor out siw_rx_data helper
Thread-Index: AQHaCzZGhF7uqLZYB0S6Ub5OXiLVQg==
Date:   Mon, 30 Oct 2023 13:37:49 +0000
Message-ID: <SN7PR15MB5755BE429D69C142C350AA8D99A1A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231027132644.29347-9-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-9-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA3PR15MB6145:EE_
x-ms-office365-filtering-correlation-id: 948530e6-99ce-41fd-1bde-08dbd94d68c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odc2Dj8KmszpB3pMNF3YiD5BhQGpAb8RxzwAZUg+n4nriPNyScDb+iukT64IJFPPKRAeoagOPoeU0RMFNbNISpzcVDIQgVqGgE/gAIReG9pqZG2xR04iSuORE4G2jImnd34hiLHpAOxng1fi5yBGgOMbhpDcDXna9cxVZbOZigUXqPDyI79stywW77gPlWYZXlhgjjdwIF7qEFBi1UrcEHq46KDP7z8DOSYps593XToeLgojnnTsrwpgsWW0voqBE1/xskyfnFBiD/5zZwfcuIUdyyJLeB1M4R9/5hVV1Yo8mDrKnhhBJo9ERB2FLnSzeuClMVeDjLoChYC8pwS6oxSQk86d7JUY4YNlJdJW3Leh/iVsCnKJuBJkCSoLjrxh6t0RJx6p54XxiqTc/ye64FBgoFWZ/dw+zY68V/I/OGRquxZutqqNzsomNPeikuvdqDS5f1GfEG1WdWuS4uiil71wr+BogvruN0wblwBsX/W81+vqZiyYTB4y9Exlbnog9ckTM9Hk7RQLrMLaYA7BKVYz19Xy+hhhe+kkcffep48ohAXngjN0pDljutdnFYoTqUrsHT/2KoFW1xwxfanFzohPyNBuvEhHKlosiK6nePxCoJIBDRcQ2SjeK/BuENWImAR0qWBFKedrEWKk22afo7i/tgnkUEP2o5HShWiIro4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(83380400001)(41300700001)(76116006)(110136005)(2906002)(33656002)(26005)(5660300002)(86362001)(55016003)(122000001)(38100700002)(6506007)(7696005)(9686003)(53546011)(478600001)(66476007)(66446008)(64756008)(66556008)(52536014)(66946007)(316002)(8676002)(4326008)(8936002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHEwb1dBNVQzNXV2cWRJUzl6RFhMcVpvbUUwcGZzQTMrN3RCbHNjcHEyMkZr?=
 =?utf-8?B?aTBGVTcyMWdUbjllMmpwazdnQUo4SUxvUGJyZCtienpHYjRYMElmU3AyQ3RY?=
 =?utf-8?B?bjIwZ05IWHJBQlhoaW00MklBaElFcDgxVzQ3Vm5ZdW1MM2pzdExaQTQ1T2JY?=
 =?utf-8?B?OTdLakJGZ3lIQXFvRkI3dTcxdHBIYXJleXFWK3N1ekJpaFVlcERMc0RTVkUy?=
 =?utf-8?B?UUYreHkvYWdvTzEvUTZlSlRubnlJRFhiUWppWXdFNFE2djlaK0d2WlFMZ0hY?=
 =?utf-8?B?bzQvdlJBd2drRnR1SDZPN1JCRzRBSFI4Q3ZzYU5JL3Q2eFV3QXkvL3ZibHBa?=
 =?utf-8?B?YVZ4cGt3ZjArOHUyR002SnVjaTJJNEVhZUZUbzlmbW9XUStxY1pyNEVaSC9w?=
 =?utf-8?B?N2c3V0hDSjIzM1dnWEY4QjhOZTdtRjZaV1VwNTFNOWNMdGxlZExYcHFabnhP?=
 =?utf-8?B?UDJVSFVrWWIzWElYR2FvNHRaM0hVR3RSRTUxN1g3SzBtRHhQVzhCNlhoMm1i?=
 =?utf-8?B?dGpOTWdOa2lUR1UrNFQ2WFZlMmp4VnBPVTVsMWRKTm5lYjZrRGxVeTloUWJj?=
 =?utf-8?B?WmFaazEzdG1vYjNlQVFldXZSK3FqUmxJNkN0WkxvelBoVGN0dFVyVE1QTWNO?=
 =?utf-8?B?QUZpbHBxdTBoSGZySDk4czE2SXhwZStvQnpZazBsOUEzQXRqLzQ5RGRha3ky?=
 =?utf-8?B?aExseGJZTllmNjJ2NjR0MG9NaUJWdEFyUnNpcERTaVBSS09jUGpSQXVVenJP?=
 =?utf-8?B?WDd1VHZ5ZXM1ME1wY2VHSnpEM05MVi9naHpuTmVMWEZ2TnRFVGluV0piRlYw?=
 =?utf-8?B?ZmtjR0xESThOSFgzZEpMY3Flb1REUDFmdVByK2FwcWdkOGFYd1ZGUUl3RklI?=
 =?utf-8?B?RXRvWUF6VGhoNVBvZU9aSkdLNm0zcHJrSk5IMjNTeXg0UUgwZ2ZpbnRqK2Vm?=
 =?utf-8?B?T3U3ZXVNeXRxcklDbW12WmNNSFhpdFgrWUJSK2hmTXI2Wk5uUGpVUXAxUjFu?=
 =?utf-8?B?VE82VTRSaVkvQnlFeVN1R3VWMkpKdUdKOFhhRG5vaTk2Sk0wNzhaN09NUUFu?=
 =?utf-8?B?Mm9YU2doejBvVWUwcktpUGhCK1d0TFR0RTZodUp0cnFIc1dpRDNIWHFWcXJH?=
 =?utf-8?B?ZFp5SXlrNkc1Zno3QUFoL0FaSE83Z29vQ2NvZ1pBaFBFMXZHUStjTmFYbXpF?=
 =?utf-8?B?S1gvSDBobUdxMUJWSW1ZeEJON295aW9rdEtRbzR5Zm8xelh5MjRTOWF2RnlP?=
 =?utf-8?B?eGkxeTRxdHBIVE5mdk9PS0xqSnoxd1k0OWFEMFZOQWFET0o5UHRkdkxOWjBL?=
 =?utf-8?B?VTVZTnNiQ1dTdHcwZTlkUXpBODRNL1YwVTNVYzdEQnN2RXlOanByQ3hsZmo4?=
 =?utf-8?B?QklIQmg2NllMd3hGcm9JK2Y4U3pHUjRxUjhtamxmTUlNWkZmcHNFZGZOZnVt?=
 =?utf-8?B?S0QvUnU2UHh1L3F6bldlaUpPejFNaUNlN3M0aVNPZ0kzb3ROR05OMnBIbW1z?=
 =?utf-8?B?WFR5Q2xLMVRFYUZkSm5hR2UvZVUraXhnTFBlamZmeVJ2NXBiT3YxL0J6VDhN?=
 =?utf-8?B?clhPQWhzWDRUTjNjNG42MGhhQ1NkSW55dlJHRGJzT1lhSVRoeG1kajZIa3dS?=
 =?utf-8?B?MzdpMlRQYjNjNlpPSVRIUFg0ZUtlQVI5WVF5TVdBNFFUTmswMDdibHllaXUx?=
 =?utf-8?B?YStGMHZrRFc2cEROM1d2VUoxNkNreWc3TjVjeXZIZ2l0V0dQOEZKd0dhWHBS?=
 =?utf-8?B?OFNWR3VIMTJ5NFRBaUh3akVzbjRvODRoRTcya295Ujk0dnBrRHJGVjltRXdT?=
 =?utf-8?B?MkpuZjNkUUJGTm9tU3RQemFmZzE1cmt1TUFYQmRCSzU5UkxWK1o3Yi96OGU5?=
 =?utf-8?B?WlVIZ3g4Y1FGM2E4RzdYbDY1T2dyOXJGRXZNZnhhaFN6bTJ5cGNoNE9VSVJI?=
 =?utf-8?B?YjNpelJZUitnbzBSbG9zRzhHZnQwSUdqQzZPelhpRk8zcmFXUTNrckwxM3I4?=
 =?utf-8?B?MktVRU9hNjhOY3dBM3NJVlRwQlVpOVlJd2pnWGx1UVF0MVFKRXhhSVhqbnlG?=
 =?utf-8?B?N2c1Tkk3dlFQTjZTNnJTUDY3Z01HNmlaU3p0TkpmU3pUOWNXUzNKcHZOalRT?=
 =?utf-8?Q?hqNw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948530e6-99ce-41fd-1bde-08dbd94d68c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:37:49.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TforIcfvXyk+ShLX8AoMxIGFyAzqWXT1oSJloh/zbyDfcbk58oBUA0GewsLDEdoSBM78YFMGkZPjDIlZ+eCu5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6145
X-Proofpoint-GUID: bXM8wzPbVFurHvAK_OX1DN45ugs3B-Ld
X-Proofpoint-ORIG-GUID: bXM8wzPbVFurHvAK_OX1DN45ugs3B-Ld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=818 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyAzOjI3IFBNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWNCAwOC8xOF0gUkRNQS9zaXc6IEZh
Y3RvciBvdXQgc2l3X3J4X2RhdGENCj4gaGVscGVyDQo+IA0KPiBSZW1vdmUgdGhlIHJlZHVuZGFu
dCBjb2RlIGdpdmVuIHRoZXkgc2hhcmUgdGhlIHNhbWUgbG9naWMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+IENo
YW5nZSBzaW5jZSBsYXN0IHZlcnNpb246DQo+IDEuIHJlbmFtZSB0aGUgaGVscGVyIHRvIHNpd19y
eF9kYXRhIHBlciBCZXJuYXJkJ3Mgc3VnZ2VzdGlvbg0KPiANCj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3J4LmMgfCA1MyArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiBpbmRleCAxMDgwNWE3ZDA0
ODcuLmVkNGZjMzk3MThiNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfcnguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9y
eC5jDQo+IEBAIC00MDUsNiArNDA1LDIwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2l3X3dxZSAqc2l3X3Jx
ZV9nZXQoc3RydWN0IHNpd19xcCAqcXApDQo+ICAJcmV0dXJuIHdxZTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgaW50IHNpd19yeF9kYXRhKHN0cnVjdCBzaXdfbWVtICptZW1fcCwgc3RydWN0IHNpd19y
eF9zdHJlYW0gKnNyeCwNCj4gKwkJICAgICAgIHVuc2lnbmVkIGludCAqcGJsX2lkeCwgdTY0IGFk
ZHIsIGludCBieXRlcykNCj4gK3sNCj4gKwlpbnQgcnY7DQo+ICsNCj4gKwlpZiAobWVtX3AtPm1l
bV9vYmogPT0gTlVMTCkNCj4gKwkJcnYgPSBzaXdfcnhfa3ZhKHNyeCwgaWJfdmlydF9kbWFfdG9f
cHRyKGFkZHIpLCBieXRlcyk7DQo+ICsJZWxzZSBpZiAoIW1lbV9wLT5pc19wYmwpDQo+ICsJCXJ2
ID0gc2l3X3J4X3VtZW0oc3J4LCBtZW1fcC0+dW1lbSwgYWRkciwgYnl0ZXMpOw0KPiArCWVsc2UN
Cj4gKwkJcnYgPSBzaXdfcnhfcGJsKHNyeCwgcGJsX2lkeCwgbWVtX3AsIGFkZHIsIGJ5dGVzKTsN
Cj4gKwlyZXR1cm4gcnY7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBzaXdfcHJvY19zZW5kOg0K
PiAgICoNCj4gQEAgLTQ4NSwxNyArNDk5LDggQEAgaW50IHNpd19wcm9jX3NlbmQoc3RydWN0IHNp
d19xcCAqcXApDQo+ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgCQltZW1fcCA9ICptZW07DQo+IC0J
CWlmIChtZW1fcC0+bWVtX29iaiA9PSBOVUxMKQ0KPiAtCQkJcnYgPSBzaXdfcnhfa3ZhKHNyeCwN
Cj4gLQkJCQlpYl92aXJ0X2RtYV90b19wdHIoc2dlLT5sYWRkciArIGZyeC0+c2dlX29mZiksDQo+
IC0JCQkJc2dlX2J5dGVzKTsNCj4gLQkJZWxzZSBpZiAoIW1lbV9wLT5pc19wYmwpDQo+IC0JCQly
diA9IHNpd19yeF91bWVtKHNyeCwgbWVtX3AtPnVtZW0sDQo+IC0JCQkJCSBzZ2UtPmxhZGRyICsg
ZnJ4LT5zZ2Vfb2ZmLCBzZ2VfYnl0ZXMpOw0KPiAtCQllbHNlDQo+IC0JCQlydiA9IHNpd19yeF9w
Ymwoc3J4LCAmZnJ4LT5wYmxfaWR4LCBtZW1fcCwNCj4gLQkJCQkJc2dlLT5sYWRkciArIGZyeC0+
c2dlX29mZiwgc2dlX2J5dGVzKTsNCj4gLQ0KPiArCQlydiA9IHNpd19yeF9kYXRhKG1lbV9wLCBz
cngsICZmcngtPnBibF9pZHgsDQo+ICsJCQkJIHNnZS0+bGFkZHIgKyBmcngtPnNnZV9vZmYsIHNn
ZV9ieXRlcyk7DQo+ICAJCWlmICh1bmxpa2VseShydiAhPSBzZ2VfYnl0ZXMpKSB7DQo+ICAJCQl3
cWUtPnByb2Nlc3NlZCArPSByY3ZkX2J5dGVzOw0KPiANCj4gQEAgLTU5OCwxNyArNjAzLDggQEAg
aW50IHNpd19wcm9jX3dyaXRlKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gIAl9DQo+IA0KPiAtCWlmIChtZW0tPm1lbV9vYmogPT0gTlVMTCkNCj4gLQkJcnYgPSBz
aXdfcnhfa3ZhKHNyeCwNCj4gLQkJCSh2b2lkICopKHVpbnRwdHJfdCkoc3J4LT5kZHBfdG8gKyBz
cngtPmZwZHVfcGFydF9yY3ZkKSwNCj4gLQkJCWJ5dGVzKTsNCj4gLQllbHNlIGlmICghbWVtLT5p
c19wYmwpDQo+IC0JCXJ2ID0gc2l3X3J4X3VtZW0oc3J4LCBtZW0tPnVtZW0sDQo+IC0JCQkJIHNy
eC0+ZGRwX3RvICsgc3J4LT5mcGR1X3BhcnRfcmN2ZCwgYnl0ZXMpOw0KPiAtCWVsc2UNCj4gLQkJ
cnYgPSBzaXdfcnhfcGJsKHNyeCwgJmZyeC0+cGJsX2lkeCwgbWVtLA0KPiAtCQkJCXNyeC0+ZGRw
X3RvICsgc3J4LT5mcGR1X3BhcnRfcmN2ZCwgYnl0ZXMpOw0KPiAtDQo+ICsJcnYgPSBzaXdfcnhf
ZGF0YShtZW0sIHNyeCwgJmZyeC0+cGJsX2lkeCwNCj4gKwkJCSBzcngtPmRkcF90byArIHNyeC0+
ZnBkdV9wYXJ0X3JjdmQsIGJ5dGVzKTsNCj4gIAlpZiAodW5saWtlbHkocnYgIT0gYnl0ZXMpKSB7
DQo+ICAJCXNpd19pbml0X3Rlcm1pbmF0ZShxcCwgVEVSTV9FUlJPUl9MQVlFUl9ERFAsDQo+ICAJ
CQkJICAgRERQX0VUWVBFX0NBVEFTVFJPUEhJQywNCj4gQEAgLTg0OSwxNyArODQ1LDggQEAgaW50
IHNpd19wcm9jX3JyZXNwKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCW1lbV9wID0gKm1lbTsNCj4g
DQo+ICAJYnl0ZXMgPSBtaW4oc3J4LT5mcGR1X3BhcnRfcmVtLCBzcngtPnNrYl9uZXcpOw0KPiAt
DQo+IC0JaWYgKG1lbV9wLT5tZW1fb2JqID09IE5VTEwpDQo+IC0JCXJ2ID0gc2l3X3J4X2t2YShz
cngsDQo+IC0JCQlpYl92aXJ0X2RtYV90b19wdHIoc2dlLT5sYWRkciArIHdxZS0+cHJvY2Vzc2Vk
KSwNCj4gLQkJCWJ5dGVzKTsNCj4gLQllbHNlIGlmICghbWVtX3AtPmlzX3BibCkNCj4gLQkJcnYg
PSBzaXdfcnhfdW1lbShzcngsIG1lbV9wLT51bWVtLCBzZ2UtPmxhZGRyICsgd3FlLT5wcm9jZXNz
ZWQsDQo+IC0JCQkJIGJ5dGVzKTsNCj4gLQllbHNlDQo+IC0JCXJ2ID0gc2l3X3J4X3BibChzcngs
ICZmcngtPnBibF9pZHgsIG1lbV9wLA0KPiAtCQkJCXNnZS0+bGFkZHIgKyB3cWUtPnByb2Nlc3Nl
ZCwgYnl0ZXMpOw0KPiArCXJ2ID0gc2l3X3J4X2RhdGEobWVtX3AsIHNyeCwgJmZyeC0+cGJsX2lk
eCwNCj4gKwkJCSBzZ2UtPmxhZGRyICsgd3FlLT5wcm9jZXNzZWQsIGJ5dGVzKTsNCj4gIAlpZiAo
cnYgIT0gYnl0ZXMpIHsNCj4gIAkJd3FlLT53Y19zdGF0dXMgPSBTSVdfV0NfR0VORVJBTF9FUlI7
DQo+ICAJCXJ2ID0gLUVJTlZBTDsNCj4gLS0NCj4gMi4zNS4zDQpMb29rcyBnb29kLg0KDQpBY2tl
ZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
