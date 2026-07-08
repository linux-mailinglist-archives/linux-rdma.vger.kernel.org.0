Return-Path: <linux-rdma+bounces-22873-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4ykAh8STmomCgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22873-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:02:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3837236B3
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:02:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=oya2JJ9x;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22873-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22873-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDA0300BCAB
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60E405C42;
	Wed,  8 Jul 2026 08:59:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704A404BF7
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 08:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501185; cv=none; b=Efntw6/obCAs+DQ5n20lScIEZ6hoKlACzHghAnZA2+uUHbUOhv6AVRTZByl7INNLOYm+pTCklhXt5s8d3lBPR+lpQ3jRGr1NiJNLahfij0kn4JciMwg4fWBpYVDI65KsZppBt6IRvaiheiTQXrr9Nn4i5udOEWbx4y0N+TL2fhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501185; c=relaxed/simple;
	bh=Hxj1jqc916O0uzfL9e7xmGijfaiq/P1jtACMCIsM/kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgQm0aSphCalBLURKogYyfuqH/gfEMHc/RDtpEmPMF8EaEAedA5+ligIua+N/vgBBDLoxmMjdpI5Hc/jmZRDmnZQlUO7WYwVSUGjC0ZtPWJgP1eWP4GUZhWVOnEQwS5j5dyzwm7M+ZaaTesS6WGkHSME+lx32CNJE6ZTgUWKR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=oya2JJ9x; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso2323645e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2026 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783501182; x=1784105982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5D6baHSlULcTUcRv1byvFK7PiJs9aEAD/KVj4sL3W1Q=;
        b=oya2JJ9xNdc8CX9J7lFjIn2TFMrsc3OSU3PR6M5a1YgmeDlP6vfJE5NuEL3/JUQbIm
         zc7ppyFr52LPd+LLm2kP4L6iL05c4TREy2Ckys7DlMnr6P61586d5r51ATQ6XkkYCRYE
         AlopDYO6RnzmMhXA9+uoT6eIsS9rK/mDcztpMBWtSCIuJZ8y+d0HZbzWag6Jk87KYvCv
         j/BpXdGbjhJmtnhAJwNilvy/cNRRwLtUHQ4uEDWAgMJyJ7MpQNZWQqFHNVpc6a/Eiy78
         jJ+aN6DpAN78jdzvVYXVQ3bDOL50jqgvQdZm/xz1D2xWd2YQC3T0Hz1btQQiUdcmeroE
         IX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501182; x=1784105982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5D6baHSlULcTUcRv1byvFK7PiJs9aEAD/KVj4sL3W1Q=;
        b=PIOlomgxZuPtEH/KbpXMepteLUHGwn9SWMQ+JzDj1sR/6Ak0YqGLaWAs+t3tPET5b/
         FGo/0FXAriV/V6edbPqWaQ2mLDgYUHAOe+bAFtnSnAROVYI2iBhzZwgtWMaab0OzBolW
         FX6UQAyf3CDfo2/AGVSwd23wR9FhFTzU6F4mfzGfv/P1OwlX8/Il5nSSxcCvohjEgqfe
         OIVnUBS6YDAAFC8KWaifpwRgGKGg06jeSVDe/C5WHP2K3Ppqg1zj6dYNwqQhOHag8aOT
         U27bww/aiXsutELy9tqsheh0o6y4BChYEcuR5do+BadjKhjEJMT3Wix/CaakzJ121trf
         u+wg==
X-Forwarded-Encrypted: i=1; AHgh+RoNNClydQIcK6xXsMZ7gbNhcBQ8fBBg84j7ZvZ0LYjAZ1aFulpgqdtI0oqVJPWB3RVuXhwTmrc5RxUS@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZFLQXZ1Z6tWTaolIJ+QgN8cz6RR7zd5lakNLECJKITG199Ef
	qstXK+p9vvipW/tcKdHl+LFQY8OS+ZS4sdRCq6qXLQPZ/uGKlSXClwlga0p/ALXzUXA=
X-Gm-Gg: AfdE7cn5b/lYcdIn0OwFNTPUm6p+dpoy7340Rr0cHFdN0jV1BJN3Q8VbRGyGfOViZn5
	gdzgRPd0mgTxX7Og07Fz9L1u/FgBMRXujhu/yppzUp1F6D90Cnfq/Xrbk8QMd4QNlcWXcl6jnch
	qCmsEosvWCsJpjhcMA0PtczxZ/4TNSN0DqvvGFb+nnA0w1MyW08zIWlOqWO3ewLOETRCpKFwcPs
	/J9m/QFILscpktWxAk/KU+ifWVQx5vCaHMBQIlQaTszlGkMiXjMHr5MaXM+hEyhQeKxfcNr+f+L
	geucPcF9NsvlyankGXMmwWEvoDYQioLKSxbsBUbWi0gn4NfZtEfdxi/0p2D007DvTvdgysuQ8aY
	zWDilayKs96hRufi7sLcj10KIEomwTFH9nlmuV8LsD6XRRsKRiMXaRY3lBeXi/LCB32FVjQKV4r
	KtiCG0a5tUrznIv/zx47sC
