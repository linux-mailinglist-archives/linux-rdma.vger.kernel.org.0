Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684A16E7F28
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjDSQHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDSQHd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 12:07:33 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4288113;
        Wed, 19 Apr 2023 09:07:30 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JFrgDX004583;
        Wed, 19 Apr 2023 16:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Gwyn0qxkgjM+QxjZFih7ZtKz7qvcNB4MO7q7k5m2w/U=;
 b=Gufqk0I32AEXuR+bj2pvT/NBoUtJfAGl4J5Tks9MJQxIakWFXoafgz56/DjwtKTK9qYQ
 buWr3sNCeXSbSUaqPawwIpXFW46FKdG93bKPdgDn8gop5uM21eoV/v722QT500X8GxPO
 tzRCFUXGvZsJC1lRe7pSKhXHpWLJlt9jEKpae8yNyQucjs/ZK3YmdVbKxxv92TtiiSPt
 nXwo/zvjn4qJhCzAvpgPU5G2xgDSXnBaNFcM5fSdTpblK1SPK2wAzr6/4B8mPZZ9iHXO
 byZVVXjtCokFY4/BoLipg51XXJ00FUeDWQrtao5XsElU90qY+PuOI3Hwnqj4NLvnh7g8 Kg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q2kbe04j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 16:07:25 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 85E9C13069;
        Wed, 19 Apr 2023 16:07:24 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 04:07:13 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 04:07:13 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 19 Apr 2023 04:07:13 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 04:07:13 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ft+GGl/lFjEs4LfitigOMhUYJlmnIexLe6QWMuBGWAEJ/sswryhECjP1O/b6cQLhVMV3BLv4+PDLnHmleyH8OR4zjhDGsnHJfTmgK6XbqZkMxYDqNymhK4/MiqvDALJzGpG+KBRQYea3o3prDjeGS8OWx0PxGUNAZxJ3/1lih+BvHnBgdXx4ATOB26Cld+cP5QCZqXKidoxttqE/EuQSKsXd3/eWY0KANxbvBWrkE+PKVqmsTj41VkgX2QCMfSRggj+ZukG/jmopicqYvQqLMyfUBeTbSD0e1AdZ+wthQeJnHRQlv/aXobt6L15tTcAgT3nUvjYQj3gPJ50mlR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwyn0qxkgjM+QxjZFih7ZtKz7qvcNB4MO7q7k5m2w/U=;
 b=g2p8gaP/QR5hK/ksSJeB4SrvY78jX4c/UWiKydPhaR2+1IskqP283RI+Cdc5WZkIglkwZI52xvFxAWpmjSodeDbHjDlLc9CLquQG/0c55//ji4ICY+qQda5asJBe/O5+J1L1c4OSZMFs4yXGkN/B/61vidc/SVLX0u+iCA0JEFtw9kIo3jY2oEI3d+aKma5uoJtQWsEOvP7+UTU8byqqzeBP09ZmrleY4kyYKgluKN1uYL0aXl5QRdzOBICNhTU43qTXjRlRWKon/EfUL1jPs3DAg/g7O0mwLqqGmY2cajFZtyWl6B/Lf0VNB0BLimnh6s+oI2zogQiivBRvC80O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1681.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 16:07:11 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ad7a:bf67:d9d0:371a%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 16:07:11 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v4 0/8] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v4 0/8] On-Demand Paging on SoftRoCE
