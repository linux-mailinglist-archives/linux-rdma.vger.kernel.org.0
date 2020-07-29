Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663D5232073
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgG2Odf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 10:33:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726971AbgG2Ode (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 10:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596033213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrWZeUHHAezX02B5tZbQkludP/Rhl57VOqYp9NBaRag=;
        b=Ur+MNT/8Y3AeEx9hAMNs/ptYNqDos+mSJjVeFn6/clrPpY3AyMaYOmN1YD50an/wgmp2Wu
        YXHKhguqhiLLxWIREeD++g9wMfjnmP74Y+1k0xT+UR5ZIcy2NIWzKSHQzxjwswbd3Alosf
        G9zQbZBYO1POw1FJoodZeiPmIiTNdgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-4tAlSEYsOrS_7bGFtShljw-1; Wed, 29 Jul 2020 10:33:31 -0400
X-MC-Unique: 4tAlSEYsOrS_7bGFtShljw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F7EF79EC1;
        Wed, 29 Jul 2020 14:33:30 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 683775C5B7;
        Wed, 29 Jul 2020 14:33:29 +0000 (UTC)
Date:   Wed, 29 Jul 2020 22:33:26 +0800
From:   Honggang LI <honli@redhat.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Fix RQ counting issues causing use of
 an invalid RWQE
Message-ID: <20200729143326.GA2493772@dhcp-128-72.nay.redhat.com>
References: <20200728183848.22226.29132.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728183848.22226.29132.stgit@awfm-01.aw.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 02:38:48PM -0400, Mike Marciniszyn wrote:
> The lookaside count is improperly initialized to the size of the
> Receive Queue with the additional +1.  In the traces below, the
> RQ size is 384, so the count was set to 385.
> 
> The lookaside count is then rarely refreshed.  Note the high and
> incorrect count in the trace below:
> 
> rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9008 wr_id 55c7206d75a0 qpn c
> 	qpt 2 pid 3018 num_sge 1 head 1 tail 0, count 385
> rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1
> 
> The head,tail indicate there is only one RWQE posted although the count
> says 385 and we correctly return the element 0.
> 
> The next call to rvt_get_rwqe with the decremented count:
> 
> rvt_get_rwqe: [hfi1_0] wqe ffffc900078e9058 wr_id 0 qpn c
> 	qpt 2 pid 3018 num_sge 0 head 1 tail 1, count 384
> rvt_get_rwqe: (hfi1_rc_rcv+0x4eb/0x1480 [hfi1] <- rvt_get_rwqe) ret=0x1
> 
> Note that the RQ is empty (head == tail) yet we return the RWQE at tail 1,
> which is not valid because of the bogus high count.
> 
> Best case, the RWQE has never been posted and the rc logic sees an RWQE
> that is too small (all zeros) and puts the QP into an error state.
> 
> In the worst case, a server slow at posting receive buffers might fool
> rvt_get_rwqe() into fetching an old RWQE and corrupt memory.
> 
> Fix by deleting the faulty initialization code and creating an
> inline to fetch the posted count and convert all callers to use
> new inline.
> 
> Fixes: f592ae3c999f ("IB/rdmavt: Fracture single lock used for posting and processing RWQEs")

Confirmed this patch works for me. Thanks

Tested-by: Honggang Li <honli@redhat.com>