X-Received: by 2002:a05:600c:34c3:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493e79edba5mr10649235e9.33.1783501181720;
        Wed, 08 Jul 2026 01:59:41 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3676dsm129473725e9.5.2026.07.08.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:59:41 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:59:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V5 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <ak4Muihtk40r3lfV@FV6GYCPJ69>
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-5-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707174527.425134-5-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22873-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[FV6GYCPJ69:mid,resnulli.us:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA3837236B3

Tue, Jul 07, 2026 at 07:45:25PM +0200, mbloch@nvidia.com wrote:
>Apply parsed devlink_eswitch_mode= defaults after devlink registration
>and after successful reload.
>
>devl_register() may still be called before the device is ready for an
>eswitch mode change. Keep the registration path passive and let the
>regular devl_unlock() path queue the async apply work once the instance
>is registered and the default is still pending.
>
>The queueing path runs while the devlink instance lock is held, so the
>queued work gets its devlink reference before the caller drops the lock.
>The worker then takes the devlink instance lock normally and applies the
>default only if the instance is still registered and the default is still
>pending.

This is very code-descriptive. What's the benefit of that?


>
>For successful reloads that performed DRIVER_REINIT, devlink_reload()
>already holds the devlink instance lock and the driver has completed
>reload_up(). Clear pending work and apply the default directly from the
>reload path instead of queueing work.
>
>Preserve the user configured mode when it is set before devlink applies
>the default.
>

[..]


>+void devlink_default_esw_mode_apply_locked(struct devlink *devlink)
>+{
>+	const struct devlink_ops *ops = devlink->ops;
>+	int err;
>+
>+	devl_assert_locked(devlink);
>+
>+	if (!devlink_default_esw_mode_match(devlink))
>+		return;
>+
>+	if (!ops->eswitch_mode_set) {
>+		if (!devlink_default_esw_mode_match_all)
>+			devl_warn(devlink,
>+				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
>+		return;
>+	}
>+
>+	err = devlink_eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
>+	if (err)
>+		devl_warn(devlink,
>+			  "Couldn't apply default eswitch mode, err %d\n",
>+			  err);
>+}
>+
>+void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink)

eswitch/esw - we call it "eswitch" consistently everywhere. Why "esw"
here?



>+{
>+	devl_assert_locked(devlink);
>+
>+	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
>+		return;
>+	if (!devlink->default_esw_mode_apply_pending ||
>+	    !__devl_is_registered(devlink))
>+		return;
>+	if (!devlink_try_get(devlink))
>+		return;
>+	if (!queue_work(devlink_default_esw_mode_wq,
>+			&devlink->default_esw_mode_apply_work))
>+		devlink_put(devlink);
>+}
>+
>+static void devlink_default_esw_mode_apply_work(struct work_struct *work)
>+{
>+	struct devlink *devlink;
>+
>+	devlink = container_of(work, struct devlink,
>+			       default_esw_mode_apply_work);
>+

What happens if userspace eswitch mode set happens now? Any userspace
attempt should cancel the default apply. I don't see such mechanism in
your patches, did I miss it?



>+	devl_lock(devlink);
>+
>+	if (devl_is_registered(devlink) &&
>+	    devlink->default_esw_mode_apply_pending) {
>+		devlink_default_esw_mode_apply_locked(devlink);
>+		devlink->default_esw_mode_apply_pending = false;
>+	}
>+
>+	devl_unlock(devlink);
>+	devlink_put(devlink);
>+}
>+
>+void devlink_default_esw_mode_instance_init(struct devlink *devlink)

Why "_instance_"? Care to drop?


>+{
>+	INIT_WORK(&devlink->default_esw_mode_apply_work,
>+		  devlink_default_esw_mode_apply_work);
>+	devlink->default_esw_mode_apply_pending = true;
>+}
>+
>+void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
>+{
>+	devl_assert_locked(devlink);
>+
>+	devlink->default_esw_mode_apply_pending = false;
>+}
>+
>+void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)

Why "_instance_"? Care to drop?


>+{
>+	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
>+		devlink_put(devlink);
>+}
>+
> static int __init devlink_default_esw_mode_setup(char *str)
> {
> 	devlink_default_esw_mode_param = str;
>@@ -228,10 +325,21 @@ int __init devlink_default_esw_mode_init(void)
> 		return err;
> 	}
> 
>+	devlink_default_esw_mode_wq = alloc_workqueue("devlink_default_esw_mode",
>+						      WQ_UNBOUND | WQ_MEM_RECLAIM,
>+						      0);
>+	if (!devlink_default_esw_mode_wq) {
>+		devlink_default_esw_mode_param = NULL;
>+		devlink_default_esw_mode_nodes_clear();
>+		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate workqueue\n");

Why you don't "return"  here? I think that we don't need to allow the
case wq is not allocated.


>+	}
>+
> 	return 0;
> }
> 
> void __init devlink_default_esw_mode_cleanup(void)
> {
>+	if (devlink_default_esw_mode_wq)
>+		destroy_workqueue(devlink_default_esw_mode_wq);
> 	devlink_default_esw_mode_nodes_clear();
> }

[..]

