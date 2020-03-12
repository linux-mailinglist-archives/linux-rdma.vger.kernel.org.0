Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B631836EF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCLRKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 13:10:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37998 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCLRKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 13:10:18 -0400
Received: by mail-il1-f196.google.com with SMTP id f5so6184695ilq.5
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QTDOsXgr5uhoUaVYF7jJUlB22rDwaMpfiZJJ6Mk4+Q=;
        b=J5dhMgwUULL6IWKxyuzrB7YQ8XVvgUoNyfuSsQxnVJd4IsLsr3V5xe9HkWHdR3/SFQ
         oILGpqHzzcD6orog4IdcuUwEed+41VD7dp/KRVBdeovNbcK9NV0pV/tybE232dqRURge
         7AmRreflg6bc7x3GJbps2Xy7s+DkmE53LsP4KUjef1mKG0TjzxWWJjTIW4uPAgdSdIGY
         Lcews/f3mXXcRRZpPkagGx11/4/9TH3qZJLN2WCtxdwCtnQD98h0U29QQSxC6W8Wu2BF
         DbNEHfOX7eeFdbiz1OceMllKP4hUbqjjYUma/GGnwkEr6EBqrGn4v+IrKSPCFXy+xMNh
         IFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QTDOsXgr5uhoUaVYF7jJUlB22rDwaMpfiZJJ6Mk4+Q=;
        b=i2+L74GIyRaPoQZnWGuiGsrqtBIhN5c0B6piw8D7nweCKG83SpfVBKMLDZTojbFwOO
         /P8zxdJYlV1dK1CDnEXhiH01vT7P72UJS9PHpqlr28j2K7itbSZPiFkpASsmRV2fUw7i
         vXCcVK2c7J/vloOx9PybpsRI++8LDiZw8nTQRgD8zteGBHObtDBibhnSDXsO6GSK3dCI
         wdCayKzq+Xv2Q4ACzgq+h5TqievQS073vMEBG10kK9LXkgiQgmav3kWb4YgwRuNiJP8J
         Z8j4oi03MMn66C0qL+exUg+FvpXWvK0gkdRDTpbXTRMY8S/5+Z+ilWWftFsy3/zF0yhe
         zzLA==
X-Gm-Message-State: ANhLgQ1ONOP+CPUQtREM6hka7do1Hlg2FcIaopCiCWUF3IncGlBt0kUj
        xhBtNlsDLx38+hJykf8mB+ghduGAqt0gTsSkHDff
X-Google-Smtp-Source: ADFU+vtTJQNiYZ30j6luiGizk9A5IrmVmgKY41vAfZKrgF60S3fbgo1XsRsXGvDiBwZDrKuDBztt44BgIc3d4PODtJY=
X-Received: by 2002:a92:8b8b:: with SMTP id i133mr8830314ild.307.1584033017288;
 Thu, 12 Mar 2020 10:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com> <20200311190156.GH31668@ziepe.ca>
In-Reply-To: <20200311190156.GH31668@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 12 Mar 2020 18:10:06 +0100
Message-ID: <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
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

