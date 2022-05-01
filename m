Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA651651B
	for <lists+linux-rdma@lfdr.de>; Sun,  1 May 2022 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiEAQRo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 May 2022 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348924AbiEAQRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 May 2022 12:17:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AB43ED8
        for <linux-rdma@vger.kernel.org>; Sun,  1 May 2022 09:14:16 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ebf4b91212so127649687b3.8
        for <linux-rdma@vger.kernel.org>; Sun, 01 May 2022 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVK2j7cWxGkq18poKHDIybxzNjO5ViIx+9L61BYDkL8=;
        b=ctHOLkDwhrs6iNhs9Cv7Nm+kyJjgrqeLiAZP2gPamPJPBY8xGWwKNRYV/V2NGKFOKZ
         1JKtbzo4AzuYWRl2OwZtjvTGDYAoqWrqVJC2mO/2mN3lts2nTsVi58AZe03/uTvYWi6k
         YgQ65dYSgaK1NQ4efL4UEoCHdGGDCVAz+oK8s7gJL2SWVMfc0uBYHY2gdo41uxZ5OIr/
         87XMl996Gs2b3cp8239IVfq7kJnm7+a6i4ZiEp1aWWMxosY7oHYdU1qh/yJeWnpQxjMZ
         S/QABuxN/PgUl2LznmI9sChtY+GpAssD8UI/e4PN3fzVUzcIyuMEqNk4GJpUvi1qR2Zt
         zOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVK2j7cWxGkq18poKHDIybxzNjO5ViIx+9L61BYDkL8=;
        b=73lJgK5+SlBf9RzonTQyB6+ieNWEt+zlyvmn/eTpx2Wkhgb7VC6/hhzWCAWdUDxFAJ
         GiBKh5k14Osdb8A3gesz3EUTAUYW3rbPYqggAB29S6HCPkxWfa5/5VjcTpVItdhbtRb0
         2MUwNRW+PBvZJRQvYPEaw2uQ1/RPRMek0zOAumO5qCza8e5NXNNE8e09s4gO0lni/lb1
         gMsd8fPrBg0ZpXJrat3hwnNNXTJbT2tNDubpz2K+Lrxrsf5UTU3aWNQmjbwNzox+QOc1
         d0AjAsE5wCuDiInH7TjFEWM+Gt3Q00n1Xzwu/VYo1Gd8iFD241L15gtSIJ1p5pYDMQ9G
         9sqw==
X-Gm-Message-State: AOAM532fCESLbmfwWwphM/4ccoyMPD8FGiT4E8FA58gKR1eL6BKoP6Xe
        hb+rnQMZZ8PR/maKafbxqGgxViXsVKByLLw4ug45B6h2qwAnfg==
X-Google-Smtp-Source: ABdhPJxzX0GLAnOuuJJExDWn8gQhOKKGEfPYzRDgP1cLNVfLdZLqPN822OdmQ+l0RaNllCTFEOpqlmf1qy4OnnMQo7k=
X-Received: by 2002:a81:4f0c:0:b0:2f8:46f4:be90 with SMTP id
 d12-20020a814f0c000000b002f846f4be90mr8499069ywb.332.1651421654428; Sun, 01
 May 2022 09:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000045dc96059f4d7b02@google.com> <000000000000f75af905d3ba0716@google.com>
 <c389e47f-8f82-fd62-8c1d-d9481d2f71ff@I-love.SAKURA.ne.jp>
 <b0f99499-fb6a-b9ec-7bd3-f535f11a885d@I-love.SAKURA.ne.jp>
 <5f90c2b8-283e-6ca5-65f9-3ea96df00984@I-love.SAKURA.ne.jp> <f8ae5dcd-a5ed-2d8b-dd7a-08385e9c3675@I-love.SAKURA.ne.jp>
In-Reply-To: <f8ae5dcd-a5ed-2d8b-dd7a-08385e9c3675@I-love.SAKURA.ne.jp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 1 May 2022 09:14:02 -0700
Message-ID: <CANn89iJukWcN9-fwk4HEH-StAjnTVJ34UiMsrN=mdRbwVpo8AA@mail.gmail.com>
Subject: Re: [PATCH] net: rds: acquire refcount on TCP sockets
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 1, 2022 at 8:29 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting use-after-free read in tcp_retransmit_timer() [1],
> for TCP socket used by RDS is accessing sock_net() without acquiring a
> refcount on net namespace. Since TCP's retransmission can happen after
> a process which created net namespace terminated, we need to explicitly
> acquire a refcount.
>

Please add a Fixes: tag

> Link: https://syzkaller.appspot.com/bug?extid=694120e1002c117747ed [1]
> Reported-by: syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+694120e1002c117747ed@syzkaller.appspotmail.com>
> ---
>  net/rds/tcp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 5327d130c4b5..8015d2695784 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -493,6 +493,15 @@ void rds_tcp_tune(struct socket *sock)
>         struct net *net = sock_net(sk);
>         struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
>
> +       /* TCP timer functions might access net namespace even after
> +        * a process which created this net namespace terminated.
> +        */

Please move this after the lock_sock(sk) [1], so that we are protected
correctly ?

> +       if (!sk->sk_net_refcnt) {
> +               sk->sk_net_refcnt = 1;
> +               get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> +               sock_inuse_add(net, 1);
> +       }
> +
>         tcp_sock_set_nodelay(sock->sk);

>         lock_sock(sk);

[1] Here.

>         if (rtn->sndbuf_size > 0) {
> --
> 2.34.1
>
