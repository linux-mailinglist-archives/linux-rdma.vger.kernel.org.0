Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9BB7E9E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbfISPz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 11:55:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34714 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbfISPz3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 11:55:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so7505119wmc.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+O4wf0Rjt38hLj7CnOY6Hp2EvRqTzJKyrJBitweUaT0=;
        b=K5gHpssxoOzrkXSh1EwBlIIFq0yk2fbOQNCrGx0hfCRJo4RZ4/vyOgHfpsN4IzRI+F
         5PI3lQtxi2UTrbwZdPvdhBGw1BAwCsW6AqYe3E+i9QzgRT4BM8p5kGW0+0BgJPp0nyxM
         Pttavkr8BkOUIvD1rWLtWDgMdiwT+vzXP7lo7AY0X7px81XLFMGtKI5lL5te3X9u40Nr
         F9xm7fBoc55UHg2SPE7iNHykzn3F24qj5YrNZWDqsDBsMZAqW+rQC9vSnaErbT4yBrpR
         hxe+4Vx1YDrXlnehL9uvqrmkWB6HVBQlcwR3DhQTQaMLzu4ndsNiqPWJgP0Ebvt2CwRs
         Ku2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+O4wf0Rjt38hLj7CnOY6Hp2EvRqTzJKyrJBitweUaT0=;
        b=SiFzFxvJYtBSG+Oe4iyIVtFB4Zk7wr4LCsXahRkHCkzJvVhmbGB75i8rgnZHqTGDVs
         BLUOha5lm/yTKcya/mFtjMq9X0CXOZBiUF+oLgOchC/85EWMwFna8G4a+0MkyK1iur6m
         eKSxfVQ2/N+Ofmpt9NhrzgbRgcS9+remVbZM/aW0eOpzOTPcfKWmz+OLshtXvMXjs2Qa
         AhH1B02sjW9oIOglYhnyf286MpMFvfXIKHMUjkFLx9wLfu8DdlZ3Ps8gUmBrXaayKp0u
         isN7enuZ6Ow4fhAmx8hBtjSkmXNkTtgXlSKNyQLfWkJ8yTTNvIEqdkUjIXvd1gR0TUeA
         U4rw==
X-Gm-Message-State: APjAAAUK5jFISV4L1chO9v90Sh25g7noFSgJZ+W4kr2i11OJIYeCripG
        qntuYshNzE//z46pCml38aBWmFex2bu1WbKQEg5sYw==
X-Google-Smtp-Source: APXvYqywOtD5QIaWvKcb/CJE5rnxr3lHJtBnROWbxxUWVndJU5R93sV6KGOV/nZGZh3KWWmZ6Jq6MZNyQDfWKA0YXE8=
X-Received: by 2002:a1c:7dd1:: with SMTP id y200mr3352031wmc.59.1568908525788;
 Thu, 19 Sep 2019 08:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-19-jinpuwang@gmail.com>
 <05192413-4b0c-76fd-7459-bc6d430b46a6@acm.org>
In-Reply-To: <05192413-4b0c-76fd-7459-bc6d430b46a6@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 19 Sep 2019 17:55:14 +0200
Message-ID: <CAMGffEn09RiLjkHZjt1GFkeLjk+vprupLFdPfLJ2PetArc5nHw@mail.gmail.com>
Subject: Re: [PATCH v4 18/25] ibnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 18, 2019 at 6:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> Including the line number in all messages is too much information.
> Please don't do this. Additionally, this will make the line number occur
> twice in messages produced by pr_debug().
We feel it's quite handy for debugging to have line number, I checked
in mainline,
some driver even include __func__ and __LINE__.
Also did a test, the line number occur only once from pr_debug.
>
> > +static unsigned int ibnbd_opt_mandatory[] = {
> > +     IBNBD_OPT_PATH,
> > +     IBNBD_OPT_DEV_PATH,
> > +     IBNBD_OPT_SESSNAME,
> > +};
>
> Should this array have been declared const?
Sounds good.
>
>  > +/* remove new line from string */
>  > +static void strip(char *s)
>  > +{
>  > +    char *p = s;
>  > +
>  > +    while (*s != '\0') {
>  > +            if (*s != '\n')
>  > +                    *p++ = *s++;
>  > +            else
>  > +                    ++s;
>  > +    }
>  > +    *p = '\0';
>  > +}
>
> This function can remove a newline from the middle of a string. Are you
> sure that's what you want?
Yes, we want a strip all newline in the string, when print with
> Is it useful to strip newline characters only and to keep other
> whitespace? Could this function be dropped and can the callers use
> strim() instead?
 We strstrip/strim afterwards to remove the whitespace.
