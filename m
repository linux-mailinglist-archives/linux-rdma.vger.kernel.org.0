Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F457DBB0E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 14:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJ3NoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3NoE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 09:44:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ABCA2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 06:44:02 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDHQOY000635;
        Mon, 30 Oct 2023 13:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8FMBAePYfhUhEgg6SLurhoBSZ95GpnZA1asBy1QicrM=;
 b=qABzpj0xG7IEEpb0Mt/HvfDkIy3XTwKo9fnbUbnE7NA+QmUEN2URqtV/tOj8Ocv+zh+l
 nq4fFQeCHwHAN36kktK8JUxe2hTm55UpYMFtrPmuwVV1OqQ3LOGMszled8d+xWuXu4XL
 ykQVTsEbgB/YWI/xMkFz8qd3ngEqMbWV3+R33MFtHSIYfniJqJXN0SshWZ9RuNz97z3g
 u5RPrGYUJif16fAJqRepK5c3Cdjg6obBuWHzxG55UpDDaSkVN380pFHN7LxP8nCvU2Xo
 YWFjGcSds8kfygutdln/wGBf91kMIhfPjdp+qwl+9Cp33gUKNd2AYx+NOPBUaOpmRJhO vA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2d848uk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxGFYGp82l65wNfVVBJSI5zirJjBu/P3ls/vKkHU16d3SnL4SQ/+Df4/TCCjd6Pn+wyzNaGei3aM/dQNmYWRC9onVoMN+7iy/7y5cLEO9WJ7+Kr01jRvcc9T2iqIpp2YdANnNmO0EKWU8q//bsTls6WD44rbjk4uN30I3O+s/CICqHWJcJTdZKzeIalpxfQvkD8A/naxKqQ6Uh3GXhFzmM6SJ9mY+FN8AmvgCBBOrr89yHua4E7UZFSSotw/TCHa+f6WsvTDbq9/w2t9zyglCPAaI0QrsewZIvt5aDh24k+SzxRSPfUyf0hjD52owL6TC0Ec+9gl8miH6vpUjSHj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FMBAePYfhUhEgg6SLurhoBSZ95GpnZA1asBy1QicrM=;
 b=eViivWKCQlr+r/rsUcXnisY7QIpUh+SDxjlU4njaLYsQKh/5Ts7M4zfADSKJwFSo3X7HO/ieh6KBgox7K3mGe7wrCCpo9gSaFoYgiRZ0ISJ68JI3/v9xqmN+DJoANQrVSBYz9jBXfG7YY9pwvjJkNNBQ7ygKgcPeFkWedxpZl4qbDPZglcItb197DGGudNkMzI2lB2mAfDDQT48nEGE11tgz77rYPaP+Kk6Codm2z95n0kt5wlb0NjDzcxZfd2FbhS15dm5EpwvDZ6TJAibFNnHQIsC8T+xtDWuAoY5aQwEd7mcnaqmvwfrybdxMDUx7vur5N9T6WwOg1JpXYqEcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SJ0PR15MB4712.namprd15.prod.outlook.com (2603:10b6:a03:37d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Mon, 30 Oct
 2023 13:43:53 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 13:43:53 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V4 01/18] RDMA/siw: Introduce siw_get_page
