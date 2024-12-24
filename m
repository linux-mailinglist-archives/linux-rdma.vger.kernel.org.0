Return-Path: <linux-rdma+bounces-6730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37AF9FBF2C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 15:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E606D1884DB6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81741C5CC1;
	Tue, 24 Dec 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b="QLVbPf5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBD1BC9FF
	for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.38.3.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050530; cv=none; b=KFLibKNnklV3QMlWeMoSET3z/WsuVoo8S+cVC0INHQdFvqs5FXfMAIM3ONHjwZ4nRkWcwPjax05IGsZhRCmcFR+7FUyO/gFyDDedRRSSy9R/VBnViuINmk97NZvzWl8QPmgN37DtB+KQPmflwrIC7JeSJ3G9+5xOWvgTuKbDbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050530; c=relaxed/simple;
	bh=1IlAx2xpuOVXPorQ5brBzRmGp6F4SRMpxlud/COTbTQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XGIflhH881EmHbFZ8oIqkXjHe5N8lvYYoGnj9q59+Ourd7D3A4S/P6fHnYBTypABjPZYWjjWWtKUmrnzQlR6hlyLO+rcnN21sBv7f2SDFb4DSt9WqxEmsIPGHYRaX8cxD7ytHnVacmZPqiSRhjQr4IROS6qNlvTlb9U1k2qJm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de; spf=pass smtp.mailfrom=dwd.de; dkim=pass (2048-bit key) header.d=dwd.de header.i=@dwd.de header.b=QLVbPf5I; arc=none smtp.client-ip=141.38.3.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dwd.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwd.de
Received: from localhost (localhost [127.0.0.1])
	by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 4YHcgH63BBz4vYd
	for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2024 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
	content-type:content-type:mime-version:references:message-id
	:in-reply-to:subject:subject:from:from:date:date:received
	:received:received:received:received:received:received:received;
	 s=dwd-csg20210107; t=1735050475; x=1736260076; bh=1IlAx2xpuOVXP
	orQ5brBzRmGp6F4SRMpxlud/COTbTQ=; b=QLVbPf5Ipw05/Y9osnHWZaztUJqZz
	NUg2yOC7dEwnrusgtvKZ13VBZbrqBmLkEQYEzAtjR4jMLV+bvmSyPbY68dneK945
	bUa9l8uktge1dmGW/xzZ3jTEwS5VtTIQymjIztbAOi0pqkttj65A5JRZhYYSYUKa
	2dcGZrqBF0SeovAkJ3LzJvlvNqni3P4QKnumfSFF30T6bu1Y2E+JjR7xwwq+AO+j
	5N2fsWZ01weX8sVWsjYRmLWfOx3YAsmUjaxTQhocm3ywDefn1O4awSloihLSts1L
	65LhUHsLlIXbHVD6aamEDg3jI6QFn53eGpqodLTlmyObXhdOJkBhEvf5w==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn3.dwd.de [172.30.232.26]) (amavis, port 10024)
 with ESMTP id 4plowuSPPaqQ for <linux-rdma@vger.kernel.org>;
 Tue, 24 Dec 2024 14:27:55 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 7FA5AC903A6A
	for <root@ofcsg2dn3.dwd.de>; Tue, 24 Dec 2024 14:28:38 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 71FE2C903972
	for <root@ofcsg2dn3.dwd.de>; Tue, 24 Dec 2024 14:28:38 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.26])
	by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
	for <root@ofcsg2dn3.dwd.de>; Tue, 24 Dec 2024 14:28:38 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Tue, 24 Dec 2024 14:27:55 -0000
Received: from ofcsg2dvf1.dwd.de (unknown [172.30.232.10])
	by ofcsg2dn3.dwd.de (Postfix) with ESMTPS id 4YHcgH2cfDz4vYd;
	Tue, 24 Dec 2024 14:27:55 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofldap.dwd.de [141.38.39.208])
	by ofcsg2dvf1.dwd.de  with ESMTP id 4BOEScUm027483-4BOEScUn027483;
	Tue, 24 Dec 2024 14:28:38 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
	by ofmailhub.dwd.de (Postfix) with ESMTP id EBDF44535B;
	Tue, 24 Dec 2024 14:28:37 +0000 (UTC)
Date: Tue, 24 Dec 2024 14:28:37 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Leon Romanovsky <leon@kernel.org>
cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
    linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: failed to allocate device WQ
In-Reply-To: <20241224094727.GD171473@unreal>
Message-ID: <219fb7a-5991-ada0-941c-29fd55f7df8@praktifix.dwd.de>
References: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de> <20241224094727.GD171473@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-FEAS-Client-IP: 141.38.39.208
X-FE-Last-Public-Client-IP: 141.38.39.208
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.1.1004-28880.000
X-TMASE-Result: 10--11.403300-10.000000
X-TMASE-MatchedRID: hls5oAVArl+Mp9w0tjqOxa5i3jK3KDOot3aeg7g/usCx+ck5gcrv5J3+
	duY6/oy8jAEino+oKsvpJhvb1zetNMh8MJ51rlprFwooSeuNnY687rU89eLPKR8DRANMiqtimBQ
	vLjMBsUEnloJwT/zK1yhiSap8GR+noGx3AJ5tkZO9POB463xQErcKVIr9tQwNmgxzSCl7WBnZzn
	Xqu/Oqu7r9VU1xTfnT/vNQ1oZs39BEmmhct6O0TRSceev8ZtpPiFg4TY5QPrCnhDxyeEHEOC4TI
	zFTm9BjfS0Ip2eEHnyKLuVdohwX9alObmR9moGo9xS3mVzWUuDgwxMH5wVMuonxgmBGuBcXFNgk
	dtXR37GFcrdUMP9NvLDAyM3Z0eVKWnITFEyOG+I=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe

On Tue, 24 Dec 2024, Leon Romanovsky wrote:

> On Fri, Dec 20, 2024 at 05:10:32PM +0000, Holger Kiehl wrote:
> > Hello,
> > 
> > since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
> > card sometimes hits this error:
> > 
> >    kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib_wq": -EINTR
> >    kernel: ib0: failed to allocate device WQ
> >    kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret = -12)
> >    kernel: mlx5_1: couldn't register ipoib port 1; error -12
> > 
> > The system has two cards:
> > 
> >    41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
> >    c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
> > 
> > If that happens one cannot use that card for TCP/IP communication. It does
> > not always happen, but when it does it always happens with the second
> > card mlx5_1. Never with mlx5_0. This happens on four different systems.
> > 
> > Any idea what I can do to stop this from happening?
> 
> It is not related to the FW but to how your system loads kernel modules.
> 
> This merged PR in rdma-core probably fixes it.
> * Ensure RDMA service loads modules in initrd - https://ofcsg2dvf1.dwd.de/fmlurlsvc/?fewReq=:B:JVE3PDk0Nyt7MD8jPStkaTA9PDc9PCt+ZGpjbHl4f2gwPDk5OT5ubm5rNG47OD9raDQ1aGtrbzQ9azhvbD47Pm44OGxoaD5oOyt5MDw6Pjg9Pj47NT0rfGRpMDlPQjRgPXpvPT48Pz0+IDlPQjRgPXpuPT48Pz0+K39ufXkwRWJhamh/I0ZkaGVhTWl6aSNpaCtuMDg/K2VpYTA9&url=https%3a%2f%2fgithub.com%2flinux-rdma%2frdma-core%2fpull%2f1481 
> 
Yes, applying those I could no longer reproduce the problem. After
reboot both cards are now always detected.

Thank you very much for the hint!

Regards,
Holger

