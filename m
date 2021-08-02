Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124193DDE2A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhHBQ7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 12:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhHBQ7L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 12:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4926610A8;
        Mon,  2 Aug 2021 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627923541;
        bh=N3uOJYW/01wm8sIuPFeC7afosepa4RKkuou8caMpcuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBglvETZ67PswjSJC7fBEgCR8Ig5kv8on4gs3S4UeraUdHvvAWH1Y7cFO1zL6u5Ry
         UHPK5NlN8r52Pga+x9coU15RQx/DYGIh4VuxE1/ouCI0ZOZzEcx153kGtZsCC1JVqF
         6u+ZHpvn3UYUU81BMsf/PFGC+X9uvh9YCwSrg8adkiNZ7Y8n2tLVXQrCUfE194vhEZ
         vCip5r4hGzSsf6qZpEyHwDOBk0DGL9wIlMEjWegQjMzmMwqahFDBV+3HerNGGfNghw
         2NVQcciwsRvJit9gbuQbZ+Lj77CYAAX5ifCy2g8CyBnCv0A/2aI+F35Uf9/iWhTtHf
         GV1gNohsvVxVA==
Date:   Mon, 2 Aug 2021 19:58:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: help with "PSN sequence error" in Ubuntu 20.04 (using CX-4 or
 CX-6 mellanox cards)
Message-ID: <YQgkUDawCHSYyau5@unreal>
References: <CAN-5tyEiv0-Mjfq5aSpzURjAx4Uu=ydobZCQ-rKFTOUDTapo+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyEiv0-Mjfq5aSpzURjAx4Uu=ydobZCQ-rKFTOUDTapo+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 11:37:06AM -0400, Olga Kornievskaia wrote:
> Hi folks,
> 
> We are encountering an error condition (while doing NFSoRDMA) but the
> problem seems to be in the RDMA core itself. The problem is that the
> client at some point is ending in an RDMA NAK with "PNS Sequence
> error" but the network trace shows all the PSNs are accounted for
> (snippet at the bottom). It's as if the client lost its knowledge of
> the current PSN.
> 
> Questions:
> 1. Is PSN handling done by the hardware card itself (in firmware) and
> not in the kernel (making this a card/firmware specific problem)? I
> was trying to look thru the rdma core/mlx5 driver code to see what
> would generate a NAK with such error but wasn't able to find one. Only
> found counters for nak_seq_error which made me think this is a
> firmware problem.

The decisions what is valid or not are done in the FW, kernel doesn't
check anything. Although, the kernel sets/gets next_send_psn/next_recv_psn.

Thanks
