Return-Path: <linux-rdma+bounces-19354-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 82jbBYSh3mkeGwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19354-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:20:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D533FE4EB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 609EF304A8B4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10831E106;
	Tue, 14 Apr 2026 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RVMPbCpx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC942D593E
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198013; cv=none; b=J/3FObWshjop8j0r6ElZJNQx649W9LmpnsSPAPsRQQ50XJSYg4bQASE69MSrZXOyPCowNqqn+340LzZNOpQMlEXf0EfGrEPq0uDDmgF4mMlBxawIc9Gew9kb+DTNgsSdDreTn/HnCPNIWrE+9HiNQUm5OG1vTRx17/7BdGJirlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198013; c=relaxed/simple;
	bh=6RA72LREKomIWQz20rOHPiKnlvWsEq+7Qsyttzg4eCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPAimtrxl6xvg8d+Hdzjnk0ZG9PWGUx2Er2gu6mdbQfrlWwa7KahcfEfTT2Abl/grHmr94wTXkqJWKKziSx7QJqkRA192KsHBgtF+MwX6+55hIOD7rDbJMAeRjI2LgwLahitM9/OYNp3DeQIt34joCDucE4et9L7dcSmhU2kHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RVMPbCpx; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776198011; bh=Gi1Te5MKu3lSkf9CJ6/ejqyTfTqko6UyGFbJ/Gs5eMI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RVMPbCpxrs3myrA/44pKvquEbYP5i8DwJqhBXhf9Y0wf4A20y10tktbI+aUUqjJhYS2vNsYa7wExTR3pqarOE59V21YwPe+1uMoVandAxfrlFL0WW9Jf5l12JDUFyX+H4Vva4hR61RAE8DrxrWc3Aht4ADUfgoTikmX5kAl4ifp/1XdTcd1Lk41GAGHz5Vz0XKRPIxC7gVBhS0w/LDnTo0pYwtuFptYw/qRdnUrDDIui1tnlxODt1x9E16hyY5yUnkhcKMCMe3wfosiQSphcB1aNbN5jb9FqY3DfV+XQWnBAXtXYoTdC3eyEJu/9QU/yln87SkHiR4dYS5wJKAgBPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776198011; bh=jIhbf8NAjRONiZYFQhjlBZITp05PRjWdLvRU5hMViKL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fmHHwmwpvQrLmEbeFb3hCG19yTzdg/Pg3GgFx+UPjOhs/2WtrtU3e7wFdO+qzDSIWCvEMWD+e6kyjbSLM9vIY3Hy8bS0Y8vi1lecNSrGP34J+TPZnW5hAOEkS1gIQpZRvN317mlu0X9whrv3xBlkhT0taTSvrBd4AwuPdQBp9VDn8BeUkpGsfOf1C6jpogGw9jpmx6CebFUHkcQNkPIaTwX7eqzjfTvOrGp5OSDQl6iJ9m3WrIwDWt8QvkLI+cpEfCcpF90CwwA4aI+vB5cql5meeVNuIrc/3BpHkzVnEFx7WEEv6hIwreqxN3i9N6uaueHx7xskO+foH57cNVTl2w==
