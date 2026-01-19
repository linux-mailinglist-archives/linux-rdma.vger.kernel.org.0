Return-Path: <linux-rdma+bounces-15729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1CD3B715
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 20:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 737173019E14
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200E2741B5;
	Mon, 19 Jan 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Cmyzol4I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8418143C61;
	Mon, 19 Jan 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850224; cv=none; b=bc9XdyKdZLAU1UrTXYA/bgYHy+7DtJaYR7VG1r6YXMLut7qMq55emO8ylIgYTOrLqVrF+I67SUUvWS0ofq8GVSOuwsrw3QbypLvb0yjKpX4r5IsLal/Da7W/wLO+YuOJ5dr5nUSYLQCwp9/D9oj0rqrlJyz5o7NaStXoueLlqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850224; c=relaxed/simple;
	bh=KqhJIcn2gw2lpPqMyaCJ0HqxsbftXxWYIEKHcCrE+1A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ox2ujo+wMEnWULm84bRucQqPUAWgYUYmFC1yQ6ar5KIow2EtjZBmkY7QdjLnyRF/BKAthCA3BkTN/PQGuOGmVvIlZTWk1J+6f2K77xJH+pmCMap4tB4sD8yIP6a44m40+bKAYHhTD4eBD7MMPH9FGIGN6Zcikmp9wOhAE561oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Cmyzol4I; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=Ca46aR5VgGQ5Oa2P7qfSNhrbZr6v8EOpyKoliidOvVU=; b=Cmyzol4IgiXuUCmzN8VafW7LWn
	Vokf9awJvM29mgdfnaRCig/YUzHzK9/Iem3R7dfLnPRjQZ3soRmC+yWgj5ePNRjHcn8wlRUH53DYW
	eWDLmELaiPGShcDqJKz19hrqegDlx2EDAIzrBkmjziG96FT1C2ycUXRXE8wFniBIDJcDbHhx2pjdD
	PUbFtv5w5rbegcbrQ8y77tufb3jyT9s3ABbzXmCw4pH3sRX14Yhz3RCjhoSahsMc9vNer1xHiOIYt
	JK/IFgpA4MKcfdpQvdsixxOb2igBZu/V+9L6cYZCS2jjLMhSJNScp+Hv9YX1Y6kur920/XUeGr/jZ
	8UttpsecuJSQ+ZdnTd9IZ/kCBGrUpz6p37s1DXuLlG33eUoOVLWGk7b49RffF74bBAjjLnZiW9Upi
	8xaHmnHmeoGQNRc/fyB+yk7L7ZAUXQ8LngLTIGn5e+VR4bgGWpuKz8NtH4PzKnr5DTqHGSBT9FO7S
	CxPpBDIiHGTD2x8nlfzBEWPJ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vhukG-00000001C78-2dJI;
	Mon, 19 Jan 2026 19:17:00 +0000
Message-ID: <cc5028a3-8cb0-4a44-a382-9877e7cea646@samba.org>
Date: Mon, 19 Jan 2026 20:17:00 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with smbdirect rw credits and initiator_depth
From: Stefan Metzmacher <metze@samba.org>
To: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>
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
 <dbd2e0a8-c280-405c-8106-234078181d3d@samba.org>
Content-Language: en-US
In-Reply-To: <dbd2e0a8-c280-405c-8106-234078181d3d@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> for-6.19/ksmbd-smbdirect-regression-v2 has the fixes and works for
>>> me, I'll prepare official patches (most likely) on Monday.
>> I have tested the for-6.19/ksmbd-smbdirect-regression-v2 branch, and I
>> can confirm that the issues I previously encountered in my test
>> environment have been fixed.
> 
> Great! Thanks for testing!

I just realized that I need to fix the client side,
I'll try to finish these tomorrow. I'll post all
patches then as I also need to figure out the
stable tags for all needed patches, so that 6.18
will get everything needed.

metze

