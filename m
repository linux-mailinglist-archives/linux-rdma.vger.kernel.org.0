Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89B1846CE
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMMZu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:25:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38042 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMZu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:25:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so7267577qto.5
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UYkrJkTJICopbxYzp++SFM74P6/flqGz7rA5nih6jT8=;
        b=X0u7MC7zFyh5xyepGzwJbWENntur09JgsCJjUH1zi3fWGFsZuVUp8mzxNbM8+RfpGG
         za6OCQLKw5saqKocV+2OFAMXKcDB4W0bbakAXLmR4m/CR41WvTAIodezZTfsV7+/VZnB
         jy/MWqftbbYkXgRJfJYxVQYqL+sRnTKHTzxUB6AQ8pyAVquRKRX1sFT2jl1Xy2XN0p6D
         w+PXxzy5X85hFVRAxOcfPkjzlrPvxao1oI2cgh8J19IAGvLCDQrn+RKdKSoZuNwAdXks
         hgpW1Hc+gie/oPoMzTph1HCYSD1lZRB3zVsnma7syoneAd/zF2bPDTQW7ewRyNYAtT5r
         qDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UYkrJkTJICopbxYzp++SFM74P6/flqGz7rA5nih6jT8=;
        b=bmlYz2OKh1DdL8aFQgDSY1iMAJX+aG5sC7c86iCz/5YCn8txvIlHAvBZxyArod6vDH
         mznj+HB5x2GohfhU6TM8/OXTe4wrGvSltapg/Xsx0+HSV7E9c7RDJse++mUrls7lcZy/
         uq397gUy8DP7ZmjGtbbdSKPOgk7LXzYZoX4TWraNK33utQPmw7IK7/Xt8I8vwWVA0WGr
         iCfq1NNZ2dSlpA0AhPE62zh7ExAB8YzQBG7canrIttoiaive/r/zeqLYef3EFWKZKZ16
         hB5biOm3uy8S8e6mSBSB6WrWpCaHQ/CTKgeg9LStwAwHaUvorqNwDQJbNPEmDMYoBj9F
         km3w==
X-Gm-Message-State: ANhLgQ09xIoSsk+GZMOUdvDYEAKzwxXGUshKQRjR+4r2KyW521cyq3y7
        6OD4goUqno13mYUSLNCvz3Mxew==
X-Google-Smtp-Source: ADFU+vsxTqFe+oK2/EvGE6ldN25W6mGBLsKd+HpEd2Z9sCC1RFpsSCnD4w4G26P+HmM6mx/SXXCkgg==
X-Received: by 2002:ac8:775a:: with SMTP id g26mr12000153qtu.125.1584102347455;
        Fri, 13 Mar 2020 05:25:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 82sm16865838qko.91.2020.03.13.05.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:25:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCjNq-0001ws-7z; Fri, 13 Mar 2020 09:25:46 -0300
Date:   Fri, 13 Mar 2020 09:25:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
Message-ID: <20200313122546.GC31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com>
 <20200311190156.GH31668@ziepe.ca>
 <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
 <20200312172517.GU31668@ziepe.ca>
 <CAHg0HuxmjWu2V6gN=OTsv3v6aYxDkQN=z4F4gMYAu5Wwvp1qGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0HuxmjWu2V6gN=OTsv3v6aYxDkQN=z4F4gMYAu5Wwvp1qGg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 01:18:23PM +0100, Danil Kipnis wrote:
> > > > calling rcu list iteration without holding rcu_lock is wrong
> > > This function (add_path) along with the corresponding
> > > remove_path_from_arr() are the only functions modifying the
> > > paths_list. In both functions paths_mutex is taken so that they are
> > > serialized. Since the modification of the paths_list is protected by
> > > the mutex, the rcu_read_lock is superfluous here.
> >
> > Then don't use the _rcu functions.
> We need to traverse rcu list in the update-side of the code. According
> to the whatisRCU.rst "if list_for_each_entry_rcu() instance might be
> used by update-side code...then an additional lockdep expression can
> be added to its list of arguments..." The would be our case since we
> always hold a lock when doing this, but I don't see a corresponding
> API. We can just surround the statement with
> rcu_readlock/rcu_readunlock to avoid the warning.

The only case where you can avoid RCU is if the code is already
holding a lock preventing writes to the list, in which case you use
the normal list iterator.

> > > > > +     /*
> > > > > +      * @pcpu paths can still point to the path which is going to be
> > > > > +      * removed, so change the pointer manually.
> > > > > +      */
> > > > > +     for_each_possible_cpu(cpu) {
> > > > > +             struct rtrs_clt_sess __rcu **ppcpu_path;
> > > > > +
> > > > > +             ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> > > > > +             if (rcu_dereference(*ppcpu_path) != sess)
> > > >
> > > > calling rcu_dereference without holding rcu_lock is wrong.
> > > We only need a READ_ONCE semantic here. ppcpu_path is pointing to the
> > > last path used for an IO and is used for the round robin multipath
> > > policy. I guess the call can be changed to rcu_dereference_raw to
> > > avoid rcu_lockdep warning. The round-robin algorithm has been reviewed
> > > by Paul E. McKenney, he wrote a litmus test for it:
> > > https://lkml.org/lkml/2018/5/28/2080.
> >
> > You can't call rcu expecting functions without holding the rcu lock -
> > use READ_ONCE/etc if that is what is really going on

> Look's people are using rcu_dereference_protected when dereferencing
> rcu pointer in update-side and have an explicit lock to protect it, as
> we do. Will dig into it next week.

Yes, that is right too

> > > > > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > > > > +                                   struct rtrs_addr *addr)
> > > > > +{
> > > > > +     struct rtrs_clt *clt = sess->clt;
> > > > > +
> > > > > +     mutex_lock(&clt->paths_mutex);
> > > > > +     clt->paths_num++;
> > > > > +
> > > > > +     /*
> > > > > +      * Firstly increase paths_num, wait for GP and then
> > > > > +      * add path to the list.  Why?  Since we add path with
> > > > > +      * !CONNECTED state explanation is similar to what has
> > > > > +      * been written in rtrs_clt_remove_path_from_arr().
> > > > > +      */
> > > > > +     synchronize_rcu();
> > > >
> > > > This makes no sense to me. RCU readers cannot observe the element in
> > > > the list without also observing paths_num++
> > > Paths_num is only used to make sure a reader doesn't look for a
> > > CONNECTED path in the list for ever - instead he makes at most
> > > paths_num attempts. The reader can in fact observe paths_num++ without
> > > observing new element in the paths_list, but this is OK. When adding a
> > > new path we first increase the paths_num and them add the element to
> > > the list to make sure the reader will also iterate over it. When
> > > removing the path - the logic is opposite: we first remove element
> > > from the list and only then decrement the paths_num.
> >
> > I don't understand how this explains why synchronize_rcu would be need
> > here.
> It is needed here so that readers who read the old (smaller) value of
> paths_num and are iterating over the list of paths will have a chance
> to reach the new path we are about to insert. Basically it is here to
> be symmetrical with the removal procedure: remove path,
> syncronize_rcu, path_num--.

How do readers see the paths_num before it is inserted into the list?

Jason
