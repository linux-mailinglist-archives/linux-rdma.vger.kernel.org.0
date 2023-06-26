Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D536A73DD62
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjFZLYS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 07:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFZLYJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 07:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C23C5;
        Mon, 26 Jun 2023 04:24:06 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBHpjw017522;
        Mon, 26 Jun 2023 11:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HQtg7+jIrRg0e/Y2rbXlmbrWDBT1S46rDREQmGrQgf8=;
 b=ae2Pj36616c/F02e5xufI+uJIXnrKRg2s6/+nWCZWcGlBiaVxRqpkJNwOiI8l8rqK3mi
 jYpgge+bLt0ZwuyJK8e44x9rg0WG/u27uXyYIoDHabAy6H9VfKtASzg46k91EGXRAixd
 2Te8aYZKQn6IakoehTLOwnxGCO4QGfIDAMxk9WAFGY4TWzLg17aSaezcSG4d8RqvFgP9
 SbUos/rS+7O1Kxfsmiuei0n7tYOGFMfBHFwPK1xjf0oIcrp2aMW+MHY5U4q/f99TitGG
 xxo0I/mZrLNEJcs1i6DD8KQhUa90Vd3UbYKVHeb2Rux3GcvIpQUHghXAg9AGqmJ88Ena Qg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf9p1g55x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 11:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeSbBst6i8aRvLssnpKTynm5OkvgARphBDz+d3j/wsIbl0wR7KuatnAj63cBjjCGL+imyqLxNerLpcB3+2cMj8T82BTUQ9q3SgT1/3Hh8OtSl3nE/+1inr9/vUfuofMGRyJTchFUTA3wHdsTkSeVa95u2fxt8DY4k2QiLOwz5JkgfpFgAMzoLRcp39H5uELty633886a8Tnz1usLKPgRdoCcLgrfuPuEa92X+46x5RatCWloCtJ6txsuu7Xnu6OIzACMqb50biVq1vXIdqJxaZsewNj+4+k2v8rFCSQuTGrPmbi6lP2IhEE3l7M05GT4eTYnTedchtF4Czg4KlCBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQtg7+jIrRg0e/Y2rbXlmbrWDBT1S46rDREQmGrQgf8=;
 b=at474859L+lREk1F6VC+sLT0JBVduKdKxNJ2K+ELOIDe11imebq0b9NTxHJiQ45VTdHQdCbBXOQxOFXvWvGwx7cEHoxA6k1Q2WPelqRZY4ZbX1cXeCMOaFIphE3Ik27XERhroOlYOw2abg6mcKqvff6QakOLEFHFbzQVRgi+WSs7edOiBKMfXwreC2jx3uzMRMroR4g91Qi/orntMBsp3G4LLPIvpaPjvMu9Kv+3gtzG42zbRceE6KZkJvWxqwJoYmeK8ZT2IseWb/5rSICsVCqsXRSlJitSTW+fNfgksQ3JtwGZ0UJz4o/BMdtAPcgXF2FsK9GtFYyxsVUEFQmNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DS0PR15MB5469.namprd15.prod.outlook.com (2603:10b6:8:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:23:58 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ac06:e924:d85:3f4a]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ac06:e924:d85:3f4a%4]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 11:23:58 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/26] RDMA/siw: use array_size
