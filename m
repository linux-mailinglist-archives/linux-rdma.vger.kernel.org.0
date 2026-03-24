Return-Path: <linux-rdma+bounces-18579-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE9VE2SPwmn/ewQAu9opvQ
	(envelope-from <linux-rdma+bounces-18579-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:19:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E830932C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 14:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC53316C394
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679A3F7E72;
	Tue, 24 Mar 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bVuM8NHo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1C3F7ABE
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357557; cv=none; b=gv7vP5GR9AhmlgZfAq5pRp5tXo/Eoo/1ZoPrsa1tg7IgPwsKbZCheXgGur9xuFViBEsxQlHBoVqI9QJDoXDWZxPWUQcYMfskbmjAKd/5s7WQuysDfsVB8I7TMwLzS/dMG4mrdJhb1L6KP/1O9smZwe+UPOjTSHUNpYpYaMfzF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357557; c=relaxed/simple;
	bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgbGkWE+vd9buTlBB167VswRr0JtSkFXbe0QmLkAhEEZ/HADSaJBFti5CZAUPPX6wwUtlBi2QHHP6MwknNV+KnAIohrESDKux6QAgnq4qtD5frVcSl1a53XcjU/ZxETjQmCDL979klsLQNR9qd7zCZodb8aFKFYwRp3uX/2uR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bVuM8NHo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b48ac2727so943715f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357555; x=1774962355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
        b=bVuM8NHoZV50ZFj9OagRUGXJyS3nVAzC6XcpeTbnAFals5IF/fB70YMGhn4GnfnS7d
         1WeL2D0NskAabQ/EKXp8kHU9Ic1H2QASEdVcN3aU/w8SfEylfztJLnWs1WRjFGTyBHC/
         3LO+Aqqh65k/Jq7xqGmHzdZXWm8BsP5z8MrgCB72Ie92T+fZ8re8xFEPHxz1Y7twTxoA
         HUybpoztHaIP50ikrUpcXd128Wi2MOwoNibcUYvaNaGPBe02qvCicW12NDhksSNxH1ud
         mqPIX0YwEtEI4QwX+Y7L9jGjcx84zNpWM2rfvc/pz3KMEfGwV1bDDrrv26WsnR/vxxEi
         dS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357555; x=1774962355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
        b=oB07+6TgOraHb/ovIAxWloZeE61gHLOKdzzXDoOSEzPNgUMPCR7jOALGsRrSQjDY/7
         jS2YpLkmHutyKlnIobKdimL19mUkJovv1YEEVeZV06/HQ3nu/DEG47ySVaZvVkA/VL1c
         uhTw4qK2Zc4KFMGx9O3gBilbEewqkwyFxxzrOJIvjh3QzAfsrhOVntxFr5VIFKgQEDXg
         XgfOI/+JPmiLWLqqXVfnRD9Vq+KmZcItRUAAylK13L/eBCJ2z3aSIufR0h0+meLZkFJ+
         +qXjb8YpOJ8E9AqumM9hPlfq8QEswRqjJPh1Qpx/SskVjo37RGybZFj/5MSVQJMSN6cs
         0LEA==
X-Forwarded-Encrypted: i=1; AJvYcCWuo7l92C1Dop8wduoH9VQfou0rlqk28LzhzLZnfJB1s2RHfMETIyS69czJanjTDhh9xeUjIfxP8slO@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEUgybagdDGEH9cfcSOFybZ3Bt0vKrCU3t9VkQaAEYHShDJ4+
	jnZu+mM/tjYSDRaUE2k9nUFx0UAvfuiqly7td7b6pqUQrMrr1im1jSYMrD2jQ9nZSXg=
X-Gm-Gg: ATEYQzxVJUm6OWsM0n49mTeGheeKlRTEYd/sjyxLC07c2WoU9080UWzRCOyos4vTHKj
	CuutSvFnO8vreaQGZGhQBBmMKlueipLYiX87HpzwpnpxDKxmMwAk63MHkkXbE0MNgYSAr4K36TA
	5Lcc+4S0z7+BUJ9QDkueuE3Or8MwV49WGgflxyCbXUUUJxAowjwHelzkDYQOdRVEcCgaVEE1eId
	Ck8eEtl/1qcTxItdxyfyNFzdu+GV40LcVqWdk2a6qspZ+6GMql1HcOfZAFMnD1HCE+Pyj1dMZup
	Zazl0Jd0XBVgaEp9BgIPyDlQZ4gtN/AMl6jyZBReSlEV70W5ZHg2uCgTfjODz7f1rbrC1KCK6Tf
	MNe2B4PtEuRLTzOQq1pi6fzxjzS/MElaPsLcD3pZf60izEOqAzGZoCbWLxCgAgfwt0cclghJ/Fl
	0Dcd5jLjCjM1YjukGn38KpyQlnZFFnh4HO9emclrXcl8yaEA==
X-Received: by 2002:a05:6000:26d2:b0:43b:3d4f:e18d with SMTP id ffacd0b85a97d-43b64287044mr25237105f8f.39.1774357554406;
        Tue, 24 Mar 2026 06:05:54 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470f902sm39989765f8f.28.2026.03.24.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:05:54 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:05:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Shay Drory <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, 
	Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	David Wei <dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V8 01/14] devlink: Update nested instance
 locking comment
Message-ID: <owfpttw4n7ft5gisy4gvmd7z22hcafjlcr5i3e4t22j4w3rgz5@drxvpqqmiuen>
References: <20260324122848.36731-1-tariqt@nvidia.com>
 <20260324122848.36731-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324122848.36731-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18579-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: AD8E830932C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Mar 24, 2026 at 01:28:35PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>In commit [1] a comment about nested instance locking was updated. But
>there's another place where this is mentioned, so update that as well.
>
>[1] commit 0061b5199d7c ("devlink: Reverse locking order for nested
>instances")
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

