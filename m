Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276FB355677
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbhDFOVG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 10:21:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48470 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345064AbhDFOUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 10:20:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136EKCtr173917;
        Tue, 6 Apr 2021 14:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KHRsu4eB6gCSDOtvOvVcunHk4aePZU4VhPBo0pNywjM=;
 b=Yy8PnuDU7fgxRbmarg1FQ/LgWwiNjT6QygLbogg9P+zdTQLAhOHznsCaQiXRvQ/RcQUe
 frwOdIBK8ZdDnVXQ/9RGJpc5YLzk/TWUi4IKvO7QJMupA1X1x0euQVQ3pckcoIM+Masv
 HOIoBKYXp5kizyL+NZGZfH3xKll48AUjDkPhQmZn++49Kpky54OFGXudA2maGMvgV2ib
 ZEAF7o+faZyT0Y9ovjZmWvwF/neCjlq5gVAIXpT8P6/ruN+TSlYj9LlFSDty38AcHAIZ
 w+fF1AHV+wJ3hIMQp9wPrq+Y4qjzb9juiazfdupve6qXQZipWFcislx6hraSP0nO8poD Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37q3bwnp0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 14:20:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136EJurP188697;
        Tue, 6 Apr 2021 14:20:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 37qa3jh1ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 14:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsDN42Yj34KaXlG+Mm4Cep1ckvW+lUdmiBqaw3ODdUn3pY11MhsfKzbuRv3FsE2Wfqm0bXhzIi5VhE7Z9JrrP0oWEArA6myKyQ8ASRKV7Im4QHgyKv+1Bsj6EvONbQXWJb99DDij1JXwdcezgPcnwavNX+Vu6u6cD4W0hoV0cAoqXI7c5SZXOMf/kMUztRvRrydquEPwDcjTPK8w5cmxX6i5hzAnz1T2IkGTapqPU52G3nsHR71SHDIVDxhP+/YUxt+YCezYlEWocbGI+N0YBYs02MfS+rofrituOKhPgj5KGPEnD28Bsfdf3N8/EQxDZDYwuIhivm2zhAyboShmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHRsu4eB6gCSDOtvOvVcunHk4aePZU4VhPBo0pNywjM=;
 b=SZodbhUhTscJyacAvvdnwB2ktOYUmRT9OXhR0enZQ5Z6gsYwknKorb7MaENeMjyWCehZoyq3y9IkyReqMVQpHyIPNZQIf2FaQ+SkEq6n5euZx1U4DVjYicMt4pXJ2ciG4PTd07BpQ9jhtZI/ZkJfJy6eyZK1vngE83s2sYvpN2sYrmuNMwf6Q/bADpoyWF5V6J1Sufro+OCGgI+B4cFC8SIaai8JKT2BXptyAp0R1q2Uf3rywR1DJ8E43gwHc5NKUYmOAhLg9rpS/s0RsERovKc1v69kIU/Fg0pObX0IDuZMTDgIpieHOtP2qea+MVP4myyIMIA7F+AqIjvPRXUiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHRsu4eB6gCSDOtvOvVcunHk4aePZU4VhPBo0pNywjM=;
 b=p+FMSaH/yRl/pd2K7tuGgxNDLXmt6UPmpz4HFNnkvN87AW4rgmOjAZckZsLGEbEGXtLUnJ8t+DIL3dZH7KTeZH6a/wpQtM6Y/JNtFJ4B81megYgsOltbrqwdEemwYGUSH+RoLep7Nexx/bD+hq4HucFUJ2XXFBuMqza0gBtxJhA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3334.namprd10.prod.outlook.com (2603:10b6:a03:15b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 14:20:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 14:20:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH 0/4] Enable Fault Injection for RTRS
