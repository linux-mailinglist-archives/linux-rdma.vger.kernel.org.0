Return-Path: <linux-rdma+bounces-15656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763AED38E9F
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0237301C3CF
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D930AAD0;
	Sat, 17 Jan 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Lr06b2V7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338712D59FA;
	Sat, 17 Jan 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768655707; cv=none; b=UH0Av7BZ/y2pizPyJEz1Uxzr3vNRREpHUVYwlULrQ/mACnShdRNokxiL8QJMNunNXc7mN8XU4gA+Stw6UTgnxXGNxqZnIxrOYPtCnTLDTYjpoZlyeXdw8XZld5v/hOwC3r0nWiTQy8MZG06FR9GFkp2CwcGp+l0ayHSo6IDF918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768655707; c=relaxed/simple;
	bh=l/DF1wPnxXSSVfJ1mac+OCGGhsj9MWS54a0RhZAVCHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LghWcidHN93alcfdoc9DecjKc58hhysz/zNPbhIrt8XX/frEupn2r7iCL5yCM8Z9yYxVXtJDwLO/Nx9jyeOj47VaBSQUdKUU6k9OB1Nt+sI2wj2f7r/XsJyUy63BI7hyKA8V5w+Jzx5qlm/qnnXxt5LvgeLnoPYr/dxK8XOkEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Lr06b2V7; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=OcasvqJwPlOLCeDPMt/ZehSCYT1FwbI/POlsHrBzyt0=; b=Lr06b2V7hVIcBtrQbP7CICshMS
	rJz4RdvgvdbLcErNfZBV8CP0NTogIAHGBkhNYY7986JCO4XpSpzm4o7sDFtxiFpLvH34Hsu0RLDDD
	N5OtQnSCp0eT+K1OWcnTbVk0hGx8hg9Z1WAg3vjqii7THPV+MWq3dZ2CQBWhULSoPsBwL18oEPu1p
	QnrwNZhl/JoGunRWxt9Kd7A1vAht9hgG6ikapzub9jEK1jH8eB9UuBClBfr/PPf6wKfVzajmouovm
	fni4y5KdyhIEWsI5qKH7Q/ZKm8Szt7gtLvuBAaMvLr54sx1jWj3NYDakrHq/MHQUR43lx5Pxy138j
	MKCRY/2GOTIBiHok4YpFmoX1HwOtqoR4w/ajJEK3pfGUlHu7LG1PZz272OooZraXHJkUomQyQYUKc
	GtU8PYHY+q6uwaneH70Gl2rshK0Sf4R5xpC+jS6rvPYNQaYSWaZTcAj+PuyqFU3b7L1AnvL82qgQH
	XoRsbwm+y2W4w9s8f4cTCd6E;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vh68t-00000000guU-099H;
	Sat, 17 Jan 2026 13:15:03 +0000
Message-ID: <84554ae8-574c-4476-88df-ed9cfcc347f5@samba.org>
Date: Sat, 17 Jan 2026 14:15:02 +0100
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
 <6a248fde-e0cd-489b-a640-d096fb458807@samba.org>
 <CAKYAXd-42_fSHBL7iZbuOtYFKqKyhPS-4C+nqbX=-Djq5L6Okg@mail.gmail.com>
 <b58fa352-2386-4145-b42e-9b4b1d484e17@samba.org>
 <8b4cc986-cf06-42a9-ab5d-8b35615fa809@samba.org>
