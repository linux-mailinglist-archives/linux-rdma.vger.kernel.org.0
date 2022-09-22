Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444535E6975
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIVRRo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 13:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIVRRn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 13:17:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E331E703;
        Thu, 22 Sep 2022 10:17:42 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MH3tHN012708;
        Thu, 22 Sep 2022 17:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=T6fJLGaho4cLWyKK8XYwIq2ZMjnlRp22saMT8rXMers=;
 b=Cj3mkvIF6ENckPiCBZUMwbzy38x0rPrTISBYt6sAd9wA0QY80fIjvDPAFzJu1vkaD3Pa
 JDE7cL1rIW/EqgS8GIOHevn12Y8ATRuY2bG/TnNaof89wlJ0hc+I3h5tjVswqqT5uNuA
 JMzEX43lRogaNob+VkjBC6bXQIl2kRmNkqaoTZsX1MjApuD+6OZkxmTwj/oYQoLVstI+
 ASmGsmzkJ537OXeIBScNidHUfJCxyUDibgtdqZ+M7+dXYcj6IU00WSAS9a1lUPmIF5wU
 QOi1GbeiEBTqE4zDshZKdU8Zof7aD834ifpJrl0K3M5pbGmhN0gIe0Y60fG57Ug8PMeS gA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrusdrhe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 17:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjrbCvO9xKeXh8XLdSQa8UTokSGkVzSrF+HLfBOGTLPb2TDnI5IMO2hd61huFjBSRPhTiCTy3cMcgo46rWd/D/ZZgrsc/PjvK55UC6TJLn/MM8iKWA59vRDXCh3FVBKfGhd37MLL/0/hHuahd+Am/+GYHPnQ+Er6xX7uENGtMOJGdSpQs3JvmG53YZ5jyU4bo1IFkgeZ3d+jCBXrEvK7d/94frNXcsfSNQGagy5Oj6ggpJWxPiYT7F+QoDcESkieh/qV7MgiikhUhBvaqlc/UTnR4E+87ot+ePYPpvt98Zo5KJF5gs5RDCg2gz8dVfx9TVjkX1I9V23VMEnlJEFL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6fJLGaho4cLWyKK8XYwIq2ZMjnlRp22saMT8rXMers=;
 b=YZK77qw9NbGt+GlSQ4VHquJ9PYZGS9UPxZOMxaWNAtfYn2wp6jXkwaQEl0s3pI5bSKMEektPihSEWV/2HNV6AozLxAwPgdbRQPJnM9csoBiwJoltWZ85ov7Mx9bbXMfrNHJ/XXxq9aCkmeQmsjFO5YgYYruh0FmsXQFmEpT3e9A5Ie7Z+xkKcDAslUBtGjO7aCDVi66BT8vJvELFbmtPUH/H3Cn82kpsaDHS+b6ZC8b1N/ZuRzl/OXLWtHKpopLtQUHBJg90XXsddFs+e6Qn478JBnrTvqC5ZWCWRceW+dgjZ86H6Li3VVVEuAcJjzm8iXSt/oXKLQe4n7HKSSpUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BYAPR15MB3333.namprd15.prod.outlook.com (2603:10b6:a03:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:17:24 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%3]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:17:24 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        jianghaoran <jianghaoran@kylinos.cn>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
Thread-Topic: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT
 mips kernel when enable CONFIG_RDMA_SIW
