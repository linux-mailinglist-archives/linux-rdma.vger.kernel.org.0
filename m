Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09C71846AE
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgCMMSf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:18:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40421 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMSf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:18:35 -0400
Received: by mail-il1-f193.google.com with SMTP id g6so8678801ilc.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7ST00huZYUeo/fS6kEvpdxOYRKGflJTP8aqRKHEY20=;
        b=LdNNpa2xCSBm+HSukQPY1iweNG/j1+i+Upzp1UEFDyc/tmrY3kbGhfsdDmxhR5XaqP
         gsY6BsRf9qzmObMDRHm0XIrwofZJnX1lZXeTNLlEydIy1VL8+uHY/WxGmz7KMQelNLa/
         gMQxkOvhBGseSEWMA8uZOYnLvC7DOwhtSUxb5bO7zBfRb8i0nW5iYrscdsTtjERLdqNt
         RI9xNpHtDHuHAhBg7kxp0C4N4CYDk2oVkjC6l/1TaCzu7eFXjVDHonirEuj+0vDcR01P
         AlBSoyRk4dV0SVtewatP5YGhkmlmVaEnDD9Nnt19snAjTyK2doLFATAvUhcTQpwec/jc
         zX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7ST00huZYUeo/fS6kEvpdxOYRKGflJTP8aqRKHEY20=;
        b=tOJPggpdc2NPtFAIE2+YVduLBb/jF+gFeN6mgqkmLFZnPlMjkKcT2ikzM6aenREvEK
         cw5/tOTPkwbfUJcNCKtnVNalgcqEi/Q2VcY4ssVncsSwt51z5c5UuNFAy/gZivrSjrUL
         OrXy1Nap+gQC1FGc/WWcfmkS1Tti/XLU5JOJ17KTfsGEGygYTbOZJvQr0+doG1kJS4Tn
         6J69nGhAp63PN41vvvCugUMudweEQsjLbznwvz5yalb4cqESkHm3Qd8sMnAejlkxfGxu
         ToPbzLEy8elcPrlq251zg8SQcK7PJN+IKnB5Ogd7AMXOPOtAHUoKVNSdEPFapXCjoDBB
         6VSg==
X-Gm-Message-State: ANhLgQ0Hc3gxBYarFJPs0PWmYNeX0tyIQosbkjbw5qXJcJgiYX94TMw3
        DKPz1F0iGgEF36jk0dYK9Y5zJbFmWKUiNT1PKdMy
X-Google-Smtp-Source: ADFU+vv1KXqgocUuWLvBd9Z6WyCV+ZtXs+wse0G9xaLeTtAmGbdI0kdkpV8DtopAWz+to1zHKJxMXtXtoO9IJuLVd3M=
X-Received: by 2002:a92:8b8b:: with SMTP id i133mr12694437ild.307.1584101913875;
 Fri, 13 Mar 2020 05:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com> <20200311190156.GH31668@ziepe.ca>
 <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com> <20200312172517.GU31668@ziepe.ca>
