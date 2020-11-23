Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A792C18CB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 23:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgKWWsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 17:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbgKWWsA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 17:48:00 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A8F206D8;
        Mon, 23 Nov 2020 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171679;
        bh=3RMlvihFG6FapSYwsjGeZnlTVoLlN4a3ELNxdW2lrVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDUoBNUFrRJuTyYj/yyz2PkzOniIhadu3YsBI9aE3MUHwX0T8WBljrjYfBPN65SB9
         CKNwWhmeMrtcc/uiwvXDHVsHiJWaKJBzStiLQ+bPyeC3nhlXn3l2x8ygUAcjbp3W4Q
         mi9a+HKPy5dayL+rpd+KD+9o0U7MM8L4vPubgHZ8=
Date:   Mon, 23 Nov 2020 16:48:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [EXT] [PATCH 035/141] IB/qedr: Fix fall-through warnings for
 Clang
Message-ID: <20201123224813.GJ21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <8d7cf00ec3a4b27a895534e02077c2c9ed8a5f8e.1605896059.git.gustavoars@kernel.org>
 <MN2PR18MB3182F593C7A23B42A3961208A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR18MB3182F593C7A23B42A3961208A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 22, 2020 at 08:12:15PM +0000, Michal Kalderon wrote:
> > From: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Sent: Friday, November 20, 2020 8:29 PM
> > 
> > ----------------------------------------------------------------------
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning by
> > explicitly adding a break statement instead of just letting the code fall
> > through to the next case.
> > 
> > Link: https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__github.com_KSPP_linux_issues_115&d=DwIBAg&c=nKjWec2b6R0mOyP
> > az7xtfQ&r=5_8rRZTDuAS-6X-cGRU9Fo4yjCnkS1t7T3-
> > gjL4FQng&m=ZJjyam8OGRTmM8iCzOSDOL7dMn31Pmw3aA-
> > QOVDY8eg&s=4rQYW1K3xAzeRV7SRkrvaivRWz2WwEuuk0ZnjnDTA1w&e=
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/infiniband/hw/qedr/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/infiniband/hw/qedr/main.c
> > b/drivers/infiniband/hw/qedr/main.c
> > index 967641662b24..10707b451ab8 100644
> > --- a/drivers/infiniband/hw/qedr/main.c
> > +++ b/drivers/infiniband/hw/qedr/main.c
> > @@ -796,6 +796,7 @@ static void qedr_affiliated_event(void *context, u8
> > e_code, void *fw_handle)
> >  		}
> >  		xa_unlock_irqrestore(&dev->srqs, flags);
> >  		DP_NOTICE(dev, "SRQ event %d on handle %p\n", e_code,
> > srq);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > --
> > 2.27.0
> 
> Thanks, 
> 
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>

Thanks, Michal.
--
Gustavo