Content-Language: en-US
In-Reply-To: <8b4cc986-cf06-42a9-ab5d-8b35615fa809@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.01.26 um 00:08 schrieb Stefan Metzmacher:
> Am 15.01.26 um 10:50 schrieb Stefan Metzmacher:
>> Am 15.01.26 um 03:01 schrieb Namjae Jeon:
>>> On Thu, Jan 15, 2026 at 3:13 AM Stefan Metzmacher <metze@samba.org> wrote:
>>>>
>>>> Am 15.12.25 um 21:17 schrieb Stefan Metzmacher:
>>>>> Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
>>>>>> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
>>>>>>>> I've put these changes a long with rw credit fixes into my
>>>>>>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
>>>>>>>> test this?
>>>>>>> Problems still occur. See:
>>>>>>
>>>>>> :-( Would you be able to use rxe and cake a network capture?
>>>>>>
>>>>>> Using test files with all zeros, e.g.
>>>>>> dd if=/dev/zero of=/tmp/4096MBzeros-sparse.dat seek=4096MB bs=1 count=1
>>>>>> would allow gzip --best on the capture file to compress well...
>>>>>
>>>>> I think I found something that explains it and
>>>>> I was able to reproduce and what I have in mind.
>>>>>
>>>>> We increment recv_io.posted.count after ib_post_recv()
>>>>>
>>>>> And manage_credits_prior_sending() uses
>>>>>
>>>>> new_credits = recv_io.posted.count - recv_io.credits.count
>>>>>
>>>>> But there is a race between the hardware receiving a message
>>>>> and recv_done being called in order to decrement recv_io.posted.count
>>>>> again. During that race manage_credits_prior_sending() might grant
>>>>> too much credits.
>>>>>
>>>>> Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
>>>>> I haven't tested this branch yet, I'm running out of time
>>>>> for the day.
>>>>>
>>>>> But I tested it with smbclient and having a similar
>>>>> logic in fs/smb/common/smbdirect/smbdirect_connection.c
>>>>
>>>> I was able to reproduce the problem and the fix I created
>>>> for-6.18/ksmbd-smbdirect-regression-v5 was not correct.
>>>>
>>>> I needed to use
>>>>
>>>> available = atomic_xchg(&sc->recv_io.credits.available, 0);
>>>>
>>>> instead of
>>>>
>>>> available = atomic_read(&sc->recv_io.credits.available);
>>>> atomic_sub(new_credits, &sc->recv_io.credits.available);
>>>>
>>>> This following branch works for me:
>>>> for-6.18/ksmbd-smbdirect-regression-v7
>>>> and with the fixes again master this should also work:
>>>> for-6.19/ksmbd-smbdirect-regression-v1
>>>>
>>>> I'll post real patches tomorrow.
>>>>
>>>> Please check.
>>> Okay, I will test it with two branches.
>>> I'll try it too, but I recommend running frametest for performance
>>> difference and stress testing.
>>>
>>> https://support.dvsus.com/hc/en-us/articles/212925466-How-to-use-frametest
>>>
>>> ex) frametest.exe -w 4k -t 20 -n 2000
>>
>> That works fine, but
>>
>>   frametest.exe -r 4k -t 20 -n 2000
>>
>> generates a continues stream of such messages:
>> ksmbd: Failed to send message: -107
>>
>> Both with 6.17.2 and for-6.19/ksmbd-smbdirect-regression-v1,
>> so this is not a regression.
>>
>> I'll now check if the is related to the other problems
>> I found and fixes in for-6.18/ksmbd-smbdirect-regression-v5
> 
> Ok, I found the problem.
> 
> On send we are not allowed to consume the last send credit
> without granting any credit to the peer.
> 
>      MS-SMBD 3.1.5.1 Sending Upper Layer Messages
> 
>      ...
>      If Connection.SendCredits is 1 and the CreditsGranted field of the message is 0, stop
>      processing.
>      ...
> 
>      MS-SMBD 3.1.5.9 Managing Credits Prior to Sending
> 
>      ...
>      If Connection.ReceiveCredits is zero, or if Connection.SendCredits is one and the
>      Connection.SendQueue is not empty, the sender MUST allocate and post at least one receive of size
>      Connection.MaxReceiveSize and MUST increment Connection.ReceiveCredits by the number
>      allocated and posted. If no receives are posted, the processing MUST return a value of zero to indicate
>      to the caller that no Send message can be currently performed.
>      ...
> 
> It works in my master-ipproto-smbdirect branch, see the top commit.
> 
> I'll backport the related logic to ksmbd on top of
> for-6.19/ksmbd-smbdirect-regression-v1 tomorrow.

for-6.19/ksmbd-smbdirect-regression-v2 has the fixes and works for
me, I'll prepare official patches (most likely) on Monday.

metze



