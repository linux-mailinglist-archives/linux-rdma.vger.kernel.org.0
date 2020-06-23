Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5820530D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgFWNG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWNG0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 09:06:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF59C061573
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 06:06:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so10221857ejq.6
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTlohK0P9ei8yfc5ynEDewUn/lCRNbi/T6DFbF2JE7U=;
        b=hJzM25c6nWZin96o6gSaViI+ZUcOSX2glyNJcyvLY8Yo2OfmnwqGeWCwvLZ1i4OHNd
         ZUXPC/UCPFI+wxlm8TO2XoJzawa1SgzZu33sQqHzjLU+YszhrQucYhfuOwtj0dGeFqcN
         rkUaGsVBhcFCoK/bGrexiSKIYzNj8Xnod3+nXCcs3z/wUV7/hK6wXqE3HvmnEgOyle4u
         mF1zrHVZDpdj8hfzOu4k1146cOLDRQo/mgHts8aiaqgwynC3/RzdRZ28p2cyvLPQ/MUk
         u8Y5XlRL5tZitbsSdY6oIuu2SqcdUHfHrDL4oe8OVxtE6OT9uHrD9LwtUmV8bluwmBE4
         +oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTlohK0P9ei8yfc5ynEDewUn/lCRNbi/T6DFbF2JE7U=;
        b=KWchavsSOYhabFv/gE//BCpTM9FW5SERbQUIGCX1vaxRxTHgXBy18WYfB714oHgRO1
         kwue193dYZ6O6zuvHq4+Bm8GepzzW2SpIM1oR0G97x7tuaY2m8EBFZMRg9QZs3JKniyw
         xO/o/QPnV8vvDpDgTeGGvemTRazNzRHMnS/2GC9FJV7kMFHmwBZdAaEJM/KhetEVD680
         DBEhjZUPD//tuiJhgs3C6QDc+B/wFgIx2WAbPeAjiO/84nbGRbs2oWL//2k110u41Acg
         3C+DJkUiMnluWbyljrUQvE/Q5VMe2SR78pf4+qojyvNgBjoT+uvkU3TqI3wgOCBIX+0f
         2b7w==
X-Gm-Message-State: AOAM532iDkH+2sMlU7Sv4wjFgC5v4YYD5stCfIwftR0JXa8GNLrQR5Dl
        kMVfBgQXH5Nbkn4XN3Tis6YJg4sKBMw=
X-Google-Smtp-Source: ABdhPJw/dYG+umE54XsKIUS1h7PLeP+tqnItCl0/RYfZXnwF3jUFyhWKaJZK+YyHoIhvaqvpGM8KWQ==
X-Received: by 2002:a17:906:4155:: with SMTP id l21mr13619085ejk.438.1592917585195;
        Tue, 23 Jun 2020 06:06:25 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id a9sm14484440edr.23.2020.06.23.06.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 06:06:23 -0700 (PDT)
Subject: Re: [PATCH rdma-core 03/13] verbs: Introduce ibv_import_device() verb
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
 <20200619122928.GT65026@mellanox.com>
 <5a71a881-6232-e7fb-6f20-10fc973778b2@dev.mellanox.co.il>
 <20200622125256.GD2590509@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <aab99bf5-992c-56e4-d844-b50b1560e485@dev.mellanox.co.il>
Date:   Tue, 23 Jun 2020 16:06:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622125256.GD2590509@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/22/2020 3:52 PM, Jason Gunthorpe wrote:
> On Sun, Jun 21, 2020 at 10:01:24AM +0300, Yishai Hadas wrote:
>> On 6/19/2020 3:29 PM, Jason Gunthorpe wrote:
>>> On Wed, Jun 17, 2020 at 10:45:46AM +0300, Yishai Hadas wrote:
>>>> +static struct ibv_context *verbs_import_device(int cmd_fd)
>>>> +{
>>>> +	struct verbs_device *verbs_device = NULL;
>>>> +	struct verbs_context *context_ex;
>>>> +	struct ibv_device **dev_list;
>>>> +	struct ibv_context *ctx = NULL;
>>>> +	struct stat st;
>>>> +	int i;
>>>> +
>>>> +	if (fstat(cmd_fd, &st) || !S_ISCHR(st.st_mode)) {
>>>> +		errno = EINVAL;
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	dev_list = ibv_get_device_list(NULL);
>>>> +	if (!dev_list) {
>>>> +		errno = ENODEV;
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	for (i = 0; dev_list[i]; ++i) {
>>>> +		if (verbs_get_device(dev_list[i])->sysfs->sysfs_cdev ==
>>>> +					st.st_rdev) {
>>>> +			verbs_device = verbs_get_device(dev_list[i]);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>
>>> Unfortunately it looks like there is a small race here, the struct
>>> ib_uverbs_file can exist beyond the lifetime of the cdev number - the
>>> uverbs_ida is freed in ib_uverbs_remove_one() and files can still be
>>> open past that point.
>>>
>>
>> Are you referring to the option that we might end up with importing a device
>> that was already dissociated ?  the below call to ops->import_context() will
>> just fail with -EIO upon calling on this FD to the query_context method, so
>> I believe that we should be fine here.
> 
> Okay, lets have a comment then, it is tricky
> 

Sure, I have updated the PR accordingly.
It includes also fixes to other notes that you already pointed on, thanks.

Yishai
