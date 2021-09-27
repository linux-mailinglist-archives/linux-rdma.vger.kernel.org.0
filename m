Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9D4198B2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhI0QQa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 12:16:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51446 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235337AbhI0QQa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 12:16:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RFYAPN030092;
        Mon, 27 Sep 2021 16:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C9M56MMxz9t0XoM5lWHBX1fo2jr3/0UFDmQYWofqe1g=;
 b=pqo0UCVtKsr0URA9JiW/y2iQhhYo2ryyAr8mjhjLIfET8PPtJbOWcHkHTTKVwyWnsrZr
 sGy62nQScfyWow5iXQ0eOcBLntmOPAgJvuddrRR7Gg9DJXifHU+dZZtUjp3GcnF+c/pI
 PmiKeHp6rlscTfW9Ox1TRENl9bkh1rcSe2pjSSx+jBQZm5TvBHFr3Sd+Zzm2N4YBHCTH
 tTZFMYtB7TnnW1UEQ5YXsvD+baGi07GK4ZRC1Dd1zgccIJPquQLrWvdcXswVZbHyb56c
 T0XszGSn1904DYuw8PWM7Dh8ese9UkgK3TGPN206/IpHR8z9PplXq7XVzhBxegXt/dG7 Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbejea26b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 16:14:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RGBHDA033082;
        Mon, 27 Sep 2021 16:14:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 3b9stcs2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 16:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkGA7xa1YSMYcSfB042i6AjPxgJQahgXzOXcwD48oDliwn6azOwmZGHlFnvxtQ++2jd20oGbkdwQJsUAcTY9SUAzBQabpbf9BneBm8xCvpmCjBarzPz7Up/XmRUWMsA2sAlQ+YeEW/GYQXeDSTESH3i98S66C9SYB0NCW+I8gQdE/devIbJldBxPLyGz0vTH0ARpMexvdVgXO1kuDqla+/UI7kuZVRwlrd4nbYGcoN+hhS/SF34UrrrT1Zm9Kr6SH4PsR+dRdr8uYK+DqrEUqIQDSb1Pv2nUjB4MugGpDHwN0ZrA+Gjt1HTk5zu4D16Thkw8ayDWfw6EWEx5MxwAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C9M56MMxz9t0XoM5lWHBX1fo2jr3/0UFDmQYWofqe1g=;
 b=AQqUkHwlhFQIe+2UvlvISHcUV1z5tmP4b/+zEHMYOB/8jw4sU05q4ZE02zOsPFmdDBrb7xcRj6q9rh+VLmeaMysLkRQUlDLFqq98pg+nYO0Xz5CHgJoIR3lsBnUCAKCYFut8GXPHGB14WJagA4yNOVl/mxIyae4F0NN/tP0AsKoSx6ggYePurX6/MYfJDp4bDi4HNNSdUy+pFUdeawBUEW9gjzCx5LGCTz44aRqfszTiNrkCNDSKgIRwQQepcDNqpkcJVjjCHIGtwudCD17dTxvCEElpuw1mJ76pslelFQLh1UpiKU6HwF6XYdXCYaGFSmJo1vBdiSC8NvEhLx/HDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9M56MMxz9t0XoM5lWHBX1fo2jr3/0UFDmQYWofqe1g=;
 b=ie3GpUmW5kgpdDDWGd+J9JS5zBrTDVX7c8xBuASL7L5ZqaegdkhNCN7lzKB/4N1DUc1IQEMqj6qEwkxNP/Mo9isNJHWX3jTYeX/lDp/Uv08jkEgsB3ccxGzxD52xuAiiPGixXwX51KeKnVgeSRcZMuTwSNdimCgcDul8fg0XYac=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 16:14:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:14:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Topic: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Index: AQHXsVmwbSiP3NBTSkWByRHQxitaiqu19wMAgACgO4CAATcrAIAARGKA
