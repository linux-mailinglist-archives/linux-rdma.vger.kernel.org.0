Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AC11A7B87
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502379AbgDNM4u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502372AbgDNM4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 08:56:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B5C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 05:56:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s63so8832854qke.4
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tB72+XXLm2yUjrWAv44G5JTZV0a6ONe5aJ0Qlk1TmqQ=;
        b=W0UG0g8fS3NZFlKAI6xueuOnXDs2fFIA5QiM0ri/P2agC1FV4K7iQq3pX3kYrQfGhQ
         AwZiWTR5gcgUK/8SfgVLN1oAIyspOoYcv7N4FelTfkpgVXLkI+e4f917wExkcespYqvc
         CA0MRt7f7MwbwiugB6OYO0UJpEP4GWuUMmUmXphHG1ofvN5vwsJDpS2Wi+8CdNqKEcwS
         KPtS8VJt010PVp1PI4kElNJvkW+nM5ICbLggbv08OXSSE06jelVa7QKJ8G0iR5TYOIOO
         j1o2EzHot3h+g6hctJXhPBiyLh30rOWf1J9kBNZCNc/jVAcmb/SRmNCfQcio4EorJiIN
         +taQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tB72+XXLm2yUjrWAv44G5JTZV0a6ONe5aJ0Qlk1TmqQ=;
        b=Zl+TmlwgDbS3xchSdVkYw+JHN5hmqiOR3DStouPyEgeXpiIXSiRihA79DIF+SDItTK
         bJZCG4PEHqLZKI4W/uMvDB28+BpCyZQkzWJEA7L5mR+uXTWkopfuKJ5F5AZQyJBm7B/E
         aJRHJdL4bG41UuzmtM30dbljEj3iKavEknfsRQarw3CeWHjFrSXxAEmSYY65BdNJvmty
         PI+5W3pmVZwGjUDPM2U1/j9g7uYElZMug8/oMfG6vcZZnTiLUnHgGjcPQKx9dOfqSwyf
         YsYkgWUHsFzpcACuB/5OIWP24nw8onDzZXHSTssbvG+HWl93Ph49sDL96BAWI0/Wn2wf
         fc9A==
X-Gm-Message-State: AGi0PubUAIjHAiTYGJjhZdpnJYa1riVYjISRp9qBw9eLZ4Oat1Esipxy
        XGBJS/aKyzrwFImPZzEMbNW+aQ==
X-Google-Smtp-Source: APiQypKt9s9ie3OACO2HQ7rOEpVzVMud2ucheqX9shj6g0gTzvFzCE/DYgKk57i3z703M3G0jKXnXQ==
X-Received: by 2002:ae9:dfc2:: with SMTP id t185mr21241622qkf.20.1586869006819;
        Tue, 14 Apr 2020 05:56:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p1sm10523046qkf.73.2020.04.14.05.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 05:56:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOL7N-0004JF-TM; Tue, 14 Apr 2020 09:56:45 -0300
Date:   Tue, 14 Apr 2020 09:56:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Simplify the cqe code of poll cq
Message-ID: <20200414125645.GC5100@ziepe.ca>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
 <1586760042-40516-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586760042-40516-5-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 02:40:40PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Encapsulate codes to get status of cqe into a function and use map table
> instead of switch-case to reduce cyclomatic complexity of
> hns_roce_v2_poll_one().
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 130 +++++++++++++----------------
>  1 file changed, 57 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index e938bd8..c2d2c9e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2954,6 +2954,61 @@ static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
>  	return npolled;
>  }
>  
> +static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
> +			   struct hns_roce_v2_cqe *cqe, struct ib_wc *wc)
> +{
> +	static struct {
> +		u32 cqe_status;
> +		enum ib_wc_status wc_status;
> +	} map[] = {

Also should be const

Jason
