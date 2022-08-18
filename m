Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B05981B6
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiHRKyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiHRKx7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:53:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970E5C968
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:53:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d5so635789wms.5
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=k9zSlMwXNaBKLVDczsM1t96+FWYOkXlww+cQywgfFk4=;
        b=bxiq5qRgED8bN6bQtyqXY1Q2j5ASXOrJEzBywlu3T8Ik/1WwleV2I64vKPafDGjn0B
         73pz0XXY7NwqOjfTtq5bOJQDCHk5eBjS6+yycmO/PUc56beX+qLRlIU0Lsp81hGBxDdG
         5oQ8IEu2wQuBqnBljcGJxsczOTjY91Ek0Ejpxr4KaJe1cMUDdPB+RwT6OGX4GFR3AfCL
         IihDRpfEWcWl9v8BCHBdgcRgKWBJ8tQ5VsVBGch+2+m9i0wS8qqEs1MbSUViwpkdDI9x
         xP6rxd8BmqZNUJaHQ64L/WG+KDYTqgmYzuNp7aAu9Pjhtm0ukUFi3BuadG5dvykbBvWO
         US9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=k9zSlMwXNaBKLVDczsM1t96+FWYOkXlww+cQywgfFk4=;
        b=YPm21DuxzRavoy19QLiufwiqw8wOYaVv7BtxTMAjVgwqMjgAW6O5d4XMe8oGd+IFV0
         9CJP+OvAtNGLG//VUJJma8ragrsIC7/5urOKk0LYq3O+kjip3eGDVanLM2W5isqQelTt
         jYMvynGlyshmpDQ4UgNL8AFMOp7yBinabFHI6S229eTTKRV8Vus/2eZD30aC4PqKDy5X
         ngcTHE9EBeWpaHasUCVVED5r1WKifE7beUy0AZXgERGCCjrEtvkZe5pgycq8wIclKzjH
         leYyzo3I6blHF5rhcvXMGAEHqg5tk4m4Chctx54Q+jl1kYrRmF0EojD14O/ovqD0Xp/W
         Eh3Q==
X-Gm-Message-State: ACgBeo0A4LoM/obooQZ2bPC2DNisaMmOVg74RSbOGAX7Ec3TV/MilXVY
        NYVQegEm6gv4jXVMkvC1tq6/7QRfLaENow==
X-Google-Smtp-Source: AA6agR5cVsURHHcG8qaqxvaxUYLlnk+DT2Ll2Vz65aIygwBxIQgcCo/aYfVNOK2CkxkNdAya3Mj83g==
X-Received: by 2002:a05:600c:3b93:b0:3a6:c3b:37eb with SMTP id n19-20020a05600c3b9300b003a60c3b37ebmr1511127wms.185.1660820037603;
        Thu, 18 Aug 2022 03:53:57 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm1920751wms.17.2022.08.18.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:53:57 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH for-next 0/3] Use the right sg_cnt after ib_dma_map_sg
Date:   Thu, 18 Aug 2022 12:53:52 +0200
Message-Id: <20220818105355.110344-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

The patchset is organized as follows:
1: Add output for debug purposes
2: Use correct count returned form ib_dma_map_sg for rtrs-clt
3: Use correct count returned form ib_dma_map_sg for rtrs-srv

Jack Wang (3):
  RDMA/rtrs-clt: Output sg index when warning on
  RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
  RDMA/rtrs-srv: Pass the correct number of entries for dma mapped SGL

 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  9 +++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 +++++++-------
 drivers/infiniband/ulp/rtrs/rtrs.c     |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1

