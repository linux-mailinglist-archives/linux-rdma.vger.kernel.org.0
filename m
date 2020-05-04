Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F431C41A3
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgEDRNT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730450AbgEDRNR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 13:13:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491FC061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 10:13:16 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e17so114381qtp.7
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeCp8Zrwfmf8a3z9DkYAyLqXwlT7p9atEj2RIaYLh7E=;
        b=ZgfyCK8kpnqFY19HbnATMIetrpoo6bWiym5loh3EhZy8JLDnOlCLIqcXvx7EvAYQDm
         SPtnyvHnwOced8TGzYf+csNgZrBwBqFM+jzW0WSQ/hXBpddb2VZO3D9zjmLnW8pXKFE3
         SsRW78F4Ee5sRHJrNTjgDZQMqoOEMotijHsI/z2sQErY4XEWMRON+cyRUFM8r7If1u/P
         uurDzr9gg1jkKjDnodz4lv3CuSzpD3ESks0dfIxBFlRzqykAr1ngCOcp0ZHp9YpDxRT/
         3Hf68G+V761KnBsu21Jsl8UFTGjOZIFpzFOzbSkjS8dGDvp8TMoDr5qmW2WMZ0siP1Nu
         J1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeCp8Zrwfmf8a3z9DkYAyLqXwlT7p9atEj2RIaYLh7E=;
        b=HMNyM0kWIynxs4pb93Omt1BQTxCnXxshjr30rgMVIbdfGmZJ30uIhXbuK9/+MiI74t
         ZrtjXQO+J39djtPEm/lz+aOXl/lImEoxcMCvdVD/hPuwgJVRr7Z0pWp0HKVkaCgfV3wZ
         hwmtiP3MLA0HG394LmzkvfXUlbugQ6E9UQy/nHuITJWRrB56hcFFcREWC5hEsuNvtGqr
         lyXIpDhCSkiXl/WAoz0QGU/7SxKc8D5yQFbk1+jErN4zaxavetKSOehpVF+QlDIs0+5J
         xblGlYguKV6Uf4XdTG5t1klzKGj7klGA4DEs5Oe39GUvriEAfvpWCDKGC4RkKkIWJSIy
         KCOw==
X-Gm-Message-State: AGi0PubJuTfUI4NPL07+gOLKszfxvbtp8iZ4Pa3yhGJMBwwfL4mpVbU2
        BJ+1HFXbtZVg2v5oJzJ8BpE/3Q==
X-Google-Smtp-Source: APiQypLIjJjdX1GmVO6teq5X9lLz/HEAwSfURzK2wl4KgpSM0nYVuB2nVQDYrZ913HBmcqSqDlmKDQ==
X-Received: by 2002:ac8:3279:: with SMTP id y54mr45560qta.375.1588612395993;
        Mon, 04 May 2020 10:13:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j92sm11082160qtd.58.2020.05.04.10.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 10:13:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVeeZ-0002nw-4p; Mon, 04 May 2020 14:13:15 -0300
Date:   Mon, 4 May 2020 14:13:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] i40iw: Fix error handling in i40iw_manage_arp_cache()
Message-ID: <20200504171315.GA10755@ziepe.ca>
References: <20200422092211.GA195357@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422092211.GA195357@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 22, 2020 at 12:22:11PM +0300, Dan Carpenter wrote:
> The i40iw_arp_table() function can return -EOVERFLOW if
> i40iw_alloc_resource() fails so we can't just test for "== -1".
> 
> Fixes: 4e9042e647ff ("i40iw: add hw and utils files")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
