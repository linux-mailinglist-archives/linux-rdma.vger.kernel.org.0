Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D058AE31
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiHEQat (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbiHEQa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 12:30:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9C7648
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 09:30:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275FXvB3013364;
        Fri, 5 Aug 2022 16:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qSDBcJ5wLf/ezc+roIxb+MfXtLKV5dm0I4UYSH0CNvU=;
 b=N1aw6Tzq0ZxTJwuyihssCk2FMLKSkjqg9VcSJJEEs0cUbNcdRFRAbtAtiK9+Je+W2oug
 44DpJmg9eCX/kdWyqPNM0HVTNLeTuWHO2yxXPNIHtJ2gRetbuOuOp3v9eq0kJVYqKCcL
 YMO+PSxhaE9ej2xfADpBonyLjNROw4NplZXwDrXzbUQvsQ2unyFBon8tCvHT8OwmnFq6
 o8fecFIbpHL3PEM/tkB1rye9noOztscVXGqY1ivpsOoG/iq1uBnvmwaG09BzxOuI/yk+
 AsY2XXidtcAay88zlseuDekZBAwmdShNNiEVT3xZfMkiGzjr0n4Ui1GRijgBUKuW7iRl fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2cfupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 16:29:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 275FZvVH001480;
        Fri, 5 Aug 2022 16:29:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57uce8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Aug 2022 16:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMegZSzOOVlk/neiiEjp/FQdULCOvloo+Cutkc6bcnHLkZC9o0zlJ2ETVAq0JEeTB/VNb0Vc0u4ZJ/k6BAb3bM7tyKOScVjJsFolcny3kc9UT0PdJ8j2TwQRSc1hSMwyIKCn/2+ul7H6s3fIV2fjd1UBG/LxNxPT5xoaopD2XHSmObNxmnBr6hei1Ip4R9uxTA6Fs/wgimB95nAkVSk7Ld8TtDE9W7W9R+xekueyN8/rMudtnkA/1dYFFdlRBeS7aKvw7ewie6R/jIl/4x4Glgl7fNl2Ittqq4uvjGGWRouTRpptoFkxu8UmO7KU0kaed9FEsWpDZJmZSQNTDrjsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSDBcJ5wLf/ezc+roIxb+MfXtLKV5dm0I4UYSH0CNvU=;
 b=mjiIG3IFYqk25TM8OXZWsoB1PE2TuQ+NNmWyGDiUnjqeZZ8516+y4dVFzFSbAjCksfF1Vo6u+8nP2+vC6bKsonyyDj3zq4d4k5LadDVxjcoYEIVOlT1LksgXbCkIWcHCQ8ILmNenzlfTceCx3gAIJamHGbrmNQpbTV/Kqyk/cusLKyeuHyHPbTL4fg1zII8wOiOEyNb4dVviro2a/KV2IsBpNahbv3XfeoRhGVZy5MNAp1E6/iqk1se+7rF0ETjhjkQFjZUf5Bvgz9c3yLBquqIPKhKgf4xLvZOHagQTkcgr8QxcnwxkwNCrLj3njcUODOBirCXDdCP04AprOl4QEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSDBcJ5wLf/ezc+roIxb+MfXtLKV5dm0I4UYSH0CNvU=;
 b=W/6zQw9/St1GEfOXU9n66WW4X2COax72i6SeEsNnp9KBBLTAIH4QEfji2DR8IMkF2PeERlYP1DXCbdFDjfnW+osH75OToQTb2T/UkhwI7+mPXrlOlYiUugHh2azujDEbr+3wiWWBrhfUE4woSMDzwTGNe1vqpWNP/X2TbGE58Fs=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by DM6PR10MB2428.namprd10.prod.outlook.com (2603:10b6:5:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 16:29:52 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 16:29:51 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Thread-Topic: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Thread-Index: AQHYe8/FJJbPDZ0ej0ioquz7QorGFa1RxqqAgE68y4CAAA4MAIAAR/+A
Date:   Fri, 5 Aug 2022 16:29:51 +0000
Message-ID: <045D4EDF-5726-4DE4-A83E-3FB3A412345B@oracle.com>
References: <20220609070656.1446121-1-dzm91@hust.edu.cn>
 <YqrwibTkaDig+QfI@unreal> <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
 <Yu0JEAbEyZ1UwSaQ@ziepe.ca>
In-Reply-To: <Yu0JEAbEyZ1UwSaQ@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3729.0.22.1.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b36bbe5-3258-4afa-a2f0-08da76ffb904
x-ms-traffictypediagnostic: DM6PR10MB2428:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JW3glwxAjchZ2z7tVySHcsrZ0H32Mq7Ts8PtPebcRNixER+6y0JRPUNCb4fBN3SIRivM1qd6XmRYZS8iwXHO2HvZPuz9Tbv1pwrwXqnZQwu0kDiIJsDO3n/4guLpRudwkeoV7mKzDwOZivsA6SFQfKKgrr7kohinw1WuhEQWrZE/UUeSBWfm/RKdMFXZT/qPkVK6RHlTCYvC+RA4+BWPjH2edCri6cwPBmmq5bGKuvymf815NbzpCP2R6EUBFqtoIkYQUCsMVryDXJh+QIDV0EkdXLzjGnXGJesQbMRwjDE2Dq09dw080Dw8RC5BfzZlFcoC4MllMzstq3oJzkzO4fH7yMVzgUqpAX1BR69AU5yDE2q9U0o24oJQWt6SMQHop9dRtpQgJj1dzWxiBrEkEzhgVOFN/GSY/7P6xyhDdIYeVJC2wwojxupxKmruRq3XXyaeMPJvlPH31MzwHbQNHwx5ZcCh7JLk5WqGB8Ma86vSI2UOo1dEfVyOMzLZKNY5abrb3Kq+2Zt3fsMffOhxmnRNfDSdajW407z84i6bjhz14dNZ0B9dhjyPvST5FLEkcg3GWDpmvHLab3tTSnzvtbX1hEEU4zoiq+ScxvimiJAd1Djz6YcocljoNABf0I08E2XGh6Ejg4i44Ha/xf8ag+Vy+m9VVsEKH5lFl7Xu3GwmWTUSm+i5Nuf05WSd9p01hjFSfhnhRT0dRzsO3+5Qa3B8gM08q+1ouDMhLhMS6+AEra2LzaSV0fWVkjOcPkoYeCpShdQ8MbzSxhPbW9mPDrJyXWzZriSOpeMfxeB+y94wjb6SIZ8aOgK+HKIq3qsdJeV94yLxA4AM7U5hAQSAMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39860400002)(396003)(38070700005)(44832011)(5660300002)(4744005)(8936002)(66476007)(38100700002)(76116006)(8676002)(66446008)(64756008)(122000001)(91956017)(4326008)(66556008)(53546011)(6506007)(66946007)(54906003)(6916009)(6512007)(6486002)(71200400001)(478600001)(41300700001)(2616005)(316002)(186003)(2906002)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mt4bvIbHgS1JZcz4IcVyTC4pp+vrojyNWDUx6WoZbesMRPudiX+sy8UJs3a/?=
 =?us-ascii?Q?Psep80MlQy70Y48qTS87qcGk2rgSizywjwAHegTflzV9u7aksK+eA9HyT9Dt?=
 =?us-ascii?Q?nobLeKoqeNZgEU8xhLullKBA/D20o8Qp2Ds/kkx1gnCVGP+PxLZmfDE7Upky?=
 =?us-ascii?Q?vtYDTh0fpuBS/pL3XvPgOlZwTVQ+EeegMmRtdNVqMH805mJx/i4FWvmqweny?=
 =?us-ascii?Q?EnsyTx0crXSuzeyte7lFuNXGdS1eFFTPowfKnckeXoCzucPLAu1rEvf6wA5G?=
 =?us-ascii?Q?MbVw60sytjinDWjQ3IbKet8KTQNMYCukDu+W9dVSEJaIMj0R5N1lVuj58p51?=
 =?us-ascii?Q?1Art4kiNb6XCEb/jOeMIC8ihoXxu6nInnztMxuNSESg8pVt3eoO8ZVlx5wua?=
 =?us-ascii?Q?qS8mxB59qWs393V6Fz7Usby0ZVHnC5pAu+jlHFXH/XeDTbB8awVNBezdC1KL?=
 =?us-ascii?Q?kOtQIrZEWjoEQQBoNueDIbCL207pN6A+I4Nu2IA/448d6pK/ZPYI3Zkl2F1t?=
 =?us-ascii?Q?aibhqOSFSIcCyghPBeS7e8tC0zYx4cHhzH7oS7V3b4PC8o/GK1/cHoq5wfIn?=
 =?us-ascii?Q?Z5AxpMJC5ho9A6lSkzBD35NTJx6W87Xq389I55K4O87IpPTz1eMh5r86RmqR?=
 =?us-ascii?Q?FpHSuXyAltpYEBgvB/6E1QjEzrJDnxwG85rBPieQn4bAnoQ79XYDk09q9dvL?=
 =?us-ascii?Q?AfDEAoF4BwNi3b6edq/8zCx3488oZ7ouC6KxV/NFzlt82sh9C0Jif2Yl8KcW?=
 =?us-ascii?Q?/XlDW/gjpTCWOdglLHssUiuUwC5mA07amcDUxDiLK9Sla4rRgPNEs7yZ5YeP?=
 =?us-ascii?Q?0J1enWYTVupwHMBqSvzZ5PLCqgQpSn0dY+fu9miE7b4zWkM1FbgQ30uxHJV+?=
 =?us-ascii?Q?BcQB+mKSa6IEKyBmJFgybpZtWdfnD/ojSnacyZIRUIPDFp3zCQgwB89j4bBq?=
 =?us-ascii?Q?x/YUW/BT1S1zskcrkEzLuzbLqnD9nuKtL6ncQYqogKHXgDUmcs+jNLRW87Vo?=
 =?us-ascii?Q?/vRD5q/aRAADou6oNUX3vN64w/IsvbavCcNXDYWrLWMno0Ni0VXmNs1pJjnm?=
 =?us-ascii?Q?S0fhjMTFokzUUVccH8fcJm/b2ZyEwvE/2s59XnvxSk+k2hJs4q2K9cgZA9JD?=
 =?us-ascii?Q?oXbi9R5ws6eHuTF1YnRCzrePi+YSDOmS0IZVJ2iyJ5RW57u74l0QNAQAPdR0?=
 =?us-ascii?Q?h/ztNmPLz3TLDb8frqP2Ueakatv7278avOepo1f9mbHpOOI3l3zvWCKhrDDV?=
 =?us-ascii?Q?RScH8DvYjwQsrR4AB07qVrAp5D/NTeM5ar663t7Uylu0vgmopeVryndQ3Nxh?=
 =?us-ascii?Q?MHyFvXIcu8RF5M2sfwkXelD5HEOQQmG8gKeTSQ9mAzdbFhmkLX/cDNOPOKKh?=
 =?us-ascii?Q?pTCIy9cghxba8j8Gl9rC0Sv1in0fpclrzDj3Bm5WKQFUTgoiCP+n4p+raVAN?=
 =?us-ascii?Q?z40IAQgMRb19b7QwCFl/Pbe/MOzHSiBSSQjsPmXTsBZazkqnG2dJqhZ5aw1b?=
 =?us-ascii?Q?G43yQ+AELkVXcSEFYCgudwO6EfguCkgqT1R6JQxM8J08uuExr0r4v2ZmWXqx?=
 =?us-ascii?Q?u8vern5p+BLHsClGOBmQyQzX86Y1q1ahEStdj//5HrsTlo3TrrGK5N3ao6bV?=
 =?us-ascii?Q?VPtUTX8AE28xViu3UIb4NOTdj6eBW2+KGvcu1kYZ5jY9+O3Iknnc54uBKgGb?=
 =?us-ascii?Q?tDbXCYIB9Js1xlkDuw3o181u2q0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7CAD119A2B4D1458D4FD34A442262CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36bbe5-3258-4afa-a2f0-08da76ffb904
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 16:29:51.9173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjzQmqp7CF3IobQtinIvO5CsB8+xO1SsaCIDEDl4/6Wg2DFttRNwlfw17lCznbqHoSrBEOvvIpXqNI95tMfX76nhqFINVvoOpx8oVidpEdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_09,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208050079
X-Proofpoint-GUID: gsmmg-Zda-HvHeYr3NJrzs5W7YvShSsA
X-Proofpoint-ORIG-GUID: gsmmg-Zda-HvHeYr3NJrzs5W7YvShSsA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Perfect, thank you.

> On Aug 5, 2022, at 6:12 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Fri, Aug 05, 2022 at 11:21:53AM +0000, William Kucharski wrote:
>> I erroneously sent a duplicate of this patch last week because I didn't =
see the fix in the 5.19 kernel as of yet.
>>=20
>> Do we know when it might be pulled into Linus' tree?
>=20
> Yesterday
>=20
> Jason

