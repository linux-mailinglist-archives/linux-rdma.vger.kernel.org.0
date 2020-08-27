Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409072543E9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgH0Kkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 06:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgH0Kk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 06:40:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D23C061264;
        Thu, 27 Aug 2020 03:40:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so4662203wmi.3;
        Thu, 27 Aug 2020 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9h50JngkVr+gkrhnIsNROuiviGOt2MFti/otieY/AXU=;
        b=QeAUQvUIg8cyqHSvEiCXoONpwTzlEnl88xGfT/MXZUVrM/b9w9CeXPc6QOlUlWX5UJ
         n2Ct5gPGnBbHgD39GW80UXokZEU0zbi+OMQiJM/RWDJHHMUf0P9XSMjJZPZy5CpZXAYw
         4Tmo164abRMFFwsCy5dOey+1UwrrPqIjPn945sOEW7R/EFp/s/hCtjlJqZonCTpBG4tY
         ROx+fQD59ps3nqxC1Sf5PLHOVoBKOj8aQ93anM4yBxDeG27a7l1dR8ibtDDieKpT3pke
         72eaVzrFwyohSiMD2a0D6BRY1uO2jYPRaYv2RaUdk1Qml2muglfY2/S2mg9tis9PMYka
         /yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9h50JngkVr+gkrhnIsNROuiviGOt2MFti/otieY/AXU=;
        b=CjcpwFCgXB2+wGl6SrsLaBUclh6RHQtp1RL086QMAKtZomlFnHBNE8mgtGbZ3Oeavi
         sbGGmTpqEtGH1xzuGLBvEQjBQbTk6WbA1Qic7Z6itszRtVgCkuv/tfaCK9Bg4BKFnmst
         b7iuUlufS21oh2rvviCu4GQ7hrF2ObLtGvlQxuE3mVoX9BnMwqUMg7S9UcG2TjvycMOY
         CXJ+MYLnp47kNJInijGSdJJTD74OkEmB3yUgbxgi1lD79wz03YQaNrasg0PjEVDsm478
         Mz9YQUeM0pxXRkBc1jW0Jg3hbow5SC9JeVUT/8T1GOQ90CKJl6bGUr6m4oCBDSVp85L/
         /d+Q==
X-Gm-Message-State: AOAM531vdN7Mt9SkzryBkQs3JN+Nvms1EsZsXb+jf6BQjIccriiCF5/k
        G6zL2ai+kaJemhwFtMBfaGc=
X-Google-Smtp-Source: ABdhPJwz1uMTy7qUCE4Sfg7brDSdhildnSnl6zUAM6bAmxEAJEgmnowsTywQUlbVghov6jVeGRADJQ==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr6838717wmi.67.1598524823760;
        Thu, 27 Aug 2020 03:40:23 -0700 (PDT)
Received: from lenovo-laptop (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id u17sm5812569wrp.81.2020.08.27.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 03:40:22 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 27 Aug 2020 11:40:20 +0100
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alex Dewar <alex.dewar90@gmail.com>,
        dennis.dalessandro@intel.com, dledford@redhat.com,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        roland@purestorage.com
Subject: Re: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Message-ID: <20200827104020.jfp5kju56duu4sh4@lenovo-laptop>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
 <20200825171242.448447-1-alex.dewar90@gmail.com>
 <20200825193327.GA5504@embeddedor>
 <20200826191859.GB2671@embeddedor>
 <20200827001149.GK24045@ziepe.ca>
 <20200827014120.GD2671@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827014120.GD2671@embeddedor>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 08:41:20PM -0500, Gustavo A. R. Silva wrote:
> On Wed, Aug 26, 2020 at 09:11:49PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 26, 2020 at 02:18:59PM -0500, Gustavo A. R. Silva wrote:
> > > Hi,
> > > 
> > > On Tue, Aug 25, 2020 at 02:33:27PM -0500, Gustavo A. R. Silva wrote:
> > > > On Tue, Aug 25, 2020 at 06:12:42PM +0100, Alex Dewar wrote:
> > > > > Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > > > erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> > > > > were later converted to fallthrough statements by commit df561f6688fe
> > > > > ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> > > > > warning about unreachable code.
> > > > >
> > > > 
> > > > It's worth mentioning that this warning is triggered only by compilers
> > > > that don't support __attribute__((__fallthrough__)), which has been
> > > > supported since GCC 7.1.
> > > > 
> > > > > Remove the fallthrough statements.
> > > > > 
> > > > > Addresses-Coverity: ("Unreachable code")
> > > > > Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > > > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > > 
> > > > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > 
> > > 
> > > I can take this in my tree for 5.9-rc3.
> > 
> > That would make conflicts for the 2nd patch, lets just send them all
> > through the rdma tree please.
> 
> OK.
> 
> > Is there a reason this is -rc material?
> 
> It's just that this warning is currently in mainline.

FYI this issue was found with Coverity, not a compiler. I just built the
unfixed version from mainline (with gcc 10.2.0) and didn't get any
warnings.

> 
> Thanks
> --
> Gustavo
