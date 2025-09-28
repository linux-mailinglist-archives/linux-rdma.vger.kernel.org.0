Return-Path: <linux-rdma+bounces-13696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECDBA7011
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15843B0F1A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661C2DE6F8;
	Sun, 28 Sep 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hysO746P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914C3C38;
	Sun, 28 Sep 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759059788; cv=none; b=ozvRSZqr1MoAspVc1kI56VCBBaMsyzgQ6Q6n+GW3D4sNzfPMuss13ENLE0JAIzJqq2BkycDNH5brbdpmCHL1f8trm4uBp7olKL/5hh97ZRn8FMRRtOXLaIBVy4+0w5/dGA0gon9chHA9FAAQeLZVo2E3nbnD2RXq045DpxJ6Vko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759059788; c=relaxed/simple;
	bh=MjFIAl9k9tX8maWLewrIXygg9RZGYKcf7XkiGNCxuJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKCB2v7Rune2hqNGTRdJWfg1YZ0cywHTFu7dmIwhtlMZOSBsxaiWrxTT9cNyhpdWB954AZgJON7StP8wBiUOwbUGjo+YrlQkWI76QbyMKDcBfZ9LIGV7sslumUO/Dp8RTIYVncPM456sJ5/K4LYqw+0+BeCGuFp/U48gt66a6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hysO746P; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759059776; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=FbEJZn1VlIH4Up2Uzqcbz9YfXVxLvi1ttktMbwcIwhA=;
	b=hysO746P5MhOK6F3nFGQjtUJePDRaWmtP47eRL9u7y+qdAmfBl+Z5IrmUo+Gd60YSnwQCUF8h0TmSiXbk/apbdWEgZx8dpaOrVsvU+npY9xZ8BxptAywDAG4X9ch61W7J1WXU3TCMEEAlNyWTzhxZbr8Lp4a2qCqre2GynLkY24=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WoyoQGt_1759059774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 19:42:55 +0800
Date: Sun, 28 Sep 2025 19:42:54 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
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
Message-ID: <aNkfPqTyQxYTusKw@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
 <7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
 <20250925132540.74091295.pasic@linux.ibm.com>
 <20250928005515.61a57542.pasic@linux.ibm.com>
 <aNiXQ_UfG9k-f9-n@linux.alibaba.com>
 <20250928103951.6464dfd3.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250928103951.6464dfd3.pasic@linux.ibm.com>

On 2025-09-28 10:39:51, Halil Pasic wrote:
>On Sun, 28 Sep 2025 10:02:43 +0800
>Dust Li <dust.li@linux.alibaba.com> wrote:
>
>> >Unfortunately I don't quite understand why qp_attr.cap.max_send_wr is 3
>> >times the number of send WR buffers we allocate. My understanding
>> >is that qp_attr.cap.max_send_wr is about the number of send WQEs.  
>> 
>> We have at most 2 RDMA Write for 1 RDMA send. So 3 times is necessary.
>> That is explained in the original comments. Maybe it's better to keep it.
>> 
>> ```
>> .cap = {
>>                 /* include unsolicited rdma_writes as well,
>>                  * there are max. 2 RDMA_WRITE per 1 WR_SEND
>>                  */
>
>But what are "the unsolicited" rdma_writes? I have heard of
>unsolicited receive, where the data is received without
>consuming a WR previously put on the RQ on the receiving end, but
>the concept of unsolicited rdma_writes eludes me completely.

unsolicited RDMA Writes means those RDMA Writes won't generate
CQEs on the local side. You can refer to:
https://www.rdmamojo.com/2014/05/27/solicited-event/

>
>I guess what you are trying to say, and what I understand is
>that we first put the payload into the RMB of the remote, which
>may require up 2 RDMA_WRITE operations, probably because we may
>cross the end (and start) of the array that hosts the circular
>buffer, and then we send a CDC message to update the cursor.
>
>For the latter a  ib_post_send() is used in smc_wr_tx_send()
>and AFAICT it consumes a WR from wr_tx_bufs. For the former
>we consume a single wr_tx_rdmas which and each wr_tx_rdmas
>has 2 WR allocated.

Right.

>
>And all those WRs need a WQE. So I guess now I do understand
>SMC_WR_BUF_CNT, but I find the comment still confusing like
>hell because of these unsolicited rdma_writes.
>
>Thank you for the explanation! It was indeed helpful! Let
>me try to come up with a better comment -- unless somebody
>manages to explain "unsolicited rdma_writes" to me.
>
>>         .max_send_wr = SMC_WR_BUF_CNT * 3,
>>         .max_recv_wr = SMC_WR_BUF_CNT * 3,
>>         .max_send_sge = SMC_IB_MAX_SEND_SGE,
>>         .max_recv_sge = lnk->wr_rx_sge_cnt,
>>         .max_inline_data = 0,
>> },
>> ```
>> 
>> >I assume that qp_attr.cap.max_send_wr == qp_attr.cap.max_recv_wr
>> >is not something we would want to preserve.  
>> 
>> IIUC, RDMA Write won't consume any RX wqe on the receive side, so I think
>> the .max_recv_wr can be SMC_WR_BUF_CNT if we don't use RDMA_WRITE_IMM.
>
>Maybe we don't want to assume somebody else (another implementation)
>would not use immediate data. I'm not sure. But I don't quite understand
>the why the relationship between the send and the receive side either.

I missed something here. I sent an other email right after this to
explain my thoughts here:

    I kept thinking about this a bit more, and I realized that max_recv_wr
    should be larger than SMC_WR_BUF_CNT.

    Since receive WQEs are posted in a softirq context, their posting may be
    delayed. Meanwhile, the sender might already have received the TX
    completion (CQE) and continue sending new messages. In this case, if the
    receiver’s post_recv() (i.e., posting of RX WQEs) is delayed, an RNR
    (Receiver Not Ready) can easily occur.

Best regards,
Dust


