Return-Path: <linux-rdma+bounces-15984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CM5HTwOdmlRLAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:36:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D0808B1
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2461F3002527
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818B275AE1;
	Sun, 25 Jan 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYxC827K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB11E86E;
	Sun, 25 Jan 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769344565; cv=none; b=AEYf61gAeUZ8bkapbUXt7YkcSgmaMBaq9TtDxPjZXrbG5nCdjNBeU+ouzHED2UZzogkRmAhzeZTqdPff/C0Pu2qoyJ85JzMGdoxQLAEfj8npdpgZMMwo5bZLC4Y8JDYH1Wxr1VHEwbdJrvJNU8KCye518E5GOy7gihTNhlDArjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769344565; c=relaxed/simple;
	bh=gkfmA/bd5J27d0T1WYH5WsPq3ys9qISDnEYzmYv0GqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDvd9I/qzG7ik5Bcu6Q3wSWea14dsTbnOCnyO3eL1LzZfd2lNNrm1Dx0aGIWsNipHmIfHODG9GMsYXz/SDGKZYLmarwDlf5hybXlQ9sdmN8lQm5G1jM3cHHNb2V1rYLt0b+NrLvCZIV4OXs0/dg239QGRp3VQzLx3fXjBHluQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYxC827K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6484FC4CEF1;
	Sun, 25 Jan 2026 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769344564;
	bh=gkfmA/bd5J27d0T1WYH5WsPq3ys9qISDnEYzmYv0GqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYxC827K8ERzRJuSEIspV1rhxruuMehRmG0TZAROdsrVvbfXLzpGPSjJlh8UvRx1Z
	 fAXNjdRbKNQckgDTfBmjdzBHTn/B5Tn/k5YnxtqeupbPwUix6aXvDrvesVgb/mnP7I
	 bMQ1RzcnmcKPvj86feUh0/bkGvryFoN5xdsE045nX1ipd+QWmdnaAhVb2RxN0jS4u3
	 WLYYjuWZjI4gm4x6A7/1g1Wr72qNqv+RdR9yI/Yntg1VMYuBPcCm51GRPRQezaM8Ii
	 ck7XuP4f/5Udhi5x+TbZGoNtBBFJ43CVdErlUMOmuXVojg3cpBa64TqlDSZMtaH3AU
	 FiOBfEWkp++SQ==
Date: Sun, 25 Jan 2026 14:35:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, linux-kernel@vger.kernel.org,
	dave.jiang@intel.com, saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com, gospo@broadcom.com,
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH fwctl 1/5] fwctl/bnxt_en: Move common definitions to
 include/linux/bnxt/
Message-ID: <20260125123552.GA13967@unreal>
References: <20260118123401.3188438-1-pavan.chebbi@broadcom.com>
 <20260118123401.3188438-2-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118123401.3188438-2-pavan.chebbi@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15984-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D2D0808B1
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 04:33:57AM -0800, Pavan Chebbi wrote:
> We have common definitions that are now going to be used
> by more than one component outside of bnxt (bnxt_re and
> fwctl)
> 
> Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/debugfs.c                         | 2 +-
>  drivers/infiniband/hw/bnxt_re/main.c                            | 2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c                        | 2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h                       | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c                       | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c               | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c               | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                 | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                   | 2 +-
>  .../broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h        | 0
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (100%)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