Thread-Topic: [PATCH 0/4] Enable Fault Injection for RTRS
Thread-Index: AQHXKtsgx50JMIUbk02ssSVMwtKVc6qnii4A
Date:   Tue, 6 Apr 2021 14:20:09 +0000
Message-ID: <6DBCD231-E108-4F4C-AFBF-688E988DACD7@oracle.com>
References: <20210406115049.196527-1-gi-oh.kim@ionos.com>
In-Reply-To: <20210406115049.196527-1-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb17885-0c7c-420d-ec75-08d8f90715d0
x-ms-traffictypediagnostic: BYAPR10MB3334:
x-microsoft-antispam-prvs: <BYAPR10MB33346202FF743C1A9116A1E993769@BYAPR10MB3334.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: waE5icP5dHOVB+dgGSQnPVi7ofOERQYzzHoW6ynWj84i0/RGfdv9geoLbshYXA0t+l1Qi/VZ3KS6daA+4csLcrcO8Pt9YvY+D4C5SToUP6ifMZJKS02JlcAWjJadwEhaR0LrURtjtG8JpWeQHN9eEIytpXQM6Q5W2WpIknFzauYmsqY+37ARb8JACFsaJ7sUA6smvrQ9xU+bBxreCPSJOppOuaLMlnnnB72Ar45M8b4hgl7yEjQEP247ZvJ3H7na2PIisaWj0+66SANEpYGO8Q6vjoI6onkSVym1QptDK3KjtB1EPL0+JsqNkLsmj7IeRtPHuaxRFJSVi2E8FBP3RB2erHMYfp+0qMI1Wto0Uus4S2Tz4VPSYL9bSUIrA9/2bjLZuXsTx4c72KiZI2utojwh/ED5raGHNjqKt7spVG0Ht75MY8hGilzzeqTCn5eQ016M9/4xAbbeyvFq3xsN16SEwK9EHvMKsZKCIjStNvNLeRdO01mTW1hoGFFRlQZt8J/Zkxhjl/ysmDPIk9n7IdUVdv8Byu9e1IMVY8c21thRoQcepsddcdYHaG8oNjFPcZDOmtaZqq3zBNlXzXsuoQCIatXVUbRUPy3bwIMhrGIVZuxekpUrIoD2a1GpoAUx1JdPggUdZR6ry3LFqAu+vvUiznYoR6YXrn0AZWzAbGq5pmf2bjb1oK1Rjtl0J5iN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(33656002)(2906002)(38100700001)(54906003)(91956017)(8676002)(86362001)(186003)(76116006)(53546011)(83380400001)(26005)(36756003)(6506007)(4326008)(7416002)(8936002)(478600001)(64756008)(2616005)(6916009)(66446008)(6512007)(66556008)(6486002)(66946007)(66476007)(71200400001)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u69E8zbE1BcLENoP4bTbKqV7GJX9I2le7iAbHwvYsdAlNkdvHRvwAKeQiKvb?=
 =?us-ascii?Q?W+p7u97LmITk/rdNm0fY4roHyaDx4BgMN0FUrCuh1tXJoV2uS12R1pQenZ0R?=
 =?us-ascii?Q?0RJonJdF/Os+Lo6xbDABf+dW6I5boGXmjIPQM59cwaNXmUlF2wc38Hcmj/cy?=
 =?us-ascii?Q?BgZGQTKudsnBIZX1bReQxDbjhJRSIKeeKrO0j86twabZk0lw4DfVOuSeMFl5?=
 =?us-ascii?Q?0butxmPe4uZGReSaDZ8e+hjj446+1Fp/PVnge1aZIyOD4bY83q2ykD2O7A+N?=
 =?us-ascii?Q?7EcvLV49Vev29qX0g5RY/QJYk72xFawtGJ1/b9v1dH7E6jfuc2feYwkXsr6+?=
 =?us-ascii?Q?HY57b2vvfLC+u3hDHvzIiE3276mWbg8IWY1q5UGfpz1Jn2tbog0jvoo0i8rd?=
 =?us-ascii?Q?rKAF5V3XlhIVKbl8wMOHGCjE+W3GEg7XmhLIrfCHCfLzu1IzrocmaKxUBQ0+?=
 =?us-ascii?Q?9sUNFvTuV4GQtflrSSGv2slyI31f3l3eVmetoLqhNutjfRNzWeX+q/VA3+Aj?=
 =?us-ascii?Q?dEPVmjW/+7ruKzD7sBDnW5GvDjzlNnPYmcXwkXEPE5hvERKAuaw7g8TF26i0?=
 =?us-ascii?Q?/vUlitrR11Wu6OK5S3BGGdwPmleARgla74apsVghAmlmcnz96Hj4rWKAqURy?=
 =?us-ascii?Q?j6EacoykvqEgJXeGRylqCY5Zf6TA/AP141c04usOqhY4RkXWaTijns8HGWbH?=
 =?us-ascii?Q?0WkxgXR6owXAiRQRstdSgFecQ3rhDSRYAp/qfI88oZfr2nKZCpuq3/l/Qg1D?=
 =?us-ascii?Q?GfspP6DHwSII75OnLjnr3LZherZjqCQU/3luRxeyEvnBnWH/iwujD5ZCUd2R?=
 =?us-ascii?Q?sdayo2I7Fd/VyClmswANCHPGNTxKg3g0AEjYgNFewAhpY3MInNYLg7qiSBJ9?=
 =?us-ascii?Q?BfX8mdAWS09osyKXF+EVYhlX3LGzV8hAVW208/eEFZ9xthKYX33GDGTMS79E?=
 =?us-ascii?Q?BdSoIaYYiwm3FFR5I1JEflVsQHczJLB73Ssj3M6CtvhTGgSUx2LTdVtLhgWp?=
 =?us-ascii?Q?R2xttuivluLw9pROrVOVdL+09t3t8rQwngj1Pui+8P6hg9WMCZADjUoEFV/f?=
 =?us-ascii?Q?ZShByqO9eqQXiK9cAmVsvJH10Bzu4OextW2dmNPnoNs3RYVVuIPN6sRdKqoK?=
 =?us-ascii?Q?AJfr7xUvQg7VHoo1WWHIu0jzAJvL3qV/Jlp2PuUNp2mj7v//u9EA+qW6TLIo?=
 =?us-ascii?Q?ANSxQTdZjLRCGhz8ssO3ZzXaeidG/NAJTkEFS1eWSvUdHsOw0pN8Kz8FmlI8?=
 =?us-ascii?Q?SLQ1FBeTCRsSYEBRsd4Pjfs8qTPbr9T87x8TAdM8oihU3MbhT6MZfoNiGBe4?=
 =?us-ascii?Q?FKKvagI2YIOQvNgimmj2CR0o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8843BE90F42274F860053FBC46EB82E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb17885-0c7c-420d-ec75-08d8f90715d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 14:20:09.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKgp9YCK7RlEkAUhpo/o8QNUXau44iqWu4yQXbumJQKla1VvhL0YHqSe/wu+ooylIEk6V0MwXKyCF2Qa2af7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3334
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060101
X-Proofpoint-GUID: QY7ZpNguJH7Bzg6YiZXS4oc1k5ycDOvn
X-Proofpoint-ORIG-GUID: QY7ZpNguJH7Bzg6YiZXS4oc1k5ycDOvn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Apr 6, 2021, at 7:50 AM, Gioh Kim <gi-oh.kim@ionos.com> wrote:
>=20
> My colleagues and I would like to apply the fault injection
> of the Linux to test error handling of RTRS module. RTRS module
> consists of client and server modules that are connected via
> Infiniband network. So it is important for the client to receive
> the error of the server and handle it smoothly.

