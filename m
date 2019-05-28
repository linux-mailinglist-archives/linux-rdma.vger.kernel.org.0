Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA762C6EB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE1Mqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 08:46:51 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16891 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1Mqu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559047610; x=1590583610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z8P1x3T/i9VLkXUcjV66qqt5b5l7OgosbkTv+ci9cf0=;
  b=MWWJP6oCirc6H5SSRJ7d99+XvAVhd1Qz1aUYPZVipRZvn1N98wxf7XIl
   38hdnIgABtOA3wwWEkwEaArEiNCYYuTjb3cz3w/izozHV8CXA+xkaEU9X
   DGcIaHbIQZ7O+EqETMCn/5/JIU3ZTgzs4z+LdjXwcK37jkusRPC3lB8QW
   k=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="676767341"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 12:46:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4SCki48019409
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 12:46:46 GMT
Received: from EX13D19EUB004.ant.amazon.com (10.43.166.61) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:46 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB004.ant.amazon.com (10.43.166.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 12:46:45 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.129) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:46:42 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc 0/6] EFA updates 2019-05-28
Date:   Tue, 28 May 2019 15:46:12 +0300
Message-ID: <20190528124618.77918-1-galpress@amazon.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This series introduces misc updates that were discussed on-list to the
EFA driver.

I've sent this series to for-rc as EFA is a new driver and there's no
real regression danger here, but I'm fine with applying these changes to
for-next instead.

Thanks,
Gal

Gal Pressman (6):
  RDMA/efa: Remove MAYEXEC flag check from mmap flow
  RDMA/efa: Use kvzalloc instead of kzalloc with fallback
  RDMA/efa: Remove unneeded admin commands abort flow
  RDMA/efa: Use API to get contiguous memory blocks aligned to device
    supported page size
  RDMA/efa: Use rdma block iterator in chunk list creation
  RDMA/efa: Remove unused includes

 drivers/infiniband/hw/efa/efa.h         |   2 -
 drivers/infiniband/hw/efa/efa_com.c     |  74 +----------
 drivers/infiniband/hw/efa/efa_com.h     |   1 -
 drivers/infiniband/hw/efa/efa_com_cmd.c |   1 -
 drivers/infiniband/hw/efa/efa_verbs.c   | 157 ++++++++----------------
 5 files changed, 49 insertions(+), 186 deletions(-)

-- 
2.21.0

