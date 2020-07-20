Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88342225E6F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 14:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgGTMXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 08:23:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgGTMXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 08:23:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCIWN5138221;
        Mon, 20 Jul 2020 12:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mwMqoiYligQWyp9UasYPVuaAYUJI64jUuwngYCkVWGE=;
 b=zcLP/lONLQBFqfQVsteotezTKcvB6Yh+FrVRxl5FVAjwnUpM/D5UtubrmWbA5WU+bOLJ
 cFQulG/vBGhM37I+DGntprAq2+gWGng7qkKIIWYeo7/7YMzpcq59i79CSp3obbDyWdmT
 Z35okxKWBK5Ve4EMsieqzYLhjZ+8+Hx36uHtzgg+uxEkqQGwaaakrfyJaA/xafpZ5hpW
 9BtpcMvOP2KNp3+fDKHr0jeg4Epn97vvbFvmQBuF1pQIp8Jpxf/j/gV+QxV71TkWKIF6
 tizpADt94gqI6fxtL7SymgZ6Fy5so6F1EimpeJ71zpJIoNDS1OsHHjCXbIArOAuy7TGy ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32bs1m6jpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 12:23:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCGx0q067558;
        Mon, 20 Jul 2020 12:23:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32d9wb4acd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:23:01 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KCN0ms007124;
        Mon, 20 Jul 2020 12:23:00 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 05:23:00 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: [PATCH for-rc 0/5] Add CM packets missing and harden the proxying
Date:   Mon, 20 Jul 2020 14:22:44 +0200
Message-Id: <20200720122249.487086-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
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

Håkon Bugge (5):
  IB/mlx4: Add and improve logging
  IB/mlx4: Add support for MRA
  IB/mlx4: Separate tunnel and wire bufs parameters
  IB/mlx4: Fix starvation in paravirt mux/demux
  IB/mlx4: Add support for REJ due to timeout

 drivers/infiniband/hw/mlx4/cm.c      | 143 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx4/mad.c     | 121 +++++++++++++----------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |   6 ++
 3 files changed, 211 insertions(+), 59 deletions(-)

--
2.20.1

