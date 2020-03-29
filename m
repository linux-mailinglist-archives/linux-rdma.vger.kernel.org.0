Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1340C197056
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgC2UpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 16:45:21 -0400
Received: from mx.sdf.org ([205.166.94.20]:50317 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgC2UpV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 16:45:21 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TKj3GP003334
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 20:45:04 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TKj23i004239;
        Sun, 29 Mar 2020 20:45:02 GMT
Date:   Sun, 29 Mar 2020 20:45:01 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
Message-ID: <20200329204501.GF4675@SDF.ORG>
References: <202003281643.02SGhN9T020186@sdf.org>
 <OF05D43316.2F69D46F-ON0025853A.00513FE8-0025853A.00528B66@notes.na.collabserv.com>
 <20200329165204.GC4675@SDF.ORG>
 <20200329200213.GG20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329200213.GG20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 05:02:13PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 29, 2020 at 04:52:04PM +0000, George Spelvin wrote:

>> Many intra-machine networks (like infiniband) are specifically not 
>> designed to be robust in the face of malicious actors on the network.
> 
> This is not really true at all..

Eep, this came out wrong!  Let me clarify:

Many intra-machine networks like SCSI, LPC, HyperTransport, QuickPath,
and I2C are specifically not designed to be robust in the face of malicious
actors on the network/bus.

I don't know, *and was wondering*, whether this is true of Infiniband.

Does that make more sense?
