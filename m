Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9BE389095
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhESOUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 10:20:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47866 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242381AbhESOUF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 10:20:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEEGZH194171;
        Wed, 19 May 2021 14:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=EVtBgKZnQCjb1OT0+Me6i4WbJ4GcjksiqwesDsbTflA=;
 b=d+qORVv03JI1Kj0I2p1U0UYQABlNZoJWp3rsIysdpzQ2mYB/24BK412leVi/CzJp4/Um
 mPdIQzj7m0NAM1E7ujLzKtMeqVToTEEMtHllCrVOHDbxjXbrwpLgh8dYTka3NmKHQftZ
 YJM/Txqziw88R7IHSggZ/DvF02lBvIXKAMmv7he4m9ysz6FeGvEWZ3lREqtoYMxMMTjD
 Vdzu45UtMQfzHD/6By8TT9N+bdCv7a71YlFBwbd6oJDiNexUnNg8/Jiz5PSU1tc6zYej
 JZNcgeub2G1HWU21mpSRXdb4sZNLiZT+OzFwiSldPiIyXCkld+rF6BSGHyere9qfl5qK OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbht7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEAOHd031261;
        Wed, 19 May 2021 14:18:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38megkh0xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:40 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JEIeO5051066;
        Wed, 19 May 2021 14:18:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38megkh0x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:39 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14JEIdcl003239;
        Wed, 19 May 2021 14:18:39 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 14:18:38 +0000
Date:   Wed, 19 May 2021 17:18:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     danielj@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] {net, IB}/mlx5: Manage port association for multiport
 RoCE
Message-ID: <YKUeOV14j98OJIj7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518082855.GB32682@kadam>
X-Proofpoint-ORIG-GUID: rBIJ1hk-_gWuTOYYrquX3SIgblUnfmJS
X-Proofpoint-GUID: rBIJ1hk-_gWuTOYYrquX3SIgblUnfmJS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=946 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190089
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Daniel Jurgens,

The patch 32f69e4be269: "{net, IB}/mlx5: Manage port association for
multiport RoCE" from Jan 4, 2018, leads to the following static
checker warning:

	drivers/infiniband/hw/mlx5/main.c:3285 mlx5_ib_init_multiport_master()
	warn: iterator 'mpi->list.next' changed during iteration

drivers/infiniband/hw/mlx5/main.c
  3285                  list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We're iterating through the unafiliated list.

  3286                                      list) {
  3287                          if (dev->sys_image_guid == mpi->sys_image_guid &&
  3288                              (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
  3289                                  bound = mlx5_ib_bind_slave_port(dev, mpi);

The mlx5_ib_bind_slave_port() function returns true on success and
false on failure.  On the failure path it calls:

	mlx5_ib_unbind_slave_port(ibdev, mpi);

Which adds our "mpi" as the last item on the unaffiliated list.  I don't
think anything good can come from adding a list item to a list twice.

  3290                          }
  3291  
  3292                          if (bound) {
  3293                                  dev_dbg(mpi->mdev->device,
  3294                                          "removing port from unaffiliated list.\n");
  3295                                  mlx5_ib_dbg(dev, "port %d bound\n", i + 1);
  3296                                  list_del(&mpi->list);
  3297                                  break;
  3298                          }
  3299                  }
  3300                  if (!bound)
  3301                          mlx5_ib_dbg(dev, "no free port found for port %d\n",
  3302                                      i + 1);

regards,
dan carpenter
