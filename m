Return-Path: <linux-rdma+bounces-15167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B381DCD7F53
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 04:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B30A30141C8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A02882A7;
	Tue, 23 Dec 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kEBJ0kdC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39112CDA5;
	Tue, 23 Dec 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460160; cv=none; b=R4qIZHKkEzRUi6dG/y1eCNLV2K5cTfp6t7ea8BVaUwoTqFFsBbAoZm1kzJHfRuR7BAg92m52/ETAWHV03J4FxxPGqAvrbC8WII3G8Na1Q7rxkIB9FfXUInV+a6gDdhwvMIRrcRz7X8PSyc/atyz/FV80NmEvoWqtqUr49G4WZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460160; c=relaxed/simple;
	bh=LGXYOersx12NO7guu8zp3w5U69pzmSwX09u77EZ/pCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpekmsJsKk2MKYIShcYaXYOuHHi88cGM3Bl+MACciCVDfaFRhFtZajzC/lkjpAuVT8t6QglHYSLXDfjucjDWrB4ebJssa4iDEReJ245aRI3kMdWT1RxWyssCt3v5fUP5mC+ZorQOzGZvTzszsYJ2ACIIal/0ktq0ONdW6d1wiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kEBJ0kdC; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=TsFdCkTNKSKpNoU2DIreeB9FOqWoogDsXfWGVkIGkB8=;
	b=kEBJ0kdChvkrpzwLzZMD8k+kePSh+P4crmSyWY2sW9IG586MyZV/vN9a5swvXc
	76mQA8R9Xf+bCgLl36gRJvQoidKHUdalCVtVK0ryjE7ILA902kI2ebqK4u6dzaoW
	hwjY/Y+6nIp4h0BNdMEQhWVf4TiJGKOJmsqmRbxv+Zq0I=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXmNzlCkpp3_ZcBw--.24421S2;
	Tue, 23 Dec 2025 11:22:15 +0800 (CST)
Date: Tue, 23 Dec 2025 11:22:13 +0800
From: Honggang LI <honggangli@163.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: remove dead code
Message-ID: <aUoK5SoYcJXTpUAQ@fedora>
References: <20251201032405.484231-1-honggangli@163.com>
 <20251218132259.GE39046@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218132259.GE39046@unreal>
X-CM-TRANSID:_____wCXmNzlCkpp3_ZcBw--.24421S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UJw4fGrW3uF47CrW8tFb_yoW5GrWUp3
	y29F1jyF17tF1UC3ZFqay8ZFWYkws5t3yvgFn7t39YvFn5JF1xWr48JFySkFW7JryDGa17
	tr4kGF45Gw4Iy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLa9hUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC6weo7WlKCud1+AAA3q

On Thu, Dec 18, 2025 at 03:22:59PM +0200, Leon Romanovsky wrote:
> Subject: Re: [PATCH] RDMA/rtrs: remove dead code
> From: Leon Romanovsky <leon@kernel.org>
> Date: Thu, 18 Dec 2025 15:22:59 +0200
> 
> 
> You can go one step further and remove rkey too.

You are right. But I'd like to keep rkey for readability.

How about follwing patch?

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 9ecc6343455d..4efb71c04a40 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -208,7 +208,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	size_t sg_cnt;
 	int err, offset;
 	bool need_inval;
-	u32 rkey = 0;
+	u32 rkey;
 	struct ib_reg_wr rwr;
 	struct ib_sge *plist;
 	struct ib_sge list;
@@ -240,11 +240,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	wr->wr.num_sge	= 1;
 	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
 	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
-	if (rkey == 0)
-		rkey = wr->rkey;
-	else
-		/* Only one key is actually used */
-		WARN_ON_ONCE(rkey != wr->rkey);
+	rkey = wr->rkey;
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
 	wr->wr.wr_cqe   = &io_comp_cqe;


Anyway, if you persisted, I will send a new patch as you suggested.

thanks
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 9ecc6343455d..396dfc41e6da 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -208,7 +208,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>         size_t sg_cnt;
>         int err, offset;
>         bool need_inval;
> -       u32 rkey = 0;
>         struct ib_reg_wr rwr;
>         struct ib_sge *plist;
>         struct ib_sge list;
> @@ -240,12 +239,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>         wr->wr.num_sge  = 1;
>         wr->remote_addr = le64_to_cpu(id->rd_msg->desc[0].addr);
>         wr->rkey        = le32_to_cpu(id->rd_msg->desc[0].key);
> -       if (rkey == 0)
> -               rkey = wr->rkey;
> -       else
> -               /* Only one key is actually used */
> -               WARN_ON_ONCE(rkey != wr->rkey);
> -
>         wr->wr.opcode = IB_WR_RDMA_WRITE;
>         wr->wr.wr_cqe   = &io_comp_cqe;
>         wr->wr.ex.imm_data = 0;
> @@ -277,7 +270,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>                 inv_wr.opcode = IB_WR_SEND_WITH_INV;
>                 inv_wr.wr_cqe   = &io_comp_cqe;
>                 inv_wr.send_flags = 0;
> -               inv_wr.ex.invalidate_rkey = rkey;
> +               inv_wr.ex.invalidate_rkey = wr->rkey;
>         }
>  
>         imm_wr.wr.next = NULL;
> ~
> 
> >  
> >  	wr->wr.opcode = IB_WR_RDMA_WRITE;
> >  	wr->wr.wr_cqe   = &io_comp_cqe;


