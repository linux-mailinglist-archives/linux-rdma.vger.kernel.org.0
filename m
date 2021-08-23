Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3060C3F4C3B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHWOUR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 10:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhHWOUQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 10:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 122C6613D2
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629728374;
        bh=2rlmwEiB32Y5Je+PnppRifwGHLngBQvzeIS6AEiCeG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DGyWggwA2hQpjEasmoO+9ZlDnRZ9fZZ5yvfKE16l9gu98MbKbkh6jtVpyWw+UT4c0
         UnRZ86RRdV+jUThNy43vIrlqWj5Uxw/h/casgUp9KpLj1VMPuUuTmUTbMF1mgVWJF7
         JSZseGTz3rk3rzn1D+/p2Zk7yCg3I/Q7t3bPWvCEYwXtHuagLEEbvfHtesRI9r2VJV
         QKP87tv3E9Uj2E+lnlzPNSWXhRX/yGmY8ecOJiwbVeuRojJea11r1QEGxG1eIok+qV
         oQsTm03NDekOuj6GeP35IeS6UlKtQWKjIwl3UiKUjdQtacyWk71Fx7ZYhy+f7LkhhB
         t4wDKmISfYMMA==
Received: by mail-ot1-f49.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so36661963otk.9
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 07:19:34 -0700 (PDT)
X-Gm-Message-State: AOAM532so2iCxfqeCT0rvmIkLx3VdqTKj4gabp8yUcuJOw4iml3/dDEi
        G2WXb4CETDY7+K6Wg5iSsXarlVKeVuaN/U2EA2I=
X-Google-Smtp-Source: ABdhPJy+yG9TzbEVbFPHMKowMXGNUZA/cXf7gm3cYMzAzcV6HJOyF4U1bTp/r+SR84F5jIxjegSujQizKtWYqFRDWoA=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr14574780otn.143.1629728373488;
 Mon, 23 Aug 2021 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca> <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca>
In-Reply-To: <20210823130419.GA543798@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 23 Aug 2021 17:19:06 +0300
X-Gmail-Original-Message-ID: <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
Message-ID: <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
Subject: Re: Creating new RDMA driver for habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 4:04 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Aug 23, 2021 at 11:53:48AM +0300, Oded Gabbay wrote:
>
> > Do you see any issue with that ?
>
> It should work out, without a netdev you have to be more careful about
> addressing and can't really use the IP addressing modes. But you'd
> have a singular hardwired roce gid in this case and act more like an
> IB device than a roce device.
>
> Where you might start to run into trouble is you probably want to put
> all these ports under a single struct ib_device and we've been moving
> away from having significant per-port differences. But I suspect it
> can still work out.
>
> Jason

ok, thanks for all the info.
I will go look at the efa driver.

Thanks,
Oded
