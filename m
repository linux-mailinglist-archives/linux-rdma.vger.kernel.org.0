Return-Path: <linux-rdma+bounces-19357-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIeFE93C3mnXIAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19357-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:42:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2D3FEE28
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEF3303CEBF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D7386C27;
	Tue, 14 Apr 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AwDHSFhi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED7318B85
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206544; cv=none; b=ISj5oww8ZxilWIsegDFfyOzfKNnAnmLHS8We2cijnaNUPb+MooIgwRbkkqJEz4RVWOquyStQI+X5ioEgMtZ/GvJYjJ1tuTs/WGpSegEHB2Gq+20yjCYfpcKVNDax0uBp1l+B/DW3FO79I/XzXcz9IyHSXvNpTg+HGU8d4jKg5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206544; c=relaxed/simple;
	bh=4FmZF7558vFRvVZRQjylfqMIhy+jgbKLmWnuJG9P98w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCsF59eR4SVQouXkJo0wfIKZbOHnl3DyWEnnZxgWG299hUkUOJlnGeGQ31EZkeeKgbVEEr2DflC7nsCiCBQxz3zUPyoh1O/Y/mNgw68UUl1p+TXLTPANutawt0JO6csBmQ4FZbyHitdQmsYGaS2igudqW19Klo4qHvTgFTNy1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AwDHSFhi; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776206542; bh=6oz1GzunoF5mXCMRgI3YarO93ZRvasdAdnsKt8OmNi0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AwDHSFhiPFoexCT7OfrlfbfHsFRbZb50/7+Fo4T4USMgQaXia9boGJ8iRv41JT2QavaCti/YMXRXZFBiAF1Na0FHPnKtBAB0EgtcY4AKD+rAwDKlOts8KnQ/BX0I66K96ZYFx0bWF7Cwa+iJobJd6Fy9mArqtgKNMkMfZeKj8wX2jpecJ8mNxjeVCmhOFbXuY5+qdZlkIOCSMGPOAYtHHC1gFiC//tMuoK6vrm90JvCJphvaQ8hjEtvaB9u2XGmnWAMc/lzfvgilnTefVNJTHPwDAbo09Os2bDX31Ig9kx/DKYzI+jETJoZO2SX55Wx+e21cRNO9fLjHe4ZBSM6uMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776206542; bh=aAzO9OHFag6YklDPkTrYT26uxyYAUnbydqtnBRq9ZtS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YUyE4zQd/OuKaoxjbRg+EoEX5rQBQzOCRTNirVIQHLovLiRZSKY9l/VRMVCQ7RrZeLyqrBfHalaD5OqGkxmn9U2wUO3xsClzvfOae/1v8bB4qgz/LGd9q5IwKVSY0lhrDyLGRmgT39zEe+4kvyjEbI6YUj+pHUG5yR8gE1LRB82IBmBRbkixvlEUVV1tr/u/E3yr8hpF5U3i6rz3mSKyIzV+OWKeWIHoLZ60q3wlnwwvvmR8ocRMNXXFl7OHP+vt/LLlOhedjk1Mv8lwb7uw8erb5baa+qeQ+gbQBL8lmMax7Uwme8r1ZsSTdFyqOm9b32JUd5mZtSiNFICjtgD5ow==
