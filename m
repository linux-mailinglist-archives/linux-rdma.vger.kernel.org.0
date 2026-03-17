Return-Path: <linux-rdma+bounces-18264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FO/ChRquWmZDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:49:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5012AC51F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D22B31ACD7E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49873EC2CA;
	Tue, 17 Mar 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUWH8JN1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG0++1L1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BF3EBF32
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758472; cv=none; b=VmMhHg2IcTju9Q1OV6eaOLBZITXSJws7T09iFEQYvgC+DAtIBFi0JPqDDc7QN9px6OsOF8LUbQBYAT9hdLKj7pLnNQ7N/H98PuBODJNSPmkeJ6erZ/cOl1AfxABjpXqchqMYavu1qk4BNcff9dtnDLa19WavKH7+CXbmjU5/178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758472; c=relaxed/simple;
	bh=Xec3Bnqs8cOPFzLKCllX85qxRCNRZ4+RoA71Mx5laDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl+bU9vTF5MVBIiFcsBdLycQWvCwasHdW2TKR5tGzAYdwJfbqMqwwPU9WCBVxa05jDqDZtKj3qYrLYN7yI1uJCKd8vO28S1g0ask8FUibayoYaDf0ia7OcLkOLQLprUiw7TKKk+67dkNM5m3GO8oC0uj+WzzRsOEEtbna/F9278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUWH8JN1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG0++1L1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773758470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqu0XWMuuVA5H9z7yGNPz2Wm4cgx+SYtal3EMhGWndY=;
	b=cUWH8JN1rcYk3Mv/vkJl8Ew2rumC7fLlAZbMCs1+CDlfoQZCH0HBUGBByOQe232+6FoaPV
	/VD6QVGlo4d3pAGzp8UBVCE3Is4WI6wLRM+wp+janFg6R2L8BVGg38GIvzY271AWFFI9ht
	0gT0/RfmkPJZbAgWzbg41o7bpO5cYbQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-cVRlHho2M9i_8vAECLiTHw-1; Tue, 17 Mar 2026 10:41:09 -0400
X-MC-Unique: cVRlHho2M9i_8vAECLiTHw-1
X-Mimecast-MFC-AGG-ID: cVRlHho2M9i_8vAECLiTHw_1773758468
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485375aa56eso42266885e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773758468; x=1774363268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oqu0XWMuuVA5H9z7yGNPz2Wm4cgx+SYtal3EMhGWndY=;
        b=WG0++1L1eJ+K+WollAoxNY0IvNCOkHl8MTu5IUk2XEXne0hF+bhL0zlZAsloN5//sJ
         aR8i/KD8c/pbmwNMymLN/pIIjdY9Mg/A5riYsUTRPBnGKQ3N2xqgpQ/iQW/NHBnEuvum
         MHxRe3kNV2PE47ZV7MU8G4SyRk7DQGmKftWuYRLcVPo6KjhdowfO6HrvZxEq0XL3ZDX0
         gbAqDWbbjBkETbeleliXwNVwNe2GERGbDB8IHAAdm2p+aveqSwZ22NzijIsXLY3+e0qE
         3VS6j/AdV/Ps08Ztt+zoYMj1wu6GheW9S3Ss3oVU51vA3Fg2G0B93ivEDPq8aGRH6v3Q
         Ts0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758468; x=1774363268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oqu0XWMuuVA5H9z7yGNPz2Wm4cgx+SYtal3EMhGWndY=;
        b=jNndx48oxlXF9rQl3q8IeZQmN7tKc5JOpWbNoFdfM15IkUIMGRcN33qVSclKD8IFJX
         nn3wjHyP5bAzjhylWMUBtM7I50vTvQgvUPDAiv4uN1S/ue7ZbCAQf+iyub6CZQvCoRxM
         Lz9fOPU54C/ziAtmKlbs+Pn62XFFj43ap2cJgRG6qIEAAzb2I1qX+zn5WVpK/kbPyt7F
         aPZCa4euwGsST1SaECprP//1HH1D3wAx5mZ9Sr2MaLIL0mm7QAi+z455JiMDe0HpyRDM
         izFK5RjWUOXOxIzhLDn6DhnDmiYWL7oDZ7IMlz8r+Ohg7Vf+is2wArDTXAtMkloFZKO7
         xKtg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKfMKZULxykx3Dl4hW4px9FPpaqFcs5sGk1ZLmLSavoLxkK6/q76A4Xep8LpKjibZKlVMfS1Hg7p0@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtA/PdnzAADdz/8l0JFjcFP9149O5jLq6dphAB0+D9HvJ8Vcg
	ep5aS7YHrXkG/EykH/SMzpqKgVLxGasNkfNm79Uh8u4IfxQPYOqxlfwB5v0eQ1ONm7jc1rPIJqY
	37wfO9Kz/3rgeb8Xsm/b1d2e4SYbiLRCfCup4DgidxlSTZiwnLVXzSqOZNgt6rBA=
