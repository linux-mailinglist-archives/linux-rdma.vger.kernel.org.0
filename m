Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79B3984C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfFGWK6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:10:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39133 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfFGWK6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 18:10:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so3007465ljh.6
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KJ2BLcajVixF67CJRoLG0re1JrYiYqxErMSXYl0tsRw=;
        b=XuBNVLdgbcY56Ud4pdH5EXvxmGUKkACohMhQU5klJr5o3160jnTXt0fFBjrUYI8cwP
         qecWlqIvuoz0yWBNmcfBXRagMuyCN57WmUDAmyLBAoGU/vidUSxhCkBsLMXMAH3gz4EM
         tWZ1AvPkv98MPJtshU6r4aCzmSJMbti0XAF/zuBjkobX6oY2h/G+vb0ik5Hw5N96rvpl
         6I3l+tkrVJzURiq0H50JHF2DmIxfH/WItDgvQ/p6+kMn6jvKrdwRXX3GqUJ8EGr+IbP6
         8uKRI0Z+Ms/ak/i4ugiXOgxFVoAHcF4ZSdzDMKgNGJtjX6zHgettmLUAxF9t1zYsva3u
         aXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KJ2BLcajVixF67CJRoLG0re1JrYiYqxErMSXYl0tsRw=;
        b=ltUb4K0eDZdRNrlLpVfTQmGH3vj8IMIE07r3drXHDS9daMfAg9s1JtIJ+lMainRHZx
         nykq8+F6ruZUgK27Nzn9/uN8LJ8B9khk7YbuiIfSzgEohggTFGHnR9Kr+rN2Szb6giU3
         URkfM+3aNxz4gS74uirFbE9aNXPqv1lNTPEEdXJxzQSLDLBqTH9DPSDQAKE2ll4UGIxs
         vx6yifHlhcNFi7hiwEYtcruNTBuJqExGjiUrJJKh82Cy3wLby7To9hAujE8d4T4f2RNm
         m1hV1QsPfEPQH40g83dG1Lf1fC2+H/Pp+YOiCnp7bWsUqwfGR82oxkIhdVTM5/WC81lD
         ZiQA==
X-Gm-Message-State: APjAAAVjGjx/FD5aGFcjFVueKGnxXZK8Gn9LPdtVSstdelKrgfLkPlbb
        RZvFuQNur05gAw9R+lEKRbzqZXaG8RTLp3Gdw4k=
X-Google-Smtp-Source: APXvYqziLCb0F1leUAaa1UiZwsg3YnrP4quS0pn+HDEfTbgIMU+w+qLFrO34EBW5m2sppHV711BE8EPBCVYV8kHdz3g=
X-Received: by 2002:a2e:3912:: with SMTP id g18mr20425063lja.38.1559945456292;
 Fri, 07 Jun 2019 15:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190606184438.31646-1-jgg@ziepe.ca> <20190606184438.31646-8-jgg@ziepe.ca>
In-Reply-To: <20190606184438.31646-8-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 03:46:00 +0530
Message-ID: <CAFqt6zbPYWiV+2d7-o8EYACKKM2s_M7U=9j3pRux1OWsEqrQAQ@mail.gmail.com>
Subject: Re: [PATCH v2 hmm 07/11] mm/hmm: Use lockdep instead of comments
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 7, 2019 at 12:15 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> So we can check locking at runtime.

Little more descriptive change log would be helpful.
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> ---
> v2
> - Fix missing & in lockdeps (Jason)
> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f67ba32983d9f1..c702cd72651b53 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -254,11 +254,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifi=
er_ops =3D {
>   *
>   * To start mirroring a process address space, the device driver must re=
gister
>   * an HMM mirror struct.
> - *
> - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
>   */
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
>  {
> +       lockdep_assert_held_exclusive(&mm->mmap_sem);
> +
>         /* Sanity check */
>         if (!mm || !mirror || !mirror->ops)
>                 return -EINVAL;
> --
> 2.21.0
>
