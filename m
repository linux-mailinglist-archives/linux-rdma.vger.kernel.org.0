Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA003027A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfE3S5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:57:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39103 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfE3S5j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:57:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so8313187qta.6
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJ8eoV66HOG9poIM8AWbefQpDKoD7rUujitRUJ2OdC8=;
        b=KheYiPteCXGS9fXRhd0FJaauO1RTL8M5XjsFQO7nQYCvxy6EF+QtomgttHrdJU2ki3
         j3G70FYIJdrIRf7hj5KXSHduewsd9gbjawtz8eXjeFGX8b7sNujQmIR6O8UT5mfxVRm0
         Zwg+oSKgq6ASA7ItM/i4I2sTPEniiWLlawvu7UjHaFq8cdE6lgw2hMSsD4QGsxlaKj0M
         gDdi59ze/kcfagk6AbOUOA5t2K7OtEe5XtnIm8aZ54k604ySvXB6+SWi7ecte6QQzOXe
         5eZiwrTjNxt0SLW9C63xND3eFueQ/NUneOBLEqS7xk/RFYXPyi/5Pj0qrxYCt5IL5gkl
         mehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJ8eoV66HOG9poIM8AWbefQpDKoD7rUujitRUJ2OdC8=;
        b=LdZTPxI5JX2ELpltxCLV2t0dtm3fD0RiBC6Pg212AVQaI7QXiu/XlXZkXLz5EJnUFz
         VCqLoh3HwFWom2p5MrmuXo3r0OsKwnlaIApcV7dO/fzoRTD4F1W8hefsU8a9r+6pKa2+
         QOm8mVGl6I15N627faBIDjIJ2CiRGrnDXkbHKnG8VPKe3V6Y+HNLOOrXP4iFHhqYonMg
         I4KBgOwT8jwITGzV3n/7s1ZOnJwzuEVy+EVvZAw1UM3vP5rawrkb9xKw+/Q6E6MyHQuK
         mYJtEAg6jLeaWNKhcBbbZtlZjbAsW63MAix567CAN8dLjc7XYoZtsah8PJ/veHOAAofu
         5mSQ==
X-Gm-Message-State: APjAAAVOuLQuMGb5D1z61AUsFZrKMkj8KW9sxuTVdzNKg1mIDS/qFiTY
        kh4V59umhpseEqUrdqw6RV93tg==
X-Google-Smtp-Source: APXvYqwDiNEYmwhiiUsBhEyJgTF5xlFBkrG2HKEEmgw73uJ+Gd9vwvFrGLv1KVGtwqc7tTMTFTewlA==
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr4947612qvb.43.1559242658218;
        Thu, 30 May 2019 11:57:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm1807579qkl.71.2019.05.30.11.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:57:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQF7-0001bW-CO; Thu, 30 May 2019 15:57:37 -0300
Date:   Thu, 30 May 2019 15:57:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190530185737.GG13475@ziepe.ca>
References: <20190530060539.7136-1-yuval.shaia@oracle.com>
 <MN2PR18MB3182E08DB0E164C6BE6C409FA1180@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190530143452.GA19236@lap1>
 <20190530181717.GP13461@mellanox.com>
 <20190530185608.GA25754@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530185608.GA25754@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 09:56:09PM +0300, Yuval Shaia wrote:
> On Thu, May 30, 2019 at 06:17:21PM +0000, Jason Gunthorpe wrote:
> > On Thu, May 30, 2019 at 05:34:53PM +0300, Yuval Shaia wrote:
> > > On Thu, May 30, 2019 at 12:37:18PM +0000, Michal Kalderon wrote:
> > > > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > > > owner@vger.kernel.org> On Behalf Of Yuval Shaia
> > > > > 
> > > > > The virtual address that is registered is used as a base for any address passed
> > > > > later in post_recv and post_send operations.
> > > > > 
> > > > > On a virtualized environment this is not correct.
> > > > > 
> > > > > A guest cannot register its memory so hypervisor maps the guest physical
> > > > > address to a host virtual address and register it with the HW. Later on, at
> > > > > datapath phase, the guest fills the SGEs with addresses from its address
> > > > > space.
> > > > > Since HW cannot access guest virtual address space an extra translation is
> > > > > needed to map those addresses to be based on the host virtual address that
> > > > > was registered with the HW.
> > > > > This datapath interference affects performances.
> > > > > 
> > > > > To avoid this, a logical separation between the address that is registered and
> > > > > the address that is used as a offset at datapath phase is needed.
> > > > > This separation is already implemented in the lower layer part
> > > > > (ibv_cmd_reg_mr) but blocked at the API level.
> > > > > 
> > > > > Fix it by introducing a new API function which accepts an address from guest
> > > > > virtual address space as well, to be used as offset for later datapath
> > > > > operations.
> > > > > 
> > > > Could you give an example of how an app would use this new API? How will
> > > > It receive the new hca_va addresss ? 
> > > 
> > > In my use case an application is device emulation that runs in the context
> > > of a userspace process in the host.
> > > This (virtual) device receives from guest driver a dma address (in form of
> > > scatter-gather list) along with guest user-space virtual address. 
> > 
> > How do you handle the scatter-gather list?
> 
> Well, it is not exactly scatter-gather, lets think of it as an array of
> guest dma addresses, in mellanox terms it is mtt, in vmware it is page
> directory.
> So i guess your question is how to register list of scattered addresses,
> right?

Yes..

I've always thought we should have an API to do that.

Jason
