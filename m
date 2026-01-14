Return-Path: <linux-rdma+bounces-15564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A753ED20BCE
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58A1D302AB9B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF28331229;
	Wed, 14 Jan 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="CLN4NvY9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00243AA4;
	Wed, 14 Jan 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414410; cv=none; b=BOJGGoZWilRPGMrcCQaaAkx2ybBXlz/+pTR4fepdjl3tZu63MwD0Z1Z2vAv5KPHtmhWhBx7dn5Tzpn+AAopmTVmN+0HxZu7u4t1jVqD+D3DorsM4LjJlo8Qeou98RvcONd6sfpCQsg12jSekyNHVkXBSyYQ5HMLEZFXB89sPnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414410; c=relaxed/simple;
	bh=beCypBu4GL4awbujW4L3wXZlKKaEYIAFKQofDheWlaQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q7Imo3QzmWSJtmkH+wAUn9swYKEr7z2b0r2wwhWL1SiVn5mIgr+G4zFU09nN66m2u4p0ZoMG3uRdTiDcvkEsnAbBqd7ZzLcSygEs6gXI5nte10fTFg6QjGJHvBYGy+sOWs4SuTWvo0dOKnKXYVY28S0lArmPJG5iCXJinMdks3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=CLN4NvY9; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=Co7oV69yV1f5h8ZT89aTZvC7YA2pcvpcsHWNSHUTn24=; b=CLN4NvY9HrFbk0BOKCQ1cuSj1x
	FIPJlJPk1SOxu0yYbXe5CXzGigNFzlLW3AFbHzOdiuXOB9WlRer85mS7YyZACC48ervfnoRDNU3b3
	M3GgSokwfk0K1qC9eK+fQDJG1/6hA187gzj7IzhbXyfPnBYR0dD2uCeoVqnyCTYsz5tjNgbisfsBd
	OTl0VhxRCJ0AIAqA1RYD4wyTQglnfeS7AukyBPYqMxVQrMd2xcnERoEa1ScWHkg/pQUQAH93aQYY8
	vHhjYSjLvGFTkmsn76n1asxFLAJIDz9Wt06X9iwUobsVFUE+eK55Y08uyRLH3RnnKPbgGOc+QBefW
	RwED0juPwvkZANrqaQVvsRlDFqNT2g7O1ssvZetbmbSKIIF5AFYyOZz/+KjrWsRnkcoYBanNgnrwv
	0tMjUIHcE/tHVyf+4U4G8UMmL0HNOh47Q6eyk06SLIBM6jXW2Q3FbtDRyTK5woO7RzxV8xXVbqOXs
	v6TP0tLoJqMWFWyNoxThlDZ9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vg5Mu-000000008tn-2D8C;
	Wed, 14 Jan 2026 18:13:20 +0000
Message-ID: <6a248fde-e0cd-489b-a640-d096fb458807@samba.org>
Date: Wed, 14 Jan 2026 19:13:19 +0100
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
 <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
Content-Language: en-US
In-Reply-To: <ee6873d7-6e47-4d42-9822-cb55b2bfb79e@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 15.12.25 um 21:17 schrieb Stefan Metzmacher:
> Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
>> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
>>>> I've put these changes a long with rw credit fixes into my
>>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
>>>> test this?
>>> Problems still occur. See:
>>
>> :-( Would you be able to use rxe and cake a network capture?
>>
>> Using test files with all zeros, e.g.
>> dd if=/dev/zero of=/tmp/4096MBzeros-sparse.dat seek=4096MB bs=1 count=1
>> would allow gzip --best on the capture file to compress well...
> 
> I think I found something that explains it and
> I was able to reproduce and what I have in mind.
> 
> We increment recv_io.posted.count after ib_post_recv()
> 
> And manage_credits_prior_sending() uses
> 
> new_credits = recv_io.posted.count - recv_io.credits.count
> 
> But there is a race between the hardware receiving a message
> and recv_done being called in order to decrement recv_io.posted.count
> again. During that race manage_credits_prior_sending() might grant
> too much credits.
> 
> Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
> I haven't tested this branch yet, I'm running out of time
> for the day.
> 
> But I tested it with smbclient and having a similar
> logic in fs/smb/common/smbdirect/smbdirect_connection.c

I was able to reproduce the problem and the fix I created
for-6.18/ksmbd-smbdirect-regression-v5 was not correct.

I needed to use

available = atomic_xchg(&sc->recv_io.credits.available, 0);

instead of

available = atomic_read(&sc->recv_io.credits.available);
atomic_sub(new_credits, &sc->recv_io.credits.available);

This following branch works for me:
for-6.18/ksmbd-smbdirect-regression-v7
and with the fixes again master this should also work:
for-6.19/ksmbd-smbdirect-regression-v1

I'll post real patches tomorrow.

Please check.

Thanks!
metze


