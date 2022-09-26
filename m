Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2233D5EAEE2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 19:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiIZR5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIZR5M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 13:57:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B1DEA2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:35:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i3so4570451qkl.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R783SiSfCMVqAFTcNVl7sF8YnFXoJd82sBRH4fuwwS8=;
        b=GvOhqyhao+mcwjXW8UmLL7OlZss0mKztQTnLV9JflFLL4ro1u6w/RfLbOMS6mKRS/D
         yGdvNqxworwRxlFTmUPcZDMSEcUNMnt8XI5ITgGsIEaflVyzGuEoHkdx+py3FKt2cVLT
         gDEd0Uko4ScuxyIZlDSR00lLgGHzOs4AUaxmWtB5mJ/+AaRfteAeKleq1VVqCJTE6mAz
         eV0BIwsQR+DE2f4dnfuVfDJBV8NQtQoHgfaAV/6LNyQ+d7HfAqWiucBi79hROOtQQcGD
         cpt7XpZvQ305WDQGmNXePSxCTS3+QIneOOrS1mIGJHdPah/lj5Onfdlv5/kc733FjRoc
         Dc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R783SiSfCMVqAFTcNVl7sF8YnFXoJd82sBRH4fuwwS8=;
        b=GJZgCkVCpXNSVjBRmgrOBXYVbGp6ZT3XaxzdjqgoJKuBjywpZVoYSkqcb97/6ERNt7
         aiL2r+g7KS9dFuko8TXRlDbgZLM8toPy/tC6PbtoYZqfUmoc/Y1tSq/x9g5INIVrLZJ5
         GeaQ83aS2ziuoCGJ06NYjA+Quph2UicLHeaCsd+KHl9a8aTc1jcqwoprPx/ZQjoPilhh
         PEHRwMSuj99x60jPNPAhiJcz8g55CpmxcVxuOTQGsAxHC/1ojPcgOrztZyuQrIehloWy
         oGKCcVJgklhW55LD6OU0EE2RUHft6uIIzx30yoo/qr8v6mPlBnJAC+RvQ959di7HYaUD
         RUNQ==
X-Gm-Message-State: ACrzQf2dl8IGt0mHLELxDba6ml/gR3EJMBvH/lKSn87jA4yUlmNg2bhZ
        YEG2Wdd1nPtNo1+7OJWj5ioEmQ==
X-Google-Smtp-Source: AMsMyM7ZdCi0AXhel9Eb4di0Rz2+bPGv2Tlf7yDdRWDAk6VAYl5u0Y5iIdglC17r9JMvLiVGkiR5Iw==
X-Received: by 2002:a05:620a:1312:b0:6ce:5f1b:b05f with SMTP id o18-20020a05620a131200b006ce5f1bb05fmr14365845qkj.360.1664213714032;
        Mon, 26 Sep 2022 10:35:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id o29-20020a05620a0d5d00b006b60d5a7205sm11064665qkl.51.2022.09.26.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:35:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ocs0e-000BUR-MP;
        Mon, 26 Sep 2022 14:35:12 -0300
Date:   Mon, 26 Sep 2022 14:35:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1,PCI: Fix missing pci_disable_device() in
 probe and remove
Message-ID: <YzHi0D7YNtZyxOZE@ziepe.ca>
References: <20220922024601.3643622-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922024601.3643622-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 22, 2022 at 10:46:01AM +0800, ruanjinjie wrote:
> Replace pci_enable_device() with pcim_enable_device(),
> pci_disable_device() and pci_release_regions() will be
> called in release automatically.
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Please no, at LPC it seems the general consensus is that the devm
varients were a Bad Idea. If the code as-is is correct then lets leave
it alone.

Jason
