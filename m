Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C270329EB4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403967AbfEXS7p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:59:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404122AbfEXS7o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 14:59:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OIwqEf025915;
        Fri, 24 May 2019 18:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bLhJULZuzMwxvwKVbALrmEFjxnPgEAH1OTEouZtc8ZI=;
 b=V+yUWxf5L0o3jeQ8VEoIMEUuXrFNb1ZBWGH+w9M2+cN/TbwmLwFSUQcxJXdDh8b/p28w
 KFb6Yz6c0qMNUFvWVT0XXkyiZcKxpCSfr1/SrT1dFh0aA71mJV+Ooccfj2Xl7TIDO0Pp
 H9aF0xYtF33dyhpqlm8/v+l+YeKn6T9ySrYcegx42Oo0+DVYMO+vOu63Q2hK1+VouTwq
 cJ7AEdZsaH8F4W25nzpx55hmJInHhZ8PxmxPs2wZNLbYDwA7nYTVN+x2XvSvRlIWvmm0
 eikzWIC+5IwVzU4swBjpIeotPfmM51bunYEiDKIcyHcp44wEaRwIav2JK6PXxcJwtagv tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2smsk5jxkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 18:59:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OIwFZT118626;
        Fri, 24 May 2019 18:59:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2smsh326n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 18:59:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4OIxcA5016318;
        Fri, 24 May 2019 18:59:38 GMT
MIME-Version: 1.0
Message-ID: <309e44c2-f520-4e35-9f50-5e6932d7b40f@default>
Date:   Fri, 24 May 2019 18:59:36 +0000 (UTC)
From:   Zuoyu Tao <zuoyu.tao@oracle.com>
To:     Gerd Rausch <gerd.rausch@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>
Subject: RE: <infiniband/verbs.h> & ICC
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
In-Reply-To: <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 16.0.4849.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here were the compiler flags used with ICC:

-trigraphs -fno-omit-frame-pointer -fp-model source  -fno-strict-aliasing  =
-mIPOPT_clone_max_total_clones=3D0 -mP2OPT_hpo_enable_short_trip_vec=3DF -s=
ox=3Dprofile -sox=3Dinline   -no-global-hoist -mP2OPT_tls_control=3D0  -wd1=
91 -wd175 -wd188 -wd810 -we127 -we1345 -we1338 -wd279 -wd186 -wd1572 -wd589=
 -wd11505 -we592 -wd69 -we172 -Qoption,cpp,--treat_func_as_string_literal -=
mP2OPT_spill_parms=3DT -wd11505 -wd411 -wd273 -ww174    -we266    -ww279   =
 -we589    -we810    -we1011   -ww1418   -strict-ansi -wd66     -wd76     -=
wd82     -wd94     -we102    -wd271    -wd424    -wd561    -wd662    -wd151=
1    -std=3Dc99 -ww344 -we137   -fPIC -mP2OPT_tls_control=3D2

-----Original Message-----
From: Gerd Rausch=20
Sent: Thursday, May 23, 2019 11:15 PM
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-rdma@vger.kernel.org; Aron Silverton <aron.silverton@oracle.com>;=
 Sharon Liu <sharon.s.liu@oracle.com>; ZUOYU.TAO <zuoyu.tao@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC

+Zuoyu,

Hi Zuoyo,

What compiler flags were you using while compiling the <verbs.h> file throw=
ing the error about 'enumeration value is out of "int" range'?


On 23/05/2019 18.30, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 03:57:29PM -0700, Gerd Rausch wrote:
>>
>> error: enumeration value is out of "int" range
>>          IBV_RX_HASH_INNER =3D (1UL << 31),
>=20
> I assume you are running with some higher warning flags and -Werror?
> gcc will not emit this warning without -Wpedantic
>=20

Perhaps. I've added Zuoyu, who reported this issue to this e-mail thread.

>=20
>> Since "int" is signed, it can't hold the unsigned value of 1UL<<31 on=20
>> target platforms with sizeof(int) <=3D 4.
>=20
> Pedentically yes, but gcc and any compiler that can compile on linux=20
> supports an extension where the underlying type of an enum constant is=20
> automatically increased until it can hold the value of the constant.=20
> In this case the constant is type promoted to long, IIRC.
>=20

Evidently ICC supports that as well:
% icc --version
icc (ICC) 17.0.5 20170817
Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.

% cat foo.c
enum { FOO =3D 1UL << 31 } foo =3D FOO;

% icc -c -g foo.c && gdb -ex 'ptype foo' -ex 'print sizeof foo' foo.o type =
=3D enum {FOO =3D -2147483648}
$1 =3D 4

% cat bar.c
enum { FOO =3D 1UL << 31, BAR =3D -1 } bar =3D BAR; % icc -c -g bar.c && gd=
b -ex 'ptype bar' -ex 'print sizeof bar' bar.o type =3D enum {FOO =3D -2147=
483648, BAR =3D -1}
$1 =3D 8

I can't say that I'm thrilled with this behavior though, as it appears erro=
r-prone:
As soon as an enum value goes out of range for an "int", the type silently =
changes, potentially rendering structures and functions silently incompatib=
le.
It's quite the pitfall (e.g. the foo.c vs bar.c case above).

>=20
> Can you clarify if icc is being run in some wonky mode that is causing=20
> this warning? AFAIK icc will compile the linux kernel, and the kernel=20
> makes extensive use of this extension. So I think the compiler is not=20
> configured properly.
>=20

I've added Zuoyu to the distribution to shed some light on that.

> IIRC I looked at this once for -Wpedantic support and decided it was a=20
> lot of work as there are more cases than just this.
>=20

Not exactly shocking news ;-)

Thanks for providing the information,

  Gerd
