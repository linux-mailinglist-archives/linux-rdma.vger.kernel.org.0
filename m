Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC047196E4E
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgC2QIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 12:08:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:49464 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgC2QIa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 12:08:30 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02TG8Qck019212
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 16:08:26 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02TG8P1Q026937;
        Sun, 29 Mar 2020 16:08:25 GMT
Date:   Sun, 29 Mar 2020 16:08:25 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org, lkml@sdf.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200329160825.GA4675@SDF.ORG>
References: <202003281643.02SGh6eG002694@sdf.org>
 <20200329141710.GE20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329141710.GE20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 11:17:10AM -0300, Jason Gunthorpe wrote:
> You need to do a better job sending your patches, this is not
> threaded, and not cc'd to linux-rdma, so it doesn't show in the
> patchworks.

Indeed; mea culpa.  I forgot the magic option to git-format-patch.

Unfortunately, such things tend to get noticed only after the e-mail
has been sent and one has embarrassed oneself publicly.  :-(

> In general, do not send such large series for things that are not
> connected. Send small cleanups like this properly and directly so they
> can be applied.

They're all concpetually connected, but yes.

> I took care of it this time, so applied to the rdma tree as it is
> obviously correct.

I will drop it from my series, thank you!
