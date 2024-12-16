Return-Path: <linux-rdma+bounces-6541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EED9F3165
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 14:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CA67A299E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B204C25;
	Mon, 16 Dec 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyrtwwfL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBA204684
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355246; cv=none; b=u8V2PCFJ3HTP+E6Bt5juSYO1bgasjhBhf5RvY8bKvmPDQ/AXRckQ5asrZloXofepOROJRUYrY4Vl12O8Q3I1YgACokRyS7pSO4kHyUo84zURYf0HAsbJCFO9XM2yMtD9r5O3uAHWrMKOY4CYbXYw6f2+vB0cDUuAg2RwlOgYx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355246; c=relaxed/simple;
	bh=corGHlYga3Q4Z9N3r4Xyim5ewYFPPdIMXRadJOvl0II=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JEvh/Riyg2TW9s28/O7kVR8bnu2VGOi+dP02nwLsecwpnD/h+RbWFBeWVRKQmis4vpRHm3rPRFZ04sMhQlbeZ1+jZ49CYVqaSg4ufF3Uepll1d5qcYU/6NghfqFOrn99x0KPiAz3q89oMeHfnLTUEudLsejzitxJMh+q+ttYHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyrtwwfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEC4C4CED0;
	Mon, 16 Dec 2024 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734355246;
	bh=corGHlYga3Q4Z9N3r4Xyim5ewYFPPdIMXRadJOvl0II=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UyrtwwfL6rPCrwDrzAdshHhyZiz++v3jceHsZOAKespMdqOlFetxluJ6GJCkUpphK
	 /V0OPG5xJ11drvU4NovsJHX8t16wvyZABzupf3Dy606FIkrCzHWpaKkTaUt6yNYmwf
	 /EMYeKxFRL1VNkuhH7IA/KBfvaaN/n7pIPd5jRZAFWSRiKF4WcHZlZdTqm7cz/MunQ
	 BoSvvcT5Tb57y+VCxA/Ts6ypRzbnxwBWmJ1zjSHrexwx2meuORXm39crxujSO00uED
	 jnLZMBjF5WQmo1WKdk18EEBSZ/XnNs2eUch20fcX6VulDiSZIMqCy6nUr0sqacKQGN
	 yb+zSUK7PbzFw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Boshi Yu <boshiyu@linux.alibaba.com>
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com, 
 chengyou@linux.alibaba.com
In-Reply-To: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
References: <20241211020930.68833-1-boshiyu@linux.alibaba.com>
Subject: Re: [PATCH for-next v2 0/8] RDMA/erdma: Support the RoCEv2
 protocol
Message-Id: <173435524338.183876.2979930550772102026.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 08:20:43 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 11 Dec 2024 10:09:00 +0800, Boshi Yu wrote:
> This patch series introduces support for the RoCEv2 protocol into the
> erdma driver. As the most prevalent RDMA protocol, RoCEv2 is widely
> used in the production environment. Given the extensive application of
> erdma across various scenarios in the Alibaba Cloud, there has arisen a
> requirement for erdma to support the RoCEv2 protocol. Therefore, we update
> both the erdma hardware and the erdma driver to accommodate the RoCEv2
> protocol.
> 
> [...]

Applied, thanks!

[1/8] RDMA/erdma: Probe the erdma RoCEv2 device
      https://git.kernel.org/rdma/rdma/c/a883e71345a010
[2/8] RDMA/erdma: Add GID table management interfaces
      https://git.kernel.org/rdma/rdma/c/6edc15abc256f6
[3/8] RDMA/erdma: Add the erdma_query_pkey() interface
      https://git.kernel.org/rdma/rdma/c/14bcf7354a0ed2
[4/8] RDMA/erdma: Add address handle implementation
      https://git.kernel.org/rdma/rdma/c/41dcaf48ff9e31
[5/8] RDMA/erdma: Add erdma_modify_qp_rocev2() interface
      https://git.kernel.org/rdma/rdma/c/9566cf6a7742f2
[6/8] RDMA/erdma: Refactor the code of the modify_qp interface
      https://git.kernel.org/rdma/rdma/c/de5b8008aa4da7
[7/8] RDMA/erdma: Add the query_qp command to the cmdq
      https://git.kernel.org/rdma/rdma/c/1cccbd3eec3d63
[8/8] RDMA/erdma: Support UD QPs and UD WRs
      https://git.kernel.org/rdma/rdma/c/999a0a2e9b87c4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


