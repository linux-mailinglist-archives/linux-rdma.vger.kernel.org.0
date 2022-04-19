Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04983507C5D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357358AbiDSWFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDSWFX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 18:05:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5F3EF39
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 15:02:40 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23JJwAqD003743;
        Tue, 19 Apr 2022 22:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=BBBBP/benFipFqcPHYpu+uWeO9eQanbMpBnR6yQhzdg=;
 b=CxDNttTCk4jqBWaXiTiBTm4brsMkOXnTwKIrmdmOPYF9DIowgN4+RBZvmbwqiQ5Ar8B8
 IzF1YnUFZH07MywOt1KOTJoaa383P3wX+/WnPJapJPYVHTSUMaHWAb43AsCFXF0Ve1Y9
 likZHJgTcLvBymN2fjHsBuDqJe52yIh+1UqsMCPzhYodpEsfKjxeFClrmSfF296p1qvA
 oQUh99pgEAub7VLHRTKus9SvoRHz5xGjAL7Bc3/Ar7vwwaDjJxUinzfvPgb8+8LWU/bZ
 0OhSxyzvUWWHVsvkfeLR7wDqkTh00vSWqzFLG9fxpHVU7woPZ/igwFm85tmK+Jp/eL9h Fw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fj3pt8y5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 22:02:29 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D3D2D1317B;
        Tue, 19 Apr 2022 22:02:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 19 Apr 2022 10:02:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 19 Apr 2022 10:02:02 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 19 Apr 2022 10:02:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giqfISn+JMxljmDqoB6CqIPMyu7UCOxoqsCcyFHQkH3ygwUaQRNuZKhBEaJxtcPfWU/J5o4moWWKXYqXV+ikYjl1wrZUWE9Ci8u4JomOCnAYBwLz1bUvN4Q1LIMudhzGmK2swdj1roIq0pVkSw7w1yM8AUOSIWcNtnLnXfhiYx0se9RYvZXUNIjbDcS/cpOI/SWwcle6RTOC6bWjag6RfufwsJ6DmlIDei35/XYqyGGbQrNsN+lKa+Y+NJ46Pla4k6J7e6ymTfT26X2R8LScUcAVxmJhpKWvNIHWEX98m+Y6usegY6Lz7x+oDbWEAVZt7SEhfpYQ787PZe2gWP+4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBBBP/benFipFqcPHYpu+uWeO9eQanbMpBnR6yQhzdg=;
 b=PSfO0GNSgwlXboS5VtZN7V4nSsnfaXqWUe1dONgdvP9Zb5WDNsSPvbTqRUD7AA3dna8SUXT9d2BrHcth/3BO+pRZdEiryx8viujiLJmb/AZeOAwYB7XbauulzxAcdRQKLRyQS8pF3RnlwSjGp0Tax3MRPlPwZUbLlEERtoE7NDUsog/E7TL1EpQcermdq3SIAtxf7+kz1PJaTds9yXTWURu9QBME5LFir3sRkScNJEafcpufXlGvRu5UVW1LjoCu7y6oO+iybQ9VgCo12FK0tN53Sp0Ht7RH3VsKMrGlepB48cMMFzHbb2gPx5uwY61/yFWeP0rt3QTbVA4CD653yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1372.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:02:01 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 22:02:01 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Thread-Index: AQHYU0vE3lZ2myKE6UWSR2QzXLf97Kz3a4GAgABeI2A=
Date:   Tue, 19 Apr 2022 22:02:01 +0000
Message-ID: <MW4PR84MB2307A74EBAA10355B50A3C83BCF29@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220418174103.3040-1-rpearsonhpe@gmail.com>
 <20220419161805.GA1245827@nvidia.com>
