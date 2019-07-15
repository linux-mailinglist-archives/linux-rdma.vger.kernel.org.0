Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2376825D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfGOCzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 22:55:12 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:37049 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGOCzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 22:55:12 -0400
Received: by mail-lf1-f52.google.com with SMTP id c9so9900790lfh.4
        for <linux-rdma@vger.kernel.org>; Sun, 14 Jul 2019 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xXZnp3zLEv9/8rZrVJ8Bb1hgH0mFVq0ktioQL8IoBE=;
        b=QG6qimnZ0OuOr18TPPyD1ZpsfC2oaBrHXD55BhiSP6dw+mQqPSGsIUy/Yf4/KOcnWu
         3PMYYqkRk/B44HHs/mOcE5iy2y+FDx49TCkO+kDXoObGp0hcYXLYXFAlMjRw25zjrKgL
         tjFllJ7em2UwShT6KqGZwlL9Geykn6fnTBnEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xXZnp3zLEv9/8rZrVJ8Bb1hgH0mFVq0ktioQL8IoBE=;
        b=ptFaM+k2WQr6vhpjbtMSKnFixgII80pMV43WEafDQq0RMtMSNbwVUTG0MB+nMtSOFv
         uXY+gFoNjPjYWliLEjzQTgabsrdYg+y9+6Xz7QjXW1a+fGvQn0GX11skpXAq0hbC88rB
         ebxPflCe/wG3wu8lw+Z+ew89auVw62mV3NfMj/ZqNyegY3e34xoIBY5Qbg9uXIYBVekp
         zNAu1XuQKFLnhRvK+qSpeO+qVNb8fOLrdrcUyVcdqNVZ1ix0MQvrvs/joDqCqnz8haHh
         5TKkYefAFIRvo5kmrdO1HHMaTHDvGFc/kKUtk6HlDcKVlrqsb+T3Nt2rhkNUrmrjolNr
         HSPw==
X-Gm-Message-State: APjAAAXluwY4DWqaLTAQi8SDWUzjMdSQRBnHHFzlmeNSKWWU1U9v6yN4
        JSAcI29oIzSsEJPBLpDqgZS7Ld+qAzM=
X-Google-Smtp-Source: APXvYqxNagVISAO+BG/f/9tQ2Vxv0f4nMU7t9fpI1odi22dFJ1S8N3LCDo1o42Q9k4cj4/WL4BgHVg==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr9965594lfo.71.1563159309823;
        Sun, 14 Jul 2019 19:55:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 24sm3201160ljs.63.2019.07.14.19.55.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 19:55:09 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r9so14565622ljg.5
        for <linux-rdma@vger.kernel.org>; Sun, 14 Jul 2019 19:55:09 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr11885151ljk.90.1563158936002;
 Sun, 14 Jul 2019 19:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190709192418.GA13677@ziepe.ca>
In-Reply-To: <20190709192418.GA13677@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jul 2019 19:48:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHKrYEMDbA9CxZ2Sw8JuW3=Wxr1fZo+EvXXLhg4iUOmw@mail.gmail.com>
Message-ID: <CAHk-=wgHKrYEMDbA9CxZ2Sw8JuW3=Wxr1fZo+EvXXLhg4iUOmw@mail.gmail.com>
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
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 9, 2019 at 12:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I'm sending it early as it is now a dependency for several patches in
> mm's quilt.

.. but I waited to merge it until I had time to review it more
closely, because I expected the review to be painful.

I'm happy to say that I was overly pessimistic, and that instead of
finding things to hate, I found it all looking good.

Particularly the whole "use reference counts properly, so that
lifetimes make sense and all those nasty cases can't happen" parts.

It's all merged, just waiting for the test-build to verify that I
didn't miss anything (well, at least nothing obvious).

                      Linus
