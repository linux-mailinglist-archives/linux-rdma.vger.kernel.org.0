Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC23431C9
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCUI5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 04:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhCUI4v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 04:56:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D2AA61924;
        Sun, 21 Mar 2021 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616317010;
        bh=349re/xRmhghhglFb2HVcKulTN/dsCATi50SCN5+e00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2gfWOhimkDKA5OLq6phBfUawkrZGI3p2yXTNMRvJVtsfM7Leo488iXqHgeM7N7Mw
         yCxnNNYjLFjzg3F32ZA0fdR8btFPVaeSSRFy2yU6CA0frIYUfHU4LilJ1Ltq5EP/QH
         13kvmgt/5pyznhuX6lcijugIoCGM+fHE1K/RNtl5TDRCLZRB6goATKzM3fomQqCoIO
         0b8qDcpKz/xaNcCk0wUO3qlHQnEH6JPdFGwoF3nxTNG5dIaeyVdQ5sR3Dz0MWIrunx
         pJmOXCfyMiWmRqcytg8/AbhZhbRBi8zIdGDijSslFUnPNsIrt7GcYn72LPYSJ1Ifa9
         YTGR6S1JN8Lqg==
Date:   Sun, 21 Mar 2021 10:56:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <YFcKTjU9JSMBrv0x@unreal>
References: <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 20, 2021 at 12:39:46PM -0400, Dennis Dalessandro wrote:
> On 3/19/2021 6:57 PM, Rimmer, Todd wrote:
> > > > [Wan, Kaike] Incorrect. The rv module works with hfi1.

<...>

> > We have removed all GPU specific code from the upstream submission, but used both the "alignment holes" and the "reserved"
> > mechanisms to hold places for GPU specific fields which can't be upstreamed.
> 
> This problem extends to other drivers as well. I'm also interested in advice
> on the situation. I don't particularly like this either, but we need a way
> to accomplish the goal. We owe it to users to be flexible. Please offer
> suggestions.

Sorry to interrupt, but it seems that solution was said here [1].
It wasn't said directly, but between the lines it means that you need
two things:
1. Upstream everything.
2. Find another vendor that jumps on this RV bandwagon.

[1] https://lore.kernel.org/linux-rdma/20210319230644.GI2356281@nvidia.com

Thanks
