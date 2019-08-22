Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8076F997A4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfHVPDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:03:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:63532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfHVPDT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:03:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 08:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="186595013"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2019 08:03:17 -0700
Date:   Thu, 22 Aug 2019 23:01:54 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Doug Ledford <dledford@redhat.com>, tom@talpey.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: CX314A WCE error: WR_FLUSH_ERR
Message-ID: <20190822150154.GA27163@jerryopenix>
References: <20190821120912.GA1672@jerryopenix>
 <6aed3f75-2445-eb6f-0bd8-7c79ea4a0967@talpey.com>
 <20190821153844.GA4545@jerryopenix>
 <0ce34055454c68cf9089e9e742b04397419a6309.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ce34055454c68cf9089e9e742b04397419a6309.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Doug Ledford & Tom. I've found that QP is force switched into
Error status to flush outstandting WQEs into CQ with WR_FLUSH_ERR
status.

On 14:47 Wed 21 Aug, Doug Ledford wrote:
> On Wed, 2019-08-21 at 23:38 +0800, Liu, Changcheng wrote:
> > On 09:36 Wed 21 Aug, Tom Talpey wrote:
> > > On 8/21/2019 8:09 AM, Liu, Changcheng wrote:
> > > > Hi all,
> > > >     In one system, it always frequently hit "IBV_WC_WR_FLUSH_ERR"
> > > > in the WCE(work completion element) polled from completion queue
> > > > bound with RQ(Receive Queue).
> > > >     Does anyone has some idea to debug "IBV_WC_WR_FLUSH_ERR"
> > > > problem?
> > > > 
> > > >     With CX314A/40Gb NIC, I hit this error when using RC transport
> > > > type with only Send Operation(IBV_WR_SEND) WR(work request) on
> > > > SQ(Send Queue).
> > > >     Every WR only has one SGE(scatter/gather element) and all the
> > > > SGE on RQ has the same size. The SGE size in SQ WR is not greater
> > > > than the SGE size in RQ WR.
> > > > 
> > > >    There’s one explanation about IBV_WC_WR_FLUSH_ERR on page 114
> > > > in the "RDMA Aware Networks Programming User Manual" 
> > > > http://www.mellanox.com/related-docs/prod_software/RDMA_Aware_Programming_user_manual.pdf
> > > >    But I still didn't understand it well. How to trigger this
> > > > error with a short demo program?
> > > >    "
> > > >      IBV_WC_WR_FLUSH_ERR
> > > >      This event is generated when an invalid remote error is
> > > > thrown when the responder detects an
> > > >      invalid request. It may be that the operation is not
> > > > supported by the request queue or there is
> > > >      insufficient buffer space to receive the request.
> > > >    "
> > > 
> > > The most common reason for a flushed work request is loss of
> > > the connection to the remote peer. This can be caused by any
> > > number of conditions.
> > Good diretion. I'll debug it in this way first.
> > > The second-most common is a programming error in the upper
> > > layer protocol. A shortage of posted receives on either peer,
> > > a protection error on some buffer, etc.
> > Do you mean the protection key such as l_key/r_key isn't set well?
> > What's kind of protection error could trigger IBV_WC_WR_FLUSH_ERR?
> 
> FLUSH_ERR is the error used whenever a queue pair goes into an error
> state and there are still WQEs posted to the queue pair.  All
> outstanding WQEs are returned with the state IBV_WC_WR_FLUSH_ERR.  This
> is how you make sure you don't loose WQEs when the QP hits an error
> state.  So, literally *anything* that can cause a QP to go into an ERROR
> state will result in all WQEs currently posted to the QP being sent back
> with this FLUSH_ERR.  FLUSH_ERR literally just means that the card is
> flushing out the QP's work queue because now that the QP is in an error
> state it can't process the WQEs and, presumably, the application needs
> to know which ones completed and which ones didn't so it knows what to
> requeue once the QP is no longer in an error state.
> 
> As Tom has already pointed out, all of these things will throw the queue
> pair into an error state and cause all posted WQEs to be flushed with
> the FLUSH_ERR condition:
> 
> 1) Loss of queue pair connection
> 2) Any memory permission violation (attempt to write to read only
> memory, attempt to RDMA read/write to an invalid rkey, etc)
> 3) Receipt of any post_send message without a waiting post_recv buffer
> to accept the message
> 4) Receipt of a post_send message that is too large to fit in the first
> available post_recv buffer
> 
> A common cause of this sort of thing is when you don't do proper flow
> control on the queue pair and the sending side floods the receiving side
> and runs it out of posted recv WQEs.  Although, in your case, you did
> say this was happening on the receive queue, so that implies this is
> happening on the receiving side, so if that is what's happenining here,
> the process would have to be something like:
> 
> sender starts sending data (maybe without any flow control)
> 	receiver starts receiving data and refilling buffers
> 	...
> 	receiver runs totally dry of buffers and gets an incoming recv
> 	causing qp to go into error state
> 
> 	receiver then posts refill buffers to the RQ after the QP
> 	went into error state but before acknowledging the error state
> 	and shutting down the recv processing thread
> 
> 	all recv buffers posted as WQEs are flushed back to the process
> 	with FLUSH_ERR because they were posted to a QP in ERROR state
> 
> > > If you're looking to actually trigger this error for testing,
> > > well, try one of the above. If you're trying to figure out
> > > why it's happening, that can take some digging, but not in
> > > the RDMA stack, typically.
> > Many thanks.
> > 
> > --Changcheng
> > > Tom.
> > > 
> 
> -- 
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


