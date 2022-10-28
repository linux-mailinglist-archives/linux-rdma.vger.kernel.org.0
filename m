Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3B611AE3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 21:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ1TaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ1TaI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 15:30:08 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B257538D
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 12:30:04 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIw2OA008585;
        Fri, 28 Oct 2022 19:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=iDZgkmRSqmSeFRfVRIvGtHz4Y3vdsMNOQUYNPc2lMBY=;
 b=MCoAISXio3zVzGnHRlL5fC+dVlz39uPmmnQhsUGMaSDRL/c5cHGDSa4X1/PXjsx9BSAg
 yrpX6QIdkm/VhKSTEJKbJl+xcadnzDK0kMijsDbWD5cz7zkiNjrZ4VrxLpVoXkJoHH6i
 gboN44W9JnFYLJm9mGz+mG7wv6vjaZItqE3QJRouVOG0k/+hGSG/0H+SIcnM1YHke5JU
 /pwHPkRL5GFS57tnKWrC6YL3+CF/zFmvr/vSAj2mzb0/wCHijO8id25P2ZhIVAiDKAj2
 5BiYqR0ZvnokM0jbY5vai/YMIJD7CcbAwDgLtYBM9AJVqXX5r9OplwutGp4SGyhuubbf IA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kgmtsg7dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 19:29:52 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0EBCAD256;
        Fri, 28 Oct 2022 19:29:52 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Oct 2022 07:29:51 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 28 Oct 2022 07:29:51 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 28 Oct 2022 19:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk8ctaD6PxSLoYH1T5QxVh3iEVJ3YNIhyJPpZgHU2/3ZZOk98wsrDdPae0Urh0bLP38Sr6W3rMqSn1bY01RG/iyCaHtGxeGZk3qQSsrq4+w8NwjpvnU6fbcFbj2Kana3Azl4xN2dzMz19wU93R+NwLfvq42T5pNmrrbJyQesDLf5kzM8Q1K+rlR9JBmXRYISr8uv6G6Erb9lWgy4ZCxac+Mxk/7cqJobQhBPjXNQuo1L1kONWT17ANTvvtR+sCbyyribWDXxOaZkWAlUyKydy09uas8E57+wFDT47Oroy209sHuvkFA1On7sXM0pCTGcSx21FvE5jJKrKocZqBN7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDZgkmRSqmSeFRfVRIvGtHz4Y3vdsMNOQUYNPc2lMBY=;
 b=XSXcfeVYoruYdz4fNYEYUAz5J60+MN97CHuII47qudnQW2cuQ1kY38U3/K1V2H+jlRpVpu0sg2uE1/AesrGDjzUjQqoEG5p4Topivpl/RyPH2FkZD9L9mcYjl4ywFhoIKK419R7Gh8/NslEMEr4m6lNmkVVw1Y1ZDxU4go5NGQwHXMexb87QcJWnE7zP1M7e//AExIF/Q8lLOa60Adc/4Mx9kHlU9vYO5mGSXeRYWwWOiCM90MUZNtdESP/VXo2dj1QjHZiJQilEfqSrzkg8O8iVCRB3pN8nKT1Wt8vOdlTOlKRwvVSxehkJkPU+ra9WmrlXcBtp6W4v6MqEkpZR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by PH0PR84MB1696.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 19:29:50 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::89fe:b7a3:29b:fb31]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::89fe:b7a3:29b:fb31%8]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:29:49 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        "Ziemba, Ian" <ian.ziemba@hpe.com>,
        "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 00/18] Implement work queues for rdma_rxe
Thread-Topic: [PATCH v2 00/18] Implement work queues for rdma_rxe
Thread-Index: AQHY5YhA9RXG4a5j70StiKcw7ka/X64kE4iAgAAUHoCAAABygIAAC0YAgAAFFACAAAOGsA==
Date:   Fri, 28 Oct 2022 19:29:49 +0000
Message-ID: <MW4PR84MB230728EACC609D41D4DDD475BC329@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <Y1wLi5lFAGeeS9T3@nvidia.com>
 <6696eff3-2558-6aba-2d62-47b9d4b73fc6@gmail.com>
 <Y1wcyzvH5gMNxpaZ@nvidia.com>
 <83d14def-32e3-41b6-31c6-786dc5059eea@gmail.com>
 <Y1wqglqKKz2oVgcM@nvidia.com>
