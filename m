Return-Path: <linux-rdma+bounces-2604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27A8CDF53
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 03:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8255B281F12
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643C79C8;
	Fri, 24 May 2024 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F6pJlbW8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6E17578
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515612; cv=none; b=i++46ftnacLZ5fQ/xQEazCY0/oEZ47WFLXivl4VKWMaRbzV8gi4PqxLAiMhlFF11tukyuhckjuTHQxYmbyyiRHapSbqzZ4evZYwvebfy9fO2m/YNC9APvkeJ7ILbnGT0K6Z4vvd2wolYZNvQcQf90KXdMVR4NrfWFj2AJRgfemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515612; c=relaxed/simple;
	bh=bPK8teCnWfQt2JdjI284T1Dvo2TtjQQsb+LRFW0KhBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhkI8SRfMcesOrWzbbh3wlvnPe6CRJbrWW9cJRbOWmvsakARexPkKxNEFaEnRNKsrKCVHspNyKtmaTOVXhv5y+rb26aeuyIgIlCMNsMgrBJ8LGxcZPH8tmORxBX3d4TSxZrkx2bzZxVIP7n7v6467fM9zwDv/GUxiRZR575Kgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F6pJlbW8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9ANMtJIKAfeBbZdxJh0GASWtWNXdgV/5BuGZZEQWDUk=;
	b=F6pJlbW805k80h7UlaSygZUUw/7rixFrXulcTv9n6Z8xu+bJk3BbAvXX4gZ6fk
	iIkQWwQ2qAYcSJurXcUBOCoLz5V0elqR8nRXSRp1C9uabwiiUzLZk7ZK4uiep/09
	UCIXCKGy51VcR65m09AmFsAt3EXIPf7DMYhhwg0MyqL+U=
Received: from localhost (unknown [183.81.182.182])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wDnj6L48k9meWYGEw--.7828S2;
	Fri, 24 May 2024 09:52:58 +0800 (CST)
Date: Fri, 24 May 2024 09:52:56 +0800
From: Honggang LI <honggangli@163.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, leon@kernel.org, rpearsonhpe@gmail.com,
	matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
Message-ID: <Zk_y-DYV_2fOSxOF@fc39>
References: <20240523094617.141148-1-honggangli@163.com>
 <593dd175-c9c8-4bd0-a1bb-a7a19d1070d1@linux.dev>
 <579a7cf1-7eb8-442f-bae7-f929cfa82dda@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579a7cf1-7eb8-442f-bae7-f929cfa82dda@linux.dev>
X-CM-TRANSID:_____wDnj6L48k9meWYGEw--.7828S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1fGr17AF13Cr1kAFyrJFb_yoW5GrWUp3
	y5ta4UKF4rXr17A3Z2v3yFqF4Yya97GF4UWF9Fq3s8Krs8ZayaqFsIgr1UWFyDAF1xWayS
	qrWqvas3Ww1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7CzNUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDxvoRWVOEGQnBgAAsH

On Thu, May 23, 2024 at 05:03:12PM +0200, Zhu Yanjun wrote:
> Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
>  packets
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> Date: Thu, 23 May 2024 17:03:12 +0200
> 
> 
> On 23.05.24 14:06, Zhu Yanjun wrote:
> > 
> > On 23.05.24 11:46, Honggang LI wrote:
> > > According to the IBA specification:
> > > If a UD request packet is detected with an invalid length, the request
> > > shall be an invalid request and it shall be silently dropped by
> > > the responder. The responder then waits for a new request packet.
> > > 
> > > commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
> > > checking")
> > > defers responder length check for UD QPs in function `copy_data`.
> > > But it introduces a regression issue for UD QPs.
> > > 
> > > When the packet size is too large to fit in the receive buffer.
> > > `copy_data` will return error code -EINVAL. Then `send_data_in`
> > > will return RESPST_ERR_MALFORMED_WQE. UD QP will transfer into
> > > ERROR state.
> > > 
> > > Fixes: 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length
> > > checking")
> > > Signed-off-by: Honggang LI <honggangli@163.com>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > index 963382f625d7..a74f29dcfdc9 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > > @@ -354,6 +354,18 @@ static enum resp_states
> > > rxe_resp_check_length(struct rxe_qp *qp,
> > >        * receive buffer later. For rmda operations additional
> > >        * length checks are performed in check_rkey.
> > >        */
> > > +    if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
> > 
> > From IBA specification:
> > 
> > "
> > 
> > QP1, used for the General Services Interface (GSI).
> > •This QP uses the Unreliable Datagram transport service.
> > •All traffic to and from this QP uses any VL other than VL15.
> > •GSI packets arriving before the current packet’s command completes may
> > be dropped (i.e. the minimum queue depth of QP1 is one).
> > 
> > "
> > 
> > GSI should be MAD packets. And it should have a fixed format. Not sure
> > if the payload of GSI packets will exceed the size of the recv buffer.

It's dangerous to trust remote GSI request packets always fit in local
receive buffer. A well-designed hostile GSI request packet can render
remote QP1 into ERROR state. That means the remote node can't establish
new RC QP connections.

Thanks


