Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798F57D6C1A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjJYMj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbjJYMj1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:39:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D673AC
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:39:24 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCJBKx010324;
        Wed, 25 Oct 2023 12:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0Hu2r8sjwKYYHJSlPNCP7IXUBLMQGxoaSg671pnR9Nk=;
 b=W5AYWWHZueAn865e6Wx+3X9Q7tpawXuKpMbVXflzM0ARJg8vAcvqRiwxjBXkbnI12HgQ
 5L0tCApuur3eWIF9qiNY38QBf7rCrXXMsCFUuzqEWLotvxlJ9FaoA892ljJIZKiLasjL
 NVYNm8Y8782idZeEuD1zrcPnyxJOJMj5vvP2Qhd/kgCCUKoCcas2ptkIMvDL0k4ynfdy
 XuJ74v1GmEi8xlSJnsFbOt7l925fFIPMTyxQanUakR3YM9Y550pxQwJZeYqOCB8wMQaW
 Mmk51IkUlxNPiZdP2nrDsKmepjvLFDp/lSgppeB5ZG9l5q3g/PfUfIEjdF3OadUX05M6 eA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2wv8x3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKETOuSOQUb2N7Bt+Ejyuhr58Ap9iLAurn0fFIsAaQ5xZQeCuSZUEjDw72v7SaOpsG2FYug/e0GeRgQC8J+DAfASfnrWMr4r8CY87ArtcQu2iTXCmIsEe/20ZXfkcdC+sZjdOefEJ/U0PH4Ytz/KonsF5gTX4CGjv8lMuH6RvjPHi2X0jOSC6YNSRoCXQOtDHE17h5DPPeQWI2xX8mf+4JJundpr1kiEyv/f9fna3y+fRwCu7toVa+Mkt35w71/3KpeIDheoIJWMpgKiUL123Vnw5k76QNpTN0UrLEpKUn0wO8Wd6mG6K2e8EBs782gQGtM4YUzcrxNQjFlF/QbhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hu2r8sjwKYYHJSlPNCP7IXUBLMQGxoaSg671pnR9Nk=;
 b=dLefo7viZ9opVrQcoszs/2vF0pj15nOKIV2NkqG+sXlD9M1nDGUhdM5C2m24SZRYG64S8FrfVTffYDrCJyFK0EONvYrWSGXthLCjip7mU0ofay5PitYNVdXTozljcYu4fFqVBzmWJFGtpZXkYS0BtiX2XzvhaoGD5wFRA7kd98Zrs91F26b/mY8zyqFjvNymmQLUxy9WXgmUpQCidUENRE6IESH9sAweKCj9ZDmZrkJkdGqfhI3EYNwNQlVTkmKA1H5Yicr+hYi3Dt1t4U9niD5ETV0iDh4CIX0yZag/TxxGHontPIFtwzOCgwqMSq75SBnw+ajgh40OJwjCXHYb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by IA1PR15MB5533.namprd15.prod.outlook.com (2603:10b6:208:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:39:18 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:39:18 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 05/19] RDMA/siw: Remove rcu from siw_qp
