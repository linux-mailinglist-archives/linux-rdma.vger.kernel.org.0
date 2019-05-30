Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C9301D9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3SZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:25:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45112 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3SZL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:25:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so8151104qtc.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cSrqrIgrInAtLJo2kHqTtMUGh4CJxgy1fN3QR1jv1as=;
        b=PSNhexlAm6eiP/1ALt5hMFol25rYfA4R/+e93oiOPOaoY/F8gI/mQpbQsHsx2Pl+Lt
         aebs4GAvYHYe2sClBfzLLLzfnJK3NeQy8c8jakZJw0VJnMUxskWPDB3eD3dT5E+6nimR
         jAOe9ki+X2MnTZzJxCBGXmc+fbuyP6480BGM6pyZ9cizHvuFV5ddfbCXHSav9panuWkB
         00HvOZfHcaIk369Zj91vkEHDWF+Qwi4cWAixPcJvVXZGkLM+KZvEBG7JdXHnOGzMW1Yp
         9FSbNVd15brUOaDSYKSyYZCltb+oyOafEzCFb8wCNEQlWzC2aK6uydB+6crvwXBSaJ6d
         Fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSrqrIgrInAtLJo2kHqTtMUGh4CJxgy1fN3QR1jv1as=;
        b=hzsma0dQbKZM4M9jHdk65U8fAinjdwGNm5preZ4NEcaFweeRcIME3taqRgU0xHFB3d
         tvnMOu6XuOWeyCLoKPNwYmgAHj3ItTHIUt2uahKFQEclIOSYHdJqlLtuoTHr8VkkuUyb
         UC8+YDNrhpp7TrnY8Jpe3hmU/jjW+fSZhcJuGjHl9EtO5buYJFvd+63pmoGULDT5ouhD
         Ob1pCTKSebelCyv93wlcy3Q/Nw1JdRI5Mn3Ttqons1t0sfYIwsPh0SA8mJ3PegEKTszQ
         KJf1q4Z2zlKB93nT0cCQ4EiYXImY1Fj3P1zTWSOcmDC6TQeAeXj4+yv4+AGXMewhKtTl
         I7CA==
X-Gm-Message-State: APjAAAVjmGucJx3huMzl5+7lB8AhCGuO/4Rf4+P0MBUqGO7X+5pFurnc
        9ZsxZiGBngIp6YrR85hFgIg9LECWXiE=
X-Google-Smtp-Source: APXvYqxFvdV4MF4CV763d59CefX8RLv1BSJVJkc7V5EiOiPCFp4cZVnXPPEYyYl59Wen8XdmhbZNfw==
X-Received: by 2002:a0c:c612:: with SMTP id v18mr3872191qvi.215.1559240710445;
        Thu, 30 May 2019 11:25:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g9sm1459540qtj.67.2019.05.30.11.25.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:25:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWPjh-0006Z7-Gd
        for linux-rdma@vger.kernel.org; Thu, 30 May 2019 15:25:09 -0300
Date:   Thu, 30 May 2019 15:25:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 00/20] Incorporate infiniband-diags into
 rdma-core
Message-ID: <20190530182509.GA25195@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:49:16PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Ira would like to stop maintaining infiniband-diags, and also bring it up to
> the level of CI, packaging, static analysis, etc that rdma-core has. Since it
> is a fairly small and complementary code base, just roll it into rdma-core.
> 
> The packaging is based on what Debian, Fedora and suse have already.
> 
> I've already sent many commits to infinbiand-diags that clean up warnings/etc
> so this drops in and passes travis CI.
> 
> Like all the past aggregations this preserves the GIT commit history and
> per-file history and blame works with --follow.
> 
> This should not be merged until after we make the next rdma-core release.
> 
> It is a github PR:
> 
> https://github.com/linux-rdma/rdma-core/pull/529
> 
> The diffs attached are based off the merge point that includes the entire
> infiniband-diag's source as a subdirectory to rdma-core. They show the
> transformation of infiniband-diags to fit into rdma-core.
> 
> Jason Gunthorpe (20):
>   ibdiags: Add SWITCH_FALLTHROUGH
>   ibdiags: Add required definitions to rdma-core config.h
>   ibdiags: Remove unneeded HAVE_ checks
>   ibdiags: Remove config.h and HAVE_CONFIG_H
>   ibdiags: Don't use __DATE__ and __TIME__
>   build: Support rst as a man page option
>   ibdiags: Add cmake files for ibdiags components
>   ibdiags: Copy the cl_qmap implementation from opensm
>   ibdiags: Copy part of ib_types.h from opensm
>   ibdiags: Provide the cl_nodenamemap interface
>   ibdiags: Add Debian packaging
>   ibdiags: Add Fedora packaging
>   ibdiags: Add suse packaging
>   ibdiags: Obsolete mad_osd.h
>   libibmad: Flatten libibmad into one directory
>   libibnetdiscover: Flatten libibnetdiscover into one directory
>   ibdiags: Flatten the infiniband-diags tools into one directory
>   ibdiags: Remove obsolete build system and related files
>   ibdiags: Remove @BUILD_DATE@ from the man pages
>   ibdiags: Perform substitution on the RST include files as well

Merged on github

Jason
