Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87C29F44D
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJ2Sxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2Sxk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 14:53:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A60C0613D4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 11:53:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d25so4225017ljc.11
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZe3AQjrpqH5xb0HFY+F5bJm7+6FpbLNI7yCa2PA1xk=;
        b=fYo/tT9VWNa6txrV/eT6Rp1NB/LxKNnV4XnN6GV7T88v+FpbFKhTl7p/DKDaIdTmgz
         YLEO1C38eIj4PXcYJWKEGnv3IeNHR3W/Yfetn/B3URQJYD0IR+N91NBXn03sGmrzKmHa
         let6OzGitZcVIkBN3Eke79gVjw3MJlwWvhlGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZe3AQjrpqH5xb0HFY+F5bJm7+6FpbLNI7yCa2PA1xk=;
        b=IS8CVjkqUbsWGdBLGydM4YW+Ak416pnGnTz5GwzK36YmxpCc0kaMalSs7X0hZLyMzV
         1akc3t12dtTetx8Ye/TCd62OGv3A1VjHG8jNeKNtJHiLN9dtRYhvJTPCUMHGs7iqHCTK
         RTZd5FJ0ISqKSJs+kGc3XFaVsuRvDTz8BorRdEridcifuFNn/k3aKlt8iOPcWkzpKLsQ
         /q36QCtCT9UkFhVATfl+dzib8TDeh9KqBj+YJYJc8BZLQrYBLKRTheRMODqL2ADiOhYK
         AlNKNBtjgy6oo+AXGKJ5Lszx0qo2ubNd1SDQDBzuC9r1KOPPicoxMuTRcWJgiUZa7Ue4
         Vkhg==
X-Gm-Message-State: AOAM533OeaMQZoPsomBbYQfgXOXGJSAmihpM7wpPqYYP1zQuVJDHYa3K
        JZv7XpEhSOHY2hj61XivBykJ11TnqWQQ4w==
X-Google-Smtp-Source: ABdhPJxLsNSWdnN4TfkyXfT+0p6+wo7r5mKbbydKC+aMnst1ZMhYvIPWVFerv37ZufcBlsRzHdPn+g==
X-Received: by 2002:a2e:984e:: with SMTP id e14mr2277578ljj.94.1603997617906;
        Thu, 29 Oct 2020 11:53:37 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v15sm363417lfi.114.2020.10.29.11.53.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:53:37 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y16so4302164ljk.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 11:53:36 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr2386293lji.102.1603997616544;
 Thu, 29 Oct 2020 11:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029184123.GA2920455@nvidia.com>
In-Reply-To: <20201029184123.GA2920455@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Oct 2020 11:53:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8K7tn0Y_ne4nYTEQigZKE-foAOnjkYzTTRh0ruMKTyw@mail.gmail.com>
Message-ID: <CAHk-=wg8K7tn0Y_ne4nYTEQigZKE-foAOnjkYzTTRh0ruMKTyw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 29, 2020 at 11:41 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Three notable merge window regressions that didn't get caught/fixed in
> time for rc1:

Three .. and then you list five things ;)

                Linus