Thread-Topic: [PATCH 05/19] RDMA/siw: Remove rcu from siw_qp
Thread-Index: AQHaB0BFlOgG+s0yt0KDBDc/6yZ12w==
Date:   Wed, 25 Oct 2023 12:39:18 +0000
Message-ID: <SN7PR15MB57556328CAE337FF9B8BBFB699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-6-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-6-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|IA1PR15MB5533:EE_
x-ms-office365-filtering-correlation-id: 67fc653a-8790-4915-12c6-08dbd55767e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDcs4vYwDhs3BTnhv+C7RoqKLz3PrBx+2QMKlx10Laf37dHN7Lzjgse1TUMiwtBJRyDQLFKtJ6E+ZiaTWPd/3sul5yUrcZL0hQ4Z3Sy0HudJvKvCDzKEnDhjb0tFgWsdamaHKNTNsV88zUM3/zUgASsiAJeVAKd+Ykp+BPK6H9+xihzCSI1VFJ9lujEBJiBNQ+qktqxzITjNJ5V0HL0YrOTAEQMJ6rJwFV9dvIVkd1xvYsccd6GYxbTv2eJCXvuEVZ8Gm+M2qrKt5m1RM1ITRWNCWuc+twMv0Cayv8+NFEkKjIIl/chLY3neKdCD3dSGUYH+u8nUBPOrixkq6yDFvrah4jovtwXnSOJIqjDTBco1Xxx3i6D9HFrRygY5IGnlU/ZUm4MX2F8w820q+F35cvTt8C5dR4UcoyTOqX4usODRwLAa47qQIvRrSYAfNYbRK6euH6UMiT8WLvFLZKzs1KR9xAVt5Z/eRhbn+o6v4NZBTc8ebrn4g/bigDjcknPZHpJ9/9jpmdS/vJLe2lT9Pw4jUYoGTIE9Zx5nNPz7n1bXPEtP2ZvbpMKyn90fp4DaDLgBdM8irpuFEULjqi6hXtXlvXW181nGTfRJ6QQnoKHwqsIeHJhPIUvfpukwEbah
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(53546011)(7696005)(9686003)(71200400001)(6506007)(38100700002)(110136005)(316002)(86362001)(64756008)(66476007)(66946007)(66556008)(66446008)(76116006)(55016003)(478600001)(83380400001)(33656002)(41300700001)(4326008)(52536014)(8676002)(8936002)(2906002)(38070700009)(4744005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1Sc1lIN0sxVnZWcDNzZnlZWm0wR0kyOThGa2JCc2RXMmF5R0VNRFdYVXlw?=
 =?utf-8?B?MlR4T1RPVmFFOW9HL0tWUW8wc1o4Q2JralFFMVhTUXY0dmNQN1R0UTVEeG96?=
 =?utf-8?B?c0pyV0V6V1pBMXIvSm11SVEzaE54bGozQWFFS3RNbnNmaUV2Sk9JVit6MS9X?=
 =?utf-8?B?V1gyb0Zaby9pNTJkNDg2WDlTU3JrWEVTMXMvYjRXL0t3QlpXM1pVTUhVaWFE?=
 =?utf-8?B?U3ovdWZnRjFuQlpBeklkNXk4VzNXMGhBQ2hGM1FFbHJVaXRnTFdKcXV5L2ox?=
 =?utf-8?B?VU9Pb2JtdndXREs0MDl2T0xhTmpmNGxBVERYNWJiNFlTVktLRC9Rb0w1cjVt?=
 =?utf-8?B?dS9LdERsdFZqbFlEdFI3NnFKUXdObzVEeGRWRXVNb2w5N1F4MlZOcWxJeWls?=
 =?utf-8?B?bVk3d0k1enJrRlJSTWxwM0lIN05zWHBsRnhTa2ZzL0ZvR0IxT0tqdEFod2VM?=
 =?utf-8?B?T21jQ2FOSS9hR0R4RThxek5hbldXQUVDUHE2SVdsMG9NU1Z6cjRMTHN6K2lv?=
 =?utf-8?B?dDI5OUNkSXRDTGhNNWkrRnp4bWxuSzljeFgzOXQwaWc0T2MvTGJIOWJoS0N5?=
 =?utf-8?B?QlNQaXpLekNhejIyVFg4bEVqRjJPUmlQVVhFV1ZKZzlUZWFtcFFxM0dJTTVW?=
 =?utf-8?B?L0pQM3UzZXo5UmxQazBOcFBmNUE0NE04RkRTRXcxYUswSVVDWFIxdzMweDJv?=
 =?utf-8?B?RTVFMlp2NTJsSWMxQitkWVdlV3BKeXlRamxNcDM5YURIZEp6STNQNWptWWxR?=
 =?utf-8?B?b1p3c1RjdmdIL0FhWjRwOXUyZno0bFRPbWt1Q3NYNXBuaUFlRnAvTDYrQWJw?=
 =?utf-8?B?RmRwbFMxWHFNTTlFUVVzdy9wbGhNamlzdU5yNWdWL3k1MmphUkZqcXkwYzYz?=
 =?utf-8?B?VmdnRzduelZ2Mk9uSTBpSGd5Y1JrRUtFeHdhektjNmFKS2JoSG01emlEYUhZ?=
 =?utf-8?B?SDA0WU5HZWtGU2hPcHBLUGd6a0NWM01kR0tIcndPdDNPWCs1NkVXTExjcTc1?=
 =?utf-8?B?a2oxUmZyUGV2bXlSWUhSaFBEbXYzR3dvZVdWdWZBbTZIckhjZXBiVEc0Q2Ra?=
 =?utf-8?B?V29tQlp4MnhQRnlMOGxRcjZUV3p6UDc4WHl2T0NnaVIyOWJIMkVTRWhRVUdE?=
 =?utf-8?B?WkVWS1NNNEhiODhKUUJPV0xHeXgrbTVXbWhxSU4zYWhDTU1YK000THpELzlS?=
 =?utf-8?B?R3JMRk1BaUg0OFJZUEtTcys2Y3lGQW5pNURxMzhWRVhLb1RLQS9Tb2QzdG5O?=
 =?utf-8?B?VUZyVjZEMjZwQ0M2SmdVd0h3N3MyVjlTUDhFYkpFNmdpZStNb2h6OW1ybjB1?=
 =?utf-8?B?TnJDcFlUNGs1akFHYXY1UkhnbTNFREJnQlFJVXVaVkRRYkx4VzNwc0lrV0tQ?=
 =?utf-8?B?aUx5MXUvSVJKK0NTVXZTV1ZwdDZpaUpTRUhBdWRoUVhGb05NT01aVnpjeGFB?=
 =?utf-8?B?dytUN2FweXp5aitmbzlIOTVkMENSR2hDWHNiK0dmbjltRmQ3L3pLay96aExk?=
 =?utf-8?B?Q090cG8yT2g5Tyt1Qy9La01ZMmRkUUF6Y283eXprQkRidHU0UWFnWGVjSVJE?=
 =?utf-8?B?ZXdTZ1dVNFFYRFhjSTVaZmg1dVh0OXljRHZ5UVhFN2V6Y29rSWk2K3dPZ0w5?=
 =?utf-8?B?Y3lCOS9pNEVWMU9ackRMaTR4OUl3MUlZb1hFQlB6Ryt5dE5JenZTa3B2anQy?=
 =?utf-8?B?ZFVhRUFvelJIVlZDNm8zV2VsSzE2U3ZUSS9mTlBIZC9KUTYva3hkM1QraWJp?=
 =?utf-8?B?eWk0amVLNmdLNDkrRUxLY3ozU1dqVmorbUduUUFaa2FWZk1lRHU4Z0dEanJw?=
 =?utf-8?B?ZlRWeUIxYldVUCtDK3dEbVdsSVZLTTNvR3pUTHh1ajhnbWtFdW8wOVdsNzZo?=
 =?utf-8?B?Sysva2d6eGxUc1NibHdOazlqV1FUa0JDMmZpTzZ0TFdTMDNTcmRBSmlVMFhz?=
 =?utf-8?B?bXViQ2p2RDB2VWFnYk1PdzVFSEhGYUgxSlZkYVl2T2hOTVdsN2VYbkhTWU9B?=
 =?utf-8?B?Qy9QSzJmWGs1QnpWOE1QU3lOZUpzWk5RS2ZseW96U0twRFR3NVBCaXEyMWdn?=
 =?utf-8?B?WnpCZmE5alljbVZrQ3p3VVM0MFJuY1lrSytWZHFaYnQyeDZQcEJKd3VubXNT?=
 =?utf-8?B?clNvNGVmUldvWW1lTlhhWW9GYUdVdXhxeEJlMDFRSzV5UHhrRU5rRW5aWTM2?=
 =?utf-8?Q?fE/cQLpvyTClMweUo8XhbjE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc653a-8790-4915-12c6-08dbd55767e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:39:18.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/fGUbAa0JZlUOST3XpcsnQ2fZTLHkCZlcjKh0ts0WEl2llncYZJU+rq17QlNDaxfhNsscH9s7RB6xTj/t3VeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5533
X-Proofpoint-GUID: CLyLBrhIbDy2IxXuE85p5yA1MKr0s9Y2
X-Proofpoint-ORIG-GUID: CLyLBrhIbDy2IxXuE85p5yA1MKr0s9Y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=677 phishscore=0 spamscore=0
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDA1LzE5XSBSRE1BL3NpdzogUmVtb3Zl
IHJjdSBmcm9tIHNpd19xcA0KPiANCj4gUmVtb3ZlIGl0IHNpbmNlIGl0IGlzIG5vdCB1c2VkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5k
ZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCB8IDEgLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXcuaA0KPiBpbmRleCBjZWM1Y2NjZDJlNzUuLjQ0Njg0Yjc0NTUwZiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npdy5oDQo+IEBAIC00NjYsNyArNDY2LDYgQEAgc3RydWN0IHNpd19xcCB7DQo+
ICAJfSB0ZXJtX2luZm87DQo+ICAJc3RydWN0IHJkbWFfdXNlcl9tbWFwX2VudHJ5ICpzcV9lbnRy
eTsgLyogbW1hcCBpbmZvIGZvciBTUUUgYXJyYXkgKi8NCj4gIAlzdHJ1Y3QgcmRtYV91c2VyX21t
YXBfZW50cnkgKnJxX2VudHJ5OyAvKiBtbWFwIGluZm8gZm9yIFJRRSBhcnJheSAqLw0KPiAtCXN0
cnVjdCByY3VfaGVhZCByY3U7DQo+ICB9Ow0KPiANCj4gIC8qIGhlbHBlciBtYWNyb3MgKi8NCj4g
LS0NCj4gMi4zNS4zDQoNClRoYW5rcywgbWFrZXMgc2Vuc2UhDQoNCkFja2VkLWJ5OiBCZXJuYXJk
IE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==
