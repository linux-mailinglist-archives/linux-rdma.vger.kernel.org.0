Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1EE6A2D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 00:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJ0XPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 19:15:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39975 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJ0XPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Oct 2019 19:15:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so11995125qta.7
        for <linux-rdma@vger.kernel.org>; Sun, 27 Oct 2019 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxZpFzuz60sIrSruV5Nd/Y3j5ItN6VqaItCAQPTMcIc=;
        b=Od2El8QyLa/H5hwR1OSJAf3wwqCt4YPdA06x5ONzTzr++XnoLDSgadVgdMez7X3dFP
         tdEahE8G7Opi2klzQQCY8N72Slkgu2gENIzdmOMZynjcyDNqNdUT7VdI1UwR1jjxB1Xx
         T5kaGcbHpgJX34PsmT9FXhQWl0cOm6OSOjnO2INOyBhh4k+H2PeDHKMzkEYr8e02iPey
         YGz9am7DB6flMKYfKUgbHUU3M+/EUsoohM3Agmo6YKNGHuF/JZtJCiGBrfONYvVWqEcM
         pP2icbaJd4446Zx+NzXtTTI04dmt7C92y1fYm+nKJmHTp9u3+ZW7AZUJngGk1C7eXHWd
         hdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxZpFzuz60sIrSruV5Nd/Y3j5ItN6VqaItCAQPTMcIc=;
        b=MsV0CatxGZBBnijuByKqbpmKELfeWPhqU9MyfywG7z+pu7c9aGesP99/DcDYHOVpaV
         JWlAufv26RCUqBTJ+qQp4ycI+bmgqMS2KyU/QalFmo9koICg5ZS6Ppn2ik4CHuGtI3j/
         7VxckYUWA1FjRnwPX3kTW/FXTCa5Vp6fgHixMW3oKRmSjMvGfJKJaBGNrFafjvtVE6nl
         DJ5fzg/pPEBvqXBk1oC55txzJ1gQztTvf/iTGwOwTa9x4OovQofTeg5uQOrfmySEewEI
         HKzPw5aayfEmJmSVATd8FSN1LM4HH49LyMRVRBr2W1n+AclRyiJbNiYj4wQ3LJ8u+Xto
         GV+Q==
X-Gm-Message-State: APjAAAVqECRx7DynB4enpKo9Yx8Plrpdgt4Q8qoqXut2JsUzHnW61+1p
        Pe1J64zvhKOmRCte53MOk1Lo2fdTifE=
X-Google-Smtp-Source: APXvYqxizxptV9dIppboKod3HPUerUoysc89bhjuseF5zgElGRhZk0mma/yLKAT2W01dKY3PL374/A==
X-Received: by 2002:aed:2907:: with SMTP id s7mr14732360qtd.265.1572218138170;
        Sun, 27 Oct 2019 16:15:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v3sm4707476qkd.78.2019.10.27.16.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2019 16:15:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iOrl3-0006cG-2G; Sun, 27 Oct 2019 20:15:37 -0300
Date:   Sun, 27 Oct 2019 20:15:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH hmm 02/15] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191027231537.GA25385@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015181242.8343-3-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:29PM -0300, Jason Gunthorpe wrote:

> +static void mn_itree_release(struct mmu_notifier_mm *mmn_mm,
> +			     struct mm_struct *mm)
> +{
> +	struct mmu_notifier_range range = {
> +		.flags = MMU_NOTIFIER_RANGE_BLOCKABLE,
> +		.event = MMU_NOTIFY_RELEASE,
> +		.mm = mm,
> +		.start = 0,
> +		.end = ULONG_MAX,
> +	};
> +	struct mmu_range_notifier *mrn;
> +	unsigned long cur_seq;
> +	bool ret;
> +
> +	for (mrn = mn_itree_inv_start_range(mmn_mm, &range, &cur_seq); mrn;
> +	     mrn = mn_itree_inv_next(mrn, &range)) {
> +		ret = mrn->ops->invalidate(mrn, &range);
> +		WARN_ON(ret);

This should be 
  WARN_ON(!ret)

Jason
