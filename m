Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01D1374FE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgAJRi6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 12:38:58 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39992 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgAJRi6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 12:38:58 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so2930253iop.7
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xboVQiOZAq1T+J80yURogFNM8VRipdoxX78ZHnTkCJ8=;
        b=HdryxMKkADBYq56aGAVZ7TGGUMfVBOHAq1YgpkkG4HDIZYg5UFIjk0OmVCfvKhurZv
         JBXtt2wFN9RHLOBiinR1W6ly5RwU7QB5Mu2SR3tuqmuumjkBaCOs0nsfktdNT0LRpO1E
         yG81Zzpq/OQc6rkuyJS4Vs1JitxMTYRTJHH1rAF8LHr7BuZoiO9uaQ/5OnhtsiVmcGKh
         8l/QaSJeIiEd6CajH9w7SWBgnjyT+kepwftnhyIldFZmLE1bzgj4MGmSlggVMO7pm0jq
         kMIUuV1fYVEIlxy58r7MC5T4VpJHWQqi7xKjV4hzSuUvIMrzZZqHcpw8Xx0eCJZQDd9X
         HhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xboVQiOZAq1T+J80yURogFNM8VRipdoxX78ZHnTkCJ8=;
        b=WGY0l8DTL2nFfZr+N2qofAsIHh7ELe1nnYdPAzHg8jY9vTrLa1Jcc8Foz48ItNfc8+
         JgFY4HH1GUa2uyitxUASh/rTF19bgTLBllYgfxVEKWwgJHb5cAo/LBUa494LSVm4jhzI
         /91Invzv8K56g8F+80ttmTio2Wtt6nt2GFdlQatk3OM5G80b3IciGyN6Y/HqVJ89WveG
         WVxNJr2PXyg4qUYNLy60r1OCuP4y1w8ywHYoaGemgbReZio2R5agPjp3LwTtjcXPDxrr
         dRcswisO7RbX9mqZiAO0lyf7zEPqtb0ypqJsC708644i7NEAO725WPwF+KWG2MC3G+yn
         30QQ==
X-Gm-Message-State: APjAAAUWbY+NdUshu6SW1oMoQKmH/76jxGwtJm/y21YJK6kFdFX7Xw+F
        jUTi0pUQ/6odm5Gy6OGNTGoBM0LYs0b6UfT3Wvi2Eg==
X-Google-Smtp-Source: APXvYqyuGQMZPhU6h9tQpN8ysU0IKlH2kw/21E4p6/AvGlH/uXayaADTWhbk2AWLjEEgXoXc25SwM9tc5ABQI+QpBPc=
X-Received: by 2002:a02:3090:: with SMTP id q138mr4010316jaq.23.1578677937397;
 Fri, 10 Jan 2020 09:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-11-jinpuwang@gmail.com>
 <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org> <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
 <20200107182528.GB26174@ziepe.ca>
In-Reply-To: <20200107182528.GB26174@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 10 Jan 2020 18:38:46 +0100
Message-ID: <CAMGffE=vcwto1Jyi21fw4m-H9M0ZjMhzfckXvUz++ComS-tfYw@mail.gmail.com>
Subject: Re: [PATCH v6 10/25] rtrs: server: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 7, 2020 at 7:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jan 07, 2020 at 02:19:53PM +0100, Jinpu Wang wrote:
>
> > > How can posting a signaled send prevent that the send queue overflows?
> > > Isn't that something that can only be guaranteed by tracking the number
> > > of WQE's in the send queue?
> > Selective signaling works. All we need to do is signal one WR for
> > every SQ-depth worth of WRs posted. For example, If the SQ depth is
> > 16, we must signal at least one out of every 16. This ensures proper
> > flow control for HW resources.
> > Courtesy: section 8.2.1 of the iWARP Verbs draft
> > http://tools.ietf.org/html/draft-hilland-rddp-verbs-00#section-8.2.1
>
> Not quite. If the SQ depth is 16 and you post 16 things and then
> signal the last one, you *cannot* post new work until you see the
> completion.
>
> More SQ space *ONLY* becomes available upon receipt of a
> completion. This is why you can't have an unsignaled SQ
>
> Jason
Thanks for clarifying.
The HW seems to be very fast to complete WR, that's why never see the problem.
iser has a similar logic, see iser_signal_comp

Jack
