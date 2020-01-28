Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED41E14C14E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 20:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgA1T4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 14:56:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34310 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1T4p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 14:56:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id h12so11300857qtu.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2020 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UaRn1Gi2K33QkL+Lbb8msdZCgNra8/sHUkSDcAVrDgw=;
        b=WGMDLnbybSCvH1ZbUsZ2CDQDrev7cn1iPAsq68I/XHmt4ubtDJ4LKmfCMvCHjgDJvi
         6D5LUIQo6NsvVEq5NSBUouA0RF1hnlbDhOEjnOkLbDNA99Dd5aFxN95sQ9nC/fhh1a3m
         QiGbECyzurTxDcfg6iI5Iz3r5VOyGtslp3nAOnQx0Qg0G6ioQrJpk92zEim0kR+le4ig
         /gM6x1dvIvCzLPhpObuMJvwUAHgt2qqgs5ESwEPPpqZE2/jB/fNHRDdJWpYsQaD/Qx2x
         Mf0mw6ORMWH0P+bvcdmXb+IGdm+9b5VjtjLiEzo+Q0cpmV7g2hp68ceowLyi5zsp2/N/
         v/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaRn1Gi2K33QkL+Lbb8msdZCgNra8/sHUkSDcAVrDgw=;
        b=qtzhu7C1NYtM34tbaQyujM9vGEto8yuHJADYVMR1W4QSjwiYZeEgf+OdWHI3YwL5Ev
         ylhu+S2s3Q0RRglluaow3IW+pim6i8Rgni6LNIEfDT/yr9ORaSCsg3dQnzkoVMdYD4yl
         6eqoscnBU0W3fcw3X1Zhuvmz8IDmEL705zMLaXUwtXZCtM/9oZiCHklAviPpO5jLTVMQ
         YQLi7CNRRVhNlmHWKNe+lDSNonu63Dix4DhynJE7tHkRayZ2X8/iHfNU0AKyWrxe/s1m
         egm1+DWU/HNlyTM5zztfBB0270P89hms66nteWgqIUrXvOyh0zlA72Epg+XbdlYZRYr9
         QPfQ==
X-Gm-Message-State: APjAAAVTbotOsB3p9WpsqmG9QTa6f/R9qTV8m/nyDs9oEhUk1uX3wlPR
        JOMQ7rl9tZsTaeX4DDiNFLKwMA==
X-Google-Smtp-Source: APXvYqyJvGvljHcHEpfwCbeNR3UvYDXNtiFYIqzcrqm8Xj0Zbwi6LD7jLAhJ0zjM8n4MxZguKs0ycw==
X-Received: by 2002:aed:2a32:: with SMTP id c47mr22603557qtd.289.1580241404114;
        Tue, 28 Jan 2020 11:56:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f5sm12753812qke.109.2020.01.28.11.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 11:56:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwWyZ-0005xA-0h; Tue, 28 Jan 2020 15:56:43 -0400
Date:   Tue, 28 Jan 2020 15:56:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
Message-ID: <20200128195643.GA8107@ziepe.ca>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
> -			if (ret) {
> -				spin_unlock_irqrestore(&qp->sq.lock, flags);
> -				*bad_wr = wr;
> -				return ret;
> +			if (atomic_read(&qp->flush_cnt) == 0) {
> +				atomic_set(&qp->flush_cnt, 1);
> +				init_flush_work(hr_dev, qp);
> +			} else {
> +				atomic_inc(&qp->flush_cnt);
>  			}

Surely this should be written using atomic_add_return ??

Jason
