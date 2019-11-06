Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01875F1FA6
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKFUVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 15:21:21 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:32902 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKFUVU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 15:21:20 -0500
Received: by mail-qv1-f65.google.com with SMTP id x14so1988080qvu.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99SUOpwMOoDmGaqlAqAAE0NX4V2byws+FTfoeeEsouM=;
        b=Wc6sHf7FLvveaVcXMAHxP/GQSwvUInGVKIzZPmAuWKprFG5fHV+zg21pcYKt6ep4e3
         tp3Ac+ukkZI3NpBFSJfwRcibqeK53PaK7wbQaI/sdcYLrwlpCqzvRcyi8C6ODhAmjP/k
         S99q/5SdPpNV3eUm2Cpg6V/yRRpfysC7SGEssQ7WBD7qpjv3smNK2znSRw0nvrDPOxSW
         7hbbKyKqO2VpMo055GGQ/K2kOCs4X3XVNTThn39g7jqNFvih9t8AAoHx/GB3I0yCY84Z
         6ssnOlmq4ia4/c8EFkP3tRAhjOncQk8a53jyukUik9iI8WPvtnKDCT+KGkaPwP5EecVr
         jlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99SUOpwMOoDmGaqlAqAAE0NX4V2byws+FTfoeeEsouM=;
        b=eGH6zylcVFkCN38Vjg36etvLBhFUSZ2xmYgLwb4zTLje5TART/8kzJue2XrlsZ7IeC
         ab+Gq70Gk+/o/NYhZ0jDufAFtzA/q83zfTNvXXNplrR52DUAgnq6aFOQsJ9LZeDZrP9k
         iFMsMeb2LjCbHH5wg8EkbHQp7HxD41y/T0vTIwMhGL3OPNj+O1Ht2C2RIjCOBXWyLkTU
         bnRwNKrujoT711W18JpjlbaHu/QAJPtG6WBiGEmRiWYGTVYefeNCmTE5u8T+zvyLJcZT
         aNK5A2jkhwJi9wuxZfI1aBND1e/M6vf7OIaX2JcrbU0pZKPnF60N4ZwJuEefW1+6Aq0z
         iuiQ==
X-Gm-Message-State: APjAAAWcQcWDWgNAHGt7MF8J2K5rKy+vq5262W+CMKQIWQpt2Dw2oD+R
        O2JQfI3bpDvx37zB1V3q2QmV2Q==
X-Google-Smtp-Source: APXvYqwES+MbSNfrA952bLonNqt2DyMi8hS6M002YZJ2M3EvIORDCTXab7b1YJQ71EVMUZduQdNMnw==
X-Received: by 2002:a05:6214:931:: with SMTP id dk17mr3892992qvb.19.1573071679831;
        Wed, 06 Nov 2019 12:21:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 27sm15971544qtu.71.2019.11.06.12.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 12:21:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSRnq-0006mI-Nb; Wed, 06 Nov 2019 16:21:18 -0400
Date:   Wed, 6 Nov 2019 16:21:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v2] IB/mlx5: Support flow counters offset for
 bulk counters
Message-ID: <20191106202118.GA26024@ziepe.ca>
References: <20191103140723.77411-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103140723.77411-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 03, 2019 at 04:07:23PM +0200, Leon Romanovsky wrote:
> diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> index d0da070cf0ab..20d88307f75f 100644
> +++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> @@ -198,6 +198,7 @@ enum mlx5_ib_create_flow_attrs {
>  	MLX5_IB_ATTR_CREATE_FLOW_ARR_FLOW_ACTIONS,
>  	MLX5_IB_ATTR_CREATE_FLOW_TAG,
>  	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
> +	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
>  };

Where is the rdma-core PR consuming this new uapi?

Jason
