Return-Path: <linux-rdma+bounces-14988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634ADCBC199
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 23:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62B0A3007EDF
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28493314A74;
	Sun, 14 Dec 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="RouBOS7r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC123AB81;
	Sun, 14 Dec 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765753017; cv=none; b=VFHuXZ8gIztJbLbHzVE8cFyEDWeDNXdTnG9uHT4ZYq809dQuu2bqdVYnVHiHAOAik0Ezs/AT+pMnYocsTe/Xmee/goHHohBVB0POQtRa1w9GPJ209EAcb3qSbRdVi3ry3U3JXm9uBZmzMEp0+P1J0tOhpv6w2nVAuHhc3pJm4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765753017; c=relaxed/simple;
	bh=nMrTVTAT7uH5lmrS3i8sEn8Nd3ACl/R4qLE/M7/DLXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4gzkpke0gctHWipDoxrAXnNc9W07a9MbkG2bfvO16BF+fIBpkMGJd4F6YH8q0tEcMcmteTQ1M6IieAKK+Y7k+7QvK9SDWIjOvLVEQk+OXZy1mDWdIb0SzvQFn91+n9socLtM3Rq1sG5c2azK5l5dLztWAWc809HS7EPyo6vzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=RouBOS7r; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=nMrTVTAT7uH5lmrS3i8sEn8Nd3ACl/R4qLE/M7/DLXc=; b=RouBOS7rhw76m37vK7N0MwP9T+
	7PW8nTM96sw1QptX+fEi/Qvtkhf5vivgA9LffUhWdgzUpNIggvcEXa7miRpGgEXC/+dW7QKi8xIpo
	qu2bmWF0A44a02n6rpoMo7AM3hO+AtQ4NWMjq6ma3+4oQgr4CZQQaVZsp924JzYyFQJgqzAFKOKwA
	txVtDdFlaDPHVDX4Ran6EKRraDUNsOdhTI+ojr4m9/tXrqVeOxCpu16k322OgwCIco5+BJf7spxxH
	tgl8B2KlN7G4ItZaGgzCiRGqN3Rv5NNgHZvm6f5NC3COHxNAVkm3WdUZsiwvkoEo/jiAaegTA7nL8
	skLnhd6xBpB95ws8L4oPIgOFJ36lT+AKS2xjc+UVXzc/kGKkr+vu2zniw+ItWvWQs4V7yC9sKVUr2
	L26+0v9qTe4xSeDfHTm75mq+f1r6vvi8dDmflh9XuhLZIRoGnKMBoCHQS07zlBYhBlatFC19FdSCN
	U9rwTUM+fMXN9lIHSGyy96xB;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vUv1E-000gJC-0t;
	Sun, 14 Dec 2025 22:56:48 +0000
Message-ID: <183d92a0-6478-41bb-acb3-ccefd664d62f@samba.org>
Date: Sun, 14 Dec 2025 23:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with smbdirect rw credits and initiator_depth
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Tom Talpey <tom@talpey.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <35eec2e6-bf37-43d6-a2d8-7a939a68021b@samba.org>
 <CAKYAXd9p=7BzmSSKi5n41OKkkw4qrr4cWpWet7rUfC+VT-6h1g@mail.gmail.com>
 <f59e0dc7-e91c-4a13-8d49-fe183c10b6f4@samba.org>
 <CAKYAXd-MF1j+CkbWakFJK2ov_SfRUXaRuT6jE0uHZoLxTu130Q@mail.gmail.com>
 <CAKYAXd__T=L9aWwOuY7Z8fJgMf404=KQ2dTpNRd3mq9dnYCxRw@mail.gmail.com>
 <86b3c222-d765-4a6c-bb79-915609fa3d27@samba.org>
 <a3760b26-7458-40a0-ae79-bb94dd0e1d01@samba.org>
 <3c0c9728-6601-41f1-892f-469e83dd7f19@samba.org>
 <721eb7b1-dea9-4510-8531-05b2c95cb240@samba.org>
 <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd-WTsVEyONDmOMbKseyAp29q71KiUPwGDp2L_a53oL0vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 13.12.25 um 03:14 schrieb Namjae Jeon:
>> I've put these changes a long with rw credit fixes into my
>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
>> test this?
> Problems still occur. See:

:-( Would you be able to use rxe and cake a network capture?

Using test files with all zeros, e.g.
dd if=/dev/zero of=/tmp/4096MBzeros-sparse.dat seek=4096MB bs=1 count=1
would allow gzip --best on the capture file to compress well...

metze

