Return-Path: <linux-rdma+bounces-18941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B6YGikwzmnIlQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 11:00:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522F38665A
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 883AC3057316
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE243C73C0;
	Thu,  2 Apr 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGgNpv97";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfJKtm+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2C1C861A
	for <linux-rdma@vger.kernel.org>; Thu,  2 Apr 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120091; cv=none; b=iViUMB4ghDq0mIusaG8H1mSZvJaF0J8AycgDSdMRUmlPP95LVT2ikmvMS9lermuUX6QjfavcRcapCKMkF546gJXcYjQwYIJy6YomeUtWgA5nV9IRH6Ifdp+e3hnk2xO+uUbIPwhgHs4DWAyxssOT5RLQ39ceQ7CB0mmQCd7aCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120091; c=relaxed/simple;
	bh=TmXtfrkVEQnquTCvxTkGtndXJ71C/6/lm3RkiXKS5DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HccbyF4QZnplhT25ghNWGpa2EMQD3WWdGp1ZWUrJuoaUqYi6zrkzsy3pME5a6Ka4W81DuOA73LDS6sAJrJ3x9OmE00aZNe78YjPjbzTeFgYH0MFn/21zZ/gkspQR3zZV2ZFjLZqDxuFTLalMhcgSyeeEWqOAppOlUwJnOnpmdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGgNpv97; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfJKtm+b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775120087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
	b=UGgNpv97e7xwCY4irYpGBhtn16AUow/R1LaN/jkGA/vKlCiTOd+KdXWq3YM5rUHrbW8C+t
	bFiiqSWySsB9lOEJ+Yab66hQdiiTb4PNa4o72iKIKVczohPhCNzeAqeQ54ee89lKYE2HM5
	aJJUtXGOZQPFykjZ7Wskw+RU7Bo1uzY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-bBUykWcONUqA1AhUq7K7Dg-1; Thu, 02 Apr 2026 04:54:46 -0400
X-MC-Unique: bBUykWcONUqA1AhUq7K7Dg-1
X-Mimecast-MFC-AGG-ID: bBUykWcONUqA1AhUq7K7Dg_1775120085
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b9b8e3af6so531696f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2026 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775120085; x=1775724885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
        b=DfJKtm+b5gXvZbryMu8d+RW47uvvbYOzIAxitd8pyD0Js9czDTQfn0upguTpz69UXN
         c59c0xrvSSIOJapp2rQqkwbAIYAv3m/zwYAq6mrpCXbxaUbYdju0u7L+0LhGPQq5jK+s
         GYQtqVtGhml2nD9kSqcK9aXV07rIXdEL6LU+WbPAc1kFw5usjLjsyh5QmYzFH+jyX3mm
         fEwzLHhjNp/XLu2XfgpRb1tk0KNaZMEqJi4GIMkxxkQxZTJcZ0ZEixLzts1/SvOha/iX
         nwSHD7rAX6tDiBi/c6kUur+Tuh5wZfvuHQrAqjhvIPtpV5oQe1e+CndLw3J3M1i53v+9
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120085; x=1775724885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
        b=ev4ObO9S7MpMNtar/+KKhu6NAA1xRSWP9EpC6qQlweNq/hZJBWHvW8xRBV1WzXGfRC
         /+iuX8n36JwRlk+BmZgkRQpLs7Cj60DiyiSmX5iiV2v/JBJKTXlCAz/CqNEoS85fvaIu
         217RZJlYzKL9f3njX3pUHNeAw6mOqS2TpFTp7pBT902e7gWIKoeHkTUaRfmVAoBoCOi1
         rk4N63EIQVp8sx5UdT8IavB2iQgi/MTsVEHAWSqTaT+8u1svpgp3RMSbElYep5//ZGpI
         9rPhkbrBC2Hnf4DSSa/h0hfLEWynslyNL2PcA2WMRTecHp0DLOBDgjMoPil0vuyxnZtZ
         1/MA==
