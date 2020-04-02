Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7D19C70C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDBQ2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 12:28:02 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:36129 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBQ2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 12:28:02 -0400
Received: by mail-il1-f181.google.com with SMTP id p13so4211601ilp.3
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LWQRzvGUf0Noo8gQmhIsnF90MWgcXs+EjcH83IaZZI=;
        b=cyAtrTVxn8FFy1qj++2UDFQvNzskVPe9VtPrHb+clKTiQLHHTU7tnza2uSu0zk2FMB
         QQxzhOvv99qOh2WZfAaUZM5I8TR7QgTxWA3Vy7e6s1UZ/lyxX70FbQ+Te56n0awso5na
         Nnqii4V9Rvu2TeK/7ZT1EgLkDsa0TDBdp9LEe20Pv8j3yuOxKxwwNZEP7JU2kjAl7/EN
         qgTizy2VhBStl+hR3noLJhwKet8yeXuqRSqntRO4Gqx90IDDnWiVm8QCnIn5WNczDXmK
         wsp+sFaam7gmn0IyAFw5t8qzz+ogRRPlJodVPDvDSGNzNbR1avKF8PwshzpV7OXS5oAA
         0iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LWQRzvGUf0Noo8gQmhIsnF90MWgcXs+EjcH83IaZZI=;
        b=Szb6lCmM2SPhRlu/SqnAZ5mfM+xwLjy3D1SIEpkrvEBhWHL6wmW2R3HpYrNIUwyR7k
         hsH9iBG/AoJkMzfP3HDB0xyaYKg5sYI9g8ZxJUVGSe1UK+E0dpgVGIFalAi2z8gT4W3k
         0PXSE2HwFRgUE5U8Kx1AEdmqcpxv8auHytQbYKbQVS+TS03ExDmx/WwqNmAEUe634FSZ
         YyaM7a1AEpm58stEqdjM2/HvevLxjNZ8nfk/cSFSJuFHNYwx+mCpl4kNkKuAT3P+dBCD
         FlOUVGrtryvf2mnOkA72aib0SpzMmYvuLOmRec6XK9uPd4ia+Iaec428Zu0L9Ar/TmtW
         hyiA==
X-Gm-Message-State: AGi0PuapccJW3ZWF4F9pd/kt5ozCP+cO0gDy4C04m7YGiWFKzFP7kEL8
        MROiCfeyq7DVqSr3tnJSEBpd9rQZnLtPfDmIvqDyPg==
X-Google-Smtp-Source: APiQypIsUTohrvKHniCIy83q9ah4PZqWdPsXTTnRHexEKhHjSG91k73rGGZj9Uezdib+zAGJMz9OH6yGZwu43ziQb2A=
X-Received: by 2002:a92:8159:: with SMTP id e86mr3907587ild.60.1585844880822;
 Thu, 02 Apr 2020 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com> <198cd2da-cbf8-17b0-3ee5-5dec366a43e2@acm.org>
 <CAMGffEk1WA114u4KR8_UAUoUvpafshZkhxEYuxg6UcQpZid0qQ@mail.gmail.com>
In-Reply-To: <CAMGffEk1WA114u4KR8_UAUoUvpafshZkhxEYuxg6UcQpZid0qQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Apr 2020 18:27:50 +0200
Message-ID: <CAMGffEk3R_egv5ry4mQ3LDEPMHXkSzV9_SaVJ_83q5Xu-++-DA@mail.gmail.com>
Subject: Re: [PATCH v11 18/26] block/rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > Would it be possible to use the .get_budget / .put_budget callbacks for
> > obtaining / releasing a "permit" object? I'm asking this because it was
> > really tricky to get the .get_budget / .put_budget calls right in the
> > block layer core. See also commit 0bca799b9280 ("blk-mq: order getting
> > budget and driver tag") # v4.17.
>
> Will check if we can use .get_budget/put_budget call back.
I checked get_budget/put_budget only has single parameter blk_mq_hw_ctx,
so it's not possible save the permit for later to release/put back the permit.

Thanks!
