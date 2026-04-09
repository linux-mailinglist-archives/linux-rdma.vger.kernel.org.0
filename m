Return-Path: <linux-rdma+bounces-19159-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAPuKLSY12lNQAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19159-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:16:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C223CA475
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76304304E335
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0B3C13FD;
	Thu,  9 Apr 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFma3xVd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F313A4F2E;
	Thu,  9 Apr 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736754; cv=none; b=cAnSFnhVqArNDxBihKc00epKwi/2JNjfV2MCQfyItndJ2fjXE2JqdgkMDwXZT7vwW9tIa+8jowKUPBk80c68RgAcs/Qp+K/MvpJ6mL/0CcI8aLrkJsR+ZeuTFtTOajAi7j74h09b46MObjUX0DbdMdcB6oTV70S4qMZPtOjQDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736754; c=relaxed/simple;
	bh=EnP9JMAOTjkjqO/CLPh1AIVmglFqWKUmkpn2JEr1QOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkmJiwomItdTwhcvvIHmeYcWcs6shj+p5Qq6PfUEgwkEsrqMHlvfBtVYaIHQ+xMclyWBClOC1BlTiqzk3teHht7gQbXOjIXXx2uNPGEj5Rx7IbbFMRfkrWHp7Ayiz9jW8pa9ku7ttm6PkMYYso6nHzr3My3lRfEo77BvQ7E8MI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFma3xVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996EC4CEF7;
	Thu,  9 Apr 2026 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736754;
	bh=EnP9JMAOTjkjqO/CLPh1AIVmglFqWKUmkpn2JEr1QOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFma3xVdZvtUl3jO59TjO5InWxdJaYEsqtUWKkHXiJBJly9j5faYgWKfgUpeFUzP2
	 ufiVXhryp/NTLLc9fzoczENqXNHLXGqHAWDZN+XBNCMvdtU5tT0XU6vbCetqHvojKY
	 wqLEry7T1fpIVJUaCt8YtCRXDgsqcVVoO91ZPGJ+qaH4dX/jwCWQmynix4AJgLAniZ
	 ZhB3DAFpaR1D78IkJx0KATK47z/3m3H/bFO0YfY/BWhC+bT14qwTMIjpn4NWguA6YD
	 m7t48K0trDDydZZ3ahkTKRoGGvf7umvUUgfXv9seN/7Zgwo8lveS6gbr7doSit9Lff
	 rzz546ONwZIAw==
Date: Thu, 9 Apr 2026 15:12:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260409121230.GA720371@unreal>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19159-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20C223CA475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> From Chiara:
> 
> This patch set introduces a new BPF LSM hook to validate firmware commands
> triggered by userspace before they are submitted to the device. The hook
> runs after the command buffer is constructed, right before it is sent
> to firmware.

<...>

> ---
> Chiara Meiohas (4):
>       bpf: add firmware command validation hook
>       selftests/bpf: add test cases for fw_validate_cmd hook
>       RDMA/mlx5: Externally validate FW commands supplied in DEVX interface
>       fwctl/mlx5: Externally validate FW commands supplied in fwctl

Hi,

Can we get Ack from BPF/LSM side?

Thanks

> 
>  drivers/fwctl/mlx5/main.c                        | 12 +++++-
>  drivers/infiniband/hw/mlx5/devx.c                | 49 ++++++++++++++++++------
>  include/linux/bpf_lsm.h                          | 41 ++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c                             | 11 ++++++
>  tools/testing/selftests/bpf/progs/verifier_lsm.c | 23 +++++++++++
>  5 files changed, 122 insertions(+), 14 deletions(-)
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260309-fw-lsm-hook-7c094f909ffc
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

