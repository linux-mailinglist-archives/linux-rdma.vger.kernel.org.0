Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25AD10326D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 05:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKTEFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 23:05:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39484 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKTEFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 23:05:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id b126so1281228pga.6
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 20:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ryussi-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g8kLjqRS4nkr82iaaUyYPYix5m87gelxUCSvcpoYL4c=;
        b=RAycph/cS8Q4X1KjY98R4tamz3XmZgRBVpqnOu6c8AGADVrg2XJN2CEW8a/ns+q6GR
         lYgy/h9HUbUAbc/PwoE9+odab352imFHI3MaFYR6BPhOB+8stXEziMFaTl9uU2Q229jQ
         2K4dqIm1Q7j8SBBqAAq15JRol1QOv7jLXTzrqhKRIJhtfNGun9yAVZOaxu6P8y3k0e/F
         rfY6g3D8iur0sjwkjZtcogZ1Kt/prWpuJtb24mES7aOAbX4b4qplHDTCX35+FUnXu7Y3
         oIxa7BIjwqtGU8/PE+Jj1skO5y+bDLwxZY4cX6y7GFs0QDkoZbxcDR/FPifMBFwXMU6R
         bSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g8kLjqRS4nkr82iaaUyYPYix5m87gelxUCSvcpoYL4c=;
        b=nX9p+4FFb1S47tsds3J9vGHVMiNm+zV5vH+AskQyS5BAiqj4ZPZ5Woqt7+TauKNftD
         OZ8tStwio5zGBfLwafSWnWrRTcvKAV6antx9DOSLP9XbYDbJ0012uxMS4C1ysqryqwil
         qsj6VIW6zdrlBpC/QQaZvsQ5/t/B4cWZ5Yoh9ZxuJTUpuofJCc69vglayxyayI74Uq0I
         s1cLcwlk0HswYmchkHDWj9T/AqSJXsMkdvpCl39PAm7FQOaUaRl6ScWB3s/AV5Qgqp89
         NG8ofEo6s98wZ7JEvnrATOshGIFEuo5gVJOz8oAYyUZ4xlHXjmZ95Kc/iKEesp3zd8mB
         kZLw==
X-Gm-Message-State: APjAAAXmkY50bXMCv8w9UpVa3JNy90yd1i5jpxFSSegAQFiW5j7ssPeK
        3wjdWgSWqOeJX/nLNsX4raema3ADu5Q=
X-Google-Smtp-Source: APXvYqyhwn5N6mCNIksC28LhryUV4MQPNXEuW+LezK/ZhtBljA3IG7IB8e4823VPWm1Y/N8hGYXTJw==
X-Received: by 2002:a63:5d26:: with SMTP id r38mr823477pgb.48.1574222714987;
        Tue, 19 Nov 2019 20:05:14 -0800 (PST)
Received: from [172.31.254.84] ([182.73.204.74])
        by smtp.gmail.com with ESMTPSA id u7sm26453905pfh.84.2019.11.19.20.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 20:05:14 -0800 (PST)
Subject: Re: [question] ibv_reg_mr() returning EACCESS
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
 <20191115141210.GC4055@ziepe.ca>
 <cc6543bd-0c8d-40e3-f384-68a847b873b3@ryussi.com>
 <20191119233400.GP4991@ziepe.ca>
From:   Vinit Agnihotri <vinita@ryussi.com>
Message-ID: <1d17a8f1-388f-239b-9032-db4706842dd1@ryussi.com>
Date:   Wed, 20 Nov 2019 09:35:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119233400.GP4991@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you Jason,

I'll sure take a look.


Regards,

Vinit.

On 20/11/19 5:04 AM, Jason Gunthorpe wrote:
> You need this kernel commit
>
> commit 4785860e04bc8d7e244b25257168e1cf8a5529ab
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Fri Nov 30 13:06:21 2018 +0200
>
>      RDMA/uverbs: Implement an ioctl that can call write and write_ex handlers
>      
>      Now that the handlers do not process their own udata we can make a
>      sensible ioctl that wrappers them. The ioctl follows the same format as
>      the write_ex() and has the user explicitly specify the core and driver
>      in/out opaque structures and a command number.
>      
>      This works for all forms of write commands.
>      
>      Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>      Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>      Signed-off-by: Doug Ledford <dledford@redhat.com>
>
> And a rdma-core new enough to call UVERBS_METHOD_INVOKE_WRITE
>
> On Mon, Nov 18, 2019 at 10:29:33AM +0530, Vinit Agnihotri wrote:
>> Thank you Jason.
>>
>> I did went through archives for the same.
>>
>> Can you please provide pointer towards documentation or
>>
>> sample userspace usage for the same? Or which kernel version to be looked
>> into?
>>
>>
>> Thanks & Regards,
>>
>> Vinit.
>>
>> On 15/11/19 7:42 PM, Jason Gunthorpe wrote:
>>> On Fri, Nov 15, 2019 at 09:27:40AM +0530, Vinit Agnihotri wrote:
>>>> Hi,
>>>>
>>>> I am trying to use setfsgid()/setfssid() calls to ensure proper access check
>>>> for linux users.
>>>>
>>>> However if user is non-root then ibv_reg_mr() returns EACCESS. While I am
>>>> sure I am calling ibv_reg_mr()
>>>>
>>>> as root user, not sure why it still returns EACCESS.
>>>>
>>>> While going through libibverbs sources I realize EACCESS might be returned
>>>> by this call:
>>>>
>>>> if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
>>>>           return errno;
>>>>
>>>> Can anyone provide any insight into this behavior? Does calling these
>>>> systems calls in threads can affect
>>>>
>>>> entire process? I checked /dev/infiniband/* has appropriate privileges.
>>> This is a security limitation, if you want do this flow you need a new
>>> enough kernel and rdma-core to support the ioctl() scheme for calling
>>> verbs
>>>
>>> Jason
