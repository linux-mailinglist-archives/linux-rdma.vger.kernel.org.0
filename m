Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629796DE18B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDKQx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDKQxU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 12:53:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A25241
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:53:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5140cca9dbbso723343a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1681231999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg4IHVJYm1jFUD6UI345qIdjmJzrQpPe8h8tbVM40Rs=;
        b=AbTJ0m9/Hhxao9/CnfkafPYQ/kl813XSGPjD+RPxhvztW6b8Mv0dSmQ22s+RgCMxVx
         guAnwh/yrYzqsA65NQkof9xPB/wn9p73zzclHNMhbHkf5fE3eCFOA1lndmpvEIATxauA
         BPOYvS648fZRmmhQNy1tafVPg6bITIY9lGHGP3omwEK7ERXUgB29AUMhPlxt/KtWyuzy
         t/sughUgpU4gssXNu3H8m3Da2ww+iFADSjRI2cdGOeJIfGNsx+OBT0N21tg7NBXfgMr9
         R0zCsgbWae7jK2VWMnAlc3CvIYLbc5p4Uva86dINh1HzG1HwCcQcd8guXy2/htEvo6Ki
         IsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg4IHVJYm1jFUD6UI345qIdjmJzrQpPe8h8tbVM40Rs=;
        b=0G/O0dUVVTEkpJHM0+FBWPztgSATGYrawPbKwcvwTCal/1Kh7li77HyWTY/jJlx7bN
         C9cxp1/liLvYtftHyFByXbd0LjEr7AiWuowxW0BhHTldg38sZzNDqci7C9t0nSJLObki
         /mOUE697XykwPf2l1AwFabkaH4SPeWsBwenokglg3UZ4Nd1f8T45qPM5IoXi0vJC3rrk
         T+ldby2C7FYgJtjavuTlzNOxCVy/eSjkS8QaahGBzIm+eQOvAWJmkFOi/zR4BowQFTEa
         U8JhF7pW0GzyqCHnhPcoTzu6toWl939phb6olizx60++DXNoB/aaKZx5HKFryAXrSois
         jFig==
X-Gm-Message-State: AAQBX9d3HFH1476syYpvx4+IVSoQyWybSJtx/ZOqc8/LvnKUEMR6L5l6
        izZ3+NLEyzG51zgasrr8X+82GQ==
X-Google-Smtp-Source: AKy350ZFCFspOgJYQSaYuuLeWC2AbVJj/2ZVwZKJ6pXjDsPDyWLxb3mC78rEixFvJmEulnXZRKSVIg==
X-Received: by 2002:aa7:9507:0:b0:632:34ef:7669 with SMTP id b7-20020aa79507000000b0063234ef7669mr3765415pfp.7.1681231999137;
        Tue, 11 Apr 2023 09:53:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b00637b0c719c5sm4250832pfn.201.2023.04.11.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:53:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pmHF7-009Pmw-D4;
        Tue, 11 Apr 2023 13:53:17 -0300
Date:   Tue, 11 Apr 2023 13:53:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 1/6] RDMA/bnxt_re: Use the common mmap helper
 functions
Message-ID: <ZDWQfWeTqfuvc3Dl@ziepe.ca>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-2-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:50AM -0700, Selvin Xavier wrote:
> -		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
> +		pd->pd_db_mmap = bnxt_re_mmap_entry_insert(ucntx, (u64)ucntx->dpi.umdbr,
> +							   BNXT_RE_MMAP_UC_DB, &resp.dbr);
> +
> +		if (!pd->pd_db_mmap) {
> +			ibdev_err(&rdev->ibdev,
> +				  "Failed to insert mmap entry\n");

No prints from drivers on failure paths. dbg at worst.

> +	switch (bnxt_entry->mmap_flag) {
> +	case BNXT_RE_MMAP_UC_DB:
> +		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
> +		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
> +					pgprot_noncached(vma->vm_page_prot),
> +				rdma_entry);
> +		if (ret)
> +			ibdev_err(&rdev->ibdev, "Failed to map shared page");
> +		break;
> +	case BNXT_RE_MMAP_SH_PAGE:
>  		pfn = virt_to_phys(uctx->shpg) >> PAGE_SHIFT;
>  		if (remap_pfn_range(vma, vma->vm_start,
>  				    pfn, PAGE_SIZE, vma->vm_page_prot)) {
>  			ibdev_err(&rdev->ibdev, "Failed to map shared page");
> -			return -EAGAIN;
> +			ret =  -EAGAIN;
>  		}
> +		break;

What is this? You can't enable disassociate support until all the mmap's
in the driver have been fixed.

Jason

