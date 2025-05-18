Return-Path: <linux-rdma+bounces-10392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB649ABAE78
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5F3B0754
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470071E04AD;
	Sun, 18 May 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs4UkSyL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CF14F104;
	Sun, 18 May 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553528; cv=none; b=rGnJyM2pXLwE3l5atDZGf7+bzraTRReBBGh3F3gQ5+auHotjTzi9ovIN7xQgocqFAoXMwAGLxQMInlzGrXjdjnpdcKsw5XtcoRNtzG5k6kq3OiioY4X3VdlOkY02bah5o2ZwAeOgRUj0jcfCW/ocHmsCvEqT5Ncyep/pqu7wt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553528; c=relaxed/simple;
	bh=kKd8oaw3v4F7nYKeZlhHUMa3JwKA6J/11vZlgXm7ltk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNmjj3mtmqijBKzC4XSnmzWs7z7dDFSnfuiQQXzp05ssggM2f3/Ye6M3WHzOvOZq3gpW5ZJgX9UebNSXqunZ/8oZQe9wPLyi/Ro6UKlvyGxB8+kZAfABavFRMu1NvWxKJf7B5LkNZqdPlaSihiTQ3P+9MM2YG7vPD4GVIr8Qsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs4UkSyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3F3C4CEE7;
	Sun, 18 May 2025 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747553527;
	bh=kKd8oaw3v4F7nYKeZlhHUMa3JwKA6J/11vZlgXm7ltk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rs4UkSyLyQkEmiWZoBp1A0WxojWwflX6Mge46au5CF33DzHJPlhun4c3Bm9IXTQrG
	 12rpEDmZhE+aTWpiBEoer71xQNfSAfmQHTWM0GhiehZNexIkF99RNCzxWOA5pgjZ3R
	 hoUI6e8gFsjGSqYr1BDi9iHT3r9y7Djck8KqtyS9hZnCpnweZ6dbBKw0J/uPEiKIU3
	 k2D6z5Cyofwh3ecqgMFCeLFswWt2fbWg35cPy+KSvy+XnA6T2JvMKlP80B5qdwAaH7
	 BqHMybXJcDEalxBIQbLBJDEU36tHftSVweHBP9C6J49A6OnUwTmLtky2GxnsBqDt9u
	 7fld1vR9Z+9rw==
Date: Sun, 18 May 2025 10:32:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: mustafa.ismail@intel.com, tatyana.e.nikolova@intel.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: puda: Clear entries after allocation to
 ensure clean state
Message-ID: <20250518073202.GE7435@unreal>
References: <20250515133929.1222-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515133929.1222-1-vulab@iscas.ac.cn>

On Thu, May 15, 2025 at 09:39:28PM +0800, Wentao Liang wrote:
> The irdma_puda_send() calls the irdma_puda_get_next_send_wqe() to get
> entries, but does not clear the entries after the function call. This
> could lead to wqe data inconsistency.

Where does this "wqe data inconsistency" occur?

Thanks

