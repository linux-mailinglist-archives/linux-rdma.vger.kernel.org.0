Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85547A1BA
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 19:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhLSSTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Dec 2021 13:19:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234077AbhLSSTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Dec 2021 13:19:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJ9sFoO031810;
        Sun, 19 Dec 2021 18:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ls5BSNa/Ep/O6oDqZmF2Jty4+l4y8IsiseY10vjBPtw=;
 b=PHypQ2wLk4f7ObvMwsJytcNG4j9vX9D2uWw0nZJGdhGgP4Bjvpz/pKtqRN+vbtdKt0mk
 gOFtQQrxqLA3t5JTyOaTt2y5Tvr6GxRCzoaMh5fdBtzoLRL512S5yjmdx/t+LTh4rqyD
 rDnpkgBXuoF8PFBIWH0sAE9yAYiazfFfJsfGMBMoP+/qgRmzdbwB14nTIJtvtfcRw5sY
 3pbhb6wnZ1OZdjuOiVoVh1HgoDQyP9+UW4nB+0JK/8Q0vgzp97olWwG5v39rblKXKG5d
 1Bh7k1J8bmi1taWNvAL3RzOsc9QpWeHAxXnrhEq5JgFbxesYX4VO0tSljvy/DaXmE8q7 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d186ssw8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:19:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BJIAUrP161671;
        Sun, 19 Dec 2021 18:19:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 3d15pb465n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ+Qx02M3WRZrTDslhJ+A/ZwqktV7POsd1LQTY0q0NsrPffEPIIPW0ipNQH7CnLx3N/SyB7KOUoP9kHM6ZIWBxqQi81PC4Q3NXqTS/Nz/muaICsTFt39IL3HP7bfUOLXHg/fvfskvSmYKtefU7e5jfhBKaPpzVPAqhgh0kw+dU0iQcJUv5abbauBN6Taf7bzIj6241prI1nIl4xg9nZ9WOuN1AYloREplLkri+YxOlbvNL2z0hkj10TRh2PHZWXkkrTeTrccmhUW8/LsX3pUkkZo9wZCzk8ojdAmIbSU+9KyW6BJxf3lM3jGtPv31b4GMJ4O4EKVlHAhPoRuBn7L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls5BSNa/Ep/O6oDqZmF2Jty4+l4y8IsiseY10vjBPtw=;
 b=YgF7PNkPLyKOuKDKCxbbKEsP1eA7PdY/z1b6G8dswAICcRHlTVGMFfZqHFLUWj2Oxl/HEh5SizrUTcM0LKjTqx0oWqlK3RZlD0LNRIJ3+fMfWwypFwo/ipYIt0kUvsO38zShnhygK+kd8gMPSdlpaIGbvtmyyMO8/BeY27zDEvAltT7WgKsfdb5+oYb9cnKmeW+T6cdDH8AmcuMk6Qvx8bGz+jH1nO6xFxxUnvIW2xwvFb6oZJZukOVNhV+JNWpU3SyoUDWGxXyz1IJdDPwhOGwukAJivGEZ5BqiUVf2+cYjEXJPVIv7obhm/RvdAc+Oh6Y2YLaU8g+pIPCCjNCh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls5BSNa/Ep/O6oDqZmF2Jty4+l4y8IsiseY10vjBPtw=;
 b=xi8ZWq3dE60/moLosqLMZCbpHVj2H8wUAa00HU6hWy5j1sphX4z15oWmlJF6w48SF2RZzGPlPd4Xyc1+twhLjpT8orDSumzVEiEkx4l91svaLiiwM/ngsalMpjaOOWt9cs17g+6TiYeW9GiPiVen5y/I7U/4RIsFK8G0Goey2Y8=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 18:19:09 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 18:19:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Maor Gottlieb <maorg@nvidia.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
 dereg MR flow")
Thread-Topic: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
 dereg MR flow")
Thread-Index: AQHX9FXC3tbANwqs80OrwY52vatSbKw5kzEAgACN9gA=
Date:   Sun, 19 Dec 2021 18:19:09 +0000
Message-ID: <C479500E-BED6-4ED6-9C4D-510D6AAE11D1@oracle.com>
References: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
 <3fa317ce-e0cf-cfce-c4f2-8940ba546b61@nvidia.com>
