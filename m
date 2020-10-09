Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF83D288CC7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbgJIPeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389286AbgJIPeI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:34:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7FC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:34:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 140so9249627qko.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cr0Wu9uKFx9jCRmzr4+5wPNR0+MenAtDpXJRGtbSwBk=;
        b=Hy600MUxVD2WC+0fNwlqo4rNsOcnlUJC04RVcRGZQBSdT4YJ2zADA9bYOc9kATBvEQ
         y2D1SfQg3JkDB/oNpe7oZb90LUMYjNkDzQJQbrKtR65KIBoh1mHmcl84fPZDH6CFg6pz
         hsJeQqD091lCG0IMfJ1IjNKljYgg5v7RPj7uB7A6bBkxYURX9v3yGAwc4g4HZigcyYzI
         k7CXDyIu6HS49e3covDhXVbTMwArVezWQLTsfl3Ru6xN2VuyEfiKE3fEBQpQA3yPughB
         4myBNg++bos16DRGw4BOG8KqAmiDs87ElGFOeBXjuA+3BHiWx3Gvs31a9dbhIKGYR6zH
         Sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cr0Wu9uKFx9jCRmzr4+5wPNR0+MenAtDpXJRGtbSwBk=;
        b=nQdPJc9enqNfedT7LZnbIgmo4EOvU8QREnWPVQhNjji8BUzUrubPVQhfpxBB5TP5bt
         j/qDwTWfJkcg+SAi/MlGMM1DRLCnOIABA8JPsBO0YTgnl4OX+y2UhOXLnkzrXNQEQEnl
         wo3jJ/c2xXQ3ygIPzFIjBOyKNA4LWTPgaAVIR1+zhxJUbwszu1wimRj8qSf/MWztvg8p
         FXsUeuGV0Wms+frl5DjP4hRIUDCTMf5zMA4zZfKEqo2nmXw4bXUmNZnl6sBeplIJcgCa
         mlLO3FaQvXi1GXFEXQXVA16LbSYDhc5WMsPRVOO2a7W1/taZxh4Qvt+fzD/yxPOjURA6
         l96g==
X-Gm-Message-State: AOAM5320r7HdEU/M2c/ZCQKtoQTADDQosFU8VgNaNmfIpwWayogdpaQf
        oSyLtEjPXul5D84lp8oo7SQ5pFbzoJ6FkP9m
X-Google-Smtp-Source: ABdhPJxhJgv9oxijLhfGnS0B+7QR/lJna4WfXbwaH0VnCF0m6R4MFOI6JBp2FpWkQ+8PvnA8/h2V3w==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr6107222qka.119.1602257647523;
        Fri, 09 Oct 2020 08:34:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l6sm6394932qkb.56.2020.10.09.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:34:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQuPG-002CBu-4o; Fri, 09 Oct 2020 12:34:06 -0300
Date:   Fri, 9 Oct 2020 12:34:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201009153406.GA5177@ziepe.ca>
References: <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 11:27:44AM -0400, Chuck Lever wrote:

> Therefore I think the approach is going to be "one RDS listener per
> net namespace". The problem Ka-Cheong is trying to address is how to
> manage the destruction of a listener-namespace pair. The extra
> reference count on the cm_id is pinning the namespace so it cannot
> be destroyed.

I really don't think this idea of just loading a kernel module and it
immediately creates a network visibile listening socket in every
namespace is very good.

> Understood, but it doesn't seem like there is enough useful overlap
> between the NFS and RDS usage scenarios. With NFS, I would expect
> an explicit listener shutdown from userland prior to namespace
> destruction.

Yes, because namespaces are fundamentally supposed to be anchored in
the processes inside the namespace.

Having the kernel jump in and start opening holes as soon as a
namespace is created is just wrong.

At a bare minimum the listener should not exist until something in the
namespace is willing to work with RDS.

Jason
