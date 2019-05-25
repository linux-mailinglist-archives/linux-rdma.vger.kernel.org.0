Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED682A216
	for <lists+linux-rdma@lfdr.de>; Sat, 25 May 2019 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfEYAWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 20:22:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEYAWS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 20:22:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4P0Ihx9043620;
        Sat, 25 May 2019 00:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : sender : to : cc : subject : references :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BZLkG88/rpbKWV3c9e0DsG1TPHe+UfFr9uJsJcunxds=;
 b=PO+QyZCVRu1PIkGmw4mmEpOsk743Z4Tc/mQj5IWtoEV8fgGWauc8G1EqT64Z+MP9D/+U
 Gu57Dnk8fzYI1JwENvE4NwD4Gn/3oTN1ARWPieLF3rAiUc3AAp4BFITFRheH1DZogFRB
 KUG//n+3MS3lMFvAsllvgRDbG65qZpBGUwBlayqsOQrd8b2cZ10wGbGlt97Gr2fHFNHW
 84KieRy7CimyO6rgf05yREpAnM6D3pNBoSR9rkgNSV4LEGiD3jU/de1aT1PJCn5iJV8X
 NcYvnRDv/eBi5MQBwnOZwmnIQ101mJADX9mE+fWwd+8SYy5mwT7e3Fztd9mkkHWREW3o lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2smsk5kthy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 May 2019 00:22:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4P0Leax069274;
        Sat, 25 May 2019 00:22:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2smsgu4uk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 May 2019 00:22:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4P0MCsV004622;
        Sat, 25 May 2019 00:22:13 GMT
MIME-Version: 1.0
Message-ID: <249b6ede-bf1e-4d33-aeee-2f177d244495@default>
Date:   Sat, 25 May 2019 00:22:10 +0000 (UTC)
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
 <309e44c2-f520-4e35-9f50-5e6932d7b40f@default>
 <d2f25bde-488f-dc37-b751-53ec602d66be@oracle.com>
In-Reply-To: <d2f25bde-488f-dc37-b751-53ec602d66be@oracle.com>
X-Priority: 3
X-Mailer: Oracle Beehive Extensions for Outlook 2.0.1.9.1  (1003210) [OL
 16.0.4849.0 (x86)]
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905250000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905250000
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Gerd,=20

Here's the response I got back from Simon:=20

=09there is an outstanding request with Intel, which would allow us to get =
rid of -strict-ansi. But until then, it seems to be a choice between (A) on=
e line change =09every time we update verbs.h and (B) let in the code chang=
es that break GCC build.

=09I'd vote for (A), since it isn't really that often that we pick new verb=
s.h.

So I suppose for now if the upstream doesn't pick up the enum change, we ca=
n make the change in our private verbs.h copy.=20

Thanks,

Zuoyu=20

-----Original Message-----
From: Gerd Rausch=20
Sent: Friday, May 24, 2019 12:26 PM
To: Zuoyu Tao <zuoyu.tao@oracle.com>; Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-rdma@vger.kernel.org; Aron Silverton <aron.silverton@oracle.com>;=
 Sharon Liu <sharon.s.liu@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC

Hi,

It's the "-strict-ansi" that makes it fail:

% icc -c -strict-ansi foo.c
foo.c(2): error: enumeration value is out of "int" range
  =09enum { FOO =3D 1UL << 31 } foo;


Zuoyu, is it possible to _not_ use "-strict-ansi"?

Thanks,

  Gerd

On 24/05/2019 11.59, Zuoyu Tao wrote:
> Here were the compiler flags used with ICC:
>=20
> -trigraphs -fno-omit-frame-pointer -fp-model source  -fno-strict-aliasing=
  -mIPOPT_clone_max_total_clones=3D0 -mP2OPT_hpo_enable_short_trip_vec=3DF =
