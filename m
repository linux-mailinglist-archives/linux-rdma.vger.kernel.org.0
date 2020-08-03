Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53A239F8E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHCGUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHCGT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:19:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736Htpr004437;
        Mon, 3 Aug 2020 06:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=UpGU7Uu1lTbtrzgO96rZGMR3/hytXQCB/FxyrwW2/mo=;
 b=SNToQQeWuyeg9SiEiLsTNBys4VBzC1Kk6z2TXFxhqVnDezvgaUfZOdvj3Rh0Wl40AlBo
 Ergbbmdr+jo1cKA3Rcsl6jOXaBi8Wjfpwuu+jKW92xCrxTjrxoT7n/AqqoYnXZFbzmng
 BmmxhQi3MIZtYUo/U2rqJSBqHTq2XX0RRZtfVqzxa7Blo3Vt7wIrxJ23zA6tx7TCm3ik
 LL7Z6PBfNBUM0TrDW3Xkjf7R3+DKTHw55WD6tYvQobV20ZelIjpiSEnBd6bHqwBiHZ+m
 qELYmCCmhaOXm5NcaXFTzuqgLYWZAJKwrIM2eqI39VmMQmHfoHZ6NTN4W6SRLZreXWI5 XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32nc9yb6qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:19:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736Ipn7163926;
        Mon, 3 Aug 2020 06:19:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32nj5phvhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:19:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0736Jpkv006099;
        Mon, 3 Aug 2020 06:19:51 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:19:51 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 0/6] Add CM packets missing and harden the proxying
Date:   Mon,  3 Aug 2020 08:19:35 +0200
Message-Id: <20200803061941.1139994-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A high number of MAD packet drops are observed in the mlx4 MAD proxy
system. These are fixed by separating the parameters for the tunnel
vs. wire QPs and by introducing a separate worker-thread for the wire
QPs.

Support for MRA and REJ with its reason being timeout is also added.

Dynamic debug prints adjusted and amended.

    v1->v2:
	* Added commit ("Adjust delayed work when a dup is observed")
	* Minor adjustments in some of the commits

Håkon Bugge (6):
  IB/mlx4: Add and improve logging
  IB/mlx4: Add support for MRA
  IB/mlx4: Separate tunnel and wire bufs parameters
  IB/mlx4: Fix starvation in paravirt mux/demux
  IB/mlx4: Add support for REJ due to timeout
  IB/mlx4: Adjust delayed work when a dup is observed

 drivers/infiniband/hw/mlx4/cm.c      | 148 ++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx4/mad.c     | 158 +++++++++++++++------------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |   8 +-
 3 files changed, 241 insertions(+), 73 deletions(-)

--
2.20.1

