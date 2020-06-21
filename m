Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618FB202933
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFUHBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgFUHBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Jun 2020 03:01:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018EC061794
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 00:01:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so14721228ejb.4
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SInjI9WbseW+siuBa4bZ4kAMNxODhCDAjUAIGkxeOU4=;
        b=iLTwONO8WEwf5Qb6cqS5BrzPgaPhBm5j+AUhZ2bC+KO0d82IPjAoDtFwXxSqk8tidn
         /k6TPuhcirINdcgTEE2S6Bx6Y1pgdOogdCv4VOo7QaNtsWUvxCXJauG6ZyOKFow91ilL
         hVmIiTuYcdxPPeYOMfZqKBxvQhcKdjGaXoUPPaoBRBXdaZoZ48cpcQUpLLQpZps7DD4O
         axQo5l3dGZEoLk2I3+5uT4jNFMsZYbOSsMCO38L1GNHw56Yk0uNCyTf04rAqBFsCsTWA
         +mL7dSEe+s4NVbjKTQmni8wl4ERHvKNQUKWkKyzH72Gt08C91N/Pef2qn/Ut/cIfdv7R
         mFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SInjI9WbseW+siuBa4bZ4kAMNxODhCDAjUAIGkxeOU4=;
        b=LtR75kVG6+qQ85CYGzySzONbqoN6mqrFBoYCtT9wgPgrRxZ1gbVZ2LDoJLF0WHtN18
         Gy5j2SsXWJUtZhdrvPFgLoQ5YDRgi8mEZy+YAG1Bbe0PYAlDnKZNfDaf/NSSPS/b1wU0
         /7r3xJr3E+OZC1fLzRdDBzzUCkOQxrftMR76Q+LgQNqt4DcF0Tu3R+ZHPgr5JME6HCvn
         d5NHnvyA2IZMBUjluC7K+O9bgW50W2g4rknj8pfm4r8mzOjAsOBn7jNS8XL84UlmpDVK
         DIM+d+5vh+SbCZCffUaMTDv7rMGiTA5cktf09NUjN9OD4+KrDGb1uYitGhIuWGCkdhh6
         PNtw==
X-Gm-Message-State: AOAM533sHVZgD1j9hYx9d3nTGfPpwDNZOeAz+uft7ljXBW13Xo4udvU7
        NU/tlqefbQGoLip/21RQVRc7cA==
X-Google-Smtp-Source: ABdhPJySgW+d4ClxXJPn8vdjUW04oyKWolXORP9mYUjx6WghR+epVJRYOPyTryPNUKBvKt0iwJpQWw==
X-Received: by 2002:a17:906:8244:: with SMTP id f4mr10904270ejx.257.1592722887336;
        Sun, 21 Jun 2020 00:01:27 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id 36sm9455632edl.31.2020.06.21.00.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 00:01:26 -0700 (PDT)
Subject: Re: [PATCH rdma-core 03/13] verbs: Introduce ibv_import_device() verb
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
 <20200619122928.GT65026@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <5a71a881-6232-e7fb-6f20-10fc973778b2@dev.mellanox.co.il>
Date:   Sun, 21 Jun 2020 10:01:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619122928.GT65026@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/2020 3:29 PM, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 10:45:46AM +0300, Yishai Hadas wrote:
>> +static struct ibv_context *verbs_import_device(int cmd_fd)
>> +{
>> +	struct verbs_device *verbs_device = NULL;
>> +	struct verbs_context *context_ex;
>> +	struct ibv_device **dev_list;
>> +	struct ibv_context *ctx = NULL;
>> +	struct stat st;
>> +	int i;
>> +
>> +	if (fstat(cmd_fd, &st) || !S_ISCHR(st.st_mode)) {
>> +		errno = EINVAL;
>> +		return NULL;
>> +	}
>> +
>> +	dev_list = ibv_get_device_list(NULL);
>> +	if (!dev_list) {
>> +		errno = ENODEV;
>> +		return NULL;
>> +	}
>> +
>> +	for (i = 0; dev_list[i]; ++i) {
>> +		if (verbs_get_device(dev_list[i])->sysfs->sysfs_cdev ==
>> +					st.st_rdev) {
>> +			verbs_device = verbs_get_device(dev_list[i]);
>> +			break;
>> +		}
>> +	}
> 
> Unfortunately it looks like there is a small race here, the struct
> ib_uverbs_file can exist beyond the lifetime of the cdev number - the
> uverbs_ida is freed in ib_uverbs_remove_one() and files can still be
> open past that point.
> 

Are you referring to the option that we might end up with importing a 
device that was already dissociated ?  the below call to 
ops->import_context() will just fail with -EIO upon calling on this FD 
to the query_context method, so I believe that we should be fine here.

> I guess we should add a special ioctl to return the driver_id and
> match that way?
> 
>> +	if (!verbs_device) {
>> +		errno = ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	if (!verbs_device->ops->import_context) {
>> +		errno = EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	context_ex = verbs_device->ops->import_context(&verbs_device->device, cmd_fd);
>> +	if (!context_ex)
>> +		goto out;
>> +
>> +	set_lib_ops(context_ex);
>> +
>> +	ctx = &context_ex->context;
>> +out:
>> +	ibv_free_device_list(dev_list);
>> +	return ctx;
>> +}
>> +
>> +struct ibv_context *ibv_import_device(int cmd_fd)
>> +{
>> +	return verbs_import_device(cmd_fd);
>> +}
> 
> Why two functions? No reason for verbs_import_device()..

Sure, thanks.
> 
> Jason
> 

