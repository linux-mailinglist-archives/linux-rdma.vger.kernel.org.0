Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C628903D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbgJIRrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 13:47:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgJIRrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 13:47:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099HTYWi053907;
        Fri, 9 Oct 2020 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=RrPayZrm5J2koESwq4jLiVatK3JS2GuFNv/DaCzt6cA=;
 b=mGIQcSa+Pc0KDj+lkIypF/5oY+9KT6jMppx45sa7xpl2sIdZ7thwsxv10DoX6kaRmdmh
 +EWGxQC0XDhn279LAS9DDhZ9+ujyi+7MjT1VF8GxnXLs+lZQYPCo9alLm+qhl7wi0wmm
 g5E+PPuKnl7GfEM3C8QD0S38Kp/p14v4SGjG/dGGgw/S3PziMzd7O1d5+BiehgUT+WeM
 8/fb3tOIEIxdrXJW36t4l8T9G7KHyI7U/o5HdOtSkBwgbzkp80+u3f2j2NXnMsMLE0Oz
 FrpOsYH27wYlKZYVgsCfySN9waolfYn/9YK8ZRGm53WmvljjxUr//Z+Rx9H9eGbvRd+P tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3429jmmu6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 17:47:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099HVR0i173223;
        Fri, 9 Oct 2020 17:47:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 342gurqmj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 17:47:14 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 099HlEQM025760;
        Fri, 9 Oct 2020 17:47:14 GMT
Received: from dhcp-10-175-176-72.vpn.oracle.com (/10.175.176.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 10:47:14 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH for-next v2] IB/mlx4: Convert rej_tmout radix-tree to
 XArray
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20201009153514.GA527106@nvidia.com>
Date:   Fri, 9 Oct 2020 19:47:12 +0200
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70AC4469-158B-4AB0-A898-6DA621AA898D@oracle.com>
References: <1602253482-6718-1-git-send-email-haakon.bugge@oracle.com>
 <20201009153514.GA527106@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=3
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 9 Oct 2020, at 17:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Oct 09, 2020 at 04:24:42PM +0200, H=C3=A5kon Bugge wrote:
>> Fixes: 227a0e142e37 ("IB/mlx4: Add support for REJ due to timeout")
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>> drivers/infiniband/hw/mlx4/cm.c      | 92 =
++++++++++++++++++------------------
>> drivers/infiniband/hw/mlx4/mlx4_ib.h |  4 +-
>> 2 files changed, 48 insertions(+), 48 deletions(-)
>=20
> Applied to for-next, thanks

Thxs

