Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7C40832B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhIMDf4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 23:35:56 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33994 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235725AbhIMDfz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 23:35:55 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18D0cuAC020541;
        Mon, 13 Sep 2021 03:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=RrQai670kKmAGFCnBGVrvQQ7D9i/dCAgapXGLY7U1TI=;
 b=L85OSFKZpFnjVBiXS4tFrt4VC9j9u5uQ1ayVuVP78lRaHsoHvsCoYLyRvznUkfbBTtl/
 uejiUQwMx+M4LrDVnsqltjg2M2UmKsqA/Eh7d6SP5n4/orQlZI/m2tO6d5POy5MmwuDN
 aoqsJNo4oXGyK1wrG7Irf/u0da4Ncg3XJOyu0oEhLeh7SGPW18Z5VZrZO9phq4IB8oMA
 8fh4Qy8fNOWY4NA8yJqv7bR94uKRBiM9TrNc4TAQh4/biJJtsju3EPbOceh9x97IptBp
 CFvMOem5hx6DX2TPXYbx4+jpihklm1hNRx2NTiFQ+VBOAc4ZkXppPQ1YBJz7T7QvY18W +g== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 3b1v9e8ncc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 03:34:38 +0000
Received: from G9W9210.americas.hpqcorp.net (g9w9210.houston.hpecorp.net [16.220.66.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 3F8C857;
        Mon, 13 Sep 2021 03:34:38 +0000 (UTC)
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Mon, 13 Sep 2021 03:34:38 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Mon, 13 Sep 2021 03:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG68n6PwK7iUZkDeZhgUZBr/NVTc2AFqarki1eDvGtkxAY4dzoFVB1d/yxwdJqkrJ0mJ8q6iG/+Xfi3TSWNf9oIrelYBj+GyRV0E7MBKHo3cQqV1UNtHl9+ohKOAKAlV4yopilRHDVjN14nVWdEpgne3CgUc2pJIWY037tLa1qbA7xg0fTaTizUZJDYJ+GsIjPE/7yOsjwwOWfZGjK5a0ucwSLkF1ELE/JhVLGhTxhWYWlLgY61jaxgiLHOQ5aqXO6uRBntIggk6ySn2/cgCDBcWxoT9gsXZTgTaGZZibAWmeESAj1ArZCIyX5a/qyd+0hqGQtXKgy/b72dfPGrnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RrQai670kKmAGFCnBGVrvQQ7D9i/dCAgapXGLY7U1TI=;
 b=aF4v1uszSRvBu/RNkQ16PEYhAlhH6XZ9A/SMUxQA5MQ3pVd8Izs1uDJK0LxasTjcabeFfD/K6I7SSbsX2h8xF2INeCfVfikmv+H+/tkGAbtm1pYkzZ1VZIWezoRA0gK6cifrGF+i1kuUWt/DmDhENk8jiD0Q/Z8WOD2N95h1IpRLJGSa0LPsXsUQZWF+ZmmVcRbib9zi4/wYoMue20d4S5VDFWlvHI0Jq2r4BQLJhF1ArPXl9bsea04Du0GC08oTCWjnIv/ovZQnQtZUM0gLM8ewDIgE5M+KxuwDks1Eul87A6bTz9CumIOXDf/ixJGfHSINJ7vjtE1n1a86K7yCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::15) by CS1PR8401MB0805.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 03:34:36 +0000
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ccb1:b47d:5749:87a6]) by CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ccb1:b47d:5749:87a6%10]) with mapi id 15.20.4500.018; Mon, 13 Sep
 2021 03:34:36 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Shoaib Rao <rao.shoaib@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Thread-Topic: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Thread-Index: AQHXfCiRQi0iyK/afU2lI65YdvMuDKtXDP2AgAAYBgCAAmx1AIAAAuUAgAAR+gCAAMJ9AIAABNcAgAA25jCACeSCgIACEmiAgDre0wCAAC250A==
