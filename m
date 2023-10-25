Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347457D6C1F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJYMj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjJYMj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:39:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA82CC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:39:56 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCQJAE009962;
        Wed, 25 Oct 2023 12:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=yXspi2pj+c2Z4GnJ97K2bM0gsN2lsxpDOo5RKsxPJXg=;
 b=OY2KHG3dRaXW1bKfFa8NHhBxJMwnentu+SfR7hvg83kT37eKDjl8iV23deHQvremPDDQ
 C5JtVMpFYdOiG36lcAm9WXiEZED9nD8JTnaL0VlwSSR9L244GQGp6LjKn3QoVCcJG4A5
 DZgGgFcoJuayCGy2ne3VwNfMYbMlaFWxzzMVSIkHaHvTKHyt6NydohhrEx2fF049q8EW
 xydw4A4Q/AA4rB8N0dzJcMBQ4UJY/TQy59Csgdce7sBhAFUN77ugFgxTOkphLnf5eNgx
 FA0+0odgs+eC2IWiyLHmGbA/qVh+5ZFUUqQbTH0WuZ53Z7kA4iOjAdzP8kdjHL6dQzL9 uA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2ex9e3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLtDdxqxBpcpmsybXlbBDwEf6BQX9ahbatjc5KUA3+QLihux+7VYjQ+uN1XuW586t75xaiEYFGCamTAlZ+fwKwdtRT7Tx/2FGOc3T3JHlGOfkToySs7EV1bSBBJwj11jz3dG9rCP1njl6drUX710jP820iX7MEoNhM0sd4hhFqpChTLuAMLCS3aZGPVVdcfpGbSyAhB2m4Y6TQcWITAs5WC+/TrHpUFAlIdQFOWPwCTjFnZ4YBEwlw6+QuCklbtQ85GZ88XK7gFj1LrcmElZpjDcIBKRHX7xp7Q2mY+uDg0dPsq/0m7HhkyQJiqzDQgtBVDlspkcBxZ5DzUIcxcbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXspi2pj+c2Z4GnJ97K2bM0gsN2lsxpDOo5RKsxPJXg=;
 b=jc1sOCDIpBrs5t8SDJ2ka8PoFD36z6FpLl2UwQHc67K1+wNFFA71ENNxoeVvGEuUeoWJxE53Nn+9IIPIqFZbohU6WJvw5xYEXGY36Mmke0lFx33NzQtmAJpV29kFSUlJKBKmp1Mvl7H0xAeIRo1cpUatbGivgSj5HVgaEFHAC6v1IfOi1njcFuIYTRxC/NtCLRbmPtHhUZvteZzqD3ZwndMr4vkBJ9r7l1N3fhhVPtX41jODo0wkK6RvsQTtfIvO7K0QASPrefHcAR2IiK4F4DJQMpkXU8DtjNviR30bPSxDD1ZXMuGRtatgPilGuj+kyMFppYQZvWz85YS6cYLW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by IA1PR15MB5533.namprd15.prod.outlook.com (2603:10b6:208:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:39:48 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:39:48 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 06/19] RDMA/siw: No need to check
 term_info.valid before call siw_send_terminate
