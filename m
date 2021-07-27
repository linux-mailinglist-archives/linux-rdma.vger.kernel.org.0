Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19A43D7C7F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhG0RqE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:46:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27822 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0RqE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:46:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RHQFqP001168;
        Tue, 27 Jul 2021 17:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hIvsjUwFJAcJVo8rIzDAEbBVT2/T25UFZKoTyJqY9J8=;
 b=ChXSCULPugRu8oI0siPj59p5ES5Bsd+qaF9g9O773tcI74ULvCCbpD0d+ygsLsGG2oQg
 8Ba6UBD/1mCXf5GyLE9iPgt/LHRPR8qgKT2D8kP2QxMwPZHirRP5+CQxUTbLE6yL+/9L
 eqL0TMJOzn2dgoUwxYxNEzx6hIByiIfajk+29CcE6Npe0WG/Z6hE8isomzqevylgz49r
 /7LwjUVJpqTxV7F0wevafnwkV9R+DuRYqNdUmi+3kHK2rKCs0IPzPYztQCQ4rADV9aXa
 PYWF/HhFXQkHfPRIjAewUsa+NkIV3Te32comtb0HgmXk31PGA+fdG8QNpFu1Tf6XvzrA jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hIvsjUwFJAcJVo8rIzDAEbBVT2/T25UFZKoTyJqY9J8=;
 b=bcunzfPxBuDKfqWYEdNtWCnINd0gth4aF5ZYTlTVEok6cL7fATde6evbryumRM7S8DjS
 aoGMrLHGQpSiQrIq6m55fYiosrQErXqNd4BYLL7s1zhIMd9IuAHlOrRLdft9SmT1pdQ5
 +OFu/434fsaZsMjrzzxhmjpTBiEr2gRAIvhr7Z3JjHCMzzxfccIqya7fLrufN7FWts2q
 40KZ4tU/RXVxYKOzkl0STzA88++A4JYt/lKKxrOM4/ETh0D27xqxctcW6TXgQYfZIGte
 HOOQDxsdL4vOu5PUkc+Fn6oM4F3D/11My637CDYDTDpRqSTgQMZ++K8m0/txfGOMWRdQ 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2353afmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:45:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RHVUUO013155;
        Tue, 27 Jul 2021 17:45:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3020.oracle.com with ESMTP id 3a2348k16b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+JBhSJiRuhkIlpb2Zx1NKxQzDUJVc6nab4Rw9BpF9WrsOjDdFXLYXhZbOdflAVquKNdMJb2+Z05/JicJ7L3dUCWIZjxZ30DdPcDfeutFJVsqjH6xLOsbpTlqpBX4m8zL0w7YlVYKq49oyjchMslmOeMPyB37R7Tld2lSzqDdMoTB6WnPe0+mULphddjUgWrkG0/PqE783/x2keTu4ukVZQFopJrxzP48GcOSdB/uVG2dJRJcTq+acihzX5EB+PUF4XiaY7Dh9yRQeUE3MhcTn/xOMs2icVHR9JvQzczG3p1URPWYSqSh0jT7ltLLk6EICB8GUDBjqrxpHP98zx7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIvsjUwFJAcJVo8rIzDAEbBVT2/T25UFZKoTyJqY9J8=;
 b=Mf77gkMYFw87jqn6lZij4+jh8bH5Uz7+whtRaxCDO6NskIi89s1/gDM/cYe6YZpAcWFmKRn0uBdyXCwS+GbgCKKFPjE6UM4QGM7+lbiwTGOJhFfguuGT1jagWvOzlP/L+KZL7FiTlIBs95vBVvkgOIPHNvvbCtvpswieB7DZ4idOtIZ5QTYPi0W9h2dNem9kaNk6I5TJ4vZ4W/9PpAc9GInVV2REC4CvObtvsF/eH3Y/2Nt68mqhG51dnytNUGEGx++X3ZJZttwPLl+nVs9q5y1TB4yTFhSyBqmL3RG1OSA5ASKu3IteRCuIs3r8k7KmUMbF3ZnEUeEraK7caUiWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIvsjUwFJAcJVo8rIzDAEbBVT2/T25UFZKoTyJqY9J8=;
 b=Y/AuxseiPYFYpWtgzhwf2RGG1mYgtU90C4Zr/KciNCA/pC86hSNpnyVG8PIG0L4D0UCq6StGulVCQboa/Npqxy/SVofd2gpTud52a9lG6p3ZXfHseLeyy6eO++XBKAFbQe1TqxhEk+eUKI51wNp8J95FE3Z2NmbIjEU1+VFbMJI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 17:45:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 17:45:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQAACUb4AAAE5b4AAAJPuAAAA+IwA=
