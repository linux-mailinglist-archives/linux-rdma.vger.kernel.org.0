Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0189056B
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHPQGv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 12:06:51 -0400
Received: from fieldses.org ([173.255.197.46]:35722 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfHPQGv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 12:06:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 234D21E67; Fri, 16 Aug 2019 12:06:51 -0400 (EDT)
Date:   Fri, 16 Aug 2019 12:06:51 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] NFS/RDMA-related NFSD patches for -next
Message-ID: <20190816160651.GB4234@fieldses.org>
References: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
 <BFF3E871-D4B1-4692-A39B-B693BFE85899@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFF3E871-D4B1-4692-A39B-B693BFE85899@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 11:55:29AM -0400, Chuck Lever wrote:
> Would you consider these for v5.4?

Apologies, I can't find these in my mail anywhere, for some
reason--would you mind resending?

--b.

> 
> 
> > On Jul 23, 2019, at 3:20 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > 
> > Hi-
> > 
> > Two server side patches for NFSD. Both are minor.
> > 
> > ---
> > 
> > Chuck Lever (2):
> >      svcrdma: Remove svc_rdma_wq
> >      svcrdma: Use llist for managing cache of recv_ctxts
> > 
> > 
> > include/linux/sunrpc/svc_rdma.h          |    6 +++---
> > net/sunrpc/xprtrdma/svc_rdma.c           |    7 -------
> > net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   24 ++++++++++--------------
> > net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 +++---
> > 4 files changed, 16 insertions(+), 27 deletions(-)
> > 
> > --
> > Chuck Lever
