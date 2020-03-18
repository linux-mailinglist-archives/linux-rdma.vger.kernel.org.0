Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A618A87D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCRWmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 18:42:16 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38888 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRWmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 18:42:16 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so13880605qva.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9iHa+tu6a/MNAJDPqq/FDffxsm6HpNPFdjt30XS0vQ=;
        b=YLBiKDTWRtbiIc83Lk7tMA+YIi4o8Wc1pRIjc6caQRCsBVPanuzojhJli67N3wN403
         GrfjLOoh1ctUVwoRQFfIBeKQcdDuY+rtKSmjaKQWcclP6FC3/EED/b5k1PCUIZgj+EQz
         oAVz4ENaHvcTGuPk5nUusq/QsdqXukwf85ZxdW8thkCcgbWWL20uW0c8rbXadKfDKvjS
         +5nu3LBAIfZRtaMw/uvdsixaRsIHi/Jq8XiubZJQdc2StWQ92OTepv5pPFlXiMMLPTsu
         KFqygMgGWv0+5gQj8kQp62egMksPohKuUwX6cN6pevlIxJIw1Gr0MsXk/Dv2wHdK8xSP
         9EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9iHa+tu6a/MNAJDPqq/FDffxsm6HpNPFdjt30XS0vQ=;
        b=RJ51QpVPJbrVnKL/jW0WeZHFsW2NoeOhuL5u9/kSyGUnYFAiF11Se6NmsKDQUgrWSY
         XVpdzOPAS8esUVMuhXLCFUJnhbQqpQBb8OCwPPU8zkRzwS+YXpyUsA9qB9UI6610n0Yo
         douyjOOFZbZ0tCaBgMhK8LZAvuT4X/BXSwJCDrc8BTT5/CeGip/taKjJUvZEunXWD4aC
         tS0f3r4a4I+CzYt6RIifwIdN2Nein+bL96EMrie7nukQ7k3nC4iheAhFhjfUXGGmKWF4
         mdpcvTjHtoIjH8HjQuLqHm+SXXpFYx6v9FQEZqdasMg1bPr88wygsKBHuu4nur6TYgrI
         GtGg==
X-Gm-Message-State: ANhLgQ0adR2HQQWliVgSGFdBSimRlwuroYgPzHTSKoi6XCAHovzjAmyF
        Q9F+kJUj03nKlbnvshtHosVbaw==
X-Google-Smtp-Source: ADFU+vtk4xhCdLt04XU+ab12jpw3TVS4FkzGYHVQYGJ7YaFy8kew5PkZNk6Zct4lIWrhMl8dgCSRgQ==
X-Received: by 2002:ad4:57b3:: with SMTP id g19mr214773qvx.87.1584571335840;
        Wed, 18 Mar 2020 15:42:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u77sm249058qka.134.2020.03.18.15.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 15:42:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEhOA-0000I0-V2; Wed, 18 Mar 2020 19:42:14 -0300
Date:   Wed, 18 Mar 2020 19:42:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RESEND v4 for-next] RDMA/hns: Check if depth of qp is 0
 before configure
Message-ID: <20200318224214.GA1066@ziepe.ca>
References: <1584006624-11846-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584006624-11846-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 05:50:24PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Depth of qp shouldn't be allowed to be set to zero, after ensuring that,
> subsequent process can be simplified. And when qp is changed from reset to
> reset, the capability of minimum qp depth was used to identify hardware of
> hip06, it should be changed into a more readable form.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> This patch is named "RDMA/hns: Support to set mininum depth of qp to 0"
> before v3, and previous discussions can be found at:
> https://patchwork.kernel.org/patch/11415067/
> 
> Changes since v3:
> - Remove a "Reviewed-by" tag that hasn't been authorized.
> 
> Changes since v2:
> - Update this patch's name and description according to the modification of
>   code.
> 
> Changes since v1:
> - Fix comments from Leon about calculation of max_cnt, check for qp's depth
>   and modification of the prints.
> - Optimize logic of codes to make them more readable.
> - Replace dev_err() with ibdev_err().
> 
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 77 ++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)

Applied to for-next, thanks

Jason