Thread-Index: AQHZ+oDQtzMP34/Q90KAstD8N96zXLBai5Hg
Date:   Wed, 25 Oct 2023 12:39:48 +0000
Message-ID: <SN7PR15MB5755BE68DBCA735A05A7BAC799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-7-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-7-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|IA1PR15MB5533:EE_
x-ms-office365-filtering-correlation-id: 0b00161d-bb3e-4b0d-7649-08dbd55779b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5m+RhY7UOMT0MfXei86cAZ++nVk6OF+n4r0HoPaYmaltc5kNwmqR/MHgNpNls0J3byBl1dPR++SXZiU00rS3Ic6tmU34qVQPoL6WrZZpKy/SwoHaNs4oT32Y6T6FQzTg/0hsi0ZZRBk7BnCJF+Fv4unUr8yNIP5T3mhPqaMyOONscK0zzyvgRyv8vKnKrL+kdsTqQ0qt6gB08oZp4DGn0QUOf84H565QWbzq3nRwcZVohL2m0rZ0xeO5dsPOzTrz3oVcKw883/y/nxt5sb2Tb1Y1F5tdfU57W6gQlq2e0lnE14X67XwL2y2ode0cR+FnKCSkpNHe+aHr1/nHx93hvRXGW9tcbCaEMrBG8ShJaHt/Jk3WlbfWgdE+IJCOmR98aNzYE9T6WU7ZCRUZltRA0AnOp0M3ZX9mdsYqgRTqNMTl9xNKZZ/qCL6lEh54qahWoARxG61nJ674fx+Z4VdRTJWuMFXlV7YQKBc5Zz2felP3O+cwuhUIq1VTgATuih17/N1vEjKJFR5XKFBttzjsPNSkEaoHUR9rhqi0xFhmexnAoaQYFtp9d+DryDlVpMQdYfKzg1yESwk5Xm65y9w3NUAHiETzj+XVNO8TLyKrAf/8BWz66/o56FdWHf6oNYEJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(53546011)(7696005)(9686003)(71200400001)(6506007)(38100700002)(110136005)(316002)(86362001)(64756008)(66476007)(66946007)(66556008)(66446008)(76116006)(55016003)(478600001)(83380400001)(33656002)(41300700001)(4326008)(52536014)(8676002)(8936002)(2906002)(38070700009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFd3QjYxT25xb1U2SEpQSlNoS0cvcWNYUWFROUJCc1BjRDhtd1k1azZWb3hQ?=
 =?utf-8?B?ZHRuNzBoRGIyMXdoVE56SHV2dnVGWmN6Ymk4dHg2OCt4TEtBdmx3TEkzQnpV?=
 =?utf-8?B?WWFHTXc4YjdMR1dCV3grVXYvOEtiS1MwYzFQa01manNTRUczaGtuT2lncTJw?=
 =?utf-8?B?dW53LzFZR0pzMzhvZjBEdUlMOHFtQlRJWTYvQk5mRXpCSDhCbU5TR0ZVbmlL?=
 =?utf-8?B?VE5FSkwrK3RDUEY1K1N3djFqSmZGZjNpK0xmckdYR1o1R051VkdEVmQweGps?=
 =?utf-8?B?U3ZrM3JWN1hrK21tSG1iTXZ0cjFBNGRhajNRNTV6SnVYT3ZDenJYMFp4d0No?=
 =?utf-8?B?SmxvMkhES05obUhZbWdOb1A3T204dUV0ZVYwZkdnSFZ4b2JoaDMrR2hZVXJs?=
 =?utf-8?B?d0NWcFFiWmpVRzlVTjdQcWxCK1RzZ2hnekdOVFdIKzZPOUUzR0ZpVWRMNmVL?=
 =?utf-8?B?SXF2bTFVaTZWb3ZsWXVidm1aRGdvYWkweEhQNDNFYWxjT2VEbWNCMlJMbTZy?=
 =?utf-8?B?YnNZZ2FtNHdaZmp5K3dzM3Bvay9TUE4wZWVuYXpUNmtwWEc5SVJLUnYwK2M3?=
 =?utf-8?B?WWRYQ0ZGWXAzbTFVNERCNC9pZmVzYys3NDhrU2pMU1N3UDJqRWZzUG1Pc1Rn?=
 =?utf-8?B?cS9UQnpQZHRiS0JyVGVhajN4am1GNlYwSmtWNTE4WEZVQzI4d1ltbXhZa1lO?=
 =?utf-8?B?U1g4dUlSS0dIZ3AvdDBVOGROeEF2bVdQUklMdkh6RXpyd3FpY1NVWkY0SFFy?=
 =?utf-8?B?cE5VdmU2eGZldTNzNmF3Z3BrWFhiN3JoTVBFdk1vL0xjRXNoejVMNHJEOUtm?=
 =?utf-8?B?UVZCaldYdWdYNU5FZkwvTllnRENiK0tPYTE3RDlDRks0YzhJTUlRRHF6R3N4?=
 =?utf-8?B?Z3RMRy9TemtvaURqZlFuM0g3eWRGZkxYSDFjcGcvd2YwRjhySFVRSEhOd3cy?=
 =?utf-8?B?U2FoM1d6L1Bqa1lxTXA0cWlZOGV1U25LTURHZm9RcittS3hSc25jMEtyQWQy?=
 =?utf-8?B?MmlGNDlVNVFPMWJPaEttTHJlZTdvQnRLNjJhT3NZRVFTbWZuUDlGQ3JjR2Zz?=
 =?utf-8?B?cmlxTXgxY1lIaVd0TC9nV1d2dVlnd2dlRmpTUXpxZW5sdXIrcUhERXFDVGpN?=
 =?utf-8?B?ZHlOcnluQmx4ZjI5NDdYcGt0TEFOTVczWVljUTd2Y2RFdXhSbnhsbzhjVFRU?=
 =?utf-8?B?WG1HeVFuQnlPQVlsdEF2K0hNcko0cW16MENBTUIzcGlkMTJzMUZQL0E3Qkxs?=
 =?utf-8?B?SG9CblJ4V3ZUNGs0b3VPcmw4dGwwMVpHNGxMamVSWkp6U21LSVlXeXh4L1BB?=
 =?utf-8?B?c29LVnJ3RHRsbEF3cll6aTZCRlhyM0pEWEROUTNKcHFhVS84Sm9wMllQRnJi?=
 =?utf-8?B?UTZDVjFjN1VnbGtPQ0hSd1dYTzJMa3hYREFiczBrR0o5Q1VpMU56dHZxcVFQ?=
 =?utf-8?B?VDdVMDNENXZGdEhYV1daNmJ1NGE4KzFxUmVrNTFGUC85a1JjMEJSUUthSGJp?=
 =?utf-8?B?Q0dKdCt3NnNVSlFucTFHaVpWT3VwdWNGcncvdzVMdW1ONitTQmY5NEFvK0cx?=
 =?utf-8?B?NTdOdTVCWTRKcGVEUFI1QVBaRXVzczAyOVhvbHRpNmNabEpGU050TTI0eFBM?=
 =?utf-8?B?enN4RGY0bkYrYm5FVEY5UllyT0RCZmFOZUo2dHNWa3cycG9kM2pSandmaHJv?=
 =?utf-8?B?SFJ1MnhUQjBWU0dmMStnbTdUVzEyVnM3UE8zdURvOFBMV0IxQTdqYVg2OXdl?=
 =?utf-8?B?TitaR0ZDZXRnVHRhTDd2enFMU2JReGhBVVFIV1dHQ1JLQWFTbXBTU0NiN1lO?=
 =?utf-8?B?cjRWYVVlQjNaUHZ5ZzFUd3FyWWNZMzF2OEtqelpuYzRBSHJHRjdOQlY5dmc4?=
 =?utf-8?B?MW1RcjhjaThCWGFxSmFneVUvVUZIVVVUSXlNY0VadGpBekpFeWV5SUQrWnV6?=
 =?utf-8?B?NDdlY3FpK3hVOEdHWVVVUThPdHMvaStDcUJvaXZqUG9uQjBvS0NvWnVlRHVy?=
 =?utf-8?B?Qjg4YnRkZDdMMTVMUjhZN0JSMzFMbEcxdDZRVjBwTEtsSmdhRWVpR3Q2QkIz?=
 =?utf-8?B?cXVMYXdtamxSR2ppemlPUHJNc1ZaZkRKMjJJTElKNFNseTU2czlGb3llc2s1?=
 =?utf-8?B?TnkwSG1mTzJJRmFmZE9Mem9CWGZ3MG9mZ1hqbTVHU2N4dVE0WTJSa0ExK2kr?=
 =?utf-8?Q?7iqU7iqDW1EmQjsF/typ/+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b00161d-bb3e-4b0d-7649-08dbd55779b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:39:48.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OR8si44RPujVZXWCblnZpeTp1A/iXn1P0Tfb1VGMj7qIbM6yEeJu7H70hE7HffL8SAmvyVoASacudFsBv26sLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5533
X-Proofpoint-GUID: CCrygE6ubSUlPuT3Ht6oZMSsgHolrHGr
X-Proofpoint-ORIG-GUID: CCrygE6ubSUlPuT3Ht6oZMSsgHolrHGr
Subject: RE:  [PATCH 06/19] RDMA/siw: No need to check term_info.valid before call
 siw_send_terminate
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=865
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDA2LzE5XSBSRE1BL3NpdzogTm8gbmVl
ZCB0byBjaGVjaw0KPiB0ZXJtX2luZm8udmFsaWQgYmVmb3JlIGNhbGwgc2l3X3NlbmRfdGVybWlu
YXRlDQo+IA0KPiBSZW1vdmUgdGhlIHJlZHVuZGF0ZSBjaGVja2luZyBzaW5jZSBzaXdfc2VuZF90
ZXJtaW5hdGUgY2hlY2sgaXQgaW5zaWRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBK
aWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfY20uYyB8IDUgKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X2NtLmMNCj4gaW5kZXggMGExNTI1ZDc2YmExLi5jOGE5MTE4Njc3ZDcgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiBAQCAtMzkzLDggKzM5Myw3IEBAIHZvaWQgc2l3X3Fw
X2NtX2Ryb3Aoc3RydWN0IHNpd19xcCAqcXAsIGludCBzY2hlZHVsZSkNCj4gIAkJfQ0KPiAgCQlz
aXdfZGJnX2NlcChjZXAsICJpbW1lZGlhdGUgY2xvc2UsIHN0YXRlICVkXG4iLCBjZXAtPnN0YXRl
KTsNCj4gDQo+IC0JCWlmIChxcC0+dGVybV9pbmZvLnZhbGlkKQ0KPiAtCQkJc2l3X3NlbmRfdGVy
bWluYXRlKHFwKTsNCj4gKwkJc2l3X3NlbmRfdGVybWluYXRlKHFwKTsNCj4gDQo+ICAJCWlmIChj
ZXAtPmNtX2lkKSB7DQo+ICAJCQlzd2l0Y2ggKGNlcC0+c3RhdGUpIHsNCj4gQEAgLTEwNjAsNyAr
MTA1OSw3IEBAIHN0YXRpYyB2b2lkIHNpd19jbV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3Ry
dWN0DQo+ICp3KQ0KPiAgCQkvKg0KPiAgCQkgKiBRUCBzY2hlZHVsZWQgTExQIGNsb3NlDQo+ICAJ
CSAqLw0KPiAtCQlpZiAoY2VwLT5xcCAmJiBjZXAtPnFwLT50ZXJtX2luZm8udmFsaWQpDQo+ICsJ
CWlmIChjZXAtPnFwKQ0KPiAgCQkJc2l3X3NlbmRfdGVybWluYXRlKGNlcC0+cXApOw0KPiANCj4g
IAkJaWYgKGNlcC0+Y21faWQpDQo+IC0tDQo+IDIuMzUuMw0KDQpUaGFua3MsIG1ha2VzIHNlbnNl
IQ0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
