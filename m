Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109CA206D80
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbgFXHXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389724AbgFXHXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 03:23:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D356C061573
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 00:22:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so1431732ejb.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nyxBBJkZSluN196PCm6LChCvpAmVUaHWJJdq7Mn3Mxk=;
        b=YGCxeMO7NpvRF3A0DMKGECb/hmQMy8c/t1zbtEPnc3A+V2GtlHrerJjT0fwsBJTUo3
         iLsEvqGBKi74omsaEaEvtmKONfuNVjOcLx99JFK/Br39VIKL9F0e1wqYznxKgn+XufUE
         SBwczFnzUB5p3m3dK/BcJ0E+8V3NFm6pfafXny4xhY+KSTfIiV8WFNA8YxHFz4Gdu230
         PM+US1HXDL6VOjxvZLegU1eCtot0TvLv82aIb/DuBPc3cAPKCDeDY/VtGyKLxLjxnmko
         DCzi67Jdw00dxIoygzXGOlFHhl3xRg09pMr8bXWtPMQ40sFqatc0kBWoVpwe8FM/IACB
         Luzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nyxBBJkZSluN196PCm6LChCvpAmVUaHWJJdq7Mn3Mxk=;
        b=C/PpdWW0vJW9wKTzZmmNRQxz/IrsbE9ej9AdavyT4uja1prPWClu90BnPgcfqX5yuY
         zfCgOXTJMPD7tPB8IgY4guwvkrLW9PYtU2ggYN+kBGW6UXjmeGVV2ZxhC14g5c7XPdVw
         LH+PBKbhc0DM+eNebUHirMOcNiBvhIf9x64HWWiFJktKNi+TkPiBA2IbAJBmwbqjhwi+
         qpd1vGT0JAxiQ4RVS5EPywtp+8tEZvh+85DjL6cC/+7yhHOyLBuaX3N+CA4LOaEzOVh7
         c3qVFRVhMd2rJF3vvzKYxF+3hM2o10qZtLTQ5jW2VWS4YBEZqCITvHzhnA/S49KwrNUu
         h3UQ==
X-Gm-Message-State: AOAM531eTqbS9uOlB6YmOnfzfIgAa21xZmdg4WZRg7wQfaikDX9HO3yo
        I+TxXx0LaERSBmyY56bfAChAWw==
X-Google-Smtp-Source: ABdhPJxkPbavJBudShR4zBGMSJJdcBGMe5gPuu2RuZIq65LA8U/r4yIV/iS5yIga6CWWjlg00HPKRQ==
X-Received: by 2002:a17:906:fb93:: with SMTP id lr19mr4777747ejb.333.1592983378226;
        Wed, 24 Jun 2020 00:22:58 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id g25sm15888539edq.34.2020.06.24.00.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 00:22:57 -0700 (PDT)
Subject: Re: [PATCH rdma-core 04/13] verbs: Handle async FD on an imported
 device
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-5-git-send-email-yishaih@mellanox.com>
 <20200619123332.GU65026@mellanox.com>
 <778c127c-00c9-9b2d-6c81-a96e51029324@dev.mellanox.co.il>
 <20200623173401.GL2874652@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <1704061f-3180-df86-feb9-9a1da30ba361@dev.mellanox.co.il>
Date:   Wed, 24 Jun 2020 10:22:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623173401.GL2874652@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/23/2020 8:34 PM, Jason Gunthorpe wrote:
> On Sun, Jun 21, 2020 at 12:08:57PM +0300, Yishai Hadas wrote:
>> On 6/19/2020 3:33 PM, Jason Gunthorpe wrote:
>>> On Wed, Jun 17, 2020 at 10:45:47AM +0300, Yishai Hadas wrote:
>>>> @@ -418,7 +427,13 @@ static struct ibv_context *verbs_import_device(int cmd_fd)
>>>>    	set_lib_ops(context_ex);
>>>> +	context_ex->priv->imported = true;
>>>>    	ctx = &context_ex->context;
>>>> +	ret = ibv_cmd_alloc_async_fd(ctx);
>>>> +	if (ret) {
>>>> +		ibv_close_device(ctx);
>>>> +		ctx = NULL;
>>>> +	}
>>>>    out:
>>>>    	ibv_free_device_list(dev_list);
>>>>    	return ctx;
>>>
>>> This hunk should probably be in the prior patch, or ideally the order
>>> of these two patches should be swapped.
>>>
>>
>> I can swap the order of those two patches as you suggested.
>> However, in this case, the first one will be some preparation to force the
>> ioctl mode upon an 'imported' flow and only then the second one will
>> introduce the 'imported' flow as part of adding ibv_import_device().
>> If you are fine with that let's go by that approach.
> 
> prep patches are better than having patches with incomplete
> functionality
> 

Agree, already was updated in the PR accordingly.

Yishai
