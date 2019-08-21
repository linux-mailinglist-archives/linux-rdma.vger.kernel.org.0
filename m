Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7D97962
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfHUMbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:31:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:52643 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUMbr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 08:31:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="378931100"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2019 05:31:45 -0700
Date:   Wed, 21 Aug 2019 20:30:22 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: why ibv_wc src_qp is zero
Message-ID: <20190821123021.GA2270@jerryopenix>
References: <20190821121436.GA1834@jerryopenix>
 <20190821122554.GA8653@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821122554.GA8653@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09:25 Wed 21 Aug, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 08:14:36PM +0800, Liu, Changcheng wrote:
> > Hi all,
> >    Does anyone know the usage of the src_qp field in struct ibv_wc?
> > 
> >    I’m using RC transport type with only Send Operation on Send Queue.
> >      On the requester side, when SQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value.
> >      On the responder side, when RQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value too.
> >    Why the ibv_wc::src_qp field is zero instead of recording the peer's qp number?
> 
> It is only supported for UD QPs

Thanks a lot for your info. I'll check it the protocol.

--Thanks
Changcheng 

> 
> Jason
