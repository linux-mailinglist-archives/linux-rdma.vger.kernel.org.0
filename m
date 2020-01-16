Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18813F1BA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392225AbgAPSao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 13:30:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387439AbgAPSan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 13:30:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI8PS2056063;
        Thu, 16 Jan 2020 18:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=ZMupfJuDLsp3z5XCn4hed8rVhp5oeLY7ig+E85dpO8E=;
 b=DnrJK9e1O86RoB93MNmYhm/tHOvgMl/Lp8CUxLMe6tARWQzbc6tIbXTLlHLlT+NUWiuE
 SAGcV9T59Jxrw8+MErMfc//vRI0uZbDoZXxeozzGalpVdMrWld3hFo4hFQDkd1QtE95r
 s+GhjhA9SBkIYR8cDnv7FA99izvdhmm3x4LnSHORcoya73d4QSaIbd7+5xzmShoFov6F
 7zQJgM5Y2+KRSXBQ5o4xWq0gyvNjJSPMCTK+apW5KBgvH5OOwqIWlxIlRhMGz0kr2RMQ
 PQnRPs93pi4bRq7TJa295XxEqrkh5wUmOyxeu6OlikfzoVPH+sHteIN7oK3kMah1tUXE 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sm9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 18:30:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI9M1k124332;
        Thu, 16 Jan 2020 18:30:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xj1ptjdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 18:30:31 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00GIU9eu190457;
        Thu, 16 Jan 2020 18:30:30 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xj1ptjdxt-1;
        Thu, 16 Jan 2020 18:30:30 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v4 0/2] RDMA/rxe: rxe should use same buffer size for SGE's and inline data
Date:   Thu, 16 Jan 2020 10:30:10 -0800
Message-Id: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160147
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Incorportaed suggestions from Jason. There are two patches.
Patch #1 introduces max WQE size as suggested by Jason
Patch #2 allocates resources requested and makes sure that the buffer size
         is same for SG entries and inline data, maximum of the two values
         requested is used.

Rao Shoaib (2):
  RDMA/rxe: use RXE_MAX_WQE_SIZE to enforce limits
  RDMA/rxe: SGE buffer and max_inline data must have same size

 drivers/infiniband/sw/rxe/rxe_param.h |  7 ++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

-- 
1.8.3.1

