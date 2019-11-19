Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C82102C8E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKST3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 14:29:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44537 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKST3V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 14:29:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so18917197qki.11
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfUNRR6Aj8Fa/728ptaAQl+RP7PB5fawjGg9q6xDfp4=;
        b=V9VoL4Wb0B3gAgE91RJME11vcDGw+zAO3HH4dqvAghun/4aQldj01ps51tT08vyqaw
         i4YFPt7+ELmXNqCIzOoSgT1JYDx3XFXgDh8zGjS/Ie/8IXEOA089Y/VOHhPsPqkSKGTb
         snL6hxCEtLTRITDgWn8tOeIPgCfdtRg54Juk/sMBsO1rTxOXm/FfTlkxqXKAiVlULKK4
         dyy+U8JKgP+AoBFCqurSPRoBbUFkKn91HVcv1xDFk6lZSpanMrfcYx6XL8xM8vmQEXSv
         9aX8aK4t0FrFoFqjF+x292V9qvhrtH063qXl/iHYOcsxWlHkaIMMIncVeWINwtCEoRgK
         GpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfUNRR6Aj8Fa/728ptaAQl+RP7PB5fawjGg9q6xDfp4=;
        b=XYkkLCZxGZHsVZakJvjM1LvHyIJHpm4d590NA2Cwo/44EkyUmfsr/NH/+L7pz6bCSr
         n3ZgDcmY7ehfNyTrrPO32296ya6yIW+nc619iVrDbAjY1YAJpw+SNh2UW14xWhACwoLo
         cJmxt9iPn4iGHpa0C0eJK6EVgFn/FdneuyuztRIEpAxAvB17hA5YIdyMzDWIZMiBeAsY
         jK5izUNB4AtUl8nqkgwUMcCnRwMreqlVcZMstDPYlDyI1xHv05mu7PgEzJjDexyOONHr
         1KRdNF97en0itAEbmNCAuOdKMfFK+O0x9HeGejxMGURXi0zZmolWHDKr1XyJ/Azq8usf
         yCcw==
X-Gm-Message-State: APjAAAVyedBG/hm8qzO4k0L9Pg38tIX7ug7DnY0/+9BISgPlD3g+cRtz
        5ZWq72rviRXVVRDEReDHlZjMyw==
X-Google-Smtp-Source: APXvYqyffUQbfGWPqa22cMVPLf5pHLGQ0dagckge0lj5Zt4JYRod5XBomE4Ml1TnBvKENOg5Ssb5gg==
X-Received: by 2002:a05:620a:16bb:: with SMTP id s27mr31010123qkj.501.1574191759916;
        Tue, 19 Nov 2019 11:29:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c21sm12035655qtg.61.2019.11.19.11.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 11:29:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9Bf-0004Bt-16; Tue, 19 Nov 2019 15:29:19 -0400
Date:   Tue, 19 Nov 2019 15:29:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haggai Eran <haggaie@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        michaelgur@mellanox.com
Subject: Re: [PATCH RFC rdma-core] verbs: relaxed ordering memory regions
Message-ID: <20191119192919.GA16030@ziepe.ca>
References: <1573976488-24301-1-git-send-email-haggaie@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573976488-24301-1-git-send-email-haggaie@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 17, 2019 at 09:41:28AM +0200, Haggai Eran wrote:
> +/* Use the new version of ibv_reg_mr only if flags that require it are used. */
> +#define ibv_reg_mr(pd, addr, length, access) ({\
> +	const int optional_access_flags = IBV_ACCESS_RELAXED_ORDERING;
> \

We need to set aside more bits for optional as we can't keep revising
this

> +	struct ibv_mr *__mr; \
> +	\
> +	if (__builtin_constant_p(access) && \
> +	    !((access) & optional_access_flags)) \
> +		__mr = ibv_reg_mr(pd, addr, length, access); \
> +	else \
> +		__mr = ibv_reg_mr_iova2(pd, addr, length, (uintptr_t)addr, \
> +					access); \

Missing brackets around addr

This also wants to be a ?: expression to avoid the ({}) extension

Jason