Thread-Index: AQHZcoObR/yRwrjyXkKQGV/1F+zJI68yzNAA
Date:   Wed, 19 Apr 2023 16:07:11 +0000
Message-ID: <MW4PR84MB23075F0B2E684D7EDE8AD6CCBC629@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
In-Reply-To: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|MW4PR84MB1681:EE_
x-ms-office365-filtering-correlation-id: 39b3997e-5668-4c49-bb27-08db40f02264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0MrffcqKgYEw39QopfXJ8IUnn5ZlbnCfV/AKElHog4pW/g50pa3ZK1dJm7AbJXiBENzYsUvhrS7+YpZu7CfbNFwAhKka4L95Zmv9EkRDuE+URGxowBgeEPqPJJOism9rczZw7OtPjvK1hPjYUJYrY1Gw8jdaVH7gRyXxuKh/GS947f050A2YfQVTTUhj04o/RRdPRXNuqrmWRynl4wIMTS9+X3OUPQzYFeEJz47PieAa04Z+tzPgzGni6EOYW9lBwpNl9Fg509tasbQCLKn7R7XS9TQwTNh2IQHP55BkmwLSb+3lgG1mdcmMvsdrYaNQ7KEGmPvxvoG/uSw196uLiuDFTi2YeI4PXREgdwQZ1MkIhZit1uc/0fu9lN3lalTllX+qDsoZecyVHnbOVN7DhbCITlhu57yNb5cW7wMtnEiTnGsXj2r+3awPO26ReysTT+6ODCAuhjJWO16YVbYGMs2WO6r/T2OY26bNBoI4jjUlZT9fSzvHN3AjwkDwOzChXB+y06X/2PGOyPGo1xfmLeXQgYjPhnGg6vYP71vo+2rkPCyga+gyyX3Jwyylfkq6BbSWe6d9LPqcqWlfODgLT78vDWSJhPzykY0K1XGeB/YoIJy31qX+UwMudRaX7OrFL6vUkw+W4TgMd4ILqb0Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(54906003)(110136005)(9686003)(53546011)(26005)(6506007)(478600001)(66946007)(66556008)(64756008)(66446008)(76116006)(66476007)(83380400001)(316002)(82960400001)(966005)(7696005)(71200400001)(186003)(4326008)(8936002)(8676002)(2906002)(41300700001)(5660300002)(122000001)(52536014)(38070700005)(33656002)(38100700002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B1vXBl7Q67IFntH7aQ9qAR0kYB5lDoiYFGEdeQ/z6pFrXe8bqrFpGZkGKpgx?=
 =?us-ascii?Q?tuRxTPFqM1YRQACmqReXZadLzib6I+p3WgMoWeKnVsYkA3buzASwFRIjI81e?=
 =?us-ascii?Q?oEoUcmW1j+j6kGPfXtaMNO2xIbqUbvX3jv0RtcAtUrrBbbR8kw+ZkD3ZVRvW?=
 =?us-ascii?Q?ZCWfwPimCU9XLkZeP+gpozkDJbNqNr2bYyKXLAY2GJR5aPQ/37m4o7fCqsc5?=
 =?us-ascii?Q?iU7lmnBzo2j6695nqXfxyiGFDKuHCw2KPBQihrs5KlBoOmUjnKpRes8uVIQZ?=
 =?us-ascii?Q?qmvPe8cNofQNKJfkq0JJ/XfMj6QJJknuSbMrs8uCYKmabS4p5Nh9A0fj12sR?=
 =?us-ascii?Q?5VDIGvyIEOjmOilZYcDzjHmFvvOb45LJqkhmIT6mSt21i+HRc1haEuflhQUs?=
 =?us-ascii?Q?jN2QlnlRPZVNaZiJrYVtRzV93+TTe6lTBaBjQs6tRHTW7EzMnYr1Hx7sUlm1?=
 =?us-ascii?Q?RHGVEOuOFSSUunTO+Wgal0n76huLg6Is41qXroGEJVV1WhySwTEZgkeFxF4N?=
 =?us-ascii?Q?I4PTPYSUkhHLcMjs6bsTyQgf6fauwyOpNVrQlk+uFen/dWIWKrt8v8iY63Vs?=
 =?us-ascii?Q?t+HNxZ96Sf5Y+/HznzcvDQAuji8yN86AaWL8xBbO/45kNbFtUUpPCplIHjnt?=
 =?us-ascii?Q?VQvCrfSmMkfnRLdORcfdWZAMBYOu9IbuJDvBuJJV3Vmlwmawfsv81w7YwqW9?=
 =?us-ascii?Q?z7WtqhoB0jg777C+lBeSyLgH/EUJPXkwJGp1nawm95JyYkiuW8jYa4wPwYes?=
 =?us-ascii?Q?7teDM7haUH56WEH+8sJuqkqh0pbUvoGGTKMyFJj/FZXo+v/Nu8uCQPuSqw3H?=
 =?us-ascii?Q?GbDdejwvse4Cckl9wD6WsgAWAWgYo3cqj00QyDsqD0zasXeVJYsv4mIDb17c?=
 =?us-ascii?Q?/Tt6a+KWtiRrPVrkKvl7kZuoQMkNLG54KoyQQtxjJESVWevLRiYNh6vbvp31?=
 =?us-ascii?Q?9THvwRwrm1ymXX20Zg4zLYzoyL9O68tfaTU7bxD9ioZv0JLl5hCaFQVsrSbg?=
 =?us-ascii?Q?BO+5b3UBDsM+W0mMjSQSDleCevWUUmWShRpER5Y7kvsgvQCIQ3bDwnnFYcwI?=
 =?us-ascii?Q?rLFzpkV3HVdv1jWI5FSQ7Ll0RAE6n4XWzAjbS5d6u7Lxr+0G1Ql8hpSSuKXj?=
 =?us-ascii?Q?O6vTdmc4oi+oF/ynMEoFOHJqsxjs5nlEPX5HWiybcDrGK6inaPs0TzO9ZoaF?=
 =?us-ascii?Q?eHFT244yx3sALe+LpJnoQMZzgJz2nKaebOtOpO7o/pssEqoBWodVM24oOHCn?=
 =?us-ascii?Q?s/8SmHCAIuVX8L0Q8sYGfo7Nglyan7ohvuKgjrSMALFQiwMMDMG6XGJpazg3?=
 =?us-ascii?Q?ssCklmsI35BnjBxtPC/k9imJbeDsWezJ9Y+JMtNn2gUxwHdW1R4Sq5PjYIT6?=
 =?us-ascii?Q?T2gtwSs1OStXU/92lIDypNzHV7EMK/hvt95XvwOhlfPoEjfQb6yGv9KC1I5i?=
 =?us-ascii?Q?i/iMbOrQFYv9DWqMrA5dHH3yhZWsvCdTpGdskScGjFwmyqg4kZTm3a6s99NT?=
 =?us-ascii?Q?65cmi9HnQpL7e/KEJ4o8uveewRpRXE5LmLtLQAL5PySPSUGwzeX9XR4meBPH?=
 =?us-ascii?Q?2ygZwn5yOTY3mLY4TWvw5q4FexdcTgBqdtvrMlIs?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b3997e-5668-4c49-bb27-08db40f02264
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 16:07:11.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHdlVyJCPRb05oB4ufpPuoCSvNT8GhSmuyCqD7yZ94RAPiq1UIBzalC/P2Lp5pdY9pgM0r3PFDzCz1iqRAoZ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1681
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: qduKFrSvBOnnktKZp220TWZP3IVhIAn2
X-Proofpoint-ORIG-GUID: qduKFrSvBOnnktKZp220TWZP3IVhIAn2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The work queue patch has been submitted and is waiting for some action. -- =
Bob

-----Original Message-----
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>=20
Sent: Wednesday, April 19, 2023 12:52 AM
To: linux-rdma@vger.kernel.org; leonro@nvidia.com; jgg@nvidia.com; zyjzyj20=
00@gmail.com
Cc: linux-kernel@vger.kernel.org; rpearsonhpe@gmail.com; yangx.jy@fujitsu.c=
om; lizhijian@fujitsu.com; Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v4 0/8] On-Demand Paging on SoftRoCE