Date:   Mon, 13 Sep 2021 03:34:36 +0000
Message-ID: <CS1PR8401MB1077464FBC2736A93E1D9414BCD99@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
 <20210806134939.GN543798@ziepe.ca>
 <f3849d06-f25b-5119-f2be-4974a72f9bad@oracle.com>
In-Reply-To: <f3849d06-f25b-5119-f2be-4974a72f9bad@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc331374-2d02-42f0-eccc-08d976676929
x-ms-traffictypediagnostic: CS1PR8401MB0805:
x-microsoft-antispam-prvs: <CS1PR8401MB08054A8B91C60EC66289850ABCD99@CS1PR8401MB0805.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y90aR7j0KO4GVGpZWWBkXU5o6PGHnocayAcgGifBzWdVyAXIavS65K5yrSmYOTBck97w6OVG/N2WmMpz3Zp5sTOQmiooaRVcdfDVlWUaXSFQoUkS/SzZluzGJyQV9Mv501ubB3okVpiXj5n1k4E7UJJG4JrwANLgOcJIUoMvNZ2TrFbaJCTAsowCECC9p6TXz+rE5q5HKicGSIJcpxSTMph2C2FJZA9XebvgMVZKy8as+TVdScCuwW3NpYvVfiDn+p557+UEFOXn24lcidLjBPL9IkYDhrQKPEM+peeyqpEC4zxpFfybEImNicLcuLkgVkyp5psM8zLDpXYbRn2sDg+kpwl5pgrK2A3baWS/wTCRXmnb13YdKd/lyDQE+OfgMS92/+7mJNZVjvdDbzRZXJ3O90BrqsWQbCiVEZs8LGCSPEBVPwhlyYRSFMvRExjYYPMDmrtnM+h45Z54FSaDmaYSpOI4nKG/o3EgLInNP80/wg4SsUPz/gwK4qvE8Xl+0OFu6l6+HRkNajxaF3DNFAQXZl2u8I1s3KCvTDeVGOLRY1s5MS92E76MgnVoqYQRC9WjKARLOPAfZP9eekt9Bsmxxhbj9vc6oB+SSFlVAnuKA9lQaCTfZL3/SDizl8VKkgQi7vE68vsZe0zni6IQiFBD7wWYEnvptS9KlXaWHVme7g1+eQ3qP30qWDM9JecrQj/aLlwP7Bob/qyDSM9Jcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(71200400001)(26005)(2906002)(6506007)(33656002)(86362001)(186003)(8676002)(38100700002)(7696005)(83380400001)(76116006)(66446008)(64756008)(66476007)(66556008)(110136005)(66946007)(4326008)(122000001)(478600001)(55236004)(8936002)(52536014)(9686003)(38070700005)(55016002)(54906003)(316002)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHpJM3BybXNIQXFjY0dNNWFxQzFIcmIwVnlCZi9RSDBJbU9UQmdxT2oxTWt6?=
 =?utf-8?B?NHk2eFd1Q0laZ29QdVNOWENUR1VwSmQ0bDZmT1JLeWJzc1BUN00zb0YrcDJY?=
 =?utf-8?B?bVJjS1h6ZnpQbFl5ekdJSG0rbVdGbGM5NzNPVlo5cFg1NWpYL2EySzZzd3NU?=
 =?utf-8?B?RUxDREhQd1RMWjRKSk1saFI1dGoxVVJObXFnb2xMMTVNT2VRN2NZZzF6MjlU?=
 =?utf-8?B?UGxoZTNmS1Q1SEcvRS9qclo2L2lLVHhNdWNWRXhBcjdnanFJQ2o0NVRkQkgz?=
 =?utf-8?B?bm5ncDRpVHBob0tKRFlqcWxyRFNPeUhkSTRISkx4cWNJT0dlYkVzcjJlbFdy?=
 =?utf-8?B?R1lGRDZjSXFhYlE1cnJaTHVTR2kvYzNZMnMwZVV6QUZneE8rL00rT2NDdWN3?=
 =?utf-8?B?WnpONVM2MjBlQjhXbkFiZklDWU5WdjZVTk40TGwwNzhzdWx2aUFoWFRYcTJB?=
 =?utf-8?B?dEUreVJrS2hRajRmZ0dqN0ZWZk9VSHBwNzRNK0JuZmpHckMwNWdENkh3Z21h?=
 =?utf-8?B?OVNBaVUrYWQrcC9ZTlc4TDN2SlBLaDk5SEgrMmZZRVFXUUtNUVpSRFVtMjhU?=
 =?utf-8?B?OTVWdmlVSnU0RHFITktHVDlsaHlQNnZ2ekpGU1BndHBTbjJra0Y2clRJOVo4?=
 =?utf-8?B?dVFnR3NSZ2NkRFBBQkxNNW55cXM1MnhFWDBybGRNTmF0T01iR2lma1hZRklO?=
 =?utf-8?B?YWFyclBJNjdxSnNIelBuVlBiMFBDZVlvdXlEQXpLbDh0QUhRVm9EYnpKOW83?=
 =?utf-8?B?dEZGclFHREFhZnFRMGhQUC9ab1B2d0xkM0ttUnNKdkNncmorcG9MU1hQcTBB?=
 =?utf-8?B?eis0V2tzQ1prbFp2dHAxY3RvVHJqcW9JQmJvUFhwRkxoL2E1TVB2OEFtSnA5?=
 =?utf-8?B?WEpLUjJ4Y2JwN2FNOXAzQ1p2UUhTb0FaQ2dUUTU5elNGbXdmWkNjdk5QUW40?=
 =?utf-8?B?WkphUHBJZHNHRWFrZHh4eGNERjczQWxuM1gxYzFJVjMwRDNpdUZocktHYjNI?=
 =?utf-8?B?dzlUejFVMEVrbUVGaVkxa3V3Tmp6MmJNa1ozTkxqd3ovdkNaWUdmS1R3WURF?=
 =?utf-8?B?OTFLOXl2MFBWOUllalUydVB3YmVlUW9tajA0Y2JFZzBYeEhNV1RybnpDL0Mr?=
 =?utf-8?B?NUVqUERXWkVPQ3hFelg5YktKc2VQdjRUWHZHekUyNGg2QkRvTW44VDI0YXV0?=
 =?utf-8?B?UjBTaWdTU3lGdDlhZ1dEMWNKVlJDUWYraitwalRPTUgwNUE2MnU3L1ppaHc4?=
 =?utf-8?B?U000Y3dXWFJ1L01vRGl1SFBWZHNVZHFlS3FnMThYWVluaG4rWUwyYUZmT2FK?=
 =?utf-8?B?em93cVFVaWMvNWpncHc0WGRBTmNQWGJXdE5oQjlUWTJrQUxtcTRaYXZ2b3hM?=
 =?utf-8?B?Yy9GYmF0Z2ppTU5ubTgyYWsxWDZUQ1VDSFF1bXJyaUk2K2hYdDg4YlFrZ2dn?=
 =?utf-8?B?YWY2aEVPUWlqVXl0THh5SDVBczBSazdsQlRWb2E3VFRlZkJFNThQVEp3NDRl?=
 =?utf-8?B?WDJNVlUwb0xmSkp3cFRnQlhYbzhNOVFPWWl6NVUyZWRRWWkvNnNtRjk3V3RQ?=
 =?utf-8?B?M25OS09hSzVWSUUwSmhMM2Mrb3ltcnNIRnVOTTBzVmFSUzFYMWllKzBQeGkv?=
 =?utf-8?B?RU0zdGJyaGNadnRpSkhkQkRQR0RsOVhPTkVEM1V1QjlkR1A1UmltSnFrOG1I?=
 =?utf-8?B?TnZTeDdpUVRqSkZjdGlrNUVydG0zWm02aXlpWkxDWnAzc2lDNnBXc1J0U1NW?=
 =?utf-8?Q?2vAKQKV5AgAPxewM2jdPD47B25lZ36/O77HdDtu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc331374-2d02-42f0-eccc-08d976676929
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 03:34:36.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czqpkHM1Sg7zcB7vo8VODSToNGl2iaCtOEorfiAUUimDp8KIEbvwf+ZZx+NuR00+mV7cd6XFqUGPjyivAPv9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0805
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: orR1EuaAT6WI9s1Z3dvsa85_qpKAt2No
X-Proofpoint-ORIG-GUID: orR1EuaAT6WI9s1Z3dvsa85_qpKAt2No
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_02,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109130022
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U29ycnkuIEkgdG90YWxseSBtaXNzZWQgdGhpcy4gSSB3aWxsIGxvb2sgYXQgaXQgaW4gdGhlIG1v
cm5pbmcuDQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2hvYWli
IFJhbyA8cmFvLnNob2FpYkBvcmFjbGUuY29tPiANClNlbnQ6IFN1bmRheSwgU2VwdGVtYmVyIDEy
LCAyMDIxIDc6NTAgUE0NClRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBQ
ZWFyc29uLCBSb2JlcnQgQiA8cm9iZXJ0LnBlYXJzb24yQGhwZS5jb20+OyBaaHUgWWFuanVuIDx6
eWp6eWoyMDAwQGdtYWlsLmNvbT47IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8xXSBSRE1BL3J4ZTogQnVtcCB1
cCBkZWZhdWx0IG1heGltdW0gdmFsdWVzIHVzZWQgdmlhIHV2ZXJicw0KDQoNCk9uIDgvNi8yMSA2
OjQ5IEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDA0LCAyMDIxIGF0
IDExOjExOjE1UE0gLTA3MDAsIFNob2FpYiBSYW8gd3JvdGU6DQo+PiBCb2IsDQo+Pg0KPj4gWW91
ciB0aGlyZCBwYXRjaCBoYXMgYW4gaXNzdWUuDQo+Pg0KPj4gSW4gcnhlX2NxX3Bvc3QoKQ0KPj4N
Cj4+DQo+PiBhZGRyID0gcHJvZHVjZXJfYWRkcihjcS0+cXVldWUsIFFVRVVFX1RZUEVfVE9fQ0xJ
RU5UKTsNCj4+DQo+PiBJdCBzaG91bGQgYmUNCj4+DQo+PiBhZGRyID0gcHJvZHVjZXJfYWRkcihj
cS0+cXVldWUsIFFVRVVFX1RZUEVfRlJPTV9DTElFTlQpOw0KPj4NCj4+IEFmdGVyIG1ha2luZyB0
aGlzIGNoYW5nZSwgSSBoYXZlIHRlc3RlZCBteSBwYXRjaCBhbmQgcnBpbmcgd29ya3MuDQo+Pg0K
Pj4gQm9iIGNhbiB5b3UgcGxlYXNlIHBvaW50IG1lIHRvIHRoZSBkaXNjdXNzaW9uIHdoaWNoIGxl
YWQgdG8gdGhlIA0KPj4gY3VycmVudCBjaGFuZ2VzLCBwYXJ0aWN1bGFybHkgdGhlIG5lZWQgZm9y
IHVzZXIgYmFycmllci4NCj4+DQo+PiBaaHUgY2FuIHlvdSBhcHBseSBCb2IncyAzIHBhdGNoZXMg
KyB0aGUgY2hhbmdlIGFib3ZlICsgbXkgcGF0Y2ggYW5kIA0KPj4gcmVwb3J0IGJhY2suIEluIG15
IHRlc3RpbmcgaXQgd29ya3MuDQo+IEknbGwgZXhwZWN0IEJvYiB0byByZXNlbmQNCj4NCj4gCVtm
b3ItbmV4dCx2MiwzLzNdIFJETUEvcnhlOiBBZGQgbWVtb3J5IGJhcnJpZXJzIHRvIGtlcm5lbCBx
dWV1ZXMNCj4NCj4gSmFzb24NCg0KSSBoYXZlIG5vdCBzZWVuIGEgcmVwbHkgdG8gdGhpcyBlbWFp
bCB0aHJlYWQuIEhhcyB0aGUgaXNzdWUgYmVlbiByZXNvbHZlZCBhbmQgSSBtaXNzZWQgaXQ/DQoN
ClNob2FpYg0KDQo=
