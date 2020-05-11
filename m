Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4161CE351
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 20:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgEKSyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 14:54:52 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:59726 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgEKSyw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 14:54:52 -0400
Received: from localhost ([10.193.186.242])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 04BIsg6e012988;
        Mon, 11 May 2020 11:54:48 -0700
Date:   Tue, 12 May 2020 00:24:42 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/iw_cxgb4: Fix incorrect function parameters
Message-ID: <20200511185440.GA12579@chelsio.com>
References: <20200510184157.12466-1-bharat@chelsio.com>
 <20200511131135.GR26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511131135.GR26002@ziepe.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, May 05/11/20, 2020 at 18:41:35 +0530, Jason Gunthorpe wrote:
> On Mon, May 11, 2020 at 12:11:57AM +0530, Potnuri Bharat Teja wrote:
> > Fixes the incorrect function parameters passed while reading TCB fields and
> > completing cached SRQ buffers.
> 
> For a -rc fix you must explain what bad thing happens because of the
> bug
> 
My bad. This patch fixes app segfults during connection teardown when SRQ is 
used. Resending patch wit updated description.
