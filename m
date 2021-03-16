Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315F433DE49
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhCPT6d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 15:58:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhCPT6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 15:58:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GJoXD3161581
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 19:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2020-01-29;
 bh=AoBG+Yocv8rwMSNphL/MlJJUHCEzWtYBI+JOCbMImDk=;
 b=O64u/PQJuXY1HQOTYJgC2h7JpwfnZQAXwUmurq7tRqSn6y5QZ5cUUhNZWyf5+Lv9UO/e
 6hE6jqk3r0m8q+H2RsbSHTlH0Y+k5jJFl/P1SRVJn3lcEgkt+T68mEWF01zotDYbB8hC
 bdguRsbAKhjls3omL+vJXbp5EMd1LN2ylQRDE/cuNhHvzcKlmayblEuAf3RzWTBPic7u
 t6FN/hby9FyftVINv/A3jaNzEUcrJ8CoFyESL+lRltkwwDMgTJ893BuOXtjhgN6N03fb
 adNN4TsiAvJ7TxMONdFBXN9834rWDD8roUBU34+2KIAdGwnSSFcwCxor/Esm9q48COK9 VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37a4ekpscq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 19:58:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GJtJRV094358
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 19:58:03 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by userp3020.oracle.com with ESMTP id 37a4etdw3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 19:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBQ6Ubu8xMaj0arhUEj6muaWaXibaqpvTy+IkHUKrI3vocOSCG+PpCJ97/gPEDVlblxTXdH98WOZV1+advMd94qDubcZJjCg46OJENlUGRNwBAfSuuFlkr5iej2fKiByj3sXfTFic9ph0KN7R2b/M2yRulko6cGTL0cGrY9GmL+R5OSkPmkQdR7KDNk3xWljamd1qO7lsGkLDjccjyL502RfB6Wu+ivBzi2Fl0egpuYDT+p272WzPKzuSEz9u/o2vIo/JErlqvzCmPxAwE9/LRM1iq/UZCl6KeZ24hEtGNXTq3DECW6ZBR/SVr/tyXQFwQdPKb0cUAAtPfyx2kxL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoBG+Yocv8rwMSNphL/MlJJUHCEzWtYBI+JOCbMImDk=;
 b=JGFYsslAzL/+tSRyayNf8m6yaVQtNMKSIwYXeL0647MfISuJOxLTZJsfQEJzj2dglCGrK1VAVz+T54QqNqEPCvWAKi5bldSwB0J9N5NfxvZsNnHYwMGdokmpH7cbg+lGVYb96QbEZTWKLXYxoDy/7asVuge9cUkHP4cde9eMpAVL6ODiV+N82gVACO2MRbzZLr5TavxJXh2GWsZXBwRnhPQYIlexGyk5vTP6OwBXD65JDdRNEyqmEgluVuYutC+gYoqff8xAPATmwDZrfMWFMLa9o3lj50r3+JXN2cCRx9NF2mRu+AOCPevSGSr4EtE3PdL/ijiCFWJzFmgufTawSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoBG+Yocv8rwMSNphL/MlJJUHCEzWtYBI+JOCbMImDk=;
 b=bQZgjeqvv65hSj0R5jRBWzCW4HhIoYVGe0/0NfjUEMidmrsdx4VsfktDJjmaHU5FrN6HtNMMhXCRHGYOfIctz9M275FlpidNljiycyaUWaiISAgE+2Q2gSzpdKSDZaP1JmvMaTfhJDi6nYvcc0tOyC7J8PYv2CtaqbnMSf3lG5o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 19:58:01 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 19:58:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Topic: FastLinQ: possible duplicate flush of FastReg and LocalInv
