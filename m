Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1508318DD87
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2020 02:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCUBru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 21:47:50 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42135 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCUBrt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 21:47:49 -0400
Received: by mail-ed1-f44.google.com with SMTP id b21so9411789edy.9
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67NdMEH1N4z7XhO0UQmaT7LMAE4ult8205LWqZGdKaM=;
        b=hvlij6GvhUt9NCDDv84YKzI7edMW9os1AdHfC04aw1OnTpqSyWDBxFS9ZkDSAuIZfm
         XHbTWqKx4kHHrHX/IUq2LdA4F7he7rKg+8U36v/DQo8s/MR1Vv2Ur7jIjFT4Pyu/tyEY
         pvQXSOPx301PiSAlA+ahUUMOCvvDgM/HhTXg0kcsuW9t8jX+4sCCAY8B6nB5syntZreY
         JmrkveqqQ2uLTLRUHrFty6oaT3MvU4D8cOTQP77tOa7w3y/mQV8kiAp200bjhpfAiGyF
         zwNIk7WIbo1SGskYMyKqPAvOhoccTMSxyxOKkAvt9/edbBEbFvyL+1GT4P6CwxhigIux
         7Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67NdMEH1N4z7XhO0UQmaT7LMAE4ult8205LWqZGdKaM=;
        b=Kpa8EZguXRA9Lm7UvfhxJ+oc6TTwX/IxoS1lYCV1F7M/1AXGkNfIIf5/YJ+xoT9HQ0
         IEKtOx+lwEqvn3Wcij/fbvElGj7aqDiKRT5/0XWSIR1dtESkp6OzZ/lb7Wr3nGS8V0z0
         TvB/jBe2SZ7ZWGVkhPkZPYOisja8KoiiYpNv2KTaHdMgWdCnPJBS6A44HgS9j/jxftx/
         k/L1PZf55NNl64DsTGD0HuWOF4QUZ/QkX186K33NzzKubkAiRRT49Zc+ZiRi3exuPC1O
         JUWOf35atuHYohostz9IhDMAyj2vYbpEA5FZrO4/IzL8ZKxrJe40WW2lTref6p1+7Rn4
         NZOA==
X-Gm-Message-State: ANhLgQ3fEWIiNE/yJ43Cv7+SaVkPP6KyHlJNYjgv4jyEJ9WQ3yHBNf6L
        36S4PUjmm9QDCAKPiQiwIkLpfMH6QCqhug1B6mE3XQ==
X-Google-Smtp-Source: ADFU+vtMeoCd0IsGeTvd13o637BpMUcv2lMwjXcB9gi6CkYQuP+OrD8xDKQXbbXmZLljw0nnsrBgFzjnQyn0Gf+ojeg=
X-Received: by 2002:a50:9ae4:: with SMTP id p91mr10809001edb.114.1584755267204;
 Fri, 20 Mar 2020 18:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com> <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
 <8c2c8049-af47-e8b0-3b63-c179f16908ed@mellanox.com>
In-Reply-To: <8c2c8049-af47-e8b0-3b63-c179f16908ed@mellanox.com>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Fri, 20 Mar 2020 18:47:36 -0700
Message-ID: <CAOc41xFUqmtKZXmwyaOmYQHGQ+PxJqGUY=1urDuV2GoeCDL3JA@mail.gmail.com>
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Mark Bloch <markb@mellanox.com>
Cc:     Terry Toole <toole@photodiagnostic.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Mark. We haven't been using DPDK. We're using IB verbs, but
we've had difficulty reaching these with UDP, even though with UC it's
been straightforward.

Dimitris

On Fri, Mar 20, 2020 at 9:05 AM Mark Bloch <markb@mellanox.com> wrote:
>
> Hey Dimitris,
>
> On 3/20/2020 08:40, Dimitris Dimitropoulos wrote:
> > Hi Mark,
> >
> > Just a clarification: when you say reach line rates speeds, you mean
> > with no packet drops ?
>
> Yep* you can have a look at the following PDF for some numbers:
> https://fast.dpdk.org/doc/perf/DPDK_19_08_Mellanox_NIC_performance_report.pdf
>
> *I just want to point out that in the real world (as opposed to the tests/applications used during the measurements
> inside the PDF) usually there is a lot more processing inside the application itself which can
> make it harder to handle large number of packets and still saturate the wire.
> Once you take into account packet sizes, MTU, servers configuration/hardware etc it can get a bit tricky
> but not impossible.
>
> Just to add that currently we have support and ability to insert millions for flow steering rules with very
> high update rate, but you have to use the DV APIs to achieve that:
> https://github.com/linux-rdma/rdma-core/blob/master/providers/mlx5/man/mlx5dv_dr_flow.3.md
>
> Mark
>
> >
> > Thanks
> > Dimitris
> >
> > On Tue, Mar 17, 2020 at 4:40 PM Mark Bloch <markb@mellanox.com> wrote:
> >> If you would like to have a look at a highly optimized datapath from userspace:
> >> https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c
> >>
> >> With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs
> >>
> >> Mark
