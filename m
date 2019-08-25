Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D570A9C5FC
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfHYT4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 15:56:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38646 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfHYT4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Aug 2019 15:56:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id f21so5722033lfc.5;
        Sun, 25 Aug 2019 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNr4Eb/OClyqUi9J6625K0uKkXRSs4d01YJAiRjVE7A=;
        b=WyoTJVrbbLq8FbO4TiYd5CrfgfvZ/Ws3Or/Q8fFtw+6WmPUY1j7gpEMSRodUhUCA/u
         uL3qZp5ltjLSfCz6LbDA/DtjDqBdiqJ67Bc4JuF1DpY5gr3kdeufOd+WOXXqOBip92ob
         z83W5JH3vT9mRTmY303X35KTBkey1NSm6LbMzRrI/axOhl2Z7F9K+7kWGECuT/nkHJ3L
         4eULs2SQ/KWvBD7+do/T/laxix/bdmiyH/qNacguHRFkN546rytHBIAISs9pX1a6qH/k
         iBGeWkqE9b/v9RPmLdz2tBw/pyYJfageU2NTsckkCjW0LbrGwH//VhtQ3GAoibE4HUXb
         UfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNr4Eb/OClyqUi9J6625K0uKkXRSs4d01YJAiRjVE7A=;
        b=dtVrnOyf99DXZGjxNhRoOYr7pT18X6CNdEih5GlPqtR+xDqMK/oiJ+A33l04unTutI
         y9/qpXm3E36jWFLqCuKQAVKEr4IA+gT/01jkA3613Yo6tX3FkxhPQ1pwJCp3yjHU8ROj
         ggDWS8lQ7UxhpQ7X+5nd5gyEipVIUq9rCVDLnqN8801W+LOBlEeNOYz3lX6+K01h8/ez
         /iFgBJXAlERaG9JFnnrMvMh6gx/6dJTS15WGATLEEqUMVsE2RUO4GjXz39FGFuS9O+gn
         KfOYlwlYHcg+26QEUDWnr/fwr2OUAgTMM1fyOp2PTmHMrsjFpIGU+ui8qhlOHi85ET4v
         646w==
X-Gm-Message-State: APjAAAU8JSkxZy7T9GO9YZK+RMGfmK4arZxI4pIFi4qI53UhP1F9xGPZ
        Gkt+b0afrgk2/U75XqzO+VwrSqqNYLWV9mo6ab4=
X-Google-Smtp-Source: APXvYqxNB9g686I/txTkwcUXa2qaf6TAlS+aO49/xFd/b6spcrqM8Blz4ezofbNhYBx3iNvXChpSvb/HbShO6VA4Gak=
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr8534933lff.95.1566762982456;
 Sun, 25 Aug 2019 12:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com> <20190825194354.GC21239@ziepe.ca>
In-Reply-To: <20190825194354.GC21239@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 26 Aug 2019 01:32:09 +0530
Message-ID: <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > First, length passed to mmap is checked explicitly against
> > PAGE_SIZE.
> >
> > Second, if vma->vm_pgoff is passed as non zero, it would return
> > error. It appears like driver is expecting vma->vm_pgoff to
> > be passed as 0 always.
>
> ? pg_off is not zero

Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
which means in true scenario driver is expecting vma->vm_pgoff should be passed
as 0.

-       if (get_index(vma->vm_pgoff) != MLX5_IB_CLOCK_INFO_V1)
-               return -EOPNOTSUPP;
