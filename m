Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7E352A5A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBLrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 07:47:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53146 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBLrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 07:47:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132BcklS108604;
        Fri, 2 Apr 2021 11:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s86nNGXjuQO3BIkeVvSlQRzc9bKAV2oQ8jed6Z2e3HU=;
 b=XizUMFnRdxrvpdhLZZDNaT9Vr14PnUnxWqXc9xaUE8ob/WhP9XBptaWf4WiyKtM0+USM
 HV5pubFSSvTikTyTjnjqaHTdpKjyMiMH+ukDbbe6m4Ols7Bp9MC5JOXaYrGTM7C2ro63
 IDsIM4LEhtFadLDZeTlWavJhKygz631O8NbGLAK/MpWi+0526fvnLUHJSraLiaCiRtwk
 Eq00wVUQm0KYJwotwEhBwy2YfaK/bqIaZ4HRkZx6zd42T/walynPP8wzF01vAzmT8Xj9
 g//r0KY+28WVQeOfgGW6Yx0Aers6RNk9I/roHusQSd3U7hUoe+6nrIGk88VvN36+L4CA xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dve46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 11:47:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132Bdg3a037341;
        Fri, 2 Apr 2021 11:47:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 37n2atyu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 11:47:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 132BlVAO014148;
        Fri, 2 Apr 2021 11:47:31 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Apr 2021 11:47:30 +0000
Date:   Fri, 2 Apr 2021 14:47:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/addr: potential uninitialized variable in
 ib_nl_process_good_ip_rsep()
Message-ID: <YGcES6MsXGnh83qi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020086
X-Proofpoint-GUID: x-PxymaAPF3LEccK0jkXjXt0TExl6ZHs
X-Proofpoint-ORIG-GUID: x-PxymaAPF3LEccK0jkXjXt0TExl6ZHs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020086
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The nla_len() is less than or equal to 16.  If it's less than 16 then
end of the "gid" buffer is uninitialized.

Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I just spotted this in review.  I think it's a bug but I'm not 100%.

 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0abce004a959..a037ba4424bf 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -98,7 +98,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
 	const struct nlattr *head, *curr;
-	union ib_gid gid;
+	union ib_gid gid = {};
 	struct addr_req *req;
 	int len, rem;
 	int found = 0;
-- 
2.30.2