X-YMail-OSG: Pw8u1nAVM1lr.IMD.UymBkbwkG5bUAGnZzwLrOsQVnqUbNMjhJJZ.dzHBWeAztH
 EorXABIkcZzDNn3tjiSwdKamup_Hqj6iuTQ45kZ4xrf4BfK9vAhRQ0k1M0xqPg0Mc7ce77vinKFy
 RF2IsfLVaKn81eDQyx6FeQrNgsPAvLTbtpLoIUCxFUdQasKRiUXr1CURSIEVYliBM7vb5cWYpQmm
 D35ickUbtQIG5EAplq36gUQv1JS8H8tOzAeRzfu_nMy6R9J1og23bPv0o3YDeYazNhrDkwl4scTC
 crESgeOQlEdU2YXcu5sPRv29Iw9XZa4Nn_xNfcC11qpjahPvajIjmirS0FkCDO.RWTfkzcC3pfBe
 JufDKqINiGp5b81jV4l10GM.qq4BMD7MljdQUZO17KUvCAQTQx6yrd98e8a9TWlyj2k0zniKGWsO
 xJaq0tCes79FHUQga6ArpS_xm44UQvs48.aIhggAUO9xnBFfiBvaMP21rYnXUVHqxswpLEVknvNo
 KEZFVTOyovQNKriUJT83Ot72UYE5sg.5lj.X2el.d4As6Whs2pn2K0P5Sx8PthqtImeyhyFEHh9K
 vgafZKTJEPMSpD2W.yO8KaPhBQopJKPUpfwU0A1qvLcGBtrAucLCWTbR2pqkyc43u_fn2q269G8i
 qg6nDNEtEHHttW3PY06puvQYJfHYFs0dj1t4OzVPtzoqELSH6hkUQym5E7v1T4Jdw6UBKV0UsgPg
 cbxrusBcArsbcovZQqwgfj4Uv7BMLm1sJTFlw.TKMuNTSjfYZ0Aplu8tfa3_.KHrvB1Tlf_o588u
 W5Ms8C18Mqfr0viswsMiuf6._ly.zEnzxYKv8jVn9GYjzob3carltyTKSHMyZbxnJV3UkWj7vPAp
 U8abVjTdHc3P2z110oClxXM5fvtzzWrzA4XBHp2fQmetJGxKgGhk8cehrS1ZO7BhV7qNAZxeMQ2j
 Cat0OELEMBBF3nq7Z7HNcjop7E7LmCbkh7Am5Bv1bUFH6LItzYHmcacHdJwu8Cdj_lGSn_IerMLT
 aSa0FcKykWNIJMQZZ5uJtKOCKtbc5FlGXWcXeAVnynhvwznfXzU2GuxPr7lZpHzFjV6l5dDBEH1O
 MAI_WSP8iV4bqhIbWXsjsixCLVQJ_WP5cEE9bTDpMWsqIPKsA3xm0ZDyH6on2qp3Cq87yS6Vkvl8
 buN602EHoZevNXNOG_P7lVXKNYlhCqr0GF5OsYvVdH1d7BFllhQJEVOxL1F.q6EaBZf.vd5xOVfF
 qhWKgzAUkxScUYYTYiqEq_jv1sIPfOTu_hwbP_wVZIVDOgqifHsFbui_eiAf6_5XH_kJdrqhv2M.
 XLNelWT3c2nOj1u4AHnaAG3zB4mT5szdff3geDdrbHdZl3CdwVfhQCTXcNgoxwG4_u8RJxiCir2G
 au5ey.VTOZ02gTnY6Wsh2vm5x_H6r9dwjoZjxQpLICILOFgifrkbt55bm6x6pStX4ktv3MW35q28
 M43LGy4B2oYh.j5pCAQFPq6JVfqn1SrjfwjwvBQQnSOOFx8iSd.0gaMV9eyovmZtx0XlPOgjMks.
 hSYUzNQpAvCYDCCgKXLhcW2Kv9AaBwvex6HyO63a_CHYR6zWw4SLAodDD6ZeJwZ4j2QIViJqsJfV
 A_UrYvU83XyFieX6.VvJ_n5fRWvUqyElPIr3stRmlN6KVdKYBRxrCHK.v8mYVc_YFxt4ZaNyI3.n
 Gw9annSAOXqFvC42t_TDu1BFNqA18fqhym6Cf1cIw3T5Eonj70e8xYjnGA29BS8CTGqB7QcH0Jj.
 vT6lbRPCMgmHeRhd7R39MslRx7b0yDUQ3caLLwbec2ELTi0xRd.cgoxmj7NiBmByO3yCEUUy0kas
 8lXjbXOXsbTx9YoXl9OMEMkOTFGAVrZBNGVCkv2wOa5O2wXAnJLqIXuSc35vhAWdOmjnDO_oCRk0
 fa766p2gdynnA8mL2udWEc2mQi4Np4h4DNRtkwo8r8If0Z8AUkM2y281bSfJQMqIigQAtYcHNZ5h
 SC63Af1AwL9Roy7ElSYVEP9eR1Q5.TzNTSDzcYWP4AdLxIcJq7koSvTKo2GvA8C8zzjh71ZgDuy7
 VRt_MCNvxkC9kbdR.lw8mZXlvdKs3zgBtS3ouksPY5qZXhgweaa9aYVsZ83bfurYHU3luGQ_qc1h
 N0eBKnhndu3T.KP_OM_TNIoeiAnK5PMAPjd6qomTfi2i6ufaEehIqmeko5w6jRkB2OGWm4WngJJl
 LGxt.cYnLE5dB0wI0f2adeQVqj2_R9J7ufg6Q4Ov9ATJpYz.qb8PKOmAlSg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 09705605-3580-4447-9167-3f29f3bf0677
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Apr 2026 22:42:22 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xb5j9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 946f65a48635aaf9d12068908cc9ccab;
          Tue, 14 Apr 2026 22:42:18 +0000 (UTC)