In-Reply-To: <20220419161805.GA1245827@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3d78f5-0c1b-4840-4d79-08da22503b38
x-ms-traffictypediagnostic: MW4PR84MB1372:EE_
x-microsoft-antispam-prvs: <MW4PR84MB13726CF75E83FF1A5F4CDA86BCF29@MW4PR84MB1372.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QlL14w3Zxi6ICrrD8tivMnOAIE3OJgz0hlNqp8dJelWu2GyVgjwDjryzRFTMd8TEIS419H9e6yM5qFRUGEDAARE/FpE7691+WXqpfXrEAdNN5ZF3IEYPIvEWPYW4gGZh5W9dZ+J+YiD2fZBS+BXWcXZ+mm68HAqDLyRv8fH3LKr74j+MTl+WfWcIQ3tNaZEJd3v14ZoZ5gBdKTcw3iFz/Kw43WJBRdnfqcOHsEgcgZMpKS/drwQSVeZfxJJ5SvfnZAqA1CzXGC9EXTwX/ccXidf6A9MN0x9X7uDRSZUHKPEEoghlG8GsL20BtgdcAkqhInJ/38I5mOjDwHMauEtCgPDyXJcx3Qx3tMqDGglbI/tFMVHrLa3LfJrcrQm8jNjhKqcngLI2dPdlebQKXHvvWAKZvgYVeu0saY3Zmdh2y3NbDjjbEWuH0JTGO0gzbSDpVRINqYKEWiLrmIpMu5qM1SMAonuc/B1M9pblJB2z2rQcX4ljWoD9gMIbQEhso+6EbETKkNnsNP8c5RBkYAjd8AIjTwv7FtVU4+MDX3kynhiYlQxPgurCd3xnTApSeHNbezyVc5y/ySCidnQCYf5fZxdMnQtIOJR6j02xQP7+0tEFYmJ2dwMkMEFG0e94O3ImS8O4BXCztbEXkqv0YMUYL19zdoxjTGOpadIAi7E9EzxjxINGO0ssZBMxEu1bJX7QLD4vnUreigoz1/bs5h0/xlfKgNlDkZCAIzqtQDxObNTs+ASBDiObEAMttmkDkHJDSH9gKz+O4vJ+LzqgHHatVyrUFS/R09CXkcYEbUgXuWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(508600001)(66446008)(4326008)(64756008)(66476007)(66556008)(8676002)(52536014)(110136005)(54906003)(5660300002)(2906002)(122000001)(7696005)(55236004)(9686003)(8936002)(6506007)(71200400001)(66946007)(76116006)(38100700002)(966005)(86362001)(82960400001)(316002)(38070700005)(55016003)(4744005)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tnTycqbtcAyl3yHT88bBY91B59xABnlCjd96v2pqT/FOhDc4n8SbBk8wWxTo?=
 =?us-ascii?Q?6Cnv92MCMkI6Y4kTLPQWtsBlNm0rf1nEVoSQ6oA106KT0tXAm2i1k7gxbyed?=
 =?us-ascii?Q?SwlSKeM2vVLTIpX90R7YGphvlpTFXB434k+F03pIxuBzmDi+cWLe3mhOgB3F?=
 =?us-ascii?Q?r8mXzOx1XmtGn23COnQ5SkeiOFAmvjCNz1qIAQDPkjgn0eNV5W/3znhQMQBA?=
 =?us-ascii?Q?ow43k43f/FGjCLhaeCHZCoVKIgAfeZXBBighDKcJSPPZeJS3blOO7DGSWy7s?=
 =?us-ascii?Q?Rc8lNuJeyqpg7RLjq/wbcMu5LjJtOqQOmoM0xcYXMzaGli31PgcHdL0wSNKc?=
 =?us-ascii?Q?BtcytadkN53odvj13dYcNQ6knDORH7fUHlPeAIkHVt1qf46YKpGScr/LBxFk?=
 =?us-ascii?Q?tB137R6GqFrafzFrdqrgTZ+egIApxxArqi4LC2v4b9g1bMU854M58dVF2k38?=
 =?us-ascii?Q?ZVF27BALuSU2VbrjygwWOvoWZ39hexP1dkDhPIzVIroQCiwuh4/SwxJcGM0T?=
 =?us-ascii?Q?mM4t0ujTSw48Zt2qiLDd9qzO/kczHbTRX7LSDHe7ZqU0qV3W2JFQcBXNdtV8?=
 =?us-ascii?Q?hSpSCTKvM5o+3AN7kVE2JEk/Ht81KHHKBRIb+1g2071FqHdD+P24IgRXmo+O?=
 =?us-ascii?Q?0JFiYxgJYsxeDZ66c8KmejjQ2G20mVdVSOhgfvLdISi11ApCv2XX2lV0+661?=
 =?us-ascii?Q?tDBTDiqNk1toqvzlDDAIbHjgzGj79PeBAU+qzXWa2rYw1DGqrjytbXZq+WdF?=
 =?us-ascii?Q?pGPR/hHwP0UMU05NIfMF7Ph3tbVTpJE1gJUm8fsLxBXaVUqnyohNxN5dpANo?=
 =?us-ascii?Q?i/PugEc34pvvbUNo7qscACx2dHWn8HNrQumOYwJMHx5WEH9he816QzzZ49Q4?=
 =?us-ascii?Q?bK1pxhFAdcasR3VPQbop4abaIQQRl0IM/XNsFELSpoOu4w+jP8+0aQdoVDDf?=
 =?us-ascii?Q?T5Oer2BH2yd7jifagZUq3+Ykv7BGBxpLvGDu5BGBtUri6RRwJPcn4IPWhj0p?=
 =?us-ascii?Q?V5rR17do5zsNl3t8cq7ULOc8UQsjLcJlOdWBzf4+vmpeAvNw37sGvJhQKjR8?=
 =?us-ascii?Q?cc6C04bkSYxt5mPuq9qu9j1quy+g9T9ybJ2j2uTK+LgkWP5gYG7b67p7Od5/?=
 =?us-ascii?Q?cJLiBx5z9a36ZdlrGL5bEJBXBpOu6XqNsUgjM4H88wk41UUiM4qUlhnMszWC?=
 =?us-ascii?Q?/M9lvJ2GfWZRAASngY6kMCXdfXsEVw5fxpAsFx1Icy+lTeOUfCOQx42YNU0Q?=
 =?us-ascii?Q?RPcNp56md/8MT8h3piJsvyo0a3Z5H0SpzdMEZrqttazqcXFZW70G2MdgpeME?=
 =?us-ascii?Q?oolXTrhoFhMpLlRY58MFxC4ULm7DvJz0oaEyz2JygXtJ+lu9Nwf1nLBpNOO8?=
 =?us-ascii?Q?ozZt7EeyRBO1yLE89l652S5ptRjgTQr3xTw4Ixq02EVDshNI945L2mtAsG10?=
 =?us-ascii?Q?6rEXr1TLbAGr5TIKT6F7zHH5eGYW6QJxWnchlcn1BNmtJ0Jq9E3XtjF9Z2wK?=
 =?us-ascii?Q?xAbXEDjEO9/wPAuiCm05Ockm6azRq808Ob+3GccsIKaPubkwYgwyFoRdXP4h?=
 =?us-ascii?Q?rgg1G+6hW31p2ZixOFTFVAZicqXD5qQqve8EUfVvK5+c32QDWZ/yCctlIp1g?=
 =?us-ascii?Q?aW8qHjMEJyuQEDsCBPRVwNkcEO4vA2xwXv/NddPye6oknUkFzpTKm0FiMG0q?=
 =?us-ascii?Q?SDLe/vdkC0L//4kxJgVNrK6kS35cqwxgruUrK1IFbGPMHfGP5Wpd2PtmAS0E?=
 =?us-ascii?Q?S/zT2F+/yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3d78f5-0c1b-4840-4d79-08da22503b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 22:02:01.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvQFO+UqTNQFJsU7nrRsm/l89gKbaB/w2fepgqWoqgoNADufWohovtcOR2t2FCFDHNl2A4m60yCT9/+G8H9ubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1372
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: s-ezmOINGMyRHlDvPiNh2hUa3m9IxTbe
X-Proofpoint-ORIG-GUID: s-ezmOINGMyRHlDvPiNh2hUa3m9IxTbe
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=694 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190122
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> I'm confused, does this one replace this patch:
> https://lore.kernel.org/all/20220411030647.20011-1-rpearsonhpe@gmail.com/
> ?
> It has the same title but is completely different
> Jason

This is a new bug. It needs a better title. Is the old one still hanging ar=
ound or was it accepted upstream?
We could call this "Fix read_reply in rxe_resp.c" or anything else that wor=
ks for you.
