Return-Path: <linux-rdma+bounces-13635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448CB9D56D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 05:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2499384D3F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641742E6CCB;
	Thu, 25 Sep 2025 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sOV4m1lm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C7DF49;
	Thu, 25 Sep 2025 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772464; cv=none; b=t2ZAIHwORIayvdxJepiqtxjr3WBgaJe6TduxkkMXk1Fr7PbLEf8DxVCs8+rGLaHD2Ugy2T6SOqm4NkPbObGF9Y2OJjVl44l6P7dAkPR4nzk+kCRsh4x0aE9Qbw1O8oJ2Ag3juRhkeZ5k7DCV8sTntiJMg78Hzn2lqtQI8SdCuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772464; c=relaxed/simple;
	bh=nGIho2dwWkohzWHCgUzJMDybe+bcnDzqaHkwa/e4A9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWESuRnUOCSMWdH7FqKggE9j3i1Y0AZn5UXmAqg7lW2V9AgwhlJNaa7y3etjGzZIA2qZPHM1HXtUcrVyJDg0nhlkXB8An506/EmuXoNnVEe2Is8Vf9Bhwirb5RKY26MG6QWbz78Xv4frUgeS/uAH7Vb4Qx24VS/oPrkUUk6r4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sOV4m1lm; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758772452; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wsAuT+Pm1Q6WqoYdsP5p4PwG0In8tq3ybZz3jyVwdSY=;
	b=sOV4m1lmNcVYY39ybrDgVqE1HUTpFS/XIZFBra2nuz+VWmqI/fMQwWKR4PXBZXrwaVSSp0r2kU/sCd22ZAHE5pcWZERf4DTrzQNr8NUQ1C7vKFvNzfWpo1ZOIS2X9Roi56SFbCNOzu97aety7vsI0oRcDtnFeYxzxKVDNBdN6wA=
Received: from 30.221.116.42(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Wom3gRQ_1758772127 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 11:48:47 +0800
Message-ID: <2aced457-5f1e-4c1a-b5ea-035240f73aaf@linux.alibaba.com>
Date: Thu, 25 Sep 2025 11:48:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/smc: make wr buffer count
 configurable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dust Li <dust.li@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
 <20250908220150.3329433-2-pasic@linux.ibm.com>
 <aL-YYoYRsFiajiPW@linux.alibaba.com>
 <20250909121850.2635894a.pasic@linux.ibm.com>
 <20250919165549.7bebfbc3.pasic@linux.ibm.com>
 <06a87a92-6cce-4a63-99d0-463a1d035478@linux.alibaba.com>
 <20250924115010.38d2f3cb.pasic@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250924115010.38d2f3cb.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/9/24 17:50, Halil Pasic 写道:
> On Wed, 24 Sep 2025 11:13:05 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> 在 2025/9/19 22:55, Halil Pasic 写道:
>>> On Tue, 9 Sep 2025 12:18:50 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>
>>>
>>> Can maybe Wen Gu and  Guangguan Wang chime in. From what I read
>>> link->wr_rx_buflen can be either SMC_WR_BUF_SIZE that is 48 in which
>>> case it does not matter, or SMC_WR_BUF_V2_SIZE that is 8192, if
>>> !smc_link_shared_v2_rxbuf(lnk) i.e. max_recv_sge == 1. So we talk
>>> about roughly a factor of 170 here. For a large pref_recv_wr the
>>> back of logic is still there to save us but I really would not say that
>>> this is how this is intended to work.
>>>   
>>
>> Hi Halil,
>>
>> I think the root cause of the problem this patchset try to solve is a mismatch
>> between SMC_WR_BUF_CNT and the max_conns per lgr(which value is 255). Furthermore,
>> I believe that value 255 of the max_conns per lgr is not an optimal value, as too
>> few connections lead to a waste of memory and too many connections lead to I/O queuing
>> within a single QP(every WR post_send to a single QP will initiate and complete in sequence).
>>
>> We actually identified this problem long ago. In Alibaba Cloud Linux distribution, we have
>> changed SMC_WR_BUF_CNT to 64 and reduced max_conns per lgr to 32(for SMC-R V2.1). This
>> configuration has worked well under various workflow for a long time.
>>
>> SMC-R V2.1 already support negotiation of the max_conns per lgr. Simply change the value of
>> the macro SMC_CONN_PER_LGR_PREFER can influence the negotiation result. But SMC-R V1.0 and SMC-R
>> v2.0 do not support the negotiation of the max_conns per lgr.
>> I think it is better to reduce SMC_CONN_PER_LGR_PREFER for SMC-R V2.1. But for SMC-R V1.0 and
>> SMC-R V2.0, I do not have any good idea.
>>
> 
> I agree, the number of WR buffers and the max number of connections per
> lgr can an should be tuned in concert.
> 
>>> Maybe not supporting V2 on devices with max_recv_sge is a better choice,
>>> assuming that a maximal V2 LLC msg needs to fit each and every receive
>>> WR buffer. Which seems to be the case based on 27ef6a9981fe ("net/smc:
>>> support SMC-R V2 for rdma devices with max_recv_sge equals to 1").
>>>  
>>
>> For rdma dev whose max_recv_sge is 1, as metioned in the commit log in the related patch,
>> it is better to support than SMC_CLC_DECL_INTERR fallback, as SMC_CLC_DECL_INTERR fallback
>> is not a fast fallback, and may heavily influence the efficiency of the connecting process
>> in both the server and client side.
> 
> I mean another possible mitigation of the problem can be the following,
> if there is a device in the mix with max_recv_sge < 2 the don't propose/
> accept SMCR-V2. 
> 
> Do you know how prevalent and relevant are max_recv_sge < 2 RDMA
> devices, and how likely is it that somebody would like to use SMC-R with
> such devices?
> 

eRDMA in Alibaba Cloud is max_recv_sge < 2, and it is the RDMA device we are primarily focusing on.
eRDMA prefer works on SMC-R V2.1, is it possible that supported in SMC-R V2.1 but not in V2.0? 

>>
>>  
>>> For me the best course of action seems to be to send a V3 using
>>> link->wr_rx_buflen. I'm really not that knowledgeable about RDMA or
>>> the SMC-R protocol, but I'm happy to be part of the discussion on this
>>> matter.
>>>
>>> Regards,
>>> Halil  
>>
>> And a tiny suggestion for the risk you mentioned in commit log
>> ("Addressing this by simply bumping SMC_WR_BUF_CNT to 256 was deemed
>> risky, because the large-ish physically continuous allocation could fail
>> and lead to TCP fall-backs."). Non-physically continuous allocation (vmalloc/vzalloc .etc.) is
>> also supported for wr buffers. SMC-R snd_buf and rmb have already supported for non-physically
>> continuous memory, when sysctl_smcr_buf_type is set to SMCR_VIRT_CONT_BUFS or SMCR_MIXED_BUFS.
>> It can be an example of using non-physically continuous memory.
>>
> 
> I think we can put this on the list of possible enhancements. I would
> perfer to not add this to the scope of this series. But I would be happy to
> see this happen. Don't know know if somebody form Alibaba, or maybe
> Mahanta or Sid would like to pick this up as an enhancement on top.
> > Thank you very much for for your comments!
> 
> Regards,
> Halil 


