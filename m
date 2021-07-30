Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA33DB931
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhG3NSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhG3NSk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799AC061765
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b7so11305089wri.8
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVZyMdqykAKaELdQcRa249NH48OvkP2tWCmv72L6uVQ=;
        b=baK5f6xOF1ZG77rh7IPgy6u1O2S7smlTS+FCL7CknzKCy2ZPIrArn0KLfuhYUKEaaS
         IBf6RN1imSVKHI7iArgo4TMPe2H5Vhluw52B84OHlR+busMULtdAqBLV4rsr4pVY6QVM
         rGOYX9uNtqNnGUCkA65Br7yTlr8qa2Bxm1q7ECMcEQbfupPyb37U3JMThEURf/utIdHK
         Z2gkbAcJJ8+s6/RMxi0q0fJMeRaWxtIy8kWYm/OwPnqV7EWke+3TCCOy5hr1GwHkH8Bj
         ujduNeppn+c6CzBmapFniNDy61kXIJfMlRA7iaAKlJtyF5Z5PFl8DFgkiUwO3N7W8Zae
         XnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVZyMdqykAKaELdQcRa249NH48OvkP2tWCmv72L6uVQ=;
        b=kmk34yNaWQIAJte51QT2X5JqsH/prITtgYxMd8xTbTBy+KrHI4E/OQYkYqE7zKAwlW
         GLN2HrvqZeBDgWtLXwO/d0LCPmpWhMGeiZisRAoqlOx3L6WGF6sTMfckineYm23pjhUw
         9FFxAoVDvDieQiFkpv3IACCOXLbXndr46IxaUh0HaCWZCp+/H+dVNxY1H5RU4eNTa7dd
         UQsswZZQK7cJe9ZN4AcJq1OPGB2D/JHLG74SxbD5jSrbxIBMBwHkFKtC+NcnXhlsQz+W
         egOaWPVsx6P01QSUe3cQ0D4Bd3feDqIAeJfwjtghZkiNO89Ol0tKn7HLtiXfa0E21lyf
         VSqA==
X-Gm-Message-State: AOAM531c/TtAi/OAdos2e8pOJoUPv9RxGwrI07wcZWbtn25ciIB72Uiu
        o7GJOy55nYzSYnM/Rt9HTQhhG2UhrQIeow==
X-Google-Smtp-Source: ABdhPJwniPIs941DOUSVAxIYpIr+5EVdNFFEwkZHtFE8G+D8nhikjjZcCw0z4GfNy3PheOy/qxLBGg==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr3098357wrp.54.1627651113980;
        Fri, 30 Jul 2021 06:18:33 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:33 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 00/10] Misc update for RTRS
Date:   Fri, 30 Jul 2021 15:18:22 +0200
Message-Id: <20210730131832.118865-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

The patchset is orgnized as:
- patch1 bugfix for corner case.
- patch2 reject client with special sessname.
- patch3 sysfs_emit conversion.
- patch4 remove unused functions.
- patch5 Fix warning with poll mode.
- patch6 remove len parameter.
- patch7 remove likely/unlikely.
- patch8 Fix inflight io accounting when switch mp_policy.
- patch9 add interface to disable IB port on server side.
- patch10 remove void cast.

The patches are created base on rdma/for-next at commit:
07d0f314ba75 ("Merge branch 'mlx5_dcs' into rdma.git for-next")

Thanks!

Gioh Kim (4):
  RDMA/rtrs-srv: Prevent sysfs error with path name "ctl"
  RDMA/rtrs: Remove all likely and unlikely
  RDMA/rtrs-clt: Fix counting inflight IO
  RDMA/rtrs: remove (void) casting for functions

Jack Wang (2):
  RDMA/rtrs: Remove unused functions
  RDMA/rtrs: Fix warning when use poll mode

Md Haris Iqbal (4):
  RDMA/rtrs-clt: During add_path change for_new_clt according to
    path_num
  RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
  RDMA/rtrs: Remove len parameter from helper print functions of sysfs
  RDMA/rtrs: Add support to disable an IB port on the storage side

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |  40 ++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 152 +++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  16 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 169 ++++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |  17 +-
 9 files changed, 253 insertions(+), 155 deletions(-)

-- 
2.25.1