In-Reply-To: <3fa317ce-e0cf-cfce-c4f2-8940ba546b61@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c92ed0c-f7cf-48fc-5f7d-08d9c31c0cd4
x-ms-traffictypediagnostic: CH2PR10MB4247:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4247F600B32354F2A3FD3BF4937A9@CH2PR10MB4247.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwqjtcQGcfRxfVF46r0vEUJNW3wrfyCFMj1yO29TCPx6zrpFFz/DdppgE8yTYGU1dNVli3s9oNiknAqVumFWayjmTmCqvfOMZHSbC/ILQNgKtncY3vMbuRUCVcoq/rpWGFrWn/mWTLX7u6c/v5oC6XW+vBgCbzTW+rna43+L7khrranIj0lV1FeWwzVAkn1o9rbHSIjazXxkV8lH+3rNKrz3+s/FARWFNlVKKqOeTlpcG8Bf0ojHN2W3HC00NY/fdk+PLRe9RJpo5SS0CN8tSaRYNpL1gB9yEBdP4OiaAD5HY89kklLwpCjaLEIoSw+eEYptLvn4bGN8eJ9KUX9sEDdsmRgrp7ciMU5/jpPu6y/2CQaJXWq0YU4IM2BS0o4vY+W6ICCc9DdU7G/5JCtmpQ6msgXuQ1Q5z14VttvjGRIGHA+mFdfgpdt07DeLkFUEFTz7mcVO8hojn+deFFhFHzL1UPJr2eKi44qa9fXFbXoZC/uuEeKgiepqJRBXEz+b/83tjWjE/L/3RUpUs/sPvGutFeMs2J5cqU2UtHkAgaGTSmdcYEs0x1wen0WX6jeey5IqMCj72b0G+oa9doFlXz9wUN5i1N1rLoi81x3KM/MNsqmvrSKT3YltH2KLdse/Lq41v98frxb9k+IXzWJkSjp4fqSrMjKf1oDKUVsjDuVxlcahC5u0i0mRs8HP+kiyI4E0bK/+mrWWdrXZTSWSnjH9/2fSS4gHc7y76w0RapWM7cHDtn6mE+kCleMQYkS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(36756003)(122000001)(6916009)(33656002)(2906002)(2616005)(38070700005)(83380400001)(86362001)(5660300002)(71200400001)(4326008)(6486002)(186003)(8676002)(26005)(8936002)(316002)(66556008)(53546011)(66476007)(6506007)(66446008)(6512007)(64756008)(66946007)(76116006)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?363I/s8nK6fqVBYna6k325UJJndYISI/RuWJ7/JkIIQDFESgNwJpRQC8qMKX?=
 =?us-ascii?Q?V+tiWDRXWC2K+XCgM3kga8JRFtuqjzow1dijOI9+XvIfCTd4xKv+EZkIvkTr?=
 =?us-ascii?Q?MaNMzsU8eTwtdnlK7CSnxMXgzNXf0TIWBZH2UOjUea7HOnwGsUr2wRcJOiMM?=
 =?us-ascii?Q?LM7Phjr7ajYS9KYMWxhpp98OS1tbYU7u2UaZGc52NacktwUlQQD3Yk1nUaoJ?=
 =?us-ascii?Q?gOfK7OZcYwgbnMJwjvj1pnEyhu6A/r1i96udyK+YI3ZW75F5CJFjVYJwi4fV?=
 =?us-ascii?Q?FoGk1NmLsCyFqpDah4uHNzIX2ljyr2lfyXAtA0msLUaQEvKInykA8pSR/w2Q?=
 =?us-ascii?Q?s3kGEEKij6EesK7uswNkMjrhYHQs1pqN37AgtXQBQ8hTXXdAyLfvNfphCU6R?=
 =?us-ascii?Q?91Fe7cSKkHMoH0HF5omcZURmtMfybb/Es9v24inMGE66nML0KAXU96/wOvfj?=
 =?us-ascii?Q?fu37hTso2I4+bPyb/106FvqI+ELcWSrXKI/BQVKR5RpB4mflPrj3O2j2jPLd?=
 =?us-ascii?Q?1+Q3PpL4JGzuiQ2yTVtRePJn/wqUR5iw3Z60eOqVHg5T9J2Kv52WACN//5mR?=
 =?us-ascii?Q?oqI0ZldotBOZiKGoA0i71HfH8K4G/xKY7Jia14J7ML1Qo5GwxACHgVrXj8FU?=
 =?us-ascii?Q?QvznnOhiZBjJei26tGENafeHBsQQin4XPXL0y6JTQDsndNOHG5K7qgxYaz8A?=
 =?us-ascii?Q?+TZyYxYgBV5IP31utLU+djGTmROYWA2nLddwiTCRcT6eANQunsB2CQIVWv9a?=
 =?us-ascii?Q?dC66DQOadvZ7b3H2EbEryWV06namlJhb5sCgbQqRaMWLgaEQxBW6T4YIE5tS?=
 =?us-ascii?Q?G2xNohnHSGrcsXawdrGdTk0hueQHYlAmOs96K4tS/8KuRwNI8iKINaRsHkhr?=
 =?us-ascii?Q?FsFM2GQ25R/bHRle6OOTpXD1GKOu9/h+ND6Vm9aWZI5hgcoaRlxh0Y62VcHZ?=
 =?us-ascii?Q?c1v3PjRVmkp9X1rNlmMGLShd1LthiaPS+4RE5oBmTesmLD0Fw9WMAODn/8aZ?=
 =?us-ascii?Q?pfg/rP9KYjPBRaVqIhpqTpL+1zMeDVC2CEVhPl673m94WAlo2C4QbYHUsEyB?=
 =?us-ascii?Q?Iti8uvyLJ+Yhpr7Deq4Wkz5iRGGEDqD5HfgeF7KxZVQ5rqt4ncnz20Ltpi0J?=
 =?us-ascii?Q?DhQ+RYxswrPLix03pl4vMECIaDG2IJsaKLaQwNfwP5jmapO31MDo1rbAekBe?=
 =?us-ascii?Q?LOdK3Z7TWCkEOJEW7VVYEYx6N594CzXmhCGGIsfts+zfqq+fEZB8TzUheiyT?=
 =?us-ascii?Q?4aZzaSwYATS3NGCFLjuawh5e2wYsIiKdSwHrAdaS+MKd5fF782SqchAJv/Lo?=
 =?us-ascii?Q?+wD4GYzBDZLkJ4VykwaSO6FYhvT+shhvIaJW8zDIXM3cHLylFQKvjqfFzCJC?=
 =?us-ascii?Q?V6bNWs/65aICq6rBvhtY7/fNsrmMp+xyHvb6I+8aRroqZ4+MjwRtCx1Fqjb5?=
 =?us-ascii?Q?X8YaPXlWkNGT+omW2bIqrtDPOKUmH1FIYsn4If9bVkB3OA8Dl/PPPUxI0pTI?=
 =?us-ascii?Q?+x2pVOfKLWP1ICVOuPJl8v50CqzE+ipwS0oMQU0PVEWONwsC13TsoolwC3Uu?=
 =?us-ascii?Q?Djkc/Qg5dub1u73nwExXuFYp5k8lSCO1uL/0l0M75OENqNKEDZGcv1AIucZ2?=
 =?us-ascii?Q?Cmk6nuJmcYA1nhvMqBvC9o4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17917E473F0C554B8E6597039F6E720E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c92ed0c-f7cf-48fc-5f7d-08d9c31c0cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 18:19:09.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVzXDaL+vCm1gpuLvc6T1rqXG95oql+sVIpew5esz8RiFmwS6LZK6R/iM3yI5aPyD8Yp8aJFykgAmFsL0RDlVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112190114
