Return-Path: <linux-rdma+bounces-13113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDDB45A4D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A1A5A7EA2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DD370586;
	Fri,  5 Sep 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="erpJX7YK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D917F4F6;
	Fri,  5 Sep 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082175; cv=none; b=rpbjJFtIb7cdUhO3Z3Ub6IBbIanAtQi9F1/z5dmC+Zmh44ZfzB62Otb9H7a5esxi1fXO1ES6p5cD6eI+0gJ9LwJ9pIpfwRSRgm873tkhlxCckznYHnH9EM2QBR6x+ujjjeGkn7cwNgn3634kfrEilF+i4Q3jFfwWfOJLhSG0uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082175; c=relaxed/simple;
	bh=iXh+Bl38X2EaiStHRHcv6FcU/gmGdvpDqsCf2aQDgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnh5RsnOx9vyQ8zWy5+vloxSySnSPfboCBWaEFvBRQVec/coS08Kz9hi561BOhxZzr+RO4t9B/GPoqb/2Ip4h+9E/Xa9Fjvo62H6B/a/+nWcWnzYKcdlg4187GUIO0MfL/u60j967AqfKC/b2QAXYnJtxLF4+3IfSQ/rU0Hh0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=erpJX7YK; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757082169; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=i7lSBQn9bunxBXeDCEhWwLI2E33KOvXQC3PG7TrCbjM=;
	b=erpJX7YKlVMM64riye+FXAp9AmhNiyX03RveTN0mK2VNHkmrxQwtkALkZHt8hQxcSXjy5GnvCusr83srNkcYYH89FgCBWl2iGvMcXaoHbVs7InGRMGUGHaLv0+cojKRliDhQf/cLe2cQa0QfjqRKEQ8++PhZgWcsHn6XVPiwlY4=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WnKtX9o_1757082168 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 22:22:48 +0800
Date: Fri, 5 Sep 2025 22:22:48 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Message-ID: <aLryOL-fahUINVg0@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
 <20250904211254.1057445-2-pasic@linux.ibm.com>
 <aLpc4H_rHkHRu0nQ@linux.alibaba.com>
 <20250905110059.450da664.pasic@linux.ibm.com>
 <20250905140135.2487a99f.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905140135.2487a99f.pasic@linux.ibm.com>

On 2025-09-05 14:01:35, Halil Pasic wrote:
>On Fri, 5 Sep 2025 11:00:59 +0200
>Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> > 1. What if the two sides have different max_send_wr/max_recv_wr configurations?
>> > IIUC, For example, if the client sets max_send_wr to 64, but the server sets
>> > max_recv_wr to 16, the client might overflow the server's QP receive
>> > queue, potentially causing an RNR (Receiver Not Ready) error.  
>>
>> I don't think the 16 is spec-ed anywhere and if the client and the server
>> need to agree on the same value it should either be speced, or a
>> protocol mechanism for negotiating it needs to exist. So what is your
>> take on this as an SMC maintainer?

Right — I didn't realize that either until I saw this patch today :)
But since the implementation's been set to 16 since day one, bumping it
up might break things.

>>
>> I think, we have tested heterogeneous setups and didn't see any grave
>> issues. But let me please do a follow up on this. Maybe the other
>> maintainers can chime in as well.

I'm glad to hear from others.

>
>Did some research and some thinking. Are you concerned about a
>performance regression for e.g. 64 -> 16 compared to 16 -> 16? According
>to my current understanding the RNR must not lead to a catastrophic
>failure, but the RDMA/IB stack is supposed to handle that.

No, it's not just a performance regression.
If we get an RNR when going from 64 -> 16, the whole link group gets
torn down — and all SMC connections inside it break.
So from the user’s point of view, connections will just randomly drop
out of nowhere.

>
>I would like to also point out that bumping SMC_WR_BUF_CNT basically has
>the same problem, although admittedly to a smaller extent because it is
>only between "old" and "new".

Right.

>
>Assuming that my understanding is correct, I believe that the problem of
>the potential RNR is inherent to the objective of the series, and
>probably one that can be lived with. Given this entire EID business, I
>think the SMC-R setup is likely to happen in a coordinated fashion for
>all potential peers, and I hope whoever tweaks those values has a
>sufficent understanding or empiric evidence to justify the tweaks.
>
>Assuming my understanding is not utterly wrong, I would very much like
>to know what would you want me to do with this?

In my opinion, the best way to support different SMC_WR_BUF_CNT values
is: First, define it in the spec - then do a handshake to agree on the
value.
If the peer doesn’t support this feature, just fall back to 16.
If both sides support it, use the smaller (MIN) of the two values.

Best regards,
Dust


