Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05B3FCA5C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKNP4z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:56:55 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38080 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNP4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 10:56:55 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so2528215qvs.5
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=651gNZrWD0bGz7Wy3cIfe2XA678Er3DCQbFeB48W83w=;
        b=la2CqbWwmowRFJ5rCSoABUbb3VQt0++Vh1xLgU/2Qy/h+/yu7dHCI8CLTxiqlryMKq
         vZuQWxYjlKuQ93nJtDZeY5oP+0KWXJtCw2LDOHUlB3iUFOoo/KyvLUYXUe/lnW/f+FBJ
         /QwP7FC0Th82ey+QjruYZhCxv0qONfXgCs4+udstmZQliIGWejkcMTHA4hgoiO+DpRTL
         nMaMZFlLbHcysH1CMOh4MInfIhYNDUvdKsezZ0eDyC4nSuV1D1HmTsB5xXb0e0pIRKRx
         AM4bpxXw9RRXh6fSoYRCB29l8lK2DjNIpIVNByDjjdyra3PWIb5R7/dRgjFUFpXCo9Ys
         Jt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=651gNZrWD0bGz7Wy3cIfe2XA678Er3DCQbFeB48W83w=;
        b=keTytHzzMZEMfLFGAGXakDiRQjyba9bDXal2Rkn/8tgyqEAM3eD1NiT9uHZpeUA/C8
         m1JAXbaaw1YJ7MSYXck678BbiNc+hmag+niwkznYHx6pUyPgX5v5e9psaQr9aoLyzOn/
         3SD2+obaLrjYYixoF9EaHxFoAIM/SoD/MBpPMobfVozEjkW2fC+k7YJc6+SRQsSqXbb+
         FA45Hz3j40X1BlCb6doSzo0HO+yxRuj942knuAwozvtDx8rlmTjFvdEarHBn0KegEiyT
         W0pq1OIv4tnmWcaRfCLBwph5yvAxXTmWr42RH0Xm8Tt0Ru1+Z+rKUGrWPNYuNxRe+DHl
         JAVA==
X-Gm-Message-State: APjAAAUTnu/mrtMZnyhjqYOpJV20HVi0HP104S7CyozX2FRQXgJvY7DI
        tjSjsWgFYGvig3uT6rcgz55kUg==
X-Google-Smtp-Source: APXvYqxc2CZofxYfLrcaw65U5A2q6uXVI50mvYwMIm19CexHufTHL6b+VsWVTsTPjz+ocO8Tu0Jmlw==
X-Received: by 2002:a0c:e74a:: with SMTP id g10mr8679004qvn.29.1573747014097;
        Thu, 14 Nov 2019 07:56:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b134sm2747467qkc.96.2019.11.14.07.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:56:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHUL-0001Ah-93; Thu, 14 Nov 2019 11:56:53 -0400
Date:   Thu, 14 Nov 2019 11:56:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Make qedr_iw_load_qp() static
Message-ID: <20191114155653.GB4323@ziepe.ca>
References: <20191110113645.20058-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191110113645.20058-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 10, 2019 at 01:36:45PM +0200, Kamal Heib wrote:
> The function qedr_iw_load_qp() is only used in qedr_iw_cm.c
> 
> Fixes: 82af6d19d8d9 ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
