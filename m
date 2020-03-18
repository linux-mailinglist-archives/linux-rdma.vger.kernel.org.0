Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16B6189D6B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCRN4W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:56:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42661 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCRN4V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 09:56:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so20649904qtp.9
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLTE7LlnyouQoakEIcCMj/A9xCpW9OpvmzA0kjN3/NU=;
        b=KnsHcqMcEWCfYB28HFZm/UemfTp8vebklg6XLEl3pwLdmRxy8iXb7ZL8bSjnQRblK7
         Q1PXPZU001y5OqkJF7vo+rSRT2gYKMVzdhYgFu3MrK5rsQ8jydB1KHhl4CP6QTo1v+i1
         pbarKVbQdlDu4biyG5dumortxMm2Jj2zL9M1dON/tMi7Tn3aw1nPwVPrcLxV0B6uuQrp
         FsEK4OGXmsG/nkYL39b9NR90KEmhYqkjDNQbfzN4O0LucPHwTcxny14lfkbHUUzjGn05
         EL23j5iFgV0AohKuJq/N14bOMybdN/++8gxl0Z2ELyEEjEQrNpOzlCjcj+tFxdBVX6uQ
         n3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLTE7LlnyouQoakEIcCMj/A9xCpW9OpvmzA0kjN3/NU=;
        b=DpSHFVpskiw+Lz43R7+wLBW23BF55FELRSMWpGeUV+vyLzmP5glZgJtfKuEIYUbshw
         QfJov1HVTdppl0cNRO2I4V+mZWfbLLrkZm49ZiZHZNlHRLRPJ0O3Wf3mu4pTTwf2d0+4
         V5B+lQqBUso1AtxyocUFCwmJbMNLGJ9B2u1IkkOmqRiJHxMtMI/L7iwZrhwi6+DUB4ao
         e5ouMNKB2bIot1hPChi59aERvOT++aXeWl3zJJZyM9pKyQFQgQNSCEwHuvkHCPQJrn5n
         uFTcPvOfID/tTDupxpVnsH3oCnghKUCStD10S7v4+hB8u/wq6y0YP7+nyXRy/2wV0tFy
         LP3g==
X-Gm-Message-State: ANhLgQ2fU7Jd2UI6QFrO59/Htrh69wA0mcvVHRvWAhmTnQ6BJzG/MgZ0
        KIoiAGHylNP3tA7MkFOKuWwd1Tl0HGKdMw==
X-Google-Smtp-Source: ADFU+vuYU+F0Pgk1dkAHvGdzZo0Ja0GoYr7qsWZjBVW6k9jjP9K88ivOFyybP02Mgn6eOTilIaR0WQ==
X-Received: by 2002:aed:2499:: with SMTP id t25mr4660405qtc.127.1584539780481;
        Wed, 18 Mar 2020 06:56:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 60sm4625598qtb.95.2020.03.18.06.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 06:56:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEZBD-0008Rr-AX; Wed, 18 Mar 2020 10:56:19 -0300
Date:   Wed, 18 Mar 2020 10:56:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        "Sindhu, Devale" <sindhu.devale@intel.com>,
        Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH v1 rdma-next] i40iw: Report correct firmware version
Message-ID: <20200318135619.GA31930@ziepe.ca>
References: <20200313214406.2159-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313214406.2159-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 04:44:06PM -0500, Shiraz Saleem wrote:
> From: "Sindhu, Devale" <sindhu.devale@intel.com>
> 
> The driver uses a hard-coded value for FW version and
> reports an inconsistent FW version between ibv_devinfo
> and /sys/class/infiniband/i40iw/fw_ver.
> Retrieve the FW version via a Control QP (CQP) operation
> and report it consistently across sysfs and query device.
> 
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Reported-by: Jarod Wilson <jarod@redhat.com>
> Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0-->v1:
> -Remove implicit casts
> -Use static inline function for computing FW version instead of macros
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h        | 22 ++++++-
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c   | 99 ++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/i40iw/i40iw_d.h      | 26 +++++++-
>  drivers/infiniband/hw/i40iw/i40iw_main.c   |  6 ++
>  drivers/infiniband/hw/i40iw/i40iw_p.h      |  1 +
>  drivers/infiniband/hw/i40iw/i40iw_status.h |  3 +-
>  drivers/infiniband/hw/i40iw/i40iw_type.h   | 12 ++++
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c  | 10 +--
>  8 files changed, 170 insertions(+), 9 deletions(-)

Applied to for-next

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_d.h b/drivers/infiniband/hw/i40iw/i40iw_d.h
> index 6ddaeec..e8367d6 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_d.h
> +++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
> @@ -403,7 +403,7 @@
>  #define I40IW_CQP_OP_MANAGE_ARP                 0x0f
>  #define I40IW_CQP_OP_MANAGE_VF_PBLE_BP          0x10
>  #define I40IW_CQP_OP_MANAGE_PUSH_PAGES          0x11
> -#define I40IW_CQP_OP_MANAGE_PE_TEAM             0x12
> +#define I40IW_CQP_OP_QUERY_RDMA_FEATURES	0x12
>  #define I40IW_CQP_OP_UPLOAD_CONTEXT             0x13
>  #define I40IW_CQP_OP_ALLOCATE_LOC_MAC_IP_TABLE_ENTRY 0x14
>  #define I40IW_CQP_OP_MANAGE_HMC_PM_FUNC_TABLE   0x15
> @@ -431,6 +431,24 @@
>  #define I40IW_CQP_OP_SHMC_PAGES_ALLOCATED       0x2b
>  #define I40IW_CQP_OP_SET_HMC_RESOURCE_PROFILE   0x2d
>  
> +#define I40IW_FEATURE_BUF_SIZE                  (8 * I40IW_MAX_FEATURES)
> +
> +#define I40IW_FW_VER_MINOR_SHIFT        0
> +#define I40IW_FW_VER_MINOR_MASK         \
> +	(0xffffULL << I40IW_FW_VER_MINOR_SHIFT)
> +
> +#define I40IW_FW_VER_MAJOR_SHIFT        16
> +#define I40IW_FW_VER_MAJOR_MASK	        \
> +	(0xffffULL << I40IW_FW_VER_MAJOR_SHIFT)
> +
> +#define I40IW_FEATURE_INFO_SHIFT        0
> +#define I40IW_FEATURE_INFO_MASK         \
> +	(0xffffULL << I40IW_FEATURE_INFO_SHIFT)
> +
> +#define I40IW_FEATURE_CNT_SHIFT         32
> +#define I40IW_FEATURE_CNT_MASK          \
> +	(0xffffULL << I40IW_FEATURE_CNT_SHIFT)

Please see the discussion about these kinds of macros on the EFA
thread - please don't use this scheme in the new
driver. The standard GENMASK/FIELD_PREP/etc should be used

Thanks,
Jason
