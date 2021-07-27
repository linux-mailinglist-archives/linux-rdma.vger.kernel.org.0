Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9103D7C1A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhG0R0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:26:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14292 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhG0R0N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:26:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RHPs0b005723;
        Tue, 27 Jul 2021 17:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DGLFhxR8Xz4EjNYXjZcgtVFrrcZs7WGYFc5UFv2l4sw=;
 b=OuGqnuda60EvHbz4uMDx5d52N+XgowQ6O8L4O+cOYBD3fMuxGpxZLqbJDEVPn2WKeBzV
 5K6LtEGu25PKZ9P2RiIb9fIqMhobKVzJf2op9Z02QXUxKAu4PldW+i9GGMDmKPWwtvRn
 4/uUysU3H1uNsW0ghrOYuAzMyKPzq0Yfpq6TBCs4lMUziAyjDkjSWwEwfnjLUs0T1XLW
 zbuS2IO+VQPOEi+lSoazbWnta9nGaliKeUosGJL3AtzrgxviKUkD9ZSnNB/nAnb6EgAC
 myLJvqQIfE0BYhmb+eztNbnkwChLlfdi8NUoEasZR/xJdiI3ibBIc7frOOgEqbCKHvtO Ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DGLFhxR8Xz4EjNYXjZcgtVFrrcZs7WGYFc5UFv2l4sw=;
 b=ie/lbMh36oacvlhtg27T58w0xuN93K/0QhwwsDMPEi6hG1sq4RE1GI9kM5ASLAdZ6G4Y
 /FnsTDrTv7PgjA1sEEpFNmQhUA4p1kht8uphO+K37dsi12XOFyEGVdYmv95ULjoAZSqM
 ksJiFdFLo0kxL6loWkU8rvpGbhAgeTclDrEYtLp7XoIEdfmmAEJwrRKoLmM39p5LfUd/
 o2PKW2iTZirEO5TWh1anGuIJpOAwedlbWSEmHZNE4+mfKy8yCZOizvN0RBLXe4LWXv9v
 TKBZ7jJbWqu2NapBNCkJjl4qxwrblAELmK58B9KUZVvNzHDJhq6fTlZ1O/B8T8h5D6O8 ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2356jcww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:26:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RHBURl147756;
        Tue, 27 Jul 2021 17:26:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3a2348j1qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 17:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOX+xDgnsj4HRPBpqAWO0uxv0TWGrTygOIh7StNXcyOM+wH9xQxvrzC1w7sKZU5XTt1XRTkF7RMPe1WZEZIOQujuey1JMjQXcFuRfpmTVId62BM/q9x+/6efak+KrsJ0IxYUEz2tsZRw4skuJ2dZ/aNNJ2n2z8t6nmxFgkxJfv0VcLVz3KtbuOer+HTUtE8JMkjJ/7VwqMIk4+TFrAGa2Hbr7FBKK1gnkvSoKAazByGDYWQPUvMXAODx0xtJ+Wxr/bxxIkhOwp0r06DjIG6sqrsKwsE4wf41ivD+j0NexJc2OfIeEtxBqXLGY/v+NKQVvVtiG78V/tUDrbYaDSWhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGLFhxR8Xz4EjNYXjZcgtVFrrcZs7WGYFc5UFv2l4sw=;
 b=JDPwDk+M8yPeepm6Omr0Sl6g2AXSHSN2IN0+n3T89TWv0JRmaibPig7Eitzu3joYOVYqCw5Kz6uzMHo0uYuPyGtHuUXkF5dhvVI2wZzENOLdIX7Gkzerma97MNGzSIkFMe3WEjQlXKhVGuuzXMUwP2DhQjM/QM11CoFCkhvGHnL0oOoYmxpWwrxYpQkNxRjaa5jB469jFFkhuhjBurmIzfFVSr+vwKgTJuuOAl7LjgQsoBYmolEYZgU1RepDEpGtduqkLxsX74YfFCpmiDb4Yc5skCwKqlqEJSNB4R8ARBMXdywZi4uKYDjqlxiBSR58lpNegB+d9bMHBpGhkWmTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGLFhxR8Xz4EjNYXjZcgtVFrrcZs7WGYFc5UFv2l4sw=;
 b=Z+6mK/GFWLKYKHaG1HhU1EIFLxnVR8EaIDDPENbn7tkELEn1ajCXVN+uvFQU/zvnMyGNAeJ8nFoX9SuEPgSUZZ0ILVOwg0xP08WTlvsqrQE87CSs8zldooRd9ndUh+jHOm2S4AxvPx5DoA86v2Kus93TQQg9H+VOzPbY8t2UH8I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 17:26:04 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 17:26:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQAACUb4A=