In-Reply-To: <20200312172517.GU31668@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 13 Mar 2020 13:18:23 +0100
Message-ID: <CAHg0HuxmjWu2V6gN=OTsv3v6aYxDkQN=z4F4gMYAu5Wwvp1qGg@mail.gmail.com>
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Thu, Mar 12, 2020 at 6:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 12, 2020 at 06:10:06PM +0100, Danil Kipnis wrote:
> > Hi Jason,
> >
> > On Wed, Mar 11, 2020 at 8:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Mar 11, 2020 at 05:12:20PM +0100, Jack Wang wrote:
> > > > +static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
> > > > +{
> > > > +     struct rtrs_clt *clt = sess->clt;
> > > > +     struct rtrs_clt_sess *next;
> > > > +     bool wait_for_grace = false;
> > > > +     int cpu;
> > > > +
> > > > +     mutex_lock(&clt->paths_mutex);
> > > > +     list_del_rcu(&sess->s.entry);
> > > > +
> > > > +     /* Make sure everybody observes path removal. */
> > > > +     synchronize_rcu();
> > > > +
> > > > +     /*
> > > > +      * At this point nobody sees @sess in the list, but still we have
> > > > +      * dangling pointer @pcpu_path which _can_ point to @sess.  Since
> > > > +      * nobody can observe @sess in the list, we guarantee that IO path
> > > > +      * will not assign @sess to @pcpu_path, i.e. @pcpu_path can be equal
> > > > +      * to @sess, but can never again become @sess.
> > > > +      */
> > > > +
> > > > +     /*
> > > > +      * Decrement paths number only after grace period, because
> > > > +      * caller of do_each_path() must firstly observe list without
> > > > +      * path and only then decremented paths number.
> > > > +      *
> > > > +      * Otherwise there can be the following situation:
> > > > +      *    o Two paths exist and IO is coming.
> > > > +      *    o One path is removed:
> > > > +      *      CPU#0                          CPU#1
> > > > +      *      do_each_path():                rtrs_clt_remove_path_from_arr():
> > > > +      *          path = get_next_path()
> > > > +      *          ^^^                            list_del_rcu(path)
> > > > +      *          [!CONNECTED path]              clt->paths_num--
> > > > +      *                                              ^^^^^^^^^
> > > > +      *          load clt->paths_num                 from 2 to 1
> > > > +      *                    ^^^^^^^^^
> > > > +      *                    sees 1
> > > > +      *
> > > > +      *      path is observed as !CONNECTED, but do_each_path() loop
> > > > +      *      ends, because expression i < clt->paths_num is false.
> > > > +      */
> > > > +     clt->paths_num--;
> > > > +
> > > > +     /*
> > > > +      * Get @next connection from current @sess which is going to be
> > > > +      * removed.  If @sess is the last element, then @next is NULL.
> > > > +      */
> > > > +     next = list_next_or_null_rr_rcu(&clt->paths_list, &sess->s.entry,
> > > > +                                     typeof(*next), s.entry);
> > >
> > > calling rcu list iteration without holding rcu_lock is wrong
> > This function (add_path) along with the corresponding
> > remove_path_from_arr() are the only functions modifying the
> > paths_list. In both functions paths_mutex is taken so that they are
> > serialized. Since the modification of the paths_list is protected by
> > the mutex, the rcu_read_lock is superfluous here.
>
> Then don't use the _rcu functions.
We need to traverse rcu list in the update-side of the code. According
to the whatisRCU.rst "if list_for_each_entry_rcu() instance might be
used by update-side code...then an additional lockdep expression can
be added to its list of arguments..." The would be our case since we
always hold a lock when doing this, but I don't see a corresponding
API. We can just surround the statement with
rcu_readlock/rcu_readunlock to avoid the warning.

>
> > >
> > > > +     /*
> > > > +      * @pcpu paths can still point to the path which is going to be
> > > > +      * removed, so change the pointer manually.
> > > > +      */
> > > > +     for_each_possible_cpu(cpu) {
> > > > +             struct rtrs_clt_sess __rcu **ppcpu_path;
> > > > +
> > > > +             ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> > > > +             if (rcu_dereference(*ppcpu_path) != sess)
> > >
> > > calling rcu_dereference without holding rcu_lock is wrong.
> > We only need a READ_ONCE semantic here. ppcpu_path is pointing to the
> > last path used for an IO and is used for the round robin multipath
> > policy. I guess the call can be changed to rcu_dereference_raw to
> > avoid rcu_lockdep warning. The round-robin algorithm has been reviewed
> > by Paul E. McKenney, he wrote a litmus test for it:
> > https://lkml.org/lkml/2018/5/28/2080.
>
> You can't call rcu expecting functions without holding the rcu lock -
> use READ_ONCE/etc if that is what is really going on
Look's people are using rcu_dereference_protected when dereferencing
rcu pointer in update-side and have an explicit lock to protect it, as
we do. Will dig into it next week.

>
> > >
> > > > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > > > +                                   struct rtrs_addr *addr)
> > > > +{
> > > > +     struct rtrs_clt *clt = sess->clt;
> > > > +
> > > > +     mutex_lock(&clt->paths_mutex);
> > > > +     clt->paths_num++;
> > > > +
> > > > +     /*
> > > > +      * Firstly increase paths_num, wait for GP and then
> > > > +      * add path to the list.  Why?  Since we add path with
> > > > +      * !CONNECTED state explanation is similar to what has
> > > > +      * been written in rtrs_clt_remove_path_from_arr().
> > > > +      */
> > > > +     synchronize_rcu();
> > >
> > > This makes no sense to me. RCU readers cannot observe the element in
> > > the list without also observing paths_num++
> > Paths_num is only used to make sure a reader doesn't look for a
> > CONNECTED path in the list for ever - instead he makes at most
> > paths_num attempts. The reader can in fact observe paths_num++ without
> > observing new element in the paths_list, but this is OK. When adding a
> > new path we first increase the paths_num and them add the element to
> > the list to make sure the reader will also iterate over it. When
> > removing the path - the logic is opposite: we first remove element
> > from the list and only then decrement the paths_num.
>
> I don't understand how this explains why synchronize_rcu would be need
> here.
It is needed here so that readers who read the old (smaller) value of
paths_num and are iterating over the list of paths will have a chance
to reach the new path we are about to insert. Basically it is here to
be symmetrical with the removal procedure: remove path,
syncronize_rcu, path_num--.

>
> > > > +static void rtrs_clt_close_work(struct work_struct *work)
> > > > +{
> > > > +     struct rtrs_clt_sess *sess;
> > > > +
> > > > +     sess = container_of(work, struct rtrs_clt_sess, close_work);
> > > > +
> > > > +     cancel_delayed_work_sync(&sess->reconnect_dwork);
> > > > +     rtrs_clt_stop_and_destroy_conns(sess);
> > > > +     /*
> > > > +      * Sounds stupid, huh?  No, it is not.  Consider this sequence:
> > >
> > > It sounds stupid because it is stupid. cancel_work is a giant race if
> > > some other action hasn't been taken to block parallel threads from
> > > calling queue_work before calling cancel_work.
> > Will double check. It might be possible to avoid the second call to
> > the cancel_delayed_work_sync().
>
> I would have guessed first call.. Before doing cancel_work something
> must have prevented new work from being created.
Will look look into it, thanks.
>
> > > > +     err = rtrs_clt_create_sysfs_root_folders(clt);
> > >
> > > sysfs creation that is not done as part of device_regsiter races with
> > > udev.
> > We only use device_register() to create
> > /sys/class/rtrs_client/<sessionname> sysfs directory. We then create
> > some folders and files inside this directory (i.e. paths/,
> > multipath_policy, etc.). Do you mean that the uevent is generated
> > before we create those subdirectories? How can the creation of this
> > subdirectories and files be integrated into the device_register()
> > call?
>
> Yes the uevent..
>
> Limited types of sysfs files can be created with the group scheme.
>
> Others need to manipulate the uevent unfortunately, see how ib device
> registration works
Will check it out, thank you.

>
> > > > +struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > > > +                              const char *sessname,
> > > > +                              const struct rtrs_addr *paths,
> > > > +                              size_t paths_num,
> > > > +                              u16 port,
> > > > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > > > +                              u16 max_segments,
> > > > +                              s16 max_reconnect_attempts)
> > > > +{
> > > > +     struct rtrs_clt_sess *sess, *tmp;
> > > > +     struct rtrs_clt *clt;
> > > > +     int err, i;
> > > > +
> > > > +     clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> > > > +                     ops->link_ev,
> > > > +                     max_segments, reconnect_delay_sec,
> > > > +                     max_reconnect_attempts);
> > > > +     if (IS_ERR(clt)) {
> > > > +             err = PTR_ERR(clt);
> > > > +             goto out;
> > > > +     }
> > > > +     for (i = 0; i < paths_num; i++) {
> > > > +             struct rtrs_clt_sess *sess;
> > > > +
> > > > +             sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
> > > > +                               max_segments);
> > > > +             if (IS_ERR(sess)) {
> > > > +                     err = PTR_ERR(sess);
> > > > +                     goto close_all_sess;
> > > > +             }
> > > > +             list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> > > > +
> > > > +             err = init_sess(sess);
> > > > +             if (err)
> > > > +                     goto close_all_sess;
> > > > +
> > > > +             err = rtrs_clt_create_sess_files(sess);
> > > > +             if (err)
> > > > +                     goto close_all_sess;
> > > > +     }
> > > > +     err = alloc_permits(clt);
> > > > +     if (err)
> > > > +             goto close_all_sess;
> > > > +     err = rtrs_clt_create_sysfs_root_files(clt);
> > > > +     if (err)
> > > > +             goto close_all_sess;
> > > > +
> > > > +     /*
> > > > +      * There is a race if someone decides to completely remove just
> > > > +      * newly created path using sysfs entry.  To avoid the race we
> > > > +      * use simple 'opened' flag, see rtrs_clt_remove_path_from_sysfs().
> > > > +      */
> > > > +     clt->opened = true;
> > >
> > > A race solution without locks?
> > We wanted to make sure that a path belonging to a session currently
> > being established can't be removed from sysfs before the establishment
> > is finished.
>
> There are still no locks, so this solution to races is probably racey.
Will try to get rid of the flag.
>
> Jason
