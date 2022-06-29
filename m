Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1456094A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiF2Sk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2Sk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 14:40:26 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C6B29810
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:40:26 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TI2FnK000872;
        Wed, 29 Jun 2022 18:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=JYiTGa+T0aUorIvkcOWbMhwQjujM7TJbOq2sB6JSouc=;
 b=Up6Lg5rPCUrhTA5cqXToHIZYQCKrG/JAVb6BDCXdRrEEdfOLyjLSq08t+CYpbOaQuVDQ
 YEnbq7+4zETk5hnzhexr/mVjshHvAjdUwvzVb/F00e5tekFIlceohrb+el6KqI2ecEaZ
 72HQqGoMOPlpBDQF0n9EfVyzYyDTn613B4fOeY0EaKWbPNbHXkCevIkMQEe4+UmNR6zL
 SGPXm4ytEzUQEecrrw8dbNq85iZEDPBlmdnvWivWqSy5mWpqEQJKOMsv88uWC+Co4W3S
 ACSMwwpzyC6jEM0abjSODrOEyk/cKpGryaGN16Y4q9s1BWu4xKBG+5ePjR4AOtbHWnMX /w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3h0u1f8sxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 18:40:13 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 04E2B12B44;
        Wed, 29 Jun 2022 18:40:12 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 06:40:09 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 06:40:09 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 29 Jun 2022 06:40:09 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 06:40:08 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oyh1dvfpgXKZkiXMxDy1Jqlmso2Aszkhp8uHQu+W77uJvttfeoxm9ylMKw+gqIBXPhdGB6GGaQliJlnHUNQKgz6N0ehF8QNRDDNjYZePcZLoUbZ3OBLk4hvxkxNTAqDybskAgOwmbdcvKU+911UyF0id8TMI+MmD90A62YOaPrpPuiq0Uipg8LYt67rZgawfo8hx524WFV17GVjPKBkKzqOCfWmRBXGRVL5kQ0JPPkXlyRjGbNzJGtVkckvCwGS8Oszlv1MTp97/MnZaU95CdXOxyJyaeJt5I1II8Rwr6JTBJeHsrYjra0VUrx4qPyUOsyJf+UdyEGXD7Zx2SxOchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYiTGa+T0aUorIvkcOWbMhwQjujM7TJbOq2sB6JSouc=;
 b=TB+iDcWJfokOFfG9Tz36mrsoraWAo0ZDI8K226jiVda3teUJ/jjGHZWaX5nWpuubYeQ0zrbZv//yGua2pqh9AUuPmmnd2gRl/RMhSW0wVrPXsEegau6dtsy4CVGuNFU2p7Iiws61fErHi92IZg628+UKUofxH9bndMYL0BDx8SYQ49u0K2xRHtCBS2955UENUDOiaRCa7prXM0iPFRcCW3laAsyclyRImEJYZ7gss8ejiZO23UcL2qHHrQQQGjq3g2m87Gk2c7jCmc45T1TYcb+JVaYGW2A16fvUArxJKJH6BwWtWL0TtN9VEHOggavkZZA3xFH2GxhYl+Vu8I1zEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1543.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:40:07 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 18:40:07 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Md Haris Iqbal <haris.phnx@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR
 access
Thread-Topic: [PATCH] RDMA/rxe: For invalidate compare keys according to the
 MR access
Thread-Index: AQHYi9iAxovqsOAg+0izN/pZoerKUa1mth2AgAAAztA=
Date:   Wed, 29 Jun 2022 18:40:07 +0000
Message-ID: <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
 <20220629183445.GV23621@ziepe.ca>
