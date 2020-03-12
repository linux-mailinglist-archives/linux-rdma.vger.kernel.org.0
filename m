Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E30182A05
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 08:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbgCLHzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 03:55:54 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40831 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgCLHzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 03:55:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id c15so4710174ywn.7;
        Thu, 12 Mar 2020 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8PH8OwRLD6nQXDDi9y8VIf66Uz6y/cjwU3hUU4CHeQ=;
        b=NYpb5alec01RBygunaSyIwAvzoDgMhxcnYOM5Z0iWhI6ke8QJJuGbFWLgFtCkzOhSo
         GmBEWrvQPIhOxjn7HuZ7k5vG73LaHkos049KQPV5cc2hFNRvbijKNH9UqIw+VgasE4xn
         3u7y7elTcNfK1JzMXRbdFDFnqbOxqmLRe+0rUE5mK/coiDm/Xdd+K3y7vJXqETfNaKUl
         I7SRSFAGlpKQOP6enB7qLsjfHZagaBg0kGG8KnhuK9p/9Obksy8WCavX1brmWM52OIno
         Zyuu7bat/tQDr2/OE3y96UhIQ7QPveDoq0k2IxJJU4ACBvdTqQ5KLP5bueYl/O1MeTvH
         Bw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8PH8OwRLD6nQXDDi9y8VIf66Uz6y/cjwU3hUU4CHeQ=;
        b=hBnnebFSUQ2yabngB6S6VMTJU3fvP72f3dGH2CfOhn1aV/8/AvShEURfjJ7ZKjdODE
         AL1T0rpoGLD1PDmRhE93lKBpC4FImDjZFAagOnpshzjmzFLVwCA6KRcvlccHMrkybTC3
         lsKurZLKNtXJWvaeoyZsQD/yZSgVJCXgU3E7M4wZ06hHAvL8vFXZm7ttEObQ4QBmzMi9
         OKHO1g9LcYtZdfY84ZVaNwvAwyAU9Pn8IpRsdlKBigQYOrgfKKZOJ5qkKTPs+zeDKDXc
         uAOFKVHcGfEn7oD00RQGiLf1pJbwg/5+pl1lPf+B3mKO7h5SZRlqhCPyEJzxqVRfNvUn
         i6pw==
X-Gm-Message-State: ANhLgQ2BXU0YTQApYn/Qmme6h/Vd33X5lxM17OFG9CFizx1GWG8yj7ju
        xLMtmQgGvQH/2vJe8MiLxKd4wQ1TM7Jsk0tfwSY=
X-Google-Smtp-Source: ADFU+vts+xJgjvsNggC0oJn6T/AhhA6fIzZAK7IOhIRQgnxsxYNXe7MXAD02qS1EHhqhreTigQi0w6OWbvY0Klo8cyc=
X-Received: by 2002:a25:ace2:: with SMTP id x34mr7802951ybd.83.1583999750963;
 Thu, 12 Mar 2020 00:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200304001339.8248-1-rcampbell@nvidia.com> <20200304001339.8248-2-rcampbell@nvidia.com>
In-Reply-To: <20200304001339.8248-2-rcampbell@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 12 Mar 2020 17:55:39 +1000
Message-ID: <CACAvsv4+od30K-FAr5Fet7kOz1APRDTXmHRc3fN4eiCVDhY02w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v3 1/4] nouveau/hmm: fix vma range check for migration
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I've taken all 4 patches in my tree.

Thanks Ralph,
Ben.

On Wed, 4 Mar 2020 at 10:14, Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> find_vma_intersection(mm, start, end) only guarantees that end is greater
> than or equal to vma->vm_start but doesn't guarantee that start is
> greater than or equal to vma->vm_start. The calculation for the
> intersecting range in nouveau_svmm_bind() isn't accounting for this and
> can call migrate_vma_setup() with a starting address less than
> vma->vm_start. This results in migrate_vma_setup() returning -EINVAL for
> the range instead of nouveau skipping that part of the range and migrating
> the rest.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index df9bf1fd1bc0..169320409286 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -179,6 +179,7 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
>                 if (!vma)
>                         break;
>
> +               addr = max(addr, vma->vm_start);
>                 next = min(vma->vm_end, end);
>                 /* This is a best effort so we ignore errors */
>                 nouveau_dmem_migrate_vma(cli->drm, vma, addr, next);
> --
> 2.20.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