X-YMail-OSG: iay6JtoVM1k0h6r_zLyTJrXRIr3aSR906hOswAKIVf64Slcl8gPMUSKv3byLnYf
 s_EsKWeto798l7yb.Gn.PSrflgfdUwonQAURtzPVhvA7Fl0o3QQNLiZfItH6GEaWrn8xbPB48UxE
 JvLUl1qmj.VDD27okP15BemWdGIXJUx_0kotjlCkgd9QUlSa1.dBHkRGNkWuie2.otqvAmh3gcN3
 iw5i9OGoiI1H3l5jU3az.AncPfZd6qXvVRKkwxqGq65_420NzVqHL1atK5krVJbeWFuUTYq5wLMY
 fOdT.lUEhAYQY.tngCRGae4YpvaObv8j1_n7cH5oqZYs2P_.XmKMYZCCiCNC1dflQBrtt87RIXBF
 WEBja3aHB1W6cvjUlpkkFQYSm1Zn1JGRQd3rqFyJgNRtsVL6VXcQtpxe41n2GeDUWDZV22JMEL2O
 g7ycpx_ROUKuh0sAYHpoW.q_A2n.zLTVNNVKr3JI3MdMDHz8bcAAl6CA.JW1kPxAf50vEIDPHdoe
 Gl9iIzmwYR.otZORerLkLGQOsPp1E_Ite6bRgucNB2Tu3Uu2dA1zINBkuzHBWbSMhFaNjFywciyq
 TWmY6BwwakA6_kiavl8EM4am6J.Sz8XMmoOTm1Ffzr.u.AFEq5xuHDf80mPxcISQJyJY9Cyswj8Z
 .REdQHoRybUfb4CjtWMJJXNL2Lodizrsf.c7VJMeJj6k9V4ahOPOB6Sw2MDWjqdZdldRmPa.gP0q
 vdSE1wYIxWYT1Sgv3WhibVlDnUALAmf5DTa39F1CCvrnFTs0DoOQPLmP2wBphWlmMdmih49wJpJB
 95fNiQyCNymtA4Cp.g2.guwEgsO9nH5nTH013tHljLl8t_JuS2wpXWv8dHYS5xRBjX7yKuvvKrAb
 EVmewx6N7Hxei87gZNDUNqC1qz9SfAEYktEJsfMQHL6yXww348XaDF3RtsqivJ4TdEI_Fq9CpHZW
 H9.Xx1Am9mjOsEdCq9LUPYMHx3uauPogOL5sUASOQcfPWRvwAlBmlqblgAQBpfukJ2dRW85xeHId
 5.blW3UTxPYnNfS_9bxK3yPgKDc_jDV3AVyZhZoRamgrMaz._Kj3dBNFF6RsBmwL2IPkv5vmv0D2
 E3fYhZ8vdOLFfaMiAgtu7exqzWBXyxo6xDF2xiSf_h1lBgRzH0_6ZDNpeHkT7L2P.z_zx4E3EASJ
 zwJ9rMY2qgXmno3vN.tkLsfu08qWSYiG91ak4L7ZctKGdXaHpnZNcDyq70BTAQNT7TtMMO63.TGx
 e5Srk8d61YzOKBL3F0Nz5uGpgtLlYu3GRT0rQlYskiY52OgbNimCOHC8tkXsABqrq5tItOjzbTyJ
 rxMD6px5aQsFmBrWFuMtE5i_GweFmv3UArqAq522E.D98Q_cy7hgSu779ep2Gp6t8VD9VXL3HaUF
 ruuxnr7voim323k8z4b1ql0uQFcfnIAPd3dsAA4rnd1mJQ7_bw1crsE5Gsa7UNkqzwT8R_39R0HB
 XBssnbTb_GKkNJPS_jVrmx00zB2Y6YkeVrpdUYTp29ZVF3JTEeFhRkhJ..YQM1BCWWQg.VLz2QKM
 gqO1nmg3Z3WQlSam8wNtgBPIUaGpz4YFNc4LQezYv._XuCDvB2jIdjSIA5AXpQO7aUjCKBWSoYj_
 5eSvyxmm66rqUmy4hXF1VleTovFhE9yHypTTefgV4GMJ3ytpXrDWh9NGitPfyMBwXNIDR6seAam_
 f0SLK5ZmLZp.ldOMdL1DVQ2DaSbB7e6dk0Etvuo8JQ_vGSwNVL65Wq0lXZy8U3eGFErxgtxU4vUS
 YDamSSndVvg7xKTjrPK7eeCh_3uT1JC0wAfketpYsbZF49gM1T59nw3nikmnW2f_Pv8AUEwTGo29
 civCtQR4V8imc_Rr1_noR_XC9ZgOvV4qW8lUfdnJEB7YKp69_xAASmFvKnM2OCaKUe2MJHQQ7nNx
 svqUqyjFepnK6ntadO53LtRnueVc29X4ALS86lTMnlnV7tpXO17pT2.nFivHGOeiuGSUuGqI3pwR
 fXEezigAXlkIYRm1iK.PtKQWhmChZxjxdkCiIJ2KTmPCJ88EMp2hCBL6no6J583Pje1.YEElN5_W
 uCqt0a3sLoAGYNxRrfdoMrXwyFeDFotFHpp4EEq4xYX6S6x9kz2HXB6U0tiZwm5Rgnn7p6l5DxCx
 _r6XjnoGDBBlP7XqYN8Jh08chKthKFHpt_lNMxbW8L3dlycRPacEG6ps14eTur.Vk1TMVZ_NOz8r
 h9qdlP9dBZtbck_ZwzKVSVLCDs.Mh9hnKnBltA23fPbL6hJVwE1AwbQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5645cfa9-c473-4367-838c-8ef631aabbef
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Apr 2026 20:20:11 +0000
Received: by hermes--production-gq1-6dfcf9f8b-7ggwq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ed718aee344bcab0b89868fa26b773d6;
          Tue, 14 Apr 2026 20:10:01 +0000 (UTC)