Thread-Topic: [PATCH V4 01/18] RDMA/siw: Introduce siw_get_page
Thread-Index: AQHaCzcevXSn207cFk2tXyj0guCbVQ==
Date:   Mon, 30 Oct 2023 13:43:52 +0000
Message-ID: <SN7PR15MB57553C3DE74E621104F0C82E99A1A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231027132644.29347-2-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-2-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SJ0PR15MB4712:EE_
x-ms-office365-filtering-correlation-id: 063258a6-4258-4dbb-16cd-08dbd94e415a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMYHXZV+xmHTMmPGJ/SmvWUZf+FJWgC38y2JmPDKt36rp5PgfrA120XDJhI/aY3LlLh18O5elMnyWq6vfWWfnSQUc4nTFP3aqyU4sUAywNk9sCYSG9qWHxXtYn/8PUp6YT6xcqfEE3ZHdUrczoPvtN6svE6xxuEn85bB+FglWbRsf7qolexUERpLeWZPm5UJKUfC20yYqPLjWNimikWJfcerIiUrfdN3jW7mmvsJjSsPPfeW38jqUtMrpETA1eo6KUYBDXpqZ/yjzb5+Lo+fzMZjWRoDFguvPwQoBtePFpZZE5ItAdeion9cOQqaSltjvpMZM9Y58yC1GHvD3/6+Yvnog1moTFJuiRAmUFgz4w+nDVrLjUeYigtuFgdQ8gIQvfPWFjprBl5Zu5bD9ZiOIEAta/3RjvhuTUbUZIq3kXu0fqQ9eaB7s6ZZEaYWKDHzJ8r6RoHwk0rmkhFI/cNHHYXGjmyIupr7HLQv85+EQK+GiU1mcYgHc6f/dzu7jeZxldGtyTbMaNdK7Jl2QmNiR7r0T+t7G1pCY8xX1pwxn7Sbb/nromVPg12epFgpXSKWSfM3HwROUPFq7L53Xb29Vc7t/NwzR3qX9z4NDfNKXVijJoFoilniZqmCZKFyxMoy/IwBaYbqu3YUrWJonARhg1IdT57K8SnjHiimE4z2114=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8936002)(122000001)(26005)(9686003)(53546011)(71200400001)(6506007)(7696005)(83380400001)(478600001)(38100700002)(52536014)(110136005)(4326008)(66476007)(76116006)(66556008)(316002)(64756008)(8676002)(66946007)(5660300002)(66446008)(55016003)(41300700001)(38070700009)(2906002)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFcvU2hMbHFickwyM2NINTdVTGpDZTZtalJpei92T0w4d2tqdXF6TGNRN3VM?=
 =?utf-8?B?aTlqM0htVFVzR0tQbjlFdmVEbmtHKy9uRE15emVkVFBZM2dnVHQ0bEs4VTlN?=
 =?utf-8?B?T0xUbGpybDRtUDJqQVpCM3ZGb0NzK3pBWWxJWTRadlI5T1QvNVBKcHlZbGl0?=
 =?utf-8?B?UTBUTmpvaUNzV1RRVG9FQktWTkM3UkNzNmlWNnE0WVBveFl4S0JwOXpUSEd4?=
 =?utf-8?B?RkpweUluK1NFT21ZYkJSU2tIOHpwZFNGUFhOUDFYT09OSWUxQTZIeXdFcmdH?=
 =?utf-8?B?QmNhUFJRcXplUHUyMjdpYklBVU9ER1NRdnI4dEI0SVMwL1NibFM5cFc4blNt?=
 =?utf-8?B?aDBrVmFndVByZDBQbWs4Y0lSbVlXL0hzc0lLOFVvQ0hQbG9Zc0Jka3RROVRl?=
 =?utf-8?B?WVBLeEhqcWZGRnZoNEVWTTduTURGSFp1dk9jYzQ5bHJzWmlhRWgrTnpFWkZB?=
 =?utf-8?B?dVlUWGxRdCtQUmQ0Sk9lYXNNVlgySVd0WUl2Z09HSDU4cEp2VlpneWNjMlNw?=
 =?utf-8?B?eXphNHJKUGJxMUtHbWk5WmdabkpDS0FwSTNBaXZaazNpUUhmTGt1TEZlb21D?=
 =?utf-8?B?RFVLUXJXamdUWS9NOUpCU3cyTWtFL3VqbnpzcWpjeVAvT285ZmNhSXFVSjVE?=
 =?utf-8?B?QzRkaGRWV0V6Z2t2THUvQWlFUUR4VmdBcHdianNZalppT3Q5NUpYVURIbEpv?=
 =?utf-8?B?dkR3VDZLL0gvYmVtUmpJSkYxOEZSU1pER3NKV2kyK24zQTV2RWYyZHNaaDUv?=
 =?utf-8?B?dnhNQXg0YnR0bVlDQjFjMHphUGpuQmxhdnJabC9GNzdXY3lzemw5OW1EYStu?=
 =?utf-8?B?cmtHaEFQOHZSRlk4NnQrajRDVXVsM0QzMUVjZnB6Mk1wMjk0Um5SdmU5UTUy?=
 =?utf-8?B?Y1c0ZWpmL1BuZWVxQndRcmtDOVBHcmZlTUJ5dXoySktXUGljYzEvSUlYUVZ1?=
 =?utf-8?B?b1ZnRnZCWlkyN2V1aDNTSUdtUWM0eDRZaHpXNXVGMjlSTGpTLzEzVmVnVzQx?=
 =?utf-8?B?VWNKdEpLNmtQRDNDdlMxVHRzcW10UTIxc092STBBMkdxdWF1RUg0ZmE5ZU0x?=
 =?utf-8?B?cGI4MnAvQ1hEcGVLNWZUeXMreE9DdDdxS1duLzlkcWhUU1RzbUtMaWJvWjFL?=
 =?utf-8?B?TTVuZElJdjliZDRWeEZVRWdRZEtTenU2TDVWbldyWDRpejZuMkRzWWlwQjFF?=
 =?utf-8?B?K09Rd3kwVnRSWCt4WGc0cmhrKzcxYllXR0djek1sTzUvSDFSRGpzY3RrUlBk?=
 =?utf-8?B?TWVSR0o0OEdvWEZmckdoUEtYYlIrdURzSnhjOGp2cS8zc2liN24rSG1hL1dH?=
 =?utf-8?B?N2h4eWV3YjBCRk1iMlFTbVVxcGIzaTVkRFhSSHhnKzRaUldYVWttaUNKajN4?=
 =?utf-8?B?TGtIRXEvSlBuOTB4VEJTSVRDMnJLMHRUOTY3WlpYbXpISjdNejA3Si9VQ2xl?=
 =?utf-8?B?Y2ZxTGtlc0NIcVdwdU9OQ1gvRHRjUTlzLzdrMFMvODlBdUt0dkNueUp5eWlI?=
 =?utf-8?B?STk2SFNpT3pyUFo5ZDVGdDNmS0krTkhvL3krSGVTbFcrN09sZHJKZUdqUTZB?=
 =?utf-8?B?Wlh5eGRWV3RRdjlJdUhuQm1zamI0TGprY1ExOXl0ZG1ydUdobTFweWhIUzNW?=
 =?utf-8?B?a0wvNm83em1kV1pTZWtJcFZVUVJ2YzRlTG52SFdqb3d2c3AxdG1rYm1KQ2p1?=
 =?utf-8?B?R011VUJRSHRFVFdjREFBWTUwc3I2NzRtdEVEb2wzanpwZndPazJPQWdDazVp?=
 =?utf-8?B?SjBqck9XcHgrRmdZd2Y4OFFHTldhdkhwTXJyZWtvTE1Eays2MjNML3BWN01W?=
 =?utf-8?B?NkFBR3pZeEtEZHoyOHNBbnVSbWxHN3dXbWhseVIrTWtWWnBoMUdXVXkwbEJY?=
 =?utf-8?B?WXhpOGMwVmIzZjMyU0tyM0h1ZnlNVVk5amMxaEVGWjBFWW1FeGlOWGIzRlhX?=
 =?utf-8?B?VkQ5WlU1WXl2TCtzY3hTQ1V0bnVMTlpGaFkyQ3Ird0NQTFQyd2tORDNEbTkr?=
 =?utf-8?B?UFhaWm44Y0FnSWZmTUc1cVo5YnVlcWtMTlIwUTRSREZNYmJDZTgxMDdVeHRv?=
 =?utf-8?B?bmlpa05xWXlnd2dmNTdUTFZiNnVWRlJlQmMyZThPZU5Gbmp1ZEgvMy9XV2lu?=
 =?utf-8?Q?dQ2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063258a6-4258-4dbb-16cd-08dbd94e415a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:43:52.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu0Nw85yHBCNAlUjJoNg/ODjZxrlEWniUDE0hsJUASJrA4bxAcfvXjMOFxPiIk8dcsGHnsLt9lwm5Z0uFeBNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4712