I am a fan of fault injection. In fact I added a disconnect fault
injector for RPC that's in the kernel now, and it uses debugfs
as its control interface.

But that was years ago. If I were doing this today, I'd consider
kprobes, since fault injection is generally not something that
is consumed by users or administrators in a distributed kernel.

Have you considered injection via kprobes or eBPF instead of
adding permanent code?


> When debugfs is enabled, RTRS is able to export interfaces
> to fail RTRS client and server.
> Following fault injection points are enabled:
> - fail a request processing on RTRS client side
> - fail a heart-beat transferation on RTRS server side
>=20
> This patch set is just a starting point. We will enable various
> faults and test as many error cases as possible.
>=20
> Best regards
>=20
> Gioh Kim (4):
>  RDMA/rtrs: Enable the fault-injection
>  RDMA/rtrs-clt: Inject a fault at request processing
>  RDMA/rtrs-srv: Inject a fault at heart-beat sending
>  docs: fault-injection: Add fault-injection manual of RTRS
>=20
> .../fault-injection/rtrs-fault-injection.rst  | 83 +++++++++++++++++++
> drivers/infiniband/ulp/rtrs/Makefile          |  2 +
> drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 44 ++++++++++
> drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  7 ++
> drivers/infiniband/ulp/rtrs/rtrs-clt.h        | 13 +++
> drivers/infiniband/ulp/rtrs/rtrs-fault.c      | 52 ++++++++++++
> drivers/infiniband/ulp/rtrs/rtrs-fault.h      | 28 +++++++
> drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  | 44 ++++++++++
> drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  5 ++
> drivers/infiniband/ulp/rtrs/rtrs-srv.h        | 13 +++
> 10 files changed, 291 insertions(+)
> create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst
> create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.c
> create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.h
>=20
> --=20
> 2.25.1
>=20

--
Chuck Lever



