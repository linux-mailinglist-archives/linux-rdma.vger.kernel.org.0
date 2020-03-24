Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90671191D1E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 23:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCXWwz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 18:52:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42811 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCXWwz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 18:52:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so433769qkg.9
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s97NcoiimSY+SLC3KhNiGGRZTKkCVt2XYNBD1w45KLE=;
        b=JC1YeJljnfPNXyEFvjc84jgLKteJLZ+8kGsVQM2rf+2nsw372+efqtqk5F/wMTqlRu
         fpEhrAGfhxqOqGpgXE0SVozVRQTwrXzlsnctg755YRa2XqCHklp9EQUvd4bsiaHg0K0j
         FjBwy/hgWeIm+4KnAVbua8ISWzScIvTrhwAxzx+d4JEZzvgPHzsugdaf5QeAAp+97qyH
         xDbGy4pD2J/5ZKGlrdBoa8ZBHCcvfjtCl6OnNPFfNU5mliv06m3zWlmFvGkFpYNJFAB1
         NsabRN7ivpLYcGnG91eZE+IMImg4iW+YdhyePnyjWDnyd9kIMbUPpPcPGZoEk4qkzzNy
         b0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s97NcoiimSY+SLC3KhNiGGRZTKkCVt2XYNBD1w45KLE=;
        b=jRvplEOc1a/WVgFWer3/kN2xLzZ/I1qhfxyuMztaCU7IAojb3p2K0nSQGhfM+EZG+H
         a6KGvSav6F6hwtVdwCbyCpAkWCA2pSxHJVKj0Z7D3QbPG2GbtuUpQZgEbG1+05KypktU
         6yyZauZwTh9l/PPFBZrCdQjhbZvGoqWNCwEAaf3cy37GaRwkhxjEV1MICZ49HNEHh1Rb
         NqKCxgfgdhbePxOfdQMIEVWhL1BpMuzdZMpXNXPKkClG5KjXMxyNRQdZ6dIfhh5viKay
         jZIssWdf8u98zN24G3FUzkTn8pjW19GFAVpsvsrd6hjhU2RwBX5960gwq5UT3wHYHCup
         hIWA==
X-Gm-Message-State: ANhLgQ3OCpLxEbwBhSryljEzAdnbZqA9LA0FdWbd7okOZiV9IA83entA
        7onfe7p/ZDrcMreVXvrujTn5mQ==
X-Google-Smtp-Source: ADFU+vtxfc/JeUSGuN+78EPSUMkjDIE0WoNpmDAWqcqhHjkWYxSp/2i/WcLYOwLXVJd+r7kUtP78ug==
X-Received: by 2002:a37:b185:: with SMTP id a127mr249758qkf.224.1585090374539;
        Tue, 24 Mar 2020 15:52:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y127sm13826068qkb.76.2020.03.24.15.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 15:52:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGsPl-0007XA-IU; Tue, 24 Mar 2020 19:52:53 -0300
Date:   Tue, 24 Mar 2020 19:52:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as
 RXE maintainer
Message-ID: <20200324225253.GA28932@ziepe.ca>
References: <20200312083658.29603-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312083658.29603-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 10:36:58AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Zhu Yanjun contributed many patches to RXE and expressed genuine
> interest in improve RXE even more. Let's add him as a maintainer.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Acked-by: Moni Shoua <monis@mellanox.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
