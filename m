Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33933307687
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhA1MzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 07:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhA1MzF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Jan 2021 07:55:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAB1564DE1;
        Thu, 28 Jan 2021 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611838465;
        bh=JnUgwAt4QABQVihSvMlCWe0F7R+ypLgdKh2LX3kaBTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFgrQjU/lpB45ydhEsdDqp+cGFq/V+aYJwObwDrI7haLetaKRTCEswMpTBxypvYYM
         z2NSr+UyeCBEgDmKPh9s9VkJQqExeGJsKYsNTyB+mjcrw7D2Mz5CVZhsmmWwsanmzu
         gv+dgh1e581g+sKq0mG42+kwNO2msuxdK+vAtuWKkV4PkqZWEOdZDupUanwyPUhYBc
         y60pAvV9Z0uUunWgJ42nmXKKPbB/RifExU8ptGubZ2L/yYMQj7gvVusgoiA4kNw6NZ
         QV2KcgcV7Rtaeas+gesFxojN7DcKqTxf4ht65ladhkdUrbgbYTR+WbN7DbSL7O+1zp
         TgNTldYPzNTNw==
Date:   Thu, 28 Jan 2021 14:54:21 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Message-ID: <20210128125421.GC5097@unreal>
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal>
 <601259D7.1040207@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601259D7.1040207@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 02:29:43PM +0800, Xiao Yang wrote:
> On 2021/1/27 20:04, Leon Romanovsky wrote:
> > On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
> > > Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
> > > module cannot set imm_data in WC when the related WR with imm_data
> > > finished on SQ.
> > >
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > ---
> > >
> > > Current rxe module and other rdma modules(e.g. mlx5) only set
> > > imm_data in WC when the related WR with imm_data finished on RQ.
> > > I am not sure if it is a expected behavior.
> > This is IBTA behavior.
> >
> > 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
> > "Immediate Data (ImmDt) contains data that is placed in the receive
> >   Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
> >   RDMA WRITE packets with Immediate Data."
> >
> > If I understand the spec, you shouldn't set imm_data in SQ.
> Hi Leon,
>
> About the behavior, I have another question:
> For send operation with imm_data, we can verify if the delivered imm_data is
> correct by CQE on RQ.
> For rdma write operation with imm_data, how to verify if the delivered
> imm_data is correct? :-)

Probably that I didn't understand the question, but the RDMA WRITE is
marked with special opcode in the BTH that indicates imm_data.

Thanks

>
> Best Regards,
> Xiao Yang
> > Thanks
> >
> >
> > .
> >
>
>
>
