Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D656161197A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJ1RmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJ1Rls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:41:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797A422C801
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 10:41:34 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SGIKDf031535;
        Fri, 28 Oct 2022 17:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Igv3cOtvME4o0Wp8knRlxujDlNLd0CIkKEHu5J5Qn48=;
 b=hfg6SCXL3hzR85hiUEXoa+Bb7ZeUhAlS95Q0R1NxRL4DGsL3H/DSpGAQkHOtYcyfQniQ
 l2KmFZDe22juIwWgqW0zy28JyNFyCKw4Jexpecf3MDEGNSWHzc2RiCi7CYOonl/kkwZ7
 UrW9CZ5TYxeXz3W1tx40fBEiq7zthVNdMC4vupKrrsunngMeu8wz8EOsenop/MH0Nfq1
 GwtI2x+RAt1BoP5PdySLmtjp2WVeOpbZw+U7iFtmbnhZQ2roMJs+F+mJWpCxoSNvxj2C
 SXiywYk7p0EnHnxiGYoldmLX8kHqZs/SQF1RYA3n31U4Z9YzHBJ5v9M+h53jZXqr4R9S gw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kgjfvrmet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 17:41:31 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 479AE1397D;
        Fri, 28 Oct 2022 17:41:31 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Oct 2022 05:41:31 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Oct 2022 05:41:30 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 28 Oct 2022 05:41:30 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Oct 2022 17:41:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHSCI7iahc3uWOamRHZ/16Nrtk/IwuXRgN4XJweDBQ5LR6CveaRuheYdDlp7n5HGOJaJPt9bKoyCi/SR0O6F4ZuCfJli3yDgxMV9RdKSZDC+wXOPOmb2jKOmOyD1HAGj0FH7xHxU5enstYUr5ebbnwMzNNlKU9HceXTc2PCngH8z63H0Xd9SS6YqhsnvMIfsnArebEjfap340/EkKbppmsudR6xRmD5CfrVlL/qxOfWa0OwQnMVFBsP8xJ5YztHWfm7gZaLxUfdfWXkkhurc+UmX6n6OT+O24DZB9aHC8N+5g6Dbxzq3xbQqsZvBkSErs+MmB7K1WX52/XOLJ3uxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igv3cOtvME4o0Wp8knRlxujDlNLd0CIkKEHu5J5Qn48=;
 b=E9Ozq1o41pPt7oM3kTeAC9U+l3Eg3sWMdi/TSp76q9c5fFCVpQIhKmjPPgJn4mrDYHoq/sIfpL0B9NnfCLr08yTZp11ixZTOj7Ef6gGtrpi8QuUYdzLRp2troeXSRbiQAZHp3hsnomVdBoDqygCV5zccafkpN1p06cMxnm48nGUMkewvYPdV6dIn8ksqzlHq/rHDX9hxnG/unMj2akl9lk20Y8KQ7Ag4gGZrxO/O9nvrJlqru6qrmLIE2neqrpkMSkf4/Nqx3AjWCRDrPD+JKPfAlI9wPIaUAN0LPNimiPJ/Lnx5Nzk9uD4SihEDBtInomXyxfWaL2G9AO8+R6FnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1490.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:41:29 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::89fe:b7a3:29b:fb31]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::89fe:b7a3:29b:fb31%8]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:41:29 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to spin_lock
Thread-Topic: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to
 spin_lock
Thread-Index: AQHY2aXbRyRCNLw/JEqbT7kQ4zFVqK4kM1SAgAABz5A=
Date:   Fri, 28 Oct 2022 17:41:29 +0000
Message-ID: <MW4PR84MB23075142FFB21BDAE8B18D0BBC329@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006170454.89903-1-rpearsonhpe@gmail.com>
 <Y1wSRyFc809rFohX@nvidia.com>
