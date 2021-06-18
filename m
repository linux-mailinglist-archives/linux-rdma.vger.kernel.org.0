Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140D3AC2AE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFRFCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFRFCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267FC061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h9so9221440oih.4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/i/wop5npp57u6T/YJWCQGL9QhtlO92Z+A4ZjRU0dw=;
        b=D+M12zIznOCfKmAN7D5zdmPeCWTxSB7w+H01VHhkqhdatWKtVEZg8yy3+603cCOnzw
         1Con2+9M9c2WeouR/wnif7UieZvLDuQG8XN6Ivpt8jUHy57vpMykRysZ6wxSjC+eTJ2M
         Md+uw9bo3Lozrm+013ue7G4uqj14bPnwYaXGQlg2aq0hNWCFff79YEIEloT9cNOANivx
         xiPT5kdjGah/uY4D9lZ2ZcSqk76JH5gAAnDQnkNFkU8gT5xgJWetdyW0XkUc1FFOhBfJ
         OiMjGpGfYPvOzSi1wJHR9PPvhzFAU8XSsiFMgM0EqN6p+ny6Bq5NhCvqYLhMxyLA/BMU
         VYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/i/wop5npp57u6T/YJWCQGL9QhtlO92Z+A4ZjRU0dw=;
        b=HYygECTzwUgMDhGgFAijLNkQ8QR/XLMNeoeY+Ia0o1yZnu9cfOVLV1Ehd4x8twKTN0
         tkZyrM92fuuqRBz0l3bVd4muCianQP86GUqXpcvojp/gb/inKe4nwzc3hwX1dkuMNhrY
         YKvdaZcRjkG7EJIXJU2KX9Pe+SQuO1Fj9kGj10LCyqG0ozXstGO+3BgyT5iOqlGI+yaE
         L0vhlSQfGeGkWwN4l8eiaLcZrruz5eGuWaxcKuQvKw2XT6+h37EXm/vNsFYWU8v/gTbm
         Oq5allMpk0l843bfIQCV18SGlwtZhn/fTB4EZPxCRvPGzQ0t5It4z/cOQCzvM2nv44eb
         JDvQ==
X-Gm-Message-State: AOAM530wXYhNNhZpFFS8I2OoCZplF3BWuvL6vY7GzY5yZA/XJ5zKy0ZU
        aT7F330sVrrsAgg9AEy7Xhw=
X-Google-Smtp-Source: ABdhPJwwB77DBmru38qB8Iq7759w/MJ9TZ78kYzvLk1bIJp/59he3KaHwZfHbMsow22g6YWUAmUnnQ==
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr5955595oif.43.1623992425140;
        Thu, 17 Jun 2021 22:00:25 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id t21sm1778920otd.35.2021.06.17.22.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] Fix extra/redundant copies
Date:   Thu, 17 Jun 2021 23:57:37 -0500
Message-Id: <20210618045742.204195-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches removes or shortens several unneeded passes over
packet data.

Applies cleanly to for-next after the memory windows commits.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---

Bob Pearson (6):
  RDMA/rxe: Fix useless copy in send_atomic_ack
  RDMA/rxe: Fix redundant call to ip_send_check
  RDMA/rxe: Fix extra copies in build_rdma_network_hdr
  RDMA/rxe: Fix over copying in get_srq_wqe
  RDMA/rxe: Fix extra copy in prepare_ack_packet
  RDMA/rxe: Fix redundant skb_put_zero

 drivers/infiniband/sw/rxe/rxe_net.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 56 ++++++++++++----------------
 2 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.30.2