Date:   Mon, 27 Sep 2021 16:14:30 +0000
Message-ID: <71F17C4E-FA6E-4806-9599-A4241337EE5F@oracle.com>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal> <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal>
In-Reply-To: <YVG0iI3dSdP/6/1J@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db95f711-36f8-47b2-f2fe-08d981d1e2d8
x-ms-traffictypediagnostic: SJ0PR10MB4510:
x-microsoft-antispam-prvs: <SJ0PR10MB4510EF31BC15DCF212D020B093A79@SJ0PR10MB4510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNbMCGcWed+UYrF4q1pr5GteNVfUwIcArF81Y5DWEDN/sPwSFxdFFVquwoO0pOe55abweTEBo5XRU0MREwye1D8LrXQWiJc58MNpbVojG24qDFqoNksgSIRCwTc1Nuj63bP7K6SkjqRNKvHNmrZqW7hu6UQ3+IZImix8eflv0EspPukCu9PNuXcL+lvaAqQRK3WY+Kn1pUXmcXB/Q5wHi7Qs3JWru+qjQ7P2d7ET6F6B7rBYMOnh9A6637kdYgYhhkssLyA4YAs9zpvtesbgN19hKSFUk3PrkEC3j17kw9yUjNIsHk08a211C/Ll8kkJWE5c5d2vCtvQJE/x9cbwFxfGww7xsf/fiEUjlSJe3YRF5hUpmHusGWWJxAw7YlLe9dfsKptblPk6aKU4MD/fZzmP2sDvsTCY2F2p8Y1bvL1JtnoLd2wuNPr1Ehedd8tFZQpbUsb8iqMdJA9jyS/lYyGsxYnU3i7lyNQdYOIn19gMD16/BxLYdQ/OOOcu6S3WpdXBRTo+4G+8+UEMWNFw4+VhMLZlFOGiKVtECyoUVPTCDdd39X+c6lC+IbbDlWF9EqfX2zQI6WUC5X7FSQsMXYY+qjLvaFgGnljZhUzpQb0gcNgyGSpZsdDWv43usRLjm5j3bF9KSqQIdEcffEfn3xqwV4YdpxvWihnYGjH7m07RqlBLWC7YHjG+A90uVOLgkjahdgdIqwWABRUkITzkAM74eG0y0nnR+YCyh1pfG54xLjD+t+k7HjvAcV5vZNNn/W2c1gCMqHuGpEbR6p1NVKim0DeWsyuSE/LwuHdM1Tb6n0b83YAEKOodmLIdsWS7mJdWoFWjsA+qy1glcM+afA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(38070700005)(66476007)(71200400001)(8676002)(83380400001)(6486002)(53546011)(2906002)(66946007)(6506007)(66556008)(6916009)(2616005)(66446008)(36756003)(6512007)(26005)(5660300002)(186003)(86362001)(122000001)(508600001)(38100700002)(54906003)(91956017)(316002)(76116006)(4326008)(15650500001)(8936002)(33656002)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CgBDvYX35lVhDiErBw7wuRqJF3OPspmeRglZXeXe7UsEWN0kdlZ2waKdW2dl?=
 =?us-ascii?Q?1b6KfDbdeBPqLmO1ibKREuaUvgEZRGpimyGqdqDIHe3vRT6LcEq6YAeCBucV?=
 =?us-ascii?Q?jaanrF8RW54ANOhm2+wq2Wws7/W3sLaoE+mqwpvEHxOdNr7Hc1RPrGSiszNj?=
 =?us-ascii?Q?fdu3We4S1XWieAuCswrw1J3JsfHw8Lx8gMWAmfPcEqX0Rr5Rh2i6wJm4Fh40?=
 =?us-ascii?Q?zt/ZF7zhe2+GDxPEkhKUj6MK0l44kQ2G4TPgmZtzQovt64TNUuhdgse4cyTW?=
 =?us-ascii?Q?X5iH6Xw4cv8myz9LreJ8MWfq1yeIn9KrSMsNesJCMSdlu/IndGQT4C1hvcz6?=
 =?us-ascii?Q?p79mKoUg+zIzQXFhEaULgDJHTsbSv9q/3DnK6wApuBNX/mU8XintzmQQ+297?=
 =?us-ascii?Q?RKhd+pa8FWQ5NUpwTOIfNqDlYkWoejXE9K5ryGfMfIkkEPOEI8frLBKbEUo+?=
 =?us-ascii?Q?g41Xlxbwy2xrz/e2czWyUD8rUCYGgQPyN/wUcSQ+55eYEHTP4L+zGC8YLXu+?=
 =?us-ascii?Q?sx45OyITgSDpb5iTt8xK8sAmIzqW3Alx4Z1PgtJxstmVoKHDvxQwLiR6K9qV?=
 =?us-ascii?Q?/FT5PXS2yzcVn97SEfNl+T9pD9D4GgqRwRMHKMz30p1kDq859wm4sjdE+t0K?=
 =?us-ascii?Q?YExKmrp+sBkou8FHOUPnyiXU0uqU+hEI3lda4hQeEFcnHVzB5VlC7dp7MYMt?=
 =?us-ascii?Q?LUQEr9uTh9wzDYZJNpLQe2F1EuVpoIU4fNHdoAbOfyoHwZOg8NmdvuATUvAI?=
 =?us-ascii?Q?BIlUBunUgm+rk6Ydz2DGI++EpAM1fpoL94OcQa7WzvNucDGOLvg6yB1V55sE?=
 =?us-ascii?Q?6TvfatrA/BDTw1STgKJWidxg+8ThKvhxLhn/ILVlW+KBflNqr3qqKdf3idO5?=
 =?us-ascii?Q?nAqL58rgmEMuaJ1yvf597S7Jy8yaGSTjQl+hUEEAYtYv+zK0q7JaRASeCE1V?=
 =?us-ascii?Q?EReXTiPEUC2IBm2Ky8TMXnRvs1gmRT8yfSJUKzlKFm3g0UOYFYZh2MvDStVP?=
 =?us-ascii?Q?2aMGGv3UkmQ7IHucERjh1OCVY5fNZQC2gk2LLTdjPOWti4SC/Crn0rvBRj0h?=
 =?us-ascii?Q?aciVHbhRpbdG1hRPkezworf5Q+MzGViit84DFVRIvL9lgwrQl+6vJ69rFhha?=
 =?us-ascii?Q?+F6IYW6P1ZpZ/qEvM1fiCKMLXD6X+nXOVzcbAdKOgPR+UNxM4OYByTglDu9+?=
 =?us-ascii?Q?NZJWkdIP4JyQVYsxEfrKWBz41/EehtXcxlD6XCVkPKgDhii2jofxhVbMbOBA?=
 =?us-ascii?Q?zfGPelX3j7jD/ERre4s7M7cb/XYAFHJgscNfpmelRPhuxoh1UkwAqoPOeP7M?=
 =?us-ascii?Q?OO/XXp/zkfmJC5eGfSbb8AdB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C40AAABC8AFBCC4E8CD81331D5CFA8C7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db95f711-36f8-47b2-f2fe-08d981d1e2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 16:14:30.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9WiRA36kscPczxSrR4+ytgMGDdi2GWqZ12KWqmZLTBSGDAKaN566u4TZk1FkkXLR65V8K/M4cSjhpW2qa0oWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270111
