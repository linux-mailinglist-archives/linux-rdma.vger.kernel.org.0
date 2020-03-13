Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F80184881
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgCMNxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:53:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38914 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCMNxF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:53:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id f17so6213747qtq.6
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhTAEUb0CKU7cUmJxlGIQXm3jXmhdS/EU6RvOkuimUc=;
        b=pC+JllgYSu5r6kQR54aaqYTMDt6E7+AP+ncEtV8/YJ7mtqAZ/2/JYJ/wDnhHDRcsL6
         wGq6H8l+r6u7GBB/45/+tQudBCb9mu78Avehje7/VxZi4jxYZfF81mhLMeT/vArq3S7p
         c0yFXsamH0g2jmyGiOq1jVRlozRFMuNOs/NPhv0i4XVpoGWWb3gyPcBgIiW3Ib6T+VCW
         /0Gl8bTAOzm/JqFK4BGGMEOctYH9YKTlLUXdlRYVt/vfTj/Fqh6IabQZfdZBjqHlwS0r
         jj5DXo9RjV8u0QTPnxbmB7gfSro/CIIAXgPqOBMtta9EsCrid91JuPTnGP9jCuOY6qfk
         kF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhTAEUb0CKU7cUmJxlGIQXm3jXmhdS/EU6RvOkuimUc=;
        b=IhxEBV9jitB9AG2uP6mvdLf2ydoE0gw8nvHpV9ucnh6pZdwX+pdk/JriY2WbcK+uRj
         BRUWpAcBn8lAr2WZ+mvdj61azN9QUAYV5n84YBjEX0E+BrTv3g9S58L851gfp/Z0HcLL
         yhCmAJpNDPmetAmk7rbZcr2Nfm9j2o6sXhFxK1kAyX1Mt4wmdPGf9YCWHW57LJBf6qr+
         Lqw/HOY9hR+si6eUXGOWT3uL4T12NeHtMy7QatQgY5PshwskZe1uJmM6pNT6bq+pbMeT
         4g5TIY1xP5sPntfXG77midAs7jf+8unwCHvrmRdEVTqsj5ZMESF6VUVXRWmQjEj5kw2F
         N3dg==
X-Gm-Message-State: ANhLgQ2DPVQz5Zp0mfOkLiTSlyr0o0+YmqZpv7FIdZLOydsje7CXbr7I
        Ae6SeCPd4Lg+ghxm47DFzM3+xA==
X-Google-Smtp-Source: ADFU+vtU2B6nwFziiJDBl9BQ05KoFsPk7oHkeEWfg9BnU1sdLDW+4Hmsyy4Ve0AZoOIF5eZX7mrJGg==
X-Received: by 2002:ac8:7b2f:: with SMTP id l15mr12116784qtu.320.1584107584469;
        Fri, 13 Mar 2020 06:53:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x6sm9609039qke.43.2020.03.13.06.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:53:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkkJ-0006cr-Bd; Fri, 13 Mar 2020 10:53:03 -0300
Date:   Fri, 13 Mar 2020 10:53:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/11] Add Enhanced Connection Established
 (ECE)
Message-ID: <20200313135303.GA25305@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:14:27AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v1: Dropped field_avail patch in favor of mass conversion to use function
>      which already exists in the kernel code.
>  v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org
> 
> Enhanced Connection Established or ECE is new negotiation scheme
> introduced in IBTA v1.4 to exchange extra information about nodes
> capabilities and later negotiate them at the connection establishment
> phase.
> 
> The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
> to carry two fields, one new and another gained new functionality:
>  * VendorID is a new field that indicates that common subset of vendor
>    option bits are supported as indicated by that VendorID.
>  * AttributeModifier already exists, but overloaded to indicate which
>    vendor options are supported by this VendorID.
> 
> This is kernel part of such functionality which is responsible to get data
> from librdmacm and properly create and handle RDMA-CM messages.
> 
> Thanks
> 
> Leon Romanovsky (11):
>   RDMA/mlx4: Delete duplicated offsetofend implementation
>   RDMA/mlx5: Use offsetofend() instead of duplicated variant
>   RDMA/cm: Delete not implemented CM peer to peer communication

These ones applied to for-next

>   RDMA/efa: Use in-kernel offsetofend() to check field availability

This needs resending

>   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
>   RDMA/uapi: Add ECE definitions to UCMA
>   RDMA/ucma: Extend ucma_connect to receive ECE parameters
>   RDMA/ucma: Deliver ECE parameters through UCMA events
>   RDMA/cm: Send and receive ECE parameter over the wire
>   RDMA/cma: Connect ECE to rdma_accept
>   RDMA/cma: Provide ECE reject reason

These need userspace to not be RFC

Jason
