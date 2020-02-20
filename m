Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22250166476
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBTRXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 12:23:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43144 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTRXS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 12:23:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id p7so4263395qkh.10
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2020 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5ClAp5nYh4S84QoVUj0cg7x+oEYxYAhY1bGhWHcMrI=;
        b=PR6XWcyoNytCI/IJ4HMlBWs6hkDhnUofgY6uQySNqSBZVvWH+DxTVbbok1ETg4zgVi
         qsyq/L3K7RUCzdOcH0n7Mr/ylgvSieb0NRNxL2CQ2MFzIRDRrEkh9BzwL4gqlCt9JQAX
         lymAz6faczQjWAyKixYfBdRxBQ55YSR/29GMXuxHehZhwvYuamdLDmtq6l28WEKJAnJl
         YHEjmize67rAGzOHQ7Aa/a8wS4SuHjkOA5A8LOpmIhtzta45VH9W0O7wmnSHdHqUFxig
         zbR3G3kl55xp6CRxVwfg/fj6UbPwQ+hP7mFbgq6UidyvniPQvW54Z3QtB8pDeZ94O9aa
         XGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5ClAp5nYh4S84QoVUj0cg7x+oEYxYAhY1bGhWHcMrI=;
        b=KQaNJWPoix0QBh+LZDa/7o0eJXyctLQZLVLhwlAEmxFGZb2GcDMHtTwmyPgVvrHJ5c
         u6Bu9WPZb2NF4U9O6HB2VvV+tdbCOU0eG4R+Q/vabOWEheivqaDRHZE2zek99AAbDtCp
         kgcXabyRP3ersOcU8HdqoXnJSM+j0rMR0J+KmxuSE/hRLt/AJJkAIuBEaRrTL1kqFkAH
         RMnYhYTE0Pzh6Ef7yrJFW2jNMl/puxWlGC7spLoKKk7I5yztkzf9ZDbUdZhgOka7ojoj
         mLPdE/CnctV3UTD2o7UjA6H2bUTquKKea+JSWWozN8a7m6e3Zpo6+S8TguOmx2AVfVnz
         DcrA==
X-Gm-Message-State: APjAAAUxfOZY0IK02LcDxYHlCdBmoIsafjglvotJ30AunFSrTi+3iIa+
        KiWnOZELNk7m2MwGIKamazUlUQ==
X-Google-Smtp-Source: APXvYqxZn9ThkUFHS9CT1Xyjlcz9woMfWjMuYovYvUp5DYdxqxtRmjyFQPmNA2wqZgpAwvSXNw6q/Q==
X-Received: by 2002:a37:4e94:: with SMTP id c142mr26360552qkb.13.1582219396537;
        Thu, 20 Feb 2020 09:23:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a1sm92194qkd.126.2020.02.20.09.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:23:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4pXf-0007lQ-Jo; Thu, 20 Feb 2020 13:23:15 -0400
Date:   Thu, 20 Feb 2020 13:23:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Initialize all fields of doorbells
 to zero
Message-ID: <20200220172315.GA29815@ziepe.ca>
References: <1582162471-50361-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582162471-50361-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 09:34:31AM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Prevent uninitialized fields when new fields are added, and make code
> look simpler.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Just rebase against the for-next branch.
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 9 ++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
>  2 files changed, 3 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
