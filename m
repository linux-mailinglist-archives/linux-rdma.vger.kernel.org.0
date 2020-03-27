Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F1195B2A
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgC0QeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 12:34:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38479 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0QeI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 12:34:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id z12so9067062qtq.5
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3vviqCu3BeG6uIIUCd43nA6eTJ5KzlQf0ffZzPpsPs4=;
        b=RBRV3WO801lKB8gQl1he0zYwjDdL4naaopbT1SR4ARbcSV/S7AqLJP9+u03VXASsAz
         5twpvwZOc8bUNlBpY/g1Ld1nlbi6iTnKCfR1J0npvRlhc83u4kiyUoPw84QZnyIAn+3c
         uRX/IplJS+dlOmmoNZAnQHSIVb/I1DN5HoDnhb3XVTjcb25C5mxh0ke+sIIbskJP5hD+
         2VnXLqqf8Hpvq6Th7cKkf5oaykK8tpMRptDwGxpRDEEN2bFAMdhepKgVFtKtNAurbKae
         bLsAFE3WzzdZSKUdTlNQ6covBJS/GDOnIvIyvDH7pEnahqeaMr0u69uVcmcXkMbJcqXa
         yK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vviqCu3BeG6uIIUCd43nA6eTJ5KzlQf0ffZzPpsPs4=;
        b=J1OGL6Daz47ccqrkCiE1auxGVjJJcXmsK0qJbQZKvOAwS1z2y4FTcF+ONA7sggCHMc
         vMvLm+kpjM8k76MlYBjB3dplEi8UaVvObDtwo4sIHpWeBSqT/SE9O2HOqOgTLPS4up0e
         ZKxSU/OhPFT8bnAwFSm/uHDGF/Ph2PbGxRRtVHMSZ/jf07BPY6YDw2VIrxtfGfPQL0qZ
         vmt+8EzsHCEHUAnfBGbOdaP1UQrXBUB+1yUXRBEZPZ71VhOrCnGxUdclTHyl8oeHylw2
         hiHgbhWAxG5O+liwYBzTOos7U8kDY62EijwFSESr12qIKu7bv7gSvKH10lY5eLBYymbZ
         MErw==
X-Gm-Message-State: ANhLgQ07QCU+/v4BnRMFdotWzcw8ClfgsjpiI//G2vcyvBau10ciffLr
        ilDDEuViEwkX4hwNbaWMZ5Qs7Q==
X-Google-Smtp-Source: ADFU+vtWDYI244g1D1/9GAn8KCVhcGD/3cO2b4hDQssj0QNU+Fk5Jj8wwwqNkqug3JExHVABVuG6jw==
X-Received: by 2002:ac8:7085:: with SMTP id y5mr40941qto.47.1585326847461;
        Fri, 27 Mar 2020 09:34:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t6sm4138177qkd.60.2020.03.27.09.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:34:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHrvq-0001gp-4j; Fri, 27 Mar 2020 13:34:06 -0300
Date:   Fri, 27 Mar 2020 13:34:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] RDMA TX steering support
Message-ID: <20200327163406.GA6423@ziepe.ca>
References: <20200324061425.1570190-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324061425.1570190-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 24, 2020 at 08:14:23AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> Those two patches from Michael extends mlx5_core and mlx5_ib flow
> steering to support RDMA TX in similar way to already supported
> RDMA RX.
> 
> Thanks
> 
> Michael Guralnik (2):
>   net/mlx5: Add support for RDMA TX steering
>   RDMA/mlx5: Add support for RDMA TX flow table

I applied this to for-next, in the unlikely event that the shared
branch is still required the net/mlx5 commit is

24670b1a316618 net/mlx5: Add support for RDMA TX steering

Thanks,
Jason
