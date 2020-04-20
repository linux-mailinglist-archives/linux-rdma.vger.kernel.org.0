Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7C1B0182
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTGWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 02:22:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26065 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTGWa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Apr 2020 02:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587363750; x=1618899750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jGgZPBfhjA1AzYp6/2iVroWc+GoZYq4nNO7VfjII1zc=;
  b=VgZ6mRLGnVK/VMP7PFrmbND9rGxe6bcCHamoFLvJcrbjQTEGMh15tOV+
   qHBWwEz6uSktGY8Dt+/fNzQxameO/AwtG91sEHJoEBD9+xCWD6QyceVfq
   8nTv1ultyIv38PkEPzf9/i0t0K1BEM+OREY0047f/gV3aVDdnPV/bx4CO
   k=;
IronPort-SDR: 9QOh8DxhfAIu3iWukW/9A0wyT8ySvTHXZmCXyxl989Sor2DUGbHKtUGLLqGj6+NqXrLQUGeTB8
 UDPqssAn0LgA==
X-IronPort-AV: E=Sophos;i="5.72,405,1580774400"; 
   d="scan'208";a="39425452"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Apr 2020 06:22:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 2C64BA1FAE;
        Mon, 20 Apr 2020 06:22:26 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:26 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.20) by
 mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Apr 2020 06:22:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/3] EFA statistics minor updates
Date:   Mon, 20 Apr 2020 09:22:10 +0300
Message-ID: <20200420062213.44577-1-galpress@amazon.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains three small patches to collect a few counters we
found helpful when encountering different issues.

Regards,
Gal

Gal Pressman (3):
  RDMA/efa: Report create CQ error counter
  RDMA/efa: Count mmap failures
  RDMA/efa: Count admin commands errors

 drivers/infiniband/hw/efa/efa.h       |  3 ++-
 drivers/infiniband/hw/efa/efa_com.c   |  5 ++++-
 drivers/infiniband/hw/efa/efa_com.h   |  3 ++-
 drivers/infiniband/hw/efa/efa_verbs.c | 13 +++++++++++--
 4 files changed, 19 insertions(+), 5 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.26.1

