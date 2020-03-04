Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FAF1798C3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 20:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDTS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 14:18:27 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34382 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDTS1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 14:18:27 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1315401qvf.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 11:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h8rLEH1NioflLpmaStS7ciRXkkf+whoI0iQDAoY3wPY=;
        b=VOQxYSDkYHQhW61+LDqVs+a63aD0Kz0Pr+d/IuSWMwBmBgf1mpTUwFY1DRtIKVfoD/
         MfYu79x7Rx6NgbZv6AmETTz2+88LrJGVwWU+Cawk76m8g47cL6dpKgBhaHy50LwuNOlq
         pHWOIah+wlUra2U0y/wwDr/iT8wirbdIke2TiZZvrxh+17rJErmTKmMLlzGK2es85m40
         yiMgKFIdaWP540NV+ljVyffhs+IuShSrtJyqNlRwIX7VGRUK/BJP05Bn8IFEaOFDQV6Z
         Y7LRggeZ6zeYsttEdur26cbpuV3MWO/uuIj5U4VwXEWadrhspTInMH22Q/79U2hgZlNq
         eu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h8rLEH1NioflLpmaStS7ciRXkkf+whoI0iQDAoY3wPY=;
        b=kpUAV2PqSN0uIqYH7bpNWnLB+LG2TTK+J9LjK4UNSgdQNCNKkPZNLIiFupybDPGsj5
         WEw84Ep/5NL78EUOfHnG/kmEFpMVeu/lKPeIhqnslo5ierVRohWxaWU4Vzq5PT38VIiq
         tDVgDTN1bf0Wz5CGIbSbUHxFwrDGcBF/3i4b99cBxJ7RTOsKQUWNFQwa+3meT2Qg5NLX
         RYmKIwnfzfPLqC/7549NQuAZb/UNR0bW/CHdImeUj4mAoW5grqV3/B83YT7l/n7Fb2F/
         ayC6dfKIkuUNLy+NvwK0i83rsN1H7SlXeT96wpMrpzNp7AuP+mjtMgk/usjnmOXpWMZY
         thEA==
X-Gm-Message-State: ANhLgQ21JwLIK7MKgdshbl5IcME1EXUkNj2mpxwmfxPhAtMJVf1hV+O9
        bjPF0C55Tjdf+0y5jYNNdjfzXA==
X-Google-Smtp-Source: ADFU+vuRB3spBzQbN/udkosbiuFaudaZ6mrVQI2VvPzmKVTOLESFgxsK5eGZzEk6KDnkbqlYa/p3xQ==
X-Received: by 2002:a05:6214:294:: with SMTP id l20mr3466752qvv.28.1583349504609;
        Wed, 04 Mar 2020 11:18:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d185sm14886029qkf.46.2020.03.04.11.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 11:18:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9ZXD-00042I-9k; Wed, 04 Mar 2020 15:18:23 -0400
Date:   Wed, 4 Mar 2020 15:18:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Message-ID: <20200304191823.GA15415@ziepe.ca>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583151093-30402-5-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 08:11:32PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Currently, before the qp is created, a page size needs to be calculated for
> the base address table to store all base addresses in the mtr. As a result,
> the parameter configuration of the mtr is complex. So integrate the process
> of calculating the base table page size into the hem related interface to
> simplify the process of using mtr.

This patch doesn't apply, and somehow it didn't get linked to the
series in patchworks too. Looks like this patch was replaced somehow
as it references the wrong In-Reply-To

Please be more careful that things go into patchworks properly and
resend this series so it applies

Jason
