Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CCF180224
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCJPoJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 11:44:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39191 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCJPoJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 11:44:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id e16so13150153qkl.6
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGhJEwYcNkUu6d/e01/ViI8q88K0xEDtn9j67HjaOA4=;
        b=JcghvuH3dTV7R9Cmz0QTTUjydzhoT4QmEj3YCpCtlgLm5fqLmJxrFPiu/49qGXIww9
         bZUAF7O7Fkz9h5xa6NpZ1g1nw4D1Dam/ikwaufJvKcgrF8GAkvaytJYtlMZTI/PC412t
         lEZ0ksQNvVubseHNnRcf7SaDwEtY9eQ5XOzH1PqBj+9p6n7LO+GnH8iV/gdsffOsUYxI
         5rDhR15Qatd5YLsip0YVwqc+fmPN3g56wdioDr7SwHJWJVbriGb2Prc+3/EI/qNAigYf
         dNx9bjoNaeXR5I5dPvzPgoaCoA09Lm26erNHsuJuO0jEsBLLdUgjNDfIDuLyQ85Bt6i+
         Br3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGhJEwYcNkUu6d/e01/ViI8q88K0xEDtn9j67HjaOA4=;
        b=CtLvoYv///sdM0hchYzvHRDLnEdH8eiiywFgtOgwKiJveT/LeHmLTf4YynoXfN9yvL
         4pZ8WsaXTVAWqAWZ+NuZY9p3+8D5a+5gurMhyb5HixBVYb4jrWmlO/YYJF54kfm/qL92
         x4phbYrvWHol5nsxQodOd0MtMlhKCrnUYykqsf1svdPmS9tXGe+wxkdcVFUg+NNbqXuC
         hu7bnmGbnhipvAqkhBDAQlV3zbTYblb7mPJlhnOjDjKeZdmdGDTOwfFS0s5q+VU3V0LQ
         zFsBdya3Il6bVa6r6wLNklQITg/gQJIIaXbfAebUotvlTEhyCArI5Vm69T5Fx2L2YuSt
         Z9Kg==
X-Gm-Message-State: ANhLgQ2G5JUHW04ON87GaHyg3/uJL1y8qMUCADW7uwgy52gMDthu0l0+
        cTtQqv593NgeD6KuWttNDTvNTA==
X-Google-Smtp-Source: ADFU+vvwLCrijPW2mlTtSZFKgaK4Ld7nVbLZtRjIOdfDyy3Ll00vBa2o09jzcWOt0sbz38cJxp/ksA==
X-Received: by 2002:ae9:f70b:: with SMTP id s11mr18352032qkg.201.1583855047937;
        Tue, 10 Mar 2020 08:44:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p2sm23345128qkm.64.2020.03.10.08.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 08:44:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBh38-0005Fi-Oo; Tue, 10 Mar 2020 12:44:06 -0300
Date:   Tue, 10 Mar 2020 12:44:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/2] Packet pacing DEVX API
Message-ID: <20200310154406.GA19944@ziepe.ca>
References: <20200219190518.200912-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219190518.200912-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 09:05:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This series from Yishai extends packet pacing to work over DEVX
> interface. In first patch, he refactors the mlx5_core internal
> logic. In second patch, the RDMA APIs are added.
> 
> Thanks
> 
> Yishai Hadas (2):
>   net/mlx5: Expose raw packet pacing APIs
>   IB/mlx5: Introduce UAPIs to manage packet pacing

Applied to for-next, thanks

Jason