Date:   Tue, 27 Jul 2021 17:45:54 +0000
Message-ID: <29236B57-4AEA-4DEA-AC6F-4402FF8A1A83@oracle.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <20210727173857.GI1721383@nvidia.com>
In-Reply-To: <20210727173857.GI1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20acb24-4a05-45b6-3984-08d95126624c
x-ms-traffictypediagnostic: SJ0PR10MB5565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB556505566453C75D70C6955293E99@SJ0PR10MB5565.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stRWLtCzYEwygZ83LoTsNH9xqzIFkp/fpl1HVDzagWUR5K+ZJLIRL+DhQgE/hOVbFBFzS31GkND51agZjFgAopE7B89/KmBjSp/QJxqhjsPosR5u1iL9dXju3lUJNY0JdEP5WPQQBG5OFUeKenst4P2e53XrtKK7IWOaZXYJtljzaN8Ea8rj6gLC63GO5Y6o3BFdtEGMHfl67fBaWzhEu5P6cbrWjc8hh9uphDJisPhru3qMeIu8lULTwzusIii78RUXsw/8N8zyk0uTi4JXJj5Oj+g6+U2rojhNQw+xxKVDTpM+k9/AMKhZdWKY4/yEv9MdWgluNnAkfF+UTIVov/Blvybenhskq+fvjrn9TxRgwCTWBSsyR0Auwa89Rno8ihvH1AQW+hxt+kbYBl5IoR4R/a5YbAMhriCWMQbqxOEB47hE2uHr8THFRg8pQCJBN7kmUtLjLVVKUvU8feFUvBdLH+L6VypiWMZyYMQrA6AzEEBSyMlYHTF8N2PRuduNRrLdD+O9fK/Orr304nTNkjmpK16w2EBVSxeRT542j1gUTLsoL7f+DD8fq+LClFWGZ2RFISTy/0OHCM0um/VP8yAYG95Z2DdRWu7v1oVQZiN9m4ZVyNYXj1l2XIzTtAn8lQQSL8RbtS/XVhYmX+9QUavML44BtTzTn4ZOcFdxOSPGk+chNal12fD8wSmbOBVo0r0Wze9JxvZYK0cqPS0yDPlH57GDRYqq87Bi7T4m7kB0hbZ+9ypMCKN8aXtWqMSe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(38100700002)(6506007)(33656002)(66446008)(71200400001)(66556008)(54906003)(6486002)(2616005)(6512007)(4326008)(64756008)(122000001)(91956017)(8676002)(186003)(66476007)(478600001)(53546011)(8936002)(5660300002)(316002)(86362001)(76116006)(66946007)(6916009)(36756003)(26005)(2906002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhov/ABqxnEg7qB5eSePInThhVZQoxiSTV6dht7n/2Edgp3ShR1bx+64txyg?=
 =?us-ascii?Q?wzZxNNSJ3z2n/Fnk3OA3bgOvievI3THynBIF+/6OXj6exqI09Qb7KNExXTVv?=
 =?us-ascii?Q?/C2SbDNECjy8qBbHIKdbNWvlvB3g+OVl/Mo3f/8fmUJKLhfRRcqyEzp6Uv12?=
 =?us-ascii?Q?PPIhPfEd1tLM9By/bQrD7cIET2sL972IoaRZ+cN5lQVT/1+oIY4kxSurveXy?=
 =?us-ascii?Q?aJ1pU0pRD9TMSu1IEwtrIjx+aTcTl6OCzWoZUjhseXT9DeA8k0/ZnDOUv2Rf?=
 =?us-ascii?Q?GtLuO8o14BvCOze/Fbzf+s4V5uDfJFLVZMBf9DGxy+dCAodNNaOh9k6zN+SO?=
 =?us-ascii?Q?PHVy6aGM1712vEbckPCS6x1uQVgssdQnSEzSggYlABimmfsq6S/YDLK3YFhV?=
 =?us-ascii?Q?lhhlr/mG0bN5Y+INIFlf59pQ3u+pbNmKkRrU15o1pdVUgen5qJwGrB5I5j4G?=
 =?us-ascii?Q?RIi3bP21fXYvAj3dBHJiz9T3XIRoekmpraEusCQ92vQVCddWMjVg0nHhKuMj?=
 =?us-ascii?Q?twETrdZwx34Xd59Ex1mYpeDj4BZxvYHc67UEVT81KualYMBIlP2dG2SKbam3?=
 =?us-ascii?Q?u989XSJYCoNzLzg9r1oVIq5wSHQIiepeUjjrQZI+ywNwJ/1C7s6kmnGCZeJs?=
 =?us-ascii?Q?M6LX6eJu4+VUE/6fbNN0nI4zQ5tXgE4CEPN/HUZyZuP4bNTYwdNcSOMaKJh7?=
 =?us-ascii?Q?K/MX5a+rKAaoB3uW908gWjnvE9251a5q6l5C0AdPsozv9eJEmaJ3/+bGYKYi?=
 =?us-ascii?Q?Hvllh88IFLxiAVGCgWl1Uwpa2B4pzpEofdHTyVMBm/gK/8wYh7/0O9Tg2pB3?=
 =?us-ascii?Q?DweUZJ1st5a6Zo+hoDbtLmpmcH7L8AlXjSCWIkf87ZCWKO28SptyPD/+BOPg?=
 =?us-ascii?Q?PRMPt6oZ6q8BUei25oKsJ4whujxOJSVGYHtNPZvUNB7xW8OeM+mA+aPIIkft?=
 =?us-ascii?Q?3Fbzk1Nvuu0ioxm6rL7VhrGrIhdw07X6oKojG0YaBBAVjsyozufBTmzfjpuO?=
 =?us-ascii?Q?pY3vfh+nMsYX9c5wRhqdyxl8IeuwJ9c7nStwDPfVS1diWRozLk0MXoq1tX9a?=
 =?us-ascii?Q?nyzNjVAHYekXupTHIN6L90GP+DLFZuSS5EtdiO3hEb1eAjbddcs8Er4KkCRn?=
 =?us-ascii?Q?rVERb2xx8kxnqYKOcmIActbjkaqK/qalNoLHyU1kF315dImDTM9ZJnEztHAP?=
 =?us-ascii?Q?wRnjGYPJyQd6bKnwYMzmXsec5kam4Z1u+uSkwcoUwLZGIihVzcqZzzKy4fCL?=
 =?us-ascii?Q?h9C44/1mptQsSGDpBnp7y9vfPXdIXGEYhFti88whr+mOX7nUDIUctYj6JqId?=
 =?us-ascii?Q?bbLsop2njp6PXJfzNzkmK28PxfxZ451PAApkHoJZVJLNKg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA92B837E8381F4C839F1CA71A051FE5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20acb24-4a05-45b6-3984-08d95126624c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:45:54.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITR6/J6TWRPky3za6uIEWTkxcfcZZuzuWBpsxqQxg+cbyWYtcUphjNffJb60iHerAb6ooDgTQUJLaytQiJLBvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107270105
X-Proofpoint-GUID: -JbV4HUvF3wXryFqqkjP2KDl_1k8_IHC
X-Proofpoint-ORIG-GUID: -JbV4HUvF3wXryFqqkjP2KDl_1k8_IHC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jul 27, 2021, at 1:38 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Tue, Jul 27, 2021 at 05:35:46PM +0000, Marciniszyn, Mike wrote:
>>>> On Jul 27, 2021, at 1:14 PM, Marciniszyn, Mike
>>> <mike.marciniszyn@cornelisnetworks.com> wrote:
>>>>=20
>>>>> I suspect the patch needs to be reverted or NFS RDMA needs to handle
>>>>> the transition to INIT?
>>>=20
>>> If I'm reading nvmet_rdma_create_queue_ib() correctly, it invokes
>>> rdma_create_qp() then posts Receives. No
>>> ib_modify_qp() there.
>>>=20
>>> So some ULPs assume that rdma_create_qp() returns a new QP in the
>>> IB_QPS_INIT state.
>>>=20
>>> I can't say whether that is spec compliant or even internally documente=
d.
>>>=20
>>=20
>> This from the spec:
>>=20
>> C10-20: A newly created QP/EE shall be placed in the Reset state.
>=20
> rdma_create_qp() is a CM function, it is not covered by the spec.
>=20
> The question is if there is any reasonable basis for ULPs to require
> that the QP be in the INIT state after the CM creates it, or if the
> ULPs should wait to post their recvs until later on in the process.

Existing ULPs that have posted Receives well before the CM_ESTABLISHED
event suggest that there is a longstanding expectation that a QP
returned from rdma_create_qp() is in a state that is ready for posted
work.


> Haakon's original analysis said that this was an INIT->INIT
> transition, so I'm a bit confused why we lost a RESET->INIT transition
> in the end?

Perhaps the patch should have removed the ib_modify_qp() from
cma_modify_qp_rtr() instead.

--
Chuck Lever



