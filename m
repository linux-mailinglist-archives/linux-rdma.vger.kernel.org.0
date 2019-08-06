Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAD283548
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfHFPbH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:31:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37109 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFPbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 11:31:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so84960187qto.4
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9WHdS9yHlilQK32DStRp6jKyDuD2tZ6VXu29/s10hGY=;
        b=TmFjfuM6/ZhBtB3neURRStFEcbUHpl7o3WAV+pMG9wMMa5hTYlaKjQ2LYYhKZnSV4I
         JcfmfRtMzUBLciAlCm9NZdjzthCfkpTOcNSQad/5Zmp3VqbPhehrUTyQnroBvR7ObG9G
         ycDCYhY53vEqgk37RLDqNSa+/yUoxJqkb4aG5MENhN0sdptkhbqPvRqz4kTN1rdHOayd
         MquxPfuxxhga2VQC+8AenSQ4Yxs0dGA3qMXAcVB6pU+fCIsuZw+YIIZVxq0QwcUJdiMd
         W2h3dX6bOQNDF0MC9R2HgWStaT6H48HuUJnVPfRQpJG6/oNc1WhjHN/PJSUR5CNsJjGg
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9WHdS9yHlilQK32DStRp6jKyDuD2tZ6VXu29/s10hGY=;
        b=Z/LtF2CFHLHyLslLedKkZ8Mkp28lbTqkmWcuPir0876PFxKbN3t5kdwr3DQrTBqdNd
         zPWSNDJO2XzSJuYBZ56sPwoTw0MvBKaO6LPuxgfQFAbOxg8aZEyhbLjpxc8Gz3ubCj8D
         gPSrVvHPMqS3BS2kLFs+dz/2yKeQP15k4cWbE+sFCT0QYJCcxO46V12Xeuq5IvCRcSVL
         c/5wPBskxbCUCg8WilBHUsFddK93reWOqpUOHUso/S+LVyV3AL0fjnJVXfQCFOQHxdya
         WR/+9dpXW76dIke2H7euB3nIpH9wBK7eCuNt4v1nW/dNkudhRyq9YG+rnn80qjo810AC
         d4CA==
X-Gm-Message-State: APjAAAX4oh5Gr/gAPgGngDruebR6ZL20utqHUZFpWt92Nr2OMhEtQqzV
        rHZhNkyBsF1xGTFyS51Fhqj+zZTbtx0=
X-Google-Smtp-Source: APXvYqwpLfvK9Q+hOB/OJH/p0mSsQ9SUuWFhePm8gPvH1p0dnZGmZQe6jQ09GMwUtuE6s7mVVsMsPg==
X-Received: by 2002:ac8:45d0:: with SMTP id e16mr3493992qto.337.1565105466551;
        Tue, 06 Aug 2019 08:31:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x10sm34419234qtc.34.2019.08.06.08.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 08:31:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv1QX-0006dc-Hn; Tue, 06 Aug 2019 12:31:05 -0300
Date:   Tue, 6 Aug 2019 12:31:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit
 size to remove 64 bit architecture dependency of siw.
Message-ID: <20190806153105.GG11627@ziepe.ca>
References: <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 02:53:49PM +0000, Bernard Metzler wrote:

> >> index 7de68f1dc707..af735f55b291 100644
> >> +++ b/include/uapi/rdma/siw-abi.h
> >> @@ -180,6 +180,7 @@ struct siw_cqe {
> >>   * to control CQ arming.
> >>   */
> >>  struct siw_cq_ctrl {
> >> -	__aligned_u64 notify;
> >> +	__u32 flags;
> >> +	__u32 pad;
> >
> >The commit message needs to explain why this is compatible with
> >existing user space, if it is even is safe..
> >
> Old libsiw would remain compatible with the new layout, since it
> simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a 64bit
> 'notify', ending with reading the same bits.

Even on big endian?

Jason