X-Proofpoint-GUID: rE-m83RUnYThaTpqA37ocl190rrJeaui
X-Proofpoint-ORIG-GUID: rE-m83RUnYThaTpqA37ocl190rrJeaui
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Sep 27, 2021, at 8:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Sun, Sep 26, 2021 at 05:36:01PM +0000, Chuck Lever III wrote:
>> Hi Leon-
>>=20
>> Thanks for the suggestion! More below.
>>=20
>>> On Sep 26, 2021, at 4:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Fri, Sep 24, 2021 at 03:34:32PM +0000, bugzilla-daemon@bugzilla.kern=
el.org wrote:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D214523
>>>>=20
>>>>           Bug ID: 214523
>>>>          Summary: RDMA Mellanox RoCE drivers are unresponsive to ARP
>>>>                   updates during a reconnect
>>>>          Product: Drivers
>>>>          Version: 2.5
>>>>   Kernel Version: 5.14
>>>>         Hardware: All
>>>>               OS: Linux
>>>>             Tree: Mainline
>>>>           Status: NEW
>>>>         Severity: normal
>>>>         Priority: P1
>>>>        Component: Infiniband/RDMA
>>>>         Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>>>>         Reporter: kolga@netapp.com
>>>>       Regression: No
>>>>=20
>>>> RoCE RDMA connection uses CMA protocol to establish an RDMA connection=
. During
>>>> the setup the code uses hard coded timeout/retry values. These values =
are used
>>>> for when Connect Request is not being answered to to re-try the reques=
t. During
>>>> the re-try attempts the ARP updates of the destination server are igno=
red.
>>>> Current timeout values lead to 4+minutes long attempt at connecting to=
 a server
