Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C271ACFEB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgDPSr5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgDPSr4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 14:47:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512BC061A10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:47:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y19so2380399qvv.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=En8a9OfgFteW3m95ox2NXgQt0GaK2x1PYnYvAasaCWs=;
        b=MuXkSZQiiVR1PEk7+YTmlEUZCK3yGEHFaQqPh4S5joJgqa3VjvuC0DWIz6x4Rt9Ypd
         Cw4VLEhbCS4MbfQXPkvt0yAUibmK3z54SmoKM7bAR6xmm0Neyj6RvQTq3GqTrs6XRnXT
         HE+Ffi67KVZExUAm2dZQJemGW2fdTd2kzl8vPSz7QRcnaowoj5XVYuUj2cKUZ3AyowPa
         ie5A6Oksfy/1bByzcPxLjyDKCJHPOH6ihIPOsPN2ZNSJKvSRBgdv8SfjNXbGCPdk4pUB
         k15sY3dgRtQw23US1RIFflpCYm2SGEEeQa4VPqzr6Yb+3sm73/hDUESLbX04TYC8tXI3
         yK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=En8a9OfgFteW3m95ox2NXgQt0GaK2x1PYnYvAasaCWs=;
        b=Q/6GSZkaLgcUAnn50s+DyABL/e8FoFSTR5ZTZY1XsbU9UCS//G0U0vP6xfdZw8L/0x
         /B4VDfDK3qiJobpGiIJIPEIaSN7DQH2xXzlXMk090b4jWiDes1My//ouBC90JnzHxJC8
         uooPlowV5ap76BDLW5u4LvbcSGLs1R6bPs7CK49hf3jULN4t+l4fZyWv39+K72/C+gyM
         RvQJha9dA56LVQPkgORa/iTNAuT3mQ2rfXocUCe+EXT4v4K+tAadskP+Evwube8iCVBo
         o+w8aTaj3mKXejOM5x3X4MPoUm8A3j7GMbb+YblLdfdxr3eKF9PLGdJnlDqRxEktzPnl
         u/HA==
X-Gm-Message-State: AGi0PuY/W4qM1KsaZn9V9NYjfAnPGCLx2vsZKtdNNXlAhcAWcrL03i96
        W6sMi2/oqboJ/vhSyChn5/Udug==
X-Google-Smtp-Source: APiQypLvuE2d6rubB0KnxOEgCaaDxfB/k5+UjRfHvtWXX0MOWfVSGEEw7sQa8qPkBXmtVzJHhKKb5g==
X-Received: by 2002:a05:6214:17ce:: with SMTP id cu14mr11534107qvb.51.1587062875176;
        Thu, 16 Apr 2020 11:47:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h3sm1005577qkf.15.2020.04.16.11.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:47:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP9YI-0006rv-2e; Thu, 16 Apr 2020 15:47:54 -0300
Date:   Thu, 16 Apr 2020 15:47:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        roland@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200416184754.GZ5100@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416130847.GP1163@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > The memcpy is still kind of silly right? What about this:
> > 
> > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > {
> > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > 	int cpy_len;
> > 
> > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > 	if (cpy_len >= len || cpy_len < 0) {
> 
> The kernel version of snprintf() doesn't and will never return
> negatives.  It would cause a huge security headache if it started
> returning negatives.

Begs the question why it returns an int then :)

Thanks,
Jason
