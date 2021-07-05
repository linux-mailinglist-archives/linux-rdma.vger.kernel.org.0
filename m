Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F143BBD40
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGENF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 09:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhGENF6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Jul 2021 09:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 681BD61447;
        Mon,  5 Jul 2021 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625490201;
        bh=JAhM9uLnVQdWyUIJvWzQUlT2ptJXIZ6NsbSZCd1vRmw=;
        h=From:To:Cc:Subject:Date:From;
        b=joYZP1uH+TarU+TSon38rp2wt+bjwtNuJciGpFjdb3F1K3fX3tezOnUFc8Ios6DNY
         obi/Cbw3FuWNceIPuQebcJ1j2whR8GVHHpwvg6UWRL3aa9ZL+d9Btb1Ye+sCPDHrga
         y2b1NOizE+V2lzA7/2Tm9JYAAxXQaajaD/JbktNOmRmAe6gUywNXk7BwbZIzeLSwGY
         UQcS+bTw3qcin+aDxqzBTlSZwA1WUPe1oNAN43pAZ9AQLQvyl1afov3v8a2s4j/HFw
         ljIvlxl3lmPfo9n4YWXx0ToIwJ7KHaAYHEjfLTo5CkCxZOloaTU0ZxtZ06YYrSElFR
         c+iJniV0iYxHA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Date:   Mon,  5 Jul 2021 16:03:12 +0300
Message-Id: <20210705130314.11519-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
I'm sending v4 of this patch-set following the long email thread.
I want to thank Jason for reviewing v3 and pointing out the errors, saving
us time later to debug it :)

I consulted with Christian on how to fix patch 2 (the implementation) and
at the end of the day I shamelessly copied the relevant content from
amdgpu_vram_mgr_alloc_sgt() and amdgpu_dma_buf_attach(), regarding the
usage of dma_map_resource() and pci_p2pdma_distance_many(), respectively.

I also made a few improvements after looking at the relevant code in amdgpu.
The details are in the changelog of patch 2.

I took the time to write an import code into the driver, allowing me to
check real P2P with two Gaudi devices, one as exporter and the other as
importer. I'm not going to include the import code in the product, it was
just for testing purposes (although I can share it if anyone wants).

I run it on a bare-metal environment with IOMMU enabled, on a sky-lake CPU
with a white-listed PCIe bridge (to make the pci_p2pdma_distance_many happy).

Greg, I hope this will be good enough for you to merge this code.

Thanks,
Oded

Oded Gabbay (1):
  habanalabs: define uAPI to export FD for DMA-BUF

Tomer Tayar (1):
  habanalabs: add support for dma-buf exporter

 drivers/misc/habanalabs/Kconfig             |   1 +
 drivers/misc/habanalabs/common/habanalabs.h |  26 ++
 drivers/misc/habanalabs/common/memory.c     | 480 +++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
 drivers/misc/habanalabs/goya/goya.c         |   1 +
 include/uapi/misc/habanalabs.h              |  28 +-
 6 files changed, 532 insertions(+), 5 deletions(-)

-- 
2.25.1

