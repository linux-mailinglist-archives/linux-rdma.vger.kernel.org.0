Return-Path: <linux-rdma+bounces-10166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BFAAFCF6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698B03B2667
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4B27055C;
	Thu,  8 May 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LMKm36rH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0C26D4EE
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714398; cv=none; b=Cyo+EcEr66Ej7sDAoPR872b6OATcu6s7IkQNqkXv3qvSNx8iEabNHJ6w4/gVIF4gpiQLZAMSASeKeCT2frIdl+ILVA8t22NN/DLWq4XNuQM9QRKtXmU5qFXi/GJz9yYeQyUcxbCSIJyo7Y6b0PED+XSKWf3EWfHymhUZNLx67sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714398; c=relaxed/simple;
	bh=5/3rS6QNCGc9/8VtN5vG09IX6zYgH6KCHanADqI/UsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFtkcscjOJL2aPHAV1GR7XD+HwZDMo3MsMxBLwdLOkjRa49Kg8Ua0lfKANdTF4pJBcHjRGUcXv5TFmihNINkqyQPaE1SsyyNcwfpV4YtbvHDFyRdVVyX3LPUkt/NKO6IbgRDyExg+C0G4gS2VOL7X80iAc4thierXe8eJ2rKHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LMKm36rH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so3224555a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 08 May 2025 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746714393; x=1747319193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIhWIUreSP+JGYnJn14K35TWWNfJWxsj/24+cQ+PUMY=;
        b=LMKm36rHdxhF9w76Cj9h/ctDQJRj7i+gRhHyjPZj1g2huarHUBQ1ighOVhOlFBMV32
         qqwT0crgjYxx5dPcOwY7nXdFAzLVktBi4xQA18IHSxb4XMxAqrZ0XyoxSWi2LbuYJuCn
         DWHO3hXZKMAQp+U4DDsqzmBxVM5guVHK/ohTwTQJywoLqICt9LkQD7nxAj0GqH8GzNWj
         OTnRmWOfejY7uvQIjtfcOUZTVrSfkpTFWvstbsbYZOihnL442RhLYqn3iJOLBjavO0yn
         xPajwMLY6LkYTPv4qaioiF9wIzfRsGi/nvLTu5Ga9JHDcmDAvXc9AhIjZuQlehohanaQ
         wHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714393; x=1747319193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIhWIUreSP+JGYnJn14K35TWWNfJWxsj/24+cQ+PUMY=;
        b=Yu5QTIUqQ3EPW9fgtZwRZapKzi8Hp5PGZ0phNrJhfrmPs1Z0y2/T1kpgNme1QmbHu/
         wB14+MVNnXVZM5PbH0qND1tnchnouEzkx7sdwlbKVZu8dqTygytBJXm8EDBfmXLOdTRQ
         KV3h9TJBe2igugy3vroATUS6VhyjL/5u444EbpVPoq7/2ZLKME+c7ogKPJzt3J+14Cai
         o3JftP5rLJiJT0OZNooMW6edUflcgGXXdJm9cQbhRh4j0fuq2mdY0kF19009ah6MV3Gv
         LzDkeqRjEf4/PUWSTfFE7/H0KvzdDmacD+nxNhT8yiIIo/Qm3GNSiXJy116dkw8HnZOU
         9rIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNWRD271JbJazsOfiyx9pMtO7J1aw9CvYkRUcGfhloRN6T3lZV2UIQxnsL9w13/ZWnsSQXoZfKyOAT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cehmLNSzk/QLnFL8cfPBEQPOYMQ9RCNauoXaeJCnGMCJi0YX
	JrD4uSyt7+n4iWEFqJ7DY2fxqhIgHL+skFwE+R+NmJG6HknFCT1vfKYEKmpmbQc=
X-Gm-Gg: ASbGncu46SEPGbo+5o4A+wYOgXT1nlbC1Y+t1KSH4xlkDAGqysWIG0RspTnc7gKWxBJ
	QMcR/ahwaL63umvrfa9USSlxb+3+5ejaqHHgzMSzDLN9oOO4n0N8ge3j4+npBEO0v04heqLkv++
	7uWAWJHJs+a+ACtQ2ijwGHhFGuEt/VNQo65fgIANaZygpksULFA+9AKrOFxwIKPOlwCUHNcZYZS
	C+05vV/IkWdeSUcorcyVW5A90I9s+88Fy/in/bmvzKgi4WSZrx0k05iA9FMwvS6E4MLPhxeNlgH
	UgZGkpDOeOElcRDwd8l0/eTaqITeAKvy7eWmu7sYmdGqNzN8YJto3Qen0H97l9lUQTwGiiuy
X-Google-Smtp-Source: AGHT+IHFGqucmKGTyA5vmk4L71NpkM8eVm1tDoKjhCFYtm5+iTJpiXuabD74HhfORH+kTWKCVII7IQ==
X-Received: by 2002:a17:907:a4c3:b0:acb:aa43:e82d with SMTP id a640c23a62f3a-ad1fcb581e8mr443211366b.3.1746714392815;
        Thu, 08 May 2025 07:26:32 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a2d87sm1088547966b.45.2025.05.08.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:26:32 -0700 (PDT)
Date: Thu, 8 May 2025 16:26:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, jonathan.lemon@gmail.com, 
	richardcochran@gmail.com, aleksandr.loktionov@intel.com, milena.olech@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dpll: add phase-offset-monitor feature
 to netlink spec
