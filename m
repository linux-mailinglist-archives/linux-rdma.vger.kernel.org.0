Return-Path: <linux-rdma+bounces-2154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453518B6F7D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C2D283269
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28C129E72;
	Tue, 30 Apr 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvv3hbjQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC10129E7E
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472339; cv=none; b=VX/HYD6NCtVG5MJ2VlmpXJQgh6/VnHFtjKZjwuQ/5lQo0797AdHdxt+TqetnvBtGL8J9fqKCzVEv4ytYB4WlXfJS8O95WE0/5EFMfqArnQbJP5rJ1G/xbiDIOljNcIl2byDziovQoeG2cH7fCsON79/FXgKhCTD8X68UtbTu/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472339; c=relaxed/simple;
	bh=tiyS0brJq0gF/SEpsgKeTXgkydUlU/Cmlqr3ij6EEYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GmsDlWxRfTjEfZNNw6y8aFHfezivOFKzK+Z/T0JR3KW9xhqILQAyAg8zuhwBZ6OGt0IwG8QckG2U9O3mraJUc8O4doKxvO+JtJ/6ARyG5likGqickOrP8f4I5gVNeVRh7yVAgFsW8njVtCFvtqcW8GWSdL2ggGOZS4VHTgoIH9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvv3hbjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A5BC2BBFC;
	Tue, 30 Apr 2024 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472339;
	bh=tiyS0brJq0gF/SEpsgKeTXgkydUlU/Cmlqr3ij6EEYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wvv3hbjQLAX2XysK3qTCp2Erq3TJuzaeVEZa2od0volHRL51c5QSLlp8GCfDXrVb+
	 Oh1KxG70mrA9bAf3z/QqkTUgoWpb+PwUfN0cSyH2pcNJh1OnXz6jUaHiHG9q5zeTPm
	 DWXgSHMCk6bqsqZQboATbSv2JKnMogNcfnnj64JRkDAB8LUAj0F7/IvyeAdek3QzVM
	 gGKQelEu9OeTslb/u6sH0SJkujfyyD4nL7V9m2jyAXeN75iKFT6IHI/XaDpeXMRA11
	 3xoendl/FbA3mOlYJX0zAjquRLTdmFBZCduXiOZ3CYDzVx/tfegLRBIEecituxp2uW
	 2zADdbUqmCSlg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org>
References: <2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] RDMA/core: Add an option to display
 driver-specific QPs in the rdmatool
Message-Id: <171447233535.87755.5228812010570551466.b4-ty@kernel.org>
Date: Tue, 30 Apr 2024 13:18:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 16 Apr 2024 15:03:50 +0300, Leon Romanovsky wrote:
> Utilize the -dd flag (driver-specific details) in the rdmatool
> to view driver-specific QPs which are not exposed yet.
> 
> Add the netlink attribute to mark request to convey driver details and
> use it to return QP subtype as a string.
> 
> $ rdma resource show qp link ibp8s0f1
> link ibp8s0f1/1 lqpn 360 type UD state RTS sq-psn 0 comm [mlx5_ib]
> link ibp8s0f1/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> link ibp8s0f1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> 
> [...]

Applied, thanks!

[1/2] RDMA/core: Add an option to display driver-specific QPs in the rdmatool
      https://git.kernel.org/rdma/rdma/c/e18fa0bbcedf82
[2/2] RDMA/mlx5: Track DCT, DCI and REG_UMR QPs as diver_detail resources.
      https://git.kernel.org/rdma/rdma/c/fd3af5e21866b7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


