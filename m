Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49814164159
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 11:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBSKUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 05:20:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37306 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSKUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 05:20:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so6136099wme.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Nk2ICGQwTNYvudQ5oQVgnZh4sWA6pqXWSRj6B9yT7xQ=;
        b=ECGaHKTIK1cF9Ss0pMoMObBf3xUe3kGRAWjLw5OeWhDTrYbtkyHFNa7OlaiP/MFKhT
         4NH7U6cN1ZE1jXLPTTTWyW5m1b4+WWRq72VcgNx56NELq3jVF73FZvRlRsgr4LdB0bhs
         YFIAl37P5ZGaa8aUk8kwXpLMUtp//CZ6e6uXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nk2ICGQwTNYvudQ5oQVgnZh4sWA6pqXWSRj6B9yT7xQ=;
        b=YaSJ3wxyF8rwYspmogYxqqyxtQ4sQ0gFYJ2tyOyOAACr2pb5/YI1alvRUUDvulOSCH
         lhD7FdY7XUKubHULZhQG1J96SCyDxfWRYXrAaY4vAK3EAl8RwF7mzTEYFGfheKpPjLpC
         k4SYLdpfW0LWSvjEeZc0mjhBddQjlkaoCR/rF76mt2UiQzak56meoXt73sAsjt6d45ga
         Jve97XQRU6Q4ebsh3hXOpNbTdOCOG9+q6ljsX+Xej7v2KbyBUkXQ5+3Mu4RCirzwquTS
         tX/BEOtOXPogbIziygDSjNMJxXf80A5Qmf2Jh52rWVlRuq5hjmx1xTUoUf9KClm41RiJ
         /5nw==
X-Gm-Message-State: APjAAAX2BMO24vL0bp4RTYNkSEL68rgG9orqrppCETqWNP9HQPdTcXOF
        9NImic+ZBEuDjiiTfV45BLr3Tg==
X-Google-Smtp-Source: APXvYqwIPmxKBqVvuKuhUGKbAWI7efZgKXSo21aqOPGCjDORGoVTutywl7D0BEVsTSclmBiQMCMWjw==
X-Received: by 2002:a1c:4905:: with SMTP id w5mr4786435wma.129.1582107613421;
        Wed, 19 Feb 2020 02:20:13 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k16sm2408260wru.0.2020.02.19.02.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 02:20:12 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v4 0/2]  Retrieve HW GID context from ib_gid_attr
Date:   Wed, 19 Feb 2020 02:19:52 -0800
Message-Id: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Provide an option for vendor drivers to get the HW GID context
from the ib_gid_attr during modify_qp and create_ah. Required
for drivers/HW that maintains HW gid index different than the
host sgid_index.

Please review and merge

Thanks,
Selvin Xavier

v3 -> v4:
 Addressed Jason's comments. Removed unnecessary validation and locking
 as the reference to the GID table entry should be taken before invoking
 the new symbol.

v2 -> v3:
 Added a new symbol to retrieve the hw context.

v1 -> v2:
 Addressed review comments from Parav


Selvin Xavier (2):
  RDMA/core: Add helper function to retrieve driver gid context from gid
    attr
  RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index

 drivers/infiniband/core/cache.c          | 20 ++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 ++++++++++++-----------
 include/rdma/ib_cache.h                  |  1 +
 3 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.5.5

