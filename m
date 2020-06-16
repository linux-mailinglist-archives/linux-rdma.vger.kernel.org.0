Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B691FBE56
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFPSmf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFPSme (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 14:42:34 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A0C061573
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 11:42:34 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so16733355otr.12
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fn4ehCG3pFeb0sf+XQjAjxNV4HnRu1zeAZ03qDqSGLU=;
        b=TMIXWavEcgNLMiErIzR/M/QAAvkh9oQoUF847arZZvocgtMF8TmfwlFDprVx8F2hrb
         11hcFdVXFq2a2gv2xuSkHBk56tVEMcU0xdWigQjOcodzOumMpNYyL6vP97sYQ4Q5AukS
         YPkNt+rFy5VrBGnPdg72VNlILdpJaJGUlEgAuBqMgqoRAoqWWVAIF6+C41YrcwcUQWvM
         LYsidFr9aRThJH3pekg79ob40OX0aFMXedHO/0AeWC97OJBiLRR8A3c9Ec5nj7QrLdxy
         +koxhYmSYGR34tcWcU5lm09L4AZpspK/wfZKCqWfW5ufs/4ndKek3l19RFnDHiEQ5Iq8
         Z4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fn4ehCG3pFeb0sf+XQjAjxNV4HnRu1zeAZ03qDqSGLU=;
        b=LBcLT3r0r8De+LoVSQ5rivwcatHHT3fAHgjZbdA3OP1KxdtR8rVBKdGtMsw1FFBEp4
         Kp64ljZzhYvo7ID7o2/lq8+BOfMqF3c9Qn80LwkuMLFoFaNvI+HIwYnHYkQM85DNpMfW
         1lne41v7mBn0Yz1tOLxmDmRmwncRN4rCK4WUMhvrhhyqMy7iEpKVGFBQpucdZcNjmNz5
         gdSJBr4/czMq3xRc8Lmf4xn2S0m1VEjbLQjHIY9Tw2Taacm/CmsY3DbXHVxHrAqJEID8
         2afkUx0k3v0V+bK9D08ZetFKa+nhHisF3WPLjmja4/1fk02blfY9y0U6JfO/Bg9QoeuE
         Patg==
X-Gm-Message-State: AOAM532WyA33R7MBzHf5WMT/Bppc5p/miSGNeHZBC1ZksqJ9ySmydI4Q
        5DcAIIJFKp7B2albiOKx1bs=
X-Google-Smtp-Source: ABdhPJzHsQVA/tvAyZjXV5NGkPqv+a4ED8ir9Z4DfWruYol8sHBDspsj+CoSUHls0kvHAn153ObTOQ==
X-Received: by 2002:a05:6830:20c9:: with SMTP id z9mr3943350otq.30.1592332953611;
        Tue, 16 Jun 2020 11:42:33 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id b16sm4191936ooj.17.2020.06.16.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:42:33 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:42:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200616184231.GA3734396@ubuntu-n2-xlarge-x86>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
 <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
 <20200616062534.GB2141420@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616062534.GB2141420@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 09:25:34AM +0300, Leon Romanovsky wrote:
> On Mon, Jun 15, 2020 at 05:56:50PM -0700, Nathan Chancellor wrote:
> > On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
> > >
> > > > They should probably all be in "enum ib_mtu". Jason any issues with us donig
> > > > that? I can't for certain recall the real reason they were kept separate in
> > > > the first place.
> > >
> > > It is probably OK
> > >
> > > Jason
> >
> > I don't mind taking a wack at this if you guys are too busy (I'm rather
> > tired of seeing the warning across all of my builds). However, I am
> > wondering how far should this be unwound? Should 'enum opa_mtu' be
> > collapsed into 'enum ib_mtu' and then all of the opa conversion
> > functions be eliminated in favor of the ib ones? It looks like
> > OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
> > drivers/infiniband/hw/hfi1, should all of those instances be converted
> > over to IB_MTU_* and the defines at the top of
> > drivers/infiniband/hw/hfi1/hfi.h be eliminated?
> 
> We rather keep separation due to logic separation.
> 
> While ib_* defines come from IBTA and interoperable across different
> devices and vendors, opa_* definitions are Intel proprietary ones used
> for the product that was canceled.
> 
> Thanks
> 
> >
> > Cheers,
> > Nathan

Fair enough, could someone take care of properly fixing the warning that
was introduced by this patch then? I can send a patch that just adds an
explicit cast but that looks like an eye sore to me. Otherwise, I am not
familiar enough with this code to know what is an appropriate fix or
not.

Cheers,
Nathan
