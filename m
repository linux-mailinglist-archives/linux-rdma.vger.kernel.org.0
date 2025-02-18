Return-Path: <linux-rdma+bounces-7806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A2A39D71
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B17A7A2596
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F726B947;
	Tue, 18 Feb 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh4dROgr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2046269B05;
	Tue, 18 Feb 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885270; cv=none; b=p1ru/4rY9Sjlgl9oA63Qk6KHNVyzIr9+t9rNNkxotvAg541Iog0yW7WP4tJa/+WD+08Ylo1ZIArb2YrHJF7x+Pjv4hOLr7RUcub62Two19Qj/Ce89C+6J9bDaBZREwWvpNLeLdfjnLmZHxJQrJLdYR4SPeumZfwZe2nziQPa/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885270; c=relaxed/simple;
	bh=yDmvv2RRGXVB1JkDdHxyX23GBsKptFVSowKC9tzQzZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ffxEhpsx23XcrqMo/EJvjpvTtW0RTAKXZ5VwqXI2TMn8JxdB5LSNYHcIzThxXCOGJ9o2voFA3W219wuXhvuvGA/XFsvfpjJf2gW2HqidSfhA7AuXdl+9HqJsiOtzaxulB/FKPpwaSC7jhU/d1tF++J34y2IQOUOfNdNqcoSzzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh4dROgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58ECC4CEE2;
	Tue, 18 Feb 2025 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885270;
	bh=yDmvv2RRGXVB1JkDdHxyX23GBsKptFVSowKC9tzQzZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dh4dROgrCKGQjtVcAMo05MX/RfV5GjAdV4lYHAEO+C/sPfc/Q9hyRojQ+dFbnPUfW
	 tFr6MWkpcOkBgb38trIcRCWOZiMjADeUDr0W8S9qC8G1Hz8CsFtjgik81aH+8gz92s
	 aQqyQajTTJlRXLSX/0Brs5H6zXnWh8DRXOCQQOu0ypZ93Q/oM5JKF7tUNvT1+c/nqs
	 jhkTJV/UoMcZ+I1bAkxBE7UvsA2eAN+AhsUgXzmbujTrmQeCdqujq2VAalHdBFmAYx
	 9QXF9UP5wkblIkVVXLRIRMw9MZX73lVeaIPlVVDYvvVmMOlqRtOSnsM/G8i0Gra3FW
	 MReDAJRh9pPkA==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1739454861-4456-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1739454861-4456-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: implement
 reg_user_mr_dmabuf
Message-Id: <173988526667.362922.11374741994452164893.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 08:27:46 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 13 Feb 2025 05:54:21 -0800, Konstantin Taranov wrote:
> Add support of dmabuf MRs to mana_ib.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
      https://git.kernel.org/rdma/rdma/c/ffd67b6b420d05

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


