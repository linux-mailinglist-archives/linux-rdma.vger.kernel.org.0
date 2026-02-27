Return-Path: <linux-rdma+bounces-17284-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAIyOj1JoWnWrwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17284-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 08:35:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564151B3F87
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 08:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FEE307D7C7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7B345CB2;
	Fri, 27 Feb 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BOb1BLE1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41A332623;
	Fri, 27 Feb 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177551; cv=none; b=N87JzkXgQ53JhTMfk2jWk958uDF2RNtgxEFMEs5haDjZlQAQCSh0LdObLlgz+vl2jwirYh1uFgCI2+yr2iEbnS95KWZibpI8z3hvGomPPQvswGqScuSkQv4P2b9FzMpEjcd2nF3yD3uU2mmqy4M65v8hz4PgfwnGxSigRkp2gNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177551; c=relaxed/simple;
	bh=TDS4Zm71RjH961NF7Iw4vKnvNrO9qeZPh0gZtb/7288=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=blF9RcUmTTwj4uMXUGZVOAZtcK3lJrS4pUIsDDqkyidcLF7JzbOoeror8A7XfhjeXhVY7PxNo1w5vuOyQgLDt3Mp8bfCxWqFcGxD0Mm7ys5/b3wH6i/IG5Oc0NI+Xdec1ykiLVEEmGqgMjgXXmhLdeFhi4uYTp2/oJ0p2s0KO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BOb1BLE1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772177540; x=1772782340; i=markus.elfring@web.de;
	bh=TDS4Zm71RjH961NF7Iw4vKnvNrO9qeZPh0gZtb/7288=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BOb1BLE1KbNTQxPZvPNLEeZwHdQXRijAn2sPJ82s5FtiGZv2xUlFkEN4ukbbxmlS
	 9xJHGfjH+SExdsKMKXhhDSdQo5H3S4rzMSOpWEN2TRgXpF1fS6Uldi9taiEpya7W1
	 veCH5dHAze5Zpzm+uvVFAeheoXY7YLA1Cm5vc/CTY4QylJFdvRWVejys6ZYxtTikz
	 +bxvqn3mdMtfHJsj0Y+2ohLquYG0MEry3kvuZ28HB8O3iZi8OD0HEXAHMmqpHOW2J
	 jIe9Bs2fBQIwi7ks+UZ+4sG/oQkYAh1Z93R2OS7uK2TFH/MNDtQmnRvalGVsPzyQ2
	 zp9L5PfZu9s2CpyZPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQcf-1vDm9i3tr7-00dv0N; Fri, 27
 Feb 2026 08:32:19 +0100
Message-ID: <1c5c67e8-2067-40ec-80c7-72308618e267@web.de>
Date: Fri, 27 Feb 2026 08:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Zilin Guan <zilin@seu.edu.cn>,
 linux-rdma@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jianhao Xu <jianhao.xu@seu.edu.cn>,
 Yishai Hadas <yishaih@nvidia.com>
References: <176952361266.919365.7397232673824655302.b4-ty@kernel.org>
Subject: Re: RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <176952361266.919365.7397232673824655302.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOUTbxJ89g9VM1pIwiXCAVnR/2wl8YAsvs6mSk2WD0NdRam8Zc3
 eUor7JuvhHBw1vmanOazJOlvxnsR7oXBKY4WBrkMHo6LImdNTPbPVfnC/WVH58iCvKLxWMW
 W2PVE04Pc6c0odbz3p6XtGUbBEsDpzN5y8l8vyFwMbweErN8HDRWagzfD7SogWzC1uVlZWF
 2N3HKs4sElq6EmRujH6mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:724nT8kkFwQ=;rS8GcRNDT6xOKv7uvg8oZBBLpHU
 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
 ZuRL3THd/vOhTO76hgQF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17284-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 564151B3F87
X-Rspamd-Action: no action

=E2=80=A6
> > Add a kfree() call to the error path to ensure the allocated memory is
> > properly freed.
=E2=80=A6
> Applied, thanks!
>=20
> [1/1] RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler
=E2=80=A6

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?h=3Dv7.0-rc1&id=3D9b9d253908478f504297ac283c514e5953ddafa6

I find that an other change description would fit better to the performed
source code adjustment.

Will further collateral evolution become more helpful accordingly?
https://elixir.bootlin.com/linux/v6.19.3/source/include/linux/cleanup.h#L1=
57-L161

Regards,
Markus