X-Forwarded-Encrypted: i=1; AJvYcCW28geSTdgra+Sn6fcNlzdlDL/bkdyZlBNttfu1IA6NW+fGvoq8JOf5Flr0acl1ihDAYbyAP/TRDMfN@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDq4hKBj+lgxL3Yn99XtzKYEc0vVRXfTGXeDQWH/RVlj/UT1D
	OR2wVVgGZ0NBjwTOfzk6GyNXcjJJxqniuJ5u/yUNYYrSHTaas9EzXseZ3CFk32fsU7txFYE+FB2
	rJHnNR2LsEdEOES4HBU9Ln5MkaT1jaG/tnezn86OlAx83BsAx/n81uSm4xZq9WvI=
X-Gm-Gg: ATEYQzzGgUsU55qlGZUNmX9ERYVNKimbpTeWcKz/sV1i+Sb50FRGq0BgHd1vhccTrwH
	3c7CHmGq+IL1qOUJm4NPZJd1kIeD085r+DZnEeawaeuRvbJAuzQn3LrIY8KzyjgbVoXOSOWoOf6
	ZJ4PVQMZkpI273dxvW8fk4G4dViPybTN82EMB/AgF3ARqJL6kXU8czLibtjak1eS8dqT6YO4d65
	4sz9ZSM/z+5feIJjiqM26mJPC9mK7YK9SeODqxmAuYe3fd3OqxaQ8oxc++7dZ4cVYdTufKu4QLn
	PkTxm/qWY/nC7He/yUJe/1fF0lyYjq46y+W02iyhlZ64ISP1wKFbGfMXucrkDfHU+xxMJzuWoJX
	t6uz9+lUKGp/GnzPREh8Oz1Kyqwk+TlVIetBlhAwGXY9t4FcAGQyJ1FYAqQ==
X-Received: by 2002:a05:600c:1d16:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4888359d2afmr115404935e9.28.1775120085100;
        Thu, 02 Apr 2026 01:54:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4888359d2afmr115404265e9.28.1775120084622;
        Thu, 02 Apr 2026 01:54:44 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93cf2dsm162267625e9.11.2026.04.02.01.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:54:44 -0700 (PDT)
Message-ID: <ac20d8bc-4af5-4338-adc3-01e4aac4e70e@redhat.com>
Date: Thu, 2 Apr 2026 10:54:42 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 6/6] octeontx2-af: npc: Support for custom KPU
 profile from filesystem
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, donald.hunter@gmail.com,
 horms@kernel.org, jiri@resnulli.us, chuck.lever@oracle.com,
 matttbe@kernel.org, cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com
References: <20260330053105.2722453-1-rkannoth@marvell.com>
 <20260330053105.2722453-7-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330053105.2722453-7-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-18941-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 5522F38665A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 7:31 AM, Ratheesh Kannoth wrote:
> @@ -1635,9 +1651,9 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
>  	}
>  
>  	/* Verify if profile fits the HW */
> -	if (fw->kpus > profile->kpus) {
> -		dev_warn(rvu->dev, "Not enough KPUs: %d > %ld\n", fw->kpus,
> -			 profile->kpus);
> +	if (fw->kpus > rvu->hw->npc_kpus) {
> +		dev_warn(rvu->dev, "Not enough KPUs: %d > %d\n", fw->kpus,
> +			 rvu->hw->npc_kpus);
>  		return -EINVAL;
>  	}

AI review says:

---
The bounds check was changed from profile->kpus (which equals
ARRAY_SIZE(npc_kpu_profiles) = 16) to rvu->hw->npc_kpus (a 5-bit
hardware field, max value 31). Can this cause an out-of-bounds write?

In the subsequent loop at lines 1658-1685 (visible earlier in the
function), the code writes to profile->kpu[kpu].cam[entry] and
profile->kpu[kpu].action[entry], where profile->kpu points to the static
global npc_kpu_profiles[] array that has exactly 16 elements.

If cn20k hardware reports npc_kpus > 16 and the firmware provides
fw->kpus > 16, the new check passes but the loop iterates beyond the
array bounds, corrupting adjacent memory.
---

Also there are several remarks for sashiko, some of them looks valid:

https://sashiko.dev/#/patchset/20260330053105.2722453-1-rkannoth%40marvell.com

please a look.

Thanks,

Paolo


