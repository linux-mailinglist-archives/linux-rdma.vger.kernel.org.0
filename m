Return-Path: <linux-rdma+bounces-19351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAC/FbB43mkHEwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:26:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9A3FD0F3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3E083021C37
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500A3EDAA0;
	Tue, 14 Apr 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lKg6Cz9m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD11D5CC6
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187526; cv=none; b=WrV0GHBapbyeMMbReW7a+aUBzdZNQZ3vlu9K1ooK3DHDuZmAGp360SpntRF2/jw0D87hDCqVIA9lNoTI1GhqsVJyRiUQOfLsLKXVjRH/Q99C/bzNGw8Ub46SKZSCOPjWDfVCuL55xo84Q0OJWTXd+3w3KI5vqOzhvYnQaf0t1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187526; c=relaxed/simple;
	bh=1R8ck4miS/ptVkXJyvQbxFUMSaydM6XzvJ8O7WgZWIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQQh7Rwov86cmbd3NNtZy0yWfB5FnWsJymuuAQ8dySCl0kKOkpMUMcu83wC8x3IoUF9q7WUxI3RUZ6QSzZKqFd0HzZNNJN6qAplqX29M1KSGGixp/AnPLYOu0/KJea3HXuEAmFc27Y7OeAaqHsvll9OTq2jEuh/nZ7Hi6WC/aYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lKg6Cz9m; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776187524; bh=kj1sfOzHMYPt1j5hcLFkJwgzxKgQtthmIu4jaY8YNj4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lKg6Cz9mOYP1MTux/LT1po4vNffBoBYUq4Xpt1gqnU0DVXRivpsdASB2LxI/f1OkBU91uLvtRcytGxnIH0uS9CSQ0lga1kCQ/RfZJ5R0qdxiTkXfr3NllnIaCDczsE7Hqf0qNuQ70vOnROEzYwEG+9L/U/lHwdpgiSzyPo8oOi6vvoEunbFvi9R1gMHOflIIr2CCsTV+WdWmZFLZ9uKBDXFw5Ai06fJKcC4oKGvigb6URhR8cTfgWwq/xOk4R/AkD2zRCIl72TvKmeWhvtFZHoRt0v65dVHRDqEnxnSXD37P1y53TlwW9OMDYCDQgcKOXl71AcaaQ8XZfZrpPybuRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776187524; bh=quMPjD2oFutnBQjoMPqKL0L+yx6ZwrVmOEoWc4Ie1/4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fng5fp/j8V2HGkaFUwaj1oj2deTIbvSxqiNxgOSUOEJzYxwZR7m4Ffe276gLlVsnd+lfWcyyCbSbMspA9gG6HhFMgArFwK5ZO5ZLl+jgI/bP9NXxF3NTqW+oNWYrk3iLlTlPqH3bl7/L6Pd6BqWK5OquE9oirvs5+p1+dHxdAjF2pakMf10YqIAn43Uz8nQM3bYVIYsBgEme6QrzVQIyLChspVp2f7vXUZDHAjb+EOOe5kS4mxjCQyZfX1M7c2acM/xLNV7f1/biuIMoIIKieuAOXqPJHgUxB6uUAAaflOBODOFtg7xWcgiYocmbKpsKt5PB0qTqBqMqLj8sI87Q9Q==
