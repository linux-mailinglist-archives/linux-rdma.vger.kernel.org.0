Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28874C0311
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfI0KNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 06:13:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45766 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfI0KNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Sep 2019 06:13:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so2027362wrm.12
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2019 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDHMnW1NJitbZSytC+0aQ9Bkh/hdcZN/s3YmRoZCQ/M=;
        b=HK7BfQKrG8aeB/i+dT99yhmwOeIvy5SErCSd8m+RxhCvHSL0TqhaQYA3QBsapvW+Vo
         zsKDU1Z9OHn8xXAejKW0NpoBHv89nSeMUx4hTVmRtEi1F/HmNppJwCJBl4U/PATfbBTB
         CBiYcGSqTokD3ksgyYWiG6EYx2jqjr9oTfvhmt6OKuoduj/ZSX72xpVZs+ZwEI2LXUSi
         5OsA3FYQ6qauPtfSZEdrjZUs3YLctxgrr51H0pxf0nG0Y61Nyg0g7aKzh9iCu9AFNTC9
         d1GKlR7616Hf2rB/StIX7e+25nexFvGyhjHYWAqybHUhODw/J7050jTtgIZsM37loOKK
         xcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDHMnW1NJitbZSytC+0aQ9Bkh/hdcZN/s3YmRoZCQ/M=;
        b=oAQCL65BADsL28DTaxOZvdpJxEmERaebkC4aprDjOI1TyjxSTkP+e1++ZEQ03u5CTm
         77ttEFxJ3XJqFGwTmwr5OiQUSEwZUE6XQYmoFRnZAJu0dvmTVEPQD2Bt+68ZO2p3ixu4
         S9XOtTsC5xVAgkNCkTlg6QgwslocrVwXfvDYhzlxsV4aMpKoBlF1KZo1KWNCEGj3ugcX
         zNQrS9xGubAXMI4amAccTcSsBuFyadnQWGcKVIqv6uK9Q3ndD+CUDJjrDTyvkTaY7Byw
         CLZR3DmeqH7WaLeRuOBULGm7AIvqWrqZ1/7yvCQS8N9lEze06nFBGOfNC0UZ/QINkKhw
         rQrg==
X-Gm-Message-State: APjAAAVdJTFsQ7Rmf6nwxwiYr4PeZmd66GkyRDbbXTzSG97LijfOQ+2Q
        P/3HzYP0wNyyjEytOCoeYH/7OqlMGaLkOjJhbygRdw==
X-Google-Smtp-Source: APXvYqxfWzRagkeEMBMLs8gOoYAwpn8TJd/NWWaMNMHsP9Ji4BgOgT8ZExq0tvTFDdp20Rcw0nEB1u8V9m8FJphfATM=
X-Received: by 2002:adf:f406:: with SMTP id g6mr2209918wro.325.1569579210631;
 Fri, 27 Sep 2019 03:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-5-jinpuwang@gmail.com>
 <f511731a-f981-8cd0-97df-03105a105b36@acm.org>
In-Reply-To: <f511731a-f981-8cd0-97df-03105a105b36@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 12:13:19 +0200
Message-ID: <CAMGffE=QOpec+J0WZkrncqVHZvO3htZdCeBY-uHYJMixrO3DCw@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] ibtrs: core: lib functions shared between client
 and server modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 24, 2019 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static int ibtrs_str_gid_to_sockaddr(const char *addr, size_t len,
> > +                                  short port, struct sockaddr_storage *dst)
> > +{
> > +     struct sockaddr_ib *dst_ib = (struct sockaddr_ib *)dst;
> > +     int ret;
> > +
> > +     /*
> > +      * We can use some of the I6 functions since GID is a valid
> > +      * IPv6 address format
> > +      */
> > +     ret = in6_pton(addr, len, dst_ib->sib_addr.sib_raw, '\0', NULL);
> > +     if (ret == 0)
> > +             return -EINVAL;
> > +
> > +     dst_ib->sib_family = AF_IB;
> > +     /*
> > +      * Use the same TCP server port number as the IB service ID
> > +      * on the IB port space range
> > +      */
> > +     dst_ib->sib_sid = cpu_to_be64(RDMA_IB_IP_PS_IB | port);
> > +     dst_ib->sib_sid_mask = cpu_to_be64(0xffffffffffffffffULL);
> > +     dst_ib->sib_pkey = cpu_to_be16(0xffff);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * ibtrs_str_to_sockaddr() - Convert ibtrs address string to sockaddr
> > + * @addr     String representation of an addr (IPv4, IPv6 or IB GID):
> > + *              - "ip:192.168.1.1"
> > + *              - "ip:fe80::200:5aee:feaa:20a2"
> > + *              - "gid:fe80::200:5aee:feaa:20a2"
> > + * @len         String address length
> > + * @port     Destination port
> > + * @dst              Destination sockaddr structure
> > + *
> > + * Returns 0 if conversion successful. Non-zero on error.
> > + */
> > +static int ibtrs_str_to_sockaddr(const char *addr, size_t len,
> > +                              short port, struct sockaddr_storage *dst)
> > +{
> > +     if (strncmp(addr, "gid:", 4) == 0) {
> > +             return ibtrs_str_gid_to_sockaddr(addr + 4, len - 4, port, dst);
> > +     } else if (strncmp(addr, "ip:", 3) == 0) {
> > +             char port_str[8];
> > +             char *cpy;
> > +             int err;
> > +
> > +             snprintf(port_str, sizeof(port_str), "%u", port);
> > +             cpy = kstrndup(addr + 3, len - 3, GFP_KERNEL);
> > +             err = cpy ? inet_pton_with_scope(&init_net, AF_UNSPEC,
> > +                                              cpy, port_str, dst) : -ENOMEM;
> > +             kfree(cpy);
> > +
> > +             return err;
> > +     }
> > +     return -EPROTONOSUPPORT;
> > +}
>
> A considerable amount of code is required to support the IB/CM. Does
> supporting the IB/CM add any value? If that code would be left out,
> would anything break? Is it really useful to support IB networks where
> no IP address has been assigned to each IB port?

We had quite some problems with ipoib in the past, especially neighbor
discovery, from time to time
we encountered some IP are not reachable from other hosts.

That's why we want to have AF_IB support, which doesn't reply on IPoIB.

Thanks,
Jinpu
