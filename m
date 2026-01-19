Return-Path: <linux-rdma+bounces-15723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E546AD3B446
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCE78300DDBA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAC3033E4;
	Mon, 19 Jan 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Bgj4l9rx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A330C608;
	Mon, 19 Jan 2026 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843710; cv=none; b=Z8Adv+e6BCrnV7qDqJUybISTHGkok4K/QGTrZKvoSqjT3gKpezyiqiGUjaqCXNISD0nDyZRej98veEmNpWNkT57narx7dgbdzATJrvuXl9Wh4Peuuz15CSXkk5//l6K2icTJupJlTLWiFYJW+JxeF77VqBQPSdZ5pzFaztzp77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843710; c=relaxed/simple;
	bh=dAEN621rxaKLniJp++d1mCcqa+hHeDahYePAXwnepds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUFZtK4ik9PvwGbsL7+wUkMYTZJMm2n4ZYTLOv7WO58P1MuaDhIpDzz0ibvRennWNaBCZrz3L2Fv+heIx+YRN6iYTjXnI1zvhIhRBqXXOsUW08GBrTYlShvSWmOUWbn3ztTreo424KbTJUtdsiBJNFcp/dv0On++hkmi8SDatjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Bgj4l9rx; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=JMxLJry4AoMWV6osPRsv8deFO4tQ6Q6IX6Od1VSMlo4=; b=Bgj4l9rx3hAFwtF+gr+N63DV6e
	iBlpVY36M4faTbLJYyxNOO4qD5W99ekNkoEBsHPrthQE0LQVCiet8IRosV9YJJEEvYC0CM0xBQNku
	LSaN9/h27btm3KPBDZZw8CK0n/sx+LxgMMSk0yTfnmr2tnqgg/EJAo7F+Ovc6hPh00K1BZuePEC3e
	gtP0PLoToFU3Dj24dFg7Z62o9MqhK14JpIWwEjtpPTVBiRE6HBnMaQa9CmHGj+HV7owwjU4+al29z
	2OsZEKKM7OPBZ9FCy19LR/njEKXXQ+SbdQY+BcIWTioFczivXeTay++jD2oOYVsrvPVAdQNeQ5DX+
	uPnMcF80g3YMBWcb2YIUSeuP6l8Pqu5kmszoARG5Dy76Kpw4vt/p1U/k73yxzetvaqiCAn0WdNXeL
	MWlwy0muGOo5+1FMHKd5wwFVvYfjYuoHw8LTmTqXpg7Y0U0Gasxf1l1w8UMgJ9bsB8rgRwSO+++aA
	2Z+SO0OHhEQ/BR9KepaQLlxX;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vht35-00000001B4g-3TTx;
	Mon, 19 Jan 2026 17:28:19 +0000
Message-ID: <dbd2e0a8-c280-405c-8106-234078181d3d@samba.org>
Date: Mon, 19 Jan 2026 18:28:19 +0100
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
 <84554ae8-574c-4476-88df-ed9cfcc347f5@samba.org>
 <CAKYAXd8np_b1RUkPQj2pz6=F5dciDLooES-gZVkSMSrbWRjWSQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd8np_b1RUkPQj2pz6=F5dciDLooES-gZVkSMSrbWRjWSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.01.26 um 09:03 schrieb Namjae Jeon:
