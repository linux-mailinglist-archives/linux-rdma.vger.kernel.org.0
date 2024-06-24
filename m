Return-Path: <linux-rdma+bounces-3430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E269F914776
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC78286A70
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D8136E37;
	Mon, 24 Jun 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4YujQNw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C02136995
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224818; cv=none; b=UvdTcZjnxEkLBEcQrDmTaFmHhJGKtWs+zRQNB6pelHLOsEt2d3S4he3IQOgsYa2VMhAzmKNNcWdN93wfLK67wcmZGXhr+CnfnajZ7Y87abm/0kj5bjK3KGxESeNY/PwdsTZl1lrvCMy4anrIbkES44QaS6vncIFqi4s/2yNU60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224818; c=relaxed/simple;
	bh=5Osaek7mJpfFa+5mEwuGe3SGAQhXao7yyk6LZtnNiUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r8KrVDphkpCjI9ZmJdyLp+Yfon3+2CH29ZlefXVCtEO0kXkkSrUB25uzN9vyiwFRfnZByYntAYYQVi4KMd0cmKvkkgDB6qtIwNuH1i4TT2QNcKGUas7peV/GCIc0OpvqBqde9ZLMFrn5xCcqMxws/9X/seCWY7lz+54x/S6qcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4YujQNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12700C2BBFC;
	Mon, 24 Jun 2024 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719224817;
	bh=5Osaek7mJpfFa+5mEwuGe3SGAQhXao7yyk6LZtnNiUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M4YujQNw+zL+UeUxJUAX89b2rEUadUMjd81CPYwyJAFeEUO9SdYUgosWRt6WMEHEN
	 K755GKdD4ioU8w2WS5KqyRqUf6Vl2iVbAVSyD32Zole5UwzJQgpW/5/Ew29yLC4QcC
	 8PEB/qHC9V4LjE8JSGqldChQAalcEBYeOl17IkzSI6WYgnfbjtA2eFx9T0VLXGCP3Z
	 6nrqYAG9awPWTwaki4rMB/CIaGhVbPJrOkrswSc48nZQZC/3ArF4dEFmzv4LsnVq7m
	 fF+4MPF1TEFaatsSQIsSyQ3ffAnxcu38m12POz7MMtdOp6CD5e9oiUmN39nnCPWCjJ
	 UXMSa7GyrRuNg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
 chuck.lever@oracle.com, sagi@grimberg.me, Leon Romanovsky <leon@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com, 
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com, 
 edumazet@google.com
In-Reply-To: <20240619171153.34631-1-mgurtovoy@nvidia.com>
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 0/2] Last WQE Reached event treatment
Message-Id: <171922481356.416620.9418503031889142594.b4-ty@kernel.org>
Date: Mon, 24 Jun 2024 13:26:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 19 Jun 2024 20:11:51 +0300, Max Gurtovoy wrote:
> This series adds a support for draining a QP that is associated with a
> SRQ (Shared Receive Queue).
> Leakage problem can occur if we won't treat Last WQE Reached event.
> 
> In the series, that is based on some old series I've send during 2018, I
> used a different approach and handled the event in the RDMA core, as was
> suggested in discussion in the mailing list.
> 
> [...]

Applied, thanks!

[1/2] IB/core: add support for draining Shared receive queues
      https://git.kernel.org/rdma/rdma/c/95dd753bdb674b
[2/2] IB/isert: remove the handling of last WQE reached event
      https://git.kernel.org/rdma/rdma/c/8de1ea4a9d7a2d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