Thread-Index: AdjOpy1kczQuO8VsT4eldX0LbrZu8w==
Date:   Thu, 22 Sep 2022 17:17:24 +0000
Message-ID: <SA0PR15MB3919C9E8260E7DF5FB36A9D9994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BYAPR15MB3333:EE_
x-ms-office365-filtering-correlation-id: 08d4b5dc-935e-4066-881f-08da9cbe510d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dhfo8a+UGlLvEP4v7u4SwP+losIF20kP7eqggcxLVSVfcw1MMNRHVXL67+ygzXVETXpV1dpmya1C/hFWpM5UFhb9FMPxyXSlVy1pbF5SnIzLE00Z2RKs1V6HRIDCPAnRAF/lEs8pS/FFM90vAfB0vSC5PnLd7WAxjLVRKXcDjk5GcifihEetO4ChuYMKhi/oGZCpDumj8+qTW2jLACLV4llAJWGJSee4jkSsRT4xkuSs+8FVDKQaSdVmetxa1cO0iX3kUydimcrluMuje6FVQs10UaP5n7hR4X/w3SpDeOd2QAfghBcfm4GdZCQf7qIvo0jW5g+ecS3yoblmBT4/N7me/pu67B5xnfebNSq53IZgHUqe34kaEolG6KPNsaMF6hbyvy3DMoYMkjxXJ4Kh5+GMyAtm1P3y8AvFCvaUPUqHe+xhfKAfJJz0R2xGJXF48biYD3cBBAsjc53dAK/vbeJ0x8uLYgMOFgEvZZ3dEsLUg6zth4Rjp/WeVE1v/HIEQURVc2uA/dSwRuZCiyV7crt1j9MfSXfBLfQ9zzt5QU4YVwPEnJasF7sszpMHusEHYZ5iYfDZDKxGM9HddbtYt/iqcok0nPu7iU3CRTxnptjWY4D2HGwgsJgFgpKw5TTnRri+zHguHjfuTGR+MEF7wBVqZ+aGOp8a0lbq7LprU4cNCe2pBW8u2r4ybrG+RnBIv2796JChZYDhMBJHFfLVbvWJ3pTAD9Wpjg8+EcWbVuXH3gZM7779DdLnxuOaE0HiH3mI5380/uSZE4DIqIyww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(478600001)(41300700001)(71200400001)(186003)(6506007)(53546011)(55016003)(9686003)(33656002)(7696005)(64756008)(66446008)(8676002)(66476007)(83380400001)(66946007)(76116006)(4326008)(66556008)(5660300002)(2906002)(8936002)(52536014)(316002)(110136005)(54906003)(38070700005)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDNoTSsvb3NDQWNWc0V5QmpGRWFoek5aWWZMNDZ0MlV2bHJvVkxFYzhsUzZG?=
 =?utf-8?B?czIwOW5jUlhkajFsbTRXS3I3SDNnT1N2T1FxcUg0MDBtSFdBMC84Vzg3UVdt?=
 =?utf-8?B?QjRDUEhTQlBmOGxDc0ZXYmdGYytBYWFlcjZsWUFzR0V1THRPNVF3WEJNN1VP?=
 =?utf-8?B?Uk5EQ1NuTkRJUDg5MERVaUExVGVnaDlMdU9pK2hSMm56bHVOSmlYeUxOZDFP?=
 =?utf-8?B?SzMybHkyaGM2NUhqZGVycWJtMGVXUS9NUjNrU1JyY1N5ZnFvR1gwUVhyMjhj?=
 =?utf-8?B?V2tRUk5xREplYXEwUVhPdi8wM1BjNkdlOGZpY1V3UEYwMm9wSlJnWW5mSUkv?=
 =?utf-8?B?M2JLbUNDWE1Cclh6OG5Bekx4Vm54UzF6VjRLVnpaLzNBUGtLTE9xU3Z2eTY2?=
 =?utf-8?B?ZTJ5QWwwUm05cGV3TGxPZFh4YkcwdXZFMjBlbnkzY21kTkQ1K0lWTzQwK0xU?=
 =?utf-8?B?d0RKMUQwQW04azZScGVFb09oUlpoZ09kTG5sOW9aWWxldCtXMC9ocUVkRGtv?=
 =?utf-8?B?KzhKNytwa2JwWXpicXRFL2VhM050b1VicklFQkQ1ekJVUmRGRkZvNWZSYWla?=
 =?utf-8?B?THovem1TajdCZUFzclhSdGtsS3U3dHJXb1ZyZFZ6dFQ4OXpubE1RcWprT1pi?=
 =?utf-8?B?NFl5Vzl4ZHJxdUJ3R3VpWUVSdHg4M2Y1UnpwVFhHSTl2U1ZvelV5bEpFUmli?=
 =?utf-8?B?MllkcDVBWGljd2dSb21IRW9yNXBSMkVYOTk1c2cvRHBPdnhCQWpzY0ZTNi94?=
 =?utf-8?B?WDdJVHNQbWdaVHk3dHlUN0lZOHdMQmNkdU55V1VpMHg3S3d0OUFKbjBMZ3FK?=
 =?utf-8?B?Z012OUg0SkF6UDF4S1NwY2xFTmFMNlo5TW1xUE5wMVlSQ0ZkamdpdUNjOWdI?=
 =?utf-8?B?OGxVYXZZTUtYYThRbzQvNHYzWnE2ZGpQL1ViNExOcDVHS1JubXFOU3FScjcz?=
 =?utf-8?B?TU44cHd4MHpmdElmamdOcmUrcmM2K1BFQnBGSC9EclphL1NRTGdtbnIzNUxQ?=
 =?utf-8?B?SlhrTnFsQkVwOHlpZ24zWktGZ2JBblR0anhOQ3hFUTd1eit2Qk5GQktYL1hP?=
 =?utf-8?B?bFFyWk0wUkIyRm9Td3pMQXVDMlhZTmYwejJZajZlbDl0WWVhNUtiSThnMW9s?=
 =?utf-8?B?YVYzMmp4VmJSRzliQlB3M0ZtZFpielFUSTUyYTFLcUNkdHc1ZnF1STY3Y3JJ?=
 =?utf-8?B?aUJhRTBINGNMaWJ1NTBlL1Z0eDM4VThBUkdudm5MYnFEelBweWFMRzZtM3BV?=
 =?utf-8?B?Y2VJSnFLQ082bG1SR0xiNi9XZWRRZ0xSVW5Md3RkNVdERktKbS9Ea2xISGZ5?=
 =?utf-8?B?bkZoaGpJWkJaMGh2emNCZDd5a282VCtVYi9YcjVSSGpzUGs0a01qWVdDbitU?=
 =?utf-8?B?aDEzcWNZdWdpdlVhWVRtYnFwYVdTN2srR05KREMrbW9IMm1ZTWFCdHNwYTlV?=
 =?utf-8?B?Ny84ZnV4c2YwZkl6U2dGbHhMMGljdWF0bTRzVWNhZ0Q2MXc2S2RCYlc2TE56?=
 =?utf-8?B?Q2hzaWVGQ3RXZVFrV3lzSmRDS2Nhdkh5cmpjdkg0K0ZqRld0Wmt5aWZTeFd2?=
 =?utf-8?B?cTNjVW9lU08rdmxDTXhwbGN4RFVSTU9ScGhiSzBSendTckRNTGtKd1Z4aGJ3?=
 =?utf-8?B?MEU5RFlEbjUrL214ZVpoaUNXbFcrWnNhSjNzWVcyU2ZheWk5c0R6WWdYOEVG?=
 =?utf-8?B?Z0RuOHFPcDNIeHZZckcyTTFZM3dURVlLUHR5Y3hTRGNnR0FvVHM3RGw0NXFw?=
 =?utf-8?B?L1RIbHM0S1A0dlVZazNQQzlRekw5ZHdZTzJ6czY2d2ZhNThvSTBlc2E4Yk1S?=
 =?utf-8?B?Q3Q0dVlWb2RoRnZaclBHY0RWVGVwSWwza0h1ektXOUJRRTFNMldIVXNMcFhY?=
 =?utf-8?B?UEk5L2ZIaFlJdjNaUjJOc25sK3pOZnVQbmoxSHhyUXB5VllDVVYrV1VEM3ZQ?=
 =?utf-8?B?N0JjR2xkVlJkbE5kSUptR1o3cGZEa3VZbU1JZE5WaGV1OVBvV1ZMdnFXVFhU?=
 =?utf-8?B?YlB6TzYreTgrcmJPK0l6KzZQTElZek5EQUdSZ1JseFNPS1hCMklyS3ZKVzFS?=
 =?utf-8?B?aWl3RW9zdHNBc1YzTXBmNjNHVG1SazdQUEQ2eXV5ZjVXMm5RRXBtWnJEeXRG?=
 =?utf-8?B?ektaUmRQSUdaZDFuL0o2ZEoyd1E0ekJTOElOZzlQRnkvakluUnd4YVBiNTRX?=
 =?utf-8?Q?+ZOSUXn4J499tp2JFjz/Um4P6slGa5gvyiI8Vyes6VYs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d4b5dc-935e-4066-881f-08da9cbe510d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 17:17:24.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iDsBIJfYqNKQDYXFz25df4gx/E0z3Yb8p0ZkMNw7yJe8LMbDxhXv4mQzh3HXdBaPsowxc3pvPA+/UdHDU/2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3333
