Return-Path: <linux-rdma+bounces-14934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B239DCAE99D
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 02:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54B08300CAB2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965791C84A2;
	Tue,  9 Dec 2025 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OuvBWm2J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C525F995
	for <linux-rdma@vger.kernel.org>; Tue,  9 Dec 2025 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242924; cv=none; b=sRtFB2IoJdAWrUSHZM+PeTOAKKFcgJ2KgZVQd4qxq3nLmP/9EdAYWr294+9sqUS/bA6s9iPK8yeWIfK+K32e+iUyh3w/xXdwFrIpAG4N4xdTuXtZHB8zXSTx8b1L0ojZ5ZFpIx/eMfkN9f7haMeGq55gCNjeF0MPdwZuEan98bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242924; c=relaxed/simple;
	bh=nexP4SWJruKUarJZ/rFU8+4k0KNca4gjU/1H4Gnhfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CttmxyJ8mzQn0N8J4WHc1OSymoNjnUDY8mP8KUwiaDthjj6MlHS8jg4ZDJNl0vkyPpj8rH2UyPBZshdrNmOX+dm7BgqrNtKdQNgjXmUlmaXepptznWoZWMYZVBG1rCCmoi2hUUoxQkPh6d3UPOliNkvV5PYfTLTH0SX+EpK9MJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OuvBWm2J; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2n363xOx+XYbTUr0bSoWFyjz1NjW0b8UvqXbQO3L3cQ=;
	b=OuvBWm2Jz+9SAOOSYqP2INZuO+/FcfLXEVjOHYKYCa2JJ0/UURuCFHb+zZ6VEW
	+h2Hh28OqaNIKHFbQzSGGbtCZ3kXkt7UJcKkEG2OopPVZC+DtvN0W8UGAI2n9gUQ
	wmc/Trddc2n5vNgd8VyE5vooqF82LWOHInmdDCLHjT77c=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnd9gHeDdp78KSAg--.1829S2;
	Tue, 09 Dec 2025 09:14:48 +0800 (CST)
Date: Tue, 9 Dec 2025 09:14:47 +0800
From: Honggang LI <honggangli@163.com>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com
Subject: Re: [PATCH 5/9] RDMA/rtrs-clt: Remove unused list-head in
 rtrs_clt_io_req
Message-ID: <aTd4B9vJ--hDESNJ@fedora>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-6-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208161513.127049-6-haris.iqbal@ionos.com>
X-CM-TRANSID:_____wDnd9gHeDdp78KSAg--.1829S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xAryxur47Aw4kGFW3KFg_yoWkJwb_KF
	40qrZ7XFyDCr18ta4Yg3W3WFyv9w1xZFn5Z3Z0g34DJ345tF4rXFn2vr1Fqwn8Xw1I9Fn8
	Cr93Wr4vgrySkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU1SotUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiOhUfRWk3cZmjKAABsJ

On Mon, Dec 08, 2025 at 05:15:09PM +0100, Md Haris Iqbal wrote:
> Subject: [PATCH 5/9] RDMA/rtrs-clt: Remove unused list-head in
>  rtrs_clt_io_req
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> Date: Mon,  8 Dec 2025 17:15:09 +0100
> X-Mailer: git-send-email 2.43.0
> 
> From: Jack Wang <jinpu.wang@ionos.com>
> 
> Remove unused member.
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> index 0f57759b3080..3633119d1db2 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> @@ -92,7 +92,6 @@ struct rtrs_permit {
>   * rtrs_clt_io_req - describes one inflight IO request
>   */
>  struct rtrs_clt_io_req {
> -	struct list_head        list;

It seems these two members alse unused. Why keep them?

struct rtrs_sg_desc        *desc;
unsigned long                start_jiffies;

thanks


