Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2F3E4716
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhHIOBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 10:01:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28968 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234689AbhHIOBB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Aug 2021 10:01:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179DwbuE031355;
        Mon, 9 Aug 2021 14:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q8FJrWGHagG3Hn3nb3DfgcJ7/aW+A21zatb0VMakxCg=;
 b=lC39jHcebcfdgvN7gYeB/IJMwk6OFGr+3g1YtgeqvLwkJedtieBfkdbEeZkCHBK8yWX2
 8qHEvCE8AXR7hbNY9/rU8wSvdfIMTr73qAXujSSsJlAEdyX1IABZiSmBHzr6zw3Q+UFK
 jlbjxIDwBWZECIOKWLV3tmVKUNjbhdt/AOdXg3lbfeAhFce0CUZoBOQY4OaU3tSxdjqH
 RgcCv9AlqYD9V9yttuGNdJDjai9Z/ZSvYVk+yyUz7/epUsF4U19Ptz1r+rZuX6bTxINe
 pyeqFsaf9gfXVXspLbyVIC/59P/UajT0Y7kb9ZxL7ZyOLvsYMyQXkAEmLzIz2N2DZ+px zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Q8FJrWGHagG3Hn3nb3DfgcJ7/aW+A21zatb0VMakxCg=;
 b=V4tu9RaOmNsur5Wid+fFDgWPteLw7QSP7qSzTGJEvOqCDDBs9fTyoYhRG31WPcbhEaMe
 W+mnv01UwYJoIyUEq4M0Q9+IO6K78wSEBp0w1+wWvvvKGSQq41D4Lk0FMTO1wwDJctph
 PbHqsQQkTAksYgalzgLKsW3hElJaQ7W280m04yLwm/28Ps171pA9+Zgo6dmEJx7aQQq1
 ExHujsmC9ljxuTyKBzXgxW09bsmi8rQaDPgxd96LVZtlO6aJjVVNVp2Cho5kBkBPZjZV
 VGPDu1gyo9rqjmc5q1LirwL7U/tsBJOtZ46CaYU0DLuNsuhvQjnFI+VqrmHll/y98e5G Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fryhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:00:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179E0LeC093353;
        Mon, 9 Aug 2021 14:00:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3a9vv30xv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkZSl8S05uF6fgoSGq9j81zkS26JW6tglIbVgmQTE9BHvoxVmTxEdHLrMsd/TebRAPH4ahwukou58FjRDRb5qcvbe1fiyRgOK+EZrYj6oUCnLXwcF9GrKn1RB7G5JuXt8TtptHUuyeEq5GTPMBoRrsWYnLQKKhIvUHKEH83FAgBf2sNi6DGOfgYYN9uVs6uTHcIsXSAooluM7Hpbgv690m4Yo8xJJYbLyDI3/bO7ha6O3agy7eMzLDWXi7p+Suw+C0BmquOBgrXTocA2BC1Me0RhAw/9gBK6EH/Szw2qoIB1fsXyh7Y/LKRZMa//G5jSNCv4laC6fKmN5EuPsksFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8FJrWGHagG3Hn3nb3DfgcJ7/aW+A21zatb0VMakxCg=;
 b=QLWMEcCk6pJWJFZ5a8dN6zURqvsMHqdi2+iQlTg0+ozf2dZi1qdaJz5TydCttUyTyf5Rzbzy84/GAYRAoZlOcG4B4+/tikQ6Be1UzabnllQrgqfocBCNsszJMnnWGZ/A+2gjmuWVLbbizCJ4RvMOlAo2owg5Z/8ORmh6WlF0nXzhLd7LJIJEJT5LpQt08q3oWQmxGWjHBk02d6CIhAHMQZO8oefe3MDnWvJevFYQN85TDVFlBYuEEJa0WDsjKBot+2zvfhd0yA/mkuez1gxvQq34fngC8hQ55i9piB0+m7u0V1p5Al4xIgKu0dNpw/Ro3dJpQy89mUNfsNDla/WJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8FJrWGHagG3Hn3nb3DfgcJ7/aW+A21zatb0VMakxCg=;
 b=aE1h5520PrZbZCxxIR2/3flJgkSmjXQ95Y+EdgZu/Sj87Cq/VZ7RGWPbwLAPxJ7S1R8/d0JibMmc9CRjXszOfMsuT50dw5MJAKjojExDvicsqXneO8AvdA9gDCwkA9GZ1ypAlaPg+p37bcM5dKb+/YjO+svSACyijVXuXVfycc8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3111.namprd10.prod.outlook.com (2603:10b6:a03:159::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 14:00:05 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:00:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93QACMdPeAACJMjAAA1KQDwAh8caQAAAL6WgA==
Date:   Mon, 9 Aug 2021 14:00:05 +0000
Message-ID: <3DF0B3EC-4E95-47C6-BFAC-3313E147F5BD@oracle.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
 <20210728170540.GA2316423@nvidia.com>
 <CH0PR01MB7153AC0E62FCE1E9C4C82AD6F2EB9@CH0PR01MB7153.prod.exchangelabs.com>
 <A3297641-63BA-4DF1-886A-3620E2A40BA3@oracle.com>
In-Reply-To: <A3297641-63BA-4DF1-886A-3620E2A40BA3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203aa563-d613-440e-e67a-08d95b3dfdd5
x-ms-traffictypediagnostic: BYAPR10MB3111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB311127FA422FF01C2C64296393F69@BYAPR10MB3111.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kCZjrvlKgg+xmZHW9DbIjA5Jz7PRBHQSpq2FnHIIzsRLAo9Yt0XX++Nb4e0T8jof1ef9PnaEm+GbRRqNLgDMLYrs/jIn+RY3c0aQhLsVrzYbQdCWesjeKzndHANCy2Gun8lisep/sutISRl0VREL4pPDUDHCy/ARy7GkDhGR7DPYY5K85f3DcXLp6cG10mIO22BK5GCJAb2oAkV+OGuGAcAyZXx/SwiIHhefI5G+a+3z0zqOLKShLs/D+LJdV931winzzHSV4dIFlxeOOR65XMFyAARIb0ODJc3nQgPWo/7jiH7OBGKDc8f84Id0v6GCfaJxM/MoMTXgl6wnptR+bXu6ZVVaEc1IyB+s7XIqkM2/uTMXoheIHHdbGYCAgc54zp1SiEg2RnuhXHO76q/LHnsU1s4Lf+OZiTqmDPujVXfzOtdT54OYuGUU06F4SUuvVlLEAvDiG+vf4gu8EoyPzXLp+tfHUV4pfWH3RZF8tO3nM7G9NsDSiOtYG4G16HlBzlaKLFIK256nn4K+l0GJEZ2H6RE5t8HHozLFmKwWPhtAo1+H6bFsGzDLazCTnJ2xJ04riQqRyjvXR8twOtkfDpzqbzXpDoXHU2GhJ+ihstemmkU+6IYE2+ac6JCc34mxhLpPzGId1W6LQZrG/e443mnEQ5K7yzWz/RWts2TFpEoH/mxiV1b3rgQHxwUIDDLYidwaLQ3vdoHUYXT0TRswdUfUlG82LOPTNGx+X3h/xrneU75R6f2tn65QtyD5sNfFdHSwObOUbEAE58ibgVBGyb7XIg6zQhgCR19mT3t6aM1PvCCv5Eq2OMwap031MwetExylv92BbsE579q0VjAhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39860400002)(966005)(71200400001)(122000001)(478600001)(91956017)(86362001)(316002)(38100700002)(38070700005)(6512007)(4326008)(36756003)(54906003)(37006003)(2906002)(6636002)(6862004)(8936002)(83380400001)(53546011)(6486002)(186003)(8676002)(5660300002)(26005)(64756008)(66556008)(76116006)(33656002)(66476007)(2616005)(66946007)(66446008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InUgWj38qXtFYCdBr50R5aO1Bq2ktIFSjefngNaDdy03JzeSEttiP2RYuzzw?=
 =?us-ascii?Q?xSprpjSY5pDBgWS8KA0SSVIUtLWaaWpipqcS+N2QbSSk9EOPbKUlOqIHEGvG?=
 =?us-ascii?Q?H4ckHXFUHGbNq7l+boV6dce7LoHY+OWM1lsOXlavfDJQEHkWlq5ilb+TQY0b?=
 =?us-ascii?Q?T2lAkVHsfQW4NnmjYjc2L4DI9B+Pev113p94X3wncjBw8F2OmumrLhEOr9SS?=
 =?us-ascii?Q?QiDw0zOg3ecCkNNQ1Rl2VbAeYYFkFKS47IFnnfkDqZKaQGYhoeciHe61zn91?=
 =?us-ascii?Q?fgVz/USSxyy2K9DjyuvZfMryeeQrTWGkPDfPYeYowDDrxCVitvT/gVx+/VtI?=
 =?us-ascii?Q?/Fc5ZqKAMWVUI14MY1ToUo3JUyZzMbMLd03I9QVYzyo58Rc/0o7R/Ve5gJo2?=
 =?us-ascii?Q?7xh/ZSstXzbTdy/mRDE1YkYmwcFHXe3SGfH9mc7zjJXDQD4N+ASbZ3Es/e75?=
 =?us-ascii?Q?eXjO0DJbYMNj1faaWccYv2Aj9/4e5J/G5JaHaiOqpW4yBtoQ74ZMiCgOE0vP?=
 =?us-ascii?Q?8aWZ5PMoRbONDVPGCjYxE1vow75mnCF7YFV00jPZ50kygNPRgHBKJh63wBDO?=
 =?us-ascii?Q?TUWa+ptwRt1HGHB7RY3P4j9dBOWQRqy82Y/Z5nU54qS3iPvp6bAbjmzU/n8q?=
 =?us-ascii?Q?Gv6+/o29+nbu4XCsxRZOVIZy8kR0tebFedhdjw0ifbtTLmSsvw/zyk2HYTkE?=
 =?us-ascii?Q?s7qCRHoaiBgGRKXHa6Eq1tklbt0sPR0vIOVeTy+apuy6Yd58RksCAxTrNj5d?=
 =?us-ascii?Q?4eX9Dahh8pHtLhE4ydmK/5h9IKeoeArxIoPtQ60z4/EM8FpNyMfEiZahKOrd?=
 =?us-ascii?Q?roJq6TIEchOksP4ntt3HXq4aa86yf9v/2ZlRDw90Mx2A+dVGeZEwgx7dF3Gk?=
 =?us-ascii?Q?a/DWB5Q1YHG42gAxm7KfvEav9Vhh1JgwYdoy/OtVTj12ZBt9ZupOcUAj6UbH?=
 =?us-ascii?Q?HrO8Z6MsY1QCKx/bpHiRa2pN3z9nOn0xehsdA4cLJo9/nrt7f80V9/hlKi88?=
 =?us-ascii?Q?GVHSeHbSRRGkJ5lDD3FtYEa/X78e2q9tIycIwuvjAzzK9RsET0LGE/9Pi4sG?=
 =?us-ascii?Q?UiuGmYhyk+OFueFZHqEerYeaAC4nURjl/Em8JPUtlP2pzXIt92/NjOP0Tvgf?=
 =?us-ascii?Q?5szJREO8UnGFyDe2AvclrjkWYMWvWoP9C6BiRw7mCjRn/d1b6SP1TXLJ+CtH?=
 =?us-ascii?Q?W8YeRDZjNiMr+kaWrmvV1QdojFFYmbZh9L6jXu4F7LF9yYFHdpiBuZw2AzyD?=
 =?us-ascii?Q?xs5IPuJ1jk1s4PWVnvMsQ14lfzeSIgdBzy91aPIMsOiP5XklhAhvConLlD3d?=
 =?us-ascii?Q?R1F8cLc+Mr27oNJeZSYh50dnyuDxkPeAl2VlnXfMhx+hcQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC2C5A29D3D2064C9717C8B420D29D3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203aa563-d613-440e-e67a-08d95b3dfdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:00:05.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kqse9uemgHHrk5U+GKOF8Xpd1d4VrhZettbejNNwMSlSffTo3AWeXwzu84JzVg6llhMlstYMkFnUuyzwDetf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090105
X-Proofpoint-ORIG-GUID: uXvBjrd9_QryGNR_OfkRyWxqZWlloaSy
X-Proofpoint-GUID: uXvBjrd9_QryGNR_OfkRyWxqZWlloaSy
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Aug 9, 2021, at 9:38 AM, Haakon Bugge <haakon.bugge@oracle.com> wrote:
>=20
>=20
>=20
>> On 29 Jul 2021, at 20:28, Marciniszyn, Mike <mike.marciniszyn@cornelisne=
tworks.com> wrote:
>>=20
>>>> A test of 5.15-rc3 + a revert tested clean.
>>>>=20
>>>> Jason, do you need a patch to revert or should I send one.
>>>=20
>>> Please, I would like to hear from Haakon as well
>>>=20
>> The revert is https://lore.kernel.org/linux-rdma/1627583182-81330-1-git-=
send-email-mike.marciniszyn@cornelisnetworks.com/T/#u.
>=20
> Hi Mike/Chuck/Jason/Leon,
>=20
>=20
> Thanks so much for filling in for me while I was on vacation.
>=20
> Short term I agree on the revert. But I actually think commit dc70f7c3ed3=
4 ("RDMA/cma: Remove unnecessary INIT->INIT transition") is correcting an e=
rroneous behaviour in the CMA. But it needs more.
>=20
> 1. An API that has a call that has to be made twice (modify_qp --> INIT) =
is either incorrectly designed or incorrectly used IMHO.
>=20
> 2. IBTA is quite clear, that the transition to Initialized shall happen o=
n the Active side when a REQ is sent (section 12.9.7.1 ACTIVE STATES) and t=
he CM state transitions to the "REQ Sent" state. Similar on the Passive sid=
e, the transition to Initialized shall happen when you are in the CMA LISTE=
N state and you receive a REQ and the CM state is transitioned to "REQ Rcvd=
" state (section 12.9.7.2 PASSIVE STATES).
>=20
> 3. Performance-wise, the WR posting _before_ sending a REQ is sent on the=
 Active side (rdma_connect()) or before calling rdma_listen() on the passiv=
e side, prolongs the time before said REQ is sent or the server is ready to=
 accept. Doing the WR posting as depicted by IBTA above, the time spent fil=
ling the recv queues are hidden because we're waiting for a communication r=
esponse anyway. Not saying this is pronounced, but worth to mention.
>=20
> The problem here seems to be, CMA does incorrectly return a QP in the INI=
T state after rdma_create_qp() and some ULPs take advantage of it, it does =
not transition the QP to INIT state when REQ is sent or received as per IBT=
A, but has the (second) transition to INIT just before the transition to RT=
R.
>=20
> Should this be changed such that the QP is transitioned to the INIT state=
 during rdma_connect() and rdma_accept()? After the respective calls, the U=
LP is allowed to post recvs. This also aligns nicely with the use of rdma_s=
et_ack_timeout() and rdma_set_min_rnr_timer().

I don't have a philosophical position on exactly how rdma_create_qp()
should work going forward, but I agree that ULPs have depended on the
current behavior and will need to be updated if the QPs returned by
rdma_create_qp() are not in INIT state. I stand ready to fix things
up in the RPC/RDMA consumers should that be needed.

In fact it looks like some consumers might already assume the corrected
CMA behavior. Maybe the RPC/RDMA consumers can safely be modified now?
Let me know how to proceed if this is the case.


--
Chuck Lever