X-Proofpoint-GUID: d2ZANF52_NZknR4zMv5vEBlOaQYyPTYB
X-Proofpoint-ORIG-GUID: d2ZANF52_NZknR4zMv5vEBlOaQYyPTYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1011 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDIyIFNlcHRlbWJlciAyMDIyIDE5
OjAzDQo+IFRvOiBqaWFuZ2hhb3JhbiA8amlhbmdoYW9yYW5Aa3lsaW5vcy5jbj4NCj4gQ2M6IEJl
cm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgbGVvbkBrZXJuZWwub3JnOyBsaW51
eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3NpdzogU29sdmUgdGhlIGVy
cm9yIG9mIGNvbXBpbGluZyB0aGUNCj4gMzJCSVQgbWlwcyBrZXJuZWwgd2hlbiBlbmFibGUgQ09O
RklHX1JETUFfU0lXDQo+IA0KPiBPbiBUaHUsIFNlcCAwMSwgMjAyMiBhdCAwMTo1MTozOFBNICsw
ODAwLCBqaWFuZ2hhb3JhbiB3cm90ZToNCj4gPiBjcm9zcy1jb21waWxhdGlvbiBlbnZpcm9ubWVu
dO+8mg0KPiA+IHVidW50dSAyMC4wNA0KPiA+IG1pcHMtbGludXgtZ251LWdjYyAoVWJ1bnR1IDEw
LjMuMC0xdWJ1bnR1MX4yMC4wNCkgMTAuMy4wDQo+ID4NCj4gPiBnZW5lcmF0ZSBhIGNvbmZpZ3Vy
YXRpb24gZmlsZSBieSBtYWtlIHJhbmRjb25maWc6DQo+ID4gQ09ORklHXzMyQklUPXkNCj4gPiBD
T05GSUdfUkRNQV9TSVc9eQ0KPiA+DQo+ID4gdGhlIGVycm9yIG1lc3NhZ2UgYXMgZm9sbG93c++8
mg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9hcmNoL21pcHMvaW5jbHVkZS9hc20vcGFn
ZS5oOjI3MCwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi4vYXJjaC9taXBzL2luY2x1ZGUv
YXNtL2lvLmg6MjksDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2FyY2gvbWlwcy9pbmNs
dWRlL2FzbS9tbWlvd2IuaDo1LA0KPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRl
L2xpbnV4L3NwaW5sb2NrLmg6NjQsDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1
ZGUvbGludXgvd2FpdC5oOjksDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUv
bGludXgvbmV0Lmg6MTksDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6ODoNCj4gPiAuLi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19xcF90eC5jOiBJbiBmdW5jdGlvbiDigJhzaXdfdHhfaGR04oCZOg0KPiA+IC4u
L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9wYWdlLmg6MjU1OjUzOiBlcnJvcjogY2FzdCB0byBwb2lu
dGVyIGZyb20NCj4gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJvcj1pbnQtdG8tcG9p
bnRlci1jYXN0XQ0KPiA+ICAgMjU1IHwgI2RlZmluZSB2aXJ0X3RvX3BmbihrYWRkcikgICAgUEZO
X0RPV04odmlydF90b19waHlzKCh2b2lkDQo+ICopKGthZGRyKSkpDQo+ID4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IC4u
L2luY2x1ZGUvYXNtLWdlbmVyaWMvbWVtb3J5X21vZGVsLmg6MTg6NDE6IG5vdGU6IGluIGRlZmlu
aXRpb24gb2YgbWFjcm8NCj4g4oCYX19wZm5fdG9fcGFnZeKAmQ0KPiA+ICAgIDE4IHwgI2RlZmlu
ZSBfX3Bmbl90b19wYWdlKHBmbikgKG1lbV9tYXAgKyAoKHBmbikgLSBBUkNIX1BGTl9PRkZTRVQp
KQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fg0KPiA+IC4uL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9wYWdlLmg6MjU1OjMxOiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8NCj4g4oCYUEZOX0RPV07igJkNCj4gPiAgIDI1NSB8ICNkZWZpbmUg
dmlydF90b19wZm4oa2FkZHIpICAgIFBGTl9ET1dOKHZpcnRfdG9fcGh5cygodm9pZA0KPiAqKShr
YWRkcikpKQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn4NCj4gPiAuLi9hcmNoL21pcHMvaW5jbHVkZS9hc20vcGFnZS5oOjI1Njo0MTogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvDQo+IOKAmHZpcnRfdG9fcGZu4oCZDQo+ID4gICAyNTYgfCAjZGVm
aW5lIHZpcnRfdG9fcGFnZShrYWRkcikgcGZuX3RvX3BhZ2UodmlydF90b19wZm4oa2FkZHIpKQ0K
PiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+DQo+ID4gLi4vZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzo1Mzg6
MjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZg0KPiBtYWNybyDigJh2aXJ0X3RvX3BhZ2XigJkNCj4g
PiAgIDUzOCB8ICAgICBwYWdlX2FycmF5W3NlZ10gPSB2aXJ0X3RvX3BhZ2UodmEgJiBQQUdFX01B
U0spOw0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+
IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+ID4gbWFrZVs1XTog
KioqIFsuLi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OToNCj4gZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHgub10gRXJyb3IgMQ0KPiA+IG1ha2VbNF06ICoqKiBbLi4vc2NyaXB0
cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXddDQo+IEVycm9y
IDINCj4gPiBtYWtlWzNdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2
ZXJzL2luZmluaWJhbmQvc3ddIEVycm9yDQo+IDINCj4gPiBtYWtlWzNdOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IGsyY2kgPGtlcm5l
bC1ib3RAa3lsaW5vcy5jbj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBqaWFuZ2hhb3JhbiA8amlhbmdo
YW9yYW5Aa3lsaW5vcy5jbj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfdHguYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3Fw
X3R4LmMNCj4gPiBpbmRleCAxZjRlNjAyNTc3MDAuLjU1ZWQwYzI3ZjQ0OSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ID4gKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiA+IEBAIC01MzMsNyArNTMzLDcg
QEAgc3RhdGljIGludCBzaXdfdHhfaGR0KHN0cnVjdCBzaXdfaXdhcnBfdHggKmNfdHgsDQo+IHN0
cnVjdCBzb2NrZXQgKnMpDQo+ID4gIAkJCQkJa3VubWFwX2xvY2FsKGthZGRyKTsNCj4gPiAgCQkJ
CX0NCj4gPiAgCQkJfSBlbHNlIHsNCj4gPiAtCQkJCXU2NCB2YSA9IHNnZS0+bGFkZHIgKyBzZ2Vf
b2ZmOw0KPiA+ICsJCQkJdW5zaWduZWQgbG9uZyB2YSA9IHNnZS0+bGFkZHIgKyBzZ2Vfb2ZmOw0K
PiANCj4gVGhlIGNvbXBpbGVyIGlzIHNheWluZyBpdCBzaG91bGQgYmUgYSB2b2lkICogbm90IGFu
IHVuc2lnbmVkIGxvbmcuDQo+IA0KDQpMaW51cycgW1BhdGNoIHYzXSB3YXMgbW92aW5nIGl0IHRv
IHVpbnRwdHJfdCAgd2hpY2ggSSB0aGluayBpcw0KdGhlIHJpZ2h0IHNvbHV0aW9uLiBXZSB3ZW50
IGZvciB0aGF0IGFmYWlrLg0KDQoNCg==
