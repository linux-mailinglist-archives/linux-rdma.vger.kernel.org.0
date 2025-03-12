Return-Path: <linux-rdma+bounces-8623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7CBA5E3F5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF88175052
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542A257AE4;
	Wed, 12 Mar 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYivf2MA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4724EF90
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805839; cv=none; b=F/f02WiUkRXr3lznBKuN91Ckri8s9ydQ/nzzARWu86ao1sGsKCdXw+yszIrIKBOVXaJNwIN5fww9sOJ16tKeLeKl5Jc3gN7ICF8/qYmWrdD1nAePc6AOjcdk9E3fvdlxfvvtTs8/xpX0x9Xsu5c8Snud+ahvqHZV5muRqphikvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805839; c=relaxed/simple;
	bh=mfD2FWRlsERmBTIG9k3DQaK/NZzJgptQXjSZlh350aw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RF4BziXQZxC2vmGCODARFkb3JCJgmaccZ4fc5twX99YlkhNVuGnxlb2NFaXNDIxAOW0driOXg9MEOpRU8UYLAaLqTjoH60TDrzCGfzRRGmdnd3ljyoiY/LDWk70ISkO0TMZFusjlJKo7eHiQLYckYuaa041AVmHK2tvwtgIJTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYivf2MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CDAC4CEDD;
	Wed, 12 Mar 2025 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741805835;
	bh=mfD2FWRlsERmBTIG9k3DQaK/NZzJgptQXjSZlh350aw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=bYivf2MANU+8/ZbHRzZvrMptjn4gXmZOzP4cybyT6UocfgQ0B68NawB6MAp8Yc9Rp
	 QaS6XtFczBsY1oEOAZN62ykGiSrUP7xXWjM05JElNH1fuk+CTZMmsegURXr1YS/qEt
	 WmxEyW2chbCM4PbwJnEr7wadV97NBXqjwx95yiGAyFrZ5FeW219Xns5NWPpfsyDv2e
	 9UkgWZT6wEzj/c9sJhLv+tSZwe4VYLFRUeq8Lzc37QTu+I1C0GrNPv6g/aeqlbiCP+
	 xGM5JYyhvdYTQssQR8iiS6AFmHJQPcYe7OjK8ESE5CampzCwQ3xxCf4/n+HkW+f0Mi
	 b/2mSQJZajcpg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com, 
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
In-Reply-To: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
References: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Improve readability of ODP
 pagefault interface
Message-Id: <174180583204.526748.15299430646827912961.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 14:57:12 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 12 Mar 2025 15:59:37 +0900, Daisuke Matsuda wrote:
> Use a meaningful constant explicitly instead of hard-coding a literal.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Improve readability of ODP pagefault interface
      https://git.kernel.org/rdma/rdma/c/0a924decd4a3a2

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