X-Gm-Gg: ATEYQzwaaHb3pb/wtI1K0b6n/VNV3/OiUQCSblGKKuYxGKYdjM47fIprE0SxJBOH+rZ
	NMKQVBF6jW6MxRLh6fHjWI/v8yPDKc0W/Z/k3XCHw7VaN6UQRG0gr5bE+1iqDTwCxDGkA8Nyzi8
	X+evBWEsQ0RqXO/LtqSCtpYopiohGOezXi02q/IevA2NiT89+zFfczepDrUM9Q3KItWf54OY1cD
	NPO437K1AySgKtXgJaVgP+G3ZpwYtT44JhRl5hclDEVS5rNbqnd6k7uVhVpJ2hAWJ59Dnnm2zjF
	MmUmcF1n7sI0I92joWD6/bKVmff4/svtKgtmKhUETZ7IPFGH3vjgmYK1nead7RsWEa0MNvPTf/Z
	NOjfI+Ooz8n7TABcpZW/UdlHhh+4Xp1UmFBOaWoxe3qO/+mdwN5nkvbs=
X-Received: by 2002:a05:600c:35cd:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-485ae14864fmr48934225e9.5.1773758467689;
        Tue, 17 Mar 2026 07:41:07 -0700 (PDT)
X-Received: by 2002:a05:600c:35cd:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-485ae14864fmr48933695e9.5.1773758467265;
        Tue, 17 Mar 2026 07:41:07 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186e3sm57258205f8f.26.2026.03.17.07.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:41:06 -0700 (PDT)
Message-ID: <728fc0aa-4c07-4092-91bb-6b9f76c2f3eb@redhat.com>
Date: Tue, 17 Mar 2026 15:41:05 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] selftest: rds: add
 tools/testing/selftests/net/rds/config
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, shuah@kernel.org, allison.henderson@oracle.com
References: <20260316235848.2395654-1-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260316235848.2395654-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18264-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB5012AC51F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:58 AM, Allison Henderson wrote:
> This patch adds an rds selftest config.  

Why? what improvement produces or what issues does that address?

> diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
> new file mode 100644
> index 000000000000..103f9d941d10
> --- /dev/null
> +++ b/tools/testing/selftests/net/rds/config
> @@ -0,0 +1,5 @@
> +CONFIG_RDS=y
> +CONFIG_RDS_TCP=y
> +CONFIG_NET_NS=y
> +CONFIG_VETH=y
> +CONFIG_NET_SCH_NETEM=y
> diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
> index 791c8dbe1095..7cf56ee8882f 100755
> --- a/tools/testing/selftests/net/rds/config.sh
> +++ b/tools/testing/selftests/net/rds/config.sh
> @@ -24,7 +24,7 @@ while getopts "g" opt; do
>    esac
>  done
>  
> -CONF_FILE="tools/testing/selftests/net/config"
> +CONF_FILE="tools/testing/selftests/net/rds/config"
>  
>  # no modules
>  scripts/config --file "$CONF_FILE" --disable CONFIG_MODULES

This looks wrong?!? The script is going to update the config file which
is under git control. You probably want to copy the default config in a
tmp file file, edit the latter and add it to .gitignore and EXTRA_CLEAN.

The issue looks pre-existent, but since you are touching this part...

/P