This patch series implements the On-Demand Paging feature on SoftRoCE(rxe) =
driver, which has been available only in mlx5 driver[1] so far.

The first patch of this series is provided for testing purpose, and it shou=
ld be dropped in the end. It converts triple tasklets to use workqueue in o=
rder to let them sleep during page-fault. Bob Pearson says he will post the=
 patch to do this, and I think we can adopt that. The other patches in this=
 series are, I believe, completed works.

I omitted some contents like the motive behind this series for simplicity.
Please see the cover letter of v3 for more details[2].

[Overview]
When applications register a memory region(MR), RDMA drivers normally pin p=
ages in the MR so that physical addresses are never changed during RDMA com=
munication. This requires the MR to fit in physical memory and inevitably l=
eads to memory pressure. On the other hand, On-Demand Paging
(ODP) allows applications to register MRs without pinning pages. They are p=
aged-in when the driver requires and paged-out when the OS reclaims. As a r=
esult, it is possible to register a large MR that does not fit in physical =
memory without taking up so much physical memory.

[How does ODP work?]
"struct ib_umem_odp" is used to manage pages. It is created for each ODP-en=
abled MR on its registration. This struct holds a pair of arrays
(dma_list/pfn_list) that serve as a driver page table. DMA addresses and PF=
Ns are stored in the driver page table. They are updated on page-in and pag=
e-out, both of which use the common interfaces in the ib_uverbs layer.

Page-in can occur when requester, responder or completer access an MR in or=
der to process RDMA operations. If they find that the pages being accessed =
are not present on physical memory or requisite permissions are not set on =
the pages, they provoke page fault to make the pages present with proper pe=
rmissions and at the same time update the driver page table.
After confirming the presence of the pages, they execute memory access such=
 as read, write or atomic operations.