Thread-Topic: [PATCH 14/26] RDMA/siw: use array_size
Thread-Index: AQHZqCCz4E+Z2th3O0+IOKJVSohm4g==
Date:   Mon, 26 Jun 2023 11:23:58 +0000
Message-ID: <SN7PR15MB5755D82EE7B0630CEEFE01DD9926A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-15-Julia.Lawall@inria.fr>
In-Reply-To: <20230623211457.102544-15-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DS0PR15MB5469:EE_
x-ms-office365-filtering-correlation-id: a1cf0187-8d2d-4d49-bdb2-08db7637d5a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGvtpQlTllwsJ5/2LoTcZ9fjZeAn0fVgqASUbz/PG5EVmzcGXcCH/VSRk6qHbfEHwc07aIUBL77k+MGlTpgYkCz6GeTJONh5L8JElYl+ddtl4S5rudkQj5k8gIsjHAlVvC4jb++PRTMO5uBIB3dcglbUk4mX1Le3kdvVq8HAtvvsMc7nkBbj20gM+7XaookAwEplhGlb/E1cTV8/LJGqgP2keQzQ8kl8vuNnNlJALqmg6ALsiWu7eKQuf7V6covZpWMgeU+krdK+YU7YELRwIRHAmXrd/MFyneC50aOCk3h73NwVf9F+DKlvTrG6/Yo/GQkAjsJWKJxeXRsFpqAVF4NrLUoRYLzsf8dlalRUz1wCnI4lF/WxZnN+sQvfg868b1SjdzRCV0LBj/v2oQPd7ozDeVANP7v1Y2xXL8Cg8oSX6zKqoUrO4d8XshOTZojq/jVV16dfg5l6AXVt4igTqP8rjOWy/2fKgMVXiXbPd+RR+LvFNsi8uMjQxwb0ladM0QQz8Q0DejCyUlUjm9KQkHxBeBSOguQcR4AYfGCmXan/HPBZfo5yeKPbreSwkq7zk5ZdOOTCVhQFPUR7a+B/EnM5gkaGgn0RKCCeSptEOGhaFVsWszc1WBKBcPpsYtpo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(5660300002)(52536014)(4326008)(76116006)(66946007)(66556008)(66446008)(64756008)(6916009)(66476007)(33656002)(478600001)(316002)(8676002)(8936002)(2906002)(55016003)(54906003)(38070700005)(86362001)(41300700001)(7696005)(9686003)(53546011)(6506007)(26005)(186003)(38100700002)(122000001)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpOcHhtOFBwWGkyQjVtc0Zqa0U0cU9aeVpsQVdQTldlY2JTQ1g0bFFsWlBM?=
 =?utf-8?B?ZjRUSzkrOU12Mko1RTluLyttTEdUUDZiRldzbjdDNGhqcXdOdkV4dGxORXp2?=
 =?utf-8?B?OXFidCtxMW1QaHN1WHFiMGlJTXIyNFloQTRnNUtOUzhFakpocUJZK082ZU1J?=
 =?utf-8?B?THV4UDJwRXhiYmRzV1VGTFdUZk5XSUZDT1QwaE5LOUZzVjlpSzg3bHFjaDB1?=
 =?utf-8?B?eGFHR3ZFTzNKeGRqcW1XOXFneGd6eTQwVDU2a2NKRlc4OEkrK01mVkxHOTBR?=
 =?utf-8?B?ZGh1UW9zN25xWnJzdXpRV2VjWDloSmt5Z3VBWjkycEEva0IxRHlxbWtVOTQ5?=
 =?utf-8?B?M0JRbHA5dDRQMmZ5dWVCQTIyNmRHUTBEQTVCL2ZxZHFNci9WY2dmWVJQcGk0?=
 =?utf-8?B?aEtzb3k2QloydW9HMUc3c2tnaFlGak9BalVnVk5Zam1PWGc4Vmx6dEZ4OU94?=
 =?utf-8?B?Z1RUUE56Ky81Wk1aak1jWlF6UHNGWGJmYnRvS3NGQklkanMvSmVrc0dtZGxq?=
 =?utf-8?B?NmUzd2pNU04zK3ZtM09OTEhTNkVsK3JTOWxmemtpNGdldlErbUlVZU04WkR0?=
 =?utf-8?B?eGNxbEErY2lncXZnbjd2LzVrN3JRdEFtVTEyNFA3aGpBN01VcXNsZVVSSlVn?=
 =?utf-8?B?MENzcTN1LzBuSldZWENLTUNyV09kL0NnMXRiVk8rN3FxR21LNW5VNVc5TXNE?=
 =?utf-8?B?bW9jbkFBWnloMFNrcEJackx4VkJQRFd2SE80d0JHdnFWRW5icHo3QzBSMUZm?=
 =?utf-8?B?ZG1XMlZMdmhjWVJrZnhDdWU2QTJkcHlwbVlzbkRzM2EvWDNmMXpqOU1pTVdC?=
 =?utf-8?B?SHBDc0NyWCtodUhEK3VpMCtESEFzNmFUNUZ3b1piTDNpS1ZEamxiMTg0TlBo?=
 =?utf-8?B?ZTFWQThlRlNTRDcyU245N3ZtMkRQODF2M1hHQUlJM3poR0V2Z3A2eGdjcEFJ?=
 =?utf-8?B?aFdtTWNiWEcyeEYzYktDM0hsSm54UHJKNlZSNXpldktaaE9UeUhGVlR6UUpN?=
 =?utf-8?B?TjQwQUlCbW8vSWprTXMyNWtTd3pnejhTSzl1T0p0QU5HWEdBRTA4VU9UejFq?=
 =?utf-8?B?eUVERE5QU0I5Ky80NnFvS2d4Y2VXOTJnTnhlQnBhelZaNG0zYkNGejMxRVp2?=
 =?utf-8?B?SDdVcWJqblhUSnNOOEZTN0VYOHRFemN6QmlQeUZNc2J6VGdjMTg4UDNWcTlr?=
 =?utf-8?B?cDdWMW9wNXRLNk9GK21Rd3RVYjR6UDQ5Q0cwVnlNY2FVNGZlMGZlRVloRGJD?=
 =?utf-8?B?WjFhM2VLOWI5aVV2ajBXc2xUMzcyL1RJMTdscXZQNDJTbitrNkVCa2piMTlV?=
 =?utf-8?B?QUdoR3ZNcUVZMzBWajRqelVGOWVmTUF2Tzd5RkJBMk1SV3ZkZElwZjJWdWsr?=
 =?utf-8?B?STB0cUNlZEJoQWs2SUJaa1hCS2pjaStRR0NKSVZMT0JKd3Y4Y3NnR0tnUms4?=
 =?utf-8?B?cmNsbGl6ZWt4UGtUN3NiQXkwdFc0RGFUS3JXYXNvOEhJSkcyNjBTSnJMVHNX?=
 =?utf-8?B?V0tIU0pvcC94QnRrV29mSGFJQzFGZnpMVkRieXdMWFdtdFQ5Wm5GZVQwT1d3?=
 =?utf-8?B?Y2dlMHNuUWdodi9MVFNDQVB5Y1k3UjFXaVhyZmpUL0xqZnlQYlpDMEIrRTVw?=
 =?utf-8?B?N3V2TkN2dWRnMTNIalMvK1pWa2VzM3hHRFk5N1orSWpKV200dzJKaENqU0ky?=
 =?utf-8?B?RUhOL01yeDNUdmdQb3pmY05QMjBuZEJxRGQ1czRNTXRHNTdwVDBKV2xLQ2d1?=
 =?utf-8?B?dUFxU210MU1Rc2I3OWh0T2pTSEFrQU5Jcjd0K21ISTJzQXhUMG9BZjUvcXJK?=
 =?utf-8?B?UWsxLzFleVZkZW1vZitvUVdvMm1pRnBWNFlkUTFZMjNiWFN4bnNRa2pYbzJj?=
 =?utf-8?B?R1dyazlQaUUyWFRQZjRJbFg2MjdPWE9IL2s1QkZaRzY0YUlqZER4RTV1a0lM?=
 =?utf-8?B?MHZzQzhISVh3NjgwZkZtNmlXVGRxbGtydWNHZHVUY252YnZVVnEwRzJLTUtp?=
 =?utf-8?B?WVpyeEhGWG5SRzVucFdUbUFMdmtCS2JwQ3kvQ0JyN1NFRWRwOTlVLy9yaGlz?=
 =?utf-8?B?aElKdnQ5RTFNVGxobXJuYitqSy9sNVFsT0VqRk9TQzBPbXhNZlk2K3FlbDhI?=
 =?utf-8?Q?K5Ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cf0187-8d2d-4d49-bdb2-08db7637d5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 11:23:58.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poPMFTzBD7wclwFKl/Fm386JolkAAxls6ushRpUXyTGA/wa4ap/tDxrRoY2aTN2Mxbw/RMCQYKYDvNvqA0L//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5469