In-Reply-To: <Y1wSRyFc809rFohX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|MW4PR84MB1490:EE_
x-ms-office365-filtering-correlation-id: 89ce4848-b1bf-4e90-2c2f-08dab90ba532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kJxAkNCFLj1nRBmH0rLoE5HWUxWihp8dHwpPA7nVU2oWSyo4NicQ7KQJFgPRLL75+PNH0qLtWxVBw4ZTc8m+zv8Bhv0OMaTjlSOiQorKd3XQtWFsOE6LXjq8PiE2sPtzttDyu9p/YMGvERQ1vQfX9J2hlrYY3jyI7BIRZLxvCIT3CGA4pwezZClUhX7hiPtpfZtmnhPqKpNwVIwMcIOCdCVCzlJeyiEBjJLAFTsMA825Xd9SZb3NJgSgOtL2NwYg/agFWuo2lWI+hJWznwkVzKMgkuNK7J/ppm0x2WeD4icfS6/t9aA01fRoohdqwD7kVk63mK+vHUXgcypOcY6+vjhzXOT88n+zHeppRSynFe1l3KGGGqEKCngHDBkRGDRurp2xgiPhVOeyDCgGmwNzeC0ATWTFhqi1iqSNu/bUqmhv2/NQbtt4h1ushKrIxUpk9RBmMbq/vkuMK3Pd4L2UIq7w7uU1joojn6NWN3kuJ3Kc//XLk8JFE3oZxHBUyYtBs+cpubTP8OUJzctOCv6oVBWrdzD9+q4JSy79eBM8un2CEfnWe8H52HDzY3HdJAytTE5wP8tvcnQcRCoGx/+4awb1QlulGBdePiQJs/kjfM+zMuFCC0kitj8KlWVoK88q7ECYXiYoqoJT91xbi0mAbk0qm2gwbUgT2Zgo/d29EB9r3NfGYxIntm925ZBcDFfgRMGkx0Ba9HRQYzDzjEP8BjANCx86lmanM5pMjau17+Zc13cXsBxRY7nGgtBP5Ie4t9BXJZYxLwElpcJonJUIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(122000001)(83380400001)(5660300002)(8936002)(2906002)(38070700005)(33656002)(86362001)(76116006)(66946007)(52536014)(54906003)(316002)(71200400001)(110136005)(478600001)(53546011)(7696005)(6506007)(26005)(9686003)(82960400001)(186003)(41300700001)(66556008)(4326008)(8676002)(64756008)(66446008)(66476007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ho2bPhHzlWAOXNnUoVv4PmpX4l+nlJlRQsprHXWd9sVbegOviBgHdJTSJSVc?=
 =?us-ascii?Q?Pwhy+6o3F8rPkV/HHoxYOLjpGuw38C2zZ2k8nNbR8h/3KQBLHXIiL0m36EfJ?=
 =?us-ascii?Q?5oAkr4A/b2/WVs/VGHUcNS+Kn3xkaJpQJ1cGS1DE97oFv9kJbte+qka8ksBf?=
 =?us-ascii?Q?OzvQY/BvQG1ENShpl/FLZzRTLOar+P2x2vj7KgSu/gZ8CPk+agtcrGVjiffj?=
 =?us-ascii?Q?Su6KjvBH3GRaUHTDmjiYciLqev/qaaDNpEhCQ5h8PsZpiKt+E1jF5Hq2A1/m?=
 =?us-ascii?Q?i0JrRby934ZrjUOjtHOYZSpFb4hQjdXDOLGuNaNqFxtsUU5UuggmLPBliOnM?=
 =?us-ascii?Q?Whs3+pt927XV6muiO48RE8TWPF3rKt4ZeGyY6ZUldYso284Rw/WCND00idex?=
 =?us-ascii?Q?Yt8AFZbO+E/6qpaEPCeJD7gxJj5oLBfxgrreyMYXHv4NONFrmPhdthilwes3?=
 =?us-ascii?Q?aAVsQdEvzHurnE7fLA0pUlingqso/O/edRs3YxEZW+jS25Prv0429serC6i8?=
 =?us-ascii?Q?nrrPWEKD5ZwfjXNkUCqB/TpTGMQN6MkJ1ECjTQZCcUKZcuIEgJMV35h3/eVT?=
 =?us-ascii?Q?lyXdPyaHjmu+X7Kh7nURCT0OEuYfstobRDv5lojSHITXxh3iGzKGXTdzLr0G?=
 =?us-ascii?Q?NgCnUR1A5+pnLJBapHKXPXG8yhpVxsUayNlwF0QhWHnlBiy+DV3kMmez9e6o?=
 =?us-ascii?Q?ABP60zG7ib8IlTaHmG2Lwg4G5jzcdAKQ1tEwCf3hiqdcP7SXubcQcezXatcB?=
 =?us-ascii?Q?i6mhdPJWoFm0KOtvbiZysAnX8+S95vOsdynmr0lYfxjXfmhZ0RBI4IehaNxj?=
 =?us-ascii?Q?fkcJlPn6+JzogGlu6ZSD/AG3HRdPo84vXo4w6iQqH6RchQjj32Jq8OpTSCWL?=
 =?us-ascii?Q?a9Q2ymuPV303QJtVw+TfvTBK1m1xK/SbxPombAwNO+cOS7OSe42ZOQvz/MaW?=
 =?us-ascii?Q?nezV0iYRPWSBYukZIPBHDmntIafm0kdgq5fNVE25V+TfikvRdlriu8daSnYV?=
 =?us-ascii?Q?EBP4d25h+n2u5VrXqSHlGd9Tmp8aqyXD7pQ4/PQ64viKnZkg5yRmZbYzznsJ?=
 =?us-ascii?Q?rmn/4RKiW0WZlLL/gAoel4iu6tfKMmEc4SDcp0wmCxxyj07Ash9j/i3lZXWe?=
 =?us-ascii?Q?EYMvmitJ8POYxhdmSx1dmXxPtrOhwldsC3H+FOvwz5TOkGgy0P6sLDfc2Tz1?=
 =?us-ascii?Q?dXVwNzd2nN3tniorziKzueY1sLCob6lqP4juR1+z+fXEJ2PDz2j2+xeLOlNd?=
 =?us-ascii?Q?us0pzXSJrD09u37LnBuaJty1KvqDoxCidci2Nu1L9YpzD3GkPIqzrqwZGSQ/?=
 =?us-ascii?Q?djTeSWlxLVsEiN6STh1AbFtKiA3wRMORH+9hjg34BkkNiWPNvlUhRVgpFi96?=
 =?us-ascii?Q?jT8nO1qi+tPyT9xZuFhJjGIsDu9Zq5MNJ440kHPWq3eaCvFj95/fnEfsqhsm?=
 =?us-ascii?Q?M75okAG4ls4+SqbaBE5OrxJAjJAPcFxsyAUlfXbhxHlofI+DCLvKNnhPZA/g?=
 =?us-ascii?Q?NfUDYOuWjfG5jWUwsi/hr+bos74LSaw5WCTEvsL/HiygrnfTveMvWK9cIyR3?=
 =?us-ascii?Q?DyA6V34USkWuejySr+l3XfoUIWPvKwnHVY/kQCMW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ce4848-b1bf-4e90-2c2f-08dab90ba532
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 17:41:29.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEnH/30QMavOKRzB5mkz84NQIjvXqr5HWg0060hBg6MvkzvDgLZyQ9xDg64+VOnMM8rzMt8+CSzspQj0tlkv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1490
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: w_mJRb8oRdP0PgIsiAHT1M-Q6Up-nFXP
X-Proofpoint-ORIG-GUID: w_mJRb8oRdP0PgIsiAHT1M-Q6Up-nFXP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=562 lowpriorityscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280110
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Yes. Every time it turns out that you really need irqsave locks for rxe it =
is because some maniac is calling into the verbs API at interrupt level. I =
have run into this a couple of times.

Bob

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Friday, October 28, 2022 12:33 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to spin_l=
ock

On Thu, Oct 06, 2022 at 12:04:55PM -0500, Bob Pearson wrote:
> Currently the rxe driver uses a spin_lock_irqsave call to protect the=20
> producer end of a completion queue from multiple QPs which may be=20
> sharing the cq. Since all accesses to the cq are from tasklets this is=20
> overkill and a simple spin_lock will be sufficient.

A tasklet is a softirq, which means it needs to use the BH suffix for all a=
cquires that are in a process context if it the spinlock is obtained from a=
 tasklet

There is a nice table in Documentation/kernel-hacking/locking.rst that expl=
ains this.

Jason
