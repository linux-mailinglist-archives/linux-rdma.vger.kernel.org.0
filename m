Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA31D9191
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESICy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgESICy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 04:02:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B1C05BD0A
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 01:02:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so2041924wmf.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAvzowp8ctEQm7gDEd4YN2NPgCDtGpVSkCRU+hDllI4=;
        b=O2Wky9A8duWFoGp+rYjpSC7TU3//cc4PxKnhXm14syvXkMGjtoAZx5r+2dD9EEjaw8
         mEjRZPJBmzBNhma59aN5Hn3C6nd2TR9J+CBC4p2sgK9Yy1l2XGy/66MGx9e58sDdPTuD
         O76M7mN3bjI3KdGef5qiAx2H1Bwf1gVoAdA3c9ooYIRKaNqdHtYzhkPz9lW39isn17Oe
         tgO+sof0JCQ9xaIJGskoM5okQDc9mPD0nVoFlYFLWwgR2ZdajvyQztYkbkNxmfMcEgYs
         Y55qnN7SLKWV2DnFMItkhtRM6LgoUIWDE6PJwq9opSFr0n7TsWaZ6XjXKvFWI5sFoCkn
         lkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAvzowp8ctEQm7gDEd4YN2NPgCDtGpVSkCRU+hDllI4=;
        b=rLO5PvelgL89z2h4m8BXUVHH8djjt2yMT5PNjJ3d4Fmb/Lm9bFMrsFTSjvLBblTW3E
         txMrzySYzpK6nynRDwqfJJr41mRvmuSUgA7QQV1Xyd364GB1ie7jVxhGpDPF9vgHLzNc
         JjC+UWjOuXEEUP7ClmatGgrlqF6LG2U+egDBufsx+2VkO5t8HRLd0aRTCOLzlj3t8aPR
         LBotSE492dXX5hRzD0OcqvIKShX+EbyUmxt0IIBPOFyRerWvn+CcNz/v07Bx6Vc/MRx3
         Ru9IWsWbihJ/fK5aAgMF4SWzuDFeMb6kYvbCLVcPemlefwzN/wZOpIR5YIu2zC55wkqu
         bbJw==
X-Gm-Message-State: AOAM532IEF031VNb5i1MYmqyppvBUZWS5ddtSomqVgwc/PYet3hntExF
        5mcKxaNc29Egz9Uk6tlIPrV2P91lTQ+xq/k=
X-Google-Smtp-Source: ABdhPJyYv429uc6XmHCaQKhGJrU9gXQ+XOl2Zv+wDcE8FrVLNhN172EIHdiBjZibiPINaTcoaegb2Q==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr3983307wme.162.1589875371784;
        Tue, 19 May 2020 01:02:51 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id g10sm18915386wrx.4.2020.05.19.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 01:02:51 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linux-next@vger.kernel.org
Cc:     jinpu.wang@cloud.ionos.com, dledford@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        rdunlap@infradead.org, leon@kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: [PATCH 0/1] Fix RTRS compilation with block layer disabled
Date:   Tue, 19 May 2020 10:01:35 +0200
Message-Id: <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, Hi All,

this fixes the compilation problem reported by Randy Dunlap for RTRS on
rdma for-next.

Jason, am I even doing the right thing sending the fixes for the issues
reported for the for-next for RTRS/RNBD to here?

Danil Kipnis (1):
  rnbd/rtrs: pass max segment size from blk user to the rdma library

 drivers/block/rnbd/rnbd-clt.c          |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 +++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.h     |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

