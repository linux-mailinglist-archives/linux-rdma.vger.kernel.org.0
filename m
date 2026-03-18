Return-Path: <linux-rdma+bounces-18355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFTKBVjVummfcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:39:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03D2BF6E2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027A13099680
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9D3EF0DE;
	Wed, 18 Mar 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoSz+IWV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E822DECDF
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850596; cv=none; b=Lr4rF5Mo2NubWlLKlAHARti3HnBdWC9s9Qi9Vtilux3fHPWms6FsTHnzehPeK1b7ONGHGDjBgSSFQxpzajpo8LGTxyqHVvTurCPYOfYnSKzUGGkVWhXyMdxq6ZJRmlKJK9bWeIgE46MvbBGjUz+mmQeElyYLnuvjM0Ae/8ekAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850596; c=relaxed/simple;
	bh=cVJluK3TyDFVcOJa07LmzKrKJzuXgnk0YMFEuT5VkI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4JQRN8ODiWZ+nFo8E6dGllTU3sPRjHWqt6OoPaCos9i+YxKact4HxBmMsl+z9jqGM5XT13/s0vr2WdKPjqp2ivRlNLEAFrLnLDvJUVa8befKXys349kxPQ9ajRK2YgeGrRC6ja6VwlYUMQbCP+RjV6rsf22EV1a7DdsECsmg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoSz+IWV; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso101772eec.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850587; x=1774455387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dla1BTbyc4l54nWX3/vfHTdXPEelTK/vnnV7aOlfzTg=;
        b=AoSz+IWVLDGje93UL+/laOx3Mm0bxjDxLZJaDpknBN4X8GKG9GRLRfG7DxLwpZjh+5
         dJV1k8J7EkT4oSMBi2qaQTnxP8BhAtdYbcLnuf75ASSnQ8dmIc+Lyh8cElL5B02r13Po
         LOZ4JY7M6r+bLWm7dHU0ExjewkvCEXrXAWzJdHMiQvti0m7mOkrONr/hn/m1pmpQGSrk
         GTydgAkOkKDELZQ2TztMxAnRJnEvqdes/NdSkDwOHACBTXTCEM3QIYyy/JKWlQlwyucA
         ycNIKH81TaqjKFEiaSmD1KzL+/zx1SaBO2bYv7IwkRw5Vh1CvAKBaM9VhN/1+xtGkYs2
         FuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850587; x=1774455387;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dla1BTbyc4l54nWX3/vfHTdXPEelTK/vnnV7aOlfzTg=;
        b=lbAmFBRQm5pZsFJ/DB9qdfRfV7Yhi7Nje5oDoWg3tztDyzuUewjoGyGFblPlnXGA+s
         jawORf8U9rKo6Nm6P6qDPfTujaQ4Ftv5U+uqnc8ETyd75hYnSyrx5R7wHb5hP2Dt0mhQ
         6raiVL22Mbgw39ttH87kC5DxKAqa7TZ7IGR+CYAb/FrImfRwHyyjLBw6kAgnXD62CzyW
         ShrDRaA5+6IYLUzO87FedrdC7frl0OWDcfIL4mwYyYc9HTAAJihEC6RCuJ0chHR80g/Z
         NHcmNMPfNlgfF6JSpscHr0raaldLhTQFNDO9K/zcRCynZ67HgZAIb7o9vWH0+gnn0D8+
         jlFw==
X-Forwarded-Encrypted: i=1; AJvYcCV82ZAaCFmnCBo7UbTUvS6fZB6B6+kH/EO0MXtiHPmrDDSzVibrGJocJyoBvj+E9u4U+F95J/eSxzPH@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkeyiigsYTy2ElaL6BsF4ls9QTeybBN4HUI98w3V0D8e3HT/G
	/AKvaaLG9VHTNsmP/RybqRv+eRWz/2/ghF/0sdR5RB6AwqsnC21M6iM=
X-Gm-Gg: ATEYQzyuu6y32Tpyc07E3OclyybdAP9SiMdNqMjf8XtOhgsjzuWo8b+gcqgsZzqn79x
	QOg/f8ITZU9qL+tnMgVOHfOrySGDcyuYeUeIMegK17CiLhOfoYbEgYNl/TudIzNT/DkmeMCErmK
	YJEudE6hGWS61mJJbRX/XZHT9yWpdaqcRbI7Tn4Z6aGMsEPcwsL+ywdncLap6hwVrmIlnl3RSSG
	rJ13D6vs72tlTnvWLrbGHZda0ZvZYfsvO6VlrGRfIjxh4uSlEP58pxAgh4Xebghg790SAtF73nv
	zbwJtcyjR3HYXV0AWLWBsmLRB7y+Z+VwuLAFA4MLU/jQyO5YmPzOcsfEh7yndeQS6GNueMIAQLk
	Os6zqhyovVRCdEEjFnx6lFsDwgPsfgwOIMSHbv4m6vFg3zxv6F0ffKzIMK53R/tTXI2MSCrKJHi
	hyJkXduLJv+W2Yujf2VXsLl54UQwPmvY2ZBA78YXNk7qGkRYMt2KbJ/luyt1ISVLXD7F0rMb7cz
	G3eJ86U+qH9513mzQ==
X-Received: by 2002:a05:7022:6a5:b0:128:d471:8c1 with SMTP id a92af1059eb24-1299ba3e555mr1770451c88.17.1773850586365;
        Wed, 18 Mar 2026 09:16:26 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41289e7sm3582603c88.10.2026.03.18.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:16:25 -0700 (PDT)
Date: Wed, 18 Mar 2026 09:16:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net-next v2 02/13] wifi: cfg80211: use __rtnl_unlock in
 nl80211_pre_doit
Message-ID: <abrP2NavLA4f5iHE@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org, leon@kernel.org
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318150305.123900-3-sdf@fomichev.me>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18355-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.832];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 8C03D2BF6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/18, Stanislav Fomichev wrote:
> nl80211_pre_doit acquires rtnl_lock and then wiphy_lock, releasing
> rtnl while keeping wiphy_lock held until post_doit. With the
> introduction of rx_mode_wq and its flush in netdev_run_todo, calling
> rtnl_unlock here creates a circular lock dependency:
> 
>   Chain exists of:
>     (wq_completion)rx_mode_wq --> rtnl_mutex --> &rdev->wiphy.mtx
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&rdev->wiphy.mtx);
>                                  lock(rtnl_mutex);
>                                  lock(&rdev->wiphy.mtx);
>     lock((wq_completion)rx_mode_wq);
> 
> Switch to __rtnl_unlock to skip netdev_run_todo in nl80211_pre_doit.
> This seems safe because we run before the op.
> 
> Link: http://lore.kernel.org/netdev/69b5ad67.a00a0220.3b25d1.001a.GAE@google.com
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/wireless/nl80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 2225f5d0b124..ce5f25d4c87e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -18192,7 +18192,7 @@ static int nl80211_pre_doit(const struct genl_split_ops *ops,
>  		__release(&rdev->wiphy.mtx);
>  	}
>  	if (!(internal_flags & NL80211_FLAG_NEED_RTNL))
> -		rtnl_unlock();
> +		__rtnl_unlock();
>  
>  	return 0;
>  out_unlock:
> -- 
> 2.53.0
> 

ERROR: modpost: "__rtnl_unlock" [net/wireless/cfg80211.ko] undefined!

Gonna re-run local nipa ingest locally to see if anything else pops up.

---
pw-bot: cr

