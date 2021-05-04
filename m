Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261BB3726CD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhEDHvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 03:51:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47860 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEDHvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 May 2021 03:51:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1447e0A2098018;
        Tue, 4 May 2021 07:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DeMalEzqOkSq9HdbtMkUcPMgYKsbz8okBDOm5TdXKWo=;
 b=OEG6d1X1TYhHz6OH8WEO2Qldb4SUrANzpUd7dpsPmnRBIYJhWFZtIE6P6THBjZd/X+wJ
 rg2FBRfkxmJnK1PsLYt343PoAjli1SdxMqmXVAN2BwQyZdRrLZLFeP1Us+rcLqfhH7wb
 zfE1NUD3LQ9maNY9hsChzQrrDpZuGdUWLmmgn9yB6LX9mdJp1fjC+o6SdM4oHklOkIK0
 3Jr3T5gKRVFz9vYn8dnCUsJZyMhAHYzF002Omh1eP49Ed4s4HqXI1362JRuofZuug059
 vwjP9nqWV9Qm6qBg9czXNZKPBe5zFUVtVPtHGq2RYfzYvPMeWtlpL6FzV7fUpmyt7grG Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 388xxmwwxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 07:50:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1447fDA2151320;
        Tue, 4 May 2021 07:50:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 388v3vye5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 07:50:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1447k3Yh167532;
        Tue, 4 May 2021 07:50:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 388v3vye56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 07:50:51 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1447ooxv008599;
        Tue, 4 May 2021 07:50:50 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 May 2021 00:50:50 -0700
Date:   Tue, 4 May 2021 10:50:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     maorg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/mlx5: Add support in MEMIC operations
Message-ID: <YJD81HgeXxGUMaik@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: B0vzAgExI9b7et2G9qcP3ewjkZtUlHtb
X-Proofpoint-ORIG-GUID: B0vzAgExI9b7et2G9qcP3ewjkZtUlHtb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040058
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Maor Gottlieb,

The patch cea85fa5dbc2: "RDMA/mlx5: Add support in MEMIC operations"
from Apr 11, 2021, leads to the following static checker warning:

	drivers/infiniband/hw/mlx5/dm.c:220 mlx5_ib_handler_MLX5_IB_METHOD_DM_MAP_OP_ADDR()
	error: undefined (user controlled) shift '(((1))) << op'

drivers/infiniband/hw/mlx5/dm.c
   204  static int UVERBS_HANDLER(MLX5_IB_METHOD_DM_MAP_OP_ADDR)(
   205          struct uverbs_attr_bundle *attrs)
   206  {
   207          struct ib_uobject *uobj = uverbs_attr_get_uobject(
   208                  attrs, MLX5_IB_ATTR_DM_MAP_OP_ADDR_REQ_HANDLE);
   209          struct mlx5_ib_dev *dev = to_mdev(uobj->context->device);
   210          struct ib_dm *ibdm = uobj->object;
   211          struct mlx5_ib_dm_memic *dm = to_memic(ibdm);
   212          struct mlx5_ib_dm_op_entry *op_entry;
   213          int err;
   214          u8 op;
   215  
   216          err = uverbs_copy_from(&op, attrs, MLX5_IB_ATTR_DM_MAP_OP_ADDR_REQ_OP);
                                        ^^
op is user controlled and in the 0-255 range.

   217          if (err)
   218                  return err;
   219  
   220          if (!(MLX5_CAP_DEV_MEM(dev->mdev, memic_operations) & BIT(op)))
                                                                      ^^^^^^^
If it's more than 31 then this is undefined (shift wrapping generally).
Plus it might trigger a UBSan warning at run time.

   221                  return -EOPNOTSUPP;
   222  
   223          mutex_lock(&dm->ops_xa_lock);

regards,
dan carpenter
