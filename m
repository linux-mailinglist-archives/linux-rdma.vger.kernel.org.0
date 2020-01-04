Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2512FF61
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 01:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgADABa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 19:01:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45257 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgADABa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 19:01:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so35077802qkl.12
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FyxITQ06mRJ5LXE0g6/PDzDBVCahITkTQdAtCtjXbRA=;
        b=JycquDxZmpvNSLHrC0gLJNcNVObsJLFaFftFQXWXhrPcDE6GUzXJg7aRUccY/JakTP
         4Q+idNLtoSxJR8CzhGXwvj5DkdWuuHZQPsP+bnJMq9HbKqmuswAD+PCLMqrLvDP4ebcH
         rFuQSfTWX2hXXEeeSr4zAxkBoc/Tj/dcdpoPAt98uf9DRJCz2ljyVTh+37RVZglTrY5U
         llfC5qPU4Qy8lLZyi7XWKG8SqENKOtrK/vKvwJFfQWMjQgDHOD/X5zZ5/J9chEe9drC1
         0Mbm0lC9vLmy20t5/KeXcAwS4P6q+ZrUMIAvYsYAJ5LjsVQyxSzQkvCRiVC40kW22iRq
         XDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyxITQ06mRJ5LXE0g6/PDzDBVCahITkTQdAtCtjXbRA=;
        b=njv64QKgEZjOHxToKnoO0QLgWRwkAV9VxW7HF1VXc4JQhFjN44Jc2ZfX/yJlR/E721
         X9ewYygUw+9Xuj8QUHByRzpiaKWE/PR/AK+qZ9AOXJCVmN5Lp97w5Gg+xNHMQdEH7Okj
         7qhchYgYKk0tHL11Q36V/hIXd8W9Dx3Uzxvq3NiUUkorZHiLssxL57yBDuPaf/h3tBes
         a0SLaRBz/q3sKk+NBH465GFSNDfVtOPWBDFSBHE3O5NVFeFzbQH7dCmR+kmW6GCy4adr
         d2GzUVYYEdE1M64UhYoXZy9WUQL/30Z3uVnTP9jX1pcLs/4GnKqipLwqJqQW4+H6IeBt
         O8iw==
X-Gm-Message-State: APjAAAVme4mWxqIGumNFHI+tG5oBtBtDmhYqrxt1g3P1TB6FxJheAPtH
        tfmTWxzFYqPS4BPjqtaV6DzZVw==
X-Google-Smtp-Source: APXvYqyVgAtb+6xBtEQEBbHXzoCRgoqXmWEYCLbkvrVum/DtSo090a7tfoaaZMEPBbMJH/GLEMmHxw==
X-Received: by 2002:a05:620a:139b:: with SMTP id k27mr72376440qki.112.1578096089492;
        Fri, 03 Jan 2020 16:01:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f97sm19409271qtb.18.2020.01.03.16.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 16:01:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inWsi-0005PG-Dz; Fri, 03 Jan 2020 20:01:28 -0400
Date:   Fri, 3 Jan 2020 20:01:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu, leon@kernel.org,
        Markus.Elfring@web.de, Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Message-ID: <20200104000128.GA20711@ziepe.ca>
References: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 30, 2019 at 10:24:28AM +0800, Xiyu Yang wrote:
> A NULL pointer can be returned by in_dev_get(). Thus add
> a corresponding check so that a NULL pointer dereference
> will be avoided at this place.
> 
> Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changes in v2:
> - Release rtnl lock when in_dev_get return NULL
> Changes in v3:
> - Continue the next loop when in_dev_get return NULL
> Changes in v4:
> - Change commit message
> 
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

And Shiraz, Leon is right, that trylock stuff is completely wrong,
let's fix it.

Jason
