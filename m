Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3455010DE90
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2019 19:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK3SgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Nov 2019 13:36:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41525 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3SgE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Nov 2019 13:36:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so35260984ljj.8
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2019 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Irn5UBlraoC6oNG6oHJ0v3sniaA47hfP9JyZ+OOZ5YQ=;
        b=DqePDF5z5ErRyWSeEgVaSsv8stVnpuBr+ZgPAs/bxB2P6a9Q83YgJNJKigI+qKzX7l
         d1ItFUaSCRwJc7UUmQ1puXVuXuwv0D/q5PC8EPzfuJQ/gVPTSHLlpdwz/uBl8j4dRAmh
         vp3NOQ7crMVKbNTlP5JnOPAY9FVhRRSy9edd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Irn5UBlraoC6oNG6oHJ0v3sniaA47hfP9JyZ+OOZ5YQ=;
        b=BQ9XIt+b62VodL0PqquK0TOTQHNQnwGU5mj9tLq3iS9opdx0eYUdmMRfV+2Q9j9ilK
         TIcLcCbf7B1bQHFbA3Y2UYSrOFPg5wzHI0Zt8d9MzK9G7AvEOHTwxWveTMYO3x+qdmg7
         +XZFSlw3vQ4Ba9YOMom4kkX9E52nu6ZFo1U93nMw3ngaCTZFQPaWPdSiOv/g6ycRHHkn
         Fxvd4F0QMpXh7fnCRvRKfTgL8j4v+Ddc9HhNYZQm0P5dynqApD0RvKXXvDRLjTVFi9MO
         /p1koI3Y7NjEgUat0gU9fWwLtBbE/CQ6dWOZkfidcQZKcPBQnSwj0zFHSe+HQBWG4P9P
         C4Yg==
X-Gm-Message-State: APjAAAUUiQVDFPecvlZ1GX6aSJwpQrXqAwqzulf+nadeiAE/Fi6bS/Z8
        YL/wmRd7nkEgnuVLKdqR5TUzaU6I6/A=
X-Google-Smtp-Source: APXvYqzsNtys09hAWpNo0Cz1fzqpz9S1DlPDtK+pc2vxx7raUrO+iN1AuXdlfWTQQ/wyHVuT7aFuAA==
X-Received: by 2002:a2e:9684:: with SMTP id q4mr3918633lji.242.1575138962401;
        Sat, 30 Nov 2019 10:36:02 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r26sm6095134lfm.82.2019.11.30.10.36.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 10:36:01 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id e9so35266285ljp.13
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2019 10:36:01 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr28337844ljj.1.1575138960919;
 Sat, 30 Nov 2019 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
In-Reply-To: <20191125204248.GA2485@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 10:35:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLUF3zZzTgaAM+JQu6T7MWdXLZUDgXodSZxSv0TMNCmw@mail.gmail.com>
Message-ID: <CAHk-=wgLUF3zZzTgaAM+JQu6T7MWdXLZUDgXodSZxSv0TMNCmw@mail.gmail.com>
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

On Mon, Nov 25, 2019 at 12:42 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Here is this batch of hmm updates, I think we are nearing the end of this
> project for now, although I suspect there will be some more patches related to
> hmm_range_fault() in the next cycle.

I've ended up pulling this, but I'm not entirely happy with the code.
You've already seen the comments on it in the earlier replies.

            Linus
