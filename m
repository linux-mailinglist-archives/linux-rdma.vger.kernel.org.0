Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861EE37AF4D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKT25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbhEKT25 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:28:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D5B661026;
        Tue, 11 May 2021 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620761270;
        bh=rI+mHAxfG+btsGqsMuf6hMha8zHnoszPJpeNAenOTWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZT0TkeI6hzGrWXBcom5m26wY5ixzlwMLKl5BD9+8jGYjLR0oX2z567yflvpdx3xnY
         5TLLRXVhJMlPJWnz8D3r3UqUJqGEFZ0udkucUZ6oJbv4BrQ1BK7ZUqIeNolvxDT0bU
         YJUv3JKE+gPux0mOsFwYsyeo9f3kVHyL5Sh40/g/R+I0UzZD7b2t1sP5sPMkyutUoZ
         2jvtTrb4p1I5brGOgPotkzK0E+9L3O4MbkInDIjzyDE3niMGJGduw4sJBl2pg5Oy9O
         1sHWiDr+RrGHQpgpeTKpSOKNNCUYOT/L6aOh/I2vSXYZ548QrUvUhM7ZWMW+PmgHuG
         etkMdca0n8qiQ==
Date:   Tue, 11 May 2021 22:27:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YJrasoIGHQCq7QBD@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com>
 <YJp50nw6JD3ptVDp@unreal>
 <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB3816D1F9DC81BBB1FA5DF293F2539@BYAPR01MB3816.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 07:15:09PM +0000, Marciniszyn, Mike wrote:
> > >
> > > Why not kzalloc_node() here?
> 
> I agree here.
> 
> Other allocations that have been promoted to the core have lost the node attribute in the allocation.

Did you notice any performance degradation?

Thanks
