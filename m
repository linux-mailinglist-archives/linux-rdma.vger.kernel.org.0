Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB17D6C0C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjJYMgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbjJYMgW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:36:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C4196
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:36:19 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCQRM2009110;
        Wed, 25 Oct 2023 12:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6vLvbhSm2SyFgnWqmJMWk2t2J4iPpaOfeyEjNPMeNvE=;
 b=pWYCii09YTpIA8pvHc5Mv72OZqxw+kLXzl5okMAkJTd+i1wK/TVLl7DnUHSybE8dwQh0
 Skd/FWNj+L9m9mONjeWz392jRiy0sbCN+1LgIXhpmNcDhKQb83caNQWmnf6FlFxDnE4P
 atnrqicnTgYrhVqOWLWid62pnRFM17X5bSBAi1gY/IradK5Rb5FruHl+WzL73wFuJ0lw
 gZ6QcK9mqYKFgSm2pJzZMt0Aedi7sjp6+npM7UAOCglT6szlJ8pMTZVccnmPHzaJCNLh
 1ZJBPqz+FH3waIhXi/VqzkKArxImk/Rl96tRkaXpsfFpVBk9QdXTTwNqJ2cUpFM0E+3R kw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2cksjkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMrjSGU2IZs+VXa5a2QrJzj8LmsauBCOm53MLxdjk556JjwMjS5kgMwLtCXbvcIVz6QgkyhFsfbhtjj2waqNjsk3tjd8hQYoKZazoVOJ6zp+pTOGXeGDty4KF/Dmmjq2mGrbK1tOKxtOz3QJRMtVZb7wfQvKjJPXZHi3wrsa5IX7KQUCZ7yIo74fHsUDT4XwQeptLgu4oXR6b6d9iFg8IzV/0UqK3DlmgW+yzw54MKH6js1Hr6Igb7lFFAVJZAnRiug4g0wHuQDJEyf8zE40/WyfAUmofKozibY43Uiu1SUT3C6ywMK2Qmp3yYoHoCLD0egUhAAtBCnUU6him44YSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vLvbhSm2SyFgnWqmJMWk2t2J4iPpaOfeyEjNPMeNvE=;
 b=dJW0KLvbq0gUG3hB7Ju0HTgYQRXkINS5GJZAAKMkQ7Awtlvj3N11ypcUibmGJc+01x9ppNYX0jME4Wu8v34gTmoxoBwRLR2gsfq2opsqwMtcgcUq55SSpeFsV9cgmxfFjKEfI8pHwrzSaA4HZcluqej6iOfUchA5PM9dx/q5QGxlafpW3B3WFla3cIqtLQnxkDSQotZv9fr2cP2Br6f4MkZIFXDZNL0aXry69lpNPVMvmTItyPQCKj1IOCcUWiGE8RE9vqavO6D+Cqyelrp+ZEf5eZ+Rm2PsK0Rm36RaSwhiLes06F/supDuRCrszzcVqrQ/hFLD7lHWJT6LeP9HQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:36:05 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:36:04 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 03/19] RDMA/siw: Use iov.iov_len in kernel_sendmsg
