Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54BFC874
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNOKz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 09:10:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45355 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKNOKz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 09:10:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id 30so6861493qtz.12
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pO5UL8JHLBSta04+vYyLL3xmgTqAemyGftmYjhzcWx0=;
        b=kBVBaSBy5Yiw4+pqToR8uak9+U3oDmHOSKF5lk/drpE/T0e8lEL8XaWnAQuHh5KJ1E
         rrdpVng8YCpFlD4VjxnW7DrERYwuwBaS74GZbPYwEYZiK3asDANe9PAtsG4zizABlM9b
         wCaJhzqI4ikgRMlW+ld/ah3xXCGPNE9iLrnN0t3dAi2DK8gC+b1dSoq5jayOWJDXU2gi
         OXklcw+vjmgrq3mDRBogB20JCDcwCrnMS0E1FVeP/D+AQX3Eit9xOd98JCvQtgZpd2LL
         vFfPUt0rYXDmvUd0a6PJbG2VuNA9UyYu86sob4LNrfgEGulzNFpU/kwYk+gglMEcvUNO
         v2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pO5UL8JHLBSta04+vYyLL3xmgTqAemyGftmYjhzcWx0=;
        b=Flk6lys/wCDpHnj8xxq7B9a9j8acfsFwwmwacwxzaG4n/q4M2blMD1FjbQh9k0NQuX
         2cvPS6+XK0Fwx+lY3Csq5ZuwZu1NC1OO3ijIrUUaP/sNI0loS+pcV3ejEPDnyKVSTPDE
         PpSo6QvzwatXaEspZOWfWGIY2t4Msc43tC+Q0K19s/TtfI8EGyco7Ytk40lXNoRTLEsE
         e++hC/lVXEdnEU8jSSpY/RmWJLuSf0/YcUZ3lmQx/cnCYs+sWi/oVA6aNIk4/CN8wQTF
         wneRBNHO+yeNqywN7rhwD99lEkodw0rpnj02hPrPW1fLFftb803z40nEX1FFiqaXlawL
         39MQ==
X-Gm-Message-State: APjAAAU6KS+ffwKSCf9g/QOKZPtmHG0ha56mpwYjJtZ7cJ9UZcOdFrBq
        /sKkRH78I8gpvmVoLlYU5IKSTQ==
X-Google-Smtp-Source: APXvYqx1k5jk0ga4ebGjAlp3fJeHn5+JHDmFUNHBl/hcKPnl8HTjJQkooKQ3ZovQ1ohSFxxIX39ZDQ==
X-Received: by 2002:aed:3467:: with SMTP id w94mr8470895qtd.166.1573740653989;
        Thu, 14 Nov 2019 06:10:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o28sm3360783qtk.4.2019.11.14.06.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 06:10:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVFpk-0002PJ-KI; Thu, 14 Nov 2019 10:10:52 -0400
Date:   Thu, 14 Nov 2019 10:10:52 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] RDMA/srpt: Report the SCSI residual to the initiator
Message-ID: <20191114141052.GA9219@ziepe.ca>
References: <20191105214632.183302-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105214632.183302-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 01:46:32PM -0800, Bart Van Assche wrote:
> The code added by this patch is similar to the code that already exists
> in ibmvscsis_determine_resid(). This patch has been tested by running
> the following command:
> 
> strace sg_raw -r 1k /dev/sdb 12 00 00 00 60 00 -o inquiry.bin |&
>     grep resid=
> 
> Cc: Honggang LI <honli@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Honggang Li <honli@redhat.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied to for-next, thanks

Jason
