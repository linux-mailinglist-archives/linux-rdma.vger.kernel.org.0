Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020AF19572E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 13:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0Mhg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 08:37:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37463 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0Mhg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 08:37:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so7097349qtu.4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0T029vJ/SUKWVLqY5K375bXlsPrFCmutIbwoNf3r04=;
        b=oCpcelUz7XOBRDyNznFY5WGjoY5SCtER9oe+OfVaRKYN9qj0iumwPTrE+PbhoQ9PHQ
         3zE24+26lwsYSgiRc5YG5/mfJQ8ArXFhuTFAmshazuL2chytgPOeAeiQPGvkvSHT/P71
         iGBaqMOjY73JnZMvbwDCQAftyEkflj0zONxYZthlswBsVrMMT53aqD5Etucfvd1Dq6Ov
         YIcJ0tYPKFvgBfno9v2rJDi5otcl2p2L9072M4ntF02eyJe/a9dRlufVCeWYU6XsEpT9
         23+rEeeh4smAwU1RulY9/4fpJd0kvX5U/7r6LgOS8tg20ehT6tHmnM6A0NicEMv35ouZ
         Heyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0T029vJ/SUKWVLqY5K375bXlsPrFCmutIbwoNf3r04=;
        b=GSTwVdaXETHDfebbkpbHjGeKZqz+83xSqC+/74gbkLUnBx2tpqnkp9Kmt3lS0yoLT+
         VBKd4fWXjvRnxV/1e5z9s0+DLnb02naPCw6j7zXBocMbHGMqMPdvYT3Z0/3oeLMRLcPt
         K1mbjcSP695oFpv86m8CAq+yLFtMTkaKU3UdDJiceZqG2oM1YPlijfjrTPZOy1qZK9ac
         05tJcwLN2wPuEbMb3vkVtzHKObpSd3949db4BVFx9b968hzd/GwwBEx3VJ7cEPilscJ8
         jsLst1iYk38f4K989FA1sPhSMeoZ6JoAbpxiBZrllnSUMpbMcFtUsPCgZqwF9fm2ULAE
         gA6Q==
X-Gm-Message-State: ANhLgQ0BXtQitDJ9a1+s7jxNXh4LiRiz2/Cx3vjCfM8C35TLkEdm9Ec2
        WYFXVvtRcJrsql+rwIbaYTBMLw==
X-Google-Smtp-Source: ADFU+vvg/5Mz6Rtlw0jUYi0ok1G/kUbyLTgZyhnRG24xJXVp7l2O//zv2kphfg95avK5XpNgtlSAyQ==
X-Received: by 2002:aed:2da7:: with SMTP id i36mr3780921qtd.84.1585312655204;
        Fri, 27 Mar 2020 05:37:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r29sm3588067qkk.85.2020.03.27.05.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 05:37:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHoEv-0007qx-R1; Fri, 27 Mar 2020 09:37:33 -0300
Date:   Fri, 27 Mar 2020 09:37:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1 6/7] RDMA/cm: Set flow label of recv_wc
 based on primary flow label
Message-ID: <20200327123733.GA6821@ziepe.ca>
References: <20200322093031.918447-1-leon@kernel.org>
 <20200322093031.918447-7-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322093031.918447-7-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 22, 2020 at 11:30:30AM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> In the request handler of the response side, Set flow label of the
> recv_wc if it is not net. It will be used for all messages sent
> by the responder.
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index bbbfa77dbce7..4ab2f71da522 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -2039,6 +2039,7 @@ static int cm_req_handler(struct cm_work *work)
>  	struct cm_req_msg *req_msg;
>  	const struct ib_global_route *grh;
>  	const struct ib_gid_attr *gid_attr;
> +	struct ib_grh *ibgrh;
>  	int ret;
> 
>  	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
> @@ -2048,6 +2049,12 @@ static int cm_req_handler(struct cm_work *work)
>  	if (IS_ERR(cm_id_priv))
>  		return PTR_ERR(cm_id_priv);
> 
> +	ibgrh = work->mad_recv_wc->recv_buf.grh;
> +	if (!(be32_to_cpu(ibgrh->version_tclass_flow) & IB_GRH_FLOWLABEL_MASK))
> +		ibgrh->version_tclass_flow |=
> +			cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL,
> +					    req_msg));

This doesn't seem right.

Up until the path is established the response should follow the
reversible GMP rules and the flow_label should come out of the
request's GRH.

Once we established the return data path and the GMP's switch to using
the datapath, the flowlabel should be set in something like
cm_format_paths_from_req()

If you want to switch to using the return data path for REP replies
earlier then it should be done completely and not only the flow
label. But somehow I suspect we cannot as this could fail too.

Jason
