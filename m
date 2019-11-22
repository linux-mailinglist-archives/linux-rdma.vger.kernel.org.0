Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD15107984
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 21:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKVUgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 15:36:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43918 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVUgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 15:36:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id q8so6651261qtr.10
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LCoGSWuKTjCv++vOYEaDnSn9jB2GEhV3V+wi/fZWa8=;
        b=adAWxdRZJLuFx89wDMkfKExymp7oX9VpH7EARLxtLZ9f3c7SBrfpiF5m8qj8UdbuK6
         kO9LGAEDlrNM9il0IPGWLwcfOdyy/IXqH+zAsfOu8Busyvr3iaUNCqb+z+2KqfH8bkPK
         Xa3GVgvEodQsw6l/P7C9UMteoBp7CdVoDhpz6Ps+FqlAr7MREhHZS2YVzZl9w7rgVIqL
         H1Zgiwpz70GrZmXM2tZzQtwljBTALP2rzFvPDvu1uwDnYWKAnHP3Qai5qAMxd+CvQBOw
         paY7BX9B+hHFpAvy5qhA2R74oZrtO1oom5lgSJ0clTtH1grTSPiARiZvhwOSN5mbmHip
         Cd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LCoGSWuKTjCv++vOYEaDnSn9jB2GEhV3V+wi/fZWa8=;
        b=DNWI+PqZJOW/n6MEtBx2q+IzcDw357VjME2X8iab6pCaOcs808fJ/GNhoIriC10SxZ
         SipiEPKu0K9icATsCfW7AmoYC3ArjGfZZjOgClo1gTZVKlFgadupzt86CtuI+ZpBBK0A
         y0ygq7GCNG1VjAsKAFCDjtr3b3ji6FDlsI9UsYrb5O4HcZspEA0TG/OMxK9xaqkLFxS6
         7J59SQ9t3eeJShMKJERiUXJjlotF74R0ofBMg8nLR/uWRKUX0IyW4CP+jKQyCMdjdH+u
         S9JLA6MvQHDy6nvi5Y9vpyb41FHLCHEG0KK5i2eNSXKQSef8g4TnNnJ0hbugC8HtVYhh
         0yUw==
X-Gm-Message-State: APjAAAXKZvhOkyRnaHXMvogx6YWlGNBVAwrEXJQuwjdy0BlYKm0+xo01
        angIC016ujQ7nwXaoUaHM2ETuBnLqi8=
X-Google-Smtp-Source: APXvYqw5r1Z+xpk4Pcef9z809unT9X4LUD+vPixWemBScZf8N8lxqOaIsMGGYC881SxKu7oIsdYw/g==
X-Received: by 2002:aed:22c1:: with SMTP id q1mr16677325qtc.337.1574454973915;
        Fri, 22 Nov 2019 12:36:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g11sm3514103qkm.82.2019.11.22.12.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:36:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFf2-00049C-RG; Fri, 22 Nov 2019 16:36:12 -0400
Date:   Fri, 22 Nov 2019 16:36:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next v2 0/3] EFA RDMA read support
Message-ID: <20191122203612.GA15904@ziepe.ca>
References: <20191121141509.59297-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121141509.59297-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 04:15:06PM +0200, Gal Pressman wrote:
> Hello all,
> 
> The following series introduces RDMA read support and capabilities
> reporting to the EFA driver.
> 
> RDMA read support, maximum transfer size and max SGEs per RDMA WR are
> now being reported to the userspace library through the query device
> verb.
> In addition, remote read access is supported by the register MR verb.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/613
> 
> Changelog -
> v1->v2: https://lore.kernel.org/linux-rdma/20191112091737.40204-1-galpress@amazon.com/
> * Use max_sge_rd field in ib_device_attr struct instead of duplicating
>   it in vendor specific ABI.
> 
> Thanks,
> Gal
> 
> Daniel Kranzdorf (2):
>   RDMA/efa: Support remote read access in MR registration
>   RDMA/efa: Expose RDMA read related attributes
> 
> Gal Pressman (1):
>   RDMA/efa: Store network attributes in device attributes

Applied to for-next, thanks

Jason
