Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66A68D199
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNKzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 06:55:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfHNKzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 06:55:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAs1JC137006;
        Wed, 14 Aug 2019 10:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=gt0l2zsTz2l3ZjXvyhBQHpE/YiRmTp5wblWGuBO41M8=;
 b=JTe88/0H+qGvdeCIRyvhaz2cO6LBofqN90G6OO4Zi77Fwe9ynOO6ClEYnF1iuAgBkXmI
 BNeyb7UCTa/5rk3SPET8pZwhnIVYCF0Kx9C/SSj3PyVu5oOIPg+IJiHWdpzp//v3h+1k
 bEYRjEgtH1e5vxprpZmz3h8bd6x2Xn8Ko7xh9YXbt0IKOIlq0anjonYfCE5T0B67ktGJ
 vQzGPCRuxAHgL41GYfY80JuTRd8VU2yhHXC8t8tFj+gZCPUhKxxfFjMLl0wCIDXtdRyW
 FD6IjGA5He5qOYGYvQVI6VzkF9FULkMBuria4EvoK2+XVldrbrlecxAj3vFYYiObQohW kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvpc4mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:55:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EAqSkF052474;
        Wed, 14 Aug 2019 10:53:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ubwcxvxk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 10:53:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EArAkr005259;
        Wed, 14 Aug 2019 10:53:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 03:53:09 -0700
Date:   Wed, 14 Aug 2019 13:53:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vladbu@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Extend encap entry with reference counter
Message-ID: <20190814105302.GA14514@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140113
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ I already wrote this email, but it looks like I deleted it instead of
  sending it.  So weird.  I hopefully don't send it twice! ]

Hi Vlad,

I noticed a possible refcounting bug in commit 948993f2beeb ("net/mlx5e:
Extend encap entry with reference counter") from Jun 3, 2018.

	drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1435 mlx5e_tc_update_neigh_used_value()
	error: dereferencing freed memory 'e'

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

  1415  void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
  1416  {
  1417          struct mlx5e_neigh *m_neigh = &nhe->m_neigh;
  1418          struct mlx5e_tc_flow *flow;
  1419          struct mlx5e_encap_entry *e;
  1420          struct mlx5_fc *counter;
  1421          struct neigh_table *tbl;
  1422          bool neigh_used = false;
  1423          struct neighbour *n;
  1424          u64 lastuse;
  1425  
  1426          if (m_neigh->family == AF_INET)
  1427                  tbl = &arp_tbl;
  1428  #if IS_ENABLED(CONFIG_IPV6)
  1429          else if (m_neigh->family == AF_INET6)
  1430                  tbl = &nd_tbl;
  1431  #endif
  1432          else
  1433                  return;
  1434  
  1435          list_for_each_entry_safe(e, tmp, &nhe->encap_list, encap_list) {
  1436                  struct encap_flow_item *efi, *tmp;
  1437  
  1438                  if (!(e->flags & MLX5_ENCAP_ENTRY_VALID) ||
  1439                      !mlx5e_encap_take(e))
                            ^^^^^^^^^^^^^^^^^^^
We take a reference here.

  1440                          continue;
  1441  
  1442                  list_for_each_entry_safe(efi, tmp, &e->flows, list) {
  1443                          flow = container_of(efi, struct mlx5e_tc_flow,
  1444                                              encaps[efi->index]);
  1445                          if (IS_ERR(mlx5e_flow_get(flow)))
  1446                                  continue;
  1447  
  1448                          if (mlx5e_is_offloaded_flow(flow)) {
  1449                                  counter = mlx5e_tc_get_counter(flow);
  1450                                  lastuse = mlx5_fc_query_lastuse(counter);
  1451                                  if (time_after((unsigned long)lastuse, nhe->reported_lastuse)) {
  1452                                          mlx5e_flow_put(netdev_priv(e->out_dev), flow);
  1453                                          neigh_used = true;
  1454                                          break;

I think we need to call mlx5e_encap_put(netdev_priv(e->out_dev), e);
before this break;

  1455                                  }
  1456                          }
  1457  
  1458                          mlx5e_flow_put(netdev_priv(e->out_dev), flow);
  1459                  }
  1460  
  1461                  mlx5e_encap_put(netdev_priv(e->out_dev), e);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  1462                  if (neigh_used)
  1463                          break;
  1464          }
  1465  

regards,
dan carpenter
