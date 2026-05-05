Return-Path: <linux-rdma+bounces-20012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFIJOCrz+WmcFQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:39:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6A4CEA88
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD335305C8D0
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906A342C9E;
	Tue,  5 May 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpwwthMA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YospqjKt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7882D5941
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987938; cv=none; b=aWaDdujCmAwJaeW7by3z+b35wrmiWDgREHtroc3XV4SKWtKl/5w/10JVmpT717Oneu1dJEMLlvWgc9bP9ZosooKSTT8IubFs+oe9mM/OoyHEnznb0bg83hNflN1NrAbzUXOa5Eb6l2STsKMYj9eh/8oKkXvrRMpt7LK77Vq9wZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987938; c=relaxed/simple;
	bh=0s89vfwi9u2GmyoZr12XQ/VmH/dxXgL1PDXgs/5ffAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1fcTkQi2DXY0i+IMO+k4WPv5BElvTSkm5fI4Q9KBHA0EXp/X5RfjpAsLyWkL2MVi0kZdDIVS5twQRaXj0tv9N7Hd9R5+4SCnfwJ3c9W+9DcqIGtIvI9b5aZtSDOyCF+zwNRBuHkJv4sqMdU9Zrz8LI76rMSHK45sPbApcHx/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpwwthMA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YospqjKt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777987935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
	b=OpwwthMAVx1XKALzLcI8sfcUxfa+pVDagaZee6A7sh5vyyAmjsm4N+WiMO6bFhwPyI5pqr
	14m5yfZDHNyfEnvtMRi0UUrHlbhq5KeCX91/qJA/mjMX0UMcoxyeC1Jm2+11ZP9ggKFCVd
	ovtvpMW99Wmf9RcG+kNXHxhAY8qxDvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-pZLKTQqoMBaG84v2wAU6-w-1; Tue, 05 May 2026 09:32:13 -0400
X-MC-Unique: pZLKTQqoMBaG84v2wAU6-w-1
X-Mimecast-MFC-AGG-ID: pZLKTQqoMBaG84v2wAU6-w_1777987933
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so33314425e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777987932; x=1778592732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
        b=YospqjKtBoSuN8XM6UboXywz5TnUJtC+tg8PyBxGViW2pAKrMAqoHiLuLfJ0tyM2E4
         6bASS1/1k99IJAsKdMfoUqIUKfjHMAR/XjAA+UBW5VFY3T2nAW54RIvq5q4gJnDfYA7r
         oTHANx8lEpdSoMeDWOtA+DxLIdwViCluMiRpZr3aQsgdXN4ls4SOADsC2OyWyyoFRgPY
         aQijhu0EYhGpStfL6qo3H7MkFzF2pCkmcaFFBpPuaeDWnfy4RiSJM5nnLbOeZkTMPFSR
         LKc8vzsSu5YQN9U/4FW70bFp4wfaJCOEf0qalgapJiAe/CPvFgPLQj8oQKzGgFyuB+dG
         dpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987932; x=1778592732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
        b=DaUsgvIasY9VcQeuS08/trnXjn3BK616R1hJNDwO9Q0SyOrUqIN67xqobLU7kq3E9z
         24BNmemTKCVCCbpLgq3U2Cf4X8lkkZIIDMN6+bPmvlyMyvm+d0//K2ECKvFw8Dr/IX0g
         Kt5hEGfJfXTpPxD6ODDq+SdKwaehtyDXzGQqhKExzmAyPPREJL2SaaxGcbYal9lx67YM
         3OFHOq0CO2dkedd8DLdyekPjDTEhsK8UG/P2S8VIP1cXV02ABA/SkxdF4A/hdHmFPjjv
         PQ4eEbfWmyHxpqYRR3Q50sKYNXGmz7429SBSseH8FJXLJWxH0LdVC7Sqdr/FMUfeWko5
         EjCw==
