Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640654218F2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 23:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJDVHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhJDVHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 17:07:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B7C061745
        for <linux-rdma@vger.kernel.org>; Mon,  4 Oct 2021 14:05:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b8so35466308edk.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 Oct 2021 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjuNLJAD6uk9v9mkArdSBNFR1WdGNRI2gcPkUZfGClI=;
        b=VW47hnup9J2ZHml2Kayio1niVc5rIsKpGvxKlGZzMubOPe6PSrMv4M65xnMbl01ctU
         OBNiniygcRa8Roz55QGs+9o+eILc5A4aFwUIodzznLaKK0qRzPTnXu1rhgcN9HpyQhFT
         mTahukLcKLzWAjDgF8djiTqsPwmKozrxBBqFW/OMxdrr8jLwsF6pRZcM2htgbju8leIP
         /1h/hPyR6YXABnT99nhzruMLLLRBR7GKoIzHeIE0/8Q/4sJ496VP51NDBn1EQ8T/Nssx
         JNWwz8ljihTwN219fOjMEhfkrmbef41t4SUK1B4z0evqAt6W/JF8bxvH6GMf3FFBqP9Y
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjuNLJAD6uk9v9mkArdSBNFR1WdGNRI2gcPkUZfGClI=;
        b=HgZDAxgI6MtbF244ybuSDuNbJ3wYlHe1TzOoNobtKF4qTaqhHdW4tIS19eWBxrE0qe
         u6Ehuk6HFfinYLL14b/8wTpO4lZvyo2zTioSBO7HdQJ027MUs2UJL8FIW9g+wgWE7OJx
         w9Vy2/WFruv9NKkje1j0sV22AlbXAscCa718MyLSwxZv4b0UzJ9msyLizXAgiuodhBwH
         nCpVi7LbScKl2ufmgHjBH/5UrCyEiZQ3sb7Q9OmTIqdZ48l+Qhrzu+1qqBFg65C8G87G
         DFdauyCaOG6CCg2o6aFAd2sNdc9+Of7SQDrz7Iompozy/Mzk7OEtLp/kaYM5pk93qx7u
         ns9g==
X-Gm-Message-State: AOAM532YUBYX8haKWZE29f7Rmwwq55i33biXS7/1s5GygERNvTiZyE2d
        azdTiARwvZnrCPja9A/P/UXJQJwMDxvm4CGPPsDIfg==
X-Google-Smtp-Source: ABdhPJyPG+rC7IzPuc+uKKJ8haIjtIRfNpHYsN+Fm954hYRQur5M2aerlnUkzr+OW8P6iNRiPjyM2yZfWFvSNw9ApCc=
X-Received: by 2002:aa7:c952:: with SMTP id h18mr21418445edt.18.1633381529791;
 Mon, 04 Oct 2021 14:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <YVLEIVz1mCV0cZlC@unreal> <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal> <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal> <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
 <YVVtAFtOj0mPzSAR@unreal> <CAMGffEmYObHjk1Fk6jZqBnUPCE5o9=EpHHYqvevA8kKLjQG6aQ@mail.gmail.com>
 <YVchqF1oHf903+lk@unreal> <CAMGffEk4PJGkL3fufgKGUCmKDUqYOTFgKPisda0OeMN1hTk-iA@mail.gmail.com>
 <20211004184718.GD3544071@ziepe.ca>
In-Reply-To: <20211004184718.GD3544071@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 4 Oct 2021 23:05:19 +0200
Message-ID: <CAMGffEmYEM=R6enfhy0oRx9MzomFN_HWZzmSKnv-pnSu-aKseg@mail.gmail.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 4, 2021 at 8:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Oct 04, 2021 at 07:41:08AM +0200, Jinpu Wang wrote:
> > Sorry, I'm really not convinced, why should we only do allowing, not
> > disabling in this case?
> >
> > Jason, what's your suggestion?
>
> At least from a correctness perspective only the characters / and \0
> are forbidden, as well as any existing filenames like . and ..
>
> Generally it is not a great idea to restrict things too much because
> it can block the full use of UTF-8 for non-English languages.
>
> However, I also think the sysfs in this driver is far too elaborate,
> the time to complain was before this was all merged
> unfortunately. Given that it is a simple enough bug fix it may as well
> go ahead as-is.
>
> Jason

Thanks Jason and Leon.