Date:   Tue, 27 Jul 2021 17:26:04 +0000
Message-ID: <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3212b1e-5e6f-43ad-4b24-08d951239c82
x-ms-traffictypediagnostic: SJ0PR10MB4624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB46240D9BA60DE4BEBA4E199D93E99@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kySQI6IqM3RaixQPv4YDTirzQjN6R+wfIfi+8MPU3G5amWv/w6O7M/4a6LYUTWp2POl/Gw2xzH050CoZiUeRkftLmLDPGK572vI4j4SVb1jw0JfLxmfiut4b+eHxSVdGnL9f5d3ni7+hLSpQEnKTu9v3aFWSrVWIExV8WVtYKWqHsUdekKf2sVoTyMbCyYBXcQJu4As/Zql1Em7FgngkdxrJn5ISmRuOpmeShRJRk7f1gO1zLZtQDUoTtqMYkJJ9YRFxv38LBcM79Z5MaR5Gw+Om4nKKG/KJ6wh17oXgGetFSEmlyeagD+Y3zIspD+r6KGTdPQt7+gFp4Ja72X4uFdzeNTRF4edsI+1qeaFzURIQvFg8DFKWg91e73SGfu65hI7+fIClt0/Kv63kkW8gEns0YA7luTaNu2Lo0c4UYXfQYfTNQEj+1GzPimNMDexmaexLeemeE3st1nwJMzZEZFpb+SMaxuFBQIFJcuIriMUSe8aUiUCaNhzYj1DrfP8x1zx1r9NcoWLCDNuquu7VYmztBreD+us983OmgahSpJuuLfU3HEr0k98/WSth3Zu4Cwoi29Lu4fCyz6QHUTBxXfDAN1vlNZuBUJPXUGXw5lez//nHDw9aZSJ9CSgPfFPgpdFflAn9xIJNBpymvYdTeLCP4a9UVh98yV2TkztvEhdNHK17vuflJPZa1+OhLUL/Z6/TdtLMOYqSzO0HalNVNA5IG+AC8DXa7/LiMWYcwspMZKNfW1/A3u0ZLxPC9w+Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(33656002)(508600001)(5660300002)(54906003)(122000001)(38100700002)(6486002)(8676002)(4326008)(110136005)(2616005)(86362001)(6506007)(6512007)(66946007)(53546011)(316002)(64756008)(66556008)(66476007)(66446008)(76116006)(71200400001)(91956017)(36756003)(2906002)(8936002)(26005)(4744005)(6636002)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JURPBObTwus7f4lWCFv1hTQsHJrz9nc2HHTf9ujZxgcPaeMOyHI9OUYM0rTN?=
 =?us-ascii?Q?dNnUdT/F4WO+XvUEKGsP/ZejfOcE6QYIoqiUSIuB47s4nDerzm9mQjdDYv5E?=
 =?us-ascii?Q?YJaJz8+Tt/9jjLh1roDmAFQvdEpw88xM43Wo7pWi2PRhdmxARmlAKAc7Y7La?=
 =?us-ascii?Q?gHb9JLxZusbK7OJ/waw8VpJSnfIDdBE/ZaerIRAANmIBFH8o8lhoCJjOp04D?=
 =?us-ascii?Q?r0hC2dWCopLTdIIvEeuQAtVdz9s4ChUWzm2T2FBiLLSO7+EU+O+LWCvA4Nod?=
 =?us-ascii?Q?OYiePODhe6mGOgesEy96MG1jeuMNsqv6uZkWavDe4W1+yh9mun6re1CQUmFj?=
 =?us-ascii?Q?RyJga9nlBhz9Ayn2rp9rHPBv7ruszbwr4x+okoXt4yxxQlM/RfLXv9O+EX+k?=
 =?us-ascii?Q?XdaCYwrrgsduVyGrzZ6BGTz8fCpWvR/AE9Dotd2XssR0EAGBg6Jh7u140d+v?=
 =?us-ascii?Q?FXWUwFrm2gr+UBmJQR0p+mOmvq+ktLhHXkg71ATPxHJGm5MKLAD2UqYygR99?=
 =?us-ascii?Q?9FBYosfZrMBrDZrBHvAIPvAFq1DZK5BGsa5j5x+St7LboQxihxhP3o7vublZ?=
 =?us-ascii?Q?Sa8QfDJJFSaoEjftHv5zm2Puxm5yD9kwldjO6ulohq/+75zqq/LYroSFt72r?=
 =?us-ascii?Q?5Xn4rZ5mHs3JyzcNycGVVfC4/6SWFC8adNJMgzvZzK522Kv+kf0NnhBiAwax?=
 =?us-ascii?Q?mkn0uOSfzxMj2uiBrs2jXzFfHs8UxMiYl1f8PG7grRzV40Bt2X4DxJW0ekk9?=
 =?us-ascii?Q?7eYKoCxkM+1ZUNQwDIBpE4/MbZMuLntENjbVf4wBcqDL0E3hr1pBxqV2+q5v?=
 =?us-ascii?Q?ik36axWwmcz2hEmkv+kNNMLOzfJia5+obuMUZlv6pQLgoYKQ4xnxPo90kY01?=
 =?us-ascii?Q?salP1Kt8FFoCKXtv47hqhUidxXZCCPOpG9mYNqzNDh6u71TvgVbDVQ+AlY57?=
 =?us-ascii?Q?RntTmqFp9U67jK6998SDmZfohr0HQHfPvdHg0p94kTkbMoGDDGe7qoEI/Aay?=
 =?us-ascii?Q?c4AXwG0fHPRzB2xzzo9W0lXclxgh/MZKpaEz4ChWL9s/mxObH8Xw3dHd7UIs?=
 =?us-ascii?Q?EMJiX45ZMJGJlL4YssPo1S07q02ZuPLRLEKoXjA4r2X+6p7TtwLqjLjyZtsN?=
 =?us-ascii?Q?zEGk+CohQw74WNaGWB/b4ByUMfASiZrlfG/pHr2tM4cv5g/EhtpfewUBq5po?=
 =?us-ascii?Q?qTf6gygbDiHYwSYqT9BzrhKrWCmOVSUBQjdtzNitVe10C96EOyfxACoEZ9gW?=
 =?us-ascii?Q?TmNUZsYplbOAQMOvT+pLlFXNskwNHNStH4p1Z65GASitH3LNDRLZAbhyx767?=
 =?us-ascii?Q?iOdS/DBg0iVcoP1oJUoMKOWbqiHdPWGucfy47//JvqiPMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0694071EDE9B214EBA907D09F2DA71CC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3212b1e-5e6f-43ad-4b24-08d951239c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:26:04.0110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsCcpN+LR4M9A3X8wC5F2m5GtNQV3XyxpORJYqa0QIEVEiSRREKcZtECPamkIhH3iTmZz3l5yL188MIN4tA93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107270104
X-Proofpoint-ORIG-GUID: HHVQQfc4JfBIsFCIbQ9F30WRN3AC6lkR
X-Proofpoint-GUID: HHVQQfc4JfBIsFCIbQ9F30WRN3AC6lkR
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Jul 27, 2021, at 1:14 PM, Marciniszyn, Mike <mike.marciniszyn@cornelis=
networks.com> wrote:
>=20
>> I suspect the patch needs to be reverted or NFS RDMA needs to handle the
>> transition to INIT?

If I'm reading nvmet_rdma_create_queue_ib() correctly,
it invokes rdma_create_qp() then posts Receives. No
ib_modify_qp() there.

So some ULPs assume that rdma_create_qp() returns a
new QP in the IB_QPS_INIT state.

I can't say whether that is spec compliant or even
internally documented.


--
Chuck Lever



