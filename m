Return-Path: <linux-rdma+bounces-22962-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OfHqIaqYT2pQkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22962-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 14:48:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D962D73134C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 14:48:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oSTzm5VZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22962-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22962-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1027031CC0D8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB84314A6;
	Thu,  9 Jul 2026 12:37:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879542B75E
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 12:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600664; cv=none; b=fP7uwDvDPAdu7STi1TOS2VpB/62YuguCyNZMmO+aKj0gxfaRCyISNZ706N+ImMFaJrHVtFBgPdlZ9ouD1BchudOG8CAeh1ZAMKMJEQz4/ilfZBFVdYXJ2pFt3AcYmkbobyXJYyxkrPtbaXfp9HbVdVrCNjEC4tPG7fUDM9IQci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600664; c=relaxed/simple;
	bh=N7u+K2H8AMSpKxT22XYhaTAOeJR5UWYAcY50gHQtV+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVs7VXjUvuzy8NjMX03RhlkA4CX4WjllRqaKfX/WDZ/AbyAJM25VxCQ5QDC40/6kdQvIOQ5KsyNL5mLLIEpvDNDKQdSTbkVPTm7inqZgAadrOLhd6H6FjFI/9fOHA/3Qo+sviEhVPpqFEJlTMmnNWhUe/peGq5X+rubAJCKxdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSTzm5VZ; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c16ac21acso9878671cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600662; x=1784205462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZsM6QHqor3CIMylXI/PYzeAjQqxKR3ZG+lD/y/C554=;
        b=oSTzm5VZ7AfjqOHJkzYkX+wFI4gGi93a2qGibtMzjADMd0+KQ15XUmLpKBT+9QUEhz
         pZ0iU0UQbXCTHq/lik610Ak7La5pZDSlCYj0TB5ws6Po5gVYxNQKxiYyY8tluNujTuJU
         6GNV6NlRaiRw/+Zs+kLGOmdaeMyeVONB4UXX8QbZ0FpbyNkOj1Y9av572FJDxpVGp7+0
         CXj7wmqKhVaTr30U2+PPioWJ64IDEkmGB5XfdYlYgroWD6KcFsn/QShQ+OG4l9NbcQvO
         YLztGYAWcX7EELU5M/WW3X71uqUMV8M7bSpTvp7bYLAES6TMuLJ9CEdMz3qcNdCI8bTn
         Bi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600662; x=1784205462;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZsM6QHqor3CIMylXI/PYzeAjQqxKR3ZG+lD/y/C554=;
        b=aPi8SuLRk8e12GzQLDo5yr5kqCls7HZBrpY1b7SletqAfWlv28P/ARA4f4FAR3MxOi
         jLnzGw/jO4t7HtX3O7LNnKVoJqhk1I7lVDdbwX73kKzymrBTB8UirXiYoD9kQfKslCcY
         jkf/nDNMSdZvZG8jFtyyycfgO2MqrbnpDnXpVNpYn4EZIgZp5tJ0LP1yWI9xYR+rVeSs
         ryKARBv9DABtyqfOciBtmpPFvMRIL5KojjYn7iaSFpRk5uYtLUYSUZGQF8xlLbeQapXS
         t6A8jMnggi7Z5+h/1dxP2gSA/RfTvIDABfXxpzq0VCHSyvWlsvceRKuXYuej2MlzsRxu
         oT+g==
X-Forwarded-Encrypted: i=1; AHgh+RqJuO8IOikXCn3i8C81ilbP5Rcq528pLVpyL8Jlj5XoOZkDA3R9GPv11eQ+hg/j81MOhF75Cq6ckAqc@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdHxKYpdGUSN9e5456CnVzTJ1tfbt1i3ldU87VxtTFi8k1Ifw
	Ezn2DGUCumXMUzRWwxdg4X80yei4lPtHgS/lPQl+tG1ztBXntKmyDGEY
