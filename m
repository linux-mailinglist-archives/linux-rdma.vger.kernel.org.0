Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88667DA5C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfHALed (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 07:34:33 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:14980 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHALed (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 07:34:33 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x71BYNvP029930;
        Thu, 1 Aug 2019 04:34:24 -0700
Date:   Thu, 1 Aug 2019 17:04:23 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     jgg@ziepe.ca, bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com
Subject: Re: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA
 message
Message-ID: <20190801113421.GA3145@chelsio.com>
References: <20190731103310.23199-1-krishna2@chelsio.com>
 <b5c1a7d76e4aaf89063c56f1437fa803e3d7ea45.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c1a7d76e4aaf89063c56f1437fa803e3d7ea45.camel@redhat.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, July 07/31/19, 2019 at 15:17:40 -0400, Doug Ledford wrote:
> On Wed, 2019-07-31 at 16:03 +0530, Krishnamraju Eraparaju wrote:
> > while processing MPA Reply, SIW driver is trying to read extra 4 bytes
> > than what peer has advertised as private data length.
> > 
> > If a FPDU data is received before even siw_recv_mpa_rr() completed
> > reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
> > read FPDU, if "size" is larger than advertised MPA reply length.
> > 
> >  501 static int siw_recv_mpa_rr(struct siw_cep *cep)
> >  502 {
> >           .............
> >  572
> >  573         if (rcvd > to_rcv)
> >  574                 return -EPROTO;   <----- Failure here
> > 
> > Looks like the intention here is to throw an ERROR if the received
> > data
> > is more than the total private data length advertised by the peer. But
> > reading beyond MPA message causes siw_cm to generate
> > RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is
> > already
> > queued with FPDU messages.
> > 
> > Hence, this function should only read upto private data length.
> > 
> > Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> 
> Once you apply this patch, the if (rcvd > to_rcv) test you listed above
> in the commit message becomes dead code.  So I removed it while applying
> the patch.  Thanks.
> 

Thanks Doug.

> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

