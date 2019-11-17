Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801B3FFA49
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfKQOan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 09:30:43 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32329 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQOan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Nov 2019 09:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1574001043; x=1605537043;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=Tvw/TZ0weKiMerHL28d0qEr74ibe02jqYRkJyrm9rp4=;
  b=OhyLLw6SHhMvXnl19clO0TGEHlW/eQ4x+9uPwCKyolc52purhGmpXHMA
   EUTF3/k28MTjL9WTrN8nVpAvlmNs6pFFZr0fLj33XYflq23v9MFUtfyms
   0gv9eZXtspzjqGUM3iBCkUzWdqWAsH+oGwdkK6zF7w37+Xui+ciaSGleL
   s=;
IronPort-SDR: FfArU4lwtQjBqSGLNpqtcFOucF8mFRxfkg2LvvoVqtBSQRTtPLN49GGP28TlSGFxmcYqSS2C/9
 ER3GKPDPUNXg==
X-IronPort-AV: E=Sophos;i="5.68,316,1569283200"; 
   d="scan'208";a="3396643"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Nov 2019 14:30:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id BCAB9A1812;
        Sun, 17 Nov 2019 14:30:40 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Nov 2019 14:30:38 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.90) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 17 Nov 2019 14:30:35 +0000
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-rdma@vger.kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Subject: Problem in for-next commit 6ffedfe3ae38 ("IB/umem: remove the dmasync
 argument to ib_umem_get")
Message-ID: <1fda84d9-a4b7-4d3f-fec2-82344e1cb220@amazon.com>
Date:   Sun, 17 Nov 2019 16:30:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D10UWA002.ant.amazon.com (10.43.160.228) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

FYI, looks like something got messed up in commit 6ffedfe3ae38 ("IB/umem: remove
the dmasync argument to ib_umem_get"), it brings back the entire deleted
iwch_provider.c file.
