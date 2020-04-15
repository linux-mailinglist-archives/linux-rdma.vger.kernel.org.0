Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01251AA23D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370526AbgDOMwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 08:52:16 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:10881 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370522AbgDOMwP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Apr 2020 08:52:15 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 03FCq5Qk006916;
        Wed, 15 Apr 2020 05:52:06 -0700
Date:   Wed, 15 Apr 2020 18:22:05 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
Message-ID: <20200415125203.GA8720@chelsio.com>
References: <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard Metzler wrote:
> >At present, Chelsio T6 adapter could understand upto 16KB large FPDU
> >size, max.
> >
> That's interesting and would already better the performance for
> siw <-> hardware iwarp substantially I guess. Did you try that?
Yes I see almost 3x perfromace gain when GSO is enabled.
That is, on a siw<->T6 setup, with 1500 MTU size:
GSO disabled: ~25Gbps
GSO enabled:  ~72Gbps
