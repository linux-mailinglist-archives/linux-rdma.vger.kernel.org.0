Return-Path: <linux-rdma+bounces-13686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC0FBA65FD
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 04:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364091893966
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 02:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A18424678E;
	Sun, 28 Sep 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="svJJJBDQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E534BA3B;
	Sun, 28 Sep 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024972; cv=none; b=eNaX4K1i5uTYU/HrHFMI/2H80PsgA2glTv5NYi7mlhKRVNtUsfDfGQjKJ4R+tAolJNj8UjQHZwl52ltG4oLUKBefNiXYGmq4OGOJ9gKJYNTjWsuy9t8a6h0+qxqVciBRXUOPn8vgKpwY9ZxXTG2TdOdP02cxa+b8uDpq//FnKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024972; c=relaxed/simple;
	bh=TbE5wP/JcNnnsgJs1T+Ur/fVdp9uhNGZ5B79GwCENkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNKnd996FpRWs136E5vxjN+sVP6o0OfbAr5XIszsKwFjVMSJ5E0mPHnhUNkX4d8lzn3v0vFKYPXM7N2BvSq1EQg/DZxhUSTDqrXs3ottn4UmOpKkrlP6CnowemVuuFERl7WXUI+ep0Ir3KGVonALfJSa08w74MnqblWnpIoJO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=svJJJBDQ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759024964; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=z6EMcu+n/Cws7562CqoRQNUPXsezkRvjfC1WKL+N5wM=;
	b=svJJJBDQ8PPoR+1lW96s5j2Buxq3JWT+w/yDWGNYUWOTmjjDRmVbnA0Dw/ZXckdRhxmeexwTFLXm+GHUn9ZS2gzPdxMr2UgzGdaof7zF0QzvA3upppnkRf7bpenOMT9TRfO/KsYljp+xDlDPqi1pOk3QRoN1WpVmnQzqUqnpE70=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WowZZ-z_1759024963 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 10:02:44 +0800
Date: Sun, 28 Sep 2025 10:02:43 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aNiXQ_UfG9k-f9-n@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
 <7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
 <20250925132540.74091295.pasic@linux.ibm.com>
 <20250928005515.61a57542.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928005515.61a57542.pasic@linux.ibm.com>

On 2025-09-28 00:55:15, Halil Pasic wrote:
>On Thu, 25 Sep 2025 13:25:40 +0200
>Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> > [...]  
>> > > @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>> > >  	};
>> > >  	int rc;
>> > >  
>> > > +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
>> > > +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;    
>> > 
>> > Possibly:
>> > 
>> > 	cap = max(3 * lnk->lgr->max_send_wr, lnk->lgr->max_recv_wr);
>> > 	qp_attr.cap.max_send_wr = cap;
>> > 	qp_attr.cap.max_recv_wr = cap
>> > 
>> > to avoid assumption on `max_send_wr`, `max_recv_wr` relative values.  
>> 
>> Can you explain a little more. I'm happy to do the change, but I would
>> prefer to understand why is keeping qp_attr.cap.max_send_wr ==
>> qp_attr.cap.max_recv_wr better? But if you tell: "Just trust me!" I will.
>
>Due to a little accident we ended up having a private conversation
>on this, which I'm going to sum up quickly.
>
>Paolo stated that he has no strong preference and that I should at
>least add a comment, which I will do for v4. 
>
>Unfortunately I don't quite understand why qp_attr.cap.max_send_wr is 3
>times the number of send WR buffers we allocate. My understanding
>is that qp_attr.cap.max_send_wr is about the number of send WQEs.

We have at most 2 RDMA Write for 1 RDMA send. So 3 times is necessary.
That is explained in the original comments. Maybe it's better to keep it.

```
.cap = {
                /* include unsolicited rdma_writes as well,
                 * there are max. 2 RDMA_WRITE per 1 WR_SEND
                 */
        .max_send_wr = SMC_WR_BUF_CNT * 3,
        .max_recv_wr = SMC_WR_BUF_CNT * 3,
        .max_send_sge = SMC_IB_MAX_SEND_SGE,
        .max_recv_sge = lnk->wr_rx_sge_cnt,
        .max_inline_data = 0,
},
```

>I assume that qp_attr.cap.max_send_wr == qp_attr.cap.max_recv_wr
>is not something we would want to preserve.

IIUC, RDMA Write won't consume any RX wqe on the receive side, so I think
the .max_recv_wr can be SMC_WR_BUF_CNT if we don't use RDMA_WRITE_IMM.


Best regards,
Dust

