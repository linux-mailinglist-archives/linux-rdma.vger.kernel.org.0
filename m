Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39187DA09
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 02:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfD2AJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Apr 2019 20:09:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41069 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfD2AJ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Apr 2019 20:09:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so7714540lja.8
        for <linux-rdma@vger.kernel.org>; Sun, 28 Apr 2019 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5edmKMNesOmTcxFJnf9Lz0/KQgLhzB4TUwjfxcYB3Uk=;
        b=ez30jOypMMG21KI3XNAUZsoNnolgvRzYvcCoQeA037MgleXHJRmoIb5BJbrsv3QAz/
         4TqBnEJLGefSeW+uwDduv37MKUifx7r1q8Gsfc686s9vJ8f/4YhVRGHG0P02BMeb0UFG
         YPTWymrNHQ99FODG+f5nK6n1Ql7U9d28fc6kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5edmKMNesOmTcxFJnf9Lz0/KQgLhzB4TUwjfxcYB3Uk=;
        b=W1rV6nb1fiJRom7fP1m54+KsXGikGxYyPvRV80khDE9ij+qAdGcr7g3tsgqK7CspbV
         tTavcw0jYazfWmoF/XiV66nQhprxrokORthxZ6Z6LHf59sY4KQ36sZcEo+GwwjO8VCPj
         SlMdJQ3HnK1MxYd/ozYiCrMczAYvchXACdGE8WOveacbzvLHNesoRLkUJ/ruQrHfIzUp
         0xwbgBlK33+w72dFZM+ffEKSqUu5ttiVUmrIaH+cNfZcvr7Dwh/ndN0YMgjkKa3caRA4
         GpmT8Xv5hHVbK+s/WoRHt/mgEWQ/4yq1dKiqD3CohUbF1szM5OzKzlSwYE5CmiKiZzRJ
         /x6g==
X-Gm-Message-State: APjAAAWNieuibdfjew9DhMQfUdP3w0aSLl1GwhLnMdSi4sju9avuqd4u
        p9D7YhkcOJLCgSQeW42PU/oLZnQFc5U=
X-Google-Smtp-Source: APXvYqxMgkhyMnscCWaqq66r9c4vU54awG24uQ6tj+y8EAxHe+1LLhecVqYAuw+aUQ69FxLWWbIbpA==
X-Received: by 2002:a2e:5dd9:: with SMTP id v86mr2590154lje.157.1556496565571;
        Sun, 28 Apr 2019 17:09:25 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f25sm7053090lfc.46.2019.04.28.17.09.24
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h5so6596380lfm.1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr4933626lfb.11.1556496564129;
 Sun, 28 Apr 2019 17:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190428115207.GA11924@ziepe.ca> <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
 <20190428234935.GA15233@mellanox.com>
In-Reply-To: <20190428234935.GA15233@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 17:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
Message-ID: <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 28, 2019 at 4:49 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> It is for high availability - we have situations where the hardware
> can fault and needs some kind of destructive recovery. For instance a
> firmware reboot, or a VM migration.
>
> In these designs there may be multiple cards in the system and the
> userspace application could be using both. Just because one card
> crashed we can't send SIGBUS and kill the application, that breaks the
> HA design.

Why can't this magical application that is *so* special that it is HA
and does magic mmap's of special rdma areas just catch the SIGBUS?

Honestly, the whole "it's for HA" excuse stinks. It stinks because you
now silently just replace the mapping with *garbage*. That's not HA,
that's just random.

Wouldn't it be a lot better to just get the SIGBUS, and then that
magical application knows that "oh, it's gone", and it could - in its
SIGBUS handler - just do the dummy anonymous mmap() with /dev/zero it
if it wants to?

Whatever. It really sounds like this is yet another horrible back for
bad interfaces for all these "super-special high-end enterprise
people".

I hope that some day enterprise people will wake up and realize that
"enterprise" seems to be often a code name for "lots of random hacks".

                    Linus
