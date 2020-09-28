Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A627ABA6
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1KPQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Sep 2020 06:15:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44598 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1KPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Sep 2020 06:15:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SABPVX129653;
        Mon, 28 Sep 2020 10:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=LPYaMKSIzSW676D+dL0gaedlKwcq+iEI2gIe5J3ZT6g=;
 b=LWMH34/St/oQkTxY844g+ViT3siNvwLscatw8SXO+yuJOe9/Uy1h3fxOQ7/TZPFC68ic
 KQgSpL8O4G9iiatMCLdoNbhBk7rWt2olAp87fyxGVusAG1Xuo03kA8RwWvAVCT3C3NGn
 c1n20WagP6G6A0E4BCbG6Yxqh3qbbroOuSZCL3haQlcsSl4uqpB87M9wtQRf3z2S6nWg
 o223ie4xsZztTTM+rpQqTG56paw9uWJHShqbMLWieg4hNKH8fPo0lxdEl7HLZFctiBpE
 JWJlxrhVGANM/VPnURmMRlz3yiNqwtJkr7dE8Dx/hqoGI6J20OUyNuNNP3Ik670QyJfM ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33su5am8y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 10:15:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SA8upu036292;
        Mon, 28 Sep 2020 10:15:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33tfjur3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 10:15:12 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08SAFBYq008260;
        Mon, 28 Sep 2020 10:15:11 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 03:15:10 -0700
Date:   Mon, 28 Sep 2020 13:15:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lariel@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Support CT offload for tc nic flows
Message-ID: <20200928101505.GA382341@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=11
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=11
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Ariel Levkovich,

The patch aedd133d17bc: "net/mlx5e: Support CT offload for tc nic
flows" from Jul 21, 2020, leads to the following static checker
warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1132 mlx5e_tc_del_nic_flow()
	warn: passing freed memory 'flow'

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
  1105  static void mlx5e_tc_del_nic_flow(struct mlx5e_priv *priv,
  1106                                    struct mlx5e_tc_flow *flow)
  1107  {
  1108          struct mlx5_flow_attr *attr = flow->attr;
  1109          struct mlx5e_tc_table *tc = &priv->fs.tc;
  1110  
  1111          flow_flag_clear(flow, OFFLOADED);
  1112  
  1113          if (flow_flag_test(flow, CT))
  1114                  mlx5_tc_ct_delete_flow(get_ct_priv(flow->priv), flow, attr);
                                                                        ^^^^
I guess this used to free "flow" and Smatch's db hasn't totally caught
up yet.  Now it doesn't use "flow" at all.  Maybe we could just remove
that parameter?

  1115          else if (!IS_ERR_OR_NULL(flow->rule[0]))
  1116                  mlx5e_del_offloaded_nic_rule(priv, flow->rule[0], attr);
  1117  
  1118          /* Remove root table if no rules are left to avoid
  1119           * extra steering hops.
  1120           */
  1121          mutex_lock(&priv->fs.tc.t_lock);
  1122          if (!mlx5e_tc_num_filters(priv, MLX5_TC_FLAG(NIC_OFFLOAD)) &&
  1123              !IS_ERR_OR_NULL(tc->t)) {
  1124                  mlx5_chains_put_table(nic_chains(priv), 0, 1, MLX5E_TC_FT_LEVEL);
  1125                  priv->fs.tc.t = NULL;
  1126          }
  1127          mutex_unlock(&priv->fs.tc.t_lock);
  1128  
  1129          kvfree(attr->parse_attr);
  1130  
  1131          if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
  1132                  mlx5e_detach_mod_hdr(priv, flow);
                                                   ^^^^
  1133  
  1134          mlx5_fc_destroy(priv->mdev, attr->counter);
  1135  
  1136          if (flow_flag_test(flow, HAIRPIN))
  1137                  mlx5e_hairpin_flow_del(priv, flow);
  1138  
  1139          kfree(flow->attr);
  1140  }

regards,
dan carpenter
