Return-Path: <linux-rdma+bounces-11804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80FAEFEC7
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DF744624D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE127A47F;
	Tue,  1 Jul 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm1R2/Vg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CD279908
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385628; cv=none; b=q/RbOPfNVLDW4EqF34ZrrTlxn/jCdzwjog9AptAIZ9+wcXsFZnACkRTO3M4Juht2bsAkw5m5PYysSYyarXesm4n0UfE9sSQtVSMy18vmGyXApAhCzwMBvlDB0Ir9zpKJLebZ/UsThWl6nzb9KWFFKLHYbDGJ61wk9wanGnmluKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385628; c=relaxed/simple;
	bh=Tb93M/o+wD9gkR4/rhhvNTqlEHHoRCkLCgOjvACreXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYGnvWrSSlGCtWnWtEtD/NXMWbZLDEAC/Yllir5UpQk/g4Fnec5+BV8WAE43/UhREh67pnEebqyjiOFJwikxatpiDS421owAPVmIq4fvTMUe8MsZLenkBTJZJLxOTXjes5/ZihVVVUFzFsN1n+eTiyDct8pXPcyDDfhS9gpav8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm1R2/Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD29BC4CEEB;
	Tue,  1 Jul 2025 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751385628;
	bh=Tb93M/o+wD9gkR4/rhhvNTqlEHHoRCkLCgOjvACreXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cm1R2/VgbSA427sUNdLQ2g99VCsq/MuHnrOQxyC7pu2uHKH/apkBoSNZOV2PfQIQM
	 dJe5IBcdGux+uxpBPTBQVWF6ydOpIT93TMJOvg2CwypznNSejl8QQHV1cj0g/IU0uf
	 LiarV5mnzp4DRCIOethZasG/h+Ibn8w9JByjUVwCzkzNQ8dOlalEQurQzoEKPvTKed
	 u7PFN5zKMlSfKzwIHwVuwFO+BBdna28jJdpzPopqLQSwtjhpYddFZKp1nFsQxlevg0
	 4mpW9n6/f4zbz6aDqOLugDtXX6MIA6w2IrpUk/K6s26SYYzZHobe1gzRUT6ehLa+nh
	 ot23YAdZd22jw==
Date: Tue, 1 Jul 2025 19:00:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 06/23] RDMA/hfi1: Remove opa_vnic
Message-ID: <20250701160024.GF6278@unreal>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741787.1859400.7033099190800356659.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123853.GD6278@unreal>
 <5dbcf9f6-cfe5-42f5-880d-d0fd7e8bcb3c@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dbcf9f6-cfe5-42f5-880d-d0fd7e8bcb3c@cornelisnetworks.com>

On Tue, Jul 01, 2025 at 09:44:05AM -0400, Dennis Dalessandro wrote:
> On 7/1/25 8:38 AM, Leon Romanovsky wrote:
> > On Mon, Jun 30, 2025 at 11:30:17AM -0400, Dennis Dalessandro wrote:
> >> OPA Vnic has been abandoned and left to rot. Time to excise.
> >>
> >> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> >> ---
> >>  Documentation/infiniband/opa_vnic.rst              |  159 ---
> >>  .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
> >>  MAINTAINERS                                        |    6 
> >>  drivers/infiniband/Kconfig                         |    2 
> >>  drivers/infiniband/hw/hfi1/Makefile                |    4 
> >>  drivers/infiniband/hw/hfi1/aspm.c                  |    2 
> >>  drivers/infiniband/hw/hfi1/chip.c                  |   54 -
> >>  drivers/infiniband/hw/hfi1/chip.h                  |    2 
> >>  drivers/infiniband/hw/hfi1/driver.c                |   13 
> >>  drivers/infiniband/hw/hfi1/hfi.h                   |   20 
> >>  drivers/infiniband/hw/hfi1/init.c                  |    4 
> >>  drivers/infiniband/hw/hfi1/mad.c                   |    1 
> >>  drivers/infiniband/hw/hfi1/msix.c                  |    4 
> >>  drivers/infiniband/hw/hfi1/netdev.h                |    8 
> >>  drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 
> >>  drivers/infiniband/hw/hfi1/verbs.c                 |    2 
> >>  drivers/infiniband/hw/hfi1/vnic.h                  |  126 --
> >>  drivers/infiniband/hw/hfi1/vnic_main.c             |  615 ------------
> >>  drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
> >>  drivers/infiniband/ulp/Makefile                    |    1 
> >>  drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 
> >>  drivers/infiniband/ulp/opa_vnic/Makefile           |    9 
> >>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ----------
> >>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ----------
> >>  drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ---
> >>  .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
> >>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 --------
> >>  drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 --------------------
> >>  .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
> >>  29 files changed, 20 insertions(+), 4857 deletions(-)
> >>  delete mode 100644 Documentation/infiniband/opa_vnic.rst
> >>  delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
> >>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
> >>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
> >>  delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
> >>  delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
> > 
> > It is not complete, after applying the patch:
> > ➜  kernel git:(wip/leon-for-next) git grep -c -i opa_vnic 
> > Documentation/driver-api/infiniband.rst:4
> > Documentation/infiniband/index.rst:1
> > Documentation/translations/zh_CN/infiniband/index.rst:1
> > include/rdma/ib_verbs.h:2
> > include/rdma/opa_vnic.h:24
> 
> Ah! Will get rid of those in the next iteration.

Send opa_vnic separately, it is independent.

Thanks

> 
> -Denny

