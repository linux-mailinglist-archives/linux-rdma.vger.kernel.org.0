Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60E722A260
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgGVWdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVWdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 18:33:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3DC0619E2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 15:33:15 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so3094061qts.6
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNTzG6qcBQuW0UnSYe8/jDfHi5XObGtNTg45FW0KfjY=;
        b=M+VGBvQ+eQKQBCSLRfLaL/v6FZSuwRdtyTJX6r07YtUqLEva+Fz5S4iJyShRBpQ119
         bcDKHcMIoRzgHSuqq0/fMI96YHvIv+USJdZ5Z6+uZY9nQhSww6xl0ywoebu+4WX87wgk
         FF74hwwPU7XWFybe3w/4/PoWIoFlevi/87tc6OYP+b/KplY9Ui4oHj/etquSuVuLtS7S
         PQgWA9ASEwCJbPzsByGq2exdZIQcyh7VpC6bICadwajduRf+C4LaAYeu3xjIt2Vtr2D5
         8m3ZKcpYylNX3Iuhze4CR60MHFC0Sz8yAyDmL+CS9XASuzDeI+sEqvhr2rXkaOMQdaJ3
         omyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNTzG6qcBQuW0UnSYe8/jDfHi5XObGtNTg45FW0KfjY=;
        b=XGR1npu+siAzlF0KXbTqxwnVUJOGd4nfZBzEPw+s9LQXSldqDm4WJZlBK/cNDCTsPh
         ivqgRVRP8SI998Pczs2FUMdipYkZ+pjrFfZ1LPtIhlBsG2vNybvYMD0Pq20awoutCiwc
         hfkJD+253CznanyXyo4C6LvieBNG4CVAiTkDQNnO+gO42VrRFixloSQfx0p6yS4oK/HZ
         A7Kw+u/QA6XMCXfMUQKDIJDkejIh4jGq/xO/mMYcnTCHtaCCUpyN+Dud7bVeD+rnUv9Y
         LNKEs/OpAOl6ELP8RcEfkXu/ohx5xKO5u0Bx6ZB7v5FZtsmZ7uPQ3pdESHZ6deWMkAob
         RvbA==
X-Gm-Message-State: AOAM5303HszG1oPL4gRJfmvLYRjOAScifEygSbERQVzv4tCXb/tLyTMv
        kMBZGZDJf4fcGHBAJij7cvBDsw==
X-Google-Smtp-Source: ABdhPJxiKbn56anOP6nT+bAbNNtR/OqTNAMF/G7Mw2zuA7Od619cKlMkiA82MbBqicSsEqw9RJOhMA==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr1587073qtr.84.1595457194224;
        Wed, 22 Jul 2020 15:33:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x36sm990975qtk.36.2020.07.22.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:33:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyNIV-00E6RQ-L9; Wed, 22 Jul 2020 19:33:11 -0300
Date:   Wed, 22 Jul 2020 19:33:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@marvell.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 01/15] qed: reformat "qed_chain.h" a bit
Message-ID: <20200722223311.GK25301@ziepe.ca>
References: <20200722221045.5436-1-alobakin@marvell.com>
 <20200722221045.5436-2-alobakin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722221045.5436-2-alobakin@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 01:10:31AM +0300, Alexander Lobakin wrote:
> Reformat structs and macros definitions a bit prior to making functional
> changes.
> 
> Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
> Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>  include/linux/qed/qed_chain.h | 126 ++++++++++++++++++----------------
>  1 file changed, 66 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
> index 7071dc92b4e2..087073517c09 100644
> +++ b/include/linux/qed/qed_chain.h
> @@ -26,9 +26,9 @@ enum qed_chain_mode {
>  };
>  
>  enum qed_chain_use_mode {
> -	QED_CHAIN_USE_TO_PRODUCE,		/* Chain starts empty */
> -	QED_CHAIN_USE_TO_CONSUME,		/* Chain starts full */
> -	QED_CHAIN_USE_TO_CONSUME_PRODUCE,	/* Chain starts empty */
> +	QED_CHAIN_USE_TO_PRODUCE,			/* Chain starts empty */
> +	QED_CHAIN_USE_TO_CONSUME,			/* Chain starts full */
> +	QED_CHAIN_USE_TO_CONSUME_PRODUCE,		/* Chain starts empty */
>  };
>  
>  enum qed_chain_cnt_type {
> @@ -40,84 +40,86 @@ enum qed_chain_cnt_type {
>  };
>  
>  struct qed_chain_next {
> -	struct regpair	next_phys;
> -	void		*next_virt;
> +	struct regpair					next_phys;
> +	void						*next_virt;
>  };

I'm surprised this is considered an improvement??

I've been encouring people to go the other way, maintaining vertical alignment is
harmful to backporting..

Jason
