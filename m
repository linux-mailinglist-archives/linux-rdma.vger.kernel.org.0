Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DF296A6E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374553AbgJWHn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374512AbgJWHn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:43:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF6C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l24so613848edj.8
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvfrY9rn0hZQUINprO0ZXBJY0gEAUg+clX2xGBiD3Xo=;
        b=e6QLMcZYskVHE5gDqfmP1moWuWtdWtVmzU/v9ttuSiUyXyqRJF3xIiSC4Sng3CAv5g
         4t8RnHWoTNskcPnYaPnAwz+F6lhKB5WXJ46kMM1lQtvfVzMY2+r0k8kcVElallY9sy+f
         SF+uTo1h5PEiqGcfJpG06q7FMIBSehosXf+Uo3/j4qap6Q6kIpf8PJ3LXbcxSIdRDWi/
         uX/0om+YYFBhD7TB23B3qcTop9hHY+mkdvgFskUi08Xt+s9/r0TBnnLqlyXjzQxr62KK
         u5svBJX06vNxNs6XA6CnOGWb31pIMC93AuG+y/czls4Pz3sEJAbCAyeDEwoOOkqkczqT
         bwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvfrY9rn0hZQUINprO0ZXBJY0gEAUg+clX2xGBiD3Xo=;
        b=kxO75T0vKkNVUU1XuKJGa/9rjXaSte7NPraqHpcyDdKJdIKpkywza7RnQGJIpEvS70
         YhVQKNOnUnokncOVqUQvoqE/pH+ygAed6OwQJ7oh+HzHDK0PB64pmJ5cR7IgeyiMZZkL
         K3nShEhL7bF0jzhe32Vg0KJwZ9n8nwqR2hTE0AOULwtETgkjo2Q6gxoqkDKeyegkxWMU
         uIubLTJh7BAhPL/G2OB9viD9KXIlVWPGCSnklH+hET/gS8xTjNLf43DQZQCF3udwv8qo
         xmSs8Yahk41cs4HFe+Dt9KWX2832R9LB8/3RLeb1l+fXzKZax7xNNVvCe8LcatdKO9xL
         V3Og==
X-Gm-Message-State: AOAM530A69Exvh9N0MG67BU2U1hclYzRX2EqQAP19Neaof9drFi0PFT8
        aWAw4YJ6ip16bsJ28msUNy66gIF8PjnKTQ==
X-Google-Smtp-Source: ABdhPJy+PFiXzDiHutq8QwvhHMdIetkImyptkHeUdRj5DoUbyMc5vidKT9jBQmETJfcCHjrJhxzCbA==
X-Received: by 2002:a50:ff02:: with SMTP id a2mr930475edu.364.1603439034897;
        Fri, 23 Oct 2020 00:43:54 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:54 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCHv2 for-next 00/12]  rtrs: misc fix and cleanup
Date:   Fri, 23 Oct 2020 09:43:41 +0200
Message-Id: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please consider to include following changes to upstream.

I re-ordered the patch sequence so bugfix comes first, then cleanup.
First 5 patches are bugfixes, we also added the Fixes tag accordingly.

Thanks!

Changelog:
v2 -> v1:
Droped "RDMA/rtrs: removed unused filed list of rtrs_iu" merged alreay.
Droped "RDMA/rtrs-clt: remove unnecessary dev_ref of rtrs_sess", buggy.
New "RDMA/rtrs-srv: don't guard the whole __alloc_srv with srv_mutex"

v1:
https://lore.kernel.org/linux-rdma/20201012131814.121096-1-jinpu.wang@cloud.ionos.com/

Danil Kipnis (1):
  RDMA/rtrs-clt: remove destroy_con_cq_qp in case route resolving failed

Gioh Kim (4):
  RDMA/rtrs-clt: missing error from rtrs_rdma_conn_established
  RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
  RDMA/rtrs-clt: remove duplicated switch-case handling for CM error
    events
  RDMA/rtrs-clt: remove duplicated code

Guoqing Jiang (5):
  RDMA/rtrs-srv: don't guard the whole __alloc_srv with srv_mutex
  RDMA/rtrs-srv: fix typo
  RDMA/rtrs-srv: kill rtrs_srv_change_state_get_old
  RDMA/rtrs: introduce rtrs_post_send
  RDMA/rtrs-clt: remove 'addr' from rtrs_clt_add_path_to_arr

Jack Wang (2):
  RDMA/rtrs-clt: remove outdated comment in create_con_cq_qp
  RDMA/rtrs-clt: avoid run destroy_con_cq_qp/create_con_cq_qp in
    parallel

 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  74 ++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 119 ++++++++++---------------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs.c     |  61 +++++--------
 6 files changed, 108 insertions(+), 152 deletions(-)

-- 
2.25.1

