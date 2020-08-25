Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729C4250E4E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHYBjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 21:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYBjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 21:39:44 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7BDC061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 18:39:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x24so9122412otp.3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 18:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uy8Hi/pCpWxAdnNOPkw4JdxUGcNrJJ3zXEj6C2N67cw=;
        b=ccXPMMX8HCUO4hq0OnicGHUyh6/6m7lwQoe8JBrr/rQ5uRzo1dpCvdKtS0BLOa2EKi
         D9RT7zA+4JcI0Tz9zTXXY9i6pafTxzQek2EJJeFSXDHOuZPS3Ki2eda6KXKkBEXZSMIY
         S3GiXkd6Iss9u6vzvNZCKe6BhxX8WwjXMe/Jd3WvTVvrDrP+4/6+y+gyI7z3hhUmZfV9
         A72ZHail793L0ZQHTjUQF8d6sl1XrpcJx4q0xwDJlFjrsCT3psY+pUqBhtsG/QYeu91z
         UsEtPB3ZRecGsixV96X5LUTl5dBrrD7GVzTOkRFxKkfbNIgoXJqlMmNhrd/Z9gT+KjpO
         tDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uy8Hi/pCpWxAdnNOPkw4JdxUGcNrJJ3zXEj6C2N67cw=;
        b=D2sW34xDZLOAH7quibIiET03LY31mXtUx4ygGs4X5ypLQp5hOkqSIUslY/ceGo18jk
         bKf0uMCSiqKPIuYffcDxV9KZYND8/ISzLUCimSHuIw7qdKnKpAtCI6Zj+W5tDG9vpa7I
         dqa4X9l/nogOEPr8cNqdptKffBNvfyLo9dRtw17fcNcHwdiFo8gvBmj75DKqk9fIddbE
         iyYqFfeNOcn/GzSB+tDrAmk2pGnsDoNSmjmL6lfGPgRs+9xUu2F3WFjrra99E1C3d5cm
         9MxFqltPYB5TJGCCTYJw4DQViZv7JghrvmX1jeKcK9wHLb95T6HQHV+XTOdVQ9ObBw/v
         MMxQ==
X-Gm-Message-State: AOAM5319ZuaXcbkbwhla6Iuvv8T0mPZ+lZ10JlOInmW0ZK/tM3JDSlum
        lJtZhM9cmXHp+cwLi1r089lzXtIlmIqHHYf+QTIklmAmyy0=
X-Google-Smtp-Source: ABdhPJzZldJpkhexYJhmkXEEPCAN8ncaJaAYQxfaMXOZDyMRH0UILPXloERisXa0diFGhXL5+VAV2N8+/6ZAkUIkHOo=
X-Received: by 2002:a9d:4c12:: with SMTP id l18mr5752316otf.260.1598319580319;
 Mon, 24 Aug 2020 18:39:40 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Worley <worleys@gmail.com>
Date:   Mon, 24 Aug 2020 15:39:29 -1000
Message-ID: <CANWz5fhKJ=MbXdQo8gjAvioGj4V+V0wKZrU90OnCc+Nn0KkBLg@mail.gmail.com>
Subject: NVME module won't load ("nvme: disagrees about version of symbol nvme_uninit_ctrl")
To:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Running MLNX_OFED_LINUX-5.0-2.1.8.0-rhel8.2-x86_6 on ConnectX-3 cards,
attempting to run NVME-over-fabrics.

OFED installed with: "./mlnxofedinstall --add-kernel-support
--with-nvmf --force"

The OFED install did indicate it couldn't load the firmware (although
these are Mellanox cards) and said: "Note: In order to load the new
nvme-rdma and nvmet-rdma modules, the nvme module must be reloaded."
... but the nvme driver doesn't even load.

Where did I go wrong?

Thanks,

Chris

