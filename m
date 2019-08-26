Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53409CEAD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfHZLy2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 07:54:28 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:3564 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbfHZLy2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 07:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566820467; x=1598356467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6XPh9YBf5e0htkGv7Ks6eHPePhskcZY7qGwFMi4gzRI=;
  b=Ko278SkyVK5plQZU48Qg+n5PfCk/OJlavm1xkrMK/GvzRicV6BuTP4aC
   fC82h6WNkRKaB8EGptEgJQiiF7vtV6L4YQHd9GjP7j/tUZarpqRoBIEkQ
   ge9E3aGtOnYQ3G8PsmaEn0OvnfySKEfKeyFx+MxBPRJ7pCa8AFKb9S/9U
   0=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="417655518"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 26 Aug 2019 11:54:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 0D6B8A217F;
        Mon, 26 Aug 2019 11:54:23 +0000 (UTC)
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 11:54:23 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 11:54:22 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.144) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 11:54:18 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/2] EFA cleanups 2019-08-26
Date:   Mon, 26 Aug 2019 14:53:48 +0300
Message-ID: <20190826115350.21718-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

This series introduces two minor cleanups for EFA that were hanging
around in my local git waiting to be submitted.
The patches are very straight forward, nothing intersting to say about
them :)..

Gal Pressman (2):
  RDMA/efa: Remove umem check on dereg MR flow
  RDMA/efa: Use existing FIELD_SIZEOF macro

 drivers/infiniband/hw/efa/efa_verbs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.22.0

