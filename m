Return-Path: <linux-rdma+bounces-14414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56405C51329
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D723B3BA276
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7422FE053;
	Wed, 12 Nov 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2snCHXg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6642FE045
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937365; cv=none; b=aYamYwRLVyeXnCEnnQsqEMK7b47exSWNrC8A6ysDUIaS1qJblHIVmzn4EF+cngXJFwCxRfcOJ1NJcA3+UPjq2MtE5jIDiWCPOaQVWkSRT/KWjJCEVNTa1MSfd20sVw9AvJeBY5UY7l/Psu8/3bLGi4ETQstGSMPtmeOcG/1qpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937365; c=relaxed/simple;
	bh=941PI/PGM7Os4X1vwhDP65qnAmaeLmqeW4XPXmyCFhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsCEMNZdkMsUf8PljyQuYdKy/NZ2Kn4KN8U2rp9Pwl00JnzadDEROyD9tV8jrBd/p5oAQ+HPFPD3A1mlQY7wq6CnOnyDjdn8OosalX4cK6LhTO8YcLXTkynUA7Yp4kk7xSSJgb4c2JyU57FrlQfYdbuJf8IhKv+krvjWo6BZzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2snCHXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F8C4AF09;
	Wed, 12 Nov 2025 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762937364;
	bh=941PI/PGM7Os4X1vwhDP65qnAmaeLmqeW4XPXmyCFhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2snCHXg4Vo+yxv0vn0DVT3aIP0y4yA9EZNigDD3rtnO0VbIHAjRQuRCjHLmpFANP
	 tSeKgHvvdQis9FenxC/KP9YRgTmuJdf9NYDDXpALLNRwBTHwIOo7JmQHNarn+5UPGW
	 00dEPBOQ0oxUCkQAVc22fLTkXGNurJNHyQamy4zGOTFr2JeYeeyq/EU5K7ccFNHMfA
	 VDQ5nXMOG3Dnjz5vrs38meDpUyGQqvu4sxBiPzM0OrdwdB+QtlQqrOA+FispcTLS87
	 kOWJoxem9d6qSTMErY6q/RbyAWaLXZ0ZIXU/hJ3z34JKfs0TBWs79FV+KQnxYffD30
	 +hDISbOPpKtRw==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Jacob Moroni <jmoroni@google.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/irdma: Remove unused CQ registry
Date: Wed, 12 Nov 2025 10:49:12 +0200
Message-ID: <176293717263.866356.12244984018242128294.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105162841.31786-1-jmoroni@google.com>
References: <20251105162841.31786-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>


On Wed, 05 Nov 2025 16:28:41 +0000, Jacob Moroni wrote:
> The CQ registry was never actually used (ceq->reg_cq was always NULL),
> so remove the dead code.
> 
> 

Applied, thanks!

[1/1] RDMA/irdma: Remove unused CQ registry

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>

