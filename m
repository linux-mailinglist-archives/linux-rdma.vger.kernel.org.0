Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43938CAB1
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhEUQOJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 12:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233360AbhEUQOI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 May 2021 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621613565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BUc9vNUEFI1h0TmHJFjFqgJSEIeT9zOloVrP9nB4LeI=;
        b=L6416ausM99Y1d6dX1139h0HPcTU3nq2sJN1tx/zdkBLnI8JZa8pAmUTe8MLDlJMUANcjN
        a2TYCgfYw8zTpWPbXGE252PZ8J1WxX4x83zKmaE+DX5kWycbWxsE4Q161PsKd2LXyPfiLy
        4nh1Y5+vb/+uylppVjYRX815NZLy51c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-wfwzLVC8OHeyBFEcSVL3Zg-1; Fri, 21 May 2021 12:12:38 -0400
X-MC-Unique: wfwzLVC8OHeyBFEcSVL3Zg-1
Received: by mail-yb1-f199.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so27587807ybp.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 09:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BUc9vNUEFI1h0TmHJFjFqgJSEIeT9zOloVrP9nB4LeI=;
        b=H+Q4sY13G1uRbGF46fwe+Wc4QZSX3oDAvuRUBgXBVklOO6t+C7FR1TLBMNOHyp0xw3
         OCDJzjmySEsr9zkprvWoLlb7/r4iQIvwu6Sa/GlUwkzHGjoxpQplqAtfFWKZ5jCJVgsI
         eMpWRsTnzsdYIWsbs8r5PeAkWKoHTUIeXpjxSd+sZuA0J4iUkkxTREmhyKc4C2khQRZW
         yNGHTvoZHtEa3xsg2qMbka/+abhfg37zrDOwVmgB8uTgJe+clCYe8AbypF7jVudtIhZJ
         YThZxivAdI4RlaU/YUbdnwR2hcJ78qoNmaeRK6wsBszLw56RuA8Ei9JxyPzU/4XSb6dn
         1HNA==
X-Gm-Message-State: AOAM533Xh6StBcraXTneuUeOIWKY0maHOKurlVxEayhg2JfI6CO7VeUa
        GTEXrSngrgWiDKKaDNZGKkQOo+qeh3EjfPe81YxA4QLACaikM4FZqK2goMWj9wuZB31Q+WHHMMo
        0skjcX/owZ8R4M6L8G/W8fnoLjq142VZmbzQtiQ==
X-Received: by 2002:a25:744c:: with SMTP id p73mr15877958ybc.205.1621613557621;
        Fri, 21 May 2021 09:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9T/WrkOTucst8g6Y/ojDUHloCX6zpyTKTQfsLHXdMgJ7O9jJK59DUa036rYJOBdNxbyZzZZ0jXlGo3s+PjuU=
X-Received: by 2002:a25:744c:: with SMTP id p73mr15877934ybc.205.1621613557420;
 Fri, 21 May 2021 09:12:37 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 22 May 2021 00:12:26 +0800
Message-ID: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
Subject: [bug report] NVMe/IB: reset_controller need more than 1min
To:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, maxg@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi
I found this issue on 5.13-rc2 with NVMe/IB environment, could anyone
help check it?
Thanks.

$ time echo 1 >/sys/block/nvme0n1/device/reset_controller
real 0m10.678s
user 0m0.000s
sys 0m0.000s
$ time echo 1 >/sys/block/nvme0n1/device/reset_controller
real 1m11.530s
user 0m0.000s
sys 0m0.000s

target:
$ dmesg | grep nvme
[  276.891454] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
[  287.374412] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  287.399317] nvmet: ctrl 1 fatal error occurred!
[  348.412672] nvmet: creating controller 1 for subsystem testnqn for
NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.

client:
$ dmesg | grep nvme
[  281.704475] nvme nvme0: creating 40 I/O queues.
[  285.557759] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  353.187809] nvme nvme0: I/O 8 QID 0 timeout
[  353.193100] nvme nvme0: Property Set error: 881, offset 0x14
[  353.226082] nvme nvme0: creating 40 I/O queues.
[  357.088266] nvme nvme0: mapped 40/0/0 default/read/poll queues.


-- 
Best Regards,
  Yi Zhang

