Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E976B3552F8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbhDFL7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbhDFL7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:59:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03719C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:59:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so21485061ejr.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ3efblv7PftdQN8Ew2E/1F0weq2OU387FzH9lJDBVw=;
        b=hYx7t4XTiES6gijR/VfI9JGPG8LIpuI4XPSwXCysT+z+8nkB4zcBEeMqKpAYY+y5It
         lKmZpGE6m31zb20gcHLqFimmaDKjlzIJZL0kGyRMUwwLdAbeFQzwsfHCLlVOkL14iI+6
         gyTshfM0Tp7aCukAnlaa7JHyPN+Q5znAZ/V9/b2hM6bpTd4JhQe0gk6FbFvzLMn6B0+5
         D3cdqXCEkquky3nvlI0KHPZgM02p8x25Y5Kl3rPjUx2JFVKztofpNoF5OKKjyMxEOHDW
         djVa0RmGmbQ26wf7rcLXAE1ZaSiaJmXepp3uBGc8sOsD3tT0UvK5mqV6c3OPuDmz0/Uy
         nNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ3efblv7PftdQN8Ew2E/1F0weq2OU387FzH9lJDBVw=;
        b=qny5bkUojYdu+fyi1rXyX9oo3oV0f9fXyVQ8Cq+ySsXphJe4Y6lG5vRV0GA+RtmLaa
         i377c+yPqSrRo9uxklI62uxrbld2KZ+SrHpCgG8QxrNp4zEFFi+aHLQxHyyI4QlkqLbO
         WaRt8lx1JWs3SzaG4qq2DowZH+ISrN2ZURioLdQUjZyFWB22XM+cpO+PY3aAFOXpP8uW
         ro4eQZ6myWvZjUysjXsmPLaaw/23iLwt2pTgK3AxUblnMyKOzskIFLnDHZx48C6Zub+E
         AgJZn60G9OJf2FKh6cfxAmcaUdmTPlqxvST5SQCLfrXk8HRoqIJcF8+I4qyP0jXYmYC+
         +N3w==
X-Gm-Message-State: AOAM533ZezDqbSzUA4HetSuXTkVNHl3D+GC3WUqQs8mmMdSZSTnmcmQ/
        cdLN0A89H3MyAKdH7EeeYFzaoIYfgfw63z+2
X-Google-Smtp-Source: ABdhPJwx/U2p70p+tIHDDiP9Ms82uBL52YEI6ftg5107RoxYOxwQLJcFeNgDFeCq5xU8n0Y4Qfex5A==
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr9828304ejd.156.1617710351668;
        Tue, 06 Apr 2021 04:59:11 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id da12sm3554954edb.34.2021.04.06.04.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:59:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 0/3] Improve debugging messages
Date:   Tue,  6 Apr 2021 13:59:05 +0200
Message-Id: <20210406115908.197305-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add more information into the error message for better debugging.
The old messages was just like "Error happend" without detail
information. This patch adds more information which session,
port, HCA name and etc.

Gioh Kim (3):
  RDMA/rtrs-clt: Print more info when an error happens
  RDMA/rtrs-srv: More debugging info when fail to send reply
  RDMA/rtrs-clt: Simplify error message

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 23 +++++++++++++++++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.25.1