Thread-Index: AQHXGp6rKm5pojEmnUqrdHeuFBMMog==
Date:   Tue, 16 Mar 2021 19:58:01 +0000
Message-ID: <73EEB368-3E02-4BDD-BE16-4AA9A87A3919@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 423f3ea7-ba90-4063-aad6-08d8e8b5ce2d
x-ms-traffictypediagnostic: SJ0PR10MB4687:
x-microsoft-antispam-prvs: <SJ0PR10MB4687690CA72B0856285ACF70936B9@SJ0PR10MB4687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUSp1nIP38W4fL/YJHaUYI7NWcArk7u7fn/MhZMJhdHe9iNaeJaDhNg9RshKF8oCAxTsvjsyxS5UvucIYgsrtzV8U4k3NDo+qt3CXUJW36y4vFAnSmGPVyKxdHsKkEo+U4BTG24C/fYgplBbxfQVjr14/hq/iFiG02t087WfycU4wsLGvCfs2dQpJ9XOhbcFWgeV4J51geEuED6Q0yEx4+os+dQOPKnaFD/e8K8w2fJmdRH26sSL8PlOrbesqhEOctiEjgoTWFoGGr3fvhyFyQoH6MDAD42YmlEvDy+LwtWtVNznb3RoUTBFwZMlI9WrGQR+eIgpRDzCZsB/ITcJXRT42TYYH04WzYcS3517H9mZardxDIx419j2S4alSd6gRIHiRZ/TPWD82W6iWTKQmPZ86RKtmBecMJAYvxwr4Tt1Jjath9go13t14uP4KjrVkga3nTrfNkpGJImMzhGa9v9QYIderZ4NOsVF2Q/dxSOd74TbhWWh0c3aKwwbDxUJfQsGVnlX8gULszC7twqMovbe7vFMUMqrCkbZVskEbjg9gL1dfcQZFWOrucNEn2ih0LzZcCAMfsqHFMQrvCeDb0EFcPN+uupnzIj/I64rQF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(2616005)(8936002)(8676002)(316002)(36756003)(6506007)(6512007)(71200400001)(6916009)(26005)(86362001)(186003)(76116006)(66556008)(2906002)(66476007)(66446008)(6486002)(66946007)(478600001)(5660300002)(33656002)(91956017)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j/08Xrq1y+DJ2oE5qK4WG4wrmZ3ALHoLfBM+wj1gXFSX6uXOb44dYLhSNf6w?=
 =?us-ascii?Q?A95V8czAbBrQTDmorC8eYafRozcwOkD13XjJ5FWsxIkf8pqLDjCMCn5J/yeu?=
 =?us-ascii?Q?r3VEW1oiZ/hlmKkSo10wKQPN/AiF3rq7caVY5tWeZA50aYgw4PWDVKErXmIR?=
 =?us-ascii?Q?IDRtkYM9N5XEpEJE/GvQ0QXEODNEhdTOY+bV02fXCX1ZFK1mtSyQpJN+1jD8?=
 =?us-ascii?Q?9AnTHxesHSn0yQryhJRbApQHlkbZUAZHVNW9Ortfd+ll6FMwHccY6Zik+xj+?=
 =?us-ascii?Q?MvyOMbOL2dZWUVHssbcK+C5iY0aJKeTuRz0ZaC3p1k4L8GUj3Ist0qz+Fkgr?=
 =?us-ascii?Q?YrRL7sH6yZMwf5gBNtphInxMF1P7dmrJkYa3PGfZvADWHl0amRTEu0jk/AjM?=
 =?us-ascii?Q?gl1ml7ikerns5fhE5R4CSsuJAyg8fZplyV1kSWmPoVUK7SA/DS+spttVIaUN?=
 =?us-ascii?Q?VXwIGEjC4pzd9of6ZOIsee/bELQkehmKNsixbGcVWlzhIcZfQ0vim71EXJ+E?=
 =?us-ascii?Q?iK063sm0RIDb8k2W5Z/ZQAmMh7AFYb2KYOLp3abOKdItz37uuMBzNKO5wcQ0?=
 =?us-ascii?Q?kNC9Mc2DIzhhYSM1oYMMGxUnO4pdlmpVN+oSP3APRNNwamOjWV4qKkJErQGb?=
 =?us-ascii?Q?wrCR9UTpaRPxXfM0Mqq2qxAcOduNcYhXGbQKEx3pEJVlulZqGAaMmiYQJQKw?=
 =?us-ascii?Q?aqGmKm/UdmjxvPmuIOW361oTwaFB/frVoif5flQmDjEGT5x8ij211lmPLrd7?=
 =?us-ascii?Q?Ij6fzyl5bFFWGcXtrjEagpCN2cd/bb48x4u/1KtNcOnvli9dixiBPtg0XQy3?=
 =?us-ascii?Q?m+acF5xS5sf391RdpX2MIqnnRLYsYU9gQBj17CVROUVY3y9cj3zNyO8HF8Sl?=
 =?us-ascii?Q?4ihj9UKTukhWGpV+a43ltz1lOtYr0XqAy2bUJNsJkydsnReh84YwxzPfURab?=
 =?us-ascii?Q?ChMgMxcw9F5mMkXCmSi0IJXgOfCe/qffr4U4MsoFpuRyfewXS0grvYXh+kM+?=
 =?us-ascii?Q?Qnvsc8VO6fx8/y2tnqmQkkxMU25X+nEvvvieVSe7jNJGTepRPKzV84fZwsbB?=
 =?us-ascii?Q?TAMi4EKq6BCi7R0fB9DDUMoDUzR8HpGWDD0C194VAuyIrCqwnAxwm4SS1dh0?=
 =?us-ascii?Q?+GDCw0GEs8+4Zg857zvRLLu+NBnT/XtzrpVxmbJBIlfohV9hIJj0cz/eEWyt?=
 =?us-ascii?Q?jUx2C/WfvZ5jSWLkOtc30L92vVNF0Y0Xt21PSwtqLvuFKWfZmnnlzaoBc2jR?=
 =?us-ascii?Q?6jITezBfWZ1+9sLQfCUuvHjotqCXDc2X+bqMxnttnlK5HO2QnndRzkmvRZaz?=
 =?us-ascii?Q?AZfJ4iDXmcrXULnIywKHIXjU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D147E26964629547A8484FD795886964@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423f3ea7-ba90-4063-aad6-08d8e8b5ce2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 19:58:01.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNyjWUjIwKuVOEHLLl72+42dWDYBwK5FKKPVAv0bVpdCoYozY38oyKlEvKkApk8yO8VEgJHWt7kMeu6Bl15WlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=608
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=855 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160124
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

I've been trying to track down some crashes when running NFS/RDMA
tests over FastLinQ devices in iWARP mode. To make it stressful,
I've enabled disconnect injection, where rpcrdma injects a
connection disconnect every so often.

As part of a disconnect event, the Receive and Send queues are
drained. Sometimes I see a duplicate flush for one or more of
memory registration ops. This is not a big deal for FastReq
because its completion handler is basically a no-op.

But for LocalInv this is a problem. On a flushed completion, the
MR is destroyed. If the completion occurs again, of course, all
kinds of badness happens because we're DMA-unmapping twice,
touching memory that has already been freed, and deleting from a
list_head that is poisonous.

The last straw is that wc_localinv_done calls the generic RPC layer
to indicate that an RPC Reply is ready. The duplicate flush
dereferences one or more NULL pointers.

Doesn't the verbs API contract stipulate that every posted WR gets
exactly one completion? I don't see this behavior with other
providers.

Thanks for any advice.


--
Chuck Lever



