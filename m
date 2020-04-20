Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626861B0213
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 09:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDTHAs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 03:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTHAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 03:00:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1231FC061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:00:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t10so8670330ilg.9
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXlpspJEbDHoQKzTWZ7OoJ0DmgN59WGOBFVzZ9ECAqQ=;
        b=MgGtdqwvkxDCWV/ys6L9qG4ozrCBAixZ6iysWCPYpc/7PZKSM43UYUnXg8tVZVxZll
         Xfde+dd8EVxYj8DBhtERhrbDBVu2ZKs4wMpj/imwAxmcZkrEuAEsFf6ZDl4EbGd1ICJZ
         n0HeyCNKixRjOGN/dGYyVLUhsmD8iB0bJIQfNQvJQtZdWZHvel9Vf9dcQ+tmlz04pEZl
         S0q3YxBkqFOqwMPcUabyzqcoZlys9Qof4QqYbV5O340sHLAsZx+/toOXDO9dzmGSrEpl
         /MnoP5VMxTmJhF97M+Trvz36pc9iP5ls3Lm6RR7nKKFQW3yjnzrakoz8kCdQ9zssp+OY
         SeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXlpspJEbDHoQKzTWZ7OoJ0DmgN59WGOBFVzZ9ECAqQ=;
        b=ntpAdDvxnFMl2fxaoMWG0HpVSIeySYHNB3Zn+ik0uXC9ktCdBQ/PBlmCETOOrDL61i
         RwKeTMY2LFFbKm5fBr2p7fHc84c8LVp97FxBL25PMu+QY4t3kFuzfgcqEAWB8XTnmHBX
         JBAHbW4eFBdps34fUrQDDW/FdwoDHRhQwHCNSirSJLAjfKWrKgrcrMzgCgERi1447h1Y
         6BKlo9Tp/YlrnmOZozboRpuc5uq0P8xrBn132tiz/CfvywKj7vTrBORyxw52nCOmV2dY
         cLrRN/LNMD6tOZZVk3vvkNiYecz0yj6Oyik1LNWf3SNiaPLfTtofUiF8ezHHptlSPjLk
         sT8A==
X-Gm-Message-State: AGi0PuZGRBZlNOh2G9yPnFmdEmh4trUQGqnDKBS/78/E/tlVHWCH4vu6
        pLTbj3/HX0uJEyJOgOEms8PKSLimT6Jw+DhEKpJ/vh3t
X-Google-Smtp-Source: APiQypKVKmZRHiGPVWXVvY9+klgoFYg/ZzKF0xk1aCtXv/786RkD707yD8EhFnvTqR/eKHRQnf43BmUs5pj0hn8e1tg=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr13961843ili.217.1587366046506;
 Mon, 20 Apr 2020 00:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-23-danil.kipnis@cloud.ionos.com> <0b161f96-c6de-ff6a-e71c-b0e2e623105a@acm.org>
In-Reply-To: <0b161f96-c6de-ff6a-e71c-b0e2e623105a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:00:38 +0200
Message-ID: <CAMGffEm+O8tOTDuZX++T1mDOJA4GuoT9xZMNH83JTNfJk4uPBg@mail.gmail.com>
Subject: Re: [PATCH v12 22/25] block/rnbd: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 19, 2020 at 1:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is the sysfs interface to rnbd mapped devices on server side:
> >
> >    /sys/class/rnbd-server/ctl/devices/<device_name>/
> >      |- block_dev
> >      |  *** link pointing to the corresponding block device sysfs entry
> >      |
> >      |- sessions/<session-name>/
> >      |  *** sessions directory
> >         |
> >         |- read_only
> >         |  *** is devices mapped as read only
> >         |
> >         |- mapping_path
> >            *** relative device path provided by the client during mapping
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
