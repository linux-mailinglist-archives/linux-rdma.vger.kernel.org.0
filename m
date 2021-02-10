Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22477316187
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBJIzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 03:55:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBJIw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 03:52:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A8oU1s175847;
        Wed, 10 Feb 2021 08:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Jqvy9RDsn07XhpQN7tGZuz3EtBVgYIhd+eG/44NJcnc=;
 b=pKkx0lDAQSc1otQe7C9W9pV7oywqC6CTeHWaf/Tn/ddYcaN+5Jp114FmS+YqMw4utArh
 eO12JM86RNM0e+w3ZdL3BCPWn+4Udo81EIwbuh2TiHMhkBdGMSx79IPpAcNlOHaCYsBK
 w6qM32xiDR25Txllrj3RH55jsI72NbWxjfTa+v2Slico8aUlDvvG008LH7hJqpPg92Pp
 TJxqO6EVXYFcx7RkE9Vf0WhcD2C4QpJrJPN5KW9NW2rQZU2xZVGiII1FlGOh3Z5GEzxq
 vfKcetSlhcTpYDtrbNqaM9IbquzRIclrAHmjhH+576sDHvv6ngTF3K2zh8jdp84D2/FX 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4ups05k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 08:51:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A8oheF119010;
        Wed, 10 Feb 2021 08:51:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36j4vsh85j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 08:51:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11A8pu4g028885;
        Wed, 10 Feb 2021 08:51:56 GMT
Received: from mwanda (/10.175.190.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 00:51:56 -0800
Date:   Wed, 10 Feb 2021 11:51:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vladbu@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: E-Switch, Maintain vhca_id to vport_num
 mapping
Message-ID: <YCOep5XDMt5IM/PV@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100090
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100090
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Vlad Buslov,

The patch 84ae9c1f29c0: "net/mlx5e: E-Switch, Maintain vhca_id to
vport_num mapping" from Sep 23, 2020, leads to the following static
checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/vport.c:1170 mlx5_vport_get_other_func_cap()
	warn: odd binop '0x0 & 0x1'

drivers/net/ethernet/mellanox/mlx5/core/vport.c
  1168  int mlx5_vport_get_other_func_cap(struct mlx5_core_dev *dev, u16 function_id, void *out)
  1169  {
  1170          u16 opmod = (MLX5_CAP_GENERAL << 1) | (HCA_CAP_OPMOD_GET_MAX & 0x01);

HCA_CAP_OPMOD_GET_MAX is zero.  The 0x01 is a magical number.

  1171          u8 in[MLX5_ST_SZ_BYTES(query_hca_cap_in)] = {};
  1172  
  1173          MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
  1174          MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
  1175          MLX5_SET(query_hca_cap_in, in, function_id, function_id);
  1176          MLX5_SET(query_hca_cap_in, in, other_function, true);
  1177          return mlx5_cmd_exec_inout(dev, query_hca_cap, in, out);
  1178  }

regards,
dan carpenter
