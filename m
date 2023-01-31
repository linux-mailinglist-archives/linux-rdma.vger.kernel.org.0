Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143E682B1C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 12:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAaLGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 06:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjAaLGG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 06:06:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB63C12
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 03:06:01 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VAvoPm025085;
        Tue, 31 Jan 2023 11:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KLGSb/jU0WXn9K5KOoEYI8Zeu+PwHEg6NeOTLFGkuBs=;
 b=DR7/1ChB6CVyW9Tpwy5lPEEI8GLKnnHThD81/nAjeAmlEiYg6xaYiuUT4p0ofcr3GcfT
 qaKGYo9MZy5ZzWPV3pSjVPESpaJo86o4wfdglKOR1OzLacgWb2XS2drvw+U0P2t/7XAl
 Oua87drODUeE/LBxkeuj6QeeeD4Tt9I7+vF5T/DdI2m4U2k0Jy+em3rBut/Ik6n7ta2M
 uS1ovYUIwRaXYF6d7VT1BdsvkC4S/lgX3WPWxoQhfzbpAtsQoS+XFxoy6CrgLXohg+Se
 9gyB0QxXurJy7S3jx7oBAvlbu10uuZuGZkTz52VJUCU0cuqIXvC8cQTuiNmNXVs8QZgk kg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf1pu86ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 11:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kljn8dlDmdyHTtPuTq7o32lKINQH3UKy7VFe3aCWP4YySw53wuHRQ/LqypXHGuDXcO7Q2tfYgfgXvIiP/fyUvblG4cs1YVzH/ASfdXcA2RujNWi10axZqJn8HbwTDBtp7v1EvxU5tJXdzYcm4RC3RK3M3RlGRnJpIz3lT34p2X43GHDKshsLRqKaBc8miBnyAR1S4HPAUbl3Vd7iojE01Rmqsyueyh1FCZv0vQM3qS/NKTshMEPyAPbIrd29KR8borXMA9qbeuZdASZrKayG+LKzXDQ4sRzm4NFOPp3DIux1OUAcNKyS38/Hhq0NmRw0k5IkkTIMxX/Ka6U0D6UXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLGSb/jU0WXn9K5KOoEYI8Zeu+PwHEg6NeOTLFGkuBs=;
 b=IDmvwy9rYcqoG8dTOTd/g9GjNxDIi5aOTW4+2uYvnfoI6iZyYh0J6XUZA29zzIeVW+pOf9jYcUIDBYpmNAsevJyja30yrAu0bTBbC5O/4gTdDfU/VomW7UFidd/tbjbz98aMHnruPNOkqpLkh0fCfVlab+AjJLLyjIsJn3gPSlx+HFeVClST81T7OPfYVJcMWbapKJkZA691ggJDIKJ27OJxugzn5nrabi8n3APfiXNZFId5kHzTrzM5QsNRRzGVfM+2H70gYjq/dq5YIDEw3DsLmtw8do5PlmSX1dMI/vtRubCjgC2S78qR2I1sjA66+E3zIVUq8EV8uc5wobiN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DS0PR15MB5745.namprd15.prod.outlook.com (2603:10b6:8:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 11:05:57 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 11:05:57 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE:  Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Thread-Topic: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Thread-Index: AQHZNWP+ZMSqI8u3q0y42IrFqeP+TQ==
Date:   Tue, 31 Jan 2023 11:05:57 +0000
Message-ID: <SA0PR15MB3919E2F0F97368BF0069F4E499D09@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20230130133235.223440-1-bmt@zurich.ibm.com>
 <878rhjzhbg.fsf@nvidia.com>
In-Reply-To: <878rhjzhbg.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|DS0PR15MB5745:EE_
x-ms-office365-filtering-correlation-id: deb462e0-843a-40a5-8bda-08db037b214c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pe8k9+IXuLJViOYzMUuZVASzzUHK/Wk9vzxTCjGN48g44xAg1urVbJDyOuca8qDgt19FR/Nd9ey6rKzrTq2Ml789WhkR5Oz8QSPRsnGhqFChNQKy3fTwPwp8pTqHVE0nrX+b1EefGBwQtLMqqfKyjUMBtO5YI8Qx7rEwp2VQf15i0eL9hyTjsGJha6VoPzuZ3gPDYzEOLHnVY2wxDilQJzIaSKWVh/eX7vzzVF/I1Elhfam3E0u6Xx9zhO583EpkQlftElYKCDtaoe+mUipC66jChaAieYGbE4x3ldhtrjEGKmBDX99TCyUbiilxC2lz8bxVkLBHTK65LO/+zWDkyJd7KscvGoCWGAsjXJOs70oeheufuP7iJZ7XRHylqFP2EeNWAiX8SPws40EYm7PAPVAWsxLYX7GJwN5iye/UpxEL63W7oLXG1KnxCNYk34jkxuLStDtEB5yKzmoHwhh8JS+mw8I7GmAZalDZqNOMNQG7tuOUlXP6/GhbmK/A+O28m5g0LiqgnFQIN65W2RQoAHVV4h6uYPCIYvyWQl+kiLbJ0Mx8DtrdAV8MphasmAbXoA/cc7HWDnMiY8q6WbL2HSYpRETEsP04+tbxLqlfNr69AOp4Faz/D+1AXZLO+5Q3kmaek1jhG8Ns0tUS5R/Hl8unw4hD7aUbTpd1IKCmI+bUaJUSFkHl7OeR0GX/7gtGwl70H6JHeMwRi3nFpsEQog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(6916009)(66556008)(66946007)(66446008)(66476007)(64756008)(54906003)(316002)(8676002)(4326008)(76116006)(5660300002)(41300700001)(8936002)(52536014)(122000001)(38100700002)(86362001)(38070700005)(33656002)(6506007)(53546011)(186003)(9686003)(71200400001)(83380400001)(55016003)(2906002)(15650500001)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkpEVyswVi83WkpjRlg2US8rNVdQN054aFRibmgwU2VCSDYvZGRjQ1hmRlUv?=
 =?utf-8?B?Z1gyMmNPT1F2V1dsN3ZGQzcyOFhTd21nSGh3dWJXSFhqZm1EOGtDbTRrVDJJ?=
 =?utf-8?B?d1dDMVA4MnlPb0pCYXRsRm5NeGFpSjJqL3NwMktXaU1aeVBCS2ZTT0t6S1kx?=
 =?utf-8?B?TWVVVFdvRVc4T2pXb3JObEluTitnQWdrVXd0dUc0ZmRwL05jbGREVnJtK0Fl?=
 =?utf-8?B?VFNLaVgzb29sRkNRY3FCSDZSUXAreTVVUWJMeWMvdnlTcis1dGtDcGVlaFQ3?=
 =?utf-8?B?WThKUVVVZ09LUkQ3UHA4am95K0kzRDFVQXpoZDVpVHBCVCtRM2hYMC95VnE5?=
 =?utf-8?B?U3pHM3BSRTJyUmlFZWZDQlNtc3Uya0dWSTBFNTZNc0FuR1Nsd2doUDVvTEp1?=
 =?utf-8?B?RjdNbDhTV1l4YVNocXJMZmtOMHY0TWxFa0J1OVNVRkN6MXFTU2FUZndHb3U1?=
 =?utf-8?B?MkpWS21EbHhWK295VUJDdG9pWkVQNVNXUlVDcE5HNy9FQkN0NURmTUc0WFBM?=
 =?utf-8?B?SUFNaUQvbTU0THFKUjk3ZmlOMlh2NEhVbkZzNEpsbk16NFNOaDJNb0lCS1BZ?=
 =?utf-8?B?a1NTeHhQQnZRS0ZOTitaQ3BKMTE1Q3RvV21BS2RGeXZZcmdGdTV4M2FaZ0to?=
 =?utf-8?B?TzNtcmZjK0xmL1dGRjZlZFZrblhNRWlWLzhyT2NmNThlS242ZFR6QlVvaTNp?=
 =?utf-8?B?RnRBd04wUGZVeE9manVMei9tREtyMlcwdHhyQ2I1cDBqelNKUFBCSGR1ZDUr?=
 =?utf-8?B?d2Z1OXBNZzBEWSs2ZFJjUWI1cDlZeFNqVi9iYktLQVBxTVVNZHpUekx5ZXcx?=
 =?utf-8?B?SW5uMTEwSS9hWllvOFNENnJERXBKMmZJVm8zdUEraTdSOG42czFTMEx6K1Nu?=
 =?utf-8?B?OVI2cHdTMHZSdlVNN0l0bXppT0F6OGdSN2pCMmlybVhDYXJsYUU5MjB4MVVM?=
 =?utf-8?B?S3g4MXUyaVczSVA4TlhTTnprV0V6M20xVFM4cFdlaW5tRmpVYnJ2NEtDMjJP?=
 =?utf-8?B?L1k0dUJ3MjQySXM3RUlBT0duajFCeDQrUm42Nys5SEFZbTlWT3FTanhwSXNh?=
 =?utf-8?B?Y0taVWY1cGFXWEdzVmQ5L1hUaDIwZllTa3U3aU9LZVBmcGw3M3JBeVhaOUVN?=
 =?utf-8?B?ZzVHZzUyZGlvWE42OWFwTFRmckFnK0Jrcys3dDAvMmlLOVUzNnNIQkp5MTFh?=
 =?utf-8?B?dStqbFlIeVBNdGszdUxMaG05V0V5SG1BRmhwcXd0TGplMFBpd0NwejFhaE5C?=
 =?utf-8?B?amZOMTY3YU90YWNhSzBIdFdkM2ZuWlE0ZW9zK0E4QUl4cGs0Ymp4a3d3dzZt?=
 =?utf-8?B?TEJyVk1oTVBSY0N3NFZvbHRyUHlCNVFrVisxR3RhcDYrZlNhdEVIemxIVEdJ?=
 =?utf-8?B?blBhRzJWQTJuOHljYXo2b0NjckZEa1Y4R3hCOS9CVVYvSmJXVHFINWtUN2do?=
 =?utf-8?B?MFNvVytPR0JtVVFjbmNWL05BWlNJS1oycjBVRXJ0SUs1UzBwMnpSOEFLb1BO?=
 =?utf-8?B?QUNocGFRMjZDRzFnYmJ5ZE1aNSttZ2ZxUmk3b3ZKbnpjaTN2YzZPZzRrNm90?=
 =?utf-8?B?SFQ0TkFLaXYwblFVM1BVdFJFWW1LcitaanY1TStUeXd1dit4dDIvcEtBUXhh?=
 =?utf-8?B?eW0rQXlnRnpDSk5obGF5Zmd2QXp0Qzh6L1VyVzRzVmJ5dlBKelVMWHlEbHRl?=
 =?utf-8?B?alRMRW5ySldzVlBPZHRPRS9RM0ppVHRieVVvNDVMdFhEbWNXZ0t5cXU0UVZw?=
 =?utf-8?B?TVZMMmZuOGl6Tzh4ek03TElJR2Fxdnl1UkxSemd3TFN0NGp0a2pReGZ4clNn?=
 =?utf-8?B?Z1U0cnV1LzVsMmFrVmFDR2VvMVV2LzZCY0RONTRmU0hnNlVaQ2NaaVpvK1dv?=
 =?utf-8?B?dGhlY2xmMCtKQ2VjaThYMFhZM2ZjdVNRd1FGNEs3aFJFVHlCYlBuM2F5ZVcv?=
 =?utf-8?B?bGx2Tm1yWjl2U2lsUmpuYllBeC9mLzNqRkVUU1BoVm5wcTZRak5zaEdLWnhM?=
 =?utf-8?B?Z2psSzBSeWZKSmd5N1p2cmZ6S2tQRkRieTZRcTFJN0FqYkI2d25aNzAzcENt?=
 =?utf-8?B?d0NwN0hteVY4YU1QazM0MnYwOC9KSEdjbk9jeUdFNXZNV0R4Mkk0bHN4TmZz?=
 =?utf-8?B?K05xV3pUWS8rdFZnYXBuOVpUOEFPdGtDbjVNTXFKZ0FNZWFNd2lIY1ZXdDVx?=
 =?utf-8?Q?ghKWhRXcIX+8iwLLD16QKYQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb462e0-843a-40a5-8bda-08db037b214c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 11:05:57.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCfQeNmmkp6EryDxZH1MHlK5zMfQqfLQAR4O7WiNp3yda4Q5sX+INoWwjgqqChNR0FfHnqEUoWeyue/oQIwDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5745
X-Proofpoint-GUID: 0r5YqW33_iQN8llfu_9PpfIBe6Pl4rmv
X-Proofpoint-ORIG-GUID: 0r5YqW33_iQN8llfu_9PpfIBe6Pl4rmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_05,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxscore=0 mlxlogscore=954 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgUG9wcGxl
IDxhcG9wcGxlQG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDMxIEphbnVhcnkgMjAyMyAw
MTowOQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgamdnQG52aWRpYS5jb207IGxlb25yb0BudmlkaWEu
Y29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IEZpeCB1c2Vy
IHBhZ2UgcGlubmluZyBhY2NvdW50aW5nDQo+IA0KPiANCj4gQmVybmFyZCBNZXR6bGVyIDxibXRA
enVyaWNoLmlibS5jb20+IHdyaXRlczoNCj4gDQo+ID4gVG8gYXZvaWQgcmFjaW5nIHdpdGggb3Ro
ZXIgdXNlciBtZW1vcnkgcmVzZXJ2YXRpb25zLCBpbW1lZGlhdGVseQ0KPiA+IGFjY291bnQgZnVs
bCBhbW91bnQgb2YgcGFnZXMgdG8gYmUgcGlubmVkLg0KPiA+DQo+ID4gRml4ZXM6IDIyNTEzMzRk
Y2FjOSAoInJkbWEvc2l3OiBhcHBsaWNhdGlvbiBidWZmZXIgbWFuYWdlbWVudCIpDQo+ID4gUmVw
b3J0ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+ID4gU3VnZ2VzdGVk
LWJ5OiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMgfCA3ICsrKysrLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5jDQo+ID4gaW5kZXggYjJiMzNkZDNiNGZhLi43
YWZkYmUzZjIyNjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfbWVtLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0K
PiA+IEBAIC0zOTgsNyArMzk4LDcgQEAgc3RydWN0IHNpd191bWVtICpzaXdfdW1lbV9nZXQodTY0
IHN0YXJ0LCB1NjQgbGVuLA0KPiBib29sIHdyaXRhYmxlKQ0KPiA+DQo+ID4gIAltbG9ja19saW1p
dCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsNCj4gPg0KPiA+IC0JaWYg
KG51bV9wYWdlcyArIGF0b21pYzY0X3JlYWQoJm1tX3MtPnBpbm5lZF92bSkgPiBtbG9ja19saW1p
dCkgew0KPiA+ICsJaWYgKGF0b21pYzY0X2FkZF9yZXR1cm4obnVtX3BhZ2VzLCAmbW1fcy0+cGlu
bmVkX3ZtKSA+IG1sb2NrX2xpbWl0KSB7DQo+ID4gIAkJcnYgPSAtRU5PTUVNOw0KPiA+ICAJCWdv
dG8gb3V0X3NlbV91cDsNCj4gPiAgCX0NCj4gPiBAQCAtNDI5LDcgKzQyOSw2IEBAIHN0cnVjdCBz
aXdfdW1lbSAqc2l3X3VtZW1fZ2V0KHU2NCBzdGFydCwgdTY0IGxlbiwNCj4gYm9vbCB3cml0YWJs
ZSkNCj4gPiAgCQkJCWdvdG8gb3V0X3NlbV91cDsNCj4gPg0KPiA+ICAJCQl1bWVtLT5udW1fcGFn
ZXMgKz0gcnY7DQo+ID4gLQkJCWF0b21pYzY0X2FkZChydiwgJm1tX3MtPnBpbm5lZF92bSk7DQo+
ID4gIAkJCWZpcnN0X3BhZ2VfdmEgKz0gcnYgKiBQQUdFX1NJWkU7DQo+ID4gIAkJCW5lbnRzIC09
IHJ2Ow0KPiA+ICAJCQlnb3QgKz0gcnY7DQo+ID4gQEAgLTQ0Miw2ICs0NDEsMTAgQEAgc3RydWN0
IHNpd191bWVtICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiBib29sIHdyaXRh
YmxlKQ0KPiA+ICAJaWYgKHJ2ID4gMCkNCj4gPiAgCQlyZXR1cm4gdW1lbTsNCj4gPg0KPiA+ICsJ
LyogQWRqdXN0IGFjY291bnRpbmcgZm9yIHBhZ2VzIG5vdCBwaW5uZWQgKi8NCj4gPiArCWlmIChu
dW1fcGFnZXMpDQo+ID4gKwkJYXRvbWljNjRfc3ViKG51bV9wYWdlcywgJm1tX3MtPnBpbm5lZF92
bSk7DQo+ID4gKw0KPiA+ICAJc2l3X3VtZW1fcmVsZWFzZSh1bWVtLCBmYWxzZSk7DQo+IA0KPiBX
b24ndCB0aGlzIHVuYWNjb3VudCBzb21lIHBhZ2VzIHR3aWNlIGlmIHdlIGJhaWwgb3V0IG9mIHRo
aXMgbG9vcCBlYXJseToNCg0KDQpPaCB5ZXMgaXQgd291bGQuIE1hbnkgdGhhbmtzIGZvciBsb29r
aW5nIGNsb3NlIQ0KDQoNCj4gDQo+IAkJd2hpbGUgKG5lbnRzKSB7DQo+IAkJCXN0cnVjdCBwYWdl
ICoqcGxpc3QgPSAmdW1lbS0+cGFnZV9jaHVua1tpXS5wbGlzdFtnb3RdOw0KPiANCj4gCQkJcnYg
PSBwaW5fdXNlcl9wYWdlcyhmaXJzdF9wYWdlX3ZhLCBuZW50cywNCj4gCQkJCQkgICAgZm9sbF9m
bGFncyB8IEZPTExfTE9OR1RFUk0sDQo+IAkJCQkJICAgIHBsaXN0LCBOVUxMKTsNCj4gCQkJaWYg
KHJ2IDwgMCkNCj4gCQkJCWdvdG8gb3V0X3NlbV91cDsNCj4gDQo+IAkJCXVtZW0tPm51bV9wYWdl
cyArPSBydjsNCj4gCQkJZmlyc3RfcGFnZV92YSArPSBydiAqIFBBR0VfU0laRTsNCj4gCQkJbmVu
dHMgLT0gcnY7DQo+IAkJCWdvdCArPSBydjsNCj4gCQl9DQo+IAkJbnVtX3BhZ2VzIC09IGdvdDsN
Cj4gDQo+IEJlY2F1c2Ugc2l3X3VtZW1fcmVsZWFzZSgpIHdpbGwgc3VidHJhY3QgdW1lbS0+bnVt
X3BhZ2VzIGJ1dCBudW1fcGFnZXMNCj4gd29uJ3QgYWx3YXlzIGhhdmUgYmVlbiB1cGRhdGVkPyBM
b29rcyBsaWtlIHlvdSBjb3VsZCBqdXN0IHVwZGF0ZQ0KPiBudW1fcGFnZXMgaW4gdGhlIGlubmVy
IGxvb3AgYW5kIGVsaW1pbmF0ZSB0aGUgYGdvdGAgdmFyaWFibGUgcmlnaHQ/DQoNCkluZGVlZCwg
YnV0IHdlIGhhdmUgdG8gYWR2YW5jZSB0aGUgcGFnZSBsaXN0IHBvaW50ZXIgY29ycmVjdGx5LA0K
d2hpY2ggd2FzIGRvbmUgYnkgdGhpcyB2YXJpYWJsZSBiZWZvcmUuIERvZXMgdGhhdCBsb29rIGJl
dHRlcj8NCg0KTWFueSB0aGFua3MhDQpCZXJuYXJkLg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d19tZW0uYw0KaW5kZXggYjJiMzNkZDNiNGZhLi4wNTVmZWMwNWJlYmMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfbWVtLmMNCkBAIC0zOTgsNyArMzk4LDcgQEAgc3RydWN0IHNpd191bWVt
ICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVuLCBib29sIHdyaXRhYmxlKQ0KIA0KICAg
ICAgICBtbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsN
CiANCi0gICAgICAgaWYgKG51bV9wYWdlcyArIGF0b21pYzY0X3JlYWQoJm1tX3MtPnBpbm5lZF92
bSkgPiBtbG9ja19saW1pdCkgew0KKyAgICAgICBpZiAoYXRvbWljNjRfYWRkX3JldHVybihudW1f
cGFnZXMsICZtbV9zLT5waW5uZWRfdm0pID4gbWxvY2tfbGltaXQpIHsNCiAgICAgICAgICAgICAg
ICBydiA9IC1FTk9NRU07DQogICAgICAgICAgICAgICAgZ290byBvdXRfc2VtX3VwOw0KICAgICAg
ICB9DQpAQCAtNDExLDcgKzQxMSw4IEBAIHN0cnVjdCBzaXdfdW1lbSAqc2l3X3VtZW1fZ2V0KHU2
NCBzdGFydCwgdTY0IGxlbiwgYm9vbCB3cml0YWJsZSkNCiAgICAgICAgICAgICAgICBnb3RvIG91
dF9zZW1fdXA7DQogICAgICAgIH0NCiAgICAgICAgZm9yIChpID0gMDsgbnVtX3BhZ2VzOyBpKysp
IHsNCi0gICAgICAgICAgICAgICBpbnQgZ290LCBuZW50cyA9IG1pbl90KGludCwgbnVtX3BhZ2Vz
LCBQQUdFU19QRVJfQ0hVTkspOw0KKyAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICoqcGxpc3Q7
DQorICAgICAgICAgICAgICAgaW50IG5lbnRzID0gbWluX3QoaW50LCBudW1fcGFnZXMsIFBBR0VT
X1BFUl9DSFVOSyk7DQogDQogICAgICAgICAgICAgICAgdW1lbS0+cGFnZV9jaHVua1tpXS5wbGlz
dCA9DQogICAgICAgICAgICAgICAgICAgICAgICBrY2FsbG9jKG5lbnRzLCBzaXplb2Yoc3RydWN0
IHBhZ2UgKiksIEdGUF9LRVJORUwpOw0KQEAgLTQxOSwyMiArNDIwLDE5IEBAIHN0cnVjdCBzaXdf
dW1lbSAqc2l3X3VtZW1fZ2V0KHU2NCBzdGFydCwgdTY0IGxlbiwgYm9vbCB3cml0YWJsZSkNCiAg
ICAgICAgICAgICAgICAgICAgICAgIHJ2ID0gLUVOT01FTTsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gb3V0X3NlbV91cDsNCiAgICAgICAgICAgICAgICB9DQotICAgICAgICAgICAgICAg
Z290ID0gMDsNCisgICAgICAgICAgICAgICBwbGlzdCA9ICZ1bWVtLT5wYWdlX2NodW5rW2ldLnBs
aXN0WzBdOw0KICAgICAgICAgICAgICAgIHdoaWxlIChuZW50cykgew0KLSAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IHBhZ2UgKipwbGlzdCA9ICZ1bWVtLT5wYWdlX2NodW5rW2ldLnBsaXN0
W2dvdF07DQotDQogICAgICAgICAgICAgICAgICAgICAgICBydiA9IHBpbl91c2VyX3BhZ2VzKGZp
cnN0X3BhZ2VfdmEsIG5lbnRzLCBmb2xsX2ZsYWdzLA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwbGlzdCwgTlVMTCk7DQogICAgICAgICAgICAgICAgICAgICAg
ICBpZiAocnYgPCAwKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9z
ZW1fdXA7DQogDQogICAgICAgICAgICAgICAgICAgICAgICB1bWVtLT5udW1fcGFnZXMgKz0gcnY7
DQotICAgICAgICAgICAgICAgICAgICAgICBhdG9taWM2NF9hZGQocnYsICZtbV9zLT5waW5uZWRf
dm0pOw0KICAgICAgICAgICAgICAgICAgICAgICAgZmlyc3RfcGFnZV92YSArPSBydiAqIFBBR0Vf
U0laRTsNCisgICAgICAgICAgICAgICAgICAgICAgIHBsaXN0ICs9IHJ2Ow0KICAgICAgICAgICAg
ICAgICAgICAgICAgbmVudHMgLT0gcnY7DQotICAgICAgICAgICAgICAgICAgICAgICBnb3QgKz0g
cnY7DQorICAgICAgICAgICAgICAgICAgICAgICBudW1fcGFnZXMgLT0gcnY7DQogICAgICAgICAg
ICAgICAgfQ0KLSAgICAgICAgICAgICAgIG51bV9wYWdlcyAtPSBnb3Q7DQogICAgICAgIH0NCiBv
dXRfc2VtX3VwOg0KICAgICAgICBtbWFwX3JlYWRfdW5sb2NrKG1tX3MpOw0KQEAgLTQ0Miw2ICs0
NDAsMTAgQEAgc3RydWN0IHNpd191bWVtICpzaXdfdW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVu
LCBib29sIHdyaXRhYmxlKQ0KICAgICAgICBpZiAocnYgPiAwKQ0KICAgICAgICAgICAgICAgIHJl
dHVybiB1bWVtOw0KIA0KKyAgICAgICAvKiBBZGp1c3QgYWNjb3VudGluZyBmb3IgcGFnZXMgbm90
IHBpbm5lZCAqLw0KKyAgICAgICBpZiAobnVtX3BhZ2VzKQ0KKyAgICAgICAgICAgICAgIGF0b21p
YzY0X3N1YihudW1fcGFnZXMsICZtbV9zLT5waW5uZWRfdm0pOw0KKw0KICAgICAgICBzaXdfdW1l
bV9yZWxlYXNlKHVtZW0sIGZhbHNlKTsNCiANCiAgICAgICAgcmV0dXJuIEVSUl9QVFIocnYpOw0K
DQoNCg0K
