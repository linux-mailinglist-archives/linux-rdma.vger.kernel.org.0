Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BAD3B4648
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhFYPHC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhFYPHC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Jun 2021 11:07:02 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD27C061766
        for <linux-rdma@vger.kernel.org>; Fri, 25 Jun 2021 08:04:41 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id s10-20020a4aeaca0000b029024c2acf6eecso1344675ooh.9
        for <linux-rdma@vger.kernel.org>; Fri, 25 Jun 2021 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DiAImJC2GZ3jkFP0YNIuIi6bgnjbAAPYS1+zU7xBvKE=;
        b=us4wMNvbzYexcYeccsQxs3SxEvEKmriD1r9pVSOdCjiNqV8twuffuOlBkOO3h9uxF6
         gUevRDLh/xXxwFPAVUwgL5XoFWz35cKRUxvCmb9LikYaGdImp3QyuPaWyd9sSyCZD3CV
         BP6BmJVeha62etO31tcix9I60+EZ0/l/520upT1UwyvU/C62gm5MPSS/QPnqWk9h7jpy
         wBDSdJAC6lb20keVwpk/4b0yUY12V1XWACWzrO6SfryINbv6IzTDAZk9wTN/4SJ0DIrx
         FWlMU19ZlNktaf5mf9GrIlQ3NWhrZvxb8P2mGpwQjQ9i0JxuzhlazUsMF/Nc60H0XFiW
         lmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DiAImJC2GZ3jkFP0YNIuIi6bgnjbAAPYS1+zU7xBvKE=;
        b=NG9Ek6eIzPRnn9rVaLb048kYVoQCXck3Es8Fp9tJmRGllspuihsXpMhSKrm348ykzu
         vby7tk0btW3rXx/ekpgGddVJhWmGAp0vf/BtJvB7kfNv2hZ778QmQu6LhyaKA5ScpxEx
         xaaIQ3UEGzu+tOPFOcISeNoL/MwARZOmnMVswFHxVqJAEKEidrICvoA08bcDM1FfIWdJ
         t2arXSp1Z7iSy4dpuK6Kv+f9TsP1kV9TGXLbdGPEARg6tVHdx+en/M0OnHMyFIzfBTm1
         wKwJ8uMlmZ6nrtphYwUNXLskwW4+7anLok/YC9zcOmf/SCIagtBRex88QskZvf09MVAM
         IaVQ==
X-Gm-Message-State: AOAM533ePYYc5vffK/xoTGQWbkYpzHl0rL0HNUCn53I/zFy5j9xrPRIJ
        Qn5oCKxTLM9P5oMA+/2A3O2sv2zBKF0=
X-Google-Smtp-Source: ABdhPJxmhG3h7HJWLt6IOGKFQYQI4Vq04YaRWQnX6iK3ngkuwr3B32g+s+prMsdv36/guGvz7gplaQ==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr9448790oou.23.1624633478104;
        Fri, 25 Jun 2021 08:04:38 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:a9aa:3b39:eb3c:2e4? (2603-8081-140c-1a00-a9aa-3b39-eb3c-02e4.res6.spectrum.com. [2603:8081:140c:1a00:a9aa:3b39:eb3c:2e4])
        by smtp.gmail.com with ESMTPSA id w186sm1342468oib.58.2021.06.25.08.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 08:04:37 -0700 (PDT)
Subject: Re: rxe MW PR for rdma-core
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <29c7ec8a-3190-cb75-855d-f8c9b483d896@gmail.com>
 <20210625143924.GU2371267@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <62f655f9-29f2-de99-29b0-16539f45e6fc@gmail.com>
Date:   Fri, 25 Jun 2021 10:04:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625143924.GU2371267@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/25/21 9:39 AM, Jason Gunthorpe wrote:
> On Thu, Jun 24, 2021 at 11:59:14PM -0500, Bob Pearson wrote:
> 
>> It took a few hours but I finally managed to get rid of the merge
>> commits in the rxe MW PR. It's back out there at github. I lost the
>> name change Jason had made when I deleted and reforked my repo. I
>> remade the update kernel headers commit without the ??. It still
>> passes all the screening tests.
> 
> You should never have to delete and refork with git.
> 
> Force push fixes all mistakes.
> 
> The sequence to fix your situation is
> 
> 1) Starting at the bad branch merge to latest rdma-core
> 2) Create a new branch on latest rdma-core
> 3) Use 'git cherry-pick' on each non-merge commit from the
>    bad branch
> 4) Diff the bad/good branch to make sure nothing got missed in the
>    merges
> 5) Reset the bad branch to the new branch's commit ID.
> 6) Force push the fixed branch to github.
> 
> In future use 'git rebase' instead of 'git merge'
> 
> Jason
> 
I have a question about how the various trees are arranged.
I started by cloning the rdma-core tree from github to my local machine (i.e. origin master).
Then later I added my own github account and forked the rdma-core tree.
I have a link to is in my local .git/config (i.e. my-rdma-core).
Normally I do a git pull from origin which is shorthand for git fetch + git merge (I think??)
To rebase instead do you have to first do a fetch then a rebase or can you set the rebase flag in
.git/config?
I also do updates in the github web site from rdma-core to my copy there. I was having a hard time
getting the private github tree and the local tree to match (because of merge commits)

In the github docs that I read last evening they seem to recommend cloning the forked github tree
instead of the upstream tree on your local system. Is this correct?

Also in 5) above how do you do that?

thanks

bob
