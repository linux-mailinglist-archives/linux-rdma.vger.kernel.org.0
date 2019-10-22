Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7CBE0C73
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfJVTUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:20:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40707 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbfJVTUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:20:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id y81so13489972qkb.7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2Qnqg3rfCV8RGxr5umHilHWYprJJ/Op5cxMtzbDAO4=;
        b=JkPlhiZB/j2PfdEQ/g+VroUulLPPgFeip6qgrSohy5h5MzyHT2bA8hwIeT5gVdHBRl
         XYwaDEWOzym1Psj41HMUQEWQ7RdAcICzYiX8wsbRg0aptJcgL9C2vIv1Cz2mYfjVNTpN
         vV/iUqqkJIgFfMsVdxDSdzFlohJlkrv3wNaD1qV/Pvree6yMf4ruf3eCGTCMOxn21RvB
         crVUy2zeeK7O/gdeCcYzxJoiR2+sIxlzZq3L3dHeD2PrYyUaykJIQJpcDwD1VJKrjG/r
         dh0zLuhsgGqIpfoBBQKc3/m4VaSngQOaW9MMmqICmyYou8rF6tMjSdhRGHiHFEfvZb27
         C+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2Qnqg3rfCV8RGxr5umHilHWYprJJ/Op5cxMtzbDAO4=;
        b=tuIg0M38DUAYWPJElPUHZYfrXBfH//KSMpGEGA1HNKGEU3z8EfD86CVbR0dsJuPO8k
         J2KCbGnbeLF37gDBwvTBzDgQMMXqOT3Mg0VcmNmrr2oekGYY0Lp4AY2PJ6K+2gdsSdPp
         zwQRbqzOW0rimFbVfshnG5oleCI9nmou1u0l8HorCaTzc1grGRhpmSUdNVwDfG9KteZF
         Euaa/+UbEwFM0rRyhdjc01YR8TLVgtPFPxC1bpOeWLNrPyLe2JBLKz1tZd6u7isMmmU4
         1hRwfzswlYWALBK7WaNAwA+Njv8JgQykFcSJQDOGoGnzbeV0LrMls1xL5ACVfs+8KWOd
         mFuw==
X-Gm-Message-State: APjAAAWF/Pn48bO2x92zakryhkuZS87ibptusFHV131viuwjon+5N20Z
        nk27xdjIuTZWCM6q1TFV0B75gw==
X-Google-Smtp-Source: APXvYqwzpPACtaDiAnRPTcMv/R0izUGHk4wMG8XCgH16sT2dMRTRHDnHkfWAcRNPd3A6IUGRJOpTcg==
X-Received: by 2002:a05:620a:2092:: with SMTP id e18mr4646556qka.222.1571772003591;
        Tue, 22 Oct 2019 12:20:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f144sm9799118qke.132.2019.10.22.12.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:20:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzhK-0002ud-Nc; Tue, 22 Oct 2019 16:20:02 -0300
Date:   Tue, 22 Oct 2019 16:20:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH for-next v3 1/4] RDMA/core: Fix return code when
 modify_port isn't supported
Message-ID: <20191022192002.GF23952@ziepe.ca>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
 <20191018094115.13167-2-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018094115.13167-2-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 18, 2019 at 12:41:12PM +0300, Kamal Heib wrote:
> Improving return code from ib_modify_port() by doing the following:
> 1- Use "-EOPNOTSUPP" instead "-ENOSYS" which is the proper return code.
> 2- Avoid confusion by return "-EOPNOTSUPP" when modify_port() isn't
>    supplied by the provider and the protocol is IB, otherwise return
>    success to avoid failure of the ib_modify_port() in CM layer.
> 
> Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>  drivers/infiniband/core/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index a667636f74bf..626ac18dd3a7 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
>  					     port_modify_mask,
>  					     port_modify);
>  	else
> -		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
> +		rc = rdma_protocol_ib(device, port_num) ? -EOPNOTSUPP : 0;
>  	return rc;

Oh gross, this is such an ugly hack

roce mode should allow a fake IB_PORT_CM_SUP to be manipulated and
nothing else.

All other cases should return EOPNOTSUPP as something has gone really
wrong

Jason
