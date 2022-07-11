Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE7570833
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGKQWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 12:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKQWU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 12:22:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB27358F;
        Mon, 11 Jul 2022 09:22:17 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BG63u4012347;
        Mon, 11 Jul 2022 16:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=j9JTDiGwsTl97toLAz+edbxtTyo9IzXXWKB7leCSXwY=;
 b=a7KvD+ZmnwL7u/IjjqemDtaAAOhgiX5QUM6udQnmAVvDyVSV434Exr3OJHnz/MmQ/7Rt
 0k9dq4HS1XW0g6YvOViqWwecnNOjm0IHHu3XGWHzbqREm45T13Y7ORC1360K1XeHsqiz
 OiRpaAlYJjVpE2Kn3jeJy9auvJQ8tfBDO+mpb5DGN33HilF8zzTHxcLDfl6BM0UwJKSV
 hi5AyTj/iiYyNgTDyJ5k2ZKL+fHRJ9/pVtGJ4kRJaYEuZDKRJ7P9w8QmwV+5d2DQfZeV
 5+TlYz15T3YDquIh/0dIYW6o7nYZAeYiyQC1Tquyqz5mw1uPrcY3kAjg6+sGPgAkAQCY +Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8q3agk66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 16:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7c6m758kH3tQQDl0WihD8j+hQ/Sx8d5p2ef3bHWWbZfqbGvEpRDXtXSgcfOuw4DeiGZ8CirfIAdge72oTO+BNDTlU8da2C3O6zz/ELckVKc9VFoRd0bW9+Gg/wGrj0+KURS3CmhEP/HHvWP+uN/nVQhbYxcRH/I8xBwlBkO9DTgbOKI5H2ek3YFRoDcOQFZT6IwKgq5ySZTar6DbY92lOUsFSbZmRNpTHaOb4JnqwniIerW9RBbfferNGeBP0zT6fczeYj5kPcwNSU8LF7ldOWvXNBzLLsqWqm5r5OKlOQ2uNTWf4jDXnjxnd25fJLHUSZZD+AOoESA+jIIWDF6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9JTDiGwsTl97toLAz+edbxtTyo9IzXXWKB7leCSXwY=;
 b=THN3e1H4U1wytsgCPR3xn1SI6yxBCRU8Jsj3wel3lwECCVEFPhXbtDb/UqCOr7wR+gfCoa/oCC3vNezMahDXsSn9UdRJh+gaI6fGr+ejt1U1BmV2drSF6VnUwkhMdiyA3nuneweeYJfKe4koPgixqdvpTp1va6Amusqpp2jJ4MOozSQInlzKJwbKx6MVI+p+RiB+DHmmx33ZLs+UrTWVCQ1CYb3WK2J72fav8F5SmKHUMGMD4UICUuJWf0GaKHUgjjBfj5XNLiBFSB3HbVEEQfzjM7CU7E6jVUndR1UK8V7s4+hIOsXg3Cdwm+TNI6ZpeaKSZxitpgwxqSqwP4Oz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by MN2PR15MB4798.namprd15.prod.outlook.com (2603:10b6:208:1b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 16:21:42 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 16:21:42 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Andrey Strachuk <strochuk@ispras.ru>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: RE: [PATCH] RDMA: remove useless condition in siw_create_cq()
Thread-Topic: [PATCH] RDMA: remove useless condition in siw_create_cq()
Thread-Index: AdiVQk1t02BM0jHFTcyUzrPxmXQryg==
Date:   Mon, 11 Jul 2022 16:21:41 +0000
Message-ID: <BYAPR15MB263181A19484772A18872C8D99879@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f282a3eb-84f1-40eb-ff1c-08da635970a8
x-ms-traffictypediagnostic: MN2PR15MB4798:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNFeQnELZd+KZu+QvkmVWKW0xBevEAZ6svc9rltsxfOLFrWmiKmEIJQM5Yj6/KsQMg42FscZ8NRIX3jL7IWJX661J/j7aC9qZcePqOPO6mw68OZ+jOJrZ23s6Nn96MpIaiq4ZR4oEknkC7NiY3xWx6SilDWBVSSeSHda4+8F0HdfNVDB1kgSZZX8KFQw7MYrQUvCaACSqGKSeTOF36hRjGrDQBDBIg8XaPV76OPlZLL5eRW1mdKvE+OBK2utrfva5Y94OGyLNX6gnLZQ0WOb1BvVDg0YvO/aQqqqFF+rEdrL5PZe73/6LR0TYvjYw3BGHNSXDm3t/X+4IiWdJJ7mRuAqmHKJuQH82YYc+a0pknrpO6MUAbwarlRuYQjNRkG9i1WktCjSxXzbbICj2WF5JdrUUXKHMFZPmEeq61TCpzc/RUPa2s9VqAi/tV2MCpA/f0ifk5kwU+cB9zld4uIAwcNdShi5/FkMoBbZwVtRtCGTcH78JVZ5dKEu13R1BH8uWG0sZMJR165bQIUPa1Kt6UgoZyaYsxcL1Emm7PF97Dql0VYBGHrcWFP67cVseci8zyeXhjrfn4ouamA+rbSqMEQ/mxRUaXw0NkRDLbBKp96nNYGumWfIwGAg0GX6glkyfq+6Ed3VQpBLJSkoVWSfiM9AnafJrXGgOdr9bXNiA7PjBlHUnefS6cSzbHbJmIoQPXkR1hpzTg3WrTRoupOUeAPyKMvOvAj2+VTtwx0f6l9kUe9d6JpE3mPh7Mon1r3DPc91GxYELVPRtxTqf95bU1XKdD+2daJ+XDOGvpTzXZe6yc+tucvssHZKzD4AqAY8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39860400002)(366004)(376002)(86362001)(53546011)(5660300002)(38070700005)(9686003)(33656002)(71200400001)(2906002)(122000001)(54906003)(55016003)(316002)(6506007)(7696005)(6916009)(8936002)(4326008)(186003)(76116006)(52536014)(38100700002)(478600001)(41300700001)(66556008)(8676002)(66476007)(64756008)(66446008)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akNDaVRYbjAzaDNWM3pLRzFCNVgwdEVhUUROYThhUGxqOE91WERzRjN1cHJx?=
 =?utf-8?B?cjYyOHVibTFOd0FJT3VkZFNMeWtXZ3VtdGo5SXIyQXAvMEdJQTlzYjhoWVQ0?=
 =?utf-8?B?VFUrUGRHV0FpZTN4U3ptSFh1RHdGNGFaWnAvazNieCtNME13T2puc1VBcUow?=
 =?utf-8?B?NWw5VTJ5S1N4Y2hFcGF3RE5DWXg3WXlMd29xaUxQU211LytabG1Vb2lEZmth?=
 =?utf-8?B?Zm9qUmVjUVE2T04zVEs1bUhGNXBER2dlVlpEZmlpNGlpU0VqOEhielpUU0Vm?=
 =?utf-8?B?QjNWRXo4Y0g3YS9mZWlIcnMrYVAvaDVsVDFid0RBbmljdGR1VS9UQ3RtQm1v?=
 =?utf-8?B?dkNtRTB4MU1EYU1IVytmUGdkMmhWSlhDOXlUN2VxcWZEZU9GcTJWd3RSK1F3?=
 =?utf-8?B?cC9uUW1GU2xvS2hnc1pnaStCb3dzU0VHd0xldCt6S1VWSTNUTUFRSER5cU1a?=
 =?utf-8?B?a2tYQlFlRkF4aUl2QmI4ZFFNYWd5eDZOSjNMTXNuTmdOb0VuWHdXeWQxMDZI?=
 =?utf-8?B?RXd1VlFhUFkzUkZ4TlFzbWNBSzdMdzJJRnRsUUhFaWtDdUdLUk5MRlVLaXcz?=
 =?utf-8?B?bHpyLzNYTVM3UDJidWdGbTJ2RUgvRFRtMzBadG8rWXFZZUJRZHQxTFNzY0Va?=
 =?utf-8?B?Wi9kaFBGcFEyWng2THV0cE5lOWc4akI3dmdZdlRqVW40OW1ROTZoT1NlSEVn?=
 =?utf-8?B?SzBXbmNyelZ3UmFxWWhxR2F5VlJLelFocGRaSVNta3lKd3FjMGRPL1RRZ3NY?=
 =?utf-8?B?dDVtWVliM3NZV0lqVndFbFlkUHc1VXJhTjRxdHI2Z1RKYXpKeWNZMEk3UXhI?=
 =?utf-8?B?WXpNbDMzQkc4Qi9ENCtsbElrd2FSSE8xS01TNk4zMlU0Z1EvMkNzMkdvdnVY?=
 =?utf-8?B?ckFjeHpNTzJTVVRmdHFLQWREbHBKdDNqYzJlOUY2MkdNc1o3SUltNG8yckU0?=
 =?utf-8?B?MmNPTmtGSU5hb1FEcHVwVUR1cnNzTVljWldNTllXenhnRjRlM2JJb250UHRa?=
 =?utf-8?B?VWJpSW01ZjhKR2FzRUNUNGVnZ1MrL1FORytKRUorNE9zdVNFbDNuYXdxcXFE?=
 =?utf-8?B?dGVpWmFOTkEzV3Jhek5wQWNaZFZlaUg1dHVvRE4xR0l3TCt3SWRFR3creXB0?=
 =?utf-8?B?NEJRUnJ6ejI5cCtDVzl3RXdvT0J0OStkcUN4d1NoZjVORHhzU1A2S2NLbG5C?=
 =?utf-8?B?aGZzQ2QwWWpMTFZCcWxjUXU0U0cyb1cvbEFZQkx4d2tHZ0pHN1R1NFRGYkZP?=
 =?utf-8?B?SkdUeUdMVlNPa0JwVXhnUXZXblgvQjFiZGYwNG1TcHpwUzF6MXJTcFRCZDNZ?=
 =?utf-8?B?aGxNVmc5UW94TWN5L1NXbHlUQmpkbUFHL2dPbTh6Yk9QL2lCMnRjQ1BLdTM2?=
 =?utf-8?B?bXJ4ODNYL1dkZ1lEMkFsQUh5YUg3UWR6b1RlV0toc1dhUlVZZEhENncrVWcr?=
 =?utf-8?B?eml5Y2p5a0lramR2cWVpdHNibjJiSlFIc0NzYlF6UUpNNkVsazlsWnJIT0lQ?=
 =?utf-8?B?bDFUc2h5eEs4NWFFNHI3anFxWklrcDdSanlBWnM1T1FTaFpQMUpOM3JlUnRF?=
 =?utf-8?B?VG5qdTZ2Q2pYMjc1WDRJY2l1VXdOWmdkcll1a1pQS29TTldhcGxKTnJmYkpP?=
 =?utf-8?B?aXBxeVFKRzc2NWNiNk94WWJ1K0N5cnZ2SlpZMmVFL3VhMEtLbk15cTJ5aXNC?=
 =?utf-8?B?NUpMOGZtMmFOc2VXTklZNDQ5NmQ4U01BMURhR0VFelFTdWFTZEJ4WkhxczlK?=
 =?utf-8?B?Mys3MWVxRzFZazM4UzluVXA5YXMvZ0k0SzNmQ1RRalZBVkc3R0lXbkZ0THBx?=
 =?utf-8?B?dG5VYVh6eTgzT0M0WXF4MStoK2N6dmU5WjNjZzNmbnlqZUlPVTl0SVQwUDZY?=
 =?utf-8?B?TWx1VGhVWGZraVVJVk1YTm1oUWp5TS81dkx6UkxoWDVkZGZqMm1NN0dRd3Bp?=
 =?utf-8?B?ZWVldkdtUkN3THViWThheDFPWVRRbmJndjVRWENScTRLbHdTN2lXdjZaZ3ZE?=
 =?utf-8?B?bVNvaDNMOWNidVo0a080aXVReGd6SUMrM1M5WmFLL2szUHhGOEVEZFE2Q25q?=
 =?utf-8?B?U1N4Z1d1cWhnWDlIK3VCWWw0S3MxdGUrK2ZjSkpjb2xDYnUyS29EVVJHUGVW?=
 =?utf-8?B?MFVQUHZTeUhFWmRxZktuaWR4VWs2QzZtWTcxTWVmdG9qeEV5QmRZbktKUFJT?=
 =?utf-8?Q?dJTbXz6nhf9cdIGtZ5BOMzJPoSQg1MPnXt6m8mlcdH2c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f282a3eb-84f1-40eb-ff1c-08da635970a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 16:21:41.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrffWfiwCCrmpOH9Gza+/fKAIcdVrFX12OLw9yfZRctP2YWjbWxHZaT7WzokMbFw7jYTB2He+rErwjm5606g3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4798
