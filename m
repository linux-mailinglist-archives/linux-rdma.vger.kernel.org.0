Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DF1B3A77
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVIqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 04:46:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVIqr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Apr 2020 04:46:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M8gRIN189273;
        Wed, 22 Apr 2020 08:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+g/izlnTjzflxOQriADQ2+sU3bekL66zAkV05lgW/Go=;
 b=GqCB+HS5rB+nRtgSnIK72ZSzLV7ktQvOft4r2lZNyfR3aNhv4r/qeXcwd0KbYLbxh6Da
 PWVXyuDSR/3kP3OpENCz5EG9SBIOtfEISnbkk6oFH58A8cugN+wyD3OtSal2WYyCcrBO
 OkLsL+Z7DgiAu5qK+QK87pkFMp60RuxzhZN3IdGQu6/q8uYj6Eigh088lIJYai6N4Eid
 2t4laNLg3JpXkKKWcOs4tbysL1L0xSAnjaHV1X8rk518uWfqtaW77hXnWKcHlQJaK4qd
 EuRxLiTMwQLZY4/9PBNHs+Ow0/vhJShbCoBg3tv4PG8WYRRmvc85CkUxOjrscoc6N1DF Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30grpgnwy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 08:46:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M8fcil137316;
        Wed, 22 Apr 2020 08:46:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30gb3tju2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 08:46:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03M8ke2L014002;
        Wed, 22 Apr 2020 08:46:40 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 01:46:40 -0700
Date:   Wed, 22 Apr 2020 11:46:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     raeds@mellanox.com
Cc:     Boris Pismenny <borisp@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: IPsec, Refactor SA handle creation and
 destruction
Message-ID: <20200422084634.GA190201@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=702 phishscore=0 suspectscore=3 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=733 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=3 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220070
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Raed Salem,

The patch 7dfee4b1d79e: "net/mlx5: IPsec, Refactor SA handle creation
and destruction" from Oct 23, 2019, leads to the following static
checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c:711 mlx5_fpga_ipsec_create_sa_ctx()
	warn: bitwise AND condition is false here

drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
   701                             sizeof(sa_ctx->hw_sa))) {
   702                          context = ERR_PTR(-EINVAL);
   703                          goto exists;
   704                  }
   705  
   706                  ++fpga_xfrm->num_rules;
   707                  context = fpga_xfrm->sa_ctx;
   708                  goto exists;
   709          }
   710  
   711          if (accel_xfrm->attrs.action & MLX5_ACCEL_ESP_ACTION_DECRYPT) {
                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is zero and it's always used like this, so it can never be true.

drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c:762 mlx5_fpga_ipsec_create_sa_ctx() warn: bitwise AND condition is false here
drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c:856 mlx5_fpga_ipsec_release_sa_ctx() warn: bitwise AND condition is false here

   712                  err = ida_simple_get(&fipsec->halloc, 1, 0, GFP_KERNEL);
   713                  if (err < 0) {
   714                          context = ERR_PTR(err);
   715                          goto exists;
   716                  }
   717  
   718                  sa_ctx->sa_handle = err;
   719                  if (sa_handle)
   720                          *sa_handle = sa_ctx->sa_handle;
   721          }
   722          /* This is unbounded fpga_xfrm, try to add to hash */
   723          mutex_lock(&fipsec->sa_hash_lock);
   724  
   725          err = rhashtable_lookup_insert_fast(&fipsec->sa_hash, &sa_ctx->hash,

regards,
dan carpenter
