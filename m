Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9194EEC95
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiDALwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDALwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 07:52:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AC1D59C3
        for <linux-rdma@vger.kernel.org>; Fri,  1 Apr 2022 04:50:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t19so1921318qtc.4
        for <linux-rdma@vger.kernel.org>; Fri, 01 Apr 2022 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aWU5ex06rg/AbNFctgOjoJ+VPR4oCqibVD3GK7DdDdo=;
        b=Qyy3Udw8VF5Ot//VwLar51rfmkwCFBDzCnSF6Gf9f8KzXztMaOS0Bf8klFPdc4rhkS
         qWuajiA0GbmB02qlYfdQXTKlNa+WarFwE0QLpGuBXjIzJtAOaMIAhiWzs2KiYwS8+sa8
         iJEyhURgJ2kgurgxXoEtTXICZzT8NZcuxN+J74FTu1LtT8dHsd5xOtJpnJwPL0AoaElP
         NDy2gnD9jSf+AuVwK9YJeJkfZcYvIHodQUCbEB/o+k4bLIdpFLEyVvYqQaMfqqdBJNNV
         KjqXnimN6f285Yq1Z3jbp2o7g4Pz/rwVJA+NFMOewjcPkrXP5vXkOplN3Xog+1J2f3ve
         bE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aWU5ex06rg/AbNFctgOjoJ+VPR4oCqibVD3GK7DdDdo=;
        b=IaE1M6+xVzURJY2OvRbdGGfErGAXjMXj7gXSCYZ3ql4m3zuSo40bq3vOpDyEUcr+te
         abgjhWzOA+2f/t0gEPPkzBwzkcBvlv7Pyz5fRk7asHBm3tFOkKAIuuIvgn33kr4gYogF
         489nxs8A7oRE6wDZoN2qQTs575q5K9Ob0uTrEah1kc0i1dZxLidJ8qyN/RSkxRZzO9PB
         d7RC8Xv0XhRV/aZsh3Kraipem0yNzckctm/yuaZmV4Nugwa7MHS60p9ywefBwQG4NHm9
         vVa6txHpUb2fNeFwYpSnNBBrNbiFrSEGxw5WKiwpN4006nLlmgX04CjVmkC/NTxx4LTD
         Iogw==
X-Gm-Message-State: AOAM530DGieQ5mN3nWPI5+rtyHoUiGvcIIR7SccEn8hqagsofYI7bR4T
        51V+zVnNIclUOMc2f8DfDn/z3A==
X-Google-Smtp-Source: ABdhPJyfCcvq7CBX9wgoBhMFIjFHkhgqRfs3elmzeEMluYtBMOrfnZch8qYIwPkBbG5DDeM5pPgVDA==
X-Received: by 2002:a05:622a:164f:b0:2e1:d4b7:b208 with SMTP id y15-20020a05622a164f00b002e1d4b7b208mr8122507qtj.84.1648813842430;
        Fri, 01 Apr 2022 04:50:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm1626596qtw.26.2022.04.01.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:50:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1naFnb-00ANpp-Tn; Fri, 01 Apr 2022 08:50:39 -0300
Date:   Fri, 1 Apr 2022 08:50:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     cgel.zte@gmail.com
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] RDMA: Replace zero-length array with flexible-array
 member
Message-ID: <20220401115039.GO64706@ziepe.ca>
References: <20220401075406.2407294-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220401075406.2407294-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 01, 2022 at 07:54:06AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].

If I recall properly this doesn't work if the flex array is nested
inside another member.. Not sure what this thinks it is doing anyhow

Jason
