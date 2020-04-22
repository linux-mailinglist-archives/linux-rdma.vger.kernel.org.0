Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACB21B5013
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVWYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWYa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4B1C03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 15:24:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v63so1856526pfb.10
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHrHLvTJ9CWgVWiVQyE99M0mE7zEJFulQmFuGP+4648=;
        b=e1td5G9TiSyZLvBrUiWmUDEDSml0y1z7wstTGBqLG9UneZh/M3sis8rL0+vqcS1oqh
         pz23uT1tVgyz/NGLRUT/iaMxO5bfjxJ1v+HwrzMtFgwIEOgyLNDPTINEBAUYSst3yGAe
         ebkvgCzFfVwVDF9uu2CgYR5gVRnoc/TZijYxJ8FeP7rdYPSRNzfqpiyY+Jv1CQoAJlq4
         Fwm5xFpZQBhvVmG4Z4AawCWlLIUCzDZ7wn/VgtEqZfZnfRxH1SqUuJSkklZZMDg4eY1b
         kqZDlmJL4kDcwO7hjqDBbRStHdu7xL1yIvJBydcmyL8fDxYwCqT/XjE95hez7XNIH+uX
         DcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHrHLvTJ9CWgVWiVQyE99M0mE7zEJFulQmFuGP+4648=;
        b=CO5yQa/76evStkh7/CxYf5GtzCA9/VTXzOGDOVSjAzfBLQaLD9rQ+yuw+KevB+3hwl
         S78owP+iNsICEg5p96nPQ663UHkw9tRGyC/tkgDdnig3zLWLxqGRYWmGIF5aE2LFg4N8
         sYxW6pJ//lFaA7W5LcevkrMkpegvEEGvoXvAbH6NtvutUbu5qH4e+DgM0EbIb8dtwEX5
         nqEE0FyD7Sxv6t9JEQmtGNq0rFkAI5Wu7Lal4SJzvbZpt+pJHYvg3pXxuk7QYhAbLojl
         WSLxhPFEuE5qgA0ZqkZafKeIGKSUTkXfcQF2DPHzzqWHbs+BeIpNgzmt9caTm6LY3EEC
         4Ccg==
X-Gm-Message-State: AGi0PuavOdManmJcRTUmedgALCeAZstHxxnfY70DwoFmi2H+OIJ5xmEa
        HP3sxKz9X4Sp+4lrdhqA8N4=
X-Google-Smtp-Source: APiQypLhEvLtIfLOWM8+pZBs4U9szwgf8fl8NBMZCmDSbKP6vCWtNSheRM6HYUUBiCAXGIH7jeXrjA==
X-Received: by 2002:a63:213:: with SMTP id 19mr1172051pgc.202.1587594269973;
        Wed, 22 Apr 2020 15:24:29 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h12sm508042pfq.176.2020.04.22.15.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 15:24:28 -0700 (PDT)
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
Date:   Wed, 22 Apr 2020 15:24:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/22/2020 3:07 PM, Max Gurtovoy wrote:
> 
> On 4/21/2020 6:17 PM, Christoph Hellwig wrote:
>> On Fri, Mar 27, 2020 at 08:15:33PM +0300, Max Gurtovoy wrote:
>>> From: Israel Rukshin <israelr@mellanox.com>
>>>
>>> Preparation for adding metadata (T10-PI) over fabric support. This will
>>> allow end-to-end protection information passthrough and validation for
>>> NVMe over Fabric.
>> So actually - for PCIe we enable PI by default.  Not sure why RDMA would
>> be any different?  If we have a switch to turn it off we probably want
>> it work similar (can't be the same due to the lack of connect) for PCIe
>> as well.
> 
> For PCI we use a format command to configure metadata. In fabrics we can 
> choose doing it in the connect command and we can also choose to have 
> "protected" controllers and "non-protected" controllers.
> 
> I don't think it's all or nothing case, and configuration using nvme-cli 
> (or other tool) seems reasonable and flexible.

I think you need to change this to "some fabrics".

With FC, we don't do anything in connect. The transport passes 
attributes on what it can do for PI support, including: passing through 
metadata (no checks); checking of metadata (normal); generation/strip of 
metadata on the wire (meaning OS does not have to have a metadata 
buffer), and so on.  Enablement is just like pci - format the ns, then 
match up the attribute with the behavior. There is no such thing as 
protected and non-protected controllers.  There's either a ns that has 
metadata or not. If metadata and the attributes of the transport can't 
support it, the ns is inaccessible.

I understand why you are describing it as you are, but I'm a bit 
concerned about the creation of things that aren't comprehended in the 
standards at all right now (protected vs non-protected controllers). 
This affects how multipath configures as well.

-- james