X-Proofpoint-GUID: OXPH9ihwfSj9Bb2RqqHQDBntL8lfnOF7
X-Proofpoint-ORIG-GUID: OXPH9ihwfSj9Bb2RqqHQDBntL8lfnOF7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Maor-

> On Dec 19, 2021, at 4:51 AM, Maor Gottlieb <maorg@nvidia.com> wrote:
>=20
>=20
> On 12/18/2021 11:25 PM, Chuck Lever III wrote:
>> NFS/RDMA with an NFS client using mlx5-based hardware triggers a
>> system deadlock (no error messages) on the client. I bisected to
>> f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
>> dereg MR flow").
>>=20
>> --
>> Chuck Lever
>=20
> Hi Chuck,
>=20
> I found some bug in the cited commit. Can you please test if the below pa=
tch fixes this deadlock ?
>=20
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 157d862fb864..3cb4e34fe199 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1978,7 +1978,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_=
udata *udata)
>                         return rc;
>         }
>=20
> -   if (mr->umem) {
> + if (udata && mr->umem) {
>                 bool is_odp =3D is_odp_mr(mr);
>=20
>                 if (!is_odp)

After applying this one-liner, I am not able to reproduce the
NFS client system deadlock.

Tested-by: Chuck Lever <chuck.lever@oracle.com>

--
Chuck Lever