X-Forwarded-Encrypted: i=1; AFNElJ/eco9RtblmY3EM00U3E9IpR3/gTiMhyKXSgxeGNFA2Pusji8g8Wa23Auo6nsxULAA5JzRoprvDTDM4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXyf8atCQWH6QXR7j9dRRrSYYvs3wbmPJrfKrbhTMNRwWrUo7
	dLEsvnHQ92nG1Q6n4ADdmpY0giMB+xJIx6GfsPdMECZn34q6j9TYT9TMB1yjavt5D8LNUhw1bRf
	i8aVkHPSMtaFx0mI2y0HYCHfjK6WRL4t0v65dw9gSlq0nT3LjAR279byWh1UZ8uY=
X-Gm-Gg: AeBDiev71LMfGVTNsOjoNcdd9CF3jITxGDHlkdW1p46MRJK1nb5kV5Df9SBLOlPqJjW
	4naetWhWtLCY4xpjMhVww234zssWEnq+AOC4EPdn2BnqAN36PqvhcAxWxPsphHVqSPQfLE83k3B
	cU7AASYqevkiWkVnAhncgbKwin3QQ5zXvviZgSX1UmCS+ALsfZYdp4bhjSCnTIFJMUisPn4PbdT
	O9uToOnp1yRhxz3BWIJpHHEd7OmCYQRQ79Nzte32YdQBcWBepxbdP1bT9gyMexx1I4sZYqP6+1P
	OttqMP21261vvRlrB0kxvUOLfuLdtVk7w+UM48UA7TDW7Sw0Ea2E/nngo0wvKOYsJ12tXNODg0y
	5uFKDV5xW3gAZIOYSdYB0UWHXHZXcnL1qew+MKt2JNbGPvILSLHii
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48a98638cebmr245847155e9.10.1777987932495;
        Tue, 05 May 2026 06:32:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48a98638cebmr245846325e9.10.1777987931898;
        Tue, 05 May 2026 06:32:11 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm628732505e9.9.2026.05.05.06.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:32:11 -0700 (PDT)
Message-ID: <673288e7-37ac-4533-a4d3-2fa87dc282f1@redhat.com>
Date: Tue, 5 May 2026 15:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before the
 message is queued
To: Allison Henderson <achender@kernel.org>, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, santosh.shilimkar@oracle.com, sowmini.varadhan@oracle.com,
 willemb@google.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, lx24@stu.ynu.edu.cn,
 tonanli66@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
References: <cover.1777550074.git.tonanli66@gmail.com>
 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
 <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28A6A4CEA88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20012-lists,linux-rdma=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.660];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]

On 5/1/26 9:40 PM, Allison Henderson wrote:
> On Fri, 2026-05-01 at 09:08 +0800, Ren Wei wrote:
>> From: Nan Li <tonanli66@gmail.com>
>>
>> A zerocopy send can fail after user pages have been pinned but before
>> the message is attached to the sending socket.
>>
>> The purge path currently infers zerocopy state from rm->m_rs, so an
>> unqueued message can be cleaned up as if it owned normal payload pages.
>> However, zerocopy ownership is really determined by the presence of
>> op_mmp_znotifier, regardless of whether the message has reached the
>> socket queue.
>>
>> Capture op_mmp_znotifier up front in rds_message_purge() and use it as
>> the cleanup discriminator. If the message is already associated with a
>> socket, keep the existing completion path. Otherwise, drop the pinned
>> page accounting directly and release the notifier before putting the
>> payload pages.
>>
>> This keeps early send failure cleanup consistent with the zerocopy
>> lifetime rules without changing the normal queued completion path.
>>
>> Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> This fix looks fine to me.  Thanks Ren Wei!
> Reviewed-by: Allison Henderson <achender@kernel.org>

Note that sashiko spotted more pre-existing problems in this area,
please have a look:

https://sashiko.dev/#/patchset/d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66%40gmail.com

/P