In-Reply-To: <20220629183445.GV23621@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34c96aa5-4e4f-4457-d3a8-08da59feca1e
x-ms-traffictypediagnostic: DM4PR84MB1543:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NsgzN//U+KHnc3JC0+NeBv4dX2cUfNh6v18D0LOpoJsshcRPnruKAWcMWyu+hoZgz/8mhv2Y1GZkR6+xqEs03XYiyiCNVr1iDet4V5xWW6yT3+rkSDDWciUvg1Yvkd6AfICobVGrFUFfd2EBZgeNWukbuIP69YUDFBQJKt1n2YXsgrbgub72LAaZZ9k56Ck/jJAw8nd6TWKCLbfwrlENJA4an2EWZH3veLMzXCCw4aQpmOiRFD3wD11reILXJxRrILrfr5NPvTH07K+jEkysdn1Qbn3c8+/S8QpUzqoz/dLegdFONys2pDpUIP4v3TBOkTeScdWOSsRZ6NoXa5ArRNqU8GmQe7TuV2n/3pE/BA0tNsFT7XCkVxI0Ssh0ec5eEj0+NqUN5g+B8+orpkVeEqAGqRXa8VTb2YmmJlzw33K71Rq1qq9zftiwT7ef/AqIYc0ZMcFAYM1qWOpffbZG4OaiSXArWSgSGRS9D6NmE8mq2YcFTdTYPqnOmiYAYe38dEZ5yxgbXmJQLqlbCjLMWGjdsy8hMuqWgaRJYjN3HTwLPA9jndF4Eno71DpJZCpsAarrstTx/dQO0i1vYavZeWyb3xEukluErntsQWbjbGvl5UAiN3rYd+dnr1MRrXt3kXsdvbhltz/IrGafCPT4W3PXWuIR9Ja1o7p5pYEfIrLRCHGTuh4nYTZfh5zIBa0XQQtkyJ5mhNjLCwevkH75BQAQLZVkV3duKN4K1x5BQnSfOZbI+Ju4j3T74oWWVndJd57cJt8rpo11bsgpJOuaX+chomy7dSC8aoThusa1h4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(346002)(136003)(52536014)(6506007)(478600001)(4744005)(26005)(8936002)(33656002)(9686003)(66946007)(41300700001)(2906002)(86362001)(7696005)(5660300002)(82960400001)(66446008)(38100700002)(122000001)(38070700005)(186003)(71200400001)(83380400001)(66476007)(4326008)(8676002)(64756008)(316002)(55016003)(110136005)(54906003)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pzhlGA9qLdCba7dPEx3Ul5xhPpAGvgcHVsK0wYVwLri8df2IunAzNqysk5lH?=
 =?us-ascii?Q?5z6MUg/MaxG5Jw7mQMM/3Rpl2T/aEp5mVIGs6eWe3EcQooWR7WTsWLCr6LpN?=
 =?us-ascii?Q?HPfbp9SeemYJFP3NIE5HIj0WNp9lXnh7IyWDt/hbUHHLJxKj5q4e1K7/RKPe?=
 =?us-ascii?Q?PeKaY+R9z9FsPcctNM26BM7WIWKia+sjhuiDMdFElj4LS1CMyCH2CwrKzBJQ?=
 =?us-ascii?Q?YP1M8F+WKOy4N29rorBx/3kEV3rWkbC4lz1Z1vmMIUc8l1sRNx+c1xmPSnT1?=
 =?us-ascii?Q?Y4YCMOY8vZUjnrm/8gM4PWxTmcS+mCg4bJSsdC/pWHtMgccQPLF6CMeqGQWd?=
 =?us-ascii?Q?8E18600fR1/Z2M16KxG/Jy7YIfY13yYXyr8slZVwfqFTI21tMPdZMcuH7d4a?=
 =?us-ascii?Q?HMT9dUcmmBM3Piyd1mHVu00I1lIo0+2j605iqSothlv+ThsoPNVu5N7VdJLr?=
 =?us-ascii?Q?nXtYnEB50YTH30dNdKqSW31VydtmOj7OKh6tIPeCO9dAmtQiixbVV/BtBN9L?=
 =?us-ascii?Q?aBAvg3S7hPD8pACKJeI2z061Z/Lbtuqzi3IkzAYgrSqnE8iuz5BQbX1eGLB8?=
 =?us-ascii?Q?pHwD31ZoO7JroY0NT46bVarZvuuftHcTBlJQn2KIolKBtNsj9RUX1OWc34D3?=
 =?us-ascii?Q?YSbdFKBDiDtkWMaq7PMcwPXa8twsmuaDNWdU18uj3LIj1Ztb8BXDXkU5CaSR?=
 =?us-ascii?Q?o1ZmIh+Sje/gOM+IMya4eoN27kJBoM5QX85oczHP2VAaUXdQXfZAUGacN9k7?=
 =?us-ascii?Q?QwMcvFi6lLYRiqFo3HTXE1VL+3TP5KF4+YIGaW/HtRAKbvemDeoGzF2qP4J4?=
 =?us-ascii?Q?besCFSV11g261xgAbI08Tnd79cG6LebrSzIgnFpxK+P8UvQk9PUkd0jjj7h1?=
 =?us-ascii?Q?FA2mKPRJfJOMwv1uX7IypG0LdWAAoKUlNVkAQSdbGgFwWi4GA2o7d/SUJcrs?=
 =?us-ascii?Q?JC+n0b8DTF8HqW215cm+rh3+iNdXmK296AJU7vHJUkiPithwIPMIfARAqApH?=
 =?us-ascii?Q?JlkaDB6C/2IaRDgLAuuwX+jSPIXI9qVx5xYUORJ6PkTkrcE8kdLjPwhv/UTd?=
 =?us-ascii?Q?Z++d5pkxROwCX4MzrPno1iTqnhWiyJntRRSkFFnpxJGamVwZZzfIIcytQjEd?=
 =?us-ascii?Q?thD9jDe9zTUoayCBPODU+edYFnRJBxVCHjYrTjU1VHBR489gfFAYkdPij9tb?=
 =?us-ascii?Q?4crTLW65OoAsJY9xN2CzYklpDx6chhWH/y9rCHW0GKa4i2rxzJFKo1JuFX1q?=
 =?us-ascii?Q?cP5X947x6SEGRHUo2/VMUvkqMK1B4gobam2S1FKbpAqF5UdN1yPvjCAKKy1T?=
 =?us-ascii?Q?33R1tBQB+KRHQmcKUSsP7MKHhVxLSNVmvAJEvou+f6EyIydoaJUDXvh+M2wp?=
 =?us-ascii?Q?iHvB4dxzRjKIZel+wAJKkJh9XKemvPFn2jmRt11emGfIt65MidiXpLbKXjQd?=
 =?us-ascii?Q?QL09r2XWqLKJ9TvwSD8EOFSXijutQna/I9XD4zysOpnBr/8HxsbV7ICBy11n?=
 =?us-ascii?Q?ZFkwH7OZ959/K28irMrVc0tp/jwUSyDxB0TWK2zYXUPFJIl7D+fgYzCtBe53?=
 =?us-ascii?Q?gbF6HwqF3eAEjkoE+QsQ4R82VGlqAL6JtXA7jCuG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c96aa5-4e4f-4457-d3a8-08da59feca1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 18:40:07.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/CuxTxR6bA8oQ/PTQ0av25q6RznVTz6Uemn88AB8qMKqGmrwITHwtluuBIQPBFhhRkbCozwJI9967khbVd7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1543
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: ajU2H60lR2oixkmXmE_rJWBX5vcPv310
X-Proofpoint-ORIG-GUID: ajU2H60lR2oixkmXmE_rJWBX5vcPv310
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_19,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=679
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290066
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> If the rkey's and lkeys are always the same why do we store them twice in=
 the mr ?

They are not always the same currently. If you request remote access they a=
re the same if you don't rkey is set to zero.
You could, of course, check both the keys and the access bits but that is n=
ot the way it is written currently.

Bob


