Return-Path: <linux-rdma+bounces-8403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369EFA544B5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9689170BDC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244A1FECD1;
	Thu,  6 Mar 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1/7C5ia"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F81C8602;
	Thu,  6 Mar 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249388; cv=none; b=NpvCXiU37CFNDjeZqQ4uqCyJt8zOPGFuP5dQMfaOc9W++LFY/a7MLRoRate0DHTGFhdAO/+BdbRu3NBsTA1SGFm3r8Fi9B+eTHfCC+aHMTtxDMZI30QlW6clOJmJiACiUmEcrIDY5dCWfhqKVGRpTZVTYvaq/j8areSqSBJwAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249388; c=relaxed/simple;
	bh=m0O/gtms73lRwWWSENneHLmwqpuQFsbBbwXE5dP5hEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UYjpz25VLPYi6d2rqDvYPal4YBkqYMMCIMIgxKP4qnhZ8wknpj0E63Hm9K+YNp6ONiSgXljUGudu+vZ3zpbFEyXcjosE00ssK/wRYzU4iduozQz1IvYCWe7hByRq5n47CY7qc3rElYR2nOASmkZJBtFgWxbUf8vA7O7hcCP+L54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1/7C5ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C67C4CEE0;
	Thu,  6 Mar 2025 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249387;
	bh=m0O/gtms73lRwWWSENneHLmwqpuQFsbBbwXE5dP5hEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R1/7C5iaFtLmxiSdmxkBJCo3yF0xYyxMDD1ojG82oc0+rZ1bTKQdD9ptR77Em/dUu
	 3HUhEI2xU+yspO5E6sZ5r8Trt9BusMety2MmZkJP1uzw24fSt4kHggzPWa2VxRCgDO
	 xgPOxyJmlpF4quaPFusmOhHvZbDXKGei65XVgJrKZH3OKRn0oyXcuIHksp2YH7lkHU
	 biHZhOPdh2rq7eepCfdVPpFsPMpE+BxQfR2d+ZbprhudTN7T2MR0K8ERFVpInW1Srz
	 2l1GdgJ153W1S7sOkkWMYNwK2rKg30LO6cHSAtFhRgXctEqGgIe+OYl6HMrK9glFkd
	 sVikj3wuDHwcQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Qasim Ijaz <qasdev00@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250304140246.205919-1-qasdev00@gmail.com>
References: <20250304140246.205919-1-qasdev00@gmail.com>
Subject: Re: [PATCH] RDMA/mlx5: Prevent UB from shifting negative signed
 value
Message-Id: <174124938333.256459.13549544178260242325.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 03:23:03 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 04 Mar 2025 14:02:46 +0000, Qasim Ijaz wrote:
> In function create_ib_ah() the following line attempts
> to left shift the return value of mlx5r_ib_rate() by 4
> and store it in the stat_rate_sl member of av:
> 
> 		ah->av.stat_rate_sl = (mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
> 
> However the code overlooks the fact that mlx5r_ib_rate()
> may return -EINVAL if the rate passed to it is less than
> IB_RATE_2_5_GBPS or greater than IB_RATE_800_GBPS.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Prevent UB from shifting negative signed value
      https://git.kernel.org/rdma/rdma/c/556f93b90c1872

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


