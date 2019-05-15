Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E861B1FA2C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOSnh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 May 2019 14:43:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46907 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfEOSnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 14:43:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so1177333edb.13
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 11:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JE9AN98zDtCbsiE0/AlpOlN1N93gU5qIhDcJCSfYwLw=;
        b=pWHXsEYRy63KEGRG9CUwkWrVn8zLfOlyBKrs05uOg22GI8VHKqb222ITxteIMB9pTI
         E+4ZkR3kaFVHvspHPhtyGkG01vtilLcNdDxOfHG32i/ffzSUA43mbOtaw7QlfqLaC52j
         90Z9aNkSogVILRGCeoa+8li5G+dK8ntryxu7TVmsjgbiq8mmg0sB/tUFlq/olHPhD/0J
         qrJhTpVyN1CimKUJW5snGWQvAXWrsrms+vE9Ku+HdLApTrIFr3lTK815W/i119us8w3O
         utA4fQD3X3JuPHSrV1qYsDOU7OJqgu9spvdQh3k8MGWfBCGd6cV9DLY2MarUt5+sH2Yb
         KyPg==
X-Gm-Message-State: APjAAAUk+dHtIJ0hIFisTAoZPpDjFrDl/tKSsCqvZRGoxLbqAE8zfjr8
        w0WuLoKGTIBQbILJyB49S43WNSKY
X-Google-Smtp-Source: APXvYqy5XsAS+EAN2/kNxuYaj/tM4VvcEGeDwoAY1Oe3OUK98AUcg7hhC3xH0EvjV5rsJfReRR5EQA==
X-Received: by 2002:a17:906:5a08:: with SMTP id p8mr18432118ejq.276.1557945815113;
        Wed, 15 May 2019 11:43:35 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id k12sm611696eja.52.2019.05.15.11.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:43:34 -0700 (PDT)
Subject: Re: [RFC PATCH rdma-next v2] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190515170638.11913-1-leon@kernel.org>
 <97b980a9-6a2a-234e-c12c-b7ee5fd4262e@acm.org>
 <20190515183342.GQ5225@mtr-leonro.mtl.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <054e8b16-ca7b-674f-96a9-b1f8cc78884f@acm.org>
Date:   Wed, 15 May 2019 20:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515183342.GQ5225@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/19 8:33 PM, Leon Romanovsky wrote:
> On Wed, May 15, 2019 at 07:32:35PM +0200, Bart Van Assche wrote:
>> On 5/15/19 7:06 PM, Leon Romanovsky wrote:
>>> +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
>>> +		char name[IB_DEVICE_NAME_MAX * 2] = {};
>>                           ^^^^^^^^^^^^^^^^^^^^^^
>> I think this should be IB_DEVICE_NAME_MAX + 8 instead of ... * 2. Please
>> also consider to leave out the initialization of the char array since
>> snprintf() overwrites the array whether or not it has been initialized.
> 
> Any reason why shoud we care for this micro optimizations?

Good kernel developers care about writing code that is not confusing to
the reader. IB_DEVICE_NAME_MAX * 2 is confusing because the generated
string is not built of two device names. The "= {}" part is confusing
because immediately after that initialization the entire string gets
overwritten. This makes the reader wonder: what does that initialization
do there?

>>> +		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
>>                                ^^^^^^^^^^^^^^^^^^^^^^
>> Please change this into sizeof(name) such that the size expression only
>> occurs once.
> 
> The same as sizeof it is calculated once at the stage of defines
> expansion.

I think that snprintf(buf, sizeof(buf), ...) is much more common in the
kernel than snprintf(buf, size_expression, ...).

Thanks,

Bart.

