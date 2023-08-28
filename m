Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8D78AFD2
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Aug 2023 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjH1MPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Aug 2023 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjH1MPd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Aug 2023 08:15:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A69D8;
        Mon, 28 Aug 2023 05:15:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8475964a12.1;
        Mon, 28 Aug 2023 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693224928; x=1693829728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n6GwFDOr+hzOGHtIK05YvBf8UtxquAjCgB7KwctWkU=;
        b=FB56Pgy43qSiXWeEsZlec1LU64H/wQZ+tBbXmBoK/TbDpjeAhm9+1x91U7YWSTq08r
         NN+CQpeSzAUdmDcPbSWNiM+2tNJ1wQ+MzNlNa1ktdQ93UmVA+pxhTqCh5QeMJk0G9WOd
         EGXqAT1y3tEpxZj3lrdGQjyeAVcQowITHY1W0f7Xru9VaxNkbGtrxF8LA5uNfDdlj8V5
         NpdbmAjL2jm3I1QeuQFlyaYJWW3djluVU6XP0ogFoG9NYWY78O1Njz5xgi8EstDEmBGy
         /l5BuGp6kZnkFFfbURtflSdZmT8KR7Z8eCU+RK2dJlAE9OyrK8JWKIVyHeUaHzwSCICx
         KRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224928; x=1693829728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n6GwFDOr+hzOGHtIK05YvBf8UtxquAjCgB7KwctWkU=;
        b=KGEmbrQozI77t3P3QJqZvvlHkXppD7RVMFGpT0uUMLQ/GyZrbsVeytulcp9sU9NTxn
         IDHTL3JoeYKKcxQteC/2YmLUrJc28VuqHFfQGMqhyOCVQ/z59zR7TLKKpjBT/PcWRV5N
         pfLYGJsa5iSYROlc6zdzCoEHJZKWEw563oPMbmZ39+L46+M7ynUE4Yi0+hCQoFkopI2o
         dzkEE6+q+wILYMd5z+9BTREUc5B6hLGa6OjZ3i78gwtOsAbaAZfcqH3cd0XPpKzHISa0
         n4XatgSKiY/720ZaTHoBiiG+n/S4ZBvWV9hGvF+P1fubv69N3tvLETVbYQOwSYLGJYny
         AGng==
X-Gm-Message-State: AOJu0Yzaoc1ovTnDlzI8XjKHAD2aE9CfJ8irABwg7ylnLST2HPkgXsG+
        OwtLFMkQKdQAFHQEI3Aub5YILUQ919r5dQ30B2K88TV2Xbo=
X-Google-Smtp-Source: AGHT+IFHS8hbsnfoi+9GwbHqwxNQFWN6JrX4VyytnlSe9RJzo1AgaEsVAuW4S0H7pjLCuYkMVUDys4QYDc7P5qHHuZo=
X-Received: by 2002:a17:907:6eab:b0:9a1:e5bf:c907 with SMTP id
 sh43-20020a1709076eab00b009a1e5bfc907mr14462671ejc.2.1693224928155; Mon, 28
 Aug 2023 05:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <f3f30d46-379a-8730-5797-400a77db61c3@linux.dev> <87r0nnczp7.fsf@jogness.linutronix.de>
 <CAD=hENcu4wKELCt61O+p-RtOpaHHoaAQhr7Ygt9pdr9Hc4s2Wg@mail.gmail.com> <87fs43cudc.fsf@jogness.linutronix.de>
In-Reply-To: <87fs43cudc.fsf@jogness.linutronix.de>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 28 Aug 2023 20:15:15 +0800
Message-ID: <CAD=hENdkUaFQTKAskbYo72tsXUD5CXht-oMMn_ye3F1S6HHj9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Very helpful. Thanks a lot for your explanation.

Zhu Yanjun

On Mon, Aug 28, 2023 at 6:51=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2023-08-28, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > Do you mean "a newline can help flushing messages out"?
> > That is, in printk, the message will be buffered until it is full or
> > it meets a newline?
>
> Correct. A trailing newline is needed for the record to become
> "finalized". Only finalized records are pushed out to consoles.
>
> If there is no trailing newline, the message will be buffered until
> printk is called using a message with a trailing newline.
>
> There are some other reasons why it may be flushed. But for sure the
> flushing will be delayed if there is no trailing newline.
>
> John Ogness
