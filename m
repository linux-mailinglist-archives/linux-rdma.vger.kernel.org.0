Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C892A2627
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgKBIc6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 03:32:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgKBIc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 03:32:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A28TSTL150766;
        Mon, 2 Nov 2020 08:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=KSymEnRa+9K099ANpmCQECO5JBQhVzr6VLQmxrXeA7U=;
 b=OqH8DPWirYntU9kx8sDyP81QRBWuG/033pRxpX2CZSk2q1m+JM/3p4JT7IDoYGxDhWd2
 sXfg3aYNfIWBsFLg/lV2BBnRQHJ3EQ7Kmqm73d1+QieupvTlw/O7k93uD+9HLuAPDegU
 0pJFhfjLe2yYW6jIVYzj/vh42KyoCOQT0H8ygI/Jy6FjvxnRrgNBo6/eYFRnSouUE5FR
 cPv7BOeObP6BFbPVc/TEs2c/CruO+wzKZrjS9kWojh7qFQwGdIQcKvJYYGc5jbTgYyqI
 WWSWc+kxVluIN5Etf3CbXcUTUgtsJtvo+Dnfm+/3IxBunf0FKMW6FLYqmwT3VeVwSGQL TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34hhvc2js6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 08:32:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A28UQ81035674;
        Mon, 2 Nov 2020 08:32:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0eqw6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 08:32:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A28Wr1Q032509;
        Mon, 2 Nov 2020 08:32:54 GMT
Received: from mwanda (/10.175.190.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 00:32:53 -0800
Date:   Mon, 2 Nov 2020 11:32:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vuhuong@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-Switch, Refactor eswitch ingress acl codes
Message-ID: <20201102083248.GA194043@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=3 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020067
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Vu Pham,

The patch 07bab9502641: "net/mlx5: E-Switch, Refactor eswitch ingress
acl codes" from Mar 27, 2020, leads to the following static checker
warning:

	drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c:184 esw_acl_ingress_lgcy_setup()
	warn: passing zero to 'PTR_ERR'

drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
  163          if (MLX5_CAP_ESW_INGRESS_ACL(esw->dev, flow_counter)) {
   164                  counter = mlx5_fc_create(esw->dev, false);
   165                  if (IS_ERR(counter)) {
   166                          esw_warn(esw->dev,
   167                                   "vport[%d] configure ingress drop rule counter failed\n",
   168                                   vport->vport);
   169                          counter = NULL;
   170                  }
   171                  vport->ingress.legacy.drop_counter = counter;
   172          }
   173  
   174          if (!vport->info.vlan && !vport->info.qos && !vport->info.spoofchk) {
   175                  esw_acl_ingress_lgcy_cleanup(esw, vport);
   176                  return 0;
   177          }
   178  
   179          if (!vport->ingress.acl) {
   180                  vport->ingress.acl = esw_acl_table_create(esw, vport->vport,
   181                                                            MLX5_FLOW_NAMESPACE_ESW_INGRESS,
   182                                                            table_size);
   183                  if (IS_ERR_OR_NULL(vport->ingress.acl)) {
   184                          err = PTR_ERR(vport->ingress.acl);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
esw_acl_table_create() doesn't return NULL, but if it did that would
mean "err = 0;" (ie.  The success path).

When a function returns both error pointers and NULL then the NULL
return is meant to be an optional thing where the feature has been
manually disabled by the admin or by the kernel config.

   185                          vport->ingress.acl = NULL;
   186                          return err;
   187                  }
   188  
   189                  err = esw_acl_ingress_lgcy_groups_create(esw, vport);
   190                  if (err)
   191                          goto out;
   192          }
   193  
   194          esw_debug(esw->dev,
   195                    "vport[%d] configure ingress rules, vlan(%d) qos(%d)\n",
   196                    vport->vport, vport->info.vlan, vport->info.qos);

regards,
dan carpenter
