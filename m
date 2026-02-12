Return-Path: <linux-rdma+bounces-16787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJepCPPEjWnT6gAAu9opvQ
	(envelope-from <linux-rdma+bounces-16787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 13:17:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30512D5C6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990D8306CEC6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178B357A37;
	Thu, 12 Feb 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiP9VDfq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="acorpGF4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C902329392
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898608; cv=none; b=gzBnk2lPpvQJfL5wkowsc5eBZmcsEoxrsm8XXsK1L+LZmIZfBFgvvuYiuxpwGMXjjoZqA0y3NegaK4fxlgy77tbtQsw6wFKYi4ksFVWkV4CW6WaSu54HIdkTYaHAuezK76q7DWl8htF+yLEZz3fqg4kbhSoVMSDJy4rNRLO/J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898608; c=relaxed/simple;
	bh=JWljiblHKdW/kvLi+oANTy8OmaENQH4T3UWSJZWjvFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+NhdXBqoXLNUSz2aASoA6a8//xd/1ZbqbQ+nCgvz2+YV9RQ7aynp2oVgeYcS/8/8Z02oEQU/ZnvGh0uf+GuyRW7STT+0W7Tz0xH90haYdZQJoKu+h8SvLjg0pr8O2VMcu8MA6y9z+Jf1JAlwRA5dtNjUh6x99re5I0dl9Rknk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiP9VDfq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=acorpGF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
	b=eiP9VDfqbtlvai58YJ3XwBgfuidAfFpKf/EHQo2V1qH1lZs05qvPnHXxKwXYqRNjbT3Fek
	uZykAkq/pUaCRRjdTYUVwgRVuD0nV3ctkUBdKIO5EQE0diB5j+n5r0RI4LXSMUO34OSRyi
	9TtZgXbvP/u/HPDPmg3z14ZpAfV9H0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-uhxvw3n2Mpmj9wWLI4PBEg-1; Thu, 12 Feb 2026 07:16:45 -0500
X-MC-Unique: uhxvw3n2Mpmj9wWLI4PBEg-1
X-Mimecast-MFC-AGG-ID: uhxvw3n2Mpmj9wWLI4PBEg_1770898604
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso39757225e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 04:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770898604; x=1771503404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
        b=acorpGF4kFx8o5/6t6OW4yUJji1mF9Tl9Vmid/46M0+rLwid8Ej469iqO3ijuBwdwK
         I4KdrQyydVq8GvDiKUTj/XYffmtfMj5IgtbtwNLi5+snAprHLtZhaE4loJqrhN9tMN+K
         Mf/bZT2uZi+RcyNmLR1BrMSqnRuj5OqN3QX5UVE/pe9IW3QMG9UtZX7SIg5t6S7HoQph
         VGRoaxwJrGRng4hKiJxEkkCpGUAloNRL1d7sY5g428MD3lIXiquXKGFqQP3RjQcO2Xwn
         AOVR9+xbQj5Nt+XEeqT8PoaWWG1Aric8NtLcOpU3nIFInH5jJ2K87qOPMEp3AabuU/wu
         LteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898604; x=1771503404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ASZtwC4Jr2vY7rfr/wbGtVzwGSZEjBKWQrjrryCwDs=;
        b=NIC7BBl2gbrVJtACF/dv/GFO8I6Fc+VVHg6cW1ll/kM1LZ/gHZnznO+rFaqrGnnQJw
         ZhniOzxaSr1sbjgNh95HjUgZF8bExnyHnYfY+/aRVXc+n8CHEt1ocaCeDwx+7+BfZaii
         n0L10qkSf4eZEE6gk95XNLyah27cvn/cKkW+wlrPxPTRkTHfmTKrDiRW2MgbVEYKa/MK
         HFrSwuLV0H9M+Dy5oLkegpD4yq/xC+aaB4Ui/ng2X9Aj77ruzS729fNWV1Q0O3qt8N25
         a3HTcbFRZq6gcavZLqLoxCnH3vqNdwXB9UykLbteg2X6AucTnDBrzMa/Xi8km5ivq3Ub
         d9kw==
X-Forwarded-Encrypted: i=1; AJvYcCU4sin44TDfNZA9BtNyfgHhb2IQzMHKghpGgFGrmRoGLvK5po321cMkdGEIMYNHmVhQCqTuA2CNpjHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLSGMewqyI67DuHPKALszuNGu/v3Gsg9P3Ruyqau23lKcq8UF
	5Dt7A/jRPJPhUZB8z/zAvI2sHvtRnS8EYtgZfKUsArQcga4SOSZVHMvuYMp37RWPzOxAa8HzcFw
	gj+2wW/5vT+6yikyASLYk8rNS2JdsqodLsHYuFS2s/MrR1OofrgXV+F3H53OvE9g=
X-Gm-Gg: AZuq6aJtjad9JSud25/t3dKxAlxllVVFQA3MGHEs/YKXATsN2IFk1Q3LzTrdVTC9K5n
	9A20hx6U4XTn7HVzTJygwtRjwUTClyDsJh2ASiKT+r4cvLqWyh8d/+PYhZBP/wUa5fHSsvb90aN
	B7n+RbINAz9HGkNQWkIceInF1YjmXj15Le7DQ7qxzYmFCpVcN2YZXdwTVStz2BOTQWHTJLTPXoD
	0DCva3TfZjJMdH7LzJskhYaxxM+ieuMcvI+rtThDrwCCut+urL3tPXq+uVV2uSDGXwXkYoAcIXA
	DTJ1nya6xbnwgcig9ockKIDzpSi+GBtAmM5Q7qZmREJMf7AeUUYX+ZaHg57DZjUwJk4gfFJCQp7
	e0yN5mBXqrAHpjIzKlENmE0IUXg==
X-Received: by 2002:a05:600c:3b12:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-483670fac23mr28141785e9.3.1770898604175;
        Thu, 12 Feb 2026 04:16:44 -0800 (PST)
X-Received: by 2002:a05:600c:3b12:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-483670fac23mr28141325e9.3.1770898603714;
        Thu, 12 Feb 2026 04:16:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm365332535e9.11.2026.02.12.04.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:16:43 -0800 (PST)
Message-ID: <e52a10e2-b208-460c-a3e3-305b91433531@redhat.com>
Date: Thu, 12 Feb 2026 13:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] net/rds: RDS-TCP reconnect and fanout
 improvements
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, allison.henderson@oracle.com
References: <20260212053230.1921241-1-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260212053230.1921241-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16787-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C30512D5C6
X-Rspamd-Action: no action

On 2/12/26 6:32 AM, Allison Henderson wrote:
> This is subset 4 of the larger RDS-TCP patch series I posted last
> Oct.  The greater series aims to correct multiple rds-tcp issues that
> can cause dropped or out of sequence messages.  I've broken it down into
> smaller sets to make reviews more manageable.
> 
> In this set, we address some reconnect issues occurring during connection
> teardowns, and also move connection fanout operations to a background
> worker.
> 
> The entire set can be viewed in the rfc here:
> https://lore.kernel.org/netdev/20251022191715.157755-1-achender@kernel.org/
> 
> Questions, comments, flames appreciated!

I think you could resubmit the first patch for net after that Linus pull
the currently pending MR.

---
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


