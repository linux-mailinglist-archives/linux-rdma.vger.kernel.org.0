Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58687140F07
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAQQfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 11:35:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42275 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jan 2020 11:35:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so10064728plk.9;
        Fri, 17 Jan 2020 08:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MKjwyU5xxChThHG6yIW2AZm0A76+EMtzB7P4sghv6Po=;
        b=R/1GHGcbjxflEZSpnSGLA1Odn15Go2twSzAgEhT6XZ3IztFWRrMpg/wfrG3V2JPh1N
         9JIhYKQdJc9d1kptf0XN4BTQVkxdQGQLpzSADBprNl7BlbvbdnY88TjK2Bu59tiRWI1m
         dQNFYuZC/3UizvsqNyc0UnrM3xtjEbqBEaKWD8rcLa8bYNeiBRjQmJO8MjEj3+Qx++fM
         gIxzcxRyzzBQjOrxCEQlahaXZjB5i/FJ3n1ruhm7LysL2hoogW8bsmREfovvbwkMkiYd
         6hgsdUSJXyiBiYc4zqArq0StByu2lFE71fODpQh/9pNkyu/8cnfDly7Kb6OvMJOtITu1
         cb8A==
X-Gm-Message-State: APjAAAUCPvpdC4YeTJt9rFBGzwCZfWEiYNCXUv1At3gJJ6tZXfvRDDB1
        9wYVm6kP6gJm9Xr+ljT+B61HnXqDTX4=
X-Google-Smtp-Source: APXvYqxHQu0zAODRouKUtkXHGcwbV3/JbSPRbxUFkd+AqPVzSGKwJy1QsUsCawDv0AqLYVI6iNxuBQ==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr31210159plb.13.1579278906911;
        Fri, 17 Jan 2020 08:35:06 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e2sm8052194pjs.25.2020.01.17.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:35:05 -0800 (PST)
Subject: Re: Recent trace observed in target code during iSer testing
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
References: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <3b724797-275a-9a14-1503-1778780a5872@acm.org>
 <MWHPR1101MB227100196B12AF2494BB184F863E0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <MWHPR1101MB227156761E41FA7C47DAE5A486310@MWHPR1101MB2271.namprd11.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a686b847-846e-1495-a7ff-d6184631e296@acm.org>
Date:   Fri, 17 Jan 2020 08:35:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MWHPR1101MB227156761E41FA7C47DAE5A486310@MWHPR1101MB2271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/17/20 7:55 AM, Marciniszyn, Mike wrote:
>> Subject: RE: Recent trace observed in target code during iSer testing
>>
>>>
>>> A candidate fix has been posted but needs review and/or a Tested-by. See
>>> also https://www.spinics.net/lists/target-devel/msg17981.html.
>>>
>>> Thanks,
>>>
>>> Bart.
>>
>> I'm testing this now.
>>
> 
> I have tested this change an it certainly eliminates the percpu message.
> 
> Have you submitted a patch?  I actually extracted the patch from the email thread.
> 
> When you do feel free to add:
> Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Thanks Mike for having tested this patch. The patch itself has been 
cross-posted to the target-devel and linux-rdma mailing lists. See also 
https://lore.kernel.org/linux-rdma/20200116044737.19507-1-bvanassche@acm.org/

Bart.

