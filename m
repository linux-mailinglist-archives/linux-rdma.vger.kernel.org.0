Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845363F8CF6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbhHZR1G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 13:27:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34826 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243171AbhHZR1F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 13:27:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QExipR010695;
        Thu, 26 Aug 2021 17:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e4ImqamVhFW128tRLKbjAqcHH5TSsDF0gRGwwsewHnM=;
 b=JCncyaWQvghn8q3a9wngIPDR6ErqaFccXgqYhp9Vgi6GyruUMnWzCVUtZ210OCCtJIJz
 t52oo54xEppzb/SdynOL1OJgPTeo8jofq9CJi0pzSVG+yLdgxtj0+9ilTf4F1oMtJjk2
 Wg/ZzJX8q0gyKhR6rDMHrsgwR1T+85p4y971H0JAEWTfx3txtDVOAQlyoHtYe+26j799
 Ja1RbL4WzyMIbQMA/PgdI7g/XdR9gdIyYGbnGvzFITukQBDFfW0jfPUzxno5MnbnNrYW
 9m7EJ/QCV2SseYKDN6ntLv/56Kik10dxJ2i03oXHEOBjWEIP2HPfMbO2HJcAXedA/F/R sA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=e4ImqamVhFW128tRLKbjAqcHH5TSsDF0gRGwwsewHnM=;
 b=PshdGymD53rutpy7lK+UVQF2THMFM8e9mZ+N1teTmN80f3mYe0XYYCu3+8cGMHagUYI2
 gDF6XMkwoJ0jRAyK07dwTa94VI8etpTdfLi2NKLL1eMqzgKe+VZ5tqKB41IfQPHPnwJ/
 RZz0P1tunTOrKpVFjF0GleLXH3J6IA/KUj7TqLHKuHJyRPZ40b9GL0GgV/TwkgOcEJ2l
 vB4JA5zTPhkjt6hdNf1rj1tuGA01yJQ2Pj8dtoVSPYDGeS1AZsCKp63AZe2oQLA6lAdo
 JJ+B/w3+z8sfewucfWSjylYxOsWWrMzVmKk8vNIXYPolu2sw8UOSDgcrvXGJzhd4GgQN CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4eksprn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 17:26:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QHPYTg057392;
        Thu, 26 Aug 2021 17:26:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3akb90eabb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 17:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzlFyJGG37jkXZ0JGY+LC/n4g0twQ3EHAFysv9hQjvGcM/mcV116HV8X7mhabcpa5j4/BKkmA34QmWORJqETbkpLCAPrs+ZZ2WHeNJSlrQf2LwpdEzRIks/vS+9hKGrq0dsRW1xFy1UfOGZslREWxFhDU/WEX+sRZlIbuCTC/Fq8N2pByzdzvsvXGqQ4fy4OZRo8VA3tA93UHOK6qs1rYk9QvLQlTayA6A2zZPDHovfRIU+Hvf23JPatdmr1zqx45qwuEmPMM81aRyBFbxZ3BarhgQlOwVT61LMKPELxK/CjaS0AuiyVV47Yn0Mf/dTLtcEJsUT+8tqqz9ahhhYeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4ImqamVhFW128tRLKbjAqcHH5TSsDF0gRGwwsewHnM=;
 b=ZfnI37qBSpaeMKa4JOOWDl2j+r1eo73yC6qFPXYRrnYu9ir2qzIsakyMpCz0W+dNJNw5BBlMz5hFlFQjgSB1xjnO/tE2SGQofj/EBNPsPpCkmrDuK1SMhBoWtai7gavKvRUk43hjUdAd75JXgx7EkTJt18qdQ1LhKxFcBoTukt7uHW1h39QAYFI2qmJsaz34xLRx3x27YSdazwMZNZaDB6WS75VxIrzJxsI8NGFOUqQTgwcAkxWCshqwqGV4NkOz+dbDq6XPvreHae7FmzEBkYaNsOcU2UNkufMkIkYm2g8hPQ6OyUV47Q72exWe0nG4WxOBkibQN/Zo0hkBxjP4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4ImqamVhFW128tRLKbjAqcHH5TSsDF0gRGwwsewHnM=;
 b=x9xq1auxwi5ik2DBf07D8VsXOf0WV2cAKcKpW1BekNbdt8JyF+e+x207wCBTKDMEhVcqMbzcKwQMRweI7KK2RQ159fJ9tew4wY53YZhstpq47uikHH19aAIrtox56p7JR8S2SxBIdhlXpQHdkxnwCOfV504QNViuA9ScUJxuk7M=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR1001MB2192.namprd10.prod.outlook.com (2603:10b6:301:35::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 17:26:12 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 17:26:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
CC:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Subject: IB_MR_TYPE_SG_GAPS support
Thread-Topic: IB_MR_TYPE_SG_GAPS support
Thread-Index: AQHXmp938jmDampzikm4oTqTqWLZAg==
Date:   Thu, 26 Aug 2021 17:26:11 +0000
Message-ID: <D87B6648-A4C4-4D0B-A390-EA1F0A240C08@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 225b9469-d390-4f2e-857a-08d968b699b1
x-ms-traffictypediagnostic: MWHPR1001MB2192:
x-microsoft-antispam-prvs: <MWHPR1001MB2192A49306440A9F3D0FDC4F93C79@MWHPR1001MB2192.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlR0sxQFxG7TZGBR39liHfJfMJ2G1XHwjf14VXgu8hxHzF+EQshD9/dmyI80YZyvuKHGlsOPmVopSD+/tm3Vgbg9hOYJEYfbrhuhkI54XAhc5stvdty0PkaJUuG5/TAWOq9btzzb+3RHI3LXusaU4gaeuvQDzXo/rKgQQ5ylq+LQP5C1jO1kQovDvYiWdXjEqG7xXVbgV+5feEVUuCFFNdGxbwCXuly7dqIjiB9Uojf6TTnnNn1CSC5Zj5H3dHN1sLZf9cRKOxPZjE6nik1LLQahifXtZ/+hfF/MDEM5mjxLm6/dyURbcbPZqMvuLEAHQeQreadXKccYCmnGQzZS5CxrAhY820GGfYG6eEDocl1RmKE6HUIHjk6K/RmsnvEhkpKg1swkNG6Gxihk/0juYr9wo7oq0JuRh6Ac+z8qLtMFp/+FFD7kIvzLNOap2RDRc9dLl28rHTRGp+GH6KJMoB2Bi2LKXQYm8dsl77g1bZAz6PSyDudJ5okTD+WZ5bmP3kUkRVwEgPd1tXrDBTljxe5HSE8FINfQFxwSzIJkBwcN6mjLVtpQHYsPH050HRpZHSs+zIYQFsg/30iklZjmDzgPWYZW+TK2fhQpL95dbe3LjizHbXX22amMkt1dnC9KdjNV0ykk5hAxo0xNCyGNJD/HKXtyojZ1b3DMQN9ld61h8Spc+r0fOiMTr7S9SHR0C+0UL3Cxw1fgGj3j/8fDQgC3InHp/QXb2W2fqUM92Wu5R1AwuOiidDoe+P2sGQs1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(6506007)(6916009)(8676002)(66556008)(38100700002)(5660300002)(8936002)(2616005)(478600001)(4326008)(33656002)(66946007)(66476007)(6486002)(316002)(76116006)(66446008)(64756008)(91956017)(6512007)(36756003)(7116003)(86362001)(4744005)(122000001)(38070700005)(2906002)(71200400001)(26005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WeaJ3O4nJ74UzbynzimnOQ5VFnr2NcbLg+Vyvt4EWjVFTw1nqlT0LOEZOy4O?=
 =?us-ascii?Q?YkoEHP6qxrVi7Di337z30rKZR5POQ0nOSH+uS5YR1P32S69A6+eVsdbPdgdV?=
 =?us-ascii?Q?wL2+RsGDqZTEG3lQM9qGThofb4UDUhfjvLxJPSHlnOuZuo/iIZvHEDtQUGLW?=
 =?us-ascii?Q?3AwHcCqsFDQQDK2y8s4xGGZmp6z2dWa3c85/47a3fUEcTU79/ggUBWwytZim?=
 =?us-ascii?Q?xPL8t97Txs9H46tFfpin0ZDuzY1P5qig+2MsugDzVm2eRbd9s/pr0ooa3le1?=
 =?us-ascii?Q?GtnQt5cm9ZrfNv+reabXC8+W0/C+FZPc8fz5mi+3X4A8Ky0azU4sim/f/qCg?=
 =?us-ascii?Q?kJRJgecvnQ4m8/DbkeRBN0GHaiR5DHydaTFDb0lS7E1p6etA69JK+4TYVJWn?=
 =?us-ascii?Q?R2YhYrX+yRlv9NrTpUZovkj6t+WvjxmHV+x7ZWZ46Tfm0bzZCz7E1ZkSoPq2?=
 =?us-ascii?Q?k8qk/C1XAgCpoidQ8TQw0BbB1HRr14XQJLTmPb0JirWKSnmcjusIzLtrgmJa?=
 =?us-ascii?Q?K9PHESRO40xx4j+SaOKg4Lu12B1QK1imyu4DR6JfGdV3cdF97cYBNdwSi1U8?=
 =?us-ascii?Q?BzWERS+PuP4I3rqLqoXQFTCt6Gwqpip+vmEH37Wb+ydA5Wvkumu9NHEZMjAH?=
 =?us-ascii?Q?P+o7dGK+fgnBxQAR4yV4TeZNl07saqMz8p5GulUw55iu3SQI82MmdG0iROxL?=
 =?us-ascii?Q?XfVKTfXPVHiOd4RFSVNzeOUkqnBQ2ZYHrX1lt7noo8ooT++AgMitatq3M3xH?=
 =?us-ascii?Q?aPRQztQ6eGcmj9DwwcZ8hXmlw1F5l9k4X21DScP4DjbHcMJGpqshu9Q40ROY?=
 =?us-ascii?Q?hVdAWnziidywFcdXh0jdDXxZWAOmv9Yi7dhdp5D9skTbjOBOF/RH33LhPWIi?=
 =?us-ascii?Q?sw9Y391Z35IYFYGuLSOBJ4j+bdS0OqDCfsajAuUwjDj1WlyFOqtrWaTDqZ43?=
 =?us-ascii?Q?H7KhvXNNpMuDNq26OvIrW/A0oqJNC/N3Pur2D/2+FgARrZ1zfLAY2ZZwbzS6?=
 =?us-ascii?Q?jAUE4zJ3Mo5DeOBkSuxpUkN7nmarGxPb9wNKFYs/fJfDb8S4hXvTp8r8fPs5?=
 =?us-ascii?Q?PTOlfTiIVcxccoOFy86nSKerSXVhq84XcgxkkDcXRIBLIkHXwlSzZKmEDtWE?=
 =?us-ascii?Q?o3G0rXtVsLnsc27/UPduD+SVE7uxxevG6MQeHiHxpC+RKJ+/Ah50CM2c/ctA?=
 =?us-ascii?Q?oKf4fegq46yqS52IAX8lPc4L10aXmtFVYsAvKVLIP+DtfD4oMoFrYCm3nwQe?=
 =?us-ascii?Q?xTLn8v01Y1xKGGFWqFyr8PN8QILIJ4woDdBaq6v7msPokW4lwRc73WRjU6GU?=
 =?us-ascii?Q?KKJLx2YsiFmswiWsQEPp//Vh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52B085A66C399143AC36F1FB73E92993@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225b9469-d390-4f2e-857a-08d968b699b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 17:26:11.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8v2y+qXsbwqOiNQ2inCgA3GMnr8EXHh1jPSreM9xgDQLU3fpf6G3r3curnrbZYviuV+LXpusdJaOTnxGRhbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2192
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260096
X-Proofpoint-GUID: djmPJ0lUALu4rfAUvY7nJuxEQOJDo3gu
X-Proofpoint-ORIG-GUID: djmPJ0lUALu4rfAUvY7nJuxEQOJDo3gu
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

I have a report that net/sunrpc/xprtrdma/frwr_ops.c::frwr_map()
is attempting to register a mix of GPU and CPU pages with a
single MR during an NFSv4 READ.

We think we understand where both pages are coming from, and
why frwr_map() is attempting to coalesce them (the verbs
provider happens to support IB_DEVICE_SG_GAPS_REG).

frwr_map() does this:

305         for (i =3D 0; i < nsegs;) {
306                 sg_set_page(&mr->mr_sg[i], seg->mr_page,
307                             seg->mr_len, seg->mr_offset);
308=20
309                 ++seg;
310                 ++i;
311                 if (ep->re_mrtype =3D=3D IB_MR_TYPE_SG_GAPS)
312                         continue;
313                 if ((i < nsegs && seg->mr_offset) ||
314                     offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len=
))
315                         break;
316         }

If GPU and CPU pages are not considered contiguous, then some
additional loop termination logic is needed here so that at
a boundary between page types, xprtrdma will simply move
into a fresh MR instead of coalescing.

Does anyone have suggestions of where to look for an
appropriate check?

TIA

--
Chuck Lever



