Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788164E8FD
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLPKBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 05:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLPKBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 05:01:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE349B69;
        Fri, 16 Dec 2022 02:01:15 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG8i3XS008979;
        Fri, 16 Dec 2022 10:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qooTeOZGHc9vWTcpI/1jVe5nGmERaKQXhJTIhx7a7os=;
 b=Fh32JTdXu5PXFCVcHAE3udhCKMqs6gUycYHCLzrvwjPXeKhHzzYCbRW+7g/HIrmwSMAT
 cCnFu2Exm1QW6quaPYC76L4sPPZezwhlgupZeC0HNG88waLnAmKhJvCSv/cF/30q/UU6
 8twfhMHs1kZ1FNpFCvoiDzQlenU7s0EXv6M0yD5cdA23qDGuevngmV6sX4JbWghpi+Zf
 lzDS2oRQE0evtKd7+l1Iz1aGrw+waDsQWvCQKMTNAv61LkYVfNEm4MWe2sAt29MyWksi
 rQspvSKnIDnItfKUeB0usqE5JY/bnHrOgUWEHR5cj5SSA8Klqac44Brt8nI81M9+8Tj7 1g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgndv1qqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 10:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJCGT1TxMTRin8LpUftc61X7ei2bSdHMiMeyt//AB67DHzaol6k81v7oQumnJTT1dahWMascf9qpHQKrJefoV/ssH54ZWEVK/g0L/ukeW6g/oC9TbgB2g6idjbfMF3mTpPcefnsca6OQdwZoFxBA9fBTgfAjgF7TbqOUi7aeFkBJBBJAoSgk8bxmph18333Z3d1dG2ib5+qGo7tVLGKFk8SkN/YzL/JJCID5DPeEzjfm0KYv3/t7vWzRSn9Xr3qkKas5nJKYDVFGIIWfY68xpT9ZC74/tkoq4F7DGVOR6W9zwKcOwPvpElf5Pyg6l+mSXj08ykCtU44ZgSWOss1beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qooTeOZGHc9vWTcpI/1jVe5nGmERaKQXhJTIhx7a7os=;
 b=FA9Hmby+eP69tWkzxM7h4hOiPdXsLbHK0EqH4DkYWpYK6xO15PYfhoL1LRSgOJfBph+g/hpm+emshbUcTXSnewnM10sfOhBPaAqPvSpE6LADXn7JwE4nONSJxa2E81WmqhRWxD0SO3jBXgajC4q/0ZqpkXLnebQPe6N03U791v6m1B5dWZEmvvOKcbDJnxPYVdSx6CYcCJrRR+3OlQxRBvxgEKhhggeHDt1EsiFwd1pXabWCKZ++E/8ruzqMX9hmG18bKT2AgyMMvXPkkzamTMivWb+Iv//+eDMK67d7RZRAFCbRGWkzXnexSTV1oJVtIw7UcAQTED7wFp7kLSzHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BN8PR15MB2642.namprd15.prod.outlook.com (2603:10b6:408:ce::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 10:01:02 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 10:01:02 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        David Laight <David.Laight@aculab.com>
CC:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Topic: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Index: AQHZETVNED4pqf+o10COHC+KSVE48Q==
Date:   Fri, 16 Dec 2022 10:01:02 +0000
Message-ID: <SA0PR15MB3919F3295251A173D0E14C3F99E69@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221215170347.2612403-1-arnd@kernel.org>
 <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
 <CACRpkdY_050MZ3Gun_bOZiTk=q+7xUkiP0CO7daLEiX2wRi_yg@mail.gmail.com>
