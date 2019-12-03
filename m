Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB8111B22
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 22:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLCVsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 16:48:19 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:34848 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfLCVsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 16:48:19 -0500
Received: by mail-il1-f176.google.com with SMTP id g12so4672602ild.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2019 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A19Pw1tPp8I9RS7X7QtpXVPnH3dxB18y6JWRMvT2H0I=;
        b=Q80hv9FrTfDUYvLUwk50duOP4ClHw4BBgIwwUEdXiKeGQhVQdDOEqa7NJAXoIaVjF2
         dnCdiuI+Bq6yQPK3K854baeJ7twoZ+qdSJ0K1EL+rfmj61GMG+jejevQm/v4r9caEkXd
         lUNRwYZ5fvjvT3NT8qVOkSZiJ1L9vAXYflLHlC0UtlT8xZnZ2n8QaG3v3S+gJ6pG99jL
         nrEztCsoqlC0BMXr1WwmOODxYfyUJ+u28JqK+H2055PQg9ao1qyht10ywC/zSOJ/anqc
         aRXp0BsdgvGBe2/O7baXZG1tGBglLn03iVxndMAvMNboGmEZI80J4ovofMx03WZqXKS7
         oWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A19Pw1tPp8I9RS7X7QtpXVPnH3dxB18y6JWRMvT2H0I=;
        b=XKBrOBBkwQb0L1joZeDLO1KyLtKNg88cZt9r2C7tivjfSoFg3cmRSxyekalFAQiSIK
         wH8iNjzFhF/PJ64Pz4e51OG5aXceyDyaSBLaQoJICPrlmrBC7NnwSWcpVNYcg0pNDNKJ
         5NfDpOhz3r/Maa/0HJk37yCOxRulj+vkoUP9P8DMBGFMz/2KENNUlZE+iKzpzwird41W
         yH+G9bK5/J+0YTfzm2a8qMFhe82khclRVhbKMDnI6YwtJVgFHgUMb6JdLnds39QAfWie
         uCFO5m0ao43bYJjJAC0q4XR/75SUvjifal6AVToYms+iEFvL0wN1XAfVmUwnpAh87bc7
         NgDw==
X-Gm-Message-State: APjAAAU09PO3rgeHg2PloE2BkNkyuTrmW5ZJbdjc6kveblUYVEPEen76
        R1ZjZXfdbnlvy0QbeH4KclIkrHUj82BPCj5hnss=
X-Google-Smtp-Source: APXvYqwTexLsXgmadsKlG88UQMpu8s/UKBlZJkwve6En6jW9tO/P16uB5ZX6gmE+ZZWjZQCFtxisioNFCXZ/Jc+USGE=
X-Received: by 2002:a92:3a58:: with SMTP id h85mr306689ila.245.1575409698140;
 Tue, 03 Dec 2019 13:48:18 -0800 (PST)
MIME-Version: 1.0
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
 <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org> <20191127111008.GC10331@unreal>
 <CADmRdJfEr405W1+m=jYDYV=MZtk_0mEamUA7UXt6rKangnAC1g@mail.gmail.com>
 <8e8d9ecc-9406-11b3-242b-3a84f3702f79@acm.org> <CADmRdJcQV3hOObZXSQMgJynmFyeWietWb2gffo3T0o5NBPOfNQ@mail.gmail.com>
In-Reply-To: <CADmRdJcQV3hOObZXSQMgJynmFyeWietWb2gffo3T0o5NBPOfNQ@mail.gmail.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Tue, 3 Dec 2019 15:48:07 -0600
Message-ID: <CADmRdJcCFYqQ4+gu2yf+UA=m5B4ER8ZJxgb_ebbFTfBi=-4tmQ@mail.gmail.com>
Subject: Re: [question]can hard roce and soft roce communicate with each other?
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>, wangqi <3100102071@zju.edu.cn>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 2, 2019 at 7:57 PM Steve Wise <larrystevenwise@gmail.com> wrote:
>
> Hey Bart,
>
> Well, as long as every implementation supports proper iCRC and RoCE
> standards, I don't see how there could be a problem...
>
> Let me send my patch out now...
>
>
> On Mon, Dec 2, 2019 at 6:57 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 11/27/19 6:24 AM, Steve Wise wrote:
> > > I've recently uncovered a bug in RXE that causes iCRC errors when
> > > running between RXE and a correct RoCE implementation.  The bug is
> > > that RXE is not including pad bytes in its iCRC calculations.  So if
> > > the application payload is not 4B aligned then you'll hit this bug.
> > > You can see this by running ib_write_bw, for example, between mlnx_ib
> > > and rxe.
> > >
> > > works:  ib_write_bw -s 32 -n 5
> > > fails: ib_write_bw -s 33 -n 5
> > >
> > > I'll post a patch this coming weekend hopefully.
> >   Hi Steve,
> >
> > Will that patch support coexistence of softRoCE implementations that use
> > different CRC calculation methods?
> >
> > Thanks,
> >
> > Bart.

In case anyone missed it, I posted my fix for unaligned payloads:

https://www.spinics.net/lists/linux-rdma/msg86758.html

Steve.
