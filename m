Return-Path: <linux-rdma+bounces-8265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F9A4CB22
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA687A3A7C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5322DFB5;
	Mon,  3 Mar 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oPw3V5Qr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945E20FA85;
	Mon,  3 Mar 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027338; cv=none; b=jzyrXEu75dH00m/asjg0SwvGxn2etpOoiLVFZSEE9coidHt2SywyRX6Ba8q5EMoK+Rzt+nS0PcoLH9dEP/wPYP6cuHWIZYdCp6XX3xvmkMov0vkN3wIMsQul42ZRv+fH8Yk3qXDhbNaam/F160pbBp10f+h7AcdMvgy5fS25Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027338; c=relaxed/simple;
	bh=GgL5l5p7cLIK3jtpm2PKvweYN8IGRE0x81hzIGh6psM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0lkTrkWAKpjHXHqQ0TcHh7PPqywgE2cs1EoLyiVoDscY6GMXAHXgmdnBzz9DRYJHtlj5iqWb9W7m4vv56Hw5ntLhqljT5EUmoXssRDqKEVP+3T3D1IUaFLpivV+vaHg94wKcmZxjnSrzLnHuoFyTFuf2C3TvI15izyhcBCzHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oPw3V5Qr; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+blnsrHAxihwIlHpvyveOux8noercGhAiceXO94VY1k=; b=oPw3V5Qr/ypp0ZNY
	35NdCkYmE2Ij7+RA2l2EX2HizcINmpziFDhFwhBlQQTOmfjGPM/XojC3ZzSC/mF/c2mLglOhPhGUj
	7/p/sBRwpcXDs0tfnTpxdYxoDK8yLHIa7TRgfaycCnXuTpFN1ekzGXmyN44XHZFbVXE9fmQR++gPj
	aQRmrFBi99qg/7fkyMYi5Qtg3r1OlU2kwrMmHfHKBpYuLu6PnQAUtoerWVg5IeO/6lqDuaiPCeDYS
	SPB5c+ueCtBH+aZ1xZOK+VPx1vn9SewKVuPL+gf0aVNwyfa6ye/x1rkD3wwGFoCr7YMYOG6kpbZk9
	227J4gnpUxhdzJJQWA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tpAjz-002E4j-1w;
	Mon, 03 Mar 2025 18:42:11 +0000
Date: Mon, 3 Mar 2025 18:42:11 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, leon@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Unwired pvrdma_modify_device ?
Message-ID: <Z8X4Ax5UCerz9lP8@gallifrey>
References: <Z8TWF6coBUF3l_jk@gallifrey>
 <20250303182629.GV5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250303182629.GV5011@ziepe.ca>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 18:41:23 up 299 days,  5:55,  1 user,  load average: 0.10, 0.05,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jason Gunthorpe (jgg@ziepe.ca) wrote:
> On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> > Hi,
> >   I noticed that pvrdma_modify_device() in
> >    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> > isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> > 
> > (I've not got VMWare anywhere to try it on, and don't know the innards
> > of RDMA drivers; so can't really test it).

Hi Jason,
  Thanks for the reply,

> Seems probably right
> 
> But at this point I'd just delete it unless pvrdma maintainers say
> otherwise in the next week

OK, lets see if they wake up.

Dave

> Jason
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

