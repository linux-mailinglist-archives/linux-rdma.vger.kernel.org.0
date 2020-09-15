Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24726AEB6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIOUeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 16:34:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35283 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgIOUdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 16:33:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id o68so2648336pfg.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Sep 2020 13:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RXW/eLZI8Sy77ZEMvS/zwoaoRg+vHMc4xyAMcTVg7QQ=;
        b=Xlx+pG0qz13r0q9j8JY3BShYT06a9ocjAOLuhQwrUvrhhzXMDMLk5/q8gfh1YCnsC5
         OiI0pjS6rzpmssWNauNjF0XNBOSp/IQrio8eSE62q05nepKlFi4l+KoNAkzfuw5KXdsl
         XMjLlNRyCrJLNudxDvkxlImMbmX97rhZ404WvI2AgpzVFFD3fnDtJE9slJopvaDcDbuz
         lWfG5i8tnXfukjmD0Y5zHVkOYct8UlJcGfrjnWM8ROxg9hUPeGef+PjIBTkNy52we0d+
         /S2HNThoKfFBfbpC7DSYKWxXEkJPgPSegejIX2TTystSpogYmW80mD/xdVDHlu49vG6k
         GFCg==
X-Gm-Message-State: AOAM533h3NBxuNRL6rugm8LaGwJQ2QsEsmlhsFFXrZKQc9u2mOWBPbON
        9CKJHeBjssFXPtgH0S/XnHM=
X-Google-Smtp-Source: ABdhPJzJIT3F5g32E46MDmoGmleK5F2yhof4dkoHS/lDK/yer+6hbPh8JLjSUHUYGawNMDkxD0icOg==
X-Received: by 2002:a63:355:: with SMTP id 82mr15423018pgd.384.1600201950530;
        Tue, 15 Sep 2020 13:32:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:cf06:df5:7551:f96f? ([2601:647:4000:d7:cf06:df5:7551:f96f])
        by smtp.gmail.com with ESMTPSA id p29sm11844695pgl.34.2020.09.15.13.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 13:32:29 -0700 (PDT)
Subject: Re: [PATCH] srp_daemon: Avoid extra permissions for the lock file
To:     Sergey Gorenko <sergeygo@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20200819141745.11005-1-sergeygo@nvidia.com>
 <7027c39a-1435-c4eb-d42f-c7fe272456a8@acm.org>
 <BN8PR12MB32208D60B5E5E1AFBDBAF0CCBF200@BN8PR12MB3220.namprd12.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <e6c1888e-8488-4255-edda-7fa1648ca957@acm.org>
Date:   Tue, 15 Sep 2020 13:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB32208D60B5E5E1AFBDBAF0CCBF200@BN8PR12MB3220.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-09-15 01:10, Sergey Gorenko wrote:
> I tested the patch for the following scenarios:
> * Start the srp_daemon service when srp_daemon is not running and the lock file does not exist.
> * Start the srp_daemon service when srp_daemon is not running and the lock file exists.
> * Start the srp_daemon service when srp_daemon is running and the lock file exists.
> * Start the srp_daemon service when srp_daemon is running and the lock file exists and the file owner is not root. (Such scenario can happen if someone tries to run srp_daemon manually as not root. The srp_daemon fails in this case, but the lock file is created). This case is handled successfully even without the fchmod() call because the srp_daemon service starts srp_daemon as root.
>  
> I do not know any case when fchmod() is needed. And it does not look like a good idea to create a word-writable file owned by root. That's why I want to remove the fchmod() call.
>  
> Do you have an idea when the fchmod() call can be needed?
>  
> If you have no other objections, I will add the fixes line and send V1.

Thanks Sergey for having shared all this information. I think this testing
is sufficient. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
