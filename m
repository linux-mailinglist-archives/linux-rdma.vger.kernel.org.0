Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE119984F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgCaOUp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 10:20:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43968 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgCaOUo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 10:20:44 -0400
Received: by mail-io1-f68.google.com with SMTP id x9so15414486iom.10
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnPaVP2gBEwIPF8mfzd93scGAf3j/qK6lXY3ypX3mqA=;
        b=IOsqcPnGJWgJtyx5ZJEg50LRaTrvcqPJSh8Oc2lGtJrVisHrPyv6fnOUThIjlm/FhJ
         qSEEAEevksq9P/kXVty+lyn0fAeOBpV3zEIce5Q4gxAep4lSYigsedPKZe91E067pnXj
         uiJFL/QboomYq3hjkOx1FTEcIQ6kQ7salGCqKhwzjCt/mbOuvZS7Z/zQ16KUtIa/k/Fl
         4F/U7yyjI9LBczfSR00otULe1kQshZ06YE5blDAask2QIocxQzlb3SRvU9A3IDSST32S
         1k70f3/fozO6EB6/YoUmD0mPYTnAe30BEQHB8c0Q1+Vv6K5tlzYmFEBmzmiidMnLalsE
         FNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnPaVP2gBEwIPF8mfzd93scGAf3j/qK6lXY3ypX3mqA=;
        b=l9cqdpjtQgvS6YFxRtVMqk7XXVomIiceUrSvydwruFwLZ1qNOKBltLVj5vwW6BCIXI
         8IJH37QJ9jF36OUU/lqsiO5VtT1JkpLRnHBq16RYHQeDr/mNGYVQa4MigvQ4Bprf0SUV
         TqjX3A7/qVLY6+uV0YAgC4xT2uhUqKVSwjjtcpvvtFC4Eutt1vbE4ONAn+UiRaHL0mna
         6AnUzrpTIdhtXG44837sgLHyRHyJTubVn11gJQ4L8Vyo2vUGnKUwRFoQPCNUk9QZsYAF
         +FWL10zwsySFvzHe3RDEA5JgTFXlfbsGEEcNnhU+U9K5UrLTG2tSlBjVARwMDtwQnQt2
         dNSw==
X-Gm-Message-State: ANhLgQ2yinSmbXHB/12QDZ/MQedVFgpdfYPbZkxWxJDt1unaqj3vOqnO
        oJmp6Xq49KPSdSGKYcD4ffegpuKBX6WQWnCnKZKftg==
X-Google-Smtp-Source: ADFU+vtVgS5vr/ydr7uBVhvdFJEto7dqmOE9+vHSWzFR4/gsD6YOozE+HaVT0inaiIKDNDfNkaiVxO02iNO9/4BjTRI=
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr16588167jas.37.1585664443040;
 Tue, 31 Mar 2020 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com> <27b4e9a5-826f-d323-3d19-3f64c79e03eb@acm.org>
 <CAMGffEmWPyBAHWJpkVvWuptgoX0tw4rs4jJH1TuJ0jRrkMBdYQ@mail.gmail.com> <a02887c4-2e54-3b55-612a-29721b44eb7b@acm.org>
In-Reply-To: <a02887c4-2e54-3b55-612a-29721b44eb7b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 16:20:32 +0200
Message-ID: <CAMGffEkeVHm57DgTD_tXQNjuNx152PmGLum-cNS1X6x=5eysGg@mail.gmail.com>
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

On Tue, Mar 31, 2020 at 4:13 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/31/20 2:25 AM, Jinpu Wang wrote:
> > On Sat, Mar 28, 2020 at 5:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2020-03-20 05:16, Jack Wang wrote:
> >>> +     /*
> >>> +      * Nothing was found, establish rtrs connection and proceed further.
> >>> +      */
> >>> +     sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
> >>> +                                  paths, path_cnt, RTRS_PORT,
> >>> +                                  sizeof(struct rnbd_iu),
> >>> +                                  RECONNECT_DELAY, BMAX_SEGMENTS,
> >>> +                                  MAX_RECONNECTS);
> >>
> >> Is the server port number perhaps hardcoded in the above code?
> >
> > Yes, we should have introduced a module parameter for rnbd-clt too, so
> > if admin changes port_nr, it's possible to change it also on rnbd-clt.
>
> What if someone decides to use different port numbers for different rnbd
> servers? Shouldn't the port number be configurable per connection
> instead of making it a kernel module parameter? How about extracting the
> destination port number from the address string like srp_parse_in() does?

Probably we should do both, the per connection destination setting can
over right the module parameter if both exist.
>
> Thanks,
>
> Bart.
Thanks Bart!
