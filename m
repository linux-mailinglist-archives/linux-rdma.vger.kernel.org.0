Return-Path: <linux-rdma+bounces-741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CE83BE3E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9938A286C15
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E881C6AB;
	Thu, 25 Jan 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSuRkmKt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C651C69A;
	Thu, 25 Jan 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177015; cv=none; b=n1owgdYZ6oGILjEUCQ1y7j7Ep6gwPIaN1AhpCCM89WNOSedqXQKKJAqISFh2AwgMaSRJHYmKFw0jc8vg7UIM9cpbfOHqYGNsaqrxtrWqlzEVG6omoGBHE9LKadwx6usfLppJI50jOj0enNDmrw4boXr5bhkCWR6IZRA5ZSoMhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177015; c=relaxed/simple;
	bh=EkYisJpwdiBDSByJVPEqoe/aBzHVDCKYcLz+CjtlS3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lbrKkXh24lwyxWBWgrjwFGADUAkOL7FsOQc/wzuRw6U1U0n5QWp9NQHEmENPDJRtggymTqVrTz27ursA9tPRJ5fLaUgyECX/F8YakHZPBACVxdZb0ILVuXxV+n+dYUULJHXvAHirFcVu/RXTs0unSB4ipISZ8FZ4eAu3R0w9tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSuRkmKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16256C433C7;
	Thu, 25 Jan 2024 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177014;
	bh=EkYisJpwdiBDSByJVPEqoe/aBzHVDCKYcLz+CjtlS3E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BSuRkmKtHJCmd2n80RNEnU/uAMArAkO/QJXJsF3NRwAmMbeUBQBG5a2p+nSiknQwK
	 dqGiD58Wk/d5Du2mzp3lmGsVyH6JgudrIKrn3qU8duxUxjdMKnpWq89RVVuSFORK7J
	 2TnW7I2Fo7VdWta3AsHEmtcK1zSQBkf2h2uKCfW+Db+y8KIm/AKhXFt2o3eQxx9dbp
	 SesmI867EIr1Y8RMAuZX/Jm+/Fo3ztJ9e92lX0o1tpYaUB6E9TeRTts0AVWIn9pJNi
	 nNuMhBSDL9kPUb1/oazIcSN4d1xmUzDgr+1hMccATWyRxsjw1PYhXySwm3L1h8UEl6
	 sCGeXU40XL9Sw==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v1 0/3] RDMA/mana_ib: Introduce three helper
 functions to clean code
Message-Id: <170617701011.634075.7695135572481942797.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 12:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 22 Jan 2024 15:22:58 -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patchset aims to remove code repetitions in mana_ib
> as well as to avoid explicit use of the gdma_dev.
> The gdma_dev was either ethernet or IB device depending on
> the usage, which was often easy to confuse and misuse.
> 
> [...]

Applied, thanks!

[1/3] RDMA/mana_ib: introduce mdev_to_gc helper function
      https://git.kernel.org/rdma/rdma/c/71c8cbfcdc8f1d
[2/3] RDMA/mana_ib: introduce mana_ib_get_netdev helper function
      https://git.kernel.org/rdma/rdma/c/3b73eb3a4acdf5
[3/3] RDMA/mana_ib: introduce mana_ib_install_cq_cb helper function
      https://git.kernel.org/rdma/rdma/c/2a31c5a7e0d879

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

