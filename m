Return-Path: <linux-rdma+bounces-11800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE49AEF8D2
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 14:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901581890FF8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273A273D91;
	Tue,  1 Jul 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwK4uDAe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A8273818
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373538; cv=none; b=dHfKFwOgRcup50Aq1902twsyr4g0B2Rtu849Gg/C/wFxj8NX75WcO/zf7IVBAED87PUQmwPvbnhztX5TUetCuIrvpTtFT0BbpFbx1k9lvccFw91Ip+Ql3DVGq/Z7Fr9oed9HszY9lbWLTyTu3qFd1rSo0Ffc7VceH0XRXkG/UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373538; c=relaxed/simple;
	bh=hxslfEDTIthkVPENOVaafrSa8DsPpU32eoDRFyV/7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6OpNkbnTP+Okeqqfvw5eU2hkrGclfhYdzxRoJEyA6IHYLKMitLKhyb/mh6fDmLEiKtg0JVByzPzTzgSRwlpmyQomS0vQDYcsKRdO2Kin9MDkGy1qUkKrN0HqkPLrHqnfws9Yt8yZMrYvtc/PCY03qAqZ+IACiQgj6QXvRc9qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwK4uDAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A31C4CEEB;
	Tue,  1 Jul 2025 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373538;
	bh=hxslfEDTIthkVPENOVaafrSa8DsPpU32eoDRFyV/7pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwK4uDAeceQFmf6KcORoT+XrrkL7YdMC+WQU7YZF1fka5mgBh+2ynCSMS7hFI6r1F
	 8IFsrOO535NNDGhQ975A/DBWFO0VUySap+SBidMikLw0aK0Ab186/QHO3+Q4wLNgdB
	 3p9cb5u3pioBd35qhYfcUPKD40hnGwq6Qou6D4prdTcI6J6xEGatBF9cD2MEWrhIpl
	 UklQ1Ad7gbWeLwud4cHBPcCk2MIOMO+yUNXWr4UhMWaShxmxw91g1i8cx8CYD6b6M/
	 0ZTdKJCmDDgVXHtpAfK9ySkPpiyRWz8Td9f5LYtXP8T9whP5PtMIfX7Yy1O/fXjcw4
	 oGoIAmxrBMapA==
Date: Tue, 1 Jul 2025 15:38:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 06/23] RDMA/hfi1: Remove opa_vnic
Message-ID: <20250701123853.GD6278@unreal>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>

On Mon, Jun 30, 2025 at 11:30:17AM -0400, Dennis Dalessandro wrote:
> OPA Vnic has been abandoned and left to rot. Time to excise.
> 
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  Documentation/infiniband/opa_vnic.rst              |  159 ---
>  .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
>  MAINTAINERS                                        |    6 
>  drivers/infiniband/Kconfig                         |    2 
>  drivers/infiniband/hw/hfi1/Makefile                |    4 
>  drivers/infiniband/hw/hfi1/aspm.c                  |    2 
>  drivers/infiniband/hw/hfi1/chip.c                  |   54 -
>  drivers/infiniband/hw/hfi1/chip.h                  |    2 
>  drivers/infiniband/hw/hfi1/driver.c                |   13 
>  drivers/infiniband/hw/hfi1/hfi.h                   |   20 
>  drivers/infiniband/hw/hfi1/init.c                  |    4 
>  drivers/infiniband/hw/hfi1/mad.c                   |    1 
>  drivers/infiniband/hw/hfi1/msix.c                  |    4 
>  drivers/infiniband/hw/hfi1/netdev.h                |    8 
>  drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 
>  drivers/infiniband/hw/hfi1/verbs.c                 |    2 
>  drivers/infiniband/hw/hfi1/vnic.h                  |  126 --
>  drivers/infiniband/hw/hfi1/vnic_main.c             |  615 ------------
>  drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
>  drivers/infiniband/ulp/Makefile                    |    1 
>  drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 
>  drivers/infiniband/ulp/opa_vnic/Makefile           |    9 
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ----------
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ----------
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ---
>  .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 --------
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 --------------------
>  .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
>  29 files changed, 20 insertions(+), 4857 deletions(-)
>  delete mode 100644 Documentation/infiniband/opa_vnic.rst
>  delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c

It is not complete, after applying the patch:
➜  kernel git:(wip/leon-for-next) git grep -c -i opa_vnic 
Documentation/driver-api/infiniband.rst:4
Documentation/infiniband/index.rst:1
Documentation/translations/zh_CN/infiniband/index.rst:1
include/rdma/ib_verbs.h:2
include/rdma/opa_vnic.h:24

Thanks

