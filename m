Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AA29139E
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438854AbgJQSWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438829AbgJQSWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Oct 2020 14:22:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14ABC061755
        for <linux-rdma@vger.kernel.org>; Sat, 17 Oct 2020 11:22:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so6226551ljn.13
        for <linux-rdma@vger.kernel.org>; Sat, 17 Oct 2020 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvfrPQKqDIUDWKr4bvF9zseBtYlgWNO2Udg9wjc+J0k=;
        b=X/atbA5ghjwxGuDohIm6DWhvDxovv16cntrov/K/0HDMXAWJ51CDi4OMyWKrhwWWGD
         tdZHgjyvMJCOGFTb1HHCFyFZiwsxQWWophssZz6Kve39ZrC95pZ+5G5k+b2QPLi4wTDz
         MykSD+HdImlY3WRMqruqM22jNtThdFkydsFLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvfrPQKqDIUDWKr4bvF9zseBtYlgWNO2Udg9wjc+J0k=;
        b=m7Id9YaTJzFAnaWsxBg68rhilcjEh/gGi84WYiORfPyNj2Dzv6grK0NExg7L9NYh3v
         +y6ovWTe6qHLVMuF1YJvBQIM7DnAvzK17PNiEJ3Q61Qu1ZV57nrf3BQyiEjOCpWXUcnX
         w3jbo/uYlGAPZh0bArJhiTMLQ/IRt5vBZ9Qtx2N8hCXxzG3Ooh3pfN8x8ZZ6O8dLGcqW
         sN8ecGx34GzcCTTnXX03ixjHQ2wUZD9lhhAEt7SgyhsCFiSdm9PyJM1EREc9Kgupm32N
         NG+vpHbIymoVqbFDy5ByTXJ4hy4lszyJ6/6Mx7u/kjzMd6Jy44Puantctky+q20P4vMB
         9fCw==
X-Gm-Message-State: AOAM533ku/6cpAgBIaH23KG3esIdwVrvVWsDDmKLTIYmNdfqQHVeXCkd
        4PsZmsWFPmLFNehKafadd1yyU5ZgtxJnLw==
X-Google-Smtp-Source: ABdhPJzeRZaxqwBw4l7veXnUWLs/1oigBNWuSotCODN8Czqu5TZNFbPwBD0D9ZIC3H9E5t8D1SEssQ==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr3366892lji.259.1602958929469;
        Sat, 17 Oct 2020 11:22:09 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b14sm2263144ljo.16.2020.10.17.11.22.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 184so7544692lfd.6
        for <linux-rdma@vger.kernel.org>; Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr3076848lfa.148.1602958927056;
 Sat, 17 Oct 2020 11:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201016185155.GA233060@nvidia.com>
In-Reply-To: <20201016185155.GA233060@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Oct 2020 11:21:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
Message-ID: <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 11:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> You'll need to apply this fixup to the merge commit (it is in the tag
> for-linus-merged for reference):

Ugh. That's unbelievably and unnecessarily ugly.

There's no point in that unnecessary "ret" variable and the "goto out"
etc, when all the error cases can be handled much more directly.

So I resolved that merge issue somewhat differently. I can't test the
end result, but it looks TriviallyCorrect(tm).

Famous last words. Feel free to make fun of me and call me names if that breaks.

           Linus

I did it v
