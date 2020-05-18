Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EDC1D75DB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgERLFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgERLFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 May 2020 07:05:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F16C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 04:05:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so9236698wrx.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAE08SBqIc8pASy1kitEcGu15we0RMxreMgdE1YvLog=;
        b=TpboNGnUzC61RMIvOPHnVr7Pj8D76rFYnasKPmxGvq8A87CzgJMDv4OnTGaHhpcH15
         HXnSnV0GEPBs87bsk1U17Us2bApaqcbinP/Eisrjb3SzA0eN/GFzLdvAVokuQORzK3at
         21H+6ajlU8LopMlKb5515NBMNm9uRCxL4nGUhTiQirmMIvqwupIUrp1mVsCKj5zhxpFh
         y857AuOlcYIJST1ndqtQdhHuJY/CJN7e7O1n38uNmVstIULyvGl2wh/zXf/DLkY6IaWT
         sXgiQFVS3HxIh9N/yYb7b27+DLrNhWLRNwCiaGkNUeR3TwYWIKCuzJHWcs04PrnEWvAu
         dhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAE08SBqIc8pASy1kitEcGu15we0RMxreMgdE1YvLog=;
        b=rVpgML+36/P1/k0EqqwO+XbdWyruYG1krPfMT/3cLAO/U+c+vxWJ4KXsSHP4ePaBmW
         kXtCH9X/2+feXIER/YX2zYrvOHtYisc1NlmF3FN/7Qx47yg1yQ6iCJmHedq0kT6pQ7jK
         kC7i1bOGrpBXd2mSYWcGH5CdIG+igBoVeJRAxrv4rFxezsX85kZwxJD+6DeVw0bxIiZS
         6l2Ke77VvP70o0XyYq13Mi1r+okLk9hpnLxnlXkoOa83leVwsqDRgVLv/AZARRJ8v5A+
         m7HtqkSJ3jCulfQLfXZstGjL7vDCIeacitPerohg379d0HJw+WPpnTVgnqIsZCypcJxi
         v9WA==
X-Gm-Message-State: AOAM531UwbqLAzIqKj5AnUh5nkXr/A875VzAy+V1qPmLZanhr4HXhcK8
        KGyD5HnXpPJ+KfobaQzTjwAfum607mPW
X-Google-Smtp-Source: ABdhPJzgjT7apG8TaEFkhMhYKDaDRZ1IN5VMOt+FlYdjSGgTTHFlsSkZhniqaKB7NDjC8GzT+FpcwA==
X-Received: by 2002:adf:f086:: with SMTP id n6mr17493181wro.388.1589799938489;
        Mon, 18 May 2020 04:05:38 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a74sm10565648wme.23.2020.05.18.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 04:05:37 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     dledford@redhat.com, bvanassche@acm.org,
        jinpu.wang@cloud.ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: [PATCH 0/1] Fix kbuilt test smatch inconsistent intentation warning
Date:   Mon, 18 May 2020 13:04:53 +0200
Message-Id: <20200518110454.427034-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202005181024.7TYVfk5c%lkp@intel.com>
References: <202005181024.7TYVfk5c%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, Hi All,

this silences the inconsistent intenting smatch warning in
the rtrs library found by kbuild test robot. Is this a strict
requirement to always clean this kind of warnings? Please apply
the patch in case it is.

Thank you,
Best
Danil.

Danil Kipnis (1):
  rtrs-clt: silence kbuild test inconsistent intenting smatch warning

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

