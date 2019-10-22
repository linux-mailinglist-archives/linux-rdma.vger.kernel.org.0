Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4AE0C04
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfJVSxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 14:53:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37044 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbfJVSxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 14:53:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so17306266qkd.4
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FWOFfYDApjOod/xH6Fe+NLgi9Xobf2k31aJZrVvzdOI=;
        b=UjwBKgsNOzd8PqZDBOGme0KeaLyBvqiD1HX1JQFcR68ovdZns2nLz/wKImH6eQjQEl
         UwH78xN/NaIwjOcQYq9f3lP6LwQGTJlUIZEv54JNs8Q62C7G431IMb8obna8oaw1uhlw
         1yggim1vo4/JMi5w7DL4LX8PnjDDR0UUEASEPvipiEG7hSWY4H7ipmNlBhLWRhpCW0mO
         yk82RiWLBeXGZCx80wgoB8d3dC8sdMB18XuHPs4ltAhdTAChn2ilH/z0eFxkcD/ZHK5j
         m+kEa1564TX1uMX53UtUtwtKUWt5JhUa7egXSxupQL2rnjbOSFJy++xaYYdXQv1jlCJ4
         qXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FWOFfYDApjOod/xH6Fe+NLgi9Xobf2k31aJZrVvzdOI=;
        b=j53fz7cBFjZJCDkyottzQDRJOCd3tyQ4EobSfbKyyVKtKM6yVvAJrRXqenl6dQqjCR
         uxOh6AaHm1tex4R/zNpetrhYP8UoxTqU8TJ1zrjVWO1/ceMEkXB6KWk5NvVj0Z26daKk
         cprzrMoeqmefBNz6iReWen+l0BYDT8Zl27ntdiZiJUn+QI0/1Ven8DedRM35XaMJW8mM
         e4zLfU1LWaIk0MWLjmgMe73taZJQJEOXrvTsLZidzgIw5oT9tglvN97ce1lmxaY9lLXw
         d/ne0gvMI7uuPUaY/QFKIKYd6kYGa47pjlfOup9+8YwLWxSthlVNuukGllivW9VGXYhn
         U7OQ==
X-Gm-Message-State: APjAAAWncHS481Eg787bHYU3aDW60YcG248E0qD7V6QnIKtPEHre1WII
        iVcGBJHeN76xFGjG/dMMmu5xLQ==
X-Google-Smtp-Source: APXvYqwEBWgd2sTsSeRqWMxJ9xC3qkDRi9SGEXkGsJWF08m8Q2ywwVyvmK7VtijcWQ2cPL+6UzU2GA==
X-Received: by 2002:a37:68c2:: with SMTP id d185mr4585620qkc.297.1571770418354;
        Tue, 22 Oct 2019 11:53:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q44sm13619938qtk.16.2019.10.22.11.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 11:53:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzHl-0002Qn-Bb; Tue, 22 Oct 2019 15:53:37 -0300
Date:   Tue, 22 Oct 2019 15:53:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v3 0/4] ODP information and statistics
Message-ID: <20191022185337.GB8628@ziepe.ca>
References: <20191016062308.11886-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016062308.11886-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 09:23:04AM +0300, Leon Romanovsky wrote:
> Erez Alfasi (4):
>   IB/mlx5: Introduce ODP diagnostic counters
>   RDMA/nldev: Allow different fill function per resource
>   RDMA/mlx5: Return ODP type per MR
>   RDMA/nldev: Provide MR statistics

applied to for-next, thanks

Jason
