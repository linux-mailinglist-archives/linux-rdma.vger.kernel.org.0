Return-Path: <linux-rdma+bounces-14885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0215CA31CF
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B5B1300ADB4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B172F0690;
	Thu,  4 Dec 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="YcotR04e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276B22B8CB;
	Thu,  4 Dec 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842267; cv=none; b=I0FY7BaI7S3HDWSySleOvm+w3trneSj8hLj8zXx27rmf5BzWUOr1qavmVXXVpDzoZ+F+8a5fJDrCYEJIgPSbn68TIrfb4TvpSGQ3vhUoFTrzm3u8OdOB5lSN/M9FXcGaI+UIRCzCKgpMhMgxOHu1jysTAwvM07WOKsQaw+chozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842267; c=relaxed/simple;
	bh=RP2/TcAPEfeq4WzrulpBLFirsQxt32tm7LM+EvKZRDs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HjCuUbf/9pN6d9X363mTrV1qGKX9adreKvVI+cQ7ncyEEQvWoNtQGpy5fQuFmQU8c10zErcHBLq37B4245/vD/WJFB+lezVmMsMpHatWnF+47De3KM+z3dDwbsbKvIbNWrrvEgCUEuMjU3garTzFvIOmDC4RWehl6GPFStSWgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=YcotR04e; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=qgDVriAK4brRgh1Ixyxvn6fh177n/JbDrh9Ai0wqwyg=; b=YcotR04e+an1xprYJeWSfA91f4
	6y5RloSUd+QoxE1DZaUn279VQ5daFsuGElA0y73tPKwHM5B7J6CF7bcOnkl+eRsSODuu6BEyv/1ti
	BzPafnrBLAOvRe1ZxiQ1lrybn6+Kjbi+UELV2H1AP72YZlFqM2IGOGojxRmsHErJMgn6/QcWq1v4L
	z8aVBHV9RFHwNdKYLwqn+hjcVBM9HaWDAuWGu/sU47nVeo3C4/SuRE/qYIh+i6JjoCLfD4U3Abpkp
	efr6Gl8hUSBPMZw+4asVzgqsB9geGEjKqeJaXqwQm3v/MgOv8ZxkW4+JknI103jvrfRvgpbnQ9OZR
	UWNLLVMYcmXSfHyvVTQQ0OG7a0BNICaanP9C7lzKM5KtXLfplat1pCiXWLh3xG/oePDM9BRsXfgV7
	YsOyRqxEOJd1C0+tvU9REZAXSJpMG3nAhl7sTKibmpvtfbRYJ9G68mIVPkAvjLkRu2Cd/HjuQ0pjp
	cSkQNS2RSLdqSMEhsoX71m2F;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vR65n-00GwZq-2f;
	Thu, 04 Dec 2025 09:57:43 +0000
Message-ID: <8be9db5a-85c3-4571-999d-dd72a39727a7@samba.org>
Date: Thu, 4 Dec 2025 10:57:43 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with smbdirect rw credits and initiator_depth
From: Stefan Metzmacher <metze@samba.org>
To: Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
Content-Language: en-US
In-Reply-To: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tom,
> I assume the solution is to change smb_direct_rdma_xmit, so that
> it doesn't try to get credits for all RDMA read/write requests at once.
> Instead after collecting all ib_send_wr structures from all rdma_rw_ctx_wrs()
> we chunk the list to stay in the negotiated initiator depth,
> before passing to ib_post_send().
> 
> At least we need to limit this for RDMA read requests, for RDMA write requests
> we may not need to chunk and post them all together, but still chunking might
> be good in order to avoid blocking concurrent RDMA sends.
> 
> Tom is this assumption correct?

I guess these manpages explain it as I expected:

For the client:
https://www.man7.org/linux/man-pages/man3/rdma_connect.3.html

        responder_resources
               The maximum number of outstanding RDMA read and atomic
               operations that the local side will accept from the remote
               side.  Applies only to RDMA_PS_TCP.  This value must be
               less than or equal to the local RDMA device attribute
               max_qp_rd_atom and remote RDMA device attribute
               max_qp_init_rd_atom.  The remote endpoint can adjust this
               value when accepting the connection.

For the server:
https://www.man7.org/linux/man-pages/man3/rdma_accept.3.html

        initiator_depth
               The maximum number of outstanding RDMA read and atomic
               operations that the local side will have to the remote
               side.  Applies only to RDMA_PS_TCP.  This value must be
               less than or equal to the local RDMA device attribute
               max_qp_init_rd_atom and the initiator_depth value reported
               in the connect request event.


I general I'm wondering why we set conn_param.retry_count = 6 (both client and server)

        retry_count
               The maximum number of times that a data transfer operation
               should be retried on the connection when an error occurs.
               This setting controls the number of times to retry send,
               RDMA, and atomic operations when timeouts occur.  Applies
               only to RDMA_PS_TCP.

I guess it initiator_depth/responder_resources values are respected by the
server when doing RDMA reads, there should never be a reason to retry, correct?
So we should use retry_count = 0, otherwise this may randomly mask problems.

Do you remember what you used in Windows?

Thanks!
metze



