Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8521CDF24
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEKPfj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgEKPfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 11:35:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054AC061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 08:35:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w19so5071229wmc.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzN+NauwtXiKnUj0Cs55Qpnrqyr6jxztItXCnTDR5mE=;
        b=eB37HafDVnW/iNHZY85fHYvmqSoIf7oV19tHWx6F8RcBwg7S+CpTknudX/7b/jLq6c
         hj+0CTBVHS2yWr0aaomCBVZ7csjjrwg3aKzhBRLAJmKvBnjRUvGEvTTQjB3AYMd0fz/J
         H3FWAO2wpsCbrgiGQkrfLg1zfPiLyTZLxsQRiNeaqvd4S21qfgn4vCYblTTw0SP5G/qU
         HpduDRjufRAmk9XyCJoO+RTnAvej3rsXm6qE03jcm+2sr/m0UbO/lppfp79jjhQug934
         H6SISVKYuJyIX/5C4i7PrrH0Y3SaQ1iT5xAYgoT5inNLdDtilpP/mW2rNKmB73h4Nihu
         6O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzN+NauwtXiKnUj0Cs55Qpnrqyr6jxztItXCnTDR5mE=;
        b=bzC3TPu2XNHT8S8Qk+O7dpjIGTljbkN0ZrogudvaYVEq8H+dwXyG8TthyTfzINfJu9
         IKS1Ouy8QcwWgn8+T1YKcLAjLWK9uzbIQijYD4xW08b05rD+VjymXoOAiSKg8Ed2WpYe
         aeFhjEVuHkq3XuVQvIkWfkQE4Z+wEyE66RPQlVEypetHEbAWj+SU9bHeZbrrEWlX/ifu
         H5FuX20uTYo96o46WDs7sQe7+s4Z93Adz/jJ4dPO6z7swvRUCtamjcwKkZqvjrFEewxw
         UL5LkT3+eCHzvd/yQO0TiESujaaESvo1KiuTTp1Ob8KqL0MXJiUHsK/PJcAONLiKqLJQ
         SrSg==
X-Gm-Message-State: AGi0PuYjOWt7gWA+n67U38TIuwDwCZY+CXdspEaZP4wkI/QXqFufQcAX
        awMvdDwJJNc4zqgfF/kehFXVMg==
X-Google-Smtp-Source: APiQypJ1NJr0RknVyxQtyGuEet1VrEOfp+pPRgriN9Z0/6rjHpxFloUscnlGHNw/2FRpTgI+oYyCPg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr34089187wmh.31.1589211337956;
        Mon, 11 May 2020 08:35:37 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.133])
        by smtp.googlemail.com with ESMTPSA id g15sm10077272wro.71.2020.05.11.08.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 08:35:37 -0700 (PDT)
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
To:     Gal Pressman <galpress@amazon.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@mellanox.com, maorg@mellanox.com, Alexr@mellanox.com
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
 <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
Date:   Mon, 11 May 2020 18:35:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/11/2020 5:31 PM, Gal Pressman wrote:
> On 11/05/2020 16:12, Yishai Hadas wrote:
>> Introduce import verbs for device, PD, MR, it enables processes to share
>> their ibv_contxet and then share PD and MR that is associated with.
>>
>> A process is creating a device and then uses some of the Linux systems
>> calls to dup its 'cmd_fd' member which lets other process to obtain
>> owning on.
>>
>> Once other process obtains the 'cmd_fd' it can call ibv_import_device()
>> which returns an ibv_contxet on the original RDMA device.
>>
>> On the imported device there is an option to import PD(s) and MR(s) to
>> achieve a sharing on those objects.
>>
>> This is the responsibility of the application to coordinate between all
>> ibv_context(s) that use the imported objects, such that once destroy is
>> done no other process can touch the object except for unimport. All
>> users of the context must collaborate to ensure this.
>>
>> A matching unimport verbs where introduced for PD and MR, for the device
>> the ibv_close_device() API should be used.
>>
>> Detailed man pages are introduced as part of this RFC patch to clarify
>> the expected usage and notes.
>>
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> 
> Hi Yishai,
> 
> A few questions:
> Can you please explain the use case? I remember there was a discussion on the
> previous shared PD kernel submission (by Yuval and Shamir) but I'm not sure if
> there was a conclusion.
> 

The expected flow and use case are as follows.

One process creates an ibv_context by calling ibv_open_device() and then 
enables owning of its 'cmd_fd' with other processes by some Linux system 
call, (see man page as part of this RFC for some alternatives). Then 
other process that owns this 'cmd_fd' will be able to have its own 
ibv_context for the same RDMA device by calling ibv_import_device().

At that point those processes really work on same kernel context and 
PD(s), MR(s) and potentially other objects in the future can be shared 
by calling ibv_import_pd()/mr() assuming that the initiator process 
let's the other ones know the kernel handle value.

Once a PD and MR which points to this PD were shared it enables a memory 
that was registered by one process to be used by others with the 
matching lkey/rkey for RDMA operations.

> Could you please elaborate more how the process cleanup flow (e.g killed
> process) is going to change? I know it's a very broad question but I'm just
> trying to get the general idea.
> 

For now the model in those suggested APIs is that cleanup will be done 
or explicitly by calling the relevant destroy command or alternatively 
once all processes that own the cmd_fd will be closed.

 From kernel side there is only one object and its ref count is not 
increased as part of the import_xxx() functions, see in the man pages 
some notes regarding this point.


> What's expected to happen in a case where we have two processes P1 & P2, both
> use a shared PD, but separate MRs and QPs (created under the same shared PD).
> Now when an RDMA read request arrives at P2's QP, but refers to an MR of P1
> (which was not imported, but under the same PD), how would you expect the device
> to handle that?
> 

The processes are behaving almost like 2 threads each have a QP and an 
MR, if you mix them around it will work just like any buggy software.
In this case I would expect the device to scatter to the MR that was 
pointed by the RDMA read request, any reason that it will behave 
differently ?

Yishai
