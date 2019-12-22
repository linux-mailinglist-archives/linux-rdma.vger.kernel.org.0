Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439D5128D50
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 10:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVJ4n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 04:56:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLVJ4n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Dec 2019 04:56:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so13081853wmc.2
        for <linux-rdma@vger.kernel.org>; Sun, 22 Dec 2019 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r1rm9hN6hsiS9uZtYNWLF61+TBhGGwGQK/9BbWorRc8=;
        b=gjQMgP2+6yBR/nXhdSKMO5dvDwIn/5a0XadQcF1ENOV5rwD8YKQ+Vk8DKh9YXXmzMb
         Mzgkxoi7524/pvs5dzKSGUrYfgYzfjNvrqE5M2EpgsmwzwkRwDNnVaoB6ZHBi6EMFLcF
         sAxDdB/OolsrR/ni4UGLmirku8lb8zFjdFArD1OT6Tgj3n9iwZIGq4FrY1z10+8xZxvu
         tjCF+0+qgOUlhQiMsEtiKjy3Pp3kxwC4BOay8kuC8GS6DfHafr/C8hTNpa/nVdeseAoA
         1QdU3Oc69NVX3p1E87InxGWCu36q+KZQ6VC7rM9QHTrfrL0jScVxNYiE3DqTIdRzzVSq
         vcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1rm9hN6hsiS9uZtYNWLF61+TBhGGwGQK/9BbWorRc8=;
        b=SUTrYCOP0rdlp0h0t6Lfx8Ft3//rqnfjetZlSKlPahqgd0TB6ab26cdFwVpvDM+t1L
         5ejQiZzpT/WXRK1O9+mBpOyqjmfyaCcu49OX5aCXsw7fazhY24qJlMdU/qOIb/eyWknS
         4kalSHhE/Gdcr5kGduDW84VJqino2OJ4EqZDdvEivmLkjGTxu0UO0l8/s81HrYrhNJXV
         W10pTrDWXEljZHeDec0ED60GE32ia7J47N18O4D5vBjVbJDX3M40lcuM3BavVK2ii4wP
         1D5VPOFTXUW74NOIoPwm7hZi6ph6AEzvwDuGT0VRvaJmOFl+Y1k+3FxLfqK5lGZAw90J
         umnA==
X-Gm-Message-State: APjAAAWJ+BL1hzXz4ufmpOVq0NtzGGyMSl8otijSx3+ZQuKJ0fF2HgEK
        6jEqAaB2AWUMj58yg5zr9k534A==
X-Google-Smtp-Source: APXvYqzcC9UhTUtpjwt44/Snfw0YgY+jyFM6TTMx5MDxaCH7NUk1lP4rCtBG0nDgOX+Eg7NXAAiMLw==
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr26946558wmc.25.1577008600800;
        Sun, 22 Dec 2019 01:56:40 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id l17sm16240540wro.77.2019.12.22.01.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 01:56:40 -0800 (PST)
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-4-leon@kernel.org> <20191219183237.GJ17227@ziepe.ca>
 <AM6PR0502MB3638228D4DD3E713A5AE8951B72D0@AM6PR0502MB3638.eurprd05.prod.outlook.com>
 <20191220133547.GB13506@ziepe.ca>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <73bd873e-e2d8-148c-e5fb-cb263114e88e@dev.mellanox.co.il>
Date:   Sun, 22 Dec 2019 11:56:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220133547.GB13506@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/20/2019 3:35 PM, Jason Gunthorpe wrote:
> On Fri, Dec 20, 2019 at 04:51:00AM +0000, Artemy Kovalyov wrote:
> 
>> AK: checking for linear contiguity may be not enough, page may be
>> transparent huge page, so in addition we also ensure its indeed
>> persistent.
> 
> ??
> 
> I don't understand how it makes a difference. If the physical is
> linear we don't care if it is THP or just a lucky list of 4k pages?
> 

Agree, once we are fine with enabling THP or lucky list of 4k there is 
no need for the VMA extra checking to force persistent huge pages.

In V1 will cleaned-up the VMA part from the patch and adapt the commit 
message accordingly.

Yishai
