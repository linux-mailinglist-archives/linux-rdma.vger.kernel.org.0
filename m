Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5713D8C9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgAPLPm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 06:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgAPLPm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 06:15:42 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4CA2072B;
        Thu, 16 Jan 2020 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579173341;
        bh=oK+Fu2D+nIK8zD3hKNrHzyMz2PhnQGsKTg/aLtV3khs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wW+m1fd3lUcCAmJEVUt2/1zXn4ADMOoGCqJ2ELl52em5Pq/al5HsbV/KU7GfqO9IX
         dxlwETpAjBqPiybPx3eIUOaOwW5EbngC29cJOWDNfF66TYfELbr6esk8XT04OzH/3n
         9dRpu6/YrX7lXcrPg4CattDjDTBSK5AseQBvkAUU=
Date:   Thu, 16 Jan 2020 13:15:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, shiraz.saleem@intel.com,
        aditr@vmware.com, mkalderon@marvell.com, aelior@marvell.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH RFC for-next 0/6] ofed support to send ib port link event
Message-ID: <20200116111537.GC6853@unreal>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 12:10:41PM +0800, Weihang Li wrote:
> Some provider's driver has supported to send port link event to ofed, but

How is "ofed" related here?
