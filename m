Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0BC97F1C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHUPkK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 11:40:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:50679 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfHUPkJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 11:40:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 08:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196020967"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 08:40:07 -0700
Date:   Wed, 21 Aug 2019 23:38:44 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: CX314A WCE error: WR_FLUSH_ERR
Message-ID: <20190821153844.GA4545@jerryopenix>
References: <20190821120912.GA1672@jerryopenix>
 <6aed3f75-2445-eb6f-0bd8-7c79ea4a0967@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aed3f75-2445-eb6f-0bd8-7c79ea4a0967@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09:36 Wed 21 Aug, Tom Talpey wrote:
> On 8/21/2019 8:09 AM, Liu, Changcheng wrote:
> > Hi all,
> >     In one system, it always frequently hit "IBV_WC_WR_FLUSH_ERR" in the WCE(work completion element) polled from completion queue bound with RQ(Receive Queue).
> >     Does anyone has some idea to debug "IBV_WC_WR_FLUSH_ERR" problem?
> > 
> >     With CX314A/40Gb NIC, I hit this error when using RC transport type with only Send Operation(IBV_WR_SEND) WR(work request) on SQ(Send Queue).
> >     Every WR only has one SGE(scatter/gather element) and all the SGE on RQ has the same size. The SGE size in SQ WR is not greater than the SGE size in RQ WR.
> > 
> >    There’s one explanation about IBV_WC_WR_FLUSH_ERR on page 114 in the "RDMA Aware Networks Programming User Manual" http://www.mellanox.com/related-docs/prod_software/RDMA_Aware_Programming_user_manual.pdf
> >    But I still didn't understand it well. How to trigger this error with a short demo program?
> >    "
> >      IBV_WC_WR_FLUSH_ERR
> >      This event is generated when an invalid remote error is thrown when the responder detects an
> >      invalid request. It may be that the operation is not supported by the request queue or there is
> >      insufficient buffer space to receive the request.
> >    "
> 
> The most common reason for a flushed work request is loss of
> the connection to the remote peer. This can be caused by any
> number of conditions.
Good diretion. I'll debug it in this way first.
> 
> The second-most common is a programming error in the upper
> layer protocol. A shortage of posted receives on either peer,
> a protection error on some buffer, etc.
Do you mean the protection key such as l_key/r_key isn't set well?
What's kind of protection error could trigger IBV_WC_WR_FLUSH_ERR?
> 
> If you're looking to actually trigger this error for testing,
> well, try one of the above. If you're trying to figure out
> why it's happening, that can take some digging, but not in
> the RDMA stack, typically.
Many thanks.

--Changcheng
> 
> Tom.
> 
