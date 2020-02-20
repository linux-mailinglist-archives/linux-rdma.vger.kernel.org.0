Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7016641B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTRPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 12:15:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43101 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTRPY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 12:15:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so4238273qkh.10
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2020 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGoWjHPgm7tYvm2Vr3vpXC/9J65LRE8w5Rx36wd6wFg=;
        b=Q6Gb/+jQmhOKFHjAFvws2bxaL02WMg+hJvhLUyE3nTmx1ATRS/ZSnlXsIyYcjwY9Ud
         +AsjzyxxMROwa9HzIlQG01ZQ8S6mVEMxzuf7YseS7kdH/r0OzQp9MJJob3E+r1WFy4YD
         IkjGvqK/Qh3tSsHYoA/a0afZHdAcSkF/3DN8e2BPh2wLd+m0qzl9xhTZdWeZ3Fo32Y25
         kXnSGLF0YxXROaZnXOdVu3BYbr1Gw1k3zDV4tpoIuUlpybAzMwHFMvjevusMr5Mvn4p+
         ZYzFsUlKhMusKijEst6nOOou5aF7/4sK3ADGy9UIlA9a3nMi/Gye+hSGcxYaKrKYFeVo
         Eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGoWjHPgm7tYvm2Vr3vpXC/9J65LRE8w5Rx36wd6wFg=;
        b=IcW/cuefVLMFe5GF6TWstSY1ijAq/vGC3tBi7dYcPEIq7HE6bK4xh/6sHImyiU7zwE
         BnPULZWrgGN1oo9zoUpDylhaf2HTAzZdquQeT3iXNM38j7Ih6adAAd6fp9CkLs3st6Ow
         6DgjYX9QMYf4c7eT+rGEWNjiJ1yfBI/CZTHwo7DTHgP9i/PKf9tyVUN1Iz+Vk4FyCa4z
         o8SIy5cYAJcQihO/LUObxv1r5LcJtJxl4KGVaxzUo+IQIVbxbEJW1iBjqZLJKkrfyeOM
         Qn/9qmyNpG+aOREHqYDvToKH+XwjjxWIkTsrSZqcY1B8d1SjqgMSEwiSufwHP6vNBsVG
         eDoQ==
X-Gm-Message-State: APjAAAUyJUy21Nnig5t3TwY6TKaxrlq8lzOGlvfAeGq3pET1vd9eYDcc
        g8vY8ebqdKibNML21DiWdnIgpQ==
X-Google-Smtp-Source: APXvYqwj67jVVxTQzQgtH21G/bluLOMGfigpHMpUuYK8XDtWxEnymK5NBtVn/Nr3pqzVmdR5UGqsCA==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr28678803qke.61.1582218922935;
        Thu, 20 Feb 2020 09:15:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y197sm94295qka.65.2020.02.20.09.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:15:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4pQ1-00065O-Sw; Thu, 20 Feb 2020 13:15:21 -0400
Date:   Thu, 20 Feb 2020 13:15:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hns: fix spelling mistake: "attatch" ->
 "attach"
Message-ID: <20200220171521.GA23368@ziepe.ca>
References: <20200214003338.6573-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214003338.6573-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 12:33:38AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
