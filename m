Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5825E1CED5E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 08:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgELGzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 02:55:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44643 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgELGzQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 02:55:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id x13so28765pfn.11
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 23:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVvJKo8oAD2W+RkCjLALOzohIz6g9x6OeJfl24Ay3fk=;
        b=W6EcM99n7DQEvh11rBpBb6QW57unODS+pU8TAT30e4mmOgqLpfzvl/H5Rn/OCadhHz
         HSpTDNFdXwMVRHNrTAZGZAQEBGQHns9cVs58cBaktHtYmeu8X5+nOZVdwwZyHFQx4fsJ
         zS5pTrn3oB20W3iWSk0oF092IzzddhXhgmDJvNEDgFH6YRCNwphJDnCr1KzzCzy8viVq
         hFkfek7lEfCm3M7rTaa6OwwVdOc4FpQdbHJG7g1D80bIMt9GHCmaE5IvUyqIFAm/6bXt
         saDa+w0889/N/2R0UrVm948Xr8zb8sweFktHgbhT9Ebcb9+Gs4QcDsKEq0lqBM8bSUJr
         t4Eg==
X-Gm-Message-State: AOAM530Fj0/WAkz5u2HE6JV2qPOcJl6O0h4wK31A+p/1FZRTngNFYlSB
        4QYo6f6+VZjWXYc6AwMeetbfvGMo
X-Google-Smtp-Source: ABdhPJw+6JcI2dztI9cXLprM+VKHqWtDcZhLPuQBHc3kY3O0zekHPAWGv5K/77k1HEFvn3KS66SSZQ==
X-Received: by 2002:a63:b146:: with SMTP id g6mr8572505pgp.396.1589266514918;
        Mon, 11 May 2020 23:55:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3949:7466:3de1:e65f? ([2601:647:4802:9070:3949:7466:3de1:e65f])
        by smtp.gmail.com with ESMTPSA id q1sm1536586pfg.194.2020.05.11.23.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 23:55:14 -0700 (PDT)
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <f214d59e-2bc1-15f5-4029-99ed322b843e@grimberg.me>
 <921ae7c2-04f0-e89d-7f80-6534ed3b8aa0@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e893419f-f26a-a0d0-1616-970a78c60b04@grimberg.me>
Date:   Mon, 11 May 2020 23:55:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <921ae7c2-04f0-e89d-7f80-6534ed3b8aa0@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> Why are you using the cpu_hint as the vector? Aren't you suppose
>> to seach the cq with vector that maps to the cpu?
>>
>> IIRC my version used ib_get_vector_affinity to locate a cq that
>> will actually interrupt on the cpu... Otherwise, just call it vector.
> You are right, I ended up removing the call to ib_get_vector_affinity 
> because it wasn't implemented anyway. I think it would be best just to 
> change it from cpu_hint to comp_vector_hint and then we will get the 
> desired spread over comp vectors which is what happens anyway without 
> ib_get_vector_affinity.

Why isn't that supported btw? I see mlx5_comp_irq_get_affinity_mask and
it should be pretty straight forward to have this for all the device
drivers really, isn't it?