X-YMail-OSG: GFhkpDoVM1miKjVoM.uwrYUwzunfusklP7VPzKJwE7O06Em3K18yBDscxfjeovn
 7nJneKeH9noG7rZ_Tu2u5LFlGrjAU6bq1UPsnK3rTMJGBzIWPFPUVhLcDX.01cN1v4HN9qHkWLJh
 eYuduXAtuCxuhizj9.aik8s0xm2ipm_LHCz5nxKWINblTD9hfY1KoGFK5T8n7jkoJBZyTGNFLU7l
 MSGhp8zga3c7AiPYhlx0QYiRDE_3FnE9xjE4GWChym9yDJD4JeVKjNCRCU81SHEaIqwfgUU7bFmN
 4JYe1pEfCPZZKI_EnLxNcCX31QQQ8gZaeQQbdgjCRDEflGbdXRqIF3XRPTxnX.A1E9ppOdvZQ6Rj
 _uTwypRhpNCzR.yWu.OpX9_YOApqbkVL1yT.ZkzVcnE_ulS_dT7CqPg46erp360ppoEM58bw7R8u
 gAMHHhROjPN8fBSuUFEq9ozBrrT5ADyMvMaZqbCrhYJebGs1vIpCnqPfqCKY6hCZT3YMKqqIw_RK
 9Mf3NXp2ue1UUu9BOYJ1gt85MkPbA1wbLZYBlSrjVij9PHaWfSEWZ6CfUs.bC8dvSQyclLWb85.2
 dhQDm8MslR5EOjmzDv4MlLaCByfBgWdaH26dJjftyoPVd_DP_jbLdYnox6eE5W5S7_XSFbpBKj68
 LVbeZKY3QP0O1htLsUZHzaDTpy93gjwNls801GYQQGZGv5ct1Lng4O.dnmqd3O_iNs_54zDYck2C
 F5g_LQUZuTGILTTiNJfWWcdFAl.dguR7Y_u74MjqO6kTF8PhrxlPFm8zwRlr3UeTY9sBBxlyZnzi
 grjYit19CPDqMscCvXvyEmq5.p.Q5TTqqdhXYXQ4uGMG9BwQam4jP5wken_F4kMZsPZdx_N4XxNi
 bvwXyG9dLNc6BfUxWmViN8ijKPkteIsxi961WDFBsAZaE5qL95aMwL3ssKzKVGIyV2pbH7FanoVB
 1ASRzntLh9DEFWs1NKj9VSY4fCZ9BUbRPBg22tXubyUzL4HdQgvqt7Vt0gRjX1AjCmaHHmFmC9jt
 HFAp6iViR4iU6mPXGWxmvNcf06KtL0Zd8VTyENX18xd1z24XrP5DW6Jxm6wdKxFKNKhlnBGT86XJ
 uiwr0yU_Goy2Ij7SVwVNoua0KJCw_kG47C9VrXFPt7zwvfA8UNivLUQz.i8n965bTYBVEvmdlYl5
 U7IISiSGwcrTaqcXj8qVhoM1PvBEJZAasAbax0TyHebOugNe9m4dvqCxxBo8ZtM_t.O2mvZ0kYjt
 UXNhp2KzoGZoA6pKZ_v1GL8NKgADXkjXLWqMlH9jgAm1QiFVqnGIXvY0I52pw1r_qHvfzvpDgQXf
 n1ayfeYTa7.2d1.VuJ_.NL2_rgiRvNLxPfy4a0pHbe30yYI2qPsRbxxSqQhPE8r6svR02CfCEtQw
 PVmySonj.rAzSzrWQLC6Ko0ci0tLQ79bIa.KY1oufgCc1TxxYaumpT9dnUJKePyrELMpsTA6XDLr
 EC.1SPEn2jfXm3XrXg3GwherzMjRzxtvUrfp45fPHBvzWUO0FiLrMzTswwwiDwSAB454DGKD7YIk
 3evDvx6yrIIFhWxuLw4kvbZKRZp2QLy_kVDRueJj2AmM4t4SFIfFoQIKWaKKUcZmuRPFtD8ALf3Q
 PSzs68Oq7th9Tp8Nanc4jWwLn5_ssQe7HYGBpikpkADb.2vf_PAGIIH8fVuvv4hW51PpK13g_zpI
 UZLTo3Fnlb522fsB_gQzhTwSVPFqzA2W5zzHNgp2hbvitLQDR8z4hMQs13j0LdB4.Z4tLyP5UEw6
 3BAv9iVpe4FWk3TasqKzqHHJYsNInkbyQleW0raWsz.b9q8gYqOSYWq.OeFYr6JEyi.Uqx6Zlonn
 gE7FGshmgeKRxsvWVLzWv1pSqEc2lpVQRfKVTXZL9aNUX65.b4nGiIjIZNCcmkf0AJ5cVjE1c8qC
 7K.1uh5_IvUjy1jIttZI2XX6mm2foNVd2WpXj_3p3IW40V0WwLJ03_XvpsHf6f.q.ES2UthI2EG4
 iddwBfxxy9yTi2Zc.nFCTAvsAH2JRNifweCLeYtEEw5XQPZYe_epLhpxpdh_hu.92jOYOqAIxLiQ
 wFqHkyjoc1lHo_.d0LR1wbriOjl8MMRkZgR2lIhcbp_kTYyJvIHb5ROtHi8LQ3wchvHgkAormXQG
 iyX9GbH9wdyJRZ8P2pUhMFikVgIFb4wA7IRbHwSUYQsoNAnI8q0Oz6oJyl1Hh5lkEtIkuPdLZRSX
 ZEb.bUvPlcHIcCXy_tk5kTmuTiHYYR7zwQIFujMLOdr_LoexoHU5wDYhdk_Ln
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 30480471-503a-4ddb-98f5-de4e115036aa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Apr 2026 17:25:24 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xb5j9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2513f61ee43f0821ef423277142ceb5b;
          Tue, 14 Apr 2026 17:05:04 +0000 (UTC)
