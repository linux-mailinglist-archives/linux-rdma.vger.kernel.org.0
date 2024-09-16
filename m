Return-Path: <linux-rdma+bounces-4961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D025979CC4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA43EB22C48
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502A13D2BC;
	Mon, 16 Sep 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQtWElH5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBF13B590;
	Mon, 16 Sep 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475220; cv=none; b=u96dd2zDPM/wMiNDPjlecD8fTDa6c7v9ZAiGUn5tmtXw9EYg5fL0nVzO0gDZvhE9oarOqdaJmpl8ViFH7reemMKB2vvd/SHsA7CkyFHPjPgJ1ssMngJnCnTmBQG99enq3sLrCHreIy7RGhMk5kQBnU+onMR1mz2pz8ngTllIfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475220; c=relaxed/simple;
	bh=8DWtL+EHyERRG8cXzzPmiDSBP/gLfpuRk2nQC0QEpnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dcHt+MwxiVwmnX8ufBxM0Givv89PDnjGw7c7GgIMCcSAHCIaj306GKvEz7ZhrBTsaDsWcW34jai3WeRAl21LsP7HJ2FztIRfgQIZtZ/RFDjENLOUPFQKkST282qshn94Ow7GC3kY3hqqqhVrjhPV98sEtpFgFKTNjOhY+UJY1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQtWElH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90998C4CEC4;
	Mon, 16 Sep 2024 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726475220;
	bh=8DWtL+EHyERRG8cXzzPmiDSBP/gLfpuRk2nQC0QEpnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hQtWElH54zW8d+JdbGuYzuJhd24vbDuKLRIpnuS9ovMJjP46HHveCFDaX+2Dm+Atr
	 40YXyNJDqDkvbaGr1Hh3TUDblLX/ctuYieLJIgRJrFKYHVwmLtt7iUmUtOSp6E3m3D
	 4hBEWUVlvVmdzkW6N5MrboZxytKyrAc5CXFvpnxy9y9LeIixYoJaY5NxjpyCn5CKQi
	 iU68cxdrbaad2SDIlxOi5Ve/1Xmw4E5FGgN29aiAzdoNiU8/XIwXoZseL55K3LINVn
	 yiuYQ2Jxkb2VAF7e6e6JBn8WUH2W57ZQYX7R2TXLFUu2XNXN1suK70vwjAHs1IT6MO
	 IU95XoPEKc+Ww==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240912115700.2016443-1-huangjunxian6@hisilicon.com>
References: <20240912115700.2016443-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix ah error counter in sw stat not
 increasing
Message-Id: <172647521530.863326.4779292576968824657.b4-ty@kernel.org>
Date: Mon, 16 Sep 2024 11:26:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 12 Sep 2024 19:57:00 +0800, Junxian Huang wrote:
> There are several error cases where hns_roce_create_ah() returns
> directly without jumping to sw stat path, thus leading to a problem
> that the ah error counter does not increase.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix ah error counter in sw stat not increasing
      https://git.kernel.org/rdma/rdma/c/39c047d4047a12

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


