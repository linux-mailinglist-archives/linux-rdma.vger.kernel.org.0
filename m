Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D357311614
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 23:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBEWuV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 17:50:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60110 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhBENDx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 08:03:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CTTnv115438;
        Fri, 5 Feb 2021 13:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=LgzNwtVrPCHQ+X8++9CaF64ugRzfuLVv6tZF9PdDXH8=;
 b=bUmawfdmWCY7B6M4RdQaMNSXMOcMa1rPHhd/3lCHbxtIOyplFoql/OvdSR1P1Amvmhpp
 5d5oaIsVHfiJugmdhV+F7dyIQUyErjknIHGxQnHJFJwZaF5QXZ4BwKugm6wqboh5X7bR
 tNKeHPbYEA7rufTsrWVolzc5tagUkB0bs+LxsCQhGrSQqkbZOgxpkKUeTXTFwKJKD+5u
 0tMrCyunsD9bso9PFiXEiFwcE0WzJAPeWTyRGSKOUxi/u6yn1XZPIca9Soy9LUvAJATS
 /nz2VHAS2luM1l5bJPXnsR9kd3eb3GAqW+dCea/Uynb4+6doRhrCqbtLr6qRlS4oCHzC tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36gfw8sqv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 13:03:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CxeSo023736;
        Fri, 5 Feb 2021 13:03:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36dh1tvpd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 13:03:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 115D33SV027207;
        Fri, 5 Feb 2021 13:03:03 GMT
Received: from mwanda (/41.210.143.249)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Feb 2021 05:03:02 -0800
Date:   Fri, 5 Feb 2021 16:02:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kliteyn@nvidia.com
Cc:     Yevgeny Kliteynik <kliteyn@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: DR, Add STEv1 setters and getters
Message-ID: <YB1B/iHMlHHnOWCh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=852 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=796 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050083
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Yevgeny Kliteynik,

The patch a6098129c781: "net/mlx5: DR, Add STEv1 setters and getters"
from Sep 22, 2020, leads to the following static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c:268 dr_ste_v1_get_miss_addr()
	warn: potential shift truncation.  '0xff (0-255) << 26'

drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
   264  static u64 dr_ste_v1_get_miss_addr(u8 *hw_ste_p)
   265  {
   266          u64 index =
   267                  (MLX5_GET(ste_match_bwc_v1, hw_ste_p, miss_address_31_6) |
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   268                   MLX5_GET(ste_match_bwc_v1, hw_ste_p, miss_address_39_32) << 26);
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

index is a u64 but the right side is a two u32s.  The << 26 can shift
wrap potentially according to Smatch.

   269  
   270          return index << 6;
   271  }

regards,
dan carpenter