Message-ID: <4cf6b20b-f53b-4b5e-ba03-c7ac01bec0c2@schaufler-ca.com>
Date: Tue, 14 Apr 2026 10:05:02 -0700
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
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260413231920.GS3694781@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19351-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,huaweicloud.com,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,schaufler-ca.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 47B9A3FD0F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 4:19 PM, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2026 at 06:36:06PM -0400, Paul Moore wrote:
>> On Mon, Apr 13, 2026 at 12:42 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>> On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
>>>>> We are not limited to LSM solution, the goal is to intercept commands
>>>>> which are submitted to the FW and "security" bucket sounded right to us.
>>>> Yes, it does sound "security relevant", but without a well defined
>>>> interface/format it is going to be difficult to write a generic LSM to
>>>> have any level of granularity beyond a basic "load firmware"
>>>> permission.
>>> I think to step back a bit, what this is trying to achieve is very
>>> similar to the iptables fwmark/secmark scheme.
>> Points for thinking outside the box a bit, but from what I've seen
>> thus far, it differs from secmark in a few important areas.  The
>> secmark concept relies on the admin to configure the network stack to
>> apply secmark labels to network traffic as it flows through the
>> system, the LSM then applies security policy to these packets based on
>> their label.  The firmware LSM hooks, at least as I currently
>> understand them, rely on the LSM hook callback to parse the firmware
>> op/request and apply a security policy to the request.
> That was what was proposed because the idea was to combine the
> parse/clasification/decision steps into one eBPF program, but I think
> it can be split up too.
>
>> We've already talked about the first issue, parsing the request, and
>> my suggestion was to make the LSM hook call from within the firmware
>> (the firmware must have some way to call into the kernel/driver code,
>> no?)
> No, that's not workable on so many levels. It is sort of anaologous to
> asking the NIC to call the LSM to apply the secmark while sending the
> packet.
>
> The proper flow has the kernel evaluate the packet/command *before* it
> delivers it to HW, not after.
>
>> so that only the firmware would need to parse the request.  If we
>> wanted to adopt a secmark-esque approach, one could develop a second
>> parsing mechanism that would be responsible for assigning a LSM label
>> to the request, and then pass the firmware request to the LSM, but I
>> do worry a bit about the added complexity associated with keeping the
>> parser sync'd with the driver/fw.
> In practice it would be like iptables, the parser would be entirely
> programmed by userspace and there is nothing to keep in sync.
>
>> However, even if we solve the parsing problem, I worry we have
>> another, closely related issue, of having to categorize all of the
>> past, present, and future firmware requests into a set of LSM specific
>> actions.  
> Why? secmark doesn't have this issue? The classifer would return the
> same kind of information as secmark, some user provided label that is
> delivered to the LSM policy side.
>
> When I talk about a classifier I mean a user programmable classifer
> like iptables. secmark obviously doesn't raise future looking
> questions (like what if there is httpv3?) nor should this.

Secmark has already failed. As I mentioned before, you can't fit the
label information from more than one LSM in a u32. There's going to have
to be some performance degrading hash-magic invoked to make that happen,
and when I've looked into what it would take I was very unhappy.

