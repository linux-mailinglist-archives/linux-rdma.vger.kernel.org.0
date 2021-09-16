Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1486440EABE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 21:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhIPTUY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 15:20:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhIPTUX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 15:20:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18GGZJ1C012281;
        Thu, 16 Sep 2021 15:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=1hjp6UL9gpEZD94jzyB2AnnmM66yDcPTRA8aGYu7DTo=;
 b=EXYAy/cFaYF2MFBL1W6xNoOS0pFKO9+B2D4yhyEpP73NfDi6IqeW+e7fy6mx6T/qoz2f
 0TQ0dPkuMU5Sb3EI8x049qCD0p4aNallNUOI6sPCJIdJYOeaSTaHyvjsNAwM9IUlJHRW
 FQxa6HpZOUPyxzQMryoEVTrnSm+RoN8V8lZKAB53KkHWwfVtqbXccmjIXWBRjGN7mSri
 sr3PMd65lL+kTJR/l42kgE3MJaeLy+i91hTLu3YmYRy8YljtWpU694QOogFJJA5xW71W
 EclTH7K1F5i9ZgC8ISgpb54v2jhZs6hbKe0cbHqTdq74c/fEYi+H+bPF0uP5mD+xRR1x CA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b49k0u82c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 15:18:59 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18GJCr8x032048;
        Thu, 16 Sep 2021 19:18:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 3b0m3ba7ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 19:18:58 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18GJIvZW17170704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 19:18:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C6747807A;
        Thu, 16 Sep 2021 19:18:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93CAF78072;
        Thu, 16 Sep 2021 19:18:57 +0000 (GMT)
Received: from mww0302.dal12m.mail.ibm.com (unknown [9.208.69.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Sep 2021 19:18:57 +0000 (GMT)
In-Reply-To: <ccb9ee03-4aaa-2288-3d2f-ce01f550a609@acm.org>
Subject: Re: v5.15-rc1 issue with the soft-iWARP driver
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@nvidia.com>
Date:   Thu, 16 Sep 2021 19:18:55 +0000
Message-ID: <OF74B9ECF6.B2B7F2D4-ON00258752.00675A19-00258752.006A1A3D@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <ccb9ee03-4aaa-2288-3d2f-ce01f550a609@acm.org>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF114   September 2, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 09/16/2021 19:18:55,Serialize
 complete at 09/16/2021 19:18:55
X-KeepSent: 74B9ECF6:B2B7F2D4-00258752:00675A19; name=$KeepSent; type=4
X-Disclaimed: 54235
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _tp_Mr-czb4-YaB8etjURw90FupwYF5K
X-Proofpoint-ORIG-GUID: _tp_Mr-czb4-YaB8etjURw90FupwYF5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-11_02,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 phishscore=0 mlxlogscore=756 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160094
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@nvidia.com>
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 09/15/2021 06:54AM
>Subject: [EXTERNAL] v5.15-rc1 issue with the soft-iWARP driver
>
>Hi,
>
>If I run test srp/015 from the blktests suite then the following
>appears
>in the kernel log:
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>BUG: KASAN: null-ptr-deref in =5F=5Flist=5Fdel=5Fentry=5Fvalid+0x4d/0xe0
>Read of size 8 at addr 0000000000000000 by task kworker/u16:3/161
>
>CPU: 5 PID: 161 Comm: kworker/u16:3 Not tainted 5.15.0-rc1-dbg+ #2
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>Workqueue: iw=5Fcm=5Fwq cm=5Fwork=5Fhandler [iw=5Fcm]
>Call Trace:
>  show=5Fstack+0x52/0x58
>  dump=5Fstack=5Flvl+0x5b/0x82
>  kasan=5Freport.cold+0x52/0x57
>  =5F=5Fasan=5Fload8+0x69/0x90
>  =5F=5Flist=5Fdel=5Fentry=5Fvalid+0x4d/0xe0
>  =5Fcma=5Fcancel=5Flistens+0x49/0x230 [rdma=5Fcm]
>  =5Fdestroy=5Fid+0x4e/0x420 [rdma=5Fcm]
>  destroy=5Fid=5Fhandler=5Funlock+0xc4/0x200 [rdma=5Fcm]
>  iw=5Fconn=5Freq=5Fhandler+0x335/0x370 [rdma=5Fcm]
>  cm=5Fconn=5Freq=5Fhandler+0x546/0x7d0 [iw=5Fcm]
>  cm=5Fwork=5Fhandler+0x419/0x480 [iw=5Fcm]
>  process=5Fone=5Fwork+0x59d/0xb00
>  worker=5Fthread+0x8f/0x5c0
>  kthread+0x1fc/0x230
>  ret=5Ffrom=5Ffork+0x1f/0x30
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>I think this is a regression. This happened with commit a17a1faf5d3e
>("RDMA/cma: Fix listener leak in rdma=5Fcma=5Flisten=5Fon=5Fall() failure"=
).
>
So far I could not reproduce it with that patch (tried to get better
understanding with siw debugging enabled). That doesn't mean much.

But I do see issues with rxe if running the complete srp set from
blktest, which seem to be unrelated. I'll send an extra message.

Many thanks,
Bernard.