X-Proofpoint-ORIG-GUID: vFnbNsaVp-vWL00E9bQPDvqmIIbhOUEg
X-Proofpoint-GUID: vFnbNsaVp-vWL00E9bQPDvqmIIbhOUEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_21,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=950 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXkgU3RyYWNodWsgPHN0
cm9jaHVrQGlzcHJhcy5ydT4NCj4gU2VudDogTW9uZGF5LCAxMSBKdWx5IDIwMjIgMTc6MTMNCj4g
VG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogQW5kcmV5IFN0
cmFjaHVrIDxzdHJvY2h1a0Bpc3ByYXMucnU+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5j
YT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgbGludXgtcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsZHYtcHJvamVj
dEBsaW51eHRlc3Rpbmcub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIXSBSRE1BOiBy
ZW1vdmUgdXNlbGVzcyBjb25kaXRpb24gaW4NCj4gc2l3X2NyZWF0ZV9jcSgpDQo+IA0KPiBDb21w
YXJpc29uIG9mICdjcScgd2l0aCBOVUxMIGlzIHVzZWxlc3Mgc2luY2UNCj4gJ2NxJyBpcyBhIHJl
c3VsdCBvZiBjb250YWluZXJfb2YgYW5kIGNhbm5vdCBiZSBOVUxMDQo+IGluIGFueSByZWFzb25h
YmxlIHNjZW5hcmlvLg0KPiANCj4gRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENlbnRlciAo
bGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
eSBTdHJhY2h1ayA8c3Ryb2NodWtAaXNwcmFzLnJ1Pg0KPiBGaXhlczogMzAzYWUxY2RmZGY3ICgi
cmRtYS9zaXc6IGFwcGxpY2F0aW9uIGludGVyZmFjZSIpDQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd192ZXJicy5jDQo+IGluZGV4IDA5MzE2MDcyYjc4OS4uOGRlZGFlN2FlNzllIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gQEAgLTExNjcsNyArMTE2Nyw3
IEBAIGludCBzaXdfY3JlYXRlX2NxKHN0cnVjdCBpYl9jcSAqYmFzZV9jcSwgY29uc3Qgc3RydWN0
DQo+IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4gIGVycl9vdXQ6DQo+ICAJc2l3X2RiZyhiYXNl
X2NxLT5kZXZpY2UsICJDUSBjcmVhdGlvbiBmYWlsZWQ6ICVkIiwgcnYpOw0KPiANCj4gLQlpZiAo
Y3EgJiYgY3EtPnF1ZXVlKSB7DQo+ICsJaWYgKGNxLT5xdWV1ZSkgew0KPiAgCQlzdHJ1Y3Qgc2l3
X3Vjb250ZXh0ICpjdHggPQ0KPiAgCQkJcmRtYV91ZGF0YV90b19kcnZfY29udGV4dCh1ZGF0YSwg
c3RydWN0IHNpd191Y29udGV4dCwNCj4gIAkJCQkJCSAgYmFzZV91Y29udGV4dCk7DQo+IC0tDQo+
IDIuMjUuMQ0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+
DQoNClRoYW5rcyBBbmRyZXkhDQo=
