Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16F3DD20B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhHBIdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhHBIdf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 04:33:35 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649BCC06175F
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 01:33:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso3057746ota.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGjVcY9jHFWorlQ+Cz7g+1ccOyHATV6WN0PPozhhWEI=;
        b=sULfPERXVLAEQG4OMQRpiawru7sAMopcHba2X/mUXvwZSy01T9kJYhjdRSlgkLSfHQ
         uzARkZ7X2puZ2naWAnj+rPq7/1Fmw1SeVIp5A6LmtwqURaTAPK42fizF1WgKcbfRKPWB
         TOrRY630O/TLCLBtg/IEYuTF8lQrS0VLcwwFwOq/6XMfBj0S1NJKs1GvCEOvLGZpkOje
         cHpJcmfNLiEQ42j43MA9cpCC3dbHuDylr2KB67XlsYIb1lL/+fG0EbS97uvpWNuFn2H9
         lwpaVtQbyynWJsfRhZ+AxDQCrMsZROp2TiQbej7OYP973pqIiVUb3PUdN7n19qxmnuKf
         mB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGjVcY9jHFWorlQ+Cz7g+1ccOyHATV6WN0PPozhhWEI=;
        b=rxKDiqdRYWU62purjH7qBFqXcOio0cFlftAPogEhootz2CPtFA+exWqBPzT0MDmdg4
         nWShw/2LV32240XmrBVIIDrbXHgUcSszJ2qE6V4+7X0JZ34R/V0oEvEn6BNou+OG1tZU
         NxLpVuZ7vHRDijwUrczYcYz5X4jrjPBm/Of/M8iNPypi2bzp/P7jAFHm+4Z1PhzG87Vx
         eEPsq58av5qmU+PRjaoT+EagmDm7oopy8gPRCqNm8KEFGGVCR5gJ99EQdE4O2ncZke0L
         jX7Ncc8S+0S8PbRpO27qroCBPx1mqjlZiJZab18mvILSh7pwze8PGsp2YcTUza48HNDy
         0mSQ==
X-Gm-Message-State: AOAM533EBqF/uxzEFMZzPlBXEu88s/oNZ7uKhNLZC2J0cSC3rvbp+NVg
        oIEDwGr2/O2vo26+AtwqHo8Pv8JKaTMH+WBvy5I=
X-Google-Smtp-Source: ABdhPJw5Jotm7Enai6IVWWkM7HbpXAf55YRnC4WiyifOtAsK7WdkV3Ah0JDastXCyKQpbgisl0U1mueyKGCC/n+jWwQ=
X-Received: by 2002:a9d:5f87:: with SMTP id g7mr11179164oti.278.1627893204837;
 Mon, 02 Aug 2021 01:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210729220039.18549-1-rpearsonhpe@gmail.com> <20210729220039.18549-3-rpearsonhpe@gmail.com>
In-Reply-To: <20210729220039.18549-3-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 2 Aug 2021 16:33:13 +0800
Message-ID: <CAD=hENf5i3+rHZtA-O_bafEfZtYp-0FwkT=jPrd59VxyT0=XmQ@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/3] RDMA/rxe: Fix bug in rxe_net.c
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 6:01 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> An earlier patch removed setting of tot_len in IPV4 headers because it
> was also set in ip_local_out. However, this change resulted in an incorrect
> ICRC being computed because the tot_len field is not masked out. This
> patch restores that line. This fixes the bug reported by Zhu Yanjun.
> This bug affects anyone using rxe which is currently broken.
>
> Fixes: 230bb836ee88 ("RDMA/rxe: Fix redundant call to ip_send_check")
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

This commit is needed.

Without this commit,  on some different kernel versions,
SoftRoCE can not connect to each other.

Thanks a lot.
Reviewed-and-tested-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 10c13dfebcbc..2cb810cb890a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -259,6 +259,7 @@ static void prepare_ipv4_hdr(struct dst_entry *dst, struct sk_buff *skb,
>
>         iph->version    =       IPVERSION;
>         iph->ihl        =       sizeof(struct iphdr) >> 2;
> +       iph->tot_len    =       htons(skb->len);
>         iph->frag_off   =       df;
>         iph->protocol   =       proto;
>         iph->tos        =       tos;
> --
> 2.30.2
>