Message-ID: <53a532e8-5981-49b4-896e-0bf5021ff78b@schaufler-ca.com>
Date: Tue, 14 Apr 2026 13:09:58 -0700
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTm9MG-NzdwxtqJA6LZeTEsmUjyy8da2=8KOVxgDtEqWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19354-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,schaufler-ca.com:mid,schaufler-ca.com:email]
X-Rspamd-Queue-Id: 54D533FE4EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 12:09 PM, Paul Moore wrote:
> On Tue, Apr 14, 2026 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Netlabel has a similar issue to secmarks with its use of secids, and
>> currently supports only a single CIPSO tag in the IP header, making
>> multiple concurrent LSM support impossible.
> That's not correct.

OK, you're right. However ...

>
> We've talked about this multiple times Casey.  The short version is
> that while NetLabel doesn't support multiple simultaneous LSMs at the
> moment (mostly due to an issue with outbound traffic), this is not due
> to some inherent limitation, it is due to the fact that it wasn't
> needed when NetLabel was created, and no one has done the (relatively
> minor) work to add support since then.
>
> For those of you who are interested in a more detailed explanation,
> here ya go ...
>
> NetLabel passes security attributes between itself and various LSMs
> through the netlbl_lsm_secattr struct.  The netlbl_lsm_secattr struct
> is an abstraction not only for the underlying labeling protocols, e.g.
> CIPSO and CALIPSO, but also for the LSMs.  Multiple LSMs call into
> NetLabel for the same inbound packet using netlbl_skbuff_getattr() and
> then translate the attributes into their own label representation.
>
> Outbound traffic is a bit more complicated as it involves changing the
> state of either a sock, via netlbl_sock_setattr(), or a packet, via
> netlbl_skbuff_setattr(), but in both cases we are once again dealing
> with netlbl_lsm_secattr struct, not a LSM specific label.  Since the
> underlying labeling protocol is configured within the NetLabel
> subsystem and outside the individual LSMs, there is no worry about
> different LSMs requesting different protocol configurations (that is a
> separate system/network management issue). The only concern is that
> the on-the-wire representation is the same for each LSM that is using
> NetLabel based labeling.  While some additional work would be
> required, it shouldn't be that hard to add NetLabel/protocol code to
> ensure the protocol specific labels are the same, and reject/drop the
> packet if not.

Indeed, we've discussed this, and I had at one point implemented it.
The problem is that for any meaningful access control policies you will
never get the two LSMs to agree on a unified network representation.
SELinux transmits the MLS component of the security context. Smack passes
the text of its context. Unless the Smack label is completely in step with
the MLS component of the SELinux context there is no hope of a common
network representation. If a *very talented* sysadmin could create such a
policy, you would have to wonder why, because Smack would be duplicating
the SELinux MLS policy.

So there's really no value in pursuing that approach.

> Use of the NetLabel translation cache, e.g. netlbl_cache_add(), would
> require some additional work to convert over to a lsm_prop instead of
> a u32/secid, but if you look at the caching code that should be
> trivial.  It might be as simple as adding a lsm_prop to the
> netlbl_lsm_secattr::attr struct since the cache stores a full secattr
> and not just a u32/secid.

Indeed. But with no viable users it seems like a lower priority task.

And to be clear, I have no problem with netlabel as written. Multiple tag
support isn't simple (we did it for Trusted IRIX) and the limited space
available for IP options make it tricky.


