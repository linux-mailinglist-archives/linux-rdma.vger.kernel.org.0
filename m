Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C059305AD6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 13:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhA0MHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 07:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237506AbhA0MFL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 07:05:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F18920770;
        Wed, 27 Jan 2021 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611749071;
        bh=0ROzRDenijzaPjybHW5ef1TiTWTtcj7q/+Nzk38dp5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQIb0CuMIHwtGxoFLebApODduwL/5z+3dJRcz0AH0gIkaOsHaiebZzYXpgv+7AR7f
         bm0CT3syPoQ7lFjIJtiQKfzd2FK27DIuVknB+ZtfOKhSgpEeaY0aI3XNDliaRqGJ4o
         /r+RPWKRvv+FICm+h0KcZiNFJAAmN916eZi/Si6GQ9Iv5FbVBEARIc63QclWfEmk4f
         EswX/wNsfa3EDIyAiIqDl1Tb0xV65+hF9XSXHlk9WenzEepySWKPLzbEIHB+AvNfub
         C+p32o9B7U9eogHssoS+svlkird1jwvjxSLg7Gmlhu4iEN1G+rXjLa6mlHE7UBQpQS
         1KZKq7OFNP8kw==
Date:   Wed, 27 Jan 2021 14:04:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Message-ID: <20210127120427.GJ1053290@unreal>
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
> module cannot set imm_data in WC when the related WR with imm_data
> finished on SQ.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>
> Current rxe module and other rdma modules(e.g. mlx5) only set
> imm_data in WC when the related WR with imm_data finished on RQ.
> I am not sure if it is a expected behavior.

This is IBTA behavior.

5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
"Immediate Data (ImmDt) contains data that is placed in the receive
 Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
 RDMA WRITE packets with Immediate Data."

If I understand the spec, you shouldn't set imm_data in SQ.

Thanks
