Return-Path: <linux-rdma+bounces-8620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512ECA5E3BD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD93BC09C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68725745C;
	Wed, 12 Mar 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aILb36NL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF82571A7
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804578; cv=none; b=OAWuxGTwJ1By7BHvuCX5pCz7/w1h8YxVVuJTXuoDQUdTEQyEAUp8xkJR0WPVfbYLChcQAK1NP3eNP1f6qpdLNwTuyoDZVBe4LCXMWJnMrWfi+Keqqxk4+fxAU7LLqq/OuaO2XWTJRbY6KKnwNznxw9qSbIceUELbM278LcfNyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804578; c=relaxed/simple;
	bh=bbU1yaZX7goX7ohGt7FqYjzVeXuGuf5iiPTQpkygFQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s0WfCq1Cz9G1HZN85MhEqr1UJEMctocp+VFJ0MWgGKv3ZlpqadV09sdjhOH3Qwn5GYSImd8vlu7gYH20Ft/5JQT/wkumibbi/pvAHsZ/o2SwDUs+Q5z9QcG9d2inpINWYKw5kFafOEMz+v0qzo2GU23kTwNnnX+KF3cyhrUkngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aILb36NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EDBC4CEDD;
	Wed, 12 Mar 2025 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804578;
	bh=bbU1yaZX7goX7ohGt7FqYjzVeXuGuf5iiPTQpkygFQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aILb36NLLqKO50nwjvh3ZWDGmv7PVbgMj87ZquaCKyNmF91lfhkWhWwx5C/fehybF
	 1kX6IXLQD1JUCIn4ei2HIy/uJ6/c0/XgTEIHXtCJEsSEOhRXidbf236nOcTqVopYpZ
	 B9lUgQE0K1rfwgl1jg/rIXjKh/+gzv+yqTUjcsLIXyipoYQBqHkFL6HuXPIKCOk+3B
	 cDfvMzNBYP0neDXfnbhsyPYgmu6MGz8LlFAJZvQ43tbzLdlFXqHy/f4zvzyuJxsTfn
	 uelPbdbNJEWtNsTswuJFy9tWTUq9hNks0fEMXPr5738uqzhMDtAmqxlW6OSZinAys+
	 WYs5+6VxnrN+A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc 0/7] RDMA/hns: Cleanup and Bugfixes
Message-Id: <174180457486.526331.13319540305783041507.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 14:36:14 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 11 Mar 2025 16:48:50 +0800, Junxian Huang wrote:
> This series contains some recent cleanup and bugfixes for hns.
> 
> Guofeng Yue (1):
>   RDMA/hns: Inappropriate format characters cleanup
> 
> Junxian Huang (6):
>   RDMA/hns: Fix soft lockup during bt pages loop
>   RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
>   RDMA/hns: Fix invalid sq params not being blocked
>   RDMA/hns: Fix a missing rollback in error path of
>     hns_roce_create_qp_common()
>   RDMA/hns: Fix missing xa_destroy()
>   RDMA/hns: Fix wrong value of max_sge_rd
> 
> [...]

Applied, thanks!

[1/7] RDMA/hns: Inappropriate format characters cleanup
      (no commit info)
[2/7] RDMA/hns: Fix soft lockup during bt pages loop
      https://git.kernel.org/rdma/rdma/c/25655580136de5
[3/7] RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      https://git.kernel.org/rdma/rdma/c/b9f59a24ba35a7
[4/7] RDMA/hns: Fix invalid sq params not being blocked
      https://git.kernel.org/rdma/rdma/c/13c90c22204976
[5/7] RDMA/hns: Fix a missing rollback in error path of hns_roce_create_qp_common()
      https://git.kernel.org/rdma/rdma/c/444907dd45cbe6
[6/7] RDMA/hns: Fix missing xa_destroy()
      https://git.kernel.org/rdma/rdma/c/eda0a2fdbc24c3
[7/7] RDMA/hns: Fix wrong value of max_sge_rd
      https://git.kernel.org/rdma/rdma/c/6b5e41a8b51fce

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


