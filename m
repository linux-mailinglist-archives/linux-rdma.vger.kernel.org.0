Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F839F393
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFHKcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHKcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 06:32:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFBC061574
        for <linux-rdma@vger.kernel.org>; Tue,  8 Jun 2021 03:30:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d13so10385342edt.5
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jun 2021 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NfZxVClNovR6Y76oUj7Vf1Z7wlmT8TIgfd43JeOEys=;
        b=B3iN42ya4o3XzIHSwsYL45e98TWLi91GfJQQhKEnLKVJV/UdvzmvLX6GEIeoLtLGOU
         7jFWI/VN6AQ3tD5TAD6lAaQ30XCXQxZ7JQt+B0TC9JE2XhP0M/j0Fw3898mTL/j6/z7v
         mJFzvZIaX5qx7mftpYU0/fyNpLKXPYpns9sH2xrYD1TDBd/mKyiS+KAZGze1YWpI3lh4
         oW/R575Oj5QTibzJJ6jILHWzyKZMxqKc5tREmz9yoKWEly+pdoTDAtvxLp2sKNDELGkz
         uTykyiufefCanGisoyxxJZOTA903oqKHeJDTA8obentbzgysVsAyReXLzDmolAh5MpMb
         8U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NfZxVClNovR6Y76oUj7Vf1Z7wlmT8TIgfd43JeOEys=;
        b=b+oqxyrRT87Xep7EWnTCePADJEQWSxWijbPIpo9UVGeiYF0X6gPFSTmBFE3QKURxyV
         P8Qmk1X+Z+5Nuq6tpQy5MT6ePkJiUte3+wQFhehmlK+HNWGdnBRJwqBs1XvpZWVqYT+x
         oOz9xrHS/azxvzPyn9UW0cL53rOAMfejaa1/aZCfg12NNXSxcGWMaWTBbA/Gdl2jqitY
         KzjKGT0Bq/iGXH9AZxLDDQCtbHAL1nxf6PqoBGDxl+bp6soS8aT1YBb9bv1/E5Us/vTG
         OZfLzyKUOIUZ44+N8vJ6hNxnyYzwf+HCZOmyxaF6cCZzV6/X6NVa8ePZmJD+KuFB3WlV
         QYoQ==
X-Gm-Message-State: AOAM533Q3uzoH77MXWadH3Cpo6d9Yj/pb2uYYAp4flwow0v4iOlsJdAJ
        1N3sAdlIeoQzlmyxdFVKbN71pm5K4TEV+g==
X-Google-Smtp-Source: ABdhPJz9OlAC52Lw9GcJvuNOmfZq0w0JB5XrKh/98btb4FdgocG/tJoLdIwnLTJ93NE1R5cbxELAMA==
X-Received: by 2002:aa7:de99:: with SMTP id j25mr24594892edv.91.1623148240998;
        Tue, 08 Jun 2021 03:30:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4943:5b00:2927:a608:b264:d770])
        by smtp.gmail.com with ESMTPSA id dy19sm8634400edb.68.2021.06.08.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:30:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/4] misc update for RTRS
Date:   Tue,  8 Jun 2021 12:30:35 +0200
Message-Id: <20210608103039.39080-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- first 2 patches are for reducing the memory usage when create QP.
- the third one are to make testing on RXE working.
- last one is just cleanup for variables.

This patchset is based on rdma/for-next branch.

Guoqing Jiang (1):
  RDMA/rtrs: Rename some variables to avoid confusion

Jack Wang (2):
  RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
  RDMA/rtrs-clt: Use minimal max_send_sge when create qp

Md Haris Iqbal (1):
  RDMA/rtrs: RDMA_RXE requires more number of WR

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 31 +++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 10 +++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 39 +++++++++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs.c     | 24 ++++++++--------
 5 files changed, 60 insertions(+), 47 deletions(-)

-- 
2.25.1

