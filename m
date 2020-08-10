Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEE24052D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgHJLU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 07:20:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgHJLUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 07:20:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ABGbqg056479;
        Mon, 10 Aug 2020 11:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=y1wmFYbJ+HYC63cVgEe6D2pIJsUWEap1+nfWxbIzEa0=;
 b=EkqUQL6Tx5BksUbnCGwJs2d4XutyWIm3E2AcEUa79XpaHY5q0GpHURHE1vgYXPZZhybw
 8bYOtFI9IlwgMQZwkmOjKgAyZmmOrIuTnigRt/+XavIzWyO1wrcD95P2KksITht3OpSh
 C74KMbQP1FBqph9bDC+A3JDeO8OSEFlA7hB5rQDtd6TfW8aktkvncB2tRwvN3aBb66aU
 ATbPGj7KeyfPd6LHDsblTeqRxhfx7szt2Q6qEK5rniNksYQGbuwo3+zvWq4BX/L22jju
 DWz3rWsgik7xVuzbZiQ7K5bJyPYdDDI43D0jpmgpq7TwPats5hb7877gwE/4YI/+raV5 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32sm0mdvrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 11:20:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ABDRET017388;
        Mon, 10 Aug 2020 11:20:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32t5mmd0hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 11:20:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07ABKlqw030378;
        Mon, 10 Aug 2020 11:20:47 GMT
Received: from dhcp-10-175-161-90.vpn.oracle.com (/10.175.161.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 11:20:47 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH for-rc v2 0/6] Add CM packets missing and harden the
 proxying
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
Date:   Mon, 10 Aug 2020 13:20:43 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>, ranro@mellanox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A84B2186-42F4-4164-B80D-27782CEAE925@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=3 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A friendly reminder.


Thxs, H=C3=A5kon


> On 3 Aug 2020, at 08:19, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> A high number of MAD packet drops are observed in the mlx4 MAD proxy
> system. These are fixed by separating the parameters for the tunnel
> vs. wire QPs and by introducing a separate worker-thread for the wire
> QPs.
>=20
> Support for MRA and REJ with its reason being timeout is also added.
>=20
> Dynamic debug prints adjusted and amended.
>=20
>    v1->v2:
> 	* Added commit ("Adjust delayed work when a dup is observed")
> 	* Minor adjustments in some of the commits
>=20
> H=C3=A5kon Bugge (6):
>  IB/mlx4: Add and improve logging
>  IB/mlx4: Add support for MRA
>  IB/mlx4: Separate tunnel and wire bufs parameters
>  IB/mlx4: Fix starvation in paravirt mux/demux
>  IB/mlx4: Add support for REJ due to timeout
>  IB/mlx4: Adjust delayed work when a dup is observed
>=20
> drivers/infiniband/hw/mlx4/cm.c      | 148 ++++++++++++++++++++++++-
> drivers/infiniband/hw/mlx4/mad.c     | 158 +++++++++++++++------------
> drivers/infiniband/hw/mlx4/mlx4_ib.h |   8 +-
> 3 files changed, 241 insertions(+), 73 deletions(-)
>=20
> --
> 2.20.1
>=20

