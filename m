Return-Path: <linux-rdma+bounces-19302-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OJoL3cu3Wn1aQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19302-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:57:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8A3F1BB9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC1BC3009E1C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D623B6347;
	Mon, 13 Apr 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g/RnZw6O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30B3B584A
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103006; cv=none; b=VCRNAaPcxk2Gn0dLNFDX0lSMBcqrSFu2PQhfqFcj6O7zSLvrAkIpXdmGusLO+O1zl2rs4AEwYip13nv1xEhtoerFkDfJu/P8bCzuTRz+lBA6NqxCTSLUGIiUiIDoEFi+hLYcrVqWaa1j8zbuX8/VQSVGnOFFrNQMoEvH29NHi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103006; c=relaxed/simple;
	bh=rmBTtrz9chI/mbl/+nEwMS5pf2+6uFRDUaAG1DPa390=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V96EHpsal44Qoa+yNPziAW8T7S6YYFBA+wpBQuRXyj2zh7vzQG+rdPyYWt+C4QeXIU32BT71noKcrD8Yoes9jL0toZibVGBTNgOdAFCXVWaaauNrsw7or8fViL+Hu3/ZAVJltcM43hCjH6/nzCYMnZIeLnfSy8pgPhQmY4IoCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=g/RnZw6O; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776103003; bh=rmBTtrz9chI/mbl/+nEwMS5pf2+6uFRDUaAG1DPa390=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=g/RnZw6Ob/tVDfz888VQl8f9F4+lZyiuMuMtyHZz4TN3Nhyc1mTSMXvJmGmXhSSvL2kPVPH1KlaFyULgHZ/wmmT+wB4P/2Szc3hPIh28CNrYVh0mNoHEEEla7eRBL4bOYkf2b9sU4PgDpGSrfVVXl4ihshixU+wGM6Ix5FDZreF9xLQ7THgj5jYQpjELMsa1LXty/PGd7kqKXqwfFptcOMIsvpbM4y1pgo8jT5o0SrKjYchQdABgmRHw908WTSr/p5j9DAowei9HX4NRlKMkbNfHPreC/IRqZKpEVNoMD1MgdAgQwtyymLbKIzNelO8ltLeZCGU7fSwC1Gv57WMhFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776103003; bh=lH5eDplIdmWSGuX/ToReB8fKRnuurmR/+UhKAIOV4G/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kOVkNE0/ej/woNpNTRziNmWAlc1tqtjnkRLVgAL0vOWhfdWRHQJKH9cCNSKvv0WgoKpW1v+uGIEoeVktPjZZAf1rUPiYg9LzyjbeBo3CqDeCIpUqJH7yRAWVtNAeyfjaW2gonc5KR9WLVzn/EZBSLtdUFUnK8Kb8LnK6Y+lnL0tVU8BQN7NLmRElyOakTTz37GPuXBlmdYYTD5wDfSjJw6Ddk65rVlSD7LW/+GYK2BiQvgtj3ChhqLBv4kWdZWvGxHo88p30sfmObob5TNdikWulckZaQXL1kzBRgE/EpwMfFZZBkOvr3DZaFQs2yCPlhyGOC8jD/LHRDt07cuEtTw==
