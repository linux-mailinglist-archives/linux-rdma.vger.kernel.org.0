Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A080E6BBB6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfGQLoe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 07:44:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38497 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfGQLoe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 07:44:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so17188757qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQdDg6bbzqvrsF8D3pcHx1woITnP337NAgIleobh6kY=;
        b=Klb4MF03OuahvFr+wB7W3FBrIY33QAZfssPMSp1z4P7ikEG27wBmp86/ynT4Vqj4E0
         zJvNnToYRCNiQ7OmYaSj9MVP6bosQeMBZKDPmp2zOABjJe+bpeVg1iEKEHjreqm2uMSr
         UPlr7+f3NZCM/jhzmm4P2XjwgG06PQTh+9Z0Ukq2WCv4Dq4lU6/o9lfMOOI2SO0wBpLQ
         zkICg2Z42/A/AAAli78PlFP/jkGBTYvhGXs79KMG183MNeuDQpo2OU/H9DHJwGb0C2Tn
         MTdBLinnGc8sSMybArP8Z7P0NhKoJWtU7qvMa9bNGzXmfN07OlF6XNR7oZj07pmtYZlS
         mOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQdDg6bbzqvrsF8D3pcHx1woITnP337NAgIleobh6kY=;
        b=GPm+uZXpuOruXUsVR8IpQP+0zm2L65uMPCTDCRczsgxRKqMY61HSZsFZV7Ja8zBDRL
         /KTGSYEEzNL1c2uB4kqQEm+F4Fv6KIrTbbnmQkCU9u0n7YrmMq7RhBgr5OvVpV886eC2
         3GW1F+NIXAZxk4Z6mxDtzwuUZKhqk8C9/Ow+bLa5sm280H9l/vBreaWI0YCaz/Iz079u
         G7cKb7SUWJ4lhX/vJLh3AHr1+5w0/os7773E+8yEi4Yfghlt66kWNGZyeDZptOmjSstf
         EtJ9oVmBAKTTpMZE4FhITJJ5i9MtBiZJ1qFuW2pXYou7dj3TV2pa/OQnbdA5ue7Ztzq1
         oFkw==
X-Gm-Message-State: APjAAAXthkgXU5KSAcvMpfGXfw9qKL5xSUlIm3aY+3PD+EllUfsCUa9x
        /1lFQrOz/6YwFbqAK/R5L5mEUg==
X-Google-Smtp-Source: APXvYqwxkwGEVOcXU6yEhnr78kQSxlUcZ2y/CJYB2ot5l0eC/XUOKfgpdms6dN5xmeQ3KW6ZgpioWw==
X-Received: by 2002:a37:464a:: with SMTP id t71mr26080628qka.436.1563363873595;
        Wed, 17 Jul 2019 04:44:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r5sm10836081qkc.42.2019.07.17.04.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:44:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hniMK-0003Nw-P8; Wed, 17 Jul 2019 08:44:32 -0300
Date:   Wed, 17 Jul 2019 08:44:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <srabinov7@gmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, monis@mellanox.com,
        parav@mellanox.com, danielj@mellanox.com, kamalheib1@gmail.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        shamir.rabinovitch@oracle.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 15/25] IB/uverbs: Add PD import verb
Message-ID: <20190717114432.GB12119@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-16-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716181200.4239-16-srabinov7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 16, 2019 at 09:11:50PM +0300, Shamir Rabinovitch wrote:
>  /*
>   * Describe the input structs for write(). Some write methods have an input
>   * only struct, most have an input and output. If the struct has an output then
> @@ -4015,6 +4105,11 @@ const struct uapi_definition uverbs_def_write_intf[] = {
>  			UAPI_DEF_WRITE_IO(struct ib_uverbs_query_port,
>  					  struct ib_uverbs_query_port_resp),
>  			UAPI_DEF_METHOD_NEEDS_FN(query_port)),
> +		DECLARE_UVERBS_WRITE(
> +			IB_USER_VERBS_CMD_IMPORT_FR_FD,
> +			ib_uverbs_import_fr_fd,
> +			UAPI_DEF_WRITE_IO(struct ib_uverbs_import_fr_fd,
> +					  union
> ib_uverbs_import_fr_fd_resp)),

New non-ioctl interfaces are not allowed now

Jason
