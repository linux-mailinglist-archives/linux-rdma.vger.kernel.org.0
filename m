Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A245E3AC3
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436810AbfJXSQh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:16:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45017 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436611AbfJXSQh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 14:16:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so24277245qkk.11
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ECc85k/HCV9xlF2iOQA++Qj9PZNM29CLbLrnIGfads=;
        b=dOMGsE0vn3bsEeEzZD8W/N2mP4JerquBhY0Dyo0kdnCWSv/CEUy7cSkQ72JwbSnM0f
         JVTgwb3qKqds08yRbwZT609deAPe1Gz1haqt367Z6epg7QBYDWmF/+M20itj5HVbL7AC
         EjuLw/1jOxe3O/jb+lYQRuxcVOk042Zvz6cG3bMlvADOLOjzrzmB+mjOmAW6UUGMFkHJ
         D/+X5h+SHD1t3hgTy5qBl7e9on79KsFHIroBOdI00+JOUwn8szzu3r1H7YZkaRnhgabE
         Wg2EZUyxi6ccMODbcjacyhk99VjWtW8I9kMy02gRIRFi3rIyPYf/eyD8t9U173ke/l0c
         UpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ECc85k/HCV9xlF2iOQA++Qj9PZNM29CLbLrnIGfads=;
        b=f39Ce4ogmGcrn2D23+JxZbOCVk/9VkG3yvRmi6DiTTLASxEBdp2pguxOv3I/GcmFmS
         0QjrTQuWtay1VZbLStnISHi+LMwfzCYnzeeDGg6wlO1c5aV1zpKXCfSlxNSoEbzZgKcD
         cyfVCSF8Hjx+eTttAQhDUq3xULea9yUPlsS6kNohBnHJEtTK9u3RUL88jarb3JVg+9K1
         Q3zNRiX7JoNuPnEF5Loqu8gtDXK/rcGKYv+mP+l3XFlVCNyuAZBTgSrou/U1THTsstrX
         xkhVF8Gx6yaPdAb8/wY8G2mj9NVHauCLLbESTb2ZcF12AdgBNT2Bx/YT2wn6tKiZZul0
         VKqg==
X-Gm-Message-State: APjAAAVRubgx1RVXLkqgRkObJCGzLNMSJfaSb3Tmv2YuhmEq5xdr86m3
        3yZ+Vn2bgWpT0tOvnedC0xMuMZc8ZRU=
X-Google-Smtp-Source: APXvYqxoI+jrI3uO++cIGmpm8wXPfwK9Sfo7OIpowxyAiS1D4P8FrCfDDuwFjA5Bfc0ZEOfGGY8InA==
X-Received: by 2002:a05:620a:536:: with SMTP id h22mr97240qkh.480.1571940996489;
        Thu, 24 Oct 2019 11:16:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q204sm4714124qke.39.2019.10.24.11.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 11:16:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNhf1-00015l-Fm; Thu, 24 Oct 2019 15:16:35 -0300
Date:   Thu, 24 Oct 2019 15:16:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Remove useless rxe_init_device_param
 assignments
Message-ID: <20191024181635.GA4149@ziepe.ca>
References: <20191020055724.7410-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020055724.7410-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 08:57:24AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> IB devices are allocated with kzalloc and don't need explicit zero
> assignments for their parameters. It can be removed safely.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 13 -------------
>  drivers/infiniband/sw/rxe/rxe_param.h | 13 -------------
>  2 files changed, 26 deletions(-)

Applied to for-next, thanks

Jason