> On Sat, Jan 17, 2026 at 10:15 PM Stefan Metzmacher <metze@samba.org> wrote:
>>
>> Am 17.01.26 um 00:08 schrieb Stefan Metzmacher:
>>> Am 15.01.26 um 10:50 schrieb Stefan Metzmacher:
>>>> Am 15.01.26 um 03:01 schrieb Namjae Jeon:
>>>>> On Thu, Jan 15, 2026 at 3:13 AM Stefan Metzmacher <metze@samba.org> wrote:
>>>>>>
>>>>>> Am 15.12.25 um 21:17 schrieb Stefan Metzmacher:
>>>>>>> Am 14.12.25 um 23:56 schrieb Stefan Metzmacher:
>>>>>>>> Am 13.12.25 um 03:14 schrieb Namjae Jeon:
>>>>>>>>>> I've put these changes a long with rw credit fixes into my
>>>>>>>>>> for-6.18/ksmbd-smbdirect-regression-v4 branch, are you able to
>>>>>>>>>> test this?
>>>>>>>>> Problems still occur. See:
>>>>>>>>
>>>>>>>> :-( Would you be able to use rxe and cake a network capture?
>>>>>>>>
>>>>>>>> Using test files with all zeros, e.g.
>>>>>>>> dd if=/dev/zero of=/tmp/4096MBzeros-sparse.dat seek=4096MB bs=1 count=1
>>>>>>>> would allow gzip --best on the capture file to compress well...
>>>>>>>
>>>>>>> I think I found something that explains it and
>>>>>>> I was able to reproduce and what I have in mind.
>>>>>>>
>>>>>>> We increment recv_io.posted.count after ib_post_recv()
>>>>>>>
>>>>>>> And manage_credits_prior_sending() uses
>>>>>>>
>>>>>>> new_credits = recv_io.posted.count - recv_io.credits.count
>>>>>>>
>>>>>>> But there is a race between the hardware receiving a message
>>>>>>> and recv_done being called in order to decrement recv_io.posted.count
>>>>>>> again. During that race manage_credits_prior_sending() might grant
>>>>>>> too much credits.
>>>>>>>
>>>>>>> Please test my for-6.18/ksmbd-smbdirect-regression-v5 branch,
>>>>>>> I haven't tested this branch yet, I'm running out of time
>>>>>>> for the day.
>>>>>>>
>>>>>>> But I tested it with smbclient and having a similar
>>>>>>> logic in fs/smb/common/smbdirect/smbdirect_connection.c
>>>>>>
>>>>>> I was able to reproduce the problem and the fix I created
>>>>>> for-6.18/ksmbd-smbdirect-regression-v5 was not correct.
>>>>>>
>>>>>> I needed to use
>>>>>>
>>>>>> available = atomic_xchg(&sc->recv_io.credits.available, 0);
>>>>>>
>>>>>> instead of
>>>>>>
>>>>>> available = atomic_read(&sc->recv_io.credits.available);
>>>>>> atomic_sub(new_credits, &sc->recv_io.credits.available);
>>>>>>
>>>>>> This following branch works for me:
>>>>>> for-6.18/ksmbd-smbdirect-regression-v7
>>>>>> and with the fixes again master this should also work:
>>>>>> for-6.19/ksmbd-smbdirect-regression-v1
>>>>>>
>>>>>> I'll post real patches tomorrow.
>>>>>>
>>>>>> Please check.
>>>>> Okay, I will test it with two branches.
>>>>> I'll try it too, but I recommend running frametest for performance
>>>>> difference and stress testing.
>>>>>
>>>>> https://support.dvsus.com/hc/en-us/articles/212925466-How-to-use-frametest
>>>>>
>>>>> ex) frametest.exe -w 4k -t 20 -n 2000
>>>>
>>>> That works fine, but
>>>>
>>>>    frametest.exe -r 4k -t 20 -n 2000
>>>>
>>>> generates a continues stream of such messages:
>>>> ksmbd: Failed to send message: -107
>>>>
>>>> Both with 6.17.2 and for-6.19/ksmbd-smbdirect-regression-v1,
>>>> so this is not a regression.
>>>>
>>>> I'll now check if the is related to the other problems
>>>> I found and fixes in for-6.18/ksmbd-smbdirect-regression-v5
>>>
>>> Ok, I found the problem.
>>>
>>> On send we are not allowed to consume the last send credit
>>> without granting any credit to the peer.
>>>
>>>       MS-SMBD 3.1.5.1 Sending Upper Layer Messages
>>>
>>>       ...
>>>       If Connection.SendCredits is 1 and the CreditsGranted field of the message is 0, stop
>>>       processing.
>>>       ...
>>>
>>>       MS-SMBD 3.1.5.9 Managing Credits Prior to Sending
>>>
>>>       ...
>>>       If Connection.ReceiveCredits is zero, or if Connection.SendCredits is one and the
>>>       Connection.SendQueue is not empty, the sender MUST allocate and post at least one receive of size
>>>       Connection.MaxReceiveSize and MUST increment Connection.ReceiveCredits by the number
>>>       allocated and posted. If no receives are posted, the processing MUST return a value of zero to indicate
>>>       to the caller that no Send message can be currently performed.
>>>       ...
>>>
>>> It works in my master-ipproto-smbdirect branch, see the top commit.
>>>
>>> I'll backport the related logic to ksmbd on top of
>>> for-6.19/ksmbd-smbdirect-regression-v1 tomorrow.
>>
>> for-6.19/ksmbd-smbdirect-regression-v2 has the fixes and works for
>> me, I'll prepare official patches (most likely) on Monday.
> I have tested the for-6.19/ksmbd-smbdirect-regression-v2 branch, and I
> can confirm that the issues I previously encountered in my test
> environment have been fixed.

Great! Thanks for testing!

> I have a couple of follow-up questions regarding this fix:
> 1. Regarding your frametest results, did you not observe any
> performance degradation or difference compared to linux-6.17.9?

Sorry, I don't understand what you are asking for.

Do you mean with v6.19-rc5, for-6.19/ksmbd-smbdirect-regression-v1 or
for-6.19/ksmbd-smbdirect-regression-v2?


> 2. You mentioned previously testing with Intel E810-CQDA2 NICs. Have
> you tested both iWARP and RoCEv2 modes on the E810?

Yes, both while there seem to be strange problems with iWarp.

I'll have to re-test with these cards, we'll test if it's possible
to have both cards installed together both only getting 8 PCIe 5 lanes,
that would make it easier to test.

At the time I was always testing with KSAN, lockdep and other debugging features
turned on, so performance was not as expected anyway...

metze


