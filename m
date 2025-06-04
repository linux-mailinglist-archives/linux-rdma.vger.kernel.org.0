Return-Path: <linux-rdma+bounces-10980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C3ACDC48
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7981893094
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924628E57C;
	Wed,  4 Jun 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tdJExIWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BALc2CPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857220E6E3;
	Wed,  4 Jun 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035089; cv=none; b=lA78ePho2Id7Z/69eVjpuL+lTUunPygsdSEKwMezxyNRjA0fr/ehLi0u8gUCXv5Fg6rysW7REkZNGUiSQ2+n1YOyhU2xypEJmuZ7f0C0s1qXyXxVsQFezsnH3OAMM6+YDB1RnMy48YoeCaBBhl+aFvPlHIFawZUHnm50ITrtjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035089; c=relaxed/simple;
	bh=vrFDCiqXDMtRHbVFVsT+31iDGAdDQ3ptGNMH7XKEI9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCLLqMyhBIo+g89+7MGIE0oeyFb3bmo6WTcvlERZuaEUwwCzDX367MMAuCAo0L19jT696Z+B9PNU/zAC0Fl1vnp18x0uaeb7wwxjAjsX7We0spP99Hzk9rTVrlmC9F6mmwlFyZVV7gLzWFXmISSXrHkUfl+5v9feLbHjuww7IfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tdJExIWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BALc2CPn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Jun 2025 13:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749035079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrFDCiqXDMtRHbVFVsT+31iDGAdDQ3ptGNMH7XKEI9Q=;
	b=tdJExIWU24fpA6+s2PVmEwF5OlREnTVG04LlBr5mh1rW3r0KA8BuSnXw2xtJv5AAPx1YGU
	A3sC9mL/+kbvrqAeREt4EAgIvVdf9q6bzYnmoIeoz3Ez4ovzgC/RencTsBcdiKirHuSmUn
	uQYmKQjOE912jmRQHAcfSSYGYv1ZYrqSQkTlJaH/bJuYch4yp8aRTeJ12oA7L78WkIn5TT
	/2ATA7mG2kECBxOIg10rlQtCM0vjNigf+dCQ9m1dgG/FYMTgDi93uaYGkisyfqGzlCEGVk
	2E1g+yOxtae8npQ/oWYtUJzPv05T9/DlXtEkI8EsglQAxzbmEny+gkHHtoqqvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749035079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrFDCiqXDMtRHbVFVsT+31iDGAdDQ3ptGNMH7XKEI9Q=;
	b=BALc2CPnWzOjlqX0PqN8Lvuavq2pw1hJQ+kR+d7cuTD0L5ptSNoho+3HXS69mZsPEHzjml
	L/2JsK5jDYvsnFAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [linus:master] [rds]  c50d295c37:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20250604110438.rer2bMSx@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202506041623.e45e4f7d-lkp@intel.com>

On 2025-06-04 16:42:37 [+0800], kernel test robot wrote:
>=20
> Hello,
Hi,

> kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" o=
n:
>=20
> commit: c50d295c37f2648a8d9e8a572fedaad027d134bb ("rds: Use nested-BH loc=
king for rds_page_remainder")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
=E2=80=A6
> the issue does not always happen, 45 times out of 200 runs as below. but =
parent
> keeps clean.

I can reproduce this quite reliably. Looking=E2=80=A6

Sebastian

