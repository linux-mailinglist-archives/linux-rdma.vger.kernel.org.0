Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAD61900
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 03:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGHBrA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 7 Jul 2019 21:47:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:17392 "EHLO edge20.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfGHBrA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Jul 2019 21:47:00 -0400
Received: from mailm214.d.ethz.ch (129.132.139.38) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 8 Jul
 2019 03:46:39 +0200
Received: from ktaranov-laptop (50.225.16.155) by mailm214.d.ethz.ch
 (2001:67c:10ec:5603::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 8 Jul 2019
 03:46:31 +0200
Date:   Mon, 8 Jul 2019 03:46:21 +0200
From:   Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
To:     Zhu Yanjun <yanjun.zhu@oracle.com>
CC:     <monis@mellanox.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Make rxe driver to calculate correct byte_len on
 receiving side when work completion is generated with
 IB_WC_RECV_RDMA_WITH_IMM opcode.
Message-ID: <20190708034621.101b25dc@ktaranov-laptop>
In-Reply-To: <a58291a3-8b04-49bf-6c10-202b8ba426ac@oracle.com>
References: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
        <d149da15-523a-438a-1550-095b4b1a840b@oracle.com>
        <20190707231126.774bdd6e@ktaranov-laptop>
        <a58291a3-8b04-49bf-6c10-202b8ba426ac@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [50.225.16.155]
X-ClientProxiedBy: mailm116.d.ethz.ch (2001:67c:10ec:5602::28) To
 mailm214.d.ethz.ch (2001:67c:10ec:5603::28)
X-TM-SNTS-SMTP: 48B72BD22EE2AFFCF3B5B174C0C3E6EEB0092AEF9701AC2500650438D8D233AC2000:8
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 8 Jul 2019 07:35:24 +0800
Zhu Yanjun <yanjun.zhu@oracle.com> wrote:

> 在 2019/7/8 5:23, Konstantin Taranov 写道:
> > On Wed, 3 Jul 2019 09:24:54 +0800
> > Yanjun Zhu <yanjun.zhu@oracle.com> wrote:
> >  
> >> On 2019/6/27 22:06, Konstantin Taranov wrote:  
> >>> Make softRoce to calculate correct byte_len on receiving side when work completion
> >>> is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
> >>>
> >>> According to documentation byte_len must indicate the number of written
> >>> bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.  
> >> With roce NIC, what is the byte_len? Thanks a lot.  
> > byte_len is a field of a work completion (struct ib_uverbs_wc or struct ibv_wc). It is defined in verbs and stores
> > the number of written bytes to the destination memory. In case of IB_WC_RECV_RDMA_WITH_IMM
> > completion event, the field byte_len must store the number of written bytes for incoming
> > RDMA_WRITE_WITH_IMM request.  
> 
> Cool. Thanks for your explanations.
> 
> The above is the test result of physical RoCE NIC?
> 
Yes. When I use physical nics, the byte_len indicates the number of received bytes.
It is also fully complies with what is written in https://www.rdmamojo.com/2013/02/15/ibv_poll_cq/ about the byte_len field.  


> Thanks.
> 
> Zhu Yanjun
> 
> >  
> >> Zhu Yanjun
> >>  
> >>> The patch proposes to remember the length of an RDMA request from the RETH header, and use it
> >>> as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.
> >>>
> >>> Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
> >>> ---
> >>>    drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
> >>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
> >>>    2 files changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> index aca9f60f9b21..1cbfbd98eb22 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> @@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >>>    			qp->resp.va = reth_va(pkt);
> >>>    			qp->resp.rkey = reth_rkey(pkt);
> >>>    			qp->resp.resid = reth_len(pkt);
> >>> +			qp->resp.length = reth_len(pkt);
> >>>    		}
> >>>    		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
> >>>    						     : IB_ACCESS_REMOTE_WRITE;
> >>> @@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
> >>>    				pkt->mask & RXE_WRITE_MASK) ?
> >>>    					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
> >>>    		wc->vendor_err = 0;
> >>> -		wc->byte_len = wqe->dma.length - wqe->dma.resid;
> >>> +		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
> >>> +				pkt->mask & RXE_WRITE_MASK) ?
> >>> +					qp->resp.length : wqe->dma.length - wqe->dma.resid;
> >>>    
> >>>    		/* fields after byte_len are different between kernel and user
> >>>    		 * space
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>> index e8be7f44e3be..28bfb3ece104 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >>> @@ -213,6 +213,7 @@ struct rxe_resp_info {
> >>>    	struct rxe_mem		*mr;
> >>>    	u32			resid;
> >>>    	u32			rkey;
> >>> +	u32			length;
> >>>    	u64			atomic_orig;
> >>>    
> >>>    	/* SRQ only */  