X-Gm-Gg: AfdE7clQJ7/5r+xlTcUMydEYvjLvVGLriIn7prJCVduJc4qjCwyq3iLtylj5JstE64m
	l1Uz2mmOYJX0AgjKa17klNiC4i9npkZH9Mi7Z0SNs0s8+XzEJ72gWG3YoYcxDlETAjs3trYgdzS
	bWdZLNtUjt3AHUg+0ZVWMm7O80SLwxpV5jm78RsSvEv6GYrhovitM0/QhRNNGW1y/NGtMENqmP1
	AAlWknFk/lv5qSkVKWiVgb9MpHALccM0qs1qSSuIjZGY8hTp2EntJfFks6Zp8eGdV3vFjDJRIq4
	E8R33rkCGPEi+0WEUzzYWnOHENYL4lO3UHzVkQwBOYwVNCrqWzzM0Ys4J/tAPs6XeU9RHx2RezT
	VjOv/byb7pGS9dQtZooTancXsamOT9t1UgaUHcioag0T2OZljkHgj6b9uCczURpq3wrmL9lkAqE
	AN1yrpgNmx0jcGv/T9nR/czb1rq3mcwYHJ3+OXmE5KSLv1
X-Received: by 2002:a05:622a:606:b0:51c:844f:28df with SMTP id d75a77b69052e-51c8b420e56mr74133901cf.75.1783600662266;
        Thu, 09 Jul 2026 05:37:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:69c1:4b24:4324:2373? ([2620:10d:c091:500::1:7f14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abe756sm172240671cf.6.2026.07.09.05.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:37:41 -0700 (PDT)
Message-ID: <dab3ce06-b2a7-4495-8fb3-a867e33806a6@gmail.com>
Date: Thu, 9 Jul 2026 08:37:40 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
To: Cosmin Ratiu <cratiu@nvidia.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 Jianbo Liu <jianbol@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Raed Salem <raeds@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 "sdf.kernel@gmail.com" <sdf.kernel@gmail.com>, Mark Bloch
 <mbloch@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
 Gal Pressman <gal@nvidia.com>, Lama Kayal <lkayal@nvidia.com>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
 <0dfe5f6b-dbc8-4104-8883-e88e8e59ab58@gmail.com>
 <9c6a65b7e54a31dea87e7ea1c5b1b3931240f3ac.camel@nvidia.com>
 <3a8a33b0822e82d8a37aeb7e9c326889074e458a.camel@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <3a8a33b0822e82d8a37aeb7e9c326889074e458a.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22962-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cratiu@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:tariqt@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:jianbol@nvidia.com,m:leon@kernel.org,m:rrameshbabu@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:raeds@nvidia.com,m:cmi@nvidia.com,m:dtatulea@nvidia.com,m:sdf.kernel@gmail.com,m:mbloch@nvidia.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:aleksandr.loktionov@intel.com,m:gal@nvidia.com,m:lkayal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D962D73134C


On 7/9/26 6:51 AM, Cosmin Ratiu wrote:
> So the test relies on TCP retransmissions to catch the encrypted echo
> from the responder on the UDP socket. The timeline seems to be:
> 1. data_send_off disables PSP on its end.
> 2. data_send_off opens a UDP socket and binds it to port 1000.
> 3. data_send_off sends "data echo" to psp_responder on the control
> connection.
> 4. psp_responder send "echo" on the now sabotaged PSP connection.
> 5. psp_responder acks the "echo request" on the control connection.
> 6. data_send_off receives the ack.
> 7. data_send_off tries to receive "echo" on the PSP connection but
> expect_fail==True so stops after 100 ms.
> 8. data_send_off reenables PSP on its end.
> 9. data_send_off waits for "echo" to be received now that connectivity
> is back for up to 350 ms.
> 10. data_send_off asserts that something is in the UDP socket queue.
>
> So UDP packets could be enqueued if PSP packets are received between
> steps 4-8.
>
> It seems disabling PSP steering rules isn't as atomic as we thought,
> and sometimes the first echo is discarded by steering. The default TCP
> retransmission timeout is 200 ms so there are no retransmissions in the
> ~150-170 ms between steps 4-8.
>
> With a slightly modified test that directly requests data echoes, the
> test becomes more reliable. Additionally, you need the UDP_NO_CHECK6_RX
> (102) socket options for the ipv6 version, otherwise zero-checksum UDP
> packets are discarded by the stack. I vaguely remember doing this
> change for this test in Jakub's repo a few years ago.
>
> Anyway, here's the diff that makes both tests reliably pass:

Thanks for taking a look. I suppose the timing and 0 udp checksum 
explain why I wasn't seeing any packets. I was concerned that we may 
have entered a state where we were losing some udp packets permanently, 
as opposed to just some transient drops at the time the device is 
reconfigured, but it sounds like that isn't the case. So, I think this 
works ok then.


