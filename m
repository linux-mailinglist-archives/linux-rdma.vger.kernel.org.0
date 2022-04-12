Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E14FE31F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356367AbiDLNzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356352AbiDLNze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 09:55:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C457B35
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:53:15 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j6so13731046qkp.9
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PBuMAH3rTUpfxI+mZt/ZTT/N3YWTiBg1EJgACsNMZPE=;
        b=IRlwmzizWP/FSNval8NC5Ggc4mxJ7LERA3iAuMqYVZaaKsd/1Vxj7vuT9rH3rD9EFy
         lbvwSSnM+p+OslNOPAGJxj5qqav+4SHIy4jJa+JmnADPAdO+k1Vw108LQksmynv8cNmS
         Rowrldh3iFELPVVMCkue9aSX5LRkmHJTmWfz2W/vpyjSJghO1VN0x1plzayEp5QW9q7D
         YI4pup9FqTsCnFwAPPxZVzxnq6VhgCDkdebu8EVVn4r/3Eigdt4eRWHtAy+XLWazh9OL
         V7DZxDA+wczrQK3OzhUOV5D5+qqTYQ8BCgJsFFfr60h9qDXyrlSYIp1UUQX6TAI2DYBa
         /oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PBuMAH3rTUpfxI+mZt/ZTT/N3YWTiBg1EJgACsNMZPE=;
        b=eoWDLFXtk0n1ich910pnfV8s/0KR+wRS4M6FBIycZBwJsB5Az+7CSvzcmHkzIY6PPY
         Mn09IMo+zPdwjzjlFxM1XsozgF+K6op9RqCHwbd9T4f5wflNTCpDCEvaDovlS1bxfg2+
         7LybfOfhCe9cQCjhiiP8pzcIXzz+IBpp98QEQKMR2j3UshXvSVSViMrez6usXao2MZut
         ySRtSiIMgVnMfXqeJ+MxAvMO1sHYU3ycX8814RjJaj7OaR4Nrj9FO6HIjhLSiD7gtdPm
         +2R0VCQr4oXx/i7Ao2LabStiAAUkqZsxCfkXhow8sZDwQTAXo5c1/VnpfwZ5l8pS7OGK
         S8kw==
X-Gm-Message-State: AOAM531zgIPbMVlq0wZ+ivYJ++5cY46vqi1jG7BFW5SrQMmuoe3hk9FK
        Xg83kHYGbzOHnBkNhLw431rtItaQIO4jNQ==
X-Google-Smtp-Source: ABdhPJzN4R3N/Vhy3eyCfGaMlAHK5PFg+8lpkEz9oHhWna3/aLeAbnO2OaqcjQcN5BlYsRLQ6sNXbg==
X-Received: by 2002:a05:620a:148c:b0:69b:ef4d:ada1 with SMTP id w12-20020a05620a148c00b0069bef4dada1mr3120812qkj.608.1649771594247;
        Tue, 12 Apr 2022 06:53:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm28980283qtz.92.2022.04.12.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:53:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neGxF-000rE0-1J; Tue, 12 Apr 2022 10:53:13 -0300
Date:   Tue, 12 Apr 2022 10:53:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220412135313.GD64706@ziepe.ca>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
 <20220411115019.GB64706@ziepe.ca>
 <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 09:43:28PM +0800, Yanjun Zhu wrote:
> 在 2022/4/11 19:50, Jason Gunthorpe 写道:
> > On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
> > > @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
> > >   	elem->obj = obj;
> > >   	kref_init(&elem->ref_cnt);
> > > -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > > -			      &pool->next, GFP_KERNEL);
> > > +	xa_lock_irqsave(&pool->xa, flags);
> > > +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > > +				&pool->next, GFP_ATOMIC);
> > > +	xa_unlock_irqrestore(&pool->xa, flags);
> > 
> > No to  using atomics, this needs to be either the _irq or _bh varient
> 
> If I understand you correctly, you mean that we should use
> xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead of
> xa_unlock_irqrestore?

This is correct

> If so, xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh is used here,
> the warning as below will appear. This means that __rxe_add_to_pool disables
> softirq, but fpu_clone enables softirq.

I don't know what this is, you need to show the whole debug.

fpu_clone does not call rxe_add_to_pool
 
> As such, it is better to use xa_unlock_irqrestore +
> __xa_alloc(...,GFP_ATOMIC/GFP_NOWAIT).

No

Jason
