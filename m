Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEFA1251EB
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLRTdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 14:33:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39118 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRTdp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 14:33:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so3446299lja.6
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 11:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nkv/j0DmOufir99TeJBSwrc+MG8sCcIZ06VqqtU6qj4=;
        b=HB5BhhATDpbdm4h+jVarT9wg6GBJI7KN8S7Moxw6piTnQ1m9cOBJIQS/PaCI6gTwMC
         KcFBk1wxizpJ2F1l9fk+BZCervlQw4eLP6hIx3WTFqvuEuuqo1YSkFlmKAawJkGux2PE
         vW9q2+l9GY9Z481m0TD7EghEJOC9eulnbmi7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nkv/j0DmOufir99TeJBSwrc+MG8sCcIZ06VqqtU6qj4=;
        b=GqhUojuppGUlkLws79X2LlANmQY1nbfMao/KsfTg9W/fwA6qaX3Zi7rxZ9L03W9ALK
         sA+kXNwV2sZdEy0YU8thPv0uz/7NIDT2gPvLVtBw3JXjFOKzokJl9bNX3KsXVfytxo/H
         maK68pAQM0HaA2KiUPdwXIMV6fOh3QdrJQ1ULRCp27qwwZ24tke8fcBcJzxUUcXnfNyh
         9OTEWNQmhNkZrYPgYI/wYGkf98JLmSH7sg3m6bLTBVtUxJHrHvDL0KyF3CRwPvb9KrfD
         aPnMgn7Q3tzXUCRjbl+x5OUp+Aoy6JiFTJqAJscSAVZcgm+wMDRluUyufOPvXmwEJdw4
         P0EQ==
X-Gm-Message-State: APjAAAVfcaYVQHHOlDTFzo2T7q+Bcmu9f+1vrnRsQrwnnl5dtQ4TWYWl
        zYfVqJULxphPtX+syjv7BVf4UF0MnJo=
X-Google-Smtp-Source: APXvYqxS7x8o8+24J3kj/QjZU+glahmLbckPzCYkAOrrLOO4EqRyfMIiiSecymHjn/oVGXQtiUovDg==
X-Received: by 2002:a2e:804c:: with SMTP id p12mr3043220ljg.31.1576697623046;
        Wed, 18 Dec 2019 11:33:43 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h24sm1619128ljc.84.2019.12.18.11.33.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:33:41 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id m30so2535418lfp.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 11:33:41 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr2827166lfk.52.1576697621256;
 Wed, 18 Dec 2019 11:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca> <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com> <20191205160324.GB5819@redhat.com>
 <20191211225703.GE3434@mellanox.com> <20191213101916.GD624164@phenom.ffwll.local>
 <20191218145913.GO16762@mellanox.com> <CAHk-=wgR7OSE9Bn2+MbOYDbiu7n1RQaQhdc6gkEywXL9rMFcpw@mail.gmail.com>
 <20191218183704.GT16762@mellanox.com>
In-Reply-To: <20191218183704.GT16762@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 11:33:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=9MNwP6gAqhMZ+T7GBVCt-VZyw8qb-i_eXQ61izBKrA@mail.gmail.com>
Message-ID: <CAHk-=wh=9MNwP6gAqhMZ+T7GBVCt-VZyw8qb-i_eXQ61izBKrA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 18, 2019 at 10:37 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I think this is what you are looking for?

I think that with these names, I would have had an easier time reading
the original patch that made me go "Eww", yes.

Of course, now that it's just a rename patch, it's not like the patch
is all that legible, but yeah, I think the naming is saner.

              Linus
