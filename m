Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735E818A8FB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 00:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRXHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 19:07:51 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34512 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRXHv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 19:07:51 -0400
Received: by mail-ed1-f54.google.com with SMTP id i24so287404eds.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=7tP46YN5vtYe4c8oJNbBW9X6X2YsjiAXlQCTpLv+bLw=;
        b=v37AMJ2Cjz+G3FeiWFmEGKZqvixv2fs8MTuYJwuXbm2is3LPDYwUL31dJTCDUKlFQO
         M4e7jc/swztBd1Pq/QDsn0Ot5KwXY8kQFrvt9E7TdAB+nQzpVKnv+tGiFQGhw5nieMJ7
         3Wje6gQPIKZjKshalaXgU6b+bIh5OD4M+oyN3wKoqlGcTkgxz6mp+hoPd+0nilV1CJrD
         yitOsYqfN5quw4fWBY0/R24ooKTtRzWBcY89Y7fCdzkijGBfVuGkzCU8yB6RkICMrUvU
         fDtdP0W2c/RzhzNvBSRq2+ss5fqNuKW9SkhIbjMJ/KXyW8/1fFr2EPcyiyTk5lbwXkX8
         kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7tP46YN5vtYe4c8oJNbBW9X6X2YsjiAXlQCTpLv+bLw=;
        b=RI/VfvFSoxHM5rqlrV+x1LQkVxFDhcE1ELUxiUwYi1Dal/DOT/shuQIjAVVFVKrtvZ
         36PGBspPNuGmpmSNC6BQO++pwxgOjhf6cGoBS9gGeDC757FZCSFfQBzzQdRL+bW6jMVP
         PUiHsvOO/Rjm5C9UyeLhHBxphZJ5QYCmNUBeel76GEwrujFf2ojxyRvv4Qt3lGx1vFZJ
         mg1/kF8WhOR8ctR875aYJWN4OBIN8mu3CNTx8BAcV+CjXEy5psyvGdXz7mLz5LObVs/K
         BfaxhB4U03ZIsgfgCAGk8ZdRgzX3df2WT2VZWP9Wcqg/lXaDHh0eYfpuXanhhcsw6DWF
         xUzw==
X-Gm-Message-State: ANhLgQ2AQTiBYTIbPErg4yISbPzEoMLXMfCvJWMMTEoIDbes5exMou97
        foo93NrLbedLU3dry4EeOOpBUI/qiPi03u4PiMZbw/hi
X-Google-Smtp-Source: ADFU+vtusC2BzzHg21+io5RMbtAoYiqVD7E5uUbO7ZqPefW4QDnc+QCmRH2Uvobvc2p0cD29v56UQdxR9Y8fjZz8/50=
X-Received: by 2002:a50:aca3:: with SMTP id x32mr6594184edc.368.1584572868978;
 Wed, 18 Mar 2020 16:07:48 -0700 (PDT)
MIME-Version: 1.0
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Wed, 18 Mar 2020 16:07:37 -0700
Message-ID: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
Subject: UDP with IB verbs lib
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm looking at UDP using the IB verbs library. If I send UDP packets
that are intercepted by the IB verbs layer, what happens with the
completion notifications ?

For example, say I create a list of 10 ibv_recv_wr objects and each
has num_sge = 30, with each SGE having a 4K size. And I setup for
reception with ibv_post_recv(). If I transmit 30 UDP packets each 4K
in size will I receive one CQ event ? Or 30 ?

Will the UDP packets be written in consecutive SGEs of the first
ibv_recv_wr object ? Or will they be written in consecutive
ibv_recv_wr objects (in their first SGE) ?

Thank you.

Dimitris
