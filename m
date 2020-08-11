Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7F241845
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 10:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgHKIbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgHKIbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 04:31:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092BC061787
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 01:31:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so12181771ejb.4
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiEVGPid6fNu3u2/+UVT80DrdCDFGK6L0AEhBU/401w=;
        b=PyjA9AmdtZwpDwiqa7CWI/1e1+SMXF8+PoPYnxb+EWmtB09hHtqNEQvDJYifVgJe5t
         0cFPEm+eCxvvj1bsdNVbLfH7NtIIwA3rKYKl2A5FFOCZ4kJiWSg8fVE6INjDmVGJcF1y
         J2Ga9RGRm1J0z4XX9b7ynr5Hat8fw2XHn3vLBeRcyBeWenHgdYIyFNe1/EeZV8EsdKpE
         M7BuOEI8RdlOuS6jNIOjmuUIvD4f5PGD9WD8VBBjLcY11WQnzu/4Jfows5e+WrVeq2IA
         cd5AHJRtDanuK+woC3qPsW5q279EOx7mKRPffQNO/cmfPrYf9bF50ajRtwTdZb9vWn50
         Y4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiEVGPid6fNu3u2/+UVT80DrdCDFGK6L0AEhBU/401w=;
        b=A6tmjgrbdS4lIba7+3G52z/7hRIC+Qvcc/wvtIgmyDnNnHlJH/5Oe++7raXRZAiu1z
         7zHFkrjnxxZ/eA49E4z6SD1+zBcRe0QcM744v2xrUndvIp77C5WNZGdm8ZRQLEcAZiFi
         GDHDp3RHsdT7C9HPkCGvtIApsaKDrtKKG5T5s6at8aKtZwJUPTbwUBDbZMnEHT2t50G0
         CZiBTObflRBMtUkv8zZI+ApnY1wiLK8JIPrifU3pUAHu+j4rE+6xaQwTossi3Wr9QRKw
         /xw5t/A/NDVz6QMwUndIHtCzCjIkGdVMKdAcsLG+QzFmk1kISKcL7nfP5Bur8XY7LLk3
         ohkg==
X-Gm-Message-State: AOAM532bn1Knbs/KOdTYgECYXmJaMQHtVstUxO72pkQDWPQ7a0mG5kbZ
        QmiJq3+5NQMJtCi6oBqf26aHHdaRmB6MuqdwGWLQuA==
X-Google-Smtp-Source: ABdhPJzG73nvFfk0XHtVcnuCEDIBQb1M84nJWERMU5MRp5HyWBIMdmOdwokCmjSJgOTGZ+wm37iGEylpCzk4+KHjTP0=
X-Received: by 2002:a17:906:7a16:: with SMTP id d22mr25846663ejo.478.1597134695070;
 Tue, 11 Aug 2020 01:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 10:31:24 +0200
Message-ID: <CAMGffEmN25PjoLVsWPbp7kVrCWpA-T8AMxb32zYtSVs=3Z090Q@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 1:51 PM Md Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> The rnbd_server module's communication manager (cm) initialization depends
> on the registration of the "network namespace subsystem" of the RDMA CM
> agent module. As such, when the kernel is configured to load the
> rnbd_server and the RDMA cma module during initialization; and if the
> rnbd_server module is initialized before RDMA cma module, a null ptr
> dereference occurs during the RDMA bind operation.
>
> Call trace below,
>
> [    1.904782] Call Trace:
> [    1.904782]  ? xas_load+0xd/0x80
> [    1.904782]  xa_load+0x47/0x80
> [    1.904782]  cma_ps_find+0x44/0x70
> [    1.904782]  rdma_bind_addr+0x782/0x8b0
> [    1.904782]  ? get_random_bytes+0x35/0x40
> [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> [    1.904782]  rtrs_srv_open+0x102/0x180
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  rnbd_srv_init_module+0x34/0x84
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  do_one_initcall+0x4a/0x200
> [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> [    1.904782]  ? rest_init+0xb0/0xb0
> [    1.904782]  kernel_init+0xe/0x100
> [    1.904782]  ret_from_fork+0x22/0x30
> [    1.904782] Modules linked in:
> [    1.904782] CR2: 0000000000000015
> [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
>
> All this happens cause the cm init is in the call chain of the module init,
> which is not a preferred practice.
>
> So remove the call to rdma_create_id() from the module init call chain.
> Instead register rtrs-srv as an ib client, which makes sure that the
> rdma_create_id() is called only when an ib device is added.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks!