-sox=3Dprofile -sox=3Dinline   -no-global-hoist -mP2OPT_tls_control=3D0  -w=
d191 -wd175 -wd188 -wd810 -we127 -we1345 -we1338 -wd279 -wd186 -wd1572 -wd5=
89 -wd11505 -we592 -wd69 -we172 -Qoption,cpp,--treat_func_as_string_literal=
 -mP2OPT_spill_parms=3DT -wd11505 -wd411 -wd273 -ww174    -we266    -ww279 =
   -we589    -we810    -we1011   -ww1418   -strict-ansi -wd66     -wd76    =
 -wd82     -wd94     -we102    -wd271    -wd424    -wd561    -wd662    -wd1=
511    -std=3Dc99 -ww344 -we137   -fPIC -mP2OPT_tls_control=3D2
>=20
> -----Original Message-----
> From: Gerd Rausch
> Sent: Thursday, May 23, 2019 11:15 PM
> To: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; Aron Silverton=20
> <aron.silverton@oracle.com>; Sharon Liu <sharon.s.liu@oracle.com>;=20
> ZUOYU.TAO <zuoyu.tao@oracle.com>
> Subject: Re: <infiniband/verbs.h> & ICC
>=20
> +Zuoyu,
>=20
> Hi Zuoyo,
>=20
> What compiler flags were you using while compiling the <verbs.h> file thr=
owing the error about 'enumeration value is out of "int" range'?
>=20
>=20
> On 23/05/2019 18.30, Jason Gunthorpe wrote:
>> On Thu, May 23, 2019 at 03:57:29PM -0700, Gerd Rausch wrote:
>>>
>>> error: enumeration value is out of "int" range
>>>          IBV_RX_HASH_INNER =3D (1UL << 31),
>>
>> I assume you are running with some higher warning flags and -Werror?
>> gcc will not emit this warning without -Wpedantic
>>
>=20
> Perhaps. I've added Zuoyu, who reported this issue to this e-mail thread.
>=20
>>
>>> Since "int" is signed, it can't hold the unsigned value of 1UL<<31=20
>>> on target platforms with sizeof(int) <=3D 4.
>>
>> Pedentically yes, but gcc and any compiler that can compile on linux=20
>> supports an extension where the underlying type of an enum constant=20
>> is automatically increased until it can hold the value of the constant.
>> In this case the constant is type promoted to long, IIRC.
>>
>=20
> Evidently ICC supports that as well:
> % icc --version
> icc (ICC) 17.0.5 20170817
> Copyright (C) 1985-2017 Intel Corporation.  All rights reserved.
>=20
> % cat foo.c
> enum { FOO =3D 1UL << 31 } foo =3D FOO;
>=20
> % icc -c -g foo.c && gdb -ex 'ptype foo' -ex 'print sizeof foo' foo.o=20
> type =3D enum {FOO =3D -2147483648}
> $1 =3D 4
>=20
> % cat bar.c
> enum { FOO =3D 1UL << 31, BAR =3D -1 } bar =3D BAR; % icc -c -g bar.c && =
gdb=20
> -ex 'ptype bar' -ex 'print sizeof bar' bar.o type =3D enum {FOO =3D=20
> -2147483648, BAR =3D -1}
> $1 =3D 8
>=20
> I can't say that I'm thrilled with this behavior though, as it appears er=
ror-prone:
> As soon as an enum value goes out of range for an "int", the type silentl=
y changes, potentially rendering structures and functions silently incompat=
ible.
> It's quite the pitfall (e.g. the foo.c vs bar.c case above).
>=20
>>
>> Can you clarify if icc is being run in some wonky mode that is=20
>> causing this warning? AFAIK icc will compile the linux kernel, and=20
>> the kernel makes extensive use of this extension. So I think the=20
>> compiler is not configured properly.
>>
>=20
> I've added Zuoyu to the distribution to shed some light on that.
>=20
>> IIRC I looked at this once for -Wpedantic support and decided it was=20
>> a lot of work as there are more cases than just this.
>>
>=20
> Not exactly shocking news ;-)
>=20
> Thanks for providing the information,
>=20
>   Gerd
>=20
