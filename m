Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22134396E96
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhFAINC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhFAINC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 04:13:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A45C061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 01:11:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso6445577otu.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylosZ8VNMw9a6i7zWSWtxN5LZb1PYmn9UpzuWpY9QHE=;
        b=ZIj3jVY91OGeJWKSoY31QrIZAdjbmCq58hbWejbdtly6kXxEck6oeOYEbqvB7/jk/b
         OZiqGW+RNCqTxe4ZLN+IMSvCtnTmwAukYS7PDcsFKsN3H1m4IGqrMcwuZXDjlu3EB9wY
         OuhZz9wOhK2tliK+Wv9ZDL6NrHNLUc4r4k8NQ93fsyA6q+nNi4TvRvfFeJeJM47SvidI
         gAaZDiO+P2FHReClJrkqW2Iz75g0t+OeLFdv+IcTkjB9Uv9U2uZc5aHSoxYL9vUn5Y1Q
         yH8OtrC5SvxMz72BO5JHJ6GDJdD1rZAPDxeQV+NN+kum2GxzbURV7pa0EB9si5NdPg5s
         yXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylosZ8VNMw9a6i7zWSWtxN5LZb1PYmn9UpzuWpY9QHE=;
        b=RjwLw1Ku8z5D3PgRDHsYU5/KD6kxNpzNU4Q4WEKQ2EqpGo2LpvfGWW9qcVjxkSne0f
         g9jNkBlhRDWVkykbGPhzValOHktSZYAcO46DY5I0gNkBAHHjDFf7vbk9rOJJvacUKXL9
         Qa11Un0nXjqAWmrryoY2n4/TbIVLYVFJ2BiOZcA1fPZjxqu75OHWhY1vw1aX940LW/bt
         kRnlnAQe9aL096GCit5kf7vPjeIFQDEwNt68S+6od2wMLK4//ouDIT5P6fzl/MR6MmhH
         TDWPpesSvkwSoHb4hmCZEX63NIaW2T5wNwFBashDODw87SQKYPGMFYFko0jzVdZO++Zw
         zvlg==
X-Gm-Message-State: AOAM530m/AygyjkrnBXMXrs5vZfruET3QrphbikP7VKvMWtBgU/nKpaJ
        9fhc2En2By7eGbUL092cxduWlG92No4/qZKRlDE=
X-Google-Smtp-Source: ABdhPJwqa2aIwpNaAyxfJzDW/uDy2svigckp0zoNiPRWnc5wdJQIyW9RRYIg1i/7Ts+qJYoMPoQwF8zDNp7ZXxx2gmM=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr10967400otf.278.1622535079560;
 Tue, 01 Jun 2021 01:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
In-Reply-To: <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 1 Jun 2021 16:11:08 +0800
Message-ID: <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
To:     kamal heib <kamalheib1@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
>
>
>
> > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > =EF=BB=BFOn Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.co=
m> wrote:
> >>
> >> To avoid the following failure when trying to load the rdma_rxe module
> >> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
> >> before trying to create the IPv6 UDP tunnel.
> >>
> >> $ modprobe rdma_rxe
> >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> >
> > About this problem, this link:
> > https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12=
209-1-yanjun.zhu@intel.com/
> > also tries to solve ipv6 problem.
> >
> > Zhu Yanjun
> >
>
> Yes, but this patch is fixing the problem more cleanly and I=E2=80=99ve t=
ested it.
>
> Could you please review and ACK this patch?

https://www.spinics.net/lists/linux-rdma/msg100274.html
Compared with the above commit, are the following also needed?

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
b/drivers/infiniband/sw/rxe/rxe_net.c
index 0701bd1ffd1a..6ef092cb575e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
net_device *ndev,
        struct dst_entry *ndst;
        struct flowi6 fl6 =3D { { 0 } };

+       if (!ipv6_mod_enabled()) {
+               pr_info("IPv6 is disabled by ipv6.disable=3D1 in cmdline");
+               return NULL;
+       }
+
        memset(&fl6, 0, sizeof(fl6));
        fl6.flowi6_oif =3D ndev->ifindex;
        memcpy(&fl6.saddr, saddr, sizeof(*saddr));

Zhu Yanjun

>
> Thanks,
> Kamal
>
>
> >>
> >> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
> >> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >> ---
> >> drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
> >> 1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/=
sw/rxe/rxe_net.c
> >> index 01662727dca0..f353fc18769f 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> >> @@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
> >> {
> >> #if IS_ENABLED(CONFIG_IPV6)
> >>
> >> -       recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_net,
> >> -                                               htons(ROCE_V2_UDP_DPOR=
T), true);
> >> -       if (IS_ERR(recv_sockets.sk6)) {
> >> -               recv_sockets.sk6 =3D NULL;
> >> -               pr_err("Failed to create IPv6 UDP tunnel\n");
> >> -               return -1;
> >> +       if (ipv6_mod_enabled()) {
> >> +               recv_sockets.sk6 =3D rxe_setup_udp_tunnel(&init_net,
> >> +                                       htons(ROCE_V2_UDP_DPORT), true=
);
> >> +               if (IS_ERR(recv_sockets.sk6)) {
> >> +                       recv_sockets.sk6 =3D NULL;
> >> +                       pr_err("Failed to create IPv6 UDP tunnel\n");
> >> +                       return -1;
> >> +               }
> >>        }
> >> #endif
> >>        return 0;
> >> --
> >> 2.26.3
> >>
