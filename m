Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4143428DD45
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgJNJXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgJNJWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Oct 2020 05:22:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6CCC02524F
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 17:39:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so1446798oie.4
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcUhqi1j/8T6qszOgS2y+lOtAlVETZnS+k14R+nuEbQ=;
        b=IIea5AELF6NOshMrBPP2k9vr9mybIvxNO7+kV+oDJj+JbsDvlfPfC0cZLOSr+b2IZD
         3ZUfq/2uBNLWpKDeHPtQI1BeLWvlXoh2Ss8JrZi8bv+GA4gKmS7lk0VX1Ujp7pLDsWow
         u+kIamcIrsW2u21fM0AqJ8IaovUFR6YgvXkrYxcG5D8dtbr2qCD9XkxqF+5EwRaqcE2O
         EU9s88h2ssCsax6qRuBnEj35C56ei+6RYoRxeNSa4DjBQtJ+9bL3ciIhxfi1CSdNDVMq
         D4nr6PhEl1/RFaJem/puQxu6C+pv9qHmZFl8hWOTpJjoQCrRjOrtyFsHMoY9qxdvyfpn
         FuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcUhqi1j/8T6qszOgS2y+lOtAlVETZnS+k14R+nuEbQ=;
        b=WrNbvprEZEcZGczNHbKpiv9rIvEQLNIsJHmCf4gykDiWrsEKfjOJ57Pdv7/OgkbcuZ
         MLCwPzJy80JrZphC4DqGizpmPurqJjylJlcrpyUflDjG3h4GN+Qz+mIr6GuRYzbnVMK7
         FVk4/eL1LCJVlutCe1sc4z/EBEIUJ0MrMtt08rHJ/dYC4VXkH9muvAkQspQF4tD4qfxz
         1ytab89qoWaPv8RqujZTr2KYrcK1QqF+2g6zxpbuqwfoECEgq6yVdAMvKAC/fO7Fnryx
         ki9Lgsp8/0krVhjFQ40gZkHNaWyvCMZ5H30KUMiqfTXzU+MHsuuQB/X0iG07/tSO1YNV
         iGPQ==
X-Gm-Message-State: AOAM530Ks6EbKZSPb3zh620qKWZef8GcpdBrvmtgn+G2dPOA2+NqbLVb
        iMLq+cKCtnWRJA0UnhmfuvufaQPmAp6vPKuCBQs=
X-Google-Smtp-Source: ABdhPJzcu/3qeIcwOZUWzr/EzEEE0oAtCmOEDtEUwbZKw42ok0LBzgTZ0fL2okyCEtTKNP3hxnIYCjLJ0Wj0dwC83R8=
X-Received: by 2002:aca:fc89:: with SMTP id a131mr602083oii.163.1602635997197;
 Tue, 13 Oct 2020 17:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201013184236.5231-1-rpearson@hpe.com>
In-Reply-To: <20201013184236.5231-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 14 Oct 2020 08:39:46 +0800
Message-ID: <CAD=hENfGR=nLqZNON0=whxDFooG5E+Eq-ggDjrvN+6M+3F7G7w@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe - Respond to skb_clone failure in rxe_recv.c
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 14, 2020 at 2:44 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> If skb_clone is unable to allocate memory for a new
> sk_buff this is not detected by the current code.
>
> Check for a NULL return and continue. This is similar to
> other errors in this loop over QPs attached to the multicast address
> and consistent with the unreliable UD transport.
>
> Fixes: e7ec96fc7932f ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")

Addresses-Coverity-ID: 1497804: Null pointer dereferences (NULL_RETURNS)

Thanks
Zhu Yanjun

> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 11f3daf20768..c9984a28eecc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -271,6 +271,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>                 else
>                         per_qp_skb = skb;
>
> +               if (unlikely(!per_qp_skb))
> +                       continue;
> +
>                 per_qp_pkt = SKB_TO_PKT(per_qp_skb);
>                 per_qp_pkt->qp = qp;
>                 rxe_add_ref(qp);
> --
> 2.25.1
>
