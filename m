Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45336F58B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Apr 2021 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhD3GDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Apr 2021 02:03:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhD3GDD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Apr 2021 02:03:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U60dXq008516;
        Fri, 30 Apr 2021 06:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bR2+KtIaPtC53CBJQihPGd4Br58pLWSVwuOGAQwAsho=;
 b=g0Yx3mnXrukZJV1v+sAU14/qziuEXJcfhSePIOnIjApdyhMQM/ARyAs5f15Q21ge5fxq
 L1S9YIuAa2THzpWwb6iOOZovmm/IioohP1B30CbjPHq5kl2YErwQvfDjmszhLImpaD92
 6uk3w1XURcKRdMn9lRbnw1Qtl4QSevmaXpk0xdJ7EAXogtSJB1XqS9HfiKA52zfCBBf5
 C7VN5nKiALBOash0vjMqffCh6d771iv/se/Sq1uUSe7IzWj9PF0CKkW5d1afxKRh8JWY
 E4BceURVH23nRkcbltbY4RJAlRO+N0IEyhm+TVfbBrDge5lsNv2YJ2g+LsSPFuLH8XXZ Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 385aft6gm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 06:02:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U5stKM172365;
        Fri, 30 Apr 2021 06:02:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3874d4hk3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 06:02:12 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13U5x32c185636;
        Fri, 30 Apr 2021 06:02:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3874d4hk38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 06:02:12 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13U62Bld007530;
        Fri, 30 Apr 2021 06:02:11 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 06:02:10 +0000
Date:   Fri, 30 Apr 2021 09:02:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     parav@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-Switch, Consider SF ports of host PF
Message-ID: <YIudXfl7K83HgIzM@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: t6A9p2wbh6RLvNXTnQpohQ_w3vvYoU8n
X-Proofpoint-ORIG-GUID: t6A9p2wbh6RLvNXTnQpohQ_w3vvYoU8n
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300042
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Parav Pandit,

The patch 87bd418ea751: "net/mlx5: E-Switch, Consider SF ports of
host PF" from Mar 2, 2021, leads to the following static checker
warning:

	drivers/net/ethernet/mellanox/mlx5/core/eswitch.c:1571 mlx5_query_hca_cap_host_pf()
	warn: odd binop '0x0 & 0x1'

drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
  1569  static int mlx5_query_hca_cap_host_pf(struct mlx5_core_dev *dev, void *out)
  1570  {
  1571          u16 opmod = (MLX5_CAP_GENERAL << 1) | (HCA_CAP_OPMOD_GET_MAX & 0x01);
                                                       ^^^^^^^^^^^^^^^^^^^^^
HCA_CAP_OPMOD_GET_MAX is zero.

  1572          u8 in[MLX5_ST_SZ_BYTES(query_hca_cap_in)] = {};
  1573  
  1574          MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
  1575          MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
  1576          MLX5_SET(query_hca_cap_in, in, function_id, MLX5_VPORT_PF);
  1577          MLX5_SET(query_hca_cap_in, in, other_function, true);
  1578          return mlx5_cmd_exec_inout(dev, query_hca_cap, in, out);
  1579  }

regards,
dan carpenter
