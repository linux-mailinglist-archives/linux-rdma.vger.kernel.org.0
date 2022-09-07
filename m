Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10485B05D7
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGN5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIGN5k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 09:57:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AEA8CC1
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 06:57:36 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287DW2V1029016;
        Wed, 7 Sep 2022 13:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=Y6/NBdTORx4ChQ63cIlUcQgFNrZtkEY5ZlrudPgtCa4=;
 b=ZrEh8PTRsTVwb66y+xv6zMsbAvCKoUKEyfvbu0nxzhGeyWY1SXENRGYZ/8N9m86sc5i1
 dK3t6IYONer30pCaJDh0stM3ELChGJ0W4CrJRvivuKX01tPj8x6Z3vKkvjdcpheXyMWg
 7ptqZDkzZY9i3YGOyat9EYwLjZmD03etk4BC4/ZGjz4MwTP7/2qxhlxdBsRKYlFWCNVL
 AipPGPqAZRCTWMDxzSz61PyV8/RW7hA94nKes/ijPOtDpS6zj13U3KACOqfvWpq83wS4
 qR8oj7IkRh3EIu3OjymiPC43/lLTftKaVXUtXoqYq5tBU/wXYBQZkj8seCXtEhDgkmsk Zg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jev93gxnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 13:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt4nVeI5RBfcnftw43e0M1Oo5xmiHNdzbWBRvUJy4kxe1krsOooYo0iWqq9WJ2/lZCaBT1EATOINTOMVDXrH4GyJ4+Ho2yGNlcUic1GT6UL99oZ6J2DzpM/f1pfm9ZYtMgB8j+F6piT1CW+wLVZTJTavrRgslx5Tzi7T+LeJXfPsFtLMhZ77ZTtLcuh1WI+zUI0ktBbuEVcdUoc2DZHolHW0i1HiAtBYzkqZ94+GFQJ45YH+XErOwTP2xP1g426P2jMhwz+HlWwglTDBvyTU+/cgNESjOGqSuumRUj3/wDEYueuJT/YECUemS9yJZrjAsdMeJK1mGSh0pqSt+3LdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6/NBdTORx4ChQ63cIlUcQgFNrZtkEY5ZlrudPgtCa4=;
 b=LVv+VqSFJmyj6o5hmCB/SoARumo3BUGgAc6j0d59W6/W9+81prVqwOzzEr6JzKs79YMcVAHZ/494hz1btbpaLzD7Cf1qI8TQO10B9zL4MnKCQCLAh4NoFzjAicL3hmrGTqFJg16FwRndl+MCxsPoou2FmQwhAGMjnL7eTMnWfJd49l/mcpSpH0bHyMlFpCUe2UBcI07grhM+yINuTG/yryAf1F7srkoYPcFL93+2cB0FC9QsmL2WPTtrS2tZeIFJvy7X8bbM7AGpSvz8YVwzgug7pWZjzKm63cg+SmkDVCSf87nYkfMhZrVBfYOLYCwc1aO0dxqNDjScLcDrm+jx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA1PR15MB4935.namprd15.prod.outlook.com (2603:10b6:806:1d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 13:57:30 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Wed, 7 Sep 2022
 13:57:30 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] Add missing ib_uverbs dependency from
 SoftiWARP
