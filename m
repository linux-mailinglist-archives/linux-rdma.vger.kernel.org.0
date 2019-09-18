Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD2B6815
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbfIRQ2l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 12:28:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbfIRQ2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 12:28:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so158837pgn.0;
        Wed, 18 Sep 2019 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rdoH0a+QsELg1xLYb3BRFJVMR3oYJaQvDlAnnpQ/PM=;
        b=bK9Vq3TblvSfqvv/1aNf1szX1jyJejp9XwxSByUkAvgI13IrBrqkVTZ8bcyPlmZIp3
         bsuffjyWPy0xodw9EHxE+IJLwS84zfUEnxEbY49CgPe+evZTq5DRNNPX0TjEqLzIX9eg
         izIAQ/sK41Nqx9ch3KVEQDQzMV/fDibXAHwJMxMJ9Nz+/YrAcR8NQFNoz6GoClMiAg+S
         wajmj88wncGbDYOZ7VHnjNf4fBQY0rFhVbZsbFgurlSXd7V+NRGuPusZ+U8Hcpm32jkB
         uNErCXhb3vFs/CvAe/9aQ1Sda9HJdUCfpZVgedekq4M6ptzsxd3NOik8ppKOBg/uOaMu
         DsZg==
X-Gm-Message-State: APjAAAXAnJJ1atpzbdaSGh4wyM8OF0VptR/0947yjTIg4VpgzZ3SErG2
        5FdlHWw5aJJ2O0s0qJySotA=
X-Google-Smtp-Source: APXvYqzptXgIyKHsvSdcdY3sDKO5CqyDUw+mtcCNzkaYkyyx539NG3satsFU3FYgK1eu/sozeAtKHA==
X-Received: by 2002:a65:6716:: with SMTP id u22mr4741660pgf.192.1568824119817;
        Wed, 18 Sep 2019 09:28:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q42sm3246212pja.16.2019.09.18.09.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:28:39 -0700 (PDT)
Subject: Re: [PATCH v4 18/25] ibnbd: client: sysfs interface functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-19-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <05192413-4b0c-76fd-7459-bc6d430b46a6@acm.org>
Date:   Wed, 18 Sep 2019 09:28:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-19-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt

Including the line number in all messages is too much information. 
Please don't do this. Additionally, this will make the line number occur 
twice in messages produced by pr_debug().

> +static unsigned int ibnbd_opt_mandatory[] = {
> +	IBNBD_OPT_PATH,
> +	IBNBD_OPT_DEV_PATH,
> +	IBNBD_OPT_SESSNAME,
> +};

Should this array have been declared const?

 > +/* remove new line from string */
 > +static void strip(char *s)
 > +{
 > +	char *p = s;
 > +
 > +	while (*s != '\0') {
 > +		if (*s != '\n')
 > +			*p++ = *s++;
 > +		else
 > +			++s;
 > +	}
 > +	*p = '\0';
 > +}

This function can remove a newline from the middle of a string. Are you 
sure that's what you want?

Is it useful to strip newline characters only and to keep other 
whitespace? Could this function be dropped and can the callers use 
strim() instead?

> +static int ibnbd_clt_parse_map_options(const char *buf,
> +				       char *sessname,
> +				       struct ibtrs_addr *paths,
> +				       size_t *path_cnt,
> +				       size_t max_path_cnt,
> +				       char *pathname,
> +				       enum ibnbd_access_mode *access_mode,
> +				       enum ibnbd_io_mode *io_mode)
> +{

Please introduce a structure for all the output parameters of this 
function and pass a pointer to that structure to this function. That 
will make it easier to introduce support for new parameters.

> +	char *options, *sep_opt;
> +	char *p;
> +	substring_t args[MAX_OPT_ARGS];
> +	int opt_mask = 0;
> +	int token;
> +	int ret = -EINVAL;
> +	int i;
> +	int p_cnt = 0;
> +
> +	options = kstrdup(buf, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	sep_opt = strstrip(options);
> +	strip(sep_opt);

Are you sure that strstrip() does not remove trailing newline characters?

> +	while ((p = strsep(&sep_opt, " ")) != NULL) {
> +		if (!*p)
> +			continue;
> +
> +		token = match_token(p, ibnbd_opt_tokens, args);
> +		opt_mask |= token;
> +
> +		switch (token) {
> +		case IBNBD_OPT_SESSNAME:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) > NAME_MAX) {
> +				pr_err("map_device: sessname too long\n");
> +				ret = -EINVAL;
> +				kfree(p);
> +				goto out;
> +			}
> +			strlcpy(sessname, p, NAME_MAX);
> +			kfree(p);
> +			break;

Please change sessname from a fixed size buffer into a dynamically 
allocated buffer. That will remove the need to perform a strlcpy() and 
will also allow to remove the NAME_MAX checks.

> +		case IBNBD_OPT_DEV_PATH:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) > NAME_MAX) {
> +				pr_err("map_device: Device path too long\n");
> +				ret = -EINVAL;
> +				kfree(p);
> +				goto out;
> +			}
> +			strlcpy(pathname, p, NAME_MAX);
> +			kfree(p);
> +			break;

Same comment here - please change pathname from a fixed-size array into 
a dynamically allocated buffer.

