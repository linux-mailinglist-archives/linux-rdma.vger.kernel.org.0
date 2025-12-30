Return-Path: <linux-rdma+bounces-15242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29FCE936B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C1C301DBA1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E527F73A;
	Tue, 30 Dec 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVijP6cg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36F25B305;
	Tue, 30 Dec 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086888; cv=none; b=Bs2CPvqdQ0YO0KAKMGqScoP/U8vNrWVoC7Ksc80JuB1sR/p7m7sjNIHfGmVFE6hFOpDOFs6q3XLKXcVKJ5G02NJEbwoXlZX2iFS+v8v0kNpLIGdppXWSognlQ9dESgrBUk+IADzcV3Ub24iaohfNfPUqDKwFzEx0GQObD9bvANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086888; c=relaxed/simple;
	bh=22vg4kpeZxNtpN7bWE8UeH7uE+4QH9zDG/cjk+opXvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4Dig7gAlVzMW/8xNYvbZv9zPR37tpr6RmQHX9VI2QnIhcpplAOsM3Q15cOKChr2fe00SLQmPKNHmGBoUJYe4ghl5jpPLFgn4c0jIQa5pzrD+JIEIRWB36HjRX6wWg/qFDBsMwYcHeEe0fBHlWtu4yJCMnZch2bAu8DJs4pYmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVijP6cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E0DC4CEFB;
	Tue, 30 Dec 2025 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767086888;
	bh=22vg4kpeZxNtpN7bWE8UeH7uE+4QH9zDG/cjk+opXvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dVijP6cgMi+8/wACzdWKfREZfga5xZl1QzJq3s/TqVMbYttV7a54oX36PkXA+pdhg
	 BK+d7i1HOQRqRPWAFQjNebUzizXJhoC0K/ZP3Kiq0ze4+BeJnWz84NN+rJriIgd3vO
	 CCn72vvNiRdAutGQ0WhFPIZzmQCFpbcp8Sx18ZUcT4R4zabT4YwxO75tlEKpdKepsF
	 yMB04LmWEr14BTB1uro44luYwUy0qjbftr1+b+vKYgyXhRSp0XSlfHQlEg51bW6F7t
	 wbdEYQ+j+L169Fot815exQg8mF2r+XGghZv96bHq/3MnkPrf0s8HwfTK+2QoYeqbYH
	 Jdg96QmYOu1Vg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca, 
 Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20251226094112.3042583-1-lizhijian@fujitsu.com>
References: <20251226094112.3042583-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
Message-Id: <176708688553.593956.4867050867025505997.b4-ty@kernel.org>
Date: Tue, 30 Dec 2025 04:28:05 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Fri, 26 Dec 2025 17:41:12 +0800, Li Zhijian wrote:
> rxe_odp_map_range_and_lock() should unlock umem_odp->umem_mutex on error.
> 
> 

Applied, thanks!

[1/1] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
      https://git.kernel.org/rdma/rdma/c/3c68cf68233e55

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


