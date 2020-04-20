Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883711B01D5
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTGwJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTGwI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 02:52:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53870C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2020 23:52:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b12so9727816ion.8
        for <linux-rdma@vger.kernel.org>; Sun, 19 Apr 2020 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTN0Etd0QTtHC3Kctw5TWjwXgkC2NCT+z5h45jcHEk8=;
        b=DmTEDWoy6i0eg5b5thUjJAPi+1glCHhNgT+5DBnICfH09z8YyOh+OBIPc7lzOp87/V
         9lK4E9FThQ6nCIJETkFhWM9Z96kL/nJPM9ylaXJHgjIYPDD/2hgF3QvqPLwFdVCQ1BN1
         IBBwAViqBqxrfU/OgxKOL9D3H+3FGKrIONBV34Y0CJ5XrkKzE/SXRORnEr/XUmc3ggKl
         2eV9Jt3gDHOMiMzNlEWQ2cQyA7UcDgsdsCGpG3i4wxCvO3nh5XYGFLLZJDGsTO82ewzL
         Sfo1zksetBajEpfxgRIljvzs6/e/aP68IzVjC/O3iEVWiy4YcvT4LMgxpfQ4W/aihoq0
         4vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTN0Etd0QTtHC3Kctw5TWjwXgkC2NCT+z5h45jcHEk8=;
        b=YrZyFluAbzTIjNMA24dutOZCqYyYjGwd2v2s/QPqTyW4Kp7vOD9v1gOAZUYQboQxiv
         bXYsXGMzzSYENGzpggzamlABtiXcwBtUqY4pzUDtkvUww99cAywQ5z5cM9twDGyIBPxo
         kAzZdUMaBb7EjhmhqFApeeVycdtIjeemWafbLnWP8qSxsmqapevYfcK/VmtY+/pfSahQ
         6G2NhFTqY6Dxr7JLcWFkxGjV2Jp2l6isncyWq15/Bbhcnp5MaFBwJfN6XFQkyc8OKxUC
         bVMwEimraD9sCdNrbRe0d9X4MRgzsIYuQv4+ffb4SRNMUy30hmTeMe7Vv7pLu8dvda9O
         JzGQ==
X-Gm-Message-State: AGi0PuY6Ogm3sFOac7rqYq3Cm8KH3gihNfhUTVUVca/oeGFgJzSllvsd
        QqFYVyoq52O2ULKu9n7qz1EA9FcXzvUf47uNbBtgIPSJSHw=
X-Google-Smtp-Source: APiQypJGCkxSnfUi8KAmaAvFO0CCmdGyo88P4nt/FXTGFk5sNs2abAl+GIV0wh3fIg+Rb44MSCcCeU9ZjcbFwW8Sy2U=
X-Received: by 2002:a02:710c:: with SMTP id n12mr14528166jac.85.1587365526810;
 Sun, 19 Apr 2020 23:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-17-danil.kipnis@cloud.ionos.com> <5fdaf1c6-1445-79af-9b1f-3c1bd9b9536a@acm.org>
In-Reply-To: <5fdaf1c6-1445-79af-9b1f-3c1bd9b9536a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:51:58 +0200
Message-ID: <CAMGffEkRJRFFO21nntkeJHE5BOon9GMdR7XnnxxRMacHh6FfMQ@mail.gmail.com>
Subject: Re: [PATCH v12 16/25] block/rnbd: client: private header with client
 structs and functions
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

On Sun, Apr 19, 2020 at 1:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This header describes main structs and functions used by rnbd-client
> > module, mainly for managing RNBD sessions and mapped block devices,
> > creating and destroying sysfs entries.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
