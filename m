Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905D0F8B8C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLJRu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 04:17:50 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:65208 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLJRu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 04:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573550270; x=1605086270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9a4epLm8KwOucfdmvw2sExVvuMcteMvVgknekQ4yQ9s=;
  b=cRlQgw0JjMh3r9OKYmU0msCoKfgJmHCrVXGWw0Oh2/1rG+OzpctJbA4l
   e5HW2TmgrcC9I4JRcgR12n6SetbhJO3QVn10QMpo+yi9IUlFWizmInDRP
   DJEhUWrJOPs/bha2UPax8FAPJfkhMApm8EfxmdrEtBju5rbZkpXgOFIBj
   Y=;
IronPort-SDR: +nhLJDNX4kj1TLaQ6i0g/F8i/6//pgvPB+XpUjhgZQV8TRMA4wLY9qbgc//3s64papF/ySu0nd
 KBbeoYobIl+A==
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Nov 2019 09:17:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id DDE86A2278;
        Tue, 12 Nov 2019 09:17:47 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:47 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:46 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 12 Nov 2019 09:17:43 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/3] EFA RDMA read support
Date:   Tue, 12 Nov 2019 11:17:34 +0200
Message-ID: <20191112091737.40204-1-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

The following series introduces RDMA read support and capabilities
reporting to the EFA driver.

RDMA read support, maximum transfer size and max SGEs per RDMA WR are
now being reported to the userspace library through the extended query
device verb. 
In addition, remote read access is supported by the register MR verb.

PR was sent:
https://github.com/linux-rdma/rdma-core/pull/613

Thanks,
Gal

Daniel Kranzdorf (2):
  RDMA/efa: Support remote read access in MR registration
  RDMA/efa: Expose RDMA read related attributes

Gal Pressman (1):
  RDMA/efa: Store network attributes in device attributes

 drivers/infiniband/hw/efa/efa.h               |  2 -
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 29 ++++++++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 40 ++++++++-----------
 drivers/infiniband/hw/efa/efa_com_cmd.h       | 19 +++------
 drivers/infiniband/hw/efa/efa_main.c          | 16 --------
 drivers/infiniband/hw/efa/efa_verbs.c         | 31 +++++++++-----
 include/uapi/rdma/efa-abi.h                   |  9 +++++
 7 files changed, 79 insertions(+), 67 deletions(-)

-- 
2.23.0

