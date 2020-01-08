Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3E134809
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgAHQdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 11:33:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33780 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgAHQdi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 11:33:38 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so3902055ioh.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0qG6NRLqy7mvD6qvWnV9Y3yuCIMjNVmVlZXp2JZhAg=;
        b=bmjouH+xaoy8MBqnIfs6g7C1DwZUA7d0d++MibQVEEoiiyWq99Uo/+kCUoto589/6y
         Z8XWkR6sO7ZWkeS+aqqN47VO7fJr+exu1n0wuwVKOu72SkPrpNrpUQTL+BUh/XGcOkdo
         oV/+3LuT3Q77467cm59wy8p0ZkIP3mo6xlnMRwHzopwbwxlQiSQXwc5HH1y5h85BIBpP
         PVf6pEQ+A1XrjxU6MHi1vAdCgcNS56qedejnBZ5otMqZ7IZp0HjzGBANf/5MdEBblORj
         6BFra9Uj5HGAH0zuIf9MZTeC/77mBlNAwNCQimFr0229Z1h7iUuD7k3MgH8OiQSt2Ygm
         gUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0qG6NRLqy7mvD6qvWnV9Y3yuCIMjNVmVlZXp2JZhAg=;
        b=iKRW7s0yovyL0JiryU7zztromD5PvQYBQ4/tR9ANIqd1D3JcI2uBFddF3gFhwxIuJj
         sYi1dupD+PcjZeoo46dGaN/UP/eMplv5aPFEsbjJFaY8I2EXRa7I2eteGsDkLSs4E15g
         lzcJjHhOqTrWc5pMD4SoZO/ujiX5AwCDi1jg26zCjDuRt8GQhcxFUEBYg+UBux+bM2jJ
         C8PhFbjxLYk3nltK0dYgouW+t6ODGJexXDOjiumMcWRuIeFcrMbJ4l4s/bPLRuwZ2DTz
         OQeV7Rt7w3jWBUEZ9p8mac5J7vgLF8yCRzv3v8l/WwltSh8PxKFJpizFxixHB5XLz9RY
         LTBA==
X-Gm-Message-State: APjAAAVYh9rKyZ6HktkZx7+kvZpHWGjVCyuGv+Vp/RDo27fEC1JZdudi
        dMdSbmxDg66maupPeDryo4y08bctJrPjpt1EeDWoIQ==
X-Google-Smtp-Source: APXvYqxX4un718qenN/+gUObZZrZSck3SyOJJE+AABa0Mp+35gS4S1Ma/zLzbeA56VzoIOm6J/Oa9lz02gLwFXcTk8Q=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr4124290ioh.22.1578501217592;
 Wed, 08 Jan 2020 08:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-10-jinpuwang@gmail.com>
 <848cdafd-60c5-b656-1569-81644b7fc5df@acm.org>
In-Reply-To: <848cdafd-60c5-b656-1569-81644b7fc5df@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 17:33:26 +0100
Message-ID: <CAMGffEmT0KGpa5j_FsKq8tmPrjM2-aAYqvCfQaKkDmUb1o17dQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/25] rtrs: server: private header with server structs
 and functions
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

On Thu, Jan 2, 2020 at 10:24 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +struct rtrs_stats_wc_comp {
> > +     atomic64_t      calls;
> > +     atomic64_t      total_wc_cnt;
> > +};
>
> Please document the meaning of the members of this data structure.
will do.
>
> > +struct rtrs_srv_stats_rdma_stats {
> > +     struct {
> > +             atomic64_t      cnt;
> > +             atomic64_t      size_total;
> > +     } dir[2];
> > +};
>
> Please document the meaning of the members of this data structure and
> also which index (0, 1) corresponds to which direction (read, write).
yes, will do.
>
> > +struct rtrs_srv_op {
> > +     struct rtrs_srv_con             *con;
> > +     u32                             msg_id;
> > +     u8                              dir;
> > +     struct rtrs_msg_rdma_read       *rd_msg;
> > +     struct ib_rdma_wr               *tx_wr;
> > +     struct ib_sge                   *tx_sg;
> > +};
>
> Please document the role of this data structure.
ok.
>
> > +struct rtrs_srv_mr {
> > +     struct ib_mr    *mr;
> > +     struct sg_table sgt;
> > +     struct ib_cqe   inv_cqe; /* only for always_invalidate=true */
> > +     u32             msg_id; /* only for always_invalidate=true */
> > +     u32             msg_off; /* only for always_invalidate=true */
> > +     struct rtrs_iu  *iu; /* send buffer for new rkey msg */
> > +};
>
> Please document the role of this data structure.
ok
>
> > +extern struct class *rtrs_dev_class;
>
> Please make sure that the static 'rtrs_dev_class' variable in rtrs-clt.c
> and in this header file have different names.
ok
>
> Thanks,
>
> Bart.
Thanks
