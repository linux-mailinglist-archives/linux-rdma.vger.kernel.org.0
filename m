Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E03CCAE7
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhGRVcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhGRVcN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:32:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB087C061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:29:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so4421078otd.7
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4wVk/JrHvwWwdtqrdIdI4u6TuOGi2YeEOKz1j+z234=;
        b=OQ62RaIY/Bmc1R7KrXgbbzHZYWNCqcRj0oV/X4Y4WlN4QSescOzLXumTzPpDgpkDtq
         7rzzpsX6gdbNCMPTwfZv1bg/71q8P+biCtx3d2XwV56dIO2vIlrsng9a+TXtGi1rHC1J
         j46TLDeieD1V71+4cBw56u59QAacG5bzlnbvug9kQfAvCc6QGYGfGYr+fkLwW9UEZm07
         fGb7lvHsReuXipcH9eVD6b5Qs7zMGDz5H/OE0MZzqwFE6uoJyOFtx/UAw2dd/v9yuLIC
         A/5ySzCceCLIbYOntOXWiX7EeiSruLg73gYgmJyP/GRhX3ABp97wtC8Ce2pNRtEHHkwD
         7VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4wVk/JrHvwWwdtqrdIdI4u6TuOGi2YeEOKz1j+z234=;
        b=MGBqDk17PhJwS2uui0qfHVsWnW8BCqJdnN42LnHonKaj0aVGpH5awZgONzKVMJqKAq
         ah3EKE3hbrFPsfyOxjnmAPh407Mt+sZJOcDBcEi17UdYYOrtFMHgXd3sN90lXp9c4Qua
         Z/gZnDzYGx5XyMZCvTj0rLZj5JRay7fo9X9wKhueUisbw9KHDQyWLHbV/hohxIXttYFs
         aKtddMph02Q7ev/qh6DVtbgXgVKiKmYqMP/JRqgEYuVUnGhK0S6lhwo1xUDXvMUfbHuD
         ThVtz9/YdnIkWMX51ftioiCxn6geyohH/pSV3jUENQbvYrhPQAB778Z88vLrIFweDazh
         oGjg==
X-Gm-Message-State: AOAM533oqAsz1uedjMxfpNaU/SRKETRsgqVUKTIevpA22LZiu7CY1YPt
        XAB+RlB/epPYIjQImn0U9Lo=
X-Google-Smtp-Source: ABdhPJyvTwzlwdIfeWFeqGfD1TaHUUdfmpanEaOVbD9JD3cBf1c5284CfmHfuVW8bihF572wEuL30g==
X-Received: by 2002:a9d:24c5:: with SMTP id z63mr16800602ota.43.1626643754253;
        Sun, 18 Jul 2021 14:29:14 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id e29sm3410475oiy.53.2021.07.18.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:29:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 0/2] Providers/rxe: Replace AV by AH for UD sends
Date:   Sun, 18 Jul 2021 16:28:41 -0500
Message-Id: <20210718212842.21559-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches contains the changes to the rxe provider to match the
kernel patch series with a similar name.

v2:
  As suggested by Jason Gunthorp moved the AV struct out of rxe_send_wqe
  and into rxe_wr in the ud struct in the wr union at the original offset.
  This maintains ABI compatibility with old kernels or rdma-core but
  simplifies the code.

Bob Pearson (2):
  Update kernel headers
  Providers/rxe: Replace AV by AH for UD sends

 kernel-headers/rdma/rdma_user_rxe.h |  16 +++-
 providers/rxe/rxe-abi.h             |   2 +
 providers/rxe/rxe.c                 | 117 ++++++++++++++++++----------
 providers/rxe/rxe.h                 |   8 +-
 4 files changed, 100 insertions(+), 43 deletions(-)

-- 
2.30.2

