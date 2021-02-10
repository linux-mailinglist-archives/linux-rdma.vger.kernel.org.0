Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C73164B7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhBJLLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 06:11:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50662 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBJLJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 06:09:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB4Zip123182;
        Wed, 10 Feb 2021 11:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=C4Kx45ZtPGlePGz5bDd624VhCfzZtg9HRn9Wbyy6mNw=;
 b=FovVTUj1qBnPJgnYvHsoVUQjmkD2TfX7MEjZfpNJxKBRYEKq/hRClOKxGtF/tCyq9UEF
 q+PEDZ7G6sWJGdEINoo0QrVd/wuSXSU84PPgugeaXwON3T2TsNNLjFUGixiH+Ez3dptq
 7JIlp0RMdKS9EuL77JLjpFjzt+CpTfWLmZrZ3tKUVWMFSKd8AsU5Un2e7ldZX4P/OvVE
 aP68cENPob7i6BbuJq9/t9SHjFufr7cdMc4BF1BZRnImEGHpHMJgW5s73W462rwosoAF
 MGgkjW4EhghG3G+oQMMb2QNrU3YUJo+BY3LhHqlzF0DI1SNX8jum+DnF/SU2CasiFa/p Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36hjhqtyvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:08:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AB5w3T028803;
        Wed, 10 Feb 2021 11:08:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36j4pq0gef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 11:08:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11AB8J1L027065;
        Wed, 10 Feb 2021 11:08:19 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 03:08:19 -0800
Date:   Wed, 10 Feb 2021 14:08:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vladbu@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Handle FIB events to update tunnel endpoint
 device
Message-ID: <YCO+nR+3Zs9jIAfp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=929 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100108
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Vlad Buslov,

The patch 8914add2c9e5: "net/mlx5e: Handle FIB events to update
tunnel endpoint device" from Jan 25, 2021, leads to the following
static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c:1639 mlx5e_tc_tun_init()
	error: passing non negative 1 to ERR_PTR

drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
  1622  struct mlx5e_tc_tun_encap *mlx5e_tc_tun_init(struct mlx5e_priv *priv)
  1623  {
  1624          struct mlx5e_tc_tun_encap *encap;
  1625          int err;
  1626  
  1627          encap = kvzalloc(sizeof(*encap), GFP_KERNEL);
  1628          if (!encap)
  1629                  return ERR_PTR(-ENOMEM);
  1630  
  1631          encap->priv = priv;
  1632          encap->fib_nb.notifier_call = mlx5e_tc_tun_fib_event;
  1633          spin_lock_init(&encap->route_lock);
  1634          hash_init(encap->route_tbl);
  1635          err = register_fib_notifier(dev_net(priv->netdev), &encap->fib_nb,
  1636                                      NULL, NULL);

register_fib_notifier() calls fib_net_dump() which eventually calls
fib6_walk_continue() which can return 1 if "walk is incomplete (i.e.
suspended)".

  1637          if (err) {
  1638                  kvfree(encap);
  1639                  return ERR_PTR(err);

If this returns 1 it will eventually lead to an Oops.

  1640          }
  1641  
  1642          return encap;
  1643  }

regards,
dan carpenter
