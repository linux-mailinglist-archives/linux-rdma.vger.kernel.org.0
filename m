Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B260324428
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Feb 2021 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhBXS5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Feb 2021 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhBXS41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Feb 2021 13:56:27 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79AC061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Feb 2021 10:55:47 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v64so2240174qtd.5
        for <linux-rdma@vger.kernel.org>; Wed, 24 Feb 2021 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqcuDEKf/MVqrKelG9Rf9BsOfxR3pI0bdpSsX09dQvs=;
        b=dl7MP022tdrjvChQGKvjtDnjyblrIU/z0SO3dvvXca9xDF5bI/RxG1MfLvw4949hhV
         /xD0yxDhKpbhEFAPc/2JvWvNlTgFYUQ4qk5K5MblVYU7OWBww+/6ZbrefGnEQyNuDjsF
         y+s5lk9PYqWrnu5AzGg4Lo+wurAhXLlH9GUyS8G0YH+cwyVSASzibsXSUpEvIy7VKASk
         MWqsvruRoypBeBRk1I+tWEtgRvvOm/KUXzqNmMAY2dM85HDOk/PaffkbQgPxzAHqCqK8
         AP3if8aFRscPoYJGKxfp31jWMuzKnWR1accZts7KBkoMrWgpm4/dC5sRbN9ISuxXdGdN
         c+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqcuDEKf/MVqrKelG9Rf9BsOfxR3pI0bdpSsX09dQvs=;
        b=Fi+r7OybBm8fVaM0+zoTav6yKz0lsnGFKma18ir+yKnw0jjSwB9pLJsoq1mHkK5g7T
         sTIa5O3F6odOkGmyc+KnntBYaVPR/7UznHcdB1KZCsfEB3YKPgz5PaTaL7hTPkBQSiXN
         8/LT41J8RXy2j0A/B/pGj6sS8N1L+wy5ePKNMSCzK73rynsEEGWPX4LS8dD46hUsbmoP
         xbfZlyQXl08L4ZtWncW9mIQ5LC8b7Q/DO9yCyw93oiJSeb5LAx91B4Os0mpPN7f+GJOB
         q1+F5dc67khlab2wcvmHpXAdRTg0yv/fy5rnVI4d/JTqBXkCq7/KBvSDAVdsypcd88qP
         jnCQ==
X-Gm-Message-State: AOAM531QqoY2qTpPWbdrj9uEBSC0Nc4sgIUxw3okNH+3elRpXccVsjjE
        qKXXsgJ3wEXZ1X6d4namxG7sqg==
X-Google-Smtp-Source: ABdhPJzOjHPVUut/3hYTO2btIoVtaYoak4x+b1T0sksbvk7HS7dWnqJMJ9yHbL1sPcHLGk5ijRBKeg==
X-Received: by 2002:a05:622a:183:: with SMTP id s3mr31323360qtw.223.1614192945923;
        Wed, 24 Feb 2021 10:55:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v135sm2170907qka.98.2021.02.24.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:55:45 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEzK4-00GmRD-PD; Wed, 24 Feb 2021 14:55:44 -0400
Date:   Wed, 24 Feb 2021 14:55:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Message-ID: <20210224185544.GS2643399@ziepe.ca>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <20210209195359.GT4247@nvidia.com>
 <55238899c6574cbe9fd96094ad4cc5e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55238899c6574cbe9fd96094ad4cc5e4@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 24, 2021 at 09:48:34AM +0000, liweihang wrote:

> I'm confused about how to introduce DCA in man pages. Current man pages
> in rdma-core can be classifed into public and vendor-defined ones.
> For example, ibv_create_qp.3 in libibverbs/man and mlx5dv.7 in
> providers/mlx5/man, but most of them is a description for a single
> interface. If we want to explain how to use DCA and how does it work,
> should we put a hns_dca.x file in providers/hns/man? 

You could do that, yes

> And another question, I know the files with a number suffix like
> ibv_create_qp.3 is for man pages in linux. What about the markdown files
> with .md suffix like ibv_fork_init.3.md? If we want to add a new one about
> DCA, which type should we choose?

Always use the md files for new man pages please

Jason
