Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C413195903
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 15:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Occ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 10:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC0Occ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Mar 2020 10:32:32 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD410206F2;
        Fri, 27 Mar 2020 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585319551;
        bh=rGsnUkAfzHyC/Eb7Gb/9HXJVVTaSwN/ewijdlwINBOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n3cS6pSNtwlXzCsTj6mOeaL7HmPD7n5lnu3s86Wx38DfXbaogmfWvwo7J21xmtK0B
         04J+hvJJSDEE2sOv6nZEe2LXSjDNrE+NG0xqFSG97KD3SXkp5WSsMmsFx6U1a5brcb
         zKZ+wJBsxCudgmlFddWCqbGFwNlar9IjMK/1FcNA=
Date:   Fri, 27 Mar 2020 15:32:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 14/17] infiniband: pa_vnic_encap.h: get rid of a warning
Message-ID: <20200327153226.1fed1835@coco.lan>
In-Reply-To: <20200319003645.GH20941@ziepe.ca>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <9dce702510505556d75a13d9641e09218a4b4a65.1584456635.git.mchehab+huawei@kernel.org>
        <20200319003645.GH20941@ziepe.ca>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Em Wed, 18 Mar 2020 21:36:45 -0300
Jason Gunthorpe <jgg@ziepe.ca> escreveu:

> On Tue, Mar 17, 2020 at 03:54:23PM +0100, Mauro Carvalho Chehab wrote:
> > The right markup for a variable is @foo, and not @foo[].
> > 
> > Using a wrong markup caused this warning:
> > 
> > 	./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:243: WARNING: Inline strong start-string without end-string.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Do you want this to go to the RDMA tree? I wasn't cc'd on the cover
> letter

Sorry for not answering earlier. Got sidetracked with other things.

Yeah, if there are still time, feel free to pick it. Otherwise, 
I'll likely send again after the merge window, to be applied either 
by you or via the docs tree.

> 
> Otherwise
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
>  
> Thanks,
> Jason



Thanks,
Mauro
