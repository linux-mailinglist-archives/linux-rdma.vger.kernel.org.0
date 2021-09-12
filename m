Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E8407EBE
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhILQya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 12:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhILQya (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 12:54:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F4A46103D;
        Sun, 12 Sep 2021 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631465596;
        bh=hWXd04iRoonKIYllliPipNavG0ogl8feAMJEpsYp1lg=;
        h=From:To:Cc:Subject:Date:From;
        b=Dl6IVrhh7WwKFWaOhzoqOwbt8G011NZ0T/ouDpKIYZkE+w8fiC3wG4/v+sd0m4Fck
         hkVFLI/8BvwAiqtqHv/RB60UBrJcIrLIIM9t4O+MCSDR6nzgL6eWRxe3v+JzbVqWKk
         MWUc3dsNJRLQV0aMgUF4PGt9epInExMQ2Le28h4XMzse95hWDWYNqkaVHpJ7cUKXjo
         hGve2sPeZLhJJ3+nCnVAeBZTVKZAAqAUjlXHaQCDuTyd3rtcgJQ8TSqe6+KSK1dLmx
         4iuJzUNu+n5yGZ4WSSYJhQ+RUO4y9rEV1z83KvDUCIrO1SMPB3M0CHB1ft6w1Rc4/l
         EvrhuA6yJb+ig==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jgg@ziepe.ca
Cc:     christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, dledford@redhat.com,
        airlied@gmail.com, alexander.deucher@amd.com, leonro@nvidia.com,
        hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Date:   Sun, 12 Sep 2021 19:53:07 +0300
Message-Id: <20210912165309.98695-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
Re-sending this patch-set following the release of our user-space TPC
compiler and runtime library.

I would appreciate a review on this.

Thanks,
Oded

Oded Gabbay (1):
  habanalabs: define uAPI to export FD for DMA-BUF

Tomer Tayar (1):
  habanalabs: add support for dma-buf exporter

 drivers/misc/habanalabs/Kconfig             |   1 +
 drivers/misc/habanalabs/common/habanalabs.h |  22 +
 drivers/misc/habanalabs/common/memory.c     | 522 +++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
 drivers/misc/habanalabs/goya/goya.c         |   1 +
 include/uapi/misc/habanalabs.h              |  28 +-
 6 files changed, 570 insertions(+), 5 deletions(-)

-- 
2.17.1

