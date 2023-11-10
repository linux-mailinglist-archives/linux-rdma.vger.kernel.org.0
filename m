Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D007E80C4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Nov 2023 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbjKJSRb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Nov 2023 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbjKJSQr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Nov 2023 13:16:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41A3A228
        for <linux-rdma@vger.kernel.org>; Fri, 10 Nov 2023 07:09:20 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAF1SDS000492;
        Fri, 10 Nov 2023 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lQci2J1nyH+t+87/qTrxZHRqPWw4qmMPcT8Cih91atM=;
 b=gszK+MtQUSMCqL3e6pW+6BDl8UgtRhtYlEIGpSGvmuLlZlcccSSbmaOFjKoZk3zBDPh/
 WncCRT7Mon++Ppea7i+hKjB/LKvMcw32hendGG2doVIHIvysPCQ2YzKcbpjJP4/j3bvh
 doirPFYXab/f89qU8Qhl+aw09reUbC9caWhDvdcZsbz/nhDwVJWUy7vyrZfs3REVrRUD
 Fnd+BuRCpbYhjhlFbh76Jc4cYUeS7E2gDaOP3sNfGxkAAkXYju6Oe8uyuHB6LAAa3hlI
 UnxMWrCQgi86SBpl6fQN2pEVA63RDvZt+Qjy8dKVyedICNSZMdlHYle7G4o1rZsSLF+h Rw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9ph4gq5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 15:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REYYYghWuC2baeYSS2BcKl6i6iDi7SqjBH6DNJnUiTw99eyXjOJLktkSCVZmlFob7gbBoEWznT4Bg6k6atL1proEWy9Q+fGre72epclCt2GWsn8maRp5ucCYuCSQGVlecJ8+Nv6NdrBzfT5UNAx84CeWBPIAF1cV3BXkHwCM/Vqk2654kvvEsjLetPlSAI5oIkyB4MqAJCK3wZ3arxsqKSM8qOuFzHCV1h+eCFWZ4qOGR13D0ssdfMdiszuqmsmctBQRpOjRb1vM431UZJeKsUc28JjfNZ2HJfnAiN6pShc0Bs1cceqX5h/Tr2LrHEB7AzYei7EcvLl32m1uTW01Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQci2J1nyH+t+87/qTrxZHRqPWw4qmMPcT8Cih91atM=;
 b=NTVCuh/ptak6R5COL6Ge68e1xMmsei8PTRQDRbJI0OxWSCotSu7D3n/tPwQPDbiohQHBxH34uLzNwu0H+XmhDjpw12R3KiVo+1+IYQhrQdFHNRg3niKCKvNr2rWOU0q724LUfgz8DHy3xsdH4qGY5owi5qTf8S/rJOtZEnbFZu5kmHbFmfF1OZpXuDUENo8ECPbTgI4NYRckXBCia9Mhx5wi2thC8FLRyz/Fh65n7DlazpFZp+I/jERJZ0jlH3/FdikqqXnzdPYVV9QUVxnVg1K+zSLaiqtX1eNKClUqgYwMAvrrBv29buiexZHgewIQ7HuDKVmHcHYf2EEWo0qWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SA3PR15MB5630.namprd15.prod.outlook.com (2603:10b6:806:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 10 Nov
 2023 15:09:07 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 15:09:07 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "max7255@meta.com" <max7255@meta.com>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: Re: [PATCH for-next v2] RDMA/siw: Use ib_umem_get() to pin user
 pages
Thread-Topic: Re: [PATCH for-next v2] RDMA/siw: Use ib_umem_get() to pin user
 pages
Thread-Index: AQHaE+fZBMlwI8zJR0qTz35bneIuVw==
Date:   Fri, 10 Nov 2023 15:09:07 +0000
Message-ID: <BY5PR15MB360228A45CA3B76A32A6962999AEA@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231104075643.195186-1-bmt@zurich.ibm.com>
 <e606de53-b22f-f347-a71e-7b8a3cfb915a@linux.dev>
In-Reply-To: <e606de53-b22f-f347-a71e-7b8a3cfb915a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SA3PR15MB5630:EE_
x-ms-office365-filtering-correlation-id: ec1abc7c-150c-4783-d24c-08dbe1fefc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tprxoX2aGE+dgRSurojJ+xYn/FI9aZNJWFjI6c68TN5SflyFx2O+ajrN6ek4lE81Iv7Noib5nVTsjoTUBgOOlGAAlaCjA5C1veGdhdrg09WakZRDNyRiNOjSdba8Hb7byZN85nIOq7aS9Z78jAkW2alIba2behup/OH7ovzpt9yN3VrV09yFbdXX63aTAOQPggHflA0TRTVDWIJWFyntSwQYeqxXTuXAAhdAfBPWnB314ZabAnIED9O5l2Xnq8PtVxUM5MG0DAGe/3add/cnbFIGbUmt0c4RdI90dpF6mdl7SqxFkxcr5nRYm1p9qOtftk4pogZLo9ufEuEnrAFl/Fr6XRUo2MlXzwYLLQ0jbrlPqQGVdsOh7nu3FI1i4RgG3F1TKaEqaVUzXA+Q76Xh9Cl0fsOaluXe/c6XRnCuwhgMFFyXG5rwHfbPKkQjYvImtpBbNbzDJmoPP4TAfuW6RBR4bA5axjUkRhKMTrHo+tN37ul/WK5PqgHpkLaoCBUcqBbztH3Rl49naBmDYXmwD1La5l1ihqvHIqi9/+/X4zwpFhPff7HKMOHvb07/exIMYOcASUFaJppVf0b2Urb6Se95/0HscINPyWuXsbPbVCZ6vIixkKDoUnVUPEkIOmn/LeZZWe/LUa0VF1cueTHZ2AKGuC+aBfI2FaXvVLDssg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(66556008)(55016003)(7696005)(38070700009)(83380400001)(9686003)(2906002)(86362001)(5660300002)(33656002)(66946007)(52536014)(122000001)(71200400001)(54906003)(53546011)(4326008)(8676002)(66446008)(66476007)(6506007)(110136005)(316002)(38100700002)(478600001)(41300700001)(8936002)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEk2OHhuVTQ1aUtqdTRQMEoyVzdNYVJ6ODRnSzI5OUUwRmNaS0FyWHR6YUty?=
 =?utf-8?B?NWM1bVZoN1hJSVdIM2lBSXNjQWVnc3NOcjBjREdkVzVyRjd3d082NmkyanI0?=
 =?utf-8?B?aDdRWTcxNzdFMk50Z1BQbkI1RmJ2S2VJOVczTUVOMndkQUdQU0NVQlg3bDZw?=
 =?utf-8?B?d0xuLzdoQWpXRzdFTllZbUUwTS9BK0ZRL2U3MkdRL3hjdVEvc2E1QWxRWWtx?=
 =?utf-8?B?YTg4R094OTZtTGNSYU1FWm9NNDllWTlFM2Q2Wi9mNHp5ZlpqbVVJc0M5MUV6?=
 =?utf-8?B?K2lvcEx5c2p1OFMyVVpWQXBrNFpHamxiK2Y4bHpDdzg0MUxLY29aNE5JSDhu?=
 =?utf-8?B?bUh5MkpEdS90R1dYd3JCRU1wYVptQmZQVlowN0M5MERUUHV1WVB0b3RUUkJI?=
 =?utf-8?B?ZDBxaUZYenhFTHhXOXNuNGdOcXA4OC8vYUplQjJVK21MY1BZTnRkY0JVN01n?=
 =?utf-8?B?dmJxeGZNV1V3bXpIRUFESXMrZmxKQ24wN3pLeVdvZUhEMjZqRDYrbmRud2tn?=
 =?utf-8?B?a1M4T3U3T1Bta2xWME9HZms4MlljaWhhTEhmTTdjQ1dkOTZ0VDNVcThtNVNQ?=
 =?utf-8?B?ZHBCYU50bWZEVndsaUxSellISnZtQnRJOEVYUVNSL1RxbGRQVTkyQXB2OGpX?=
 =?utf-8?B?QlhjRUZXYTI5S2RWalJwbmovanJmT1J3bEQ4YlBad2FKa2Z2S2pVa0huM1ZX?=
 =?utf-8?B?ZFN2OE0rRDg2TFF3T1Y0SGZIanZlZ3I5VTFXQk9ONW9rMGhyQkhaM1RySThm?=
 =?utf-8?B?enRNUmdaTjVnT2NLdUQwbkdQaE9RaFFoTHZyRVdSRktWNTl5Mm9ORHc0R3BD?=
 =?utf-8?B?TVlYSEgrLy9PdVE1Vk5XTlRNOGs1NVJIUXJ0ckgxaDY3aWpzTkx2WDNaTjIr?=
 =?utf-8?B?OWYwZWpISFVFd1MyK2djZGdZMHBXSUhuQWVXdDNHRjdtTktjL0w1aXA5YWd4?=
 =?utf-8?B?RHNCTWxOL1hONkRDQUtVdmFSYjgrcW5tMSs5aG5xZjIrVXhqTEgxalRXbU4y?=
 =?utf-8?B?cU1IMDQ2VUZVck50SmY0L1FQOWZhZm0xUnBabTRsOFQzc2EwV0FFVHJ5V1lu?=
 =?utf-8?B?ZTFGQjI3WWFzKzhKMHdjS2Y0NU5MTTU1R2s5dXBvWk9JSGVaRFhGVkVRNTdi?=
 =?utf-8?B?b0c3Wm5LWjN0YmsyZHdjaHVIZWRUUkd4TmgwV0JGU09PT0NFcjhDZHAwWDNF?=
 =?utf-8?B?OHhWRk9sQWtCQ09TZTNhZkhvRkRXUWtta2IxNmYvb2Y5WC9VTTIrak5rbVhp?=
 =?utf-8?B?MVZXb0g4OWZCR1ZseEtTN05PV1JXVFJ6RjJhTms3c1B4aUNpbVpDR2VtR3hN?=
 =?utf-8?B?VDdFb09MRDVDWkp5cGRYak1yUG1qTzhNdWZkZVB5blVWSUxhcWhtczhZR1Bp?=
 =?utf-8?B?MU12U3N0cGlIVjhZYjBlUS9EOWU0YSszWnJ1VjBZc2w0dEtUcDUvbUtoSjBZ?=
 =?utf-8?B?aDRHWFltRVJ4MTNzMlVuZkszQUgvemRzclhiakNXUXZmVmJyRFlaSy9uR3c5?=
 =?utf-8?B?djd6U25KcHFjaWpaZHlLR2tQYjJrMDRSUzFJWmp0V0QvZUppcmJIUUZldmNS?=
 =?utf-8?B?bng5QXNsdkJPZlZQZnVlSDgvemRISWYzZjR5T2FKRjAzUnFUZFMrMURFWjh0?=
 =?utf-8?B?NDlwN0VqSEdGZW9mL1FWUXpYYXNCWVp2dFAwNDEwamdaakZ1YjQ0Mll0Q3Vw?=
 =?utf-8?B?dUd5RVpUL3hzQWxZajBEazJZajBrUWF6Ylo1NE8wN2kyWXo3NTBOWVBGdXJK?=
 =?utf-8?B?dWF3d2dWbUVJYSs5Wm9pWmtrWVBQSlo4OWhxT0dSVEJFdkFKUENBbnRBZUsy?=
 =?utf-8?B?cnI2dUpRaHZrcVkvSVdwTkFKTHFTaXhhNCtJcEtTa21pR2xOUlhxVHBPKzFK?=
 =?utf-8?B?QU9sOGNhM3l5b3RVZ1JneXBoWStFMm5FYUNpTlJwRE1RWUNDeDh3WXpiWG1B?=
 =?utf-8?B?Sm9mYWxOYjVmTUpTZmdxVURiQVQzOXlBSHZxNjN5cUlJWm11Tm44WFdtVUx5?=
 =?utf-8?B?M29qTTZ1TDduYkJKVFo0WjByU2kyMEZmYW5wSC9EZUJhMWZoOVBNdFA4MTdG?=
 =?utf-8?B?NGtkaE4xYVNYWTAxSWVVL2FWeW1KUXZjTEh6bG11L29HdEkrSFV0V1FYYmxq?=
 =?utf-8?B?SlpRb2JFekNwRnRsak4veC9UZUJPc3cwSDNvWk15Y2pTbXhscitiNmYrZWZ2?=
 =?utf-8?Q?9dwbuQiBaehHT0seg2vHVawPmrTdblsLCx2Zyf87JZNQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1abc7c-150c-4783-d24c-08dbe1fefc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 15:09:07.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TEwf95qrjyWGoAZSJSO4jvhZiedqrLqFjL5ePTVBJ2idAabtH+Tgv2YbxqkQVnJqPsbGsDEUtWRI9i96BGTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5630
X-Proofpoint-GUID: toNrrrL63NAUprwu7hQR3lZbH_PXC1j8
X-Proofpoint-ORIG-GUID: toNrrrL63NAUprwu7hQR3lZbH_PXC1j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=664
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTAsIDIw
MjMgNzozNyBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5l
bC5vcmc7IG1heDcyNTVAbWV0YS5jb207DQo+IGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25l
dHdvcmtzLmNvbTsgYmVudmVAY2lzY28uY29tOw0KPiB2YWRpbS5mZWRvcmVua29AbGludXguZGV2
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBmb3ItbmV4dCB2Ml0gUkRNQS9zaXc6
IFVzZSBpYl91bWVtX2dldCgpIHRvDQo+IHBpbiB1c2VyIHBhZ2VzDQo+IA0KPiBIaSwNCj4gDQo+
IE9uIDExLzQvMjMgMTU6NTYsIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiBBYmFuZG9uIHNp
dyBwcml2YXRlIGNvZGUgdG8gcGluIHVzZXIgcGFnZXMgZHVyaW5nIHVzZXINCj4gPiBtZW1vcnkg
cmVnaXN0cmF0aW9uLCBidXQgdXNlIGliX3VtZW1fZ2V0KCkgaW5zdGVhZC4NCj4gPiBUaGlzIHdp
bGwgaGVscCBtYWludGFpbmluZyB0aGUgZHJpdmVyIGluIGNhc2Ugb2YgY2hhbmdlcw0KPiA+IHRv
IHRoZSBtZW1vcnkgc3Vic3lzdGVtLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBN
ZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+ID4gLS0tDQo+ID4gdjEgLT4gdjI6IHJlbW92
ZSBSTElNSVQgbWVtbG9jayBjaGVjayBsb2dpYywgbm93IGRvbmUgaW4gaWJfdW1lbV9nZXQoKQ0K
PiA+IC0tLQ0KPiANCj4gTG9va3MgZ29vZCwgQWNrZWQtYnk6IEd1b3FpbmcgSmlhbmcgPGd1b3Fp
bmcuamlhbmdAbGludXguZGV2Pg0KPiANCj4gLi4uDQo+IA0KPiA+ICsJZm9yIChpID0gMDsgbnVt
X3BhZ2VzID4gMDsgaSsrKSB7DQo+ID4gICAJCWludCBuZW50cyA9IG1pbl90KGludCwgbnVtX3Bh
Z2VzLCBQQUdFU19QRVJfQ0hVTkspOw0KPiA+ICAgCQlzdHJ1Y3QgcGFnZSAqKnBsaXN0ID0NCj4g
PiAgIAkJCWtjYWxsb2MobmVudHMsIHNpemVvZihzdHJ1Y3QgcGFnZSAqKSwgR0ZQX0tFUk5FTCk7
DQo+ID4NCj4gPiAgIAkJaWYgKCFwbGlzdCkgew0KPiA+ICAgCQkJcnYgPSAtRU5PTUVNOw0KPiA+
IC0JCQlnb3RvIG91dF9zZW1fdXA7DQo+ID4gKwkJCWdvdG8gZXJyX291dDsNCj4gPiAgIAkJfQ0K
PiA+ICAgCQl1bWVtLT5wYWdlX2NodW5rW2ldLnBsaXN0ID0gcGxpc3Q7DQo+IA0KPiBPbmUgb2Zm
IHRvcGljIHF1ZXN0aW9uLCB3aHkgdHdvIGRpbWVuc2lvbmFsIGxpc3QgaXMgbmVlZGVkIGZvciBz
aXcgdW1lbT8NCj4gVGhhbmtzIGluIGFkdmFuY2UuDQo+IA0KDQpub3QgbmVlZGVkLiBhbnkgbGlz
dCBsaWtlIHRoaXMgY2FuIGJlIG9uZSBkaW1lbnNpb25hbC4gSSB3YW50ZWQgdG8ga2VlcA0KdGhl
IHBhZ2UgbGlzdCBjb21wYWN0IGluIG1lbW9yeS4gSSBjb25zaWRlciBtb3ZpbmcgdG8geGFycmF5
IC0gbGlrZSByeGUNCmRvZXMgLSBsYXRlciwgYnV0IHdhbnRlZCB0byBtb3ZlIHRvIGliX3VtZW1f
Z2V0KCkgZmlyc3QuDQo=
