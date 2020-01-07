Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B83132691
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 13:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgAGMju (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 07:39:50 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38024 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgAGMju (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 07:39:50 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so45557458ilq.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kx/KRZtLUiE++L2YxiYEthkHn+l+qZzIrlIKHMD+XQ=;
        b=V6OvFynfEVDMUA+f976XTx3OvgqBs6Hp500jxACGSOEKyHfKnnmo1Dz7MIgCrJEtsV
         THFhgxsmDwuLtTUvjSEx23wuGMGcwwBTyi5jfyw8x8ivYra54JLkTH1gOsUUN1aNDhDx
         IDGYWYUaNCJ11fEqzQ/ofVG/88NVTLaOvs5/7ks+J0GfbSBW2M1MsjMrOuDQ7llHWhey
         Z3YRSQKabrth0lnwx3ZOWN+nLFhI+bbbUdBRMwCDOO8e6mhBBkL9dOSfCXeU6KQBSsHA
         YqJYo9SjL/BQOhFKiiMtVhHE/7kzrW0gJB8P5nTdNuKP+VIIB5Iy2hkAWd/gu1f/gW9j
         z+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kx/KRZtLUiE++L2YxiYEthkHn+l+qZzIrlIKHMD+XQ=;
        b=Zltmbvvk+HrpaHcYNmCGVV0L3eera1KqxPPHm0vewvXZhI9Nm4OUSDEUenwu1gwujl
         TRroR9p6NpYbnnDfWFq/ZIOLbYfWFklvxBITECT2ltpp725MvgmP0+q4/3PMVE8+hZEj
         vBBU83lzMyvXcI558lb9GIfwRk1J6/YEq1ky5LstQHsFKfvQ8ZCMZ06obAaf8piTLyep
         evI5aKcLnYKBd67PrIpxUIRxVZDCjsXpIoJ09Pt/91jtv82uZUIvcs41wiJMQH3fSxyG
         2m30Df+y0tpq9OujpQc+CxWaJXG5H0WpLkyXE6cZrIMRVQbBzoHSby3oiALjnsrxcuPW
         rNqw==
X-Gm-Message-State: APjAAAVbJ6hbROCzNWQrIU/b8ntHW+W44c0oq75fFCvkjWwPa7r7lSzV
        JU8K1F3zxFx/G5AV0xk0piyU6y931TKgdOMKrq+bcw==
X-Google-Smtp-Source: APXvYqyFJDJpg46QGAegSLNhG2N0hYYFlfZFpwKHMTN8WfqnhtJXZy1hgg5zpalMWgZ44IZeEDagffmOOLrp7DKWbNg=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr92587841ill.71.1578400789802;
 Tue, 07 Jan 2020 04:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-6-jinpuwang@gmail.com>
 <02d1f022-8f60-714c-24c8-e2100984e90f@acm.org>
In-Reply-To: <02d1f022-8f60-714c-24c8-e2100984e90f@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 13:39:39 +0100
Message-ID: <CAMGffEnYeDEmqxAChJgvddv_R94wOYkHbG7MHNaTCrvXu2qEig@mail.gmail.com>
Subject: Re: [PATCH v6 05/25] rtrs: client: private header with client structs
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

On Mon, Dec 30, 2019 at 11:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > + * InfiniBand Transport Layer
>
> InfiniBand or RDMA?
will fix.
>
> > +static inline const char *rtrs_clt_state_str(enum rtrs_clt_state state)
> > +{
> > +     switch (state) {
> > +     case RTRS_CLT_CONNECTING:
> > +             return "RTRS_CLT_CONNECTING";
> > +     case RTRS_CLT_CONNECTING_ERR:
> > +             return "RTRS_CLT_CONNECTING_ERR";
> > +     case RTRS_CLT_RECONNECTING:
> > +             return "RTRS_CLT_RECONNECTING";
> > +     case RTRS_CLT_CONNECTED:
> > +             return "RTRS_CLT_CONNECTED";
> > +     case RTRS_CLT_CLOSING:
> > +             return "RTRS_CLT_CLOSING";
> > +     case RTRS_CLT_CLOSED:
> > +             return "RTRS_CLT_CLOSED";
> > +     case RTRS_CLT_DEAD:
> > +             return "RTRS_CLT_DEAD";
> > +     default:
> > +             return "UNKNOWN";
> > +     }
> > +}
>
> This function is not in the hot path so it shouldn't be inline.
no longer in use, will remove.
>
> > +#define MIN_LOG_SG 2
> > +#define MAX_LOG_SG 5
> > +#define MAX_LIN_SG BIT(MIN_LOG_SG)
> > +#define SG_DISTR_SZ (MAX_LOG_SG - MIN_LOG_SG + MAX_LIN_SG + 2)
>
> I think these constants deserve a comment that explains what their
> meaning is.
will add comment.
>
> > +/**
> > + * rtrs_permit - permits the memory allocation for future RDMA operation
> > + */
> > +struct rtrs_permit {
> > +     enum rtrs_clt_con_type con_type;
> > +     unsigned int cpu_id;
> > +     unsigned int mem_id;
> > +     unsigned int mem_off;
> > +};
>
> The comment above this structure is confusing. Please make it more clear.
will extend.
>
> Thanks,
>
> Bart.
Thanks Bart
