Return-Path: <linux-rdma+bounces-15004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F1CBFB8E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 21:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 032463028D82
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 20:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EDC288502;
	Mon, 15 Dec 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="BiPUx/dh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACD26E708;
	Mon, 15 Dec 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829875; cv=none; b=LvYJnu/nQr0SMRjVNJ7Ws6O9PklY5SMaumVbbC4kjowLQGJN3mv2FNRiLr0gYdSzS+RMrU10g31X2be0XNzYsOt0OmBbNMJDJY1g0Sf7r2YyyMXfjUjxqnhSrkFn5KnjRhG6A7Y+fjWZ96FQQYNxT7jd2HEK5wV/8DEQ5yMiVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829875; c=relaxed/simple;
	bh=VpYsESqV0wjtzQTqk1L8Hlara3UWcPwJoFbE7XGdRJk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G0PN/hdl+tbCyohcYxu/r7jyXT2ayuuGac4gmTxL3iabdUVtNIisSbddCVPw3OxeyiksW66BRmbF4u2qj1ItGhIZkpiZuFIN7nkA4rI+gJz1dKeghTfsnmLL+iO6vDr2lVxbP+U0I5pKgXJtkJL09qDuvfONoHn3ZV+AvXu8j+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=BiPUx/dh; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=q2/nZMPaU3boBZyOfQDLnSPi0tVtst41YVBrCjN2wTI=; b=BiPUx/dhJuQV4sQpBf5OCgE7Sp
	kHTbT0v7orc2ftNMJB6n5UMI3VNjMH4Q4RlwU9fL9P8qO0EP9RQdoq29MJdj2g8cioC3ZrIt5KzZr
	0U6rZAsAyIdlcZU2Zlcxk99IQbZBFCxRCywpnEAhaNQTB+zYFO4+GnCZPlAR25V69y9ZT3QNewNqM
	64CNKmFHhbcxLr4EZdKvO9xZdu+FxZ9O0qiEXuY7yGYvLfkDHosy+t8aMTUqZoif4+wufERtPOvcU
	qf6n9QHzSlo2QsAU2wTHGP3K6kMWO8/B+iUjcq1qfoVvNOXLSk9lM/49m78feJU8EW/xaUnuUOWGP
	GIujeAWUfGqZhMa666HFQ0bdGG0eUfZHpiFS7tJrwDDFji8FmBMWwg+DU15MjLk7AFBugVpgEEo25
	KpJkjEqaoi/z6Ow4VfbWvc5kyXbmLxxTjNsYjjUmRl3QJlC90JaS1MDFQy5gH34kGH0O2sabkie71
	N8kElQSA4ToAegLuUfX3wSeI;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vVF0w-000oFt-2P;
	Mon, 15 Dec 2025 20:17:50 +0000
Message-ID: <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
Date: Mon, 15 Dec 2025 21:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with smbdirect rw credits and initiator_depth
From: Stefan Metzmacher <metze@samba.org>
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
 <183d92a0-6478-41bb-acb3-ccefd664d62f@samba.org>
Content-Language: en-US
In-Reply-To: <183d92a0-6478-41bb-acb3-ccefd664d62f@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
>>> I've put these changes a long with rw credit fixes into my
>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
>>> test this?
>> Problems still occur. See:
> 
> :-( Would you be able to use rxe and cake a network capture?
> 
> Using test files with all zeros, e.g.
> dd if=/dev/zero of=/tmp/4096MBzeros-sparse.dat seek=4096MB bs=1 count=1
> would allow gzip --best on the capture file to compress well...

I think I found something that explains it and
I was able to reproduce and what I have in mind.

We increment recv_io.posted.count after ib_post_recv()

And manage_credits_prior_sending() uses

new_credits = recv_io.posted.count - recv_io.credits.count

But there is a race between the hardware receiving a message
and recv_done being called in order to decrement recv_io.posted.count
again. During that race manage_credits_prior_sending() might grant
too much credits.

Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
I haven't tested this branch yet, I'm running out of time
for the day.

But I tested it with smbclient and having a similar
logic in fs/smb/common/smbdirect/smbdirect_connection.c

metze

