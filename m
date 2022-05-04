Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A344F51A400
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352403AbiEDP3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352786AbiEDP3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 11:29:36 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5042C661
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 08:25:59 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id p1so630651uak.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6KaVnI7rfJenx+3SffjuaqizCTMLuYUAgf5qe0eYiA=;
        b=T2/LHo+e7vqogm5r3+Ft3/zWLxozf82phySmunwDoFOZGd9qUxBu3AApyFG8BpHOzH
         VbImHv8Bevwo0UVGj/eA/Po5vzg/bgFj5PdRFG8JMhYDzNTLwF2xuojuvQgxI1G2j2A0
         pBKajlla5RL83zk4AD8kJ5WgDFckOZZzYlCq1T6+x3o+l/Fo9Z0XrdzvrZm+i1le1tfc
         egNajVfLtSFmPN8mM8tiy6KSEEfiB/Z2wz3v8KpAoGfIUbFk/M9VpwPDZmg/YvtuBiXe
         oJlVK1pO+RaQE4oOvkUXq/Baca3um/Nba9BYW2sc/ejANBQjRZA8MJJAXgZu9/Nzl4fd
         5nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6KaVnI7rfJenx+3SffjuaqizCTMLuYUAgf5qe0eYiA=;
        b=j4MmKfpoUnMCTe1zEbBijH5XWBB7ilHcIBMSzLDZ52vICjqeGS/C7mFLWnSXMogLQF
         Ztsyi4bW6dYo44xr0eo2S6fS3ecUiXD5IcQBjasxoX+AmIkBObv+fKo9uhwOCwUixOzz
         LuSCUtF9TfwuV3X3rBVD1sU4t+X/v9yrapnyCZ+UV8rf5TA2xFikbAiITbQjdTWLMpkZ
         ZugyYZNQDKC33iv7Ra/digPfcadw1EhHYFW29vJpL/1nZSjID7XZ6t43JSbSGbc9dHFL
         nY6hcM3muRd4PjWJ+Y/bv20Y4uL29HskQhicVYWbwEQXRSTuj0O64lfPkNXWXtEHnyuy
         XOaQ==
X-Gm-Message-State: AOAM533Cpe9eb+Y/y4LPAjmJUBCCXXVZ8aeidMbUPRFB+vka5HuFVd21
        giCQilM7Qyo5DZ6h2uNeX17hmOp/Sb/6FVz85fenOlXO
X-Google-Smtp-Source: ABdhPJx+sH2KXrlk80uNsBwp1e3lZw+ZwmdepI7CsBTKDvCD7clxr1vKUUld+5bxVALApokTnz6F6C/qRuFUJi9ph1Q=
X-Received: by 2002:ab0:407:0:b0:35f:ef75:81e8 with SMTP id
 7-20020ab00407000000b0035fef7581e8mr6394763uav.91.1651677958955; Wed, 04 May
 2022 08:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220502053907.6388-1-cgxu519@mykernel.net> <MW4PR84MB230773A6CD5414E6CC8E502CBCC19@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <6b41c49d-b3ed-8396-a217-c756a37b5e05@mykernel.net>
In-Reply-To: <6b41c49d-b3ed-8396-a217-c756a37b5e05@mykernel.net>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Wed, 4 May 2022 10:25:48 -0500
Message-ID: <CAFc_bgbnMed9VeBM5RJ1py2tzyOSGXbMThmNskSQdiiQAeidJw@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in
 retry operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry I misread your original post. You are correct. The wqe->iova is
only used to fill in the RETH header so it is not needed after
the first packet.
This commit looks OK.

On Tue, May 3, 2022 at 2:59 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> =E5=9C=A8 2022/5/3 1:15, Pearson, Robert B =E5=86=99=E9=81=93:
> >> -----Original Message-----
> >> From: Chengguang Xu <cgxu519@mykernel.net>
> >> Sent: Monday, May 2, 2022 12:39 AM
> >> To: zyjzyj2000@gmail.com; jgg@ziepe.ca; leon@kernel.org
> >> Cc: linux-rdma@vger.kernel.org; Chengguang Xu <cgxu519@mykernel.net>
> >> Subject: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in=
 retry operation
> >>
> >> For write request the remote addr will be sent only with first packet =
so we don't have to adjust wqe->iova in retry operation.
> > This is problematic for lossy networks. A very large read request, say =
8MiB, sends 2048 packets in response without any acknowledgement
> > from the requester. If the packet loss rate was 1% the read request wou=
ld never finish as the probability of sending 2048 packets without
> > loss is very small. The way the code works today is that the iova is ad=
justed, and if you are lucky the responder has already finished the
> > previous read operation and starts over with a new read reply starting =
with a first packet at iova. If you are less fortunate the previous
> > read reply has not finished and the responder will continue to work on =
it until it is finished before looking at the new read request wqe.
> > the completer will respond to each out of order packet by checking to s=
ee if it should start a retry but since it has already done so
> > it drops the packet. It's messy but one can make forward progress ~100 =
packets at a time. It would be faster if the responder saw that
> > the new request replaced the old one and stopped sending packets on the=
 old read. I have no idea how CX NICs do this but just restarting
> > from scratch seems bad.
>
> I agree that read request indeed needs to adjust iova during retry and
> the adjustment(for read) has already done in below logic in req_retry().
>
>
> if (mask & WR_READ_MASK) {
>          npsn =3D (wqe->dma.length - wqe->dma.resid) /
>                       qp->mtu;
>          wqe->iova +=3D npsn * qp->mtu;
> }
>
> For write request, retry will not send new iova because only first write
> packet has RXE_RETH_MASK regardless iova adjustment.
> Am I missing something?
>
>
> Thanks,
> Chengguang
>
>
>
>
>
