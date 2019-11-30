Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4BE10DE82
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2019 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3SXx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Nov 2019 13:23:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45864 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfK3SXx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Nov 2019 13:23:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so24863578lfa.12
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2019 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0JfrhdDhzTetmUD+84kClCBoBttknwfKi4pRj2979M=;
        b=bf0MgGTip6d1PItDL8VGeE1qaDY/j9ixz0qpAQkf5F6v9M5aNPOpI4jjr2XPxAxhcA
         GJKbY/6+tUCS+LVQS13ljyhVcfEbxwb3tv5e7NTZlJijMtJ6r3T+eylFOA0z7JAlzHKn
         R52/jRzjHqCo8LV/hAE+usMuZz8TLO3DZuEW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0JfrhdDhzTetmUD+84kClCBoBttknwfKi4pRj2979M=;
        b=nsIZFyKpppDdhFdBTMfSphXjjTKDDe/N/IIO6UL+yceTE6ozagNi0L+aKjwpDNKh25
         pso4dKLBOuEsWwVo7hE/IYuS3isAadPIU2+t0EYox7+xXJtPhMtS5hE+TGtWw6Xv1BVc
         1QDbr2olQXCfq+kgqt77j2EuAG0li8HzqjUY9fRHcl1eBoa+BQCIeMZXloCupR4TcGsj
         zq+/i6LRSh5gBmG0Kg2LS4NZ/anr2yO2mgP7CVZeTs6Z0hmM1K0VtpUcrnyVBs02SXxG
         6BCmdjEeABLcHqK80oneafGz9rJrkNaOcreZRKohPEy1s7G+bCfUNChGl0qSD78BzZyL
         knCA==
X-Gm-Message-State: APjAAAWPYwPpz8YROoOlJ+ErFX7lvhmOEC6stcmlvo2cHYymSPASGGy7
        hP4s6BUit+HisM3J2tL+/Ub8rRbMsqg=
X-Google-Smtp-Source: APXvYqzWKEsy2lEXyO/arb+zhdWm7bnaaetGLvu3XR2SVcCGRYcYiBS3YrkhuD2gUDgMtVfGX+NprA==
X-Received: by 2002:ac2:4212:: with SMTP id y18mr11068216lfh.2.1575138230531;
        Sat, 30 Nov 2019 10:23:50 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f11sm8434943lfa.9.2019.11.30.10.23.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 10:23:48 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id f16so24912002lfm.3
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2019 10:23:47 -0800 (PST)
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr36767338lfa.61.1575138227505;
 Sat, 30 Nov 2019 10:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca> <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
In-Reply-To: <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 10:23:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
Message-ID: <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 30, 2019 at 10:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll try to figure the code out, but my initial reaction was "yeah,
> not in my VM".

Why is it ok to sometimes do

    WRITE_ONCE(mni->invalidate_seq, cur_seq);

(to pair with the unlocked READ_ONCE), and sometimes then do

    mni->invalidate_seq = mmn_mm->invalidate_seq;

My initial guess was that latter is only done at initialization time,
but at least in one case it's done *after* the mni has been added to
the mmn_mm (oh, how I despise those names - I can only repeat: WTF?).

See __mmu_interval_notifier_insert() in the
mmn_mm->active_invalidate_ranges case.

I'm guessing that it doesn't matter, because when inserting the
notifier the sequence number is presumably not used until after the
insertion (and any use though mmn_mm is protected by the
mmn_mm->lock), but it still looks odd to me.

               Linus
