Return-Path: <linux-rdma+bounces-19307-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP5THrpA3WkubQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19307-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 21:15:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FFB3F28CE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 21:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD2A7305BFCE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784B391856;
	Mon, 13 Apr 2026 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pHdjIZqN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FB35E529
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107353; cv=none; b=CISOo0Q5dYGWYh7u+yQP4vdWMoj+WFxH0rq2O7tGbPISd0dQaw+FkRzarUl3V9woe0N46cHzhdU2twiIaNH99wygR97Elfs1Q5h5hCD4Trb0UOB07L3b3aOvUhK2m3YtRuWXtjq9IbH34bAMCVUwYHzT4PwDSg++zdEvZI6BRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107353; c=relaxed/simple;
	bh=4lCjZBrL20Y1MEon1+tdGW8CkaiyHj2NmsrGq6qstrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjogJyCEKbU8+dmEWr71ymrH53ZL+GnDe4b0UyHC23JUe68c6sv9dV40iVcF7IhKeWxoy0dZcDDM+6iYo7pg8SeqBUH9d53KEZuYQ83l8sl7qBobkfahGbrcipdPk5P56PYCnhbBdYTVZQL1d4+GPCsl2amH9g/MyGkvwIk6B84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pHdjIZqN; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776107350; bh=4lCjZBrL20Y1MEon1+tdGW8CkaiyHj2NmsrGq6qstrQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pHdjIZqNnW+dbZRvMjbm9zdetYmS1602MegnsXCul9FLDxAHEwD4XaqlX5PCEe1FaE1ts97gQ6A+G/RLY6HOZ4Cgs5wZHYXCJTrEmtcpA1n6s4HAX+JTKMRLlSbxCrH8Q69e1N3A+AGZ3osGw0Iihn4am7QkNBfAKpXvP/fDMV4K33hDB36tXLjHeAROAuLfqeYSWVBd3EEYHTeG4Th8PU59EDAoPE8O5pgPPhUOb2Kt/k0YAFTJsFWhaWBeivvUMowSBTcAhBzi+GUXlcIVJRI99PwOwhYxBM8p/EMqjxmwhX0tTHznTLjLLnVVgFW/q7qb2qW0oVG0jtDRPKfKug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776107350; bh=E15Dqj+ts7GhtVutkKE3G/CPgTeb/uCXfpQaID6ENp6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=p6Yiym3hwvN/SEDLXNnRddJqUjRWMd3rjo748ag5qutHzqJF56y6gRROrGXHhShv9M1s27EaUQWxS/sMePrL/aAnxx5jiC4CrSyi+l/GkAzMkFVMKNzWKG34IsuIkJHMizOZmX4uiOHMCF/pCKS1yDf43WTRJDAIBgyzDklqoisqyjaPOJ7VrZkFq5Qek4agupQCMqFWJcAuf0HgBiKGaCD9d7F+DJ4pVhCCzFe5UNPLyxYppzf0oZZhQfiOpRarHqedNIhlwN+Gfih2p/vwEu+GZDAGZSgXDgteT7bdpebAMn6aayTE3i6yLk0z9zuK36MYfB8oNACZMeh2yV8vpA==
