Return-Path: <linux-rdma+bounces-19380-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A91JjsG4Gn4bgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19380-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:42:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EB4083D5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5B0300FEEB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6738F648;
	Wed, 15 Apr 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eJu37NhQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic317-33.consmr.mail.bf2.yahoo.com (sonic317-33.consmr.mail.bf2.yahoo.com [74.6.129.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBD38A727
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289332; cv=none; b=skUDm8IPURAVOSFc5rVeOujcLnbOLh0VBXpP8jwlc3h5eUP7Kc/EnAQ/zqYKSvJe4koUmImV8J0BowsLQYMjAcWN9hWqpI5IcWCJHTpYRTiSNX1I6wRtSDu+fX67VMkNVs5VPkC3ck3fzCFFmdVbcPdlIezl2gLHCfxgOkhu5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289332; c=relaxed/simple;
	bh=1VRzEwc9as955hJAJQZkD8aoU2tfmXZsG3lk/RyK87w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUjD4aloxtui1oR7YZ9d2ihOEa6131soHOAciEaUw1LU9BJcLQA5tcL3H/1d/BF2H71K3USomjnkcO3gaFN5kRHLcsgy75y2/vmN5XW7WVijDH0I5snA4aEecbjW9AUFvBVGYZiVQoolBJaK70NPmrJ4nrYK+Td8RfugdDWyZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eJu37NhQ; arc=none smtp.client-ip=74.6.129.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776289330; bh=PCIEZUDtvL4fKDuA56MB9W3LMeOH6yBvvyQFCUOW0uA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eJu37NhQ9EZB//KES6VcA0ZoEgNKhQmmCG7uQjJS3rVnD2JaGXLbYtCXag3d0fcwdsahRQF2hlwysg0L28CiZ5pjbhD4WF7ZHd4ciPlivW2AeQZMEjLfVL5QBUBB/LGREFIn3suNbvu3GRotEugIWvaggm/H7HMDLP78FyE20DpxrDVyAwR32W65ghDONJOEQBS2zEo3HUWnyMB5698B/xD8Cziuv/6lw62lPQDxJQg1lHd7ebBMSOujJu4t84j3UtHn4zfdRCcdFMSpc8nsAkvl5BDP3py5bY7Qvd1KZK1L2bppKSW67d1vQ6hSVkLNEsr+U82Nc1qu2ZBmzDQSHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776289330; bh=8Nd23b9kPnbMVrpDoG9ynVPDR3R5ucFWAVwcAHdS5Sl=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gVpkB0nxfGM8gMDWVSfuXpiZXPyNYKgF/CWs3oMUarn8N1DOt/osm1Zbapqi5vjQ+3oh9mac8iHxflT7mVYrvVLYF0lccbT2Fmp5lMNnjxqld7ocuQ1aRiO7IwnOTKhi7FoO4yoB2JrljYgCZYN4eaQ2FWxodZGmscEbldgOik2IwfcdWEpaLyx557iUNIynvgA9CA73Ce8baxm3vEqn1Yh3Mkf2Q1pWBrAOCRK7BdTyDgCOVU3JNql/mE+Oi8thArADac66JLfv7rPznlJVDqTouehqKWHIWexPWD5WyFPpcJpeU5W2pt4ovsNixvmzwrYN259czmGuM8V/b4NjUQ==
X-YMail-OSG: OTWDq0wVM1kWBKlAClbtD.6W.Rgce4yInLQVN97jyOJxSa1hGgVXGNaz8TPVgxy
 wm5N0OZz2yEOydYM1i9uZWkp53km0ZmaQkIg_xaEAQozcV1Di9tdpXDzSQWS1GhrMcTVr3m201Bf
 40FW9DxdNkcJtDsTRUNTPDV9kKxT42IPULUl3WPiN7iJCfkWKxlDyLXiE8eTt0KGHvmb.OoGEgBy
 AoXITcef2y4r_WqBS2gLbeKfpnr1RVZihFcNWgCsuIY63wgZbLoMSXSSjm1XtlxfjrPk.DP6XoZC
 biDFbDHSnoY5P9o7u2G.zZilDjVYT.qCa0GNh_g_RDahhSok_q3mp79XDGMCZAGQ.GG.syh6lTHX
 P7fXQ8bkTWUIQA8pTh0KLK6O_1mk6agZcCD3Ba8WhDTDCI7CxauFy.kkMolNdYB_qGXENI.wK3n3
 eBbZ.zjPooFiUCULsa6jzGX.C7VFGzcpLXp1s9hOl1yvdRHIBO0LmhANf.o2aFhh7tnWhAssqd41
 e_7RHNS.i_dixFkALoTeixj6VYYlduEwIzAcQU5DS8ILULg9kFLEmT4DNKPS0CkuuJeRHBCmrG3o
 AN0p75xLlz27f3QoKImoBCNd.2n7G78LfZfgTQ0Qjzg2SUpjIcYwmgzopERLZ92zOXS3Tciopgwy
 yCK65MgTPVZ5BKNBwRd5qxwDf0FBmVAPEhU5ZhPw9k.NIUN13Fmbh3t8EQ7c0wJU4UUTYAWoGELY
 .LJrht6FcvDWGCYBfkzbVmb6XFam4HNtRSKaUTlA9OiHwHtm4gMX6iAVbf.ULGI8J3eJrnntvS0p
 XpUvYDl0cC3V.rXaUlnGmT7GMnjYPfVDhGwbXH9KtEfnW30DQXVtyassb5E4w9w8Vf7IngNVsRXO
 mn3heo2tZw.TslL5cexILIeli0HuHhHv1gRQeKHyrrreLLWuSlxsrfNCTw1L1pITqKrl_dgGrjyu
 viLWNKZR5sCA6YzRt6RbMZQt5xVnI0HbQwMsQWV_gN5.f2AruKDVsBxY4TFUyvDhbJjwFNlf3fz2
 UVUZFtplvxfr5uMIzH2lrhuZ1GGcR0IjajNfhfkiXLpQs9ENLFaZ4fjYKayEcBz5vZ51jv_PSS64
 4K8wVVo4mekXJZGTTq1T8UA0tcFgUGXEBuIXeAVcudJcqwA0mfOcXvy1_5jPVTKsMvLeCcN65g6w
 xrm73ukJDYwf.jg46aqpYnZ6TPb.GN0YXJIRAb9s2BOY0f4DZxCSMUXfAdsLJOxSCd9OC8VMQsIU
 gmw5mLLKSQQWibutpi_be0SxKGt3H1XNppl0cQ7R99F8GcVjzUNg0y9dGrr34MOOURzBwF3U33Ku
 K8LCt.8.s_uWAIRmEKnx6a.V1bPc1dUMi_NIyNSxu.i2B1kHAPIkQgYd8HRjO4E3fM_qPEonpCnI
 skpVSJd3.ApsyiDhpSaV1ChED8ZpoUR4gG42uRBcYph2GHBrpLPUAC2LeOuFRWfAWXf.t.pcgEtd
 I8.UAg67i33D8xJhxToGhcBAnnFzFVSU0F8X2ApA.R4cvXHwS6ZBOO_7n5mk6N2LjeT8O5D87MHa
 YsbmoFSX3my0K6SGsK4XAgU.IuU4.sRCz52du8xWXED03Gi9wbAKiSdf7dok7tBZ7eOoBFGnKsXx
 G5aUNd9kJb6PXeflkbmlkl.Hs5P9Vsi8qtExRZMzAot9nsj2JxmaUkbKB9tHX1vrw_3Qx6syt5_.
 BVYaEa2QtTpNlEdb.hpQJTLRIT5szY2eni9XytJwEoClRDx5LWvfA9V10yoTKxAu5F_Df4GD..UB
 bd.4yenjrfIj3EkXhPq3NBD3gAwoVihMUlAl3ODeP29zNpyOq0_N0WAiC6APoM07UeLtKQyjRvE.
 qnp9CFNvRm7fPc5FDQJeNuDkfKYHAQjzJIvKrokib13kmBLEV5owRT_LJ1ubfTS8aeSlgP5SNQIE
 kOdiOmBLN0dOFrUYyr8ZwYTJVNITmEKnN5uDKN28VKEMM7BwTMxmAAOxmndwH1xJH0Ae6jLHZfJv
 qxgF70jsVRzidZkW32xeYRfkwwhxR1woQAEr0QbYBG2sdw3GyfzgdHXaDZLdQS1EWuQh3h5N.BeU
 mHAuyoXwIrnAH89NmLZq0xjL6gWB1FuxCdLDovUk8Oxny3CjWzGWxtLnW6L7xlF5SHDrqX6bu3mq
 ue50btk6e7y1bf2iXuJf1pQAdHL5rTGCQi5z5ROlkBGtq_MzNHPTQSjrKvrZYdvCHiFwjRie0rI1
 8d2LalaiufdwZdKZYuWCgbmv.p9efZbZyLJR8Zs1qEF8r8gNBIpCazw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2d41aabe-9af5-437d-8e9e-568444c670cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 15 Apr 2026 21:42:10 +0000
Received: by hermes--production-gq1-6dfcf9f8b-h78wr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b799781f33bb01013e1e244a638df756;
          Wed, 15 Apr 2026 21:21:52 +0000 (UTC)
Message-ID: <a77f43dc-f05f-4dd3-9f0f-296447c44e8d@schaufler-ca.com>
Date: Wed, 15 Apr 2026 14:21:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Paul Moore <paul@paul-moore.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh
 <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal>
 <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
 <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
 <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
 <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
 <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
 <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
 <CAHC9VhS1sVMGHpO-5Zn0K0w6suTB-i_SwvouDpEmT8sXffsRfg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS1sVMGHpO-5Zn0K0w6suTB-i_SwvouDpEmT8sXffsRfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19380-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A0EB4083D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/2026 2:03 PM, Paul Moore wrote:
> On Tue, Apr 14, 2026 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/14/2026 1:44 PM, Paul Moore wrote:
>>> On Tue, Apr 14, 2026 at 4:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 4/14/2026 12:09 PM, Paul Moore wrote:
>>>>> On Tue, Apr 14, 2026 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> ..
>
>> CMW MLS and SELinux MLS can be mapped. They have the same components.
> Yes, one of the fields in a full SELinux label can be an MLS field,
> but that doesn't mean there isn't translation needed.  The important
> point is that security label translation, mapping, etc. is necessary,
> possible, and has been proven to work across a variety of systems.

I'm not especially concerned about translation between systems.
The problem at hand is negotiating between LSMs on the same system.

>
>>>> SELinux transmits the MLS component of the security context. Smack passes
>>>> the text of its context.
>>> Arguably the NetLabel/CIPSO interoperability challenge between SELinux
>>> and Smack is due more to differences in how Smack encodes its security
>>> labels into MLS attributes than from any inherent interop limitation.
>> Yes. That is correct. The big issue I see is that SELinux does not represent
>> the entire context in the CIPSO header. Thus, you're up against many SELinux
>> contexts having the same wire representation, where Smack will have a unique
>> on wire for each context ...
> That isn't always true is it?  From my understanding of the "cipso2"
> interface an admin could easily map multiple Smack labels to a single
> CIPSO label.

True, but you can't map multiple Smack labels to the same CIPSO label
without introducing ambiguity.

> It's important to remember that if you wanted to utilize CIPSO to
> communicate between SELinux and Smack, the label translation is not
> between SELinux and Smack but rather between SELinux and CIPSO as well
> as between Smack and CIPSO.
>
>>>>> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
>>>>> require some additional work to convert over to a lsm_prop instead of
>>>>> a u32/secid, but if you look at the caching code that should be
>>>>> trivial.  It might be as simple as adding a lsm_prop to the
>>>>> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
>>>>> and not just a u32/secid.
>>>> Indeed. But with no viable users it seems like a lower priority task.
>>> You need to be very careful about those "viable users" claims ...
>> Today there are no users.
> That you are aware of at the moment.  You are also well aware of my
> feelings on this issue and ultimately I'm the one who has to sign off
> on that stuff.

Understood. There are a serious number of considerations that need to
be worked through.

>
>> There are other problems (e.g. mount options) that have yet to be addressed.
> The existence of one problem does not mean another does not exist.

True enough.


