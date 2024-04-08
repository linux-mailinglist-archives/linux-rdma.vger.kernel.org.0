Return-Path: <linux-rdma+bounces-1842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAA89BE1D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 13:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BC61C213B1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B84C657C1;
	Mon,  8 Apr 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMiBitlA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAC3FB81;
	Mon,  8 Apr 2024 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575696; cv=none; b=jM3lzC1TlP8M+fRuXNzcHQ62WXfCIK3yqhxduJ4wHW/Hdy6lPb9CtwMWsl0aWfkwn48Vbx+Mo2HZYIunTNlG5OkrJRkPmJJgrr33WfjeI9amDUb9l+sbj8BNvSBvzQjN5dCfAr2jnpi7HuH9Rf0bsjQkjopBsRtcRce6oUsz6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575696; c=relaxed/simple;
	bh=lLTbowSwzeWgkAL21lpvXAkbdwYlYSLAD3ZBr2JGCBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I76e0DmGQsuIeOSez8xCHhlE348f8xqZM44eu0cgFtzR43HiJfrviWxQMycjvKuncGg/Jy7wDY72G3HIar5iP43DJO9xFzLk+NWiK6WPK5lJKxzXOHE0/rQWCkcq6GPtTUISlpdQy1dQZnrnP+3uew9oUZavF75sNhv0HfnqWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMiBitlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E368C433F1;
	Mon,  8 Apr 2024 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712575695;
	bh=lLTbowSwzeWgkAL21lpvXAkbdwYlYSLAD3ZBr2JGCBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RMiBitlAmuZknqrpwEYtL3q6KeUjV9jQzXEA+VMelz3aM7+SV4DS1oh86qt4lkDYJ
	 xrX6jdkv3Xy0goVsToydhX6vl6V+gqItnfLOV9SYzOm4nKOAvE1AMYXlJDCi7dCGfL
	 yYYMG86np7ABpTOI7dwYIy1WTdzI3ZYgK0/cJnHAr41J9je0eZ6yiZokP5iH89wB/w
	 lwKOwGt+mZsP9QKQmb0Z/7dKqKVxiQtibhiv3eBkDqvc60XoV9VuQrA1b1QeqzvrCl
	 SM+6XQo6wiVfGPyZJ0akKyHVZr05FTpDvMGGINjWESosJ9SG8k1Fz4E4vQNko8of63
	 OXZEslCFpOYsg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
References: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Support DSCP
Message-Id: <171257569273.115037.9184913634596731281.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 14:28:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 15 Mar 2024 17:35:51 +0800, Junxian Huang wrote:
> Add support for DSCP configuration. For DSCP, get dscp-prio mapping
> via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
> UD or in QPC for RC) with the priority value. The prio-tc mapping is
> configured to HW by hns3 nic driver. HW will select a corresponding
> TC according to SL and the prio-tc mapping.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Support DSCP
      https://git.kernel.org/rdma/rdma/c/c3236d538646c8

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


