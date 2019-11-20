Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4552910417A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 17:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfKTQxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 11:53:04 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36400 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfKTQxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 11:53:04 -0500
Received: by mail-qv1-f67.google.com with SMTP id cv8so186454qvb.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFGGhPq6BvNyMYQknLW2ICQHPGQUtXRdqVnFI2VHGSI=;
        b=PJkuJ3WOcSOagcNL5sWyrdv8Yfy8YmvJNeMs53qw1CKiU9pJPJgtfO4YVOTYlWm6lM
         e9TZPx2mMLMFgz9GVqMktw8qWNzd761whV1R4YjE3uOXrGMpkCueEz2FRWXIfXh9U68q
         V4soFtyPEgGYaDyk8GapoUQKeYUA3M5vVQTfEDUfHPxiQg5m82YI/KEW/65kElGIAmm2
         nAdqqly8Rhdmwbk7j005kL0jcMlrGUywRVarzNBp7jJzeef89Qhpq+j4QhASK6MXLR/s
         zCsFPGbDKglWHMF30ksMYllefH0/glMnbdwR3g7W5YdEa1N1HXnSlPjhcdtq85CY7szs
         1Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFGGhPq6BvNyMYQknLW2ICQHPGQUtXRdqVnFI2VHGSI=;
        b=Pm3IdAqAGDtTQgol4c7r5N1hR9FzDlZ6jXwRIKVL66VhmvEdfDaAD+yA4egT98CSTB
         75CejMiscSGJ2taQLfU18HriShzNdRpInRIlQjKYrH4xl4BDzqnmc9GpdSDb61akiQnr
         7G/c7ABdVmcag9zu9u1RiwRz5gY8hh7+GiH1QjpkLQAOQR9caluf5r/bkOCBvnIOVPhR
         59RLMrwCgFzKE0iODWZWyLNTCrc6JH8NVHbEaDX0MSrvHS1AcSgTUxTeX3dSKYe/HAGN
         PVWbl3lOYdszMQMSqNKNK/VtL/ND5IFMYol1GzuYvASDibw0NWokOKEXcNPQrEDm7tMc
         MwRQ==
X-Gm-Message-State: APjAAAUebJR0n4jo7UluV4sX0tea8i2a2OOn1A2F4ySEE8odPItojMz3
        fDvAiTOkUa/O7VZvpN3eQ8Qvs+XDFHg=
X-Google-Smtp-Source: APXvYqzwvp+OG4OS4I+OyMWZPElP5WbUvHGKlSzxtIhUw2tkSzInAZNRlThJ4u/qsER6CCghdT7fuw==
X-Received: by 2002:a0c:802f:: with SMTP id 44mr3421453qva.116.1574268782991;
        Wed, 20 Nov 2019 08:53:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u22sm14860591qtb.59.2019.11.20.08.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 08:53:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXTDx-0007sK-Q0; Wed, 20 Nov 2019 12:53:01 -0400
Date:   Wed, 20 Nov 2019 12:53:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/qedr: Add kernel capability flags for dpm
 enabled mode
Message-ID: <20191120165301.GI22515@ziepe.ca>
References: <20191120132009.14107-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120132009.14107-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 03:20:09PM +0200, Michal Kalderon wrote:
> diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
> index c022ee26089b..a0b83c9d4498 100644
> +++ b/include/uapi/rdma/qedr-abi.h
> @@ -48,6 +48,18 @@ struct qedr_alloc_ucontext_req {
>  	__u32 reserved;
>  };
>  
> +#define QEDR_LDPM_MAX_SIZE	(8192)
> +#define QEDR_EDPM_TRANS_SIZE	(64)
> +
> +enum qedr_rdma_dpm_type {
> +	QEDR_DPM_TYPE_NONE		= 0,
> +	QEDR_DPM_TYPE_ROCE_ENHANCED	= 1 << 0,
> +	QEDR_DPM_TYPE_ROCE_LEGACY	= 1 << 1,
> +	QEDR_DPM_TYPE_IWARP_LEGACY	= 1 << 2,
> +	QEDR_DPM_TYPE_RESERVED		= 1 << 3,
> +	QEDR_DPM_SIZES_SET		= 1 << 4,
> +};
> +
>  struct qedr_alloc_ucontext_resp {
>  	__aligned_u64 db_pa;
>  	__u32 db_size;
> @@ -59,10 +71,12 @@ struct qedr_alloc_ucontext_resp {
>  	__u32 sges_per_recv_wr;
>  	__u32 sges_per_srq_wr;
>  	__u32 max_cqes;
> -	__u8 dpm_enabled;
> +	__u8 dpm_flags;

Is this redefinition backwards compatible with old user space?
That should be described in the commit message

Jason
