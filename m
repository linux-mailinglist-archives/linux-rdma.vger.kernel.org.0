Return-Path: <linux-rdma+bounces-13197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D12B4AD05
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2751896910
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C3326D49;
	Tue,  9 Sep 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE8Zcwv2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461C322C71;
	Tue,  9 Sep 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419045; cv=none; b=L/7jg0JZLtVSG7zgT5xZ9FyVV5YzlaEBfiCFu5gQ6E//9397kw5zMlFFkf2BVFXbBgBm0NSQLEbXoZs/nJLPAnqVc+2c9W5Ryf4jvLv1GlqtQjTpV+lvFmKT1aFbZOjg2BjM6mYmCgc6brCD1yqAq/cNiyXOoL3YeRwjfBjm7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419045; c=relaxed/simple;
	bh=fR5d/X+EsmsKupUxUlkgKWk5VbJ0sQISP1sMlP4FhjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ATHqdN2UWKuzUAQHwux0WDlxxu+7YfwTkU0Oq6WfwfZ+/B8GWlnWd1ewghMW0qPo+PKBFDCYnW9nK6+Ypd5IBO5zvVijfJrIg0K1x+FiPNfNBFtiyNJ9PDmdaVKjLKKTSIw5H8fHRdPKCfhWTi60ILFG6dhgSr1r+qRFUZcnAKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE8Zcwv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92B6C4CEF4;
	Tue,  9 Sep 2025 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419045;
	bh=fR5d/X+EsmsKupUxUlkgKWk5VbJ0sQISP1sMlP4FhjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gE8Zcwv2XCCoAOJLKy3/4qtBmKTAvtbcQ16VAyoQJnNbt6guE1KfUHL1FUs9SEvhz
	 V/GZpq7dZb+LWZP/3z9IfUqMm9j2cOZiV1ITviLacBLZtNJk831kVZjC6zWtdgDQL1
	 kRwEu/Bp6YuWn57PmMmHjj3dPYGAEGeUm7HAQXAXOzdBjO00GCQOT9g+Z9BWfwT/mu
	 akzPio98WZirQIzh5y+vrCFFR5BZDWmKZ3uAWNSUHJaZxdKDGgsvE3dKpz9UpWjnZ4
	 LmpzAEqz0z0xgjYqiHsBwRf/DS+x6I6Gi6UOud3MKGrVprG/nbqSWlJc0OY4IQ3JFa
	 rGXrapxbX2mcg==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250901150038.227036-2-thorsten.blum@linux.dev>
References: <20250901150038.227036-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] RDMA/bnxt_re: Call strscpy() with correct size
 argument
Message-Id: <175741904219.708611.9150229525222115606.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 07:57:22 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 01 Sep 2025 17:00:39 +0200, Thorsten Blum wrote:
> In bnxt_re_register_ib(), strscpy() is called with the length of the
> source string rather than the size of the destination buffer.
> 
> This is fine as long as the destination buffer is larger than the source
> string, but we should still use the destination buffer size instead to
> call strscpy() as intended. And since 'node_desc' has a fixed size, we
> can safely omit the size argument and let strscpy() infer it using
> sizeof().
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Call strscpy() with correct size argument
      https://git.kernel.org/rdma/rdma/c/9eda7148f0f78f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