>
> > +static int ibnbd_clt_parse_map_options(const char *buf,
> > +                                    char *sessname,
> > +                                    struct ibtrs_addr *paths,
> > +                                    size_t *path_cnt,
> > +                                    size_t max_path_cnt,
> > +                                    char *pathname,
> > +                                    enum ibnbd_access_mode *access_mode,
> > +                                    enum ibnbd_io_mode *io_mode)
> > +{
>
> Please introduce a structure for all the output parameters of this
> function and pass a pointer to that structure to this function. That
> will make it easier to introduce support for new parameters.
>
> > +     char *options, *sep_opt;
> > +     char *p;
> > +     substring_t args[MAX_OPT_ARGS];
> > +     int opt_mask = 0;
> > +     int token;
> > +     int ret = -EINVAL;
> > +     int i;
> > +     int p_cnt = 0;
> > +
> > +     options = kstrdup(buf, GFP_KERNEL);
> > +     if (!options)
> > +             return -ENOMEM;
> > +
> > +     sep_opt = strstrip(options);
> > +     strip(sep_opt);
>
> Are you sure that strstrip() does not remove trailing newline characters?
Yes, it only removes the whitespace
>
> > +     while ((p = strsep(&sep_opt, " ")) != NULL) {
> > +             if (!*p)
> > +                     continue;
> > +
> > +             token = match_token(p, ibnbd_opt_tokens, args);
> > +             opt_mask |= token;
> > +
> > +             switch (token) {
> > +             case IBNBD_OPT_SESSNAME:
> > +                     p = match_strdup(args);
> > +                     if (!p) {
> > +                             ret = -ENOMEM;
> > +                             goto out;
> > +                     }
> > +                     if (strlen(p) > NAME_MAX) {
> > +                             pr_err("map_device: sessname too long\n");
> > +                             ret = -EINVAL;
> > +                             kfree(p);
> > +                             goto out;
> > +                     }
> > +                     strlcpy(sessname, p, NAME_MAX);
> > +                     kfree(p);
> > +                     break;
>
> Please change sessname from a fixed size buffer into a dynamically
> allocated buffer. That will remove the need to perform a strlcpy() and
> will also allow to remove the NAME_MAX checks.
We can change sessname to be dynamically allocated, but I think the
the NAME_MAX check
is not conflicting, we don't want to have that long sessname anyway.

>
> > +             case IBNBD_OPT_DEV_PATH:
> > +                     p = match_strdup(args);
> > +                     if (!p) {
> > +                             ret = -ENOMEM;
> > +                             goto out;
> > +                     }
> > +                     if (strlen(p) > NAME_MAX) {
> > +                             pr_err("map_device: Device path too long\n");
> > +                             ret = -EINVAL;
> > +                             kfree(p);
> > +                             goto out;
> > +                     }
> > +                     strlcpy(pathname, p, NAME_MAX);
> > +                     kfree(p);
> > +                     break;
>
> Same comment here - please change pathname from a fixed-size array into
> a dynamically allocated buffer.
Ditto
>
> > +static ssize_t ibnbd_clt_state_show(struct kobject *kobj,
> > +                                 struct kobj_attribute *attr, char *page)
> > +{
> > +     struct ibnbd_clt_dev *dev;
> > +
> > +     dev = container_of(kobj, struct ibnbd_clt_dev, kobj);
> > +
> > +     switch (dev->dev_state) {
> > +     case (DEV_STATE_INIT):
> > +             return scnprintf(page, PAGE_SIZE, "init\n");
> > +     case (DEV_STATE_MAPPED):
> > +             /* TODO fix cli tool before changing to proper state */
> > +             return scnprintf(page, PAGE_SIZE, "open\n");
> > +     case (DEV_STATE_MAPPED_DISCONNECTED):
> > +             /* TODO fix cli tool before changing to proper state */
> > +             return scnprintf(page, PAGE_SIZE, "closed\n");
> > +     case (DEV_STATE_UNMAPPED):
> > +             return scnprintf(page, PAGE_SIZE, "unmapped\n");
> > +     default:
> > +             return scnprintf(page, PAGE_SIZE, "unknown\n");
> > +     }
> > +}
>
> Please remove the superfluous parentheses from around the DEV_STATE_*
> constants.
>
> Additionally, using scnprintf() here is overkill. snprintf() should be
> sufficient.
You're right, will address both.
>
> > +static struct kobj_attribute ibnbd_clt_state_attr =
> > +     __ATTR(state, 0444, ibnbd_clt_state_show, NULL);
>
> Please use DEVICE_ATTR_RO() instead of __ATTR() for all read-only
> attributes.
DEVICE_ATTR_RO doesn't fit here, will use __ATTR_RO, thanks
>
> > +static ssize_t ibnbd_clt_unmap_dev_store(struct kobject *kobj,
> > +                                      struct kobj_attribute *attr,
> > +                                      const char *buf, size_t count)
> > +{
> > +     struct ibnbd_clt_dev *dev;
> > +     char *opt, *options;
> > +     bool force;
> > +     int err;
> > +
> > +     opt = kstrdup(buf, GFP_KERNEL);
> > +     if (!opt)
> > +             return -ENOMEM;
> > +
> > +     options = strstrip(opt);
> > +     strip(options);
> > +
> > +     dev = container_of(kobj, struct ibnbd_clt_dev, kobj);
> > +
> > +     if (sysfs_streq(options, "normal")) {
> > +             force = false;
> > +     } else if (sysfs_streq(options, "force")) {
> > +             force = true;
> > +     } else {
> > +             ibnbd_err(dev, "unmap_device: Invalid value: %s\n", options);
> > +             err = -EINVAL;
> > +             goto out;
> > +     }
>
> Wasn't sysfs_streq() introduced to avoid having to duplicate and strip
> the input string?
sysfs_streq is only tolerant for trailing newline. we use strstrip to
strip whitespaces, strip for newlines.

>
> > +     /*
> > +      * We take explicit module reference only for one reason: do not
> > +      * race with lockless ibnbd_destroy_sessions().
> > +      */
> > +     if (!try_module_get(THIS_MODULE)) {
> > +             err = -ENODEV;
> > +             goto out;
> > +     }
> > +     err = ibnbd_clt_unmap_device(dev, force, &attr->attr);
> > +     if (unlikely(err)) {
> > +             if (unlikely(err != -EALREADY))
> > +                     ibnbd_err(dev, "unmap_device: %d\n",  err);
> > +             goto module_put;
> > +     }
> > +
> > +     /*
> > +      * Here device can be vanished!
> > +      */
> > +
> > +     err = count;
> > +
> > +module_put:
> > +     module_put(THIS_MODULE);
>
> I've never before seen a module_get() / module_put() pair inside a sysfs
>   callback function. Can this race be fixed by making
> ibnbd_destroy_sessions() remove this sysfs attribute before it tries to
> destroy any sessions?
That's the first thing we do in ibnbd_destroy_sessions already.
>
> > +void ibnbd_clt_remove_dev_symlink(struct ibnbd_clt_dev *dev)
> > +{
> > +     /*
> > +      * The module_is_live() check is crucial and helps to avoid annoying
> > +      * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
> > +      * path was just removed, see ibnbd_close_sessions().
> > +      */
> > +     if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
> > +             sysfs_remove_link(ibnbd_devs_kobj, dev->blk_symlink_name);
> > +}
>
> I haven't been able to find any other sysfs code that calls
> module_is_live()? Please elaborate why that check is needed.

The reason might be lost in the dust, I can retest without module_* to
see if our tests don't break

>
> > +int ibnbd_clt_create_sysfs_files(void)
> > +{
> > +     int err;
> > +
> > +     ibnbd_dev_class = class_create(THIS_MODULE, "ibnbd-client");
> > +     if (unlikely(IS_ERR(ibnbd_dev_class)))
> > +             return PTR_ERR(ibnbd_dev_class);
> > +
> > +     ibnbd_dev = device_create(ibnbd_dev_class, NULL,
> > +                               MKDEV(0, 0), NULL, "ctl");
> > +     if (unlikely(IS_ERR(ibnbd_dev))) {
> > +             err = PTR_ERR(ibnbd_dev);
> > +             goto cls_destroy;
> > +     }
> > +     ibnbd_devs_kobj = kobject_create_and_add("devices", &ibnbd_dev->kobj);
> > +     if (unlikely(!ibnbd_devs_kobj)) {
> > +             err = -ENOMEM;
> > +             goto dev_destroy;
> > +     }
> > +     err = sysfs_create_group(&ibnbd_dev->kobj, &default_attr_group);
> > +     if (unlikely(err))
> > +             goto put_devs_kobj;
> > +
> > +     return 0;
> > +
> > +put_devs_kobj:
> > +     kobject_del(ibnbd_devs_kobj);
> > +     kobject_put(ibnbd_devs_kobj);
> > +dev_destroy:
> > +     device_destroy(ibnbd_dev_class, MKDEV(0, 0));
> > +cls_destroy:
> > +     class_destroy(ibnbd_dev_class);
> > +
> > +     return err;
> > +}
>
> I think this is the wrong way to create a device node because this
> approach will inform udev about device creation before the sysfs group
> has been created. Please use device_create_with_groups() instead of
> calling device_create() and sysfs_create_group() separately.
>
> Bart.
I'm not aware of device_create_with_groups, will try it out.

Thanks,
Jinpu