X-Proofpoint-ORIG-GUID: nQZR2elOHYR6Efb4XWPtyVb2dF8uJtN6
X-Proofpoint-GUID: nQZR2elOHYR6Efb4XWPtyVb2dF8uJtN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_07,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=732 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVsaWEgTGF3YWxsIDxK
dUdsaWEuTGF3YWxsQGlucmlhLmZyPg0KPiBTZW50OiBGcmlkYXksIDIzIEp1bmUgMjAyMyAyMzox
NQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+DQo+IENjOiBrZWVz
Y29va0BjaHJvbWl1bS5vcmc7IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IEphc29u
IEd1bnRob3JwZQ0KPiA8amdnQHppZXBlLmNhPjsgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5l
bC5vcmc+OyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggMTQvMjZdIFJETUEvc2l3
OiB1c2UgYXJyYXlfc2l6ZQ0KPiANCj4gVXNlIGFycmF5X3NpemUgdG8gcHJvdGVjdCBhZ2FpbnN0
IG11bHRpcGxpY2F0aW9uIG92ZXJmbG93cy4NCj4gDQo+IFRoZSBjaGFuZ2VzIHdlcmUgZG9uZSB1
c2luZyB0aGUgZm9sbG93aW5nIENvY2NpbmVsbGUgc2VtYW50aWMgcGF0Y2g6DQo+IA0KPiAvLyA8
c21wbD4NCj4gQEANCj4gICAgIGV4cHJlc3Npb24gRTEsIEUyOw0KPiAgICAgY29uc3RhbnQgQzEs
IEMyOw0KPiAgICAgaWRlbnRpZmllciBhbGxvYyA9IHt2bWFsbG9jLHZ6YWxsb2N9Ow0KPiBAQA0K
PiANCj4gKA0KPiAgICAgICBhbGxvYyhDMSAqIEMyLC4uLikNCj4gfA0KPiAgICAgICBhbGxvYygN
Cj4gLSAgICAgICAgICAgKEUxKSAqIChFMikNCj4gKyAgICAgICAgICAgYXJyYXlfc2l6ZShFMSwg
RTIpDQo+ICAgICAgICwuLi4pDQo+ICkNCj4gLy8gPC9zbXBsPg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSnVsaWEgTGF3YWxsIDxKdWxpYS5MYXdhbGxAaW5yaWEuZnI+DQo+IA0KPiAtLS0NCj4gIGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMgICAgfCAgICA0ICsrLS0NCj4gIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAgICA2ICsrKy0tLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXAuYw0KPiBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMNCj4gaW5kZXggODFlOWJiZDllYmRhLi4zMmVjODVhZjAz
MTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMNCj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXAuYw0KPiBAQCAtMjA0LDcgKzIw
NCw3IEBAIHN0YXRpYyBpbnQgc2l3X3FwX3JlYWRxX2luaXQoc3RydWN0IHNpd19xcCAqcXAsIGlu
dA0KPiBpcnFfc2l6ZSwgaW50IG9ycV9zaXplKQ0KPiAgew0KPiAgCWlmIChpcnFfc2l6ZSkgew0K
PiAgCQlpcnFfc2l6ZSA9IHJvdW5kdXBfcG93X29mX3R3byhpcnFfc2l6ZSk7DQo+IC0JCXFwLT5p
cnEgPSB2emFsbG9jKGlycV9zaXplICogc2l6ZW9mKHN0cnVjdCBzaXdfc3FlKSk7DQo+ICsJCXFw
LT5pcnEgPSB2emFsbG9jKGFycmF5X3NpemUoaXJxX3NpemUsIHNpemVvZihzdHJ1Y3Qgc2l3X3Nx
ZSkpKTsNCj4gIAkJaWYgKCFxcC0+aXJxKSB7DQo+ICAJCQlxcC0+YXR0cnMuaXJxX3NpemUgPSAw
Ow0KPiAgCQkJcmV0dXJuIC1FTk9NRU07DQo+IEBAIC0yMTIsNyArMjEyLDcgQEAgc3RhdGljIGlu
dCBzaXdfcXBfcmVhZHFfaW5pdChzdHJ1Y3Qgc2l3X3FwICpxcCwgaW50DQo+IGlycV9zaXplLCBp
bnQgb3JxX3NpemUpDQo+ICAJfQ0KPiAgCWlmIChvcnFfc2l6ZSkgew0KPiAgCQlvcnFfc2l6ZSA9
IHJvdW5kdXBfcG93X29mX3R3byhvcnFfc2l6ZSk7DQo+IC0JCXFwLT5vcnEgPSB2emFsbG9jKG9y
cV9zaXplICogc2l6ZW9mKHN0cnVjdCBzaXdfc3FlKSk7DQo+ICsJCXFwLT5vcnEgPSB2emFsbG9j
KGFycmF5X3NpemUob3JxX3NpemUsIHNpemVvZihzdHJ1Y3Qgc2l3X3NxZSkpKTsNCj4gIAkJaWYg
KCFxcC0+b3JxKSB7DQo+ICAJCQlxcC0+YXR0cnMub3JxX3NpemUgPSAwOw0KPiAgCQkJcXAtPmF0
dHJzLmlycV9zaXplID0gMDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5j
DQo+IGluZGV4IDM5OGVjMTNkYjYyNC4uZGRmODNiNjM4Y2IwIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTM4MSw3ICszODEsNyBAQCBpbnQgc2l3X2Ny
ZWF0ZV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsIHN0cnVjdA0KPiBpYl9xcF9pbml0X2F0dHIgKmF0
dHJzLA0KPiAgCWlmICh1ZGF0YSkNCj4gIAkJcXAtPnNlbmRxID0gdm1hbGxvY191c2VyKG51bV9z
cWUgKiBzaXplb2Yoc3RydWN0IHNpd19zcWUpKTsNCj4gIAllbHNlDQo+IC0JCXFwLT5zZW5kcSA9
IHZ6YWxsb2MobnVtX3NxZSAqIHNpemVvZihzdHJ1Y3Qgc2l3X3NxZSkpOw0KPiArCQlxcC0+c2Vu
ZHEgPSB2emFsbG9jKGFycmF5X3NpemUobnVtX3NxZSwgc2l6ZW9mKHN0cnVjdA0KPiBzaXdfc3Fl
KSkpOw0KPiANCj4gIAlpZiAocXAtPnNlbmRxID09IE5VTEwpIHsNCj4gIAkJcnYgPSAtRU5PTUVN
Ow0KPiBAQCAtNDE0LDcgKzQxNCw3IEBAIGludCBzaXdfY3JlYXRlX3FwKHN0cnVjdCBpYl9xcCAq
aWJxcCwgc3RydWN0DQo+IGliX3FwX2luaXRfYXR0ciAqYXR0cnMsDQo+ICAJCQlxcC0+cmVjdnEg
PQ0KPiAgCQkJCXZtYWxsb2NfdXNlcihudW1fcnFlICogc2l6ZW9mKHN0cnVjdCBzaXdfcnFlKSk7
DQo+ICAJCWVsc2UNCj4gLQkJCXFwLT5yZWN2cSA9IHZ6YWxsb2MobnVtX3JxZSAqIHNpemVvZihz
dHJ1Y3Qgc2l3X3JxZSkpOw0KPiArCQkJcXAtPnJlY3ZxID0gdnphbGxvYyhhcnJheV9zaXplKG51
bV9ycWUsIHNpemVvZihzdHJ1Y3QNCj4gc2l3X3JxZSkpKTsNCj4gDQo+ICAJCWlmIChxcC0+cmVj
dnEgPT0gTlVMTCkgew0KPiAgCQkJcnYgPSAtRU5PTUVNOw0KPiBAQCAtMTYyNCw3ICsxNjI0LDcg
QEAgaW50IHNpd19jcmVhdGVfc3JxKHN0cnVjdCBpYl9zcnEgKmJhc2Vfc3JxLA0KPiAgCQlzcnEt
PnJlY3ZxID0NCj4gIAkJCXZtYWxsb2NfdXNlcihzcnEtPm51bV9ycWUgKiBzaXplb2Yoc3RydWN0
IHNpd19ycWUpKTsNCj4gIAllbHNlDQo+IC0JCXNycS0+cmVjdnEgPSB2emFsbG9jKHNycS0+bnVt
X3JxZSAqIHNpemVvZihzdHJ1Y3Qgc2l3X3JxZSkpOw0KPiArCQlzcnEtPnJlY3ZxID0gdnphbGxv
YyhhcnJheV9zaXplKHNycS0+bnVtX3JxZSwgc2l6ZW9mKHN0cnVjdA0KPiBzaXdfcnFlKSkpOw0K
PiANCj4gIAlpZiAoc3JxLT5yZWN2cSA9PSBOVUxMKSB7DQo+ICAJCXJ2ID0gLUVOT01FTTsNCg0K
bGd0bSENCg0KUmV2aWV3ZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29t
Pg0KDQo=
