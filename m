Return-Path: <linux-rdma+bounces-14229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABCC2F8EC
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 08:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96BE423446
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7773019C1;
	Tue,  4 Nov 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uvmRyMJK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63458301717;
	Tue,  4 Nov 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762240122; cv=none; b=kjo/TJF4jgod7r7pL1+OkE7HBGO8hQCeSLKpXFQ75GiX0FuCJJ/bURdxIUDvPBPKyExbj+soINCL+8NhleiiSY9Wp/8V5DgaJOOlvvBhYI4fOJBTC2IEdYEaw+JIeC246BGMtnjUrbzLX/cX10uV6pfhGup2/Ggpnd12Twusbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762240122; c=relaxed/simple;
	bh=sAOdPGYCPCwYsQtkPo4GCjFg3Nkx257mkO4wArX6Rsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebI8wXXkrlhR18fv8pMYV85jtHfKhEuwq1TfqOa4qe2qYqPhmKNEimdLCCrUpnknnf6dXG9UEV5BNzrqEovhahApLk2BWANPFIW4Mxh09In25RRYWyprNkkhM7N4Z1hBrh8IaEMFDurvmfdkC0F1xWMJSk4psMh1Gc51JW3dZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uvmRyMJK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762240109; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tHAZePd0ycu1VN9/wUJ5tt4FKrADODcsk8LpTvkJW0o=;
	b=uvmRyMJK9nrx3opM7Qwm2SslFZ4XtYTvxBJo3ikH2l2tGewGCUsA4JaQeUo6JuCISHg0Jbfi47fcOPAfFRBDlgUxAQgQ5pmfNPBa+v14rTiG2Flym22QfQM/isb7KtHLxBilJza+jqcrjZ6AmviplzOCQMgOWOpzYs73ENHSd/A=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wrg8odg_1762240108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Nov 2025 15:08:28 +0800
Date: Tue, 4 Nov 2025 15:08:28 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH net] net/smc: fix mismatch between CLC header and
 proposal extensions
Message-ID: <20251104070828.GA36449@j66a10360.sqa.eu95>
References: <20251031031828.111364-1-alibuda@linux.alibaba.com>
 <95bd9c85-8241-4040-bbd0-bcac3ffc78f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95bd9c85-8241-4040-bbd0-bcac3ffc78f7@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 03, 2025 at 09:28:22AM +0100, Alexandra Winter wrote:
> 
> 
> On 31.10.25 04:18, D. Wythe wrote:
> > The current CLC proposal message construction uses a mix of
> > `ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
> > to include optional extensions (IPv6 prefix extension for v1, and v2
> > extension). This leads to a critical inconsistency: when
> > `smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
> > only link-local addresses, or when the local IP address and the outgoing
> > interface’s network address are not in the same subnet.
> > 
> > As a result, the proposal message is assembled using the stale
> > `ini->smc_type_v1` value—causing the IPv6 prefix extension to be
> > included even though the header indicates v1 is not supported.
> > The peer then receives a malformed CLC proposal where the header type
> > does not match the payload, and immediately resets the connection.
> > 
> > Fix this by consistently using `pclc_base->hdr.typev1` and
> > `pclc_base->hdr.typev2`—the authoritative fields that reflect the
> > actual capabilities advertised in the CLC header—when deciding whether
> > to include optional extensions, as required by the SMC-R v2
> > specification ("V1 IP Subnet Extension and V2 Extension only present if
> > applicable").
> 
> 
> Just thinking out loud:
> It seems to me that the 'ini' structure exists once per socket and is used
> to pass information between many functions involved with the handshake.
> Did you consider updating ini->smc_type_v1/v2 when `smc_clc_prfx_set()` fails,
> and using ini as the authoritative source?
> With your patch, it seems to me `ini->smc_type_v1` still contains a stale value,
> which may lead to issues in other places or future code.

Based on my understanding, ini->smc_type_v1/v2 represents the local
device's inherent hardware capabilities. This value is a static property
and, from my perspective, should remain immutable, independent of
transient network conditions such as invalid IPv6 prefixes or GID
mismatches. Therefore, I believe modifying this field within
smc_clc_send_proposal() might not be the most appropriate approach.

In contrast, pclc_base->hdr.typev1/v2 reflects the actual capabilities
negotiated for a specific connection—what we might term "soft
capabilities." These can, and often do, dynamically adjust based on
current network conditions (e.g., in the event of a prefix validation
failure) and could potentially be restored if network conditions
improve.

Furthermore, once CLC negotiation is complete, the SMC protocol stack
relies exclusively on these negotiated results for all subsequent
operations. It no longer refers to the initial capability values stored
in ini. Consequently, maintaining ini->smc_type_v1/v2 in its original,
unaltered state appears to present no practical risks or functional
issues.

