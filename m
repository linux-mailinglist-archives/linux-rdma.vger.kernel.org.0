Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89143EAF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfFMPwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:52:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4663 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfFMJKf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 05:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560417034; x=1591953034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bl9sjunFFQaUDLdSuwplIlN9HRd1Iol9DAeVsFR0krU=;
  b=sbMS2fiEXa7g0siv1AmQVFU2q3+8wxfJkbQMN8p+p08t1im9dXNt+pO8
   +l49rlz0AzMOjeuhwQ05x9kYKMAg7ICUTugfWOVFVvgusufDYl65QCh1P
   3do8CGwMHaud8UlZD0XfLLSV0B8D/w41QOqxE8Zyq94SSP13R+5JqpAXb
   k=;
X-IronPort-AV: E=Sophos;i="5.62,369,1554768000"; 
   d="scan'208";a="679689305"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Jun 2019 09:10:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id C7A87A1BD4;
        Thu, 13 Jun 2019 09:10:31 +0000 (UTC)
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:31 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Jun 2019 09:10:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.75.47) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 13 Jun 2019 09:10:27 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/3] EFA updates 2019-06-13
Date:   Thu, 13 Jun 2019 12:10:11 +0300
Message-ID: <20190613091014.93483-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Patch #1 makes use of Shiraz's new API including a fix to Jason's
comment to check for zero return value.
Patch #2 is a cleanup making the driver more consistent.
Patch #3 adds more information to our error prints, which proved useful
in our debugging process.

Thanks,
Gal

Firas Jahjah (1):
  RDMA/efa: Print address on AH creation failure

Gal Pressman (2):
  RDMA/efa: Use API to get contiguous memory blocks aligned to device
    supported page size
  RDMA/efa: Be consistent with success flow return value

 drivers/infiniband/hw/efa/efa_com_cmd.c |  7 +-
 drivers/infiniband/hw/efa/efa_main.c    |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c   | 94 +++++++------------------
 3 files changed, 30 insertions(+), 73 deletions(-)

-- 
2.22.0

