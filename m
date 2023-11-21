Return-Path: <linux-rdma+bounces-11-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56EC7F2DDD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 14:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FE5B21860
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D81482F5;
	Tue, 21 Nov 2023 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="amDMPq7C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65374D52
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084095722aso27600795e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700571797; x=1701176597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRodHR+0DxLQ8tzFCB2jJC9b0bDxDXgeAV1aIIOqc5w=;
        b=amDMPq7CCC8pH5CTvY/TveZgvKHy0/8sUoMk65ZACYbvBllGPX8ilWQFKJEyckYpkK
         EVKYyrQHI0yhzKrWDBARfsf5UitZ9fzvDu+jauiIi0U2QwcHYMpttr67E+C3EzZKP+Gu
         0bAst68O+uyAbIWyNk3QnPG6OZRNn1BwV80kk3gsGbFOTw81U40oPKLxVlUkbNayI+0u
         AJKAYWGaHs4VQhXWjEVY93+eZVlB62/y0klV+vNDwlFQXPLhJoxr9Hqa4zC/gx6ffhYz
         Pfe1+Uu9eMKvPNJj57XbNghWoPMqfOQE9AdSM+oBhyoWnvUPpNpSF05j4nua/AQ3kMaf
         uA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571797; x=1701176597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRodHR+0DxLQ8tzFCB2jJC9b0bDxDXgeAV1aIIOqc5w=;
        b=SVJgYOhnydpoitTYZquddW59gJbDNFF2eLC2BnpYj9WZORNpIC0b4WB5cnH9nKfVx7
         8m60U8plAkffBA1sFxC/kxT8amnrd2j9aBgUXdSCX7iEapFTmigAVBfJb0XDe7pdsdIO
         2aO/wGwqsBWrPecwvLnHpWGIDVarJPuDdOCQBv6YDDePXyjWVqX2K1J/5r+oGISyN3ID
         OTg5yW2UPkxRua8Jy2oJZdiffnoYt6EfSDWZD1BGtfubJojvJ2mTiJn3WEWmBsydaiyZ
         UgbD1LS703GFgUyypOnA2mIJqB4lrGBJ/5k+ljzZr/CiApNsDg/G20xwv6Y+38mYhx8T
         MyLw==
X-Gm-Message-State: AOJu0YxftU1FwWvYR2Pxe+4m8bxXumo229o6OqsN/362il3mYWpaYLE+
	lXqba40Gr2xarLTDaWJGkeCA/fIgmMWHh6JZtV4=
X-Google-Smtp-Source: AGHT+IGYQEYf3TRssfXbw33GyGgNNZPovDowMWJBvyFCvOvXsG/L9pwTy4YgKPu04ru+16URCgsQog==
X-Received: by 2002:a05:600c:354f:b0:40b:2b86:c88a with SMTP id i15-20020a05600c354f00b0040b2b86c88amr859937wmq.2.1700571797430;
        Tue, 21 Nov 2023 05:03:17 -0800 (PST)
Received: from lb02065.fritz.box ([2001:9e8:1427:de00:2523:9f30:fa95:ba54])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b004077219aed5sm21949606wmb.6.2023.11.21.05.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:03:17 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca
Subject: [PATCHv2 0/2] ipoib bugfix
Date: Tue, 21 Nov 2023 14:03:14 +0100
Message-Id: <20231121130316.126364-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We run into queue timeout often with call trace as such:
NETDEV WATCHDOG: ib0.beef (): transmit queue 26 timed out
Call Trace:
call_timer_fn+0x27/0x100
__run_timers.part.0+0x1be/0x230
? mlx5_cq_tasklet_cb+0x6d/0x140 [mlx5_core]
run_timer_softirq+0x26/0x50
__do_softirq+0xbc/0x26d
asm_call_irq_on_stack+0xf/0x20
ib0.beef: transmit timeout: latency 10 msecs
ib0.beef: queue stopped 0, tx_head 0, tx_tail 0, global_tx_head 0, global_tx_tail 0

The last two message repeated for days.

After cross check with Mellanox OFED, I noticed some bugfix are missing in
upstream, hence I take the liberty to send them out.

Thx!

v2:
Fix the build error due to napi api change in v6.7

Jack Wang (2):
  ipoib: Fix error code return in ipoib_mcast_join
  ipoib: Add tx timeout work to recover queue stop situation

 drivers/infiniband/ulp/ipoib/ipoib.h          |  4 +++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c       | 26 ++++++++++++++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     | 33 +++++++++++++++++--
 .../infiniband/ulp/ipoib/ipoib_multicast.c    |  1 +
 4 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.34.1


