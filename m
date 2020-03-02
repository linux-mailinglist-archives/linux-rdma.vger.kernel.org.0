Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F01756D6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCBJVo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 04:21:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46108 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCBJVo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 04:21:44 -0500
Received: by mail-io1-f67.google.com with SMTP id x21so6167968iox.13
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEFkAcOGrFGZ9vC9gz7pgwP4iGIBCbBAbgqfhx1gxTw=;
        b=bjgepMjfTFKXiH1y1++pYmtaMgK1a0pm8g+Ft3bErJmRX5ndF/6c1HPBfqB7wtFxjY
         DHMWCTs/SdahAbFmr+r4WGKUqRK2cyniIbH2M63ygpdtoCxbQ2BsrkT/n6SSs7C6yidl
         glVje2Z6MqVA4pYo7ozPfH6s6Wab5g8Sk8iTFMQ+06NdrJ4ODeG/JpTN2/PbNEhl04zB
         2ufG1v660T3sJwb1KFARccsdBu6L5s6QKGya6JjWjFOCDCGejKBQCBacT+CW6xZRYhrM
         uNyNc09KXk+RfMP5vC9Y9ohoYS4QcNmOe0ihBiYvjXAiRFiDPORbEB772+kDOpE2wrMw
         LVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEFkAcOGrFGZ9vC9gz7pgwP4iGIBCbBAbgqfhx1gxTw=;
        b=o5N5acJjAqwT2QQJIDaTwhTL9JWsuQr9giHZy6lcYScHCW4yEGvjZz6Kx9zpJYCRWO
         cD5Bd4Hd8jlYPP4O+Pi40oNOjRVKzwIinOxjWdPFYFzDx01Mg/izYkCN4FqTVE0neGtT
         e3ToSQsNGdiQ04ykGNWfar2VDppWJPrvj6qb0N0lho1cU7RyaeR/N9EFr8HjqagQQcXc
         Qgd37Ep/h89NlCs1lAmnaZxyJb/g7cpgfw3rMV9OlCEDUhxVXbQbCVlFm/NyaUpVPeGp
         JtQAHKZP5b1SBMCsAq26ozHAeDAgPNpOkNn3kZc9QXepQaFyRjHRCqd5Bi2A1VacLtDf
         KoKw==
X-Gm-Message-State: APjAAAXOaJusmOdHhYmwHL90eLdtE31SBfgg+N6B3K5Ha0WHjfWdjatl
        5cYbparVIYDv7bRpKMJNdwSatIj51s1mSxCftLVwJA==
X-Google-Smtp-Source: APXvYqw3sGCat8h4DoLmpdadvgGUNsDTGZi83wNh/OG/n1D9udk1A3xJIq3u1cRwZ/fnRXsnHyS9RofYxs6lCYqbjeM=
X-Received: by 2002:a02:3b24:: with SMTP id c36mr13317752jaa.23.1583140904123;
 Mon, 02 Mar 2020 01:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-4-jinpuwang@gmail.com>
 <60d1b3e1-2da6-90ae-1e0b-1c313ffbd9b0@acm.org>
In-Reply-To: <60d1b3e1-2da6-90ae-1e0b-1c313ffbd9b0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 10:21:33 +0100
Message-ID: <CAMGffEm5vueNV7jW8hTWT3SR2qgPTNuRZg7k3kDGu-KGAcLqKw@mail.gmail.com>
Subject: Re: [PATCH v9 03/25] RDMA/rtrs: private headers with rtrs protocol
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

On Sun, Mar 1, 2020 at 1:37 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > +enum rtrs_imm_type {
> > +     RTRS_IO_REQ_IMM       = 0, /* client to server */
> > +     RTRS_IO_RSP_IMM       = 1, /* server to client */
> > +     RTRS_IO_RSP_W_INV_IMM = 2, /* server to client */
> > +
> > +     RTRS_HB_MSG_IMM = 8, /* HB: HeartBeat */
> > +     RTRS_HB_ACK_IMM = 9,
> > +
> > +     RTRS_LAST_IMM,
> > +};
>
> This is the first time in this header file that the abbreviation "hb" is
> used. Please add a comment that explains what this abbreviation stands for.
>
> Thanks,
>
> Bart.
Will do, thank you
