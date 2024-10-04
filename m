Return-Path: <linux-rdma+bounces-5215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB99905C3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C025E1F221E3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA899212F15;
	Fri,  4 Oct 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="C86sRQfG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB371BC23;
	Fri,  4 Oct 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051376; cv=none; b=MZ0qeIpEIW6/KLKxDkAOWu01+1B960XLEE9ad/OQikF6cYnAN7TAk/VBRMShPxvwml29B5Rv4Xf7sWf30L5Tot+9KvwFdR0h8sXSyv2/jxFBoxaEjevpROmmc3NbGsko9WUDkDCA12cO2hhsiIWZXpWsdiQ0hhnSptgjy4xe0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051376; c=relaxed/simple;
	bh=es7DQpcICKhSauRHiYxbkz1Bv1jKuLVCA8L+zF1GC2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eHd8IxEVoe7HtE7K+V7U5I9/Wm2N9ydMkDl4WtSQ3jrlJ1wk7ehgHOl4yPNPWIMoU7apzCeH5paAKFMlKo0Q75mZc6bGVUKFmTGxfYRh+6IL0D+M3QDi6HZK9EQi1zObI2oG0C9N1r2kAOvY8y01zxTm6if99P/IhoxsYWf50dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=C86sRQfG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=dLzfh73W+9ci6UkmDEBS2G6WMepVrbkF6pKwKfsZehQ=; b=C86sRQfG64KhRrKu
	lyFRoYoOgcs47Izu0Q6Ji+D1vSD5iGaTXtH5ZK0TtAtGdphY4Zd2lUUthhu/okXKAhneT3OUJBc40
	H7+ZWsoJBHKZHaRK8yt5pJdk0QWoy2LyGFJT1B+oeivkWK8LcMfxF3TKxN4EXsJ8o/AdeZC7ZUKtz
	vyS85TApffKhVUj8xwO3e1RYX8IraJ+Qmp6avdYTpMAFqesr7QmBqRGEcgCXRC1ongX+DOe6+s25I
	sb2xAKBgWpqGZfXYfE6v/PjfzkVPmq9glMT0A33lgvEkK7i94OrHfhiAjSu48p70rQJO+iQag9/7i
	8/UEz/Wdq6GzUyXBag==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1swj6G-008s3o-2C;
	Fri, 04 Oct 2024 14:16:08 +0000
Date: Fri, 4 Oct 2024 14:16:08 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: maorg@nvidia.com, bharat@chelsio.com, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: of c4iw_fill_res_qp_entry
Message-ID: <Zv_4qAxuC0dLmgXP@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:01:54 up 149 days,  1:15,  1 user,  load average: 0.02, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  One of my scripts noticed that c4iw_fill_res_qp_entry is not called
anywhere; It came from:

commit 5cc34116ccec60032dbaa92768f41e95ce2d8ec7
Author: Maor Gottlieb <maorg@mellanox.com>
Date:   Tue Jun 23 14:30:38 2020 +0300

    RDMA: Add dedicated QP resource tracker function
    
I was going to send a patch to deadcode it, but is it really a bug and
it should be assigned in c4iw_dev_ops in cxgb4/provider.c ?

(Note I know nothing about the innards of your driver, I'm just spotting
the unused function).

Thoughts?

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