Message-ID: <a5fe292b-77c8-4190-8989-1d32cadb5689@schaufler-ca.com>
Date: Tue, 14 Apr 2026 15:42:15 -0700
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRoaECt03Rs-ZyoGhW2_qZkA_1weTYYjiXc41Yf5U8A_g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-19357-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[schaufler-ca.com:mid,schaufler-ca.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9E2D3FEE28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 1:44 PM, Paul Moore wrote:
> On Tue, Apr 14, 2026 at 4:10 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/14/2026 12:09 PM, Paul Moore wrote:
>>> On Tue, Apr 14, 2026 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> ..
>
>>> For those of you who are interested in a more detailed explanation,
>>> here ya go ...
>>>
>>> NetLabel passes security attributes between itself and various LSMs
>>> through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
>>> is an abstraction not only for the underlying labeling protocols, e.g.
>>> CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
>>> NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
>>> then translate the attributes into their own label representation.
>>>
>>> Outbound traffic is a bit more complicated as it involves changing the
>>> state of either a sock, via netlbl_sock_setattr(), or a packet, via
>>> netlbl_skbuff_setattr(), but in both cases we are once again dealing
>>> with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
>>> underlying labeling protocol is configured within the NetLabel
>>> subsystem and outside the individual LSMs, there is no worry about
>>> different LSMs requesting different protocol configurations (that is a
>>> separate system/network management issue). The only concern is that
>>> the on-the-wire representation is the same for each LSM that is using
>>> NetLabel based labeling.  While some additional work would be
>>> required, it shouldn't be that hard to add NetLabel/protocol code to
>>> ensure the protocol specific labels are the same, and reject/drop the
>>> packet if not.
>> Indeed, we've discussed this, and I had at one point implemented it.
>> The problem is that for any meaningful access control policies you will
>> never get the two LSMs to agree on a unified network representation.
> That is also not correct.  In the early days when SELinux was first
> being used to displace the old CMW/MLS UNIXes NetLabel/CIPSO was used
> to interoperate between the systems and it did so quite well despite
> the SELinux TE/MLS policy being quite different than the CMW MLS
> policies.  Yes, there were aspects of the SELinux policy that made
> this easier - it had a MLS component after all - but they were still
> *very* different policies.

CMW MLS and SELinux MLS can be mapped. They have the same components.
Comparing a full SELinux context and a Smack label is another beast.

>> SELinux transmits the MLS component of the security context. Smack passes
>> the text of its context.
> Arguably the NetLabel/CIPSO interoperability challenge between SELinux
> and Smack is due more to differences in how Smack encodes its security
> labels into MLS attributes than from any inherent interop limitation.

Yes. That is correct. The big issue I see is that SELinux does not represent
the entire context in the CIPSO header. Thus, you're up against many SELinux
contexts having the same wire representation, where Smack will have a unique
on wire for each context. You'll have many-to-one mapping issues.

> In fact, I thought the "cipso2" Smack interface was intended to
> resolve this by allowing admins to control how a Smack/CIPSO
> translation so that Smack could interop with MLS systems, is that not
> the case?

Indeed. A CMW MLS policy is way simpler than an SELinux policy.

>
>> Unless the Smack label is completely in step with
>> the MLS component of the SELinux context there is no hope of a common
>> network representation. If a *very talented* sysadmin could create such a
>> policy, you would have to wonder why, because Smack would be duplicating
>> the SELinux MLS policy.
> Interoperability wouldn't be a problem if everyone the "right" systems :D

Where would the fun in that be? ;)

>
>>> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
>>> require some additional work to convert over to a lsm_prop instead of
>>> a u32/secid, but if you look at the caching code that should be
>>> trivial.  It might be as simple as adding a lsm_prop to the
>>> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
>>> and not just a u32/secid.
>> Indeed. But with no viable users it seems like a lower priority task.
> You need to be very careful about those "viable users" claims ...

Today there are no users. There are other problems (e.g. mount options)
that have yet to be addressed.

>> And to be clear, I have no problem with netlabel as written. Multiple tag
>> support isn't simple (we did it for Trusted IRIX) and the limited space
>> available for IP options make it tricky.
> That's an entirely different problem from the LSM and protocol
> abstractions, but yeah.
>

