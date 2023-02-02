Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF5687831
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBBJEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjBBJE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 04:04:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A186B35B
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 01:04:10 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31286PeA000449;
        Thu, 2 Feb 2023 09:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZButax7a/ADioEhoNtNLuD+99yVl5ZzaVUGTSakWgOc=;
 b=iiCDRm85lW2YGHVNfC68n5gJkkeS5dSV3IocGUPV3ocqfSwXxmLVV+qUM3O7w1DK4beH
 3F5D3LfYkwkJXB0IR4geshUJBjHVCudq2GRxEpBTWglNwNOHYVG2i+zuomrH9o4jULvN
 Nov/0cMYDCrltzarOFyn/43qvsL7YYQpEFqDYWYeYYnDP6DaA0vifvuUEJYGdEfFf8dg
 54gSGu2bS5rfN/fV2lhTs8KuKHbmu/DNOtza/+FxuvTNZ8lw+daFIAig3Z1pY+gQhlX1
 Xj8pJvfHUDCsqTcqpPfZnhsa+WiieJynnt5JjWo/hYG+PTLd89A5Ggjj3Um/3x7OQStX JA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ng6yq4m59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 09:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtxQO4EsO2swz9UQy0db2pUDMfWhNd7jeOhkF3+dGr6yH8sq/aSupwn98RNTfBGQ4/OyoG3CdbNmLJLXEGczEDJv9nhSPo/CI7Sf31fnT/MWhA4RnCF+dF6RU6Wzm5piQSNffu/qUSzy4oEVK1m2WaZi7V6phNLp5dj83JsU3+Js9ABLC98yT3Xs12LmSsfA/yJ3MMRwfL/+0AVoaSyVqv7bDNNDPZLjO79a6F7NxohTGhtsIs0a4OFBHZvCc5EVZia8RKKopG7OJ/zuB/s2iy8njmuPEhlechdCrTLWeBJSCvsPGT+UWCxYyS2L9sWecgdk+wKRcpx03elXUWBexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZButax7a/ADioEhoNtNLuD+99yVl5ZzaVUGTSakWgOc=;
 b=K48m4EGZj1VhozYKeLQM5QAmjmjYAoQjKaxbpHaJlSOPQa81hmYq/iMxr8yJ9qaRMK/1RZZghGLpw3snQAS/Y4YHQxVaNyC29UzCwKuy7kEXwv6WrHSBZy2mciuA1j6kYr++hOWbG3kkmEm9fbrsBO/k5LWj05ICrh54x7Joh1oYPWtUYGQtF5rbeNMWPPjsT1C6qdbD0PnrheacPgEgnW6HWTxvkapQrbZkghEZM1b6+hiebyHxFVSA8rBwJc9S4AUhMZtMmJqbNTyMSR+eSyyp2DNAd4dAwVh1x2SrueWIS9nmCh35PKEjCc0OFgkAR2U8WB3rcLQRXUqW95k/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by IA1PR15MB5895.namprd15.prod.outlook.com (2603:10b6:208:3f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 09:04:06 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 09:04:06 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Thread-Topic: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Thread-Index: AQHZNuVNeGPvvpON4kmHyW9d7V6R7A==
Date:   Thu, 2 Feb 2023 09:04:06 +0000
Message-ID: <SA0PR15MB3919BA817A04C53AEC8B66FA99D69@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20230201115540.360353-1-bmt@zurich.ibm.com>
 <875yckmrx0.fsf@nvidia.com>
In-Reply-To: <875yckmrx0.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|IA1PR15MB5895:EE_
x-ms-office365-filtering-correlation-id: d137a4e8-0ad6-4b68-c649-08db04fc7056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfS9zr6J22y6UKiEclOu7BjfpL+w9Hrf8oaE92JqxwNCZl2jNlrFtH3IqREDr+rVz9C1Cgp7Tkip9iG469CrEuk6kyD1RpLaMlLqUg6cZrH8VO4Um8ZE5zoX/honfeZNalYHBIF/Xqj9HXdIQh2jKXwFRNKef5xA9EoSJyHgDihe6+K/UgQNFecYz08Xtv4uIaxnPf2C/lEfSS7c92V6wB9g32G1ghgsj7i+giIHtGMJf4y12jW/BKjvW68hnTWkB/Nj2Tuh3h6NYohbd+Fi8BAWISiQbVJnD5/SffwuHrUvo8OjnJfn2ArrduZUX5JGghMXZJFw4b3pwINtNDEuj+YtqFsDGZuBVWu+1+BS4KuCoNu/zmCbL6ofIykbM39jZYl/elStswEUCP1+b0HOHzX0lLBKRt9P3Wrdd+ucV0Acqt62En6qEO4+BYklxiQYs/Tfv3f7OYqpZhPXXOTpW7Xe3BJzW/yyZpjTsYdRAon4S3ks5vjtaBGqoV+zuRqjj87ix+rYM2DELup1Rd6Og5K4gVoKkBBWotqc3jrDpgyuW258Op12qnuFJoY8/B3jBpzUeQfj7dHpBJnYWqFD29HrqFcszMHWFNgJzhObqUs3hq3TyVXiloSklkgRi4ANyu11AgmHpjS7vav8UwUQt9OIdOir12OHBzGzerabGdUe2NB219QjxhEWMymS0q638mmPqGMj1DNj0AU1k6Z+yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199018)(5660300002)(53546011)(6506007)(9686003)(26005)(4744005)(186003)(122000001)(38070700005)(38100700002)(52536014)(316002)(54906003)(15650500001)(33656002)(478600001)(6916009)(66476007)(64756008)(55016003)(7696005)(66556008)(66446008)(71200400001)(83380400001)(2906002)(76116006)(86362001)(4326008)(66946007)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emFXamswcXptbkc5V1NTOS84alZMU3lLaUVpSFdQNnFTbndGT3NiVm1kQzJN?=
 =?utf-8?B?V3J2MVpTSjgxOE8wTGRzTkw4OWlwOFBrZlZzMEFRT09uWmh2OEtwaEl0cXpM?=
 =?utf-8?B?VG1qandLcDV6dFgyVW5KamVNRndIZ0Mwa2RRU1hJRktiY011dzh2a2JLb2d5?=
 =?utf-8?B?ekVDajFEcFZ1OWhyZ2ZpY0YvdndGTEg0Sjk5SVh2clVqdGlOOTdHMXFNTnZj?=
 =?utf-8?B?blFZKzkvbWJwaEp5ZDJJRithSE1zUGR6VjZhRjBYUk5RRkFIQVBrSFREUGEx?=
 =?utf-8?B?UnBzYVZML3NDSHFUWG0yUkdnTnZvQ3JjWnhwZHFiM2FMS0t1dUw0Lzk1N09J?=
 =?utf-8?B?UUg1aXBVNWNFR2ZFYmdQMmhoYjRFcGdVNlR6NDFJOHBXWGwyc1J5a0swUEdl?=
 =?utf-8?B?MWs3RXRCU25maXQ2U0FlYmxDRE9oaGl4SDF5Q01KRlR3VVZvNHlHNUxZaUVn?=
 =?utf-8?B?Mmh0N2VZcTVIT3REUTUzeURFQ0wyUjF5ZlpmSnZJZjdIeVJVNzdYZWFXdEhK?=
 =?utf-8?B?MWRhcnhtaEpNS0RsVVlMekVDaWh1NDUxeUhrRGw5cDk1dktaSzRmV05PbGhk?=
 =?utf-8?B?b0RQWlpUbmxwRS9YVUxlZEJlREtGOEo0YVdsOWRIajBzbTh0NzVkSUx0UGZl?=
 =?utf-8?B?V1JpOTZOZENOK2k2eVJVUlBNOW5PK01XMjFLenZvaTRkV0lnSmo2emMvQ1FG?=
 =?utf-8?B?MXlkV0tQWWl3RjlUZGkxKzlSallYR0RTTkRxWGd1aG13OU9YYXlMUXJQS0x3?=
 =?utf-8?B?OXByQm5ZMWN6eWV6ajVrQUsvcmJuOWYvUXNERERXYnVRM280bXAvcjFhZlhs?=
 =?utf-8?B?VmdqRk91Tzd2Mm1nazFnL2RMaVU3a3RSZ3lHbGx0OCsrUDdoaGlxWFc2Mi9J?=
 =?utf-8?B?djQxUDVXeGZRT2EwZ3hQSXgwbVhzMGxiTndQQitzbTd0dEtyZHZwZlIrZW41?=
 =?utf-8?B?SEFJb2p5RFVRaWMxOWRWR1ZUbHdFSGxjRmZDQ2x6L1VIb1I3bWNkOTRtVlhI?=
 =?utf-8?B?ZXFqcEthL0NtMndDbFVmVlhCMFJ4MlArVWV5WjdlMDN5T3dEUUM2cmh6Qytu?=
 =?utf-8?B?dXZPQWFBelRVNnZRV1dKZWU2aEw0aytkQ2JWV2NMaTFucHJwdmlCRWo0QWw0?=
 =?utf-8?B?S0V2am1MM21kRHBsdVpmL2todXRUdTljVXY0TGMwYldFT3BBdll5b3dnMWY4?=
 =?utf-8?B?TDYxb29GM0VqOGRRVjMyUFBCWE9mVE9Tb1Z5ejN6QjFoNmVxclgrR0JtSWdJ?=
 =?utf-8?B?c3NTOVRPa2Z3VmgzVTNWSmdxS25nek8ycW1ZeFZUQXR4ZVZDdHRVR2tpbHVS?=
 =?utf-8?B?NE9tMmJtOVdaWVEwM1pTNEJQa3hxSC9RcFpaNExaVllUUEpnTzdIYy9QdEZi?=
 =?utf-8?B?ZVQ5ZHh3dUxVL3o4dUloV1JiQmFxeTNSNkVlK0FSdVRpS3VmZ1cwNzVMR1By?=
 =?utf-8?B?dWhOdFE2WE83ZC9hdmJhS2FRZTlGMHRxYlhiaUNEQnNCUjdOQzNuTkRhU2hT?=
 =?utf-8?B?ejVBOThSMldFYkNYRjlkRjIwczkwdmhhY3Q1NEpQdTg0QzE3OUdVa1NWK1ox?=
 =?utf-8?B?TmtDK0ZKTC9pNnQ5ejlEVkxkcWNUVThCRjhHbmVZMHlJdERkT1hVWUFSZmkv?=
 =?utf-8?B?QzdEOEhuNzVsdE5pNGJDSDB3S000Uk9hYjR2Y0RFOGtlaFhabU5tMmxkekE3?=
 =?utf-8?B?cWtCZ0lobHFWWmN6V0NPVXpHOGFVTitJVGtzMmlTeCtGSGV4NlJYMkVVK3Mx?=
 =?utf-8?B?TGFlZHlhbDF6LzJ3V1FiNk8waGx5bzdKS1BFSi9BdEtGYTdaTHV3WFhQdC84?=
 =?utf-8?B?M2Z4T3VzT0wxQzFFZi8yeGFnb3ZHWXBvSXY4VVRPTXNYVG4yM1NWVVpzcGty?=
 =?utf-8?B?aGtRUlVBak5qOUFhR2RZRXhiczBlZG1rc2QwQWIrd09iWG9uaHRGeVFHdk1x?=
 =?utf-8?B?WHhIcWhZYUloeXI3SCtkVEx3djZOeEZMZ2tWVDVxV3ZVWm5ZMjgwemF4OEt1?=
 =?utf-8?B?d1ltUHgxeUpzbU4yamZRUlJKYVdsMjJRWHNwTDRoZmtabW9qVVU5UitxWUJU?=
 =?utf-8?B?ODlMRzlYTHNOUmovb0VRb3pScDlWNXdvbnJNdFJubFFDV3FpZW0rd3UyNlJl?=
 =?utf-8?Q?7ioM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d137a4e8-0ad6-4b68-c649-08db04fc7056
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 09:04:06.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wThfQpMvLEjnG8bUbdFElTaMvZEDk1DidICl0yURy/fYGZgk4sgr6k9Ydr44sZ9a3gxQmwuhE+N6CtWoB2wOzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5895
X-Proofpoint-ORIG-GUID: I6-egmakqkBcoOrCYEvbos5i8ETG3nG7
X-Proofpoint-GUID: I6-egmakqkBcoOrCYEvbos5i8ETG3nG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgUG9wcGxl
IDxhcG9wcGxlQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAyIEZlYnJ1YXJ5IDIwMjMg
MDg6NDQNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzog
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGpnZ0BudmlkaWEuY29tOyBsZW9ucm9AbnZpZGlh
LmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIFJETUEvc2l3OiBGaXggdXNl
ciBwYWdlIHBpbm5pbmcNCj4gYWNjb3VudGluZw0KPiANCj4gDQo+IFRoYW5rcyBmb3IgY2xlYW5p
bmcgdGhpcyB1cCwgd2lsbCBtYWtlIGFueSBwb3RlbnRpYWwgZm9sbG93IG9uIEkgZG8NCj4gbXVj
aCBlYXNpZXIuIEZlZWwgZnJlZSB0byBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogQWxpc3RhaXIg
UG9wcGxlIDxhcG9wcGxlQG52aWRpYS5jb20+DQo+IA0KDQpUaGFua3MgYSBsb3QhIEknbGwgcmVz
ZW5kIGZvciB0aGUgbGFzdCB0aW1lIChJIGhvcGUpLCBoYXZpbmcgeW91DQphcyBhIHJldmlld2Vy
Lg0KDQpNYW55IHRoYW5rcywNCkJlcm5hcmQuDQoNCg==
