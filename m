Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB358617B7
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2019 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfGGVbK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 17:31:10 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11428 "EHLO edge20.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfGGVbK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Jul 2019 17:31:10 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2019 17:31:09 EDT
Received: from mailm214.d.ethz.ch (129.132.139.38) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 7 Jul
 2019 23:24:09 +0200
Received: from ktaranov-laptop (209.17.40.23) by mailm214.d.ethz.ch
 (2001:67c:10ec:5603::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jul 2019
 23:23:34 +0200
Date:   Sun, 7 Jul 2019 23:23:31 +0200
From:   Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
To:     Yanjun Zhu <yanjun.zhu@oracle.com>
CC:     <monis@mellanox.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
Message-ID: <20190707231126.774bdd6e@ktaranov-laptop>
In-Reply-To: <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
 <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [209.17.40.23]
X-ClientProxiedBy: mailm215.d.ethz.ch (2001:67c:10ec:5603::29) To
 mailm214.d.ethz.ch (2001:67c:10ec:5603::28)
X-TM-SNTS-SMTP: 4D81165952664C1D04AE67D65F90729D56AF5BDF793DC19688AF2A16CC9E746A2000:8
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 3 Jul 2019 09:24:54 +0800
Yanjun Zhu <yanjun.zhu@oracle.com> wrote:

> On 2019/6/27 22:06, Konstantin Taranov wrote:
> > Make softRoce to calculate correct byte_len on receiving side when work completion
> > is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
> >
> > According to documentation byte_len must indicate the number of written
> > bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.  
> 
> With roce NIC, what is the byte_len? Thanks a lot.

byte_len is a field of a work completion (struct ib_uverbs_wc or struct ibv_wc). It is defined in verbs and stores
the number of written bytes to the destination memory. In case of IB_WC_RECV_RDMA_WITH_IMM
completion event, the field byte_len must store the number of written bytes for incoming
RDMA_WRITE_WITH_IMM request. 

> 
> Zhu Yanjun
> 
> >
> > The patch proposes to remember the length of an RDMA request from the RETH header, and use it
> > as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
> >
> > Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
> >   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index aca9f60f9b21..1cbfbd98eb22 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >   			qp->resp.va = reth_va(pkt);
> >   			qp->resp.rkey = reth_rkey(pkt);
> >   			qp->resp.resid = reth_len(pkt);
> > +			qp->resp.length = reth_len(pkt);
> >   		}
> >   		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
> >   						     : IB_ACCESS_REMOTE_WRITE;
> > @@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
> >   				pkt->mask & RXE_WRITE_MASK) ?
> >   					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
> >   		wc->vendor_err = 0;
> > -		wc->byte_len = wqe->dma.length - wqe->dma.resid;
> > +		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
> > +				pkt->mask & RXE_WRITE_MASK) ?
> > +					qp->resp.length : wqe->dma.length - wqe->dma.resid;
> >   
> >   		/* fields after byte_len are different between kernel and user
> >   		 * space
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > index e8be7f44e3be..28bfb3ece104 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > @@ -213,6 +213,7 @@ struct rxe_resp_info {
> >   	struct rxe_mem		*mr;
> >   	u32			resid;
> >   	u32			rkey;
> > +	u32			length;
> >   	u64			atomic_orig;
> >   
> >   	/* SRQ only */  