X-YMail-OSG: Q4M_pPwVM1nv6EaRII.6WBpG_K6KUDVr67FR5BPMefwsjqkpMk8uT2qG1idDE5E
 WGB206otxTuQeEcQkfJ6LjBtbeTxskR4DcDkeRrQaD5SGY58qk0m5O0ay_sOdmsFbkOaIvhuXnVO
 2AkCqsJ3j7uCctBZhAW9qQROi.JhGIs7i.Iq9DGLSGOQlSKM.EufFlshOBDG01cndr.NfJXHf9y_
 mcTJFoO1xYphgMDavQxgcOJSfrvQRNdSkewWKUdx1O_G56r_ofyrT.gk4eom9Poz6_lNPCm_btaL
 KPpvJWGeYBLRnEYivpB7_dxxZ60ybXzpwPz14hRCev2C5YDSI2yhy2ZgbuaokPp1PQxZoZuCds6y
 ov4n4i2gpKwO3zDJjTVi.az8LC9EmYhT4F6e_0ix8kLXDHVoMbFVdC0eGi.HPdlhZDMP_IirLODz
 LPggQd9qjsTbw6WueiIGwWc8sABqYvAbGvoYUd3Rr9NqJ55M7D30fny2DNIINYV3KbLMeT.68P24
 JE7dqzQ9O2X4lDyruvlIJIHl_XOOBbrzaqDlGKxakWedeDRfSZBQXKgEzh6v1iXGfQf8o87.wBQc
 BPJaqmRdlBWbgPcXtNliyMB7ZB_mUtkoPAzpDbh5QUEZKdLEmywtMYuKUATO3z9px1wYgPkIxHaM
 wkiwKijOwja9_pZRFSHHDMtmY7mJEFkLsJNVkHVELaiRGbm4RPDWQ7J5vcjVPaOgSBT6PN4ajTKp
 z0v8RIeXfUg4eAGoADDVu35ejkp4nqfjfDpjbDOBOXal00zz6aFNCu3faeiv2BqXx363SW8Z29rt
 NiYC8a.dA2pYdKbzbc9OUOPJA88u7HuIO4gcKeDDBVOkMkyr00lPUNsXFvC3JXAExLLFiwT4rbZU
 V_JKdnGHBT7SywCTgy.8aKCAMRLhjHVBJeLryIVlCEboQyG53Eub8EAOiF6QBC5yfbFXOht8KclA
 hbQ8QUS6UJ_ZG4eYiPH01bZaV0R5DUV05cDBUcB4s0WXmfWkvu__x6T5i78j.cni9FDF461QTw0o
 Omqf.b4SW6ICh6Zq5DyJJ5FU4W4SquW80UJhREm9jK3prNFkyVEu.nfAe76dI4rL3LmiTUCVeSyj
 iznTrTdyc8vFQ4g648sZy6m31G77s9zikPPlIh2ZKW0RXLTjaS0T8GKFVflsHNuE0RlhQt8gmi.e
 9Jrg2jq2DhTd9h3SQVimW4sxo5rxmshzjVlvdegqs3Pu0HhxWHogdW2_xS6cvGE.ft3xjwOWTug0
 0vtNthaB2b0UDvDugk3JYV8JTekNIUMsH.bBFrzDUJHlx6jpEjOPPrUkJSmfwJlYqtjTZMJaY3Wf
 dJpViVcwtKuxadUjKMuNnzzIPntrblLnFEqd50yXCvc4o88z.EypVkYRhkhXgV0wY_1gLtE9yc_y
 ZM4LzXx8W2PlfdXTQ0kvvVtkQjKHCWFwH1CourWrAnkuJQgsNOtIaNRUxAreDXEVqHjgF9qm64Cf
 cTicxV5jCycINI78oaPUssir8_stEcOHp8LVmjG6LH0n_vsJlMJBxr0QQKNt8PrtBxNW2B53Usik
 _0DBKCBgXl3tjd_6SL.Ebgb1VxOVepX54NC.v2lltWTsU8hQFlyQgFl5KMDMGv6ieU9JZZ1UCpoQ
 FDvysIYDpMLZAsMl2vVFZlL3b4iRYUyrIhYWfay2VC8eokjgWLw_fCjKPEZQUszhdzfeNa.2_BBm
 vp6J9jVyHA1NcD_pcLGQRqDfn92I70NgwrdZg9u9pSVqr40ku.FGv1qUra5c6fQecup9yTTDepOh
 dSDLNkUDZEzP3DjxshO4vCWlZi7P_jIZI1FFqdakPnSTNF47SO0sFvUhfafrtXk8.2b.tURmUmrA
 Zl7GX2XvDugs6_bTIoYfgXPlzKw1wZO5K9c82wcu8okp5X.Ap8Mf8FnlhjwqPvwQecGGBELaF9tM
 lDGZHQePfW2np0PWeOBojfWWQ6ogNyzPdvnqiH1DIoL0wyFX4E98ly5Iesn0x5ZPXipcSFe7PFY_
 kn_LDkIoWSNifQQXCJkLRS0aTDfXvruUf2zuPCUs87g.ugeBA9d8_vPCJoEuqSVuGPrhi0gi.DZI
 oxnR5oz8mN2t9QhuHIGToJ3pYY45vl2fJdswtUWC7OPr_WvEDEvZibZkgC3LvNo7wnYl5omt4D8F
 M4o2TwkUTel_fgTZJLnpQIm3CEVlm2i3BeQvwdGiRpH5ddnCeJwgqG9vyXSpFCGSVWXwOpBhveKi
 RCLPxwd51bhRwbqrX69hKqMH0ZZUocGg5vMInedDXzK9JaDwK_giFBIKOnDCS
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 955de430-2ace-48ee-8b4f-2fc6e9871f3b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Apr 2026 17:56:43 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xs62w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b13f36faa7b702ca1ab4e41c810c08a5;
          Mon, 13 Apr 2026 17:36:25 +0000 (UTC)
Message-ID: <bd7d139f-b5d6-42e1-be2c-4f71feed63cf@schaufler-ca.com>
Date: Mon, 13 Apr 2026 10:36:22 -0700
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260413164220.GP3694781@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19302-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9C8A3F1BB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 9:42 AM, Jason Gunthorpe wrote:
> On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
>>> We are not limited to LSM solution, the goal is to intercept commands
>>> which are submitted to the FW and "security" bucket sounded right to us.
>> Yes, it does sound "security relevant", but without a well defined
>> interface/format it is going to be difficult to write a generic LSM to
>> have any level of granularity beyond a basic "load firmware"
>> permission.
> I think to step back a bit, what this is trying to achieve is very
> similar to the iptables fwmark/secmark scheme.
>
> secmark allows the user to specify programmable rules via iptables
> which results in each packet being tagged with a SELinux context and
> then the userspace policy can consume that and make security decision
> based on that.

If you want to pursue something like this DO NOT USE A u32 TO REPRESENT
THE SECURITY CONTEXT! Use a struct lsm_context pointer. The limitations
imposed by a "secid" don't show up in SELinux, which introduced them, but
they sure do in Smack, and they really gum up the works for general LSM
stacking.


