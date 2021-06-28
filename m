Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31BD3B6AC6
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhF1WGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbhF1WF6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:05:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D045C061768
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:03:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20535185otl.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLvw6r9+pMXu01qZnvolo+M/6gBx74Mw6gbbfYI0vNE=;
        b=hCvNVrwEjXgD/I00CDEv8Sbb+eNhZdQp1RcLh6qP9HcRzqTMT7+kPi6Q2IYa/5gDsz
         xE7pbROLqCcbnZb6JFMJDvOU+3yf7MZUz+L8cIOALdDJ+i9pH1TyQf0gnJs0bQfefLDU
         uSpRjmovL/tfUTh7WYb82DMrEwhVHR2DeXcqiOEbKBTfilzX7xzAVnsmlbHS04KBvClu
         2HZ0QnaYXeFAtLlGnfrIc7FpvN7+muXqOGSSnGlnoGvYEjs3YwHNbtY2gecLzQFByeQH
         gxjRBQuWbei9rcdZjcJ8J2EQx3GdZN/pEWFT/nLDLMpdYHj+UtMDablPKCVhU+gtF4tt
         y0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLvw6r9+pMXu01qZnvolo+M/6gBx74Mw6gbbfYI0vNE=;
        b=Ellt7GQDu0b0Lb7Sb4pVCtLB7jd5rBDPxHavCvmJD57lkbAjBH4eTh6XddM0MFRUI+
         oVwDek7xtvQIxIbfvRYD+S9rFSguXuNNi9Y6tlzUE6uLxOVpzFKqVrt0KmAyboZICBFU
         2tiMldiA/UwKfH9+OpYhkwVin5FSFSBosX3fM0phWsS+wHsBSo4MO7BkIpbwhhdkwKaY
         yDq6dpBquTAowkMsfMiOW7E82KGqRSoo6+rjBWCaNijuP5CmqoAWNrRNcxOURm17dZp6
         fk5HGX6V8Cl+kVCtf4vO4qZ/sJx+Z11T8U5cNldoVQCA5nC4yXYBD5JURFIeVEymK1Ax
         nogQ==
X-Gm-Message-State: AOAM533mZ5FmEAWRdbu/d29aHFxXGGTEyWp9xjuWWL3IhbRoH/RGeE02
        pPGY6IF/UUN5pYFi7aGTpXA=
X-Google-Smtp-Source: ABdhPJyLIQkUYG5IqnA2tj1x8l0yJoSJk4R6o8TBajf0DyHdWyDbrpJ7pEJop/6RMVWDXLl+MvlGhg==
X-Received: by 2002:a05:6830:1156:: with SMTP id x22mr1486948otq.180.1624917810875;
        Mon, 28 Jun 2021 15:03:30 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id z2sm1182355otm.2.2021.06.28.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:03:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 0/2] Providers/rxe: Replace AV by AH for UD sends
Date:   Mon, 28 Jun 2021 17:03:03 -0500
Message-Id: <20210628220303.9938-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches contains the changes to the rxe provider to match the
kernel patch series with a similar name.

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

