Return-Path: <linux-rdma+bounces-8269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A899A4CB93
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 20:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A02E3A3A98
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1022D7AA;
	Mon,  3 Mar 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENOt2OBw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546692135B2
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028833; cv=none; b=EtwMaHm96HiVWCvwUi/n7WOHfIQ8pwERgsDcpGq5r5Q9Q9josVt1DMbECa6RqGqB8/8lnLWBijw1MeR0pozLvgRS8OHRahUNjkaXG3Chv6iAA5jmSDGpHf4zLWacqUh0ESzcLSCIKqOTDVRBEowUqh7rafRkXukfxT2Koq6A2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028833; c=relaxed/simple;
	bh=+6wCV2+fRbT4lpnHsQ+w87udncd6MzzU1LEoeP0oQv0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A73K1TIYOpEMaQ+I4rNW+0+5jlzNxtszlScm/Av1dCJEooANJ6J6rTKpiFf1lFZjjmOKxav3nDo+LOxaCR4T66/aIwa65Hy2wiJNw1jaAUHVS2LsDhtV5DgeqS+R+rVkzNFFVFA5tgNuRJXPJg9B8k3pPRiXQrbuY0mtPhYpejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENOt2OBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63109C4CED6;
	Mon,  3 Mar 2025 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028832;
	bh=+6wCV2+fRbT4lpnHsQ+w87udncd6MzzU1LEoeP0oQv0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ENOt2OBwT9kLkiGabPycWHml87lDU1XH1qKBe0idxC5xQrFs5oWRis5EQgUnneXPx
	 d0HwdJWp9iC/hhX75uIOHnEHIT8G2J85HL72M4Ua9c1BNYkI5LmUKGZA45n/BtlU2e
	 heajutebHbQSQPchw+y0XsvATQmaRcmOPoEQRDd7szRbphSuQo7EIRQsx/cDZXi/vs
	 7h92SqEI/Iue7W2b0cd2X/uBDYzK1f3DuIHlwFvo4q+z6gi2FbUz+ZDmhR/hmpmtAw
	 86zkGgJeYnKXxesXskKSKdDvR49HXCkmuWrcq576CI/g5HmT1p38GH3XSg7j+9C76c
	 HLmdh4EeR/gpg==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250302215444.3742072-1-yanjun.zhu@linux.dev>
References: <20250302215444.3742072-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of
 ibv_query_device() and ibv_query_device_ex() tests
Message-Id: <174102882930.42565.11864314726635251412.b4-ty@kernel.org>
Date: Mon, 03 Mar 2025 14:07:09 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 02 Mar 2025 22:54:44 +0100, Zhu Yanjun wrote:
> In rdma-core, the following failures appear.
> 
> "
> $ ./build/bin/run_tests.py -k device
> ssssssss....FF........s
> ======================================================================
> FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
> Test ibv_query_device()
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
>    test_query_device
>      self.verify_device_attr(attr, dev)
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
>    verify_device_attr
>      assert attr.sys_image_guid != 0
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
      https://git.kernel.org/rdma/rdma/c/8ce2eb9dfac874

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


