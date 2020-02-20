Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE1165F54
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBTN5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 08:57:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgBTN5n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 08:57:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KDqr7Z105551;
        Thu, 20 Feb 2020 13:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=l0RHcD2bGgv0Tq1M4MvjSgBwXPauFs/5JttJChwCW1g=;
 b=B2rHB1oBLxX4La52ttXD8syP3U6La32M2fK2rULDrMUHUv+rbKfrZ8D5YZ+5ywr8ArQ8
 GHTQBNDM6Yyq0MgraacIr7YrFeMRIDhhd74qOLyu5cWHRWYoN30qRxcFrUVEjj+V8Yxn
 484O4jJVLcEhX/wqCNUj59JfkMpW2QEwNQDFmfKqZZnEx0gpZFCD5SlFs56MXZ8i6euS
 h/sFV+aN9CLpgnbCcfWzI9ijH/Xb0bsfXjo5bj+czufVi0uwqMxmUkLG9xUtZN7TDMXX
 m8XtzI3CDtBSlKxiXzZJ8zZuseDg/GHK+a/5+FCyAzdyr3SXrF4xgMR4K49R+GC/VBKt Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8udd9u6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 13:57:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KDppCw196011;
        Thu, 20 Feb 2020 13:57:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y8udd4e23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 13:57:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KDvVjC027808;
        Thu, 20 Feb 2020 13:57:31 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 05:57:30 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened
 in 5.4.21 but not in 5.4.20
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200220112231.34FB.409509F4@e16-tech.com>
Date:   Thu, 20 Feb 2020 08:57:29 -0500
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD4E1E87-28CF-4F4C-BBF4-2BD945142A14@oracle.com>
References: <20200220112231.34FB.409509F4@e16-tech.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=2
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200105
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

Thanks for your bug report.


> On Feb 19, 2020, at 10:22 PM, Wang Yugui <wangyugui@e16-tech.com> =
wrote:
>=20
> Hi, chuck.lever=20
>=20
> a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in =
5.4.21 but not in 5.4.20.
>=20
> maybe some releationship to =
xprtrdma-fix-dma-scatter-gather-list-mapping-imbalance.patch

I don't see an obvious connection to =
fix-dma-scatter-gather-list-mapping-imbalance.
The backtrace below is through IPoIB code paths. Those have nothing to =
do with
NFS/RDMA, which is the only ULP code that is changed by my commit.


> maybe the info is useful.

I'm copying linux-rdma for a bigger set of eyeballs.

My knee-jerk recommendation is that if you have a reliable reproducer, =
try "git bisect"
between .20 and .21 to nail down a specific commit where the BUG starts =
to occur.


> Feb 20 10:05:58 T630 kernel: BUG: kernel NULL pointer dereference, =
address: 0000000000000010
> ...
> Feb 20 10:05:58 T630 kernel: port_pkey_list_insert+0x30/0x1a0 =
[ib_core]
> Feb 20 10:05:58 T630 kernel: ? kmem_cache_alloc_trace+0x219/0x230
> Feb 20 10:05:58 T630 kernel: ib_security_modify_qp+0x244/0x3b0 =
[ib_core]
> Feb 20 10:05:58 T630 kernel: _ib_modify_qp+0x1c0/0x3c0 [ib_core]
> Feb 20 10:05:58 T630 kernel: ? dma_pool_free+0x24/0xc0
> Feb 20 10:05:58 T630 kernel: ipoib_init_qp+0x77/0x190 [ib_ipoib]
> Feb 20 10:05:58 T630 kernel: ? __mlx4_ib_query_pkey+0xe7/0x110 =
[mlx4_ib]
> Feb 20 10:05:58 T630 kernel: ? ib_find_pkey+0x98/0xe0 [ib_core]
> Feb 20 10:05:58 T630 kernel: ipoib_ib_dev_open_default+0x1a/0x180 =
[ib_ipoib]
> Feb 20 10:05:58 T630 kernel: ipoib_ib_dev_open+0x66/0xa0 [ib_ipoib]
> Feb 20 10:05:58 T630 kernel: ipoib_open+0x44/0x110 [ib_ipoib]
> Feb 20 10:05:58 T630 kernel: __dev_open+0xcd/0x160
>=20
>=20
> # ibstat
> CA 'mlx4_0'
>        CA type: MT4099
>        Number of ports: 2
>        Firmware version: 2.42.5000
>        Hardware version: 1
>        Node GUID: 0xe41d2d03007b4080
>        System image GUID: 0xe41d2d03007b4083
>        Port 1:
>                State: Down
>                Physical state: Polling
>                Rate: 10
>                Base lid: 0
>                LMC: 0
>                SM lid: 0
>                Capability mask: 0x02594868
>                Port GUID: 0xe41d2d03007b4081
>                Link layer: InfiniBand
>        Port 2:
>                State: Down
>                Physical state: Disabled
>                Rate: 40
>                Base lid: 0
>                LMC: 0
>                SM lid: 0
>                Capability mask: 0x00010000
>                Port GUID: 0xe61d2dfffe7b4082
>                Link layer: Ethernet
>=20
> Best Regards
> =E7=8E=8B=E7=8E=89=E8=B4=B5
> 2020/02/20
>=20
> --------------------------------------
> =E5=8C=97=E4=BA=AC=E4=BA=AC=E5=9E=93=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8
> =E7=8E=8B=E7=8E=89=E8=B4=B5	wangyugui@e16-tech.com
> =E7=94=B5=E8=AF=9D=EF=BC=9A+86-136-71123776
> <bug-of-ib-in-5.4.21.message>

--
Chuck Lever



