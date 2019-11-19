Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0272102D12
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 20:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKST4k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 14:56:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37213 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKST4k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 14:56:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so19027958qkf.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=atrClaetg9DSCkw5CMYG0uu1x0TzMpea3sCswkk9tMg=;
        b=KhCuvJMxBvdq131/2eeub1rg15L9hC3wgNnYgxxUMNTAWuBp8jn+9zRG3t5NWj95WO
         j78AsM+DGr5pe8+BSSuj4x95CuLVYYU7ZzVn6x/LyTa4z0XMxIQqQZkIJsMQ30kmu0wM
         Fa7X3KW8azxbcsa5NzZzdxPEjK9JfWmKw11uJIqAh2bs042hAnc613l1nnkIBXjDgwbk
         uywO2cpcNZNsb74PWeXq/GzQvZMkj5hR0Kz3IHUH9zKYRDSht93WxxWpxA0Lp3G8w60L
         ncBQfH3yJq797YTSa6JMTx2xK+XKIJcYYdIo4Z14MeAEVeY84yjod7fVoD1iD1MLHEwl
         ttQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=atrClaetg9DSCkw5CMYG0uu1x0TzMpea3sCswkk9tMg=;
        b=mh63cGdtf6ZPVFRr2QGIPkI/bKWDbe3vAzCd81CA07mCcn5aOgqMIPLPn7lNT9q/0R
         ao+twXawUDwsgNnIhqEeKq0+yhzup51kVG++yh7t0EW2LhBtbecV5fWMLx8n37TpML2G
         XkrfgpgSguywDzkkha8wiDQ1FAtUGP011mvYyfLSu4K6JVnTf0DpO3K6wM9Lyfxz67cR
         M7JXFmqZ7u5lLG8FSqU76g5TUUCLteD6Fr5gIrEsm7ZnEYiXrXYtmll/MD/ps9wE+SN4
         gYdfTB9RMan0ZBTRZ834fvZM4M1UdzMcSDs41s+s2GyTTHkAYttvbaBjDnOxKjeSBzU4
         5UyQ==
X-Gm-Message-State: APjAAAXtzkxdc7Q7qFzvIVFDY8jktlxzdkevIOozIAGimL10eua95TjI
        aOw+WMkurjSX80p4+6Y/Hl2NlQ==
X-Google-Smtp-Source: APXvYqyK9mg4ZcaDPZlHKZjeyX/V70g4PxrpFsjWjm8Iw63mhhpybFiBJ+03+AWFXkqR61cKjM6D4Q==
X-Received: by 2002:ae9:de07:: with SMTP id s7mr7088858qkf.89.1574193398896;
        Tue, 19 Nov 2019 11:56:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s44sm13300600qts.22.2019.11.19.11.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 11:56:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9c5-0004es-TK; Tue, 19 Nov 2019 15:56:37 -0400
Date:   Tue, 19 Nov 2019 15:56:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 3/3] RDMA/efa: Expose RDMA read related
 attributes
Message-ID: <20191119195637.GA17863@ziepe.ca>
References: <20191112091737.40204-1-galpress@amazon.com>
 <20191112091737.40204-4-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112091737.40204-4-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 12, 2019 at 11:17:37AM +0200, Gal Pressman wrote:
> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> index 9599a2a62be8..442804572118 100644
> +++ b/include/uapi/rdma/efa-abi.h
> @@ -90,12 +90,21 @@ struct efa_ibv_create_ah_resp {
>  	__u8 reserved_30[2];
>  };
>  
> +enum {
> +	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
> +};

This doesn't seem needed, caps should only be used if a zero filled
reply from an old kernel is not OK.

>  struct efa_ibv_ex_query_device_resp {
>  	__u32 comp_mask;
>  	__u32 max_sq_wr;
>  	__u32 max_rq_wr;
>  	__u16 max_sq_sge;
>  	__u16 max_rq_sge;
> +	__u32 max_rdma_size;
> +	__u16 max_wr_rdma_sge;
> +	__u8 reserved_b0[2];
> +	__u32 device_caps;
> +	__u8 reserved_e0[4];
>  };

This has the same problem as we talked about in userspace, the
max_wr_rdma_sge duplicates the field in the normal query_device
response

Jason
