Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7E735D78
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjFSS3Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFSS3Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 14:29:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC34137
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 11:29:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76300f4d7eeso110098485a.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687199363; x=1689791363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2srzci4Ajc4qNXSDpnKuPvoH+6k2As0TgkUfoMG4fYs=;
        b=C7mbYlmSUcv/2SOnmIL/j9r+2/KLMWYpzxJrrwzFifLVBw2iACIQGuQZBO5BA1bNnN
         Hzk1CNTrz2uEnQ7KsmhwA3GdVq+/WPBPhVKahjWbLi5H8EtM7O++kVzXCPoNShsl/O1d
         rGlZnJtszbMdW0hnjBBHBE6oH54YfiMREqZYgy9SVzTsSvQ14t9KJ8DjKLmPsbncYgQ7
         A7yUSHbUD9RaEVifA24kZzWzbSZsjqOGnAKxsO/HNCRd1SoySO/9NNh6B/G6v44n09c5
         5Ud0JpykRnuFonH3CmJmxu4IDCOy8LfyJt8e+8dfPksUGLcAFBInzwLvkiwb1KMw9rW7
         2+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687199363; x=1689791363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2srzci4Ajc4qNXSDpnKuPvoH+6k2As0TgkUfoMG4fYs=;
        b=dGSL8oVIgmspitn4HFRqP5VWoiMo3zo+YgBOzW4RNtPPX3xr1zcPuWSiRbt+yDsZfK
         ie2BS6dYTXxO6Qod2Ax177JvlaGdGtRThm6HGngrGLM0ucA3kT1u4NF9UEM1lF76Jx8m
         zvA6vg0YFoprGCQpmEjFmtEJnIrTPsHukNlhpbBmGw5WFVhnT4UzZFCyX6JcZh3DOsMK
         LyoIwczDG9AkJ8AcCOjLYMwx81TKxRb2pS+Q9ARp/J/qEtFhI5lu/Fkkp3+5DUeK+/t2
         kXp8Ft2zDKHD+InZ7v+J9XNf1sCVBNn5a5v0oS5vGe47KK7nmjFOAFjyHx0MCnXRXaV8
         AiVA==
X-Gm-Message-State: AC+VfDwgwxh7c1SnSm0dBym8KgQ2V0gjKgDIRBGlI9XKaqqneBxWB0TP
        Y/osKkDZjIfd6FGv7ZCjb+KAI08PAR09qMYAOpM=
X-Google-Smtp-Source: ACHHUZ69JavB7h0IolWLlW6mq4pJdIZ0hV/eCwB2ScqAs5R2GTFtoLiMnMTIfEAj2nLori2NpDWTEQ==
X-Received: by 2002:a05:620a:3e09:b0:763:97a8:b958 with SMTP id tt9-20020a05620a3e0900b0076397a8b958mr2721987qkn.39.1687199363279;
        Mon, 19 Jun 2023 11:29:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a152800b00762f37b206dsm189997qkk.81.2023.06.19.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 11:29:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qBJcv-007DrH-Vo;
        Mon, 19 Jun 2023 15:29:21 -0300
Date:   Mon, 19 Jun 2023 15:29:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Subject: Re: [syzbot] [rdma?] general protection fault in rxe_completer
Message-ID: <ZJCegWuC8i6n3WA3@ziepe.ca>
References: <00000000000012d89205fe7cfe00@google.com>
 <d66248b3-646a-a25c-92c2-f182cf910b21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66248b3-646a-a25c-92c2-f182cf910b21@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 19, 2023 at 11:47:57AM -0500, Bob Pearson wrote:

> There is a fairly obvious error in create_qp error path code. The
> seg fault occurs in flush_send_queue() in rxe_comp.c. However, the
> cleanup routine which got here was called after rxe_create_qp()
> failed the call to rxe_qp_from_init(). That routine attempts to
> cleanup qp resources if it fails so the send queue will be either
> not yet be created or cleaned up before it returns. Then referencing
> the send queue in flush_send_queue() will seg fault. The top level
> qp cleanup code needs to handle this case correctly.  I will give it
> a try. Not sure what they were doing to cause create_qp to fail but
> it's a bug. Is there a way to get them to re-run it or will it
> happen as a matter of course?

Without a syzkaller reproducer you have to fix it by inspection, make
a patch that is really logically sound, then push it as a
fixes/reported-by. If it doesn't fix it then we will still get pings
on it.

Jason
