Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C60139AA4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMUQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 15:16:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39113 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMUQo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 15:16:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so9797006qko.6
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2020 12:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25ea5n108eS6074QGsnGbBIUkbfdaKx61K6NhtGXG9M=;
        b=DKRmQUzYNX5kzRdsf2mdD85N3S5jXYcLy1xS7e5Y7UMlcBf00o164BaJysrJQ/WHPY
         gIyR1ok7IVJcsaCm4KLFnBhWINFNp/OZW0OlcuRjdvyprTb9x+Nj68BfyAjpof6q2Hne
         mzV98gWBap9Jh1Ymt7l6/w4HbX6Jm/hGfUzNW3Ug/cvlz6Vw5CP2sS0fihiojmFXh8S7
         4kUr2ZaOXh/CZoyoExqTqtir4mrs24EHcgLSZwEtw16YOcAmTOtgx6jbrAoO16XhvugG
         QSLgGDtVCHQH+1SNllr+wyBxas0l14r06vGnj4rcLWzLIwsmVER1zjmAKh9acGWbOXcj
         l3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25ea5n108eS6074QGsnGbBIUkbfdaKx61K6NhtGXG9M=;
        b=bm9gzQNeBVsGfMz+JJfpbiA2Fu5eRQ23mnZg+f9b6LDatNNPLvohJTeXC4yxVnXEPb
         NrLb54BKYmGfDPGiiE8IifNatNXm4xuG18FFW4P82hKubPgcGhZioaWIPdQ2u9ppeoGh
         k9PGZe4r18k23Z07a6IoNcT9LUcASkPoE2V59sd03MZRWNk/9O/7bDhcluoLnsVSuLCd
         1yA5ON1/otDXaNilbGjwWWzdVoEryYYST7FQ6E8LmuxjvRi30Hp747z2+e/LiPTfhpLz
         zvuEQ8h8ka9j+G0UO1KBlu+9JTKoWaQANyoXi9whrrbxbkUi9B1jNulO9PvCaWa1e+MV
         z3zA==
X-Gm-Message-State: APjAAAV6+8CFsCQM+VVgPtLr3htHP11YZRp+hqo4ztceisn8VRgP7P3t
        ebl9eH2uTPpis4OJZZq3k0Jbsg==
X-Google-Smtp-Source: APXvYqwuworvOM60m3WEjfZ63P9KlwpOzeol+iWw9T8gr4QP5XtoO6+gWfNp5GYVc3Yk2dOVX1Up9Q==
X-Received: by 2002:a37:2f47:: with SMTP id v68mr11557662qkh.217.1578946603738;
        Mon, 13 Jan 2020 12:16:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k29sm6262201qtu.54.2020.01.13.12.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 12:16:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ir68g-00068l-Fl; Mon, 13 Jan 2020 16:16:42 -0400
Date:   Mon, 13 Jan 2020 16:16:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix storing node description
Message-ID: <20200113201642.GC9861@ziepe.ca>
References: <20200113191226.14903-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113191226.14903-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 13, 2020 at 09:12:26PM +0200, Kamal Heib wrote:
> Make sure to return -EINVAL when the supplied string is bigger then
> IB_DEVICE_NODE_DESC_MAX.
> 
> Fixes: c5bcbbb9fe00 ("IB: Allow userspace to set node description")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/core/sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 087682e6969e..55f4d7c1fcc9 100644
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1265,10 +1265,13 @@ static ssize_t node_desc_store(struct device *device,
>  	struct ib_device_modify desc = {};
>  	int ret;
>  
> +	if (count > IB_DEVICE_NODE_DESC_MAX)
> +		return -EINVAL;
> +
>  	if (!dev->ops.modify_device)
>  		return -EOPNOTSUPP;
>  
> -	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
> +	memcpy(desc.node_desc, buf, count);

I think this should just be written as

if (strscpy(desc.node_desc, buf, sizeof(desc.node_desc)) == -E2BIG)
    return -EINVAL;

Jason
