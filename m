Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23A5AD206
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIEMCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiIEMCo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:02:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FAD5D0D9
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:02:42 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285Bfhw5003072;
        Mon, 5 Sep 2022 12:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=dflSAabbF+1YmG2Yb4wo2edHUGA0QWL7vOv+DpVmyv8=;
 b=I08mXr3E+EM0Z4Y4hsmqYHV/e+pu4qm4VAkhr3rvOQ8IGXJENo2Eh0MNBWKxf4SsqTnh
 UWjWbP5odOYIZqBxWqRIEmGq7hkdb6Di0q0S2svnSJAhhslMX+dqgnIGt2TLVjpQzw1V
 /h9cZiY1S58auzAJmsBoGw4eCJaWIldNwQrkkBfqoIMC/1Uyg7Iq58JWNHBi6cfEu1iY
 Sx7VSlh2IMkCxc+0X+aWKnoigk48eZgbUXma503S64EaV/aVffG37zItr2Du6m9loNj4
 iCMnFs03kOSROKqZPCzpI4xXpxZ+hkndQTIFaICKlTaIuHVvZ6/oO9ArJJxYPPPOv0pj wg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdgfarkcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 12:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAFwEBVZ0Ou4pkt0BzFjRv1lRwzu/9uPMROI/TRgSRkrRyBPvBUl+kyBYP2vvRwPfftO4dQnGUQwiIHd96/7Tox6Zoj0FWuRPmg86j4t8bOewSfqqCcEEU9QOMSeQg9lm+trWEExzSDckmww5RmuSwty/uLHvoN+pP5pxw5b/grlfJPKYqih33Ynxd5Vpa2xCRTwzLom2aDQcxXZjcW4oRtpiMCP71lQ/cLRfpZHn3oYxEW5Rlasm8oD4FTvFyzC7oyn6sccCInAY4aO9MlwMR7lng17by0McQeG57nJKv4zgEHQRdqq6cJwu0XOXfdypREf+Fc7bCLi4axz0IVkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dflSAabbF+1YmG2Yb4wo2edHUGA0QWL7vOv+DpVmyv8=;
 b=M1LbuakfwTq1zo3s4yYck7sF2iJJPs/d2H1sVs7h+9ohOIQBr+19VI2Ph2fg/tpcyslY8lWHzmYX1LGCDqfNH/Mkd39TWQ+M2k+lDIlQxtpfypC0M4l5XJSf08d+Zp00ja/9L6DXyQ0gRRjpjbkGuvX87Hpj2NUTOe3F/tTpib6R/vlZm5nLu7Dp5Vipku10EZ81zpbMgNAc3dZn61ARQmlK9jre7Nw01tqnEiMOJFbsTBigcsP2HJo2vN4rZS22b8qFVaErlYuVDQiFnKDq/XIU3jkMyqVHlohIOnwRaKbrKvyI2kLTDuBx1HBBe81sT7fPDTJZj6t6Yk0Mo86MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH0PR15MB5167.namprd15.prod.outlook.com (2603:10b6:510:140::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Mon, 5 Sep
 2022 12:02:38 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Mon, 5 Sep 2022
 12:02:38 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leonro@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Topic: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Index: AdjBHvfym2KWkwaPQ2SxP9SoMnMS0Q==
Date:   Mon, 5 Sep 2022 12:02:38 +0000
Message-ID: <SA0PR15MB3919314166F86C36B564961E997F9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3a741b-2966-4aae-7167-08da8f368724
x-ms-traffictypediagnostic: PH0PR15MB5167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyGOvprxoXIQlFQLrdnae7jsJk5g4TIQJLKSnOFSyTChGF4BmNtQmsn73oe9acgmsQflINN6Fz9hbQmhVVjBSJLKyQI1gfsFRNTE04l/za8EukxdIm10lo217lpPuKhlcVc3rTI+5yU1Fc6/WMOydj3Z560sR770XYevI+ieoEoWa92b1s1KUl4dg9PgHAwfW6nc36D9q/a1k4fCHP/AMpwn6j9SRTuBHLitHFu1n7UhBFN7k7nM+eHvAAo8gDb1oDE9enSsuZfR4WHFs4q7v8smRsp7aDFwn2s0GThC4pBuN9bOY3S6vV3kRIlJ52wDDWPvsNUJPeIUvhPQLrd5mQ9taDXDJBfOlFHw28TBTej9N1cDyLbH4X3hKnsAaF6eWwyWefVK+5gw6xQ9nbA6MRMrsXry41hGjejdJMCBspd1lO5oG0LaKghMl5xfBWDAUDrro8sBPdX8Wgh8wpGmb9Mr5X8tdZ+Shg9BcfiirTDnsdAhipnH3BQK3I2wYwpHi95n3MSXx5ba12DLMRwR+frfhvKKwy1UW/rLeGWuGIXrYn8N5VRkMx2SmQIDgnv3OWK8PRc1o9LVFwTk3tNOyf8/rf/KxsQFPiJur6/enpD7hZXTKv9m4zle8suJhPn1RUlv8SJ1yEpmktWlkiOrduYX9ieVV6jUk3lPyavC8xEpvDp53+Gp6FqrWgxTsyFXqCvyEn0HsbVuDDVimiYv0oicU3A2pMXTAYrOd8md5DOHgtKmoZNv9pO61gvEIx39oJjuNkerxmUIWhMS3v0hWLOLP5hMUhQ59UMyveQFGfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(366004)(346002)(396003)(83380400001)(38070700005)(122000001)(66556008)(316002)(66946007)(55016003)(76116006)(110136005)(54906003)(64756008)(66476007)(38100700002)(66446008)(2906002)(8676002)(4326008)(5660300002)(53546011)(8936002)(52536014)(9686003)(186003)(6506007)(71200400001)(478600001)(41300700001)(7696005)(33656002)(86362001)(266184004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhucjF2VmdaZ3h3R3daUk1QclZrVUtodWNkTDVYWkd6TTVSZmhxa1B4Q1Av?=
 =?utf-8?B?NjYxRmF2bzhhRGtUUjJGS0tIeVNmQWkxK3RpdVk5ajMvdEhOeldITTMwY3hq?=
 =?utf-8?B?L1ZDZVBEWXNFbEdWTGJwMm9LQXhkQ2FnMGt0WjFNVjNpeEtKdk9EUXZIaFZQ?=
 =?utf-8?B?aVZxaHR0LzBqUGN1Z3NsK0JVcXFWYXAxVFFmd0MwSkRlVU1uNGYwQ0lKMzRv?=
 =?utf-8?B?Y3UxYk1DUE1yalZ6M1BMbkE4Snh2M2FWUXQ1emFCeGQ3ZnN4NFVuYmtHVUk3?=
 =?utf-8?B?VXZ1UDFHaWFCcTlYVXJOMDJIQmU2RExpR0xkZk96MXorWkEvL2hLS0FQOW9S?=
 =?utf-8?B?dnA4ckN0bGlMYUtVdnpRWXZMWE5NYlNYdDh5S0syQlVmenArbGpSaUZlb0tZ?=
 =?utf-8?B?eFRqZjBaZjZhOTZOeG9xdlpWUHlFQjJFSkRNd2pWNUpkTmJxV01LN0dhQWlL?=
 =?utf-8?B?R2NmTmdTVTRqSU5vVjY1dVVBSlgvTHlUeUFvWFB6ZDlORjFTQ1JlMjVXelpv?=
 =?utf-8?B?WVMzaEg3bDNBVk9LT2x6c0x1VVBwSStvSWVFVGVPK2ZNN3lNTERYMnZVWmR4?=
 =?utf-8?B?M25QTklKcGxnNTExVTJLZit2OVhBQjB0OFZKZkJWaHN3bEU0UVlmZzZoZjZM?=
 =?utf-8?B?T1F3UUhFeXA5UVo5aWhCU1hFc1JkSWdWMml1L2NqZndLa1NHQnkyZEtYcWxN?=
 =?utf-8?B?aUlEWXNHSVdGMExSV0NlbERXdFJaVUsvb1o4Zitsd2VaSFUrWmZKcVlLNEZ5?=
 =?utf-8?B?d21wVjh5VzZ2VmtFRGpNMTlWOUpjYXhZcFFwYXVGZHVPSG5pRzZ5cS9OZzYw?=
 =?utf-8?B?eTlrTkROalVMd2NwVFB3cm8xT1Nvb3FmMk9LeXVJdEJRellZY3VlNzFKc3p6?=
 =?utf-8?B?MnMzVXMxb1lKWkFNQS84S29rOWp3YmxIN0hCY0FXbW5lWUZlZldPd2gwOU92?=
 =?utf-8?B?Yi9NYk1aa2xZclU3aGxMOVhlUmZhVE5SUXlUcjN2YTM2Q2ltaVdzYURWTGNW?=
 =?utf-8?B?VzFCYVV2SzkrOVJ6RkZVT3VreWNZVUlJb0pGc3IvQTlVZ2Q1MTlxSFl2N1ky?=
 =?utf-8?B?YmJ2aExMdE1GRFB2eGRPODkvSURsc1FBa3RnWUpvbFlteEZURkpjb05IMjNm?=
 =?utf-8?B?WWljV3ZZTVIrLzUwM0FaTnk2dmNBWlN2QUpsN0pOYmhCWng2bEhQbzVSSzly?=
 =?utf-8?B?SktuL3ZJSFJ0SFZKNmVqWWV2bEZoR0xpWGdWbUg2SzRTQXNpaGh1OTZmSmVW?=
 =?utf-8?B?VzIzcEFIaGM4NThBZnozaERjOEZyNnA0STRnSXpyZU5aZVlDa0NDY1c3M0Ew?=
 =?utf-8?B?Rm1BTDFFc1UrL2hWYnRsZ08xMWhuUXRkdEdNRWppdmdPM1FUcm9DVS9MSGU2?=
 =?utf-8?B?VDJJYk9PRmFaRmlqdE1QTVU3V3pMNUtUdVd3SGlnNXQ4THk4L3dpSktHUTlO?=
 =?utf-8?B?MHlMZG5UMEplam1QRDBOS0FHNTFnOXI5YnlLbGc2SHJRaE00TTlsTXRFMVlj?=
 =?utf-8?B?L0NHZEpxRjkyWWd2YXR2bXBxOU1QeHF4NmZXOWRGSWlrdWVDSDJHaHljcmFy?=
 =?utf-8?B?TnRDN0hNTU9XdmpEQjV5b1hQUzBXdENyQUJrUHYyN3AvU0gyQThtMjg0Yll0?=
 =?utf-8?B?UFJqMHR4MldLQk9SalIySXIrdnArZUpWenJiSnNXd3UrV29Ga3owUkVOUnFw?=
 =?utf-8?B?eS9EQUJwQVVFTmFNb2M0UFVFc3NqQnA0OTdmNUFEdloyenFTUnRFNVZTbjJp?=
 =?utf-8?B?UzhxR2MxWU0yRGVhMzJTVTVjQkk4bmVkZzNJc2ZqNWZxQjVjbldHdkE1Wkh0?=
 =?utf-8?B?TVhZYTJtTURTRHNGOWwrM25FYkwzSEhHSGczS0kvb1g4cFN5ZEFaOS84a0NH?=
 =?utf-8?B?VFVBOTMyT01zK3hDSkJGTHB3cUVBK3p4T3FiRDVzRE55M09RMmpGaStwTGZG?=
 =?utf-8?B?ekhWRWljVkk5WGszeHZ3dW9GYmFVMmIrUmNqVHZNZ2lUQ2VxaHFaRGhsRFpm?=
 =?utf-8?B?VDFyeUlHMlpBWk9YQWxuYWdCeTgzYUZOSjFaK1RvRWVrbHFMVW5KeGtNT3hk?=
 =?utf-8?B?eC90N0FIRGNxL0lXTHAwZ2FPVklROGEvTUo1aTBrdGlteEFVNmUyNWZOaTJo?=
 =?utf-8?B?Rm9iZnF0azJCejJlSkFZYjByQkRPYVo2OUxkTmdxaHl1MElxZmpOK1dtTElq?=
 =?utf-8?Q?0Mm5OQSVgb6R2Q7/xrB6mT8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3a741b-2966-4aae-7167-08da8f368724
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:02:38.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0ne5oniKVEYKRzXvnLHKdbOrFdMK0ob/NVTOpu4he6BenMQF405wbyZhtdXj8hweD/cgDytTaWdxP/MpSsMmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5167
X-Proofpoint-GUID: eguUSccuiEb_VcOc-ruTjp8Dz_eR1hj0
X-Proofpoint-ORIG-GUID: eguUSccuiEb_VcOc-ruTjp8Dz_eR1hj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_08,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4gU2VudDogU3VuZGF5LCA0IFNlcHRlbWJlciAyMDIyIDA5
OjIzDQo+IFRvOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IENj
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgQmVybmFyZCBNZXR6bGVyDQo+IDxC
TVRAenVyaWNoLmlibS5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjNdIFJETUEvc2l3OiBQYXNzIGEgcG9pbnRlciB0bw0K
PiB2aXJ0X3RvX3BhZ2UoKQ0KPiANCj4gT24gRnJpLCBTZXAgMDIsIDIwMjIgYXQgMTE6NTk6MThQ
TSArMDIwMCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gPiBGdW5jdGlvbnMgdGhhdCB3b3JrIG9u
IGEgcG9pbnRlciB0byB2aXJ0dWFsIG1lbW9yeSBzdWNoIGFzDQo+ID4gdmlydF90b19wZm4oKSBh
bmQgdXNlcnMgb2YgdGhhdCBmdW5jdGlvbiBzdWNoIGFzDQo+ID4gdmlydF90b19wYWdlKCkgYXJl
IHN1cHBvc2VkIHRvIHBhc3MgYSBwb2ludGVyIHRvIHZpcnR1YWwNCj4gPiBtZW1vcnksIGlkZWFs
bHkgYSAodm9pZCAqKSBvciBvdGhlciBwb2ludGVyLiBIb3dldmVyIHNpbmNlDQo+ID4gbWFueSBh
cmNoaXRlY3R1cmVzIGltcGxlbWVudCB2aXJ0X3RvX3BmbigpIGFzIGEgbWFjcm8sDQo+ID4gdGhp
cyBmdW5jdGlvbiBiZWNvbWVzIHBvbHltb3JwaGljIGFuZCBhY2NlcHRzIGJvdGggYQ0KPiA+ICh1
bnNpZ25lZCBsb25nKSBhbmQgYSAodm9pZCAqKS4NCj4gPg0KPiA+IElmIHdlIGluc3RlYWQgaW1w
bGVtZW50IGEgcHJvcGVyIHZpcnRfdG9fcGZuKHZvaWQgKmFkZHIpDQo+ID4gZnVuY3Rpb24gdGhl
IGZvbGxvd2luZyBoYXBwZW5zIChvY2N1cnJlZCBvbiBhcmNoL2FybSk6DQo+ID4NCj4gPiBkcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jOjMyOjIzOiB3YXJuaW5nOiBpbmNvbXBh
dGlibGUNCj4gPiAgIGludGVnZXIgdG8gcG9pbnRlciBjb252ZXJzaW9uIHBhc3NpbmcgJ2RtYV9h
ZGRyX3QnIChha2EgJ3Vuc2lnbmVkDQo+IGludCcpDQo+ID4gICB0byBwYXJhbWV0ZXIgb2YgdHlw
ZSAnY29uc3Qgdm9pZCAqJyBbLVdpbnQtY29udmVyc2lvbl0NCj4gPiBkcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF90eC5jOjMyOjM3OiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50DQo+
ID4gICAxIG9mICd2aXJ0X3RvX3BmbicgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91
dCBhIGNhc3QNCj4gPiAgIFstV2ludC1jb252ZXJzaW9uXQ0KPiA+IGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3R4LmM6NTM4OjM2OiB3YXJuaW5nOiBpbmNvbXBhdGlibGUNCj4gPiAg
IGludGVnZXIgdG8gcG9pbnRlciBjb252ZXJzaW9uIHBhc3NpbmcgJ3Vuc2lnbmVkIGxvbmcgbG9u
ZycNCj4gPiAgIHRvIHBhcmFtZXRlciBvZiB0eXBlICdjb25zdCB2b2lkIConIFstV2ludC1jb252
ZXJzaW9uXQ0KPiA+DQo+ID4gRml4IHRoaXMgd2l0aCBhbiBleHBsaWNpdCBjYXN0LiBJbiBvbmUg
Y2FzZSB3aGVyZSB0aGUgU0lXDQo+ID4gU0dFIHVzZXMgYW4gdW5hbGlnbmVkIHU2NCB3ZSBuZWVk
IGEgZG91YmxlIGNhc3QgbW9kaWZ5aW5nIHRoZQ0KPiA+IHZpcnR1YWwgYWRkcmVzcyAodmEpIHRv
IGEgcGxhdGZvcm0tc3BlY2lmaWMgdWludHB0cl90IGJlZm9yZQ0KPiA+IGNhc3RpbmcgdG8gYSAo
dm9pZCAqKS4NCj4gPg0KPiA+IEZpeGVzOiBiOWJlNmYxOGNmOWUgKCJyZG1hL3NpdzogdHJhbnNt
aXQgcGF0aCIpDQo+ID4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVk
LW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZUxvZyB2Mi0+djM6DQo+ID4gLSBBZGQgRml4ZXM6IHRhZy4NCj4gPiBDaGFu
Z2VMb2cgdjEtPnYyOg0KPiA+IC0gQ2hhbmdlIHRoZSBsb2NhbCB2YSB2YXJpYWJsZSB0byBiZSB1
aW50cHRyX3QsIGF2b2lkaW5nDQo+ID4gICBkb3VibGUgY2FzdHMgaW4gdHdvIHNwb3RzLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIHwgMTggKysr
KysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBUaGFua3MsIGFwcGxpZWQuDQoNClRoYW5rcyBMaW51
cywgdGhhbmtzIExlb24uIEkgbG9va2VkIGF0IHRoaXMgb25seSB0b2RheS4NCg0KQ2FuIHdlIGVh
c2lseSBmaXggdGhlIHR3byBsaW5lIHdyYXBzIGludHJvZHVjZWQgYnkgdGhpcw0KcGF0Y2g/IFdp
dGhvdXQgc2VuZGluZyBhbiBleHBsaWNpdCBwYXRjaCBvbiB0b3AgLS0gSSdkDQpzdWdnZXN0IGFk
ZGluZyBqdXN0IHR3byBsaW5lIGJyZWFrcyB0byBpdC4gSSdkIGJlIGhhcHB5DQp0byBzZWUgc2l3
IGNvZGUgY29udGludWVzIHRvIGFkaGVyZSB0byB0aGUgODAgY2hhcidzDQpwZXIgbGluZSBzdHls
ZS4NCg0KVGhhbmtzIHZlcnkgbXVjaCENCkJlcm5hcmQuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfdHguYw0KaW5kZXggN2Q0N2I1MjEwNzBiLi4wMDEzN2RkMDIyM2MgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQorKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQpAQCAtNTM3LDcgKzUzNyw4IEBAIHN0YXRp
YyBpbnQgc2l3X3R4X2hkdChzdHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LCBzdHJ1Y3Qgc29ja2V0
ICpzKQ0KCQkJCQkgKiBDYXN0IHRvIGFuIHVpbnRwdHJfdCB0byBwcmVzZXJ2ZSBhbGwgNjQgYml0
cw0KCQkJCQkgKiBpbiBzZ2UtPmxhZGRyLg0KCQkJCQkgKi8NCi0JCQkJCXVpbnRwdHJfdCB2YSA9
ICh1aW50cHRyX3QpKHNnZS0+bGFkZHIgKyBzZ2Vfb2ZmKTsNCisJCQkJCXVpbnRwdHJfdCB2YSA9
DQorCQkJCQkJKHVpbnRwdHJfdCkoc2dlLT5sYWRkciArIHNnZV9vZmYpOw0KIA0KCQkJCQkvKg0K
CQkJCQkgKiB2aXJ0X3RvX3BhZ2UoKSB0YWtlcyBhICh2b2lkICopIHBvaW50ZXINCkBAIC01NDUs
NyArNTQ2LDggQEAgc3RhdGljIGludCBzaXdfdHhfaGR0KHN0cnVjdCBzaXdfaXdhcnBfdHggKmNf
dHgsIHN0cnVjdCBzb2NrZXQgKnMpDQoJCQkJCSAqIGJpdHMgb24gYSA2NCBiaXQgcGxhdGZvcm0g
YW5kIDMyIGJpdHMgb24gYQ0KCQkJCQkgKiAzMiBiaXQgcGxhdGZvcm0uDQoJCQkJCSAqLw0KLQkJ
CQkJcGFnZV9hcnJheVtzZWddID0gdmlydF90b19wYWdlKCh2b2lkICopKHZhICYgUEFHRV9NQVNL
KSk7DQorCQkJCQlwYWdlX2FycmF5W3NlZ10gPQ0KKwkJCQkJCXZpcnRfdG9fcGFnZSgodm9pZCAq
KSh2YSAmIFBBR0VfTUFTSykpOw0KCQkJCQlpZiAoZG9fY3JjKQ0KCQkJCQkJY3J5cHRvX3NoYXNo
X3VwZGF0ZSgNCgkJCQkJCQljX3R4LT5tcGFfY3JjX2hkLA0KDQo=
