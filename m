Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11C9126D0F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 20:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfLSTIB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 14:08:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36652 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfLSTIB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 14:08:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so5908695qkc.3
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2019 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GFska7E8A0Yz3vjbXjkTBLzR9urC71UZqWIyJZEn1k=;
        b=JC76XHHtOJ5yfICHoHYpjZl/VXSQHbckS2zh0FIJXUS7DA3SVQr1lam6W7VIVgKlUR
         xG8K/rUJ0a5OcrD9A08ckYue3RGwO42qmvOFdie9YGu7Y754+wXVkp/QmFJF4bOXxE0t
         imEbrY3vHhMolBSBE3kW09x5jcQjHvWVaJIanDMVxaDv77rerUGDjcqpqMuIIJjqWe/X
         ErD+oS897ZJ9f+vH622ebftYaPMungd6KeNzuABKu8PlZYok6cR0pxFD209qZ9LQ90BK
         BzLHtSMrD/RCbJW4J7pFoXcYKpsJcEEtXRBH+n1yJWRoYKnboxb6ScR9RDVQcb+CCA2m
         2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GFska7E8A0Yz3vjbXjkTBLzR9urC71UZqWIyJZEn1k=;
        b=lBZ8WP5PU5Xa+noUoxeOsAF+Nn5Icj08TPVPizJj5gxBR9rdC9YF9Y/ZT41KeKI81x
         b9Y+n1sw1AEl34lZHPzVFUN9KpXFPfuog84YKLZR5Ci4geBQFf9vApFaG4iwkMlQ/PpS
         DUUcv8rIU4BUgKiWvTvyA7c7ZD5QRYzT48y9JfQcsbCPUqF8KmwP7mytW7bX6HEp7pM1
         x+4hunoSLfaeMD3eCB19ylu60Hovec8tLkPbaTe5d1ojzhGCchLGEgCXU2/BC0xY+Oy+
         1tkrFFjgIxytnie2HMSDbD2F0MaDPX807JpcqW8HsziUamjk015XuL+Gg0/6IRq8uOCP
         ya0A==
X-Gm-Message-State: APjAAAVOfmGqW02Wh1vwl+Q1SqZv/TRLIHfeksG6Gxo6hGA2E7MwbdWj
        PCP18UCi5fEknqMM6EQGVuCFmg==
X-Google-Smtp-Source: APXvYqyXZTzIJVewp3JPbDcjEoXZN4V7dL44LskPt/w44ITuI8EE312t6PsPeSDFD5V3/FwIBfT8eA==
X-Received: by 2002:a05:620a:98f:: with SMTP id x15mr9637632qkx.462.1576782480499;
        Thu, 19 Dec 2019 11:08:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g62sm2000490qkd.25.2019.12.19.11.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 11:08:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ii19T-0008Cb-M1; Thu, 19 Dec 2019 15:07:59 -0400
Date:   Thu, 19 Dec 2019 15:07:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
Message-ID: <20191219190759.GM17227@ziepe.ca>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
 <d48e1f2c-4a2e-42ee-08d6-69eab4aacde0@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48e1f2c-4a2e-42ee-08d6-69eab4aacde0@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 09:10:24PM +0800, Weihang Li wrote:
> Hi Jason and Doug,
> 
> Do you have some comments on this patch?

It seemed OK to me

Jason
