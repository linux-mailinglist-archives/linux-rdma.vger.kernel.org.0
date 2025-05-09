Return-Path: <linux-rdma+bounces-10237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F023AB1E62
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD111677CB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FA25E834;
	Fri,  9 May 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFWzAcpD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FE2376EB;
	Fri,  9 May 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746822838; cv=none; b=Mlv2PJF6wXdI/m95OYzR/vVwn0AQICjbhbmX2rsv+c8sTXmtv4YJTpOeWLdLdnTfd5UFAcadAoN4rw6nYaFfFnOeJKpeD/kPl5Hx4orlaLJelHR0uKE0UIhq5A76RnFyYw1NiFrFMotoVW24nm5GudE5vPxSpzpITPu3tJSSAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746822838; c=relaxed/simple;
	bh=8Opp5CXxAJ0wijLLMmq4HiIZRuUEz0j+COvG3Ubsows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWkFkjDpS22JSySEyT86EYut2k9c7ae+ErVU+Psc4ImVTZmyaEpQYN8fQA6BUkszy8lwc1/wuBFfaJirEZxFAVYrqEbb4U4JahoHUYpaXjx5vpok6DiqUJzna3UrWiYKA99OKTbUKI8B7SM+Pccy8KKGCcPjjs74ddSjHD6slHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFWzAcpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A2BC4CEE4;
	Fri,  9 May 2025 20:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746822838;
	bh=8Opp5CXxAJ0wijLLMmq4HiIZRuUEz0j+COvG3Ubsows=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFWzAcpDthJicBQU2Ki2KeqEJXoAuSiWsKmhiNgmnsEjM0hp6PavQKrKZxwJc9zjm
	 36nryU4QZfKVi4JUPxMA04xK6Jq+IDNECEoShNRJ6Um8WU3yrfYEFKSZuNl2UIR0Oq
	 uM2aHC2x0X0lpXLtkewXfnfznbTVkrkilp27Yl1GigdaTZvhCaTFbM/02haQOkiURs
	 sNbAqdPDM+HktFgdGEdeYpl+FZ9thMYgp7D5JsciBQQfczTJrxaq9mcMk98KoBjeNB
	 gjYbw3mW1vVmMYvknHprZ+LACOXUcqeI+GeiK8y1oJduh36xK//gLpXNUex1ojnIaC
	 0VHYsTbtgrtYQ==
Date: Fri, 9 May 2025 21:33:52 +0100
From: Simon Horman <horms@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel
 build environment
Message-ID: <20250509203352.GS3339421@horms.kernel.org>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <20250508045957.2823318-15-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508045957.2823318-15-abhijit.gangurde@amd.com>

On Thu, May 08, 2025 at 10:29:57AM +0530, Abhijit Gangurde wrote:
> Add ionic to the kernel build environment.
> 
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++++
>  drivers/infiniband/Kconfig                    |  1 +
>  drivers/infiniband/hw/Makefile                |  1 +
>  drivers/infiniband/hw/ionic/Kconfig           | 17 ++++++++
>  drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>  6 files changed, 80 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>  create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>  create mode 100644 drivers/infiniband/hw/ionic/Makefile
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
> new file mode 100644
> index 000000000000..80c4d9876d3e
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst

Please add this new file to
Documentation/networking/device_drivers/ethernet/index.rst
(or some other index.rst).

Flagged by make htmldocs

...