>>>> that no longer owns the IP since the ARP update happens.=20
>>>>=20
>>>> The ask is to make the timeout/retry values configurable via procfs or=
 sysfs.
>>>> This will allow for environments that use RoCE to reduce the timeouts =
to a more
>>>> reasonable values and be able to react to the ARP updates faster. Othe=
r CMA
>>>> users (eg IB or others) can continue to use existing values.
>>=20
>> I would rather not add a user-facing tunable. The fabric should
>> be better at detecting addressing changes within a reasonable
>> time. It would be helpful to provide a history of why the ARP
>> timeout is so lax -- do certain ULPs rely on it being long?
>=20
> I don't know about ULPs and ARPs, but how to calculate TimeWait is
> described in the spec.
>=20
> Regarding tunable, I agree. Because it needs to be per-connection, most
> likely not many people in the world will success to configure it properly=
.

Exactly.


>>>> The problem exist in all kernel versions but bugzilla is filed for 5.1=
4 kernel.
>>>>=20
>>>> The use case is (RoCE-based) NFSoRDMA where a server went down and ano=
ther
>>>> server was brought up in its place. RDMA layer introduces 4+ minutes i=
n being
>>>> able to re-establish an RDMA connection and let IO resume, due to inab=
ility to
>>>> react to the ARP update.
>>>=20
>>> RDMA-CM has many different timeouts, so I hope that my answer is for th=
e
>>> right timeout.
>>>=20
>>> We probably need to extend rdma_connect() to receive remote_cm_response=
_timeout
>>> value, so NFSoRDMA will set it to whatever value its appropriate.
>>>=20
>>> The timewait will be calculated based it in ib_send_cm_req().
>>=20
>> I hope a mechanism can be found that behaves the same or nearly the
>> same way for all RDMA fabrics.
>=20
> It depends on the fabric itself, in every network
> remote_cm_response_timeout can be different.

What I mean is I hope a way can be found so that RDMA consumers do
not have to be aware of the fabric differences.


>> For those who are not NFS-savvy:
>>=20
>> Simple NFS server failover is typically implemented with a heartbeat
>> between two similar platforms that both access the same backend
>> storage. When one platform fails, the other detects it and takes over
>> the failing platform's IP address. Clients detect connection loss
>> with the failing platform, and upon reconnection to that IP address
>> are transparently directed to the other platform.
>>=20
>> NFS server vendors have tried to extend this behavior to RDMA fabrics,
>> with varying degrees of success.
>>=20
>> In addition to enforcing availability SLAs, the time it takes to
>> re-establish a working connection is critical for NFSv4 because each
>> client maintains a lease to prevent the server from purging open and
>> lock state. If the reconnect takes too long, the client's lease is
>> jeopardized because other clients can then access files that client
>> might still have locked or open.
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



