Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9854E2BB20F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKTSFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:05:36 -0500
Received: from gentwo.org ([3.19.106.255]:37168 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgKTSFf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 13:05:35 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 2246D3F529; Fri, 20 Nov 2020 18:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 210FC3E9FD;
        Fri, 20 Nov 2020 18:05:35 +0000 (UTC)
Date:   Fri, 20 Nov 2020 18:05:35 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Mark Haywood <mark.haywood@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <20201117193329.GH244516@ziepe.ca>
Message-ID: <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 17 Nov 2020, Jason Gunthorpe wrote:

> If it really doesn't work at all any more we should delete it from
> rdma-core if nobody is interested to fix it.
>
> Haakon and Mark had stepped up to maintain it a while ago because they
> were using it internally, so I'm surprised to hear it is broken.

Oh great. I did not know. Will work with them to get things sorted out.