In-Reply-To: <CACRpkdY_050MZ3Gun_bOZiTk=q+7xUkiP0CO7daLEiX2wRi_yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BN8PR15MB2642:EE_
x-ms-office365-filtering-correlation-id: 9de014ca-5c80-4523-8142-08dadf4c706c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IZf6KHGtZOW2ZTXn2M5eXGI2TzsqWVGlXeJCW2dNuXhRwvF3CncTWZ0GtaiEkeDMrM7/xz/QJeLSfg6aCP1nOZoJqlNmiDIzIuwzt7ugLle7RQ+FDOpzyDnJXVAAAoCmibjZNxp/2Sm1pFrBtVaNJXc/1K1caSXQmfVHjNiCy4zwKqFeWNrz+kGomnF9foUh027XmHRIi29l//t5CHlongqqoNDCvOSc6gYliLhRHWRtsuNDgOpZv+HbuafeaU14CYLC74E1xqix3ffnKRHBRL1f9TP7ztIZVEfSNVzFNQozW2rshTHcAKE26BrJH/UKK+ovp0HdwiM9ppMALpr8eQt3Vn3dC4wX5tBQ6MQRLpCyX09CdhQ/7T6QBzRSnJ0uA7tz6aC9+ClB7VfFwIA8fpCaZERJWLgr0wU+uG2LpzZX9U4vIs9fYfaZUeFgBFAf7V5ltcUAdwrqFdQwUAXfbFH+PXnOhpBqVi7X4NNRxHQg07wJmCs3gE4tPQIroLjSi86oJdQ9t+Gz7fGi78mzosQULpoa4oBVC1LX+Vw/amzRvM7b+JSORsZmKMed2xDoFGYRJEJmypQfK49/xNpdkD5+fQtCLEX+dADBdlcSrAqXE2IbB6vRpkuPC2B1h5kXz5VREij9LIdirOkcoEkJYVpH0dcbIh6McrrSXCzu4kKyyUiJzOLl7IL4aT1BA8QAGNOY3R00LnxZkb6IIRSdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(122000001)(38100700002)(55016003)(38070700005)(86362001)(478600001)(71200400001)(52536014)(66446008)(41300700001)(9686003)(66946007)(53546011)(110136005)(54906003)(316002)(66476007)(83380400001)(7696005)(6506007)(8936002)(186003)(66556008)(2906002)(4326008)(64756008)(76116006)(5660300002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2pJWFNyR1dZZ1pIUDRZY1hBZzh5THg3UkhuSUlacW1iQis2NEU5RjlUUnhQ?=
 =?utf-8?B?Z1UySk16Yjdzd3JGdzdNd1RGOXNYYXYwQ1dqUUx4SWJiL05PR2FSd2dwZkFl?=
 =?utf-8?B?dllkSFBNdEtzNjZmSkEyb1R6aElURlRkY1VjbzY3YS9zZTk3QSt2cVdFWHBG?=
 =?utf-8?B?YmFweGszWVhKQkRNd0ZFcG9MZk5NdUVkZGFkNE9NSTRQaXpacnQ3MlNiOG9C?=
 =?utf-8?B?RmM1b1ZIZWRpMHdJU3RYK2RqSW9lTGVHTVBlaVB1SStJNEJCNmJsTktWMFRk?=
 =?utf-8?B?emNqNGlIdFQ0MCt2WHQvZW14dHRHdHBpUnZZeG9tRzA5MndobG0vL24xNDIx?=
 =?utf-8?B?d0c3Tmx1dGxocVYzcENxRHlGbm9EWHFFWVcxaWNTdlM2aDgwT0RZR1o3VTVV?=
 =?utf-8?B?Y20vczlZT215UXVjOTIxZnR0cUllUjNWaURLYTkwMzBuRUY4YnBUMnFBblhl?=
 =?utf-8?B?dUc2TWhiOFhHeVJNeXpYYzNIeUlYWDcrSUpPZUxwQlpqellLWWYzdWV1Mm4r?=
 =?utf-8?B?dXVpS3AycUZZSkRuTDRJeUpzTTM3ckpSQTdKRkNVTzRCbER4YllWbmNBVGgz?=
 =?utf-8?B?RnNadnl5UDE3Zng3bjRWS1JhL2p1TjhZYmRyUHlzQWI0c2hRRWRPcm0xZ3ZY?=
 =?utf-8?B?RzJXTmx3bHdaWFNTanZlaUdUeUhYRFdXVGxYbEZvNldrY2o5SWlrR0NQaXBa?=
 =?utf-8?B?VFM0eU1LeUFTamlKZ1lGUWZjYVloV3NRZ3d1U0s2bUp3ZHdFZFdnVWRMMHFN?=
 =?utf-8?B?cjVwcFozcHBRTFM0QjFQMGdaWVZzR2dKSXE3VjQwTkF3LzVPai9yV0hQeVVR?=
 =?utf-8?B?NW56RFhpZFlINll0STlmczR4dStvNUJsTmM1bDQvNmF1T0VJRmFZUUZZQ3ZK?=
 =?utf-8?B?Y3RJWGVRdDhoKzlEMStmcTA3VGcvK3hLYWZ0Vld4VFRKQUFpTjhmQTVrS3Jl?=
 =?utf-8?B?S0R0dHJEcGd5UjJXWEpodjlvMitwbkZBcXQraWU4bERKRzBjRm5ldU04TFox?=
 =?utf-8?B?TDJKbnVsbEp4aDhabGRqR211ekFJQ1VIK3AvR3NpbmkxcVIvampaL2VSc3ZL?=
 =?utf-8?B?MUQ0Q2NNT01yVTZOeEdTQ1dCTVNCSmRUTlJESXdYVWFHUVpGY3RmNENJRUFK?=
 =?utf-8?B?UmJUL3MyOFB1UFEvRVQ5ZWVDbVlDUi9kTDJiR082cDhaM21kTlNjZFRlS3Jo?=
 =?utf-8?B?RC9DcXBsVllaT3gvbkQydE9zU1U5V2plVXdDNEdoT2hGc2VzeGZhbEFCTDVS?=
 =?utf-8?B?NkozdUNMOUw4MkhVL2Q0TERzQmFqYTZKL2k3c1JRcDVqN1J0dGdHNWZGT25K?=
 =?utf-8?B?OU9XYmtiM1htUlJPUVJIMVNzNW5wRkNOOFVrYjczRm1EYnBQcG12RFBWMkxt?=
 =?utf-8?B?anREckZORTUzbzh5bUMxNGwwYzhoWXpQZ3RZNE9vdzZlRklVeU9wNFBRSEVv?=
 =?utf-8?B?c3oyc1pLZUVHRnIxcW1EY1Nzd3FER1RNUGlNVVNWeWFkNHRYbXZOVmVkenNV?=
 =?utf-8?B?Z1V2WGRrS3pnL0IxM09NQ0dZMWZsV0dVMDQxc0FnR2IwSzdtVGtlVnhjVGRJ?=
 =?utf-8?B?REZ6YzlHUGxUQUszYldneVdMZDl4cmNZMk9ia25LN05NVlZzeXJQWnh5L0Z2?=
 =?utf-8?B?NzdScWYyQURoZHQxa01Nd3RHeDRVZ3dFVFNkdkZ4TitmNVJpRHpTK25sRkFo?=
 =?utf-8?B?SmkwZzNGZlZtNjRobmt5d0RTK3U3R2NwVHVjN3hnVXFwNkZUWGlTdENWRzRo?=
 =?utf-8?B?akN3KzIyL0NwUklDR0JDb0M3WkttVnZzZHBieENHMlpNdE01bWdneFpuYWk3?=
 =?utf-8?B?YndLKzlLdExyUjRJZ3Robk1ZTHJrbzE4a3NXWnVhaTRPeFdTdmhENjdOQkNR?=
 =?utf-8?B?TGJrelUyRDRybkdjSzAyQWllbkZmUjZPVnFvNEFZRllnVGM3NVVkd2VkbTUy?=
 =?utf-8?B?dW9mZmZ4SExxSWUzdkwxR1U1d3lSMTFLendlQTNncjBqS3NQNGFOYzdTTENR?=
 =?utf-8?B?MUgwWUFQZFJLUmtkamR1dXlmU09FV2JiZE9kZ1B3MDJmRC94aFNZcGdsNTVa?=
 =?utf-8?B?TzY2UHEyMDVxcHJoZFZZdEgzQm5xbE9CRHppUGdaRjY5QXNkUWtFQ0JPVSts?=
 =?utf-8?B?SHVRUzB3OGwyd3pHUnhtU2NReXdnbktqeENSaFBhV0NEd2l0cGNYQStMVmNC?=
 =?utf-8?Q?dGlyKDqkiX81mIBE+H1JyDEp2HcdqKnu2lkG+YHj0368?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de014ca-5c80-4523-8142-08dadf4c706c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 10:01:02.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfQ+/P03IXbMU9GB3IAKkubXTAziMJqGUZXJCV0rhRis7Ri6xzRHBA/tzNJ/iHRjl23SNZ0wsHzj9zHc3R6zyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2642
