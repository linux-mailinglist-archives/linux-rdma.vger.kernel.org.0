Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FB82B8474
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 20:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKRTKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 14:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRTKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 14:10:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A12C0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 11:10:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 199so2899213qkg.9
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCP+zxMV4+zjIbdfaM5WE70gjHVsYbcDuebcqDWkLuE=;
        b=VAVI+/BWtSqJ/l2O4ER0n+i211cmsdRpiwV4ZDCrHvHbsJ070ZzY604Rlu5geUiGKZ
         LATobfzoxqOO0+3Vj6nyJ8i48xAcmESKc03LemOPzVGUwpXB8NEdj+cCMaL3SMzYQhg+
         pdsV13CkpihmJA1ofn+8msMIMupU3nXCFBEku5MyG1aqI/2B8CpjuzehVJefVwDHBN7P
         4VoQWqCa8dY+nukduCfCa0aOZD63MYyrUCWUaC/S5gtd88CMjs6zbZNBxNsFMV44aPx7
         3rEvP1hfBPgm2S/nac1lwkROPBJMfbeRK6X+XY6w6SbLtGSKzSgUG+bbhbF1mv5DYKdj
         TDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCP+zxMV4+zjIbdfaM5WE70gjHVsYbcDuebcqDWkLuE=;
        b=dZCAJ7NZhrS3CBGk1HX6nl8do88wlE+dDrbt+l7oszF/9rouc9PHPDfhkxyeBwfLn9
         A8ww4g4H9v4uf9MHcOj3hpurZteusNHHEgCts+u8rDkiqUIkeGhVCOuKSh1BhU6gsF+U
         7M9u6hGoR5ADGUqIFvlzb0ahATNkFQoTBXhP5QaRPE91C/yLFLnVwwX+mjBjSjB1H5SN
         a5cvm0liLML/Gw3+plXXn6/KXHw3zrJEO8nPfgxiVzeoz+Qmky3JFe5Dlguat6HELjSp
         hy4cLGPuz4nPNJayZpW2MyNm7pW2NRv4HN3qRJHuWXhZMtNaFDhZn0SHPGcBLLoGInoO
         tX1g==
X-Gm-Message-State: AOAM533ZDpWZedhp7HdJwBYGbJTirPJw7f9tfCiZSV9EZQes8VDonsBd
        g7YUat1a2/x0QB4fvZsLQpDQuysjR8MJsHsg
X-Google-Smtp-Source: ABdhPJwMvWrrVGcinOJj3TUlZk5HISo4NP1r0/Neh5TMGrAZaI8F3TCeBEZ5cIh5Pi77qALWmu7YCQ==
X-Received: by 2002:a37:941:: with SMTP id 62mr6112961qkj.444.1605726653110;
        Wed, 18 Nov 2020 11:10:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n201sm17439375qka.32.2020.11.18.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:10:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kfSqx-007q7Z-Pb; Wed, 18 Nov 2020 15:10:51 -0400
Date:   Wed, 18 Nov 2020 15:10:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Message-ID: <20201118191051.GL244516@ziepe.ca>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <1605526408-6936-8-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605526408-6936-8-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 07:33:28PM +0800, Weihang Li wrote:
> @@ -503,7 +581,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>  	if (ret)
>  		return ret;
>  
> -	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
> +	if (wr->send_flags & IB_SEND_INLINE) {
> +		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
> +		if (ret)
> +			return ret;

Why are you implementing this in the kernel? No kernel ULP sets this
flag?

Jason
