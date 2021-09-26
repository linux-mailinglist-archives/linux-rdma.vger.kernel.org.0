Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0C418A5F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhIZRhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 13:37:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31044 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhIZRho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 13:37:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18QEc7hV017464;
        Sun, 26 Sep 2021 17:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yCgU201JjRqF39cgfV0u+zlU33dhrBl888vpj74kwTc=;
 b=OfvLkTFWUu5jrGlX+qduQWqjDybTuVVBe4Id3S7MrJwUAh1M11GxLN4Fo0+m9fDbJv1Q
 rDq5HHuneEr3yfAr406jWqYtSYbcvIChkDbMVJwDx1ozRNVUbazF6tkBigzE4YqNuE2U
 ZstM92s7jD3dV/58iedVxfdKl+Lb1pB7WbkrV9JE4IhElPxx7bBV1okDSpaaWEaOPdkg
 KSq7JAYa0Dl+/U3z1T+8HfgDbmQt/k5gOGE6w09TMQw85sgwx8yxvfr9fxd+j+Wpns2S
 rwdAJfUwk3s6PriqQn9FQs7Q3hp/Iu+h4ytRdG2ASu4m7AvvxNzB7dYWHopEcMCu0+AY TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bap3e8r0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Sep 2021 17:36:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18QHZDIL073037;
        Sun, 26 Sep 2021 17:36:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3b9stbnjjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Sep 2021 17:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Paq7tCixuOTSwSAjMFo/hPOLFKc3Tq9SDrEcN7O9OorflzqXUtjpUx2WFGNtQ0ltio/0FjA3clOVPNxeJnp1u4nRqi8UJGiGKP3KHzWQBvy8H2lJ2AXh+KrRVEjymGvuEr59EkhulI6SfD7WJspKF+FIANxZWEQ/vTl/kFNNzf7M6wAQz/bgoc8OYRL38xqZMY1elwFXUIm3HfYK6na/rUe4RYoOeMoYC78QeWjndAqLhXhuEtzWPQhDKl8QuzLIda9KViXOllUfu/WiLK5gemKEXEGkv28+XGDRfEYCRG9bPoN3P2LAsE8TZ2D93tUmE8dSEYWpuSxsoBq/1BUQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yCgU201JjRqF39cgfV0u+zlU33dhrBl888vpj74kwTc=;
 b=CwDd5N9juwAXi3+g+Hirk6X3+imrOuF/92lz38t2cJLBlC2/ejLxqlVY4J+rSB6+wjQbNBHXq1ePaxcDIbfR7tv8hyEwzfSh/n+ohbTa2ff/kP4WdE8LeC6v26f0y9XLgqR1GetGuM8rzltkGlRAiULRRbgcfop4GYzz7oYcrTfm8H+/X6rxJx/iNYI3q2YniPurn+AEHDAha/wS6M8PZN749KCRqL6z+MSnkC1qsnJhaLOPOgWwDqn2LJ6KkkoQmTYcgXs7sC2SSDPwDYa+qQNEti1EMDXeKo5MbWyLACgQwFHQkJL9xRrg8zh7Krvo2buY0IJeviSDTsDuhjzHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCgU201JjRqF39cgfV0u+zlU33dhrBl888vpj74kwTc=;
 b=n99IKlEWU+rZQhgk9XGODRXCFEwRhnyf/AMan9dem1FUVM10qPZyq2dqjjvAcmwt97b8GCvhEvQtNSuHccHdwbMTYRUNaBC43udkyy8KxmGKHO/W7/rO7ahbILalfRVL+bOMo/LtKQoPsfvT4ADOasuDjoiBg66X261gLfzql2g=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3046.namprd10.prod.outlook.com (2603:10b6:a03:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.19; Sun, 26 Sep
 2021 17:36:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 17:36:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Topic: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Index: AQHXsVmwbSiP3NBTSkWByRHQxitaiqu19wMAgACgO4A=
Date:   Sun, 26 Sep 2021 17:36:01 +0000
Message-ID: <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal>
In-Reply-To: <YVApGIbSLsU2Ap0k@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7c8ec62-7017-415f-acd5-08d981141c03
x-ms-traffictypediagnostic: BYAPR10MB3046:
x-microsoft-antispam-prvs: <BYAPR10MB3046913917719EB72DFBD9C593A69@BYAPR10MB3046.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3CEIngCjS0Wn5SysKmLJin04v7f+Cw6zYzaIZ+atWjuEDlTNjI2tlJDYDpDynq5VLXb9UvcYf/j/3XRFw78uOgjZiB7xrmWof7RrSqv33glTSYiI9jJhvscNclQZTwRcyq6CXJOZVdU26t8FgwYL2+q6tCA0Fn1hJ2EMXIdHswNK/GJz8cMj0+ndev5DCNy/6b79pEJ1Rkr2P/9cYa+CA8fpv/m+m5Qi0yp2Y/5jSuSufxZq8LWO8yszk43KWEgwWi45UrJwBEdp3XUWUH7T37dFwl1EJr3TJoD5DgkIyBpW5bNfow0eLQRJWI6vYXLK+UkndR8vR5jNMdAftVYyYghDtU/I9zkqWcBHhTEOyulA25v0+SMRtPYqe3xpvjHbdELE4kapeFmvCGZOLAZa+ulFxNxQalo0R/ItoqijYx1TwxZokXFMWb9FP35Zz0G7M13l33ltSoYNEF0qyQKdWhFVvA4xQXR+R7rKt7igknnUi53gwzYSWtvmARVrqm69IeOohx8/uf/fQ8pXKtNnmW/LEwHyaQ+s0WysDj+OiCSTx+V9KsuhI5hMfWmlNKGSjBPU1OAB1VJvw9OKxkRK1P9t4Pr2jyIGbjlAYuDsNZJr0YsFO50Fz7lirO+ld5fordwFsjqk9LOwjSADBwRw+nmSngSfA4sVoBj8V9WZPQkDdg+sL0UD71vBZtdWds01gnLfJ1HNXBzHAG8yNmU2GLtltEZ2FaYBtPtYsZcOfhDielVdGOQnWNWF4wDb8vlWvcU4tRePc2uYcSoQD7ISnQNrlzHB2fYd2gViyE27+o8klbiIcIn48vLcvD2C64K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(966005)(54906003)(33656002)(6512007)(6506007)(53546011)(83380400001)(508600001)(4326008)(8936002)(76116006)(91956017)(66446008)(15650500001)(8676002)(6486002)(2616005)(71200400001)(2906002)(186003)(86362001)(38100700002)(66476007)(5660300002)(26005)(316002)(36756003)(64756008)(38070700005)(66946007)(66556008)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rt/HVUmifms/wv9OlPvC8rF49P7ttWkMvLe0DIeM5NbOkWNpzvjdMQX6U/hV?=
 =?us-ascii?Q?ekWoCyX5IndNuy6EpNWXq4lkAl9QHp2c/RtxKIvbJwg+Oj/+0OC8NmaarxIb?=
 =?us-ascii?Q?Q1fdiN1ZSDqCQyMZ+gl9LSLuFCPRq5GDvHXViWGYbLNFaZ7ZSEFtQAW/Hx9f?=
 =?us-ascii?Q?VvlBuaybQ546wCDJ0T2YZL0ej5lDEFDBcdfwGwrMoCAxCTiZi4d+d0i266pX?=
 =?us-ascii?Q?GE5zLdbm0zswsi4CR12PpOwEn4wY6KL/rqmKIf32ma5Q+sBvo7x9pcqwKolZ?=
 =?us-ascii?Q?L5ZJMmxnEOqDoTs5GjSoWBKzktxVrkBP+i29LUUUaIYvJXI61gzNGe1m225E?=
 =?us-ascii?Q?w0oCxwBBSwqL7EvTZDJWredUVyGWeorhxTNdWWHFiqCFMbRrXWHPXAhoercp?=
 =?us-ascii?Q?FD7q2D9g/5icgsA7gWZozcGLZM8JZHsZVG0u8p0t7VW5E6bm2+C+CUn8/L2o?=
 =?us-ascii?Q?oblAiTNH1erhg6Lg91ZSFrqXIMQScudAhonQz6IDiAjSCUuJkKhjaxcWgM6z?=
 =?us-ascii?Q?ArYrgSf1cPYe6gZGEmDIraWfP0m2LGpWK1cXFV5Yjs1JbntVjcWyhI4xaeLa?=
 =?us-ascii?Q?C1hgGLRRNnWazeiiDhGsqG7dM0SOu2YtREVfhvHlwHkce2yxR9R+Kjj2hgbi?=
 =?us-ascii?Q?FExKzSPa2DFpqlDm7kP8KxVPdDi1fvXDE8cToG5/qwDKipyvup3gcnUPfTvX?=
 =?us-ascii?Q?qqVVUW6lMl4aktMy9y6pnEsq6AqE958TrkbKjZjanYfRzjHvn2Sw92feAlow?=
 =?us-ascii?Q?xjBN7b1TvFinc/XgO4Mi6w4JE+NUGmuYcmMzB0ikP3sgS22tyAjIxC6l8rR3?=
 =?us-ascii?Q?w6KmzGvMXx0Dnu/UlgJmhPPxRdp5FSZWiXlNKtl+AnPTgX3ABy2kreVE7GaS?=
 =?us-ascii?Q?t78ypvAd6dMT/sEzVVtiLkD4bTJT3v5n+0GKiua9IV8eFbPpJWAHhcPdTOiI?=
 =?us-ascii?Q?VLZnSZbUu165k5EzWXrz23zgXrcmlq3bQHA/8nn0bmrPZ+WIscfU80ksZwQL?=
 =?us-ascii?Q?HaagOAXMfAjeWiv1DaHikfO3kP1PyLP8R7phbdDELdnIyDoxGuNBNXyMbAAA?=
 =?us-ascii?Q?s6B7QgDohrzw5KJv5QUzssi3drsW3LfNcq2svHvtU8FPrMKcniFFbv+yc0he?=
 =?us-ascii?Q?QcW/PolAHNsckcegGvHzr/eam5p9Lqlzt5HTpw4Ulm2gbcyE03ZxvhLws2Ps?=
 =?us-ascii?Q?uM6oKEeDiniKuMa3TaPhT5HuwSWRR5pJTv/FS24Js1U7ffYznNKaigjFqF9S?=
 =?us-ascii?Q?FxsdLP6f5CCraKSZ7k3pdgzhKLT0nYiW7EMEiRcyPdFk32ruEDD20UxJz4l5?=
 =?us-ascii?Q?W9/4OGQNF5mDA9HyBWOF9Yu+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC7A821EE01AF941924608B56A6CD0A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8ec62-7017-415f-acd5-08d981141c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2021 17:36:01.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fT+Nc1afM12+nEPoDiweGvK1hTDDbcZBd6pxobLAT7/Bl5t4cvqNFqSoHgIu6UPGezqOJcZiPYzI6FF+HYW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3046
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10119 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109260122
X-Proofpoint-GUID: bL4GcN0xA7vLHPCFXQQ3inbsQRU6GBXK
X-Proofpoint-ORIG-GUID: bL4GcN0xA7vLHPCFXQQ3inbsQRU6GBXK
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon-

Thanks for the suggestion! More below.

> On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kernel=
.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D214523
>>=20
>>            Bug ID: 214523
>>           Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
>>                    updates during a reconnect
>>           Product: Drivers
>>           Version: 2.5
>>    Kernel Version: 5.14
>>          Hardware: All
>>                OS: Linux
>>              Tree: Mainline
>>            Status: NEW
>>          Severity: normal
>>          Priority: P1
>>         Component: Infiniband/RDMA
>>          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>>          Reporter: kolga@netapp.com
>>        Regression: No
>>=20
>> RoCE RDMA connection uses CMA protocol to establish an RDMA connection. =
During
>> the setup the code uses hard coded timeout/retry values. These values ar=
e used
>> for when Connect Request is not being answered to to re-try the request.=
 During
>> the re-try attempts the ARP updates of the destination server are ignore=
d.
>> Current timeout values lead to 4+minutes long attempt at connecting to a=
 server
>> that no longer owns the IP since the ARP update happens.=20
>>=20
>> The ask is to make the timeout/retry values configurable via procfs or s=
ysfs.
>> This will allow for environments that use RoCE to reduce the timeouts to=
 a more
>> reasonable values and be able to react to the ARP updates faster. Other =
CMA
>> users (eg IB or others) can continue to use existing values.

I would rather not add a user-facing tunable. The fabric should
be better at detecting addressing changes within a reasonable
time. It would be helpful to provide a history of why the ARP
timeout is so lax -- do certain ULPs rely on it being long?


>> The problem exist in all kernel versions but bugzilla is filed for 5.14 =
kernel.
>>=20
>> The use case is (RoCE-based) NFSoRDMA where a server went down and anoth=
er
>> server was brought up in its place. RDMA layer introduces 4+ minutes in =
being
>> able to re-establish an RDMA connection and let IO resume, due to inabil=
ity to
>> react to the ARP update.
>=20
> RDMA-CM has many different timeouts, so I hope that my answer is for the
> right timeout.
>=20
> We probably need to extend rdma_connect() to receive remote_cm_response_t=
imeout
> value, so NFSoRDMA will set it to whatever value its appropriate.
>=20
> The timewait will be calculated based it in ib_send_cm_req().

I hope a mechanism can be found that behaves the same or nearly the
same way for all RDMA fabrics.

For those who are not NFS-savvy:

Simple NFS server failover is typically implemented with a heartbeat
between two similar platforms that both access the same backend
storage. When one platform fails, the other detects it and takes over
the failing platform's IP address. Clients detect connection loss
with the failing platform, and upon reconnection to that IP address
are transparently directed to the other platform.

NFS server vendors have tried to extend this behavior to RDMA fabrics,
with varying degrees of success.

In addition to enforcing availability SLAs, the time it takes to
re-establish a working connection is critical for NFSv4 because each
client maintains a lease to prevent the server from purging open and
lock state. If the reconnect takes too long, the client's lease is
jeopardized because other clients can then access files that client
might still have locked or open.


--
Chuck Lever