X-Proofpoint-ORIG-GUID: OoICWHedYRV_q6qSyXHB1x6ujzrcSHJL
X-Proofpoint-GUID: OoICWHedYRV_q6qSyXHB1x6ujzrcSHJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=900 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIDE2IERlY2VtYmVyIDIw
MjIgMDg6NDcNCj4gVG86IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+DQo+
IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+OyBCZXJuYXJkIE1ldHpsZXIgPEJN
VEB6dXJpY2guaWJtLmNvbT47DQo+IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBBcm5kDQo+IEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6
IGZpeCBwb2ludGVyIGNhc3Qgd2FybmluZw0KPiANCj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQg
MTE6MjAgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4NCj4gd3JvdGU6
DQo+IA0KPiA+IEZyb206IEFybmQgQmVyZ21hbm4NCj4gPiA+IFNlbnQ6IDE1IERlY2VtYmVyIDIw
MjIgMTc6MDQNCj4gPiA+DQo+ID4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
Pg0KPiA+ID4NCj4gPiA+IFRoZSBwcmV2aW91cyBidWlsZCBmaXggbGVmdCBhIHJlbWFpbmluZyBp
c3N1ZSBpbiBjb25maWd1cmF0aW9ucw0KPiA+ID4gd2l0aCA2NC1iaXQgZG1hX2FkZHJfdCBvbiAz
Mi1iaXQgYXJjaGl0ZWN0dXJlczoNCj4gPiA+DQo+ID4gPiBkcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19xcF90eC5jOiBJbiBmdW5jdGlvbiAnc2l3X2dldF9wYmxwYWdlJzoNCj4gPiA+IGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6MzI6Mzc6IGVycm9yOiBjYXN0IHRv
IHBvaW50ZXINCj4gZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstDQo+ID4gPiBXZXJy
b3I9aW50LXRvLXBvaW50ZXItY2FzdF0NCj4gPiA+ICAgIDMyIHwgICAgICAgICAgICAgICAgIHJl
dHVybiB2aXJ0X3RvX3BhZ2UoKHZvaWQgKilwYWRkcik7DQo+ID4gPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gPiA+DQo+ID4gPiBVc2UgdGhlIHNhbWUg
ZG91YmxlIGNhc3QgaGVyZSB0aGF0IHRoZSBkcml2ZXIgdXNlcyBlbHNld2hlcmUNCj4gPiA+IHRv
IGNvbnZlcnQgYmV0d2VlbiBkbWFfYWRkcl90IGFuZCB2b2lkKi4NCj4gPiA+DQo+ID4gPiBJdCB0
b29rIG1lIGEgd2hpbGUgdG8gZmlndXJlIG91dCB3aHkgdGhpcyBkcml2ZXIgZG9lcyBpdA0KPiA+
ID4gbGlrZSB0aGlzLCBhcyB0aGVyZSBpcyBubyBoYXJkd2FyZSBhY2Nlc3MgYW5kIGl0IGp1c3Qg
c3RvcmVzDQo+ID4gPiBrZXJuZWwgcG9pbnRlcnMgaW4gcGxhY2Ugb2YgZGV2aWNlIGFkZHJlc3Nl
cyB3aGVuIGNvbW11bmljYXRpbmcNCj4gPiA+IHdpdGggdGhlIHJkbWEgY29yZSBhbmQgd2l0aCB1
c2VyIHNwYWNlLg0KPiA+DQo+ID4gSSBob3BlIHRoYXQgZG9lc24ndCBtZWFuIGl0IGlzIHJlbHlp
bmcgb24gdXNlciBzcGFjZSBvbmx5DQo+ID4gZ2l2aW5nIGl0IGJhY2sgdmFsaWQgdmFsdWVzPw0K
PiANCj4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGlzIGRyaXZlciB0b3RhbGx5IHRydXN0cyB1c2Vy
c3BhY2UuDQo+IA0KDQpTaGFtZSBvbiBtZS4gWWVzLCBzb21laG93LCBhbiBhY2Nlc3Nfb2soKHZv
aWQgX191c2VyICopc3RhcnQsIGxlbikNCmlzIG1pc3NpbmchIExldCBtZSBmaXggdGhhdCB3aGVu
IEkgYW0gYmFjayBhdCBteSBkZXNrLiBTZWVtcyBpdCBuZWVkcw0KaW1tZWRpYXRlIGFjdGlvbi4N
Cg0KTWFueSB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0IQ0KQmVybmFyZC4NCg0KPiBZb3Vy
cywNCj4gTGludXMgV2FsbGVpag0K
