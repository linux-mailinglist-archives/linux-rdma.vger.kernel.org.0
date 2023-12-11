Return-Path: <linux-rdma+bounces-344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DE80C270
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 08:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CBB1C20959
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C620B01;
	Mon, 11 Dec 2023 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAHaWvmz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A96208A2
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 07:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E202C433C7;
	Mon, 11 Dec 2023 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702281410;
	bh=mgvZF0/Qj7hwBrJmPgMLGbj+s6Omnq2b7TkPy0MjR2g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GAHaWvmzXmykt+SAmYPuYCpuP6DSXL/vyYkBnirNyFanKD0pF93WVG0UDzouTk+WH
	 XnQkRxtxeXwNXtUVYPmUMrOg1idX1xpc4WRzzSao4P2UtUh20oOsQ87Do2nXC9S7jk
	 p7vLfPK4tmLNpQXpep+5crkRxOVzunNFmqtVwWxGa+vtFrzhTN0X1GJT6VpYBGijJq
	 yZRg+ekSknxzZfeLyUxcmYoFQnavyOzPudDFacCw8U2h+DQUba71XGigMGlIOhcZXS
	 EZQOlsPeWLmfSoHRVukbAgc+KoeMq4D0Wu3A7jRtZz9n7e3xT5nvfkxr9dEREdvRV5
	 YhL4sHo+fqYAg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Subject:
 Re: [PATCH for-next 0/6] RDMA/bnxt_re: Initial support for GenP7 adapters
Message-Id: <170228140597.18735.8413571902520352314.b4-ty@kernel.org>
Date: Mon, 11 Dec 2023 09:56:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 07 Dec 2023 02:47:34 -0800, Selvin Xavier wrote:
> This is the first series for adding support for Gen P7 Adapters. Includes
> the basic changes to detect the device and load. Adds the Doorbell changes
> for the new adapter and MSN capability to enable the FW initialization
> of the adapter.
> 
> Please review and apply.
> 
> [...]

Applied, thanks!

[1/6] RDMA/bnxt_re: Support new 5760X P7 devices
      https://git.kernel.org/rdma/rdma/c/1801d87b3598b1
[2/6] RDMA/bnxt_re: Update the BAR offsets
      https://git.kernel.org/rdma/rdma/c/a62d6858144166
[3/6] RDMA/bnxt_re: Update the HW interface definitions
      https://git.kernel.org/rdma/rdma/c/880a5dd1880a29
[4/6] RDMA/bnxt_re: Get the toggle bits from CQ completions
      https://git.kernel.org/rdma/rdma/c/6027c20dad1ad1
[5/6] RDMA/bnxt_re: Doorbell changes
      https://git.kernel.org/rdma/rdma/c/cdae3936b2fe7f
[6/6] RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
      https://git.kernel.org/rdma/rdma/c/07f830ae4913d0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

