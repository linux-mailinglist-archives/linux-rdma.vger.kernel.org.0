Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7B61ECDA1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCKeo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 06:34:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37288 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCKeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 06:34:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053AWftE190825;
        Wed, 3 Jun 2020 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+K29LhdQYv+upXE0bZAc0K2Rc0ly+aoA/w5eTyFD4Sc=;
 b=brwBWdFkJu//I660zn8AxWtm8x/R57XokP7PKpmYpG782jv5s3nVQEfwinNX+pwY1GT/
 XiZQCqCiVis7vMpeqd9rDOPwywaaWFXLghg0WHy7EXed/+aLa02BfEwY13VnGd9m5iB+
 2Hu3XHQaLOA+QnF0kQzcJn4hLefm5hcPyJwoYYhyfsIuDhbxZ7zzvf9ZWDsw2zo5Y8hy
 mS76clTOPURN0RMkZ6ucCWhOXfJVggU3NrDPGT+8e4w9zgfAYPp/g8nprTaSYG1ndGUA
 Sg0QH3cNvINJn5Bzvou/3WEwCJ9gUxHRb19sjpfPgf6Q9taeAnJ6JxdM2JY/LDL78xKK gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31bfem8ga7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 10:34:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053ATIqg025252;
        Wed, 3 Jun 2020 10:34:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31c1dyswwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 10:34:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 053AYdx5008768;
        Wed, 3 Jun 2020 10:34:39 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:34:39 -0700
Date:   Wed, 3 Jun 2020 13:34:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vuhuong@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-switch, Offloads shift ACL programming
 during enable/disable vport
Message-ID: <20200603103433.GD1845750@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=759
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=3 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 mlxlogscore=801 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030082
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Vu Pham,

The patch 748da30b376e: "net/mlx5: E-switch, Offloads shift ACL
programming during enable/disable vport" from Oct 28, 2019, leads to
the following static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1979 esw_create_uplink_offloads_acl_tables()
	error: 'vport' dereferencing possible ERR_PTR()

drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
  1970  static int esw_create_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
  1971  {
  1972          struct mlx5_vport *vport;
  1973          int err;
  1974  
  1975          if (esw_use_vport_metadata(esw))
  1976                  esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
  1977  
  1978          vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);

No error checking.

  1979          err = esw_vport_create_offloads_acl_tables(esw, vport);
  1980          if (err)
  1981                  esw->flags &= ~MLX5_ESWITCH_VPORT_MATCH_METADATA;
  1982          return err;
  1983  }

regards,
dan carpenter
