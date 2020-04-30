Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF121BF1B9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgD3Hm7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgD3Hm7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Apr 2020 03:42:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF9C035494
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 00:42:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so712487wmc.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yj3aOOAITkSoQ9HT/kLSsxXrmoC54MHhQnwfKg+EFsA=;
        b=Pm0gae2WWQGHGGGGOdaSVHtCmsA3TKcvgr8Nj2+qIsy2aELVcARV7qCd1ZjvJEtCOm
         IbAmWIeKIhTLUxDSeh8VESrrbt3Ygn2crA0bwve3VtBx633ubS3cEfqPlO2wWQOY5Nyz
         Tno8w9QwO+9xz9CppDJqIb4qnllco8yeygNgsc8FRmjR71xzM/6ubeb551WtgtYcTm+h
         owYpjqttcka/D0/FP7xQIfATN3FEValTX9qyiPQNUpbr3A9MhvN0yejJ0SHcBcaxiOCt
         okM0y78WXX4bpPirKvDRd6VJjGX935ZDzSQ7qMnfAFh15LDEfDtdum4d5oQTMSROTdIY
         YCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yj3aOOAITkSoQ9HT/kLSsxXrmoC54MHhQnwfKg+EFsA=;
        b=RcahGxvgBI8imRRD6Opq8t7xG5NHW7fMMbtBMzM7DNfO5+ux6D9Gu+tkcn4wSiq+dB
         YObb3S3R5H2uRoUaOkPicZf0jho53L9ID1sNARi7/uTR61UjJXpiXdowfvVYpwNUdMqR
         zRbtedgQcJB4+qzpOK32uTz0ywD/CsgEGt65Gz+DJcWx/cAstoaD5tP98EahCvBshhPA
         fDirq6ZcovgBMPuYV/Gx0tU0oY8pIQMUQGsgtwtelYxiZdJzt68qpnHx7c6IttYTPIlI
         mZWn02xmw29pqM9WVyaJsyRJ3zHMTzuN0Ol5qJh+VWbG3C9vX2igORm0kcEQottUtp9E
         z2kw==
X-Gm-Message-State: AGi0Pub1VLPJaHGNX0Dc7LHSIbwZg/1loe9QWST12CHvOWzrmbUN35at
        BIYHhiW/g40nFqWZdf7O1qbZrdeCRZg5G49ALiVu
X-Google-Smtp-Source: APiQypLeP/hDfEhBONVBBPo4+ko5WjkMd4EvCY7nuPRLYRkKNJYDO0r9o+eolLYaXHwTLn8a3SMcctnUtcNSRYJt06E=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr1403256wml.166.1588232577086;
 Thu, 30 Apr 2020 00:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-24-danil.kipnis@cloud.ionos.com> <20200429171804.GE26002@ziepe.ca>
In-Reply-To: <20200429171804.GE26002@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 09:42:46 +0200
Message-ID: <CAHg0Huyvt1P1To+fxn3RZdGXJfnQXpNxJbpNxquqLw_KVtcDKA@mail.gmail.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 7:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:18PM +0200, Danil Kipnis wrote:
> > +rnbd-client-y := rnbd-clt.o \
> > +               rnbd-common.o \
> > +               rnbd-clt-sysfs.o
> > +
> > +rnbd-server-y := rnbd-srv.o \
> > +               rnbd-common.o \
> > +               rnbd-srv-dev.o \
> > +               rnbd-srv-sysfs.o
>
> keep lists of things sorted

Hi Jason, I understand you mean to sort the order of object files
here, right? Is that the reason the kbuild robot couldn't find the
rtrs.h include file?
