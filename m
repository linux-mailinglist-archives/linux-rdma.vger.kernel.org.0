Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3450512FA31
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgACQTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 11:19:52 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45451 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgACQTw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 11:19:52 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so36958289iln.12
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05YrvVWWk/rZpAFGYlfJ9p7bDX0zz0zCE+5tItikZfU=;
        b=Nv+QYmAf83A9eeErqft4+JNO24vhDOKS3zlOVz8dAGoyHDiLftgoqMKaJCgyFYhqL5
         czZyHtXFPnj8DrLHX1UpX64zE1phGGImVeNAU5sqH3UXwMkREeFAIfHtjwS7OErAZa1n
         njhzTi4cuzht+uDYEtKYj2lk+VmX7pWxOd5PYLKsPW+Q2n/E+Jr9190HxUWFkiuC+KuS
         J16M49nhNMZMEkKZRHPCtqndCOVAsneD5rJ+0KUjjtZ33FFX7SYWMoaNk0OvMQR9guSi
         HKhbXGAMo3KKNidvEqCISwqsHzUXRxSbMAAhFXRaQxTna1F6hQYLTs0HdAEtQBp8d+lO
         E1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05YrvVWWk/rZpAFGYlfJ9p7bDX0zz0zCE+5tItikZfU=;
        b=PLYWFqWQ3Ec4ZjF9gRqZBhycePO/gLIngvTgCzvuZ7xt6cFhdE3iykUzbiKQb3vVB5
         7tUT3H0zouN/kCZUXFybzUsGupxBCqTj+13WuUgQgdyP5rFhCoh6ta7jC/33Rh+IIsA/
         uEdYp7UYUQlThd06oVcPXDv0To9Jr+2P7dHB8E0E/gqNg++lAXdGU8gAjjdwccFcshbK
         j5sOqozrEE2jfqLeMOGukPknXxS+FicVBDx8LXcLYR/HL7Y0jHMxp9j1eiNN4vIWngbj
         APiNHctdoLxrG4SFp0UiS2cJND6/75K6YC3sMGMdn6vFbezxo21Bj+DNxIpNVBc7SjWS
         V9Gg==
X-Gm-Message-State: APjAAAXufNvgiNVCN1zVGilI7bOeGfQMETfsOSVspwdw+LMVWXDMXtRj
        gxaEck4mOp6/5QZsOQjxT4iqA/6aEZEPYBI1vxI5nQ==
X-Google-Smtp-Source: APXvYqzovU0uBZ8ftzlLa62V+oIwtTpAa3pkdA26wZQ8mkNz8WV1vZilOv8yUwml4zAnr0ro4Ji8+WZoeAsDpn0EcK4=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr77578935ill.71.1578068391465;
 Fri, 03 Jan 2020 08:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-14-jinpuwang@gmail.com>
 <81414f0d-ee6e-9477-ef85-12476faa257d@acm.org>
In-Reply-To: <81414f0d-ee6e-9477-ef85-12476faa257d@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 17:19:40 +0100
Message-ID: <CAMGffE=6Zvu08qeWCiK6poa787V+OcNQ+71ivdTiGK0mZu-z5w@mail.gmail.com>
Subject: Re: [PATCH v6 13/25] rtrs: include client and server modules into
 kernel compilation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 11:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +config INFINIBAND_RTRS
> > +     tristate
> > +     depends on INFINIBAND_ADDR_TRANS
> > +
> > +config INFINIBAND_RTRS_CLIENT
> > +     tristate "RTRS client module"
> > +     depends on INFINIBAND_ADDR_TRANS
> > +     select INFINIBAND_RTRS
> > +     help
> > +       RDMA transport client module.
> > +
> > +       RTRS client allows for simplified data transfer and connection
> > +       establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
> > +       READ/WRITE semantics and provides multipath capabilities.
>
> What does "simplified" mean in this context? I'm concerned that
> including that word will cause confusion. How about writing that RTRS
> implements a reliable transport layer and also multipathing
> functionality and that it is intended to be the base layer for a block
> storage initiator over RDMA?
Sounds fine, will explains what the RTRS abbreviation
>
> > +config INFINIBAND_RTRS_SERVER
> > +     tristate "RTRS server module"
> > +     depends on INFINIBAND_ADDR_TRANS
> > +     select INFINIBAND_RTRS
> > +     help
> > +       RDMA transport server module.
> > +
> > +       RTRS server module processing connection and IO requests received
> > +       from the RTRS client module, it will pass the IO requests to its
> > +       user eg. RNBD_server.
>
> Users who see these help texts will be left wondering what RTRS stands
> for. Please add some text that explains what the RTRS abbreviation
> stands for.
>
> Thanks,
>
> Bart.
Thanks.
