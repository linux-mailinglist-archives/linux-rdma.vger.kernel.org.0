Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366ADE21D6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfJWReJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 13:34:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfJWReJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 13:34:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NHT0dL190401;
        Wed, 23 Oct 2019 17:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=v5WNcs4g10siyBcOLnqcoMIG80ASzIyEaX700f+qp9E=;
 b=fmzdiIxNo1VSSS49/ElgzGX8s5/x6Lf32ZNuz3N23Er4+bMMhknkRDF2F+PYq4L2+D9l
 Rs21jm7TN3Hg8xko1cGyWOfo0EwpBsH2Yx4YZfHQEsHQIoSwJZbG3B824ezKGrcJ7w9y
 ZVAq3gANxaJhYSK3KjPjlZUsjGgZLUAxEtvQuNsryIqVkK21XeBauzqnMLj26BWgwNr/
 oDZKjztIXJsu37r9aPIo7e3ADyNnF0F15dJqx5JtZOq1u2G/nlupi4Gyvey05GTcPwBb
 aI5f4MjtPp5cJwmYPzOf/8XLL1kxFqeh4026HexjDGW70+PmIrVVTTTgD31HX44g6hS/ EA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtepxv5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 17:33:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NHXjjs069906;
        Wed, 23 Oct 2019 17:33:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2vtm22kx67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 17:33:56 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9NHXnFM070572;
        Wed, 23 Oct 2019 17:33:49 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by aserp3030.oracle.com with ESMTP id 2vtm22kwep-1;
        Wed, 23 Oct 2019 17:33:49 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v1 0/1] rxe driver should dynamically caclculate inline data size
Date:   Wed, 23 Oct 2019 10:32:36 -0700
Message-Id: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=902 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230167
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

Resending because of typo in the email addresses.

Currently rxe driver has a hard coded value for inline data size, where as mlx5 driver calculates the size of inline data and number of SGE's to use based on the values in the qp request. Some applications depend on this behavior. This patch changes rxe to dynamically calculate the values.

Rao Shoaib (1):
  rxe: calculate inline data size based on requested values

 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.3.1