>> The past and present requests are just a matter of code,
>> that isn't too worrying, but what do we do about unknown future
>> requests?  Beyond simply encoding the request into a operation
>> token/enum/int, what additional information beyond the action type
>> would a LSM need to know to apply a security policy?  Would it be
>> reasonable to blindly allow or reject unknown requests?  If so, what
>> would break?
> I am proposing something like SECMARK.
>
> Eg from Google:
>
> iptables -t mangle -A INPUT -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:httpd_packet_t:s0
>
> Which is 'match a packet to see that byte offset XX is 0080 and if so
> tag it with the thing this string describes'
>
> So I'm imagining the same kind of flexability. User provides the
> matching and whatever those strings are. The classifer step is fully
> flexible. No worry about future stuff.
>
> I'm guessing when Casey talks about struct lsm_prop it is related to
> the system_u string?

Yeah, that would be it. Lets say your system supports SELinux and AppArmor.
You'll need to be able to specify an SELinux context, an AppArmor context,
or both. Iptables can't do that because of the limitations of a secmark.

>>> ... Once classified we want this to work with more than SELinux
>>> only, we have a particular interest in the eBPF LSM.
>> One of the design requirements for the LSM framework is that it
>> provides an abstraction layer between the kernel and the underlying
>> security mechanisms implemented by the various LSMs.  Some operations
>> will always fall outside the scope of individual LSMs due to their
>> nature, but as a general rule we try to ensure that LSM hooks are
>> useful across multiple LSMs.
> I don't know much about SECMARK but Google is telling me it doesn't
> work with anything but SELinux LSM? We'd just like to avoid this
> pitful and I guess that is why Casey brings up lsm_prop?

Google is wrong. (Imagine that!) Smack uses secmarks. It's one of the
reasons you can't use SELinux and Smack at the same time. There is code
in iptables that implies it only works for SELinux, but it isn't true.
That's why you want an lsm_prop instead of a secid. The limitation of a
secmark is imposed by the IP stack implementation. It would be very
frustrating if you introduced yet another scheme with that limitation.

>>> Following the fwmark example, if there was some programmable in-kernel
>>> function to convert the cmd into a SELinux label would we be able to
>>> enable SELinux following the SECMARK design?
>> As Casey already mentioned, any sort of classifier would need to be
>> able to support multiple LSMs.  The only example that comes to mind at
>> the moment is the NetLabel mechanism which translates between
>> on-the-wire CIPSO and CALIPSO labels and multiple LSMs (Smack and
>> SELinux currently).
> Ok, I think they can look into that, it is a good lead

Netlabel has a similar issue to secmarks with its use of secids, and
currently supports only a single CIPSO tag in the IP header, making
multiple concurrent LSM support impossible. If you're defining a new
mechanism you can avoid this limitation.

>>> Would there be an objection if that in-kernel function was using a
>>> system-wide eBPF uploaded with some fwctl uAPI?
>> We'd obviously need to see patches, but there is precedent in
>> separating labeling from enforcement.  We've discussed SecMark and
>> NetLabel in the networking space, but technically, the VFS/filesystem
>> xattr implementations could also be considered as a labeling mechanism
>> outside of the LSM.
> Makes sense
>
>>> Finally, would there be an objection to enabling the same function in
>>> eBPF by feeding it the entire command and have it classify and make a
>>> security decision in a single eBPF program?
>> Keeping in mind that from an LSM perspective we need to support
>> multiple implementations, both in terms of language mechanics (eBPF,
>> Rust, C) and security philosophies (Smack, SELinux, AppArmor, etc.),
>> so it would be very unlikely that we would want a specific shortcut or
>> mechanism that would only work for one language or philosophy.
> Okay, it is good to understand the sensitivities
>
>>> Is there some other way to enable eBPF?
>> If one develops a workable LSM hook then I see no reason why one
>> couldn't write a BPF LSM to use that hook; that's what we do today.
> I was thinking that too
>
>> However, it seems like direct reuse of secmark isn't what is needed,
>> or even wanted, you were just using that as an example of separating
>> labeling from enforcement, yes?
> Yes, and looking for a coding example to guide implementing it, and to
> recast this discussion to something more concrete. It is very helpful
> to think of this a lot like deep packet inspection and
> classification.
>
> That the packets are delivered to FW and execute commands is not
> actually that important. IP packets are also delivered to remote CPUs
> and execute commands there too <shrug>
>
> At the end of the day the task is the same - deep packet inspection,
> classification. labeling, policy decision, enforcement.
>
> Thanks,
> Jason
>

