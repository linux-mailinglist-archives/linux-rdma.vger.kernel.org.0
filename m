Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E674DD93
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGJStU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjGJStT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 14:49:19 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17310C3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 11:49:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-765ae938b1bso453144985a.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689014957; x=1691606957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vuc2RGlNDPX0WHzNUZ68FNKD5vSaPC+1T3268GsGn1o=;
        b=DPIKL7B+r1AOTGxEGLAytamKWjUCWYUXYDWmNUI/bDuwAyuooJXXUDjveqLQOqPG7v
         Kd80OWCOvvUhkkIq/cpCisoIDqJATbT0bieuc22iPsFQnQDqw7bzQwaW4kfnSiPqV5AE
         kwvmgohQY4tHcsMJrkUA1zbuvrX8wFapl23T/f6I1SqE/lAE8gYSyGjdMTuSa76dM08a
         BqNLA/9fKgDEpy3YB0y3zdvmhRBr3IoW/gWDVTAL1Z1OyvLaVV2tfjRuyeDVLFafGVeO
         nDGTgtnB9NLRqoFxe4LLtQdL+mAl26xCD9L9h1BPE7o4mvs5h1MiXJtuEvAI4aSC/C+1
         HoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014957; x=1691606957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuc2RGlNDPX0WHzNUZ68FNKD5vSaPC+1T3268GsGn1o=;
        b=XfXTWbcUNycKNCOGqYBBqzEhPukTeGjM5yUQ88lhQxLcKNJfu8L402orwcXKt9S4Id
         oghBbvB1KI27+vREgPBV8fgj/nntnUlsQHH4FgY7N20S/Cbg0uRvyrrHnWa4Zfbo1mEy
         /gnPb2B/OSfMtvDyJm3p2BGOMcYA1I/Fv359o6gVTVVub+I+/KHfkxe9KFBVH5IpzRMh
         klJoUcQ/scpxVf/R8Jcbx5Cds1yXGY1uJ3uF0X86d44HcvsconORJ8j1T+hiq3o1OLBH
         bX4FBI/wa4WouHBMTiJkPkKBpjFxFgFlTo1lRqwdsjUH/QrnedzQsCK7b2rYNhZMNno+
         ScqQ==
X-Gm-Message-State: ABy/qLbMu4ZEH/nJqHb4MiFQlsG1pmz+mOc2ozJqA1YVOaBkEkWU+J1J
        LHobab7jrTcN0BhhCeGgFJWmoQ==
X-Google-Smtp-Source: APBJJlEN2A6v97mnICa+7D7yKuUQ5xgkdehvfwJj1fIED8lFSPF7TGTOKOhmkv5c6gLp+tpP/XkfBQ==
X-Received: by 2002:a0c:e352:0:b0:62f:a95:4567 with SMTP id a18-20020a0ce352000000b0062f0a954567mr11937154qvm.11.1689014957254;
        Mon, 10 Jul 2023 11:49:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e4-20020a0cf344000000b0062b76c29978sm137011qvm.6.2023.07.10.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:49:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIvwi-0004qc-7N;
        Mon, 10 Jul 2023 15:49:16 -0300
Date:   Mon, 10 Jul 2023 15:49:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Guy Levi <guyle@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Make check for invalid flags stricter
Message-ID: <ZKxSrOVS/CtxJaDl@ziepe.ca>
References: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
 <20230704133841.GD6455@unreal>
 <359dc6de-2b08-4baa-99cc-d5e5f6e6ce43@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359dc6de-2b08-4baa-99cc-d5e5f6e6ce43@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 05:07:17PM +0300, Dan Carpenter wrote:
> On Tue, Jul 04, 2023 at 04:38:41PM +0300, Leon Romanovsky wrote:
> > On Thu, Jun 29, 2023 at 09:07:37AM +0300, Dan Carpenter wrote:
> > > This code is trying to ensure that only the flags specified in the list
> > > are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
> > > the flags are an enum which is treated as a u32 in this context.  That
> > > means the test doesn't check whether the highest 32 bits are zero.
> > > 
> > > Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > > The MLX4_IB_RX_HASH_INNER value is declared as
> > > "MLX4_IB_RX_HASH_INNER           = 1ULL << 31," which suggests that it
> > > should be type ULL but that doesn't work.  It will still be basically a
> > > u32.  (Enum types are weird).
> > 
> > Can you please elaborate more why enum left to be int? It is surprise to me.
> 
> Enum types are not defined very strictly in C so it's up to the
> compiler.
> 
> Clang, GCC and Sparse implement them in the same way.  They default
> to u32 unless the values can't fit, then they become whatever type fits.
> So if you have a negative, it becomes an int or a big value changes the
> type to unsigned long.

It is worse than that, the standard has some wording that the
constants have to be 'int' so gcc makes most of those values 'int'
when it computes the | across them.  There is some 'beyond C' behavior
here where gcc will make only the non-int representable constants
some larger type (ie MLX4_IB_RX_HASH_INNER is u32 and
MLX4_IB_RX_HASH_SRC_IPV4 is int)

This is totally un-intuitive that the type of the enum constants is
not the type of the enum itself (which is u32 in this case), but here
we are.

C23 finally fixes this by brining the C++ feature of explicitly typed
enums and then the enum and all the constants have a consistent,
specified, type.

But this is definately the right thing to do, I actually thought we
had a function specifically for doing this test becaue of how tricky ~
is...

Jason