In-Reply-To: <Y1wqglqKKz2oVgcM@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|PH0PR84MB1696:EE_
x-ms-office365-filtering-correlation-id: 9ed0cac9-de2e-4bbe-4168-08dab91ac75c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGCeJWOIWIPM7HLUX3BwFw/jcsk5zHjJk3oo+NIMQdzsCMJVE+10xdHq8GIhs/jZciZtDOMNZI11ErAd1Orf9A0V1mKLBb0gr/kn2XM/73nx0ticKcuIdgkTeDd+JlQwxCUiFDo7G6qqf1cxx7Dh5z5Od53dDq+8FLd7ePp5Bat0F4y1gB5uYpR5SSbsVWBrdzcg94uWl5pxPS06MWdh8wtOIx6JqaCxYILLVcg+BNxlRoTeo6T/uq1v1uQUsXfat+LOgC2Dj3vKzqKmRBiCUcy5SPfh64bzbKjUmFc2Tg2PczAn/2im6snFztKq8jW0kaj5EUz1WJWOl1cQQdYSIMolkEZLvCudkPsZTd7EwpyyWZODckS3sRqu2GYoVI1KHeoKfGHI8uGH7jPHzylE3CbiBnL/d28v3kMUUr9JJ4XFGsKkt24ZU5avLz9kyOqxfc+jZMk/roS1yCtBhwAhxD7s44hhYSX7fol49AHCsDrqJ1+HBJCCY9zwCcxJcaN0aQ96w0vxwcScni8ZBPSZa4ghMItLRAZEsN73Qp0cOiZh8ztn0mGQMeB0oz+aYNEDrUAdjU34a+Nh9lk25RnOEez6nI9lBu4FB+c6kTSgkQClUR4+aLhNhtL256Q52sUTc+5DwYcbeoL5hlmxflc9RbyMQhzF5ud2v27RTgpllrHPNiZUBbRcsiLjPohXFp6kdRrM+0vK1wtM8MEraCH2WgxRzNN3AZsu9ZUrTHi9OlwSBJztX6bUMgYWmj050H01ZeJLugMN7ebvy6z2zI7i4puAXXPS6UPwJd5w21/oaLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(66476007)(66946007)(41300700001)(76116006)(66556008)(64756008)(4326008)(7696005)(122000001)(8676002)(53546011)(38070700005)(6506007)(316002)(66446008)(54906003)(110136005)(38100700002)(52536014)(86362001)(55016003)(83380400001)(2906002)(186003)(5660300002)(9686003)(8936002)(26005)(71200400001)(33656002)(966005)(82960400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K1s0s6GRZZBl63Mf29kX8hYDC+UTBL5XzhpNu7VCkF+R+7lcS6478s9Nprdz?=
 =?us-ascii?Q?/v2MBN7Z59pWSSjQ+HIdvy3G5pNDuX3srd20vV3XxJnO70yEG1Acv+lIw9MM?=
 =?us-ascii?Q?aikJpefzvclFidbnISZG11X1pQ/C3ylRRQ6XQtfsYV679Luu/zxkQK8hRC6s?=
 =?us-ascii?Q?3KkT0jOHsUyMJZME8UNYFmUyYnvWrEgaAs5VOVAgyKNjnfKmZBdHc9lBLQ++?=
 =?us-ascii?Q?vPgwuRet2rqECizJPdteMEqmRAoiBpljvZxscG6J8M5lNqtH3yBaJYSygwL4?=
 =?us-ascii?Q?cgWnITpiXQwuElw/7DrOBk0zUYE0wzoRWN+rBsu8vXzAQqwtWh6z1RTSgj2Y?=
 =?us-ascii?Q?BWYGTUfUQFxFu4EY5PTYt8ZonLKrTTK5dqMon4FhReIoAzrOXsLfMOiXKcYk?=
 =?us-ascii?Q?CRzLldDr+d5I5WwtpB9tAtxwWhujO2Smiz3NiD5ncwHLdH2gXjFV61XdMGCW?=
 =?us-ascii?Q?199YU4YBhBiqzSd2PkYyA6xU2qPhnPE5KMMT3QlogPHn7C7l5ELJpHAJJ8jF?=
 =?us-ascii?Q?MrLHy/k/KWLnkYsi50IPYsRK5Q6dS8qLNXSCZ8tIHcLqlrMTqS1+xDzevk9x?=
 =?us-ascii?Q?z7cBOzzY1jBpSQmJOJy77SvfXqHjAxanYj7eYJxyR0ZcVqhHXRb6KgnhEOo5?=
 =?us-ascii?Q?FG2z95Y7ndQjtUhdlt5mdAZGwFKcZtzg+R4PmNQhWxnUIEmSjdAAdOHUB6KM?=
 =?us-ascii?Q?dPxiB76FlDmkVIPcl+RUgvFh3kbqx4+v6mNiUYOsyc13Vv+K8MDkzxfExoMq?=
 =?us-ascii?Q?ioP3vZIh0kV0wpsc44FYxrlti8sWreIwxZtelPZ2aEbO56VDNtHok4ji4UKj?=
 =?us-ascii?Q?Hi5A5GyhDvkIPo6VewKVvPzTX3WBl3UgM6tgwqihoQFzDRCzqxEaOqutIMXs?=
 =?us-ascii?Q?mscJNDZzUmhS8G3fRWulc/qqpxBAn8VEuTEz9/3RQ/Qi67Cb7PKwG6t11Wlt?=
 =?us-ascii?Q?/XVqhWSSe8UBVDlV8WLdauJsbFDlw7xRC7YVa3OZYEPuplHUrEDiJhLQE0lt?=
 =?us-ascii?Q?4MKOBd5JE1nFqtjDc3M8xmkfvaZxLHe4PA7T1MB9ntdWdB8hGE4gJA6SNeuX?=
 =?us-ascii?Q?5/fArxgxofNs0Svptle4ZeyBSo867qtTvjVVFw4rWUW+sjTP7+ynBnFvuth2?=
 =?us-ascii?Q?RW2SdRrONPHLacwvWiqbUHPYg43VQ5iQPjvSHZ7g0tcvxaeHLzpNNthdDUPk?=
 =?us-ascii?Q?HC1bARD7Amtv54NWWXp2pFh5tYxatOmZaW3e72030Kz4JDptXimDYw0nXWA7?=
 =?us-ascii?Q?MmxTczAC9tNQaFP7RsRz5QbeQAOzfNSk64RQQbLjvWOwOq13S6sQ5R6KQ+HI?=
 =?us-ascii?Q?25HtgTYAKLkQJFNn/mjGG3WhNgHa4wgeJVmYr+QTi3wjIDAXFWBMFsYWwZ6/?=
 =?us-ascii?Q?e6NoGqWN8n6l3DGte958a9dQMAlhQdYSCbvhHdtKZwGyVbwBUVuhwXaYhy5Y?=
 =?us-ascii?Q?sh3d8CQ8U+9YCaceNlljYMwC/LsFiq0y1kS0Zr2g8/i7EnFOTURiSc00ObU8?=
 =?us-ascii?Q?isNvQyYGdkbCKbRn31/OTBNHxWFuZn6Oc0a4FtsLsWk/DWIUEpdaGfGkeOYP?=
 =?us-ascii?Q?5+31IsKt6hsu/r4UtrexUhvJ8YSzDxuGpScuzp9J?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed0cac9-de2e-4bbe-4168-08dab91ac75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:29:49.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJjBfjR1WM6LD98bbtq+Kob8KZUTYLuqbqh2idb8V9w7ql2K7lWuQZmsFcax2pefqLAzVQLpD+k+WQCF/2a2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1696
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: wzxbxZuE4dO2Ve1J_wvueT6oZ5fbrgoC
X-Proofpoint-ORIG-GUID: wzxbxZuE4dO2Ve1J_wvueT6oZ5fbrgoC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=972 spamscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280122
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Yes. I saw that. I missed the 0-day connection. Yes I'll add the 'static' d=
eclaration.

Bob

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Friday, October 28, 2022 2:16 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; leon@kernel.org; Hack, Jenny (Ft. Collins) <jhack=
@hpe.com>; Ziemba, Ian <ian.ziemba@hpe.com>; matsuda-daisuke@fujitsu.com; l=
izhijian@fujitsu.com; haris.phnx@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe

On Fri, Oct 28, 2022 at 01:58:08PM -0500, Bob Pearson wrote:
> On 10/28/22 13:17, Jason Gunthorpe wrote:
> > On Fri, Oct 28, 2022 at 01:16:11PM -0500, Bob Pearson wrote:
> >> On 10/28/22 12:04, Jason Gunthorpe wrote:
> >>>> Bob Pearson (18):
> >>>>   RDMA/rxe: Remove redundant header files
> >>>>   RDMA/rxe: Remove init of task locks from rxe_qp.c
> >>>>   RDMA/rxe: Removed unused name from rxe_task struct
> >>>>   RDMA/rxe: Split rxe_run_task() into two subroutines
> >>>>   RDMA/rxe: Make rxe_do_task static
> >>>
> >>> I took these patches into for-next, the rest will need reposting=20
> >>> to address the 0-day and decide if we should strip out the work=20
> >>> queue entirely
> >>>
> >>> Jason
> >>
> >> I'm guessing you meant tasklet??
> >=20
> > yes
> >=20
> > Jason
>=20
> What do you mean by 0-day?? Sounds like a cpu bug we used to talk=20
> about. But not sure what it has to do with work queue patches.

https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/

Jason
