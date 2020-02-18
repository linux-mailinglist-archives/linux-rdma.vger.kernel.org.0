Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4A1620C2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 07:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgBRGUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 01:20:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46755 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 01:20:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id b35so10278643pgm.13
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5UE4AxOFzaoIoR8VYnOCfbRZ399eioexG6iH32o3YWo=;
        b=drHHEZ/EoQ4CHytGsZWW1BeZbprjfORyr17gXdvW7PUtu5RwyQ+6/iyoXt+9fZY0uN
         5lhgum2k30aFDagH/bvR+RUoiYzfmOQWvS8Td9sZywA5ROMzExOD7ZMruaWqCcTpbUO7
         Bc/cxvcoOyFVtxAQeiZtUjsavI1p/GE3wSHQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5UE4AxOFzaoIoR8VYnOCfbRZ399eioexG6iH32o3YWo=;
        b=g0QNn1db2oUllV5mUff+rOH5ECX+UQZpEfKwkSr+mz+omMfoC7zoMBHpafDea5sZJy
         DYlYzTjB/jM9kJ5jaSMXCW5CVSrztT6nkWwWgpJ+gYR2t9GVIRAH1WIJ+9+++1HYrvWk
         ILIRaEx1AkYfrxsfgWJQYz3yPIHLvramdHzOHOcce9kqqZVnYE7QeYdFjmpAmcs9QDQ+
         fOJeTt9HPnhk4Z3UFxM38VsA7YOkjQif56+L5OuJMgaSjv/e5TLui1OuE+KB3/NAf9HR
         aQa0T/RWtJwSsh9byY5kD1VErEwVi57N71DxIllijFH20Wg1eiAg79uu+nxA8/3qRpAB
         /cPA==
X-Gm-Message-State: APjAAAV9ZzDA2s/CroqADJn5GkuYq/yOEPYt7rBYwoQ5USwKkBZAblb3
        eWpvikkUgZ6Ly1h0G6ZxvPhNGQ==
X-Google-Smtp-Source: APXvYqwtifHKE40mp6LEEWN8JW5zX+GZVeuKIayxNqLFZbE0+hq6ps1axOJMMNr8AwSGXSZuGn32+g==
X-Received: by 2002:a63:9251:: with SMTP id s17mr21039092pgn.127.1582006831687;
        Mon, 17 Feb 2020 22:20:31 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 72sm2606753pfw.7.2020.02.17.22.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 22:20:31 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 0/2] Retrieve HW GID context from ib_gid_attr
Date:   Mon, 17 Feb 2020 22:20:08 -0800
Message-Id: <1582006810-32174-1-git-send-email-selvin.xavier@broadcom.com>
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

v2 -> v3:
 Added a new symbol to retrieve the hw context.

v1 -> v2:
 Addressed review comments from Parav

Selvin Xavier (2):
  RDMA/core: Add helper function to retrieve driver gid context from gid
    attr
  RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index

 drivers/infiniband/core/cache.c          | 41 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 27 +++++++++++----------
 include/rdma/ib_cache.h                  |  1 +
 3 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.5.5

