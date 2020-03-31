Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2F199236
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaJ0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 05:26:51 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35596 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgCaJ0v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 05:26:51 -0400
Received: by mail-il1-f195.google.com with SMTP id 7so18737324ill.2
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2020 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CZCEVvaP4QJeKyBrdCxhzKGyfAnZN+S5sG3wKAL0Us=;
        b=EPjPT9Ix9refc520tdJ/5pB07YINSgYm5Jlflz9wN770In+vG2bIMqrSCz3gK9yrFw
         Cswj/woPaOY3NE1eS5piZ9pXE+0pKTO/LQ2pusHhAdvSgIMw2JA9wxXlfxvw6sqZHjcy
         MsrhUTZkFcH5B1Fr9YYfBdckXahcS8yjM/bW/jcz5/00kOSZVN8jVDbgNQqm4T7KJpOy
         Tb8WF9GbfAK9/pvKCje6XziAdIEl9iUovbngkwsxJ7OR0R3oyQ2HDG/aZVnz0g3AyKRu
         RZIZL9mOQZt/j5/ehmEUeEDUp7ddV9KtdyQyd9MJNiIRfNmzNt4s3asDcBVlMIZQTCDG
         rd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CZCEVvaP4QJeKyBrdCxhzKGyfAnZN+S5sG3wKAL0Us=;
        b=nmr8peF2HMSMNmCtE6b4z/VqwfEH/XWt05g1/cFPaTqSRLUXm0tBJY1RBa8vYZGb4e
         kmbqEI+KkKr7C47879zoB5hCNtHQO3eD3oyWViaHhpaf8ZD0DSf6DdXKyyE696g0SRx6
         YIVqE52wiy3acMMHv5nbdrwuf4DN7qKlUJYlFtKKE7P63AU9D9Qa/zALbCNDTivNf46J
         vVlvwRafPzJUd/Z/InZn66fV85tMLYJZPnK7qYAu0I33m9eeJuiUyamXx2aBp8xUzX8X
         zsz08WHelmjXG6mNTsAViUCOvNs9yYQjYE444Q/t5y1TcPpg7cXhGu4cIOMIHm6kjabi
         81kA==
X-Gm-Message-State: ANhLgQ0lHdVxNGhus/FKPM+VxxTuR4XH9QFisXTFEx+IPVHeW2L91PtA
        BZmCyES8tSbXD9tJnkd7nDyJKpT6gNJ6amE/inVd0Q==
X-Google-Smtp-Source: ADFU+vsLHRoHdX+k4k1F6t37d2n0/vx2+CGoLKmML6U+/PPZhjMj0kJqDw0LRcyqsY58pIEWI6wQbp8yYvyclm2kz98=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr15056961ili.217.1585646810616;
 Tue, 31 Mar 2020 02:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-20-jinpu.wang@cloud.ionos.com> <5c710388-c40e-4336-d1d8-b50d4ed3ca85@acm.org>
In-Reply-To: <5c710388-c40e-4336-d1d8-b50d4ed3ca85@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:26:39 +0200
Message-ID: <CAMGffEnjxB1NK-c=G9298U_VD1r9DhBQCDqvD8TozTRTXXuP4g@mail.gmail.com>
Subject: Re: [PATCH v11 19/26] block/rnbd: client: sysfs interface functions
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

On Sat, Mar 28, 2020 at 6:00 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +                     ret = rtrs_addr_to_sockaddr(p, strlen(p), RTRS_PORT,
> > +                                                  &opt->paths[p_cnt]);
>
> Same question here: has the server port number been hardcoded here?
Yeah, as answered in another email, we will introduce a module
parameter for rnbd-clt for port_nr.
>
> Thanks,
>
> Bart.
Thanks Bart!