[ 1862.838855] nvme: disagrees about version of symbol nvme_uninit_ctrl
[ 1862.838856] nvme: Unknown symbol nvme_uninit_ctrl (err -22)
[ 1862.838872] nvme: disagrees about version of symbol nvme_complete_rq
[ 1862.838873] nvme: Unknown symbol nvme_complete_rq (err -22)
[ 1862.838886] nvme: disagrees about version of symbol nvme_reset_ctrl_sync
[ 1862.838887] nvme: Unknown symbol nvme_reset_ctrl_sync (err -22)
[ 1862.838900] nvme: disagrees about version of symbol nvme_wait_freeze_timeout
[ 1862.838901] nvme: Unknown symbol nvme_wait_freeze_timeout (err -22)
[ 1862.838932] nvme: disagrees about version of symbol nvme_start_queues
[ 1862.838933] nvme: Unknown symbol nvme_start_queues (err -22)
[ 1862.838944] nvme: disagrees about version of symbol nvme_alloc_request
[ 1862.838944] nvme: Unknown symbol nvme_alloc_request (err -22)
[ 1862.838983] nvme: disagrees about version of symbol nvme_setup_cmd
[ 1862.838984] nvme: Unknown symbol nvme_setup_cmd (err -22)
[ 1862.838996] nvme: disagrees about version of symbol nvme_start_freeze
[ 1862.838997] nvme: Unknown symbol nvme_start_freeze (err -22)
[ 1862.839009] nvme: disagrees about version of symbol nvme_start_ctrl
[ 1862.839010] nvme: Unknown symbol nvme_start_ctrl (err -22)
[ 1862.839028] nvme: disagrees about version of symbol nvme_submit_sync_cmd
[ 1862.839029] nvme: Unknown symbol nvme_submit_sync_cmd (err -22)
[ 1862.839066] nvme: disagrees about version of symbol nvme_disable_ctrl
[ 1862.839067] nvme: Unknown symbol nvme_disable_ctrl (err -22)
[ 1862.839097] nvme: disagrees about version of symbol nvme_wait_freeze
[ 1862.839097] nvme: Unknown symbol nvme_wait_freeze (err -22)
[ 1862.839108] nvme: disagrees about version of symbol nvme_cancel_request
[ 1862.839108] nvme: Unknown symbol nvme_cancel_request (err -22)
[ 1862.839121] nvme: disagrees about version of symbol nvme_cleanup_cmd
[ 1862.839121] nvme: Unknown symbol nvme_cleanup_cmd (err -22)
[ 1862.839132] nvme: disagrees about version of symbol nvme_sync_queues
[ 1862.839132] nvme: Unknown symbol nvme_sync_queues (err -22)
[ 1862.839167] nvme: disagrees about version of symbol nvme_change_ctrl_state
[ 1862.839168] nvme: Unknown symbol nvme_change_ctrl_state (err -22)
[ 1862.839182] nvme: disagrees about version of symbol nvme_init_ctrl
[ 1862.839182] nvme: Unknown symbol nvme_init_ctrl (err -22)
[ 1862.839200] nvme: Unknown symbol disk_to_nvme_ns (err 0)
[ 1862.839221] nvme: disagrees about version of symbol nvme_remove_namespaces
[ 1862.839221] nvme: Unknown symbol nvme_remove_namespaces (err -22)
[ 1862.839231] nvme: disagrees about version of symbol nvme_init_identify
[ 1862.839232] nvme: Unknown symbol nvme_init_identify (err -22)
[ 1862.839261] nvme: disagrees about version of symbol nvme_enable_ctrl
[ 1862.839262] nvme: Unknown symbol nvme_enable_ctrl (err -22)
[ 1862.839291] nvme: disagrees about version of symbol nvme_kill_queues
[ 1862.839291] nvme: Unknown symbol nvme_kill_queues (err -22)
[ 1862.839303] nvme: disagrees about version of symbol nvme_complete_async_event
[ 1862.839303] nvme: Unknown symbol nvme_complete_async_event (err -22)
[ 1862.839315] nvme: disagrees about version of symbol nvme_stop_queues
[ 1862.839316] nvme: Unknown symbol nvme_stop_queues (err -22)
[ 1862.839327] nvme: disagrees about version of symbol nvme_set_queue_count
[ 1862.839327] nvme: Unknown symbol nvme_set_queue_count (err -22)
[ 1862.839339] nvme: disagrees about version of symbol nvme_shutdown_ctrl
[ 1862.839339] nvme: Unknown symbol nvme_shutdown_ctrl (err -22)
[ 1862.839352] nvme: disagrees about version of symbol nvme_unfreeze
[ 1862.839353] nvme: Unknown symbol nvme_unfreeze (err -22)
[ 1862.839363] nvme: disagrees about version of symbol nvme_stop_ctrl
[ 1862.839364] nvme: Unknown symbol nvme_stop_ctrl (err -22)
[ 1862.839387] nvme: disagrees about version of symbol nvme_reset_ctrl
[ 1862.839387] nvme: Unknown symbol nvme_reset_ctrl (err -22)
