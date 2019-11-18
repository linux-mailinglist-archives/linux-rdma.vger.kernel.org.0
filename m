Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CA100C69
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 20:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRTys (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 14:54:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRTys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 14:54:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJsK6m110830;
        Mon, 18 Nov 2019 19:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=j1BXwsUDklwenftg815pFd1iW2NIFhwDjT4BkXgsHYo=;
 b=dzOSmpP3vC/mDY5UCofTguW0WlQ6foqFkUkEKkVGNiUfD0FQbac8fqegWCsvvuC7kLgP
 adnGyljTHWvJxvIzjJxjn4Fmx/84Rv1J/VwFpyQ0/wwI90j0V3hiIYGcDtnIn7RMGmjf
 0AOAUjanJxH9QxUHR44LRKb6KWIZm+XQDhhE0q5Hc1wemGM08r+s74cF2c7PW86RqDs1
 wUAgsr2g0/PHPF3WSZdo/JZ1bEO/c8SbbXeLDnjLIShmhb86NByXvulwBhsoJK6A2wzs
 /q9xydaYIhMGXJI9xJ+rs1hXgRwcVm5Ve7tq5Z2aMot43YZVi/Mk8o9DhHL8BwX/Ocyw /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htjk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 19:54:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJs5aF146997;
        Mon, 18 Nov 2019 19:54:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2wc09w4kyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 19:54:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAIJsd7I149983;
        Mon, 18 Nov 2019 19:54:39 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2wc09w4kxp-1;
        Mon, 18 Nov 2019 19:54:39 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rao.shoaib@oracle.com
Subject: [PATCH v2 0/2] rxe should use same buffer size for SGE's and inline data
Date:   Mon, 18 Nov 2019 11:54:37 -0800
Message-Id: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=955 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180170
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

 drivers/infiniband/sw/rxe/rxe_param.h |  3 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
1.8.3.1

