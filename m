Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFA3B43FA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYNFm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 09:05:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFYNFl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 09:05:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PD2B8l018209;
        Fri, 25 Jun 2021 13:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ITP1MH3m241ptYlgCn0u0jldmC7ori0GDyZfgxqd5a8=;
 b=XTMUBKtDcRoLN8e03mruLRqhslv7Ivu5PY1HUWiYlczAZ4Psb/G6PDUn/SeStay7cB1E
 /TjGESYcfqvH8RKhiwUtnz+dflEGnUbBzpI2PP09OO+48W1D+BDcSwZ6Mz9sO2xajvQ4
 teslV4RlmuEPH2MsE9FTqhoGXCn+TwvHi3eUCCqbx22/6Sz3oYaLea/31UuEPdKHhwC/
 tZtJFG9YmSn14DIxyLjuG0iKehqUbYWPZ7SbuLl5qEswT4UJPqgEh34mBLZRewDqSvor
 I+MJc6YrTaO4LSlAXu2mu4EI440OGlZMmbbbSu1YKruYm3K5C4l5uoXCPewk2AhN2YDo nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2pe9977-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:03:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PD1OBm051648;
        Fri, 25 Jun 2021 13:03:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39d23y27mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:03:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PD21lo053816;
        Fri, 25 Jun 2021 13:03:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 39d23y27kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:03:14 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PD3De0030317;
        Fri, 25 Jun 2021 13:03:13 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 06:03:12 -0700
Date:   Fri, 25 Jun 2021 16:03:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
Message-ID: <YNXUCmnPsSkPyhkm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: ilusytOlfk-QwfjvnG_0JnGSXW4hVBts
X-Proofpoint-ORIG-GUID: ilusytOlfk-QwfjvnG_0JnGSXW4hVBts
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This error path needs to unlock before returning.

Fixes: ec0fa2445c18 ("RDMA/rxe: Fix over copying in get_srq_wqe")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I'm sort of surprised this one wasn't caught in testing...

 drivers/infiniband/sw/rxe/rxe_resp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 72cdb170b67b..3743dc39b60c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -314,6 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 
 	/* don't trust user space data */
 	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
+		spin_unlock_bh(&srq->rq.consumer_lock);
 		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
 		return RESPST_ERR_MALFORMED_WQE;
 	}
-- 
2.30.2

