Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D002B9C3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfE0SFb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 14:05:31 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40890 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0SFb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 14:05:31 -0400
Received: by mail-vk1-f193.google.com with SMTP id v140so4032396vkd.7
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIlW7nYfkybMLBmiuIuf47GWBN24yBnXsPersiD6Rpw=;
        b=guVmGAo4QtYSceqjteyYwZvfNoisIO9y7tvtEz/FI6jqAYMUz9vcYzuWEHVnayn8c4
         4fsq8a2tYOAWXSS1RatJGoK7zg0hHjN+qOxvoAbF2Ts0PDDD36mp1AFTq5ZTdyeKjtkL
         YZ9tMHSjt3V1TqLCn0ZYivtCnKtzSkjhVmAVPNP0jXSBhBgfNAdSI6Svx1lvj2FNA/oO
         t//B49N8RuEynVWMVg01Dlh9B0fgrcO5cyd6AEi6HVwYhm/WpMnlkI3hzTRijC2W+L6i
         RqJ6+MCxzOVTUP3kd2I+pfscWi1aQUcrgXJ5KzmNMy5qR3tXeyF/Oixw0XafooHVKt1T
         tiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIlW7nYfkybMLBmiuIuf47GWBN24yBnXsPersiD6Rpw=;
        b=O1DQedxQwPaLtKo98GsPdYDNcuVZY0UhwwdSp5MHlryfccvXpJRaQrF7q37oINqHR7
         nn9x2y0pKdIxYFsxd1z+VBmCzMJNWP/d+e2xH3FJtPTxUWi5fJ9sv9+e1JfmF0grRmeU
         t8qVdI2IRMrxfINITTyonel6yDCIs3Vo9/DZ6HjtblXrEcKJKBs5vCZMJMpLIDyMTb+c
         GAHXk+EVJ26CHNElZahw4uepdY68RCiYulYGbC2Tl+GccDeCySIGmdZ21/GR86FyRno2
         Jg73YQ8s1M7sxv6wQh5eUiObap2+oRaaYdVdCkfxuIBTeioHjE/lRhEpzLS/wtb6DWI2
         qmwA==
X-Gm-Message-State: APjAAAVLbVsyrz7IaZyzd9HctNLZcZPpu6MQF5PI02TsLjVg2AcJl6eB
        zPBKz5oA4swVPyQgStJu8xwGng==
X-Google-Smtp-Source: APXvYqx+8k2MkLm62SVJnNK9VlZ14e7XGx5aSbXufqpGmIKqkmjKlvdJRZXjZc7in2zTS0V6ofYPKQ==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr20674273vkk.26.1558980329945;
        Mon, 27 May 2019 11:05:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 142sm9974526vkp.56.2019.05.27.11.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 11:05:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVK00-0002Vg-Vr; Mon, 27 May 2019 15:05:28 -0300
Date:   Mon, 27 May 2019 15:05:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zuoyu Tao <zuoyu.tao@oracle.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>, linux-rdma@vger.kernel.org,
        Aron Silverton <aron.silverton@oracle.com>,
        Sharon Liu <sharon.s.liu@oracle.com>
Subject: Re: <infiniband/verbs.h> & ICC
Message-ID: <20190527180528.GC18100@ziepe.ca>
References: <54a40ca4-707b-d7a8-16b0-7d475e64f957@oracle.com>
 <20190524013033.GA13582@mellanox.com>
 <e9d86a45-a3b0-e303-027b-02474ed3a2ac@oracle.com>
 <309e44c2-f520-4e35-9f50-5e6932d7b40f@default>
 <d2f25bde-488f-dc37-b751-53ec602d66be@oracle.com>
 <249b6ede-bf1e-4d33-aeee-2f177d244495@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249b6ede-bf1e-4d33-aeee-2f177d244495@default>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 25, 2019 at 12:22:10AM +0000, Zuoyu Tao wrote:
> Hi Gerd, 
> 
> Here's the response I got back from Simon: 
> 
> 	there is an outstanding request with Intel, which would allow
> 	us to get rid of -strict-ansi. But until then, it seems to be
> 	a choice between (A) one line change every time we update
> 	verbs.h and (B) let in the code changes that break GCC build.
> 
> 	I'd vote for (A), since it isn't really that often that we
> 	pick new verbs.h.
> 
> So I suppose for now if the upstream doesn't pick up the enum
> change, we can make the change in our private verbs.h copy.

I can't imagine why using --strict-ansi would be the best solution for
compatability with gcc.

AFAIK there are several things in verbs.h that are not
strict-ansi. icc seems broken to be selectively ignoring some and not
others.

I did make an attempt at it once:

https://patchwork.kernel.org/patch/10209785/

We also had to give up on fixing 'zero-length-array', which is not ISO
C11 either

It didn't seem worthwhile.

Jason
