Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25372132E53
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgAGSZb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 13:25:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44850 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGSZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 13:25:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so222456qkb.11
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOR+K1ncnhPYV3jShNhhaRqIVvIIfeqkcrZztx4tCT0=;
        b=didMPmIA0tc6k6INSrF+hb9ceSMwHRwM6PbQr0gaEkiMXKAQ0M1mAJ9+bhuf9RVaC2
         qCuej3M29reZ9rBAjI4y92wUX8SgBjpg4lCry1KCkLZMXkfZToju8nO7LKo6IU91Nsi8
         ip5efLngVMBZGe0AyEPYNvFTtysOgK8DFuzTQLeNoMBodTuhZFXTGpky8jsMaM0HsFwS
         zwjcuvhL4HtfmdqB7AM+TT4ZWZxQnFGUH5X40gAYS02whXYsGzFIPuII3sWN2XmRwmBc
         mfy37siyI0wWoqYox8o8EVCvDyc7pOZp1YLclf9wDo9CMi7V6HGdscD58a6DgJ/TQ2PH
         0AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOR+K1ncnhPYV3jShNhhaRqIVvIIfeqkcrZztx4tCT0=;
        b=gHX1RS7aSAzDbn6liQzUlqXImvDY0WL7WHatVyZ9kK8/fAo5plSIy90XOuKMFcrrV4
         e5o3mYAsapabdlDqc6N0LudfI5cTJl7mIYAQPLvevZlm3uaRpkLqyDj8lGxIpPFVrdn7
         oxY+foVFctasGzT5NuDV36pdcu6kSMxBDRQpPrqJfLG7pL59hYZLwEKwEAlF4g28HAwq
         Ix/mC6K51SE17xLShxAubqMV+oyX0+HmT88IopWAHT0Eq+mm+NzDTxDSICGnUdcmjDek
         165I7P8pdcv4V2WKKVWZXoT0zS+NRGT31+uB4Q0XDp8QAWwGSgBQrQGpUbZyW4IUj0/a
         64tQ==
X-Gm-Message-State: APjAAAUB3i9GaqMsBUuhW55lb1U8YDjX/78ABBHK8RF4p3/EZDlrMz8U
        WsHTMbZF8SaI3Aoftcmw9H0nyw==
X-Google-Smtp-Source: APXvYqxZ5kMw7iRRyhUHoE6hJP5D8mKrqkB4NK/JakvpKB061ba9HTmJ6H4UOqYdrpZHmed4WxfEDA==
X-Received: by 2002:ae9:c205:: with SMTP id j5mr661226qkg.58.1578421529949;
        Tue, 07 Jan 2020 10:25:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s20sm174023qkg.131.2020.01.07.10.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:25:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotXk-0008PJ-PX; Tue, 07 Jan 2020 14:25:28 -0400
Date:   Tue, 7 Jan 2020 14:25:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v6 10/25] rtrs: server: main functionality
Message-ID: <20200107182528.GB26174@ziepe.ca>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-11-jinpuwang@gmail.com>
 <3fa42a11-5a85-f585-fed8-e8a2c0d7a249@acm.org>
 <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkhf8O01F-78LJnqiASsGsfdR9WWENPrPtrTOUYUp6=gw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 07, 2020 at 02:19:53PM +0100, Jinpu Wang wrote:

> > How can posting a signaled send prevent that the send queue overflows?
> > Isn't that something that can only be guaranteed by tracking the number
> > of WQE's in the send queue?
> Selective signaling works. All we need to do is signal one WR for
> every SQ-depth worth of WRs posted. For example, If the SQ depth is
> 16, we must signal at least one out of every 16. This ensures proper
> flow control for HW resources.
> Courtesy: section 8.2.1 of the iWARP Verbs draft
> http://tools.ietf.org/html/draft-hilland-rddp-verbs-00#section-8.2.1

Not quite. If the SQ depth is 16 and you post 16 things and then
signal the last one, you *cannot* post new work until you see the
completion.

More SQ space *ONLY* becomes available upon receipt of a
completion. This is why you can't have an unsignaled SQ

Jason
