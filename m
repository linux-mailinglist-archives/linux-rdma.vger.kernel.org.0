Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F14F003A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfKEOqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfKEOqG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:46:06 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E0217F5;
        Tue,  5 Nov 2019 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572965165;
        bh=+zuRl8xHs5WYJ5yR2VLrNsKBEkP61o9K77tshM9riF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ai0f8CWusOWyyKJZVVmCRXL2eQ7MwEOhylAz2eGAjSp9Dy+bNEo6pHsM8d5KdLqZQ
         +lNZ7q4Ljs9gLp94M0QVHMoBuU4MU3t8TTF2UKZ9y3uUVvepor1CBhjddQN8iMzgHZ
         hxDf5SB4wVzLC84qPw525MZVJYXus1CdEWkhPO5o=
Date:   Tue, 5 Nov 2019 16:46:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH v2 rdma-core] cxgb4: free appropriate pointer in error
 case
Message-ID: <20191105144602.GH6763@unreal>
References: <1572870345-8629-1-git-send-email-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572870345-8629-1-git-send-email-bharat@chelsio.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 05:55:45PM +0530, Potnuri Bharat Teja wrote:
> error unmap case wrongly frees only the cqid2ptr for qp/mmid2ptr.
> This patch frees the appropriate pointer.
>
> Fixes: 9b2d3af5735e ("Query device to get the max supported stags, qps, and cqs")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> v0 -> v1:
> - add missing description
> ---
>  providers/cxgb4/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks, applied.
