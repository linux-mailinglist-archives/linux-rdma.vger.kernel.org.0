Return-Path: <linux-rdma+bounces-20014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANOFHwj0+WkOFgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:43:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E404CEBA4
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C923058898
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3047DD63;
	Tue,  5 May 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIe1m+7n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiYgCUaa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700937F8A5
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988578; cv=none; b=fT39S+IvmZiTQMq16tanZcOXbqmVLgqXc6yJKhM5yPUd5PmDnSrboNF6j+rbIYOiaGINdqtD4CuCvEua7i73ldawiiZXJQMt4g2jQs0Db9ytSYOxolPWt4xBCb88WH/W7tp9xORcxVT5lXKSUEKaPJ28BBbAHm/tq2QHEKHRKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988578; c=relaxed/simple;
	bh=KoGS6aWgQmyghW2+RcilZE/a4UalTY9FWST44iSCrmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cfApXyQE4p/PEf/n9VRwnTQ3yFf1TK2i2YZTE9/YZTJstu4YFS8/KPG/0fuqSFhDeYd83wfjitbM9/zhd2VnzK8enBrGOox2Sz1if6nkuG6ropGViR9TlQ4vufFNZ9KU71NEbGK57s9G+IdodWZwMs1lSE2lpmNNLdqFAfm8Vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIe1m+7n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiYgCUaa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777988576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
	b=iIe1m+7nX/dYHzEQJ4/Li1qp3kxTZzFjmOGp43F6+vcZV+tTqpkiRPLl/jep4zVDHEtyFa
	hHzJvWbItmH3qPHPon81OnuEQH4Uu9frKk4VpypKT+xzbXrQHZLAoaOjRL5UfE/uf7/9QZ
	B47evGGNrWn69QN0w1ZSxV3Ylj3/G5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-6uETd2jzMLSUOEJhWN3Krg-1; Tue, 05 May 2026 09:42:55 -0400
X-MC-Unique: 6uETd2jzMLSUOEJhWN3Krg-1
X-Mimecast-MFC-AGG-ID: 6uETd2jzMLSUOEJhWN3Krg_1777988573
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso37547535e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777988573; x=1778593373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=XiYgCUaamZm6WTSI43K90aaOEBA5Nx5HVT+DagaNvt4YXFGrM8PC/hruoust7T0UOh
         /JjptZ6ZEWwSE/YaFAa1nL2d++YeXMdcGUapz/E9Nj6ERAP4LeEBEb/BwxZlhLRMjPnM
         RjSYKiQycZbwL/Sm4Aqbs7A8LZi+XRKYp4rKVh8Hqp0cWeiAbOyla7MiRj8r9A2U2ZEO
         gUf4q4fcD0EEwWP++lGtlMPSDvksWAM77zE6Pf5pmJyQLfX6AX9uoMLg1tBSDninDQNc
         JKr+HKgQaDzGm+rYUt3n73FIInQIqZbZMAcuckIrFPHYxUbV5SMqfPzbnf3YLzQcOCZd
         Ol+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988573; x=1778593373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=icGYoLSP/uiExlEdW/S/LW5mXEmfH0PyDcRmOlM2hpKB83+9BPtvkfRqdiEv86g5+k
         tukLsxIMSTZx4Rjj8AcJe3++wCn5HBMTOboYfmAORz4ppECLOPRPR57Mgq3tqIHRx7eg
         0b3LLapsWXs+Qj+IN2jCjAqjoFCdjAjuiLrcVULVRxcc3vtsKlXao4xxqE7OURKiUOvQ
         sSKrwYrdy2vDjFFkY+8Gu6rfJI1P+XvXapBsdzvYDcVtnHjp6PI368tkUMiXuIFW+yCT
         5GYawyLEs6TccNrd03SsO+i4RVP3SJbEZkHHODR2fGEM979N5j/irmUk/9b8XcfKBJVv
         gGkA==
X-Forwarded-Encrypted: i=1; AFNElJ/8nGAeOdQFTKk2vNYicW9mpYjJPuW04GYJgs/5x6QZGXIQHYmBr8ZNO/6MsPsVm71y7ow/r5xJXe2O@vger.kernel.org
X-Gm-Message-State: AOJu0Ywov3+tIKWSy4yklGJ0UyRoJoSjQMBH0ki4MItfde9YDoHUBFGv
	fDC5HzrEiW44JtOJ/vAlvzrhD75IhVt5+dsAzuWirulNY0d5XKOpYHpHM17jXSJUaPUxRM6cczN
	3EpH5MJhnpaN/QXsi0zFGqoG1IMJfeFweJRaAPhmpXw9nx3dBjo6crsCo6+anQ3M=
X-Gm-Gg: AeBDievo+RaAfdvLwtzE0dhIJvp/rdVBeMDghTk7nyJKOyhZdJRProu4E+z48cVdziz
	k9DC5m4VRxbK3j06LIqTj36fcb9jMUYAJIHnqdXBAtOlnsVsqWjMTE1sMGFE8AGJ/BK5YClez2h
	IwGHp+GisqXieldySORQHGudWwDW8EtiqYiODuI2Qqy01qzu6TN714riGHjnG9VYQsu3LSw8Ntd
	+EZ5k9LwafVXgZwdNskXS8QBlpdUzUyrlDG0UwvbIDsZIX2VCyf2qzeIh2SjHTUzw9R+WjYfYqA
	JxNQCLkrNkPxrLJi0u2A4YBJ0FJjqLEl7LnIIAa+x+IotPwxosFQ+j3o04NlTg/uEy9i2scDPKd
	+L9ViJEoP48Qq8Xr2voxHDlKaccaW2z1UmhmTPJMqgjn5KuoiRf7jeSdnWdjnMxIsFFc=
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36490325e9.21.1777988573100;
        Tue, 05 May 2026 06:42:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36489575e9.21.1777988572565;
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149d49acsm30503175e9.1.2026.05.05.06.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Message-ID: <30f588ad-cf80-432b-bde3-13b3c0d5a124@redhat.com>
Date: Tue, 5 May 2026 15:42:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net, v3] net: mana: Fix crash from unvalidated SHM offset
 read from BAR0 during FLR
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com
References: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 05E404CEBA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20014-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/1/26 4:47 AM, Dipayaan Roy wrote:
> @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    gc->bar0_size - sriov_base_off <
> +		GDMA_PF_REG_SHM_OFF + sizeof(u64) ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u64))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

I think that the additional fix suggested by sashiko is really worthy,
but should go in a separate patch. @Dipayaan: please follow-up on that
one, thanks!

Paolo


