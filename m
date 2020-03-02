Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC2176019
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 17:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCBQhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 11:37:14 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35123 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCBQhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 11:37:14 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so82632iob.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUwJFOHIny8Wvu7PLpqOuE2bR34bAgL0os8brnYjmf0=;
        b=RO+4wjvF0xYL0dSmTu0pBrPBX2y9kwTNQida9W505FBOq5ToUDCrKC602NKbVTFivx
         +70otg8lIjLLDnvsZwqJ0sFygw/PBIQQsG/r9jkGGnmoB1LwQSzjmiNe7Yk0fb5F25wL
         ZUzJZGEHWpurJfHOM42GL70qak7QarVwT0yKYXf/urexcTCBGnjhiRH6uj0zUyR9ymJE
         yAisRJJmsOwc6YuGN/oTsQ0mxmgyIx+blISeSMXy6AgdXazb1c+9YEv9p8AsTvHviS4R
         qs1/h4X2QC81UA+fqBrcmX1jqJyN+8br1eg1zbo7/fOsyUDDE54zptyquMXWwejTyu5y
         ux5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUwJFOHIny8Wvu7PLpqOuE2bR34bAgL0os8brnYjmf0=;
        b=f4qUuuI/zw4C2QZY5d+tMlxyytnK+5FAevzxvP3Mn5OeLWqT+ChS5/qT5iu0Hr7uPc
         RgRPx1zDcZ0YhB6AMppzyGmPlyShBcbRhLw3J47WKkaKD0hooWvU+zPSSl6stEBv1kyU
         sDo316h15lfs0C7tAyp4t9K2krbAyLcfrDXpGVfIT0RFOXC5l+IkBt2rAvsZVRXB/+gV
         fJA+Zs7ixxvcwXWc3qnshAyooMZDYnTVn4XUijMitdffpMt46UASfrQ+nzHjSvwZbBi4
         cDBbK2n/36w/IilYTaxn516py1bpWPFI/kY48A3nEiYl61gJRcaCxwqoWc9tJs/UImWh
         zigA==
X-Gm-Message-State: ANhLgQ1fq1a0LcvU9G0biAVLk+t+A05MCamIJRTdtyJlrfmGGY3pcLQ7
        x5/B6J8d9qZGzn7Z0xzVg0y04MfrI+74csz8+LLOWw==
X-Google-Smtp-Source: ADFU+vvE24Kbc/c8Y/XMRlL4fc7Tqkl4w/eq7idYA5x8i/8IYxALP/dHS4htvWW9fFmCaImgHdbRxswM3m8u1hmW39A=
X-Received: by 2002:a6b:6814:: with SMTP id d20mr304596ioc.71.1583167032668;
 Mon, 02 Mar 2020 08:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-16-jinpuwang@gmail.com>
 <ef4e45bf-f4fe-99eb-68de-4e4aff415c67@acm.org>
In-Reply-To: <ef4e45bf-f4fe-99eb-68de-4e4aff415c67@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 17:37:01 +0100
Message-ID: <CAMGffEmj8MihGW4+wwJNgmnyFLM96AOq8YbxRPqbDGN4gDakuA@mail.gmail.com>
Subject: Re: [PATCH v9 15/25] block/rnbd: private headers with rnbd protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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

On Sun, Mar 1, 2020 at 3:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +/**
> > + * struct rnbd_msg_hdr - header of RNBD messages
> > + * @type:    Message type, valid values see: enum rnbd_msg_types
> > + */
> > +struct rnbd_msg_hdr {
> > +     __le16          type;
> > +     __le16          __padding;
> > +};
>
> Please add a BUILD_BUG_ON() somewhere that checks the size of the
> structures that represent the wire protocol.
Ok, will do
>
> > +static inline u32 rnbd_op(u32 flags)
> > +{
> > +     return (flags & RNBD_OP_MASK);
> > +}
> > +
> > +static inline u32 rnbd_flags(u32 flags)
> > +{
> > +     return (flags & ~RNBD_OP_MASK);
> > +}
>
> No parentheses around returned values please.
will fix.
>
> Thanks,
>
> Bart.
Thanks Bart!
