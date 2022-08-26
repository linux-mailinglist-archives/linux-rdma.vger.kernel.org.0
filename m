Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05525A2530
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiHZJ43 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiHZJ4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 05:56:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6F6F562
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z8so1508547edb.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=J4/6rXKW+adS20FtpQBZ0C2m0YU++BdYhMABDG0ynrE=;
        b=KWGChfZM1+Ny5ByozjDXkgvan5DhlkTbZil80/9VWgTWgtD1zjbmkvfkD90VHXjhK4
         ePHKVGM+oCCKYe4Bg6vrMmSloTSOW7CtzKs/7ekPouX1TZtVkCZ36/O9fV4QR/EWUrWG
         VbCJot7T72gCDbeCncgzKpJXaRjC0e7Fty/dMKmME2feBERtU8GKbGin6179cTJPMvIP
         e53s5kdbkk8GrWvG1ro0Hw909/FvaJ+MlrYTcU5ZeZHiOj93ZiDFHOx/9qmktRL7qx64
         RNtqQp2hLFys5aacb4+qXZMF5NqZ0tSKM5qc1uP+Sv4R+KTJ6BUcwh2BJic62xgkfcei
         ExoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=J4/6rXKW+adS20FtpQBZ0C2m0YU++BdYhMABDG0ynrE=;
        b=6h5LsgGeZK3KZKSeKfUcKNW1bom5bpvgnnyl4sl1ROAsM7XzwAFe/ovF3aIpsBY/RB
         vwJrqyrlPdZRkK5giqF+p0bbR3xN1zrCPyiQKadVw+75VEKnDUu/cyXeaaiPk2wYnwwf
         UuJ49lKfIgOWqvCMvF2KvpGgPZqdrROdGzAbbZOF+iH9p/JYl0BiIGkyZAzQEBW7OpFB
         TjCCKZ5ZSjRIs7w6D1oWt/ImCxjceQIe6Iwd1lVzVYtDncJpYtTC9TvaNCC0QAqtOeqs
         kC+WVkhpNGPKhdXzuE1jc2iePWLH/F84wn7e0WjJmv0kcX29LeKYvgZbTNMMuN01RLSJ
         owXw==
X-Gm-Message-State: ACgBeo1Jr8OFcJHFbU6VMZeYCgkUxEAk3K8eNAZX6A/po58OFqXQ5+Dr
        WJ14ZL8RDV6a9/wDCrSA0V4TOFH/wnwvHw==
X-Google-Smtp-Source: AA6agR71p+r9X2usA5mdl13eR0DZ1noGqpywVWZJv3S/zAwocjA7S2e6Ybcwk0mRMB00AILeoNoiDA==
X-Received: by 2002:a05:6402:50ca:b0:447:3355:76e3 with SMTP id h10-20020a05640250ca00b00447335576e3mr6170741edb.72.1661507777071;
        Fri, 26 Aug 2022 02:56:17 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b007081282cbd8sm694826eju.76.2022.08.26.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:56:16 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 0/2] infiniband: Fxi dma_map_sg error check
Date:   Fri, 26 Aug 2022 11:56:13 +0200
Message-Id: <20220826095615.74328-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, all,

While working on a bugfix on RTRS[1], I noticed there are quite a few other
drivers have the same problem, due to the fact dma_map_sg return 0 on error,
not like most of the cases, return negative value for error.

I "grep -A 5 dma_map_sg' in kernel tree, and audit/fix the one I feel is buggy,
hence this patchset. As suggested by Christoph Hellwig, I now send the patches per
subsystem, this is for infiniband subsystem.

The first one for mthca, leon mentioned it's too old to change, I still keep it
in the hope others have a different opinion.

The second patch change the return value follow the patch from Christoph
Hellwig, we might want to change the type for in the drivers which calls
dma_map_sg or ib_dma_map_sg to unsigned int to.

Thanks!

[1] https://lore.kernel.org/linux-rdma/20220818105355.110344-1-haris.iqbal@ionos.com/T/#t
Jack Wang (2):
  infiniband/mthca: Fix dma_map_sg error check
  RDMA: dma-mapping: Return an unsigned int from ib_dma_map_sg{,_attrs}

 drivers/infiniband/core/device.c            | 2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
 include/rdma/ib_verbs.h                     | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.34.1