Thread-Topic: [PATCH 03/19] RDMA/siw: Use iov.iov_len in kernel_sendmsg
Thread-Index: AQHaBz/Rcqg0KA5JeUim9nNfQJl5iQ==
Date:   Wed, 25 Oct 2023 12:36:04 +0000
Message-ID: <SN7PR15MB5755C681F2C8C2F13A60236D99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-4-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-4-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|MW3PR15MB4009:EE_
x-ms-office365-filtering-correlation-id: 9564aca6-17b8-4e5a-525c-08dbd556f464
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqntqwUkUn3PyLPkG2+R/IvCiNMpBRqX2csfq1MCw8Ga5dO4tnFbXSUPkK2QR+UezFC3blsJdAx3ozIPec4EiwsIqirqvKNgKAaTCfPLIPR7y1gtSIYJkisjKVqkU5jTBFW7Gag5Pvsqc5PGGWsDhSMnhz+JRsNvDMZXj7W7kDdZgNsgY8xqg4HRv3mni91XtqG/D66TLtkDcA8s6qIzAmhqGQnD/+1cBD0UfOXE7h78vzNNH2QxAUIAC2ZqXNsHO2GCCRGMjieL2iz3r4uinWzX5WWS+bcGa1R9RpezJG13pgkHBWxeSS3EXyxruovM4BiSARMZMynceWy8kYy2oEyy+uRsFq6xrYePgxMVR8FYvta8Nci7XJRnzuAvxq0qoNs+Na9Nf863vlFFh2n/rkd2YAWzsC5uhJlwOfPQkwLH8tVqao0dkj379TM7YBs4e+9MjXYU65C7s+SNrcYvs1Dnf3QL8Xr7XuD3dyVqrHqYuXHsxnwdZCX14iEl9PJ4H2rbypOsBk77N/dCJqljGmYUrzlOYy/KRlujdBuAgRHMYdpGtCkmbPHjwIBqBby4ibTe81ruT4mO88Osloh0Ma2wd3eZk10W0lq4Xf17PpbyulweTVWOGlBl6McB96+M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(9686003)(83380400001)(7696005)(53546011)(71200400001)(38100700002)(6506007)(2906002)(316002)(110136005)(41300700001)(4326008)(66946007)(478600001)(52536014)(8936002)(8676002)(76116006)(66556008)(66446008)(5660300002)(66476007)(64756008)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1VZQWJhVGhlYWUzR3VVZ1Z2c29pM3dRZWQwSWZ5T2N2RVFxVDJibDIwOTQz?=
 =?utf-8?B?VkZkQ2FRWWZpQjROQVFaVHBpcTc2VlM5UmNKVXQ1QWNGc28yTForWWFLb21u?=
 =?utf-8?B?c1M1aVlDTUJxY0w2eDNHaWFGcUcyS3E5RWlkRmdhb053K1Rmb25EcHhWUXk4?=
 =?utf-8?B?aFdWQlh6djZBY1BwZDUxNFhLcDdMc3lnc3k2eGhFWXB1cnhDUm1vZE5ybVY3?=
 =?utf-8?B?UW1JL1lrOGVGME1hODZFejZST2diUUdNZXM0TUM1U1ZjVUxqb2xJRG1tN2ZY?=
 =?utf-8?B?NzhuRlB0eHNsZWtCVWE2RWpDa0wrdkF3WVN2MWc4a2EwcFV1RG4xZVVRenh6?=
 =?utf-8?B?clNaRmxKQXk3anV3cGZRNU5qZlVHclZrTnFJU0xtMjdURmpOTFZaQTZSNzFP?=
 =?utf-8?B?Yzcwa3VMWUxpYkx5ME5RZy9UaFoxZU5UMXd5SzZEUnRHeXNva054ZEdyM1lS?=
 =?utf-8?B?WEJTOTFrZTFGRVYzQ0xkUkdNMlU1Ri84elZINWFlbUVqVTFod2J6K2FYZSsz?=
 =?utf-8?B?UkFKdk82elNoekJWbjVUN3ZSWUppMGtIZjAzMUJBWTRKWnlNdHZXK05MYU54?=
 =?utf-8?B?c09pS2tXWEdaQUxiNytKTCs0L05XeUlmZ21LK293K3NRYjJkc3p5ZElwV1Fp?=
 =?utf-8?B?R3AxWUxhcXliR1NKMHRNWVlBcmloVHNYZ3JDbmFDM0xGNGhDRlM1OVpZaE9r?=
 =?utf-8?B?Q2dMaTZFK0tqWHEvL20xZlZTUnRKRERNQjNGUTR4MzMydDQzWU82QVJ3RTBT?=
 =?utf-8?B?eW01VHVJbVZOeWh5TEpSbkdKVVU5T2VxNWozTmhmQjBXeUZzU2xuK2g3bUlU?=
 =?utf-8?B?MjlaV2ZlZ1drVjZ0U2lQUWpaTTJSNmtRL20va2JWekpIUWFEUm4vN2lhU2wz?=
 =?utf-8?B?V0g5UXMwWWxZNTNrb3p6cDdoelJhbkE5b0lJSDZQeHNUTm8wRFMyK0l1WlF4?=
 =?utf-8?B?SXlZcHQ4TXBYNEpYbHNIam5EeE1BWEoybzZQbzA0dzhBeDlNL0FsbCtXdVZl?=
 =?utf-8?B?VG5mb1B2NXM0dmwzYTFmRXVmakUzSElSZUpURFdYbEpzVXFHVFR3dnA3RVZq?=
 =?utf-8?B?Y0dUcjJZTlJFbHBQc2JRVTZhOXJQQlI2S29aTDVVSVd2eUNybzdqd0hUTUNz?=
 =?utf-8?B?R1BkRkwvcW5jczc4dHpZamkwV3R1V1ZvQ05ETm5MVExVejg5LzVkeExuekoz?=
 =?utf-8?B?azJEMkxUWEtNTjZjbFBFMGZSS2cxVUpYeTRWekFSSmtLWHhIWlJhYUZnVk1Q?=
 =?utf-8?B?elJISStwbnA3bVhlWlFCbTl3a0cxdk9TTkdiZ3U2bUg3UE1aaGNCc3huVmcr?=
 =?utf-8?B?V21vMjVSZlJNWi9ORUMrOEFNT3dOZ240Ukd0bkY2R25raytMcjRPNlhaMnk1?=
 =?utf-8?B?VFBCTGVWOTltSEhpMnFmd3hzNjNRSC9lVkVOOFlIZFQvNmZyVUhyWk51V0F3?=
 =?utf-8?B?Q2xCTmRVU05UV2dxeHJYSG9kaldvZzN0QjBkbzB3ZmJFYTBHRk41N1FyOUJ6?=
 =?utf-8?B?Zm1OU2ltTzlXdk40L3Yyb01MOG5GQnd3SC9nOERXZVZqdCtERThSajRTZXhF?=
 =?utf-8?B?ejhNbmZQYTIrbGNmdWtPYWJEZFFiTFN3RU93WkxhZ21IR0IwWjg1Q25GcVdm?=
 =?utf-8?B?akMzNnIydFNNNU5tc3NlS2dWdGtkckRSV0Zxc1V2UzJIb1FQeERaVEsxTms5?=
 =?utf-8?B?NENFVmpKVzIwcndPSjZ0TFpTQzB3dlZqT1I2b2hKRkRUV0kxVU5DMjVSdmZT?=
 =?utf-8?B?WGFlYlROM2MrRG9HYjBOeE1pK204WWVZR0RiZ0xTN1U1bGJ2cU5HM09kNHR0?=
 =?utf-8?B?R01aOThqL1VQZys5Q0M1dElmelZVaGl2SW8vRGpSM0k5b2RUSGtGdjJ3Y1c5?=
 =?utf-8?B?czUzdUdRMTBhcEVCODFla1htS2xETzlLa2pSZEhkMUk0ZnZwYmtVM3gxSS9M?=
 =?utf-8?B?dndkRG9iZmJyOVY5SUZ5RVBBdVpUWGRhZzRkZVpCQjBuSGQ1RlBONVNSeWxF?=
 =?utf-8?B?ZUJUdHkvNStWR2hhMFozRm1FdC9CZCtBRnRhUjExYjQ4MWNmSTBCL0lXUjlH?=
 =?utf-8?B?eUhnYjlzcHFMWmx0R0lqeHFXUXlxTUFuWkpjVWNWMkxXU0Jua3YrSUZHU0Ew?=
 =?utf-8?B?bGs2WVhQNk1DVzZON1FQY0VtVFAyUUlWTXFBelAvenBXVVZIK2x4d2JDOVRT?=
 =?utf-8?Q?QzWT5pklHoOHJR6IFrXVViE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9564aca6-17b8-4e5a-525c-08dbd556f464
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:36:04.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVwL242eXvxf7Je4vHN/qDdhYkWWzghlREqiEOhVvbrs7GxTgW27BR0NbvrhuBDt25XAnBOXoGlLiYTg9jwFCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-Proofpoint-ORIG-GUID: l55TDRA6DD_gwYOyJFUw_T2fH0WvEx6J
X-Proofpoint-GUID: l55TDRA6DD_gwYOyJFUw_T2fH0WvEx6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=949 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250109
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDAzLzE5XSBSRE1BL3NpdzogVXNlIGlv
di5pb3ZfbGVuIGluDQo+IGtlcm5lbF9zZW5kbXNnDQo+IA0KPiBXZSBjYW4gcGFzcyBpb3YuaW92
X2xlbiBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5q
aWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
cXBfdHguYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4g
aW5kZXggNmEyNGUwODM1NmU5Li4yZTA1NWI2ZGNkNDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHguYw0KPiBAQCAtMjk2LDggKzI5Niw3IEBAIHN0YXRpYyBpbnQgc2l3
X3R4X2N0cmwoc3RydWN0IHNpd19pd2FycF90eCAqY190eCwNCj4gc3RydWN0IHNvY2tldCAqcywN
Cj4gIAkJCQkgICAgKGNoYXIgKikmY190eC0+cGt0LmN0cmwgKyBjX3R4LT5jdHJsX3NlbnQsDQo+
ICAJCQkgICAgLmlvdl9sZW4gPSBjX3R4LT5jdHJsX2xlbiAtIGNfdHgtPmN0cmxfc2VudCB9Ow0K
PiANCj4gLQlpbnQgcnYgPSBrZXJuZWxfc2VuZG1zZyhzLCAmbXNnLCAmaW92LCAxLA0KPiAtCQkJ
CWNfdHgtPmN0cmxfbGVuIC0gY190eC0+Y3RybF9zZW50KTsNCj4gKwlpbnQgcnYgPSBrZXJuZWxf
c2VuZG1zZyhzLCAmbXNnLCAmaW92LCAxLCBpb3YuaW92X2xlbik7DQo+IA0KPiAgCWlmIChydiA+
PSAwKSB7DQo+ICAJCWNfdHgtPmN0cmxfc2VudCArPSBydjsNCj4gLS0NCj4gMi4zNS4zDQoNClRo
YW5rcywgbWFrZXMgc2Vuc2UhDQoNCkFja2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJp
Y2guaWJtLmNvbT4NCg0K
