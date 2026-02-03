Return-Path: <linux-rdma+bounces-16445-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFrlMyzLgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16445-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:17:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A10D771B
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0C6130093B8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8D314B62;
	Tue,  3 Feb 2026 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGuhu8HX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZorrZ5s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E33009DA
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113818; cv=none; b=WxmMDNAc/cEUjRyVCBn6uJpRb6SAsJxo+pp7xhCr1WxoJ7Ls+Mk1mqSe+ksJccincOVzxD2MaCcr1RrKP9gqxpcWcjAu3IhYhe34VxhQgTEPJaWLnHjPa+pOMAy/y+U/D2Pik7fGA2g3vjuTHSlO6LdNhCsx3vKsj5uxZoc207s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113818; c=relaxed/simple;
	bh=zzrjZPXfYdNR5ur4+DAFLb38Y57K+9PEFWBPSbmtPds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d64FFuZeweyeR5E9QDnV1GDh4Xog4eoch3BdBmTB7jmING5jl/PH7OqOLHV6RlIUWv943XHYMQE3tVdr9DKRTpvp54oBLEKz8YGqZJHFDtBaUTxgd9VMAfzxYBGv63Dijc5mAQ/kn1MChTVYjFnS71N5TdnHJhCSWU2e6GZYdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGuhu8HX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZorrZ5s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770113814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
	b=MGuhu8HXuyG6Z429aoDjYzvFlU1JTzTGQ5uoHjFD7doV7TiRmvGV2u4P5hGhAWlf2+a9oc
	8FJ0nmHLsT9v7FoXtQkKqxT+kK9MZdaGvWF660JPvtAh4Uh/5vMqR88FzqzhpkWED2Lq7/
	A9PpLxPMmRYTFW1b6ZG/SiW6SG1H9i0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-TXuOO-atPAGj_wjr5c7l9g-1; Tue, 03 Feb 2026 05:16:52 -0500
X-MC-Unique: TXuOO-atPAGj_wjr5c7l9g-1
X-Mimecast-MFC-AGG-ID: TXuOO-atPAGj_wjr5c7l9g_1770113811
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435aadfaf4eso3413317f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 02:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770113811; x=1770718611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
        b=WZorrZ5sXghZyCstwYDVxGn/NNSD+stCSM7fCSmT+ZCg4OQJRIFql2rrnL55Xdj70H
         VAvxlw9E41FKVBWb0J/r37OCzbc2HUiK2h+q66/bvPUOG99Qca5voqbe+4qDFXhqyco0
         tgfEeLadXSpjD4fE3z49eoruA4VKz/hUM8ZdAzRP3EexmewG9SdZfLcagMs0TA+zY3cO
         UFwr84jXbM9Y+4MBpzS08yLeepq/8Nf7lpm1D2yFC43FlUiRjqbbH8QUutSqCdGc+jZD
         kPsxrxxtyCAfszKZRBksDTASbfFLxH/CxFYBRHzdkeSrRAVTUQn9yb/2vThgJgYKQwkq
         cPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113811; x=1770718611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
        b=LJz8jswIo8KTyafz/J0soLZLm4JdHXZvhY6mKrFyrwHTvNo7ZIHMKcoLQsYVrg75gD
         EALZQsu/4mqAvwgXdYhb/6BguqPjehou2eR5G0QBSc25CeFjXPrn0vofbXE5U/Opa5WD
         48Pdr2wQVHIOTwQtpMffgGQCmDsO9I5e6sUZAydq5sJ+BupFf0Xkg4vN8SaAXA7Rrw6E
         TAD4bi/d+ZkYJcjGMkbskVgJpPRDg5BsFvQtRA5Ys/PorHFLDHTdqB3cUnfDKuR7Jquy
         to0PVzaI74kpD7982WrMZNdYiTmSXe30Q3WRwYO8Pqk7OqTU3DRh0F37CKLXh4Q4IeT8
         n3fg==
X-Forwarded-Encrypted: i=1; AJvYcCUE17xcKyRBDfzDZKcDhCGSOxktDGfAWOSgo48T/PcdlGQTdmrGMgvS6zJsCRBZLNtkFush7fBA9rF1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zGozaG/6Bfu81c3HNmJOu76GuEiszNWuyeslkuZ4K/quQsd2
	nEOQjLmBJ6/MfxXgWOzW528Dg3WfyTcHHUoDI02QWvUwfeFbxJ+5QyfPjKjsv+PSNdEAbBxl09T
	Qtu1v6JSpPBZT0ovuybXrFnrB91V9Qmthu/vo/u1i605vDFI9nX6AYlo4/mj0wFI=
