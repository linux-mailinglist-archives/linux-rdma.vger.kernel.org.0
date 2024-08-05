Return-Path: <linux-rdma+bounces-4203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AE947A27
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 13:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E30F1F21911
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C44153BE8;
	Mon,  5 Aug 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmKzsfHv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D91514C9
	for <linux-rdma@vger.kernel.org>; Mon,  5 Aug 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855652; cv=none; b=ckf+B34ZGt/cGBOhlw6yQ76oMhVBhefyEp3xO9eF1qqBA6q7moWrPeSwHZmb0ysUXAnqUFgpW/36BhMxm9ytKjUqYYlFFtOAz+KJwz95MBybojCYxoOEQEt8C2yFHcf6HtbNabvcms823IZsdmfj/0lCbDhTVjASEJ0ZBehHCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855652; c=relaxed/simple;
	bh=aOEiFMoJ33SmMluLCm3VV8jc7dx46h6cTfBbKwXj7wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJEJ0P7gj8m0Uru27MkOZcqtRRtjy0zovdkOeVJr59Bw0KAZzdH1duCrSrOffhNSiwS/iKbbfgG0k/11r8VEtY9FoEjKpv395k3xOB0cagJV5EQP4p4EeIAMoIDPH5QVyoQQF0RlcDq2TLzchXD/Dae7Laj0i98mBY889dkJQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmKzsfHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFFC32782;
	Mon,  5 Aug 2024 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722855651;
	bh=aOEiFMoJ33SmMluLCm3VV8jc7dx46h6cTfBbKwXj7wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tmKzsfHvJV4Kova+wZuOGakcYZdW8kjtm9PDIxrps6sCAlctiXmEFys2OfTPYCWlq
	 uCRkPH4ike2YMhjWeboF+XfSQ7e8l08e6q2+y2vM8bin8TppkleIl6xNboIMqXBKbY
	 m6jrQtB6meH/GE+usnEZN8j88MGbDQPKCvoARlzhnpC/J45l8N0VZkuLvFyfubCnbr
	 5iOmGX1U33EjytLXS2JPiVqaeAjaZAERYEv3y9J02ZUbpYxvG5Op6bh11I2uEZjagA
	 wYUpQZrUw+OXRc1ypypavuadB671YuphyaYiTtQ9POAo8FTjB+xQ9My0TuS7JSk4wT
	 c/Ou9fSutOe5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <41dea83aa51843aa4c067b4f73f28d64e51bd53c.1722331101.git.leon@kernel.org>
References: <41dea83aa51843aa4c067b4f73f28d64e51bd53c.1722331101.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Expose vhca id for all ports in
 multiport mode
Message-Id: <172285564668.428749.4095850145353082986.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 14:00:46 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 30 Jul 2024 12:18:45 +0300, Leon Romanovsky wrote:
> In multiport mode, RDMA devices make it impossible for userspace to use
> DEVX to discover vhca id values for ports beyond port 1. This patch
> addresses the issue by exposing the vhca id of all ports.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Expose vhca id for all ports in multiport mode
      https://git.kernel.org/rdma/rdma/c/d29d64e8d65960

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


