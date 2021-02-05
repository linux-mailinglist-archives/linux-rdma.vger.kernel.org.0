Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D745D310B58
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBEMtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 07:49:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhBEMrP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 07:47:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CTUit115488;
        Fri, 5 Feb 2021 12:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NJrBfpgCjUiEfZr94zJbyL1bQyu5MTHNs/temhe54wc=;
 b=lTv5549OETIVSUeL+QMuSRKA0n77HTclVDPDooO+d7TkY4LCokYKvS+YNm0Om2i2Y4TY
 kP2N2Wz+yfJ4J8kdrppeIM68JMSeiVyPNidCMvTYAp+XCEVbj9wY98JN4GQDeb5Z84Ek
 fjHsLAF73stfCfpOW/iaL7lqtrlH1loPDHGQEzy8cNBcX3nVnvWk/yvMmjbEjQ6FuGdf
 hpUKGEOApqTz1Ruys8wtgQa+pAD8skCZozE7Shu3iJ5bk2ACe9hGUufMQBis5Bzftf5t
 8zQdd/rhtAIB9oop5hJSCUNqGsqf143I1Rr3yU1B49YHRipDmetz+7nhRLb/3UTsPTq3 Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36gfw8snvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 12:46:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CUdgr077914;
        Fri, 5 Feb 2021 12:46:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36dh7wnhhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 12:46:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 115Ck4vc006594;
        Fri, 5 Feb 2021 12:46:04 GMT
Received: from mwanda (/41.210.143.249)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Feb 2021 04:46:03 -0800
Date:   Fri, 5 Feb 2021 15:45:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     saeedm@nvidia.com, Feras Daoud <ferasda@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mxl5e: Add change profile method
Message-ID: <YBz2CSKUBlUCRxsZ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050083
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Saeed Mahameed and Feras Daoud,

I'm not exactly sure if I should blame commit c4d7eb57687f: "net/mxl5e:
Add change profile method" fomr Mar 22, 2020 or commit 182570b26223
("net/mlx5e: Gather common netdev init/cleanup functionality in one
place") from Oct 2, 2018.

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5658 mlx5e_netdev_change_profile() warn: 'priv->htb.qos_sq_stats' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5658 mlx5e_netdev_change_profile() warn: 'priv->scratchpad.cpumask' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5789 mlx5e_probe() warn: 'priv->htb.qos_sq_stats' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5789 mlx5e_probe() warn: 'priv->scratchpad.cpumask' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5802 mlx5e_remove() warn: 'priv->htb.qos_sq_stats' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5802 mlx5e_remove() warn: 'priv->scratchpad.cpumask' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:1317 mlx5e_vport_rep_unload() warn: 'priv->htb.qos_sq_stats' double freed
drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:1317 mlx5e_vport_rep_unload() warn: 'priv->scratchpad.cpumask' double freed

drivers/net/ethernet/mellanox/mlx5/core/en_main.c
  5639  int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
  5640                                  const struct mlx5e_profile *new_profile, void *new_ppriv)
  5641  {
  5642          unsigned int new_max_nch = mlx5e_calc_max_nch(priv, new_profile);
  5643          const struct mlx5e_profile *orig_profile = priv->profile;
  5644          void *orig_ppriv = priv->ppriv;
  5645          int err, rollback_err;
  5646  
  5647          /* sanity */
  5648          if (new_max_nch != priv->max_nch) {
  5649                  netdev_warn(priv->netdev,
  5650                              "%s: Replacing profile with different max channles\n",
  5651                              __func__);
  5652                  return -EINVAL;
  5653          }
  5654  
  5655          /* cleanup old profile */
  5656          mlx5e_detach_netdev(priv);
  5657          priv->profile->cleanup(priv);

The problem is that mlx5i_pkey_cleanup() calls mlx5e_priv_cleanup().

  5658          mlx5e_priv_cleanup(priv);
                ^^^^^^^^^^^^^^^^^^^^^^^^
And then it gets called again here.

  5659  
  5660          err = mlx5e_netdev_attach_profile(priv, new_profile, new_ppriv);
  5661          if (err) { /* roll back to original profile */
  5662                  netdev_warn(priv->netdev, "%s: new profile init failed, %d\n",
  5663                              __func__, err);
  5664                  goto rollback;
  5665          }
  5666  
  5667          return 0;
  5668  
  5669  rollback:
  5670          rollback_err = mlx5e_netdev_attach_profile(priv, orig_profile, orig_ppriv);
  5671          if (rollback_err) {
  5672                  netdev_err(priv->netdev,
  5673                             "%s: failed to rollback to orig profile, %d\n",
  5674                             __func__, rollback_err);
  5675          }
  5676          return err;
  5677  }

regards,
dan carpenter
