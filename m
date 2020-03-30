Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF2197C9A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgC3NO7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 09:14:59 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45807 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgC3NO6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 09:14:58 -0400
Received: by mail-il1-f194.google.com with SMTP id x16so15681090ilp.12
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2020 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukZxHuXcY+RSkOEQnOs8SE01WIPAoehebs9txPS9INA=;
        b=Gsq/0OEAqZNUJ3xOQCl+XSkomNQk3hERzAOOBg7Bpyzlbj4fITzjK2urG50G69a/Sw
         ajvzYFU3g1+A7x/KlsT5qcnAWl95q05JTvPpAVcWJ8+X+fxcYpT05ibGInd2wgWyGGys
         AjUkcOSt3L0Imiu9MkGJXYj9n2aPS0ObxPbHApbbp3+1wZD5o9X7iY5gyMKSvf5XHJ6g
         JpYBDNbKCRs4IAProMxwPfKpJvhyNFDp9U8dKcg0mAIZMy5HIiOUWZyLj7gHjHf+GVOF
         IwfbMPThgB/Fv5rgBHzxxITRT19FSVC6uD7b+T8O5rV/9+eVV7V+tncox2SJ8sANeGb8
         /25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukZxHuXcY+RSkOEQnOs8SE01WIPAoehebs9txPS9INA=;
        b=ResPLNPXwQIbzR3M7xJWGe0by87imMt57WxI6KTRp4MiE19YL3Z5q8XEV3Hh1zHYjL
         mRTZPPFQIA7G3Q9GiN6hKOzkcxiBwvfz25Kf1gpCTTY9s0/qs88lofCpsqSKvn4aGC2K
         XLRz135iUYHmhaP+dTtnge9+MY3poxfXNu5ivch19s4RYIHRYpHmXRI9BnkCU0AdtqUg
         nyLGH6wzxfpOayrVsU6mTYszlR10RTN79E/5ULEgvLgdNk7lRKuXz51O5PNaFIcRJMyt
         og90vkY2RXJjJ9xjw0tiTHzIscQzqMIymYLTbwS6r0HkGhlZ133efpQcSCM3lkaL5T6S
         6s1Q==
X-Gm-Message-State: ANhLgQ1HtfoPqSjzr96pNbtG+C3kJzghkwctLRcrWqr0IgJpcWz51w1S
        phIyZ2Qj5S1KsbqyxDH8cwAkEpL9q31WeZxkXCax
X-Google-Smtp-Source: ADFU+vu/CcdW5NMLyBTPm9iVigb01s8LTpPXTv/W1C7Ycj7ZoHPDirRzhi4qoZg71CLTtEbJbCulCa7XUhQ05XPSkNQ=
X-Received: by 2002:a92:da81:: with SMTP id u1mr10840997iln.116.1585574097606;
 Mon, 30 Mar 2020 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-24-jinpu.wang@cloud.ionos.com> <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
In-Reply-To: <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 15:14:46 +0200
Message-ID: <CAHg0HuxsSJzth9iBotNSKJOG4327xRgSRgvaTMH6G58ADSXCTQ@mail.gmail.com>
Subject: Re: [PATCH v11 23/26] block/rnbd: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 8:31 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > This is the sysfs interface to rnbd mapped devices on server side:
> >
> >   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
> >     |- block_dev
> >     |  *** link pointing to the corresponding block device sysfs entry
> >     |
> >     |- sessions/<session-name>/
> >     |  *** sessions directory
> >        |
> >        |- read_only
> >        |  *** is devices mapped as read only
> >        |
> >        |- mapping_path
> >           *** relative device path provided by the client during mapping
> >
>
> > +static struct kobj_type ktype = {
> > +     .sysfs_ops      = &kobj_sysfs_ops,
> > +};
>
> From Documentation/kobject.txt: "One important point cannot be
> overstated: every kobject must have a release() method." I think this is
> something that Greg KH feels very strongly about. Please fix this.

OK.


>
> > +int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> > +                            struct block_device *bdev,
> > +                            const char *dir_name)
> > +{
> > +     struct kobject *bdev_kobj;
> > +     int ret;
> > +
> > +     ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
> > +                                rnbd_devs_kobj, dir_name);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = kobject_init_and_add(&dev->dev_sessions_kobj,
> > +                                &ktype,
> > +                                &dev->dev_kobj, "sessions");
> > +     if (ret)
> > +             goto err;
> > +
> > +     bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
> > +     ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
> > +     if (ret)
> > +             goto err2;
> > +
> > +     return 0;
> > +
> > +err2:
> > +     kobject_put(&dev->dev_sessions_kobj);
> > +err:
> > +     kobject_put(&dev->dev_kobj);
> > +     return ret;
> > +}
>
> Please choose more descriptive names for the goto labels, e.g.
> put_sess_kobj and put_dev_kobj.

OK


>
> > +static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +                           char *page)
> > +{
> > +     struct rnbd_srv_sess_dev *sess_dev;
> > +
> > +     sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
> > +
> > +     return scnprintf(page, PAGE_SIZE, "%s\n",
> > +                      (sess_dev->open_flags & FMODE_WRITE) ? "0" : "1");
> > +}
>
> The scnprintf() statement looks overcomplicated. How about the following?
>
> return scnprintf(page, PAGE_SIZE, "%d\n",
>                  (sess_dev->open_flags & FMODE_WRITE) != 0);

Looks better, thanks.


> > +void rnbd_srv_destroy_dev_session_sysfs(struct rnbd_srv_sess_dev *sess_dev)
> > +{
> > +     DECLARE_COMPLETION_ONSTACK(sysfs_compl);
> > +
> > +     sysfs_remove_group(&sess_dev->kobj,
> > +                        &rnbd_srv_default_dev_session_attr_group);
> > +
> > +     sess_dev->sysfs_release_compl = &sysfs_compl;
> > +     kobject_del(&sess_dev->kobj);
> > +     kobject_put(&sess_dev->kobj);
> > +     wait_for_completion(&sysfs_compl);
> > +}
>
> Why is there a wait_for_completion() call in the above function? I think
> Greg KH strongly disagrees with such calls in functions that remove
> sysfs attributes.

This just makes the function wait until the sysfs release function is
called, so that sess_dev can be freed afterwards. Will try to get rid
of the completion and call the rnbd_destroy_sess_dev() which frees the
struct directly from the release function.


>
> > +int rnbd_srv_create_sysfs_files(void)
> > +{
> > +     int err;
> > +
> > +     rnbd_dev_class = class_create(THIS_MODULE, "rnbd-server");
> > +     if (IS_ERR(rnbd_dev_class))
> > +             return PTR_ERR(rnbd_dev_class);
> > +
> > +     rnbd_dev = device_create(rnbd_dev_class, NULL,
> > +                               MKDEV(0, 0), NULL, "ctl");
> > +     if (IS_ERR(rnbd_dev)) {
> > +             err = PTR_ERR(rnbd_dev);
> > +             goto cls_destroy;
> > +     }
> > +     rnbd_devs_kobj = kobject_create_and_add("devices", &rnbd_dev->kobj);
> > +     if (!rnbd_devs_kobj) {
> > +             err = -ENOMEM;
> > +             goto dev_destroy;
> > +     }
> > +
> > +     return 0;
> > +
> > +dev_destroy:
> > +     device_destroy(rnbd_dev_class, MKDEV(0, 0));
> > +cls_destroy:
> > +     class_destroy(rnbd_dev_class);
> > +
> > +     return err;
> > +}
>
> Please mention the device class in the description of this patch.

OK,

Thanks,

Danil
>
> Thanks,
>
> Bart.
