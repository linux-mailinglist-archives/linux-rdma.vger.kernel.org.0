Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4583F4B53
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 15:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhHWNFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbhHWNFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 09:05:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE2C061575
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:04:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id jv8so9591736qvb.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f50vC7zIeMwqepv4RFwpH7mORqkN8Mr21/+qOWLlAYI=;
        b=fLBg8hJB3YxHLiRx6SMZ08NW60UMGWMS+FOsUqJMvTgltf9rnMZsu1cIxbm8f0yXKP
         wg7SEWN1pCyevpBSaxrytzfvCdcUMCJ8fnTJBWhizDkNrWqocdQW4G0nntRvNWPGFJ0u
         ZjfP0vTVwSEcpsqWif3oosDJVguCeEjHNyCAFfRUuXXViX9643iur529Q9KRGHyIcW6T
         GRUzYrjGxEjQMqg5+9Q4S1N/daCQTX2Oc1OnDCsJCiCDbNR6ZgpxDem287KfPr24EFRb
         CjaVTeZ6osyOmjwpdLVX2KHwMBthhnROibBefHDGUF1e20Bb0E2IaTMHcBeJ/y1AoLfg
         1ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f50vC7zIeMwqepv4RFwpH7mORqkN8Mr21/+qOWLlAYI=;
        b=Gdu8J+3DDGTB0PXaHVIMhQNgN6+qWgwsjGU1CaYZe3+XFcoD8ypIfcTnDAqX2eHWrH
         vqdrXMwoFnWXSWqGiPi70TcohwFY2v7H2L8KoE/JHyk/FoQdC1ijoGFrvZltewKohGQa
         FlQ2ewttygX9Q2aGDP9UVYzS3P5amIolkNW+x0xRezS5GXDyY3V0A2t3lBICShv04yZh
         e4pBGk8v1pYoCnDQy3IcUOmismCG4PuyVRYMnWwoM79GCU7EEElNcENQkT/Z0s7kvOLh
         mC515Ubmg71Sa2IFikeXbc3MwDOwKY7IluE1MXZNk7pZ8fL0AcCbjL5oBN7gTQ8X6OuX
         KV4w==
X-Gm-Message-State: AOAM530dluGRnswv83kYPrnIbbqrhOUunPxRqvj3Fm3mK2FSJJXHV+Og
        WlhaUu5mABEm2tWKhS4jQFaAXOtrVt0jlg==
X-Google-Smtp-Source: ABdhPJyhXO416IdBDrNzxSPX6GBkG/NURoOzbhXsDjiUNJUg4POnRfuzLVC3Dv4qg5BUBG+QET1nNg==
X-Received: by 2002:a05:6214:c69:: with SMTP id t9mr33312470qvj.28.1629723860598;
        Mon, 23 Aug 2021 06:04:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h13sm8264610qkk.67.2021.08.23.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:04:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mI9ch-003GE6-6D; Mon, 23 Aug 2021 10:04:19 -0300
Date:   Mon, 23 Aug 2021 10:04:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <20210823130419.GA543798@ziepe.ca>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca>
 <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 11:53:48AM +0300, Oded Gabbay wrote:

> Do you see any issue with that ?

It should work out, without a netdev you have to be more careful about
addressing and can't really use the IP addressing modes. But you'd
have a singular hardwired roce gid in this case and act more like an
IB device than a roce device.

Where you might start to run into trouble is you probably want to put
all these ports under a single struct ib_device and we've been moving
away from having significant per-port differences. But I suspect it
can still work out.

Jason
