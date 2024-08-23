Return-Path: <linux-rdma+bounces-4499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A795C50F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C521F2550A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077B74424;
	Fri, 23 Aug 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQPaHuAL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884753E22
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392576; cv=none; b=Rbit+wEeZuHZgFc9o2WXwui3ScAE8lDyGf1V0agWO/vSZqKrdX1WmlU2k66kf2ey/0lVkXEbMNVAWb6W+2BBvla23RkG0blZccMUqfmMC2u87rqfev96j15lAa0Cq7JMwtdkkV8JwdpDsqnnxt1qHZ+8lI7/xyz1Gb9hE+7UGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392576; c=relaxed/simple;
	bh=UH/845C3CKqyzAbizs/Nu/leaga8purHzb9PP0avFys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlKUm0DVIe70NXkKZ6VU7WWpzqZqh1OO8Cq69Vz971Lq1m3fj/iTkJ5/ulCqy1HFMfvXQi3olQWzNvwiWxuzhNM+J+BWYGacAZq/A6QaOnsS3ivzJ3gxtDgaNKTHmYbzAS3ZZftieq3E8sfSHAN82ee39gn6PdJpo7k/Jf3Muy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQPaHuAL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70f73586-670e-43d0-adf4-0950a9b3940d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724392570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4VR43m38UmF4fnbqpzcLCBIxvAClHFKLB7ul2q3ync=;
	b=wQPaHuALIFdCW4qTRlYfHw74flRHn/b7xx0uFq3raDuJb2dLDad+2jdqLdaZjDCbcEAaKO
	MyVZZoIkY8I17v2cv3G4BXW/qFjDj1mGRz3xc+UIey2Tse3mHDQ0Tw2HhZx5jMlAE1QvQQ
	k7u+Svvf2DM07yq2qsH4t27rWkvK/Fg=
Date: Fri, 23 Aug 2024 13:56:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
To: zhenwei pi <pizhenwei@bytedance.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 zyjzyj2000@gmail.com, leonro@nvidia.com
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
 <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
 <20240822123649.GP3773488@nvidia.com>
 <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CABoGonKvG9AyuVPMG29b3q5bGr7ZAH5RsGg7TOtkcaAZm9F-Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/23 10:30, zhenwei pi 写道:
>
> On 8/22/24 20:36, Jason Gunthorpe wrote:
> > On Thu, Aug 22, 2024 at 07:59:32PM +0800, Zhu Yanjun wrote:
> >> 在 2024/8/22 14:52, zhenwei pi 写道:
> >>> Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
> >>> for GSI and UD.
> >>>
> >>> Signed-off-by: zhenwei pi
> >>> ---
> >>> drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
> b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> index 6596a85723c9..bf8f4bc8c5c8 100644
> >>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >>> @@ -351,7 +351,7 @@ static enum resp_states 
> rxe_resp_check_length(struct rxe_qp *qp,
> >>> for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
> >>> recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
> >>> - if (payload + 40 > recv_buffer_len) {
> >>> + if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
> >>
> >> The definition of union rdma_network_hdr is as below
> >>
> >> 797 union rdma_network_hdr {
> >> 798 struct ib_grh ibgrh;
> >> 799 struct {
> >> 800 /* The IB spec states that if it's IPv4, the header
> >> 801 * is located in the last 20 bytes of the header.
> >> 802 */
> >> 803 u8 reserved[20];
> >> 804 struct iphdr roce4grh;
> >> 805 };
> >> 806 };
> >>
> >> The length is 40 byte.
> >
> > This looks like the right struct to me if this is talking about the
> > special 40 byte blob that is placed in front of UD verbs completions.
> >
> > Jason
>
> Yes, this is the front part(40 bytes) of UD/GSI verbs completion.
>
When running, you can print the value of the front part (40 bytes) of 
UD/GSI to confirm that these 40 bytes are the union rdma_network_hdr.

If these 40 bytes are the union rdma_network_hdr,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Best Regards,

Zhu Yanjun

>
> -- 
> zhenwei pi
>
-- 
Best Regards,
Yanjun.Zhu