> +static ssize_t ibnbd_clt_state_show(struct kobject *kobj,
> +				    struct kobj_attribute *attr, char *page)
> +{
> +	struct ibnbd_clt_dev *dev;
> +
> +	dev = container_of(kobj, struct ibnbd_clt_dev, kobj);
> +
> +	switch (dev->dev_state) {
> +	case (DEV_STATE_INIT):
> +		return scnprintf(page, PAGE_SIZE, "init\n");
> +	case (DEV_STATE_MAPPED):
> +		/* TODO fix cli tool before changing to proper state */
> +		return scnprintf(page, PAGE_SIZE, "open\n");
> +	case (DEV_STATE_MAPPED_DISCONNECTED):
> +		/* TODO fix cli tool before changing to proper state */
> +		return scnprintf(page, PAGE_SIZE, "closed\n");
> +	case (DEV_STATE_UNMAPPED):
> +		return scnprintf(page, PAGE_SIZE, "unmapped\n");
> +	default:
> +		return scnprintf(page, PAGE_SIZE, "unknown\n");
> +	}
> +}

Please remove the superfluous parentheses from around the DEV_STATE_* 
constants.

Additionally, using scnprintf() here is overkill. snprintf() should be 
sufficient.

> +static struct kobj_attribute ibnbd_clt_state_attr =
> +	__ATTR(state, 0444, ibnbd_clt_state_show, NULL);

Please use DEVICE_ATTR_RO() instead of __ATTR() for all read-only 
attributes.

> +static ssize_t ibnbd_clt_unmap_dev_store(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct ibnbd_clt_dev *dev;
> +	char *opt, *options;
> +	bool force;
> +	int err;
> +
> +	opt = kstrdup(buf, GFP_KERNEL);
> +	if (!opt)
> +		return -ENOMEM;
> +
> +	options = strstrip(opt);
> +	strip(options);
> +
> +	dev = container_of(kobj, struct ibnbd_clt_dev, kobj);
> +
> +	if (sysfs_streq(options, "normal")) {
> +		force = false;
> +	} else if (sysfs_streq(options, "force")) {
> +		force = true;
> +	} else {
> +		ibnbd_err(dev, "unmap_device: Invalid value: %s\n", options);
> +		err = -EINVAL;
> +		goto out;
> +	}

Wasn't sysfs_streq() introduced to avoid having to duplicate and strip 
the input string?

> +	/*
> +	 * We take explicit module reference only for one reason: do not
> +	 * race with lockless ibnbd_destroy_sessions().
> +	 */
> +	if (!try_module_get(THIS_MODULE)) {
> +		err = -ENODEV;
> +		goto out;
> +	}
> +	err = ibnbd_clt_unmap_device(dev, force, &attr->attr);
> +	if (unlikely(err)) {
> +		if (unlikely(err != -EALREADY))
> +			ibnbd_err(dev, "unmap_device: %d\n",  err);
> +		goto module_put;
> +	}
> +
> +	/*
> +	 * Here device can be vanished!
> +	 */
> +
> +	err = count;
> +
> +module_put:
> +	module_put(THIS_MODULE);

I've never before seen a module_get() / module_put() pair inside a sysfs 
  callback function. Can this race be fixed by making 
ibnbd_destroy_sessions() remove this sysfs attribute before it tries to 
destroy any sessions?

> +void ibnbd_clt_remove_dev_symlink(struct ibnbd_clt_dev *dev)
> +{
> +	/*
> +	 * The module_is_live() check is crucial and helps to avoid annoying
> +	 * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
> +	 * path was just removed, see ibnbd_close_sessions().
> +	 */
> +	if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
> +		sysfs_remove_link(ibnbd_devs_kobj, dev->blk_symlink_name);
> +}

I haven't been able to find any other sysfs code that calls 
module_is_live()? Please elaborate why that check is needed.

> +int ibnbd_clt_create_sysfs_files(void)
> +{
> +	int err;
> +
> +	ibnbd_dev_class = class_create(THIS_MODULE, "ibnbd-client");
> +	if (unlikely(IS_ERR(ibnbd_dev_class)))
> +		return PTR_ERR(ibnbd_dev_class);
> +
> +	ibnbd_dev = device_create(ibnbd_dev_class, NULL,
> +				  MKDEV(0, 0), NULL, "ctl");
> +	if (unlikely(IS_ERR(ibnbd_dev))) {
> +		err = PTR_ERR(ibnbd_dev);
> +		goto cls_destroy;
> +	}
> +	ibnbd_devs_kobj = kobject_create_and_add("devices", &ibnbd_dev->kobj);
> +	if (unlikely(!ibnbd_devs_kobj)) {
> +		err = -ENOMEM;
> +		goto dev_destroy;
> +	}
> +	err = sysfs_create_group(&ibnbd_dev->kobj, &default_attr_group);
> +	if (unlikely(err))
> +		goto put_devs_kobj;
> +
> +	return 0;
> +
> +put_devs_kobj:
> +	kobject_del(ibnbd_devs_kobj);
> +	kobject_put(ibnbd_devs_kobj);
> +dev_destroy:
> +	device_destroy(ibnbd_dev_class, MKDEV(0, 0));
> +cls_destroy:
> +	class_destroy(ibnbd_dev_class);
> +
> +	return err;
> +}

I think this is the wrong way to create a device node because this 
approach will inform udev about device creation before the sysfs group 
has been created. Please use device_create_with_groups() instead of 
calling device_create() and sysfs_create_group() separately.

Bart.
