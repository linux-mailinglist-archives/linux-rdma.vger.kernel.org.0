Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAD280A8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfEWPLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:11:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43687 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbfEWPLH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:11:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so5806267lji.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XRLAU6oU5E0/8gW3lY2rtdeODZlzcPWAFZA13HWTCU=;
        b=A87Rf4qG4wn9ePdBXWK4S6A+i4fN/l2BHBriTyA/NV7md909J0ajFqoql7nafgIWFX
         zNeMu8SMtxpeDziW/96Gcai5LoSeFlFor/iwm8XXRysAwkMkqUmZRyYrQAC88L1pZlXU
         ZQKZDUd8/qaGGjTkJPmRfmYpeswXlH3T1V2Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XRLAU6oU5E0/8gW3lY2rtdeODZlzcPWAFZA13HWTCU=;
        b=OerjRKyIs/qhubWpjZRDfv3Xd6f2MM9ytnkyjVV2Nf3NmnBuMAuZ57wE9Tinm8jICI
         E1h/nr1cZee7Ug/aKhYawSddZZ7MtOAK7+1/xsPKXnLqbflrB2TiH3aQO/iqz8zpaHs5
         C3PzPXiDQST2NBfWBxxfYW/ZqXvSbEwryBnxvtut66aBWBBLLDmw++SIMegox1trW36A
         4vOG/KQNYI854xDF3WxnY+xriVHnqAgUDWVG5y+utmtf2RJKNYN51KtgK83Rz2r0+Dye
         xI9I5y6/xFxhV9slH5id88033xfaF+7rdhyEi+VNPT7MRh9QZVt4p3vtK4Nd7vWwLRjZ
         Eciw==
X-Gm-Message-State: APjAAAUIMKiP5BxDVRBnvJasoFR24GpdmHHscxrgCbQsRa0Zaiv9fy26
        9sOPBTZLUXsg7pzUZVxnEFnDIoHeSjE=
X-Google-Smtp-Source: APXvYqykNdrFByFknCqlOd4Jh72WdY+RLxTeVN/gMfuIQxYdT3PRpkOUumQlwwm8yxW5Z62ZZWHPrA==
X-Received: by 2002:a2e:8555:: with SMTP id u21mr41289930ljj.133.1558624263292;
        Thu, 23 May 2019 08:11:03 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v2sm5629677ljg.6.2019.05.23.08.11.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:11:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 14so5827113ljj.5
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:11:00 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr18999482lji.189.1558624260065;
 Thu, 23 May 2019 08:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523100013.52a8d2a6@gandalf.local.home>
In-Reply-To: <20190523100013.52a8d2a6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 08:10:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
Message-ID: <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 7:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +# define roundup_64(x, y) (                            \
> +{                                                      \
> +       typeof(y) __y = y;                              \
> +       typeof(x) __x = (x) + (__y - 1);                \
> +       do_div(__x, __y);                               \
> +       __x * __y;                                      \
> +}                                                      \

The thing about this is that it absolutely sucks for power-of-two arguments.

The regular roundup() that uses division has the compiler at least
optimize them to shifts - at least for constant cases. But do_div() is
meant for "we already know it's not a power of two", and the compiler
doesn't have any understanding of the internals.

And it looks to me like the use case you want this for is very much
probably a power of two. In which case division is all kinds of just
stupid.

And we already have a power-of-two round up function that works on
u64. It's called "round_up()".

I wish we had a better visual warning about the differences between
"round_up()" (limited to powers-of-two, but efficient, and works with
any size) and "roundup()" (generic, potentially horribly slow, and
doesn't work for 64-bit on 32-bit).

Side note: "round_up()" has the problem that it uses "x" twice.

End result: somebody should look at this, but I really don't like the
"force division" case that is likely horribly slow and nasty.

                  Linus
