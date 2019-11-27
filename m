Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307B210B57A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfK0SUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 13:20:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfK0SUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 13:20:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so16362820ljj.6
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwpNndouEqIAQ7+k+dkJbISEfrceAc9l9U5/isaZ+uE=;
        b=VCIoRanJ2BSoE96u/1A8Sh/MjKBNZOlFe6axmVbKRJpSN5et6ww6OxWHsYRv20kLos
         fDeRLhVXN66pcYfCZ8b95qLf2djCsxLD43qN2pdmpoie+a4poE/4ta1yzu0u4yU2zlQD
         Vl7A8lEJsjoPFz3Xr177Yku9/ocjKFVNLH4uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwpNndouEqIAQ7+k+dkJbISEfrceAc9l9U5/isaZ+uE=;
        b=Uz5XPiE5OC3tEcLP6KHH769/l5v/fYtse0lHxpQ6gzrv2QMkrR2aAEdyOLyLceAYaQ
         ijprnVr7cYeYwyFaT4Hazj4MSaZy5ovFbTlbL2mWM2dQHCuqvQ4ramWHmWEGTiPsGd5D
         g+WH5VS9OUt60Qe+Dfys9gCQKTwjiD9aLbWYOZp0SkKKwm27XA+zjvG7GZAxJyW/+tBM
         LQuh0k5LCXFEWiSWSOV/I/yzG5p0fXJJXV/pSgFVYznRHDosMIfubAxdldYMeuxwBIdW
         6MAXGUqNjySeDPmmGRA7F3wWhOBki0+mAbCZCA5tROoH5rLmPRLux3FF6N19EoBm0ite
         0jyw==
X-Gm-Message-State: APjAAAX9aCrw5r0AsRBgBzM/0mkjllItd0QiNImB3nnQxvvpW0KVodyz
        PafgzMRWICa49wqz5dDqPSHmXNtexyg=
X-Google-Smtp-Source: APXvYqz/CTciDrxGTxRp04DdUo/m+3MruwD5xSYd6q4X31973VHmL2ABhVgRBS3/4EoAhTvr++7DIQ==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr6177870ljj.235.1574878810071;
        Wed, 27 Nov 2019 10:20:10 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r7sm7465924ljc.74.2019.11.27.10.20.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:20:09 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id e28so1344860ljo.9
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 10:20:08 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr31883187ljh.82.1574878808221;
 Wed, 27 Nov 2019 10:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20191127002431.GA4861@ziepe.ca>
In-Reply-To: <20191127002431.GA4861@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 10:19:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
Message-ID: <CAHk-=whUhSMUfCoAmk9YsP-R28a7+_Lda780JOfeVTVeopa_Fw@mail.gmail.com>
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

On Tue, Nov 26, 2019 at 4:24 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> There is one conflict with v5.4, the hunk should be resolved in favor of
> rdma.git

Ok, so no need for the (now two!) xa_erase() calls to be the
"xa_erase_irq()" one?

         Linus