X-Proofpoint-ORIG-GUID: gyST-58hpgy5q9LT7a49J9h9FrHH9EPx
X-Proofpoint-GUID: gyST-58hpgy5q9LT7a49J9h9FrHH9EPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=924
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300105
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
MyAzOjI2IFBNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWNCAwMS8xOF0gUkRNQS9zaXc6IElu
dHJvZHVjZSBzaXdfZ2V0X3BhZ2UNCj4gDQo+IEFkZCB0aGUgd3JhcHBlciBmdW5jdGlvbiB0byBn
ZXQgZWl0aGVyIHBibCBwYWdlIG9yIHVtZW0gcGFnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1
b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCAzMSArKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90
eC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBpbmRleCBi
MmMwNjEwMGNmMDEuLjZhMjRlMDgzNTZlOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd19xcF90eC5jDQo+IEBAIC0zNCw2ICszNCwxNSBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnNp
d19nZXRfcGJscGFnZShzdHJ1Y3Qgc2l3X21lbSAqbWVtLA0KPiB1NjQgYWRkciwgaW50ICppZHgp
DQo+ICAJcmV0dXJuIE5VTEw7DQo+ICB9DQo+IA0KPiArc3RhdGljIHN0cnVjdCBwYWdlICpzaXdf
Z2V0X3BhZ2Uoc3RydWN0IHNpd19tZW0gKm1lbSwgc3RydWN0IHNpd19zZ2UgKnNnZSwNCj4gKwkJ
CQkgdW5zaWduZWQgbG9uZyBvZmZzZXQsIGludCAqcGJsX2lkeCkNCj4gK3sNCj4gKwlpZiAoIW1l
bS0+aXNfcGJsKQ0KPiArCQlyZXR1cm4gc2l3X2dldF91cGFnZShtZW0tPnVtZW0sIHNnZS0+bGFk
ZHIgKyBvZmZzZXQpOw0KPiArCWVsc2UNCj4gKwkJcmV0dXJuIHNpd19nZXRfcGJscGFnZShtZW0s
IHNnZS0+bGFkZHIgKyBvZmZzZXQsIHBibF9pZHgpOw0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICog
Q29weSBzaG9ydCBwYXlsb2FkIGF0IHByb3ZpZGVkIGRlc3RpbmF0aW9uIHBheWxvYWQgYWRkcmVz
cw0KPiAgICovDQo+IEBAIC02NywxMSArNzYsNyBAQCBzdGF0aWMgaW50IHNpd190cnlfMXNlZyhz
dHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LCB2b2lkDQo+ICpwYWRkcikNCj4gIAkJCWNoYXIgKmJ1
ZmZlcjsNCj4gIAkJCWludCBwYmxfaWR4ID0gMDsNCj4gDQo+IC0JCQlpZiAoIW1lbS0+aXNfcGJs
KQ0KPiAtCQkJCXAgPSBzaXdfZ2V0X3VwYWdlKG1lbS0+dW1lbSwgc2dlLT5sYWRkcik7DQo+IC0J
CQllbHNlDQo+IC0JCQkJcCA9IHNpd19nZXRfcGJscGFnZShtZW0sIHNnZS0+bGFkZHIsICZwYmxf
aWR4KTsNCj4gLQ0KPiArCQkJcCA9IHNpd19nZXRfcGFnZShtZW0sIHNnZSwgMCwgJnBibF9pZHgp
Ow0KPiAgCQkJaWYgKHVubGlrZWx5KCFwKSkNCj4gIAkJCQlyZXR1cm4gLUVGQVVMVDsNCj4gDQo+
IEBAIC04NSwxMyArOTAsNyBAQCBzdGF0aWMgaW50IHNpd190cnlfMXNlZyhzdHJ1Y3Qgc2l3X2l3
YXJwX3R4ICpjX3R4LCB2b2lkDQo+ICpwYWRkcikNCj4gIAkJCQltZW1jcHkocGFkZHIsIGJ1ZmZl
ciArIG9mZiwgcGFydCk7DQo+ICAJCQkJa3VubWFwX2xvY2FsKGJ1ZmZlcik7DQo+IA0KPiAtCQkJ
CWlmICghbWVtLT5pc19wYmwpDQo+IC0JCQkJCXAgPSBzaXdfZ2V0X3VwYWdlKG1lbS0+dW1lbSwN
Cj4gLQkJCQkJCQkgIHNnZS0+bGFkZHIgKyBwYXJ0KTsNCj4gLQkJCQllbHNlDQo+IC0JCQkJCXAg
PSBzaXdfZ2V0X3BibHBhZ2UobWVtLA0KPiAtCQkJCQkJCSAgICBzZ2UtPmxhZGRyICsgcGFydCwN
Cj4gLQkJCQkJCQkgICAgJnBibF9pZHgpOw0KPiArCQkJCXAgPSBzaXdfZ2V0X3BhZ2UobWVtLCBz
Z2UsIHBhcnQsICZwYmxfaWR4KTsNCj4gIAkJCQlpZiAodW5saWtlbHkoIXApKQ0KPiAgCQkJCQly
ZXR1cm4gLUVGQVVMVDsNCj4gDQo+IEBAIC01MDIsMTMgKzUwMSw3IEBAIHN0YXRpYyBpbnQgc2l3
X3R4X2hkdChzdHJ1Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LA0KPiBzdHJ1Y3Qgc29ja2V0ICpzKQ0K
PiAgCQkJaWYgKCFpc19rdmEpIHsNCj4gIAkJCQlzdHJ1Y3QgcGFnZSAqcDsNCj4gDQo+IC0JCQkJ
aWYgKG1lbS0+aXNfcGJsKQ0KPiAtCQkJCQlwID0gc2l3X2dldF9wYmxwYWdlKA0KPiAtCQkJCQkJ
bWVtLCBzZ2UtPmxhZGRyICsgc2dlX29mZiwNCj4gLQkJCQkJCSZwYmxfaWR4KTsNCj4gLQkJCQll
bHNlDQo+IC0JCQkJCXAgPSBzaXdfZ2V0X3VwYWdlKG1lbS0+dW1lbSwNCj4gLQkJCQkJCQkgIHNn
ZS0+bGFkZHIgKyBzZ2Vfb2ZmKTsNCj4gKwkJCQlwID0gc2l3X2dldF9wYWdlKG1lbSwgc2dlLCBz
Z2Vfb2ZmLCAmcGJsX2lkeCk7DQo+ICAJCQkJaWYgKHVubGlrZWx5KCFwKSkgew0KPiAgCQkJCQlz
aXdfdW5tYXBfcGFnZXMoaW92LCBrbWFwX21hc2ssIHNlZyk7DQo+ICAJCQkJCXdxZS0+cHJvY2Vz
c2VkIC09IGNfdHgtPmJ5dGVzX3Vuc2VudDsNCj4gLS0NCj4gMi4zNS4zDQpMb29rcyBnb29kLg0K
DQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
