Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A398528EA83
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 03:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgJOByo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Oct 2020 21:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbgJOByi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438AC08EC6B
        for <linux-rdma@vger.kernel.org>; Wed, 14 Oct 2020 16:27:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id bl9so370802qvb.10
        for <linux-rdma@vger.kernel.org>; Wed, 14 Oct 2020 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGMetf2TtDYpQ2U52WWdv6t2v1aPWDuWX9MXwICP818=;
        b=JKTFenP2amE8CI1KKnHcrQE7Mc94ojhKi/rSYtZlqb0N5vnJYo+8N3vvIMS2e/I04i
         D5Z7eSkTLyeIsrs4IHivY5UY9sNQ9GuBUlJsVVasrgUmW3dFRT9reK5D+je9jQwshPoy
         1TDGpVUHE8k/1EkzxNBntAuJkoOxG7IKwSoAQfSW11DxK39NSzxnJMT2ecH3r9RmtFXV
         6SuABXnye1cmoTB1kt04+1rpliftDeZco1NPwphnQSNiCIK/qmL7HvyiVBu64MJhNIG7
         vk0q+tlNGdtGq8wS76VsbsV9GqIENipUaFHG9+OBuG8ZufkOwBcOt/gMG8O3i/YRjyCJ
         tRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGMetf2TtDYpQ2U52WWdv6t2v1aPWDuWX9MXwICP818=;
        b=LFUuT7K9/9mYf0F9Ke9Fqjfu1yYIP2qfeSW1pdOIiDZnvbNyDsKhyt5cSLjP2mRamj
         smhg4F87bn/neYkOJmInPVNHDKU5zLGppqLhsawJDSprbWfVmMTiCFamdCzIkJM4r/Mj
         mmiEGn3K75ANAyqrHB2BBsgUGzkyyNOWc3svayxtlPhhXVMLDisvi1vtmbRz/+qyPmmF
         1gREzYKpRdsS/zD0dAa0hGgYVGwbW21+3cTdY9f0GviXfM2LLlWG9LlwQb2PO8rr9jYs
         C6s018yheU4CvkQupnA+ltL9wTGqrUHAAu834ekD/tSH3CK5+ZYy8fjTgcKM4EjXAiN8
         OWuA==
X-Gm-Message-State: AOAM533akkyOp9iGei4+yXb9CH+JsErwEh6Md6Nl7zYxuASy0YYcErM+
        yBb+U2Ykx352rhVzZffmVUh6aBsUyEhZEQ==
X-Google-Smtp-Source: ABdhPJyCFy8Ef1msmxTyTP8my9nEEJAhY8bgrnNAfnPhIUZit37rGO8drXpQwB0Al6ZeBN1iYAP80w==
X-Received: by 2002:a0c:a482:: with SMTP id x2mr1771542qvx.56.1602718043905;
        Wed, 14 Oct 2020 16:27:23 -0700 (PDT)
Received: from ziepe.ca ([142.177.128.188])
        by smtp.gmail.com with ESMTPSA id z69sm520231qkb.7.2020.10.14.16.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 16:27:23 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1kSqB0-0001sR-8d; Wed, 14 Oct 2020 20:27:22 -0300
Date:   Wed, 14 Oct 2020 20:27:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 01/11] RDMA/cxgb4: Remove MW support
Message-ID: <20201014232722.GC6763@ziepe.ca>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <20201005055652.GE9764@unreal>
 <20201005161726.GX816047@nvidia.com>
 <20201009164004.GA20779@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009164004.GA20779@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 10:10:06PM +0530, Potnuri Bharat Teja wrote:
> On Monday, October 10/05/20, 2020 at 21:47:26 +0530, Jason Gunthorpe wrote:
> > On Mon, Oct 05, 2020 at 08:56:52AM +0300, Leon Romanovsky wrote:
> > 
> > > > -	mhp->rhp = rhp;
> > > > -	mhp->attr.pdid = php->pdid;
> > > > -	mhp->attr.type = FW_RI_STAG_MW;
> > > 
> > > 75% of "enum fw_ri_stag_type" can be removed too.
> > 
> > I think that is the code-gen'd HW API for this driver, I don't mind
> > leaving it. It seems the HW supports MW, just nobody plumbed it
> > through to rdma-core
> > 
> Hi Jason,
> Agreed its dead code as is but Chelsio HW suports MW and we are yet to decide on
> requirements, we may probably add userspace support for MW in future.

You can't add userspace support without modifying the kernel since the
ucmd_mask was never, set. So when/if you get everything working send a
kernel series bringing these functions back.

Jason
