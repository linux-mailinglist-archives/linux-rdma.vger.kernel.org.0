Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718E611742F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIS3t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 13:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIS3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Dec 2019 13:29:49 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C7C2077B;
        Mon,  9 Dec 2019 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575916189;
        bh=10O+VoIovfwCskMewNy1SMPPar1H8jRX+oOO+JDykrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fjsey3cJztMIkqaR8AEUVnYlC4Y/dftODmeLxDNxNWsRPrecHlVMQDp4qz/JADJtz
         9oriw+qqIBQCM05e+ZH8oTPii5/UW7lJTaDoAtWk0+zKkfHy04pXDXMPqoabF+Va8z
         HEpn4J1cKErPwJJnnWPxwYAFXG32GyNGyx9CUpTo=
Date:   Mon, 9 Dec 2019 20:29:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        krishna2@chelsio.com
Subject: Re: [PATCH for-next] RDMA/siw: Simplify QP representation.
Message-ID: <20191209182944.GE67461@unreal>
References: <20191209160701.GD3790@ziepe.ca>
 <20191129162509.26576-1-bmt@zurich.ibm.com>
 <OF3F5E9911.A6946CC7-ON002584CB.0059DED2-002584CB.005C8103@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3F5E9911.A6946CC7-ON002584CB.0059DED2-002584CB.005C8103@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 09, 2019 at 04:50:23PM +0000, Bernard Metzler wrote:
> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>
> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 12/09/2019 05:07PM
> >Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
> >Subject: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: Simplify QP
> >representation.
> >
> >On Fri, Nov 29, 2019 at 05:25:09PM +0100, Bernard Metzler wrote:
> >> Change siw_qp to contain ib_qp. Use ib_qp's uobject pointer
> >> to distinguish kernel level and user level applications.
> >> Apply same mechanism for kerne/user level application
> >> detection to shared receive queues and completion queues.
> >
> >Drivers should not touch the uobject. If I recall you can use
> >restrack
> >to tell if it is kernel or user created
> >
> 'bool res->user' would probably be it, but I stumbled
> upon this comment (e.g. in struct ib_qp):
>
>         /*
>          * Implementation details of the RDMA core, don't use in drivers:
>          */
>         struct rdma_restrack_entry     res;
>
>
> So we shall not use restrack information in drivers..?
> Shall restrack better export a query such as
> 'rdma_restrack_is_user(resource)'?

rdma_is_kernel_res() inside include/rdma/restrack.h

I added the comment mentioned above before we started to remove uobject
accesses.

Thanks