On Wed, Mar 11, 2020 at 8:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Mar 11, 2020 at 05:12:20PM +0100, Jack Wang wrote:
> > +static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
> > +{
> > +     struct rtrs_clt *clt = sess->clt;
> > +     struct rtrs_clt_sess *next;
> > +     bool wait_for_grace = false;
> > +     int cpu;
> > +
> > +     mutex_lock(&clt->paths_mutex);
> > +     list_del_rcu(&sess->s.entry);
> > +
> > +     /* Make sure everybody observes path removal. */
> > +     synchronize_rcu();
> > +
> > +     /*
> > +      * At this point nobody sees @sess in the list, but still we have
> > +      * dangling pointer @pcpu_path which _can_ point to @sess.  Since
> > +      * nobody can observe @sess in the list, we guarantee that IO path
> > +      * will not assign @sess to @pcpu_path, i.e. @pcpu_path can be equal
> > +      * to @sess, but can never again become @sess.
> > +      */
> > +
> > +     /*
> > +      * Decrement paths number only after grace period, because
> > +      * caller of do_each_path() must firstly observe list without
> > +      * path and only then decremented paths number.
> > +      *
> > +      * Otherwise there can be the following situation:
> > +      *    o Two paths exist and IO is coming.
> > +      *    o One path is removed:
> > +      *      CPU#0                          CPU#1
> > +      *      do_each_path():                rtrs_clt_remove_path_from_arr():
> > +      *          path = get_next_path()
> > +      *          ^^^                            list_del_rcu(path)
> > +      *          [!CONNECTED path]              clt->paths_num--
> > +      *                                              ^^^^^^^^^
> > +      *          load clt->paths_num                 from 2 to 1
> > +      *                    ^^^^^^^^^
> > +      *                    sees 1
> > +      *
> > +      *      path is observed as !CONNECTED, but do_each_path() loop
> > +      *      ends, because expression i < clt->paths_num is false.
> > +      */
> > +     clt->paths_num--;
> > +
> > +     /*
> > +      * Get @next connection from current @sess which is going to be
> > +      * removed.  If @sess is the last element, then @next is NULL.
> > +      */
> > +     next = list_next_or_null_rr_rcu(&clt->paths_list, &sess->s.entry,
> > +                                     typeof(*next), s.entry);
>
> calling rcu list iteration without holding rcu_lock is wrong
This function (add_path) along with the corresponding
remove_path_from_arr() are the only functions modifying the
paths_list. In both functions paths_mutex is taken so that they are
serialized. Since the modification of the paths_list is protected by
the mutex, the rcu_read_lock is superfluous here.

>
> > +     /*
> > +      * @pcpu paths can still point to the path which is going to be
> > +      * removed, so change the pointer manually.
> > +      */
> > +     for_each_possible_cpu(cpu) {
> > +             struct rtrs_clt_sess __rcu **ppcpu_path;
> > +
> > +             ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> > +             if (rcu_dereference(*ppcpu_path) != sess)
>
> calling rcu_dereference without holding rcu_lock is wrong.
We only need a READ_ONCE semantic here. ppcpu_path is pointing to the
last path used for an IO and is used for the round robin multipath
policy. I guess the call can be changed to rcu_dereference_raw to
avoid rcu_lockdep warning. The round-robin algorithm has been reviewed
by Paul E. McKenney, he wrote a litmus test for it:
https://lkml.org/lkml/2018/5/28/2080.

>
> > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > +                                   struct rtrs_addr *addr)
> > +{
> > +     struct rtrs_clt *clt = sess->clt;
> > +
> > +     mutex_lock(&clt->paths_mutex);
> > +     clt->paths_num++;
> > +
> > +     /*
> > +      * Firstly increase paths_num, wait for GP and then
> > +      * add path to the list.  Why?  Since we add path with
> > +      * !CONNECTED state explanation is similar to what has
> > +      * been written in rtrs_clt_remove_path_from_arr().
> > +      */
> > +     synchronize_rcu();
>
> This makes no sense to me. RCU readers cannot observe the element in
> the list without also observing paths_num++
Paths_num is only used to make sure a reader doesn't look for a
CONNECTED path in the list for ever - instead he makes at most
paths_num attempts. The reader can in fact observe paths_num++ without
observing new element in the paths_list, but this is OK. When adding a
new path we first increase the paths_num and them add the element to
the list to make sure the reader will also iterate over it. When
removing the path - the logic is opposite: we first remove element
from the list and only then decrement the paths_num.

>
> Please check all your RCU stuff carefully.

We do our best :]

>
> > +static void rtrs_clt_close_work(struct work_struct *work)
> > +{
> > +     struct rtrs_clt_sess *sess;
> > +
> > +     sess = container_of(work, struct rtrs_clt_sess, close_work);
> > +
> > +     cancel_delayed_work_sync(&sess->reconnect_dwork);
> > +     rtrs_clt_stop_and_destroy_conns(sess);
> > +     /*
> > +      * Sounds stupid, huh?  No, it is not.  Consider this sequence:
>
> It sounds stupid because it is stupid. cancel_work is a giant race if
> some other action hasn't been taken to block parallel threads from
> calling queue_work before calling cancel_work.
Will double check. It might be possible to avoid the second call to
the cancel_delayed_work_sync().

>
> > +static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
> > +                               short port, size_t pdu_sz, void *priv,
> > +                               void  (*link_ev)(void *priv, enum rtrs_clt_link_ev ev),
> > +                               unsigned int max_segments,
> > +                               unsigned int reconnect_delay_sec,
> > +                               unsigned int max_reconnect_attempts)
> > +{
> > +     struct rtrs_clt *clt;
> > +     int err;
> > +
> > +     if (!paths_num || paths_num > MAX_PATHS_NUM)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     if (strlen(sessname) >= sizeof(clt->sessname))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     clt = kzalloc(sizeof(*clt), GFP_KERNEL);
> > +     if (!clt)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     clt->pcpu_path = alloc_percpu(typeof(*clt->pcpu_path));
> > +     if (!clt->pcpu_path) {
> > +             kfree(clt);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> > +     uuid_gen(&clt->paths_uuid);
> > +     INIT_LIST_HEAD_RCU(&clt->paths_list);
> > +     clt->paths_num = paths_num;
> > +     clt->paths_up = MAX_PATHS_NUM;
> > +     clt->port = port;
> > +     clt->pdu_sz = pdu_sz;
> > +     clt->max_segments = max_segments;
> > +     clt->reconnect_delay_sec = reconnect_delay_sec;
> > +     clt->max_reconnect_attempts = max_reconnect_attempts;
> > +     clt->priv = priv;
> > +     clt->link_ev = link_ev;
> > +     clt->mp_policy = MP_POLICY_MIN_INFLIGHT;
> > +     strlcpy(clt->sessname, sessname, sizeof(clt->sessname));
> > +     init_waitqueue_head(&clt->permits_wait);
> > +     mutex_init(&clt->paths_ev_mutex);
> > +     mutex_init(&clt->paths_mutex);
> > +
> > +     clt->dev.class = rtrs_clt_dev_class;
> > +     clt->dev.release = rtrs_clt_dev_release;
> > +     dev_set_name(&clt->dev, "%s", sessname);
>
> Missing error check on dev_set_name

Will fix.
>
> > +     err = device_register(&clt->dev);
> > +     if (err)
> > +             goto percpu_free;
>
> Wrong error unwind, read the kdoc for device_register
Thanks for pointing out, will convert the error handling to put_device().

>
> > +     err = rtrs_clt_create_sysfs_root_folders(clt);
>
> sysfs creation that is not done as part of device_regsiter races with
> udev.
We only use device_register() to create
/sys/class/rtrs_client/<sessionname> sysfs directory. We then create
some folders and files inside this directory (i.e. paths/,
multipath_policy, etc.). Do you mean that the uevent is generated
before we create those subdirectories? How can the creation of this
subdirectories and files be integrated into the device_register()
call?

>
> > +     if (err)
> > +             goto dev_unregister;
>
> > +     return clt;
> > +
> > +dev_unregister:
> > +     device_unregister(&clt->dev);
>
> Wrong error unwind
Device_register succeeded before, so we do device_unregister in error path...
Will fix the wrong kfree(clt) and use put_device instead.

>
> > +percpu_free:
> > +     free_percpu(clt->pcpu_path);
> > +     kfree(clt);
> > +     return ERR_PTR(err);
> > +}
>
> > +struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > +                              const char *sessname,
> > +                              const struct rtrs_addr *paths,
> > +                              size_t paths_num,
> > +                              u16 port,
> > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > +                              u16 max_segments,
> > +                              s16 max_reconnect_attempts)
> > +{
> > +     struct rtrs_clt_sess *sess, *tmp;
> > +     struct rtrs_clt *clt;
> > +     int err, i;
> > +
> > +     clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> > +                     ops->link_ev,
> > +                     max_segments, reconnect_delay_sec,
> > +                     max_reconnect_attempts);
> > +     if (IS_ERR(clt)) {
> > +             err = PTR_ERR(clt);
> > +             goto out;
> > +     }
> > +     for (i = 0; i < paths_num; i++) {
> > +             struct rtrs_clt_sess *sess;
> > +
> > +             sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
> > +                               max_segments);
> > +             if (IS_ERR(sess)) {
> > +                     err = PTR_ERR(sess);
> > +                     goto close_all_sess;
> > +             }
> > +             list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> > +
> > +             err = init_sess(sess);
> > +             if (err)
> > +                     goto close_all_sess;
> > +
> > +             err = rtrs_clt_create_sess_files(sess);
> > +             if (err)
> > +                     goto close_all_sess;
> > +     }
> > +     err = alloc_permits(clt);
> > +     if (err)
> > +             goto close_all_sess;
> > +     err = rtrs_clt_create_sysfs_root_files(clt);
> > +     if (err)
> > +             goto close_all_sess;
> > +
> > +     /*
> > +      * There is a race if someone decides to completely remove just
> > +      * newly created path using sysfs entry.  To avoid the race we
> > +      * use simple 'opened' flag, see rtrs_clt_remove_path_from_sysfs().
> > +      */
> > +     clt->opened = true;
>
> A race solution without locks?
We wanted to make sure that a path belonging to a session currently
being established can't be removed from sysfs before the establishment
is finished.

>
> > +
> > +     /* Do not let module be unloaded if client is alive */
> > +     __module_get(THIS_MODULE);
>
> Very strange.
Will check.
>
> > +static int __init rtrs_client_init(void)
> > +{
> > +     pr_info("Loading module %s, proto %s\n",
> > +             KBUILD_MODNAME, RTRS_PROTO_VER_STRING);
>
> No prints like this please
Will drop the print.
>
> Jason