Thread-Index: AQHYwsDuZrt9/7xuQUO7QHSDGC2hoa3T/JSw
Date:   Wed, 7 Sep 2022 13:57:30 +0000
Message-ID: <SA0PR15MB39196B7EF30AD4FB112D6CAB99419@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
In-Reply-To: <Yxih3M3rym7Abt0P@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2857558e-c7c2-4599-3ad0-08da90d8e80e
x-ms-traffictypediagnostic: SA1PR15MB4935:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W15Gb5DU9k3iuTX2KkHV9zQyI3Z47M8jFnfB0CwrfXl/oUIw0qJE3Tf0VvWS4dK71iHCN/8hVksLZTGow0CQ+OtCelFt0vuN7/4pYKXvoD1zWlV9gXOrPozLTZOwfdjz1s76EBcsM+NPlpB+CLLIwhnu9b2kE8Fz93K7Z+l8YQsf74lBn23MzgTB1Aw+DrTOJOxu+uS3KQ/Tci4K75zG+/rUyLjqR2cThd6K3BcqfOYe/enupaRBwVeAFH1V8Wb/FVR7XhM3EYOVEua8ag7KkymFiwcsAov4QbSxnrDfg2PbF9olf9MvF7dJJ/sIeC+dGTC/4jJbNaTJjGj0t8YG4lbS2LXS2l2h1Nwcj5RLF4KwSrOAQzlRD1l46GQQv9b3vK2AIx4c/RXrFlXjJg4Vo4YxXEvExBUmwWIZFV8VKtzph76W5g+Av6Wwol3Tw2voa7eKAKVAIhRxpTJefoVucje2UKVvTK83J052+99qBxaJnbfsVb+tzmK3f7rLM+R2pZoYoYU5HZ94y9NcUvt90i3a2BwItBoBwQ8smzAa6xWZzKfr1QZwEyADwiBqE+kUrs7HXB+A8qesLFwnNCBDGBLSUs60lC5MoEoj8hweh03FTMMdccbGoGmiAnZmimpXtQU/qOtMLhDn+j3ehnLkfZlHQM0lJ6FbNlYqdcQlWcvUTLP7XTOhuDTo7cdwtfANITLYP3eCQEM8WJu/2VKPhBQJ5nIOdkA3CCdk7RXxLAHiEfBbimBT/C2P4hQ7r93Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(396003)(376002)(136003)(186003)(5660300002)(52536014)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(2906002)(8936002)(66946007)(76116006)(53546011)(33656002)(6506007)(7696005)(86362001)(9686003)(83380400001)(41300700001)(478600001)(55016003)(38070700005)(110136005)(316002)(54906003)(71200400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXQrWHFIT1Q3L1VDQ2VNemdlSlNOR2NXZy9QTW11KysvQTIzTU01Wi9BM1Y4?=
 =?utf-8?B?RW9TcmE5bnp3RTRBQStlekFFT0JMNEZWK3JKd3htODJSNnB4TjUzbTNOMDZz?=
 =?utf-8?B?OFBhQjNKcVNneEtSYWlEaXlKYlhBQXVnRzRWMllMbWVwdUYrZXNSWmw5UHFG?=
 =?utf-8?B?NnhLSEU1LzNTdGlUSXFDbXI4cXUyenlLbkN1LzRpUmI1c2xiSFJzdnFuUEZ0?=
 =?utf-8?B?TCtoYlhaMFN0enB4Z0gyaXJHaHo5TVRXVS9KQkluTDlkQWp3VEpJa290R1N0?=
 =?utf-8?B?eTNGN05mQ0hwSjVmb2ZyeXZwLzRZb1dBMDMyakw3VSt4VWlCWjFUMEo3RmVX?=
 =?utf-8?B?QlRqdkRucXRYTHp6UStkb0hxTFVpN1lJVmVKMXA0ZDZ2SFQ2cDZ5bDNUMUNw?=
 =?utf-8?B?U0FQRjBvZGlSRDZ4OW5aMmZJSzlEeUxSWjIzaG44RWFRVlc0SE93aE1qRkVD?=
 =?utf-8?B?QXhGRlNZTUpwMzdYbVpTSlBodkk2Rm1MUitKNzVvNzJNMjJDUlJHdDVrUCtw?=
 =?utf-8?B?TDV4VUFnVG90MDNsdDkwblFRcVpiRTdKWkF0dTNhVXMrK2cwS0pkVDAwWGlo?=
 =?utf-8?B?UTZPdFBYdHErVnRya05kWlErbVhERnZDVVBnZXlCNzZOMlplQXRzTkIwM1o0?=
 =?utf-8?B?ZHF5c3ZZRXFncDZONC8wNjZrRlF1MUR6Zm9FRHFCMzlnY2J2SWNaUmgreit0?=
 =?utf-8?B?bFFoeHBRV2MxRk91VkRLdmhMUnM5VHV6OXdabUN6SXlDYXNRand2STdwbXgy?=
 =?utf-8?B?eWo5YXR4SkUrRXpyMUdGQUZRU3I3QVNjZ0RhRFVwL3k2ejFhMXVuU2pDT0s2?=
 =?utf-8?B?UklOWFc5QUErcU5DeGVDbUNhYW94eHRDN0dLVDFRT2toYkV2eVJZaE0vbXc3?=
 =?utf-8?B?QkRvdGlSREU2VjI1TUtBRmJwVGU2WU4zSmxlTDhBZjdBck5BTG4zZzV0TThz?=
 =?utf-8?B?dmwxNkl5bFlvb0pOUGpycmRrbkhDcHMzamNzTHc2bDl2MXY4SktpUUtRRUVM?=
 =?utf-8?B?S2IydkFtRWMwREk3aklTSHBTRnQ4RmdIWnJxbng0Vy9EZzdyS1lPMGxlZGtx?=
 =?utf-8?B?OGs3dUhWYkpENDZKaDBRNjlSNFlZVTBneG5YOUcwZlRyWWo2ZEZKcHR2NjdH?=
 =?utf-8?B?K3VuRi9kVk5EK1hzNUVGamxzTjlZZDd4QjJBSXdCejgvd1ExUXBmZVU5bXhX?=
 =?utf-8?B?TjYvckR2RnVRN29pbEhCbU5ZV2JsRzgyQlEwMSs2QXJIam03bE53Q2wzU0NO?=
 =?utf-8?B?eXUyTktjaUJpN1BnbGNWalFyeWJjSHhXOXVuYW1VRVFyR3hEQ0diRlZMZ2Zj?=
 =?utf-8?B?d01Db2lONFYrL1ZsdmgyK2U2Z212QXJkeWdwTnV3aG9XTWhiUDNvUEZieXVo?=
 =?utf-8?B?NGorNE5jOVVFc0JHK0FFdDZweStLcG9Sd2VsblM1QzRJcXRlRGY2bUtWRVlo?=
 =?utf-8?B?THRWc3M1WUo3QWkveVFES3dwQ3diUmFGS2RNeDNiRllqZTYxQzh4VXZhTW9x?=
 =?utf-8?B?OGVaSlRkNHd0d1ltSHVmRktFMnoydHQrVEoyR3hHZ1FLSWcyMHozMWxnbHNl?=
 =?utf-8?B?M0l2a0ErQTRURStyaDdQeEVONG40UWoxRlI0RjVLelJnRHJpTGxURDlMQnNV?=
 =?utf-8?B?TnYxQjh5UVl2K3lxTWE0Vkp3UW1QQlNmUmw1YXJ2ZHVRRXFHdzFKOFZ0d2FN?=
 =?utf-8?B?ME0vOEdkS0VoZXNZYjgwM2FoWVBWU0xWRks5QlBDK2pXcnZvc09EWWVZVzVi?=
 =?utf-8?B?a3ZBZDViNDkxN1R6M3ZJQW1RbzR0NDdEVWQxV09Udmo0VEY4Umg4QWtqZ1dJ?=
 =?utf-8?B?K1p3MExacElSUmJRT2hhTUFvT3FZSm5GVlVITVlWeHc3cER4YUo3SmQ0dzFt?=
 =?utf-8?B?VHlkU2dROXZLQlVSUmczUWUrdUVBdnlLN0pIQmg5ZTJiWWFMbHpBVGRJNUxh?=
 =?utf-8?B?RlBDeU5uOFFlWG9TdDNWZys4K0xza2hNMkpOb0dpS3VTU25lSzROd0FVb25E?=
 =?utf-8?B?dUhTT1BoSFhoVjVkSUlVRDMzeU5QY0ZRYmorRFRSMlVFTjdHenA5VmorREkv?=
 =?utf-8?B?VmdMZ3Y4ZzladENJMmVCc3ltY2N2SUdCTDlWaWlrdnlONG1iSTVKS2NxajNr?=
 =?utf-8?B?dkRRK0pSeDJDSlEvWHgyVGpXczBTOGtuQW9DTkkrSWlqbUdCVGM0dUo3MktY?=
 =?utf-8?Q?05J9G/vkE2BfmYCbOkPOLrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2857558e-c7c2-4599-3ad0-08da90d8e80e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 13:57:30.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhKGbjyBYcDY359BBilnIZm0SbzBuTPf6ofNWD7VbDDEEeq8YvG3zr4i86WRxWGw4EV7zmLsVCsxtnE0g55dvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4935
X-Proofpoint-GUID: D-hOZq5055XtQ1CyRYwG3vCZH1Ff3dZQ
X-Proofpoint-ORIG-GUID: D-hOZq5055XtQ1CyRYwG3vCZH1Ff3dZQ
Subject: RE: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_07,2022-09-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCA3IFNlcHRlbWJlciAyMDIyIDE1
OjUxDQo+IFRvOiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4gQ2M6IExlb24gUm9tYW5v
dnNreSA8bGVvbnJvQG52aWRpYS5jb20+OyBCZXJuYXJkIE1ldHpsZXINCj4gPEJNVEB6dXJpY2gu
aWJtLmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5B
TF0gUmU6IFtQQVRDSF0gQWRkIG1pc3NpbmcgaWJfdXZlcmJzIGRlcGVuZGVuY3kgZnJvbQ0KPiBT
b2Z0aVdBUlANCj4gDQo+IE9uIFdlZCwgU2VwIDA3LCAyMDIyIGF0IDA5OjQ1OjA3QU0gLTA0MDAs
IFRvbSBUYWxwZXkgd3JvdGU6DQo+ID4gV2hlbiBsb2FkaW5nIHRoZSBzaXcgbW9kdWxlLCBpYl91
dmVyYnMgaXMgbmVlZGVkIHNvIHRoYXQgY29uc3VtZXJzIG1heQ0KPiA+IGFjY2VzcyBpdC4gSG93
ZXZlciwgc2l3IHJlZmVyZW5jZXMgb25seSBpbmxpbmUgZnVuY3Rpb25zIGluDQo+IGliX3V2ZXJi
cy5oLA0KPiA+IHNvIHRoZSBrZXJuZWwgbGlua2VyIGNhbiBub3QgZGV0ZWN0IHRoaXMsIGFuZCB0
aGUgbW9kdWxlIGlzIG5vdCBsb2FkZWQNCj4gPiBhdXRvbWF0aWNhbGx5LiBBZGQgYSBtb2R1bGUg
ZGVwZW5kZW5jeSB0byBlbnN1cmUgaWJfdXZlcmJzIGlzIHByZXNlbnQuDQo+IA0KPiBObywgdGhh
dCBpcyBub3QgaG93IHRoaW5ncyB3b3JrLg0KPiANCj4gTW9kZXJuIHJkbWEtY29yZSB3aWxsIGF1
dG8tbG9hZCB1dmVyYnMgd2hlbiBzb21ldGhpbmcgdXNlcyBpdCwgd2UNCj4gc2hvdWxkbid0IGhh
dmUgdGhpbmdzIGxpa2UgdGhpcy4NCg0KSG1tbSwgaWYgZS5nLiBzaXcgcmVmZXJlbmNlcyBpYl9j
b3B5X3RvX3VkYXRhKCksIGl0IHVzZXMNCmliX3V2ZXJicyBmdW5jdGlvbmFsaXR5LCBidXQgdGhl
IGtlcm5lbCBidWlsZCBtZWNoYW5pY3MNCmRvIG5vdCBicmluZyBpbiBpYl91dmVyYnMua28gZGVw
ZW5kZW5jeSwgc2luY2UgaWJfY29weV90b191ZGF0YSgpDQppcyBqdXN0IGFuIGlubGluZSBkZWZp
bmVkIGluIGliX3V2ZXJicy5oLg0KDQpJdCBzZWVtcyBkcml2ZXJzIGRlcGVuZCBvbiB1c2luZyBh
dCBsZWFzdCBvbmUgJ3JlYWwnDQpzeW1ib2wgb3V0IG9mIHRoYXQgLmtvLiBNYXliZSB3ZSBzaGFs
bCBub3QgcHV0IGZ1bmN0aW9ucyBpbnRvDQpoZWFkZXIgZmlsZXM/DQoNClRoYW5rcw0KQmVybmFy
ZC4NCg0K
