Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACDB150A83
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgBCQIv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 11:08:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33523 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBCQIv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 11:08:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so11863481qto.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSPZAcOwPE+miJM24DVr8MZ7WJDnXgEIbTgSwRc+jIA=;
        b=WjZgNzuuuV6G+eRlnJWokzLzP/XrDDDrcej7Nh/5ihiHRxMqFR4M+jT6h8FBViqAKX
         3+R0PT+a9Njm5wP3gC+KEiB4ZLU5GAnA8C9Yq/5nnqyRC7/+M82ti4Bc+JkBWu2ocKUM
         /xk8k2nQitfsayF3q6SteKakMt1evOgq9L9tRcD7qQoJd/Eqxp1DXU1woyZZl2eFINlL
         80+UbLUY7Xqex8OxDe2f75R2iqDJr7YMurmJePgrKx3hufSLrSU/vsP67YpGQMjyHz3Y
         qJzOK2yHdwgy3nPuvnmIO+PZW5pp4C/1aRpii78RSOU0NkcPLCqYP7z8q6onNhaxPVzT
         jouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSPZAcOwPE+miJM24DVr8MZ7WJDnXgEIbTgSwRc+jIA=;
        b=aRRYJskpzLqFsApt3Ghg/bzFtxQ4iuyP7PEeT8CjG/cuvZml3sXEPKHQL5f9Q7zW6k
         vji/xlYbQs6GTvWZLe2H6a/fTz50q42lG5f0zGskJEp5KSQnieXVUvv7hJljwy4hvY27
         xyUeDnq7bSIF2dxE6gOLsa4pBzy5M11+LN/KJVzbR2mpcfMcVDd64pHQiBfJEQuHeF4G
         XHQ22JAaERUMPDz8/fCpeW8ob4h677xmLgCdYOVFCUgC7/DZBqd/DMZifJeOajprzWVR
         eTO5cMho09Bx5M7d/YbC+XDAZj1WQLba9jqlEwBFhpDvGLfgrJMICRaDY0qODzbb9YU1
         FsJQ==
X-Gm-Message-State: APjAAAUMDPlsZavPojfaHLEDPKHiMr6vUT6xr0WJQCBw2XSUoejk8ZAJ
        HPovxsGZBC7QqHkNVFxfXlVM3a+6vwI=
X-Google-Smtp-Source: APXvYqwm9UInITNJex3Mh4ZeSgNXxj3n8t7ugFfZmUxJM0x23Zm2/FJKimtPfPacNXLZrqM290fQ9w==
X-Received: by 2002:aed:3786:: with SMTP id j6mr24907805qtb.62.1580746130500;
        Mon, 03 Feb 2020 08:08:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w1sm10292594qtk.31.2020.02.03.08.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 08:08:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iyeHJ-0006oQ-FH; Mon, 03 Feb 2020 12:08:49 -0400
Date:   Mon, 3 Feb 2020 12:08:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH v4] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200203160849.GA14732@ziepe.ca>
References: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 10:56:55AM -0500, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
> 
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
> 
> The output would look something like below:
> $ ibv_devinfo -v -d bnxt_re2
> hca_id: bnxt_re2
>  transport:             InfiniBand (0)
>  fw_ver:                216.0.220.0
>  node_guid:             b226:28ff:fed3:b0f0
>  sys_image_guid:        b226:28ff:fed3:b0f0
>   .
>   .
>   .
>   .
>        phys_state:      LINK_UP (5)
>        GID[  0]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
>        GID[  1]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
>        GID[  2]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
>        GID[  3]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2

I think you should display the RoCEv2 GID in IPv6 notation, since it
isn't really a GID anyhmore. The IPv6 notation should automatically
show the IPv4 dotted quad

Jason
