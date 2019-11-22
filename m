Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1A107962
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKVUVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 15:21:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44977 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKVUVd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 15:21:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so7393362qki.11
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 12:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJNST5spgJ+9+0zEr716mDrZrSEXVq6warPi8NwZbrs=;
        b=JhjAtp9Hhcee9dePtJRpLRpEX/HZaH15EcThHJwgzedX9w3iqvQW1XlNZs9lmKnMB5
         YHYRCtAhRXlYs+eaY/ppkhvKUDTXiE8JMKdVfpRw1/pEP9gch35FrKHITd/Z2d10XqkZ
         lmRigj1GfsO+Njc212aBszSd9MJNmFB0E+XQwbOHM4YwkVTBK29vpHgqJOqrwDdBQtsp
         6mwjwjiQtOiT5cPg8djKRQscdB1JKUiC/ubhBGKQfx34lMK/UVG1paKgZzCpk6izxgnX
         ikNa4k+s/6pQodVJh3YK88nJk3YSVSr2RkrK7ws34RT+Sl3hMBC8ARskMN9jFT1LEudO
         ma5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJNST5spgJ+9+0zEr716mDrZrSEXVq6warPi8NwZbrs=;
        b=LUzBUHtC2iXiOXlTrSXWdrDMrx6zN4YBKNdwLt974BuBfubCa5J8H4DGeRikvFlryV
         NZTO24gtLmVPBs/MsmfBdJQ/+feYl3ixkJxCln+UgnzjQX/ncZ4t71T0z1rHOd0ti87P
         SKp9ZTuXsONC1ZujC4JSbXWL7jFhwVvsr5Ag7z+zHxspJO56JIo//v8GjsTPuAqqgRQl
         iocAzs8uoPYwnVsN7uEM/j5LsMFuhG4OQpqxanyhbgS6iepLjzh5fgamVjHCftPBAXyZ
         Hoi1K/m6H8k1zuRsWN+aFOGpYC0MiDC4ksuWyO95LftNaG7MTlvAkKhwmQoJVxHpHM3l
         lMtQ==
X-Gm-Message-State: APjAAAWWjHCE89ehWypi3QR65mpAgkI+mDbzKB5k9TNiILDCg2J4fzJN
        mgVKhbM+XW0vJD/6xsuZjMjSPg==
X-Google-Smtp-Source: APXvYqxrPOvst0p298a7SIdNeCNXyIrt9qTv1oLj3gIr0rfw32Pl2OLk5QHxmI1OaJ4/l7n/eDJ7vg==
X-Received: by 2002:a37:7dc2:: with SMTP id y185mr4828809qkc.380.1574454092120;
        Fri, 22 Nov 2019 12:21:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h37sm4083006qth.78.2019.11.22.12.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:21:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFQm-0000J6-Do; Fri, 22 Nov 2019 16:21:28 -0400
Date:   Fri, 22 Nov 2019 16:21:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband: Fix Kconfig indentation
Message-ID: <20191122202128.GA905@ziepe.ca>
References: <20191120134138.15245-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120134138.15245-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 09:41:38PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/infiniband/hw/bnxt_re/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
