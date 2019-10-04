Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461D3CB40C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 06:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbfJDE53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 00:57:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:28819 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387872AbfJDE53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 00:57:29 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x944vL1q032002;
        Thu, 3 Oct 2019 21:57:22 -0700
Date:   Fri, 4 Oct 2019 10:27:20 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: Re: Re: Re: [PATCH for-next] RDMA/siw: fix SQ/RQ drain logic to
 support ib_drain_qp
Message-ID: <20191004045718.GA29290@chelsio.com>
References: <20191003105112.GA20688@chelsio.com>
 <20191001174502.GB31728@chelsio.com>
 <20191001095224.GA5448@chelsio.com>
 <20190927221545.5944-1-krishna2@chelsio.com>
 <OFFA5BB431.AD96EB3F-ON00258485.0054053B-00258485.0055D206@notes.na.collabserv.com>
 <OF8E75AE75.02E5B443-ON00258486.00578402-00258486.00579818@notes.na.collabserv.com>
 <OFB95A41D1.52157F37-ON00258487.003EF8B5-00258487.003EF8F6@notes.na.collabserv.com>
 <OF2EDF2738.25C83B56-ON00258488.003E6ADE-00258488.004D3019@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2EDF2738.25C83B56-ON00258488.003E6ADE-00258488.004D3019@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, October 10/03/19, 2019 at 14:03:05 +0000, Bernard Metzler wrote:
> There are other reasons why the generic
> __ib_drain_sq() may fail. A CQ overflow is one
> such candidate. Failures are not handled by the ULP,
> since calling a void function.
The function description of ib_drain_qp() says:
 * The caller must:
 *
 * ensure there is room in the CQ(s), SQ, and RQ for drain work requests
 * and completions.
 *
 * allocate the CQs using ib_alloc_cq().
 *
 * ensure that there are no other contexts that are posting WRs
 * concurrently.
 * Otherwise the drain is not guaranteed.
 */


So, it looks like ULP has to check for available CQs before calling
ib_drain_xx(). 
> 
> At the other hand, we know that if we have reached
> ERROR state, the QP will never escape back to become
> full functional; ERROR is the QP's final state.
> 
> So we could do an extra check if we cannot get
> the state lock - if we are already in ERROR. And
> if yes, complete immediately there as well.
> 
> I can change the patch accordingly. Makes sense?
Yes, I think addressing this would make the fix complete.

Thanks,
Krishna.
