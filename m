Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C294AFE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHSQ4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:56:24 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:58363 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbfHSQ4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 12:56:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 97F20180A7F8C;
        Mon, 19 Aug 2019 16:56:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:4605:5007:6119:7903:8603:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30080:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:31,LUA_SUMMARY:none
X-HE-Tag: twist55_71b833439d92c
X-Filterd-Recvd-Size: 2537
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 16:56:21 +0000 (UTC)
Message-ID: <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 09:56:20 -0700
In-Reply-To: <20190819100526.13788-1-geert@linux-m68k.org>
References: <20190819100526.13788-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2019-08-19 at 12:05 +0200, Geert Uytterhoeven wrote:
> When compiling on 32-bit:
> 
>     drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
[]
> Fix this by applying the following rules:
>   1. When printing a u64, the %llx format specififer should be used,
>      instead of casting to a pointer, and printing the latter.
>   2. When assigning a pointer to a u64, the pointer should be cast to
>      uintptr_t, not u64,
>   3. When casting from u64 to pointer, an intermediate cast to uintptr_t
>      should be added,

I think a cast to unsigned long is rather more common.

uintptr_t is used ~1300 times in the kernel.
I believe a cast to unsigned long is much more common.

It might be useful to add something to the Documentation
for this style.  Documentation/process/coding-style.rst

And trivia:

> > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
[]
> @@ -842,8 +842,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>  			rv = -EINVAL;
>  			break;
>  		}
> -		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
> -			   sqe->opcode, sqe->flags, (void *)sqe->id);
> +		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%llx\n",
> +			   sqe->opcode, sqe->flags, sqe->id);

Printing possible pointers as %llx is generally not a good idea
given the desire for %p obfuscation.


