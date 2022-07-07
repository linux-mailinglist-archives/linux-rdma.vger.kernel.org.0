Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2756A542
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiGGOVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiGGOVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 10:21:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B51C136
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 07:21:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ez10so2553611ejc.13
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzSolsNhYVRZ7ltYCk+3rt5w8SPDkIr3xmKCxt5f+XY=;
        b=bYIQBs9g5v6EP7jmyxAZpl3GNOI1eZDiv9wsYG0yegMjE4SYwRGTeeCm9euqzliskC
         nNN8v3LzKXEyyF4WNJd7TDBX3VrkFZPn3uToaxf6Epb06jducXCKdMxnd/bfo8KwJSKP
         F/uY6cD+7cQ2+uXAeet8SG8vAh5GZl85+J844uSnm919YjbYnOGhX9bdQX81ltAPuvd1
         BB2EdAYt4lo98wF4GtSKlJV2z1StP9TEAl5tGUY0glmUY21+fkw05tTAMqV43Vvn2Oq/
         kr4fOI7TvJ+76OiW2K43QpoTC7r57KkZVSoGCfAwK7knsFVaEV4O5Do/BXN6M7uQ8Jil
         PpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzSolsNhYVRZ7ltYCk+3rt5w8SPDkIr3xmKCxt5f+XY=;
        b=zmvd14A13RdE1Fr+x3V4N/+GSGr0kb/esvsWcEog+MyLi24h5/VVGy/1oqtl8A0BJj
         M+070klWQXi5uLnJmQDKXQqiQitTeiItRnSgBLU7iofQhMsdrfICrPlTGruQ7J7VN9Ka
         N72C4Q+dCCxCCM1gtm5rsrPDQiCJvhbDLIWHdSp9xKRaMXfZ6nbqmnoIEB90rJi1kWGs
         oH9UKs/TQwjm1k6/krfmrOlO4zNTeIbrMNHzWXgC+Hdr5q4hWazBzs7ClXOhcmaHcB00
         gOL+VRlzSz6L/nxfxmXjrnPzWQuFX/R5JJheOKC12oR/nbX6v59bMnWSTQsm8o69Fpom
         cnFA==
X-Gm-Message-State: AJIora+pC+Z8efEVx8Kxd72G/ENDSKISFPIZh+sbwMljoJTqrQ45MaU1
        5aE9v2Zl/llpO49PFYREBBE/Z3EZYsXNuA==
X-Google-Smtp-Source: AGRyM1tiJWxaSAx7lhcxSBoBE8fASuFl9BsOybMbmP+NZFEpF9wNR3ZpYaQfU5y9VLzaYPvOvcPdMQ==
X-Received: by 2002:a17:906:4789:b0:72b:fc8:23d6 with SMTP id cw9-20020a170906478900b0072b0fc823d6mr3110671ejc.656.1657203711119;
        Thu, 07 Jul 2022 07:21:51 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072b13fa5e4csm693807ejo.58.2022.07.07.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:21:50 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH for-next 0/5] Misc patches for RTRS
Date:   Thu,  7 Jul 2022 16:21:39 +0200
Message-Id: <20220707142144.459751-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

The patchset is organized as follows:
1: change to make stringify work for a module param
2: an change to avoid disable/enable of preemption
3: replace normal stats structure with percpu version
4: Fixes some checkpatch warnings
5: removes allocation and usage of mempool

Jack Wang (2):
  RDMA/rtrs-srv: Fix modinfo output for stringify
  RDMA/rtrs-srv: Do not use mempool for page allocation

Md Haris Iqbal (1):
  rtrs-clt: Replace list_next_or_null_rr_rcu with an inline function

Santosh Kumar Pradhan (2):
  RDMA/rtrs-clt: Use this_cpu_ API for stats
  RDMA/rtrs-srv: Use per-cpu variables for rdma stats

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 ++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 35 +++++++++-----------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       | 21 ++++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 32 +++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 32 ++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       | 15 +++++----
 7 files changed, 78 insertions(+), 73 deletions(-)

-- 
2.25.1

