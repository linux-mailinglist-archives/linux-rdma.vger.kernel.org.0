Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E7BE4E7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfIYSp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 14:45:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37981 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfIYSp0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 14:45:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so6089117wmi.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPril4YgcRmPmooDyKH1wJLjnG5Kq7kOi9WRmhXR8jg=;
        b=sjr2CGKPTSYl32WCGCQRYmj/ZKEQdMLdm6lFdZmk9TaSUarz+/edJJ8iKOqbGra/CL
         0z401BrUFEzfbkIFGTeqolGgmlZ2WYXFK5Xr8VOreMly4LTKfx/y4cvBSUcz+CWzgLoX
         GsUzrxYF5OMfwodFA28I4iCmVjJ3VhgvAcnmGMIzT2QjzvhLaqW2+iMk2zIPr38jEGVo
         fbOBrNUmpp4h+NZM+E3imcjJmNzK3Fz9tlQlIriayYbRorswaM8/swrx32er3OAv+lH+
         q6Atq8hq5KyorWlLxndt9B4jivRfO7PZ1JsB8Kz4qCr/4LkMt3SIqBtDYwDf5i8wym1e
         afdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPril4YgcRmPmooDyKH1wJLjnG5Kq7kOi9WRmhXR8jg=;
        b=ZbWsz5ii9ba7Ux4PDIsprw45AllLcjc15xc0dpe7WF693YgC4s3nu94faKOEZzKCJ5
         4aJPAnBSMHrJNJI89QwpqbFGsI12IAamXPQpEbGZe9BiM/UdXheiPsQSOIrDMk1gpsgP
         41tGTwme7+KYHVgX8H96aOVC2wbpshPqLyadCxN69T5T9UPsOc3TWFr3N9CuhsL533or
         Ne5jkz+ig0euTc1KzJfVe55Lli4gnncBkxBmSa/VphpNAJXhbY+wI+/R3zZ9GDxPdSKa
         eSJNv71tcA4D13QzaGtdv9fXr9w5Y4OhPP4KWg8jXC8WkpSBOyS5zWUhXUrgyfYp5ndc
         x/xg==
X-Gm-Message-State: APjAAAXiI2B/dhzv5BwcuNAJHfOzyTYnR+Xo1tZZKmTaSHa7ldbUtFpk
        yUMuSc1ozhRI4Y0x+sVSgIA=
X-Google-Smtp-Source: APXvYqwVxMWw8wOm9ZrHTzJL4zyNZHgpo9BQ41XISMU12bzf9ylxBARPcQNsXrpZLFTuV7vuVVcMtg==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14mr9168336wmb.117.1569437124117;
        Wed, 25 Sep 2019 11:45:24 -0700 (PDT)
Received: from kheib-workstation (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id c10sm9857534wrf.58.2019.09.25.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:45:23 -0700 (PDT)
Date:   Wed, 25 Sep 2019 21:45:19 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, aelior@marvell.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt leak
 on ndev in_device in iwarp_query_port
Message-ID: <20190925184519.GA16328@kheib-workstation>
References: <20190925123332.10746-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925123332.10746-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 03:33:32PM +0300, Michal Kalderon wrote:
> If an iWARP driver is probed and removed while there are no ips
> set for the device, it will lead to a reference count leak on
> the inet device of the netdevice.
> 
> In addition, the netdevice was accessed after already calling
> netdev_put, which could lead to using the netdev after already
> freed.
> 
> Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---

Thanks!

Reviewed-by: Kamal Heib <kamalheib1@gmail.com>