Page-out is triggered by page reclaim or filesystem events (e.g. metadata u=
pdate of a file that is being used as an MR). When creating an ODP-enabled =
MR, the driver registers an MMU notifier callback. When the kernel issues a=
 page invalidation notification, the callback is provoked to unmap DMA addr=
esses and update the driver page table. After that, the kernel releases the=
 pages.

[Supported operations]
All traditional operations are supported on RC connection. The new Atomic w=
rite[3] and RDMA Flush[4] operations are not included in this patchset. I w=
ill post them later after this patchset is merged. On UD connection, Send, =
Recv, and SRQ-Recv are supported.

[How to test ODP?]
There are only a few resources available for testing. pyverbs testcases in =
rdma-core and perftest[5] are recommendable ones. Other than them, the ibv_=
rc_pingpong command can also used for testing. Note that you may have to bu=
ild perftest from upstream because older versions do not handle ODP capabil=
ities correctly.

The tree is available from github:
https://github.com/daimatsuda/linux/tree/odp_v4
While this series is based on commit f605f26ea196, the tree includes an add=
itional bugfix, which is yet to be merged as of today (Apr 19th, 2023).
https://lore.kernel.org/linux-rdma/20230418090642.1849358-1-matsuda-daisuke=
@fujitsu.com/

[Future work]
My next work is to enable the new Atomic write[3] and RDMA Flush[4] operati=
ons with ODP. After that, I am going to implement the prefetch feature. It =
allows applications to trigger page fault using
ibv_advise_mr(3) to optimize performance. Some existing software like librp=
ma[6] use this feature. Additionally, I think we can also add the implicit =
ODP feature in the future.

[1] [RFC 00/20] On demand paging
https://www.spinics.net/lists/linux-rdma/msg18906.html

[2] [PATCH for-next v3 0/7] On-Demand Paging on SoftRoCE https://lore.kerne=
l.org/lkml/cover.1671772917.git.matsuda-daisuke@fujitsu.com/

[3] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation https://lore.kernel=
.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/

[4] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation https://lore.=
kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/

[5] linux-rdma/perftest: Infiniband Verbs Performance Tests https://github.=
com/linux-rdma/perftest

[6] librpma: Remote Persistent Memory Access Library https://github.com/pme=
m/rpma

v3->v4:
 1) Re-designed functions that access MRs to use the MR xarray.
 2) Rebased onto the latest jgg-for-next tree.

v2->v3:
 1) Removed a patch that changes the common ib_uverbs layer.
 2) Re-implemented patches for conversion to workqueue.
 3) Fixed compile errors (happened when CONFIG_INFINIBAND_ON_DEMAND_PAGING=
=3Dn).
 4) Fixed some functions that returned incorrect errors.
 5) Temporarily disabled ODP for RDMA Flush and Atomic Write.

v1->v2:
 1) Fixed a crash issue reported by Haris Iqbal.
 2) Tried to make lock patters clearer as pointed out by Romanovsky.
 3) Minor clean ups and fixes.

Daisuke Matsuda (8):
  RDMA/rxe: Tentative workqueue implementation
  RDMA/rxe: Always schedule works before accessing user MRs
  RDMA/rxe: Make MR functions accessible from other rxe source code
  RDMA/rxe: Move resp_states definition to rxe_verbs.h
  RDMA/rxe: Add page invalidation support
  RDMA/rxe: Allow registering MRs for On-Demand Paging
  RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
  RDMA/rxe: Add support for the traditional Atomic operations with ODP

 drivers/infiniband/sw/rxe/Makefile    |   2 +
 drivers/infiniband/sw/rxe/rxe.c       |  27 ++-
 drivers/infiniband/sw/rxe/rxe.h       |  37 ---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  49 +++-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  27 +--
 drivers/infiniband/sw/rxe/rxe_odp.c   | 311 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  32 ++-  drivers/infiniband/sw/rxe=
/rxe_task.c  |  84 ++++---
 drivers/infiniband/sw/rxe/rxe_task.h  |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  39 ++++
 13 files changed, 535 insertions(+), 100 deletions(-)  create mode 100644 =
drivers/infiniband/sw/rxe/rxe_odp.c

base-commit: f605f26ea196a3b49bea249330cbd18dba61a33e

--
2.39.1

