Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD544226CFF
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGTRQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgGTRQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 13:16:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D3BC061794
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o3so13930633ilo.12
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qwickyyv+4ldeHVNeH2NCfRItkI/Z4dSZ3CyauroqVg=;
        b=otwo/2WjjvjzpYYCBIGC7XzBXn8zYwsoTOGjYT0J6k3AsRNX+n9894EbJFKpQffodl
         5SNJ1rXDEXRPibSePGy0soF25UXYB24AKkkkqO97s6Jg/8SXZY6QlOWhQom783I7i7hG
         WIel9K1J4VmmZxCDKP2Qnc4SByoiXKxGWLWf1c309RtR/f8211Tc5aOpY2pO7Y+srjbO
         Xa84NgWz5DWsJntPy06ZTOLFibuOhjrRxusizTSxcyEoBYT9DNTnIiMgUD/JOn7WMS+P
         Hz/Bl5VcsgV8UJ8edFxEpVt6Gi5DeCkMnRG6jeJNOPr2KDU265qmbLcI2q7wXQUYAw9y
         m4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qwickyyv+4ldeHVNeH2NCfRItkI/Z4dSZ3CyauroqVg=;
        b=fOqrbbhS0g6yio4l/uKwwTkI1P+0ulO16WJErigOkpKs/LB0f8gKByXpxeoGx4wL9z
         l1CTWgSlO0mUBcgL5SVwGN+QphBB3LUKoGuXTGNmv35+BZsjY6TEMnTlWXWcWBW0Ea6A
         78O8qxZzosQkuDF8uF/vwqhUd8KzSccr9/AUI5WMqeoKXYp+i07m17h/apm6LBgHondP
         3djgPZa40yVjUm9A8Rv8qm+yCY4BalUG0WwBThxo8JH58s/PY5G5XkzoDoDRW9caw5ek
         pMrmztyMr/3GZB713Rd5J+HBtiS8htNsDLNUkwSKbX9vZrwG0un1BHru9cwprxDNUvYY
         8GzQ==
X-Gm-Message-State: AOAM533G8haJK9THpO9uuIIaL4u6d2SMmHw2zoqjIaOe5jAVGID/AfNO
        NnEafRpASv9Umh4LsfWJYcvjeAjp
X-Google-Smtp-Source: ABdhPJwjb0qgXmu3kk67Ns8Pwf9H5l+AHosJBXowz1y9VgSmMw4CPQtMh8yOwBqA9KlsYHlebAUTPA==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr25153780ilm.25.1595265392188;
        Mon, 20 Jul 2020 10:16:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d6sm9062000ilq.27.2020.07.20.10.16.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 10:16:31 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06KHGSKS023975
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 17:16:30 GMT
Subject: [PATCH v2 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 20 Jul 2020 13:16:28 -0400
Message-ID: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Oracle has an interest in a common observability infrastructure in
the RDMA core and ULPs. Introduce static tracepoints that can also
be used as hooks for eBPF scripts, replacing infrastructure that
is based on printk. This takes the same approach as tracepoints
added recently in the RDMA CM.

Changes since RFC:
* Correct spelling of example tracepoint in patch description
* Newer tool chains don't care for tracepoints with the same name
  in different subsystems
* Display ib_cm_events, not ib_events

---

Chuck Lever (3):
      RDMA/core: Move the rdma_show_ib_cm_event() macro
      RDMA/cm: Replace pr_debug() call sites with tracepoints
      RDMA/cm: Add tracepoints to track MAD send operations


 drivers/infiniband/core/Makefile   |   2 +-
 drivers/infiniband/core/cm.c       | 102 ++++---
 drivers/infiniband/core/cm_trace.c |  15 ++
 drivers/infiniband/core/cm_trace.h | 414 +++++++++++++++++++++++++++++
 4 files changed, 476 insertions(+), 57 deletions(-)
 create mode 100644 drivers/infiniband/core/cm_trace.c
 create mode 100644 drivers/infiniband/core/cm_trace.h

--
Chuck Lever