X-YMail-OSG: S.53nWMVM1n5YHcAVgmX51Tz.J7cK4w9XPc2eYfDt2DURaDD6t9wsnArxUjuU4_
 LWb38xC2bJ6eswZi03x3Dm4YVaZE6iWLESzVcFigTThTEzs1ALY2wy7uzmwKkCD.LU3SsM6DSkqv
 LGS38bio0Wc2z4jiVLEGo_X1U92JBlsOAz9FUVm6tohsBe_FL3GlohL77kKVBPEwQ1dI2B9Q0z6l
 s2kYaVC.jLxjQ_.8QvZq.wOPLUmzB0e.BN4OhZxR6u_EJysRb4B9TNhR_rQZnxFq9SWaRuazzL6Z
 fR2IBhfAIB9qdnquQ9acNg4x3ktrMFof8lsJRkL7hJKjaL0QNtvmdDKNpJ2i2dHF_ePBfIO89iXJ
 qjhB6dYw4VDrBBZeSnr77opZzI068pyvAPBseOkA49KskHY2CX7ihE31SWD4aHRer03VlzTzQ_Cz
 mQegpNzmMIawBGG8A_dniUaikUBPH5svvWtjWEoTfOn5b0jnyCW9Q1qDYsi_7ejuXeaTg4iJhoRQ
 FFxUoOLRsKMpGF1sgXtMnnx9a7lpxWpKpf4s9PPDXrzY0X4e3Rv0_NC.l0MXBK2SLVsYTaTvqppP
 yUPkBZ5XEWcFSQDiTawQkriQVrx6iNh_8IAckzISMxnIrbLgW.H.bAgr6PAcbvXq0rD5wt8XYf2j
 4mrqbdRfhlBeR8AjIKMeKddFPvSrCPUivEgFht6sRzNL.4_MYaXlFp3y70aElBtH.vv4CJRG_MlJ
 0j5quoVIBaWENVEPjRROw1omd4pK8DB7UprFSsxKa7WSe.Yz9ILvl16H.GE6NKhSl1T10JVpxAP4
 uQzMCiZtTNHhBwBS.bO1E5HMKvV08qTe6KHhWQR9QNEY6WmipHp3I0Zhn4vlY8IOjz6s4CLEDfj1
 hbSss.gTZWXl5g2GwmR5OEYzYw1dkjVz7g3hIQ9xxS0yYWsLTFwB4cGH77fHXKi.TuOc48muQVLk
 Pl.UQ0CFLXlT5P7wbQIIldamdsp5wv1gfpYa4h9GsAUg37IpO6.1t1_awti3UigKfvGcLs.Gm65f
 s9JnGS08GRH_0azPL4YkHMrBdKVQQ1w70T_Ay5dC28fu9Y38YwMGoGRCrDYNY9GnmJ2vZN2C0rer
 fRSmYZrrosRMGvJ_d0RpUj0n8KVoNRjHn6u_Yy051YJtG_9FW9sy_xbjTV3BBV4j39hSJLXi7R1N
 5il75zqILZLFxO6Tx102wKnBdaT1k7H3Bs31jDxv3BFw10yBX0lEgyBVsJ1KOKlap9_2AsqFNdOw
 esyjPh7Uhs5a5uljW6hj78wdQ53QV967JrExR3xEIjdXocSkCMhAUnryebvECIX5j60WOowZVh8J
 tXXHyfcyI5XHZUtqezq7aeTa52LUx6zmgWT3jfIetaOcnDI9BMXRPIAb.Q8T39NvcVI4AvFEEMfo
 D7x8841_S1WgOfv88E73zDab0ZLh.gvPI44ECNKrLQRO5MSpuU1_FyYLSZ9_ODrynNvgJT7YvOF1
 ghP9mu3iaOocaKvwtkpxHrOIAb2zERr97F87t6t1IHoh4p4zfcSsLmxv8iAXoRwsnhCdsoWGCQxm
 XQQBgZf5eGqcoambDihRYGKcSgzMW6oeWLFP7kgFI8jYYKoKeMHZM3GxqJTBN.5i_UD_XKALNc_L
 55aMnUgTAlhRAv2lgHkw16DzYB3vYzfp7.rGjjpXwMwWOXHArGZNU3MnoiRhNqNDUMTLyNL5WFX7
 VVjIyi99WXAawV16wDhpfXV_EmQlDikiEtGNu2MLz_OCjn9piBOaMz6mxTHEPVo6Fj3TpVYCg_hQ
 au909sTaUzjSWJoEF3z758ksIa.SM8ZDWqpTDuRrm3.w8iESXpW9fLk6fcjJp1IyPWKWBrbvJbZ8
 bNO67LqjOCcRxBbEPeLvxSFOX05bdJ4xn9exrlA_44LYJK9Y9lYxK8MOhWZ6H9Y.V6sy.1.vRHlo
 6wcpwZHLH_q5WUpFW7s233cMNfVFAZ7qfUcVqY3OVbNTik3hVATdi93ZSUIAOhPcJ1cFdNWs0KVv
 5U5ErA4NfUROcYZPx5F.rKr4cYA4vfS9qYepFeRdpZw650Isg8naBbsqrwAEb6E6_E7V1vJM5Neq
 CUw7L4Q3oJ5Uk8y3CgkBIiWgAs1xualGovyQShI7yoY_BE_2wUQET7bWR87ZwHVrT7ljX25iM0lu
 fPR0oPie0Fd.nPkAzKJ7vPb2ox6q.U86MgKaq7PWwJYbNiP7FceTSEaJ_sQbDwEgtO7.xpQw2zWf
 zLkiTTd_mzFCg8kuPjVXdKrCHt03RGw51eV1hcOLaKlHsvnosqNrKuYzxjNSV1KSSsTw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ff501cc8-7b35-4a47-996a-fa0874e3405d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Apr 2026 19:09:10 +0000
Received: by hermes--production-gq1-6dfcf9f8b-x2pwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c2976e02367141b17038844605468df3;
          Mon, 13 Apr 2026 19:09:05 +0000 (UTC)
Message-ID: <7700699d-f6c4-4d60-89da-e0977d086a5b@schaufler-ca.com>
Date: Mon, 13 Apr 2026 12:09:02 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>, Paul Moore <paul@paul-moore.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
 <bd7d139f-b5d6-42e1-be2c-4f71feed63cf@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <bd7d139f-b5d6-42e1-be2c-4f71feed63cf@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-19307-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org,schaufler-ca.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[schaufler-ca.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00FFB3F28CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 10:36 AM, Casey Schaufler wrote:
> On 4/13/2026 9:42 AM, Jason Gunthorpe wrote:
>> On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
>>>> We are not limited to LSM solution, the goal is to intercept commands
>>>> which are submitted to the FW and "security" bucket sounded right to us.
>>> Yes, it does sound "security relevant", but without a well defined
>>> interface/format it is going to be difficult to write a generic LSM to
>>> have any level of granularity beyond a basic "load firmware"
>>> permission.
>> I think to step back a bit, what this is trying to achieve is very
>> similar to the iptables fwmark/secmark scheme.
>>
>> secmark allows the user to specify programmable rules via iptables
>> which results in each packet being tagged with a SELinux context and
>> then the userspace policy can consume that and make security decision
>> based on that.
> If you want to pursue something like this DO NOT USE A u32 TO REPRESENT
> THE SECURITY CONTEXT! Use a struct lsm_context pointer. The limitations
> imposed by a "secid" don't show up in SELinux, which introduced them, but
> they sure do in Smack, and they really gum up the works for general LSM
> stacking.


Whoops. I meant a struct lsm_prop pointer. It must be Monday morning.