X-Gm-Gg: AZuq6aIh8Ts+HUqju/rvuPHLTHvEd/c3L3TydLD86GxubvybT6CtE0Oo5HGe7vDdhFc
	BAR1E0u3s70WmXeKT4oVdulygiGML09J7v6ALbNRAkPRXubH2NdTOzwDQv2HqeJH9sosGCNHqPA
	WGl/kogATpwM/Mhv0OeHn34CPbMIYjpQhWzKrpz0G08+6UvoR2UKuQUNift0cx9KZHqCq/eho3d
	UspLocUhkqW6Dzki7yrpXEDyXItRsJXeup7j7wRcsu13Kb63QngK9/NmW70zLULYHEfY8FDXRP+
	aKhF2crzelLedEyeBFRc3onXbxN95lxkaJs8IeV8IwAOjxnqUhnOAvoOsxSMm+1mvqB+3F15TR0
	+ulukLql35m4=
X-Received: by 2002:a05:6000:1862:b0:435:729b:c390 with SMTP id ffacd0b85a97d-435f3abb192mr22523240f8f.47.1770113811384;
        Tue, 03 Feb 2026 02:16:51 -0800 (PST)
X-Received: by 2002:a05:6000:1862:b0:435:729b:c390 with SMTP id ffacd0b85a97d-435f3abb192mr22523181f8f.47.1770113810888;
        Tue, 03 Feb 2026 02:16:50 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm48741670f8f.17.2026.02.03.02.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:16:50 -0800 (PST)
Message-ID: <ce09e17d-2b74-4bda-a8ec-352c92659a6e@redhat.com>
Date: Tue, 3 Feb 2026 11:16:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] selftest: netdevsim: Add devlink port
 resource test
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-5-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203071033.1709445-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16445-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 07A10D771B
X-Rspamd-Action: no action

On 2/3/26 8:10 AM, Tariq Toukan wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Add selftest to verify port-level resource functionality using netdevsim.
> 
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../drivers/net/netdevsim/devlink.sh          | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> index 1b529ccaf050..674f0e981ab0 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> @@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
>  
>  ALL_TESTS="fw_flash_test params_test  \
>  	   params_default_test regions_test reload_test \
> -	   netns_reload_test resource_test dev_info_test \
> +	   netns_reload_test resource_test port_resource_test dev_info_test \
>  	   empty_reporter_test dummy_reporter_test rate_test"
>  NUM_NETIFS=0
>  source $lib_dir/lib.sh
> @@ -856,6 +856,36 @@ rate_test()
>  	log_test "rate test"
>  }
>  
> +port_resource_test()
> +{
> +	RET=0
> +
> +	local first_port="${DL_HANDLE}/0"
> +	local name
> +	local size
> +
> +	devlink port resource show "$first_port" > /dev/null 2>&1
> +	check_err $? "Failed to show port resource for $first_port"
> +
> +	name=$(cmd_jq "devlink port resource show $first_port -j" \
> +		      ".[][][].name")
> +	[ "$name" == "max_sfs" ]
> +	check_err $? "Unexpected resource name $name (expected max_sfs)"
> +
> +	size=$(cmd_jq "devlink port resource show $first_port -j" \
> +		      ".[][][].size")
> +	[ "$size" == "20" ]
> +	check_err $? "Unexpected resource size $size (expected 20)"
> +
> +	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
> +	check_err $? "Failed to show port resources for $DL_HANDLE"
> +
> +	devlink port resource show > /dev/null 2>&1
> +	check_err $? "Failed to dump all port resources"
> +
> +	log_test "port resource test"
> +}
> +
>  setup_prepare()
>  {
>  	modprobe netdevsim

This test is failing in NIPA (adding some more context beyond the
failing test output just in case it may help):

# Error: netdevsim: Exceeded number of supported fib entries.
# Error: netdevsim: Exceeded number of supported fib entries.
# kernel answers: Operation not permitted
# TEST: resource test                                                 [ OK ]
# Command "resource" not found
# Command "resource" not found
# TEST: port resource test                                            [FAIL]
# Failed to show port resource for netdevsim/netdevsim10/0
# TEST: dev_info test                                                 [ OK ]
# TEST: empty reporter test                                           [ OK ]
# kernel answers: Success
# kernel answers: Success
# ./devlink.sh: line 614: echo: write error: Invalid argument
# Error: netdevsim: User setup the recover to fail for testing purposes.

/P


