Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DE2E28E8
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Dec 2020 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgLXV7B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Dec 2020 16:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgLXV7B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Dec 2020 16:59:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A8C061575
        for <linux-rdma@vger.kernel.org>; Thu, 24 Dec 2020 13:58:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so7117540lfg.0
        for <linux-rdma@vger.kernel.org>; Thu, 24 Dec 2020 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSDUiTX/NXLyfi/V+4IDlAI8A7LxI546IW1ZU27ToIk=;
        b=Nfn/q5YlLQXpNXmEqDq6/Q73KAKT9+/L3eZV7VMiDu0ylSNbF8Nv9EwsSOk+NVj2PO
         i7G8+E4U/BxtLR5pWY0MG+Tzn7RNQkXV6uD1C8OgOLEXQscqxhT82LkV2Fe8GoYCAkTX
         6tivVLx51LNiPh+vog+1uBXpnCELCRRLgCqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSDUiTX/NXLyfi/V+4IDlAI8A7LxI546IW1ZU27ToIk=;
        b=s4D7X+Wq2JP43SwXFUFtO/PmOqCJEDbJAvXVWLVeE2tk52d5ZPMX/PmMFulvs33g0Q
         Pfd2+ms5X3fgAJh6DQlqWXCpr8cxKoD1tavxYGEzTPUDN48yW5XjdTyWyH+yRtvdu6kL
         folHPT3ic/NAtNg62OT0p3+lke0OV8xq6mu39W8stIkNJ9TZX0QSqfIXWq/jUBFgPPSZ
         1J6YMGqeecG1iP+tR+IxkOOC7No8QhcTpZ46gFyjYIYa7rCf2mm2+F8DXKSEzGlSqmYl
         /aXVWsqDMkSZEqRjp0hKsd+RPX+nr7n06bccAhhnQfXs5h47d0pISwhNAXLQgp/jWQYR
         uXdQ==
X-Gm-Message-State: AOAM53146wVMXIcUTGBWY8F7T+/l/hzU6sP+3ZlE+stWofMzMAk0rwN7
        mSLll5Ixb6x7sxPtCsA0KcSAxHyllvuY7A==
X-Google-Smtp-Source: ABdhPJywEdSn4qC3MGBsZne9wfJG5kU4ykQmVFteZmOhIgeajRDnfLg4dzceWa6vzgQG/dKi+UdcMQ==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr14436738ljg.451.1608847097419;
        Thu, 24 Dec 2020 13:58:17 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c24sm4281606ljn.116.2020.12.24.13.58.15
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 13:58:15 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id o19so7111103lfo.1
        for <linux-rdma@vger.kernel.org>; Thu, 24 Dec 2020 13:58:15 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr15568245ljj.220.1608847095286;
 Thu, 24 Dec 2020 13:58:15 -0800 (PST)
MIME-Version: 1.0
References: <160868116773.15975.16926726831905097728.tglx@nanos>
In-Reply-To: <160868116773.15975.16926726831905097728.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Dec 2020 13:57:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzJf_UTORN+j-Bn-faWBgM=oNgj9feUu-d7F6BqK5hdw@mail.gmail.com>
Message-ID: <CAHk-=wgzJf_UTORN+j-Bn-faWBgM=oNgj9feUu-d7F6BqK5hdw@mail.gmail.com>
Subject: Re: [GIT pull] irq/core for v5.11-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 22, 2020 at 3:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   A treewide cleanup of interrupt descriptor (ab)use with all sorts of racy
>   accesses, inefficient and disfunctional code. The goal is to remove the
>   export of irq_to_desc() to prevent these things from creeping up again.

This exposed that the mellanox mlx5 driver had grown another use of
'irq_desc' in commit 145e5637d941 ("net/mlx5e: Add TX PTP port object
support").

Except that use was write-only, with the only acces being this assignment:

        c->irq_desc = irq_to_desc(irq);

so I removed the 'irq_desc' field and that assignment in my merge.

I didn't even replace it with an affinity mask thing like commit
6e745db4ddd0 ("net/mlx5: Replace irq_to_desc() abuse") did for the
previous case, because the irq_desc thing was literally pointless and
unused. I suspect it was some cut-and-paste programming.

Just writing this note so that everybody knows what's going on.

              Linus
