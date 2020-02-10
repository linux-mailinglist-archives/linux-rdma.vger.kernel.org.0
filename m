Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75E158186
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 18:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBJRib (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 12:38:31 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:43644 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgBJRib (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Feb 2020 12:38:31 -0500
Received: by mail-ed1-f48.google.com with SMTP id dc19so1279774edb.10
        for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2020 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPw7biNM9ylFX2K0uo7nJPFukNe3lp+4qWC2kQZ5BeQ=;
        b=q/PfBLVqINr5a00qYE2xgTXZ7G13QmM1E7okdgDBCLNZuvzV57FQAnwHpTXVOrDdCs
         pV3xyiq0cgc+kCCQDT12NsJRW2N5lT6V93FTTmIIZXc0m7mZiPEP4dDLIKBaMOpRevWV
         tWngyahdXGfUz7rfJ/2eXi8BAEmzPfAIU5E7tBkmfqjW9t4X+dXo0511UNJ2zJpFolRk
         WaFws+SfPMkgl9A9fEyOK1xeZFSy1xklsW3xCCHWhwwqxL/qEJ69LPEb1jqwALlFIqTY
         Ontxg5wsdxqPf6IRmOVKkYzcUmu2kF5XKf6K72mc4jzojC212vnTwzf1hAnyJ58yFQJo
         RHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPw7biNM9ylFX2K0uo7nJPFukNe3lp+4qWC2kQZ5BeQ=;
        b=MXTq3LuY88Wsbj/7vvgIqyLalcbW2dHBADysyEiOsk5WOPXVWcHCud9UiON7zkaaFs
         mQaQCvFkcePd8M0032Gm9iuOZJTSu8LwGhWoqbCJRwGDbPUq/lOfMzRj5Z8QEhHADBDy
         QmeuWN6gyQxRdoK79hgPKytw4H/x3/NLZ8Xeg+1QIn1ya5uHmLHUlR5H2eunUFQY4a5X
         coBjodSGFxuHIK/6AOfg2V2ktyUe74eypeQs6guGg+HAAlraTflZZ4VETYPeBXhRaS1g
         ldf9RywwY7fItpMXPwBdcVoqAWaW1xHl6v1NVm2Iq9JNh/8mxTFyt0qnvKCacIB0Z+de
         CSbQ==
X-Gm-Message-State: APjAAAXojlZ2t1BP7HyfOIPk9TgyBccK2BqboJQlAnndohQsesa+7CmV
        7aYNFHJDXCE9QHdabaer8ZshS6FNZGukbh7X1/NHFg==
X-Google-Smtp-Source: APXvYqwzv+txfNkBWDPSgwk8ru9B5Iwlfm0C6rkXhD1aa2C1x9vKMyzQiFTuGpWKfxyiZE1Phi/jh5mGavVtyaKdPIo=
X-Received: by 2002:a17:906:4a03:: with SMTP id w3mr2212814eju.263.1581356305878;
 Mon, 10 Feb 2020 09:38:25 -0800 (PST)
MIME-Version: 1.0
References: <CAOc41xHpF5VXK_-L_BeaU9v842BuRd2QTXkZunDKDgiEhixFtg@mail.gmail.com>
 <20200209145736.GG13557@unreal>
In-Reply-To: <20200209145736.GG13557@unreal>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Mon, 10 Feb 2020 09:38:13 -0800
Message-ID: <CAOc41xFkdgwt38e6TAh=E2wWXsdTHBKaOphSx3OG5DwK8xErxA@mail.gmail.com>
Subject: Re: maximum QP size
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you, there is a wealth of information with the "-v" switch. For
the Mellanox Connect-5 that I'm using I see:

max_cq:                         16777216
max_cqe:                        4194303

I'm encountering a smaller limit on the maximum entries, so I presume
this is the max total number of cqe for all queues in the system.

Regards
Dimitris

> > Hi,
> >
> > I'm running the ibv_rc_pingpong example and I notice as as rx-depth
> > increases the QP create fails, eg at 50k. My understanding is this
> > variable controls the number of RECV WR that will be posted in advance
> > before SEND WRs are posted.
> >
> > Is there a limitation on the queue size (the size is unit32_t) and if
> > so why ? Also is there a way around it ?
>
> The rx-depth is translated to the size of completion queue buffer.
> That buffer used by hardware to post completions - writing completion
> queue elements (CQEs) and it is allocated when creating the CQ.
>
> Maximum number of CQEs can be retrieved by the ibv_devinfo -v, see max_cqe field.