Message-ID: <timzeiuivkgvdzmyafp752acgfkieuqhivcab55x24ow7apovp@4lsq6esrrusg>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508122128.1216231-2-arkadiusz.kubalewski@intel.com>

Thu, May 08, 2025 at 02:21:26PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Add enum dpll_feature_state for control over features.
>
>Add dpll device level attribute:
>DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
>feature. Attribute is present and shall return current state of a feature
>(enum dpll_feature_state), if the device driver provides such capability,
>otherwie attribute shall not be present.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v3:
>- replace feature flags and capabilities with per feature attribute
>  approach,
>- add dpll documentation for phase-offset-monitor feature.
>---
> Documentation/driver-api/dpll.rst     | 16 ++++++++++++++++
> Documentation/netlink/specs/dpll.yaml | 24 ++++++++++++++++++++++++
> drivers/dpll/dpll_nl.c                |  5 +++--
> include/uapi/linux/dpll.h             | 12 ++++++++++++
> 4 files changed, 55 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>index e6855cd37e85..04efb425b411 100644
>--- a/Documentation/driver-api/dpll.rst
>+++ b/Documentation/driver-api/dpll.rst
>@@ -214,6 +214,22 @@ offset values are fractional with 3-digit decimal places and shell be
> divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
> modulo divided to get fractional part.
> 
>+Phase offset monitor
>+====================
>+
>+Phase offset measurement is typically performed against the current active
>+source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
>+the capability to monitor phase offsets across all available inputs.
>+The attribute and current feature state shall be included in the response
>+message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
>+In such cases, users can also control the feature using the
>+``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
>+values for the attribute.
>+
>+  =============================== ========================
>+  ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
>+  =============================== ========================
>+
> Embedded SYNC
> =============
> 
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>index 8feefeae5376..e9774678b3f3 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -240,6 +240,20 @@ definitions:
>       integer part of a measured phase offset value.
>       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
>       fractional part of a measured phase offset value.
>+  -
>+    type: enum
>+    name: feature-state
>+    doc: |
>+      Allow control (enable/disable) and status checking over features.
>+    entries:
>+      -
>+        name: disable
>+        doc: |
>+          feature shall be disabled
>+      -
>+        name: enable
>+        doc: |
>+          feature shall be enabled

Is it necessary to introduce an enum for simple bool?
I mean, we used to handle this by U8 attr with 0/1 value. Idk what's the
usual way carry boolean values to do this these days, but enum looks
like overkill.


> 
> attribute-sets:
>   -
>@@ -293,6 +307,14 @@ attribute-sets:
>           be put to message multiple times to indicate possible parallel
>           quality levels (e.g. one specified by ITU option 1 and another
>           one specified by option 2).
>+      -
>+        name: phase-offset-monitor
>+        type: u32
>+        enum: feature-state
>+        doc: Receive or request state of phase offset monitor feature.
>+          If enabled, dpll device shall monitor and notify all currently
>+          available inputs for changes of their phase offset against the
>+          dpll device.
>   -
>     name: pin
>     enum-name: dpll_a_pin
>@@ -483,6 +505,7 @@ operations:
>             - temp
>             - clock-id
>             - type
>+            - phase-offset-monitor
> 
>       dump:
>         reply: *dev-attrs
>@@ -499,6 +522,7 @@ operations:
>         request:
>           attributes:
>             - id
>+            - phase-offset-monitor
>     -
>       name: device-create-ntf
>       doc: Notification about device appearing
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>index fe9b6893d261..8de90310c3be 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -37,8 +37,9 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
> };
> 
> /* DPLL_CMD_DEVICE_SET - do */
>-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_ID + 1] = {
>+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_MONITOR + 1] = {
> 	[DPLL_A_ID] = { .type = NLA_U32, },
>+	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
> };
> 
> /* DPLL_CMD_PIN_ID_GET - do */
>@@ -105,7 +106,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
> 		.doit		= dpll_nl_device_set_doit,
> 		.post_doit	= dpll_post_doit,
> 		.policy		= dpll_device_set_nl_policy,
>-		.maxattr	= DPLL_A_ID,
>+		.maxattr	= DPLL_A_PHASE_OFFSET_MONITOR,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> 	{
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index bf97d4b6d51f..349e1b3ca1ae 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -192,6 +192,17 @@ enum dpll_pin_capabilities {
> 
> #define DPLL_PHASE_OFFSET_DIVIDER	1000
> 
>+/**
>+ * enum dpll_feature_state - Allow control (enable/disable) and status checking
>+ *   over features.
>+ * @DPLL_FEATURE_STATE_DISABLE: feature shall be disabled
>+ * @DPLL_FEATURE_STATE_ENABLE: feature shall be enabled
>+ */
>+enum dpll_feature_state {
>+	DPLL_FEATURE_STATE_DISABLE,
>+	DPLL_FEATURE_STATE_ENABLE,
>+};
>+
> enum dpll_a {
> 	DPLL_A_ID = 1,
> 	DPLL_A_MODULE_NAME,
>@@ -204,6 +215,7 @@ enum dpll_a {
> 	DPLL_A_TYPE,
> 	DPLL_A_LOCK_STATUS_ERROR,
> 	DPLL_A_CLOCK_QUALITY_LEVEL,
>+	DPLL_A_PHASE_OFFSET_MONITOR,
> 
> 	__DPLL_A_MAX,
> 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
>-- 
>2.38.1
>

