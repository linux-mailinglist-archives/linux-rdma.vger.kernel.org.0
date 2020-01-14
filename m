Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65A139E6A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 01:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgANAlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 19:41:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44170 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgANAlq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 19:41:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0cqwv065758;
        Tue, 14 Jan 2020 00:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=xqsf6ckW2iSZpQMx8EIfUWF7V/K4/38oY1N43NbDuV0=;
 b=Btp5NfufyotUpB3sCKItejZ9pGvhrFM9OUUVsiXtqV0+6jh9wI3DVlmcyUqFPFQ3EkjN
 W0dpoCfP63n1c0rn1VgFzTiG37JLwWkbkIxw9orDWteUrn1gfQ2uK6R2/zO3yWeY5Jm+
 iQHd30s0nX62DvRd4o/VF9kGcqAkPdcfd8DLeKf61vG9s9xFQcOBJHhdj8zufJ3+4Q6K
 L3zUtAxpbWhOzrq0qxGKTRa4QPVZxTihdprPMCV40RpB9r1Vp9hYWb7T/3m2LxbfoRz9
 2FjSwtapsQ6MNoB9Pb9jIrGxl5BY/6y54VuQsf6GrIL3A5dqYpHWagZd6wf9aGclxo76 qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73tjfn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 00:41:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0d6sl057212;
        Tue, 14 Jan 2020 00:41:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xfrgjmaek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 00:41:38 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00E0fbfh067024;
        Tue, 14 Jan 2020 00:41:37 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xfrgjmae0-1;
        Tue, 14 Jan 2020 00:41:37 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v3 0/2] rxe should use same buffer size for SGE's and inline data
Date:   Mon, 13 Jan 2020 16:41:18 -0800
Message-Id: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=880 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140003
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

I have incorportaed suggestions from Jason. There are two patches.
Patch #1 introduces max WQE size as suggested by Jason
Patch #2 allocates resources requested and makes sure that the buffer size
         is same for SG entries and inline data, maximum of the two values
	 requested is used.

Rao Shoaib (2):
  Introduce maximum WQE size to check limits
  SGE buffer and max_inline data must have same size

 drivers/infiniband/sw/rxe/rxe_param.h |  7 ++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 23 +++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
1.8.3.1

